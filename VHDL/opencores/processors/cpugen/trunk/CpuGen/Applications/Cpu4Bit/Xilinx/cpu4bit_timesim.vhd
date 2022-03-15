-- Xilinx Vhdl netlist produced by netgen application (version G.26)
-- Command       : -intstyle ise -s 5 -pcf cpu4bit.pcf -ngm cpu4bit.ngm -rpw 100 -tpw 0 -ar Structure -xon true -w -ofmt vhdl -sim cpu4bit.ncd cpu4bit_timesim.vhd 
-- Input file    : cpu4bit.ncd
-- Output file   : cpu4bit_timesim.vhd
-- Design name   : cpu4bit
-- # of Entities : 1
-- Xilinx        : C:/Xilinx
-- Device        : 2s30cs144-5 (PRODUCTION 1.27 2003-11-04)

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

entity cpu4bit is
  port (
    nRE_CPU : out STD_LOGIC; 
    nWE_CPU : out STD_LOGIC; 
    PWM_OUT : out STD_LOGIC; 
    NRESET : in STD_LOGIC := 'X'; 
    CLK : in STD_LOGIC := 'X'; 
    CPU_DADDR : out STD_LOGIC_VECTOR ( 5 downto 0 ); 
    CTRL_DATA_OUT : out STD_LOGIC_VECTOR ( 3 downto 0 ); 
    CPU_IADDR : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    CPU_DATA_OUT : out STD_LOGIC_VECTOR ( 3 downto 0 ); 
    CTRL_DATA_IN : in STD_LOGIC_VECTOR ( 3 downto 0 ) 
  );
end cpu4bit;

architecture Structure of cpu4bit is
  signal CPU_IADDR_0_OBUF : STD_LOGIC; 
  signal CPU_IADDR_1_OBUF : STD_LOGIC; 
  signal CPU_IADDR_2_OBUF : STD_LOGIC; 
  signal CPU_IADDR_3_OBUF : STD_LOGIC; 
  signal CPU_IADDR_4_OBUF : STD_LOGIC; 
  signal CPU_IADDR_5_OBUF : STD_LOGIC; 
  signal CPU_IADDR_6_OBUF : STD_LOGIC; 
  signal XLXI_10_I5_ndwe_c : STD_LOGIC; 
  signal CPU_IADDR_7_OBUF : STD_LOGIC; 
  signal XLXI_3_pwm_c : STD_LOGIC; 
  signal CTRL_DATA_IN_0_IBUF : STD_LOGIC; 
  signal CTRL_DATA_IN_1_IBUF : STD_LOGIC; 
  signal CTRL_DATA_IN_2_IBUF : STD_LOGIC; 
  signal CTRL_DATA_IN_3_IBUF : STD_LOGIC; 
  signal CLK_BUFGP : STD_LOGIC; 
  signal XLXI_2_n0039 : STD_LOGIC; 
  signal CPU_DATA_OUT_1_OBUF : STD_LOGIC; 
  signal NRESET_IBUF : STD_LOGIC; 
  signal XLXI_10_I5_Mmux_daddr_out_Result_0_1_1 : STD_LOGIC; 
  signal CPU_DATA_OUT_2_OBUF : STD_LOGIC; 
  signal CPU_DADDR_1_OBUF : STD_LOGIC; 
  signal CPU_DATA_OUT_3_OBUF : STD_LOGIC; 
  signal CPU_DADDR_2_OBUF : STD_LOGIC; 
  signal CPU_DADDR_3_OBUF : STD_LOGIC; 
  signal CPU_DADDR_4_OBUF : STD_LOGIC; 
  signal CPU_DADDR_5_OBUF : STD_LOGIC; 
  signal CLK_BUFGP_IBUFG : STD_LOGIC; 
  signal CPU_DATA_OUT_0_OBUF : STD_LOGIC; 
  signal nRE_CPU_OBUF : STD_LOGIC; 
  signal nWR_RAM : STD_LOGIC; 
  signal GLOBAL_LOGIC0 : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_4 : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_0 : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_1 : STD_LOGIC; 
  signal N23723 : STD_LOGIC; 
  signal CHOICE1817 : STD_LOGIC; 
  signal CHOICE1835 : STD_LOGIC; 
  signal XLXI_10_I3_N8818 : STD_LOGIC; 
  signal XLXI_10_I3_N8655 : STD_LOGIC; 
  signal N23411 : STD_LOGIC; 
  signal CHOICE1918 : STD_LOGIC; 
  signal XLXI_10_I2_valid_c : STD_LOGIC; 
  signal CHOICE1938 : STD_LOGIC; 
  signal N23423 : STD_LOGIC; 
  signal N23355 : STD_LOGIC; 
  signal N23497 : STD_LOGIC; 
  signal CHOICE1852 : STD_LOGIC; 
  signal CHOICE1864 : STD_LOGIC; 
  signal N23405 : STD_LOGIC; 
  signal CHOICE1874 : STD_LOGIC; 
  signal CHOICE1894 : STD_LOGIC; 
  signal N23429 : STD_LOGIC; 
  signal CHOICE2006 : STD_LOGIC; 
  signal CHOICE2026 : STD_LOGIC; 
  signal N23417 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_cy_1 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_cy_3 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_cy_5 : STD_LOGIC; 
  signal XLXI_3_n0017 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_cy_1 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_cy_3 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_cy_5 : STD_LOGIC; 
  signal XLXI_3_n0018 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_cy_29 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_lut2_28 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_lut2_29 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_cy_31 : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_2 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_lut2_30 : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_3 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_lut2_31 : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_cy_25 : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_lut2_24 : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_lut2_25 : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_lut2_26 : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_lut2_27 : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_17 : STD_LOGIC; 
  signal GLOBAL_LOGIC1 : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_19 : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_21 : STD_LOGIC; 
  signal XLXI_3_n0024 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_9 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_8 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_9 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_11 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_10 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_11 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_13 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_12 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_13 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_14 : STD_LOGIC; 
  signal XLXI_3_N6661 : STD_LOGIC; 
  signal XLXI_3_Madd_n0013_inst_cy_17 : STD_LOGIC; 
  signal XLXI_3_Madd_n0013_inst_cy_19 : STD_LOGIC; 
  signal XLXI_3_Madd_n0013_inst_cy_21 : STD_LOGIC; 
  signal XLXI_10_I1_n0014 : STD_LOGIC; 
  signal XLXI_10_I2_pc_mux_x_2_2 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_5 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_5 : STD_LOGIC; 
  signal XLXI_10_I1_n0011_5_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I2_pc_mux_x_1_1 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_5 : STD_LOGIC; 
  signal XLXI_10_I2_pc_mux_x_0_17_1 : STD_LOGIC; 
  signal XLXI_10_I2_pc_mux_x_2_1 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_1 : STD_LOGIC; 
  signal XLXI_10_I1_n0012_1_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_1 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_2 : STD_LOGIC; 
  signal XLXI_10_I1_n0012_2_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_2 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_6 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_6 : STD_LOGIC; 
  signal XLXI_10_I1_n0011_6_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_6 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_3 : STD_LOGIC; 
  signal XLXI_10_I1_n0012_3_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_3 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_4 : STD_LOGIC; 
  signal XLXI_10_I1_n0012_4_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_4 : STD_LOGIC; 
  signal XLXI_10_I1_n0012_5_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_6_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_skip : STD_LOGIC; 
  signal XLXI_10_I2_N8054 : STD_LOGIC; 
  signal XLXI_10_I2_N8130 : STD_LOGIC; 
  signal N21055 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_1 : STD_LOGIC; 
  signal XLXI_10_I1_n0016 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_1 : STD_LOGIC; 
  signal N23875 : STD_LOGIC; 
  signal CHOICE1760 : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_0_31_O : STD_LOGIC; 
  signal N23879 : STD_LOGIC; 
  signal CHOICE1670 : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_1_31_O : STD_LOGIC; 
  signal N23883 : STD_LOGIC; 
  signal CHOICE1685 : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_2_31_O : STD_LOGIC; 
  signal N23887 : STD_LOGIC; 
  signal CHOICE1775 : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_3_31_O : STD_LOGIC; 
  signal N23891 : STD_LOGIC; 
  signal CHOICE1745 : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_4_31_O : STD_LOGIC; 
  signal N23895 : STD_LOGIC; 
  signal CHOICE1715 : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_5_31_O : STD_LOGIC; 
  signal N23899 : STD_LOGIC; 
  signal CHOICE1730 : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_6_31_O : STD_LOGIC; 
  signal N23903 : STD_LOGIC; 
  signal CHOICE1700 : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_7_31_O : STD_LOGIC; 
  signal N22806 : STD_LOGIC; 
  signal N23503 : STD_LOGIC; 
  signal XLXI_10_ndre_int : STD_LOGIC; 
  signal XLXI_2_n0038 : STD_LOGIC; 
  signal XLXI_2_N6097 : STD_LOGIC; 
  signal XLXI_2_N6116 : STD_LOGIC; 
  signal CHOICE1927 : STD_LOGIC; 
  signal XLXI_10_I3_n0035_2_109_SW0_O : STD_LOGIC; 
  signal N23931 : STD_LOGIC; 
  signal CHOICE1901 : STD_LOGIC; 
  signal CHOICE1906 : STD_LOGIC; 
  signal CHOICE1909 : STD_LOGIC; 
  signal CHOICE1912 : STD_LOGIC; 
  signal XLXI_10_I3_N8784 : STD_LOGIC; 
  signal XLXI_10_I3_N8823 : STD_LOGIC; 
  signal XLXI_10_I3_n0037 : STD_LOGIC; 
  signal N22134 : STD_LOGIC; 
  signal XLXI_10_I4_N9468 : STD_LOGIC; 
  signal CHOICE2015 : STD_LOGIC; 
  signal XLXI_10_I3_n0035_3_109_SW0_O : STD_LOGIC; 
  signal N23935 : STD_LOGIC; 
  signal N21808 : STD_LOGIC; 
  signal N20496 : STD_LOGIC; 
  signal N23559 : STD_LOGIC; 
  signal N23595 : STD_LOGIC; 
  signal CHOICE1967 : STD_LOGIC; 
  signal N23475 : STD_LOGIC; 
  signal CHOICE1970 : STD_LOGIC; 
  signal N23473 : STD_LOGIC; 
  signal CPU_DADDR_0_OBUF : STD_LOGIC; 
  signal XLXI_2_Ker6114_SW0_O : STD_LOGIC; 
  signal N23563 : STD_LOGIC; 
  signal N23393 : STD_LOGIC; 
  signal N23385 : STD_LOGIC; 
  signal XLXI_2_N6111 : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW2_O : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW3_O : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW4_O : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW5_O : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW1_O : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW8_O : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW9_O : STD_LOGIC; 
  signal XLXI_3_N6680 : STD_LOGIC; 
  signal XLXI_10_I4_N9501 : STD_LOGIC; 
  signal N23387 : STD_LOGIC; 
  signal N20995 : STD_LOGIC; 
  signal XLXI_10_I2_N8107 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_0 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_0 : STD_LOGIC; 
  signal N23820 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_0 : STD_LOGIC; 
  signal XLXI_10_I1_n0012_0_19_SW0_O : STD_LOGIC; 
  signal N23840 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_7 : STD_LOGIC; 
  signal XLXI_10_I1_n0011_1_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_2 : STD_LOGIC; 
  signal XLXI_10_I1_n0011_2_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_3 : STD_LOGIC; 
  signal XLXI_10_I1_n0011_3_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_4 : STD_LOGIC; 
  signal XLXI_10_I1_n0011_4_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0010_1_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_2 : STD_LOGIC; 
  signal XLXI_10_I1_n0010_2_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_3 : STD_LOGIC; 
  signal XLXI_10_I1_n0010_3_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_0 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_4 : STD_LOGIC; 
  signal XLXI_10_I1_n0010_4_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_5 : STD_LOGIC; 
  signal XLXI_10_I1_n0010_5_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_6 : STD_LOGIC; 
  signal XLXI_10_I1_n0010_6_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_7 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_7 : STD_LOGIC; 
  signal XLXI_10_I3_N8686 : STD_LOGIC; 
  signal XLXI_10_I3_n0053 : STD_LOGIC; 
  signal XLXI_10_I3_n0035_0_27_O : STD_LOGIC; 
  signal XLXI_10_I3_n0055 : STD_LOGIC; 
  signal N23351 : STD_LOGIC; 
  signal CHOICE1807 : STD_LOGIC; 
  signal CHOICE1962 : STD_LOGIC; 
  signal CHOICE1973 : STD_LOGIC; 
  signal CHOICE1816 : STD_LOGIC; 
  signal XLXI_10_I3_n0073 : STD_LOGIC; 
  signal N23927 : STD_LOGIC; 
  signal XLXI_10_I3_n0048 : STD_LOGIC; 
  signal CHOICE1849 : STD_LOGIC; 
  signal XLXI_10_I3_n0035_4_11_SW1_O : STD_LOGIC; 
  signal N23575 : STD_LOGIC; 
  signal CHOICE1309 : STD_LOGIC; 
  signal CHOICE1318 : STD_LOGIC; 
  signal XLXI_10_I3_N8835 : STD_LOGIC; 
  signal XLXI_10_I3_n0045 : STD_LOGIC; 
  signal XLXI_10_I3_n0054 : STD_LOGIC; 
  signal XLXI_10_I4_N9483 : STD_LOGIC; 
  signal N23605 : STD_LOGIC; 
  signal N23603 : STD_LOGIC; 
  signal CHOICE1795 : STD_LOGIC; 
  signal XLXI_10_I3_n0035_0_107_SW0_O : STD_LOGIC; 
  signal CHOICE1875 : STD_LOGIC; 
  signal CHOICE1883 : STD_LOGIC; 
  signal CHOICE1871 : STD_LOGIC; 
  signal XLXI_10_I3_n0035_1_47_O : STD_LOGIC; 
  signal N23427 : STD_LOGIC; 
  signal CHOICE1915 : STD_LOGIC; 
  signal CHOICE1919 : STD_LOGIC; 
  signal XLXI_10_I3_n0035_2_47_SW0_O : STD_LOGIC; 
  signal CHOICE2003 : STD_LOGIC; 
  signal CHOICE2007 : STD_LOGIC; 
  signal XLXI_10_I3_n0035_3_47_SW0_O : STD_LOGIC; 
  signal N23947 : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW15_O : STD_LOGIC; 
  signal N20289 : STD_LOGIC; 
  signal XLXI_2_Ker6121_O : STD_LOGIC; 
  signal N23359 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_7 : STD_LOGIC; 
  signal N23951 : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW14_O : STD_LOGIC; 
  signal N23955 : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW13_O : STD_LOGIC; 
  signal N23959 : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW12_O : STD_LOGIC; 
  signal N23939 : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW11_O : STD_LOGIC; 
  signal N23919 : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW10_O : STD_LOGIC; 
  signal XLXI_10_I2_skip_c : STD_LOGIC; 
  signal N23375 : STD_LOGIC; 
  signal XLXI_10_I2_N8098 : STD_LOGIC; 
  signal CHOICE1559 : STD_LOGIC; 
  signal XLXI_10_I2_N8038 : STD_LOGIC; 
  signal N23371 : STD_LOGIC; 
  signal N22760 : STD_LOGIC; 
  signal N23493 : STD_LOGIC; 
  signal N23491 : STD_LOGIC; 
  signal XLXI_10_I3_n00441_O : STD_LOGIC; 
  signal CHOICE1987 : STD_LOGIC; 
  signal XLXI_3_Ker66781_SW0_O : STD_LOGIC; 
  signal CHOICE2000 : STD_LOGIC; 
  signal XLXI_10_I3_skip_l90_O : STD_LOGIC; 
  signal CHOICE1994 : STD_LOGIC; 
  signal XLXI_3_n0003 : STD_LOGIC; 
  signal XLXI_10_ndwe_int : STD_LOGIC; 
  signal XLXI_10_I4_ipage_we_c : STD_LOGIC; 
  signal XLXI_10_I4_n0044 : STD_LOGIC; 
  signal CHOICE1833 : STD_LOGIC; 
  signal XLXI_10_I3_n0052 : STD_LOGIC; 
  signal XLXI_10_I3_n0062 : STD_LOGIC; 
  signal CHOICE1613 : STD_LOGIC; 
  signal XLXI_10_I3_N8675 : STD_LOGIC; 
  signal N23800 : STD_LOGIC; 
  signal N23399 : STD_LOGIC; 
  signal N23397 : STD_LOGIC; 
  signal N23525 : STD_LOGIC; 
  signal N23363 : STD_LOGIC; 
  signal N23367 : STD_LOGIC; 
  signal N23499 : STD_LOGIC; 
  signal N23519 : STD_LOGIC; 
  signal CHOICE1601 : STD_LOGIC; 
  signal N18981 : STD_LOGIC; 
  signal N23848 : STD_LOGIC; 
  signal XLXI_10_I3_N8705 : STD_LOGIC; 
  signal N23844 : STD_LOGIC; 
  signal N23487 : STD_LOGIC; 
  signal N23735 : STD_LOGIC; 
  signal N23403 : STD_LOGIC; 
  signal N23523 : STD_LOGIC; 
  signal XLXI_3_n0025 : STD_LOGIC; 
  signal N23485 : STD_LOGIC; 
  signal N23784 : STD_LOGIC; 
  signal N23731 : STD_LOGIC; 
  signal CHOICE1610 : STD_LOGIC; 
  signal CHOICE1618 : STD_LOGIC; 
  signal CHOICE1591 : STD_LOGIC; 
  signal CHOICE1637 : STD_LOGIC; 
  signal CHOICE1642 : STD_LOGIC; 
  signal N23772 : STD_LOGIC; 
  signal CHOICE1596 : STD_LOGIC; 
  signal N23481 : STD_LOGIC; 
  signal N23591 : STD_LOGIC; 
  signal N23863 : STD_LOGIC; 
  signal N23479 : STD_LOGIC; 
  signal N23727 : STD_LOGIC; 
  signal N23589 : STD_LOGIC; 
  signal N20573 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_0 : STD_LOGIC; 
  signal GLOBAL_LOGIC0_0 : STD_LOGIC; 
  signal GLOBAL_LOGIC0_1 : STD_LOGIC; 
  signal GLOBAL_LOGIC0_2 : STD_LOGIC; 
  signal GSR : STD_LOGIC; 
  signal GTS : STD_LOGIC; 
  signal CPU_IADDR_0_ENABLE : STD_LOGIC; 
  signal CPU_IADDR_0_TORGTS : STD_LOGIC; 
  signal CPU_IADDR_0_OUTMUX : STD_LOGIC; 
  signal CPU_IADDR_1_ENABLE : STD_LOGIC; 
  signal CPU_IADDR_1_TORGTS : STD_LOGIC; 
  signal CPU_IADDR_1_OUTMUX : STD_LOGIC; 
  signal CPU_IADDR_2_ENABLE : STD_LOGIC; 
  signal CPU_IADDR_2_TORGTS : STD_LOGIC; 
  signal CPU_IADDR_2_OUTMUX : STD_LOGIC; 
  signal CPU_IADDR_3_ENABLE : STD_LOGIC; 
  signal CPU_IADDR_3_TORGTS : STD_LOGIC; 
  signal CPU_IADDR_3_OUTMUX : STD_LOGIC; 
  signal CPU_IADDR_4_ENABLE : STD_LOGIC; 
  signal CPU_IADDR_4_TORGTS : STD_LOGIC; 
  signal CPU_IADDR_4_OUTMUX : STD_LOGIC; 
  signal CPU_IADDR_5_ENABLE : STD_LOGIC; 
  signal CPU_IADDR_5_TORGTS : STD_LOGIC; 
  signal CPU_IADDR_5_OUTMUX : STD_LOGIC; 
  signal CPU_IADDR_6_ENABLE : STD_LOGIC; 
  signal CPU_IADDR_6_TORGTS : STD_LOGIC; 
  signal CPU_IADDR_6_OUTMUX : STD_LOGIC; 
  signal nWE_CPU_ENABLE : STD_LOGIC; 
  signal nWE_CPU_TORGTS : STD_LOGIC; 
  signal nWE_CPU_OUTMUX : STD_LOGIC; 
  signal CPU_IADDR_7_ENABLE : STD_LOGIC; 
  signal CPU_IADDR_7_TORGTS : STD_LOGIC; 
  signal CPU_IADDR_7_OUTMUX : STD_LOGIC; 
  signal PWM_OUT_ENABLE : STD_LOGIC; 
  signal PWM_OUT_TORGTS : STD_LOGIC; 
  signal PWM_OUT_OUTMUX : STD_LOGIC; 
  signal CTRL_DATA_IN_0_IBUF_0 : STD_LOGIC; 
  signal CTRL_DATA_IN_1_IBUF_1 : STD_LOGIC; 
  signal CTRL_DATA_IN_2_IBUF_2 : STD_LOGIC; 
  signal CTRL_DATA_IN_3_IBUF_3 : STD_LOGIC; 
  signal CTRL_DATA_OUT_0_ENABLE : STD_LOGIC; 
  signal CTRL_DATA_OUT_0_TORGTS : STD_LOGIC; 
  signal CTRL_DATA_OUT_0_OUTMUX : STD_LOGIC; 
  signal CTRL_DATA_OUT_1_ENABLE : STD_LOGIC; 
  signal CTRL_DATA_OUT_1_TORGTS : STD_LOGIC; 
  signal CTRL_DATA_OUT_1_OUTMUX : STD_LOGIC; 
  signal CTRL_DATA_OUT_1_OD : STD_LOGIC; 
  signal CTRL_DATA_OUT_1_SRMUXNOT : STD_LOGIC; 
  signal CPU_DADDR_0_ENABLE : STD_LOGIC; 
  signal CPU_DADDR_0_TORGTS : STD_LOGIC; 
  signal CPU_DADDR_0_OUTMUX : STD_LOGIC; 
  signal CTRL_DATA_OUT_2_ENABLE : STD_LOGIC; 
  signal CTRL_DATA_OUT_2_TORGTS : STD_LOGIC; 
  signal CTRL_DATA_OUT_2_OUTMUX : STD_LOGIC; 
  signal CTRL_DATA_OUT_2_OD : STD_LOGIC; 
  signal CTRL_DATA_OUT_2_SRMUXNOT : STD_LOGIC; 
  signal CPU_DADDR_1_ENABLE : STD_LOGIC; 
  signal CPU_DADDR_1_TORGTS : STD_LOGIC; 
  signal CPU_DADDR_1_OUTMUX : STD_LOGIC; 
  signal CTRL_DATA_OUT_3_ENABLE : STD_LOGIC; 
  signal CTRL_DATA_OUT_3_TORGTS : STD_LOGIC; 
  signal CTRL_DATA_OUT_3_OUTMUX : STD_LOGIC; 
  signal CTRL_DATA_OUT_3_OD : STD_LOGIC; 
  signal CTRL_DATA_OUT_3_SRMUXNOT : STD_LOGIC; 
  signal CPU_DADDR_2_ENABLE : STD_LOGIC; 
  signal CPU_DADDR_2_TORGTS : STD_LOGIC; 
  signal CPU_DADDR_2_OUTMUX : STD_LOGIC; 
  signal CPU_DADDR_3_ENABLE : STD_LOGIC; 
  signal CPU_DADDR_3_TORGTS : STD_LOGIC; 
  signal CPU_DADDR_3_OUTMUX : STD_LOGIC; 
  signal CPU_DADDR_4_ENABLE : STD_LOGIC; 
  signal CPU_DADDR_4_TORGTS : STD_LOGIC; 
  signal CPU_DADDR_4_OUTMUX : STD_LOGIC; 
  signal CPU_DADDR_5_ENABLE : STD_LOGIC; 
  signal CPU_DADDR_5_TORGTS : STD_LOGIC; 
  signal CPU_DADDR_5_OUTMUX : STD_LOGIC; 
  signal CPU_DATA_OUT_0_ENABLE : STD_LOGIC; 
  signal CPU_DATA_OUT_0_TORGTS : STD_LOGIC; 
  signal CPU_DATA_OUT_0_OUTMUX : STD_LOGIC; 
  signal CPU_DATA_OUT_1_ENABLE : STD_LOGIC; 
  signal CPU_DATA_OUT_1_TORGTS : STD_LOGIC; 
  signal CPU_DATA_OUT_1_OUTMUX : STD_LOGIC; 
  signal CPU_DATA_OUT_2_ENABLE : STD_LOGIC; 
  signal CPU_DATA_OUT_2_TORGTS : STD_LOGIC; 
  signal CPU_DATA_OUT_2_OUTMUX : STD_LOGIC; 
  signal CPU_DATA_OUT_3_ENABLE : STD_LOGIC; 
  signal CPU_DATA_OUT_3_TORGTS : STD_LOGIC; 
  signal CPU_DATA_OUT_3_OUTMUX : STD_LOGIC; 
  signal NRESET_IBUF_4 : STD_LOGIC; 
  signal nRE_CPU_ENABLE : STD_LOGIC; 
  signal nRE_CPU_TORGTS : STD_LOGIC; 
  signal nRE_CPU_OUTMUX : STD_LOGIC; 
  signal XLXI_4_B5_DOB15 : STD_LOGIC; 
  signal XLXI_4_B5_DOB14 : STD_LOGIC; 
  signal XLXI_4_B5_DOB13 : STD_LOGIC; 
  signal XLXI_4_B5_DOB12 : STD_LOGIC; 
  signal XLXI_4_B5_DOB11 : STD_LOGIC; 
  signal XLXI_4_B5_DOB10 : STD_LOGIC; 
  signal XLXI_4_B5_DOB9 : STD_LOGIC; 
  signal XLXI_4_B5_DOB8 : STD_LOGIC; 
  signal XLXI_4_B5_DOB7 : STD_LOGIC; 
  signal XLXI_4_B5_DOB6 : STD_LOGIC; 
  signal XLXI_4_B5_DOB5 : STD_LOGIC; 
  signal XLXI_4_B5_DOB4 : STD_LOGIC; 
  signal XLXI_4_B5_DOB3 : STD_LOGIC; 
  signal XLXI_4_B5_DOB2 : STD_LOGIC; 
  signal XLXI_4_B5_DOB1 : STD_LOGIC; 
  signal XLXI_4_B5_DOB0 : STD_LOGIC; 
  signal XLXI_4_B5_DOA15 : STD_LOGIC; 
  signal XLXI_4_B5_DOA14 : STD_LOGIC; 
  signal XLXI_4_B5_DOA13 : STD_LOGIC; 
  signal XLXI_4_B5_DOA12 : STD_LOGIC; 
  signal XLXI_4_B5_DOA11 : STD_LOGIC; 
  signal XLXI_4_B5_DOA10 : STD_LOGIC; 
  signal XLXI_4_B5_DOA9 : STD_LOGIC; 
  signal XLXI_4_B5_DOA8 : STD_LOGIC; 
  signal XLXI_4_B5_DOA7 : STD_LOGIC; 
  signal XLXI_4_B5_DOA6 : STD_LOGIC; 
  signal XLXI_4_B5_DOA5 : STD_LOGIC; 
  signal XLXI_4_B5_DOA4 : STD_LOGIC; 
  signal XLXI_4_B5_DIB15 : STD_LOGIC; 
  signal XLXI_4_B5_DIB14 : STD_LOGIC; 
  signal XLXI_4_B5_DIB13 : STD_LOGIC; 
  signal XLXI_4_B5_DIB12 : STD_LOGIC; 
  signal XLXI_4_B5_DIB11 : STD_LOGIC; 
  signal XLXI_4_B5_DIB10 : STD_LOGIC; 
  signal XLXI_4_B5_DIB9 : STD_LOGIC; 
  signal XLXI_4_B5_DIB8 : STD_LOGIC; 
  signal XLXI_4_B5_DIB7 : STD_LOGIC; 
  signal XLXI_4_B5_DIB6 : STD_LOGIC; 
  signal XLXI_4_B5_DIB5 : STD_LOGIC; 
  signal XLXI_4_B5_DIB4 : STD_LOGIC; 
  signal XLXI_4_B5_DIB3 : STD_LOGIC; 
  signal XLXI_4_B5_DIB2 : STD_LOGIC; 
  signal XLXI_4_B5_DIB1 : STD_LOGIC; 
  signal XLXI_4_B5_DIB0 : STD_LOGIC; 
  signal XLXI_4_B5_DIA15 : STD_LOGIC; 
  signal XLXI_4_B5_DIA14 : STD_LOGIC; 
  signal XLXI_4_B5_DIA13 : STD_LOGIC; 
  signal XLXI_4_B5_DIA12 : STD_LOGIC; 
  signal XLXI_4_B5_DIA11 : STD_LOGIC; 
  signal XLXI_4_B5_DIA10 : STD_LOGIC; 
  signal XLXI_4_B5_DIA9 : STD_LOGIC; 
  signal XLXI_4_B5_DIA8 : STD_LOGIC; 
  signal XLXI_4_B5_DIA7 : STD_LOGIC; 
  signal XLXI_4_B5_DIA6 : STD_LOGIC; 
  signal XLXI_4_B5_DIA5 : STD_LOGIC; 
  signal XLXI_4_B5_DIA4 : STD_LOGIC; 
  signal XLXI_4_B5_ADDRB11 : STD_LOGIC; 
  signal XLXI_4_B5_ADDRB10 : STD_LOGIC; 
  signal XLXI_4_B5_ADDRB9 : STD_LOGIC; 
  signal XLXI_4_B5_ADDRB8 : STD_LOGIC; 
  signal XLXI_4_B5_ADDRB7 : STD_LOGIC; 
  signal XLXI_4_B5_ADDRB6 : STD_LOGIC; 
  signal XLXI_4_B5_ADDRB5 : STD_LOGIC; 
  signal XLXI_4_B5_ADDRB4 : STD_LOGIC; 
  signal XLXI_4_B5_ADDRB3 : STD_LOGIC; 
  signal XLXI_4_B5_ADDRB2 : STD_LOGIC; 
  signal XLXI_4_B5_ADDRB1 : STD_LOGIC; 
  signal XLXI_4_B5_ADDRB0 : STD_LOGIC; 
  signal XLXI_4_B5_ADDRA1 : STD_LOGIC; 
  signal XLXI_4_B5_ADDRA0 : STD_LOGIC; 
  signal XLXI_4_B5_WEA_INTNOT : STD_LOGIC; 
  signal XLXI_4_B5_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_4_B5_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_5_B5_DOB15 : STD_LOGIC; 
  signal XLXI_5_B5_DOB14 : STD_LOGIC; 
  signal XLXI_5_B5_DOB13 : STD_LOGIC; 
  signal XLXI_5_B5_DOB12 : STD_LOGIC; 
  signal XLXI_5_B5_DOB11 : STD_LOGIC; 
  signal XLXI_5_B5_DOB10 : STD_LOGIC; 
  signal XLXI_5_B5_DOB9 : STD_LOGIC; 
  signal XLXI_5_B5_DOB8 : STD_LOGIC; 
  signal XLXI_5_B5_DOB7 : STD_LOGIC; 
  signal XLXI_5_B5_DOB6 : STD_LOGIC; 
  signal XLXI_5_B5_DOB5 : STD_LOGIC; 
  signal XLXI_5_B5_DOB4 : STD_LOGIC; 
  signal XLXI_5_B5_DOB3 : STD_LOGIC; 
  signal XLXI_5_B5_DOB2 : STD_LOGIC; 
  signal XLXI_5_B5_DOB1 : STD_LOGIC; 
  signal XLXI_5_B5_DOB0 : STD_LOGIC; 
  signal XLXI_5_B5_DOA15 : STD_LOGIC; 
  signal XLXI_5_B5_DOA14 : STD_LOGIC; 
  signal XLXI_5_B5_DOA13 : STD_LOGIC; 
  signal XLXI_5_B5_DOA12 : STD_LOGIC; 
  signal XLXI_5_B5_DOA11 : STD_LOGIC; 
  signal XLXI_5_B5_DOA10 : STD_LOGIC; 
  signal XLXI_5_B5_DIB15 : STD_LOGIC; 
  signal XLXI_5_B5_DIB14 : STD_LOGIC; 
  signal XLXI_5_B5_DIB13 : STD_LOGIC; 
  signal XLXI_5_B5_DIB12 : STD_LOGIC; 
  signal XLXI_5_B5_DIB11 : STD_LOGIC; 
  signal XLXI_5_B5_DIB10 : STD_LOGIC; 
  signal XLXI_5_B5_DIB9 : STD_LOGIC; 
  signal XLXI_5_B5_DIB8 : STD_LOGIC; 
  signal XLXI_5_B5_DIB7 : STD_LOGIC; 
  signal XLXI_5_B5_DIB6 : STD_LOGIC; 
  signal XLXI_5_B5_DIB5 : STD_LOGIC; 
  signal XLXI_5_B5_DIB4 : STD_LOGIC; 
  signal XLXI_5_B5_DIB3 : STD_LOGIC; 
  signal XLXI_5_B5_DIB2 : STD_LOGIC; 
  signal XLXI_5_B5_DIB1 : STD_LOGIC; 
  signal XLXI_5_B5_DIB0 : STD_LOGIC; 
  signal XLXI_5_B5_ADDRB11 : STD_LOGIC; 
  signal XLXI_5_B5_ADDRB10 : STD_LOGIC; 
  signal XLXI_5_B5_ADDRB9 : STD_LOGIC; 
  signal XLXI_5_B5_ADDRB8 : STD_LOGIC; 
  signal XLXI_5_B5_ADDRB7 : STD_LOGIC; 
  signal XLXI_5_B5_ADDRB6 : STD_LOGIC; 
  signal XLXI_5_B5_ADDRB5 : STD_LOGIC; 
  signal XLXI_5_B5_ADDRB4 : STD_LOGIC; 
  signal XLXI_5_B5_ADDRB3 : STD_LOGIC; 
  signal XLXI_5_B5_ADDRB2 : STD_LOGIC; 
  signal XLXI_5_B5_ADDRB1 : STD_LOGIC; 
  signal XLXI_5_B5_ADDRB0 : STD_LOGIC; 
  signal XLXI_5_B5_ADDRA3 : STD_LOGIC; 
  signal XLXI_5_B5_ADDRA2 : STD_LOGIC; 
  signal XLXI_5_B5_ADDRA1 : STD_LOGIC; 
  signal XLXI_5_B5_ADDRA0 : STD_LOGIC; 
  signal XLXI_5_B5_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_5_B5_LOGIC_ONE : STD_LOGIC; 
  signal N24001 : STD_LOGIC; 
  signal N23999 : STD_LOGIC; 
  signal N23723_F5MUX : STD_LOGIC; 
  signal N23996 : STD_LOGIC; 
  signal N23994 : STD_LOGIC; 
  signal N23411_F5MUX : STD_LOGIC; 
  signal N23986 : STD_LOGIC; 
  signal N23984 : STD_LOGIC; 
  signal N23423_F5MUX : STD_LOGIC; 
  signal N23976 : STD_LOGIC; 
  signal N23974 : STD_LOGIC; 
  signal N23497_F5MUX : STD_LOGIC; 
  signal N23981 : STD_LOGIC; 
  signal N23979 : STD_LOGIC; 
  signal N23405_F5MUX : STD_LOGIC; 
  signal N23971 : STD_LOGIC; 
  signal N23969 : STD_LOGIC; 
  signal N23429_F5MUX : STD_LOGIC; 
  signal N23991 : STD_LOGIC; 
  signal N23989 : STD_LOGIC; 
  signal N23417_F5MUX : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_lut2_0 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_cy_1_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_lut2_1 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_cy_0 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_cy_1_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_lut2_2 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_cy_3_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_lut2_3 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_cy_2 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_cy_3_CYINIT : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_lut2_4 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_cy_5_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_lut2_5 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_cy_4 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_cy_5_CYINIT : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_lut2_6 : STD_LOGIC; 
  signal XLXI_3_n0017_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_lut2_7 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0017_inst_cy_6 : STD_LOGIC; 
  signal XLXI_3_n0017_CYINIT : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_lut2_0 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_cy_1_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_lut2_1 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_cy_0 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_cy_1_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_lut2_2 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_cy_3_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_lut2_3 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_cy_2 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_cy_3_CYINIT : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_lut2_4 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_cy_5_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_lut2_5 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_cy_4 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_cy_5_CYINIT : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_lut2_6 : STD_LOGIC; 
  signal XLXI_3_n0018_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_lut2_7 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0018_inst_cy_6 : STD_LOGIC; 
  signal XLXI_3_n0018_CYINIT : STD_LOGIC; 
  signal XLXI_10_I3_n0059_0_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0059_0_XORF : STD_LOGIC; 
  signal XLXI_10_I3_n0059_0_CYMUXG : STD_LOGIC; 
  signal XLXI_10_I3_n0059_0_XORG : STD_LOGIC; 
  signal XLXI_10_I3_n0059_0_GROM : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_cy_28 : STD_LOGIC; 
  signal XLXI_10_I3_n0059_0_CYINIT : STD_LOGIC; 
  signal XLXI_10_I3_n0059_0_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_10_I3_n0059_2_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0059_2_XORF : STD_LOGIC; 
  signal XLXI_10_I3_n0059_2_CYMUXG : STD_LOGIC; 
  signal XLXI_10_I3_n0059_2_XORG : STD_LOGIC; 
  signal XLXI_10_I3_n0059_2_GROM : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_cy_30 : STD_LOGIC; 
  signal XLXI_10_I3_n0059_2_CYINIT : STD_LOGIC; 
  signal XLXI_10_I3_n0059_4_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0059_4_XORF : STD_LOGIC; 
  signal XLXI_10_I3_n0059_4_CYINIT : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_lut2_24_rt : STD_LOGIC; 
  signal XLXI_10_I3_n0064_1_CYMUXG : STD_LOGIC; 
  signal XLXI_10_I3_n0064_1_XORG : STD_LOGIC; 
  signal XLXI_10_I3_n0064_1_GROM : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_cy_24 : STD_LOGIC; 
  signal XLXI_10_I3_n0064_1_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_10_I3_n0064_2_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0064_2_XORF : STD_LOGIC; 
  signal XLXI_10_I3_n0064_2_CYMUXG : STD_LOGIC; 
  signal XLXI_10_I3_n0064_2_XORG : STD_LOGIC; 
  signal XLXI_10_I3_n0064_2_GROM : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_cy_26 : STD_LOGIC; 
  signal XLXI_10_I3_n0064_2_CYINIT : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_lut2_16 : STD_LOGIC; 
  signal XLXI_10_I1_n0013_1_CYMUXG : STD_LOGIC; 
  signal XLXI_10_I1_n0013_1_XORG : STD_LOGIC; 
  signal XLXI_10_I1_n0013_1_GROM : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_16 : STD_LOGIC; 
  signal XLXI_10_I1_n0013_1_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_10_I1_n0013_2_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0013_2_XORF : STD_LOGIC; 
  signal XLXI_10_I1_n0013_2_CYMUXG : STD_LOGIC; 
  signal XLXI_10_I1_n0013_2_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_10_I1_n0013_2_XORG : STD_LOGIC; 
  signal XLXI_10_I1_n0013_2_GROM : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_18 : STD_LOGIC; 
  signal XLXI_10_I1_n0013_2_CYINIT : STD_LOGIC; 
  signal XLXI_10_I1_n0013_4_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0013_4_XORF : STD_LOGIC; 
  signal XLXI_10_I1_n0013_4_CYMUXG : STD_LOGIC; 
  signal XLXI_10_I1_n0013_4_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_10_I1_n0013_4_XORG : STD_LOGIC; 
  signal XLXI_10_I1_n0013_4_GROM : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_20 : STD_LOGIC; 
  signal XLXI_10_I1_n0013_4_CYINIT : STD_LOGIC; 
  signal XLXI_10_I1_n0013_6_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_10_I1_n0013_6_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0013_6_XORF : STD_LOGIC; 
  signal XLXI_10_I1_n0013_6_XORG : STD_LOGIC; 
  signal XLXI_10_I1_pc_7_rt : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_22 : STD_LOGIC; 
  signal XLXI_10_I1_n0013_6_CYINIT : STD_LOGIC; 
  signal XLXI_3_pwm_high_0_FROM : STD_LOGIC; 
  signal XLXI_3_pwm_high_0_CYMUXG : STD_LOGIC; 
  signal XLXI_3_pwm_high_0_GROM : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_8 : STD_LOGIC; 
  signal XLXI_3_pwm_high_0_CYINIT : STD_LOGIC; 
  signal XLXI_3_pwm_high_0_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_3_pwm_high_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_pwm_high_2_FROM : STD_LOGIC; 
  signal XLXI_3_pwm_high_2_CYMUXG : STD_LOGIC; 
  signal XLXI_3_pwm_high_2_GROM : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_10 : STD_LOGIC; 
  signal XLXI_3_pwm_high_2_CYINIT : STD_LOGIC; 
  signal XLXI_3_pwm_high_2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_pwm_high_4_FROM : STD_LOGIC; 
  signal XLXI_3_pwm_high_4_CYMUXG : STD_LOGIC; 
  signal XLXI_3_pwm_high_4_GROM : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_12 : STD_LOGIC; 
  signal XLXI_3_pwm_high_4_CYINIT : STD_LOGIC; 
  signal XLXI_3_pwm_high_4_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_pwm_high_6_FROM : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_151_O : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_14 : STD_LOGIC; 
  signal XLXI_3_pwm_high_6_CYINIT : STD_LOGIC; 
  signal XLXI_3_pwm_high_6_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_Madd_n0013_inst_lut2_16 : STD_LOGIC; 
  signal XLXI_3_n0013_1_CYMUXG : STD_LOGIC; 
  signal XLXI_3_n0013_1_XORG : STD_LOGIC; 
  signal XLXI_3_n0013_1_GROM : STD_LOGIC; 
  signal XLXI_3_Madd_n0013_inst_cy_16 : STD_LOGIC; 
  signal XLXI_3_n0013_1_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_3_n0013_2_FROM : STD_LOGIC; 
  signal XLXI_3_n0013_2_XORF : STD_LOGIC; 
  signal XLXI_3_n0013_2_CYMUXG : STD_LOGIC; 
  signal XLXI_3_n0013_2_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_3_n0013_2_XORG : STD_LOGIC; 
  signal XLXI_3_n0013_2_GROM : STD_LOGIC; 
  signal XLXI_3_Madd_n0013_inst_cy_18 : STD_LOGIC; 
  signal XLXI_3_n0013_2_CYINIT : STD_LOGIC; 
  signal XLXI_3_n0013_4_FROM : STD_LOGIC; 
  signal XLXI_3_n0013_4_XORF : STD_LOGIC; 
  signal XLXI_3_n0013_4_CYMUXG : STD_LOGIC; 
  signal XLXI_3_n0013_4_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_3_n0013_4_XORG : STD_LOGIC; 
  signal XLXI_3_n0013_4_GROM : STD_LOGIC; 
  signal XLXI_3_Madd_n0013_inst_cy_20 : STD_LOGIC; 
  signal XLXI_3_n0013_4_CYINIT : STD_LOGIC; 
  signal XLXI_3_n0013_6_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_3_n0013_6_FROM : STD_LOGIC; 
  signal XLXI_3_n0013_6_XORF : STD_LOGIC; 
  signal XLXI_3_n0013_6_XORG : STD_LOGIC; 
  signal XLXI_3_pwm_count_7_rt : STD_LOGIC; 
  signal XLXI_3_Madd_n0013_inst_cy_22 : STD_LOGIC; 
  signal XLXI_3_n0013_6_CYINIT : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_5_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0011_5_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_1_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0012_1_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_2_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0012_2_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_6_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0011_6_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_3_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0012_3_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_4_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0012_4_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_5_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0012_5_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_6_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0012_6_19_O : STD_LOGIC; 
  signal XLXI_10_I2_N8130_FROM : STD_LOGIC; 
  signal XLXI_10_I2_N8130_GROM : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_1_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0009_1_1_O : STD_LOGIC; 
  signal XLXI_10_I1_pc_0_FROM : STD_LOGIC; 
  signal XLXI_10_I1_pc_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I1_pc_0_GROM : STD_LOGIC; 
  signal XLXI_10_I1_pc_1_FROM : STD_LOGIC; 
  signal XLXI_10_I1_pc_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I1_pc_1_GROM : STD_LOGIC; 
  signal XLXI_10_I1_pc_2_FROM : STD_LOGIC; 
  signal XLXI_10_I1_pc_2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I1_pc_2_GROM : STD_LOGIC; 
  signal XLXI_10_I1_pc_3_FROM : STD_LOGIC; 
  signal XLXI_10_I1_pc_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I1_pc_3_GROM : STD_LOGIC; 
  signal XLXI_10_I1_pc_4_FROM : STD_LOGIC; 
  signal XLXI_10_I1_pc_4_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I1_pc_4_GROM : STD_LOGIC; 
  signal XLXI_10_I1_pc_5_FROM : STD_LOGIC; 
  signal XLXI_10_I1_pc_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I1_pc_5_GROM : STD_LOGIC; 
  signal XLXI_10_I1_pc_6_FROM : STD_LOGIC; 
  signal XLXI_10_I1_pc_6_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I1_pc_6_GROM : STD_LOGIC; 
  signal XLXI_10_I1_pc_7_FROM : STD_LOGIC; 
  signal XLXI_10_I1_pc_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I1_pc_7_GROM : STD_LOGIC; 
  signal N23503_FROM : STD_LOGIC; 
  signal N23503_GROM : STD_LOGIC; 
  signal XLXI_2_Mmux_n0018_Result_1_1_O : STD_LOGIC; 
  signal XLXI_2_pwm_data_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_2_Mmux_n0018_Result_0_1_O : STD_LOGIC; 
  signal XLXI_2_Mmux_n0018_Result_3_1_O : STD_LOGIC; 
  signal XLXI_2_pwm_data_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_2_Mmux_n0018_Result_2_1_O : STD_LOGIC; 
  signal XLXI_10_I3_n0035_2_109_SW0_O_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0035_2_109_SW0_O_GROM : STD_LOGIC; 
  signal XLXI_10_I3_data_x_1_FROM : STD_LOGIC; 
  signal XLXI_10_I3_data_x_1_GROM : STD_LOGIC; 
  signal XLXI_10_I3_data_x_2_FROM : STD_LOGIC; 
  signal XLXI_10_I3_data_x_2_GROM : STD_LOGIC; 
  signal XLXI_10_I3_n0035_3_109_SW0_O_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0035_3_109_SW0_O_GROM : STD_LOGIC; 
  signal XLXI_10_I3_data_x_3_FROM : STD_LOGIC; 
  signal XLXI_10_I3_data_x_3_GROM : STD_LOGIC; 
  signal CHOICE1970_FROM : STD_LOGIC; 
  signal CHOICE1970_GROM : STD_LOGIC; 
  signal XLXI_2_Ker6114_SW0_O_FROM : STD_LOGIC; 
  signal XLXI_2_Ker6114_SW0_O_GROM : STD_LOGIC; 
  signal CHOICE1909_FROM : STD_LOGIC; 
  signal CHOICE1909_GROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW2_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW2_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW3_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW3_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW4_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW4_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW5_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW5_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW1_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW1_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW8_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW8_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW9_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW9_O_GROM : STD_LOGIC; 
  signal XLXI_3_n0009_1_1_O : STD_LOGIC; 
  signal XLXI_3_n0009_0_1_O : STD_LOGIC; 
  signal XLXI_3_n0009_3_1_O : STD_LOGIC; 
  signal XLXI_3_n0009_2_1_O : STD_LOGIC; 
  signal XLXI_3_n0009_5_1_O : STD_LOGIC; 
  signal XLXI_3_n0009_4_1_O : STD_LOGIC; 
  signal XLXI_3_n0009_7_1_O : STD_LOGIC; 
  signal XLXI_3_n0009_6_1_O : STD_LOGIC; 
  signal CHOICE1967_FROM : STD_LOGIC; 
  signal CHOICE1967_GROM : STD_LOGIC; 
  signal CHOICE1906_FROM : STD_LOGIC; 
  signal CHOICE1906_GROM : STD_LOGIC; 
  signal XLXI_10_I2_pc_mux_x_2_2_FROM : STD_LOGIC; 
  signal XLXI_10_I2_pc_mux_x_2_2_GROM : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_0_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0012_0_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_7_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0011_0_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_1_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0011_1_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_2_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0011_2_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_3_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0011_3_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_4_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0011_4_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_1_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0010_1_19_O : STD_LOGIC; 
  signal CTRL_DATA_OUT_1_OFF_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_2_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0010_2_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_3_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0010_3_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0009_0_1_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_4_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0010_4_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_5_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0010_5_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0009_3_1_O : STD_LOGIC; 
  signal XLXI_10_I1_n0009_2_1_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_6_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0010_6_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0009_5_1_O : STD_LOGIC; 
  signal XLXI_10_I1_n0009_4_1_O : STD_LOGIC; 
  signal XLXI_10_I1_n0009_7_1_O : STD_LOGIC; 
  signal XLXI_10_I1_n0009_6_1_O : STD_LOGIC; 
  signal XLXI_10_I3_n0035_0_27_O_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0035_0_27_O_GROM : STD_LOGIC; 
  signal XLXI_10_I3_data_x_0_FROM : STD_LOGIC; 
  signal XLXI_10_I3_data_x_0_GROM : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_4_FROM : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_4_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I3_n0035_4_96_O : STD_LOGIC; 
  signal XLXI_10_I3_N8835_FROM : STD_LOGIC; 
  signal XLXI_10_I3_N8835_GROM : STD_LOGIC; 
  signal XLXI_2_N6111_FROM : STD_LOGIC; 
  signal XLXI_2_N6111_GROM : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_0_FROM : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I3_n0035_0_220_O : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_1_FROM : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I3_n0035_1_145_O : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_2_FROM : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I3_n0035_2_145_O : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_3_FROM : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I3_n0035_3_145_O : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW15_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW15_O_GROM : STD_LOGIC; 
  signal XLXI_2_mux_c_0_FROM : STD_LOGIC; 
  signal XLXI_2_mux_c_0_GROM : STD_LOGIC; 
  signal XLXI_2_mux_c_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I2_N8107_FROM : STD_LOGIC; 
  signal XLXI_10_I2_N8107_GROM : STD_LOGIC; 
  signal XLXI_10_I2_data_is_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal CHOICE1915_FROM : STD_LOGIC; 
  signal CHOICE1915_GROM : STD_LOGIC; 
  signal XLXI_10_I3_N8675_FROM : STD_LOGIC; 
  signal XLXI_10_I3_N8675_GROM : STD_LOGIC; 
  signal CHOICE1849_FROM : STD_LOGIC; 
  signal CHOICE1849_GROM : STD_LOGIC; 
  signal XLXI_10_I3_N8686_FROM : STD_LOGIC; 
  signal XLXI_10_I3_N8686_GROM : STD_LOGIC; 
  signal CHOICE1994_FROM : STD_LOGIC; 
  signal CHOICE1994_GROM : STD_LOGIC; 
  signal CHOICE1835_FROM : STD_LOGIC; 
  signal CHOICE1835_GROM : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_7_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0011_7_19_O : STD_LOGIC; 
  signal CHOICE1816_FROM : STD_LOGIC; 
  signal CHOICE1816_GROM : STD_LOGIC; 
  signal N23903_FROM : STD_LOGIC; 
  signal N23903_GROM : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_lut2_30_GROM : STD_LOGIC; 
  signal N23525_FROM : STD_LOGIC; 
  signal N23525_GROM : STD_LOGIC; 
  signal N23363_FROM : STD_LOGIC; 
  signal N23363_GROM : STD_LOGIC; 
  signal N23367_FROM : STD_LOGIC; 
  signal N23367_GROM : STD_LOGIC; 
  signal N23499_FROM : STD_LOGIC; 
  signal N23499_GROM : STD_LOGIC; 
  signal N23493_FROM : STD_LOGIC; 
  signal N23493_GROM : STD_LOGIC; 
  signal XLXI_3_pwm_low_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal N23519_FROM : STD_LOGIC; 
  signal N23519_GROM : STD_LOGIC; 
  signal XLXI_3_pwm_low_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal CHOICE1601_FROM : STD_LOGIC; 
  signal CHOICE1601_GROM : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_0_FROM : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I5_ndwe_c_FROM : STD_LOGIC; 
  signal XLXI_10_I5_ndwe_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_nadwe_out : STD_LOGIC; 
  signal XLXI_10_I4_n0044_GROM : STD_LOGIC; 
  signal N23848_FROM : STD_LOGIC; 
  signal N23848_GROM : STD_LOGIC; 
  signal CHOICE2015_FROM : STD_LOGIC; 
  signal CHOICE2015_GROM : STD_LOGIC; 
  signal CHOICE1318_FROM : STD_LOGIC; 
  signal CHOICE1318_GROM : STD_LOGIC; 
  signal XLXI_10_I3_N8655_FROM : STD_LOGIC; 
  signal XLXI_10_I3_N8655_GROM : STD_LOGIC; 
  signal CHOICE1901_FROM : STD_LOGIC; 
  signal CHOICE1901_GROM : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_2_FROM : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal N23939_FROM : STD_LOGIC; 
  signal N23939_GROM : STD_LOGIC; 
  signal N23899_FROM : STD_LOGIC; 
  signal N23899_GROM : STD_LOGIC; 
  signal N23947_FROM : STD_LOGIC; 
  signal N23947_GROM : STD_LOGIC; 
  signal N23951_FROM : STD_LOGIC; 
  signal N23951_GROM : STD_LOGIC; 
  signal XLXI_3_n0003_FROM : STD_LOGIC; 
  signal XLXI_3_n0003_GROM : STD_LOGIC; 
  signal N23487_FROM : STD_LOGIC; 
  signal N23487_GROM : STD_LOGIC; 
  signal N23735_FROM : STD_LOGIC; 
  signal N23735_GROM : STD_LOGIC; 
  signal N23603_GROM : STD_LOGIC; 
  signal N23605_GROM : STD_LOGIC; 
  signal CHOICE1775_FROM : STD_LOGIC; 
  signal CHOICE1775_GROM : STD_LOGIC; 
  signal N23559_FROM : STD_LOGIC; 
  signal N23559_GROM : STD_LOGIC; 
  signal N23575_GROM : STD_LOGIC; 
  signal N23523_FROM : STD_LOGIC; 
  signal N23523_GROM : STD_LOGIC; 
  signal XLXI_3_pwm_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_pwm_c_BYMUXNOT : STD_LOGIC; 
  signal N23393_FROM : STD_LOGIC; 
  signal N23393_GROM : STD_LOGIC; 
  signal CPU_DADDR_4_OBUF_FROM : STD_LOGIC; 
  signal CPU_DADDR_4_OBUF_GROM : STD_LOGIC; 
  signal XLXI_10_I2_pc_mux_x_2_1_FROM : STD_LOGIC; 
  signal XLXI_10_I2_pc_mux_x_2_1_GROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW14_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW14_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW13_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW13_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW12_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW12_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW11_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW11_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW10_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker66591_SW10_O_GROM : STD_LOGIC; 
  signal XLXI_10_I4_N9501_FROM : STD_LOGIC; 
  signal XLXI_10_I4_N9501_GROM : STD_LOGIC; 
  signal N22806_FROM : STD_LOGIC; 
  signal N22806_GROM : STD_LOGIC; 
  signal XLXI_10_pc_mux_0_FROM : STD_LOGIC; 
  signal XLXI_10_pc_mux_0_GROM : STD_LOGIC; 
  signal CTRL_DATA_OUT_2_OFF_RST : STD_LOGIC; 
  signal XLXI_10_I5_Mmux_daddr_out_Result_0_1_1_FROM : STD_LOGIC; 
  signal XLXI_10_I5_Mmux_daddr_out_Result_0_1_1_GROM : STD_LOGIC; 
  signal N20496_FROM : STD_LOGIC; 
  signal N20496_GROM : STD_LOGIC; 
  signal XLXI_10_I2_N8098_FROM : STD_LOGIC; 
  signal XLXI_10_I2_N8098_GROM : STD_LOGIC; 
  signal N23355_FROM : STD_LOGIC; 
  signal N23355_GROM : STD_LOGIC; 
  signal XLXI_10_I3_n00441_O_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n00441_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker66781_SW0_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker66781_SW0_O_GROM : STD_LOGIC; 
  signal XLXI_10_I2_skip_c_FROM : STD_LOGIC; 
  signal XLXI_10_I2_skip_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I2_skip_c_GROM : STD_LOGIC; 
  signal XLXI_10_pc_mux_2_FROM : STD_LOGIC; 
  signal XLXI_10_pc_mux_2_GROM : STD_LOGIC; 
  signal CPU_DADDR_0_OBUF_FROM : STD_LOGIC; 
  signal CPU_DADDR_0_OBUF_GROM : STD_LOGIC; 
  signal XLXI_3_pwm_count_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_pwm_count_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_pwm_count_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_pwm_count_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_pwm_low_1_FROM : STD_LOGIC; 
  signal XLXI_3_pwm_low_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_pwm_low_1_GROM : STD_LOGIC; 
  signal XLXI_3_pwm_low_3_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_low_3_FROM : STD_LOGIC; 
  signal XLXI_3_pwm_low_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_pwm_low_3_GROM : STD_LOGIC; 
  signal XLXI_10_I4_ipage_we_c_FROM : STD_LOGIC; 
  signal XLXI_10_I4_ipage_we_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I4_ipage_we_x : STD_LOGIC; 
  signal XLXI_10_I4_ipage_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I2_valid_c_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_valid_c_FROM : STD_LOGIC; 
  signal XLXI_10_I2_valid_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I2_valid_x : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_3_GROM : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_5_FROM : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I1_nreset_v_0_FROM : STD_LOGIC; 
  signal XLXI_10_I1_nreset_v_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I2_nreset_v_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I3_nreset_v_0_FROM : STD_LOGIC; 
  signal XLXI_10_I3_nreset_v_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I4_nreset_v_0_FROM : STD_LOGIC; 
  signal XLXI_10_I4_nreset_v_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal CHOICE1833_FROM : STD_LOGIC; 
  signal CHOICE1833_GROM : STD_LOGIC; 
  signal XLXI_10_I3_n0037_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0037_GROM : STD_LOGIC; 
  signal XLXI_10_I3_n0048_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0048_GROM : STD_LOGIC; 
  signal XLXI_10_I3_n0053_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0053_GROM : STD_LOGIC; 
  signal XLXI_10_I3_n0055_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0055_GROM : STD_LOGIC; 
  signal CTRL_DATA_OUT_3_OFF_RST : STD_LOGIC; 
  signal XLXI_10_I3_n0062_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0062_GROM : STD_LOGIC; 
  signal CHOICE1309_FROM : STD_LOGIC; 
  signal CHOICE1309_GROM : STD_LOGIC; 
  signal CHOICE1613_FROM : STD_LOGIC; 
  signal CHOICE1613_GROM : STD_LOGIC; 
  signal N23887_FROM : STD_LOGIC; 
  signal N23887_GROM : STD_LOGIC; 
  signal XLXI_10_I2_data_is_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal N23485_FROM : STD_LOGIC; 
  signal N23485_GROM : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_7_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0010_7_19_O : STD_LOGIC; 
  signal N23731_FROM : STD_LOGIC; 
  signal N23731_GROM : STD_LOGIC; 
  signal CHOICE2000_FROM : STD_LOGIC; 
  signal CHOICE2000_GROM : STD_LOGIC; 
  signal XLXI_2_ctrl_data_c_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal nRE_CPU_OBUF_FROM : STD_LOGIC; 
  signal nRE_CPU_OBUF_GROM : STD_LOGIC; 
  signal N22760_FROM : STD_LOGIC; 
  signal N22760_GROM : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_0_FROM : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal N23403_FROM : STD_LOGIC; 
  signal N23403_GROM : STD_LOGIC; 
  signal CHOICE1591_FROM : STD_LOGIC; 
  signal CHOICE1591_GROM : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_1_FROM : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_0_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0010_0_19_O : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_2_FROM : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_1_FROM : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal N23481_FROM : STD_LOGIC; 
  signal N23481_GROM : STD_LOGIC; 
  signal N23591_FROM : STD_LOGIC; 
  signal N23591_GROM : STD_LOGIC; 
  signal N23863_FROM : STD_LOGIC; 
  signal N23863_GROM : STD_LOGIC; 
  signal N23479_FROM : STD_LOGIC; 
  signal N23479_GROM : STD_LOGIC; 
  signal N23727_FROM : STD_LOGIC; 
  signal N23727_GROM : STD_LOGIC; 
  signal N21808_FROM : STD_LOGIC; 
  signal N21808_GROM : STD_LOGIC; 
  signal N23589_FROM : STD_LOGIC; 
  signal N23589_GROM : STD_LOGIC; 
  signal CHOICE1745_FROM : STD_LOGIC; 
  signal CHOICE1745_GROM : STD_LOGIC; 
  signal CHOICE1685_FROM : STD_LOGIC; 
  signal CHOICE1685_GROM : STD_LOGIC; 
  signal CHOICE1700_FROM : STD_LOGIC; 
  signal CHOICE1700_GROM : STD_LOGIC; 
  signal XLXI_10_I1_nreset_v_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I1_nreset_v_1_LOGIC_ONE : STD_LOGIC; 
  signal CHOICE1730_GROM : STD_LOGIC; 
  signal XLXI_3_n0025_GROM : STD_LOGIC; 
  signal XLXI_10_I2_nreset_v_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I2_nreset_v_1_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_3_FROM : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal N23563_GROM : STD_LOGIC; 
  signal XLXI_10_I3_nreset_v_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I3_nreset_v_1_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_10_I4_nreset_v_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I4_nreset_v_1_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_2_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_high_2_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_high_0_FFX_RST : STD_LOGIC; 
  signal XLXI_3_pwm_high_6_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_high_2_FFX_RST : STD_LOGIC; 
  signal XLXI_3_pwm_high_4_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_c_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_7_FFY_RST : STD_LOGIC; 
  signal XLXI_2_ctrl_data_c_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_4_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_5_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_3_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_3_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_6_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_5_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_5_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_7_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_pc_7_FFY_RST : STD_LOGIC; 
  signal XLXI_2_pwm_data_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_2_pwm_data_c_3_FFY_RST : STD_LOGIC; 
  signal XLXI_2_pwm_data_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_2_pwm_data_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_3_pwm_high_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_3_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_4_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_5_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_6_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_pc_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_pc_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_5_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_2_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_6_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_7_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_low_5_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_high_4_FFX_RST : STD_LOGIC; 
  signal XLXI_3_pwm_high_6_FFX_RST : STD_LOGIC; 
  signal XLXI_3_pwm_period_1_FFX_RST : STD_LOGIC; 
  signal XLXI_3_pwm_period_3_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_period_3_FFX_RST : STD_LOGIC; 
  signal XLXI_3_pwm_period_7_FFX_RST : STD_LOGIC; 
  signal XLXI_3_pwm_period_5_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_period_5_FFX_RST : STD_LOGIC; 
  signal XLXI_3_pwm_period_7_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_0_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_period_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_7_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_4_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_2_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_pc_2_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_pc_3_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_pc_4_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_pc_5_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_pc_6_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I4_nreset_v_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_3_FFY_RST : STD_LOGIC; 
  signal XLXI_2_mux_c_0_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_7_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_7_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_2_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_3_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_4_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_3_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_2_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_skip_c_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_nreset_v_1_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_low_1_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I4_ipage_we_c_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_low_3_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I4_ipage_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I4_ipage_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_data_is_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_data_is_c_3_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_data_is_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I2_data_is_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_3_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_5_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_nreset_v_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_5_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I2_nreset_v_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I3_nreset_v_0_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_count_1_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_count_3_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_count_1_FFX_RST : STD_LOGIC; 
  signal XLXI_3_pwm_low_1_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_count_3_FFX_RST : STD_LOGIC; 
  signal XLXI_3_pwm_count_5_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_count_5_FFX_RST : STD_LOGIC; 
  signal XLXI_3_pwm_count_7_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_count_7_FFX_RST : STD_LOGIC; 
  signal XLXI_3_pwm_low_7_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_low_5_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_0_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_low_7_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I5_ndwe_c_FFY_SET : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_2_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_nreset_v_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_3_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I3_nreset_v_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I4_nreset_v_1_FFY_RST : STD_LOGIC; 
  signal CLK_BUFGP_BUFG_CE : STD_LOGIC; 
  signal PWR_VCC_0_FROM : STD_LOGIC; 
  signal PWR_VCC_0_GROM : STD_LOGIC; 
  signal PWR_VCC_1_FROM : STD_LOGIC; 
  signal PWR_GND_0_GROM : STD_LOGIC; 
  signal PWR_GND_1_GROM : STD_LOGIC; 
  signal PWR_GND_2_GROM : STD_LOGIC; 
  signal VCC : STD_LOGIC; 
  signal GND : STD_LOGIC; 
  signal XLXI_2_ctrl_data_c : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal RAM_DATA_OUT : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXN_8 : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal XLXI_10_I2_TD_c : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_10_I2_TC_c : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal XLXI_10_I3_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_10_I4_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_3_pwm_low : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_3_pwm_period : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_3_pwm_count : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_3_pwm_high : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_10_I3_n0059 : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal XLXI_10_I3_n0064 : STD_LOGIC_VECTOR ( 3 downto 1 ); 
  signal XLXI_10_I3_n0058 : STD_LOGIC_VECTOR ( 4 downto 4 ); 
  signal XLXI_10_I1_pc : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_10_I1_n0013 : STD_LOGIC_VECTOR ( 7 downto 1 ); 
  signal XLXI_3_n0011 : STD_LOGIC_VECTOR ( 6 downto 0 ); 
  signal XLXI_2_pwm_data_c : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_3_n0013 : STD_LOGIC_VECTOR ( 7 downto 1 ); 
  signal XLXI_10_I2_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_10_pc_mux : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal XLXI_10_I3_data_x : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_10_I2_data_is_c : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_2_mux_c : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_10_I5_daddr_c : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal XLXI_10_adaddr_out : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal XLXI_10_I4_ipage_c : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_10_I1_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_3_n0005 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_10_I2_TC_x : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal XLXI_3_n0006 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_10_I4_n0030 : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_10_I1_n0008 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_10_I2_n0028 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_10_I3_n0036 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_10_I4_n0031 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_10_I2_TD_x : STD_LOGIC_VECTOR ( 3 downto 0 ); 
begin
  CPU_IADDR_0_OBUF_5 : X_TRI
    port map (
      I => CPU_IADDR_0_OUTMUX,
      CTL => CPU_IADDR_0_ENABLE,
      O => CPU_IADDR(0)
    );
  CPU_IADDR_0_ENABLEINV : X_INV
    port map (
      I => CPU_IADDR_0_TORGTS,
      O => CPU_IADDR_0_ENABLE
    );
  CPU_IADDR_0_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_IADDR_0_TORGTS
    );
  CPU_IADDR_0_OUTMUX_6 : X_BUF
    port map (
      I => CPU_IADDR_0_OBUF,
      O => CPU_IADDR_0_OUTMUX
    );
  CPU_IADDR_1_OBUF_7 : X_TRI
    port map (
      I => CPU_IADDR_1_OUTMUX,
      CTL => CPU_IADDR_1_ENABLE,
      O => CPU_IADDR(1)
    );
  CPU_IADDR_1_ENABLEINV : X_INV
    port map (
      I => CPU_IADDR_1_TORGTS,
      O => CPU_IADDR_1_ENABLE
    );
  CPU_IADDR_1_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_IADDR_1_TORGTS
    );
  CPU_IADDR_1_OUTMUX_8 : X_BUF
    port map (
      I => CPU_IADDR_1_OBUF,
      O => CPU_IADDR_1_OUTMUX
    );
  CPU_IADDR_2_OBUF_9 : X_TRI
    port map (
      I => CPU_IADDR_2_OUTMUX,
      CTL => CPU_IADDR_2_ENABLE,
      O => CPU_IADDR(2)
    );
  CPU_IADDR_2_ENABLEINV : X_INV
    port map (
      I => CPU_IADDR_2_TORGTS,
      O => CPU_IADDR_2_ENABLE
    );
  CPU_IADDR_2_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_IADDR_2_TORGTS
    );
  CPU_IADDR_2_OUTMUX_10 : X_BUF
    port map (
      I => CPU_IADDR_2_OBUF,
      O => CPU_IADDR_2_OUTMUX
    );
  CPU_IADDR_3_OBUF_11 : X_TRI
    port map (
      I => CPU_IADDR_3_OUTMUX,
      CTL => CPU_IADDR_3_ENABLE,
      O => CPU_IADDR(3)
    );
  CPU_IADDR_3_ENABLEINV : X_INV
    port map (
      I => CPU_IADDR_3_TORGTS,
      O => CPU_IADDR_3_ENABLE
    );
  CPU_IADDR_3_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_IADDR_3_TORGTS
    );
  CPU_IADDR_3_OUTMUX_12 : X_BUF
    port map (
      I => CPU_IADDR_3_OBUF,
      O => CPU_IADDR_3_OUTMUX
    );
  CPU_IADDR_4_OBUF_13 : X_TRI
    port map (
      I => CPU_IADDR_4_OUTMUX,
      CTL => CPU_IADDR_4_ENABLE,
      O => CPU_IADDR(4)
    );
  CPU_IADDR_4_ENABLEINV : X_INV
    port map (
      I => CPU_IADDR_4_TORGTS,
      O => CPU_IADDR_4_ENABLE
    );
  CPU_IADDR_4_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_IADDR_4_TORGTS
    );
  CPU_IADDR_4_OUTMUX_14 : X_BUF
    port map (
      I => CPU_IADDR_4_OBUF,
      O => CPU_IADDR_4_OUTMUX
    );
  CPU_IADDR_5_OBUF_15 : X_TRI
    port map (
      I => CPU_IADDR_5_OUTMUX,
      CTL => CPU_IADDR_5_ENABLE,
      O => CPU_IADDR(5)
    );
  CPU_IADDR_5_ENABLEINV : X_INV
    port map (
      I => CPU_IADDR_5_TORGTS,
      O => CPU_IADDR_5_ENABLE
    );
  CPU_IADDR_5_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_IADDR_5_TORGTS
    );
  CPU_IADDR_5_OUTMUX_16 : X_BUF
    port map (
      I => CPU_IADDR_5_OBUF,
      O => CPU_IADDR_5_OUTMUX
    );
  CPU_IADDR_6_OBUF_17 : X_TRI
    port map (
      I => CPU_IADDR_6_OUTMUX,
      CTL => CPU_IADDR_6_ENABLE,
      O => CPU_IADDR(6)
    );
  CPU_IADDR_6_ENABLEINV : X_INV
    port map (
      I => CPU_IADDR_6_TORGTS,
      O => CPU_IADDR_6_ENABLE
    );
  CPU_IADDR_6_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_IADDR_6_TORGTS
    );
  CPU_IADDR_6_OUTMUX_18 : X_BUF
    port map (
      I => CPU_IADDR_6_OBUF,
      O => CPU_IADDR_6_OUTMUX
    );
  nWE_CPU_OBUF : X_TRI
    port map (
      I => nWE_CPU_OUTMUX,
      CTL => nWE_CPU_ENABLE,
      O => nWE_CPU
    );
  nWE_CPU_ENABLEINV : X_INV
    port map (
      I => nWE_CPU_TORGTS,
      O => nWE_CPU_ENABLE
    );
  nWE_CPU_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => nWE_CPU_TORGTS
    );
  nWE_CPU_OUTMUX_19 : X_BUF
    port map (
      I => XLXI_10_I5_ndwe_c,
      O => nWE_CPU_OUTMUX
    );
  CPU_IADDR_7_OBUF_20 : X_TRI
    port map (
      I => CPU_IADDR_7_OUTMUX,
      CTL => CPU_IADDR_7_ENABLE,
      O => CPU_IADDR(7)
    );
  CPU_IADDR_7_ENABLEINV : X_INV
    port map (
      I => CPU_IADDR_7_TORGTS,
      O => CPU_IADDR_7_ENABLE
    );
  CPU_IADDR_7_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_IADDR_7_TORGTS
    );
  CPU_IADDR_7_OUTMUX_21 : X_BUF
    port map (
      I => CPU_IADDR_7_OBUF,
      O => CPU_IADDR_7_OUTMUX
    );
  PWM_OUT_OBUF : X_TRI
    port map (
      I => PWM_OUT_OUTMUX,
      CTL => PWM_OUT_ENABLE,
      O => PWM_OUT
    );
  PWM_OUT_ENABLEINV : X_INV
    port map (
      I => PWM_OUT_TORGTS,
      O => PWM_OUT_ENABLE
    );
  PWM_OUT_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => PWM_OUT_TORGTS
    );
  PWM_OUT_OUTMUX_22 : X_BUF
    port map (
      I => XLXI_3_pwm_c,
      O => PWM_OUT_OUTMUX
    );
  CTRL_DATA_IN_0_IMUX : X_BUF
    port map (
      I => CTRL_DATA_IN_0_IBUF_0,
      O => CTRL_DATA_IN_0_IBUF
    );
  CTRL_DATA_IN_0_IBUF_23 : X_BUF
    port map (
      I => CTRL_DATA_IN(0),
      O => CTRL_DATA_IN_0_IBUF_0
    );
  CTRL_DATA_IN_1_IMUX : X_BUF
    port map (
      I => CTRL_DATA_IN_1_IBUF_1,
      O => CTRL_DATA_IN_1_IBUF
    );
  CTRL_DATA_IN_1_IBUF_24 : X_BUF
    port map (
      I => CTRL_DATA_IN(1),
      O => CTRL_DATA_IN_1_IBUF_1
    );
  CTRL_DATA_IN_2_IMUX : X_BUF
    port map (
      I => CTRL_DATA_IN_2_IBUF_2,
      O => CTRL_DATA_IN_2_IBUF
    );
  CTRL_DATA_IN_2_IBUF_25 : X_BUF
    port map (
      I => CTRL_DATA_IN(2),
      O => CTRL_DATA_IN_2_IBUF_2
    );
  CTRL_DATA_IN_3_IMUX : X_BUF
    port map (
      I => CTRL_DATA_IN_3_IBUF_3,
      O => CTRL_DATA_IN_3_IBUF
    );
  CTRL_DATA_IN_3_IBUF_26 : X_BUF
    port map (
      I => CTRL_DATA_IN(3),
      O => CTRL_DATA_IN_3_IBUF_3
    );
  CTRL_DATA_OUT_0_OBUF : X_TRI
    port map (
      I => CTRL_DATA_OUT_0_OUTMUX,
      CTL => CTRL_DATA_OUT_0_ENABLE,
      O => CTRL_DATA_OUT(0)
    );
  CTRL_DATA_OUT_0_ENABLEINV : X_INV
    port map (
      I => CTRL_DATA_OUT_0_TORGTS,
      O => CTRL_DATA_OUT_0_ENABLE
    );
  CTRL_DATA_OUT_0_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CTRL_DATA_OUT_0_TORGTS
    );
  CTRL_DATA_OUT_0_OUTMUX_27 : X_BUF
    port map (
      I => XLXI_2_ctrl_data_c(0),
      O => CTRL_DATA_OUT_0_OUTMUX
    );
  CTRL_DATA_OUT_1_OBUF : X_TRI
    port map (
      I => CTRL_DATA_OUT_1_OUTMUX,
      CTL => CTRL_DATA_OUT_1_ENABLE,
      O => CTRL_DATA_OUT(1)
    );
  CTRL_DATA_OUT_1_ENABLEINV : X_INV
    port map (
      I => CTRL_DATA_OUT_1_TORGTS,
      O => CTRL_DATA_OUT_1_ENABLE
    );
  CTRL_DATA_OUT_1_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CTRL_DATA_OUT_1_TORGTS
    );
  CTRL_DATA_OUT_1_OUTMUX_28 : X_BUF
    port map (
      I => XLXI_2_ctrl_data_c(1),
      O => CTRL_DATA_OUT_1_OUTMUX
    );
  CTRL_DATA_OUT_1_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT_1_OBUF,
      O => CTRL_DATA_OUT_1_OD
    );
  CTRL_DATA_OUT_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => CTRL_DATA_OUT_1_SRMUXNOT
    );
  CPU_DADDR_0_OBUF_29 : X_TRI
    port map (
      I => CPU_DADDR_0_OUTMUX,
      CTL => CPU_DADDR_0_ENABLE,
      O => CPU_DADDR(0)
    );
  CPU_DADDR_0_ENABLEINV : X_INV
    port map (
      I => CPU_DADDR_0_TORGTS,
      O => CPU_DADDR_0_ENABLE
    );
  CPU_DADDR_0_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_DADDR_0_TORGTS
    );
  CPU_DADDR_0_OUTMUX_30 : X_BUF
    port map (
      I => XLXI_10_I5_Mmux_daddr_out_Result_0_1_1,
      O => CPU_DADDR_0_OUTMUX
    );
  CTRL_DATA_OUT_2_OBUF : X_TRI
    port map (
      I => CTRL_DATA_OUT_2_OUTMUX,
      CTL => CTRL_DATA_OUT_2_ENABLE,
      O => CTRL_DATA_OUT(2)
    );
  CTRL_DATA_OUT_2_ENABLEINV : X_INV
    port map (
      I => CTRL_DATA_OUT_2_TORGTS,
      O => CTRL_DATA_OUT_2_ENABLE
    );
  CTRL_DATA_OUT_2_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CTRL_DATA_OUT_2_TORGTS
    );
  CTRL_DATA_OUT_2_OUTMUX_31 : X_BUF
    port map (
      I => XLXI_2_ctrl_data_c(2),
      O => CTRL_DATA_OUT_2_OUTMUX
    );
  CTRL_DATA_OUT_2_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT_2_OBUF,
      O => CTRL_DATA_OUT_2_OD
    );
  CTRL_DATA_OUT_2_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => CTRL_DATA_OUT_2_SRMUXNOT
    );
  CPU_DADDR_1_OBUF_32 : X_TRI
    port map (
      I => CPU_DADDR_1_OUTMUX,
      CTL => CPU_DADDR_1_ENABLE,
      O => CPU_DADDR(1)
    );
  CPU_DADDR_1_ENABLEINV : X_INV
    port map (
      I => CPU_DADDR_1_TORGTS,
      O => CPU_DADDR_1_ENABLE
    );
  CPU_DADDR_1_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_DADDR_1_TORGTS
    );
  CPU_DADDR_1_OUTMUX_33 : X_BUF
    port map (
      I => CPU_DADDR_1_OBUF,
      O => CPU_DADDR_1_OUTMUX
    );
  CTRL_DATA_OUT_3_OBUF : X_TRI
    port map (
      I => CTRL_DATA_OUT_3_OUTMUX,
      CTL => CTRL_DATA_OUT_3_ENABLE,
      O => CTRL_DATA_OUT(3)
    );
  CTRL_DATA_OUT_3_ENABLEINV : X_INV
    port map (
      I => CTRL_DATA_OUT_3_TORGTS,
      O => CTRL_DATA_OUT_3_ENABLE
    );
  CTRL_DATA_OUT_3_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CTRL_DATA_OUT_3_TORGTS
    );
  CTRL_DATA_OUT_3_OUTMUX_34 : X_BUF
    port map (
      I => XLXI_2_ctrl_data_c(3),
      O => CTRL_DATA_OUT_3_OUTMUX
    );
  CTRL_DATA_OUT_3_OMUX : X_BUF
    port map (
      I => CPU_DATA_OUT_3_OBUF,
      O => CTRL_DATA_OUT_3_OD
    );
  CTRL_DATA_OUT_3_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => CTRL_DATA_OUT_3_SRMUXNOT
    );
  CPU_DADDR_2_OBUF_35 : X_TRI
    port map (
      I => CPU_DADDR_2_OUTMUX,
      CTL => CPU_DADDR_2_ENABLE,
      O => CPU_DADDR(2)
    );
  CPU_DADDR_2_ENABLEINV : X_INV
    port map (
      I => CPU_DADDR_2_TORGTS,
      O => CPU_DADDR_2_ENABLE
    );
  CPU_DADDR_2_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_DADDR_2_TORGTS
    );
  CPU_DADDR_2_OUTMUX_36 : X_BUF
    port map (
      I => CPU_DADDR_2_OBUF,
      O => CPU_DADDR_2_OUTMUX
    );
  CPU_DADDR_3_OBUF_37 : X_TRI
    port map (
      I => CPU_DADDR_3_OUTMUX,
      CTL => CPU_DADDR_3_ENABLE,
      O => CPU_DADDR(3)
    );
  CPU_DADDR_3_ENABLEINV : X_INV
    port map (
      I => CPU_DADDR_3_TORGTS,
      O => CPU_DADDR_3_ENABLE
    );
  CPU_DADDR_3_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_DADDR_3_TORGTS
    );
  CPU_DADDR_3_OUTMUX_38 : X_BUF
    port map (
      I => CPU_DADDR_3_OBUF,
      O => CPU_DADDR_3_OUTMUX
    );
  CPU_DADDR_4_OBUF_39 : X_TRI
    port map (
      I => CPU_DADDR_4_OUTMUX,
      CTL => CPU_DADDR_4_ENABLE,
      O => CPU_DADDR(4)
    );
  CPU_DADDR_4_ENABLEINV : X_INV
    port map (
      I => CPU_DADDR_4_TORGTS,
      O => CPU_DADDR_4_ENABLE
    );
  CPU_DADDR_4_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_DADDR_4_TORGTS
    );
  CPU_DADDR_4_OUTMUX_40 : X_BUF
    port map (
      I => CPU_DADDR_4_OBUF,
      O => CPU_DADDR_4_OUTMUX
    );
  CPU_DADDR_5_OBUF_41 : X_TRI
    port map (
      I => CPU_DADDR_5_OUTMUX,
      CTL => CPU_DADDR_5_ENABLE,
      O => CPU_DADDR(5)
    );
  CPU_DADDR_5_ENABLEINV : X_INV
    port map (
      I => CPU_DADDR_5_TORGTS,
      O => CPU_DADDR_5_ENABLE
    );
  CPU_DADDR_5_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_DADDR_5_TORGTS
    );
  CPU_DADDR_5_OUTMUX_42 : X_BUF
    port map (
      I => CPU_DADDR_5_OBUF,
      O => CPU_DADDR_5_OUTMUX
    );
  CPU_DATA_OUT_0_OBUF_43 : X_TRI
    port map (
      I => CPU_DATA_OUT_0_OUTMUX,
      CTL => CPU_DATA_OUT_0_ENABLE,
      O => CPU_DATA_OUT(0)
    );
  CPU_DATA_OUT_0_ENABLEINV : X_INV
    port map (
      I => CPU_DATA_OUT_0_TORGTS,
      O => CPU_DATA_OUT_0_ENABLE
    );
  CPU_DATA_OUT_0_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_DATA_OUT_0_TORGTS
    );
  CPU_DATA_OUT_0_OUTMUX_44 : X_BUF
    port map (
      I => CPU_DATA_OUT_0_OBUF,
      O => CPU_DATA_OUT_0_OUTMUX
    );
  CPU_DATA_OUT_1_OBUF_45 : X_TRI
    port map (
      I => CPU_DATA_OUT_1_OUTMUX,
      CTL => CPU_DATA_OUT_1_ENABLE,
      O => CPU_DATA_OUT(1)
    );
  CPU_DATA_OUT_1_ENABLEINV : X_INV
    port map (
      I => CPU_DATA_OUT_1_TORGTS,
      O => CPU_DATA_OUT_1_ENABLE
    );
  CPU_DATA_OUT_1_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_DATA_OUT_1_TORGTS
    );
  CPU_DATA_OUT_1_OUTMUX_46 : X_BUF
    port map (
      I => CPU_DATA_OUT_1_OBUF,
      O => CPU_DATA_OUT_1_OUTMUX
    );
  CPU_DATA_OUT_2_OBUF_47 : X_TRI
    port map (
      I => CPU_DATA_OUT_2_OUTMUX,
      CTL => CPU_DATA_OUT_2_ENABLE,
      O => CPU_DATA_OUT(2)
    );
  CPU_DATA_OUT_2_ENABLEINV : X_INV
    port map (
      I => CPU_DATA_OUT_2_TORGTS,
      O => CPU_DATA_OUT_2_ENABLE
    );
  CPU_DATA_OUT_2_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_DATA_OUT_2_TORGTS
    );
  CPU_DATA_OUT_2_OUTMUX_48 : X_BUF
    port map (
      I => CPU_DATA_OUT_2_OBUF,
      O => CPU_DATA_OUT_2_OUTMUX
    );
  CPU_DATA_OUT_3_OBUF_49 : X_TRI
    port map (
      I => CPU_DATA_OUT_3_OUTMUX,
      CTL => CPU_DATA_OUT_3_ENABLE,
      O => CPU_DATA_OUT(3)
    );
  CPU_DATA_OUT_3_ENABLEINV : X_INV
    port map (
      I => CPU_DATA_OUT_3_TORGTS,
      O => CPU_DATA_OUT_3_ENABLE
    );
  CPU_DATA_OUT_3_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => CPU_DATA_OUT_3_TORGTS
    );
  CPU_DATA_OUT_3_OUTMUX_50 : X_BUF
    port map (
      I => CPU_DATA_OUT_3_OBUF,
      O => CPU_DATA_OUT_3_OUTMUX
    );
  NRESET_IMUX : X_BUF
    port map (
      I => NRESET_IBUF_4,
      O => NRESET_IBUF
    );
  NRESET_IBUF_51 : X_BUF
    port map (
      I => NRESET,
      O => NRESET_IBUF_4
    );
  nRE_CPU_OBUF_52 : X_TRI
    port map (
      I => nRE_CPU_OUTMUX,
      CTL => nRE_CPU_ENABLE,
      O => nRE_CPU
    );
  nRE_CPU_ENABLEINV : X_INV
    port map (
      I => nRE_CPU_TORGTS,
      O => nRE_CPU_ENABLE
    );
  nRE_CPU_GTS_OR : X_BUF
    port map (
      I => GTS,
      O => nRE_CPU_TORGTS
    );
  nRE_CPU_OUTMUX_53 : X_BUF
    port map (
      I => nRE_CPU_OBUF,
      O => nRE_CPU_OUTMUX
    );
  XLXI_4_B5_LOGIC_ONE_54 : X_ONE
    port map (
      O => XLXI_4_B5_LOGIC_ONE
    );
  XLXI_4_B5_LOGIC_ZERO_55 : X_ZERO
    port map (
      O => XLXI_4_B5_LOGIC_ZERO
    );
  XLXI_4_B5_WEAMUX : X_INV
    port map (
      I => nWR_RAM,
      O => XLXI_4_B5_WEA_INTNOT
    );
  XLXI_4_B5 : X_RAMB4_S4
    generic map(
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
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
      CLK => CLK_BUFGP,
      EN => XLXI_4_B5_LOGIC_ONE,
      RST => XLXI_4_B5_LOGIC_ZERO,
      WE => XLXI_4_B5_WEA_INTNOT,
      GSR => GSR,
      ADDR(9) => GLOBAL_LOGIC0,
      ADDR(8) => GLOBAL_LOGIC0,
      ADDR(7) => GLOBAL_LOGIC0,
      ADDR(6) => GLOBAL_LOGIC0,
      ADDR(5) => GLOBAL_LOGIC0,
      ADDR(4) => GLOBAL_LOGIC0,
      ADDR(3) => CPU_DADDR_3_OBUF,
      ADDR(2) => CPU_DADDR_2_OBUF,
      ADDR(1) => CPU_DADDR_1_OBUF,
      ADDR(0) => XLXI_10_I5_Mmux_daddr_out_Result_0_1_1,
      DI(3) => CPU_DATA_OUT_3_OBUF,
      DI(2) => CPU_DATA_OUT_2_OBUF,
      DI(1) => CPU_DATA_OUT_1_OBUF,
      DI(0) => CPU_DATA_OUT_0_OBUF,
      DO(3) => RAM_DATA_OUT(3),
      DO(2) => RAM_DATA_OUT(2),
      DO(1) => RAM_DATA_OUT(1),
      DO(0) => RAM_DATA_OUT(0)
    );
  XLXI_5_B5_LOGIC_ONE_56 : X_ONE
    port map (
      O => XLXI_5_B5_LOGIC_ONE
    );
  XLXI_5_B5_LOGIC_ZERO_57 : X_ZERO
    port map (
      O => XLXI_5_B5_LOGIC_ZERO
    );
  XLXI_5_B5 : X_RAMB4_S16
    generic map(
      INIT_00 => X"004E0102000800B0002E01020151000A0031002A0031000A000900000031001A",
      INIT_01 => X"000000000000000000000068015800B0008E010200E800B0006E0102007800B0",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"00000000000000C00101001A0141002A0151000A0121000A0131001A0101000A",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"014100AA01C80101001C0030002A0141006A01C80101001C0030001A0141002A",
      INIT_09 => X"006800000031000201C80101001C0030004A014100EA01C80101001C0030003A",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
    port map (
      CLK => CLK_BUFGP,
      EN => XLXI_5_B5_LOGIC_ONE,
      RST => XLXI_5_B5_LOGIC_ZERO,
      WE => XLXI_5_B5_LOGIC_ZERO,
      GSR => GSR,
      ADDR(7) => CPU_IADDR_7_OBUF,
      ADDR(6) => CPU_IADDR_6_OBUF,
      ADDR(5) => CPU_IADDR_5_OBUF,
      ADDR(4) => CPU_IADDR_4_OBUF,
      ADDR(3) => CPU_IADDR_3_OBUF,
      ADDR(2) => CPU_IADDR_2_OBUF,
      ADDR(1) => CPU_IADDR_1_OBUF,
      ADDR(0) => CPU_IADDR_0_OBUF,
      DI(15) => GLOBAL_LOGIC0_2,
      DI(14) => GLOBAL_LOGIC0_2,
      DI(13) => GLOBAL_LOGIC0_2,
      DI(12) => GLOBAL_LOGIC0_2,
      DI(11) => GLOBAL_LOGIC0_2,
      DI(10) => GLOBAL_LOGIC0_2,
      DI(9) => GLOBAL_LOGIC0_2,
      DI(8) => GLOBAL_LOGIC0_2,
      DI(7) => GLOBAL_LOGIC0_2,
      DI(6) => GLOBAL_LOGIC0_2,
      DI(5) => GLOBAL_LOGIC0_2,
      DI(4) => GLOBAL_LOGIC0_2,
      DI(3) => GLOBAL_LOGIC0_2,
      DI(2) => GLOBAL_LOGIC0_2,
      DI(1) => GLOBAL_LOGIC0_2,
      DI(0) => GLOBAL_LOGIC0_2,
      DO(15) => XLXI_5_B5_DOA15,
      DO(14) => XLXI_5_B5_DOA14,
      DO(13) => XLXI_5_B5_DOA13,
      DO(12) => XLXI_5_B5_DOA12,
      DO(11) => XLXI_5_B5_DOA11,
      DO(10) => XLXI_5_B5_DOA10,
      DO(9) => XLXN_8(9),
      DO(8) => XLXN_8(8),
      DO(7) => XLXN_8(7),
      DO(6) => XLXN_8(6),
      DO(5) => XLXN_8(5),
      DO(4) => XLXN_8(4),
      DO(3) => XLXN_8(3),
      DO(2) => XLXN_8(2),
      DO(1) => XLXN_8(1),
      DO(0) => XLXN_8(0)
    );
  XLXI_10_I3_n0035_0_179_SW0 : X_MUX2
    port map (
      IA => N23999,
      IB => N24001,
      SEL => XLXI_10_I2_TD_c(0),
      O => N23723_F5MUX
    );
  XLXI_10_I3_n0035_0_179_SW0_G : X_LUT4
    generic map(
      INIT => X"04A4"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(2),
      ADR1 => XLXI_10_I3_acc_c_0_4,
      ADR2 => XLXI_10_I2_TD_c(1),
      ADR3 => XLXI_10_I3_acc_c_0_0,
      O => N24001
    );
  XLXI_10_I3_n0035_0_179_SW0_F : X_LUT4
    generic map(
      INIT => X"4848"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(2),
      ADR1 => XLXI_10_I3_acc_c_0_1,
      ADR2 => XLXI_10_I2_TD_c(1),
      ADR3 => VCC,
      O => N23999
    );
  N23723_XUSED : X_BUF
    port map (
      I => N23723_F5MUX,
      O => N23723
    );
  XLXI_10_I3_n0035_0_107_SW11 : X_MUX2
    port map (
      IA => N23994,
      IB => N23996,
      SEL => CHOICE1817,
      O => N23411_F5MUX
    );
  XLXI_10_I3_n0035_0_107_SW11_G : X_LUT4
    generic map(
      INIT => X"BE00"
    )
    port map (
      ADR0 => CHOICE1835,
      ADR1 => XLXI_10_I2_TC_c(0),
      ADR2 => XLXI_10_I2_TC_c(1),
      ADR3 => XLXI_10_I3_N8818,
      O => N23996
    );
  XLXI_10_I3_n0035_0_107_SW11_F : X_LUT4
    generic map(
      INIT => X"F200"
    )
    port map (
      ADR0 => XLXI_10_I3_N8655,
      ADR1 => XLXI_10_I2_TD_c(3),
      ADR2 => CHOICE1835,
      ADR3 => XLXI_10_I3_N8818,
      O => N23994
    );
  N23411_XUSED : X_BUF
    port map (
      I => N23411_F5MUX,
      O => N23411
    );
  XLXI_10_I3_n0035_2_109_SW11 : X_MUX2
    port map (
      IA => N23984,
      IB => N23986,
      SEL => CHOICE1918,
      O => N23423_F5MUX
    );
  XLXI_10_I3_n0035_2_109_SW11_G : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_10_I3_nreset_v(0),
      ADR1 => XLXI_10_I2_TC_c(2),
      ADR2 => XLXI_10_I3_nreset_v(1),
      ADR3 => XLXI_10_I2_valid_c,
      O => N23986
    );
  XLXI_10_I3_n0035_2_109_SW11_F : X_LUT4
    generic map(
      INIT => X"3200"
    )
    port map (
      ADR0 => XLXI_10_I3_N8655,
      ADR1 => XLXI_10_I2_TD_c(3),
      ADR2 => CHOICE1938,
      ADR3 => XLXI_10_I3_N8818,
      O => N23984
    );
  N23423_XUSED : X_BUF
    port map (
      I => N23423_F5MUX,
      O => N23423
    );
  XLXI_3_Ker66591_SW61 : X_MUX2
    port map (
      IA => N23974,
      IB => N23976,
      SEL => N23355,
      O => N23497_F5MUX
    );
  XLXI_3_Ker66591_SW61_G : X_LUT4
    generic map(
      INIT => X"9555"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(0),
      ADR1 => NRESET_IBUF,
      ADR2 => XLXI_10_I3_acc_c_0_0,
      ADR3 => XLXI_10_I4_nreset_v(1),
      O => N23976
    );
  XLXI_3_Ker66591_SW61_F : X_LUT4
    generic map(
      INIT => X"AC53"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(0),
      ADR1 => XLXI_3_pwm_period(0),
      ADR2 => XLXI_10_I5_ndwe_c,
      ADR3 => CPU_DATA_OUT_0_OBUF,
      O => N23974
    );
  N23497_XUSED : X_BUF
    port map (
      I => N23497_F5MUX,
      O => N23497
    );
  XLXI_10_I3_n0035_4_60_SW11 : X_MUX2
    port map (
      IA => N23979,
      IB => N23981,
      SEL => CHOICE1852,
      O => N23405_F5MUX
    );
  XLXI_10_I3_n0035_4_60_SW11_G : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_10_I2_valid_c,
      ADR1 => XLXI_10_I2_TC_c(2),
      ADR2 => XLXI_10_I3_nreset_v(1),
      ADR3 => XLXI_10_I3_nreset_v(0),
      O => N23981
    );
  XLXI_10_I3_n0035_4_60_SW11_F : X_LUT4
    generic map(
      INIT => X"5040"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(3),
      ADR1 => CHOICE1864,
      ADR2 => XLXI_10_I3_N8818,
      ADR3 => XLXI_10_I3_N8655,
      O => N23979
    );
  N23405_XUSED : X_BUF
    port map (
      I => N23405_F5MUX,
      O => N23405
    );
  XLXI_10_I3_n0035_1_109_SW11 : X_MUX2
    port map (
      IA => N23969,
      IB => N23971,
      SEL => CHOICE1874,
      O => N23429_F5MUX
    );
  XLXI_10_I3_n0035_1_109_SW11_G : X_LUT4
    generic map(
      INIT => X"4000"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(2),
      ADR1 => XLXI_10_I2_valid_c,
      ADR2 => XLXI_10_I3_nreset_v(1),
      ADR3 => XLXI_10_I3_nreset_v(0),
      O => N23971
    );
  XLXI_10_I3_n0035_1_109_SW11_F : X_LUT4
    generic map(
      INIT => X"2220"
    )
    port map (
      ADR0 => XLXI_10_I3_N8818,
      ADR1 => XLXI_10_I2_TD_c(3),
      ADR2 => CHOICE1894,
      ADR3 => XLXI_10_I3_N8655,
      O => N23969
    );
  N23429_XUSED : X_BUF
    port map (
      I => N23429_F5MUX,
      O => N23429
    );
  XLXI_10_I3_n0035_3_109_SW11 : X_MUX2
    port map (
      IA => N23989,
      IB => N23991,
      SEL => CHOICE2006,
      O => N23417_F5MUX
    );
  XLXI_10_I3_n0035_3_109_SW11_G : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_10_I3_nreset_v(1),
      ADR1 => XLXI_10_I2_TC_c(2),
      ADR2 => XLXI_10_I3_nreset_v(0),
      ADR3 => XLXI_10_I2_valid_c,
      O => N23991
    );
  XLXI_10_I3_n0035_3_109_SW11_F : X_LUT4
    generic map(
      INIT => X"4440"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(3),
      ADR1 => XLXI_10_I3_N8818,
      ADR2 => XLXI_10_I3_N8655,
      ADR3 => CHOICE2026,
      O => N23989
    );
  N23417_XUSED : X_BUF
    port map (
      I => N23417_F5MUX,
      O => N23417
    );
  XLXI_3_Mcompar_n0017_inst_cy_1_LOGIC_ZERO_58 : X_ZERO
    port map (
      O => XLXI_3_Mcompar_n0017_inst_cy_1_LOGIC_ZERO
    );
  XLXI_3_Mcompar_n0017_inst_cy_0_59 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(0),
      IB => XLXI_3_Mcompar_n0017_inst_cy_1_LOGIC_ZERO,
      SEL => XLXI_3_Mcompar_n0017_inst_lut2_0,
      O => XLXI_3_Mcompar_n0017_inst_cy_0
    );
  XLXI_3_Mcompar_n0017_inst_lut2_01 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(0),
      ADR1 => XLXI_3_pwm_count(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0017_inst_lut2_0
    );
  XLXI_3_Mcompar_n0017_inst_lut2_11 : X_LUT4
    generic map(
      INIT => X"A5A5"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(1),
      ADR1 => VCC,
      ADR2 => XLXI_3_pwm_count(1),
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0017_inst_lut2_1
    );
  XLXI_3_Mcompar_n0017_inst_cy_1_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0017_inst_cy_1_CYMUXG,
      O => XLXI_3_Mcompar_n0017_inst_cy_1
    );
  XLXI_3_Mcompar_n0017_inst_cy_1_60 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(1),
      IB => XLXI_3_Mcompar_n0017_inst_cy_0,
      SEL => XLXI_3_Mcompar_n0017_inst_lut2_1,
      O => XLXI_3_Mcompar_n0017_inst_cy_1_CYMUXG
    );
  XLXI_3_Mcompar_n0017_inst_cy_2_61 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(2),
      IB => XLXI_3_Mcompar_n0017_inst_cy_3_CYINIT,
      SEL => XLXI_3_Mcompar_n0017_inst_lut2_2,
      O => XLXI_3_Mcompar_n0017_inst_cy_2
    );
  XLXI_3_Mcompar_n0017_inst_lut2_21 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(2),
      ADR1 => XLXI_3_pwm_count(2),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0017_inst_lut2_2
    );
  XLXI_3_Mcompar_n0017_inst_lut2_31 : X_LUT4
    generic map(
      INIT => X"A5A5"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(3),
      ADR1 => VCC,
      ADR2 => XLXI_3_pwm_count(3),
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0017_inst_lut2_3
    );
  XLXI_3_Mcompar_n0017_inst_cy_3_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0017_inst_cy_3_CYMUXG,
      O => XLXI_3_Mcompar_n0017_inst_cy_3
    );
  XLXI_3_Mcompar_n0017_inst_cy_3_62 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(3),
      IB => XLXI_3_Mcompar_n0017_inst_cy_2,
      SEL => XLXI_3_Mcompar_n0017_inst_lut2_3,
      O => XLXI_3_Mcompar_n0017_inst_cy_3_CYMUXG
    );
  XLXI_3_Mcompar_n0017_inst_cy_3_CYINIT_63 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0017_inst_cy_1,
      O => XLXI_3_Mcompar_n0017_inst_cy_3_CYINIT
    );
  XLXI_3_Mcompar_n0017_inst_cy_4_64 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(4),
      IB => XLXI_3_Mcompar_n0017_inst_cy_5_CYINIT,
      SEL => XLXI_3_Mcompar_n0017_inst_lut2_4,
      O => XLXI_3_Mcompar_n0017_inst_cy_4
    );
  XLXI_3_Mcompar_n0017_inst_lut2_41 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(4),
      ADR1 => XLXI_3_pwm_count(4),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0017_inst_lut2_4
    );
  XLXI_3_Mcompar_n0017_inst_lut2_51 : X_LUT4
    generic map(
      INIT => X"AA55"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(5),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_3_pwm_count(5),
      O => XLXI_3_Mcompar_n0017_inst_lut2_5
    );
  XLXI_3_Mcompar_n0017_inst_cy_5_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0017_inst_cy_5_CYMUXG,
      O => XLXI_3_Mcompar_n0017_inst_cy_5
    );
  XLXI_3_Mcompar_n0017_inst_cy_5_65 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(5),
      IB => XLXI_3_Mcompar_n0017_inst_cy_4,
      SEL => XLXI_3_Mcompar_n0017_inst_lut2_5,
      O => XLXI_3_Mcompar_n0017_inst_cy_5_CYMUXG
    );
  XLXI_3_Mcompar_n0017_inst_cy_5_CYINIT_66 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0017_inst_cy_3,
      O => XLXI_3_Mcompar_n0017_inst_cy_5_CYINIT
    );
  XLXI_3_Mcompar_n0017_inst_cy_6_67 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(6),
      IB => XLXI_3_n0017_CYINIT,
      SEL => XLXI_3_Mcompar_n0017_inst_lut2_6,
      O => XLXI_3_Mcompar_n0017_inst_cy_6
    );
  XLXI_3_Mcompar_n0017_inst_lut2_61 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(6),
      ADR1 => XLXI_3_pwm_count(6),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0017_inst_lut2_6
    );
  XLXI_3_Mcompar_n0017_inst_lut2_71 : X_LUT4
    generic map(
      INIT => X"A5A5"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(7),
      ADR1 => VCC,
      ADR2 => XLXI_3_pwm_count(7),
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0017_inst_lut2_7
    );
  XLXI_3_n0017_COUTUSED : X_BUF
    port map (
      I => XLXI_3_n0017_CYMUXG,
      O => XLXI_3_n0017
    );
  XLXI_3_Mcompar_n0017_inst_cy_7 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(7),
      IB => XLXI_3_Mcompar_n0017_inst_cy_6,
      SEL => XLXI_3_Mcompar_n0017_inst_lut2_7,
      O => XLXI_3_n0017_CYMUXG
    );
  XLXI_3_n0017_CYINIT_68 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0017_inst_cy_5,
      O => XLXI_3_n0017_CYINIT
    );
  XLXI_3_Mcompar_n0018_inst_cy_1_LOGIC_ZERO_69 : X_ZERO
    port map (
      O => XLXI_3_Mcompar_n0018_inst_cy_1_LOGIC_ZERO
    );
  XLXI_3_Mcompar_n0018_inst_cy_0_70 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(0),
      IB => XLXI_3_Mcompar_n0018_inst_cy_1_LOGIC_ZERO,
      SEL => XLXI_3_Mcompar_n0018_inst_lut2_0,
      O => XLXI_3_Mcompar_n0018_inst_cy_0
    );
  XLXI_3_Mcompar_n0018_inst_lut2_01 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(0),
      ADR1 => XLXI_3_pwm_count(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0018_inst_lut2_0
    );
  XLXI_3_Mcompar_n0018_inst_lut2_11 : X_LUT4
    generic map(
      INIT => X"AA55"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(1),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_3_pwm_count(1),
      O => XLXI_3_Mcompar_n0018_inst_lut2_1
    );
  XLXI_3_Mcompar_n0018_inst_cy_1_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0018_inst_cy_1_CYMUXG,
      O => XLXI_3_Mcompar_n0018_inst_cy_1
    );
  XLXI_3_Mcompar_n0018_inst_cy_1_71 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(1),
      IB => XLXI_3_Mcompar_n0018_inst_cy_0,
      SEL => XLXI_3_Mcompar_n0018_inst_lut2_1,
      O => XLXI_3_Mcompar_n0018_inst_cy_1_CYMUXG
    );
  XLXI_3_Mcompar_n0018_inst_cy_2_72 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(2),
      IB => XLXI_3_Mcompar_n0018_inst_cy_3_CYINIT,
      SEL => XLXI_3_Mcompar_n0018_inst_lut2_2,
      O => XLXI_3_Mcompar_n0018_inst_cy_2
    );
  XLXI_3_Mcompar_n0018_inst_lut2_21 : X_LUT4
    generic map(
      INIT => X"AA55"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(2),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_3_pwm_count(2),
      O => XLXI_3_Mcompar_n0018_inst_lut2_2
    );
  XLXI_3_Mcompar_n0018_inst_lut2_31 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(3),
      ADR1 => XLXI_3_pwm_count(3),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0018_inst_lut2_3
    );
  XLXI_3_Mcompar_n0018_inst_cy_3_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0018_inst_cy_3_CYMUXG,
      O => XLXI_3_Mcompar_n0018_inst_cy_3
    );
  XLXI_3_Mcompar_n0018_inst_cy_3_73 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(3),
      IB => XLXI_3_Mcompar_n0018_inst_cy_2,
      SEL => XLXI_3_Mcompar_n0018_inst_lut2_3,
      O => XLXI_3_Mcompar_n0018_inst_cy_3_CYMUXG
    );
  XLXI_3_Mcompar_n0018_inst_cy_3_CYINIT_74 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0018_inst_cy_1,
      O => XLXI_3_Mcompar_n0018_inst_cy_3_CYINIT
    );
  XLXI_3_Mcompar_n0018_inst_cy_4_75 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(4),
      IB => XLXI_3_Mcompar_n0018_inst_cy_5_CYINIT,
      SEL => XLXI_3_Mcompar_n0018_inst_lut2_4,
      O => XLXI_3_Mcompar_n0018_inst_cy_4
    );
  XLXI_3_Mcompar_n0018_inst_lut2_41 : X_LUT4
    generic map(
      INIT => X"AA55"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(4),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_3_pwm_count(4),
      O => XLXI_3_Mcompar_n0018_inst_lut2_4
    );
  XLXI_3_Mcompar_n0018_inst_lut2_51 : X_LUT4
    generic map(
      INIT => X"A5A5"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(5),
      ADR1 => VCC,
      ADR2 => XLXI_3_pwm_count(5),
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0018_inst_lut2_5
    );
  XLXI_3_Mcompar_n0018_inst_cy_5_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0018_inst_cy_5_CYMUXG,
      O => XLXI_3_Mcompar_n0018_inst_cy_5
    );
  XLXI_3_Mcompar_n0018_inst_cy_5_76 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(5),
      IB => XLXI_3_Mcompar_n0018_inst_cy_4,
      SEL => XLXI_3_Mcompar_n0018_inst_lut2_5,
      O => XLXI_3_Mcompar_n0018_inst_cy_5_CYMUXG
    );
  XLXI_3_Mcompar_n0018_inst_cy_5_CYINIT_77 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0018_inst_cy_3,
      O => XLXI_3_Mcompar_n0018_inst_cy_5_CYINIT
    );
  XLXI_3_Mcompar_n0018_inst_cy_6_78 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(6),
      IB => XLXI_3_n0018_CYINIT,
      SEL => XLXI_3_Mcompar_n0018_inst_lut2_6,
      O => XLXI_3_Mcompar_n0018_inst_cy_6
    );
  XLXI_3_Mcompar_n0018_inst_lut2_61 : X_LUT4
    generic map(
      INIT => X"A5A5"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(6),
      ADR1 => VCC,
      ADR2 => XLXI_3_pwm_count(6),
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0018_inst_lut2_6
    );
  XLXI_3_Mcompar_n0018_inst_lut2_71 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(7),
      ADR1 => XLXI_3_pwm_count(7),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0018_inst_lut2_7
    );
  XLXI_3_n0018_COUTUSED : X_BUF
    port map (
      I => XLXI_3_n0018_CYMUXG,
      O => XLXI_3_n0018
    );
  XLXI_3_Mcompar_n0018_inst_cy_7 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(7),
      IB => XLXI_3_Mcompar_n0018_inst_cy_6,
      SEL => XLXI_3_Mcompar_n0018_inst_lut2_7,
      O => XLXI_3_n0018_CYMUXG
    );
  XLXI_3_n0018_CYINIT_79 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0018_inst_cy_5,
      O => XLXI_3_n0018_CYINIT
    );
  XLXI_10_I3_n0059_0_LOGIC_ONE_80 : X_ONE
    port map (
      O => XLXI_10_I3_n0059_0_LOGIC_ONE
    );
  XLXI_10_I3_Msub_n0059_inst_cy_28_81 : X_MUX2
    port map (
      IA => XLXI_10_I3_acc_c_0_0,
      IB => XLXI_10_I3_n0059_0_CYINIT,
      SEL => XLXI_10_I3_n0059_0_FROM,
      O => XLXI_10_I3_Msub_n0059_inst_cy_28
    );
  XLXI_10_I3_Msub_n0059_inst_sum_20 : X_XOR2
    port map (
      I0 => XLXI_10_I3_n0059_0_CYINIT,
      I1 => XLXI_10_I3_n0059_0_FROM,
      O => XLXI_10_I3_n0059_0_XORF
    );
  XLXI_10_I3_n0059_0_F : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => VCC,
      ADR2 => XLXI_10_I3_Msub_n0059_inst_lut2_28,
      ADR3 => VCC,
      O => XLXI_10_I3_n0059_0_FROM
    );
  XLXI_10_I3_n0059_0_G : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_1,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_10_I3_Msub_n0059_inst_lut2_29,
      O => XLXI_10_I3_n0059_0_GROM
    );
  XLXI_10_I3_n0059_0_COUTUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0059_0_CYMUXG,
      O => XLXI_10_I3_Msub_n0059_inst_cy_29
    );
  XLXI_10_I3_n0059_0_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0059_0_XORF,
      O => XLXI_10_I3_n0059(0)
    );
  XLXI_10_I3_n0059_0_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0059_0_XORG,
      O => XLXI_10_I3_n0059(1)
    );
  XLXI_10_I3_Msub_n0059_inst_cy_29_82 : X_MUX2
    port map (
      IA => XLXI_10_I3_acc_c_0_1,
      IB => XLXI_10_I3_Msub_n0059_inst_cy_28,
      SEL => XLXI_10_I3_n0059_0_GROM,
      O => XLXI_10_I3_n0059_0_CYMUXG
    );
  XLXI_10_I3_Msub_n0059_inst_sum_21 : X_XOR2
    port map (
      I0 => XLXI_10_I3_Msub_n0059_inst_cy_28,
      I1 => XLXI_10_I3_n0059_0_GROM,
      O => XLXI_10_I3_n0059_0_XORG
    );
  XLXI_10_I3_n0059_0_CYINIT_83 : X_BUF
    port map (
      I => XLXI_10_I3_n0059_0_LOGIC_ONE,
      O => XLXI_10_I3_n0059_0_CYINIT
    );
  XLXI_10_I3_Msub_n0059_inst_cy_30_84 : X_MUX2
    port map (
      IA => XLXI_10_I3_acc_c_0_2,
      IB => XLXI_10_I3_n0059_2_CYINIT,
      SEL => XLXI_10_I3_n0059_2_FROM,
      O => XLXI_10_I3_Msub_n0059_inst_cy_30
    );
  XLXI_10_I3_Msub_n0059_inst_sum_22 : X_XOR2
    port map (
      I0 => XLXI_10_I3_n0059_2_CYINIT,
      I1 => XLXI_10_I3_n0059_2_FROM,
      O => XLXI_10_I3_n0059_2_XORF
    );
  XLXI_10_I3_n0059_2_F : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_2,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_10_I3_Msub_n0059_inst_lut2_30,
      O => XLXI_10_I3_n0059_2_FROM
    );
  XLXI_10_I3_n0059_2_G : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_3,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_10_I3_Msub_n0059_inst_lut2_31,
      O => XLXI_10_I3_n0059_2_GROM
    );
  XLXI_10_I3_n0059_2_COUTUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0059_2_CYMUXG,
      O => XLXI_10_I3_Msub_n0059_inst_cy_31
    );
  XLXI_10_I3_n0059_2_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0059_2_XORF,
      O => XLXI_10_I3_n0059(2)
    );
  XLXI_10_I3_n0059_2_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0059_2_XORG,
      O => XLXI_10_I3_n0059(3)
    );
  XLXI_10_I3_Msub_n0059_inst_cy_31_85 : X_MUX2
    port map (
      IA => XLXI_10_I3_acc_c_0_3,
      IB => XLXI_10_I3_Msub_n0059_inst_cy_30,
      SEL => XLXI_10_I3_n0059_2_GROM,
      O => XLXI_10_I3_n0059_2_CYMUXG
    );
  XLXI_10_I3_Msub_n0059_inst_sum_23 : X_XOR2
    port map (
      I0 => XLXI_10_I3_Msub_n0059_inst_cy_30,
      I1 => XLXI_10_I3_n0059_2_GROM,
      O => XLXI_10_I3_n0059_2_XORG
    );
  XLXI_10_I3_n0059_2_CYINIT_86 : X_BUF
    port map (
      I => XLXI_10_I3_Msub_n0059_inst_cy_29,
      O => XLXI_10_I3_n0059_2_CYINIT
    );
  XLXI_10_I3_Msub_n0059_inst_sum_24 : X_XOR2
    port map (
      I0 => XLXI_10_I3_n0059_4_CYINIT,
      I1 => XLXI_10_I3_n0059_4_FROM,
      O => XLXI_10_I3_n0059_4_XORF
    );
  XLXI_10_I3_n0059_4_F : X_LUT4
    generic map(
      INIT => X"FFFF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I3_n0059_4_FROM
    );
  XLXI_10_I3_n0059_4_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0059_4_XORF,
      O => XLXI_10_I3_n0059(4)
    );
  XLXI_10_I3_n0059_4_CYINIT_87 : X_BUF
    port map (
      I => XLXI_10_I3_Msub_n0059_inst_cy_31,
      O => XLXI_10_I3_n0059_4_CYINIT
    );
  XLXI_10_I3_n0064_1_LOGIC_ZERO_88 : X_ZERO
    port map (
      O => XLXI_10_I3_n0064_1_LOGIC_ZERO
    );
  XLXI_10_I3_Madd_n0064_inst_cy_24_89 : X_MUX2
    port map (
      IA => XLXI_10_I3_acc_c_0_0,
      IB => XLXI_10_I3_n0064_1_LOGIC_ZERO,
      SEL => XLXI_10_I3_Madd_n0064_inst_lut2_24_rt,
      O => XLXI_10_I3_Madd_n0064_inst_cy_24
    );
  XLXI_10_I3_Madd_n0064_inst_lut2_24_rt_90 : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => VCC,
      ADR2 => XLXI_10_I3_Madd_n0064_inst_lut2_24,
      ADR3 => VCC,
      O => XLXI_10_I3_Madd_n0064_inst_lut2_24_rt
    );
  XLXI_10_I3_n0064_1_G : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_1,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_10_I3_Madd_n0064_inst_lut2_25,
      O => XLXI_10_I3_n0064_1_GROM
    );
  XLXI_10_I3_n0064_1_COUTUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0064_1_CYMUXG,
      O => XLXI_10_I3_Madd_n0064_inst_cy_25
    );
  XLXI_10_I3_n0064_1_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0064_1_XORG,
      O => XLXI_10_I3_n0064(1)
    );
  XLXI_10_I3_Madd_n0064_inst_cy_25_91 : X_MUX2
    port map (
      IA => XLXI_10_I3_acc_c_0_1,
      IB => XLXI_10_I3_Madd_n0064_inst_cy_24,
      SEL => XLXI_10_I3_n0064_1_GROM,
      O => XLXI_10_I3_n0064_1_CYMUXG
    );
  XLXI_10_I3_Madd_n0064_inst_sum_17 : X_XOR2
    port map (
      I0 => XLXI_10_I3_Madd_n0064_inst_cy_24,
      I1 => XLXI_10_I3_n0064_1_GROM,
      O => XLXI_10_I3_n0064_1_XORG
    );
  XLXI_10_I3_Madd_n0064_inst_cy_26_92 : X_MUX2
    port map (
      IA => XLXI_10_I3_acc_c_0_2,
      IB => XLXI_10_I3_n0064_2_CYINIT,
      SEL => XLXI_10_I3_n0064_2_FROM,
      O => XLXI_10_I3_Madd_n0064_inst_cy_26
    );
  XLXI_10_I3_Madd_n0064_inst_sum_18 : X_XOR2
    port map (
      I0 => XLXI_10_I3_n0064_2_CYINIT,
      I1 => XLXI_10_I3_n0064_2_FROM,
      O => XLXI_10_I3_n0064_2_XORF
    );
  XLXI_10_I3_n0064_2_F : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_2,
      ADR1 => XLXI_10_I3_Madd_n0064_inst_lut2_26,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I3_n0064_2_FROM
    );
  XLXI_10_I3_n0064_2_G : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_3,
      ADR1 => XLXI_10_I3_Madd_n0064_inst_lut2_27,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I3_n0064_2_GROM
    );
  XLXI_10_I3_n0064_2_COUTUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0064_2_CYMUXG,
      O => XLXI_10_I3_n0058(4)
    );
  XLXI_10_I3_n0064_2_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0064_2_XORF,
      O => XLXI_10_I3_n0064(2)
    );
  XLXI_10_I3_n0064_2_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0064_2_XORG,
      O => XLXI_10_I3_n0064(3)
    );
  XLXI_10_I3_Madd_n0064_inst_cy_27 : X_MUX2
    port map (
      IA => XLXI_10_I3_acc_c_0_3,
      IB => XLXI_10_I3_Madd_n0064_inst_cy_26,
      SEL => XLXI_10_I3_n0064_2_GROM,
      O => XLXI_10_I3_n0064_2_CYMUXG
    );
  XLXI_10_I3_Madd_n0064_inst_sum_19 : X_XOR2
    port map (
      I0 => XLXI_10_I3_Madd_n0064_inst_cy_26,
      I1 => XLXI_10_I3_n0064_2_GROM,
      O => XLXI_10_I3_n0064_2_XORG
    );
  XLXI_10_I3_n0064_2_CYINIT_93 : X_BUF
    port map (
      I => XLXI_10_I3_Madd_n0064_inst_cy_25,
      O => XLXI_10_I3_n0064_2_CYINIT
    );
  XLXI_10_I1_n0013_1_LOGIC_ZERO_94 : X_ZERO
    port map (
      O => XLXI_10_I1_n0013_1_LOGIC_ZERO
    );
  XLXI_10_I1_Madd_n0013_inst_cy_16_95 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC1_0,
      IB => XLXI_10_I1_n0013_1_LOGIC_ZERO,
      SEL => XLXI_10_I1_Madd_n0013_inst_lut2_16,
      O => XLXI_10_I1_Madd_n0013_inst_cy_16
    );
  XLXI_10_I1_Madd_n0013_inst_lut2_161 : X_LUT4
    generic map(
      INIT => X"0F0F"
    )
    port map (
      ADR0 => GLOBAL_LOGIC1_0,
      ADR1 => VCC,
      ADR2 => XLXI_10_I1_pc(0),
      ADR3 => VCC,
      O => XLXI_10_I1_Madd_n0013_inst_lut2_16
    );
  XLXI_10_I1_n0013_1_G : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => GLOBAL_LOGIC0_1,
      ADR1 => VCC,
      ADR2 => XLXI_10_I1_pc(1),
      ADR3 => VCC,
      O => XLXI_10_I1_n0013_1_GROM
    );
  XLXI_10_I1_n0013_1_COUTUSED : X_BUF
    port map (
      I => XLXI_10_I1_n0013_1_CYMUXG,
      O => XLXI_10_I1_Madd_n0013_inst_cy_17
    );
  XLXI_10_I1_n0013_1_YUSED : X_BUF
    port map (
      I => XLXI_10_I1_n0013_1_XORG,
      O => XLXI_10_I1_n0013(1)
    );
  XLXI_10_I1_Madd_n0013_inst_cy_17_96 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC0_1,
      IB => XLXI_10_I1_Madd_n0013_inst_cy_16,
      SEL => XLXI_10_I1_n0013_1_GROM,
      O => XLXI_10_I1_n0013_1_CYMUXG
    );
  XLXI_10_I1_Madd_n0013_inst_sum_9 : X_XOR2
    port map (
      I0 => XLXI_10_I1_Madd_n0013_inst_cy_16,
      I1 => XLXI_10_I1_n0013_1_GROM,
      O => XLXI_10_I1_n0013_1_XORG
    );
  XLXI_10_I1_n0013_2_LOGIC_ZERO_97 : X_ZERO
    port map (
      O => XLXI_10_I1_n0013_2_LOGIC_ZERO
    );
  XLXI_10_I1_Madd_n0013_inst_cy_18_98 : X_MUX2
    port map (
      IA => XLXI_10_I1_n0013_2_LOGIC_ZERO,
      IB => XLXI_10_I1_n0013_2_CYINIT,
      SEL => XLXI_10_I1_n0013_2_FROM,
      O => XLXI_10_I1_Madd_n0013_inst_cy_18
    );
  XLXI_10_I1_Madd_n0013_inst_sum_10 : X_XOR2
    port map (
      I0 => XLXI_10_I1_n0013_2_CYINIT,
      I1 => XLXI_10_I1_n0013_2_FROM,
      O => XLXI_10_I1_n0013_2_XORF
    );
  XLXI_10_I1_n0013_2_F : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_10_I1_pc(2),
      O => XLXI_10_I1_n0013_2_FROM
    );
  XLXI_10_I1_n0013_2_G : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_10_I1_pc(3),
      ADR3 => VCC,
      O => XLXI_10_I1_n0013_2_GROM
    );
  XLXI_10_I1_n0013_2_COUTUSED : X_BUF
    port map (
      I => XLXI_10_I1_n0013_2_CYMUXG,
      O => XLXI_10_I1_Madd_n0013_inst_cy_19
    );
  XLXI_10_I1_n0013_2_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_n0013_2_XORF,
      O => XLXI_10_I1_n0013(2)
    );
  XLXI_10_I1_n0013_2_YUSED : X_BUF
    port map (
      I => XLXI_10_I1_n0013_2_XORG,
      O => XLXI_10_I1_n0013(3)
    );
  XLXI_10_I1_Madd_n0013_inst_cy_19_99 : X_MUX2
    port map (
      IA => XLXI_10_I1_n0013_2_LOGIC_ZERO,
      IB => XLXI_10_I1_Madd_n0013_inst_cy_18,
      SEL => XLXI_10_I1_n0013_2_GROM,
      O => XLXI_10_I1_n0013_2_CYMUXG
    );
  XLXI_10_I1_Madd_n0013_inst_sum_11 : X_XOR2
    port map (
      I0 => XLXI_10_I1_Madd_n0013_inst_cy_18,
      I1 => XLXI_10_I1_n0013_2_GROM,
      O => XLXI_10_I1_n0013_2_XORG
    );
  XLXI_10_I1_n0013_2_CYINIT_100 : X_BUF
    port map (
      I => XLXI_10_I1_Madd_n0013_inst_cy_17,
      O => XLXI_10_I1_n0013_2_CYINIT
    );
  XLXI_10_I1_n0013_4_LOGIC_ZERO_101 : X_ZERO
    port map (
      O => XLXI_10_I1_n0013_4_LOGIC_ZERO
    );
  XLXI_10_I1_Madd_n0013_inst_cy_20_102 : X_MUX2
    port map (
      IA => XLXI_10_I1_n0013_4_LOGIC_ZERO,
      IB => XLXI_10_I1_n0013_4_CYINIT,
      SEL => XLXI_10_I1_n0013_4_FROM,
      O => XLXI_10_I1_Madd_n0013_inst_cy_20
    );
  XLXI_10_I1_Madd_n0013_inst_sum_12 : X_XOR2
    port map (
      I0 => XLXI_10_I1_n0013_4_CYINIT,
      I1 => XLXI_10_I1_n0013_4_FROM,
      O => XLXI_10_I1_n0013_4_XORF
    );
  XLXI_10_I1_n0013_4_F : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I1_pc(4),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_n0013_4_FROM
    );
  XLXI_10_I1_n0013_4_G : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_10_I1_pc(5),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_n0013_4_GROM
    );
  XLXI_10_I1_n0013_4_COUTUSED : X_BUF
    port map (
      I => XLXI_10_I1_n0013_4_CYMUXG,
      O => XLXI_10_I1_Madd_n0013_inst_cy_21
    );
  XLXI_10_I1_n0013_4_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_n0013_4_XORF,
      O => XLXI_10_I1_n0013(4)
    );
  XLXI_10_I1_n0013_4_YUSED : X_BUF
    port map (
      I => XLXI_10_I1_n0013_4_XORG,
      O => XLXI_10_I1_n0013(5)
    );
  XLXI_10_I1_Madd_n0013_inst_cy_21_103 : X_MUX2
    port map (
      IA => XLXI_10_I1_n0013_4_LOGIC_ZERO,
      IB => XLXI_10_I1_Madd_n0013_inst_cy_20,
      SEL => XLXI_10_I1_n0013_4_GROM,
      O => XLXI_10_I1_n0013_4_CYMUXG
    );
  XLXI_10_I1_Madd_n0013_inst_sum_13 : X_XOR2
    port map (
      I0 => XLXI_10_I1_Madd_n0013_inst_cy_20,
      I1 => XLXI_10_I1_n0013_4_GROM,
      O => XLXI_10_I1_n0013_4_XORG
    );
  XLXI_10_I1_n0013_4_CYINIT_104 : X_BUF
    port map (
      I => XLXI_10_I1_Madd_n0013_inst_cy_19,
      O => XLXI_10_I1_n0013_4_CYINIT
    );
  XLXI_10_I1_n0013_6_LOGIC_ZERO_105 : X_ZERO
    port map (
      O => XLXI_10_I1_n0013_6_LOGIC_ZERO
    );
  XLXI_10_I1_Madd_n0013_inst_cy_22_106 : X_MUX2
    port map (
      IA => XLXI_10_I1_n0013_6_LOGIC_ZERO,
      IB => XLXI_10_I1_n0013_6_CYINIT,
      SEL => XLXI_10_I1_n0013_6_FROM,
      O => XLXI_10_I1_Madd_n0013_inst_cy_22
    );
  XLXI_10_I1_Madd_n0013_inst_sum_14 : X_XOR2
    port map (
      I0 => XLXI_10_I1_n0013_6_CYINIT,
      I1 => XLXI_10_I1_n0013_6_FROM,
      O => XLXI_10_I1_n0013_6_XORF
    );
  XLXI_10_I1_n0013_6_F : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_10_I1_pc(6),
      ADR3 => VCC,
      O => XLXI_10_I1_n0013_6_FROM
    );
  XLXI_10_I1_pc_7_rt_107 : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_10_I1_pc(7),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_pc_7_rt
    );
  XLXI_10_I1_n0013_6_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_n0013_6_XORF,
      O => XLXI_10_I1_n0013(6)
    );
  XLXI_10_I1_n0013_6_YUSED : X_BUF
    port map (
      I => XLXI_10_I1_n0013_6_XORG,
      O => XLXI_10_I1_n0013(7)
    );
  XLXI_10_I1_Madd_n0013_inst_sum_15 : X_XOR2
    port map (
      I0 => XLXI_10_I1_Madd_n0013_inst_cy_22,
      I1 => XLXI_10_I1_pc_7_rt,
      O => XLXI_10_I1_n0013_6_XORG
    );
  XLXI_10_I1_n0013_6_CYINIT_108 : X_BUF
    port map (
      I => XLXI_10_I1_Madd_n0013_inst_cy_21,
      O => XLXI_10_I1_n0013_6_CYINIT
    );
  XLXI_3_pwm_high_0_LOGIC_ONE_109 : X_ONE
    port map (
      O => XLXI_3_pwm_high_0_LOGIC_ONE
    );
  XLXI_3_Msub_n0005_inst_cy_8_110 : X_MUX2
    port map (
      IA => XLXI_3_n0011(0),
      IB => XLXI_3_pwm_high_0_CYINIT,
      SEL => XLXI_3_pwm_high_0_FROM,
      O => XLXI_3_Msub_n0005_inst_cy_8
    );
  XLXI_3_Msub_n0005_inst_sum_0 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_high_0_CYINIT,
      I1 => XLXI_3_pwm_high_0_FROM,
      O => XLXI_3_n0005(0)
    );
  XLXI_3_pwm_high_0_F : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => XLXI_3_n0011(0),
      ADR1 => VCC,
      ADR2 => XLXI_3_Msub_n0005_inst_lut2_8,
      ADR3 => VCC,
      O => XLXI_3_pwm_high_0_FROM
    );
  XLXI_3_pwm_high_0_G : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => XLXI_3_n0011(1),
      ADR1 => VCC,
      ADR2 => XLXI_3_Msub_n0005_inst_lut2_9,
      ADR3 => VCC,
      O => XLXI_3_pwm_high_0_GROM
    );
  XLXI_3_pwm_high_0_COUTUSED : X_BUF
    port map (
      I => XLXI_3_pwm_high_0_CYMUXG,
      O => XLXI_3_Msub_n0005_inst_cy_9
    );
  XLXI_3_Msub_n0005_inst_cy_9_111 : X_MUX2
    port map (
      IA => XLXI_3_n0011(1),
      IB => XLXI_3_Msub_n0005_inst_cy_8,
      SEL => XLXI_3_pwm_high_0_GROM,
      O => XLXI_3_pwm_high_0_CYMUXG
    );
  XLXI_3_Msub_n0005_inst_sum_1 : X_XOR2
    port map (
      I0 => XLXI_3_Msub_n0005_inst_cy_8,
      I1 => XLXI_3_pwm_high_0_GROM,
      O => XLXI_3_n0005(1)
    );
  XLXI_3_pwm_high_0_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_high_0_SRMUX_OUTPUTNOT
    );
  XLXI_3_pwm_high_0_CYINIT_112 : X_BUF
    port map (
      I => XLXI_3_pwm_high_0_LOGIC_ONE,
      O => XLXI_3_pwm_high_0_CYINIT
    );
  XLXI_3_Msub_n0005_inst_cy_10_113 : X_MUX2
    port map (
      IA => XLXI_3_n0011(2),
      IB => XLXI_3_pwm_high_2_CYINIT,
      SEL => XLXI_3_pwm_high_2_FROM,
      O => XLXI_3_Msub_n0005_inst_cy_10
    );
  XLXI_3_Msub_n0005_inst_sum_2 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_high_2_CYINIT,
      I1 => XLXI_3_pwm_high_2_FROM,
      O => XLXI_3_n0005(2)
    );
  XLXI_3_pwm_high_2_F : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => XLXI_3_n0011(2),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_3_Msub_n0005_inst_lut2_10,
      O => XLXI_3_pwm_high_2_FROM
    );
  XLXI_3_pwm_high_2_G : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => XLXI_3_n0011(3),
      ADR1 => VCC,
      ADR2 => XLXI_3_Msub_n0005_inst_lut2_11,
      ADR3 => VCC,
      O => XLXI_3_pwm_high_2_GROM
    );
  XLXI_3_pwm_high_2_COUTUSED : X_BUF
    port map (
      I => XLXI_3_pwm_high_2_CYMUXG,
      O => XLXI_3_Msub_n0005_inst_cy_11
    );
  XLXI_3_Msub_n0005_inst_cy_11_114 : X_MUX2
    port map (
      IA => XLXI_3_n0011(3),
      IB => XLXI_3_Msub_n0005_inst_cy_10,
      SEL => XLXI_3_pwm_high_2_GROM,
      O => XLXI_3_pwm_high_2_CYMUXG
    );
  XLXI_3_Msub_n0005_inst_sum_3 : X_XOR2
    port map (
      I0 => XLXI_3_Msub_n0005_inst_cy_10,
      I1 => XLXI_3_pwm_high_2_GROM,
      O => XLXI_3_n0005(3)
    );
  XLXI_3_pwm_high_2_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_high_2_SRMUX_OUTPUTNOT
    );
  XLXI_3_pwm_high_2_CYINIT_115 : X_BUF
    port map (
      I => XLXI_3_Msub_n0005_inst_cy_9,
      O => XLXI_3_pwm_high_2_CYINIT
    );
  XLXI_3_Msub_n0005_inst_cy_12_116 : X_MUX2
    port map (
      IA => XLXI_3_n0011(4),
      IB => XLXI_3_pwm_high_4_CYINIT,
      SEL => XLXI_3_pwm_high_4_FROM,
      O => XLXI_3_Msub_n0005_inst_cy_12
    );
  XLXI_3_Msub_n0005_inst_sum_4 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_high_4_CYINIT,
      I1 => XLXI_3_pwm_high_4_FROM,
      O => XLXI_3_n0005(4)
    );
  XLXI_3_pwm_high_4_F : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => XLXI_3_n0011(4),
      ADR1 => VCC,
      ADR2 => XLXI_3_Msub_n0005_inst_lut2_12,
      ADR3 => VCC,
      O => XLXI_3_pwm_high_4_FROM
    );
  XLXI_3_pwm_high_4_G : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => XLXI_3_n0011(5),
      ADR1 => VCC,
      ADR2 => XLXI_3_Msub_n0005_inst_lut2_13,
      ADR3 => VCC,
      O => XLXI_3_pwm_high_4_GROM
    );
  XLXI_3_pwm_high_4_COUTUSED : X_BUF
    port map (
      I => XLXI_3_pwm_high_4_CYMUXG,
      O => XLXI_3_Msub_n0005_inst_cy_13
    );
  XLXI_3_Msub_n0005_inst_cy_13_117 : X_MUX2
    port map (
      IA => XLXI_3_n0011(5),
      IB => XLXI_3_Msub_n0005_inst_cy_12,
      SEL => XLXI_3_pwm_high_4_GROM,
      O => XLXI_3_pwm_high_4_CYMUXG
    );
  XLXI_3_Msub_n0005_inst_sum_5 : X_XOR2
    port map (
      I0 => XLXI_3_Msub_n0005_inst_cy_12,
      I1 => XLXI_3_pwm_high_4_GROM,
      O => XLXI_3_n0005(5)
    );
  XLXI_3_pwm_high_4_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_high_4_SRMUX_OUTPUTNOT
    );
  XLXI_3_pwm_high_4_CYINIT_118 : X_BUF
    port map (
      I => XLXI_3_Msub_n0005_inst_cy_11,
      O => XLXI_3_pwm_high_4_CYINIT
    );
  XLXI_3_Msub_n0005_inst_cy_14_119 : X_MUX2
    port map (
      IA => XLXI_3_n0011(6),
      IB => XLXI_3_pwm_high_6_CYINIT,
      SEL => XLXI_3_pwm_high_6_FROM,
      O => XLXI_3_Msub_n0005_inst_cy_14
    );
  XLXI_3_Msub_n0005_inst_sum_6 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_high_6_CYINIT,
      I1 => XLXI_3_pwm_high_6_FROM,
      O => XLXI_3_n0005(6)
    );
  XLXI_3_pwm_high_6_F : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_3_n0011(6),
      ADR1 => XLXI_3_Msub_n0005_inst_lut2_14,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_pwm_high_6_FROM
    );
  XLXI_3_Msub_n0005_inst_lut2_151 : X_LUT4
    generic map(
      INIT => X"C693"
    )
    port map (
      ADR0 => XLXI_3_N6661,
      ADR1 => XLXI_2_pwm_data_c(3),
      ADR2 => XLXI_3_pwm_low(7),
      ADR3 => XLXI_3_pwm_period(7),
      O => XLXI_3_Msub_n0005_inst_lut2_151_O
    );
  XLXI_3_Msub_n0005_inst_sum_7 : X_XOR2
    port map (
      I0 => XLXI_3_Msub_n0005_inst_cy_14,
      I1 => XLXI_3_Msub_n0005_inst_lut2_151_O,
      O => XLXI_3_n0005(7)
    );
  XLXI_3_pwm_high_6_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_high_6_SRMUX_OUTPUTNOT
    );
  XLXI_3_pwm_high_6_CYINIT_120 : X_BUF
    port map (
      I => XLXI_3_Msub_n0005_inst_cy_13,
      O => XLXI_3_pwm_high_6_CYINIT
    );
  XLXI_3_n0013_1_LOGIC_ZERO_121 : X_ZERO
    port map (
      O => XLXI_3_n0013_1_LOGIC_ZERO
    );
  XLXI_3_Madd_n0013_inst_cy_16_122 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC1,
      IB => XLXI_3_n0013_1_LOGIC_ZERO,
      SEL => XLXI_3_Madd_n0013_inst_lut2_16,
      O => XLXI_3_Madd_n0013_inst_cy_16
    );
  XLXI_3_Madd_n0013_inst_lut2_161 : X_LUT4
    generic map(
      INIT => X"0F0F"
    )
    port map (
      ADR0 => GLOBAL_LOGIC1,
      ADR1 => VCC,
      ADR2 => XLXI_3_pwm_count(0),
      ADR3 => VCC,
      O => XLXI_3_Madd_n0013_inst_lut2_16
    );
  XLXI_3_n0013_1_G : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => GLOBAL_LOGIC0_0,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_3_pwm_count(1),
      O => XLXI_3_n0013_1_GROM
    );
  XLXI_3_n0013_1_COUTUSED : X_BUF
    port map (
      I => XLXI_3_n0013_1_CYMUXG,
      O => XLXI_3_Madd_n0013_inst_cy_17
    );
  XLXI_3_n0013_1_YUSED : X_BUF
    port map (
      I => XLXI_3_n0013_1_XORG,
      O => XLXI_3_n0013(1)
    );
  XLXI_3_Madd_n0013_inst_cy_17_123 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC0_0,
      IB => XLXI_3_Madd_n0013_inst_cy_16,
      SEL => XLXI_3_n0013_1_GROM,
      O => XLXI_3_n0013_1_CYMUXG
    );
  XLXI_3_Madd_n0013_inst_sum_9 : X_XOR2
    port map (
      I0 => XLXI_3_Madd_n0013_inst_cy_16,
      I1 => XLXI_3_n0013_1_GROM,
      O => XLXI_3_n0013_1_XORG
    );
  XLXI_3_n0013_2_LOGIC_ZERO_124 : X_ZERO
    port map (
      O => XLXI_3_n0013_2_LOGIC_ZERO
    );
  XLXI_3_Madd_n0013_inst_cy_18_125 : X_MUX2
    port map (
      IA => XLXI_3_n0013_2_LOGIC_ZERO,
      IB => XLXI_3_n0013_2_CYINIT,
      SEL => XLXI_3_n0013_2_FROM,
      O => XLXI_3_Madd_n0013_inst_cy_18
    );
  XLXI_3_Madd_n0013_inst_sum_10 : X_XOR2
    port map (
      I0 => XLXI_3_n0013_2_CYINIT,
      I1 => XLXI_3_n0013_2_FROM,
      O => XLXI_3_n0013_2_XORF
    );
  XLXI_3_n0013_2_F : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_3_pwm_count(2),
      O => XLXI_3_n0013_2_FROM
    );
  XLXI_3_n0013_2_G : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_3_pwm_count(3),
      ADR3 => VCC,
      O => XLXI_3_n0013_2_GROM
    );
  XLXI_3_n0013_2_COUTUSED : X_BUF
    port map (
      I => XLXI_3_n0013_2_CYMUXG,
      O => XLXI_3_Madd_n0013_inst_cy_19
    );
  XLXI_3_n0013_2_XUSED : X_BUF
    port map (
      I => XLXI_3_n0013_2_XORF,
      O => XLXI_3_n0013(2)
    );
  XLXI_3_n0013_2_YUSED : X_BUF
    port map (
      I => XLXI_3_n0013_2_XORG,
      O => XLXI_3_n0013(3)
    );
  XLXI_3_Madd_n0013_inst_cy_19_126 : X_MUX2
    port map (
      IA => XLXI_3_n0013_2_LOGIC_ZERO,
      IB => XLXI_3_Madd_n0013_inst_cy_18,
      SEL => XLXI_3_n0013_2_GROM,
      O => XLXI_3_n0013_2_CYMUXG
    );
  XLXI_3_Madd_n0013_inst_sum_11 : X_XOR2
    port map (
      I0 => XLXI_3_Madd_n0013_inst_cy_18,
      I1 => XLXI_3_n0013_2_GROM,
      O => XLXI_3_n0013_2_XORG
    );
  XLXI_3_n0013_2_CYINIT_127 : X_BUF
    port map (
      I => XLXI_3_Madd_n0013_inst_cy_17,
      O => XLXI_3_n0013_2_CYINIT
    );
  XLXI_3_n0013_4_LOGIC_ZERO_128 : X_ZERO
    port map (
      O => XLXI_3_n0013_4_LOGIC_ZERO
    );
  XLXI_3_Madd_n0013_inst_cy_20_129 : X_MUX2
    port map (
      IA => XLXI_3_n0013_4_LOGIC_ZERO,
      IB => XLXI_3_n0013_4_CYINIT,
      SEL => XLXI_3_n0013_4_FROM,
      O => XLXI_3_Madd_n0013_inst_cy_20
    );
  XLXI_3_Madd_n0013_inst_sum_12 : X_XOR2
    port map (
      I0 => XLXI_3_n0013_4_CYINIT,
      I1 => XLXI_3_n0013_4_FROM,
      O => XLXI_3_n0013_4_XORF
    );
  XLXI_3_n0013_4_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_3_pwm_count(4),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_n0013_4_FROM
    );
  XLXI_3_n0013_4_G : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_3_pwm_count(5),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_n0013_4_GROM
    );
  XLXI_3_n0013_4_COUTUSED : X_BUF
    port map (
      I => XLXI_3_n0013_4_CYMUXG,
      O => XLXI_3_Madd_n0013_inst_cy_21
    );
  XLXI_3_n0013_4_XUSED : X_BUF
    port map (
      I => XLXI_3_n0013_4_XORF,
      O => XLXI_3_n0013(4)
    );
  XLXI_3_n0013_4_YUSED : X_BUF
    port map (
      I => XLXI_3_n0013_4_XORG,
      O => XLXI_3_n0013(5)
    );
  XLXI_3_Madd_n0013_inst_cy_21_130 : X_MUX2
    port map (
      IA => XLXI_3_n0013_4_LOGIC_ZERO,
      IB => XLXI_3_Madd_n0013_inst_cy_20,
      SEL => XLXI_3_n0013_4_GROM,
      O => XLXI_3_n0013_4_CYMUXG
    );
  XLXI_3_Madd_n0013_inst_sum_13 : X_XOR2
    port map (
      I0 => XLXI_3_Madd_n0013_inst_cy_20,
      I1 => XLXI_3_n0013_4_GROM,
      O => XLXI_3_n0013_4_XORG
    );
  XLXI_3_n0013_4_CYINIT_131 : X_BUF
    port map (
      I => XLXI_3_Madd_n0013_inst_cy_19,
      O => XLXI_3_n0013_4_CYINIT
    );
  XLXI_3_n0013_6_LOGIC_ZERO_132 : X_ZERO
    port map (
      O => XLXI_3_n0013_6_LOGIC_ZERO
    );
  XLXI_3_Madd_n0013_inst_cy_22_133 : X_MUX2
    port map (
      IA => XLXI_3_n0013_6_LOGIC_ZERO,
      IB => XLXI_3_n0013_6_CYINIT,
      SEL => XLXI_3_n0013_6_FROM,
      O => XLXI_3_Madd_n0013_inst_cy_22
    );
  XLXI_3_Madd_n0013_inst_sum_14 : X_XOR2
    port map (
      I0 => XLXI_3_n0013_6_CYINIT,
      I1 => XLXI_3_n0013_6_FROM,
      O => XLXI_3_n0013_6_XORF
    );
  XLXI_3_n0013_6_F : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_3_pwm_count(6),
      O => XLXI_3_n0013_6_FROM
    );
  XLXI_3_pwm_count_7_rt_134 : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_3_pwm_count(7),
      ADR3 => VCC,
      O => XLXI_3_pwm_count_7_rt
    );
  XLXI_3_n0013_6_XUSED : X_BUF
    port map (
      I => XLXI_3_n0013_6_XORF,
      O => XLXI_3_n0013(6)
    );
  XLXI_3_n0013_6_YUSED : X_BUF
    port map (
      I => XLXI_3_n0013_6_XORG,
      O => XLXI_3_n0013(7)
    );
  XLXI_3_Madd_n0013_inst_sum_15 : X_XOR2
    port map (
      I0 => XLXI_3_Madd_n0013_inst_cy_22,
      I1 => XLXI_3_pwm_count_7_rt,
      O => XLXI_3_n0013_6_XORG
    );
  XLXI_3_n0013_6_CYINIT_135 : X_BUF
    port map (
      I => XLXI_3_Madd_n0013_inst_cy_21,
      O => XLXI_3_n0013_6_CYINIT
    );
  XLXI_10_I1_n0011_5_19_SW0 : X_LUT4
    generic map(
      INIT => X"CFC0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_5,
      ADR2 => XLXI_10_I2_pc_mux_x_2_2,
      ADR3 => XLXI_10_I1_stack_addrs_c_0_5,
      O => XLXI_10_I1_stack_addrs_c_1_5_FROM
    );
  XLXI_10_I1_n0011_5_19 : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_1_1,
      ADR1 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_5,
      ADR3 => XLXI_10_I1_n0011_5_19_SW0_O,
      O => XLXI_10_I1_n0011_5_19_O
    );
  XLXI_10_I1_stack_addrs_c_1_5_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_1_5_FROM,
      O => XLXI_10_I1_n0011_5_19_SW0_O
    );
  XLXI_10_I1_n0012_1_19_SW0 : X_LUT4
    generic map(
      INIT => X"ACAC"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_1_1,
      ADR1 => XLXI_10_I1_n0013(1),
      ADR2 => XLXI_10_I2_pc_mux_x_2_1,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_0_1_FROM
    );
  XLXI_10_I1_n0012_1_19 : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_1_1,
      ADR1 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_1,
      ADR3 => XLXI_10_I1_n0012_1_19_SW0_O,
      O => XLXI_10_I1_n0012_1_19_O
    );
  XLXI_10_I1_stack_addrs_c_0_1_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_0_1_FROM,
      O => XLXI_10_I1_n0012_1_19_SW0_O
    );
  XLXI_10_I1_n0012_2_19_SW0 : X_LUT4
    generic map(
      INIT => X"AACC"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_1_2,
      ADR1 => XLXI_10_I1_n0013(2),
      ADR2 => VCC,
      ADR3 => XLXI_10_I2_pc_mux_x_2_1,
      O => XLXI_10_I1_stack_addrs_c_0_2_FROM
    );
  XLXI_10_I1_n0012_2_19 : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_2,
      ADR3 => XLXI_10_I1_n0012_2_19_SW0_O,
      O => XLXI_10_I1_n0012_2_19_O
    );
  XLXI_10_I1_stack_addrs_c_0_2_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_0_2_FROM,
      O => XLXI_10_I1_n0012_2_19_SW0_O
    );
  XLXI_10_I1_n0011_6_19_SW0 : X_LUT4
    generic map(
      INIT => X"CACA"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_0_6,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_6,
      ADR2 => XLXI_10_I2_pc_mux_x_2_2,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_1_6_FROM
    );
  XLXI_10_I1_n0011_6_19 : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_6,
      ADR3 => XLXI_10_I1_n0011_6_19_SW0_O,
      O => XLXI_10_I1_n0011_6_19_O
    );
  XLXI_10_I1_stack_addrs_c_1_6_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_1_6_FROM,
      O => XLXI_10_I1_n0011_6_19_SW0_O
    );
  XLXI_10_I1_n0012_3_19_SW0 : X_LUT4
    generic map(
      INIT => X"FC0C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I1_n0013(3),
      ADR2 => XLXI_10_I2_pc_mux_x_2_1,
      ADR3 => XLXI_10_I1_stack_addrs_c_1_3,
      O => XLXI_10_I1_stack_addrs_c_0_3_FROM
    );
  XLXI_10_I1_n0012_3_19 : X_LUT4
    generic map(
      INIT => X"EC4C"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_0_3,
      ADR2 => XLXI_10_I2_pc_mux_x_1_1,
      ADR3 => XLXI_10_I1_n0012_3_19_SW0_O,
      O => XLXI_10_I1_n0012_3_19_O
    );
  XLXI_10_I1_stack_addrs_c_0_3_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_0_3_FROM,
      O => XLXI_10_I1_n0012_3_19_SW0_O
    );
  XLXI_10_I1_n0012_4_19_SW0 : X_LUT4
    generic map(
      INIT => X"CACA"
    )
    port map (
      ADR0 => XLXI_10_I1_n0013(4),
      ADR1 => XLXI_10_I1_stack_addrs_c_1_4,
      ADR2 => XLXI_10_I2_pc_mux_x_2_1,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_0_4_FROM
    );
  XLXI_10_I1_n0012_4_19 : X_LUT4
    generic map(
      INIT => X"EC4C"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_1_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_0_4,
      ADR2 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR3 => XLXI_10_I1_n0012_4_19_SW0_O,
      O => XLXI_10_I1_n0012_4_19_O
    );
  XLXI_10_I1_stack_addrs_c_0_4_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_0_4_FROM,
      O => XLXI_10_I1_n0012_4_19_SW0_O
    );
  XLXI_10_I1_n0012_5_19_SW0 : X_LUT4
    generic map(
      INIT => X"F0CC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I1_n0013(5),
      ADR2 => XLXI_10_I1_stack_addrs_c_1_5,
      ADR3 => XLXI_10_I2_pc_mux_x_2_1,
      O => XLXI_10_I1_stack_addrs_c_0_5_FROM
    );
  XLXI_10_I1_n0012_5_19 : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_0_5,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR3 => XLXI_10_I1_n0012_5_19_SW0_O,
      O => XLXI_10_I1_n0012_5_19_O
    );
  XLXI_10_I1_stack_addrs_c_0_5_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_0_5_FROM,
      O => XLXI_10_I1_n0012_5_19_SW0_O
    );
  XLXI_10_I1_n0012_6_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_6,
      ADR2 => XLXI_10_I1_n0013(6),
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_0_6_FROM
    );
  XLXI_10_I1_n0012_6_19 : X_LUT4
    generic map(
      INIT => X"EC4C"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_1_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_0_6,
      ADR2 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR3 => XLXI_10_I1_n0012_6_19_SW0_O,
      O => XLXI_10_I1_n0012_6_19_O
    );
  XLXI_10_I1_stack_addrs_c_0_6_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_0_6_FROM,
      O => XLXI_10_I1_n0012_6_19_SW0_O
    );
  XLXI_10_I2_Ker81281 : X_LUT4
    generic map(
      INIT => X"0F00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_10_skip,
      ADR3 => XLXI_10_I2_nreset_v(1),
      O => XLXI_10_I2_N8130_FROM
    );
  XLXI_10_I2_pc_mux_x_1_Q : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => N21055,
      ADR1 => XLXI_10_I2_N8054,
      ADR2 => NRESET_IBUF,
      ADR3 => XLXI_10_I2_N8130,
      O => XLXI_10_I2_N8130_GROM
    );
  XLXI_10_I2_N8130_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_N8130_FROM,
      O => XLXI_10_I2_N8130
    );
  XLXI_10_I2_N8130_YUSED : X_BUF
    port map (
      I => XLXI_10_I2_N8130_GROM,
      O => XLXI_10_pc_mux(1)
    );
  XLXI_10_I1_n00161 : X_LUT4
    generic map(
      INIT => X"C0C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_pc_mux(0),
      ADR2 => XLXI_10_pc_mux(1),
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_3_1_FROM
    );
  XLXI_10_I1_n0009_1_1 : X_LUT4
    generic map(
      INIT => X"22F0"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_2_1,
      ADR1 => XLXI_10_I2_pc_mux_x_2_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_3_1,
      ADR3 => XLXI_10_I1_n0016,
      O => XLXI_10_I1_n0009_1_1_O
    );
  XLXI_10_I1_stack_addrs_c_3_1_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_3_1_FROM,
      O => XLXI_10_I1_n0016
    );
  XLXI_10_I1_iaddr_x_0_31 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => N23875,
      ADR3 => XLXI_10_pc_mux(0),
      O => XLXI_10_I1_pc_0_FROM
    );
  XLXI_10_I1_iaddr_x_0_50 : X_LUT4
    generic map(
      INIT => X"F040"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(2),
      ADR1 => CHOICE1760,
      ADR2 => XLXI_10_I1_n0014,
      ADR3 => XLXI_10_I1_iaddr_x_0_31_O,
      O => XLXI_10_I1_pc_0_GROM
    );
  XLXI_10_I1_pc_0_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_pc_0_FROM,
      O => XLXI_10_I1_iaddr_x_0_31_O
    );
  XLXI_10_I1_pc_0_YUSED : X_BUF
    port map (
      I => XLXI_10_I1_pc_0_GROM,
      O => CPU_IADDR_0_OBUF
    );
  XLXI_10_I1_pc_0_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I1_pc_0_SRMUX_OUTPUTNOT
    );
  XLXI_10_I1_iaddr_x_1_31 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_pc_mux(0),
      ADR2 => VCC,
      ADR3 => N23879,
      O => XLXI_10_I1_pc_1_FROM
    );
  XLXI_10_I1_iaddr_x_1_50 : X_LUT4
    generic map(
      INIT => X"AA20"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => XLXI_10_pc_mux(2),
      ADR2 => CHOICE1670,
      ADR3 => XLXI_10_I1_iaddr_x_1_31_O,
      O => XLXI_10_I1_pc_1_GROM
    );
  XLXI_10_I1_pc_1_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_pc_1_FROM,
      O => XLXI_10_I1_iaddr_x_1_31_O
    );
  XLXI_10_I1_pc_1_YUSED : X_BUF
    port map (
      I => XLXI_10_I1_pc_1_GROM,
      O => CPU_IADDR_1_OBUF
    );
  XLXI_10_I1_pc_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I1_pc_1_SRMUX_OUTPUTNOT
    );
  XLXI_10_I1_iaddr_x_2_31 : X_LUT4
    generic map(
      INIT => X"AA00"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => N23883,
      O => XLXI_10_I1_pc_2_FROM
    );
  XLXI_10_I1_iaddr_x_2_50 : X_LUT4
    generic map(
      INIT => X"AA20"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => XLXI_10_pc_mux(2),
      ADR2 => CHOICE1685,
      ADR3 => XLXI_10_I1_iaddr_x_2_31_O,
      O => XLXI_10_I1_pc_2_GROM
    );
  XLXI_10_I1_pc_2_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_pc_2_FROM,
      O => XLXI_10_I1_iaddr_x_2_31_O
    );
  XLXI_10_I1_pc_2_YUSED : X_BUF
    port map (
      I => XLXI_10_I1_pc_2_GROM,
      O => CPU_IADDR_2_OBUF
    );
  XLXI_10_I1_pc_2_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I1_pc_2_SRMUX_OUTPUTNOT
    );
  XLXI_10_I1_iaddr_x_3_31 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => N23887,
      ADR2 => VCC,
      ADR3 => XLXI_10_pc_mux(0),
      O => XLXI_10_I1_pc_3_FROM
    );
  XLXI_10_I1_iaddr_x_3_52 : X_LUT4
    generic map(
      INIT => X"CC40"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(2),
      ADR1 => XLXI_10_I1_n0014,
      ADR2 => CHOICE1775,
      ADR3 => XLXI_10_I1_iaddr_x_3_31_O,
      O => XLXI_10_I1_pc_3_GROM
    );
  XLXI_10_I1_pc_3_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_pc_3_FROM,
      O => XLXI_10_I1_iaddr_x_3_31_O
    );
  XLXI_10_I1_pc_3_YUSED : X_BUF
    port map (
      I => XLXI_10_I1_pc_3_GROM,
      O => CPU_IADDR_3_OBUF
    );
  XLXI_10_I1_pc_3_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I1_pc_3_SRMUX_OUTPUTNOT
    );
  XLXI_10_I1_iaddr_x_4_31 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => N23891,
      ADR2 => VCC,
      ADR3 => XLXI_10_pc_mux(0),
      O => XLXI_10_I1_pc_4_FROM
    );
  XLXI_10_I1_iaddr_x_4_50 : X_LUT4
    generic map(
      INIT => X"CC08"
    )
    port map (
      ADR0 => CHOICE1745,
      ADR1 => XLXI_10_I1_n0014,
      ADR2 => XLXI_10_pc_mux(2),
      ADR3 => XLXI_10_I1_iaddr_x_4_31_O,
      O => XLXI_10_I1_pc_4_GROM
    );
  XLXI_10_I1_pc_4_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_pc_4_FROM,
      O => XLXI_10_I1_iaddr_x_4_31_O
    );
  XLXI_10_I1_pc_4_YUSED : X_BUF
    port map (
      I => XLXI_10_I1_pc_4_GROM,
      O => CPU_IADDR_4_OBUF
    );
  XLXI_10_I1_pc_4_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I1_pc_4_SRMUX_OUTPUTNOT
    );
  XLXI_10_I1_iaddr_x_5_31 : X_LUT4
    generic map(
      INIT => X"AA00"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => N23895,
      O => XLXI_10_I1_pc_5_FROM
    );
  XLXI_10_I1_iaddr_x_5_50 : X_LUT4
    generic map(
      INIT => X"F020"
    )
    port map (
      ADR0 => CHOICE1715,
      ADR1 => XLXI_10_pc_mux(2),
      ADR2 => XLXI_10_I1_n0014,
      ADR3 => XLXI_10_I1_iaddr_x_5_31_O,
      O => XLXI_10_I1_pc_5_GROM
    );
  XLXI_10_I1_pc_5_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_pc_5_FROM,
      O => XLXI_10_I1_iaddr_x_5_31_O
    );
  XLXI_10_I1_pc_5_YUSED : X_BUF
    port map (
      I => XLXI_10_I1_pc_5_GROM,
      O => CPU_IADDR_5_OBUF
    );
  XLXI_10_I1_pc_5_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I1_pc_5_SRMUX_OUTPUTNOT
    );
  XLXI_10_I1_iaddr_x_6_31 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => N23899,
      ADR1 => XLXI_10_pc_mux(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_pc_6_FROM
    );
  XLXI_10_I1_iaddr_x_6_50 : X_LUT4
    generic map(
      INIT => X"F040"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(2),
      ADR1 => CHOICE1730,
      ADR2 => XLXI_10_I1_n0014,
      ADR3 => XLXI_10_I1_iaddr_x_6_31_O,
      O => XLXI_10_I1_pc_6_GROM
    );
  XLXI_10_I1_pc_6_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_pc_6_FROM,
      O => XLXI_10_I1_iaddr_x_6_31_O
    );
  XLXI_10_I1_pc_6_YUSED : X_BUF
    port map (
      I => XLXI_10_I1_pc_6_GROM,
      O => CPU_IADDR_6_OBUF
    );
  XLXI_10_I1_pc_6_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I1_pc_6_SRMUX_OUTPUTNOT
    );
  XLXI_10_I1_iaddr_x_7_31 : X_LUT4
    generic map(
      INIT => X"A0A0"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => VCC,
      ADR2 => N23903,
      ADR3 => VCC,
      O => XLXI_10_I1_pc_7_FROM
    );
  XLXI_10_I1_iaddr_x_7_50 : X_LUT4
    generic map(
      INIT => X"AA08"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => CHOICE1700,
      ADR2 => XLXI_10_pc_mux(2),
      ADR3 => XLXI_10_I1_iaddr_x_7_31_O,
      O => XLXI_10_I1_pc_7_GROM
    );
  XLXI_10_I1_pc_7_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_pc_7_FROM,
      O => XLXI_10_I1_iaddr_x_7_31_O
    );
  XLXI_10_I1_pc_7_YUSED : X_BUF
    port map (
      I => XLXI_10_I1_pc_7_GROM,
      O => CPU_IADDR_7_OBUF
    );
  XLXI_10_I1_pc_7_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I1_pc_7_SRMUX_OUTPUTNOT
    );
  XLXI_10_I2_ndre_x_SW2 : X_LUT4
    generic map(
      INIT => X"FFF7"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXI_10_I2_nreset_v(1),
      ADR2 => N22806,
      ADR3 => XLXI_10_skip,
      O => N23503_FROM
    );
  XLXI_10_I2_ndre_x : X_LUT4
    generic map(
      INIT => X"FFAB"
    )
    port map (
      ADR0 => XLXN_8(3),
      ADR1 => XLXN_8(1),
      ADR2 => XLXN_8(2),
      ADR3 => N23503,
      O => N23503_GROM
    );
  N23503_XUSED : X_BUF
    port map (
      I => N23503_FROM,
      O => N23503
    );
  N23503_YUSED : X_BUF
    port map (
      I => N23503_GROM,
      O => XLXI_10_ndre_int
    );
  XLXI_2_Mmux_n0018_Result_1_1 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_2_N6097,
      ADR1 => XLXI_2_N6116,
      ADR2 => CPU_DATA_OUT_1_OBUF,
      ADR3 => XLXI_2_pwm_data_c(1),
      O => XLXI_2_Mmux_n0018_Result_1_1_O
    );
  XLXI_2_Mmux_n0018_Result_0_1 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => CPU_DATA_OUT_0_OBUF,
      ADR1 => XLXI_2_N6097,
      ADR2 => XLXI_2_pwm_data_c(0),
      ADR3 => XLXI_2_N6116,
      O => XLXI_2_Mmux_n0018_Result_0_1_O
    );
  XLXI_2_pwm_data_c_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_2_pwm_data_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_2_Mmux_n0018_Result_3_1 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_2_N6116,
      ADR1 => XLXI_2_pwm_data_c(3),
      ADR2 => XLXI_2_N6097,
      ADR3 => CPU_DATA_OUT_3_OBUF,
      O => XLXI_2_Mmux_n0018_Result_3_1_O
    );
  XLXI_2_Mmux_n0018_Result_2_1 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => CPU_DATA_OUT_2_OBUF,
      ADR1 => XLXI_2_N6116,
      ADR2 => XLXI_2_N6097,
      ADR3 => XLXI_2_pwm_data_c(2),
      O => XLXI_2_Mmux_n0018_Result_2_1_O
    );
  XLXI_2_pwm_data_c_3_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_2_pwm_data_c_3_SRMUX_OUTPUTNOT
    );
  XLXI_10_I3_n0035_2_109_SW0 : X_LUT4
    generic map(
      INIT => X"F020"
    )
    port map (
      ADR0 => CHOICE1938,
      ADR1 => XLXI_10_I2_TD_c(3),
      ADR2 => XLXI_10_I3_N8818,
      ADR3 => CHOICE1918,
      O => XLXI_10_I3_n0035_2_109_SW0_O_FROM
    );
  XLXI_10_I3_n0035_2_47_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"AFA0"
    )
    port map (
      ADR0 => N23423,
      ADR1 => VCC,
      ADR2 => CHOICE1927,
      ADR3 => XLXI_10_I3_n0035_2_109_SW0_O,
      O => XLXI_10_I3_n0035_2_109_SW0_O_GROM
    );
  XLXI_10_I3_n0035_2_109_SW0_O_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0035_2_109_SW0_O_FROM,
      O => XLXI_10_I3_n0035_2_109_SW0_O
    );
  XLXI_10_I3_n0035_2_109_SW0_O_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0035_2_109_SW0_O_GROM,
      O => N23931
    );
  XLXI_10_I3_Mmux_data_x_Result_1_45 : X_LUT4
    generic map(
      INIT => X"EEEA"
    )
    port map (
      ADR0 => CHOICE1901,
      ADR1 => CHOICE1912,
      ADR2 => CHOICE1906,
      ADR3 => CHOICE1909,
      O => XLXI_10_I3_data_x_1_FROM
    );
  XLXI_10_I3_n0035_1_6 : X_LUT4
    generic map(
      INIT => X"C888"
    )
    port map (
      ADR0 => XLXI_10_I3_N8784,
      ADR1 => XLXI_10_I3_acc_c_0_1,
      ADR2 => XLXI_10_I3_N8823,
      ADR3 => XLXI_10_I3_data_x(1),
      O => XLXI_10_I3_data_x_1_GROM
    );
  XLXI_10_I3_data_x_1_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_data_x_1_FROM,
      O => XLXI_10_I3_data_x(1)
    );
  XLXI_10_I3_data_x_1_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_data_x_1_GROM,
      O => CHOICE1874
    );
  XLXI_10_I3_Mmux_data_x_Result_2_Q : X_LUT4
    generic map(
      INIT => X"AAC0"
    )
    port map (
      ADR0 => XLXI_10_I2_data_is_c(2),
      ADR1 => N22134,
      ADR2 => XLXI_10_I4_N9468,
      ADR3 => XLXI_10_I3_n0037,
      O => XLXI_10_I3_data_x_2_FROM
    );
  XLXI_10_I3_n0035_2_6 : X_LUT4
    generic map(
      INIT => X"A8A0"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_2,
      ADR1 => XLXI_10_I3_N8823,
      ADR2 => XLXI_10_I3_N8784,
      ADR3 => XLXI_10_I3_data_x(2),
      O => XLXI_10_I3_data_x_2_GROM
    );
  XLXI_10_I3_data_x_2_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_data_x_2_FROM,
      O => XLXI_10_I3_data_x(2)
    );
  XLXI_10_I3_data_x_2_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_data_x_2_GROM,
      O => CHOICE1918
    );
  XLXI_10_I3_n0035_3_109_SW0 : X_LUT4
    generic map(
      INIT => X"AA20"
    )
    port map (
      ADR0 => XLXI_10_I3_N8818,
      ADR1 => XLXI_10_I2_TD_c(3),
      ADR2 => CHOICE2026,
      ADR3 => CHOICE2006,
      O => XLXI_10_I3_n0035_3_109_SW0_O_FROM
    );
  XLXI_10_I3_n0035_3_47_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"BB88"
    )
    port map (
      ADR0 => N23417,
      ADR1 => CHOICE2015,
      ADR2 => VCC,
      ADR3 => XLXI_10_I3_n0035_3_109_SW0_O,
      O => XLXI_10_I3_n0035_3_109_SW0_O_GROM
    );
  XLXI_10_I3_n0035_3_109_SW0_O_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0035_3_109_SW0_O_FROM,
      O => XLXI_10_I3_n0035_3_109_SW0_O
    );
  XLXI_10_I3_n0035_3_109_SW0_O_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0035_3_109_SW0_O_GROM,
      O => N23935
    );
  XLXI_10_I3_Mmux_data_x_Result_3_Q : X_LUT4
    generic map(
      INIT => X"F808"
    )
    port map (
      ADR0 => N21808,
      ADR1 => XLXI_10_I4_N9468,
      ADR2 => XLXI_10_I3_n0037,
      ADR3 => XLXI_10_I2_data_is_c(3),
      O => XLXI_10_I3_data_x_3_FROM
    );
  XLXI_10_I3_n0035_3_6 : X_LUT4
    generic map(
      INIT => X"C8C0"
    )
    port map (
      ADR0 => XLXI_10_I3_N8823,
      ADR1 => XLXI_10_I3_acc_c_0_3,
      ADR2 => XLXI_10_I3_N8784,
      ADR3 => XLXI_10_I3_data_x(3),
      O => XLXI_10_I3_data_x_3_GROM
    );
  XLXI_10_I3_data_x_3_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_data_x_3_FROM,
      O => XLXI_10_I3_data_x(3)
    );
  XLXI_10_I3_data_x_3_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_data_x_3_GROM,
      O => CHOICE2006
    );
  XLXI_10_I3_Mmux_data_x_Result_0_18 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => N23503,
      ADR1 => N23559,
      ADR2 => N23595,
      ADR3 => N20496,
      O => CHOICE1970_FROM
    );
  XLXI_10_I3_Madd_n0064_inst_lut2_241 : X_LUT4
    generic map(
      INIT => X"5553"
    )
    port map (
      ADR0 => N23475,
      ADR1 => N23473,
      ADR2 => CHOICE1967,
      ADR3 => CHOICE1970,
      O => CHOICE1970_GROM
    );
  CHOICE1970_XUSED : X_BUF
    port map (
      I => CHOICE1970_FROM,
      O => CHOICE1970
    );
  CHOICE1970_YUSED : X_BUF
    port map (
      I => CHOICE1970_GROM,
      O => XLXI_10_I3_Madd_n0064_inst_lut2_24
    );
  XLXI_2_Ker6114_SW0 : X_LUT4
    generic map(
      INIT => X"FF33"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CPU_DADDR_0_OBUF,
      ADR2 => VCC,
      ADR3 => CPU_DADDR_3_OBUF,
      O => XLXI_2_Ker6114_SW0_O_FROM
    );
  XLXI_2_Ker6114 : X_LUT4
    generic map(
      INIT => X"0048"
    )
    port map (
      ADR0 => CPU_DADDR_1_OBUF,
      ADR1 => CPU_DADDR_4_OBUF,
      ADR2 => CPU_DADDR_2_OBUF,
      ADR3 => XLXI_2_Ker6114_SW0_O,
      O => XLXI_2_Ker6114_SW0_O_GROM
    );
  XLXI_2_Ker6114_SW0_O_XUSED : X_BUF
    port map (
      I => XLXI_2_Ker6114_SW0_O_FROM,
      O => XLXI_2_Ker6114_SW0_O
    );
  XLXI_2_Ker6114_SW0_O_YUSED : X_BUF
    port map (
      I => XLXI_2_Ker6114_SW0_O_GROM,
      O => XLXI_2_N6116
    );
  XLXI_10_I3_Mmux_data_x_Result_1_18 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => N23503,
      ADR1 => N23563,
      ADR2 => N23595,
      ADR3 => N20496,
      O => CHOICE1909_FROM
    );
  XLXI_10_I3_Madd_n0064_inst_lut2_251 : X_LUT4
    generic map(
      INIT => X"5553"
    )
    port map (
      ADR0 => N23393,
      ADR1 => N23385,
      ADR2 => CHOICE1906,
      ADR3 => CHOICE1909,
      O => CHOICE1909_GROM
    );
  CHOICE1909_XUSED : X_BUF
    port map (
      I => CHOICE1909_FROM,
      O => CHOICE1909
    );
  CHOICE1909_YUSED : X_BUF
    port map (
      I => CHOICE1909_GROM,
      O => XLXI_10_I3_Madd_n0064_inst_lut2_25
    );
  XLXI_3_Ker66591_SW2 : X_LUT4
    generic map(
      INIT => X"F0E4"
    )
    port map (
      ADR0 => CPU_DADDR_0_OBUF,
      ADR1 => XLXI_3_pwm_period(0),
      ADR2 => CPU_DATA_OUT_0_OBUF,
      ADR3 => XLXI_10_I5_ndwe_c,
      O => XLXI_3_Ker66591_SW2_O_FROM
    );
  XLXI_3_Mmux_n0011_Result_0_1 : X_LUT4
    generic map(
      INIT => X"AAB8"
    )
    port map (
      ADR0 => CPU_DATA_OUT_0_OBUF,
      ADR1 => XLXI_2_N6111,
      ADR2 => XLXI_3_Ker66591_SW2_O,
      ADR3 => N23355,
      O => XLXI_3_Ker66591_SW2_O_GROM
    );
  XLXI_3_Ker66591_SW2_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW2_O_FROM,
      O => XLXI_3_Ker66591_SW2_O
    );
  XLXI_3_Ker66591_SW2_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW2_O_GROM,
      O => XLXI_3_n0011(0)
    );
  XLXI_3_Ker66591_SW3 : X_LUT4
    generic map(
      INIT => X"CCCA"
    )
    port map (
      ADR0 => XLXI_3_pwm_period(1),
      ADR1 => CPU_DATA_OUT_1_OBUF,
      ADR2 => XLXI_10_I5_ndwe_c,
      ADR3 => CPU_DADDR_0_OBUF,
      O => XLXI_3_Ker66591_SW3_O_FROM
    );
  XLXI_3_Mmux_n0011_Result_1_1 : X_LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      ADR0 => CPU_DATA_OUT_1_OBUF,
      ADR1 => N23355,
      ADR2 => XLXI_2_N6111,
      ADR3 => XLXI_3_Ker66591_SW3_O,
      O => XLXI_3_Ker66591_SW3_O_GROM
    );
  XLXI_3_Ker66591_SW3_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW3_O_FROM,
      O => XLXI_3_Ker66591_SW3_O
    );
  XLXI_3_Ker66591_SW3_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW3_O_GROM,
      O => XLXI_3_n0011(1)
    );
  XLXI_3_Ker66591_SW4 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => XLXI_10_I5_ndwe_c,
      ADR1 => CPU_DATA_OUT_2_OBUF,
      ADR2 => CPU_DADDR_0_OBUF,
      ADR3 => XLXI_3_pwm_period(2),
      O => XLXI_3_Ker66591_SW4_O_FROM
    );
  XLXI_3_Mmux_n0011_Result_2_1 : X_LUT4
    generic map(
      INIT => X"F1E0"
    )
    port map (
      ADR0 => XLXI_2_N6111,
      ADR1 => N23355,
      ADR2 => CPU_DATA_OUT_2_OBUF,
      ADR3 => XLXI_3_Ker66591_SW4_O,
      O => XLXI_3_Ker66591_SW4_O_GROM
    );
  XLXI_3_Ker66591_SW4_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW4_O_FROM,
      O => XLXI_3_Ker66591_SW4_O
    );
  XLXI_3_Ker66591_SW4_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW4_O_GROM,
      O => XLXI_3_n0011(2)
    );
  XLXI_3_Ker66591_SW5 : X_LUT4
    generic map(
      INIT => X"AAB8"
    )
    port map (
      ADR0 => CPU_DATA_OUT_3_OBUF,
      ADR1 => XLXI_10_I5_Mmux_daddr_out_Result_0_1_1,
      ADR2 => XLXI_3_pwm_period(3),
      ADR3 => XLXI_10_I5_ndwe_c,
      O => XLXI_3_Ker66591_SW5_O_FROM
    );
  XLXI_3_Mmux_n0011_Result_3_1 : X_LUT4
    generic map(
      INIT => X"CCCA"
    )
    port map (
      ADR0 => XLXI_3_Ker66591_SW5_O,
      ADR1 => CPU_DATA_OUT_3_OBUF,
      ADR2 => XLXI_2_N6111,
      ADR3 => N23355,
      O => XLXI_3_Ker66591_SW5_O_GROM
    );
  XLXI_3_Ker66591_SW5_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW5_O_FROM,
      O => XLXI_3_Ker66591_SW5_O
    );
  XLXI_3_Ker66591_SW5_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW5_O_GROM,
      O => XLXI_3_n0011(3)
    );
  XLXI_3_Ker66591_SW1 : X_LUT4
    generic map(
      INIT => X"F0E2"
    )
    port map (
      ADR0 => XLXI_3_pwm_period(4),
      ADR1 => XLXI_10_I5_ndwe_c,
      ADR2 => XLXI_2_pwm_data_c(0),
      ADR3 => CPU_DADDR_0_OBUF,
      O => XLXI_3_Ker66591_SW1_O_FROM
    );
  XLXI_3_Mmux_n0011_Result_4_1 : X_LUT4
    generic map(
      INIT => X"F1E0"
    )
    port map (
      ADR0 => XLXI_2_N6111,
      ADR1 => N23355,
      ADR2 => XLXI_2_pwm_data_c(0),
      ADR3 => XLXI_3_Ker66591_SW1_O,
      O => XLXI_3_Ker66591_SW1_O_GROM
    );
  XLXI_3_Ker66591_SW1_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW1_O_FROM,
      O => XLXI_3_Ker66591_SW1_O
    );
  XLXI_3_Ker66591_SW1_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW1_O_GROM,
      O => XLXI_3_n0011(4)
    );
  XLXI_3_Ker66591_SW8 : X_LUT4
    generic map(
      INIT => X"F0E4"
    )
    port map (
      ADR0 => XLXI_10_I5_ndwe_c,
      ADR1 => XLXI_3_pwm_period(5),
      ADR2 => XLXI_2_pwm_data_c(1),
      ADR3 => XLXI_10_I5_Mmux_daddr_out_Result_0_1_1,
      O => XLXI_3_Ker66591_SW8_O_FROM
    );
  XLXI_3_Mmux_n0011_Result_5_1 : X_LUT4
    generic map(
      INIT => X"CCCA"
    )
    port map (
      ADR0 => XLXI_3_Ker66591_SW8_O,
      ADR1 => XLXI_2_pwm_data_c(1),
      ADR2 => XLXI_2_N6111,
      ADR3 => N23355,
      O => XLXI_3_Ker66591_SW8_O_GROM
    );
  XLXI_3_Ker66591_SW8_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW8_O_FROM,
      O => XLXI_3_Ker66591_SW8_O
    );
  XLXI_3_Ker66591_SW8_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW8_O_GROM,
      O => XLXI_3_n0011(5)
    );
  XLXI_3_Ker66591_SW9 : X_LUT4
    generic map(
      INIT => X"FE10"
    )
    port map (
      ADR0 => XLXI_10_I5_Mmux_daddr_out_Result_0_1_1,
      ADR1 => XLXI_10_I5_ndwe_c,
      ADR2 => XLXI_3_pwm_period(6),
      ADR3 => XLXI_2_pwm_data_c(2),
      O => XLXI_3_Ker66591_SW9_O_FROM
    );
  XLXI_3_Mmux_n0011_Result_6_1 : X_LUT4
    generic map(
      INIT => X"F1E0"
    )
    port map (
      ADR0 => N23355,
      ADR1 => XLXI_2_N6111,
      ADR2 => XLXI_2_pwm_data_c(2),
      ADR3 => XLXI_3_Ker66591_SW9_O,
      O => XLXI_3_Ker66591_SW9_O_GROM
    );
  XLXI_3_Ker66591_SW9_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW9_O_FROM,
      O => XLXI_3_Ker66591_SW9_O
    );
  XLXI_3_Ker66591_SW9_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW9_O_GROM,
      O => XLXI_3_n0011(6)
    );
  XLXI_3_n0009_1_1 : X_LUT4
    generic map(
      INIT => X"CAC0"
    )
    port map (
      ADR0 => XLXI_10_I4_N9501,
      ADR1 => XLXI_3_pwm_period(1),
      ADR2 => XLXI_3_N6680,
      ADR3 => XLXI_10_I3_acc_c_0_1,
      O => XLXI_3_n0009_1_1_O
    );
  XLXI_3_n0009_0_1 : X_LUT4
    generic map(
      INIT => X"E2C0"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => XLXI_3_N6680,
      ADR2 => XLXI_3_pwm_period(0),
      ADR3 => XLXI_10_I4_N9501,
      O => XLXI_3_n0009_0_1_O
    );
  XLXI_3_n0009_3_1 : X_LUT4
    generic map(
      INIT => X"CCA0"
    )
    port map (
      ADR0 => XLXI_10_I4_N9501,
      ADR1 => XLXI_3_pwm_period(3),
      ADR2 => XLXI_10_I3_acc_c_0_3,
      ADR3 => XLXI_3_N6680,
      O => XLXI_3_n0009_3_1_O
    );
  XLXI_3_n0009_2_1 : X_LUT4
    generic map(
      INIT => X"E4A0"
    )
    port map (
      ADR0 => XLXI_3_N6680,
      ADR1 => XLXI_10_I4_N9501,
      ADR2 => XLXI_3_pwm_period(2),
      ADR3 => XLXI_10_I3_acc_c_0_2,
      O => XLXI_3_n0009_2_1_O
    );
  XLXI_3_n0009_5_1 : X_LUT4
    generic map(
      INIT => X"FC0C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_2_pwm_data_c(1),
      ADR2 => XLXI_3_N6680,
      ADR3 => XLXI_3_pwm_period(5),
      O => XLXI_3_n0009_5_1_O
    );
  XLXI_3_n0009_4_1 : X_LUT4
    generic map(
      INIT => X"CCF0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_3_pwm_period(4),
      ADR2 => XLXI_2_pwm_data_c(0),
      ADR3 => XLXI_3_N6680,
      O => XLXI_3_n0009_4_1_O
    );
  XLXI_3_n0009_7_1 : X_LUT4
    generic map(
      INIT => X"DD88"
    )
    port map (
      ADR0 => XLXI_3_N6680,
      ADR1 => XLXI_3_pwm_period(7),
      ADR2 => VCC,
      ADR3 => XLXI_2_pwm_data_c(3),
      O => XLXI_3_n0009_7_1_O
    );
  XLXI_3_n0009_6_1 : X_LUT4
    generic map(
      INIT => X"AFA0"
    )
    port map (
      ADR0 => XLXI_3_pwm_period(6),
      ADR1 => VCC,
      ADR2 => XLXI_3_N6680,
      ADR3 => XLXI_2_pwm_data_c(2),
      O => XLXI_3_n0009_6_1_O
    );
  XLXI_10_I3_Mmux_data_x_Result_0_13 : X_LUT4
    generic map(
      INIT => X"B800"
    )
    port map (
      ADR0 => CTRL_DATA_IN_0_IBUF,
      ADR1 => XLXI_2_mux_c(0),
      ADR2 => RAM_DATA_OUT(0),
      ADR3 => XLXI_10_I4_N9468,
      O => CHOICE1967_FROM
    );
  XLXI_10_I3_Msub_n0059_inst_lut2_281 : X_LUT4
    generic map(
      INIT => X"F0E4"
    )
    port map (
      ADR0 => CHOICE1970,
      ADR1 => N23473,
      ADR2 => N23475,
      ADR3 => CHOICE1967,
      O => CHOICE1967_GROM
    );
  CHOICE1967_XUSED : X_BUF
    port map (
      I => CHOICE1967_FROM,
      O => CHOICE1967
    );
  CHOICE1967_YUSED : X_BUF
    port map (
      I => CHOICE1967_GROM,
      O => XLXI_10_I3_Msub_n0059_inst_lut2_28
    );
  XLXI_10_I3_Mmux_data_x_Result_1_13 : X_LUT4
    generic map(
      INIT => X"A820"
    )
    port map (
      ADR0 => XLXI_10_I4_N9468,
      ADR1 => XLXI_2_mux_c(0),
      ADR2 => RAM_DATA_OUT(1),
      ADR3 => CTRL_DATA_IN_1_IBUF,
      O => CHOICE1906_FROM
    );
  XLXI_10_I3_Msub_n0059_inst_lut2_291 : X_LUT4
    generic map(
      INIT => X"F0E2"
    )
    port map (
      ADR0 => N23385,
      ADR1 => CHOICE1906,
      ADR2 => N23387,
      ADR3 => CHOICE1909,
      O => CHOICE1906_GROM
    );
  CHOICE1906_XUSED : X_BUF
    port map (
      I => CHOICE1906_FROM,
      O => CHOICE1906
    );
  CHOICE1906_YUSED : X_BUF
    port map (
      I => CHOICE1906_GROM,
      O => XLXI_10_I3_Msub_n0059_inst_lut2_29
    );
  XLXI_10_I2_pc_mux_x_2_2_136 : X_LUT4
    generic map(
      INIT => X"0020"
    )
    port map (
      ADR0 => XLXI_10_I2_N8130,
      ADR1 => N20995,
      ADR2 => XLXI_10_I2_N8107,
      ADR3 => XLXI_10_I2_N8054,
      O => XLXI_10_I2_pc_mux_x_2_2_FROM
    );
  XLXI_10_I1_n0011_0_19_SW0 : X_LUT4
    generic map(
      INIT => X"AAF0"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_2_0,
      ADR1 => VCC,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_0,
      ADR3 => XLXI_10_I2_pc_mux_x_2_2,
      O => XLXI_10_I2_pc_mux_x_2_2_GROM
    );
  XLXI_10_I2_pc_mux_x_2_2_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_pc_mux_x_2_2_FROM,
      O => XLXI_10_I2_pc_mux_x_2_2
    );
  XLXI_10_I2_pc_mux_x_2_2_YUSED : X_BUF
    port map (
      I => XLXI_10_I2_pc_mux_x_2_2_GROM,
      O => N23820
    );
  XLXI_10_I1_n0012_0_19_SW0 : X_LUT4
    generic map(
      INIT => X"F303"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I1_pc(0),
      ADR2 => XLXI_10_I2_pc_mux_x_2_1,
      ADR3 => XLXI_10_I1_stack_addrs_c_1_0,
      O => XLXI_10_I1_stack_addrs_c_0_0_FROM
    );
  XLXI_10_I1_n0012_0_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0012_0_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_0,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0012_0_19_O
    );
  XLXI_10_I1_stack_addrs_c_0_0_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_0_0_FROM,
      O => XLXI_10_I1_n0012_0_19_SW0_O
    );
  XLXI_10_I1_n0012_7_19 : X_LUT4
    generic map(
      INIT => X"E4CC"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_0_7,
      ADR2 => N23840,
      ADR3 => XLXI_10_I2_pc_mux_x_1_1,
      O => XLXI_10_I1_n0012_7_19_O
    );
  XLXI_10_I1_n0011_0_19 : X_LUT4
    generic map(
      INIT => X"ACCC"
    )
    port map (
      ADR0 => N23820,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_0,
      ADR2 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR3 => XLXI_10_I2_pc_mux_x_1_1,
      O => XLXI_10_I1_n0011_0_19_O
    );
  XLXI_10_I1_n0011_1_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_1,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_1_1_FROM
    );
  XLXI_10_I1_n0011_1_19 : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_1_1,
      ADR1 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR2 => XLXI_10_I2_pc_mux_x_1_1,
      ADR3 => XLXI_10_I1_n0011_1_19_SW0_O,
      O => XLXI_10_I1_n0011_1_19_O
    );
  XLXI_10_I1_stack_addrs_c_1_1_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_1_1_FROM,
      O => XLXI_10_I1_n0011_1_19_SW0_O
    );
  XLXI_10_I1_n0011_2_19_SW0 : X_LUT4
    generic map(
      INIT => X"CFC0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_2,
      ADR2 => XLXI_10_I2_pc_mux_x_2_2,
      ADR3 => XLXI_10_I1_stack_addrs_c_0_2,
      O => XLXI_10_I1_stack_addrs_c_1_2_FROM
    );
  XLXI_10_I1_n0011_2_19 : X_LUT4
    generic map(
      INIT => X"EC4C"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_2,
      ADR2 => XLXI_10_I2_pc_mux_x_1_1,
      ADR3 => XLXI_10_I1_n0011_2_19_SW0_O,
      O => XLXI_10_I1_n0011_2_19_O
    );
  XLXI_10_I1_stack_addrs_c_1_2_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_1_2_FROM,
      O => XLXI_10_I1_n0011_2_19_SW0_O
    );
  XLXI_10_I1_n0011_3_19_SW0 : X_LUT4
    generic map(
      INIT => X"CACA"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_0_3,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_3,
      ADR2 => XLXI_10_I2_pc_mux_x_2_2,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_1_3_FROM
    );
  XLXI_10_I1_n0011_3_19 : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_1_3,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR3 => XLXI_10_I1_n0011_3_19_SW0_O,
      O => XLXI_10_I1_n0011_3_19_O
    );
  XLXI_10_I1_stack_addrs_c_1_3_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_1_3_FROM,
      O => XLXI_10_I1_n0011_3_19_SW0_O
    );
  XLXI_10_I1_n0011_4_19_SW0 : X_LUT4
    generic map(
      INIT => X"CCF0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_4,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_4,
      ADR3 => XLXI_10_I2_pc_mux_x_2_2,
      O => XLXI_10_I1_stack_addrs_c_1_4_FROM
    );
  XLXI_10_I1_n0011_4_19 : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_1_1,
      ADR1 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_4,
      ADR3 => XLXI_10_I1_n0011_4_19_SW0_O,
      O => XLXI_10_I1_n0011_4_19_O
    );
  XLXI_10_I1_stack_addrs_c_1_4_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_1_4_FROM,
      O => XLXI_10_I1_n0011_4_19_SW0_O
    );
  XLXI_10_I1_n0010_1_19_SW0 : X_LUT4
    generic map(
      INIT => X"EE22"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_1_1,
      ADR1 => XLXI_10_I2_pc_mux_x_2_2,
      ADR2 => VCC,
      ADR3 => XLXI_10_I1_stack_addrs_c_3_1,
      O => XLXI_10_I1_stack_addrs_c_2_1_FROM
    );
  XLXI_10_I1_n0010_1_19 : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_1_1,
      ADR1 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_1,
      ADR3 => XLXI_10_I1_n0010_1_19_SW0_O,
      O => XLXI_10_I1_n0010_1_19_O
    );
  XLXI_10_I1_stack_addrs_c_2_1_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_2_1_FROM,
      O => XLXI_10_I1_n0010_1_19_SW0_O
    );
  XLXI_2_ctrl_data_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CTRL_DATA_OUT_1_OD,
      CE => XLXI_2_n0039,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => CTRL_DATA_OUT_1_OFF_RST,
      O => XLXI_2_ctrl_data_c(1)
    );
  CTRL_DATA_OUT_1_OFF_RSTOR : X_OR2
    port map (
      I0 => CTRL_DATA_OUT_1_SRMUXNOT,
      I1 => GSR,
      O => CTRL_DATA_OUT_1_OFF_RST
    );
  XLXI_10_I1_n0010_2_19_SW0 : X_LUT4
    generic map(
      INIT => X"DD88"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_2,
      ADR2 => VCC,
      ADR3 => XLXI_10_I1_stack_addrs_c_1_2,
      O => XLXI_10_I1_stack_addrs_c_2_2_FROM
    );
  XLXI_10_I1_n0010_2_19 : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_2_2,
      ADR1 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR2 => XLXI_10_I2_pc_mux_x_1_1,
      ADR3 => XLXI_10_I1_n0010_2_19_SW0_O,
      O => XLXI_10_I1_n0010_2_19_O
    );
  XLXI_10_I1_stack_addrs_c_2_2_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_2_2_FROM,
      O => XLXI_10_I1_n0010_2_19_SW0_O
    );
  XLXI_10_I1_n0010_3_19_SW0 : X_LUT4
    generic map(
      INIT => X"ACAC"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_3_3,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_3,
      ADR2 => XLXI_10_I2_pc_mux_x_2_2,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_2_3_FROM
    );
  XLXI_10_I1_n0010_3_19 : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_1_1,
      ADR1 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_3,
      ADR3 => XLXI_10_I1_n0010_3_19_SW0_O,
      O => XLXI_10_I1_n0010_3_19_O
    );
  XLXI_10_I1_stack_addrs_c_2_3_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_2_3_FROM,
      O => XLXI_10_I1_n0010_3_19_SW0_O
    );
  XLXI_10_I1_n0009_0_1 : X_LUT4
    generic map(
      INIT => X"4E44"
    )
    port map (
      ADR0 => XLXI_10_I1_n0016,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_0,
      ADR2 => XLXI_10_I2_pc_mux_x_2_1,
      ADR3 => XLXI_10_I1_stack_addrs_c_2_0,
      O => XLXI_10_I1_n0009_0_1_O
    );
  XLXI_10_I1_n0010_4_19_SW0 : X_LUT4
    generic map(
      INIT => X"F3C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I2_pc_mux_x_2_2,
      ADR2 => XLXI_10_I1_stack_addrs_c_3_4,
      ADR3 => XLXI_10_I1_stack_addrs_c_1_4,
      O => XLXI_10_I1_stack_addrs_c_2_4_FROM
    );
  XLXI_10_I1_n0010_4_19 : X_LUT4
    generic map(
      INIT => X"ACCC"
    )
    port map (
      ADR0 => XLXI_10_I1_n0010_4_19_SW0_O,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_4,
      ADR2 => XLXI_10_I2_pc_mux_x_1_1,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0010_4_19_O
    );
  XLXI_10_I1_stack_addrs_c_2_4_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_2_4_FROM,
      O => XLXI_10_I1_n0010_4_19_SW0_O
    );
  XLXI_10_I1_n0010_5_19_SW0 : X_LUT4
    generic map(
      INIT => X"B8B8"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_3_5,
      ADR1 => XLXI_10_I2_pc_mux_x_2_2,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_5,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_2_5_FROM
    );
  XLXI_10_I1_n0010_5_19 : X_LUT4
    generic map(
      INIT => X"EC4C"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_1_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_5,
      ADR2 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR3 => XLXI_10_I1_n0010_5_19_SW0_O,
      O => XLXI_10_I1_n0010_5_19_O
    );
  XLXI_10_I1_stack_addrs_c_2_5_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_2_5_FROM,
      O => XLXI_10_I1_n0010_5_19_SW0_O
    );
  XLXI_10_I1_n0009_3_1 : X_LUT4
    generic map(
      INIT => X"2F20"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_2_3,
      ADR1 => XLXI_10_I2_pc_mux_x_2_1,
      ADR2 => XLXI_10_I1_n0016,
      ADR3 => XLXI_10_I1_stack_addrs_c_3_3,
      O => XLXI_10_I1_n0009_3_1_O
    );
  XLXI_10_I1_n0009_2_1 : X_LUT4
    generic map(
      INIT => X"2F20"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_2_2,
      ADR1 => XLXI_10_I2_pc_mux_x_2_1,
      ADR2 => XLXI_10_I1_n0016,
      ADR3 => XLXI_10_I1_stack_addrs_c_3_2,
      O => XLXI_10_I1_n0009_2_1_O
    );
  XLXI_10_I1_n0010_6_19_SW0 : X_LUT4
    generic map(
      INIT => X"EE22"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_1_6,
      ADR1 => XLXI_10_I2_pc_mux_x_2_2,
      ADR2 => VCC,
      ADR3 => XLXI_10_I1_stack_addrs_c_3_6,
      O => XLXI_10_I1_stack_addrs_c_2_6_FROM
    );
  XLXI_10_I1_n0010_6_19 : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_1_1,
      ADR1 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_6,
      ADR3 => XLXI_10_I1_n0010_6_19_SW0_O,
      O => XLXI_10_I1_n0010_6_19_O
    );
  XLXI_10_I1_stack_addrs_c_2_6_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_2_6_FROM,
      O => XLXI_10_I1_n0010_6_19_SW0_O
    );
  XLXI_10_I1_n0009_5_1 : X_LUT4
    generic map(
      INIT => X"22F0"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_2_5,
      ADR1 => XLXI_10_I2_pc_mux_x_2_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_3_5,
      ADR3 => XLXI_10_I1_n0016,
      O => XLXI_10_I1_n0009_5_1_O
    );
  XLXI_10_I1_n0009_4_1 : X_LUT4
    generic map(
      INIT => X"22F0"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_2_4,
      ADR1 => XLXI_10_I2_pc_mux_x_2_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_3_4,
      ADR3 => XLXI_10_I1_n0016,
      O => XLXI_10_I1_n0009_4_1_O
    );
  XLXI_10_I1_n0009_7_1 : X_LUT4
    generic map(
      INIT => X"30AA"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_3_7,
      ADR1 => XLXI_10_I2_pc_mux_x_2_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_7,
      ADR3 => XLXI_10_I1_n0016,
      O => XLXI_10_I1_n0009_7_1_O
    );
  XLXI_10_I1_n0009_6_1 : X_LUT4
    generic map(
      INIT => X"44F0"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_6,
      ADR2 => XLXI_10_I1_stack_addrs_c_3_6,
      ADR3 => XLXI_10_I1_n0016,
      O => XLXI_10_I1_n0009_6_1_O
    );
  XLXI_10_I3_n0035_0_27 : X_LUT4
    generic map(
      INIT => X"CEA0"
    )
    port map (
      ADR0 => XLXI_10_I3_n0053,
      ADR1 => XLXI_10_I3_N8686,
      ADR2 => XLXI_10_I3_acc_c_0_0,
      ADR3 => XLXI_10_I3_data_x(0),
      O => XLXI_10_I3_n0035_0_27_O_FROM
    );
  XLXI_10_I3_n0035_0_41 : X_LUT4
    generic map(
      INIT => X"FFEA"
    )
    port map (
      ADR0 => N23351,
      ADR1 => XLXI_10_I3_n0059(0),
      ADR2 => XLXI_10_I3_n0055,
      ADR3 => XLXI_10_I3_n0035_0_27_O,
      O => XLXI_10_I3_n0035_0_27_O_GROM
    );
  XLXI_10_I3_n0035_0_27_O_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0035_0_27_O_FROM,
      O => XLXI_10_I3_n0035_0_27_O
    );
  XLXI_10_I3_n0035_0_27_O_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0035_0_27_O_GROM,
      O => CHOICE1807
    );
  XLXI_10_I3_Mmux_data_x_Result_0_45 : X_LUT4
    generic map(
      INIT => X"FFC8"
    )
    port map (
      ADR0 => CHOICE1970,
      ADR1 => CHOICE1973,
      ADR2 => CHOICE1967,
      ADR3 => CHOICE1962,
      O => XLXI_10_I3_data_x_0_FROM
    );
  XLXI_10_I3_n0035_0_88 : X_LUT4
    generic map(
      INIT => X"B090"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(2),
      ADR1 => XLXI_10_I2_TD_c(1),
      ADR2 => CHOICE1816,
      ADR3 => XLXI_10_I3_data_x(0),
      O => XLXI_10_I3_data_x_0_GROM
    );
  XLXI_10_I3_data_x_0_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_data_x_0_FROM,
      O => XLXI_10_I3_data_x(0)
    );
  XLXI_10_I3_data_x_0_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_data_x_0_GROM,
      O => CHOICE1817
    );
  XLXI_10_I3_n0035_4_11_SW1 : X_LUT4
    generic map(
      INIT => X"E2AA"
    )
    port map (
      ADR0 => N23927,
      ADR1 => XLXI_10_I3_n0048,
      ADR2 => N23405,
      ADR3 => XLXI_10_I3_n0058(4),
      O => XLXI_10_I3_acc_c_0_4_FROM
    );
  XLXI_10_I3_n0035_4_96 : X_LUT4
    generic map(
      INIT => X"FEF2"
    )
    port map (
      ADR0 => N23575,
      ADR1 => XLXI_10_I3_n0059(4),
      ADR2 => CHOICE1849,
      ADR3 => XLXI_10_I3_n0035_4_11_SW1_O,
      O => XLXI_10_I3_n0035_4_96_O
    );
  XLXI_10_I3_acc_c_0_4_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_acc_c_0_4_FROM,
      O => XLXI_10_I3_n0035_4_11_SW1_O
    );
  XLXI_10_I3_acc_c_0_4_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I3_acc_c_0_4_SRMUX_OUTPUTNOT
    );
  XLXI_10_I3_Ker883335 : X_LUT4
    generic map(
      INIT => X"BABA"
    )
    port map (
      ADR0 => CHOICE1309,
      ADR1 => XLXI_10_I2_TD_c(1),
      ADR2 => CHOICE1318,
      ADR3 => VCC,
      O => XLXI_10_I3_N8835_FROM
    );
  XLXI_10_I3_Ker87821 : X_LUT4
    generic map(
      INIT => X"FECC"
    )
    port map (
      ADR0 => XLXI_10_I3_n0054,
      ADR1 => XLXI_10_I3_N8835,
      ADR2 => XLXI_10_I3_n0045,
      ADR3 => XLXI_10_I3_N8655,
      O => XLXI_10_I3_N8835_GROM
    );
  XLXI_10_I3_N8835_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_N8835_FROM,
      O => XLXI_10_I3_N8835
    );
  XLXI_10_I3_N8835_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_N8835_GROM,
      O => XLXI_10_I3_N8784
    );
  XLXI_2_Ker61091 : X_LUT4
    generic map(
      INIT => X"F1E0"
    )
    port map (
      ADR0 => XLXI_10_ndre_int,
      ADR1 => XLXI_10_I4_N9483,
      ADR2 => N23605,
      ADR3 => N23603,
      O => XLXI_2_N6111_FROM
    );
  XLXI_2_Ker60951 : X_LUT4
    generic map(
      INIT => X"FF0F"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_10_I5_Mmux_daddr_out_Result_0_1_1,
      ADR3 => XLXI_2_N6111,
      O => XLXI_2_N6111_GROM
    );
  XLXI_2_N6111_XUSED : X_BUF
    port map (
      I => XLXI_2_N6111_FROM,
      O => XLXI_2_N6111
    );
  XLXI_2_N6111_YUSED : X_BUF
    port map (
      I => XLXI_2_N6111_GROM,
      O => XLXI_2_N6097
    );
  XLXI_10_I3_n0035_0_107_SW0 : X_LUT4
    generic map(
      INIT => X"C8C0"
    )
    port map (
      ADR0 => XLXI_10_I3_N8655,
      ADR1 => XLXI_10_I3_N8818,
      ADR2 => CHOICE1835,
      ADR3 => CHOICE1817,
      O => XLXI_10_I3_acc_c_0_0_FROM
    );
  XLXI_10_I3_n0035_0_220 : X_LUT4
    generic map(
      INIT => X"EFEA"
    )
    port map (
      ADR0 => CHOICE1795,
      ADR1 => N23411,
      ADR2 => CHOICE1807,
      ADR3 => XLXI_10_I3_n0035_0_107_SW0_O,
      O => XLXI_10_I3_n0035_0_220_O
    );
  XLXI_10_I3_acc_c_0_0_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_acc_c_0_0_FROM,
      O => XLXI_10_I3_n0035_0_107_SW0_O
    );
  XLXI_10_I3_acc_c_0_0_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I3_acc_c_0_0_SRMUX_OUTPUTNOT
    );
  XLXI_10_I3_n0035_1_47 : X_LUT4
    generic map(
      INIT => X"FFEC"
    )
    port map (
      ADR0 => XLXI_10_I3_n0064(1),
      ADR1 => CHOICE1883,
      ADR2 => XLXI_10_I3_n0048,
      ADR3 => CHOICE1875,
      O => XLXI_10_I3_acc_c_0_1_FROM
    );
  XLXI_10_I3_n0035_1_145 : X_LUT4
    generic map(
      INIT => X"FAEE"
    )
    port map (
      ADR0 => CHOICE1871,
      ADR1 => N23427,
      ADR2 => N23429,
      ADR3 => XLXI_10_I3_n0035_1_47_O,
      O => XLXI_10_I3_n0035_1_145_O
    );
  XLXI_10_I3_acc_c_0_1_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_acc_c_0_1_FROM,
      O => XLXI_10_I3_n0035_1_47_O
    );
  XLXI_10_I3_acc_c_0_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I3_acc_c_0_1_SRMUX_OUTPUTNOT
    );
  XLXI_10_I3_n0035_2_47_SW0 : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => N23931,
      ADR1 => N23423,
      ADR2 => XLXI_10_I3_n0048,
      ADR3 => XLXI_10_I3_n0064(2),
      O => XLXI_10_I3_acc_c_0_2_FROM
    );
  XLXI_10_I3_n0035_2_145 : X_LUT4
    generic map(
      INIT => X"FBEA"
    )
    port map (
      ADR0 => CHOICE1915,
      ADR1 => CHOICE1919,
      ADR2 => N23423,
      ADR3 => XLXI_10_I3_n0035_2_47_SW0_O,
      O => XLXI_10_I3_n0035_2_145_O
    );
  XLXI_10_I3_acc_c_0_2_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_acc_c_0_2_FROM,
      O => XLXI_10_I3_n0035_2_47_SW0_O
    );
  XLXI_10_I3_acc_c_0_2_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I3_acc_c_0_2_SRMUX_OUTPUTNOT
    );
  XLXI_10_I3_n0035_3_47_SW0 : X_LUT4
    generic map(
      INIT => X"E2AA"
    )
    port map (
      ADR0 => N23935,
      ADR1 => XLXI_10_I3_n0064(3),
      ADR2 => N23417,
      ADR3 => XLXI_10_I3_n0048,
      O => XLXI_10_I3_acc_c_0_3_FROM
    );
  XLXI_10_I3_n0035_3_145 : X_LUT4
    generic map(
      INIT => X"EFEA"
    )
    port map (
      ADR0 => CHOICE2003,
      ADR1 => N23417,
      ADR2 => CHOICE2007,
      ADR3 => XLXI_10_I3_n0035_3_47_SW0_O,
      O => XLXI_10_I3_n0035_3_145_O
    );
  XLXI_10_I3_acc_c_0_3_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_acc_c_0_3_FROM,
      O => XLXI_10_I3_n0035_3_47_SW0_O
    );
  XLXI_10_I3_acc_c_0_3_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I3_acc_c_0_3_SRMUX_OUTPUTNOT
    );
  XLXI_3_Ker66591_SW15 : X_LUT4
    generic map(
      INIT => X"3237"
    )
    port map (
      ADR0 => N23355,
      ADR1 => XLXI_3_pwm_low(1),
      ADR2 => CPU_DADDR_0_OBUF,
      ADR3 => N23947,
      O => XLXI_3_Ker66591_SW15_O_FROM
    );
  XLXI_3_Msub_n0005_inst_lut2_91 : X_LUT4
    generic map(
      INIT => X"95A6"
    )
    port map (
      ADR0 => CPU_DATA_OUT_1_OBUF,
      ADR1 => XLXI_2_N6111,
      ADR2 => XLXI_3_pwm_low(1),
      ADR3 => XLXI_3_Ker66591_SW15_O,
      O => XLXI_3_Ker66591_SW15_O_GROM
    );
  XLXI_3_Ker66591_SW15_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW15_O_FROM,
      O => XLXI_3_Ker66591_SW15_O
    );
  XLXI_3_Ker66591_SW15_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW15_O_GROM,
      O => XLXI_3_Msub_n0005_inst_lut2_9
    );
  XLXI_2_Ker6121 : X_LUT4
    generic map(
      INIT => X"0100"
    )
    port map (
      ADR0 => CPU_DADDR_1_OBUF,
      ADR1 => CPU_DADDR_3_OBUF,
      ADR2 => N20289,
      ADR3 => CPU_DADDR_4_OBUF,
      O => XLXI_2_mux_c_0_FROM
    );
  XLXI_2_n00391 : X_LUT4
    generic map(
      INIT => X"5500"
    )
    port map (
      ADR0 => XLXI_10_I5_ndwe_c,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_2_Ker6121_O,
      O => XLXI_2_mux_c_0_GROM
    );
  XLXI_2_mux_c_0_XUSED : X_BUF
    port map (
      I => XLXI_2_mux_c_0_FROM,
      O => XLXI_2_Ker6121_O
    );
  XLXI_2_mux_c_0_YUSED : X_BUF
    port map (
      I => XLXI_2_mux_c_0_GROM,
      O => XLXI_2_n0039
    );
  XLXI_2_mux_c_0_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_2_mux_c_0_SRMUX_OUTPUTNOT
    );
  XLXI_10_I2_Ker81051 : X_LUT4
    generic map(
      INIT => X"2200"
    )
    port map (
      ADR0 => XLXN_8(7),
      ADR1 => XLXN_8(5),
      ADR2 => VCC,
      ADR3 => XLXN_8(6),
      O => XLXI_10_I2_N8107_FROM
    );
  XLXI_10_I2_pc_mux_x_1_SW0 : X_LUT4
    generic map(
      INIT => X"CDCC"
    )
    port map (
      ADR0 => XLXN_8(4),
      ADR1 => XLXN_8(3),
      ADR2 => XLXN_8(0),
      ADR3 => XLXI_10_I2_N8107,
      O => XLXI_10_I2_N8107_GROM
    );
  XLXI_10_I2_N8107_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_N8107_FROM,
      O => XLXI_10_I2_N8107
    );
  XLXI_10_I2_N8107_YUSED : X_BUF
    port map (
      I => XLXI_10_I2_N8107_GROM,
      O => N21055
    );
  XLXI_10_I2_data_is_c_3_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_data_is_c_3_SRMUX_OUTPUTNOT
    );
  XLXI_10_I3_n0035_2_0 : X_LUT4
    generic map(
      INIT => X"A0A0"
    )
    port map (
      ADR0 => XLXI_10_I3_n0062,
      ADR1 => VCC,
      ADR2 => XLXI_10_I3_acc_c_0_2,
      ADR3 => VCC,
      O => CHOICE1915_FROM
    );
  XLXI_10_I3_n0035_0_0 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_10_I3_n0062,
      ADR3 => XLXI_10_I3_acc_c_0_0,
      O => CHOICE1915_GROM
    );
  CHOICE1915_XUSED : X_BUF
    port map (
      I => CHOICE1915_FROM,
      O => CHOICE1915
    );
  CHOICE1915_YUSED : X_BUF
    port map (
      I => CHOICE1915_GROM,
      O => CHOICE1795
    );
  XLXI_10_I3_Ker86731 : X_LUT4
    generic map(
      INIT => X"003C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I2_TD_c(1),
      ADR2 => XLXI_10_I2_TD_c(2),
      ADR3 => XLXI_10_I2_TD_c(0),
      O => XLXI_10_I3_N8675_FROM
    );
  XLXI_10_I3_n0035_1_7 : X_LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(2),
      ADR1 => XLXI_10_I3_n0059(1),
      ADR2 => XLXI_10_I2_TD_c(0),
      ADR3 => XLXI_10_I2_TD_c(1),
      O => XLXI_10_I3_N8675_GROM
    );
  XLXI_10_I3_N8675_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_N8675_FROM,
      O => XLXI_10_I3_N8675
    );
  XLXI_10_I3_N8675_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_N8675_GROM,
      O => CHOICE1875
    );
  XLXI_10_I3_n0035_4_0 : X_LUT4
    generic map(
      INIT => X"A0A0"
    )
    port map (
      ADR0 => XLXI_10_I3_n0062,
      ADR1 => VCC,
      ADR2 => XLXI_10_I3_acc_c_0_4,
      ADR3 => VCC,
      O => CHOICE1849_FROM
    );
  XLXI_10_I3_n0035_3_0 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_I3_n0062,
      ADR1 => XLXI_10_I3_acc_c_0_3,
      ADR2 => VCC,
      ADR3 => VCC,
      O => CHOICE1849_GROM
    );
  CHOICE1849_XUSED : X_BUF
    port map (
      I => CHOICE1849_FROM,
      O => CHOICE1849
    );
  CHOICE1849_YUSED : X_BUF
    port map (
      I => CHOICE1849_GROM,
      O => CHOICE2003
    );
  XLXI_10_I3_Ker86841 : X_LUT4
    generic map(
      INIT => X"A500"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(2),
      ADR1 => VCC,
      ADR2 => XLXI_10_I2_TD_c(0),
      ADR3 => XLXI_10_I2_TD_c(1),
      O => XLXI_10_I3_N8686_FROM
    );
  XLXI_10_I3_n0035_2_7 : X_LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      ADR0 => XLXI_10_I3_n0059(2),
      ADR1 => XLXI_10_I2_TD_c(2),
      ADR2 => XLXI_10_I2_TD_c(0),
      ADR3 => XLXI_10_I2_TD_c(1),
      O => XLXI_10_I3_N8686_GROM
    );
  XLXI_10_I3_N8686_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_N8686_FROM,
      O => XLXI_10_I3_N8686
    );
  XLXI_10_I3_N8686_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_N8686_GROM,
      O => CHOICE1919
    );
  XLXI_10_I3_skip_l61 : X_LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(1),
      ADR1 => XLXI_10_I3_acc_c_0_4,
      ADR2 => XLXI_10_I2_TD_c(0),
      ADR3 => XLXI_10_I2_TD_c(2),
      O => CHOICE1994_FROM
    );
  XLXI_10_I3_n0035_3_7 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(1),
      ADR1 => XLXI_10_I2_TD_c(0),
      ADR2 => XLXI_10_I3_n0059(3),
      ADR3 => XLXI_10_I2_TD_c(2),
      O => CHOICE1994_GROM
    );
  CHOICE1994_XUSED : X_BUF
    port map (
      I => CHOICE1994_FROM,
      O => CHOICE1994
    );
  CHOICE1994_YUSED : X_BUF
    port map (
      I => CHOICE1994_GROM,
      O => CHOICE2007
    );
  XLXI_10_I3_n0035_0_179 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => N23723,
      ADR1 => XLXI_10_I3_acc_c_0_0,
      ADR2 => CHOICE1833,
      ADR3 => XLXI_10_I3_N8835,
      O => CHOICE1835_FROM
    );
  XLXI_10_I3_n0035_4_6 : X_LUT4
    generic map(
      INIT => X"C8C0"
    )
    port map (
      ADR0 => XLXI_10_I3_n0045,
      ADR1 => XLXI_10_I3_acc_c_0_4,
      ADR2 => XLXI_10_I3_N8835,
      ADR3 => XLXI_10_I3_N8655,
      O => CHOICE1835_GROM
    );
  CHOICE1835_XUSED : X_BUF
    port map (
      I => CHOICE1835_FROM,
      O => CHOICE1835
    );
  CHOICE1835_YUSED : X_BUF
    port map (
      I => CHOICE1835_GROM,
      O => CHOICE1852
    );
  XLXI_10_I1_n0011_7_19_SW0 : X_LUT4
    generic map(
      INIT => X"CACA"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_0_7,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_7,
      ADR2 => XLXI_10_I2_pc_mux_x_2_2,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_1_7_FROM
    );
  XLXI_10_I1_n0011_7_19 : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_1_7,
      ADR1 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR2 => XLXI_10_I2_pc_mux_x_1_1,
      ADR3 => N23800,
      O => XLXI_10_I1_n0011_7_19_O
    );
  XLXI_10_I1_stack_addrs_c_1_7_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_1_7_FROM,
      O => N23800
    );
  XLXI_10_I3_n0035_0_81 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_10_I2_TD_c(0),
      ADR3 => XLXI_10_I3_acc_c_0_0,
      O => CHOICE1816_FROM
    );
  XLXI_10_I3_n0035_0_41_SW0 : X_LUT4
    generic map(
      INIT => X"4488"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => XLXI_10_I3_n0048,
      ADR2 => VCC,
      ADR3 => XLXI_10_I3_data_x(0),
      O => CHOICE1816_GROM
    );
  CHOICE1816_XUSED : X_BUF
    port map (
      I => CHOICE1816_FROM,
      O => CHOICE1816
    );
  CHOICE1816_YUSED : X_BUF
    port map (
      I => CHOICE1816_GROM,
      O => N23351
    );
  XLXI_10_I1_iaddr_x_7_31_SW0 : X_LUT4
    generic map(
      INIT => X"A00C"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_0_7,
      ADR1 => XLXI_10_I1_n0013(7),
      ADR2 => XLXI_10_pc_mux(2),
      ADR3 => XLXI_10_pc_mux(1),
      O => N23903_FROM
    );
  XLXI_10_I1_iaddr_x_2_31_SW0 : X_LUT4
    generic map(
      INIT => X"8580"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(2),
      ADR1 => XLXI_10_I1_stack_addrs_c_0_2,
      ADR2 => XLXI_10_pc_mux(1),
      ADR3 => XLXI_10_I1_n0013(2),
      O => N23903_GROM
    );
  N23903_XUSED : X_BUF
    port map (
      I => N23903_FROM,
      O => N23903
    );
  N23903_YUSED : X_BUF
    port map (
      I => N23903_GROM,
      O => N23883
    );
  XLXI_10_I3_Msub_n0059_inst_lut2_301 : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => XLXI_10_I4_N9468,
      ADR1 => N22134,
      ADR2 => N23397,
      ADR3 => N23399,
      O => XLXI_10_I3_Msub_n0059_inst_lut2_30_GROM
    );
  XLXI_10_I3_Msub_n0059_inst_lut2_30_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_Msub_n0059_inst_lut2_30_GROM,
      O => XLXI_10_I3_Msub_n0059_inst_lut2_30
    );
  XLXI_10_I5_Mmux_daddr_out_Result_4_1_SW1 : X_LUT4
    generic map(
      INIT => X"EEFF"
    )
    port map (
      ADR0 => XLXI_10_I5_daddr_c(4),
      ADR1 => XLXI_10_I5_ndwe_c,
      ADR2 => VCC,
      ADR3 => NRESET_IBUF,
      O => N23525_FROM
    );
  XLXI_10_I4_ndre_x1_SW0 : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_10_I5_daddr_c(4),
      ADR1 => NRESET_IBUF,
      ADR2 => XLXI_10_I4_nreset_v(1),
      ADR3 => XLXN_8(8),
      O => N23525_GROM
    );
  N23525_XUSED : X_BUF
    port map (
      I => N23525_FROM,
      O => N23525
    );
  N23525_YUSED : X_BUF
    port map (
      I => N23525_GROM,
      O => N23359
    );
  XLXI_10_I4_ndre_x1_SW1 : X_LUT4
    generic map(
      INIT => X"F780"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => XLXN_8(5),
      ADR3 => XLXI_10_I5_daddr_c(1),
      O => N23363_FROM
    );
  XLXI_10_I5_Mmux_daddr_out_Result_1_1 : X_LUT4
    generic map(
      INIT => X"F0E4"
    )
    port map (
      ADR0 => XLXI_10_I4_N9483,
      ADR1 => N23363,
      ADR2 => XLXI_10_I5_daddr_c(1),
      ADR3 => XLXI_10_ndre_int,
      O => N23363_GROM
    );
  N23363_XUSED : X_BUF
    port map (
      I => N23363_FROM,
      O => N23363
    );
  N23363_YUSED : X_BUF
    port map (
      I => N23363_GROM,
      O => CPU_DADDR_1_OBUF
    );
  XLXI_10_I4_ndre_x1_SW2 : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => XLXI_10_I5_daddr_c(3),
      ADR1 => NRESET_IBUF,
      ADR2 => XLXI_10_I4_nreset_v(1),
      ADR3 => XLXN_8(7),
      O => N23367_FROM
    );
  XLXI_10_I5_Mmux_daddr_out_Result_3_1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => XLXI_10_ndre_int,
      ADR1 => XLXI_10_I5_daddr_c(3),
      ADR2 => XLXI_10_I4_N9483,
      ADR3 => N23367,
      O => N23367_GROM
    );
  N23367_XUSED : X_BUF
    port map (
      I => N23367_FROM,
      O => N23367
    );
  N23367_YUSED : X_BUF
    port map (
      I => N23367_GROM,
      O => CPU_DADDR_3_OBUF
    );
  XLXI_3_Ker66591_SW7 : X_LUT4
    generic map(
      INIT => X"807F"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      ADR3 => XLXI_3_pwm_low(0),
      O => N23499_FROM
    );
  XLXI_10_I4_ndre_x1_SW3 : X_LUT4
    generic map(
      INIT => X"F780"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => XLXN_8(4),
      ADR3 => XLXI_10_I5_daddr_c(0),
      O => N23499_GROM
    );
  N23499_XUSED : X_BUF
    port map (
      I => N23499_FROM,
      O => N23499
    );
  N23499_YUSED : X_BUF
    port map (
      I => N23499_GROM,
      O => N23371
    );
  XLXI_10_I4_ndre_x1_SW5 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_10_I5_daddr_c(2),
      ADR3 => NRESET_IBUF,
      O => N23493_FROM
    );
  XLXI_10_I4_ndre_x1_SW4 : X_LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXI_10_I5_daddr_c(2),
      ADR2 => XLXI_10_I4_nreset_v(1),
      ADR3 => XLXN_8(6),
      O => N23493_GROM
    );
  N23493_XUSED : X_BUF
    port map (
      I => N23493_FROM,
      O => N23493
    );
  N23493_YUSED : X_BUF
    port map (
      I => N23493_GROM,
      O => N23491
    );
  XLXI_3_pwm_low_5_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_low_5_SRMUX_OUTPUTNOT
    );
  XLXI_10_I4_ndre_x1_SW6 : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => XLXI_10_I5_daddr_c(2),
      ADR1 => XLXN_8(6),
      ADR2 => XLXI_10_I4_nreset_v(1),
      ADR3 => NRESET_IBUF,
      O => N23519_FROM
    );
  XLXI_10_I5_Mmux_daddr_out_Result_2_1 : X_LUT4
    generic map(
      INIT => X"AAB8"
    )
    port map (
      ADR0 => XLXI_10_I5_daddr_c(2),
      ADR1 => XLXI_10_ndre_int,
      ADR2 => N23519,
      ADR3 => XLXI_10_I4_N9483,
      O => N23519_GROM
    );
  N23519_XUSED : X_BUF
    port map (
      I => N23519_FROM,
      O => N23519
    );
  N23519_YUSED : X_BUF
    port map (
      I => N23519_GROM,
      O => CPU_DADDR_2_OBUF
    );
  XLXI_3_pwm_low_7_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_low_7_SRMUX_OUTPUTNOT
    );
  XLXI_10_I2_TD_x_0_2 : X_LUT4
    generic map(
      INIT => X"FA00"
    )
    port map (
      ADR0 => XLXN_8(2),
      ADR1 => VCC,
      ADR2 => XLXN_8(1),
      ADR3 => XLXN_8(0),
      O => CHOICE1601_FROM
    );
  XLXI_10_I2_pc_mux_x_0_13 : X_LUT4
    generic map(
      INIT => X"FE10"
    )
    port map (
      ADR0 => XLXN_8(2),
      ADR1 => XLXN_8(1),
      ADR2 => XLXN_8(0),
      ADR3 => XLXN_8(3),
      O => CHOICE1601_GROM
    );
  CHOICE1601_XUSED : X_BUF
    port map (
      I => CHOICE1601_FROM,
      O => CHOICE1601
    );
  CHOICE1601_YUSED : X_BUF
    port map (
      I => CHOICE1601_GROM,
      O => CHOICE1559
    );
  XLXI_10_I2_TC_x_0_SW0 : X_LUT4
    generic map(
      INIT => X"CCCE"
    )
    port map (
      ADR0 => XLXI_10_I2_N8107,
      ADR1 => XLXN_8(0),
      ADR2 => XLXN_8(3),
      ADR3 => XLXN_8(4),
      O => XLXI_10_I2_TC_c_0_FROM
    );
  XLXI_10_I2_TC_x_0_Q : X_LUT4
    generic map(
      INIT => X"2A08"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXI_10_I2_N8054,
      ADR2 => XLXN_8(3),
      ADR3 => N18981,
      O => XLXI_10_I2_TC_x(0)
    );
  XLXI_10_I2_TC_c_0_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_TC_c_0_FROM,
      O => N18981
    );
  XLXI_10_I2_TC_c_0_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_TC_c_0_SRMUX_OUTPUTNOT
    );
  XLXI_10_I2_ndwe_x1 : X_LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      ADR0 => XLXI_10_I2_N8054,
      ADR1 => XLXN_8(3),
      ADR2 => XLXI_10_I2_N8098,
      ADR3 => XLXN_8(0),
      O => XLXI_10_I5_ndwe_c_FROM
    );
  XLXI_10_I4_ndwe_x1 : X_LUT4
    generic map(
      INIT => X"FFBF"
    )
    port map (
      ADR0 => XLXI_10_I4_N9483,
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      ADR3 => XLXI_10_ndwe_int,
      O => XLXI_10_nadwe_out
    );
  XLXI_10_I5_ndwe_c_XUSED : X_BUF
    port map (
      I => XLXI_10_I5_ndwe_c_FROM,
      O => XLXI_10_ndwe_int
    );
  XLXI_10_I5_ndwe_c_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I5_ndwe_c_SRMUX_OUTPUTNOT
    );
  XLXI_10_I4_n00441 : X_LUT4
    generic map(
      INIT => X"BBBB"
    )
    port map (
      ADR0 => XLXI_10_I4_ipage_we_c,
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I4_n0044_GROM
    );
  XLXI_10_I4_n0044_YUSED : X_BUF
    port map (
      I => XLXI_10_I4_n0044_GROM,
      O => XLXI_10_I4_n0044
    );
  XLXI_10_I2_Ker8036_SW1 : X_LUT4
    generic map(
      INIT => X"AFFF"
    )
    port map (
      ADR0 => XLXI_10_I2_skip_c,
      ADR1 => VCC,
      ADR2 => XLXI_10_I2_TC_c(1),
      ADR3 => XLXI_10_I2_TC_c(0),
      O => N23848_FROM
    );
  XLXI_10_I2_Ker8036 : X_LUT4
    generic map(
      INIT => X"FAFB"
    )
    port map (
      ADR0 => N23848,
      ADR1 => XLXN_8(2),
      ADR2 => XLXI_10_I2_TC_c(2),
      ADR3 => XLXN_8(1),
      O => N23848_GROM
    );
  N23848_XUSED : X_BUF
    port map (
      I => N23848_FROM,
      O => N23848
    );
  N23848_YUSED : X_BUF
    port map (
      I => N23848_GROM,
      O => XLXI_10_I2_N8038
    );
  XLXI_10_I3_n0035_3_33 : X_LUT4
    generic map(
      INIT => X"DA88"
    )
    port map (
      ADR0 => XLXI_10_I3_data_x(3),
      ADR1 => XLXI_10_I3_N8686,
      ADR2 => XLXI_10_I3_acc_c_0_3,
      ADR3 => XLXI_10_I3_n0053,
      O => CHOICE2015_FROM
    );
  XLXI_10_I3_n0035_2_33 : X_LUT4
    generic map(
      INIT => X"B8C8"
    )
    port map (
      ADR0 => XLXI_10_I3_N8686,
      ADR1 => XLXI_10_I3_data_x(2),
      ADR2 => XLXI_10_I3_n0053,
      ADR3 => XLXI_10_I3_acc_c_0_2,
      O => CHOICE2015_GROM
    );
  CHOICE2015_XUSED : X_BUF
    port map (
      I => CHOICE2015_FROM,
      O => CHOICE2015
    );
  CHOICE2015_YUSED : X_BUF
    port map (
      I => CHOICE2015_GROM,
      O => CHOICE1927
    );
  XLXI_10_I3_Ker883322 : X_LUT4
    generic map(
      INIT => X"0343"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(1),
      ADR1 => XLXI_10_I2_TD_c(0),
      ADR2 => XLXI_10_I2_TD_c(2),
      ADR3 => XLXI_10_I2_TC_c(0),
      O => CHOICE1318_FROM
    );
  XLXI_10_I3_Ker87031 : X_LUT4
    generic map(
      INIT => X"0F00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_10_I2_TD_c(2),
      ADR3 => XLXI_10_I2_TD_c(0),
      O => CHOICE1318_GROM
    );
  CHOICE1318_XUSED : X_BUF
    port map (
      I => CHOICE1318_FROM,
      O => CHOICE1318
    );
  CHOICE1318_YUSED : X_BUF
    port map (
      I => CHOICE1318_GROM,
      O => XLXI_10_I3_N8705
    );
  XLXI_10_I3_Ker86531 : X_LUT4
    generic map(
      INIT => X"0FF0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_10_I2_TC_c(1),
      ADR3 => XLXI_10_I2_TC_c(0),
      O => XLXI_10_I3_N8655_FROM
    );
  XLXI_10_I3_Ker88211 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(2),
      ADR1 => XLXI_10_I2_TD_c(1),
      ADR2 => XLXI_10_I2_TD_c(0),
      ADR3 => XLXI_10_I3_N8655,
      O => XLXI_10_I3_N8655_GROM
    );
  XLXI_10_I3_N8655_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_N8655_FROM,
      O => XLXI_10_I3_N8655
    );
  XLXI_10_I3_N8655_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_N8655_GROM,
      O => XLXI_10_I3_N8823
    );
  XLXI_10_I3_Mmux_data_x_Result_1_0 : X_LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      ADR0 => XLXI_10_I2_data_is_c(1),
      ADR1 => XLXI_10_I2_TC_c(1),
      ADR2 => XLXI_10_I2_TC_c(2),
      ADR3 => XLXI_10_I2_TC_c(0),
      O => CHOICE1901_FROM
    );
  XLXI_10_I3_Ker88161 : X_LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      ADR0 => XLXI_10_I2_valid_c,
      ADR1 => XLXI_10_I3_nreset_v(1),
      ADR2 => XLXI_10_I2_TC_c(2),
      ADR3 => XLXI_10_I3_nreset_v(0),
      O => CHOICE1901_GROM
    );
  CHOICE1901_XUSED : X_BUF
    port map (
      I => CHOICE1901_FROM,
      O => CHOICE1901
    );
  CHOICE1901_YUSED : X_BUF
    port map (
      I => CHOICE1901_GROM,
      O => XLXI_10_I3_N8818
    );
  XLXI_10_I2_TC_x_2_SW1 : X_LUT4
    generic map(
      INIT => X"FFAF"
    )
    port map (
      ADR0 => XLXN_8(2),
      ADR1 => VCC,
      ADR2 => NRESET_IBUF,
      ADR3 => XLXN_8(1),
      O => XLXI_10_I2_TC_c_2_FROM
    );
  XLXI_10_I2_TC_x_2_Q : X_LUT4
    generic map(
      INIT => X"00AE"
    )
    port map (
      ADR0 => XLXN_8(3),
      ADR1 => XLXI_10_I2_N8107,
      ADR2 => XLXN_8(0),
      ADR3 => N23844,
      O => XLXI_10_I2_TC_x(2)
    );
  XLXI_10_I2_TC_c_2_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_TC_c_2_FROM,
      O => N23844
    );
  XLXI_10_I2_TC_c_2_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_TC_c_2_SRMUX_OUTPUTNOT
    );
  XLXI_3_Ker66591_SW11_SW0 : X_LUT4
    generic map(
      INIT => X"CFC0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_3_pwm_low(5),
      ADR2 => XLXI_10_I5_ndwe_c,
      ADR3 => XLXI_3_pwm_period(5),
      O => N23939_FROM
    );
  XLXI_3_Ker66591_SW10_SW0 : X_LUT4
    generic map(
      INIT => X"F0CC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_3_pwm_period(6),
      ADR2 => XLXI_3_pwm_low(6),
      ADR3 => XLXI_10_I5_ndwe_c,
      O => N23939_GROM
    );
  N23939_XUSED : X_BUF
    port map (
      I => N23939_FROM,
      O => N23939
    );
  N23939_YUSED : X_BUF
    port map (
      I => N23939_GROM,
      O => N23919
    );
  XLXI_10_I1_iaddr_x_6_31_SW0 : X_LUT4
    generic map(
      INIT => X"A00C"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_0_6,
      ADR1 => XLXI_10_I1_n0013(6),
      ADR2 => XLXI_10_pc_mux(2),
      ADR3 => XLXI_10_pc_mux(1),
      O => N23899_FROM
    );
  XLXI_10_I1_iaddr_x_4_31_SW0 : X_LUT4
    generic map(
      INIT => X"A044"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(2),
      ADR1 => XLXI_10_I1_n0013(4),
      ADR2 => XLXI_10_I1_stack_addrs_c_0_4,
      ADR3 => XLXI_10_pc_mux(1),
      O => N23899_GROM
    );
  N23899_XUSED : X_BUF
    port map (
      I => N23899_FROM,
      O => N23899
    );
  N23899_YUSED : X_BUF
    port map (
      I => N23899_GROM,
      O => N23891
    );
  XLXI_3_Ker66591_SW15_SW0 : X_LUT4
    generic map(
      INIT => X"F0AA"
    )
    port map (
      ADR0 => XLXI_3_pwm_period(1),
      ADR1 => VCC,
      ADR2 => XLXI_3_pwm_low(1),
      ADR3 => XLXI_10_I5_ndwe_c,
      O => N23947_FROM
    );
  XLXI_3_Ker66591_SW12_SW0 : X_LUT4
    generic map(
      INIT => X"E4E4"
    )
    port map (
      ADR0 => XLXI_10_I5_ndwe_c,
      ADR1 => XLXI_3_pwm_period(4),
      ADR2 => XLXI_3_pwm_low(4),
      ADR3 => VCC,
      O => N23947_GROM
    );
  N23947_XUSED : X_BUF
    port map (
      I => N23947_FROM,
      O => N23947
    );
  N23947_YUSED : X_BUF
    port map (
      I => N23947_GROM,
      O => N23959
    );
  XLXI_3_Ker66591_SW14_SW0 : X_LUT4
    generic map(
      INIT => X"CFC0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_3_pwm_low(2),
      ADR2 => XLXI_10_I5_ndwe_c,
      ADR3 => XLXI_3_pwm_period(2),
      O => N23951_FROM
    );
  XLXI_3_Ker66591_SW13_SW0 : X_LUT4
    generic map(
      INIT => X"FA50"
    )
    port map (
      ADR0 => XLXI_10_I5_ndwe_c,
      ADR1 => VCC,
      ADR2 => XLXI_3_pwm_period(3),
      ADR3 => XLXI_3_pwm_low(3),
      O => N23951_GROM
    );
  N23951_XUSED : X_BUF
    port map (
      I => N23951_FROM,
      O => N23951
    );
  N23951_YUSED : X_BUF
    port map (
      I => N23951_GROM,
      O => N23955
    );
  XLXI_3_n00031 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_10_I5_Mmux_daddr_out_Result_0_1_1,
      ADR1 => XLXI_10_I5_ndwe_c,
      ADR2 => XLXI_2_N6111,
      ADR3 => N23355,
      O => XLXI_3_n0003_FROM
    );
  XLXI_3_Msub_n0005_inst_lut2_81 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => XLXI_10_I5_Mmux_daddr_out_Result_0_1_1,
      ADR1 => N23499,
      ADR2 => XLXI_2_N6111,
      ADR3 => N23497,
      O => XLXI_3_n0003_GROM
    );
  XLXI_3_n0003_XUSED : X_BUF
    port map (
      I => XLXI_3_n0003_FROM,
      O => XLXI_3_n0003
    );
  XLXI_3_n0003_YUSED : X_BUF
    port map (
      I => XLXI_3_n0003_GROM,
      O => XLXI_3_Msub_n0005_inst_lut2_8
    );
  XLXI_10_I3_Mmux_data_x_Result_3_SW2 : X_LUT4
    generic map(
      INIT => X"C3F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I2_data_is_c(3),
      ADR2 => XLXI_10_I3_acc_c_0_3,
      ADR3 => XLXI_10_I3_n0037,
      O => N23487_FROM
    );
  XLXI_10_I3_Mmux_data_x_Result_0_45_SW2 : X_LUT4
    generic map(
      INIT => X"A555"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => VCC,
      ADR2 => XLXI_10_I3_n0037,
      ADR3 => XLXI_10_I2_data_is_c(0),
      O => N23487_GROM
    );
  N23487_XUSED : X_BUF
    port map (
      I => N23487_FROM,
      O => N23487
    );
  N23487_YUSED : X_BUF
    port map (
      I => N23487_GROM,
      O => N23473
    );
  XLXI_10_I3_n0035_1_86_SW0 : X_LUT4
    generic map(
      INIT => X"F222"
    )
    port map (
      ADR0 => XLXI_10_I3_n0054,
      ADR1 => XLXI_10_I3_acc_c_0_1,
      ADR2 => XLXI_10_I3_acc_c_0_2,
      ADR3 => XLXI_10_I3_N8675,
      O => N23735_FROM
    );
  XLXI_10_I3_n0035_1_86 : X_LUT4
    generic map(
      INIT => X"CC80"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => XLXI_10_I3_n0052,
      ADR2 => XLXI_10_I3_N8705,
      ADR3 => N23735,
      O => N23735_GROM
    );
  N23735_XUSED : X_BUF
    port map (
      I => N23735_FROM,
      O => N23735
    );
  N23735_YUSED : X_BUF
    port map (
      I => N23735_GROM,
      O => CHOICE1894
    );
  XLXI_2_Ker61091_SW0 : X_LUT4
    generic map(
      INIT => X"EBFF"
    )
    port map (
      ADR0 => N23367,
      ADR1 => N23363,
      ADR2 => N23519,
      ADR3 => N23359,
      O => N23603_GROM
    );
  N23603_YUSED : X_BUF
    port map (
      I => N23603_GROM,
      O => N23603
    );
  XLXI_2_Ker61091_SW1 : X_LUT4
    generic map(
      INIT => X"EFDF"
    )
    port map (
      ADR0 => XLXI_10_I5_daddr_c(2),
      ADR1 => XLXI_10_I5_daddr_c(3),
      ADR2 => XLXI_10_I5_daddr_c(4),
      ADR3 => XLXI_10_I5_daddr_c(1),
      O => N23605_GROM
    );
  N23605_YUSED : X_BUF
    port map (
      I => N23605_GROM,
      O => N23605
    );
  XLXI_10_I1_iaddr_x_3_14 : X_LUT4
    generic map(
      INIT => X"88D8"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(1),
      ADR1 => XLXN_8(7),
      ADR2 => XLXI_10_I1_pc(3),
      ADR3 => XLXI_10_pc_mux(0),
      O => CHOICE1775_FROM
    );
  XLXI_10_I1_iaddr_x_5_31_SW0 : X_LUT4
    generic map(
      INIT => X"9180"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(1),
      ADR1 => XLXI_10_pc_mux(2),
      ADR2 => XLXI_10_I1_stack_addrs_c_0_5,
      ADR3 => XLXI_10_I1_n0013(5),
      O => CHOICE1775_GROM
    );
  CHOICE1775_XUSED : X_BUF
    port map (
      I => CHOICE1775_FROM,
      O => CHOICE1775
    );
  CHOICE1775_YUSED : X_BUF
    port map (
      I => CHOICE1775_GROM,
      O => N23895
    );
  XLXI_10_I4_Ker9481_SW1 : X_LUT4
    generic map(
      INIT => X"5FFF"
    )
    port map (
      ADR0 => XLXI_10_I4_ipage_c(0),
      ADR1 => VCC,
      ADR2 => XLXN_8(4),
      ADR3 => XLXN_8(5),
      O => N23559_FROM
    );
  XLXI_10_I2_pc_mux_x_2_SW0 : X_LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      ADR0 => XLXN_8(0),
      ADR1 => NRESET_IBUF,
      ADR2 => XLXN_8(3),
      ADR3 => XLXN_8(4),
      O => N23559_GROM
    );
  N23559_XUSED : X_BUF
    port map (
      I => N23559_FROM,
      O => N23559
    );
  N23559_YUSED : X_BUF
    port map (
      I => N23559_GROM,
      O => N20995
    );
  XLXI_10_I3_n0035_4_11_SW0 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N23405,
      ADR1 => XLXI_10_I3_n0048,
      ADR2 => N23403,
      ADR3 => XLXI_10_I3_n0058(4),
      O => N23575_GROM
    );
  N23575_YUSED : X_BUF
    port map (
      I => N23575_GROM,
      O => N23575
    );
  XLXI_10_I5_Mmux_daddr_out_Result_4_1_SW0 : X_LUT4
    generic map(
      INIT => X"FFF3"
    )
    port map (
      ADR0 => VCC,
      ADR1 => NRESET_IBUF,
      ADR2 => N23359,
      ADR3 => XLXI_10_I5_ndwe_c,
      O => N23523_FROM
    );
  XLXI_2_nWR_RAM1 : X_LUT4
    generic map(
      INIT => X"CCD8"
    )
    port map (
      ADR0 => XLXI_10_I4_N9483,
      ADR1 => N23525,
      ADR2 => N23523,
      ADR3 => XLXI_10_ndre_int,
      O => N23523_GROM
    );
  N23523_XUSED : X_BUF
    port map (
      I => N23523_FROM,
      O => N23523
    );
  N23523_YUSED : X_BUF
    port map (
      I => N23523_GROM,
      O => nWR_RAM
    );
  XLXI_3_pwm_c_BYMUX : X_INV
    port map (
      I => XLXI_3_pwm_c,
      O => XLXI_3_pwm_c_BYMUXNOT
    );
  XLXI_3_pwm_c_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_c_SRMUX_OUTPUTNOT
    );
  XLXI_10_I3_Mmux_data_x_Result_1_45_SW3 : X_LUT4
    generic map(
      INIT => X"9C93"
    )
    port map (
      ADR0 => XLXI_10_I2_data_is_c(1),
      ADR1 => XLXI_10_I3_acc_c_0_1,
      ADR2 => XLXI_10_I3_n0037,
      ADR3 => XLXI_10_I4_N9501,
      O => N23393_FROM
    );
  XLXI_10_I3_Mmux_data_x_Result_1_45_SW0 : X_LUT4
    generic map(
      INIT => X"9595"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_1,
      ADR1 => XLXI_10_I2_data_is_c(1),
      ADR2 => XLXI_10_I3_n0037,
      ADR3 => VCC,
      O => N23393_GROM
    );
  N23393_XUSED : X_BUF
    port map (
      I => N23393_FROM,
      O => N23393
    );
  N23393_YUSED : X_BUF
    port map (
      I => N23393_GROM,
      O => N23385
    );
  XLXI_10_I5_Mmux_daddr_out_Result_4_1 : X_LUT4
    generic map(
      INIT => X"FE04"
    )
    port map (
      ADR0 => XLXI_10_I4_N9483,
      ADR1 => N23359,
      ADR2 => XLXI_10_ndre_int,
      ADR3 => XLXI_10_I5_daddr_c(4),
      O => CPU_DADDR_4_OBUF_FROM
    );
  XLXI_2_n00381 : X_LUT4
    generic map(
      INIT => X"0F00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_10_I5_ndwe_c,
      ADR3 => CPU_DADDR_4_OBUF,
      O => CPU_DADDR_4_OBUF_GROM
    );
  CPU_DADDR_4_OBUF_XUSED : X_BUF
    port map (
      I => CPU_DADDR_4_OBUF_FROM,
      O => CPU_DADDR_4_OBUF
    );
  CPU_DADDR_4_OBUF_YUSED : X_BUF
    port map (
      I => CPU_DADDR_4_OBUF_GROM,
      O => XLXI_2_n0038
    );
  XLXI_10_I2_pc_mux_x_2_1_137 : X_LUT4
    generic map(
      INIT => X"0200"
    )
    port map (
      ADR0 => XLXI_10_I2_N8130,
      ADR1 => XLXI_10_I2_N8054,
      ADR2 => N20995,
      ADR3 => XLXI_10_I2_N8107,
      O => XLXI_10_I2_pc_mux_x_2_1_FROM
    );
  XLXI_10_I1_n0012_7_19_SW0 : X_LUT4
    generic map(
      INIT => X"AAF0"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_1_7,
      ADR1 => VCC,
      ADR2 => XLXI_10_I1_n0013(7),
      ADR3 => XLXI_10_I2_pc_mux_x_2_1,
      O => XLXI_10_I2_pc_mux_x_2_1_GROM
    );
  XLXI_10_I2_pc_mux_x_2_1_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_pc_mux_x_2_1_FROM,
      O => XLXI_10_I2_pc_mux_x_2_1
    );
  XLXI_10_I2_pc_mux_x_2_1_YUSED : X_BUF
    port map (
      I => XLXI_10_I2_pc_mux_x_2_1_GROM,
      O => N23840
    );
  XLXI_3_Ker66591_SW14 : X_LUT4
    generic map(
      INIT => X"3335"
    )
    port map (
      ADR0 => N23951,
      ADR1 => XLXI_3_pwm_low(2),
      ADR2 => N23355,
      ADR3 => CPU_DADDR_0_OBUF,
      O => XLXI_3_Ker66591_SW14_O_FROM
    );
  XLXI_3_Msub_n0005_inst_lut2_101 : X_LUT4
    generic map(
      INIT => X"87D2"
    )
    port map (
      ADR0 => XLXI_2_N6111,
      ADR1 => XLXI_3_pwm_low(2),
      ADR2 => CPU_DATA_OUT_2_OBUF,
      ADR3 => XLXI_3_Ker66591_SW14_O,
      O => XLXI_3_Ker66591_SW14_O_GROM
    );
  XLXI_3_Ker66591_SW14_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW14_O_FROM,
      O => XLXI_3_Ker66591_SW14_O
    );
  XLXI_3_Ker66591_SW14_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW14_O_GROM,
      O => XLXI_3_Msub_n0005_inst_lut2_10
    );
  XLXI_3_Ker66591_SW13 : X_LUT4
    generic map(
      INIT => X"5547"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(3),
      ADR1 => CPU_DADDR_0_OBUF,
      ADR2 => N23955,
      ADR3 => N23355,
      O => XLXI_3_Ker66591_SW13_O_FROM
    );
  XLXI_3_Msub_n0005_inst_lut2_111 : X_LUT4
    generic map(
      INIT => X"939C"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(3),
      ADR1 => CPU_DATA_OUT_3_OBUF,
      ADR2 => XLXI_2_N6111,
      ADR3 => XLXI_3_Ker66591_SW13_O,
      O => XLXI_3_Ker66591_SW13_O_GROM
    );
  XLXI_3_Ker66591_SW13_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW13_O_FROM,
      O => XLXI_3_Ker66591_SW13_O
    );
  XLXI_3_Ker66591_SW13_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW13_O_GROM,
      O => XLXI_3_Msub_n0005_inst_lut2_11
    );
  XLXI_3_Ker66591_SW12 : X_LUT4
    generic map(
      INIT => X"0E1F"
    )
    port map (
      ADR0 => N23355,
      ADR1 => CPU_DADDR_0_OBUF,
      ADR2 => XLXI_3_pwm_low(4),
      ADR3 => N23959,
      O => XLXI_3_Ker66591_SW12_O_FROM
    );
  XLXI_3_Msub_n0005_inst_lut2_121 : X_LUT4
    generic map(
      INIT => X"939C"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(4),
      ADR1 => XLXI_2_pwm_data_c(0),
      ADR2 => XLXI_2_N6111,
      ADR3 => XLXI_3_Ker66591_SW12_O,
      O => XLXI_3_Ker66591_SW12_O_GROM
    );
  XLXI_3_Ker66591_SW12_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW12_O_FROM,
      O => XLXI_3_Ker66591_SW12_O
    );
  XLXI_3_Ker66591_SW12_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW12_O_GROM,
      O => XLXI_3_Msub_n0005_inst_lut2_12
    );
  XLXI_3_Ker66591_SW11 : X_LUT4
    generic map(
      INIT => X"0F1B"
    )
    port map (
      ADR0 => CPU_DADDR_0_OBUF,
      ADR1 => N23939,
      ADR2 => XLXI_3_pwm_low(5),
      ADR3 => N23355,
      O => XLXI_3_Ker66591_SW11_O_FROM
    );
  XLXI_3_Msub_n0005_inst_lut2_131 : X_LUT4
    generic map(
      INIT => X"95A6"
    )
    port map (
      ADR0 => XLXI_2_pwm_data_c(1),
      ADR1 => XLXI_2_N6111,
      ADR2 => XLXI_3_pwm_low(5),
      ADR3 => XLXI_3_Ker66591_SW11_O,
      O => XLXI_3_Ker66591_SW11_O_GROM
    );
  XLXI_3_Ker66591_SW11_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW11_O_FROM,
      O => XLXI_3_Ker66591_SW11_O
    );
  XLXI_3_Ker66591_SW11_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW11_O_GROM,
      O => XLXI_3_Msub_n0005_inst_lut2_13
    );
  XLXI_3_Ker66591_SW10 : X_LUT4
    generic map(
      INIT => X"3237"
    )
    port map (
      ADR0 => N23355,
      ADR1 => XLXI_3_pwm_low(6),
      ADR2 => CPU_DADDR_0_OBUF,
      ADR3 => N23919,
      O => XLXI_3_Ker66591_SW10_O_FROM
    );
  XLXI_3_Msub_n0005_inst_lut2_141 : X_LUT4
    generic map(
      INIT => X"87D2"
    )
    port map (
      ADR0 => XLXI_2_N6111,
      ADR1 => XLXI_3_pwm_low(6),
      ADR2 => XLXI_2_pwm_data_c(2),
      ADR3 => XLXI_3_Ker66591_SW10_O,
      O => XLXI_3_Ker66591_SW10_O_GROM
    );
  XLXI_3_Ker66591_SW10_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW10_O_FROM,
      O => XLXI_3_Ker66591_SW10_O
    );
  XLXI_3_Ker66591_SW10_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker66591_SW10_O_GROM,
      O => XLXI_3_Msub_n0005_inst_lut2_14
    );
  XLXI_10_I4_Ker94991 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_10_I4_nreset_v(1),
      ADR3 => NRESET_IBUF,
      O => XLXI_10_I4_N9501_FROM
    );
  XLXI_10_I3_Mmux_data_x_Result_2_SW0 : X_LUT4
    generic map(
      INIT => X"E200"
    )
    port map (
      ADR0 => RAM_DATA_OUT(2),
      ADR1 => XLXI_2_mux_c(0),
      ADR2 => CTRL_DATA_IN_2_IBUF,
      ADR3 => XLXI_10_I4_N9501,
      O => XLXI_10_I4_N9501_GROM
    );
  XLXI_10_I4_N9501_XUSED : X_BUF
    port map (
      I => XLXI_10_I4_N9501_FROM,
      O => XLXI_10_I4_N9501
    );
  XLXI_10_I4_N9501_YUSED : X_BUF
    port map (
      I => XLXI_10_I4_N9501_GROM,
      O => N22134
    );
  XLXI_10_I2_ndre_x_SW0 : X_LUT4
    generic map(
      INIT => X"0020"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(0),
      ADR1 => XLXI_10_I2_skip_c,
      ADR2 => XLXI_10_I2_TC_c(1),
      ADR3 => XLXI_10_I2_TC_c(2),
      O => N22806_FROM
    );
  XLXI_10_I2_ndre_x_SW1 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => XLXN_8(8),
      ADR1 => XLXN_8(3),
      ADR2 => XLXN_8(9),
      ADR3 => N22806,
      O => N22806_GROM
    );
  N22806_XUSED : X_BUF
    port map (
      I => N22806_FROM,
      O => N22806
    );
  N22806_YUSED : X_BUF
    port map (
      I => N22806_GROM,
      O => N23375
    );
  XLXI_10_I2_pc_mux_x_0_17 : X_LUT4
    generic map(
      INIT => X"FBFA"
    )
    port map (
      ADR0 => CHOICE1559,
      ADR1 => XLXN_8(3),
      ADR2 => XLXI_10_I2_N8098,
      ADR3 => XLXI_10_I2_N8038,
      O => XLXI_10_pc_mux_0_FROM
    );
  XLXI_10_I1_iaddr_x_5_14 : X_LUT4
    generic map(
      INIT => X"A0AC"
    )
    port map (
      ADR0 => XLXN_8(9),
      ADR1 => XLXI_10_I1_pc(5),
      ADR2 => XLXI_10_pc_mux(1),
      ADR3 => XLXI_10_pc_mux(0),
      O => XLXI_10_pc_mux_0_GROM
    );
  XLXI_10_pc_mux_0_XUSED : X_BUF
    port map (
      I => XLXI_10_pc_mux_0_FROM,
      O => XLXI_10_pc_mux(0)
    );
  XLXI_10_pc_mux_0_YUSED : X_BUF
    port map (
      I => XLXI_10_pc_mux_0_GROM,
      O => CHOICE1715
    );
  XLXI_2_ctrl_data_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CTRL_DATA_OUT_2_OD,
      CE => XLXI_2_n0039,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => CTRL_DATA_OUT_2_OFF_RST,
      O => XLXI_2_ctrl_data_c(2)
    );
  CTRL_DATA_OUT_2_OFF_RSTOR : X_OR2
    port map (
      I0 => CTRL_DATA_OUT_2_SRMUXNOT,
      I1 => GSR,
      O => CTRL_DATA_OUT_2_OFF_RST
    );
  XLXI_10_I5_Mmux_daddr_out_Result_0_1_1_138 : X_LUT4
    generic map(
      INIT => X"FE10"
    )
    port map (
      ADR0 => XLXI_10_I4_N9483,
      ADR1 => XLXI_10_ndre_int,
      ADR2 => N23371,
      ADR3 => XLXI_10_I5_daddr_c(0),
      O => XLXI_10_I5_Mmux_daddr_out_Result_0_1_1_FROM
    );
  XLXI_3_n00241 : X_LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      ADR0 => XLXI_10_I5_ndwe_c,
      ADR1 => NRESET_IBUF,
      ADR2 => XLXI_2_N6111,
      ADR3 => XLXI_10_I5_Mmux_daddr_out_Result_0_1_1,
      O => XLXI_10_I5_Mmux_daddr_out_Result_0_1_1_GROM
    );
  XLXI_10_I5_Mmux_daddr_out_Result_0_1_1_XUSED : X_BUF
    port map (
      I => XLXI_10_I5_Mmux_daddr_out_Result_0_1_1_FROM,
      O => XLXI_10_I5_Mmux_daddr_out_Result_0_1_1
    );
  XLXI_10_I5_Mmux_daddr_out_Result_0_1_1_YUSED : X_BUF
    port map (
      I => XLXI_10_I5_Mmux_daddr_out_Result_0_1_1_GROM,
      O => XLXI_3_n0024
    );
  XLXI_10_I4_Ker9481_SW0 : X_LUT4
    generic map(
      INIT => X"FFEE"
    )
    port map (
      ADR0 => XLXN_8(9),
      ADR1 => XLXN_8(7),
      ADR2 => VCC,
      ADR3 => XLXN_8(8),
      O => N20496_FROM
    );
  XLXI_10_I4_Ker9481 : X_LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      ADR0 => XLXN_8(6),
      ADR1 => XLXN_8(5),
      ADR2 => XLXN_8(4),
      ADR3 => N20496,
      O => N20496_GROM
    );
  N20496_XUSED : X_BUF
    port map (
      I => N20496_FROM,
      O => N20496
    );
  N20496_YUSED : X_BUF
    port map (
      I => N20496_GROM,
      O => XLXI_10_I4_N9483
    );
  XLXI_10_I2_Ker80961 : X_LUT4
    generic map(
      INIT => X"DFDF"
    )
    port map (
      ADR0 => XLXI_10_I2_nreset_v(1),
      ADR1 => XLXI_10_skip,
      ADR2 => NRESET_IBUF,
      ADR3 => VCC,
      O => XLXI_10_I2_N8098_FROM
    );
  XLXI_10_I4_Ker9466 : X_LUT4
    generic map(
      INIT => X"FFFD"
    )
    port map (
      ADR0 => XLXI_10_I2_N8054,
      ADR1 => N23375,
      ADR2 => N22760,
      ADR3 => XLXI_10_I2_N8098,
      O => XLXI_10_I2_N8098_GROM
    );
  XLXI_10_I2_N8098_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_N8098_FROM,
      O => XLXI_10_I2_N8098
    );
  XLXI_10_I2_N8098_YUSED : X_BUF
    port map (
      I => XLXI_10_I2_N8098_GROM,
      O => XLXI_10_I4_N9468
    );
  XLXI_3_Ker66591_SW0 : X_LUT4
    generic map(
      INIT => X"5553"
    )
    port map (
      ADR0 => N23493,
      ADR1 => N23491,
      ADR2 => XLXI_10_ndre_int,
      ADR3 => XLXI_10_I4_N9483,
      O => N23355_FROM
    );
  XLXI_3_Ker66591 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => XLXI_2_N6111,
      ADR1 => XLXI_10_I5_ndwe_c,
      ADR2 => XLXI_10_I5_Mmux_daddr_out_Result_0_1_1,
      ADR3 => N23355,
      O => N23355_GROM
    );
  N23355_XUSED : X_BUF
    port map (
      I => N23355_FROM,
      O => N23355
    );
  N23355_YUSED : X_BUF
    port map (
      I => N23355_GROM,
      O => XLXI_3_N6661
    );
  XLXI_10_I3_n00441 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_1,
      ADR1 => XLXI_10_I3_acc_c_0_3,
      ADR2 => XLXI_10_I3_acc_c_0_0,
      ADR3 => XLXI_10_I3_acc_c_0_2,
      O => XLXI_10_I3_n00441_O_FROM
    );
  XLXI_10_I3_skip_l36 : X_LUT4
    generic map(
      INIT => X"115A"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(1),
      ADR1 => XLXI_10_I3_acc_c_0_4,
      ADR2 => XLXI_10_I3_n00441_O,
      ADR3 => XLXI_10_I2_TD_c(2),
      O => XLXI_10_I3_n00441_O_GROM
    );
  XLXI_10_I3_n00441_O_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_n00441_O_FROM,
      O => XLXI_10_I3_n00441_O
    );
  XLXI_10_I3_n00441_O_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_n00441_O_GROM,
      O => CHOICE1987
    );
  XLXI_3_Ker66781_SW0 : X_LUT4
    generic map(
      INIT => X"BF8F"
    )
    port map (
      ADR0 => XLXI_10_I5_daddr_c(2),
      ADR1 => nRE_CPU_OBUF,
      ADR2 => NRESET_IBUF,
      ADR3 => XLXI_10_adaddr_out(2),
      O => XLXI_3_Ker66781_SW0_O_FROM
    );
  XLXI_3_Ker66781 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => XLXI_10_I5_ndwe_c,
      ADR1 => XLXI_3_Ker66781_SW0_O,
      ADR2 => XLXI_2_N6111,
      ADR3 => XLXI_10_I5_Mmux_daddr_out_Result_0_1_1,
      O => XLXI_3_Ker66781_SW0_O_GROM
    );
  XLXI_3_Ker66781_SW0_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker66781_SW0_O_FROM,
      O => XLXI_3_Ker66781_SW0_O
    );
  XLXI_3_Ker66781_SW0_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker66781_SW0_O_GROM,
      O => XLXI_3_N6680
    );
  XLXI_10_I3_skip_l90 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CHOICE2000,
      ADR2 => VCC,
      ADR3 => XLXI_10_I3_N8818,
      O => XLXI_10_I2_skip_c_FROM
    );
  XLXI_10_I3_skip_l99 : X_LUT4
    generic map(
      INIT => X"BA00"
    )
    port map (
      ADR0 => CHOICE1994,
      ADR1 => XLXI_10_I2_TD_c(0),
      ADR2 => CHOICE1987,
      ADR3 => XLXI_10_I3_skip_l90_O,
      O => XLXI_10_I2_skip_c_GROM
    );
  XLXI_10_I2_skip_c_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_skip_c_FROM,
      O => XLXI_10_I3_skip_l90_O
    );
  XLXI_10_I2_skip_c_YUSED : X_BUF
    port map (
      I => XLXI_10_I2_skip_c_GROM,
      O => XLXI_10_skip
    );
  XLXI_10_I2_skip_c_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_skip_c_SRMUX_OUTPUTNOT
    );
  XLXI_10_I2_pc_mux_x_2_Q : X_LUT4
    generic map(
      INIT => X"0400"
    )
    port map (
      ADR0 => XLXI_10_I2_N8054,
      ADR1 => XLXI_10_I2_N8130,
      ADR2 => N20995,
      ADR3 => XLXI_10_I2_N8107,
      O => XLXI_10_pc_mux_2_FROM
    );
  XLXI_10_I1_iaddr_x_0_31_SW0 : X_LUT4
    generic map(
      INIT => X"8803"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_0_0,
      ADR1 => XLXI_10_pc_mux(1),
      ADR2 => XLXI_10_I1_pc(0),
      ADR3 => XLXI_10_pc_mux(2),
      O => XLXI_10_pc_mux_2_GROM
    );
  XLXI_10_pc_mux_2_XUSED : X_BUF
    port map (
      I => XLXI_10_pc_mux_2_FROM,
      O => XLXI_10_pc_mux(2)
    );
  XLXI_10_pc_mux_2_YUSED : X_BUF
    port map (
      I => XLXI_10_pc_mux_2_GROM,
      O => N23875
    );
  XLXI_10_I5_Mmux_daddr_out_Result_0_1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => XLXI_10_I4_N9483,
      ADR1 => XLXI_10_I5_daddr_c(0),
      ADR2 => XLXI_10_ndre_int,
      ADR3 => N23371,
      O => CPU_DADDR_0_OBUF_FROM
    );
  XLXI_2_Ker6121_SW0 : X_LUT4
    generic map(
      INIT => X"FFF0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => CPU_DADDR_2_OBUF,
      ADR3 => CPU_DADDR_0_OBUF,
      O => CPU_DADDR_0_OBUF_GROM
    );
  CPU_DADDR_0_OBUF_XUSED : X_BUF
    port map (
      I => CPU_DADDR_0_OBUF_FROM,
      O => CPU_DADDR_0_OBUF
    );
  CPU_DADDR_0_OBUF_YUSED : X_BUF
    port map (
      I => CPU_DADDR_0_OBUF_GROM,
      O => N20289
    );
  XLXI_3_n0006_1_1 : X_LUT4
    generic map(
      INIT => X"A0C0"
    )
    port map (
      ADR0 => XLXI_3_n0018,
      ADR1 => XLXI_3_n0017,
      ADR2 => XLXI_3_n0013(1),
      ADR3 => XLXI_3_pwm_c,
      O => XLXI_3_n0006(1)
    );
  XLXI_3_n0006_0_1 : X_LUT4
    generic map(
      INIT => X"0C0A"
    )
    port map (
      ADR0 => XLXI_3_n0017,
      ADR1 => XLXI_3_n0018,
      ADR2 => XLXI_3_pwm_count(0),
      ADR3 => XLXI_3_pwm_c,
      O => XLXI_3_n0006(0)
    );
  XLXI_3_pwm_count_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_count_1_SRMUX_OUTPUTNOT
    );
  XLXI_3_n0006_3_1 : X_LUT4
    generic map(
      INIT => X"88A0"
    )
    port map (
      ADR0 => XLXI_3_n0013(3),
      ADR1 => XLXI_3_n0018,
      ADR2 => XLXI_3_n0017,
      ADR3 => XLXI_3_pwm_c,
      O => XLXI_3_n0006(3)
    );
  XLXI_3_n0006_2_1 : X_LUT4
    generic map(
      INIT => X"8C80"
    )
    port map (
      ADR0 => XLXI_3_n0018,
      ADR1 => XLXI_3_n0013(2),
      ADR2 => XLXI_3_pwm_c,
      ADR3 => XLXI_3_n0017,
      O => XLXI_3_n0006(2)
    );
  XLXI_3_pwm_count_3_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_count_3_SRMUX_OUTPUTNOT
    );
  XLXI_3_n0006_5_1 : X_LUT4
    generic map(
      INIT => X"C0A0"
    )
    port map (
      ADR0 => XLXI_3_n0017,
      ADR1 => XLXI_3_n0018,
      ADR2 => XLXI_3_n0013(5),
      ADR3 => XLXI_3_pwm_c,
      O => XLXI_3_n0006(5)
    );
  XLXI_3_n0006_4_1 : X_LUT4
    generic map(
      INIT => X"B800"
    )
    port map (
      ADR0 => XLXI_3_n0018,
      ADR1 => XLXI_3_pwm_c,
      ADR2 => XLXI_3_n0017,
      ADR3 => XLXI_3_n0013(4),
      O => XLXI_3_n0006(4)
    );
  XLXI_3_pwm_count_5_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_count_5_SRMUX_OUTPUTNOT
    );
  XLXI_3_n0006_7_1 : X_LUT4
    generic map(
      INIT => X"88A0"
    )
    port map (
      ADR0 => XLXI_3_n0013(7),
      ADR1 => XLXI_3_n0018,
      ADR2 => XLXI_3_n0017,
      ADR3 => XLXI_3_pwm_c,
      O => XLXI_3_n0006(7)
    );
  XLXI_3_n0006_6_1 : X_LUT4
    generic map(
      INIT => X"8A80"
    )
    port map (
      ADR0 => XLXI_3_n0013(6),
      ADR1 => XLXI_3_n0018,
      ADR2 => XLXI_3_pwm_c,
      ADR3 => XLXI_3_n0017,
      O => XLXI_3_n0006(6)
    );
  XLXI_3_pwm_count_7_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_count_7_SRMUX_OUTPUTNOT
    );
  XLXI_10_I4_data_ox_1_1 : X_LUT4
    generic map(
      INIT => X"8800"
    )
    port map (
      ADR0 => XLXI_10_I4_nreset_v(1),
      ADR1 => NRESET_IBUF,
      ADR2 => VCC,
      ADR3 => XLXI_10_I3_acc_c_0_1,
      O => XLXI_3_pwm_low_1_FROM
    );
  XLXI_10_I4_data_ox_0_1 : X_LUT4
    generic map(
      INIT => X"8800"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXI_10_I3_acc_c_0_0,
      ADR2 => VCC,
      ADR3 => XLXI_10_I4_nreset_v(1),
      O => XLXI_3_pwm_low_1_GROM
    );
  XLXI_3_pwm_low_1_XUSED : X_BUF
    port map (
      I => XLXI_3_pwm_low_1_FROM,
      O => CPU_DATA_OUT_1_OBUF
    );
  XLXI_3_pwm_low_1_YUSED : X_BUF
    port map (
      I => XLXI_3_pwm_low_1_GROM,
      O => CPU_DATA_OUT_0_OBUF
    );
  XLXI_3_pwm_low_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_low_1_SRMUX_OUTPUTNOT
    );
  XLXI_3_pwm_low_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_low_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_low_3_FFY_RST
    );
  XLXI_3_pwm_low_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_low_3_GROM,
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_low_3_FFY_RST,
      O => XLXI_3_pwm_low(2)
    );
  XLXI_10_I4_data_ox_3_1 : X_LUT4
    generic map(
      INIT => X"8800"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => VCC,
      ADR3 => XLXI_10_I3_acc_c_0_3,
      O => XLXI_3_pwm_low_3_FROM
    );
  XLXI_10_I4_data_ox_2_1 : X_LUT4
    generic map(
      INIT => X"C000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => XLXI_10_I3_acc_c_0_2,
      ADR3 => NRESET_IBUF,
      O => XLXI_3_pwm_low_3_GROM
    );
  XLXI_3_pwm_low_3_XUSED : X_BUF
    port map (
      I => XLXI_3_pwm_low_3_FROM,
      O => CPU_DATA_OUT_3_OBUF
    );
  XLXI_3_pwm_low_3_YUSED : X_BUF
    port map (
      I => XLXI_3_pwm_low_3_GROM,
      O => CPU_DATA_OUT_2_OBUF
    );
  XLXI_3_pwm_low_3_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_low_3_SRMUX_OUTPUTNOT
    );
  XLXI_10_I3_Mmux_data_x_Result_0_45_SW3 : X_LUT4
    generic map(
      INIT => X"B847"
    )
    port map (
      ADR0 => XLXI_10_I2_data_is_c(0),
      ADR1 => XLXI_10_I3_n0037,
      ADR2 => XLXI_10_I4_N9501,
      ADR3 => XLXI_10_I3_acc_c_0_0,
      O => XLXI_10_I4_ipage_we_c_FROM
    );
  XLXI_10_I4_ipage_we_x1 : X_LUT4
    generic map(
      INIT => X"4000"
    )
    port map (
      ADR0 => XLXI_10_ndwe_int,
      ADR1 => XLXI_10_I4_N9501,
      ADR2 => XLXI_10_ndre_int,
      ADR3 => XLXI_10_I4_N9483,
      O => XLXI_10_I4_ipage_we_x
    );
  XLXI_10_I4_ipage_we_c_XUSED : X_BUF
    port map (
      I => XLXI_10_I4_ipage_we_c_FROM,
      O => N23475
    );
  XLXI_10_I4_ipage_we_c_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I4_ipage_we_c_SRMUX_OUTPUTNOT
    );
  XLXI_10_I4_n0030_1_1 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_10_I4_ipage_we_c,
      ADR3 => XLXI_10_I3_acc_c_0_1,
      O => XLXI_10_I4_n0030(1)
    );
  XLXI_10_I4_n0030_0_1 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_10_I3_acc_c_0_0,
      ADR3 => XLXI_10_I4_ipage_we_c,
      O => XLXI_10_I4_n0030(0)
    );
  XLXI_10_I4_ipage_c_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I4_ipage_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_10_I2_valid_c_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I2_valid_c_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I2_valid_c_FFY_RST
    );
  XLXI_10_I2_valid_c_139 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_valid_x,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I2_valid_c_FFY_RST,
      O => XLXI_10_I2_valid_c
    );
  XLXI_10_I2_pc_mux_x_1_1_140 : X_LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      ADR0 => N21055,
      ADR1 => NRESET_IBUF,
      ADR2 => XLXI_10_I2_N8054,
      ADR3 => XLXI_10_I2_N8130,
      O => XLXI_10_I2_valid_c_FROM
    );
  XLXI_10_I2_valid_x1 : X_LUT4
    generic map(
      INIT => X"EF00"
    )
    port map (
      ADR0 => XLXN_8(3),
      ADR1 => XLXI_10_I2_N8038,
      ADR2 => NRESET_IBUF,
      ADR3 => XLXI_10_I2_N8130,
      O => XLXI_10_I2_valid_x
    );
  XLXI_10_I2_valid_c_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_valid_c_FROM,
      O => XLXI_10_I2_pc_mux_x_1_1
    );
  XLXI_10_I2_valid_c_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_valid_c_SRMUX_OUTPUTNOT
    );
  XLXI_10_I4_daddr_x_1_1 : X_LUT4
    generic map(
      INIT => X"8800"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXN_8(5),
      ADR2 => VCC,
      ADR3 => XLXI_10_I4_nreset_v(1),
      O => XLXI_10_adaddr_out(1)
    );
  XLXI_10_I4_daddr_x_0_1 : X_LUT4
    generic map(
      INIT => X"8800"
    )
    port map (
      ADR0 => XLXI_10_I4_nreset_v(1),
      ADR1 => XLXN_8(4),
      ADR2 => VCC,
      ADR3 => NRESET_IBUF,
      O => XLXI_10_adaddr_out(0)
    );
  XLXI_10_I5_daddr_c_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I5_daddr_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_10_I4_daddr_x_3_1 : X_LUT4
    generic map(
      INIT => X"8800"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXN_8(7),
      ADR2 => VCC,
      ADR3 => XLXI_10_I4_nreset_v(1),
      O => XLXI_10_adaddr_out(3)
    );
  XLXI_10_I4_daddr_x_2_1 : X_LUT4
    generic map(
      INIT => X"C000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => NRESET_IBUF,
      ADR2 => XLXN_8(6),
      ADR3 => XLXI_10_I4_nreset_v(1),
      O => XLXI_10_I5_daddr_c_3_GROM
    );
  XLXI_10_I5_daddr_c_3_YUSED : X_BUF
    port map (
      I => XLXI_10_I5_daddr_c_3_GROM,
      O => XLXI_10_adaddr_out(2)
    );
  XLXI_10_I5_daddr_c_3_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I5_daddr_c_3_SRMUX_OUTPUTNOT
    );
  XLXI_10_I4_daddr_x_5_1 : X_LUT4
    generic map(
      INIT => X"8800"
    )
    port map (
      ADR0 => XLXI_10_I4_nreset_v(1),
      ADR1 => NRESET_IBUF,
      ADR2 => VCC,
      ADR3 => XLXN_8(9),
      O => XLXI_10_I5_daddr_c_5_FROM
    );
  XLXI_10_I4_daddr_x_4_1 : X_LUT4
    generic map(
      INIT => X"A000"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => VCC,
      ADR2 => XLXI_10_I4_nreset_v(1),
      ADR3 => XLXN_8(8),
      O => XLXI_10_adaddr_out(4)
    );
  XLXI_10_I5_daddr_c_5_XUSED : X_BUF
    port map (
      I => XLXI_10_I5_daddr_c_5_FROM,
      O => XLXI_10_adaddr_out(5)
    );
  XLXI_10_I5_daddr_c_5_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I5_daddr_c_5_SRMUX_OUTPUTNOT
    );
  XLXI_10_I1_n00141 : X_LUT4
    generic map(
      INIT => X"C0C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I1_nreset_v(1),
      ADR2 => NRESET_IBUF,
      ADR3 => VCC,
      O => XLXI_10_I1_nreset_v_0_FROM
    );
  XLXI_10_I1_n0008_0_1 : X_LUT4
    generic map(
      INIT => X"AFAF"
    )
    port map (
      ADR0 => XLXI_10_I1_nreset_v(1),
      ADR1 => VCC,
      ADR2 => XLXI_10_I1_nreset_v(0),
      ADR3 => VCC,
      O => XLXI_10_I1_n0008(0)
    );
  XLXI_10_I1_nreset_v_0_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_nreset_v_0_FROM,
      O => XLXI_10_I1_n0014
    );
  XLXI_10_I1_nreset_v_0_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I1_nreset_v_0_SRMUX_OUTPUTNOT
    );
  XLXI_10_I2_n0028_0_1 : X_LUT4
    generic map(
      INIT => X"AFAF"
    )
    port map (
      ADR0 => XLXI_10_I2_nreset_v(1),
      ADR1 => VCC,
      ADR2 => XLXI_10_I2_nreset_v(0),
      ADR3 => VCC,
      O => XLXI_10_I2_n0028(0)
    );
  XLXI_10_I2_nreset_v_0_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_nreset_v_0_SRMUX_OUTPUTNOT
    );
  XLXI_10_I3_n00731 : X_LUT4
    generic map(
      INIT => X"F7F7"
    )
    port map (
      ADR0 => XLXI_10_I3_nreset_v(0),
      ADR1 => XLXI_10_I3_nreset_v(1),
      ADR2 => XLXI_10_I2_valid_c,
      ADR3 => VCC,
      O => XLXI_10_I3_nreset_v_0_FROM
    );
  XLXI_10_I3_n0036_0_1 : X_LUT4
    generic map(
      INIT => X"CFCF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I3_nreset_v(1),
      ADR2 => XLXI_10_I3_nreset_v(0),
      ADR3 => VCC,
      O => XLXI_10_I3_n0036(0)
    );
  XLXI_10_I3_nreset_v_0_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_nreset_v_0_FROM,
      O => XLXI_10_I3_n0073
    );
  XLXI_10_I3_nreset_v_0_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I3_nreset_v_0_SRMUX_OUTPUTNOT
    );
  XLXI_10_I3_Mmux_data_x_Result_1_30 : X_LUT4
    generic map(
      INIT => X"5000"
    )
    port map (
      ADR0 => XLXI_10_I3_n0037,
      ADR1 => VCC,
      ADR2 => XLXI_10_I4_nreset_v(1),
      ADR3 => NRESET_IBUF,
      O => XLXI_10_I4_nreset_v_0_FROM
    );
  XLXI_10_I4_n0031_0_1 : X_LUT4
    generic map(
      INIT => X"F0FF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_10_I4_nreset_v(1),
      ADR3 => XLXI_10_I4_nreset_v(0),
      O => XLXI_10_I4_n0031(0)
    );
  XLXI_10_I4_nreset_v_0_XUSED : X_BUF
    port map (
      I => XLXI_10_I4_nreset_v_0_FROM,
      O => CHOICE1912
    );
  XLXI_10_I4_nreset_v_0_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I4_nreset_v_0_SRMUX_OUTPUTNOT
    );
  XLXI_10_I3_n0035_0_164 : X_LUT4
    generic map(
      INIT => X"0003"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I2_TC_c(1),
      ADR2 => XLXI_10_I2_TD_c(3),
      ADR3 => XLXI_10_I2_TC_c(0),
      O => CHOICE1833_FROM
    );
  XLXI_10_I3_n00521 : X_LUT4
    generic map(
      INIT => X"0033"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I2_TC_c(1),
      ADR2 => VCC,
      ADR3 => XLXI_10_I2_TC_c(0),
      O => CHOICE1833_GROM
    );
  CHOICE1833_XUSED : X_BUF
    port map (
      I => CHOICE1833_FROM,
      O => CHOICE1833
    );
  CHOICE1833_YUSED : X_BUF
    port map (
      I => CHOICE1833_GROM,
      O => XLXI_10_I3_n0052
    );
  XLXI_10_I3_n00371 : X_LUT4
    generic map(
      INIT => X"0044"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(2),
      ADR1 => XLXI_10_I2_TC_c(1),
      ADR2 => VCC,
      ADR3 => XLXI_10_I2_TC_c(0),
      O => XLXI_10_I3_n0037_FROM
    );
  XLXI_10_I3_Mmux_data_x_Result_0_30 : X_LUT4
    generic map(
      INIT => X"00A0"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => VCC,
      ADR2 => XLXI_10_I4_nreset_v(1),
      ADR3 => XLXI_10_I3_n0037,
      O => XLXI_10_I3_n0037_GROM
    );
  XLXI_10_I3_n0037_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0037_FROM,
      O => XLXI_10_I3_n0037
    );
  XLXI_10_I3_n0037_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0037_GROM,
      O => CHOICE1973
    );
  XLXI_10_I3_n00481 : X_LUT4
    generic map(
      INIT => X"0030"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I2_TD_c(0),
      ADR2 => XLXI_10_I2_TD_c(2),
      ADR3 => XLXI_10_I2_TD_c(1),
      O => XLXI_10_I3_n0048_FROM
    );
  XLXI_10_I3_n00451 : X_LUT4
    generic map(
      INIT => X"0030"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I2_TD_c(2),
      ADR2 => XLXI_10_I2_TD_c(0),
      ADR3 => XLXI_10_I2_TD_c(1),
      O => XLXI_10_I3_n0048_GROM
    );
  XLXI_10_I3_n0048_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0048_FROM,
      O => XLXI_10_I3_n0048
    );
  XLXI_10_I3_n0048_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0048_GROM,
      O => XLXI_10_I3_n0045
    );
  XLXI_10_I3_n00531 : X_LUT4
    generic map(
      INIT => X"0A00"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(1),
      ADR1 => VCC,
      ADR2 => XLXI_10_I2_TD_c(2),
      ADR3 => XLXI_10_I2_TD_c(0),
      O => XLXI_10_I3_n0053_FROM
    );
  XLXI_10_I3_n0035_1_33 : X_LUT4
    generic map(
      INIT => X"E6C0"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_1,
      ADR1 => XLXI_10_I3_data_x(1),
      ADR2 => XLXI_10_I3_N8686,
      ADR3 => XLXI_10_I3_n0053,
      O => XLXI_10_I3_n0053_GROM
    );
  XLXI_10_I3_n0053_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0053_FROM,
      O => XLXI_10_I3_n0053
    );
  XLXI_10_I3_n0053_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0053_GROM,
      O => CHOICE1883
    );
  XLXI_10_I3_n00551 : X_LUT4
    generic map(
      INIT => X"4040"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(0),
      ADR1 => XLXI_10_I2_TD_c(2),
      ADR2 => XLXI_10_I2_TD_c(1),
      ADR3 => VCC,
      O => XLXI_10_I3_n0055_FROM
    );
  XLXI_10_I3_n00541 : X_LUT4
    generic map(
      INIT => X"C000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I2_TD_c(2),
      ADR2 => XLXI_10_I2_TD_c(0),
      ADR3 => XLXI_10_I2_TD_c(1),
      O => XLXI_10_I3_n0055_GROM
    );
  XLXI_10_I3_n0055_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0055_FROM,
      O => XLXI_10_I3_n0055
    );
  XLXI_10_I3_n0055_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0055_GROM,
      O => XLXI_10_I3_n0054
    );
  XLXI_2_ctrl_data_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CTRL_DATA_OUT_3_OD,
      CE => XLXI_2_n0039,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => CTRL_DATA_OUT_3_OFF_RST,
      O => XLXI_2_ctrl_data_c(3)
    );
  CTRL_DATA_OUT_3_OFF_RSTOR : X_OR2
    port map (
      I0 => CTRL_DATA_OUT_3_SRMUXNOT,
      I1 => GSR,
      O => CTRL_DATA_OUT_3_OFF_RST
    );
  XLXI_10_I3_n00621 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => XLXI_10_I3_nreset_v(0),
      ADR1 => XLXI_10_I3_nreset_v(1),
      ADR2 => XLXI_10_I2_valid_c,
      ADR3 => XLXI_10_I2_TC_c(2),
      O => XLXI_10_I3_n0062_FROM
    );
  XLXI_10_I3_n0035_1_0 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I3_acc_c_0_1,
      ADR2 => VCC,
      ADR3 => XLXI_10_I3_n0062,
      O => XLXI_10_I3_n0062_GROM
    );
  XLXI_10_I3_n0062_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0062_FROM,
      O => XLXI_10_I3_n0062
    );
  XLXI_10_I3_n0062_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0062_GROM,
      O => CHOICE1871
    );
  XLXI_10_I3_Ker88332 : X_LUT4
    generic map(
      INIT => X"FFC0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I2_TC_c(1),
      ADR2 => XLXI_10_I2_TC_c(0),
      ADR3 => XLXI_10_I2_TD_c(3),
      O => CHOICE1309_FROM
    );
  XLXI_10_I3_n0035_1_109_SW0 : X_LUT4
    generic map(
      INIT => X"F200"
    )
    port map (
      ADR0 => CHOICE1894,
      ADR1 => XLXI_10_I2_TD_c(3),
      ADR2 => CHOICE1874,
      ADR3 => XLXI_10_I3_N8818,
      O => CHOICE1309_GROM
    );
  CHOICE1309_XUSED : X_BUF
    port map (
      I => CHOICE1309_FROM,
      O => CHOICE1309
    );
  CHOICE1309_YUSED : X_BUF
    port map (
      I => CHOICE1309_GROM,
      O => N23427
    );
  XLXI_10_I2_TD_x_0_26 : X_LUT4
    generic map(
      INIT => X"000F"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXN_8(1),
      ADR3 => XLXN_8(3),
      O => CHOICE1613_FROM
    );
  XLXI_10_I2_pc_mux_x_0_17_1_141 : X_LUT4
    generic map(
      INIT => X"FFF2"
    )
    port map (
      ADR0 => XLXI_10_I2_N8038,
      ADR1 => XLXN_8(3),
      ADR2 => XLXI_10_I2_N8098,
      ADR3 => CHOICE1559,
      O => CHOICE1613_GROM
    );
  CHOICE1613_XUSED : X_BUF
    port map (
      I => CHOICE1613_FROM,
      O => CHOICE1613
    );
  CHOICE1613_YUSED : X_BUF
    port map (
      I => CHOICE1613_GROM,
      O => XLXI_10_I2_pc_mux_x_0_17_1
    );
  XLXI_10_I1_iaddr_x_3_31_SW0 : X_LUT4
    generic map(
      INIT => X"C00A"
    )
    port map (
      ADR0 => XLXI_10_I1_n0013(3),
      ADR1 => XLXI_10_I1_stack_addrs_c_0_3,
      ADR2 => XLXI_10_pc_mux(2),
      ADR3 => XLXI_10_pc_mux(1),
      O => N23887_FROM
    );
  XLXI_10_I1_iaddr_x_1_31_SW0 : X_LUT4
    generic map(
      INIT => X"C00A"
    )
    port map (
      ADR0 => XLXI_10_I1_n0013(1),
      ADR1 => XLXI_10_I1_stack_addrs_c_0_1,
      ADR2 => XLXI_10_pc_mux(1),
      ADR3 => XLXI_10_pc_mux(2),
      O => N23887_GROM
    );
  N23887_XUSED : X_BUF
    port map (
      I => N23887_FROM,
      O => N23887
    );
  N23887_YUSED : X_BUF
    port map (
      I => N23887_GROM,
      O => N23879
    );
  XLXI_10_I2_data_is_c_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_data_is_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_10_I3_Mmux_data_x_Result_3_SW1 : X_LUT4
    generic map(
      INIT => X"9595"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_3,
      ADR1 => XLXI_10_I3_n0037,
      ADR2 => XLXI_10_I2_data_is_c(3),
      ADR3 => VCC,
      O => N23485_FROM
    );
  XLXI_10_I3_Mmux_data_x_Result_1_45_SW1 : X_LUT4
    generic map(
      INIT => X"D827"
    )
    port map (
      ADR0 => XLXI_10_I3_n0037,
      ADR1 => XLXI_10_I2_data_is_c(1),
      ADR2 => XLXI_10_I4_N9501,
      ADR3 => XLXI_10_I3_acc_c_0_1,
      O => N23485_GROM
    );
  N23485_XUSED : X_BUF
    port map (
      I => N23485_FROM,
      O => N23485
    );
  N23485_YUSED : X_BUF
    port map (
      I => N23485_GROM,
      O => N23387
    );
  XLXI_10_I1_n0010_7_19_SW0 : X_LUT4
    generic map(
      INIT => X"AFA0"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_3_7,
      ADR1 => VCC,
      ADR2 => XLXI_10_I2_pc_mux_x_2_2,
      ADR3 => XLXI_10_I1_stack_addrs_c_1_7,
      O => XLXI_10_I1_stack_addrs_c_2_7_FROM
    );
  XLXI_10_I1_n0010_7_19 : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_7,
      ADR3 => N23784,
      O => XLXI_10_I1_n0010_7_19_O
    );
  XLXI_10_I1_stack_addrs_c_2_7_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_2_7_FROM,
      O => N23784
    );
  XLXI_10_I3_n0035_2_86_SW0 : X_LUT4
    generic map(
      INIT => X"A0EC"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_3,
      ADR1 => XLXI_10_I3_n0054,
      ADR2 => XLXI_10_I3_N8675,
      ADR3 => XLXI_10_I3_acc_c_0_2,
      O => N23731_FROM
    );
  XLXI_10_I3_n0035_2_86 : X_LUT4
    generic map(
      INIT => X"F080"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_1,
      ADR1 => XLXI_10_I3_N8705,
      ADR2 => XLXI_10_I3_n0052,
      ADR3 => N23731,
      O => N23731_GROM
    );
  N23731_XUSED : X_BUF
    port map (
      I => N23731_FROM,
      O => N23731
    );
  N23731_YUSED : X_BUF
    port map (
      I => N23731_GROM,
      O => CHOICE1938
    );
  XLXI_10_I3_skip_l89 : X_LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(1),
      ADR1 => XLXI_10_I2_TD_c(3),
      ADR2 => NRESET_IBUF,
      ADR3 => XLXI_10_I2_TC_c(0),
      O => CHOICE2000_FROM
    );
  XLXI_10_I3_Mmux_data_x_Result_0_0 : X_LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(1),
      ADR1 => XLXI_10_I2_data_is_c(0),
      ADR2 => XLXI_10_I2_TC_c(2),
      ADR3 => XLXI_10_I2_TC_c(0),
      O => CHOICE2000_GROM
    );
  CHOICE2000_XUSED : X_BUF
    port map (
      I => CHOICE2000_FROM,
      O => CHOICE2000
    );
  CHOICE2000_YUSED : X_BUF
    port map (
      I => CHOICE2000_GROM,
      O => CHOICE1962
    );
  XLXI_2_ctrl_data_c_0_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_2_ctrl_data_c_0_SRMUX_OUTPUTNOT
    );
  XLXI_10_I4_ndre_x1 : X_LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      ADR0 => XLXI_10_I4_N9483,
      ADR1 => XLXI_10_ndre_int,
      ADR2 => NRESET_IBUF,
      ADR3 => XLXI_10_I4_nreset_v(1),
      O => nRE_CPU_OBUF_FROM
    );
  XLXI_10_I5_Mmux_daddr_out_Result_5_1 : X_LUT4
    generic map(
      INIT => X"F0AA"
    )
    port map (
      ADR0 => XLXI_10_adaddr_out(5),
      ADR1 => VCC,
      ADR2 => XLXI_10_I5_daddr_c(5),
      ADR3 => nRE_CPU_OBUF,
      O => nRE_CPU_OBUF_GROM
    );
  nRE_CPU_OBUF_XUSED : X_BUF
    port map (
      I => nRE_CPU_OBUF_FROM,
      O => nRE_CPU_OBUF
    );
  nRE_CPU_OBUF_YUSED : X_BUF
    port map (
      I => nRE_CPU_OBUF_GROM,
      O => CPU_DADDR_5_OBUF
    );
  XLXI_10_I4_Ker9466_SW0 : X_LUT4
    generic map(
      INIT => X"FFBF"
    )
    port map (
      ADR0 => XLXN_8(6),
      ADR1 => XLXN_8(5),
      ADR2 => XLXN_8(4),
      ADR3 => XLXN_8(7),
      O => N22760_FROM
    );
  XLXI_10_I2_TD_x_0_22 : X_LUT4
    generic map(
      INIT => X"1717"
    )
    port map (
      ADR0 => XLXN_8(6),
      ADR1 => XLXN_8(7),
      ADR2 => XLXN_8(5),
      ADR3 => VCC,
      O => N22760_GROM
    );
  N22760_XUSED : X_BUF
    port map (
      I => N22760_FROM,
      O => N22760
    );
  N22760_YUSED : X_BUF
    port map (
      I => N22760_GROM,
      O => CHOICE1610
    );
  XLXI_10_I2_TD_x_0_39 : X_LUT4
    generic map(
      INIT => X"0200"
    )
    port map (
      ADR0 => CHOICE1613,
      ADR1 => XLXN_8(2),
      ADR2 => XLXN_8(0),
      ADR3 => XLXN_8(4),
      O => XLXI_10_I2_TD_c_0_FROM
    );
  XLXI_10_I2_TD_x_0_76 : X_LUT4
    generic map(
      INIT => X"E0A0"
    )
    port map (
      ADR0 => CHOICE1601,
      ADR1 => CHOICE1610,
      ADR2 => NRESET_IBUF,
      ADR3 => CHOICE1618,
      O => XLXI_10_I2_TD_x(0)
    );
  XLXI_10_I2_TD_c_0_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_TD_c_0_FROM,
      O => CHOICE1618
    );
  XLXI_10_I2_TD_c_0_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_TD_c_0_SRMUX_OUTPUTNOT
    );
  XLXI_10_I3_n0035_4_60_SW0 : X_LUT4
    generic map(
      INIT => X"C0E0"
    )
    port map (
      ADR0 => CHOICE1864,
      ADR1 => CHOICE1852,
      ADR2 => XLXI_10_I3_N8818,
      ADR3 => XLXI_10_I2_TD_c(3),
      O => N23403_FROM
    );
  XLXI_10_I3_n0035_4_11_SW1_SW0 : X_LUT4
    generic map(
      INIT => X"F3C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I3_n0055,
      ADR2 => N23405,
      ADR3 => N23403,
      O => N23403_GROM
    );
  N23403_XUSED : X_BUF
    port map (
      I => N23403_FROM,
      O => N23403
    );
  N23403_YUSED : X_BUF
    port map (
      I => N23403_GROM,
      O => N23927
    );
  XLXI_10_I2_TD_x_2_29 : X_LUT4
    generic map(
      INIT => X"0870"
    )
    port map (
      ADR0 => XLXN_8(5),
      ADR1 => XLXN_8(4),
      ADR2 => XLXN_8(6),
      ADR3 => XLXN_8(7),
      O => CHOICE1591_FROM
    );
  XLXI_10_I2_TD_x_1_52 : X_LUT4
    generic map(
      INIT => X"046C"
    )
    port map (
      ADR0 => XLXN_8(6),
      ADR1 => XLXN_8(5),
      ADR2 => XLXN_8(4),
      ADR3 => XLXN_8(7),
      O => CHOICE1591_GROM
    );
  CHOICE1591_XUSED : X_BUF
    port map (
      I => CHOICE1591_FROM,
      O => CHOICE1591
    );
  CHOICE1591_YUSED : X_BUF
    port map (
      I => CHOICE1591_GROM,
      O => CHOICE1637
    );
  XLXI_10_I2_TD_x_1_61 : X_LUT4
    generic map(
      INIT => X"0003"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXN_8(2),
      ADR2 => XLXN_8(3),
      ADR3 => XLXN_8(0),
      O => XLXI_10_I2_TD_c_1_FROM
    );
  XLXI_10_I2_TD_x_1_97 : X_LUT4
    generic map(
      INIT => X"C8C0"
    )
    port map (
      ADR0 => CHOICE1637,
      ADR1 => NRESET_IBUF,
      ADR2 => XLXN_8(1),
      ADR3 => CHOICE1642,
      O => XLXI_10_I2_TD_x(1)
    );
  XLXI_10_I2_TD_c_1_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_TD_c_1_FROM,
      O => CHOICE1642
    );
  XLXI_10_I2_TD_c_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_TD_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_10_I1_n0010_0_19_SW0 : X_LUT4
    generic map(
      INIT => X"F0AA"
    )
    port map (
      ADR0 => XLXI_10_I1_stack_addrs_c_1_0,
      ADR1 => VCC,
      ADR2 => XLXI_10_I1_stack_addrs_c_3_0,
      ADR3 => XLXI_10_I2_pc_mux_x_2_2,
      O => XLXI_10_I1_stack_addrs_c_2_0_FROM
    );
  XLXI_10_I1_n0010_0_19 : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_0_17_1,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_0,
      ADR3 => N23772,
      O => XLXI_10_I1_n0010_0_19_O
    );
  XLXI_10_I1_stack_addrs_c_2_0_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_2_0_FROM,
      O => N23772
    );
  XLXI_10_I2_TD_x_2_38 : X_LUT4
    generic map(
      INIT => X"0011"
    )
    port map (
      ADR0 => XLXN_8(0),
      ADR1 => XLXN_8(3),
      ADR2 => VCC,
      ADR3 => XLXN_8(1),
      O => XLXI_10_I2_TD_c_2_FROM
    );
  XLXI_10_I2_TD_x_2_72 : X_LUT4
    generic map(
      INIT => X"C8C0"
    )
    port map (
      ADR0 => CHOICE1591,
      ADR1 => NRESET_IBUF,
      ADR2 => XLXN_8(2),
      ADR3 => CHOICE1596,
      O => XLXI_10_I2_TD_x(2)
    );
  XLXI_10_I2_TD_c_2_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_TD_c_2_FROM,
      O => CHOICE1596
    );
  XLXI_10_I2_TD_c_2_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_TD_c_2_SRMUX_OUTPUTNOT
    );
  XLXI_10_I2_Ker80521 : X_LUT4
    generic map(
      INIT => X"EEEE"
    )
    port map (
      ADR0 => XLXN_8(2),
      ADR1 => XLXN_8(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I2_TC_c_1_FROM
    );
  XLXI_10_I2_TC_x_1_1 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXN_8(3),
      ADR2 => XLXN_8(0),
      ADR3 => XLXI_10_I2_N8054,
      O => XLXI_10_I2_TC_x(1)
    );
  XLXI_10_I2_TC_c_1_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_TC_c_1_FROM,
      O => XLXI_10_I2_N8054
    );
  XLXI_10_I2_TC_c_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_TC_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_10_I3_Mmux_data_x_Result_2_SW4 : X_LUT4
    generic map(
      INIT => X"C3F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I2_data_is_c(2),
      ADR2 => XLXI_10_I3_acc_c_0_2,
      ADR3 => XLXI_10_I3_n0037,
      O => N23481_FROM
    );
  XLXI_10_I3_Mmux_data_x_Result_2_SW1 : X_LUT4
    generic map(
      INIT => X"C30F"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I2_data_is_c(2),
      ADR2 => XLXI_10_I3_acc_c_0_2,
      ADR3 => XLXI_10_I3_n0037,
      O => N23481_GROM
    );
  N23481_XUSED : X_BUF
    port map (
      I => N23481_FROM,
      O => N23481
    );
  N23481_YUSED : X_BUF
    port map (
      I => N23481_GROM,
      O => N23397
    );
  XLXI_10_I3_Mmux_data_x_Result_3_SW4 : X_LUT4
    generic map(
      INIT => X"C3CC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I3_acc_c_0_3,
      ADR2 => XLXI_10_I2_data_is_c(3),
      ADR3 => XLXI_10_I3_n0037,
      O => N23591_FROM
    );
  XLXI_10_I3_Mmux_data_x_Result_2_SW2 : X_LUT4
    generic map(
      INIT => X"9A9A"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_2,
      ADR1 => XLXI_10_I2_data_is_c(2),
      ADR2 => XLXI_10_I3_n0037,
      ADR3 => VCC,
      O => N23591_GROM
    );
  N23591_XUSED : X_BUF
    port map (
      I => N23591_FROM,
      O => N23591
    );
  N23591_YUSED : X_BUF
    port map (
      I => N23591_GROM,
      O => N23399
    );
  XLXI_10_I3_n0035_4_37_SW0 : X_LUT4
    generic map(
      INIT => X"0F77"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(1),
      ADR1 => XLXI_10_I3_acc_c_0_0,
      ADR2 => XLXI_10_I3_acc_c_0_3,
      ADR3 => XLXI_10_I2_TD_c(0),
      O => N23863_FROM
    );
  XLXI_10_I3_n0035_4_37 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(1),
      ADR1 => XLXI_10_I2_TD_c(2),
      ADR2 => XLXI_10_I2_TC_c(0),
      ADR3 => N23863,
      O => N23863_GROM
    );
  N23863_XUSED : X_BUF
    port map (
      I => N23863_FROM,
      O => N23863
    );
  N23863_YUSED : X_BUF
    port map (
      I => N23863_GROM,
      O => CHOICE1864
    );
  XLXI_10_I3_Mmux_data_x_Result_2_SW3 : X_LUT4
    generic map(
      INIT => X"C30F"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_10_I2_data_is_c(2),
      ADR2 => XLXI_10_I3_acc_c_0_2,
      ADR3 => XLXI_10_I3_n0037,
      O => N23479_FROM
    );
  XLXI_10_I3_Madd_n0064_inst_lut2_261 : X_LUT4
    generic map(
      INIT => X"087F"
    )
    port map (
      ADR0 => N22134,
      ADR1 => XLXI_10_I4_N9468,
      ADR2 => N23481,
      ADR3 => N23479,
      O => N23479_GROM
    );
  N23479_XUSED : X_BUF
    port map (
      I => N23479_FROM,
      O => N23479
    );
  N23479_YUSED : X_BUF
    port map (
      I => N23479_GROM,
      O => XLXI_10_I3_Madd_n0064_inst_lut2_26
    );
  XLXI_10_I3_n0035_3_86_SW0 : X_LUT4
    generic map(
      INIT => X"88F8"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_2,
      ADR1 => XLXI_10_I3_N8705,
      ADR2 => XLXI_10_I3_n0054,
      ADR3 => XLXI_10_I3_acc_c_0_3,
      O => N23727_FROM
    );
  XLXI_10_I3_n0035_3_86 : X_LUT4
    generic map(
      INIT => X"F800"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_4,
      ADR1 => XLXI_10_I3_N8675,
      ADR2 => N23727,
      ADR3 => XLXI_10_I3_n0052,
      O => N23727_GROM
    );
  N23727_XUSED : X_BUF
    port map (
      I => N23727_FROM,
      O => N23727
    );
  N23727_YUSED : X_BUF
    port map (
      I => N23727_GROM,
      O => CHOICE2026
    );
  XLXI_10_I3_Mmux_data_x_Result_3_SW0 : X_LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      ADR0 => XLXI_10_I4_N9501,
      ADR1 => XLXI_2_mux_c(0),
      ADR2 => CTRL_DATA_IN_3_IBUF,
      ADR3 => RAM_DATA_OUT(3),
      O => N21808_FROM
    );
  XLXI_10_I3_Msub_n0059_inst_lut2_311 : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => N23485,
      ADR1 => N23487,
      ADR2 => XLXI_10_I4_N9468,
      ADR3 => N21808,
      O => N21808_GROM
    );
  N21808_XUSED : X_BUF
    port map (
      I => N21808_FROM,
      O => N21808
    );
  N21808_YUSED : X_BUF
    port map (
      I => N21808_GROM,
      O => XLXI_10_I3_Msub_n0059_inst_lut2_31
    );
  XLXI_10_I3_Mmux_data_x_Result_3_SW3 : X_LUT4
    generic map(
      INIT => X"9933"
    )
    port map (
      ADR0 => XLXI_10_I2_data_is_c(3),
      ADR1 => XLXI_10_I3_acc_c_0_3,
      ADR2 => VCC,
      ADR3 => XLXI_10_I3_n0037,
      O => N23589_FROM
    );
  XLXI_10_I3_Madd_n0064_inst_lut2_271 : X_LUT4
    generic map(
      INIT => X"087F"
    )
    port map (
      ADR0 => N21808,
      ADR1 => XLXI_10_I4_N9468,
      ADR2 => N23591,
      ADR3 => N23589,
      O => N23589_GROM
    );
  N23589_XUSED : X_BUF
    port map (
      I => N23589_FROM,
      O => N23589
    );
  N23589_YUSED : X_BUF
    port map (
      I => N23589_GROM,
      O => XLXI_10_I3_Madd_n0064_inst_lut2_27
    );
  XLXI_10_I1_iaddr_x_4_14 : X_LUT4
    generic map(
      INIT => X"D1C0"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => XLXI_10_pc_mux(1),
      ADR2 => XLXN_8(8),
      ADR3 => XLXI_10_I1_pc(4),
      O => CHOICE1745_FROM
    );
  XLXI_10_I1_iaddr_x_0_14 : X_LUT4
    generic map(
      INIT => X"88B8"
    )
    port map (
      ADR0 => XLXN_8(4),
      ADR1 => XLXI_10_pc_mux(1),
      ADR2 => XLXI_10_I1_pc(0),
      ADR3 => XLXI_10_pc_mux(0),
      O => CHOICE1745_GROM
    );
  CHOICE1745_XUSED : X_BUF
    port map (
      I => CHOICE1745_FROM,
      O => CHOICE1745
    );
  CHOICE1745_YUSED : X_BUF
    port map (
      I => CHOICE1745_GROM,
      O => CHOICE1760
    );
  XLXI_10_I1_iaddr_x_2_14 : X_LUT4
    generic map(
      INIT => X"88B8"
    )
    port map (
      ADR0 => XLXN_8(6),
      ADR1 => XLXI_10_pc_mux(1),
      ADR2 => XLXI_10_I1_pc(2),
      ADR3 => XLXI_10_pc_mux(0),
      O => CHOICE1685_FROM
    );
  XLXI_10_I2_ndre_x_SW3 : X_LUT4
    generic map(
      INIT => X"FFAB"
    )
    port map (
      ADR0 => XLXN_8(6),
      ADR1 => XLXN_8(2),
      ADR2 => XLXN_8(1),
      ADR3 => XLXN_8(3),
      O => CHOICE1685_GROM
    );
  CHOICE1685_XUSED : X_BUF
    port map (
      I => CHOICE1685_FROM,
      O => CHOICE1685
    );
  CHOICE1685_YUSED : X_BUF
    port map (
      I => CHOICE1685_GROM,
      O => N23595
    );
  XLXI_10_I1_iaddr_x_7_14 : X_LUT4
    generic map(
      INIT => X"AA0C"
    )
    port map (
      ADR0 => XLXI_10_I4_ipage_c(1),
      ADR1 => XLXI_10_I1_pc(7),
      ADR2 => XLXI_10_pc_mux(0),
      ADR3 => XLXI_10_pc_mux(1),
      O => CHOICE1700_FROM
    );
  XLXI_10_I1_iaddr_x_1_14 : X_LUT4
    generic map(
      INIT => X"CE02"
    )
    port map (
      ADR0 => XLXI_10_I1_pc(1),
      ADR1 => XLXI_10_pc_mux(1),
      ADR2 => XLXI_10_pc_mux(0),
      ADR3 => XLXN_8(5),
      O => CHOICE1700_GROM
    );
  CHOICE1700_XUSED : X_BUF
    port map (
      I => CHOICE1700_FROM,
      O => CHOICE1700
    );
  CHOICE1700_YUSED : X_BUF
    port map (
      I => CHOICE1700_GROM,
      O => CHOICE1670
    );
  XLXI_10_I1_nreset_v_1_LOGIC_ONE_142 : X_ONE
    port map (
      O => XLXI_10_I1_nreset_v_1_LOGIC_ONE
    );
  XLXI_10_I1_nreset_v_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I1_nreset_v_1_SRMUX_OUTPUTNOT
    );
  XLXI_10_I1_iaddr_x_6_14 : X_LUT4
    generic map(
      INIT => X"A3A0"
    )
    port map (
      ADR0 => XLXI_10_I4_ipage_c(0),
      ADR1 => XLXI_10_pc_mux(0),
      ADR2 => XLXI_10_pc_mux(1),
      ADR3 => XLXI_10_I1_pc(6),
      O => CHOICE1730_GROM
    );
  CHOICE1730_YUSED : X_BUF
    port map (
      I => CHOICE1730_GROM,
      O => CHOICE1730
    );
  XLXI_3_n00251 : X_LUT4
    generic map(
      INIT => X"1D00"
    )
    port map (
      ADR0 => XLXI_3_n0017,
      ADR1 => XLXI_3_pwm_c,
      ADR2 => XLXI_3_n0018,
      ADR3 => XLXI_2_ctrl_data_c(0),
      O => XLXI_3_n0025_GROM
    );
  XLXI_3_n0025_YUSED : X_BUF
    port map (
      I => XLXI_3_n0025_GROM,
      O => XLXI_3_n0025
    );
  XLXI_10_I2_nreset_v_1_LOGIC_ONE_143 : X_ONE
    port map (
      O => XLXI_10_I2_nreset_v_1_LOGIC_ONE
    );
  XLXI_10_I2_nreset_v_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_nreset_v_1_SRMUX_OUTPUTNOT
    );
  XLXI_10_I2_TD_x_3_SW0 : X_LUT4
    generic map(
      INIT => X"FFFD"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXN_8(3),
      ADR2 => XLXN_8(2),
      ADR3 => XLXN_8(0),
      O => XLXI_10_I2_TD_c_3_FROM
    );
  XLXI_10_I2_TD_x_3_Q : X_LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      ADR0 => XLXN_8(6),
      ADR1 => XLXN_8(7),
      ADR2 => XLXN_8(1),
      ADR3 => N20573,
      O => XLXI_10_I2_TD_x(3)
    );
  XLXI_10_I2_TD_c_3_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_TD_c_3_FROM,
      O => N20573
    );
  XLXI_10_I2_TD_c_3_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_TD_c_3_SRMUX_OUTPUTNOT
    );
  XLXI_10_I4_Ker9481_SW2 : X_LUT4
    generic map(
      INIT => X"5FFF"
    )
    port map (
      ADR0 => XLXN_8(4),
      ADR1 => VCC,
      ADR2 => XLXI_10_I4_ipage_c(1),
      ADR3 => XLXN_8(5),
      O => N23563_GROM
    );
  N23563_YUSED : X_BUF
    port map (
      I => N23563_GROM,
      O => N23563
    );
  XLXI_10_I3_nreset_v_1_LOGIC_ONE_144 : X_ONE
    port map (
      O => XLXI_10_I3_nreset_v_1_LOGIC_ONE
    );
  XLXI_10_I3_nreset_v_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I3_nreset_v_1_SRMUX_OUTPUTNOT
    );
  XLXI_10_I4_nreset_v_1_LOGIC_ONE_145 : X_ONE
    port map (
      O => XLXI_10_I4_nreset_v_1_LOGIC_ONE
    );
  XLXI_10_I4_nreset_v_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I4_nreset_v_1_SRMUX_OUTPUTNOT
    );
  XLXI_10_I2_TC_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_TC_x(2),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I2_TC_c_2_FFY_RST,
      O => XLXI_10_I2_TC_c(2)
    );
  XLXI_10_I2_TC_c_2_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I2_TC_c_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I2_TC_c_2_FFY_RST
    );
  XLXI_3_pwm_high_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(3),
      CE => XLXI_3_n0024,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_high_2_FFY_RST,
      O => XLXI_3_pwm_high(3)
    );
  XLXI_3_pwm_high_2_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_high_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_high_2_FFY_RST
    );
  XLXI_3_pwm_high_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(0),
      CE => XLXI_3_n0024,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_high_0_FFX_RST,
      O => XLXI_3_pwm_high(0)
    );
  XLXI_3_pwm_high_0_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_high_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_high_0_FFX_RST
    );
  XLXI_3_pwm_high_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(7),
      CE => XLXI_3_n0024,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_high_6_FFY_RST,
      O => XLXI_3_pwm_high(7)
    );
  XLXI_3_pwm_high_6_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_high_6_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_high_6_FFY_RST
    );
  XLXI_3_pwm_high_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(2),
      CE => XLXI_3_n0024,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_high_2_FFX_RST,
      O => XLXI_3_pwm_high(2)
    );
  XLXI_3_pwm_high_2_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_high_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_high_2_FFX_RST
    );
  XLXI_3_pwm_high_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(5),
      CE => XLXI_3_n0024,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_high_4_FFY_RST,
      O => XLXI_3_pwm_high(5)
    );
  XLXI_3_pwm_high_4_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_high_4_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_high_4_FFY_RST
    );
  XLXI_3_pwm_c_146 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_c_BYMUXNOT,
      CE => XLXI_3_n0025,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_c_FFY_RST,
      O => XLXI_3_pwm_c
    );
  XLXI_3_pwm_c_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_c_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_c_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_2_7_147 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0010_7_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_2_7_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_2_7
    );
  XLXI_10_I1_stack_addrs_c_2_7_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_2_7_FFY_RST
    );
  XLXI_2_ctrl_data_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT_0_OBUF,
      CE => XLXI_2_n0039,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_2_ctrl_data_c_0_FFY_RST,
      O => XLXI_2_ctrl_data_c(0)
    );
  XLXI_2_ctrl_data_c_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_2_ctrl_data_c_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_2_ctrl_data_c_0_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_3_0_148 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0009_0_1_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_3_0_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_3_0
    );
  XLXI_10_I1_stack_addrs_c_3_0_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_3_0_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_2_4_149 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0010_4_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_2_4_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_2_4
    );
  XLXI_10_I1_stack_addrs_c_2_4_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_2_4_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_2_5_150 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0010_5_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_2_5_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_2_5
    );
  XLXI_10_I1_stack_addrs_c_2_5_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_2_5_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_3_3_151 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0009_3_1_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_3_3_FFX_RST,
      O => XLXI_10_I1_stack_addrs_c_3_3
    );
  XLXI_10_I1_stack_addrs_c_3_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_3_3_FFX_RST
    );
  XLXI_10_I1_stack_addrs_c_3_2_152 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0009_2_1_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_3_3_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_3_2
    );
  XLXI_10_I1_stack_addrs_c_3_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_3_3_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_2_6_153 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0010_6_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_2_6_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_2_6
    );
  XLXI_10_I1_stack_addrs_c_2_6_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_2_6_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_3_5_154 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0009_5_1_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_3_5_FFX_RST,
      O => XLXI_10_I1_stack_addrs_c_3_5
    );
  XLXI_10_I1_stack_addrs_c_3_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_3_5_FFX_RST
    );
  XLXI_10_I1_stack_addrs_c_3_4_155 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0009_4_1_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_3_5_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_3_4
    );
  XLXI_10_I1_stack_addrs_c_3_5_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_3_5_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_3_6_156 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0009_6_1_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_3_7_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_3_6
    );
  XLXI_10_I1_stack_addrs_c_3_7_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_3_7_FFY_RST
    );
  XLXI_10_I1_pc_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_pc_7_GROM,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_pc_7_FFY_RST,
      O => XLXI_10_I1_pc(7)
    );
  XLXI_10_I1_pc_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I1_pc_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I1_pc_7_FFY_RST
    );
  XLXI_2_pwm_data_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_Mmux_n0018_Result_0_1_O,
      CE => XLXI_2_n0038,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_2_pwm_data_c_1_FFY_RST,
      O => XLXI_2_pwm_data_c(0)
    );
  XLXI_2_pwm_data_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_2_pwm_data_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_2_pwm_data_c_1_FFY_RST
    );
  XLXI_2_pwm_data_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_Mmux_n0018_Result_2_1_O,
      CE => XLXI_2_n0038,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_2_pwm_data_c_3_FFY_RST,
      O => XLXI_2_pwm_data_c(2)
    );
  XLXI_2_pwm_data_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_2_pwm_data_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_2_pwm_data_c_3_FFY_RST
    );
  XLXI_2_pwm_data_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_Mmux_n0018_Result_1_1_O,
      CE => XLXI_2_n0038,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_2_pwm_data_c_1_FFX_RST,
      O => XLXI_2_pwm_data_c(1)
    );
  XLXI_2_pwm_data_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_2_pwm_data_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_2_pwm_data_c_1_FFX_RST
    );
  XLXI_2_pwm_data_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_Mmux_n0018_Result_3_1_O,
      CE => XLXI_2_n0038,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_2_pwm_data_c_3_FFX_RST,
      O => XLXI_2_pwm_data_c(3)
    );
  XLXI_2_pwm_data_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_2_pwm_data_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_2_pwm_data_c_3_FFX_RST
    );
  XLXI_3_pwm_high_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(1),
      CE => XLXI_3_n0024,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_high_0_FFY_RST,
      O => XLXI_3_pwm_high(1)
    );
  XLXI_3_pwm_high_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_high_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_high_0_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_0_3_157 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0012_3_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_0_3_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_0_3
    );
  XLXI_10_I1_stack_addrs_c_0_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_0_3_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_0_4_158 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0012_4_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_0_4_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_0_4
    );
  XLXI_10_I1_stack_addrs_c_0_4_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_0_4_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_0_5_159 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0012_5_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_0_5_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_0_5
    );
  XLXI_10_I1_stack_addrs_c_0_5_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_0_5_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_0_6_160 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0012_6_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_0_6_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_0_6
    );
  XLXI_10_I1_stack_addrs_c_0_6_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_0_6_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_3_1_161 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0009_1_1_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_3_1_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_3_1
    );
  XLXI_10_I1_stack_addrs_c_3_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_3_1_FFY_RST
    );
  XLXI_10_I1_pc_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_pc_1_GROM,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_pc_1_FFY_RST,
      O => XLXI_10_I1_pc(1)
    );
  XLXI_10_I1_pc_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I1_pc_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I1_pc_1_FFY_RST
    );
  XLXI_10_I1_pc_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_pc_0_GROM,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_pc_0_FFY_RST,
      O => XLXI_10_I1_pc(0)
    );
  XLXI_10_I1_pc_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I1_pc_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I1_pc_0_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_0_1_162 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0012_1_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_0_1_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_0_1
    );
  XLXI_10_I1_stack_addrs_c_0_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_0_1_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_1_5_163 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0011_5_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_1_5_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_1_5
    );
  XLXI_10_I1_stack_addrs_c_1_5_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_1_5_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_0_2_164 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0012_2_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_0_2_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_0_2
    );
  XLXI_10_I1_stack_addrs_c_0_2_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_0_2_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_1_6_165 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0011_6_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_1_6_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_1_6
    );
  XLXI_10_I1_stack_addrs_c_1_6_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_1_6_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_1_7_166 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0011_7_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_1_7_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_1_7
    );
  XLXI_10_I1_stack_addrs_c_1_7_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_1_7_FFY_RST
    );
  XLXI_3_pwm_low_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_pwm_data_c(0),
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_low_5_FFY_RST,
      O => XLXI_3_pwm_low(4)
    );
  XLXI_3_pwm_low_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_low_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_low_5_FFY_RST
    );
  XLXI_3_pwm_high_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(4),
      CE => XLXI_3_n0024,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_high_4_FFX_RST,
      O => XLXI_3_pwm_high(4)
    );
  XLXI_3_pwm_high_4_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_high_4_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_high_4_FFX_RST
    );
  XLXI_3_pwm_high_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(6),
      CE => XLXI_3_n0024,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_high_6_FFX_RST,
      O => XLXI_3_pwm_high(6)
    );
  XLXI_3_pwm_high_6_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_high_6_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_high_6_FFX_RST
    );
  XLXI_3_pwm_period_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0009_1_1_O,
      CE => NRESET_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_period_1_FFX_RST,
      O => XLXI_3_pwm_period(1)
    );
  XLXI_3_pwm_period_1_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_3_pwm_period_1_FFX_RST
    );
  XLXI_3_pwm_period_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0009_2_1_O,
      CE => NRESET_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_period_3_FFY_RST,
      O => XLXI_3_pwm_period(2)
    );
  XLXI_3_pwm_period_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_3_pwm_period_3_FFY_RST
    );
  XLXI_3_pwm_period_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0009_3_1_O,
      CE => NRESET_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_period_3_FFX_RST,
      O => XLXI_3_pwm_period(3)
    );
  XLXI_3_pwm_period_3_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_3_pwm_period_3_FFX_RST
    );
  XLXI_3_pwm_period_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0009_7_1_O,
      CE => NRESET_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_period_7_FFX_RST,
      O => XLXI_3_pwm_period(7)
    );
  XLXI_3_pwm_period_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_3_pwm_period_7_FFX_RST
    );
  XLXI_3_pwm_period_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0009_4_1_O,
      CE => NRESET_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_period_5_FFY_RST,
      O => XLXI_3_pwm_period(4)
    );
  XLXI_3_pwm_period_5_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_3_pwm_period_5_FFY_RST
    );
  XLXI_3_pwm_period_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0009_5_1_O,
      CE => NRESET_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_period_5_FFX_RST,
      O => XLXI_3_pwm_period(5)
    );
  XLXI_3_pwm_period_5_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_3_pwm_period_5_FFX_RST
    );
  XLXI_3_pwm_period_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0009_6_1_O,
      CE => NRESET_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_period_7_FFY_RST,
      O => XLXI_3_pwm_period(6)
    );
  XLXI_3_pwm_period_7_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_3_pwm_period_7_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_0_0_167 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0012_0_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_0_0_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_0_0
    );
  XLXI_10_I1_stack_addrs_c_0_0_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_0_0_FFY_RST
    );
  XLXI_3_pwm_period_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0009_0_1_O,
      CE => NRESET_IBUF,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_period_1_FFY_RST,
      O => XLXI_3_pwm_period(0)
    );
  XLXI_3_pwm_period_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_3_pwm_period_1_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_3_7_168 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0009_7_1_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_3_7_FFX_RST,
      O => XLXI_10_I1_stack_addrs_c_3_7
    );
  XLXI_10_I1_stack_addrs_c_3_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_3_7_FFX_RST
    );
  XLXI_10_I3_acc_c_0_4_169 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I3_n0035_4_96_O,
      CE => XLXI_10_I3_n0073,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I3_acc_c_0_4_FFY_RST,
      O => XLXI_10_I3_acc_c_0_4
    );
  XLXI_10_I3_acc_c_0_4_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I3_acc_c_0_4_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I3_acc_c_0_4_FFY_RST
    );
  XLXI_10_I3_acc_c_0_0_170 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I3_n0035_0_220_O,
      CE => XLXI_10_I3_n0073,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I3_acc_c_0_0_FFY_RST,
      O => XLXI_10_I3_acc_c_0_0
    );
  XLXI_10_I3_acc_c_0_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I3_acc_c_0_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I3_acc_c_0_0_FFY_RST
    );
  XLXI_10_I3_acc_c_0_1_171 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I3_n0035_1_145_O,
      CE => XLXI_10_I3_n0073,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I3_acc_c_0_1_FFY_RST,
      O => XLXI_10_I3_acc_c_0_1
    );
  XLXI_10_I3_acc_c_0_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I3_acc_c_0_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I3_acc_c_0_1_FFY_RST
    );
  XLXI_10_I3_acc_c_0_2_172 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I3_n0035_2_145_O,
      CE => XLXI_10_I3_n0073,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I3_acc_c_0_2_FFY_RST,
      O => XLXI_10_I3_acc_c_0_2
    );
  XLXI_10_I3_acc_c_0_2_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I3_acc_c_0_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I3_acc_c_0_2_FFY_RST
    );
  XLXI_10_I1_pc_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_pc_2_GROM,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_pc_2_FFY_RST,
      O => XLXI_10_I1_pc(2)
    );
  XLXI_10_I1_pc_2_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I1_pc_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I1_pc_2_FFY_RST
    );
  XLXI_10_I1_pc_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_pc_3_GROM,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_pc_3_FFY_RST,
      O => XLXI_10_I1_pc(3)
    );
  XLXI_10_I1_pc_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I1_pc_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I1_pc_3_FFY_RST
    );
  XLXI_10_I1_pc_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_pc_4_GROM,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_pc_4_FFY_RST,
      O => XLXI_10_I1_pc(4)
    );
  XLXI_10_I1_pc_4_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I1_pc_4_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I1_pc_4_FFY_RST
    );
  XLXI_10_I1_pc_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_pc_5_GROM,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_pc_5_FFY_RST,
      O => XLXI_10_I1_pc(5)
    );
  XLXI_10_I1_pc_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I1_pc_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I1_pc_5_FFY_RST
    );
  XLXI_10_I1_pc_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_pc_6_GROM,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_pc_6_FFY_RST,
      O => XLXI_10_I1_pc(6)
    );
  XLXI_10_I1_pc_6_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I1_pc_6_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I1_pc_6_FFY_RST
    );
  XLXI_10_I4_nreset_v_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I4_n0031(0),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I4_nreset_v_0_FFY_RST,
      O => XLXI_10_I4_nreset_v(0)
    );
  XLXI_10_I4_nreset_v_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I4_nreset_v_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I4_nreset_v_0_FFY_RST
    );
  XLXI_10_I3_acc_c_0_3_173 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I3_n0035_3_145_O,
      CE => XLXI_10_I3_n0073,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I3_acc_c_0_3_FFY_RST,
      O => XLXI_10_I3_acc_c_0_3
    );
  XLXI_10_I3_acc_c_0_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I3_acc_c_0_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I3_acc_c_0_3_FFY_RST
    );
  XLXI_2_mux_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_mux_c_0_FROM,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_2_mux_c_0_FFX_RST,
      O => XLXI_2_mux_c(0)
    );
  XLXI_2_mux_c_0_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_2_mux_c_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_2_mux_c_0_FFX_RST
    );
  XLXI_10_I1_stack_addrs_c_0_7_174 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0012_7_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_0_7_FFX_RST,
      O => XLXI_10_I1_stack_addrs_c_0_7
    );
  XLXI_10_I1_stack_addrs_c_0_7_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_0_7_FFX_RST
    );
  XLXI_10_I1_stack_addrs_c_1_0_175 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0011_0_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_0_7_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_1_0
    );
  XLXI_10_I1_stack_addrs_c_0_7_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_0_7_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_1_1_176 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0011_1_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_1_1_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_1_1
    );
  XLXI_10_I1_stack_addrs_c_1_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_1_1_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_1_2_177 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0011_2_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_1_2_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_1_2
    );
  XLXI_10_I1_stack_addrs_c_1_2_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_1_2_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_1_3_178 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0011_3_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_1_3_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_1_3
    );
  XLXI_10_I1_stack_addrs_c_1_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_1_3_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_1_4_179 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0011_4_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_1_4_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_1_4
    );
  XLXI_10_I1_stack_addrs_c_1_4_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_1_4_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_2_1_180 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0010_1_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_2_1_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_2_1
    );
  XLXI_10_I1_stack_addrs_c_2_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_2_1_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_2_3_181 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0010_3_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_2_3_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_2_3
    );
  XLXI_10_I1_stack_addrs_c_2_3_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_2_3_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_2_2_182 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0010_2_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_2_2_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_2_2
    );
  XLXI_10_I1_stack_addrs_c_2_2_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_2_2_FFY_RST
    );
  XLXI_10_I2_skip_c_183 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_skip_c_GROM,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I2_skip_c_FFY_RST,
      O => XLXI_10_I2_skip_c
    );
  XLXI_10_I2_skip_c_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I2_skip_c_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I2_skip_c_FFY_RST
    );
  XLXI_10_I1_nreset_v_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_nreset_v_1_LOGIC_ONE,
      CE => XLXI_10_I1_nreset_v(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_nreset_v_1_FFY_RST,
      O => XLXI_10_I1_nreset_v(1)
    );
  XLXI_10_I1_nreset_v_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I1_nreset_v_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I1_nreset_v_1_FFY_RST
    );
  XLXI_3_pwm_low_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_low_1_FROM,
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_low_1_FFX_RST,
      O => XLXI_3_pwm_low(1)
    );
  XLXI_3_pwm_low_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_low_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_low_1_FFX_RST
    );
  XLXI_10_I4_ipage_we_c_184 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I4_ipage_we_x,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I4_ipage_we_c_FFY_RST,
      O => XLXI_10_I4_ipage_we_c
    );
  XLXI_10_I4_ipage_we_c_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I4_ipage_we_c_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I4_ipage_we_c_FFY_RST
    );
  XLXI_3_pwm_low_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_low_3_FROM,
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_low_3_FFX_RST,
      O => XLXI_3_pwm_low(3)
    );
  XLXI_3_pwm_low_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_low_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_low_3_FFX_RST
    );
  XLXI_10_I4_ipage_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I4_n0030(0),
      CE => XLXI_10_I4_n0044,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I4_ipage_c_1_FFY_RST,
      O => XLXI_10_I4_ipage_c(0)
    );
  XLXI_10_I4_ipage_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I4_ipage_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I4_ipage_c_1_FFY_RST
    );
  XLXI_10_I4_ipage_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I4_n0030(1),
      CE => XLXI_10_I4_n0044,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I4_ipage_c_1_FFX_RST,
      O => XLXI_10_I4_ipage_c(1)
    );
  XLXI_10_I4_ipage_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I4_ipage_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I4_ipage_c_1_FFX_RST
    );
  XLXI_10_I5_daddr_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_adaddr_out(0),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I5_daddr_c_1_FFY_RST,
      O => XLXI_10_I5_daddr_c(0)
    );
  XLXI_10_I5_daddr_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I5_daddr_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I5_daddr_c_1_FFY_RST
    );
  XLXI_10_I2_data_is_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXN_8(4),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I2_data_is_c_1_FFY_RST,
      O => XLXI_10_I2_data_is_c(0)
    );
  XLXI_10_I2_data_is_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I2_data_is_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I2_data_is_c_1_FFY_RST
    );
  XLXI_10_I2_data_is_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXN_8(6),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I2_data_is_c_3_FFY_RST,
      O => XLXI_10_I2_data_is_c(2)
    );
  XLXI_10_I2_data_is_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I2_data_is_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I2_data_is_c_3_FFY_RST
    );
  XLXI_10_I2_data_is_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXN_8(5),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I2_data_is_c_1_FFX_RST,
      O => XLXI_10_I2_data_is_c(1)
    );
  XLXI_10_I2_data_is_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I2_data_is_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I2_data_is_c_1_FFX_RST
    );
  XLXI_10_I2_data_is_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXN_8(7),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I2_data_is_c_3_FFX_RST,
      O => XLXI_10_I2_data_is_c(3)
    );
  XLXI_10_I2_data_is_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I2_data_is_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I2_data_is_c_3_FFX_RST
    );
  XLXI_10_I5_daddr_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I5_daddr_c_3_GROM,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I5_daddr_c_3_FFY_RST,
      O => XLXI_10_I5_daddr_c(2)
    );
  XLXI_10_I5_daddr_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I5_daddr_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I5_daddr_c_3_FFY_RST
    );
  XLXI_10_I5_daddr_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_adaddr_out(1),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I5_daddr_c_1_FFX_RST,
      O => XLXI_10_I5_daddr_c(1)
    );
  XLXI_10_I5_daddr_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I5_daddr_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I5_daddr_c_1_FFX_RST
    );
  XLXI_10_I5_daddr_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_adaddr_out(4),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I5_daddr_c_5_FFY_RST,
      O => XLXI_10_I5_daddr_c(4)
    );
  XLXI_10_I5_daddr_c_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I5_daddr_c_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I5_daddr_c_5_FFY_RST
    );
  XLXI_10_I1_nreset_v_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0008(0),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_nreset_v_0_FFY_RST,
      O => XLXI_10_I1_nreset_v(0)
    );
  XLXI_10_I1_nreset_v_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I1_nreset_v_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I1_nreset_v_0_FFY_RST
    );
  XLXI_10_I5_daddr_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_adaddr_out(3),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I5_daddr_c_3_FFX_RST,
      O => XLXI_10_I5_daddr_c(3)
    );
  XLXI_10_I5_daddr_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I5_daddr_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I5_daddr_c_3_FFX_RST
    );
  XLXI_10_I5_daddr_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I5_daddr_c_5_FROM,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I5_daddr_c_5_FFX_RST,
      O => XLXI_10_I5_daddr_c(5)
    );
  XLXI_10_I5_daddr_c_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I5_daddr_c_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I5_daddr_c_5_FFX_RST
    );
  XLXI_10_I2_nreset_v_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_n0028(0),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I2_nreset_v_0_FFY_RST,
      O => XLXI_10_I2_nreset_v(0)
    );
  XLXI_10_I2_nreset_v_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I2_nreset_v_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I2_nreset_v_0_FFY_RST
    );
  XLXI_10_I3_nreset_v_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I3_n0036(0),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I3_nreset_v_0_FFY_RST,
      O => XLXI_10_I3_nreset_v(0)
    );
  XLXI_10_I3_nreset_v_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I3_nreset_v_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I3_nreset_v_0_FFY_RST
    );
  XLXI_3_pwm_count_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006(0),
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_count_1_FFY_RST,
      O => XLXI_3_pwm_count(0)
    );
  XLXI_3_pwm_count_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_count_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_count_1_FFY_RST
    );
  XLXI_3_pwm_count_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006(2),
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_count_3_FFY_RST,
      O => XLXI_3_pwm_count(2)
    );
  XLXI_3_pwm_count_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_count_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_count_3_FFY_RST
    );
  XLXI_3_pwm_count_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006(1),
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_count_1_FFX_RST,
      O => XLXI_3_pwm_count(1)
    );
  XLXI_3_pwm_count_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_count_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_count_1_FFX_RST
    );
  XLXI_3_pwm_low_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_low_1_GROM,
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_low_1_FFY_RST,
      O => XLXI_3_pwm_low(0)
    );
  XLXI_3_pwm_low_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_low_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_low_1_FFY_RST
    );
  XLXI_3_pwm_count_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006(3),
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_count_3_FFX_RST,
      O => XLXI_3_pwm_count(3)
    );
  XLXI_3_pwm_count_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_count_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_count_3_FFX_RST
    );
  XLXI_3_pwm_count_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006(4),
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_count_5_FFY_RST,
      O => XLXI_3_pwm_count(4)
    );
  XLXI_3_pwm_count_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_count_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_count_5_FFY_RST
    );
  XLXI_3_pwm_count_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006(5),
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_count_5_FFX_RST,
      O => XLXI_3_pwm_count(5)
    );
  XLXI_3_pwm_count_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_count_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_count_5_FFX_RST
    );
  XLXI_3_pwm_count_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006(6),
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_count_7_FFY_RST,
      O => XLXI_3_pwm_count(6)
    );
  XLXI_3_pwm_count_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_count_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_count_7_FFY_RST
    );
  XLXI_3_pwm_count_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006(7),
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_count_7_FFX_RST,
      O => XLXI_3_pwm_count(7)
    );
  XLXI_3_pwm_count_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_count_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_count_7_FFX_RST
    );
  XLXI_3_pwm_low_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_pwm_data_c(2),
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_low_7_FFY_RST,
      O => XLXI_3_pwm_low(6)
    );
  XLXI_3_pwm_low_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_low_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_low_7_FFY_RST
    );
  XLXI_3_pwm_low_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_pwm_data_c(1),
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_low_5_FFX_RST,
      O => XLXI_3_pwm_low(5)
    );
  XLXI_3_pwm_low_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_low_5_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_low_5_FFX_RST
    );
  XLXI_10_I2_TC_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_TC_x(0),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I2_TC_c_0_FFY_RST,
      O => XLXI_10_I2_TC_c(0)
    );
  XLXI_10_I2_TC_c_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I2_TC_c_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I2_TC_c_0_FFY_RST
    );
  XLXI_3_pwm_low_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_pwm_data_c(3),
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_3_pwm_low_7_FFX_RST,
      O => XLXI_3_pwm_low(7)
    );
  XLXI_3_pwm_low_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_pwm_low_7_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_3_pwm_low_7_FFX_RST
    );
  XLXI_10_I5_ndwe_c_185 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_10_nadwe_out,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => XLXI_10_I5_ndwe_c_FFY_SET,
      RST => GND,
      O => XLXI_10_I5_ndwe_c
    );
  XLXI_10_I5_ndwe_c_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_10_I5_ndwe_c_SRMUX_OUTPUTNOT,
      O => XLXI_10_I5_ndwe_c_FFY_SET
    );
  XLXI_10_I2_TD_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_TD_x(0),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I2_TD_c_0_FFY_RST,
      O => XLXI_10_I2_TD_c(0)
    );
  XLXI_10_I2_TD_c_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I2_TD_c_0_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I2_TD_c_0_FFY_RST
    );
  XLXI_10_I2_TD_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_TD_x(1),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I2_TD_c_1_FFY_RST,
      O => XLXI_10_I2_TD_c(1)
    );
  XLXI_10_I2_TD_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I2_TD_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I2_TD_c_1_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_2_0_186 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0010_0_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_2_0_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_2_0
    );
  XLXI_10_I1_stack_addrs_c_2_0_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_2_0_FFY_RST
    );
  XLXI_10_I2_TD_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_TD_x(2),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I2_TD_c_2_FFY_RST,
      O => XLXI_10_I2_TD_c(2)
    );
  XLXI_10_I2_TD_c_2_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I2_TD_c_2_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I2_TD_c_2_FFY_RST
    );
  XLXI_10_I2_TC_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_TC_x(1),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I2_TC_c_1_FFY_RST,
      O => XLXI_10_I2_TC_c(1)
    );
  XLXI_10_I2_TC_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I2_TC_c_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I2_TC_c_1_FFY_RST
    );
  XLXI_10_I2_nreset_v_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_nreset_v_1_LOGIC_ONE,
      CE => XLXI_10_I2_nreset_v(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I2_nreset_v_1_FFY_RST,
      O => XLXI_10_I2_nreset_v(1)
    );
  XLXI_10_I2_nreset_v_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I2_nreset_v_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I2_nreset_v_1_FFY_RST
    );
  XLXI_10_I2_TD_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_TD_x(3),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I2_TD_c_3_FFY_RST,
      O => XLXI_10_I2_TD_c(3)
    );
  XLXI_10_I2_TD_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I2_TD_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I2_TD_c_3_FFY_RST
    );
  XLXI_10_I3_nreset_v_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I3_nreset_v_1_LOGIC_ONE,
      CE => XLXI_10_I3_nreset_v(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I3_nreset_v_1_FFY_RST,
      O => XLXI_10_I3_nreset_v(1)
    );
  XLXI_10_I3_nreset_v_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I3_nreset_v_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I3_nreset_v_1_FFY_RST
    );
  XLXI_10_I4_nreset_v_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I4_nreset_v_1_LOGIC_ONE,
      CE => XLXI_10_I4_nreset_v(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I4_nreset_v_1_FFY_RST,
      O => XLXI_10_I4_nreset_v(1)
    );
  XLXI_10_I4_nreset_v_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I4_nreset_v_1_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I4_nreset_v_1_FFY_RST
    );
  CLK_BUF : X_CKBUF
    port map (
      I => CLK,
      O => CLK_BUFGP_IBUFG
    );
  CLK_BUFGP_BUFG_BUF : X_CKBUF
    port map (
      I => CLK_BUFGP_IBUFG,
      O => CLK_BUFGP
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
      O => GLOBAL_LOGIC0_0
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
      O => GLOBAL_LOGIC0_1
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
      O => GLOBAL_LOGIC0_2
    );
  NlwBlock_cpu4bit_VCC : X_ONE
    port map (
      O => VCC
    );
  NlwBlock_cpu4bit_GND : X_ZERO
    port map (
      O => GND
    );
  NlwBlockROC : X_ROC
    generic map (ROC_WIDTH => 100 ns)
    port map (O => GSR);
  NlwBlockTOC : X_TOC
    port map (O => GTS);

end Structure;

