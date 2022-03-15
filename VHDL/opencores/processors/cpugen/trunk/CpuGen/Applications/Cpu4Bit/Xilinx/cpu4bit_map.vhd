-- Xilinx Vhdl netlist produced by netgen application (version G.25a)
-- Command       : -intstyle ise -s 5 -pcf cpu4bit.pcf -ngm cpu4bit.ngm -rpw 100 -tpw 0 -ar Structure -xon true -w -ofmt vhdl -sim cpu4bit_map.ncd cpu4bit_map.vhd 
-- Input file    : cpu4bit_map.ncd
-- Output file   : cpu4bit_map.vhd
-- Design name   : cpu4bit
-- # of Entities : 1
-- Xilinx        : C:/Xilinx
-- Device        : 2s30cs144-5 (PRODUCTION 1.27 2003-09-30)

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
  signal XLXI_2_n0043 : STD_LOGIC; 
  signal CPU_DATA_OUT_1_OBUF : STD_LOGIC; 
  signal NRESET_IBUF : STD_LOGIC; 
  signal CPU_DADDR_0_OBUF : STD_LOGIC; 
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
  signal XLXI_10_I3_acc_c_0_1 : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_0 : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_4 : STD_LOGIC; 
  signal N24977 : STD_LOGIC; 
  signal CHOICE1966 : STD_LOGIC; 
  signal XLXI_10_I3_N9047 : STD_LOGIC; 
  signal CHOICE1984 : STD_LOGIC; 
  signal XLXI_10_I3_N8884 : STD_LOGIC; 
  signal N24693 : STD_LOGIC; 
  signal CHOICE2079 : STD_LOGIC; 
  signal XLXI_10_I2_valid_c : STD_LOGIC; 
  signal CHOICE2099 : STD_LOGIC; 
  signal N24705 : STD_LOGIC; 
  signal CHOICE2013 : STD_LOGIC; 
  signal CHOICE2025 : STD_LOGIC; 
  signal N24687 : STD_LOGIC; 
  signal CHOICE2035 : STD_LOGIC; 
  signal CHOICE2055 : STD_LOGIC; 
  signal N24711 : STD_LOGIC; 
  signal CHOICE2167 : STD_LOGIC; 
  signal CHOICE2187 : STD_LOGIC; 
  signal N24699 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_25 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_27 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_29 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_31 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_9 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_11 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_13 : STD_LOGIC; 
  signal XLXI_3_n0015 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_9 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_11 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_13 : STD_LOGIC; 
  signal XLXI_3_n0016 : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_1 : STD_LOGIC; 
  signal GLOBAL_LOGIC1 : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_3 : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_5 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_cy_37 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_lut2_36 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_lut2_37 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_cy_39 : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_2 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_lut2_38 : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_3 : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_lut2_39 : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_cy_33 : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_lut2_32 : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_lut2_33 : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_lut2_34 : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_lut2_35 : STD_LOGIC; 
  signal XLXI_3_pwm_count_Madd_n0000_inst_cy_1 : STD_LOGIC; 
  signal XLXI_3_n0007 : STD_LOGIC; 
  signal XLXI_3_pwm_count_Madd_n0000_inst_cy_3 : STD_LOGIC; 
  signal XLXI_3_pwm_count_Madd_n0000_inst_cy_5 : STD_LOGIC; 
  signal XLXI_3_n0026 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_17 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_16 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_17 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_19 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_18 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_19 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_21 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_20 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_21 : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_22 : STD_LOGIC; 
  signal XLXI_3_N6905 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_25 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_27 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_29 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_31 : STD_LOGIC; 
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
  signal XLXI_10_I2_N8359 : STD_LOGIC; 
  signal XLXI_10_I2_N8283 : STD_LOGIC; 
  signal N22263 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_1 : STD_LOGIC; 
  signal XLXI_10_I1_n0016 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_1 : STD_LOGIC; 
  signal N25128 : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_0_31_O : STD_LOGIC; 
  signal CHOICE1924 : STD_LOGIC; 
  signal N25132 : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_1_31_O : STD_LOGIC; 
  signal CHOICE1819 : STD_LOGIC; 
  signal N25136 : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_2_31_O : STD_LOGIC; 
  signal CHOICE1834 : STD_LOGIC; 
  signal N25140 : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_3_31_O : STD_LOGIC; 
  signal CHOICE1909 : STD_LOGIC; 
  signal N25144 : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_4_31_O : STD_LOGIC; 
  signal CHOICE1894 : STD_LOGIC; 
  signal N25148 : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_5_31_O : STD_LOGIC; 
  signal CHOICE1879 : STD_LOGIC; 
  signal N25152 : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_6_31_O : STD_LOGIC; 
  signal CHOICE1849 : STD_LOGIC; 
  signal N25156 : STD_LOGIC; 
  signal XLXI_10_I1_iaddr_x_7_31_O : STD_LOGIC; 
  signal CHOICE1864 : STD_LOGIC; 
  signal N24084 : STD_LOGIC; 
  signal N24761 : STD_LOGIC; 
  signal XLXI_10_ndre_int : STD_LOGIC; 
  signal XLXI_10_I4_N9712 : STD_LOGIC; 
  signal N24653 : STD_LOGIC; 
  signal N25166 : STD_LOGIC; 
  signal XLXI_2_n0042 : STD_LOGIC; 
  signal XLXI_2_n0046 : STD_LOGIC; 
  signal XLXI_10_I4_N9730 : STD_LOGIC; 
  signal CHOICE2088 : STD_LOGIC; 
  signal XLXI_10_I3_n0035_2_109_SW0_O : STD_LOGIC; 
  signal N25174 : STD_LOGIC; 
  signal CHOICE2073 : STD_LOGIC; 
  signal CHOICE2067 : STD_LOGIC; 
  signal CHOICE2070 : STD_LOGIC; 
  signal CHOICE2062 : STD_LOGIC; 
  signal XLXI_10_I3_N9013 : STD_LOGIC; 
  signal XLXI_10_I3_N9052 : STD_LOGIC; 
  signal XLXI_10_I3_n0037 : STD_LOGIC; 
  signal N23412 : STD_LOGIC; 
  signal XLXI_10_I4_N9697 : STD_LOGIC; 
  signal CHOICE2176 : STD_LOGIC; 
  signal XLXI_10_I3_n0035_3_109_SW0_O : STD_LOGIC; 
  signal N25184 : STD_LOGIC; 
  signal N23016 : STD_LOGIC; 
  signal N21724 : STD_LOGIC; 
  signal N24783 : STD_LOGIC; 
  signal N24847 : STD_LOGIC; 
  signal CHOICE2128 : STD_LOGIC; 
  signal N24745 : STD_LOGIC; 
  signal CHOICE2131 : STD_LOGIC; 
  signal N24743 : STD_LOGIC; 
  signal N24787 : STD_LOGIC; 
  signal N24851 : STD_LOGIC; 
  signal N24675 : STD_LOGIC; 
  signal N24667 : STD_LOGIC; 
  signal N24633 : STD_LOGIC; 
  signal N23342 : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW0_O : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW1_O : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW2_O : STD_LOGIC; 
  signal N24641 : STD_LOGIC; 
  signal N24637 : STD_LOGIC; 
  signal N24767 : STD_LOGIC; 
  signal XLXI_2_nCS_PWM_SW0_SW0_O : STD_LOGIC; 
  signal XLXI_3_N6924 : STD_LOGIC; 
  signal N24669 : STD_LOGIC; 
  signal CHOICE1448 : STD_LOGIC; 
  signal CHOICE1457 : STD_LOGIC; 
  signal XLXI_10_I3_n0045 : STD_LOGIC; 
  signal XLXI_10_I3_n0054 : STD_LOGIC; 
  signal XLXI_10_I3_N9064 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_0 : STD_LOGIC; 
  signal XLXI_10_I1_n0012_0_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_0 : STD_LOGIC; 
  signal XLXI_10_I1_n0011_1_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_2 : STD_LOGIC; 
  signal XLXI_10_I1_n0011_2_19_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_3 : STD_LOGIC; 
  signal XLXI_10_I1_n0011_3_19_SW0_O : STD_LOGIC; 
  signal N25058 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_0 : STD_LOGIC; 
  signal N25006 : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_7 : STD_LOGIC; 
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
  signal XLXI_10_I3_N8915 : STD_LOGIC; 
  signal XLXI_10_I3_n0053 : STD_LOGIC; 
  signal XLXI_10_I3_n0035_0_27_O : STD_LOGIC; 
  signal XLXI_10_I3_n0055 : STD_LOGIC; 
  signal N24629 : STD_LOGIC; 
  signal CHOICE1956 : STD_LOGIC; 
  signal CHOICE2134 : STD_LOGIC; 
  signal CHOICE2123 : STD_LOGIC; 
  signal CHOICE1965 : STD_LOGIC; 
  signal N22203 : STD_LOGIC; 
  signal XLXI_10_I2_N8336 : STD_LOGIC; 
  signal XLXI_10_I3_n0073 : STD_LOGIC; 
  signal N25170 : STD_LOGIC; 
  signal XLXI_10_I3_n0048 : STD_LOGIC; 
  signal CHOICE2010 : STD_LOGIC; 
  signal XLXI_10_I3_n0035_4_11_SW1_O : STD_LOGIC; 
  signal N24827 : STD_LOGIC; 
  signal CHOICE1944 : STD_LOGIC; 
  signal XLXI_10_I3_n0035_0_107_SW0_O : STD_LOGIC; 
  signal CHOICE2036 : STD_LOGIC; 
  signal CHOICE2044 : STD_LOGIC; 
  signal CHOICE2032 : STD_LOGIC; 
  signal XLXI_10_I3_n0035_1_47_O : STD_LOGIC; 
  signal N24709 : STD_LOGIC; 
  signal CHOICE2076 : STD_LOGIC; 
  signal CHOICE2080 : STD_LOGIC; 
  signal XLXI_10_I3_n0035_2_47_SW0_O : STD_LOGIC; 
  signal CHOICE2164 : STD_LOGIC; 
  signal CHOICE2168 : STD_LOGIC; 
  signal XLXI_10_I3_n0035_3_47_SW0_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_7 : STD_LOGIC; 
  signal N25208 : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW5_O : STD_LOGIC; 
  signal N25212 : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW4_O : STD_LOGIC; 
  signal N25192 : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW3_O : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW9_O : STD_LOGIC; 
  signal N25196 : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW8_O : STD_LOGIC; 
  signal N25200 : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW7_O : STD_LOGIC; 
  signal N25204 : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW6_O : STD_LOGIC; 
  signal XLXI_2_n0020_SW0_O : STD_LOGIC; 
  signal XLXI_2_n0020 : STD_LOGIC; 
  signal XLXI_2_n0043_SW0_O : STD_LOGIC; 
  signal XLXI_2_n0046_SW0_O : STD_LOGIC; 
  signal XLXI_10_I2_skip_c : STD_LOGIC; 
  signal N24657 : STD_LOGIC; 
  signal N24649 : STD_LOGIC; 
  signal XLXI_3_n0003 : STD_LOGIC; 
  signal XLXI_10_I2_N8327 : STD_LOGIC; 
  signal CHOICE1708 : STD_LOGIC; 
  signal XLXI_10_I2_N8267 : STD_LOGIC; 
  signal N24038 : STD_LOGIC; 
  signal nCS_PWM : STD_LOGIC; 
  signal XLXI_10_I3_n00441_O : STD_LOGIC; 
  signal CHOICE2148 : STD_LOGIC; 
  signal CHOICE2161 : STD_LOGIC; 
  signal XLXI_10_I3_skip_l90_O : STD_LOGIC; 
  signal CHOICE2155 : STD_LOGIC; 
  signal XLXI_10_ndwe_int : STD_LOGIC; 
  signal XLXI_10_I4_ipage_we_c : STD_LOGIC; 
  signal XLXI_10_I4_n0044 : STD_LOGIC; 
  signal XLXI_10_I3_n0052 : STD_LOGIC; 
  signal XLXI_10_I3_n0062 : STD_LOGIC; 
  signal CHOICE1982 : STD_LOGIC; 
  signal CHOICE1762 : STD_LOGIC; 
  signal CHOICE1740 : STD_LOGIC; 
  signal XLXI_10_I3_N8904 : STD_LOGIC; 
  signal N25086 : STD_LOGIC; 
  signal N24779 : STD_LOGIC; 
  signal N24645 : STD_LOGIC; 
  signal N24681 : STD_LOGIC; 
  signal N24679 : STD_LOGIC; 
  signal N25078 : STD_LOGIC; 
  signal CHOICE1750 : STD_LOGIC; 
  signal N20151 : STD_LOGIC; 
  signal XLXI_10_I3_N8934 : STD_LOGIC; 
  signal N25098 : STD_LOGIC; 
  signal N24773 : STD_LOGIC; 
  signal N24771 : STD_LOGIC; 
  signal N24757 : STD_LOGIC; 
  signal N25102 : STD_LOGIC; 
  signal N24989 : STD_LOGIC; 
  signal N24685 : STD_LOGIC; 
  signal N24777 : STD_LOGIC; 
  signal XLXI_3_n0027 : STD_LOGIC; 
  signal N24755 : STD_LOGIC; 
  signal N25042 : STD_LOGIC; 
  signal N24985 : STD_LOGIC; 
  signal CHOICE1786 : STD_LOGIC; 
  signal CHOICE1759 : STD_LOGIC; 
  signal CHOICE1767 : STD_LOGIC; 
  signal CHOICE1791 : STD_LOGIC; 
  signal CHOICE1745 : STD_LOGIC; 
  signal N24751 : STD_LOGIC; 
  signal N24843 : STD_LOGIC; 
  signal N25117 : STD_LOGIC; 
  signal N24749 : STD_LOGIC; 
  signal N24981 : STD_LOGIC; 
  signal CHOICE1444 : STD_LOGIC; 
  signal N24841 : STD_LOGIC; 
  signal N21781 : STD_LOGIC; 
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
  signal N25248 : STD_LOGIC; 
  signal N25246 : STD_LOGIC; 
  signal N24977_F5MUX : STD_LOGIC; 
  signal N25223 : STD_LOGIC; 
  signal N25221 : STD_LOGIC; 
  signal N24693_F5MUX : STD_LOGIC; 
  signal N25228 : STD_LOGIC; 
  signal N25226 : STD_LOGIC; 
  signal N24705_F5MUX : STD_LOGIC; 
  signal N25238 : STD_LOGIC; 
  signal N25236 : STD_LOGIC; 
  signal N24687_F5MUX : STD_LOGIC; 
  signal N25233 : STD_LOGIC; 
  signal N25231 : STD_LOGIC; 
  signal N24711_F5MUX : STD_LOGIC; 
  signal N25243 : STD_LOGIC; 
  signal N25241 : STD_LOGIC; 
  signal N24699_F5MUX : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_lut2_24 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_25_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_lut2_25 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_24 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_25_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_lut2_26 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_27_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_lut2_27 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_26 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_27_CYINIT : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_lut2_28 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_29_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_lut2_29 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_28 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_29_CYINIT : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_lut2_30 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_31_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_lut2_31 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_30 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0014_inst_cy_31_CYINIT : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_lut2_8 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_9_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_lut2_9 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_8 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_9_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_lut2_10 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_11_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_lut2_11 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_10 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_11_CYINIT : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_lut2_12 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_13_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_lut2_13 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_12 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_13_CYINIT : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_lut2_14 : STD_LOGIC; 
  signal XLXI_3_n0015_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_lut2_15 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0015_inst_cy_14 : STD_LOGIC; 
  signal XLXI_3_n0015_CYINIT : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_lut2_8 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_9_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_lut2_9 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_8 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_9_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_lut2_10 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_11_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_lut2_11 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_10 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_11_CYINIT : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_lut2_12 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_13_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_lut2_13 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_12 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_13_CYINIT : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_lut2_14 : STD_LOGIC; 
  signal XLXI_3_n0016_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_lut2_15 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0016_inst_cy_14 : STD_LOGIC; 
  signal XLXI_3_n0016_CYINIT : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_lut2_0 : STD_LOGIC; 
  signal XLXI_10_I1_n0013_1_CYMUXG : STD_LOGIC; 
  signal XLXI_10_I1_n0013_1_XORG : STD_LOGIC; 
  signal XLXI_10_I1_n0013_1_GROM : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_0 : STD_LOGIC; 
  signal XLXI_10_I1_n0013_1_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_10_I1_n0013_2_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0013_2_XORF : STD_LOGIC; 
  signal XLXI_10_I1_n0013_2_CYMUXG : STD_LOGIC; 
  signal XLXI_10_I1_n0013_2_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_10_I1_n0013_2_XORG : STD_LOGIC; 
  signal XLXI_10_I1_n0013_2_GROM : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_2 : STD_LOGIC; 
  signal XLXI_10_I1_n0013_2_CYINIT : STD_LOGIC; 
  signal XLXI_10_I1_n0013_4_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0013_4_XORF : STD_LOGIC; 
  signal XLXI_10_I1_n0013_4_CYMUXG : STD_LOGIC; 
  signal XLXI_10_I1_n0013_4_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_10_I1_n0013_4_XORG : STD_LOGIC; 
  signal XLXI_10_I1_n0013_4_GROM : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_4 : STD_LOGIC; 
  signal XLXI_10_I1_n0013_4_CYINIT : STD_LOGIC; 
  signal XLXI_10_I1_n0013_6_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_10_I1_n0013_6_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0013_6_XORF : STD_LOGIC; 
  signal XLXI_10_I1_n0013_6_XORG : STD_LOGIC; 
  signal XLXI_10_I1_pc_7_rt : STD_LOGIC; 
  signal XLXI_10_I1_Madd_n0013_inst_cy_6 : STD_LOGIC; 
  signal XLXI_10_I1_n0013_6_CYINIT : STD_LOGIC; 
  signal XLXI_10_I3_n0059_0_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0059_0_XORF : STD_LOGIC; 
  signal XLXI_10_I3_n0059_0_CYMUXG : STD_LOGIC; 
  signal XLXI_10_I3_n0059_0_XORG : STD_LOGIC; 
  signal XLXI_10_I3_n0059_0_GROM : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_cy_36 : STD_LOGIC; 
  signal XLXI_10_I3_n0059_0_CYINIT : STD_LOGIC; 
  signal XLXI_10_I3_n0059_0_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_10_I3_n0059_2_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0059_2_XORF : STD_LOGIC; 
  signal XLXI_10_I3_n0059_2_CYMUXG : STD_LOGIC; 
  signal XLXI_10_I3_n0059_2_XORG : STD_LOGIC; 
  signal XLXI_10_I3_n0059_2_GROM : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_cy_38 : STD_LOGIC; 
  signal XLXI_10_I3_n0059_2_CYINIT : STD_LOGIC; 
  signal XLXI_10_I3_n0059_4_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0059_4_XORF : STD_LOGIC; 
  signal XLXI_10_I3_n0059_4_CYINIT : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_lut2_32_rt : STD_LOGIC; 
  signal XLXI_10_I3_n0064_1_CYMUXG : STD_LOGIC; 
  signal XLXI_10_I3_n0064_1_XORG : STD_LOGIC; 
  signal XLXI_10_I3_n0064_1_GROM : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_cy_32 : STD_LOGIC; 
  signal XLXI_10_I3_n0064_1_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_10_I3_n0064_2_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0064_2_XORF : STD_LOGIC; 
  signal XLXI_10_I3_n0064_2_CYMUXG : STD_LOGIC; 
  signal XLXI_10_I3_n0064_2_XORG : STD_LOGIC; 
  signal XLXI_10_I3_n0064_2_GROM : STD_LOGIC; 
  signal XLXI_10_I3_Madd_n0064_inst_cy_34 : STD_LOGIC; 
  signal XLXI_10_I3_n0064_2_CYINIT : STD_LOGIC; 
  signal XLXI_3_pwm_count_Madd_n0000_inst_lut2_0 : STD_LOGIC; 
  signal XLXI_3_pwm_count_0_CYMUXG : STD_LOGIC; 
  signal XLXI_3_pwm_count_0_GROM : STD_LOGIC; 
  signal XLXI_3_pwm_count_Madd_n0000_inst_cy_0 : STD_LOGIC; 
  signal XLXI_3_pwm_count_0_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_3_pwm_count_2_FROM : STD_LOGIC; 
  signal XLXI_3_pwm_count_2_CYMUXG : STD_LOGIC; 
  signal XLXI_3_pwm_count_2_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_3_pwm_count_2_GROM : STD_LOGIC; 
  signal XLXI_3_pwm_count_Madd_n0000_inst_cy_2 : STD_LOGIC; 
  signal XLXI_3_pwm_count_2_CYINIT : STD_LOGIC; 
  signal XLXI_3_pwm_count_4_FROM : STD_LOGIC; 
  signal XLXI_3_pwm_count_4_CYMUXG : STD_LOGIC; 
  signal XLXI_3_pwm_count_4_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_3_pwm_count_4_GROM : STD_LOGIC; 
  signal XLXI_3_pwm_count_Madd_n0000_inst_cy_4 : STD_LOGIC; 
  signal XLXI_3_pwm_count_4_CYINIT : STD_LOGIC; 
  signal XLXI_3_pwm_count_6_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_3_pwm_count_6_FROM : STD_LOGIC; 
  signal XLXI_3_pwm_count_7_rt : STD_LOGIC; 
  signal XLXI_3_pwm_count_Madd_n0000_inst_cy_6 : STD_LOGIC; 
  signal XLXI_3_pwm_count_6_CYINIT : STD_LOGIC; 
  signal XLXI_3_pwm_high_0_FROM : STD_LOGIC; 
  signal XLXI_3_pwm_high_0_CYMUXG : STD_LOGIC; 
  signal XLXI_3_pwm_high_0_GROM : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_16 : STD_LOGIC; 
  signal XLXI_3_pwm_high_0_CYINIT : STD_LOGIC; 
  signal XLXI_3_pwm_high_0_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_3_pwm_high_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_pwm_high_2_FROM : STD_LOGIC; 
  signal XLXI_3_pwm_high_2_CYMUXG : STD_LOGIC; 
  signal XLXI_3_pwm_high_2_GROM : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_18 : STD_LOGIC; 
  signal XLXI_3_pwm_high_2_CYINIT : STD_LOGIC; 
  signal XLXI_3_pwm_high_2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_pwm_high_4_FROM : STD_LOGIC; 
  signal XLXI_3_pwm_high_4_CYMUXG : STD_LOGIC; 
  signal XLXI_3_pwm_high_4_GROM : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_20 : STD_LOGIC; 
  signal XLXI_3_pwm_high_4_CYINIT : STD_LOGIC; 
  signal XLXI_3_pwm_high_4_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_pwm_high_6_FROM : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_lut2_231_O : STD_LOGIC; 
  signal XLXI_3_Msub_n0005_inst_cy_22 : STD_LOGIC; 
  signal XLXI_3_pwm_high_6_CYINIT : STD_LOGIC; 
  signal XLXI_3_pwm_high_6_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_lut2_24 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_25_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_lut2_25 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_24 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_25_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_lut2_26 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_27_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_lut2_27 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_26 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_27_CYINIT : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_lut2_28 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_29_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_lut2_29 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_28 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_29_CYINIT : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_lut2_30 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_31_CYMUXG : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_lut2_31 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_30 : STD_LOGIC; 
  signal XLXI_3_Mcompar_n0013_inst_cy_31_CYINIT : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_5_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0011_5_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_1_FFY_RST : STD_LOGIC; 
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
  signal XLXI_10_I2_N8359_FROM : STD_LOGIC; 
  signal XLXI_10_I2_N8359_GROM : STD_LOGIC; 
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
  signal N24761_FROM : STD_LOGIC; 
  signal N24761_GROM : STD_LOGIC; 
  signal CPU_DADDR_3_OBUF_FROM : STD_LOGIC; 
  signal CPU_DADDR_3_OBUF_GROM : STD_LOGIC; 
  signal XLXI_2_Mmux_n0021_Result_1_1_O : STD_LOGIC; 
  signal XLXI_2_pwm_data_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_2_Mmux_n0021_Result_0_1_O : STD_LOGIC; 
  signal XLXI_2_Mmux_n0021_Result_3_1_O : STD_LOGIC; 
  signal XLXI_2_pwm_data_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_2_Mmux_n0021_Result_2_1_O : STD_LOGIC; 
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
  signal CHOICE2131_FROM : STD_LOGIC; 
  signal CHOICE2131_GROM : STD_LOGIC; 
  signal CHOICE2070_FROM : STD_LOGIC; 
  signal CHOICE2070_GROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW0_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW0_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW1_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW1_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW2_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW2_O_GROM : STD_LOGIC; 
  signal XLXI_3_N6905_FROM : STD_LOGIC; 
  signal XLXI_3_N6905_GROM : STD_LOGIC; 
  signal XLXI_2_nCS_PWM_SW0_SW0_O_FROM : STD_LOGIC; 
  signal XLXI_2_nCS_PWM_SW0_SW0_O_GROM : STD_LOGIC; 
  signal XLXI_3_n0006_1_1_O : STD_LOGIC; 
  signal XLXI_3_n0006_0_1_O : STD_LOGIC; 
  signal XLXI_3_n0006_3_1_O : STD_LOGIC; 
  signal XLXI_3_n0006_2_1_O : STD_LOGIC; 
  signal XLXI_3_n0006_5_1_O : STD_LOGIC; 
  signal XLXI_3_n0006_4_1_O : STD_LOGIC; 
  signal XLXI_3_n0006_7_1_O : STD_LOGIC; 
  signal XLXI_3_n0006_6_1_O : STD_LOGIC; 
  signal CHOICE2128_FROM : STD_LOGIC; 
  signal CHOICE2128_GROM : STD_LOGIC; 
  signal CHOICE2067_FROM : STD_LOGIC; 
  signal CHOICE2067_GROM : STD_LOGIC; 
  signal XLXI_10_I3_N9064_FROM : STD_LOGIC; 
  signal XLXI_10_I3_N9064_GROM : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_0_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0012_0_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_1_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0011_1_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_2_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0011_2_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_3_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0011_3_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0010_0_19_O : STD_LOGIC; 
  signal XLXI_10_I1_n0012_7_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_4_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0011_4_19_O : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_1_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0010_1_19_O : STD_LOGIC; 
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
  signal XLXI_10_pc_mux_2_FROM : STD_LOGIC; 
  signal XLXI_10_pc_mux_2_GROM : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_4_FROM : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_4_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I3_n0035_4_96_O : STD_LOGIC; 
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
  signal XLXI_10_I3_n0062_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0062_GROM : STD_LOGIC; 
  signal CHOICE1982_FROM : STD_LOGIC; 
  signal CHOICE1982_GROM : STD_LOGIC; 
  signal CHOICE1762_FROM : STD_LOGIC; 
  signal CHOICE1762_GROM : STD_LOGIC; 
  signal N25128_FROM : STD_LOGIC; 
  signal N25128_GROM : STD_LOGIC; 
  signal XLXI_10_I2_data_is_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I2_data_is_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal CHOICE2164_FROM : STD_LOGIC; 
  signal CHOICE2164_GROM : STD_LOGIC; 
  signal CHOICE2010_FROM : STD_LOGIC; 
  signal CHOICE2010_GROM : STD_LOGIC; 
  signal CHOICE1740_FROM : STD_LOGIC; 
  signal CHOICE1740_GROM : STD_LOGIC; 
  signal XLXI_10_I3_N8904_FROM : STD_LOGIC; 
  signal XLXI_10_I3_N8904_GROM : STD_LOGIC; 
  signal XLXI_10_I3_N8915_FROM : STD_LOGIC; 
  signal XLXI_10_I3_N8915_GROM : STD_LOGIC; 
  signal CHOICE2155_FROM : STD_LOGIC; 
  signal CHOICE2155_GROM : STD_LOGIC; 
  signal CHOICE1984_FROM : STD_LOGIC; 
  signal CHOICE1984_GROM : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_7_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0011_7_19_O : STD_LOGIC; 
  signal CHOICE1965_FROM : STD_LOGIC; 
  signal CHOICE1965_GROM : STD_LOGIC; 
  signal N25152_FROM : STD_LOGIC; 
  signal N25152_GROM : STD_LOGIC; 
  signal N24779_FROM : STD_LOGIC; 
  signal N24779_GROM : STD_LOGIC; 
  signal N24653_FROM : STD_LOGIC; 
  signal N24653_GROM : STD_LOGIC; 
  signal N24641_FROM : STD_LOGIC; 
  signal N24641_GROM : STD_LOGIC; 
  signal N24645_FROM : STD_LOGIC; 
  signal N24645_GROM : STD_LOGIC; 
  signal XLXI_10_I4_n0044_FROM : STD_LOGIC; 
  signal XLXI_10_I4_n0044_GROM : STD_LOGIC; 
  signal XLXI_10_I3_Msub_n0059_inst_lut2_38_GROM : STD_LOGIC; 
  signal XLXI_3_pwm_low_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_pwm_low_7_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_0_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0011_0_19_O : STD_LOGIC; 
  signal CHOICE1750_FROM : STD_LOGIC; 
  signal CHOICE1750_GROM : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_0_FROM : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I5_ndwe_c_FROM : STD_LOGIC; 
  signal XLXI_10_I5_ndwe_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_nadwe_out : STD_LOGIC; 
  signal CHOICE2062_FROM : STD_LOGIC; 
  signal CHOICE2062_GROM : STD_LOGIC; 
  signal CHOICE2176_FROM : STD_LOGIC; 
  signal CHOICE2176_GROM : STD_LOGIC; 
  signal CHOICE1457_FROM : STD_LOGIC; 
  signal CHOICE1457_GROM : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_2_FROM : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I3_N8884_FROM : STD_LOGIC; 
  signal XLXI_10_I3_N8884_GROM : STD_LOGIC; 
  signal N24771_FROM : STD_LOGIC; 
  signal N24771_GROM : STD_LOGIC; 
  signal XLXI_3_n0026_FROM : STD_LOGIC; 
  signal XLXI_3_n0026_GROM : STD_LOGIC; 
  signal N25148_FROM : STD_LOGIC; 
  signal N25148_GROM : STD_LOGIC; 
  signal XLXI_2_mux_c_0_LOGIC_ONE : STD_LOGIC; 
  signal N24757_FROM : STD_LOGIC; 
  signal N24757_GROM : STD_LOGIC; 
  signal N25102_FROM : STD_LOGIC; 
  signal N25102_GROM : STD_LOGIC; 
  signal N24989_FROM : STD_LOGIC; 
  signal N24989_GROM : STD_LOGIC; 
  signal N24787_FROM : STD_LOGIC; 
  signal N24787_GROM : STD_LOGIC; 
  signal N24827_GROM : STD_LOGIC; 
  signal N24777_FROM : STD_LOGIC; 
  signal N24777_GROM : STD_LOGIC; 
  signal XLXI_10_I2_N8336_FROM : STD_LOGIC; 
  signal XLXI_10_I2_N8336_GROM : STD_LOGIC; 
  signal CPU_DADDR_4_OBUF_FROM : STD_LOGIC; 
  signal CPU_DADDR_4_OBUF_GROM : STD_LOGIC; 
  signal XLXI_10_I2_pc_mux_x_2_1_FROM : STD_LOGIC; 
  signal XLXI_10_I2_pc_mux_x_2_1_GROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW5_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW5_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW4_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW4_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW3_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW3_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW9_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW9_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW8_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW8_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW7_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW7_O_GROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW6_O_FROM : STD_LOGIC; 
  signal XLXI_3_Ker69031_SW6_O_GROM : STD_LOGIC; 
  signal XLXI_2_n0020_SW0_O_FROM : STD_LOGIC; 
  signal XLXI_2_n0020_SW0_O_GROM : STD_LOGIC; 
  signal XLXI_2_n0043_SW0_O_FROM : STD_LOGIC; 
  signal XLXI_2_n0043_SW0_O_GROM : STD_LOGIC; 
  signal XLXI_10_I2_pc_mux_x_2_2_FROM : STD_LOGIC; 
  signal XLXI_10_I2_pc_mux_x_2_2_GROM : STD_LOGIC; 
  signal XLXI_2_n0046_SW0_O_FROM : STD_LOGIC; 
  signal XLXI_2_n0046_SW0_O_GROM : STD_LOGIC; 
  signal XLXI_10_I4_N9730_FROM : STD_LOGIC; 
  signal XLXI_10_I4_N9730_GROM : STD_LOGIC; 
  signal N24084_FROM : STD_LOGIC; 
  signal N24084_GROM : STD_LOGIC; 
  signal CPU_DADDR_2_OBUF_FROM : STD_LOGIC; 
  signal CPU_DADDR_2_OBUF_GROM : STD_LOGIC; 
  signal XLXI_10_pc_mux_0_FROM : STD_LOGIC; 
  signal XLXI_10_pc_mux_0_GROM : STD_LOGIC; 
  signal N21724_FROM : STD_LOGIC; 
  signal N21724_GROM : STD_LOGIC; 
  signal XLXI_10_I2_N8327_FROM : STD_LOGIC; 
  signal XLXI_10_I2_N8327_GROM : STD_LOGIC; 
  signal nCS_PWM_FROM : STD_LOGIC; 
  signal nCS_PWM_GROM : STD_LOGIC; 
  signal XLXI_10_I3_n00441_O_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n00441_O_GROM : STD_LOGIC; 
  signal XLXI_10_I2_skip_c_FROM : STD_LOGIC; 
  signal XLXI_10_I2_skip_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I2_skip_c_GROM : STD_LOGIC; 
  signal XLXI_3_pwm_low_1_FROM : STD_LOGIC; 
  signal XLXI_3_pwm_low_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_pwm_low_1_GROM : STD_LOGIC; 
  signal XLXI_3_pwm_low_3_FROM : STD_LOGIC; 
  signal XLXI_3_pwm_low_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_pwm_low_3_GROM : STD_LOGIC; 
  signal XLXI_10_I4_ipage_we_c_FROM : STD_LOGIC; 
  signal XLXI_10_I4_ipage_we_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I4_ipage_we_x : STD_LOGIC; 
  signal XLXI_10_I4_ipage_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I2_valid_c_FROM : STD_LOGIC; 
  signal XLXI_10_I2_valid_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I2_valid_x : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_3_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_5_FROM : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_5_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I1_nreset_v_0_FROM : STD_LOGIC; 
  signal XLXI_10_I1_nreset_v_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I2_nreset_v_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I3_nreset_v_0_FROM : STD_LOGIC; 
  signal XLXI_10_I3_nreset_v_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I4_nreset_v_0_FROM : STD_LOGIC; 
  signal XLXI_10_I4_nreset_v_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_n0011_6_FROM : STD_LOGIC; 
  signal XLXI_3_n0011_6_GROM : STD_LOGIC; 
  signal XLXI_3_n0011_5_FROM : STD_LOGIC; 
  signal XLXI_3_n0011_5_GROM : STD_LOGIC; 
  signal XLXI_3_n0011_4_FROM : STD_LOGIC; 
  signal XLXI_3_n0011_4_GROM : STD_LOGIC; 
  signal N25196_FROM : STD_LOGIC; 
  signal N25196_GROM : STD_LOGIC; 
  signal N25200_GROM : STD_LOGIC; 
  signal CHOICE1448_FROM : STD_LOGIC; 
  signal CHOICE1448_GROM : STD_LOGIC; 
  signal XLXI_10_I3_n0037_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0037_GROM : STD_LOGIC; 
  signal XLXI_10_I3_n0048_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0048_GROM : STD_LOGIC; 
  signal XLXI_10_I3_n0053_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0053_GROM : STD_LOGIC; 
  signal XLXI_10_I3_n0055_FROM : STD_LOGIC; 
  signal XLXI_10_I3_n0055_GROM : STD_LOGIC; 
  signal XLXI_3_pwm_c_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_3_pwm_c_BYMUXNOT : STD_LOGIC; 
  signal N24675_FROM : STD_LOGIC; 
  signal N24675_GROM : STD_LOGIC; 
  signal N24755_FROM : STD_LOGIC; 
  signal N24755_GROM : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_7_FROM : STD_LOGIC; 
  signal XLXI_10_I1_n0010_7_19_O : STD_LOGIC; 
  signal N24985_FROM : STD_LOGIC; 
  signal N24985_GROM : STD_LOGIC; 
  signal CHOICE2161_FROM : STD_LOGIC; 
  signal CHOICE2161_GROM : STD_LOGIC; 
  signal XLXI_2_ctrl_data_c_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal nRE_CPU_OBUF_FROM : STD_LOGIC; 
  signal nRE_CPU_OBUF_GROM : STD_LOGIC; 
  signal CHOICE1786_FROM : STD_LOGIC; 
  signal CHOICE1786_GROM : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_0_FROM : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_0_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal N24685_FROM : STD_LOGIC; 
  signal N24685_GROM : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_1_FROM : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_2_FROM : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_2_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal N24751_FROM : STD_LOGIC; 
  signal N24751_GROM : STD_LOGIC; 
  signal N24843_FROM : STD_LOGIC; 
  signal N24843_GROM : STD_LOGIC; 
  signal N25117_FROM : STD_LOGIC; 
  signal N25117_GROM : STD_LOGIC; 
  signal N24749_FROM : STD_LOGIC; 
  signal N24749_GROM : STD_LOGIC; 
  signal N24981_FROM : STD_LOGIC; 
  signal N24981_GROM : STD_LOGIC; 
  signal CHOICE1444_FROM : STD_LOGIC; 
  signal CHOICE1444_GROM : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_1_FROM : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal N23016_FROM : STD_LOGIC; 
  signal N23016_GROM : STD_LOGIC; 
  signal N24841_FROM : STD_LOGIC; 
  signal N24841_GROM : STD_LOGIC; 
  signal CHOICE1894_FROM : STD_LOGIC; 
  signal CHOICE1894_GROM : STD_LOGIC; 
  signal N24851_FROM : STD_LOGIC; 
  signal N24851_GROM : STD_LOGIC; 
  signal CHOICE1849_FROM : STD_LOGIC; 
  signal CHOICE1849_GROM : STD_LOGIC; 
  signal CHOICE1909_FROM : STD_LOGIC; 
  signal CHOICE1909_GROM : STD_LOGIC; 
  signal N24783_GROM : STD_LOGIC; 
  signal CHOICE1879_FROM : STD_LOGIC; 
  signal CHOICE1879_GROM : STD_LOGIC; 
  signal XLXI_10_I1_nreset_v_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I1_nreset_v_1_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_3_n0027_GROM : STD_LOGIC; 
  signal XLXI_10_I2_nreset_v_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I2_nreset_v_1_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_3_FROM : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_3_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I3_nreset_v_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I3_nreset_v_1_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_10_I4_nreset_v_1_SRMUX_OUTPUTNOT : STD_LOGIC; 
  signal XLXI_10_I4_nreset_v_1_LOGIC_ONE : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_5_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_7_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_2_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_3_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_0_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_4_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_2_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_5_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_7_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_4_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_3_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I3_acc_c_0_2_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_2_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_6_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_3_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_4_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_5_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_0_6_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_period_1_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_period_1_FFX_RST : STD_LOGIC; 
  signal XLXI_3_pwm_period_3_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_period_3_FFX_RST : STD_LOGIC; 
  signal XLXI_3_pwm_period_7_FFX_RST : STD_LOGIC; 
  signal XLXI_3_pwm_period_5_FFY_RST : STD_LOGIC; 
  signal XLXI_3_pwm_period_5_FFX_RST : STD_LOGIC; 
  signal XLXI_3_pwm_period_7_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_data_is_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_data_is_c_3_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_data_is_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I2_skip_c_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I4_ipage_we_c_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I4_ipage_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_valid_c_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I4_ipage_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I1_nreset_v_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_nreset_v_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_3_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I3_nreset_v_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I4_nreset_v_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_3_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_4_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_5_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_3_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_3_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_2_6_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_7_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_5_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_3_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_pc_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_pc_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_pc_2_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_pc_3_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_pc_4_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_pc_5_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_pc_6_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_pc_7_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I3_nreset_v_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I4_nreset_v_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_5_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I1_nreset_v_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I5_daddr_c_5_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I2_nreset_v_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_data_is_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_10_I1_stack_addrs_c_1_7_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I5_ndwe_c_FFY_SET : STD_LOGIC; 
  signal XLXI_10_I2_TC_c_2_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_0_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_10_I2_TD_c_2_FFY_RST : STD_LOGIC; 
  signal CLK_BUFGP_BUFG_CE : STD_LOGIC; 
  signal VCC : STD_LOGIC; 
  signal GND : STD_LOGIC; 
  signal XLXI_2_ctrl_data_c : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal RAM_DATA_OUT : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXN_8 : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal XLXI_10_I2_TD_c : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_10_I2_TC_c : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal XLXI_10_I3_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_3_pwm_low : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_3_pwm_count : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_3_pwm_high : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_10_I1_pc : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_10_I1_n0013 : STD_LOGIC_VECTOR ( 7 downto 1 ); 
  signal XLXI_10_I3_n0059 : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal XLXI_10_I3_n0064 : STD_LOGIC_VECTOR ( 3 downto 1 ); 
  signal XLXI_10_I3_n0058 : STD_LOGIC_VECTOR ( 4 downto 4 ); 
  signal XLXI_3_n0011 : STD_LOGIC_VECTOR ( 6 downto 0 ); 
  signal XLXI_3_pwm_period : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_2_pwm_data_c : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_10_I2_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_10_pc_mux : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal XLXI_10_I5_daddr_c : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal XLXI_10_I3_data_x : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_10_I2_data_is_c : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal XLXI_2_mux_c : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_10_I4_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_10_I4_ipage_c : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_10_adaddr_out : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal XLXI_10_I1_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_3_pwm_count_n0000 : STD_LOGIC_VECTOR ( 7 downto 1 ); 
  signal XLXI_3_n0005 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_10_I2_TC_x : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal XLXI_10_I4_n0030 : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_10_I1_n0008 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_10_I2_n0028 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_10_I3_n0036 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_10_I4_n0031 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal XLXI_10_I2_TD_x : STD_LOGIC_VECTOR ( 3 downto 0 ); 
