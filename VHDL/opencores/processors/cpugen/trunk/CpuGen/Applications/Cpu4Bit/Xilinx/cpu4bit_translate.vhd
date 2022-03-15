-- Xilinx Vhdl netlist produced by netgen application (version G.25a)
-- Command       : -intstyle ise -rpw 100 -tpw 0 -ar Structure -xon true -w -ofmt vhdl -sim cpu4bit.ngd cpu4bit_translate.vhd 
-- Input file    : cpu4bit.ngd
-- Output file   : cpu4bit_translate.vhd
-- Design name   : cpu4bit
-- # of Entities : 1
-- Xilinx        : C:/Xilinx
-- Device        : 2s30cs144-5

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
    CLK : in STD_LOGIC := 'X'; 
    NRESET : in STD_LOGIC := 'X'; 
    PWM_OUT : out STD_LOGIC; 
    nWE_CPU : out STD_LOGIC; 
    nRE_CPU : out STD_LOGIC; 
    CTRL_DATA_IN : in STD_LOGIC_VECTOR ( 3 downto 0 ); 
    CPU_DATA_OUT : out STD_LOGIC_VECTOR ( 3 downto 0 ); 
    CPU_IADDR : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    CTRL_DATA_OUT : out STD_LOGIC_VECTOR ( 3 downto 0 ); 
    CPU_DADDR : out STD_LOGIC_VECTOR ( 5 downto 0 ) 
  );
end cpu4bit;

architecture Structure of cpu4bit is
  signal CLK_BUFGP : STD_LOGIC; 
  signal XLXI_3_pwm_c : STD_LOGIC; 
  signal NRESET_IBUF : STD_LOGIC; 
  signal XLXI_10_I5_ndwe_c : STD_LOGIC; 
  signal nRE_CPU_OBUF : STD_LOGIC; 
  signal XLXI_10_I4_N9730 : STD_LOGIC; 
  signal CPU_IADDR_3_OBUF : STD_LOGIC; 
  signal nCS_PWM : STD_LOGIC; 
  signal nWR_RAM : STD_LOGIC; 
  signal CPU_IADDR_5_OBUF : STD_LOGIC; 
  signal CTRL_DATA_IN_2_IBUF : STD_LOGIC; 
  signal CPU_DATA_OUT_3_OBUF : STD_LOGIC; 
  signal CTRL_DATA_IN_3_IBUF : STD_LOGIC; 
  signal CPU_DATA_OUT_1_OBUF : STD_LOGIC; 
  signal CPU_DADDR_3_OBUF : STD_LOGIC; 
  signal XLXI_2_n0042 : STD_LOGIC; 
  signal CPU_DADDR_2_OBUF : STD_LOGIC; 
  signal CPU_IADDR_0_OBUF : STD_LOGIC; 
  signal CTRL_DATA_IN_1_IBUF : STD_LOGIC; 
  signal CPU_IADDR_1_OBUF : STD_LOGIC; 
  signal CPU_DADDR_5_OBUF : STD_LOGIC; 
  signal CPU_DATA_OUT_2_OBUF : STD_LOGIC; 
  signal CTRL_DATA_IN_0_IBUF : STD_LOGIC; 
  signal CPU_DADDR_1_OBUF : STD_LOGIC; 
  signal CPU_IADDR_4_OBUF : STD_LOGIC; 
  signal CPU_DADDR_0_OBUF : STD_LOGIC; 
  signal CPU_DADDR_4_OBUF : STD_LOGIC; 
  signal XLXN_87 : STD_LOGIC; 
  signal CPU_IADDR_2_OBUF : STD_LOGIC; 
  signal CPU_IADDR_6_OBUF : STD_LOGIC; 
  signal XLXI_2_n0043 : STD_LOGIC; 
  signal CPU_DATA_OUT_0_OBUF : STD_LOGIC; 
  signal CPU_IADDR_7_OBUF : STD_LOGIC; 
  signal XLXI_10_I2_N8267 : STD_LOGIC; 
  signal XLXI_10_nadwe_out : STD_LOGIC; 
  signal XLXI_10_I2_valid_x : STD_LOGIC; 
  signal XLXI_10_I4_ipage_we_c : STD_LOGIC; 
  signal XLXI_10_ndwe_int : STD_LOGIC; 
  signal XLXI_10_ndre_int : STD_LOGIC; 
  signal XLXI_10_I2_valid_c : STD_LOGIC; 
  signal XLXI_10_skip : STD_LOGIC; 
  signal XLXI_10_I2_skip_c : STD_LOGIC; 
  signal XLXI_10_I2_N8359 : STD_LOGIC; 
  signal XLXI_10_I2_N8327 : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_0 : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_1 : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_2 : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_3 : STD_LOGIC; 
  signal XLXI_10_I4_N9712 : STD_LOGIC; 
  signal XLXI_10_I4_n0044 : STD_LOGIC; 
  signal XLXI_10_I5_ndwe_c_N748 : STD_LOGIC; 
  signal XLXI_10_I4_ipage_we_x : STD_LOGIC; 
  signal XLXI_2_n0046 : STD_LOGIC; 
  signal N24709 : STD_LOGIC; 
  signal XLXI_2_n0020 : STD_LOGIC; 
  signal XLXI_3_N6924 : STD_LOGIC; 
  signal XLXI_3_N6905 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_24 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_26 : STD_LOGIC; 
  signal N19080_rt : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_lut2_27 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_27 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_lut2_28 : STD_LOGIC; 
  signal XLXI_10_I1_pc_4_rt : STD_LOGIC; 
  signal XLXI_10_I1_pc_7_rt : STD_LOGIC; 
  signal XLXI_10_I1_pc_5_rt : STD_LOGIC; 
  signal XLXI_3_n0003 : STD_LOGIC; 
  signal XLXI_3_pwm_count_7_rt : STD_LOGIC; 
  signal XLXI_10_I1_pc_1_rt : STD_LOGIC; 
  signal XLXI_3_n0007 : STD_LOGIC; 
  signal N25208 : STD_LOGIC; 
  signal N25212 : STD_LOGIC; 
  signal XLXI_3_n0009 : STD_LOGIC; 
  signal XLXI_3_n0015 : STD_LOGIC; 
  signal XLXI_3_n0016 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_lut2_26 : STD_LOGIC; 
  signal XLXI_3_n0026 : STD_LOGIC; 
  signal XLXI_3_n0027 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_28 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_lut2_29 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_29 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_lut2_30 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_30 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_lut2_31 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_31 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_lut2_24 : STD_LOGIC; 
  signal XLXI_10_I1_pc_2_rt : STD_LOGIC; 
  signal N24697 : STD_LOGIC; 
  signal N24703 : STD_LOGIC; 
  signal XLXI_3_pwm_count_Madd_n0000_inst_cy_4 : STD_LOGIC; 
  signal XLXI_3_pwm_count_Madd_n0000_inst_cy_2 : STD_LOGIC; 
  signal XLXI_3_pwm_count_Madd_n0000_inst_cy_6 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_lut2_25 : STD_LOGIC; 
  signal XLXI_3_pwm_count_Madd_n0000_inst_cy_1 : STD_LOGIC; 
  signal XLXI_3_pwm_count_Madd_n0000_inst_cy_3 : STD_LOGIC; 
  signal XLXI_3_pwm_count_Madd_n0000_inst_cy_5 : STD_LOGIC; 
  signal XLXI_3_pwm_count_Madd_n0000_inst_cy_0 : STD_LOGIC; 
  signal XLXI_3_pwm_count_Madd_n0000_inst_lut2_0 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_lut2_25 : STD_LOGIC; 
  signal N19427 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_8 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_lut2_8 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_lut2_15 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_14 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_lut2_14 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_13 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_lut2_13 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_12 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_lut2_12 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_11 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_lut2_11 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_10 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_lut2_10 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_9 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_lut2_9 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_8 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_lut2_8 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_lut2_15 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_14 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_lut2_14 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_13 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_lut2_13 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_12 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_lut2_12 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_11 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_lut2_11 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_10 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_lut2_10 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_9 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_lut2_9 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_21 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_22 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_20 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_20 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_22 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_19 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_19 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_23 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_18 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_18 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_16 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_16 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_21 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_17 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_17 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_25 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_24 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_lut2_24 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_31 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_lut2_31 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_30 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_lut2_30 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_29 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_lut2_29 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_28 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_lut2_28 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_27 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_lut2_27 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_26 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_lut2_26 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_25 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_6 : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_5 : STD_LOGIC; 
  signal XLXI_10_I1_n0014 : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_4 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_7 : STD_LOGIC; 
  signal XLXI_10_I1_n0016 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_0 : STD_LOGIC; 
  signal N24807 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_5 : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_0 : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_1 : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_6 : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_2 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_1 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_2 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_3 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_4 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_5 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_6 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_7 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_0 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_1 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_2 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_3 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_4 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_5 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_6 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_7 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_0 : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_3 : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_lut2_0 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_0 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_1 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_2 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_3 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_4 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_7 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_6 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_5 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_4 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_3 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_2 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_1 : STD_LOGIC; 
  signal XLXI_10_I2_N8336 : STD_LOGIC; 
  signal XLXI_10_I2_N8283 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_lut2_39 : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_4 : STD_LOGIC; 
  signal XLXI_10_I3_N8915 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_lut2_37 : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_cy_32 : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_lut2_32 : STD_LOGIC; 
  signal XLXI_10_I3_n0053 : STD_LOGIC; 
  signal XLXI_10_I3_N8884 : STD_LOGIC; 
  signal XLXI_10_I3_n0048 : STD_LOGIC; 
  signal XLXI_10_I3_n0062 : STD_LOGIC; 
  signal XLXI_10_I3_n0055 : STD_LOGIC; 
  signal XLXI_10_I3_n0054 : STD_LOGIC; 
  signal XLXI_10_I3_n0073 : STD_LOGIC; 
  signal XLXI_10_I3_N9013 : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_cy_33 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_cy_37 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_lut2_36 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_cy_39 : STD_LOGIC; 
  signal XLXI_10_I3_n0052 : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_lut2_35 : STD_LOGIC; 
  signal XLXI_10_I3_N8904 : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_cy_34 : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_lut2_34 : STD_LOGIC; 
  signal XLXI_10_I3_N9052 : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_lut2_33 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_cy_38 : STD_LOGIC; 
  signal XLXI_10_I3_N9047 : STD_LOGIC; 
  signal XLXI_10_I3_N8934 : STD_LOGIC; 
  signal XLXI_10_I3_n0037 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_lut2_38 : STD_LOGIC; 
  signal XLXI_10_I3_n0044 : STD_LOGIC; 
  signal XLXI_10_I3_n0045 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_cy_36 : STD_LOGIC; 
  signal XLXI_10_I3_N9064 : STD_LOGIC; 
  signal XLXI_10_I4_N9697 : STD_LOGIC; 
  signal N25042 : STD_LOGIC; 
  signal N25010 : STD_LOGIC; 
  signal N25078 : STD_LOGIC; 
  signal N25070 : STD_LOGIC; 
  signal N25062 : STD_LOGIC; 
  signal N25098 : STD_LOGIC; 
  signal CHOICE1457 : STD_LOGIC; 
  signal N21388 : STD_LOGIC; 
  signal N25038 : STD_LOGIC; 
  signal N25046 : STD_LOGIC; 
  signal N25102 : STD_LOGIC; 
  signal N25002 : STD_LOGIC; 
  signal CHOICE1444 : STD_LOGIC; 
  signal N25014 : STD_LOGIC; 
  signal N25094 : STD_LOGIC; 
  signal N25034 : STD_LOGIC; 
  signal N21431 : STD_LOGIC; 
  signal N25082 : STD_LOGIC; 
  signal N25066 : STD_LOGIC; 
  signal CHOICE1448 : STD_LOGIC; 
  signal N25030 : STD_LOGIC; 
  signal N25090 : STD_LOGIC; 
  signal N25086 : STD_LOGIC; 
  signal N25022 : STD_LOGIC; 
  signal N25026 : STD_LOGIC; 
  signal N25074 : STD_LOGIC; 
  signal N25006 : STD_LOGIC; 
  signal N25018 : STD_LOGIC; 
  signal N25050 : STD_LOGIC; 
  signal N21724 : STD_LOGIC; 
  signal N20151 : STD_LOGIC; 
  signal N25058 : STD_LOGIC; 
  signal CHOICE1708 : STD_LOGIC; 
  signal N25054 : STD_LOGIC; 
  signal N21493 : STD_LOGIC; 
  signal N21781 : STD_LOGIC; 
  signal N25156 : STD_LOGIC; 
  signal N25166 : STD_LOGIC; 
  signal N24847 : STD_LOGIC; 
  signal CHOICE1901 : STD_LOGIC; 
  signal CHOICE1834 : STD_LOGIC; 
  signal CHOICE1740 : STD_LOGIC; 
  signal CHOICE1886 : STD_LOGIC; 
  signal N25140 : STD_LOGIC; 
  signal CHOICE1856 : STD_LOGIC; 
  signal CHOICE1759 : STD_LOGIC; 
  signal CHOICE1871 : STD_LOGIC; 
  signal N25144 : STD_LOGIC; 
  signal N24827 : STD_LOGIC; 
  signal CHOICE1864 : STD_LOGIC; 
  signal CHOICE1791 : STD_LOGIC; 
  signal CHOICE1909 : STD_LOGIC; 
  signal N24851 : STD_LOGIC; 
  signal N24841 : STD_LOGIC; 
  signal N22203 : STD_LOGIC; 
  signal CHOICE1894 : STD_LOGIC; 
  signal CHOICE1826 : STD_LOGIC; 
  signal CHOICE1767 : STD_LOGIC; 
  signal CHOICE1879 : STD_LOGIC; 
  signal N22263 : STD_LOGIC; 
  signal N24811 : STD_LOGIC; 
  signal N25132 : STD_LOGIC; 
  signal CHOICE1762 : STD_LOGIC; 
  signal N24843 : STD_LOGIC; 
  signal CHOICE1916 : STD_LOGIC; 
  signal N25136 : STD_LOGIC; 
  signal N25148 : STD_LOGIC; 
  signal CHOICE1750 : STD_LOGIC; 
  signal CHOICE1745 : STD_LOGIC; 
  signal CHOICE1849 : STD_LOGIC; 
  signal CHOICE1786 : STD_LOGIC; 
  signal N25152 : STD_LOGIC; 
  signal CHOICE1841 : STD_LOGIC; 
  signal CHOICE1819 : STD_LOGIC; 
  signal N24084 : STD_LOGIC; 
  signal CHOICE2187 : STD_LOGIC; 
  signal CHOICE1984 : STD_LOGIC; 
  signal N24705 : STD_LOGIC; 
  signal N25204 : STD_LOGIC; 
  signal CHOICE1956 : STD_LOGIC; 
  signal CHOICE2164 : STD_LOGIC; 
  signal N24989 : STD_LOGIC; 
  signal CHOICE1931 : STD_LOGIC; 
  signal N24687 : STD_LOGIC; 
  signal CHOICE2010 : STD_LOGIC; 
  signal CHOICE1982 : STD_LOGIC; 
  signal CHOICE2035 : STD_LOGIC; 
  signal CHOICE2162 : STD_LOGIC; 
  signal CHOICE1924 : STD_LOGIC; 
  signal CHOICE2155 : STD_LOGIC; 
  signal CHOICE2076 : STD_LOGIC; 
  signal CHOICE2123 : STD_LOGIC; 
  signal CHOICE2013 : STD_LOGIC; 
  signal CHOICE2167 : STD_LOGIC; 
  signal CHOICE2067 : STD_LOGIC; 
  signal N25184 : STD_LOGIC; 
  signal CHOICE2055 : STD_LOGIC; 
  signal N24711 : STD_LOGIC; 
  signal N24038 : STD_LOGIC; 
  signal CHOICE1953 : STD_LOGIC; 
  signal CHOICE2025 : STD_LOGIC; 
  signal CHOICE2062 : STD_LOGIC; 
  signal N24985 : STD_LOGIC; 
  signal CHOICE2131 : STD_LOGIC; 
  signal N24791 : STD_LOGIC; 
  signal N23342 : STD_LOGIC; 
  signal CHOICE1965 : STD_LOGIC; 
  signal N25128 : STD_LOGIC; 
  signal N24981 : STD_LOGIC; 
  signal CHOICE2036 : STD_LOGIC; 
  signal CHOICE2070 : STD_LOGIC; 
  signal N23016 : STD_LOGIC; 
  signal CHOICE2079 : STD_LOGIC; 
  signal CHOICE2073 : STD_LOGIC; 
  signal CHOICE2080 : STD_LOGIC; 
  signal N24795 : STD_LOGIC; 
  signal N23412 : STD_LOGIC; 
  signal CHOICE2032 : STD_LOGIC; 
  signal CHOICE1966 : STD_LOGIC; 
  signal CHOICE2047 : STD_LOGIC; 
  signal N24829 : STD_LOGIC; 
  signal N24693 : STD_LOGIC; 
  signal N24977 : STD_LOGIC; 
  signal CHOICE2128 : STD_LOGIC; 
  signal CHOICE2161 : STD_LOGIC; 
  signal CHOICE2176 : STD_LOGIC; 
  signal N25192 : STD_LOGIC; 
  signal N25117 : STD_LOGIC; 
  signal CHOICE2088 : STD_LOGIC; 
  signal N25196 : STD_LOGIC; 
  signal CHOICE2099 : STD_LOGIC; 
  signal N24699 : STD_LOGIC; 
  signal CHOICE2148 : STD_LOGIC; 
  signal CHOICE1944 : STD_LOGIC; 
  signal N25200 : STD_LOGIC; 
  signal N24629 : STD_LOGIC; 
  signal CHOICE2044 : STD_LOGIC; 
  signal N25174 : STD_LOGIC; 
  signal CHOICE2134 : STD_LOGIC; 
  signal CHOICE2168 : STD_LOGIC; 
  signal XLXI_3_pwm_count_5_rt : STD_LOGIC; 
  signal XLXI_3_pwm_count_1_rt : STD_LOGIC; 
  signal XLXI_3_pwm_count_2_rt : STD_LOGIC; 
  signal XLXI_3_pwm_count_3_rt : STD_LOGIC; 
  signal XLXI_3_pwm_count_4_rt : STD_LOGIC; 
  signal XLXI_3_pwm_count_6_rt : STD_LOGIC; 
  signal XLXI_10_I1_pc_3_rt : STD_LOGIC; 
  signal XLXI_10_I1_pc_6_rt : STD_LOGIC; 
  signal N24633 : STD_LOGIC; 
  signal N24637 : STD_LOGIC; 
  signal N24641 : STD_LOGIC; 
  signal N24645 : STD_LOGIC; 
  signal N24649 : STD_LOGIC; 
  signal N24653 : STD_LOGIC; 
  signal N24657 : STD_LOGIC; 
  signal N24815 : STD_LOGIC; 
  signal N24799 : STD_LOGIC; 
  signal N24667 : STD_LOGIC; 
  signal N24669 : STD_LOGIC; 
  signal N24823 : STD_LOGIC; 
  signal N24675 : STD_LOGIC; 
  signal N24679 : STD_LOGIC; 
  signal N24681 : STD_LOGIC; 
  signal N24685 : STD_LOGIC; 
  signal N24691 : STD_LOGIC; 
  signal N24819 : STD_LOGIC; 
  signal N25170 : STD_LOGIC; 
  signal N24803 : STD_LOGIC; 
  signal N24731 : STD_LOGIC; 
  signal N24735 : STD_LOGIC; 
  signal N24739 : STD_LOGIC; 
  signal N24743 : STD_LOGIC; 
  signal N24745 : STD_LOGIC; 
  signal N24749 : STD_LOGIC; 
  signal N24751 : STD_LOGIC; 
  signal N24755 : STD_LOGIC; 
  signal N24757 : STD_LOGIC; 
  signal N24761 : STD_LOGIC; 
  signal N24765 : STD_LOGIC; 
  signal N24767 : STD_LOGIC; 
  signal N24771 : STD_LOGIC; 
  signal N24773 : STD_LOGIC; 
  signal N24777 : STD_LOGIC; 
  signal N24779 : STD_LOGIC; 
  signal N24783 : STD_LOGIC; 
  signal N24787 : STD_LOGIC; 
  signal XLXI_10_I2_pc_mux_x_1_1 : STD_LOGIC; 
  signal XLXI_10_I2_pc_mux_x_0_17_1 : STD_LOGIC; 
  signal XLXI_10_I2_pc_mux_x_2_1 : STD_LOGIC; 
  signal XLXI_10_I2_pc_mux_x_2_2 : STD_LOGIC; 
  signal N25221 : STD_LOGIC; 
  signal N25223 : STD_LOGIC; 
  signal N25226 : STD_LOGIC; 
  signal N25228 : STD_LOGIC; 
  signal N25231 : STD_LOGIC; 
  signal N25233 : STD_LOGIC; 
  signal N25236 : STD_LOGIC; 
  signal N25238 : STD_LOGIC; 
  signal N25241 : STD_LOGIC; 
  signal N25243 : STD_LOGIC; 
  signal N25246 : STD_LOGIC; 
  signal N25248 : STD_LOGIC; 
  signal N25251 : STD_LOGIC; 
  signal N25253 : STD_LOGIC; 
  signal N25255 : STD_LOGIC; 
  signal N25257 : STD_LOGIC; 
  signal N25278 : STD_LOGIC; 
  signal N25284 : STD_LOGIC; 
  signal N25293 : STD_LOGIC; 
  signal N25295 : STD_LOGIC; 
  signal N25298 : STD_LOGIC; 
  signal N25312 : STD_LOGIC; 
  signal N25314 : STD_LOGIC; 
  signal N25316 : STD_LOGIC; 
  signal N25319 : STD_LOGIC; 
  signal N25322 : STD_LOGIC; 
  signal N25325 : STD_LOGIC; 
  signal N25333 : STD_LOGIC; 
  signal N25335 : STD_LOGIC; 
  signal N25337 : STD_LOGIC; 
  signal N25365 : STD_LOGIC; 
  signal N25368 : STD_LOGIC; 
  signal N25370 : STD_LOGIC; 
  signal N25374 : STD_LOGIC; 
  signal N25378 : STD_LOGIC; 
  signal N25382 : STD_LOGIC; 
  signal N25384 : STD_LOGIC; 
  signal N25388 : STD_LOGIC; 
  signal N25390 : STD_LOGIC; 
  signal N25392 : STD_LOGIC; 
  signal N25398 : STD_LOGIC; 
  signal N25400 : STD_LOGIC; 
  signal N25402 : STD_LOGIC; 
  signal N25413 : STD_LOGIC; 
  signal N25416 : STD_LOGIC; 
  signal N25418 : STD_LOGIC; 
  signal XLXI_2_nCS_PWM_SW0_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_0_31_O : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW2_O : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW1_O : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW0_O : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW9_O : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_231_O : STD_LOGIC; 
  signal XLXI_10_I3_n0035_4_11_SW1_O : STD_LOGIC; 
  signal XLXI_10_I3_n0035_2_47_SW0_O : STD_LOGIC; 
  signal XLXI_10_I3_n0035_0_27_O : STD_LOGIC; 
  signal XLXI_10_I3_skip_l90_O : STD_LOGIC; 
  signal XLXI_3_n0006_3_1_O : STD_LOGIC; 
  signal XLXI_10_I3_n0035_3_47_SW0_O : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW3_O : STD_LOGIC; 
  signal XLXI_10_I3_n0035_1_47_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_0_19_SW0_O : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW8_O : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW7_O : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_2_31_O : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW6_O : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_5_31_O : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_6_31_O : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_7_31_O : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_4_31_O : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_1_31_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_2_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0010_6_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_4_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0011_1_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0011_7_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0010_1_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0011_0_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0011_4_19_O : STD_LOGIC; 
  signal XLXI_2_n0020_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0011_3_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_1_19_O : STD_LOGIC; 
  signal XLXI_2_n0046_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0010_5_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0010_6_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0011_6_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0010_0_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_6_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0011_1_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0010_3_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0010_1_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_3_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0010_3_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0011_5_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0010_7_19_O : STD_LOGIC; 
  signal XLXI_10_I3_n0035_4_96_O : STD_LOGIC; 
  signal XLXI_10_I3_n0035_3_145_O : STD_LOGIC; 
  signal XLXI_10_I3_n0035_2_145_O : STD_LOGIC; 
  signal XLXI_10_I3_n0035_1_145_O : STD_LOGIC; 
  signal XLXI_10_I3_n0035_0_220_O : STD_LOGIC; 
  signal XLXI_10_I3_n00441_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_4_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0011_2_19_O : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_3_31_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_2_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0011_3_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0010_4_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_1_19_SW0_O : STD_LOGIC; 
  signal XLXI_2_n0043_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_5_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0009_2_1_O : STD_LOGIC; 
  signal XLXI_10_I1_n0009_3_1_O : STD_LOGIC; 
  signal XLXI_10_I1_n0009_4_1_O : STD_LOGIC; 
  signal XLXI_10_I1_n0009_5_1_O : STD_LOGIC; 
  signal XLXI_10_I1_n0009_6_1_O : STD_LOGIC; 
  signal XLXI_10_I1_n0009_7_1_O : STD_LOGIC; 
  signal XLXI_10_I1_n0009_1_1_O : STD_LOGIC; 
  signal XLXI_10_I1_n0011_6_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0010_2_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0010_2_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_5_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0011_4_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0011_2_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_3_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0011_5_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_0_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0009_0_1_O : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW5_O : STD_LOGIC; 
  signal XLXI_3_n0006_5_1_O : STD_LOGIC; 
  signal XLXI_3_n0006_6_1_O : STD_LOGIC; 
  signal XLXI_3_n0006_7_1_O : STD_LOGIC; 
  signal XLXI_10_I3_n0035_0_107_SW0_O : STD_LOGIC; 
  signal XLXI_10_I3_n0035_3_109_SW0_O : STD_LOGIC; 
  signal XLXI_10_I3_n0035_2_109_SW0_O : STD_LOGIC; 
  signal XLXI_3_n0006_2_1_O : STD_LOGIC; 
  signal XLXI_3_n0006_1_1_O : STD_LOGIC; 
  signal XLXI_3_n0006_0_1_O : STD_LOGIC; 
  signal XLXI_2_Mmux_n0021_Result_0_1_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_7_19_O : STD_LOGIC; 
  signal XLXI_3_n0006_4_1_O : STD_LOGIC; 
  signal XLXI_2_Mmux_n0021_Result_2_1_O : STD_LOGIC; 
  signal XLXI_2_Mmux_n0021_Result_3_1_O : STD_LOGIC; 
  signal XLXI_10_I1_n0010_4_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0010_5_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_6_19_SW0_O : STD_LOGIC; 
  signal XLXI_2_Mmux_n0021_Result_1_1_O : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW4_O : STD_LOGIC; 
  signal XLXI_5_N0 : STD_LOGIC; 
  signal XLXI_5_N1 : STD_LOGIC; 
  signal XLXI_4_N0 : STD_LOGIC; 
  signal XLXI_4_N1 : STD_LOGIC; 
  signal CLK_BUFGP_IBUFG : STD_LOGIC; 
  signal GSR : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_2_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_3_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I5_ndwe_c_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_5_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_4_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_0_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_1_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I1_pc_4_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I1_pc_5_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I1_pc_2_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I1_pc_3_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I1_nreset_v_1_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I1_pc_7_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I1_nreset_v_0_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I1_pc_6_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I1_pc_0_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I1_pc_1_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I2_skip_c_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_0_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_2_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I2_data_is_c_1_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_1_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_0_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I2_valid_c_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I2_nreset_v_0_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I2_data_is_c_2_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I2_nreset_v_1_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_3_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_2_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_1_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I2_data_is_c_0_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I2_data_is_c_3_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_4_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I3_nreset_v_1_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_1_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_2_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_0_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_3_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I3_nreset_v_0_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I4_ipage_c_0_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I4_nreset_v_1_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I4_ipage_we_c_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I4_ipage_c_1_GSR_OR : STD_LOGIC; 
  signal XLXI_10_I4_nreset_v_0_GSR_OR : STD_LOGIC; 
  signal CTRL_DATA_OUT_0_OBUF_GTS_TRI : STD_LOGIC; 
  signal GTS : STD_LOGIC; 
  signal CPU_IADDR_0_OBUF_GTS_TRI : STD_LOGIC; 
  signal CTRL_DATA_OUT_3_OBUF_GTS_TRI : STD_LOGIC; 
  signal CPU_IADDR_2_OBUF_GTS_TRI : STD_LOGIC; 
  signal CTRL_DATA_OUT_2_OBUF_GTS_TRI : STD_LOGIC; 
  signal CPU_DADDR_2_OBUF_GTS_TRI : STD_LOGIC; 
  signal CTRL_DATA_OUT_1_OBUF_GTS_TRI : STD_LOGIC; 
  signal CPU_DADDR_3_OBUF_GTS_TRI : STD_LOGIC; 
  signal CPU_DADDR_0_OBUF_GTS_TRI : STD_LOGIC; 
  signal CPU_DADDR_4_OBUF_GTS_TRI : STD_LOGIC; 
  signal CPU_DADDR_1_OBUF_GTS_TRI : STD_LOGIC; 
  signal CPU_DADDR_5_OBUF_GTS_TRI : STD_LOGIC; 
  signal CPU_IADDR_1_OBUF_GTS_TRI : STD_LOGIC; 
  signal PWM_OUT_OBUF_GTS_TRI : STD_LOGIC; 
  signal nWE_CPU_OBUF_GTS_TRI : STD_LOGIC; 
  signal nRE_CPU_OBUF_GTS_TRI : STD_LOGIC; 
  signal CPU_DATA_OUT_3_OBUF_GTS_TRI : STD_LOGIC; 
  signal CPU_DATA_OUT_2_OBUF_GTS_TRI : STD_LOGIC; 
  signal CPU_DATA_OUT_1_OBUF_GTS_TRI : STD_LOGIC; 
  signal CPU_DATA_OUT_0_OBUF_GTS_TRI : STD_LOGIC; 
  signal CPU_IADDR_7_OBUF_GTS_TRI : STD_LOGIC; 
  signal CPU_IADDR_6_OBUF_GTS_TRI : STD_LOGIC; 
  signal CPU_IADDR_5_OBUF_GTS_TRI : STD_LOGIC; 
  signal CPU_IADDR_4_OBUF_GTS_TRI : STD_LOGIC; 
  signal CPU_IADDR_3_OBUF_GTS_TRI : STD_LOGIC; 
  signal VCC : STD_LOGIC; 
  signal GND : STD_LOGIC; 
  signal NLW_XLXI_5_B5_DO_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_XLXI_5_B5_DO_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_XLXI_5_B5_DO_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_XLXI_5_B5_DO_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_XLXI_5_B5_DO_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_XLXI_5_B5_DO_15_UNCONNECTED : STD_LOGIC; 
  signal NlwInverterSignal_CTRL_DATA_OUT_0_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_IADDR_0_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CTRL_DATA_OUT_3_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_IADDR_2_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CTRL_DATA_OUT_2_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_DADDR_2_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CTRL_DATA_OUT_1_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_DADDR_3_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_DADDR_0_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_DADDR_4_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_DADDR_1_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_DADDR_5_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_IADDR_1_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_PWM_OUT_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_nWE_CPU_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_nRE_CPU_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_DATA_OUT_3_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_DATA_OUT_2_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_DATA_OUT_1_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_DATA_OUT_0_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_IADDR_7_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_IADDR_6_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_IADDR_5_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_IADDR_4_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal NlwInverterSignal_CPU_IADDR_3_OBUF_GTS_TRI_CTL : STD_LOGIC; 
  signal XLXI_10_I4_n0031 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXN_8 : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal XLXI_10_I4_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal RAM_DATA_OUT : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_2_pwm_data_c : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_2_ctrl_data_c : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_2_n0021 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_10_I2_TD_x : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_10_I5_daddr_c : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal XLXI_10_I2_n0028 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_10_I4_n0030 : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_10_I2_TD_c : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_10_pc_mux : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal XLXI_10_I2_TC_c : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal XLXI_10_I2_data_is_c : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_10_I2_TC_x : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal XLXI_10_I2_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_10_adaddr_out : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal XLXI_10_I4_ipage_c : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_2_mux_c : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_3_n0005 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_3_pwm_low : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_3_pwm_count : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_3_pwm_high : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_3_pwm_period : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_3_n0006 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_3_n0011 : STD_LOGIC_VECTOR ( 6 downto 0 ); 
  signal XLXI_3_pwm_count_n0000 : STD_LOGIC_VECTOR ( 7 downto 1 ); 
  signal XLXI_10_I1_n0012 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_10_I1_n0009 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_10_I1_n0011 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_10_I1_n0010 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_10_I1_n0008 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_10_I1_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_10_I1_n0013 : STD_LOGIC_VECTOR ( 7 downto 1 ); 
  signal XLXI_10_I1_pc : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_10_I3_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_10_I3_n0059 : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal XLXI_10_I3_n0035 : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal XLXI_10_I3_n0064 : STD_LOGIC_VECTOR ( 3 downto 1 ); 
  signal XLXI_10_I3_data_x : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_10_I3_n0058 : STD_LOGIC_VECTOR ( 4 downto 4 ); 
  signal XLXI_10_I3_n0036 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
