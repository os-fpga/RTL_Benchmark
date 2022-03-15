-- Xilinx Vhdl netlist produced by netgen application (version G.26)
-- Command       : -intstyle ise -s 7 -pcf cpu8bit.pcf -ngm cpu8bit.ngm -rpw 100 -tpw 0 -ar Structure -xon true -w -ofmt vhdl -sim cpu8bit.ncd cpu8bit_timesim.vhd 
-- Input file    : cpu8bit.ncd
-- Output file   : cpu8bit_timesim.vhd
-- Design name   : cpu8bit
-- # of Entities : 1
-- Xilinx        : C:/Xilinx
-- Device        : 2s50etq144-7 (PRODUCTION 1.17 2003-11-04)

-- This vhdl netlist is a simulation model and uses simulation 
-- primitives which may not represent the true implementation of the 
-- device, however the netlist is functionally correct and should not 
-- be modified. This file cannot be synthesized and should only be used 
-- with supported simulation tools.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library SIMPRIM;
use SIMPRIM.VCOMPONENTS.ALL;
use SIMPRIM.VPACKAGE.ALL;

entity cpu8bit is
  port (
    TXD : out STD_LOGIC; 
    RXD : in STD_LOGIC := 'X'; 
    NRESET : in STD_LOGIC := 'X'; 
    UCLK : in STD_LOGIC := 'X'; 
    OUT0_REG : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    OUT1_REG : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    IN1_REG : in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    IN0_REG : in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    IN_INT : in STD_LOGIC_VECTOR ( 3 downto 0 ) 
  );
end cpu8bit;

architecture Structure of cpu8bit is
  signal IN_INT_0_IBUF : STD_LOGIC; 
  signal IN_INT_1_IBUF : STD_LOGIC; 
  signal IN_INT_2_IBUF : STD_LOGIC; 
  signal IN_INT_3_IBUF : STD_LOGIC; 
  signal UCLK_BUFGP_IBUFG : STD_LOGIC; 
  signal UCLK_BUFGP : STD_LOGIC; 
  signal XLXI_3_n0006 : STD_LOGIC; 
  signal NRESET_BUFGP : STD_LOGIC; 
  signal XLXI_3_n0002 : STD_LOGIC; 
  signal XLXI_26_n0102 : STD_LOGIC; 
  signal RXD_IBUF : STD_LOGIC; 
  signal XLXI_6_n0028 : STD_LOGIC; 
  signal XLXI_6_n0016 : STD_LOGIC; 
  signal IN0_REG_0_IBUF : STD_LOGIC; 
  signal IN0_REG_1_IBUF : STD_LOGIC; 
  signal IN0_REG_2_IBUF : STD_LOGIC; 
  signal IN0_REG_3_IBUF : STD_LOGIC; 
  signal IN0_REG_4_IBUF : STD_LOGIC; 
  signal IN0_REG_5_IBUF : STD_LOGIC; 
  signal IN0_REG_6_IBUF : STD_LOGIC; 
  signal IN0_REG_7_IBUF : STD_LOGIC; 
  signal IN1_REG_0_IBUF : STD_LOGIC; 
  signal IN1_REG_1_IBUF : STD_LOGIC; 
  signal IN1_REG_2_IBUF : STD_LOGIC; 
  signal IN1_REG_3_IBUF : STD_LOGIC; 
  signal IN1_REG_4_IBUF : STD_LOGIC; 
  signal IN1_REG_5_IBUF : STD_LOGIC; 
  signal IN1_REG_6_IBUF : STD_LOGIC; 
  signal IN1_REG_7_IBUF : STD_LOGIC; 
  signal NRESET_BUFGP_IBUFG : STD_LOGIC; 
  signal nWE_RAM : STD_LOGIC; 
  signal GLOBAL_LOGIC0 : STD_LOGIC; 
  signal XLXI_1_I5_Mmux_daddr_out_Result_0_1_1 : STD_LOGIC; 
  signal XLXI_1_I3_n0063 : STD_LOGIC; 
  signal XLXI_1_I2_TC_c_1_1 : STD_LOGIC; 
  signal XLXI_1_I2_TC_c_0_1 : STD_LOGIC; 
  signal XLXI_1_I2_TC_c_2_1 : STD_LOGIC; 
  signal N43992 : STD_LOGIC; 
  signal XLXI_1_I3_N19977 : STD_LOGIC; 
  signal CHOICE2917 : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_1 : STD_LOGIC; 
  signal XLXI_1_I4_n0037 : STD_LOGIC; 
  signal XLXI_1_I3_n0025 : STD_LOGIC; 
  signal N43148 : STD_LOGIC; 
  signal XLXI_1_I4_N21650 : STD_LOGIC; 
  signal CHOICE2905 : STD_LOGIC; 
  signal N43150 : STD_LOGIC; 
  signal N43453 : STD_LOGIC; 
  signal CHOICE824 : STD_LOGIC; 
  signal CHOICE828 : STD_LOGIC; 
  signal XLXI_1_I4_N21661 : STD_LOGIC; 
  signal XLXI_1_I4_n0033 : STD_LOGIC; 
  signal XLXI_1_I4_ireg_we_c : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_0 : STD_LOGIC; 
  signal CHOICE576 : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_lut2_47 : STD_LOGIC; 
  signal CHOICE567 : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_2 : STD_LOGIC; 
  signal CHOICE630 : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_3 : STD_LOGIC; 
  signal CHOICE621 : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_4 : STD_LOGIC; 
  signal CHOICE603 : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_5 : STD_LOGIC; 
  signal CHOICE612 : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_6 : STD_LOGIC; 
  signal CHOICE594 : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_7 : STD_LOGIC; 
  signal CHOICE585 : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_2_1 : STD_LOGIC; 
  signal XLXI_1_I1_n0025 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_0 : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_0_79_1 : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_1_38_1 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_0 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_0 : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_1_38_3 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_1 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_1 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_1 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_2 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_2 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_2 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_3 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_3 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_3 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_4 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_4 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_4 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_5 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_5 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_5 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_6 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_6 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_6 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_7 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_7 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_7 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_8 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_8 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_8 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_9 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_9 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_9 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_0 : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_0_79_4 : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_1_38_2 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_0 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_0 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_1 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_1 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_1 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_2 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_2 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_2 : STD_LOGIC; 
  signal CHOICE2723 : STD_LOGIC; 
  signal XLXI_1_I2_valid_c : STD_LOGIC; 
  signal XLXI_1_I3_n0076 : STD_LOGIC; 
  signal CHOICE2701 : STD_LOGIC; 
  signal XLXI_1_I3_n0023 : STD_LOGIC; 
  signal N43246 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_3 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_3 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_3 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_4 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_4 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_4 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_0 : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_0_79_3 : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_1_38_4 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_5 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_5 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_5 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_1 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_6 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_6 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_6 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_2 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_3 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_7 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_7 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_7 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_8 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_8 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_8 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_4 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_0 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_9 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_9 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_9 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_5 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_1 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_6 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_2 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_7 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_3 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_4 : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_0_79_2 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_8 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_9 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_5 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_6 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_7 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_8 : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_9 : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_8 : STD_LOGIC; 
  signal CHOICE2462 : STD_LOGIC; 
  signal CHOICE2396 : STD_LOGIC; 
  signal CHOICE2426 : STD_LOGIC; 
  signal CHOICE2411 : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_cy_57 : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_cy_59 : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_cy_61 : STD_LOGIC; 
  signal XLXI_6_Madd_n0040_inst_cy_17 : STD_LOGIC; 
  signal GLOBAL_LOGIC1 : STD_LOGIC; 
  signal XLXI_5_Msub_n0016_inst_cy_9 : STD_LOGIC; 
  signal XLXI_5_Msub_n0016_inst_cy_11 : STD_LOGIC; 
  signal XLXI_5_Msub_n0016_inst_cy_13 : STD_LOGIC; 
  signal XLXI_6_Madd_n0041_inst_cy_17 : STD_LOGIC; 
  signal XLXI_1_I3_Msub_n0066_inst_cy_48 : STD_LOGIC; 
  signal XLXI_1_I3_Msub_n0066_inst_lut2_38 : STD_LOGIC; 
  signal XLXI_1_I3_Msub_n0066_inst_lut2_39 : STD_LOGIC; 
  signal XLXI_1_I3_Msub_n0066_inst_cy_50 : STD_LOGIC; 
  signal XLXI_1_I3_Msub_n0066_inst_lut2_40 : STD_LOGIC; 
  signal XLXI_1_I3_Msub_n0066_inst_lut2_41 : STD_LOGIC; 
  signal XLXI_1_I3_Msub_n0066_inst_cy_52 : STD_LOGIC; 
  signal XLXI_1_I3_Msub_n0066_inst_lut2_42 : STD_LOGIC; 
  signal XLXI_1_I3_Msub_n0066_inst_lut2_43 : STD_LOGIC; 
  signal XLXI_1_I3_Msub_n0066_inst_cy_54 : STD_LOGIC; 
  signal XLXI_1_I3_Msub_n0066_inst_lut2_44 : STD_LOGIC; 
  signal XLXI_1_I3_Msub_n0066_inst_lut2_45 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_cy_21 : STD_LOGIC; 
  signal CHOICE1017 : STD_LOGIC; 
  signal CHOICE1024 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_cy_23 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_cy_25 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_cy_27 : STD_LOGIC; 
  signal XLXI_6_n0051 : STD_LOGIC; 
  signal XLXI_6_N15034 : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_cy_40 : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_30 : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_31 : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_cy_42 : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_32 : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_33 : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_cy_44 : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_34 : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_35 : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_36 : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_37 : STD_LOGIC; 
  signal XLXI_26_Madd_n0060_inst_cy_17 : STD_LOGIC; 
  signal XLXI_26_Madd_n0061_inst_cy_17 : STD_LOGIC; 
  signal XLXI_1_I1_Madd_n0024_inst_cy_30 : STD_LOGIC; 
  signal XLXI_1_I1_Madd_n0024_inst_cy_32 : STD_LOGIC; 
  signal XLXI_1_I1_Madd_n0024_inst_cy_34 : STD_LOGIC; 
  signal XLXI_1_I1_Madd_n0024_inst_cy_36 : STD_LOGIC; 
  signal XLXI_5_Madd_n0017_inst_cy_1 : STD_LOGIC; 
  signal XLXI_5_Madd_n0017_inst_cy_3 : STD_LOGIC; 
  signal XLXI_5_Madd_n0017_inst_cy_5 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_cy_21 : STD_LOGIC; 
  signal CHOICE1032 : STD_LOGIC; 
  signal CHOICE1039 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_cy_23 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_cy_25 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_cy_27 : STD_LOGIC; 
  signal XLXI_26_Madd_n0058_inst_cy_17 : STD_LOGIC; 
  signal XLXI_26_Madd_n0059_inst_cy_17 : STD_LOGIC; 
  signal N43788 : STD_LOGIC; 
  signal CHOICE2315 : STD_LOGIC; 
  signal XLXI_1_I1_iaddr_x_6_33_O : STD_LOGIC; 
  signal N43784 : STD_LOGIC; 
  signal CHOICE2298 : STD_LOGIC; 
  signal XLXI_1_I1_iaddr_x_7_33_O : STD_LOGIC; 
  signal XLXI_1_skip : STD_LOGIC; 
  signal XLXI_1_I2_N18996 : STD_LOGIC; 
  signal N43480 : STD_LOGIC; 
  signal N43792 : STD_LOGIC; 
  signal CHOICE2281 : STD_LOGIC; 
  signal XLXI_1_I1_iaddr_x_8_33_O : STD_LOGIC; 
  signal N43800 : STD_LOGIC; 
  signal CHOICE2264 : STD_LOGIC; 
  signal XLXI_1_I1_iaddr_x_9_33_O : STD_LOGIC; 
  signal XLXI_1_I3_skip_i : STD_LOGIC; 
  signal XLXI_1_I3_skip_l62_O : STD_LOGIC; 
  signal N43126 : STD_LOGIC; 
  signal XLXI_1_I3_skip_l86_SW1_SW0_O : STD_LOGIC; 
  signal N43128 : STD_LOGIC; 
  signal XLXI_1_I2_C_raw : STD_LOGIC; 
  signal N43080 : STD_LOGIC; 
  signal XLXI_1_I4_Ker217601_1 : STD_LOGIC; 
  signal XLXI_1_I2_ndre_x1_1 : STD_LOGIC; 
  signal XLXI_1_I4_N21762 : STD_LOGIC; 
  signal XLXI_1_ndre_int : STD_LOGIC; 
  signal XLXI_6_n00601_O : STD_LOGIC; 
  signal XLXI_1_I5_ndwe_c : STD_LOGIC; 
  signal nCS_UART : STD_LOGIC; 
  signal XLXI_6_tx_uart_busy : STD_LOGIC; 
  signal XLXI_6_n0023 : STD_LOGIC; 
  signal XLXI_55_N16508 : STD_LOGIC; 
  signal N29345 : STD_LOGIC; 
  signal CHOICE3059 : STD_LOGIC; 
  signal N43378 : STD_LOGIC; 
  signal XLXI_1_I4_N21894 : STD_LOGIC; 
  signal N29016 : STD_LOGIC; 
  signal N43443 : STD_LOGIC; 
  signal N43499 : STD_LOGIC; 
  signal N43497 : STD_LOGIC; 
  signal N43098 : STD_LOGIC; 
  signal N43350 : STD_LOGIC; 
  signal XLXI_1_I4_daddr_x_3_1_SW1_O : STD_LOGIC; 
  signal N43491 : STD_LOGIC; 
  signal N43102 : STD_LOGIC; 
  signal N43354 : STD_LOGIC; 
  signal N43106 : STD_LOGIC; 
  signal N43238 : STD_LOGIC; 
  signal N28675 : STD_LOGIC; 
  signal N43468 : STD_LOGIC; 
  signal nCS_TIMER : STD_LOGIC; 
  signal XLXI_5_N14481 : STD_LOGIC; 
  signal XLXI_5_tmr_enable : STD_LOGIC; 
  signal CHOICE2866 : STD_LOGIC; 
  signal CHOICE2870 : STD_LOGIC; 
  signal XLXI_1_I3_n0059 : STD_LOGIC; 
  signal N43258 : STD_LOGIC; 
  signal XLXI_1_I3_n0115_6_39_O : STD_LOGIC; 
  signal CHOICE2859 : STD_LOGIC; 
  signal N43256 : STD_LOGIC; 
  signal N43482 : STD_LOGIC; 
  signal N43094 : STD_LOGIC; 
  signal XLXI_1_I4_Ker216591_SW0_O : STD_LOGIC; 
  signal XLXI_5_tmr_reset : STD_LOGIC; 
  signal XLXI_5_n0032 : STD_LOGIC; 
  signal CHOICE764 : STD_LOGIC; 
  signal N29544 : STD_LOGIC; 
  signal CHOICE2984 : STD_LOGIC; 
  signal CHOICE2986 : STD_LOGIC; 
  signal XLXI_1_I2_int_start_c : STD_LOGIC; 
  signal CHOICE2437 : STD_LOGIC; 
  signal CHOICE2438 : STD_LOGIC; 
  signal CHOICE2445 : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_3_1 : STD_LOGIC; 
  signal N43090 : STD_LOGIC; 
  signal XLXI_1_I3_n0115_0_82_O : STD_LOGIC; 
  signal CHOICE2471 : STD_LOGIC; 
  signal N43088 : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_1 : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_0 : STD_LOGIC; 
  signal N29416 : STD_LOGIC; 
  signal CHOICE2907 : STD_LOGIC; 
  signal CHOICE2575 : STD_LOGIC; 
  signal N43338 : STD_LOGIC; 
  signal N43336 : STD_LOGIC; 
  signal XLXI_1_I3_n0115_2_72_SW1_O : STD_LOGIC; 
  signal CHOICE2584 : STD_LOGIC; 
  signal CHOICE2570 : STD_LOGIC; 
  signal N43280 : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_3 : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_2 : STD_LOGIC; 
  signal CHOICE2738 : STD_LOGIC; 
  signal CHOICE2742 : STD_LOGIC; 
  signal N43270 : STD_LOGIC; 
  signal XLXI_1_I3_n0115_4_39_O : STD_LOGIC; 
  signal CHOICE2731 : STD_LOGIC; 
  signal N43268 : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_5 : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_4 : STD_LOGIC; 
  signal N44555 : STD_LOGIC; 
  signal XLXI_1_I3_n0115_8_13_SW1_O : STD_LOGIC; 
  signal CHOICE2729 : STD_LOGIC; 
  signal N43426 : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_8 : STD_LOGIC; 
  signal CHOICE2841 : STD_LOGIC; 
  signal XLXI_3_reg_data_out_x_2_O : STD_LOGIC; 
  signal CHOICE2843 : STD_LOGIC; 
  signal N43110 : STD_LOGIC; 
  signal N29274 : STD_LOGIC; 
  signal CHOICE2777 : STD_LOGIC; 
  signal XLXI_3_reg_data_out_x_3_O : STD_LOGIC; 
  signal CHOICE2779 : STD_LOGIC; 
  signal N43114 : STD_LOGIC; 
  signal N29203 : STD_LOGIC; 
  signal CHOICE2680 : STD_LOGIC; 
  signal XLXI_3_reg_data_out_x_4_O : STD_LOGIC; 
  signal CHOICE2682 : STD_LOGIC; 
  signal N43118 : STD_LOGIC; 
  signal N29124 : STD_LOGIC; 
  signal CHOICE2616 : STD_LOGIC; 
  signal XLXI_3_reg_data_out_x_5_O : STD_LOGIC; 
  signal CHOICE2618 : STD_LOGIC; 
  signal N43122 : STD_LOGIC; 
  signal N29051 : STD_LOGIC; 
  signal CHOICE2552 : STD_LOGIC; 
  signal XLXI_3_reg_data_out_x_6_O : STD_LOGIC; 
  signal CHOICE2554 : STD_LOGIC; 
  signal N43132 : STD_LOGIC; 
  signal N28941 : STD_LOGIC; 
  signal CHOICE2488 : STD_LOGIC; 
  signal XLXI_3_reg_data_out_x_7_O : STD_LOGIC; 
  signal CHOICE2490 : STD_LOGIC; 
  signal CHOICE2359 : STD_LOGIC; 
  signal XLXI_1_I2_N18844 : STD_LOGIC; 
  signal CHOICE2367 : STD_LOGIC; 
  signal CHOICE2381 : STD_LOGIC; 
  signal N43476 : STD_LOGIC; 
  signal XLXI_1_I4_Ker218921_SW0_SW0_O : STD_LOGIC; 
  signal N43808 : STD_LOGIC; 
  signal CHOICE2247 : STD_LOGIC; 
  signal XLXI_1_I1_iaddr_x_3_33_O : STD_LOGIC; 
  signal N43796 : STD_LOGIC; 
  signal CHOICE2349 : STD_LOGIC; 
  signal XLXI_1_I1_iaddr_x_4_33_O : STD_LOGIC; 
  signal N43804 : STD_LOGIC; 
  signal CHOICE2332 : STD_LOGIC; 
  signal XLXI_1_I1_iaddr_x_5_33_O : STD_LOGIC; 
  signal CHOICE3042 : STD_LOGIC; 
  signal CHOICE3026 : STD_LOGIC; 
  signal XLXI_1_I3_skip_l : STD_LOGIC; 
  signal XLXI_1_I2_skip_c : STD_LOGIC; 
  signal N28714 : STD_LOGIC; 
  signal CHOICE3008 : STD_LOGIC; 
  signal XLXI_1_I2_n006236_SW1_O : STD_LOGIC; 
  signal N28827 : STD_LOGIC; 
  signal XLXI_1_I4_n005725_O : STD_LOGIC; 
  signal nCS_INT : STD_LOGIC; 
  signal XLXI_4_N13806 : STD_LOGIC; 
  signal XLXI_5_N14552 : STD_LOGIC; 
  signal CHOICE870 : STD_LOGIC; 
  signal CHOICE877 : STD_LOGIC; 
  signal CHOICE951 : STD_LOGIC; 
  signal XLXI_55_nCS_UART_SW0_O : STD_LOGIC; 
  signal nCS_REG : STD_LOGIC; 
  signal XLXI_55_nCS_REG_SW10_SW1_O : STD_LOGIC; 
  signal CHOICE2850 : STD_LOGIC; 
  signal N43156 : STD_LOGIC; 
  signal CHOICE2853 : STD_LOGIC; 
  signal N43154 : STD_LOGIC; 
  signal CHOICE2920 : STD_LOGIC; 
  signal CHOICE2890 : STD_LOGIC; 
  signal XLXI_1_I3_N20052 : STD_LOGIC; 
  signal XLXI_1_I3_n0058 : STD_LOGIC; 
  signal CHOICE2511 : STD_LOGIC; 
  signal N43186 : STD_LOGIC; 
  signal CHOICE2996 : STD_LOGIC; 
  signal N43142 : STD_LOGIC; 
  signal CHOICE2442 : STD_LOGIC; 
  signal CHOICE2786 : STD_LOGIC; 
  signal N43162 : STD_LOGIC; 
  signal CHOICE2789 : STD_LOGIC; 
  signal N43160 : STD_LOGIC; 
  signal CHOICE2689 : STD_LOGIC; 
  signal N43168 : STD_LOGIC; 
  signal CHOICE2692 : STD_LOGIC; 
  signal N43166 : STD_LOGIC; 
  signal CHOICE2625 : STD_LOGIC; 
  signal N43174 : STD_LOGIC; 
  signal CHOICE2628 : STD_LOGIC; 
  signal N43172 : STD_LOGIC; 
  signal CHOICE2561 : STD_LOGIC; 
  signal N43180 : STD_LOGIC; 
  signal CHOICE2564 : STD_LOGIC; 
  signal N43220 : STD_LOGIC; 
  signal CHOICE2856 : STD_LOGIC; 
  signal CHOICE2826 : STD_LOGIC; 
  signal CHOICE2497 : STD_LOGIC; 
  signal N43228 : STD_LOGIC; 
  signal CHOICE2500 : STD_LOGIC; 
  signal N43232 : STD_LOGIC; 
  signal XLXI_1_I3_N20010 : STD_LOGIC; 
  signal CHOICE2513 : STD_LOGIC; 
  signal XLXI_1_I3_n0115_1_29_O : STD_LOGIC; 
  signal CHOICE2520 : STD_LOGIC; 
  signal N43144 : STD_LOGIC; 
  signal N44559 : STD_LOGIC; 
  signal XLXI_1_I3_Mmux_data_x_Result_0_59_SW0_O : STD_LOGIC; 
  signal N43422 : STD_LOGIC; 
  signal XLXI_1_I3_Mmux_data_x_Result_1_59_SW1_O : STD_LOGIC; 
  signal CHOICE2631 : STD_LOGIC; 
  signal CHOICE2762 : STD_LOGIC; 
  signal CHOICE2639 : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_2_1 : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_1_1 : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_0_1 : STD_LOGIC; 
  signal XLXI_1_I3_n0115_2_19_O : STD_LOGIC; 
  signal CHOICE2581 : STD_LOGIC; 
  signal XLXI_1_I3_n007212_O : STD_LOGIC; 
  signal CHOICE2967 : STD_LOGIC; 
  signal N43138 : STD_LOGIC; 
  signal N43136 : STD_LOGIC; 
  signal CHOICE2695 : STD_LOGIC; 
  signal CHOICE2665 : STD_LOGIC; 
  signal CHOICE2736 : STD_LOGIC; 
  signal CHOICE2601 : STD_LOGIC; 
  signal CHOICE2800 : STD_LOGIC; 
  signal CHOICE2567 : STD_LOGIC; 
  signal CHOICE2537 : STD_LOGIC; 
  signal CHOICE2864 : STD_LOGIC; 
  signal CHOICE2473 : STD_LOGIC; 
  signal CHOICE2928 : STD_LOGIC; 
  signal N43439 : STD_LOGIC; 
  signal XLXI_6_n0007 : STD_LOGIC; 
  signal XLXI_6_n0021 : STD_LOGIC; 
  signal XLXI_1_I4_n0062 : STD_LOGIC; 
  signal XLXI_1_int_stop : STD_LOGIC; 
  signal XLXI_1_I4_iinc_we_c : STD_LOGIC; 
  signal XLXI_1_I4_n00371_1 : STD_LOGIC; 
  signal XLXI_26_n0056 : STD_LOGIC; 
  signal XLXI_26_rx_s_FFd1 : STD_LOGIC; 
  signal XLXI_26_rx_s_FFd3 : STD_LOGIC; 
  signal XLXI_26_rx_s_FFd2 : STD_LOGIC; 
  signal XLXI_26_n0024 : STD_LOGIC; 
  signal XLXI_26_N16174 : STD_LOGIC; 
  signal XLXI_26_N16090 : STD_LOGIC; 
  signal XLXI_1_I1_n0038 : STD_LOGIC; 
  signal XLXI_1_I1_n0039 : STD_LOGIC; 
  signal XLXI_26_n0030 : STD_LOGIC; 
  signal XLXI_1_I2_N18884 : STD_LOGIC; 
  signal N29718 : STD_LOGIC; 
  signal XLXI_26_n0026 : STD_LOGIC; 
  signal XLXI_26_n0033 : STD_LOGIC; 
  signal XLXI_26_rx_uart_full_d : STD_LOGIC; 
  signal XLXI_26_rx_uart_full_s : STD_LOGIC; 
  signal XLXI_26_rx_uart_ovr_s : STD_LOGIC; 
  signal XLXI_5_n0030 : STD_LOGIC; 
  signal XLXI_1_I2_N19016 : STD_LOGIC; 
  signal XLXI_1_I2_int_stop_c : STD_LOGIC; 
  signal XLXI_5_n0015 : STD_LOGIC; 
  signal CHOICE885 : STD_LOGIC; 
  signal CHOICE892 : STD_LOGIC; 
  signal XLXI_5_n0031 : STD_LOGIC; 
  signal XLXI_5_tmr_int_x : STD_LOGIC; 
  signal XLXI_1_I4_N21830 : STD_LOGIC; 
  signal XLXI_26_N16130 : STD_LOGIC; 
  signal XLXI_1_ndwe_int : STD_LOGIC; 
  signal CHOICE2379 : STD_LOGIC; 
  signal N28548 : STD_LOGIC; 
  signal N43370 : STD_LOGIC; 
  signal XLXI_26_N16151 : STD_LOGIC; 
  signal XLXI_26_N16111 : STD_LOGIC; 
  signal XLXI_1_I2_n0105 : STD_LOGIC; 
  signal XLXI_1_I2_int_start_x : STD_LOGIC; 
  signal XLXI_6_n0055 : STD_LOGIC; 
  signal XLXI_6_n0042 : STD_LOGIC; 
  signal XLXI_26_N16097 : STD_LOGIC; 
  signal XLXI_26_N16182 : STD_LOGIC; 
  signal XLXI_1_I1_n0034 : STD_LOGIC; 
  signal XLXI_26_rx_uart_full_c : STD_LOGIC; 
  signal XLXI_26_rx_uart_ovr_d : STD_LOGIC; 
  signal N43921 : STD_LOGIC; 
  signal CHOICE1108 : STD_LOGIC; 
  signal CHOICE1111 : STD_LOGIC; 
  signal XLXI_26_N16104 : STD_LOGIC; 
  signal XLXI_1_I3_n00231_1 : STD_LOGIC; 
  signal N43314 : STD_LOGIC; 
  signal N43312 : STD_LOGIC; 
  signal CHOICE2661 : STD_LOGIC; 
  signal N43406 : STD_LOGIC; 
  signal N43276 : STD_LOGIC; 
  signal N43274 : STD_LOGIC; 
  signal CHOICE2993 : STD_LOGIC; 
  signal CHOICE531 : STD_LOGIC; 
  signal XLXI_26_n0023 : STD_LOGIC; 
  signal N27670 : STD_LOGIC; 
  signal XLXI_26_n0118 : STD_LOGIC; 
  signal XLXI_26_n0116 : STD_LOGIC; 
  signal XLXI_26_n0114 : STD_LOGIC; 
  signal XLXI_26_n0112 : STD_LOGIC; 
  signal XLXI_26_n0110 : STD_LOGIC; 
  signal XLXI_26_n0108 : STD_LOGIC; 
  signal XLXI_26_n0106 : STD_LOGIC; 
  signal XLXI_26_n0104 : STD_LOGIC; 
  signal XLXI_1_I3_n0057 : STD_LOGIC; 
  signal XLXI_1_I3_n0060 : STD_LOGIC; 
  signal XLXI_1_I3_n0061 : STD_LOGIC; 
  signal CHOICE2711 : STD_LOGIC; 
  signal N44524 : STD_LOGIC; 
  signal CHOICE2934 : STD_LOGIC; 
  signal N43386 : STD_LOGIC; 
  signal XLXI_1_I3_n0067 : STD_LOGIC; 
  signal CHOICE2716 : STD_LOGIC; 
  signal CHOICE2758 : STD_LOGIC; 
  signal CHOICE2822 : STD_LOGIC; 
  signal N43318 : STD_LOGIC; 
  signal N43324 : STD_LOGIC; 
  signal N43398 : STD_LOGIC; 
  signal N43320 : STD_LOGIC; 
  signal N43402 : STD_LOGIC; 
  signal XLXI_4_n0005 : STD_LOGIC; 
  signal N27639 : STD_LOGIC; 
  signal N44416 : STD_LOGIC; 
  signal CHOICE2464 : STD_LOGIC; 
  signal XLXI_1_I3_N19927 : STD_LOGIC; 
  signal CHOICE2923 : STD_LOGIC; 
  signal N44536 : STD_LOGIC; 
  signal CHOICE2914 : STD_LOGIC; 
  signal CHOICE2370 : STD_LOGIC; 
  signal N43486 : STD_LOGIC; 
  signal XLXI_26_N16197 : STD_LOGIC; 
  signal N29615 : STD_LOGIC; 
  signal CHOICE2950 : STD_LOGIC; 
  signal CHOICE2886 : STD_LOGIC; 
  signal N43306 : STD_LOGIC; 
  signal N43332 : STD_LOGIC; 
  signal XLXI_5_n0010 : STD_LOGIC; 
  signal CHOICE860 : STD_LOGIC; 
  signal CHOICE853 : STD_LOGIC; 
  signal N43394 : STD_LOGIC; 
  signal CHOICE1007 : STD_LOGIC; 
  signal N43216 : STD_LOGIC; 
  signal N43222 : STD_LOGIC; 
  signal CHOICE906 : STD_LOGIC; 
  signal CHOICE899 : STD_LOGIC; 
  signal CHOICE921 : STD_LOGIC; 
  signal CHOICE914 : STD_LOGIC; 
  signal CHOICE936 : STD_LOGIC; 
  signal CHOICE929 : STD_LOGIC; 
  signal XLXI_26_n0099 : STD_LOGIC; 
  signal CHOICE992 : STD_LOGIC; 
  signal CHOICE944 : STD_LOGIC; 
  signal CHOICE1073 : STD_LOGIC; 
  signal CHOICE977 : STD_LOGIC; 
  signal CHOICE970 : STD_LOGIC; 
  signal CHOICE1061 : STD_LOGIC; 
  signal CHOICE1126 : STD_LOGIC; 
  signal N43326 : STD_LOGIC; 
  signal N43264 : STD_LOGIC; 
  signal N43262 : STD_LOGIC; 
  signal CHOICE985 : STD_LOGIC; 
  signal XLXI_26_n0098 : STD_LOGIC; 
  signal CHOICE1000 : STD_LOGIC; 
  signal N29672 : STD_LOGIC; 
  signal XLXI_6_n0056 : STD_LOGIC; 
  signal CHOICE2606 : STD_LOGIC; 
  signal N43366 : STD_LOGIC; 
  signal N43358 : STD_LOGIC; 
  signal N44520 : STD_LOGIC; 
  signal N43362 : STD_LOGIC; 
  signal N43346 : STD_LOGIC; 
  signal N43374 : STD_LOGIC; 
  signal N43410 : STD_LOGIC; 
  signal XLXI_1_I3_N20122 : STD_LOGIC; 
  signal N43390 : STD_LOGIC; 
  signal XLXI_1_I2_N18949 : STD_LOGIC; 
  signal N44420 : STD_LOGIC; 
  signal XLXI_6_n0061 : STD_LOGIC; 
  signal N43330 : STD_LOGIC; 
  signal XLXI_5_n0003 : STD_LOGIC; 
  signal N43302 : STD_LOGIC; 
  signal N43300 : STD_LOGIC; 
  signal XLXI_1_I3_n0115_1_72_SW1_O : STD_LOGIC; 
  signal CHOICE2506 : STD_LOGIC; 
  signal N43286 : STD_LOGIC; 
  signal CHOICE2641 : STD_LOGIC; 
  signal CHOICE2645 : STD_LOGIC; 
  signal XLXI_1_I3_n0115_3_39_O : STD_LOGIC; 
  signal CHOICE2634 : STD_LOGIC; 
  signal CHOICE2802 : STD_LOGIC; 
  signal CHOICE2806 : STD_LOGIC; 
  signal XLXI_1_I3_n0115_5_39_O : STD_LOGIC; 
  signal CHOICE2795 : STD_LOGIC; 
  signal N28888 : STD_LOGIC; 
  signal N43996 : STD_LOGIC; 
  signal CHOICE1131 : STD_LOGIC; 
  signal CHOICE1137 : STD_LOGIC; 
  signal CHOICE2203 : STD_LOGIC; 
  signal CHOICE2069 : STD_LOGIC; 
  signal N44532 : STD_LOGIC; 
  signal N44528 : STD_LOGIC; 
  signal N44544 : STD_LOGIC; 
  signal N43198 : STD_LOGIC; 
  signal N43244 : STD_LOGIC; 
  signal N30608 : STD_LOGIC; 
  signal CHOICE2971 : STD_LOGIC; 
  signal CHOICE2974 : STD_LOGIC; 
  signal CHOICE2678 : STD_LOGIC; 
  signal CHOICE2828 : STD_LOGIC; 
  signal CHOICE2831 : STD_LOGIC; 
  signal CHOICE2892 : STD_LOGIC; 
  signal CHOICE2895 : STD_LOGIC; 
  signal CHOICE2930 : STD_LOGIC; 
  signal N43252 : STD_LOGIC; 
  signal XLXI_1_I3_n0115_7_39_O : STD_LOGIC; 
  signal N43250 : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_6 : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_7 : STD_LOGIC; 
  signal N31478 : STD_LOGIC; 
  signal CHOICE2603 : STD_LOGIC; 
  signal CHOICE2764 : STD_LOGIC; 
  signal CHOICE2767 : STD_LOGIC; 
  signal CHOICE1070 : STD_LOGIC; 
  signal XLXI_1_I2_N18976 : STD_LOGIC; 
  signal CHOICE2539 : STD_LOGIC; 
  signal CHOICE2542 : STD_LOGIC; 
  signal N43308 : STD_LOGIC; 
  signal CHOICE2475 : STD_LOGIC; 
  signal CHOICE2478 : STD_LOGIC; 
  signal CHOICE2667 : STD_LOGIC; 
  signal CHOICE2670 : STD_LOGIC; 
  signal N43204 : STD_LOGIC; 
  signal N43210 : STD_LOGIC; 
  signal XLXI_1_I3_N19856 : STD_LOGIC; 
  signal XLXI_1_I3_N19837 : STD_LOGIC; 
  signal N43234 : STD_LOGIC; 
  signal CHOICE2375 : STD_LOGIC; 
  signal CHOICE2369 : STD_LOGIC; 
  signal CHOICE1051 : STD_LOGIC; 
  signal N44540 : STD_LOGIC; 
  signal N44516 : STD_LOGIC; 
  signal CHOICE2063 : STD_LOGIC; 
  signal CHOICE2533 : STD_LOGIC; 
  signal CHOICE2149 : STD_LOGIC; 
  signal CHOICE2083 : STD_LOGIC; 
  signal CHOICE2077 : STD_LOGIC; 
  signal CHOICE2189 : STD_LOGIC; 
  signal CHOICE2089 : STD_LOGIC; 
  signal CHOICE2143 : STD_LOGIC; 
  signal CHOICE2103 : STD_LOGIC; 
  signal CHOICE2097 : STD_LOGIC; 
  signal CHOICE2183 : STD_LOGIC; 
  signal CHOICE2109 : STD_LOGIC; 
  signal CHOICE2129 : STD_LOGIC; 
  signal CHOICE2123 : STD_LOGIC; 
  signal N44508 : STD_LOGIC; 
  signal CHOICE2117 : STD_LOGIC; 
  signal CHOICE2137 : STD_LOGIC; 
  signal CHOICE2169 : STD_LOGIC; 
  signal CHOICE2163 : STD_LOGIC; 
  signal CHOICE2157 : STD_LOGIC; 
  signal CHOICE2177 : STD_LOGIC; 
  signal CHOICE2197 : STD_LOGIC; 
  signal CHOICE2043 : STD_LOGIC; 
  signal CHOICE2209 : STD_LOGIC; 
  signal CHOICE2229 : STD_LOGIC; 
  signal CHOICE2223 : STD_LOGIC; 
  signal CHOICE2217 : STD_LOGIC; 
  signal N28591 : STD_LOGIC; 
  signal N44512 : STD_LOGIC; 
  signal CHOICE2237 : STD_LOGIC; 
  signal CHOICE2049 : STD_LOGIC; 
  signal CHOICE2057 : STD_LOGIC; 
  signal CHOICE1078 : STD_LOGIC; 
  signal CHOICE1097 : STD_LOGIC; 
  signal CHOICE1102 : STD_LOGIC; 
  signal CHOICE1056 : STD_LOGIC; 
  signal CHOICE2597 : STD_LOGIC; 
  signal nRE_CPU : STD_LOGIC; 
  signal CHOICE842 : STD_LOGIC; 
  signal CHOICE836 : STD_LOGIC; 
  signal CHOICE845 : STD_LOGIC; 
  signal CHOICE847 : STD_LOGIC; 
  signal N43846 : STD_LOGIC; 
  signal N43854 : STD_LOGIC; 
  signal N43834 : STD_LOGIC; 
  signal N27948 : STD_LOGIC; 
  signal N43838 : STD_LOGIC; 
  signal CHOICE2969 : STD_LOGIC; 
  signal N43512 : STD_LOGIC; 
  signal N43510 : STD_LOGIC; 
  signal XLXI_26_N16190 : STD_LOGIC; 
  signal N43842 : STD_LOGIC; 
  signal CHOICE2530 : STD_LOGIC; 
  signal N43850 : STD_LOGIC; 
  signal CHOICE2594 : STD_LOGIC; 
  signal CHOICE2658 : STD_LOGIC; 
  signal N28099 : STD_LOGIC; 
  signal N43830 : STD_LOGIC; 
  signal CHOICE2755 : STD_LOGIC; 
  signal CHOICE2819 : STD_LOGIC; 
  signal N43917 : STD_LOGIC; 
  signal CHOICE2883 : STD_LOGIC; 
  signal N43414 : STD_LOGIC; 
  signal N43447 : STD_LOGIC; 
  signal N43416 : STD_LOGIC; 
  signal CHOICE2700 : STD_LOGIC; 
  signal CHOICE2947 : STD_LOGIC; 
  signal N43449 : STD_LOGIC; 
  signal CHOICE2722 : STD_LOGIC; 
  signal N43460 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_0 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_1 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_2 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_3 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_4 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_5 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_6 : STD_LOGIC; 
  signal GLOBAL_LOGIC0_0 : STD_LOGIC; 
  signal GLOBAL_LOGIC0_1 : STD_LOGIC; 
  signal GLOBAL_LOGIC0_2 : STD_LOGIC; 
  signal GLOBAL_LOGIC0_3 : STD_LOGIC; 
  signal GLOBAL_LOGIC0_4 : STD_LOGIC; 
  signal GLOBAL_LOGIC0_5 : STD_LOGIC; 
  signal GLOBAL_LOGIC0_6 : STD_LOGIC; 
  signal GLOBAL_LOGIC0_7 : STD_LOGIC; 
  signal GLOBAL_LOGIC0_8 : STD_LOGIC; 
  signal GLOBAL_LOGIC0_9 : STD_LOGIC; 
  signal GLOBAL_LOGIC0_10 : STD_LOGIC; 
  signal GLOBAL_LOGIC0_11 : STD_LOGIC; 
  signal GSR : STD_LOGIC; 
  signal GTS : STD_LOGIC; 
  signal IN_INT_0_IBUF_0 : STD_LOGIC; 
  signal IN_INT_1_IBUF_1 : STD_LOGIC; 
  signal IN_INT_2_IBUF_2 : STD_LOGIC; 
  signal IN_INT_3_IBUF_3 : STD_LOGIC; 
  signal OUT0_REG_0_OFF_RST : STD_LOGIC; 
  signal OUT0_REG_0_ENABLE : STD_LOGIC; 
  signal OUT0_REG_0_TORGTS : STD_LOGIC; 
  signal OUT0_REG_0_OUTMUX : STD_LOGIC; 
  signal OUT0_REG_0_OD : STD_LOGIC; 
  signal OUT0_REG_0_SRMUXNOT : STD_LOGIC; 
  signal OUT0_REG_1_ENABLE : STD_LOGIC; 
  signal OUT0_REG_1_TORGTS : STD_LOGIC; 
  signal OUT0_REG_1_OUTMUX : STD_LOGIC; 
  signal OUT0_REG_1_OD : STD_LOGIC; 
  signal OUT0_REG_1_SRMUXNOT : STD_LOGIC; 
  signal OUT0_REG_2_ENABLE : STD_LOGIC; 
  signal OUT0_REG_2_TORGTS : STD_LOGIC; 
  signal OUT0_REG_2_OUTMUX : STD_LOGIC; 
  signal OUT0_REG_2_OD : STD_LOGIC; 
  signal OUT0_REG_2_SRMUXNOT : STD_LOGIC; 
  signal OUT0_REG_3_ENABLE : STD_LOGIC; 
  signal OUT0_REG_3_TORGTS : STD_LOGIC; 
  signal OUT0_REG_3_OUTMUX : STD_LOGIC; 
  signal OUT0_REG_3_OD : STD_LOGIC; 
  signal OUT0_REG_3_SRMUXNOT : STD_LOGIC; 
  signal OUT0_REG_1_OFF_RST : STD_LOGIC; 
  signal OUT0_REG_4_ENABLE : STD_LOGIC; 
  signal OUT0_REG_4_TORGTS : STD_LOGIC; 
  signal OUT0_REG_4_OUTMUX : STD_LOGIC; 
  signal OUT0_REG_4_OD : STD_LOGIC; 
  signal OUT0_REG_4_SRMUXNOT : STD_LOGIC; 
  signal OUT0_REG_5_ENABLE : STD_LOGIC; 
  signal OUT0_REG_5_TORGTS : STD_LOGIC; 
  signal OUT0_REG_5_OUTMUX : STD_LOGIC; 
  signal OUT0_REG_5_OD : STD_LOGIC; 
  signal OUT0_REG_5_SRMUXNOT : STD_LOGIC; 
  signal OUT0_REG_6_ENABLE : STD_LOGIC; 
  signal OUT0_REG_6_TORGTS : STD_LOGIC; 
  signal OUT0_REG_6_OUTMUX : STD_LOGIC; 
  signal OUT0_REG_6_OD : STD_LOGIC; 
  signal OUT0_REG_6_SRMUXNOT : STD_LOGIC; 
  signal OUT0_REG_7_ENABLE : STD_LOGIC; 
  signal OUT0_REG_7_TORGTS : STD_LOGIC; 
  signal OUT0_REG_7_OUTMUX : STD_LOGIC; 
  signal OUT0_REG_7_OD : STD_LOGIC; 
  signal OUT0_REG_7_SRMUXNOT : STD_LOGIC; 
  signal OUT1_REG_0_ENABLE : STD_LOGIC; 
  signal OUT1_REG_0_TORGTS : STD_LOGIC; 
  signal OUT1_REG_0_OUTMUX : STD_LOGIC; 
  signal OUT1_REG_0_OD : STD_LOGIC; 
  signal OUT1_REG_0_SRMUXNOT : STD_LOGIC; 
  signal OUT1_REG_1_ENABLE : STD_LOGIC; 
  signal OUT1_REG_1_TORGTS : STD_LOGIC; 
  signal OUT1_REG_1_OUTMUX : STD_LOGIC; 
  signal OUT1_REG_1_OD : STD_LOGIC; 
  signal OUT1_REG_1_SRMUXNOT : STD_LOGIC; 
  signal OUT1_REG_2_ENABLE : STD_LOGIC; 
  signal OUT1_REG_2_TORGTS : STD_LOGIC; 
  signal OUT1_REG_2_OUTMUX : STD_LOGIC; 
  signal OUT1_REG_2_OD : STD_LOGIC; 
  signal OUT1_REG_2_SRMUXNOT : STD_LOGIC; 
  signal OUT1_REG_3_ENABLE : STD_LOGIC; 
  signal OUT1_REG_3_TORGTS : STD_LOGIC; 
  signal OUT1_REG_3_OUTMUX : STD_LOGIC; 
  signal OUT1_REG_3_OD : STD_LOGIC; 
  signal OUT1_REG_3_SRMUXNOT : STD_LOGIC; 
  signal OUT1_REG_4_ENABLE : STD_LOGIC; 
  signal OUT1_REG_4_TORGTS : STD_LOGIC; 
  signal OUT1_REG_4_OUTMUX : STD_LOGIC; 
  signal OUT1_REG_4_OD : STD_LOGIC; 
  signal OUT1_REG_4_SRMUXNOT : STD_LOGIC; 
  signal OUT1_REG_5_ENABLE : STD_LOGIC; 
  signal OUT1_REG_5_TORGTS : STD_LOGIC; 
  signal OUT1_REG_5_OUTMUX : STD_LOGIC; 
  signal OUT1_REG_5_OD : STD_LOGIC; 
  signal OUT1_REG_5_SRMUXNOT : STD_LOGIC; 
  signal OUT1_REG_6_ENABLE : STD_LOGIC; 
  signal OUT1_REG_6_TORGTS : STD_LOGIC; 
  signal OUT1_REG_6_OUTMUX : STD_LOGIC; 
  signal OUT1_REG_6_OD : STD_LOGIC; 
  signal OUT1_REG_6_SRMUXNOT : STD_LOGIC; 
  signal OUT1_REG_7_ENABLE : STD_LOGIC; 
  signal OUT1_REG_7_TORGTS : STD_LOGIC; 
  signal OUT1_REG_7_OUTMUX : STD_LOGIC; 
  signal OUT1_REG_7_OD : STD_LOGIC; 
  signal OUT1_REG_7_SRMUXNOT : STD_LOGIC; 
  signal RXD_IDELAY : STD_LOGIC; 
  signal RXD_IBUF_4 : STD_LOGIC; 
  signal RXD_SRMUXNOT : STD_LOGIC; 
  signal TXD_ENABLE : STD_LOGIC; 
  signal TXD_TORGTS : STD_LOGIC; 
  signal TXD_OUTMUX : STD_LOGIC; 
  signal XLXI_6_tx_uart : STD_LOGIC; 
  signal TXD_OD : STD_LOGIC; 
  signal TXD_SRMUXNOT : STD_LOGIC; 
  signal IN0_REG_0_IBUF_5 : STD_LOGIC; 
  signal IN0_REG_1_IBUF_6 : STD_LOGIC; 
  signal IN0_REG_2_IBUF_7 : STD_LOGIC; 
  signal IN0_REG_3_IBUF_8 : STD_LOGIC; 
  signal IN0_REG_4_IBUF_9 : STD_LOGIC; 
  signal OUT0_REG_2_OFF_RST : STD_LOGIC; 
  signal IN0_REG_5_IBUF_10 : STD_LOGIC; 
  signal IN0_REG_6_IBUF_11 : STD_LOGIC; 
  signal IN0_REG_7_IBUF_12 : STD_LOGIC; 
  signal IN1_REG_0_IBUF_13 : STD_LOGIC; 
  signal IN1_REG_1_IBUF_14 : STD_LOGIC; 
  signal IN1_REG_2_IBUF_15 : STD_LOGIC; 
  signal IN1_REG_3_IBUF_16 : STD_LOGIC; 
  signal IN1_REG_4_IBUF_17 : STD_LOGIC; 
  signal IN1_REG_5_IBUF_18 : STD_LOGIC; 
  signal IN1_REG_6_IBUF_19 : STD_LOGIC; 
  signal IN1_REG_7_IBUF_20 : STD_LOGIC; 
  signal XLXI_7_B5_DOB15 : STD_LOGIC; 
  signal XLXI_7_B5_DOB14 : STD_LOGIC; 
  signal XLXI_7_B5_DOB13 : STD_LOGIC; 
  signal XLXI_7_B5_DOB12 : STD_LOGIC; 
  signal XLXI_7_B5_DOB11 : STD_LOGIC; 
  signal XLXI_7_B5_DOB10 : STD_LOGIC; 
  signal XLXI_7_B5_DOB9 : STD_LOGIC; 
  signal XLXI_7_B5_DOB8 : STD_LOGIC; 
  signal XLXI_7_B5_DOB7 : STD_LOGIC; 
  signal XLXI_7_B5_DOB6 : STD_LOGIC; 
  signal XLXI_7_B5_DOB5 : STD_LOGIC; 
  signal XLXI_7_B5_DOB4 : STD_LOGIC; 
  signal XLXI_7_B5_DOB3 : STD_LOGIC; 
  signal XLXI_7_B5_DOB2 : STD_LOGIC; 
  signal XLXI_7_B5_DOB1 : STD_LOGIC; 
  signal XLXI_7_B5_DOB0 : STD_LOGIC; 
  signal XLXI_7_B5_DOA15 : STD_LOGIC; 
  signal XLXI_7_B5_DOA14 : STD_LOGIC; 
  signal XLXI_7_B5_DOA13 : STD_LOGIC; 
  signal XLXI_7_B5_DOA12 : STD_LOGIC; 
  signal XLXI_7_B5_DOA11 : STD_LOGIC; 
  signal XLXI_7_B5_DOA10 : STD_LOGIC; 
  signal XLXI_7_B5_DOA9 : STD_LOGIC; 
  signal XLXI_7_B5_DOA8 : STD_LOGIC; 
  signal XLXI_7_B5_DIB15 : STD_LOGIC; 
  signal XLXI_7_B5_DIB14 : STD_LOGIC; 
  signal XLXI_7_B5_DIB13 : STD_LOGIC; 
  signal XLXI_7_B5_DIB12 : STD_LOGIC; 
  signal XLXI_7_B5_DIB11 : STD_LOGIC; 
  signal XLXI_7_B5_DIB10 : STD_LOGIC; 
  signal XLXI_7_B5_DIB9 : STD_LOGIC; 
  signal XLXI_7_B5_DIB8 : STD_LOGIC; 
  signal XLXI_7_B5_DIB7 : STD_LOGIC; 
  signal XLXI_7_B5_DIB6 : STD_LOGIC; 
  signal XLXI_7_B5_DIB5 : STD_LOGIC; 
  signal XLXI_7_B5_DIB4 : STD_LOGIC; 
  signal XLXI_7_B5_DIB3 : STD_LOGIC; 
  signal XLXI_7_B5_DIB2 : STD_LOGIC; 
  signal XLXI_7_B5_DIB1 : STD_LOGIC; 
  signal XLXI_7_B5_DIB0 : STD_LOGIC; 
  signal XLXI_7_B5_DIA15 : STD_LOGIC; 
  signal XLXI_7_B5_DIA14 : STD_LOGIC; 
  signal XLXI_7_B5_DIA13 : STD_LOGIC; 
  signal XLXI_7_B5_DIA12 : STD_LOGIC; 
  signal XLXI_7_B5_DIA11 : STD_LOGIC; 
  signal XLXI_7_B5_DIA10 : STD_LOGIC; 
  signal XLXI_7_B5_DIA9 : STD_LOGIC; 
  signal XLXI_7_B5_DIA8 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB11 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB10 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB9 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB8 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB7 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB6 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB5 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB4 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB3 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB2 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB1 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB0 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRA2 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRA1 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRA0 : STD_LOGIC; 
  signal XLXI_7_B5_WEA_INTNOT : STD_LOGIC; 
  signal XLXI_7_B5_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_7_B5_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_8_B5_DOB15 : STD_LOGIC; 
  signal XLXI_8_B5_DOB14 : STD_LOGIC; 
  signal XLXI_8_B5_DOB13 : STD_LOGIC; 
  signal XLXI_8_B5_DOB12 : STD_LOGIC; 
  signal XLXI_8_B5_DOB11 : STD_LOGIC; 
  signal XLXI_8_B5_DOB10 : STD_LOGIC; 
  signal XLXI_8_B5_DOB9 : STD_LOGIC; 
  signal XLXI_8_B5_DOB8 : STD_LOGIC; 
  signal XLXI_8_B5_DOB7 : STD_LOGIC; 
  signal XLXI_8_B5_DOB6 : STD_LOGIC; 
  signal XLXI_8_B5_DOB5 : STD_LOGIC; 
  signal XLXI_8_B5_DOB4 : STD_LOGIC; 
  signal XLXI_8_B5_DOB3 : STD_LOGIC; 
  signal XLXI_8_B5_DOB2 : STD_LOGIC; 
  signal XLXI_8_B5_DOB1 : STD_LOGIC; 
  signal XLXI_8_B5_DOB0 : STD_LOGIC; 
  signal XLXI_8_B5_DOA15 : STD_LOGIC; 
  signal XLXI_8_B5_DOA14 : STD_LOGIC; 
  signal XLXI_8_B5_DOA13 : STD_LOGIC; 
  signal XLXI_8_B5_DOA12 : STD_LOGIC; 
  signal XLXI_8_B5_DOA11 : STD_LOGIC; 
  signal XLXI_8_B5_DOA10 : STD_LOGIC; 
  signal XLXI_8_B5_DOA9 : STD_LOGIC; 
  signal XLXI_8_B5_DOA8 : STD_LOGIC; 
  signal XLXI_8_B5_DOA7 : STD_LOGIC; 
  signal XLXI_8_B5_DOA6 : STD_LOGIC; 
  signal XLXI_8_B5_DOA5 : STD_LOGIC; 
  signal XLXI_8_B5_DOA4 : STD_LOGIC; 
  signal XLXI_8_B5_DIB15 : STD_LOGIC; 
  signal XLXI_8_B5_DIB14 : STD_LOGIC; 
  signal XLXI_8_B5_DIB13 : STD_LOGIC; 
  signal XLXI_8_B5_DIB12 : STD_LOGIC; 
  signal XLXI_8_B5_DIB11 : STD_LOGIC; 
  signal XLXI_8_B5_DIB10 : STD_LOGIC; 
  signal XLXI_8_B5_DIB9 : STD_LOGIC; 
  signal XLXI_8_B5_DIB8 : STD_LOGIC; 
  signal XLXI_8_B5_DIB7 : STD_LOGIC; 
  signal XLXI_8_B5_DIB6 : STD_LOGIC; 
  signal XLXI_8_B5_DIB5 : STD_LOGIC; 
  signal XLXI_8_B5_DIB4 : STD_LOGIC; 
  signal XLXI_8_B5_DIB3 : STD_LOGIC; 
  signal XLXI_8_B5_DIB2 : STD_LOGIC; 
  signal XLXI_8_B5_DIB1 : STD_LOGIC; 
  signal XLXI_8_B5_DIB0 : STD_LOGIC; 
  signal XLXI_8_B5_DIA15 : STD_LOGIC; 
  signal XLXI_8_B5_DIA14 : STD_LOGIC; 
  signal XLXI_8_B5_DIA13 : STD_LOGIC; 
  signal XLXI_8_B5_DIA12 : STD_LOGIC; 
  signal XLXI_8_B5_DIA11 : STD_LOGIC; 
  signal XLXI_8_B5_DIA10 : STD_LOGIC; 
  signal XLXI_8_B5_DIA9 : STD_LOGIC; 
  signal XLXI_8_B5_DIA8 : STD_LOGIC; 
  signal XLXI_8_B5_DIA7 : STD_LOGIC; 
  signal XLXI_8_B5_DIA6 : STD_LOGIC; 
  signal XLXI_8_B5_DIA5 : STD_LOGIC; 
  signal XLXI_8_B5_DIA4 : STD_LOGIC; 
  signal XLXI_8_B5_ADDRB11 : STD_LOGIC; 
  signal XLXI_8_B5_ADDRB10 : STD_LOGIC; 
  signal XLXI_8_B5_ADDRB9 : STD_LOGIC; 
  signal XLXI_8_B5_ADDRB8 : STD_LOGIC; 
  signal XLXI_8_B5_ADDRB7 : STD_LOGIC; 
  signal XLXI_8_B5_ADDRB6 : STD_LOGIC; 
  signal XLXI_8_B5_ADDRB5 : STD_LOGIC; 
  signal XLXI_8_B5_ADDRB4 : STD_LOGIC; 
  signal XLXI_8_B5_ADDRB3 : STD_LOGIC; 
  signal XLXI_8_B5_ADDRB2 : STD_LOGIC; 
  signal XLXI_8_B5_ADDRB1 : STD_LOGIC; 
  signal XLXI_8_B5_ADDRB0 : STD_LOGIC; 
  signal XLXI_8_B5_ADDRA1 : STD_LOGIC; 
  signal XLXI_8_B5_ADDRA0 : STD_LOGIC; 
  signal XLXI_8_B5_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_8_B5_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_8_B9_DOB15 : STD_LOGIC; 
  signal XLXI_8_B9_DOB14 : STD_LOGIC; 
  signal XLXI_8_B9_DOB13 : STD_LOGIC; 
  signal XLXI_8_B9_DOB12 : STD_LOGIC; 
  signal XLXI_8_B9_DOB11 : STD_LOGIC; 
  signal XLXI_8_B9_DOB10 : STD_LOGIC; 
  signal XLXI_8_B9_DOB9 : STD_LOGIC; 
  signal XLXI_8_B9_DOB8 : STD_LOGIC; 
  signal XLXI_8_B9_DOB7 : STD_LOGIC; 
  signal XLXI_8_B9_DOB6 : STD_LOGIC; 
  signal XLXI_8_B9_DOB5 : STD_LOGIC; 
  signal XLXI_8_B9_DOB4 : STD_LOGIC; 
  signal XLXI_8_B9_DOB3 : STD_LOGIC; 
  signal XLXI_8_B9_DOB2 : STD_LOGIC; 
  signal XLXI_8_B9_DOB1 : STD_LOGIC; 
  signal XLXI_8_B9_DOB0 : STD_LOGIC; 
  signal XLXI_8_B9_DOA15 : STD_LOGIC; 
  signal XLXI_8_B9_DOA14 : STD_LOGIC; 
  signal XLXI_8_B9_DOA13 : STD_LOGIC; 
  signal XLXI_8_B9_DOA12 : STD_LOGIC; 
  signal XLXI_8_B9_DOA11 : STD_LOGIC; 
  signal XLXI_8_B9_DOA10 : STD_LOGIC; 
  signal XLXI_8_B9_DOA9 : STD_LOGIC; 
  signal XLXI_8_B9_DOA8 : STD_LOGIC; 
  signal XLXI_8_B9_DOA7 : STD_LOGIC; 
  signal XLXI_8_B9_DOA6 : STD_LOGIC; 
  signal XLXI_8_B9_DOA5 : STD_LOGIC; 
  signal XLXI_8_B9_DOA4 : STD_LOGIC; 
  signal XLXI_8_B9_DIB15 : STD_LOGIC; 
  signal XLXI_8_B9_DIB14 : STD_LOGIC; 
  signal XLXI_8_B9_DIB13 : STD_LOGIC; 
  signal XLXI_8_B9_DIB12 : STD_LOGIC; 
  signal XLXI_8_B9_DIB11 : STD_LOGIC; 
  signal XLXI_8_B9_DIB10 : STD_LOGIC; 
  signal XLXI_8_B9_DIB9 : STD_LOGIC; 
  signal XLXI_8_B9_DIB8 : STD_LOGIC; 
  signal XLXI_8_B9_DIB7 : STD_LOGIC; 
  signal XLXI_8_B9_DIB6 : STD_LOGIC; 
  signal XLXI_8_B9_DIB5 : STD_LOGIC; 
  signal XLXI_8_B9_DIB4 : STD_LOGIC; 
  signal XLXI_8_B9_DIB3 : STD_LOGIC; 
  signal XLXI_8_B9_DIB2 : STD_LOGIC; 
  signal XLXI_8_B9_DIB1 : STD_LOGIC; 
  signal XLXI_8_B9_DIB0 : STD_LOGIC; 
  signal XLXI_8_B9_DIA15 : STD_LOGIC; 
  signal XLXI_8_B9_DIA14 : STD_LOGIC; 
  signal XLXI_8_B9_DIA13 : STD_LOGIC; 
  signal XLXI_8_B9_DIA12 : STD_LOGIC; 
  signal XLXI_8_B9_DIA11 : STD_LOGIC; 
  signal XLXI_8_B9_DIA10 : STD_LOGIC; 
  signal XLXI_8_B9_DIA9 : STD_LOGIC; 
  signal XLXI_8_B9_DIA8 : STD_LOGIC; 
  signal XLXI_8_B9_DIA7 : STD_LOGIC; 
  signal XLXI_8_B9_DIA6 : STD_LOGIC; 
  signal XLXI_8_B9_DIA5 : STD_LOGIC; 
  signal XLXI_8_B9_DIA4 : STD_LOGIC; 
  signal XLXI_8_B9_ADDRB11 : STD_LOGIC; 
  signal XLXI_8_B9_ADDRB10 : STD_LOGIC; 
  signal XLXI_8_B9_ADDRB9 : STD_LOGIC; 
  signal XLXI_8_B9_ADDRB8 : STD_LOGIC; 
  signal XLXI_8_B9_ADDRB7 : STD_LOGIC; 
  signal XLXI_8_B9_ADDRB6 : STD_LOGIC; 
  signal XLXI_8_B9_ADDRB5 : STD_LOGIC; 
  signal XLXI_8_B9_ADDRB4 : STD_LOGIC; 
  signal XLXI_8_B9_ADDRB3 : STD_LOGIC; 
  signal XLXI_8_B9_ADDRB2 : STD_LOGIC; 
  signal XLXI_8_B9_ADDRB1 : STD_LOGIC; 
  signal XLXI_8_B9_ADDRB0 : STD_LOGIC; 
  signal XLXI_8_B9_ADDRA1 : STD_LOGIC; 
  signal XLXI_8_B9_ADDRA0 : STD_LOGIC; 
  signal XLXI_8_B9_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_8_B9_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_8_B13_DOB15 : STD_LOGIC; 
  signal XLXI_8_B13_DOB14 : STD_LOGIC; 
  signal XLXI_8_B13_DOB13 : STD_LOGIC; 
  signal XLXI_8_B13_DOB12 : STD_LOGIC; 
  signal XLXI_8_B13_DOB11 : STD_LOGIC; 
  signal XLXI_8_B13_DOB10 : STD_LOGIC; 
  signal XLXI_8_B13_DOB9 : STD_LOGIC; 
  signal XLXI_8_B13_DOB8 : STD_LOGIC; 
  signal XLXI_8_B13_DOB7 : STD_LOGIC; 
  signal XLXI_8_B13_DOB6 : STD_LOGIC; 
  signal XLXI_8_B13_DOB5 : STD_LOGIC; 
  signal XLXI_8_B13_DOB4 : STD_LOGIC; 
  signal XLXI_8_B13_DOB3 : STD_LOGIC; 
  signal XLXI_8_B13_DOB2 : STD_LOGIC; 
  signal XLXI_8_B13_DOB1 : STD_LOGIC; 
  signal XLXI_8_B13_DOB0 : STD_LOGIC; 
  signal XLXI_8_B13_DOA15 : STD_LOGIC; 
  signal XLXI_8_B13_DOA14 : STD_LOGIC; 
  signal XLXI_8_B13_DOA13 : STD_LOGIC; 
  signal XLXI_8_B13_DOA12 : STD_LOGIC; 
  signal XLXI_8_B13_DOA11 : STD_LOGIC; 
  signal XLXI_8_B13_DOA10 : STD_LOGIC; 
  signal XLXI_8_B13_DOA9 : STD_LOGIC; 
  signal XLXI_8_B13_DOA8 : STD_LOGIC; 
  signal XLXI_8_B13_DOA7 : STD_LOGIC; 
  signal XLXI_8_B13_DOA6 : STD_LOGIC; 
  signal XLXI_8_B13_DOA5 : STD_LOGIC; 
  signal XLXI_8_B13_DOA4 : STD_LOGIC; 
  signal XLXI_8_B13_DIB15 : STD_LOGIC; 
  signal XLXI_8_B13_DIB14 : STD_LOGIC; 
  signal XLXI_8_B13_DIB13 : STD_LOGIC; 
  signal XLXI_8_B13_DIB12 : STD_LOGIC; 
  signal XLXI_8_B13_DIB11 : STD_LOGIC; 
  signal XLXI_8_B13_DIB10 : STD_LOGIC; 
  signal XLXI_8_B13_DIB9 : STD_LOGIC; 
  signal XLXI_8_B13_DIB8 : STD_LOGIC; 
  signal XLXI_8_B13_DIB7 : STD_LOGIC; 
  signal XLXI_8_B13_DIB6 : STD_LOGIC; 
  signal XLXI_8_B13_DIB5 : STD_LOGIC; 
  signal XLXI_8_B13_DIB4 : STD_LOGIC; 
  signal XLXI_8_B13_DIB3 : STD_LOGIC; 
  signal XLXI_8_B13_DIB2 : STD_LOGIC; 
  signal XLXI_8_B13_DIB1 : STD_LOGIC; 
  signal XLXI_8_B13_DIB0 : STD_LOGIC; 
  signal XLXI_8_B13_DIA15 : STD_LOGIC; 
  signal XLXI_8_B13_DIA14 : STD_LOGIC; 
  signal XLXI_8_B13_DIA13 : STD_LOGIC; 
  signal XLXI_8_B13_DIA12 : STD_LOGIC; 
  signal XLXI_8_B13_DIA11 : STD_LOGIC; 
  signal XLXI_8_B13_DIA10 : STD_LOGIC; 
  signal XLXI_8_B13_DIA9 : STD_LOGIC; 
  signal XLXI_8_B13_DIA8 : STD_LOGIC; 
  signal XLXI_8_B13_DIA7 : STD_LOGIC; 
  signal XLXI_8_B13_DIA6 : STD_LOGIC; 
  signal XLXI_8_B13_DIA5 : STD_LOGIC; 
  signal XLXI_8_B13_DIA4 : STD_LOGIC; 
  signal XLXI_8_B13_ADDRB11 : STD_LOGIC; 
  signal XLXI_8_B13_ADDRB10 : STD_LOGIC; 
  signal XLXI_8_B13_ADDRB9 : STD_LOGIC; 
  signal XLXI_8_B13_ADDRB8 : STD_LOGIC; 
  signal XLXI_8_B13_ADDRB7 : STD_LOGIC; 
  signal XLXI_8_B13_ADDRB6 : STD_LOGIC; 
  signal XLXI_8_B13_ADDRB5 : STD_LOGIC; 
  signal XLXI_8_B13_ADDRB4 : STD_LOGIC; 
  signal XLXI_8_B13_ADDRB3 : STD_LOGIC; 
  signal XLXI_8_B13_ADDRB2 : STD_LOGIC; 
  signal XLXI_8_B13_ADDRB1 : STD_LOGIC; 
  signal XLXI_8_B13_ADDRB0 : STD_LOGIC; 
  signal XLXI_8_B13_ADDRA1 : STD_LOGIC; 
  signal XLXI_8_B13_ADDRA0 : STD_LOGIC; 
  signal XLXI_8_B13_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_8_B13_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_8_B17_DOB15 : STD_LOGIC; 
  signal XLXI_8_B17_DOB14 : STD_LOGIC; 
  signal XLXI_8_B17_DOB13 : STD_LOGIC; 
  signal XLXI_8_B17_DOB12 : STD_LOGIC; 
  signal XLXI_8_B17_DOB11 : STD_LOGIC; 
  signal XLXI_8_B17_DOB10 : STD_LOGIC; 
  signal XLXI_8_B17_DOB9 : STD_LOGIC; 
  signal XLXI_8_B17_DOB8 : STD_LOGIC; 
  signal XLXI_8_B17_DOB7 : STD_LOGIC; 
  signal XLXI_8_B17_DOB6 : STD_LOGIC; 
  signal XLXI_8_B17_DOB5 : STD_LOGIC; 
  signal XLXI_8_B17_DOB4 : STD_LOGIC; 
  signal XLXI_8_B17_DOB3 : STD_LOGIC; 
  signal XLXI_8_B17_DOB2 : STD_LOGIC; 
  signal XLXI_8_B17_DOB1 : STD_LOGIC; 
  signal XLXI_8_B17_DOB0 : STD_LOGIC; 
  signal XLXI_8_B17_DOA15 : STD_LOGIC; 
  signal XLXI_8_B17_DOA14 : STD_LOGIC; 
  signal XLXI_8_B17_DOA13 : STD_LOGIC; 
  signal XLXI_8_B17_DOA12 : STD_LOGIC; 
  signal XLXI_8_B17_DOA11 : STD_LOGIC; 
  signal XLXI_8_B17_DOA10 : STD_LOGIC; 
  signal XLXI_8_B17_DOA9 : STD_LOGIC; 
  signal XLXI_8_B17_DOA8 : STD_LOGIC; 
  signal XLXI_8_B17_DOA7 : STD_LOGIC; 
  signal XLXI_8_B17_DOA6 : STD_LOGIC; 
  signal XLXI_8_B17_DOA5 : STD_LOGIC; 
  signal XLXI_8_B17_DOA4 : STD_LOGIC; 
  signal XLXI_8_B17_DOA3 : STD_LOGIC; 
  signal XLXI_8_B17_DOA2 : STD_LOGIC; 
  signal XLXI_8_B17_DIB15 : STD_LOGIC; 
  signal XLXI_8_B17_DIB14 : STD_LOGIC; 
  signal XLXI_8_B17_DIB13 : STD_LOGIC; 
  signal XLXI_8_B17_DIB12 : STD_LOGIC; 
  signal XLXI_8_B17_DIB11 : STD_LOGIC; 
  signal XLXI_8_B17_DIB10 : STD_LOGIC; 
  signal XLXI_8_B17_DIB9 : STD_LOGIC; 
  signal XLXI_8_B17_DIB8 : STD_LOGIC; 
  signal XLXI_8_B17_DIB7 : STD_LOGIC; 
  signal XLXI_8_B17_DIB6 : STD_LOGIC; 
  signal XLXI_8_B17_DIB5 : STD_LOGIC; 
  signal XLXI_8_B17_DIB4 : STD_LOGIC; 
  signal XLXI_8_B17_DIB3 : STD_LOGIC; 
  signal XLXI_8_B17_DIB2 : STD_LOGIC; 
  signal XLXI_8_B17_DIB1 : STD_LOGIC; 
  signal XLXI_8_B17_DIB0 : STD_LOGIC; 
  signal XLXI_8_B17_DIA15 : STD_LOGIC; 
  signal XLXI_8_B17_DIA14 : STD_LOGIC; 
  signal XLXI_8_B17_DIA13 : STD_LOGIC; 
  signal XLXI_8_B17_DIA12 : STD_LOGIC; 
  signal XLXI_8_B17_DIA11 : STD_LOGIC; 
  signal XLXI_8_B17_DIA10 : STD_LOGIC; 
  signal XLXI_8_B17_DIA9 : STD_LOGIC; 
  signal XLXI_8_B17_DIA8 : STD_LOGIC; 
  signal XLXI_8_B17_DIA7 : STD_LOGIC; 
  signal XLXI_8_B17_DIA6 : STD_LOGIC; 
  signal XLXI_8_B17_DIA5 : STD_LOGIC; 
  signal XLXI_8_B17_DIA4 : STD_LOGIC; 
  signal XLXI_8_B17_DIA3 : STD_LOGIC; 
  signal XLXI_8_B17_DIA2 : STD_LOGIC; 
  signal XLXI_8_B17_ADDRB11 : STD_LOGIC; 
  signal XLXI_8_B17_ADDRB10 : STD_LOGIC; 
  signal XLXI_8_B17_ADDRB9 : STD_LOGIC; 
  signal XLXI_8_B17_ADDRB8 : STD_LOGIC; 
  signal XLXI_8_B17_ADDRB7 : STD_LOGIC; 
  signal XLXI_8_B17_ADDRB6 : STD_LOGIC; 
  signal XLXI_8_B17_ADDRB5 : STD_LOGIC; 
  signal XLXI_8_B17_ADDRB4 : STD_LOGIC; 
  signal XLXI_8_B17_ADDRB3 : STD_LOGIC; 
  signal XLXI_8_B17_ADDRB2 : STD_LOGIC; 
  signal XLXI_8_B17_ADDRB1 : STD_LOGIC; 
  signal XLXI_8_B17_ADDRB0 : STD_LOGIC; 
  signal XLXI_8_B17_ADDRA0 : STD_LOGIC; 
  signal XLXI_8_B17_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_8_B17_LOGIC_ONE : STD_LOGIC; 
  signal OUT0_REG_3_OFF_RST : STD_LOGIC; 
  signal N44943 : STD_LOGIC; 
  signal N44941 : STD_LOGIC; 
  signal XLXI_1_I3_N19977_F5MUX : STD_LOGIC; 
  signal N44668 : STD_LOGIC; 
  signal N44666 : STD_LOGIC; 
  signal N43453_F5MUX : STD_LOGIC; 
  signal N44648 : STD_LOGIC; 
  signal N44646 : STD_LOGIC; 
  signal CHOICE828_F5MUX : STD_LOGIC; 
  signal N44853 : STD_LOGIC; 
  signal N44851 : STD_LOGIC; 
  signal XLXI_1_I4_ireg_i_0_F5MUX : STD_LOGIC; 
  signal N44843 : STD_LOGIC; 
  signal N44841 : STD_LOGIC; 
  signal XLXI_1_I4_ireg_i_1_F5MUX : STD_LOGIC; 
  signal N44938 : STD_LOGIC; 
  signal N44936 : STD_LOGIC; 
  signal XLXI_1_I4_ireg_i_2_F5MUX : STD_LOGIC; 
  signal N44848 : STD_LOGIC; 
  signal N44846 : STD_LOGIC; 
  signal XLXI_1_I4_ireg_i_3_F5MUX : STD_LOGIC; 
  signal N44958 : STD_LOGIC; 
  signal N44956 : STD_LOGIC; 
  signal XLXI_1_I4_ireg_i_4_F5MUX : STD_LOGIC; 
  signal N44833 : STD_LOGIC; 
  signal N44831 : STD_LOGIC; 
  signal XLXI_1_I4_ireg_i_5_F5MUX : STD_LOGIC; 
  signal N44963 : STD_LOGIC; 
  signal N44961 : STD_LOGIC; 
  signal XLXI_1_I4_ireg_i_6_F5MUX : STD_LOGIC; 
  signal N44838 : STD_LOGIC; 
  signal N44836 : STD_LOGIC; 
  signal XLXI_1_I4_ireg_i_7_F5MUX : STD_LOGIC; 
  signal N44753 : STD_LOGIC; 
  signal N44751 : STD_LOGIC; 
  signal N44743 : STD_LOGIC; 
  signal N44741 : STD_LOGIC; 
  signal N44728 : STD_LOGIC; 
  signal N44726 : STD_LOGIC; 
  signal N44868 : STD_LOGIC; 
  signal N44866 : STD_LOGIC; 
  signal N44798 : STD_LOGIC; 
  signal N44796 : STD_LOGIC; 
  signal N44773 : STD_LOGIC; 
  signal N44771 : STD_LOGIC; 
  signal N44733 : STD_LOGIC; 
  signal N44731 : STD_LOGIC; 
  signal N44953 : STD_LOGIC; 
  signal N44951 : STD_LOGIC; 
  signal OUT0_REG_4_OFF_RST : STD_LOGIC; 
  signal N44903 : STD_LOGIC; 
  signal N44901 : STD_LOGIC; 
  signal N44688 : STD_LOGIC; 
  signal N44686 : STD_LOGIC; 
  signal N44898 : STD_LOGIC; 
  signal N44896 : STD_LOGIC; 
  signal N44763 : STD_LOGIC; 
  signal N44761 : STD_LOGIC; 
  signal N44858 : STD_LOGIC; 
  signal N44856 : STD_LOGIC; 
  signal N44928 : STD_LOGIC; 
  signal N44926 : STD_LOGIC; 
  signal N43246_F5MUX : STD_LOGIC; 
  signal N44708 : STD_LOGIC; 
  signal N44706 : STD_LOGIC; 
  signal N44908 : STD_LOGIC; 
  signal N44906 : STD_LOGIC; 
  signal N44863 : STD_LOGIC; 
  signal N44861 : STD_LOGIC; 
  signal N44888 : STD_LOGIC; 
  signal N44886 : STD_LOGIC; 
  signal N44803 : STD_LOGIC; 
  signal N44801 : STD_LOGIC; 
  signal N44893 : STD_LOGIC; 
  signal N44891 : STD_LOGIC; 
  signal N44723 : STD_LOGIC; 
  signal N44721 : STD_LOGIC; 
  signal N44883 : STD_LOGIC; 
  signal N44881 : STD_LOGIC; 
  signal N44878 : STD_LOGIC; 
  signal N44876 : STD_LOGIC; 
  signal N44808 : STD_LOGIC; 
  signal N44806 : STD_LOGIC; 
  signal N44783 : STD_LOGIC; 
  signal N44781 : STD_LOGIC; 
  signal N44643 : STD_LOGIC; 
  signal N44641 : STD_LOGIC; 
  signal N44913 : STD_LOGIC; 
  signal N44911 : STD_LOGIC; 
  signal OUT0_REG_5_OFF_RST : STD_LOGIC; 
  signal N44718 : STD_LOGIC; 
  signal N44716 : STD_LOGIC; 
  signal N44658 : STD_LOGIC; 
  signal N44656 : STD_LOGIC; 
  signal N44813 : STD_LOGIC; 
  signal N44811 : STD_LOGIC; 
  signal N44768 : STD_LOGIC; 
  signal N44766 : STD_LOGIC; 
  signal N44873 : STD_LOGIC; 
  signal N44871 : STD_LOGIC; 
  signal N44823 : STD_LOGIC; 
  signal N44821 : STD_LOGIC; 
  signal N44793 : STD_LOGIC; 
  signal N44791 : STD_LOGIC; 
  signal XLXI_55_mux_x_3_1_O : STD_LOGIC; 
  signal XLXI_55_mux_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_55_mux_x_2_1_O : STD_LOGIC; 
  signal CPU_ADDR_OUT_0_FROM : STD_LOGIC; 
  signal CPU_ADDR_OUT_0_GROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_0_FROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_0_GROM : STD_LOGIC; 
  signal XLXI_1_I4_Ker217601_1_FROM : STD_LOGIC; 
  signal XLXI_1_I4_Ker217601_1_GROM : STD_LOGIC; 
  signal XLXI_1_I4_daddr_x_3_1_SW1_O_FROM : STD_LOGIC; 
  signal XLXI_1_I4_daddr_x_3_1_SW1_O_GROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_3_FROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_3_GROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal CPU_ADDR_OUT_2_FROM : STD_LOGIC; 
  signal CPU_ADDR_OUT_2_GROM : STD_LOGIC; 
  signal XLXI_1_I4_N21762_FROM : STD_LOGIC; 
  signal XLXI_1_I4_N21762_GROM : STD_LOGIC; 
  signal XLXI_5_tmr_enable_FROM : STD_LOGIC; 
  signal XLXI_5_tmr_enable_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_5_n00071_O : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_7_FROM : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_7_GROM : STD_LOGIC; 
  signal XLXI_1_I4_Ker216591_SW0_O_FROM : STD_LOGIC; 
  signal XLXI_1_I4_Ker216591_SW0_O_GROM : STD_LOGIC; 
  signal XLXI_5_tmr_reset_FROM : STD_LOGIC; 
  signal XLXI_5_tmr_reset_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_5_n00061_O : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_0_FROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_0_GROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_1_FROM : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_1_GROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_1_FROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_1_GROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_3_FROM : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_3_GROM : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_5_FROM : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_5_GROM : STD_LOGIC; 
  signal OUT1_REG_3_OFF_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_8_FROM : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_8_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_8_GROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_2_FROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_2_GROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_3_FROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_3_GROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_4_FROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_4_GROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_4_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_5_FROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_5_GROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_6_FROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_6_GROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_6_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_7_FROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_7_GROM : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal CHOICE2367_FROM : STD_LOGIC; 
  signal CHOICE2367_GROM : STD_LOGIC; 
  signal XLXI_1_I4_Ker218921_SW0_SW0_O_FROM : STD_LOGIC; 
  signal XLXI_1_I4_Ker218921_SW0_SW0_O_GROM : STD_LOGIC; 
  signal XLXI_1_I1_pc_1_FROM : STD_LOGIC; 
  signal XLXI_1_I1_pc_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I1_pc_1_GROM : STD_LOGIC; 
  signal XLXI_1_I1_pc_2_FROM : STD_LOGIC; 
  signal XLXI_1_I1_pc_2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I1_pc_2_GROM : STD_LOGIC; 
  signal XLXI_1_I1_pc_3_FROM : STD_LOGIC; 
  signal XLXI_1_I1_pc_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I1_pc_3_GROM : STD_LOGIC; 
  signal XLXI_1_I1_pc_4_FROM : STD_LOGIC; 
  signal XLXI_1_I1_pc_4_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I1_pc_4_GROM : STD_LOGIC; 
  signal XLXI_1_I1_pc_5_FROM : STD_LOGIC; 
  signal XLXI_1_I1_pc_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I1_pc_5_GROM : STD_LOGIC; 
  signal XLXI_1_I2_skip_c_FROM : STD_LOGIC; 
  signal XLXI_1_I2_skip_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I2_skip_c_GROM : STD_LOGIC; 
  signal CPU_ADDR_OUT_8_FROM : STD_LOGIC; 
  signal CPU_ADDR_OUT_8_GROM : STD_LOGIC; 
  signal XLXI_6_tx_clk_div_5_FROM : STD_LOGIC; 
  signal XLXI_6_tx_clk_div_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_n0014_5_1_O : STD_LOGIC; 
  signal XLXI_6_tx_clk_div_6_FROM : STD_LOGIC; 
  signal XLXI_6_tx_clk_div_6_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_n0014_6_1_O : STD_LOGIC; 
  signal XLXI_1_I2_n006236_SW1_O_FROM : STD_LOGIC; 
  signal XLXI_1_I2_n006236_SW1_O_GROM : STD_LOGIC; 
  signal OUT1_REG_4_OFF_RST : STD_LOGIC; 
  signal XLXI_1_ndre_int_FROM : STD_LOGIC; 
  signal XLXI_1_ndre_int_GROM : STD_LOGIC; 
  signal XLXI_1_I4_n005725_O_FROM : STD_LOGIC; 
  signal XLXI_1_I4_n005725_O_GROM : STD_LOGIC; 
  signal nCS_INT_FROM : STD_LOGIC; 
  signal nCS_INT_GROM : STD_LOGIC; 
  signal nCS_TIMER_FROM : STD_LOGIC; 
  signal nCS_TIMER_GROM : STD_LOGIC; 
  signal XLXI_6_n0014_1_1_O : STD_LOGIC; 
  signal XLXI_6_tx_clk_div_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_n0014_0_1_O : STD_LOGIC; 
  signal XLXI_6_n0014_3_1_O : STD_LOGIC; 
  signal XLXI_6_tx_clk_div_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_n0014_2_1_O : STD_LOGIC; 
  signal XLXI_6_tx_clk_div_4_FROM : STD_LOGIC; 
  signal XLXI_6_tx_clk_div_4_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_n0014_4_1_O : STD_LOGIC; 
  signal XLXI_1_I3_n0023_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n0023_GROM : STD_LOGIC; 
  signal XLXI_55_nCS_UART_SW0_O_FROM : STD_LOGIC; 
  signal XLXI_55_nCS_UART_SW0_O_GROM : STD_LOGIC; 
  signal N44748 : STD_LOGIC; 
  signal N44746 : STD_LOGIC; 
  signal N44693 : STD_LOGIC; 
  signal N44691 : STD_LOGIC; 
  signal N44778 : STD_LOGIC; 
  signal N44776 : STD_LOGIC; 
  signal N44698 : STD_LOGIC; 
  signal N44696 : STD_LOGIC; 
  signal N44628 : STD_LOGIC; 
  signal N44626 : STD_LOGIC; 
  signal N44923 : STD_LOGIC; 
  signal N44921 : STD_LOGIC; 
  signal N44608 : STD_LOGIC; 
  signal N44606 : STD_LOGIC; 
  signal N44818 : STD_LOGIC; 
  signal N44816 : STD_LOGIC; 
  signal N44653 : STD_LOGIC; 
  signal N44651 : STD_LOGIC; 
  signal N44758 : STD_LOGIC; 
  signal N44756 : STD_LOGIC; 
  signal N44738 : STD_LOGIC; 
  signal N44736 : STD_LOGIC; 
  signal N44673 : STD_LOGIC; 
  signal N44671 : STD_LOGIC; 
  signal OUT0_REG_6_OFF_RST : STD_LOGIC; 
  signal N44828 : STD_LOGIC; 
  signal N44826 : STD_LOGIC; 
  signal N44703 : STD_LOGIC; 
  signal N44701 : STD_LOGIC; 
  signal N44593 : STD_LOGIC; 
  signal N44591 : STD_LOGIC; 
  signal N44713 : STD_LOGIC; 
  signal N44711 : STD_LOGIC; 
  signal N44618 : STD_LOGIC; 
  signal N44616 : STD_LOGIC; 
  signal N44683 : STD_LOGIC; 
  signal N44681 : STD_LOGIC; 
  signal N44598 : STD_LOGIC; 
  signal N44596 : STD_LOGIC; 
  signal N44788 : STD_LOGIC; 
  signal N44786 : STD_LOGIC; 
  signal N44588 : STD_LOGIC; 
  signal N44586 : STD_LOGIC; 
  signal N44633 : STD_LOGIC; 
  signal N44631 : STD_LOGIC; 
  signal N44613 : STD_LOGIC; 
  signal N44611 : STD_LOGIC; 
  signal N44603 : STD_LOGIC; 
  signal N44601 : STD_LOGIC; 
  signal N44948 : STD_LOGIC; 
  signal N44946 : STD_LOGIC; 
  signal CHOICE2462_F5MUX : STD_LOGIC; 
  signal N44638 : STD_LOGIC; 
  signal N44636 : STD_LOGIC; 
  signal N44678 : STD_LOGIC; 
  signal N44676 : STD_LOGIC; 
  signal N44933 : STD_LOGIC; 
  signal N44931 : STD_LOGIC; 
  signal N44918 : STD_LOGIC; 
  signal N44916 : STD_LOGIC; 
  signal CHOICE2396_F5MUX : STD_LOGIC; 
  signal N44623 : STD_LOGIC; 
  signal N44621 : STD_LOGIC; 
  signal CHOICE2426_F5MUX : STD_LOGIC; 
  signal N44663 : STD_LOGIC; 
  signal N44661 : STD_LOGIC; 
  signal CHOICE2411_F5MUX : STD_LOGIC; 
  signal OUT0_REG_7_OFF_RST : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_lut2_47_FROM : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_lut2_47_CYMUXG : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_lut2_47_XORG : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_lut2_48 : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_cy_56 : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_lut2_47_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_lut2_49 : STD_LOGIC; 
  signal XLXI_1_I4_n0046_2_XORF : STD_LOGIC; 
  signal XLXI_1_I4_n0046_2_CYMUXG : STD_LOGIC; 
  signal XLXI_1_I4_n0046_2_XORG : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_lut2_50 : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_cy_58 : STD_LOGIC; 
  signal XLXI_1_I4_n0046_2_CYINIT : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_lut2_51 : STD_LOGIC; 
  signal XLXI_1_I4_n0046_4_XORF : STD_LOGIC; 
  signal XLXI_1_I4_n0046_4_CYMUXG : STD_LOGIC; 
  signal XLXI_1_I4_n0046_4_XORG : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_lut2_52 : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_cy_60 : STD_LOGIC; 
  signal XLXI_1_I4_n0046_4_CYINIT : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_lut2_53 : STD_LOGIC; 
  signal XLXI_1_I4_n0046_6_XORF : STD_LOGIC; 
  signal XLXI_1_I4_n0046_6_XORG : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_lut2_54 : STD_LOGIC; 
  signal XLXI_1_I4_Madd_n0046_inst_cy_62 : STD_LOGIC; 
  signal XLXI_1_I4_n0046_6_CYINIT : STD_LOGIC; 
  signal XLXI_6_Madd_n0040_inst_lut2_16 : STD_LOGIC; 
  signal XLXI_6_n0040_1_CYMUXG : STD_LOGIC; 
  signal XLXI_6_n0040_1_XORG : STD_LOGIC; 
  signal XLXI_6_n0040_1_GROM : STD_LOGIC; 
  signal XLXI_6_Madd_n0040_inst_cy_16 : STD_LOGIC; 
  signal XLXI_6_n0040_1_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_6_n0040_2_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_6_n0040_2_FROM : STD_LOGIC; 
  signal XLXI_6_n0040_2_XORF : STD_LOGIC; 
  signal XLXI_6_n0040_2_XORG : STD_LOGIC; 
  signal XLXI_6_tx_bit_count_3_rt : STD_LOGIC; 
  signal XLXI_6_Madd_n0040_inst_cy_18 : STD_LOGIC; 
  signal XLXI_6_n0040_2_CYINIT : STD_LOGIC; 
  signal XLXI_5_n0016_0_FROM : STD_LOGIC; 
  signal XLXI_5_n0016_0_XORF : STD_LOGIC; 
  signal XLXI_5_n0016_0_CYMUXG : STD_LOGIC; 
  signal XLXI_5_n0016_0_XORG : STD_LOGIC; 
  signal XLXI_5_Msub_n0016_inst_lut2_9 : STD_LOGIC; 
  signal XLXI_5_Msub_n0016_inst_cy_8 : STD_LOGIC; 
  signal XLXI_5_n0016_0_CYINIT : STD_LOGIC; 
  signal XLXI_5_n0016_0_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_5_Msub_n0016_inst_lut2_10 : STD_LOGIC; 
  signal XLXI_5_n0016_2_XORF : STD_LOGIC; 
  signal XLXI_5_n0016_2_CYMUXG : STD_LOGIC; 
  signal XLXI_5_n0016_2_XORG : STD_LOGIC; 
  signal XLXI_5_Msub_n0016_inst_lut2_11 : STD_LOGIC; 
  signal XLXI_5_Msub_n0016_inst_cy_10 : STD_LOGIC; 
  signal XLXI_5_n0016_2_CYINIT : STD_LOGIC; 
  signal XLXI_5_Msub_n0016_inst_lut2_12 : STD_LOGIC; 
  signal XLXI_5_n0016_4_XORF : STD_LOGIC; 
  signal XLXI_5_n0016_4_CYMUXG : STD_LOGIC; 
  signal XLXI_5_n0016_4_XORG : STD_LOGIC; 
  signal XLXI_5_Msub_n0016_inst_lut2_13 : STD_LOGIC; 
  signal XLXI_5_Msub_n0016_inst_cy_12 : STD_LOGIC; 
  signal XLXI_5_n0016_4_CYINIT : STD_LOGIC; 
  signal XLXI_5_Msub_n0016_inst_lut2_14 : STD_LOGIC; 
  signal XLXI_5_n0016_6_XORF : STD_LOGIC; 
  signal XLXI_5_n0016_6_XORG : STD_LOGIC; 
  signal XLXI_5_Msub_n0016_inst_lut2_15 : STD_LOGIC; 
  signal XLXI_5_Msub_n0016_inst_cy_14 : STD_LOGIC; 
  signal XLXI_5_n0016_6_CYINIT : STD_LOGIC; 
  signal XLXI_6_Madd_n0041_inst_lut2_16 : STD_LOGIC; 
  signal XLXI_6_n0041_1_CYMUXG : STD_LOGIC; 
  signal XLXI_6_n0041_1_XORG : STD_LOGIC; 
  signal XLXI_6_n0041_1_GROM : STD_LOGIC; 
  signal XLXI_6_Madd_n0041_inst_cy_16 : STD_LOGIC; 
  signal XLXI_6_n0041_1_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_6_n0041_2_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_6_n0041_2_FROM : STD_LOGIC; 
  signal XLXI_6_n0041_2_XORF : STD_LOGIC; 
  signal XLXI_6_n0041_2_XORG : STD_LOGIC; 
  signal XLXI_6_tx_16_count_3_rt : STD_LOGIC; 
  signal XLXI_6_Madd_n0041_inst_cy_18 : STD_LOGIC; 
  signal XLXI_6_n0041_2_CYINIT : STD_LOGIC; 
  signal XLXI_1_I3_n0066_0_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n0066_0_XORF : STD_LOGIC; 
  signal XLXI_1_I3_n0066_0_CYMUXG : STD_LOGIC; 
  signal XLXI_1_I3_n0066_0_XORG : STD_LOGIC; 
  signal XLXI_1_I3_n0066_0_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Msub_n0066_inst_cy_47 : STD_LOGIC; 
  signal XLXI_1_I3_n0066_0_CYINIT : STD_LOGIC; 
  signal XLXI_1_I3_n0066_0_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_1_I3_n0066_2_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n0066_2_XORF : STD_LOGIC; 
  signal XLXI_1_I3_n0066_2_CYMUXG : STD_LOGIC; 
  signal XLXI_1_I3_n0066_2_XORG : STD_LOGIC; 
  signal XLXI_1_I3_n0066_2_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Msub_n0066_inst_cy_49 : STD_LOGIC; 
  signal XLXI_1_I3_n0066_2_CYINIT : STD_LOGIC; 
  signal XLXI_1_I3_n0066_4_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n0066_4_XORF : STD_LOGIC; 
  signal XLXI_1_I3_n0066_4_CYMUXG : STD_LOGIC; 
  signal XLXI_1_I3_n0066_4_XORG : STD_LOGIC; 
  signal XLXI_1_I3_n0066_4_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Msub_n0066_inst_cy_51 : STD_LOGIC; 
  signal XLXI_1_I3_n0066_4_CYINIT : STD_LOGIC; 
  signal XLXI_1_I3_n0066_6_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n0066_6_XORF : STD_LOGIC; 
  signal XLXI_1_I3_n0066_6_CYMUXG : STD_LOGIC; 
  signal XLXI_1_I3_n0066_6_XORG : STD_LOGIC; 
  signal XLXI_1_I3_n0066_6_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Msub_n0066_inst_cy_53 : STD_LOGIC; 
  signal XLXI_1_I3_n0066_6_CYINIT : STD_LOGIC; 
  signal XLXI_1_I3_n0066_8_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n0066_8_XORF : STD_LOGIC; 
  signal XLXI_1_I3_n0066_8_CYINIT : STD_LOGIC; 
  signal XLXI_6_n0059 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_0_CYMUXG : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_0_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_lut3_0 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_cy_20 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_0_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_sum_20 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_lut3_1 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_sum_21 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_1_CYMUXG : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_1_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_lut3_2 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_cy_22 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_1_CYINIT : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_sum_22 : STD_LOGIC; 
  signal OUT1_REG_0_OFF_RST : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_lut3_3 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_sum_23 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_3_CYMUXG : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_3_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_lut3_4 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_cy_24 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_3_CYINIT : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_sum_24 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_lut3_5 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_sum_25 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_5_CYMUXG : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_5_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_lut3_6 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_cy_26 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_5_CYINIT : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_sum_26 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_lut3_7 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_inst_sum_27 : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_7_CYINIT : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_n0014_7_1_O : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_30_rt : STD_LOGIC; 
  signal XLXI_1_I3_n0074_1_CYMUXG : STD_LOGIC; 
  signal XLXI_1_I3_n0074_1_XORG : STD_LOGIC; 
  signal XLXI_1_I3_n0074_1_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_cy_39 : STD_LOGIC; 
  signal XLXI_1_I3_n0074_1_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_1_I3_n0074_2_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n0074_2_XORF : STD_LOGIC; 
  signal XLXI_1_I3_n0074_2_CYMUXG : STD_LOGIC; 
  signal XLXI_1_I3_n0074_2_XORG : STD_LOGIC; 
  signal XLXI_1_I3_n0074_2_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_cy_41 : STD_LOGIC; 
  signal XLXI_1_I3_n0074_2_CYINIT : STD_LOGIC; 
  signal XLXI_1_I3_n0074_4_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n0074_4_XORF : STD_LOGIC; 
  signal XLXI_1_I3_n0074_4_CYMUXG : STD_LOGIC; 
  signal XLXI_1_I3_n0074_4_XORG : STD_LOGIC; 
  signal XLXI_1_I3_n0074_4_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_cy_43 : STD_LOGIC; 
  signal XLXI_1_I3_n0074_4_CYINIT : STD_LOGIC; 
  signal XLXI_1_I3_n0074_6_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n0074_6_XORF : STD_LOGIC; 
  signal XLXI_1_I3_n0074_6_CYMUXG : STD_LOGIC; 
  signal XLXI_1_I3_n0074_6_XORG : STD_LOGIC; 
  signal XLXI_1_I3_n0074_6_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_cy_45 : STD_LOGIC; 
  signal XLXI_1_I3_n0074_6_CYINIT : STD_LOGIC; 
  signal XLXI_26_Madd_n0060_inst_lut2_16 : STD_LOGIC; 
  signal XLXI_26_n0060_1_CYMUXG : STD_LOGIC; 
  signal XLXI_26_n0060_1_XORG : STD_LOGIC; 
  signal XLXI_26_n0060_1_GROM : STD_LOGIC; 
  signal XLXI_26_Madd_n0060_inst_cy_16 : STD_LOGIC; 
  signal XLXI_26_n0060_1_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_26_n0060_2_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_26_n0060_2_FROM : STD_LOGIC; 
  signal XLXI_26_n0060_2_XORF : STD_LOGIC; 
  signal XLXI_26_n0060_2_XORG : STD_LOGIC; 
  signal XLXI_26_rx_8_count_3_rt : STD_LOGIC; 
  signal XLXI_26_Madd_n0060_inst_cy_18 : STD_LOGIC; 
  signal XLXI_26_n0060_2_CYINIT : STD_LOGIC; 
  signal XLXI_26_Madd_n0061_inst_lut2_16 : STD_LOGIC; 
  signal XLXI_26_n0061_1_CYMUXG : STD_LOGIC; 
  signal XLXI_26_n0061_1_XORG : STD_LOGIC; 
  signal XLXI_26_n0061_1_GROM : STD_LOGIC; 
  signal XLXI_26_Madd_n0061_inst_cy_16 : STD_LOGIC; 
  signal XLXI_26_n0061_1_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_26_n0061_2_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_26_n0061_2_FROM : STD_LOGIC; 
  signal XLXI_26_n0061_2_XORF : STD_LOGIC; 
  signal XLXI_26_n0061_2_XORG : STD_LOGIC; 
  signal XLXI_26_rx_16_count_3_rt : STD_LOGIC; 
  signal XLXI_26_Madd_n0061_inst_cy_18 : STD_LOGIC; 
  signal XLXI_26_n0061_2_CYINIT : STD_LOGIC; 
  signal XLXI_1_I1_Madd_n0024_inst_lut2_20 : STD_LOGIC; 
  signal XLXI_1_I1_n0024_1_CYMUXG : STD_LOGIC; 
  signal XLXI_1_I1_n0024_1_XORG : STD_LOGIC; 
  signal XLXI_1_I1_n0024_1_GROM : STD_LOGIC; 
  signal XLXI_1_I1_Madd_n0024_inst_cy_29 : STD_LOGIC; 
  signal XLXI_1_I1_n0024_1_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_1_I1_n0024_2_FROM : STD_LOGIC; 
  signal XLXI_1_I1_n0024_2_XORF : STD_LOGIC; 
  signal XLXI_1_I1_n0024_2_CYMUXG : STD_LOGIC; 
  signal XLXI_1_I1_n0024_2_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_1_I1_n0024_2_XORG : STD_LOGIC; 
  signal XLXI_1_I1_n0024_2_GROM : STD_LOGIC; 
  signal XLXI_1_I1_Madd_n0024_inst_cy_31 : STD_LOGIC; 
  signal XLXI_1_I1_n0024_2_CYINIT : STD_LOGIC; 
  signal XLXI_1_I1_n0024_4_FROM : STD_LOGIC; 
  signal XLXI_1_I1_n0024_4_XORF : STD_LOGIC; 
  signal XLXI_1_I1_n0024_4_CYMUXG : STD_LOGIC; 
  signal XLXI_1_I1_n0024_4_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_1_I1_n0024_4_XORG : STD_LOGIC; 
  signal XLXI_1_I1_n0024_4_GROM : STD_LOGIC; 
  signal XLXI_1_I1_Madd_n0024_inst_cy_33 : STD_LOGIC; 
  signal XLXI_1_I1_n0024_4_CYINIT : STD_LOGIC; 
  signal XLXI_1_I1_n0024_6_FROM : STD_LOGIC; 
  signal XLXI_1_I1_n0024_6_XORF : STD_LOGIC; 
  signal XLXI_1_I1_n0024_6_CYMUXG : STD_LOGIC; 
  signal XLXI_1_I1_n0024_6_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_1_I1_n0024_6_XORG : STD_LOGIC; 
  signal XLXI_1_I1_n0024_6_GROM : STD_LOGIC; 
  signal XLXI_1_I1_Madd_n0024_inst_cy_35 : STD_LOGIC; 
  signal XLXI_1_I1_n0024_6_CYINIT : STD_LOGIC; 
  signal XLXI_1_I1_n0024_8_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_1_I1_n0024_8_FROM : STD_LOGIC; 
  signal XLXI_1_I1_n0024_8_XORF : STD_LOGIC; 
  signal XLXI_1_I1_n0024_8_XORG : STD_LOGIC; 
  signal XLXI_1_I1_pc_9_rt : STD_LOGIC; 
  signal XLXI_1_I1_Madd_n0024_inst_cy_37 : STD_LOGIC; 
  signal XLXI_1_I1_n0024_8_CYINIT : STD_LOGIC; 
  signal XLXI_5_Madd_n0017_inst_lut2_0 : STD_LOGIC; 
  signal XLXI_5_n0017_1_CYMUXG : STD_LOGIC; 
  signal XLXI_5_n0017_1_XORG : STD_LOGIC; 
  signal XLXI_5_n0017_1_GROM : STD_LOGIC; 
  signal XLXI_5_Madd_n0017_inst_cy_0 : STD_LOGIC; 
  signal XLXI_5_n0017_1_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_5_n0017_2_FROM : STD_LOGIC; 
  signal XLXI_5_n0017_2_XORF : STD_LOGIC; 
  signal XLXI_5_n0017_2_CYMUXG : STD_LOGIC; 
  signal XLXI_5_n0017_2_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_5_n0017_2_XORG : STD_LOGIC; 
  signal XLXI_5_n0017_2_GROM : STD_LOGIC; 
  signal XLXI_5_Madd_n0017_inst_cy_2 : STD_LOGIC; 
  signal XLXI_5_n0017_2_CYINIT : STD_LOGIC; 
  signal XLXI_5_n0017_4_FROM : STD_LOGIC; 
  signal XLXI_5_n0017_4_XORF : STD_LOGIC; 
  signal XLXI_5_n0017_4_CYMUXG : STD_LOGIC; 
  signal XLXI_5_n0017_4_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_5_n0017_4_XORG : STD_LOGIC; 
  signal XLXI_5_n0017_4_GROM : STD_LOGIC; 
  signal XLXI_5_Madd_n0017_inst_cy_4 : STD_LOGIC; 
  signal XLXI_5_n0017_4_CYINIT : STD_LOGIC; 
  signal OUT1_REG_1_OFF_RST : STD_LOGIC; 
  signal XLXI_5_n0017_6_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_5_n0017_6_FROM : STD_LOGIC; 
  signal XLXI_5_n0017_6_XORF : STD_LOGIC; 
  signal XLXI_5_n0017_6_XORG : STD_LOGIC; 
  signal XLXI_5_tmr_low_7_rt : STD_LOGIC; 
  signal XLXI_5_Madd_n0017_inst_cy_6 : STD_LOGIC; 
  signal XLXI_5_n0017_6_CYINIT : STD_LOGIC; 
  signal XLXI_26_n0097 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_0_CYMUXG : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_0_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_lut3_0 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_cy_20 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_0_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_sum_20 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_lut3_1 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_sum_21 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_1_CYMUXG : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_1_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_lut3_2 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_cy_22 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_1_CYINIT : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_sum_22 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_lut3_3 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_sum_23 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_3_CYMUXG : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_3_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_lut3_4 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_cy_24 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_3_CYINIT : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_sum_24 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_lut3_5 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_sum_25 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_5_CYMUXG : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_5_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_lut3_6 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_cy_26 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_5_CYINIT : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_sum_26 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_lut3_7 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_inst_sum_27 : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_7_CYINIT : STD_LOGIC; 
  signal XLXI_26_Madd_n0058_inst_lut2_16 : STD_LOGIC; 
  signal XLXI_26_n0058_1_CYMUXG : STD_LOGIC; 
  signal XLXI_26_n0058_1_XORG : STD_LOGIC; 
  signal XLXI_26_n0058_1_GROM : STD_LOGIC; 
  signal XLXI_26_Madd_n0058_inst_cy_16 : STD_LOGIC; 
  signal XLXI_26_n0058_1_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_26_n0058_2_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_26_n0058_2_FROM : STD_LOGIC; 
  signal XLXI_26_n0058_2_XORF : STD_LOGIC; 
  signal XLXI_26_n0058_2_XORG : STD_LOGIC; 
  signal XLXI_26_rx_bit_count_3_rt : STD_LOGIC; 
  signal XLXI_26_Madd_n0058_inst_cy_18 : STD_LOGIC; 
  signal XLXI_26_n0058_2_CYINIT : STD_LOGIC; 
  signal XLXI_26_Madd_n0059_inst_lut2_16 : STD_LOGIC; 
  signal XLXI_26_n0059_1_CYMUXG : STD_LOGIC; 
  signal XLXI_26_n0059_1_XORG : STD_LOGIC; 
  signal XLXI_26_n0059_1_GROM : STD_LOGIC; 
  signal XLXI_26_Madd_n0059_inst_cy_16 : STD_LOGIC; 
  signal XLXI_26_n0059_1_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_26_n0059_2_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_26_n0059_2_FROM : STD_LOGIC; 
  signal XLXI_26_n0059_2_XORF : STD_LOGIC; 
  signal XLXI_26_n0059_2_XORG : STD_LOGIC; 
  signal XLXI_26_rx_8z_count_3_rt : STD_LOGIC; 
  signal XLXI_26_Madd_n0059_inst_cy_18 : STD_LOGIC; 
  signal XLXI_26_n0059_2_CYINIT : STD_LOGIC; 
  signal XLXI_1_I1_pc_6_FROM : STD_LOGIC; 
  signal XLXI_1_I1_pc_6_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I1_pc_6_GROM : STD_LOGIC; 
  signal XLXI_1_I1_pc_7_FROM : STD_LOGIC; 
  signal XLXI_1_I1_pc_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I1_pc_7_GROM : STD_LOGIC; 
  signal XLXI_1_I2_N18996_FROM : STD_LOGIC; 
  signal XLXI_1_I2_N18996_GROM : STD_LOGIC; 
  signal XLXI_1_I1_pc_8_FROM : STD_LOGIC; 
  signal XLXI_1_I1_pc_8_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I1_pc_8_GROM : STD_LOGIC; 
  signal XLXI_1_I1_pc_9_FROM : STD_LOGIC; 
  signal XLXI_1_I1_pc_9_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I1_pc_9_GROM : STD_LOGIC; 
  signal XLXI_1_I3_skip_l62_O_FROM : STD_LOGIC; 
  signal XLXI_1_I3_skip_l62_O_GROM : STD_LOGIC; 
  signal XLXI_1_I3_skip_l86_SW1_SW0_O_FROM : STD_LOGIC; 
  signal XLXI_1_I3_skip_l86_SW1_SW0_O_GROM : STD_LOGIC; 
  signal XLXI_1_I2_ndre_x1_1_FROM : STD_LOGIC; 
  signal XLXI_1_I2_ndre_x1_1_GROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_4_FROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_4_GROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_4_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal OUT1_REG_2_OFF_RST : STD_LOGIC; 
  signal XLXI_6_tx_uart_busy_FROM : STD_LOGIC; 
  signal XLXI_6_tx_uart_busy_GROM : STD_LOGIC; 
  signal XLXI_6_tx_uart_busy_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_55_mux_c_1_FROM : STD_LOGIC; 
  signal XLXI_55_mux_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_55_mux_x_1_1_O : STD_LOGIC; 
  signal XLXI_1_I5_Mmux_daddr_out_Result_0_1_1_FROM : STD_LOGIC; 
  signal XLXI_1_I5_Mmux_daddr_out_Result_0_1_1_GROM : STD_LOGIC; 
  signal XLXI_55_nCS_REG_SW10_SW1_O_FROM : STD_LOGIC; 
  signal XLXI_55_nCS_REG_SW10_SW1_O_GROM : STD_LOGIC; 
  signal nCS_REG_FROM : STD_LOGIC; 
  signal nCS_REG_GROM : STD_LOGIC; 
  signal CHOICE2853_FROM : STD_LOGIC; 
  signal CHOICE2853_GROM : STD_LOGIC; 
  signal XLXI_1_I3_data_x_1_FROM : STD_LOGIC; 
  signal XLXI_1_I3_data_x_1_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_30_FROM : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_30_GROM : STD_LOGIC; 
  signal CHOICE2789_FROM : STD_LOGIC; 
  signal CHOICE2789_GROM : STD_LOGIC; 
  signal CHOICE2692_FROM : STD_LOGIC; 
  signal CHOICE2692_GROM : STD_LOGIC; 
  signal CHOICE2628_FROM : STD_LOGIC; 
  signal CHOICE2628_GROM : STD_LOGIC; 
  signal CHOICE2564_FROM : STD_LOGIC; 
  signal CHOICE2564_GROM : STD_LOGIC; 
  signal OUT1_REG_5_OFF_RST : STD_LOGIC; 
  signal XLXI_1_I3_data_x_2_FROM : STD_LOGIC; 
  signal XLXI_1_I3_data_x_2_GROM : STD_LOGIC; 
  signal CHOICE2500_FROM : STD_LOGIC; 
  signal CHOICE2500_GROM : STD_LOGIC; 
  signal XLXI_1_I3_n0115_1_29_O_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n0115_1_29_O_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Mmux_data_x_Result_0_59_SW0_O_FROM : STD_LOGIC; 
  signal XLXI_1_I3_Mmux_data_x_Result_0_59_SW0_O_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Mmux_data_x_Result_1_59_SW1_O_FROM : STD_LOGIC; 
  signal XLXI_1_I3_Mmux_data_x_Result_1_59_SW1_O_GROM : STD_LOGIC; 
  signal XLXI_1_I3_data_x_3_FROM : STD_LOGIC; 
  signal XLXI_1_I3_data_x_3_GROM : STD_LOGIC; 
  signal XLXI_1_I3_n0115_2_19_O_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n0115_2_19_O_GROM : STD_LOGIC; 
  signal XLXI_1_I3_n007212_O_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n007212_O_GROM : STD_LOGIC; 
  signal XLXI_1_I3_data_x_4_FROM : STD_LOGIC; 
  signal XLXI_1_I3_data_x_4_GROM : STD_LOGIC; 
  signal XLXI_1_I3_data_x_5_FROM : STD_LOGIC; 
  signal XLXI_1_I3_data_x_5_GROM : STD_LOGIC; 
  signal XLXI_1_I3_data_x_6_FROM : STD_LOGIC; 
  signal XLXI_1_I3_data_x_6_GROM : STD_LOGIC; 
  signal XLXI_1_I3_data_x_7_FROM : STD_LOGIC; 
  signal XLXI_1_I3_data_x_7_GROM : STD_LOGIC; 
  signal CHOICE2996_FROM : STD_LOGIC; 
  signal CHOICE2996_GROM : STD_LOGIC; 
  signal XLXI_4_n0003_1_1_O : STD_LOGIC; 
  signal XLXI_4_int_clr_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_4_n0003_0_1_O : STD_LOGIC; 
  signal XLXI_4_n0003_3_1_O : STD_LOGIC; 
  signal XLXI_4_int_clr_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_4_n0003_2_1_O : STD_LOGIC; 
  signal XLXI_4_n0003_5_1_O : STD_LOGIC; 
  signal XLXI_4_int_clr_c_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_4_n0003_4_1_O : STD_LOGIC; 
  signal XLXI_4_n0003_7_1_O : STD_LOGIC; 
  signal XLXI_4_int_clr_c_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_4_n0003_6_1_O : STD_LOGIC; 
  signal OUT1_REG_6_OFF_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I4_iinc_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I4_iinc_c_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I4_iinc_c_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_s_FFd1_FROM : STD_LOGIC; 
  signal XLXI_26_rx_s_FFd1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_s_FFd1_In : STD_LOGIC; 
  signal XLXI_1_I4_iinc_i_3_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_i_7_FROM : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_1_FROM : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_1_GROM : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_3_FROM : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_3_GROM : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_5_FROM : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_5_GROM : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_7_FROM : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_7_GROM : STD_LOGIC; 
  signal XLXI_1_I2_TC_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I2_TC_c_1_GROM : STD_LOGIC; 
  signal OUT1_REG_7_OFF_RST : STD_LOGIC; 
  signal XLXI_26_rx_uart_full_s_FROM : STD_LOGIC; 
  signal XLXI_26_rx_uart_full_s_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_n0036 : STD_LOGIC; 
  signal XLXI_5_tmr_low_1_FFY_RST : STD_LOGIC; 
  signal XLXI_5_tmr_low_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I4_ireg_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I2_int_stop_c_FROM : STD_LOGIC; 
  signal XLXI_1_I2_int_stop_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_5_tmr_low_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I4_ireg_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_5_tmr_int_x_FROM : STD_LOGIC; 
  signal XLXI_5_tmr_int_x_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_5_n0019 : STD_LOGIC; 
  signal XLXI_5_tmr_low_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I4_ireg_c_4_FROM : STD_LOGIC; 
  signal XLXI_1_I4_ireg_c_4_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_5_tmr_low_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I4_ireg_c_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I4_iinc_we_c_FROM : STD_LOGIC; 
  signal XLXI_1_I4_iinc_we_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I4_iinc_we_x : STD_LOGIC; 
  signal XLXI_26_rx_bit_count_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_bit_count_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I5_ndwe_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_nadwe_out : STD_LOGIC; 
  signal XLXI_1_I2_valid_c_FROM : STD_LOGIC; 
  signal XLXI_1_I2_valid_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I2_valid_x : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_1_FROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_1_GROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_5_FROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_5_GROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_6_FROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_6_GROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_6_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_7_FROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_7_GROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_8_FROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_8_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_8_GROM : STD_LOGIC; 
  signal XLXI_26_rx_8z_count_0_FROM : STD_LOGIC; 
  signal XLXI_26_rx_8z_count_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_8z_count_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal RXD_IFF_SET : STD_LOGIC; 
  signal XLXI_1_I1_nreset_v_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I2_nreset_v_0_FROM : STD_LOGIC; 
  signal XLXI_1_I2_nreset_v_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I2_int_start_c_FROM : STD_LOGIC; 
  signal XLXI_1_I2_int_start_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I2_int_start_c_GROM : STD_LOGIC; 
  signal TXD_OFF_SET : STD_LOGIC; 
  signal XLXI_1_I3_nreset_v_0_FROM : STD_LOGIC; 
  signal XLXI_1_I3_nreset_v_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_4_int_pending_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_4_int_pending_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_4_int_pending_c_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_4_int_pending_c_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I4_nreset_v_0_FROM : STD_LOGIC; 
  signal XLXI_1_I4_nreset_v_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_tx_bit_count_0_FROM : STD_LOGIC; 
  signal XLXI_6_tx_bit_count_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_tx_bit_count_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_8_count_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_16_count_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_1_CKMUXNOT : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_3_FROM : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_3_CKMUXNOT : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_5_CKMUXNOT : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_7_CKMUXNOT : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_9_CKMUXNOT : STD_LOGIC; 
  signal XLXI_4_int_masked_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_4_int_masked_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_4_int_masked_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_4_int_masked_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I2_S_c_2_FROM : STD_LOGIC; 
  signal XLXI_1_I2_S_c_2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_8_count_3_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_8_count_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal N43276_FROM : STD_LOGIC; 
  signal N43276_GROM : STD_LOGIC; 
  signal N43800_FROM : STD_LOGIC; 
  signal N43800_GROM : STD_LOGIC; 
  signal CHOICE2315_FROM : STD_LOGIC; 
  signal CHOICE2315_GROM : STD_LOGIC; 
  signal CHOICE2856_FROM : STD_LOGIC; 
  signal CHOICE2856_GROM : STD_LOGIC; 
  signal CHOICE2349_FROM : STD_LOGIC; 
  signal CHOICE2349_GROM : STD_LOGIC; 
  signal N43439_FROM : STD_LOGIC; 
  signal N43439_GROM : STD_LOGIC; 
  signal CHOICE2332_FROM : STD_LOGIC; 
  signal CHOICE2332_GROM : STD_LOGIC; 
  signal N43992_FROM : STD_LOGIC; 
  signal N43992_GROM : STD_LOGIC; 
  signal XLXI_26_rx_s_FFd2_FROM : STD_LOGIC; 
  signal XLXI_26_rx_s_FFd2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_s_FFd2_In : STD_LOGIC; 
  signal XLXI_26_rx_uart_reg_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_uart_reg_1_FFY_SET : STD_LOGIC; 
  signal XLXI_26_rx_uart_reg_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I3_n0025_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n0025_GROM : STD_LOGIC; 
  signal XLXI_26_rx_uart_reg_2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_uart_reg_3_FFY_SET : STD_LOGIC; 
  signal XLXI_26_rx_uart_reg_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_uart_reg_4_FFY_SET : STD_LOGIC; 
  signal XLXI_26_rx_uart_reg_4_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_uart_reg_5_FFY_SET : STD_LOGIC; 
  signal XLXI_26_rx_uart_reg_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_uart_reg_6_FFY_SET : STD_LOGIC; 
  signal XLXI_26_rx_uart_reg_6_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_uart_reg_7_FFY_SET : STD_LOGIC; 
  signal XLXI_26_rx_uart_reg_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I3_n0057_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n0057_GROM : STD_LOGIC; 
  signal XLXI_1_I3_N20010_FROM : STD_LOGIC; 
  signal XLXI_1_I3_N20010_GROM : STD_LOGIC; 
  signal XLXI_1_I3_n0063_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n0063_GROM : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_0_79_4_FROM : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_0_79_4_GROM : STD_LOGIC; 
  signal XLXI_1_I3_n0058_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n0058_GROM : STD_LOGIC; 
  signal CHOICE2567_FROM : STD_LOGIC; 
  signal CHOICE2567_GROM : STD_LOGIC; 
  signal XLXI_1_I3_N20052_FROM : STD_LOGIC; 
  signal XLXI_1_I3_N20052_GROM : STD_LOGIC; 
  signal N43386_FROM : STD_LOGIC; 
  signal N43386_GROM : STD_LOGIC; 
  signal XLXI_1_I3_n0076_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n0076_GROM : STD_LOGIC; 
  signal N43318_FROM : STD_LOGIC; 
  signal N43318_GROM : STD_LOGIC; 
  signal CHOICE2601_FROM : STD_LOGIC; 
  signal CHOICE2601_GROM : STD_LOGIC; 
  signal N28941_FROM : STD_LOGIC; 
  signal N28941_GROM : STD_LOGIC; 
  signal N43270_FROM : STD_LOGIC; 
  signal N43270_GROM : STD_LOGIC; 
  signal N43804_FROM : STD_LOGIC; 
  signal N43804_GROM : STD_LOGIC; 
  signal XLXI_26_n0030_FROM : STD_LOGIC; 
  signal XLXI_26_n0030_GROM : STD_LOGIC; 
  signal N29274_FROM : STD_LOGIC; 
  signal N29274_GROM : STD_LOGIC; 
  signal XLXI_26_rx_s_FFd3_FROM : STD_LOGIC; 
  signal XLXI_26_rx_s_FFd3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_s_FFd3_In : STD_LOGIC; 
  signal N43090_FROM : STD_LOGIC; 
  signal N43090_GROM : STD_LOGIC; 
  signal CHOICE2923_FROM : STD_LOGIC; 
  signal CHOICE2923_GROM : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_0_79_3_FROM : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_0_79_3_GROM : STD_LOGIC; 
  signal N43150_FROM : STD_LOGIC; 
  signal N43150_GROM : STD_LOGIC; 
  signal CHOICE2370_FROM : STD_LOGIC; 
  signal CHOICE2370_GROM : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_4_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_0_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_5_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_6_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_2_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_3_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_7_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_5_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_9_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_6_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_2_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_3_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_7_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_8_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_9_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_0_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_2_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_3_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_ireg_i_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_ireg_i_7_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_ireg_i_2_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_ireg_i_3_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_ireg_i_4_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_ireg_i_5_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_0_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_ireg_i_6_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_7_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_3_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_4_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_8_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_0_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_9_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_5_FFX_RST : STD_LOGIC; 
  signal XLXI_26_n0118_FROM : STD_LOGIC; 
  signal XLXI_26_n0118_GROM : STD_LOGIC; 
  signal N43306_FROM : STD_LOGIC; 
  signal N43306_GROM : STD_LOGIC; 
  signal XLXI_5_tmr_high_0_FROM : STD_LOGIC; 
  signal XLXI_5_tmr_high_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal CHOICE2537_FROM : STD_LOGIC; 
  signal CHOICE2537_GROM : STD_LOGIC; 
  signal CHOICE1007_FROM : STD_LOGIC; 
  signal CHOICE1007_GROM : STD_LOGIC; 
  signal N43216_FROM : STD_LOGIC; 
  signal N43216_GROM : STD_LOGIC; 
  signal N43222_FROM : STD_LOGIC; 
  signal N43222_GROM : STD_LOGIC; 
  signal XLXI_5_tmr_high_1_FROM : STD_LOGIC; 
  signal XLXI_5_tmr_high_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal CHOICE921_FROM : STD_LOGIC; 
  signal CHOICE921_GROM : STD_LOGIC; 
  signal XLXI_5_tmr_high_2_FROM : STD_LOGIC; 
  signal XLXI_5_tmr_high_2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_5_tmr_high_3_FROM : STD_LOGIC; 
  signal XLXI_5_tmr_high_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_uart_ovr_d_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal CHOICE992_FROM : STD_LOGIC; 
  signal CHOICE992_GROM : STD_LOGIC; 
  signal XLXI_5_tmr_high_4_FROM : STD_LOGIC; 
  signal XLXI_5_tmr_high_4_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal CHOICE1073_FROM : STD_LOGIC; 
  signal CHOICE1073_GROM : STD_LOGIC; 
  signal XLXI_5_tmr_high_5_FROM : STD_LOGIC; 
  signal XLXI_5_tmr_high_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal CHOICE1061_FROM : STD_LOGIC; 
  signal CHOICE1061_GROM : STD_LOGIC; 
  signal N29051_FROM : STD_LOGIC; 
  signal N29051_GROM : STD_LOGIC; 
  signal XLXI_5_n0030_FROM : STD_LOGIC; 
  signal XLXI_5_n0030_GROM : STD_LOGIC; 
  signal N43264_FROM : STD_LOGIC; 
  signal N43264_GROM : STD_LOGIC; 
  signal N43796_FROM : STD_LOGIC; 
  signal N43796_GROM : STD_LOGIC; 
  signal XLXI_5_tmr_high_6_FROM : STD_LOGIC; 
  signal XLXI_5_tmr_high_6_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_uart_full_d_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_5_tmr_high_7_FROM : STD_LOGIC; 
  signal XLXI_5_tmr_high_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal N29124_GROM : STD_LOGIC; 
  signal XLXI_1_I4_n0033_GROM : STD_LOGIC; 
  signal XLXI_6_n0007_FROM : STD_LOGIC; 
  signal XLXI_6_n0007_GROM : STD_LOGIC; 
  signal CHOICE2606_FROM : STD_LOGIC; 
  signal CHOICE2606_GROM : STD_LOGIC; 
  signal CHOICE1111_FROM : STD_LOGIC; 
  signal CHOICE1111_GROM : STD_LOGIC; 
  signal N43118_FROM : STD_LOGIC; 
  signal N43118_GROM : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_0_79_2_FROM : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_0_79_2_GROM : STD_LOGIC; 
  signal N43122_FROM : STD_LOGIC; 
  signal N43122_GROM : STD_LOGIC; 
  signal N43497_FROM : STD_LOGIC; 
  signal N43497_GROM : STD_LOGIC; 
  signal N43410_FROM : STD_LOGIC; 
  signal N43410_GROM : STD_LOGIC; 
  signal CHOICE2473_FROM : STD_LOGIC; 
  signal CHOICE2473_GROM : STD_LOGIC; 
  signal N44420_FROM : STD_LOGIC; 
  signal N44420_GROM : STD_LOGIC; 
  signal CHOICE2993_FROM : STD_LOGIC; 
  signal CHOICE2993_GROM : STD_LOGIC; 
  signal XLXI_6_tx_uart_fifo_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_tx_uart_fifo_3_FFY_SET : STD_LOGIC; 
  signal XLXI_6_tx_uart_fifo_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_tx_uart_fifo_5_FFY_SET : STD_LOGIC; 
  signal XLXI_6_tx_uart_fifo_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal N43499_FROM : STD_LOGIC; 
  signal N43499_GROM : STD_LOGIC; 
  signal XLXI_6_tx_uart_fifo_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal CHOICE1017_GROM : STD_LOGIC; 
  signal CHOICE1024_FROM : STD_LOGIC; 
  signal CHOICE1024_GROM : STD_LOGIC; 
  signal XLXI_6_n0028_FROM : STD_LOGIC; 
  signal XLXI_6_n0028_GROM : STD_LOGIC; 
  signal CHOICE2914_FROM : STD_LOGIC; 
  signal CHOICE2914_GROM : STD_LOGIC; 
  signal N43138_FROM : STD_LOGIC; 
  signal N43138_GROM : STD_LOGIC; 
  signal N43258_FROM : STD_LOGIC; 
  signal N43258_GROM : STD_LOGIC; 
  signal nWE_RAM_FROM : STD_LOGIC; 
  signal nWE_RAM_GROM : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_0_FROM : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_0_GROM : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_2_FROM : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_2_GROM : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_4_FROM : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_4_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_4_GROM : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_8_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal N28888_FROM : STD_LOGIC; 
  signal N28888_GROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_2_FROM : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I3_skip_i_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I4_ireg_we_c_FROM : STD_LOGIC; 
  signal XLXI_1_I4_ireg_we_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I4_ireg_we_x : STD_LOGIC; 
  signal XLXI_1_I3_n00231_1_FROM : STD_LOGIC; 
  signal XLXI_1_I3_n00231_1_GROM : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_1_38_2_FROM : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_1_38_2_GROM : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_1_38_3_FROM : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_1_38_3_GROM : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_1_38_4_GROM : STD_LOGIC; 
  signal N44532_FROM : STD_LOGIC; 
  signal N44532_GROM : STD_LOGIC; 
  signal N44528_FROM : STD_LOGIC; 
  signal N44528_GROM : STD_LOGIC; 
  signal N43198_FROM : STD_LOGIC; 
  signal N43198_GROM : STD_LOGIC; 
  signal N43180_FROM : STD_LOGIC; 
  signal N43180_GROM : STD_LOGIC; 
  signal CHOICE630_FROM : STD_LOGIC; 
  signal CHOICE630_GROM : STD_LOGIC; 
  signal N43426_GROM : STD_LOGIC; 
  signal CHOICE603_FROM : STD_LOGIC; 
  signal CHOICE603_GROM : STD_LOGIC; 
  signal N43142_FROM : STD_LOGIC; 
  signal N43142_GROM : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_3_FROM : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_3_GROM : STD_LOGIC; 
  signal CHOICE2984_FROM : STD_LOGIC; 
  signal CHOICE2984_GROM : STD_LOGIC; 
  signal CHOICE612_FROM : STD_LOGIC; 
  signal CHOICE612_GROM : STD_LOGIC; 
  signal CHOICE2841_FROM : STD_LOGIC; 
  signal CHOICE2841_GROM : STD_LOGIC; 
  signal N43244_FROM : STD_LOGIC; 
  signal N43244_GROM : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_6_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_6_FROM : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_6_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_6_GROM : STD_LOGIC; 
  signal XLXI_5_tmr_count_3_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_N18884_FROM : STD_LOGIC; 
  signal XLXI_1_I2_N18884_GROM : STD_LOGIC; 
  signal XLXI_1_I4_iinc_i_6_FROM : STD_LOGIC; 
  signal CHOICE2616_FROM : STD_LOGIC; 
  signal CHOICE2616_GROM : STD_LOGIC; 
  signal N43443_FROM : STD_LOGIC; 
  signal N43443_GROM : STD_LOGIC; 
  signal N43094_FROM : STD_LOGIC; 
  signal N43094_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_31_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_32_GROM : STD_LOGIC; 
  signal CHOICE1070_FROM : STD_LOGIC; 
  signal CHOICE1070_GROM : STD_LOGIC; 
  signal CHOICE585_FROM : STD_LOGIC; 
  signal CHOICE585_GROM : STD_LOGIC; 
  signal CHOICE2678_FROM : STD_LOGIC; 
  signal CHOICE2678_GROM : STD_LOGIC; 
  signal N43252_FROM : STD_LOGIC; 
  signal N43252_GROM : STD_LOGIC; 
  signal CHOICE2488_FROM : STD_LOGIC; 
  signal CHOICE2488_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_33_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_34_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_35_GROM : STD_LOGIC; 
  signal CHOICE2689_FROM : STD_LOGIC; 
  signal CHOICE2689_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_36_GROM : STD_LOGIC; 
  signal XLXI_1_I3_N19856_FROM : STD_LOGIC; 
  signal XLXI_1_I3_N19856_GROM : STD_LOGIC; 
  signal XLXI_1_I3_Madd_n0074_inst_lut2_37_GROM : STD_LOGIC; 
  signal XLXI_1_I3_N19927_FROM : STD_LOGIC; 
  signal XLXI_1_I3_N19927_GROM : STD_LOGIC; 
  signal CHOICE2497_FROM : STD_LOGIC; 
  signal CHOICE2497_GROM : STD_LOGIC; 
  signal CHOICE2369_FROM : STD_LOGIC; 
  signal CHOICE2369_GROM : STD_LOGIC; 
  signal CHOICE1051_FROM : STD_LOGIC; 
  signal CHOICE1051_GROM : STD_LOGIC; 
  signal CHOICE1131_FROM : STD_LOGIC; 
  signal CHOICE1131_GROM : STD_LOGIC; 
  signal CHOICE1137_FROM : STD_LOGIC; 
  signal CHOICE1137_GROM : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_2_FROM : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_2_CKMUXNOT : STD_LOGIC; 
  signal XLXI_1_pc_mux_1_FROM : STD_LOGIC; 
  signal XLXI_1_pc_mux_1_GROM : STD_LOGIC; 
  signal N44540_FROM : STD_LOGIC; 
  signal N44540_GROM : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_9_FROM : STD_LOGIC; 
  signal N44516_FROM : STD_LOGIC; 
  signal N44516_GROM : STD_LOGIC; 
  signal N43312_FROM : STD_LOGIC; 
  signal N43312_GROM : STD_LOGIC; 
  signal CHOICE2149_FROM : STD_LOGIC; 
  signal CHOICE2149_GROM : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_0_FROM : STD_LOGIC; 
  signal CHOICE2189_FROM : STD_LOGIC; 
  signal CHOICE2189_GROM : STD_LOGIC; 
  signal CHOICE2143_FROM : STD_LOGIC; 
  signal CHOICE2143_GROM : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_1_FROM : STD_LOGIC; 
  signal CHOICE2183_FROM : STD_LOGIC; 
  signal CHOICE2183_GROM : STD_LOGIC; 
  signal CHOICE2129_FROM : STD_LOGIC; 
  signal CHOICE2129_GROM : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_2_1_FROM : STD_LOGIC; 
  signal XLXI_1_I2_pc_mux_x_2_1_GROM : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_2_FROM : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_3_FROM : STD_LOGIC; 
  signal CHOICE2169_FROM : STD_LOGIC; 
  signal CHOICE2169_GROM : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_4_FROM : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_5_FROM : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_6_FROM : STD_LOGIC; 
  signal CHOICE2043_FROM : STD_LOGIC; 
  signal CHOICE2043_GROM : STD_LOGIC; 
  signal CHOICE2229_FROM : STD_LOGIC; 
  signal CHOICE2229_GROM : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_7_FROM : STD_LOGIC; 
  signal N43374_FROM : STD_LOGIC; 
  signal N43374_GROM : STD_LOGIC; 
  signal XLXI_6_n0021_FROM : STD_LOGIC; 
  signal XLXI_6_n0021_GROM : STD_LOGIC; 
  signal XLXI_55_mux_c_4_FROM : STD_LOGIC; 
  signal XLXI_55_mux_c_4_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_55_mux_x_4_O : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_8_FROM : STD_LOGIC; 
  signal CHOICE2049_GROM : STD_LOGIC; 
  signal XLXI_6_tx_bit_count_1_FROM : STD_LOGIC; 
  signal XLXI_6_tx_bit_count_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_9_FROM : STD_LOGIC; 
  signal N43366_FROM : STD_LOGIC; 
  signal N43366_GROM : STD_LOGIC; 
  signal N43921_GROM : STD_LOGIC; 
  signal XLXI_1_I1_nreset_v_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I1_nreset_v_1_LOGIC_ONE : STD_LOGIC; 
  signal CHOICE3008_GROM : STD_LOGIC; 
  signal N43362_FROM : STD_LOGIC; 
  signal N43362_GROM : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_0_FROM : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_0_GROM : STD_LOGIC; 
  signal CHOICE1097_GROM : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_1_FROM : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_1_GROM : STD_LOGIC; 
  signal XLXI_1_I2_data_is_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_2_FROM : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_2_GROM : STD_LOGIC; 
  signal N43358_GROM : STD_LOGIC; 
  signal XLXI_1_I2_nreset_v_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I2_nreset_v_1_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_1_I2_data_is_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I2_data_is_c_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_tx_uart_shift_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_tx_uart_shift_1_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_1_I2_data_is_c_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_tx_uart_shift_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_tx_uart_shift_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_tx_uart_shift_7_FFY_SET : STD_LOGIC; 
  signal XLXI_6_tx_uart_shift_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal CHOICE2570_FROM : STD_LOGIC; 
  signal CHOICE2570_GROM : STD_LOGIC; 
  signal XLXI_6_tx_uart_shift_8_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal N44508_FROM : STD_LOGIC; 
  signal N44508_GROM : STD_LOGIC; 
  signal N43204_FROM : STD_LOGIC; 
  signal N43204_GROM : STD_LOGIC; 
  signal N43234_FROM : STD_LOGIC; 
  signal N43234_GROM : STD_LOGIC; 
  signal XLXI_26_rx_uart_full_c_FROM : STD_LOGIC; 
  signal XLXI_26_rx_uart_full_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_n00321_O : STD_LOGIC; 
  signal XLXI_1_I3_nreset_v_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I3_nreset_v_1_LOGIC_ONE : STD_LOGIC; 
  signal N43166_FROM : STD_LOGIC; 
  signal N43166_GROM : STD_LOGIC; 
  signal N43280_FROM : STD_LOGIC; 
  signal N43280_GROM : STD_LOGIC; 
  signal XLXI_1_I4_nreset_v_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I4_nreset_v_1_LOGIC_ONE : STD_LOGIC; 
  signal CHOICE842_FROM : STD_LOGIC; 
  signal CHOICE842_GROM : STD_LOGIC; 
  signal CHOICE845_GROM : STD_LOGIC; 
  signal CHOICE847_FROM : STD_LOGIC; 
  signal CHOICE847_GROM : STD_LOGIC; 
  signal CHOICE2464_FROM : STD_LOGIC; 
  signal CHOICE2464_GROM : STD_LOGIC; 
  signal CHOICE2764_FROM : STD_LOGIC; 
  signal CHOICE2764_GROM : STD_LOGIC; 
  signal CHOICE892_FROM : STD_LOGIC; 
  signal CHOICE892_GROM : STD_LOGIC; 
  signal CHOICE2826_FROM : STD_LOGIC; 
  signal CHOICE2826_GROM : STD_LOGIC; 
  signal CHOICE2533_FROM : STD_LOGIC; 
  signal CHOICE2533_GROM : STD_LOGIC; 
  signal XLXI_4_int_mask_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_4_int_mask_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal CHOICE870_GROM : STD_LOGIC; 
  signal XLXI_4_int_mask_c_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_4_int_mask_c_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_n0026_FROM : STD_LOGIC; 
  signal XLXI_26_n0026_GROM : STD_LOGIC; 
  signal CHOICE877_FROM : STD_LOGIC; 
  signal CHOICE877_GROM : STD_LOGIC; 
  signal CHOICE2597_FROM : STD_LOGIC; 
  signal CHOICE2597_GROM : STD_LOGIC; 
  signal XLXI_26_N16097_FROM : STD_LOGIC; 
  signal XLXI_26_N16097_GROM : STD_LOGIC; 
  signal XLXI_6_tx_s_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_6_tx_s_0_BYMUXNOT : STD_LOGIC; 
  signal CHOICE2661_FROM : STD_LOGIC; 
  signal CHOICE2661_GROM : STD_LOGIC; 
  signal XLXI_1_I2_TC_c_0_FROM : STD_LOGIC; 
  signal XLXI_1_I2_TC_c_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I2_TC_c_0_GROM : STD_LOGIC; 
  signal XLXI_26_rx_8_count_1_FROM : STD_LOGIC; 
  signal XLXI_26_rx_8_count_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_16_count_1_FROM : STD_LOGIC; 
  signal XLXI_26_rx_16_count_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_8z_count_1_FROM : STD_LOGIC; 
  signal XLXI_26_rx_8z_count_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal CHOICE2758_FROM : STD_LOGIC; 
  signal CHOICE2758_GROM : STD_LOGIC; 
  signal XLXI_1_I3_data_x_0_FROM : STD_LOGIC; 
  signal XLXI_1_I3_data_x_0_GROM : STD_LOGIC; 
  signal XLXI_26_N16197_FROM : STD_LOGIC; 
  signal XLXI_26_N16197_GROM : STD_LOGIC; 
  signal CHOICE2738_FROM : STD_LOGIC; 
  signal CHOICE2738_GROM : STD_LOGIC; 
  signal CHOICE2866_FROM : STD_LOGIC; 
  signal CHOICE2866_GROM : STD_LOGIC; 
  signal XLXI_26_N16190_FROM : STD_LOGIC; 
  signal XLXI_26_N16190_GROM : STD_LOGIC; 
  signal CHOICE2822_FROM : STD_LOGIC; 
  signal CHOICE2822_GROM : STD_LOGIC; 
  signal CHOICE2802_FROM : STD_LOGIC; 
  signal CHOICE2802_GROM : STD_LOGIC; 
  signal CHOICE2762_FROM : STD_LOGIC; 
  signal CHOICE2762_GROM : STD_LOGIC; 
  signal CHOICE2892_FROM : STD_LOGIC; 
  signal CHOICE2892_GROM : STD_LOGIC; 
  signal N43402_FROM : STD_LOGIC; 
  signal N43402_GROM : STD_LOGIC; 
  signal CHOICE2530_FROM : STD_LOGIC; 
  signal CHOICE2530_GROM : STD_LOGIC; 
  signal CHOICE2895_FROM : STD_LOGIC; 
  signal CHOICE2895_GROM : STD_LOGIC; 
  signal CHOICE2645_FROM : STD_LOGIC; 
  signal CHOICE2645_GROM : STD_LOGIC; 
  signal CHOICE2603_FROM : STD_LOGIC; 
  signal CHOICE2603_GROM : STD_LOGIC; 
  signal CHOICE2886_FROM : STD_LOGIC; 
  signal CHOICE2886_GROM : STD_LOGIC; 
  signal XLXI_26_n0106_FROM : STD_LOGIC; 
  signal XLXI_26_n0106_GROM : STD_LOGIC; 
  signal CHOICE2594_FROM : STD_LOGIC; 
  signal CHOICE2594_GROM : STD_LOGIC; 
  signal CHOICE1032_GROM : STD_LOGIC; 
  signal CHOICE2930_FROM : STD_LOGIC; 
  signal CHOICE2930_GROM : STD_LOGIC; 
  signal XLXI_26_n0023_GROM : STD_LOGIC; 
  signal CHOICE2542_FROM : STD_LOGIC; 
  signal CHOICE2542_GROM : STD_LOGIC; 
  signal N43210_FROM : STD_LOGIC; 
  signal N43210_GROM : STD_LOGIC; 
  signal XLXI_26_n0024_FROM : STD_LOGIC; 
  signal XLXI_26_n0024_GROM : STD_LOGIC; 
  signal XLXI_26_n0108_FROM : STD_LOGIC; 
  signal XLXI_26_n0108_GROM : STD_LOGIC; 
  signal XLXI_26_n0112_GROM : STD_LOGIC; 
  signal CHOICE2539_FROM : STD_LOGIC; 
  signal CHOICE2539_GROM : STD_LOGIC; 
  signal CHOICE1039_FROM : STD_LOGIC; 
  signal CHOICE1039_GROM : STD_LOGIC; 
  signal CHOICE2478_FROM : STD_LOGIC; 
  signal CHOICE2478_GROM : STD_LOGIC; 
  signal CHOICE2634_FROM : STD_LOGIC; 
  signal CHOICE2634_GROM : STD_LOGIC; 
  signal CHOICE2658_FROM : STD_LOGIC; 
  signal CHOICE2658_GROM : STD_LOGIC; 
  signal CHOICE2670_GROM : STD_LOGIC; 
  signal CHOICE2870_FROM : STD_LOGIC; 
  signal CHOICE2870_GROM : STD_LOGIC; 
  signal N28099_FROM : STD_LOGIC; 
  signal N28099_GROM : STD_LOGIC; 
  signal CHOICE2950_FROM : STD_LOGIC; 
  signal CHOICE2950_GROM : STD_LOGIC; 
  signal CHOICE2755_FROM : STD_LOGIC; 
  signal CHOICE2755_GROM : STD_LOGIC; 
  signal CHOICE2475_GROM : STD_LOGIC; 
  signal CHOICE2795_FROM : STD_LOGIC; 
  signal CHOICE2795_GROM : STD_LOGIC; 
  signal N43168_FROM : STD_LOGIC; 
  signal N43168_GROM : STD_LOGIC; 
  signal XLXI_26_n0102_GROM : STD_LOGIC; 
  signal CHOICE2819_FROM : STD_LOGIC; 
  signal CHOICE2819_GROM : STD_LOGIC; 
  signal XLXI_1_I2_TC_c_2_FROM : STD_LOGIC; 
  signal XLXI_1_I2_TC_c_2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I2_TC_c_2_GROM : STD_LOGIC; 
  signal CHOICE2883_FROM : STD_LOGIC; 
  signal CHOICE2883_GROM : STD_LOGIC; 
  signal N43186_FROM : STD_LOGIC; 
  signal N43186_GROM : STD_LOGIC; 
  signal N43414_FROM : STD_LOGIC; 
  signal N43414_GROM : STD_LOGIC; 
  signal N43416_GROM : STD_LOGIC; 
  signal CHOICE2700_FROM : STD_LOGIC; 
  signal CHOICE2700_GROM : STD_LOGIC; 
  signal N43447_GROM : STD_LOGIC; 
  signal XLXI_26_n0099_FROM : STD_LOGIC; 
  signal XLXI_26_n0099_GROM : STD_LOGIC; 
  signal CHOICE2947_FROM : STD_LOGIC; 
  signal CHOICE2947_GROM : STD_LOGIC; 
  signal N43449_FROM : STD_LOGIC; 
  signal N43449_GROM : STD_LOGIC; 
  signal CHOICE2722_FROM : STD_LOGIC; 
  signal CHOICE2722_GROM : STD_LOGIC; 
  signal N43460_FROM : STD_LOGIC; 
  signal N43460_GROM : STD_LOGIC; 
  signal XLXI_26_rx_uart_fifo_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_uart_fifo_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_uart_fifo_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_26_rx_uart_fifo_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_4_int_masked_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_4_int_masked_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_4_int_masked_c_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_4_int_masked_c_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_2_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_3_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_4_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_5_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_7_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_1_6_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_9_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_ireg_i_0_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_pc_7_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_pc_8_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_pc_9_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_5_FFX_RST : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_2_FFX_RST : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_4_FFX_RST : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_5_FFX_RST : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_6_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_pc_6_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_4_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_6_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_2_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_7_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_3_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_8_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_0_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_8_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_2_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_4_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_0_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_6_9_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_5_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_4_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_5_6_FFX_RST : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_0_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_1_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_3_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_1_FFX_RST : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_8_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_5_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_3_FFX_RST : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_0_FFY_RST : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_1_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_4_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_8_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_5_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_3_9_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_6_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_7_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_2_8_FFX_RST : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_7_FFX_RST : STD_LOGIC; 
  signal XLXI_4_int_clr_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_4_int_clr_c_5_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_clr_c_5_FFX_RST : STD_LOGIC; 
  signal XLXI_4_int_clr_c_7_FFY_RST : STD_LOGIC; 
  signal XLXI_6_tx_16_count_1_FFX_RST : STD_LOGIC; 
  signal XLXI_4_int_clr_c_7_FFX_RST : STD_LOGIC; 
  signal XLXI_6_tx_16_count_1_FFY_RST : STD_LOGIC; 
  signal XLXI_6_tx_16_count_3_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_6_tx_16_count_3_FFX_RST : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_1_FFX_RST : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_3_FFY_RST : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_3_FFX_RST : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_5_FFY_RST : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_7_FFY_RST : STD_LOGIC; 
  signal XLXI_6_tx_clk_count_5_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_0_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_1_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_3_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_5_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_uart_full_s_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_TC_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_7_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I2_TC_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_uart_full_s_FFX_RST : STD_LOGIC; 
  signal XLXI_5_tmr_low_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_ireg_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_int_stop_c_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_clr_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_clr_c_3_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_clr_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_1_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_3_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_5_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_7_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_clk_count_5_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_i_3_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_i_5_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_i_5_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_i_7_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_1_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_3_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_3_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_7_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_5_FFY_RST : STD_LOGIC; 
  signal XLXI_5_tmr_low_5_FFX_RST : STD_LOGIC; 
  signal XLXI_5_tmr_low_7_FFY_RST : STD_LOGIC; 
  signal XLXI_5_tmr_low_7_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_ireg_c_7_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I4_ireg_c_7_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_we_c_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_bit_count_1_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_bit_count_3_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_bit_count_1_FFX_RST : STD_LOGIC; 
  signal XLXI_3_reg_data_out_c_7_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_pc_1_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_pc_2_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_pc_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_pc_3_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_pc_4_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_pc_5_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_skip_c_FFY_RST : STD_LOGIC; 
  signal XLXI_6_tx_clk_div_5_FFY_RST : STD_LOGIC; 
  signal XLXI_6_tx_clk_div_6_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_4_FFX_RST : STD_LOGIC; 
  signal XLXI_55_mux_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_6_tx_uart_busy_FFX_RST : STD_LOGIC; 
  signal XLXI_55_mux_c_3_FFY_RST : STD_LOGIC; 
  signal XLXI_55_mux_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_0_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_c_3_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_c_5_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_c_5_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_c_7_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_c_7_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_i_1_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_i_1_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_s_FFd1_FFY_RST : STD_LOGIC; 
  signal XLXI_5_tmr_count_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_i_0_6_FFX_RST : STD_LOGIC; 
  signal XLXI_5_tmr_count_3_FFX_RST : STD_LOGIC; 
  signal XLXI_5_tmr_count_5_FFY_RST : STD_LOGIC; 
  signal XLXI_5_tmr_count_5_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_iinc_i_6_FFY_RST : STD_LOGIC; 
  signal XLXI_5_tmr_count_7_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_5_tmr_enable_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_7_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_7_FFX_RST : STD_LOGIC; 
  signal XLXI_5_tmr_reset_FFY_SET : STD_LOGIC; 
  signal XLXI_1_I2_valid_c_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_bit_count_3_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I5_ndwe_c_FFY_SET : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_5_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_6_FFX_RST : STD_LOGIC; 
  signal XLXI_6_tx_uart_shift_5_FFX_SET : STD_LOGIC; 
  signal XLXI_6_tx_uart_shift_8_FFY_SET : STD_LOGIC; 
  signal XLXI_6_tx_uart_shift_7_FFX_SET : STD_LOGIC; 
  signal XLXI_26_rx_uart_full_c_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I3_nreset_v_1_FFY_RST : STD_LOGIC; 
  signal XLXI_6_tx_uart_fifo_1_FFY_SET : STD_LOGIC; 
  signal XLXI_6_tx_clk_div_1_FFY_RST : STD_LOGIC; 
  signal XLXI_6_tx_clk_div_1_FFX_RST : STD_LOGIC; 
  signal XLXI_6_tx_clk_div_3_FFY_RST : STD_LOGIC; 
  signal XLXI_6_tx_clk_div_3_FFX_RST : STD_LOGIC; 
  signal XLXI_6_tx_clk_div_4_FFY_RST : STD_LOGIC; 
  signal XLXI_5_tmr_high_2_FFY_RST : STD_LOGIC; 
  signal XLXI_5_tmr_high_3_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_uart_ovr_d_FFY_RST : STD_LOGIC; 
  signal XLXI_5_tmr_high_4_FFY_RST : STD_LOGIC; 
  signal XLXI_5_tmr_high_5_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I3_nreset_v_0_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_pending_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_pending_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_4_int_pending_c_3_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_pending_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_4_int_pending_c_5_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I4_nreset_v_0_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_pending_c_5_FFX_RST : STD_LOGIC; 
  signal XLXI_4_int_pending_c_7_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_5_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_7_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_8_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_1_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_3_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_1_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_5_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_3_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_clk_div_7_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_pending_c_7_FFX_RST : STD_LOGIC; 
  signal XLXI_6_tx_bit_count_0_FFY_RST : STD_LOGIC; 
  signal XLXI_6_tx_bit_count_3_FFY_RST : STD_LOGIC; 
  signal XLXI_6_tx_bit_count_3_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_8_count_0_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_1_FFY_CK_LATNOT : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_1_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_8_count_0_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_16_count_3_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_16_count_3_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_9_FFX_CK_LATNOT : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_9_FFX_RST : STD_LOGIC; 
  signal XLXI_4_int_masked_1_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_masked_1_FFX_RST : STD_LOGIC; 
  signal XLXI_4_int_masked_3_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_masked_3_FFX_RST : STD_LOGIC; 
  signal XLXI_4_int_masked_5_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_S_c_2_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_masked_5_FFX_RST : STD_LOGIC; 
  signal XLXI_4_int_masked_7_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_8_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_7_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_8z_count_0_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_8z_count_3_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_nreset_v_0_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_8z_count_3_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_nreset_v_0_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_int_start_c_FFY_RST : STD_LOGIC; 
  signal XLXI_5_tmr_low_3_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I4_ireg_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I2_int_stop_c_FFX_RST : STD_LOGIC; 
  signal XLXI_5_tmr_low_3_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I4_ireg_c_3_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I4_ireg_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_5_tmr_int_x_FFY_RST : STD_LOGIC; 
  signal XLXI_5_tmr_low_5_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I4_ireg_c_4_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_0_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_4_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_2_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_0_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_8_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_2_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I5_daddr_c_2_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I3_acc_c_0_4_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_1_FFX_CK_LATNOT : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_3_FFY_CK_LATNOT : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_3_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_5_FFY_CK_LATNOT : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_5_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_5_FFX_CK_LATNOT : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_5_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_7_FFY_CK_LATNOT : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_7_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_7_FFX_CK_LATNOT : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_7_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_9_FFY_CK_LATNOT : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_9_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_masked_7_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_8_count_3_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I2_S_c_2_FFX_RST : STD_LOGIC; 
  signal XLXI_5_tmr_high_0_FFY_RST : STD_LOGIC; 
  signal XLXI_5_tmr_high_1_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_s_FFd3_FFY_SET : STD_LOGIC; 
  signal XLXI_26_rx_s_FFd2_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_uart_reg_0_FFY_SET : STD_LOGIC; 
  signal XLXI_26_rx_uart_reg_2_FFY_SET : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_4_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_5_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_6_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_7_FFY_RST : STD_LOGIC; 
  signal XLXI_6_tx_uart_fifo_1_FFX_SET : STD_LOGIC; 
  signal XLXI_6_tx_uart_fifo_3_FFX_SET : STD_LOGIC; 
  signal XLXI_6_tx_uart_fifo_7_FFY_SET : STD_LOGIC; 
  signal XLXI_6_tx_uart_fifo_5_FFX_SET : STD_LOGIC; 
  signal XLXI_6_tx_uart_fifo_7_FFX_SET : STD_LOGIC; 
  signal XLXI_55_mux_c_4_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_8_FFY_RST : STD_LOGIC; 
  signal XLXI_6_tx_bit_count_1_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_9_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_nreset_v_1_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_2_FFY_CK_LATNOT : STD_LOGIC; 
  signal XLXI_1_I1_eaddr_x_2_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_7_9_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_0_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_1_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_2_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I1_stack_addrs_c_0_3_FFY_RST : STD_LOGIC; 
  signal XLXI_5_tmr_high_6_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_uart_full_d_FFY_RST : STD_LOGIC; 
  signal XLXI_5_tmr_high_7_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_3_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_5_tmr_count_1_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_mask_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_4_int_mask_c_5_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_mask_c_5_FFX_RST : STD_LOGIC; 
  signal XLXI_4_int_mask_c_7_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_mask_c_7_FFX_RST : STD_LOGIC; 
  signal XLXI_6_tx_s_0_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_TC_c_0_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I3_skip_i_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I4_ireg_we_c_FFY_RST : STD_LOGIC; 
  signal XLXI_5_tmr_count_7_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_0_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_data_is_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_0_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I2_data_is_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_2_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_nreset_v_1_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_TD_c_2_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I2_data_is_c_5_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_data_is_c_3_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_data_is_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_1_I2_data_is_c_7_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_data_is_c_5_FFX_RST : STD_LOGIC; 
  signal XLXI_6_tx_uart_shift_1_FFY_SET : STD_LOGIC; 
  signal XLXI_6_tx_uart_shift_1_FFX_SET : STD_LOGIC; 
  signal XLXI_1_I2_data_is_c_7_FFX_RST : STD_LOGIC; 
  signal XLXI_6_tx_uart_shift_3_FFY_SET : STD_LOGIC; 
  signal XLXI_6_tx_uart_shift_3_FFX_SET : STD_LOGIC; 
  signal XLXI_6_tx_uart_shift_5_FFY_SET : STD_LOGIC; 
  signal XLXI_1_I4_nreset_v_1_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_mask_c_3_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_mask_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_mask_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_8_count_1_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_TC_c_0_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_16_count_1_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_8z_count_1_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_masked_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_4_int_masked_c_5_FFX_RST : STD_LOGIC; 
  signal XLXI_4_int_masked_c_7_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_masked_c_7_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_uart_fifo_1_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_uart_fifo_1_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_uart_fifo_3_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_uart_fifo_3_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_uart_fifo_5_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_uart_fifo_5_FFX_RST : STD_LOGIC; 
  signal XLXI_26_rx_uart_fifo_7_FFY_RST : STD_LOGIC; 
  signal XLXI_26_rx_uart_fifo_7_FFX_RST : STD_LOGIC; 
  signal XLXI_4_int_masked_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_masked_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_4_int_masked_c_3_FFY_RST : STD_LOGIC; 
  signal XLXI_4_int_masked_c_5_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_TC_c_2_FFY_RST : STD_LOGIC; 
  signal XLXI_1_I2_TC_c_2_FFX_RST : STD_LOGIC; 
  signal UCLK_BUFGP_BUFG_CE : STD_LOGIC; 
  signal NRESET_BUFGP_BUFG_CE : STD_LOGIC; 
  signal PWR_VCC_0_FROM : STD_LOGIC; 
  signal PWR_VCC_0_GROM : STD_LOGIC; 
  signal PWR_VCC_1_FROM : STD_LOGIC; 
  signal PWR_VCC_2_FROM : STD_LOGIC; 
  signal PWR_VCC_3_FROM : STD_LOGIC; 
  signal PWR_VCC_4_FROM : STD_LOGIC; 
  signal PWR_VCC_4_GROM : STD_LOGIC; 
  signal PWR_VCC_5_FROM : STD_LOGIC; 
  signal PWR_VCC_6_FROM : STD_LOGIC; 
  signal PWR_VCC_6_GROM : STD_LOGIC; 
  signal PWR_VCC_7_FROM : STD_LOGIC; 
  signal PWR_VCC_7_GROM : STD_LOGIC; 
  signal PWR_GND_0_GROM : STD_LOGIC; 
  signal PWR_GND_1_GROM : STD_LOGIC; 
  signal PWR_GND_2_GROM : STD_LOGIC; 
  signal PWR_GND_3_GROM : STD_LOGIC; 
  signal PWR_GND_4_GROM : STD_LOGIC; 
  signal PWR_GND_5_GROM : STD_LOGIC; 
  signal PWR_GND_6_GROM : STD_LOGIC; 
  signal PWR_GND_7_GROM : STD_LOGIC; 
  signal PWR_GND_8_GROM : STD_LOGIC; 
  signal GND : STD_LOGIC; 
  signal VCC : STD_LOGIC; 
  signal CPU_DATA_OUT : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_26_rx_uart_reg : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal CPU_ADDR_OUT : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal RAM_DATA_OUT : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal IADDR : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal IDATA : STD_LOGIC_VECTOR ( 13 downto 0 ); 
  signal XLXI_1_I2_data_is_c : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_6_tx_bit_count : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_6_tx_uart_shift : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal XLXI_1_I4_ireg_c : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_1_I4_ireg_x : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_1_I4_ireg_i : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_1_I4_n0046 : STD_LOGIC_VECTOR ( 7 downto 1 ); 
  signal XLXI_1_pc_mux : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal XLXI_1_I3_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_1_I2_TD_c : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_1_I1_pc : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal XLXI_1_I1_n0024 : STD_LOGIC_VECTOR ( 9 downto 1 ); 
  signal XLXI_1_I4_iinc_c : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_6_n0040 : STD_LOGIC_VECTOR ( 3 downto 1 ); 
  signal XLXI_5_tmr_high : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_5_n0016 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_6_tx_16_count : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_6_n0041 : STD_LOGIC_VECTOR ( 3 downto 1 ); 
  signal XLXI_1_I3_n0066 : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal XLXI_6_tx_clk_div : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_6_tx_clk_count : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_1_I3_n0074 : STD_LOGIC_VECTOR ( 7 downto 1 ); 
  signal XLXI_1_I3_n0065 : STD_LOGIC_VECTOR ( 8 downto 8 ); 
  signal XLXI_26_rx_8_count : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_26_n0060 : STD_LOGIC_VECTOR ( 3 downto 1 ); 
  signal XLXI_26_rx_16_count : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_26_n0061 : STD_LOGIC_VECTOR ( 3 downto 1 ); 
  signal XLXI_5_tmr_low : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_5_n0017 : STD_LOGIC_VECTOR ( 7 downto 1 ); 
  signal XLXI_26_rx_clk_div : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_26_rx_clk_count : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_26_rx_bit_count : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_26_n0058 : STD_LOGIC_VECTOR ( 3 downto 1 ); 
  signal XLXI_26_rx_8z_count : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_26_n0059 : STD_LOGIC_VECTOR ( 3 downto 1 ); 
  signal XLXI_1_I2_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_1_I2_TC_c : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal XLXI_1_I5_daddr_c : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal XLXI_1_adaddr_out : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal XLXI_6_tx_s : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_55_mux_c : STD_LOGIC_VECTOR ( 4 downto 1 ); 
  signal XLXI_1_I3_acc : STD_LOGIC_VECTOR2 ( 0 downto 0 , 8 downto 0 ); 
  signal XLXI_3_reg_data_out_c : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal REG_DATA_OUT : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_1_I1_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_1_I3_data_x : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_4_int_clr_c : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_1_I4_iinc_i : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_1_I4_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_1_I2_TC_x : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal XLXI_4_int_pending_c : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_4_int_masked : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_4_int_masked_c : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_1_I1_eaddr_x : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal XLXI_4_int_mask_c : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_1_I2_S_c : STD_LOGIC_VECTOR ( 2 downto 1 ); 
  signal XLXI_5_tmr_count : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_26_rx_uart_fifo : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_6_tx_uart_fifo : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_1_I2_TD_x : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_3_out_0reg : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_3_out_1reg : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_1_I1_n0020 : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal XLXI_1_I1_n0015 : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal XLXI_1_I1_n0016 : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal XLXI_1_I1_n0017 : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal XLXI_1_I1_n0018 : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal XLXI_1_I1_n0019 : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal XLXI_6_n0011 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_1_I4_n0035 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_1_I4_iinc_x : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_1_I1_n0014 : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal XLXI_5_n0004 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_1_I4_n0034 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_26_n0039 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_26_n0040 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_1_I1_n0013 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_1_I2_n0041 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_1_I3_n0022 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_4_n0001 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_1_I4_n0036 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_6_n0010 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_26_n0041 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_26_n0042 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_1_I1_n0023 : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal XLXI_4_n0002 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_1_I2_n0040 : STD_LOGIC_VECTOR ( 1 downto 1 ); 
  signal XLXI_5_n0005 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_1_I1_n0021 : STD_LOGIC_VECTOR ( 9 downto 0 ); 
begin
  IN_INT_0_IMUX : X_BUF
    port map (
      I => IN_INT_0_IBUF_0,
      O => IN_INT_0_IBUF
    );
  IN_INT_0_IBUF_21 : X_BUF
    port map (
      I => IN_INT(0),
      O => IN_INT_0_IBUF_0
    );
  IN_INT_1_IMUX : X_BUF
    port map (
      I => IN_INT_1_IBUF_1,
      O => IN_INT_1_IBUF
    );
  IN_INT_1_IBUF_22 : X_BUF
    port map (
      I => IN_INT(1),
      O => IN_INT_1_IBUF_1
    );
  IN_INT_2_IMUX : X_BUF
    port map (
      I => IN_INT_2_IBUF_2,
      O => IN_INT_2_IBUF
    );
  IN_INT_2_IBUF_23 : X_BUF
    port map (
      I => IN_INT(2),
      O => IN_INT_2_IBUF_2
    );
  IN_INT_3_IMUX : X_BUF
    port map (
      I => IN_INT_3_IBUF_3,
      O => IN_INT_3_IBUF
    );
  IN_INT_3_IBUF_24 : X_BUF
    port map (
      I => IN_INT(3),
      O => IN_INT_3_IBUF_3
    );
  OUT0_REG_0_OFF_RSTOR : X_OR2
    port map (
      I0 => OUT0_REG_0_SRMUXNOT,
      I1 => GSR,
      O => OUT0_REG_0_OFF_RST
    );
  XLXI_3_out_0reg_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => OUT0_REG_0_OD,
      CE => XLXI_3_n0006,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => OUT0_REG_0_OFF_RST,
      O => XLXI_3_out_0reg(0)
    );
  OUT0_REG_0_OBUF : X_TRI
    port map (
      I => OUT0_REG_0_OUTMUX,
      CTL => OUT0_REG_0_ENABLE,
      O => OUT0_REG(0)
    );
  OUT0_REG_0_ENABLEINV : X_INV
    port map (
      I => OUT0_REG_0_TORGTS,
      O => OUT0_REG_0_ENABLE
    );
  OUT0_REG_0_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => OUT0_REG_0_TORGTS
    );
  OUT0_REG_0_OUTMUX_25 : X_BUF
    port map (
      I => XLXI_3_out_0reg(0),
      O => OUT0_REG_0_OUTMUX
    );
  OUT0_REG_0_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT(0),
      O => OUT0_REG_0_OD
    );
  OUT0_REG_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => OUT0_REG_0_SRMUXNOT
    );
  OUT0_REG_1_OBUF : X_TRI
    port map (
      I => OUT0_REG_1_OUTMUX,
      CTL => OUT0_REG_1_ENABLE,
      O => OUT0_REG(1)
    );
  OUT0_REG_1_ENABLEINV : X_INV
    port map (
      I => OUT0_REG_1_TORGTS,
      O => OUT0_REG_1_ENABLE
    );
  OUT0_REG_1_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => OUT0_REG_1_TORGTS
    );
  OUT0_REG_1_OUTMUX_26 : X_BUF
    port map (
      I => XLXI_3_out_0reg(1),
      O => OUT0_REG_1_OUTMUX
    );
  OUT0_REG_1_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT(1),
      O => OUT0_REG_1_OD
    );
  OUT0_REG_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => OUT0_REG_1_SRMUXNOT
    );
  OUT0_REG_2_OBUF : X_TRI
    port map (
      I => OUT0_REG_2_OUTMUX,
      CTL => OUT0_REG_2_ENABLE,
      O => OUT0_REG(2)
    );
  OUT0_REG_2_ENABLEINV : X_INV
    port map (
      I => OUT0_REG_2_TORGTS,
      O => OUT0_REG_2_ENABLE
    );
  OUT0_REG_2_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => OUT0_REG_2_TORGTS
    );
  OUT0_REG_2_OUTMUX_27 : X_BUF
    port map (
      I => XLXI_3_out_0reg(2),
      O => OUT0_REG_2_OUTMUX
    );
  OUT0_REG_2_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT(2),
      O => OUT0_REG_2_OD
    );
  OUT0_REG_2_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => OUT0_REG_2_SRMUXNOT
    );
  OUT0_REG_3_OBUF : X_TRI
    port map (
      I => OUT0_REG_3_OUTMUX,
      CTL => OUT0_REG_3_ENABLE,
      O => OUT0_REG(3)
    );
  OUT0_REG_3_ENABLEINV : X_INV
    port map (
      I => OUT0_REG_3_TORGTS,
      O => OUT0_REG_3_ENABLE
    );
  OUT0_REG_3_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => OUT0_REG_3_TORGTS
    );
  OUT0_REG_3_OUTMUX_28 : X_BUF
    port map (
      I => XLXI_3_out_0reg(3),
      O => OUT0_REG_3_OUTMUX
    );
  OUT0_REG_3_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT(3),
      O => OUT0_REG_3_OD
    );
  OUT0_REG_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => OUT0_REG_3_SRMUXNOT
    );
  XLXI_3_out_0reg_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => OUT0_REG_1_OD,
      CE => XLXI_3_n0006,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => OUT0_REG_1_OFF_RST,
      O => XLXI_3_out_0reg(1)
    );
  OUT0_REG_1_OFF_RSTOR : X_OR2
    port map (
      I0 => OUT0_REG_1_SRMUXNOT,
      I1 => GSR,
      O => OUT0_REG_1_OFF_RST
    );
  OUT0_REG_4_OBUF : X_TRI
    port map (
      I => OUT0_REG_4_OUTMUX,
      CTL => OUT0_REG_4_ENABLE,
      O => OUT0_REG(4)
    );
  OUT0_REG_4_ENABLEINV : X_INV
    port map (
      I => OUT0_REG_4_TORGTS,
      O => OUT0_REG_4_ENABLE
    );
  OUT0_REG_4_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => OUT0_REG_4_TORGTS
    );
  OUT0_REG_4_OUTMUX_29 : X_BUF
    port map (
      I => XLXI_3_out_0reg(4),
      O => OUT0_REG_4_OUTMUX
    );
  OUT0_REG_4_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT(4),
      O => OUT0_REG_4_OD
    );
  OUT0_REG_4_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => OUT0_REG_4_SRMUXNOT
    );
  OUT0_REG_5_OBUF : X_TRI
    port map (
      I => OUT0_REG_5_OUTMUX,
      CTL => OUT0_REG_5_ENABLE,
      O => OUT0_REG(5)
    );
  OUT0_REG_5_ENABLEINV : X_INV
    port map (
      I => OUT0_REG_5_TORGTS,
      O => OUT0_REG_5_ENABLE
    );
  OUT0_REG_5_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => OUT0_REG_5_TORGTS
    );
  OUT0_REG_5_OUTMUX_30 : X_BUF
    port map (
      I => XLXI_3_out_0reg(5),
      O => OUT0_REG_5_OUTMUX
    );
  OUT0_REG_5_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT(5),
      O => OUT0_REG_5_OD
    );
  OUT0_REG_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => OUT0_REG_5_SRMUXNOT
    );
  OUT0_REG_6_OBUF : X_TRI
    port map (
      I => OUT0_REG_6_OUTMUX,
      CTL => OUT0_REG_6_ENABLE,
      O => OUT0_REG(6)
    );
  OUT0_REG_6_ENABLEINV : X_INV
    port map (
      I => OUT0_REG_6_TORGTS,
      O => OUT0_REG_6_ENABLE
    );
  OUT0_REG_6_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => OUT0_REG_6_TORGTS
    );
  OUT0_REG_6_OUTMUX_31 : X_BUF
    port map (
      I => XLXI_3_out_0reg(6),
      O => OUT0_REG_6_OUTMUX
    );
  OUT0_REG_6_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT(6),
      O => OUT0_REG_6_OD
    );
  OUT0_REG_6_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => OUT0_REG_6_SRMUXNOT
    );
  OUT0_REG_7_OBUF : X_TRI
    port map (
      I => OUT0_REG_7_OUTMUX,
      CTL => OUT0_REG_7_ENABLE,
      O => OUT0_REG(7)
    );
  OUT0_REG_7_ENABLEINV : X_INV
    port map (
      I => OUT0_REG_7_TORGTS,
      O => OUT0_REG_7_ENABLE
    );
  OUT0_REG_7_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => OUT0_REG_7_TORGTS
    );
  OUT0_REG_7_OUTMUX_32 : X_BUF
    port map (
      I => XLXI_3_out_0reg(7),
      O => OUT0_REG_7_OUTMUX
    );
  OUT0_REG_7_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT(7),
      O => OUT0_REG_7_OD
    );
  OUT0_REG_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => OUT0_REG_7_SRMUXNOT
    );
  OUT1_REG_0_OBUF : X_TRI
    port map (
      I => OUT1_REG_0_OUTMUX,
      CTL => OUT1_REG_0_ENABLE,
      O => OUT1_REG(0)
    );
  OUT1_REG_0_ENABLEINV : X_INV
    port map (
      I => OUT1_REG_0_TORGTS,
      O => OUT1_REG_0_ENABLE
    );
  OUT1_REG_0_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => OUT1_REG_0_TORGTS
    );
  OUT1_REG_0_OUTMUX_33 : X_BUF
    port map (
      I => XLXI_3_out_1reg(0),
      O => OUT1_REG_0_OUTMUX
    );
  OUT1_REG_0_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT(0),
      O => OUT1_REG_0_OD
    );
  OUT1_REG_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => OUT1_REG_0_SRMUXNOT
    );
  OUT1_REG_1_OBUF : X_TRI
    port map (
      I => OUT1_REG_1_OUTMUX,
      CTL => OUT1_REG_1_ENABLE,
      O => OUT1_REG(1)
    );
  OUT1_REG_1_ENABLEINV : X_INV
    port map (
      I => OUT1_REG_1_TORGTS,
      O => OUT1_REG_1_ENABLE
    );
  OUT1_REG_1_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => OUT1_REG_1_TORGTS
    );
  OUT1_REG_1_OUTMUX_34 : X_BUF
    port map (
      I => XLXI_3_out_1reg(1),
      O => OUT1_REG_1_OUTMUX
    );
  OUT1_REG_1_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT(1),
      O => OUT1_REG_1_OD
    );
  OUT1_REG_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => OUT1_REG_1_SRMUXNOT
    );
  OUT1_REG_2_OBUF : X_TRI
    port map (
      I => OUT1_REG_2_OUTMUX,
      CTL => OUT1_REG_2_ENABLE,
      O => OUT1_REG(2)
    );
  OUT1_REG_2_ENABLEINV : X_INV
    port map (
      I => OUT1_REG_2_TORGTS,
      O => OUT1_REG_2_ENABLE
    );
  OUT1_REG_2_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => OUT1_REG_2_TORGTS
    );
  OUT1_REG_2_OUTMUX_35 : X_BUF
    port map (
      I => XLXI_3_out_1reg(2),
      O => OUT1_REG_2_OUTMUX
    );
  OUT1_REG_2_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT(2),
      O => OUT1_REG_2_OD
    );
  OUT1_REG_2_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => OUT1_REG_2_SRMUXNOT
    );
  OUT1_REG_3_OBUF : X_TRI
    port map (
      I => OUT1_REG_3_OUTMUX,
      CTL => OUT1_REG_3_ENABLE,
      O => OUT1_REG(3)
    );
  OUT1_REG_3_ENABLEINV : X_INV
    port map (
      I => OUT1_REG_3_TORGTS,
      O => OUT1_REG_3_ENABLE
    );
  OUT1_REG_3_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => OUT1_REG_3_TORGTS
    );
  OUT1_REG_3_OUTMUX_36 : X_BUF
    port map (
      I => XLXI_3_out_1reg(3),
      O => OUT1_REG_3_OUTMUX
    );
  OUT1_REG_3_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT(3),
      O => OUT1_REG_3_OD
    );
  OUT1_REG_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => OUT1_REG_3_SRMUXNOT
    );
  OUT1_REG_4_OBUF : X_TRI
    port map (
      I => OUT1_REG_4_OUTMUX,
      CTL => OUT1_REG_4_ENABLE,
      O => OUT1_REG(4)
    );
  OUT1_REG_4_ENABLEINV : X_INV
    port map (
      I => OUT1_REG_4_TORGTS,
      O => OUT1_REG_4_ENABLE
    );
  OUT1_REG_4_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => OUT1_REG_4_TORGTS
    );
  OUT1_REG_4_OUTMUX_37 : X_BUF
    port map (
      I => XLXI_3_out_1reg(4),
      O => OUT1_REG_4_OUTMUX
    );
  OUT1_REG_4_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT(4),
      O => OUT1_REG_4_OD
    );
  OUT1_REG_4_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => OUT1_REG_4_SRMUXNOT
    );
  OUT1_REG_5_OBUF : X_TRI
    port map (
      I => OUT1_REG_5_OUTMUX,
      CTL => OUT1_REG_5_ENABLE,
      O => OUT1_REG(5)
    );
  OUT1_REG_5_ENABLEINV : X_INV
    port map (
      I => OUT1_REG_5_TORGTS,
      O => OUT1_REG_5_ENABLE
    );
  OUT1_REG_5_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => OUT1_REG_5_TORGTS
    );
  OUT1_REG_5_OUTMUX_38 : X_BUF
    port map (
      I => XLXI_3_out_1reg(5),
      O => OUT1_REG_5_OUTMUX
    );
  OUT1_REG_5_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT(5),
      O => OUT1_REG_5_OD
    );
  OUT1_REG_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => OUT1_REG_5_SRMUXNOT
    );
  OUT1_REG_6_OBUF : X_TRI
    port map (
      I => OUT1_REG_6_OUTMUX,
      CTL => OUT1_REG_6_ENABLE,
      O => OUT1_REG(6)
    );
  OUT1_REG_6_ENABLEINV : X_INV
    port map (
      I => OUT1_REG_6_TORGTS,
      O => OUT1_REG_6_ENABLE
    );
  OUT1_REG_6_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => OUT1_REG_6_TORGTS
    );
  OUT1_REG_6_OUTMUX_39 : X_BUF
    port map (
      I => XLXI_3_out_1reg(6),
      O => OUT1_REG_6_OUTMUX
    );
  OUT1_REG_6_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT(6),
      O => OUT1_REG_6_OD
    );
  OUT1_REG_6_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => OUT1_REG_6_SRMUXNOT
    );
  OUT1_REG_7_OBUF : X_TRI
    port map (
      I => OUT1_REG_7_OUTMUX,
      CTL => OUT1_REG_7_ENABLE,
      O => OUT1_REG(7)
    );
  OUT1_REG_7_ENABLEINV : X_INV
    port map (
      I => OUT1_REG_7_TORGTS,
      O => OUT1_REG_7_ENABLE
    );
  OUT1_REG_7_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => OUT1_REG_7_TORGTS
    );
  OUT1_REG_7_OUTMUX_40 : X_BUF
    port map (
      I => XLXI_3_out_1reg(7),
      O => OUT1_REG_7_OUTMUX
    );
  OUT1_REG_7_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT(7),
      O => OUT1_REG_7_OD
    );
  OUT1_REG_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => OUT1_REG_7_SRMUXNOT
    );
  RXD_IMUX : X_BUF
    port map (
      I => RXD_IBUF_4,
      O => RXD_IBUF
    );
  RXD_IBUF_41 : X_BUF
    port map (
      I => RXD,
      O => RXD_IBUF_4
    );
  RXD_DELAY : X_BUF
    port map (
      I => RXD_IBUF_4,
      O => RXD_IDELAY
    );
  RXD_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => RXD_SRMUXNOT
    );
  TXD_OBUF : X_TRI
    port map (
      I => TXD_OUTMUX,
      CTL => TXD_ENABLE,
      O => TXD
    );
  TXD_ENABLEINV : X_INV
    port map (
      I => TXD_TORGTS,
      O => TXD_ENABLE
    );
  TXD_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => TXD_TORGTS
    );
  TXD_OUTMUX_42 : X_BUF
    port map (
      I => XLXI_6_tx_uart,
      O => TXD_OUTMUX
    );
  TXD_OMUX : X_BUF
    port map (
      I => XLXI_6_n0016,
      O => TXD_OD
    );
  TXD_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => TXD_SRMUXNOT
    );
  IN0_REG_0_IMUX : X_BUF
    port map (
      I => IN0_REG_0_IBUF_5,
      O => IN0_REG_0_IBUF
    );
  IN0_REG_0_IBUF_43 : X_BUF
    port map (
      I => IN0_REG(0),
      O => IN0_REG_0_IBUF_5
    );
  IN0_REG_1_IMUX : X_BUF
    port map (
      I => IN0_REG_1_IBUF_6,
      O => IN0_REG_1_IBUF
    );
  IN0_REG_1_IBUF_44 : X_BUF
    port map (
      I => IN0_REG(1),
      O => IN0_REG_1_IBUF_6
    );
  IN0_REG_2_IMUX : X_BUF
    port map (
      I => IN0_REG_2_IBUF_7,
      O => IN0_REG_2_IBUF
    );
  IN0_REG_2_IBUF_45 : X_BUF
    port map (
      I => IN0_REG(2),
      O => IN0_REG_2_IBUF_7
    );
  IN0_REG_3_IMUX : X_BUF
    port map (
      I => IN0_REG_3_IBUF_8,
      O => IN0_REG_3_IBUF
    );
  IN0_REG_3_IBUF_46 : X_BUF
    port map (
      I => IN0_REG(3),
      O => IN0_REG_3_IBUF_8
    );
  IN0_REG_4_IMUX : X_BUF
    port map (
      I => IN0_REG_4_IBUF_9,
      O => IN0_REG_4_IBUF
    );
  IN0_REG_4_IBUF_47 : X_BUF
    port map (
      I => IN0_REG(4),
      O => IN0_REG_4_IBUF_9
    );
  XLXI_3_out_0reg_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => OUT0_REG_2_OD,
      CE => XLXI_3_n0006,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => OUT0_REG_2_OFF_RST,
      O => XLXI_3_out_0reg(2)
    );
  OUT0_REG_2_OFF_RSTOR : X_OR2
    port map (
      I0 => OUT0_REG_2_SRMUXNOT,
      I1 => GSR,
      O => OUT0_REG_2_OFF_RST
    );
  IN0_REG_5_IMUX : X_BUF
    port map (
      I => IN0_REG_5_IBUF_10,
      O => IN0_REG_5_IBUF
    );
  IN0_REG_5_IBUF_48 : X_BUF
    port map (
      I => IN0_REG(5),
      O => IN0_REG_5_IBUF_10
    );
  IN0_REG_6_IMUX : X_BUF
    port map (
      I => IN0_REG_6_IBUF_11,
      O => IN0_REG_6_IBUF
    );
  IN0_REG_6_IBUF_49 : X_BUF
    port map (
      I => IN0_REG(6),
      O => IN0_REG_6_IBUF_11
    );
  IN0_REG_7_IMUX : X_BUF
    port map (
      I => IN0_REG_7_IBUF_12,
      O => IN0_REG_7_IBUF
    );
  IN0_REG_7_IBUF_50 : X_BUF
    port map (
      I => IN0_REG(7),
      O => IN0_REG_7_IBUF_12
    );
  IN1_REG_0_IMUX : X_BUF
    port map (
      I => IN1_REG_0_IBUF_13,
      O => IN1_REG_0_IBUF
    );
  IN1_REG_0_IBUF_51 : X_BUF
    port map (
      I => IN1_REG(0),
      O => IN1_REG_0_IBUF_13
    );
  IN1_REG_1_IMUX : X_BUF
    port map (
      I => IN1_REG_1_IBUF_14,
      O => IN1_REG_1_IBUF
    );
  IN1_REG_1_IBUF_52 : X_BUF
    port map (
      I => IN1_REG(1),
      O => IN1_REG_1_IBUF_14
    );
  IN1_REG_2_IMUX : X_BUF
    port map (
      I => IN1_REG_2_IBUF_15,
      O => IN1_REG_2_IBUF
    );
  IN1_REG_2_IBUF_53 : X_BUF
    port map (
      I => IN1_REG(2),
      O => IN1_REG_2_IBUF_15
    );
  IN1_REG_3_IMUX : X_BUF
    port map (
      I => IN1_REG_3_IBUF_16,
      O => IN1_REG_3_IBUF
    );
  IN1_REG_3_IBUF_54 : X_BUF
    port map (
      I => IN1_REG(3),
      O => IN1_REG_3_IBUF_16
    );
  IN1_REG_4_IMUX : X_BUF
    port map (
      I => IN1_REG_4_IBUF_17,
      O => IN1_REG_4_IBUF
    );
  IN1_REG_4_IBUF_55 : X_BUF
    port map (
      I => IN1_REG(4),
      O => IN1_REG_4_IBUF_17
    );
  IN1_REG_5_IMUX : X_BUF
    port map (
      I => IN1_REG_5_IBUF_18,
      O => IN1_REG_5_IBUF
    );
  IN1_REG_5_IBUF_56 : X_BUF
    port map (
      I => IN1_REG(5),
      O => IN1_REG_5_IBUF_18
    );
  IN1_REG_6_IMUX : X_BUF
    port map (
      I => IN1_REG_6_IBUF_19,
      O => IN1_REG_6_IBUF
    );
  IN1_REG_6_IBUF_57 : X_BUF
    port map (
      I => IN1_REG(6),
      O => IN1_REG_6_IBUF_19
    );
  IN1_REG_7_IMUX : X_BUF
    port map (
      I => IN1_REG_7_IBUF_20,
      O => IN1_REG_7_IBUF
    );
  IN1_REG_7_IBUF_58 : X_BUF
    port map (
      I => IN1_REG(7),
      O => IN1_REG_7_IBUF_20
    );
  XLXI_7_B5_LOGIC_ONE_59 : X_ONE
    port map (
      O => XLXI_7_B5_LOGIC_ONE
    );
  XLXI_7_B5_LOGIC_ZERO_60 : X_ZERO
    port map (
      O => XLXI_7_B5_LOGIC_ZERO
    );
  XLXI_7_B5_WEAMUX : X_INV
    port map (
      I => nWE_RAM,
      O => XLXI_7_B5_WEA_INTNOT
    );
  XLXI_7_B5 : X_RAMB4_S8
    generic map(
      INIT_00 => X"000000000000000000000000000000060D6F6C6C654800000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
    port map (
      CLK => UCLK_BUFGP,
      EN => XLXI_7_B5_LOGIC_ONE,
      RST => XLXI_7_B5_LOGIC_ZERO,
      WE => XLXI_7_B5_WEA_INTNOT,
      GSR => GSR,
      ADDR(8) => GLOBAL_LOGIC0_0,
      ADDR(7) => CPU_ADDR_OUT(7),
      ADDR(6) => CPU_ADDR_OUT(6),
      ADDR(5) => CPU_ADDR_OUT(5),
      ADDR(4) => CPU_ADDR_OUT(4),
      ADDR(3) => CPU_ADDR_OUT(3),
      ADDR(2) => CPU_ADDR_OUT(2),
      ADDR(1) => CPU_ADDR_OUT(1),
      ADDR(0) => XLXI_1_I5_Mmux_daddr_out_Result_0_1_1,
      DI(7) => CPU_DATA_OUT(7),
      DI(6) => CPU_DATA_OUT(6),
      DI(5) => CPU_DATA_OUT(5),
      DI(4) => CPU_DATA_OUT(4),
      DI(3) => CPU_DATA_OUT(3),
      DI(2) => CPU_DATA_OUT(2),
      DI(1) => CPU_DATA_OUT(1),
      DI(0) => CPU_DATA_OUT(0),
      DO(7) => RAM_DATA_OUT(7),
      DO(6) => RAM_DATA_OUT(6),
      DO(5) => RAM_DATA_OUT(5),
      DO(4) => RAM_DATA_OUT(4),
      DO(3) => RAM_DATA_OUT(3),
      DO(2) => RAM_DATA_OUT(2),
      DO(1) => RAM_DATA_OUT(1),
      DO(0) => RAM_DATA_OUT(0)
    );
  XLXI_8_B5_LOGIC_ONE_61 : X_ONE
    port map (
      O => XLXI_8_B5_LOGIC_ONE
    );
  XLXI_8_B5_LOGIC_ZERO_62 : X_ZERO
    port map (
      O => XLXI_8_B5_LOGIC_ZERO
    );
  XLXI_8_B5 : X_RAMB4_S4
    generic map(
      INIT_00 => X"A1A11F280D21A8121A142121A1C280211C21A1A121EA1A1A1A1A11A1A1A1A110",
      INIT_01 => X"021A80D21A1A14280D21A1A80D21A1A11F280D21A1A11F280D21A1A11F280D21",
      INIT_02 => X"00000000000000000000000000000000000001A1A1A1280D280D21A1A1A121E8",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000800000000000000000000000000000000000000000000000000000000"
    )
    port map (
      CLK => UCLK_BUFGP,
      EN => XLXI_8_B5_LOGIC_ONE,
      RST => XLXI_8_B5_LOGIC_ZERO,
      WE => XLXI_8_B5_LOGIC_ZERO,
      GSR => GSR,
      ADDR(9) => IADDR(9),
      ADDR(8) => IADDR(8),
      ADDR(7) => IADDR(7),
      ADDR(6) => IADDR(6),
      ADDR(5) => IADDR(5),
      ADDR(4) => IADDR(4),
      ADDR(3) => IADDR(3),
      ADDR(2) => IADDR(2),
      ADDR(1) => IADDR(1),
      ADDR(0) => IADDR(0),
      DI(3) => GLOBAL_LOGIC0,
      DI(2) => GLOBAL_LOGIC0,
      DI(1) => GLOBAL_LOGIC0,
      DI(0) => GLOBAL_LOGIC0,
      DO(3) => IDATA(3),
      DO(2) => IDATA(2),
      DO(1) => IDATA(1),
      DO(0) => IDATA(0)
    );
  XLXI_8_B9_LOGIC_ONE_63 : X_ONE
    port map (
      O => XLXI_8_B9_LOGIC_ONE
    );
  XLXI_8_B9_LOGIC_ZERO_64 : X_ZERO
    port map (
      O => XLXI_8_B9_LOGIC_ZERO
    );
  XLXI_8_B9 : X_RAMB4_S4
    generic map(
      INIT_00 => X"05187171A1470D801208908128A8D8198188061001101A214AD19801AC140096",
      INIT_01 => X"A160BA0450508808A045050DA04505887875A84505487479A4450528727DA245",
      INIT_02 => X"000000000000000000000000000000000000D505061087816BA0450506100117",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000300000000000000000000000000000000000000000000000000000000"
    )
    port map (
      CLK => UCLK_BUFGP,
      EN => XLXI_8_B9_LOGIC_ONE,
      RST => XLXI_8_B9_LOGIC_ZERO,
      WE => XLXI_8_B9_LOGIC_ZERO,
      GSR => GSR,
      ADDR(9) => IADDR(9),
      ADDR(8) => IADDR(8),
      ADDR(7) => IADDR(7),
      ADDR(6) => IADDR(6),
      ADDR(5) => IADDR(5),
      ADDR(4) => IADDR(4),
      ADDR(3) => IADDR(3),
      ADDR(2) => IADDR(2),
      ADDR(1) => IADDR(1),
      ADDR(0) => IADDR(0),
      DI(3) => GLOBAL_LOGIC0_11,
      DI(2) => GLOBAL_LOGIC0_11,
      DI(1) => GLOBAL_LOGIC0_11,
      DI(0) => GLOBAL_LOGIC0_11,
      DO(3) => IDATA(7),
      DO(2) => IDATA(6),
      DO(1) => IDATA(5),
      DO(0) => IDATA(4)
    );
  XLXI_8_B13_LOGIC_ONE_65 : X_ONE
    port map (
      O => XLXI_8_B13_LOGIC_ONE
    );
  XLXI_8_B13_LOGIC_ZERO_66 : X_ZERO
    port map (
      O => XLXI_8_B13_LOGIC_ZERO
    );
  XLXI_8_B13 : X_RAMB4_S4
    generic map(
      INIT_00 => X"0000101400010100010000001000101010110101010100000F00000100000000",
      INIT_01 => X"0110804000020017020000160100000010160000000010150000000010140000",
      INIT_02 => X"0000000000000000000000000000000000000000810109001908000041010108",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000300000000000000000000000000000000000000000000000000000000"
    )
    port map (
      CLK => UCLK_BUFGP,
      EN => XLXI_8_B13_LOGIC_ONE,
      RST => XLXI_8_B13_LOGIC_ZERO,
      WE => XLXI_8_B13_LOGIC_ZERO,
      GSR => GSR,
      ADDR(9) => IADDR(9),
      ADDR(8) => IADDR(8),
      ADDR(7) => IADDR(7),
      ADDR(6) => IADDR(6),
      ADDR(5) => IADDR(5),
      ADDR(4) => IADDR(4),
      ADDR(3) => IADDR(3),
      ADDR(2) => IADDR(2),
      ADDR(1) => IADDR(1),
      ADDR(0) => IADDR(0),
      DI(3) => GLOBAL_LOGIC0_9,
      DI(2) => GLOBAL_LOGIC0_9,
      DI(1) => GLOBAL_LOGIC0_9,
      DI(0) => GLOBAL_LOGIC0_9,
      DO(3) => IDATA(11),
      DO(2) => IDATA(10),
      DO(1) => IDATA(9),
      DO(0) => IDATA(8)
    );
  XLXI_8_B17_LOGIC_ONE_67 : X_ONE
    port map (
      O => XLXI_8_B17_LOGIC_ONE
    );
  XLXI_8_B17_LOGIC_ZERO_68 : X_ZERO
    port map (
      O => XLXI_8_B17_LOGIC_ZERO
    );
  XLXI_8_B17 : X_RAMB4_S2
    generic map(
      INIT_00 => X"0001444405100511000511000511000511000400004400010001000044511110",
      INIT_01 => X"0000000000000000000000000000000000000000000000000011010000510100",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
    port map (
      CLK => UCLK_BUFGP,
      EN => XLXI_8_B17_LOGIC_ONE,
      RST => XLXI_8_B17_LOGIC_ZERO,
      WE => XLXI_8_B17_LOGIC_ZERO,
      GSR => GSR,
      ADDR(10) => GLOBAL_LOGIC0_10,
      ADDR(9) => IADDR(9),
      ADDR(8) => IADDR(8),
      ADDR(7) => IADDR(7),
      ADDR(6) => IADDR(6),
      ADDR(5) => IADDR(5),
      ADDR(4) => IADDR(4),
      ADDR(3) => IADDR(3),
      ADDR(2) => IADDR(2),
      ADDR(1) => IADDR(1),
      ADDR(0) => IADDR(0),
      DI(1) => GLOBAL_LOGIC0_10,
      DI(0) => GLOBAL_LOGIC0_10,
      DO(1) => IDATA(13),
      DO(0) => IDATA(12)
    );
  XLXI_3_out_0reg_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => OUT0_REG_3_OD,
      CE => XLXI_3_n0006,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => OUT0_REG_3_OFF_RST,
      O => XLXI_3_out_0reg(3)
    );
  OUT0_REG_3_OFF_RSTOR : X_OR2
    port map (
      I0 => OUT0_REG_3_SRMUXNOT,
      I1 => GSR,
      O => OUT0_REG_3_OFF_RST
    );
  XLXI_1_I3_Ker1997510 : X_MUX2
    port map (
      IA => N44941,
      IB => N44943,
      SEL => XLXI_1_I3_n0063,
      O => XLXI_1_I3_N19977_F5MUX
    );
  XLXI_1_I3_Ker1997510_G : X_LUT4
    generic map(
      INIT => X"E9FD"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c_2_1,
      ADR1 => XLXI_1_I2_TC_c_0_1,
      ADR2 => XLXI_1_I2_TC_c_1_1,
      ADR3 => N43992,
      O => N44943
    );
  XLXI_1_I3_Ker1997510_F : X_LUT4
    generic map(
      INIT => X"E8FD"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c_2_1,
      ADR1 => XLXI_1_I2_TC_c_0_1,
      ADR2 => XLXI_1_I2_TC_c_1_1,
      ADR3 => N43992,
      O => N44941
    );
  XLXI_1_I3_N19977_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_N19977_F5MUX,
      O => XLXI_1_I3_N19977
    );
  XLXI_1_I3_Mmux_data_x_Result_1_59_SW01 : X_MUX2
    port map (
      IA => N44666,
      IB => N44668,
      SEL => CHOICE2917,
      O => N43453_F5MUX
    );
  XLXI_1_I3_Mmux_data_x_Result_1_59_SW01_G : X_LUT4
    generic map(
      INIT => X"99C3"
    )
    port map (
      ADR0 => XLXI_1_I2_data_is_c(1),
      ADR1 => XLXI_1_I3_acc_c_0_1,
      ADR2 => XLXI_1_I4_n0037,
      ADR3 => XLXI_1_I3_n0025,
      O => N44668
    );
  XLXI_1_I3_Mmux_data_x_Result_1_59_SW01_F : X_LUT4
    generic map(
      INIT => X"E2AA"
    )
    port map (
      ADR0 => N43148,
      ADR1 => CHOICE2905,
      ADR2 => N43150,
      ADR3 => XLXI_1_I4_N21650,
      O => N44666
    );
  N43453_XUSED : X_BUF
    port map (
      I => N43453_F5MUX,
      O => N43453
    );
  XLXI_6_n001665 : X_MUX2
    port map (
      IA => N44646,
      IB => N44648,
      SEL => XLXI_6_tx_bit_count(1),
      O => CHOICE828_F5MUX
    );
  XLXI_6_n001665_G : X_LUT4
    generic map(
      INIT => X"5D58"
    )
    port map (
      ADR0 => XLXI_6_tx_bit_count(0),
      ADR1 => XLXI_6_tx_uart_shift(3),
      ADR2 => XLXI_6_tx_bit_count(3),
      ADR3 => XLXI_6_tx_uart_shift(2),
      O => N44648
    );
  XLXI_6_n001665_F : X_LUT4
    generic map(
      INIT => X"AAAE"
    )
    port map (
      ADR0 => CHOICE824,
      ADR1 => XLXI_6_tx_uart_shift(0),
      ADR2 => XLXI_6_tx_bit_count(3),
      ADR3 => XLXI_6_tx_bit_count(0),
      O => N44646
    );
  CHOICE828_XUSED : X_BUF
    port map (
      I => CHOICE828_F5MUX,
      O => CHOICE828
    );
  XLXI_1_I4_ireg_x_0_19 : X_MUX2
    port map (
      IA => N44851,
      IB => N44853,
      SEL => XLXI_1_I4_N21661,
      O => XLXI_1_I4_ireg_i_0_F5MUX
    );
  XLXI_1_I4_ireg_x_0_19_G : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_0,
      ADR1 => XLXI_1_I4_ireg_we_c,
      ADR2 => CHOICE576,
      ADR3 => XLXI_1_I4_ireg_c(0),
      O => N44853
    );
  XLXI_1_I4_ireg_x_0_19_F : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_1_I4_ireg_we_c,
      ADR1 => XLXI_1_I4_Madd_n0046_inst_lut2_47,
      ADR2 => CHOICE576,
      ADR3 => XLXI_1_I3_acc_c_0_0,
      O => N44851
    );
  XLXI_1_I4_ireg_i_0_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_ireg_i_0_F5MUX,
      O => XLXI_1_I4_ireg_x(0)
    );
  XLXI_1_I4_ireg_x_1_19 : X_MUX2
    port map (
      IA => N44841,
      IB => N44843,
      SEL => XLXI_1_I4_N21661,
      O => XLXI_1_I4_ireg_i_1_F5MUX
    );
  XLXI_1_I4_ireg_x_1_19_G : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_1,
      ADR1 => XLXI_1_I4_ireg_we_c,
      ADR2 => XLXI_1_I4_ireg_c(1),
      ADR3 => CHOICE567,
      O => N44843
    );
  XLXI_1_I4_ireg_x_1_19_F : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => CHOICE567,
      ADR1 => XLXI_1_I3_acc_c_0_1,
      ADR2 => XLXI_1_I4_n0046(1),
      ADR3 => XLXI_1_I4_ireg_we_c,
      O => N44841
    );
  XLXI_1_I4_ireg_i_1_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_ireg_i_1_F5MUX,
      O => XLXI_1_I4_ireg_x(1)
    );
  XLXI_1_I4_ireg_x_2_19 : X_MUX2
    port map (
      IA => N44936,
      IB => N44938,
      SEL => XLXI_1_I4_N21661,
      O => XLXI_1_I4_ireg_i_2_F5MUX
    );
  XLXI_1_I4_ireg_x_2_19_G : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_2,
      ADR1 => XLXI_1_I4_ireg_we_c,
      ADR2 => CHOICE630,
      ADR3 => XLXI_1_I4_ireg_c(2),
      O => N44938
    );
  XLXI_1_I4_ireg_x_2_19_F : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_2,
      ADR1 => XLXI_1_I4_n0046(2),
      ADR2 => XLXI_1_I4_ireg_we_c,
      ADR3 => CHOICE630,
      O => N44936
    );
  XLXI_1_I4_ireg_i_2_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_ireg_i_2_F5MUX,
      O => XLXI_1_I4_ireg_x(2)
    );
  XLXI_1_I4_ireg_x_3_19 : X_MUX2
    port map (
      IA => N44846,
      IB => N44848,
      SEL => XLXI_1_I4_N21661,
      O => XLXI_1_I4_ireg_i_3_F5MUX
    );
  XLXI_1_I4_ireg_x_3_19_G : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_1_I4_ireg_c(3),
      ADR1 => CHOICE621,
      ADR2 => XLXI_1_I4_ireg_we_c,
      ADR3 => XLXI_1_I3_acc_c_0_3,
      O => N44848
    );
  XLXI_1_I4_ireg_x_3_19_F : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_1_I4_n0046(3),
      ADR1 => XLXI_1_I4_ireg_we_c,
      ADR2 => XLXI_1_I3_acc_c_0_3,
      ADR3 => CHOICE621,
      O => N44846
    );
  XLXI_1_I4_ireg_i_3_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_ireg_i_3_F5MUX,
      O => XLXI_1_I4_ireg_x(3)
    );
  XLXI_1_I4_ireg_x_4_19 : X_MUX2
    port map (
      IA => N44956,
      IB => N44958,
      SEL => XLXI_1_I4_N21661,
      O => XLXI_1_I4_ireg_i_4_F5MUX
    );
  XLXI_1_I4_ireg_x_4_19_G : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_1_I4_ireg_we_c,
      ADR1 => CHOICE603,
      ADR2 => XLXI_1_I4_ireg_c(4),
      ADR3 => XLXI_1_I3_acc_c_0_4,
      O => N44958
    );
  XLXI_1_I4_ireg_x_4_19_F : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_1_I4_n0046(4),
      ADR1 => XLXI_1_I4_ireg_we_c,
      ADR2 => XLXI_1_I3_acc_c_0_4,
      ADR3 => CHOICE603,
      O => N44956
    );
  XLXI_1_I4_ireg_i_4_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_ireg_i_4_F5MUX,
      O => XLXI_1_I4_ireg_x(4)
    );
  XLXI_1_I4_ireg_x_5_19 : X_MUX2
    port map (
      IA => N44831,
      IB => N44833,
      SEL => XLXI_1_I4_N21661,
      O => XLXI_1_I4_ireg_i_5_F5MUX
    );
  XLXI_1_I4_ireg_x_5_19_G : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_1_I4_ireg_c(5),
      ADR1 => XLXI_1_I4_ireg_we_c,
      ADR2 => XLXI_1_I3_acc_c_0_5,
      ADR3 => CHOICE612,
      O => N44833
    );
  XLXI_1_I4_ireg_x_5_19_F : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_1_I4_n0046(5),
      ADR1 => CHOICE612,
      ADR2 => XLXI_1_I3_acc_c_0_5,
      ADR3 => XLXI_1_I4_ireg_we_c,
      O => N44831
    );
  XLXI_1_I4_ireg_i_5_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_ireg_i_5_F5MUX,
      O => XLXI_1_I4_ireg_x(5)
    );
  XLXI_1_I4_ireg_x_6_19 : X_MUX2
    port map (
      IA => N44961,
      IB => N44963,
      SEL => XLXI_1_I4_N21661,
      O => XLXI_1_I4_ireg_i_6_F5MUX
    );
  XLXI_1_I4_ireg_x_6_19_G : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_1_I4_ireg_we_c,
      ADR1 => XLXI_1_I4_ireg_c(6),
      ADR2 => CHOICE594,
      ADR3 => XLXI_1_I3_acc_c_0_6,
      O => N44963
    );
  XLXI_1_I4_ireg_x_6_19_F : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_1_I4_n0046(6),
      ADR1 => XLXI_1_I3_acc_c_0_6,
      ADR2 => CHOICE594,
      ADR3 => XLXI_1_I4_ireg_we_c,
      O => N44961
    );
  XLXI_1_I4_ireg_i_6_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_ireg_i_6_F5MUX,
      O => XLXI_1_I4_ireg_x(6)
    );
  XLXI_1_I4_ireg_x_7_19 : X_MUX2
    port map (
      IA => N44836,
      IB => N44838,
      SEL => XLXI_1_I4_N21661,
      O => XLXI_1_I4_ireg_i_7_F5MUX
    );
  XLXI_1_I4_ireg_x_7_19_G : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => CHOICE585,
      ADR1 => XLXI_1_I3_acc_c_0_7,
      ADR2 => XLXI_1_I4_ireg_we_c,
      ADR3 => XLXI_1_I4_ireg_c(7),
      O => N44838
    );
  XLXI_1_I4_ireg_x_7_19_F : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_7,
      ADR1 => CHOICE585,
      ADR2 => XLXI_1_I4_n0046(7),
      ADR3 => XLXI_1_I4_ireg_we_c,
      O => N44836
    );
  XLXI_1_I4_ireg_i_7_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_ireg_i_7_F5MUX,
      O => XLXI_1_I4_ireg_x(7)
    );
  XLXI_1_I1_n0020_0_40 : X_MUX2
    port map (
      IA => N44751,
      IB => N44753,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0020(0)
    );
  XLXI_1_I1_n0020_0_40_G : X_LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_2_0,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR3 => XLXI_1_I1_stack_addrs_c_0_0,
      O => N44753
    );
  XLXI_1_I1_n0020_0_40_F : X_LUT4
    generic map(
      INIT => X"ACCC"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_0_0,
      ADR1 => XLXI_1_I1_stack_addrs_c_1_0,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_3,
      O => N44751
    );
  XLXI_1_I1_n0020_1_40 : X_MUX2
    port map (
      IA => N44741,
      IB => N44743,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0020(1)
    );
  XLXI_1_I1_n0020_1_40_G : X_LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_2_1,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR3 => XLXI_1_I1_stack_addrs_c_0_1,
      O => N44743
    );
  XLXI_1_I1_n0020_1_40_F : X_LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR1 => XLXI_1_I1_stack_addrs_c_0_1,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR3 => XLXI_1_I1_stack_addrs_c_1_1,
      O => N44741
    );
  XLXI_1_I1_n0020_2_40 : X_MUX2
    port map (
      IA => N44726,
      IB => N44728,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0020(2)
    );
  XLXI_1_I1_n0020_2_40_G : X_LUT4
    generic map(
      INIT => X"E2AA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_0_2,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR2 => XLXI_1_I1_stack_addrs_c_2_2,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_1,
      O => N44728
    );
  XLXI_1_I1_n0020_2_40_F : X_LUT4
    generic map(
      INIT => X"D8F0"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR1 => XLXI_1_I1_stack_addrs_c_0_2,
      ADR2 => XLXI_1_I1_stack_addrs_c_1_2,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_3,
      O => N44726
    );
  XLXI_1_I1_n0020_3_40 : X_MUX2
    port map (
      IA => N44866,
      IB => N44868,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0020(3)
    );
  XLXI_1_I1_n0020_3_40_G : X_LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_2_3,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR3 => XLXI_1_I1_stack_addrs_c_0_3,
      O => N44868
    );
  XLXI_1_I1_n0020_3_40_F : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_1_3,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR3 => XLXI_1_I1_stack_addrs_c_0_3,
      O => N44866
    );
  XLXI_1_I1_n0020_4_40 : X_MUX2
    port map (
      IA => N44796,
      IB => N44798,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0020(4)
    );
  XLXI_1_I1_n0020_4_40_G : X_LUT4
    generic map(
      INIT => X"E2AA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_0_4,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR2 => XLXI_1_I1_stack_addrs_c_2_4,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_1,
      O => N44798
    );
  XLXI_1_I1_n0020_4_40_F : X_LUT4
    generic map(
      INIT => X"D8F0"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR1 => XLXI_1_I1_stack_addrs_c_0_4,
      ADR2 => XLXI_1_I1_stack_addrs_c_1_4,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_1,
      O => N44796
    );
  XLXI_1_I1_n0020_5_40 : X_MUX2
    port map (
      IA => N44771,
      IB => N44773,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0020(5)
    );
  XLXI_1_I1_n0020_5_40_G : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_0_5,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR3 => XLXI_1_I1_stack_addrs_c_2_5,
      O => N44773
    );
  XLXI_1_I1_n0020_5_40_F : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR2 => XLXI_1_I1_stack_addrs_c_1_5,
      ADR3 => XLXI_1_I1_stack_addrs_c_0_5,
      O => N44771
    );
  XLXI_1_I1_n0020_6_40 : X_MUX2
    port map (
      IA => N44731,
      IB => N44733,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0020(6)
    );
  XLXI_1_I1_n0020_6_40_G : X_LUT4
    generic map(
      INIT => X"D8F0"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR1 => XLXI_1_I1_stack_addrs_c_2_6,
      ADR2 => XLXI_1_I1_stack_addrs_c_0_6,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_1,
      O => N44733
    );
  XLXI_1_I1_n0020_6_40_F : X_LUT4
    generic map(
      INIT => X"F780"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR2 => XLXI_1_I1_stack_addrs_c_0_6,
      ADR3 => XLXI_1_I1_stack_addrs_c_1_6,
      O => N44731
    );
  XLXI_1_I1_n0020_7_40 : X_MUX2
    port map (
      IA => N44951,
      IB => N44953,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0020(7)
    );
  XLXI_1_I1_n0020_7_40_G : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_0_7,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR3 => XLXI_1_I1_stack_addrs_c_2_7,
      O => N44953
    );
  XLXI_1_I1_n0020_7_40_F : X_LUT4
    generic map(
      INIT => X"ACCC"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_0_7,
      ADR1 => XLXI_1_I1_stack_addrs_c_1_7,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_1,
      O => N44951
    );
  XLXI_3_out_0reg_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => OUT0_REG_4_OD,
      CE => XLXI_3_n0006,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => OUT0_REG_4_OFF_RST,
      O => XLXI_3_out_0reg(4)
    );
  OUT0_REG_4_OFF_RSTOR : X_OR2
    port map (
      I0 => OUT0_REG_4_SRMUXNOT,
      I1 => GSR,
      O => OUT0_REG_4_OFF_RST
    );
  XLXI_1_I1_n0020_8_40 : X_MUX2
    port map (
      IA => N44901,
      IB => N44903,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0020(8)
    );
  XLXI_1_I1_n0020_8_40_G : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_0_8,
      ADR1 => XLXI_1_I1_stack_addrs_c_2_8,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_1,
      O => N44903
    );
  XLXI_1_I1_n0020_8_40_F : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_0_8,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR2 => XLXI_1_I1_stack_addrs_c_1_8,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_1,
      O => N44901
    );
  XLXI_1_I1_n0020_9_40 : X_MUX2
    port map (
      IA => N44686,
      IB => N44688,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0020(9)
    );
  XLXI_1_I1_n0020_9_40_G : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_0_9,
      ADR1 => XLXI_1_I1_stack_addrs_c_2_9,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_1,
      O => N44688
    );
  XLXI_1_I1_n0020_9_40_F : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_0_9,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR2 => XLXI_1_I1_stack_addrs_c_1_9,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_3,
      O => N44686
    );
  XLXI_1_I1_n0015_0_40 : X_MUX2
    port map (
      IA => N44896,
      IB => N44898,
      SEL => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_n0015(0)
    );
  XLXI_1_I1_n0015_0_40_G : X_LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_7_0,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR3 => XLXI_1_I1_stack_addrs_c_5_0,
      O => N44898
    );
  XLXI_1_I1_n0015_0_40_F : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_5_0,
      ADR1 => XLXI_1_pc_mux(1),
      ADR2 => XLXI_1_I1_stack_addrs_c_6_0,
      ADR3 => XLXI_1_pc_mux(0),
      O => N44896
    );
  XLXI_1_I1_n0015_1_40 : X_MUX2
    port map (
      IA => N44761,
      IB => N44763,
      SEL => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_n0015(1)
    );
  XLXI_1_I1_n0015_1_40_G : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_7_1,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR2 => XLXI_1_I1_stack_addrs_c_5_1,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_2,
      O => N44763
    );
  XLXI_1_I1_n0015_1_40_F : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_6_1,
      ADR1 => XLXI_1_I1_stack_addrs_c_5_1,
      ADR2 => XLXI_1_pc_mux(1),
      ADR3 => XLXI_1_pc_mux(0),
      O => N44761
    );
  XLXI_1_I1_n0015_2_40 : X_MUX2
    port map (
      IA => N44856,
      IB => N44858,
      SEL => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_n0015(2)
    );
  XLXI_1_I1_n0015_2_40_G : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_7_2,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR2 => XLXI_1_I1_stack_addrs_c_5_2,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_4,
      O => N44858
    );
  XLXI_1_I1_n0015_2_40_F : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_6_2,
      ADR1 => XLXI_1_I1_stack_addrs_c_5_2,
      ADR2 => XLXI_1_pc_mux(1),
      ADR3 => XLXI_1_pc_mux(0),
      O => N44856
    );
  XLXI_1_I3_n0115_8_31_SW11 : X_MUX2
    port map (
      IA => N44926,
      IB => N44928,
      SEL => CHOICE2723,
      O => N43246_F5MUX
    );
  XLXI_1_I3_n0115_8_31_SW11_G : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => XLXI_1_I3_nreset_v(1),
      ADR1 => NRESET_BUFGP,
      ADR2 => XLXI_1_I3_nreset_v(0),
      ADR3 => XLXI_1_I2_valid_c,
      O => N44928
    );
  XLXI_1_I3_n0115_8_31_SW11_F : X_LUT4
    generic map(
      INIT => X"0C08"
    )
    port map (
      ADR0 => CHOICE2701,
      ADR1 => XLXI_1_I3_n0023,
      ADR2 => XLXI_1_I2_TD_c(3),
      ADR3 => XLXI_1_I3_n0076,
      O => N44926
    );
  N43246_XUSED : X_BUF
    port map (
      I => N43246_F5MUX,
      O => N43246
    );
  XLXI_1_I1_n0015_3_40 : X_MUX2
    port map (
      IA => N44706,
      IB => N44708,
      SEL => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_n0015(3)
    );
  XLXI_1_I1_n0015_3_40_G : X_LUT4
    generic map(
      INIT => X"EC4C"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR1 => XLXI_1_I1_stack_addrs_c_5_3,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR3 => XLXI_1_I1_stack_addrs_c_7_3,
      O => N44708
    );
  XLXI_1_I1_n0015_3_40_F : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_5_3,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR2 => XLXI_1_I1_stack_addrs_c_6_3,
      ADR3 => XLXI_1_pc_mux(1),
      O => N44706
    );
  XLXI_1_I1_n0015_4_40 : X_MUX2
    port map (
      IA => N44906,
      IB => N44908,
      SEL => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_n0015(4)
    );
  XLXI_1_I1_n0015_4_40_G : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_5_4,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR3 => XLXI_1_I1_stack_addrs_c_7_4,
      O => N44908
    );
  XLXI_1_I1_n0015_4_40_F : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_5_4,
      ADR1 => XLXI_1_pc_mux(1),
      ADR2 => XLXI_1_I1_stack_addrs_c_6_4,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_4,
      O => N44906
    );
  XLXI_1_I1_n0016_0_40 : X_MUX2
    port map (
      IA => N44861,
      IB => N44863,
      SEL => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_n0016(0)
    );
  XLXI_1_I1_n0016_0_40_G : X_LUT4
    generic map(
      INIT => X"F780"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR2 => XLXI_1_I1_stack_addrs_c_6_0,
      ADR3 => XLXI_1_I1_stack_addrs_c_4_0,
      O => N44863
    );
  XLXI_1_I1_n0016_0_40_F : X_LUT4
    generic map(
      INIT => X"D8F0"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR1 => XLXI_1_I1_stack_addrs_c_4_0,
      ADR2 => XLXI_1_I1_stack_addrs_c_5_0,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_4,
      O => N44861
    );
  XLXI_1_I1_n0015_5_40 : X_MUX2
    port map (
      IA => N44886,
      IB => N44888,
      SEL => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_n0015(5)
    );
  XLXI_1_I1_n0015_5_40_G : X_LUT4
    generic map(
      INIT => X"D8F0"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR1 => XLXI_1_I1_stack_addrs_c_7_5,
      ADR2 => XLXI_1_I1_stack_addrs_c_5_5,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_2,
      O => N44888
    );
  XLXI_1_I1_n0015_5_40_F : X_LUT4
    generic map(
      INIT => X"E4CC"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR1 => XLXI_1_I1_stack_addrs_c_6_5,
      ADR2 => XLXI_1_I1_stack_addrs_c_5_5,
      ADR3 => XLXI_1_pc_mux(1),
      O => N44886
    );
  XLXI_1_I1_n0016_1_40 : X_MUX2
    port map (
      IA => N44801,
      IB => N44803,
      SEL => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_n0016(1)
    );
  XLXI_1_I1_n0016_1_40_G : X_LUT4
    generic map(
      INIT => X"E4CC"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR1 => XLXI_1_I1_stack_addrs_c_4_1,
      ADR2 => XLXI_1_I1_stack_addrs_c_6_1,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_3,
      O => N44803
    );
  XLXI_1_I1_n0016_1_40_F : X_LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_4_1,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR3 => XLXI_1_I1_stack_addrs_c_5_1,
      O => N44801
    );
  XLXI_1_I1_n0015_6_40 : X_MUX2
    port map (
      IA => N44891,
      IB => N44893,
      SEL => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_n0015(6)
    );
  XLXI_1_I1_n0015_6_40_G : X_LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR1 => XLXI_1_I1_stack_addrs_c_7_6,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR3 => XLXI_1_I1_stack_addrs_c_5_6,
      O => N44893
    );
  XLXI_1_I1_n0015_6_40_F : X_LUT4
    generic map(
      INIT => X"E4CC"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR1 => XLXI_1_I1_stack_addrs_c_6_6,
      ADR2 => XLXI_1_I1_stack_addrs_c_5_6,
      ADR3 => XLXI_1_pc_mux(1),
      O => N44891
    );
  XLXI_1_I1_n0016_2_40 : X_MUX2
    port map (
      IA => N44721,
      IB => N44723,
      SEL => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_n0016(2)
    );
  XLXI_1_I1_n0016_2_40_G : X_LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR1 => XLXI_1_I1_stack_addrs_c_6_2,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR3 => XLXI_1_I1_stack_addrs_c_4_2,
      O => N44723
    );
  XLXI_1_I1_n0016_2_40_F : X_LUT4
    generic map(
      INIT => X"EC4C"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR1 => XLXI_1_I1_stack_addrs_c_5_2,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR3 => XLXI_1_I1_stack_addrs_c_4_2,
      O => N44721
    );
  XLXI_1_I1_n0016_3_40 : X_MUX2
    port map (
      IA => N44881,
      IB => N44883,
      SEL => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_n0016(3)
    );
  XLXI_1_I1_n0016_3_40_G : X_LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR1 => XLXI_1_I1_stack_addrs_c_6_3,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR3 => XLXI_1_I1_stack_addrs_c_4_3,
      O => N44883
    );
  XLXI_1_I1_n0016_3_40_F : X_LUT4
    generic map(
      INIT => X"EC4C"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR1 => XLXI_1_I1_stack_addrs_c_5_3,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR3 => XLXI_1_I1_stack_addrs_c_4_3,
      O => N44881
    );
  XLXI_1_I1_n0015_7_40 : X_MUX2
    port map (
      IA => N44876,
      IB => N44878,
      SEL => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_n0015(7)
    );
  XLXI_1_I1_n0015_7_40_G : X_LUT4
    generic map(
      INIT => X"E2AA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_5_7,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR2 => XLXI_1_I1_stack_addrs_c_7_7,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_2,
      O => N44878
    );
  XLXI_1_I1_n0015_7_40_F : X_LUT4
    generic map(
      INIT => X"E4CC"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR1 => XLXI_1_I1_stack_addrs_c_6_7,
      ADR2 => XLXI_1_I1_stack_addrs_c_5_7,
      ADR3 => XLXI_1_pc_mux(1),
      O => N44876
    );
  XLXI_1_I1_n0015_8_40 : X_MUX2
    port map (
      IA => N44806,
      IB => N44808,
      SEL => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_n0015(8)
    );
  XLXI_1_I1_n0015_8_40_G : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_7_8,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR2 => XLXI_1_I1_stack_addrs_c_5_8,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_3,
      O => N44808
    );
  XLXI_1_I1_n0015_8_40_F : X_LUT4
    generic map(
      INIT => X"D8F0"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(1),
      ADR1 => XLXI_1_I1_stack_addrs_c_5_8,
      ADR2 => XLXI_1_I1_stack_addrs_c_6_8,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_3,
      O => N44806
    );
  XLXI_1_I1_n0016_4_40 : X_MUX2
    port map (
      IA => N44781,
      IB => N44783,
      SEL => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_n0016(4)
    );
  XLXI_1_I1_n0016_4_40_G : X_LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR1 => XLXI_1_I1_stack_addrs_c_6_4,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR3 => XLXI_1_I1_stack_addrs_c_4_4,
      O => N44783
    );
  XLXI_1_I1_n0016_4_40_F : X_LUT4
    generic map(
      INIT => X"EC4C"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR1 => XLXI_1_I1_stack_addrs_c_5_4,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR3 => XLXI_1_I1_stack_addrs_c_4_4,
      O => N44781
    );
  XLXI_1_I1_n0017_0_40 : X_MUX2
    port map (
      IA => N44641,
      IB => N44643,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0017(0)
    );
  XLXI_1_I1_n0017_0_40_G : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_3_0,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR3 => XLXI_1_I1_stack_addrs_c_5_0,
      O => N44643
    );
  XLXI_1_I1_n0017_0_40_F : X_LUT4
    generic map(
      INIT => X"D8F0"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR1 => XLXI_1_I1_stack_addrs_c_3_0,
      ADR2 => XLXI_1_I1_stack_addrs_c_4_0,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_3,
      O => N44641
    );
  XLXI_1_I1_n0015_9_40 : X_MUX2
    port map (
      IA => N44911,
      IB => N44913,
      SEL => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_n0015(9)
    );
  XLXI_1_I1_n0015_9_40_G : X_LUT4
    generic map(
      INIT => X"ACCC"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_7_9,
      ADR1 => XLXI_1_I1_stack_addrs_c_5_9,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_2,
      O => N44913
    );
  XLXI_1_I1_n0015_9_40_F : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR1 => XLXI_1_pc_mux(1),
      ADR2 => XLXI_1_I1_stack_addrs_c_6_9,
      ADR3 => XLXI_1_I1_stack_addrs_c_5_9,
      O => N44911
    );
  XLXI_3_out_0reg_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => OUT0_REG_5_OD,
      CE => XLXI_3_n0006,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => OUT0_REG_5_OFF_RST,
      O => XLXI_3_out_0reg(5)
    );
  OUT0_REG_5_OFF_RSTOR : X_OR2
    port map (
      I0 => OUT0_REG_5_SRMUXNOT,
      I1 => GSR,
      O => OUT0_REG_5_OFF_RST
    );
  XLXI_1_I1_n0016_5_40 : X_MUX2
    port map (
      IA => N44716,
      IB => N44718,
      SEL => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_n0016(5)
    );
  XLXI_1_I1_n0016_5_40_G : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_4_5,
      ADR1 => XLXI_1_I1_stack_addrs_c_6_5,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_2,
      O => N44718
    );
  XLXI_1_I1_n0016_5_40_F : X_LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_4_5,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR3 => XLXI_1_I1_stack_addrs_c_5_5,
      O => N44716
    );
  XLXI_1_I1_n0017_1_40 : X_MUX2
    port map (
      IA => N44656,
      IB => N44658,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0017(1)
    );
  XLXI_1_I1_n0017_1_40_G : X_LUT4
    generic map(
      INIT => X"E2AA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_3_1,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR2 => XLXI_1_I1_stack_addrs_c_5_1,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_3,
      O => N44658
    );
  XLXI_1_I1_n0017_1_40_F : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_4_1,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR3 => XLXI_1_I1_stack_addrs_c_3_1,
      O => N44656
    );
  XLXI_1_I1_n0016_6_40 : X_MUX2
    port map (
      IA => N44811,
      IB => N44813,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0016(6)
    );
  XLXI_1_I1_n0016_6_40_G : X_LUT4
    generic map(
      INIT => X"F780"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR2 => XLXI_1_I1_stack_addrs_c_6_6,
      ADR3 => XLXI_1_I1_stack_addrs_c_4_6,
      O => N44813
    );
  XLXI_1_I1_n0016_6_40_F : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_5_6,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR3 => XLXI_1_I1_stack_addrs_c_4_6,
      O => N44811
    );
  XLXI_1_I1_n0017_2_40 : X_MUX2
    port map (
      IA => N44766,
      IB => N44768,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0017(2)
    );
  XLXI_1_I1_n0017_2_40_G : X_LUT4
    generic map(
      INIT => X"F780"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR2 => XLXI_1_I1_stack_addrs_c_5_2,
      ADR3 => XLXI_1_I1_stack_addrs_c_3_2,
      O => N44768
    );
  XLXI_1_I1_n0017_2_40_F : X_LUT4
    generic map(
      INIT => X"EC4C"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR1 => XLXI_1_I1_stack_addrs_c_4_2,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR3 => XLXI_1_I1_stack_addrs_c_3_2,
      O => N44766
    );
  XLXI_1_I1_n0016_7_40 : X_MUX2
    port map (
      IA => N44871,
      IB => N44873,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0016(7)
    );
  XLXI_1_I1_n0016_7_40_G : X_LUT4
    generic map(
      INIT => X"E2AA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_4_7,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR2 => XLXI_1_I1_stack_addrs_c_6_7,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_2,
      O => N44873
    );
  XLXI_1_I1_n0016_7_40_F : X_LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_4_7,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR3 => XLXI_1_I1_stack_addrs_c_5_7,
      O => N44871
    );
  XLXI_1_I1_n0017_3_40 : X_MUX2
    port map (
      IA => N44821,
      IB => N44823,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0017(3)
    );
  XLXI_1_I1_n0017_3_40_G : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR2 => XLXI_1_I1_stack_addrs_c_3_3,
      ADR3 => XLXI_1_I1_stack_addrs_c_5_3,
      O => N44823
    );
  XLXI_1_I1_n0017_3_40_F : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_4_3,
      ADR1 => XLXI_1_I1_stack_addrs_c_3_3,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_4,
      O => N44821
    );
  XLXI_1_I1_n0017_4_40 : X_MUX2
    port map (
      IA => N44791,
      IB => N44793,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0017(4)
    );
  XLXI_1_I1_n0017_4_40_G : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR2 => XLXI_1_I1_stack_addrs_c_3_4,
      ADR3 => XLXI_1_I1_stack_addrs_c_5_4,
      O => N44793
    );
  XLXI_1_I1_n0017_4_40_F : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_4_4,
      ADR1 => XLXI_1_I1_stack_addrs_c_3_4,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_4,
      O => N44791
    );
  XLXI_55_mux_x_3_1 : X_LUT4
    generic map(
      INIT => X"C000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_55_N16508,
      ADR2 => CPU_ADDR_OUT(3),
      ADR3 => CPU_ADDR_OUT(2),
      O => XLXI_55_mux_x_3_1_O
    );
  XLXI_55_mux_x_2_1 : X_LUT4
    generic map(
      INIT => X"00C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_55_N16508,
      ADR2 => CPU_ADDR_OUT(3),
      ADR3 => CPU_ADDR_OUT(2),
      O => XLXI_55_mux_x_2_1_O
    );
  XLXI_55_mux_c_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_55_mux_c_3_SRMUX_OUTPUTNOT
    );
  XLXI_1_I5_Mmux_daddr_out_Result_0_1 : X_LUT4
    generic map(
      INIT => X"F1E0"
    )
    port map (
      ADR0 => XLXI_1_I4_N21762,
      ADR1 => XLXI_1_ndre_int,
      ADR2 => XLXI_1_I5_daddr_c(0),
      ADR3 => XLXI_1_adaddr_out(0),
      O => CPU_ADDR_OUT_0_FROM
    );
  XLXI_3_reg_data_out_x_2_SW0 : X_LUT4
    generic map(
      INIT => X"CCF0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => IN1_REG_2_IBUF,
      ADR2 => IN0_REG_2_IBUF,
      ADR3 => CPU_ADDR_OUT(0),
      O => CPU_ADDR_OUT_0_GROM
    );
  CPU_ADDR_OUT_0_XUSED : X_BUF
    port map (
      I => CPU_ADDR_OUT_0_FROM,
      O => CPU_ADDR_OUT(0)
    );
  CPU_ADDR_OUT_0_YUSED : X_BUF
    port map (
      I => CPU_ADDR_OUT_0_GROM,
      O => N29345
    );
  XLXI_1_I4_Ker218921 : X_LUT4
    generic map(
      INIT => X"0100"
    )
    port map (
      ADR0 => XLXI_1_I2_C_raw,
      ADR1 => IDATA(3),
      ADR2 => N43378,
      ADR3 => CHOICE3059,
      O => XLXI_1_I5_daddr_c_0_FROM
    );
  XLXI_1_I4_daddr_x_0_Q : X_LUT4
    generic map(
      INIT => X"D0C0"
    )
    port map (
      ADR0 => N29016,
      ADR1 => IDATA(4),
      ADR2 => XLXI_1_I4_n0037,
      ADR3 => XLXI_1_I4_N21894,
      O => XLXI_1_I5_daddr_c_0_GROM
    );
  XLXI_1_I5_daddr_c_0_XUSED : X_BUF
    port map (
      I => XLXI_1_I5_daddr_c_0_FROM,
      O => XLXI_1_I4_N21894
    );
  XLXI_1_I5_daddr_c_0_YUSED : X_BUF
    port map (
      I => XLXI_1_I5_daddr_c_0_GROM,
      O => XLXI_1_adaddr_out(0)
    );
  XLXI_1_I5_daddr_c_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I5_daddr_c_0_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_Ker217601_1_69 : X_LUT4
    generic map(
      INIT => X"1F0F"
    )
    port map (
      ADR0 => N43378,
      ADR1 => N43443,
      ADR2 => XLXI_1_I4_n0037,
      ADR3 => CHOICE3059,
      O => XLXI_1_I4_Ker217601_1_FROM
    );
  XLXI_55_nCS_REG_SW114_SW0 : X_LUT4
    generic map(
      INIT => X"0035"
    )
    port map (
      ADR0 => N43497,
      ADR1 => N43499,
      ADR2 => XLXI_1_I4_N21661,
      ADR3 => XLXI_1_I4_Ker217601_1,
      O => XLXI_1_I4_Ker217601_1_GROM
    );
  XLXI_1_I4_Ker217601_1_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_Ker217601_1_FROM,
      O => XLXI_1_I4_Ker217601_1
    );
  XLXI_1_I4_Ker217601_1_YUSED : X_BUF
    port map (
      I => XLXI_1_I4_Ker217601_1_GROM,
      O => N43098
    );
  XLXI_1_I4_daddr_x_3_1_SW1 : X_LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      ADR0 => XLXI_1_ndre_int,
      ADR1 => N43350,
      ADR2 => XLXI_1_I4_n0037,
      ADR3 => IDATA(7),
      O => XLXI_1_I4_daddr_x_3_1_SW1_O_FROM
    );
  XLXI_55_nCS_REG_SW114_SW1 : X_LUT4
    generic map(
      INIT => X"FECE"
    )
    port map (
      ADR0 => N43491,
      ADR1 => XLXI_1_I4_N21762,
      ADR2 => XLXI_1_I4_N21661,
      ADR3 => XLXI_1_I4_daddr_x_3_1_SW1_O,
      O => XLXI_1_I4_daddr_x_3_1_SW1_O_GROM
    );
  XLXI_1_I4_daddr_x_3_1_SW1_O_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_daddr_x_3_1_SW1_O_FROM,
      O => XLXI_1_I4_daddr_x_3_1_SW1_O
    );
  XLXI_1_I4_daddr_x_3_1_SW1_O_YUSED : X_BUF
    port map (
      I => XLXI_1_I4_daddr_x_3_1_SW1_O_GROM,
      O => N43102
    );
  XLXI_1_I4_daddr_x_3_1 : X_LUT4
    generic map(
      INIT => X"E040"
    )
    port map (
      ADR0 => XLXI_1_I4_N21661,
      ADR1 => XLXI_1_I4_ireg_c(3),
      ADR2 => XLXI_1_I4_n0037,
      ADR3 => IDATA(7),
      O => XLXI_1_I5_daddr_c_3_FROM
    );
  XLXI_55_nCS_REG_SW114_SW2 : X_LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      ADR0 => N43354,
      ADR1 => XLXI_1_I4_N21762,
      ADR2 => XLXI_1_ndre_int,
      ADR3 => XLXI_1_adaddr_out(3),
      O => XLXI_1_I5_daddr_c_3_GROM
    );
  XLXI_1_I5_daddr_c_3_XUSED : X_BUF
    port map (
      I => XLXI_1_I5_daddr_c_3_FROM,
      O => XLXI_1_adaddr_out(3)
    );
  XLXI_1_I5_daddr_c_3_YUSED : X_BUF
    port map (
      I => XLXI_1_I5_daddr_c_3_GROM,
      O => N43106
    );
  XLXI_1_I5_daddr_c_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I5_daddr_c_3_SRMUX_OUTPUTNOT
    );
  XLXI_1_I5_Mmux_daddr_out_Result_2_1 : X_LUT4
    generic map(
      INIT => X"CCCA"
    )
    port map (
      ADR0 => N43238,
      ADR1 => XLXI_1_I5_daddr_c(2),
      ADR2 => XLXI_1_I4_Ker217601_1,
      ADR3 => XLXI_1_I2_ndre_x1_1,
      O => CPU_ADDR_OUT_2_FROM
    );
  XLXI_55_nCS_INT_SW0 : X_LUT4
    generic map(
      INIT => X"AA00"
    )
    port map (
      ADR0 => NRESET_BUFGP,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => CPU_ADDR_OUT(2),
      O => CPU_ADDR_OUT_2_GROM
    );
  CPU_ADDR_OUT_2_XUSED : X_BUF
    port map (
      I => CPU_ADDR_OUT_2_FROM,
      O => CPU_ADDR_OUT(2)
    );
  CPU_ADDR_OUT_2_YUSED : X_BUF
    port map (
      I => CPU_ADDR_OUT_2_GROM,
      O => N28675
    );
  XLXI_1_I4_Ker217601 : X_LUT4
    generic map(
      INIT => X"0F4F"
    )
    port map (
      ADR0 => N43378,
      ADR1 => CHOICE3059,
      ADR2 => XLXI_1_I4_n0037,
      ADR3 => N43443,
      O => XLXI_1_I4_N21762_FROM
    );
  XLXI_55_nCS_REG_SW10_SW0 : X_LUT4
    generic map(
      INIT => X"FAC8"
    )
    port map (
      ADR0 => XLXI_1_I5_daddr_c(4),
      ADR1 => XLXI_1_ndre_int,
      ADR2 => XLXI_1_I5_daddr_c(2),
      ADR3 => XLXI_1_I4_N21762,
      O => XLXI_1_I4_N21762_GROM
    );
  XLXI_1_I4_N21762_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_N21762_FROM,
      O => XLXI_1_I4_N21762
    );
  XLXI_1_I4_N21762_YUSED : X_BUF
    port map (
      I => XLXI_1_I4_N21762_GROM,
      O => N43468
    );
  XLXI_5_Ker144791 : X_LUT4
    generic map(
      INIT => X"FFF3"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I5_Mmux_daddr_out_Result_0_1_1,
      ADR2 => nCS_TIMER,
      ADR3 => XLXI_1_I5_ndwe_c,
      O => XLXI_5_tmr_enable_FROM
    );
  XLXI_5_n00071 : X_LUT4
    generic map(
      INIT => X"AAF0"
    )
    port map (
      ADR0 => XLXI_5_tmr_enable,
      ADR1 => VCC,
      ADR2 => CPU_DATA_OUT(0),
      ADR3 => XLXI_5_N14481,
      O => XLXI_5_n00071_O
    );
  XLXI_5_tmr_enable_XUSED : X_BUF
    port map (
      I => XLXI_5_tmr_enable_FROM,
      O => XLXI_5_N14481
    );
  XLXI_5_tmr_enable_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_5_tmr_enable_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_n0115_6_39 : X_LUT4
    generic map(
      INIT => X"FEEE"
    )
    port map (
      ADR0 => CHOICE2870,
      ADR1 => CHOICE2866,
      ADR2 => XLXI_1_I3_n0074(6),
      ADR3 => XLXI_1_I3_n0059,
      O => XLXI_1_I3_acc_c_0_7_FROM
    );
  XLXI_1_I3_n0115_6_139 : X_LUT4
    generic map(
      INIT => X"FCFA"
    )
    port map (
      ADR0 => N43256,
      ADR1 => N43258,
      ADR2 => CHOICE2859,
      ADR3 => XLXI_1_I3_n0115_6_39_O,
      O => XLXI_1_I3_acc_c_0_7_GROM
    );
  XLXI_1_I3_acc_c_0_7_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_c_0_7_FROM,
      O => XLXI_1_I3_n0115_6_39_O
    );
  XLXI_1_I3_acc_c_0_7_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_c_0_7_GROM,
      O => XLXI_1_I3_acc(0, 6)
    );
  XLXI_1_I3_acc_c_0_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I3_acc_c_0_7_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_Ker216591_SW0 : X_LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      ADR0 => N43482,
      ADR1 => IDATA(1),
      ADR2 => IDATA(2),
      ADR3 => N43480,
      O => XLXI_1_I4_Ker216591_SW0_O_FROM
    );
  XLXI_1_I4_Ker216591 : X_LUT4
    generic map(
      INIT => X"FFFD"
    )
    port map (
      ADR0 => CHOICE3059,
      ADR1 => N43094,
      ADR2 => XLXI_1_I2_C_raw,
      ADR3 => XLXI_1_I4_Ker216591_SW0_O,
      O => XLXI_1_I4_Ker216591_SW0_O_GROM
    );
  XLXI_1_I4_Ker216591_SW0_O_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_Ker216591_SW0_O_FROM,
      O => XLXI_1_I4_Ker216591_SW0_O
    );
  XLXI_1_I4_Ker216591_SW0_O_YUSED : X_BUF
    port map (
      I => XLXI_1_I4_Ker216591_SW0_O_GROM,
      O => XLXI_1_I4_N21661
    );
  XLXI_5_n00321 : X_LUT4
    generic map(
      INIT => X"FAFA"
    )
    port map (
      ADR0 => XLXI_5_tmr_enable,
      ADR1 => VCC,
      ADR2 => XLXI_5_tmr_reset,
      ADR3 => VCC,
      O => XLXI_5_tmr_reset_FROM
    );
  XLXI_5_n00061 : X_LUT4
    generic map(
      INIT => X"CCAA"
    )
    port map (
      ADR0 => CPU_DATA_OUT(1),
      ADR1 => XLXI_5_tmr_reset,
      ADR2 => VCC,
      ADR3 => XLXI_5_N14481,
      O => XLXI_5_n00061_O
    );
  XLXI_5_tmr_reset_XUSED : X_BUF
    port map (
      I => XLXI_5_tmr_reset_FROM,
      O => XLXI_5_n0032
    );
  XLXI_5_tmr_reset_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_5_tmr_reset_SRMUX_OUTPUTNOT
    );
  XLXI_3_reg_data_out_x_0_Q : X_LUT4
    generic map(
      INIT => X"D1F0"
    )
    port map (
      ADR0 => N29544,
      ADR1 => CHOICE764,
      ADR2 => XLXI_3_reg_data_out_c(0),
      ADR3 => N43098,
      O => XLXI_3_reg_data_out_c_0_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_0_59 : X_LUT4
    generic map(
      INIT => X"C888"
    )
    port map (
      ADR0 => CHOICE2984,
      ADR1 => XLXI_1_I4_N21650,
      ADR2 => XLXI_55_mux_c(2),
      ADR3 => REG_DATA_OUT(0),
      O => XLXI_3_reg_data_out_c_0_GROM
    );
  XLXI_3_reg_data_out_c_0_XUSED : X_BUF
    port map (
      I => XLXI_3_reg_data_out_c_0_FROM,
      O => REG_DATA_OUT(0)
    );
  XLXI_3_reg_data_out_c_0_YUSED : X_BUF
    port map (
      I => XLXI_3_reg_data_out_c_0_GROM,
      O => CHOICE2986
    );
  XLXI_3_reg_data_out_c_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_3_reg_data_out_c_0_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_n0115_0_82 : X_LUT4
    generic map(
      INIT => X"F3F2"
    )
    port map (
      ADR0 => CHOICE2445,
      ADR1 => XLXI_1_I2_TD_c_3_1,
      ADR2 => CHOICE2437,
      ADR3 => CHOICE2438,
      O => XLXI_1_I3_acc_i_0_1_FROM
    );
  XLXI_1_I3_n0115_0_209 : X_LUT4
    generic map(
      INIT => X"FAFC"
    )
    port map (
      ADR0 => N43090,
      ADR1 => N43088,
      ADR2 => CHOICE2471,
      ADR3 => XLXI_1_I3_n0115_0_82_O,
      O => XLXI_1_I3_acc_i_0_1_GROM
    );
  XLXI_1_I3_acc_i_0_1_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_i_0_1_FROM,
      O => XLXI_1_I3_n0115_0_82_O
    );
  XLXI_1_I3_acc_i_0_1_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_i_0_1_GROM,
      O => XLXI_1_I3_acc(0, 0)
    );
  XLXI_1_I3_acc_i_0_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I3_acc_i_0_1_SRMUX_OUTPUTNOT
    );
  XLXI_3_reg_data_out_x_1_Q : X_LUT4
    generic map(
      INIT => X"F0E4"
    )
    port map (
      ADR0 => N43102,
      ADR1 => N29416,
      ADR2 => XLXI_3_reg_data_out_c(1),
      ADR3 => CHOICE764,
      O => XLXI_3_reg_data_out_c_1_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_1_59 : X_LUT4
    generic map(
      INIT => X"C888"
    )
    port map (
      ADR0 => CHOICE2905,
      ADR1 => XLXI_1_I4_N21650,
      ADR2 => XLXI_55_mux_c(2),
      ADR3 => REG_DATA_OUT(1),
      O => XLXI_3_reg_data_out_c_1_GROM
    );
  XLXI_3_reg_data_out_c_1_XUSED : X_BUF
    port map (
      I => XLXI_3_reg_data_out_c_1_FROM,
      O => REG_DATA_OUT(1)
    );
  XLXI_3_reg_data_out_c_1_YUSED : X_BUF
    port map (
      I => XLXI_3_reg_data_out_c_1_GROM,
      O => CHOICE2907
    );
  XLXI_3_reg_data_out_c_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_3_reg_data_out_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_n0115_2_72_SW1 : X_LUT4
    generic map(
      INIT => X"AC00"
    )
    port map (
      ADR0 => N43338,
      ADR1 => N43336,
      ADR2 => CHOICE2575,
      ADR3 => XLXI_1_I3_n0023,
      O => XLXI_1_I3_acc_i_0_3_FROM
    );
  XLXI_1_I3_n0115_2_139 : X_LUT4
    generic map(
      INIT => X"FECE"
    )
    port map (
      ADR0 => N43280,
      ADR1 => CHOICE2570,
      ADR2 => CHOICE2584,
      ADR3 => XLXI_1_I3_n0115_2_72_SW1_O,
      O => XLXI_1_I3_acc_i_0_3_GROM
    );
  XLXI_1_I3_acc_i_0_3_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_i_0_3_FROM,
      O => XLXI_1_I3_n0115_2_72_SW1_O
    );
  XLXI_1_I3_acc_i_0_3_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_i_0_3_GROM,
      O => XLXI_1_I3_acc(0, 2)
    );
  XLXI_1_I3_acc_i_0_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I3_acc_i_0_3_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_n0115_4_39 : X_LUT4
    generic map(
      INIT => X"FFF8"
    )
    port map (
      ADR0 => XLXI_1_I3_n0074(4),
      ADR1 => XLXI_1_I3_n0059,
      ADR2 => CHOICE2738,
      ADR3 => CHOICE2742,
      O => XLXI_1_I3_acc_i_0_5_FROM
    );
  XLXI_1_I3_n0115_4_139 : X_LUT4
    generic map(
      INIT => X"FAFC"
    )
    port map (
      ADR0 => N43270,
      ADR1 => N43268,
      ADR2 => CHOICE2731,
      ADR3 => XLXI_1_I3_n0115_4_39_O,
      O => XLXI_1_I3_acc_i_0_5_GROM
    );
  XLXI_1_I3_acc_i_0_5_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_i_0_5_FROM,
      O => XLXI_1_I3_n0115_4_39_O
    );
  XLXI_1_I3_acc_i_0_5_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_i_0_5_GROM,
      O => XLXI_1_I3_acc(0, 4)
    );
  XLXI_1_I3_acc_i_0_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I3_acc_i_0_5_SRMUX_OUTPUTNOT
    );
  XLXI_3_out_1reg_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => OUT1_REG_3_OD,
      CE => XLXI_3_n0002,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => OUT1_REG_3_OFF_RST,
      O => XLXI_3_out_1reg(3)
    );
  OUT1_REG_3_OFF_RSTOR : X_OR2
    port map (
      I0 => OUT1_REG_3_SRMUXNOT,
      I1 => GSR,
      O => OUT1_REG_3_OFF_RST
    );
  XLXI_1_I3_n0115_8_13_SW1 : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => N44555,
      ADR1 => XLXI_1_I3_n0065(8),
      ADR2 => XLXI_1_I3_n0059,
      ADR3 => N43246,
      O => XLXI_1_I3_acc_i_0_8_FROM
    );
  XLXI_1_I3_n0115_8_135 : X_LUT4
    generic map(
      INIT => X"FEAE"
    )
    port map (
      ADR0 => CHOICE2729,
      ADR1 => N43426,
      ADR2 => XLXI_1_I3_n0066(8),
      ADR3 => XLXI_1_I3_n0115_8_13_SW1_O,
      O => XLXI_1_I3_acc_i_0_8_GROM
    );
  XLXI_1_I3_acc_i_0_8_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_i_0_8_FROM,
      O => XLXI_1_I3_n0115_8_13_SW1_O
    );
  XLXI_1_I3_acc_i_0_8_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_i_0_8_GROM,
      O => XLXI_1_I3_acc(0, 8)
    );
  XLXI_1_I3_acc_i_0_8_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I3_acc_i_0_8_SRMUX_OUTPUTNOT
    );
  XLXI_3_reg_data_out_x_2_Q : X_LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      ADR0 => XLXI_3_reg_data_out_c(2),
      ADR1 => N43106,
      ADR2 => CHOICE764,
      ADR3 => N29345,
      O => XLXI_3_reg_data_out_c_2_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_2_59 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => XLXI_1_I4_N21650,
      ADR1 => CHOICE2841,
      ADR2 => XLXI_55_mux_c(2),
      ADR3 => XLXI_3_reg_data_out_x_2_O,
      O => XLXI_3_reg_data_out_c_2_GROM
    );
  XLXI_3_reg_data_out_c_2_XUSED : X_BUF
    port map (
      I => XLXI_3_reg_data_out_c_2_FROM,
      O => XLXI_3_reg_data_out_x_2_O
    );
  XLXI_3_reg_data_out_c_2_YUSED : X_BUF
    port map (
      I => XLXI_3_reg_data_out_c_2_GROM,
      O => CHOICE2843
    );
  XLXI_3_reg_data_out_c_2_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_3_reg_data_out_c_2_SRMUX_OUTPUTNOT
    );
  XLXI_3_reg_data_out_x_3_Q : X_LUT4
    generic map(
      INIT => X"AAB8"
    )
    port map (
      ADR0 => XLXI_3_reg_data_out_c(3),
      ADR1 => N43110,
      ADR2 => N29274,
      ADR3 => CHOICE764,
      O => XLXI_3_reg_data_out_c_3_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_3_59 : X_LUT4
    generic map(
      INIT => X"C8C0"
    )
    port map (
      ADR0 => XLXI_55_mux_c(2),
      ADR1 => XLXI_1_I4_N21650,
      ADR2 => CHOICE2777,
      ADR3 => XLXI_3_reg_data_out_x_3_O,
      O => XLXI_3_reg_data_out_c_3_GROM
    );
  XLXI_3_reg_data_out_c_3_XUSED : X_BUF
    port map (
      I => XLXI_3_reg_data_out_c_3_FROM,
      O => XLXI_3_reg_data_out_x_3_O
    );
  XLXI_3_reg_data_out_c_3_YUSED : X_BUF
    port map (
      I => XLXI_3_reg_data_out_c_3_GROM,
      O => CHOICE2779
    );
  XLXI_3_reg_data_out_c_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_3_reg_data_out_c_3_SRMUX_OUTPUTNOT
    );
  XLXI_3_reg_data_out_x_4_Q : X_LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      ADR0 => XLXI_3_reg_data_out_c(4),
      ADR1 => N43114,
      ADR2 => CHOICE764,
      ADR3 => N29203,
      O => XLXI_3_reg_data_out_c_4_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_4_59 : X_LUT4
    generic map(
      INIT => X"C888"
    )
    port map (
      ADR0 => CHOICE2680,
      ADR1 => XLXI_1_I4_N21650,
      ADR2 => XLXI_55_mux_c(2),
      ADR3 => XLXI_3_reg_data_out_x_4_O,
      O => XLXI_3_reg_data_out_c_4_GROM
    );
  XLXI_3_reg_data_out_c_4_XUSED : X_BUF
    port map (
      I => XLXI_3_reg_data_out_c_4_FROM,
      O => XLXI_3_reg_data_out_x_4_O
    );
  XLXI_3_reg_data_out_c_4_YUSED : X_BUF
    port map (
      I => XLXI_3_reg_data_out_c_4_GROM,
      O => CHOICE2682
    );
  XLXI_3_reg_data_out_c_4_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_3_reg_data_out_c_4_SRMUX_OUTPUTNOT
    );
  XLXI_3_reg_data_out_x_5_Q : X_LUT4
    generic map(
      INIT => X"FE02"
    )
    port map (
      ADR0 => N29124,
      ADR1 => N43118,
      ADR2 => CHOICE764,
      ADR3 => XLXI_3_reg_data_out_c(5),
      O => XLXI_3_reg_data_out_c_5_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_5_59 : X_LUT4
    generic map(
      INIT => X"C888"
    )
    port map (
      ADR0 => CHOICE2616,
      ADR1 => XLXI_1_I4_N21650,
      ADR2 => XLXI_55_mux_c(2),
      ADR3 => XLXI_3_reg_data_out_x_5_O,
      O => XLXI_3_reg_data_out_c_5_GROM
    );
  XLXI_3_reg_data_out_c_5_XUSED : X_BUF
    port map (
      I => XLXI_3_reg_data_out_c_5_FROM,
      O => XLXI_3_reg_data_out_x_5_O
    );
  XLXI_3_reg_data_out_c_5_YUSED : X_BUF
    port map (
      I => XLXI_3_reg_data_out_c_5_GROM,
      O => CHOICE2618
    );
  XLXI_3_reg_data_out_c_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_3_reg_data_out_c_5_SRMUX_OUTPUTNOT
    );
  XLXI_3_reg_data_out_x_6_Q : X_LUT4
    generic map(
      INIT => X"FE04"
    )
    port map (
      ADR0 => N43122,
      ADR1 => N29051,
      ADR2 => CHOICE764,
      ADR3 => XLXI_3_reg_data_out_c(6),
      O => XLXI_3_reg_data_out_c_6_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_6_59 : X_LUT4
    generic map(
      INIT => X"E0A0"
    )
    port map (
      ADR0 => CHOICE2552,
      ADR1 => XLXI_55_mux_c(2),
      ADR2 => XLXI_1_I4_N21650,
      ADR3 => XLXI_3_reg_data_out_x_6_O,
      O => XLXI_3_reg_data_out_c_6_GROM
    );
  XLXI_3_reg_data_out_c_6_XUSED : X_BUF
    port map (
      I => XLXI_3_reg_data_out_c_6_FROM,
      O => XLXI_3_reg_data_out_x_6_O
    );
  XLXI_3_reg_data_out_c_6_YUSED : X_BUF
    port map (
      I => XLXI_3_reg_data_out_c_6_GROM,
      O => CHOICE2554
    );
  XLXI_3_reg_data_out_c_6_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_3_reg_data_out_c_6_SRMUX_OUTPUTNOT
    );
  XLXI_3_reg_data_out_x_7_Q : X_LUT4
    generic map(
      INIT => X"CCD8"
    )
    port map (
      ADR0 => N43132,
      ADR1 => XLXI_3_reg_data_out_c(7),
      ADR2 => N28941,
      ADR3 => CHOICE764,
      O => XLXI_3_reg_data_out_c_7_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_7_59 : X_LUT4
    generic map(
      INIT => X"C8C0"
    )
    port map (
      ADR0 => XLXI_55_mux_c(2),
      ADR1 => XLXI_1_I4_N21650,
      ADR2 => CHOICE2488,
      ADR3 => XLXI_3_reg_data_out_x_7_O,
      O => XLXI_3_reg_data_out_c_7_GROM
    );
  XLXI_3_reg_data_out_c_7_XUSED : X_BUF
    port map (
      I => XLXI_3_reg_data_out_c_7_FROM,
      O => XLXI_3_reg_data_out_x_7_O
    );
  XLXI_3_reg_data_out_c_7_YUSED : X_BUF
    port map (
      I => XLXI_3_reg_data_out_c_7_GROM,
      O => CHOICE2490
    );
  XLXI_3_reg_data_out_c_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_3_reg_data_out_c_7_SRMUX_OUTPUTNOT
    );
  XLXI_1_I2_pc_mux_x_0_25 : X_LUT4
    generic map(
      INIT => X"5020"
    )
    port map (
      ADR0 => XLXI_1_I2_C_raw,
      ADR1 => XLXI_1_skip,
      ADR2 => CHOICE2359,
      ADR3 => XLXI_1_I2_N18844,
      O => CHOICE2367_FROM
    );
  XLXI_1_I2_pc_mux_x_0_79 : X_LUT4
    generic map(
      INIT => X"FFCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CHOICE2381,
      ADR2 => VCC,
      ADR3 => CHOICE2367,
      O => CHOICE2367_GROM
    );
  CHOICE2367_XUSED : X_BUF
    port map (
      I => CHOICE2367_FROM,
      O => CHOICE2367
    );
  CHOICE2367_YUSED : X_BUF
    port map (
      I => CHOICE2367_GROM,
      O => XLXI_1_pc_mux(0)
    );
  XLXI_1_I4_Ker218921_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      ADR0 => IDATA(6),
      ADR1 => XLXI_1_I2_N18996,
      ADR2 => XLXI_1_skip,
      ADR3 => IDATA(0),
      O => XLXI_1_I4_Ker218921_SW0_SW0_O_FROM
    );
  XLXI_1_I4_Ker218921_SW0 : X_LUT4
    generic map(
      INIT => X"F1E0"
    )
    port map (
      ADR0 => IDATA(1),
      ADR1 => IDATA(2),
      ADR2 => N43476,
      ADR3 => XLXI_1_I4_Ker218921_SW0_SW0_O,
      O => XLXI_1_I4_Ker218921_SW0_SW0_O_GROM
    );
  XLXI_1_I4_Ker218921_SW0_SW0_O_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_Ker218921_SW0_SW0_O_FROM,
      O => XLXI_1_I4_Ker218921_SW0_SW0_O
    );
  XLXI_1_I4_Ker218921_SW0_SW0_O_YUSED : X_BUF
    port map (
      I => XLXI_1_I4_Ker218921_SW0_SW0_O_GROM,
      O => N43378
    );
  XLXI_1_I1_iaddr_x_1_55 : X_LUT4
    generic map(
      INIT => X"A000"
    )
    port map (
      ADR0 => CHOICE2426,
      ADR1 => VCC,
      ADR2 => XLXI_1_I1_nreset_v(1),
      ADR3 => NRESET_BUFGP,
      O => XLXI_1_I1_pc_1_FROM
    );
  XLXI_1_I1_iaddr_x_0_55 : X_LUT4
    generic map(
      INIT => X"A000"
    )
    port map (
      ADR0 => NRESET_BUFGP,
      ADR1 => VCC,
      ADR2 => CHOICE2396,
      ADR3 => XLXI_1_I1_nreset_v(1),
      O => XLXI_1_I1_pc_1_GROM
    );
  XLXI_1_I1_pc_1_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_1_FROM,
      O => IADDR(1)
    );
  XLXI_1_I1_pc_1_YUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_1_GROM,
      O => IADDR(0)
    );
  XLXI_1_I1_pc_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I1_pc_1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I1_n00251 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_1_I1_nreset_v(1),
      ADR3 => NRESET_BUFGP,
      O => XLXI_1_I1_pc_2_FROM
    );
  XLXI_1_I1_iaddr_x_2_55 : X_LUT4
    generic map(
      INIT => X"C000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CHOICE2411,
      ADR2 => XLXI_1_I1_nreset_v(1),
      ADR3 => NRESET_BUFGP,
      O => XLXI_1_I1_pc_2_GROM
    );
  XLXI_1_I1_pc_2_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_2_FROM,
      O => XLXI_1_I1_n0025
    );
  XLXI_1_I1_pc_2_YUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_2_GROM,
      O => IADDR(2)
    );
  XLXI_1_I1_pc_2_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I1_pc_2_SRMUX_OUTPUTNOT
    );
  XLXI_1_I1_iaddr_x_3_33 : X_LUT4
    generic map(
      INIT => X"DF00"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(1),
      ADR1 => XLXI_1_I1_stack_addrs_c_0_3,
      ADR2 => XLXI_1_pc_mux(0),
      ADR3 => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_pc_3_FROM
    );
  XLXI_1_I1_iaddr_x_3_60 : X_LUT4
    generic map(
      INIT => X"F0B0"
    )
    port map (
      ADR0 => CHOICE2247,
      ADR1 => N43808,
      ADR2 => XLXI_1_I1_n0025,
      ADR3 => XLXI_1_I1_iaddr_x_3_33_O,
      O => XLXI_1_I1_pc_3_GROM
    );
  XLXI_1_I1_pc_3_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_3_FROM,
      O => XLXI_1_I1_iaddr_x_3_33_O
    );
  XLXI_1_I1_pc_3_YUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_3_GROM,
      O => IADDR(3)
    );
  XLXI_1_I1_pc_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I1_pc_3_SRMUX_OUTPUTNOT
    );
  XLXI_1_I1_iaddr_x_4_33 : X_LUT4
    generic map(
      INIT => X"DF00"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(0),
      ADR1 => XLXI_1_I1_stack_addrs_c_0_4,
      ADR2 => XLXI_1_pc_mux(1),
      ADR3 => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_pc_4_FROM
    );
  XLXI_1_I1_iaddr_x_4_60 : X_LUT4
    generic map(
      INIT => X"F0D0"
    )
    port map (
      ADR0 => N43796,
      ADR1 => CHOICE2349,
      ADR2 => XLXI_1_I1_n0025,
      ADR3 => XLXI_1_I1_iaddr_x_4_33_O,
      O => XLXI_1_I1_pc_4_GROM
    );
  XLXI_1_I1_pc_4_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_4_FROM,
      O => XLXI_1_I1_iaddr_x_4_33_O
    );
  XLXI_1_I1_pc_4_YUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_4_GROM,
      O => IADDR(4)
    );
  XLXI_1_I1_pc_4_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I1_pc_4_SRMUX_OUTPUTNOT
    );
  XLXI_1_I1_iaddr_x_5_33 : X_LUT4
    generic map(
      INIT => X"BF00"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_0_5,
      ADR1 => XLXI_1_pc_mux(0),
      ADR2 => XLXI_1_pc_mux(1),
      ADR3 => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_pc_5_FROM
    );
  XLXI_1_I1_iaddr_x_5_60 : X_LUT4
    generic map(
      INIT => X"F0B0"
    )
    port map (
      ADR0 => CHOICE2332,
      ADR1 => N43804,
      ADR2 => XLXI_1_I1_n0025,
      ADR3 => XLXI_1_I1_iaddr_x_5_33_O,
      O => XLXI_1_I1_pc_5_GROM
    );
  XLXI_1_I1_pc_5_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_5_FROM,
      O => XLXI_1_I1_iaddr_x_5_33_O
    );
  XLXI_1_I1_pc_5_YUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_5_GROM,
      O => IADDR(5)
    );
  XLXI_1_I1_pc_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I1_pc_5_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_skip_l123 : X_LUT4
    generic map(
      INIT => X"8C80"
    )
    port map (
      ADR0 => N43128,
      ADR1 => CHOICE3042,
      ADR2 => CHOICE3026,
      ADR3 => N43126,
      O => XLXI_1_I2_skip_c_FROM
    );
  XLXI_1_I3_skip1 : X_LUT4
    generic map(
      INIT => X"5500"
    )
    port map (
      ADR0 => XLXI_1_I2_int_start_c,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_1_I3_skip_l,
      O => XLXI_1_I2_skip_c_GROM
    );
  XLXI_1_I2_skip_c_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_skip_c_FROM,
      O => XLXI_1_I3_skip_l
    );
  XLXI_1_I2_skip_c_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_skip_c_GROM,
      O => XLXI_1_skip
    );
  XLXI_1_I2_skip_c_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_skip_c_SRMUX_OUTPUTNOT
    );
  XLXI_1_I5_Mmux_daddr_out_Result_8_1 : X_LUT4
    generic map(
      INIT => X"FE10"
    )
    port map (
      ADR0 => XLXI_1_I4_Ker217601_1,
      ADR1 => XLXI_1_ndre_int,
      ADR2 => XLXI_1_adaddr_out(8),
      ADR3 => XLXI_1_I5_daddr_c(8),
      O => CPU_ADDR_OUT_8_FROM
    );
  XLXI_55_nCS_TIMER_SW0 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => NRESET_BUFGP,
      ADR3 => CPU_ADDR_OUT(8),
      O => CPU_ADDR_OUT_8_GROM
    );
  CPU_ADDR_OUT_8_XUSED : X_BUF
    port map (
      I => CPU_ADDR_OUT_8_FROM,
      O => CPU_ADDR_OUT(8)
    );
  CPU_ADDR_OUT_8_YUSED : X_BUF
    port map (
      I => CPU_ADDR_OUT_8_GROM,
      O => N28714
    );
  XLXI_6_n00511 : X_LUT4
    generic map(
      INIT => X"0300"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I5_ndwe_c,
      ADR2 => nCS_UART,
      ADR3 => XLXI_1_I5_Mmux_daddr_out_Result_0_1_1,
      O => XLXI_6_tx_clk_div_5_FROM
    );
  XLXI_6_n0014_5_1 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => CPU_DATA_OUT(5),
      ADR1 => XLXI_6_tx_clk_div(5),
      ADR2 => XLXI_6_N15034,
      ADR3 => XLXI_6_n0051,
      O => XLXI_6_n0014_5_1_O
    );
  XLXI_6_tx_clk_div_5_XUSED : X_BUF
    port map (
      I => XLXI_6_tx_clk_div_5_FROM,
      O => XLXI_6_n0051
    );
  XLXI_6_tx_clk_div_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_clk_div_5_SRMUX_OUTPUTNOT
    );
  XLXI_6_Ker150321 : X_LUT4
    generic map(
      INIT => X"FFF5"
    )
    port map (
      ADR0 => XLXI_1_I5_Mmux_daddr_out_Result_0_1_1,
      ADR1 => VCC,
      ADR2 => nCS_UART,
      ADR3 => XLXI_1_I5_ndwe_c,
      O => XLXI_6_tx_clk_div_6_FROM
    );
  XLXI_6_n0014_6_1 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_6_tx_clk_div(6),
      ADR1 => XLXI_6_n0051,
      ADR2 => CPU_DATA_OUT(6),
      ADR3 => XLXI_6_N15034,
      O => XLXI_6_n0014_6_1_O
    );
  XLXI_6_tx_clk_div_6_XUSED : X_BUF
    port map (
      I => XLXI_6_tx_clk_div_6_FROM,
      O => XLXI_6_N15034
    );
  XLXI_6_tx_clk_div_6_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_clk_div_6_SRMUX_OUTPUTNOT
    );
  XLXI_1_I2_n006236_SW1 : X_LUT4
    generic map(
      INIT => X"BBFB"
    )
    port map (
      ADR0 => XLXI_1_I2_N18996,
      ADR1 => CHOICE3008,
      ADR2 => XLXI_1_I3_skip_l,
      ADR3 => XLXI_1_I2_int_start_c,
      O => XLXI_1_I2_n006236_SW1_O_FROM
    );
  XLXI_1_I2_n006236 : X_LUT4
    generic map(
      INIT => X"000E"
    )
    port map (
      ADR0 => IDATA(1),
      ADR1 => IDATA(2),
      ADR2 => IDATA(3),
      ADR3 => XLXI_1_I2_n006236_SW1_O,
      O => XLXI_1_I2_n006236_SW1_O_GROM
    );
  XLXI_1_I2_n006236_SW1_O_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_n006236_SW1_O_FROM,
      O => XLXI_1_I2_n006236_SW1_O
    );
  XLXI_1_I2_n006236_SW1_O_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_n006236_SW1_O_GROM,
      O => XLXI_1_I2_C_raw
    );
  XLXI_3_out_1reg_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => OUT1_REG_4_OD,
      CE => XLXI_3_n0002,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => OUT1_REG_4_OFF_RST,
      O => XLXI_3_out_1reg(4)
    );
  OUT1_REG_4_OFF_RSTOR : X_OR2
    port map (
      I0 => OUT1_REG_4_SRMUXNOT,
      I1 => GSR,
      O => OUT1_REG_4_OFF_RST
    );
  XLXI_1_I2_ndre_x1 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => XLXI_1_I2_C_raw,
      ADR1 => N43080,
      ADR2 => IDATA(3),
      ADR3 => XLXI_1_skip,
      O => XLXI_1_ndre_int_FROM
    );
  XLXI_1_I4_Ker21648 : X_LUT4
    generic map(
      INIT => X"FFFD"
    )
    port map (
      ADR0 => CHOICE3059,
      ADR1 => N28827,
      ADR2 => IDATA(6),
      ADR3 => XLXI_1_ndre_int,
      O => XLXI_1_ndre_int_GROM
    );
  XLXI_1_ndre_int_XUSED : X_BUF
    port map (
      I => XLXI_1_ndre_int_FROM,
      O => XLXI_1_ndre_int
    );
  XLXI_1_ndre_int_YUSED : X_BUF
    port map (
      I => XLXI_1_ndre_int_GROM,
      O => XLXI_1_I4_N21650
    );
  XLXI_1_I4_n005725 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => IDATA(13),
      ADR1 => IDATA(12),
      ADR2 => IDATA(11),
      ADR3 => IDATA(10),
      O => XLXI_1_I4_n005725_O_FROM
    );
  XLXI_1_I4_n005730 : X_LUT4
    generic map(
      INIT => X"0100"
    )
    port map (
      ADR0 => IDATA(9),
      ADR1 => IDATA(8),
      ADR2 => IDATA(7),
      ADR3 => XLXI_1_I4_n005725_O,
      O => XLXI_1_I4_n005725_O_GROM
    );
  XLXI_1_I4_n005725_O_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_n005725_O_FROM,
      O => XLXI_1_I4_n005725_O
    );
  XLXI_1_I4_n005725_O_YUSED : X_BUF
    port map (
      I => XLXI_1_I4_n005725_O_GROM,
      O => CHOICE3059
    );
  XLXI_55_nCS_INT : X_LUT4
    generic map(
      INIT => X"FFF7"
    )
    port map (
      ADR0 => CPU_ADDR_OUT(8),
      ADR1 => N28675,
      ADR2 => CPU_ADDR_OUT(3),
      ADR3 => CPU_ADDR_OUT(4),
      O => nCS_INT_FROM
    );
  XLXI_4_Ker138041 : X_LUT4
    generic map(
      INIT => X"FFF5"
    )
    port map (
      ADR0 => CPU_ADDR_OUT(0),
      ADR1 => VCC,
      ADR2 => XLXI_1_I5_ndwe_c,
      ADR3 => nCS_INT,
      O => nCS_INT_GROM
    );
  nCS_INT_XUSED : X_BUF
    port map (
      I => nCS_INT_FROM,
      O => nCS_INT
    );
  nCS_INT_YUSED : X_BUF
    port map (
      I => nCS_INT_GROM,
      O => XLXI_4_N13806
    );
  XLXI_55_nCS_TIMER : X_LUT4
    generic map(
      INIT => X"F7FF"
    )
    port map (
      ADR0 => CPU_ADDR_OUT(2),
      ADR1 => CPU_ADDR_OUT(3),
      ADR2 => CPU_ADDR_OUT(4),
      ADR3 => N28714,
      O => nCS_TIMER_FROM
    );
  XLXI_5_Ker145501 : X_LUT4
    generic map(
      INIT => X"0005"
    )
    port map (
      ADR0 => XLXI_1_I5_ndwe_c,
      ADR1 => VCC,
      ADR2 => CPU_ADDR_OUT(0),
      ADR3 => nCS_TIMER,
      O => nCS_TIMER_GROM
    );
  nCS_TIMER_XUSED : X_BUF
    port map (
      I => nCS_TIMER_FROM,
      O => nCS_TIMER
    );
  nCS_TIMER_YUSED : X_BUF
    port map (
      I => nCS_TIMER_GROM,
      O => XLXI_5_N14552
    );
  XLXI_6_n0014_1_1 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_6_n0051,
      ADR1 => CPU_DATA_OUT(1),
      ADR2 => XLXI_6_tx_clk_div(1),
      ADR3 => XLXI_6_N15034,
      O => XLXI_6_n0014_1_1_O
    );
  XLXI_6_n0014_0_1 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_6_n0051,
      ADR1 => CPU_DATA_OUT(0),
      ADR2 => XLXI_6_tx_clk_div(0),
      ADR3 => XLXI_6_N15034,
      O => XLXI_6_n0014_0_1_O
    );
  XLXI_6_tx_clk_div_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_clk_div_1_SRMUX_OUTPUTNOT
    );
  XLXI_6_n0014_3_1 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_6_tx_clk_div(3),
      ADR1 => XLXI_6_N15034,
      ADR2 => CPU_DATA_OUT(3),
      ADR3 => XLXI_6_n0051,
      O => XLXI_6_n0014_3_1_O
    );
  XLXI_6_n0014_2_1 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => CPU_DATA_OUT(2),
      ADR1 => XLXI_6_tx_clk_div(2),
      ADR2 => XLXI_6_N15034,
      ADR3 => XLXI_6_n0051,
      O => XLXI_6_n0014_2_1_O
    );
  XLXI_6_tx_clk_div_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_clk_div_3_SRMUX_OUTPUTNOT
    );
  XLXI_5_n0005_4_31 : X_LUT4
    generic map(
      INIT => X"7F00"
    )
    port map (
      ADR0 => CHOICE870,
      ADR1 => CHOICE877,
      ADR2 => XLXI_5_tmr_enable,
      ADR3 => CPU_DATA_OUT(4),
      O => XLXI_6_tx_clk_div_4_FROM
    );
  XLXI_6_n0014_4_1 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_6_tx_clk_div(4),
      ADR1 => CPU_DATA_OUT(4),
      ADR2 => XLXI_6_N15034,
      ADR3 => XLXI_6_n0051,
      O => XLXI_6_n0014_4_1_O
    );
  XLXI_6_tx_clk_div_4_XUSED : X_BUF
    port map (
      I => XLXI_6_tx_clk_div_4_FROM,
      O => CHOICE951
    );
  XLXI_6_tx_clk_div_4_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_clk_div_4_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_n00231 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => XLXI_1_I3_nreset_v(0),
      ADR1 => XLXI_1_I3_nreset_v(1),
      ADR2 => NRESET_BUFGP,
      ADR3 => XLXI_1_I2_valid_c,
      O => XLXI_1_I3_n0023_FROM
    );
  XLXI_1_I3_skip_l121 : X_LUT4
    generic map(
      INIT => X"0300"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I2_TC_c(0),
      ADR2 => XLXI_1_I2_TC_c(1),
      ADR3 => XLXI_1_I3_n0023,
      O => XLXI_1_I3_n0023_GROM
    );
  XLXI_1_I3_n0023_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0023_FROM,
      O => XLXI_1_I3_n0023
    );
  XLXI_1_I3_n0023_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0023_GROM,
      O => CHOICE3042
    );
  XLXI_55_nCS_UART_SW0 : X_LUT4
    generic map(
      INIT => X"C0C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => NRESET_BUFGP,
      ADR2 => CPU_ADDR_OUT(4),
      ADR3 => VCC,
      O => XLXI_55_nCS_UART_SW0_O_FROM
    );
  XLXI_55_nCS_UART : X_LUT4
    generic map(
      INIT => X"FBFF"
    )
    port map (
      ADR0 => CPU_ADDR_OUT(3),
      ADR1 => CPU_ADDR_OUT(8),
      ADR2 => CPU_ADDR_OUT(2),
      ADR3 => XLXI_55_nCS_UART_SW0_O,
      O => XLXI_55_nCS_UART_SW0_O_GROM
    );
  XLXI_55_nCS_UART_SW0_O_XUSED : X_BUF
    port map (
      I => XLXI_55_nCS_UART_SW0_O_FROM,
      O => XLXI_55_nCS_UART_SW0_O
    );
  XLXI_55_nCS_UART_SW0_O_YUSED : X_BUF
    port map (
      I => XLXI_55_nCS_UART_SW0_O_GROM,
      O => nCS_UART
    );
  XLXI_1_I1_n0016_8_40 : X_MUX2
    port map (
      IA => N44746,
      IB => N44748,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0016(8)
    );
  XLXI_1_I1_n0016_8_40_G : X_LUT4
    generic map(
      INIT => X"EC4C"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR1 => XLXI_1_I1_stack_addrs_c_4_8,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR3 => XLXI_1_I1_stack_addrs_c_6_8,
      O => N44748
    );
  XLXI_1_I1_n0016_8_40_F : X_LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR1 => XLXI_1_I1_stack_addrs_c_4_8,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR3 => XLXI_1_I1_stack_addrs_c_5_8,
      O => N44746
    );
  XLXI_1_I1_n0018_0_40 : X_MUX2
    port map (
      IA => N44691,
      IB => N44693,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0018(0)
    );
  XLXI_1_I1_n0018_0_40_G : X_LUT4
    generic map(
      INIT => X"E4CC"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR1 => XLXI_1_I1_stack_addrs_c_2_0,
      ADR2 => XLXI_1_I1_stack_addrs_c_4_0,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_1,
      O => N44693
    );
  XLXI_1_I1_n0018_0_40_F : X_LUT4
    generic map(
      INIT => X"ACCC"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_2_0,
      ADR1 => XLXI_1_I1_stack_addrs_c_3_0,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR3 => XLXI_1_pc_mux(0),
      O => N44691
    );
  XLXI_1_I1_n0016_9_40 : X_MUX2
    port map (
      IA => N44776,
      IB => N44778,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0016(9)
    );
  XLXI_1_I1_n0016_9_40_G : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_4_9,
      ADR1 => XLXI_1_I1_stack_addrs_c_6_9,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_3,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_2,
      O => N44778
    );
  XLXI_1_I1_n0016_9_40_F : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_4_9,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR2 => XLXI_1_I1_stack_addrs_c_5_9,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_3,
      O => N44776
    );
  XLXI_1_I1_n0017_5_40 : X_MUX2
    port map (
      IA => N44696,
      IB => N44698,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0017(5)
    );
  XLXI_1_I1_n0017_5_40_G : X_LUT4
    generic map(
      INIT => X"F780"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR2 => XLXI_1_I1_stack_addrs_c_5_5,
      ADR3 => XLXI_1_I1_stack_addrs_c_3_5,
      O => N44698
    );
  XLXI_1_I1_n0017_5_40_F : X_LUT4
    generic map(
      INIT => X"F780"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR2 => XLXI_1_I1_stack_addrs_c_3_5,
      ADR3 => XLXI_1_I1_stack_addrs_c_4_5,
      O => N44696
    );
  XLXI_1_I1_n0018_1_40 : X_MUX2
    port map (
      IA => N44626,
      IB => N44628,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0018(1)
    );
  XLXI_1_I1_n0018_1_40_G : X_LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR1 => XLXI_1_I1_stack_addrs_c_4_1,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR3 => XLXI_1_I1_stack_addrs_c_2_1,
      O => N44628
    );
  XLXI_1_I1_n0018_1_40_F : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_2_1,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR2 => XLXI_1_I1_stack_addrs_c_3_1,
      ADR3 => XLXI_1_pc_mux(0),
      O => N44626
    );
  XLXI_1_I1_n0017_6_40 : X_MUX2
    port map (
      IA => N44921,
      IB => N44923,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0017(6)
    );
  XLXI_1_I1_n0017_6_40_G : X_LUT4
    generic map(
      INIT => X"E4CC"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR1 => XLXI_1_I1_stack_addrs_c_3_6,
      ADR2 => XLXI_1_I1_stack_addrs_c_5_6,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_2,
      O => N44923
    );
  XLXI_1_I1_n0017_6_40_F : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_3_6,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR2 => XLXI_1_I1_stack_addrs_c_4_6,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_2,
      O => N44921
    );
  XLXI_1_I1_n0018_2_40 : X_MUX2
    port map (
      IA => N44606,
      IB => N44608,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0018(2)
    );
  XLXI_1_I1_n0018_2_40_G : X_LUT4
    generic map(
      INIT => X"D8F0"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR1 => XLXI_1_I1_stack_addrs_c_4_2,
      ADR2 => XLXI_1_I1_stack_addrs_c_2_2,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_2,
      O => N44608
    );
  XLXI_1_I1_n0018_2_40_F : X_LUT4
    generic map(
      INIT => X"E2AA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_3_2,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR2 => XLXI_1_I1_stack_addrs_c_2_2,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_2,
      O => N44606
    );
  XLXI_1_I1_n0017_7_40 : X_MUX2
    port map (
      IA => N44816,
      IB => N44818,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0017(7)
    );
  XLXI_1_I1_n0017_7_40_G : X_LUT4
    generic map(
      INIT => X"F780"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR2 => XLXI_1_I1_stack_addrs_c_5_7,
      ADR3 => XLXI_1_I1_stack_addrs_c_3_7,
      O => N44818
    );
  XLXI_1_I1_n0017_7_40_F : X_LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_3_7,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR3 => XLXI_1_I1_stack_addrs_c_4_7,
      O => N44816
    );
  XLXI_1_I1_n0018_3_40 : X_MUX2
    port map (
      IA => N44651,
      IB => N44653,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0018(3)
    );
  XLXI_1_I1_n0018_3_40_G : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_2_3,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR3 => XLXI_1_I1_stack_addrs_c_4_3,
      O => N44653
    );
  XLXI_1_I1_n0018_3_40_F : X_LUT4
    generic map(
      INIT => X"F780"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR2 => XLXI_1_I1_stack_addrs_c_2_3,
      ADR3 => XLXI_1_I1_stack_addrs_c_3_3,
      O => N44651
    );
  XLXI_1_I1_n0017_8_40 : X_MUX2
    port map (
      IA => N44756,
      IB => N44758,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0017(8)
    );
  XLXI_1_I1_n0017_8_40_G : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_3_8,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR3 => XLXI_1_I1_stack_addrs_c_5_8,
      O => N44758
    );
  XLXI_1_I1_n0017_8_40_F : X_LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR1 => XLXI_1_I1_stack_addrs_c_3_8,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR3 => XLXI_1_I1_stack_addrs_c_4_8,
      O => N44756
    );
  XLXI_1_I1_n0019_0_40 : X_MUX2
    port map (
      IA => N44736,
      IB => N44738,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0019(0)
    );
  XLXI_1_I1_n0019_0_40_G : X_LUT4
    generic map(
      INIT => X"F780"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR2 => XLXI_1_I1_stack_addrs_c_3_0,
      ADR3 => XLXI_1_I1_stack_addrs_c_1_0,
      O => N44738
    );
  XLXI_1_I1_n0019_0_40_F : X_LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_1_0,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR3 => XLXI_1_I1_stack_addrs_c_2_0,
      O => N44736
    );
  XLXI_1_I1_n0018_4_40 : X_MUX2
    port map (
      IA => N44671,
      IB => N44673,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0018(4)
    );
  XLXI_1_I1_n0018_4_40_G : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR2 => XLXI_1_I1_stack_addrs_c_2_4,
      ADR3 => XLXI_1_I1_stack_addrs_c_4_4,
      O => N44673
    );
  XLXI_1_I1_n0018_4_40_F : X_LUT4
    generic map(
      INIT => X"D8F0"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR1 => XLXI_1_I1_stack_addrs_c_2_4,
      ADR2 => XLXI_1_I1_stack_addrs_c_3_4,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_4,
      O => N44671
    );
  XLXI_3_out_0reg_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => OUT0_REG_6_OD,
      CE => XLXI_3_n0006,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => OUT0_REG_6_OFF_RST,
      O => XLXI_3_out_0reg(6)
    );
  OUT0_REG_6_OFF_RSTOR : X_OR2
    port map (
      I0 => OUT0_REG_6_SRMUXNOT,
      I1 => GSR,
      O => OUT0_REG_6_OFF_RST
    );
  XLXI_1_I1_n0018_5_40 : X_MUX2
    port map (
      IA => N44826,
      IB => N44828,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0018(5)
    );
  XLXI_1_I1_n0018_5_40_G : X_LUT4
    generic map(
      INIT => X"D8F0"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR1 => XLXI_1_I1_stack_addrs_c_4_5,
      ADR2 => XLXI_1_I1_stack_addrs_c_2_5,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_2,
      O => N44828
    );
  XLXI_1_I1_n0018_5_40_F : X_LUT4
    generic map(
      INIT => X"E2AA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_3_5,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR2 => XLXI_1_I1_stack_addrs_c_2_5,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_4,
      O => N44826
    );
  XLXI_1_I1_n0017_9_40 : X_MUX2
    port map (
      IA => N44701,
      IB => N44703,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0017(9)
    );
  XLXI_1_I1_n0017_9_40_G : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_3_9,
      ADR1 => XLXI_1_I1_stack_addrs_c_5_9,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_2,
      O => N44703
    );
  XLXI_1_I1_n0017_9_40_F : X_LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR1 => XLXI_1_I1_stack_addrs_c_3_9,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR3 => XLXI_1_I1_stack_addrs_c_4_9,
      O => N44701
    );
  XLXI_1_I1_n0019_1_40 : X_MUX2
    port map (
      IA => N44591,
      IB => N44593,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0019(1)
    );
  XLXI_1_I1_n0019_1_40_G : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_3_1,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR2 => XLXI_1_I1_stack_addrs_c_1_1,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_1,
      O => N44593
    );
  XLXI_1_I1_n0019_1_40_F : X_LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR1 => XLXI_1_I1_stack_addrs_c_1_1,
      ADR2 => XLXI_1_pc_mux(0),
      ADR3 => XLXI_1_I1_stack_addrs_c_2_1,
      O => N44591
    );
  XLXI_1_I1_n0018_6_40 : X_MUX2
    port map (
      IA => N44711,
      IB => N44713,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0018(6)
    );
  XLXI_1_I1_n0018_6_40_G : X_LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR1 => XLXI_1_I1_stack_addrs_c_4_6,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR3 => XLXI_1_I1_stack_addrs_c_2_6,
      O => N44713
    );
  XLXI_1_I1_n0018_6_40_F : X_LUT4
    generic map(
      INIT => X"E2AA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_3_6,
      ADR1 => XLXI_1_pc_mux(0),
      ADR2 => XLXI_1_I1_stack_addrs_c_2_6,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_4,
      O => N44711
    );
  XLXI_1_I1_n0019_2_40 : X_MUX2
    port map (
      IA => N44616,
      IB => N44618,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0019(2)
    );
  XLXI_1_I1_n0019_2_40_G : X_LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_3_2,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR3 => XLXI_1_I1_stack_addrs_c_1_2,
      O => N44618
    );
  XLXI_1_I1_n0019_2_40_F : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_2_2,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR3 => XLXI_1_I1_stack_addrs_c_1_2,
      O => N44616
    );
  XLXI_1_I1_n0019_3_40 : X_MUX2
    port map (
      IA => N44681,
      IB => N44683,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0019(3)
    );
  XLXI_1_I1_n0019_3_40_G : X_LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR1 => XLXI_1_I1_stack_addrs_c_3_3,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR3 => XLXI_1_I1_stack_addrs_c_1_3,
      O => N44683
    );
  XLXI_1_I1_n0019_3_40_F : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_2_3,
      ADR1 => XLXI_1_I1_stack_addrs_c_1_3,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_4,
      O => N44681
    );
  XLXI_1_I1_n0018_7_40 : X_MUX2
    port map (
      IA => N44596,
      IB => N44598,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0018(7)
    );
  XLXI_1_I1_n0018_7_40_G : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_2_7,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR2 => XLXI_1_pc_mux(0),
      ADR3 => XLXI_1_I1_stack_addrs_c_4_7,
      O => N44598
    );
  XLXI_1_I1_n0018_7_40_F : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_2_7,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR2 => XLXI_1_I1_stack_addrs_c_3_7,
      ADR3 => XLXI_1_pc_mux(0),
      O => N44596
    );
  XLXI_1_I1_n0019_4_40 : X_MUX2
    port map (
      IA => N44786,
      IB => N44788,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0019(4)
    );
  XLXI_1_I1_n0019_4_40_G : X_LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR1 => XLXI_1_I1_stack_addrs_c_3_4,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR3 => XLXI_1_I1_stack_addrs_c_1_4,
      O => N44788
    );
  XLXI_1_I1_n0019_4_40_F : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_2_4,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR3 => XLXI_1_I1_stack_addrs_c_1_4,
      O => N44786
    );
  XLXI_1_I1_n0018_8_40 : X_MUX2
    port map (
      IA => N44586,
      IB => N44588,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0018(8)
    );
  XLXI_1_I1_n0018_8_40_G : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_4_8,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR2 => XLXI_1_I1_stack_addrs_c_2_8,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_2,
      O => N44588
    );
  XLXI_1_I1_n0018_8_40_F : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_3_8,
      ADR1 => XLXI_1_pc_mux(0),
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_4,
      ADR3 => XLXI_1_I1_stack_addrs_c_2_8,
      O => N44586
    );
  XLXI_1_I1_n0019_5_40 : X_MUX2
    port map (
      IA => N44631,
      IB => N44633,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0019(5)
    );
  XLXI_1_I1_n0019_5_40_G : X_LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR1 => XLXI_1_I1_stack_addrs_c_3_5,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR3 => XLXI_1_I1_stack_addrs_c_1_5,
      O => N44633
    );
  XLXI_1_I1_n0019_5_40_F : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_2_5,
      ADR1 => XLXI_1_I1_stack_addrs_c_1_5,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_4,
      O => N44631
    );
  XLXI_1_I1_n0018_9_40 : X_MUX2
    port map (
      IA => N44611,
      IB => N44613,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0018(9)
    );
  XLXI_1_I1_n0018_9_40_G : X_LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR1 => XLXI_1_I1_stack_addrs_c_4_9,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR3 => XLXI_1_I1_stack_addrs_c_2_9,
      O => N44613
    );
  XLXI_1_I1_n0018_9_40_F : X_LUT4
    generic map(
      INIT => X"D8F0"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_2,
      ADR1 => XLXI_1_I1_stack_addrs_c_2_9,
      ADR2 => XLXI_1_I1_stack_addrs_c_3_9,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_4,
      O => N44611
    );
  XLXI_1_I1_n0019_6_40 : X_MUX2
    port map (
      IA => N44601,
      IB => N44603,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0019(6)
    );
  XLXI_1_I1_n0019_6_40_G : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_1_6,
      ADR1 => XLXI_1_I1_stack_addrs_c_3_6,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_1,
      O => N44603
    );
  XLXI_1_I1_n0019_6_40_F : X_LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_1_6,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR3 => XLXI_1_I1_stack_addrs_c_2_6,
      O => N44601
    );
  XLXI_1_I3_n0115_0_132 : X_MUX2
    port map (
      IA => N44946,
      IB => N44948,
      SEL => XLXI_1_I2_TD_c(2),
      O => CHOICE2462_F5MUX
    );
  XLXI_1_I3_n0115_0_132_G : X_LUT4
    generic map(
      INIT => X"02C2"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_1,
      ADR1 => XLXI_1_I2_TD_c(0),
      ADR2 => XLXI_1_I2_TD_c(1),
      ADR3 => XLXI_1_I3_acc_c_0_0,
      O => N44948
    );
  XLXI_1_I3_n0115_0_132_F : X_LUT4
    generic map(
      INIT => X"22C0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_1,
      ADR1 => XLXI_1_I2_TD_c(0),
      ADR2 => XLXI_1_I3_acc_c_0_8,
      ADR3 => XLXI_1_I2_TD_c(1),
      O => N44946
    );
  CHOICE2462_XUSED : X_BUF
    port map (
      I => CHOICE2462_F5MUX,
      O => CHOICE2462
    );
  XLXI_1_I1_n0019_7_40 : X_MUX2
    port map (
      IA => N44636,
      IB => N44638,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0019(7)
    );
  XLXI_1_I1_n0019_7_40_G : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_3_7,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR2 => XLXI_1_I1_stack_addrs_c_1_7,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_1,
      O => N44638
    );
  XLXI_1_I1_n0019_7_40_F : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR2 => XLXI_1_I1_stack_addrs_c_2_7,
      ADR3 => XLXI_1_I1_stack_addrs_c_1_7,
      O => N44636
    );
  XLXI_1_I1_n0019_8_40 : X_MUX2
    port map (
      IA => N44676,
      IB => N44678,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0019(8)
    );
  XLXI_1_I1_n0019_8_40_G : X_LUT4
    generic map(
      INIT => X"F780"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR2 => XLXI_1_I1_stack_addrs_c_3_8,
      ADR3 => XLXI_1_I1_stack_addrs_c_1_8,
      O => N44678
    );
  XLXI_1_I1_n0019_8_40_F : X_LUT4
    generic map(
      INIT => X"E2AA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_2_8,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR2 => XLXI_1_I1_stack_addrs_c_1_8,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_3,
      O => N44676
    );
  XLXI_1_I1_n0019_9_40 : X_MUX2
    port map (
      IA => N44931,
      IB => N44933,
      SEL => XLXI_1_I2_pc_mux_x_2_1,
      O => XLXI_1_I1_n0019(9)
    );
  XLXI_1_I1_n0019_9_40_G : X_LUT4
    generic map(
      INIT => X"E2AA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_1_9,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_1,
      ADR2 => XLXI_1_I1_stack_addrs_c_3_9,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_1,
      O => N44933
    );
  XLXI_1_I1_n0019_9_40_F : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_2_9,
      ADR1 => XLXI_1_I1_stack_addrs_c_1_9,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR3 => XLXI_1_pc_mux(0),
      O => N44931
    );
  XLXI_1_I1_iaddr_x_0_44 : X_MUX2
    port map (
      IA => N44916,
      IB => N44918,
      SEL => XLXI_1_pc_mux(1),
      O => CHOICE2396_F5MUX
    );
  XLXI_1_I1_iaddr_x_0_44_G : X_LUT4
    generic map(
      INIT => X"B830"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_0_0,
      ADR1 => XLXI_1_I2_pc_mux_x_2_1,
      ADR2 => IDATA(4),
      ADR3 => XLXI_1_pc_mux(0),
      O => N44918
    );
  XLXI_1_I1_iaddr_x_0_44_F : X_LUT4
    generic map(
      INIT => X"1144"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_2_1,
      ADR1 => XLXI_1_I1_pc(0),
      ADR2 => VCC,
      ADR3 => XLXI_1_pc_mux(0),
      O => N44916
    );
  CHOICE2396_XUSED : X_BUF
    port map (
      I => CHOICE2396_F5MUX,
      O => CHOICE2396
    );
  XLXI_1_I1_iaddr_x_1_44 : X_MUX2
    port map (
      IA => N44621,
      IB => N44623,
      SEL => XLXI_1_pc_mux(1),
      O => CHOICE2426_F5MUX
    );
  XLXI_1_I1_iaddr_x_1_44_G : X_LUT4
    generic map(
      INIT => X"AC0C"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_0_1,
      ADR1 => IDATA(5),
      ADR2 => XLXI_1_I2_pc_mux_x_2_1,
      ADR3 => XLXI_1_pc_mux(0),
      O => N44623
    );
  XLXI_1_I1_iaddr_x_1_44_F : X_LUT4
    generic map(
      INIT => X"0D08"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(0),
      ADR1 => XLXI_1_I1_n0024(1),
      ADR2 => XLXI_1_I2_pc_mux_x_2_1,
      ADR3 => XLXI_1_I1_pc(1),
      O => N44621
    );
  CHOICE2426_XUSED : X_BUF
    port map (
      I => CHOICE2426_F5MUX,
      O => CHOICE2426
    );
  XLXI_1_I1_iaddr_x_2_44 : X_MUX2
    port map (
      IA => N44661,
      IB => N44663,
      SEL => XLXI_1_pc_mux(1),
      O => CHOICE2411_F5MUX
    );
  XLXI_1_I1_iaddr_x_2_44_G : X_LUT4
    generic map(
      INIT => X"C0AA"
    )
    port map (
      ADR0 => IDATA(6),
      ADR1 => XLXI_1_pc_mux(0),
      ADR2 => XLXI_1_I1_stack_addrs_c_0_2,
      ADR3 => XLXI_1_I2_pc_mux_x_2_1,
      O => N44663
    );
  XLXI_1_I1_iaddr_x_2_44_F : X_LUT4
    generic map(
      INIT => X"3202"
    )
    port map (
      ADR0 => XLXI_1_I1_pc(2),
      ADR1 => XLXI_1_I2_pc_mux_x_2_1,
      ADR2 => XLXI_1_pc_mux(0),
      ADR3 => XLXI_1_I1_n0024(2),
      O => N44661
    );
  CHOICE2411_XUSED : X_BUF
    port map (
      I => CHOICE2411_F5MUX,
      O => CHOICE2411
    );
  XLXI_3_out_0reg_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => OUT0_REG_7_OD,
      CE => XLXI_3_n0006,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => OUT0_REG_7_OFF_RST,
      O => XLXI_3_out_0reg(7)
    );
  OUT0_REG_7_OFF_RSTOR : X_OR2
    port map (
      I0 => OUT0_REG_7_SRMUXNOT,
      I1 => GSR,
      O => OUT0_REG_7_OFF_RST
    );
  XLXI_1_I4_Madd_n0046_inst_lut2_47_LOGIC_ZERO_70 : X_ZERO
    port map (
      O => XLXI_1_I4_Madd_n0046_inst_lut2_47_LOGIC_ZERO
    );
  XLXI_1_I4_Madd_n0046_inst_cy_56_71 : X_MUX2
    port map (
      IA => XLXI_1_I4_iinc_c(0),
      IB => XLXI_1_I4_Madd_n0046_inst_lut2_47_LOGIC_ZERO,
      SEL => XLXI_1_I4_Madd_n0046_inst_lut2_47_FROM,
      O => XLXI_1_I4_Madd_n0046_inst_cy_56
    );
  XLXI_1_I4_Madd_n0046_inst_lut2_471 : X_LUT4
    generic map(
      INIT => X"5A5A"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_c(0),
      ADR1 => VCC,
      ADR2 => XLXI_1_I4_ireg_c(0),
      ADR3 => VCC,
      O => XLXI_1_I4_Madd_n0046_inst_lut2_47_FROM
    );
  XLXI_1_I4_Madd_n0046_inst_lut2_481 : X_LUT4
    generic map(
      INIT => X"55AA"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_c(1),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_1_I4_ireg_c(1),
      O => XLXI_1_I4_Madd_n0046_inst_lut2_48
    );
  XLXI_1_I4_Madd_n0046_inst_lut2_47_COUTUSED : X_BUF
    port map (
      I => XLXI_1_I4_Madd_n0046_inst_lut2_47_CYMUXG,
      O => XLXI_1_I4_Madd_n0046_inst_cy_57
    );
  XLXI_1_I4_Madd_n0046_inst_lut2_47_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_Madd_n0046_inst_lut2_47_FROM,
      O => XLXI_1_I4_Madd_n0046_inst_lut2_47
    );
  XLXI_1_I4_Madd_n0046_inst_lut2_47_YUSED : X_BUF
    port map (
      I => XLXI_1_I4_Madd_n0046_inst_lut2_47_XORG,
      O => XLXI_1_I4_n0046(1)
    );
  XLXI_1_I4_Madd_n0046_inst_cy_57_72 : X_MUX2
    port map (
      IA => XLXI_1_I4_iinc_c(1),
      IB => XLXI_1_I4_Madd_n0046_inst_cy_56,
      SEL => XLXI_1_I4_Madd_n0046_inst_lut2_48,
      O => XLXI_1_I4_Madd_n0046_inst_lut2_47_CYMUXG
    );
  XLXI_1_I4_Madd_n0046_inst_sum_56 : X_XOR2
    port map (
      I0 => XLXI_1_I4_Madd_n0046_inst_cy_56,
      I1 => XLXI_1_I4_Madd_n0046_inst_lut2_48,
      O => XLXI_1_I4_Madd_n0046_inst_lut2_47_XORG
    );
  XLXI_1_I4_Madd_n0046_inst_cy_58_73 : X_MUX2
    port map (
      IA => XLXI_1_I4_iinc_c(2),
      IB => XLXI_1_I4_n0046_2_CYINIT,
      SEL => XLXI_1_I4_Madd_n0046_inst_lut2_49,
      O => XLXI_1_I4_Madd_n0046_inst_cy_58
    );
  XLXI_1_I4_Madd_n0046_inst_sum_57 : X_XOR2
    port map (
      I0 => XLXI_1_I4_n0046_2_CYINIT,
      I1 => XLXI_1_I4_Madd_n0046_inst_lut2_49,
      O => XLXI_1_I4_n0046_2_XORF
    );
  XLXI_1_I4_Madd_n0046_inst_lut2_491 : X_LUT4
    generic map(
      INIT => X"6666"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_c(2),
      ADR1 => XLXI_1_I4_ireg_c(2),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_1_I4_Madd_n0046_inst_lut2_49
    );
  XLXI_1_I4_Madd_n0046_inst_lut2_501 : X_LUT4
    generic map(
      INIT => X"5A5A"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_c(3),
      ADR1 => VCC,
      ADR2 => XLXI_1_I4_ireg_c(3),
      ADR3 => VCC,
      O => XLXI_1_I4_Madd_n0046_inst_lut2_50
    );
  XLXI_1_I4_n0046_2_COUTUSED : X_BUF
    port map (
      I => XLXI_1_I4_n0046_2_CYMUXG,
      O => XLXI_1_I4_Madd_n0046_inst_cy_59
    );
  XLXI_1_I4_n0046_2_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_n0046_2_XORF,
      O => XLXI_1_I4_n0046(2)
    );
  XLXI_1_I4_n0046_2_YUSED : X_BUF
    port map (
      I => XLXI_1_I4_n0046_2_XORG,
      O => XLXI_1_I4_n0046(3)
    );
  XLXI_1_I4_Madd_n0046_inst_cy_59_74 : X_MUX2
    port map (
      IA => XLXI_1_I4_iinc_c(3),
      IB => XLXI_1_I4_Madd_n0046_inst_cy_58,
      SEL => XLXI_1_I4_Madd_n0046_inst_lut2_50,
      O => XLXI_1_I4_n0046_2_CYMUXG
    );
  XLXI_1_I4_Madd_n0046_inst_sum_58 : X_XOR2
    port map (
      I0 => XLXI_1_I4_Madd_n0046_inst_cy_58,
      I1 => XLXI_1_I4_Madd_n0046_inst_lut2_50,
      O => XLXI_1_I4_n0046_2_XORG
    );
  XLXI_1_I4_n0046_2_CYINIT_75 : X_BUF
    port map (
      I => XLXI_1_I4_Madd_n0046_inst_cy_57,
      O => XLXI_1_I4_n0046_2_CYINIT
    );
  XLXI_1_I4_Madd_n0046_inst_cy_60_76 : X_MUX2
    port map (
      IA => XLXI_1_I4_iinc_c(4),
      IB => XLXI_1_I4_n0046_4_CYINIT,
      SEL => XLXI_1_I4_Madd_n0046_inst_lut2_51,
      O => XLXI_1_I4_Madd_n0046_inst_cy_60
    );
  XLXI_1_I4_Madd_n0046_inst_sum_59 : X_XOR2
    port map (
      I0 => XLXI_1_I4_n0046_4_CYINIT,
      I1 => XLXI_1_I4_Madd_n0046_inst_lut2_51,
      O => XLXI_1_I4_n0046_4_XORF
    );
  XLXI_1_I4_Madd_n0046_inst_lut2_511 : X_LUT4
    generic map(
      INIT => X"55AA"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_c(4),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_1_I4_ireg_c(4),
      O => XLXI_1_I4_Madd_n0046_inst_lut2_51
    );
  XLXI_1_I4_Madd_n0046_inst_lut2_521 : X_LUT4
    generic map(
      INIT => X"55AA"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_c(5),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_1_I4_ireg_c(5),
      O => XLXI_1_I4_Madd_n0046_inst_lut2_52
    );
  XLXI_1_I4_n0046_4_COUTUSED : X_BUF
    port map (
      I => XLXI_1_I4_n0046_4_CYMUXG,
      O => XLXI_1_I4_Madd_n0046_inst_cy_61
    );
  XLXI_1_I4_n0046_4_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_n0046_4_XORF,
      O => XLXI_1_I4_n0046(4)
    );
  XLXI_1_I4_n0046_4_YUSED : X_BUF
    port map (
      I => XLXI_1_I4_n0046_4_XORG,
      O => XLXI_1_I4_n0046(5)
    );
  XLXI_1_I4_Madd_n0046_inst_cy_61_77 : X_MUX2
    port map (
      IA => XLXI_1_I4_iinc_c(5),
      IB => XLXI_1_I4_Madd_n0046_inst_cy_60,
      SEL => XLXI_1_I4_Madd_n0046_inst_lut2_52,
      O => XLXI_1_I4_n0046_4_CYMUXG
    );
  XLXI_1_I4_Madd_n0046_inst_sum_60 : X_XOR2
    port map (
      I0 => XLXI_1_I4_Madd_n0046_inst_cy_60,
      I1 => XLXI_1_I4_Madd_n0046_inst_lut2_52,
      O => XLXI_1_I4_n0046_4_XORG
    );
  XLXI_1_I4_n0046_4_CYINIT_78 : X_BUF
    port map (
      I => XLXI_1_I4_Madd_n0046_inst_cy_59,
      O => XLXI_1_I4_n0046_4_CYINIT
    );
  XLXI_1_I4_Madd_n0046_inst_cy_62_79 : X_MUX2
    port map (
      IA => XLXI_1_I4_iinc_c(6),
      IB => XLXI_1_I4_n0046_6_CYINIT,
      SEL => XLXI_1_I4_Madd_n0046_inst_lut2_53,
      O => XLXI_1_I4_Madd_n0046_inst_cy_62
    );
  XLXI_1_I4_Madd_n0046_inst_sum_61 : X_XOR2
    port map (
      I0 => XLXI_1_I4_n0046_6_CYINIT,
      I1 => XLXI_1_I4_Madd_n0046_inst_lut2_53,
      O => XLXI_1_I4_n0046_6_XORF
    );
  XLXI_1_I4_Madd_n0046_inst_lut2_531 : X_LUT4
    generic map(
      INIT => X"6666"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_c(6),
      ADR1 => XLXI_1_I4_ireg_c(6),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_1_I4_Madd_n0046_inst_lut2_53
    );
  XLXI_1_I4_Madd_n0046_inst_lut2_541 : X_LUT4
    generic map(
      INIT => X"6666"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_c(7),
      ADR1 => XLXI_1_I4_ireg_c(7),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_1_I4_Madd_n0046_inst_lut2_54
    );
  XLXI_1_I4_n0046_6_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_n0046_6_XORF,
      O => XLXI_1_I4_n0046(6)
    );
  XLXI_1_I4_n0046_6_YUSED : X_BUF
    port map (
      I => XLXI_1_I4_n0046_6_XORG,
      O => XLXI_1_I4_n0046(7)
    );
  XLXI_1_I4_Madd_n0046_inst_sum_62 : X_XOR2
    port map (
      I0 => XLXI_1_I4_Madd_n0046_inst_cy_62,
      I1 => XLXI_1_I4_Madd_n0046_inst_lut2_54,
      O => XLXI_1_I4_n0046_6_XORG
    );
  XLXI_1_I4_n0046_6_CYINIT_80 : X_BUF
    port map (
      I => XLXI_1_I4_Madd_n0046_inst_cy_61,
      O => XLXI_1_I4_n0046_6_CYINIT
    );
  XLXI_6_n0040_1_LOGIC_ZERO_81 : X_ZERO
    port map (
      O => XLXI_6_n0040_1_LOGIC_ZERO
    );
  XLXI_6_Madd_n0040_inst_cy_16_82 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC1_6,
      IB => XLXI_6_n0040_1_LOGIC_ZERO,
      SEL => XLXI_6_Madd_n0040_inst_lut2_16,
      O => XLXI_6_Madd_n0040_inst_cy_16
    );
  XLXI_6_Madd_n0040_inst_lut2_161 : X_LUT4
    generic map(
      INIT => X"3333"
    )
    port map (
      ADR0 => GLOBAL_LOGIC1_6,
      ADR1 => XLXI_6_tx_bit_count(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_6_Madd_n0040_inst_lut2_16
    );
  XLXI_6_n0040_1_G : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => GLOBAL_LOGIC0_8,
      ADR1 => VCC,
      ADR2 => XLXI_6_tx_bit_count(1),
      ADR3 => VCC,
      O => XLXI_6_n0040_1_GROM
    );
  XLXI_6_n0040_1_COUTUSED : X_BUF
    port map (
      I => XLXI_6_n0040_1_CYMUXG,
      O => XLXI_6_Madd_n0040_inst_cy_17
    );
  XLXI_6_n0040_1_YUSED : X_BUF
    port map (
      I => XLXI_6_n0040_1_XORG,
      O => XLXI_6_n0040(1)
    );
  XLXI_6_Madd_n0040_inst_cy_17_83 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC0_8,
      IB => XLXI_6_Madd_n0040_inst_cy_16,
      SEL => XLXI_6_n0040_1_GROM,
      O => XLXI_6_n0040_1_CYMUXG
    );
  XLXI_6_Madd_n0040_inst_sum_17 : X_XOR2
    port map (
      I0 => XLXI_6_Madd_n0040_inst_cy_16,
      I1 => XLXI_6_n0040_1_GROM,
      O => XLXI_6_n0040_1_XORG
    );
  XLXI_6_n0040_2_LOGIC_ZERO_84 : X_ZERO
    port map (
      O => XLXI_6_n0040_2_LOGIC_ZERO
    );
  XLXI_6_Madd_n0040_inst_cy_18_85 : X_MUX2
    port map (
      IA => XLXI_6_n0040_2_LOGIC_ZERO,
      IB => XLXI_6_n0040_2_CYINIT,
      SEL => XLXI_6_n0040_2_FROM,
      O => XLXI_6_Madd_n0040_inst_cy_18
    );
  XLXI_6_Madd_n0040_inst_sum_18 : X_XOR2
    port map (
      I0 => XLXI_6_n0040_2_CYINIT,
      I1 => XLXI_6_n0040_2_FROM,
      O => XLXI_6_n0040_2_XORF
    );
  XLXI_6_n0040_2_F : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_6_tx_bit_count(2),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_6_n0040_2_FROM
    );
  XLXI_6_tx_bit_count_3_rt_86 : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_6_tx_bit_count(3),
      ADR3 => VCC,
      O => XLXI_6_tx_bit_count_3_rt
    );
  XLXI_6_n0040_2_XUSED : X_BUF
    port map (
      I => XLXI_6_n0040_2_XORF,
      O => XLXI_6_n0040(2)
    );
  XLXI_6_n0040_2_YUSED : X_BUF
    port map (
      I => XLXI_6_n0040_2_XORG,
      O => XLXI_6_n0040(3)
    );
  XLXI_6_Madd_n0040_inst_sum_19 : X_XOR2
    port map (
      I0 => XLXI_6_Madd_n0040_inst_cy_18,
      I1 => XLXI_6_tx_bit_count_3_rt,
      O => XLXI_6_n0040_2_XORG
    );
  XLXI_6_n0040_2_CYINIT_87 : X_BUF
    port map (
      I => XLXI_6_Madd_n0040_inst_cy_17,
      O => XLXI_6_n0040_2_CYINIT
    );
  XLXI_5_n0016_0_LOGIC_ONE_88 : X_ONE
    port map (
      O => XLXI_5_n0016_0_LOGIC_ONE
    );
  XLXI_5_Msub_n0016_inst_cy_8_89 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC0_6,
      IB => XLXI_5_n0016_0_CYINIT,
      SEL => XLXI_5_n0016_0_FROM,
      O => XLXI_5_Msub_n0016_inst_cy_8
    );
  XLXI_5_Msub_n0016_inst_sum_8 : X_XOR2
    port map (
      I0 => XLXI_5_n0016_0_CYINIT,
      I1 => XLXI_5_n0016_0_FROM,
      O => XLXI_5_n0016_0_XORF
    );
  XLXI_5_n0016_0_F : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => GLOBAL_LOGIC0_6,
      ADR1 => XLXI_5_tmr_high(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_n0016_0_FROM
    );
  XLXI_5_Msub_n0016_inst_lut2_91 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => XLXI_5_tmr_high(1),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_Msub_n0016_inst_lut2_9
    );
  XLXI_5_n0016_0_COUTUSED : X_BUF
    port map (
      I => XLXI_5_n0016_0_CYMUXG,
      O => XLXI_5_Msub_n0016_inst_cy_9
    );
  XLXI_5_n0016_0_XUSED : X_BUF
    port map (
      I => XLXI_5_n0016_0_XORF,
      O => XLXI_5_n0016(0)
    );
  XLXI_5_n0016_0_YUSED : X_BUF
    port map (
      I => XLXI_5_n0016_0_XORG,
      O => XLXI_5_n0016(1)
    );
  XLXI_5_Msub_n0016_inst_cy_9_90 : X_MUX2
    port map (
      IA => XLXI_5_tmr_high(1),
      IB => XLXI_5_Msub_n0016_inst_cy_8,
      SEL => XLXI_5_Msub_n0016_inst_lut2_9,
      O => XLXI_5_n0016_0_CYMUXG
    );
  XLXI_5_Msub_n0016_inst_sum_9 : X_XOR2
    port map (
      I0 => XLXI_5_Msub_n0016_inst_cy_8,
      I1 => XLXI_5_Msub_n0016_inst_lut2_9,
      O => XLXI_5_n0016_0_XORG
    );
  XLXI_5_n0016_0_CYINIT_91 : X_BUF
    port map (
      I => XLXI_5_n0016_0_LOGIC_ONE,
      O => XLXI_5_n0016_0_CYINIT
    );
  XLXI_5_Msub_n0016_inst_cy_10_92 : X_MUX2
    port map (
      IA => XLXI_5_tmr_high(2),
      IB => XLXI_5_n0016_2_CYINIT,
      SEL => XLXI_5_Msub_n0016_inst_lut2_10,
      O => XLXI_5_Msub_n0016_inst_cy_10
    );
  XLXI_5_Msub_n0016_inst_sum_10 : X_XOR2
    port map (
      I0 => XLXI_5_n0016_2_CYINIT,
      I1 => XLXI_5_Msub_n0016_inst_lut2_10,
      O => XLXI_5_n0016_2_XORF
    );
  XLXI_5_Msub_n0016_inst_lut2_101 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => XLXI_5_tmr_high(2),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_Msub_n0016_inst_lut2_10
    );
  XLXI_5_Msub_n0016_inst_lut2_111 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => XLXI_5_tmr_high(3),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_Msub_n0016_inst_lut2_11
    );
  XLXI_5_n0016_2_COUTUSED : X_BUF
    port map (
      I => XLXI_5_n0016_2_CYMUXG,
      O => XLXI_5_Msub_n0016_inst_cy_11
    );
  XLXI_5_n0016_2_XUSED : X_BUF
    port map (
      I => XLXI_5_n0016_2_XORF,
      O => XLXI_5_n0016(2)
    );
  XLXI_5_n0016_2_YUSED : X_BUF
    port map (
      I => XLXI_5_n0016_2_XORG,
      O => XLXI_5_n0016(3)
    );
  XLXI_5_Msub_n0016_inst_cy_11_93 : X_MUX2
    port map (
      IA => XLXI_5_tmr_high(3),
      IB => XLXI_5_Msub_n0016_inst_cy_10,
      SEL => XLXI_5_Msub_n0016_inst_lut2_11,
      O => XLXI_5_n0016_2_CYMUXG
    );
  XLXI_5_Msub_n0016_inst_sum_11 : X_XOR2
    port map (
      I0 => XLXI_5_Msub_n0016_inst_cy_10,
      I1 => XLXI_5_Msub_n0016_inst_lut2_11,
      O => XLXI_5_n0016_2_XORG
    );
  XLXI_5_n0016_2_CYINIT_94 : X_BUF
    port map (
      I => XLXI_5_Msub_n0016_inst_cy_9,
      O => XLXI_5_n0016_2_CYINIT
    );
  XLXI_5_Msub_n0016_inst_cy_12_95 : X_MUX2
    port map (
      IA => XLXI_5_tmr_high(4),
      IB => XLXI_5_n0016_4_CYINIT,
      SEL => XLXI_5_Msub_n0016_inst_lut2_12,
      O => XLXI_5_Msub_n0016_inst_cy_12
    );
  XLXI_5_Msub_n0016_inst_sum_12 : X_XOR2
    port map (
      I0 => XLXI_5_n0016_4_CYINIT,
      I1 => XLXI_5_Msub_n0016_inst_lut2_12,
      O => XLXI_5_n0016_4_XORF
    );
  XLXI_5_Msub_n0016_inst_lut2_121 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => XLXI_5_tmr_high(4),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_Msub_n0016_inst_lut2_12
    );
  XLXI_5_Msub_n0016_inst_lut2_131 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => XLXI_5_tmr_high(5),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_Msub_n0016_inst_lut2_13
    );
  XLXI_5_n0016_4_COUTUSED : X_BUF
    port map (
      I => XLXI_5_n0016_4_CYMUXG,
      O => XLXI_5_Msub_n0016_inst_cy_13
    );
  XLXI_5_n0016_4_XUSED : X_BUF
    port map (
      I => XLXI_5_n0016_4_XORF,
      O => XLXI_5_n0016(4)
    );
  XLXI_5_n0016_4_YUSED : X_BUF
    port map (
      I => XLXI_5_n0016_4_XORG,
      O => XLXI_5_n0016(5)
    );
  XLXI_5_Msub_n0016_inst_cy_13_96 : X_MUX2
    port map (
      IA => XLXI_5_tmr_high(5),
      IB => XLXI_5_Msub_n0016_inst_cy_12,
      SEL => XLXI_5_Msub_n0016_inst_lut2_13,
      O => XLXI_5_n0016_4_CYMUXG
    );
  XLXI_5_Msub_n0016_inst_sum_13 : X_XOR2
    port map (
      I0 => XLXI_5_Msub_n0016_inst_cy_12,
      I1 => XLXI_5_Msub_n0016_inst_lut2_13,
      O => XLXI_5_n0016_4_XORG
    );
  XLXI_5_n0016_4_CYINIT_97 : X_BUF
    port map (
      I => XLXI_5_Msub_n0016_inst_cy_11,
      O => XLXI_5_n0016_4_CYINIT
    );
  XLXI_5_Msub_n0016_inst_cy_14_98 : X_MUX2
    port map (
      IA => XLXI_5_tmr_high(6),
      IB => XLXI_5_n0016_6_CYINIT,
      SEL => XLXI_5_Msub_n0016_inst_lut2_14,
      O => XLXI_5_Msub_n0016_inst_cy_14
    );
  XLXI_5_Msub_n0016_inst_sum_14 : X_XOR2
    port map (
      I0 => XLXI_5_n0016_6_CYINIT,
      I1 => XLXI_5_Msub_n0016_inst_lut2_14,
      O => XLXI_5_n0016_6_XORF
    );
  XLXI_5_Msub_n0016_inst_lut2_141 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => XLXI_5_tmr_high(6),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_Msub_n0016_inst_lut2_14
    );
  XLXI_5_Msub_n0016_inst_lut2_151 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => XLXI_5_tmr_high(7),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_Msub_n0016_inst_lut2_15
    );
  XLXI_5_n0016_6_XUSED : X_BUF
    port map (
      I => XLXI_5_n0016_6_XORF,
      O => XLXI_5_n0016(6)
    );
  XLXI_5_n0016_6_YUSED : X_BUF
    port map (
      I => XLXI_5_n0016_6_XORG,
      O => XLXI_5_n0016(7)
    );
  XLXI_5_Msub_n0016_inst_sum_15 : X_XOR2
    port map (
      I0 => XLXI_5_Msub_n0016_inst_cy_14,
      I1 => XLXI_5_Msub_n0016_inst_lut2_15,
      O => XLXI_5_n0016_6_XORG
    );
  XLXI_5_n0016_6_CYINIT_99 : X_BUF
    port map (
      I => XLXI_5_Msub_n0016_inst_cy_13,
      O => XLXI_5_n0016_6_CYINIT
    );
  XLXI_6_n0041_1_LOGIC_ZERO_100 : X_ZERO
    port map (
      O => XLXI_6_n0041_1_LOGIC_ZERO
    );
  XLXI_6_Madd_n0041_inst_cy_16_101 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC1_5,
      IB => XLXI_6_n0041_1_LOGIC_ZERO,
      SEL => XLXI_6_Madd_n0041_inst_lut2_16,
      O => XLXI_6_Madd_n0041_inst_cy_16
    );
  XLXI_6_Madd_n0041_inst_lut2_161 : X_LUT4
    generic map(
      INIT => X"00FF"
    )
    port map (
      ADR0 => GLOBAL_LOGIC1_5,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_6_tx_16_count(0),
      O => XLXI_6_Madd_n0041_inst_lut2_16
    );
  XLXI_6_n0041_1_G : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => GLOBAL_LOGIC0_7,
      ADR1 => VCC,
      ADR2 => XLXI_6_tx_16_count(1),
      ADR3 => VCC,
      O => XLXI_6_n0041_1_GROM
    );
  XLXI_6_n0041_1_COUTUSED : X_BUF
    port map (
      I => XLXI_6_n0041_1_CYMUXG,
      O => XLXI_6_Madd_n0041_inst_cy_17
    );
  XLXI_6_n0041_1_YUSED : X_BUF
    port map (
      I => XLXI_6_n0041_1_XORG,
      O => XLXI_6_n0041(1)
    );
  XLXI_6_Madd_n0041_inst_cy_17_102 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC0_7,
      IB => XLXI_6_Madd_n0041_inst_cy_16,
      SEL => XLXI_6_n0041_1_GROM,
      O => XLXI_6_n0041_1_CYMUXG
    );
  XLXI_6_Madd_n0041_inst_sum_17 : X_XOR2
    port map (
      I0 => XLXI_6_Madd_n0041_inst_cy_16,
      I1 => XLXI_6_n0041_1_GROM,
      O => XLXI_6_n0041_1_XORG
    );
  XLXI_6_n0041_2_LOGIC_ZERO_103 : X_ZERO
    port map (
      O => XLXI_6_n0041_2_LOGIC_ZERO
    );
  XLXI_6_Madd_n0041_inst_cy_18_104 : X_MUX2
    port map (
      IA => XLXI_6_n0041_2_LOGIC_ZERO,
      IB => XLXI_6_n0041_2_CYINIT,
      SEL => XLXI_6_n0041_2_FROM,
      O => XLXI_6_Madd_n0041_inst_cy_18
    );
  XLXI_6_Madd_n0041_inst_sum_18 : X_XOR2
    port map (
      I0 => XLXI_6_n0041_2_CYINIT,
      I1 => XLXI_6_n0041_2_FROM,
      O => XLXI_6_n0041_2_XORF
    );
  XLXI_6_n0041_2_F : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_6_tx_16_count(2),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_6_n0041_2_FROM
    );
  XLXI_6_tx_16_count_3_rt_105 : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_6_tx_16_count(3),
      ADR3 => VCC,
      O => XLXI_6_tx_16_count_3_rt
    );
  XLXI_6_n0041_2_XUSED : X_BUF
    port map (
      I => XLXI_6_n0041_2_XORF,
      O => XLXI_6_n0041(2)
    );
  XLXI_6_n0041_2_YUSED : X_BUF
    port map (
      I => XLXI_6_n0041_2_XORG,
      O => XLXI_6_n0041(3)
    );
  XLXI_6_Madd_n0041_inst_sum_19 : X_XOR2
    port map (
      I0 => XLXI_6_Madd_n0041_inst_cy_18,
      I1 => XLXI_6_tx_16_count_3_rt,
      O => XLXI_6_n0041_2_XORG
    );
  XLXI_6_n0041_2_CYINIT_106 : X_BUF
    port map (
      I => XLXI_6_Madd_n0041_inst_cy_17,
      O => XLXI_6_n0041_2_CYINIT
    );
  XLXI_1_I3_n0066_0_LOGIC_ONE_107 : X_ONE
    port map (
      O => XLXI_1_I3_n0066_0_LOGIC_ONE
    );
  XLXI_1_I3_Msub_n0066_inst_cy_47_108 : X_MUX2
    port map (
      IA => XLXI_1_I3_acc_c_0_0,
      IB => XLXI_1_I3_n0066_0_CYINIT,
      SEL => XLXI_1_I3_n0066_0_FROM,
      O => XLXI_1_I3_Msub_n0066_inst_cy_47
    );
  XLXI_1_I3_Msub_n0066_inst_sum_46 : X_XOR2
    port map (
      I0 => XLXI_1_I3_n0066_0_CYINIT,
      I1 => XLXI_1_I3_n0066_0_FROM,
      O => XLXI_1_I3_n0066_0_XORF
    );
  XLXI_1_I3_n0066_0_F : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_0,
      ADR1 => VCC,
      ADR2 => XLXI_1_I3_Msub_n0066_inst_lut2_38,
      ADR3 => VCC,
      O => XLXI_1_I3_n0066_0_FROM
    );
  XLXI_1_I3_n0066_0_G : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_1,
      ADR1 => VCC,
      ADR2 => XLXI_1_I3_Msub_n0066_inst_lut2_39,
      ADR3 => VCC,
      O => XLXI_1_I3_n0066_0_GROM
    );
  XLXI_1_I3_n0066_0_COUTUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0066_0_CYMUXG,
      O => XLXI_1_I3_Msub_n0066_inst_cy_48
    );
  XLXI_1_I3_n0066_0_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0066_0_XORF,
      O => XLXI_1_I3_n0066(0)
    );
  XLXI_1_I3_n0066_0_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0066_0_XORG,
      O => XLXI_1_I3_n0066(1)
    );
  XLXI_1_I3_Msub_n0066_inst_cy_48_109 : X_MUX2
    port map (
      IA => XLXI_1_I3_acc_c_0_1,
      IB => XLXI_1_I3_Msub_n0066_inst_cy_47,
      SEL => XLXI_1_I3_n0066_0_GROM,
      O => XLXI_1_I3_n0066_0_CYMUXG
    );
  XLXI_1_I3_Msub_n0066_inst_sum_47 : X_XOR2
    port map (
      I0 => XLXI_1_I3_Msub_n0066_inst_cy_47,
      I1 => XLXI_1_I3_n0066_0_GROM,
      O => XLXI_1_I3_n0066_0_XORG
    );
  XLXI_1_I3_n0066_0_CYINIT_110 : X_BUF
    port map (
      I => XLXI_1_I3_n0066_0_LOGIC_ONE,
      O => XLXI_1_I3_n0066_0_CYINIT
    );
  XLXI_1_I3_Msub_n0066_inst_cy_49_111 : X_MUX2
    port map (
      IA => XLXI_1_I3_acc_c_0_2,
      IB => XLXI_1_I3_n0066_2_CYINIT,
      SEL => XLXI_1_I3_n0066_2_FROM,
      O => XLXI_1_I3_Msub_n0066_inst_cy_49
    );
  XLXI_1_I3_Msub_n0066_inst_sum_48 : X_XOR2
    port map (
      I0 => XLXI_1_I3_n0066_2_CYINIT,
      I1 => XLXI_1_I3_n0066_2_FROM,
      O => XLXI_1_I3_n0066_2_XORF
    );
  XLXI_1_I3_n0066_2_F : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_2,
      ADR1 => XLXI_1_I3_Msub_n0066_inst_lut2_40,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_1_I3_n0066_2_FROM
    );
  XLXI_1_I3_n0066_2_G : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_3,
      ADR1 => XLXI_1_I3_Msub_n0066_inst_lut2_41,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_1_I3_n0066_2_GROM
    );
  XLXI_1_I3_n0066_2_COUTUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0066_2_CYMUXG,
      O => XLXI_1_I3_Msub_n0066_inst_cy_50
    );
  XLXI_1_I3_n0066_2_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0066_2_XORF,
      O => XLXI_1_I3_n0066(2)
    );
  XLXI_1_I3_n0066_2_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0066_2_XORG,
      O => XLXI_1_I3_n0066(3)
    );
  XLXI_1_I3_Msub_n0066_inst_cy_50_112 : X_MUX2
    port map (
      IA => XLXI_1_I3_acc_c_0_3,
      IB => XLXI_1_I3_Msub_n0066_inst_cy_49,
      SEL => XLXI_1_I3_n0066_2_GROM,
      O => XLXI_1_I3_n0066_2_CYMUXG
    );
  XLXI_1_I3_Msub_n0066_inst_sum_49 : X_XOR2
    port map (
      I0 => XLXI_1_I3_Msub_n0066_inst_cy_49,
      I1 => XLXI_1_I3_n0066_2_GROM,
      O => XLXI_1_I3_n0066_2_XORG
    );
  XLXI_1_I3_n0066_2_CYINIT_113 : X_BUF
    port map (
      I => XLXI_1_I3_Msub_n0066_inst_cy_48,
      O => XLXI_1_I3_n0066_2_CYINIT
    );
  XLXI_1_I3_Msub_n0066_inst_cy_51_114 : X_MUX2
    port map (
      IA => XLXI_1_I3_acc_c_0_4,
      IB => XLXI_1_I3_n0066_4_CYINIT,
      SEL => XLXI_1_I3_n0066_4_FROM,
      O => XLXI_1_I3_Msub_n0066_inst_cy_51
    );
  XLXI_1_I3_Msub_n0066_inst_sum_50 : X_XOR2
    port map (
      I0 => XLXI_1_I3_n0066_4_CYINIT,
      I1 => XLXI_1_I3_n0066_4_FROM,
      O => XLXI_1_I3_n0066_4_XORF
    );
  XLXI_1_I3_n0066_4_F : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_4,
      ADR1 => XLXI_1_I3_Msub_n0066_inst_lut2_42,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_1_I3_n0066_4_FROM
    );
  XLXI_1_I3_n0066_4_G : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_5,
      ADR1 => VCC,
      ADR2 => XLXI_1_I3_Msub_n0066_inst_lut2_43,
      ADR3 => VCC,
      O => XLXI_1_I3_n0066_4_GROM
    );
  XLXI_1_I3_n0066_4_COUTUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0066_4_CYMUXG,
      O => XLXI_1_I3_Msub_n0066_inst_cy_52
    );
  XLXI_1_I3_n0066_4_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0066_4_XORF,
      O => XLXI_1_I3_n0066(4)
    );
  XLXI_1_I3_n0066_4_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0066_4_XORG,
      O => XLXI_1_I3_n0066(5)
    );
  XLXI_1_I3_Msub_n0066_inst_cy_52_115 : X_MUX2
    port map (
      IA => XLXI_1_I3_acc_c_0_5,
      IB => XLXI_1_I3_Msub_n0066_inst_cy_51,
      SEL => XLXI_1_I3_n0066_4_GROM,
      O => XLXI_1_I3_n0066_4_CYMUXG
    );
  XLXI_1_I3_Msub_n0066_inst_sum_51 : X_XOR2
    port map (
      I0 => XLXI_1_I3_Msub_n0066_inst_cy_51,
      I1 => XLXI_1_I3_n0066_4_GROM,
      O => XLXI_1_I3_n0066_4_XORG
    );
  XLXI_1_I3_n0066_4_CYINIT_116 : X_BUF
    port map (
      I => XLXI_1_I3_Msub_n0066_inst_cy_50,
      O => XLXI_1_I3_n0066_4_CYINIT
    );
  XLXI_1_I3_Msub_n0066_inst_cy_53_117 : X_MUX2
    port map (
      IA => XLXI_1_I3_acc_c_0_6,
      IB => XLXI_1_I3_n0066_6_CYINIT,
      SEL => XLXI_1_I3_n0066_6_FROM,
      O => XLXI_1_I3_Msub_n0066_inst_cy_53
    );
  XLXI_1_I3_Msub_n0066_inst_sum_52 : X_XOR2
    port map (
      I0 => XLXI_1_I3_n0066_6_CYINIT,
      I1 => XLXI_1_I3_n0066_6_FROM,
      O => XLXI_1_I3_n0066_6_XORF
    );
  XLXI_1_I3_n0066_6_F : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_6,
      ADR1 => VCC,
      ADR2 => XLXI_1_I3_Msub_n0066_inst_lut2_44,
      ADR3 => VCC,
      O => XLXI_1_I3_n0066_6_FROM
    );
  XLXI_1_I3_n0066_6_G : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_7,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_1_I3_Msub_n0066_inst_lut2_45,
      O => XLXI_1_I3_n0066_6_GROM
    );
  XLXI_1_I3_n0066_6_COUTUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0066_6_CYMUXG,
      O => XLXI_1_I3_Msub_n0066_inst_cy_54
    );
  XLXI_1_I3_n0066_6_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0066_6_XORF,
      O => XLXI_1_I3_n0066(6)
    );
  XLXI_1_I3_n0066_6_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0066_6_XORG,
      O => XLXI_1_I3_n0066(7)
    );
  XLXI_1_I3_Msub_n0066_inst_cy_54_118 : X_MUX2
    port map (
      IA => XLXI_1_I3_acc_c_0_7,
      IB => XLXI_1_I3_Msub_n0066_inst_cy_53,
      SEL => XLXI_1_I3_n0066_6_GROM,
      O => XLXI_1_I3_n0066_6_CYMUXG
    );
  XLXI_1_I3_Msub_n0066_inst_sum_53 : X_XOR2
    port map (
      I0 => XLXI_1_I3_Msub_n0066_inst_cy_53,
      I1 => XLXI_1_I3_n0066_6_GROM,
      O => XLXI_1_I3_n0066_6_XORG
    );
  XLXI_1_I3_n0066_6_CYINIT_119 : X_BUF
    port map (
      I => XLXI_1_I3_Msub_n0066_inst_cy_52,
      O => XLXI_1_I3_n0066_6_CYINIT
    );
  XLXI_1_I3_Msub_n0066_inst_sum_54 : X_XOR2
    port map (
      I0 => XLXI_1_I3_n0066_8_CYINIT,
      I1 => XLXI_1_I3_n0066_8_FROM,
      O => XLXI_1_I3_n0066_8_XORF
    );
  XLXI_1_I3_n0066_8_F : X_LUT4
    generic map(
      INIT => X"FFFF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_1_I3_n0066_8_FROM
    );
  XLXI_1_I3_n0066_8_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0066_8_XORF,
      O => XLXI_1_I3_n0066(8)
    );
  XLXI_1_I3_n0066_8_CYINIT_120 : X_BUF
    port map (
      I => XLXI_1_I3_Msub_n0066_inst_cy_54,
      O => XLXI_1_I3_n0066_8_CYINIT
    );
  XLXI_6_tx_clk_count_0_LOGIC_ZERO_121 : X_ZERO
    port map (
      O => XLXI_6_tx_clk_count_0_LOGIC_ZERO
    );
  XLXI_6_tx_clk_count_0_LOGIC_ONE_122 : X_ONE
    port map (
      O => XLXI_6_tx_clk_count_0_LOGIC_ONE
    );
  XLXI_6_tx_clk_count_inst_cy_20_123 : X_MUX2
    port map (
      IA => XLXI_6_tx_clk_count_0_LOGIC_ONE,
      IB => XLXI_6_tx_clk_count_0_LOGIC_ZERO,
      SEL => XLXI_6_n0059,
      O => XLXI_6_tx_clk_count_inst_cy_20
    );
  XLXI_6_n00591 : X_LUT4
    generic map(
      INIT => X"5F5F"
    )
    port map (
      ADR0 => CHOICE1024,
      ADR1 => VCC,
      ADR2 => CHOICE1017,
      ADR3 => VCC,
      O => XLXI_6_n0059
    );
  XLXI_6_tx_clk_count_inst_lut3_01 : X_LUT4
    generic map(
      INIT => X"470F"
    )
    port map (
      ADR0 => XLXI_6_tx_clk_div(0),
      ADR1 => CHOICE1024,
      ADR2 => XLXI_6_tx_clk_count(0),
      ADR3 => CHOICE1017,
      O => XLXI_6_tx_clk_count_inst_lut3_0
    );
  XLXI_6_tx_clk_count_0_COUTUSED : X_BUF
    port map (
      I => XLXI_6_tx_clk_count_0_CYMUXG,
      O => XLXI_6_tx_clk_count_inst_cy_21
    );
  XLXI_6_tx_clk_count_inst_cy_21_124 : X_MUX2
    port map (
      IA => XLXI_6_tx_clk_count_0_LOGIC_ONE,
      IB => XLXI_6_tx_clk_count_inst_cy_20,
      SEL => XLXI_6_tx_clk_count_inst_lut3_0,
      O => XLXI_6_tx_clk_count_0_CYMUXG
    );
  XLXI_6_tx_clk_count_inst_sum_20_125 : X_XOR2
    port map (
      I0 => XLXI_6_tx_clk_count_inst_cy_20,
      I1 => XLXI_6_tx_clk_count_inst_lut3_0,
      O => XLXI_6_tx_clk_count_inst_sum_20
    );
  XLXI_6_tx_clk_count_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_clk_count_0_SRMUX_OUTPUTNOT
    );
  XLXI_6_tx_clk_count_1_LOGIC_ONE_126 : X_ONE
    port map (
      O => XLXI_6_tx_clk_count_1_LOGIC_ONE
    );
  XLXI_6_tx_clk_count_inst_cy_22_127 : X_MUX2
    port map (
      IA => XLXI_6_tx_clk_count_1_LOGIC_ONE,
      IB => XLXI_6_tx_clk_count_1_CYINIT,
      SEL => XLXI_6_tx_clk_count_inst_lut3_1,
      O => XLXI_6_tx_clk_count_inst_cy_22
    );
  XLXI_6_tx_clk_count_inst_sum_21_128 : X_XOR2
    port map (
      I0 => XLXI_6_tx_clk_count_1_CYINIT,
      I1 => XLXI_6_tx_clk_count_inst_lut3_1,
      O => XLXI_6_tx_clk_count_inst_sum_21
    );
  XLXI_6_tx_clk_count_inst_lut3_11 : X_LUT4
    generic map(
      INIT => X"1D55"
    )
    port map (
      ADR0 => XLXI_6_tx_clk_count(1),
      ADR1 => CHOICE1017,
      ADR2 => XLXI_6_tx_clk_div(1),
      ADR3 => CHOICE1024,
      O => XLXI_6_tx_clk_count_inst_lut3_1
    );
  XLXI_6_tx_clk_count_inst_lut3_21 : X_LUT4
    generic map(
      INIT => X"15D5"
    )
    port map (
      ADR0 => XLXI_6_tx_clk_count(2),
      ADR1 => CHOICE1017,
      ADR2 => CHOICE1024,
      ADR3 => XLXI_6_tx_clk_div(2),
      O => XLXI_6_tx_clk_count_inst_lut3_2
    );
  XLXI_6_tx_clk_count_1_COUTUSED : X_BUF
    port map (
      I => XLXI_6_tx_clk_count_1_CYMUXG,
      O => XLXI_6_tx_clk_count_inst_cy_23
    );
  XLXI_6_tx_clk_count_inst_cy_23_129 : X_MUX2
    port map (
      IA => XLXI_6_tx_clk_count_1_LOGIC_ONE,
      IB => XLXI_6_tx_clk_count_inst_cy_22,
      SEL => XLXI_6_tx_clk_count_inst_lut3_2,
      O => XLXI_6_tx_clk_count_1_CYMUXG
    );
  XLXI_6_tx_clk_count_inst_sum_22_130 : X_XOR2
    port map (
      I0 => XLXI_6_tx_clk_count_inst_cy_22,
      I1 => XLXI_6_tx_clk_count_inst_lut3_2,
      O => XLXI_6_tx_clk_count_inst_sum_22
    );
  XLXI_6_tx_clk_count_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_clk_count_1_SRMUX_OUTPUTNOT
    );
  XLXI_6_tx_clk_count_1_CYINIT_131 : X_BUF
    port map (
      I => XLXI_6_tx_clk_count_inst_cy_21,
      O => XLXI_6_tx_clk_count_1_CYINIT
    );
  XLXI_3_out_1reg_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => OUT1_REG_0_OD,
      CE => XLXI_3_n0002,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => OUT1_REG_0_OFF_RST,
      O => XLXI_3_out_1reg(0)
    );
  OUT1_REG_0_OFF_RSTOR : X_OR2
    port map (
      I0 => OUT1_REG_0_SRMUXNOT,
      I1 => GSR,
      O => OUT1_REG_0_OFF_RST
    );
  XLXI_6_tx_clk_count_3_LOGIC_ONE_132 : X_ONE
    port map (
      O => XLXI_6_tx_clk_count_3_LOGIC_ONE
    );
  XLXI_6_tx_clk_count_inst_cy_24_133 : X_MUX2
    port map (
      IA => XLXI_6_tx_clk_count_3_LOGIC_ONE,
      IB => XLXI_6_tx_clk_count_3_CYINIT,
      SEL => XLXI_6_tx_clk_count_inst_lut3_3,
      O => XLXI_6_tx_clk_count_inst_cy_24
    );
  XLXI_6_tx_clk_count_inst_sum_23_134 : X_XOR2
    port map (
      I0 => XLXI_6_tx_clk_count_3_CYINIT,
      I1 => XLXI_6_tx_clk_count_inst_lut3_3,
      O => XLXI_6_tx_clk_count_inst_sum_23
    );
  XLXI_6_tx_clk_count_inst_lut3_31 : X_LUT4
    generic map(
      INIT => X"3555"
    )
    port map (
      ADR0 => XLXI_6_tx_clk_count(3),
      ADR1 => XLXI_6_tx_clk_div(3),
      ADR2 => CHOICE1024,
      ADR3 => CHOICE1017,
      O => XLXI_6_tx_clk_count_inst_lut3_3
    );
  XLXI_6_tx_clk_count_inst_lut3_41 : X_LUT4
    generic map(
      INIT => X"15D5"
    )
    port map (
      ADR0 => XLXI_6_tx_clk_count(4),
      ADR1 => CHOICE1024,
      ADR2 => CHOICE1017,
      ADR3 => XLXI_6_tx_clk_div(4),
      O => XLXI_6_tx_clk_count_inst_lut3_4
    );
  XLXI_6_tx_clk_count_3_COUTUSED : X_BUF
    port map (
      I => XLXI_6_tx_clk_count_3_CYMUXG,
      O => XLXI_6_tx_clk_count_inst_cy_25
    );
  XLXI_6_tx_clk_count_inst_cy_25_135 : X_MUX2
    port map (
      IA => XLXI_6_tx_clk_count_3_LOGIC_ONE,
      IB => XLXI_6_tx_clk_count_inst_cy_24,
      SEL => XLXI_6_tx_clk_count_inst_lut3_4,
      O => XLXI_6_tx_clk_count_3_CYMUXG
    );
  XLXI_6_tx_clk_count_inst_sum_24_136 : X_XOR2
    port map (
      I0 => XLXI_6_tx_clk_count_inst_cy_24,
      I1 => XLXI_6_tx_clk_count_inst_lut3_4,
      O => XLXI_6_tx_clk_count_inst_sum_24
    );
  XLXI_6_tx_clk_count_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_clk_count_3_SRMUX_OUTPUTNOT
    );
  XLXI_6_tx_clk_count_3_CYINIT_137 : X_BUF
    port map (
      I => XLXI_6_tx_clk_count_inst_cy_23,
      O => XLXI_6_tx_clk_count_3_CYINIT
    );
  XLXI_6_tx_clk_count_5_LOGIC_ONE_138 : X_ONE
    port map (
      O => XLXI_6_tx_clk_count_5_LOGIC_ONE
    );
  XLXI_6_tx_clk_count_inst_cy_26_139 : X_MUX2
    port map (
      IA => XLXI_6_tx_clk_count_5_LOGIC_ONE,
      IB => XLXI_6_tx_clk_count_5_CYINIT,
      SEL => XLXI_6_tx_clk_count_inst_lut3_5,
      O => XLXI_6_tx_clk_count_inst_cy_26
    );
  XLXI_6_tx_clk_count_inst_sum_25_140 : X_XOR2
    port map (
      I0 => XLXI_6_tx_clk_count_5_CYINIT,
      I1 => XLXI_6_tx_clk_count_inst_lut3_5,
      O => XLXI_6_tx_clk_count_inst_sum_25
    );
  XLXI_6_tx_clk_count_inst_lut3_51 : X_LUT4
    generic map(
      INIT => X"1B33"
    )
    port map (
      ADR0 => CHOICE1024,
      ADR1 => XLXI_6_tx_clk_count(5),
      ADR2 => XLXI_6_tx_clk_div(5),
      ADR3 => CHOICE1017,
      O => XLXI_6_tx_clk_count_inst_lut3_5
    );
  XLXI_6_tx_clk_count_inst_lut3_61 : X_LUT4
    generic map(
      INIT => X"207F"
    )
    port map (
      ADR0 => CHOICE1024,
      ADR1 => XLXI_6_tx_clk_div(6),
      ADR2 => CHOICE1017,
      ADR3 => XLXI_6_tx_clk_count(6),
      O => XLXI_6_tx_clk_count_inst_lut3_6
    );
  XLXI_6_tx_clk_count_5_COUTUSED : X_BUF
    port map (
      I => XLXI_6_tx_clk_count_5_CYMUXG,
      O => XLXI_6_tx_clk_count_inst_cy_27
    );
  XLXI_6_tx_clk_count_inst_cy_27_141 : X_MUX2
    port map (
      IA => XLXI_6_tx_clk_count_5_LOGIC_ONE,
      IB => XLXI_6_tx_clk_count_inst_cy_26,
      SEL => XLXI_6_tx_clk_count_inst_lut3_6,
      O => XLXI_6_tx_clk_count_5_CYMUXG
    );
  XLXI_6_tx_clk_count_inst_sum_26_142 : X_XOR2
    port map (
      I0 => XLXI_6_tx_clk_count_inst_cy_26,
      I1 => XLXI_6_tx_clk_count_inst_lut3_6,
      O => XLXI_6_tx_clk_count_inst_sum_26
    );
  XLXI_6_tx_clk_count_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_clk_count_5_SRMUX_OUTPUTNOT
    );
  XLXI_6_tx_clk_count_5_CYINIT_143 : X_BUF
    port map (
      I => XLXI_6_tx_clk_count_inst_cy_25,
      O => XLXI_6_tx_clk_count_5_CYINIT
    );
  XLXI_6_tx_clk_count_inst_sum_27_144 : X_XOR2
    port map (
      I0 => XLXI_6_tx_clk_count_7_CYINIT,
      I1 => XLXI_6_tx_clk_count_inst_lut3_7,
      O => XLXI_6_tx_clk_count_inst_sum_27
    );
  XLXI_6_tx_clk_count_inst_lut3_71 : X_LUT4
    generic map(
      INIT => X"087F"
    )
    port map (
      ADR0 => CHOICE1024,
      ADR1 => CHOICE1017,
      ADR2 => XLXI_6_tx_clk_div(7),
      ADR3 => XLXI_6_tx_clk_count(7),
      O => XLXI_6_tx_clk_count_inst_lut3_7
    );
  XLXI_6_n0014_7_1 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_6_N15034,
      ADR1 => CPU_DATA_OUT(7),
      ADR2 => XLXI_6_n0051,
      ADR3 => XLXI_6_tx_clk_div(7),
      O => XLXI_6_n0014_7_1_O
    );
  XLXI_6_tx_clk_count_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_clk_count_7_SRMUX_OUTPUTNOT
    );
  XLXI_6_tx_clk_count_7_CYINIT_145 : X_BUF
    port map (
      I => XLXI_6_tx_clk_count_inst_cy_27,
      O => XLXI_6_tx_clk_count_7_CYINIT
    );
  XLXI_1_I3_n0074_1_LOGIC_ZERO_146 : X_ZERO
    port map (
      O => XLXI_1_I3_n0074_1_LOGIC_ZERO
    );
  XLXI_1_I3_Madd_n0074_inst_cy_39_147 : X_MUX2
    port map (
      IA => XLXI_1_I3_acc_c_0_0,
      IB => XLXI_1_I3_n0074_1_LOGIC_ZERO,
      SEL => XLXI_1_I3_Madd_n0074_inst_lut2_30_rt,
      O => XLXI_1_I3_Madd_n0074_inst_cy_39
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_30_rt_148 : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_0,
      ADR1 => XLXI_1_I3_Madd_n0074_inst_lut2_30,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_30_rt
    );
  XLXI_1_I3_n0074_1_G : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_1,
      ADR1 => XLXI_1_I3_Madd_n0074_inst_lut2_31,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_1_I3_n0074_1_GROM
    );
  XLXI_1_I3_n0074_1_COUTUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0074_1_CYMUXG,
      O => XLXI_1_I3_Madd_n0074_inst_cy_40
    );
  XLXI_1_I3_n0074_1_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0074_1_XORG,
      O => XLXI_1_I3_n0074(1)
    );
  XLXI_1_I3_Madd_n0074_inst_cy_40_149 : X_MUX2
    port map (
      IA => XLXI_1_I3_acc_c_0_1,
      IB => XLXI_1_I3_Madd_n0074_inst_cy_39,
      SEL => XLXI_1_I3_n0074_1_GROM,
      O => XLXI_1_I3_n0074_1_CYMUXG
    );
  XLXI_1_I3_Madd_n0074_inst_sum_39 : X_XOR2
    port map (
      I0 => XLXI_1_I3_Madd_n0074_inst_cy_39,
      I1 => XLXI_1_I3_n0074_1_GROM,
      O => XLXI_1_I3_n0074_1_XORG
    );
  XLXI_1_I3_Madd_n0074_inst_cy_41_150 : X_MUX2
    port map (
      IA => XLXI_1_I3_acc_c_0_2,
      IB => XLXI_1_I3_n0074_2_CYINIT,
      SEL => XLXI_1_I3_n0074_2_FROM,
      O => XLXI_1_I3_Madd_n0074_inst_cy_41
    );
  XLXI_1_I3_Madd_n0074_inst_sum_40 : X_XOR2
    port map (
      I0 => XLXI_1_I3_n0074_2_CYINIT,
      I1 => XLXI_1_I3_n0074_2_FROM,
      O => XLXI_1_I3_n0074_2_XORF
    );
  XLXI_1_I3_n0074_2_F : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_2,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_1_I3_Madd_n0074_inst_lut2_32,
      O => XLXI_1_I3_n0074_2_FROM
    );
  XLXI_1_I3_n0074_2_G : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_3,
      ADR1 => VCC,
      ADR2 => XLXI_1_I3_Madd_n0074_inst_lut2_33,
      ADR3 => VCC,
      O => XLXI_1_I3_n0074_2_GROM
    );
  XLXI_1_I3_n0074_2_COUTUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0074_2_CYMUXG,
      O => XLXI_1_I3_Madd_n0074_inst_cy_42
    );
  XLXI_1_I3_n0074_2_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0074_2_XORF,
      O => XLXI_1_I3_n0074(2)
    );
  XLXI_1_I3_n0074_2_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0074_2_XORG,
      O => XLXI_1_I3_n0074(3)
    );
  XLXI_1_I3_Madd_n0074_inst_cy_42_151 : X_MUX2
    port map (
      IA => XLXI_1_I3_acc_c_0_3,
      IB => XLXI_1_I3_Madd_n0074_inst_cy_41,
      SEL => XLXI_1_I3_n0074_2_GROM,
      O => XLXI_1_I3_n0074_2_CYMUXG
    );
  XLXI_1_I3_Madd_n0074_inst_sum_41 : X_XOR2
    port map (
      I0 => XLXI_1_I3_Madd_n0074_inst_cy_41,
      I1 => XLXI_1_I3_n0074_2_GROM,
      O => XLXI_1_I3_n0074_2_XORG
    );
  XLXI_1_I3_n0074_2_CYINIT_152 : X_BUF
    port map (
      I => XLXI_1_I3_Madd_n0074_inst_cy_40,
      O => XLXI_1_I3_n0074_2_CYINIT
    );
  XLXI_1_I3_Madd_n0074_inst_cy_43_153 : X_MUX2
    port map (
      IA => XLXI_1_I3_acc_c_0_4,
      IB => XLXI_1_I3_n0074_4_CYINIT,
      SEL => XLXI_1_I3_n0074_4_FROM,
      O => XLXI_1_I3_Madd_n0074_inst_cy_43
    );
  XLXI_1_I3_Madd_n0074_inst_sum_42 : X_XOR2
    port map (
      I0 => XLXI_1_I3_n0074_4_CYINIT,
      I1 => XLXI_1_I3_n0074_4_FROM,
      O => XLXI_1_I3_n0074_4_XORF
    );
  XLXI_1_I3_n0074_4_F : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_4,
      ADR1 => VCC,
      ADR2 => XLXI_1_I3_Madd_n0074_inst_lut2_34,
      ADR3 => VCC,
      O => XLXI_1_I3_n0074_4_FROM
    );
  XLXI_1_I3_n0074_4_G : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_5,
      ADR1 => VCC,
      ADR2 => XLXI_1_I3_Madd_n0074_inst_lut2_35,
      ADR3 => VCC,
      O => XLXI_1_I3_n0074_4_GROM
    );
  XLXI_1_I3_n0074_4_COUTUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0074_4_CYMUXG,
      O => XLXI_1_I3_Madd_n0074_inst_cy_44
    );
  XLXI_1_I3_n0074_4_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0074_4_XORF,
      O => XLXI_1_I3_n0074(4)
    );
  XLXI_1_I3_n0074_4_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0074_4_XORG,
      O => XLXI_1_I3_n0074(5)
    );
  XLXI_1_I3_Madd_n0074_inst_cy_44_154 : X_MUX2
    port map (
      IA => XLXI_1_I3_acc_c_0_5,
      IB => XLXI_1_I3_Madd_n0074_inst_cy_43,
      SEL => XLXI_1_I3_n0074_4_GROM,
      O => XLXI_1_I3_n0074_4_CYMUXG
    );
  XLXI_1_I3_Madd_n0074_inst_sum_43 : X_XOR2
    port map (
      I0 => XLXI_1_I3_Madd_n0074_inst_cy_43,
      I1 => XLXI_1_I3_n0074_4_GROM,
      O => XLXI_1_I3_n0074_4_XORG
    );
  XLXI_1_I3_n0074_4_CYINIT_155 : X_BUF
    port map (
      I => XLXI_1_I3_Madd_n0074_inst_cy_42,
      O => XLXI_1_I3_n0074_4_CYINIT
    );
  XLXI_1_I3_Madd_n0074_inst_cy_45_156 : X_MUX2
    port map (
      IA => XLXI_1_I3_acc_c_0_6,
      IB => XLXI_1_I3_n0074_6_CYINIT,
      SEL => XLXI_1_I3_n0074_6_FROM,
      O => XLXI_1_I3_Madd_n0074_inst_cy_45
    );
  XLXI_1_I3_Madd_n0074_inst_sum_44 : X_XOR2
    port map (
      I0 => XLXI_1_I3_n0074_6_CYINIT,
      I1 => XLXI_1_I3_n0074_6_FROM,
      O => XLXI_1_I3_n0074_6_XORF
    );
  XLXI_1_I3_n0074_6_F : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_6,
      ADR1 => VCC,
      ADR2 => XLXI_1_I3_Madd_n0074_inst_lut2_36,
      ADR3 => VCC,
      O => XLXI_1_I3_n0074_6_FROM
    );
  XLXI_1_I3_n0074_6_G : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_7,
      ADR1 => VCC,
      ADR2 => XLXI_1_I3_Madd_n0074_inst_lut2_37,
      ADR3 => VCC,
      O => XLXI_1_I3_n0074_6_GROM
    );
  XLXI_1_I3_n0074_6_COUTUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0074_6_CYMUXG,
      O => XLXI_1_I3_n0065(8)
    );
  XLXI_1_I3_n0074_6_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0074_6_XORF,
      O => XLXI_1_I3_n0074(6)
    );
  XLXI_1_I3_n0074_6_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0074_6_XORG,
      O => XLXI_1_I3_n0074(7)
    );
  XLXI_1_I3_Madd_n0074_inst_cy_46 : X_MUX2
    port map (
      IA => XLXI_1_I3_acc_c_0_7,
      IB => XLXI_1_I3_Madd_n0074_inst_cy_45,
      SEL => XLXI_1_I3_n0074_6_GROM,
      O => XLXI_1_I3_n0074_6_CYMUXG
    );
  XLXI_1_I3_Madd_n0074_inst_sum_45 : X_XOR2
    port map (
      I0 => XLXI_1_I3_Madd_n0074_inst_cy_45,
      I1 => XLXI_1_I3_n0074_6_GROM,
      O => XLXI_1_I3_n0074_6_XORG
    );
  XLXI_1_I3_n0074_6_CYINIT_157 : X_BUF
    port map (
      I => XLXI_1_I3_Madd_n0074_inst_cy_44,
      O => XLXI_1_I3_n0074_6_CYINIT
    );
  XLXI_26_n0060_1_LOGIC_ZERO_158 : X_ZERO
    port map (
      O => XLXI_26_n0060_1_LOGIC_ZERO
    );
  XLXI_26_Madd_n0060_inst_cy_16_159 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC1,
      IB => XLXI_26_n0060_1_LOGIC_ZERO,
      SEL => XLXI_26_Madd_n0060_inst_lut2_16,
      O => XLXI_26_Madd_n0060_inst_cy_16
    );
  XLXI_26_Madd_n0060_inst_lut2_161 : X_LUT4
    generic map(
      INIT => X"3333"
    )
    port map (
      ADR0 => GLOBAL_LOGIC1,
      ADR1 => XLXI_26_rx_8_count(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_26_Madd_n0060_inst_lut2_16
    );
  XLXI_26_n0060_1_G : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => GLOBAL_LOGIC0_2,
      ADR1 => XLXI_26_rx_8_count(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_26_n0060_1_GROM
    );
  XLXI_26_n0060_1_COUTUSED : X_BUF
    port map (
      I => XLXI_26_n0060_1_CYMUXG,
      O => XLXI_26_Madd_n0060_inst_cy_17
    );
  XLXI_26_n0060_1_YUSED : X_BUF
    port map (
      I => XLXI_26_n0060_1_XORG,
      O => XLXI_26_n0060(1)
    );
  XLXI_26_Madd_n0060_inst_cy_17_160 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC0_2,
      IB => XLXI_26_Madd_n0060_inst_cy_16,
      SEL => XLXI_26_n0060_1_GROM,
      O => XLXI_26_n0060_1_CYMUXG
    );
  XLXI_26_Madd_n0060_inst_sum_17 : X_XOR2
    port map (
      I0 => XLXI_26_Madd_n0060_inst_cy_16,
      I1 => XLXI_26_n0060_1_GROM,
      O => XLXI_26_n0060_1_XORG
    );
  XLXI_26_n0060_2_LOGIC_ZERO_161 : X_ZERO
    port map (
      O => XLXI_26_n0060_2_LOGIC_ZERO
    );
  XLXI_26_Madd_n0060_inst_cy_18_162 : X_MUX2
    port map (
      IA => XLXI_26_n0060_2_LOGIC_ZERO,
      IB => XLXI_26_n0060_2_CYINIT,
      SEL => XLXI_26_n0060_2_FROM,
      O => XLXI_26_Madd_n0060_inst_cy_18
    );
  XLXI_26_Madd_n0060_inst_sum_18 : X_XOR2
    port map (
      I0 => XLXI_26_n0060_2_CYINIT,
      I1 => XLXI_26_n0060_2_FROM,
      O => XLXI_26_n0060_2_XORF
    );
  XLXI_26_n0060_2_F : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_26_rx_8_count(2),
      ADR3 => VCC,
      O => XLXI_26_n0060_2_FROM
    );
  XLXI_26_rx_8_count_3_rt_163 : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_26_rx_8_count(3),
      O => XLXI_26_rx_8_count_3_rt
    );
  XLXI_26_n0060_2_XUSED : X_BUF
    port map (
      I => XLXI_26_n0060_2_XORF,
      O => XLXI_26_n0060(2)
    );
  XLXI_26_n0060_2_YUSED : X_BUF
    port map (
      I => XLXI_26_n0060_2_XORG,
      O => XLXI_26_n0060(3)
    );
  XLXI_26_Madd_n0060_inst_sum_19 : X_XOR2
    port map (
      I0 => XLXI_26_Madd_n0060_inst_cy_18,
      I1 => XLXI_26_rx_8_count_3_rt,
      O => XLXI_26_n0060_2_XORG
    );
  XLXI_26_n0060_2_CYINIT_164 : X_BUF
    port map (
      I => XLXI_26_Madd_n0060_inst_cy_17,
      O => XLXI_26_n0060_2_CYINIT
    );
  XLXI_26_n0061_1_LOGIC_ZERO_165 : X_ZERO
    port map (
      O => XLXI_26_n0061_1_LOGIC_ZERO
    );
  XLXI_26_Madd_n0061_inst_cy_16_166 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC1_2,
      IB => XLXI_26_n0061_1_LOGIC_ZERO,
      SEL => XLXI_26_Madd_n0061_inst_lut2_16,
      O => XLXI_26_Madd_n0061_inst_cy_16
    );
  XLXI_26_Madd_n0061_inst_lut2_161 : X_LUT4
    generic map(
      INIT => X"0F0F"
    )
    port map (
      ADR0 => GLOBAL_LOGIC1_2,
      ADR1 => VCC,
      ADR2 => XLXI_26_rx_16_count(0),
      ADR3 => VCC,
      O => XLXI_26_Madd_n0061_inst_lut2_16
    );
  XLXI_26_n0061_1_G : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => GLOBAL_LOGIC0_0,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_26_rx_16_count(1),
      O => XLXI_26_n0061_1_GROM
    );
  XLXI_26_n0061_1_COUTUSED : X_BUF
    port map (
      I => XLXI_26_n0061_1_CYMUXG,
      O => XLXI_26_Madd_n0061_inst_cy_17
    );
  XLXI_26_n0061_1_YUSED : X_BUF
    port map (
      I => XLXI_26_n0061_1_XORG,
      O => XLXI_26_n0061(1)
    );
  XLXI_26_Madd_n0061_inst_cy_17_167 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC0_0,
      IB => XLXI_26_Madd_n0061_inst_cy_16,
      SEL => XLXI_26_n0061_1_GROM,
      O => XLXI_26_n0061_1_CYMUXG
    );
  XLXI_26_Madd_n0061_inst_sum_17 : X_XOR2
    port map (
      I0 => XLXI_26_Madd_n0061_inst_cy_16,
      I1 => XLXI_26_n0061_1_GROM,
      O => XLXI_26_n0061_1_XORG
    );
  XLXI_26_n0061_2_LOGIC_ZERO_168 : X_ZERO
    port map (
      O => XLXI_26_n0061_2_LOGIC_ZERO
    );
  XLXI_26_Madd_n0061_inst_cy_18_169 : X_MUX2
    port map (
      IA => XLXI_26_n0061_2_LOGIC_ZERO,
      IB => XLXI_26_n0061_2_CYINIT,
      SEL => XLXI_26_n0061_2_FROM,
      O => XLXI_26_Madd_n0061_inst_cy_18
    );
  XLXI_26_Madd_n0061_inst_sum_18 : X_XOR2
    port map (
      I0 => XLXI_26_n0061_2_CYINIT,
      I1 => XLXI_26_n0061_2_FROM,
      O => XLXI_26_n0061_2_XORF
    );
  XLXI_26_n0061_2_F : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_26_rx_16_count(2),
      ADR3 => VCC,
      O => XLXI_26_n0061_2_FROM
    );
  XLXI_26_rx_16_count_3_rt_170 : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_26_rx_16_count(3),
      O => XLXI_26_rx_16_count_3_rt
    );
  XLXI_26_n0061_2_XUSED : X_BUF
    port map (
      I => XLXI_26_n0061_2_XORF,
      O => XLXI_26_n0061(2)
    );
  XLXI_26_n0061_2_YUSED : X_BUF
    port map (
      I => XLXI_26_n0061_2_XORG,
      O => XLXI_26_n0061(3)
    );
  XLXI_26_Madd_n0061_inst_sum_19 : X_XOR2
    port map (
      I0 => XLXI_26_Madd_n0061_inst_cy_18,
      I1 => XLXI_26_rx_16_count_3_rt,
      O => XLXI_26_n0061_2_XORG
    );
  XLXI_26_n0061_2_CYINIT_171 : X_BUF
    port map (
      I => XLXI_26_Madd_n0061_inst_cy_17,
      O => XLXI_26_n0061_2_CYINIT
    );
  XLXI_1_I1_n0024_1_LOGIC_ZERO_172 : X_ZERO
    port map (
      O => XLXI_1_I1_n0024_1_LOGIC_ZERO
    );
  XLXI_1_I1_Madd_n0024_inst_cy_29_173 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC1_3,
      IB => XLXI_1_I1_n0024_1_LOGIC_ZERO,
      SEL => XLXI_1_I1_Madd_n0024_inst_lut2_20,
      O => XLXI_1_I1_Madd_n0024_inst_cy_29
    );
  XLXI_1_I1_Madd_n0024_inst_lut2_201 : X_LUT4
    generic map(
      INIT => X"0F0F"
    )
    port map (
      ADR0 => GLOBAL_LOGIC1_3,
      ADR1 => VCC,
      ADR2 => XLXI_1_I1_pc(0),
      ADR3 => VCC,
      O => XLXI_1_I1_Madd_n0024_inst_lut2_20
    );
  XLXI_1_I1_n0024_1_G : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => GLOBAL_LOGIC0_5,
      ADR1 => XLXI_1_I1_pc(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_1_I1_n0024_1_GROM
    );
  XLXI_1_I1_n0024_1_COUTUSED : X_BUF
    port map (
      I => XLXI_1_I1_n0024_1_CYMUXG,
      O => XLXI_1_I1_Madd_n0024_inst_cy_30
    );
  XLXI_1_I1_n0024_1_YUSED : X_BUF
    port map (
      I => XLXI_1_I1_n0024_1_XORG,
      O => XLXI_1_I1_n0024(1)
    );
  XLXI_1_I1_Madd_n0024_inst_cy_30_174 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC0_5,
      IB => XLXI_1_I1_Madd_n0024_inst_cy_29,
      SEL => XLXI_1_I1_n0024_1_GROM,
      O => XLXI_1_I1_n0024_1_CYMUXG
    );
  XLXI_1_I1_Madd_n0024_inst_sum_29 : X_XOR2
    port map (
      I0 => XLXI_1_I1_Madd_n0024_inst_cy_29,
      I1 => XLXI_1_I1_n0024_1_GROM,
      O => XLXI_1_I1_n0024_1_XORG
    );
  XLXI_1_I1_n0024_2_LOGIC_ZERO_175 : X_ZERO
    port map (
      O => XLXI_1_I1_n0024_2_LOGIC_ZERO
    );
  XLXI_1_I1_Madd_n0024_inst_cy_31_176 : X_MUX2
    port map (
      IA => XLXI_1_I1_n0024_2_LOGIC_ZERO,
      IB => XLXI_1_I1_n0024_2_CYINIT,
      SEL => XLXI_1_I1_n0024_2_FROM,
      O => XLXI_1_I1_Madd_n0024_inst_cy_31
    );
  XLXI_1_I1_Madd_n0024_inst_sum_30 : X_XOR2
    port map (
      I0 => XLXI_1_I1_n0024_2_CYINIT,
      I1 => XLXI_1_I1_n0024_2_FROM,
      O => XLXI_1_I1_n0024_2_XORF
    );
  XLXI_1_I1_n0024_2_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_pc(2),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_1_I1_n0024_2_FROM
    );
  XLXI_1_I1_n0024_2_G : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_pc(3),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_1_I1_n0024_2_GROM
    );
  XLXI_1_I1_n0024_2_COUTUSED : X_BUF
    port map (
      I => XLXI_1_I1_n0024_2_CYMUXG,
      O => XLXI_1_I1_Madd_n0024_inst_cy_32
    );
  XLXI_1_I1_n0024_2_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_n0024_2_XORF,
      O => XLXI_1_I1_n0024(2)
    );
  XLXI_1_I1_n0024_2_YUSED : X_BUF
    port map (
      I => XLXI_1_I1_n0024_2_XORG,
      O => XLXI_1_I1_n0024(3)
    );
  XLXI_1_I1_Madd_n0024_inst_cy_32_177 : X_MUX2
    port map (
      IA => XLXI_1_I1_n0024_2_LOGIC_ZERO,
      IB => XLXI_1_I1_Madd_n0024_inst_cy_31,
      SEL => XLXI_1_I1_n0024_2_GROM,
      O => XLXI_1_I1_n0024_2_CYMUXG
    );
  XLXI_1_I1_Madd_n0024_inst_sum_31 : X_XOR2
    port map (
      I0 => XLXI_1_I1_Madd_n0024_inst_cy_31,
      I1 => XLXI_1_I1_n0024_2_GROM,
      O => XLXI_1_I1_n0024_2_XORG
    );
  XLXI_1_I1_n0024_2_CYINIT_178 : X_BUF
    port map (
      I => XLXI_1_I1_Madd_n0024_inst_cy_30,
      O => XLXI_1_I1_n0024_2_CYINIT
    );
  XLXI_1_I1_n0024_4_LOGIC_ZERO_179 : X_ZERO
    port map (
      O => XLXI_1_I1_n0024_4_LOGIC_ZERO
    );
  XLXI_1_I1_Madd_n0024_inst_cy_33_180 : X_MUX2
    port map (
      IA => XLXI_1_I1_n0024_4_LOGIC_ZERO,
      IB => XLXI_1_I1_n0024_4_CYINIT,
      SEL => XLXI_1_I1_n0024_4_FROM,
      O => XLXI_1_I1_Madd_n0024_inst_cy_33
    );
  XLXI_1_I1_Madd_n0024_inst_sum_32 : X_XOR2
    port map (
      I0 => XLXI_1_I1_n0024_4_CYINIT,
      I1 => XLXI_1_I1_n0024_4_FROM,
      O => XLXI_1_I1_n0024_4_XORF
    );
  XLXI_1_I1_n0024_4_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_pc(4),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_1_I1_n0024_4_FROM
    );
  XLXI_1_I1_n0024_4_G : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_1_I1_pc(5),
      O => XLXI_1_I1_n0024_4_GROM
    );
  XLXI_1_I1_n0024_4_COUTUSED : X_BUF
    port map (
      I => XLXI_1_I1_n0024_4_CYMUXG,
      O => XLXI_1_I1_Madd_n0024_inst_cy_34
    );
  XLXI_1_I1_n0024_4_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_n0024_4_XORF,
      O => XLXI_1_I1_n0024(4)
    );
  XLXI_1_I1_n0024_4_YUSED : X_BUF
    port map (
      I => XLXI_1_I1_n0024_4_XORG,
      O => XLXI_1_I1_n0024(5)
    );
  XLXI_1_I1_Madd_n0024_inst_cy_34_181 : X_MUX2
    port map (
      IA => XLXI_1_I1_n0024_4_LOGIC_ZERO,
      IB => XLXI_1_I1_Madd_n0024_inst_cy_33,
      SEL => XLXI_1_I1_n0024_4_GROM,
      O => XLXI_1_I1_n0024_4_CYMUXG
    );
  XLXI_1_I1_Madd_n0024_inst_sum_33 : X_XOR2
    port map (
      I0 => XLXI_1_I1_Madd_n0024_inst_cy_33,
      I1 => XLXI_1_I1_n0024_4_GROM,
      O => XLXI_1_I1_n0024_4_XORG
    );
  XLXI_1_I1_n0024_4_CYINIT_182 : X_BUF
    port map (
      I => XLXI_1_I1_Madd_n0024_inst_cy_32,
      O => XLXI_1_I1_n0024_4_CYINIT
    );
  XLXI_1_I1_n0024_6_LOGIC_ZERO_183 : X_ZERO
    port map (
      O => XLXI_1_I1_n0024_6_LOGIC_ZERO
    );
  XLXI_1_I1_Madd_n0024_inst_cy_35_184 : X_MUX2
    port map (
      IA => XLXI_1_I1_n0024_6_LOGIC_ZERO,
      IB => XLXI_1_I1_n0024_6_CYINIT,
      SEL => XLXI_1_I1_n0024_6_FROM,
      O => XLXI_1_I1_Madd_n0024_inst_cy_35
    );
  XLXI_1_I1_Madd_n0024_inst_sum_34 : X_XOR2
    port map (
      I0 => XLXI_1_I1_n0024_6_CYINIT,
      I1 => XLXI_1_I1_n0024_6_FROM,
      O => XLXI_1_I1_n0024_6_XORF
    );
  XLXI_1_I1_n0024_6_F : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_1_I1_pc(6),
      O => XLXI_1_I1_n0024_6_FROM
    );
  XLXI_1_I1_n0024_6_G : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_1_I1_pc(7),
      O => XLXI_1_I1_n0024_6_GROM
    );
  XLXI_1_I1_n0024_6_COUTUSED : X_BUF
    port map (
      I => XLXI_1_I1_n0024_6_CYMUXG,
      O => XLXI_1_I1_Madd_n0024_inst_cy_36
    );
  XLXI_1_I1_n0024_6_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_n0024_6_XORF,
      O => XLXI_1_I1_n0024(6)
    );
  XLXI_1_I1_n0024_6_YUSED : X_BUF
    port map (
      I => XLXI_1_I1_n0024_6_XORG,
      O => XLXI_1_I1_n0024(7)
    );
  XLXI_1_I1_Madd_n0024_inst_cy_36_185 : X_MUX2
    port map (
      IA => XLXI_1_I1_n0024_6_LOGIC_ZERO,
      IB => XLXI_1_I1_Madd_n0024_inst_cy_35,
      SEL => XLXI_1_I1_n0024_6_GROM,
      O => XLXI_1_I1_n0024_6_CYMUXG
    );
  XLXI_1_I1_Madd_n0024_inst_sum_35 : X_XOR2
    port map (
      I0 => XLXI_1_I1_Madd_n0024_inst_cy_35,
      I1 => XLXI_1_I1_n0024_6_GROM,
      O => XLXI_1_I1_n0024_6_XORG
    );
  XLXI_1_I1_n0024_6_CYINIT_186 : X_BUF
    port map (
      I => XLXI_1_I1_Madd_n0024_inst_cy_34,
      O => XLXI_1_I1_n0024_6_CYINIT
    );
  XLXI_1_I1_n0024_8_LOGIC_ZERO_187 : X_ZERO
    port map (
      O => XLXI_1_I1_n0024_8_LOGIC_ZERO
    );
  XLXI_1_I1_Madd_n0024_inst_cy_37_188 : X_MUX2
    port map (
      IA => XLXI_1_I1_n0024_8_LOGIC_ZERO,
      IB => XLXI_1_I1_n0024_8_CYINIT,
      SEL => XLXI_1_I1_n0024_8_FROM,
      O => XLXI_1_I1_Madd_n0024_inst_cy_37
    );
  XLXI_1_I1_Madd_n0024_inst_sum_36 : X_XOR2
    port map (
      I0 => XLXI_1_I1_n0024_8_CYINIT,
      I1 => XLXI_1_I1_n0024_8_FROM,
      O => XLXI_1_I1_n0024_8_XORF
    );
  XLXI_1_I1_n0024_8_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_pc(8),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_1_I1_n0024_8_FROM
    );
  XLXI_1_I1_pc_9_rt_189 : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_1_I1_pc(9),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_1_I1_pc_9_rt
    );
  XLXI_1_I1_n0024_8_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_n0024_8_XORF,
      O => XLXI_1_I1_n0024(8)
    );
  XLXI_1_I1_n0024_8_YUSED : X_BUF
    port map (
      I => XLXI_1_I1_n0024_8_XORG,
      O => XLXI_1_I1_n0024(9)
    );
  XLXI_1_I1_Madd_n0024_inst_sum_37 : X_XOR2
    port map (
      I0 => XLXI_1_I1_Madd_n0024_inst_cy_37,
      I1 => XLXI_1_I1_pc_9_rt,
      O => XLXI_1_I1_n0024_8_XORG
    );
  XLXI_1_I1_n0024_8_CYINIT_190 : X_BUF
    port map (
      I => XLXI_1_I1_Madd_n0024_inst_cy_36,
      O => XLXI_1_I1_n0024_8_CYINIT
    );
  XLXI_5_n0017_1_LOGIC_ZERO_191 : X_ZERO
    port map (
      O => XLXI_5_n0017_1_LOGIC_ZERO
    );
  XLXI_5_Madd_n0017_inst_cy_0_192 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC1_4,
      IB => XLXI_5_n0017_1_LOGIC_ZERO,
      SEL => XLXI_5_Madd_n0017_inst_lut2_0,
      O => XLXI_5_Madd_n0017_inst_cy_0
    );
  XLXI_5_Madd_n0017_inst_lut2_01 : X_LUT4
    generic map(
      INIT => X"3333"
    )
    port map (
      ADR0 => GLOBAL_LOGIC1_4,
      ADR1 => XLXI_5_tmr_low(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_Madd_n0017_inst_lut2_0
    );
  XLXI_5_n0017_1_G : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => GLOBAL_LOGIC0_3,
      ADR1 => VCC,
      ADR2 => XLXI_5_tmr_low(1),
      ADR3 => VCC,
      O => XLXI_5_n0017_1_GROM
    );
  XLXI_5_n0017_1_COUTUSED : X_BUF
    port map (
      I => XLXI_5_n0017_1_CYMUXG,
      O => XLXI_5_Madd_n0017_inst_cy_1
    );
  XLXI_5_n0017_1_YUSED : X_BUF
    port map (
      I => XLXI_5_n0017_1_XORG,
      O => XLXI_5_n0017(1)
    );
  XLXI_5_Madd_n0017_inst_cy_1_193 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC0_3,
      IB => XLXI_5_Madd_n0017_inst_cy_0,
      SEL => XLXI_5_n0017_1_GROM,
      O => XLXI_5_n0017_1_CYMUXG
    );
  XLXI_5_Madd_n0017_inst_sum_1 : X_XOR2
    port map (
      I0 => XLXI_5_Madd_n0017_inst_cy_0,
      I1 => XLXI_5_n0017_1_GROM,
      O => XLXI_5_n0017_1_XORG
    );
  XLXI_5_n0017_2_LOGIC_ZERO_194 : X_ZERO
    port map (
      O => XLXI_5_n0017_2_LOGIC_ZERO
    );
  XLXI_5_Madd_n0017_inst_cy_2_195 : X_MUX2
    port map (
      IA => XLXI_5_n0017_2_LOGIC_ZERO,
      IB => XLXI_5_n0017_2_CYINIT,
      SEL => XLXI_5_n0017_2_FROM,
      O => XLXI_5_Madd_n0017_inst_cy_2
    );
  XLXI_5_Madd_n0017_inst_sum_2 : X_XOR2
    port map (
      I0 => XLXI_5_n0017_2_CYINIT,
      I1 => XLXI_5_n0017_2_FROM,
      O => XLXI_5_n0017_2_XORF
    );
  XLXI_5_n0017_2_F : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_5_tmr_low(2),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_n0017_2_FROM
    );
  XLXI_5_n0017_2_G : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_5_tmr_low(3),
      ADR3 => VCC,
      O => XLXI_5_n0017_2_GROM
    );
  XLXI_5_n0017_2_COUTUSED : X_BUF
    port map (
      I => XLXI_5_n0017_2_CYMUXG,
      O => XLXI_5_Madd_n0017_inst_cy_3
    );
  XLXI_5_n0017_2_XUSED : X_BUF
    port map (
      I => XLXI_5_n0017_2_XORF,
      O => XLXI_5_n0017(2)
    );
  XLXI_5_n0017_2_YUSED : X_BUF
    port map (
      I => XLXI_5_n0017_2_XORG,
      O => XLXI_5_n0017(3)
    );
  XLXI_5_Madd_n0017_inst_cy_3_196 : X_MUX2
    port map (
      IA => XLXI_5_n0017_2_LOGIC_ZERO,
      IB => XLXI_5_Madd_n0017_inst_cy_2,
      SEL => XLXI_5_n0017_2_GROM,
      O => XLXI_5_n0017_2_CYMUXG
    );
  XLXI_5_Madd_n0017_inst_sum_3 : X_XOR2
    port map (
      I0 => XLXI_5_Madd_n0017_inst_cy_2,
      I1 => XLXI_5_n0017_2_GROM,
      O => XLXI_5_n0017_2_XORG
    );
  XLXI_5_n0017_2_CYINIT_197 : X_BUF
    port map (
      I => XLXI_5_Madd_n0017_inst_cy_1,
      O => XLXI_5_n0017_2_CYINIT
    );
  XLXI_5_n0017_4_LOGIC_ZERO_198 : X_ZERO
    port map (
      O => XLXI_5_n0017_4_LOGIC_ZERO
    );
  XLXI_5_Madd_n0017_inst_cy_4_199 : X_MUX2
    port map (
      IA => XLXI_5_n0017_4_LOGIC_ZERO,
      IB => XLXI_5_n0017_4_CYINIT,
      SEL => XLXI_5_n0017_4_FROM,
      O => XLXI_5_Madd_n0017_inst_cy_4
    );
  XLXI_5_Madd_n0017_inst_sum_4 : X_XOR2
    port map (
      I0 => XLXI_5_n0017_4_CYINIT,
      I1 => XLXI_5_n0017_4_FROM,
      O => XLXI_5_n0017_4_XORF
    );
  XLXI_5_n0017_4_F : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_5_tmr_low(4),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_n0017_4_FROM
    );
  XLXI_5_n0017_4_G : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_5_tmr_low(5),
      ADR3 => VCC,
      O => XLXI_5_n0017_4_GROM
    );
  XLXI_5_n0017_4_COUTUSED : X_BUF
    port map (
      I => XLXI_5_n0017_4_CYMUXG,
      O => XLXI_5_Madd_n0017_inst_cy_5
    );
  XLXI_5_n0017_4_XUSED : X_BUF
    port map (
      I => XLXI_5_n0017_4_XORF,
      O => XLXI_5_n0017(4)
    );
  XLXI_5_n0017_4_YUSED : X_BUF
    port map (
      I => XLXI_5_n0017_4_XORG,
      O => XLXI_5_n0017(5)
    );
  XLXI_5_Madd_n0017_inst_cy_5_200 : X_MUX2
    port map (
      IA => XLXI_5_n0017_4_LOGIC_ZERO,
      IB => XLXI_5_Madd_n0017_inst_cy_4,
      SEL => XLXI_5_n0017_4_GROM,
      O => XLXI_5_n0017_4_CYMUXG
    );
  XLXI_5_Madd_n0017_inst_sum_5 : X_XOR2
    port map (
      I0 => XLXI_5_Madd_n0017_inst_cy_4,
      I1 => XLXI_5_n0017_4_GROM,
      O => XLXI_5_n0017_4_XORG
    );
  XLXI_5_n0017_4_CYINIT_201 : X_BUF
    port map (
      I => XLXI_5_Madd_n0017_inst_cy_3,
      O => XLXI_5_n0017_4_CYINIT
    );
  XLXI_3_out_1reg_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => OUT1_REG_1_OD,
      CE => XLXI_3_n0002,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => OUT1_REG_1_OFF_RST,
      O => XLXI_3_out_1reg(1)
    );
  OUT1_REG_1_OFF_RSTOR : X_OR2
    port map (
      I0 => OUT1_REG_1_SRMUXNOT,
      I1 => GSR,
      O => OUT1_REG_1_OFF_RST
    );
  XLXI_5_n0017_6_LOGIC_ZERO_202 : X_ZERO
    port map (
      O => XLXI_5_n0017_6_LOGIC_ZERO
    );
  XLXI_5_Madd_n0017_inst_cy_6_203 : X_MUX2
    port map (
      IA => XLXI_5_n0017_6_LOGIC_ZERO,
      IB => XLXI_5_n0017_6_CYINIT,
      SEL => XLXI_5_n0017_6_FROM,
      O => XLXI_5_Madd_n0017_inst_cy_6
    );
  XLXI_5_Madd_n0017_inst_sum_6 : X_XOR2
    port map (
      I0 => XLXI_5_n0017_6_CYINIT,
      I1 => XLXI_5_n0017_6_FROM,
      O => XLXI_5_n0017_6_XORF
    );
  XLXI_5_n0017_6_F : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_5_tmr_low(6),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_n0017_6_FROM
    );
  XLXI_5_tmr_low_7_rt_204 : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_5_tmr_low(7),
      ADR3 => VCC,
      O => XLXI_5_tmr_low_7_rt
    );
  XLXI_5_n0017_6_XUSED : X_BUF
    port map (
      I => XLXI_5_n0017_6_XORF,
      O => XLXI_5_n0017(6)
    );
  XLXI_5_n0017_6_YUSED : X_BUF
    port map (
      I => XLXI_5_n0017_6_XORG,
      O => XLXI_5_n0017(7)
    );
  XLXI_5_Madd_n0017_inst_sum_7 : X_XOR2
    port map (
      I0 => XLXI_5_Madd_n0017_inst_cy_6,
      I1 => XLXI_5_tmr_low_7_rt,
      O => XLXI_5_n0017_6_XORG
    );
  XLXI_5_n0017_6_CYINIT_205 : X_BUF
    port map (
      I => XLXI_5_Madd_n0017_inst_cy_5,
      O => XLXI_5_n0017_6_CYINIT
    );
  XLXI_26_rx_clk_count_0_LOGIC_ZERO_206 : X_ZERO
    port map (
      O => XLXI_26_rx_clk_count_0_LOGIC_ZERO
    );
  XLXI_26_rx_clk_count_0_LOGIC_ONE_207 : X_ONE
    port map (
      O => XLXI_26_rx_clk_count_0_LOGIC_ONE
    );
  XLXI_26_rx_clk_count_inst_cy_20_208 : X_MUX2
    port map (
      IA => XLXI_26_rx_clk_count_0_LOGIC_ONE,
      IB => XLXI_26_rx_clk_count_0_LOGIC_ZERO,
      SEL => XLXI_26_n0097,
      O => XLXI_26_rx_clk_count_inst_cy_20
    );
  XLXI_26_n00971 : X_LUT4
    generic map(
      INIT => X"55FF"
    )
    port map (
      ADR0 => CHOICE1039,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => CHOICE1032,
      O => XLXI_26_n0097
    );
  XLXI_26_rx_clk_count_inst_lut3_01 : X_LUT4
    generic map(
      INIT => X"470F"
    )
    port map (
      ADR0 => XLXI_26_rx_clk_div(0),
      ADR1 => CHOICE1032,
      ADR2 => XLXI_26_rx_clk_count(0),
      ADR3 => CHOICE1039,
      O => XLXI_26_rx_clk_count_inst_lut3_0
    );
  XLXI_26_rx_clk_count_0_COUTUSED : X_BUF
    port map (
      I => XLXI_26_rx_clk_count_0_CYMUXG,
      O => XLXI_26_rx_clk_count_inst_cy_21
    );
  XLXI_26_rx_clk_count_inst_cy_21_209 : X_MUX2
    port map (
      IA => XLXI_26_rx_clk_count_0_LOGIC_ONE,
      IB => XLXI_26_rx_clk_count_inst_cy_20,
      SEL => XLXI_26_rx_clk_count_inst_lut3_0,
      O => XLXI_26_rx_clk_count_0_CYMUXG
    );
  XLXI_26_rx_clk_count_inst_sum_20_210 : X_XOR2
    port map (
      I0 => XLXI_26_rx_clk_count_inst_cy_20,
      I1 => XLXI_26_rx_clk_count_inst_lut3_0,
      O => XLXI_26_rx_clk_count_inst_sum_20
    );
  XLXI_26_rx_clk_count_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_clk_count_0_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_clk_count_1_LOGIC_ONE_211 : X_ONE
    port map (
      O => XLXI_26_rx_clk_count_1_LOGIC_ONE
    );
  XLXI_26_rx_clk_count_inst_cy_22_212 : X_MUX2
    port map (
      IA => XLXI_26_rx_clk_count_1_LOGIC_ONE,
      IB => XLXI_26_rx_clk_count_1_CYINIT,
      SEL => XLXI_26_rx_clk_count_inst_lut3_1,
      O => XLXI_26_rx_clk_count_inst_cy_22
    );
  XLXI_26_rx_clk_count_inst_sum_21_213 : X_XOR2
    port map (
      I0 => XLXI_26_rx_clk_count_1_CYINIT,
      I1 => XLXI_26_rx_clk_count_inst_lut3_1,
      O => XLXI_26_rx_clk_count_inst_sum_21
    );
  XLXI_26_rx_clk_count_inst_lut3_11 : X_LUT4
    generic map(
      INIT => X"1D55"
    )
    port map (
      ADR0 => XLXI_26_rx_clk_count(1),
      ADR1 => CHOICE1032,
      ADR2 => XLXI_26_rx_clk_div(1),
      ADR3 => CHOICE1039,
      O => XLXI_26_rx_clk_count_inst_lut3_1
    );
  XLXI_26_rx_clk_count_inst_lut3_21 : X_LUT4
    generic map(
      INIT => X"1D55"
    )
    port map (
      ADR0 => XLXI_26_rx_clk_count(2),
      ADR1 => CHOICE1032,
      ADR2 => XLXI_26_rx_clk_div(2),
      ADR3 => CHOICE1039,
      O => XLXI_26_rx_clk_count_inst_lut3_2
    );
  XLXI_26_rx_clk_count_1_COUTUSED : X_BUF
    port map (
      I => XLXI_26_rx_clk_count_1_CYMUXG,
      O => XLXI_26_rx_clk_count_inst_cy_23
    );
  XLXI_26_rx_clk_count_inst_cy_23_214 : X_MUX2
    port map (
      IA => XLXI_26_rx_clk_count_1_LOGIC_ONE,
      IB => XLXI_26_rx_clk_count_inst_cy_22,
      SEL => XLXI_26_rx_clk_count_inst_lut3_2,
      O => XLXI_26_rx_clk_count_1_CYMUXG
    );
  XLXI_26_rx_clk_count_inst_sum_22_215 : X_XOR2
    port map (
      I0 => XLXI_26_rx_clk_count_inst_cy_22,
      I1 => XLXI_26_rx_clk_count_inst_lut3_2,
      O => XLXI_26_rx_clk_count_inst_sum_22
    );
  XLXI_26_rx_clk_count_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_clk_count_1_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_clk_count_1_CYINIT_216 : X_BUF
    port map (
      I => XLXI_26_rx_clk_count_inst_cy_21,
      O => XLXI_26_rx_clk_count_1_CYINIT
    );
  XLXI_26_rx_clk_count_3_LOGIC_ONE_217 : X_ONE
    port map (
      O => XLXI_26_rx_clk_count_3_LOGIC_ONE
    );
  XLXI_26_rx_clk_count_inst_cy_24_218 : X_MUX2
    port map (
      IA => XLXI_26_rx_clk_count_3_LOGIC_ONE,
      IB => XLXI_26_rx_clk_count_3_CYINIT,
      SEL => XLXI_26_rx_clk_count_inst_lut3_3,
      O => XLXI_26_rx_clk_count_inst_cy_24
    );
  XLXI_26_rx_clk_count_inst_sum_23_219 : X_XOR2
    port map (
      I0 => XLXI_26_rx_clk_count_3_CYINIT,
      I1 => XLXI_26_rx_clk_count_inst_lut3_3,
      O => XLXI_26_rx_clk_count_inst_sum_23
    );
  XLXI_26_rx_clk_count_inst_lut3_31 : X_LUT4
    generic map(
      INIT => X"270F"
    )
    port map (
      ADR0 => CHOICE1039,
      ADR1 => XLXI_26_rx_clk_div(3),
      ADR2 => XLXI_26_rx_clk_count(3),
      ADR3 => CHOICE1032,
      O => XLXI_26_rx_clk_count_inst_lut3_3
    );
  XLXI_26_rx_clk_count_inst_lut3_41 : X_LUT4
    generic map(
      INIT => X"1B33"
    )
    port map (
      ADR0 => CHOICE1039,
      ADR1 => XLXI_26_rx_clk_count(4),
      ADR2 => XLXI_26_rx_clk_div(4),
      ADR3 => CHOICE1032,
      O => XLXI_26_rx_clk_count_inst_lut3_4
    );
  XLXI_26_rx_clk_count_3_COUTUSED : X_BUF
    port map (
      I => XLXI_26_rx_clk_count_3_CYMUXG,
      O => XLXI_26_rx_clk_count_inst_cy_25
    );
  XLXI_26_rx_clk_count_inst_cy_25_220 : X_MUX2
    port map (
      IA => XLXI_26_rx_clk_count_3_LOGIC_ONE,
      IB => XLXI_26_rx_clk_count_inst_cy_24,
      SEL => XLXI_26_rx_clk_count_inst_lut3_4,
      O => XLXI_26_rx_clk_count_3_CYMUXG
    );
  XLXI_26_rx_clk_count_inst_sum_24_221 : X_XOR2
    port map (
      I0 => XLXI_26_rx_clk_count_inst_cy_24,
      I1 => XLXI_26_rx_clk_count_inst_lut3_4,
      O => XLXI_26_rx_clk_count_inst_sum_24
    );
  XLXI_26_rx_clk_count_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_clk_count_3_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_clk_count_3_CYINIT_222 : X_BUF
    port map (
      I => XLXI_26_rx_clk_count_inst_cy_23,
      O => XLXI_26_rx_clk_count_3_CYINIT
    );
  XLXI_26_rx_clk_count_5_LOGIC_ONE_223 : X_ONE
    port map (
      O => XLXI_26_rx_clk_count_5_LOGIC_ONE
    );
  XLXI_26_rx_clk_count_inst_cy_26_224 : X_MUX2
    port map (
      IA => XLXI_26_rx_clk_count_5_LOGIC_ONE,
      IB => XLXI_26_rx_clk_count_5_CYINIT,
      SEL => XLXI_26_rx_clk_count_inst_lut3_5,
      O => XLXI_26_rx_clk_count_inst_cy_26
    );
  XLXI_26_rx_clk_count_inst_sum_25_225 : X_XOR2
    port map (
      I0 => XLXI_26_rx_clk_count_5_CYINIT,
      I1 => XLXI_26_rx_clk_count_inst_lut3_5,
      O => XLXI_26_rx_clk_count_inst_sum_25
    );
  XLXI_26_rx_clk_count_inst_lut3_51 : X_LUT4
    generic map(
      INIT => X"470F"
    )
    port map (
      ADR0 => XLXI_26_rx_clk_div(5),
      ADR1 => CHOICE1039,
      ADR2 => XLXI_26_rx_clk_count(5),
      ADR3 => CHOICE1032,
      O => XLXI_26_rx_clk_count_inst_lut3_5
    );
  XLXI_26_rx_clk_count_inst_lut3_61 : X_LUT4
    generic map(
      INIT => X"207F"
    )
    port map (
      ADR0 => CHOICE1032,
      ADR1 => XLXI_26_rx_clk_div(6),
      ADR2 => CHOICE1039,
      ADR3 => XLXI_26_rx_clk_count(6),
      O => XLXI_26_rx_clk_count_inst_lut3_6
    );
  XLXI_26_rx_clk_count_5_COUTUSED : X_BUF
    port map (
      I => XLXI_26_rx_clk_count_5_CYMUXG,
      O => XLXI_26_rx_clk_count_inst_cy_27
    );
  XLXI_26_rx_clk_count_inst_cy_27_226 : X_MUX2
    port map (
      IA => XLXI_26_rx_clk_count_5_LOGIC_ONE,
      IB => XLXI_26_rx_clk_count_inst_cy_26,
      SEL => XLXI_26_rx_clk_count_inst_lut3_6,
      O => XLXI_26_rx_clk_count_5_CYMUXG
    );
  XLXI_26_rx_clk_count_inst_sum_26_227 : X_XOR2
    port map (
      I0 => XLXI_26_rx_clk_count_inst_cy_26,
      I1 => XLXI_26_rx_clk_count_inst_lut3_6,
      O => XLXI_26_rx_clk_count_inst_sum_26
    );
  XLXI_26_rx_clk_count_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_clk_count_5_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_clk_count_5_CYINIT_228 : X_BUF
    port map (
      I => XLXI_26_rx_clk_count_inst_cy_25,
      O => XLXI_26_rx_clk_count_5_CYINIT
    );
  XLXI_26_rx_clk_count_inst_sum_27_229 : X_XOR2
    port map (
      I0 => XLXI_26_rx_clk_count_7_CYINIT,
      I1 => XLXI_26_rx_clk_count_inst_lut3_7,
      O => XLXI_26_rx_clk_count_inst_sum_27
    );
  XLXI_26_rx_clk_count_inst_lut3_71 : X_LUT4
    generic map(
      INIT => X"270F"
    )
    port map (
      ADR0 => CHOICE1039,
      ADR1 => XLXI_26_rx_clk_div(7),
      ADR2 => XLXI_26_rx_clk_count(7),
      ADR3 => CHOICE1032,
      O => XLXI_26_rx_clk_count_inst_lut3_7
    );
  XLXI_26_rx_clk_count_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_clk_count_7_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_clk_count_7_CYINIT_230 : X_BUF
    port map (
      I => XLXI_26_rx_clk_count_inst_cy_27,
      O => XLXI_26_rx_clk_count_7_CYINIT
    );
  XLXI_26_n0058_1_LOGIC_ZERO_231 : X_ZERO
    port map (
      O => XLXI_26_n0058_1_LOGIC_ZERO
    );
  XLXI_26_Madd_n0058_inst_cy_16_232 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC1_0,
      IB => XLXI_26_n0058_1_LOGIC_ZERO,
      SEL => XLXI_26_Madd_n0058_inst_lut2_16,
      O => XLXI_26_Madd_n0058_inst_cy_16
    );
  XLXI_26_Madd_n0058_inst_lut2_161 : X_LUT4
    generic map(
      INIT => X"00FF"
    )
    port map (
      ADR0 => GLOBAL_LOGIC1_0,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_26_rx_bit_count(0),
      O => XLXI_26_Madd_n0058_inst_lut2_16
    );
  XLXI_26_n0058_1_G : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => GLOBAL_LOGIC0_1,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_26_rx_bit_count(1),
      O => XLXI_26_n0058_1_GROM
    );
  XLXI_26_n0058_1_COUTUSED : X_BUF
    port map (
      I => XLXI_26_n0058_1_CYMUXG,
      O => XLXI_26_Madd_n0058_inst_cy_17
    );
  XLXI_26_n0058_1_YUSED : X_BUF
    port map (
      I => XLXI_26_n0058_1_XORG,
      O => XLXI_26_n0058(1)
    );
  XLXI_26_Madd_n0058_inst_cy_17_233 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC0_1,
      IB => XLXI_26_Madd_n0058_inst_cy_16,
      SEL => XLXI_26_n0058_1_GROM,
      O => XLXI_26_n0058_1_CYMUXG
    );
  XLXI_26_Madd_n0058_inst_sum_17 : X_XOR2
    port map (
      I0 => XLXI_26_Madd_n0058_inst_cy_16,
      I1 => XLXI_26_n0058_1_GROM,
      O => XLXI_26_n0058_1_XORG
    );
  XLXI_26_n0058_2_LOGIC_ZERO_234 : X_ZERO
    port map (
      O => XLXI_26_n0058_2_LOGIC_ZERO
    );
  XLXI_26_Madd_n0058_inst_cy_18_235 : X_MUX2
    port map (
      IA => XLXI_26_n0058_2_LOGIC_ZERO,
      IB => XLXI_26_n0058_2_CYINIT,
      SEL => XLXI_26_n0058_2_FROM,
      O => XLXI_26_Madd_n0058_inst_cy_18
    );
  XLXI_26_Madd_n0058_inst_sum_18 : X_XOR2
    port map (
      I0 => XLXI_26_n0058_2_CYINIT,
      I1 => XLXI_26_n0058_2_FROM,
      O => XLXI_26_n0058_2_XORF
    );
  XLXI_26_n0058_2_F : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_26_rx_bit_count(2),
      O => XLXI_26_n0058_2_FROM
    );
  XLXI_26_rx_bit_count_3_rt_236 : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_26_rx_bit_count(3),
      O => XLXI_26_rx_bit_count_3_rt
    );
  XLXI_26_n0058_2_XUSED : X_BUF
    port map (
      I => XLXI_26_n0058_2_XORF,
      O => XLXI_26_n0058(2)
    );
  XLXI_26_n0058_2_YUSED : X_BUF
    port map (
      I => XLXI_26_n0058_2_XORG,
      O => XLXI_26_n0058(3)
    );
  XLXI_26_Madd_n0058_inst_sum_19 : X_XOR2
    port map (
      I0 => XLXI_26_Madd_n0058_inst_cy_18,
      I1 => XLXI_26_rx_bit_count_3_rt,
      O => XLXI_26_n0058_2_XORG
    );
  XLXI_26_n0058_2_CYINIT_237 : X_BUF
    port map (
      I => XLXI_26_Madd_n0058_inst_cy_17,
      O => XLXI_26_n0058_2_CYINIT
    );
  XLXI_26_n0059_1_LOGIC_ZERO_238 : X_ZERO
    port map (
      O => XLXI_26_n0059_1_LOGIC_ZERO
    );
  XLXI_26_Madd_n0059_inst_cy_16_239 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC1_1,
      IB => XLXI_26_n0059_1_LOGIC_ZERO,
      SEL => XLXI_26_Madd_n0059_inst_lut2_16,
      O => XLXI_26_Madd_n0059_inst_cy_16
    );
  XLXI_26_Madd_n0059_inst_lut2_161 : X_LUT4
    generic map(
      INIT => X"3333"
    )
    port map (
      ADR0 => GLOBAL_LOGIC1_1,
      ADR1 => XLXI_26_rx_8z_count(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_26_Madd_n0059_inst_lut2_16
    );
  XLXI_26_n0059_1_G : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => GLOBAL_LOGIC0_4,
      ADR1 => XLXI_26_rx_8z_count(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_26_n0059_1_GROM
    );
  XLXI_26_n0059_1_COUTUSED : X_BUF
    port map (
      I => XLXI_26_n0059_1_CYMUXG,
      O => XLXI_26_Madd_n0059_inst_cy_17
    );
  XLXI_26_n0059_1_YUSED : X_BUF
    port map (
      I => XLXI_26_n0059_1_XORG,
      O => XLXI_26_n0059(1)
    );
  XLXI_26_Madd_n0059_inst_cy_17_240 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC0_4,
      IB => XLXI_26_Madd_n0059_inst_cy_16,
      SEL => XLXI_26_n0059_1_GROM,
      O => XLXI_26_n0059_1_CYMUXG
    );
  XLXI_26_Madd_n0059_inst_sum_17 : X_XOR2
    port map (
      I0 => XLXI_26_Madd_n0059_inst_cy_16,
      I1 => XLXI_26_n0059_1_GROM,
      O => XLXI_26_n0059_1_XORG
    );
  XLXI_26_n0059_2_LOGIC_ZERO_241 : X_ZERO
    port map (
      O => XLXI_26_n0059_2_LOGIC_ZERO
    );
  XLXI_26_Madd_n0059_inst_cy_18_242 : X_MUX2
    port map (
      IA => XLXI_26_n0059_2_LOGIC_ZERO,
      IB => XLXI_26_n0059_2_CYINIT,
      SEL => XLXI_26_n0059_2_FROM,
      O => XLXI_26_Madd_n0059_inst_cy_18
    );
  XLXI_26_Madd_n0059_inst_sum_18 : X_XOR2
    port map (
      I0 => XLXI_26_n0059_2_CYINIT,
      I1 => XLXI_26_n0059_2_FROM,
      O => XLXI_26_n0059_2_XORF
    );
  XLXI_26_n0059_2_F : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_26_rx_8z_count(2),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_26_n0059_2_FROM
    );
  XLXI_26_rx_8z_count_3_rt_243 : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_26_rx_8z_count(3),
      ADR3 => VCC,
      O => XLXI_26_rx_8z_count_3_rt
    );
  XLXI_26_n0059_2_XUSED : X_BUF
    port map (
      I => XLXI_26_n0059_2_XORF,
      O => XLXI_26_n0059(2)
    );
  XLXI_26_n0059_2_YUSED : X_BUF
    port map (
      I => XLXI_26_n0059_2_XORG,
      O => XLXI_26_n0059(3)
    );
  XLXI_26_Madd_n0059_inst_sum_19 : X_XOR2
    port map (
      I0 => XLXI_26_Madd_n0059_inst_cy_18,
      I1 => XLXI_26_rx_8z_count_3_rt,
      O => XLXI_26_n0059_2_XORG
    );
  XLXI_26_n0059_2_CYINIT_244 : X_BUF
    port map (
      I => XLXI_26_Madd_n0059_inst_cy_17,
      O => XLXI_26_n0059_2_CYINIT
    );
  XLXI_1_I1_iaddr_x_6_33 : X_LUT4
    generic map(
      INIT => X"8AAA"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(2),
      ADR1 => XLXI_1_I1_stack_addrs_c_0_6,
      ADR2 => XLXI_1_pc_mux(1),
      ADR3 => XLXI_1_pc_mux(0),
      O => XLXI_1_I1_pc_6_FROM
    );
  XLXI_1_I1_iaddr_x_6_60 : X_LUT4
    generic map(
      INIT => X"F0D0"
    )
    port map (
      ADR0 => N43788,
      ADR1 => CHOICE2315,
      ADR2 => XLXI_1_I1_n0025,
      ADR3 => XLXI_1_I1_iaddr_x_6_33_O,
      O => XLXI_1_I1_pc_6_GROM
    );
  XLXI_1_I1_pc_6_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_6_FROM,
      O => XLXI_1_I1_iaddr_x_6_33_O
    );
  XLXI_1_I1_pc_6_YUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_6_GROM,
      O => IADDR(6)
    );
  XLXI_1_I1_pc_6_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I1_pc_6_SRMUX_OUTPUTNOT
    );
  XLXI_1_I1_iaddr_x_7_33 : X_LUT4
    generic map(
      INIT => X"D0F0"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(1),
      ADR1 => XLXI_1_I1_stack_addrs_c_0_7,
      ADR2 => XLXI_1_pc_mux(2),
      ADR3 => XLXI_1_pc_mux(0),
      O => XLXI_1_I1_pc_7_FROM
    );
  XLXI_1_I1_iaddr_x_7_60 : X_LUT4
    generic map(
      INIT => X"CCC4"
    )
    port map (
      ADR0 => N43784,
      ADR1 => XLXI_1_I1_n0025,
      ADR2 => CHOICE2298,
      ADR3 => XLXI_1_I1_iaddr_x_7_33_O,
      O => XLXI_1_I1_pc_7_GROM
    );
  XLXI_1_I1_pc_7_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_7_FROM,
      O => XLXI_1_I1_iaddr_x_7_33_O
    );
  XLXI_1_I1_pc_7_YUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_7_GROM,
      O => IADDR(7)
    );
  XLXI_1_I1_pc_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I1_pc_7_SRMUX_OUTPUTNOT
    );
  XLXI_1_I2_Ker189941 : X_LUT4
    generic map(
      INIT => X"0FFF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_1_I2_nreset_v(1),
      ADR3 => NRESET_BUFGP,
      O => XLXI_1_I2_N18996_FROM
    );
  XLXI_1_I4_Ker216591_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      ADR0 => IDATA(3),
      ADR1 => IDATA(0),
      ADR2 => XLXI_1_skip,
      ADR3 => XLXI_1_I2_N18996,
      O => XLXI_1_I2_N18996_GROM
    );
  XLXI_1_I2_N18996_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_N18996_FROM,
      O => XLXI_1_I2_N18996
    );
  XLXI_1_I2_N18996_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_N18996_GROM,
      O => N43480
    );
  XLXI_1_I1_iaddr_x_8_33 : X_LUT4
    generic map(
      INIT => X"D0F0"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(0),
      ADR1 => XLXI_1_I1_stack_addrs_c_0_8,
      ADR2 => XLXI_1_pc_mux(2),
      ADR3 => XLXI_1_pc_mux(1),
      O => XLXI_1_I1_pc_8_FROM
    );
  XLXI_1_I1_iaddr_x_8_60 : X_LUT4
    generic map(
      INIT => X"CC8C"
    )
    port map (
      ADR0 => CHOICE2281,
      ADR1 => XLXI_1_I1_n0025,
      ADR2 => N43792,
      ADR3 => XLXI_1_I1_iaddr_x_8_33_O,
      O => XLXI_1_I1_pc_8_GROM
    );
  XLXI_1_I1_pc_8_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_8_FROM,
      O => XLXI_1_I1_iaddr_x_8_33_O
    );
  XLXI_1_I1_pc_8_YUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_8_GROM,
      O => IADDR(8)
    );
  XLXI_1_I1_pc_8_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I1_pc_8_SRMUX_OUTPUTNOT
    );
  XLXI_1_I1_iaddr_x_9_33 : X_LUT4
    generic map(
      INIT => X"A2AA"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(2),
      ADR1 => XLXI_1_pc_mux(1),
      ADR2 => XLXI_1_I1_stack_addrs_c_0_9,
      ADR3 => XLXI_1_pc_mux(0),
      O => XLXI_1_I1_pc_9_FROM
    );
  XLXI_1_I1_iaddr_x_9_60 : X_LUT4
    generic map(
      INIT => X"AAA2"
    )
    port map (
      ADR0 => XLXI_1_I1_n0025,
      ADR1 => N43800,
      ADR2 => CHOICE2264,
      ADR3 => XLXI_1_I1_iaddr_x_9_33_O,
      O => XLXI_1_I1_pc_9_GROM
    );
  XLXI_1_I1_pc_9_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_9_FROM,
      O => XLXI_1_I1_iaddr_x_9_33_O
    );
  XLXI_1_I1_pc_9_YUSED : X_BUF
    port map (
      I => XLXI_1_I1_pc_9_GROM,
      O => IADDR(9)
    );
  XLXI_1_I1_pc_9_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I1_pc_9_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_skip_l62 : X_LUT4
    generic map(
      INIT => X"0400"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c(1),
      ADR1 => XLXI_1_I3_acc_c_0_8,
      ADR2 => XLXI_1_I2_TD_c(2),
      ADR3 => XLXI_1_I2_TD_c(0),
      O => XLXI_1_I3_skip_l62_O_FROM
    );
  XLXI_1_I3_skip_l86_SW0 : X_LUT4
    generic map(
      INIT => X"E4A0"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c(2),
      ADR1 => XLXI_1_I2_TD_c(3),
      ADR2 => XLXI_1_I3_skip_i,
      ADR3 => XLXI_1_I3_skip_l62_O,
      O => XLXI_1_I3_skip_l62_O_GROM
    );
  XLXI_1_I3_skip_l62_O_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_skip_l62_O_FROM,
      O => XLXI_1_I3_skip_l62_O
    );
  XLXI_1_I3_skip_l62_O_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_skip_l62_O_GROM,
      O => N43126
    );
  XLXI_1_I3_skip_l86_SW1_SW0 : X_LUT4
    generic map(
      INIT => X"AA8A"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c(0),
      ADR1 => XLXI_1_I2_TD_c(2),
      ADR2 => XLXI_1_I3_acc_c_0_8,
      ADR3 => XLXI_1_I2_TD_c(1),
      O => XLXI_1_I3_skip_l86_SW1_SW0_O_FROM
    );
  XLXI_1_I3_skip_l86_SW1 : X_LUT4
    generic map(
      INIT => X"A0E4"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c(2),
      ADR1 => XLXI_1_I2_TD_c(3),
      ADR2 => XLXI_1_I3_skip_i,
      ADR3 => XLXI_1_I3_skip_l86_SW1_SW0_O,
      O => XLXI_1_I3_skip_l86_SW1_SW0_O_GROM
    );
  XLXI_1_I3_skip_l86_SW1_SW0_O_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_skip_l86_SW1_SW0_O_FROM,
      O => XLXI_1_I3_skip_l86_SW1_SW0_O
    );
  XLXI_1_I3_skip_l86_SW1_SW0_O_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_skip_l86_SW1_SW0_O_GROM,
      O => N43128
    );
  XLXI_1_I2_ndre_x1_1_245 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => N43080,
      ADR1 => IDATA(3),
      ADR2 => XLXI_1_skip,
      ADR3 => XLXI_1_I2_C_raw,
      O => XLXI_1_I2_ndre_x1_1_FROM
    );
  XLXI_1_I5_Mmux_daddr_out_Result_3_1 : X_LUT4
    generic map(
      INIT => X"AAB8"
    )
    port map (
      ADR0 => XLXI_1_I5_daddr_c(3),
      ADR1 => XLXI_1_I4_Ker217601_1,
      ADR2 => XLXI_1_adaddr_out(3),
      ADR3 => XLXI_1_I2_ndre_x1_1,
      O => XLXI_1_I2_ndre_x1_1_GROM
    );
  XLXI_1_I2_ndre_x1_1_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_ndre_x1_1_FROM,
      O => XLXI_1_I2_ndre_x1_1
    );
  XLXI_1_I2_ndre_x1_1_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_ndre_x1_1_GROM,
      O => CPU_ADDR_OUT(3)
    );
  XLXI_1_I4_daddr_x_4_1 : X_LUT4
    generic map(
      INIT => X"8C80"
    )
    port map (
      ADR0 => IDATA(8),
      ADR1 => XLXI_1_I4_n0037,
      ADR2 => XLXI_1_I4_N21661,
      ADR3 => XLXI_1_I4_ireg_c(4),
      O => XLXI_1_I5_daddr_c_4_FROM
    );
  XLXI_1_I5_Mmux_daddr_out_Result_4_1 : X_LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      ADR0 => XLXI_1_I5_daddr_c(4),
      ADR1 => XLXI_1_ndre_int,
      ADR2 => XLXI_1_I4_N21762,
      ADR3 => XLXI_1_adaddr_out(4),
      O => XLXI_1_I5_daddr_c_4_GROM
    );
  XLXI_1_I5_daddr_c_4_XUSED : X_BUF
    port map (
      I => XLXI_1_I5_daddr_c_4_FROM,
      O => XLXI_1_adaddr_out(4)
    );
  XLXI_1_I5_daddr_c_4_YUSED : X_BUF
    port map (
      I => XLXI_1_I5_daddr_c_4_GROM,
      O => CPU_ADDR_OUT(4)
    );
  XLXI_1_I5_daddr_c_4_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I5_daddr_c_4_SRMUX_OUTPUTNOT
    );
  XLXI_3_out_1reg_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => OUT1_REG_2_OD,
      CE => XLXI_3_n0002,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => OUT1_REG_2_OFF_RST,
      O => XLXI_3_out_1reg(2)
    );
  OUT1_REG_2_OFF_RSTOR : X_OR2
    port map (
      I0 => OUT1_REG_2_SRMUXNOT,
      I1 => GSR,
      O => OUT1_REG_2_OFF_RST
    );
  XLXI_6_n00231 : X_LUT4
    generic map(
      INIT => X"0005"
    )
    port map (
      ADR0 => XLXI_1_I5_ndwe_c,
      ADR1 => VCC,
      ADR2 => nCS_UART,
      ADR3 => CPU_ADDR_OUT(0),
      O => XLXI_6_tx_uart_busy_FROM
    );
  XLXI_6_n00601 : X_LUT4
    generic map(
      INIT => X"FF20"
    )
    port map (
      ADR0 => XLXI_6_n0028,
      ADR1 => XLXI_6_tx_s(0),
      ADR2 => XLXI_6_tx_uart_busy,
      ADR3 => XLXI_6_n0023,
      O => XLXI_6_tx_uart_busy_GROM
    );
  XLXI_6_tx_uart_busy_XUSED : X_BUF
    port map (
      I => XLXI_6_tx_uart_busy_FROM,
      O => XLXI_6_n0023
    );
  XLXI_6_tx_uart_busy_YUSED : X_BUF
    port map (
      I => XLXI_6_tx_uart_busy_GROM,
      O => XLXI_6_n00601_O
    );
  XLXI_6_tx_uart_busy_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_uart_busy_SRMUX_OUTPUTNOT
    );
  XLXI_55_Ker165061 : X_LUT4
    generic map(
      INIT => X"0C00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CPU_ADDR_OUT(8),
      ADR2 => CPU_ADDR_OUT(4),
      ADR3 => NRESET_BUFGP,
      O => XLXI_55_mux_c_1_FROM
    );
  XLXI_55_mux_x_1_1 : X_LUT4
    generic map(
      INIT => X"0C00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CPU_ADDR_OUT(2),
      ADR2 => CPU_ADDR_OUT(3),
      ADR3 => XLXI_55_N16508,
      O => XLXI_55_mux_x_1_1_O
    );
  XLXI_55_mux_c_1_XUSED : X_BUF
    port map (
      I => XLXI_55_mux_c_1_FROM,
      O => XLXI_55_N16508
    );
  XLXI_55_mux_c_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_55_mux_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I5_Mmux_daddr_out_Result_0_1_1_246 : X_LUT4
    generic map(
      INIT => X"CCCA"
    )
    port map (
      ADR0 => XLXI_1_adaddr_out(0),
      ADR1 => XLXI_1_I5_daddr_c(0),
      ADR2 => XLXI_1_ndre_int,
      ADR3 => XLXI_1_I4_N21762,
      O => XLXI_1_I5_Mmux_daddr_out_Result_0_1_1_FROM
    );
  XLXI_3_n00021 : X_LUT4
    generic map(
      INIT => X"0300"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I5_ndwe_c,
      ADR2 => nCS_REG,
      ADR3 => XLXI_1_I5_Mmux_daddr_out_Result_0_1_1,
      O => XLXI_1_I5_Mmux_daddr_out_Result_0_1_1_GROM
    );
  XLXI_1_I5_Mmux_daddr_out_Result_0_1_1_XUSED : X_BUF
    port map (
      I => XLXI_1_I5_Mmux_daddr_out_Result_0_1_1_FROM,
      O => XLXI_1_I5_Mmux_daddr_out_Result_0_1_1
    );
  XLXI_1_I5_Mmux_daddr_out_Result_0_1_1_YUSED : X_BUF
    port map (
      I => XLXI_1_I5_Mmux_daddr_out_Result_0_1_1_GROM,
      O => XLXI_3_n0002
    );
  XLXI_55_nCS_REG_SW10_SW1 : X_LUT4
    generic map(
      INIT => X"FFCD"
    )
    port map (
      ADR0 => XLXI_1_I4_N21762,
      ADR1 => XLXI_1_I5_daddr_c(2),
      ADR2 => XLXI_1_ndre_int,
      ADR3 => XLXI_1_I5_daddr_c(4),
      O => XLXI_55_nCS_REG_SW10_SW1_O_FROM
    );
  XLXI_55_nCS_REG_SW10 : X_LUT4
    generic map(
      INIT => X"FE04"
    )
    port map (
      ADR0 => N43238,
      ADR1 => N43468,
      ADR2 => XLXI_1_adaddr_out(4),
      ADR3 => XLXI_55_nCS_REG_SW10_SW1_O,
      O => XLXI_55_nCS_REG_SW10_SW1_O_GROM
    );
  XLXI_55_nCS_REG_SW10_SW1_O_XUSED : X_BUF
    port map (
      I => XLXI_55_nCS_REG_SW10_SW1_O_FROM,
      O => XLXI_55_nCS_REG_SW10_SW1_O
    );
  XLXI_55_nCS_REG_SW10_SW1_O_YUSED : X_BUF
    port map (
      I => XLXI_55_nCS_REG_SW10_SW1_O_GROM,
      O => CHOICE764
    );
  XLXI_55_nCS_REG_SW114 : X_LUT4
    generic map(
      INIT => X"DFFF"
    )
    port map (
      ADR0 => CPU_ADDR_OUT(3),
      ADR1 => CHOICE764,
      ADR2 => CPU_ADDR_OUT(8),
      ADR3 => NRESET_BUFGP,
      O => nCS_REG_FROM
    );
  XLXI_3_n00061 : X_LUT4
    generic map(
      INIT => X"0005"
    )
    port map (
      ADR0 => XLXI_1_I5_Mmux_daddr_out_Result_0_1_1,
      ADR1 => VCC,
      ADR2 => XLXI_1_I5_ndwe_c,
      ADR3 => nCS_REG,
      O => nCS_REG_GROM
    );
  nCS_REG_XUSED : X_BUF
    port map (
      I => nCS_REG_FROM,
      O => nCS_REG
    );
  nCS_REG_YUSED : X_BUF
    port map (
      I => nCS_REG_GROM,
      O => XLXI_3_n0006
    );
  XLXI_1_I3_Mmux_data_x_Result_2_99 : X_LUT4
    generic map(
      INIT => X"4040"
    )
    port map (
      ADR0 => XLXI_1_I2_ndre_x1_1,
      ADR1 => XLXI_1_I4_N21894,
      ADR2 => CHOICE2850,
      ADR3 => VCC,
      O => CHOICE2853_FROM
    );
  XLXI_1_I3_Msub_n0066_inst_lut2_401 : X_LUT4
    generic map(
      INIT => X"CCCA"
    )
    port map (
      ADR0 => N43154,
      ADR1 => N43156,
      ADR2 => CHOICE2843,
      ADR3 => CHOICE2853,
      O => CHOICE2853_GROM
    );
  CHOICE2853_XUSED : X_BUF
    port map (
      I => CHOICE2853_FROM,
      O => CHOICE2853
    );
  CHOICE2853_YUSED : X_BUF
    port map (
      I => CHOICE2853_GROM,
      O => XLXI_1_I3_Msub_n0066_inst_lut2_40
    );
  XLXI_1_I3_Mmux_data_x_Result_1_140 : X_LUT4
    generic map(
      INIT => X"FEAA"
    )
    port map (
      ADR0 => CHOICE2890,
      ADR1 => CHOICE2917,
      ADR2 => CHOICE2907,
      ADR3 => CHOICE2920,
      O => XLXI_1_I3_data_x_1_FROM
    );
  XLXI_1_I3_n0115_1_12 : X_LUT4
    generic map(
      INIT => X"FAFC"
    )
    port map (
      ADR0 => XLXI_1_I3_n0063,
      ADR1 => XLXI_1_I3_n0058,
      ADR2 => XLXI_1_I3_N20052,
      ADR3 => XLXI_1_I3_data_x(1),
      O => XLXI_1_I3_data_x_1_GROM
    );
  XLXI_1_I3_data_x_1_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_data_x_1_FROM,
      O => XLXI_1_I3_data_x(1)
    );
  XLXI_1_I3_data_x_1_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_data_x_1_GROM,
      O => CHOICE2511
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_301 : X_LUT4
    generic map(
      INIT => X"0E1F"
    )
    port map (
      ADR0 => CHOICE2996,
      ADR1 => CHOICE2986,
      ADR2 => N43186,
      ADR3 => N43142,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_30_FROM
    );
  XLXI_1_I3_n0115_0_53 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_1_I3_data_x(0),
      ADR1 => XLXI_1_I3_n0059,
      ADR2 => CHOICE2442,
      ADR3 => XLXI_1_I3_Madd_n0074_inst_lut2_30,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_30_GROM
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_30_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_Madd_n0074_inst_lut2_30_FROM,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_30
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_30_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_Madd_n0074_inst_lut2_30_GROM,
      O => CHOICE2445
    );
  XLXI_1_I3_Mmux_data_x_Result_3_99 : X_LUT4
    generic map(
      INIT => X"4400"
    )
    port map (
      ADR0 => XLXI_1_I2_ndre_x1_1,
      ADR1 => CHOICE2786,
      ADR2 => VCC,
      ADR3 => XLXI_1_I4_N21894,
      O => CHOICE2789_FROM
    );
  XLXI_1_I3_Msub_n0066_inst_lut2_411 : X_LUT4
    generic map(
      INIT => X"F0E4"
    )
    port map (
      ADR0 => CHOICE2779,
      ADR1 => N43160,
      ADR2 => N43162,
      ADR3 => CHOICE2789,
      O => CHOICE2789_GROM
    );
  CHOICE2789_XUSED : X_BUF
    port map (
      I => CHOICE2789_FROM,
      O => CHOICE2789
    );
  CHOICE2789_YUSED : X_BUF
    port map (
      I => CHOICE2789_GROM,
      O => XLXI_1_I3_Msub_n0066_inst_lut2_41
    );
  XLXI_1_I3_Mmux_data_x_Result_4_99 : X_LUT4
    generic map(
      INIT => X"4400"
    )
    port map (
      ADR0 => XLXI_1_I2_ndre_x1_1,
      ADR1 => CHOICE2689,
      ADR2 => VCC,
      ADR3 => XLXI_1_I4_N21894,
      O => CHOICE2692_FROM
    );
  XLXI_1_I3_Msub_n0066_inst_lut2_421 : X_LUT4
    generic map(
      INIT => X"F0E4"
    )
    port map (
      ADR0 => CHOICE2682,
      ADR1 => N43166,
      ADR2 => N43168,
      ADR3 => CHOICE2692,
      O => CHOICE2692_GROM
    );
  CHOICE2692_XUSED : X_BUF
    port map (
      I => CHOICE2692_FROM,
      O => CHOICE2692
    );
  CHOICE2692_YUSED : X_BUF
    port map (
      I => CHOICE2692_GROM,
      O => XLXI_1_I3_Msub_n0066_inst_lut2_42
    );
  XLXI_1_I3_Mmux_data_x_Result_5_99 : X_LUT4
    generic map(
      INIT => X"0088"
    )
    port map (
      ADR0 => CHOICE2625,
      ADR1 => XLXI_1_I4_N21894,
      ADR2 => VCC,
      ADR3 => XLXI_1_I2_ndre_x1_1,
      O => CHOICE2628_FROM
    );
  XLXI_1_I3_Msub_n0066_inst_lut2_431 : X_LUT4
    generic map(
      INIT => X"AAAC"
    )
    port map (
      ADR0 => N43174,
      ADR1 => N43172,
      ADR2 => CHOICE2618,
      ADR3 => CHOICE2628,
      O => CHOICE2628_GROM
    );
  CHOICE2628_XUSED : X_BUF
    port map (
      I => CHOICE2628_FROM,
      O => CHOICE2628
    );
  CHOICE2628_YUSED : X_BUF
    port map (
      I => CHOICE2628_GROM,
      O => XLXI_1_I3_Msub_n0066_inst_lut2_43
    );
  XLXI_1_I3_Mmux_data_x_Result_6_99 : X_LUT4
    generic map(
      INIT => X"5000"
    )
    port map (
      ADR0 => XLXI_1_I2_ndre_x1_1,
      ADR1 => VCC,
      ADR2 => CHOICE2561,
      ADR3 => XLXI_1_I4_N21894,
      O => CHOICE2564_FROM
    );
  XLXI_1_I3_Msub_n0066_inst_lut2_441 : X_LUT4
    generic map(
      INIT => X"F0E2"
    )
    port map (
      ADR0 => N43220,
      ADR1 => CHOICE2554,
      ADR2 => N43180,
      ADR3 => CHOICE2564,
      O => CHOICE2564_GROM
    );
  CHOICE2564_XUSED : X_BUF
    port map (
      I => CHOICE2564_FROM,
      O => CHOICE2564
    );
  CHOICE2564_YUSED : X_BUF
    port map (
      I => CHOICE2564_GROM,
      O => XLXI_1_I3_Msub_n0066_inst_lut2_44
    );
  XLXI_3_out_1reg_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => OUT1_REG_5_OD,
      CE => XLXI_3_n0002,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => OUT1_REG_5_OFF_RST,
      O => XLXI_3_out_1reg(5)
    );
  OUT1_REG_5_OFF_RSTOR : X_OR2
    port map (
      I0 => OUT1_REG_5_SRMUXNOT,
      I1 => GSR,
      O => OUT1_REG_5_OFF_RST
    );
  XLXI_1_I3_Mmux_data_x_Result_2_140 : X_LUT4
    generic map(
      INIT => X"FFE0"
    )
    port map (
      ADR0 => CHOICE2853,
      ADR1 => CHOICE2843,
      ADR2 => CHOICE2856,
      ADR3 => CHOICE2826,
      O => XLXI_1_I3_data_x_2_FROM
    );
  XLXI_1_I3_n0115_2_12 : X_LUT4
    generic map(
      INIT => X"EEFC"
    )
    port map (
      ADR0 => XLXI_1_I3_n0063,
      ADR1 => XLXI_1_I3_N20052,
      ADR2 => XLXI_1_I3_n0058,
      ADR3 => XLXI_1_I3_data_x(2),
      O => XLXI_1_I3_data_x_2_GROM
    );
  XLXI_1_I3_data_x_2_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_data_x_2_FROM,
      O => XLXI_1_I3_data_x(2)
    );
  XLXI_1_I3_data_x_2_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_data_x_2_GROM,
      O => CHOICE2575
    );
  XLXI_1_I3_Mmux_data_x_Result_7_99 : X_LUT4
    generic map(
      INIT => X"4400"
    )
    port map (
      ADR0 => XLXI_1_I2_ndre_x1_1,
      ADR1 => XLXI_1_I4_N21894,
      ADR2 => VCC,
      ADR3 => CHOICE2497,
      O => CHOICE2500_FROM
    );
  XLXI_1_I3_Msub_n0066_inst_lut2_451 : X_LUT4
    generic map(
      INIT => X"F0E4"
    )
    port map (
      ADR0 => CHOICE2490,
      ADR1 => N43232,
      ADR2 => N43228,
      ADR3 => CHOICE2500,
      O => CHOICE2500_GROM
    );
  CHOICE2500_XUSED : X_BUF
    port map (
      I => CHOICE2500_FROM,
      O => CHOICE2500
    );
  CHOICE2500_YUSED : X_BUF
    port map (
      I => CHOICE2500_GROM,
      O => XLXI_1_I3_Msub_n0066_inst_lut2_45
    );
  XLXI_1_I3_n0115_1_29 : X_LUT4
    generic map(
      INIT => X"F200"
    )
    port map (
      ADR0 => XLXI_1_I3_n0058,
      ADR1 => XLXI_1_I3_acc_c_0_1,
      ADR2 => XLXI_1_I3_N20010,
      ADR3 => XLXI_1_I3_data_x(1),
      O => XLXI_1_I3_n0115_1_29_O_FROM
    );
  XLXI_1_I3_n0115_1_39 : X_LUT4
    generic map(
      INIT => X"FFEA"
    )
    port map (
      ADR0 => CHOICE2513,
      ADR1 => XLXI_1_I3_n0074(1),
      ADR2 => XLXI_1_I3_n0059,
      ADR3 => XLXI_1_I3_n0115_1_29_O,
      O => XLXI_1_I3_n0115_1_29_O_GROM
    );
  XLXI_1_I3_n0115_1_29_O_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0115_1_29_O_FROM,
      O => XLXI_1_I3_n0115_1_29_O
    );
  XLXI_1_I3_n0115_1_29_O_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0115_1_29_O_GROM,
      O => CHOICE2520
    );
  XLXI_1_I3_Mmux_data_x_Result_0_59_SW0 : X_LUT4
    generic map(
      INIT => X"F0E4"
    )
    port map (
      ADR0 => N44559,
      ADR1 => N43142,
      ADR2 => N43144,
      ADR3 => CHOICE2996,
      O => XLXI_1_I3_Mmux_data_x_Result_0_59_SW0_O_FROM
    );
  XLXI_1_I3_Msub_n0066_inst_lut2_381 : X_LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      ADR0 => REG_DATA_OUT(0),
      ADR1 => N43422,
      ADR2 => XLXI_55_mux_c(2),
      ADR3 => XLXI_1_I3_Mmux_data_x_Result_0_59_SW0_O,
      O => XLXI_1_I3_Mmux_data_x_Result_0_59_SW0_O_GROM
    );
  XLXI_1_I3_Mmux_data_x_Result_0_59_SW0_O_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_Mmux_data_x_Result_0_59_SW0_O_FROM,
      O => XLXI_1_I3_Mmux_data_x_Result_0_59_SW0_O
    );
  XLXI_1_I3_Mmux_data_x_Result_0_59_SW0_O_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_Mmux_data_x_Result_0_59_SW0_O_GROM,
      O => XLXI_1_I3_Msub_n0066_inst_lut2_38
    );
  XLXI_1_I3_Mmux_data_x_Result_1_59_SW1 : X_LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      ADR0 => N43150,
      ADR1 => XLXI_1_I4_N21650,
      ADR2 => CHOICE2917,
      ADR3 => N43148,
      O => XLXI_1_I3_Mmux_data_x_Result_1_59_SW1_O_FROM
    );
  XLXI_1_I3_Msub_n0066_inst_lut2_391 : X_LUT4
    generic map(
      INIT => X"EC4C"
    )
    port map (
      ADR0 => REG_DATA_OUT(1),
      ADR1 => N43453,
      ADR2 => XLXI_55_mux_c(2),
      ADR3 => XLXI_1_I3_Mmux_data_x_Result_1_59_SW1_O,
      O => XLXI_1_I3_Mmux_data_x_Result_1_59_SW1_O_GROM
    );
  XLXI_1_I3_Mmux_data_x_Result_1_59_SW1_O_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_Mmux_data_x_Result_1_59_SW1_O_FROM,
      O => XLXI_1_I3_Mmux_data_x_Result_1_59_SW1_O
    );
  XLXI_1_I3_Mmux_data_x_Result_1_59_SW1_O_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_Mmux_data_x_Result_1_59_SW1_O_GROM,
      O => XLXI_1_I3_Msub_n0066_inst_lut2_39
    );
  XLXI_1_I3_Mmux_data_x_Result_3_140 : X_LUT4
    generic map(
      INIT => X"FCF8"
    )
    port map (
      ADR0 => CHOICE2779,
      ADR1 => CHOICE2631,
      ADR2 => CHOICE2762,
      ADR3 => CHOICE2789,
      O => XLXI_1_I3_data_x_3_FROM
    );
  XLXI_1_I3_n0115_3_12 : X_LUT4
    generic map(
      INIT => X"FCFA"
    )
    port map (
      ADR0 => XLXI_1_I3_n0058,
      ADR1 => XLXI_1_I3_n0063,
      ADR2 => XLXI_1_I3_N20052,
      ADR3 => XLXI_1_I3_data_x(3),
      O => XLXI_1_I3_data_x_3_GROM
    );
  XLXI_1_I3_data_x_3_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_data_x_3_FROM,
      O => XLXI_1_I3_data_x(3)
    );
  XLXI_1_I3_data_x_3_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_data_x_3_GROM,
      O => CHOICE2639
    );
  XLXI_1_I3_n0115_2_19 : X_LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      ADR0 => XLXI_1_I3_n0066(2),
      ADR1 => XLXI_1_I2_TD_c_2_1,
      ADR2 => XLXI_1_I2_TD_c_0_1,
      ADR3 => XLXI_1_I2_TD_c_1_1,
      O => XLXI_1_I3_n0115_2_19_O_FROM
    );
  XLXI_1_I3_n0115_2_39 : X_LUT4
    generic map(
      INIT => X"FFF8"
    )
    port map (
      ADR0 => XLXI_1_I3_n0059,
      ADR1 => XLXI_1_I3_n0074(2),
      ADR2 => CHOICE2581,
      ADR3 => XLXI_1_I3_n0115_2_19_O,
      O => XLXI_1_I3_n0115_2_19_O_GROM
    );
  XLXI_1_I3_n0115_2_19_O_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0115_2_19_O_FROM,
      O => XLXI_1_I3_n0115_2_19_O
    );
  XLXI_1_I3_n0115_2_19_O_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0115_2_19_O_GROM,
      O => CHOICE2584
    );
  XLXI_1_I3_n007212 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_0,
      ADR1 => XLXI_1_I3_acc_c_0_1,
      ADR2 => XLXI_1_I3_acc_c_0_3,
      ADR3 => XLXI_1_I3_acc_c_0_2,
      O => XLXI_1_I3_n007212_O_FROM
    );
  XLXI_1_I3_skip_l37 : X_LUT4
    generic map(
      INIT => X"5333"
    )
    port map (
      ADR0 => N43138,
      ADR1 => N43136,
      ADR2 => CHOICE2967,
      ADR3 => XLXI_1_I3_n007212_O,
      O => XLXI_1_I3_n007212_O_GROM
    );
  XLXI_1_I3_n007212_O_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n007212_O_FROM,
      O => XLXI_1_I3_n007212_O
    );
  XLXI_1_I3_n007212_O_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n007212_O_GROM,
      O => CHOICE3026
    );
  XLXI_1_I3_Mmux_data_x_Result_4_140 : X_LUT4
    generic map(
      INIT => X"FAF8"
    )
    port map (
      ADR0 => CHOICE2695,
      ADR1 => CHOICE2692,
      ADR2 => CHOICE2665,
      ADR3 => CHOICE2682,
      O => XLXI_1_I3_data_x_4_FROM
    );
  XLXI_1_I3_n0115_4_12 : X_LUT4
    generic map(
      INIT => X"FAEE"
    )
    port map (
      ADR0 => XLXI_1_I3_N20052,
      ADR1 => XLXI_1_I3_n0058,
      ADR2 => XLXI_1_I3_n0063,
      ADR3 => XLXI_1_I3_data_x(4),
      O => XLXI_1_I3_data_x_4_GROM
    );
  XLXI_1_I3_data_x_4_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_data_x_4_FROM,
      O => XLXI_1_I3_data_x(4)
    );
  XLXI_1_I3_data_x_4_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_data_x_4_GROM,
      O => CHOICE2736
    );
  XLXI_1_I3_Mmux_data_x_Result_5_140 : X_LUT4
    generic map(
      INIT => X"FECC"
    )
    port map (
      ADR0 => CHOICE2618,
      ADR1 => CHOICE2601,
      ADR2 => CHOICE2628,
      ADR3 => CHOICE2631,
      O => XLXI_1_I3_data_x_5_FROM
    );
  XLXI_1_I3_n0115_5_12 : X_LUT4
    generic map(
      INIT => X"EFEC"
    )
    port map (
      ADR0 => XLXI_1_I3_n0063,
      ADR1 => XLXI_1_I3_N20052,
      ADR2 => XLXI_1_I3_data_x(5),
      ADR3 => XLXI_1_I3_n0058,
      O => XLXI_1_I3_data_x_5_GROM
    );
  XLXI_1_I3_data_x_5_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_data_x_5_FROM,
      O => XLXI_1_I3_data_x(5)
    );
  XLXI_1_I3_data_x_5_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_data_x_5_GROM,
      O => CHOICE2800
    );
  XLXI_1_I3_Mmux_data_x_Result_6_140 : X_LUT4
    generic map(
      INIT => X"FAF8"
    )
    port map (
      ADR0 => CHOICE2567,
      ADR1 => CHOICE2554,
      ADR2 => CHOICE2537,
      ADR3 => CHOICE2564,
      O => XLXI_1_I3_data_x_6_FROM
    );
  XLXI_1_I3_n0115_6_12 : X_LUT4
    generic map(
      INIT => X"FAEE"
    )
    port map (
      ADR0 => XLXI_1_I3_N20052,
      ADR1 => XLXI_1_I3_n0058,
      ADR2 => XLXI_1_I3_n0063,
      ADR3 => XLXI_1_I3_data_x(6),
      O => XLXI_1_I3_data_x_6_GROM
    );
  XLXI_1_I3_data_x_6_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_data_x_6_FROM,
      O => XLXI_1_I3_data_x(6)
    );
  XLXI_1_I3_data_x_6_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_data_x_6_GROM,
      O => CHOICE2864
    );
  XLXI_1_I3_Mmux_data_x_Result_7_140 : X_LUT4
    generic map(
      INIT => X"FEF0"
    )
    port map (
      ADR0 => CHOICE2490,
      ADR1 => CHOICE2500,
      ADR2 => CHOICE2473,
      ADR3 => CHOICE2631,
      O => XLXI_1_I3_data_x_7_FROM
    );
  XLXI_1_I3_n0115_7_12 : X_LUT4
    generic map(
      INIT => X"FAFC"
    )
    port map (
      ADR0 => XLXI_1_I3_n0063,
      ADR1 => XLXI_1_I3_n0058,
      ADR2 => XLXI_1_I3_N20052,
      ADR3 => XLXI_1_I3_data_x(7),
      O => XLXI_1_I3_data_x_7_GROM
    );
  XLXI_1_I3_data_x_7_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_data_x_7_FROM,
      O => XLXI_1_I3_data_x(7)
    );
  XLXI_1_I3_data_x_7_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_data_x_7_GROM,
      O => CHOICE2928
    );
  XLXI_1_I3_Mmux_data_x_Result_0_99 : X_LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      ADR0 => N43439,
      ADR1 => CHOICE3059,
      ADR2 => N43378,
      ADR3 => N43080,
      O => CHOICE2996_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_0_59_SW1 : X_LUT4
    generic map(
      INIT => X"FE04"
    )
    port map (
      ADR0 => CHOICE2996,
      ADR1 => N43142,
      ADR2 => XLXI_1_I4_N21650,
      ADR3 => N43144,
      O => CHOICE2996_GROM
    );
  CHOICE2996_XUSED : X_BUF
    port map (
      I => CHOICE2996_FROM,
      O => CHOICE2996
    );
  CHOICE2996_YUSED : X_BUF
    port map (
      I => CHOICE2996_GROM,
      O => N43422
    );
  XLXI_4_n0003_1_1 : X_LUT4
    generic map(
      INIT => X"CFC0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_4_int_clr_c(1),
      ADR2 => XLXI_4_N13806,
      ADR3 => CPU_DATA_OUT(1),
      O => XLXI_4_n0003_1_1_O
    );
  XLXI_4_n0003_0_1 : X_LUT4
    generic map(
      INIT => X"FA0A"
    )
    port map (
      ADR0 => CPU_DATA_OUT(0),
      ADR1 => VCC,
      ADR2 => XLXI_4_N13806,
      ADR3 => XLXI_4_int_clr_c(0),
      O => XLXI_4_n0003_0_1_O
    );
  XLXI_4_int_clr_c_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_clr_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_4_n0003_3_1 : X_LUT4
    generic map(
      INIT => X"FC30"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_4_N13806,
      ADR2 => CPU_DATA_OUT(3),
      ADR3 => XLXI_4_int_clr_c(3),
      O => XLXI_4_n0003_3_1_O
    );
  XLXI_4_n0003_2_1 : X_LUT4
    generic map(
      INIT => X"F3C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_4_N13806,
      ADR2 => XLXI_4_int_clr_c(2),
      ADR3 => CPU_DATA_OUT(2),
      O => XLXI_4_n0003_2_1_O
    );
  XLXI_4_int_clr_c_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_clr_c_3_SRMUX_OUTPUTNOT
    );
  XLXI_4_n0003_5_1 : X_LUT4
    generic map(
      INIT => X"AACC"
    )
    port map (
      ADR0 => XLXI_4_int_clr_c(5),
      ADR1 => CPU_DATA_OUT(5),
      ADR2 => VCC,
      ADR3 => XLXI_4_N13806,
      O => XLXI_4_n0003_5_1_O
    );
  XLXI_4_n0003_4_1 : X_LUT4
    generic map(
      INIT => X"FC30"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_4_N13806,
      ADR2 => CPU_DATA_OUT(4),
      ADR3 => XLXI_4_int_clr_c(4),
      O => XLXI_4_n0003_4_1_O
    );
  XLXI_4_int_clr_c_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_clr_c_5_SRMUX_OUTPUTNOT
    );
  XLXI_4_n0003_7_1 : X_LUT4
    generic map(
      INIT => X"CFC0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_4_int_clr_c(7),
      ADR2 => XLXI_4_N13806,
      ADR3 => CPU_DATA_OUT(7),
      O => XLXI_4_n0003_7_1_O
    );
  XLXI_4_n0003_6_1 : X_LUT4
    generic map(
      INIT => X"FC0C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CPU_DATA_OUT(6),
      ADR2 => XLXI_4_N13806,
      ADR3 => XLXI_4_int_clr_c(6),
      O => XLXI_4_n0003_6_1_O
    );
  XLXI_4_int_clr_c_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_clr_c_7_SRMUX_OUTPUTNOT
    );
  XLXI_6_n0011_1_1 : X_LUT4
    generic map(
      INIT => X"4400"
    )
    port map (
      ADR0 => XLXI_6_n0021,
      ADR1 => XLXI_6_n0041(1),
      ADR2 => VCC,
      ADR3 => XLXI_6_tx_s(0),
      O => XLXI_6_n0011(1)
    );
  XLXI_6_n0011_0_1 : X_LUT4
    generic map(
      INIT => X"0A0A"
    )
    port map (
      ADR0 => XLXI_6_tx_s(0),
      ADR1 => VCC,
      ADR2 => XLXI_6_tx_16_count(0),
      ADR3 => VCC,
      O => XLXI_6_n0011(0)
    );
  XLXI_6_n0011_3_1 : X_LUT4
    generic map(
      INIT => X"00C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_6_n0041(3),
      ADR2 => XLXI_6_tx_s(0),
      ADR3 => XLXI_6_n0021,
      O => XLXI_6_n0011(3)
    );
  XLXI_6_n0011_2_1 : X_LUT4
    generic map(
      INIT => X"2200"
    )
    port map (
      ADR0 => XLXI_6_n0041(2),
      ADR1 => XLXI_6_n0021,
      ADR2 => VCC,
      ADR3 => XLXI_6_tx_s(0),
      O => XLXI_6_n0011(2)
    );
  XLXI_3_out_1reg_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => OUT1_REG_6_OD,
      CE => XLXI_3_n0002,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => OUT1_REG_6_OFF_RST,
      O => XLXI_3_out_1reg(6)
    );
  OUT1_REG_6_OFF_RSTOR : X_OR2
    port map (
      I0 => OUT1_REG_6_SRMUXNOT,
      I1 => GSR,
      O => OUT1_REG_6_OFF_RST
    );
  XLXI_1_I4_n0035_1_1 : X_LUT4
    generic map(
      INIT => X"CCA0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_1,
      ADR1 => XLXI_1_I4_iinc_i(1),
      ADR2 => XLXI_1_I4_iinc_we_c,
      ADR3 => XLXI_1_int_stop,
      O => XLXI_1_I4_n0035(1)
    );
  XLXI_1_I4_n0035_0_1 : X_LUT4
    generic map(
      INIT => X"B888"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_i(0),
      ADR1 => XLXI_1_int_stop,
      ADR2 => XLXI_1_I4_iinc_we_c,
      ADR3 => XLXI_1_I3_acc_c_0_0,
      O => XLXI_1_I4_n0035(0)
    );
  XLXI_1_I4_iinc_c_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I4_iinc_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_n0035_3_1 : X_LUT4
    generic map(
      INIT => X"F088"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_3,
      ADR1 => XLXI_1_I4_iinc_we_c,
      ADR2 => XLXI_1_I4_iinc_i(3),
      ADR3 => XLXI_1_int_stop,
      O => XLXI_1_I4_n0035(3)
    );
  XLXI_1_I4_n0035_2_1 : X_LUT4
    generic map(
      INIT => X"EA40"
    )
    port map (
      ADR0 => XLXI_1_int_stop,
      ADR1 => XLXI_1_I4_iinc_we_c,
      ADR2 => XLXI_1_I3_acc_c_0_2,
      ADR3 => XLXI_1_I4_iinc_i(2),
      O => XLXI_1_I4_n0035(2)
    );
  XLXI_1_I4_iinc_c_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I4_iinc_c_3_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_n0035_5_1 : X_LUT4
    generic map(
      INIT => X"F088"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_we_c,
      ADR1 => XLXI_1_I3_acc_c_0_5,
      ADR2 => XLXI_1_I4_iinc_i(5),
      ADR3 => XLXI_1_int_stop,
      O => XLXI_1_I4_n0035(5)
    );
  XLXI_1_I4_n0035_4_1 : X_LUT4
    generic map(
      INIT => X"AAC0"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_i(4),
      ADR1 => XLXI_1_I4_iinc_we_c,
      ADR2 => XLXI_1_I3_acc_c_0_4,
      ADR3 => XLXI_1_int_stop,
      O => XLXI_1_I4_n0035(4)
    );
  XLXI_1_I4_iinc_c_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I4_iinc_c_5_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_n0035_7_1 : X_LUT4
    generic map(
      INIT => X"E2C0"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_we_c,
      ADR1 => XLXI_1_int_stop,
      ADR2 => XLXI_1_I4_iinc_i(7),
      ADR3 => XLXI_1_I3_acc_c_0_7,
      O => XLXI_1_I4_n0035(7)
    );
  XLXI_1_I4_n0035_6_1 : X_LUT4
    generic map(
      INIT => X"CAC0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_6,
      ADR1 => XLXI_1_I4_iinc_i(6),
      ADR2 => XLXI_1_int_stop,
      ADR3 => XLXI_1_I4_iinc_we_c,
      O => XLXI_1_I4_n0035(6)
    );
  XLXI_1_I4_iinc_c_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I4_iinc_c_7_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_iinc_x_1_1 : X_LUT4
    generic map(
      INIT => X"CCA0"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_c(1),
      ADR1 => XLXI_1_I3_acc_c_0_1,
      ADR2 => XLXI_1_I4_n00371_1,
      ADR3 => XLXI_1_I4_iinc_we_c,
      O => XLXI_1_I4_iinc_x(1)
    );
  XLXI_1_I4_iinc_x_0_1 : X_LUT4
    generic map(
      INIT => X"AAC0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_0,
      ADR1 => XLXI_1_I4_iinc_c(0),
      ADR2 => XLXI_1_I4_n00371_1,
      ADR3 => XLXI_1_I4_iinc_we_c,
      O => XLXI_1_I4_iinc_x(0)
    );
  XLXI_26_Ker160881 : X_LUT4
    generic map(
      INIT => X"FAFE"
    )
    port map (
      ADR0 => XLXI_26_rx_s_FFd3,
      ADR1 => XLXI_26_rx_s_FFd2,
      ADR2 => XLXI_26_rx_s_FFd1,
      ADR3 => XLXI_26_n0024,
      O => XLXI_26_rx_s_FFd1_FROM
    );
  XLXI_26_rx_s_FFd1_In1 : X_LUT4
    generic map(
      INIT => X"ECCC"
    )
    port map (
      ADR0 => XLXI_26_rx_s_FFd2,
      ADR1 => XLXI_26_N16174,
      ADR2 => XLXI_26_n0024,
      ADR3 => XLXI_26_rx_bit_count(3),
      O => XLXI_26_rx_s_FFd1_In
    );
  XLXI_26_rx_s_FFd1_XUSED : X_BUF
    port map (
      I => XLXI_26_rx_s_FFd1_FROM,
      O => XLXI_26_N16090
    );
  XLXI_26_rx_s_FFd1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_s_FFd1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_iinc_i_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I4_iinc_i_3_FFY_RST
    );
  XLXI_1_I4_iinc_i_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_iinc_x(2),
      CE => XLXI_1_I4_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_iinc_i_3_FFY_RST,
      O => XLXI_1_I4_iinc_i(2)
    );
  XLXI_1_I4_iinc_x_3_1 : X_LUT4
    generic map(
      INIT => X"AAC0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_3,
      ADR1 => XLXI_1_I4_iinc_c(3),
      ADR2 => XLXI_1_I4_n00371_1,
      ADR3 => XLXI_1_I4_iinc_we_c,
      O => XLXI_1_I4_iinc_x(3)
    );
  XLXI_1_I4_iinc_x_2_1 : X_LUT4
    generic map(
      INIT => X"E2C0"
    )
    port map (
      ADR0 => XLXI_1_I4_n00371_1,
      ADR1 => XLXI_1_I4_iinc_we_c,
      ADR2 => XLXI_1_I3_acc_c_0_2,
      ADR3 => XLXI_1_I4_iinc_c(2),
      O => XLXI_1_I4_iinc_x(2)
    );
  XLXI_1_I4_iinc_x_5_1 : X_LUT4
    generic map(
      INIT => X"B888"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_5,
      ADR1 => XLXI_1_I4_iinc_we_c,
      ADR2 => XLXI_1_I4_iinc_c(5),
      ADR3 => XLXI_1_I4_n00371_1,
      O => XLXI_1_I4_iinc_x(5)
    );
  XLXI_1_I4_iinc_x_4_1 : X_LUT4
    generic map(
      INIT => X"EC20"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_c(4),
      ADR1 => XLXI_1_I4_iinc_we_c,
      ADR2 => XLXI_1_I4_n00371_1,
      ADR3 => XLXI_1_I3_acc_c_0_4,
      O => XLXI_1_I4_iinc_x(4)
    );
  XLXI_1_I3_Mmux_data_x_Result_7_140_SW1 : X_LUT4
    generic map(
      INIT => X"99C3"
    )
    port map (
      ADR0 => XLXI_1_I2_data_is_c(7),
      ADR1 => XLXI_1_I3_acc_c_0_7,
      ADR2 => XLXI_1_I4_n00371_1,
      ADR3 => XLXI_1_I3_n0025,
      O => XLXI_1_I4_iinc_i_7_FROM
    );
  XLXI_1_I4_iinc_x_7_1 : X_LUT4
    generic map(
      INIT => X"AAC0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_7,
      ADR1 => XLXI_1_I4_iinc_c(7),
      ADR2 => XLXI_1_I4_n00371_1,
      ADR3 => XLXI_1_I4_iinc_we_c,
      O => XLXI_1_I4_iinc_x(7)
    );
  XLXI_1_I4_iinc_i_7_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_iinc_i_7_FROM,
      O => N43228
    );
  XLXI_1_I1_n0014_1_1 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_6_1,
      ADR1 => XLXI_1_I1_n0039,
      ADR2 => XLXI_1_I1_n0038,
      ADR3 => XLXI_1_I1_stack_addrs_c_7_1,
      O => XLXI_1_I1_n0014(1)
    );
  XLXI_1_I1_n0014_0_1 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_1_I1_n0039,
      ADR1 => XLXI_1_I1_stack_addrs_c_6_0,
      ADR2 => XLXI_1_I1_stack_addrs_c_7_0,
      ADR3 => XLXI_1_I1_n0038,
      O => XLXI_1_I1_n0014(0)
    );
  XLXI_1_I1_n0014_3_1 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_1_I1_n0039,
      ADR1 => XLXI_1_I1_n0038,
      ADR2 => XLXI_1_I1_stack_addrs_c_7_3,
      ADR3 => XLXI_1_I1_stack_addrs_c_6_3,
      O => XLXI_1_I1_n0014(3)
    );
  XLXI_1_I1_n0014_2_1 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_7_2,
      ADR1 => XLXI_1_I1_stack_addrs_c_6_2,
      ADR2 => XLXI_1_I1_n0038,
      ADR3 => XLXI_1_I1_n0039,
      O => XLXI_1_I1_n0014(2)
    );
  XLXI_1_I1_n0014_5_1 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_1_I1_n0039,
      ADR1 => XLXI_1_I1_stack_addrs_c_7_5,
      ADR2 => XLXI_1_I1_n0038,
      ADR3 => XLXI_1_I1_stack_addrs_c_6_5,
      O => XLXI_1_I1_n0014(5)
    );
  XLXI_1_I1_n0014_4_1 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_1_I1_n0039,
      ADR1 => XLXI_1_I1_stack_addrs_c_6_4,
      ADR2 => XLXI_1_I1_n0038,
      ADR3 => XLXI_1_I1_stack_addrs_c_7_4,
      O => XLXI_1_I1_n0014(4)
    );
  XLXI_1_I1_n0014_7_1 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_1_I1_n0038,
      ADR1 => XLXI_1_I1_stack_addrs_c_6_7,
      ADR2 => XLXI_1_I1_n0039,
      ADR3 => XLXI_1_I1_stack_addrs_c_7_7,
      O => XLXI_1_I1_n0014(7)
    );
  XLXI_1_I1_n0014_6_1 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_7_6,
      ADR1 => XLXI_1_I1_stack_addrs_c_6_6,
      ADR2 => XLXI_1_I1_n0039,
      ADR3 => XLXI_1_I1_n0038,
      O => XLXI_1_I1_n0014(6)
    );
  XLXI_1_I1_n0014_8_1 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_1_I1_n0039,
      ADR1 => XLXI_1_I1_stack_addrs_c_7_8,
      ADR2 => XLXI_1_I1_stack_addrs_c_6_8,
      ADR3 => XLXI_1_I1_n0038,
      O => XLXI_1_I1_n0014(8)
    );
  XLXI_1_I4_data_ox_1_1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => XLXI_1_I4_nreset_v(1),
      ADR1 => XLXI_1_I3_acc_c_0_1,
      ADR2 => NRESET_BUFGP,
      ADR3 => VCC,
      O => XLXI_26_rx_clk_div_1_FROM
    );
  XLXI_1_I4_data_ox_0_1 : X_LUT4
    generic map(
      INIT => X"A000"
    )
    port map (
      ADR0 => NRESET_BUFGP,
      ADR1 => VCC,
      ADR2 => XLXI_1_I4_nreset_v(1),
      ADR3 => XLXI_1_I3_acc_c_0_0,
      O => XLXI_26_rx_clk_div_1_GROM
    );
  XLXI_26_rx_clk_div_1_XUSED : X_BUF
    port map (
      I => XLXI_26_rx_clk_div_1_FROM,
      O => CPU_DATA_OUT(1)
    );
  XLXI_26_rx_clk_div_1_YUSED : X_BUF
    port map (
      I => XLXI_26_rx_clk_div_1_GROM,
      O => CPU_DATA_OUT(0)
    );
  XLXI_26_rx_clk_div_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_clk_div_1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_data_ox_3_1 : X_LUT4
    generic map(
      INIT => X"8800"
    )
    port map (
      ADR0 => NRESET_BUFGP,
      ADR1 => XLXI_1_I4_nreset_v(1),
      ADR2 => VCC,
      ADR3 => XLXI_1_I3_acc_c_0_3,
      O => XLXI_26_rx_clk_div_3_FROM
    );
  XLXI_1_I4_data_ox_2_1 : X_LUT4
    generic map(
      INIT => X"8800"
    )
    port map (
      ADR0 => NRESET_BUFGP,
      ADR1 => XLXI_1_I4_nreset_v(1),
      ADR2 => VCC,
      ADR3 => XLXI_1_I3_acc_c_0_2,
      O => XLXI_26_rx_clk_div_3_GROM
    );
  XLXI_26_rx_clk_div_3_XUSED : X_BUF
    port map (
      I => XLXI_26_rx_clk_div_3_FROM,
      O => CPU_DATA_OUT(3)
    );
  XLXI_26_rx_clk_div_3_YUSED : X_BUF
    port map (
      I => XLXI_26_rx_clk_div_3_GROM,
      O => CPU_DATA_OUT(2)
    );
  XLXI_26_rx_clk_div_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_clk_div_3_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_data_ox_5_1 : X_LUT4
    generic map(
      INIT => X"C000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I4_nreset_v(1),
      ADR2 => XLXI_1_I3_acc_c_0_5,
      ADR3 => NRESET_BUFGP,
      O => XLXI_26_rx_clk_div_5_FROM
    );
  XLXI_1_I4_data_ox_4_1 : X_LUT4
    generic map(
      INIT => X"A000"
    )
    port map (
      ADR0 => XLXI_1_I4_nreset_v(1),
      ADR1 => VCC,
      ADR2 => XLXI_1_I3_acc_c_0_4,
      ADR3 => NRESET_BUFGP,
      O => XLXI_26_rx_clk_div_5_GROM
    );
  XLXI_26_rx_clk_div_5_XUSED : X_BUF
    port map (
      I => XLXI_26_rx_clk_div_5_FROM,
      O => CPU_DATA_OUT(5)
    );
  XLXI_26_rx_clk_div_5_YUSED : X_BUF
    port map (
      I => XLXI_26_rx_clk_div_5_GROM,
      O => CPU_DATA_OUT(4)
    );
  XLXI_26_rx_clk_div_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_clk_div_5_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_data_ox_7_1 : X_LUT4
    generic map(
      INIT => X"C000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I3_acc_c_0_7,
      ADR2 => XLXI_1_I4_nreset_v(1),
      ADR3 => NRESET_BUFGP,
      O => XLXI_26_rx_clk_div_7_FROM
    );
  XLXI_1_I4_data_ox_6_1 : X_LUT4
    generic map(
      INIT => X"A000"
    )
    port map (
      ADR0 => XLXI_1_I4_nreset_v(1),
      ADR1 => VCC,
      ADR2 => XLXI_1_I3_acc_c_0_6,
      ADR3 => NRESET_BUFGP,
      O => XLXI_26_rx_clk_div_7_GROM
    );
  XLXI_26_rx_clk_div_7_XUSED : X_BUF
    port map (
      I => XLXI_26_rx_clk_div_7_FROM,
      O => CPU_DATA_OUT(7)
    );
  XLXI_26_rx_clk_div_7_YUSED : X_BUF
    port map (
      I => XLXI_26_rx_clk_div_7_GROM,
      O => CPU_DATA_OUT(6)
    );
  XLXI_26_rx_clk_div_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_clk_div_7_SRMUX_OUTPUTNOT
    );
  XLXI_1_I2_TC_x_1_1 : X_LUT4
    generic map(
      INIT => X"A0E0"
    )
    port map (
      ADR0 => IDATA(3),
      ADR1 => IDATA(0),
      ADR2 => NRESET_BUFGP,
      ADR3 => XLXI_1_I2_N18884,
      O => XLXI_1_I2_TC_c_1_GROM
    );
  XLXI_1_I2_TC_c_1_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_TC_c_1_GROM,
      O => XLXI_1_I2_TC_x(1)
    );
  XLXI_1_I2_TC_c_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_TC_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_3_out_1reg_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => OUT1_REG_7_OD,
      CE => XLXI_3_n0002,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => OUT1_REG_7_OFF_RST,
      O => XLXI_3_out_1reg(7)
    );
  OUT1_REG_7_OFF_RSTOR : X_OR2
    port map (
      I0 => OUT1_REG_7_SRMUXNOT,
      I1 => GSR,
      O => OUT1_REG_7_OFF_RST
    );
  XLXI_26_n00331 : X_LUT4
    generic map(
      INIT => X"0010"
    )
    port map (
      ADR0 => XLXI_26_rx_8_count(1),
      ADR1 => N29718,
      ADR2 => XLXI_26_n0056,
      ADR3 => XLXI_26_rx_8_count(0),
      O => XLXI_26_rx_uart_full_s_FROM
    );
  XLXI_26_n00361 : X_LUT4
    generic map(
      INIT => X"0C00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_26_rx_uart_full_d,
      ADR2 => XLXI_26_n0026,
      ADR3 => XLXI_26_n0033,
      O => XLXI_26_n0036
    );
  XLXI_26_rx_uart_full_s_XUSED : X_BUF
    port map (
      I => XLXI_26_rx_uart_full_s_FROM,
      O => XLXI_26_n0033
    );
  XLXI_26_rx_uart_full_s_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_uart_full_s_SRMUX_OUTPUTNOT
    );
  XLXI_5_tmr_low_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_low_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_low_1_FFY_RST
    );
  XLXI_5_tmr_low_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n0004(0),
      CE => XLXI_5_n0030,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_low_1_FFY_RST,
      O => XLXI_5_tmr_low(0)
    );
  XLXI_5_n0004_1_1 : X_LUT4
    generic map(
      INIT => X"0C00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_5_n0017(1),
      ADR2 => XLXI_5_tmr_reset,
      ADR3 => XLXI_5_tmr_enable,
      O => XLXI_5_n0004(1)
    );
  XLXI_5_n0004_0_1 : X_LUT4
    generic map(
      INIT => X"0300"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_5_tmr_low(0),
      ADR2 => XLXI_5_tmr_reset,
      ADR3 => XLXI_5_tmr_enable,
      O => XLXI_5_n0004(0)
    );
  XLXI_5_tmr_low_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_5_tmr_low_1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_Mmux_n0034_Result_1_1 : X_LUT4
    generic map(
      INIT => X"EE44"
    )
    port map (
      ADR0 => XLXI_1_int_stop,
      ADR1 => XLXI_1_I4_ireg_x(1),
      ADR2 => VCC,
      ADR3 => XLXI_1_I4_ireg_i(1),
      O => XLXI_1_I4_n0034(1)
    );
  XLXI_1_I4_Mmux_n0034_Result_0_1 : X_LUT4
    generic map(
      INIT => X"E2E2"
    )
    port map (
      ADR0 => XLXI_1_I4_ireg_x(0),
      ADR1 => XLXI_1_int_stop,
      ADR2 => XLXI_1_I4_ireg_i(0),
      ADR3 => VCC,
      O => XLXI_1_I4_n0034(0)
    );
  XLXI_1_I4_ireg_c_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I4_ireg_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I2_int_stop_x1 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => XLXI_1_I2_N19016,
      ADR1 => NRESET_BUFGP,
      ADR2 => XLXI_1_I2_nreset_v(1),
      ADR3 => XLXI_1_I2_N18844,
      O => XLXI_1_I2_int_stop_c_FROM
    );
  XLXI_1_I4_Mmux_n0034_Result_5_1 : X_LUT4
    generic map(
      INIT => X"CCAA"
    )
    port map (
      ADR0 => XLXI_1_I4_ireg_x(5),
      ADR1 => XLXI_1_I4_ireg_i(5),
      ADR2 => VCC,
      ADR3 => XLXI_1_int_stop,
      O => XLXI_1_I4_n0034(5)
    );
  XLXI_1_I2_int_stop_c_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_int_stop_c_FROM,
      O => XLXI_1_int_stop
    );
  XLXI_1_I2_int_stop_c_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_int_stop_c_SRMUX_OUTPUTNOT
    );
  XLXI_5_n0004_3_1 : X_LUT4
    generic map(
      INIT => X"4040"
    )
    port map (
      ADR0 => XLXI_5_tmr_reset,
      ADR1 => XLXI_5_n0017(3),
      ADR2 => XLXI_5_tmr_enable,
      ADR3 => VCC,
      O => XLXI_5_n0004(3)
    );
  XLXI_5_n0004_2_1 : X_LUT4
    generic map(
      INIT => X"2020"
    )
    port map (
      ADR0 => XLXI_5_n0017(2),
      ADR1 => XLXI_5_tmr_reset,
      ADR2 => XLXI_5_tmr_enable,
      ADR3 => VCC,
      O => XLXI_5_n0004(2)
    );
  XLXI_5_tmr_low_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_5_tmr_low_3_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_Mmux_n0034_Result_3_1 : X_LUT4
    generic map(
      INIT => X"AFA0"
    )
    port map (
      ADR0 => XLXI_1_I4_ireg_i(3),
      ADR1 => VCC,
      ADR2 => XLXI_1_int_stop,
      ADR3 => XLXI_1_I4_ireg_x(3),
      O => XLXI_1_I4_n0034(3)
    );
  XLXI_1_I4_Mmux_n0034_Result_2_1 : X_LUT4
    generic map(
      INIT => X"CACA"
    )
    port map (
      ADR0 => XLXI_1_I4_ireg_x(2),
      ADR1 => XLXI_1_I4_ireg_i(2),
      ADR2 => XLXI_1_int_stop,
      ADR3 => VCC,
      O => XLXI_1_I4_n0034(2)
    );
  XLXI_1_I4_ireg_c_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I4_ireg_c_3_SRMUX_OUTPUTNOT
    );
  XLXI_5_n00311 : X_LUT4
    generic map(
      INIT => X"FFEC"
    )
    port map (
      ADR0 => XLXI_5_n0015,
      ADR1 => XLXI_5_N14552,
      ADR2 => XLXI_5_tmr_enable,
      ADR3 => XLXI_5_tmr_reset,
      O => XLXI_5_tmr_int_x_FROM
    );
  XLXI_5_n00191 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => CHOICE885,
      ADR1 => XLXI_5_tmr_reset,
      ADR2 => CHOICE892,
      ADR3 => XLXI_5_n0015,
      O => XLXI_5_n0019
    );
  XLXI_5_tmr_int_x_XUSED : X_BUF
    port map (
      I => XLXI_5_tmr_int_x_FROM,
      O => XLXI_5_n0031
    );
  XLXI_5_tmr_int_x_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_5_tmr_int_x_SRMUX_OUTPUTNOT
    );
  XLXI_5_n0004_5_1 : X_LUT4
    generic map(
      INIT => X"00C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_5_n0017(5),
      ADR2 => XLXI_5_tmr_enable,
      ADR3 => XLXI_5_tmr_reset,
      O => XLXI_5_n0004(5)
    );
  XLXI_5_n0004_4_1 : X_LUT4
    generic map(
      INIT => X"00A0"
    )
    port map (
      ADR0 => XLXI_5_n0017(4),
      ADR1 => VCC,
      ADR2 => XLXI_5_tmr_enable,
      ADR3 => XLXI_5_tmr_reset,
      O => XLXI_5_n0004(4)
    );
  XLXI_5_tmr_low_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_5_tmr_low_5_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_n00621 : X_LUT4
    generic map(
      INIT => X"FFF5"
    )
    port map (
      ADR0 => XLXI_1_I4_nreset_v(1),
      ADR1 => VCC,
      ADR2 => XLXI_1_I4_iinc_we_c,
      ADR3 => XLXI_1_int_stop,
      O => XLXI_1_I4_ireg_c_4_FROM
    );
  XLXI_1_I4_Mmux_n0034_Result_4_1 : X_LUT4
    generic map(
      INIT => X"CCAA"
    )
    port map (
      ADR0 => XLXI_1_I4_ireg_x(4),
      ADR1 => XLXI_1_I4_ireg_i(4),
      ADR2 => VCC,
      ADR3 => XLXI_1_int_stop,
      O => XLXI_1_I4_n0034(4)
    );
  XLXI_1_I4_ireg_c_4_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_ireg_c_4_FROM,
      O => XLXI_1_I4_n0062
    );
  XLXI_1_I4_ireg_c_4_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I4_ireg_c_4_SRMUX_OUTPUTNOT
    );
  XLXI_5_n0004_7_1 : X_LUT4
    generic map(
      INIT => X"4040"
    )
    port map (
      ADR0 => XLXI_5_tmr_reset,
      ADR1 => XLXI_5_n0017(7),
      ADR2 => XLXI_5_tmr_enable,
      ADR3 => VCC,
      O => XLXI_5_n0004(7)
    );
  XLXI_5_n0004_6_1 : X_LUT4
    generic map(
      INIT => X"0808"
    )
    port map (
      ADR0 => XLXI_5_n0017(6),
      ADR1 => XLXI_5_tmr_enable,
      ADR2 => XLXI_5_tmr_reset,
      ADR3 => VCC,
      O => XLXI_5_n0004(6)
    );
  XLXI_5_tmr_low_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_5_tmr_low_7_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_Mmux_n0034_Result_7_1 : X_LUT4
    generic map(
      INIT => X"AACC"
    )
    port map (
      ADR0 => XLXI_1_I4_ireg_i(7),
      ADR1 => XLXI_1_I4_ireg_x(7),
      ADR2 => VCC,
      ADR3 => XLXI_1_int_stop,
      O => XLXI_1_I4_n0034(7)
    );
  XLXI_1_I4_Mmux_n0034_Result_6_1 : X_LUT4
    generic map(
      INIT => X"CCAA"
    )
    port map (
      ADR0 => XLXI_1_I4_ireg_x(6),
      ADR1 => XLXI_1_I4_ireg_i(6),
      ADR2 => VCC,
      ADR3 => XLXI_1_int_stop,
      O => XLXI_1_I4_n0034(6)
    );
  XLXI_1_I4_ireg_c_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I4_ireg_c_7_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_Ker21648_SW0 : X_LUT4
    generic map(
      INIT => X"CC33"
    )
    port map (
      ADR0 => VCC,
      ADR1 => IDATA(4),
      ADR2 => VCC,
      ADR3 => IDATA(5),
      O => XLXI_1_I4_iinc_we_c_FROM
    );
  XLXI_1_I4_iinc_we_x1 : X_LUT4
    generic map(
      INIT => X"00C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I4_N21830,
      ADR2 => IDATA(5),
      ADR3 => IDATA(4),
      O => XLXI_1_I4_iinc_we_x
    );
  XLXI_1_I4_iinc_we_c_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_iinc_we_c_FROM,
      O => N28827
    );
  XLXI_1_I4_iinc_we_c_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I4_iinc_we_c_SRMUX_OUTPUTNOT
    );
  XLXI_26_n0039_1_1 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_26_n0058(1),
      ADR1 => XLXI_26_N16130,
      ADR2 => XLXI_26_rx_bit_count(1),
      ADR3 => XLXI_26_N16090,
      O => XLXI_26_n0039(1)
    );
  XLXI_26_n0039_0_1 : X_LUT4
    generic map(
      INIT => X"FC0C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_26_N16130,
      ADR2 => XLXI_26_rx_bit_count(0),
      ADR3 => XLXI_26_N16090,
      O => XLXI_26_n0039(0)
    );
  XLXI_26_rx_bit_count_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_bit_count_1_SRMUX_OUTPUTNOT
    );
  XLXI_26_n0039_3_1 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_26_N16090,
      ADR1 => XLXI_26_n0058(3),
      ADR2 => XLXI_26_rx_bit_count(3),
      ADR3 => XLXI_26_N16130,
      O => XLXI_26_n0039(3)
    );
  XLXI_26_n0039_2_1 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_26_n0058(2),
      ADR1 => XLXI_26_N16090,
      ADR2 => XLXI_26_rx_bit_count(2),
      ADR3 => XLXI_26_N16130,
      O => XLXI_26_n0039(2)
    );
  XLXI_26_rx_bit_count_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_bit_count_3_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_ndwe_x1 : X_LUT4
    generic map(
      INIT => X"EEEE"
    )
    port map (
      ADR0 => XLXI_1_I4_Ker217601_1,
      ADR1 => XLXI_1_ndwe_int,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_1_nadwe_out
    );
  XLXI_1_I5_ndwe_c_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I5_ndwe_c_SRMUX_OUTPUTNOT
    );
  XLXI_1_I2_pc_mux_x_0_55 : X_LUT4
    generic map(
      INIT => X"0203"
    )
    port map (
      ADR0 => XLXI_1_I2_int_start_c,
      ADR1 => IDATA(1),
      ADR2 => IDATA(2),
      ADR3 => XLXI_1_I3_skip_l,
      O => XLXI_1_I2_valid_c_FROM
    );
  XLXI_1_I2_valid_x1 : X_LUT4
    generic map(
      INIT => X"00D0"
    )
    port map (
      ADR0 => XLXI_1_I3_skip_l,
      ADR1 => XLXI_1_I2_int_start_c,
      ADR2 => XLXI_1_I2_nreset_v(1),
      ADR3 => XLXI_1_I2_C_raw,
      O => XLXI_1_I2_valid_x
    );
  XLXI_1_I2_valid_c_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_valid_c_FROM,
      O => CHOICE2379
    );
  XLXI_1_I2_valid_c_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_valid_c_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_daddr_x_1_Q : X_LUT4
    generic map(
      INIT => X"CC40"
    )
    port map (
      ADR0 => N28548,
      ADR1 => XLXI_1_I4_n00371_1,
      ADR2 => XLXI_1_I4_N21894,
      ADR3 => IDATA(5),
      O => XLXI_1_I5_daddr_c_1_FROM
    );
  XLXI_1_I5_Mmux_daddr_out_Result_1_1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => XLXI_1_I4_Ker217601_1,
      ADR1 => XLXI_1_I5_daddr_c(1),
      ADR2 => XLXI_1_I2_ndre_x1_1,
      ADR3 => XLXI_1_adaddr_out(1),
      O => XLXI_1_I5_daddr_c_1_GROM
    );
  XLXI_1_I5_daddr_c_1_XUSED : X_BUF
    port map (
      I => XLXI_1_I5_daddr_c_1_FROM,
      O => XLXI_1_adaddr_out(1)
    );
  XLXI_1_I5_daddr_c_1_YUSED : X_BUF
    port map (
      I => XLXI_1_I5_daddr_c_1_GROM,
      O => CPU_ADDR_OUT(1)
    );
  XLXI_1_I5_daddr_c_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I5_daddr_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_daddr_x_5_1 : X_LUT4
    generic map(
      INIT => X"88C0"
    )
    port map (
      ADR0 => IDATA(9),
      ADR1 => XLXI_1_I4_n00371_1,
      ADR2 => XLXI_1_I4_ireg_c(5),
      ADR3 => XLXI_1_I4_N21661,
      O => XLXI_1_I5_daddr_c_5_FROM
    );
  XLXI_1_I5_Mmux_daddr_out_Result_5_1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => XLXI_1_I4_Ker217601_1,
      ADR1 => XLXI_1_I5_daddr_c(5),
      ADR2 => XLXI_1_I2_ndre_x1_1,
      ADR3 => XLXI_1_adaddr_out(5),
      O => XLXI_1_I5_daddr_c_5_GROM
    );
  XLXI_1_I5_daddr_c_5_XUSED : X_BUF
    port map (
      I => XLXI_1_I5_daddr_c_5_FROM,
      O => XLXI_1_adaddr_out(5)
    );
  XLXI_1_I5_daddr_c_5_YUSED : X_BUF
    port map (
      I => XLXI_1_I5_daddr_c_5_GROM,
      O => CPU_ADDR_OUT(5)
    );
  XLXI_1_I5_daddr_c_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I5_daddr_c_5_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_daddr_x_6_1 : X_LUT4
    generic map(
      INIT => X"C0A0"
    )
    port map (
      ADR0 => XLXI_1_I4_ireg_c(6),
      ADR1 => IDATA(10),
      ADR2 => XLXI_1_I4_n00371_1,
      ADR3 => XLXI_1_I4_N21661,
      O => XLXI_1_I5_daddr_c_6_FROM
    );
  XLXI_1_I5_Mmux_daddr_out_Result_6_1 : X_LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      ADR0 => XLXI_1_I5_daddr_c(6),
      ADR1 => XLXI_1_I2_ndre_x1_1,
      ADR2 => XLXI_1_I4_Ker217601_1,
      ADR3 => XLXI_1_adaddr_out(6),
      O => XLXI_1_I5_daddr_c_6_GROM
    );
  XLXI_1_I5_daddr_c_6_XUSED : X_BUF
    port map (
      I => XLXI_1_I5_daddr_c_6_FROM,
      O => XLXI_1_adaddr_out(6)
    );
  XLXI_1_I5_daddr_c_6_YUSED : X_BUF
    port map (
      I => XLXI_1_I5_daddr_c_6_GROM,
      O => CPU_ADDR_OUT(6)
    );
  XLXI_1_I5_daddr_c_6_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I5_daddr_c_6_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_daddr_x_7_1 : X_LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      ADR0 => XLXI_1_I4_n00371_1,
      ADR1 => XLXI_1_I4_N21661,
      ADR2 => IDATA(11),
      ADR3 => XLXI_1_I4_ireg_c(7),
      O => XLXI_1_I5_daddr_c_7_FROM
    );
  XLXI_1_I5_Mmux_daddr_out_Result_7_1 : X_LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      ADR0 => XLXI_1_I5_daddr_c(7),
      ADR1 => XLXI_1_I4_Ker217601_1,
      ADR2 => XLXI_1_I2_ndre_x1_1,
      ADR3 => XLXI_1_adaddr_out(7),
      O => XLXI_1_I5_daddr_c_7_GROM
    );
  XLXI_1_I5_daddr_c_7_XUSED : X_BUF
    port map (
      I => XLXI_1_I5_daddr_c_7_FROM,
      O => XLXI_1_adaddr_out(7)
    );
  XLXI_1_I5_daddr_c_7_YUSED : X_BUF
    port map (
      I => XLXI_1_I5_daddr_c_7_GROM,
      O => CPU_ADDR_OUT(7)
    );
  XLXI_1_I5_daddr_c_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I5_daddr_c_7_SRMUX_OUTPUTNOT
    );
  XLXI_55_nCS_REG_SW114_SW6_SW0 : X_LUT4
    generic map(
      INIT => X"7F7F"
    )
    port map (
      ADR0 => XLXI_1_I4_nreset_v(1),
      ADR1 => NRESET_BUFGP,
      ADR2 => IDATA(12),
      ADR3 => VCC,
      O => XLXI_1_I5_daddr_c_8_FROM
    );
  XLXI_1_I4_daddr_x_8_1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => IDATA(12),
      ADR1 => NRESET_BUFGP,
      ADR2 => XLXI_1_I4_nreset_v(1),
      ADR3 => VCC,
      O => XLXI_1_I5_daddr_c_8_GROM
    );
  XLXI_1_I5_daddr_c_8_XUSED : X_BUF
    port map (
      I => XLXI_1_I5_daddr_c_8_FROM,
      O => N43370
    );
  XLXI_1_I5_daddr_c_8_YUSED : X_BUF
    port map (
      I => XLXI_1_I5_daddr_c_8_GROM,
      O => XLXI_1_adaddr_out(8)
    );
  XLXI_1_I5_daddr_c_8_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I5_daddr_c_8_SRMUX_OUTPUTNOT
    );
  XLXI_26_Ker161091 : X_LUT4
    generic map(
      INIT => X"FAFA"
    )
    port map (
      ADR0 => XLXI_26_rx_s_FFd1,
      ADR1 => VCC,
      ADR2 => XLXI_26_rx_s_FFd2,
      ADR3 => VCC,
      O => XLXI_26_rx_8z_count_0_FROM
    );
  XLXI_26_n0040_0_1 : X_LUT4
    generic map(
      INIT => X"FACA"
    )
    port map (
      ADR0 => XLXI_26_N16151,
      ADR1 => XLXI_26_rx_s_FFd2,
      ADR2 => XLXI_26_rx_8z_count(0),
      ADR3 => XLXI_26_rx_s_FFd1,
      O => XLXI_26_n0040(0)
    );
  XLXI_26_rx_8z_count_0_XUSED : X_BUF
    port map (
      I => XLXI_26_rx_8z_count_0_FROM,
      O => XLXI_26_N16111
    );
  XLXI_26_rx_8z_count_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_8z_count_0_SRMUX_OUTPUTNOT
    );
  XLXI_26_n0040_3_1 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_26_N16111,
      ADR1 => XLXI_26_n0059(3),
      ADR2 => XLXI_26_N16151,
      ADR3 => XLXI_26_rx_8z_count(3),
      O => XLXI_26_n0040(3)
    );
  XLXI_26_n0040_2_1 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_26_n0059(2),
      ADR1 => XLXI_26_N16111,
      ADR2 => XLXI_26_N16151,
      ADR3 => XLXI_26_rx_8z_count(2),
      O => XLXI_26_n0040(2)
    );
  XLXI_26_rx_8z_count_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_8z_count_3_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_uart_reg_8 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => RXD_IDELAY,
      CE => XLXI_26_n0102,
      CLK => UCLK_BUFGP,
      SET => RXD_IFF_SET,
      RST => GND,
      O => XLXI_26_rx_uart_reg(8)
    );
  RXD_IFF_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => RXD_SRMUXNOT,
      O => RXD_IFF_SET
    );
  XLXI_1_I1_n0013_0_1 : X_LUT4
    generic map(
      INIT => X"AFAF"
    )
    port map (
      ADR0 => XLXI_1_I1_nreset_v(1),
      ADR1 => VCC,
      ADR2 => XLXI_1_I1_nreset_v(0),
      ADR3 => VCC,
      O => XLXI_1_I1_n0013(0)
    );
  XLXI_1_I1_nreset_v_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I1_nreset_v_0_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_Ker218921_SW0_SW1 : X_LUT4
    generic map(
      INIT => X"FBFF"
    )
    port map (
      ADR0 => IDATA(6),
      ADR1 => NRESET_BUFGP,
      ADR2 => XLXI_1_skip,
      ADR3 => XLXI_1_I2_nreset_v(1),
      O => XLXI_1_I2_nreset_v_0_FROM
    );
  XLXI_1_I2_n0041_0_1 : X_LUT4
    generic map(
      INIT => X"FF0F"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_1_I2_nreset_v(0),
      ADR3 => XLXI_1_I2_nreset_v(1),
      O => XLXI_1_I2_n0041(0)
    );
  XLXI_1_I2_nreset_v_0_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_nreset_v_0_FROM,
      O => N43476
    );
  XLXI_1_I2_nreset_v_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_nreset_v_0_SRMUX_OUTPUTNOT
    );
  XLXI_1_I2_n01051 : X_LUT4
    generic map(
      INIT => X"8AFF"
    )
    port map (
      ADR0 => NRESET_BUFGP,
      ADR1 => XLXI_1_I2_N19016,
      ADR2 => XLXI_1_I2_N18844,
      ADR3 => XLXI_1_I2_nreset_v(1),
      O => XLXI_1_I2_int_start_c_FROM
    );
  XLXI_1_I2_n01001 : X_LUT4
    generic map(
      INIT => X"3000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I2_N18844,
      ADR2 => NRESET_BUFGP,
      ADR3 => XLXI_1_I2_nreset_v(1),
      O => XLXI_1_I2_int_start_c_GROM
    );
  XLXI_1_I2_int_start_c_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_int_start_c_FROM,
      O => XLXI_1_I2_n0105
    );
  XLXI_1_I2_int_start_c_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_int_start_c_GROM,
      O => XLXI_1_I2_int_start_x
    );
  XLXI_1_I2_int_start_c_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_int_start_c_SRMUX_OUTPUTNOT
    );
  XLXI_6_tx_uart_247 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => TXD_OD,
      CE => XLXI_6_n0028,
      CLK => UCLK_BUFGP,
      SET => TXD_OFF_SET,
      RST => GND,
      O => XLXI_6_tx_uart
    );
  TXD_OFF_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => TXD_SRMUXNOT,
      O => TXD_OFF_SET
    );
  XLXI_1_I3_n0115_0_208 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_1_I3_nreset_v(0),
      ADR1 => XLXI_1_I3_n0023,
      ADR2 => XLXI_1_I3_nreset_v(1),
      ADR3 => XLXI_1_I3_acc_c_0_0,
      O => XLXI_1_I3_nreset_v_0_FROM
    );
  XLXI_1_I3_n0022_0_1 : X_LUT4
    generic map(
      INIT => X"F3F3"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I3_nreset_v(0),
      ADR2 => XLXI_1_I3_nreset_v(1),
      ADR3 => VCC,
      O => XLXI_1_I3_n0022(0)
    );
  XLXI_1_I3_nreset_v_0_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_nreset_v_0_FROM,
      O => CHOICE2471
    );
  XLXI_1_I3_nreset_v_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I3_nreset_v_0_SRMUX_OUTPUTNOT
    );
  XLXI_4_n0001_1_1 : X_LUT4
    generic map(
      INIT => X"0C0E"
    )
    port map (
      ADR0 => XLXI_4_int_masked(1),
      ADR1 => XLXI_4_int_pending_c(1),
      ADR2 => XLXI_4_int_clr_c(1),
      ADR3 => XLXI_4_int_masked_c(1),
      O => XLXI_4_n0001(1)
    );
  XLXI_4_n0001_0_1 : X_LUT4
    generic map(
      INIT => X"00CE"
    )
    port map (
      ADR0 => XLXI_4_int_masked(0),
      ADR1 => XLXI_4_int_pending_c(0),
      ADR2 => XLXI_4_int_masked_c(0),
      ADR3 => XLXI_4_int_clr_c(0),
      O => XLXI_4_n0001(0)
    );
  XLXI_4_int_pending_c_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_pending_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_4_n0001_3_1 : X_LUT4
    generic map(
      INIT => X"0B0A"
    )
    port map (
      ADR0 => XLXI_4_int_pending_c(3),
      ADR1 => XLXI_4_int_masked_c(3),
      ADR2 => XLXI_4_int_clr_c(3),
      ADR3 => XLXI_4_int_masked(3),
      O => XLXI_4_n0001(3)
    );
  XLXI_4_n0001_2_1 : X_LUT4
    generic map(
      INIT => X"3130"
    )
    port map (
      ADR0 => XLXI_4_int_masked_c(2),
      ADR1 => XLXI_4_int_clr_c(2),
      ADR2 => XLXI_4_int_pending_c(2),
      ADR3 => XLXI_4_int_masked(2),
      O => XLXI_4_n0001(2)
    );
  XLXI_4_int_pending_c_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_pending_c_3_SRMUX_OUTPUTNOT
    );
  XLXI_4_n0001_5_1 : X_LUT4
    generic map(
      INIT => X"3302"
    )
    port map (
      ADR0 => XLXI_4_int_masked(5),
      ADR1 => XLXI_4_int_clr_c(5),
      ADR2 => XLXI_4_int_masked_c(5),
      ADR3 => XLXI_4_int_pending_c(5),
      O => XLXI_4_n0001(5)
    );
  XLXI_4_n0001_4_1 : X_LUT4
    generic map(
      INIT => X"5150"
    )
    port map (
      ADR0 => XLXI_4_int_clr_c(4),
      ADR1 => XLXI_4_int_masked_c(4),
      ADR2 => XLXI_4_int_pending_c(4),
      ADR3 => XLXI_4_int_masked(4),
      O => XLXI_4_n0001(4)
    );
  XLXI_4_int_pending_c_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_pending_c_5_SRMUX_OUTPUTNOT
    );
  XLXI_4_n0001_7_1 : X_LUT4
    generic map(
      INIT => X"0F04"
    )
    port map (
      ADR0 => XLXI_4_int_masked_c(7),
      ADR1 => XLXI_4_int_masked(7),
      ADR2 => XLXI_4_int_clr_c(7),
      ADR3 => XLXI_4_int_pending_c(7),
      O => XLXI_4_n0001(7)
    );
  XLXI_4_n0001_6_1 : X_LUT4
    generic map(
      INIT => X"00CE"
    )
    port map (
      ADR0 => XLXI_4_int_masked(6),
      ADR1 => XLXI_4_int_pending_c(6),
      ADR2 => XLXI_4_int_masked_c(6),
      ADR3 => XLXI_4_int_clr_c(6),
      O => XLXI_4_n0001(6)
    );
  XLXI_4_int_pending_c_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_pending_c_7_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_n00371 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_1_I4_nreset_v(1),
      ADR3 => NRESET_BUFGP,
      O => XLXI_1_I4_nreset_v_0_FROM
    );
  XLXI_1_I4_n0036_0_1 : X_LUT4
    generic map(
      INIT => X"FF0F"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_1_I4_nreset_v(0),
      ADR3 => XLXI_1_I4_nreset_v(1),
      O => XLXI_1_I4_n0036(0)
    );
  XLXI_1_I4_nreset_v_0_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_nreset_v_0_FROM,
      O => XLXI_1_I4_n0037
    );
  XLXI_1_I4_nreset_v_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I4_nreset_v_0_SRMUX_OUTPUTNOT
    );
  XLXI_6_n001640 : X_LUT4
    generic map(
      INIT => X"ECE0"
    )
    port map (
      ADR0 => XLXI_6_tx_uart_shift(1),
      ADR1 => XLXI_6_tx_bit_count(3),
      ADR2 => XLXI_6_tx_bit_count(0),
      ADR3 => XLXI_6_tx_uart_shift(8),
      O => XLXI_6_tx_bit_count_0_FROM
    );
  XLXI_6_n0010_0_1 : X_LUT4
    generic map(
      INIT => X"0C0C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_6_n0042,
      ADR2 => XLXI_6_tx_bit_count(0),
      ADR3 => VCC,
      O => XLXI_6_n0010(0)
    );
  XLXI_6_tx_bit_count_0_XUSED : X_BUF
    port map (
      I => XLXI_6_tx_bit_count_0_FROM,
      O => CHOICE824
    );
  XLXI_6_tx_bit_count_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_bit_count_0_SRMUX_OUTPUTNOT
    );
  XLXI_6_n0010_3_1 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_6_n0042,
      ADR1 => XLXI_6_n0040(3),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_6_n0010(3)
    );
  XLXI_6_n0010_2_1 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_6_n0040(2),
      ADR1 => XLXI_6_n0042,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_6_n0010(2)
    );
  XLXI_6_tx_bit_count_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_bit_count_3_SRMUX_OUTPUTNOT
    );
  XLXI_26_n0041_0_1 : X_LUT4
    generic map(
      INIT => X"FBC8"
    )
    port map (
      ADR0 => XLXI_26_rx_s_FFd2,
      ADR1 => XLXI_26_rx_8_count(0),
      ADR2 => XLXI_26_rx_s_FFd3,
      ADR3 => XLXI_26_rx_s_FFd1,
      O => XLXI_26_n0041(0)
    );
  XLXI_26_n0042_0_1 : X_LUT4
    generic map(
      INIT => X"FAD8"
    )
    port map (
      ADR0 => XLXI_26_rx_16_count(0),
      ADR1 => XLXI_26_rx_s_FFd1,
      ADR2 => XLXI_26_rx_s_FFd2,
      ADR3 => XLXI_26_rx_s_FFd3,
      O => XLXI_26_n0042(0)
    );
  XLXI_26_rx_8_count_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_8_count_0_SRMUX_OUTPUTNOT
    );
  XLXI_26_n0042_3_1 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_26_N16097,
      ADR1 => XLXI_26_n0061(3),
      ADR2 => XLXI_26_rx_16_count(3),
      ADR3 => XLXI_26_N16182,
      O => XLXI_26_n0042(3)
    );
  XLXI_26_n0042_2_1 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_26_n0061(2),
      ADR1 => XLXI_26_N16182,
      ADR2 => XLXI_26_N16097,
      ADR3 => XLXI_26_rx_16_count(2),
      O => XLXI_26_n0042(2)
    );
  XLXI_26_rx_16_count_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_16_count_3_SRMUX_OUTPUTNOT
    );
  XLXI_1_I1_Mmux_n0023_Result_1_1 : X_LUT4
    generic map(
      INIT => X"AAF0"
    )
    port map (
      ADR0 => IDATA(5),
      ADR1 => VCC,
      ADR2 => XLXI_1_I1_eaddr_x(1),
      ADR3 => XLXI_1_I1_n0034,
      O => XLXI_1_I1_n0023(1)
    );
  XLXI_1_I1_Mmux_n0023_Result_0_1 : X_LUT4
    generic map(
      INIT => X"DD88"
    )
    port map (
      ADR0 => XLXI_1_I1_n0034,
      ADR1 => IDATA(4),
      ADR2 => VCC,
      ADR3 => XLXI_1_I1_eaddr_x(0),
      O => XLXI_1_I1_n0023(0)
    );
  XLXI_1_I1_eaddr_x_1_CKINV : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I1_eaddr_x_1_CKMUXNOT
    );
  XLXI_1_I1_iaddr_x_3_20 : X_LUT4
    generic map(
      INIT => X"00A0"
    )
    port map (
      ADR0 => IDATA(7),
      ADR1 => VCC,
      ADR2 => XLXI_1_pc_mux(1),
      ADR3 => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_eaddr_x_3_FROM
    );
  XLXI_1_I1_Mmux_n0023_Result_3_1 : X_LUT4
    generic map(
      INIT => X"F0CC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I1_eaddr_x(3),
      ADR2 => IDATA(7),
      ADR3 => XLXI_1_I1_n0034,
      O => XLXI_1_I1_n0023(3)
    );
  XLXI_1_I1_eaddr_x_3_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_eaddr_x_3_FROM,
      O => CHOICE2247
    );
  XLXI_1_I1_eaddr_x_3_CKINV : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I1_eaddr_x_3_CKMUXNOT
    );
  XLXI_1_I1_Mmux_n0023_Result_5_1 : X_LUT4
    generic map(
      INIT => X"F0CC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I1_eaddr_x(5),
      ADR2 => IDATA(9),
      ADR3 => XLXI_1_I1_n0034,
      O => XLXI_1_I1_n0023(5)
    );
  XLXI_1_I1_Mmux_n0023_Result_4_1 : X_LUT4
    generic map(
      INIT => X"AFA0"
    )
    port map (
      ADR0 => IDATA(8),
      ADR1 => VCC,
      ADR2 => XLXI_1_I1_n0034,
      ADR3 => XLXI_1_I1_eaddr_x(4),
      O => XLXI_1_I1_n0023(4)
    );
  XLXI_1_I1_eaddr_x_5_CKINV : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I1_eaddr_x_5_CKMUXNOT
    );
  XLXI_1_I1_Mmux_n0023_Result_7_1 : X_LUT4
    generic map(
      INIT => X"AACC"
    )
    port map (
      ADR0 => IDATA(11),
      ADR1 => XLXI_1_I1_eaddr_x(7),
      ADR2 => VCC,
      ADR3 => XLXI_1_I1_n0034,
      O => XLXI_1_I1_n0023(7)
    );
  XLXI_1_I1_Mmux_n0023_Result_6_1 : X_LUT4
    generic map(
      INIT => X"FC30"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I1_n0034,
      ADR2 => XLXI_1_I1_eaddr_x(6),
      ADR3 => IDATA(10),
      O => XLXI_1_I1_n0023(6)
    );
  XLXI_1_I1_eaddr_x_7_CKINV : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I1_eaddr_x_7_CKMUXNOT
    );
  XLXI_1_I1_Mmux_n0023_Result_9_1 : X_LUT4
    generic map(
      INIT => X"FC30"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I1_n0034,
      ADR2 => XLXI_1_I1_eaddr_x(9),
      ADR3 => IDATA(13),
      O => XLXI_1_I1_n0023(9)
    );
  XLXI_1_I1_Mmux_n0023_Result_8_1 : X_LUT4
    generic map(
      INIT => X"FC30"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I1_n0034,
      ADR2 => XLXI_1_I1_eaddr_x(8),
      ADR3 => IDATA(12),
      O => XLXI_1_I1_n0023(8)
    );
  XLXI_1_I1_eaddr_x_9_CKINV : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I1_eaddr_x_9_CKMUXNOT
    );
  XLXI_4_n0002_1_1 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_4_int_mask_c(1),
      ADR1 => IN_INT_1_IBUF,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_4_n0002(1)
    );
  XLXI_4_n0002_0_1 : X_LUT4
    generic map(
      INIT => X"C0C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => IN_INT_0_IBUF,
      ADR2 => XLXI_4_int_mask_c(0),
      ADR3 => VCC,
      O => XLXI_4_n0002(0)
    );
  XLXI_4_int_masked_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_masked_1_SRMUX_OUTPUTNOT
    );
  XLXI_4_n0002_3_1 : X_LUT4
    generic map(
      INIT => X"AA00"
    )
    port map (
      ADR0 => XLXI_4_int_mask_c(3),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => IN_INT_3_IBUF,
      O => XLXI_4_n0002(3)
    );
  XLXI_4_n0002_2_1 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_4_int_mask_c(2),
      ADR2 => VCC,
      ADR3 => IN_INT_2_IBUF,
      O => XLXI_4_n0002(2)
    );
  XLXI_4_int_masked_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_masked_3_SRMUX_OUTPUTNOT
    );
  XLXI_4_n0002_5_1 : X_LUT4
    generic map(
      INIT => X"0A00"
    )
    port map (
      ADR0 => XLXI_4_int_mask_c(5),
      ADR1 => VCC,
      ADR2 => XLXI_26_rx_uart_full_c,
      ADR3 => XLXI_26_rx_uart_full_d,
      O => XLXI_4_n0002(5)
    );
  XLXI_4_n0002_4_1 : X_LUT4
    generic map(
      INIT => X"00C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_4_int_mask_c(4),
      ADR2 => XLXI_26_rx_uart_ovr_d,
      ADR3 => XLXI_26_rx_uart_full_c,
      O => XLXI_4_n0002(4)
    );
  XLXI_4_int_masked_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_masked_5_SRMUX_OUTPUTNOT
    );
  XLXI_4_n0002_7_1 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_5_tmr_int_x,
      ADR2 => VCC,
      ADR3 => XLXI_4_int_mask_c(7),
      O => XLXI_4_n0002(7)
    );
  XLXI_4_n0002_6_1 : X_LUT4
    generic map(
      INIT => X"00AA"
    )
    port map (
      ADR0 => XLXI_4_int_mask_c(6),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_6_tx_uart_busy,
      O => XLXI_4_n0002(6)
    );
  XLXI_4_int_masked_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_masked_7_SRMUX_OUTPUTNOT
    );
  XLXI_1_I2_ndre_x1_SW0 : X_LUT4
    generic map(
      INIT => X"57FF"
    )
    port map (
      ADR0 => XLXI_1_I2_nreset_v(1),
      ADR1 => IDATA(2),
      ADR2 => IDATA(1),
      ADR3 => NRESET_BUFGP,
      O => XLXI_1_I2_S_c_2_FROM
    );
  XLXI_1_I2_n0040_1_Q : X_LUT4
    generic map(
      INIT => X"F1FF"
    )
    port map (
      ADR0 => CHOICE1111,
      ADR1 => CHOICE1108,
      ADR2 => N43921,
      ADR3 => XLXI_1_I2_nreset_v(1),
      O => XLXI_1_I2_n0040(1)
    );
  XLXI_1_I2_S_c_2_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_S_c_2_FROM,
      O => N43080
    );
  XLXI_1_I2_S_c_2_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_S_c_2_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_8_count_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_8_count_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_8_count_3_FFY_RST
    );
  XLXI_26_rx_8_count_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n0041(2),
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_8_count_3_FFY_RST,
      O => XLXI_26_rx_8_count(2)
    );
  XLXI_26_n0041_3_1 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_26_N16104,
      ADR1 => XLXI_26_n0060(3),
      ADR2 => XLXI_26_N16174,
      ADR3 => XLXI_26_rx_8_count(3),
      O => XLXI_26_n0041(3)
    );
  XLXI_26_n0041_2_1 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_26_n0060(2),
      ADR1 => XLXI_26_N16104,
      ADR2 => XLXI_26_N16174,
      ADR3 => XLXI_26_rx_8_count(2),
      O => XLXI_26_n0041(2)
    );
  XLXI_26_rx_8_count_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_8_count_3_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_n0115_3_72_SW1 : X_LUT4
    generic map(
      INIT => X"D080"
    )
    port map (
      ADR0 => CHOICE2639,
      ADR1 => N43314,
      ADR2 => XLXI_1_I3_n00231_1,
      ADR3 => N43312,
      O => N43276_FROM
    );
  XLXI_1_I3_n0115_3_72_SW0 : X_LUT4
    generic map(
      INIT => X"F800"
    )
    port map (
      ADR0 => N43406,
      ADR1 => CHOICE2639,
      ADR2 => CHOICE2661,
      ADR3 => XLXI_1_I3_n00231_1,
      O => N43276_GROM
    );
  N43276_XUSED : X_BUF
    port map (
      I => N43276_FROM,
      O => N43276
    );
  N43276_YUSED : X_BUF
    port map (
      I => N43276_GROM,
      O => N43274
    );
  XLXI_1_I1_iaddr_x_9_60_SW0 : X_LUT4
    generic map(
      INIT => X"DDCF"
    )
    port map (
      ADR0 => XLXI_1_I1_n0024(9),
      ADR1 => XLXI_1_pc_mux(1),
      ADR2 => XLXI_1_I1_pc(9),
      ADR3 => XLXI_1_pc_mux(0),
      O => N43800_FROM
    );
  XLXI_1_I1_iaddr_x_6_60_SW0 : X_LUT4
    generic map(
      INIT => X"AFBB"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(1),
      ADR1 => XLXI_1_I1_pc(6),
      ADR2 => XLXI_1_I1_n0024(6),
      ADR3 => XLXI_1_pc_mux(0),
      O => N43800_GROM
    );
  N43800_XUSED : X_BUF
    port map (
      I => N43800_FROM,
      O => N43800
    );
  N43800_YUSED : X_BUF
    port map (
      I => N43800_GROM,
      O => N43788
    );
  XLXI_1_I1_iaddr_x_6_20 : X_LUT4
    generic map(
      INIT => X"0088"
    )
    port map (
      ADR0 => IDATA(10),
      ADR1 => XLXI_1_pc_mux(1),
      ADR2 => VCC,
      ADR3 => XLXI_1_pc_mux(2),
      O => CHOICE2315_FROM
    );
  XLXI_1_I1_iaddr_x_7_20 : X_LUT4
    generic map(
      INIT => X"0C00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => IDATA(11),
      ADR2 => XLXI_1_pc_mux(2),
      ADR3 => XLXI_1_pc_mux(1),
      O => CHOICE2315_GROM
    );
  CHOICE2315_XUSED : X_BUF
    port map (
      I => CHOICE2315_FROM,
      O => CHOICE2315
    );
  CHOICE2315_YUSED : X_BUF
    port map (
      I => CHOICE2315_GROM,
      O => CHOICE2298
    );
  XLXI_1_I3_Mmux_data_x_Result_2_123 : X_LUT4
    generic map(
      INIT => X"0088"
    )
    port map (
      ADR0 => NRESET_BUFGP,
      ADR1 => XLXI_1_I4_nreset_v(1),
      ADR2 => VCC,
      ADR3 => XLXI_1_I3_n0025,
      O => CHOICE2856_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_1_123 : X_LUT4
    generic map(
      INIT => X"0C00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I4_nreset_v(1),
      ADR2 => XLXI_1_I3_n0025,
      ADR3 => NRESET_BUFGP,
      O => CHOICE2856_GROM
    );
  CHOICE2856_XUSED : X_BUF
    port map (
      I => CHOICE2856_FROM,
      O => CHOICE2856
    );
  CHOICE2856_YUSED : X_BUF
    port map (
      I => CHOICE2856_GROM,
      O => CHOICE2920
    );
  XLXI_1_I1_iaddr_x_4_20 : X_LUT4
    generic map(
      INIT => X"0A00"
    )
    port map (
      ADR0 => IDATA(8),
      ADR1 => VCC,
      ADR2 => XLXI_1_pc_mux(2),
      ADR3 => XLXI_1_pc_mux(1),
      O => CHOICE2349_FROM
    );
  XLXI_1_I1_iaddr_x_8_20 : X_LUT4
    generic map(
      INIT => X"5000"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(2),
      ADR1 => VCC,
      ADR2 => XLXI_1_pc_mux(1),
      ADR3 => IDATA(12),
      O => CHOICE2349_GROM
    );
  CHOICE2349_XUSED : X_BUF
    port map (
      I => CHOICE2349_FROM,
      O => CHOICE2349
    );
  CHOICE2349_YUSED : X_BUF
    port map (
      I => CHOICE2349_GROM,
      O => CHOICE2281
    );
  XLXI_1_I3_Mmux_data_x_Result_0_99_SW0 : X_LUT4
    generic map(
      INIT => X"FFEF"
    )
    port map (
      ADR0 => XLXI_1_I2_C_raw,
      ADR1 => XLXI_1_skip,
      ADR2 => CHOICE2993,
      ADR3 => IDATA(3),
      O => N43439_FROM
    );
  XLXI_1_I4_Ker216591_SW0_SW1 : X_LUT4
    generic map(
      INIT => X"FFBF"
    )
    port map (
      ADR0 => IDATA(3),
      ADR1 => XLXI_1_I2_nreset_v(1),
      ADR2 => NRESET_BUFGP,
      ADR3 => XLXI_1_skip,
      O => N43439_GROM
    );
  N43439_XUSED : X_BUF
    port map (
      I => N43439_FROM,
      O => N43439
    );
  N43439_YUSED : X_BUF
    port map (
      I => N43439_GROM,
      O => N43482
    );
  XLXI_1_I1_iaddr_x_5_20 : X_LUT4
    generic map(
      INIT => X"2200"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(1),
      ADR1 => XLXI_1_pc_mux(2),
      ADR2 => VCC,
      ADR3 => IDATA(9),
      O => CHOICE2332_FROM
    );
  XLXI_1_I1_iaddr_x_9_20 : X_LUT4
    generic map(
      INIT => X"00A0"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(1),
      ADR1 => VCC,
      ADR2 => IDATA(13),
      ADR3 => XLXI_1_pc_mux(2),
      O => CHOICE2332_GROM
    );
  CHOICE2332_XUSED : X_BUF
    port map (
      I => CHOICE2332_FROM,
      O => CHOICE2332
    );
  CHOICE2332_YUSED : X_BUF
    port map (
      I => CHOICE2332_GROM,
      O => CHOICE2264
    );
  XLXI_1_I3_Ker199757_SW0 : X_LUT4
    generic map(
      INIT => X"5554"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c(3),
      ADR1 => XLXI_1_I2_TD_c(0),
      ADR2 => XLXI_1_I2_TD_c(1),
      ADR3 => XLXI_1_I2_TD_c(2),
      O => N43992_FROM
    );
  XLXI_1_I3_Ker199757 : X_LUT4
    generic map(
      INIT => X"0007"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c_0_1,
      ADR1 => XLXI_1_I2_TC_c_1_1,
      ADR2 => XLXI_1_I2_TC_c_2_1,
      ADR3 => N43992,
      O => N43992_GROM
    );
  N43992_XUSED : X_BUF
    port map (
      I => N43992_FROM,
      O => N43992
    );
  N43992_YUSED : X_BUF
    port map (
      I => N43992_GROM,
      O => CHOICE531
    );
  XLXI_26_rx_s_FFd2_In_SW0 : X_LUT4
    generic map(
      INIT => X"2020"
    )
    port map (
      ADR0 => XLXI_26_rx_s_FFd3,
      ADR1 => RXD_IBUF,
      ADR2 => XLXI_26_n0023,
      ADR3 => VCC,
      O => XLXI_26_rx_s_FFd2_FROM
    );
  XLXI_26_rx_s_FFd2_In_248 : X_LUT4
    generic map(
      INIT => X"FF4C"
    )
    port map (
      ADR0 => XLXI_26_n0024,
      ADR1 => XLXI_26_rx_s_FFd2,
      ADR2 => XLXI_26_rx_bit_count(3),
      ADR3 => N27670,
      O => XLXI_26_rx_s_FFd2_In
    );
  XLXI_26_rx_s_FFd2_XUSED : X_BUF
    port map (
      I => XLXI_26_rx_s_FFd2_FROM,
      O => N27670
    );
  XLXI_26_rx_s_FFd2_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_s_FFd2_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_uart_reg_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_uart_reg_0_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_uart_reg_1_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_26_rx_uart_reg_1_SRMUX_OUTPUTNOT,
      O => XLXI_26_rx_uart_reg_1_FFY_SET
    );
  XLXI_26_rx_uart_reg_1 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => RXD_IBUF,
      CE => XLXI_26_n0116,
      CLK => UCLK_BUFGP,
      SET => XLXI_26_rx_uart_reg_1_FFY_SET,
      RST => GND,
      O => XLXI_26_rx_uart_reg(1)
    );
  XLXI_26_rx_uart_reg_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_uart_reg_1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_n00251 : X_LUT4
    generic map(
      INIT => X"1100"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c_2_1,
      ADR1 => XLXI_1_I2_TC_c_0_1,
      ADR2 => VCC,
      ADR3 => XLXI_1_I2_TC_c_1_1,
      O => XLXI_1_I3_n0025_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_4_123 : X_LUT4
    generic map(
      INIT => X"00A0"
    )
    port map (
      ADR0 => NRESET_BUFGP,
      ADR1 => VCC,
      ADR2 => XLXI_1_I4_nreset_v(1),
      ADR3 => XLXI_1_I3_n0025,
      O => XLXI_1_I3_n0025_GROM
    );
  XLXI_1_I3_n0025_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0025_FROM,
      O => XLXI_1_I3_n0025
    );
  XLXI_1_I3_n0025_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0025_GROM,
      O => CHOICE2695
    );
  XLXI_26_rx_uart_reg_2_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_uart_reg_2_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_uart_reg_3_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_26_rx_uart_reg_3_SRMUX_OUTPUTNOT,
      O => XLXI_26_rx_uart_reg_3_FFY_SET
    );
  XLXI_26_rx_uart_reg_3 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => RXD_IBUF,
      CE => XLXI_26_n0112,
      CLK => UCLK_BUFGP,
      SET => XLXI_26_rx_uart_reg_3_FFY_SET,
      RST => GND,
      O => XLXI_26_rx_uart_reg(3)
    );
  XLXI_26_rx_uart_reg_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_uart_reg_3_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_uart_reg_4_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_26_rx_uart_reg_4_SRMUX_OUTPUTNOT,
      O => XLXI_26_rx_uart_reg_4_FFY_SET
    );
  XLXI_26_rx_uart_reg_4 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => RXD_IBUF,
      CE => XLXI_26_n0110,
      CLK => UCLK_BUFGP,
      SET => XLXI_26_rx_uart_reg_4_FFY_SET,
      RST => GND,
      O => XLXI_26_rx_uart_reg(4)
    );
  XLXI_26_rx_uart_reg_4_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_uart_reg_4_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_uart_reg_5_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_26_rx_uart_reg_5_SRMUX_OUTPUTNOT,
      O => XLXI_26_rx_uart_reg_5_FFY_SET
    );
  XLXI_26_rx_uart_reg_5 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => RXD_IBUF,
      CE => XLXI_26_n0108,
      CLK => UCLK_BUFGP,
      SET => XLXI_26_rx_uart_reg_5_FFY_SET,
      RST => GND,
      O => XLXI_26_rx_uart_reg(5)
    );
  XLXI_26_rx_uart_reg_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_uart_reg_5_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_uart_reg_6_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_26_rx_uart_reg_6_SRMUX_OUTPUTNOT,
      O => XLXI_26_rx_uart_reg_6_FFY_SET
    );
  XLXI_26_rx_uart_reg_6 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => RXD_IBUF,
      CE => XLXI_26_n0106,
      CLK => UCLK_BUFGP,
      SET => XLXI_26_rx_uart_reg_6_FFY_SET,
      RST => GND,
      O => XLXI_26_rx_uart_reg(6)
    );
  XLXI_26_rx_uart_reg_6_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_uart_reg_6_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_uart_reg_7_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_26_rx_uart_reg_7_SRMUX_OUTPUTNOT,
      O => XLXI_26_rx_uart_reg_7_FFY_SET
    );
  XLXI_26_rx_uart_reg_7 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => RXD_IBUF,
      CE => XLXI_26_n0104,
      CLK => UCLK_BUFGP,
      SET => XLXI_26_rx_uart_reg_7_FFY_SET,
      RST => GND,
      O => XLXI_26_rx_uart_reg(7)
    );
  XLXI_26_rx_uart_reg_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_uart_reg_7_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_n00571 : X_LUT4
    generic map(
      INIT => X"0050"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c(2),
      ADR1 => VCC,
      ADR2 => XLXI_1_I2_TD_c(1),
      ADR3 => XLXI_1_I2_TD_c(0),
      O => XLXI_1_I3_n0057_FROM
    );
  XLXI_1_I3_n00601 : X_LUT4
    generic map(
      INIT => X"A000"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c(2),
      ADR1 => VCC,
      ADR2 => XLXI_1_I2_TD_c(1),
      ADR3 => XLXI_1_I2_TD_c(0),
      O => XLXI_1_I3_n0057_GROM
    );
  XLXI_1_I3_n0057_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0057_FROM,
      O => XLXI_1_I3_n0057
    );
  XLXI_1_I3_n0057_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0057_GROM,
      O => XLXI_1_I3_n0060
    );
  XLXI_1_I3_Ker200081 : X_LUT4
    generic map(
      INIT => X"9900"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c_0_1,
      ADR1 => XLXI_1_I2_TD_c_2_1,
      ADR2 => VCC,
      ADR3 => XLXI_1_I2_TD_c_1_1,
      O => XLXI_1_I3_N20010_FROM
    );
  XLXI_1_I3_n00611 : X_LUT4
    generic map(
      INIT => X"0A00"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c_2_1,
      ADR1 => VCC,
      ADR2 => XLXI_1_I2_TD_c_0_1,
      ADR3 => XLXI_1_I2_TD_c_1_1,
      O => XLXI_1_I3_N20010_GROM
    );
  XLXI_1_I3_N20010_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_N20010_FROM,
      O => XLXI_1_I3_N20010
    );
  XLXI_1_I3_N20010_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_N20010_GROM,
      O => XLXI_1_I3_n0061
    );
  XLXI_1_I3_n00631 : X_LUT4
    generic map(
      INIT => X"2200"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c(2),
      ADR1 => XLXI_1_I2_TD_c(1),
      ADR2 => VCC,
      ADR3 => XLXI_1_I2_TD_c(0),
      O => XLXI_1_I3_n0063_FROM
    );
  XLXI_1_I3_n0115_8_42 : X_LUT4
    generic map(
      INIT => X"E9E8"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c_2_1,
      ADR1 => XLXI_1_I2_TC_c_0_1,
      ADR2 => XLXI_1_I2_TC_c_1_1,
      ADR3 => XLXI_1_I3_n0063,
      O => XLXI_1_I3_n0063_GROM
    );
  XLXI_1_I3_n0063_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0063_FROM,
      O => XLXI_1_I3_n0063
    );
  XLXI_1_I3_n0063_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0063_GROM,
      O => CHOICE2711
    );
  XLXI_1_I2_pc_mux_x_0_79_4_249 : X_LUT4
    generic map(
      INIT => X"FCFC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CHOICE2367,
      ADR2 => CHOICE2381,
      ADR3 => VCC,
      O => XLXI_1_I2_pc_mux_x_0_79_4_FROM
    );
  XLXI_1_I1_n0021_3_65_SW1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => CHOICE2367,
      ADR1 => XLXI_1_I1_n0024(3),
      ADR2 => CHOICE2381,
      ADR3 => XLXI_1_I1_stack_addrs_c_0_3,
      O => XLXI_1_I2_pc_mux_x_0_79_4_GROM
    );
  XLXI_1_I2_pc_mux_x_0_79_4_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_pc_mux_x_0_79_4_FROM,
      O => XLXI_1_I2_pc_mux_x_0_79_4
    );
  XLXI_1_I2_pc_mux_x_0_79_4_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_pc_mux_x_0_79_4_GROM,
      O => N44524
    );
  XLXI_1_I3_n00581 : X_LUT4
    generic map(
      INIT => X"5000"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c(2),
      ADR1 => VCC,
      ADR2 => XLXI_1_I2_TD_c(0),
      ADR3 => XLXI_1_I2_TD_c(1),
      O => XLXI_1_I3_n0058_FROM
    );
  XLXI_1_I3_n0115_7_29 : X_LUT4
    generic map(
      INIT => X"8A88"
    )
    port map (
      ADR0 => XLXI_1_I3_data_x(7),
      ADR1 => XLXI_1_I3_N20010,
      ADR2 => XLXI_1_I3_acc_c_0_7,
      ADR3 => XLXI_1_I3_n0058,
      O => XLXI_1_I3_n0058_GROM
    );
  XLXI_1_I3_n0058_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0058_FROM,
      O => XLXI_1_I3_n0058
    );
  XLXI_1_I3_n0058_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0058_GROM,
      O => CHOICE2934
    );
  XLXI_1_I3_Mmux_data_x_Result_6_123 : X_LUT4
    generic map(
      INIT => X"4040"
    )
    port map (
      ADR0 => XLXI_1_I3_n0025,
      ADR1 => NRESET_BUFGP,
      ADR2 => XLXI_1_I4_nreset_v(1),
      ADR3 => VCC,
      O => CHOICE2567_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_5_123 : X_LUT4
    generic map(
      INIT => X"2020"
    )
    port map (
      ADR0 => XLXI_1_I4_nreset_v(1),
      ADR1 => XLXI_1_I3_n0025,
      ADR2 => NRESET_BUFGP,
      ADR3 => VCC,
      O => CHOICE2567_GROM
    );
  CHOICE2567_XUSED : X_BUF
    port map (
      I => CHOICE2567_FROM,
      O => CHOICE2567
    );
  CHOICE2567_YUSED : X_BUF
    port map (
      I => CHOICE2567_GROM,
      O => CHOICE2631
    );
  XLXI_1_I3_Ker200501 : X_LUT4
    generic map(
      INIT => X"A050"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c_2_1,
      ADR1 => VCC,
      ADR2 => XLXI_1_I2_TD_c_0_1,
      ADR3 => XLXI_1_I2_TD_c_1_1,
      O => XLXI_1_I3_N20052_FROM
    );
  XLXI_1_I3_n00591 : X_LUT4
    generic map(
      INIT => X"1010"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c_0_1,
      ADR1 => XLXI_1_I2_TD_c(1),
      ADR2 => XLXI_1_I2_TD_c_2_1,
      ADR3 => VCC,
      O => XLXI_1_I3_N20052_GROM
    );
  XLXI_1_I3_N20052_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_N20052_FROM,
      O => XLXI_1_I3_N20052
    );
  XLXI_1_I3_N20052_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_N20052_GROM,
      O => XLXI_1_I3_n0059
    );
  XLXI_1_I3_n0115_1_13_SW2 : X_LUT4
    generic map(
      INIT => X"0220"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_1,
      ADR1 => XLXI_1_I2_TC_c_2_1,
      ADR2 => XLXI_1_I2_TC_c_0_1,
      ADR3 => XLXI_1_I2_TC_c_1_1,
      O => N43386_FROM
    );
  XLXI_1_I3_n00671 : X_LUT4
    generic map(
      INIT => X"0202"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c_2_1,
      ADR1 => XLXI_1_I2_TC_c_1_1,
      ADR2 => XLXI_1_I2_TC_c_0_1,
      ADR3 => VCC,
      O => N43386_GROM
    );
  N43386_XUSED : X_BUF
    port map (
      I => N43386_FROM,
      O => N43386
    );
  N43386_YUSED : X_BUF
    port map (
      I => N43386_GROM,
      O => XLXI_1_I3_n0067
    );
  XLXI_1_I3_n00761 : X_LUT4
    generic map(
      INIT => X"1212"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c_1_1,
      ADR1 => XLXI_1_I2_TC_c_2_1,
      ADR2 => XLXI_1_I2_TC_c_0_1,
      ADR3 => VCC,
      O => XLXI_1_I3_n0076_FROM
    );
  XLXI_1_I3_n0115_8_53 : X_LUT4
    generic map(
      INIT => X"0200"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c(0),
      ADR1 => XLXI_1_I2_TD_c(2),
      ADR2 => XLXI_1_I2_TD_c(1),
      ADR3 => XLXI_1_I3_n0076,
      O => XLXI_1_I3_n0076_GROM
    );
  XLXI_1_I3_n0076_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0076_FROM,
      O => XLXI_1_I3_n0076
    );
  XLXI_1_I3_n0076_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n0076_GROM,
      O => CHOICE2716
    );
  XLXI_1_I3_n0115_4_13_SW0 : X_LUT4
    generic map(
      INIT => X"F0FC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I3_n0076,
      ADR2 => CHOICE2758,
      ADR3 => XLXI_1_I2_TD_c_3_1,
      O => N43318_FROM
    );
  XLXI_1_I3_n0115_5_13_SW0 : X_LUT4
    generic map(
      INIT => X"CECE"
    )
    port map (
      ADR0 => XLXI_1_I3_n0076,
      ADR1 => CHOICE2822,
      ADR2 => XLXI_1_I2_TD_c_3_1,
      ADR3 => VCC,
      O => N43318_GROM
    );
  N43318_XUSED : X_BUF
    port map (
      I => N43318_FROM,
      O => N43318
    );
  N43318_YUSED : X_BUF
    port map (
      I => N43318_GROM,
      O => N43324
    );
  XLXI_1_I3_Mmux_data_x_Result_5_0 : X_LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      ADR0 => XLXI_1_I2_data_is_c(5),
      ADR1 => XLXI_1_I2_TC_c_1_1,
      ADR2 => XLXI_1_I2_TC_c_2_1,
      ADR3 => XLXI_1_I2_TC_c_0_1,
      O => CHOICE2601_FROM
    );
  XLXI_1_I3_n0115_5_13_SW2 : X_LUT4
    generic map(
      INIT => X"1020"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c_0_1,
      ADR1 => XLXI_1_I2_TC_c_2_1,
      ADR2 => XLXI_1_I3_acc_c_0_5,
      ADR3 => XLXI_1_I2_TC_c_1_1,
      O => CHOICE2601_GROM
    );
  CHOICE2601_XUSED : X_BUF
    port map (
      I => CHOICE2601_FROM,
      O => CHOICE2601
    );
  CHOICE2601_YUSED : X_BUF
    port map (
      I => CHOICE2601_GROM,
      O => N43398
    );
  XLXI_3_reg_data_out_x_7_SW0 : X_LUT4
    generic map(
      INIT => X"DD88"
    )
    port map (
      ADR0 => CPU_ADDR_OUT(0),
      ADR1 => IN1_REG_7_IBUF,
      ADR2 => VCC,
      ADR3 => IN0_REG_7_IBUF,
      O => N28941_FROM
    );
  XLXI_3_reg_data_out_x_0_SW0 : X_LUT4
    generic map(
      INIT => X"11BB"
    )
    port map (
      ADR0 => CPU_ADDR_OUT(0),
      ADR1 => IN0_REG_0_IBUF,
      ADR2 => VCC,
      ADR3 => IN1_REG_0_IBUF,
      O => N28941_GROM
    );
  N28941_XUSED : X_BUF
    port map (
      I => N28941_FROM,
      O => N28941
    );
  N28941_YUSED : X_BUF
    port map (
      I => N28941_GROM,
      O => N29544
    );
  XLXI_1_I3_n0115_4_72_SW1 : X_LUT4
    generic map(
      INIT => X"88A0"
    )
    port map (
      ADR0 => XLXI_1_I3_n00231_1,
      ADR1 => N43320,
      ADR2 => N43318,
      ADR3 => CHOICE2736,
      O => N43270_FROM
    );
  XLXI_1_I3_n0115_4_72_SW0 : X_LUT4
    generic map(
      INIT => X"C888"
    )
    port map (
      ADR0 => CHOICE2758,
      ADR1 => XLXI_1_I3_n00231_1,
      ADR2 => CHOICE2736,
      ADR3 => N43402,
      O => N43270_GROM
    );
  N43270_XUSED : X_BUF
    port map (
      I => N43270_FROM,
      O => N43270
    );
  N43270_YUSED : X_BUF
    port map (
      I => N43270_GROM,
      O => N43268
    );
  XLXI_1_I1_iaddr_x_5_60_SW0 : X_LUT4
    generic map(
      INIT => X"F3F5"
    )
    port map (
      ADR0 => XLXI_1_I1_pc(5),
      ADR1 => XLXI_1_I1_n0024(5),
      ADR2 => XLXI_1_pc_mux(1),
      ADR3 => XLXI_1_pc_mux(0),
      O => N43804_FROM
    );
  XLXI_1_I1_iaddr_x_7_60_SW0 : X_LUT4
    generic map(
      INIT => X"CDFD"
    )
    port map (
      ADR0 => XLXI_1_I1_pc(7),
      ADR1 => XLXI_1_pc_mux(1),
      ADR2 => XLXI_1_pc_mux(0),
      ADR3 => XLXI_1_I1_n0024(7),
      O => N43804_GROM
    );
  N43804_XUSED : X_BUF
    port map (
      I => N43804_FROM,
      O => N43804
    );
  N43804_YUSED : X_BUF
    port map (
      I => N43804_GROM,
      O => N43784
    );
  XLXI_26_n00301 : X_LUT4
    generic map(
      INIT => X"1010"
    )
    port map (
      ADR0 => XLXI_1_I5_ndwe_c,
      ADR1 => nCS_UART,
      ADR2 => XLXI_1_I5_Mmux_daddr_out_Result_0_1_1,
      ADR3 => VCC,
      O => XLXI_26_n0030_FROM
    );
  XLXI_4_n00051 : X_LUT4
    generic map(
      INIT => X"0005"
    )
    port map (
      ADR0 => XLXI_1_I5_ndwe_c,
      ADR1 => VCC,
      ADR2 => nCS_INT,
      ADR3 => XLXI_1_I5_Mmux_daddr_out_Result_0_1_1,
      O => XLXI_26_n0030_GROM
    );
  XLXI_26_n0030_XUSED : X_BUF
    port map (
      I => XLXI_26_n0030_FROM,
      O => XLXI_26_n0030
    );
  XLXI_26_n0030_YUSED : X_BUF
    port map (
      I => XLXI_26_n0030_GROM,
      O => XLXI_4_n0005
    );
  XLXI_3_reg_data_out_x_3_SW0 : X_LUT4
    generic map(
      INIT => X"AACC"
    )
    port map (
      ADR0 => IN1_REG_3_IBUF,
      ADR1 => IN0_REG_3_IBUF,
      ADR2 => VCC,
      ADR3 => CPU_ADDR_OUT(0),
      O => N29274_FROM
    );
  XLXI_3_reg_data_out_x_1_SW0 : X_LUT4
    generic map(
      INIT => X"F0CC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => IN0_REG_1_IBUF,
      ADR2 => IN1_REG_1_IBUF,
      ADR3 => CPU_ADDR_OUT(0),
      O => N29274_GROM
    );
  N29274_XUSED : X_BUF
    port map (
      I => N29274_FROM,
      O => N29274
    );
  N29274_YUSED : X_BUF
    port map (
      I => N29274_GROM,
      O => N29416
    );
  XLXI_26_rx_s_FFd3_In_SW0 : X_LUT4
    generic map(
      INIT => X"FF55"
    )
    port map (
      ADR0 => XLXI_26_n0023,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => RXD_IBUF,
      O => XLXI_26_rx_s_FFd3_FROM
    );
  XLXI_26_rx_s_FFd3_In_250 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_26_rx_s_FFd1,
      ADR1 => XLXI_26_rx_s_FFd3,
      ADR2 => XLXI_26_n0026,
      ADR3 => N27639,
      O => XLXI_26_rx_s_FFd3_In
    );
  XLXI_26_rx_s_FFd3_XUSED : X_BUF
    port map (
      I => XLXI_26_rx_s_FFd3_FROM,
      O => N27639
    );
  XLXI_26_rx_s_FFd3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_s_FFd3_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_n0115_0_191_SW1 : X_LUT4
    generic map(
      INIT => X"EA00"
    )
    port map (
      ADR0 => N44416,
      ADR1 => XLXI_1_I3_N19977,
      ADR2 => XLXI_1_I3_acc_c_0_0,
      ADR3 => XLXI_1_I3_n0023,
      O => N43090_FROM
    );
  XLXI_1_I3_n0115_0_191_SW0 : X_LUT4
    generic map(
      INIT => X"EA00"
    )
    port map (
      ADR0 => CHOICE2464,
      ADR1 => XLXI_1_I3_N19977,
      ADR2 => XLXI_1_I3_acc_c_0_0,
      ADR3 => XLXI_1_I3_n0023,
      O => N43090_GROM
    );
  N43090_XUSED : X_BUF
    port map (
      I => N43090_FROM,
      O => N43090
    );
  N43090_YUSED : X_BUF
    port map (
      I => N43090_GROM,
      O => N43088
    );
  XLXI_1_I3_n0115_7_0 : X_LUT4
    generic map(
      INIT => X"C0C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I3_N19927,
      ADR2 => XLXI_1_I3_acc_c_0_7,
      ADR3 => VCC,
      O => CHOICE2923_FROM
    );
  XLXI_1_I3_n007225 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_5,
      ADR1 => XLXI_1_I3_acc_c_0_7,
      ADR2 => XLXI_1_I3_acc_c_0_4,
      ADR3 => XLXI_1_I3_acc_c_0_6,
      O => CHOICE2923_GROM
    );
  CHOICE2923_XUSED : X_BUF
    port map (
      I => CHOICE2923_FROM,
      O => CHOICE2923
    );
  CHOICE2923_YUSED : X_BUF
    port map (
      I => CHOICE2923_GROM,
      O => CHOICE2967
    );
  XLXI_1_I2_pc_mux_x_0_79_3_251 : X_LUT4
    generic map(
      INIT => X"FAFA"
    )
    port map (
      ADR0 => CHOICE2381,
      ADR1 => VCC,
      ADR2 => CHOICE2367,
      ADR3 => VCC,
      O => XLXI_1_I2_pc_mux_x_0_79_3_FROM
    );
  XLXI_1_I1_n0021_4_65_SW1 : X_LUT4
    generic map(
      INIT => X"F0E4"
    )
    port map (
      ADR0 => CHOICE2381,
      ADR1 => XLXI_1_I1_stack_addrs_c_0_4,
      ADR2 => XLXI_1_I1_n0024(4),
      ADR3 => CHOICE2367,
      O => XLXI_1_I2_pc_mux_x_0_79_3_GROM
    );
  XLXI_1_I2_pc_mux_x_0_79_3_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_pc_mux_x_0_79_3_FROM,
      O => XLXI_1_I2_pc_mux_x_0_79_3
    );
  XLXI_1_I2_pc_mux_x_0_79_3_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_pc_mux_x_0_79_3_GROM,
      O => N44536
    );
  XLXI_1_I3_Mmux_data_x_Result_1_140_SW1 : X_LUT4
    generic map(
      INIT => X"E12D"
    )
    port map (
      ADR0 => XLXI_1_I4_n0037,
      ADR1 => XLXI_1_I3_n0025,
      ADR2 => XLXI_1_I3_acc_c_0_1,
      ADR3 => XLXI_1_I2_data_is_c(1),
      O => N43150_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_1_140_SW0 : X_LUT4
    generic map(
      INIT => X"C03F"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I3_n0025,
      ADR2 => XLXI_1_I2_data_is_c(1),
      ADR3 => XLXI_1_I3_acc_c_0_1,
      O => N43150_GROM
    );
  N43150_XUSED : X_BUF
    port map (
      I => N43150_FROM,
      O => N43150
    );
  N43150_YUSED : X_BUF
    port map (
      I => N43150_GROM,
      O => N43148
    );
  XLXI_1_I2_pc_mux_x_0_31 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => IDATA(0),
      ADR2 => VCC,
      ADR3 => IDATA(3),
      O => CHOICE2370_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_1_99_SW0 : X_LUT4
    generic map(
      INIT => X"FFFD"
    )
    port map (
      ADR0 => CHOICE2914,
      ADR1 => XLXI_1_skip,
      ADR2 => N43080,
      ADR3 => IDATA(3),
      O => CHOICE2370_GROM
    );
  CHOICE2370_XUSED : X_BUF
    port map (
      I => CHOICE2370_FROM,
      O => CHOICE2370
    );
  CHOICE2370_YUSED : X_BUF
    port map (
      I => CHOICE2370_GROM,
      O => N43486
    );
  XLXI_1_I1_stack_addrs_c_6_4_252 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0015(4),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_6_4_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_6_4
    );
  XLXI_1_I1_stack_addrs_c_6_4_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_6_4_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_5_0_253 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0016(0),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_5_0_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_5_0
    );
  XLXI_1_I1_stack_addrs_c_5_0_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_5_0_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_6_5_254 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0015(5),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_6_5_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_6_5
    );
  XLXI_1_I1_stack_addrs_c_6_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_6_5_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_5_1_255 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0016(1),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_5_1_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_5_1
    );
  XLXI_1_I1_stack_addrs_c_5_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_5_1_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_6_6_256 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0015(6),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_6_6_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_6_6
    );
  XLXI_1_I1_stack_addrs_c_6_6_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_6_6_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_5_2_257 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0016(2),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_5_2_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_5_2
    );
  XLXI_1_I1_stack_addrs_c_5_2_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_5_2_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_5_3_258 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0016(3),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_5_3_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_5_3
    );
  XLXI_1_I1_stack_addrs_c_5_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_5_3_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_6_7_259 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0015(7),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_6_7_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_6_7
    );
  XLXI_1_I1_stack_addrs_c_6_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_6_7_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_3_5_260 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0018(5),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_3_5_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_3_5
    );
  XLXI_1_I1_stack_addrs_c_3_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_3_5_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_4_9_261 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0017(9),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_4_9_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_4_9
    );
  XLXI_1_I1_stack_addrs_c_4_9_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_4_9_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_2_1_262 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0019(1),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_2_1_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_2_1
    );
  XLXI_1_I1_stack_addrs_c_2_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_2_1_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_3_6_263 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0018(6),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_3_6_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_3_6
    );
  XLXI_1_I1_stack_addrs_c_3_6_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_3_6_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_2_2_264 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0019(2),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_2_2_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_2_2
    );
  XLXI_1_I1_stack_addrs_c_2_2_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_2_2_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_2_3_265 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0019(3),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_2_3_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_2_3
    );
  XLXI_1_I1_stack_addrs_c_2_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_2_3_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_3_7_266 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0018(7),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_3_7_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_3_7
    );
  XLXI_1_I1_stack_addrs_c_3_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_3_7_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_1_8_267 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0020(8),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_1_8_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_1_8
    );
  XLXI_1_I1_stack_addrs_c_1_8_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_1_8_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_1_9_268 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0020(9),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_1_9_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_1_9
    );
  XLXI_1_I1_stack_addrs_c_1_9_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_1_9_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_6_0_269 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0015(0),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_6_0_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_6_0
    );
  XLXI_1_I1_stack_addrs_c_6_0_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_6_0_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_6_1_270 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0015(1),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_6_1_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_6_1
    );
  XLXI_1_I1_stack_addrs_c_6_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_6_1_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_6_2_271 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0015(2),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_6_2_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_6_2
    );
  XLXI_1_I1_stack_addrs_c_6_2_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_6_2_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_6_3_272 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0015(3),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_6_3_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_6_3
    );
  XLXI_1_I1_stack_addrs_c_6_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_6_3_FFX_RST
    );
  XLXI_1_I4_ireg_i_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_ireg_i_1_F5MUX,
      CE => XLXI_1_I4_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_ireg_i_1_FFX_RST,
      O => XLXI_1_I4_ireg_i(1)
    );
  XLXI_1_I4_ireg_i_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I4_ireg_i_1_FFX_RST
    );
  XLXI_1_I4_ireg_i_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_ireg_i_7_F5MUX,
      CE => XLXI_1_I4_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_ireg_i_7_FFX_RST,
      O => XLXI_1_I4_ireg_i(7)
    );
  XLXI_1_I4_ireg_i_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I4_ireg_i_7_FFX_RST
    );
  XLXI_1_I4_ireg_i_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_ireg_i_2_F5MUX,
      CE => XLXI_1_I4_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_ireg_i_2_FFX_RST,
      O => XLXI_1_I4_ireg_i(2)
    );
  XLXI_1_I4_ireg_i_2_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I4_ireg_i_2_FFX_RST
    );
  XLXI_1_I4_ireg_i_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_ireg_i_3_F5MUX,
      CE => XLXI_1_I4_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_ireg_i_3_FFX_RST,
      O => XLXI_1_I4_ireg_i(3)
    );
  XLXI_1_I4_ireg_i_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I4_ireg_i_3_FFX_RST
    );
  XLXI_1_I4_ireg_i_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_ireg_i_4_F5MUX,
      CE => XLXI_1_I4_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_ireg_i_4_FFX_RST,
      O => XLXI_1_I4_ireg_i(4)
    );
  XLXI_1_I4_ireg_i_4_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I4_ireg_i_4_FFX_RST
    );
  XLXI_1_I4_ireg_i_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_ireg_i_5_F5MUX,
      CE => XLXI_1_I4_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_ireg_i_5_FFX_RST,
      O => XLXI_1_I4_ireg_i(5)
    );
  XLXI_1_I4_ireg_i_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I4_ireg_i_5_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_1_0_273 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0020(0),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_1_0_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_1_0
    );
  XLXI_1_I1_stack_addrs_c_1_0_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_1_0_FFX_RST
    );
  XLXI_1_I4_ireg_i_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_ireg_i_6_F5MUX,
      CE => XLXI_1_I4_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_ireg_i_6_FFX_RST,
      O => XLXI_1_I4_ireg_i(6)
    );
  XLXI_1_I4_ireg_i_6_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I4_ireg_i_6_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_5_7_274 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0016(7),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_5_7_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_5_7
    );
  XLXI_1_I1_stack_addrs_c_5_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_5_7_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_4_3_275 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0017(3),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_4_3_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_4_3
    );
  XLXI_1_I1_stack_addrs_c_4_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_4_3_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_4_4_276 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0017(4),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_4_4_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_4_4
    );
  XLXI_1_I1_stack_addrs_c_4_4_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_4_4_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_5_8_277 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0016(8),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_5_8_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_5_8
    );
  XLXI_1_I1_stack_addrs_c_5_8_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_5_8_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_3_0_278 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0018(0),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_3_0_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_3_0
    );
  XLXI_1_I1_stack_addrs_c_3_0_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_3_0_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_5_9_279 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0016(9),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_5_9_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_5_9
    );
  XLXI_1_I1_stack_addrs_c_5_9_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_5_9_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_4_5_280 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0017(5),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_4_5_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_4_5
    );
  XLXI_1_I1_stack_addrs_c_4_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_4_5_FFX_RST
    );
  XLXI_26_n01181 : X_LUT4
    generic map(
      INIT => X"0044"
    )
    port map (
      ADR0 => XLXI_26_rx_bit_count(2),
      ADR1 => XLXI_26_N16197,
      ADR2 => VCC,
      ADR3 => XLXI_26_rx_bit_count(1),
      O => XLXI_26_n0118_FROM
    );
  XLXI_26_n0102_SW0 : X_LUT4
    generic map(
      INIT => X"FFF7"
    )
    port map (
      ADR0 => XLXI_26_rx_bit_count(3),
      ADR1 => XLXI_26_rx_s_FFd2,
      ADR2 => XLXI_26_rx_bit_count(2),
      ADR3 => XLXI_26_rx_bit_count(1),
      O => XLXI_26_n0118_GROM
    );
  XLXI_26_n0118_XUSED : X_BUF
    port map (
      I => XLXI_26_n0118_FROM,
      O => XLXI_26_n0118
    );
  XLXI_26_n0118_YUSED : X_BUF
    port map (
      I => XLXI_26_n0118_GROM,
      O => N29615
    );
  XLXI_1_I3_n0115_7_13_SW0 : X_LUT4
    generic map(
      INIT => X"DDCC"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c_3_1,
      ADR1 => CHOICE2950,
      ADR2 => VCC,
      ADR3 => XLXI_1_I3_n0076,
      O => N43306_FROM
    );
  XLXI_1_I3_n0115_6_13_SW1 : X_LUT4
    generic map(
      INIT => X"EAFA"
    )
    port map (
      ADR0 => CHOICE2886,
      ADR1 => XLXI_1_I3_acc_c_0_6,
      ADR2 => XLXI_1_I3_n0076,
      ADR3 => XLXI_1_I2_TD_c_3_1,
      O => N43306_GROM
    );
  N43306_XUSED : X_BUF
    port map (
      I => N43306_FROM,
      O => N43306
    );
  N43306_YUSED : X_BUF
    port map (
      I => N43306_GROM,
      O => N43332
    );
  XLXI_5_n0005_0_10 : X_LUT4
    generic map(
      INIT => X"CCA0"
    )
    port map (
      ADR0 => XLXI_5_n0016(0),
      ADR1 => XLXI_5_tmr_count(0),
      ADR2 => XLXI_5_n0015,
      ADR3 => XLXI_5_n0010,
      O => XLXI_5_tmr_high_0_FROM
    );
  XLXI_5_n0005_0_47 : X_LUT4
    generic map(
      INIT => X"3230"
    )
    port map (
      ADR0 => XLXI_5_tmr_enable,
      ADR1 => XLXI_5_tmr_reset,
      ADR2 => CHOICE860,
      ADR3 => CHOICE853,
      O => XLXI_5_n0005(0)
    );
  XLXI_5_tmr_high_0_XUSED : X_BUF
    port map (
      I => XLXI_5_tmr_high_0_FROM,
      O => CHOICE853
    );
  XLXI_5_tmr_high_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_5_tmr_high_0_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_Mmux_data_x_Result_6_0 : X_LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c_1_1,
      ADR1 => XLXI_1_I2_data_is_c(6),
      ADR2 => XLXI_1_I2_TC_c_0_1,
      ADR3 => XLXI_1_I2_TC_c_2_1,
      O => CHOICE2537_FROM
    );
  XLXI_1_I3_n0115_6_13_SW2 : X_LUT4
    generic map(
      INIT => X"1400"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c_2_1,
      ADR1 => XLXI_1_I2_TC_c_1_1,
      ADR2 => XLXI_1_I2_TC_c_0_1,
      ADR3 => XLXI_1_I3_acc_c_0_6,
      O => CHOICE2537_GROM
    );
  CHOICE2537_XUSED : X_BUF
    port map (
      I => CHOICE2537_FROM,
      O => CHOICE2537
    );
  CHOICE2537_YUSED : X_BUF
    port map (
      I => CHOICE2537_GROM,
      O => N43394
    );
  XLXI_5_n0005_7_31 : X_LUT4
    generic map(
      INIT => X"70F0"
    )
    port map (
      ADR0 => XLXI_5_tmr_enable,
      ADR1 => CHOICE870,
      ADR2 => CPU_DATA_OUT(7),
      ADR3 => CHOICE877,
      O => CHOICE1007_FROM
    );
  XLXI_5_n0005_0_30 : X_LUT4
    generic map(
      INIT => X"4CCC"
    )
    port map (
      ADR0 => CHOICE877,
      ADR1 => CPU_DATA_OUT(0),
      ADR2 => XLXI_5_tmr_enable,
      ADR3 => CHOICE870,
      O => CHOICE1007_GROM
    );
  CHOICE1007_XUSED : X_BUF
    port map (
      I => CHOICE1007_FROM,
      O => CHOICE1007
    );
  CHOICE1007_YUSED : X_BUF
    port map (
      I => CHOICE1007_GROM,
      O => CHOICE860
    );
  XLXI_1_I3_Mmux_data_x_Result_5_140_SW3 : X_LUT4
    generic map(
      INIT => X"A599"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_5,
      ADR1 => XLXI_1_I4_n00371_1,
      ADR2 => XLXI_1_I2_data_is_c(5),
      ADR3 => XLXI_1_I3_n0025,
      O => N43216_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_5_140_SW0 : X_LUT4
    generic map(
      INIT => X"C333"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I3_acc_c_0_5,
      ADR2 => XLXI_1_I2_data_is_c(5),
      ADR3 => XLXI_1_I3_n0025,
      O => N43216_GROM
    );
  N43216_XUSED : X_BUF
    port map (
      I => N43216_FROM,
      O => N43216
    );
  N43216_YUSED : X_BUF
    port map (
      I => N43216_GROM,
      O => N43172
    );
  XLXI_1_I3_Mmux_data_x_Result_6_140_SW3 : X_LUT4
    generic map(
      INIT => X"99A5"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_6,
      ADR1 => XLXI_1_I2_data_is_c(6),
      ADR2 => XLXI_1_I4_n00371_1,
      ADR3 => XLXI_1_I3_n0025,
      O => N43222_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_5_140_SW1 : X_LUT4
    generic map(
      INIT => X"D827"
    )
    port map (
      ADR0 => XLXI_1_I3_n0025,
      ADR1 => XLXI_1_I2_data_is_c(5),
      ADR2 => XLXI_1_I4_n00371_1,
      ADR3 => XLXI_1_I3_acc_c_0_5,
      O => N43222_GROM
    );
  N43222_XUSED : X_BUF
    port map (
      I => N43222_FROM,
      O => N43222
    );
  N43222_YUSED : X_BUF
    port map (
      I => N43222_GROM,
      O => N43174
    );
  XLXI_5_n0005_1_11 : X_LUT4
    generic map(
      INIT => X"F808"
    )
    port map (
      ADR0 => XLXI_5_n0015,
      ADR1 => XLXI_5_n0016(1),
      ADR2 => XLXI_5_n0010,
      ADR3 => XLXI_5_tmr_count(1),
      O => XLXI_5_tmr_high_1_FROM
    );
  XLXI_5_n0005_1_48 : X_LUT4
    generic map(
      INIT => X"3230"
    )
    port map (
      ADR0 => XLXI_5_tmr_enable,
      ADR1 => XLXI_5_tmr_reset,
      ADR2 => CHOICE906,
      ADR3 => CHOICE899,
      O => XLXI_5_n0005(1)
    );
  XLXI_5_tmr_high_1_XUSED : X_BUF
    port map (
      I => XLXI_5_tmr_high_1_FROM,
      O => CHOICE899
    );
  XLXI_5_tmr_high_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_5_tmr_high_1_SRMUX_OUTPUTNOT
    );
  XLXI_5_n0005_2_31 : X_LUT4
    generic map(
      INIT => X"7F00"
    )
    port map (
      ADR0 => XLXI_5_tmr_enable,
      ADR1 => CHOICE877,
      ADR2 => CHOICE870,
      ADR3 => CPU_DATA_OUT(2),
      O => CHOICE921_FROM
    );
  XLXI_5_n0005_1_31 : X_LUT4
    generic map(
      INIT => X"7F00"
    )
    port map (
      ADR0 => CHOICE877,
      ADR1 => CHOICE870,
      ADR2 => XLXI_5_tmr_enable,
      ADR3 => CPU_DATA_OUT(1),
      O => CHOICE921_GROM
    );
  CHOICE921_XUSED : X_BUF
    port map (
      I => CHOICE921_FROM,
      O => CHOICE921
    );
  CHOICE921_YUSED : X_BUF
    port map (
      I => CHOICE921_GROM,
      O => CHOICE906
    );
  XLXI_5_n0005_2_11 : X_LUT4
    generic map(
      INIT => X"F808"
    )
    port map (
      ADR0 => XLXI_5_n0015,
      ADR1 => XLXI_5_n0016(2),
      ADR2 => XLXI_5_n0010,
      ADR3 => XLXI_5_tmr_count(2),
      O => XLXI_5_tmr_high_2_FROM
    );
  XLXI_5_n0005_2_48 : X_LUT4
    generic map(
      INIT => X"0E0A"
    )
    port map (
      ADR0 => CHOICE921,
      ADR1 => XLXI_5_tmr_enable,
      ADR2 => XLXI_5_tmr_reset,
      ADR3 => CHOICE914,
      O => XLXI_5_n0005(2)
    );
  XLXI_5_tmr_high_2_XUSED : X_BUF
    port map (
      I => XLXI_5_tmr_high_2_FROM,
      O => CHOICE914
    );
  XLXI_5_tmr_high_2_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_5_tmr_high_2_SRMUX_OUTPUTNOT
    );
  XLXI_5_n0005_3_11 : X_LUT4
    generic map(
      INIT => X"E4A0"
    )
    port map (
      ADR0 => XLXI_5_n0010,
      ADR1 => XLXI_5_n0016(3),
      ADR2 => XLXI_5_tmr_count(3),
      ADR3 => XLXI_5_n0015,
      O => XLXI_5_tmr_high_3_FROM
    );
  XLXI_5_n0005_3_48 : X_LUT4
    generic map(
      INIT => X"5444"
    )
    port map (
      ADR0 => XLXI_5_tmr_reset,
      ADR1 => CHOICE936,
      ADR2 => XLXI_5_tmr_enable,
      ADR3 => CHOICE929,
      O => XLXI_5_n0005(3)
    );
  XLXI_5_tmr_high_3_XUSED : X_BUF
    port map (
      I => XLXI_5_tmr_high_3_FROM,
      O => CHOICE929
    );
  XLXI_5_tmr_high_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_5_tmr_high_3_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_uart_ovr_d_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_uart_ovr_d_SRMUX_OUTPUTNOT
    );
  XLXI_5_n0005_6_31 : X_LUT4
    generic map(
      INIT => X"70F0"
    )
    port map (
      ADR0 => CHOICE870,
      ADR1 => XLXI_5_tmr_enable,
      ADR2 => CPU_DATA_OUT(6),
      ADR3 => CHOICE877,
      O => CHOICE992_FROM
    );
  XLXI_5_n0005_3_31 : X_LUT4
    generic map(
      INIT => X"2AAA"
    )
    port map (
      ADR0 => CPU_DATA_OUT(3),
      ADR1 => XLXI_5_tmr_enable,
      ADR2 => CHOICE870,
      ADR3 => CHOICE877,
      O => CHOICE992_GROM
    );
  CHOICE992_XUSED : X_BUF
    port map (
      I => CHOICE992_FROM,
      O => CHOICE992
    );
  CHOICE992_YUSED : X_BUF
    port map (
      I => CHOICE992_GROM,
      O => CHOICE936
    );
  XLXI_5_n0005_4_11 : X_LUT4
    generic map(
      INIT => X"F088"
    )
    port map (
      ADR0 => XLXI_5_n0016(4),
      ADR1 => XLXI_5_n0015,
      ADR2 => XLXI_5_tmr_count(4),
      ADR3 => XLXI_5_n0010,
      O => XLXI_5_tmr_high_4_FROM
    );
  XLXI_5_n0005_4_48 : X_LUT4
    generic map(
      INIT => X"5444"
    )
    port map (
      ADR0 => XLXI_5_tmr_reset,
      ADR1 => CHOICE951,
      ADR2 => XLXI_5_tmr_enable,
      ADR3 => CHOICE944,
      O => XLXI_5_n0005(4)
    );
  XLXI_5_tmr_high_4_XUSED : X_BUF
    port map (
      I => XLXI_5_tmr_high_4_FROM,
      O => CHOICE944
    );
  XLXI_5_tmr_high_4_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_5_tmr_high_4_SRMUX_OUTPUTNOT
    );
  XLXI_1_I2_TD_x_0_26 : X_LUT4
    generic map(
      INIT => X"0303"
    )
    port map (
      ADR0 => VCC,
      ADR1 => IDATA(1),
      ADR2 => IDATA(2),
      ADR3 => VCC,
      O => CHOICE1073_FROM
    );
  XLXI_1_I2_pc_mux_x_0_2 : X_LUT4
    generic map(
      INIT => X"FFF3"
    )
    port map (
      ADR0 => VCC,
      ADR1 => IDATA(3),
      ADR2 => IDATA(2),
      ADR3 => IDATA(1),
      O => CHOICE1073_GROM
    );
  CHOICE1073_XUSED : X_BUF
    port map (
      I => CHOICE1073_FROM,
      O => CHOICE1073
    );
  CHOICE1073_YUSED : X_BUF
    port map (
      I => CHOICE1073_GROM,
      O => CHOICE2359
    );
  XLXI_5_n0005_5_11 : X_LUT4
    generic map(
      INIT => X"AAC0"
    )
    port map (
      ADR0 => XLXI_5_tmr_count(5),
      ADR1 => XLXI_5_n0016(5),
      ADR2 => XLXI_5_n0015,
      ADR3 => XLXI_5_n0010,
      O => XLXI_5_tmr_high_5_FROM
    );
  XLXI_5_n0005_5_48 : X_LUT4
    generic map(
      INIT => X"5444"
    )
    port map (
      ADR0 => XLXI_5_tmr_reset,
      ADR1 => CHOICE977,
      ADR2 => XLXI_5_tmr_enable,
      ADR3 => CHOICE970,
      O => XLXI_5_n0005(5)
    );
  XLXI_5_tmr_high_5_XUSED : X_BUF
    port map (
      I => XLXI_5_tmr_high_5_FROM,
      O => CHOICE970
    );
  XLXI_5_tmr_high_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_5_tmr_high_5_SRMUX_OUTPUTNOT
    );
  XLXI_1_I2_TD_x_0_2 : X_LUT4
    generic map(
      INIT => X"F0C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => IDATA(2),
      ADR2 => IDATA(0),
      ADR3 => IDATA(1),
      O => CHOICE1061_FROM
    );
  XLXI_1_I2_pc_mux_x_1_5 : X_LUT4
    generic map(
      INIT => X"C0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I2_N18844,
      ADR2 => IDATA(3),
      ADR3 => IDATA(0),
      O => CHOICE1061_GROM
    );
  CHOICE1061_XUSED : X_BUF
    port map (
      I => CHOICE1061_FROM,
      O => CHOICE1061
    );
  CHOICE1061_YUSED : X_BUF
    port map (
      I => CHOICE1061_GROM,
      O => CHOICE1126
    );
  XLXI_3_reg_data_out_x_6_SW0 : X_LUT4
    generic map(
      INIT => X"F0CC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => IN0_REG_6_IBUF,
      ADR2 => IN1_REG_6_IBUF,
      ADR3 => CPU_ADDR_OUT(0),
      O => N29051_FROM
    );
  XLXI_3_reg_data_out_x_4_SW0 : X_LUT4
    generic map(
      INIT => X"CFC0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => IN1_REG_4_IBUF,
      ADR2 => CPU_ADDR_OUT(0),
      ADR3 => IN0_REG_4_IBUF,
      O => N29051_GROM
    );
  N29051_XUSED : X_BUF
    port map (
      I => N29051_FROM,
      O => N29051
    );
  N29051_YUSED : X_BUF
    port map (
      I => N29051_GROM,
      O => N29203
    );
  XLXI_5_n00301 : X_LUT4
    generic map(
      INIT => X"FEFE"
    )
    port map (
      ADR0 => XLXI_5_tmr_enable,
      ADR1 => XLXI_5_tmr_reset,
      ADR2 => XLXI_5_N14552,
      ADR3 => VCC,
      O => XLXI_5_n0030_FROM
    );
  XLXI_5_n0005_5_31 : X_LUT4
    generic map(
      INIT => X"4CCC"
    )
    port map (
      ADR0 => CHOICE877,
      ADR1 => CPU_DATA_OUT(5),
      ADR2 => CHOICE870,
      ADR3 => XLXI_5_tmr_enable,
      O => XLXI_5_n0030_GROM
    );
  XLXI_5_n0030_XUSED : X_BUF
    port map (
      I => XLXI_5_n0030_FROM,
      O => XLXI_5_n0030
    );
  XLXI_5_n0030_YUSED : X_BUF
    port map (
      I => XLXI_5_n0030_GROM,
      O => CHOICE977
    );
  XLXI_1_I3_n0115_5_72_SW1 : X_LUT4
    generic map(
      INIT => X"E020"
    )
    port map (
      ADR0 => N43324,
      ADR1 => CHOICE2800,
      ADR2 => XLXI_1_I3_n00231_1,
      ADR3 => N43326,
      O => N43264_FROM
    );
  XLXI_1_I3_n0115_5_72_SW0 : X_LUT4
    generic map(
      INIT => X"F800"
    )
    port map (
      ADR0 => N43398,
      ADR1 => CHOICE2800,
      ADR2 => CHOICE2822,
      ADR3 => XLXI_1_I3_n00231_1,
      O => N43264_GROM
    );
  N43264_XUSED : X_BUF
    port map (
      I => N43264_FROM,
      O => N43264
    );
  N43264_YUSED : X_BUF
    port map (
      I => N43264_GROM,
      O => N43262
    );
  XLXI_1_I1_iaddr_x_4_60_SW0 : X_LUT4
    generic map(
      INIT => X"CEDF"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(0),
      ADR1 => XLXI_1_pc_mux(1),
      ADR2 => XLXI_1_I1_n0024(4),
      ADR3 => XLXI_1_I1_pc(4),
      O => N43796_FROM
    );
  XLXI_1_I1_iaddr_x_8_60_SW0 : X_LUT4
    generic map(
      INIT => X"CDEF"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(0),
      ADR1 => XLXI_1_pc_mux(1),
      ADR2 => XLXI_1_I1_pc(8),
      ADR3 => XLXI_1_I1_n0024(8),
      O => N43796_GROM
    );
  N43796_XUSED : X_BUF
    port map (
      I => N43796_FROM,
      O => N43796
    );
  N43796_YUSED : X_BUF
    port map (
      I => N43796_GROM,
      O => N43792
    );
  XLXI_5_n0005_6_11 : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => XLXI_5_n0010,
      ADR1 => XLXI_5_tmr_count(6),
      ADR2 => XLXI_5_n0015,
      ADR3 => XLXI_5_n0016(6),
      O => XLXI_5_tmr_high_6_FROM
    );
  XLXI_5_n0005_6_48 : X_LUT4
    generic map(
      INIT => X"0E0A"
    )
    port map (
      ADR0 => CHOICE992,
      ADR1 => XLXI_5_tmr_enable,
      ADR2 => XLXI_5_tmr_reset,
      ADR3 => CHOICE985,
      O => XLXI_5_n0005(6)
    );
  XLXI_5_tmr_high_6_XUSED : X_BUF
    port map (
      I => XLXI_5_tmr_high_6_FROM,
      O => CHOICE985
    );
  XLXI_5_tmr_high_6_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_5_tmr_high_6_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_uart_full_d_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_uart_full_d_SRMUX_OUTPUTNOT
    );
  XLXI_5_n0005_7_11 : X_LUT4
    generic map(
      INIT => X"E4A0"
    )
    port map (
      ADR0 => XLXI_5_n0010,
      ADR1 => XLXI_5_n0016(7),
      ADR2 => XLXI_5_tmr_count(7),
      ADR3 => XLXI_5_n0015,
      O => XLXI_5_tmr_high_7_FROM
    );
  XLXI_5_n0005_7_48 : X_LUT4
    generic map(
      INIT => X"0E0A"
    )
    port map (
      ADR0 => CHOICE1007,
      ADR1 => XLXI_5_tmr_enable,
      ADR2 => XLXI_5_tmr_reset,
      ADR3 => CHOICE1000,
      O => XLXI_5_n0005(7)
    );
  XLXI_5_tmr_high_7_XUSED : X_BUF
    port map (
      I => XLXI_5_tmr_high_7_FROM,
      O => CHOICE1000
    );
  XLXI_5_tmr_high_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_5_tmr_high_7_SRMUX_OUTPUTNOT
    );
  XLXI_3_reg_data_out_x_5_SW0 : X_LUT4
    generic map(
      INIT => X"AACC"
    )
    port map (
      ADR0 => IN1_REG_5_IBUF,
      ADR1 => IN0_REG_5_IBUF,
      ADR2 => VCC,
      ADR3 => CPU_ADDR_OUT(0),
      O => N29124_GROM
    );
  N29124_YUSED : X_BUF
    port map (
      I => N29124_GROM,
      O => N29124
    );
  XLXI_1_I4_n00331 : X_LUT4
    generic map(
      INIT => X"A0A0"
    )
    port map (
      ADR0 => NRESET_BUFGP,
      ADR1 => VCC,
      ADR2 => XLXI_1_I2_int_start_c,
      ADR3 => VCC,
      O => XLXI_1_I4_n0033_GROM
    );
  XLXI_1_I4_n0033_YUSED : X_BUF
    port map (
      I => XLXI_1_I4_n0033_GROM,
      O => XLXI_1_I4_n0033
    );
  XLXI_6_n00071 : X_LUT4
    generic map(
      INIT => X"A080"
    )
    port map (
      ADR0 => XLXI_6_n0028,
      ADR1 => XLXI_6_tx_s(0),
      ADR2 => NRESET_BUFGP,
      ADR3 => XLXI_6_tx_uart_busy,
      O => XLXI_6_n0007_FROM
    );
  XLXI_6_n0056_281 : X_LUT4
    generic map(
      INIT => X"D800"
    )
    port map (
      ADR0 => XLXI_6_tx_s(0),
      ADR1 => N29672,
      ADR2 => XLXI_6_tx_uart_busy,
      ADR3 => XLXI_6_n0028,
      O => XLXI_6_n0007_GROM
    );
  XLXI_6_n0007_XUSED : X_BUF
    port map (
      I => XLXI_6_n0007_FROM,
      O => XLXI_6_n0007
    );
  XLXI_6_n0007_YUSED : X_BUF
    port map (
      I => XLXI_6_n0007_GROM,
      O => XLXI_6_n0056
    );
  XLXI_1_I3_Mmux_data_x_Result_5_7 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_4_int_pending_c(5),
      ADR1 => XLXI_55_mux_c(4),
      ADR2 => XLXI_55_mux_c(1),
      ADR3 => XLXI_26_rx_uart_fifo(5),
      O => CHOICE2606_FROM
    );
  XLXI_4_int_ext4 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => XLXI_4_int_pending_c(4),
      ADR1 => XLXI_4_int_pending_c(3),
      ADR2 => XLXI_4_int_pending_c(5),
      ADR3 => XLXI_4_int_pending_c(2),
      O => CHOICE2606_GROM
    );
  CHOICE2606_XUSED : X_BUF
    port map (
      I => CHOICE2606_FROM,
      O => CHOICE2606
    );
  CHOICE2606_YUSED : X_BUF
    port map (
      I => CHOICE2606_GROM,
      O => CHOICE1108
    );
  XLXI_4_int_ext9 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => XLXI_4_int_pending_c(0),
      ADR1 => XLXI_4_int_pending_c(6),
      ADR2 => XLXI_4_int_pending_c(1),
      ADR3 => XLXI_4_int_pending_c(7),
      O => CHOICE1111_FROM
    );
  XLXI_1_I2_Ker188421 : X_LUT4
    generic map(
      INIT => X"F5F7"
    )
    port map (
      ADR0 => XLXI_1_I2_S_c(1),
      ADR1 => CHOICE1108,
      ADR2 => XLXI_1_I2_int_stop_c,
      ADR3 => CHOICE1111,
      O => CHOICE1111_GROM
    );
  CHOICE1111_XUSED : X_BUF
    port map (
      I => CHOICE1111_FROM,
      O => CHOICE1111
    );
  CHOICE1111_YUSED : X_BUF
    port map (
      I => CHOICE1111_GROM,
      O => XLXI_1_I2_N18844
    );
  XLXI_55_nCS_REG_SW114_SW5 : X_LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      ADR0 => XLXI_1_I4_N21762,
      ADR1 => N43366,
      ADR2 => XLXI_1_ndre_int,
      ADR3 => XLXI_1_adaddr_out(3),
      O => N43118_FROM
    );
  XLXI_55_nCS_REG_SW114_SW3 : X_LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      ADR0 => XLXI_1_I4_N21762,
      ADR1 => N43358,
      ADR2 => XLXI_1_ndre_int,
      ADR3 => XLXI_1_adaddr_out(3),
      O => N43118_GROM
    );
  N43118_XUSED : X_BUF
    port map (
      I => N43118_FROM,
      O => N43118
    );
  N43118_YUSED : X_BUF
    port map (
      I => N43118_GROM,
      O => N43110
    );
  XLXI_1_I2_pc_mux_x_0_79_2_282 : X_LUT4
    generic map(
      INIT => X"FFAA"
    )
    port map (
      ADR0 => CHOICE2381,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => CHOICE2367,
      O => XLXI_1_I2_pc_mux_x_0_79_2_FROM
    );
  XLXI_1_I1_n0021_5_65_SW1 : X_LUT4
    generic map(
      INIT => X"CCCA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_0_5,
      ADR1 => XLXI_1_I1_n0024(5),
      ADR2 => CHOICE2367,
      ADR3 => CHOICE2381,
      O => XLXI_1_I2_pc_mux_x_0_79_2_GROM
    );
  XLXI_1_I2_pc_mux_x_0_79_2_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_pc_mux_x_0_79_2_FROM,
      O => XLXI_1_I2_pc_mux_x_0_79_2
    );
  XLXI_1_I2_pc_mux_x_0_79_2_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_pc_mux_x_0_79_2_GROM,
      O => N44520
    );
  XLXI_55_nCS_REG_SW114_SW6 : X_LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      ADR0 => XLXI_1_ndre_int,
      ADR1 => XLXI_1_I4_N21762,
      ADR2 => N43370,
      ADR3 => XLXI_1_adaddr_out(3),
      O => N43122_FROM
    );
  XLXI_55_nCS_REG_SW114_SW4 : X_LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      ADR0 => XLXI_1_I4_N21762,
      ADR1 => N43362,
      ADR2 => XLXI_1_ndre_int,
      ADR3 => XLXI_1_adaddr_out(3),
      O => N43122_GROM
    );
  N43122_XUSED : X_BUF
    port map (
      I => N43122_FROM,
      O => N43122
    );
  N43122_YUSED : X_BUF
    port map (
      I => N43122_GROM,
      O => N43114
    );
  XLXI_1_I4_daddr_x_3_1_SW2 : X_LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      ADR0 => XLXI_1_ndre_int,
      ADR1 => N43346,
      ADR2 => XLXI_1_I4_ireg_c(3),
      ADR3 => XLXI_1_I4_n0037,
      O => N43497_FROM
    );
  XLXI_55_nCS_REG_SW114_SW7 : X_LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      ADR0 => N43374,
      ADR1 => XLXI_1_ndre_int,
      ADR2 => XLXI_1_I4_N21762,
      ADR3 => XLXI_1_adaddr_out(3),
      O => N43497_GROM
    );
  N43497_XUSED : X_BUF
    port map (
      I => N43497_FROM,
      O => N43497
    );
  N43497_YUSED : X_BUF
    port map (
      I => N43497_GROM,
      O => N43132
    );
  XLXI_1_I3_n0115_2_13_SW2 : X_LUT4
    generic map(
      INIT => X"1020"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c_0_1,
      ADR1 => XLXI_1_I2_TC_c_2_1,
      ADR2 => XLXI_1_I3_acc_c_0_2,
      ADR3 => XLXI_1_I2_TC_c_1_1,
      O => N43410_FROM
    );
  XLXI_1_I3_Ker201201 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c(3),
      ADR1 => XLXI_1_I2_TC_c_0_1,
      ADR2 => XLXI_1_I2_TC_c_2_1,
      ADR3 => XLXI_1_I2_TC_c_1_1,
      O => N43410_GROM
    );
  N43410_XUSED : X_BUF
    port map (
      I => N43410_FROM,
      O => N43410
    );
  N43410_YUSED : X_BUF
    port map (
      I => N43410_GROM,
      O => XLXI_1_I3_N20122
    );
  XLXI_1_I3_Mmux_data_x_Result_7_0 : X_LUT4
    generic map(
      INIT => X"0200"
    )
    port map (
      ADR0 => XLXI_1_I2_data_is_c(7),
      ADR1 => XLXI_1_I2_TC_c_0_1,
      ADR2 => XLXI_1_I2_TC_c_2_1,
      ADR3 => XLXI_1_I2_TC_c_1_1,
      O => CHOICE2473_FROM
    );
  XLXI_1_I3_n0115_7_13_SW2 : X_LUT4
    generic map(
      INIT => X"0208"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_7,
      ADR1 => XLXI_1_I2_TC_c_1_1,
      ADR2 => XLXI_1_I2_TC_c_2_1,
      ADR3 => XLXI_1_I2_TC_c_0_1,
      O => CHOICE2473_GROM
    );
  CHOICE2473_XUSED : X_BUF
    port map (
      I => CHOICE2473_FROM,
      O => CHOICE2473
    );
  CHOICE2473_YUSED : X_BUF
    port map (
      I => CHOICE2473_GROM,
      O => N43390
    );
  XLXI_1_I2_Ker19014_SW1 : X_LUT4
    generic map(
      INIT => X"3FBF"
    )
    port map (
      ADR0 => XLXI_1_I3_skip_l,
      ADR1 => XLXI_1_I2_S_c(2),
      ADR2 => IDATA(4),
      ADR3 => XLXI_1_I2_int_start_c,
      O => N44420_FROM
    );
  XLXI_1_I2_Ker19014 : X_LUT4
    generic map(
      INIT => X"0010"
    )
    port map (
      ADR0 => IDATA(1),
      ADR1 => IDATA(2),
      ADR2 => XLXI_1_I2_N18949,
      ADR3 => N44420,
      O => N44420_GROM
    );
  N44420_XUSED : X_BUF
    port map (
      I => N44420_FROM,
      O => N44420
    );
  N44420_YUSED : X_BUF
    port map (
      I => N44420_GROM,
      O => XLXI_1_I2_N19016
    );
  XLXI_1_I3_Mmux_data_x_Result_0_86 : X_LUT4
    generic map(
      INIT => X"5808"
    )
    port map (
      ADR0 => IDATA(5),
      ADR1 => XLXI_1_I4_iinc_c(0),
      ADR2 => IDATA(4),
      ADR3 => XLXI_1_I4_ireg_c(0),
      O => CHOICE2993_FROM
    );
  XLXI_1_I4_daddr_x_0_SW0 : X_LUT4
    generic map(
      INIT => X"AAFF"
    )
    port map (
      ADR0 => IDATA(5),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_1_I4_ireg_c(0),
      O => CHOICE2993_GROM
    );
  CHOICE2993_XUSED : X_BUF
    port map (
      I => CHOICE2993_FROM,
      O => CHOICE2993
    );
  CHOICE2993_YUSED : X_BUF
    port map (
      I => CHOICE2993_GROM,
      O => N29016
    );
  XLXI_6_tx_uart_fifo_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_uart_fifo_1_SRMUX_OUTPUTNOT
    );
  XLXI_6_tx_uart_fifo_3_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_6_tx_uart_fifo_3_SRMUX_OUTPUTNOT,
      O => XLXI_6_tx_uart_fifo_3_FFY_SET
    );
  XLXI_6_tx_uart_fifo_2 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => CPU_DATA_OUT(2),
      CE => XLXI_6_n0023,
      CLK => UCLK_BUFGP,
      SET => XLXI_6_tx_uart_fifo_3_FFY_SET,
      RST => GND,
      O => XLXI_6_tx_uart_fifo(2)
    );
  XLXI_6_tx_uart_fifo_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_uart_fifo_3_SRMUX_OUTPUTNOT
    );
  XLXI_6_tx_uart_fifo_5_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_6_tx_uart_fifo_5_SRMUX_OUTPUTNOT,
      O => XLXI_6_tx_uart_fifo_5_FFY_SET
    );
  XLXI_6_tx_uart_fifo_4 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => CPU_DATA_OUT(4),
      CE => XLXI_6_n0023,
      CLK => UCLK_BUFGP,
      SET => XLXI_6_tx_uart_fifo_5_FFY_SET,
      RST => GND,
      O => XLXI_6_tx_uart_fifo(4)
    );
  XLXI_6_tx_uart_fifo_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_uart_fifo_5_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_daddr_x_3_1_SW3 : X_LUT4
    generic map(
      INIT => X"FFBF"
    )
    port map (
      ADR0 => N43346,
      ADR1 => IDATA(7),
      ADR2 => XLXI_1_I4_n0037,
      ADR3 => XLXI_1_ndre_int,
      O => N43499_FROM
    );
  XLXI_1_I4_daddr_x_3_1_SW0 : X_LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      ADR0 => N43350,
      ADR1 => XLXI_1_ndre_int,
      ADR2 => XLXI_1_I4_ireg_c(3),
      ADR3 => XLXI_1_I4_n0037,
      O => N43499_GROM
    );
  N43499_XUSED : X_BUF
    port map (
      I => N43499_FROM,
      O => N43499
    );
  N43499_YUSED : X_BUF
    port map (
      I => N43499_GROM,
      O => N43491
    );
  XLXI_6_tx_uart_fifo_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_uart_fifo_7_SRMUX_OUTPUTNOT
    );
  XLXI_6_n002812 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_6_tx_clk_count(0),
      ADR1 => XLXI_6_tx_clk_count(2),
      ADR2 => XLXI_6_tx_clk_count(1),
      ADR3 => XLXI_6_tx_clk_count(3),
      O => CHOICE1017_GROM
    );
  CHOICE1017_YUSED : X_BUF
    port map (
      I => CHOICE1017_GROM,
      O => CHOICE1017
    );
  XLXI_6_n002825 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_6_tx_clk_count(7),
      ADR1 => XLXI_6_tx_clk_count(6),
      ADR2 => XLXI_6_tx_clk_count(4),
      ADR3 => XLXI_6_tx_clk_count(5),
      O => CHOICE1024_FROM
    );
  XLXI_6_n00611 : X_LUT4
    generic map(
      INIT => X"4000"
    )
    port map (
      ADR0 => XLXI_6_tx_s(0),
      ADR1 => XLXI_6_tx_uart_busy,
      ADR2 => CHOICE1017,
      ADR3 => CHOICE1024,
      O => CHOICE1024_GROM
    );
  CHOICE1024_XUSED : X_BUF
    port map (
      I => CHOICE1024_FROM,
      O => CHOICE1024
    );
  CHOICE1024_YUSED : X_BUF
    port map (
      I => CHOICE1024_GROM,
      O => XLXI_6_n0061
    );
  XLXI_6_n002826 : X_LUT4
    generic map(
      INIT => X"C0C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CHOICE1024,
      ADR2 => CHOICE1017,
      ADR3 => VCC,
      O => XLXI_6_n0028_FROM
    );
  XLXI_6_n00551 : X_LUT4
    generic map(
      INIT => X"CA00"
    )
    port map (
      ADR0 => XLXI_6_tx_uart_busy,
      ADR1 => XLXI_6_n0021,
      ADR2 => XLXI_6_tx_s(0),
      ADR3 => XLXI_6_n0028,
      O => XLXI_6_n0028_GROM
    );
  XLXI_6_n0028_XUSED : X_BUF
    port map (
      I => XLXI_6_n0028_FROM,
      O => XLXI_6_n0028
    );
  XLXI_6_n0028_YUSED : X_BUF
    port map (
      I => XLXI_6_n0028_GROM,
      O => XLXI_6_n0055
    );
  XLXI_1_I3_Mmux_data_x_Result_1_86 : X_LUT4
    generic map(
      INIT => X"3808"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_c(1),
      ADR1 => IDATA(5),
      ADR2 => IDATA(4),
      ADR3 => XLXI_1_I4_ireg_c(1),
      O => CHOICE2914_FROM
    );
  XLXI_1_I4_daddr_x_1_SW0 : X_LUT4
    generic map(
      INIT => X"FF55"
    )
    port map (
      ADR0 => XLXI_1_I4_ireg_c(1),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => IDATA(4),
      O => CHOICE2914_GROM
    );
  CHOICE2914_XUSED : X_BUF
    port map (
      I => CHOICE2914_FROM,
      O => CHOICE2914
    );
  CHOICE2914_YUSED : X_BUF
    port map (
      I => CHOICE2914_GROM,
      O => N28548
    );
  XLXI_1_I3_n007226_SW1 : X_LUT4
    generic map(
      INIT => X"FAAA"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c(1),
      ADR1 => VCC,
      ADR2 => XLXI_1_I2_TD_c(2),
      ADR3 => XLXI_1_I3_acc_c_0_8,
      O => N43138_FROM
    );
  XLXI_1_I3_n007226_SW0 : X_LUT4
    generic map(
      INIT => X"CFC3"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I2_TD_c(2),
      ADR2 => XLXI_1_I2_TD_c(1),
      ADR3 => XLXI_1_I3_acc_c_0_8,
      O => N43138_GROM
    );
  N43138_XUSED : X_BUF
    port map (
      I => N43138_FROM,
      O => N43138
    );
  N43138_YUSED : X_BUF
    port map (
      I => N43138_GROM,
      O => N43136
    );
  XLXI_1_I3_n0115_6_72_SW1 : X_LUT4
    generic map(
      INIT => X"CA00"
    )
    port map (
      ADR0 => N43330,
      ADR1 => N43332,
      ADR2 => CHOICE2864,
      ADR3 => XLXI_1_I3_n00231_1,
      O => N43258_FROM
    );
  XLXI_1_I3_n0115_6_72_SW0 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => XLXI_1_I3_n00231_1,
      ADR1 => CHOICE2886,
      ADR2 => N43394,
      ADR3 => CHOICE2864,
      O => N43258_GROM
    );
  N43258_XUSED : X_BUF
    port map (
      I => N43258_FROM,
      O => N43258
    );
  N43258_YUSED : X_BUF
    port map (
      I => N43258_GROM,
      O => N43256
    );
  XLXI_55_nWE_RAM1 : X_LUT4
    generic map(
      INIT => X"FAFF"
    )
    port map (
      ADR0 => XLXI_1_I5_ndwe_c,
      ADR1 => VCC,
      ADR2 => CPU_ADDR_OUT(8),
      ADR3 => NRESET_BUFGP,
      O => nWE_RAM_FROM
    );
  XLXI_5_n00031 : X_LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      ADR0 => NRESET_BUFGP,
      ADR1 => XLXI_1_I5_Mmux_daddr_out_Result_0_1_1,
      ADR2 => XLXI_1_I5_ndwe_c,
      ADR3 => nCS_TIMER,
      O => nWE_RAM_GROM
    );
  nWE_RAM_XUSED : X_BUF
    port map (
      I => nWE_RAM_FROM,
      O => nWE_RAM
    );
  nWE_RAM_YUSED : X_BUF
    port map (
      I => nWE_RAM_GROM,
      O => XLXI_5_n0003
    );
  XLXI_1_I3_n0115_1_72_SW1 : X_LUT4
    generic map(
      INIT => X"E400"
    )
    port map (
      ADR0 => CHOICE2511,
      ADR1 => N43300,
      ADR2 => N43302,
      ADR3 => XLXI_1_I3_n0023,
      O => XLXI_1_I3_acc_c_0_0_FROM
    );
  XLXI_1_I3_n0115_1_139 : X_LUT4
    generic map(
      INIT => X"FEDC"
    )
    port map (
      ADR0 => CHOICE2520,
      ADR1 => CHOICE2506,
      ADR2 => N43286,
      ADR3 => XLXI_1_I3_n0115_1_72_SW1_O,
      O => XLXI_1_I3_acc_c_0_0_GROM
    );
  XLXI_1_I3_acc_c_0_0_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_c_0_0_FROM,
      O => XLXI_1_I3_n0115_1_72_SW1_O
    );
  XLXI_1_I3_acc_c_0_0_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_c_0_0_GROM,
      O => XLXI_1_I3_acc(0, 1)
    );
  XLXI_1_I3_acc_c_0_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I3_acc_c_0_0_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_n0115_3_39 : X_LUT4
    generic map(
      INIT => X"FFEC"
    )
    port map (
      ADR0 => XLXI_1_I3_n0074(3),
      ADR1 => CHOICE2641,
      ADR2 => XLXI_1_I3_n0059,
      ADR3 => CHOICE2645,
      O => XLXI_1_I3_acc_c_0_2_FROM
    );
  XLXI_1_I3_n0115_3_139 : X_LUT4
    generic map(
      INIT => X"FCEE"
    )
    port map (
      ADR0 => N43274,
      ADR1 => CHOICE2634,
      ADR2 => N43276,
      ADR3 => XLXI_1_I3_n0115_3_39_O,
      O => XLXI_1_I3_acc_c_0_2_GROM
    );
  XLXI_1_I3_acc_c_0_2_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_c_0_2_FROM,
      O => XLXI_1_I3_n0115_3_39_O
    );
  XLXI_1_I3_acc_c_0_2_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_c_0_2_GROM,
      O => XLXI_1_I3_acc(0, 3)
    );
  XLXI_1_I3_acc_c_0_2_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I3_acc_c_0_2_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_n0115_5_39 : X_LUT4
    generic map(
      INIT => X"FEFC"
    )
    port map (
      ADR0 => XLXI_1_I3_n0074(5),
      ADR1 => CHOICE2802,
      ADR2 => CHOICE2806,
      ADR3 => XLXI_1_I3_n0059,
      O => XLXI_1_I3_acc_c_0_4_FROM
    );
  XLXI_1_I3_n0115_5_139 : X_LUT4
    generic map(
      INIT => X"FAFC"
    )
    port map (
      ADR0 => N43264,
      ADR1 => N43262,
      ADR2 => CHOICE2795,
      ADR3 => XLXI_1_I3_n0115_5_39_O,
      O => XLXI_1_I3_acc_c_0_4_GROM
    );
  XLXI_1_I3_acc_c_0_4_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_c_0_4_FROM,
      O => XLXI_1_I3_n0115_5_39_O
    );
  XLXI_1_I3_acc_c_0_4_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_c_0_4_GROM,
      O => XLXI_1_I3_acc(0, 5)
    );
  XLXI_1_I3_acc_c_0_4_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I3_acc_c_0_4_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_acc_c_0_8_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I3_acc_c_0_8_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_daddr_x_2_SW0 : X_LUT4
    generic map(
      INIT => X"FFF3"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I4_ireg_c(2),
      ADR2 => IDATA(5),
      ADR3 => IDATA(4),
      O => N28888_FROM
    );
  XLXI_1_I4_n005738_SW1 : X_LUT4
    generic map(
      INIT => X"C0C8"
    )
    port map (
      ADR0 => CHOICE3059,
      ADR1 => XLXI_1_I4_n0037,
      ADR2 => IDATA(6),
      ADR3 => N28888,
      O => N28888_GROM
    );
  N28888_XUSED : X_BUF
    port map (
      I => N28888_FROM,
      O => N28888
    );
  N28888_YUSED : X_BUF
    port map (
      I => N28888_GROM,
      O => N43238
    );
  XLXI_1_I4_daddr_x_2_SW1 : X_LUT4
    generic map(
      INIT => X"FFA0"
    )
    port map (
      ADR0 => XLXI_1_I2_ndre_x1_1,
      ADR1 => VCC,
      ADR2 => XLXI_1_ndwe_int,
      ADR3 => N28888,
      O => XLXI_1_I5_daddr_c_2_FROM
    );
  XLXI_1_I4_daddr_x_2_Q : X_LUT4
    generic map(
      INIT => X"C0C8"
    )
    port map (
      ADR0 => CHOICE3059,
      ADR1 => XLXI_1_I4_n00371_1,
      ADR2 => IDATA(6),
      ADR3 => N43996,
      O => XLXI_1_adaddr_out(2)
    );
  XLXI_1_I5_daddr_c_2_XUSED : X_BUF
    port map (
      I => XLXI_1_I5_daddr_c_2_FROM,
      O => N43996
    );
  XLXI_1_I5_daddr_c_2_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I5_daddr_c_2_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_skip_i_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I3_skip_i_SRMUX_OUTPUTNOT
    );
  XLXI_1_I4_Ker218281 : X_LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      ADR0 => XLXI_1_I2_ndre_x1_1,
      ADR1 => XLXI_1_I4_N21894,
      ADR2 => XLXI_1_ndwe_int,
      ADR3 => XLXI_1_I4_n00371_1,
      O => XLXI_1_I4_ireg_we_c_FROM
    );
  XLXI_1_I4_ireg_we_x1 : X_LUT4
    generic map(
      INIT => X"3000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => IDATA(5),
      ADR2 => IDATA(4),
      ADR3 => XLXI_1_I4_N21830,
      O => XLXI_1_I4_ireg_we_x
    );
  XLXI_1_I4_ireg_we_c_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_ireg_we_c_FROM,
      O => XLXI_1_I4_N21830
    );
  XLXI_1_I4_ireg_we_c_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I4_ireg_we_c_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_n00231_1_283 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => XLXI_1_I3_nreset_v(0),
      ADR1 => NRESET_BUFGP,
      ADR2 => XLXI_1_I3_nreset_v(1),
      ADR3 => XLXI_1_I2_valid_c,
      O => XLXI_1_I3_n00231_1_FROM
    );
  XLXI_1_I3_n0115_8_132 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => XLXI_1_I3_nreset_v(1),
      ADR1 => XLXI_1_I3_acc_c_0_8,
      ADR2 => XLXI_1_I3_nreset_v(0),
      ADR3 => XLXI_1_I3_n00231_1,
      O => XLXI_1_I3_n00231_1_GROM
    );
  XLXI_1_I3_n00231_1_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_n00231_1_FROM,
      O => XLXI_1_I3_n00231_1
    );
  XLXI_1_I3_n00231_1_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_n00231_1_GROM,
      O => CHOICE2729
    );
  XLXI_1_I2_pc_mux_x_1_38_2_284 : X_LUT4
    generic map(
      INIT => X"C8C8"
    )
    port map (
      ADR0 => CHOICE1126,
      ADR1 => CHOICE1137,
      ADR2 => CHOICE1131,
      ADR3 => VCC,
      O => XLXI_1_I2_pc_mux_x_1_38_2_FROM
    );
  XLXI_1_I1_n0021_7_12 : X_LUT4
    generic map(
      INIT => X"88C0"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_1_7,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR2 => XLXI_1_I1_pc(7),
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_2,
      O => XLXI_1_I2_pc_mux_x_1_38_2_GROM
    );
  XLXI_1_I2_pc_mux_x_1_38_2_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_pc_mux_x_1_38_2_FROM,
      O => XLXI_1_I2_pc_mux_x_1_38_2
    );
  XLXI_1_I2_pc_mux_x_1_38_2_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_pc_mux_x_1_38_2_GROM,
      O => CHOICE2203
    );
  XLXI_1_I2_pc_mux_x_1_38_3_285 : X_LUT4
    generic map(
      INIT => X"CCC0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CHOICE1137,
      ADR2 => CHOICE1126,
      ADR3 => CHOICE1131,
      O => XLXI_1_I2_pc_mux_x_1_38_3_FROM
    );
  XLXI_1_I1_n0021_0_27 : X_LUT4
    generic map(
      INIT => X"5011"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR1 => XLXI_1_I1_pc(0),
      ADR2 => XLXI_1_I1_eaddr_x(0),
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_3,
      O => XLXI_1_I2_pc_mux_x_1_38_3_GROM
    );
  XLXI_1_I2_pc_mux_x_1_38_3_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_pc_mux_x_1_38_3_FROM,
      O => XLXI_1_I2_pc_mux_x_1_38_3
    );
  XLXI_1_I2_pc_mux_x_1_38_3_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_pc_mux_x_1_38_3_GROM,
      O => CHOICE2069
    );
  XLXI_1_I2_pc_mux_x_1_38_4_286 : X_LUT4
    generic map(
      INIT => X"AA88"
    )
    port map (
      ADR0 => CHOICE1137,
      ADR1 => CHOICE1126,
      ADR2 => VCC,
      ADR3 => CHOICE1131,
      O => XLXI_1_I2_pc_mux_x_1_38_4_GROM
    );
  XLXI_1_I2_pc_mux_x_1_38_4_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_pc_mux_x_1_38_4_GROM,
      O => XLXI_1_I2_pc_mux_x_1_38_4
    );
  XLXI_1_I1_n0021_1_65_SW1 : X_LUT4
    generic map(
      INIT => X"FE02"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_0_1,
      ADR1 => CHOICE2381,
      ADR2 => CHOICE2367,
      ADR3 => XLXI_1_I1_n0024(1),
      O => N44532_FROM
    );
  XLXI_1_I2_pc_mux_x_0_79_1_287 : X_LUT4
    generic map(
      INIT => X"FFCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CHOICE2381,
      ADR2 => VCC,
      ADR3 => CHOICE2367,
      O => N44532_GROM
    );
  N44532_XUSED : X_BUF
    port map (
      I => N44532_FROM,
      O => N44532
    );
  N44532_YUSED : X_BUF
    port map (
      I => N44532_GROM,
      O => XLXI_1_I2_pc_mux_x_0_79_1
    );
  XLXI_1_I1_n0021_7_65_SW1 : X_LUT4
    generic map(
      INIT => X"CCCA"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_0_7,
      ADR1 => XLXI_1_I1_n0024(7),
      ADR2 => CHOICE2381,
      ADR3 => CHOICE2367,
      O => N44528_FROM
    );
  XLXI_1_I1_n0021_6_65_SW1 : X_LUT4
    generic map(
      INIT => X"AAAC"
    )
    port map (
      ADR0 => XLXI_1_I1_n0024(6),
      ADR1 => XLXI_1_I1_stack_addrs_c_0_6,
      ADR2 => CHOICE2381,
      ADR3 => CHOICE2367,
      O => N44528_GROM
    );
  N44528_XUSED : X_BUF
    port map (
      I => N44528_FROM,
      O => N44528
    );
  N44528_YUSED : X_BUF
    port map (
      I => N44528_GROM,
      O => N44544
    );
  XLXI_1_I3_Mmux_data_x_Result_2_140_SW3 : X_LUT4
    generic map(
      INIT => X"E12D"
    )
    port map (
      ADR0 => XLXI_1_I4_n00371_1,
      ADR1 => XLXI_1_I3_n0025,
      ADR2 => XLXI_1_I3_acc_c_0_2,
      ADR3 => XLXI_1_I2_data_is_c(2),
      O => N43198_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_2_140_SW0 : X_LUT4
    generic map(
      INIT => X"C30F"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I3_n0025,
      ADR2 => XLXI_1_I3_acc_c_0_2,
      ADR3 => XLXI_1_I2_data_is_c(2),
      O => N43198_GROM
    );
  N43198_XUSED : X_BUF
    port map (
      I => N43198_FROM,
      O => N43198
    );
  N43198_YUSED : X_BUF
    port map (
      I => N43198_GROM,
      O => N43154
    );
  XLXI_1_I3_Mmux_data_x_Result_6_140_SW1 : X_LUT4
    generic map(
      INIT => X"CA35"
    )
    port map (
      ADR0 => XLXI_1_I4_n00371_1,
      ADR1 => XLXI_1_I2_data_is_c(6),
      ADR2 => XLXI_1_I3_n0025,
      ADR3 => XLXI_1_I3_acc_c_0_6,
      O => N43180_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_2_140_SW1 : X_LUT4
    generic map(
      INIT => X"99A5"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_2,
      ADR1 => XLXI_1_I2_data_is_c(2),
      ADR2 => XLXI_1_I4_n00371_1,
      ADR3 => XLXI_1_I3_n0025,
      O => N43180_GROM
    );
  N43180_XUSED : X_BUF
    port map (
      I => N43180_FROM,
      O => N43180
    );
  N43180_YUSED : X_BUF
    port map (
      I => N43180_GROM,
      O => N43156
    );
  XLXI_1_I4_ireg_x_2_11 : X_LUT4
    generic map(
      INIT => X"4400"
    )
    port map (
      ADR0 => XLXI_1_I4_ireg_we_c,
      ADR1 => NRESET_BUFGP,
      ADR2 => VCC,
      ADR3 => XLXI_1_I4_nreset_v(1),
      O => CHOICE630_FROM
    );
  XLXI_1_I4_ireg_x_0_11 : X_LUT4
    generic map(
      INIT => X"00C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => NRESET_BUFGP,
      ADR2 => XLXI_1_I4_nreset_v(1),
      ADR3 => XLXI_1_I4_ireg_we_c,
      O => CHOICE630_GROM
    );
  CHOICE630_XUSED : X_BUF
    port map (
      I => CHOICE630_FROM,
      O => CHOICE630
    );
  CHOICE630_YUSED : X_BUF
    port map (
      I => CHOICE630_GROM,
      O => CHOICE576
    );
  XLXI_1_I3_n0115_8_13_SW0 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N43246,
      ADR1 => XLXI_1_I3_n0065(8),
      ADR2 => N43244,
      ADR3 => XLXI_1_I3_n0059,
      O => N43426_GROM
    );
  N43426_YUSED : X_BUF
    port map (
      I => N43426_GROM,
      O => N43426
    );
  XLXI_1_I4_ireg_x_4_11 : X_LUT4
    generic map(
      INIT => X"4400"
    )
    port map (
      ADR0 => XLXI_1_I4_ireg_we_c,
      ADR1 => NRESET_BUFGP,
      ADR2 => VCC,
      ADR3 => XLXI_1_I4_nreset_v(1),
      O => CHOICE603_FROM
    );
  XLXI_1_I4_ireg_x_1_11 : X_LUT4
    generic map(
      INIT => X"4400"
    )
    port map (
      ADR0 => XLXI_1_I4_ireg_we_c,
      ADR1 => XLXI_1_I4_nreset_v(1),
      ADR2 => VCC,
      ADR3 => NRESET_BUFGP,
      O => CHOICE603_GROM
    );
  CHOICE603_XUSED : X_BUF
    port map (
      I => CHOICE603_FROM,
      O => CHOICE603
    );
  CHOICE603_YUSED : X_BUF
    port map (
      I => CHOICE603_GROM,
      O => CHOICE567
    );
  XLXI_1_I3_Mmux_data_x_Result_0_140_SW0 : X_LUT4
    generic map(
      INIT => X"9933"
    )
    port map (
      ADR0 => XLXI_1_I2_data_is_c(0),
      ADR1 => XLXI_1_I3_acc_c_0_0,
      ADR2 => VCC,
      ADR3 => XLXI_1_I3_n0025,
      O => N43142_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_6_140_SW2 : X_LUT4
    generic map(
      INIT => X"9933"
    )
    port map (
      ADR0 => XLXI_1_I2_data_is_c(6),
      ADR1 => XLXI_1_I3_acc_c_0_6,
      ADR2 => VCC,
      ADR3 => XLXI_1_I3_n0025,
      O => N43142_GROM
    );
  N43142_XUSED : X_BUF
    port map (
      I => N43142_FROM,
      O => N43142
    );
  N43142_YUSED : X_BUF
    port map (
      I => N43142_GROM,
      O => N43220
    );
  XLXI_1_I2_TD_x_3_SW0 : X_LUT4
    generic map(
      INIT => X"FFEF"
    )
    port map (
      ADR0 => IDATA(3),
      ADR1 => IDATA(0),
      ADR2 => NRESET_BUFGP,
      ADR3 => IDATA(1),
      O => XLXI_1_I2_TD_c_3_FROM
    );
  XLXI_1_I2_TD_x_3_Q : X_LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      ADR0 => IDATA(6),
      ADR1 => IDATA(7),
      ADR2 => IDATA(2),
      ADR3 => N30608,
      O => XLXI_1_I2_TD_c_3_GROM
    );
  XLXI_1_I2_TD_c_3_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_TD_c_3_FROM,
      O => N30608
    );
  XLXI_1_I2_TD_c_3_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_TD_c_3_GROM,
      O => XLXI_1_I2_TD_x(3)
    );
  XLXI_1_I2_TD_c_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_TD_c_3_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_Mmux_data_x_Result_0_34 : X_LUT4
    generic map(
      INIT => X"FFF8"
    )
    port map (
      ADR0 => CHOICE2678,
      ADR1 => RAM_DATA_OUT(0),
      ADR2 => CHOICE2971,
      ADR3 => CHOICE2974,
      O => CHOICE2984_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_0_59_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I4_N21650,
      ADR2 => VCC,
      ADR3 => CHOICE2984,
      O => CHOICE2984_GROM
    );
  CHOICE2984_XUSED : X_BUF
    port map (
      I => CHOICE2984_FROM,
      O => CHOICE2984
    );
  CHOICE2984_YUSED : X_BUF
    port map (
      I => CHOICE2984_GROM,
      O => N44559
    );
  XLXI_1_I4_ireg_x_5_11 : X_LUT4
    generic map(
      INIT => X"0088"
    )
    port map (
      ADR0 => NRESET_BUFGP,
      ADR1 => XLXI_1_I4_nreset_v(1),
      ADR2 => VCC,
      ADR3 => XLXI_1_I4_ireg_we_c,
      O => CHOICE612_FROM
    );
  XLXI_1_I4_ireg_x_3_11 : X_LUT4
    generic map(
      INIT => X"0C00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I4_nreset_v(1),
      ADR2 => XLXI_1_I4_ireg_we_c,
      ADR3 => NRESET_BUFGP,
      O => CHOICE612_GROM
    );
  CHOICE612_XUSED : X_BUF
    port map (
      I => CHOICE612_FROM,
      O => CHOICE612
    );
  CHOICE612_YUSED : X_BUF
    port map (
      I => CHOICE612_GROM,
      O => CHOICE621
    );
  XLXI_1_I3_Mmux_data_x_Result_2_34 : X_LUT4
    generic map(
      INIT => X"FEEE"
    )
    port map (
      ADR0 => CHOICE2828,
      ADR1 => CHOICE2831,
      ADR2 => CHOICE2678,
      ADR3 => RAM_DATA_OUT(2),
      O => CHOICE2841_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_1_34 : X_LUT4
    generic map(
      INIT => X"FEEE"
    )
    port map (
      ADR0 => CHOICE2895,
      ADR1 => CHOICE2892,
      ADR2 => CHOICE2678,
      ADR3 => RAM_DATA_OUT(1),
      O => CHOICE2841_GROM
    );
  CHOICE2841_XUSED : X_BUF
    port map (
      I => CHOICE2841_FROM,
      O => CHOICE2841
    );
  CHOICE2841_YUSED : X_BUF
    port map (
      I => CHOICE2841_GROM,
      O => CHOICE2905
    );
  XLXI_1_I3_n0115_8_31_SW0 : X_LUT4
    generic map(
      INIT => X"8A88"
    )
    port map (
      ADR0 => XLXI_1_I3_n0023,
      ADR1 => CHOICE2723,
      ADR2 => XLXI_1_I2_TD_c(3),
      ADR3 => CHOICE2701,
      O => N43244_FROM
    );
  XLXI_1_I3_n0115_8_13_SW1_SW0 : X_LUT4
    generic map(
      INIT => X"CFC0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => N43246,
      ADR2 => XLXI_1_I3_n0061,
      ADR3 => N43244,
      O => N43244_GROM
    );
  N43244_XUSED : X_BUF
    port map (
      I => N43244_FROM,
      O => N43244
    );
  N43244_YUSED : X_BUF
    port map (
      I => N43244_GROM,
      O => N44555
    );
  XLXI_1_I3_acc_i_0_6_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_i_0_6_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_i_0_6_FFY_RST
    );
  XLXI_1_I3_acc_i_0_7_288 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc_i_0_6_GROM,
      CE => XLXI_1_I2_int_start_c,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_i_0_6_FFY_RST,
      O => XLXI_1_I3_acc_i_0_7
    );
  XLXI_1_I3_n0115_7_39 : X_LUT4
    generic map(
      INIT => X"FFEC"
    )
    port map (
      ADR0 => XLXI_1_I3_n0074(7),
      ADR1 => CHOICE2930,
      ADR2 => XLXI_1_I3_n0059,
      ADR3 => CHOICE2934,
      O => XLXI_1_I3_acc_i_0_6_FROM
    );
  XLXI_1_I3_n0115_7_139 : X_LUT4
    generic map(
      INIT => X"FAEE"
    )
    port map (
      ADR0 => CHOICE2923,
      ADR1 => N43250,
      ADR2 => N43252,
      ADR3 => XLXI_1_I3_n0115_7_39_O,
      O => XLXI_1_I3_acc_i_0_6_GROM
    );
  XLXI_1_I3_acc_i_0_6_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_i_0_6_FROM,
      O => XLXI_1_I3_n0115_7_39_O
    );
  XLXI_1_I3_acc_i_0_6_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_acc_i_0_6_GROM,
      O => XLXI_1_I3_acc(0, 7)
    );
  XLXI_1_I3_acc_i_0_6_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I3_acc_i_0_6_SRMUX_OUTPUTNOT
    );
  XLXI_5_tmr_count_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_5_tmr_count_3_FFY_RST
    );
  XLXI_5_tmr_count_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT(2),
      CE => XLXI_5_n0003,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_count_3_FFY_RST,
      O => XLXI_5_tmr_count(2)
    );
  XLXI_1_I2_Ker188821 : X_LUT4
    generic map(
      INIT => X"FFF0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => IDATA(1),
      ADR3 => IDATA(2),
      O => XLXI_1_I2_N18884_FROM
    );
  XLXI_1_I2_pc_mux_x_2_SW0 : X_LUT4
    generic map(
      INIT => X"FF4F"
    )
    port map (
      ADR0 => XLXI_1_I2_S_c(2),
      ADR1 => IDATA(4),
      ADR2 => XLXI_1_I2_N18949,
      ADR3 => XLXI_1_I2_N18884,
      O => XLXI_1_I2_N18884_GROM
    );
  XLXI_1_I2_N18884_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_N18884_FROM,
      O => XLXI_1_I2_N18884
    );
  XLXI_1_I2_N18884_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_N18884_GROM,
      O => N31478
    );
  XLXI_1_I4_n00371_1_289 : X_LUT4
    generic map(
      INIT => X"C0C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => NRESET_BUFGP,
      ADR2 => XLXI_1_I4_nreset_v(1),
      ADR3 => VCC,
      O => XLXI_1_I4_iinc_i_6_FROM
    );
  XLXI_1_I4_iinc_x_6_1 : X_LUT4
    generic map(
      INIT => X"CAC0"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_c(6),
      ADR1 => XLXI_1_I3_acc_c_0_6,
      ADR2 => XLXI_1_I4_iinc_we_c,
      ADR3 => XLXI_1_I4_n00371_1,
      O => XLXI_1_I4_iinc_x(6)
    );
  XLXI_1_I4_iinc_i_6_XUSED : X_BUF
    port map (
      I => XLXI_1_I4_iinc_i_6_FROM,
      O => XLXI_1_I4_n00371_1
    );
  XLXI_1_I3_Mmux_data_x_Result_5_34 : X_LUT4
    generic map(
      INIT => X"FFEC"
    )
    port map (
      ADR0 => CHOICE2678,
      ADR1 => CHOICE2606,
      ADR2 => RAM_DATA_OUT(5),
      ADR3 => CHOICE2603,
      O => CHOICE2616_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_3_34 : X_LUT4
    generic map(
      INIT => X"FEEE"
    )
    port map (
      ADR0 => CHOICE2764,
      ADR1 => CHOICE2767,
      ADR2 => RAM_DATA_OUT(3),
      ADR3 => CHOICE2678,
      O => CHOICE2616_GROM
    );
  CHOICE2616_XUSED : X_BUF
    port map (
      I => CHOICE2616_FROM,
      O => CHOICE2616
    );
  CHOICE2616_YUSED : X_BUF
    port map (
      I => CHOICE2616_GROM,
      O => CHOICE2777
    );
  XLXI_1_I4_Ker218921_SW1 : X_LUT4
    generic map(
      INIT => X"FFED"
    )
    port map (
      ADR0 => IDATA(5),
      ADR1 => IDATA(3),
      ADR2 => IDATA(4),
      ADR3 => XLXI_1_I2_C_raw,
      O => N43443_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_1_99 : X_LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      ADR0 => CHOICE3059,
      ADR1 => N43486,
      ADR2 => XLXI_1_I2_C_raw,
      ADR3 => N43378,
      O => N43443_GROM
    );
  N43443_XUSED : X_BUF
    port map (
      I => N43443_FROM,
      O => N43443
    );
  N43443_YUSED : X_BUF
    port map (
      I => N43443_GROM,
      O => CHOICE2917
    );
  XLXI_1_I4_n005738_SW0 : X_LUT4
    generic map(
      INIT => X"FEFE"
    )
    port map (
      ADR0 => IDATA(6),
      ADR1 => IDATA(5),
      ADR2 => IDATA(4),
      ADR3 => VCC,
      O => N43094_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_2_86 : X_LUT4
    generic map(
      INIT => X"0AC0"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_c(2),
      ADR1 => XLXI_1_I4_ireg_c(2),
      ADR2 => IDATA(4),
      ADR3 => IDATA(5),
      O => N43094_GROM
    );
  N43094_XUSED : X_BUF
    port map (
      I => N43094_FROM,
      O => N43094
    );
  N43094_YUSED : X_BUF
    port map (
      I => N43094_GROM,
      O => CHOICE2850
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_311 : X_LUT4
    generic map(
      INIT => X"3237"
    )
    port map (
      ADR0 => CHOICE2917,
      ADR1 => N43150,
      ADR2 => CHOICE2907,
      ADR3 => N43148,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_31_GROM
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_31_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_Madd_n0074_inst_lut2_31_GROM,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_31
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_321 : X_LUT4
    generic map(
      INIT => X"3335"
    )
    port map (
      ADR0 => N43154,
      ADR1 => N43198,
      ADR2 => CHOICE2843,
      ADR3 => CHOICE2853,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_32_GROM
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_32_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_Madd_n0074_inst_lut2_32_GROM,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_32
    );
  XLXI_1_I2_TD_x_0_22 : X_LUT4
    generic map(
      INIT => X"1177"
    )
    port map (
      ADR0 => IDATA(5),
      ADR1 => IDATA(7),
      ADR2 => VCC,
      ADR3 => IDATA(6),
      O => CHOICE1070_FROM
    );
  XLXI_1_I2_Ker189741 : X_LUT4
    generic map(
      INIT => X"5000"
    )
    port map (
      ADR0 => IDATA(5),
      ADR1 => VCC,
      ADR2 => IDATA(7),
      ADR3 => IDATA(6),
      O => CHOICE1070_GROM
    );
  CHOICE1070_XUSED : X_BUF
    port map (
      I => CHOICE1070_FROM,
      O => CHOICE1070
    );
  CHOICE1070_YUSED : X_BUF
    port map (
      I => CHOICE1070_GROM,
      O => XLXI_1_I2_N18976
    );
  XLXI_1_I4_ireg_x_7_11 : X_LUT4
    generic map(
      INIT => X"00C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I4_nreset_v(1),
      ADR2 => NRESET_BUFGP,
      ADR3 => XLXI_1_I4_ireg_we_c,
      O => CHOICE585_FROM
    );
  XLXI_1_I4_ireg_x_6_11 : X_LUT4
    generic map(
      INIT => X"00C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I4_nreset_v(1),
      ADR2 => NRESET_BUFGP,
      ADR3 => XLXI_1_I4_ireg_we_c,
      O => CHOICE585_GROM
    );
  CHOICE585_XUSED : X_BUF
    port map (
      I => CHOICE585_FROM,
      O => CHOICE585
    );
  CHOICE585_YUSED : X_BUF
    port map (
      I => CHOICE585_GROM,
      O => CHOICE594
    );
  XLXI_1_I3_Mmux_data_x_Result_4_25 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_55_mux_c(4),
      ADR1 => XLXI_55_mux_c(1),
      ADR2 => XLXI_55_mux_c(3),
      ADR3 => XLXI_55_mux_c(2),
      O => CHOICE2678_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_6_34 : X_LUT4
    generic map(
      INIT => X"FEEE"
    )
    port map (
      ADR0 => CHOICE2542,
      ADR1 => CHOICE2539,
      ADR2 => RAM_DATA_OUT(6),
      ADR3 => CHOICE2678,
      O => CHOICE2678_GROM
    );
  CHOICE2678_XUSED : X_BUF
    port map (
      I => CHOICE2678_FROM,
      O => CHOICE2678
    );
  CHOICE2678_YUSED : X_BUF
    port map (
      I => CHOICE2678_GROM,
      O => CHOICE2552
    );
  XLXI_1_I3_n0115_7_72_SW1 : X_LUT4
    generic map(
      INIT => X"C088"
    )
    port map (
      ADR0 => N43306,
      ADR1 => XLXI_1_I3_n00231_1,
      ADR2 => N43308,
      ADR3 => CHOICE2928,
      O => N43252_FROM
    );
  XLXI_1_I3_n0115_7_72_SW0 : X_LUT4
    generic map(
      INIT => X"F800"
    )
    port map (
      ADR0 => CHOICE2928,
      ADR1 => N43390,
      ADR2 => CHOICE2950,
      ADR3 => XLXI_1_I3_n00231_1,
      O => N43252_GROM
    );
  N43252_XUSED : X_BUF
    port map (
      I => N43252_FROM,
      O => N43252
    );
  N43252_YUSED : X_BUF
    port map (
      I => N43252_GROM,
      O => N43250
    );
  XLXI_1_I3_Mmux_data_x_Result_7_34 : X_LUT4
    generic map(
      INIT => X"FEEE"
    )
    port map (
      ADR0 => CHOICE2478,
      ADR1 => CHOICE2475,
      ADR2 => CHOICE2678,
      ADR3 => RAM_DATA_OUT(7),
      O => CHOICE2488_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_4_34 : X_LUT4
    generic map(
      INIT => X"FEEE"
    )
    port map (
      ADR0 => CHOICE2667,
      ADR1 => CHOICE2670,
      ADR2 => RAM_DATA_OUT(4),
      ADR3 => CHOICE2678,
      O => CHOICE2488_GROM
    );
  CHOICE2488_XUSED : X_BUF
    port map (
      I => CHOICE2488_FROM,
      O => CHOICE2488
    );
  CHOICE2488_YUSED : X_BUF
    port map (
      I => CHOICE2488_GROM,
      O => CHOICE2680
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_331 : X_LUT4
    generic map(
      INIT => X"3327"
    )
    port map (
      ADR0 => CHOICE2789,
      ADR1 => N43204,
      ADR2 => N43160,
      ADR3 => CHOICE2779,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_33_GROM
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_33_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_Madd_n0074_inst_lut2_33_GROM,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_33
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_341 : X_LUT4
    generic map(
      INIT => X"5553"
    )
    port map (
      ADR0 => N43210,
      ADR1 => N43166,
      ADR2 => CHOICE2682,
      ADR3 => CHOICE2692,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_34_GROM
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_34_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_Madd_n0074_inst_lut2_34_GROM,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_34
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_351 : X_LUT4
    generic map(
      INIT => X"01FB"
    )
    port map (
      ADR0 => CHOICE2628,
      ADR1 => N43172,
      ADR2 => CHOICE2618,
      ADR3 => N43216,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_35_GROM
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_35_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_Madd_n0074_inst_lut2_35_GROM,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_35
    );
  XLXI_1_I3_Mmux_data_x_Result_4_86 : X_LUT4
    generic map(
      INIT => X"22C0"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_c(4),
      ADR1 => IDATA(4),
      ADR2 => XLXI_1_I4_ireg_c(4),
      ADR3 => IDATA(5),
      O => CHOICE2689_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_3_86 : X_LUT4
    generic map(
      INIT => X"4A40"
    )
    port map (
      ADR0 => IDATA(5),
      ADR1 => XLXI_1_I4_ireg_c(3),
      ADR2 => IDATA(4),
      ADR3 => XLXI_1_I4_iinc_c(3),
      O => CHOICE2689_GROM
    );
  CHOICE2689_XUSED : X_BUF
    port map (
      I => CHOICE2689_FROM,
      O => CHOICE2689
    );
  CHOICE2689_YUSED : X_BUF
    port map (
      I => CHOICE2689_GROM,
      O => CHOICE2786
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_361 : X_LUT4
    generic map(
      INIT => X"5553"
    )
    port map (
      ADR0 => N43222,
      ADR1 => N43220,
      ADR2 => CHOICE2554,
      ADR3 => CHOICE2564,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_36_GROM
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_36_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_Madd_n0074_inst_lut2_36_GROM,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_36
    );
  XLXI_1_I3_Ker198541 : X_LUT4
    generic map(
      INIT => X"00CC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I2_TD_c(0),
      ADR2 => VCC,
      ADR3 => XLXI_1_I2_TD_c(2),
      O => XLXI_1_I3_N19856_FROM
    );
  XLXI_1_I3_Ker198351 : X_LUT4
    generic map(
      INIT => X"0330"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I2_TD_c(0),
      ADR2 => XLXI_1_I2_TD_c(1),
      ADR3 => XLXI_1_I2_TD_c(2),
      O => XLXI_1_I3_N19856_GROM
    );
  XLXI_1_I3_N19856_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_N19856_FROM,
      O => XLXI_1_I3_N19856
    );
  XLXI_1_I3_N19856_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_N19856_GROM,
      O => XLXI_1_I3_N19837
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_371 : X_LUT4
    generic map(
      INIT => X"3327"
    )
    port map (
      ADR0 => CHOICE2490,
      ADR1 => N43234,
      ADR2 => N43232,
      ADR3 => CHOICE2500,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_37_GROM
    );
  XLXI_1_I3_Madd_n0074_inst_lut2_37_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_Madd_n0074_inst_lut2_37_GROM,
      O => XLXI_1_I3_Madd_n0074_inst_lut2_37
    );
  XLXI_1_I3_Ker199251 : X_LUT4
    generic map(
      INIT => X"F088"
    )
    port map (
      ADR0 => XLXI_1_I3_nreset_v(1),
      ADR1 => XLXI_1_I3_nreset_v(0),
      ADR2 => XLXI_1_I3_N19977,
      ADR3 => XLXI_1_I3_n0023,
      O => XLXI_1_I3_N19927_FROM
    );
  XLXI_1_I3_n0115_6_0 : X_LUT4
    generic map(
      INIT => X"AA00"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_6,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_1_I3_N19927,
      O => XLXI_1_I3_N19927_GROM
    );
  XLXI_1_I3_N19927_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_N19927_FROM,
      O => XLXI_1_I3_N19927
    );
  XLXI_1_I3_N19927_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_N19927_GROM,
      O => CHOICE2859
    );
  XLXI_1_I3_Mmux_data_x_Result_7_86 : X_LUT4
    generic map(
      INIT => X"6240"
    )
    port map (
      ADR0 => IDATA(5),
      ADR1 => IDATA(4),
      ADR2 => XLXI_1_I4_ireg_c(7),
      ADR3 => XLXI_1_I4_iinc_c(7),
      O => CHOICE2497_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_5_86 : X_LUT4
    generic map(
      INIT => X"44A0"
    )
    port map (
      ADR0 => IDATA(4),
      ADR1 => XLXI_1_I4_iinc_c(5),
      ADR2 => XLXI_1_I4_ireg_c(5),
      ADR3 => IDATA(5),
      O => CHOICE2497_GROM
    );
  CHOICE2497_XUSED : X_BUF
    port map (
      I => CHOICE2497_FROM,
      O => CHOICE2497
    );
  CHOICE2497_YUSED : X_BUF
    port map (
      I => CHOICE2497_GROM,
      O => CHOICE2625
    );
  XLXI_1_I2_pc_mux_x_0_30 : X_LUT4
    generic map(
      INIT => X"DCCC"
    )
    port map (
      ADR0 => XLXI_1_I2_int_start_c,
      ADR1 => XLXI_1_I2_N18996,
      ADR2 => XLXI_1_I2_N18844,
      ADR3 => XLXI_1_I3_skip_l,
      O => CHOICE2369_FROM
    );
  XLXI_1_I2_pc_mux_x_0_68 : X_LUT4
    generic map(
      INIT => X"FFC8"
    )
    port map (
      ADR0 => CHOICE2375,
      ADR1 => CHOICE2379,
      ADR2 => CHOICE2370,
      ADR3 => CHOICE2369,
      O => CHOICE2369_GROM
    );
  CHOICE2369_XUSED : X_BUF
    port map (
      I => CHOICE2369_FROM,
      O => CHOICE2369
    );
  CHOICE2369_YUSED : X_BUF
    port map (
      I => CHOICE2369_GROM,
      O => CHOICE2381
    );
  XLXI_1_I2_TD_x_2_29 : X_LUT4
    generic map(
      INIT => X"0780"
    )
    port map (
      ADR0 => IDATA(4),
      ADR1 => IDATA(5),
      ADR2 => IDATA(7),
      ADR3 => IDATA(6),
      O => CHOICE1051_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_6_86 : X_LUT4
    generic map(
      INIT => X"3088"
    )
    port map (
      ADR0 => XLXI_1_I4_iinc_c(6),
      ADR1 => IDATA(5),
      ADR2 => XLXI_1_I4_ireg_c(6),
      ADR3 => IDATA(4),
      O => CHOICE1051_GROM
    );
  CHOICE1051_XUSED : X_BUF
    port map (
      I => CHOICE1051_FROM,
      O => CHOICE1051
    );
  CHOICE1051_YUSED : X_BUF
    port map (
      I => CHOICE1051_GROM,
      O => CHOICE2561
    );
  XLXI_1_I2_pc_mux_x_1_18 : X_LUT4
    generic map(
      INIT => X"C480"
    )
    port map (
      ADR0 => IDATA(4),
      ADR1 => XLXI_1_I2_N18949,
      ADR2 => XLXI_1_I2_S_c(2),
      ADR3 => XLXI_1_I2_N18844,
      O => CHOICE1131_FROM
    );
  XLXI_1_I2_pc_mux_x_0_44 : X_LUT4
    generic map(
      INIT => X"4500"
    )
    port map (
      ADR0 => IDATA(3),
      ADR1 => XLXI_1_I2_S_c(2),
      ADR2 => IDATA(4),
      ADR3 => XLXI_1_I2_N18949,
      O => CHOICE1131_GROM
    );
  CHOICE1131_XUSED : X_BUF
    port map (
      I => CHOICE1131_FROM,
      O => CHOICE1131
    );
  CHOICE1131_YUSED : X_BUF
    port map (
      I => CHOICE1131_GROM,
      O => CHOICE2375
    );
  XLXI_1_I2_pc_mux_x_1_36 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => IDATA(1),
      ADR1 => XLXI_1_skip,
      ADR2 => IDATA(2),
      ADR3 => XLXI_1_I2_N18996,
      O => CHOICE1137_FROM
    );
  XLXI_1_I2_pc_mux_x_1_38_1_290 : X_LUT4
    generic map(
      INIT => X"FC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CHOICE1131,
      ADR2 => CHOICE1126,
      ADR3 => CHOICE1137,
      O => CHOICE1137_GROM
    );
  CHOICE1137_XUSED : X_BUF
    port map (
      I => CHOICE1137_FROM,
      O => CHOICE1137
    );
  CHOICE1137_YUSED : X_BUF
    port map (
      I => CHOICE1137_GROM,
      O => XLXI_1_I2_pc_mux_x_1_38_1
    );
  XLXI_1_I1_n00341 : X_LUT4
    generic map(
      INIT => X"0020"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_2_1,
      ADR1 => CHOICE2381,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_1,
      ADR3 => CHOICE2367,
      O => XLXI_1_I1_eaddr_x_2_FROM
    );
  XLXI_1_I1_Mmux_n0023_Result_2_1 : X_LUT4
    generic map(
      INIT => X"AAF0"
    )
    port map (
      ADR0 => IDATA(6),
      ADR1 => VCC,
      ADR2 => XLXI_1_I1_eaddr_x(2),
      ADR3 => XLXI_1_I1_n0034,
      O => XLXI_1_I1_n0023(2)
    );
  XLXI_1_I1_eaddr_x_2_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_eaddr_x_2_FROM,
      O => XLXI_1_I1_n0034
    );
  XLXI_1_I1_eaddr_x_2_CKINV : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I1_eaddr_x_2_CKMUXNOT
    );
  XLXI_1_I2_pc_mux_x_1_38 : X_LUT4
    generic map(
      INIT => X"CC88"
    )
    port map (
      ADR0 => CHOICE1126,
      ADR1 => CHOICE1137,
      ADR2 => VCC,
      ADR3 => CHOICE1131,
      O => XLXI_1_pc_mux_1_FROM
    );
  XLXI_1_I1_iaddr_x_3_60_SW0 : X_LUT4
    generic map(
      INIT => X"FF1D"
    )
    port map (
      ADR0 => XLXI_1_I1_pc(3),
      ADR1 => XLXI_1_pc_mux(0),
      ADR2 => XLXI_1_I1_n0024(3),
      ADR3 => XLXI_1_pc_mux(1),
      O => XLXI_1_pc_mux_1_GROM
    );
  XLXI_1_pc_mux_1_XUSED : X_BUF
    port map (
      I => XLXI_1_pc_mux_1_FROM,
      O => XLXI_1_pc_mux(1)
    );
  XLXI_1_pc_mux_1_YUSED : X_BUF
    port map (
      I => XLXI_1_pc_mux_1_GROM,
      O => N43808
    );
  XLXI_1_I1_n0021_9_65_SW1 : X_LUT4
    generic map(
      INIT => X"CCD8"
    )
    port map (
      ADR0 => CHOICE2367,
      ADR1 => XLXI_1_I1_n0024(9),
      ADR2 => XLXI_1_I1_stack_addrs_c_0_9,
      ADR3 => CHOICE2381,
      O => N44540_FROM
    );
  XLXI_1_I1_n00381 : X_LUT4
    generic map(
      INIT => X"1EF0"
    )
    port map (
      ADR0 => CHOICE2381,
      ADR1 => CHOICE2367,
      ADR2 => XLXI_1_pc_mux(2),
      ADR3 => XLXI_1_pc_mux(1),
      O => N44540_GROM
    );
  N44540_XUSED : X_BUF
    port map (
      I => N44540_FROM,
      O => N44540
    );
  N44540_YUSED : X_BUF
    port map (
      I => N44540_GROM,
      O => XLXI_1_I1_n0038
    );
  XLXI_1_I1_n00391 : X_LUT4
    generic map(
      INIT => X"1113"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(1),
      ADR1 => XLXI_1_pc_mux(2),
      ADR2 => CHOICE2367,
      ADR3 => CHOICE2381,
      O => XLXI_1_I1_stack_addrs_c_7_9_FROM
    );
  XLXI_1_I1_n0014_9_1 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_1_I1_stack_addrs_c_6_9,
      ADR1 => XLXI_1_I1_n0038,
      ADR2 => XLXI_1_I1_stack_addrs_c_7_9,
      ADR3 => XLXI_1_I1_n0039,
      O => XLXI_1_I1_n0014(9)
    );
  XLXI_1_I1_stack_addrs_c_7_9_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_stack_addrs_c_7_9_FROM,
      O => XLXI_1_I1_n0039
    );
  XLXI_1_I1_n0021_0_65_SW1 : X_LUT4
    generic map(
      INIT => X"C8CD"
    )
    port map (
      ADR0 => CHOICE2367,
      ADR1 => XLXI_1_I1_pc(0),
      ADR2 => CHOICE2381,
      ADR3 => XLXI_1_I1_stack_addrs_c_0_0,
      O => N44516_FROM
    );
  XLXI_1_I1_n0021_0_12 : X_LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(0),
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR2 => XLXI_1_I1_stack_addrs_c_1_0,
      ADR3 => XLXI_1_I1_pc(0),
      O => N44516_GROM
    );
  N44516_XUSED : X_BUF
    port map (
      I => N44516_FROM,
      O => N44516
    );
  N44516_YUSED : X_BUF
    port map (
      I => N44516_GROM,
      O => CHOICE2063
    );
  XLXI_1_I3_n0115_3_13_SW0 : X_LUT4
    generic map(
      INIT => X"F2F2"
    )
    port map (
      ADR0 => XLXI_1_I3_n0076,
      ADR1 => XLXI_1_I2_TD_c(3),
      ADR2 => CHOICE2661,
      ADR3 => VCC,
      O => N43312_FROM
    );
  XLXI_1_I3_n0115_1_13_SW1 : X_LUT4
    generic map(
      INIT => X"F8FA"
    )
    port map (
      ADR0 => XLXI_1_I3_n0076,
      ADR1 => XLXI_1_I3_acc_c_0_1,
      ADR2 => CHOICE2533,
      ADR3 => XLXI_1_I2_TD_c(3),
      O => N43312_GROM
    );
  N43312_XUSED : X_BUF
    port map (
      I => N43312_FROM,
      O => N43312
    );
  N43312_YUSED : X_BUF
    port map (
      I => N43312_GROM,
      O => N43302
    );
  XLXI_1_I1_n0021_4_27 : X_LUT4
    generic map(
      INIT => X"2230"
    )
    port map (
      ADR0 => XLXI_1_I1_eaddr_x(4),
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR2 => XLXI_1_I1_n0024(4),
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_3,
      O => CHOICE2149_FROM
    );
  XLXI_1_I1_n0021_1_12 : X_LUT4
    generic map(
      INIT => X"C840"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR2 => XLXI_1_I1_pc(1),
      ADR3 => XLXI_1_I1_stack_addrs_c_1_1,
      O => CHOICE2149_GROM
    );
  CHOICE2149_XUSED : X_BUF
    port map (
      I => CHOICE2149_FROM,
      O => CHOICE2149
    );
  CHOICE2149_YUSED : X_BUF
    port map (
      I => CHOICE2149_GROM,
      O => CHOICE2083
    );
  XLXI_1_I1_n0021_0_65 : X_LUT4
    generic map(
      INIT => X"005C"
    )
    port map (
      ADR0 => N44516,
      ADR1 => XLXI_1_I1_stack_addrs_c_0_0,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR3 => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_stack_addrs_c_0_0_FROM
    );
  XLXI_1_I1_n0021_0_72 : X_LUT4
    generic map(
      INIT => X"FFA8"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(2),
      ADR1 => CHOICE2069,
      ADR2 => CHOICE2063,
      ADR3 => CHOICE2077,
      O => XLXI_1_I1_n0021(0)
    );
  XLXI_1_I1_stack_addrs_c_0_0_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_stack_addrs_c_0_0_FROM,
      O => CHOICE2077
    );
  XLXI_1_I1_n0021_6_27 : X_LUT4
    generic map(
      INIT => X"3120"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR2 => XLXI_1_I1_eaddr_x(6),
      ADR3 => XLXI_1_I1_n0024(6),
      O => CHOICE2189_FROM
    );
  XLXI_1_I1_n0021_1_27 : X_LUT4
    generic map(
      INIT => X"2230"
    )
    port map (
      ADR0 => XLXI_1_I1_eaddr_x(1),
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR2 => XLXI_1_I1_n0024(1),
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_3,
      O => CHOICE2189_GROM
    );
  CHOICE2189_XUSED : X_BUF
    port map (
      I => CHOICE2189_FROM,
      O => CHOICE2189
    );
  CHOICE2189_YUSED : X_BUF
    port map (
      I => CHOICE2189_GROM,
      O => CHOICE2089
    );
  XLXI_1_I1_n0021_4_12 : X_LUT4
    generic map(
      INIT => X"8A80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR1 => XLXI_1_I1_stack_addrs_c_1_4,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR3 => XLXI_1_I1_pc(4),
      O => CHOICE2143_FROM
    );
  XLXI_1_I1_n0021_2_12 : X_LUT4
    generic map(
      INIT => X"CA00"
    )
    port map (
      ADR0 => XLXI_1_I1_pc(2),
      ADR1 => XLXI_1_I1_stack_addrs_c_1_2,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_4,
      O => CHOICE2143_GROM
    );
  CHOICE2143_XUSED : X_BUF
    port map (
      I => CHOICE2143_FROM,
      O => CHOICE2143
    );
  CHOICE2143_YUSED : X_BUF
    port map (
      I => CHOICE2143_GROM,
      O => CHOICE2103
    );
  XLXI_1_I1_n0021_1_65 : X_LUT4
    generic map(
      INIT => X"00B8"
    )
    port map (
      ADR0 => N44532,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR2 => XLXI_1_I1_stack_addrs_c_0_1,
      ADR3 => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_stack_addrs_c_0_1_FROM
    );
  XLXI_1_I1_n0021_1_72 : X_LUT4
    generic map(
      INIT => X"FFA8"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(2),
      ADR1 => CHOICE2089,
      ADR2 => CHOICE2083,
      ADR3 => CHOICE2097,
      O => XLXI_1_I1_n0021(1)
    );
  XLXI_1_I1_stack_addrs_c_0_1_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_stack_addrs_c_0_1_FROM,
      O => CHOICE2097
    );
  XLXI_1_I1_n0021_6_12 : X_LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR1 => XLXI_1_I1_pc(6),
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR3 => XLXI_1_I1_stack_addrs_c_1_6,
      O => CHOICE2183_FROM
    );
  XLXI_1_I1_n0021_2_27 : X_LUT4
    generic map(
      INIT => X"4540"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR1 => XLXI_1_I1_eaddr_x(2),
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR3 => XLXI_1_I1_n0024(2),
      O => CHOICE2183_GROM
    );
  CHOICE2183_XUSED : X_BUF
    port map (
      I => CHOICE2183_FROM,
      O => CHOICE2183
    );
  CHOICE2183_YUSED : X_BUF
    port map (
      I => CHOICE2183_GROM,
      O => CHOICE2109
    );
  XLXI_1_I1_n0021_3_27 : X_LUT4
    generic map(
      INIT => X"0E02"
    )
    port map (
      ADR0 => XLXI_1_I1_n0024(3),
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR3 => XLXI_1_I1_eaddr_x(3),
      O => CHOICE2129_FROM
    );
  XLXI_1_I1_n0021_3_12 : X_LUT4
    generic map(
      INIT => X"8A80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR1 => XLXI_1_I1_stack_addrs_c_1_3,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR3 => XLXI_1_I1_pc(3),
      O => CHOICE2129_GROM
    );
  CHOICE2129_XUSED : X_BUF
    port map (
      I => CHOICE2129_FROM,
      O => CHOICE2129
    );
  CHOICE2129_YUSED : X_BUF
    port map (
      I => CHOICE2129_GROM,
      O => CHOICE2123
    );
  XLXI_1_I2_pc_mux_x_2_1_291 : X_LUT4
    generic map(
      INIT => X"1113"
    )
    port map (
      ADR0 => XLXI_1_I2_N18844,
      ADR1 => XLXI_1_I2_N18996,
      ADR2 => N31478,
      ADR3 => XLXI_1_skip,
      O => XLXI_1_I2_pc_mux_x_2_1_FROM
    );
  XLXI_1_I2_pc_mux_x_2_Q : X_LUT4
    generic map(
      INIT => X"1115"
    )
    port map (
      ADR0 => XLXI_1_I2_N18996,
      ADR1 => XLXI_1_I2_N18844,
      ADR2 => XLXI_1_skip,
      ADR3 => N31478,
      O => XLXI_1_I2_pc_mux_x_2_1_GROM
    );
  XLXI_1_I2_pc_mux_x_2_1_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_pc_mux_x_2_1_FROM,
      O => XLXI_1_I2_pc_mux_x_2_1
    );
  XLXI_1_I2_pc_mux_x_2_1_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_pc_mux_x_2_1_GROM,
      O => XLXI_1_pc_mux(2)
    );
  XLXI_1_I1_n0021_2_65 : X_LUT4
    generic map(
      INIT => X"00B8"
    )
    port map (
      ADR0 => N44508,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR2 => XLXI_1_I1_stack_addrs_c_0_2,
      ADR3 => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_stack_addrs_c_0_2_FROM
    );
  XLXI_1_I1_n0021_2_72 : X_LUT4
    generic map(
      INIT => X"FFA8"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(2),
      ADR1 => CHOICE2103,
      ADR2 => CHOICE2109,
      ADR3 => CHOICE2117,
      O => XLXI_1_I1_n0021(2)
    );
  XLXI_1_I1_stack_addrs_c_0_2_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_stack_addrs_c_0_2_FROM,
      O => CHOICE2117
    );
  XLXI_1_I1_n0021_3_65 : X_LUT4
    generic map(
      INIT => X"00E4"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR1 => XLXI_1_I1_stack_addrs_c_0_3,
      ADR2 => N44524,
      ADR3 => XLXI_1_pc_mux(2),
      O => XLXI_1_I1_stack_addrs_c_0_3_FROM
    );
  XLXI_1_I1_n0021_3_72 : X_LUT4
    generic map(
      INIT => X"FFC8"
    )
    port map (
      ADR0 => CHOICE2123,
      ADR1 => XLXI_1_pc_mux(2),
      ADR2 => CHOICE2129,
      ADR3 => CHOICE2137,
      O => XLXI_1_I1_n0021(3)
    );
  XLXI_1_I1_stack_addrs_c_0_3_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_stack_addrs_c_0_3_FROM,
      O => CHOICE2137
    );
  XLXI_1_I1_n0021_5_27 : X_LUT4
    generic map(
      INIT => X"3210"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR2 => XLXI_1_I1_n0024(5),
      ADR3 => XLXI_1_I1_eaddr_x(5),
      O => CHOICE2169_FROM
    );
  XLXI_1_I1_n0021_5_12 : X_LUT4
    generic map(
      INIT => X"8A80"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR1 => XLXI_1_I1_stack_addrs_c_1_5,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR3 => XLXI_1_I1_pc(5),
      O => CHOICE2169_GROM
    );
  CHOICE2169_XUSED : X_BUF
    port map (
      I => CHOICE2169_FROM,
      O => CHOICE2169
    );
  CHOICE2169_YUSED : X_BUF
    port map (
      I => CHOICE2169_GROM,
      O => CHOICE2163
    );
  XLXI_1_I1_n0021_4_65 : X_LUT4
    generic map(
      INIT => X"2230"
    )
    port map (
      ADR0 => N44536,
      ADR1 => XLXI_1_pc_mux(2),
      ADR2 => XLXI_1_I1_stack_addrs_c_0_4,
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_3,
      O => XLXI_1_I1_stack_addrs_c_0_4_FROM
    );
  XLXI_1_I1_n0021_4_72 : X_LUT4
    generic map(
      INIT => X"FFE0"
    )
    port map (
      ADR0 => CHOICE2149,
      ADR1 => CHOICE2143,
      ADR2 => XLXI_1_pc_mux(2),
      ADR3 => CHOICE2157,
      O => XLXI_1_I1_n0021(4)
    );
  XLXI_1_I1_stack_addrs_c_0_4_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_stack_addrs_c_0_4_FROM,
      O => CHOICE2157
    );
  XLXI_1_I1_n0021_5_65 : X_LUT4
    generic map(
      INIT => X"0A0C"
    )
    port map (
      ADR0 => N44520,
      ADR1 => XLXI_1_I1_stack_addrs_c_0_5,
      ADR2 => XLXI_1_pc_mux(2),
      ADR3 => XLXI_1_I2_pc_mux_x_1_38_3,
      O => XLXI_1_I1_stack_addrs_c_0_5_FROM
    );
  XLXI_1_I1_n0021_5_72 : X_LUT4
    generic map(
      INIT => X"FFE0"
    )
    port map (
      ADR0 => CHOICE2169,
      ADR1 => CHOICE2163,
      ADR2 => XLXI_1_pc_mux(2),
      ADR3 => CHOICE2177,
      O => XLXI_1_I1_n0021(5)
    );
  XLXI_1_I1_stack_addrs_c_0_5_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_stack_addrs_c_0_5_FROM,
      O => CHOICE2177
    );
  XLXI_1_I1_n0021_6_65 : X_LUT4
    generic map(
      INIT => X"0B08"
    )
    port map (
      ADR0 => N44544,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_3,
      ADR2 => XLXI_1_pc_mux(2),
      ADR3 => XLXI_1_I1_stack_addrs_c_0_6,
      O => XLXI_1_I1_stack_addrs_c_0_6_FROM
    );
  XLXI_1_I1_n0021_6_72 : X_LUT4
    generic map(
      INIT => X"FFE0"
    )
    port map (
      ADR0 => CHOICE2183,
      ADR1 => CHOICE2189,
      ADR2 => XLXI_1_pc_mux(2),
      ADR3 => CHOICE2197,
      O => XLXI_1_I1_n0021(6)
    );
  XLXI_1_I1_stack_addrs_c_0_6_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_stack_addrs_c_0_6_FROM,
      O => CHOICE2197
    );
  XLXI_1_I1_n0021_9_12 : X_LUT4
    generic map(
      INIT => X"E040"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR1 => XLXI_1_I1_pc(9),
      ADR2 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR3 => XLXI_1_I1_stack_addrs_c_1_9,
      O => CHOICE2043_FROM
    );
  XLXI_1_I1_n0021_7_27 : X_LUT4
    generic map(
      INIT => X"3202"
    )
    port map (
      ADR0 => XLXI_1_I1_n0024(7),
      ADR1 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR3 => XLXI_1_I1_eaddr_x(7),
      O => CHOICE2043_GROM
    );
  CHOICE2043_XUSED : X_BUF
    port map (
      I => CHOICE2043_FROM,
      O => CHOICE2043
    );
  CHOICE2043_YUSED : X_BUF
    port map (
      I => CHOICE2043_GROM,
      O => CHOICE2209
    );
  XLXI_1_I1_n0021_8_27 : X_LUT4
    generic map(
      INIT => X"5410"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR2 => XLXI_1_I1_n0024(8),
      ADR3 => XLXI_1_I1_eaddr_x(8),
      O => CHOICE2229_FROM
    );
  XLXI_1_I1_n0021_8_12 : X_LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      ADR0 => XLXI_1_I2_pc_mux_x_0_79_4,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR2 => XLXI_1_I1_stack_addrs_c_1_8,
      ADR3 => XLXI_1_I1_pc(8),
      O => CHOICE2229_GROM
    );
  CHOICE2229_XUSED : X_BUF
    port map (
      I => CHOICE2229_FROM,
      O => CHOICE2229
    );
  CHOICE2229_YUSED : X_BUF
    port map (
      I => CHOICE2229_GROM,
      O => CHOICE2223
    );
  XLXI_1_I1_n0021_7_65 : X_LUT4
    generic map(
      INIT => X"0B08"
    )
    port map (
      ADR0 => N44528,
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR2 => XLXI_1_pc_mux(2),
      ADR3 => XLXI_1_I1_stack_addrs_c_0_7,
      O => XLXI_1_I1_stack_addrs_c_0_7_FROM
    );
  XLXI_1_I1_n0021_7_72 : X_LUT4
    generic map(
      INIT => X"FFE0"
    )
    port map (
      ADR0 => CHOICE2203,
      ADR1 => CHOICE2209,
      ADR2 => XLXI_1_pc_mux(2),
      ADR3 => CHOICE2217,
      O => XLXI_1_I1_n0021(7)
    );
  XLXI_1_I1_stack_addrs_c_0_7_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_stack_addrs_c_0_7_FROM,
      O => CHOICE2217
    );
  XLXI_55_nCS_REG_SW114_SW7_SW0 : X_LUT4
    generic map(
      INIT => X"77FF"
    )
    port map (
      ADR0 => IDATA(12),
      ADR1 => XLXI_1_I4_nreset_v(1),
      ADR2 => VCC,
      ADR3 => NRESET_BUFGP,
      O => N43374_FROM
    );
  XLXI_55_nCS_REG_SW114_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"3FFF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I4_nreset_v(1),
      ADR2 => NRESET_BUFGP,
      ADR3 => IDATA(12),
      O => N43374_GROM
    );
  N43374_XUSED : X_BUF
    port map (
      I => N43374_FROM,
      O => N43374
    );
  N43374_YUSED : X_BUF
    port map (
      I => N43374_GROM,
      O => N43346
    );
  XLXI_6_n00211 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => XLXI_6_tx_16_count(0),
      ADR1 => XLXI_6_tx_16_count(2),
      ADR2 => XLXI_6_tx_16_count(1),
      ADR3 => XLXI_6_tx_16_count(3),
      O => XLXI_6_n0021_FROM
    );
  XLXI_6_n0056_SW0 : X_LUT4
    generic map(
      INIT => X"E000"
    )
    port map (
      ADR0 => XLXI_6_tx_bit_count(1),
      ADR1 => XLXI_6_tx_bit_count(2),
      ADR2 => XLXI_6_tx_bit_count(3),
      ADR3 => XLXI_6_n0021,
      O => XLXI_6_n0021_GROM
    );
  XLXI_6_n0021_XUSED : X_BUF
    port map (
      I => XLXI_6_n0021_FROM,
      O => XLXI_6_n0021
    );
  XLXI_6_n0021_YUSED : X_BUF
    port map (
      I => XLXI_6_n0021_GROM,
      O => N29672
    );
  XLXI_55_mux_x_4_SW0 : X_LUT4
    generic map(
      INIT => X"CFCF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CPU_ADDR_OUT(2),
      ADR2 => NRESET_BUFGP,
      ADR3 => VCC,
      O => XLXI_55_mux_c_4_FROM
    );
  XLXI_55_mux_x_4_Q : X_LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      ADR0 => CPU_ADDR_OUT(3),
      ADR1 => CPU_ADDR_OUT(4),
      ADR2 => CPU_ADDR_OUT(8),
      ADR3 => N28591,
      O => XLXI_55_mux_x_4_O
    );
  XLXI_55_mux_c_4_XUSED : X_BUF
    port map (
      I => XLXI_55_mux_c_4_FROM,
      O => N28591
    );
  XLXI_55_mux_c_4_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_55_mux_c_4_SRMUX_OUTPUTNOT
    );
  XLXI_1_I1_n0021_8_65 : X_LUT4
    generic map(
      INIT => X"2320"
    )
    port map (
      ADR0 => N44512,
      ADR1 => XLXI_1_pc_mux(2),
      ADR2 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR3 => XLXI_1_I1_stack_addrs_c_0_8,
      O => XLXI_1_I1_stack_addrs_c_0_8_FROM
    );
  XLXI_1_I1_n0021_8_72 : X_LUT4
    generic map(
      INIT => X"FFE0"
    )
    port map (
      ADR0 => CHOICE2229,
      ADR1 => CHOICE2223,
      ADR2 => XLXI_1_pc_mux(2),
      ADR3 => CHOICE2237,
      O => XLXI_1_I1_n0021(8)
    );
  XLXI_1_I1_stack_addrs_c_0_8_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_stack_addrs_c_0_8_FROM,
      O => CHOICE2237
    );
  XLXI_1_I1_n0021_9_27 : X_LUT4
    generic map(
      INIT => X"00E2"
    )
    port map (
      ADR0 => XLXI_1_I1_n0024(9),
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR2 => XLXI_1_I1_eaddr_x(9),
      ADR3 => XLXI_1_I2_pc_mux_x_0_79_4,
      O => CHOICE2049_GROM
    );
  CHOICE2049_YUSED : X_BUF
    port map (
      I => CHOICE2049_GROM,
      O => CHOICE2049
    );
  XLXI_6_n00421 : X_LUT4
    generic map(
      INIT => X"5700"
    )
    port map (
      ADR0 => XLXI_6_tx_bit_count(3),
      ADR1 => XLXI_6_tx_bit_count(1),
      ADR2 => XLXI_6_tx_bit_count(2),
      ADR3 => XLXI_6_tx_s(0),
      O => XLXI_6_tx_bit_count_1_FROM
    );
  XLXI_6_n0010_1_1 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_6_n0040(1),
      ADR2 => VCC,
      ADR3 => XLXI_6_n0042,
      O => XLXI_6_n0010(1)
    );
  XLXI_6_tx_bit_count_1_XUSED : X_BUF
    port map (
      I => XLXI_6_tx_bit_count_1_FROM,
      O => XLXI_6_n0042
    );
  XLXI_6_tx_bit_count_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_bit_count_1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I1_n0021_9_65 : X_LUT4
    generic map(
      INIT => X"5140"
    )
    port map (
      ADR0 => XLXI_1_pc_mux(2),
      ADR1 => XLXI_1_I2_pc_mux_x_1_38_2,
      ADR2 => N44540,
      ADR3 => XLXI_1_I1_stack_addrs_c_0_9,
      O => XLXI_1_I1_stack_addrs_c_0_9_FROM
    );
  XLXI_1_I1_n0021_9_72 : X_LUT4
    generic map(
      INIT => X"FFC8"
    )
    port map (
      ADR0 => CHOICE2049,
      ADR1 => XLXI_1_pc_mux(2),
      ADR2 => CHOICE2043,
      ADR3 => CHOICE2057,
      O => XLXI_1_I1_n0021(9)
    );
  XLXI_1_I1_stack_addrs_c_0_9_XUSED : X_BUF
    port map (
      I => XLXI_1_I1_stack_addrs_c_0_9_FROM,
      O => CHOICE2057
    );
  XLXI_55_nCS_REG_SW114_SW5_SW0 : X_LUT4
    generic map(
      INIT => X"5FFF"
    )
    port map (
      ADR0 => IDATA(12),
      ADR1 => VCC,
      ADR2 => XLXI_1_I4_nreset_v(1),
      ADR3 => NRESET_BUFGP,
      O => N43366_FROM
    );
  XLXI_55_nCS_REG_SW114_SW1_SW0 : X_LUT4
    generic map(
      INIT => X"3FFF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => IDATA(12),
      ADR2 => XLXI_1_I4_nreset_v(1),
      ADR3 => NRESET_BUFGP,
      O => N43366_GROM
    );
  N43366_XUSED : X_BUF
    port map (
      I => N43366_FROM,
      O => N43366
    );
  N43366_YUSED : X_BUF
    port map (
      I => N43366_GROM,
      O => N43350
    );
  XLXI_1_I2_n0040_1_SW1 : X_LUT4
    generic map(
      INIT => X"BFBF"
    )
    port map (
      ADR0 => XLXI_1_I2_int_stop_c,
      ADR1 => NRESET_BUFGP,
      ADR2 => XLXI_1_I2_S_c(1),
      ADR3 => VCC,
      O => N43921_GROM
    );
  N43921_YUSED : X_BUF
    port map (
      I => N43921_GROM,
      O => N43921
    );
  XLXI_1_I1_nreset_v_1_LOGIC_ONE_292 : X_ONE
    port map (
      O => XLXI_1_I1_nreset_v_1_LOGIC_ONE
    );
  XLXI_1_I1_nreset_v_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I1_nreset_v_1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I2_n006210 : X_LUT4
    generic map(
      INIT => X"0400"
    )
    port map (
      ADR0 => XLXI_1_I2_skip_c,
      ADR1 => XLXI_1_I2_TC_c(1),
      ADR2 => XLXI_1_I2_TC_c(2),
      ADR3 => XLXI_1_I2_TC_c(0),
      O => CHOICE3008_GROM
    );
  CHOICE3008_YUSED : X_BUF
    port map (
      I => CHOICE3008_GROM,
      O => CHOICE3008
    );
  XLXI_55_nCS_REG_SW114_SW4_SW0 : X_LUT4
    generic map(
      INIT => X"7F7F"
    )
    port map (
      ADR0 => IDATA(12),
      ADR1 => XLXI_1_I4_nreset_v(1),
      ADR2 => NRESET_BUFGP,
      ADR3 => VCC,
      O => N43362_FROM
    );
  XLXI_55_nCS_REG_SW114_SW2_SW0 : X_LUT4
    generic map(
      INIT => X"7F7F"
    )
    port map (
      ADR0 => IDATA(12),
      ADR1 => XLXI_1_I4_nreset_v(1),
      ADR2 => NRESET_BUFGP,
      ADR3 => VCC,
      O => N43362_GROM
    );
  N43362_XUSED : X_BUF
    port map (
      I => N43362_FROM,
      O => N43362
    );
  N43362_YUSED : X_BUF
    port map (
      I => N43362_GROM,
      O => N43354
    );
  XLXI_1_I2_TD_x_0_39 : X_LUT4
    generic map(
      INIT => X"0020"
    )
    port map (
      ADR0 => CHOICE1073,
      ADR1 => IDATA(0),
      ADR2 => IDATA(4),
      ADR3 => IDATA(3),
      O => XLXI_1_I2_TD_c_0_FROM
    );
  XLXI_1_I2_TD_x_0_76 : X_LUT4
    generic map(
      INIT => X"C8C0"
    )
    port map (
      ADR0 => CHOICE1070,
      ADR1 => NRESET_BUFGP,
      ADR2 => CHOICE1061,
      ADR3 => CHOICE1078,
      O => XLXI_1_I2_TD_c_0_GROM
    );
  XLXI_1_I2_TD_c_0_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_TD_c_0_FROM,
      O => CHOICE1078
    );
  XLXI_1_I2_TD_c_0_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_TD_c_0_GROM,
      O => XLXI_1_I2_TD_x(0)
    );
  XLXI_1_I2_TD_c_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_TD_c_0_SRMUX_OUTPUTNOT
    );
  XLXI_1_I2_TD_x_1_52 : X_LUT4
    generic map(
      INIT => X"1720"
    )
    port map (
      ADR0 => IDATA(6),
      ADR1 => IDATA(7),
      ADR2 => IDATA(4),
      ADR3 => IDATA(5),
      O => CHOICE1097_GROM
    );
  CHOICE1097_YUSED : X_BUF
    port map (
      I => CHOICE1097_GROM,
      O => CHOICE1097
    );
  XLXI_1_I2_TD_x_1_61 : X_LUT4
    generic map(
      INIT => X"0101"
    )
    port map (
      ADR0 => IDATA(0),
      ADR1 => IDATA(3),
      ADR2 => IDATA(2),
      ADR3 => VCC,
      O => XLXI_1_I2_TD_c_1_FROM
    );
  XLXI_1_I2_TD_x_1_97 : X_LUT4
    generic map(
      INIT => X"E0A0"
    )
    port map (
      ADR0 => IDATA(1),
      ADR1 => CHOICE1097,
      ADR2 => NRESET_BUFGP,
      ADR3 => CHOICE1102,
      O => XLXI_1_I2_TD_c_1_GROM
    );
  XLXI_1_I2_TD_c_1_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_TD_c_1_FROM,
      O => CHOICE1102
    );
  XLXI_1_I2_TD_c_1_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_TD_c_1_GROM,
      O => XLXI_1_I2_TD_x(1)
    );
  XLXI_1_I2_TD_c_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_TD_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I2_data_is_c_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_data_is_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I2_TD_x_2_38 : X_LUT4
    generic map(
      INIT => X"0005"
    )
    port map (
      ADR0 => IDATA(3),
      ADR1 => VCC,
      ADR2 => IDATA(0),
      ADR3 => IDATA(1),
      O => XLXI_1_I2_TD_c_2_FROM
    );
  XLXI_1_I2_TD_x_2_72 : X_LUT4
    generic map(
      INIT => X"C8C0"
    )
    port map (
      ADR0 => CHOICE1051,
      ADR1 => NRESET_BUFGP,
      ADR2 => IDATA(2),
      ADR3 => CHOICE1056,
      O => XLXI_1_I2_TD_c_2_GROM
    );
  XLXI_1_I2_TD_c_2_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_TD_c_2_FROM,
      O => CHOICE1056
    );
  XLXI_1_I2_TD_c_2_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_TD_c_2_GROM,
      O => XLXI_1_I2_TD_x(2)
    );
  XLXI_1_I2_TD_c_2_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_TD_c_2_SRMUX_OUTPUTNOT
    );
  XLXI_55_nCS_REG_SW114_SW3_SW0 : X_LUT4
    generic map(
      INIT => X"5FFF"
    )
    port map (
      ADR0 => IDATA(12),
      ADR1 => VCC,
      ADR2 => XLXI_1_I4_nreset_v(1),
      ADR3 => NRESET_BUFGP,
      O => N43358_GROM
    );
  N43358_YUSED : X_BUF
    port map (
      I => N43358_GROM,
      O => N43358
    );
  XLXI_1_I2_nreset_v_1_LOGIC_ONE_293 : X_ONE
    port map (
      O => XLXI_1_I2_nreset_v_1_LOGIC_ONE
    );
  XLXI_1_I2_nreset_v_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_nreset_v_1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I2_data_is_c_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_data_is_c_3_SRMUX_OUTPUTNOT
    );
  XLXI_1_I2_data_is_c_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_data_is_c_5_SRMUX_OUTPUTNOT
    );
  XLXI_6_tx_uart_shift_1_LOGIC_ZERO_294 : X_ZERO
    port map (
      O => XLXI_6_tx_uart_shift_1_LOGIC_ZERO
    );
  XLXI_6_tx_uart_shift_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_uart_shift_1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I2_data_is_c_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_data_is_c_7_SRMUX_OUTPUTNOT
    );
  XLXI_6_tx_uart_shift_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_uart_shift_3_SRMUX_OUTPUTNOT
    );
  XLXI_6_tx_uart_shift_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_uart_shift_5_SRMUX_OUTPUTNOT
    );
  XLXI_6_tx_uart_shift_7_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_6_tx_uart_shift_7_SRMUX_OUTPUTNOT,
      O => XLXI_6_tx_uart_shift_7_FFY_SET
    );
  XLXI_6_tx_uart_shift_6 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_6_tx_uart_fifo(5),
      CE => XLXI_6_n0061,
      CLK => UCLK_BUFGP,
      SET => XLXI_6_tx_uart_shift_7_FFY_SET,
      RST => GND,
      O => XLXI_6_tx_uart_shift(6)
    );
  XLXI_6_tx_uart_shift_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_uart_shift_7_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_n0115_2_0 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I3_N19927,
      ADR2 => VCC,
      ADR3 => XLXI_1_I3_acc_c_0_2,
      O => CHOICE2570_FROM
    );
  XLXI_1_I3_n0115_2_13_SW1 : X_LUT4
    generic map(
      INIT => X"EEAE"
    )
    port map (
      ADR0 => CHOICE2597,
      ADR1 => XLXI_1_I3_n0076,
      ADR2 => XLXI_1_I2_TD_c(3),
      ADR3 => XLXI_1_I3_acc_c_0_2,
      O => CHOICE2570_GROM
    );
  CHOICE2570_XUSED : X_BUF
    port map (
      I => CHOICE2570_FROM,
      O => CHOICE2570
    );
  CHOICE2570_YUSED : X_BUF
    port map (
      I => CHOICE2570_GROM,
      O => N43338
    );
  XLXI_6_tx_uart_shift_8_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_uart_shift_8_SRMUX_OUTPUTNOT
    );
  XLXI_1_I1_n0021_2_65_SW1 : X_LUT4
    generic map(
      INIT => X"FE10"
    )
    port map (
      ADR0 => CHOICE2381,
      ADR1 => CHOICE2367,
      ADR2 => XLXI_1_I1_stack_addrs_c_0_2,
      ADR3 => XLXI_1_I1_n0024(2),
      O => N44508_FROM
    );
  XLXI_1_I1_n0021_8_65_SW1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => CHOICE2367,
      ADR1 => XLXI_1_I1_n0024(8),
      ADR2 => CHOICE2381,
      ADR3 => XLXI_1_I1_stack_addrs_c_0_8,
      O => N44508_GROM
    );
  N44508_XUSED : X_BUF
    port map (
      I => N44508_FROM,
      O => N44508
    );
  N44508_YUSED : X_BUF
    port map (
      I => N44508_GROM,
      O => N44512
    );
  XLXI_1_I3_Mmux_data_x_Result_3_140_SW3 : X_LUT4
    generic map(
      INIT => X"A5C3"
    )
    port map (
      ADR0 => XLXI_1_I2_data_is_c(3),
      ADR1 => XLXI_1_I4_n00371_1,
      ADR2 => XLXI_1_I3_acc_c_0_3,
      ADR3 => XLXI_1_I3_n0025,
      O => N43204_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_3_140_SW0 : X_LUT4
    generic map(
      INIT => X"9393"
    )
    port map (
      ADR0 => XLXI_1_I3_n0025,
      ADR1 => XLXI_1_I3_acc_c_0_3,
      ADR2 => XLXI_1_I2_data_is_c(3),
      ADR3 => VCC,
      O => N43204_GROM
    );
  N43204_XUSED : X_BUF
    port map (
      I => N43204_FROM,
      O => N43204
    );
  N43204_YUSED : X_BUF
    port map (
      I => N43204_GROM,
      O => N43160
    );
  XLXI_1_I3_Mmux_data_x_Result_7_140_SW3 : X_LUT4
    generic map(
      INIT => X"D827"
    )
    port map (
      ADR0 => XLXI_1_I3_n0025,
      ADR1 => XLXI_1_I2_data_is_c(7),
      ADR2 => XLXI_1_I4_n00371_1,
      ADR3 => XLXI_1_I3_acc_c_0_7,
      O => N43234_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_3_140_SW1 : X_LUT4
    generic map(
      INIT => X"A965"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_3,
      ADR1 => XLXI_1_I3_n0025,
      ADR2 => XLXI_1_I4_n00371_1,
      ADR3 => XLXI_1_I2_data_is_c(3),
      O => N43234_GROM
    );
  N43234_XUSED : X_BUF
    port map (
      I => N43234_FROM,
      O => N43234
    );
  N43234_YUSED : X_BUF
    port map (
      I => N43234_GROM,
      O => N43162
    );
  XLXI_1_I4_ndre_x1 : X_LUT4
    generic map(
      INIT => X"FFCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I2_ndre_x1_1,
      ADR2 => VCC,
      ADR3 => XLXI_1_I4_Ker217601_1,
      O => XLXI_26_rx_uart_full_c_FROM
    );
  XLXI_26_n00321 : X_LUT4
    generic map(
      INIT => X"1015"
    )
    port map (
      ADR0 => nCS_UART,
      ADR1 => XLXI_1_I5_ndwe_c,
      ADR2 => XLXI_1_I5_Mmux_daddr_out_Result_0_1_1,
      ADR3 => nRE_CPU,
      O => XLXI_26_n00321_O
    );
  XLXI_26_rx_uart_full_c_XUSED : X_BUF
    port map (
      I => XLXI_26_rx_uart_full_c_FROM,
      O => nRE_CPU
    );
  XLXI_26_rx_uart_full_c_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_uart_full_c_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_nreset_v_1_LOGIC_ONE_295 : X_ONE
    port map (
      O => XLXI_1_I3_nreset_v_1_LOGIC_ONE
    );
  XLXI_1_I3_nreset_v_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I3_nreset_v_1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_Mmux_data_x_Result_4_140_SW0 : X_LUT4
    generic map(
      INIT => X"A50F"
    )
    port map (
      ADR0 => XLXI_1_I3_n0025,
      ADR1 => VCC,
      ADR2 => XLXI_1_I3_acc_c_0_4,
      ADR3 => XLXI_1_I2_data_is_c(4),
      O => N43166_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_7_140_SW2 : X_LUT4
    generic map(
      INIT => X"A555"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_7,
      ADR1 => VCC,
      ADR2 => XLXI_1_I2_data_is_c(7),
      ADR3 => XLXI_1_I3_n0025,
      O => N43166_GROM
    );
  N43166_XUSED : X_BUF
    port map (
      I => N43166_FROM,
      O => N43166
    );
  N43166_YUSED : X_BUF
    port map (
      I => N43166_GROM,
      O => N43232
    );
  XLXI_1_I3_n0115_2_72_SW0 : X_LUT4
    generic map(
      INIT => X"F080"
    )
    port map (
      ADR0 => N43410,
      ADR1 => CHOICE2575,
      ADR2 => XLXI_1_I3_n0023,
      ADR3 => CHOICE2597,
      O => N43280_FROM
    );
  XLXI_1_I3_n0115_1_72_SW0 : X_LUT4
    generic map(
      INIT => X"F080"
    )
    port map (
      ADR0 => N43386,
      ADR1 => CHOICE2511,
      ADR2 => XLXI_1_I3_n0023,
      ADR3 => CHOICE2533,
      O => N43280_GROM
    );
  N43280_XUSED : X_BUF
    port map (
      I => N43280_FROM,
      O => N43280
    );
  N43280_YUSED : X_BUF
    port map (
      I => N43280_GROM,
      O => N43286
    );
  XLXI_1_I4_nreset_v_1_LOGIC_ONE_296 : X_ONE
    port map (
      O => XLXI_1_I4_nreset_v_1_LOGIC_ONE
    );
  XLXI_1_I4_nreset_v_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I4_nreset_v_1_SRMUX_OUTPUTNOT
    );
  XLXI_6_n0016119 : X_LUT4
    generic map(
      INIT => X"00E4"
    )
    port map (
      ADR0 => XLXI_6_tx_bit_count(1),
      ADR1 => XLXI_6_tx_uart_shift(4),
      ADR2 => XLXI_6_tx_uart_shift(6),
      ADR3 => XLXI_6_tx_bit_count(0),
      O => CHOICE842_FROM
    );
  XLXI_6_n0016104 : X_LUT4
    generic map(
      INIT => X"D800"
    )
    port map (
      ADR0 => XLXI_6_tx_bit_count(1),
      ADR1 => XLXI_6_tx_uart_shift(7),
      ADR2 => XLXI_6_tx_uart_shift(5),
      ADR3 => XLXI_6_tx_bit_count(0),
      O => CHOICE842_GROM
    );
  CHOICE842_XUSED : X_BUF
    port map (
      I => CHOICE842_FROM,
      O => CHOICE842
    );
  CHOICE842_YUSED : X_BUF
    port map (
      I => CHOICE842_GROM,
      O => CHOICE836
    );
  XLXI_6_n0016134 : X_LUT4
    generic map(
      INIT => X"0C0C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_6_tx_bit_count(2),
      ADR2 => XLXI_6_tx_bit_count(3),
      ADR3 => VCC,
      O => CHOICE845_GROM
    );
  CHOICE845_YUSED : X_BUF
    port map (
      I => CHOICE845_GROM,
      O => CHOICE845
    );
  XLXI_6_n0016153 : X_LUT4
    generic map(
      INIT => X"EF0F"
    )
    port map (
      ADR0 => CHOICE842,
      ADR1 => CHOICE836,
      ADR2 => XLXI_6_tx_s(0),
      ADR3 => CHOICE845,
      O => CHOICE847_FROM
    );
  XLXI_6_n0016167 : X_LUT4
    generic map(
      INIT => X"FF44"
    )
    port map (
      ADR0 => XLXI_6_tx_bit_count(2),
      ADR1 => CHOICE828,
      ADR2 => VCC,
      ADR3 => CHOICE847,
      O => CHOICE847_GROM
    );
  CHOICE847_XUSED : X_BUF
    port map (
      I => CHOICE847_FROM,
      O => CHOICE847
    );
  CHOICE847_YUSED : X_BUF
    port map (
      I => CHOICE847_GROM,
      O => XLXI_6_n0016
    );
  XLXI_1_I3_n0115_0_151 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => CHOICE2462,
      ADR1 => XLXI_1_I3_acc_i_0_0,
      ADR2 => XLXI_1_I3_n0067,
      ADR3 => XLXI_1_I3_N20122,
      O => CHOICE2464_FROM
    );
  XLXI_1_I3_n0115_0_191_SW1_SW0 : X_LUT4
    generic map(
      INIT => X"FF06"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c_1_1,
      ADR1 => XLXI_1_I2_TC_c_0_1,
      ADR2 => XLXI_1_I2_TC_c_2_1,
      ADR3 => CHOICE2464,
      O => CHOICE2464_GROM
    );
  CHOICE2464_XUSED : X_BUF
    port map (
      I => CHOICE2464_FROM,
      O => CHOICE2464
    );
  CHOICE2464_YUSED : X_BUF
    port map (
      I => CHOICE2464_GROM,
      O => N44416
    );
  XLXI_1_I3_Mmux_data_x_Result_3_2 : X_LUT4
    generic map(
      INIT => X"AA00"
    )
    port map (
      ADR0 => XLXI_55_mux_c(3),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_5_tmr_high(3),
      O => CHOICE2764_FROM
    );
  XLXI_5_n001012 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_5_tmr_high(0),
      ADR1 => XLXI_5_tmr_high(3),
      ADR2 => XLXI_5_tmr_high(2),
      ADR3 => XLXI_5_tmr_high(1),
      O => CHOICE2764_GROM
    );
  CHOICE2764_XUSED : X_BUF
    port map (
      I => CHOICE2764_FROM,
      O => CHOICE2764
    );
  CHOICE2764_YUSED : X_BUF
    port map (
      I => CHOICE2764_GROM,
      O => CHOICE885
    );
  XLXI_5_n001025 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_5_tmr_high(7),
      ADR1 => XLXI_5_tmr_high(4),
      ADR2 => XLXI_5_tmr_high(5),
      ADR3 => XLXI_5_tmr_high(6),
      O => CHOICE892_FROM
    );
  XLXI_5_n001038 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => CHOICE870,
      ADR1 => CHOICE877,
      ADR2 => CHOICE885,
      ADR3 => CHOICE892,
      O => CHOICE892_GROM
    );
  CHOICE892_XUSED : X_BUF
    port map (
      I => CHOICE892_FROM,
      O => CHOICE892
    );
  CHOICE892_YUSED : X_BUF
    port map (
      I => CHOICE892_GROM,
      O => XLXI_5_n0010
    );
  XLXI_1_I3_Mmux_data_x_Result_2_0 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c_2_1,
      ADR1 => XLXI_1_I2_TC_c_0_1,
      ADR2 => XLXI_1_I2_TC_c_1_1,
      ADR3 => XLXI_1_I2_data_is_c(2),
      O => CHOICE2826_FROM
    );
  XLXI_1_I3_n0115_3_13_SW2 : X_LUT4
    generic map(
      INIT => X"1200"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c_0_1,
      ADR1 => XLXI_1_I2_TC_c_2_1,
      ADR2 => XLXI_1_I2_TC_c_1_1,
      ADR3 => XLXI_1_I3_acc_c_0_3,
      O => CHOICE2826_GROM
    );
  CHOICE2826_XUSED : X_BUF
    port map (
      I => CHOICE2826_FROM,
      O => CHOICE2826
    );
  CHOICE2826_YUSED : X_BUF
    port map (
      I => CHOICE2826_GROM,
      O => N43406
    );
  XLXI_1_I3_n0115_1_106 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_i_0_1,
      ADR1 => XLXI_1_I3_n0067,
      ADR2 => N43846,
      ADR3 => XLXI_1_I3_N20122,
      O => CHOICE2533_FROM
    );
  XLXI_1_I3_n0115_1_13_SW0 : X_LUT4
    generic map(
      INIT => X"FF30"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I2_TD_c(3),
      ADR2 => XLXI_1_I3_n0076,
      ADR3 => CHOICE2533,
      O => CHOICE2533_GROM
    );
  CHOICE2533_XUSED : X_BUF
    port map (
      I => CHOICE2533_FROM,
      O => CHOICE2533
    );
  CHOICE2533_YUSED : X_BUF
    port map (
      I => CHOICE2533_GROM,
      O => N43300
    );
  XLXI_4_int_mask_c_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_mask_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_4_int_mask_c_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_mask_c_3_SRMUX_OUTPUTNOT
    );
  XLXI_5_n001512 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_5_tmr_low(0),
      ADR1 => XLXI_5_tmr_low(1),
      ADR2 => XLXI_5_tmr_low(2),
      ADR3 => XLXI_5_tmr_low(3),
      O => CHOICE870_GROM
    );
  CHOICE870_YUSED : X_BUF
    port map (
      I => CHOICE870_GROM,
      O => CHOICE870
    );
  XLXI_4_int_mask_c_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_mask_c_5_SRMUX_OUTPUTNOT
    );
  XLXI_4_int_mask_c_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_mask_c_7_SRMUX_OUTPUTNOT
    );
  XLXI_26_n00261 : X_LUT4
    generic map(
      INIT => X"4000"
    )
    port map (
      ADR0 => XLXI_26_rx_8_count(3),
      ADR1 => XLXI_26_rx_8_count(0),
      ADR2 => XLXI_26_rx_8_count(1),
      ADR3 => XLXI_26_rx_8_count(2),
      O => XLXI_26_n0026_FROM
    );
  XLXI_26_Ker16143_SW0 : X_LUT4
    generic map(
      INIT => X"FFF7"
    )
    port map (
      ADR0 => XLXI_26_rx_s_FFd1,
      ADR1 => XLXI_26_rx_uart_reg(8),
      ADR2 => XLXI_26_rx_8_count(3),
      ADR3 => XLXI_26_rx_8_count(2),
      O => XLXI_26_n0026_GROM
    );
  XLXI_26_n0026_XUSED : X_BUF
    port map (
      I => XLXI_26_n0026_FROM,
      O => XLXI_26_n0026
    );
  XLXI_26_n0026_YUSED : X_BUF
    port map (
      I => XLXI_26_n0026_GROM,
      O => N29718
    );
  XLXI_5_n001525 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_5_tmr_low(7),
      ADR1 => XLXI_5_tmr_low(6),
      ADR2 => XLXI_5_tmr_low(5),
      ADR3 => XLXI_5_tmr_low(4),
      O => CHOICE877_FROM
    );
  XLXI_5_n001526 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => CHOICE870,
      ADR3 => CHOICE877,
      O => CHOICE877_GROM
    );
  CHOICE877_XUSED : X_BUF
    port map (
      I => CHOICE877_FROM,
      O => CHOICE877
    );
  CHOICE877_YUSED : X_BUF
    port map (
      I => CHOICE877_GROM,
      O => XLXI_5_n0015
    );
  XLXI_1_I3_n0115_2_106 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_i_0_2,
      ADR1 => N43854,
      ADR2 => XLXI_1_I3_n0067,
      ADR3 => XLXI_1_I3_N20122,
      O => CHOICE2597_FROM
    );
  XLXI_1_I3_n0115_2_13_SW0 : X_LUT4
    generic map(
      INIT => X"FF0A"
    )
    port map (
      ADR0 => XLXI_1_I3_n0076,
      ADR1 => VCC,
      ADR2 => XLXI_1_I2_TD_c(3),
      ADR3 => CHOICE2597,
      O => CHOICE2597_GROM
    );
  CHOICE2597_XUSED : X_BUF
    port map (
      I => CHOICE2597_FROM,
      O => CHOICE2597
    );
  CHOICE2597_YUSED : X_BUF
    port map (
      I => CHOICE2597_GROM,
      O => N43336
    );
  XLXI_26_Ker160951 : X_LUT4
    generic map(
      INIT => X"FFCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_26_rx_s_FFd1,
      ADR2 => VCC,
      ADR3 => XLXI_26_rx_s_FFd3,
      O => XLXI_26_N16097_FROM
    );
  XLXI_26_Ker161021 : X_LUT4
    generic map(
      INIT => X"FAFA"
    )
    port map (
      ADR0 => XLXI_26_rx_s_FFd2,
      ADR1 => VCC,
      ADR2 => XLXI_26_rx_s_FFd3,
      ADR3 => VCC,
      O => XLXI_26_N16097_GROM
    );
  XLXI_26_N16097_XUSED : X_BUF
    port map (
      I => XLXI_26_N16097_FROM,
      O => XLXI_26_N16097
    );
  XLXI_26_N16097_YUSED : X_BUF
    port map (
      I => XLXI_26_N16097_GROM,
      O => XLXI_26_N16104
    );
  XLXI_6_tx_s_0_BYMUX : X_INV
    port map (
      I => XLXI_6_tx_s(0),
      O => XLXI_6_tx_s_0_BYMUXNOT
    );
  XLXI_6_tx_s_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_6_tx_s_0_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_n0115_3_106 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_i_0_3,
      ADR1 => N43834,
      ADR2 => XLXI_1_I3_n0067,
      ADR3 => XLXI_1_I3_N20122,
      O => CHOICE2661_FROM
    );
  XLXI_1_I3_n0115_3_13_SW1 : X_LUT4
    generic map(
      INIT => X"FFC4"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c_3_1,
      ADR1 => XLXI_1_I3_n0076,
      ADR2 => XLXI_1_I3_acc_c_0_3,
      ADR3 => CHOICE2661,
      O => CHOICE2661_GROM
    );
  CHOICE2661_XUSED : X_BUF
    port map (
      I => CHOICE2661_FROM,
      O => CHOICE2661
    );
  CHOICE2661_YUSED : X_BUF
    port map (
      I => CHOICE2661_GROM,
      O => N43314
    );
  XLXI_1_I2_TC_x_0_SW0 : X_LUT4
    generic map(
      INIT => X"CCCE"
    )
    port map (
      ADR0 => XLXI_1_I2_N18976,
      ADR1 => IDATA(0),
      ADR2 => IDATA(4),
      ADR3 => IDATA(3),
      O => XLXI_1_I2_TC_c_0_FROM
    );
  XLXI_1_I2_TC_x_0_Q : X_LUT4
    generic map(
      INIT => X"2A08"
    )
    port map (
      ADR0 => NRESET_BUFGP,
      ADR1 => XLXI_1_I2_N18884,
      ADR2 => IDATA(3),
      ADR3 => N27948,
      O => XLXI_1_I2_TC_c_0_GROM
    );
  XLXI_1_I2_TC_c_0_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_TC_c_0_FROM,
      O => N27948
    );
  XLXI_1_I2_TC_c_0_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_TC_c_0_GROM,
      O => XLXI_1_I2_TC_x(0)
    );
  XLXI_1_I2_TC_c_0_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_TC_c_0_SRMUX_OUTPUTNOT
    );
  XLXI_26_Ker161721 : X_LUT4
    generic map(
      INIT => X"3300"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_26_n0026,
      ADR2 => VCC,
      ADR3 => XLXI_26_rx_s_FFd1,
      O => XLXI_26_rx_8_count_1_FROM
    );
  XLXI_26_n0041_1_1 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_26_rx_8_count(1),
      ADR1 => XLXI_26_n0060(1),
      ADR2 => XLXI_26_N16104,
      ADR3 => XLXI_26_N16174,
      O => XLXI_26_n0041(1)
    );
  XLXI_26_rx_8_count_1_XUSED : X_BUF
    port map (
      I => XLXI_26_rx_8_count_1_FROM,
      O => XLXI_26_N16174
    );
  XLXI_26_rx_8_count_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_8_count_1_SRMUX_OUTPUTNOT
    );
  XLXI_26_Ker161801 : X_LUT4
    generic map(
      INIT => X"3300"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_26_n0024,
      ADR2 => VCC,
      ADR3 => XLXI_26_rx_s_FFd2,
      O => XLXI_26_rx_16_count_1_FROM
    );
  XLXI_26_n0042_1_1 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_26_N16097,
      ADR1 => XLXI_26_n0061(1),
      ADR2 => XLXI_26_rx_16_count(1),
      ADR3 => XLXI_26_N16182,
      O => XLXI_26_n0042(1)
    );
  XLXI_26_rx_16_count_1_XUSED : X_BUF
    port map (
      I => XLXI_26_rx_16_count_1_FROM,
      O => XLXI_26_N16182
    );
  XLXI_26_rx_16_count_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_16_count_1_SRMUX_OUTPUTNOT
    );
  XLXI_26_Ker161491 : X_LUT4
    generic map(
      INIT => X"1100"
    )
    port map (
      ADR0 => RXD_IBUF,
      ADR1 => XLXI_26_n0023,
      ADR2 => VCC,
      ADR3 => XLXI_26_rx_s_FFd3,
      O => XLXI_26_rx_8z_count_1_FROM
    );
  XLXI_26_n0040_1_1 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_26_N16111,
      ADR1 => XLXI_26_rx_8z_count(1),
      ADR2 => XLXI_26_n0059(1),
      ADR3 => XLXI_26_N16151,
      O => XLXI_26_n0040(1)
    );
  XLXI_26_rx_8z_count_1_XUSED : X_BUF
    port map (
      I => XLXI_26_rx_8z_count_1_FROM,
      O => XLXI_26_N16151
    );
  XLXI_26_rx_8z_count_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_8z_count_1_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_n0115_4_106 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_1_I3_N20122,
      ADR1 => N43838,
      ADR2 => XLXI_1_I3_n0067,
      ADR3 => XLXI_1_I3_acc_i_0_4,
      O => CHOICE2758_FROM
    );
  XLXI_1_I3_n0115_4_13_SW1 : X_LUT4
    generic map(
      INIT => X"FFC4"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c_3_1,
      ADR1 => XLXI_1_I3_n0076,
      ADR2 => XLXI_1_I3_acc_c_0_4,
      ADR3 => CHOICE2758,
      O => CHOICE2758_GROM
    );
  CHOICE2758_XUSED : X_BUF
    port map (
      I => CHOICE2758_FROM,
      O => CHOICE2758
    );
  CHOICE2758_YUSED : X_BUF
    port map (
      I => CHOICE2758_GROM,
      O => N43320
    );
  XLXI_1_I3_Mmux_data_x_Result_0_140 : X_LUT4
    generic map(
      INIT => X"FEAA"
    )
    port map (
      ADR0 => CHOICE2969,
      ADR1 => CHOICE2996,
      ADR2 => CHOICE2986,
      ADR3 => CHOICE2695,
      O => XLXI_1_I3_data_x_0_FROM
    );
  XLXI_1_I3_n0115_0_27 : X_LUT4
    generic map(
      INIT => X"F0E2"
    )
    port map (
      ADR0 => N43510,
      ADR1 => CHOICE2986,
      ADR2 => N43512,
      ADR3 => CHOICE2996,
      O => XLXI_1_I3_data_x_0_GROM
    );
  XLXI_1_I3_data_x_0_XUSED : X_BUF
    port map (
      I => XLXI_1_I3_data_x_0_FROM,
      O => XLXI_1_I3_data_x(0)
    );
  XLXI_1_I3_data_x_0_YUSED : X_BUF
    port map (
      I => XLXI_1_I3_data_x_0_GROM,
      O => CHOICE2437
    );
  XLXI_26_Ker161951 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => CHOICE1039,
      ADR1 => XLXI_26_rx_bit_count(0),
      ADR2 => XLXI_26_N16130,
      ADR3 => CHOICE1032,
      O => XLXI_26_N16197_FROM
    );
  XLXI_26_n01141 : X_LUT4
    generic map(
      INIT => X"0A00"
    )
    port map (
      ADR0 => XLXI_26_rx_bit_count(1),
      ADR1 => VCC,
      ADR2 => XLXI_26_rx_bit_count(2),
      ADR3 => XLXI_26_N16197,
      O => XLXI_26_N16197_GROM
    );
  XLXI_26_N16197_XUSED : X_BUF
    port map (
      I => XLXI_26_N16197_FROM,
      O => XLXI_26_N16197
    );
  XLXI_26_N16197_YUSED : X_BUF
    port map (
      I => XLXI_26_N16197_GROM,
      O => XLXI_26_n0114
    );
  XLXI_1_I3_n0115_4_19 : X_LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      ADR0 => XLXI_1_I3_n0066(4),
      ADR1 => XLXI_1_I2_TD_c_2_1,
      ADR2 => XLXI_1_I2_TD_c_0_1,
      ADR3 => XLXI_1_I2_TD_c_1_1,
      O => CHOICE2738_FROM
    );
  XLXI_1_I3_n0115_0_36 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_1_I3_n0066(0),
      ADR1 => XLXI_1_I2_TD_c_0_1,
      ADR2 => XLXI_1_I2_TD_c_1_1,
      ADR3 => XLXI_1_I2_TD_c_2_1,
      O => CHOICE2738_GROM
    );
  CHOICE2738_XUSED : X_BUF
    port map (
      I => CHOICE2738_FROM,
      O => CHOICE2738
    );
  CHOICE2738_YUSED : X_BUF
    port map (
      I => CHOICE2738_GROM,
      O => CHOICE2438
    );
  XLXI_1_I3_n0115_6_19 : X_LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c_2_1,
      ADR1 => XLXI_1_I2_TD_c_1_1,
      ADR2 => XLXI_1_I2_TD_c_0_1,
      ADR3 => XLXI_1_I3_n0066(6),
      O => CHOICE2866_FROM
    );
  XLXI_1_I3_n0115_0_44 : X_LUT4
    generic map(
      INIT => X"B500"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c_2_1,
      ADR1 => XLXI_1_I3_acc_c_0_0,
      ADR2 => XLXI_1_I2_TD_c_0_1,
      ADR3 => XLXI_1_I2_TD_c_1_1,
      O => CHOICE2866_GROM
    );
  CHOICE2866_XUSED : X_BUF
    port map (
      I => CHOICE2866_FROM,
      O => CHOICE2866
    );
  CHOICE2866_YUSED : X_BUF
    port map (
      I => CHOICE2866_GROM,
      O => CHOICE2442
    );
  XLXI_26_Ker161881 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => XLXI_26_rx_bit_count(0),
      ADR1 => XLXI_26_N16130,
      ADR2 => CHOICE1032,
      ADR3 => CHOICE1039,
      O => XLXI_26_N16190_FROM
    );
  XLXI_26_n01161 : X_LUT4
    generic map(
      INIT => X"1100"
    )
    port map (
      ADR0 => XLXI_26_rx_bit_count(2),
      ADR1 => XLXI_26_rx_bit_count(1),
      ADR2 => VCC,
      ADR3 => XLXI_26_N16190,
      O => XLXI_26_N16190_GROM
    );
  XLXI_26_N16190_XUSED : X_BUF
    port map (
      I => XLXI_26_N16190_FROM,
      O => XLXI_26_N16190
    );
  XLXI_26_N16190_YUSED : X_BUF
    port map (
      I => XLXI_26_N16190_GROM,
      O => XLXI_26_n0116
    );
  XLXI_1_I3_n0115_5_106 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_i_0_5,
      ADR1 => N43842,
      ADR2 => XLXI_1_I3_n0067,
      ADR3 => XLXI_1_I3_N20122,
      O => CHOICE2822_FROM
    );
  XLXI_1_I3_n0115_5_13_SW1 : X_LUT4
    generic map(
      INIT => X"FF8C"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_5,
      ADR1 => XLXI_1_I3_n0076,
      ADR2 => XLXI_1_I2_TD_c_3_1,
      ADR3 => CHOICE2822,
      O => CHOICE2822_GROM
    );
  CHOICE2822_XUSED : X_BUF
    port map (
      I => CHOICE2822_FROM,
      O => CHOICE2822
    );
  CHOICE2822_YUSED : X_BUF
    port map (
      I => CHOICE2822_GROM,
      O => N43326
    );
  XLXI_1_I3_n0115_5_19 : X_LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c_1_1,
      ADR1 => XLXI_1_I3_n0066(5),
      ADR2 => XLXI_1_I2_TD_c_0_1,
      ADR3 => XLXI_1_I2_TD_c_2_1,
      O => CHOICE2802_FROM
    );
  XLXI_1_I3_n0115_1_19 : X_LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      ADR0 => XLXI_1_I3_n0066(1),
      ADR1 => XLXI_1_I2_TD_c_1_1,
      ADR2 => XLXI_1_I2_TD_c_0_1,
      ADR3 => XLXI_1_I2_TD_c_2_1,
      O => CHOICE2802_GROM
    );
  CHOICE2802_XUSED : X_BUF
    port map (
      I => CHOICE2802_FROM,
      O => CHOICE2802
    );
  CHOICE2802_YUSED : X_BUF
    port map (
      I => CHOICE2802_GROM,
      O => CHOICE2513
    );
  XLXI_1_I3_Mmux_data_x_Result_3_0 : X_LUT4
    generic map(
      INIT => X"0200"
    )
    port map (
      ADR0 => XLXI_1_I2_data_is_c(3),
      ADR1 => XLXI_1_I2_TC_c_0_1,
      ADR2 => XLXI_1_I2_TC_c_2_1,
      ADR3 => XLXI_1_I2_TC_c_1_1,
      O => CHOICE2762_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_0_0 : X_LUT4
    generic map(
      INIT => X"0020"
    )
    port map (
      ADR0 => XLXI_1_I2_data_is_c(0),
      ADR1 => XLXI_1_I2_TC_c_0_1,
      ADR2 => XLXI_1_I2_TC_c_1_1,
      ADR3 => XLXI_1_I2_TC_c_2_1,
      O => CHOICE2762_GROM
    );
  CHOICE2762_XUSED : X_BUF
    port map (
      I => CHOICE2762_FROM,
      O => CHOICE2762
    );
  CHOICE2762_YUSED : X_BUF
    port map (
      I => CHOICE2762_GROM,
      O => CHOICE2969
    );
  XLXI_1_I3_Mmux_data_x_Result_1_2 : X_LUT4
    generic map(
      INIT => X"C0C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_5_tmr_high(1),
      ADR2 => XLXI_55_mux_c(3),
      ADR3 => VCC,
      O => CHOICE2892_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_0_2 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_55_mux_c(3),
      ADR3 => XLXI_5_tmr_high(0),
      O => CHOICE2892_GROM
    );
  CHOICE2892_XUSED : X_BUF
    port map (
      I => CHOICE2892_FROM,
      O => CHOICE2892
    );
  CHOICE2892_YUSED : X_BUF
    port map (
      I => CHOICE2892_GROM,
      O => CHOICE2971
    );
  XLXI_1_I3_n0115_4_13_SW2 : X_LUT4
    generic map(
      INIT => X"0408"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c_0_1,
      ADR1 => XLXI_1_I3_acc_c_0_4,
      ADR2 => XLXI_1_I2_TC_c_2_1,
      ADR3 => XLXI_1_I2_TC_c_1_1,
      O => N43402_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_1_0 : X_LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      ADR0 => XLXI_1_I2_data_is_c(1),
      ADR1 => XLXI_1_I2_TC_c_1_1,
      ADR2 => XLXI_1_I2_TC_c_2_1,
      ADR3 => XLXI_1_I2_TC_c_0_1,
      O => N43402_GROM
    );
  N43402_XUSED : X_BUF
    port map (
      I => N43402_FROM,
      O => N43402
    );
  N43402_YUSED : X_BUF
    port map (
      I => N43402_GROM,
      O => CHOICE2890
    );
  XLXI_1_I3_n0115_1_90 : X_LUT4
    generic map(
      INIT => X"CE0A"
    )
    port map (
      ADR0 => XLXI_1_I3_n0060,
      ADR1 => XLXI_1_I3_acc_c_0_2,
      ADR2 => XLXI_1_I3_acc_c_0_1,
      ADR3 => XLXI_1_I3_N19837,
      O => CHOICE2530_FROM
    );
  XLXI_1_I3_n0115_1_106_SW0 : X_LUT4
    generic map(
      INIT => X"FF40"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c(2),
      ADR1 => XLXI_1_I3_acc_c_0_0,
      ADR2 => XLXI_1_I2_TD_c(0),
      ADR3 => CHOICE2530,
      O => CHOICE2530_GROM
    );
  CHOICE2530_XUSED : X_BUF
    port map (
      I => CHOICE2530_FROM,
      O => CHOICE2530
    );
  CHOICE2530_YUSED : X_BUF
    port map (
      I => CHOICE2530_GROM,
      O => N43846
    );
  XLXI_1_I3_Mmux_data_x_Result_1_7 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_4_int_pending_c(1),
      ADR1 => XLXI_55_mux_c(1),
      ADR2 => XLXI_55_mux_c(4),
      ADR3 => XLXI_26_rx_uart_fifo(1),
      O => CHOICE2895_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_0_7 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_55_mux_c(1),
      ADR1 => XLXI_4_int_pending_c(0),
      ADR2 => XLXI_55_mux_c(4),
      ADR3 => XLXI_26_rx_uart_fifo(0),
      O => CHOICE2895_GROM
    );
  CHOICE2895_XUSED : X_BUF
    port map (
      I => CHOICE2895_FROM,
      O => CHOICE2895
    );
  CHOICE2895_YUSED : X_BUF
    port map (
      I => CHOICE2895_GROM,
      O => CHOICE2974
    );
  XLXI_1_I3_n0115_3_29 : X_LUT4
    generic map(
      INIT => X"CE00"
    )
    port map (
      ADR0 => XLXI_1_I3_n0058,
      ADR1 => XLXI_1_I3_N20010,
      ADR2 => XLXI_1_I3_acc_c_0_3,
      ADR3 => XLXI_1_I3_data_x(3),
      O => CHOICE2645_FROM
    );
  XLXI_1_I3_n0115_2_29 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_1_I3_data_x(2),
      ADR1 => XLXI_1_I3_N20010,
      ADR2 => XLXI_1_I3_n0058,
      ADR3 => XLXI_1_I3_acc_c_0_2,
      O => CHOICE2645_GROM
    );
  CHOICE2645_XUSED : X_BUF
    port map (
      I => CHOICE2645_FROM,
      O => CHOICE2645
    );
  CHOICE2645_YUSED : X_BUF
    port map (
      I => CHOICE2645_GROM,
      O => CHOICE2581
    );
  XLXI_1_I3_Mmux_data_x_Result_5_2 : X_LUT4
    generic map(
      INIT => X"C0C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_55_mux_c(3),
      ADR2 => XLXI_5_tmr_high(5),
      ADR3 => VCC,
      O => CHOICE2603_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_2_2 : X_LUT4
    generic map(
      INIT => X"A0A0"
    )
    port map (
      ADR0 => XLXI_5_tmr_high(2),
      ADR1 => VCC,
      ADR2 => XLXI_55_mux_c(3),
      ADR3 => VCC,
      O => CHOICE2603_GROM
    );
  CHOICE2603_XUSED : X_BUF
    port map (
      I => CHOICE2603_FROM,
      O => CHOICE2603
    );
  CHOICE2603_YUSED : X_BUF
    port map (
      I => CHOICE2603_GROM,
      O => CHOICE2828
    );
  XLXI_1_I3_n0115_6_106 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_1_I3_n0067,
      ADR1 => XLXI_1_I3_acc_i_0_6,
      ADR2 => XLXI_1_I3_N20122,
      ADR3 => N43850,
      O => CHOICE2886_FROM
    );
  XLXI_1_I3_n0115_6_13_SW0 : X_LUT4
    generic map(
      INIT => X"FF44"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c_3_1,
      ADR1 => XLXI_1_I3_n0076,
      ADR2 => VCC,
      ADR3 => CHOICE2886,
      O => CHOICE2886_GROM
    );
  CHOICE2886_XUSED : X_BUF
    port map (
      I => CHOICE2886_FROM,
      O => CHOICE2886
    );
  CHOICE2886_YUSED : X_BUF
    port map (
      I => CHOICE2886_GROM,
      O => N43330
    );
  XLXI_26_n01061 : X_LUT4
    generic map(
      INIT => X"C000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_26_N16197,
      ADR2 => XLXI_26_rx_bit_count(2),
      ADR3 => XLXI_26_rx_bit_count(1),
      O => XLXI_26_n0106_FROM
    );
  XLXI_26_n01101 : X_LUT4
    generic map(
      INIT => X"3000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_26_rx_bit_count(1),
      ADR2 => XLXI_26_rx_bit_count(2),
      ADR3 => XLXI_26_N16197,
      O => XLXI_26_n0106_GROM
    );
  XLXI_26_n0106_XUSED : X_BUF
    port map (
      I => XLXI_26_n0106_FROM,
      O => XLXI_26_n0106
    );
  XLXI_26_n0106_YUSED : X_BUF
    port map (
      I => XLXI_26_n0106_GROM,
      O => XLXI_26_n0110
    );
  XLXI_1_I3_n0115_2_90 : X_LUT4
    generic map(
      INIT => X"BA30"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_3,
      ADR1 => XLXI_1_I3_acc_c_0_2,
      ADR2 => XLXI_1_I3_n0060,
      ADR3 => XLXI_1_I3_N19837,
      O => CHOICE2594_FROM
    );
  XLXI_1_I3_n0115_2_106_SW0 : X_LUT4
    generic map(
      INIT => X"FF40"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c(2),
      ADR1 => XLXI_1_I2_TD_c(0),
      ADR2 => XLXI_1_I3_acc_c_0_1,
      ADR3 => CHOICE2594,
      O => CHOICE2594_GROM
    );
  CHOICE2594_XUSED : X_BUF
    port map (
      I => CHOICE2594_FROM,
      O => CHOICE2594
    );
  CHOICE2594_YUSED : X_BUF
    port map (
      I => CHOICE2594_GROM,
      O => N43854
    );
  XLXI_26_n005612 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_26_rx_clk_count(0),
      ADR1 => XLXI_26_rx_clk_count(2),
      ADR2 => XLXI_26_rx_clk_count(1),
      ADR3 => XLXI_26_rx_clk_count(3),
      O => CHOICE1032_GROM
    );
  CHOICE1032_YUSED : X_BUF
    port map (
      I => CHOICE1032_GROM,
      O => CHOICE1032
    );
  XLXI_1_I3_n0115_7_19 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c_1_1,
      ADR1 => XLXI_1_I2_TD_c_2_1,
      ADR2 => XLXI_1_I3_n0066(7),
      ADR3 => XLXI_1_I2_TD_c_0_1,
      O => CHOICE2930_FROM
    );
  XLXI_1_I3_n0115_3_19 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c_1_1,
      ADR1 => XLXI_1_I2_TD_c_2_1,
      ADR2 => XLXI_1_I3_n0066(3),
      ADR3 => XLXI_1_I2_TD_c_0_1,
      O => CHOICE2930_GROM
    );
  CHOICE2930_XUSED : X_BUF
    port map (
      I => CHOICE2930_FROM,
      O => CHOICE2930
    );
  CHOICE2930_YUSED : X_BUF
    port map (
      I => CHOICE2930_GROM,
      O => CHOICE2641
    );
  XLXI_26_n00231 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_26_rx_8z_count(2),
      ADR1 => XLXI_26_rx_8z_count(3),
      ADR2 => XLXI_26_rx_8z_count(0),
      ADR3 => XLXI_26_rx_8z_count(1),
      O => XLXI_26_n0023_GROM
    );
  XLXI_26_n0023_YUSED : X_BUF
    port map (
      I => XLXI_26_n0023_GROM,
      O => XLXI_26_n0023
    );
  XLXI_1_I3_Mmux_data_x_Result_6_7 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_4_int_pending_c(6),
      ADR1 => XLXI_55_mux_c(1),
      ADR2 => XLXI_55_mux_c(4),
      ADR3 => XLXI_26_rx_uart_fifo(6),
      O => CHOICE2542_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_2_7 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => XLXI_26_rx_uart_fifo(2),
      ADR1 => XLXI_4_int_pending_c(2),
      ADR2 => XLXI_55_mux_c(4),
      ADR3 => XLXI_55_mux_c(1),
      O => CHOICE2542_GROM
    );
  CHOICE2542_XUSED : X_BUF
    port map (
      I => CHOICE2542_FROM,
      O => CHOICE2542
    );
  CHOICE2542_YUSED : X_BUF
    port map (
      I => CHOICE2542_GROM,
      O => CHOICE2831
    );
  XLXI_1_I3_Mmux_data_x_Result_4_140_SW3 : X_LUT4
    generic map(
      INIT => X"C399"
    )
    port map (
      ADR0 => XLXI_1_I4_n00371_1,
      ADR1 => XLXI_1_I3_acc_c_0_4,
      ADR2 => XLXI_1_I2_data_is_c(4),
      ADR3 => XLXI_1_I3_n0025,
      O => N43210_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_4_0 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c_2_1,
      ADR1 => XLXI_1_I2_TC_c_0_1,
      ADR2 => XLXI_1_I2_data_is_c(4),
      ADR3 => XLXI_1_I2_TC_c_1_1,
      O => N43210_GROM
    );
  N43210_XUSED : X_BUF
    port map (
      I => N43210_FROM,
      O => N43210
    );
  N43210_YUSED : X_BUF
    port map (
      I => N43210_GROM,
      O => CHOICE2665
    );
  XLXI_26_n00241 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => XLXI_26_rx_16_count(3),
      ADR1 => XLXI_26_rx_16_count(0),
      ADR2 => XLXI_26_rx_16_count(1),
      ADR3 => XLXI_26_rx_16_count(2),
      O => XLXI_26_n0024_FROM
    );
  XLXI_26_Ker161281 : X_LUT4
    generic map(
      INIT => X"4400"
    )
    port map (
      ADR0 => XLXI_26_rx_bit_count(3),
      ADR1 => XLXI_26_rx_s_FFd2,
      ADR2 => VCC,
      ADR3 => XLXI_26_n0024,
      O => XLXI_26_n0024_GROM
    );
  XLXI_26_n0024_XUSED : X_BUF
    port map (
      I => XLXI_26_n0024_FROM,
      O => XLXI_26_n0024
    );
  XLXI_26_n0024_YUSED : X_BUF
    port map (
      I => XLXI_26_n0024_GROM,
      O => XLXI_26_N16130
    );
  XLXI_26_n01081 : X_LUT4
    generic map(
      INIT => X"5000"
    )
    port map (
      ADR0 => XLXI_26_rx_bit_count(1),
      ADR1 => VCC,
      ADR2 => XLXI_26_N16190,
      ADR3 => XLXI_26_rx_bit_count(2),
      O => XLXI_26_n0108_FROM
    );
  XLXI_26_n01041 : X_LUT4
    generic map(
      INIT => X"A000"
    )
    port map (
      ADR0 => XLXI_26_rx_bit_count(1),
      ADR1 => VCC,
      ADR2 => XLXI_26_rx_bit_count(2),
      ADR3 => XLXI_26_N16190,
      O => XLXI_26_n0108_GROM
    );
  XLXI_26_n0108_XUSED : X_BUF
    port map (
      I => XLXI_26_n0108_FROM,
      O => XLXI_26_n0108
    );
  XLXI_26_n0108_YUSED : X_BUF
    port map (
      I => XLXI_26_n0108_GROM,
      O => XLXI_26_n0104
    );
  XLXI_26_n01121 : X_LUT4
    generic map(
      INIT => X"3000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_26_rx_bit_count(2),
      ADR2 => XLXI_26_rx_bit_count(1),
      ADR3 => XLXI_26_N16190,
      O => XLXI_26_n0112_GROM
    );
  XLXI_26_n0112_YUSED : X_BUF
    port map (
      I => XLXI_26_n0112_GROM,
      O => XLXI_26_n0112
    );
  XLXI_1_I3_Mmux_data_x_Result_6_2 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_55_mux_c(3),
      ADR3 => XLXI_5_tmr_high(6),
      O => CHOICE2539_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_4_2 : X_LUT4
    generic map(
      INIT => X"C0C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_5_tmr_high(4),
      ADR2 => XLXI_55_mux_c(3),
      ADR3 => VCC,
      O => CHOICE2539_GROM
    );
  CHOICE2539_XUSED : X_BUF
    port map (
      I => CHOICE2539_FROM,
      O => CHOICE2539
    );
  CHOICE2539_YUSED : X_BUF
    port map (
      I => CHOICE2539_GROM,
      O => CHOICE2667
    );
  XLXI_26_n005625 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_26_rx_clk_count(5),
      ADR1 => XLXI_26_rx_clk_count(7),
      ADR2 => XLXI_26_rx_clk_count(4),
      ADR3 => XLXI_26_rx_clk_count(6),
      O => CHOICE1039_FROM
    );
  XLXI_26_n005626 : X_LUT4
    generic map(
      INIT => X"AA00"
    )
    port map (
      ADR0 => CHOICE1032,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => CHOICE1039,
      O => CHOICE1039_GROM
    );
  CHOICE1039_XUSED : X_BUF
    port map (
      I => CHOICE1039_FROM,
      O => CHOICE1039
    );
  CHOICE1039_YUSED : X_BUF
    port map (
      I => CHOICE1039_GROM,
      O => XLXI_26_n0056
    );
  XLXI_1_I3_Mmux_data_x_Result_7_7 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_26_rx_uart_fifo(7),
      ADR1 => XLXI_55_mux_c(4),
      ADR2 => XLXI_4_int_pending_c(7),
      ADR3 => XLXI_55_mux_c(1),
      O => CHOICE2478_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_3_7 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_55_mux_c(4),
      ADR1 => XLXI_4_int_pending_c(3),
      ADR2 => XLXI_55_mux_c(1),
      ADR3 => XLXI_26_rx_uart_fifo(3),
      O => CHOICE2478_GROM
    );
  CHOICE2478_XUSED : X_BUF
    port map (
      I => CHOICE2478_FROM,
      O => CHOICE2478
    );
  CHOICE2478_YUSED : X_BUF
    port map (
      I => CHOICE2478_GROM,
      O => CHOICE2767
    );
  XLXI_1_I3_n0115_3_0 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_3,
      ADR1 => XLXI_1_I3_N19927,
      ADR2 => VCC,
      ADR3 => VCC,
      O => CHOICE2634_FROM
    );
  XLXI_1_I3_n0115_1_0 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I3_N19927,
      ADR2 => VCC,
      ADR3 => XLXI_1_I3_acc_c_0_1,
      O => CHOICE2634_GROM
    );
  CHOICE2634_XUSED : X_BUF
    port map (
      I => CHOICE2634_FROM,
      O => CHOICE2634
    );
  CHOICE2634_YUSED : X_BUF
    port map (
      I => CHOICE2634_GROM,
      O => CHOICE2506
    );
  XLXI_1_I3_n0115_3_90 : X_LUT4
    generic map(
      INIT => X"A0EC"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_4,
      ADR1 => XLXI_1_I3_n0060,
      ADR2 => XLXI_1_I3_N19837,
      ADR3 => XLXI_1_I3_acc_c_0_3,
      O => CHOICE2658_FROM
    );
  XLXI_1_I3_n0115_3_106_SW0 : X_LUT4
    generic map(
      INIT => X"FF40"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c(2),
      ADR1 => XLXI_1_I2_TD_c(0),
      ADR2 => XLXI_1_I3_acc_c_0_2,
      ADR3 => CHOICE2658,
      O => CHOICE2658_GROM
    );
  CHOICE2658_XUSED : X_BUF
    port map (
      I => CHOICE2658_FROM,
      O => CHOICE2658
    );
  CHOICE2658_YUSED : X_BUF
    port map (
      I => CHOICE2658_GROM,
      O => N43834
    );
  XLXI_1_I3_Mmux_data_x_Result_4_7 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_55_mux_c(4),
      ADR1 => XLXI_55_mux_c(1),
      ADR2 => XLXI_4_int_pending_c(4),
      ADR3 => XLXI_26_rx_uart_fifo(4),
      O => CHOICE2670_GROM
    );
  CHOICE2670_YUSED : X_BUF
    port map (
      I => CHOICE2670_GROM,
      O => CHOICE2670
    );
  XLXI_1_I3_n0115_6_29 : X_LUT4
    generic map(
      INIT => X"C0C8"
    )
    port map (
      ADR0 => XLXI_1_I3_n0058,
      ADR1 => XLXI_1_I3_data_x(6),
      ADR2 => XLXI_1_I3_N20010,
      ADR3 => XLXI_1_I3_acc_c_0_6,
      O => CHOICE2870_FROM
    );
  XLXI_1_I3_n0115_4_29 : X_LUT4
    generic map(
      INIT => X"AA08"
    )
    port map (
      ADR0 => XLXI_1_I3_data_x(4),
      ADR1 => XLXI_1_I3_n0058,
      ADR2 => XLXI_1_I3_acc_c_0_4,
      ADR3 => XLXI_1_I3_N20010,
      O => CHOICE2870_GROM
    );
  CHOICE2870_XUSED : X_BUF
    port map (
      I => CHOICE2870_FROM,
      O => CHOICE2870
    );
  CHOICE2870_YUSED : X_BUF
    port map (
      I => CHOICE2870_GROM,
      O => CHOICE2742
    );
  XLXI_1_I2_Ker18947_SW0 : X_LUT4
    generic map(
      INIT => X"FFAA"
    )
    port map (
      ADR0 => IDATA(5),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => IDATA(0),
      O => N28099_FROM
    );
  XLXI_1_I2_Ker18947 : X_LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      ADR0 => IDATA(7),
      ADR1 => IDATA(6),
      ADR2 => IDATA(3),
      ADR3 => N28099,
      O => N28099_GROM
    );
  N28099_XUSED : X_BUF
    port map (
      I => N28099_FROM,
      O => N28099
    );
  N28099_YUSED : X_BUF
    port map (
      I => N28099_GROM,
      O => XLXI_1_I2_N18949
    );
  XLXI_1_I3_n0115_7_106 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_1_I3_N20122,
      ADR1 => N43830,
      ADR2 => XLXI_1_I3_acc_i_0_7,
      ADR3 => XLXI_1_I3_n0067,
      O => CHOICE2950_FROM
    );
  XLXI_1_I3_n0115_7_13_SW1 : X_LUT4
    generic map(
      INIT => X"FF8A"
    )
    port map (
      ADR0 => XLXI_1_I3_n0076,
      ADR1 => XLXI_1_I3_acc_c_0_7,
      ADR2 => XLXI_1_I2_TD_c_3_1,
      ADR3 => CHOICE2950,
      O => CHOICE2950_GROM
    );
  CHOICE2950_XUSED : X_BUF
    port map (
      I => CHOICE2950_FROM,
      O => CHOICE2950
    );
  CHOICE2950_YUSED : X_BUF
    port map (
      I => CHOICE2950_GROM,
      O => N43308
    );
  XLXI_1_I3_n0115_4_90 : X_LUT4
    generic map(
      INIT => X"88F8"
    )
    port map (
      ADR0 => XLXI_1_I3_N19837,
      ADR1 => XLXI_1_I3_acc_c_0_5,
      ADR2 => XLXI_1_I3_n0060,
      ADR3 => XLXI_1_I3_acc_c_0_4,
      O => CHOICE2755_FROM
    );
  XLXI_1_I3_n0115_4_106_SW0 : X_LUT4
    generic map(
      INIT => X"FF08"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_3,
      ADR1 => XLXI_1_I2_TD_c(0),
      ADR2 => XLXI_1_I2_TD_c(2),
      ADR3 => CHOICE2755,
      O => CHOICE2755_GROM
    );
  CHOICE2755_XUSED : X_BUF
    port map (
      I => CHOICE2755_FROM,
      O => CHOICE2755
    );
  CHOICE2755_YUSED : X_BUF
    port map (
      I => CHOICE2755_GROM,
      O => N43838
    );
  XLXI_1_I3_Mmux_data_x_Result_7_2 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_55_mux_c(3),
      ADR2 => VCC,
      ADR3 => XLXI_5_tmr_high(7),
      O => CHOICE2475_GROM
    );
  CHOICE2475_YUSED : X_BUF
    port map (
      I => CHOICE2475_GROM,
      O => CHOICE2475
    );
  XLXI_1_I3_n0115_5_0 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I3_N19927,
      ADR2 => VCC,
      ADR3 => XLXI_1_I3_acc_c_0_5,
      O => CHOICE2795_FROM
    );
  XLXI_1_I3_n0115_5_29 : X_LUT4
    generic map(
      INIT => X"F040"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_5,
      ADR1 => XLXI_1_I3_n0058,
      ADR2 => XLXI_1_I3_data_x(5),
      ADR3 => XLXI_1_I3_N20010,
      O => CHOICE2795_GROM
    );
  CHOICE2795_XUSED : X_BUF
    port map (
      I => CHOICE2795_FROM,
      O => CHOICE2795
    );
  CHOICE2795_YUSED : X_BUF
    port map (
      I => CHOICE2795_GROM,
      O => CHOICE2806
    );
  XLXI_1_I3_Mmux_data_x_Result_4_140_SW1 : X_LUT4
    generic map(
      INIT => X"C693"
    )
    port map (
      ADR0 => XLXI_1_I3_n0025,
      ADR1 => XLXI_1_I3_acc_c_0_4,
      ADR2 => XLXI_1_I2_data_is_c(4),
      ADR3 => XLXI_1_I4_n00371_1,
      O => N43168_FROM
    );
  XLXI_1_I3_n0115_4_0 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I3_acc_c_0_4,
      ADR2 => VCC,
      ADR3 => XLXI_1_I3_N19927,
      O => N43168_GROM
    );
  N43168_XUSED : X_BUF
    port map (
      I => N43168_FROM,
      O => N43168
    );
  N43168_YUSED : X_BUF
    port map (
      I => N43168_GROM,
      O => CHOICE2731
    );
  XLXI_26_n0102_297 : X_LUT4
    generic map(
      INIT => X"0020"
    )
    port map (
      ADR0 => XLXI_26_n0024,
      ADR1 => N29615,
      ADR2 => XLXI_26_n0056,
      ADR3 => XLXI_26_rx_bit_count(0),
      O => XLXI_26_n0102_GROM
    );
  XLXI_26_n0102_YUSED : X_BUF
    port map (
      I => XLXI_26_n0102_GROM,
      O => XLXI_26_n0102
    );
  XLXI_1_I3_n0115_5_90 : X_LUT4
    generic map(
      INIT => X"A0EC"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_6,
      ADR1 => XLXI_1_I3_n0060,
      ADR2 => XLXI_1_I3_N19837,
      ADR3 => XLXI_1_I3_acc_c_0_5,
      O => CHOICE2819_FROM
    );
  XLXI_1_I3_n0115_5_106_SW0 : X_LUT4
    generic map(
      INIT => X"FF08"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_4,
      ADR1 => XLXI_1_I2_TD_c(0),
      ADR2 => XLXI_1_I2_TD_c_2_1,
      ADR3 => CHOICE2819,
      O => CHOICE2819_GROM
    );
  CHOICE2819_XUSED : X_BUF
    port map (
      I => CHOICE2819_FROM,
      O => CHOICE2819
    );
  CHOICE2819_YUSED : X_BUF
    port map (
      I => CHOICE2819_GROM,
      O => N43842
    );
  XLXI_1_I2_TC_x_2_SW1 : X_LUT4
    generic map(
      INIT => X"FFAF"
    )
    port map (
      ADR0 => IDATA(1),
      ADR1 => VCC,
      ADR2 => NRESET_BUFGP,
      ADR3 => IDATA(2),
      O => XLXI_1_I2_TC_c_2_FROM
    );
  XLXI_1_I2_TC_x_2_Q : X_LUT4
    generic map(
      INIT => X"00F2"
    )
    port map (
      ADR0 => XLXI_1_I2_N18976,
      ADR1 => IDATA(0),
      ADR2 => IDATA(3),
      ADR3 => N43917,
      O => XLXI_1_I2_TC_c_2_GROM
    );
  XLXI_1_I2_TC_c_2_XUSED : X_BUF
    port map (
      I => XLXI_1_I2_TC_c_2_FROM,
      O => N43917
    );
  XLXI_1_I2_TC_c_2_YUSED : X_BUF
    port map (
      I => XLXI_1_I2_TC_c_2_GROM,
      O => XLXI_1_I2_TC_x(2)
    );
  XLXI_1_I2_TC_c_2_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_1_I2_TC_c_2_SRMUX_OUTPUTNOT
    );
  XLXI_1_I3_n0115_6_90 : X_LUT4
    generic map(
      INIT => X"8F88"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_7,
      ADR1 => XLXI_1_I3_N19837,
      ADR2 => XLXI_1_I3_acc_c_0_6,
      ADR3 => XLXI_1_I3_n0060,
      O => CHOICE2883_FROM
    );
  XLXI_1_I3_n0115_6_106_SW0 : X_LUT4
    generic map(
      INIT => X"FF20"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c_0_1,
      ADR1 => XLXI_1_I2_TD_c_2_1,
      ADR2 => XLXI_1_I3_acc_c_0_5,
      ADR3 => CHOICE2883,
      O => CHOICE2883_GROM
    );
  CHOICE2883_XUSED : X_BUF
    port map (
      I => CHOICE2883_FROM,
      O => CHOICE2883
    );
  CHOICE2883_YUSED : X_BUF
    port map (
      I => CHOICE2883_GROM,
      O => N43850
    );
  XLXI_1_I3_Mmux_data_x_Result_0_140_SW3 : X_LUT4
    generic map(
      INIT => X"C939"
    )
    port map (
      ADR0 => XLXI_1_I4_n00371_1,
      ADR1 => XLXI_1_I3_acc_c_0_0,
      ADR2 => XLXI_1_I3_n0025,
      ADR3 => XLXI_1_I2_data_is_c(0),
      O => N43186_FROM
    );
  XLXI_1_I3_Mmux_data_x_Result_0_140_SW1 : X_LUT4
    generic map(
      INIT => X"D827"
    )
    port map (
      ADR0 => XLXI_1_I3_n0025,
      ADR1 => XLXI_1_I2_data_is_c(0),
      ADR2 => XLXI_1_I4_n0037,
      ADR3 => XLXI_1_I3_acc_c_0_0,
      O => N43186_GROM
    );
  N43186_XUSED : X_BUF
    port map (
      I => N43186_FROM,
      O => N43186
    );
  N43186_YUSED : X_BUF
    port map (
      I => N43186_GROM,
      O => N43144
    );
  XLXI_1_I3_Mmux_data_x_Result_0_140_SW4 : X_LUT4
    generic map(
      INIT => X"DCFC"
    )
    port map (
      ADR0 => XLXI_1_I3_n0025,
      ADR1 => XLXI_1_I3_n0060,
      ADR2 => XLXI_1_I3_n0058,
      ADR3 => XLXI_1_I2_data_is_c(0),
      O => N43414_FROM
    );
  XLXI_1_I3_n0115_0_27_SW0 : X_LUT4
    generic map(
      INIT => X"F020"
    )
    port map (
      ADR0 => N43447,
      ADR1 => XLXI_1_I2_TD_c_1_1,
      ADR2 => XLXI_1_I3_acc_c_0_0,
      ADR3 => N43414,
      O => N43414_GROM
    );
  N43414_XUSED : X_BUF
    port map (
      I => N43414_FROM,
      O => N43414
    );
  N43414_YUSED : X_BUF
    port map (
      I => N43414_GROM,
      O => N43510
    );
  XLXI_1_I3_Mmux_data_x_Result_0_140_SW5 : X_LUT4
    generic map(
      INIT => X"CCDC"
    )
    port map (
      ADR0 => CHOICE2695,
      ADR1 => XLXI_1_I3_n0060,
      ADR2 => XLXI_1_I3_n0058,
      ADR3 => CHOICE2969,
      O => N43416_GROM
    );
  N43416_YUSED : X_BUF
    port map (
      I => N43416_GROM,
      O => N43416
    );
  XLXI_1_I3_n0115_8_4 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_0,
      ADR1 => XLXI_1_I3_acc_c_0_7,
      ADR2 => XLXI_1_I3_N19856,
      ADR3 => XLXI_1_I3_n0057,
      O => CHOICE2700_FROM
    );
  XLXI_1_I3_n0115_8_5 : X_LUT4
    generic map(
      INIT => X"0100"
    )
    port map (
      ADR0 => XLXI_1_I2_TC_c_2_1,
      ADR1 => XLXI_1_I2_TC_c_1_1,
      ADR2 => XLXI_1_I2_TC_c_0_1,
      ADR3 => CHOICE2700,
      O => CHOICE2700_GROM
    );
  CHOICE2700_XUSED : X_BUF
    port map (
      I => CHOICE2700_FROM,
      O => CHOICE2700
    );
  CHOICE2700_YUSED : X_BUF
    port map (
      I => CHOICE2700_GROM,
      O => CHOICE2701
    );
  XLXI_1_I3_Mmux_data_x_Result_0_140_SW6 : X_LUT4
    generic map(
      INIT => X"8A0A"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c_0_1,
      ADR1 => XLXI_1_I2_data_is_c(0),
      ADR2 => XLXI_1_I2_TD_c_2_1,
      ADR3 => XLXI_1_I3_n0025,
      O => N43447_GROM
    );
  N43447_YUSED : X_BUF
    port map (
      I => N43447_GROM,
      O => N43447
    );
  XLXI_26_n00991 : X_LUT4
    generic map(
      INIT => X"FAFA"
    )
    port map (
      ADR0 => XLXI_26_rx_uart_ovr_s,
      ADR1 => VCC,
      ADR2 => XLXI_26_rx_uart_full_c,
      ADR3 => VCC,
      O => XLXI_26_n0099_FROM
    );
  XLXI_26_n00981 : X_LUT4
    generic map(
      INIT => X"FAFA"
    )
    port map (
      ADR0 => XLXI_26_rx_uart_full_s,
      ADR1 => VCC,
      ADR2 => XLXI_26_rx_uart_full_c,
      ADR3 => VCC,
      O => XLXI_26_n0099_GROM
    );
  XLXI_26_n0099_XUSED : X_BUF
    port map (
      I => XLXI_26_n0099_FROM,
      O => XLXI_26_n0099
    );
  XLXI_26_n0099_YUSED : X_BUF
    port map (
      I => XLXI_26_n0099_GROM,
      O => XLXI_26_n0098
    );
  XLXI_1_I3_n0115_7_90 : X_LUT4
    generic map(
      INIT => X"8F88"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_6,
      ADR1 => XLXI_1_I3_N19856,
      ADR2 => XLXI_1_I3_acc_c_0_7,
      ADR3 => XLXI_1_I3_n0060,
      O => CHOICE2947_FROM
    );
  XLXI_1_I3_n0115_7_106_SW0 : X_LUT4
    generic map(
      INIT => X"FF88"
    )
    port map (
      ADR0 => XLXI_1_I3_acc_c_0_8,
      ADR1 => XLXI_1_I3_N19837,
      ADR2 => VCC,
      ADR3 => CHOICE2947,
      O => CHOICE2947_GROM
    );
  CHOICE2947_XUSED : X_BUF
    port map (
      I => CHOICE2947_FROM,
      O => CHOICE2947
    );
  CHOICE2947_YUSED : X_BUF
    port map (
      I => CHOICE2947_GROM,
      O => N43830
    );
  XLXI_1_I3_Mmux_data_x_Result_0_140_SW7 : X_LUT4
    generic map(
      INIT => X"CCC4"
    )
    port map (
      ADR0 => XLXI_1_I2_TD_c_2_1,
      ADR1 => XLXI_1_I2_TD_c_0_1,
      ADR2 => CHOICE2969,
      ADR3 => CHOICE2695,
      O => N43449_FROM
    );
  XLXI_1_I3_n0115_0_27_SW1 : X_LUT4
    generic map(
      INIT => X"8C88"
    )
    port map (
      ADR0 => N43416,
      ADR1 => XLXI_1_I3_acc_c_0_0,
      ADR2 => XLXI_1_I2_TD_c_1_1,
      ADR3 => N43449,
      O => N43449_GROM
    );
  N43449_XUSED : X_BUF
    port map (
      I => N43449_FROM,
      O => N43449
    );
  N43449_YUSED : X_BUF
    port map (
      I => N43449_GROM,
      O => N43512
    );
  XLXI_1_I3_n0115_8_80 : X_LUT4
    generic map(
      INIT => X"F0E0"
    )
    port map (
      ADR0 => CHOICE2716,
      ADR1 => CHOICE2711,
      ADR2 => XLXI_1_I3_acc_c_0_8,
      ADR3 => CHOICE531,
      O => CHOICE2722_FROM
    );
  XLXI_1_I3_n0115_8_90 : X_LUT4
    generic map(
      INIT => X"FFC0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_1_I3_acc_i_0_8,
      ADR2 => XLXI_1_I3_n0067,
      ADR3 => CHOICE2722,
      O => CHOICE2722_GROM
    );
  CHOICE2722_XUSED : X_BUF
    port map (
      I => CHOICE2722_FROM,
      O => CHOICE2722
    );
  CHOICE2722_YUSED : X_BUF
    port map (
      I => CHOICE2722_GROM,
      O => CHOICE2723
    );
  XLXI_1_I2_ndwe_x1_SW1 : X_LUT4
    generic map(
      INIT => X"AEFF"
    )
    port map (
      ADR0 => XLXI_1_I2_N18996,
      ADR1 => XLXI_1_I3_skip_l,
      ADR2 => XLXI_1_I2_int_start_c,
      ADR3 => IDATA(0),
      O => N43460_FROM
    );
  XLXI_1_I2_ndwe_x1 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => IDATA(2),
      ADR1 => IDATA(1),
      ADR2 => IDATA(3),
      ADR3 => N43460,
      O => N43460_GROM
    );
  N43460_XUSED : X_BUF
    port map (
      I => N43460_FROM,
      O => N43460
    );
  N43460_YUSED : X_BUF
    port map (
      I => N43460_GROM,
      O => XLXI_1_ndwe_int
    );
  XLXI_26_rx_uart_fifo_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_uart_fifo_1_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_uart_fifo_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_uart_fifo_3_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_uart_fifo_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_uart_fifo_5_SRMUX_OUTPUTNOT
    );
  XLXI_26_rx_uart_fifo_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_26_rx_uart_fifo_7_SRMUX_OUTPUTNOT
    );
  XLXI_4_int_masked_c_1_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_masked_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_4_int_masked_c_3_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_masked_c_3_SRMUX_OUTPUTNOT
    );
  XLXI_4_int_masked_c_5_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_masked_c_5_SRMUX_OUTPUTNOT
    );
  XLXI_4_int_masked_c_7_SRMUX : X_INV
    port map (
      I => NRESET_BUFGP,
      O => XLXI_4_int_masked_c_7_SRMUX_OUTPUTNOT
    );
  XLXI_1_I1_stack_addrs_c_1_1_298 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0020(1),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_1_1_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_1_1
    );
  XLXI_1_I1_stack_addrs_c_1_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_1_1_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_1_2_299 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0020(2),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_1_2_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_1_2
    );
  XLXI_1_I1_stack_addrs_c_1_2_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_1_2_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_1_3_300 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0020(3),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_1_3_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_1_3
    );
  XLXI_1_I1_stack_addrs_c_1_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_1_3_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_1_4_301 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0020(4),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_1_4_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_1_4
    );
  XLXI_1_I1_stack_addrs_c_1_4_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_1_4_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_1_5_302 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0020(5),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_1_5_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_1_5
    );
  XLXI_1_I1_stack_addrs_c_1_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_1_5_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_1_7_303 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0020(7),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_1_7_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_1_7
    );
  XLXI_1_I1_stack_addrs_c_1_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_1_7_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_1_6_304 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0020(6),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_1_6_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_1_6
    );
  XLXI_1_I1_stack_addrs_c_1_6_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_1_6_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_2_9_305 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0019(9),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_2_9_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_2_9
    );
  XLXI_1_I1_stack_addrs_c_2_9_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_2_9_FFX_RST
    );
  XLXI_1_I4_ireg_i_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_ireg_i_0_F5MUX,
      CE => XLXI_1_I4_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_ireg_i_0_FFX_RST,
      O => XLXI_1_I4_ireg_i(0)
    );
  XLXI_1_I4_ireg_i_0_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I4_ireg_i_0_FFX_RST
    );
  XLXI_1_I1_pc_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_pc_7_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_pc_7_FFY_RST,
      O => XLXI_1_I1_pc(7)
    );
  XLXI_1_I1_pc_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I1_pc_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I1_pc_7_FFY_RST
    );
  XLXI_1_I1_pc_8 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_pc_8_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_pc_8_FFY_RST,
      O => XLXI_1_I1_pc(8)
    );
  XLXI_1_I1_pc_8_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I1_pc_8_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I1_pc_8_FFY_RST
    );
  XLXI_1_I1_pc_9 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_pc_9_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_pc_9_FFY_RST,
      O => XLXI_1_I1_pc(9)
    );
  XLXI_1_I1_pc_9_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I1_pc_9_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I1_pc_9_FFY_RST
    );
  XLXI_1_I3_acc_i_0_5_306 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc(0, 5),
      CE => XLXI_1_I2_int_start_c,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_i_0_5_FFX_RST,
      O => XLXI_1_I3_acc_i_0_5
    );
  XLXI_1_I3_acc_i_0_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_i_0_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_i_0_5_FFX_RST
    );
  XLXI_3_reg_data_out_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_reg_data_out_c_2_FROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_3_reg_data_out_c_2_FFX_RST,
      O => XLXI_3_reg_data_out_c(2)
    );
  XLXI_3_reg_data_out_c_2_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_reg_data_out_c_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_reg_data_out_c_2_FFX_RST
    );
  XLXI_3_reg_data_out_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_reg_data_out_c_3_FROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_3_reg_data_out_c_3_FFX_RST,
      O => XLXI_3_reg_data_out_c(3)
    );
  XLXI_3_reg_data_out_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_reg_data_out_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_reg_data_out_c_3_FFX_RST
    );
  XLXI_3_reg_data_out_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_reg_data_out_c_4_FROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_3_reg_data_out_c_4_FFX_RST,
      O => XLXI_3_reg_data_out_c(4)
    );
  XLXI_3_reg_data_out_c_4_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_reg_data_out_c_4_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_reg_data_out_c_4_FFX_RST
    );
  XLXI_3_reg_data_out_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_reg_data_out_c_5_FROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_3_reg_data_out_c_5_FFX_RST,
      O => XLXI_3_reg_data_out_c(5)
    );
  XLXI_3_reg_data_out_c_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_reg_data_out_c_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_reg_data_out_c_5_FFX_RST
    );
  XLXI_3_reg_data_out_c_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_reg_data_out_c_6_FROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_3_reg_data_out_c_6_FFX_RST,
      O => XLXI_3_reg_data_out_c(6)
    );
  XLXI_3_reg_data_out_c_6_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_reg_data_out_c_6_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_reg_data_out_c_6_FFX_RST
    );
  XLXI_1_I1_pc_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_pc_6_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_pc_6_FFY_RST,
      O => XLXI_1_I1_pc(6)
    );
  XLXI_1_I1_pc_6_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I1_pc_6_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I1_pc_6_FFY_RST
    );
  XLXI_1_I1_stack_addrs_c_3_1_307 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0018(1),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_3_1_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_3_1
    );
  XLXI_1_I1_stack_addrs_c_3_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_3_1_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_3_4_308 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0018(4),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_3_4_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_3_4
    );
  XLXI_1_I1_stack_addrs_c_3_4_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_3_4_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_4_6_309 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0017(6),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_4_6_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_4_6
    );
  XLXI_1_I1_stack_addrs_c_4_6_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_4_6_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_3_2_310 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0018(2),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_3_2_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_3_2
    );
  XLXI_1_I1_stack_addrs_c_3_2_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_3_2_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_4_7_311 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0017(7),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_4_7_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_4_7
    );
  XLXI_1_I1_stack_addrs_c_4_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_4_7_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_3_3_312 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0018(3),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_3_3_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_3_3
    );
  XLXI_1_I1_stack_addrs_c_3_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_3_3_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_4_8_313 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0017(8),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_4_8_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_4_8
    );
  XLXI_1_I1_stack_addrs_c_4_8_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_4_8_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_2_0_314 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0019(0),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_2_0_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_2_0
    );
  XLXI_1_I1_stack_addrs_c_2_0_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_2_0_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_6_8_315 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0015(8),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_6_8_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_6_8
    );
  XLXI_1_I1_stack_addrs_c_6_8_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_6_8_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_4_2_316 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0017(2),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_4_2_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_4_2
    );
  XLXI_1_I1_stack_addrs_c_4_2_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_4_2_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_5_4_317 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0016(4),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_5_4_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_5_4
    );
  XLXI_1_I1_stack_addrs_c_5_4_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_5_4_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_4_0_318 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0017(0),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_4_0_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_4_0
    );
  XLXI_1_I1_stack_addrs_c_4_0_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_4_0_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_6_9_319 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0015(9),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_6_9_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_6_9
    );
  XLXI_1_I1_stack_addrs_c_6_9_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_6_9_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_5_5_320 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0016(5),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_5_5_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_5_5
    );
  XLXI_1_I1_stack_addrs_c_5_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_5_5_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_4_1_321 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0017(1),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_4_1_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_4_1
    );
  XLXI_1_I1_stack_addrs_c_4_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_4_1_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_5_6_322 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0016(6),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_5_6_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_5_6
    );
  XLXI_1_I1_stack_addrs_c_5_6_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_5_6_FFX_RST
    );
  XLXI_3_reg_data_out_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_reg_data_out_c_0_FROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_3_reg_data_out_c_0_FFX_RST,
      O => XLXI_3_reg_data_out_c(0)
    );
  XLXI_3_reg_data_out_c_0_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_reg_data_out_c_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_reg_data_out_c_0_FFX_RST
    );
  XLXI_1_I3_acc_i_0_0_323 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc_i_0_1_GROM,
      CE => XLXI_1_I2_int_start_c,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_i_0_1_FFY_RST,
      O => XLXI_1_I3_acc_i_0_0
    );
  XLXI_1_I3_acc_i_0_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_i_0_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_i_0_1_FFY_RST
    );
  XLXI_1_I3_acc_i_0_2_324 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc_i_0_3_GROM,
      CE => XLXI_1_I2_int_start_c,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_i_0_3_FFY_RST,
      O => XLXI_1_I3_acc_i_0_2
    );
  XLXI_1_I3_acc_i_0_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_i_0_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_i_0_3_FFY_RST
    );
  XLXI_1_I3_acc_i_0_1_325 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc(0, 1),
      CE => XLXI_1_I2_int_start_c,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_i_0_1_FFX_RST,
      O => XLXI_1_I3_acc_i_0_1
    );
  XLXI_1_I3_acc_i_0_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_i_0_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_i_0_1_FFX_RST
    );
  XLXI_3_reg_data_out_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_reg_data_out_c_1_FROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_3_reg_data_out_c_1_FFX_RST,
      O => XLXI_3_reg_data_out_c(1)
    );
  XLXI_3_reg_data_out_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_reg_data_out_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_reg_data_out_c_1_FFX_RST
    );
  XLXI_1_I3_acc_i_0_8_326 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc_i_0_8_GROM,
      CE => XLXI_1_I2_int_start_c,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_i_0_8_FFY_RST,
      O => XLXI_1_I3_acc_i_0_8
    );
  XLXI_1_I3_acc_i_0_8_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_i_0_8_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_i_0_8_FFY_RST
    );
  XLXI_1_I3_acc_i_0_4_327 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc_i_0_5_GROM,
      CE => XLXI_1_I2_int_start_c,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_i_0_5_FFY_RST,
      O => XLXI_1_I3_acc_i_0_4
    );
  XLXI_1_I3_acc_i_0_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_i_0_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_i_0_5_FFY_RST
    );
  XLXI_1_I3_acc_i_0_3_328 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc(0, 3),
      CE => XLXI_1_I2_int_start_c,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_i_0_3_FFX_RST,
      O => XLXI_1_I3_acc_i_0_3
    );
  XLXI_1_I3_acc_i_0_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_i_0_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_i_0_3_FFX_RST
    );
  XLXI_6_tx_clk_count_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_tx_clk_count_inst_sum_20,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_clk_count_0_FFY_RST,
      O => XLXI_6_tx_clk_count(0)
    );
  XLXI_6_tx_clk_count_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_clk_count_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_clk_count_0_FFY_RST
    );
  XLXI_6_tx_clk_count_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_tx_clk_count_inst_sum_22,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_clk_count_1_FFY_RST,
      O => XLXI_6_tx_clk_count(2)
    );
  XLXI_6_tx_clk_count_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_clk_count_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_clk_count_1_FFY_RST
    );
  XLXI_1_I1_stack_addrs_c_2_4_329 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0019(4),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_2_4_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_2_4
    );
  XLXI_1_I1_stack_addrs_c_2_4_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_2_4_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_3_8_330 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0018(8),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_3_8_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_3_8
    );
  XLXI_1_I1_stack_addrs_c_3_8_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_3_8_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_2_5_331 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0019(5),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_2_5_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_2_5
    );
  XLXI_1_I1_stack_addrs_c_2_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_2_5_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_3_9_332 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0018(9),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_3_9_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_3_9
    );
  XLXI_1_I1_stack_addrs_c_3_9_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_3_9_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_2_6_333 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0019(6),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_2_6_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_2_6
    );
  XLXI_1_I1_stack_addrs_c_2_6_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_2_6_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_2_7_334 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0019(7),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_2_7_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_2_7
    );
  XLXI_1_I1_stack_addrs_c_2_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_2_7_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_2_8_335 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0019(8),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_2_8_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_2_8
    );
  XLXI_1_I1_stack_addrs_c_2_8_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_2_8_FFX_RST
    );
  XLXI_6_tx_clk_count_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_tx_clk_count_inst_sum_27,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_clk_count_7_FFX_RST,
      O => XLXI_6_tx_clk_count(7)
    );
  XLXI_6_tx_clk_count_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_clk_count_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_clk_count_7_FFX_RST
    );
  XLXI_4_int_clr_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0003_3_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_clr_c_3_FFX_RST,
      O => XLXI_4_int_clr_c(3)
    );
  XLXI_4_int_clr_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_clr_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_clr_c_3_FFX_RST
    );
  XLXI_4_int_clr_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0003_4_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_clr_c_5_FFY_RST,
      O => XLXI_4_int_clr_c(4)
    );
  XLXI_4_int_clr_c_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_clr_c_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_clr_c_5_FFY_RST
    );
  XLXI_4_int_clr_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0003_5_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_clr_c_5_FFX_RST,
      O => XLXI_4_int_clr_c(5)
    );
  XLXI_4_int_clr_c_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_clr_c_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_clr_c_5_FFX_RST
    );
  XLXI_4_int_clr_c_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0003_6_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_clr_c_7_FFY_RST,
      O => XLXI_4_int_clr_c(6)
    );
  XLXI_4_int_clr_c_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_clr_c_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_clr_c_7_FFY_RST
    );
  XLXI_6_tx_16_count_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_n0011(1),
      CE => XLXI_6_n0007,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_16_count_1_FFX_RST,
      O => XLXI_6_tx_16_count(1)
    );
  XLXI_6_tx_16_count_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_6_tx_16_count_1_FFX_RST
    );
  XLXI_4_int_clr_c_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0003_7_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_clr_c_7_FFX_RST,
      O => XLXI_4_int_clr_c(7)
    );
  XLXI_4_int_clr_c_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_clr_c_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_clr_c_7_FFX_RST
    );
  XLXI_6_tx_16_count_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_n0011(0),
      CE => XLXI_6_n0007,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_16_count_1_FFY_RST,
      O => XLXI_6_tx_16_count(0)
    );
  XLXI_6_tx_16_count_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_6_tx_16_count_1_FFY_RST
    );
  XLXI_6_tx_16_count_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_n0011(2),
      CE => XLXI_6_n0007,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_16_count_3_FFY_RST,
      O => XLXI_6_tx_16_count(2)
    );
  XLXI_6_tx_16_count_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_6_tx_16_count_3_FFY_RST
    );
  XLXI_1_I4_iinc_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_n0035(0),
      CE => XLXI_1_I4_n0062,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_iinc_c_1_FFY_RST,
      O => XLXI_1_I4_iinc_c(0)
    );
  XLXI_1_I4_iinc_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_iinc_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_iinc_c_1_FFY_RST
    );
  XLXI_6_tx_16_count_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_n0011(3),
      CE => XLXI_6_n0007,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_16_count_3_FFX_RST,
      O => XLXI_6_tx_16_count(3)
    );
  XLXI_6_tx_16_count_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_6_tx_16_count_3_FFX_RST
    );
  XLXI_6_tx_clk_count_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_tx_clk_count_inst_sum_21,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_clk_count_1_FFX_RST,
      O => XLXI_6_tx_clk_count(1)
    );
  XLXI_6_tx_clk_count_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_clk_count_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_clk_count_1_FFX_RST
    );
  XLXI_6_tx_clk_count_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_tx_clk_count_inst_sum_24,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_clk_count_3_FFY_RST,
      O => XLXI_6_tx_clk_count(4)
    );
  XLXI_6_tx_clk_count_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_clk_count_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_clk_count_3_FFY_RST
    );
  XLXI_6_tx_clk_count_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_tx_clk_count_inst_sum_23,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_clk_count_3_FFX_RST,
      O => XLXI_6_tx_clk_count(3)
    );
  XLXI_6_tx_clk_count_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_clk_count_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_clk_count_3_FFX_RST
    );
  XLXI_6_tx_clk_count_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_tx_clk_count_inst_sum_26,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_clk_count_5_FFY_RST,
      O => XLXI_6_tx_clk_count(6)
    );
  XLXI_6_tx_clk_count_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_clk_count_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_clk_count_5_FFY_RST
    );
  XLXI_6_tx_clk_div_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_n0014_7_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_clk_count_7_FFY_RST,
      O => XLXI_6_tx_clk_div(7)
    );
  XLXI_6_tx_clk_count_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_clk_count_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_clk_count_7_FFY_RST
    );
  XLXI_6_tx_clk_count_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_tx_clk_count_inst_sum_25,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_clk_count_5_FFX_RST,
      O => XLXI_6_tx_clk_count(5)
    );
  XLXI_6_tx_clk_count_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_clk_count_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_clk_count_5_FFX_RST
    );
  XLXI_26_rx_clk_count_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_clk_count_inst_sum_20,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_clk_count_0_FFY_RST,
      O => XLXI_26_rx_clk_count(0)
    );
  XLXI_26_rx_clk_count_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_clk_count_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_clk_count_0_FFY_RST
    );
  XLXI_26_rx_clk_count_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_clk_count_inst_sum_22,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_clk_count_1_FFY_RST,
      O => XLXI_26_rx_clk_count(2)
    );
  XLXI_26_rx_clk_count_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_clk_count_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_clk_count_1_FFY_RST
    );
  XLXI_26_rx_clk_count_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_clk_count_inst_sum_24,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_clk_count_3_FFY_RST,
      O => XLXI_26_rx_clk_count(4)
    );
  XLXI_26_rx_clk_count_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_clk_count_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_clk_count_3_FFY_RST
    );
  XLXI_26_rx_clk_div_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_clk_div_5_FROM,
      CE => XLXI_26_n0030,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_clk_div_5_FFX_RST,
      O => XLXI_26_rx_clk_div(5)
    );
  XLXI_26_rx_clk_div_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_clk_div_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_clk_div_5_FFX_RST
    );
  XLXI_26_rx_uart_ovr_s_336 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n0036,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_uart_full_s_FFY_RST,
      O => XLXI_26_rx_uart_ovr_s
    );
  XLXI_26_rx_uart_full_s_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_uart_full_s_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_uart_full_s_FFY_RST
    );
  XLXI_1_I2_TC_c_1_1_337 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_TC_c_1_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_TC_c_1_FFY_RST,
      O => XLXI_1_I2_TC_c_1_1
    );
  XLXI_1_I2_TC_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_TC_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_TC_c_1_FFY_RST
    );
  XLXI_26_rx_clk_div_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_clk_div_7_FROM,
      CE => XLXI_26_n0030,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_clk_div_7_FFX_RST,
      O => XLXI_26_rx_clk_div(7)
    );
  XLXI_26_rx_clk_div_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_clk_div_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_clk_div_7_FFX_RST
    );
  XLXI_1_I2_TC_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_TC_x(1),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_TC_c_1_FFX_RST,
      O => XLXI_1_I2_TC_c(1)
    );
  XLXI_1_I2_TC_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_TC_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_TC_c_1_FFX_RST
    );
  XLXI_26_rx_uart_full_s_338 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_uart_full_s_FROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_uart_full_s_FFX_RST,
      O => XLXI_26_rx_uart_full_s
    );
  XLXI_26_rx_uart_full_s_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_uart_full_s_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_uart_full_s_FFX_RST
    );
  XLXI_5_tmr_low_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n0004(1),
      CE => XLXI_5_n0030,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_low_1_FFX_RST,
      O => XLXI_5_tmr_low(1)
    );
  XLXI_5_tmr_low_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_low_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_low_1_FFX_RST
    );
  XLXI_1_I4_ireg_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_n0034(0),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_ireg_c_1_FFY_RST,
      O => XLXI_1_I4_ireg_c(0)
    );
  XLXI_1_I4_ireg_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_ireg_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_ireg_c_1_FFY_RST
    );
  XLXI_1_I4_ireg_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_n0034(5),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_int_stop_c_FFY_RST,
      O => XLXI_1_I4_ireg_c(5)
    );
  XLXI_1_I2_int_stop_c_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_int_stop_c_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_int_stop_c_FFY_RST
    );
  XLXI_4_int_clr_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0003_0_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_clr_c_1_FFY_RST,
      O => XLXI_4_int_clr_c(0)
    );
  XLXI_4_int_clr_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_clr_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_clr_c_1_FFY_RST
    );
  XLXI_4_int_clr_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0003_2_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_clr_c_3_FFY_RST,
      O => XLXI_4_int_clr_c(2)
    );
  XLXI_4_int_clr_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_clr_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_clr_c_3_FFY_RST
    );
  XLXI_4_int_clr_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0003_1_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_clr_c_1_FFX_RST,
      O => XLXI_4_int_clr_c(1)
    );
  XLXI_4_int_clr_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_clr_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_clr_c_1_FFX_RST
    );
  XLXI_26_rx_clk_count_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_clk_count_inst_sum_21,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_clk_count_1_FFX_RST,
      O => XLXI_26_rx_clk_count(1)
    );
  XLXI_26_rx_clk_count_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_clk_count_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_clk_count_1_FFX_RST
    );
  XLXI_26_rx_clk_count_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_clk_count_inst_sum_23,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_clk_count_3_FFX_RST,
      O => XLXI_26_rx_clk_count(3)
    );
  XLXI_26_rx_clk_count_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_clk_count_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_clk_count_3_FFX_RST
    );
  XLXI_26_rx_clk_count_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_clk_count_inst_sum_26,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_clk_count_5_FFY_RST,
      O => XLXI_26_rx_clk_count(6)
    );
  XLXI_26_rx_clk_count_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_clk_count_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_clk_count_5_FFY_RST
    );
  XLXI_26_rx_clk_count_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_clk_count_inst_sum_27,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_clk_count_7_FFX_RST,
      O => XLXI_26_rx_clk_count(7)
    );
  XLXI_26_rx_clk_count_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_clk_count_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_clk_count_7_FFX_RST
    );
  XLXI_26_rx_clk_count_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_clk_count_inst_sum_25,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_clk_count_5_FFX_RST,
      O => XLXI_26_rx_clk_count(5)
    );
  XLXI_26_rx_clk_count_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_clk_count_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_clk_count_5_FFX_RST
    );
  XLXI_1_I4_iinc_i_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_iinc_x(3),
      CE => XLXI_1_I4_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_iinc_i_3_FFX_RST,
      O => XLXI_1_I4_iinc_i(3)
    );
  XLXI_1_I4_iinc_i_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I4_iinc_i_3_FFX_RST
    );
  XLXI_1_I4_iinc_i_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_iinc_x(4),
      CE => XLXI_1_I4_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_iinc_i_5_FFY_RST,
      O => XLXI_1_I4_iinc_i(4)
    );
  XLXI_1_I4_iinc_i_5_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I4_iinc_i_5_FFY_RST
    );
  XLXI_1_I4_iinc_i_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_iinc_x(5),
      CE => XLXI_1_I4_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_iinc_i_5_FFX_RST,
      O => XLXI_1_I4_iinc_i(5)
    );
  XLXI_1_I4_iinc_i_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I4_iinc_i_5_FFX_RST
    );
  XLXI_1_I4_iinc_i_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_iinc_x(7),
      CE => XLXI_1_I4_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_iinc_i_7_FFY_RST,
      O => XLXI_1_I4_iinc_i(7)
    );
  XLXI_1_I4_iinc_i_7_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I4_iinc_i_7_FFY_RST
    );
  XLXI_1_I1_stack_addrs_c_7_0_339 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0014(0),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_7_1_FFY_RST,
      O => XLXI_1_I1_stack_addrs_c_7_0
    );
  XLXI_1_I1_stack_addrs_c_7_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_7_1_FFY_RST
    );
  XLXI_1_I1_stack_addrs_c_7_1_340 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0014(1),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_7_1_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_7_1
    );
  XLXI_1_I1_stack_addrs_c_7_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_7_1_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_7_2_341 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0014(2),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_7_3_FFY_RST,
      O => XLXI_1_I1_stack_addrs_c_7_2
    );
  XLXI_1_I1_stack_addrs_c_7_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_7_3_FFY_RST
    );
  XLXI_1_I1_stack_addrs_c_7_3_342 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0014(3),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_7_3_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_7_3
    );
  XLXI_1_I1_stack_addrs_c_7_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_7_3_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_7_6_343 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0014(6),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_7_7_FFY_RST,
      O => XLXI_1_I1_stack_addrs_c_7_6
    );
  XLXI_1_I1_stack_addrs_c_7_7_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_7_7_FFY_RST
    );
  XLXI_1_I1_stack_addrs_c_7_4_344 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0014(4),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_7_5_FFY_RST,
      O => XLXI_1_I1_stack_addrs_c_7_4
    );
  XLXI_1_I1_stack_addrs_c_7_5_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_7_5_FFY_RST
    );
  XLXI_5_tmr_low_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n0004(5),
      CE => XLXI_5_n0030,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_low_5_FFX_RST,
      O => XLXI_5_tmr_low(5)
    );
  XLXI_5_tmr_low_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_low_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_low_5_FFX_RST
    );
  XLXI_5_tmr_low_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n0004(6),
      CE => XLXI_5_n0030,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_low_7_FFY_RST,
      O => XLXI_5_tmr_low(6)
    );
  XLXI_5_tmr_low_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_low_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_low_7_FFY_RST
    );
  XLXI_5_tmr_low_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n0004(7),
      CE => XLXI_5_n0030,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_low_7_FFX_RST,
      O => XLXI_5_tmr_low(7)
    );
  XLXI_5_tmr_low_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_low_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_low_7_FFX_RST
    );
  XLXI_1_I4_ireg_c_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_n0034(6),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_ireg_c_7_FFY_RST,
      O => XLXI_1_I4_ireg_c(6)
    );
  XLXI_1_I4_ireg_c_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_ireg_c_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_ireg_c_7_FFY_RST
    );
  XLXI_1_I4_ireg_c_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_n0034(7),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_ireg_c_7_FFX_RST,
      O => XLXI_1_I4_ireg_c(7)
    );
  XLXI_1_I4_ireg_c_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_ireg_c_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_ireg_c_7_FFX_RST
    );
  XLXI_1_I4_iinc_we_c_345 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_iinc_we_x,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_iinc_we_c_FFY_RST,
      O => XLXI_1_I4_iinc_we_c
    );
  XLXI_1_I4_iinc_we_c_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_iinc_we_c_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_iinc_we_c_FFY_RST
    );
  XLXI_26_rx_bit_count_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n0039(0),
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_bit_count_1_FFY_RST,
      O => XLXI_26_rx_bit_count(0)
    );
  XLXI_26_rx_bit_count_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_bit_count_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_bit_count_1_FFY_RST
    );
  XLXI_26_rx_bit_count_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n0039(2),
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_bit_count_3_FFY_RST,
      O => XLXI_26_rx_bit_count(2)
    );
  XLXI_26_rx_bit_count_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_bit_count_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_bit_count_3_FFY_RST
    );
  XLXI_26_rx_bit_count_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n0039(1),
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_bit_count_1_FFX_RST,
      O => XLXI_26_rx_bit_count(1)
    );
  XLXI_26_rx_bit_count_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_bit_count_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_bit_count_1_FFX_RST
    );
  XLXI_3_reg_data_out_c_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_reg_data_out_c_7_FROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_3_reg_data_out_c_7_FFX_RST,
      O => XLXI_3_reg_data_out_c(7)
    );
  XLXI_3_reg_data_out_c_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_reg_data_out_c_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_reg_data_out_c_7_FFX_RST
    );
  XLXI_1_I1_pc_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_pc_1_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_pc_1_FFY_RST,
      O => XLXI_1_I1_pc(0)
    );
  XLXI_1_I1_pc_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I1_pc_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I1_pc_1_FFY_RST
    );
  XLXI_1_I1_pc_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_pc_2_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_pc_2_FFY_RST,
      O => XLXI_1_I1_pc(2)
    );
  XLXI_1_I1_pc_2_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I1_pc_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I1_pc_2_FFY_RST
    );
  XLXI_1_I1_pc_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_pc_1_FROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_pc_1_FFX_RST,
      O => XLXI_1_I1_pc(1)
    );
  XLXI_1_I1_pc_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I1_pc_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I1_pc_1_FFX_RST
    );
  XLXI_1_I1_pc_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_pc_3_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_pc_3_FFY_RST,
      O => XLXI_1_I1_pc(3)
    );
  XLXI_1_I1_pc_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I1_pc_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I1_pc_3_FFY_RST
    );
  XLXI_1_I1_pc_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_pc_4_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_pc_4_FFY_RST,
      O => XLXI_1_I1_pc(4)
    );
  XLXI_1_I1_pc_4_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I1_pc_4_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I1_pc_4_FFY_RST
    );
  XLXI_1_I1_pc_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_pc_5_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_pc_5_FFY_RST,
      O => XLXI_1_I1_pc(5)
    );
  XLXI_1_I1_pc_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I1_pc_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I1_pc_5_FFY_RST
    );
  XLXI_1_I2_skip_c_346 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_skip_c_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_skip_c_FFY_RST,
      O => XLXI_1_I2_skip_c
    );
  XLXI_1_I2_skip_c_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_skip_c_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_skip_c_FFY_RST
    );
  XLXI_6_tx_clk_div_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_n0014_5_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_clk_div_5_FFY_RST,
      O => XLXI_6_tx_clk_div(5)
    );
  XLXI_6_tx_clk_div_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_clk_div_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_clk_div_5_FFY_RST
    );
  XLXI_6_tx_clk_div_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_n0014_6_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_clk_div_6_FFY_RST,
      O => XLXI_6_tx_clk_div(6)
    );
  XLXI_6_tx_clk_div_6_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_clk_div_6_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_clk_div_6_FFY_RST
    );
  XLXI_1_I5_daddr_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I5_daddr_c_4_FROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I5_daddr_c_4_FFX_RST,
      O => XLXI_1_I5_daddr_c(4)
    );
  XLXI_1_I5_daddr_c_4_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I5_daddr_c_4_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I5_daddr_c_4_FFX_RST
    );
  XLXI_55_mux_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_55_mux_x_1_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_55_mux_c_1_FFY_RST,
      O => XLXI_55_mux_c(1)
    );
  XLXI_55_mux_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_55_mux_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_55_mux_c_1_FFY_RST
    );
  XLXI_6_tx_uart_busy_347 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_tx_uart_busy_FROM,
      CE => XLXI_6_n00601_O,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_uart_busy_FFX_RST,
      O => XLXI_6_tx_uart_busy
    );
  XLXI_6_tx_uart_busy_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_uart_busy_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_uart_busy_FFX_RST
    );
  XLXI_55_mux_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_55_mux_x_2_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_55_mux_c_3_FFY_RST,
      O => XLXI_55_mux_c(2)
    );
  XLXI_55_mux_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_55_mux_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_55_mux_c_3_FFY_RST
    );
  XLXI_55_mux_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_55_mux_x_3_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_55_mux_c_3_FFX_RST,
      O => XLXI_55_mux_c(3)
    );
  XLXI_55_mux_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_55_mux_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_55_mux_c_3_FFX_RST
    );
  XLXI_1_I5_daddr_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I5_daddr_c_0_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I5_daddr_c_0_FFY_RST,
      O => XLXI_1_I5_daddr_c(0)
    );
  XLXI_1_I5_daddr_c_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I5_daddr_c_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I5_daddr_c_0_FFY_RST
    );
  XLXI_1_I4_iinc_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_n0035(2),
      CE => XLXI_1_I4_n0062,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_iinc_c_3_FFY_RST,
      O => XLXI_1_I4_iinc_c(2)
    );
  XLXI_1_I4_iinc_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_iinc_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_iinc_c_3_FFY_RST
    );
  XLXI_1_I4_iinc_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_n0035(1),
      CE => XLXI_1_I4_n0062,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_iinc_c_1_FFX_RST,
      O => XLXI_1_I4_iinc_c(1)
    );
  XLXI_1_I4_iinc_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_iinc_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_iinc_c_1_FFX_RST
    );
  XLXI_1_I4_iinc_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_n0035(3),
      CE => XLXI_1_I4_n0062,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_iinc_c_3_FFX_RST,
      O => XLXI_1_I4_iinc_c(3)
    );
  XLXI_1_I4_iinc_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_iinc_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_iinc_c_3_FFX_RST
    );
  XLXI_1_I4_iinc_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_n0035(4),
      CE => XLXI_1_I4_n0062,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_iinc_c_5_FFY_RST,
      O => XLXI_1_I4_iinc_c(4)
    );
  XLXI_1_I4_iinc_c_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_iinc_c_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_iinc_c_5_FFY_RST
    );
  XLXI_1_I4_iinc_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_n0035(5),
      CE => XLXI_1_I4_n0062,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_iinc_c_5_FFX_RST,
      O => XLXI_1_I4_iinc_c(5)
    );
  XLXI_1_I4_iinc_c_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_iinc_c_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_iinc_c_5_FFX_RST
    );
  XLXI_1_I4_iinc_c_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_n0035(6),
      CE => XLXI_1_I4_n0062,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_iinc_c_7_FFY_RST,
      O => XLXI_1_I4_iinc_c(6)
    );
  XLXI_1_I4_iinc_c_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_iinc_c_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_iinc_c_7_FFY_RST
    );
  XLXI_1_I4_iinc_c_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_n0035(7),
      CE => XLXI_1_I4_n0062,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_iinc_c_7_FFX_RST,
      O => XLXI_1_I4_iinc_c(7)
    );
  XLXI_1_I4_iinc_c_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_iinc_c_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_iinc_c_7_FFX_RST
    );
  XLXI_1_I4_iinc_i_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_iinc_x(0),
      CE => XLXI_1_I4_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_iinc_i_1_FFY_RST,
      O => XLXI_1_I4_iinc_i(0)
    );
  XLXI_1_I4_iinc_i_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I4_iinc_i_1_FFY_RST
    );
  XLXI_1_I4_iinc_i_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_iinc_x(1),
      CE => XLXI_1_I4_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_iinc_i_1_FFX_RST,
      O => XLXI_1_I4_iinc_i(1)
    );
  XLXI_1_I4_iinc_i_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I4_iinc_i_1_FFX_RST
    );
  XLXI_26_rx_s_FFd1_348 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_s_FFd1_In,
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_s_FFd1_FFY_RST,
      O => XLXI_26_rx_s_FFd1
    );
  XLXI_26_rx_s_FFd1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_s_FFd1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_s_FFd1_FFY_RST
    );
  XLXI_5_tmr_count_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT(1),
      CE => XLXI_5_n0003,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_count_1_FFX_RST,
      O => XLXI_5_tmr_count(1)
    );
  XLXI_5_tmr_count_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_5_tmr_count_1_FFX_RST
    );
  XLXI_1_I3_acc_i_0_6_349 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc(0, 6),
      CE => XLXI_1_I2_int_start_c,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_i_0_6_FFX_RST,
      O => XLXI_1_I3_acc_i_0_6
    );
  XLXI_1_I3_acc_i_0_6_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_i_0_6_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_i_0_6_FFX_RST
    );
  XLXI_5_tmr_count_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT(3),
      CE => XLXI_5_n0003,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_count_3_FFX_RST,
      O => XLXI_5_tmr_count(3)
    );
  XLXI_5_tmr_count_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_5_tmr_count_3_FFX_RST
    );
  XLXI_5_tmr_count_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT(4),
      CE => XLXI_5_n0003,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_count_5_FFY_RST,
      O => XLXI_5_tmr_count(4)
    );
  XLXI_5_tmr_count_5_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_5_tmr_count_5_FFY_RST
    );
  XLXI_5_tmr_count_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT(5),
      CE => XLXI_5_n0003,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_count_5_FFX_RST,
      O => XLXI_5_tmr_count(5)
    );
  XLXI_5_tmr_count_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_5_tmr_count_5_FFX_RST
    );
  XLXI_1_I4_iinc_i_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_iinc_x(6),
      CE => XLXI_1_I4_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_iinc_i_6_FFY_RST,
      O => XLXI_1_I4_iinc_i(6)
    );
  XLXI_1_I4_iinc_i_6_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I4_iinc_i_6_FFY_RST
    );
  XLXI_5_tmr_count_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT(6),
      CE => XLXI_5_n0003,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_count_7_FFY_RST,
      O => XLXI_5_tmr_count(6)
    );
  XLXI_5_tmr_count_7_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_5_tmr_count_7_FFY_RST
    );
  XLXI_1_I5_daddr_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I5_daddr_c_3_FROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I5_daddr_c_3_FFX_RST,
      O => XLXI_1_I5_daddr_c(3)
    );
  XLXI_1_I5_daddr_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I5_daddr_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I5_daddr_c_3_FFX_RST
    );
  XLXI_5_tmr_enable_350 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n00071_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_enable_FFY_RST,
      O => XLXI_5_tmr_enable
    );
  XLXI_5_tmr_enable_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_enable_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_enable_FFY_RST
    );
  XLXI_1_I3_acc_c_0_6_351 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc_c_0_7_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_c_0_7_FFY_RST,
      O => XLXI_1_I3_acc_c_0_6
    );
  XLXI_1_I3_acc_c_0_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_c_0_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_c_0_7_FFY_RST
    );
  XLXI_1_I3_acc_c_0_7_352 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc(0, 7),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_c_0_7_FFX_RST,
      O => XLXI_1_I3_acc_c_0_7
    );
  XLXI_1_I3_acc_c_0_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_c_0_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_c_0_7_FFX_RST
    );
  XLXI_5_tmr_reset_353 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_5_n00061_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => XLXI_5_tmr_reset_FFY_SET,
      RST => GND,
      O => XLXI_5_tmr_reset
    );
  XLXI_5_tmr_reset_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_5_tmr_reset_SRMUX_OUTPUTNOT,
      O => XLXI_5_tmr_reset_FFY_SET
    );
  XLXI_1_I2_valid_c_354 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_valid_x,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_valid_c_FFY_RST,
      O => XLXI_1_I2_valid_c
    );
  XLXI_1_I2_valid_c_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_valid_c_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_valid_c_FFY_RST
    );
  XLXI_26_rx_bit_count_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n0039(3),
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_bit_count_3_FFX_RST,
      O => XLXI_26_rx_bit_count(3)
    );
  XLXI_26_rx_bit_count_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_bit_count_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_bit_count_3_FFX_RST
    );
  XLXI_1_I5_ndwe_c_355 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_1_nadwe_out,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => XLXI_1_I5_ndwe_c_FFY_SET,
      RST => GND,
      O => XLXI_1_I5_ndwe_c
    );
  XLXI_1_I5_ndwe_c_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_1_I5_ndwe_c_SRMUX_OUTPUTNOT,
      O => XLXI_1_I5_ndwe_c_FFY_SET
    );
  XLXI_1_I5_daddr_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I5_daddr_c_1_FROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I5_daddr_c_1_FFX_RST,
      O => XLXI_1_I5_daddr_c(1)
    );
  XLXI_1_I5_daddr_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I5_daddr_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I5_daddr_c_1_FFX_RST
    );
  XLXI_1_I5_daddr_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I5_daddr_c_5_FROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I5_daddr_c_5_FFX_RST,
      O => XLXI_1_I5_daddr_c(5)
    );
  XLXI_1_I5_daddr_c_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I5_daddr_c_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I5_daddr_c_5_FFX_RST
    );
  XLXI_1_I5_daddr_c_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I5_daddr_c_6_FROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I5_daddr_c_6_FFX_RST,
      O => XLXI_1_I5_daddr_c(6)
    );
  XLXI_1_I5_daddr_c_6_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I5_daddr_c_6_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I5_daddr_c_6_FFX_RST
    );
  XLXI_6_tx_uart_shift_5 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_6_tx_uart_fifo(4),
      CE => XLXI_6_n0061,
      CLK => UCLK_BUFGP,
      SET => XLXI_6_tx_uart_shift_5_FFX_SET,
      RST => GND,
      O => XLXI_6_tx_uart_shift(5)
    );
  XLXI_6_tx_uart_shift_5_FFX_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_6_tx_uart_shift_5_SRMUX_OUTPUTNOT,
      O => XLXI_6_tx_uart_shift_5_FFX_SET
    );
  XLXI_6_tx_uart_shift_8 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_6_tx_uart_fifo(7),
      CE => XLXI_6_n0061,
      CLK => UCLK_BUFGP,
      SET => XLXI_6_tx_uart_shift_8_FFY_SET,
      RST => GND,
      O => XLXI_6_tx_uart_shift(8)
    );
  XLXI_6_tx_uart_shift_8_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_6_tx_uart_shift_8_SRMUX_OUTPUTNOT,
      O => XLXI_6_tx_uart_shift_8_FFY_SET
    );
  XLXI_6_tx_uart_shift_7 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_6_tx_uart_fifo(6),
      CE => XLXI_6_n0061,
      CLK => UCLK_BUFGP,
      SET => XLXI_6_tx_uart_shift_7_FFX_SET,
      RST => GND,
      O => XLXI_6_tx_uart_shift(7)
    );
  XLXI_6_tx_uart_shift_7_FFX_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_6_tx_uart_shift_7_SRMUX_OUTPUTNOT,
      O => XLXI_6_tx_uart_shift_7_FFX_SET
    );
  XLXI_26_rx_uart_full_c_356 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n00321_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_uart_full_c_FFY_RST,
      O => XLXI_26_rx_uart_full_c
    );
  XLXI_26_rx_uart_full_c_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_uart_full_c_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_uart_full_c_FFY_RST
    );
  XLXI_1_I3_nreset_v_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_nreset_v_1_LOGIC_ONE,
      CE => XLXI_1_I3_nreset_v(0),
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_nreset_v_1_FFY_RST,
      O => XLXI_1_I3_nreset_v(1)
    );
  XLXI_1_I3_nreset_v_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_nreset_v_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_nreset_v_1_FFY_RST
    );
  XLXI_6_tx_uart_fifo_0 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => CPU_DATA_OUT(0),
      CE => XLXI_6_n0023,
      CLK => UCLK_BUFGP,
      SET => XLXI_6_tx_uart_fifo_1_FFY_SET,
      RST => GND,
      O => XLXI_6_tx_uart_fifo(0)
    );
  XLXI_6_tx_uart_fifo_1_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_6_tx_uart_fifo_1_SRMUX_OUTPUTNOT,
      O => XLXI_6_tx_uart_fifo_1_FFY_SET
    );
  XLXI_6_tx_clk_div_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_n0014_0_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_clk_div_1_FFY_RST,
      O => XLXI_6_tx_clk_div(0)
    );
  XLXI_6_tx_clk_div_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_clk_div_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_clk_div_1_FFY_RST
    );
  XLXI_6_tx_clk_div_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_n0014_1_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_clk_div_1_FFX_RST,
      O => XLXI_6_tx_clk_div(1)
    );
  XLXI_6_tx_clk_div_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_clk_div_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_clk_div_1_FFX_RST
    );
  XLXI_6_tx_clk_div_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_n0014_2_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_clk_div_3_FFY_RST,
      O => XLXI_6_tx_clk_div(2)
    );
  XLXI_6_tx_clk_div_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_clk_div_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_clk_div_3_FFY_RST
    );
  XLXI_6_tx_clk_div_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_n0014_3_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_clk_div_3_FFX_RST,
      O => XLXI_6_tx_clk_div(3)
    );
  XLXI_6_tx_clk_div_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_clk_div_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_clk_div_3_FFX_RST
    );
  XLXI_6_tx_clk_div_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_n0014_4_1_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_clk_div_4_FFY_RST,
      O => XLXI_6_tx_clk_div(4)
    );
  XLXI_6_tx_clk_div_4_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_clk_div_4_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_clk_div_4_FFY_RST
    );
  XLXI_5_tmr_high_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n0005(2),
      CE => XLXI_5_n0031,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_high_2_FFY_RST,
      O => XLXI_5_tmr_high(2)
    );
  XLXI_5_tmr_high_2_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_high_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_high_2_FFY_RST
    );
  XLXI_5_tmr_high_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n0005(3),
      CE => XLXI_5_n0031,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_high_3_FFY_RST,
      O => XLXI_5_tmr_high(3)
    );
  XLXI_5_tmr_high_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_high_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_high_3_FFY_RST
    );
  XLXI_26_rx_uart_ovr_d_357 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_uart_ovr_s,
      CE => XLXI_26_n0099,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_uart_ovr_d_FFY_RST,
      O => XLXI_26_rx_uart_ovr_d
    );
  XLXI_26_rx_uart_ovr_d_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_uart_ovr_d_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_uart_ovr_d_FFY_RST
    );
  XLXI_5_tmr_high_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n0005(4),
      CE => XLXI_5_n0031,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_high_4_FFY_RST,
      O => XLXI_5_tmr_high(4)
    );
  XLXI_5_tmr_high_4_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_high_4_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_high_4_FFY_RST
    );
  XLXI_5_tmr_high_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n0005(5),
      CE => XLXI_5_n0031,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_high_5_FFY_RST,
      O => XLXI_5_tmr_high(5)
    );
  XLXI_5_tmr_high_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_high_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_high_5_FFY_RST
    );
  XLXI_1_I3_nreset_v_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_n0022(0),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_nreset_v_0_FFY_RST,
      O => XLXI_1_I3_nreset_v(0)
    );
  XLXI_1_I3_nreset_v_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_nreset_v_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_nreset_v_0_FFY_RST
    );
  XLXI_4_int_pending_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0001(0),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_pending_c_1_FFY_RST,
      O => XLXI_4_int_pending_c(0)
    );
  XLXI_4_int_pending_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_pending_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_pending_c_1_FFY_RST
    );
  XLXI_4_int_pending_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0001(1),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_pending_c_1_FFX_RST,
      O => XLXI_4_int_pending_c(1)
    );
  XLXI_4_int_pending_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_pending_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_pending_c_1_FFX_RST
    );
  XLXI_4_int_pending_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0001(2),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_pending_c_3_FFY_RST,
      O => XLXI_4_int_pending_c(2)
    );
  XLXI_4_int_pending_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_pending_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_pending_c_3_FFY_RST
    );
  XLXI_4_int_pending_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0001(3),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_pending_c_3_FFX_RST,
      O => XLXI_4_int_pending_c(3)
    );
  XLXI_4_int_pending_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_pending_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_pending_c_3_FFX_RST
    );
  XLXI_4_int_pending_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0001(4),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_pending_c_5_FFY_RST,
      O => XLXI_4_int_pending_c(4)
    );
  XLXI_4_int_pending_c_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_pending_c_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_pending_c_5_FFY_RST
    );
  XLXI_1_I4_nreset_v_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_n0036(0),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_nreset_v_0_FFY_RST,
      O => XLXI_1_I4_nreset_v(0)
    );
  XLXI_1_I4_nreset_v_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_nreset_v_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_nreset_v_0_FFY_RST
    );
  XLXI_4_int_pending_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0001(5),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_pending_c_5_FFX_RST,
      O => XLXI_4_int_pending_c(5)
    );
  XLXI_4_int_pending_c_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_pending_c_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_pending_c_5_FFX_RST
    );
  XLXI_4_int_pending_c_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0001(6),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_pending_c_7_FFY_RST,
      O => XLXI_4_int_pending_c(6)
    );
  XLXI_4_int_pending_c_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_pending_c_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_pending_c_7_FFY_RST
    );
  XLXI_1_I1_stack_addrs_c_7_5_358 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0014(5),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_7_5_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_7_5
    );
  XLXI_1_I1_stack_addrs_c_7_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_7_5_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_7_7_359 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0014(7),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_7_7_FFX_RST,
      O => XLXI_1_I1_stack_addrs_c_7_7
    );
  XLXI_1_I1_stack_addrs_c_7_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_7_7_FFX_RST
    );
  XLXI_1_I1_stack_addrs_c_7_8_360 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0014(8),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_7_8_FFY_RST,
      O => XLXI_1_I1_stack_addrs_c_7_8
    );
  XLXI_1_I1_stack_addrs_c_7_8_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_7_8_FFY_RST
    );
  XLXI_26_rx_clk_div_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_clk_div_1_GROM,
      CE => XLXI_26_n0030,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_clk_div_1_FFY_RST,
      O => XLXI_26_rx_clk_div(0)
    );
  XLXI_26_rx_clk_div_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_clk_div_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_clk_div_1_FFY_RST
    );
  XLXI_26_rx_clk_div_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_clk_div_3_GROM,
      CE => XLXI_26_n0030,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_clk_div_3_FFY_RST,
      O => XLXI_26_rx_clk_div(2)
    );
  XLXI_26_rx_clk_div_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_clk_div_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_clk_div_3_FFY_RST
    );
  XLXI_26_rx_clk_div_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_clk_div_1_FROM,
      CE => XLXI_26_n0030,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_clk_div_1_FFX_RST,
      O => XLXI_26_rx_clk_div(1)
    );
  XLXI_26_rx_clk_div_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_clk_div_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_clk_div_1_FFX_RST
    );
  XLXI_26_rx_clk_div_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_clk_div_5_GROM,
      CE => XLXI_26_n0030,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_clk_div_5_FFY_RST,
      O => XLXI_26_rx_clk_div(4)
    );
  XLXI_26_rx_clk_div_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_clk_div_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_clk_div_5_FFY_RST
    );
  XLXI_26_rx_clk_div_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_clk_div_3_FROM,
      CE => XLXI_26_n0030,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_clk_div_3_FFX_RST,
      O => XLXI_26_rx_clk_div(3)
    );
  XLXI_26_rx_clk_div_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_clk_div_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_clk_div_3_FFX_RST
    );
  XLXI_26_rx_clk_div_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_clk_div_7_GROM,
      CE => XLXI_26_n0030,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_clk_div_7_FFY_RST,
      O => XLXI_26_rx_clk_div(6)
    );
  XLXI_26_rx_clk_div_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_clk_div_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_clk_div_7_FFY_RST
    );
  XLXI_4_int_pending_c_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0001(7),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_pending_c_7_FFX_RST,
      O => XLXI_4_int_pending_c(7)
    );
  XLXI_4_int_pending_c_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_pending_c_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_pending_c_7_FFX_RST
    );
  XLXI_6_tx_bit_count_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_n0010(0),
      CE => XLXI_6_n0055,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_bit_count_0_FFY_RST,
      O => XLXI_6_tx_bit_count(0)
    );
  XLXI_6_tx_bit_count_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_bit_count_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_bit_count_0_FFY_RST
    );
  XLXI_6_tx_bit_count_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_n0010(2),
      CE => XLXI_6_n0055,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_bit_count_3_FFY_RST,
      O => XLXI_6_tx_bit_count(2)
    );
  XLXI_6_tx_bit_count_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_bit_count_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_bit_count_3_FFY_RST
    );
  XLXI_6_tx_bit_count_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_n0010(3),
      CE => XLXI_6_n0055,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_bit_count_3_FFX_RST,
      O => XLXI_6_tx_bit_count(3)
    );
  XLXI_6_tx_bit_count_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_bit_count_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_bit_count_3_FFX_RST
    );
  XLXI_26_rx_16_count_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n0042(0),
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_8_count_0_FFY_RST,
      O => XLXI_26_rx_16_count(0)
    );
  XLXI_26_rx_8_count_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_8_count_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_8_count_0_FFY_RST
    );
  XLXI_1_I1_eaddr_x_0 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0023(0),
      GE => XLXI_1_I1_nreset_v(1),
      CLK => XLXI_1_I1_eaddr_x_1_FFY_CK_LATNOT,
      SET => GND,
      RST => XLXI_1_I1_eaddr_x_1_FFY_RST,
      O => XLXI_1_I1_eaddr_x(0)
    );
  XLXI_1_I1_eaddr_x_1_FFY_CK_LAT : X_INV
    port map (
      I => XLXI_1_I1_eaddr_x_1_CKMUXNOT,
      O => XLXI_1_I1_eaddr_x_1_FFY_CK_LATNOT
    );
  XLXI_1_I1_eaddr_x_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_eaddr_x_1_FFY_RST
    );
  XLXI_26_rx_8_count_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n0041(0),
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_8_count_0_FFX_RST,
      O => XLXI_26_rx_8_count(0)
    );
  XLXI_26_rx_8_count_0_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_8_count_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_8_count_0_FFX_RST
    );
  XLXI_26_rx_16_count_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n0042(2),
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_16_count_3_FFY_RST,
      O => XLXI_26_rx_16_count(2)
    );
  XLXI_26_rx_16_count_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_16_count_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_16_count_3_FFY_RST
    );
  XLXI_26_rx_16_count_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n0042(3),
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_16_count_3_FFX_RST,
      O => XLXI_26_rx_16_count(3)
    );
  XLXI_26_rx_16_count_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_16_count_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_16_count_3_FFX_RST
    );
  XLXI_1_I1_eaddr_x_9 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0023(9),
      GE => XLXI_1_I1_nreset_v(1),
      CLK => XLXI_1_I1_eaddr_x_9_FFX_CK_LATNOT,
      SET => GND,
      RST => XLXI_1_I1_eaddr_x_9_FFX_RST,
      O => XLXI_1_I1_eaddr_x(9)
    );
  XLXI_1_I1_eaddr_x_9_FFX_CK_LAT : X_INV
    port map (
      I => XLXI_1_I1_eaddr_x_9_CKMUXNOT,
      O => XLXI_1_I1_eaddr_x_9_FFX_CK_LATNOT
    );
  XLXI_1_I1_eaddr_x_9_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_eaddr_x_9_FFX_RST
    );
  XLXI_4_int_masked_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0002(0),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_masked_1_FFY_RST,
      O => XLXI_4_int_masked(0)
    );
  XLXI_4_int_masked_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_masked_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_masked_1_FFY_RST
    );
  XLXI_4_int_masked_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0002(1),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_masked_1_FFX_RST,
      O => XLXI_4_int_masked(1)
    );
  XLXI_4_int_masked_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_masked_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_masked_1_FFX_RST
    );
  XLXI_4_int_masked_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0002(2),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_masked_3_FFY_RST,
      O => XLXI_4_int_masked(2)
    );
  XLXI_4_int_masked_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_masked_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_masked_3_FFY_RST
    );
  XLXI_4_int_masked_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0002(3),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_masked_3_FFX_RST,
      O => XLXI_4_int_masked(3)
    );
  XLXI_4_int_masked_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_masked_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_masked_3_FFX_RST
    );
  XLXI_4_int_masked_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0002(4),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_masked_5_FFY_RST,
      O => XLXI_4_int_masked(4)
    );
  XLXI_4_int_masked_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_masked_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_masked_5_FFY_RST
    );
  XLXI_1_I2_S_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_n0040(1),
      CE => XLXI_1_I2_n0105,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_S_c_2_FFY_RST,
      O => XLXI_1_I2_S_c(1)
    );
  XLXI_1_I2_S_c_2_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_S_c_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_S_c_2_FFY_RST
    );
  XLXI_4_int_masked_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0002(5),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_masked_5_FFX_RST,
      O => XLXI_4_int_masked(5)
    );
  XLXI_4_int_masked_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_masked_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_masked_5_FFX_RST
    );
  XLXI_4_int_masked_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0002(6),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_masked_7_FFY_RST,
      O => XLXI_4_int_masked(6)
    );
  XLXI_4_int_masked_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_masked_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_masked_7_FFY_RST
    );
  XLXI_1_I5_daddr_c_8 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I5_daddr_c_8_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I5_daddr_c_8_FFY_RST,
      O => XLXI_1_I5_daddr_c(8)
    );
  XLXI_1_I5_daddr_c_8_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I5_daddr_c_8_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I5_daddr_c_8_FFY_RST
    );
  XLXI_1_I5_daddr_c_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I5_daddr_c_7_FROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I5_daddr_c_7_FFX_RST,
      O => XLXI_1_I5_daddr_c(7)
    );
  XLXI_1_I5_daddr_c_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I5_daddr_c_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I5_daddr_c_7_FFX_RST
    );
  XLXI_26_rx_8z_count_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n0040(0),
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_8z_count_0_FFY_RST,
      O => XLXI_26_rx_8z_count(0)
    );
  XLXI_26_rx_8z_count_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_8z_count_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_8z_count_0_FFY_RST
    );
  XLXI_26_rx_8z_count_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n0040(2),
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_8z_count_3_FFY_RST,
      O => XLXI_26_rx_8z_count(2)
    );
  XLXI_26_rx_8z_count_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_8z_count_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_8z_count_3_FFY_RST
    );
  XLXI_1_I2_nreset_v_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_n0041(0),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_nreset_v_0_FFY_RST,
      O => XLXI_1_I2_nreset_v(0)
    );
  XLXI_1_I2_nreset_v_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_nreset_v_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_nreset_v_0_FFY_RST
    );
  XLXI_26_rx_8z_count_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n0040(3),
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_8z_count_3_FFX_RST,
      O => XLXI_26_rx_8z_count(3)
    );
  XLXI_26_rx_8z_count_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_8z_count_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_8z_count_3_FFX_RST
    );
  XLXI_1_I1_nreset_v_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0013(0),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_nreset_v_0_FFY_RST,
      O => XLXI_1_I1_nreset_v(0)
    );
  XLXI_1_I1_nreset_v_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I1_nreset_v_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I1_nreset_v_0_FFY_RST
    );
  XLXI_1_I2_int_start_c_361 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_int_start_c_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_int_start_c_FFY_RST,
      O => XLXI_1_I2_int_start_c
    );
  XLXI_1_I2_int_start_c_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_int_start_c_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_int_start_c_FFY_RST
    );
  XLXI_5_tmr_low_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n0004(2),
      CE => XLXI_5_n0030,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_low_3_FFY_RST,
      O => XLXI_5_tmr_low(2)
    );
  XLXI_5_tmr_low_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_low_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_low_3_FFY_RST
    );
  XLXI_1_I4_ireg_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_n0034(1),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_ireg_c_1_FFX_RST,
      O => XLXI_1_I4_ireg_c(1)
    );
  XLXI_1_I4_ireg_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_ireg_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_ireg_c_1_FFX_RST
    );
  XLXI_1_I2_int_stop_c_362 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_int_stop_c_FROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_int_stop_c_FFX_RST,
      O => XLXI_1_I2_int_stop_c
    );
  XLXI_1_I2_int_stop_c_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_int_stop_c_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_int_stop_c_FFX_RST
    );
  XLXI_5_tmr_low_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n0004(3),
      CE => XLXI_5_n0030,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_low_3_FFX_RST,
      O => XLXI_5_tmr_low(3)
    );
  XLXI_5_tmr_low_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_low_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_low_3_FFX_RST
    );
  XLXI_1_I4_ireg_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_n0034(2),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_ireg_c_3_FFY_RST,
      O => XLXI_1_I4_ireg_c(2)
    );
  XLXI_1_I4_ireg_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_ireg_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_ireg_c_3_FFY_RST
    );
  XLXI_1_I4_ireg_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_n0034(3),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_ireg_c_3_FFX_RST,
      O => XLXI_1_I4_ireg_c(3)
    );
  XLXI_1_I4_ireg_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_ireg_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_ireg_c_3_FFX_RST
    );
  XLXI_5_tmr_int_x_363 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n0019,
      CE => XLXI_5_n0032,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_int_x_FFY_RST,
      O => XLXI_5_tmr_int_x
    );
  XLXI_5_tmr_int_x_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_int_x_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_int_x_FFY_RST
    );
  XLXI_5_tmr_low_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n0004(4),
      CE => XLXI_5_n0030,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_low_5_FFY_RST,
      O => XLXI_5_tmr_low(4)
    );
  XLXI_5_tmr_low_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_low_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_low_5_FFY_RST
    );
  XLXI_1_I4_ireg_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_n0034(4),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_ireg_c_4_FFY_RST,
      O => XLXI_1_I4_ireg_c(4)
    );
  XLXI_1_I4_ireg_c_4_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_ireg_c_4_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_ireg_c_4_FFY_RST
    );
  XLXI_1_I3_acc_c_0_1_364 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc_c_0_0_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_c_0_0_FFY_RST,
      O => XLXI_1_I3_acc_c_0_1
    );
  XLXI_1_I3_acc_c_0_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_c_0_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_c_0_0_FFY_RST
    );
  XLXI_1_I3_acc_c_0_5_365 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc_c_0_4_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_c_0_4_FFY_RST,
      O => XLXI_1_I3_acc_c_0_5
    );
  XLXI_1_I3_acc_c_0_4_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_c_0_4_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_c_0_4_FFY_RST
    );
  XLXI_1_I3_acc_c_0_3_366 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc_c_0_2_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_c_0_2_FFY_RST,
      O => XLXI_1_I3_acc_c_0_3
    );
  XLXI_1_I3_acc_c_0_2_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_c_0_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_c_0_2_FFY_RST
    );
  XLXI_1_I3_acc_c_0_0_367 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc(0, 0),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_c_0_0_FFX_RST,
      O => XLXI_1_I3_acc_c_0_0
    );
  XLXI_1_I3_acc_c_0_0_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_c_0_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_c_0_0_FFX_RST
    );
  XLXI_1_I3_acc_c_0_8_368 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc(0, 8),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_c_0_8_FFY_RST,
      O => XLXI_1_I3_acc_c_0_8
    );
  XLXI_1_I3_acc_c_0_8_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_c_0_8_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_c_0_8_FFY_RST
    );
  XLXI_1_I3_acc_c_0_2_369 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc(0, 2),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_c_0_2_FFX_RST,
      O => XLXI_1_I3_acc_c_0_2
    );
  XLXI_1_I3_acc_c_0_2_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_c_0_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_c_0_2_FFX_RST
    );
  XLXI_1_I5_daddr_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_adaddr_out(2),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I5_daddr_c_2_FFY_RST,
      O => XLXI_1_I5_daddr_c(2)
    );
  XLXI_1_I5_daddr_c_2_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I5_daddr_c_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I5_daddr_c_2_FFY_RST
    );
  XLXI_1_I3_acc_c_0_4_370 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_acc(0, 4),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_acc_c_0_4_FFX_RST,
      O => XLXI_1_I3_acc_c_0_4
    );
  XLXI_1_I3_acc_c_0_4_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_acc_c_0_4_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_acc_c_0_4_FFX_RST
    );
  XLXI_1_I1_eaddr_x_1 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0023(1),
      GE => XLXI_1_I1_nreset_v(1),
      CLK => XLXI_1_I1_eaddr_x_1_FFX_CK_LATNOT,
      SET => GND,
      RST => XLXI_1_I1_eaddr_x_1_FFX_RST,
      O => XLXI_1_I1_eaddr_x(1)
    );
  XLXI_1_I1_eaddr_x_1_FFX_CK_LAT : X_INV
    port map (
      I => XLXI_1_I1_eaddr_x_1_CKMUXNOT,
      O => XLXI_1_I1_eaddr_x_1_FFX_CK_LATNOT
    );
  XLXI_1_I1_eaddr_x_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_eaddr_x_1_FFX_RST
    );
  XLXI_1_I1_eaddr_x_3 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0023(3),
      GE => XLXI_1_I1_nreset_v(1),
      CLK => XLXI_1_I1_eaddr_x_3_FFY_CK_LATNOT,
      SET => GND,
      RST => XLXI_1_I1_eaddr_x_3_FFY_RST,
      O => XLXI_1_I1_eaddr_x(3)
    );
  XLXI_1_I1_eaddr_x_3_FFY_CK_LAT : X_INV
    port map (
      I => XLXI_1_I1_eaddr_x_3_CKMUXNOT,
      O => XLXI_1_I1_eaddr_x_3_FFY_CK_LATNOT
    );
  XLXI_1_I1_eaddr_x_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_eaddr_x_3_FFY_RST
    );
  XLXI_1_I1_eaddr_x_4 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0023(4),
      GE => XLXI_1_I1_nreset_v(1),
      CLK => XLXI_1_I1_eaddr_x_5_FFY_CK_LATNOT,
      SET => GND,
      RST => XLXI_1_I1_eaddr_x_5_FFY_RST,
      O => XLXI_1_I1_eaddr_x(4)
    );
  XLXI_1_I1_eaddr_x_5_FFY_CK_LAT : X_INV
    port map (
      I => XLXI_1_I1_eaddr_x_5_CKMUXNOT,
      O => XLXI_1_I1_eaddr_x_5_FFY_CK_LATNOT
    );
  XLXI_1_I1_eaddr_x_5_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_eaddr_x_5_FFY_RST
    );
  XLXI_1_I1_eaddr_x_5 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0023(5),
      GE => XLXI_1_I1_nreset_v(1),
      CLK => XLXI_1_I1_eaddr_x_5_FFX_CK_LATNOT,
      SET => GND,
      RST => XLXI_1_I1_eaddr_x_5_FFX_RST,
      O => XLXI_1_I1_eaddr_x(5)
    );
  XLXI_1_I1_eaddr_x_5_FFX_CK_LAT : X_INV
    port map (
      I => XLXI_1_I1_eaddr_x_5_CKMUXNOT,
      O => XLXI_1_I1_eaddr_x_5_FFX_CK_LATNOT
    );
  XLXI_1_I1_eaddr_x_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_eaddr_x_5_FFX_RST
    );
  XLXI_1_I1_eaddr_x_6 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0023(6),
      GE => XLXI_1_I1_nreset_v(1),
      CLK => XLXI_1_I1_eaddr_x_7_FFY_CK_LATNOT,
      SET => GND,
      RST => XLXI_1_I1_eaddr_x_7_FFY_RST,
      O => XLXI_1_I1_eaddr_x(6)
    );
  XLXI_1_I1_eaddr_x_7_FFY_CK_LAT : X_INV
    port map (
      I => XLXI_1_I1_eaddr_x_7_CKMUXNOT,
      O => XLXI_1_I1_eaddr_x_7_FFY_CK_LATNOT
    );
  XLXI_1_I1_eaddr_x_7_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_eaddr_x_7_FFY_RST
    );
  XLXI_1_I1_eaddr_x_7 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0023(7),
      GE => XLXI_1_I1_nreset_v(1),
      CLK => XLXI_1_I1_eaddr_x_7_FFX_CK_LATNOT,
      SET => GND,
      RST => XLXI_1_I1_eaddr_x_7_FFX_RST,
      O => XLXI_1_I1_eaddr_x(7)
    );
  XLXI_1_I1_eaddr_x_7_FFX_CK_LAT : X_INV
    port map (
      I => XLXI_1_I1_eaddr_x_7_CKMUXNOT,
      O => XLXI_1_I1_eaddr_x_7_FFX_CK_LATNOT
    );
  XLXI_1_I1_eaddr_x_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_eaddr_x_7_FFX_RST
    );
  XLXI_1_I1_eaddr_x_8 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0023(8),
      GE => XLXI_1_I1_nreset_v(1),
      CLK => XLXI_1_I1_eaddr_x_9_FFY_CK_LATNOT,
      SET => GND,
      RST => XLXI_1_I1_eaddr_x_9_FFY_RST,
      O => XLXI_1_I1_eaddr_x(8)
    );
  XLXI_1_I1_eaddr_x_9_FFY_CK_LAT : X_INV
    port map (
      I => XLXI_1_I1_eaddr_x_9_CKMUXNOT,
      O => XLXI_1_I1_eaddr_x_9_FFY_CK_LATNOT
    );
  XLXI_1_I1_eaddr_x_9_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_eaddr_x_9_FFY_RST
    );
  XLXI_4_int_masked_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_n0002(7),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_masked_7_FFX_RST,
      O => XLXI_4_int_masked(7)
    );
  XLXI_4_int_masked_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_masked_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_masked_7_FFX_RST
    );
  XLXI_26_rx_8_count_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n0041(3),
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_8_count_3_FFX_RST,
      O => XLXI_26_rx_8_count(3)
    );
  XLXI_26_rx_8_count_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_8_count_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_8_count_3_FFX_RST
    );
  XLXI_1_I2_S_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_int_start_x,
      CE => XLXI_1_I2_n0105,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_S_c_2_FFX_RST,
      O => XLXI_1_I2_S_c(2)
    );
  XLXI_1_I2_S_c_2_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_S_c_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_S_c_2_FFX_RST
    );
  XLXI_5_tmr_high_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n0005(0),
      CE => XLXI_5_n0031,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_high_0_FFY_RST,
      O => XLXI_5_tmr_high(0)
    );
  XLXI_5_tmr_high_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_high_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_high_0_FFY_RST
    );
  XLXI_5_tmr_high_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n0005(1),
      CE => XLXI_5_n0031,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_high_1_FFY_RST,
      O => XLXI_5_tmr_high(1)
    );
  XLXI_5_tmr_high_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_high_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_high_1_FFY_RST
    );
  XLXI_26_rx_s_FFd3_371 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_26_rx_s_FFd3_In,
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => XLXI_26_rx_s_FFd3_FFY_SET,
      RST => GND,
      O => XLXI_26_rx_s_FFd3
    );
  XLXI_26_rx_s_FFd3_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_26_rx_s_FFd3_SRMUX_OUTPUTNOT,
      O => XLXI_26_rx_s_FFd3_FFY_SET
    );
  XLXI_26_rx_s_FFd2_372 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_s_FFd2_In,
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_s_FFd2_FFY_RST,
      O => XLXI_26_rx_s_FFd2
    );
  XLXI_26_rx_s_FFd2_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_s_FFd2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_s_FFd2_FFY_RST
    );
  XLXI_26_rx_uart_reg_0 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => RXD_IBUF,
      CE => XLXI_26_n0118,
      CLK => UCLK_BUFGP,
      SET => XLXI_26_rx_uart_reg_0_FFY_SET,
      RST => GND,
      O => XLXI_26_rx_uart_reg(0)
    );
  XLXI_26_rx_uart_reg_0_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_26_rx_uart_reg_0_SRMUX_OUTPUTNOT,
      O => XLXI_26_rx_uart_reg_0_FFY_SET
    );
  XLXI_26_rx_uart_reg_2 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => RXD_IBUF,
      CE => XLXI_26_n0114,
      CLK => UCLK_BUFGP,
      SET => XLXI_26_rx_uart_reg_2_FFY_SET,
      RST => GND,
      O => XLXI_26_rx_uart_reg(2)
    );
  XLXI_26_rx_uart_reg_2_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_26_rx_uart_reg_2_SRMUX_OUTPUTNOT,
      O => XLXI_26_rx_uart_reg_2_FFY_SET
    );
  XLXI_1_I1_stack_addrs_c_0_4_373 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0021(4),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_0_4_FFY_RST,
      O => XLXI_1_I1_stack_addrs_c_0_4
    );
  XLXI_1_I1_stack_addrs_c_0_4_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_0_4_FFY_RST
    );
  XLXI_1_I1_stack_addrs_c_0_5_374 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0021(5),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_0_5_FFY_RST,
      O => XLXI_1_I1_stack_addrs_c_0_5
    );
  XLXI_1_I1_stack_addrs_c_0_5_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_0_5_FFY_RST
    );
  XLXI_1_I1_stack_addrs_c_0_6_375 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0021(6),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_0_6_FFY_RST,
      O => XLXI_1_I1_stack_addrs_c_0_6
    );
  XLXI_1_I1_stack_addrs_c_0_6_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_0_6_FFY_RST
    );
  XLXI_1_I1_stack_addrs_c_0_7_376 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0021(7),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_0_7_FFY_RST,
      O => XLXI_1_I1_stack_addrs_c_0_7
    );
  XLXI_1_I1_stack_addrs_c_0_7_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_0_7_FFY_RST
    );
  XLXI_6_tx_uart_fifo_1 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => CPU_DATA_OUT(1),
      CE => XLXI_6_n0023,
      CLK => UCLK_BUFGP,
      SET => XLXI_6_tx_uart_fifo_1_FFX_SET,
      RST => GND,
      O => XLXI_6_tx_uart_fifo(1)
    );
  XLXI_6_tx_uart_fifo_1_FFX_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_6_tx_uart_fifo_1_SRMUX_OUTPUTNOT,
      O => XLXI_6_tx_uart_fifo_1_FFX_SET
    );
  XLXI_6_tx_uart_fifo_3 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => CPU_DATA_OUT(3),
      CE => XLXI_6_n0023,
      CLK => UCLK_BUFGP,
      SET => XLXI_6_tx_uart_fifo_3_FFX_SET,
      RST => GND,
      O => XLXI_6_tx_uart_fifo(3)
    );
  XLXI_6_tx_uart_fifo_3_FFX_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_6_tx_uart_fifo_3_SRMUX_OUTPUTNOT,
      O => XLXI_6_tx_uart_fifo_3_FFX_SET
    );
  XLXI_6_tx_uart_fifo_6 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => CPU_DATA_OUT(6),
      CE => XLXI_6_n0023,
      CLK => UCLK_BUFGP,
      SET => XLXI_6_tx_uart_fifo_7_FFY_SET,
      RST => GND,
      O => XLXI_6_tx_uart_fifo(6)
    );
  XLXI_6_tx_uart_fifo_7_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_6_tx_uart_fifo_7_SRMUX_OUTPUTNOT,
      O => XLXI_6_tx_uart_fifo_7_FFY_SET
    );
  XLXI_6_tx_uart_fifo_5 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => CPU_DATA_OUT(5),
      CE => XLXI_6_n0023,
      CLK => UCLK_BUFGP,
      SET => XLXI_6_tx_uart_fifo_5_FFX_SET,
      RST => GND,
      O => XLXI_6_tx_uart_fifo(5)
    );
  XLXI_6_tx_uart_fifo_5_FFX_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_6_tx_uart_fifo_5_SRMUX_OUTPUTNOT,
      O => XLXI_6_tx_uart_fifo_5_FFX_SET
    );
  XLXI_6_tx_uart_fifo_7 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => CPU_DATA_OUT(7),
      CE => XLXI_6_n0023,
      CLK => UCLK_BUFGP,
      SET => XLXI_6_tx_uart_fifo_7_FFX_SET,
      RST => GND,
      O => XLXI_6_tx_uart_fifo(7)
    );
  XLXI_6_tx_uart_fifo_7_FFX_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_6_tx_uart_fifo_7_SRMUX_OUTPUTNOT,
      O => XLXI_6_tx_uart_fifo_7_FFX_SET
    );
  XLXI_55_mux_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_55_mux_x_4_O,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_55_mux_c_4_FFY_RST,
      O => XLXI_55_mux_c(4)
    );
  XLXI_55_mux_c_4_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_55_mux_c_4_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_55_mux_c_4_FFY_RST
    );
  XLXI_1_I1_stack_addrs_c_0_8_377 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0021(8),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_0_8_FFY_RST,
      O => XLXI_1_I1_stack_addrs_c_0_8
    );
  XLXI_1_I1_stack_addrs_c_0_8_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_0_8_FFY_RST
    );
  XLXI_6_tx_bit_count_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_n0010(1),
      CE => XLXI_6_n0055,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_bit_count_1_FFY_RST,
      O => XLXI_6_tx_bit_count(1)
    );
  XLXI_6_tx_bit_count_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_bit_count_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_bit_count_1_FFY_RST
    );
  XLXI_1_I1_stack_addrs_c_0_9_378 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0021(9),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_0_9_FFY_RST,
      O => XLXI_1_I1_stack_addrs_c_0_9
    );
  XLXI_1_I1_stack_addrs_c_0_9_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_0_9_FFY_RST
    );
  XLXI_1_I1_nreset_v_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_nreset_v_1_LOGIC_ONE,
      CE => XLXI_1_I1_nreset_v(0),
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_nreset_v_1_FFY_RST,
      O => XLXI_1_I1_nreset_v(1)
    );
  XLXI_1_I1_nreset_v_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I1_nreset_v_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I1_nreset_v_1_FFY_RST
    );
  XLXI_1_I1_eaddr_x_2 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0023(2),
      GE => XLXI_1_I1_nreset_v(1),
      CLK => XLXI_1_I1_eaddr_x_2_FFY_CK_LATNOT,
      SET => GND,
      RST => XLXI_1_I1_eaddr_x_2_FFY_RST,
      O => XLXI_1_I1_eaddr_x(2)
    );
  XLXI_1_I1_eaddr_x_2_FFY_CK_LAT : X_INV
    port map (
      I => XLXI_1_I1_eaddr_x_2_CKMUXNOT,
      O => XLXI_1_I1_eaddr_x_2_FFY_CK_LATNOT
    );
  XLXI_1_I1_eaddr_x_2_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_eaddr_x_2_FFY_RST
    );
  XLXI_1_I1_stack_addrs_c_7_9_379 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0014(9),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_7_9_FFY_RST,
      O => XLXI_1_I1_stack_addrs_c_7_9
    );
  XLXI_1_I1_stack_addrs_c_7_9_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_7_9_FFY_RST
    );
  XLXI_1_I1_stack_addrs_c_0_0_380 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0021(0),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_0_0_FFY_RST,
      O => XLXI_1_I1_stack_addrs_c_0_0
    );
  XLXI_1_I1_stack_addrs_c_0_0_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_0_0_FFY_RST
    );
  XLXI_1_I1_stack_addrs_c_0_1_381 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0021(1),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_0_1_FFY_RST,
      O => XLXI_1_I1_stack_addrs_c_0_1
    );
  XLXI_1_I1_stack_addrs_c_0_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_0_1_FFY_RST
    );
  XLXI_1_I1_stack_addrs_c_0_2_382 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0021(2),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_0_2_FFY_RST,
      O => XLXI_1_I1_stack_addrs_c_0_2
    );
  XLXI_1_I1_stack_addrs_c_0_2_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_0_2_FFY_RST
    );
  XLXI_1_I1_stack_addrs_c_0_3_383 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I1_n0021(3),
      CE => XLXI_1_I1_n0025,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I1_stack_addrs_c_0_3_FFY_RST,
      O => XLXI_1_I1_stack_addrs_c_0_3
    );
  XLXI_1_I1_stack_addrs_c_0_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_1_I1_stack_addrs_c_0_3_FFY_RST
    );
  XLXI_5_tmr_high_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n0005(6),
      CE => XLXI_5_n0031,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_high_6_FFY_RST,
      O => XLXI_5_tmr_high(6)
    );
  XLXI_5_tmr_high_6_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_high_6_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_high_6_FFY_RST
    );
  XLXI_26_rx_uart_full_d_384 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_uart_full_s,
      CE => XLXI_26_n0098,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_uart_full_d_FFY_RST,
      O => XLXI_26_rx_uart_full_d
    );
  XLXI_26_rx_uart_full_d_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_uart_full_d_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_uart_full_d_FFY_RST
    );
  XLXI_5_tmr_high_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_n0005(7),
      CE => XLXI_5_n0031,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_high_7_FFY_RST,
      O => XLXI_5_tmr_high(7)
    );
  XLXI_5_tmr_high_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_tmr_high_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_5_tmr_high_7_FFY_RST
    );
  XLXI_1_I2_TD_c_3_1_385 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_TD_c_3_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_TD_c_3_FFY_RST,
      O => XLXI_1_I2_TD_c_3_1
    );
  XLXI_1_I2_TD_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_TD_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_TD_c_3_FFY_RST
    );
  XLXI_1_I2_TD_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_TD_x(3),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_TD_c_3_FFX_RST,
      O => XLXI_1_I2_TD_c(3)
    );
  XLXI_1_I2_TD_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_TD_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_TD_c_3_FFX_RST
    );
  XLXI_5_tmr_count_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT(0),
      CE => XLXI_5_n0003,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_count_1_FFY_RST,
      O => XLXI_5_tmr_count(0)
    );
  XLXI_5_tmr_count_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_5_tmr_count_1_FFY_RST
    );
  XLXI_4_int_mask_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT(3),
      CE => XLXI_4_n0005,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_mask_c_3_FFX_RST,
      O => XLXI_4_int_mask_c(3)
    );
  XLXI_4_int_mask_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_mask_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_mask_c_3_FFX_RST
    );
  XLXI_4_int_mask_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT(4),
      CE => XLXI_4_n0005,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_mask_c_5_FFY_RST,
      O => XLXI_4_int_mask_c(4)
    );
  XLXI_4_int_mask_c_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_mask_c_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_mask_c_5_FFY_RST
    );
  XLXI_4_int_mask_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT(5),
      CE => XLXI_4_n0005,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_mask_c_5_FFX_RST,
      O => XLXI_4_int_mask_c(5)
    );
  XLXI_4_int_mask_c_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_mask_c_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_mask_c_5_FFX_RST
    );
  XLXI_4_int_mask_c_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT(6),
      CE => XLXI_4_n0005,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_mask_c_7_FFY_RST,
      O => XLXI_4_int_mask_c(6)
    );
  XLXI_4_int_mask_c_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_mask_c_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_mask_c_7_FFY_RST
    );
  XLXI_4_int_mask_c_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT(7),
      CE => XLXI_4_n0005,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_mask_c_7_FFX_RST,
      O => XLXI_4_int_mask_c(7)
    );
  XLXI_4_int_mask_c_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_mask_c_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_mask_c_7_FFX_RST
    );
  XLXI_6_tx_s_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_6_tx_s_0_BYMUXNOT,
      CE => XLXI_6_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_6_tx_s_0_FFY_RST,
      O => XLXI_6_tx_s(0)
    );
  XLXI_6_tx_s_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_6_tx_s_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_6_tx_s_0_FFY_RST
    );
  XLXI_1_I2_TC_c_0_1_386 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_TC_c_0_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_TC_c_0_FFY_RST,
      O => XLXI_1_I2_TC_c_0_1
    );
  XLXI_1_I2_TC_c_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_TC_c_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_TC_c_0_FFY_RST
    );
  XLXI_1_I3_skip_i_387 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I3_skip_l,
      CE => XLXI_1_I2_int_start_c,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I3_skip_i_FFY_RST,
      O => XLXI_1_I3_skip_i
    );
  XLXI_1_I3_skip_i_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I3_skip_i_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I3_skip_i_FFY_RST
    );
  XLXI_1_I4_ireg_we_c_388 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_ireg_we_x,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_ireg_we_c_FFY_RST,
      O => XLXI_1_I4_ireg_we_c
    );
  XLXI_1_I4_ireg_we_c_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_ireg_we_c_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_ireg_we_c_FFY_RST
    );
  XLXI_5_tmr_count_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT(7),
      CE => XLXI_5_n0003,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_5_tmr_count_7_FFX_RST,
      O => XLXI_5_tmr_count(7)
    );
  XLXI_5_tmr_count_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_5_tmr_count_7_FFX_RST
    );
  XLXI_1_I2_TD_c_0_1_389 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_TD_c_0_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_TD_c_0_FFY_RST,
      O => XLXI_1_I2_TD_c_0_1
    );
  XLXI_1_I2_TD_c_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_TD_c_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_TD_c_0_FFY_RST
    );
  XLXI_1_I2_data_is_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => IDATA(4),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_data_is_c_1_FFY_RST,
      O => XLXI_1_I2_data_is_c(0)
    );
  XLXI_1_I2_data_is_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_data_is_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_data_is_c_1_FFY_RST
    );
  XLXI_1_I2_TD_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_TD_x(0),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_TD_c_0_FFX_RST,
      O => XLXI_1_I2_TD_c(0)
    );
  XLXI_1_I2_TD_c_0_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_TD_c_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_TD_c_0_FFX_RST
    );
  XLXI_1_I2_TD_c_1_1_390 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_TD_c_1_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_TD_c_1_FFY_RST,
      O => XLXI_1_I2_TD_c_1_1
    );
  XLXI_1_I2_TD_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_TD_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_TD_c_1_FFY_RST
    );
  XLXI_1_I2_TD_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_TD_x(1),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_TD_c_1_FFX_RST,
      O => XLXI_1_I2_TD_c(1)
    );
  XLXI_1_I2_TD_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_TD_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_TD_c_1_FFX_RST
    );
  XLXI_1_I2_data_is_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => IDATA(5),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_data_is_c_1_FFX_RST,
      O => XLXI_1_I2_data_is_c(1)
    );
  XLXI_1_I2_data_is_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_data_is_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_data_is_c_1_FFX_RST
    );
  XLXI_1_I2_TD_c_2_1_391 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_TD_c_2_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_TD_c_2_FFY_RST,
      O => XLXI_1_I2_TD_c_2_1
    );
  XLXI_1_I2_TD_c_2_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_TD_c_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_TD_c_2_FFY_RST
    );
  XLXI_1_I2_nreset_v_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_nreset_v_1_LOGIC_ONE,
      CE => XLXI_1_I2_nreset_v(0),
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_nreset_v_1_FFY_RST,
      O => XLXI_1_I2_nreset_v(1)
    );
  XLXI_1_I2_nreset_v_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_nreset_v_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_nreset_v_1_FFY_RST
    );
  XLXI_1_I2_TD_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_TD_x(2),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_TD_c_2_FFX_RST,
      O => XLXI_1_I2_TD_c(2)
    );
  XLXI_1_I2_TD_c_2_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_TD_c_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_TD_c_2_FFX_RST
    );
  XLXI_1_I2_data_is_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => IDATA(8),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_data_is_c_5_FFY_RST,
      O => XLXI_1_I2_data_is_c(4)
    );
  XLXI_1_I2_data_is_c_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_data_is_c_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_data_is_c_5_FFY_RST
    );
  XLXI_1_I2_data_is_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => IDATA(6),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_data_is_c_3_FFY_RST,
      O => XLXI_1_I2_data_is_c(2)
    );
  XLXI_1_I2_data_is_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_data_is_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_data_is_c_3_FFY_RST
    );
  XLXI_1_I2_data_is_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => IDATA(7),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_data_is_c_3_FFX_RST,
      O => XLXI_1_I2_data_is_c(3)
    );
  XLXI_1_I2_data_is_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_data_is_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_data_is_c_3_FFX_RST
    );
  XLXI_1_I2_data_is_c_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => IDATA(10),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_data_is_c_7_FFY_RST,
      O => XLXI_1_I2_data_is_c(6)
    );
  XLXI_1_I2_data_is_c_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_data_is_c_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_data_is_c_7_FFY_RST
    );
  XLXI_1_I2_data_is_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => IDATA(9),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_data_is_c_5_FFX_RST,
      O => XLXI_1_I2_data_is_c(5)
    );
  XLXI_1_I2_data_is_c_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_data_is_c_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_data_is_c_5_FFX_RST
    );
  XLXI_6_tx_uart_shift_0 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_6_tx_uart_shift_1_LOGIC_ZERO,
      CE => XLXI_6_n0061,
      CLK => UCLK_BUFGP,
      SET => XLXI_6_tx_uart_shift_1_FFY_SET,
      RST => GND,
      O => XLXI_6_tx_uart_shift(0)
    );
  XLXI_6_tx_uart_shift_1_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_6_tx_uart_shift_1_SRMUX_OUTPUTNOT,
      O => XLXI_6_tx_uart_shift_1_FFY_SET
    );
  XLXI_6_tx_uart_shift_1 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_6_tx_uart_fifo(0),
      CE => XLXI_6_n0061,
      CLK => UCLK_BUFGP,
      SET => XLXI_6_tx_uart_shift_1_FFX_SET,
      RST => GND,
      O => XLXI_6_tx_uart_shift(1)
    );
  XLXI_6_tx_uart_shift_1_FFX_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_6_tx_uart_shift_1_SRMUX_OUTPUTNOT,
      O => XLXI_6_tx_uart_shift_1_FFX_SET
    );
  XLXI_1_I2_data_is_c_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => IDATA(11),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_data_is_c_7_FFX_RST,
      O => XLXI_1_I2_data_is_c(7)
    );
  XLXI_1_I2_data_is_c_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_data_is_c_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_data_is_c_7_FFX_RST
    );
  XLXI_6_tx_uart_shift_2 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_6_tx_uart_fifo(1),
      CE => XLXI_6_n0061,
      CLK => UCLK_BUFGP,
      SET => XLXI_6_tx_uart_shift_3_FFY_SET,
      RST => GND,
      O => XLXI_6_tx_uart_shift(2)
    );
  XLXI_6_tx_uart_shift_3_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_6_tx_uart_shift_3_SRMUX_OUTPUTNOT,
      O => XLXI_6_tx_uart_shift_3_FFY_SET
    );
  XLXI_6_tx_uart_shift_3 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_6_tx_uart_fifo(2),
      CE => XLXI_6_n0061,
      CLK => UCLK_BUFGP,
      SET => XLXI_6_tx_uart_shift_3_FFX_SET,
      RST => GND,
      O => XLXI_6_tx_uart_shift(3)
    );
  XLXI_6_tx_uart_shift_3_FFX_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_6_tx_uart_shift_3_SRMUX_OUTPUTNOT,
      O => XLXI_6_tx_uart_shift_3_FFX_SET
    );
  XLXI_6_tx_uart_shift_4 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_6_tx_uart_fifo(3),
      CE => XLXI_6_n0061,
      CLK => UCLK_BUFGP,
      SET => XLXI_6_tx_uart_shift_5_FFY_SET,
      RST => GND,
      O => XLXI_6_tx_uart_shift(4)
    );
  XLXI_6_tx_uart_shift_5_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_6_tx_uart_shift_5_SRMUX_OUTPUTNOT,
      O => XLXI_6_tx_uart_shift_5_FFY_SET
    );
  XLXI_1_I4_nreset_v_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I4_nreset_v_1_LOGIC_ONE,
      CE => XLXI_1_I4_nreset_v(0),
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I4_nreset_v_1_FFY_RST,
      O => XLXI_1_I4_nreset_v(1)
    );
  XLXI_1_I4_nreset_v_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I4_nreset_v_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I4_nreset_v_1_FFY_RST
    );
  XLXI_4_int_mask_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT(2),
      CE => XLXI_4_n0005,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_mask_c_3_FFY_RST,
      O => XLXI_4_int_mask_c(2)
    );
  XLXI_4_int_mask_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_mask_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_mask_c_3_FFY_RST
    );
  XLXI_4_int_mask_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT(0),
      CE => XLXI_4_n0005,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_mask_c_1_FFY_RST,
      O => XLXI_4_int_mask_c(0)
    );
  XLXI_4_int_mask_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_mask_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_mask_c_1_FFY_RST
    );
  XLXI_4_int_mask_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT(1),
      CE => XLXI_4_n0005,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_mask_c_1_FFX_RST,
      O => XLXI_4_int_mask_c(1)
    );
  XLXI_4_int_mask_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_mask_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_mask_c_1_FFX_RST
    );
  XLXI_26_rx_8_count_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n0041(1),
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_8_count_1_FFY_RST,
      O => XLXI_26_rx_8_count(1)
    );
  XLXI_26_rx_8_count_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_8_count_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_8_count_1_FFY_RST
    );
  XLXI_1_I2_TC_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_TC_x(0),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_TC_c_0_FFX_RST,
      O => XLXI_1_I2_TC_c(0)
    );
  XLXI_1_I2_TC_c_0_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_TC_c_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_TC_c_0_FFX_RST
    );
  XLXI_26_rx_16_count_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n0042(1),
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_16_count_1_FFY_RST,
      O => XLXI_26_rx_16_count(1)
    );
  XLXI_26_rx_16_count_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_16_count_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_16_count_1_FFY_RST
    );
  XLXI_26_rx_8z_count_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_n0040(1),
      CE => XLXI_26_n0056,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_8z_count_1_FFY_RST,
      O => XLXI_26_rx_8z_count(1)
    );
  XLXI_26_rx_8z_count_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_8z_count_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_8z_count_1_FFY_RST
    );
  XLXI_4_int_masked_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_int_masked(3),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_masked_c_3_FFX_RST,
      O => XLXI_4_int_masked_c(3)
    );
  XLXI_4_int_masked_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_masked_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_masked_c_3_FFX_RST
    );
  XLXI_4_int_masked_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_int_masked(5),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_masked_c_5_FFX_RST,
      O => XLXI_4_int_masked_c(5)
    );
  XLXI_4_int_masked_c_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_masked_c_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_masked_c_5_FFX_RST
    );
  XLXI_4_int_masked_c_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_int_masked(6),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_masked_c_7_FFY_RST,
      O => XLXI_4_int_masked_c(6)
    );
  XLXI_4_int_masked_c_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_masked_c_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_masked_c_7_FFY_RST
    );
  XLXI_4_int_masked_c_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_int_masked(7),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_masked_c_7_FFX_RST,
      O => XLXI_4_int_masked_c(7)
    );
  XLXI_4_int_masked_c_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_masked_c_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_masked_c_7_FFX_RST
    );
  XLXI_26_rx_uart_fifo_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_uart_reg(0),
      CE => XLXI_26_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_uart_fifo_1_FFY_RST,
      O => XLXI_26_rx_uart_fifo(0)
    );
  XLXI_26_rx_uart_fifo_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_uart_fifo_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_uart_fifo_1_FFY_RST
    );
  XLXI_26_rx_uart_fifo_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_uart_reg(1),
      CE => XLXI_26_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_uart_fifo_1_FFX_RST,
      O => XLXI_26_rx_uart_fifo(1)
    );
  XLXI_26_rx_uart_fifo_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_uart_fifo_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_uart_fifo_1_FFX_RST
    );
  XLXI_26_rx_uart_fifo_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_uart_reg(2),
      CE => XLXI_26_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_uart_fifo_3_FFY_RST,
      O => XLXI_26_rx_uart_fifo(2)
    );
  XLXI_26_rx_uart_fifo_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_uart_fifo_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_uart_fifo_3_FFY_RST
    );
  XLXI_26_rx_uart_fifo_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_uart_reg(3),
      CE => XLXI_26_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_uart_fifo_3_FFX_RST,
      O => XLXI_26_rx_uart_fifo(3)
    );
  XLXI_26_rx_uart_fifo_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_uart_fifo_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_uart_fifo_3_FFX_RST
    );
  XLXI_26_rx_uart_fifo_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_uart_reg(4),
      CE => XLXI_26_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_uart_fifo_5_FFY_RST,
      O => XLXI_26_rx_uart_fifo(4)
    );
  XLXI_26_rx_uart_fifo_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_uart_fifo_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_uart_fifo_5_FFY_RST
    );
  XLXI_26_rx_uart_fifo_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_uart_reg(5),
      CE => XLXI_26_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_uart_fifo_5_FFX_RST,
      O => XLXI_26_rx_uart_fifo(5)
    );
  XLXI_26_rx_uart_fifo_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_uart_fifo_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_uart_fifo_5_FFX_RST
    );
  XLXI_26_rx_uart_fifo_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_uart_reg(6),
      CE => XLXI_26_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_uart_fifo_7_FFY_RST,
      O => XLXI_26_rx_uart_fifo(6)
    );
  XLXI_26_rx_uart_fifo_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_uart_fifo_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_uart_fifo_7_FFY_RST
    );
  XLXI_26_rx_uart_fifo_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_26_rx_uart_reg(7),
      CE => XLXI_26_n0033,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_26_rx_uart_fifo_7_FFX_RST,
      O => XLXI_26_rx_uart_fifo(7)
    );
  XLXI_26_rx_uart_fifo_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_26_rx_uart_fifo_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_26_rx_uart_fifo_7_FFX_RST
    );
  XLXI_4_int_masked_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_int_masked(0),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_masked_c_1_FFY_RST,
      O => XLXI_4_int_masked_c(0)
    );
  XLXI_4_int_masked_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_masked_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_masked_c_1_FFY_RST
    );
  XLXI_4_int_masked_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_int_masked(1),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_masked_c_1_FFX_RST,
      O => XLXI_4_int_masked_c(1)
    );
  XLXI_4_int_masked_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_masked_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_masked_c_1_FFX_RST
    );
  XLXI_4_int_masked_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_int_masked(2),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_masked_c_3_FFY_RST,
      O => XLXI_4_int_masked_c(2)
    );
  XLXI_4_int_masked_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_masked_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_masked_c_3_FFY_RST
    );
  XLXI_4_int_masked_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_4_int_masked(4),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_4_int_masked_c_5_FFY_RST,
      O => XLXI_4_int_masked_c(4)
    );
  XLXI_4_int_masked_c_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_4_int_masked_c_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_4_int_masked_c_5_FFY_RST
    );
  XLXI_1_I2_TC_c_2_1_392 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_TC_c_2_GROM,
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_TC_c_2_FFY_RST,
      O => XLXI_1_I2_TC_c_2_1
    );
  XLXI_1_I2_TC_c_2_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_TC_c_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_TC_c_2_FFY_RST
    );
  XLXI_1_I2_TC_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_1_I2_TC_x(2),
      CE => VCC,
      CLK => UCLK_BUFGP,
      SET => GND,
      RST => XLXI_1_I2_TC_c_2_FFX_RST,
      O => XLXI_1_I2_TC_c(2)
    );
  XLXI_1_I2_TC_c_2_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_1_I2_TC_c_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_1_I2_TC_c_2_FFX_RST
    );
  UCLK_BUF : X_CKBUF
    port map (
      I => UCLK,
      O => UCLK_BUFGP_IBUFG
    );
  NRESET_BUF : X_CKBUF
    port map (
      I => NRESET,
      O => NRESET_BUFGP_IBUFG
    );
  UCLK_BUFGP_BUFG_BUF : X_CKBUF
    port map (
      I => UCLK_BUFGP_IBUFG,
      O => UCLK_BUFGP
    );
  NRESET_BUFGP_BUFG_BUF : X_CKBUF
    port map (
      I => NRESET_BUFGP_IBUFG,
      O => NRESET_BUFGP
    );
  PWR_VCC_0_F : X_LUT4
    generic map(
      INIT => X"FFFF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_VCC_0_FROM
    );
  PWR_VCC_0_G : X_LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_VCC_0_GROM
    );
  PWR_VCC_0_XUSED : X_BUF
    port map (
      I => PWR_VCC_0_FROM,
      O => GLOBAL_LOGIC1
    );
  PWR_VCC_0_YUSED : X_BUF
    port map (
      I => PWR_VCC_0_GROM,
      O => GLOBAL_LOGIC0_2
    );
  PWR_VCC_1_F : X_LUT4
    generic map(
      INIT => X"FFFF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_VCC_1_FROM
    );
  PWR_VCC_1_XUSED : X_BUF
    port map (
      I => PWR_VCC_1_FROM,
      O => GLOBAL_LOGIC1_0
    );
  PWR_VCC_2_F : X_LUT4
    generic map(
      INIT => X"FFFF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_VCC_2_FROM
    );
  PWR_VCC_2_XUSED : X_BUF
    port map (
      I => PWR_VCC_2_FROM,
      O => GLOBAL_LOGIC1_1
    );
  PWR_VCC_3_F : X_LUT4
    generic map(
      INIT => X"FFFF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_VCC_3_FROM
    );
  PWR_VCC_3_XUSED : X_BUF
    port map (
      I => PWR_VCC_3_FROM,
      O => GLOBAL_LOGIC1_2
    );
  PWR_VCC_4_F : X_LUT4
    generic map(
      INIT => X"FFFF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_VCC_4_FROM
    );
  PWR_VCC_4_G : X_LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_VCC_4_GROM
    );
  PWR_VCC_4_XUSED : X_BUF
    port map (
      I => PWR_VCC_4_FROM,
      O => GLOBAL_LOGIC1_3
    );
  PWR_VCC_4_YUSED : X_BUF
    port map (
      I => PWR_VCC_4_GROM,
      O => GLOBAL_LOGIC0_5
    );
  PWR_VCC_5_F : X_LUT4
    generic map(
      INIT => X"FFFF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_VCC_5_FROM
    );
  PWR_VCC_5_XUSED : X_BUF
    port map (
      I => PWR_VCC_5_FROM,
      O => GLOBAL_LOGIC1_4
    );
  PWR_VCC_6_F : X_LUT4
    generic map(
      INIT => X"FFFF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_VCC_6_FROM
    );
  PWR_VCC_6_G : X_LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_VCC_6_GROM
    );
  PWR_VCC_6_XUSED : X_BUF
    port map (
      I => PWR_VCC_6_FROM,
      O => GLOBAL_LOGIC1_5
    );
  PWR_VCC_6_YUSED : X_BUF
    port map (
      I => PWR_VCC_6_GROM,
      O => GLOBAL_LOGIC0_7
    );
  PWR_VCC_7_F : X_LUT4
    generic map(
      INIT => X"FFFF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_VCC_7_FROM
    );
  PWR_VCC_7_G : X_LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_VCC_7_GROM
    );
  PWR_VCC_7_XUSED : X_BUF
    port map (
      I => PWR_VCC_7_FROM,
      O => GLOBAL_LOGIC1_6
    );
  PWR_VCC_7_YUSED : X_BUF
    port map (
      I => PWR_VCC_7_GROM,
      O => GLOBAL_LOGIC0_8
    );
  PWR_GND_0_G : X_LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_GND_0_GROM
    );
  PWR_GND_0_YUSED : X_BUF
    port map (
      I => PWR_GND_0_GROM,
      O => GLOBAL_LOGIC0
    );
  PWR_GND_1_G : X_LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_GND_1_GROM
    );
  PWR_GND_1_YUSED : X_BUF
    port map (
      I => PWR_GND_1_GROM,
      O => GLOBAL_LOGIC0_0
    );
  PWR_GND_2_G : X_LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_GND_2_GROM
    );
  PWR_GND_2_YUSED : X_BUF
    port map (
      I => PWR_GND_2_GROM,
      O => GLOBAL_LOGIC0_1
    );
  PWR_GND_3_G : X_LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_GND_3_GROM
    );
  PWR_GND_3_YUSED : X_BUF
    port map (
      I => PWR_GND_3_GROM,
      O => GLOBAL_LOGIC0_3
    );
  PWR_GND_4_G : X_LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_GND_4_GROM
    );
  PWR_GND_4_YUSED : X_BUF
    port map (
      I => PWR_GND_4_GROM,
      O => GLOBAL_LOGIC0_4
    );
  PWR_GND_5_G : X_LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_GND_5_GROM
    );
  PWR_GND_5_YUSED : X_BUF
    port map (
      I => PWR_GND_5_GROM,
      O => GLOBAL_LOGIC0_6
    );
  PWR_GND_6_G : X_LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_GND_6_GROM
    );
  PWR_GND_6_YUSED : X_BUF
    port map (
      I => PWR_GND_6_GROM,
      O => GLOBAL_LOGIC0_9
    );
  PWR_GND_7_G : X_LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_GND_7_GROM
    );
  PWR_GND_7_YUSED : X_BUF
    port map (
      I => PWR_GND_7_GROM,
      O => GLOBAL_LOGIC0_10
    );
  PWR_GND_8_G : X_LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_GND_8_GROM
    );
  PWR_GND_8_YUSED : X_BUF
    port map (
      I => PWR_GND_8_GROM,
      O => GLOBAL_LOGIC0_11
    );
  NlwBlock_cpu8bit_GND : X_ZERO
    port map (
      O => GND
    );
  NlwBlock_cpu8bit_VCC : X_ONE
    port map (
      O => VCC
    );
  NlwBlockROC : X_ROC
    generic map (ROC_WIDTH => 100 ns)
    port map (O => GSR);
  NlwBlockTOC : X_TOC
    port map (O => GTS);

end Structure;