begin
  GLOBAL_LOGIC0_ZERO : X_ZERO
    port map (
      O => GLOBAL_LOGIC0
    );
  GLOBAL_LOGIC1_ONE : X_ONE
    port map (
      O => GLOBAL_LOGIC1
    );
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
      I => CPU_DADDR_0_OBUF,
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
      ADDR(0) => CPU_DADDR_0_OBUF,
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
      DI(15) => GLOBAL_LOGIC0,
      DI(14) => GLOBAL_LOGIC0,
      DI(13) => GLOBAL_LOGIC0,
      DI(12) => GLOBAL_LOGIC0,
      DI(11) => GLOBAL_LOGIC0,
      DI(10) => GLOBAL_LOGIC0,
      DI(9) => GLOBAL_LOGIC0,
      DI(8) => GLOBAL_LOGIC0,
      DI(7) => GLOBAL_LOGIC0,
      DI(6) => GLOBAL_LOGIC0,
      DI(5) => GLOBAL_LOGIC0,
      DI(4) => GLOBAL_LOGIC0,
      DI(3) => GLOBAL_LOGIC0,
      DI(2) => GLOBAL_LOGIC0,
      DI(1) => GLOBAL_LOGIC0,
      DI(0) => GLOBAL_LOGIC0,
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
      IA => N25246,
      IB => N25248,
      SEL => XLXI_10_I2_TD_c(2),
      O => N24977_F5MUX
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
  N24977_XUSED : X_BUF
    port map (
      I => N24977_F5MUX,
      O => N24977
    );
  XLXI_10_I3_n0035_0_107_SW11 : X_MUX2
    port map (
      IA => N25221,
      IB => N25223,
      SEL => CHOICE1966,
      O => N24693_F5MUX
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
  N24693_XUSED : X_BUF
    port map (
      I => N24693_F5MUX,
      O => N24693
    );
  XLXI_10_I3_n0035_2_109_SW11 : X_MUX2
    port map (
      IA => N25226,
      IB => N25228,
      SEL => CHOICE2079,
      O => N24705_F5MUX
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
  N24705_XUSED : X_BUF
    port map (
      I => N24705_F5MUX,
      O => N24705
    );
  XLXI_10_I3_n0035_4_60_SW11 : X_MUX2
    port map (
      IA => N25236,
      IB => N25238,
      SEL => CHOICE2013,
      O => N24687_F5MUX
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
  N24687_XUSED : X_BUF
    port map (
      I => N24687_F5MUX,
      O => N24687
    );
  XLXI_10_I3_n0035_1_109_SW11 : X_MUX2
    port map (
      IA => N25231,
      IB => N25233,
      SEL => CHOICE2035,
      O => N24711_F5MUX
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
  N24711_XUSED : X_BUF
    port map (
      I => N24711_F5MUX,
      O => N24711
    );
  XLXI_10_I3_n0035_3_109_SW11 : X_MUX2
    port map (
      IA => N25241,
      IB => N25243,
      SEL => CHOICE2167,
      O => N24699_F5MUX
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
  N24699_XUSED : X_BUF
    port map (
      I => N24699_F5MUX,
      O => N24699
    );
  XLXI_3_Mcompar_n0014_inst_cy_25_LOGIC_ZERO_58 : X_ZERO
    port map (
      O => XLXI_3_Mcompar_n0014_inst_cy_25_LOGIC_ZERO
    );
  XLXI_3_Mcompar_n0014_inst_cy_24_59 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(0),
      IB => XLXI_3_Mcompar_n0014_inst_cy_25_LOGIC_ZERO,
      SEL => XLXI_3_Mcompar_n0014_inst_lut2_24,
      O => XLXI_3_Mcompar_n0014_inst_cy_24
    );
  XLXI_3_Mcompar_n0014_inst_lut2_241 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(0),
      ADR1 => XLXI_3_pwm_count(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0014_inst_lut2_24
    );
  XLXI_3_Mcompar_n0014_inst_lut2_251 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(1),
      ADR1 => XLXI_3_pwm_count(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0014_inst_lut2_25
    );
  XLXI_3_Mcompar_n0014_inst_cy_25_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0014_inst_cy_25_CYMUXG,
      O => XLXI_3_Mcompar_n0014_inst_cy_25
    );
  XLXI_3_Mcompar_n0014_inst_cy_25_60 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(1),
      IB => XLXI_3_Mcompar_n0014_inst_cy_24,
      SEL => XLXI_3_Mcompar_n0014_inst_lut2_25,
      O => XLXI_3_Mcompar_n0014_inst_cy_25_CYMUXG
    );
  XLXI_3_Mcompar_n0014_inst_cy_26_61 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(2),
      IB => XLXI_3_Mcompar_n0014_inst_cy_27_CYINIT,
      SEL => XLXI_3_Mcompar_n0014_inst_lut2_26,
      O => XLXI_3_Mcompar_n0014_inst_cy_26
    );
  XLXI_3_Mcompar_n0014_inst_lut2_261 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(2),
      ADR1 => XLXI_3_pwm_count(2),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0014_inst_lut2_26
    );
  XLXI_3_Mcompar_n0014_inst_lut2_271 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(3),
      ADR1 => XLXI_3_pwm_count(3),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0014_inst_lut2_27
    );
  XLXI_3_Mcompar_n0014_inst_cy_27_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0014_inst_cy_27_CYMUXG,
      O => XLXI_3_Mcompar_n0014_inst_cy_27
    );
  XLXI_3_Mcompar_n0014_inst_cy_27_62 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(3),
      IB => XLXI_3_Mcompar_n0014_inst_cy_26,
      SEL => XLXI_3_Mcompar_n0014_inst_lut2_27,
      O => XLXI_3_Mcompar_n0014_inst_cy_27_CYMUXG
    );
  XLXI_3_Mcompar_n0014_inst_cy_27_CYINIT_63 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0014_inst_cy_25,
      O => XLXI_3_Mcompar_n0014_inst_cy_27_CYINIT
    );
  XLXI_3_Mcompar_n0014_inst_cy_28_64 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(4),
      IB => XLXI_3_Mcompar_n0014_inst_cy_29_CYINIT,
      SEL => XLXI_3_Mcompar_n0014_inst_lut2_28,
      O => XLXI_3_Mcompar_n0014_inst_cy_28
    );
  XLXI_3_Mcompar_n0014_inst_lut2_281 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(4),
      ADR1 => XLXI_3_pwm_count(4),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0014_inst_lut2_28
    );
  XLXI_3_Mcompar_n0014_inst_lut2_291 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(5),
      ADR1 => XLXI_3_pwm_count(5),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0014_inst_lut2_29
    );
  XLXI_3_Mcompar_n0014_inst_cy_29_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0014_inst_cy_29_CYMUXG,
      O => XLXI_3_Mcompar_n0014_inst_cy_29
    );
  XLXI_3_Mcompar_n0014_inst_cy_29_65 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(5),
      IB => XLXI_3_Mcompar_n0014_inst_cy_28,
      SEL => XLXI_3_Mcompar_n0014_inst_lut2_29,
      O => XLXI_3_Mcompar_n0014_inst_cy_29_CYMUXG
    );
  XLXI_3_Mcompar_n0014_inst_cy_29_CYINIT_66 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0014_inst_cy_27,
      O => XLXI_3_Mcompar_n0014_inst_cy_29_CYINIT
    );
  XLXI_3_Mcompar_n0014_inst_cy_30_67 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(6),
      IB => XLXI_3_Mcompar_n0014_inst_cy_31_CYINIT,
      SEL => XLXI_3_Mcompar_n0014_inst_lut2_30,
      O => XLXI_3_Mcompar_n0014_inst_cy_30
    );
  XLXI_3_Mcompar_n0014_inst_lut2_301 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(6),
      ADR1 => XLXI_3_pwm_count(6),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0014_inst_lut2_30
    );
  XLXI_3_Mcompar_n0014_inst_lut2_311 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(7),
      ADR1 => XLXI_3_pwm_count(7),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0014_inst_lut2_31
    );
  XLXI_3_Mcompar_n0014_inst_cy_31_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0014_inst_cy_31_CYMUXG,
      O => XLXI_3_Mcompar_n0014_inst_cy_31
    );
  XLXI_3_Mcompar_n0014_inst_cy_31_68 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(7),
      IB => XLXI_3_Mcompar_n0014_inst_cy_30,
      SEL => XLXI_3_Mcompar_n0014_inst_lut2_31,
      O => XLXI_3_Mcompar_n0014_inst_cy_31_CYMUXG
    );
  XLXI_3_Mcompar_n0014_inst_cy_31_CYINIT_69 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0014_inst_cy_29,
      O => XLXI_3_Mcompar_n0014_inst_cy_31_CYINIT
    );
  XLXI_3_Mcompar_n0015_inst_cy_9_LOGIC_ZERO_70 : X_ZERO
    port map (
      O => XLXI_3_Mcompar_n0015_inst_cy_9_LOGIC_ZERO
    );
  XLXI_3_Mcompar_n0015_inst_cy_8_71 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(0),
      IB => XLXI_3_Mcompar_n0015_inst_cy_9_LOGIC_ZERO,
      SEL => XLXI_3_Mcompar_n0015_inst_lut2_8,
      O => XLXI_3_Mcompar_n0015_inst_cy_8
    );
  XLXI_3_Mcompar_n0015_inst_lut2_81 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(0),
      ADR1 => XLXI_3_pwm_count(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0015_inst_lut2_8
    );
  XLXI_3_Mcompar_n0015_inst_lut2_91 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(1),
      ADR1 => XLXI_3_pwm_count(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0015_inst_lut2_9
    );
  XLXI_3_Mcompar_n0015_inst_cy_9_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0015_inst_cy_9_CYMUXG,
      O => XLXI_3_Mcompar_n0015_inst_cy_9
    );
  XLXI_3_Mcompar_n0015_inst_cy_9_72 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(1),
      IB => XLXI_3_Mcompar_n0015_inst_cy_8,
      SEL => XLXI_3_Mcompar_n0015_inst_lut2_9,
      O => XLXI_3_Mcompar_n0015_inst_cy_9_CYMUXG
    );
  XLXI_3_Mcompar_n0015_inst_cy_10_73 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(2),
      IB => XLXI_3_Mcompar_n0015_inst_cy_11_CYINIT,
      SEL => XLXI_3_Mcompar_n0015_inst_lut2_10,
      O => XLXI_3_Mcompar_n0015_inst_cy_10
    );
  XLXI_3_Mcompar_n0015_inst_lut2_101 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(2),
      ADR1 => XLXI_3_pwm_count(2),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0015_inst_lut2_10
    );
  XLXI_3_Mcompar_n0015_inst_lut2_111 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(3),
      ADR1 => XLXI_3_pwm_count(3),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0015_inst_lut2_11
    );
  XLXI_3_Mcompar_n0015_inst_cy_11_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0015_inst_cy_11_CYMUXG,
      O => XLXI_3_Mcompar_n0015_inst_cy_11
    );
  XLXI_3_Mcompar_n0015_inst_cy_11_74 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(3),
      IB => XLXI_3_Mcompar_n0015_inst_cy_10,
      SEL => XLXI_3_Mcompar_n0015_inst_lut2_11,
      O => XLXI_3_Mcompar_n0015_inst_cy_11_CYMUXG
    );
  XLXI_3_Mcompar_n0015_inst_cy_11_CYINIT_75 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0015_inst_cy_9,
      O => XLXI_3_Mcompar_n0015_inst_cy_11_CYINIT
    );
  XLXI_3_Mcompar_n0015_inst_cy_12_76 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(4),
      IB => XLXI_3_Mcompar_n0015_inst_cy_13_CYINIT,
      SEL => XLXI_3_Mcompar_n0015_inst_lut2_12,
      O => XLXI_3_Mcompar_n0015_inst_cy_12
    );
  XLXI_3_Mcompar_n0015_inst_lut2_121 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(4),
      ADR1 => XLXI_3_pwm_count(4),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0015_inst_lut2_12
    );
  XLXI_3_Mcompar_n0015_inst_lut2_131 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(5),
      ADR1 => XLXI_3_pwm_count(5),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0015_inst_lut2_13
    );
  XLXI_3_Mcompar_n0015_inst_cy_13_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0015_inst_cy_13_CYMUXG,
      O => XLXI_3_Mcompar_n0015_inst_cy_13
    );
  XLXI_3_Mcompar_n0015_inst_cy_13_77 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(5),
      IB => XLXI_3_Mcompar_n0015_inst_cy_12,
      SEL => XLXI_3_Mcompar_n0015_inst_lut2_13,
      O => XLXI_3_Mcompar_n0015_inst_cy_13_CYMUXG
    );
  XLXI_3_Mcompar_n0015_inst_cy_13_CYINIT_78 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0015_inst_cy_11,
      O => XLXI_3_Mcompar_n0015_inst_cy_13_CYINIT
    );
  XLXI_3_Mcompar_n0015_inst_cy_14_79 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(6),
      IB => XLXI_3_n0015_CYINIT,
      SEL => XLXI_3_Mcompar_n0015_inst_lut2_14,
      O => XLXI_3_Mcompar_n0015_inst_cy_14
    );
  XLXI_3_Mcompar_n0015_inst_lut2_141 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(6),
      ADR1 => XLXI_3_pwm_count(6),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0015_inst_lut2_14
    );
  XLXI_3_Mcompar_n0015_inst_lut2_151 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_low(7),
      ADR1 => XLXI_3_pwm_count(7),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0015_inst_lut2_15
    );
  XLXI_3_n0015_COUTUSED : X_BUF
    port map (
      I => XLXI_3_n0015_CYMUXG,
      O => XLXI_3_n0015
    );
  XLXI_3_Mcompar_n0015_inst_cy_15 : X_MUX2
    port map (
      IA => XLXI_3_pwm_low(7),
      IB => XLXI_3_Mcompar_n0015_inst_cy_14,
      SEL => XLXI_3_Mcompar_n0015_inst_lut2_15,
      O => XLXI_3_n0015_CYMUXG
    );
  XLXI_3_n0015_CYINIT_80 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0015_inst_cy_13,
      O => XLXI_3_n0015_CYINIT
    );
  XLXI_3_Mcompar_n0016_inst_cy_9_LOGIC_ZERO_81 : X_ZERO
    port map (
      O => XLXI_3_Mcompar_n0016_inst_cy_9_LOGIC_ZERO
    );
  XLXI_3_Mcompar_n0016_inst_cy_8_82 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(0),
      IB => XLXI_3_Mcompar_n0016_inst_cy_9_LOGIC_ZERO,
      SEL => XLXI_3_Mcompar_n0016_inst_lut2_8,
      O => XLXI_3_Mcompar_n0016_inst_cy_8
    );
  XLXI_3_Mcompar_n0016_inst_lut2_81 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(0),
      ADR1 => XLXI_3_pwm_count(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0016_inst_lut2_8
    );
  XLXI_3_Mcompar_n0016_inst_lut2_91 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(1),
      ADR1 => XLXI_3_pwm_count(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0016_inst_lut2_9
    );
  XLXI_3_Mcompar_n0016_inst_cy_9_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0016_inst_cy_9_CYMUXG,
      O => XLXI_3_Mcompar_n0016_inst_cy_9
    );
  XLXI_3_Mcompar_n0016_inst_cy_9_83 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(1),
      IB => XLXI_3_Mcompar_n0016_inst_cy_8,
      SEL => XLXI_3_Mcompar_n0016_inst_lut2_9,
      O => XLXI_3_Mcompar_n0016_inst_cy_9_CYMUXG
    );
  XLXI_3_Mcompar_n0016_inst_cy_10_84 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(2),
      IB => XLXI_3_Mcompar_n0016_inst_cy_11_CYINIT,
      SEL => XLXI_3_Mcompar_n0016_inst_lut2_10,
      O => XLXI_3_Mcompar_n0016_inst_cy_10
    );
  XLXI_3_Mcompar_n0016_inst_lut2_101 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(2),
      ADR1 => XLXI_3_pwm_count(2),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0016_inst_lut2_10
    );
  XLXI_3_Mcompar_n0016_inst_lut2_111 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(3),
      ADR1 => XLXI_3_pwm_count(3),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0016_inst_lut2_11
    );
  XLXI_3_Mcompar_n0016_inst_cy_11_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0016_inst_cy_11_CYMUXG,
      O => XLXI_3_Mcompar_n0016_inst_cy_11
    );
  XLXI_3_Mcompar_n0016_inst_cy_11_85 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(3),
      IB => XLXI_3_Mcompar_n0016_inst_cy_10,
      SEL => XLXI_3_Mcompar_n0016_inst_lut2_11,
      O => XLXI_3_Mcompar_n0016_inst_cy_11_CYMUXG
    );
  XLXI_3_Mcompar_n0016_inst_cy_11_CYINIT_86 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0016_inst_cy_9,
      O => XLXI_3_Mcompar_n0016_inst_cy_11_CYINIT
    );
  XLXI_3_Mcompar_n0016_inst_cy_12_87 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(4),
      IB => XLXI_3_Mcompar_n0016_inst_cy_13_CYINIT,
      SEL => XLXI_3_Mcompar_n0016_inst_lut2_12,
      O => XLXI_3_Mcompar_n0016_inst_cy_12
    );
  XLXI_3_Mcompar_n0016_inst_lut2_121 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(4),
      ADR1 => XLXI_3_pwm_count(4),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0016_inst_lut2_12
    );
  XLXI_3_Mcompar_n0016_inst_lut2_131 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(5),
      ADR1 => XLXI_3_pwm_count(5),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0016_inst_lut2_13
    );
  XLXI_3_Mcompar_n0016_inst_cy_13_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0016_inst_cy_13_CYMUXG,
      O => XLXI_3_Mcompar_n0016_inst_cy_13
    );
  XLXI_3_Mcompar_n0016_inst_cy_13_88 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(5),
      IB => XLXI_3_Mcompar_n0016_inst_cy_12,
      SEL => XLXI_3_Mcompar_n0016_inst_lut2_13,
      O => XLXI_3_Mcompar_n0016_inst_cy_13_CYMUXG
    );
  XLXI_3_Mcompar_n0016_inst_cy_13_CYINIT_89 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0016_inst_cy_11,
      O => XLXI_3_Mcompar_n0016_inst_cy_13_CYINIT
    );
  XLXI_3_Mcompar_n0016_inst_cy_14_90 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(6),
      IB => XLXI_3_n0016_CYINIT,
      SEL => XLXI_3_Mcompar_n0016_inst_lut2_14,
      O => XLXI_3_Mcompar_n0016_inst_cy_14
    );
  XLXI_3_Mcompar_n0016_inst_lut2_141 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(6),
      ADR1 => XLXI_3_pwm_count(6),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0016_inst_lut2_14
    );
  XLXI_3_Mcompar_n0016_inst_lut2_151 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(7),
      ADR1 => XLXI_3_pwm_count(7),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0016_inst_lut2_15
    );
  XLXI_3_n0016_COUTUSED : X_BUF
    port map (
      I => XLXI_3_n0016_CYMUXG,
      O => XLXI_3_n0016
    );
  XLXI_3_Mcompar_n0016_inst_cy_15 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(7),
      IB => XLXI_3_Mcompar_n0016_inst_cy_14,
      SEL => XLXI_3_Mcompar_n0016_inst_lut2_15,
      O => XLXI_3_n0016_CYMUXG
    );
  XLXI_3_n0016_CYINIT_91 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0016_inst_cy_13,
      O => XLXI_3_n0016_CYINIT
    );
  XLXI_10_I1_n0013_1_LOGIC_ZERO_92 : X_ZERO
    port map (
      O => XLXI_10_I1_n0013_1_LOGIC_ZERO
    );
  XLXI_10_I1_Madd_n0013_inst_cy_0_93 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC1,
      IB => XLXI_10_I1_n0013_1_LOGIC_ZERO,
      SEL => XLXI_10_I1_Madd_n0013_inst_lut2_0,
      O => XLXI_10_I1_Madd_n0013_inst_cy_0
    );
  XLXI_10_I1_Madd_n0013_inst_lut2_01 : X_LUT4
    generic map(
      INIT => X"3333"
    )
    port map (
      ADR0 => GLOBAL_LOGIC1,
      ADR1 => XLXI_10_I1_pc(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_Madd_n0013_inst_lut2_0
    );
  XLXI_10_I1_n0013_1_G : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => GLOBAL_LOGIC0,
      ADR1 => XLXI_10_I1_pc(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_n0013_1_GROM
    );
  XLXI_10_I1_n0013_1_COUTUSED : X_BUF
    port map (
      I => XLXI_10_I1_n0013_1_CYMUXG,
      O => XLXI_10_I1_Madd_n0013_inst_cy_1
    );
  XLXI_10_I1_n0013_1_YUSED : X_BUF
    port map (
      I => XLXI_10_I1_n0013_1_XORG,
      O => XLXI_10_I1_n0013(1)
    );
  XLXI_10_I1_Madd_n0013_inst_cy_1_94 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC0,
      IB => XLXI_10_I1_Madd_n0013_inst_cy_0,
      SEL => XLXI_10_I1_n0013_1_GROM,
      O => XLXI_10_I1_n0013_1_CYMUXG
    );
  XLXI_10_I1_Madd_n0013_inst_sum_1 : X_XOR2
    port map (
      I0 => XLXI_10_I1_Madd_n0013_inst_cy_0,
      I1 => XLXI_10_I1_n0013_1_GROM,
      O => XLXI_10_I1_n0013_1_XORG
    );
  XLXI_10_I1_n0013_2_LOGIC_ZERO_95 : X_ZERO
    port map (
      O => XLXI_10_I1_n0013_2_LOGIC_ZERO
    );
  XLXI_10_I1_Madd_n0013_inst_cy_2_96 : X_MUX2
    port map (
      IA => XLXI_10_I1_n0013_2_LOGIC_ZERO,
      IB => XLXI_10_I1_n0013_2_CYINIT,
      SEL => XLXI_10_I1_n0013_2_FROM,
      O => XLXI_10_I1_Madd_n0013_inst_cy_2
    );
  XLXI_10_I1_Madd_n0013_inst_sum_2 : X_XOR2
    port map (
      I0 => XLXI_10_I1_n0013_2_CYINIT,
      I1 => XLXI_10_I1_n0013_2_FROM,
      O => XLXI_10_I1_n0013_2_XORF
    );
  XLXI_10_I1_n0013_2_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_10_I1_pc(2),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_n0013_2_FROM
    );
  XLXI_10_I1_n0013_2_G : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_10_I1_pc(3),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_n0013_2_GROM
    );
  XLXI_10_I1_n0013_2_COUTUSED : X_BUF
    port map (
      I => XLXI_10_I1_n0013_2_CYMUXG,
      O => XLXI_10_I1_Madd_n0013_inst_cy_3
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
  XLXI_10_I1_Madd_n0013_inst_cy_3_97 : X_MUX2
    port map (
      IA => XLXI_10_I1_n0013_2_LOGIC_ZERO,
      IB => XLXI_10_I1_Madd_n0013_inst_cy_2,
      SEL => XLXI_10_I1_n0013_2_GROM,
      O => XLXI_10_I1_n0013_2_CYMUXG
    );
  XLXI_10_I1_Madd_n0013_inst_sum_3 : X_XOR2
    port map (
      I0 => XLXI_10_I1_Madd_n0013_inst_cy_2,
      I1 => XLXI_10_I1_n0013_2_GROM,
      O => XLXI_10_I1_n0013_2_XORG
    );
  XLXI_10_I1_n0013_2_CYINIT_98 : X_BUF
    port map (
      I => XLXI_10_I1_Madd_n0013_inst_cy_1,
      O => XLXI_10_I1_n0013_2_CYINIT
    );
  XLXI_10_I1_n0013_4_LOGIC_ZERO_99 : X_ZERO
    port map (
      O => XLXI_10_I1_n0013_4_LOGIC_ZERO
    );
  XLXI_10_I1_Madd_n0013_inst_cy_4_100 : X_MUX2
    port map (
      IA => XLXI_10_I1_n0013_4_LOGIC_ZERO,
      IB => XLXI_10_I1_n0013_4_CYINIT,
      SEL => XLXI_10_I1_n0013_4_FROM,
      O => XLXI_10_I1_Madd_n0013_inst_cy_4
    );
  XLXI_10_I1_Madd_n0013_inst_sum_4 : X_XOR2
    port map (
      I0 => XLXI_10_I1_n0013_4_CYINIT,
      I1 => XLXI_10_I1_n0013_4_FROM,
      O => XLXI_10_I1_n0013_4_XORF
    );
  XLXI_10_I1_n0013_4_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_10_I1_pc(4),
      ADR1 => VCC,
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
      O => XLXI_10_I1_Madd_n0013_inst_cy_5
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
  XLXI_10_I1_Madd_n0013_inst_cy_5_101 : X_MUX2
    port map (
      IA => XLXI_10_I1_n0013_4_LOGIC_ZERO,
      IB => XLXI_10_I1_Madd_n0013_inst_cy_4,
      SEL => XLXI_10_I1_n0013_4_GROM,
      O => XLXI_10_I1_n0013_4_CYMUXG
    );
  XLXI_10_I1_Madd_n0013_inst_sum_5 : X_XOR2
    port map (
      I0 => XLXI_10_I1_Madd_n0013_inst_cy_4,
      I1 => XLXI_10_I1_n0013_4_GROM,
      O => XLXI_10_I1_n0013_4_XORG
    );
  XLXI_10_I1_n0013_4_CYINIT_102 : X_BUF
    port map (
      I => XLXI_10_I1_Madd_n0013_inst_cy_3,
      O => XLXI_10_I1_n0013_4_CYINIT
    );
  XLXI_10_I1_n0013_6_LOGIC_ZERO_103 : X_ZERO
    port map (
      O => XLXI_10_I1_n0013_6_LOGIC_ZERO
    );
  XLXI_10_I1_Madd_n0013_inst_cy_6_104 : X_MUX2
    port map (
      IA => XLXI_10_I1_n0013_6_LOGIC_ZERO,
      IB => XLXI_10_I1_n0013_6_CYINIT,
      SEL => XLXI_10_I1_n0013_6_FROM,
      O => XLXI_10_I1_Madd_n0013_inst_cy_6
    );
  XLXI_10_I1_Madd_n0013_inst_sum_6 : X_XOR2
    port map (
      I0 => XLXI_10_I1_n0013_6_CYINIT,
      I1 => XLXI_10_I1_n0013_6_FROM,
      O => XLXI_10_I1_n0013_6_XORF
    );
  XLXI_10_I1_n0013_6_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_10_I1_pc(6),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_n0013_6_FROM
    );
  XLXI_10_I1_pc_7_rt_105 : X_LUT4
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
  XLXI_10_I1_Madd_n0013_inst_sum_7 : X_XOR2
    port map (
      I0 => XLXI_10_I1_Madd_n0013_inst_cy_6,
      I1 => XLXI_10_I1_pc_7_rt,
      O => XLXI_10_I1_n0013_6_XORG
    );
  XLXI_10_I1_n0013_6_CYINIT_106 : X_BUF
    port map (
      I => XLXI_10_I1_Madd_n0013_inst_cy_5,
      O => XLXI_10_I1_n0013_6_CYINIT
    );
  XLXI_10_I3_n0059_0_LOGIC_ONE_107 : X_ONE
    port map (
      O => XLXI_10_I3_n0059_0_LOGIC_ONE
    );
  XLXI_10_I3_Msub_n0059_inst_cy_36_108 : X_MUX2
    port map (
      IA => XLXI_10_I3_acc_c_0_0,
      IB => XLXI_10_I3_n0059_0_CYINIT,
      SEL => XLXI_10_I3_n0059_0_FROM,
      O => XLXI_10_I3_Msub_n0059_inst_cy_36
    );
  XLXI_10_I3_Msub_n0059_inst_sum_20 : X_XOR2
    port map (
      I0 => XLXI_10_I3_n0059_0_CYINIT,
      I1 => XLXI_10_I3_n0059_0_FROM,
      O => XLXI_10_I3_n0059_0_XORF
    );
  XLXI_10_I3_n0059_0_F : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => XLXI_10_I3_Msub_n0059_inst_lut2_36,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I3_n0059_0_FROM
    );
  XLXI_10_I3_n0059_0_G : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_1,
      ADR1 => XLXI_10_I3_Msub_n0059_inst_lut2_37,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I3_n0059_0_GROM
    );
  XLXI_10_I3_n0059_0_COUTUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0059_0_CYMUXG,
      O => XLXI_10_I3_Msub_n0059_inst_cy_37
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
  XLXI_10_I3_Msub_n0059_inst_cy_37_109 : X_MUX2
    port map (
      IA => XLXI_10_I3_acc_c_0_1,
      IB => XLXI_10_I3_Msub_n0059_inst_cy_36,
      SEL => XLXI_10_I3_n0059_0_GROM,
      O => XLXI_10_I3_n0059_0_CYMUXG
    );
  XLXI_10_I3_Msub_n0059_inst_sum_21 : X_XOR2
    port map (
      I0 => XLXI_10_I3_Msub_n0059_inst_cy_36,
      I1 => XLXI_10_I3_n0059_0_GROM,
      O => XLXI_10_I3_n0059_0_XORG
    );
  XLXI_10_I3_n0059_0_CYINIT_110 : X_BUF
    port map (
      I => XLXI_10_I3_n0059_0_LOGIC_ONE,
      O => XLXI_10_I3_n0059_0_CYINIT
    );
  XLXI_10_I3_Msub_n0059_inst_cy_38_111 : X_MUX2
    port map (
      IA => XLXI_10_I3_acc_c_0_2,
      IB => XLXI_10_I3_n0059_2_CYINIT,
      SEL => XLXI_10_I3_n0059_2_FROM,
      O => XLXI_10_I3_Msub_n0059_inst_cy_38
    );
  XLXI_10_I3_Msub_n0059_inst_sum_22 : X_XOR2
    port map (
      I0 => XLXI_10_I3_n0059_2_CYINIT,
      I1 => XLXI_10_I3_n0059_2_FROM,
      O => XLXI_10_I3_n0059_2_XORF
    );
  XLXI_10_I3_n0059_2_F : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_2,
      ADR1 => XLXI_10_I3_Msub_n0059_inst_lut2_38,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I3_n0059_2_FROM
    );
  XLXI_10_I3_n0059_2_G : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_3,
      ADR1 => XLXI_10_I3_Msub_n0059_inst_lut2_39,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I3_n0059_2_GROM
    );
  XLXI_10_I3_n0059_2_COUTUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0059_2_CYMUXG,
      O => XLXI_10_I3_Msub_n0059_inst_cy_39
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
  XLXI_10_I3_Msub_n0059_inst_cy_39_112 : X_MUX2
    port map (
      IA => XLXI_10_I3_acc_c_0_3,
      IB => XLXI_10_I3_Msub_n0059_inst_cy_38,
      SEL => XLXI_10_I3_n0059_2_GROM,
      O => XLXI_10_I3_n0059_2_CYMUXG
    );
  XLXI_10_I3_Msub_n0059_inst_sum_23 : X_XOR2
    port map (
      I0 => XLXI_10_I3_Msub_n0059_inst_cy_38,
      I1 => XLXI_10_I3_n0059_2_GROM,
      O => XLXI_10_I3_n0059_2_XORG
    );
  XLXI_10_I3_n0059_2_CYINIT_113 : X_BUF
    port map (
      I => XLXI_10_I3_Msub_n0059_inst_cy_37,
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
  XLXI_10_I3_n0059_4_CYINIT_114 : X_BUF
    port map (
      I => XLXI_10_I3_Msub_n0059_inst_cy_39,
      O => XLXI_10_I3_n0059_4_CYINIT
    );
  XLXI_10_I3_n0064_1_LOGIC_ZERO_115 : X_ZERO
    port map (
      O => XLXI_10_I3_n0064_1_LOGIC_ZERO
    );
  XLXI_10_I3_Madd_n0064_inst_cy_32_116 : X_MUX2
    port map (
      IA => XLXI_10_I3_acc_c_0_0,
      IB => XLXI_10_I3_n0064_1_LOGIC_ZERO,
      SEL => XLXI_10_I3_Madd_n0064_inst_lut2_32_rt,
      O => XLXI_10_I3_Madd_n0064_inst_cy_32
    );
  XLXI_10_I3_Madd_n0064_inst_lut2_32_rt_117 : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => XLXI_10_I3_Madd_n0064_inst_lut2_32,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I3_Madd_n0064_inst_lut2_32_rt
    );
  XLXI_10_I3_n0064_1_G : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_1,
      ADR1 => XLXI_10_I3_Madd_n0064_inst_lut2_33,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I3_n0064_1_GROM
    );
  XLXI_10_I3_n0064_1_COUTUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0064_1_CYMUXG,
      O => XLXI_10_I3_Madd_n0064_inst_cy_33
    );
  XLXI_10_I3_n0064_1_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_n0064_1_XORG,
      O => XLXI_10_I3_n0064(1)
    );
  XLXI_10_I3_Madd_n0064_inst_cy_33_118 : X_MUX2
    port map (
      IA => XLXI_10_I3_acc_c_0_1,
      IB => XLXI_10_I3_Madd_n0064_inst_cy_32,
      SEL => XLXI_10_I3_n0064_1_GROM,
      O => XLXI_10_I3_n0064_1_CYMUXG
    );
  XLXI_10_I3_Madd_n0064_inst_sum_17 : X_XOR2
    port map (
      I0 => XLXI_10_I3_Madd_n0064_inst_cy_32,
      I1 => XLXI_10_I3_n0064_1_GROM,
      O => XLXI_10_I3_n0064_1_XORG
    );
  XLXI_10_I3_Madd_n0064_inst_cy_34_119 : X_MUX2
    port map (
      IA => XLXI_10_I3_acc_c_0_2,
      IB => XLXI_10_I3_n0064_2_CYINIT,
      SEL => XLXI_10_I3_n0064_2_FROM,
      O => XLXI_10_I3_Madd_n0064_inst_cy_34
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
      ADR1 => XLXI_10_I3_Madd_n0064_inst_lut2_34,
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
      ADR1 => XLXI_10_I3_Madd_n0064_inst_lut2_35,
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
  XLXI_10_I3_Madd_n0064_inst_cy_35 : X_MUX2
    port map (
      IA => XLXI_10_I3_acc_c_0_3,
      IB => XLXI_10_I3_Madd_n0064_inst_cy_34,
      SEL => XLXI_10_I3_n0064_2_GROM,
      O => XLXI_10_I3_n0064_2_CYMUXG
    );
  XLXI_10_I3_Madd_n0064_inst_sum_19 : X_XOR2
    port map (
      I0 => XLXI_10_I3_Madd_n0064_inst_cy_34,
      I1 => XLXI_10_I3_n0064_2_GROM,
      O => XLXI_10_I3_n0064_2_XORG
    );
  XLXI_10_I3_n0064_2_CYINIT_120 : X_BUF
    port map (
      I => XLXI_10_I3_Madd_n0064_inst_cy_33,
      O => XLXI_10_I3_n0064_2_CYINIT
    );
  XLXI_3_pwm_count_0_LOGIC_ZERO_121 : X_ZERO
    port map (
      O => XLXI_3_pwm_count_0_LOGIC_ZERO
    );
  XLXI_3_pwm_count_Madd_n0000_inst_cy_0_122 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC1,
      IB => XLXI_3_pwm_count_0_LOGIC_ZERO,
      SEL => XLXI_3_pwm_count_Madd_n0000_inst_lut2_0,
      O => XLXI_3_pwm_count_Madd_n0000_inst_cy_0
    );
  XLXI_3_pwm_count_Madd_n0000_inst_lut2_01 : X_LUT4
    generic map(
      INIT => X"3333"
    )
    port map (
      ADR0 => GLOBAL_LOGIC1,
      ADR1 => XLXI_3_pwm_count(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_pwm_count_Madd_n0000_inst_lut2_0
    );
  XLXI_3_pwm_count_0_G : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => GLOBAL_LOGIC0,
      ADR1 => XLXI_3_pwm_count(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_pwm_count_0_GROM
    );
  XLXI_3_pwm_count_0_COUTUSED : X_BUF
    port map (
      I => XLXI_3_pwm_count_0_CYMUXG,
      O => XLXI_3_pwm_count_Madd_n0000_inst_cy_1
    );
  XLXI_3_pwm_count_Madd_n0000_inst_cy_1_123 : X_MUX2
    port map (
      IA => GLOBAL_LOGIC0,
      IB => XLXI_3_pwm_count_Madd_n0000_inst_cy_0,
      SEL => XLXI_3_pwm_count_0_GROM,
      O => XLXI_3_pwm_count_0_CYMUXG
    );
  XLXI_3_pwm_count_Madd_n0000_inst_sum_1 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_count_Madd_n0000_inst_cy_0,
      I1 => XLXI_3_pwm_count_0_GROM,
      O => XLXI_3_pwm_count_n0000(1)
    );
  XLXI_3_pwm_count_2_LOGIC_ZERO_124 : X_ZERO
    port map (
      O => XLXI_3_pwm_count_2_LOGIC_ZERO
    );
  XLXI_3_pwm_count_Madd_n0000_inst_cy_2_125 : X_MUX2
    port map (
      IA => XLXI_3_pwm_count_2_LOGIC_ZERO,
      IB => XLXI_3_pwm_count_2_CYINIT,
      SEL => XLXI_3_pwm_count_2_FROM,
      O => XLXI_3_pwm_count_Madd_n0000_inst_cy_2
    );
  XLXI_3_pwm_count_Madd_n0000_inst_sum_2 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_count_2_CYINIT,
      I1 => XLXI_3_pwm_count_2_FROM,
      O => XLXI_3_pwm_count_n0000(2)
    );
  XLXI_3_pwm_count_2_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_3_pwm_count(2),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_pwm_count_2_FROM
    );
  XLXI_3_pwm_count_2_G : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_3_pwm_count(3),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_pwm_count_2_GROM
    );
  XLXI_3_pwm_count_2_COUTUSED : X_BUF
    port map (
      I => XLXI_3_pwm_count_2_CYMUXG,
      O => XLXI_3_pwm_count_Madd_n0000_inst_cy_3
    );
  XLXI_3_pwm_count_Madd_n0000_inst_cy_3_126 : X_MUX2
    port map (
      IA => XLXI_3_pwm_count_2_LOGIC_ZERO,
      IB => XLXI_3_pwm_count_Madd_n0000_inst_cy_2,
      SEL => XLXI_3_pwm_count_2_GROM,
      O => XLXI_3_pwm_count_2_CYMUXG
    );
  XLXI_3_pwm_count_Madd_n0000_inst_sum_3 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_count_Madd_n0000_inst_cy_2,
      I1 => XLXI_3_pwm_count_2_GROM,
      O => XLXI_3_pwm_count_n0000(3)
    );
  XLXI_3_pwm_count_2_CYINIT_127 : X_BUF
    port map (
      I => XLXI_3_pwm_count_Madd_n0000_inst_cy_1,
      O => XLXI_3_pwm_count_2_CYINIT
    );
  XLXI_3_pwm_count_4_LOGIC_ZERO_128 : X_ZERO
    port map (
      O => XLXI_3_pwm_count_4_LOGIC_ZERO
    );
  XLXI_3_pwm_count_Madd_n0000_inst_cy_4_129 : X_MUX2
    port map (
      IA => XLXI_3_pwm_count_4_LOGIC_ZERO,
      IB => XLXI_3_pwm_count_4_CYINIT,
      SEL => XLXI_3_pwm_count_4_FROM,
      O => XLXI_3_pwm_count_Madd_n0000_inst_cy_4
    );
  XLXI_3_pwm_count_Madd_n0000_inst_sum_4 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_count_4_CYINIT,
      I1 => XLXI_3_pwm_count_4_FROM,
      O => XLXI_3_pwm_count_n0000(4)
    );
  XLXI_3_pwm_count_4_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_3_pwm_count(4),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_pwm_count_4_FROM
    );
  XLXI_3_pwm_count_4_G : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_3_pwm_count(5),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_pwm_count_4_GROM
    );
  XLXI_3_pwm_count_4_COUTUSED : X_BUF
    port map (
      I => XLXI_3_pwm_count_4_CYMUXG,
      O => XLXI_3_pwm_count_Madd_n0000_inst_cy_5
    );
  XLXI_3_pwm_count_Madd_n0000_inst_cy_5_130 : X_MUX2
    port map (
      IA => XLXI_3_pwm_count_4_LOGIC_ZERO,
      IB => XLXI_3_pwm_count_Madd_n0000_inst_cy_4,
      SEL => XLXI_3_pwm_count_4_GROM,
      O => XLXI_3_pwm_count_4_CYMUXG
    );
  XLXI_3_pwm_count_Madd_n0000_inst_sum_5 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_count_Madd_n0000_inst_cy_4,
      I1 => XLXI_3_pwm_count_4_GROM,
      O => XLXI_3_pwm_count_n0000(5)
    );
  XLXI_3_pwm_count_4_CYINIT_131 : X_BUF
    port map (
      I => XLXI_3_pwm_count_Madd_n0000_inst_cy_3,
      O => XLXI_3_pwm_count_4_CYINIT
    );
  XLXI_3_pwm_count_6_LOGIC_ZERO_132 : X_ZERO
    port map (
      O => XLXI_3_pwm_count_6_LOGIC_ZERO
    );
  XLXI_3_pwm_count_Madd_n0000_inst_cy_6_133 : X_MUX2
    port map (
      IA => XLXI_3_pwm_count_6_LOGIC_ZERO,
      IB => XLXI_3_pwm_count_6_CYINIT,
      SEL => XLXI_3_pwm_count_6_FROM,
      O => XLXI_3_pwm_count_Madd_n0000_inst_cy_6
    );
  XLXI_3_pwm_count_Madd_n0000_inst_sum_6 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_count_6_CYINIT,
      I1 => XLXI_3_pwm_count_6_FROM,
      O => XLXI_3_pwm_count_n0000(6)
    );
  XLXI_3_pwm_count_6_F : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_3_pwm_count(6),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_pwm_count_6_FROM
    );
  XLXI_3_pwm_count_7_rt_134 : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_3_pwm_count(7),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_pwm_count_7_rt
    );
  XLXI_3_pwm_count_Madd_n0000_inst_sum_7 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_count_Madd_n0000_inst_cy_6,
      I1 => XLXI_3_pwm_count_7_rt,
      O => XLXI_3_pwm_count_n0000(7)
    );
  XLXI_3_pwm_count_6_CYINIT_135 : X_BUF
    port map (
      I => XLXI_3_pwm_count_Madd_n0000_inst_cy_5,
      O => XLXI_3_pwm_count_6_CYINIT
    );
  XLXI_3_pwm_high_0_LOGIC_ONE_136 : X_ONE
    port map (
      O => XLXI_3_pwm_high_0_LOGIC_ONE
    );
  XLXI_3_Msub_n0005_inst_cy_16_137 : X_MUX2
    port map (
      IA => XLXI_3_n0011(0),
      IB => XLXI_3_pwm_high_0_CYINIT,
      SEL => XLXI_3_pwm_high_0_FROM,
      O => XLXI_3_Msub_n0005_inst_cy_16
    );
  XLXI_3_Msub_n0005_inst_sum_8 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_high_0_CYINIT,
      I1 => XLXI_3_pwm_high_0_FROM,
      O => XLXI_3_n0005(0)
    );
  XLXI_3_pwm_high_0_F : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_3_n0011(0),
      ADR1 => XLXI_3_Msub_n0005_inst_lut2_16,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_pwm_high_0_FROM
    );
  XLXI_3_pwm_high_0_G : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_3_n0011(1),
      ADR1 => XLXI_3_Msub_n0005_inst_lut2_17,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_pwm_high_0_GROM
    );
  XLXI_3_pwm_high_0_COUTUSED : X_BUF
    port map (
      I => XLXI_3_pwm_high_0_CYMUXG,
      O => XLXI_3_Msub_n0005_inst_cy_17
    );
  XLXI_3_Msub_n0005_inst_cy_17_138 : X_MUX2
    port map (
      IA => XLXI_3_n0011(1),
      IB => XLXI_3_Msub_n0005_inst_cy_16,
      SEL => XLXI_3_pwm_high_0_GROM,
      O => XLXI_3_pwm_high_0_CYMUXG
    );
  XLXI_3_Msub_n0005_inst_sum_9 : X_XOR2
    port map (
      I0 => XLXI_3_Msub_n0005_inst_cy_16,
      I1 => XLXI_3_pwm_high_0_GROM,
      O => XLXI_3_n0005(1)
    );
  XLXI_3_pwm_high_0_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_high_0_SRMUX_OUTPUTNOT
    );
  XLXI_3_pwm_high_0_CYINIT_139 : X_BUF
    port map (
      I => XLXI_3_pwm_high_0_LOGIC_ONE,
      O => XLXI_3_pwm_high_0_CYINIT
    );
  XLXI_3_Msub_n0005_inst_cy_18_140 : X_MUX2
    port map (
      IA => XLXI_3_n0011(2),
      IB => XLXI_3_pwm_high_2_CYINIT,
      SEL => XLXI_3_pwm_high_2_FROM,
      O => XLXI_3_Msub_n0005_inst_cy_18
    );
  XLXI_3_Msub_n0005_inst_sum_10 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_high_2_CYINIT,
      I1 => XLXI_3_pwm_high_2_FROM,
      O => XLXI_3_n0005(2)
    );
  XLXI_3_pwm_high_2_F : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_3_n0011(2),
      ADR1 => XLXI_3_Msub_n0005_inst_lut2_18,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_pwm_high_2_FROM
    );
  XLXI_3_pwm_high_2_G : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_3_n0011(3),
      ADR1 => XLXI_3_Msub_n0005_inst_lut2_19,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_pwm_high_2_GROM
    );
  XLXI_3_pwm_high_2_COUTUSED : X_BUF
    port map (
      I => XLXI_3_pwm_high_2_CYMUXG,
      O => XLXI_3_Msub_n0005_inst_cy_19
    );
  XLXI_3_Msub_n0005_inst_cy_19_141 : X_MUX2
    port map (
      IA => XLXI_3_n0011(3),
      IB => XLXI_3_Msub_n0005_inst_cy_18,
      SEL => XLXI_3_pwm_high_2_GROM,
      O => XLXI_3_pwm_high_2_CYMUXG
    );
  XLXI_3_Msub_n0005_inst_sum_11 : X_XOR2
    port map (
      I0 => XLXI_3_Msub_n0005_inst_cy_18,
      I1 => XLXI_3_pwm_high_2_GROM,
      O => XLXI_3_n0005(3)
    );
  XLXI_3_pwm_high_2_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_high_2_SRMUX_OUTPUTNOT
    );
  XLXI_3_pwm_high_2_CYINIT_142 : X_BUF
    port map (
      I => XLXI_3_Msub_n0005_inst_cy_17,
      O => XLXI_3_pwm_high_2_CYINIT
    );
  XLXI_3_Msub_n0005_inst_cy_20_143 : X_MUX2
    port map (
      IA => XLXI_3_n0011(4),
      IB => XLXI_3_pwm_high_4_CYINIT,
      SEL => XLXI_3_pwm_high_4_FROM,
      O => XLXI_3_Msub_n0005_inst_cy_20
    );
  XLXI_3_Msub_n0005_inst_sum_12 : X_XOR2
    port map (
      I0 => XLXI_3_pwm_high_4_CYINIT,
      I1 => XLXI_3_pwm_high_4_FROM,
      O => XLXI_3_n0005(4)
    );
  XLXI_3_pwm_high_4_F : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_3_n0011(4),
      ADR1 => XLXI_3_Msub_n0005_inst_lut2_20,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_pwm_high_4_FROM
    );
  XLXI_3_pwm_high_4_G : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => XLXI_3_n0011(5),
      ADR1 => XLXI_3_Msub_n0005_inst_lut2_21,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_pwm_high_4_GROM
    );
  XLXI_3_pwm_high_4_COUTUSED : X_BUF
    port map (
      I => XLXI_3_pwm_high_4_CYMUXG,
      O => XLXI_3_Msub_n0005_inst_cy_21
    );
  XLXI_3_Msub_n0005_inst_cy_21_144 : X_MUX2
    port map (
      IA => XLXI_3_n0011(5),
      IB => XLXI_3_Msub_n0005_inst_cy_20,
      SEL => XLXI_3_pwm_high_4_GROM,
      O => XLXI_3_pwm_high_4_CYMUXG
    );
  XLXI_3_Msub_n0005_inst_sum_13 : X_XOR2
    port map (
      I0 => XLXI_3_Msub_n0005_inst_cy_20,
      I1 => XLXI_3_pwm_high_4_GROM,
      O => XLXI_3_n0005(5)
    );
  XLXI_3_pwm_high_4_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_high_4_SRMUX_OUTPUTNOT
    );
  XLXI_3_pwm_high_4_CYINIT_145 : X_BUF
    port map (
      I => XLXI_3_Msub_n0005_inst_cy_19,
      O => XLXI_3_pwm_high_4_CYINIT
    );
  XLXI_3_Msub_n0005_inst_cy_22_146 : X_MUX2
    port map (
      IA => XLXI_3_n0011(6),
      IB => XLXI_3_pwm_high_6_CYINIT,
      SEL => XLXI_3_pwm_high_6_FROM,
      O => XLXI_3_Msub_n0005_inst_cy_22
    );
  XLXI_3_Msub_n0005_inst_sum_14 : X_XOR2
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
      ADR1 => XLXI_3_Msub_n0005_inst_lut2_22,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_pwm_high_6_FROM
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
  XLXI_3_Msub_n0005_inst_sum_15 : X_XOR2
    port map (
      I0 => XLXI_3_Msub_n0005_inst_cy_22,
      I1 => XLXI_3_Msub_n0005_inst_lut2_231_O,
      O => XLXI_3_n0005(7)
    );
  XLXI_3_pwm_high_6_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_high_6_SRMUX_OUTPUTNOT
    );
  XLXI_3_pwm_high_6_CYINIT_147 : X_BUF
    port map (
      I => XLXI_3_Msub_n0005_inst_cy_21,
      O => XLXI_3_pwm_high_6_CYINIT
    );
  XLXI_3_Mcompar_n0013_inst_cy_25_LOGIC_ZERO_148 : X_ZERO
    port map (
      O => XLXI_3_Mcompar_n0013_inst_cy_25_LOGIC_ZERO
    );
  XLXI_3_Mcompar_n0013_inst_cy_24_149 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(0),
      IB => XLXI_3_Mcompar_n0013_inst_cy_25_LOGIC_ZERO,
      SEL => XLXI_3_Mcompar_n0013_inst_lut2_24,
      O => XLXI_3_Mcompar_n0013_inst_cy_24
    );
  XLXI_3_Mcompar_n0013_inst_lut2_241 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(0),
      ADR1 => XLXI_3_pwm_count(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0013_inst_lut2_24
    );
  XLXI_3_Mcompar_n0013_inst_lut2_251 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(1),
      ADR1 => XLXI_3_pwm_count(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0013_inst_lut2_25
    );
  XLXI_3_Mcompar_n0013_inst_cy_25_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0013_inst_cy_25_CYMUXG,
      O => XLXI_3_Mcompar_n0013_inst_cy_25
    );
  XLXI_3_Mcompar_n0013_inst_cy_25_150 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(1),
      IB => XLXI_3_Mcompar_n0013_inst_cy_24,
      SEL => XLXI_3_Mcompar_n0013_inst_lut2_25,
      O => XLXI_3_Mcompar_n0013_inst_cy_25_CYMUXG
    );
  XLXI_3_Mcompar_n0013_inst_cy_26_151 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(2),
      IB => XLXI_3_Mcompar_n0013_inst_cy_27_CYINIT,
      SEL => XLXI_3_Mcompar_n0013_inst_lut2_26,
      O => XLXI_3_Mcompar_n0013_inst_cy_26
    );
  XLXI_3_Mcompar_n0013_inst_lut2_261 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(2),
      ADR1 => XLXI_3_pwm_count(2),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0013_inst_lut2_26
    );
  XLXI_3_Mcompar_n0013_inst_lut2_271 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(3),
      ADR1 => XLXI_3_pwm_count(3),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0013_inst_lut2_27
    );
  XLXI_3_Mcompar_n0013_inst_cy_27_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0013_inst_cy_27_CYMUXG,
      O => XLXI_3_Mcompar_n0013_inst_cy_27
    );
  XLXI_3_Mcompar_n0013_inst_cy_27_152 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(3),
      IB => XLXI_3_Mcompar_n0013_inst_cy_26,
      SEL => XLXI_3_Mcompar_n0013_inst_lut2_27,
      O => XLXI_3_Mcompar_n0013_inst_cy_27_CYMUXG
    );
  XLXI_3_Mcompar_n0013_inst_cy_27_CYINIT_153 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0013_inst_cy_25,
      O => XLXI_3_Mcompar_n0013_inst_cy_27_CYINIT
    );
  XLXI_3_Mcompar_n0013_inst_cy_28_154 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(4),
      IB => XLXI_3_Mcompar_n0013_inst_cy_29_CYINIT,
      SEL => XLXI_3_Mcompar_n0013_inst_lut2_28,
      O => XLXI_3_Mcompar_n0013_inst_cy_28
    );
  XLXI_3_Mcompar_n0013_inst_lut2_281 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(4),
      ADR1 => XLXI_3_pwm_count(4),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0013_inst_lut2_28
    );
  XLXI_3_Mcompar_n0013_inst_lut2_291 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(5),
      ADR1 => XLXI_3_pwm_count(5),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0013_inst_lut2_29
    );
  XLXI_3_Mcompar_n0013_inst_cy_29_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0013_inst_cy_29_CYMUXG,
      O => XLXI_3_Mcompar_n0013_inst_cy_29
    );
  XLXI_3_Mcompar_n0013_inst_cy_29_155 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(5),
      IB => XLXI_3_Mcompar_n0013_inst_cy_28,
      SEL => XLXI_3_Mcompar_n0013_inst_lut2_29,
      O => XLXI_3_Mcompar_n0013_inst_cy_29_CYMUXG
    );
  XLXI_3_Mcompar_n0013_inst_cy_29_CYINIT_156 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0013_inst_cy_27,
      O => XLXI_3_Mcompar_n0013_inst_cy_29_CYINIT
    );
  XLXI_3_Mcompar_n0013_inst_cy_30_157 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(6),
      IB => XLXI_3_Mcompar_n0013_inst_cy_31_CYINIT,
      SEL => XLXI_3_Mcompar_n0013_inst_lut2_30,
      O => XLXI_3_Mcompar_n0013_inst_cy_30
    );
  XLXI_3_Mcompar_n0013_inst_lut2_301 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(6),
      ADR1 => XLXI_3_pwm_count(6),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0013_inst_lut2_30
    );
  XLXI_3_Mcompar_n0013_inst_lut2_311 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => XLXI_3_pwm_high(7),
      ADR1 => XLXI_3_pwm_count(7),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_Mcompar_n0013_inst_lut2_31
    );
  XLXI_3_Mcompar_n0013_inst_cy_31_COUTUSED : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0013_inst_cy_31_CYMUXG,
      O => XLXI_3_Mcompar_n0013_inst_cy_31
    );
  XLXI_3_Mcompar_n0013_inst_cy_31_158 : X_MUX2
    port map (
      IA => XLXI_3_pwm_high(7),
      IB => XLXI_3_Mcompar_n0013_inst_cy_30,
      SEL => XLXI_3_Mcompar_n0013_inst_lut2_31,
      O => XLXI_3_Mcompar_n0013_inst_cy_31_CYMUXG
    );
  XLXI_3_Mcompar_n0013_inst_cy_31_CYINIT_159 : X_BUF
    port map (
      I => XLXI_3_Mcompar_n0013_inst_cy_29,
      O => XLXI_3_Mcompar_n0013_inst_cy_31_CYINIT
    );
  XLXI_10_I1_n0011_5_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_5,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_5,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_1_5_FROM
    );
  XLXI_10_I1_n0011_5_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0011_5_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_5,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0011_5_19_O
    );
  XLXI_10_I1_stack_addrs_c_1_5_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_1_5_FROM,
      O => XLXI_10_I1_n0011_5_19_SW0_O
    );
  XLXI_10_I1_stack_addrs_c_0_1_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_0_1_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_0_1_160 : X_FF
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
  XLXI_10_I1_n0012_1_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_1,
      ADR2 => XLXI_10_I1_n0013(1),
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_0_1_FROM
    );
  XLXI_10_I1_n0012_1_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0012_1_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_1,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0012_1_19_O
    );
  XLXI_10_I1_stack_addrs_c_0_1_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_0_1_FROM,
      O => XLXI_10_I1_n0012_1_19_SW0_O
    );
  XLXI_10_I1_n0012_2_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_2,
      ADR2 => XLXI_10_I1_n0013(2),
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_0_2_FROM
    );
  XLXI_10_I1_n0012_2_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0012_2_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_2,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0012_2_19_O
    );
  XLXI_10_I1_stack_addrs_c_0_2_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_0_2_FROM,
      O => XLXI_10_I1_n0012_2_19_SW0_O
    );
  XLXI_10_I1_n0011_6_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_6,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_6,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_1_6_FROM
    );
  XLXI_10_I1_n0011_6_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0011_6_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_6,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0011_6_19_O
    );
  XLXI_10_I1_stack_addrs_c_1_6_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_1_6_FROM,
      O => XLXI_10_I1_n0011_6_19_SW0_O
    );
  XLXI_10_I1_n0012_3_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_3,
      ADR2 => XLXI_10_I1_n0013(3),
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_0_3_FROM
    );
  XLXI_10_I1_n0012_3_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0012_3_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_3,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0012_3_19_O
    );
  XLXI_10_I1_stack_addrs_c_0_3_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_0_3_FROM,
      O => XLXI_10_I1_n0012_3_19_SW0_O
    );
  XLXI_10_I1_n0012_4_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_4,
      ADR2 => XLXI_10_I1_n0013(4),
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_0_4_FROM
    );
  XLXI_10_I1_n0012_4_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0012_4_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_4,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0012_4_19_O
    );
  XLXI_10_I1_stack_addrs_c_0_4_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_0_4_FROM,
      O => XLXI_10_I1_n0012_4_19_SW0_O
    );
  XLXI_10_I1_n0012_5_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_5,
      ADR2 => XLXI_10_I1_n0013(5),
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_0_5_FROM
    );
  XLXI_10_I1_n0012_5_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0012_5_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_5,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
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
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0012_6_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_6,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0012_6_19_O
    );
  XLXI_10_I1_stack_addrs_c_0_6_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_0_6_FROM,
      O => XLXI_10_I1_n0012_6_19_SW0_O
    );
  XLXI_10_I2_Ker83571 : X_LUT4
    generic map(
      INIT => X"2222"
    )
    port map (
      ADR0 => XLXI_10_I2_nreset_v(1),
      ADR1 => XLXI_10_skip,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I2_N8359_FROM
    );
  XLXI_10_I2_pc_mux_x_1_Q : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_10_I2_N8359,
      ADR1 => XLXI_10_I2_N8283,
      ADR2 => NRESET_IBUF,
      ADR3 => N22263,
      O => XLXI_10_I2_N8359_GROM
    );
  XLXI_10_I2_N8359_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_N8359_FROM,
      O => XLXI_10_I2_N8359
    );
  XLXI_10_I2_N8359_YUSED : X_BUF
    port map (
      I => XLXI_10_I2_N8359_GROM,
      O => XLXI_10_pc_mux(1)
    );
  XLXI_10_I1_n00161 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(1),
      ADR1 => XLXI_10_pc_mux(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_3_1_FROM
    );
  XLXI_10_I1_n0009_1_1 : X_LUT4
    generic map(
      INIT => X"4F40"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_1,
      ADR2 => XLXI_10_I1_n0016,
      ADR3 => XLXI_10_I1_stack_addrs_c_3_1,
      O => XLXI_10_I1_n0009_1_1_O
    );
  XLXI_10_I1_stack_addrs_c_3_1_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_3_1_FROM,
      O => XLXI_10_I1_n0016
    );
  XLXI_10_I1_iaddr_x_0_31 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => N25128,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_pc_0_FROM
    );
  XLXI_10_I1_iaddr_x_0_52 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => XLXI_10_I1_iaddr_x_0_31_O,
      ADR2 => CHOICE1924,
      ADR3 => XLXI_10_pc_mux(2),
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
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => N25132,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_pc_1_FROM
    );
  XLXI_10_I1_iaddr_x_1_50 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => XLXI_10_I1_iaddr_x_1_31_O,
      ADR2 => CHOICE1819,
      ADR3 => XLXI_10_pc_mux(2),
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
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => N25136,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_pc_2_FROM
    );
  XLXI_10_I1_iaddr_x_2_50 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => XLXI_10_I1_iaddr_x_2_31_O,
      ADR2 => CHOICE1834,
      ADR3 => XLXI_10_pc_mux(2),
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
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => N25140,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_pc_3_FROM
    );
  XLXI_10_I1_iaddr_x_3_50 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => XLXI_10_I1_iaddr_x_3_31_O,
      ADR2 => CHOICE1909,
      ADR3 => XLXI_10_pc_mux(2),
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
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => N25144,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_pc_4_FROM
    );
  XLXI_10_I1_iaddr_x_4_50 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => XLXI_10_I1_iaddr_x_4_31_O,
      ADR2 => CHOICE1894,
      ADR3 => XLXI_10_pc_mux(2),
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
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => N25148,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_pc_5_FROM
    );
  XLXI_10_I1_iaddr_x_5_50 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => XLXI_10_I1_iaddr_x_5_31_O,
      ADR2 => CHOICE1879,
      ADR3 => XLXI_10_pc_mux(2),
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
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => N25152,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_pc_6_FROM
    );
  XLXI_10_I1_iaddr_x_6_50 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => XLXI_10_I1_iaddr_x_6_31_O,
      ADR2 => CHOICE1849,
      ADR3 => XLXI_10_pc_mux(2),
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
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => N25156,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_pc_7_FROM
    );
  XLXI_10_I1_iaddr_x_7_50 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I1_n0014,
      ADR1 => XLXI_10_I1_iaddr_x_7_31_O,
      ADR2 => CHOICE1864,
      ADR3 => XLXI_10_pc_mux(2),
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
      INIT => X"EFFF"
    )
    port map (
      ADR0 => XLXI_10_skip,
      ADR1 => N24084,
      ADR2 => XLXI_10_I2_nreset_v(1),
      ADR3 => NRESET_IBUF,
      O => N24761_FROM
    );
  XLXI_10_I2_ndre_x : X_LUT4
    generic map(
      INIT => X"FFF1"
    )
    port map (
      ADR0 => XLXN_8(1),
      ADR1 => XLXN_8(2),
      ADR2 => N24761,
      ADR3 => XLXN_8(3),
      O => N24761_GROM
    );
  N24761_XUSED : X_BUF
    port map (
      I => N24761_FROM,
      O => N24761
    );
  N24761_YUSED : X_BUF
    port map (
      I => N24761_GROM,
      O => XLXI_10_ndre_int
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
      O => CPU_DADDR_3_OBUF_FROM
    );
  XLXI_3_Ker69031_SW9_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => XLXI_3_pwm_low(0),
      ADR2 => XLXI_3_pwm_period(0),
      ADR3 => VCC,
      O => CPU_DADDR_3_OBUF_GROM
    );
  CPU_DADDR_3_OBUF_XUSED : X_BUF
    port map (
      I => CPU_DADDR_3_OBUF_FROM,
      O => CPU_DADDR_3_OBUF
    );
  CPU_DADDR_3_OBUF_YUSED : X_BUF
    port map (
      I => CPU_DADDR_3_OBUF_GROM,
      O => N25166
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
  XLXI_2_pwm_data_c_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_2_pwm_data_c_1_SRMUX_OUTPUTNOT
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
  XLXI_2_pwm_data_c_3_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_2_pwm_data_c_3_SRMUX_OUTPUTNOT
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
      O => XLXI_10_I3_n0035_2_109_SW0_O_FROM
    );
  XLXI_10_I3_n0035_2_47_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => CHOICE2088,
      ADR1 => N24705,
      ADR2 => XLXI_10_I3_n0035_2_109_SW0_O,
      ADR3 => VCC,
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
      O => N25174
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
      O => XLXI_10_I3_data_x_1_FROM
    );
  XLXI_10_I3_n0035_1_6 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_1,
      ADR1 => XLXI_10_I3_N9013,
      ADR2 => XLXI_10_I3_data_x(1),
      ADR3 => XLXI_10_I3_N9052,
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
      O => CHOICE2035
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
      O => XLXI_10_I3_data_x_2_FROM
    );
  XLXI_10_I3_n0035_2_6 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_2,
      ADR1 => XLXI_10_I3_N9013,
      ADR2 => XLXI_10_I3_data_x(2),
      ADR3 => XLXI_10_I3_N9052,
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
      O => CHOICE2079
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
      O => XLXI_10_I3_n0035_3_109_SW0_O_FROM
    );
  XLXI_10_I3_n0035_3_47_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => CHOICE2176,
      ADR1 => N24699,
      ADR2 => XLXI_10_I3_n0035_3_109_SW0_O,
      ADR3 => VCC,
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
      O => N25184
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
      O => XLXI_10_I3_data_x_3_FROM
    );
  XLXI_10_I3_n0035_3_6 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_3,
      ADR1 => XLXI_10_I3_N9013,
      ADR2 => XLXI_10_I3_data_x(3),
      ADR3 => XLXI_10_I3_N9052,
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
      O => CHOICE2167
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
      O => CHOICE2131_FROM
    );
  XLXI_10_I3_Madd_n0064_inst_lut2_321 : X_LUT4
    generic map(
      INIT => X"3237"
    )
    port map (
      ADR0 => CHOICE2128,
      ADR1 => N24745,
      ADR2 => CHOICE2131,
      ADR3 => N24743,
      O => CHOICE2131_GROM
    );
  CHOICE2131_XUSED : X_BUF
    port map (
      I => CHOICE2131_FROM,
      O => CHOICE2131
    );
  CHOICE2131_YUSED : X_BUF
    port map (
      I => CHOICE2131_GROM,
      O => XLXI_10_I3_Madd_n0064_inst_lut2_32
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
      O => CHOICE2070_FROM
    );
  XLXI_10_I3_Madd_n0064_inst_lut2_331 : X_LUT4
    generic map(
      INIT => X"3237"
    )
    port map (
      ADR0 => CHOICE2067,
      ADR1 => N24675,
      ADR2 => CHOICE2070,
      ADR3 => N24667,
      O => CHOICE2070_GROM
    );
  CHOICE2070_XUSED : X_BUF
    port map (
      I => CHOICE2070_FROM,
      O => CHOICE2070
    );
  CHOICE2070_YUSED : X_BUF
    port map (
      I => CHOICE2070_GROM,
      O => XLXI_10_I3_Madd_n0064_inst_lut2_33
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
      O => XLXI_3_Ker69031_SW0_O_FROM
    );
  XLXI_3_Mmux_n0011_Result_0_1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => N24633,
      ADR1 => CPU_DATA_OUT_0_OBUF,
      ADR2 => N23342,
      ADR3 => XLXI_3_Ker69031_SW0_O,
      O => XLXI_3_Ker69031_SW0_O_GROM
    );
  XLXI_3_Ker69031_SW0_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW0_O_FROM,
      O => XLXI_3_Ker69031_SW0_O
    );
  XLXI_3_Ker69031_SW0_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW0_O_GROM,
      O => XLXI_3_n0011(0)
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
      O => XLXI_3_Ker69031_SW1_O_FROM
    );
  XLXI_3_Mmux_n0011_Result_1_1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => N24633,
      ADR1 => CPU_DATA_OUT_1_OBUF,
      ADR2 => N23342,
      ADR3 => XLXI_3_Ker69031_SW1_O,
      O => XLXI_3_Ker69031_SW1_O_GROM
    );
  XLXI_3_Ker69031_SW1_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW1_O_FROM,
      O => XLXI_3_Ker69031_SW1_O
    );
  XLXI_3_Ker69031_SW1_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW1_O_GROM,
      O => XLXI_3_n0011(1)
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
      O => XLXI_3_Ker69031_SW2_O_FROM
    );
  XLXI_3_Mmux_n0011_Result_2_1 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => N24633,
      ADR1 => CPU_DATA_OUT_2_OBUF,
      ADR2 => N23342,
      ADR3 => XLXI_3_Ker69031_SW2_O,
      O => XLXI_3_Ker69031_SW2_O_GROM
    );
  XLXI_3_Ker69031_SW2_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW2_O_FROM,
      O => XLXI_3_Ker69031_SW2_O
    );
  XLXI_3_Ker69031_SW2_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW2_O_GROM,
      O => XLXI_3_n0011(2)
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
      O => XLXI_3_N6905_FROM
    );
  XLXI_3_Mmux_n0011_Result_3_1 : X_LUT4
    generic map(
      INIT => X"D580"
    )
    port map (
      ADR0 => XLXI_3_N6905,
      ADR1 => XLXI_10_I3_acc_c_0_3,
      ADR2 => XLXI_10_I4_N9730,
      ADR3 => XLXI_3_pwm_period(3),
      O => XLXI_3_N6905_GROM
    );
  XLXI_3_N6905_XUSED : X_BUF
    port map (
      I => XLXI_3_N6905_FROM,
      O => XLXI_3_N6905
    );
  XLXI_3_N6905_YUSED : X_BUF
    port map (
      I => XLXI_3_N6905_GROM,
      O => XLXI_3_n0011(3)
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
      O => XLXI_2_nCS_PWM_SW0_SW0_O_FROM
    );
  XLXI_2_nCS_PWM_SW0 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => XLXI_10_I4_N9712,
      ADR1 => N24767,
      ADR2 => XLXI_10_ndre_int,
      ADR3 => XLXI_2_nCS_PWM_SW0_SW0_O,
      O => XLXI_2_nCS_PWM_SW0_SW0_O_GROM
    );
  XLXI_2_nCS_PWM_SW0_SW0_O_XUSED : X_BUF
    port map (
      I => XLXI_2_nCS_PWM_SW0_SW0_O_FROM,
      O => XLXI_2_nCS_PWM_SW0_SW0_O
    );
  XLXI_2_nCS_PWM_SW0_SW0_O_YUSED : X_BUF
    port map (
      I => XLXI_2_nCS_PWM_SW0_SW0_O_GROM,
      O => N23342
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
  XLXI_3_n0006_5_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_3_N6924,
      ADR1 => XLXI_3_pwm_period(5),
      ADR2 => XLXI_2_pwm_data_c(1),
      ADR3 => VCC,
      O => XLXI_3_n0006_5_1_O
    );
  XLXI_3_n0006_4_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_3_N6924,
      ADR1 => XLXI_3_pwm_period(4),
      ADR2 => XLXI_2_pwm_data_c(0),
      ADR3 => VCC,
      O => XLXI_3_n0006_4_1_O
    );
  XLXI_3_n0006_7_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_3_N6924,
      ADR1 => XLXI_3_pwm_period(7),
      ADR2 => XLXI_2_pwm_data_c(3),
      ADR3 => VCC,
      O => XLXI_3_n0006_7_1_O
    );
  XLXI_3_n0006_6_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_3_N6924,
      ADR1 => XLXI_3_pwm_period(6),
      ADR2 => XLXI_2_pwm_data_c(2),
      ADR3 => VCC,
      O => XLXI_3_n0006_6_1_O
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
      O => CHOICE2128_FROM
    );
  XLXI_10_I3_Msub_n0059_inst_lut2_361 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => CHOICE2128,
      ADR1 => N24745,
      ADR2 => CHOICE2131,
      ADR3 => N24743,
      O => CHOICE2128_GROM
    );
  CHOICE2128_XUSED : X_BUF
    port map (
      I => CHOICE2128_FROM,
      O => CHOICE2128
    );
  CHOICE2128_YUSED : X_BUF
    port map (
      I => CHOICE2128_GROM,
      O => XLXI_10_I3_Msub_n0059_inst_lut2_36
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
      O => CHOICE2067_FROM
    );
  XLXI_10_I3_Msub_n0059_inst_lut2_371 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => CHOICE2067,
      ADR1 => N24669,
      ADR2 => CHOICE2070,
      ADR3 => N24667,
      O => CHOICE2067_GROM
    );
  CHOICE2067_XUSED : X_BUF
    port map (
      I => CHOICE2067_FROM,
      O => CHOICE2067
    );
  CHOICE2067_YUSED : X_BUF
    port map (
      I => CHOICE2067_GROM,
      O => XLXI_10_I3_Msub_n0059_inst_lut2_37
    );
  XLXI_10_I3_Ker906235 : X_LUT4
    generic map(
      INIT => X"AEAE"
    )
    port map (
      ADR0 => CHOICE1448,
      ADR1 => CHOICE1457,
      ADR2 => XLXI_10_I2_TD_c(1),
      ADR3 => VCC,
      O => XLXI_10_I3_N9064_FROM
    );
  XLXI_10_I3_Ker90111 : X_LUT4
    generic map(
      INIT => X"FFA8"
    )
    port map (
      ADR0 => XLXI_10_I3_N8884,
      ADR1 => XLXI_10_I3_n0045,
      ADR2 => XLXI_10_I3_n0054,
      ADR3 => XLXI_10_I3_N9064,
      O => XLXI_10_I3_N9064_GROM
    );
  XLXI_10_I3_N9064_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_N9064_FROM,
      O => XLXI_10_I3_N9064
    );
  XLXI_10_I3_N9064_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_N9064_GROM,
      O => XLXI_10_I3_N9013
    );
  XLXI_10_I1_n0012_0_19_SW0 : X_LUT4
    generic map(
      INIT => X"8D8D"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_0,
      ADR2 => XLXI_10_I1_pc(0),
      ADR3 => VCC,
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
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0011_1_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_1,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0011_1_19_O
    );
  XLXI_10_I1_stack_addrs_c_1_1_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_1_1_FROM,
      O => XLXI_10_I1_n0011_1_19_SW0_O
    );
  XLXI_2_ctrl_data_c_1 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => CTRL_DATA_OUT_1_OD,
      CE => XLXI_2_n0043,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => CTRL_DATA_OUT_1_SRMUXNOT,
      O => XLXI_2_ctrl_data_c(1)
    );
  XLXI_10_I1_n0011_2_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_2,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_2,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_1_2_FROM
    );
  XLXI_10_I1_n0011_2_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0011_2_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_2,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0011_2_19_O
    );
  XLXI_10_I1_stack_addrs_c_1_2_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_1_2_FROM,
      O => XLXI_10_I1_n0011_2_19_SW0_O
    );
  XLXI_10_I1_n0011_3_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_3,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_3,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_1_3_FROM
    );
  XLXI_10_I1_n0011_3_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0011_3_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_3,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0011_3_19_O
    );
  XLXI_10_I1_stack_addrs_c_1_3_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_1_3_FROM,
      O => XLXI_10_I1_n0011_3_19_SW0_O
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
  XLXI_10_I1_n0011_4_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_4,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_4,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_1_4_FROM
    );
  XLXI_10_I1_n0011_4_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0011_4_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_4,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0011_4_19_O
    );
  XLXI_10_I1_stack_addrs_c_1_4_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_1_4_FROM,
      O => XLXI_10_I1_n0011_4_19_SW0_O
    );
  XLXI_10_I1_n0010_1_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_1,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_2_1_FROM
    );
  XLXI_10_I1_n0010_1_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0010_1_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_1,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0010_1_19_O
    );
  XLXI_10_I1_stack_addrs_c_2_1_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_2_1_FROM,
      O => XLXI_10_I1_n0010_1_19_SW0_O
    );
  XLXI_10_I1_n0010_2_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_2,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_2,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_2_2_FROM
    );
  XLXI_10_I1_n0010_2_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0010_2_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_2,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0010_2_19_O
    );
  XLXI_10_I1_stack_addrs_c_2_2_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_2_2_FROM,
      O => XLXI_10_I1_n0010_2_19_SW0_O
    );
  XLXI_10_I1_n0010_3_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_3,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_3,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_2_3_FROM
    );
  XLXI_10_I1_n0010_3_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0010_3_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_3,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0010_3_19_O
    );
  XLXI_10_I1_stack_addrs_c_2_3_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_2_3_FROM,
      O => XLXI_10_I1_n0010_3_19_SW0_O
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
  XLXI_10_I1_n0010_4_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_4,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_4,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_2_4_FROM
    );
  XLXI_10_I1_n0010_4_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0010_4_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_4,
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
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_5,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_5,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_2_5_FROM
    );
  XLXI_10_I1_n0010_5_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0010_5_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_5,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0010_5_19_O
    );
  XLXI_10_I1_stack_addrs_c_2_5_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_2_5_FROM,
      O => XLXI_10_I1_n0010_5_19_SW0_O
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
  XLXI_10_I1_n0010_6_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_6,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_6,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_2_6_FROM
    );
  XLXI_10_I1_n0010_6_19 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => XLXI_10_I1_n0010_6_19_SW0_O,
      ADR1 => XLXI_10_I2_pc_mux_x_1_1,
      ADR2 => XLXI_10_I1_stack_addrs_c_2_6,
      ADR3 => XLXI_10_I2_pc_mux_x_0_17_1,
      O => XLXI_10_I1_n0010_6_19_O
    );
  XLXI_10_I1_stack_addrs_c_2_6_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_2_6_FROM,
      O => XLXI_10_I1_n0010_6_19_SW0_O
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
  XLXI_10_I3_n0035_0_27 : X_LUT4
    generic map(
      INIT => X"D8A8"
    )
    port map (
      ADR0 => XLXI_10_I3_data_x(0),
      ADR1 => XLXI_10_I3_N8915,
      ADR2 => XLXI_10_I3_n0053,
      ADR3 => XLXI_10_I3_acc_c_0_0,
      O => XLXI_10_I3_n0035_0_27_O_FROM
    );
  XLXI_10_I3_n0035_0_41 : X_LUT4
    generic map(
      INIT => X"FFEA"
    )
    port map (
      ADR0 => XLXI_10_I3_n0035_0_27_O,
      ADR1 => XLXI_10_I3_n0059(0),
      ADR2 => XLXI_10_I3_n0055,
      ADR3 => N24629,
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
      O => CHOICE1956
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
      O => XLXI_10_I3_data_x_0_FROM
    );
  XLXI_10_I3_n0035_0_88 : X_LUT4
    generic map(
      INIT => X"B900"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(2),
      ADR1 => XLXI_10_I2_TD_c(1),
      ADR2 => XLXI_10_I3_data_x(0),
      ADR3 => CHOICE1965,
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
      O => CHOICE1966
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
      O => XLXI_10_pc_mux_2_FROM
    );
  XLXI_10_I1_iaddr_x_3_31_SW0 : X_LUT4
    generic map(
      INIT => X"9180"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(1),
      ADR1 => XLXI_10_pc_mux(2),
      ADR2 => XLXI_10_I1_stack_addrs_c_0_3,
      ADR3 => XLXI_10_I1_n0013(3),
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
      O => N25140
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
      O => XLXI_10_I3_acc_c_0_4_FROM
    );
  XLXI_10_I3_n0035_4_96 : X_LUT4
    generic map(
      INIT => X"FBEA"
    )
    port map (
      ADR0 => CHOICE2010,
      ADR1 => XLXI_10_I3_n0059(4),
      ADR2 => XLXI_10_I3_n0035_4_11_SW1_O,
      ADR3 => N24827,
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
  XLXI_10_I3_n0035_0_107_SW0 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => XLXI_10_I3_N9047,
      ADR1 => CHOICE1984,
      ADR2 => CHOICE1966,
      ADR3 => XLXI_10_I3_N8884,
      O => XLXI_10_I3_acc_c_0_0_FROM
    );
  XLXI_10_I3_n0035_0_220 : X_LUT4
    generic map(
      INIT => X"FBEA"
    )
    port map (
      ADR0 => CHOICE1944,
      ADR1 => CHOICE1956,
      ADR2 => N24693,
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
      INIT => X"FFEA"
    )
    port map (
      ADR0 => CHOICE2036,
      ADR1 => XLXI_10_I3_n0048,
      ADR2 => XLXI_10_I3_n0064(1),
      ADR3 => CHOICE2044,
      O => XLXI_10_I3_acc_c_0_1_FROM
    );
  XLXI_10_I3_n0035_1_145 : X_LUT4
    generic map(
      INIT => X"FBEA"
    )
    port map (
      ADR0 => CHOICE2032,
      ADR1 => XLXI_10_I3_n0035_1_47_O,
      ADR2 => N24711,
      ADR3 => N24709,
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
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N24705,
      ADR1 => XLXI_10_I3_n0064(2),
      ADR2 => N25174,
      ADR3 => XLXI_10_I3_n0048,
      O => XLXI_10_I3_acc_c_0_2_FROM
    );
  XLXI_10_I3_n0035_2_145 : X_LUT4
    generic map(
      INIT => X"FBEA"
    )
    port map (
      ADR0 => CHOICE2076,
      ADR1 => CHOICE2080,
      ADR2 => N24705,
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
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N24699,
      ADR1 => XLXI_10_I3_n0064(3),
      ADR2 => N25184,
      ADR3 => XLXI_10_I3_n0048,
      O => XLXI_10_I3_acc_c_0_3_FROM
    );
  XLXI_10_I3_n0035_3_145 : X_LUT4
    generic map(
      INIT => X"FBEA"
    )
    port map (
      ADR0 => CHOICE2164,
      ADR1 => CHOICE2168,
      ADR2 => N24699,
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
  XLXI_10_I3_n00621 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(2),
      ADR1 => XLXI_10_I2_valid_c,
      ADR2 => XLXI_10_I3_nreset_v(1),
      ADR3 => XLXI_10_I3_nreset_v(0),
      O => XLXI_10_I3_n0062_FROM
    );
  XLXI_10_I3_n0035_2_0 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_I3_n0062,
      ADR1 => XLXI_10_I3_acc_c_0_2,
      ADR2 => VCC,
      ADR3 => VCC,
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
      O => CHOICE2076
    );
  XLXI_10_I3_n0035_0_164 : X_LUT4
    generic map(
      INIT => X"0101"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(0),
      ADR1 => XLXI_10_I2_TC_c(1),
      ADR2 => XLXI_10_I2_TD_c(3),
      ADR3 => VCC,
      O => CHOICE1982_FROM
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
      O => CHOICE1982_GROM
    );
  CHOICE1982_XUSED : X_BUF
    port map (
      I => CHOICE1982_FROM,
      O => CHOICE1982
    );
  CHOICE1982_YUSED : X_BUF
    port map (
      I => CHOICE1982_GROM,
      O => N24709
    );
  XLXI_10_I2_TD_x_0_26 : X_LUT4
    generic map(
      INIT => X"1111"
    )
    port map (
      ADR0 => XLXN_8(1),
      ADR1 => XLXN_8(3),
      ADR2 => VCC,
      ADR3 => VCC,
      O => CHOICE1762_FROM
    );
  XLXI_10_I2_pc_mux_x_0_17_1_161 : X_LUT4
    generic map(
      INIT => X"EEFE"
    )
    port map (
      ADR0 => XLXI_10_I2_N8327,
      ADR1 => CHOICE1708,
      ADR2 => XLXI_10_I2_N8267,
      ADR3 => XLXN_8(3),
      O => CHOICE1762_GROM
    );
  CHOICE1762_XUSED : X_BUF
    port map (
      I => CHOICE1762_FROM,
      O => CHOICE1762
    );
  CHOICE1762_YUSED : X_BUF
    port map (
      I => CHOICE1762_GROM,
      O => XLXI_10_I2_pc_mux_x_0_17_1
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
      O => N25128_FROM
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
      O => N25128_GROM
    );
  N25128_XUSED : X_BUF
    port map (
      I => N25128_FROM,
      O => N25128
    );
  N25128_YUSED : X_BUF
    port map (
      I => N25128_GROM,
      O => N25132
    );
  XLXI_10_I2_data_is_c_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_data_is_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_10_I2_data_is_c_3_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_data_is_c_3_SRMUX_OUTPUTNOT
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
      O => CHOICE2164_FROM
    );
  XLXI_10_I3_n0035_0_0 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => XLXI_10_I3_n0062,
      ADR2 => VCC,
      ADR3 => VCC,
      O => CHOICE2164_GROM
    );
  CHOICE2164_XUSED : X_BUF
    port map (
      I => CHOICE2164_FROM,
      O => CHOICE2164
    );
  CHOICE2164_YUSED : X_BUF
    port map (
      I => CHOICE2164_GROM,
      O => CHOICE1944
    );
  XLXI_10_I3_n0035_4_0 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_I3_n0062,
      ADR1 => XLXI_10_I3_acc_c_0_4,
      ADR2 => VCC,
      ADR3 => VCC,
      O => CHOICE2010_FROM
    );
  XLXI_10_I3_n0035_1_0 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_I3_n0062,
      ADR1 => XLXI_10_I3_acc_c_0_1,
      ADR2 => VCC,
      ADR3 => VCC,
      O => CHOICE2010_GROM
    );
  CHOICE2010_XUSED : X_BUF
    port map (
      I => CHOICE2010_FROM,
      O => CHOICE2010
    );
  CHOICE2010_YUSED : X_BUF
    port map (
      I => CHOICE2010_GROM,
      O => CHOICE2032
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
      O => CHOICE1740_FROM
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
      O => CHOICE1740_GROM
    );
  CHOICE1740_XUSED : X_BUF
    port map (
      I => CHOICE1740_FROM,
      O => CHOICE1740
    );
  CHOICE1740_YUSED : X_BUF
    port map (
      I => CHOICE1740_GROM,
      O => N24038
    );
  XLXI_10_I3_Ker89021 : X_LUT4
    generic map(
      INIT => X"1212"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(1),
      ADR1 => XLXI_10_I2_TD_c(0),
      ADR2 => XLXI_10_I2_TD_c(2),
      ADR3 => VCC,
      O => XLXI_10_I3_N8904_FROM
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
      O => XLXI_10_I3_N8904_GROM
    );
  XLXI_10_I3_N8904_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_N8904_FROM,
      O => XLXI_10_I3_N8904
    );
  XLXI_10_I3_N8904_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_N8904_GROM,
      O => CHOICE2036
    );
  XLXI_10_I3_Ker89131 : X_LUT4
    generic map(
      INIT => X"8282"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(1),
      ADR1 => XLXI_10_I2_TD_c(0),
      ADR2 => XLXI_10_I2_TD_c(2),
      ADR3 => VCC,
      O => XLXI_10_I3_N8915_FROM
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
      O => XLXI_10_I3_N8915_GROM
    );
  XLXI_10_I3_N8915_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_N8915_FROM,
      O => XLXI_10_I3_N8915
    );
  XLXI_10_I3_N8915_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_N8915_GROM,
      O => CHOICE2080
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
      O => CHOICE2155_FROM
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
      O => CHOICE2155_GROM
    );
  CHOICE2155_XUSED : X_BUF
    port map (
      I => CHOICE2155_FROM,
      O => CHOICE2155
    );
  CHOICE2155_YUSED : X_BUF
    port map (
      I => CHOICE2155_GROM,
      O => CHOICE2168
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
      O => CHOICE1984_FROM
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
      O => CHOICE1984_GROM
    );
  CHOICE1984_XUSED : X_BUF
    port map (
      I => CHOICE1984_FROM,
      O => CHOICE1984
    );
  CHOICE1984_YUSED : X_BUF
    port map (
      I => CHOICE1984_GROM,
      O => CHOICE2013
    );
  XLXI_10_I1_n0011_7_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_7,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_7,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_1_7_FROM
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
  XLXI_10_I1_stack_addrs_c_1_7_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_1_7_FROM,
      O => N25086
    );
  XLXI_10_I3_n0035_0_81 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => XLXI_10_I2_TD_c(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => CHOICE1965_FROM
    );
  XLXI_10_I3_n0035_0_41_SW0 : X_LUT4
    generic map(
      INIT => X"2828"
    )
    port map (
      ADR0 => XLXI_10_I3_n0048,
      ADR1 => XLXI_10_I3_data_x(0),
      ADR2 => XLXI_10_I3_acc_c_0_0,
      ADR3 => VCC,
      O => CHOICE1965_GROM
    );
  CHOICE1965_XUSED : X_BUF
    port map (
      I => CHOICE1965_FROM,
      O => CHOICE1965
    );
  CHOICE1965_YUSED : X_BUF
    port map (
      I => CHOICE1965_GROM,
      O => N24629
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
      O => N25152_FROM
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
      O => N25152_GROM
    );
  N25152_XUSED : X_BUF
    port map (
      I => N25152_FROM,
      O => N25152
    );
  N25152_YUSED : X_BUF
    port map (
      I => N25152_GROM,
      O => N25136
    );
  XLXI_10_I5_Mmux_daddr_out_Result_4_1_SW1 : X_LUT4
    generic map(
      INIT => X"EFEF"
    )
    port map (
      ADR0 => XLXI_10_I5_daddr_c(4),
      ADR1 => XLXI_10_I5_ndwe_c,
      ADR2 => NRESET_IBUF,
      ADR3 => VCC,
      O => N24779_FROM
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
      O => N24779_GROM
    );
  N24779_XUSED : X_BUF
    port map (
      I => N24779_FROM,
      O => N24779
    );
  N24779_YUSED : X_BUF
    port map (
      I => N24779_GROM,
      O => N24767
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
      O => N24653_FROM
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
      O => N24653_GROM
    );
  N24653_XUSED : X_BUF
    port map (
      I => N24653_FROM,
      O => N24653
    );
  N24653_YUSED : X_BUF
    port map (
      I => N24653_GROM,
      O => N24637
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
      O => N24641_FROM
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
      O => N24641_GROM
    );
  N24641_XUSED : X_BUF
    port map (
      I => N24641_FROM,
      O => N24641
    );
  N24641_YUSED : X_BUF
    port map (
      I => N24641_GROM,
      O => CPU_DADDR_0_OBUF
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
      O => N24645_FROM
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
      O => N24645_GROM
    );
  N24645_XUSED : X_BUF
    port map (
      I => N24645_FROM,
      O => N24645
    );
  N24645_YUSED : X_BUF
    port map (
      I => N24645_GROM,
      O => CPU_DADDR_1_OBUF
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
      O => XLXI_10_I4_n0044_FROM
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
      O => XLXI_10_I4_n0044_GROM
    );
  XLXI_10_I4_n0044_XUSED : X_BUF
    port map (
      I => XLXI_10_I4_n0044_FROM,
      O => XLXI_10_I4_n0044
    );
  XLXI_10_I4_n0044_YUSED : X_BUF
    port map (
      I => XLXI_10_I4_n0044_GROM,
      O => N24649
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
      O => XLXI_10_I3_Msub_n0059_inst_lut2_38_GROM
    );
  XLXI_10_I3_Msub_n0059_inst_lut2_38_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_Msub_n0059_inst_lut2_38_GROM,
      O => XLXI_10_I3_Msub_n0059_inst_lut2_38
    );
  XLXI_3_pwm_low_5_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_low_5_SRMUX_OUTPUTNOT
    );
  XLXI_3_pwm_low_7_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_3_pwm_low_7_SRMUX_OUTPUTNOT
    );
  XLXI_10_I1_n0011_0_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_2_0,
      ADR2 => XLXI_10_I1_stack_addrs_c_0_0,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_1_0_FROM
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
  XLXI_10_I1_stack_addrs_c_1_0_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_1_0_FROM,
      O => N25078
    );
  XLXI_10_I2_TD_x_0_2 : X_LUT4
    generic map(
      INIT => X"A8A8"
    )
    port map (
      ADR0 => XLXN_8(0),
      ADR1 => XLXN_8(1),
      ADR2 => XLXN_8(2),
      ADR3 => VCC,
      O => CHOICE1750_FROM
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
      O => CHOICE1750_GROM
    );
  CHOICE1750_XUSED : X_BUF
    port map (
      I => CHOICE1750_FROM,
      O => CHOICE1750
    );
  CHOICE1750_YUSED : X_BUF
    port map (
      I => CHOICE1750_GROM,
      O => CHOICE1708
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
      O => XLXI_10_I2_TC_c_0_FROM
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
  XLXI_10_I2_TC_c_0_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_TC_c_0_FROM,
      O => N20151
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
      ADR0 => XLXI_10_I2_N8327,
      ADR1 => XLXI_10_I2_N8283,
      ADR2 => XLXN_8(3),
      ADR3 => XLXN_8(0),
      O => XLXI_10_I5_ndwe_c_FROM
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
  XLXI_10_I3_Mmux_data_x_Result_1_0 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(2),
      ADR1 => XLXI_10_I2_TC_c(0),
      ADR2 => XLXI_10_I2_TC_c(1),
      ADR3 => XLXI_10_I2_data_is_c(1),
      O => CHOICE2062_FROM
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
      O => CHOICE2062_GROM
    );
  CHOICE2062_XUSED : X_BUF
    port map (
      I => CHOICE2062_FROM,
      O => CHOICE2062
    );
  CHOICE2062_YUSED : X_BUF
    port map (
      I => CHOICE2062_GROM,
      O => XLXI_10_I3_N9047
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
      O => CHOICE2176_FROM
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
      O => CHOICE2176_GROM
    );
  CHOICE2176_XUSED : X_BUF
    port map (
      I => CHOICE2176_FROM,
      O => CHOICE2176
    );
  CHOICE2176_YUSED : X_BUF
    port map (
      I => CHOICE2176_GROM,
      O => CHOICE2088
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
      O => CHOICE1457_FROM
    );
  XLXI_10_I3_Ker89321 : X_LUT4
    generic map(
      INIT => X"2222"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(0),
      ADR1 => XLXI_10_I2_TD_c(2),
      ADR2 => VCC,
      ADR3 => VCC,
      O => CHOICE1457_GROM
    );
  CHOICE1457_XUSED : X_BUF
    port map (
      I => CHOICE1457_FROM,
      O => CHOICE1457
    );
  CHOICE1457_YUSED : X_BUF
    port map (
      I => CHOICE1457_GROM,
      O => XLXI_10_I3_N8934
    );
  XLXI_10_I2_TC_x_2_SW1 : X_LUT4
    generic map(
      INIT => X"EFEF"
    )
    port map (
      ADR0 => XLXN_8(1),
      ADR1 => XLXN_8(2),
      ADR2 => NRESET_IBUF,
      ADR3 => VCC,
      O => XLXI_10_I2_TC_c_2_FROM
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
  XLXI_10_I2_TC_c_2_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_TC_c_2_FROM,
      O => N25098
    );
  XLXI_10_I2_TC_c_2_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_TC_c_2_SRMUX_OUTPUTNOT
    );
  XLXI_10_I3_Ker88821 : X_LUT4
    generic map(
      INIT => X"6666"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(0),
      ADR1 => XLXI_10_I2_TC_c(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I3_N8884_FROM
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
      O => XLXI_10_I3_N8884_GROM
    );
  XLXI_10_I3_N8884_XUSED : X_BUF
    port map (
      I => XLXI_10_I3_N8884_FROM,
      O => XLXI_10_I3_N8884
    );
  XLXI_10_I3_N8884_YUSED : X_BUF
    port map (
      I => XLXI_10_I3_N8884_GROM,
      O => XLXI_10_I3_N9052
    );
  XLXI_10_I5_Mmux_daddr_out_Result_1_1_SW0 : X_LUT4
    generic map(
      INIT => X"EEEE"
    )
    port map (
      ADR0 => N24645,
      ADR1 => XLXI_10_I5_ndwe_c,
      ADR2 => VCC,
      ADR3 => VCC,
      O => N24771_FROM
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
      O => N24771_GROM
    );
  N24771_XUSED : X_BUF
    port map (
      I => N24771_FROM,
      O => N24771
    );
  N24771_YUSED : X_BUF
    port map (
      I => N24771_GROM,
      O => N24633
    );
  XLXI_3_n00261 : X_LUT4
    generic map(
      INIT => X"1111"
    )
    port map (
      ADR0 => nCS_PWM,
      ADR1 => XLXI_10_I5_ndwe_c,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_n0026_FROM
    );
  XLXI_10_I5_Mmux_daddr_out_Result_1_1_SW1 : X_LUT4
    generic map(
      INIT => X"EEEE"
    )
    port map (
      ADR0 => XLXI_10_I5_daddr_c(1),
      ADR1 => XLXI_10_I5_ndwe_c,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_3_n0026_GROM
    );
  XLXI_3_n0026_XUSED : X_BUF
    port map (
      I => XLXI_3_n0026_FROM,
      O => XLXI_3_n0026
    );
  XLXI_3_n0026_YUSED : X_BUF
    port map (
      I => XLXI_3_n0026_GROM,
      O => N24773
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
      O => N25148_FROM
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
      O => N25148_GROM
    );
  N25148_XUSED : X_BUF
    port map (
      I => N25148_FROM,
      O => N25148
    );
  N25148_YUSED : X_BUF
    port map (
      I => N25148_GROM,
      O => N25144
    );
  XLXI_2_mux_c_0_LOGIC_ONE_162 : X_ONE
    port map (
      O => XLXI_2_mux_c_0_LOGIC_ONE
    );
  XLXI_10_I3_Mmux_data_x_Result_3_SW2 : X_LUT4
    generic map(
      INIT => X"C6C6"
    )
    port map (
      ADR0 => XLXI_10_I3_n0037,
      ADR1 => XLXI_10_I3_acc_c_0_3,
      ADR2 => XLXI_10_I2_data_is_c(3),
      ADR3 => VCC,
      O => N24757_FROM
    );
  XLXI_10_I3_Mmux_data_x_Result_0_45_SW2 : X_LUT4
    generic map(
      INIT => X"9595"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => XLXI_10_I2_data_is_c(0),
      ADR2 => XLXI_10_I3_n0037,
      ADR3 => VCC,
      O => N24757_GROM
    );
  N24757_XUSED : X_BUF
    port map (
      I => N24757_FROM,
      O => N24757
    );
  N24757_YUSED : X_BUF
    port map (
      I => N24757_GROM,
      O => N24743
    );
  XLXI_10_I2_Ker8265_SW1 : X_LUT4
    generic map(
      INIT => X"DFDF"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(1),
      ADR1 => XLXI_10_I2_skip_c,
      ADR2 => XLXI_10_I2_TC_c(0),
      ADR3 => VCC,
      O => N25102_FROM
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
      O => N25102_GROM
    );
  N25102_XUSED : X_BUF
    port map (
      I => N25102_FROM,
      O => N25102
    );
  N25102_YUSED : X_BUF
    port map (
      I => N25102_GROM,
      O => XLXI_10_I2_N8267
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
      O => N24989_FROM
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
      O => N24989_GROM
    );
  N24989_XUSED : X_BUF
    port map (
      I => N24989_FROM,
      O => N24989
    );
  N24989_YUSED : X_BUF
    port map (
      I => N24989_GROM,
      O => CHOICE2055
    );
  XLXI_10_I4_Ker9710_SW2 : X_LUT4
    generic map(
      INIT => X"7F7F"
    )
    port map (
      ADR0 => XLXN_8(5),
      ADR1 => XLXN_8(4),
      ADR2 => XLXI_10_I4_ipage_c(1),
      ADR3 => VCC,
      O => N24787_FROM
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
      O => N24787_GROM
    );
  N24787_XUSED : X_BUF
    port map (
      I => N24787_FROM,
      O => N24787
    );
  N24787_YUSED : X_BUF
    port map (
      I => N24787_GROM,
      O => N22203
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
      O => N24827_GROM
    );
  N24827_YUSED : X_BUF
    port map (
      I => N24827_GROM,
      O => N24827
    );
  XLXI_10_I5_Mmux_daddr_out_Result_4_1_SW0 : X_LUT4
    generic map(
      INIT => X"EFEF"
    )
    port map (
      ADR0 => N24637,
      ADR1 => XLXI_10_I5_ndwe_c,
      ADR2 => NRESET_IBUF,
      ADR3 => VCC,
      O => N24777_FROM
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
      O => N24777_GROM
    );
  N24777_XUSED : X_BUF
    port map (
      I => N24777_FROM,
      O => N24777
    );
  N24777_YUSED : X_BUF
    port map (
      I => N24777_GROM,
      O => nWR_RAM
    );
  XLXI_10_I2_Ker83341 : X_LUT4
    generic map(
      INIT => X"2020"
    )
    port map (
      ADR0 => XLXN_8(7),
      ADR1 => XLXN_8(5),
      ADR2 => XLXN_8(6),
      ADR3 => VCC,
      O => XLXI_10_I2_N8336_FROM
    );
  XLXI_10_I2_pc_mux_x_1_SW0 : X_LUT4
    generic map(
      INIT => X"AAAE"
    )
    port map (
      ADR0 => XLXN_8(3),
      ADR1 => XLXI_10_I2_N8336,
      ADR2 => XLXN_8(4),
      ADR3 => XLXN_8(0),
      O => XLXI_10_I2_N8336_GROM
    );
  XLXI_10_I2_N8336_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_N8336_FROM,
      O => XLXI_10_I2_N8336
    );
  XLXI_10_I2_N8336_YUSED : X_BUF
    port map (
      I => XLXI_10_I2_N8336_GROM,
      O => N22263
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
      O => CPU_DADDR_4_OBUF_FROM
    );
  XLXI_2_n00421 : X_LUT4
    generic map(
      INIT => X"2222"
    )
    port map (
      ADR0 => CPU_DADDR_4_OBUF,
      ADR1 => XLXI_10_I5_ndwe_c,
      ADR2 => VCC,
      ADR3 => VCC,
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
      O => XLXI_2_n0042
    );
  XLXI_10_I2_pc_mux_x_2_1_163 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => XLXI_10_I2_N8283,
      ADR1 => N22203,
      ADR2 => XLXI_10_I2_N8336,
      ADR3 => XLXI_10_I2_N8359,
      O => XLXI_10_I2_pc_mux_x_2_1_FROM
    );
  XLXI_10_I1_n0012_7_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_1,
      ADR1 => XLXI_10_I1_stack_addrs_c_1_7,
      ADR2 => XLXI_10_I1_n0013(7),
      ADR3 => VCC,
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
      O => N25006
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
      O => XLXI_3_Ker69031_SW5_O_FROM
    );
  XLXI_3_Msub_n0005_inst_lut2_201 : X_LUT4
    generic map(
      INIT => X"93C6"
    )
    port map (
      ADR0 => N24633,
      ADR1 => XLXI_2_pwm_data_c(0),
      ADR2 => XLXI_3_pwm_low(4),
      ADR3 => XLXI_3_Ker69031_SW5_O,
      O => XLXI_3_Ker69031_SW5_O_GROM
    );
  XLXI_3_Ker69031_SW5_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW5_O_FROM,
      O => XLXI_3_Ker69031_SW5_O
    );
  XLXI_3_Ker69031_SW5_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW5_O_GROM,
      O => XLXI_3_Msub_n0005_inst_lut2_20
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
      O => XLXI_3_Ker69031_SW4_O_FROM
    );
  XLXI_3_Msub_n0005_inst_lut2_211 : X_LUT4
    generic map(
      INIT => X"93C6"
    )
    port map (
      ADR0 => N24633,
      ADR1 => XLXI_2_pwm_data_c(1),
      ADR2 => XLXI_3_pwm_low(5),
      ADR3 => XLXI_3_Ker69031_SW4_O,
      O => XLXI_3_Ker69031_SW4_O_GROM
    );
  XLXI_3_Ker69031_SW4_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW4_O_FROM,
      O => XLXI_3_Ker69031_SW4_O
    );
  XLXI_3_Ker69031_SW4_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW4_O_GROM,
      O => XLXI_3_Msub_n0005_inst_lut2_21
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
      O => XLXI_3_Ker69031_SW3_O_FROM
    );
  XLXI_3_Msub_n0005_inst_lut2_221 : X_LUT4
    generic map(
      INIT => X"93C6"
    )
    port map (
      ADR0 => N24633,
      ADR1 => XLXI_2_pwm_data_c(2),
      ADR2 => XLXI_3_pwm_low(6),
      ADR3 => XLXI_3_Ker69031_SW3_O,
      O => XLXI_3_Ker69031_SW3_O_GROM
    );
  XLXI_3_Ker69031_SW3_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW3_O_FROM,
      O => XLXI_3_Ker69031_SW3_O
    );
  XLXI_3_Ker69031_SW3_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW3_O_GROM,
      O => XLXI_3_Msub_n0005_inst_lut2_22
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
      O => XLXI_3_Ker69031_SW9_O_FROM
    );
  XLXI_3_Msub_n0005_inst_lut2_161 : X_LUT4
    generic map(
      INIT => X"93C6"
    )
    port map (
      ADR0 => N24633,
      ADR1 => CPU_DATA_OUT_0_OBUF,
      ADR2 => XLXI_3_pwm_low(0),
      ADR3 => XLXI_3_Ker69031_SW9_O,
      O => XLXI_3_Ker69031_SW9_O_GROM
    );
  XLXI_3_Ker69031_SW9_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW9_O_FROM,
      O => XLXI_3_Ker69031_SW9_O
    );
  XLXI_3_Ker69031_SW9_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW9_O_GROM,
      O => XLXI_3_Msub_n0005_inst_lut2_16
    );
  XLXI_2_ctrl_data_c_2 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => CTRL_DATA_OUT_2_OD,
      CE => XLXI_2_n0043,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => CTRL_DATA_OUT_2_SRMUXNOT,
      O => XLXI_2_ctrl_data_c(2)
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
      O => XLXI_3_Ker69031_SW8_O_FROM
    );
  XLXI_3_Msub_n0005_inst_lut2_171 : X_LUT4
    generic map(
      INIT => X"93C6"
    )
    port map (
      ADR0 => N24633,
      ADR1 => CPU_DATA_OUT_1_OBUF,
      ADR2 => XLXI_3_pwm_low(1),
      ADR3 => XLXI_3_Ker69031_SW8_O,
      O => XLXI_3_Ker69031_SW8_O_GROM
    );
  XLXI_3_Ker69031_SW8_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW8_O_FROM,
      O => XLXI_3_Ker69031_SW8_O
    );
  XLXI_3_Ker69031_SW8_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW8_O_GROM,
      O => XLXI_3_Msub_n0005_inst_lut2_17
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
      O => XLXI_3_Ker69031_SW7_O_FROM
    );
  XLXI_3_Msub_n0005_inst_lut2_181 : X_LUT4
    generic map(
      INIT => X"93C6"
    )
    port map (
      ADR0 => N24633,
      ADR1 => CPU_DATA_OUT_2_OBUF,
      ADR2 => XLXI_3_pwm_low(2),
      ADR3 => XLXI_3_Ker69031_SW7_O,
      O => XLXI_3_Ker69031_SW7_O_GROM
    );
  XLXI_3_Ker69031_SW7_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW7_O_FROM,
      O => XLXI_3_Ker69031_SW7_O
    );
  XLXI_3_Ker69031_SW7_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW7_O_GROM,
      O => XLXI_3_Msub_n0005_inst_lut2_18
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
      O => XLXI_3_Ker69031_SW6_O_FROM
    );
  XLXI_3_Msub_n0005_inst_lut2_191 : X_LUT4
    generic map(
      INIT => X"93C6"
    )
    port map (
      ADR0 => N24633,
      ADR1 => CPU_DATA_OUT_3_OBUF,
      ADR2 => XLXI_3_pwm_low(3),
      ADR3 => XLXI_3_Ker69031_SW6_O,
      O => XLXI_3_Ker69031_SW6_O_GROM
    );
  XLXI_3_Ker69031_SW6_O_XUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW6_O_FROM,
      O => XLXI_3_Ker69031_SW6_O
    );
  XLXI_3_Ker69031_SW6_O_YUSED : X_BUF
    port map (
      I => XLXI_3_Ker69031_SW6_O_GROM,
      O => XLXI_3_Msub_n0005_inst_lut2_19
    );
  XLXI_2_n0020_SW0 : X_LUT4
    generic map(
      INIT => X"DFDF"
    )
    port map (
      ADR0 => CPU_DADDR_4_OBUF,
      ADR1 => CPU_DADDR_3_OBUF,
      ADR2 => NRESET_IBUF,
      ADR3 => VCC,
      O => XLXI_2_n0020_SW0_O_FROM
    );
  XLXI_2_n0020_164 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => CPU_DADDR_2_OBUF,
      ADR1 => CPU_DADDR_1_OBUF,
      ADR2 => CPU_DADDR_0_OBUF,
      ADR3 => XLXI_2_n0020_SW0_O,
      O => XLXI_2_n0020_SW0_O_GROM
    );
  XLXI_2_n0020_SW0_O_XUSED : X_BUF
    port map (
      I => XLXI_2_n0020_SW0_O_FROM,
      O => XLXI_2_n0020_SW0_O
    );
  XLXI_2_n0020_SW0_O_YUSED : X_BUF
    port map (
      I => XLXI_2_n0020_SW0_O_GROM,
      O => XLXI_2_n0020
    );
  XLXI_2_n0043_SW0 : X_LUT4
    generic map(
      INIT => X"FEFE"
    )
    port map (
      ADR0 => CPU_DADDR_2_OBUF,
      ADR1 => CPU_DADDR_1_OBUF,
      ADR2 => XLXI_10_I5_ndwe_c,
      ADR3 => VCC,
      O => XLXI_2_n0043_SW0_O_FROM
    );
  XLXI_2_n0043_165 : X_LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      ADR0 => CPU_DADDR_4_OBUF,
      ADR1 => CPU_DADDR_0_OBUF,
      ADR2 => CPU_DADDR_3_OBUF,
      ADR3 => XLXI_2_n0043_SW0_O,
      O => XLXI_2_n0043_SW0_O_GROM
    );
  XLXI_2_n0043_SW0_O_XUSED : X_BUF
    port map (
      I => XLXI_2_n0043_SW0_O_FROM,
      O => XLXI_2_n0043_SW0_O
    );
  XLXI_2_n0043_SW0_O_YUSED : X_BUF
    port map (
      I => XLXI_2_n0043_SW0_O_GROM,
      O => XLXI_2_n0043
    );
  XLXI_10_I2_pc_mux_x_2_2_166 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => XLXI_10_I2_N8283,
      ADR1 => N22203,
      ADR2 => XLXI_10_I2_N8336,
      ADR3 => XLXI_10_I2_N8359,
      O => XLXI_10_I2_pc_mux_x_2_2_FROM
    );
  XLXI_10_I1_n0010_0_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_0,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_0,
      ADR3 => VCC,
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
      O => N25058
    );
  XLXI_2_n0046_SW0 : X_LUT4
    generic map(
      INIT => X"9999"
    )
    port map (
      ADR0 => CPU_DADDR_2_OBUF,
      ADR1 => CPU_DADDR_1_OBUF,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_2_n0046_SW0_O_FROM
    );
  XLXI_2_n0046_167 : X_LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => XLXI_2_n0046_SW0_O,
      ADR2 => CPU_DADDR_4_OBUF,
      ADR3 => CPU_DADDR_0_OBUF,
      O => XLXI_2_n0046_SW0_O_GROM
    );
  XLXI_2_n0046_SW0_O_XUSED : X_BUF
    port map (
      I => XLXI_2_n0046_SW0_O_FROM,
      O => XLXI_2_n0046_SW0_O
    );
  XLXI_2_n0046_SW0_O_YUSED : X_BUF
    port map (
      I => XLXI_2_n0046_SW0_O_GROM,
      O => XLXI_2_n0046
    );
  XLXI_10_I4_Ker97281 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_I4_nreset_v(1),
      ADR1 => NRESET_IBUF,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I4_N9730_FROM
    );
  XLXI_10_I3_Mmux_data_x_Result_2_SW0 : X_LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      ADR0 => XLXI_10_I4_N9730,
      ADR1 => XLXI_2_mux_c(0),
      ADR2 => CTRL_DATA_IN_2_IBUF,
      ADR3 => RAM_DATA_OUT(2),
      O => XLXI_10_I4_N9730_GROM
    );
  XLXI_10_I4_N9730_XUSED : X_BUF
    port map (
      I => XLXI_10_I4_N9730_FROM,
      O => XLXI_10_I4_N9730
    );
  XLXI_10_I4_N9730_YUSED : X_BUF
    port map (
      I => XLXI_10_I4_N9730_GROM,
      O => N23412
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
      O => N24084_FROM
    );
  XLXI_10_I2_ndre_x_SW1 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => XLXN_8(3),
      ADR1 => XLXN_8(8),
      ADR2 => XLXN_8(9),
      ADR3 => N24084,
      O => N24084_GROM
    );
  N24084_XUSED : X_BUF
    port map (
      I => N24084_FROM,
      O => N24084
    );
  N24084_YUSED : X_BUF
    port map (
      I => N24084_GROM,
      O => N24657
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
      O => CPU_DADDR_2_OBUF_FROM
    );
  XLXI_3_n00031 : X_LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      ADR0 => CPU_DADDR_2_OBUF,
      ADR1 => N24633,
      ADR2 => N23342,
      ADR3 => CPU_DADDR_3_OBUF,
      O => CPU_DADDR_2_OBUF_GROM
    );
  CPU_DADDR_2_OBUF_XUSED : X_BUF
    port map (
      I => CPU_DADDR_2_OBUF_FROM,
      O => CPU_DADDR_2_OBUF
    );
  CPU_DADDR_2_OBUF_YUSED : X_BUF
    port map (
      I => CPU_DADDR_2_OBUF_GROM,
      O => XLXI_3_n0003
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
      O => XLXI_10_pc_mux_0_FROM
    );
  XLXI_10_I1_iaddr_x_7_14 : X_LUT4
    generic map(
      INIT => X"F404"
    )
    port map (
      ADR0 => XLXI_10_pc_mux(0),
      ADR1 => XLXI_10_I1_pc(7),
      ADR2 => XLXI_10_pc_mux(1),
      ADR3 => XLXI_10_I4_ipage_c(1),
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
      O => CHOICE1864
    );
  XLXI_10_I4_Ker9710_SW0 : X_LUT4
    generic map(
      INIT => X"FEFE"
    )
    port map (
      ADR0 => XLXN_8(7),
      ADR1 => XLXN_8(9),
      ADR2 => XLXN_8(8),
      ADR3 => VCC,
      O => N21724_FROM
    );
  XLXI_10_I4_Ker9710 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => XLXN_8(6),
      ADR1 => N21724,
      ADR2 => XLXN_8(5),
      ADR3 => XLXN_8(4),
      O => N21724_GROM
    );
  N21724_XUSED : X_BUF
    port map (
      I => N21724_FROM,
      O => N21724
    );
  N21724_YUSED : X_BUF
    port map (
      I => N21724_GROM,
      O => XLXI_10_I4_N9712
    );
  XLXI_10_I2_Ker83251 : X_LUT4
    generic map(
      INIT => X"DFDF"
    )
    port map (
      ADR0 => XLXI_10_I2_nreset_v(1),
      ADR1 => XLXI_10_skip,
      ADR2 => NRESET_IBUF,
      ADR3 => VCC,
      O => XLXI_10_I2_N8327_FROM
    );
  XLXI_10_I4_Ker9695 : X_LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      ADR0 => N24657,
      ADR1 => N24038,
      ADR2 => XLXI_10_I2_N8327,
      ADR3 => XLXI_10_I2_N8283,
      O => XLXI_10_I2_N8327_GROM
    );
  XLXI_10_I2_N8327_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_N8327_FROM,
      O => XLXI_10_I2_N8327
    );
  XLXI_10_I2_N8327_YUSED : X_BUF
    port map (
      I => XLXI_10_I2_N8327_GROM,
      O => XLXI_10_I4_N9697
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
      O => nCS_PWM_FROM
    );
  XLXI_3_Ker69221 : X_LUT4
    generic map(
      INIT => X"FEFE"
    )
    port map (
      ADR0 => XLXI_10_I5_ndwe_c,
      ADR1 => CPU_DADDR_2_OBUF,
      ADR2 => nCS_PWM,
      ADR3 => VCC,
      O => nCS_PWM_GROM
    );
  nCS_PWM_XUSED : X_BUF
    port map (
      I => nCS_PWM_FROM,
      O => nCS_PWM
    );
  nCS_PWM_YUSED : X_BUF
    port map (
      I => nCS_PWM_GROM,
      O => XLXI_3_N6924
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
      O => XLXI_10_I3_n00441_O_FROM
    );
  XLXI_10_I3_skip_l36 : X_LUT4
    generic map(
      INIT => X"0656"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(1),
      ADR1 => XLXI_10_I3_n00441_O,
      ADR2 => XLXI_10_I2_TD_c(2),
      ADR3 => XLXI_10_I3_acc_c_0_4,
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
      O => CHOICE2148
    );
  XLXI_10_I3_skip_l90 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_I3_N9047,
      ADR1 => CHOICE2161,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I2_skip_c_FROM
    );
  XLXI_10_I3_skip_l99 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => XLXI_10_I3_skip_l90_O,
      ADR1 => CHOICE2155,
      ADR2 => CHOICE2148,
      ADR3 => XLXI_10_I2_TD_c(0),
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
  XLXI_10_I4_data_ox_1_1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_1,
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      ADR3 => VCC,
      O => XLXI_3_pwm_low_1_FROM
    );
  XLXI_10_I4_data_ox_0_1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_0,
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      ADR3 => VCC,
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
  XLXI_10_I4_data_ox_3_1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_3,
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      ADR3 => VCC,
      O => XLXI_3_pwm_low_3_FROM
    );
  XLXI_10_I4_data_ox_2_1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_2,
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      ADR3 => VCC,
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
      INIT => X"D827"
    )
    port map (
      ADR0 => XLXI_10_I3_n0037,
      ADR1 => XLXI_10_I2_data_is_c(0),
      ADR2 => XLXI_10_I4_N9730,
      ADR3 => XLXI_10_I3_acc_c_0_0,
      O => XLXI_10_I4_ipage_we_c_FROM
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
  XLXI_10_I4_ipage_we_c_XUSED : X_BUF
    port map (
      I => XLXI_10_I4_ipage_we_c_FROM,
      O => N24745
    );
  XLXI_10_I4_ipage_we_c_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I4_ipage_we_c_SRMUX_OUTPUTNOT
    );
  XLXI_10_I4_n0030_1_1 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_I4_ipage_we_c,
      ADR1 => XLXI_10_I3_acc_c_0_1,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I4_n0030(1)
    );
  XLXI_10_I4_n0030_0_1 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => XLXI_10_I4_ipage_we_c,
      ADR1 => XLXI_10_I3_acc_c_0_0,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I4_n0030(0)
    );
  XLXI_10_I4_ipage_c_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I4_ipage_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_10_I2_pc_mux_x_1_1_168 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => XLXI_10_I2_N8359,
      ADR1 => XLXI_10_I2_N8283,
      ADR2 => NRESET_IBUF,
      ADR3 => N22263,
      O => XLXI_10_I2_valid_c_FROM
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
      INIT => X"8080"
    )
    port map (
      ADR0 => XLXN_8(5),
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      ADR3 => VCC,
      O => XLXI_10_adaddr_out(1)
    );
  XLXI_10_I4_daddr_x_0_1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => XLXN_8(4),
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      ADR3 => VCC,
      O => XLXI_10_adaddr_out(0)
    );
  XLXI_10_I5_daddr_c_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I5_daddr_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_10_I5_daddr_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I5_daddr_c_3_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I5_daddr_c_3_FFY_RST
    );
  XLXI_10_I5_daddr_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_adaddr_out(2),
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I5_daddr_c_3_FFY_RST,
      O => XLXI_10_I5_daddr_c(2)
    );
  XLXI_10_I4_daddr_x_3_1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => XLXN_8(7),
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      ADR3 => VCC,
      O => XLXI_10_adaddr_out(3)
    );
  XLXI_10_I4_daddr_x_2_1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => XLXN_8(6),
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      ADR3 => VCC,
      O => XLXI_10_adaddr_out(2)
    );
  XLXI_10_I5_daddr_c_3_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I5_daddr_c_3_SRMUX_OUTPUTNOT
    );
  XLXI_10_I4_daddr_x_5_1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => XLXN_8(9),
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      ADR3 => VCC,
      O => XLXI_10_I5_daddr_c_5_FROM
    );
  XLXI_10_I4_daddr_x_4_1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => XLXN_8(8),
      ADR1 => XLXI_10_I4_nreset_v(1),
      ADR2 => NRESET_IBUF,
      ADR3 => VCC,
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
      INIT => X"8888"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXI_10_I1_nreset_v(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I1_nreset_v_0_FROM
    );
  XLXI_10_I1_n0008_0_1 : X_LUT4
    generic map(
      INIT => X"BBBB"
    )
    port map (
      ADR0 => XLXI_10_I1_nreset_v(1),
      ADR1 => XLXI_10_I1_nreset_v(0),
      ADR2 => VCC,
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
      INIT => X"BBBB"
    )
    port map (
      ADR0 => XLXI_10_I2_nreset_v(1),
      ADR1 => XLXI_10_I2_nreset_v(0),
      ADR2 => VCC,
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
      INIT => X"DFDF"
    )
    port map (
      ADR0 => XLXI_10_I3_nreset_v(0),
      ADR1 => XLXI_10_I2_valid_c,
      ADR2 => XLXI_10_I3_nreset_v(1),
      ADR3 => VCC,
      O => XLXI_10_I3_nreset_v_0_FROM
    );
  XLXI_10_I3_n0036_0_1 : X_LUT4
    generic map(
      INIT => X"BBBB"
    )
    port map (
      ADR0 => XLXI_10_I3_nreset_v(1),
      ADR1 => XLXI_10_I3_nreset_v(0),
      ADR2 => VCC,
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
  XLXI_10_I3_Mmux_data_x_Result_0_30 : X_LUT4
    generic map(
      INIT => X"2020"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXI_10_I3_n0037,
      ADR2 => XLXI_10_I4_nreset_v(1),
      ADR3 => VCC,
      O => XLXI_10_I4_nreset_v_0_FROM
    );
  XLXI_10_I4_n0031_0_1 : X_LUT4
    generic map(
      INIT => X"BBBB"
    )
    port map (
      ADR0 => XLXI_10_I4_nreset_v(1),
      ADR1 => XLXI_10_I4_nreset_v(0),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_10_I4_n0031(0)
    );
  XLXI_10_I4_nreset_v_0_XUSED : X_BUF
    port map (
      I => XLXI_10_I4_nreset_v_0_FROM,
      O => CHOICE2134
    );
  XLXI_10_I4_nreset_v_0_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I4_nreset_v_0_SRMUX_OUTPUTNOT
    );
  XLXI_2_ctrl_data_c_3 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => CTRL_DATA_OUT_3_OD,
      CE => XLXI_2_n0043,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => CTRL_DATA_OUT_3_SRMUXNOT,
      O => XLXI_2_ctrl_data_c(3)
    );
  XLXI_3_Mmux_n0011_Result_6_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_3_N6905,
      ADR1 => XLXI_2_pwm_data_c(2),
      ADR2 => XLXI_3_pwm_period(6),
      ADR3 => VCC,
      O => XLXI_3_n0011_6_FROM
    );
  XLXI_3_Ker69031_SW3_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => XLXI_3_pwm_low(6),
      ADR2 => XLXI_3_pwm_period(6),
      ADR3 => VCC,
      O => XLXI_3_n0011_6_GROM
    );
  XLXI_3_n0011_6_XUSED : X_BUF
    port map (
      I => XLXI_3_n0011_6_FROM,
      O => XLXI_3_n0011(6)
    );
  XLXI_3_n0011_6_YUSED : X_BUF
    port map (
      I => XLXI_3_n0011_6_GROM,
      O => N25192
    );
  XLXI_3_Mmux_n0011_Result_5_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_3_N6905,
      ADR1 => XLXI_2_pwm_data_c(1),
      ADR2 => XLXI_3_pwm_period(5),
      ADR3 => VCC,
      O => XLXI_3_n0011_5_FROM
    );
  XLXI_3_Ker69031_SW4_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => XLXI_3_pwm_low(5),
      ADR2 => XLXI_3_pwm_period(5),
      ADR3 => VCC,
      O => XLXI_3_n0011_5_GROM
    );
  XLXI_3_n0011_5_XUSED : X_BUF
    port map (
      I => XLXI_3_n0011_5_FROM,
      O => XLXI_3_n0011(5)
    );
  XLXI_3_n0011_5_YUSED : X_BUF
    port map (
      I => XLXI_3_n0011_5_GROM,
      O => N25212
    );
  XLXI_3_Mmux_n0011_Result_4_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_3_N6905,
      ADR1 => XLXI_2_pwm_data_c(0),
      ADR2 => XLXI_3_pwm_period(4),
      ADR3 => VCC,
      O => XLXI_3_n0011_4_FROM
    );
  XLXI_3_Ker69031_SW5_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => XLXI_3_pwm_low(4),
      ADR2 => XLXI_3_pwm_period(4),
      ADR3 => VCC,
      O => XLXI_3_n0011_4_GROM
    );
  XLXI_3_n0011_4_XUSED : X_BUF
    port map (
      I => XLXI_3_n0011_4_FROM,
      O => XLXI_3_n0011(4)
    );
  XLXI_3_n0011_4_YUSED : X_BUF
    port map (
      I => XLXI_3_n0011_4_GROM,
      O => N25208
    );
  XLXI_3_Ker69031_SW8_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => XLXI_3_pwm_low(1),
      ADR2 => XLXI_3_pwm_period(1),
      ADR3 => VCC,
      O => N25196_FROM
    );
  XLXI_3_Ker69031_SW6_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => XLXI_3_pwm_low(3),
      ADR2 => XLXI_3_pwm_period(3),
      ADR3 => VCC,
      O => N25196_GROM
    );
  N25196_XUSED : X_BUF
    port map (
      I => N25196_FROM,
      O => N25196
    );
  N25196_YUSED : X_BUF
    port map (
      I => N25196_GROM,
      O => N25204
    );
  XLXI_3_Ker69031_SW7_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => CPU_DADDR_3_OBUF,
      ADR1 => XLXI_3_pwm_low(2),
      ADR2 => XLXI_3_pwm_period(2),
      ADR3 => VCC,
      O => N25200_GROM
    );
  N25200_YUSED : X_BUF
    port map (
      I => N25200_GROM,
      O => N25200
    );
  XLXI_10_I3_Ker90622 : X_LUT4
    generic map(
      INIT => X"F8F8"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(0),
      ADR1 => XLXI_10_I2_TC_c(1),
      ADR2 => XLXI_10_I2_TD_c(3),
      ADR3 => VCC,
      O => CHOICE1448_FROM
    );
  XLXI_10_I3_n00521 : X_LUT4
    generic map(
      INIT => X"1111"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(0),
      ADR1 => XLXI_10_I2_TC_c(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => CHOICE1448_GROM
    );
  CHOICE1448_XUSED : X_BUF
    port map (
      I => CHOICE1448_FROM,
      O => CHOICE1448
    );
  CHOICE1448_YUSED : X_BUF
    port map (
      I => CHOICE1448_GROM,
      O => XLXI_10_I3_n0052
    );
  XLXI_10_I3_n00371 : X_LUT4
    generic map(
      INIT => X"1010"
    )
    port map (
      ADR0 => XLXI_10_I2_TC_c(2),
      ADR1 => XLXI_10_I2_TC_c(0),
      ADR2 => XLXI_10_I2_TC_c(1),
      ADR3 => VCC,
      O => XLXI_10_I3_n0037_FROM
    );
  XLXI_10_I3_Mmux_data_x_Result_1_30 : X_LUT4
    generic map(
      INIT => X"2020"
    )
    port map (
      ADR0 => NRESET_IBUF,
      ADR1 => XLXI_10_I3_n0037,
      ADR2 => XLXI_10_I4_nreset_v(1),
      ADR3 => VCC,
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
      O => CHOICE2073
    );
  XLXI_10_I3_n00481 : X_LUT4
    generic map(
      INIT => X"1010"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(0),
      ADR1 => XLXI_10_I2_TD_c(1),
      ADR2 => XLXI_10_I2_TD_c(2),
      ADR3 => VCC,
      O => XLXI_10_I3_n0048_FROM
    );
  XLXI_10_I3_n00451 : X_LUT4
    generic map(
      INIT => X"1010"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(2),
      ADR1 => XLXI_10_I2_TD_c(1),
      ADR2 => XLXI_10_I2_TD_c(0),
      ADR3 => VCC,
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
      INIT => X"2020"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(0),
      ADR1 => XLXI_10_I2_TD_c(2),
      ADR2 => XLXI_10_I2_TD_c(1),
      ADR3 => VCC,
      O => XLXI_10_I3_n0053_FROM
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
      O => CHOICE2044
    );
  XLXI_10_I3_n00551 : X_LUT4
    generic map(
      INIT => X"2020"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(2),
      ADR1 => XLXI_10_I2_TD_c(0),
      ADR2 => XLXI_10_I2_TD_c(1),
      ADR3 => VCC,
      O => XLXI_10_I3_n0055_FROM
    );
  XLXI_10_I3_n00541 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => XLXI_10_I2_TD_c(2),
      ADR1 => XLXI_10_I2_TD_c(0),
      ADR2 => XLXI_10_I2_TD_c(1),
      ADR3 => VCC,
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
      INIT => X"D827"
    )
    port map (
      ADR0 => XLXI_10_I3_n0037,
      ADR1 => XLXI_10_I2_data_is_c(1),
      ADR2 => XLXI_10_I4_N9730,
      ADR3 => XLXI_10_I3_acc_c_0_1,
      O => N24675_FROM
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
      O => N24675_GROM
    );
  N24675_XUSED : X_BUF
    port map (
      I => N24675_FROM,
      O => N24675
    );
  N24675_YUSED : X_BUF
    port map (
      I => N24675_GROM,
      O => N24667
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
      O => N24755_FROM
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
      O => N24755_GROM
    );
  N24755_XUSED : X_BUF
    port map (
      I => N24755_FROM,
      O => N24755
    );
  N24755_YUSED : X_BUF
    port map (
      I => N24755_GROM,
      O => N24669
    );
  XLXI_10_I1_n0010_7_19_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I2_pc_mux_x_2_2,
      ADR1 => XLXI_10_I1_stack_addrs_c_3_7,
      ADR2 => XLXI_10_I1_stack_addrs_c_1_7,
      ADR3 => VCC,
      O => XLXI_10_I1_stack_addrs_c_2_7_FROM
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
  XLXI_10_I1_stack_addrs_c_2_7_XUSED : X_BUF
    port map (
      I => XLXI_10_I1_stack_addrs_c_2_7_FROM,
      O => N25042
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
      O => N24985_FROM
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
      O => N24985_GROM
    );
  N24985_XUSED : X_BUF
    port map (
      I => N24985_FROM,
      O => N24985
    );
  N24985_YUSED : X_BUF
    port map (
      I => N24985_GROM,
      O => CHOICE2099
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
      O => CHOICE2161_FROM
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
      O => CHOICE2161_GROM
    );
  CHOICE2161_XUSED : X_BUF
    port map (
      I => CHOICE2161_FROM,
      O => CHOICE2161
    );
  CHOICE2161_YUSED : X_BUF
    port map (
      I => CHOICE2161_GROM,
      O => CHOICE2123
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
      ADR0 => XLXI_10_I4_N9712,
      ADR1 => XLXI_10_ndre_int,
      ADR2 => NRESET_IBUF,
      ADR3 => XLXI_10_I4_nreset_v(1),
      O => nRE_CPU_OBUF_FROM
    );
  XLXI_10_I5_Mmux_daddr_out_Result_5_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => nRE_CPU_OBUF,
      ADR1 => XLXI_10_I5_daddr_c(5),
      ADR2 => XLXI_10_adaddr_out(5),
      ADR3 => VCC,
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
  XLXI_10_I2_TD_x_1_52 : X_LUT4
    generic map(
      INIT => X"062A"
    )
    port map (
      ADR0 => XLXN_8(5),
      ADR1 => XLXN_8(6),
      ADR2 => XLXN_8(7),
      ADR3 => XLXN_8(4),
      O => CHOICE1786_FROM
    );
  XLXI_10_I2_TD_x_0_22 : X_LUT4
    generic map(
      INIT => X"1717"
    )
    port map (
      ADR0 => XLXN_8(5),
      ADR1 => XLXN_8(6),
      ADR2 => XLXN_8(7),
      ADR3 => VCC,
      O => CHOICE1786_GROM
    );
  CHOICE1786_XUSED : X_BUF
    port map (
      I => CHOICE1786_FROM,
      O => CHOICE1786
    );
  CHOICE1786_YUSED : X_BUF
    port map (
      I => CHOICE1786_GROM,
      O => CHOICE1759
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
      O => XLXI_10_I2_TD_c_0_FROM
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
  XLXI_10_I2_TD_c_0_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_TD_c_0_FROM,
      O => CHOICE1767
    );
  XLXI_10_I2_TD_c_0_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_TD_c_0_SRMUX_OUTPUTNOT
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
      O => N24685_FROM
    );
  XLXI_10_I3_n0035_4_11_SW1_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => XLXI_10_I3_n0055,
      ADR1 => N24687,
      ADR2 => N24685,
      ADR3 => VCC,
      O => N24685_GROM
    );
  N24685_XUSED : X_BUF
    port map (
      I => N24685_FROM,
      O => N24685
    );
  N24685_YUSED : X_BUF
    port map (
      I => N24685_GROM,
      O => N25170
    );
  XLXI_10_I2_TD_x_1_61 : X_LUT4
    generic map(
      INIT => X"0101"
    )
    port map (
      ADR0 => XLXN_8(2),
      ADR1 => XLXN_8(0),
      ADR2 => XLXN_8(3),
      ADR3 => VCC,
      O => XLXI_10_I2_TD_c_1_FROM
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
  XLXI_10_I2_TD_c_1_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_TD_c_1_FROM,
      O => CHOICE1791
    );
  XLXI_10_I2_TD_c_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_TD_c_1_SRMUX_OUTPUTNOT
    );
  XLXI_10_I2_TD_x_2_38 : X_LUT4
    generic map(
      INIT => X"0101"
    )
    port map (
      ADR0 => XLXN_8(1),
      ADR1 => XLXN_8(3),
      ADR2 => XLXN_8(0),
      ADR3 => VCC,
      O => XLXI_10_I2_TD_c_2_FROM
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
  XLXI_10_I2_TD_c_2_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_TD_c_2_FROM,
      O => CHOICE1745
    );
  XLXI_10_I2_TD_c_2_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_TD_c_2_SRMUX_OUTPUTNOT
    );
  XLXI_10_I3_Mmux_data_x_Result_2_SW4 : X_LUT4
    generic map(
      INIT => X"C6C6"
    )
    port map (
      ADR0 => XLXI_10_I3_n0037,
      ADR1 => XLXI_10_I3_acc_c_0_2,
      ADR2 => XLXI_10_I2_data_is_c(2),
      ADR3 => VCC,
      O => N24751_FROM
    );
  XLXI_10_I3_Mmux_data_x_Result_2_SW1 : X_LUT4
    generic map(
      INIT => X"9595"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_2,
      ADR1 => XLXI_10_I3_n0037,
      ADR2 => XLXI_10_I2_data_is_c(2),
      ADR3 => VCC,
      O => N24751_GROM
    );
  N24751_XUSED : X_BUF
    port map (
      I => N24751_FROM,
      O => N24751
    );
  N24751_YUSED : X_BUF
    port map (
      I => N24751_GROM,
      O => N24679
    );
  XLXI_10_I3_Mmux_data_x_Result_3_SW4 : X_LUT4
    generic map(
      INIT => X"C6C6"
    )
    port map (
      ADR0 => XLXI_10_I3_n0037,
      ADR1 => XLXI_10_I3_acc_c_0_3,
      ADR2 => XLXI_10_I2_data_is_c(3),
      ADR3 => VCC,
      O => N24843_FROM
    );
  XLXI_10_I3_Mmux_data_x_Result_2_SW2 : X_LUT4
    generic map(
      INIT => X"C6C6"
    )
    port map (
      ADR0 => XLXI_10_I3_n0037,
      ADR1 => XLXI_10_I3_acc_c_0_2,
      ADR2 => XLXI_10_I2_data_is_c(2),
      ADR3 => VCC,
      O => N24843_GROM
    );
  N24843_XUSED : X_BUF
    port map (
      I => N24843_FROM,
      O => N24843
    );
  N24843_YUSED : X_BUF
    port map (
      I => N24843_GROM,
      O => N24681
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
      O => N25117_FROM
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
      O => N25117_GROM
    );
  N25117_XUSED : X_BUF
    port map (
      I => N25117_FROM,
      O => N25117
    );
  N25117_YUSED : X_BUF
    port map (
      I => N25117_GROM,
      O => CHOICE2025
    );
  XLXI_10_I3_Mmux_data_x_Result_2_SW3 : X_LUT4
    generic map(
      INIT => X"9595"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_2,
      ADR1 => XLXI_10_I3_n0037,
      ADR2 => XLXI_10_I2_data_is_c(2),
      ADR3 => VCC,
      O => N24749_FROM
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
      O => N24749_GROM
    );
  N24749_XUSED : X_BUF
    port map (
      I => N24749_FROM,
      O => N24749
    );
  N24749_YUSED : X_BUF
    port map (
      I => N24749_GROM,
      O => XLXI_10_I3_Madd_n0064_inst_lut2_34
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
      O => N24981_FROM
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
      O => N24981_GROM
    );
  N24981_XUSED : X_BUF
    port map (
      I => N24981_FROM,
      O => N24981
    );
  N24981_YUSED : X_BUF
    port map (
      I => N24981_GROM,
      O => CHOICE2187
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
      O => CHOICE1444_FROM
    );
  XLXI_3_n000715 : X_LUT4
    generic map(
      INIT => X"BBBB"
    )
    port map (
      ADR0 => CHOICE1444,
      ADR1 => NRESET_IBUF,
      ADR2 => VCC,
      ADR3 => VCC,
      O => CHOICE1444_GROM
    );
  CHOICE1444_XUSED : X_BUF
    port map (
      I => CHOICE1444_FROM,
      O => CHOICE1444
    );
  CHOICE1444_YUSED : X_BUF
    port map (
      I => CHOICE1444_GROM,
      O => XLXI_3_n0007
    );
  XLXI_10_I2_Ker82811 : X_LUT4
    generic map(
      INIT => X"EEEE"
    )
    port map (
      ADR0 => XLXN_8(1),
      ADR1 => XLXN_8(2),
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
      ADR3 => XLXI_10_I2_N8283,
      O => XLXI_10_I2_TC_x(1)
    );
  XLXI_10_I2_TC_c_1_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_TC_c_1_FROM,
      O => XLXI_10_I2_N8283
    );
  XLXI_10_I2_TC_c_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_TC_c_1_SRMUX_OUTPUTNOT
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
      O => N23016_FROM
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
      O => N23016_GROM
    );
  N23016_XUSED : X_BUF
    port map (
      I => N23016_FROM,
      O => N23016
    );
  N23016_YUSED : X_BUF
    port map (
      I => N23016_GROM,
      O => XLXI_10_I3_Msub_n0059_inst_lut2_39
    );
  XLXI_10_I3_Mmux_data_x_Result_3_SW3 : X_LUT4
    generic map(
      INIT => X"9595"
    )
    port map (
      ADR0 => XLXI_10_I3_acc_c_0_3,
      ADR1 => XLXI_10_I3_n0037,
      ADR2 => XLXI_10_I2_data_is_c(3),
      ADR3 => VCC,
      O => N24841_FROM
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
      O => N24841_GROM
    );
  N24841_XUSED : X_BUF
    port map (
      I => N24841_FROM,
      O => N24841
    );
  N24841_YUSED : X_BUF
    port map (
      I => N24841_GROM,
      O => XLXI_10_I3_Madd_n0064_inst_lut2_35
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
      O => CHOICE1894_FROM
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
      O => CHOICE1894_GROM
    );
  CHOICE1894_XUSED : X_BUF
    port map (
      I => CHOICE1894_FROM,
      O => CHOICE1894
    );
  CHOICE1894_YUSED : X_BUF
    port map (
      I => CHOICE1894_GROM,
      O => CHOICE1924
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
      O => N24851_FROM
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
      O => N24851_GROM
    );
  N24851_XUSED : X_BUF
    port map (
      I => N24851_FROM,
      O => N24851
    );
  N24851_YUSED : X_BUF
    port map (
      I => N24851_GROM,
      O => N24847
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
      O => CHOICE1849_FROM
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
      O => CHOICE1819
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
      O => CHOICE1909_FROM
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
      O => CHOICE1834
    );
  XLXI_10_I4_Ker9710_SW1 : X_LUT4
    generic map(
      INIT => X"7F7F"
    )
    port map (
      ADR0 => XLXN_8(5),
      ADR1 => XLXN_8(4),
      ADR2 => XLXI_10_I4_ipage_c(0),
      ADR3 => VCC,
      O => N24783_GROM
    );
  N24783_YUSED : X_BUF
    port map (
      I => N24783_GROM,
      O => N24783
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
      O => CHOICE1879_FROM
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
      O => CHOICE1879_GROM
    );
  CHOICE1879_XUSED : X_BUF
    port map (
      I => CHOICE1879_FROM,
      O => CHOICE1879
    );
  CHOICE1879_YUSED : X_BUF
    port map (
      I => CHOICE1879_GROM,
      O => N25156
    );
  XLXI_10_I1_nreset_v_1_LOGIC_ONE_169 : X_ONE
    port map (
      O => XLXI_10_I1_nreset_v_1_LOGIC_ONE
    );
  XLXI_10_I1_nreset_v_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I1_nreset_v_1_SRMUX_OUTPUTNOT
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
      O => XLXI_3_n0027_GROM
    );
  XLXI_3_n0027_YUSED : X_BUF
    port map (
      I => XLXI_3_n0027_GROM,
      O => XLXI_3_n0027
    );
  XLXI_10_I2_nreset_v_1_LOGIC_ONE_170 : X_ONE
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
      INIT => X"FEFF"
    )
    port map (
      ADR0 => XLXN_8(3),
      ADR1 => XLXN_8(2),
      ADR2 => XLXN_8(0),
      ADR3 => NRESET_IBUF,
      O => XLXI_10_I2_TD_c_3_FROM
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
  XLXI_10_I2_TD_c_3_XUSED : X_BUF
    port map (
      I => XLXI_10_I2_TD_c_3_FROM,
      O => N21781
    );
  XLXI_10_I2_TD_c_3_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I2_TD_c_3_SRMUX_OUTPUTNOT
    );
  XLXI_10_I3_nreset_v_1_LOGIC_ONE_171 : X_ONE
    port map (
      O => XLXI_10_I3_nreset_v_1_LOGIC_ONE
    );
  XLXI_10_I3_nreset_v_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I3_nreset_v_1_SRMUX_OUTPUTNOT
    );
  XLXI_10_I4_nreset_v_1_LOGIC_ONE_172 : X_ONE
    port map (
      O => XLXI_10_I4_nreset_v_1_LOGIC_ONE
    );
  XLXI_10_I4_nreset_v_1_SRMUX : X_INV
    port map (
      I => NRESET_IBUF,
      O => XLXI_10_I4_nreset_v_1_SRMUX_OUTPUTNOT
    );
  XLXI_3_pwm_low_4 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_pwm_data_c(0),
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_pwm_low_5_SRMUX_OUTPUTNOT,
      O => XLXI_3_pwm_low(4)
    );
  XLXI_3_pwm_low_5 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_pwm_data_c(1),
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_pwm_low_5_SRMUX_OUTPUTNOT,
      O => XLXI_3_pwm_low(5)
    );
  XLXI_3_pwm_low_6 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_pwm_data_c(2),
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_pwm_low_7_SRMUX_OUTPUTNOT,
      O => XLXI_3_pwm_low(6)
    );
  XLXI_3_pwm_low_7 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_pwm_data_c(3),
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_pwm_low_7_SRMUX_OUTPUTNOT,
      O => XLXI_3_pwm_low(7)
    );
  XLXI_10_I1_stack_addrs_c_1_0_173 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0011_0_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_1_0_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_1_0
    );
  XLXI_10_I1_stack_addrs_c_1_0_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_1_0_FFY_RST
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
  XLXI_3_pwm_high_0 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(0),
      CE => XLXI_3_n0026,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_pwm_high_0_SRMUX_OUTPUTNOT,
      O => XLXI_3_pwm_high(0)
    );
  XLXI_3_pwm_high_2 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(2),
      CE => XLXI_3_n0026,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_pwm_high_2_SRMUX_OUTPUTNOT,
      O => XLXI_3_pwm_high(2)
    );
  XLXI_3_pwm_high_5 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(5),
      CE => XLXI_3_n0026,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_pwm_high_4_SRMUX_OUTPUTNOT,
      O => XLXI_3_pwm_high(5)
    );
  XLXI_3_pwm_high_4 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(4),
      CE => XLXI_3_n0026,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_pwm_high_4_SRMUX_OUTPUTNOT,
      O => XLXI_3_pwm_high(4)
    );
  XLXI_3_pwm_high_7 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(7),
      CE => XLXI_3_n0026,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_pwm_high_6_SRMUX_OUTPUTNOT,
      O => XLXI_3_pwm_high(7)
    );
  XLXI_3_pwm_high_6 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(6),
      CE => XLXI_3_n0026,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_pwm_high_6_SRMUX_OUTPUTNOT,
      O => XLXI_3_pwm_high(6)
    );
  XLXI_10_I1_stack_addrs_c_1_5_174 : X_FF
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
  XLXI_2_mux_c_0 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_mux_c_0_LOGIC_ONE,
      CE => VCC,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_2_n0020,
      O => XLXI_2_mux_c(0)
    );
  XLXI_3_pwm_c_175 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_c_BYMUXNOT,
      CE => XLXI_3_n0027,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_pwm_c_SRMUX_OUTPUTNOT,
      O => XLXI_3_pwm_c
    );
  XLXI_10_I1_stack_addrs_c_2_7_176 : X_FF
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
  XLXI_10_I1_stack_addrs_c_0_0_177 : X_FF
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
  XLXI_10_I1_stack_addrs_c_1_1_178 : X_FF
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
  XLXI_10_I1_stack_addrs_c_1_2_179 : X_FF
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
  XLXI_10_I1_stack_addrs_c_1_3_180 : X_FF
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
  XLXI_10_I1_stack_addrs_c_2_0_181 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0010_0_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_2_0_FFX_RST,
      O => XLXI_10_I1_stack_addrs_c_2_0
    );
  XLXI_10_I1_stack_addrs_c_2_0_FFX_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_2_0_FFX_RST
    );
  XLXI_10_I1_stack_addrs_c_0_7_182 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_10_I1_n0012_7_19_O,
      CE => XLXI_10_I1_n0014,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => XLXI_10_I1_stack_addrs_c_2_0_FFY_RST,
      O => XLXI_10_I1_stack_addrs_c_0_7
    );
  XLXI_10_I1_stack_addrs_c_2_0_FFY_RSTOR : X_BUF
    port map (
      I => GSR,
      O => XLXI_10_I1_stack_addrs_c_2_0_FFY_RST
    );
  XLXI_10_I1_stack_addrs_c_1_4_183 : X_FF
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
  XLXI_10_I1_stack_addrs_c_2_1_184 : X_FF
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
  XLXI_10_I1_stack_addrs_c_2_2_185 : X_FF
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
  XLXI_10_I1_stack_addrs_c_3_5_186 : X_FF
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
  XLXI_10_I1_stack_addrs_c_3_7_187 : X_FF
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
  XLXI_10_I3_acc_c_0_0_188 : X_FF
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
  XLXI_10_I3_acc_c_0_4_189 : X_FF
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
  XLXI_10_I3_acc_c_0_3_190 : X_FF
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
  XLXI_10_I3_acc_c_0_1_191 : X_FF
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
  XLXI_10_I3_acc_c_0_2_192 : X_FF
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
  XLXI_3_pwm_count_5 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_count_n0000(5),
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_n0007,
      O => XLXI_3_pwm_count(5)
    );
  XLXI_3_pwm_count_1 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_count_n0000(1),
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_n0007,
      O => XLXI_3_pwm_count(1)
    );
  XLXI_3_pwm_count_3 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_count_n0000(3),
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_n0007,
      O => XLXI_3_pwm_count(3)
    );
  XLXI_3_pwm_count_0 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_count_Madd_n0000_inst_lut2_0,
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_n0007,
      O => XLXI_3_pwm_count(0)
    );
  XLXI_2_pwm_data_c_3 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_Mmux_n0021_Result_3_1_O,
      CE => XLXI_2_n0042,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_2_pwm_data_c_3_SRMUX_OUTPUTNOT,
      O => XLXI_2_pwm_data_c(3)
    );
  XLXI_3_pwm_count_2 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_count_n0000(2),
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_n0007,
      O => XLXI_3_pwm_count(2)
    );
  XLXI_3_pwm_count_4 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_count_n0000(4),
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_n0007,
      O => XLXI_3_pwm_count(4)
    );
  XLXI_3_pwm_count_7 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_count_n0000(7),
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_n0007,
      O => XLXI_3_pwm_count(7)
    );
  XLXI_3_pwm_count_6 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_count_n0000(6),
      CE => XLXI_2_ctrl_data_c(0),
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_n0007,
      O => XLXI_3_pwm_count(6)
    );
  XLXI_3_pwm_high_3 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(3),
      CE => XLXI_3_n0026,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_pwm_high_2_SRMUX_OUTPUTNOT,
      O => XLXI_3_pwm_high(3)
    );
  XLXI_3_pwm_high_1 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0005(1),
      CE => XLXI_3_n0026,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_pwm_high_0_SRMUX_OUTPUTNOT,
      O => XLXI_3_pwm_high(1)
    );
  XLXI_10_I1_stack_addrs_c_0_2_193 : X_FF
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
  XLXI_10_I1_stack_addrs_c_1_6_194 : X_FF
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
  XLXI_10_I1_stack_addrs_c_0_3_195 : X_FF
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
  XLXI_10_I1_stack_addrs_c_0_4_196 : X_FF
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
  XLXI_10_I1_stack_addrs_c_0_5_197 : X_FF
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
  XLXI_10_I1_stack_addrs_c_0_6_198 : X_FF
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
  XLXI_3_pwm_period_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006_0_1_O,
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
  XLXI_3_pwm_period_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_n0006_1_1_O,
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
      I => XLXI_3_n0006_2_1_O,
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
      I => XLXI_3_n0006_3_1_O,
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
      I => XLXI_3_n0006_7_1_O,
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
      I => XLXI_3_n0006_4_1_O,
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
      I => XLXI_3_n0006_5_1_O,
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
      I => XLXI_3_n0006_6_1_O,
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
  XLXI_10_I2_skip_c_199 : X_FF
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
  XLXI_3_pwm_low_0 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_low_1_GROM,
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_pwm_low_1_SRMUX_OUTPUTNOT,
      O => XLXI_3_pwm_low(0)
    );
  XLXI_3_pwm_low_2 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_low_3_GROM,
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_pwm_low_3_SRMUX_OUTPUTNOT,
      O => XLXI_3_pwm_low(2)
    );
  XLXI_10_I4_ipage_we_c_200 : X_FF
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
  XLXI_3_pwm_low_1 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_low_1_FROM,
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_pwm_low_1_SRMUX_OUTPUTNOT,
      O => XLXI_3_pwm_low(1)
    );
  XLXI_3_pwm_low_3 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_pwm_low_3_FROM,
      CE => XLXI_3_n0003,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_3_pwm_low_3_SRMUX_OUTPUTNOT,
      O => XLXI_3_pwm_low(3)
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
  XLXI_10_I2_valid_c_201 : X_FF
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
  XLXI_10_I2_valid_c_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_10_I2_valid_c_SRMUX_OUTPUTNOT,
      I1 => GSR,
      O => XLXI_10_I2_valid_c_FFY_RST
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
  XLXI_10_I1_stack_addrs_c_2_3_202 : X_FF
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
  XLXI_10_I1_stack_addrs_c_3_0_203 : X_FF
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
  XLXI_10_I1_stack_addrs_c_2_4_204 : X_FF
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
  XLXI_10_I1_stack_addrs_c_2_5_205 : X_FF
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
  XLXI_10_I1_stack_addrs_c_3_3_206 : X_FF
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
  XLXI_10_I1_stack_addrs_c_3_2_207 : X_FF
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
  XLXI_10_I1_stack_addrs_c_2_6_208 : X_FF
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
  XLXI_10_I1_stack_addrs_c_3_6_209 : X_FF
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
  XLXI_10_I1_stack_addrs_c_3_4_210 : X_FF
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
  XLXI_10_I1_stack_addrs_c_3_1_211 : X_FF
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
  XLXI_2_pwm_data_c_0 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_Mmux_n0021_Result_0_1_O,
      CE => XLXI_2_n0042,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_2_pwm_data_c_1_SRMUX_OUTPUTNOT,
      O => XLXI_2_pwm_data_c(0)
    );
  XLXI_2_pwm_data_c_1 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_Mmux_n0021_Result_1_1_O,
      CE => XLXI_2_n0042,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_2_pwm_data_c_1_SRMUX_OUTPUTNOT,
      O => XLXI_2_pwm_data_c(1)
    );
  XLXI_2_pwm_data_c_2 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_Mmux_n0021_Result_2_1_O,
      CE => XLXI_2_n0042,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_2_pwm_data_c_3_SRMUX_OUTPUTNOT,
      O => XLXI_2_pwm_data_c(2)
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
  XLXI_10_I1_stack_addrs_c_1_7_212 : X_FF
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
  XLXI_10_I5_ndwe_c_213 : X_FF
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
  XLXI_2_ctrl_data_c_0 : X_SFF
    generic map(
      INIT => '0'
    )
    port map (
      I => CPU_DATA_OUT_0_OBUF,
      CE => XLXI_2_n0043,
      CLK => CLK_BUFGP,
      SET => GND,
      RST => GSR,
      SSET => GND,
      SRST => XLXI_2_ctrl_data_c_0_SRMUX_OUTPUTNOT,
      O => XLXI_2_ctrl_data_c(0)
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