begin
  XLXI_3_Mmux_n0011_Result_3_1 : X_LUT4
    generic map(
      INIT => X"D580"
    )
    port map (
      ADR0 => N25251,
      ADR1 => XLXI_10_I3_acc_c_0_3,
      ADR2 => XLXI_10_I4_N9730,
      ADR3 => XLXI_3_pwm_period(3),
      O => XLXI_3_n0011(3)
    );
  XLXI_10_I5_daddr_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_adaddr_out(2),
      RST => XLXI_10_I5_daddr_c_2_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I5_daddr_c(2),
      CE => VCC,
      SET => GND
    );
  XLXI_7 : X_INV
    port map (
      I => nWR_RAM,
      O => XLXN_87
    );
  XLXI_10_I5_daddr_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_adaddr_out(3),
      RST => XLXI_10_I5_daddr_c_3_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I5_daddr_c(3),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I3_n0035_1_86_SW0 : X_LUT4
    generic map(
      INIT => X"F444"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_1,
      ADR1 => XLXI_10_I3_n0054,
      ADR2 => XLXI_10_I3_N8904,
      ADR3 => XLXI_10_I3_acc_c_0_2,
      O => N24989
    );
  XLXI_10_I3_Msub_n0059_inst_lut2_361 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => N25390,
      ADR1 => N24745,
      ADR2 => CHOICE2131,
      ADR3 => N24743,
      O => XLXI_10_I3_Msub_n0059_inst_lut2_36
    );
  XLXI_10_I1_Madd_n0013_inst_cy_0_0 : X_MUX2
    port map (
      IB => N19427,
      IA => N19080_rt,
      SEL => XLXI_10_I1_Madd_n0013_inst_lut2_0,
      O => XLXI_10_I1_Madd_n0013_inst_cy_0
    );
  XLXI_10_I2_Ker82811 : X_LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      ADR0 => XLXN_8(1),
      ADR1 => XLXN_8(2),
      O => XLXI_10_I2_N8283
    );
  XLXI_10_I5_Mmux_daddr_out_Result_5_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => nRE_CPU_OBUF,
      ADR1 => XLXI_10_I5_daddr_c(5),
      ADR2 => XLXI_10_adaddr_out(5),
      O => CPU_DADDR_5_OBUF
    );
  XLXI_10_I5_ndwe_c_1 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_10_nadwe_out,
      SET => XLXI_10_I5_ndwe_c_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I5_ndwe_c,
      CE => VCC,
      RST => GND
    );
  XLXI_10_I5_daddr_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_adaddr_out(5),
      RST => XLXI_10_I5_daddr_c_5_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I5_daddr_c(5),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I5_ndwe_c_N7481 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => NRESET_IBUF,
      O => XLXI_10_I5_ndwe_c_N748,
      ADR1 => GND
    );
  XLXI_10_I5_daddr_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_adaddr_out(4),
      RST => XLXI_10_I5_daddr_c_4_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I5_daddr_c(4),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I5_daddr_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_adaddr_out(0),
      RST => XLXI_10_I5_daddr_c_0_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I5_daddr_c(0),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I5_daddr_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_adaddr_out(1),
      RST => XLXI_10_I5_daddr_c_1_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I5_daddr_c(1),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I5_Mmux_daddr_out_Result_0_1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => XLXI_10_ndre_int,
      ADR1 => XLXI_10_I5_daddr_c(0),
      ADR2 => XLXI_10_I4_N9712,
      ADR3 => N24641,
      O => CPU_DADDR_0_OBUF
    );
  XLXI_10_I5_Mmux_daddr_out_Result_1_1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => XLXI_10_ndre_int,
      ADR1 => XLXI_10_I5_daddr_c(1),
      ADR2 => XLXI_10_I4_N9712,
      ADR3 => N24645,
      O => CPU_DADDR_1_OBUF
    );
  XLXI_10_I4_n0030_0_1 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_I4_ipage_we_c,
      ADR1 => XLXI_10_I3_acc_c_0_0,
      O => XLXI_10_I4_n0030(0)
    );
  XLXI_2_n00421 : X_LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      ADR0 => N25253,
      ADR1 => XLXI_10_I5_ndwe_c,
      O => XLXI_2_n0042
    );
  XST_VCC : X_ONE
    port map (
      O => N19080_rt
    );
  XLXI_2_pwm_data_c_3 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_n0021(3),
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_2_n0042,
      CLK => CLK_BUFGP,
      O => XLXI_2_pwm_data_c(3),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_2_pwm_data_c_0 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_n0021(0),
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_2_n0042,
      CLK => CLK_BUFGP,
      O => XLXI_2_pwm_data_c(0),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_2_pwm_data_c_2 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_n0021(2),
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_2_n0042,
      CLK => CLK_BUFGP,
      O => XLXI_2_pwm_data_c(2),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_2_mux_c_0 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => N19080_rt,
      SRST => XLXI_2_n0020,
      CLK => CLK_BUFGP,
      O => XLXI_2_mux_c(0),
      CE => VCC,
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_2_pwm_data_c_1 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_n0021(1),
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_2_n0042,
      CLK => CLK_BUFGP,
      O => XLXI_2_pwm_data_c(1),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_2_ctrl_data_c_1 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT_1_OBUF,
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_2_n0043,
      CLK => CLK_BUFGP,
      O => XLXI_2_ctrl_data_c(1),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_2_ctrl_data_c_2 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT_2_OBUF,
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_2_n0043,
      CLK => CLK_BUFGP,
      O => XLXI_2_ctrl_data_c(2),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  CPU_IADDR_0_OBUF_2 : X_BUF
    port map (
      I => CPU_IADDR_0_OBUF,
      O => CPU_IADDR_0_OBUF_GTS_TRI
    );
  XLXI_2_ctrl_data_c_0 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT_0_OBUF,
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_2_n0043,
      CLK => CLK_BUFGP,
      O => XLXI_2_ctrl_data_c(0),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_2_ctrl_data_c_3 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT_3_OBUF,
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_2_n0043,
      CLK => CLK_BUFGP,
      O => XLXI_2_ctrl_data_c(3),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_2_nWR_RAM1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => XLXI_10_I4_N9712,
      ADR1 => N24779,
      ADR2 => XLXI_10_ndre_int,
      ADR3 => N24777,
      O => nWR_RAM
    );
  XLXI_10_I3_n0035_0_164 : X_LUT3
    generic map(
      INIT => X"01"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(0),
      ADR1 => XLXI_10_I2_TC_c(1),
      ADR2 => XLXI_10_I2_TD_c(3),
      O => CHOICE1982
    );
  XLXI_10_I4_n0030_1_1 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_I4_ipage_we_c,
      ADR1 => XLXI_10_I3_acc_c_0_1,
      O => XLXI_10_I4_n0030(1)
    );
  XLXI_10_I3_Mmux_data_x_Result_1_45_SW0 : X_LUT3
    generic map(
      INIT => X"95"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_1,
      ADR1 => XLXI_10_I2_data_is_c(1),
      ADR2 => XLXI_10_I3_n0037,
      O => N24667
    );
  XLXI_3_Mcompar_n0016_inst_cy_14_3 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0016_inst_cy_13,
      IA => XLXI_3_pwm_high(6),
      SEL => XLXI_3_Mcompar_n0016_inst_lut2_14,
      O => XLXI_3_Mcompar_n0016_inst_cy_14
    );
  XLXI_3_n00271 : X_LUT4
    generic map(
      INIT => X"202A"
    )
    port map (
      ADR0 => XLXI_2_ctrl_data_c(0),
      ADR1 => XLXI_3_n0016,
      ADR2 => XLXI_3_pwm_c,
      ADR3 => XLXI_3_n0015,
      O => XLXI_3_n0027
    );
  XLXI_3_n00261 : X_LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      ADR0 => nCS_PWM,
      ADR1 => XLXI_10_I5_ndwe_c,
      O => XLXI_3_n0026
    );
  XLXI_3_pwm_period_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006(5),
      CE => NRESET_IBUF,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_period(5),
      SET => GND,
      RST => GSR
    );
  XLXI_3_pwm_low_5 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_pwm_data_c(1),
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_low(5),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_low_6 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_pwm_data_c(2),
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_low(6),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_period_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006(1),
      CE => NRESET_IBUF,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_period(1),
      SET => GND,
      RST => GSR
    );
  XLXI_3_pwm_period_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006(2),
      CE => NRESET_IBUF,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_period(2),
      SET => GND,
      RST => GSR
    );
  XLXI_3_pwm_period_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006(3),
      CE => NRESET_IBUF,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_period(3),
      SET => GND,
      RST => GSR
    );
  XLXI_3_pwm_period_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006(0),
      CE => NRESET_IBUF,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_period(0),
      SET => GND,
      RST => GSR
    );
  XLXI_3_pwm_period_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006(4),
      CE => NRESET_IBUF,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_period(4),
      SET => GND,
      RST => GSR
    );
  XLXI_3_n00091 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => XLXI_3_pwm_c,
      O => XLXI_3_n0009,
      ADR1 => GND
    );
  XLXI_3_pwm_low_7 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_pwm_data_c(3),
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_low(7),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_high_7 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(7),
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_3_n0026,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_high(7),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_period_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006(7),
      CE => NRESET_IBUF,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_period(7),
      SET => GND,
      RST => GSR
    );
  XLXI_3_pwm_count_6 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_count_n0000(6),
      SRST => XLXI_3_n0007,
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_count(6),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_c_4 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0009,
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_3_n0027,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_c,
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_Mcompar_n0013_inst_lut2_311 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(7),
      ADR1 => XLXI_3_pwm_count(7),
      O => XLXI_3_Mcompar_n0013_inst_lut2_31
    );
  XLXI_3_Mcompar_n0014_inst_lut2_311 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(7),
      ADR1 => XLXI_3_pwm_count(7),
      O => XLXI_3_Mcompar_n0014_inst_lut2_31
    );
  XLXI_3_Mcompar_n0015_inst_cy_14_5 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0015_inst_cy_13,
      IA => XLXI_3_pwm_low(6),
      SEL => XLXI_3_Mcompar_n0015_inst_lut2_14,
      O => XLXI_3_Mcompar_n0015_inst_cy_14
    );
  XLXI_10_I3_Mmux_data_x_Result_1_45_SW1 : X_LUT4
    generic map(
      INIT => X"D827"
    )
    port map (
      ADR0 => XLXI_10_I3_n0037,
      ADR1 => XLXI_10_I2_data_is_c(1),
      ADR2 => XLXI_10_I4_N9730,
      ADR3 => XLXI_10_I3_acc_c_0_1,
      O => N24669
    );
  XLXI_3_Mcompar_n0013_inst_cy_29_6 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0013_inst_cy_28,
      IA => XLXI_3_pwm_high(5),
      SEL => XLXI_3_Mcompar_n0013_inst_lut2_29,
      O => XLXI_3_Mcompar_n0013_inst_cy_29
    );
  CTRL_DATA_OUT_2_OBUF : X_BUF
    port map (
      I => XLXI_2_ctrl_data_c(2),
      O => CTRL_DATA_OUT_2_OBUF_GTS_TRI
    );
  XLXI_3_pwm_high_0 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(0),
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_3_n0026,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_high(0),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_high_1 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(1),
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_3_n0026,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_high(1),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_high_2 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(2),
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_3_n0026,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_high(2),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_high_3 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(3),
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_3_n0026,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_high(3),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_high_4 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(4),
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_3_n0026,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_high(4),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_high_5 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(5),
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_3_n0026,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_high(5),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_high_6 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(6),
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_3_n0026,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_high(6),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_period_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006(6),
      CE => NRESET_IBUF,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_period(6),
      SET => GND,
      RST => GSR
    );
  XLXI_3_pwm_low_0 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT_0_OBUF,
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_low(0),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_low_1 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT_1_OBUF,
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_low(1),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_low_2 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT_2_OBUF,
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_low(2),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_low_3 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT_3_OBUF,
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_low(3),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_low_4 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_pwm_data_c(0),
      SRST => XLXI_10_I5_ndwe_c_N748,
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_low(4),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_count_7 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_count_n0000(7),
      SRST => XLXI_3_n0007,
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_count(7),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_count_Madd_n0000_inst_cy_5_7 : X_MUX2
    port map (
      IB => XLXI_3_pwm_count_Madd_n0000_inst_cy_4,
      IA => N19427,
      SEL => XLXI_3_pwm_count_5_rt,
      O => XLXI_3_pwm_count_Madd_n0000_inst_cy_5
    );
  XLXI_3_pwm_count_0 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_count_Madd_n0000_inst_lut2_0,
      SRST => XLXI_3_n0007,
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_count(0),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_count_1 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_count_n0000(1),
      SRST => XLXI_3_n0007,
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_count(1),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_count_2 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_count_n0000(2),
      SRST => XLXI_3_n0007,
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_count(2),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_count_3 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_count_n0000(3),
      SRST => XLXI_3_n0007,
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_count(3),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_count_4 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_count_n0000(4),
      SRST => XLXI_3_n0007,
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_count(4),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XLXI_3_pwm_count_5 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_count_n0000(5),
      SRST => XLXI_3_n0007,
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      O => XLXI_3_pwm_count(5),
      SET => GND,
      RST => GSR,
      SSET => GND
    );
  XST_GND : X_ZERO
    port map (
      O => N19427
    );
  XLXI_3_Ker69221 : X_LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      ADR0 => XLXI_10_I5_ndwe_c,
      ADR1 => CPU_DADDR_2_OBUF,
      ADR2 => N25388,
      O => XLXI_3_N6924
    );
  XLXI_3_pwm_count_Madd_n0000_inst_lut2_01 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => XLXI_3_pwm_count(0),
      O => XLXI_3_pwm_count_Madd_n0000_inst_lut2_0,
      ADR1 => GND
    );
  XLXI_3_pwm_count_Madd_n0000_inst_cy_0_8 : X_MUX2
    port map (
      IB => N19427,
      IA => N19080_rt,
      SEL => XLXI_3_pwm_count_Madd_n0000_inst_lut2_0,
      O => XLXI_3_pwm_count_Madd_n0000_inst_cy_0
    );
  CPU_DADDR_2_OBUF_9 : X_BUF
    port map (
      I => CPU_DADDR_2_OBUF,
      O => CPU_DADDR_2_OBUF_GTS_TRI
    );
  XLXI_3_pwm_count_Madd_n0000_inst_sum_7 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_count_7_rt,
      I1 => XLXI_3_pwm_count_Madd_n0000_inst_cy_6,
      O => XLXI_3_pwm_count_n0000(7)
    );
  XLXI_3_pwm_count_Madd_n0000_inst_cy_1_10 : X_MUX2
    port map (
      IB => XLXI_3_pwm_count_Madd_n0000_inst_cy_0,
      IA => N19427,
      SEL => XLXI_3_pwm_count_1_rt,
      O => XLXI_3_pwm_count_Madd_n0000_inst_cy_1
    );
  XLXI_3_pwm_count_Madd_n0000_inst_sum_1 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_count_1_rt,
      I1 => XLXI_3_pwm_count_Madd_n0000_inst_cy_0,
      O => XLXI_3_pwm_count_n0000(1)
    );
  XLXI_3_Mcompar_n0013_inst_cy_30_11 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0013_inst_cy_29,
      IA => XLXI_3_pwm_high(6),
      SEL => XLXI_3_Mcompar_n0013_inst_lut2_30,
      O => XLXI_3_Mcompar_n0013_inst_cy_30
    );
  XLXI_3_pwm_count_Madd_n0000_inst_cy_2_12 : X_MUX2
    port map (
      IB => XLXI_3_pwm_count_Madd_n0000_inst_cy_1,
      IA => N19427,
      SEL => XLXI_3_pwm_count_2_rt,
      O => XLXI_3_pwm_count_Madd_n0000_inst_cy_2
    );
  XLXI_3_pwm_count_Madd_n0000_inst_sum_2 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_count_2_rt,
      I1 => XLXI_3_pwm_count_Madd_n0000_inst_cy_1,
      O => XLXI_3_pwm_count_n0000(2)
    );
  XLXI_3_pwm_count_Madd_n0000_inst_sum_5 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_count_5_rt,
      I1 => XLXI_3_pwm_count_Madd_n0000_inst_cy_4,
      O => XLXI_3_pwm_count_n0000(5)
    );
  XLXI_3_pwm_count_Madd_n0000_inst_cy_3_13 : X_MUX2
    port map (
      IB => XLXI_3_pwm_count_Madd_n0000_inst_cy_2,
      IA => N19427,
      SEL => XLXI_3_pwm_count_3_rt,
      O => XLXI_3_pwm_count_Madd_n0000_inst_cy_3
    );
  XLXI_3_pwm_count_Madd_n0000_inst_sum_3 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_count_3_rt,
      I1 => XLXI_3_pwm_count_Madd_n0000_inst_cy_2,
      O => XLXI_3_pwm_count_n0000(3)
    );
  XLXI_3_pwm_count_Madd_n0000_inst_sum_6 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_count_6_rt,
      I1 => XLXI_3_pwm_count_Madd_n0000_inst_cy_5,
      O => XLXI_3_pwm_count_n0000(6)
    );
  XLXI_3_pwm_count_Madd_n0000_inst_cy_4_14 : X_MUX2
    port map (
      IB => XLXI_3_pwm_count_Madd_n0000_inst_cy_3,
      IA => N19427,
      SEL => XLXI_3_pwm_count_4_rt,
      O => XLXI_3_pwm_count_Madd_n0000_inst_cy_4
    );
  XLXI_3_pwm_count_Madd_n0000_inst_sum_4 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_count_4_rt,
      I1 => XLXI_3_pwm_count_Madd_n0000_inst_cy_3,
      O => XLXI_3_pwm_count_n0000(4)
    );
  XLXI_3_pwm_count_Madd_n0000_inst_cy_6_15 : X_MUX2
    port map (
      IB => XLXI_3_pwm_count_Madd_n0000_inst_cy_5,
      IA => N19427,
      SEL => XLXI_3_pwm_count_6_rt,
      O => XLXI_3_pwm_count_Madd_n0000_inst_cy_6
    );
  XLXI_3_Mcompar_n0016_inst_lut2_151 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(7),
      ADR1 => XLXI_3_pwm_count(7),
      O => XLXI_3_Mcompar_n0016_inst_lut2_15
    );
  XLXI_3_Mcompar_n0016_inst_cy_15 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0016_inst_cy_14,
      IA => XLXI_3_pwm_high(7),
      SEL => XLXI_3_Mcompar_n0016_inst_lut2_15,
      O => XLXI_3_n0016
    );
  XLXI_3_Mcompar_n0016_inst_lut2_81 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(0),
      ADR1 => XLXI_3_pwm_count(0),
      O => XLXI_3_Mcompar_n0016_inst_lut2_8
    );
  XLXI_3_Mcompar_n0016_inst_cy_8_16 : X_MUX2
    port map (
      IB => N19427,
      IA => XLXI_3_pwm_high(0),
      SEL => XLXI_3_Mcompar_n0016_inst_lut2_8,
      O => XLXI_3_Mcompar_n0016_inst_cy_8
    );
  XLXI_3_Mcompar_n0016_inst_lut2_91 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(1),
      ADR1 => XLXI_3_pwm_count(1),
      O => XLXI_3_Mcompar_n0016_inst_lut2_9
    );
  XLXI_3_Mcompar_n0016_inst_cy_9_17 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0016_inst_cy_8,
      IA => XLXI_3_pwm_high(1),
      SEL => XLXI_3_Mcompar_n0016_inst_lut2_9,
      O => XLXI_3_Mcompar_n0016_inst_cy_9
    );
  XLXI_3_Mcompar_n0016_inst_lut2_101 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(2),
      ADR1 => XLXI_3_pwm_count(2),
      O => XLXI_3_Mcompar_n0016_inst_lut2_10
    );
  XLXI_3_Mcompar_n0016_inst_cy_10_18 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0016_inst_cy_9,
      IA => XLXI_3_pwm_high(2),
      SEL => XLXI_3_Mcompar_n0016_inst_lut2_10,
      O => XLXI_3_Mcompar_n0016_inst_cy_10
    );
  XLXI_3_Mcompar_n0016_inst_lut2_111 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(3),
      ADR1 => XLXI_3_pwm_count(3),
      O => XLXI_3_Mcompar_n0016_inst_lut2_11
    );
  XLXI_3_Mcompar_n0016_inst_cy_11_19 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0016_inst_cy_10,
      IA => XLXI_3_pwm_high(3),
      SEL => XLXI_3_Mcompar_n0016_inst_lut2_11,
      O => XLXI_3_Mcompar_n0016_inst_cy_11
    );
  XLXI_3_Mcompar_n0016_inst_lut2_121 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(4),
      ADR1 => XLXI_3_pwm_count(4),
      O => XLXI_3_Mcompar_n0016_inst_lut2_12
    );
  XLXI_3_Mcompar_n0016_inst_cy_12_20 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0016_inst_cy_11,
      IA => XLXI_3_pwm_high(4),
      SEL => XLXI_3_Mcompar_n0016_inst_lut2_12,
      O => XLXI_3_Mcompar_n0016_inst_cy_12
    );
  XLXI_3_Mcompar_n0016_inst_lut2_131 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(5),
      ADR1 => XLXI_3_pwm_count(5),
      O => XLXI_3_Mcompar_n0016_inst_lut2_13
    );
  XLXI_3_Mcompar_n0016_inst_cy_13_21 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0016_inst_cy_12,
      IA => XLXI_3_pwm_high(5),
      SEL => XLXI_3_Mcompar_n0016_inst_lut2_13,
      O => XLXI_3_Mcompar_n0016_inst_cy_13
    );
  XLXI_3_Mcompar_n0016_inst_lut2_141 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(6),
      ADR1 => XLXI_3_pwm_count(6),
      O => XLXI_3_Mcompar_n0016_inst_lut2_14
    );
  XLXI_3_Mcompar_n0015_inst_lut2_151 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(7),
      ADR1 => XLXI_3_pwm_count(7),
      O => XLXI_3_Mcompar_n0015_inst_lut2_15
    );
  XLXI_3_Mcompar_n0015_inst_cy_15 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0015_inst_cy_14,
      IA => XLXI_3_pwm_low(7),
      SEL => XLXI_3_Mcompar_n0015_inst_lut2_15,
      O => XLXI_3_n0015
    );
  XLXI_3_Mcompar_n0015_inst_lut2_81 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(0),
      ADR1 => XLXI_3_pwm_count(0),
      O => XLXI_3_Mcompar_n0015_inst_lut2_8
    );
  XLXI_3_Mcompar_n0015_inst_cy_8_22 : X_MUX2
    port map (
      IB => N19427,
      IA => XLXI_3_pwm_low(0),
      SEL => XLXI_3_Mcompar_n0015_inst_lut2_8,
      O => XLXI_3_Mcompar_n0015_inst_cy_8
    );
  XLXI_3_Mcompar_n0015_inst_lut2_91 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(1),
      ADR1 => XLXI_3_pwm_count(1),
      O => XLXI_3_Mcompar_n0015_inst_lut2_9
    );
  XLXI_3_Mcompar_n0015_inst_cy_9_23 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0015_inst_cy_8,
      IA => XLXI_3_pwm_low(1),
      SEL => XLXI_3_Mcompar_n0015_inst_lut2_9,
      O => XLXI_3_Mcompar_n0015_inst_cy_9
    );
  XLXI_3_Mcompar_n0015_inst_lut2_101 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(2),
      ADR1 => XLXI_3_pwm_count(2),
      O => XLXI_3_Mcompar_n0015_inst_lut2_10
    );
  XLXI_3_Mcompar_n0015_inst_cy_10_24 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0015_inst_cy_9,
      IA => XLXI_3_pwm_low(2),
      SEL => XLXI_3_Mcompar_n0015_inst_lut2_10,
      O => XLXI_3_Mcompar_n0015_inst_cy_10
    );
  XLXI_3_Mcompar_n0015_inst_lut2_111 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(3),
      ADR1 => XLXI_3_pwm_count(3),
      O => XLXI_3_Mcompar_n0015_inst_lut2_11
    );
  XLXI_3_Mcompar_n0015_inst_cy_11_25 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0015_inst_cy_10,
      IA => XLXI_3_pwm_low(3),
      SEL => XLXI_3_Mcompar_n0015_inst_lut2_11,
      O => XLXI_3_Mcompar_n0015_inst_cy_11
    );
  XLXI_3_Mcompar_n0015_inst_lut2_121 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(4),
      ADR1 => XLXI_3_pwm_count(4),
      O => XLXI_3_Mcompar_n0015_inst_lut2_12
    );
  XLXI_3_Mcompar_n0015_inst_cy_12_26 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0015_inst_cy_11,
      IA => XLXI_3_pwm_low(4),
      SEL => XLXI_3_Mcompar_n0015_inst_lut2_12,
      O => XLXI_3_Mcompar_n0015_inst_cy_12
    );
  XLXI_3_Mcompar_n0015_inst_lut2_131 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(5),
      ADR1 => XLXI_3_pwm_count(5),
      O => XLXI_3_Mcompar_n0015_inst_lut2_13
    );
  XLXI_3_Mcompar_n0015_inst_cy_13_27 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0015_inst_cy_12,
      IA => XLXI_3_pwm_low(5),
      SEL => XLXI_3_Mcompar_n0015_inst_lut2_13,
      O => XLXI_3_Mcompar_n0015_inst_cy_13
    );
  XLXI_3_Mcompar_n0015_inst_lut2_141 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(6),
      ADR1 => XLXI_3_pwm_count(6),
      O => XLXI_3_Mcompar_n0015_inst_lut2_14
    );
  XLXI_3_Mmux_n0011_Result_0_1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => N24633,
      ADR1 => CPU_DATA_OUT_0_OBUF,
      ADR2 => N23342,
      ADR3 => N24731,
      O => XLXI_3_n0011(0)
    );
  XLXI_3_Mmux_n0011_Result_1_1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => N24633,
      ADR1 => CPU_DATA_OUT_1_OBUF,
      ADR2 => N23342,
      ADR3 => N24735,
      O => XLXI_3_n0011(1)
    );
  XLXI_3_Mmux_n0011_Result_2_1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => N24633,
      ADR1 => CPU_DATA_OUT_2_OBUF,
      ADR2 => N23342,
      ADR3 => N24739,
      O => XLXI_3_n0011(2)
    );
  XLXI_3_Mmux_n0011_Result_4_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_3_N6905,
      ADR1 => XLXI_2_pwm_data_c(0),
      ADR2 => XLXI_3_pwm_period(4),
      O => XLXI_3_n0011(4)
    );
  XLXI_3_Mmux_n0011_Result_5_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_3_N6905,
      ADR1 => XLXI_2_pwm_data_c(1),
      ADR2 => XLXI_3_pwm_period(5),
      O => XLXI_3_n0011(5)
    );
  XLXI_3_Mmux_n0011_Result_6_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_3_N6905,
      ADR1 => XLXI_2_pwm_data_c(2),
      ADR2 => XLXI_3_pwm_period(6),
      O => XLXI_3_n0011(6)
    );
  XLXI_10_I3_n0035_1_7 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(2),
      ADR1 => XLXI_10_I2_TD_c(0),
      ADR2 => XLXI_10_I2_TD_c(1),
      ADR3 => XLXI_10_I3_n0059(1),
      O => CHOICE2036
    );
  XLXI_3_Msub_n0005_inst_lut2_161 : X_LUT4
    generic map(
      INIT => X"93C6"
    )
    port map (
      ADR0 => N24633,
      ADR1 => CPU_DATA_OUT_0_OBUF,
      ADR2 => XLXI_3_pwm_low(0),
      ADR3 => N24823,
      O => XLXI_3_Msub_n0005_inst_lut2_16
    );
  XLXI_3_Msub_n0005_inst_lut2_171 : X_LUT4
    generic map(
      INIT => X"93C6"
    )
    port map (
      ADR0 => N24633,
      ADR1 => CPU_DATA_OUT_1_OBUF,
      ADR2 => XLXI_3_pwm_low(1),
      ADR3 => N24819,
      O => XLXI_3_Msub_n0005_inst_lut2_17
    );
  XLXI_3_Msub_n0005_inst_lut2_181 : X_LUT4
    generic map(
      INIT => X"93C6"
    )
    port map (
      ADR0 => N24633,
      ADR1 => CPU_DATA_OUT_2_OBUF,
      ADR2 => XLXI_3_pwm_low(2),
      ADR3 => N24815,
      O => XLXI_3_Msub_n0005_inst_lut2_18
    );
  XLXI_3_Msub_n0005_inst_lut2_191 : X_LUT4
    generic map(
      INIT => X"93C6"
    )
    port map (
      ADR0 => N24633,
      ADR1 => CPU_DATA_OUT_3_OBUF,
      ADR2 => XLXI_3_pwm_low(3),
      ADR3 => N24811,
      O => XLXI_3_Msub_n0005_inst_lut2_19
    );
  XLXI_3_Msub_n0005_inst_lut2_201 : X_LUT4
    generic map(
      INIT => X"93C6"
    )
    port map (
      ADR0 => N24633,
      ADR1 => XLXI_2_pwm_data_c(0),
      ADR2 => XLXI_3_pwm_low(4),
      ADR3 => N24807,
      O => XLXI_3_Msub_n0005_inst_lut2_20
    );
  XLXI_3_Msub_n0005_inst_lut2_211 : X_LUT4
    generic map(
      INIT => X"93C6"
    )
    port map (
      ADR0 => N24633,
      ADR1 => XLXI_2_pwm_data_c(1),
      ADR2 => XLXI_3_pwm_low(5),
      ADR3 => N24803,
      O => XLXI_3_Msub_n0005_inst_lut2_21
    );
  XLXI_3_Mcompar_n0013_inst_lut2_301 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(6),
      ADR1 => XLXI_3_pwm_count(6),
      O => XLXI_3_Mcompar_n0013_inst_lut2_30
    );
  XLXI_3_Msub_n0005_inst_sum_15 : X_XOR2
    port map (
      I0 => XLXI_3_Msub_n0005_inst_lut2_23,
      I1 => XLXI_3_Msub_n0005_inst_cy_22,
      O => XLXI_3_n0005(7)
    );
  XLXI_10_I1_pc_7_rt_28 : X_LUT2
    generic map(
      INIT => X"A"
    )
    port map (
      ADR0 => XLXI_10_I1_pc(7),
      O => XLXI_10_I1_pc_7_rt,
      ADR1 => GND
    );
  XLXI_3_Msub_n0005_inst_cy_16_29 : X_MUX2
    port map (
      IB => N19080_rt,
      IA => XLXI_3_n0011(0),
      SEL => XLXI_3_Msub_n0005_inst_lut2_16,
      O => XLXI_3_Msub_n0005_inst_cy_16
    );
  XLXI_3_Msub_n0005_inst_sum_8 : X_XOR2
    port map (
      I0 => XLXI_3_Msub_n0005_inst_lut2_16,
      I1 => N19080_rt,
      O => XLXI_3_n0005(0)
    );
  XLXI_3_pwm_count_7_rt_30 : X_LUT2
    generic map(
      INIT => X"A"
    )
    port map (
      ADR0 => XLXI_3_pwm_count(7),
      O => XLXI_3_pwm_count_7_rt,
      ADR1 => GND
    );
  XLXI_3_Msub_n0005_inst_cy_17_31 : X_MUX2
    port map (
      IB => XLXI_3_Msub_n0005_inst_cy_16,
      IA => XLXI_3_n0011(1),
      SEL => XLXI_3_Msub_n0005_inst_lut2_17,
      O => XLXI_3_Msub_n0005_inst_cy_17
    );
  XLXI_3_Msub_n0005_inst_sum_9 : X_XOR2
    port map (
      I0 => XLXI_3_Msub_n0005_inst_lut2_17,
      I1 => XLXI_3_Msub_n0005_inst_cy_16,
      O => XLXI_3_n0005(1)
    );
  XLXI_10_I1_pc_4_rt_32 : X_LUT2
    generic map(
      INIT => X"A"
    )
    port map (
      ADR0 => XLXI_10_I1_pc(4),
      O => XLXI_10_I1_pc_4_rt,
      ADR1 => GND
    );
  XLXI_3_Msub_n0005_inst_cy_18_33 : X_MUX2
    port map (
      IB => XLXI_3_Msub_n0005_inst_cy_17,
      IA => XLXI_3_n0011(2),
      SEL => XLXI_3_Msub_n0005_inst_lut2_18,
      O => XLXI_3_Msub_n0005_inst_cy_18
    );
  XLXI_3_Msub_n0005_inst_sum_10 : X_XOR2
    port map (
      I0 => XLXI_3_Msub_n0005_inst_lut2_18,
      I1 => XLXI_3_Msub_n0005_inst_cy_17,
      O => XLXI_3_n0005(2)
    );
  XLXI_10_I1_pc_1_rt_34 : X_LUT2
    generic map(
      INIT => X"A"
    )
    port map (
      ADR0 => XLXI_10_I1_pc(1),
      O => XLXI_10_I1_pc_1_rt,
      ADR1 => GND
    );
  XLXI_3_Msub_n0005_inst_cy_19_35 : X_MUX2
    port map (
      IB => XLXI_3_Msub_n0005_inst_cy_18,
      IA => XLXI_3_n0011(3),
      SEL => XLXI_3_Msub_n0005_inst_lut2_19,
      O => XLXI_3_Msub_n0005_inst_cy_19
    );
  XLXI_3_Msub_n0005_inst_sum_11 : X_XOR2
    port map (
      I0 => XLXI_3_Msub_n0005_inst_lut2_19,
      I1 => XLXI_3_Msub_n0005_inst_cy_18,
      O => XLXI_3_n0005(3)
    );
  XLXI_10_I1_pc_5_rt_36 : X_LUT2
    generic map(
      INIT => X"A"
    )
    port map (
      ADR0 => XLXI_10_I1_pc(5),
      O => XLXI_10_I1_pc_5_rt,
      ADR1 => GND
    );
  XLXI_3_Msub_n0005_inst_cy_20_37 : X_MUX2
    port map (
      IB => XLXI_3_Msub_n0005_inst_cy_19,
      IA => XLXI_3_n0011(4),
      SEL => XLXI_3_Msub_n0005_inst_lut2_20,
      O => XLXI_3_Msub_n0005_inst_cy_20
    );
  XLXI_3_Msub_n0005_inst_sum_12 : X_XOR2
    port map (
      I0 => XLXI_3_Msub_n0005_inst_lut2_20,
      I1 => XLXI_3_Msub_n0005_inst_cy_19,
      O => XLXI_3_n0005(4)
    );
  XLXI_10_I1_pc_2_rt_38 : X_LUT2
    generic map(
      INIT => X"A"
    )
    port map (
      ADR0 => XLXI_10_I1_pc(2),
      O => XLXI_10_I1_pc_2_rt,
      ADR1 => GND
    );
  XLXI_3_Msub_n0005_inst_cy_21_39 : X_MUX2
    port map (
      IB => XLXI_3_Msub_n0005_inst_cy_20,
      IA => XLXI_3_n0011(5),
      SEL => XLXI_3_Msub_n0005_inst_lut2_21,
      O => XLXI_3_Msub_n0005_inst_cy_21
    );
  XLXI_3_Msub_n0005_inst_sum_13 : X_XOR2
    port map (
      I0 => XLXI_3_Msub_n0005_inst_lut2_21,
      I1 => XLXI_3_Msub_n0005_inst_cy_20,
      O => XLXI_3_n0005(5)
    );
  XLXI_10_I1_pc_6_rt_40 : X_LUT2
    generic map(
      INIT => X"A"
    )
    port map (
      ADR0 => XLXI_10_I1_pc(6),
      O => XLXI_10_I1_pc_6_rt,
      ADR1 => GND
    );
  XLXI_3_Msub_n0005_inst_cy_22_41 : X_MUX2
    port map (
      IB => XLXI_3_Msub_n0005_inst_cy_21,
      IA => XLXI_3_n0011(6),
      SEL => XLXI_3_Msub_n0005_inst_lut2_22,
      O => XLXI_3_Msub_n0005_inst_cy_22
    );
  XLXI_3_Msub_n0005_inst_sum_14 : X_XOR2
    port map (
      I0 => XLXI_3_Msub_n0005_inst_lut2_22,
      I1 => XLXI_3_Msub_n0005_inst_cy_21,
      O => XLXI_3_n0005(6)
    );
  XLXI_3_Mcompar_n0014_inst_cy_31_42 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0014_inst_cy_30,
      IA => XLXI_3_pwm_low(7),
      SEL => XLXI_3_Mcompar_n0014_inst_lut2_31,
      O => XLXI_3_Mcompar_n0014_inst_cy_31
    );
  XLXI_3_Ker69031_SW4_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => XLXI_3_pwm_low(5),
      ADR2 => XLXI_3_pwm_period(5),
      O => N25212
    );
  XLXI_3_Mcompar_n0014_inst_lut2_241 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(0),
      ADR1 => XLXI_3_pwm_count(0),
      O => XLXI_3_Mcompar_n0014_inst_lut2_24
    );
  XLXI_3_Mcompar_n0014_inst_cy_24_43 : X_MUX2
    port map (
      IB => N19427,
      IA => XLXI_3_pwm_low(0),
      SEL => XLXI_3_Mcompar_n0014_inst_lut2_24,
      O => XLXI_3_Mcompar_n0014_inst_cy_24
    );
  XLXI_3_Mcompar_n0014_inst_lut2_251 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(1),
      ADR1 => XLXI_3_pwm_count(1),
      O => XLXI_3_Mcompar_n0014_inst_lut2_25
    );
  XLXI_3_Mcompar_n0014_inst_cy_25_44 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0014_inst_cy_24,
      IA => XLXI_3_pwm_low(1),
      SEL => XLXI_3_Mcompar_n0014_inst_lut2_25,
      O => XLXI_3_Mcompar_n0014_inst_cy_25
    );
  XLXI_3_Mcompar_n0014_inst_lut2_261 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(2),
      ADR1 => XLXI_3_pwm_count(2),
      O => XLXI_3_Mcompar_n0014_inst_lut2_26
    );
  XLXI_3_Mcompar_n0014_inst_cy_26_45 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0014_inst_cy_25,
      IA => XLXI_3_pwm_low(2),
      SEL => XLXI_3_Mcompar_n0014_inst_lut2_26,
      O => XLXI_3_Mcompar_n0014_inst_cy_26
    );
  XLXI_3_Mcompar_n0014_inst_lut2_271 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(3),
      ADR1 => XLXI_3_pwm_count(3),
      O => XLXI_3_Mcompar_n0014_inst_lut2_27
    );
  XLXI_3_Mcompar_n0014_inst_cy_27_46 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0014_inst_cy_26,
      IA => XLXI_3_pwm_low(3),
      SEL => XLXI_3_Mcompar_n0014_inst_lut2_27,
      O => XLXI_3_Mcompar_n0014_inst_cy_27
    );
  XLXI_3_Mcompar_n0014_inst_lut2_281 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(4),
      ADR1 => XLXI_3_pwm_count(4),
      O => XLXI_3_Mcompar_n0014_inst_lut2_28
    );
  XLXI_3_Mcompar_n0014_inst_cy_28_47 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0014_inst_cy_27,
      IA => XLXI_3_pwm_low(4),
      SEL => XLXI_3_Mcompar_n0014_inst_lut2_28,
      O => XLXI_3_Mcompar_n0014_inst_cy_28
    );
  XLXI_3_Mcompar_n0014_inst_lut2_291 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(5),
      ADR1 => XLXI_3_pwm_count(5),
      O => XLXI_3_Mcompar_n0014_inst_lut2_29
    );
  XLXI_3_Mcompar_n0014_inst_cy_29_48 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0014_inst_cy_28,
      IA => XLXI_3_pwm_low(5),
      SEL => XLXI_3_Mcompar_n0014_inst_lut2_29,
      O => XLXI_3_Mcompar_n0014_inst_cy_29
    );
  XLXI_3_Mcompar_n0014_inst_lut2_301 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(6),
      ADR1 => XLXI_3_pwm_count(6),
      O => XLXI_3_Mcompar_n0014_inst_lut2_30
    );
  XLXI_3_Mcompar_n0014_inst_cy_30_49 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0014_inst_cy_29,
      IA => XLXI_3_pwm_low(6),
      SEL => XLXI_3_Mcompar_n0014_inst_lut2_30,
      O => XLXI_3_Mcompar_n0014_inst_cy_30
    );
  XLXI_3_Mcompar_n0013_inst_cy_31_50 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0013_inst_cy_30,
      IA => XLXI_3_pwm_high(7),
      SEL => XLXI_3_Mcompar_n0013_inst_lut2_31,
      O => XLXI_3_Mcompar_n0013_inst_cy_31
    );
  XLXI_3_Mcompar_n0013_inst_lut2_241 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(0),
      ADR1 => XLXI_3_pwm_count(0),
      O => XLXI_3_Mcompar_n0013_inst_lut2_24
    );
  XLXI_3_Mcompar_n0013_inst_cy_24_51 : X_MUX2
    port map (
      IB => N19427,
      IA => XLXI_3_pwm_high(0),
      SEL => XLXI_3_Mcompar_n0013_inst_lut2_24,
      O => XLXI_3_Mcompar_n0013_inst_cy_24
    );
  XLXI_3_Mcompar_n0013_inst_lut2_251 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(1),
      ADR1 => XLXI_3_pwm_count(1),
      O => XLXI_3_Mcompar_n0013_inst_lut2_25
    );
  XLXI_3_Mcompar_n0013_inst_cy_25_52 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0013_inst_cy_24,
      IA => XLXI_3_pwm_high(1),
      SEL => XLXI_3_Mcompar_n0013_inst_lut2_25,
      O => XLXI_3_Mcompar_n0013_inst_cy_25
    );
  XLXI_3_Mcompar_n0013_inst_lut2_261 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(2),
      ADR1 => XLXI_3_pwm_count(2),
      O => XLXI_3_Mcompar_n0013_inst_lut2_26
    );
  XLXI_3_Mcompar_n0013_inst_cy_26_53 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0013_inst_cy_25,
      IA => XLXI_3_pwm_high(2),
      SEL => XLXI_3_Mcompar_n0013_inst_lut2_26,
      O => XLXI_3_Mcompar_n0013_inst_cy_26
    );
  XLXI_3_Mcompar_n0013_inst_lut2_271 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(3),
      ADR1 => XLXI_3_pwm_count(3),
      O => XLXI_3_Mcompar_n0013_inst_lut2_27
    );
  XLXI_3_Mcompar_n0013_inst_cy_27_54 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0013_inst_cy_26,
      IA => XLXI_3_pwm_high(3),
      SEL => XLXI_3_Mcompar_n0013_inst_lut2_27,
      O => XLXI_3_Mcompar_n0013_inst_cy_27
    );
  XLXI_3_Mcompar_n0013_inst_lut2_281 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(4),
      ADR1 => XLXI_3_pwm_count(4),
      O => XLXI_3_Mcompar_n0013_inst_lut2_28
    );
  XLXI_3_Mcompar_n0013_inst_cy_28_55 : X_MUX2
    port map (
      IB => XLXI_3_Mcompar_n0013_inst_cy_27,
      IA => XLXI_3_pwm_high(4),
      SEL => XLXI_3_Mcompar_n0013_inst_lut2_28,
      O => XLXI_3_Mcompar_n0013_inst_cy_28
    );
  XLXI_3_Mcompar_n0013_inst_lut2_291 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(5),
      ADR1 => XLXI_3_pwm_count(5),
      O => XLXI_3_Mcompar_n0013_inst_lut2_29
    );
  XLXI_10_I1_Madd_n0013_inst_cy_3_56 : X_MUX2
    port map (
      IB => XLXI_10_I1_Madd_n0013_inst_cy_2,
      IA => N19427,
      SEL => XLXI_10_I1_pc_3_rt,
      O => XLXI_10_I1_Madd_n0013_inst_cy_3
    );
  XLXI_10_I1_Madd_n0013_inst_cy_6_57 : X_MUX2
    port map (
      IB => XLXI_10_I1_Madd_n0013_inst_cy_5,
      IA => N19427,
      SEL => XLXI_10_I1_pc_6_rt,
      O => XLXI_10_I1_Madd_n0013_inst_cy_6
    );
  XLXI_10_I1_Madd_n0013_inst_sum_4 : X_XOR2
    port map (
      I0 => XLXI_10_I1_pc_4_rt,
      I1 => XLXI_10_I1_Madd_n0013_inst_cy_3,
      O => XLXI_10_I1_n0013(4)
    );
  XLXI_10_I1_n0008_0_1 : X_LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      ADR0 => XLXI_10_I1_nreset_v(1),
      ADR1 => XLXI_10_I1_nreset_v(0),
      O => XLXI_10_I1_n0008(0)
    );
  XLXI_10_I1_Madd_n0013_inst_cy_2_58 : X_MUX2
    port map (
      IB => XLXI_10_I1_Madd_n0013_inst_cy_1,
      IA => N19427,
      SEL => XLXI_10_I1_pc_2_rt,
      O => XLXI_10_I1_Madd_n0013_inst_cy_2
    );
  XLXI_10_I2_pc_mux_x_0_13 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => XLXN_8(1),
      ADR1 => XLXN_8(3),
      ADR2 => XLXN_8(2),
      ADR3 => XLXN_8(0),
      O => CHOICE1708
    );
  XLXI_10_I1_pc_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => N25295,
      RST => XLXI_10_I1_pc_4_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_pc(4),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I1_pc_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => N25370,
      RST => XLXI_10_I1_pc_5_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_pc(5),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I1_Madd_n0013_inst_sum_2 : X_XOR2
    port map (
      I0 => XLXI_10_I1_pc_2_rt,
      I1 => XLXI_10_I1_Madd_n0013_inst_cy_1,
      O => XLXI_10_I1_n0013(2)
    );
  XLXI_10_I1_Madd_n0013_inst_sum_7 : X_XOR2
    port map (
      I0 => XLXI_10_I1_pc_7_rt,
      I1 => XLXI_10_I1_Madd_n0013_inst_cy_6,
      O => XLXI_10_I1_n0013(7)
    );
  XLXI_10_I1_pc_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => N25368,
      RST => XLXI_10_I1_pc_2_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_pc(2),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I1_pc_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => N25293,
      RST => XLXI_10_I1_pc_3_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_pc(3),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I2_pc_mux_x_1_Q : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => N25312,
      ADR1 => XLXI_10_I2_N8283,
      ADR2 => NRESET_IBUF,
      ADR3 => N22263,
      O => XLXI_10_pc_mux(1)
    );
  XLXI_10_I4_daddr_x_4_1 : X_LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      ADR0 => XLXN_8(8),
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      O => XLXI_10_adaddr_out(4)
    );
  XLXI_10_I1_n00141 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXI_10_I1_nreset_v(1),
      O => XLXI_10_I1_n0014
    );
  XLXI_10_I2_Ker8265 : X_LUT4
    generic map(
      INIT => X"FFF1"
    )
    port map (
      ADR0 => XLXN_8(1),
      ADR1 => XLXN_8(2),
      ADR2 => N25102,
      ADR3 => XLXI_10_I2_TC_c(2),
      O => XLXI_10_I2_N8267
    );
  XLXI_10_I2_Ker8265_SW1 : X_LUT3
    generic map(
      INIT => X"DF"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(1),
      ADR1 => XLXI_10_I2_skip_c,
      ADR2 => XLXI_10_I2_TC_c(0),
      O => N25102
    );
  XLXI_10_I1_Madd_n0013_inst_cy_5_59 : X_MUX2
    port map (
      IB => XLXI_10_I1_Madd_n0013_inst_cy_4,
      IA => N19427,
      SEL => XLXI_10_I1_pc_5_rt,
      O => XLXI_10_I1_Madd_n0013_inst_cy_5
    );
  XLXI_10_I1_stack_addrs_c_0_7_60 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0012(7),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_0_7,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_1_7_61 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0011(7),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_1_7,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_2_7_62 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0010(7),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_2_7,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_3_7_63 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0009(7),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_3_7,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_nreset_v_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => N19080_rt,
      CE => XLXI_10_I1_nreset_v(0),
      RST => XLXI_10_I1_nreset_v_1_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_nreset_v(1),
      SET => GND
    );
  XLXI_10_I1_pc_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => N25278,
      RST => XLXI_10_I1_pc_7_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_pc(7),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I3_n0035_4_11_SW0 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N24687,
      ADR1 => XLXI_10_I3_n0058(4),
      ADR2 => N24685,
      ADR3 => XLXI_10_I3_n0048,
      O => N24827
    );
  XLXI_10_I2_TD_x_2_38 : X_LUT3
    generic map(
      INIT => X"01"
    )
    port map (
      ADR0 => XLXN_8(1),
      ADR1 => XLXN_8(3),
      ADR2 => XLXN_8(0),
      O => CHOICE1745
    );
  XLXI_10_I4_ndre_x1_SW1 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXN_8(4),
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => XLXI_10_I5_daddr_c(0),
      ADR3 => NRESET_IBUF,
      O => N24641
    );
  XLXI_10_I1_Madd_n0013_inst_cy_1_64 : X_MUX2
    port map (
      IB => XLXI_10_I1_Madd_n0013_inst_cy_0,
      IA => N19427,
      SEL => XLXI_10_I1_pc_1_rt,
      O => XLXI_10_I1_Madd_n0013_inst_cy_1
    );
  XLXI_10_I1_Madd_n0013_inst_sum_3 : X_XOR2
    port map (
      I0 => XLXI_10_I1_pc_3_rt,
      I1 => XLXI_10_I1_Madd_n0013_inst_cy_2,
      O => XLXI_10_I1_n0013(3)
    );
  CPU_DADDR_3_OBUF_65 : X_BUF
    port map (
      I => CPU_DADDR_3_OBUF,
      O => CPU_DADDR_3_OBUF_GTS_TRI
    );
  XLXI_10_I1_Madd_n0013_inst_sum_1 : X_XOR2
    port map (
      I0 => XLXI_10_I1_pc_1_rt,
      I1 => XLXI_10_I1_Madd_n0013_inst_cy_0,
      O => XLXI_10_I1_n0013(1)
    );
  CPU_DADDR_0_OBUF_66 : X_BUF
    port map (
      I => CPU_DADDR_0_OBUF,
      O => CPU_DADDR_0_OBUF_GTS_TRI
    );
  XLXI_10_I1_Madd_n0013_inst_sum_5 : X_XOR2
    port map (
      I0 => XLXI_10_I1_pc_5_rt,
      I1 => XLXI_10_I1_Madd_n0013_inst_cy_4,
      O => XLXI_10_I1_n0013(5)
    );
  XLXI_10_I1_n0010_0_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => N25418,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_0,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_0,
      O => N25058
    );
  XLXI_10_I1_n0011_7_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_7,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_7,
      O => N25086
    );
  XLXI_10_I3_Ker906222 : X_LUT4
    generic map(
      INIT => X"1119"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(0),
      ADR1 => XLXI_10_I2_TD_c(2),
      ADR2 => XLXI_10_I2_TC_c(0),
      ADR3 => XLXI_10_I2_TC_c(1),
      O => CHOICE1457
    );
  XLXI_2_n0043_67 : X_LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      ADR0 => CPU_DADDR_4_OBUF,
      ADR1 => CPU_DADDR_0_OBUF,
      ADR2 => CPU_DADDR_3_OBUF,
      ADR3 => N21431,
      O => XLXI_2_n0043
    );
  XLXI_10_I1_n0011_0_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_0,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_0,
      O => N25078
    );
  XLXI_10_I1_n0010_7_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_7,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_7,
      O => N25042
    );
  XLXI_10_I4_Ker9710 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => XLXN_8(6),
      ADR1 => N25316,
      ADR2 => XLXN_8(5),
      ADR3 => XLXN_8(4),
      O => XLXI_10_I4_N9712
    );
  XLXI_10_I1_Madd_n0013_inst_sum_6 : X_XOR2
    port map (
      I0 => XLXI_10_I1_pc_6_rt,
      I1 => XLXI_10_I1_Madd_n0013_inst_cy_5,
      O => XLXI_10_I1_n0013(6)
    );
  XLXI_10_I1_stack_addrs_c_0_0_68 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0012(0),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_0_0,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_0_1_69 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0012(1),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_0_1,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_0_2_70 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0012(2),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_0_2,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_0_3_71 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0012(3),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_0_3,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_0_4_72 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0012(4),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_0_4,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_0_5_73 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0012(5),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_0_5,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_0_6_74 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0012(6),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_0_6,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_1_0_75 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0011(0),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_1_0,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_1_1_76 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0011(1),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_1_1,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_1_2_77 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0011(2),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_1_2,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_1_3_78 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0011(3),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_1_3,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_1_4_79 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0011(4),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_1_4,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_1_5_80 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0011(5),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_1_5,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_1_6_81 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0011(6),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_1_6,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_2_0_82 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0010(0),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_2_0,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_2_1_83 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0010(1),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_2_1,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_2_2_84 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0010(2),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_2_2,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_2_3_85 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0010(3),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_2_3,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_2_4_86 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0010(4),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_2_4,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_2_5_87 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0010(5),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_2_5,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_2_6_88 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0010(6),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_2_6,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_3_0_89 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0009(0),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_3_0,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_3_1_90 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0009(1),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_3_1,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_3_2_91 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0009(2),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_3_2,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_3_3_92 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0009(3),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_3_3,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_3_4_93 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0009(4),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_3_4,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_3_5_94 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0009(5),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_3_5,
      SET => GND,
      RST => GSR
    );
  XLXI_10_I1_stack_addrs_c_3_6_95 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0009(6),
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_stack_addrs_c_3_6,
      SET => GND,
      RST => GSR
    );
  CTRL_DATA_OUT_1_OBUF : X_BUF
    port map (
      I => XLXI_2_ctrl_data_c(1),
      O => CTRL_DATA_OUT_1_OBUF_GTS_TRI
    );
  XLXI_10_I1_nreset_v_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0008(0),
      RST => XLXI_10_I1_nreset_v_0_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_nreset_v(0),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I1_pc_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => N25365,
      RST => XLXI_10_I1_pc_6_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_pc(6),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I1_pc_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => N25298,
      RST => XLXI_10_I1_pc_0_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_pc(0),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I1_pc_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => N25378,
      RST => XLXI_10_I1_pc_1_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I1_pc(1),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I1_Madd_n0013_inst_cy_4_96 : X_MUX2
    port map (
      IB => XLXI_10_I1_Madd_n0013_inst_cy_3,
      IA => N19427,
      SEL => XLXI_10_I1_pc_4_rt,
      O => XLXI_10_I1_Madd_n0013_inst_cy_4
    );
  XLXI_10_I1_Madd_n0013_inst_lut2_01 : X_LUT2
    generic map(
      INIT => X"5"
    )
    port map (
      ADR0 => XLXI_10_I1_pc(0),
      O => XLXI_10_I1_Madd_n0013_inst_lut2_0,
      ADR1 => GND
    );
  XLXI_10_I2_valid_x1 : X_LUT4
    generic map(
      INIT => X"FD00"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXN_8(3),
      ADR2 => XLXI_10_I2_N8267,
      ADR3 => XLXI_10_I2_N8359,
      O => XLXI_10_I2_valid_x
    );
  XLXI_10_I2_skip_c_97 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_skip,
      RST => XLXI_10_I2_skip_c_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I2_skip_c,
      CE => VCC,
      SET => GND
    );
  XLXI_10_I2_TD_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_TD_x(0),
      RST => XLXI_10_I2_TD_c_0_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I2_TD_c(0),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I2_TD_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_TD_x(2),
      RST => XLXI_10_I2_TD_c_2_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I2_TD_c(2),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I1_iaddr_x_7_14 : X_LUT4
    generic map(
      INIT => X"F404"
    )
    port map (
      ADR0 => N25322,
      ADR1 => XLXI_10_I1_pc(7),
      ADR2 => XLXI_10_pc_mux(1),
      ADR3 => XLXI_10_I4_ipage_c(1),
      O => CHOICE1864
    );
  XLXI_10_I2_data_is_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXN_8(5),
      RST => XLXI_10_I2_data_is_c_1_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I2_data_is_c(1),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I2_TD_x_1_97 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXN_8(1),
      ADR2 => CHOICE1786,
      ADR3 => CHOICE1791,
      O => XLXI_10_I2_TD_x(1)
    );
  XLXI_10_I2_TD_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_TD_x(1),
      RST => XLXI_10_I2_TD_c_1_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I2_TD_c(1),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I2_TC_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_TC_x(0),
      RST => XLXI_10_I2_TC_c_0_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I2_TC_c(0),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I2_valid_c_98 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_valid_x,
      RST => XLXI_10_I2_valid_c_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I2_valid_c,
      CE => VCC,
      SET => GND
    );
  XLXI_10_I2_nreset_v_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_n0028(0),
      RST => XLXI_10_I2_nreset_v_0_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I2_nreset_v(0),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I2_n0028_0_1 : X_LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      ADR0 => XLXI_10_I2_nreset_v(1),
      ADR1 => XLXI_10_I2_nreset_v(0),
      O => XLXI_10_I2_n0028(0)
    );
  XLXI_10_I2_data_is_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXN_8(6),
      RST => XLXI_10_I2_data_is_c_2_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I2_data_is_c(2),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I2_nreset_v_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => N19080_rt,
      CE => XLXI_10_I2_nreset_v(0),
      RST => XLXI_10_I2_nreset_v_1_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I2_nreset_v(1),
      SET => GND
    );
  XLXI_10_I2_TD_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_TD_x(3),
      RST => XLXI_10_I2_TD_c_3_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I2_TD_c(3),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I2_TC_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_TC_x(2),
      RST => XLXI_10_I2_TC_c_2_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I2_TC_c(2),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I2_TD_x_0_76 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => CHOICE1750,
      ADR2 => CHOICE1759,
      ADR3 => CHOICE1767,
      O => XLXI_10_I2_TD_x(0)
    );
  XLXI_10_I2_TC_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I2_TC_x(1),
      RST => XLXI_10_I2_TC_c_1_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I2_TC_c(1),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I2_data_is_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXN_8(4),
      RST => XLXI_10_I2_data_is_c_0_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I2_data_is_c(0),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I2_data_is_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXN_8(7),
      RST => XLXI_10_I2_data_is_c_3_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I2_data_is_c(3),
      CE => VCC,
      SET => GND
    );
  CPU_DADDR_4_OBUF_99 : X_BUF
    port map (
      I => CPU_DADDR_4_OBUF,
      O => CPU_DADDR_4_OBUF_GTS_TRI
    );
  CTRL_DATA_OUT_3_OBUF : X_BUF
    port map (
      I => XLXI_2_ctrl_data_c(3),
      O => CTRL_DATA_OUT_3_OBUF_GTS_TRI
    );
  XLXI_10_I2_TD_x_0_39 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => XLXN_8(2),
      ADR1 => XLXN_8(0),
      ADR2 => CHOICE1762,
      ADR3 => XLXN_8(4),
      O => CHOICE1767
    );
  XLXI_10_I2_ndwe_x1 : X_LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      ADR0 => XLXI_10_I2_N8327,
      ADR1 => XLXI_10_I2_N8283,
      ADR2 => XLXN_8(3),
      ADR3 => XLXN_8(0),
      O => XLXI_10_ndwe_int
    );
  XLXI_10_I2_TD_x_2_72 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXN_8(2),
      ADR2 => CHOICE1740,
      ADR3 => CHOICE1745,
      O => XLXI_10_I2_TD_x(2)
    );
  XLXI_3_n000712 : X_LUT4
    generic map(
      INIT => X"202A"
    )
    port map (
      ADR0 => XLXI_2_ctrl_data_c(0),
      ADR1 => XLXI_3_Mcompar_n0013_inst_cy_31,
      ADR2 => XLXI_3_pwm_c,
      ADR3 => XLXI_3_Mcompar_n0014_inst_cy_31,
      O => CHOICE1444
    );
  XLXI_10_I2_TC_x_1_1 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXN_8(3),
      ADR2 => XLXN_8(0),
      ADR3 => XLXI_10_I2_N8283,
      O => XLXI_10_I2_TC_x(1)
    );
  XLXI_10_I3_acc_c_0_4_100 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I3_n0035(4),
      CE => XLXI_10_I3_n0073,
      RST => XLXI_10_I3_acc_c_0_4_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I3_acc_c_0_4,
      SET => GND
    );
  XLXI_10_I3_nreset_v_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => N19080_rt,
      CE => XLXI_10_I3_nreset_v(0),
      RST => XLXI_10_I3_nreset_v_1_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I3_nreset_v(1),
      SET => GND
    );
  XLXI_10_I3_Ker89131 : X_LUT3
    generic map(
      INIT => X"82"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(1),
      ADR1 => XLXI_10_I2_TD_c(0),
      ADR2 => XLXI_10_I2_TD_c(2),
      O => XLXI_10_I3_N8915
    );
  XLXI_10_I3_n0035_0_41 : X_LUT4
    generic map(
      INIT => X"FFEA"
    )
    port map (
      ADR0 => CHOICE1953,
      ADR1 => XLXI_10_I3_n0059(0),
      ADR2 => XLXI_10_I3_n0055,
      ADR3 => N24629,
      O => CHOICE1956
    );
  XLXI_10_I3_Ker90451 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_10_I2_valid_c,
      ADR1 => XLXI_10_I2_TC_c(2),
      ADR2 => XLXI_10_I3_nreset_v(1),
      ADR3 => XLXI_10_I3_nreset_v(0),
      O => XLXI_10_I3_N9047
    );
  XLXI_10_I3_Msub_n0059_inst_cy_36_101 : X_MUX2
    port map (
      IB => N19080_rt,
      IA => XLXI_10_I3_acc_c_0_0,
      SEL => XLXI_10_I3_Msub_n0059_inst_lut2_36,
      O => XLXI_10_I3_Msub_n0059_inst_cy_36
    );
  XLXI_10_I3_n00731 : X_LUT3
    generic map(
      INIT => X"DF"
    )
    port map (
      ADR0 => XLXI_10_I3_nreset_v(0),
      ADR1 => XLXI_10_I2_valid_c,
      ADR2 => XLXI_10_I3_nreset_v(1),
      O => XLXI_10_I3_n0073
    );
  XLXI_10_I3_acc_c_0_1_102 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I3_n0035(1),
      CE => XLXI_10_I3_n0073,
      RST => XLXI_10_I3_acc_c_0_1_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I3_acc_c_0_1,
      SET => GND
    );
  XLXI_10_I3_Ker89321 : X_LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(0),
      ADR1 => XLXI_10_I2_TD_c(2),
      O => XLXI_10_I3_N8934
    );
  XLXI_10_I3_acc_c_0_2_103 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I3_n0035(2),
      CE => XLXI_10_I3_n0073,
      RST => XLXI_10_I3_acc_c_0_2_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I3_acc_c_0_2,
      SET => GND
    );
  XLXI_10_I3_Madd_n0064_inst_cy_35 : X_MUX2
    port map (
      IB => XLXI_10_I3_Madd_n0064_inst_cy_34,
      IA => XLXI_10_I3_acc_c_0_3,
      SEL => XLXI_10_I3_Madd_n0064_inst_lut2_35,
      O => XLXI_10_I3_n0058(4)
    );
  XLXI_10_I3_Msub_n0059_inst_sum_23 : X_XOR2
    port map (
      I0 => XLXI_10_I3_Msub_n0059_inst_lut2_39,
      I1 => XLXI_10_I3_Msub_n0059_inst_cy_38,
      O => XLXI_10_I3_n0059(3)
    );
  XLXI_10_I3_Msub_n0059_inst_sum_22 : X_XOR2
    port map (
      I0 => XLXI_10_I3_Msub_n0059_inst_lut2_38,
      I1 => XLXI_10_I3_Msub_n0059_inst_cy_37,
      O => XLXI_10_I3_n0059(2)
    );
  XLXI_10_I3_Msub_n0059_inst_lut2_381 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N24681,
      ADR1 => XLXI_10_I4_N9697,
      ADR2 => N24679,
      ADR3 => N23412,
      O => XLXI_10_I3_Msub_n0059_inst_lut2_38
    );
  XLXI_10_I3_acc_c_0_0_104 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I3_n0035(0),
      CE => XLXI_10_I3_n0073,
      RST => XLXI_10_I3_acc_c_0_0_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I3_acc_c_0_0,
      SET => GND
    );
  XLXI_10_I3_n00621 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(2),
      ADR1 => XLXI_10_I2_valid_c,
      ADR2 => XLXI_10_I3_nreset_v(1),
      ADR3 => XLXI_10_I3_nreset_v(0),
      O => XLXI_10_I3_n0062
    );
  XLXI_10_I3_Msub_n0059_inst_cy_37_105 : X_MUX2
    port map (
      IB => XLXI_10_I3_Msub_n0059_inst_cy_36,
      IA => XLXI_10_I3_acc_c_0_1,
      SEL => XLXI_10_I3_Msub_n0059_inst_lut2_37,
      O => XLXI_10_I3_Msub_n0059_inst_cy_37
    );
  XLXI_10_I3_Ker89021 : X_LUT3
    generic map(
      INIT => X"12"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(1),
      ADR1 => XLXI_10_I2_TD_c(0),
      ADR2 => XLXI_10_I2_TD_c(2),
      O => XLXI_10_I3_N8904
    );
  XLXI_10_I3_Ker90111 : X_LUT4
    generic map(
      INIT => X"FFA8"
    )
    port map (
      ADR0 => XLXI_10_I3_N8884,
      ADR1 => XLXI_10_I3_n0045,
      ADR2 => XLXI_10_I3_n0054,
      ADR3 => N25325,
      O => XLXI_10_I3_N9013
    );
  XLXI_10_I3_Ker90501 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(0),
      ADR1 => XLXI_10_I2_TD_c(1),
      ADR2 => XLXI_10_I3_N8884,
      ADR3 => XLXI_10_I2_TD_c(2),
      O => XLXI_10_I3_N9052
    );
  XLXI_10_I3_n00551 : X_LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(2),
      ADR1 => XLXI_10_I2_TD_c(0),
      ADR2 => XLXI_10_I2_TD_c(1),
      O => XLXI_10_I3_n0055
    );
  XLXI_10_I3_n00541 : X_LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(2),
      ADR1 => XLXI_10_I2_TD_c(0),
      ADR2 => XLXI_10_I2_TD_c(1),
      O => XLXI_10_I3_n0054
    );
  XLXI_10_I3_n00531 : X_LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(0),
      ADR1 => XLXI_10_I2_TD_c(2),
      ADR2 => XLXI_10_I2_TD_c(1),
      O => XLXI_10_I3_n0053
    );
  XLXI_10_I3_n00521 : X_LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(0),
      ADR1 => XLXI_10_I2_TC_c(1),
      O => XLXI_10_I3_n0052
    );
  XLXI_10_I3_Msub_n0059_inst_cy_38_106 : X_MUX2
    port map (
      IB => XLXI_10_I3_Msub_n0059_inst_cy_37,
      IA => XLXI_10_I3_acc_c_0_2,
      SEL => XLXI_10_I3_Msub_n0059_inst_lut2_38,
      O => XLXI_10_I3_Msub_n0059_inst_cy_38
    );
  XLXI_10_I3_Msub_n0059_inst_sum_21 : X_XOR2
    port map (
      I0 => XLXI_10_I3_Msub_n0059_inst_lut2_37,
      I1 => XLXI_10_I3_Msub_n0059_inst_cy_36,
      O => XLXI_10_I3_n0059(1)
    );
  XLXI_10_I3_n00481 : X_LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(0),
      ADR1 => XLXI_10_I2_TD_c(1),
      ADR2 => XLXI_10_I2_TD_c(2),
      O => XLXI_10_I3_n0048
    );
  XLXI_10_I3_Msub_n0059_inst_lut2_371 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => N25384,
      ADR1 => N24669,
      ADR2 => CHOICE2070,
      ADR3 => N24667,
      O => XLXI_10_I3_Msub_n0059_inst_lut2_37
    );
  XLXI_10_I3_n00451 : X_LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(2),
      ADR1 => XLXI_10_I2_TD_c(1),
      ADR2 => XLXI_10_I2_TD_c(0),
      O => XLXI_10_I3_n0045
    );
  XLXI_10_I3_skip_l99 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => CHOICE2162,
      ADR1 => CHOICE2155,
      ADR2 => CHOICE2148,
      ADR3 => XLXI_10_I2_TD_c(0),
      O => XLXI_10_skip
    );
  XLXI_10_I3_acc_c_0_3_107 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I3_n0035(3),
      CE => XLXI_10_I3_n0073,
      RST => XLXI_10_I3_acc_c_0_3_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I3_acc_c_0_3,
      SET => GND
    );
  XLXI_10_I3_n00371 : X_LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(2),
      ADR1 => XLXI_10_I2_TC_c(0),
      ADR2 => XLXI_10_I2_TC_c(1),
      O => XLXI_10_I3_n0037
    );
  XLXI_10_I3_n0036_0_1 : X_LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      ADR0 => XLXI_10_I3_nreset_v(1),
      ADR1 => XLXI_10_I3_nreset_v(0),
      O => XLXI_10_I3_n0036(0)
    );
  CPU_DADDR_5_OBUF_108 : X_BUF
    port map (
      I => CPU_DADDR_5_OBUF,
      O => CPU_DADDR_5_OBUF_GTS_TRI
    );
  CPU_IADDR_1_OBUF_109 : X_BUF
    port map (
      I => CPU_IADDR_1_OBUF,
      O => CPU_IADDR_1_OBUF_GTS_TRI
    );
  XLXI_10_I3_Ker88821 : X_LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(0),
      ADR1 => XLXI_10_I2_TC_c(1),
      O => XLXI_10_I3_N8884
    );
  XLXI_10_I3_nreset_v_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I3_n0036(0),
      RST => XLXI_10_I3_nreset_v_0_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I3_nreset_v(0),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I3_Msub_n0059_inst_cy_39_110 : X_MUX2
    port map (
      IB => XLXI_10_I3_Msub_n0059_inst_cy_38,
      IA => XLXI_10_I3_acc_c_0_3,
      SEL => XLXI_10_I3_Msub_n0059_inst_lut2_39,
      O => XLXI_10_I3_Msub_n0059_inst_cy_39
    );
  XLXI_10_I3_Msub_n0059_inst_sum_20 : X_XOR2
    port map (
      I0 => XLXI_10_I3_Msub_n0059_inst_lut2_36,
      I1 => N19080_rt,
      O => XLXI_10_I3_n0059(0)
    );
  XLXI_10_I3_n0035_2_0 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_I3_n0062,
      ADR1 => XLXI_10_I3_acc_c_0_2,
      O => CHOICE2076
    );
  XLXI_10_I3_Madd_n0064_inst_sum_19 : X_XOR2
    port map (
      I0 => XLXI_10_I3_Madd_n0064_inst_lut2_35,
      I1 => XLXI_10_I3_Madd_n0064_inst_cy_34,
      O => XLXI_10_I3_n0064(3)
    );
  XLXI_10_I3_Madd_n0064_inst_lut2_321 : X_LUT4
    generic map(
      INIT => X"3237"
    )
    port map (
      ADR0 => CHOICE2128,
      ADR1 => N24745,
      ADR2 => N25382,
      ADR3 => N24743,
      O => XLXI_10_I3_Madd_n0064_inst_lut2_32
    );
  XLXI_10_I3_Madd_n0064_inst_cy_32_111 : X_MUX2
    port map (
      IB => N19427,
      IA => XLXI_10_I3_acc_c_0_0,
      SEL => XLXI_10_I3_Madd_n0064_inst_lut2_32,
      O => XLXI_10_I3_Madd_n0064_inst_cy_32
    );
  CPU_DADDR_1_OBUF_112 : X_BUF
    port map (
      I => CPU_DADDR_1_OBUF,
      O => CPU_DADDR_1_OBUF_GTS_TRI
    );
  XLXI_10_I3_Madd_n0064_inst_lut2_331 : X_LUT4
    generic map(
      INIT => X"3237"
    )
    port map (
      ADR0 => CHOICE2067,
      ADR1 => N24675,
      ADR2 => N25400,
      ADR3 => N24667,
      O => XLXI_10_I3_Madd_n0064_inst_lut2_33
    );
  XLXI_10_I3_Madd_n0064_inst_cy_33_113 : X_MUX2
    port map (
      IB => XLXI_10_I3_Madd_n0064_inst_cy_32,
      IA => XLXI_10_I3_acc_c_0_1,
      SEL => XLXI_10_I3_Madd_n0064_inst_lut2_33,
      O => XLXI_10_I3_Madd_n0064_inst_cy_33
    );
  XLXI_10_I3_Madd_n0064_inst_sum_17 : X_XOR2
    port map (
      I0 => XLXI_10_I3_Madd_n0064_inst_lut2_33,
      I1 => XLXI_10_I3_Madd_n0064_inst_cy_32,
      O => XLXI_10_I3_n0064(1)
    );
  XLXI_10_I3_Madd_n0064_inst_lut2_341 : X_LUT4
    generic map(
      INIT => X"087F"
    )
    port map (
      ADR0 => XLXI_10_I4_N9697,
      ADR1 => N23412,
      ADR2 => N24751,
      ADR3 => N24749,
      O => XLXI_10_I3_Madd_n0064_inst_lut2_34
    );
  XLXI_10_I3_Madd_n0064_inst_cy_34_114 : X_MUX2
    port map (
      IB => XLXI_10_I3_Madd_n0064_inst_cy_33,
      IA => XLXI_10_I3_acc_c_0_2,
      SEL => XLXI_10_I3_Madd_n0064_inst_lut2_34,
      O => XLXI_10_I3_Madd_n0064_inst_cy_34
    );
  XLXI_10_I3_Madd_n0064_inst_sum_18 : X_XOR2
    port map (
      I0 => XLXI_10_I3_Madd_n0064_inst_lut2_34,
      I1 => XLXI_10_I3_Madd_n0064_inst_cy_33,
      O => XLXI_10_I3_n0064(2)
    );
  XLXI_10_I3_Madd_n0064_inst_lut2_351 : X_LUT4
    generic map(
      INIT => X"087F"
    )
    port map (
      ADR0 => XLXI_10_I4_N9697,
      ADR1 => N23016,
      ADR2 => N24843,
      ADR3 => N24841,
      O => XLXI_10_I3_Madd_n0064_inst_lut2_35
    );
  XLXI_10_I3_Msub_n0059_inst_lut2_391 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N24757,
      ADR1 => XLXI_10_I4_N9697,
      ADR2 => N24755,
      ADR3 => N23016,
      O => XLXI_10_I3_Msub_n0059_inst_lut2_39
    );
  XLXI_10_I3_Msub_n0059_inst_sum_24 : X_XOR2
    port map (
      I0 => N19080_rt,
      I1 => XLXI_10_I3_Msub_n0059_inst_cy_39,
      O => XLXI_10_I3_n0059(4)
    );
  XLXI_10_I4_data_ox_2_1 : X_LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_2,
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      O => CPU_DATA_OUT_2_OBUF
    );
  XLXI_10_I4_data_ox_1_1 : X_LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_1,
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      O => CPU_DATA_OUT_1_OBUF
    );
  XLXI_10_I4_data_ox_0_1 : X_LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      O => CPU_DATA_OUT_0_OBUF
    );
  XLXI_10_I4_daddr_x_2_1 : X_LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      ADR0 => XLXN_8(6),
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      O => XLXI_10_adaddr_out(2)
    );
  XLXI_10_I4_n00441 : X_LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      ADR0 => XLXI_10_I4_ipage_we_c,
      ADR1 => XLXI_10_I4_nreset_v(1),
      O => XLXI_10_I4_n0044
    );
  XLXI_10_I4_ipage_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I4_n0030(0),
      CE => XLXI_10_I4_n0044,
      RST => XLXI_10_I4_ipage_c_0_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I4_ipage_c(0),
      SET => GND
    );
  XLXI_10_I4_ipage_we_x1 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_10_ndre_int,
      ADR1 => XLXI_10_ndwe_int,
      ADR2 => XLXI_10_I4_N9712,
      ADR3 => XLXI_10_I4_N9730,
      O => XLXI_10_I4_ipage_we_x
    );
  CPU_IADDR_2_OBUF_115 : X_BUF
    port map (
      I => CPU_IADDR_2_OBUF,
      O => CPU_IADDR_2_OBUF_GTS_TRI
    );
  XLXI_10_I4_ndwe_x1 : X_LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      ADR0 => XLXI_10_I4_N9712,
      ADR1 => XLXI_10_ndwe_int,
      ADR2 => NRESET_IBUF,
      ADR3 => XLXI_10_I4_nreset_v(1),
      O => XLXI_10_nadwe_out
    );
  XLXI_10_I4_n0031_0_1 : X_LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      ADR0 => XLXI_10_I4_nreset_v(1),
      ADR1 => XLXI_10_I4_nreset_v(0),
      O => XLXI_10_I4_n0031(0)
    );
  XLXI_10_I4_nreset_v_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => N19080_rt,
      CE => XLXI_10_I4_nreset_v(0),
      RST => XLXI_10_I4_nreset_v_1_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I4_nreset_v(1),
      SET => GND
    );
  XLXI_10_I4_ipage_we_c_116 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I4_ipage_we_x,
      RST => XLXI_10_I4_ipage_we_c_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I4_ipage_we_c,
      CE => VCC,
      SET => GND
    );
  XLXI_10_I4_ipage_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I4_n0030(1),
      CE => XLXI_10_I4_n0044,
      RST => XLXI_10_I4_ipage_c_1_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I4_ipage_c(1),
      SET => GND
    );
  XLXI_10_I4_ndre_x1 : X_LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      ADR0 => XLXI_10_I4_N9712,
      ADR1 => XLXI_10_ndre_int,
      ADR2 => NRESET_IBUF,
      ADR3 => XLXI_10_I4_nreset_v(1),
      O => nRE_CPU_OBUF
    );
  XLXI_10_I4_daddr_x_3_1 : X_LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      ADR0 => XLXN_8(7),
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      O => XLXI_10_adaddr_out(3)
    );
  XLXI_10_I4_daddr_x_5_1 : X_LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      ADR0 => XLXN_8(9),
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      O => XLXI_10_adaddr_out(5)
    );
  XLXI_10_I2_TC_x_2_SW1 : X_LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      ADR0 => XLXN_8(1),
      ADR1 => XLXN_8(2),
      ADR2 => NRESET_IBUF,
      O => N25098
    );
  XLXI_10_I4_nreset_v_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I4_n0031(0),
      RST => XLXI_10_I4_nreset_v_0_GSR_OR,
      CLK => CLK_BUFGP,
      O => XLXI_10_I4_nreset_v(0),
      CE => VCC,
      SET => GND
    );
  XLXI_10_I4_daddr_x_1_1 : X_LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      ADR0 => XLXN_8(5),
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      O => XLXI_10_adaddr_out(1)
    );
  XLXI_10_I4_daddr_x_0_1 : X_LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      ADR0 => XLXN_8(4),
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      O => XLXI_10_adaddr_out(0)
    );
  CTRL_DATA_OUT_0_OBUF : X_BUF
    port map (
      I => XLXI_2_ctrl_data_c(0),
      O => CTRL_DATA_OUT_0_OBUF_GTS_TRI
    );
  XLXI_10_I2_ndre_x_SW4 : X_LUT4
    generic map(
      INIT => X"FFF1"
    )
    port map (
      ADR0 => XLXN_8(1),
      ADR1 => XLXN_8(2),
      ADR2 => XLXN_8(6),
      ADR3 => XLXN_8(3),
      O => N24851
    );
  XLXI_10_I2_TC_x_2_Q : X_LUT4
    generic map(
      INIT => X"00AE"
    )
    port map (
      ADR0 => XLXN_8(3),
      ADR1 => XLXI_10_I2_N8336,
      ADR2 => XLXN_8(0),
      ADR3 => N25098,
      O => XLXI_10_I2_TC_x(2)
    );
  XLXI_10_I3_Mmux_data_x_Result_0_0 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(2),
      ADR1 => XLXI_10_I2_TC_c(0),
      ADR2 => XLXI_10_I2_TC_c(1),
      ADR3 => XLXI_10_I2_data_is_c(0),
      O => CHOICE2123
    );
  XLXI_2_n0046_117 : X_LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => N21493,
      ADR2 => CPU_DADDR_4_OBUF,
      ADR3 => CPU_DADDR_0_OBUF,
      O => XLXI_2_n0046
    );
  XLXI_3_Ker69031_SW5_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => XLXI_3_pwm_low(4),
      ADR2 => XLXI_3_pwm_period(4),
      O => N25208
    );
  XLXI_2_n0020_118 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => CPU_DADDR_2_OBUF,
      ADR1 => CPU_DADDR_1_OBUF,
      ADR2 => CPU_DADDR_0_OBUF,
      ADR3 => N21388,
      O => XLXI_2_n0020
    );
  XLXI_3_n000715 : X_LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      ADR0 => CHOICE1444,
      ADR1 => NRESET_IBUF,
      O => XLXI_3_n0007
    );
  XLXI_10_I2_TC_x_0_SW0 : X_LUT4
    generic map(
      INIT => X"AAAE"
    )
    port map (
      ADR0 => XLXN_8(0),
      ADR1 => XLXI_10_I2_N8336,
      ADR2 => XLXN_8(4),
      ADR3 => XLXN_8(3),
      O => N20151
    );
  XLXI_10_I2_TC_x_0_Q : X_LUT4
    generic map(
      INIT => X"4C08"
    )
    port map (
      ADR0 => XLXI_10_I2_N8283,
      ADR1 => NRESET_IBUF,
      ADR2 => XLXN_8(3),
      ADR3 => N20151,
      O => XLXI_10_I2_TC_x(0)
    );
  XLXI_10_I3_Ker90622 : X_LUT3
    generic map(
      INIT => X"F8"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(0),
      ADR1 => XLXI_10_I2_TC_c(1),
      ADR2 => XLXI_10_I2_TD_c(3),
      O => CHOICE1448
    );
  XLXI_10_I1_n0012_7_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => N25416,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_7,
      ADR2 => XLXI_10_I1_n0013(7),
      O => N25006
    );
  XLXI_10_I2_TD_x_3_SW0 : X_LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      ADR0 => XLXN_8(3),
      ADR1 => XLXN_8(2),
      ADR2 => XLXN_8(0),
      ADR3 => NRESET_IBUF,
      O => N21781
    );
  XLXI_10_I2_TD_x_3_Q : X_LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      ADR0 => XLXN_8(7),
      ADR1 => XLXN_8(1),
      ADR2 => XLXN_8(6),
      ADR3 => N21781,
      O => XLXI_10_I2_TD_x(3)
    );
  XLXI_10_I2_TD_x_1_52 : X_LUT4
    generic map(
      INIT => X"062A"
    )
    port map (
      ADR0 => XLXN_8(5),
      ADR1 => XLXN_8(6),
      ADR2 => XLXN_8(7),
      ADR3 => XLXN_8(4),
      O => CHOICE1786
    );
  XLXI_10_I1_iaddr_x_5_14 : X_LUT4
    generic map(
      INIT => X"F404"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => XLXI_10_I1_pc(5),
      ADR2 => XLXI_10_pc_mux(1),
      ADR3 => XLXN_8(9),
      O => CHOICE1879
    );
  XLXI_10_I1_iaddr_x_3_31_SW0 : X_LUT4
    generic map(
      INIT => X"9180"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(1),
      ADR1 => N25374,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_3,
      ADR3 => XLXI_10_I1_n0013(3),
      O => N25140
    );
  XLXI_10_I2_TD_x_0_22 : X_LUT3
    generic map(
      INIT => X"17"
    )
    port map (
      ADR0 => XLXN_8(5),
      ADR1 => XLXN_8(6),
      ADR2 => XLXN_8(7),
      O => CHOICE1759
    );
  XLXI_10_I1_iaddr_x_4_31_SW0 : X_LUT4
    generic map(
      INIT => X"9180"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(1),
      ADR1 => XLXI_10_pc_mux(2),
      ADR2 => XLXI_10_I1_stack_addrs_c_0_4,
      ADR3 => XLXI_10_I1_n0013(4),
      O => N25144
    );
  XLXI_10_I1_iaddr_x_2_14 : X_LUT4
    generic map(
      INIT => X"F404"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => XLXI_10_I1_pc(2),
      ADR2 => XLXI_10_pc_mux(1),
      ADR3 => XLXN_8(6),
      O => CHOICE1834
    );
  XLXI_10_I3_Mmux_data_x_Result_3_SW3 : X_LUT3
    generic map(
      INIT => X"95"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_3,
      ADR1 => XLXI_10_I3_n0037,
      ADR2 => XLXI_10_I2_data_is_c(3),
      O => N24841
    );
  XLXI_10_I1_iaddr_x_2_31_SW0 : X_LUT4
    generic map(
      INIT => X"9180"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(1),
      ADR1 => XLXI_10_pc_mux(2),
      ADR2 => XLXI_10_I1_stack_addrs_c_0_2,
      ADR3 => XLXI_10_I1_n0013(2),
      O => N25136
    );
  XLXI_10_I2_ndre_x_SW3 : X_LUT4
    generic map(
      INIT => X"FFF1"
    )
    port map (
      ADR0 => XLXN_8(1),
      ADR1 => XLXN_8(2),
      ADR2 => XLXN_8(6),
      ADR3 => XLXN_8(3),
      O => N24847
    );
  XLXI_10_I2_TD_x_0_2 : X_LUT3
    generic map(
      INIT => X"A8"
    )
    port map (
      ADR0 => XLXN_8(0),
      ADR1 => XLXN_8(1),
      ADR2 => XLXN_8(2),
      O => CHOICE1750
    );
  XLXI_10_I1_iaddr_x_7_31_SW0 : X_LUT4
    generic map(
      INIT => X"9180"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(1),
      ADR1 => XLXI_10_pc_mux(2),
      ADR2 => XLXI_10_I1_stack_addrs_c_0_7,
      ADR3 => XLXI_10_I1_n0013(7),
      O => N25156
    );
  XLXI_10_I2_TD_x_0_26 : X_LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      ADR0 => XLXN_8(1),
      ADR1 => XLXN_8(3),
      O => CHOICE1762
    );
  XLXI_10_I1_iaddr_x_3_14 : X_LUT4
    generic map(
      INIT => X"F404"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => XLXI_10_I1_pc(3),
      ADR2 => XLXI_10_pc_mux(1),
      ADR3 => XLXN_8(7),
      O => CHOICE1909
    );
  XLXI_10_I4_ndre_x1_SW3 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXN_8(6),
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => XLXI_10_I5_daddr_c(2),
      ADR3 => NRESET_IBUF,
      O => N24649
    );
  XLXI_10_I3_Mmux_data_x_Result_3_SW4 : X_LUT3
    generic map(
      INIT => X"C6"
    )
    port map (
      ADR0 => XLXI_10_I3_n0037,
      ADR1 => XLXI_10_I3_acc_c_0_3,
      ADR2 => XLXI_10_I2_data_is_c(3),
      O => N24843
    );
  XLXI_10_I1_iaddr_x_1_14 : X_LUT4
    generic map(
      INIT => X"F404"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => XLXI_10_I1_pc(1),
      ADR2 => XLXI_10_pc_mux(1),
      ADR3 => XLXN_8(5),
      O => CHOICE1819
    );
  XLXI_10_I1_iaddr_x_6_14 : X_LUT4
    generic map(
      INIT => X"F404"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => XLXI_10_I1_pc(6),
      ADR2 => XLXI_10_pc_mux(1),
      ADR3 => XLXI_10_I4_ipage_c(0),
      O => CHOICE1849
    );
  XLXI_10_I2_TD_x_2_29 : X_LUT4
    generic map(
      INIT => X"0870"
    )
    port map (
      ADR0 => XLXN_8(4),
      ADR1 => XLXN_8(5),
      ADR2 => XLXN_8(6),
      ADR3 => XLXN_8(7),
      O => CHOICE1740
    );
  XLXI_10_I1_iaddr_x_1_31_SW0 : X_LUT4
    generic map(
      INIT => X"9180"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(1),
      ADR1 => XLXI_10_pc_mux(2),
      ADR2 => XLXI_10_I1_stack_addrs_c_0_1,
      ADR3 => XLXI_10_I1_n0013(1),
      O => N25132
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
      O => N25148
    );
  XLXI_10_I1_iaddr_x_4_14 : X_LUT4
    generic map(
      INIT => X"F404"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => XLXI_10_I1_pc(4),
      ADR2 => XLXI_10_pc_mux(1),
      ADR3 => XLXN_8(8),
      O => CHOICE1894
    );
  XLXI_10_I1_iaddr_x_6_31_SW0 : X_LUT4
    generic map(
      INIT => X"9180"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(1),
      ADR1 => XLXI_10_pc_mux(2),
      ADR2 => XLXI_10_I1_stack_addrs_c_0_6,
      ADR3 => XLXI_10_I1_n0013(6),
      O => N25152
    );
  XLXI_10_I2_pc_mux_x_2_SW0 : X_LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      ADR0 => XLXN_8(3),
      ADR1 => XLXN_8(4),
      ADR2 => XLXN_8(0),
      ADR3 => NRESET_IBUF,
      O => N22203
    );
  XLXI_10_I2_pc_mux_x_1_SW0 : X_LUT4
    generic map(
      INIT => X"AAAE"
    )
    port map (
      ADR0 => XLXN_8(3),
      ADR1 => N25314,
      ADR2 => XLXN_8(4),
      ADR3 => XLXN_8(0),
      O => N22263
    );
  XLXI_10_I2_TD_x_1_61 : X_LUT3
    generic map(
      INIT => X"01"
    )
    port map (
      ADR0 => XLXN_8(2),
      ADR1 => XLXN_8(0),
      ADR2 => XLXN_8(3),
      O => CHOICE1791
    );
  XLXI_10_I3_n0035_0_179 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_10_I3_N9064,
      ADR1 => XLXI_10_I3_acc_c_0_0,
      ADR2 => CHOICE1982,
      ADR3 => N24977,
      O => CHOICE1984
    );
  XLXI_10_I3_n0035_1_6 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_1,
      ADR1 => XLXI_10_I3_N9013,
      ADR2 => N25335,
      ADR3 => XLXI_10_I3_N9052,
      O => CHOICE2035
    );
  XLXI_3_Ker69031_SW6_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => XLXI_3_pwm_low(3),
      ADR2 => XLXI_3_pwm_period(3),
      O => N25204
    );
  XLXI_10_I3_n0035_3_7 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(2),
      ADR1 => XLXI_10_I2_TD_c(0),
      ADR2 => XLXI_10_I2_TD_c(1),
      ADR3 => XLXI_10_I3_n0059(3),
      O => CHOICE2168
    );
  XLXI_10_I3_n0035_2_7 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(2),
      ADR1 => XLXI_10_I2_TD_c(0),
      ADR2 => XLXI_10_I2_TD_c(1),
      ADR3 => XLXI_10_I3_n0059(2),
      O => CHOICE2080
    );
  XLXI_3_Ker69031_SW7_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => XLXI_3_pwm_low(2),
      ADR2 => XLXI_3_pwm_period(2),
      O => N25200
    );
  XLXI_10_I3_n0035_4_37 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(0),
      ADR1 => XLXI_10_I2_TC_c(1),
      ADR2 => XLXI_10_I2_TD_c(2),
      ADR3 => N25117,
      O => CHOICE2025
    );
  XLXI_10_I3_skip_l61 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(1),
      ADR1 => XLXI_10_I2_TD_c(2),
      ADR2 => XLXI_10_I3_acc_c_0_4,
      ADR3 => XLXI_10_I2_TD_c(0),
      O => CHOICE2155
    );
  XLXI_10_I3_n0035_2_6 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_2,
      ADR1 => XLXI_10_I3_N9013,
      ADR2 => N25392,
      ADR3 => XLXI_10_I3_N9052,
      O => CHOICE2079
    );
  XLXI_3_Ker69031_SW8_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => XLXI_3_pwm_low(1),
      ADR2 => XLXI_3_pwm_period(1),
      O => N25196
    );
  XLXI_10_I3_n0035_0_0 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => XLXI_10_I3_n0062,
      O => CHOICE1944
    );
  XLXI_2_nCS_PWM_SW0 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => XLXI_10_I4_N9712,
      ADR1 => N24767,
      ADR2 => XLXI_10_ndre_int,
      ADR3 => N24765,
      O => N23342
    );
  XLXI_10_I3_n0035_0_41_SW0 : X_LUT3
    generic map(
      INIT => X"28"
    )
    port map (
      ADR0 => XLXI_10_I3_n0048,
      ADR1 => XLXI_10_I3_data_x(0),
      ADR2 => XLXI_10_I3_acc_c_0_0,
      O => N24629
    );
  XLXI_10_I1_iaddr_x_0_14 : X_LUT4
    generic map(
      INIT => X"F404"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => XLXI_10_I1_pc(0),
      ADR2 => XLXI_10_pc_mux(1),
      ADR3 => XLXN_8(4),
      O => CHOICE1924
    );
  XLXI_10_I3_n0035_3_86 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => XLXI_10_I3_n0052,
      ADR1 => N24981,
      ADR2 => XLXI_10_I3_N8904,
      ADR3 => XLXI_10_I3_acc_c_0_4,
      O => CHOICE2187
    );
  XLXI_10_I3_n0035_1_33 : X_LUT4
    generic map(
      INIT => X"D8A8"
    )
    port map (
      ADR0 => XLXI_10_I3_data_x(1),
      ADR1 => XLXI_10_I3_N8915,
      ADR2 => XLXI_10_I3_n0053,
      ADR3 => XLXI_10_I3_acc_c_0_1,
      O => CHOICE2044
    );
  XLXI_10_I3_n0035_1_0 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_I3_n0062,
      ADR1 => XLXI_10_I3_acc_c_0_1,
      O => CHOICE2032
    );
  XLXI_10_I3_Mmux_data_x_Result_2_SW0 : X_LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      ADR0 => N25337,
      ADR1 => XLXI_2_mux_c(0),
      ADR2 => CTRL_DATA_IN_2_IBUF,
      ADR3 => RAM_DATA_OUT(2),
      O => N23412
    );
  XLXI_10_I3_n0035_1_109_SW0 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I3_N9047,
      ADR1 => CHOICE2035,
      ADR2 => CHOICE2055,
      ADR3 => XLXI_10_I2_TD_c(3),
      O => N24709
    );
  XLXI_10_I3_n0035_3_6 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_3,
      ADR1 => XLXI_10_I3_N9013,
      ADR2 => N25398,
      ADR3 => XLXI_10_I3_N9052,
      O => CHOICE2167
    );
  XLXI_10_I3_n0035_4_0 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_I3_n0062,
      ADR1 => XLXI_10_I3_acc_c_0_4,
      O => CHOICE2010
    );
  XLXI_10_I3_n0035_0_179_SW0_G : X_LUT4
    generic map(
      INIT => X"02C2"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_1,
      ADR1 => XLXI_10_I2_TD_c(0),
      ADR2 => XLXI_10_I2_TD_c(1),
      ADR3 => XLXI_10_I3_acc_c_0_0,
      O => N25248
    );
  XLXI_10_I3_n0035_1_86 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => XLXI_10_I3_n0052,
      ADR1 => N24989,
      ADR2 => XLXI_10_I3_N8934,
      ADR3 => XLXI_10_I3_acc_c_0_0,
      O => CHOICE2055
    );
  XLXI_3_Ker69031_SW3_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => XLXI_3_pwm_low(6),
      ADR2 => XLXI_3_pwm_period(6),
      O => N25192
    );
  XLXI_10_I3_n0035_3_109_SW11_G : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_10_I2_valid_c,
      ADR1 => XLXI_10_I2_TC_c(2),
      ADR2 => XLXI_10_I3_nreset_v(1),
      ADR3 => XLXI_10_I3_nreset_v(0),
      O => N25243
    );
  XLXI_10_I3_n0035_2_33 : X_LUT4
    generic map(
      INIT => X"D8A8"
    )
    port map (
      ADR0 => XLXI_10_I3_data_x(2),
      ADR1 => XLXI_10_I3_N8915,
      ADR2 => XLXI_10_I3_n0053,
      ADR3 => XLXI_10_I3_acc_c_0_2,
      O => CHOICE2088
    );
  XLXI_10_I1_iaddr_x_0_31_SW0 : X_LUT4
    generic map(
      INIT => X"8091"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(1),
      ADR1 => XLXI_10_pc_mux(2),
      ADR2 => XLXI_10_I1_stack_addrs_c_0_0,
      ADR3 => XLXI_10_I1_pc(0),
      O => N25128
    );
  XLXI_10_I3_n0035_0_81 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => XLXI_10_I2_TD_c(0),
      O => CHOICE1965
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
      O => N25238
    );
  XLXI_10_I3_n0035_3_0 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_I3_n0062,
      ADR1 => XLXI_10_I3_acc_c_0_3,
      O => CHOICE2164
    );
  XLXI_10_I3_n0035_2_86_SW0 : X_LUT4
    generic map(
      INIT => X"F444"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_2,
      ADR1 => XLXI_10_I3_n0054,
      ADR2 => XLXI_10_I3_N8904,
      ADR3 => XLXI_10_I3_acc_c_0_3,
      O => N24985
    );
  XLXI_10_I3_n0035_3_86_SW0 : X_LUT4
    generic map(
      INIT => X"F444"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_3,
      ADR1 => XLXI_10_I3_n0054,
      ADR2 => XLXI_10_I3_N8934,
      ADR3 => XLXI_10_I3_acc_c_0_2,
      O => N24981
    );
  XLXI_10_I4_Ker9695 : X_LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      ADR0 => N24657,
      ADR1 => N24038,
      ADR2 => N25319,
      ADR3 => XLXI_10_I2_N8283,
      O => XLXI_10_I4_N9697
    );
  XLXI_10_I3_skip_l36 : X_LUT4
    generic map(
      INIT => X"0656"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(1),
      ADR1 => XLXI_10_I3_n0044,
      ADR2 => XLXI_10_I2_TD_c(2),
      ADR3 => XLXI_10_I3_acc_c_0_4,
      O => CHOICE2148
    );
  XLXI_10_I3_n0035_0_88 : X_LUT4
    generic map(
      INIT => X"B900"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(2),
      ADR1 => XLXI_10_I2_TD_c(1),
      ADR2 => N25333,
      ADR3 => CHOICE1965,
      O => CHOICE1966
    );
  XLXI_10_I3_n0035_4_6 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_4,
      ADR1 => XLXI_10_I3_N9064,
      ADR2 => XLXI_10_I3_n0045,
      ADR3 => XLXI_10_I3_N8884,
      O => CHOICE2013
    );
  XLXI_10_I4_Ker9695_SW0 : X_LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      ADR0 => XLXN_8(6),
      ADR1 => XLXN_8(7),
      ADR2 => XLXN_8(4),
      ADR3 => XLXN_8(5),
      O => N24038
    );
  XLXI_10_I3_n0035_3_47_SW0_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => CHOICE2176,
      ADR1 => N24699,
      ADR2 => N24697,
      O => N25184
    );
  XLXI_10_I3_n0035_2_86 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => XLXI_10_I3_n0052,
      ADR1 => N24985,
      ADR2 => XLXI_10_I3_N8934,
      ADR3 => XLXI_10_I3_acc_c_0_1,
      O => CHOICE2099
    );
  XLXI_10_I3_Mmux_data_x_Result_3_SW0 : X_LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      ADR0 => XLXI_10_I4_N9730,
      ADR1 => XLXI_2_mux_c(0),
      ADR2 => CTRL_DATA_IN_3_IBUF,
      ADR3 => RAM_DATA_OUT(3),
      O => N23016
    );
  XLXI_10_I3_skip_l89 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(0),
      ADR1 => XLXI_10_I2_TC_c(1),
      ADR2 => XLXI_10_I2_TD_c(3),
      ADR3 => NRESET_IBUF,
      O => CHOICE2161
    );
  XLXI_10_I2_ndre_x : X_LUT4
    generic map(
      INIT => X"FFF1"
    )
    port map (
      ADR0 => XLXN_8(1),
      ADR1 => XLXN_8(2),
      ADR2 => N25413,
      ADR3 => XLXN_8(3),
      O => XLXI_10_ndre_int
    );
  XLXI_10_I3_Mmux_data_x_Result_1_0 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(2),
      ADR1 => XLXI_10_I2_TC_c(0),
      ADR2 => XLXI_10_I2_TC_c(1),
      ADR3 => XLXI_10_I2_data_is_c(1),
      O => CHOICE2062
    );
  XLXI_10_I3_n0035_1_109_SW11_G : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_10_I2_valid_c,
      ADR1 => XLXI_10_I2_TC_c(2),
      ADR2 => XLXI_10_I3_nreset_v(1),
      ADR3 => XLXI_10_I3_nreset_v(0),
      O => N25233
    );
  XLXI_10_I3_n0035_3_33 : X_LUT4
    generic map(
      INIT => X"D8A8"
    )
    port map (
      ADR0 => XLXI_10_I3_data_x(3),
      ADR1 => XLXI_10_I3_N8915,
      ADR2 => XLXI_10_I3_n0053,
      ADR3 => XLXI_10_I3_acc_c_0_3,
      O => CHOICE2176
    );
  XLXI_10_I3_n0035_4_37_SW0 : X_LUT4
    generic map(
      INIT => X"353F"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => XLXI_10_I3_acc_c_0_3,
      ADR2 => XLXI_10_I2_TD_c(0),
      ADR3 => XLXI_10_I2_TD_c(1),
      O => N25117
    );
  XLXI_10_I4_data_ox_3_1 : X_LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_3,
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      O => CPU_DATA_OUT_3_OBUF
    );
  XLXI_10_I3_Mmux_data_x_Result_1_30 : X_LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXI_10_I3_n0037,
      ADR2 => XLXI_10_I4_nreset_v(1),
      O => CHOICE2073
    );
  XLXI_10_I3_n0035_2_109_SW11_G : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_10_I2_valid_c,
      ADR1 => XLXI_10_I2_TC_c(2),
      ADR2 => XLXI_10_I3_nreset_v(1),
      ADR3 => XLXI_10_I3_nreset_v(0),
      O => N25228
    );
  NRESET_IBUF_119 : X_BUF
    port map (
      I => NRESET,
      O => NRESET_IBUF
    );
  CTRL_DATA_IN_3_IBUF_120 : X_BUF
    port map (
      I => CTRL_DATA_IN(3),
      O => CTRL_DATA_IN_3_IBUF
    );
  CTRL_DATA_IN_2_IBUF_121 : X_BUF
    port map (
      I => CTRL_DATA_IN(2),
      O => CTRL_DATA_IN_2_IBUF
    );
  CTRL_DATA_IN_1_IBUF_122 : X_BUF
    port map (
      I => CTRL_DATA_IN(1),
      O => CTRL_DATA_IN_1_IBUF
    );
  CTRL_DATA_IN_0_IBUF_123 : X_BUF
    port map (
      I => CTRL_DATA_IN(0),
      O => CTRL_DATA_IN_0_IBUF
    );
  PWM_OUT_OBUF : X_BUF
    port map (
      I => XLXI_3_pwm_c,
      O => PWM_OUT_OBUF_GTS_TRI
    );
  nWE_CPU_OBUF : X_BUF
    port map (
      I => XLXI_10_I5_ndwe_c,
      O => nWE_CPU_OBUF_GTS_TRI
    );
  nRE_CPU_OBUF_124 : X_BUF
    port map (
      I => nRE_CPU_OBUF,
      O => nRE_CPU_OBUF_GTS_TRI
    );
  CPU_DATA_OUT_3_OBUF_125 : X_BUF
    port map (
      I => CPU_DATA_OUT_3_OBUF,
      O => CPU_DATA_OUT_3_OBUF_GTS_TRI
    );
  CPU_DATA_OUT_2_OBUF_126 : X_BUF
    port map (
      I => CPU_DATA_OUT_2_OBUF,
      O => CPU_DATA_OUT_2_OBUF_GTS_TRI
    );
  CPU_DATA_OUT_1_OBUF_127 : X_BUF
    port map (
      I => CPU_DATA_OUT_1_OBUF,
      O => CPU_DATA_OUT_1_OBUF_GTS_TRI
    );
  CPU_DATA_OUT_0_OBUF_128 : X_BUF
    port map (
      I => CPU_DATA_OUT_0_OBUF,
      O => CPU_DATA_OUT_0_OBUF_GTS_TRI
    );
  CPU_IADDR_7_OBUF_129 : X_BUF
    port map (
      I => CPU_IADDR_7_OBUF,
      O => CPU_IADDR_7_OBUF_GTS_TRI
    );
  CPU_IADDR_6_OBUF_130 : X_BUF
    port map (
      I => CPU_IADDR_6_OBUF,
      O => CPU_IADDR_6_OBUF_GTS_TRI
    );
  CPU_IADDR_5_OBUF_131 : X_BUF
    port map (
      I => CPU_IADDR_5_OBUF,
      O => CPU_IADDR_5_OBUF_GTS_TRI
    );
  CPU_IADDR_4_OBUF_132 : X_BUF
    port map (
      I => CPU_IADDR_4_OBUF,
      O => CPU_IADDR_4_OBUF_GTS_TRI
    );
  CPU_IADDR_3_OBUF_133 : X_BUF
    port map (
      I => CPU_IADDR_3_OBUF,
      O => CPU_IADDR_3_OBUF_GTS_TRI
    );
  XLXI_3_pwm_count_5_rt_134 : X_LUT2
    generic map(
      INIT => X"A"
    )
    port map (
      ADR0 => XLXI_3_pwm_count(5),
      O => XLXI_3_pwm_count_5_rt,
      ADR1 => GND
    );
  XLXI_3_pwm_count_1_rt_135 : X_LUT2
    generic map(
      INIT => X"A"
    )
    port map (
      ADR0 => XLXI_3_pwm_count(1),
      O => XLXI_3_pwm_count_1_rt,
      ADR1 => GND
    );
  XLXI_3_pwm_count_2_rt_136 : X_LUT2
    generic map(
      INIT => X"A"
    )
    port map (
      ADR0 => XLXI_3_pwm_count(2),
      O => XLXI_3_pwm_count_2_rt,
      ADR1 => GND
    );
  XLXI_3_pwm_count_3_rt_137 : X_LUT2
    generic map(
      INIT => X"A"
    )
    port map (
      ADR0 => XLXI_3_pwm_count(3),
      O => XLXI_3_pwm_count_3_rt,
      ADR1 => GND
    );
  XLXI_3_pwm_count_4_rt_138 : X_LUT2
    generic map(
      INIT => X"A"
    )
    port map (
      ADR0 => XLXI_3_pwm_count(4),
      O => XLXI_3_pwm_count_4_rt,
      ADR1 => GND
    );
  XLXI_3_pwm_count_6_rt_139 : X_LUT2
    generic map(
      INIT => X"A"
    )
    port map (
      ADR0 => XLXI_3_pwm_count(6),
      O => XLXI_3_pwm_count_6_rt,
      ADR1 => GND
    );
  XLXI_10_I1_pc_3_rt_140 : X_LUT2
    generic map(
      INIT => X"A"
    )
    port map (
      ADR0 => XLXI_10_I1_pc(3),
      O => XLXI_10_I1_pc_3_rt,
      ADR1 => GND
    );
  XLXI_3_Msub_n0005_inst_lut2_221 : X_LUT4
    generic map(
      INIT => X"93C6"
    )
    port map (
      ADR0 => N24633,
      ADR1 => XLXI_2_pwm_data_c(2),
      ADR2 => XLXI_3_pwm_low(6),
      ADR3 => N24799,
      O => XLXI_3_Msub_n0005_inst_lut2_22
    );
  XLXI_2_nCS_PWM_SW1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => XLXI_10_I4_N9712,
      ADR1 => N24773,
      ADR2 => XLXI_10_ndre_int,
      ADR3 => N24771,
      O => N24633
    );
  XLXI_10_I3_n0035_0_107_SW11_G : X_LUT4
    generic map(
      INIT => X"8AA8"
    )
    port map (
      ADR0 => XLXI_10_I3_N9047,
      ADR1 => CHOICE1984,
      ADR2 => XLXI_10_I2_TC_c(0),
      ADR3 => XLXI_10_I2_TC_c(1),
      O => N25223
    );
  XLXI_10_I3_n0035_2_47_SW0_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => CHOICE2088,
      ADR1 => N24705,
      ADR2 => N24703,
      O => N25174
    );
  XLXI_10_I3_n0035_4_11_SW1_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I3_n0055,
      ADR1 => N24687,
      ADR2 => N24685,
      O => N25170
    );
  XLXI_10_I2_ndre_x_SW1 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => XLXN_8(3),
      ADR1 => XLXN_8(8),
      ADR2 => XLXN_8(9),
      ADR3 => N25402,
      O => N24657
    );
  XLXI_3_n00031 : X_LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      ADR0 => N25255,
      ADR1 => N24633,
      ADR2 => N23342,
      ADR3 => CPU_DADDR_3_OBUF,
      O => XLXI_3_n0003
    );
  XLXI_10_I4_ndre_x1_SW2 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXN_8(5),
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => XLXI_10_I5_daddr_c(1),
      ADR3 => NRESET_IBUF,
      O => N24645
    );
  XLXI_10_I3_Mmux_data_x_Result_0_30 : X_LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXI_10_I3_n0037,
      ADR2 => XLXI_10_I4_nreset_v(1),
      O => CHOICE2134
    );
  XLXI_10_I3_Mmux_data_x_Result_1_45_SW3 : X_LUT4
    generic map(
      INIT => X"D827"
    )
    port map (
      ADR0 => XLXI_10_I3_n0037,
      ADR1 => XLXI_10_I2_data_is_c(1),
      ADR2 => XLXI_10_I4_N9730,
      ADR3 => XLXI_10_I3_acc_c_0_1,
      O => N24675
    );
  XLXI_10_I3_Mmux_data_x_Result_0_45_SW2 : X_LUT3
    generic map(
      INIT => X"95"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => XLXI_10_I2_data_is_c(0),
      ADR2 => XLXI_10_I3_n0037,
      O => N24743
    );
  XLXI_10_I3_Mmux_data_x_Result_0_45_SW3 : X_LUT4
    generic map(
      INIT => X"D827"
    )
    port map (
      ADR0 => XLXI_10_I3_n0037,
      ADR1 => XLXI_10_I2_data_is_c(0),
      ADR2 => XLXI_10_I4_N9730,
      ADR3 => XLXI_10_I3_acc_c_0_0,
      O => N24745
    );
  XLXI_10_I3_Mmux_data_x_Result_2_SW1 : X_LUT3
    generic map(
      INIT => X"95"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_2,
      ADR1 => XLXI_10_I3_n0037,
      ADR2 => XLXI_10_I2_data_is_c(2),
      O => N24679
    );
  XLXI_10_I3_Mmux_data_x_Result_2_SW2 : X_LUT3
    generic map(
      INIT => X"C6"
    )
    port map (
      ADR0 => XLXI_10_I3_n0037,
      ADR1 => XLXI_10_I3_acc_c_0_2,
      ADR2 => XLXI_10_I2_data_is_c(2),
      O => N24681
    );
  XLXI_10_I3_n0035_4_60_SW0 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I3_N9047,
      ADR1 => CHOICE2013,
      ADR2 => CHOICE2025,
      ADR3 => XLXI_10_I2_TD_c(3),
      O => N24685
    );
  XLXI_10_I4_ndre_x1_SW0 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXN_8(8),
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => XLXI_10_I5_daddr_c(4),
      ADR3 => NRESET_IBUF,
      O => N24637
    );
  XLXI_10_I4_ndre_x1_SW4 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXN_8(7),
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => XLXI_10_I5_daddr_c(3),
      ADR3 => NRESET_IBUF,
      O => N24653
    );
  XLXI_3_Ker69031_SW9_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => N25257,
      ADR1 => XLXI_3_pwm_low(0),
      ADR2 => XLXI_3_pwm_period(0),
      O => N25166
    );
  XLXI_10_I3_Mmux_data_x_Result_2_SW3 : X_LUT3
    generic map(
      INIT => X"95"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_2,
      ADR1 => XLXI_10_I3_n0037,
      ADR2 => XLXI_10_I2_data_is_c(2),
      O => N24749
    );
  XLXI_10_I3_Mmux_data_x_Result_2_SW4 : X_LUT3
    generic map(
      INIT => X"C6"
    )
    port map (
      ADR0 => XLXI_10_I3_n0037,
      ADR1 => XLXI_10_I3_acc_c_0_2,
      ADR2 => XLXI_10_I2_data_is_c(2),
      O => N24751
    );
  XLXI_10_I3_Mmux_data_x_Result_3_SW1 : X_LUT3
    generic map(
      INIT => X"95"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_3,
      ADR1 => XLXI_10_I3_n0037,
      ADR2 => XLXI_10_I2_data_is_c(3),
      O => N24755
    );
  XLXI_10_I3_Mmux_data_x_Result_3_SW2 : X_LUT3
    generic map(
      INIT => X"C6"
    )
    port map (
      ADR0 => XLXI_10_I3_n0037,
      ADR1 => XLXI_10_I3_acc_c_0_3,
      ADR2 => XLXI_10_I2_data_is_c(3),
      O => N24757
    );
  XLXI_2_nCS_PWM_SW0_SW1 : X_LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      ADR0 => XLXI_10_I5_ndwe_c,
      ADR1 => XLXI_10_I5_daddr_c(0),
      ADR2 => XLXI_10_I5_daddr_c(4),
      ADR3 => NRESET_IBUF,
      O => N24767
    );
  XLXI_10_I5_Mmux_daddr_out_Result_1_1_SW0 : X_LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      ADR0 => N24645,
      ADR1 => XLXI_10_I5_ndwe_c,
      O => N24771
    );
  XLXI_10_I5_Mmux_daddr_out_Result_1_1_SW1 : X_LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      ADR0 => XLXI_10_I5_daddr_c(1),
      ADR1 => XLXI_10_I5_ndwe_c,
      O => N24773
    );
  XLXI_10_I5_Mmux_daddr_out_Result_4_1_SW0 : X_LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      ADR0 => N24637,
      ADR1 => XLXI_10_I5_ndwe_c,
      ADR2 => NRESET_IBUF,
      O => N24777
    );
  XLXI_10_I5_Mmux_daddr_out_Result_4_1_SW1 : X_LUT3
    generic map(
      INIT => X"EF"
    )
    port map (
      ADR0 => XLXI_10_I5_daddr_c(4),
      ADR1 => XLXI_10_I5_ndwe_c,
      ADR2 => NRESET_IBUF,
      O => N24779
    );
  XLXI_10_I4_Ker9710_SW1 : X_LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      ADR0 => XLXN_8(5),
      ADR1 => XLXN_8(4),
      ADR2 => XLXI_10_I4_ipage_c(0),
      O => N24783
    );
  XLXI_10_I4_Ker9710_SW2 : X_LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      ADR0 => XLXN_8(5),
      ADR1 => XLXN_8(4),
      ADR2 => XLXI_10_I4_ipage_c(1),
      O => N24787
    );
  XLXI_10_I2_pc_mux_x_1_1_141 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_10_I2_N8359,
      ADR1 => XLXI_10_I2_N8283,
      ADR2 => NRESET_IBUF,
      ADR3 => N22263,
      O => XLXI_10_I2_pc_mux_x_1_1
    );
  XLXI_10_I2_pc_mux_x_0_17_1_142 : X_LUT4
    generic map(
      INIT => X"EEFE"
    )
    port map (
      ADR0 => XLXI_10_I2_N8327,
      ADR1 => CHOICE1708,
      ADR2 => XLXI_10_I2_N8267,
      ADR3 => XLXN_8(3),
      O => XLXI_10_I2_pc_mux_x_0_17_1
    );
  XLXI_10_I3_n0035_0_107_SW11 : X_MUX2
    port map (
      IA => N25221,
      IB => N25223,
      SEL => CHOICE1966,
      O => N24693
    );
  XLXI_10_I3_n0035_0_107_SW11_F : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I3_N9047,
      ADR1 => CHOICE1984,
      ADR2 => XLXI_10_I3_N8884,
      ADR3 => XLXI_10_I2_TD_c(3),
      O => N25221
    );
  XLXI_10_I3_n0035_2_109_SW11 : X_MUX2
    port map (
      IA => N25226,
      IB => N25228,
      SEL => CHOICE2079,
      O => N24705
    );
  XLXI_10_I3_n0035_2_109_SW11_F : X_LUT4
    generic map(
      INIT => X"2220"
    )
    port map (
      ADR0 => XLXI_10_I3_N9047,
      ADR1 => XLXI_10_I2_TD_c(3),
      ADR2 => CHOICE2099,
      ADR3 => XLXI_10_I3_N8884,
      O => N25226
    );
  XLXI_10_I3_n0035_1_109_SW11 : X_MUX2
    port map (
      IA => N25231,
      IB => N25233,
      SEL => CHOICE2035,
      O => N24711
    );
  XLXI_10_I3_n0035_1_109_SW11_F : X_LUT4
    generic map(
      INIT => X"2220"
    )
    port map (
      ADR0 => XLXI_10_I3_N9047,
      ADR1 => XLXI_10_I2_TD_c(3),
      ADR2 => CHOICE2055,
      ADR3 => XLXI_10_I3_N8884,
      O => N25231
    );
  XLXI_10_I3_n0035_4_60_SW11 : X_MUX2
    port map (
      IA => N25236,
      IB => N25238,
      SEL => CHOICE2013,
      O => N24687
    );
  XLXI_10_I3_n0035_4_60_SW11_F : X_LUT4
    generic map(
      INIT => X"2220"
    )
    port map (
      ADR0 => XLXI_10_I3_N9047,
      ADR1 => XLXI_10_I2_TD_c(3),
      ADR2 => CHOICE2025,
      ADR3 => XLXI_10_I3_N8884,
      O => N25236
    );
  XLXI_10_I3_n0035_3_109_SW11 : X_MUX2
    port map (
      IA => N25241,
      IB => N25243,
      SEL => CHOICE2167,
      O => N24699
    );
  XLXI_10_I3_n0035_3_109_SW11_F : X_LUT4
    generic map(
      INIT => X"2220"
    )
    port map (
      ADR0 => XLXI_10_I3_N9047,
      ADR1 => XLXI_10_I2_TD_c(3),
      ADR2 => CHOICE2187,
      ADR3 => XLXI_10_I3_N8884,
      O => N25241
    );
  XLXI_10_I3_n0035_0_179_SW0 : X_MUX2
    port map (
      IA => N25246,
      IB => N25248,
      SEL => XLXI_10_I2_TD_c(2),
      O => N24977
    );
  XLXI_10_I3_n0035_0_179_SW0_F : X_LUT4
    generic map(
      INIT => X"4A40"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(1),
      ADR1 => XLXI_10_I3_acc_c_0_4,
      ADR2 => XLXI_10_I2_TD_c(0),
      ADR3 => XLXI_10_I3_acc_c_0_1,
      O => N25246
    );
  XLXI_10_I2_pc_mux_x_2_2_LUT4_D_BUF : X_BUF
    port map (
      I => XLXI_10_I2_pc_mux_x_2_2,
      O => N25418
    );
  XLXI_10_I2_pc_mux_x_2_2_148 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => XLXI_10_I2_N8283,
      ADR1 => N22203,
      ADR2 => XLXI_10_I2_N8336,
      ADR3 => XLXI_10_I2_N8359,
      O => XLXI_10_I2_pc_mux_x_2_2
    );
  XLXI_10_I2_pc_mux_x_2_1_LUT4_D_BUF : X_BUF
    port map (
      I => XLXI_10_I2_pc_mux_x_2_1,
      O => N25416
    );
  XLXI_10_I2_pc_mux_x_2_1_149 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => XLXI_10_I2_N8283,
      ADR1 => N22203,
      ADR2 => XLXI_10_I2_N8336,
      ADR3 => XLXI_10_I2_N8359,
      O => XLXI_10_I2_pc_mux_x_2_1
    );
  XLXI_2_nCS_PWM_SW0_SW0_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_2_nCS_PWM_SW0_SW0_O,
      O => N24765
    );
  XLXI_2_nCS_PWM_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      ADR0 => XLXI_10_I5_ndwe_c,
      ADR1 => N24641,
      ADR2 => N24637,
      ADR3 => NRESET_IBUF,
      O => XLXI_2_nCS_PWM_SW0_SW0_O
    );
  XLXI_10_I2_ndre_x_SW2_LUT4_D_BUF : X_BUF
    port map (
      I => N24761,
      O => N25413
    );
  XLXI_10_I2_ndre_x_SW2 : X_LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      ADR0 => XLXI_10_skip,
      ADR1 => N24084,
      ADR2 => XLXI_10_I2_nreset_v(1),
      ADR3 => NRESET_IBUF,
      O => N24761
    );
  XLXI_10_I1_iaddr_x_0_31_LUT2_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_iaddr_x_0_31_O,
      O => CHOICE1931
    );
  XLXI_10_I1_iaddr_x_0_31 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => N25128,
      O => XLXI_10_I1_iaddr_x_0_31_O
    );
  XLXI_3_Ker69031_SW2_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW2_O,
      O => N24739
    );
  XLXI_3_Ker69031_SW2 : X_LUT4
    generic map(
      INIT => X"DC8C"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => CPU_DATA_OUT_2_OBUF,
      ADR2 => CPU_DADDR_2_OBUF,
      ADR3 => XLXI_3_pwm_period(2),
      O => XLXI_3_Ker69031_SW2_O
    );
  XLXI_3_Ker69031_SW1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW1_O,
      O => N24735
    );
  XLXI_3_Ker69031_SW1 : X_LUT4
    generic map(
      INIT => X"DC8C"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => CPU_DATA_OUT_1_OBUF,
      ADR2 => CPU_DADDR_2_OBUF,
      ADR3 => XLXI_3_pwm_period(1),
      O => XLXI_3_Ker69031_SW1_O
    );
  XLXI_3_Ker69031_SW0_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW0_O,
      O => N24731
    );
  XLXI_3_Ker69031_SW0 : X_LUT4
    generic map(
      INIT => X"DC8C"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => CPU_DATA_OUT_0_OBUF,
      ADR2 => CPU_DADDR_2_OBUF,
      ADR3 => XLXI_3_pwm_period(0),
      O => XLXI_3_Ker69031_SW0_O
    );
  XLXI_3_Ker69031_SW9_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW9_O,
      O => N24823
    );
  XLXI_3_Ker69031_SW9 : X_LUT4
    generic map(
      INIT => X"2373"
    )
    port map (
      ADR0 => N23342,
      ADR1 => XLXI_3_pwm_low(0),
      ADR2 => CPU_DADDR_2_OBUF,
      ADR3 => N25166,
      O => XLXI_3_Ker69031_SW9_O
    );
  XLXI_3_Msub_n0005_inst_lut2_231_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_3_Msub_n0005_inst_lut2_231_O,
      O => XLXI_3_Msub_n0005_inst_lut2_23
    );
  XLXI_3_Msub_n0005_inst_lut2_231 : X_LUT4
    generic map(
      INIT => X"D827"
    )
    port map (
      ADR0 => XLXI_3_N6905,
      ADR1 => XLXI_3_pwm_low(7),
      ADR2 => XLXI_3_pwm_period(7),
      ADR3 => XLXI_2_pwm_data_c(3),
      O => XLXI_3_Msub_n0005_inst_lut2_231_O
    );
  XLXI_10_I3_n0035_4_11_SW1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I3_n0035_4_11_SW1_O,
      O => N24829
    );
  XLXI_10_I3_n0035_4_11_SW1 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N24687,
      ADR1 => XLXI_10_I3_n0058(4),
      ADR2 => N25170,
      ADR3 => XLXI_10_I3_n0048,
      O => XLXI_10_I3_n0035_4_11_SW1_O
    );
  XLXI_10_I3_n0035_2_47_SW0_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I3_n0035_2_47_SW0_O,
      O => N24795
    );
  XLXI_10_I3_n0035_2_47_SW0 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N24705,
      ADR1 => XLXI_10_I3_n0064(2),
      ADR2 => N25174,
      ADR3 => XLXI_10_I3_n0048,
      O => XLXI_10_I3_n0035_2_47_SW0_O
    );
  XLXI_10_I3_n0035_0_27_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I3_n0035_0_27_O,
      O => CHOICE1953
    );
  XLXI_10_I3_n0035_0_27 : X_LUT4
    generic map(
      INIT => X"D8A8"
    )
    port map (
      ADR0 => XLXI_10_I3_data_x(0),
      ADR1 => XLXI_10_I3_N8915,
      ADR2 => XLXI_10_I3_n0053,
      ADR3 => XLXI_10_I3_acc_c_0_0,
      O => XLXI_10_I3_n0035_0_27_O
    );
  XLXI_10_I2_ndre_x_SW0_LUT4_D_BUF : X_BUF
    port map (
      I => N24084,
      O => N25402
    );
  XLXI_10_I2_ndre_x_SW0 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(2),
      ADR1 => XLXI_10_I2_skip_c,
      ADR2 => XLXI_10_I2_TC_c(0),
      ADR3 => XLXI_10_I2_TC_c(1),
      O => N24084
    );
  XLXI_10_I3_Mmux_data_x_Result_1_18_LUT4_D_BUF : X_BUF
    port map (
      I => CHOICE2070,
      O => N25400
    );
  XLXI_10_I3_Mmux_data_x_Result_1_18 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => N21724,
      ADR1 => N24787,
      ADR2 => N24761,
      ADR3 => N24851,
      O => CHOICE2070
    );
  XLXI_10_I3_Mmux_data_x_Result_3_LUT4_D_BUF : X_BUF
    port map (
      I => XLXI_10_I3_data_x(3),
      O => N25398
    );
  XLXI_10_I3_Mmux_data_x_Result_3_Q : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => XLXI_10_I3_n0037,
      ADR1 => XLXI_10_I2_data_is_c(3),
      ADR2 => N23016,
      ADR3 => XLXI_10_I4_N9697,
      O => XLXI_10_I3_data_x(3)
    );
  XLXI_10_I3_skip_l90_LUT2_L_BUF : X_BUF
    port map (
      I => XLXI_10_I3_skip_l90_O,
      O => CHOICE2162
    );
  XLXI_10_I3_skip_l90 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_I3_N9047,
      ADR1 => CHOICE2161,
      O => XLXI_10_I3_skip_l90_O
    );
  XLXI_3_n0006_3_1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_3_n0006_3_1_O,
      O => XLXI_3_n0006(3)
    );
  XLXI_3_n0006_3_1 : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => XLXI_3_N6924,
      ADR1 => XLXI_3_pwm_period(3),
      ADR2 => XLXI_10_I3_acc_c_0_3,
      ADR3 => XLXI_10_I4_N9730,
      O => XLXI_3_n0006_3_1_O
    );
  XLXI_10_I3_n0035_3_47_SW0_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I3_n0035_3_47_SW0_O,
      O => N24791
    );
  XLXI_10_I3_n0035_3_47_SW0 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N24699,
      ADR1 => XLXI_10_I3_n0064(3),
      ADR2 => N25184,
      ADR3 => XLXI_10_I3_n0048,
      O => XLXI_10_I3_n0035_3_47_SW0_O
    );
  XLXI_3_Ker69031_SW3_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW3_O,
      O => N24799
    );
  XLXI_3_Ker69031_SW3 : X_LUT4
    generic map(
      INIT => X"2373"
    )
    port map (
      ADR0 => N23342,
      ADR1 => XLXI_3_pwm_low(6),
      ADR2 => CPU_DADDR_2_OBUF,
      ADR3 => N25192,
      O => XLXI_3_Ker69031_SW3_O
    );
  XLXI_10_I3_Mmux_data_x_Result_2_LUT4_D_BUF : X_BUF
    port map (
      I => XLXI_10_I3_data_x(2),
      O => N25392
    );
  XLXI_10_I3_Mmux_data_x_Result_2_Q : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => XLXI_10_I3_n0037,
      ADR1 => XLXI_10_I2_data_is_c(2),
      ADR2 => N23412,
      ADR3 => XLXI_10_I4_N9697,
      O => XLXI_10_I3_data_x(2)
    );
  XLXI_10_I3_Mmux_data_x_Result_0_13_LUT4_D_BUF : X_BUF
    port map (
      I => CHOICE2128,
      O => N25390
    );
  XLXI_10_I3_Mmux_data_x_Result_0_13 : X_LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      ADR0 => XLXI_10_I4_N9697,
      ADR1 => XLXI_2_mux_c(0),
      ADR2 => CTRL_DATA_IN_0_IBUF,
      ADR3 => RAM_DATA_OUT(0),
      O => CHOICE2128
    );
  XLXI_2_nCS_PWM_LUT4_D_BUF : X_BUF
    port map (
      I => nCS_PWM,
      O => N25388
    );
  XLXI_2_nCS_PWM : X_LUT4
    generic map(
      INIT => X"FFED"
    )
    port map (
      ADR0 => CPU_DADDR_2_OBUF,
      ADR1 => CPU_DADDR_3_OBUF,
      ADR2 => CPU_DADDR_1_OBUF,
      ADR3 => N23342,
      O => nCS_PWM
    );
  XLXI_10_I3_n0035_1_47_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I3_n0035_1_47_O,
      O => CHOICE2047
    );
  XLXI_10_I3_n0035_1_47 : X_LUT4
    generic map(
      INIT => X"FFEA"
    )
    port map (
      ADR0 => CHOICE2036,
      ADR1 => XLXI_10_I3_n0048,
      ADR2 => XLXI_10_I3_n0064(1),
      ADR3 => CHOICE2044,
      O => XLXI_10_I3_n0035_1_47_O
    );
  XLXI_10_I1_n0012_0_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0012_0_19_SW0_O,
      O => N25010
    );
  XLXI_10_I1_n0012_0_19_SW0 : X_LUT3
    generic map(
      INIT => X"8D"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_0,
      ADR2 => XLXI_10_I1_pc(0),
      O => XLXI_10_I1_n0012_0_19_SW0_O
    );
  XLXI_10_I3_Mmux_data_x_Result_1_13_LUT4_D_BUF : X_BUF
    port map (
      I => CHOICE2067,
      O => N25384
    );
  XLXI_10_I3_Mmux_data_x_Result_1_13 : X_LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      ADR0 => XLXI_10_I4_N9697,
      ADR1 => XLXI_2_mux_c(0),
      ADR2 => CTRL_DATA_IN_1_IBUF,
      ADR3 => RAM_DATA_OUT(1),
      O => CHOICE2067
    );
  XLXI_10_I3_Mmux_data_x_Result_0_18_LUT4_D_BUF : X_BUF
    port map (
      I => CHOICE2131,
      O => N25382
    );
  XLXI_10_I3_Mmux_data_x_Result_0_18 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => N21724,
      ADR1 => N24783,
      ADR2 => N24761,
      ADR3 => N24847,
      O => CHOICE2131
    );
  XLXI_3_Ker69031_SW8_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW8_O,
      O => N24819
    );
  XLXI_3_Ker69031_SW8 : X_LUT4
    generic map(
      INIT => X"2373"
    )
    port map (
      ADR0 => N23342,
      ADR1 => XLXI_3_pwm_low(1),
      ADR2 => CPU_DADDR_2_OBUF,
      ADR3 => N25196,
      O => XLXI_3_Ker69031_SW8_O
    );
  XLXI_3_Ker69031_SW7_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW7_O,
      O => N24815
    );
  XLXI_3_Ker69031_SW7 : X_LUT4
    generic map(
      INIT => X"2373"
    )
    port map (
      ADR0 => N23342,
      ADR1 => XLXI_3_pwm_low(2),
      ADR2 => CPU_DADDR_2_OBUF,
      ADR3 => N25200,
      O => XLXI_3_Ker69031_SW7_O
    );
  XLXI_10_I1_iaddr_x_1_50_LUT4_D_BUF : X_BUF
    port map (
      I => CPU_IADDR_1_OBUF,
      O => N25378
    );
  XLXI_10_I1_iaddr_x_1_50 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => CHOICE1826,
      ADR2 => CHOICE1819,
      ADR3 => XLXI_10_pc_mux(2),
      O => CPU_IADDR_1_OBUF
    );
  XLXI_10_I1_iaddr_x_2_31_LUT2_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_iaddr_x_2_31_O,
      O => CHOICE1841
    );
  XLXI_10_I1_iaddr_x_2_31 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => N25136,
      O => XLXI_10_I1_iaddr_x_2_31_O
    );
  XLXI_3_Ker69031_SW6_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW6_O,
      O => N24811
    );
  XLXI_3_Ker69031_SW6 : X_LUT4
    generic map(
      INIT => X"2373"
    )
    port map (
      ADR0 => N23342,
      ADR1 => XLXI_3_pwm_low(3),
      ADR2 => CPU_DADDR_2_OBUF,
      ADR3 => N25204,
      O => XLXI_3_Ker69031_SW6_O
    );
  XLXI_10_I2_pc_mux_x_2_LUT4_D_BUF : X_BUF
    port map (
      I => XLXI_10_pc_mux(2),
      O => N25374
    );
  XLXI_10_I2_pc_mux_x_2_Q : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => XLXI_10_I2_N8283,
      ADR1 => N22203,
      ADR2 => XLXI_10_I2_N8336,
      ADR3 => XLXI_10_I2_N8359,
      O => XLXI_10_pc_mux(2)
    );
  XLXI_10_I1_iaddr_x_5_31_LUT2_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_iaddr_x_5_31_O,
      O => CHOICE1886
    );
  XLXI_10_I1_iaddr_x_5_31 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => N25148,
      O => XLXI_10_I1_iaddr_x_5_31_O
    );
  XLXI_10_I1_iaddr_x_6_31_LUT2_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_iaddr_x_6_31_O,
      O => CHOICE1856
    );
  XLXI_10_I1_iaddr_x_6_31 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => N25152,
      O => XLXI_10_I1_iaddr_x_6_31_O
    );
  XLXI_10_I1_iaddr_x_5_50_LUT4_D_BUF : X_BUF
    port map (
      I => CPU_IADDR_5_OBUF,
      O => N25370
    );
  XLXI_10_I1_iaddr_x_5_50 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => CHOICE1886,
      ADR2 => CHOICE1879,
      ADR3 => XLXI_10_pc_mux(2),
      O => CPU_IADDR_5_OBUF
    );
  XLXI_10_I1_iaddr_x_2_50_LUT4_D_BUF : X_BUF
    port map (
      I => CPU_IADDR_2_OBUF,
      O => N25368
    );
  XLXI_10_I1_iaddr_x_2_50 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => CHOICE1841,
      ADR2 => CHOICE1834,
      ADR3 => XLXI_10_pc_mux(2),
      O => CPU_IADDR_2_OBUF
    );
  XLXI_10_I1_iaddr_x_7_31_LUT2_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_iaddr_x_7_31_O,
      O => CHOICE1871
    );
  XLXI_10_I1_iaddr_x_7_31 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => N25156,
      O => XLXI_10_I1_iaddr_x_7_31_O
    );
  XLXI_10_I1_iaddr_x_6_50_LUT4_D_BUF : X_BUF
    port map (
      I => CPU_IADDR_6_OBUF,
      O => N25365
    );
  XLXI_10_I1_iaddr_x_6_50 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => CHOICE1856,
      ADR2 => CHOICE1849,
      ADR3 => XLXI_10_pc_mux(2),
      O => CPU_IADDR_6_OBUF
    );
  XLXI_10_I1_iaddr_x_4_31_LUT2_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_iaddr_x_4_31_O,
      O => CHOICE1901
    );
  XLXI_10_I1_iaddr_x_4_31 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => N25144,
      O => XLXI_10_I1_iaddr_x_4_31_O
    );
  XLXI_10_I1_iaddr_x_1_31_LUT2_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_iaddr_x_1_31_O,
      O => CHOICE1826
    );
  XLXI_10_I1_iaddr_x_1_31 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => N25132,
      O => XLXI_10_I1_iaddr_x_1_31_O
    );
  XLXI_10_I1_n0012_2_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0012_2_19_SW0_O,
      O => N25030
    );
  XLXI_10_I1_n0012_2_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_2,
      ADR2 => XLXI_10_I1_n0013(2),
      O => XLXI_10_I1_n0012_2_19_SW0_O
    );
  XLXI_10_I1_n0010_6_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0010_6_19_O,
      O => XLXI_10_I1_n0010(6)
    );
  XLXI_10_I1_n0010_6_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25094,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_6,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0010_6_19_O
    );
  XLXI_10_I1_n0012_4_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0012_4_19_SW0_O,
      O => N25038
    );
  XLXI_10_I1_n0012_4_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_4,
      ADR2 => XLXI_10_I1_n0013(4),
      O => XLXI_10_I1_n0012_4_19_SW0_O
    );
  XLXI_10_I1_n0011_1_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0011_1_19_O,
      O => XLXI_10_I1_n0011(1)
    );
  XLXI_10_I1_n0011_1_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25090,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_1,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0011_1_19_O
    );
  XLXI_10_I1_n0011_7_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0011_7_19_O,
      O => XLXI_10_I1_n0011(7)
    );
  XLXI_10_I1_n0011_7_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25086,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_7,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0011_7_19_O
    );
  XLXI_10_I1_n0010_1_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0010_1_19_O,
      O => XLXI_10_I1_n0010(1)
    );
  XLXI_10_I1_n0010_1_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25082,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_1,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0010_1_19_O
    );
  XLXI_10_I1_n0011_0_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0011_0_19_O,
      O => XLXI_10_I1_n0011(0)
    );
  XLXI_10_I1_n0011_0_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25078,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_0,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0011_0_19_O
    );
  XLXI_10_I1_n0011_4_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0011_4_19_O,
      O => XLXI_10_I1_n0011(4)
    );
  XLXI_10_I1_n0011_4_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25074,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_4,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0011_4_19_O
    );
  XLXI_2_n0020_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_2_n0020_SW0_O,
      O => N21388
    );
  XLXI_2_n0020_SW0 : X_LUT3
    generic map(
      INIT => X"DF"
    )
    port map (
      ADR0 => CPU_DADDR_4_OBUF,
      ADR1 => CPU_DADDR_3_OBUF,
      ADR2 => NRESET_IBUF,
      O => XLXI_2_n0020_SW0_O
    );
  XLXI_10_I1_n0011_3_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0011_3_19_SW0_O,
      O => N25026
    );
  XLXI_10_I1_n0011_3_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_3,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_3,
      O => XLXI_10_I1_n0011_3_19_SW0_O
    );
  XLXI_10_I1_n0012_1_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0012_1_19_O,
      O => XLXI_10_I1_n0012(1)
    );
  XLXI_10_I1_n0012_1_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25070,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_1,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0012_1_19_O
    );
  XLXI_2_n0046_SW0_LUT2_L_BUF : X_BUF
    port map (
      I => XLXI_2_n0046_SW0_O,
      O => N21493
    );
  XLXI_2_n0046_SW0 : X_LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      ADR0 => CPU_DADDR_2_OBUF,
      ADR1 => CPU_DADDR_1_OBUF,
      O => XLXI_2_n0046_SW0_O
    );
  XLXI_10_I1_n0010_5_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0010_5_19_O,
      O => XLXI_10_I1_n0010(5)
    );
  XLXI_10_I1_n0010_5_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25066,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_5,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0010_5_19_O
    );
  XLXI_10_I1_n0010_6_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0010_6_19_SW0_O,
      O => N25094
    );
  XLXI_10_I1_n0010_6_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_6,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_6,
      O => XLXI_10_I1_n0010_6_19_SW0_O
    );
  XLXI_10_I1_n0011_6_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0011_6_19_O,
      O => XLXI_10_I1_n0011(6)
    );
  XLXI_10_I1_n0011_6_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25062,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_6,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0011_6_19_O
    );
  XLXI_10_I1_n0010_0_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0010_0_19_O,
      O => XLXI_10_I1_n0010(0)
    );
  XLXI_10_I1_n0010_0_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25058,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_0,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0010_0_19_O
    );
  XLXI_10_I1_n0012_6_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0012_6_19_O,
      O => XLXI_10_I1_n0012(6)
    );
  XLXI_10_I1_n0012_6_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25054,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_6,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0012_6_19_O
    );
  XLXI_10_I1_n0011_1_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0011_1_19_SW0_O,
      O => N25090
    );
  XLXI_10_I1_n0011_1_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_1,
      O => XLXI_10_I1_n0011_1_19_SW0_O
    );
  XLXI_10_I1_n0010_3_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0010_3_19_O,
      O => XLXI_10_I1_n0010(3)
    );
  XLXI_10_I1_n0010_3_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25050,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_3,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0010_3_19_O
    );
  XLXI_10_I1_n0010_1_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0010_1_19_SW0_O,
      O => N25082
    );
  XLXI_10_I1_n0010_1_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_1,
      O => XLXI_10_I1_n0010_1_19_SW0_O
    );
  XLXI_10_I1_n0012_3_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0012_3_19_O,
      O => XLXI_10_I1_n0012(3)
    );
  XLXI_10_I1_n0012_3_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25046,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_3,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0012_3_19_O
    );
  XLXI_10_I1_n0010_3_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0010_3_19_SW0_O,
      O => N25050
    );
  XLXI_10_I1_n0010_3_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_3,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_3,
      O => XLXI_10_I1_n0010_3_19_SW0_O
    );
  XLXI_10_I1_n0011_5_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0011_5_19_SW0_O,
      O => N25014
    );
  XLXI_10_I1_n0011_5_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_5,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_5,
      O => XLXI_10_I1_n0011_5_19_SW0_O
    );
  XLXI_10_I1_n0010_7_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0010_7_19_O,
      O => XLXI_10_I1_n0010(7)
    );
  XLXI_10_I1_n0010_7_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25042,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_7,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0010_7_19_O
    );
  XLXI_10_I4_Ker97281_LUT2_D_BUF : X_BUF
    port map (
      I => XLXI_10_I4_N9730,
      O => N25337
    );
  XLXI_10_I4_Ker97281 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_I4_nreset_v(1),
      ADR1 => NRESET_IBUF,
      O => XLXI_10_I4_N9730
    );
  XLXI_10_I3_Mmux_data_x_Result_1_45_LUT4_D_BUF : X_BUF
    port map (
      I => XLXI_10_I3_data_x(1),
      O => N25335
    );
  XLXI_10_I3_Mmux_data_x_Result_1_45 : X_LUT4
    generic map(
      INIT => X"FFA8"
    )
    port map (
      ADR0 => CHOICE2073,
      ADR1 => CHOICE2067,
      ADR2 => CHOICE2070,
      ADR3 => CHOICE2062,
      O => XLXI_10_I3_data_x(1)
    );
  XLXI_10_I3_Mmux_data_x_Result_0_45_LUT4_D_BUF : X_BUF
    port map (
      I => XLXI_10_I3_data_x(0),
      O => N25333
    );
  XLXI_10_I3_Mmux_data_x_Result_0_45 : X_LUT4
    generic map(
      INIT => X"FFA8"
    )
    port map (
      ADR0 => CHOICE2134,
      ADR1 => CHOICE2128,
      ADR2 => CHOICE2131,
      ADR3 => CHOICE2123,
      O => XLXI_10_I3_data_x(0)
    );
  XLXI_10_I3_n0035_4_96_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I3_n0035_4_96_O,
      O => XLXI_10_I3_n0035(4)
    );
  XLXI_10_I3_n0035_4_96 : X_LUT4
    generic map(
      INIT => X"FBEA"
    )
    port map (
      ADR0 => CHOICE2010,
      ADR1 => XLXI_10_I3_n0059(4),
      ADR2 => N24829,
      ADR3 => N24827,
      O => XLXI_10_I3_n0035_4_96_O
    );
  XLXI_10_I3_n0035_3_145_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I3_n0035_3_145_O,
      O => XLXI_10_I3_n0035(3)
    );
  XLXI_10_I3_n0035_3_145 : X_LUT4
    generic map(
      INIT => X"FBEA"
    )
    port map (
      ADR0 => CHOICE2164,
      ADR1 => CHOICE2168,
      ADR2 => N24699,
      ADR3 => N24791,
      O => XLXI_10_I3_n0035_3_145_O
    );
  XLXI_10_I3_n0035_2_145_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I3_n0035_2_145_O,
      O => XLXI_10_I3_n0035(2)
    );
  XLXI_10_I3_n0035_2_145 : X_LUT4
    generic map(
      INIT => X"FBEA"
    )
    port map (
      ADR0 => CHOICE2076,
      ADR1 => CHOICE2080,
      ADR2 => N24705,
      ADR3 => N24795,
      O => XLXI_10_I3_n0035_2_145_O
    );
  XLXI_10_I3_n0035_1_145_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I3_n0035_1_145_O,
      O => XLXI_10_I3_n0035(1)
    );
  XLXI_10_I3_n0035_1_145 : X_LUT4
    generic map(
      INIT => X"FBEA"
    )
    port map (
      ADR0 => CHOICE2032,
      ADR1 => CHOICE2047,
      ADR2 => N24711,
      ADR3 => N24709,
      O => XLXI_10_I3_n0035_1_145_O
    );
  XLXI_10_I3_n0035_0_220_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I3_n0035_0_220_O,
      O => XLXI_10_I3_n0035(0)
    );
  XLXI_10_I3_n0035_0_220 : X_LUT4
    generic map(
      INIT => X"FBEA"
    )
    port map (
      ADR0 => CHOICE1944,
      ADR1 => CHOICE1956,
      ADR2 => N24693,
      ADR3 => N24691,
      O => XLXI_10_I3_n0035_0_220_O
    );
  XLXI_10_I3_n00441_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I3_n00441_O,
      O => XLXI_10_I3_n0044
    );
  XLXI_10_I3_n00441 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => XLXI_10_I3_acc_c_0_1,
      ADR2 => XLXI_10_I3_acc_c_0_2,
      ADR3 => XLXI_10_I3_acc_c_0_3,
      O => XLXI_10_I3_n00441_O
    );
  XLXI_10_I3_Ker906235_LUT3_D_BUF : X_BUF
    port map (
      I => XLXI_10_I3_N9064,
      O => N25325
    );
  XLXI_10_I3_Ker906235 : X_LUT3
    generic map(
      INIT => X"AE"
    )
    port map (
      ADR0 => CHOICE1448,
      ADR1 => CHOICE1457,
      ADR2 => XLXI_10_I2_TD_c(1),
      O => XLXI_10_I3_N9064
    );
  XLXI_10_I1_n0012_4_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0012_4_19_O,
      O => XLXI_10_I1_n0012(4)
    );
  XLXI_10_I1_n0012_4_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25038,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_4,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0012_4_19_O
    );
  XLXI_10_I2_pc_mux_x_0_17_LUT4_D_BUF : X_BUF
    port map (
      I => XLXI_10_pc_mux(0),
      O => N25322
    );
  XLXI_10_I2_pc_mux_x_0_17 : X_LUT4
    generic map(
      INIT => X"EEFE"
    )
    port map (
      ADR0 => XLXI_10_I2_N8327,
      ADR1 => CHOICE1708,
      ADR2 => XLXI_10_I2_N8267,
      ADR3 => XLXN_8(3),
      O => XLXI_10_pc_mux(0)
    );
  XLXI_10_I1_n0011_2_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0011_2_19_O,
      O => XLXI_10_I1_n0011(2)
    );
  XLXI_10_I1_n0011_2_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25034,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_2,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0011_2_19_O
    );
  XLXI_10_I2_Ker83251_LUT3_D_BUF : X_BUF
    port map (
      I => XLXI_10_I2_N8327,
      O => N25319
    );
  XLXI_10_I2_Ker83251 : X_LUT3
    generic map(
      INIT => X"DF"
    )
    port map (
      ADR0 => XLXI_10_I2_nreset_v(1),
      ADR1 => XLXI_10_skip,
      ADR2 => NRESET_IBUF,
      O => XLXI_10_I2_N8327
    );
  XLXI_10_I1_iaddr_x_3_31_LUT2_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_iaddr_x_3_31_O,
      O => CHOICE1916
    );
  XLXI_10_I1_iaddr_x_3_31 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => N25140,
      O => XLXI_10_I1_iaddr_x_3_31_O
    );
  XLXI_10_I4_Ker9710_SW0_LUT3_D_BUF : X_BUF
    port map (
      I => N21724,
      O => N25316
    );
  XLXI_10_I4_Ker9710_SW0 : X_LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      ADR0 => XLXN_8(7),
      ADR1 => XLXN_8(9),
      ADR2 => XLXN_8(8),
      O => N21724
    );
  XLXI_10_I2_Ker83341_LUT3_D_BUF : X_BUF
    port map (
      I => XLXI_10_I2_N8336,
      O => N25314
    );
  XLXI_10_I2_Ker83341 : X_LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      ADR0 => XLXN_8(7),
      ADR1 => XLXN_8(5),
      ADR2 => XLXN_8(6),
      O => XLXI_10_I2_N8336
    );
  XLXI_10_I2_Ker83571_LUT2_D_BUF : X_BUF
    port map (
      I => XLXI_10_I2_N8359,
      O => N25312
    );
  XLXI_10_I2_Ker83571 : X_LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      ADR0 => XLXI_10_I2_nreset_v(1),
      ADR1 => XLXI_10_skip,
      O => XLXI_10_I2_N8359
    );
  XLXI_10_I1_n0012_2_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0012_2_19_O,
      O => XLXI_10_I1_n0012(2)
    );
  XLXI_10_I1_n0012_2_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25030,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_2,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0012_2_19_O
    );
  XLXI_10_I1_n0011_3_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0011_3_19_O,
      O => XLXI_10_I1_n0011(3)
    );
  XLXI_10_I1_n0011_3_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25026,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_3,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0011_3_19_O
    );
  XLXI_10_I1_n0010_4_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0010_4_19_SW0_O,
      O => N25002
    );
  XLXI_10_I1_n0010_4_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_4,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_4,
      O => XLXI_10_I1_n0010_4_19_SW0_O
    );
  XLXI_10_I1_n0012_1_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0012_1_19_SW0_O,
      O => N25070
    );
  XLXI_10_I1_n0012_1_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_1,
      ADR2 => XLXI_10_I1_n0013(1),
      O => XLXI_10_I1_n0012_1_19_SW0_O
    );
  XLXI_2_n0043_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_2_n0043_SW0_O,
      O => N21431
    );
  XLXI_2_n0043_SW0 : X_LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      ADR0 => CPU_DADDR_2_OBUF,
      ADR1 => CPU_DADDR_1_OBUF,
      ADR2 => XLXI_10_I5_ndwe_c,
      O => XLXI_2_n0043_SW0_O
    );
  XLXI_10_I1_n0012_5_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0012_5_19_SW0_O,
      O => N25018
    );
  XLXI_10_I1_n0012_5_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_5,
      ADR2 => XLXI_10_I1_n0013(5),
      O => XLXI_10_I1_n0012_5_19_SW0_O
    );
  XLXI_10_I1_n0009_2_1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0009_2_1_O,
      O => XLXI_10_I1_n0009(2)
    );
  XLXI_10_I1_n0009_2_1 : X_LUT4
    generic map(
      INIT => X"4F40"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_2,
      ADR2 => XLXI_10_I1_n0016,
      ADR3 => XLXI_10_I1_stack_addrs_c_3_2,
      O => XLXI_10_I1_n0009_2_1_O
    );
  XLXI_10_I1_n0009_3_1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0009_3_1_O,
      O => XLXI_10_I1_n0009(3)
    );
  XLXI_10_I1_n0009_3_1 : X_LUT4
    generic map(
      INIT => X"4F40"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_3,
      ADR2 => XLXI_10_I1_n0016,
      ADR3 => XLXI_10_I1_stack_addrs_c_3_3,
      O => XLXI_10_I1_n0009_3_1_O
    );
  XLXI_10_I1_n0009_4_1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0009_4_1_O,
      O => XLXI_10_I1_n0009(4)
    );
  XLXI_10_I1_n0009_4_1 : X_LUT4
    generic map(
      INIT => X"4F40"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_4,
      ADR2 => XLXI_10_I1_n0016,
      ADR3 => XLXI_10_I1_stack_addrs_c_3_4,
      O => XLXI_10_I1_n0009_4_1_O
    );
  XLXI_10_I1_n0009_5_1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0009_5_1_O,
      O => XLXI_10_I1_n0009(5)
    );
  XLXI_10_I1_n0009_5_1 : X_LUT4
    generic map(
      INIT => X"4F40"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_5,
      ADR2 => XLXI_10_I1_n0016,
      ADR3 => XLXI_10_I1_stack_addrs_c_3_5,
      O => XLXI_10_I1_n0009_5_1_O
    );
  XLXI_10_I1_n0009_6_1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0009_6_1_O,
      O => XLXI_10_I1_n0009(6)
    );
  XLXI_10_I1_n0009_6_1 : X_LUT4
    generic map(
      INIT => X"4F40"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_6,
      ADR2 => XLXI_10_I1_n0016,
      ADR3 => XLXI_10_I1_stack_addrs_c_3_6,
      O => XLXI_10_I1_n0009_6_1_O
    );
  XLXI_10_I1_n0009_7_1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0009_7_1_O,
      O => XLXI_10_I1_n0009(7)
    );
  XLXI_10_I1_n0009_7_1 : X_LUT4
    generic map(
      INIT => X"4F40"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_7,
      ADR2 => XLXI_10_I1_n0016,
      ADR3 => XLXI_10_I1_stack_addrs_c_3_7,
      O => XLXI_10_I1_n0009_7_1_O
    );
  XLXI_10_I1_iaddr_x_0_52_LUT4_D_BUF : X_BUF
    port map (
      I => CPU_IADDR_0_OBUF,
      O => N25298
    );
  XLXI_10_I1_iaddr_x_0_52 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => CHOICE1931,
      ADR2 => CHOICE1924,
      ADR3 => XLXI_10_pc_mux(2),
      O => CPU_IADDR_0_OBUF
    );
  XLXI_10_I1_n0009_1_1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0009_1_1_O,
      O => XLXI_10_I1_n0009(1)
    );
  XLXI_10_I1_n0009_1_1 : X_LUT4
    generic map(
      INIT => X"4F40"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_1,
      ADR2 => N25284,
      ADR3 => XLXI_10_I1_stack_addrs_c_3_1,
      O => XLXI_10_I1_n0009_1_1_O
    );
  XLXI_10_I1_iaddr_x_4_50_LUT4_D_BUF : X_BUF
    port map (
      I => CPU_IADDR_4_OBUF,
      O => N25295
    );
  XLXI_10_I1_iaddr_x_4_50 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => CHOICE1901,
      ADR2 => CHOICE1894,
      ADR3 => XLXI_10_pc_mux(2),
      O => CPU_IADDR_4_OBUF
    );
  XLXI_10_I1_iaddr_x_3_50_LUT4_D_BUF : X_BUF
    port map (
      I => CPU_IADDR_3_OBUF,
      O => N25293
    );
  XLXI_10_I1_iaddr_x_3_50 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => CHOICE1916,
      ADR2 => CHOICE1909,
      ADR3 => XLXI_10_pc_mux(2),
      O => CPU_IADDR_3_OBUF
    );
  XLXI_10_I1_n0011_6_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0011_6_19_SW0_O,
      O => N25062
    );
  XLXI_10_I1_n0011_6_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_6,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_6,
      O => XLXI_10_I1_n0011_6_19_SW0_O
    );
  XLXI_10_I1_n0010_2_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0010_2_19_O,
      O => XLXI_10_I1_n0010(2)
    );
  XLXI_10_I1_n0010_2_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25022,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_2,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0010_2_19_O
    );
  XLXI_10_I1_n0010_2_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0010_2_19_SW0_O,
      O => N25022
    );
  XLXI_10_I1_n0010_2_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_2,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_2,
      O => XLXI_10_I1_n0010_2_19_SW0_O
    );
  XLXI_10_I1_n0012_5_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0012_5_19_O,
      O => XLXI_10_I1_n0012(5)
    );
  XLXI_10_I1_n0012_5_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25018,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_5,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0012_5_19_O
    );
  XLXI_10_I1_n0011_4_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0011_4_19_SW0_O,
      O => N25074
    );
  XLXI_10_I1_n0011_4_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_4,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_4,
      O => XLXI_10_I1_n0011_4_19_SW0_O
    );
  XLXI_10_I1_n0011_2_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0011_2_19_SW0_O,
      O => N25034
    );
  XLXI_10_I1_n0011_2_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_2,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_2,
      O => XLXI_10_I1_n0011_2_19_SW0_O
    );
  XLXI_10_I1_n0012_3_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0012_3_19_SW0_O,
      O => N25046
    );
  XLXI_10_I1_n0012_3_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_3,
      ADR2 => XLXI_10_I1_n0013(3),
      O => XLXI_10_I1_n0012_3_19_SW0_O
    );
  XLXI_10_I1_n00161_LUT2_D_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0016,
      O => N25284
    );
  XLXI_10_I1_n00161 : X_LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(1),
      ADR1 => XLXI_10_pc_mux(0),
      O => XLXI_10_I1_n0016
    );
  XLXI_10_I1_n0011_5_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0011_5_19_O,
      O => XLXI_10_I1_n0011(5)
    );
  XLXI_10_I1_n0011_5_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25014,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_5,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0011_5_19_O
    );
  XLXI_10_I1_n0012_0_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0012_0_19_O,
      O => XLXI_10_I1_n0012(0)
    );
  XLXI_10_I1_n0012_0_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25010,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_0,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0012_0_19_O
    );
  XLXI_10_I1_n0009_0_1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0009_0_1_O,
      O => XLXI_10_I1_n0009(0)
    );
  XLXI_10_I1_n0009_0_1 : X_LUT4
    generic map(
      INIT => X"4F40"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_0,
      ADR2 => XLXI_10_I1_n0016,
      ADR3 => XLXI_10_I1_stack_addrs_c_3_0,
      O => XLXI_10_I1_n0009_0_1_O
    );
  XLXI_3_Ker69031_SW5_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW5_O,
      O => N24807
    );
  XLXI_3_Ker69031_SW5 : X_LUT4
    generic map(
      INIT => X"2373"
    )
    port map (
      ADR0 => N23342,
      ADR1 => XLXI_3_pwm_low(4),
      ADR2 => CPU_DADDR_2_OBUF,
      ADR3 => N25208,
      O => XLXI_3_Ker69031_SW5_O
    );
  XLXI_10_I1_iaddr_x_7_50_LUT4_D_BUF : X_BUF
    port map (
      I => CPU_IADDR_7_OBUF,
      O => N25278
    );
  XLXI_10_I1_iaddr_x_7_50 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => CHOICE1871,
      ADR2 => CHOICE1864,
      ADR3 => XLXI_10_pc_mux(2),
      O => CPU_IADDR_7_OBUF
    );
  XLXI_3_n0006_5_1_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_3_n0006_5_1_O,
      O => XLXI_3_n0006(5)
    );
  XLXI_3_n0006_5_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_3_N6924,
      ADR1 => XLXI_3_pwm_period(5),
      ADR2 => XLXI_2_pwm_data_c(1),
      O => XLXI_3_n0006_5_1_O
    );
  XLXI_3_n0006_6_1_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_3_n0006_6_1_O,
      O => XLXI_3_n0006(6)
    );
  XLXI_3_n0006_6_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_3_N6924,
      ADR1 => XLXI_3_pwm_period(6),
      ADR2 => XLXI_2_pwm_data_c(2),
      O => XLXI_3_n0006_6_1_O
    );
  XLXI_3_n0006_7_1_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_3_n0006_7_1_O,
      O => XLXI_3_n0006(7)
    );
  XLXI_3_n0006_7_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_3_N6924,
      ADR1 => XLXI_3_pwm_period(7),
      ADR2 => XLXI_2_pwm_data_c(3),
      O => XLXI_3_n0006_7_1_O
    );
  XLXI_10_I3_n0035_0_107_SW0_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I3_n0035_0_107_SW0_O,
      O => N24691
    );
  XLXI_10_I3_n0035_0_107_SW0 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => XLXI_10_I3_N9047,
      ADR1 => CHOICE1984,
      ADR2 => CHOICE1966,
      ADR3 => XLXI_10_I3_N8884,
      O => XLXI_10_I3_n0035_0_107_SW0_O
    );
  XLXI_10_I3_n0035_3_109_SW0_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I3_n0035_3_109_SW0_O,
      O => N24697
    );
  XLXI_10_I3_n0035_3_109_SW0 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I3_N9047,
      ADR1 => CHOICE2167,
      ADR2 => CHOICE2187,
      ADR3 => XLXI_10_I2_TD_c(3),
      O => XLXI_10_I3_n0035_3_109_SW0_O
    );
  XLXI_10_I3_n0035_2_109_SW0_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I3_n0035_2_109_SW0_O,
      O => N24703
    );
  XLXI_10_I3_n0035_2_109_SW0 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I3_N9047,
      ADR1 => CHOICE2079,
      ADR2 => CHOICE2099,
      ADR3 => XLXI_10_I2_TD_c(3),
      O => XLXI_10_I3_n0035_2_109_SW0_O
    );
  XLXI_3_n0006_2_1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_3_n0006_2_1_O,
      O => XLXI_3_n0006(2)
    );
  XLXI_3_n0006_2_1 : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => XLXI_3_N6924,
      ADR1 => XLXI_3_pwm_period(2),
      ADR2 => XLXI_10_I3_acc_c_0_2,
      ADR3 => XLXI_10_I4_N9730,
      O => XLXI_3_n0006_2_1_O
    );
  XLXI_3_n0006_1_1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_3_n0006_1_1_O,
      O => XLXI_3_n0006(1)
    );
  XLXI_3_n0006_1_1 : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => XLXI_3_N6924,
      ADR1 => XLXI_3_pwm_period(1),
      ADR2 => XLXI_10_I3_acc_c_0_1,
      ADR3 => XLXI_10_I4_N9730,
      O => XLXI_3_n0006_1_1_O
    );
  XLXI_3_n0006_0_1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_3_n0006_0_1_O,
      O => XLXI_3_n0006(0)
    );
  XLXI_3_n0006_0_1 : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => XLXI_3_N6924,
      ADR1 => XLXI_3_pwm_period(0),
      ADR2 => XLXI_10_I3_acc_c_0_0,
      ADR3 => XLXI_10_I4_N9730,
      O => XLXI_3_n0006_0_1_O
    );
  XLXI_2_Mmux_n0021_Result_0_1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_2_Mmux_n0021_Result_0_1_O,
      O => XLXI_2_n0021(0)
    );
  XLXI_2_Mmux_n0021_Result_0_1 : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => XLXI_2_n0046,
      ADR1 => XLXI_2_pwm_data_c(0),
      ADR2 => XLXI_10_I3_acc_c_0_0,
      ADR3 => XLXI_10_I4_N9730,
      O => XLXI_2_Mmux_n0021_Result_0_1_O
    );
  XLXI_10_I1_n0012_7_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0012_7_19_O,
      O => XLXI_10_I1_n0012(7)
    );
  XLXI_10_I1_n0012_7_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25006,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_7,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0012_7_19_O
    );
  XLXI_3_n0006_4_1_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_3_n0006_4_1_O,
      O => XLXI_3_n0006(4)
    );
  XLXI_3_n0006_4_1 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_3_N6924,
      ADR1 => XLXI_3_pwm_period(4),
      ADR2 => XLXI_2_pwm_data_c(0),
      O => XLXI_3_n0006_4_1_O
    );
  XLXI_2_Mmux_n0021_Result_2_1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_2_Mmux_n0021_Result_2_1_O,
      O => XLXI_2_n0021(2)
    );
  XLXI_2_Mmux_n0021_Result_2_1 : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => XLXI_2_n0046,
      ADR1 => XLXI_2_pwm_data_c(2),
      ADR2 => XLXI_10_I3_acc_c_0_2,
      ADR3 => XLXI_10_I4_N9730,
      O => XLXI_2_Mmux_n0021_Result_2_1_O
    );
  XLXI_2_Mmux_n0021_Result_3_1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_2_Mmux_n0021_Result_3_1_O,
      O => XLXI_2_n0021(3)
    );
  XLXI_2_Mmux_n0021_Result_3_1 : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => XLXI_2_n0046,
      ADR1 => XLXI_2_pwm_data_c(3),
      ADR2 => XLXI_10_I3_acc_c_0_3,
      ADR3 => XLXI_10_I4_N9730,
      O => XLXI_2_Mmux_n0021_Result_3_1_O
    );
  XLXI_10_I1_n0010_4_19_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0010_4_19_O,
      O => XLXI_10_I1_n0010(4)
    );
  XLXI_10_I1_n0010_4_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N25002,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_4,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0010_4_19_O
    );
  XLXI_10_I1_n0010_5_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0010_5_19_SW0_O,
      O => N25066
    );
  XLXI_10_I1_n0010_5_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_5,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_5,
      O => XLXI_10_I1_n0010_5_19_SW0_O
    );
  XLXI_10_I1_n0012_6_19_SW0_LUT3_L_BUF : X_BUF
    port map (
      I => XLXI_10_I1_n0012_6_19_SW0_O,
      O => N25054
    );
  XLXI_10_I1_n0012_6_19_SW0 : X_LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_6,
      ADR2 => XLXI_10_I1_n0013(6),
      O => XLXI_10_I1_n0012_6_19_SW0_O
    );
  XLXI_2_Mmux_n0021_Result_1_1_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_2_Mmux_n0021_Result_1_1_O,
      O => XLXI_2_n0021(1)
    );
  XLXI_2_Mmux_n0021_Result_1_1 : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => XLXI_2_n0046,
      ADR1 => XLXI_2_pwm_data_c(1),
      ADR2 => XLXI_10_I3_acc_c_0_1,
      ADR3 => XLXI_10_I4_N9730,
      O => XLXI_2_Mmux_n0021_Result_1_1_O
    );
  XLXI_3_Ker69031_SW4_LUT4_L_BUF : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW4_O,
      O => N24803
    );
  XLXI_3_Ker69031_SW4 : X_LUT4
    generic map(
      INIT => X"2373"
    )
    port map (
      ADR0 => N23342,
      ADR1 => XLXI_3_pwm_low(5),
      ADR2 => CPU_DADDR_2_OBUF,
      ADR3 => N25212,
      O => XLXI_3_Ker69031_SW4_O
    );
  XLXI_10_I5_Mmux_daddr_out_Result_3_1_LUT4_D_BUF : X_BUF
    port map (
      I => CPU_DADDR_3_OBUF,
      O => N25257
    );
  XLXI_10_I5_Mmux_daddr_out_Result_3_1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => XLXI_10_ndre_int,
      ADR1 => XLXI_10_I5_daddr_c(3),
      ADR2 => XLXI_10_I4_N9712,
      ADR3 => N24653,
      O => CPU_DADDR_3_OBUF
    );
  XLXI_10_I5_Mmux_daddr_out_Result_2_1_LUT4_D_BUF : X_BUF
    port map (
      I => CPU_DADDR_2_OBUF,
      O => N25255
    );
  XLXI_10_I5_Mmux_daddr_out_Result_2_1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => XLXI_10_ndre_int,
      ADR1 => XLXI_10_I5_daddr_c(2),
      ADR2 => XLXI_10_I4_N9712,
      ADR3 => N24649,
      O => CPU_DADDR_2_OBUF
    );
  XLXI_10_I5_Mmux_daddr_out_Result_4_1_LUT4_D_BUF : X_BUF
    port map (
      I => CPU_DADDR_4_OBUF,
      O => N25253
    );
  XLXI_10_I5_Mmux_daddr_out_Result_4_1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => XLXI_10_ndre_int,
      ADR1 => XLXI_10_I5_daddr_c(4),
      ADR2 => XLXI_10_I4_N9712,
      ADR3 => N24637,
      O => CPU_DADDR_4_OBUF
    );
  XLXI_3_Ker69031_LUT4_D_BUF : X_BUF
    port map (
      I => XLXI_3_N6905,
      O => N25251
    );
  XLXI_3_Ker69031 : X_LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      ADR0 => N24633,
      ADR1 => N23342,
      ADR2 => CPU_DADDR_3_OBUF,
      ADR3 => CPU_DADDR_2_OBUF,
      O => XLXI_3_N6905
    );
  XLXI_5_B5 : X_RAMB4_S16
    generic map(
      INIT_00 => X"004e0102000800b0002e01020151000a0031002a0031000a000900000031001a",
      INIT_01 => X"000000000000000000000068015800b0008e010200e800b0006e0102007800b0",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"00000000000000c00101001a0141002a0151000a0121000a0131001a0101000a",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"014100aa01c80101001c0030002a0141006a01c80101001c0030001a0141002a",
      INIT_09 => X"006800000031000201c80101001c0030004a014100ea01c80101001c0030003a",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
    port map (
      EN => XLXI_5_N1,
      CLK => CLK_BUFGP,
      RST => XLXI_5_N0,
      WE => XLXI_5_N0,
      GSR => GSR,
      DI(15) => XLXI_5_N0,
      DI(14) => XLXI_5_N0,
      DI(13) => XLXI_5_N0,
      DI(12) => XLXI_5_N0,
      DI(11) => XLXI_5_N0,
      DI(10) => XLXI_5_N0,
      DI(9) => XLXI_5_N0,
      DI(8) => XLXI_5_N0,
      DI(7) => XLXI_5_N0,
      DI(6) => XLXI_5_N0,
      DI(5) => XLXI_5_N0,
      DI(4) => XLXI_5_N0,
      DI(3) => XLXI_5_N0,
      DI(2) => XLXI_5_N0,
      DI(1) => XLXI_5_N0,
      DI(0) => XLXI_5_N0,
      ADDR(7) => CPU_IADDR_7_OBUF,
      ADDR(6) => CPU_IADDR_6_OBUF,
      ADDR(5) => CPU_IADDR_5_OBUF,
      ADDR(4) => CPU_IADDR_4_OBUF,
      ADDR(3) => CPU_IADDR_3_OBUF,
      ADDR(2) => CPU_IADDR_2_OBUF,
      ADDR(1) => CPU_IADDR_1_OBUF,
      ADDR(0) => CPU_IADDR_0_OBUF,
      DO(15) => NLW_XLXI_5_B5_DO_15_UNCONNECTED,
      DO(14) => NLW_XLXI_5_B5_DO_14_UNCONNECTED,
      DO(13) => NLW_XLXI_5_B5_DO_13_UNCONNECTED,
      DO(12) => NLW_XLXI_5_B5_DO_12_UNCONNECTED,
      DO(11) => NLW_XLXI_5_B5_DO_11_UNCONNECTED,
      DO(10) => NLW_XLXI_5_B5_DO_10_UNCONNECTED,
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
  XLXI_5_GND : X_ZERO
    port map (
      O => XLXI_5_N0
    );
  XLXI_5_VCC : X_ONE
    port map (
      O => XLXI_5_N1
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
      EN => XLXI_4_N1,
      CLK => CLK_BUFGP,
      RST => XLXI_4_N0,
      WE => XLXN_87,
      GSR => GSR,
      DI(3) => CPU_DATA_OUT_3_OBUF,
      DI(2) => CPU_DATA_OUT_2_OBUF,
      DI(1) => CPU_DATA_OUT_1_OBUF,
      DI(0) => CPU_DATA_OUT_0_OBUF,
      ADDR(9) => XLXI_4_N0,
      ADDR(8) => XLXI_4_N0,
      ADDR(7) => XLXI_4_N0,
      ADDR(6) => XLXI_4_N0,
      ADDR(5) => XLXI_4_N0,
      ADDR(4) => XLXI_4_N0,
      ADDR(3) => CPU_DADDR_3_OBUF,
      ADDR(2) => CPU_DADDR_2_OBUF,
      ADDR(1) => CPU_DADDR_1_OBUF,
      ADDR(0) => CPU_DADDR_0_OBUF,
      DO(3) => RAM_DATA_OUT(3),
      DO(2) => RAM_DATA_OUT(2),
      DO(1) => RAM_DATA_OUT(1),
      DO(0) => RAM_DATA_OUT(0)
    );
  XLXI_4_GND : X_ZERO
    port map (
      O => XLXI_4_N0
    );
  XLXI_4_VCC : X_ONE
    port map (
      O => XLXI_4_N1
    );
  CLK_BUFGP_BUFG : X_CKBUF
    port map (
      I => CLK_BUFGP_IBUFG,
      O => CLK_BUFGP
    );
  CLK_BUFGP_IBUFG_150 : X_CKBUF
    port map (
      I => CLK,
      O => CLK_BUFGP_IBUFG
    );
  XLXI_10_I5_daddr_c_2_GSR_OR_151 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I5_daddr_c_2_GSR_OR
    );
  XLXI_10_I5_daddr_c_3_GSR_OR_152 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I5_daddr_c_3_GSR_OR
    );
  XLXI_10_I5_ndwe_c_GSR_OR_153 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I5_ndwe_c_GSR_OR
    );
  XLXI_10_I5_daddr_c_5_GSR_OR_154 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I5_daddr_c_5_GSR_OR
    );
  XLXI_10_I5_daddr_c_4_GSR_OR_155 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I5_daddr_c_4_GSR_OR
    );
  XLXI_10_I5_daddr_c_0_GSR_OR_156 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I5_daddr_c_0_GSR_OR
    );
  XLXI_10_I5_daddr_c_1_GSR_OR_157 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I5_daddr_c_1_GSR_OR
    );
  XLXI_10_I1_pc_4_GSR_OR_158 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I1_pc_4_GSR_OR
    );
  XLXI_10_I1_pc_5_GSR_OR_159 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I1_pc_5_GSR_OR
    );
  XLXI_10_I1_pc_2_GSR_OR_160 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I1_pc_2_GSR_OR
    );
  XLXI_10_I1_pc_3_GSR_OR_161 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I1_pc_3_GSR_OR
    );
  XLXI_10_I1_nreset_v_1_GSR_OR_162 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I1_nreset_v_1_GSR_OR
    );
  XLXI_10_I1_pc_7_GSR_OR_163 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I1_pc_7_GSR_OR
    );
  XLXI_10_I1_nreset_v_0_GSR_OR_164 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I1_nreset_v_0_GSR_OR
    );
  XLXI_10_I1_pc_6_GSR_OR_165 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I1_pc_6_GSR_OR
    );
  XLXI_10_I1_pc_0_GSR_OR_166 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I1_pc_0_GSR_OR
    );
  XLXI_10_I1_pc_1_GSR_OR_167 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I1_pc_1_GSR_OR
    );
  XLXI_10_I2_skip_c_GSR_OR_168 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I2_skip_c_GSR_OR
    );
  XLXI_10_I2_TD_c_0_GSR_OR_169 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I2_TD_c_0_GSR_OR
    );
  XLXI_10_I2_TD_c_2_GSR_OR_170 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I2_TD_c_2_GSR_OR
    );
  XLXI_10_I2_data_is_c_1_GSR_OR_171 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I2_data_is_c_1_GSR_OR
    );
  XLXI_10_I2_TD_c_1_GSR_OR_172 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I2_TD_c_1_GSR_OR
    );
  XLXI_10_I2_TC_c_0_GSR_OR_173 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I2_TC_c_0_GSR_OR
    );
  XLXI_10_I2_valid_c_GSR_OR_174 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I2_valid_c_GSR_OR
    );
  XLXI_10_I2_nreset_v_0_GSR_OR_175 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I2_nreset_v_0_GSR_OR
    );
  XLXI_10_I2_data_is_c_2_GSR_OR_176 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I2_data_is_c_2_GSR_OR
    );
  XLXI_10_I2_nreset_v_1_GSR_OR_177 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I2_nreset_v_1_GSR_OR
    );
  XLXI_10_I2_TD_c_3_GSR_OR_178 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I2_TD_c_3_GSR_OR
    );
  XLXI_10_I2_TC_c_2_GSR_OR_179 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I2_TC_c_2_GSR_OR
    );
  XLXI_10_I2_TC_c_1_GSR_OR_180 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I2_TC_c_1_GSR_OR
    );
  XLXI_10_I2_data_is_c_0_GSR_OR_181 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I2_data_is_c_0_GSR_OR
    );
  XLXI_10_I2_data_is_c_3_GSR_OR_182 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I2_data_is_c_3_GSR_OR
    );
  XLXI_10_I3_acc_c_0_4_GSR_OR_183 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I3_acc_c_0_4_GSR_OR
    );
  XLXI_10_I3_nreset_v_1_GSR_OR_184 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I3_nreset_v_1_GSR_OR
    );
  XLXI_10_I3_acc_c_0_1_GSR_OR_185 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I3_acc_c_0_1_GSR_OR
    );
  XLXI_10_I3_acc_c_0_2_GSR_OR_186 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I3_acc_c_0_2_GSR_OR
    );
  XLXI_10_I3_acc_c_0_0_GSR_OR_187 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I3_acc_c_0_0_GSR_OR
    );
  XLXI_10_I3_acc_c_0_3_GSR_OR_188 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I3_acc_c_0_3_GSR_OR
    );
  XLXI_10_I3_nreset_v_0_GSR_OR_189 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I3_nreset_v_0_GSR_OR
    );
  XLXI_10_I4_ipage_c_0_GSR_OR_190 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I4_ipage_c_0_GSR_OR
    );
  XLXI_10_I4_nreset_v_1_GSR_OR_191 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I4_nreset_v_1_GSR_OR
    );
  XLXI_10_I4_ipage_we_c_GSR_OR_192 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I4_ipage_we_c_GSR_OR
    );
  XLXI_10_I4_ipage_c_1_GSR_OR_193 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I4_ipage_c_1_GSR_OR
    );
  XLXI_10_I4_nreset_v_0_GSR_OR_194 : X_OR2
    port map (
      I0 => XLXI_10_I5_ndwe_c_N748,
      I1 => GSR,
      O => XLXI_10_I4_nreset_v_0_GSR_OR
    );
  CTRL_DATA_OUT_0_OBUF_GTS_TRI_195 : X_TRI
    port map (
      I => CTRL_DATA_OUT_0_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CTRL_DATA_OUT_0_OBUF_GTS_TRI_CTL,
      O => CTRL_DATA_OUT(0)
    );
  CPU_IADDR_0_OBUF_GTS_TRI_196 : X_TRI
    port map (
      I => CPU_IADDR_0_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_IADDR_0_OBUF_GTS_TRI_CTL,
      O => CPU_IADDR(0)
    );
  CTRL_DATA_OUT_3_OBUF_GTS_TRI_197 : X_TRI
    port map (
      I => CTRL_DATA_OUT_3_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CTRL_DATA_OUT_3_OBUF_GTS_TRI_CTL,
      O => CTRL_DATA_OUT(3)
    );
  CPU_IADDR_2_OBUF_GTS_TRI_198 : X_TRI
    port map (
      I => CPU_IADDR_2_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_IADDR_2_OBUF_GTS_TRI_CTL,
      O => CPU_IADDR(2)
    );
  CTRL_DATA_OUT_2_OBUF_GTS_TRI_199 : X_TRI
    port map (
      I => CTRL_DATA_OUT_2_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CTRL_DATA_OUT_2_OBUF_GTS_TRI_CTL,
      O => CTRL_DATA_OUT(2)
    );
  CPU_DADDR_2_OBUF_GTS_TRI_200 : X_TRI
    port map (
      I => CPU_DADDR_2_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_DADDR_2_OBUF_GTS_TRI_CTL,
      O => CPU_DADDR(2)
    );
  CTRL_DATA_OUT_1_OBUF_GTS_TRI_201 : X_TRI
    port map (
      I => CTRL_DATA_OUT_1_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CTRL_DATA_OUT_1_OBUF_GTS_TRI_CTL,
      O => CTRL_DATA_OUT(1)
    );
  CPU_DADDR_3_OBUF_GTS_TRI_202 : X_TRI
    port map (
      I => CPU_DADDR_3_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_DADDR_3_OBUF_GTS_TRI_CTL,
      O => CPU_DADDR(3)
    );
  CPU_DADDR_0_OBUF_GTS_TRI_203 : X_TRI
    port map (
      I => CPU_DADDR_0_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_DADDR_0_OBUF_GTS_TRI_CTL,
      O => CPU_DADDR(0)
    );
  CPU_DADDR_4_OBUF_GTS_TRI_204 : X_TRI
    port map (
      I => CPU_DADDR_4_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_DADDR_4_OBUF_GTS_TRI_CTL,
      O => CPU_DADDR(4)
    );
  CPU_DADDR_1_OBUF_GTS_TRI_205 : X_TRI
    port map (
      I => CPU_DADDR_1_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_DADDR_1_OBUF_GTS_TRI_CTL,
      O => CPU_DADDR(1)
    );
  CPU_DADDR_5_OBUF_GTS_TRI_206 : X_TRI
    port map (
      I => CPU_DADDR_5_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_DADDR_5_OBUF_GTS_TRI_CTL,
      O => CPU_DADDR(5)
    );
  CPU_IADDR_1_OBUF_GTS_TRI_207 : X_TRI
    port map (
      I => CPU_IADDR_1_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_IADDR_1_OBUF_GTS_TRI_CTL,
      O => CPU_IADDR(1)
    );
  PWM_OUT_OBUF_GTS_TRI_208 : X_TRI
    port map (
      I => PWM_OUT_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_PWM_OUT_OBUF_GTS_TRI_CTL,
      O => PWM_OUT
    );
  nWE_CPU_OBUF_GTS_TRI_209 : X_TRI
    port map (
      I => nWE_CPU_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_nWE_CPU_OBUF_GTS_TRI_CTL,
      O => nWE_CPU
    );
  nRE_CPU_OBUF_GTS_TRI_210 : X_TRI
    port map (
      I => nRE_CPU_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_nRE_CPU_OBUF_GTS_TRI_CTL,
      O => nRE_CPU
    );
  CPU_DATA_OUT_3_OBUF_GTS_TRI_211 : X_TRI
    port map (
      I => CPU_DATA_OUT_3_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_DATA_OUT_3_OBUF_GTS_TRI_CTL,
      O => CPU_DATA_OUT(3)
    );
  CPU_DATA_OUT_2_OBUF_GTS_TRI_212 : X_TRI
    port map (
      I => CPU_DATA_OUT_2_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_DATA_OUT_2_OBUF_GTS_TRI_CTL,
      O => CPU_DATA_OUT(2)
    );
  CPU_DATA_OUT_1_OBUF_GTS_TRI_213 : X_TRI
    port map (
      I => CPU_DATA_OUT_1_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_DATA_OUT_1_OBUF_GTS_TRI_CTL,
      O => CPU_DATA_OUT(1)
    );
  CPU_DATA_OUT_0_OBUF_GTS_TRI_214 : X_TRI
    port map (
      I => CPU_DATA_OUT_0_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_DATA_OUT_0_OBUF_GTS_TRI_CTL,
      O => CPU_DATA_OUT(0)
    );
  CPU_IADDR_7_OBUF_GTS_TRI_215 : X_TRI
    port map (
      I => CPU_IADDR_7_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_IADDR_7_OBUF_GTS_TRI_CTL,
      O => CPU_IADDR(7)
    );
  CPU_IADDR_6_OBUF_GTS_TRI_216 : X_TRI
    port map (
      I => CPU_IADDR_6_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_IADDR_6_OBUF_GTS_TRI_CTL,
      O => CPU_IADDR(6)
    );
  CPU_IADDR_5_OBUF_GTS_TRI_217 : X_TRI
    port map (
      I => CPU_IADDR_5_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_IADDR_5_OBUF_GTS_TRI_CTL,
      O => CPU_IADDR(5)
    );
  CPU_IADDR_4_OBUF_GTS_TRI_218 : X_TRI
    port map (
      I => CPU_IADDR_4_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_IADDR_4_OBUF_GTS_TRI_CTL,
      O => CPU_IADDR(4)
    );
  CPU_IADDR_3_OBUF_GTS_TRI_219 : X_TRI
    port map (
      I => CPU_IADDR_3_OBUF_GTS_TRI,
      CTL => NlwInverterSignal_CPU_IADDR_3_OBUF_GTS_TRI_CTL,
      O => CPU_IADDR(3)
    );
  NlwBlock_cpu4bit_VCC : X_ONE
    port map (
      O => VCC
    );
  NlwBlock_cpu4bit_GND : X_ZERO
    port map (
      O => GND
    );
  NlwInverterBlock_CTRL_DATA_OUT_0_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CTRL_DATA_OUT_0_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_IADDR_0_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_IADDR_0_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CTRL_DATA_OUT_3_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CTRL_DATA_OUT_3_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_IADDR_2_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_IADDR_2_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CTRL_DATA_OUT_2_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CTRL_DATA_OUT_2_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_DADDR_2_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_DADDR_2_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CTRL_DATA_OUT_1_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CTRL_DATA_OUT_1_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_DADDR_3_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_DADDR_3_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_DADDR_0_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_DADDR_0_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_DADDR_4_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_DADDR_4_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_DADDR_1_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_DADDR_1_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_DADDR_5_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_DADDR_5_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_IADDR_1_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_IADDR_1_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_PWM_OUT_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_PWM_OUT_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_nWE_CPU_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_nWE_CPU_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_nRE_CPU_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_nRE_CPU_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_DATA_OUT_3_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_DATA_OUT_3_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_DATA_OUT_2_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_DATA_OUT_2_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_DATA_OUT_1_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_DATA_OUT_1_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_DATA_OUT_0_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_DATA_OUT_0_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_IADDR_7_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_IADDR_7_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_IADDR_6_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_IADDR_6_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_IADDR_5_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_IADDR_5_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_IADDR_4_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_IADDR_4_OBUF_GTS_TRI_CTL
    );
  NlwInverterBlock_CPU_IADDR_3_OBUF_GTS_TRI_CTL : X_INV
    port map (
      I => GTS,
      O => NlwInverterSignal_CPU_IADDR_3_OBUF_GTS_TRI_CTL
    );
  NlwBlockROC : X_ROC
    generic map (ROC_WIDTH => 100 ns)
    port map (O => GSR);
  NlwBlockTOC : X_TOC
    port map (O => GTS);

end Structure;

