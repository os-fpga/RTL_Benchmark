-- Xilinx Vhdl netlist produced by netgen application (version G.26)
-- Command       : -intstyle ise -s 4 -pcf cpu16bit.pcf -ngm cpu16bit.ngm -rpw 100 -tpw 0 -ar Structure -xon true -w -ofmt vhdl -sim cpu16bit.ncd cpu16bit_timesim.vhd 
-- Input file    : cpu16bit.ncd
-- Output file   : cpu16bit_timesim.vhd
-- Design name   : cpu16bit
-- # of Entities : 1
-- Xilinx        : C:/Xilinx
-- Device        : 3s50pq208-4 (PREVIEW 1.27 2003-11-04)

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

entity cpu16bit is
  port (
    NCS_EXT : out STD_LOGIC; 
    NRE_EXT : out STD_LOGIC; 
    NWE_EXT : out STD_LOGIC; 
    NRESET_IN : in STD_LOGIC := 'X'; 
    CPU_INT : in STD_LOGIC := 'X'; 
    CLK_IN : in STD_LOGIC := 'X'; 
    ADDR_OUT_EXT : out STD_LOGIC_VECTOR ( 9 downto 0 ); 
    DATA_OUT_EXT : out STD_LOGIC_VECTOR ( 15 downto 0 ); 
    DATA_IN_EXT : in STD_LOGIC_VECTOR ( 15 downto 0 ) 
  );
end cpu16bit;

architecture Structure of cpu16bit is
  signal GLOBAL_LOGIC0 : STD_LOGIC; 
  signal XLXI_4_n00021_SW1_O : STD_LOGIC; 
  signal N30764 : STD_LOGIC; 
  signal XLXI_4_Maddsub_n0001_inst_cy_1 : STD_LOGIC; 
  signal XLXI_4_n00021_SW3_O : STD_LOGIC; 
  signal N30770 : STD_LOGIC; 
  signal XLXI_4_n00021_SW5_O : STD_LOGIC; 
  signal N30776 : STD_LOGIC; 
  signal XLXI_4_Maddsub_n0001_inst_cy_3 : STD_LOGIC; 
  signal XLXI_4_n00021_SW7_O : STD_LOGIC; 
  signal N30782 : STD_LOGIC; 
  signal XLXI_4_n00021_SW9_O : STD_LOGIC; 
  signal N30788 : STD_LOGIC; 
  signal XLXI_4_Maddsub_n0001_inst_cy_5 : STD_LOGIC; 
  signal XLXI_4_n00021_SW11_O : STD_LOGIC; 
  signal N30794 : STD_LOGIC; 
  signal XLXI_4_n0002 : STD_LOGIC; 
  signal Cpu16_I1_Madd_n0009_inst_cy_17 : STD_LOGIC; 
  signal Cpu16_I1_Madd_n0009_inst_cy_19 : STD_LOGIC; 
  signal Cpu16_I1_Madd_n0009_inst_cy_21 : STD_LOGIC; 
  signal Cpu16_I1_Madd_n0009_inst_cy_23 : STD_LOGIC; 
  signal Cpu16_I1_Madd_n0009_inst_cy_25 : STD_LOGIC; 
  signal GLOBAL_LOGIC1 : STD_LOGIC; 
  signal XLXI_5_Msub_n0011_inst_cy_9 : STD_LOGIC; 
  signal XLXI_5_Msub_n0011_inst_cy_11 : STD_LOGIC; 
  signal XLXI_5_Msub_n0011_inst_cy_13 : STD_LOGIC; 
  signal XLXI_5_Msub_n0011_inst_lut2_14 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_0 : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_lut2_44 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_1 : STD_LOGIC; 
  signal Cpu16_I3_n0025 : STD_LOGIC; 
  signal CHOICE1485 : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_cy_46 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_2 : STD_LOGIC; 
  signal CHOICE1430 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_3 : STD_LOGIC; 
  signal CHOICE1342 : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_cy_48 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_4 : STD_LOGIC; 
  signal CHOICE1287 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_5 : STD_LOGIC; 
  signal CHOICE1232 : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_cy_50 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_6 : STD_LOGIC; 
  signal CHOICE1177 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_7 : STD_LOGIC; 
  signal CHOICE1122 : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_cy_52 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_8 : STD_LOGIC; 
  signal CHOICE1067 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_9 : STD_LOGIC; 
  signal CHOICE1012 : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_cy_54 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_10 : STD_LOGIC; 
  signal CHOICE957 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_11 : STD_LOGIC; 
  signal CHOICE902 : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_cy_56 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_12 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_13 : STD_LOGIC; 
  signal Cpu16_I4_N18350 : STD_LOGIC; 
  signal N24899 : STD_LOGIC; 
  signal N30800 : STD_LOGIC; 
  signal N30802 : STD_LOGIC; 
  signal N24841 : STD_LOGIC; 
  signal N30806 : STD_LOGIC; 
  signal N30808 : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_cy_58 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_14 : STD_LOGIC; 
  signal N24783 : STD_LOGIC; 
  signal N30812 : STD_LOGIC; 
  signal N30814 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_15 : STD_LOGIC; 
  signal Cpu16_I3_data_x_15_Q : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_27 : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_cy_29 : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_cy_31 : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_cy_33 : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_cy_35 : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_cy_37 : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_cy_39 : STD_LOGIC; 
  signal N30281 : STD_LOGIC; 
  signal N30283 : STD_LOGIC; 
  signal N30287 : STD_LOGIC; 
  signal N30289 : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_cy_41 : STD_LOGIC; 
  signal N30492 : STD_LOGIC; 
  signal N30494 : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_cy_43 : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_60 : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_cy_62 : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_cy_64 : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_cy_66 : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_cy_68 : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_cy_70 : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_71 : STD_LOGIC; 
  signal NRESET_IN_BUFGP : STD_LOGIC; 
  signal CLK_IN_BUFGP : STD_LOGIC; 
  signal CPU_NADWE : STD_LOGIC; 
  signal DATA_OUT_EXT_0_OBUF : STD_LOGIC; 
  signal DATA_OUT_EXT_1_OBUF : STD_LOGIC; 
  signal DATA_OUT_EXT_2_OBUF : STD_LOGIC; 
  signal DATA_OUT_EXT_3_OBUF : STD_LOGIC; 
  signal DATA_OUT_EXT_4_OBUF : STD_LOGIC; 
  signal DATA_OUT_EXT_5_OBUF : STD_LOGIC; 
  signal DATA_OUT_EXT_6_OBUF : STD_LOGIC; 
  signal DATA_OUT_EXT_7_OBUF : STD_LOGIC; 
  signal DATA_OUT_EXT_8_OBUF : STD_LOGIC; 
  signal DATA_OUT_EXT_9_OBUF : STD_LOGIC; 
  signal CPU_INT_IBUF : STD_LOGIC; 
  signal ADDR_OUT_EXT_0_OBUF : STD_LOGIC; 
  signal ADDR_OUT_EXT_1_OBUF : STD_LOGIC; 
  signal ADDR_OUT_EXT_2_OBUF : STD_LOGIC; 
  signal ADDR_OUT_EXT_3_OBUF : STD_LOGIC; 
  signal ADDR_OUT_EXT_4_OBUF : STD_LOGIC; 
  signal ADDR_OUT_EXT_5_OBUF : STD_LOGIC; 
  signal ADDR_OUT_EXT_6_OBUF : STD_LOGIC; 
  signal ADDR_OUT_EXT_7_OBUF : STD_LOGIC; 
  signal ADDR_OUT_EXT_8_OBUF : STD_LOGIC; 
  signal ADDR_OUT_EXT_9_OBUF : STD_LOGIC; 
  signal DATA_IN_EXT_10_IBUF : STD_LOGIC; 
  signal DATA_IN_EXT_11_IBUF : STD_LOGIC; 
  signal DATA_IN_EXT_12_IBUF : STD_LOGIC; 
  signal DATA_IN_EXT_13_IBUF : STD_LOGIC; 
  signal DATA_IN_EXT_14_IBUF : STD_LOGIC; 
  signal DATA_IN_EXT_15_IBUF : STD_LOGIC; 
  signal DATA_OUT_EXT_10_OBUF : STD_LOGIC; 
  signal DATA_OUT_EXT_11_OBUF : STD_LOGIC; 
  signal DATA_OUT_EXT_12_OBUF : STD_LOGIC; 
  signal DATA_OUT_EXT_13_OBUF : STD_LOGIC; 
  signal DATA_OUT_EXT_14_OBUF : STD_LOGIC; 
  signal DATA_OUT_EXT_15_OBUF : STD_LOGIC; 
  signal CLK_IN_BUFGP_IBUFG : STD_LOGIC; 
  signal NRESET_IN_BUFGP_IBUFG : STD_LOGIC; 
  signal NACS_EXT : STD_LOGIC; 
  signal DATA_IN_EXT_0_IBUF : STD_LOGIC; 
  signal DATA_IN_EXT_1_IBUF : STD_LOGIC; 
  signal DATA_IN_EXT_2_IBUF : STD_LOGIC; 
  signal DATA_IN_EXT_3_IBUF : STD_LOGIC; 
  signal DATA_IN_EXT_4_IBUF : STD_LOGIC; 
  signal DATA_IN_EXT_5_IBUF : STD_LOGIC; 
  signal DATA_IN_EXT_6_IBUF : STD_LOGIC; 
  signal DATA_IN_EXT_7_IBUF : STD_LOGIC; 
  signal DATA_IN_EXT_8_IBUF : STD_LOGIC; 
  signal DATA_IN_EXT_9_IBUF : STD_LOGIC; 
  signal NRE_EXT_OBUF : STD_LOGIC; 
  signal XLXI_2_nWE_RAM_c : STD_LOGIC; 
  signal XLXN_1 : STD_LOGIC; 
  signal Cpu16_I4_N18033 : STD_LOGIC; 
  signal Cpu16_I4_n0157 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_0_1 : STD_LOGIC; 
  signal Cpu16_I4_ireg_we_c : STD_LOGIC; 
  signal Cpu16_I4_N18286 : STD_LOGIC; 
  signal Cpu16_I4_N18018 : STD_LOGIC; 
  signal CHOICE1525 : STD_LOGIC; 
  signal N31024 : STD_LOGIC; 
  signal CHOICE712 : STD_LOGIC; 
  signal CHOICE746 : STD_LOGIC; 
  signal Cpu16_I3_n0023 : STD_LOGIC; 
  signal CHOICE740 : STD_LOGIC; 
  signal Cpu16_I3_n0100 : STD_LOGIC; 
  signal Cpu16_I2_TD_c_3_1 : STD_LOGIC; 
  signal N30438 : STD_LOGIC; 
  signal N30440 : STD_LOGIC; 
  signal N30892 : STD_LOGIC; 
  signal Cpu16_I2_n0150 : STD_LOGIC; 
  signal Cpu16_I2_n0142 : STD_LOGIC; 
  signal CHOICE1587 : STD_LOGIC; 
  signal Cpu16_I2_int_start_c : STD_LOGIC; 
  signal CHOICE1584 : STD_LOGIC; 
  signal CHOICE1565 : STD_LOGIC; 
  signal Cpu16_I3_skip_i : STD_LOGIC; 
  signal N31122 : STD_LOGIC; 
  signal CPU_NDRE : STD_LOGIC; 
  signal XLXI_3_N12472 : STD_LOGIC; 
  signal N31168 : STD_LOGIC; 
  signal Cpu16_I2_n01501_2 : STD_LOGIC; 
  signal CHOICE1534 : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_3 : STD_LOGIC; 
  signal Cpu16_I2_TD_c_0_3 : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_16 : STD_LOGIC; 
  signal CHOICE737 : STD_LOGIC; 
  signal N31164 : STD_LOGIC; 
  signal Cpu16_I3_n0087 : STD_LOGIC; 
  signal N31797 : STD_LOGIC; 
  signal Cpu16_I2_TC_c_2_1 : STD_LOGIC; 
  signal Cpu16_I2_TC_c_0_1 : STD_LOGIC; 
  signal Cpu16_I2_TC_c_1_1 : STD_LOGIC; 
  signal Cpu16_I3_N17260 : STD_LOGIC; 
  signal Cpu16_I4_ndre_x1_1 : STD_LOGIC; 
  signal CHOICE972 : STD_LOGIC; 
  signal N30361 : STD_LOGIC; 
  signal N30359 : STD_LOGIC; 
  signal N30661 : STD_LOGIC; 
  signal CHOICE966 : STD_LOGIC; 
  signal N30659 : STD_LOGIC; 
  signal N31988 : STD_LOGIC; 
  signal Cpu16_I2_ndre_x1_SW5_SW0_SW0_SW1_O : STD_LOGIC; 
  signal N30269 : STD_LOGIC; 
  signal N31370 : STD_LOGIC; 
  signal N31405 : STD_LOGIC; 
  signal CHOICE1027 : STD_LOGIC; 
  signal N30355 : STD_LOGIC; 
  signal N30353 : STD_LOGIC; 
  signal N30679 : STD_LOGIC; 
  signal CHOICE1021 : STD_LOGIC; 
  signal N30677 : STD_LOGIC; 
  signal N31914 : STD_LOGIC; 
  signal Cpu16_I2_n0077 : STD_LOGIC; 
  signal N30970 : STD_LOGIC; 
  signal N30972 : STD_LOGIC; 
  signal N31181 : STD_LOGIC; 
  signal N31179 : STD_LOGIC; 
  signal N30420 : STD_LOGIC; 
  signal N30964 : STD_LOGIC; 
  signal N30966 : STD_LOGIC; 
  signal N31058 : STD_LOGIC; 
  signal Cpu16_I1_n0010 : STD_LOGIC; 
  signal Cpu16_I1_iaddr_x_0_5_O : STD_LOGIC; 
  signal N31160 : STD_LOGIC; 
  signal Cpu16_I2_pc_mux_x_2_46_2 : STD_LOGIC; 
  signal Cpu16_I2_pc_mux_x_0_104_2 : STD_LOGIC; 
  signal Cpu16_I2_TC_x_0_SW0_SW3_SW0_O : STD_LOGIC; 
  signal N31060 : STD_LOGIC; 
  signal Cpu16_int_stop : STD_LOGIC; 
  signal CHOICE1082 : STD_LOGIC; 
  signal N30349 : STD_LOGIC; 
  signal N30347 : STD_LOGIC; 
  signal N30613 : STD_LOGIC; 
  signal CHOICE1076 : STD_LOGIC; 
  signal N30611 : STD_LOGIC; 
  signal N31968 : STD_LOGIC; 
  signal Cpu16_I1_iaddr_x_1_5_O : STD_LOGIC; 
  signal Cpu16_I3_Mmux_data_x_Result_0_85_SW0_O : STD_LOGIC; 
  signal N30542 : STD_LOGIC; 
  signal Cpu16_I4_n0202 : STD_LOGIC; 
  signal CHOICE1520 : STD_LOGIC; 
  signal N31890 : STD_LOGIC; 
  signal Cpu16_I2_ndre_x1_SW6_SW0_SW0_SW1_O : STD_LOGIC; 
  signal N31376 : STD_LOGIC; 
  signal N31409 : STD_LOGIC; 
  signal Cpu16_I2_pc_mux_x_1_44_2 : STD_LOGIC; 
  signal Cpu16_I2_nreset_v_1_1 : STD_LOGIC; 
  signal CHOICE687 : STD_LOGIC; 
  signal CHOICE679 : STD_LOGIC; 
  signal Cpu16_I2_n0145 : STD_LOGIC; 
  signal CHOICE497 : STD_LOGIC; 
  signal Cpu16_I1_iaddr_x_2_5_O : STD_LOGIC; 
  signal CHOICE502 : STD_LOGIC; 
  signal Cpu16_I1_N13702 : STD_LOGIC; 
  signal Cpu16_I2_n0062 : STD_LOGIC; 
  signal Cpu16_I2_N15561 : STD_LOGIC; 
  signal Cpu16_I2_N15717 : STD_LOGIC; 
  signal N31104 : STD_LOGIC; 
  signal Cpu16_I2_N15618 : STD_LOGIC; 
  signal N31580 : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd3 : STD_LOGIC; 
  signal Cpu16_I1_iaddr_x_4_14_O : STD_LOGIC; 
  signal CHOICE572 : STD_LOGIC; 
  signal CHOICE665 : STD_LOGIC; 
  signal CHOICE660 : STD_LOGIC; 
  signal Cpu16_I2_Mmux_skip_x_Result1_1 : STD_LOGIC; 
  signal CHOICE558 : STD_LOGIC; 
  signal CHOICE1137 : STD_LOGIC; 
  signal N30343 : STD_LOGIC; 
  signal N30341 : STD_LOGIC; 
  signal N30607 : STD_LOGIC; 
  signal CHOICE1131 : STD_LOGIC; 
  signal N30605 : STD_LOGIC; 
  signal N31938 : STD_LOGIC; 
  signal N20734 : STD_LOGIC; 
  signal XLXI_3_nadwe_c_N1214 : STD_LOGIC; 
  signal Cpu16_I1_iaddr_x_5_14_O : STD_LOGIC; 
  signal CHOICE484 : STD_LOGIC; 
  signal CHOICE485 : STD_LOGIC; 
  signal Cpu16_I1_Mmux_saddr_out_Result_10_6_O : STD_LOGIC; 
  signal Cpu16_I1_n0020 : STD_LOGIC; 
  signal Cpu16_I1_n0024 : STD_LOGIC; 
  signal Cpu16_ndre_int : STD_LOGIC; 
  signal Cpu16_I4_n0162 : STD_LOGIC; 
  signal Cpu16_I4_n0203 : STD_LOGIC; 
  signal CHOICE589 : STD_LOGIC; 
  signal Cpu16_I1_iaddr_x_6_14_O : STD_LOGIC; 
  signal CHOICE544 : STD_LOGIC; 
  signal CHOICE396 : STD_LOGIC; 
  signal CHOICE397 : STD_LOGIC; 
  signal Cpu16_I1_Mmux_saddr_out_Result_11_6_O : STD_LOGIC; 
  signal Cpu16_I1_iaddr_x_10_14_O : STD_LOGIC; 
  signal CHOICE378 : STD_LOGIC; 
  signal Cpu16_I2_pc_mux_x_0_104_1 : STD_LOGIC; 
  signal Cpu16_I2_pc_mux_x_1_44_1 : STD_LOGIC; 
  signal Cpu16_I1_iaddr_x_7_14_O : STD_LOGIC; 
  signal CHOICE516 : STD_LOGIC; 
  signal Cpu16_I1_iaddr_x_11_14_O : STD_LOGIC; 
  signal CHOICE364 : STD_LOGIC; 
  signal Cpu16_I1_iaddr_x_8_14_O : STD_LOGIC; 
  signal CHOICE530 : STD_LOGIC; 
  signal CHOICE1192 : STD_LOGIC; 
  signal N30337 : STD_LOGIC; 
  signal N30335 : STD_LOGIC; 
  signal N30619 : STD_LOGIC; 
  signal CHOICE1186 : STD_LOGIC; 
  signal N30617 : STD_LOGIC; 
  signal N31976 : STD_LOGIC; 
  signal N31120 : STD_LOGIC; 
  signal Cpu16_I2_n01011_SW3_O : STD_LOGIC; 
  signal N31252 : STD_LOGIC; 
  signal Cpu16_I2_skip_x : STD_LOGIC; 
  signal Cpu16_I2_C_mem_x : STD_LOGIC; 
  signal Cpu16_I4_dexp_we_c : STD_LOGIC; 
  signal CHOICE47 : STD_LOGIC; 
  signal Cpu16_I2_C_rti : STD_LOGIC; 
  signal CHOICE52 : STD_LOGIC; 
  signal Cpu16_I4_n0216 : STD_LOGIC; 
  signal Cpu16_I2_int_stop_c : STD_LOGIC; 
  signal Cpu16_I4_n01621_1 : STD_LOGIC; 
  signal Cpu16_ndwe_int : STD_LOGIC; 
  signal N31051 : STD_LOGIC; 
  signal Cpu16_I4_N18224 : STD_LOGIC; 
  signal XLXI_3_nadwe_c : STD_LOGIC; 
  signal N30488 : STD_LOGIC; 
  signal Cpu16_I2_skip_c : STD_LOGIC; 
  signal XLXN_2 : STD_LOGIC; 
  signal Cpu16_I2_C_raw : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd2 : STD_LOGIC; 
  signal Cpu16_skip : STD_LOGIC; 
  signal N30884 : STD_LOGIC; 
  signal N30430 : STD_LOGIC; 
  signal N31146 : STD_LOGIC; 
  signal CHOICE583 : STD_LOGIC; 
  signal Cpu16_I4_n020220_SW0_O : STD_LOGIC; 
  signal N31064 : STD_LOGIC; 
  signal N30562 : STD_LOGIC; 
  signal N30265 : STD_LOGIC; 
  signal N30976 : STD_LOGIC; 
  signal CHOICE606 : STD_LOGIC; 
  signal N31355 : STD_LOGIC; 
  signal N31353 : STD_LOGIC; 
  signal Cpu16_I2_N15700 : STD_LOGIC; 
  signal CHOICE404 : STD_LOGIC; 
  signal CHOICE405 : STD_LOGIC; 
  signal Cpu16_I1_Mmux_saddr_out_Result_0_6_O : STD_LOGIC; 
  signal CHOICE255 : STD_LOGIC; 
  signal Cpu16_I2_valid_c : STD_LOGIC; 
  signal CHOICE1593 : STD_LOGIC; 
  signal CHOICE412 : STD_LOGIC; 
  signal CHOICE413 : STD_LOGIC; 
  signal Cpu16_I1_Mmux_saddr_out_Result_1_6_O : STD_LOGIC; 
  signal N31070 : STD_LOGIC; 
  signal N31223 : STD_LOGIC; 
  signal CHOICE428 : STD_LOGIC; 
  signal CHOICE429 : STD_LOGIC; 
  signal Cpu16_I1_Mmux_saddr_out_Result_2_6_O : STD_LOGIC; 
  signal N31072 : STD_LOGIC; 
  signal N31066 : STD_LOGIC; 
  signal Cpu16_I2_ndre_x1_SW0_SW2_SW0_O : STD_LOGIC; 
  signal N31173 : STD_LOGIC; 
  signal CHOICE420 : STD_LOGIC; 
  signal CHOICE421 : STD_LOGIC; 
  signal Cpu16_I1_Mmux_saddr_out_Result_3_6_O : STD_LOGIC; 
  signal XLXI_5_N12936 : STD_LOGIC; 
  signal XLXI_5_N12957 : STD_LOGIC; 
  signal CHOICE436 : STD_LOGIC; 
  signal CHOICE437 : STD_LOGIC; 
  signal Cpu16_I1_Mmux_saddr_out_Result_4_6_O : STD_LOGIC; 
  signal CHOICE444 : STD_LOGIC; 
  signal CHOICE445 : STD_LOGIC; 
  signal Cpu16_I1_Mmux_saddr_out_Result_5_6_O : STD_LOGIC; 
  signal CHOICE452 : STD_LOGIC; 
  signal CHOICE453 : STD_LOGIC; 
  signal Cpu16_I1_Mmux_saddr_out_Result_6_6_O : STD_LOGIC; 
  signal CHOICE460 : STD_LOGIC; 
  signal CHOICE461 : STD_LOGIC; 
  signal Cpu16_I1_Mmux_saddr_out_Result_7_6_O : STD_LOGIC; 
  signal Cpu16_I2_pc_mux_x_2_46_1 : STD_LOGIC; 
  signal Cpu16_I1_N13634 : STD_LOGIC; 
  signal CHOICE468 : STD_LOGIC; 
  signal CHOICE469 : STD_LOGIC; 
  signal Cpu16_I1_Mmux_saddr_out_Result_8_6_O : STD_LOGIC; 
  signal CHOICE476 : STD_LOGIC; 
  signal CHOICE477 : STD_LOGIC; 
  signal Cpu16_I1_Mmux_saddr_out_Result_9_6_O : STD_LOGIC; 
  signal Cpu16_I2_n0151 : STD_LOGIC; 
  signal CHOICE1577 : STD_LOGIC; 
  signal Cpu16_I2_C_store_x : STD_LOGIC; 
  signal XLXI_5_ndre_c : STD_LOGIC; 
  signal Cpu16_I3_Mmux_data_x_Result_0_32_SW1_O : STD_LOGIC; 
  signal N31258 : STD_LOGIC; 
  signal CHOICE1531 : STD_LOGIC; 
  signal CHOICE1553 : STD_LOGIC; 
  signal N30906 : STD_LOGIC; 
  signal CHOICE1538 : STD_LOGIC; 
  signal CHOICE1562 : STD_LOGIC; 
  signal Cpu16_I4_N18357 : STD_LOGIC; 
  signal CHOICE1476 : STD_LOGIC; 
  signal Cpu16_I2_ndre_x1_SW1_O : STD_LOGIC; 
  signal N31926 : STD_LOGIC; 
  signal CHOICE720 : STD_LOGIC; 
  signal CHOICE713 : STD_LOGIC; 
  signal N30890 : STD_LOGIC; 
  signal CHOICE1479 : STD_LOGIC; 
  signal Cpu16_I2_ndre_x1_SW1_SW0_O : STD_LOGIC; 
  signal N31234 : STD_LOGIC; 
  signal N30558 : STD_LOGIC; 
  signal CHOICE1483 : STD_LOGIC; 
  signal N30872 : STD_LOGIC; 
  signal N30820 : STD_LOGIC; 
  signal CHOICE942 : STD_LOGIC; 
  signal CHOICE955 : STD_LOGIC; 
  signal CHOICE1241 : STD_LOGIC; 
  signal N30694 : STD_LOGIC; 
  signal CHOICE1421 : STD_LOGIC; 
  signal Cpu16_I2_ndre_x1_SW2_SW0_O : STD_LOGIC; 
  signal CHOICE1424 : STD_LOGIC; 
  signal N31238 : STD_LOGIC; 
  signal CHOICE1428 : STD_LOGIC; 
  signal N30878 : STD_LOGIC; 
  signal N30880 : STD_LOGIC; 
  signal CHOICE887 : STD_LOGIC; 
  signal CHOICE900 : STD_LOGIC; 
  signal CHOICE1296 : STD_LOGIC; 
  signal Cpu16_I2_ndre_x1_SW3_SW0_O : STD_LOGIC; 
  signal CHOICE1333 : STD_LOGIC; 
  signal CHOICE1336 : STD_LOGIC; 
  signal N31242 : STD_LOGIC; 
  signal CHOICE1340 : STD_LOGIC; 
  signal N30412 : STD_LOGIC; 
  signal Cpu16_I2_ndre_x1_SW12_O : STD_LOGIC; 
  signal N31230 : STD_LOGIC; 
  signal Cpu16_I3_data_x_12_Q : STD_LOGIC; 
  signal Cpu16_I3_n0082 : STD_LOGIC; 
  signal Cpu16_I3_N17389 : STD_LOGIC; 
  signal CHOICE1351 : STD_LOGIC; 
  signal Cpu16_I2_ndre_x1_SW4_SW0_O : STD_LOGIC; 
  signal CHOICE1278 : STD_LOGIC; 
  signal CHOICE1281 : STD_LOGIC; 
  signal N31271 : STD_LOGIC; 
  signal CHOICE1285 : STD_LOGIC; 
  signal Cpu16_I3_data_x_13_Q : STD_LOGIC; 
  signal CHOICE1439 : STD_LOGIC; 
  signal Cpu16_I2_ndre_x1_SW5_SW0_O : STD_LOGIC; 
  signal CHOICE1223 : STD_LOGIC; 
  signal CHOICE1226 : STD_LOGIC; 
  signal CHOICE1230 : STD_LOGIC; 
  signal Cpu16_I3_data_x_14_Q : STD_LOGIC; 
  signal CHOICE1494 : STD_LOGIC; 
  signal Cpu16_I2_ndre_x1_SW6_SW0_O : STD_LOGIC; 
  signal CHOICE1168 : STD_LOGIC; 
  signal CHOICE1171 : STD_LOGIC; 
  signal CHOICE1175 : STD_LOGIC; 
  signal N24468 : STD_LOGIC; 
  signal CHOICE1631 : STD_LOGIC; 
  signal CHOICE1113 : STD_LOGIC; 
  signal CHOICE1116 : STD_LOGIC; 
  signal CHOICE1120 : STD_LOGIC; 
  signal Cpu16_I3_data_x_0_Q : STD_LOGIC; 
  signal CHOICE717 : STD_LOGIC; 
  signal Cpu16_I3_n0085 : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_0 : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_1 : STD_LOGIC; 
  signal CHOICE1058 : STD_LOGIC; 
  signal Cpu16_I3_Mmux_data_x_Result_8_37_O : STD_LOGIC; 
  signal Cpu16_I2_Mmux_idata_x_Result_4_1_1 : STD_LOGIC; 
  signal Cpu16_I2_Mmux_idata_x_Result_6_1_1 : STD_LOGIC; 
  signal CHOICE1065 : STD_LOGIC; 
  signal CHOICE1003 : STD_LOGIC; 
  signal Cpu16_I3_Mmux_data_x_Result_9_37_O : STD_LOGIC; 
  signal CHOICE1010 : STD_LOGIC; 
  signal Cpu16_I2_int_start_c_1 : STD_LOGIC; 
  signal CHOICE827 : STD_LOGIC; 
  signal N30379 : STD_LOGIC; 
  signal Cpu16_I3_n0147_2_39_SW0_O : STD_LOGIC; 
  signal CHOICE820 : STD_LOGIC; 
  signal Cpu16_I3_n0083 : STD_LOGIC; 
  signal N31948 : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_2 : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_3 : STD_LOGIC; 
  signal Cpu16_I2_TC_x_2_SW0_SW1_O : STD_LOGIC; 
  signal N30758 : STD_LOGIC; 
  signal N21764 : STD_LOGIC; 
  signal CHOICE913 : STD_LOGIC; 
  signal N30367 : STD_LOGIC; 
  signal Cpu16_I3_n0147_4_39_SW0_O : STD_LOGIC; 
  signal CHOICE906 : STD_LOGIC; 
  signal N31904 : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_4 : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_5 : STD_LOGIC; 
  signal N31187 : STD_LOGIC; 
  signal N31185 : STD_LOGIC; 
  signal Cpu16_I2_C_jmp : STD_LOGIC; 
  signal N30405 : STD_LOGIC; 
  signal CHOICE1023 : STD_LOGIC; 
  signal Cpu16_I3_n0147_6_39_SW0_O : STD_LOGIC; 
  signal CHOICE1016 : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_6 : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_7 : STD_LOGIC; 
  signal N30434 : STD_LOGIC; 
  signal N30698 : STD_LOGIC; 
  signal N30261 : STD_LOGIC; 
  signal Cpu16_I2_n01501_1 : STD_LOGIC; 
  signal N31076 : STD_LOGIC; 
  signal Cpu16_I4_n020253_SW0_SW0_SW1_O : STD_LOGIC; 
  signal Cpu16_I2_n01011_SW0_SW0_O : STD_LOGIC; 
  signal Cpu16_I4_N18068 : STD_LOGIC; 
  signal N30416 : STD_LOGIC; 
  signal CHOICE1133 : STD_LOGIC; 
  signal Cpu16_I3_n0147_8_39_SW0_O : STD_LOGIC; 
  signal CHOICE1126 : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_8 : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_9 : STD_LOGIC; 
  signal Cpu16_I3_n009675_O : STD_LOGIC; 
  signal CHOICE1601 : STD_LOGIC; 
  signal CHOICE1608 : STD_LOGIC; 
  signal CHOICE1616 : STD_LOGIC; 
  signal CHOICE1623 : STD_LOGIC; 
  signal Cpu16_I1_iaddr_x_9_47_O : STD_LOGIC; 
  signal CHOICE387 : STD_LOGIC; 
  signal CHOICE392 : STD_LOGIC; 
  signal CHOICE1540 : STD_LOGIC; 
  signal N31289 : STD_LOGIC; 
  signal N31291 : STD_LOGIC; 
  signal N30842 : STD_LOGIC; 
  signal CHOICE1470 : STD_LOGIC; 
  signal CHOICE794 : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_1 : STD_LOGIC; 
  signal Cpu16_I2_TD_c_0_1 : STD_LOGIC; 
  signal Cpu16_I2_TD_c_1_1 : STD_LOGIC; 
  signal N31026 : STD_LOGIC; 
  signal N30848 : STD_LOGIC; 
  signal CHOICE1415 : STD_LOGIC; 
  signal CHOICE825 : STD_LOGIC; 
  signal N30830 : STD_LOGIC; 
  signal CHOICE1327 : STD_LOGIC; 
  signal CHOICE856 : STD_LOGIC; 
  signal N30824 : STD_LOGIC; 
  signal CHOICE1272 : STD_LOGIC; 
  signal CHOICE911 : STD_LOGIC; 
  signal N30818 : STD_LOGIC; 
  signal CHOICE1217 : STD_LOGIC; 
  signal Cpu16_I3_Mmux_data_x_Result_10_37_O : STD_LOGIC; 
  signal CHOICE948 : STD_LOGIC; 
  signal Cpu16_I2_Ker156981_SW0_SW0_O : STD_LOGIC; 
  signal N30836 : STD_LOGIC; 
  signal CHOICE1162 : STD_LOGIC; 
  signal Cpu16_I3_Mmux_data_x_Result_11_37_O : STD_LOGIC; 
  signal CHOICE893 : STD_LOGIC; 
  signal N30854 : STD_LOGIC; 
  signal CHOICE1107 : STD_LOGIC; 
  signal Cpu16_I2_n00971_SW1_O : STD_LOGIC; 
  signal N30426 : STD_LOGIC; 
  signal N30424 : STD_LOGIC; 
  signal N30860 : STD_LOGIC; 
  signal CHOICE1052 : STD_LOGIC; 
  signal N30866 : STD_LOGIC; 
  signal CHOICE997 : STD_LOGIC; 
  signal N31150 : STD_LOGIC; 
  signal Cpu16_I2_ndre_x1_SW1_SW0_SW0_SW1_O : STD_LOGIC; 
  signal N31191 : STD_LOGIC; 
  signal Cpu16_I2_n01451_SW0_O : STD_LOGIC; 
  signal CHOICE1247 : STD_LOGIC; 
  signal N30331 : STD_LOGIC; 
  signal N30329 : STD_LOGIC; 
  signal N30595 : STD_LOGIC; 
  signal N30593 : STD_LOGIC; 
  signal N31934 : STD_LOGIC; 
  signal N20432 : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd1 : STD_LOGIC; 
  signal CHOICE1243 : STD_LOGIC; 
  signal Cpu16_I3_n0147_10_39_SW0_O : STD_LOGIC; 
  signal CHOICE1236 : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_10 : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_11 : STD_LOGIC; 
  signal CHOICE1353 : STD_LOGIC; 
  signal N30319 : STD_LOGIC; 
  signal Cpu16_I3_n0147_12_39_SW0_O : STD_LOGIC; 
  signal CHOICE1346 : STD_LOGIC; 
  signal N31900 : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_12 : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_13 : STD_LOGIC; 
  signal CHOICE1496 : STD_LOGIC; 
  signal N30307 : STD_LOGIC; 
  signal Cpu16_I3_n0147_14_39_SW0_O : STD_LOGIC; 
  signal CHOICE1489 : STD_LOGIC; 
  signal N31896 : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_14 : STD_LOGIC; 
  signal CHOICE1633 : STD_LOGIC; 
  signal N30301 : STD_LOGIC; 
  signal Cpu16_I3_n0147_15_39_SW0_O : STD_LOGIC; 
  signal CHOICE1626 : STD_LOGIC; 
  signal N31944 : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_15 : STD_LOGIC; 
  signal Cpu16_I3_n0147_16_13_SW1_O : STD_LOGIC; 
  signal N30510 : STD_LOGIC; 
  signal CHOICE1408 : STD_LOGIC; 
  signal N31908 : STD_LOGIC; 
  signal N30295 : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_16 : STD_LOGIC; 
  signal CHOICE1302 : STD_LOGIC; 
  signal N30325 : STD_LOGIC; 
  signal N30323 : STD_LOGIC; 
  signal N30601 : STD_LOGIC; 
  signal N30599 : STD_LOGIC; 
  signal N31954 : STD_LOGIC; 
  signal Cpu16_I2_ndre_x1_SW2_SW0_SW0_SW1_O : STD_LOGIC; 
  signal N31197 : STD_LOGIC; 
  signal CHOICE1357 : STD_LOGIC; 
  signal N30317 : STD_LOGIC; 
  signal N30643 : STD_LOGIC; 
  signal N30641 : STD_LOGIC; 
  signal Cpu16_I2_ndre_x1_SW13_O : STD_LOGIC; 
  signal N31801 : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd4 : STD_LOGIC; 
  signal CHOICE800 : STD_LOGIC; 
  signal N30385 : STD_LOGIC; 
  signal N30383 : STD_LOGIC; 
  signal N30673 : STD_LOGIC; 
  signal N30671 : STD_LOGIC; 
  signal N31922 : STD_LOGIC; 
  signal N31217 : STD_LOGIC; 
  signal Cpu16_I2_n0103_SW1_SW0_O : STD_LOGIC; 
  signal CHOICE1445 : STD_LOGIC; 
  signal N30313 : STD_LOGIC; 
  signal N30311 : STD_LOGIC; 
  signal N30631 : STD_LOGIC; 
  signal N30629 : STD_LOGIC; 
  signal N31972 : STD_LOGIC; 
  signal Cpu16_I2_ndre_x1_SW3_SW0_SW0_SW1_O : STD_LOGIC; 
  signal N31203 : STD_LOGIC; 
  signal CHOICE831 : STD_LOGIC; 
  signal N30377 : STD_LOGIC; 
  signal N30649 : STD_LOGIC; 
  signal N30647 : STD_LOGIC; 
  signal CHOICE1500 : STD_LOGIC; 
  signal N30305 : STD_LOGIC; 
  signal N30625 : STD_LOGIC; 
  signal N30623 : STD_LOGIC; 
  signal CHOICE302 : STD_LOGIC; 
  signal CHOICE862 : STD_LOGIC; 
  signal N30373 : STD_LOGIC; 
  signal N30371 : STD_LOGIC; 
  signal N30667 : STD_LOGIC; 
  signal N30665 : STD_LOGIC; 
  signal N31984 : STD_LOGIC; 
  signal CHOICE1637 : STD_LOGIC; 
  signal N30299 : STD_LOGIC; 
  signal N30637 : STD_LOGIC; 
  signal N30635 : STD_LOGIC; 
  signal Cpu16_I2_ndre_x1_SW4_SW0_SW0_SW1_O : STD_LOGIC; 
  signal N31264 : STD_LOGIC; 
  signal CHOICE917 : STD_LOGIC; 
  signal N30365 : STD_LOGIC; 
  signal N30655 : STD_LOGIC; 
  signal N30653 : STD_LOGIC; 
  signal Cpu16_I3_N17152 : STD_LOGIC; 
  signal CHOICE851 : STD_LOGIC; 
  signal CHOICE345 : STD_LOGIC; 
  signal CHOICE321 : STD_LOGIC; 
  signal Cpu16_I2_n0075 : STD_LOGIC; 
  signal Cpu16_I1_n00201_1 : STD_LOGIC; 
  signal Cpu16_I4_n0215 : STD_LOGIC; 
  signal Cpu16_I4_iinc_we_c : STD_LOGIC; 
  signal Cpu16_I2_n0063 : STD_LOGIC; 
  signal CHOICE288 : STD_LOGIC; 
  signal N31584 : STD_LOGIC; 
  signal XLXI_3_dwait_c : STD_LOGIC; 
  signal CHOICE293 : STD_LOGIC; 
  signal N20207 : STD_LOGIC; 
  signal CHOICE270 : STD_LOGIC; 
  signal CHOICE578 : STD_LOGIC; 
  signal CHOICE581 : STD_LOGIC; 
  signal CHOICE307 : STD_LOGIC; 
  signal Cpu16_I2_TD_c_0_2 : STD_LOGIC; 
  signal CHOICE878 : STD_LOGIC; 
  signal CHOICE1043 : STD_LOGIC; 
  signal N31108 : STD_LOGIC; 
  signal N31110 : STD_LOGIC; 
  signal CHOICE350 : STD_LOGIC; 
  signal Cpu16_I2_TD_c_1_2 : STD_LOGIC; 
  signal N30952 : STD_LOGIC; 
  signal N31114 : STD_LOGIC; 
  signal N31116 : STD_LOGIC; 
  signal CHOICE326 : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_2 : STD_LOGIC; 
  signal N30293 : STD_LOGIC; 
  signal CHOICE1402 : STD_LOGIC; 
  signal CHOICE1380 : STD_LOGIC; 
  signal Cpu16_I3_N17242 : STD_LOGIC; 
  signal N31327 : STD_LOGIC; 
  signal N31335 : STD_LOGIC; 
  signal N31315 : STD_LOGIC; 
  signal CHOICE1098 : STD_LOGIC; 
  signal N30718 : STD_LOGIC; 
  signal N31311 : STD_LOGIC; 
  signal N31331 : STD_LOGIC; 
  signal N31608 : STD_LOGIC; 
  signal Cpu16_I3_N17531 : STD_LOGIC; 
  signal Cpu16_I3_n0091 : STD_LOGIC; 
  signal N31838 : STD_LOGIC; 
  signal CHOICE1153 : STD_LOGIC; 
  signal N30714 : STD_LOGIC; 
  signal N31842 : STD_LOGIC; 
  signal CHOICE1263 : STD_LOGIC; 
  signal N30706 : STD_LOGIC; 
  signal N31303 : STD_LOGIC; 
  signal CHOICE1035 : STD_LOGIC; 
  signal CHOICE1255 : STD_LOGIC; 
  signal CHOICE1256 : STD_LOGIC; 
  signal CHOICE1260 : STD_LOGIC; 
  signal Cpu16_I3_n0084 : STD_LOGIC; 
  signal Cpu16_I3_N17033 : STD_LOGIC; 
  signal CHOICE1366 : STD_LOGIC; 
  signal CHOICE1441 : STD_LOGIC; 
  signal CHOICE1298 : STD_LOGIC; 
  signal N31299 : STD_LOGIC; 
  signal CHOICE808 : STD_LOGIC; 
  signal CHOICE1310 : STD_LOGIC; 
  signal CHOICE1311 : STD_LOGIC; 
  signal CHOICE1315 : STD_LOGIC; 
  signal Cpu16_I3_N17006 : STD_LOGIC; 
  signal CHOICE1318 : STD_LOGIC; 
  signal CHOICE1188 : STD_LOGIC; 
  signal CHOICE1090 : STD_LOGIC; 
  signal CHOICE1365 : STD_LOGIC; 
  signal CHOICE1370 : STD_LOGIC; 
  signal CHOICE1373 : STD_LOGIC; 
  signal N31830 : STD_LOGIC; 
  signal CHOICE870 : STD_LOGIC; 
  signal CHOICE1453 : STD_LOGIC; 
  signal CHOICE1454 : STD_LOGIC; 
  signal CHOICE1458 : STD_LOGIC; 
  signal CHOICE1461 : STD_LOGIC; 
  signal CHOICE809 : STD_LOGIC; 
  signal Cpu16_I3_n0081 : STD_LOGIC; 
  signal CHOICE1078 : STD_LOGIC; 
  signal CHOICE1145 : STD_LOGIC; 
  signal CHOICE1508 : STD_LOGIC; 
  signal CHOICE1509 : STD_LOGIC; 
  signal CHOICE1513 : STD_LOGIC; 
  signal CHOICE1516 : STD_LOGIC; 
  signal N31307 : STD_LOGIC; 
  signal N31295 : STD_LOGIC; 
  signal CHOICE1646 : STD_LOGIC; 
  signal CHOICE871 : STD_LOGIC; 
  signal CHOICE1390 : STD_LOGIC; 
  signal CHOICE980 : STD_LOGIC; 
  signal CHOICE1645 : STD_LOGIC; 
  signal CHOICE1650 : STD_LOGIC; 
  signal CHOICE1653 : STD_LOGIC; 
  signal CHOICE816 : STD_LOGIC; 
  signal CHOICE1201 : STD_LOGIC; 
  signal CHOICE1395 : STD_LOGIC; 
  signal N31035 : STD_LOGIC; 
  signal CHOICE1401 : STD_LOGIC; 
  signal CHOICE4 : STD_LOGIC; 
  signal N31323 : STD_LOGIC; 
  signal CHOICE1208 : STD_LOGIC; 
  signal N30710 : STD_LOGIC; 
  signal N31826 : STD_LOGIC; 
  signal N31319 : STD_LOGIC; 
  signal N30702 : STD_LOGIC; 
  signal N20348 : STD_LOGIC; 
  signal N31822 : STD_LOGIC; 
  signal CHOICE847 : STD_LOGIC; 
  signal CHOICE988 : STD_LOGIC; 
  signal N31039 : STD_LOGIC; 
  signal CHOICE17 : STD_LOGIC; 
  signal CHOICE24 : STD_LOGIC; 
  signal N31834 : STD_LOGIC; 
  signal XLXI_5_n0032 : STD_LOGIC; 
  signal CHOICE1588 : STD_LOGIC; 
  signal N30734 : STD_LOGIC; 
  signal Cpu16_I3_n0147_11_39_SW0_O : STD_LOGIC; 
  signal CHOICE1291 : STD_LOGIC; 
  signal Cpu16_I3_n0147_13_39_SW0_O : STD_LOGIC; 
  signal CHOICE1434 : STD_LOGIC; 
  signal N31846 : STD_LOGIC; 
  signal N31858 : STD_LOGIC; 
  signal CHOICE1071 : STD_LOGIC; 
  signal CHOICE789 : STD_LOGIC; 
  signal CHOICE933 : STD_LOGIC; 
  signal N31031 : STD_LOGIC; 
  signal CHOICE1379 : STD_LOGIC; 
  signal CHOICE796 : STD_LOGIC; 
  signal N31850 : STD_LOGIC; 
  signal CHOICE813 : STD_LOGIC; 
  signal CHOICE925 : STD_LOGIC; 
  signal CHOICE839 : STD_LOGIC; 
  signal CHOICE981 : STD_LOGIC; 
  signal CHOICE840 : STD_LOGIC; 
  signal CHOICE844 : STD_LOGIC; 
  signal CHOICE968 : STD_LOGIC; 
  signal CHOICE858 : STD_LOGIC; 
  signal N31862 : STD_LOGIC; 
  signal CHOICE875 : STD_LOGIC; 
  signal CHOICE926 : STD_LOGIC; 
  signal CHOICE930 : STD_LOGIC; 
  signal CHOICE985 : STD_LOGIC; 
  signal N30730 : STD_LOGIC; 
  signal N20679 : STD_LOGIC; 
  signal CHOICE1036 : STD_LOGIC; 
  signal CHOICE1040 : STD_LOGIC; 
  signal CHOICE1146 : STD_LOGIC; 
  signal CHOICE1091 : STD_LOGIC; 
  signal CHOICE1095 : STD_LOGIC; 
  signal CHOICE1150 : STD_LOGIC; 
  signal N31854 : STD_LOGIC; 
  signal CHOICE1200 : STD_LOGIC; 
  signal CHOICE1205 : STD_LOGIC; 
  signal CHOICE37 : STD_LOGIC; 
  signal N20593 : STD_LOGIC; 
  signal Cpu16_I3_n0147_1_39_SW0_O : STD_LOGIC; 
  signal Cpu16_I3_n0147_3_39_SW0_O : STD_LOGIC; 
  signal Cpu16_I3_n0147_5_39_SW0_O : STD_LOGIC; 
  signal CHOICE961 : STD_LOGIC; 
  signal Cpu16_I3_n0147_7_39_SW0_O : STD_LOGIC; 
  signal CHOICE277 : STD_LOGIC; 
  signal Cpu16_I3_n0147_9_39_SW0_O : STD_LOGIC; 
  signal CHOICE1181 : STD_LOGIC; 
  signal N20628 : STD_LOGIC; 
  signal N31043 : STD_LOGIC; 
  signal N31886 : STD_LOGIC; 
  signal N30726 : STD_LOGIC; 
  signal N30956 : STD_LOGIC; 
  signal N31964 : STD_LOGIC; 
  signal N30722 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_0 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_1 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_2 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_3 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_4 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_5 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_6 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_7 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_8 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_9 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_10 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_11 : STD_LOGIC; 
  signal GLOBAL_LOGIC1_12 : STD_LOGIC; 
  signal GLOBAL_LOGIC0_0 : STD_LOGIC; 
  signal GLOBAL_LOGIC0_1 : STD_LOGIC; 
  signal GSR : STD_LOGIC; 
  signal GTS : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_9_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_9_FXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_9_F5MUX : STD_LOGIC; 
  signal N32078 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_9_BXINV : STD_LOGIC; 
  signal N32076 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_9_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_9_CEINV : STD_LOGIC; 
  signal Cpu16_I2_n0142_F5MUX : STD_LOGIC; 
  signal N32038 : STD_LOGIC; 
  signal Cpu16_I2_n0142_BXINV : STD_LOGIC; 
  signal N32036 : STD_LOGIC; 
  signal N31122_F5MUX : STD_LOGIC; 
  signal N32158 : STD_LOGIC; 
  signal N31122_BXINV : STD_LOGIC; 
  signal N32156 : STD_LOGIC; 
  signal MADDR_0_F5MUX : STD_LOGIC; 
  signal N32133 : STD_LOGIC; 
  signal MADDR_0_BXINV : STD_LOGIC; 
  signal N32131 : STD_LOGIC; 
  signal N31168_F5MUX : STD_LOGIC; 
  signal N32083 : STD_LOGIC; 
  signal N31168_BXINV : STD_LOGIC; 
  signal N32081 : STD_LOGIC; 
  signal CHOICE1534_F5MUX : STD_LOGIC; 
  signal N32028 : STD_LOGIC; 
  signal CHOICE1534_BXINV : STD_LOGIC; 
  signal N32026 : STD_LOGIC; 
  signal MADDR_1_F5MUX : STD_LOGIC; 
  signal N32033 : STD_LOGIC; 
  signal MADDR_1_BXINV : STD_LOGIC; 
  signal N32031 : STD_LOGIC; 
  signal MADDR_2_F5MUX : STD_LOGIC; 
  signal N32068 : STD_LOGIC; 
  signal MADDR_2_BXINV : STD_LOGIC; 
  signal N32066 : STD_LOGIC; 
  signal CHOICE737_F5MUX : STD_LOGIC; 
  signal N32043 : STD_LOGIC; 
  signal CHOICE737_BXINV : STD_LOGIC; 
  signal N32041 : STD_LOGIC; 
  signal N31164_F5MUX : STD_LOGIC; 
  signal N32163 : STD_LOGIC; 
  signal N31164_BXINV : STD_LOGIC; 
  signal N32161 : STD_LOGIC; 
  signal Cpu16_I3_N17260_F5MUX : STD_LOGIC; 
  signal N32048 : STD_LOGIC; 
  signal Cpu16_I3_N17260_BXINV : STD_LOGIC; 
  signal N32046 : STD_LOGIC; 
  signal MADDR_3_F5MUX : STD_LOGIC; 
  signal N32103 : STD_LOGIC; 
  signal MADDR_3_BXINV : STD_LOGIC; 
  signal N32101 : STD_LOGIC; 
  signal MADDR_4_F5MUX : STD_LOGIC; 
  signal N32123 : STD_LOGIC; 
  signal MADDR_4_BXINV : STD_LOGIC; 
  signal N32121 : STD_LOGIC; 
  signal MADDR_5_F5MUX : STD_LOGIC; 
  signal N32128 : STD_LOGIC; 
  signal MADDR_5_BXINV : STD_LOGIC; 
  signal N32126 : STD_LOGIC; 
  signal MADDR_6_F5MUX : STD_LOGIC; 
  signal N32148 : STD_LOGIC; 
  signal MADDR_6_BXINV : STD_LOGIC; 
  signal N32146 : STD_LOGIC; 
  signal MADDR_7_F5MUX : STD_LOGIC; 
  signal N32108 : STD_LOGIC; 
  signal MADDR_7_BXINV : STD_LOGIC; 
  signal N32106 : STD_LOGIC; 
  signal MADDR_8_F5MUX : STD_LOGIC; 
  signal N32143 : STD_LOGIC; 
  signal MADDR_8_BXINV : STD_LOGIC; 
  signal N32141 : STD_LOGIC; 
  signal N31988_F : STD_LOGIC; 
  signal N31988_G : STD_LOGIC; 
  signal N31405_F : STD_LOGIC; 
  signal N31405_G : STD_LOGIC; 
  signal N31914_F : STD_LOGIC; 
  signal N31914_G : STD_LOGIC; 
  signal N30970_F : STD_LOGIC; 
  signal N30970_G : STD_LOGIC; 
  signal N30972_F : STD_LOGIC; 
  signal N30972_G : STD_LOGIC; 
  signal N31058_F : STD_LOGIC; 
  signal N31058_G : STD_LOGIC; 
  signal Cpu16_I1_pc_0_DXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_0_FXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_0_F : STD_LOGIC; 
  signal Cpu16_I1_pc_0_G : STD_LOGIC; 
  signal Cpu16_I1_pc_0_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I1_pc_0_CLKINV : STD_LOGIC; 
  signal N31060_F : STD_LOGIC; 
  signal N31060_G : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_Mmux_n0158_Result_1_1_O : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_Mmux_n0158_Result_0_1_O : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_3_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_Mmux_n0158_Result_3_1_O : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_3_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_Mmux_n0158_Result_2_1_O : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_3_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_3_CLKINV : STD_LOGIC; 
  signal N31968_F : STD_LOGIC; 
  signal N31968_G : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_5_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_Mmux_n0158_Result_5_1_O : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_5_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_Mmux_n0158_Result_4_1_O : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_5_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_5_CLKINV : STD_LOGIC; 
  signal Cpu16_I1_pc_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_1_FXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_1_F : STD_LOGIC; 
  signal Cpu16_I1_pc_1_G : STD_LOGIC; 
  signal Cpu16_I1_pc_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I1_pc_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_27_F : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_27_G : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_7_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_Mmux_n0158_Result_7_1_O : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_7_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_Mmux_n0158_Result_6_1_O : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_7_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_7_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_9_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_Mmux_n0158_Result_9_1_O : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_9_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_Mmux_n0158_Result_8_1_O : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_9_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_9_CLKINV : STD_LOGIC; 
  signal N31409_F : STD_LOGIC; 
  signal N31409_G : STD_LOGIC; 
  signal CHOICE497_F : STD_LOGIC; 
  signal CHOICE497_G : STD_LOGIC; 
  signal Cpu16_I1_pc_2_DXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_2_FXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_2_F : STD_LOGIC; 
  signal Cpu16_I1_pc_2_G : STD_LOGIC; 
  signal Cpu16_I1_pc_2_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I1_pc_2_CLKINV : STD_LOGIC; 
  signal Cpu16_I1_pc_3_DXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_3_FXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_3_F : STD_LOGIC; 
  signal Cpu16_I1_pc_3_G : STD_LOGIC; 
  signal Cpu16_I1_pc_3_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I1_pc_3_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd3_F : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd3_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd3_GYMUX : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd3_G : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd3_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd3_CLKINV : STD_LOGIC; 
  signal Cpu16_I1_pc_4_DXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_4_FXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_4_F : STD_LOGIC; 
  signal Cpu16_I1_pc_4_G : STD_LOGIC; 
  signal Cpu16_I1_pc_4_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I1_pc_4_CLKINV : STD_LOGIC; 
  signal CHOICE558_F : STD_LOGIC; 
  signal CHOICE558_G : STD_LOGIC; 
  signal N31938_F : STD_LOGIC; 
  signal N31938_G : STD_LOGIC; 
  signal XLXI_3_a2vi_s_0_F : STD_LOGIC; 
  signal XLXI_3_a2vi_s_0_DYMUX : STD_LOGIC; 
  signal XLXI_3_n0006_O : STD_LOGIC; 
  signal XLXI_3_a2vi_s_0_SRINVNOT : STD_LOGIC; 
  signal XLXI_3_a2vi_s_0_CLKINV : STD_LOGIC; 
  signal Cpu16_I1_pc_5_DXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_5_FXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_5_F : STD_LOGIC; 
  signal Cpu16_I1_pc_5_G : STD_LOGIC; 
  signal Cpu16_I1_pc_5_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I1_pc_5_CLKINV : STD_LOGIC; 
  signal XLXN_14_10_F : STD_LOGIC; 
  signal XLXN_14_10_G : STD_LOGIC; 
  signal CHOICE589_F : STD_LOGIC; 
  signal CHOICE589_G : STD_LOGIC; 
  signal XLXI_4_n0005_9_CYINIT : STD_LOGIC; 
  signal XLXI_4_n0005_9_CY0F : STD_LOGIC; 
  signal XLXI_4_n0005_9_CYSELF : STD_LOGIC; 
  signal XLXI_4_Maddsub_n0001_inst_lut1_0 : STD_LOGIC; 
  signal XLXI_4_n0005_9_BXINVNOT : STD_LOGIC; 
  signal XLXI_4_n0005_9_XORG : STD_LOGIC; 
  signal XLXI_4_n0005_9_CYMUXG : STD_LOGIC; 
  signal XLXI_4_Maddsub_n0001_inst_cy_0 : STD_LOGIC; 
  signal XLXI_4_n0005_9_CY0G : STD_LOGIC; 
  signal XLXI_4_n0005_9_CYSELG : STD_LOGIC; 
  signal XLXI_4_Maddsub_n0001_inst_lut2_0 : STD_LOGIC; 
  signal XLXI_4_n0005_10_XORF : STD_LOGIC; 
  signal XLXI_4_n0005_10_CYINIT : STD_LOGIC; 
  signal XLXI_4_n0005_10_CY0F : STD_LOGIC; 
  signal XLXI_4_Maddsub_n0001_inst_lut2_1 : STD_LOGIC; 
  signal XLXI_4_n0005_10_XORG : STD_LOGIC; 
  signal XLXI_4_Maddsub_n0001_inst_cy_2 : STD_LOGIC; 
  signal XLXI_4_n0005_10_CYSELF : STD_LOGIC; 
  signal XLXI_4_n0005_10_CYMUXFAST : STD_LOGIC; 
  signal XLXI_4_n0005_10_CYAND : STD_LOGIC; 
  signal XLXI_4_n0005_10_FASTCARRY : STD_LOGIC; 
  signal XLXI_4_n0005_10_CYMUXG2 : STD_LOGIC; 
  signal XLXI_4_n0005_10_CYMUXF2 : STD_LOGIC; 
  signal XLXI_4_n0005_10_CY0G : STD_LOGIC; 
  signal XLXI_4_n0005_10_CYSELG : STD_LOGIC; 
  signal XLXI_4_Maddsub_n0001_inst_lut2_2 : STD_LOGIC; 
  signal XLXI_4_n0005_12_XORF : STD_LOGIC; 
  signal XLXI_4_n0005_12_CYINIT : STD_LOGIC; 
  signal XLXI_4_n0005_12_CY0F : STD_LOGIC; 
  signal XLXI_4_Maddsub_n0001_inst_lut2_3 : STD_LOGIC; 
  signal XLXI_4_n0005_12_XORG : STD_LOGIC; 
  signal XLXI_4_Maddsub_n0001_inst_cy_4 : STD_LOGIC; 
  signal XLXI_4_n0005_12_CYSELF : STD_LOGIC; 
  signal XLXI_4_n0005_12_CYMUXFAST : STD_LOGIC; 
  signal XLXI_4_n0005_12_CYAND : STD_LOGIC; 
  signal XLXI_4_n0005_12_FASTCARRY : STD_LOGIC; 
  signal XLXI_4_n0005_12_CYMUXG2 : STD_LOGIC; 
  signal XLXI_4_n0005_12_CYMUXF2 : STD_LOGIC; 
  signal XLXI_4_n0005_12_CY0G : STD_LOGIC; 
  signal XLXI_4_n0005_12_CYSELG : STD_LOGIC; 
  signal XLXI_4_Maddsub_n0001_inst_lut2_4 : STD_LOGIC; 
  signal XLXI_4_n0005_14_XORF : STD_LOGIC; 
  signal XLXI_4_n0005_14_CYINIT : STD_LOGIC; 
  signal XLXI_4_n0005_14_CY0F : STD_LOGIC; 
  signal XLXI_4_n0005_14_CYSELF : STD_LOGIC; 
  signal XLXI_4_Maddsub_n0001_inst_lut2_5 : STD_LOGIC; 
  signal XLXI_4_n0005_14_XORG : STD_LOGIC; 
  signal XLXI_4_Maddsub_n0001_inst_cy_6 : STD_LOGIC; 
  signal XLXI_4_Maddsub_n0001_inst_lut2_61_O : STD_LOGIC; 
  signal Cpu16_I1_n0009_1_LOGIC_ONE : STD_LOGIC; 
  signal Cpu16_I1_n0009_1_CYINIT : STD_LOGIC; 
  signal Cpu16_I1_n0009_1_CYSELF : STD_LOGIC; 
  signal Cpu16_I1_Madd_n0009_inst_lut2_15 : STD_LOGIC; 
  signal Cpu16_I1_n0009_1_BXINVNOT : STD_LOGIC; 
  signal Cpu16_I1_n0009_1_XORG : STD_LOGIC; 
  signal Cpu16_I1_n0009_1_CYMUXG : STD_LOGIC; 
  signal Cpu16_I1_Madd_n0009_inst_cy_16 : STD_LOGIC; 
  signal Cpu16_I1_n0009_1_LOGIC_ZERO : STD_LOGIC; 
  signal Cpu16_I1_n0009_1_CYSELG : STD_LOGIC; 
  signal Cpu16_I1_n0009_1_G : STD_LOGIC; 
  signal Cpu16_I1_n0009_2_XORF : STD_LOGIC; 
  signal Cpu16_I1_n0009_2_CYINIT : STD_LOGIC; 
  signal Cpu16_I1_n0009_2_F : STD_LOGIC; 
  signal Cpu16_I1_n0009_2_XORG : STD_LOGIC; 
  signal Cpu16_I1_Madd_n0009_inst_cy_18 : STD_LOGIC; 
  signal Cpu16_I1_n0009_2_CYSELF : STD_LOGIC; 
  signal Cpu16_I1_n0009_2_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I1_n0009_2_CYAND : STD_LOGIC; 
  signal Cpu16_I1_n0009_2_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I1_n0009_2_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I1_n0009_2_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I1_n0009_2_LOGIC_ZERO : STD_LOGIC; 
  signal Cpu16_I1_n0009_2_CYSELG : STD_LOGIC; 
  signal Cpu16_I1_n0009_2_G : STD_LOGIC; 
  signal Cpu16_I1_n0009_4_XORF : STD_LOGIC; 
  signal Cpu16_I1_n0009_4_CYINIT : STD_LOGIC; 
  signal Cpu16_I1_n0009_4_F : STD_LOGIC; 
  signal Cpu16_I1_n0009_4_XORG : STD_LOGIC; 
  signal Cpu16_I1_Madd_n0009_inst_cy_20 : STD_LOGIC; 
  signal Cpu16_I1_n0009_4_CYSELF : STD_LOGIC; 
  signal Cpu16_I1_n0009_4_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I1_n0009_4_CYAND : STD_LOGIC; 
  signal Cpu16_I1_n0009_4_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I1_n0009_4_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I1_n0009_4_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I1_n0009_4_LOGIC_ZERO : STD_LOGIC; 
  signal Cpu16_I1_n0009_4_CYSELG : STD_LOGIC; 
  signal Cpu16_I1_n0009_4_G : STD_LOGIC; 
  signal Cpu16_I1_n0009_6_XORF : STD_LOGIC; 
  signal Cpu16_I1_n0009_6_CYINIT : STD_LOGIC; 
  signal Cpu16_I1_n0009_6_F : STD_LOGIC; 
  signal Cpu16_I1_n0009_6_XORG : STD_LOGIC; 
  signal Cpu16_I1_Madd_n0009_inst_cy_22 : STD_LOGIC; 
  signal Cpu16_I1_n0009_6_CYSELF : STD_LOGIC; 
  signal Cpu16_I1_n0009_6_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I1_n0009_6_CYAND : STD_LOGIC; 
  signal Cpu16_I1_n0009_6_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I1_n0009_6_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I1_n0009_6_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I1_n0009_6_LOGIC_ZERO : STD_LOGIC; 
  signal Cpu16_I1_n0009_6_CYSELG : STD_LOGIC; 
  signal Cpu16_I1_n0009_6_G : STD_LOGIC; 
  signal Cpu16_I1_n0009_8_XORF : STD_LOGIC; 
  signal Cpu16_I1_n0009_8_CYINIT : STD_LOGIC; 
  signal Cpu16_I1_n0009_8_F : STD_LOGIC; 
  signal Cpu16_I1_n0009_8_XORG : STD_LOGIC; 
  signal Cpu16_I1_Madd_n0009_inst_cy_24 : STD_LOGIC; 
  signal Cpu16_I1_n0009_8_CYSELF : STD_LOGIC; 
  signal Cpu16_I1_n0009_8_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I1_n0009_8_CYAND : STD_LOGIC; 
  signal Cpu16_I1_n0009_8_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I1_n0009_8_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I1_n0009_8_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I1_n0009_8_LOGIC_ZERO : STD_LOGIC; 
  signal Cpu16_I1_n0009_8_CYSELG : STD_LOGIC; 
  signal Cpu16_I1_n0009_8_G : STD_LOGIC; 
  signal Cpu16_I1_n0009_10_XORF : STD_LOGIC; 
  signal Cpu16_I1_n0009_10_LOGIC_ZERO : STD_LOGIC; 
  signal Cpu16_I1_n0009_10_CYINIT : STD_LOGIC; 
  signal Cpu16_I1_n0009_10_CYSELF : STD_LOGIC; 
  signal Cpu16_I1_n0009_10_F : STD_LOGIC; 
  signal Cpu16_I1_n0009_10_XORG : STD_LOGIC; 
  signal Cpu16_I1_Madd_n0009_inst_cy_26 : STD_LOGIC; 
  signal Cpu16_I1_pc_11_rt : STD_LOGIC; 
  signal XLXI_5_n0011_0_XORF : STD_LOGIC; 
  signal XLXI_5_n0011_0_LOGIC_ZERO : STD_LOGIC; 
  signal XLXI_5_n0011_0_CYINIT : STD_LOGIC; 
  signal XLXI_5_n0011_0_CYSELF : STD_LOGIC; 
  signal XLXI_5_n0011_0_F : STD_LOGIC; 
  signal XLXI_5_n0011_0_XORG : STD_LOGIC; 
  signal XLXI_5_n0011_0_CYMUXG : STD_LOGIC; 
  signal XLXI_5_Msub_n0011_inst_cy_8 : STD_LOGIC; 
  signal XLXI_5_n0011_0_CY0G : STD_LOGIC; 
  signal XLXI_5_n0011_0_CYSELG : STD_LOGIC; 
  signal XLXI_5_Msub_n0011_inst_lut2_8 : STD_LOGIC; 
  signal XLXI_5_n0011_2_XORF : STD_LOGIC; 
  signal XLXI_5_n0011_2_CYINIT : STD_LOGIC; 
  signal XLXI_5_n0011_2_CY0F : STD_LOGIC; 
  signal XLXI_5_Msub_n0011_inst_lut2_9 : STD_LOGIC; 
  signal XLXI_5_n0011_2_XORG : STD_LOGIC; 
  signal XLXI_5_Msub_n0011_inst_cy_10 : STD_LOGIC; 
  signal XLXI_5_n0011_2_CYSELF : STD_LOGIC; 
  signal XLXI_5_n0011_2_CYMUXFAST : STD_LOGIC; 
  signal XLXI_5_n0011_2_CYAND : STD_LOGIC; 
  signal XLXI_5_n0011_2_FASTCARRY : STD_LOGIC; 
  signal XLXI_5_n0011_2_CYMUXG2 : STD_LOGIC; 
  signal XLXI_5_n0011_2_CYMUXF2 : STD_LOGIC; 
  signal XLXI_5_n0011_2_CY0G : STD_LOGIC; 
  signal XLXI_5_n0011_2_CYSELG : STD_LOGIC; 
  signal XLXI_5_Msub_n0011_inst_lut2_10 : STD_LOGIC; 
  signal XLXI_5_n0011_4_XORF : STD_LOGIC; 
  signal XLXI_5_n0011_4_CYINIT : STD_LOGIC; 
  signal XLXI_5_n0011_4_CY0F : STD_LOGIC; 
  signal XLXI_5_Msub_n0011_inst_lut2_11 : STD_LOGIC; 
  signal XLXI_5_n0011_4_XORG : STD_LOGIC; 
  signal XLXI_5_Msub_n0011_inst_cy_12 : STD_LOGIC; 
  signal XLXI_5_n0011_4_CYSELF : STD_LOGIC; 
  signal XLXI_5_n0011_4_CYMUXFAST : STD_LOGIC; 
  signal XLXI_5_n0011_4_CYAND : STD_LOGIC; 
  signal XLXI_5_n0011_4_FASTCARRY : STD_LOGIC; 
  signal XLXI_5_n0011_4_CYMUXG2 : STD_LOGIC; 
  signal XLXI_5_n0011_4_CYMUXF2 : STD_LOGIC; 
  signal XLXI_5_n0011_4_CY0G : STD_LOGIC; 
  signal XLXI_5_n0011_4_CYSELG : STD_LOGIC; 
  signal XLXI_5_Msub_n0011_inst_lut2_12 : STD_LOGIC; 
  signal XLXI_5_n0011_6_XORF : STD_LOGIC; 
  signal XLXI_5_n0011_6_CYINIT : STD_LOGIC; 
  signal XLXI_5_n0011_6_CY0F : STD_LOGIC; 
  signal XLXI_5_n0011_6_CYSELF : STD_LOGIC; 
  signal XLXI_5_Msub_n0011_inst_lut2_13 : STD_LOGIC; 
  signal XLXI_5_n0011_6_XORG : STD_LOGIC; 
  signal XLXI_5_Msub_n0011_inst_cy_14 : STD_LOGIC; 
  signal XLXI_5_Msub_n0011_inst_lut2_14_rt : STD_LOGIC; 
  signal Cpu16_I3_n0098_1_CYINIT : STD_LOGIC; 
  signal Cpu16_I3_n0098_1_CY0F : STD_LOGIC; 
  signal Cpu16_I3_n0098_1_CYSELF : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_lut2_44_rt : STD_LOGIC; 
  signal Cpu16_I3_n0098_1_BXINVNOT : STD_LOGIC; 
  signal Cpu16_I3_n0098_1_XORG : STD_LOGIC; 
  signal Cpu16_I3_n0098_1_CYMUXG : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_cy_45 : STD_LOGIC; 
  signal Cpu16_I3_n0098_1_CY0G : STD_LOGIC; 
  signal Cpu16_I3_n0098_1_CYSELG : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_lut2_451_O : STD_LOGIC; 
  signal Cpu16_I3_n0098_2_XORF : STD_LOGIC; 
  signal Cpu16_I3_n0098_2_CYINIT : STD_LOGIC; 
  signal Cpu16_I3_n0098_2_CY0F : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_lut2_461_O : STD_LOGIC; 
  signal Cpu16_I3_n0098_2_XORG : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_cy_47 : STD_LOGIC; 
  signal Cpu16_I3_n0098_2_CYSELF : STD_LOGIC; 
  signal Cpu16_I3_n0098_2_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I3_n0098_2_CYAND : STD_LOGIC; 
  signal Cpu16_I3_n0098_2_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I3_n0098_2_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I3_n0098_2_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I3_n0098_2_CY0G : STD_LOGIC; 
  signal Cpu16_I3_n0098_2_CYSELG : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_lut2_471_O : STD_LOGIC; 
  signal Cpu16_I3_n0098_4_XORF : STD_LOGIC; 
  signal Cpu16_I3_n0098_4_CYINIT : STD_LOGIC; 
  signal Cpu16_I3_n0098_4_CY0F : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_lut2_481_O : STD_LOGIC; 
  signal Cpu16_I3_n0098_4_XORG : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_cy_49 : STD_LOGIC; 
  signal Cpu16_I3_n0098_4_CYSELF : STD_LOGIC; 
  signal Cpu16_I3_n0098_4_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I3_n0098_4_CYAND : STD_LOGIC; 
  signal Cpu16_I3_n0098_4_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I3_n0098_4_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I3_n0098_4_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I3_n0098_4_CY0G : STD_LOGIC; 
  signal Cpu16_I3_n0098_4_CYSELG : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_lut2_491_O : STD_LOGIC; 
  signal Cpu16_I3_n0098_6_XORF : STD_LOGIC; 
  signal Cpu16_I3_n0098_6_CYINIT : STD_LOGIC; 
  signal Cpu16_I3_n0098_6_CY0F : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_lut2_501_O : STD_LOGIC; 
  signal Cpu16_I3_n0098_6_XORG : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_cy_51 : STD_LOGIC; 
  signal Cpu16_I3_n0098_6_CYSELF : STD_LOGIC; 
  signal Cpu16_I3_n0098_6_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I3_n0098_6_CYAND : STD_LOGIC; 
  signal Cpu16_I3_n0098_6_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I3_n0098_6_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I3_n0098_6_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I3_n0098_6_CY0G : STD_LOGIC; 
  signal Cpu16_I3_n0098_6_CYSELG : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_lut2_511_O : STD_LOGIC; 
  signal Cpu16_I3_n0098_8_XORF : STD_LOGIC; 
  signal Cpu16_I3_n0098_8_CYINIT : STD_LOGIC; 
  signal Cpu16_I3_n0098_8_CY0F : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_lut2_521_O : STD_LOGIC; 
  signal Cpu16_I3_n0098_8_XORG : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_cy_53 : STD_LOGIC; 
  signal Cpu16_I3_n0098_8_CYSELF : STD_LOGIC; 
  signal Cpu16_I3_n0098_8_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I3_n0098_8_CYAND : STD_LOGIC; 
  signal Cpu16_I3_n0098_8_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I3_n0098_8_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I3_n0098_8_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I3_n0098_8_CY0G : STD_LOGIC; 
  signal Cpu16_I3_n0098_8_CYSELG : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_lut2_531_O : STD_LOGIC; 
  signal Cpu16_I3_n0098_10_XORF : STD_LOGIC; 
  signal Cpu16_I3_n0098_10_CYINIT : STD_LOGIC; 
  signal Cpu16_I3_n0098_10_CY0F : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_lut2_541_O : STD_LOGIC; 
  signal Cpu16_I3_n0098_10_XORG : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_cy_55 : STD_LOGIC; 
  signal Cpu16_I3_n0098_10_CYSELF : STD_LOGIC; 
  signal Cpu16_I3_n0098_10_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I3_n0098_10_CYAND : STD_LOGIC; 
  signal Cpu16_I3_n0098_10_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I3_n0098_10_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I3_n0098_10_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I3_n0098_10_CY0G : STD_LOGIC; 
  signal Cpu16_I3_n0098_10_CYSELG : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_lut2_551_O : STD_LOGIC; 
  signal Cpu16_I3_n0098_12_XORF : STD_LOGIC; 
  signal Cpu16_I3_n0098_12_CYINIT : STD_LOGIC; 
  signal Cpu16_I3_n0098_12_CY0F : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_lut2_56 : STD_LOGIC; 
  signal Cpu16_I3_n0098_12_XORG : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_cy_57 : STD_LOGIC; 
  signal Cpu16_I3_n0098_12_CYSELF : STD_LOGIC; 
  signal Cpu16_I3_n0098_12_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I3_n0098_12_CYAND : STD_LOGIC; 
  signal Cpu16_I3_n0098_12_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I3_n0098_12_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I3_n0098_12_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I3_n0098_12_CY0G : STD_LOGIC; 
  signal Cpu16_I3_n0098_12_CYSELG : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_lut2_57 : STD_LOGIC; 
  signal Cpu16_I3_n0098_14_XORF : STD_LOGIC; 
  signal Cpu16_I3_n0098_14_CYINIT : STD_LOGIC; 
  signal Cpu16_I3_n0098_14_CY0F : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_lut2_58 : STD_LOGIC; 
  signal Cpu16_I3_n0098_14_XORG : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_cy_59 : STD_LOGIC; 
  signal Cpu16_I3_n0098_14_CYSELF : STD_LOGIC; 
  signal Cpu16_I3_n0098_14_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I3_n0098_14_CYAND : STD_LOGIC; 
  signal Cpu16_I3_n0098_14_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I3_n0098_14_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I3_n0098_14_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I3_n0098_14_CY0G : STD_LOGIC; 
  signal Cpu16_I3_n0098_14_CYSELG : STD_LOGIC; 
  signal Cpu16_I3_Madd_n0098_inst_lut2_591_O : STD_LOGIC; 
  signal Cpu16_I3_n0090_0_XORF : STD_LOGIC; 
  signal Cpu16_I3_n0090_0_CYINIT : STD_LOGIC; 
  signal Cpu16_I3_n0090_0_CY0F : STD_LOGIC; 
  signal Cpu16_I3_n0090_0_CYSELF : STD_LOGIC; 
  signal Cpu16_I3_n0090_0_F : STD_LOGIC; 
  signal Cpu16_I3_n0090_0_XORG : STD_LOGIC; 
  signal Cpu16_I3_n0090_0_CYMUXG : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_cy_28 : STD_LOGIC; 
  signal Cpu16_I3_n0090_0_CY0G : STD_LOGIC; 
  signal Cpu16_I3_n0090_0_CYSELG : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_281_O : STD_LOGIC; 
  signal Cpu16_I3_n0090_2_XORF : STD_LOGIC; 
  signal Cpu16_I3_n0090_2_CYINIT : STD_LOGIC; 
  signal Cpu16_I3_n0090_2_CY0F : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_291_O : STD_LOGIC; 
  signal Cpu16_I3_n0090_2_XORG : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_cy_30 : STD_LOGIC; 
  signal Cpu16_I3_n0090_2_CYSELF : STD_LOGIC; 
  signal Cpu16_I3_n0090_2_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I3_n0090_2_CYAND : STD_LOGIC; 
  signal Cpu16_I3_n0090_2_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I3_n0090_2_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I3_n0090_2_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I3_n0090_2_CY0G : STD_LOGIC; 
  signal Cpu16_I3_n0090_2_CYSELG : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_301_O : STD_LOGIC; 
  signal Cpu16_I3_n0090_4_XORF : STD_LOGIC; 
  signal Cpu16_I3_n0090_4_CYINIT : STD_LOGIC; 
  signal Cpu16_I3_n0090_4_CY0F : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_311_O : STD_LOGIC; 
  signal Cpu16_I3_n0090_4_XORG : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_cy_32 : STD_LOGIC; 
  signal Cpu16_I3_n0090_4_CYSELF : STD_LOGIC; 
  signal Cpu16_I3_n0090_4_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I3_n0090_4_CYAND : STD_LOGIC; 
  signal Cpu16_I3_n0090_4_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I3_n0090_4_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I3_n0090_4_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I3_n0090_4_CY0G : STD_LOGIC; 
  signal Cpu16_I3_n0090_4_CYSELG : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_321_O : STD_LOGIC; 
  signal Cpu16_I3_n0090_6_XORF : STD_LOGIC; 
  signal Cpu16_I3_n0090_6_CYINIT : STD_LOGIC; 
  signal Cpu16_I3_n0090_6_CY0F : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_331_O : STD_LOGIC; 
  signal Cpu16_I3_n0090_6_XORG : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_cy_34 : STD_LOGIC; 
  signal Cpu16_I3_n0090_6_CYSELF : STD_LOGIC; 
  signal Cpu16_I3_n0090_6_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I3_n0090_6_CYAND : STD_LOGIC; 
  signal Cpu16_I3_n0090_6_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I3_n0090_6_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I3_n0090_6_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I3_n0090_6_CY0G : STD_LOGIC; 
  signal Cpu16_I3_n0090_6_CYSELG : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_341_O : STD_LOGIC; 
  signal Cpu16_I3_n0090_8_XORF : STD_LOGIC; 
  signal Cpu16_I3_n0090_8_CYINIT : STD_LOGIC; 
  signal Cpu16_I3_n0090_8_CY0F : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_351_O : STD_LOGIC; 
  signal Cpu16_I3_n0090_8_XORG : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_cy_36 : STD_LOGIC; 
  signal Cpu16_I3_n0090_8_CYSELF : STD_LOGIC; 
  signal Cpu16_I3_n0090_8_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I3_n0090_8_CYAND : STD_LOGIC; 
  signal Cpu16_I3_n0090_8_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I3_n0090_8_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I3_n0090_8_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I3_n0090_8_CY0G : STD_LOGIC; 
  signal Cpu16_I3_n0090_8_CYSELG : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_361_O : STD_LOGIC; 
  signal Cpu16_I3_n0090_10_XORF : STD_LOGIC; 
  signal Cpu16_I3_n0090_10_CYINIT : STD_LOGIC; 
  signal Cpu16_I3_n0090_10_CY0F : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_371_O : STD_LOGIC; 
  signal Cpu16_I3_n0090_10_XORG : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_cy_38 : STD_LOGIC; 
  signal Cpu16_I3_n0090_10_CYSELF : STD_LOGIC; 
  signal Cpu16_I3_n0090_10_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I3_n0090_10_CYAND : STD_LOGIC; 
  signal Cpu16_I3_n0090_10_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I3_n0090_10_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I3_n0090_10_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I3_n0090_10_CY0G : STD_LOGIC; 
  signal Cpu16_I3_n0090_10_CYSELG : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_381_O : STD_LOGIC; 
  signal Cpu16_I3_n0090_12_XORF : STD_LOGIC; 
  signal Cpu16_I3_n0090_12_CYINIT : STD_LOGIC; 
  signal Cpu16_I3_n0090_12_CY0F : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_39 : STD_LOGIC; 
  signal Cpu16_I3_n0090_12_XORG : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_cy_40 : STD_LOGIC; 
  signal Cpu16_I3_n0090_12_CYSELF : STD_LOGIC; 
  signal Cpu16_I3_n0090_12_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I3_n0090_12_CYAND : STD_LOGIC; 
  signal Cpu16_I3_n0090_12_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I3_n0090_12_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I3_n0090_12_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I3_n0090_12_CY0G : STD_LOGIC; 
  signal Cpu16_I3_n0090_12_CYSELG : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_40 : STD_LOGIC; 
  signal Cpu16_I3_n0090_14_XORF : STD_LOGIC; 
  signal Cpu16_I3_n0090_14_CYINIT : STD_LOGIC; 
  signal Cpu16_I3_n0090_14_CY0F : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_41 : STD_LOGIC; 
  signal Cpu16_I3_n0090_14_XORG : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_cy_42 : STD_LOGIC; 
  signal Cpu16_I3_n0090_14_CYSELF : STD_LOGIC; 
  signal Cpu16_I3_n0090_14_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I3_n0090_14_CYAND : STD_LOGIC; 
  signal Cpu16_I3_n0090_14_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I3_n0090_14_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I3_n0090_14_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I3_n0090_14_CY0G : STD_LOGIC; 
  signal Cpu16_I3_n0090_14_CYSELG : STD_LOGIC; 
  signal Cpu16_I3_Msub_n0090_inst_lut2_421_O : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_60_CYINIT : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_60_CY0F : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_60_CYSELF : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_60_F : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_60_BXINVNOT : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_60_XORG : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_60_CYMUXG : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_cy_61 : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_60_CY0G : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_60_CYSELG : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_61 : STD_LOGIC; 
  signal Cpu16_I4_n0182_2_XORF : STD_LOGIC; 
  signal Cpu16_I4_n0182_2_CYINIT : STD_LOGIC; 
  signal Cpu16_I4_n0182_2_CY0F : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_62 : STD_LOGIC; 
  signal Cpu16_I4_n0182_2_XORG : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_cy_63 : STD_LOGIC; 
  signal Cpu16_I4_n0182_2_CYSELF : STD_LOGIC; 
  signal Cpu16_I4_n0182_2_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I4_n0182_2_CYAND : STD_LOGIC; 
  signal Cpu16_I4_n0182_2_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I4_n0182_2_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I4_n0182_2_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I4_n0182_2_CY0G : STD_LOGIC; 
  signal Cpu16_I4_n0182_2_CYSELG : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_63 : STD_LOGIC; 
  signal Cpu16_I4_n0182_4_XORF : STD_LOGIC; 
  signal Cpu16_I4_n0182_4_CYINIT : STD_LOGIC; 
  signal Cpu16_I4_n0182_4_CY0F : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_64 : STD_LOGIC; 
  signal Cpu16_I4_n0182_4_XORG : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_cy_65 : STD_LOGIC; 
  signal Cpu16_I4_n0182_4_CYSELF : STD_LOGIC; 
  signal Cpu16_I4_n0182_4_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I4_n0182_4_CYAND : STD_LOGIC; 
  signal Cpu16_I4_n0182_4_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I4_n0182_4_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I4_n0182_4_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I4_n0182_4_CY0G : STD_LOGIC; 
  signal Cpu16_I4_n0182_4_CYSELG : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_65 : STD_LOGIC; 
  signal Cpu16_I4_n0182_6_XORF : STD_LOGIC; 
  signal Cpu16_I4_n0182_6_CYINIT : STD_LOGIC; 
  signal Cpu16_I4_n0182_6_CY0F : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_66 : STD_LOGIC; 
  signal Cpu16_I4_n0182_6_XORG : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_cy_67 : STD_LOGIC; 
  signal Cpu16_I4_n0182_6_CYSELF : STD_LOGIC; 
  signal Cpu16_I4_n0182_6_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I4_n0182_6_CYAND : STD_LOGIC; 
  signal Cpu16_I4_n0182_6_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I4_n0182_6_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I4_n0182_6_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I4_n0182_6_CY0G : STD_LOGIC; 
  signal Cpu16_I4_n0182_6_CYSELG : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_67 : STD_LOGIC; 
  signal Cpu16_I4_n0182_8_XORF : STD_LOGIC; 
  signal Cpu16_I4_n0182_8_CYINIT : STD_LOGIC; 
  signal Cpu16_I4_n0182_8_CY0F : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_68 : STD_LOGIC; 
  signal Cpu16_I4_n0182_8_XORG : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_cy_69 : STD_LOGIC; 
  signal Cpu16_I4_n0182_8_CYSELF : STD_LOGIC; 
  signal Cpu16_I4_n0182_8_CYMUXFAST : STD_LOGIC; 
  signal Cpu16_I4_n0182_8_CYAND : STD_LOGIC; 
  signal Cpu16_I4_n0182_8_FASTCARRY : STD_LOGIC; 
  signal Cpu16_I4_n0182_8_CYMUXG2 : STD_LOGIC; 
  signal Cpu16_I4_n0182_8_CYMUXF2 : STD_LOGIC; 
  signal Cpu16_I4_n0182_8_CY0G : STD_LOGIC; 
  signal Cpu16_I4_n0182_8_CYSELG : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_69 : STD_LOGIC; 
  signal Cpu16_I4_n0182_10_XORF : STD_LOGIC; 
  signal Cpu16_I4_n0182_10_CYINIT : STD_LOGIC; 
  signal Cpu16_I4_n0182_10_CY0F : STD_LOGIC; 
  signal Cpu16_I4_n0182_10_CYSELF : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_70 : STD_LOGIC; 
  signal Cpu16_I4_n0182_10_XORG : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_cy_71 : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_71_rt : STD_LOGIC; 
  signal NWE_EXT_ENABLE : STD_LOGIC; 
  signal NWE_EXT_GTS_OR_T : STD_LOGIC; 
  signal NWE_EXT_O : STD_LOGIC; 
  signal NWE_EXT_SRINVNOT : STD_LOGIC; 
  signal DATA_OUT_EXT_0_ENABLE : STD_LOGIC; 
  signal DATA_OUT_EXT_0_GTS_OR_T : STD_LOGIC; 
  signal DATA_OUT_EXT_0_O : STD_LOGIC; 
  signal DATA_OUT_EXT_1_ENABLE : STD_LOGIC; 
  signal DATA_OUT_EXT_1_GTS_OR_T : STD_LOGIC; 
  signal DATA_OUT_EXT_1_O : STD_LOGIC; 
  signal DATA_OUT_EXT_2_ENABLE : STD_LOGIC; 
  signal DATA_OUT_EXT_2_GTS_OR_T : STD_LOGIC; 
  signal DATA_OUT_EXT_2_O : STD_LOGIC; 
  signal DATA_OUT_EXT_3_ENABLE : STD_LOGIC; 
  signal DATA_OUT_EXT_3_GTS_OR_T : STD_LOGIC; 
  signal DATA_OUT_EXT_3_O : STD_LOGIC; 
  signal DATA_OUT_EXT_4_ENABLE : STD_LOGIC; 
  signal DATA_OUT_EXT_4_GTS_OR_T : STD_LOGIC; 
  signal DATA_OUT_EXT_4_O : STD_LOGIC; 
  signal DATA_OUT_EXT_5_ENABLE : STD_LOGIC; 
  signal DATA_OUT_EXT_5_GTS_OR_T : STD_LOGIC; 
  signal DATA_OUT_EXT_5_O : STD_LOGIC; 
  signal DATA_OUT_EXT_6_ENABLE : STD_LOGIC; 
  signal DATA_OUT_EXT_6_GTS_OR_T : STD_LOGIC; 
  signal DATA_OUT_EXT_6_O : STD_LOGIC; 
  signal DATA_OUT_EXT_7_ENABLE : STD_LOGIC; 
  signal DATA_OUT_EXT_7_GTS_OR_T : STD_LOGIC; 
  signal DATA_OUT_EXT_7_O : STD_LOGIC; 
  signal DATA_OUT_EXT_8_ENABLE : STD_LOGIC; 
  signal DATA_OUT_EXT_8_GTS_OR_T : STD_LOGIC; 
  signal DATA_OUT_EXT_8_O : STD_LOGIC; 
  signal DATA_OUT_EXT_9_ENABLE : STD_LOGIC; 
  signal DATA_OUT_EXT_9_GTS_OR_T : STD_LOGIC; 
  signal DATA_OUT_EXT_9_O : STD_LOGIC; 
  signal CPU_INT_INBUF : STD_LOGIC; 
  signal ADDR_OUT_EXT_0_ENABLE : STD_LOGIC; 
  signal ADDR_OUT_EXT_0_GTS_OR_T : STD_LOGIC; 
  signal ADDR_OUT_EXT_0_O : STD_LOGIC; 
  signal ADDR_OUT_EXT_1_ENABLE : STD_LOGIC; 
  signal ADDR_OUT_EXT_1_GTS_OR_T : STD_LOGIC; 
  signal ADDR_OUT_EXT_1_O : STD_LOGIC; 
  signal ADDR_OUT_EXT_2_ENABLE : STD_LOGIC; 
  signal ADDR_OUT_EXT_2_GTS_OR_T : STD_LOGIC; 
  signal ADDR_OUT_EXT_2_O : STD_LOGIC; 
  signal ADDR_OUT_EXT_3_ENABLE : STD_LOGIC; 
  signal ADDR_OUT_EXT_3_GTS_OR_T : STD_LOGIC; 
  signal ADDR_OUT_EXT_3_O : STD_LOGIC; 
  signal ADDR_OUT_EXT_4_ENABLE : STD_LOGIC; 
  signal ADDR_OUT_EXT_4_GTS_OR_T : STD_LOGIC; 
  signal ADDR_OUT_EXT_4_O : STD_LOGIC; 
  signal ADDR_OUT_EXT_5_ENABLE : STD_LOGIC; 
  signal ADDR_OUT_EXT_5_GTS_OR_T : STD_LOGIC; 
  signal ADDR_OUT_EXT_5_O : STD_LOGIC; 
  signal ADDR_OUT_EXT_6_ENABLE : STD_LOGIC; 
  signal ADDR_OUT_EXT_6_GTS_OR_T : STD_LOGIC; 
  signal ADDR_OUT_EXT_6_O : STD_LOGIC; 
  signal ADDR_OUT_EXT_7_ENABLE : STD_LOGIC; 
  signal ADDR_OUT_EXT_7_GTS_OR_T : STD_LOGIC; 
  signal ADDR_OUT_EXT_7_O : STD_LOGIC; 
  signal ADDR_OUT_EXT_8_ENABLE : STD_LOGIC; 
  signal ADDR_OUT_EXT_8_GTS_OR_T : STD_LOGIC; 
  signal ADDR_OUT_EXT_8_O : STD_LOGIC; 
  signal ADDR_OUT_EXT_9_ENABLE : STD_LOGIC; 
  signal ADDR_OUT_EXT_9_GTS_OR_T : STD_LOGIC; 
  signal ADDR_OUT_EXT_9_O : STD_LOGIC; 
  signal DATA_IN_EXT_10_INBUF : STD_LOGIC; 
  signal DATA_IN_EXT_11_INBUF : STD_LOGIC; 
  signal DATA_IN_EXT_12_INBUF : STD_LOGIC; 
  signal DATA_IN_EXT_13_INBUF : STD_LOGIC; 
  signal DATA_IN_EXT_14_INBUF : STD_LOGIC; 
  signal DATA_IN_EXT_15_INBUF : STD_LOGIC; 
  signal DATA_OUT_EXT_10_ENABLE : STD_LOGIC; 
  signal DATA_OUT_EXT_10_GTS_OR_T : STD_LOGIC; 
  signal DATA_OUT_EXT_10_O : STD_LOGIC; 
  signal DATA_OUT_EXT_11_ENABLE : STD_LOGIC; 
  signal DATA_OUT_EXT_11_GTS_OR_T : STD_LOGIC; 
  signal DATA_OUT_EXT_11_O : STD_LOGIC; 
  signal DATA_OUT_EXT_12_ENABLE : STD_LOGIC; 
  signal DATA_OUT_EXT_12_GTS_OR_T : STD_LOGIC; 
  signal DATA_OUT_EXT_12_O : STD_LOGIC; 
  signal DATA_OUT_EXT_13_ENABLE : STD_LOGIC; 
  signal DATA_OUT_EXT_13_GTS_OR_T : STD_LOGIC; 
  signal DATA_OUT_EXT_13_O : STD_LOGIC; 
  signal DATA_OUT_EXT_14_ENABLE : STD_LOGIC; 
  signal DATA_OUT_EXT_14_GTS_OR_T : STD_LOGIC; 
  signal DATA_OUT_EXT_14_O : STD_LOGIC; 
  signal DATA_OUT_EXT_15_ENABLE : STD_LOGIC; 
  signal DATA_OUT_EXT_15_GTS_OR_T : STD_LOGIC; 
  signal DATA_OUT_EXT_15_O : STD_LOGIC; 
  signal CLK_IN_INBUF : STD_LOGIC; 
  signal NRESET_IN_INBUF : STD_LOGIC; 
  signal NCS_EXT_ENABLE : STD_LOGIC; 
  signal NCS_EXT_GTS_OR_T : STD_LOGIC; 
  signal NCS_EXT_O : STD_LOGIC; 
  signal NCS_EXT_SRINVNOT : STD_LOGIC; 
  signal DATA_IN_EXT_0_INBUF : STD_LOGIC; 
  signal DATA_IN_EXT_1_INBUF : STD_LOGIC; 
  signal DATA_IN_EXT_2_INBUF : STD_LOGIC; 
  signal DATA_IN_EXT_3_INBUF : STD_LOGIC; 
  signal DATA_IN_EXT_4_INBUF : STD_LOGIC; 
  signal DATA_IN_EXT_5_INBUF : STD_LOGIC; 
  signal DATA_IN_EXT_6_INBUF : STD_LOGIC; 
  signal DATA_IN_EXT_7_INBUF : STD_LOGIC; 
  signal DATA_IN_EXT_8_INBUF : STD_LOGIC; 
  signal DATA_IN_EXT_9_INBUF : STD_LOGIC; 
  signal NRE_EXT_ENABLE : STD_LOGIC; 
  signal NRE_EXT_GTS_OR_T : STD_LOGIC; 
  signal NRE_EXT_O : STD_LOGIC; 
  signal NRESET_IN_BUFGP_BUFG_S_INVNOT : STD_LOGIC; 
  signal CLK_IN_BUFGP_BUFG_S_INVNOT : STD_LOGIC; 
  signal XLXI_6_B5_DOPB3 : STD_LOGIC; 
  signal XLXI_6_B5_DOPB2 : STD_LOGIC; 
  signal XLXI_6_B5_DOPB1 : STD_LOGIC; 
  signal XLXI_6_B5_DOPB0 : STD_LOGIC; 
  signal XLXI_6_B5_DOB31 : STD_LOGIC; 
  signal XLXI_6_B5_DOB30 : STD_LOGIC; 
  signal XLXI_6_B5_DOB29 : STD_LOGIC; 
  signal XLXI_6_B5_DOB28 : STD_LOGIC; 
  signal XLXI_6_B5_DOB27 : STD_LOGIC; 
  signal XLXI_6_B5_DOB26 : STD_LOGIC; 
  signal XLXI_6_B5_DOB25 : STD_LOGIC; 
  signal XLXI_6_B5_DOB24 : STD_LOGIC; 
  signal XLXI_6_B5_DOB23 : STD_LOGIC; 
  signal XLXI_6_B5_DOB22 : STD_LOGIC; 
  signal XLXI_6_B5_DOB21 : STD_LOGIC; 
  signal XLXI_6_B5_DOB20 : STD_LOGIC; 
  signal XLXI_6_B5_DOB19 : STD_LOGIC; 
  signal XLXI_6_B5_DOB18 : STD_LOGIC; 
  signal XLXI_6_B5_DOB17 : STD_LOGIC; 
  signal XLXI_6_B5_DOB16 : STD_LOGIC; 
  signal XLXI_6_B5_DOB15 : STD_LOGIC; 
  signal XLXI_6_B5_DOB14 : STD_LOGIC; 
  signal XLXI_6_B5_DOB13 : STD_LOGIC; 
  signal XLXI_6_B5_DOB12 : STD_LOGIC; 
  signal XLXI_6_B5_DOB11 : STD_LOGIC; 
  signal XLXI_6_B5_DOB10 : STD_LOGIC; 
  signal XLXI_6_B5_DOB9 : STD_LOGIC; 
  signal XLXI_6_B5_DOB8 : STD_LOGIC; 
  signal XLXI_6_B5_DOB7 : STD_LOGIC; 
  signal XLXI_6_B5_DOB6 : STD_LOGIC; 
  signal XLXI_6_B5_DOB5 : STD_LOGIC; 
  signal XLXI_6_B5_DOB4 : STD_LOGIC; 
  signal XLXI_6_B5_DOB3 : STD_LOGIC; 
  signal XLXI_6_B5_DOB2 : STD_LOGIC; 
  signal XLXI_6_B5_DOB1 : STD_LOGIC; 
  signal XLXI_6_B5_DOB0 : STD_LOGIC; 
  signal XLXI_6_B5_DOPA3 : STD_LOGIC; 
  signal XLXI_6_B5_DOPA2 : STD_LOGIC; 
  signal XLXI_6_B5_DOPA1 : STD_LOGIC; 
  signal XLXI_6_B5_DOPA0 : STD_LOGIC; 
  signal XLXI_6_B5_DOA31 : STD_LOGIC; 
  signal XLXI_6_B5_DOA30 : STD_LOGIC; 
  signal XLXI_6_B5_DOA29 : STD_LOGIC; 
  signal XLXI_6_B5_DOA28 : STD_LOGIC; 
  signal XLXI_6_B5_DOA27 : STD_LOGIC; 
  signal XLXI_6_B5_DOA26 : STD_LOGIC; 
  signal XLXI_6_B5_DOA25 : STD_LOGIC; 
  signal XLXI_6_B5_DOA24 : STD_LOGIC; 
  signal XLXI_6_B5_DOA23 : STD_LOGIC; 
  signal XLXI_6_B5_DOA22 : STD_LOGIC; 
  signal XLXI_6_B5_DOA21 : STD_LOGIC; 
  signal XLXI_6_B5_DOA20 : STD_LOGIC; 
  signal XLXI_6_B5_DOA19 : STD_LOGIC; 
  signal XLXI_6_B5_DOA18 : STD_LOGIC; 
  signal XLXI_6_B5_DOA17 : STD_LOGIC; 
  signal XLXI_6_B5_DOA16 : STD_LOGIC; 
  signal XLXI_6_B5_DIPB3 : STD_LOGIC; 
  signal XLXI_6_B5_DIPB2 : STD_LOGIC; 
  signal XLXI_6_B5_DIPB1 : STD_LOGIC; 
  signal XLXI_6_B5_DIPB0 : STD_LOGIC; 
  signal XLXI_6_B5_DIB31 : STD_LOGIC; 
  signal XLXI_6_B5_DIB30 : STD_LOGIC; 
  signal XLXI_6_B5_DIB29 : STD_LOGIC; 
  signal XLXI_6_B5_DIB28 : STD_LOGIC; 
  signal XLXI_6_B5_DIB27 : STD_LOGIC; 
  signal XLXI_6_B5_DIB26 : STD_LOGIC; 
  signal XLXI_6_B5_DIB25 : STD_LOGIC; 
  signal XLXI_6_B5_DIB24 : STD_LOGIC; 
  signal XLXI_6_B5_DIB23 : STD_LOGIC; 
  signal XLXI_6_B5_DIB22 : STD_LOGIC; 
  signal XLXI_6_B5_DIB21 : STD_LOGIC; 
  signal XLXI_6_B5_DIB20 : STD_LOGIC; 
  signal XLXI_6_B5_DIB19 : STD_LOGIC; 
  signal XLXI_6_B5_DIB18 : STD_LOGIC; 
  signal XLXI_6_B5_DIB17 : STD_LOGIC; 
  signal XLXI_6_B5_DIB16 : STD_LOGIC; 
  signal XLXI_6_B5_DIB15 : STD_LOGIC; 
  signal XLXI_6_B5_DIB14 : STD_LOGIC; 
  signal XLXI_6_B5_DIB13 : STD_LOGIC; 
  signal XLXI_6_B5_DIB12 : STD_LOGIC; 
  signal XLXI_6_B5_DIB11 : STD_LOGIC; 
  signal XLXI_6_B5_DIB10 : STD_LOGIC; 
  signal XLXI_6_B5_DIB9 : STD_LOGIC; 
  signal XLXI_6_B5_DIB8 : STD_LOGIC; 
  signal XLXI_6_B5_DIB7 : STD_LOGIC; 
  signal XLXI_6_B5_DIB6 : STD_LOGIC; 
  signal XLXI_6_B5_DIB5 : STD_LOGIC; 
  signal XLXI_6_B5_DIB4 : STD_LOGIC; 
  signal XLXI_6_B5_DIB3 : STD_LOGIC; 
  signal XLXI_6_B5_DIB2 : STD_LOGIC; 
  signal XLXI_6_B5_DIB1 : STD_LOGIC; 
  signal XLXI_6_B5_DIB0 : STD_LOGIC; 
  signal XLXI_6_B5_DIPA3 : STD_LOGIC; 
  signal XLXI_6_B5_DIPA2 : STD_LOGIC; 
  signal XLXI_6_B5_DIA31 : STD_LOGIC; 
  signal XLXI_6_B5_DIA30 : STD_LOGIC; 
  signal XLXI_6_B5_DIA29 : STD_LOGIC; 
  signal XLXI_6_B5_DIA28 : STD_LOGIC; 
  signal XLXI_6_B5_DIA27 : STD_LOGIC; 
  signal XLXI_6_B5_DIA26 : STD_LOGIC; 
  signal XLXI_6_B5_DIA25 : STD_LOGIC; 
  signal XLXI_6_B5_DIA24 : STD_LOGIC; 
  signal XLXI_6_B5_DIA23 : STD_LOGIC; 
  signal XLXI_6_B5_DIA22 : STD_LOGIC; 
  signal XLXI_6_B5_DIA21 : STD_LOGIC; 
  signal XLXI_6_B5_DIA20 : STD_LOGIC; 
  signal XLXI_6_B5_DIA19 : STD_LOGIC; 
  signal XLXI_6_B5_DIA18 : STD_LOGIC; 
  signal XLXI_6_B5_DIA17 : STD_LOGIC; 
  signal XLXI_6_B5_DIA16 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRB0 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRB1 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRB2 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRB3 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRB4 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRB5 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRB6 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRB7 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRB8 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRB9 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRB10 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRB11 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRB12 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRB13 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRA0 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRA1 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRA2 : STD_LOGIC; 
  signal XLXI_6_B5_ADDRA3 : STD_LOGIC; 
  signal XLXI_6_B5_WEA_INTNOT : STD_LOGIC; 
  signal XLXI_6_B5_SSRA_INTNOT : STD_LOGIC; 
  signal XLXI_7_B5_DOPB3 : STD_LOGIC; 
  signal XLXI_7_B5_DOPB2 : STD_LOGIC; 
  signal XLXI_7_B5_DOPB1 : STD_LOGIC; 
  signal XLXI_7_B5_DOPB0 : STD_LOGIC; 
  signal XLXI_7_B5_DOB31 : STD_LOGIC; 
  signal XLXI_7_B5_DOB30 : STD_LOGIC; 
  signal XLXI_7_B5_DOB29 : STD_LOGIC; 
  signal XLXI_7_B5_DOB28 : STD_LOGIC; 
  signal XLXI_7_B5_DOB27 : STD_LOGIC; 
  signal XLXI_7_B5_DOB26 : STD_LOGIC; 
  signal XLXI_7_B5_DOB25 : STD_LOGIC; 
  signal XLXI_7_B5_DOB24 : STD_LOGIC; 
  signal XLXI_7_B5_DOB23 : STD_LOGIC; 
  signal XLXI_7_B5_DOB22 : STD_LOGIC; 
  signal XLXI_7_B5_DOB21 : STD_LOGIC; 
  signal XLXI_7_B5_DOB20 : STD_LOGIC; 
  signal XLXI_7_B5_DOB19 : STD_LOGIC; 
  signal XLXI_7_B5_DOB18 : STD_LOGIC; 
  signal XLXI_7_B5_DOB17 : STD_LOGIC; 
  signal XLXI_7_B5_DOB16 : STD_LOGIC; 
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
  signal XLXI_7_B5_DOPA3 : STD_LOGIC; 
  signal XLXI_7_B5_DOPA2 : STD_LOGIC; 
  signal XLXI_7_B5_DOPA1 : STD_LOGIC; 
  signal XLXI_7_B5_DOPA0 : STD_LOGIC; 
  signal XLXI_7_B5_DOA31 : STD_LOGIC; 
  signal XLXI_7_B5_DOA30 : STD_LOGIC; 
  signal XLXI_7_B5_DOA29 : STD_LOGIC; 
  signal XLXI_7_B5_DOA28 : STD_LOGIC; 
  signal XLXI_7_B5_DOA27 : STD_LOGIC; 
  signal XLXI_7_B5_DOA26 : STD_LOGIC; 
  signal XLXI_7_B5_DOA25 : STD_LOGIC; 
  signal XLXI_7_B5_DOA24 : STD_LOGIC; 
  signal XLXI_7_B5_DOA23 : STD_LOGIC; 
  signal XLXI_7_B5_DOA22 : STD_LOGIC; 
  signal XLXI_7_B5_DOA21 : STD_LOGIC; 
  signal XLXI_7_B5_DOA20 : STD_LOGIC; 
  signal XLXI_7_B5_DOA19 : STD_LOGIC; 
  signal XLXI_7_B5_DOA18 : STD_LOGIC; 
  signal XLXI_7_B5_DOA17 : STD_LOGIC; 
  signal XLXI_7_B5_DOA16 : STD_LOGIC; 
  signal XLXI_7_B5_DOA15 : STD_LOGIC; 
  signal XLXI_7_B5_DOA14 : STD_LOGIC; 
  signal XLXI_7_B5_DOA13 : STD_LOGIC; 
  signal XLXI_7_B5_DOA12 : STD_LOGIC; 
  signal XLXI_7_B5_DIPB3 : STD_LOGIC; 
  signal XLXI_7_B5_DIPB2 : STD_LOGIC; 
  signal XLXI_7_B5_DIPB1 : STD_LOGIC; 
  signal XLXI_7_B5_DIPB0 : STD_LOGIC; 
  signal XLXI_7_B5_DIB31 : STD_LOGIC; 
  signal XLXI_7_B5_DIB30 : STD_LOGIC; 
  signal XLXI_7_B5_DIB29 : STD_LOGIC; 
  signal XLXI_7_B5_DIB28 : STD_LOGIC; 
  signal XLXI_7_B5_DIB27 : STD_LOGIC; 
  signal XLXI_7_B5_DIB26 : STD_LOGIC; 
  signal XLXI_7_B5_DIB25 : STD_LOGIC; 
  signal XLXI_7_B5_DIB24 : STD_LOGIC; 
  signal XLXI_7_B5_DIB23 : STD_LOGIC; 
  signal XLXI_7_B5_DIB22 : STD_LOGIC; 
  signal XLXI_7_B5_DIB21 : STD_LOGIC; 
  signal XLXI_7_B5_DIB20 : STD_LOGIC; 
  signal XLXI_7_B5_DIB19 : STD_LOGIC; 
  signal XLXI_7_B5_DIB18 : STD_LOGIC; 
  signal XLXI_7_B5_DIB17 : STD_LOGIC; 
  signal XLXI_7_B5_DIB16 : STD_LOGIC; 
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
  signal XLXI_7_B5_DIPA3 : STD_LOGIC; 
  signal XLXI_7_B5_DIPA2 : STD_LOGIC; 
  signal XLXI_7_B5_DIA31 : STD_LOGIC; 
  signal XLXI_7_B5_DIA30 : STD_LOGIC; 
  signal XLXI_7_B5_DIA29 : STD_LOGIC; 
  signal XLXI_7_B5_DIA28 : STD_LOGIC; 
  signal XLXI_7_B5_DIA27 : STD_LOGIC; 
  signal XLXI_7_B5_DIA26 : STD_LOGIC; 
  signal XLXI_7_B5_DIA25 : STD_LOGIC; 
  signal XLXI_7_B5_DIA24 : STD_LOGIC; 
  signal XLXI_7_B5_DIA23 : STD_LOGIC; 
  signal XLXI_7_B5_DIA22 : STD_LOGIC; 
  signal XLXI_7_B5_DIA21 : STD_LOGIC; 
  signal XLXI_7_B5_DIA20 : STD_LOGIC; 
  signal XLXI_7_B5_DIA19 : STD_LOGIC; 
  signal XLXI_7_B5_DIA18 : STD_LOGIC; 
  signal XLXI_7_B5_DIA17 : STD_LOGIC; 
  signal XLXI_7_B5_DIA16 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB0 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB1 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB2 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB3 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB4 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB5 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB6 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB7 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB8 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB9 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB10 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB11 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB12 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRB13 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRA0 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRA1 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRA2 : STD_LOGIC; 
  signal XLXI_7_B5_ADDRA3 : STD_LOGIC; 
  signal XLXI_7_B5_SSRA_INTNOT : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_0_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_0_FXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_0_F5MUX : STD_LOGIC; 
  signal N32088 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_0_BXINV : STD_LOGIC; 
  signal N32086 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_0_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_0_CEINV : STD_LOGIC; 
  signal N31024_F5MUX : STD_LOGIC; 
  signal N32153 : STD_LOGIC; 
  signal N31024_BXINV : STD_LOGIC; 
  signal N32151 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_1_FXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_1_F5MUX : STD_LOGIC; 
  signal N32118 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_1_BXINV : STD_LOGIC; 
  signal N32116 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_1_CEINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_10_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_10_FXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_10_F5MUX : STD_LOGIC; 
  signal N32093 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_10_BXINV : STD_LOGIC; 
  signal N32091 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_10_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_10_CEINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_2_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_2_FXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_2_F5MUX : STD_LOGIC; 
  signal N32113 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_2_BXINV : STD_LOGIC; 
  signal N32111 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_2_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_2_CEINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_11_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_11_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_11_FXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_11_F5MUX : STD_LOGIC; 
  signal N32138 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_11_BXINV : STD_LOGIC; 
  signal N32136 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_11_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_11_CEINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_3_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_3_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_3_FXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_3_F5MUX : STD_LOGIC; 
  signal N32073 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_3_BXINV : STD_LOGIC; 
  signal N32071 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_3_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_3_CEINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_4_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_4_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_4_FXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_4_F5MUX : STD_LOGIC; 
  signal N32173 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_4_BXINV : STD_LOGIC; 
  signal N32171 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_4_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_4_CEINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_5_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_5_FXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_5_F5MUX : STD_LOGIC; 
  signal N32168 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_5_BXINV : STD_LOGIC; 
  signal N32166 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_5_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_5_CEINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_6_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_6_FXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_6_F5MUX : STD_LOGIC; 
  signal N32063 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_6_BXINV : STD_LOGIC; 
  signal N32061 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_6_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_6_CEINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_7_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_7_FXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_7_F5MUX : STD_LOGIC; 
  signal N32058 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_7_BXINV : STD_LOGIC; 
  signal N32056 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_7_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_7_CEINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_8_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_8_FXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_8_F5MUX : STD_LOGIC; 
  signal N32098 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_8_BXINV : STD_LOGIC; 
  signal N32096 : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_8_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_8_CEINV : STD_LOGIC; 
  signal N30892_F5MUX : STD_LOGIC; 
  signal N32053 : STD_LOGIC; 
  signal N30892_BXINV : STD_LOGIC; 
  signal N32051 : STD_LOGIC; 
  signal Cpu16_I1_pc_6_DXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_6_FXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_6_F : STD_LOGIC; 
  signal Cpu16_I1_pc_6_G : STD_LOGIC; 
  signal Cpu16_I1_pc_6_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I1_pc_6_CLKINV : STD_LOGIC; 
  signal XLXN_14_11_F : STD_LOGIC; 
  signal XLXN_14_11_G : STD_LOGIC; 
  signal Cpu16_I1_pc_10_DXMUX : STD_LOGIC; 
  signal Cpu16_I1_iaddr_x_10_47_O : STD_LOGIC; 
  signal Cpu16_I1_pc_10_G : STD_LOGIC; 
  signal Cpu16_I1_pc_10_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I1_pc_10_CLKINV : STD_LOGIC; 
  signal Cpu16_I1_pc_7_DXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_7_FXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_7_F : STD_LOGIC; 
  signal Cpu16_I1_pc_7_G : STD_LOGIC; 
  signal Cpu16_I1_pc_7_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I1_pc_7_CLKINV : STD_LOGIC; 
  signal Cpu16_I1_pc_11_DXMUX : STD_LOGIC; 
  signal Cpu16_I1_iaddr_x_11_47_O : STD_LOGIC; 
  signal Cpu16_I1_pc_11_G : STD_LOGIC; 
  signal Cpu16_I1_pc_11_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I1_pc_11_CLKINV : STD_LOGIC; 
  signal Cpu16_I1_pc_8_DXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_8_FXMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_8_F : STD_LOGIC; 
  signal Cpu16_I1_pc_8_G : STD_LOGIC; 
  signal Cpu16_I1_pc_8_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I1_pc_8_CLKINV : STD_LOGIC; 
  signal N31976_F : STD_LOGIC; 
  signal N31976_G : STD_LOGIC; 
  signal N31120_F : STD_LOGIC; 
  signal N31120_G : STD_LOGIC; 
  signal Cpu16_I2_C_mem_x_F : STD_LOGIC; 
  signal Cpu16_I2_C_mem_x_G : STD_LOGIC; 
  signal Cpu16_I2_int_stop_c_F : STD_LOGIC; 
  signal Cpu16_I2_int_stop_c_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_int_stop_c_GYMUX : STD_LOGIC; 
  signal Cpu16_I2_int_stop_c_G : STD_LOGIC; 
  signal Cpu16_I2_int_stop_c_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_int_stop_c_CLKINV : STD_LOGIC; 
  signal XLXI_3_nadwe_c_F : STD_LOGIC; 
  signal XLXI_3_nadwe_c_DYMUX : STD_LOGIC; 
  signal XLXI_3_nadwe_c_GYMUX : STD_LOGIC; 
  signal XLXI_3_nadwe_c_G : STD_LOGIC; 
  signal XLXI_3_nadwe_c_SRINVNOT : STD_LOGIC; 
  signal XLXI_3_nadwe_c_CLKINV : STD_LOGIC; 
  signal XLXI_3_nadwe_c_CEINV : STD_LOGIC; 
  signal Cpu16_I2_n0150_F : STD_LOGIC; 
  signal Cpu16_I2_n0150_G : STD_LOGIC; 
  signal XLXI_4_addr_c_1_DXMUX : STD_LOGIC; 
  signal XLXI_4_addr_c_1_FXMUX : STD_LOGIC; 
  signal XLXI_4_addr_c_1_F : STD_LOGIC; 
  signal XLXI_4_addr_c_1_G : STD_LOGIC; 
  signal XLXI_4_addr_c_1_SRINVNOT : STD_LOGIC; 
  signal XLXI_4_addr_c_1_CLKINV : STD_LOGIC; 
  signal N30884_F : STD_LOGIC; 
  signal N30884_G : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_11_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_Mmux_n0158_Result_11_1_O : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_11_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_Mmux_n0158_Result_10_1_O : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_11_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_11_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_TC_c_1_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_TC_c_1_1_F : STD_LOGIC; 
  signal Cpu16_I2_TC_c_1_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_TC_c_1_1_GYMUX : STD_LOGIC; 
  signal Cpu16_I2_TC_c_1_1_G : STD_LOGIC; 
  signal Cpu16_I2_TC_c_1_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_TC_c_1_1_CLKINV : STD_LOGIC; 
  signal XLXI_4_addr_c_7_DXMUX : STD_LOGIC; 
  signal XLXI_4_addr_c_7_FXMUX : STD_LOGIC; 
  signal XLXI_4_addr_c_7_F : STD_LOGIC; 
  signal XLXI_4_addr_c_7_G : STD_LOGIC; 
  signal XLXI_4_addr_c_7_SRINVNOT : STD_LOGIC; 
  signal XLXI_4_addr_c_7_CLKINV : STD_LOGIC; 
  signal XLXI_2_mux_c_0_DXMUX : STD_LOGIC; 
  signal XLXI_2_n00071_O : STD_LOGIC; 
  signal XLXI_2_mux_c_0_DYMUX : STD_LOGIC; 
  signal XLXI_5_Mmux_n0016_Result43_O : STD_LOGIC; 
  signal XLXI_2_mux_c_0_SRINVNOT : STD_LOGIC; 
  signal XLXI_2_mux_c_0_CLKINV : STD_LOGIC; 
  signal N31064_F : STD_LOGIC; 
  signal N31064_G : STD_LOGIC; 
  signal N30976_F : STD_LOGIC; 
  signal N30976_G : STD_LOGIC; 
  signal Cpu16_I2_pc_mux_x_1_44_2_F : STD_LOGIC; 
  signal Cpu16_I2_pc_mux_x_1_44_2_G : STD_LOGIC; 
  signal XLXN_14_0_F : STD_LOGIC; 
  signal XLXN_14_0_G : STD_LOGIC; 
  signal CHOICE1593_F : STD_LOGIC; 
  signal CHOICE1593_G : STD_LOGIC; 
  signal XLXN_14_1_F : STD_LOGIC; 
  signal XLXN_14_1_G : STD_LOGIC; 
  signal N31223_F : STD_LOGIC; 
  signal N31223_G : STD_LOGIC; 
  signal XLXN_14_2_F : STD_LOGIC; 
  signal XLXN_14_2_G : STD_LOGIC; 
  signal N31051_F : STD_LOGIC; 
  signal N31051_G : STD_LOGIC; 
  signal XLXN_14_3_F : STD_LOGIC; 
  signal XLXN_14_3_G : STD_LOGIC; 
  signal XLXI_2_nWE_RAM_c_F : STD_LOGIC; 
  signal XLXI_2_nWE_RAM_c_DYMUX : STD_LOGIC; 
  signal XLXI_2_nWE_RAM_x1_O : STD_LOGIC; 
  signal XLXI_2_nWE_RAM_c_SRINVNOT : STD_LOGIC; 
  signal XLXI_2_nWE_RAM_c_CLKINV : STD_LOGIC; 
  signal XLXN_14_4_F : STD_LOGIC; 
  signal XLXN_14_4_G : STD_LOGIC; 
  signal XLXI_5_nwait_c_0_DXMUX : STD_LOGIC; 
  signal XLXI_5_n0009_0_1_O : STD_LOGIC; 
  signal XLXI_5_nwait_c_0_G : STD_LOGIC; 
  signal XLXI_5_nwait_c_0_SRINVNOT : STD_LOGIC; 
  signal XLXI_5_nwait_c_0_CLKINV : STD_LOGIC; 
  signal XLXI_5_nwait_c_1_DYMUX : STD_LOGIC; 
  signal XLXI_5_n0009_1_1_O : STD_LOGIC; 
  signal XLXI_5_nwait_c_1_SRINVNOT : STD_LOGIC; 
  signal XLXI_5_nwait_c_1_CLKINV : STD_LOGIC; 
  signal XLXI_5_nwait_c_3_DXMUX : STD_LOGIC; 
  signal XLXI_5_n0009_3_1_O : STD_LOGIC; 
  signal XLXI_5_nwait_c_3_DYMUX : STD_LOGIC; 
  signal XLXI_5_n0009_2_1_O : STD_LOGIC; 
  signal XLXI_5_nwait_c_3_SRINVNOT : STD_LOGIC; 
  signal XLXI_5_nwait_c_3_CLKINV : STD_LOGIC; 
  signal XLXN_14_5_F : STD_LOGIC; 
  signal XLXN_14_5_G : STD_LOGIC; 
  signal XLXI_5_nwait_c_5_DXMUX : STD_LOGIC; 
  signal XLXI_5_n0009_5_1_O : STD_LOGIC; 
  signal XLXI_5_nwait_c_5_DYMUX : STD_LOGIC; 
  signal XLXI_5_n0009_4_1_O : STD_LOGIC; 
  signal XLXI_5_nwait_c_5_SRINVNOT : STD_LOGIC; 
  signal XLXI_5_nwait_c_5_CLKINV : STD_LOGIC; 
  signal XLXI_5_nwait_c_7_DXMUX : STD_LOGIC; 
  signal XLXI_5_n0009_7_1_O : STD_LOGIC; 
  signal XLXI_5_nwait_c_7_DYMUX : STD_LOGIC; 
  signal XLXI_5_n0009_6_1_O : STD_LOGIC; 
  signal XLXI_5_nwait_c_7_SRINVNOT : STD_LOGIC; 
  signal XLXI_5_nwait_c_7_CLKINV : STD_LOGIC; 
  signal XLXI_4_addr_c_0_DYMUX : STD_LOGIC; 
  signal XLXI_4_addr_c_0_GYMUX : STD_LOGIC; 
  signal XLXI_4_addr_c_0_G : STD_LOGIC; 
  signal XLXI_4_addr_c_0_SRINVNOT : STD_LOGIC; 
  signal XLXI_4_addr_c_0_CLKINV : STD_LOGIC; 
  signal XLXN_14_6_F : STD_LOGIC; 
  signal XLXN_14_6_G : STD_LOGIC; 
  signal XLXI_4_addr_c_3_DXMUX : STD_LOGIC; 
  signal XLXI_4_addr_c_3_FXMUX : STD_LOGIC; 
  signal XLXI_4_addr_c_3_F : STD_LOGIC; 
  signal XLXI_4_addr_c_3_DYMUX : STD_LOGIC; 
  signal XLXI_4_addr_c_3_GYMUX : STD_LOGIC; 
  signal XLXI_4_addr_c_3_G : STD_LOGIC; 
  signal XLXI_4_addr_c_3_SRINVNOT : STD_LOGIC; 
  signal XLXI_4_addr_c_3_CLKINV : STD_LOGIC; 
  signal XLXI_4_addr_c_5_DXMUX : STD_LOGIC; 
  signal XLXI_4_addr_c_5_FXMUX : STD_LOGIC; 
  signal XLXI_4_addr_c_5_F : STD_LOGIC; 
  signal XLXI_4_addr_c_5_DYMUX : STD_LOGIC; 
  signal XLXI_4_addr_c_5_GYMUX : STD_LOGIC; 
  signal XLXI_4_addr_c_5_G : STD_LOGIC; 
  signal XLXI_4_addr_c_5_SRINVNOT : STD_LOGIC; 
  signal XLXI_4_addr_c_5_CLKINV : STD_LOGIC; 
  signal XLXI_4_addr_c_6_F : STD_LOGIC; 
  signal XLXI_4_addr_c_6_DYMUX : STD_LOGIC; 
  signal XLXI_4_addr_c_6_GYMUX : STD_LOGIC; 
  signal XLXI_4_addr_c_6_G : STD_LOGIC; 
  signal XLXI_4_addr_c_6_SRINVNOT : STD_LOGIC; 
  signal XLXI_4_addr_c_6_CLKINV : STD_LOGIC; 
  signal XLXN_14_7_F : STD_LOGIC; 
  signal XLXN_14_7_G : STD_LOGIC; 
  signal CHOICE421_F : STD_LOGIC; 
  signal CHOICE421_G : STD_LOGIC; 
  signal CHOICE436_F : STD_LOGIC; 
  signal CHOICE436_G : STD_LOGIC; 
  signal CHOICE437_F : STD_LOGIC; 
  signal CHOICE437_G : STD_LOGIC; 
  signal XLXN_14_8_F : STD_LOGIC; 
  signal XLXN_14_8_G : STD_LOGIC; 
  signal XLXN_14_9_F : STD_LOGIC; 
  signal XLXN_14_9_G : STD_LOGIC; 
  signal CHOICE469_F : STD_LOGIC; 
  signal CHOICE469_G : STD_LOGIC; 
  signal Cpu16_I2_skip_c_F : STD_LOGIC; 
  signal Cpu16_I2_skip_c_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_skip_c_GYMUX : STD_LOGIC; 
  signal Cpu16_I2_skip_c_G : STD_LOGIC; 
  signal Cpu16_I2_skip_c_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_skip_c_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_skip_c_CEINV : STD_LOGIC; 
  signal XLXI_5_ndre_c_DXMUX : STD_LOGIC; 
  signal XLXI_5_ndre_c_FXMUX : STD_LOGIC; 
  signal XLXI_5_ndre_c_F : STD_LOGIC; 
  signal XLXI_5_ndre_c_G : STD_LOGIC; 
  signal XLXI_5_ndre_c_SRINVNOT : STD_LOGIC; 
  signal XLXI_5_ndre_c_CLKINV : STD_LOGIC; 
  signal XLXI_5_ndre_c_CEINVNOT : STD_LOGIC; 
  signal CHOICE1531_F : STD_LOGIC; 
  signal CHOICE1531_G : STD_LOGIC; 
  signal CHOICE1553_F : STD_LOGIC; 
  signal CHOICE1553_G : STD_LOGIC; 
  signal CHOICE1538_F : STD_LOGIC; 
  signal CHOICE1538_G : STD_LOGIC; 
  signal CHOICE1562_F : STD_LOGIC; 
  signal CHOICE1562_G : STD_LOGIC; 
  signal CHOICE1476_F : STD_LOGIC; 
  signal CHOICE1476_G : STD_LOGIC; 
  signal Cpu16_I4_n0202_F : STD_LOGIC; 
  signal Cpu16_I4_n0202_G : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_0_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_n0147_0_208_1_O : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_0_1_G : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_0_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_0_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_1_F : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_1_GYMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_1_G : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_1_CLKINV : STD_LOGIC; 
  signal CHOICE1483_F : STD_LOGIC; 
  signal CHOICE1483_G : STD_LOGIC; 
  signal CHOICE1241_F : STD_LOGIC; 
  signal CHOICE1241_G : STD_LOGIC; 
  signal CHOICE1421_F : STD_LOGIC; 
  signal CHOICE1421_G : STD_LOGIC; 
  signal CHOICE1428_F : STD_LOGIC; 
  signal CHOICE1428_G : STD_LOGIC; 
  signal CHOICE1424_F : STD_LOGIC; 
  signal CHOICE1424_G : STD_LOGIC; 
  signal CHOICE1296_F : STD_LOGIC; 
  signal CHOICE1296_G : STD_LOGIC; 
  signal CHOICE1340_F : STD_LOGIC; 
  signal CHOICE1340_G : STD_LOGIC; 
  signal Cpu16_I4_N18018_F : STD_LOGIC; 
  signal Cpu16_I4_N18018_G : STD_LOGIC; 
  signal CHOICE1351_F : STD_LOGIC; 
  signal CHOICE1351_G : STD_LOGIC; 
  signal CHOICE1285_F : STD_LOGIC; 
  signal CHOICE1285_G : STD_LOGIC; 
  signal CHOICE1439_F : STD_LOGIC; 
  signal CHOICE1439_G : STD_LOGIC; 
  signal CHOICE1230_F : STD_LOGIC; 
  signal CHOICE1230_G : STD_LOGIC; 
  signal CHOICE1494_F : STD_LOGIC; 
  signal CHOICE1494_G : STD_LOGIC; 
  signal CHOICE1175_F : STD_LOGIC; 
  signal CHOICE1175_G : STD_LOGIC; 
  signal CHOICE1631_F : STD_LOGIC; 
  signal CHOICE1631_G : STD_LOGIC; 
  signal CHOICE1120_F : STD_LOGIC; 
  signal CHOICE1120_G : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_0_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_0_FXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_0_F : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_0_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_0_G : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_0_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_0_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_0_CEINV : STD_LOGIC; 
  signal CHOICE1065_F : STD_LOGIC; 
  signal CHOICE1065_G : STD_LOGIC; 
  signal CHOICE1010_F : STD_LOGIC; 
  signal CHOICE1010_G : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_2_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_2_FXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_2_F : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_2_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_2_G : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_2_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_2_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_2_CEINV : STD_LOGIC; 
  signal N21764_F : STD_LOGIC; 
  signal N21764_G : STD_LOGIC; 
  signal N31173_F : STD_LOGIC; 
  signal N31173_G : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_4_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_4_FXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_4_F : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_4_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_4_G : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_4_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_4_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_4_CEINV : STD_LOGIC; 
  signal N31230_F : STD_LOGIC; 
  signal N31230_G : STD_LOGIC; 
  signal N31926_F : STD_LOGIC; 
  signal N31926_G : STD_LOGIC; 
  signal Cpu16_pc_mux_0_F : STD_LOGIC; 
  signal Cpu16_pc_mux_0_G : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_6_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_6_FXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_6_F : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_6_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_6_G : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_6_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_6_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_6_CEINV : STD_LOGIC; 
  signal N30261_F : STD_LOGIC; 
  signal N30261_G : STD_LOGIC; 
  signal N30412_F : STD_LOGIC; 
  signal N30412_G : STD_LOGIC; 
  signal N30265_F : STD_LOGIC; 
  signal N30265_G : STD_LOGIC; 
  signal N30416_F : STD_LOGIC; 
  signal N30416_G : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_8_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_8_FXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_8_F : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_8_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_8_G : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_8_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_8_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_8_CEINV : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_2_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_2_FXMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_2_F : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_2_G : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_2_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_2_CLKINV : STD_LOGIC; 
  signal CHOICE1577_F : STD_LOGIC; 
  signal CHOICE1577_G : STD_LOGIC; 
  signal Cpu16_I2_TC_c_0_F : STD_LOGIC; 
  signal Cpu16_I2_TC_c_0_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_TC_c_0_GYMUX : STD_LOGIC; 
  signal Cpu16_I2_TC_c_0_G : STD_LOGIC; 
  signal Cpu16_I2_TC_c_0_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_TC_c_0_CLKINV : STD_LOGIC; 
  signal Cpu16_I1_pc_9_F : STD_LOGIC; 
  signal Cpu16_I1_pc_9_DYMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_9_GYMUX : STD_LOGIC; 
  signal Cpu16_I1_pc_9_G : STD_LOGIC; 
  signal Cpu16_I1_pc_9_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I1_pc_9_CLKINV : STD_LOGIC; 
  signal CHOICE712_F : STD_LOGIC; 
  signal CHOICE712_G : STD_LOGIC; 
  signal CHOICE794_F : STD_LOGIC; 
  signal CHOICE794_G : STD_LOGIC; 
  signal CHOICE713_F : STD_LOGIC; 
  signal CHOICE713_G : STD_LOGIC; 
  signal CHOICE825_F : STD_LOGIC; 
  signal CHOICE825_G : STD_LOGIC; 
  signal CHOICE856_F : STD_LOGIC; 
  signal CHOICE856_G : STD_LOGIC; 
  signal CHOICE911_F : STD_LOGIC; 
  signal CHOICE911_G : STD_LOGIC; 
  signal CHOICE966_F : STD_LOGIC; 
  signal CHOICE966_G : STD_LOGIC; 
  signal CHOICE955_F : STD_LOGIC; 
  signal CHOICE955_G : STD_LOGIC; 
  signal N30430_F : STD_LOGIC; 
  signal N30430_G : STD_LOGIC; 
  signal CHOICE1021_F : STD_LOGIC; 
  signal CHOICE1021_G : STD_LOGIC; 
  signal CHOICE900_F : STD_LOGIC; 
  signal CHOICE900_G : STD_LOGIC; 
  signal CHOICE1076_F : STD_LOGIC; 
  signal CHOICE1076_G : STD_LOGIC; 
  signal CHOICE687_F : STD_LOGIC; 
  signal CHOICE687_G : STD_LOGIC; 
  signal Cpu16_pc_mux_1_F : STD_LOGIC; 
  signal Cpu16_pc_mux_1_G : STD_LOGIC; 
  signal CHOICE1131_F : STD_LOGIC; 
  signal CHOICE1131_G : STD_LOGIC; 
  signal CHOICE1186_F : STD_LOGIC; 
  signal CHOICE1186_G : STD_LOGIC; 
  signal Cpu16_pc_mux_2_F : STD_LOGIC; 
  signal Cpu16_pc_mux_2_G : STD_LOGIC; 
  signal N31234_F : STD_LOGIC; 
  signal N31234_G : STD_LOGIC; 
  signal N30434_F : STD_LOGIC; 
  signal N30434_G : STD_LOGIC; 
  signal N31934_F : STD_LOGIC; 
  signal N31934_G : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd1_F : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd1_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd1_GYMUX : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd1_G : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd1_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_10_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_10_FXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_10_F : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_10_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_10_G : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_10_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_10_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_10_CEINV : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_12_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_12_FXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_12_F : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_12_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_12_G : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_12_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_12_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_12_CEINV : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_14_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_14_FXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_14_F : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_14_G : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_14_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_14_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_14_CEINV : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_15_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_15_FXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_15_F : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_15_G : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_15_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_15_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_15_CEINV : STD_LOGIC; 
  signal N30405_F : STD_LOGIC; 
  signal N30405_G : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_16_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_16_FXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_16_F : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_16_G : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_16_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_16_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_16_CEINV : STD_LOGIC; 
  signal Cpu16_I2_N15561_F : STD_LOGIC; 
  signal Cpu16_I2_N15561_G : STD_LOGIC; 
  signal N31954_F : STD_LOGIC; 
  signal N31954_G : STD_LOGIC; 
  signal N31238_F : STD_LOGIC; 
  signal N31238_G : STD_LOGIC; 
  signal N31900_F : STD_LOGIC; 
  signal N31900_G : STD_LOGIC; 
  signal Cpu16_I4_N18350_F : STD_LOGIC; 
  signal Cpu16_I4_N18350_G : STD_LOGIC; 
  signal N30964_F : STD_LOGIC; 
  signal N30964_G : STD_LOGIC; 
  signal N31922_F : STD_LOGIC; 
  signal N31922_G : STD_LOGIC; 
  signal N30966_F : STD_LOGIC; 
  signal N30966_G : STD_LOGIC; 
  signal N31972_F : STD_LOGIC; 
  signal N31972_G : STD_LOGIC; 
  signal N31242_F : STD_LOGIC; 
  signal N31242_G : STD_LOGIC; 
  signal N31948_F : STD_LOGIC; 
  signal N31948_G : STD_LOGIC; 
  signal N31896_F : STD_LOGIC; 
  signal N31896_G : STD_LOGIC; 
  signal XLXI_3_daddr_c_3_F : STD_LOGIC; 
  signal XLXI_3_daddr_c_3_DYMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_3_GYMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_3_G : STD_LOGIC; 
  signal XLXI_3_daddr_c_3_SRINVNOT : STD_LOGIC; 
  signal XLXI_3_daddr_c_3_CLKINV : STD_LOGIC; 
  signal XLXI_3_daddr_c_3_CEINV : STD_LOGIC; 
  signal XLXI_3_daddr_c_5_DXMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_5_FXMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_5_F : STD_LOGIC; 
  signal XLXI_3_daddr_c_5_DYMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_5_GYMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_5_G : STD_LOGIC; 
  signal XLXI_3_daddr_c_5_SRINVNOT : STD_LOGIC; 
  signal XLXI_3_daddr_c_5_CLKINV : STD_LOGIC; 
  signal XLXI_3_daddr_c_5_CEINV : STD_LOGIC; 
  signal XLXI_3_daddr_c_7_DXMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_7_FXMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_7_F : STD_LOGIC; 
  signal XLXI_3_daddr_c_7_DYMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_7_GYMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_7_G : STD_LOGIC; 
  signal XLXI_3_daddr_c_7_SRINVNOT : STD_LOGIC; 
  signal XLXI_3_daddr_c_7_CLKINV : STD_LOGIC; 
  signal XLXI_3_daddr_c_7_CEINV : STD_LOGIC; 
  signal XLXI_3_daddr_c_8_F : STD_LOGIC; 
  signal XLXI_3_daddr_c_8_DYMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_8_GYMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_8_G : STD_LOGIC; 
  signal XLXI_3_daddr_c_8_SRINVNOT : STD_LOGIC; 
  signal XLXI_3_daddr_c_8_CLKINV : STD_LOGIC; 
  signal XLXI_3_daddr_c_8_CEINV : STD_LOGIC; 
  signal N31984_F : STD_LOGIC; 
  signal N31984_G : STD_LOGIC; 
  signal N31944_F : STD_LOGIC; 
  signal N31944_G : STD_LOGIC; 
  signal N31271_F : STD_LOGIC; 
  signal N31271_G : STD_LOGIC; 
  signal N31904_F : STD_LOGIC; 
  signal N31904_G : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_1_CEINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_3_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_3_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_3_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_3_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_3_CEINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_5_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_5_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_5_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_5_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_5_CEINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_7_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_7_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_7_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_7_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_7_CEINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_9_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_9_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_9_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_9_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_9_CEINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_0_F : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_0_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_0_GYMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_0_G : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_0_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_0_CEINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_1_F : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_1_GYMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_1_G : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_1_CEINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_3_F : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_3_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_3_GYMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_3_G : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_3_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_3_CEINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_5_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_5_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_5_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_5_CEINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_7_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_7_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_7_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_7_CEINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_9_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_9_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_9_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_9_CEINV : STD_LOGIC; 
  signal Cpu16_I4_ireg_we_c_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_ireg_we_x : STD_LOGIC; 
  signal Cpu16_I4_ireg_we_c_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_dexp_we_x : STD_LOGIC; 
  signal Cpu16_I4_ireg_we_c_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_ireg_we_c_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_11_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_11_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_11_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_11_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_11_CEINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_11_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_11_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_11_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_11_CEINV : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_0_F : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_0_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_0_GYMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_0_G : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_0_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_0_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_3_F : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_3_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_3_GYMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_3_G : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_3_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_3_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_5_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_5_FXMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_5_F : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_5_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_5_GYMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_5_G : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_5_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_5_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_7_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_7_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_7_FXMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_7_F : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_7_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_7_GYMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_7_G : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_7_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_7_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_9_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_9_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_9_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_9_FXMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_9_F : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_9_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_9_GYMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_9_G : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_9_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_9_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_int_start_c_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_int_start_c_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_int_start_c_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_int_start_c_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_int_start_c_1_GYMUX : STD_LOGIC; 
  signal Cpu16_I2_int_start_c_1_G : STD_LOGIC; 
  signal Cpu16_I2_int_start_c_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_int_start_c_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_1_CLKINVNOT : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_1_CEINV : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_3_DXMUX : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_3_DYMUX : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_3_CLKINVNOT : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_3_CEINV : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_5_DXMUX : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_5_DYMUX : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_5_CLKINVNOT : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_5_CEINV : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_7_DXMUX : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_7_DYMUX : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_7_CLKINVNOT : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_7_CEINV : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_9_DXMUX : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_9_DYMUX : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_9_CLKINVNOT : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_9_CEINV : STD_LOGIC; 
  signal Cpu16_I1_nreset_v_0_F : STD_LOGIC; 
  signal Cpu16_I1_nreset_v_0_DYMUX : STD_LOGIC; 
  signal Cpu16_I1_nreset_v_0_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I1_nreset_v_0_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_nreset_v_0_F : STD_LOGIC; 
  signal Cpu16_I2_nreset_v_0_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_nreset_v_0_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_nreset_v_0_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_11_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_11_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_11_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_11_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_11_CEINV : STD_LOGIC; 
  signal Cpu16_I3_nreset_v_0_F : STD_LOGIC; 
  signal Cpu16_I3_nreset_v_0_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_nreset_v_0_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_nreset_v_0_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_nreset_v_0_F : STD_LOGIC; 
  signal Cpu16_I4_nreset_v_0_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_nreset_v_0_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_nreset_v_0_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_11_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_11_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_11_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_11_CEINV : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_11_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_11_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_11_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_11_CLKINV : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_10_F : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_10_DYMUX : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_10_CLKINVNOT : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_10_CEINV : STD_LOGIC; 
  signal Cpu16_I2_TC_c_2_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_TC_c_2_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_TC_c_2_1_GYMUX : STD_LOGIC; 
  signal Cpu16_I2_TC_c_2_1_G : STD_LOGIC; 
  signal Cpu16_I2_TC_c_2_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_TC_c_2_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_1_CEINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_3_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_3_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_3_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_3_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_3_CEINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_5_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_5_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_5_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_5_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_5_CEINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_7_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_7_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_7_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_7_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_7_CEINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_9_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_9_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_9_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_9_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_9_CEINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_1_CEINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_2_F : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_2_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_2_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_2_CEINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_5_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_5_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_5_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_5_CEINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_7_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_7_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_7_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_7_CEINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_9_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_9_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_9_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_9_CEINV : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd2_F : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd2_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd2_GYMUX : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd2_G : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd2_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd2_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd4_F : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd4_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd4_In : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd4_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd4_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_we_c_F : STD_LOGIC; 
  signal Cpu16_I4_iinc_we_c_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_we_x : STD_LOGIC; 
  signal Cpu16_I4_iinc_we_c_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_iinc_we_c_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_TC_c_0_1_F : STD_LOGIC; 
  signal Cpu16_I2_TC_c_0_1_DYMUX : STD_LOGIC; 
  signal N31995 : STD_LOGIC; 
  signal Cpu16_I2_TC_c_0_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_TC_c_0_1_CLKINV : STD_LOGIC; 
  signal XLXI_3_N12472_F : STD_LOGIC; 
  signal XLXI_3_N12472_G : STD_LOGIC; 
  signal ADDR_OUT_EXT_6_OBUF_F : STD_LOGIC; 
  signal ADDR_OUT_EXT_6_OBUF_G : STD_LOGIC; 
  signal N31801_F : STD_LOGIC; 
  signal N31801_G : STD_LOGIC; 
  signal N31203_F : STD_LOGIC; 
  signal N31203_G : STD_LOGIC; 
  signal Cpu16_I2_TD_c_0_3_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_TD_c_0_3_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_TD_c_0_3_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_3_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_3_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_3_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_TD_c_3_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_TD_c_3_1_FXMUX : STD_LOGIC; 
  signal Cpu16_I2_TD_c_3_1_F : STD_LOGIC; 
  signal Cpu16_I2_TD_c_3_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_TD_c_3_1_G : STD_LOGIC; 
  signal Cpu16_I2_TD_c_3_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_TD_c_3_1_CLKINV : STD_LOGIC; 
  signal CHOICE270_F : STD_LOGIC; 
  signal CHOICE270_G : STD_LOGIC; 
  signal CHOICE583_F : STD_LOGIC; 
  signal CHOICE583_G : STD_LOGIC; 
  signal N31179_F : STD_LOGIC; 
  signal N31179_G : STD_LOGIC; 
  signal CHOICE288_F : STD_LOGIC; 
  signal Cpu16_I2_TD_c_0_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_TD_c_0_1_FXMUX : STD_LOGIC; 
  signal Cpu16_I2_TD_c_0_1_F : STD_LOGIC; 
  signal Cpu16_I2_TD_c_0_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_TD_c_0_1_G : STD_LOGIC; 
  signal Cpu16_I2_TD_c_0_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_TD_c_0_1_CLKINV : STD_LOGIC; 
  signal N30665_F : STD_LOGIC; 
  signal N30665_G : STD_LOGIC; 
  signal N30424_F : STD_LOGIC; 
  signal N30424_G : STD_LOGIC; 
  signal N30764_F : STD_LOGIC; 
  signal N30764_G : STD_LOGIC; 
  signal Cpu16_I2_TD_c_1_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_TD_c_1_1_FXMUX : STD_LOGIC; 
  signal Cpu16_I2_TD_c_1_1_F : STD_LOGIC; 
  signal Cpu16_I2_TD_c_1_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_TD_c_1_1_G : STD_LOGIC; 
  signal Cpu16_I2_TD_c_1_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_TD_c_1_1_CLKINV : STD_LOGIC; 
  signal N30353_F : STD_LOGIC; 
  signal N30353_G : STD_LOGIC; 
  signal N31197_F : STD_LOGIC; 
  signal N31197_G : STD_LOGIC; 
  signal XLXI_4_n00021_SW1_O_F : STD_LOGIC; 
  signal XLXI_4_n00021_SW1_O_G : STD_LOGIC; 
  signal N31264_F : STD_LOGIC; 
  signal N31264_G : STD_LOGIC; 
  signal CHOICE544_F : STD_LOGIC; 
  signal CHOICE544_G : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_1_FXMUX : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_1_F : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_1_G : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_1_CLKINV : STD_LOGIC; 
  signal N31076_F : STD_LOGIC; 
  signal DATA_OUT_EXT_2_OBUF_F : STD_LOGIC; 
  signal DATA_OUT_EXT_2_OBUF_G : STD_LOGIC; 
  signal CHOICE392_F : STD_LOGIC; 
  signal CHOICE392_G : STD_LOGIC; 
  signal DATA_OUT_EXT_4_OBUF_F : STD_LOGIC; 
  signal DATA_OUT_EXT_4_OBUF_G : STD_LOGIC; 
  signal Cpu16_I2_nreset_v_1_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_nreset_v_1_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_nreset_v_1_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_nreset_v_1_1_CEINV : STD_LOGIC; 
  signal DATA_OUT_EXT_6_OBUF_F : STD_LOGIC; 
  signal DATA_OUT_EXT_6_OBUF_G : STD_LOGIC; 
  signal CHOICE397_F : STD_LOGIC; 
  signal CHOICE397_G : STD_LOGIC; 
  signal CHOICE530_F : STD_LOGIC; 
  signal CHOICE530_G : STD_LOGIC; 
  signal DATA_OUT_EXT_8_OBUF_F : STD_LOGIC; 
  signal DATA_OUT_EXT_8_OBUF_G : STD_LOGIC; 
  signal CHOICE485_F : STD_LOGIC; 
  signal CHOICE485_G : STD_LOGIC; 
  signal XLXI_3_dwait_c_DYMUX : STD_LOGIC; 
  signal XLXI_3_dwait_c_SRINVNOT : STD_LOGIC; 
  signal XLXI_3_dwait_c_CLKINV : STD_LOGIC; 
  signal N30510_F : STD_LOGIC; 
  signal DATA_OUT_EXT_10_OBUF_F : STD_LOGIC; 
  signal DATA_OUT_EXT_10_OBUF_G : STD_LOGIC; 
  signal CHOICE477_F : STD_LOGIC; 
  signal CHOICE477_G : STD_LOGIC; 
  signal Cpu16_I1_n0024_F : STD_LOGIC; 
  signal Cpu16_I1_n0024_G : STD_LOGIC; 
  signal N31908_F : STD_LOGIC; 
  signal N31908_G : STD_LOGIC; 
  signal N31181_F : STD_LOGIC; 
  signal N31181_G : STD_LOGIC; 
  signal N31185_F : STD_LOGIC; 
  signal N31185_G : STD_LOGIC; 
  signal CHOICE665_F : STD_LOGIC; 
  signal CHOICE665_G : STD_LOGIC; 
  signal Cpu16_I3_N17242_F : STD_LOGIC; 
  signal Cpu16_I3_N17242_G : STD_LOGIC; 
  signal N31146_F : STD_LOGIC; 
  signal N31146_G : STD_LOGIC; 
  signal N30880_F : STD_LOGIC; 
  signal N30880_G : STD_LOGIC; 
  signal N31335_F : STD_LOGIC; 
  signal N31335_G : STD_LOGIC; 
  signal N30613_F : STD_LOGIC; 
  signal N30613_G : STD_LOGIC; 
  signal N31217_F : STD_LOGIC; 
  signal N31217_G : STD_LOGIC; 
  signal N30347_F : STD_LOGIC; 
  signal N30347_G : STD_LOGIC; 
  signal N31311_F : STD_LOGIC; 
  signal N31311_G : STD_LOGIC; 
  signal DATA_OUT_EXT_12_OBUF_F : STD_LOGIC; 
  signal DATA_OUT_EXT_12_OBUF_G : STD_LOGIC; 
  signal DATA_OUT_EXT_14_OBUF_F : STD_LOGIC; 
  signal DATA_OUT_EXT_14_OBUF_G : STD_LOGIC; 
  signal CHOICE468_F : STD_LOGIC; 
  signal CHOICE468_G : STD_LOGIC; 
  signal Cpu16_I4_N18286_F : STD_LOGIC; 
  signal Cpu16_I4_N18286_G : STD_LOGIC; 
  signal CHOICE412_F : STD_LOGIC; 
  signal CHOICE412_G : STD_LOGIC; 
  signal Cpu16_I1_n0020_F : STD_LOGIC; 
  signal Cpu16_I1_n0020_G : STD_LOGIC; 
  signal CHOICE740_F : STD_LOGIC; 
  signal CHOICE740_G : STD_LOGIC; 
  signal N31258_F : STD_LOGIC; 
  signal N31258_G : STD_LOGIC; 
  signal CHOICE746_F : STD_LOGIC; 
  signal CHOICE746_G : STD_LOGIC; 
  signal N30440_F : STD_LOGIC; 
  signal N30440_G : STD_LOGIC; 
  signal CHOICE1587_F : STD_LOGIC; 
  signal CHOICE1587_G : STD_LOGIC; 
  signal CHOICE444_F : STD_LOGIC; 
  signal CHOICE444_G : STD_LOGIC; 
  signal CHOICE445_F : STD_LOGIC; 
  signal CHOICE445_G : STD_LOGIC; 
  signal N30842_F : STD_LOGIC; 
  signal N30842_G : STD_LOGIC; 
  signal CHOICE429_F : STD_LOGIC; 
  signal CHOICE429_G : STD_LOGIC; 
  signal CHOICE452_F : STD_LOGIC; 
  signal CHOICE452_G : STD_LOGIC; 
  signal CHOICE476_F : STD_LOGIC; 
  signal CHOICE476_G : STD_LOGIC; 
  signal CHOICE461_F : STD_LOGIC; 
  signal CHOICE461_G : STD_LOGIC; 
  signal CHOICE460_F : STD_LOGIC; 
  signal N30607_F : STD_LOGIC; 
  signal N30607_G : STD_LOGIC; 
  signal Cpu16_I2_idata_c_11_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_idata_c_11_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_idata_c_11_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_idata_c_11_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_idata_c_11_CEINV : STD_LOGIC; 
  signal N30341_F : STD_LOGIC; 
  signal N30341_G : STD_LOGIC; 
  signal Cpu16_I2_idata_c_13_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_idata_c_13_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_idata_c_13_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_idata_c_13_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_idata_c_13_CEINV : STD_LOGIC; 
  signal Cpu16_I2_idata_c_15_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_idata_c_15_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_idata_c_15_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_idata_c_15_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_idata_c_15_CEINV : STD_LOGIC; 
  signal N30814_F : STD_LOGIC; 
  signal N30814_G : STD_LOGIC; 
  signal Cpu16_I3_n0091_F : STD_LOGIC; 
  signal Cpu16_I3_n0091_G : STD_LOGIC; 
  signal N30848_F : STD_LOGIC; 
  signal N30848_G : STD_LOGIC; 
  signal N30595_F : STD_LOGIC; 
  signal N30595_G : STD_LOGIC; 
  signal CHOICE1415_F : STD_LOGIC; 
  signal CHOICE1415_G : STD_LOGIC; 
  signal N30329_F : STD_LOGIC; 
  signal N30329_G : STD_LOGIC; 
  signal CHOICE1162_F : STD_LOGIC; 
  signal CHOICE1162_G : STD_LOGIC; 
  signal CHOICE997_F : STD_LOGIC; 
  signal CHOICE997_G : STD_LOGIC; 
  signal CHOICE717_F : STD_LOGIC; 
  signal CHOICE717_G : STD_LOGIC; 
  signal N30812_F : STD_LOGIC; 
  signal N30812_G : STD_LOGIC; 
  signal CHOICE893_F : STD_LOGIC; 
  signal CHOICE893_G : STD_LOGIC; 
  signal CHOICE1035_F : STD_LOGIC; 
  signal CHOICE1035_G : STD_LOGIC; 
  signal CHOICE1263_F : STD_LOGIC; 
  signal CHOICE1263_G : STD_LOGIC; 
  signal N30679_F : STD_LOGIC; 
  signal N30679_G : STD_LOGIC; 
  signal CHOICE1366_F : STD_LOGIC; 
  signal CHOICE1366_G : STD_LOGIC; 
  signal CHOICE1171_F : STD_LOGIC; 
  signal CHOICE1171_G : STD_LOGIC; 
  signal CHOICE887_F : STD_LOGIC; 
  signal CHOICE887_G : STD_LOGIC; 
  signal CHOICE1441_F : STD_LOGIC; 
  signal CHOICE1441_G : STD_LOGIC; 
  signal N30808_F : STD_LOGIC; 
  signal N30808_G : STD_LOGIC; 
  signal CHOICE948_F : STD_LOGIC; 
  signal CHOICE948_G : STD_LOGIC; 
  signal CHOICE808_F : STD_LOGIC; 
  signal CHOICE808_G : STD_LOGIC; 
  signal Cpu16_I3_N17033_F : STD_LOGIC; 
  signal Cpu16_I3_N17033_G : STD_LOGIC; 
  signal CHOICE1318_F : STD_LOGIC; 
  signal CHOICE1318_G : STD_LOGIC; 
  signal CHOICE1188_F : STD_LOGIC; 
  signal CHOICE1188_G : STD_LOGIC; 
  signal CHOICE942_F : STD_LOGIC; 
  signal CHOICE942_G : STD_LOGIC; 
  signal CHOICE1226_F : STD_LOGIC; 
  signal CHOICE1226_G : STD_LOGIC; 
  signal N31026_F : STD_LOGIC; 
  signal N31026_G : STD_LOGIC; 
  signal CHOICE1445_F : STD_LOGIC; 
  signal CHOICE1445_G : STD_LOGIC; 
  signal CHOICE1168_F : STD_LOGIC; 
  signal CHOICE1168_G : STD_LOGIC; 
  signal Cpu16_I3_n0085_F : STD_LOGIC; 
  signal Cpu16_I3_n0085_G : STD_LOGIC; 
  signal CHOICE1090_F : STD_LOGIC; 
  signal CHOICE1090_G : STD_LOGIC; 
  signal CHOICE1373_F : STD_LOGIC; 
  signal CHOICE1373_G : STD_LOGIC; 
  signal N30830_F : STD_LOGIC; 
  signal N30830_G : STD_LOGIC; 
  signal XLXI_4_n00021_SW5_O_F : STD_LOGIC; 
  signal XLXI_4_n00021_SW5_O_G : STD_LOGIC; 
  signal CHOICE870_F : STD_LOGIC; 
  signal CHOICE870_G : STD_LOGIC; 
  signal XLXI_4_n00021_SW7_O_F : STD_LOGIC; 
  signal XLXI_4_n00021_SW7_O_G : STD_LOGIC; 
  signal CHOICE1461_F : STD_LOGIC; 
  signal CHOICE1461_G : STD_LOGIC; 
  signal CHOICE809_F : STD_LOGIC; 
  signal CHOICE809_G : STD_LOGIC; 
  signal CHOICE1052_F : STD_LOGIC; 
  signal CHOICE1052_G : STD_LOGIC; 
  signal CHOICE827_F : STD_LOGIC; 
  signal CHOICE827_G : STD_LOGIC; 
  signal XLXI_4_n00021_SW9_O_F : STD_LOGIC; 
  signal XLXI_4_n00021_SW9_O_G : STD_LOGIC; 
  signal Cpu16_I3_N17006_F : STD_LOGIC; 
  signal Cpu16_I3_N17006_G : STD_LOGIC; 
  signal CHOICE1637_F : STD_LOGIC; 
  signal CHOICE1637_G : STD_LOGIC; 
  signal N30794_F : STD_LOGIC; 
  signal N30794_G : STD_LOGIC; 
  signal CHOICE1003_F : STD_LOGIC; 
  signal CHOICE1003_G : STD_LOGIC; 
  signal Cpu16_I3_N17389_F : STD_LOGIC; 
  signal Cpu16_I3_N17389_G : STD_LOGIC; 
  signal CHOICE1078_F : STD_LOGIC; 
  signal CHOICE1078_G : STD_LOGIC; 
  signal CHOICE1145_F : STD_LOGIC; 
  signal CHOICE1145_G : STD_LOGIC; 
  signal CHOICE1516_F : STD_LOGIC; 
  signal CHOICE1516_G : STD_LOGIC; 
  signal N31307_F : STD_LOGIC; 
  signal N31307_G : STD_LOGIC; 
  signal CHOICE1646_F : STD_LOGIC; 
  signal CHOICE1646_G : STD_LOGIC; 
  signal CHOICE871_F : STD_LOGIC; 
  signal CHOICE871_G : STD_LOGIC; 
  signal CHOICE1116_F : STD_LOGIC; 
  signal CHOICE913_F : STD_LOGIC; 
  signal CHOICE913_G : STD_LOGIC; 
  signal CHOICE1390_F : STD_LOGIC; 
  signal CHOICE1390_G : STD_LOGIC; 
  signal CHOICE980_F : STD_LOGIC; 
  signal CHOICE980_G : STD_LOGIC; 
  signal CHOICE1653_F : STD_LOGIC; 
  signal CHOICE1653_G : STD_LOGIC; 
  signal N30673_F : STD_LOGIC; 
  signal N30673_G : STD_LOGIC; 
  signal CHOICE1201_F : STD_LOGIC; 
  signal CHOICE1201_G : STD_LOGIC; 
  signal N30383_F : STD_LOGIC; 
  signal N30383_G : STD_LOGIC; 
  signal CHOICE1402_F : STD_LOGIC; 
  signal CHOICE1402_G : STD_LOGIC; 
  signal Cpu16_I1_nreset_v_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I1_nreset_v_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I1_nreset_v_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I1_nreset_v_1_CEINV : STD_LOGIC; 
  signal N31299_F : STD_LOGIC; 
  signal N31299_G : STD_LOGIC; 
  signal N30619_F : STD_LOGIC; 
  signal N30619_G : STD_LOGIC; 
  signal N30335_F : STD_LOGIC; 
  signal N30335_G : STD_LOGIC; 
  signal N30824_F : STD_LOGIC; 
  signal N30824_G : STD_LOGIC; 
  signal Cpu16_I2_nreset_v_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_nreset_v_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_nreset_v_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_nreset_v_1_CEINV : STD_LOGIC; 
  signal N31319_F : STD_LOGIC; 
  signal N31319_G : STD_LOGIC; 
  signal N30601_F : STD_LOGIC; 
  signal N30601_G : STD_LOGIC; 
  signal N30323_F : STD_LOGIC; 
  signal N30323_G : STD_LOGIC; 
  signal Cpu16_I2_valid_c_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_valid_x : STD_LOGIC; 
  signal Cpu16_I2_valid_c_G : STD_LOGIC; 
  signal Cpu16_I2_valid_c_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_valid_c_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_nreset_v_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_nreset_v_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_nreset_v_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_nreset_v_1_CEINV : STD_LOGIC; 
  signal N30558_F : STD_LOGIC; 
  signal N30558_G : STD_LOGIC; 
  signal N30818_F : STD_LOGIC; 
  signal N30818_G : STD_LOGIC; 
  signal Cpu16_I4_nreset_v_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I4_nreset_v_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I4_nreset_v_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_nreset_v_1_CEINV : STD_LOGIC; 
  signal N24841_F : STD_LOGIC; 
  signal N24841_G : STD_LOGIC; 
  signal N30802_F : STD_LOGIC; 
  signal N30802_G : STD_LOGIC; 
  signal CHOICE1346_F : STD_LOGIC; 
  signal CHOICE1346_G : STD_LOGIC; 
  signal N31191_F : STD_LOGIC; 
  signal N31191_G : STD_LOGIC; 
  signal N30641_F : STD_LOGIC; 
  signal N30641_G : STD_LOGIC; 
  signal N31584_F : STD_LOGIC; 
  signal N31584_G : STD_LOGIC; 
  signal N30659_F : STD_LOGIC; 
  signal N30659_G : STD_LOGIC; 
  signal N30377_F : STD_LOGIC; 
  signal N30377_G : STD_LOGIC; 
  signal N30806_F : STD_LOGIC; 
  signal N30806_G : STD_LOGIC; 
  signal Cpu16_I2_S_c_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_S_c_1_G : STD_LOGIC; 
  signal Cpu16_I2_S_c_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_S_c_1_CLKINV : STD_LOGIC; 
  signal N30836_F : STD_LOGIC; 
  signal N30836_G : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_1_DXMUX : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_1_DYMUX : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_1_SRINVNOT : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_1_CLKINV : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_1_CEINV : STD_LOGIC; 
  signal N30494_F : STD_LOGIC; 
  signal N30494_G : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_3_DXMUX : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_3_DYMUX : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_3_SRINVNOT : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_3_CLKINV : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_3_CEINV : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_5_DXMUX : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_5_DYMUX : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_5_SRINVNOT : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_5_CLKINV : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_5_CEINV : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_7_DXMUX : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_7_DYMUX : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_7_SRINVNOT : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_7_CLKINV : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_7_CEINV : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_9_DXMUX : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_9_FXMUX : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_9_F : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_9_DYMUX : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_9_G : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_9_SRINVNOT : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_9_CLKINV : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_9_CEINV : STD_LOGIC; 
  signal N30635_F : STD_LOGIC; 
  signal N30635_G : STD_LOGIC; 
  signal Cpu16_I3_skip_i_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_skip_l : STD_LOGIC; 
  signal Cpu16_I3_skip_i_G : STD_LOGIC; 
  signal Cpu16_I3_skip_i_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_skip_i_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_skip_i_CEINV : STD_LOGIC; 
  signal N30317_F : STD_LOGIC; 
  signal N30317_G : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_11_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_11_FXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_11_F : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_11_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_11_G : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_11_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_11_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_13_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_13_FXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_13_F : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_13_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_13_G : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_13_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_13_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_15_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_15_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_15_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_15_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_16_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_16_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_16_CLKINV : STD_LOGIC; 
  signal N24468_F : STD_LOGIC; 
  signal Cpu16_I2_idata_c_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_idata_c_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_idata_c_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_idata_c_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_idata_c_1_CEINV : STD_LOGIC; 
  signal Cpu16_I2_idata_c_3_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_idata_c_3_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_idata_c_3_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_idata_c_3_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_idata_c_3_CEINV : STD_LOGIC; 
  signal Cpu16_I2_idata_c_5_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_idata_c_5_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_idata_c_5_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_idata_c_5_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_idata_c_5_CEINV : STD_LOGIC; 
  signal Cpu16_I2_idata_c_7_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_idata_c_7_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_idata_c_7_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_idata_c_7_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_idata_c_7_CEINV : STD_LOGIC; 
  signal Cpu16_I2_idata_c_9_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_idata_c_9_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_idata_c_9_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_idata_c_9_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_idata_c_9_CEINV : STD_LOGIC; 
  signal N30854_F : STD_LOGIC; 
  signal N30854_G : STD_LOGIC; 
  signal N30872_F : STD_LOGIC; 
  signal N30872_G : STD_LOGIC; 
  signal CHOICE1071_F : STD_LOGIC; 
  signal CHOICE1071_G : STD_LOGIC; 
  signal CHOICE789_F : STD_LOGIC; 
  signal CHOICE789_G : STD_LOGIC; 
  signal Cpu16_I4_n0215_G : STD_LOGIC; 
  signal Cpu16_I3_data_x_0_F : STD_LOGIC; 
  signal Cpu16_I3_data_x_0_G : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_2_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_2_FXMUX : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_2_F : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_2_G : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_2_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_2_CEINV : STD_LOGIC; 
  signal CHOICE1489_F : STD_LOGIC; 
  signal CHOICE1489_G : STD_LOGIC; 
  signal Cpu16_I4_n0157_G : STD_LOGIC; 
  signal CHOICE1126_F : STD_LOGIC; 
  signal CHOICE1126_G : STD_LOGIC; 
  signal N30653_F : STD_LOGIC; 
  signal N30653_G : STD_LOGIC; 
  signal N30371_F : STD_LOGIC; 
  signal N30371_G : STD_LOGIC; 
  signal CHOICE1380_F : STD_LOGIC; 
  signal CHOICE1380_G : STD_LOGIC; 
  signal Cpu16_I2_TD_c_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_TD_c_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_TD_c_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_TD_c_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_DYMUX : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_CLKINV : STD_LOGIC; 
  signal CHOICE1023_F : STD_LOGIC; 
  signal CHOICE1023_G : STD_LOGIC; 
  signal CHOICE1137_F : STD_LOGIC; 
  signal CHOICE1137_G : STD_LOGIC; 
  signal N30860_F : STD_LOGIC; 
  signal N30860_G : STD_LOGIC; 
  signal CHOICE816_F : STD_LOGIC; 
  signal CHOICE816_G : STD_LOGIC; 
  signal CHOICE1192_F : STD_LOGIC; 
  signal CHOICE1192_G : STD_LOGIC; 
  signal CHOICE925_F : STD_LOGIC; 
  signal CHOICE925_G : STD_LOGIC; 
  signal CHOICE981_F : STD_LOGIC; 
  signal CHOICE981_G : STD_LOGIC; 
  signal CHOICE847_F : STD_LOGIC; 
  signal CHOICE847_G : STD_LOGIC; 
  signal CHOICE968_F : STD_LOGIC; 
  signal CHOICE968_G : STD_LOGIC; 
  signal CHOICE1027_F : STD_LOGIC; 
  signal CHOICE1027_G : STD_LOGIC; 
  signal N30878_F : STD_LOGIC; 
  signal N30878_G : STD_LOGIC; 
  signal NRE_EXT_OBUF_G : STD_LOGIC; 
  signal CHOICE878_F : STD_LOGIC; 
  signal CHOICE878_G : STD_LOGIC; 
  signal CHOICE972_F : STD_LOGIC; 
  signal CHOICE972_G : STD_LOGIC; 
  signal CHOICE933_F : STD_LOGIC; 
  signal CHOICE933_G : STD_LOGIC; 
  signal CHOICE1601_F : STD_LOGIC; 
  signal CHOICE1601_G : STD_LOGIC; 
  signal N30631_F : STD_LOGIC; 
  signal N30631_G : STD_LOGIC; 
  signal CHOICE988_F : STD_LOGIC; 
  signal CHOICE988_G : STD_LOGIC; 
  signal N30311_F : STD_LOGIC; 
  signal N30311_G : STD_LOGIC; 
  signal XLXI_3_daddr_c_0_DXMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_0_FXMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_0_F : STD_LOGIC; 
  signal XLXI_3_daddr_c_0_G : STD_LOGIC; 
  signal XLXI_3_daddr_c_0_SRINVNOT : STD_LOGIC; 
  signal XLXI_3_daddr_c_0_CLKINV : STD_LOGIC; 
  signal XLXI_3_daddr_c_0_CEINV : STD_LOGIC; 
  signal CHOICE1043_F : STD_LOGIC; 
  signal CHOICE1043_G : STD_LOGIC; 
  signal CHOICE1146_F : STD_LOGIC; 
  signal CHOICE1146_G : STD_LOGIC; 
  signal CHOICE1082_F : STD_LOGIC; 
  signal CHOICE1098_F : STD_LOGIC; 
  signal CHOICE1098_G : STD_LOGIC; 
  signal CHOICE1016_F : STD_LOGIC; 
  signal CHOICE1016_G : STD_LOGIC; 
  signal CHOICE1133_F : STD_LOGIC; 
  signal CHOICE1153_F : STD_LOGIC; 
  signal CHOICE1153_G : STD_LOGIC; 
  signal N30866_F : STD_LOGIC; 
  signal N30866_G : STD_LOGIC; 
  signal CHOICE52_F : STD_LOGIC; 
  signal CHOICE52_G : STD_LOGIC; 
  signal Cpu16_I3_N17531_F : STD_LOGIC; 
  signal Cpu16_I3_N17531_G : STD_LOGIC; 
  signal CHOICE1208_F : STD_LOGIC; 
  signal CHOICE1208_G : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_11_DXMUX : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_11_G : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_11_CLKINVNOT : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_11_CEINV : STD_LOGIC; 
  signal Cpu16_I2_S_c_2_DXMUX : STD_LOGIC; 
  signal Cpu16_I2_S_c_2_G : STD_LOGIC; 
  signal Cpu16_I2_S_c_2_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I2_S_c_2_CLKINV : STD_LOGIC; 
  signal XLXI_5_Msub_n0011_inst_lut2_14_G : STD_LOGIC; 
  signal XLXI_3_daddr_c_1_DXMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_1_FXMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_1_F : STD_LOGIC; 
  signal XLXI_3_daddr_c_1_G : STD_LOGIC; 
  signal XLXI_3_daddr_c_1_SRINVNOT : STD_LOGIC; 
  signal XLXI_3_daddr_c_1_CLKINV : STD_LOGIC; 
  signal XLXI_3_daddr_c_1_CEINV : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_1_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_1_FXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_1_F : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_1_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_1_G : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_1_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_1_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_3_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_3_FXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_3_F : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_3_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_3_G : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_3_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_3_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_5_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_5_FXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_5_F : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_5_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_5_G : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_5_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_5_CLKINV : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_7_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_7_FXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_7_F : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_7_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_7_G : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_7_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_7_CLKINV : STD_LOGIC; 
  signal XLXI_5_N12936_F : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_9_DXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_9_FXMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_9_F : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_9_DYMUX : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_9_G : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_9_SRINVNOT : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_9_CLKINV : STD_LOGIC; 
  signal ADDR_OUT_EXT_3_OBUF_F : STD_LOGIC; 
  signal ADDR_OUT_EXT_3_OBUF_G : STD_LOGIC; 
  signal XLXI_3_daddr_c_2_DXMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_2_FXMUX : STD_LOGIC; 
  signal XLXI_3_daddr_c_2_F : STD_LOGIC; 
  signal XLXI_3_daddr_c_2_G : STD_LOGIC; 
  signal XLXI_3_daddr_c_2_SRINVNOT : STD_LOGIC; 
  signal XLXI_3_daddr_c_2_CLKINV : STD_LOGIC; 
  signal XLXI_3_daddr_c_2_CEINV : STD_LOGIC; 
  signal CHOICE4_F : STD_LOGIC; 
  signal CHOICE4_G : STD_LOGIC; 
  signal CHOICE1181_F : STD_LOGIC; 
  signal CHOICE1181_G : STD_LOGIC; 
  signal N30661_F : STD_LOGIC; 
  signal N30661_G : STD_LOGIC; 
  signal N30365_F : STD_LOGIC; 
  signal N30365_G : STD_LOGIC; 
  signal CHOICE961_F : STD_LOGIC; 
  signal CHOICE961_G : STD_LOGIC; 
  signal N31289_F : STD_LOGIC; 
  signal N31289_G : STD_LOGIC; 
  signal XLXI_5_n0032_F : STD_LOGIC; 
  signal XLXI_5_n0032_G : STD_LOGIC; 
  signal N30625_F : STD_LOGIC; 
  signal N30625_G : STD_LOGIC; 
  signal N30305_F : STD_LOGIC; 
  signal N30305_G : STD_LOGIC; 
  signal N31114_F : STD_LOGIC; 
  signal N31114_G : STD_LOGIC; 
  signal CHOICE1608_F : STD_LOGIC; 
  signal Cpu16_I4_Madd_n0182_inst_lut2_71_G : STD_LOGIC; 
  signal N30637_F : STD_LOGIC; 
  signal N30637_G : STD_LOGIC; 
  signal CHOICE1616_F : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_3_DXMUX : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_3_G : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_3_CLKINV : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_3_CEINV : STD_LOGIC; 
  signal N30359_F : STD_LOGIC; 
  signal N30359_G : STD_LOGIC; 
  signal N30295_F : STD_LOGIC; 
  signal N30295_G : STD_LOGIC; 
  signal ADDR_OUT_EXT_4_OBUF_F : STD_LOGIC; 
  signal ADDR_OUT_EXT_4_OBUF_G : STD_LOGIC; 
  signal ADDR_OUT_EXT_5_OBUF_F : STD_LOGIC; 
  signal ADDR_OUT_EXT_5_OBUF_G : STD_LOGIC; 
  signal Cpu16_I2_idata_c_15_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_idata_c_15_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_idata_c_11_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_idata_c_11_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_idata_c_13_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_idata_c_13_FFX_RST : STD_LOGIC; 
  signal ADDR_OUT_EXT_7_OBUF_F : STD_LOGIC; 
  signal ADDR_OUT_EXT_7_OBUF_G : STD_LOGIC; 
  signal N30299_F : STD_LOGIC; 
  signal N30299_G : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_0_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_3_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_3_FFX_RST : STD_LOGIC; 
  signal NCS_EXT_OUTPUT_OTCLK1INV : STD_LOGIC; 
  signal XLXI_2_nCS_EXT_c : STD_LOGIC; 
  signal NCS_EXT_OUTPUT_OFF_OSR_USED : STD_LOGIC; 
  signal NCS_EXT_OUTPUT_OFF_O1INV : STD_LOGIC; 
  signal NCS_EXT_OUTPUT_OFF_OFF1_SET : STD_LOGIC; 
  signal Cpu16_I1_pc_8_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_int_stop_c_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_5_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_5_FFX_RST : STD_LOGIC; 
  signal Cpu16_I1_pc_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_7_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_11_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_11_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_TC_c_1_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_TC_c_1_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_9_FFX_RST : STD_LOGIC; 
  signal NWE_EXT_OUTPUT_OTCLK1INV : STD_LOGIC; 
  signal XLXI_5_ndwe_c : STD_LOGIC; 
  signal NWE_EXT_OUTPUT_OFF_OSR_USED : STD_LOGIC; 
  signal NWE_EXT_OUTPUT_OFF_OCEINVNOT : STD_LOGIC; 
  signal NWE_EXT_OUTPUT_OFF_O1INV : STD_LOGIC; 
  signal NWE_EXT_OUTPUT_OFF_OFF1_SET : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_5_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_6_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_7_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_8_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_10_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_i_2_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_7_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_9_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_c_9_FFX_RST : STD_LOGIC; 
  signal Cpu16_I1_pc_2_FFX_RST : STD_LOGIC; 
  signal Cpu16_I1_pc_3_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd3_FFY_RST : STD_LOGIC; 
  signal Cpu16_I1_pc_10_FFX_RST : STD_LOGIC; 
  signal Cpu16_I1_pc_7_FFX_RST : STD_LOGIC; 
  signal Cpu16_I1_pc_11_FFX_RST : STD_LOGIC; 
  signal Cpu16_I1_pc_5_FFX_RST : STD_LOGIC; 
  signal Cpu16_I1_pc_6_FFX_RST : STD_LOGIC; 
  signal XLXI_4_addr_c_7_FFX_SET : STD_LOGIC; 
  signal XLXI_2_mux_c_0_FFY_RST : STD_LOGIC; 
  signal XLXI_2_mux_c_0_FFX_RST : STD_LOGIC; 
  signal Cpu16_I1_pc_0_FFX_RST : STD_LOGIC; 
  signal XLXI_5_nwait_c_0_FFX_SET : STD_LOGIC; 
  signal XLXI_5_nwait_c_1_FFY_SET : STD_LOGIC; 
  signal XLXI_5_nwait_c_3_FFY_SET : STD_LOGIC; 
  signal XLXI_5_nwait_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_5_nwait_c_5_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_8_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_8_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_2_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_TC_c_0_FFY_RST : STD_LOGIC; 
  signal Cpu16_I1_pc_4_FFX_RST : STD_LOGIC; 
  signal XLXI_3_a2vi_s_0_FFY_RST : STD_LOGIC; 
  signal XLXI_3_nadwe_c_FFY_SET : STD_LOGIC; 
  signal XLXI_4_addr_c_1_FFX_SET : STD_LOGIC; 
  signal XLXI_5_nwait_c_5_FFX_RST : STD_LOGIC; 
  signal XLXI_5_nwait_c_7_FFY_RST : STD_LOGIC; 
  signal XLXI_5_nwait_c_7_FFX_RST : STD_LOGIC; 
  signal XLXI_4_addr_c_0_FFY_SET : STD_LOGIC; 
  signal XLXI_2_nWE_RAM_c_FFY_SET : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_12_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_14_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_15_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_skip_c_FFY_RST : STD_LOGIC; 
  signal XLXI_5_ndre_c_FFX_SET : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_11_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_11_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_11_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_11_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_0_FFY_RST : STD_LOGIC; 
  signal XLXI_4_addr_c_3_FFY_SET : STD_LOGIC; 
  signal XLXI_4_addr_c_3_FFX_SET : STD_LOGIC; 
  signal XLXI_4_addr_c_5_FFY_SET : STD_LOGIC; 
  signal XLXI_4_addr_c_5_FFX_SET : STD_LOGIC; 
  signal XLXI_4_addr_c_6_FFY_SET : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_0_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_0_FFX_RST : STD_LOGIC; 
  signal Cpu16_I1_pc_9_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_6_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_4_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_6_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_0_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_3_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_3_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_5_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_16_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_2_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_2_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_4_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_TD_c_0_3_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_3_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_3_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_5_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_5_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_7_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_7_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_10_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_10_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_i_0_12_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_7_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_9_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_9_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_we_c_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_ireg_we_c_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_3_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_5_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_5_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_7_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_7_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_9_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_9_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_0_FFY_RST : STD_LOGIC; 
  signal XLXI_3_daddr_c_5_FFX_RST : STD_LOGIC; 
  signal XLXI_3_daddr_c_7_FFY_RST : STD_LOGIC; 
  signal XLXI_3_daddr_c_7_FFX_RST : STD_LOGIC; 
  signal XLXI_3_daddr_c_8_FFY_RST : STD_LOGIC; 
  signal XLXI_3_daddr_c_3_FFY_RST : STD_LOGIC; 
  signal XLXI_3_daddr_c_5_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_3_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_3_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_5_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_5_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_c_7_FFY_RST : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_5_FFX_RST : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_7_FFY_RST : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_7_FFX_RST : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_9_FFY_RST : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_9_FFX_RST : STD_LOGIC; 
  signal Cpu16_I1_nreset_v_0_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_9_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_2_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_5_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_3_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_5_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_5_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_7_FFY_RST : STD_LOGIC; 
  signal XLXI_3_dwait_c_FFY_RST : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_3_FFY_RST : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_3_FFX_RST : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_5_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_11_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_data_is_c_11_FFX_RST : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_10_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_TC_c_2_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_TC_c_2_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd4_FFY_SET : STD_LOGIC; 
  signal Cpu16_I4_iinc_we_c_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_TC_c_0_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_nreset_v_0_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_11_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_11_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_nreset_v_0_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_nreset_v_0_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_11_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_11_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_5_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_7_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_7_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_c_9_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_5_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_7_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_7_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_9_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_9_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_E_c_FFd2_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_TD_c_0_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_TD_c_0_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_TD_c_3_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_TD_c_3_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_nreset_v_1_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_TD_c_1_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_TD_c_1_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_iinc_i_3_FFX_RST : STD_LOGIC; 
  signal Cpu16_I1_nreset_v_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_15_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_16_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_idata_c_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_idata_c_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_idata_c_3_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_idata_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_9_FFY_RST : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_9_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_skip_i_FFX_RST : STD_LOGIC; 
  signal Cpu16_I4_nreset_v_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_valid_c_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_nreset_v_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_11_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_11_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_13_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_15_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_13_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_S_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_1_FFY_RST : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_1_FFX_RST : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_3_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_nreset_v_1_FFY_RST : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_3_FFX_RST : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_5_FFY_RST : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_5_FFX_RST : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_7_FFY_RST : STD_LOGIC; 
  signal XLXI_5_cpu_daddr_c_7_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_TD_c_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_TD_c_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_TD_c_2_FFY_RST : STD_LOGIC; 
  signal Cpu16_I4_data_exp_i_2_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_idata_c_5_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_idata_c_5_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_idata_c_7_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_idata_c_7_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_idata_c_9_FFY_RST : STD_LOGIC; 
  signal Cpu16_I2_idata_c_9_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_9_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_9_FFX_RST : STD_LOGIC; 
  signal XLXI_3_daddr_c_2_FFX_RST : STD_LOGIC; 
  signal XLXI_3_daddr_c_0_FFX_RST : STD_LOGIC; 
  signal Cpu16_I1_eaddr_x_11_FFX_RST : STD_LOGIC; 
  signal Cpu16_I2_S_c_2_FFX_RST : STD_LOGIC; 
  signal XLXI_3_daddr_c_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_1_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_1_FFX_RST : STD_LOGIC; 
  signal Cpu16_I3_acc_c_0_3_FFY_RST : STD_LOGIC; 
  signal Cpu16_I3_n0090_16_XORF : STD_LOGIC; 
  signal Cpu16_I3_n0090_16_CYINIT : STD_LOGIC; 
  signal Cpu16_I3_n0090_16_F : STD_LOGIC; 
  signal PWR_GND_0_G : STD_LOGIC; 
  signal PWR_GND_1_G : STD_LOGIC; 
  signal PWR_GND_2_G : STD_LOGIC; 
  signal VCC : STD_LOGIC; 
  signal GND : STD_LOGIC; 
  signal NlwInverterSignal_Cpu16_I1_eaddr_x_5_CLK : STD_LOGIC; 
  signal NlwInverterSignal_Cpu16_I1_eaddr_x_6_CLK : STD_LOGIC; 
  signal NlwInverterSignal_Cpu16_I1_eaddr_x_7_CLK : STD_LOGIC; 
  signal NlwInverterSignal_Cpu16_I1_eaddr_x_8_CLK : STD_LOGIC; 
  signal NlwInverterSignal_Cpu16_I1_eaddr_x_9_CLK : STD_LOGIC; 
  signal NlwInverterSignal_Cpu16_I1_eaddr_x_0_CLK : STD_LOGIC; 
  signal NlwInverterSignal_Cpu16_I1_eaddr_x_1_CLK : STD_LOGIC; 
  signal NlwInverterSignal_Cpu16_I1_eaddr_x_2_CLK : STD_LOGIC; 
  signal NlwInverterSignal_Cpu16_I1_eaddr_x_3_CLK : STD_LOGIC; 
  signal NlwInverterSignal_Cpu16_I1_eaddr_x_4_CLK : STD_LOGIC; 
  signal NlwInverterSignal_Cpu16_I1_eaddr_x_10_CLK : STD_LOGIC; 
  signal NlwInverterSignal_Cpu16_I1_eaddr_x_11_CLK : STD_LOGIC; 
  signal XLXI_4_addr_c : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal Cpu16_pc_mux : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal XLXI_4_n0005 : STD_LOGIC_VECTOR ( 15 downto 9 ); 
  signal Cpu16_I1_pc : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Cpu16_I1_n0009 : STD_LOGIC_VECTOR ( 11 downto 1 ); 
  signal XLXI_5_nwait_c : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXI_5_n0011 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal Cpu16_I2_data_is_c : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Cpu16_I3_n0098 : STD_LOGIC_VECTOR ( 15 downto 1 ); 
  signal Cpu16_I3_n0089 : STD_LOGIC_VECTOR ( 16 downto 16 ); 
  signal Cpu16_I3_n0090 : STD_LOGIC_VECTOR ( 16 downto 0 ); 
  signal Cpu16_I4_iinc_c : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Cpu16_I4_ireg_c : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Cpu16_I4_n0182 : STD_LOGIC_VECTOR ( 11 downto 1 ); 
  signal XLXI_5_dw_s : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal MADDR : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal MEM_DATA_OUT : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal XLXN_19 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal XLXN_14 : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal XLXN_20 : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Cpu16_I4_ireg_x : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Cpu16_I4_ireg_i : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Cpu16_I2_idata_c : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal Cpu16_I2_TD_c : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal Cpu16_I2_TC_c : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal CPU_IADDR_OUT : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal XLXI_3_daddr_c : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal CPU_ADADDR_OUT : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal Cpu16_I4_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal Cpu16_I2_idata_x : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal Cpu16_daddr_is : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Cpu16_I2_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_3_a2vi_s : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal Cpu16_I2_n0166 : STD_LOGIC_VECTOR ( 2 downto 2 ); 
  signal Cpu16_I1_eaddr_x : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Cpu16_I2_TC_x : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal XLXI_2_mux_c : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal Cpu16_I3_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal XLXI_5_cpu_daddr_c : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal Cpu16_I1_nreset_v : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal Cpu16_I4_data_exp_c : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Cpu16_data_is_int : STD_LOGIC_VECTOR ( 15 downto 12 ); 
  signal Cpu16_I3_acc : STD_LOGIC_VECTOR2 ( 0 downto 0 , 16 downto 0 ); 
  signal Cpu16_I2_S_c : STD_LOGIC_VECTOR ( 2 downto 1 ); 
  signal Cpu16_I4_data_exp_i : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Cpu16_I4_iinc_i : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Cpu16_I2_TD_x : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal Cpu16_I4_n0160 : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Cpu16_I4_iadata_x : STD_LOGIC_VECTOR ( 23 downto 16 ); 
  signal Cpu16_I1_n0008 : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Cpu16_I1_n0006 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal Cpu16_I2_n0076 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal Cpu16_I4_n0159 : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Cpu16_I3_n0022 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal Cpu16_I4_n0161 : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal Cpu16_I4_iinc_x : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Cpu16_I2_n0073 : STD_LOGIC_VECTOR ( 2 downto 1 ); 
begin
  Cpu16_I4_ireg_i_9_DXMUX_0 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_9_FXMUX,
      O => Cpu16_I4_ireg_i_9_DXMUX
    );
  Cpu16_I4_ireg_i_9_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_9_FXMUX,
      O => Cpu16_I4_ireg_x(9)
    );
  Cpu16_I4_ireg_i_9_FXMUX_1 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_9_F5MUX,
      O => Cpu16_I4_ireg_i_9_FXMUX
    );
  Cpu16_I4_ireg_i_9_F5MUX_2 : X_MUX2
    port map (
      IA => N32076,
      IB => N32078,
      SEL => Cpu16_I4_ireg_i_9_BXINV,
      O => Cpu16_I4_ireg_i_9_F5MUX
    );
  Cpu16_I4_ireg_i_9_BXINV_3 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18033,
      O => Cpu16_I4_ireg_i_9_BXINV
    );
  Cpu16_I4_ireg_i_9_CLKINV_4 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_i_9_CLKINV
    );
  Cpu16_I4_ireg_i_9_CEINV_5 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_ireg_i_9_CEINV
    );
  Cpu16_I2_n0142_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n0142_F5MUX,
      O => Cpu16_I2_n0142
    );
  Cpu16_I2_n0142_F5MUX_6 : X_MUX2
    port map (
      IA => N32036,
      IB => N32038,
      SEL => Cpu16_I2_n0142_BXINV,
      O => Cpu16_I2_n0142_F5MUX
    );
  Cpu16_I2_n0142_BXINV_7 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n0150,
      O => Cpu16_I2_n0142_BXINV
    );
  N31122_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31122_F5MUX,
      O => N31122
    );
  N31122_F5MUX_8 : X_MUX2
    port map (
      IA => N32156,
      IB => N32158,
      SEL => N31122_BXINV,
      O => N31122_F5MUX
    );
  N31122_BXINV_9 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1587,
      O => N31122_BXINV
    );
  MADDR_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MADDR_0_F5MUX,
      O => MADDR(0)
    );
  MADDR_0_F5MUX_10 : X_MUX2
    port map (
      IA => N32131,
      IB => N32133,
      SEL => MADDR_0_BXINV,
      O => MADDR_0_F5MUX
    );
  MADDR_0_BXINV_11 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_IADDR_OUT(0),
      O => MADDR_0_BXINV
    );
  N31168_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31168_F5MUX,
      O => N31168
    );
  N31168_F5MUX_12 : X_MUX2
    port map (
      IA => N32081,
      IB => N32083,
      SEL => N31168_BXINV,
      O => N31168_F5MUX
    );
  N31168_BXINV_13 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_pc_mux(0),
      O => N31168_BXINV
    );
  CHOICE1534_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1534_F5MUX,
      O => CHOICE1534
    );
  CHOICE1534_F5MUX_14 : X_MUX2
    port map (
      IA => N32026,
      IB => N32028,
      SEL => CHOICE1534_BXINV,
      O => CHOICE1534_F5MUX
    );
  CHOICE1534_BXINV_15 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n01501_2,
      O => CHOICE1534_BXINV
    );
  MADDR_1_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MADDR_1_F5MUX,
      O => MADDR(1)
    );
  MADDR_1_F5MUX_16 : X_MUX2
    port map (
      IA => N32031,
      IB => N32033,
      SEL => MADDR_1_BXINV,
      O => MADDR_1_F5MUX
    );
  MADDR_1_BXINV_17 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_IADDR_OUT(1),
      O => MADDR_1_BXINV
    );
  MADDR_2_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MADDR_2_F5MUX,
      O => MADDR(2)
    );
  MADDR_2_F5MUX_18 : X_MUX2
    port map (
      IA => N32066,
      IB => N32068,
      SEL => MADDR_2_BXINV,
      O => MADDR_2_F5MUX
    );
  MADDR_2_BXINV_19 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_IADDR_OUT(2),
      O => MADDR_2_BXINV
    );
  CHOICE737_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE737_F5MUX,
      O => CHOICE737
    );
  CHOICE737_F5MUX_20 : X_MUX2
    port map (
      IA => N32041,
      IB => N32043,
      SEL => CHOICE737_BXINV,
      O => CHOICE737_F5MUX
    );
  CHOICE737_BXINV_21 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_c(1),
      O => CHOICE737_BXINV
    );
  N31164_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31164_F5MUX,
      O => N31164
    );
  N31164_F5MUX_22 : X_MUX2
    port map (
      IA => N32161,
      IB => N32163,
      SEL => N31164_BXINV,
      O => N31164_F5MUX
    );
  N31164_BXINV_23 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_pc_mux(0),
      O => N31164_BXINV
    );
  Cpu16_I3_N17260_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_N17260_F5MUX,
      O => Cpu16_I3_N17260
    );
  Cpu16_I3_N17260_F5MUX_24 : X_MUX2
    port map (
      IA => N32046,
      IB => N32048,
      SEL => Cpu16_I3_N17260_BXINV,
      O => Cpu16_I3_N17260_F5MUX
    );
  Cpu16_I3_N17260_BXINV_25 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0087,
      O => Cpu16_I3_N17260_BXINV
    );
  MADDR_3_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MADDR_3_F5MUX,
      O => MADDR(3)
    );
  MADDR_3_F5MUX_26 : X_MUX2
    port map (
      IA => N32101,
      IB => N32103,
      SEL => MADDR_3_BXINV,
      O => MADDR_3_F5MUX
    );
  MADDR_3_BXINV_27 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_IADDR_OUT(3),
      O => MADDR_3_BXINV
    );
  MADDR_4_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MADDR_4_F5MUX,
      O => MADDR(4)
    );
  MADDR_4_F5MUX_28 : X_MUX2
    port map (
      IA => N32121,
      IB => N32123,
      SEL => MADDR_4_BXINV,
      O => MADDR_4_F5MUX
    );
  MADDR_4_BXINV_29 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_IADDR_OUT(4),
      O => MADDR_4_BXINV
    );
  MADDR_5_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MADDR_5_F5MUX,
      O => MADDR(5)
    );
  MADDR_5_F5MUX_30 : X_MUX2
    port map (
      IA => N32126,
      IB => N32128,
      SEL => MADDR_5_BXINV,
      O => MADDR_5_F5MUX
    );
  MADDR_5_BXINV_31 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_IADDR_OUT(5),
      O => MADDR_5_BXINV
    );
  MADDR_6_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MADDR_6_F5MUX,
      O => MADDR(6)
    );
  MADDR_6_F5MUX_32 : X_MUX2
    port map (
      IA => N32146,
      IB => N32148,
      SEL => MADDR_6_BXINV,
      O => MADDR_6_F5MUX
    );
  MADDR_6_BXINV_33 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_IADDR_OUT(6),
      O => MADDR_6_BXINV
    );
  MADDR_7_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MADDR_7_F5MUX,
      O => MADDR(7)
    );
  MADDR_7_F5MUX_34 : X_MUX2
    port map (
      IA => N32106,
      IB => N32108,
      SEL => MADDR_7_BXINV,
      O => MADDR_7_F5MUX
    );
  MADDR_7_BXINV_35 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_IADDR_OUT(7),
      O => MADDR_7_BXINV
    );
  MADDR_8_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MADDR_8_F5MUX,
      O => MADDR(8)
    );
  MADDR_8_F5MUX_36 : X_MUX2
    port map (
      IA => N32141,
      IB => N32143,
      SEL => MADDR_8_BXINV,
      O => MADDR_8_F5MUX
    );
  MADDR_8_BXINV_37 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_IADDR_OUT(8),
      O => MADDR_8_BXINV
    );
  N31988_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31988_F,
      O => N31988
    );
  N31988_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31988_G,
      O => N30361
    );
  N31405_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31405_F,
      O => N31405
    );
  N31405_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31405_G,
      O => Cpu16_I2_ndre_x1_SW5_SW0_SW0_SW1_O
    );
  N31914_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31914_F,
      O => N31914
    );
  N31914_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31914_G,
      O => N30355
    );
  N30970_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30970_F,
      O => N30970
    );
  N30970_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30970_G,
      O => Cpu16_I2_idata_x(0)
    );
  N30972_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30972_F,
      O => N30972
    );
  N30972_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30972_G,
      O => Cpu16_I2_idata_x(3)
    );
  N31058_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31058_F,
      O => N31058
    );
  N31058_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31058_G,
      O => N30420
    );
  Cpu16_I1_pc_0_DXMUX_38 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_0_FXMUX,
      O => Cpu16_I1_pc_0_DXMUX
    );
  Cpu16_I1_pc_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_0_FXMUX,
      O => CPU_IADDR_OUT(0)
    );
  Cpu16_I1_pc_0_FXMUX_39 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_0_F,
      O => Cpu16_I1_pc_0_FXMUX
    );
  Cpu16_I1_pc_0_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_0_G,
      O => Cpu16_I1_iaddr_x_0_5_O
    );
  Cpu16_I1_pc_0_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_pc_0_SRINVNOT
    );
  Cpu16_I1_pc_0_CLKINV_40 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I1_pc_0_CLKINV
    );
  N31060_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31060_F,
      O => N31060
    );
  N31060_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31060_G,
      O => Cpu16_I2_TC_x_0_SW0_SW3_SW0_O
    );
  Cpu16_I4_ireg_c_1_DXMUX_41 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Mmux_n0158_Result_1_1_O,
      O => Cpu16_I4_ireg_c_1_DXMUX
    );
  Cpu16_I4_ireg_c_1_DYMUX_42 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Mmux_n0158_Result_0_1_O,
      O => Cpu16_I4_ireg_c_1_DYMUX
    );
  Cpu16_I4_ireg_c_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_ireg_c_1_SRINVNOT
    );
  Cpu16_I4_ireg_c_1_CLKINV_43 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_c_1_CLKINV
    );
  Cpu16_I4_ireg_c_3_DXMUX_44 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Mmux_n0158_Result_3_1_O,
      O => Cpu16_I4_ireg_c_3_DXMUX
    );
  Cpu16_I4_ireg_c_3_DYMUX_45 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Mmux_n0158_Result_2_1_O,
      O => Cpu16_I4_ireg_c_3_DYMUX
    );
  Cpu16_I4_ireg_c_3_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_ireg_c_3_SRINVNOT
    );
  Cpu16_I4_ireg_c_3_CLKINV_46 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_c_3_CLKINV
    );
  N31968_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31968_F,
      O => N31968
    );
  N31968_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31968_G,
      O => N30349
    );
  Cpu16_I4_ireg_c_5_DXMUX_47 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Mmux_n0158_Result_5_1_O,
      O => Cpu16_I4_ireg_c_5_DXMUX
    );
  Cpu16_I4_ireg_c_5_DYMUX_48 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Mmux_n0158_Result_4_1_O,
      O => Cpu16_I4_ireg_c_5_DYMUX
    );
  Cpu16_I4_ireg_c_5_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_ireg_c_5_SRINVNOT
    );
  Cpu16_I4_ireg_c_5_CLKINV_49 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_c_5_CLKINV
    );
  Cpu16_I1_pc_1_DXMUX_50 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_1_FXMUX,
      O => Cpu16_I1_pc_1_DXMUX
    );
  Cpu16_I1_pc_1_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_1_FXMUX,
      O => CPU_IADDR_OUT(1)
    );
  Cpu16_I1_pc_1_FXMUX_51 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_1_F,
      O => Cpu16_I1_pc_1_FXMUX
    );
  Cpu16_I1_pc_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_1_G,
      O => Cpu16_I1_iaddr_x_1_5_O
    );
  Cpu16_I1_pc_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_pc_1_SRINVNOT
    );
  Cpu16_I1_pc_1_CLKINV_52 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I1_pc_1_CLKINV
    );
  Cpu16_I3_Msub_n0090_inst_lut2_27_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_lut2_27_F,
      O => Cpu16_I3_Msub_n0090_inst_lut2_27
    );
  Cpu16_I3_Msub_n0090_inst_lut2_27_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_lut2_27_G,
      O => Cpu16_I3_Mmux_data_x_Result_0_85_SW0_O
    );
  Cpu16_I4_ireg_c_7_DXMUX_53 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Mmux_n0158_Result_7_1_O,
      O => Cpu16_I4_ireg_c_7_DXMUX
    );
  Cpu16_I4_ireg_c_7_DYMUX_54 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Mmux_n0158_Result_6_1_O,
      O => Cpu16_I4_ireg_c_7_DYMUX
    );
  Cpu16_I4_ireg_c_7_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_ireg_c_7_SRINVNOT
    );
  Cpu16_I4_ireg_c_7_CLKINV_55 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_c_7_CLKINV
    );
  Cpu16_I4_ireg_c_9_DXMUX_56 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Mmux_n0158_Result_9_1_O,
      O => Cpu16_I4_ireg_c_9_DXMUX
    );
  Cpu16_I4_ireg_c_9_DYMUX_57 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Mmux_n0158_Result_8_1_O,
      O => Cpu16_I4_ireg_c_9_DYMUX
    );
  Cpu16_I4_ireg_c_9_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_ireg_c_9_SRINVNOT
    );
  Cpu16_I4_ireg_c_9_CLKINV_58 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_c_9_CLKINV
    );
  N31409_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31409_F,
      O => N31409
    );
  N31409_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31409_G,
      O => Cpu16_I2_ndre_x1_SW6_SW0_SW0_SW1_O
    );
  CHOICE497_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE497_F,
      O => CHOICE497
    );
  CHOICE497_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE497_G,
      O => Cpu16_I2_pc_mux_x_0_104_2
    );
  Cpu16_I1_pc_2_DXMUX_59 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_2_FXMUX,
      O => Cpu16_I1_pc_2_DXMUX
    );
  Cpu16_I1_pc_2_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_2_FXMUX,
      O => CPU_IADDR_OUT(2)
    );
  Cpu16_I1_pc_2_FXMUX_60 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_2_F,
      O => Cpu16_I1_pc_2_FXMUX
    );
  Cpu16_I1_pc_2_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_2_G,
      O => Cpu16_I1_iaddr_x_2_5_O
    );
  Cpu16_I1_pc_2_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_pc_2_SRINVNOT
    );
  Cpu16_I1_pc_2_CLKINV_61 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I1_pc_2_CLKINV
    );
  Cpu16_I1_pc_3_DXMUX_62 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_3_FXMUX,
      O => Cpu16_I1_pc_3_DXMUX
    );
  Cpu16_I1_pc_3_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_3_FXMUX,
      O => CPU_IADDR_OUT(3)
    );
  Cpu16_I1_pc_3_FXMUX_63 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_3_F,
      O => Cpu16_I1_pc_3_FXMUX
    );
  Cpu16_I1_pc_3_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_3_G,
      O => Cpu16_I1_N13702
    );
  Cpu16_I1_pc_3_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_pc_3_SRINVNOT
    );
  Cpu16_I1_pc_3_CLKINV_64 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I1_pc_3_CLKINV
    );
  Cpu16_I2_E_c_FFd3_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_E_c_FFd3_F,
      O => N31580
    );
  Cpu16_I2_E_c_FFd3_DYMUX_65 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_E_c_FFd3_GYMUX,
      O => Cpu16_I2_E_c_FFd3_DYMUX
    );
  Cpu16_I2_E_c_FFd3_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_E_c_FFd3_GYMUX,
      O => Cpu16_I2_n0062
    );
  Cpu16_I2_E_c_FFd3_GYMUX_66 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_E_c_FFd3_G,
      O => Cpu16_I2_E_c_FFd3_GYMUX
    );
  Cpu16_I2_E_c_FFd3_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_E_c_FFd3_SRINVNOT
    );
  Cpu16_I2_E_c_FFd3_CLKINV_67 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_E_c_FFd3_CLKINV
    );
  Cpu16_I1_pc_4_DXMUX_68 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_4_FXMUX,
      O => Cpu16_I1_pc_4_DXMUX
    );
  Cpu16_I1_pc_4_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_4_FXMUX,
      O => CPU_IADDR_OUT(4)
    );
  Cpu16_I1_pc_4_FXMUX_69 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_4_F,
      O => Cpu16_I1_pc_4_FXMUX
    );
  Cpu16_I1_pc_4_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_4_G,
      O => Cpu16_I1_iaddr_x_4_14_O
    );
  Cpu16_I1_pc_4_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_pc_4_SRINVNOT
    );
  Cpu16_I1_pc_4_CLKINV_70 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I1_pc_4_CLKINV
    );
  CHOICE558_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE558_F,
      O => CHOICE558
    );
  CHOICE558_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE558_G,
      O => Cpu16_I2_pc_mux_x_2_46_2
    );
  N31938_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31938_F,
      O => N31938
    );
  N31938_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31938_G,
      O => N30343
    );
  XLXI_3_a2vi_s_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_a2vi_s_0_F,
      O => XLXI_3_nadwe_c_N1214
    );
  XLXI_3_a2vi_s_0_DYMUX_71 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_n0006_O,
      O => XLXI_3_a2vi_s_0_DYMUX
    );
  XLXI_3_a2vi_s_0_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_3_a2vi_s_0_SRINVNOT
    );
  XLXI_3_a2vi_s_0_CLKINV_72 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_3_a2vi_s_0_CLKINV
    );
  Cpu16_I1_pc_5_DXMUX_73 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_5_FXMUX,
      O => Cpu16_I1_pc_5_DXMUX
    );
  Cpu16_I1_pc_5_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_5_FXMUX,
      O => CPU_IADDR_OUT(5)
    );
  Cpu16_I1_pc_5_FXMUX_74 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_5_F,
      O => Cpu16_I1_pc_5_FXMUX
    );
  Cpu16_I1_pc_5_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_5_G,
      O => Cpu16_I1_iaddr_x_5_14_O
    );
  Cpu16_I1_pc_5_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_pc_5_SRINVNOT
    );
  Cpu16_I1_pc_5_CLKINV_75 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I1_pc_5_CLKINV
    );
  XLXN_14_10_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_10_F,
      O => XLXN_14(10)
    );
  XLXN_14_10_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_10_G,
      O => Cpu16_I1_Mmux_saddr_out_Result_10_6_O
    );
  CHOICE589_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE589_F,
      O => CHOICE589
    );
  CHOICE589_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE589_G,
      O => CPU_NDRE
    );
  Cpu16_I2_n01421_F : X_LUT4
    generic map(
      INIT => X"4400"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(5),
      ADR1 => Cpu16_I2_idata_c(7),
      ADR2 => VCC,
      ADR3 => Cpu16_I2_idata_c(6),
      O => N32036
    );
  Cpu16_I3_skip_l86_SW11_F : X_LUT4
    generic map(
      INIT => X"BFBF"
    )
    port map (
      ADR0 => Cpu16_I2_int_start_c,
      ADR1 => Cpu16_I3_skip_i,
      ADR2 => Cpu16_I2_TC_c(2),
      ADR3 => VCC,
      O => N32156
    );
  Cpu16_I1_iaddr_x_1_44_SW01_F : X_LUT4
    generic map(
      INIT => X"AFA0"
    )
    port map (
      ADR0 => MEM_DATA_OUT(5),
      ADR1 => VCC,
      ADR2 => Cpu16_pc_mux(1),
      ADR3 => Cpu16_I1_pc(1),
      O => N32081
    );
  XLXI_3_maddr_0_16_F : X_LUT4
    generic map(
      INIT => X"8F80"
    )
    port map (
      ADR0 => XLXI_3_N12472,
      ADR1 => XLXI_3_daddr_c(0),
      ADR2 => CPU_NDRE,
      ADR3 => CPU_ADADDR_OUT(0),
      O => N32131
    );
  XLXI_3_maddr_2_16_F : X_LUT4
    generic map(
      INIT => X"CA0A"
    )
    port map (
      ADR0 => CPU_ADADDR_OUT(2),
      ADR1 => XLXI_3_N12472,
      ADR2 => CPU_NDRE,
      ADR3 => XLXI_3_daddr_c(2),
      O => N32066
    );
  Cpu16_I3_n0147_0_130_F : X_LUT4
    generic map(
      INIT => X"6240"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_0_3,
      ADR1 => Cpu16_I2_TD_c_2_3,
      ADR2 => Cpu16_I3_acc_c_0_1,
      ADR3 => Cpu16_I3_acc_c_0_16,
      O => N32041
    );
  Cpu16_I1_iaddr_x_2_44_SW01_F : X_LUT4
    generic map(
      INIT => X"F3C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_pc_mux(1),
      ADR2 => MEM_DATA_OUT(6),
      ADR3 => Cpu16_I1_pc(2),
      O => N32161
    );
  XLXI_3_maddr_4_161_F : X_LUT4
    generic map(
      INIT => X"8F80"
    )
    port map (
      ADR0 => XLXI_3_N12472,
      ADR1 => XLXI_3_daddr_c(4),
      ADR2 => CPU_NDRE,
      ADR3 => CPU_ADADDR_OUT(4),
      O => N32121
    );
  XLXI_3_maddr_5_161_F : X_LUT4
    generic map(
      INIT => X"E444"
    )
    port map (
      ADR0 => CPU_NDRE,
      ADR1 => CPU_ADADDR_OUT(5),
      ADR2 => XLXI_3_daddr_c(5),
      ADR3 => XLXI_3_N12472,
      O => N32126
    );
  XLXI_3_maddr_6_161_F : X_LUT4
    generic map(
      INIT => X"8F80"
    )
    port map (
      ADR0 => XLXI_3_N12472,
      ADR1 => XLXI_3_daddr_c(6),
      ADR2 => Cpu16_I4_ndre_x1_1,
      ADR3 => CPU_ADADDR_OUT(6),
      O => N32146
    );
  XLXI_3_maddr_7_161_F : X_LUT4
    generic map(
      INIT => X"AC0C"
    )
    port map (
      ADR0 => XLXI_3_N12472,
      ADR1 => CPU_ADADDR_OUT(7),
      ADR2 => Cpu16_I4_ndre_x1_1,
      ADR3 => XLXI_3_daddr_c(7),
      O => N32106
    );
  Cpu16_I3_n0147_5_72_SW1 : X_LUT4
    generic map(
      INIT => X"E200"
    )
    port map (
      ADR0 => N30659,
      ADR1 => CHOICE966,
      ADR2 => N30661,
      ADR3 => Cpu16_I3_n0023,
      O => N31988_G
    );
  Cpu16_I4_ndre_x1 : X_LUT4
    generic map(
      INIT => X"EAFF"
    )
    port map (
      ADR0 => Cpu16_ndre_int,
      ADR1 => Cpu16_I4_n0202,
      ADR2 => Cpu16_I4_n0203,
      ADR3 => Cpu16_I4_n0162,
      O => CHOICE589_G
    );
  Cpu16_I2_ndre_x1_SW5_SW0_SW0_SW1 : X_LUT4
    generic map(
      INIT => X"C800"
    )
    port map (
      ADR0 => MEM_DATA_OUT(2),
      ADR1 => Cpu16_I4_nreset_v(1),
      ADR2 => MEM_DATA_OUT(1),
      ADR3 => NRESET_IN_BUFGP,
      O => N31405_G
    );
  Cpu16_I3_n0147_6_72_SW1 : X_LUT4
    generic map(
      INIT => X"C840"
    )
    port map (
      ADR0 => CHOICE1021,
      ADR1 => Cpu16_I3_n0023,
      ADR2 => N30677,
      ADR3 => N30679,
      O => N31914_G
    );
  Cpu16_I2_Mmux_idata_x_Result_0_1 : X_LUT4
    generic map(
      INIT => X"CFC0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => MEM_DATA_OUT(0),
      ADR2 => Cpu16_I2_n0150,
      ADR3 => Cpu16_I2_idata_c(0),
      O => N30970_G
    );
  Cpu16_I2_n0103_SW1 : X_LUT4
    generic map(
      INIT => X"3533"
    )
    port map (
      ADR0 => N30966,
      ADR1 => N30964,
      ADR2 => MEM_DATA_OUT(3),
      ADR3 => MEM_DATA_OUT(0),
      O => N31058_G
    );
  Cpu16_I2_TC_x_0_SW0_SW3_SW0 : X_LUT4
    generic map(
      INIT => X"FFCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_idata_x(3),
      ADR2 => VCC,
      ADR3 => Cpu16_daddr_is(0),
      O => N31060_G
    );
  Cpu16_I3_Mmux_data_x_Result_0_85_SW0 : X_LUT4
    generic map(
      INIT => X"AA95"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_0,
      ADR1 => Cpu16_I4_n0202,
      ADR2 => N31890,
      ADR3 => CHOICE1520,
      O => Cpu16_I3_Msub_n0090_inst_lut2_27_G
    );
  Cpu16_I2_pc_mux_x_0_104_2_76 : X_LUT4
    generic map(
      INIT => X"33FB"
    )
    port map (
      ADR0 => CHOICE679,
      ADR1 => Cpu16_I2_nreset_v_1_1,
      ADR2 => CHOICE687,
      ADR3 => Cpu16_I2_n0145,
      O => CHOICE497_G
    );
  Cpu16_I2_pc_mux_x_2_46_2_77 : X_LUT4
    generic map(
      INIT => X"A0E0"
    )
    port map (
      ADR0 => Cpu16_I2_n0166(2),
      ADR1 => CHOICE660,
      ADR2 => CHOICE665,
      ADR3 => Cpu16_I2_Mmux_skip_x_Result1_1,
      O => CHOICE558_G
    );
  Cpu16_I1_iaddr_x_4_14 : X_LUT4
    generic map(
      INIT => X"3120"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_0_104_2,
      ADR1 => Cpu16_I2_pc_mux_x_1_44_2,
      ADR2 => Cpu16_I1_n0009(4),
      ADR3 => Cpu16_I1_pc(4),
      O => Cpu16_I1_pc_4_G
    );
  Cpu16_I3_n0147_8_72_SW1 : X_LUT4
    generic map(
      INIT => X"E200"
    )
    port map (
      ADR0 => N30605,
      ADR1 => CHOICE1131,
      ADR2 => N30607,
      ADR3 => Cpu16_I3_n0023,
      O => N31938_G
    );
  XLXI_4_Maddsub_n0001_inst_lut1_01 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => XLXI_4_addr_c(0),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_4_Maddsub_n0001_inst_lut1_0
    );
  XLXI_4_Maddsub_n0001_inst_lut2_01 : X_LUT4
    generic map(
      INIT => X"470F"
    )
    port map (
      ADR0 => XLXI_4_n00021_SW1_O,
      ADR1 => Cpu16_pc_mux(1),
      ADR2 => N30764,
      ADR3 => Cpu16_pc_mux(0),
      O => XLXI_4_Maddsub_n0001_inst_lut2_0
    );
  XLXI_4_n0005_9_CYMUXF : X_MUX2
    port map (
      IA => XLXI_4_n0005_9_CY0F,
      IB => XLXI_4_n0005_9_CYINIT,
      SEL => XLXI_4_n0005_9_CYSELF,
      O => XLXI_4_Maddsub_n0001_inst_cy_0
    );
  XLXI_4_n0005_9_CYINIT_78 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n0005_9_BXINVNOT,
      O => XLXI_4_n0005_9_CYINIT
    );
  XLXI_4_n0005_9_CY0F_79 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c(0),
      O => XLXI_4_n0005_9_CY0F
    );
  XLXI_4_n0005_9_CYSELF_80 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_Maddsub_n0001_inst_lut1_0,
      O => XLXI_4_n0005_9_CYSELF
    );
  XLXI_4_n0005_9_BXINV : X_INV
    port map (
      I => GLOBAL_LOGIC1_12,
      O => XLXI_4_n0005_9_BXINVNOT
    );
  XLXI_4_n0005_9_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n0005_9_XORG,
      O => XLXI_4_n0005(9)
    );
  XLXI_4_n0005_9_XORG_81 : X_XOR2
    port map (
      I0 => XLXI_4_Maddsub_n0001_inst_cy_0,
      I1 => XLXI_4_Maddsub_n0001_inst_lut2_0,
      O => XLXI_4_n0005_9_XORG
    );
  XLXI_4_n0005_9_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n0005_9_CYMUXG,
      O => XLXI_4_Maddsub_n0001_inst_cy_1
    );
  XLXI_4_n0005_9_CYMUXG_82 : X_MUX2
    port map (
      IA => XLXI_4_n0005_9_CY0G,
      IB => XLXI_4_Maddsub_n0001_inst_cy_0,
      SEL => XLXI_4_n0005_9_CYSELG,
      O => XLXI_4_n0005_9_CYMUXG
    );
  XLXI_4_n0005_9_CY0G_83 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c(1),
      O => XLXI_4_n0005_9_CY0G
    );
  XLXI_4_n0005_9_CYSELG_84 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_Maddsub_n0001_inst_lut2_0,
      O => XLXI_4_n0005_9_CYSELG
    );
  XLXI_4_Maddsub_n0001_inst_lut2_21 : X_LUT4
    generic map(
      INIT => X"1D55"
    )
    port map (
      ADR0 => N30776,
      ADR1 => Cpu16_pc_mux(1),
      ADR2 => XLXI_4_n00021_SW5_O,
      ADR3 => Cpu16_pc_mux(0),
      O => XLXI_4_Maddsub_n0001_inst_lut2_2
    );
  XLXI_4_n0005_10_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n0005_10_XORF,
      O => XLXI_4_n0005(10)
    );
  XLXI_4_n0005_10_XORF_85 : X_XOR2
    port map (
      I0 => XLXI_4_n0005_10_CYINIT,
      I1 => XLXI_4_Maddsub_n0001_inst_lut2_1,
      O => XLXI_4_n0005_10_XORF
    );
  XLXI_4_n0005_10_CYMUXF : X_MUX2
    port map (
      IA => XLXI_4_n0005_10_CY0F,
      IB => XLXI_4_n0005_10_CYINIT,
      SEL => XLXI_4_n0005_10_CYSELF,
      O => XLXI_4_Maddsub_n0001_inst_cy_2
    );
  XLXI_4_n0005_10_CYMUXF2_86 : X_MUX2
    port map (
      IA => XLXI_4_n0005_10_CY0F,
      IB => XLXI_4_n0005_10_CY0F,
      SEL => XLXI_4_n0005_10_CYSELF,
      O => XLXI_4_n0005_10_CYMUXF2
    );
  XLXI_4_n0005_10_CYINIT_87 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_Maddsub_n0001_inst_cy_1,
      O => XLXI_4_n0005_10_CYINIT
    );
  XLXI_4_n0005_10_CY0F_88 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c(2),
      O => XLXI_4_n0005_10_CY0F
    );
  XLXI_4_n0005_10_CYSELF_89 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_Maddsub_n0001_inst_lut2_1,
      O => XLXI_4_n0005_10_CYSELF
    );
  XLXI_4_n0005_10_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n0005_10_XORG,
      O => XLXI_4_n0005(11)
    );
  XLXI_4_n0005_10_XORG_90 : X_XOR2
    port map (
      I0 => XLXI_4_Maddsub_n0001_inst_cy_2,
      I1 => XLXI_4_Maddsub_n0001_inst_lut2_2,
      O => XLXI_4_n0005_10_XORG
    );
  XLXI_4_n0005_10_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n0005_10_CYMUXFAST,
      O => XLXI_4_Maddsub_n0001_inst_cy_3
    );
  XLXI_4_n0005_10_FASTCARRY_91 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_Maddsub_n0001_inst_cy_1,
      O => XLXI_4_n0005_10_FASTCARRY
    );
  XLXI_4_n0005_10_CYAND_92 : X_AND2
    port map (
      I0 => XLXI_4_n0005_10_CYSELG,
      I1 => XLXI_4_n0005_10_CYSELF,
      O => XLXI_4_n0005_10_CYAND
    );
  XLXI_4_n0005_10_CYMUXFAST_93 : X_MUX2
    port map (
      IA => XLXI_4_n0005_10_CYMUXG2,
      IB => XLXI_4_n0005_10_FASTCARRY,
      SEL => XLXI_4_n0005_10_CYAND,
      O => XLXI_4_n0005_10_CYMUXFAST
    );
  XLXI_4_n0005_10_CYMUXG2_94 : X_MUX2
    port map (
      IA => XLXI_4_n0005_10_CY0G,
      IB => XLXI_4_n0005_10_CYMUXF2,
      SEL => XLXI_4_n0005_10_CYSELG,
      O => XLXI_4_n0005_10_CYMUXG2
    );
  XLXI_4_n0005_10_CY0G_95 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c(3),
      O => XLXI_4_n0005_10_CY0G
    );
  XLXI_4_n0005_10_CYSELG_96 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_Maddsub_n0001_inst_lut2_2,
      O => XLXI_4_n0005_10_CYSELG
    );
  XLXI_4_n0005_12_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n0005_12_XORF,
      O => XLXI_4_n0005(12)
    );
  XLXI_4_n0005_12_XORF_97 : X_XOR2
    port map (
      I0 => XLXI_4_n0005_12_CYINIT,
      I1 => XLXI_4_Maddsub_n0001_inst_lut2_3,
      O => XLXI_4_n0005_12_XORF
    );
  XLXI_4_n0005_12_CYMUXF : X_MUX2
    port map (
      IA => XLXI_4_n0005_12_CY0F,
      IB => XLXI_4_n0005_12_CYINIT,
      SEL => XLXI_4_n0005_12_CYSELF,
      O => XLXI_4_Maddsub_n0001_inst_cy_4
    );
  XLXI_4_n0005_12_CYMUXF2_98 : X_MUX2
    port map (
      IA => XLXI_4_n0005_12_CY0F,
      IB => XLXI_4_n0005_12_CY0F,
      SEL => XLXI_4_n0005_12_CYSELF,
      O => XLXI_4_n0005_12_CYMUXF2
    );
  XLXI_4_n0005_12_CYINIT_99 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_Maddsub_n0001_inst_cy_3,
      O => XLXI_4_n0005_12_CYINIT
    );
  XLXI_4_n0005_12_CY0F_100 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c(4),
      O => XLXI_4_n0005_12_CY0F
    );
  XLXI_4_n0005_12_CYSELF_101 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_Maddsub_n0001_inst_lut2_3,
      O => XLXI_4_n0005_12_CYSELF
    );
  XLXI_4_n0005_12_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n0005_12_XORG,
      O => XLXI_4_n0005(13)
    );
  XLXI_4_n0005_12_XORG_102 : X_XOR2
    port map (
      I0 => XLXI_4_Maddsub_n0001_inst_cy_4,
      I1 => XLXI_4_Maddsub_n0001_inst_lut2_4,
      O => XLXI_4_n0005_12_XORG
    );
  XLXI_4_n0005_12_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n0005_12_CYMUXFAST,
      O => XLXI_4_Maddsub_n0001_inst_cy_5
    );
  XLXI_4_n0005_12_FASTCARRY_103 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_Maddsub_n0001_inst_cy_3,
      O => XLXI_4_n0005_12_FASTCARRY
    );
  XLXI_4_n0005_12_CYAND_104 : X_AND2
    port map (
      I0 => XLXI_4_n0005_12_CYSELG,
      I1 => XLXI_4_n0005_12_CYSELF,
      O => XLXI_4_n0005_12_CYAND
    );
  XLXI_4_n0005_12_CYMUXFAST_105 : X_MUX2
    port map (
      IA => XLXI_4_n0005_12_CYMUXG2,
      IB => XLXI_4_n0005_12_FASTCARRY,
      SEL => XLXI_4_n0005_12_CYAND,
      O => XLXI_4_n0005_12_CYMUXFAST
    );
  XLXI_4_n0005_12_CYMUXG2_106 : X_MUX2
    port map (
      IA => XLXI_4_n0005_12_CY0G,
      IB => XLXI_4_n0005_12_CYMUXF2,
      SEL => XLXI_4_n0005_12_CYSELG,
      O => XLXI_4_n0005_12_CYMUXG2
    );
  XLXI_4_n0005_12_CY0G_107 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c(5),
      O => XLXI_4_n0005_12_CY0G
    );
  XLXI_4_n0005_12_CYSELG_108 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_Maddsub_n0001_inst_lut2_4,
      O => XLXI_4_n0005_12_CYSELG
    );
  XLXI_4_n0005_14_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n0005_14_XORF,
      O => XLXI_4_n0005(14)
    );
  XLXI_4_n0005_14_XORF_109 : X_XOR2
    port map (
      I0 => XLXI_4_n0005_14_CYINIT,
      I1 => XLXI_4_Maddsub_n0001_inst_lut2_5,
      O => XLXI_4_n0005_14_XORF
    );
  XLXI_4_n0005_14_CYMUXF : X_MUX2
    port map (
      IA => XLXI_4_n0005_14_CY0F,
      IB => XLXI_4_n0005_14_CYINIT,
      SEL => XLXI_4_n0005_14_CYSELF,
      O => XLXI_4_Maddsub_n0001_inst_cy_6
    );
  XLXI_4_n0005_14_CYINIT_110 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_Maddsub_n0001_inst_cy_5,
      O => XLXI_4_n0005_14_CYINIT
    );
  XLXI_4_n0005_14_CY0F_111 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c(6),
      O => XLXI_4_n0005_14_CY0F
    );
  XLXI_4_n0005_14_CYSELF_112 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_Maddsub_n0001_inst_lut2_5,
      O => XLXI_4_n0005_14_CYSELF
    );
  XLXI_4_n0005_14_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n0005_14_XORG,
      O => XLXI_4_n0005(15)
    );
  XLXI_4_n0005_14_XORG_113 : X_XOR2
    port map (
      I0 => XLXI_4_Maddsub_n0001_inst_cy_6,
      I1 => XLXI_4_Maddsub_n0001_inst_lut2_61_O,
      O => XLXI_4_n0005_14_XORG
    );
  Cpu16_I1_Madd_n0009_inst_lut2_151 : X_LUT4
    generic map(
      INIT => X"0F0F"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => Cpu16_I1_pc(0),
      ADR3 => VCC,
      O => Cpu16_I1_Madd_n0009_inst_lut2_15
    );
  Cpu16_I1_n0009_1_LOGIC_ZERO_114 : X_ZERO
    port map (
      O => Cpu16_I1_n0009_1_LOGIC_ZERO
    );
  Cpu16_I1_n0009_1_LOGIC_ONE_115 : X_ONE
    port map (
      O => Cpu16_I1_n0009_1_LOGIC_ONE
    );
  Cpu16_I1_n0009_1_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_1_LOGIC_ONE,
      IB => Cpu16_I1_n0009_1_CYINIT,
      SEL => Cpu16_I1_n0009_1_CYSELF,
      O => Cpu16_I1_Madd_n0009_inst_cy_16
    );
  Cpu16_I1_n0009_1_CYINIT_116 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_1_BXINVNOT,
      O => Cpu16_I1_n0009_1_CYINIT
    );
  Cpu16_I1_n0009_1_CYSELF_117 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_Madd_n0009_inst_lut2_15,
      O => Cpu16_I1_n0009_1_CYSELF
    );
  Cpu16_I1_n0009_1_BXINV : X_INV
    port map (
      I => GLOBAL_LOGIC1_11,
      O => Cpu16_I1_n0009_1_BXINVNOT
    );
  Cpu16_I1_n0009_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_1_XORG,
      O => Cpu16_I1_n0009(1)
    );
  Cpu16_I1_n0009_1_XORG_118 : X_XOR2
    port map (
      I0 => Cpu16_I1_Madd_n0009_inst_cy_16,
      I1 => Cpu16_I1_n0009_1_G,
      O => Cpu16_I1_n0009_1_XORG
    );
  Cpu16_I1_n0009_1_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_1_CYMUXG,
      O => Cpu16_I1_Madd_n0009_inst_cy_17
    );
  Cpu16_I1_n0009_1_CYMUXG_119 : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_1_LOGIC_ZERO,
      IB => Cpu16_I1_Madd_n0009_inst_cy_16,
      SEL => Cpu16_I1_n0009_1_CYSELG,
      O => Cpu16_I1_n0009_1_CYMUXG
    );
  Cpu16_I1_n0009_1_CYSELG_120 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_1_G,
      O => Cpu16_I1_n0009_1_CYSELG
    );
  Cpu16_I1_n0009_2_LOGIC_ZERO_121 : X_ZERO
    port map (
      O => Cpu16_I1_n0009_2_LOGIC_ZERO
    );
  Cpu16_I1_n0009_2_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_2_XORF,
      O => Cpu16_I1_n0009(2)
    );
  Cpu16_I1_n0009_2_XORF_122 : X_XOR2
    port map (
      I0 => Cpu16_I1_n0009_2_CYINIT,
      I1 => Cpu16_I1_n0009_2_F,
      O => Cpu16_I1_n0009_2_XORF
    );
  Cpu16_I1_n0009_2_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_2_LOGIC_ZERO,
      IB => Cpu16_I1_n0009_2_CYINIT,
      SEL => Cpu16_I1_n0009_2_CYSELF,
      O => Cpu16_I1_Madd_n0009_inst_cy_18
    );
  Cpu16_I1_n0009_2_CYMUXF2_123 : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_2_LOGIC_ZERO,
      IB => Cpu16_I1_n0009_2_LOGIC_ZERO,
      SEL => Cpu16_I1_n0009_2_CYSELF,
      O => Cpu16_I1_n0009_2_CYMUXF2
    );
  Cpu16_I1_n0009_2_CYINIT_124 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_Madd_n0009_inst_cy_17,
      O => Cpu16_I1_n0009_2_CYINIT
    );
  Cpu16_I1_n0009_2_CYSELF_125 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_2_F,
      O => Cpu16_I1_n0009_2_CYSELF
    );
  Cpu16_I1_n0009_2_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_2_XORG,
      O => Cpu16_I1_n0009(3)
    );
  Cpu16_I1_n0009_2_XORG_126 : X_XOR2
    port map (
      I0 => Cpu16_I1_Madd_n0009_inst_cy_18,
      I1 => Cpu16_I1_n0009_2_G,
      O => Cpu16_I1_n0009_2_XORG
    );
  Cpu16_I1_n0009_2_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_2_CYMUXFAST,
      O => Cpu16_I1_Madd_n0009_inst_cy_19
    );
  Cpu16_I1_n0009_2_FASTCARRY_127 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_Madd_n0009_inst_cy_17,
      O => Cpu16_I1_n0009_2_FASTCARRY
    );
  Cpu16_I1_n0009_2_CYAND_128 : X_AND2
    port map (
      I0 => Cpu16_I1_n0009_2_CYSELG,
      I1 => Cpu16_I1_n0009_2_CYSELF,
      O => Cpu16_I1_n0009_2_CYAND
    );
  Cpu16_I1_n0009_2_CYMUXFAST_129 : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_2_CYMUXG2,
      IB => Cpu16_I1_n0009_2_FASTCARRY,
      SEL => Cpu16_I1_n0009_2_CYAND,
      O => Cpu16_I1_n0009_2_CYMUXFAST
    );
  Cpu16_I1_n0009_2_CYMUXG2_130 : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_2_LOGIC_ZERO,
      IB => Cpu16_I1_n0009_2_CYMUXF2,
      SEL => Cpu16_I1_n0009_2_CYSELG,
      O => Cpu16_I1_n0009_2_CYMUXG2
    );
  Cpu16_I1_n0009_2_CYSELG_131 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_2_G,
      O => Cpu16_I1_n0009_2_CYSELG
    );
  Cpu16_I1_n0009_4_LOGIC_ZERO_132 : X_ZERO
    port map (
      O => Cpu16_I1_n0009_4_LOGIC_ZERO
    );
  Cpu16_I1_n0009_4_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_4_XORF,
      O => Cpu16_I1_n0009(4)
    );
  Cpu16_I1_n0009_4_XORF_133 : X_XOR2
    port map (
      I0 => Cpu16_I1_n0009_4_CYINIT,
      I1 => Cpu16_I1_n0009_4_F,
      O => Cpu16_I1_n0009_4_XORF
    );
  Cpu16_I1_n0009_4_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_4_LOGIC_ZERO,
      IB => Cpu16_I1_n0009_4_CYINIT,
      SEL => Cpu16_I1_n0009_4_CYSELF,
      O => Cpu16_I1_Madd_n0009_inst_cy_20
    );
  Cpu16_I1_n0009_4_CYMUXF2_134 : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_4_LOGIC_ZERO,
      IB => Cpu16_I1_n0009_4_LOGIC_ZERO,
      SEL => Cpu16_I1_n0009_4_CYSELF,
      O => Cpu16_I1_n0009_4_CYMUXF2
    );
  Cpu16_I1_n0009_4_CYINIT_135 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_Madd_n0009_inst_cy_19,
      O => Cpu16_I1_n0009_4_CYINIT
    );
  Cpu16_I1_n0009_4_CYSELF_136 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_4_F,
      O => Cpu16_I1_n0009_4_CYSELF
    );
  Cpu16_I1_n0009_4_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_4_XORG,
      O => Cpu16_I1_n0009(5)
    );
  Cpu16_I1_n0009_4_XORG_137 : X_XOR2
    port map (
      I0 => Cpu16_I1_Madd_n0009_inst_cy_20,
      I1 => Cpu16_I1_n0009_4_G,
      O => Cpu16_I1_n0009_4_XORG
    );
  Cpu16_I1_n0009_4_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_4_CYMUXFAST,
      O => Cpu16_I1_Madd_n0009_inst_cy_21
    );
  Cpu16_I1_n0009_4_FASTCARRY_138 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_Madd_n0009_inst_cy_19,
      O => Cpu16_I1_n0009_4_FASTCARRY
    );
  Cpu16_I1_n0009_4_CYAND_139 : X_AND2
    port map (
      I0 => Cpu16_I1_n0009_4_CYSELG,
      I1 => Cpu16_I1_n0009_4_CYSELF,
      O => Cpu16_I1_n0009_4_CYAND
    );
  Cpu16_I1_n0009_4_CYMUXFAST_140 : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_4_CYMUXG2,
      IB => Cpu16_I1_n0009_4_FASTCARRY,
      SEL => Cpu16_I1_n0009_4_CYAND,
      O => Cpu16_I1_n0009_4_CYMUXFAST
    );
  Cpu16_I1_n0009_4_CYMUXG2_141 : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_4_LOGIC_ZERO,
      IB => Cpu16_I1_n0009_4_CYMUXF2,
      SEL => Cpu16_I1_n0009_4_CYSELG,
      O => Cpu16_I1_n0009_4_CYMUXG2
    );
  Cpu16_I1_n0009_4_CYSELG_142 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_4_G,
      O => Cpu16_I1_n0009_4_CYSELG
    );
  Cpu16_I1_n0009_6_LOGIC_ZERO_143 : X_ZERO
    port map (
      O => Cpu16_I1_n0009_6_LOGIC_ZERO
    );
  Cpu16_I1_n0009_6_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_6_XORF,
      O => Cpu16_I1_n0009(6)
    );
  Cpu16_I1_n0009_6_XORF_144 : X_XOR2
    port map (
      I0 => Cpu16_I1_n0009_6_CYINIT,
      I1 => Cpu16_I1_n0009_6_F,
      O => Cpu16_I1_n0009_6_XORF
    );
  Cpu16_I1_n0009_6_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_6_LOGIC_ZERO,
      IB => Cpu16_I1_n0009_6_CYINIT,
      SEL => Cpu16_I1_n0009_6_CYSELF,
      O => Cpu16_I1_Madd_n0009_inst_cy_22
    );
  Cpu16_I1_n0009_6_CYMUXF2_145 : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_6_LOGIC_ZERO,
      IB => Cpu16_I1_n0009_6_LOGIC_ZERO,
      SEL => Cpu16_I1_n0009_6_CYSELF,
      O => Cpu16_I1_n0009_6_CYMUXF2
    );
  Cpu16_I1_n0009_6_CYINIT_146 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_Madd_n0009_inst_cy_21,
      O => Cpu16_I1_n0009_6_CYINIT
    );
  Cpu16_I1_n0009_6_CYSELF_147 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_6_F,
      O => Cpu16_I1_n0009_6_CYSELF
    );
  Cpu16_I1_n0009_6_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_6_XORG,
      O => Cpu16_I1_n0009(7)
    );
  Cpu16_I1_n0009_6_XORG_148 : X_XOR2
    port map (
      I0 => Cpu16_I1_Madd_n0009_inst_cy_22,
      I1 => Cpu16_I1_n0009_6_G,
      O => Cpu16_I1_n0009_6_XORG
    );
  Cpu16_I1_n0009_6_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_6_CYMUXFAST,
      O => Cpu16_I1_Madd_n0009_inst_cy_23
    );
  Cpu16_I1_n0009_6_FASTCARRY_149 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_Madd_n0009_inst_cy_21,
      O => Cpu16_I1_n0009_6_FASTCARRY
    );
  Cpu16_I1_n0009_6_CYAND_150 : X_AND2
    port map (
      I0 => Cpu16_I1_n0009_6_CYSELG,
      I1 => Cpu16_I1_n0009_6_CYSELF,
      O => Cpu16_I1_n0009_6_CYAND
    );
  Cpu16_I1_n0009_6_CYMUXFAST_151 : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_6_CYMUXG2,
      IB => Cpu16_I1_n0009_6_FASTCARRY,
      SEL => Cpu16_I1_n0009_6_CYAND,
      O => Cpu16_I1_n0009_6_CYMUXFAST
    );
  Cpu16_I1_n0009_6_CYMUXG2_152 : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_6_LOGIC_ZERO,
      IB => Cpu16_I1_n0009_6_CYMUXF2,
      SEL => Cpu16_I1_n0009_6_CYSELG,
      O => Cpu16_I1_n0009_6_CYMUXG2
    );
  Cpu16_I1_n0009_6_CYSELG_153 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_6_G,
      O => Cpu16_I1_n0009_6_CYSELG
    );
  Cpu16_I1_n0009_8_LOGIC_ZERO_154 : X_ZERO
    port map (
      O => Cpu16_I1_n0009_8_LOGIC_ZERO
    );
  Cpu16_I1_n0009_8_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_8_XORF,
      O => Cpu16_I1_n0009(8)
    );
  Cpu16_I1_n0009_8_XORF_155 : X_XOR2
    port map (
      I0 => Cpu16_I1_n0009_8_CYINIT,
      I1 => Cpu16_I1_n0009_8_F,
      O => Cpu16_I1_n0009_8_XORF
    );
  Cpu16_I1_n0009_8_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_8_LOGIC_ZERO,
      IB => Cpu16_I1_n0009_8_CYINIT,
      SEL => Cpu16_I1_n0009_8_CYSELF,
      O => Cpu16_I1_Madd_n0009_inst_cy_24
    );
  Cpu16_I1_n0009_8_CYMUXF2_156 : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_8_LOGIC_ZERO,
      IB => Cpu16_I1_n0009_8_LOGIC_ZERO,
      SEL => Cpu16_I1_n0009_8_CYSELF,
      O => Cpu16_I1_n0009_8_CYMUXF2
    );
  Cpu16_I1_n0009_8_CYINIT_157 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_Madd_n0009_inst_cy_23,
      O => Cpu16_I1_n0009_8_CYINIT
    );
  Cpu16_I1_n0009_8_CYSELF_158 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_8_F,
      O => Cpu16_I1_n0009_8_CYSELF
    );
  Cpu16_I1_n0009_8_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_8_XORG,
      O => Cpu16_I1_n0009(9)
    );
  Cpu16_I1_n0009_8_XORG_159 : X_XOR2
    port map (
      I0 => Cpu16_I1_Madd_n0009_inst_cy_24,
      I1 => Cpu16_I1_n0009_8_G,
      O => Cpu16_I1_n0009_8_XORG
    );
  Cpu16_I1_n0009_8_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_8_CYMUXFAST,
      O => Cpu16_I1_Madd_n0009_inst_cy_25
    );
  Cpu16_I1_n0009_8_FASTCARRY_160 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_Madd_n0009_inst_cy_23,
      O => Cpu16_I1_n0009_8_FASTCARRY
    );
  Cpu16_I1_n0009_8_CYAND_161 : X_AND2
    port map (
      I0 => Cpu16_I1_n0009_8_CYSELG,
      I1 => Cpu16_I1_n0009_8_CYSELF,
      O => Cpu16_I1_n0009_8_CYAND
    );
  Cpu16_I1_n0009_8_CYMUXFAST_162 : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_8_CYMUXG2,
      IB => Cpu16_I1_n0009_8_FASTCARRY,
      SEL => Cpu16_I1_n0009_8_CYAND,
      O => Cpu16_I1_n0009_8_CYMUXFAST
    );
  Cpu16_I1_n0009_8_CYMUXG2_163 : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_8_LOGIC_ZERO,
      IB => Cpu16_I1_n0009_8_CYMUXF2,
      SEL => Cpu16_I1_n0009_8_CYSELG,
      O => Cpu16_I1_n0009_8_CYMUXG2
    );
  Cpu16_I1_n0009_8_CYSELG_164 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_8_G,
      O => Cpu16_I1_n0009_8_CYSELG
    );
  Cpu16_I1_pc_11_rt_165 : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => Cpu16_I1_pc(11),
      O => Cpu16_I1_pc_11_rt
    );
  Cpu16_I1_n0009_10_LOGIC_ZERO_166 : X_ZERO
    port map (
      O => Cpu16_I1_n0009_10_LOGIC_ZERO
    );
  Cpu16_I1_n0009_10_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_10_XORF,
      O => Cpu16_I1_n0009(10)
    );
  Cpu16_I1_n0009_10_XORF_167 : X_XOR2
    port map (
      I0 => Cpu16_I1_n0009_10_CYINIT,
      I1 => Cpu16_I1_n0009_10_F,
      O => Cpu16_I1_n0009_10_XORF
    );
  Cpu16_I1_n0009_10_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I1_n0009_10_LOGIC_ZERO,
      IB => Cpu16_I1_n0009_10_CYINIT,
      SEL => Cpu16_I1_n0009_10_CYSELF,
      O => Cpu16_I1_Madd_n0009_inst_cy_26
    );
  Cpu16_I1_n0009_10_CYINIT_168 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_Madd_n0009_inst_cy_25,
      O => Cpu16_I1_n0009_10_CYINIT
    );
  Cpu16_I1_n0009_10_CYSELF_169 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_10_F,
      O => Cpu16_I1_n0009_10_CYSELF
    );
  Cpu16_I1_n0009_10_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0009_10_XORG,
      O => Cpu16_I1_n0009(11)
    );
  Cpu16_I1_n0009_10_XORG_170 : X_XOR2
    port map (
      I0 => Cpu16_I1_Madd_n0009_inst_cy_26,
      I1 => Cpu16_I1_pc_11_rt,
      O => Cpu16_I1_n0009_10_XORG
    );
  XLXI_5_n0011_0_LOGIC_ZERO_171 : X_ZERO
    port map (
      O => XLXI_5_n0011_0_LOGIC_ZERO
    );
  XLXI_5_n0011_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0011_0_XORF,
      O => XLXI_5_n0011(0)
    );
  XLXI_5_n0011_0_XORF_172 : X_XOR2
    port map (
      I0 => XLXI_5_n0011_0_CYINIT,
      I1 => XLXI_5_n0011_0_F,
      O => XLXI_5_n0011_0_XORF
    );
  XLXI_5_n0011_0_CYMUXF : X_MUX2
    port map (
      IA => XLXI_5_n0011_0_LOGIC_ZERO,
      IB => XLXI_5_n0011_0_CYINIT,
      SEL => XLXI_5_n0011_0_CYSELF,
      O => XLXI_5_Msub_n0011_inst_cy_8
    );
  XLXI_5_n0011_0_CYINIT_173 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GLOBAL_LOGIC1_2,
      O => XLXI_5_n0011_0_CYINIT
    );
  XLXI_5_n0011_0_CYSELF_174 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0011_0_F,
      O => XLXI_5_n0011_0_CYSELF
    );
  XLXI_5_n0011_0_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0011_0_XORG,
      O => XLXI_5_n0011(1)
    );
  XLXI_5_n0011_0_XORG_175 : X_XOR2
    port map (
      I0 => XLXI_5_Msub_n0011_inst_cy_8,
      I1 => XLXI_5_Msub_n0011_inst_lut2_8,
      O => XLXI_5_n0011_0_XORG
    );
  XLXI_5_n0011_0_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0011_0_CYMUXG,
      O => XLXI_5_Msub_n0011_inst_cy_9
    );
  XLXI_5_n0011_0_CYMUXG_176 : X_MUX2
    port map (
      IA => XLXI_5_n0011_0_CY0G,
      IB => XLXI_5_Msub_n0011_inst_cy_8,
      SEL => XLXI_5_n0011_0_CYSELG,
      O => XLXI_5_n0011_0_CYMUXG
    );
  XLXI_5_n0011_0_CY0G_177 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_nwait_c(1),
      O => XLXI_5_n0011_0_CY0G
    );
  XLXI_5_n0011_0_CYSELG_178 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_Msub_n0011_inst_lut2_8,
      O => XLXI_5_n0011_0_CYSELG
    );
  XLXI_5_n0011_2_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0011_2_XORF,
      O => XLXI_5_n0011(2)
    );
  XLXI_5_n0011_2_XORF_179 : X_XOR2
    port map (
      I0 => XLXI_5_n0011_2_CYINIT,
      I1 => XLXI_5_Msub_n0011_inst_lut2_9,
      O => XLXI_5_n0011_2_XORF
    );
  XLXI_5_n0011_2_CYMUXF : X_MUX2
    port map (
      IA => XLXI_5_n0011_2_CY0F,
      IB => XLXI_5_n0011_2_CYINIT,
      SEL => XLXI_5_n0011_2_CYSELF,
      O => XLXI_5_Msub_n0011_inst_cy_10
    );
  XLXI_5_n0011_2_CYMUXF2_180 : X_MUX2
    port map (
      IA => XLXI_5_n0011_2_CY0F,
      IB => XLXI_5_n0011_2_CY0F,
      SEL => XLXI_5_n0011_2_CYSELF,
      O => XLXI_5_n0011_2_CYMUXF2
    );
  XLXI_5_n0011_2_CYINIT_181 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_Msub_n0011_inst_cy_9,
      O => XLXI_5_n0011_2_CYINIT
    );
  XLXI_5_n0011_2_CY0F_182 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_nwait_c(2),
      O => XLXI_5_n0011_2_CY0F
    );
  XLXI_5_n0011_2_CYSELF_183 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_Msub_n0011_inst_lut2_9,
      O => XLXI_5_n0011_2_CYSELF
    );
  XLXI_5_n0011_2_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0011_2_XORG,
      O => XLXI_5_n0011(3)
    );
  XLXI_5_n0011_2_XORG_184 : X_XOR2
    port map (
      I0 => XLXI_5_Msub_n0011_inst_cy_10,
      I1 => XLXI_5_Msub_n0011_inst_lut2_10,
      O => XLXI_5_n0011_2_XORG
    );
  XLXI_5_n0011_2_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0011_2_CYMUXFAST,
      O => XLXI_5_Msub_n0011_inst_cy_11
    );
  XLXI_5_n0011_2_FASTCARRY_185 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_Msub_n0011_inst_cy_9,
      O => XLXI_5_n0011_2_FASTCARRY
    );
  XLXI_5_n0011_2_CYAND_186 : X_AND2
    port map (
      I0 => XLXI_5_n0011_2_CYSELG,
      I1 => XLXI_5_n0011_2_CYSELF,
      O => XLXI_5_n0011_2_CYAND
    );
  XLXI_5_n0011_2_CYMUXFAST_187 : X_MUX2
    port map (
      IA => XLXI_5_n0011_2_CYMUXG2,
      IB => XLXI_5_n0011_2_FASTCARRY,
      SEL => XLXI_5_n0011_2_CYAND,
      O => XLXI_5_n0011_2_CYMUXFAST
    );
  XLXI_5_n0011_2_CYMUXG2_188 : X_MUX2
    port map (
      IA => XLXI_5_n0011_2_CY0G,
      IB => XLXI_5_n0011_2_CYMUXF2,
      SEL => XLXI_5_n0011_2_CYSELG,
      O => XLXI_5_n0011_2_CYMUXG2
    );
  XLXI_5_n0011_2_CY0G_189 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_nwait_c(3),
      O => XLXI_5_n0011_2_CY0G
    );
  XLXI_5_n0011_2_CYSELG_190 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_Msub_n0011_inst_lut2_10,
      O => XLXI_5_n0011_2_CYSELG
    );
  XLXI_5_n0011_4_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0011_4_XORF,
      O => XLXI_5_n0011(4)
    );
  XLXI_5_n0011_4_XORF_191 : X_XOR2
    port map (
      I0 => XLXI_5_n0011_4_CYINIT,
      I1 => XLXI_5_Msub_n0011_inst_lut2_11,
      O => XLXI_5_n0011_4_XORF
    );
  XLXI_5_n0011_4_CYMUXF : X_MUX2
    port map (
      IA => XLXI_5_n0011_4_CY0F,
      IB => XLXI_5_n0011_4_CYINIT,
      SEL => XLXI_5_n0011_4_CYSELF,
      O => XLXI_5_Msub_n0011_inst_cy_12
    );
  XLXI_5_n0011_4_CYMUXF2_192 : X_MUX2
    port map (
      IA => XLXI_5_n0011_4_CY0F,
      IB => XLXI_5_n0011_4_CY0F,
      SEL => XLXI_5_n0011_4_CYSELF,
      O => XLXI_5_n0011_4_CYMUXF2
    );
  XLXI_5_n0011_4_CYINIT_193 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_Msub_n0011_inst_cy_11,
      O => XLXI_5_n0011_4_CYINIT
    );
  XLXI_5_n0011_4_CY0F_194 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_nwait_c(4),
      O => XLXI_5_n0011_4_CY0F
    );
  XLXI_5_n0011_4_CYSELF_195 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_Msub_n0011_inst_lut2_11,
      O => XLXI_5_n0011_4_CYSELF
    );
  XLXI_5_n0011_4_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0011_4_XORG,
      O => XLXI_5_n0011(5)
    );
  XLXI_5_n0011_4_XORG_196 : X_XOR2
    port map (
      I0 => XLXI_5_Msub_n0011_inst_cy_12,
      I1 => XLXI_5_Msub_n0011_inst_lut2_12,
      O => XLXI_5_n0011_4_XORG
    );
  XLXI_5_n0011_4_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0011_4_CYMUXFAST,
      O => XLXI_5_Msub_n0011_inst_cy_13
    );
  XLXI_5_n0011_4_FASTCARRY_197 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_Msub_n0011_inst_cy_11,
      O => XLXI_5_n0011_4_FASTCARRY
    );
  XLXI_5_n0011_4_CYAND_198 : X_AND2
    port map (
      I0 => XLXI_5_n0011_4_CYSELG,
      I1 => XLXI_5_n0011_4_CYSELF,
      O => XLXI_5_n0011_4_CYAND
    );
  XLXI_5_n0011_4_CYMUXFAST_199 : X_MUX2
    port map (
      IA => XLXI_5_n0011_4_CYMUXG2,
      IB => XLXI_5_n0011_4_FASTCARRY,
      SEL => XLXI_5_n0011_4_CYAND,
      O => XLXI_5_n0011_4_CYMUXFAST
    );
  XLXI_5_n0011_4_CYMUXG2_200 : X_MUX2
    port map (
      IA => XLXI_5_n0011_4_CY0G,
      IB => XLXI_5_n0011_4_CYMUXF2,
      SEL => XLXI_5_n0011_4_CYSELG,
      O => XLXI_5_n0011_4_CYMUXG2
    );
  XLXI_5_n0011_4_CY0G_201 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_nwait_c(5),
      O => XLXI_5_n0011_4_CY0G
    );
  XLXI_5_n0011_4_CYSELG_202 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_Msub_n0011_inst_lut2_12,
      O => XLXI_5_n0011_4_CYSELG
    );
  XLXI_5_Msub_n0011_inst_lut2_14_rt_203 : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_5_Msub_n0011_inst_lut2_14,
      ADR3 => VCC,
      O => XLXI_5_Msub_n0011_inst_lut2_14_rt
    );
  XLXI_5_n0011_6_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0011_6_XORF,
      O => XLXI_5_n0011(6)
    );
  XLXI_5_n0011_6_XORF_204 : X_XOR2
    port map (
      I0 => XLXI_5_n0011_6_CYINIT,
      I1 => XLXI_5_Msub_n0011_inst_lut2_13,
      O => XLXI_5_n0011_6_XORF
    );
  XLXI_5_n0011_6_CYMUXF : X_MUX2
    port map (
      IA => XLXI_5_n0011_6_CY0F,
      IB => XLXI_5_n0011_6_CYINIT,
      SEL => XLXI_5_n0011_6_CYSELF,
      O => XLXI_5_Msub_n0011_inst_cy_14
    );
  XLXI_5_n0011_6_CYINIT_205 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_Msub_n0011_inst_cy_13,
      O => XLXI_5_n0011_6_CYINIT
    );
  XLXI_5_n0011_6_CY0F_206 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_nwait_c(6),
      O => XLXI_5_n0011_6_CY0F
    );
  XLXI_5_n0011_6_CYSELF_207 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_Msub_n0011_inst_lut2_13,
      O => XLXI_5_n0011_6_CYSELF
    );
  XLXI_5_n0011_6_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0011_6_XORG,
      O => XLXI_5_n0011(7)
    );
  XLXI_5_n0011_6_XORG_208 : X_XOR2
    port map (
      I0 => XLXI_5_Msub_n0011_inst_cy_14,
      I1 => XLXI_5_Msub_n0011_inst_lut2_14_rt,
      O => XLXI_5_n0011_6_XORG
    );
  XLXI_4_Maddsub_n0001_inst_lut2_41 : X_LUT4
    generic map(
      INIT => X"3555"
    )
    port map (
      ADR0 => N30788,
      ADR1 => XLXI_4_n00021_SW9_O,
      ADR2 => Cpu16_pc_mux(1),
      ADR3 => Cpu16_pc_mux(0),
      O => XLXI_4_Maddsub_n0001_inst_lut2_4
    );
  Cpu16_I3_n0098_1_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_1_CY0F,
      IB => Cpu16_I3_n0098_1_CYINIT,
      SEL => Cpu16_I3_n0098_1_CYSELF,
      O => Cpu16_I3_Madd_n0098_inst_cy_45
    );
  Cpu16_I3_n0098_1_CYINIT_209 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_1_BXINVNOT,
      O => Cpu16_I3_n0098_1_CYINIT
    );
  Cpu16_I3_n0098_1_CY0F_210 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_0,
      O => Cpu16_I3_n0098_1_CY0F
    );
  Cpu16_I3_n0098_1_CYSELF_211 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_lut2_44_rt,
      O => Cpu16_I3_n0098_1_CYSELF
    );
  Cpu16_I3_n0098_1_BXINV : X_INV
    port map (
      I => GLOBAL_LOGIC1_0,
      O => Cpu16_I3_n0098_1_BXINVNOT
    );
  Cpu16_I3_n0098_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_1_XORG,
      O => Cpu16_I3_n0098(1)
    );
  Cpu16_I3_n0098_1_XORG_212 : X_XOR2
    port map (
      I0 => Cpu16_I3_Madd_n0098_inst_cy_45,
      I1 => Cpu16_I3_Madd_n0098_inst_lut2_451_O,
      O => Cpu16_I3_n0098_1_XORG
    );
  Cpu16_I3_n0098_1_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_1_CYMUXG,
      O => Cpu16_I3_Madd_n0098_inst_cy_46
    );
  Cpu16_I3_n0098_1_CYMUXG_213 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_1_CY0G,
      IB => Cpu16_I3_Madd_n0098_inst_cy_45,
      SEL => Cpu16_I3_n0098_1_CYSELG,
      O => Cpu16_I3_n0098_1_CYMUXG
    );
  Cpu16_I3_n0098_1_CY0G_214 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_1,
      O => Cpu16_I3_n0098_1_CY0G
    );
  Cpu16_I3_n0098_1_CYSELG_215 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_lut2_451_O,
      O => Cpu16_I3_n0098_1_CYSELG
    );
  Cpu16_I3_Madd_n0098_inst_lut2_471 : X_LUT4
    generic map(
      INIT => X"569A"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_3,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => CHOICE1342,
      ADR3 => Cpu16_I2_data_is_c(3),
      O => Cpu16_I3_Madd_n0098_inst_lut2_471_O
    );
  Cpu16_I3_n0098_2_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_2_XORF,
      O => Cpu16_I3_n0098(2)
    );
  Cpu16_I3_n0098_2_XORF_216 : X_XOR2
    port map (
      I0 => Cpu16_I3_n0098_2_CYINIT,
      I1 => Cpu16_I3_Madd_n0098_inst_lut2_461_O,
      O => Cpu16_I3_n0098_2_XORF
    );
  Cpu16_I3_n0098_2_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_2_CY0F,
      IB => Cpu16_I3_n0098_2_CYINIT,
      SEL => Cpu16_I3_n0098_2_CYSELF,
      O => Cpu16_I3_Madd_n0098_inst_cy_47
    );
  Cpu16_I3_n0098_2_CYMUXF2_217 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_2_CY0F,
      IB => Cpu16_I3_n0098_2_CY0F,
      SEL => Cpu16_I3_n0098_2_CYSELF,
      O => Cpu16_I3_n0098_2_CYMUXF2
    );
  Cpu16_I3_n0098_2_CYINIT_218 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_cy_46,
      O => Cpu16_I3_n0098_2_CYINIT
    );
  Cpu16_I3_n0098_2_CY0F_219 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_2,
      O => Cpu16_I3_n0098_2_CY0F
    );
  Cpu16_I3_n0098_2_CYSELF_220 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_lut2_461_O,
      O => Cpu16_I3_n0098_2_CYSELF
    );
  Cpu16_I3_n0098_2_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_2_XORG,
      O => Cpu16_I3_n0098(3)
    );
  Cpu16_I3_n0098_2_XORG_221 : X_XOR2
    port map (
      I0 => Cpu16_I3_Madd_n0098_inst_cy_47,
      I1 => Cpu16_I3_Madd_n0098_inst_lut2_471_O,
      O => Cpu16_I3_n0098_2_XORG
    );
  Cpu16_I3_n0098_2_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_2_CYMUXFAST,
      O => Cpu16_I3_Madd_n0098_inst_cy_48
    );
  Cpu16_I3_n0098_2_FASTCARRY_222 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_cy_46,
      O => Cpu16_I3_n0098_2_FASTCARRY
    );
  Cpu16_I3_n0098_2_CYAND_223 : X_AND2
    port map (
      I0 => Cpu16_I3_n0098_2_CYSELG,
      I1 => Cpu16_I3_n0098_2_CYSELF,
      O => Cpu16_I3_n0098_2_CYAND
    );
  Cpu16_I3_n0098_2_CYMUXFAST_224 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_2_CYMUXG2,
      IB => Cpu16_I3_n0098_2_FASTCARRY,
      SEL => Cpu16_I3_n0098_2_CYAND,
      O => Cpu16_I3_n0098_2_CYMUXFAST
    );
  Cpu16_I3_n0098_2_CYMUXG2_225 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_2_CY0G,
      IB => Cpu16_I3_n0098_2_CYMUXF2,
      SEL => Cpu16_I3_n0098_2_CYSELG,
      O => Cpu16_I3_n0098_2_CYMUXG2
    );
  Cpu16_I3_n0098_2_CY0G_226 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_3,
      O => Cpu16_I3_n0098_2_CY0G
    );
  Cpu16_I3_n0098_2_CYSELG_227 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_lut2_471_O,
      O => Cpu16_I3_n0098_2_CYSELG
    );
  Cpu16_I3_Madd_n0098_inst_lut2_491 : X_LUT4
    generic map(
      INIT => X"596A"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_5,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => Cpu16_I2_data_is_c(5),
      ADR3 => CHOICE1232,
      O => Cpu16_I3_Madd_n0098_inst_lut2_491_O
    );
  Cpu16_I3_n0098_4_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_4_XORF,
      O => Cpu16_I3_n0098(4)
    );
  Cpu16_I3_n0098_4_XORF_228 : X_XOR2
    port map (
      I0 => Cpu16_I3_n0098_4_CYINIT,
      I1 => Cpu16_I3_Madd_n0098_inst_lut2_481_O,
      O => Cpu16_I3_n0098_4_XORF
    );
  Cpu16_I3_n0098_4_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_4_CY0F,
      IB => Cpu16_I3_n0098_4_CYINIT,
      SEL => Cpu16_I3_n0098_4_CYSELF,
      O => Cpu16_I3_Madd_n0098_inst_cy_49
    );
  Cpu16_I3_n0098_4_CYMUXF2_229 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_4_CY0F,
      IB => Cpu16_I3_n0098_4_CY0F,
      SEL => Cpu16_I3_n0098_4_CYSELF,
      O => Cpu16_I3_n0098_4_CYMUXF2
    );
  Cpu16_I3_n0098_4_CYINIT_230 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_cy_48,
      O => Cpu16_I3_n0098_4_CYINIT
    );
  Cpu16_I3_n0098_4_CY0F_231 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_4,
      O => Cpu16_I3_n0098_4_CY0F
    );
  Cpu16_I3_n0098_4_CYSELF_232 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_lut2_481_O,
      O => Cpu16_I3_n0098_4_CYSELF
    );
  Cpu16_I3_n0098_4_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_4_XORG,
      O => Cpu16_I3_n0098(5)
    );
  Cpu16_I3_n0098_4_XORG_233 : X_XOR2
    port map (
      I0 => Cpu16_I3_Madd_n0098_inst_cy_49,
      I1 => Cpu16_I3_Madd_n0098_inst_lut2_491_O,
      O => Cpu16_I3_n0098_4_XORG
    );
  Cpu16_I3_n0098_4_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_4_CYMUXFAST,
      O => Cpu16_I3_Madd_n0098_inst_cy_50
    );
  Cpu16_I3_n0098_4_FASTCARRY_234 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_cy_48,
      O => Cpu16_I3_n0098_4_FASTCARRY
    );
  Cpu16_I3_n0098_4_CYAND_235 : X_AND2
    port map (
      I0 => Cpu16_I3_n0098_4_CYSELG,
      I1 => Cpu16_I3_n0098_4_CYSELF,
      O => Cpu16_I3_n0098_4_CYAND
    );
  Cpu16_I3_n0098_4_CYMUXFAST_236 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_4_CYMUXG2,
      IB => Cpu16_I3_n0098_4_FASTCARRY,
      SEL => Cpu16_I3_n0098_4_CYAND,
      O => Cpu16_I3_n0098_4_CYMUXFAST
    );
  Cpu16_I3_n0098_4_CYMUXG2_237 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_4_CY0G,
      IB => Cpu16_I3_n0098_4_CYMUXF2,
      SEL => Cpu16_I3_n0098_4_CYSELG,
      O => Cpu16_I3_n0098_4_CYMUXG2
    );
  Cpu16_I3_n0098_4_CY0G_238 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_5,
      O => Cpu16_I3_n0098_4_CY0G
    );
  Cpu16_I3_n0098_4_CYSELG_239 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_lut2_491_O,
      O => Cpu16_I3_n0098_4_CYSELG
    );
  Cpu16_I3_Madd_n0098_inst_lut2_511 : X_LUT4
    generic map(
      INIT => X"596A"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_7,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => Cpu16_I2_data_is_c(7),
      ADR3 => CHOICE1122,
      O => Cpu16_I3_Madd_n0098_inst_lut2_511_O
    );
  Cpu16_I3_Madd_n0098_inst_lut2_501 : X_LUT4
    generic map(
      INIT => X"369C"
    )
    port map (
      ADR0 => Cpu16_I3_n0025,
      ADR1 => Cpu16_I3_acc_c_0_6,
      ADR2 => CHOICE1177,
      ADR3 => Cpu16_I2_data_is_c(6),
      O => Cpu16_I3_Madd_n0098_inst_lut2_501_O
    );
  Cpu16_I3_n0098_6_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_6_XORF,
      O => Cpu16_I3_n0098(6)
    );
  Cpu16_I3_n0098_6_XORF_240 : X_XOR2
    port map (
      I0 => Cpu16_I3_n0098_6_CYINIT,
      I1 => Cpu16_I3_Madd_n0098_inst_lut2_501_O,
      O => Cpu16_I3_n0098_6_XORF
    );
  Cpu16_I3_n0098_6_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_6_CY0F,
      IB => Cpu16_I3_n0098_6_CYINIT,
      SEL => Cpu16_I3_n0098_6_CYSELF,
      O => Cpu16_I3_Madd_n0098_inst_cy_51
    );
  Cpu16_I3_n0098_6_CYMUXF2_241 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_6_CY0F,
      IB => Cpu16_I3_n0098_6_CY0F,
      SEL => Cpu16_I3_n0098_6_CYSELF,
      O => Cpu16_I3_n0098_6_CYMUXF2
    );
  Cpu16_I3_n0098_6_CYINIT_242 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_cy_50,
      O => Cpu16_I3_n0098_6_CYINIT
    );
  Cpu16_I3_n0098_6_CY0F_243 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_6,
      O => Cpu16_I3_n0098_6_CY0F
    );
  Cpu16_I3_n0098_6_CYSELF_244 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_lut2_501_O,
      O => Cpu16_I3_n0098_6_CYSELF
    );
  Cpu16_I3_n0098_6_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_6_XORG,
      O => Cpu16_I3_n0098(7)
    );
  Cpu16_I3_n0098_6_XORG_245 : X_XOR2
    port map (
      I0 => Cpu16_I3_Madd_n0098_inst_cy_51,
      I1 => Cpu16_I3_Madd_n0098_inst_lut2_511_O,
      O => Cpu16_I3_n0098_6_XORG
    );
  Cpu16_I3_n0098_6_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_6_CYMUXFAST,
      O => Cpu16_I3_Madd_n0098_inst_cy_52
    );
  Cpu16_I3_n0098_6_FASTCARRY_246 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_cy_50,
      O => Cpu16_I3_n0098_6_FASTCARRY
    );
  Cpu16_I3_n0098_6_CYAND_247 : X_AND2
    port map (
      I0 => Cpu16_I3_n0098_6_CYSELG,
      I1 => Cpu16_I3_n0098_6_CYSELF,
      O => Cpu16_I3_n0098_6_CYAND
    );
  Cpu16_I3_n0098_6_CYMUXFAST_248 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_6_CYMUXG2,
      IB => Cpu16_I3_n0098_6_FASTCARRY,
      SEL => Cpu16_I3_n0098_6_CYAND,
      O => Cpu16_I3_n0098_6_CYMUXFAST
    );
  Cpu16_I3_n0098_6_CYMUXG2_249 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_6_CY0G,
      IB => Cpu16_I3_n0098_6_CYMUXF2,
      SEL => Cpu16_I3_n0098_6_CYSELG,
      O => Cpu16_I3_n0098_6_CYMUXG2
    );
  Cpu16_I3_n0098_6_CY0G_250 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_7,
      O => Cpu16_I3_n0098_6_CY0G
    );
  Cpu16_I3_n0098_6_CYSELG_251 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_lut2_511_O,
      O => Cpu16_I3_n0098_6_CYSELG
    );
  Cpu16_I3_Madd_n0098_inst_lut2_531 : X_LUT4
    generic map(
      INIT => X"596A"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_9,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => Cpu16_I2_data_is_c(9),
      ADR3 => CHOICE1012,
      O => Cpu16_I3_Madd_n0098_inst_lut2_531_O
    );
  Cpu16_I3_Madd_n0098_inst_lut2_521 : X_LUT4
    generic map(
      INIT => X"396C"
    )
    port map (
      ADR0 => Cpu16_I3_n0025,
      ADR1 => Cpu16_I3_acc_c_0_8,
      ADR2 => Cpu16_I2_data_is_c(8),
      ADR3 => CHOICE1067,
      O => Cpu16_I3_Madd_n0098_inst_lut2_521_O
    );
  Cpu16_I3_n0098_8_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_8_XORF,
      O => Cpu16_I3_n0098(8)
    );
  Cpu16_I3_n0098_8_XORF_252 : X_XOR2
    port map (
      I0 => Cpu16_I3_n0098_8_CYINIT,
      I1 => Cpu16_I3_Madd_n0098_inst_lut2_521_O,
      O => Cpu16_I3_n0098_8_XORF
    );
  Cpu16_I3_n0098_8_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_8_CY0F,
      IB => Cpu16_I3_n0098_8_CYINIT,
      SEL => Cpu16_I3_n0098_8_CYSELF,
      O => Cpu16_I3_Madd_n0098_inst_cy_53
    );
  Cpu16_I3_n0098_8_CYMUXF2_253 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_8_CY0F,
      IB => Cpu16_I3_n0098_8_CY0F,
      SEL => Cpu16_I3_n0098_8_CYSELF,
      O => Cpu16_I3_n0098_8_CYMUXF2
    );
  Cpu16_I3_n0098_8_CYINIT_254 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_cy_52,
      O => Cpu16_I3_n0098_8_CYINIT
    );
  Cpu16_I3_n0098_8_CY0F_255 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_8,
      O => Cpu16_I3_n0098_8_CY0F
    );
  Cpu16_I3_n0098_8_CYSELF_256 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_lut2_521_O,
      O => Cpu16_I3_n0098_8_CYSELF
    );
  Cpu16_I3_n0098_8_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_8_XORG,
      O => Cpu16_I3_n0098(9)
    );
  Cpu16_I3_n0098_8_XORG_257 : X_XOR2
    port map (
      I0 => Cpu16_I3_Madd_n0098_inst_cy_53,
      I1 => Cpu16_I3_Madd_n0098_inst_lut2_531_O,
      O => Cpu16_I3_n0098_8_XORG
    );
  Cpu16_I3_n0098_8_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_8_CYMUXFAST,
      O => Cpu16_I3_Madd_n0098_inst_cy_54
    );
  Cpu16_I3_n0098_8_FASTCARRY_258 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_cy_52,
      O => Cpu16_I3_n0098_8_FASTCARRY
    );
  Cpu16_I3_n0098_8_CYAND_259 : X_AND2
    port map (
      I0 => Cpu16_I3_n0098_8_CYSELG,
      I1 => Cpu16_I3_n0098_8_CYSELF,
      O => Cpu16_I3_n0098_8_CYAND
    );
  Cpu16_I3_n0098_8_CYMUXFAST_260 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_8_CYMUXG2,
      IB => Cpu16_I3_n0098_8_FASTCARRY,
      SEL => Cpu16_I3_n0098_8_CYAND,
      O => Cpu16_I3_n0098_8_CYMUXFAST
    );
  Cpu16_I3_n0098_8_CYMUXG2_261 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_8_CY0G,
      IB => Cpu16_I3_n0098_8_CYMUXF2,
      SEL => Cpu16_I3_n0098_8_CYSELG,
      O => Cpu16_I3_n0098_8_CYMUXG2
    );
  Cpu16_I3_n0098_8_CY0G_262 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_9,
      O => Cpu16_I3_n0098_8_CY0G
    );
  Cpu16_I3_n0098_8_CYSELG_263 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_lut2_531_O,
      O => Cpu16_I3_n0098_8_CYSELG
    );
  Cpu16_I3_Madd_n0098_inst_lut2_551 : X_LUT4
    generic map(
      INIT => X"569A"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_11,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => CHOICE902,
      ADR3 => Cpu16_I2_data_is_c(11),
      O => Cpu16_I3_Madd_n0098_inst_lut2_551_O
    );
  Cpu16_I3_n0098_10_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_10_XORF,
      O => Cpu16_I3_n0098(10)
    );
  Cpu16_I3_n0098_10_XORF_264 : X_XOR2
    port map (
      I0 => Cpu16_I3_n0098_10_CYINIT,
      I1 => Cpu16_I3_Madd_n0098_inst_lut2_541_O,
      O => Cpu16_I3_n0098_10_XORF
    );
  Cpu16_I3_n0098_10_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_10_CY0F,
      IB => Cpu16_I3_n0098_10_CYINIT,
      SEL => Cpu16_I3_n0098_10_CYSELF,
      O => Cpu16_I3_Madd_n0098_inst_cy_55
    );
  Cpu16_I3_n0098_10_CYMUXF2_265 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_10_CY0F,
      IB => Cpu16_I3_n0098_10_CY0F,
      SEL => Cpu16_I3_n0098_10_CYSELF,
      O => Cpu16_I3_n0098_10_CYMUXF2
    );
  Cpu16_I3_n0098_10_CYINIT_266 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_cy_54,
      O => Cpu16_I3_n0098_10_CYINIT
    );
  Cpu16_I3_n0098_10_CY0F_267 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_10,
      O => Cpu16_I3_n0098_10_CY0F
    );
  Cpu16_I3_n0098_10_CYSELF_268 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_lut2_541_O,
      O => Cpu16_I3_n0098_10_CYSELF
    );
  Cpu16_I3_n0098_10_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_10_XORG,
      O => Cpu16_I3_n0098(11)
    );
  Cpu16_I3_n0098_10_XORG_269 : X_XOR2
    port map (
      I0 => Cpu16_I3_Madd_n0098_inst_cy_55,
      I1 => Cpu16_I3_Madd_n0098_inst_lut2_551_O,
      O => Cpu16_I3_n0098_10_XORG
    );
  Cpu16_I3_n0098_10_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_10_CYMUXFAST,
      O => Cpu16_I3_Madd_n0098_inst_cy_56
    );
  Cpu16_I3_n0098_10_FASTCARRY_270 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_cy_54,
      O => Cpu16_I3_n0098_10_FASTCARRY
    );
  Cpu16_I3_n0098_10_CYAND_271 : X_AND2
    port map (
      I0 => Cpu16_I3_n0098_10_CYSELG,
      I1 => Cpu16_I3_n0098_10_CYSELF,
      O => Cpu16_I3_n0098_10_CYAND
    );
  Cpu16_I3_n0098_10_CYMUXFAST_272 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_10_CYMUXG2,
      IB => Cpu16_I3_n0098_10_FASTCARRY,
      SEL => Cpu16_I3_n0098_10_CYAND,
      O => Cpu16_I3_n0098_10_CYMUXFAST
    );
  Cpu16_I3_n0098_10_CYMUXG2_273 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_10_CY0G,
      IB => Cpu16_I3_n0098_10_CYMUXF2,
      SEL => Cpu16_I3_n0098_10_CYSELG,
      O => Cpu16_I3_n0098_10_CYMUXG2
    );
  Cpu16_I3_n0098_10_CY0G_274 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_11,
      O => Cpu16_I3_n0098_10_CY0G
    );
  Cpu16_I3_n0098_10_CYSELG_275 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_lut2_551_O,
      O => Cpu16_I3_n0098_10_CYSELG
    );
  Cpu16_I3_n0098_12_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_12_XORF,
      O => Cpu16_I3_n0098(12)
    );
  Cpu16_I3_n0098_12_XORF_276 : X_XOR2
    port map (
      I0 => Cpu16_I3_n0098_12_CYINIT,
      I1 => Cpu16_I3_Madd_n0098_inst_lut2_56,
      O => Cpu16_I3_n0098_12_XORF
    );
  Cpu16_I3_n0098_12_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_12_CY0F,
      IB => Cpu16_I3_n0098_12_CYINIT,
      SEL => Cpu16_I3_n0098_12_CYSELF,
      O => Cpu16_I3_Madd_n0098_inst_cy_57
    );
  Cpu16_I3_n0098_12_CYMUXF2_277 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_12_CY0F,
      IB => Cpu16_I3_n0098_12_CY0F,
      SEL => Cpu16_I3_n0098_12_CYSELF,
      O => Cpu16_I3_n0098_12_CYMUXF2
    );
  Cpu16_I3_n0098_12_CYINIT_278 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_cy_56,
      O => Cpu16_I3_n0098_12_CYINIT
    );
  Cpu16_I3_n0098_12_CY0F_279 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_12,
      O => Cpu16_I3_n0098_12_CY0F
    );
  Cpu16_I3_n0098_12_CYSELF_280 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_lut2_56,
      O => Cpu16_I3_n0098_12_CYSELF
    );
  Cpu16_I3_n0098_12_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_12_XORG,
      O => Cpu16_I3_n0098(13)
    );
  Cpu16_I3_n0098_12_XORG_281 : X_XOR2
    port map (
      I0 => Cpu16_I3_Madd_n0098_inst_cy_57,
      I1 => Cpu16_I3_Madd_n0098_inst_lut2_57,
      O => Cpu16_I3_n0098_12_XORG
    );
  Cpu16_I3_n0098_12_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_12_CYMUXFAST,
      O => Cpu16_I3_Madd_n0098_inst_cy_58
    );
  Cpu16_I3_n0098_12_FASTCARRY_282 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_cy_56,
      O => Cpu16_I3_n0098_12_FASTCARRY
    );
  Cpu16_I3_n0098_12_CYAND_283 : X_AND2
    port map (
      I0 => Cpu16_I3_n0098_12_CYSELG,
      I1 => Cpu16_I3_n0098_12_CYSELF,
      O => Cpu16_I3_n0098_12_CYAND
    );
  Cpu16_I3_n0098_12_CYMUXFAST_284 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_12_CYMUXG2,
      IB => Cpu16_I3_n0098_12_FASTCARRY,
      SEL => Cpu16_I3_n0098_12_CYAND,
      O => Cpu16_I3_n0098_12_CYMUXFAST
    );
  Cpu16_I3_n0098_12_CYMUXG2_285 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_12_CY0G,
      IB => Cpu16_I3_n0098_12_CYMUXF2,
      SEL => Cpu16_I3_n0098_12_CYSELG,
      O => Cpu16_I3_n0098_12_CYMUXG2
    );
  Cpu16_I3_n0098_12_CY0G_286 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_13,
      O => Cpu16_I3_n0098_12_CY0G
    );
  Cpu16_I3_n0098_12_CYSELG_287 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_lut2_57,
      O => Cpu16_I3_n0098_12_CYSELG
    );
  Cpu16_I3_Madd_n0098_inst_lut2_591 : X_LUT4
    generic map(
      INIT => X"3C3C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_acc_c_0_15,
      ADR2 => Cpu16_I3_data_x_15_Q,
      ADR3 => VCC,
      O => Cpu16_I3_Madd_n0098_inst_lut2_591_O
    );
  Cpu16_I3_Madd_n0098_inst_lut2_581 : X_LUT4
    generic map(
      INIT => X"02DF"
    )
    port map (
      ADR0 => Cpu16_I4_N18350,
      ADR1 => N24783,
      ADR2 => N30814,
      ADR3 => N30812,
      O => Cpu16_I3_Madd_n0098_inst_lut2_58
    );
  Cpu16_I3_n0098_14_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_14_XORF,
      O => Cpu16_I3_n0098(14)
    );
  Cpu16_I3_n0098_14_XORF_288 : X_XOR2
    port map (
      I0 => Cpu16_I3_n0098_14_CYINIT,
      I1 => Cpu16_I3_Madd_n0098_inst_lut2_58,
      O => Cpu16_I3_n0098_14_XORF
    );
  Cpu16_I3_n0098_14_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_14_CY0F,
      IB => Cpu16_I3_n0098_14_CYINIT,
      SEL => Cpu16_I3_n0098_14_CYSELF,
      O => Cpu16_I3_Madd_n0098_inst_cy_59
    );
  Cpu16_I3_n0098_14_CYMUXF2_289 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_14_CY0F,
      IB => Cpu16_I3_n0098_14_CY0F,
      SEL => Cpu16_I3_n0098_14_CYSELF,
      O => Cpu16_I3_n0098_14_CYMUXF2
    );
  Cpu16_I3_n0098_14_CYINIT_290 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_cy_58,
      O => Cpu16_I3_n0098_14_CYINIT
    );
  Cpu16_I3_n0098_14_CY0F_291 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_14,
      O => Cpu16_I3_n0098_14_CY0F
    );
  Cpu16_I3_n0098_14_CYSELF_292 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_lut2_58,
      O => Cpu16_I3_n0098_14_CYSELF
    );
  Cpu16_I3_n0098_14_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_14_XORG,
      O => Cpu16_I3_n0098(15)
    );
  Cpu16_I3_n0098_14_XORG_293 : X_XOR2
    port map (
      I0 => Cpu16_I3_Madd_n0098_inst_cy_59,
      I1 => Cpu16_I3_Madd_n0098_inst_lut2_591_O,
      O => Cpu16_I3_n0098_14_XORG
    );
  Cpu16_I3_n0098_14_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0098_14_CYMUXFAST,
      O => Cpu16_I3_n0089(16)
    );
  Cpu16_I3_n0098_14_FASTCARRY_294 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_cy_58,
      O => Cpu16_I3_n0098_14_FASTCARRY
    );
  Cpu16_I3_n0098_14_CYAND_295 : X_AND2
    port map (
      I0 => Cpu16_I3_n0098_14_CYSELG,
      I1 => Cpu16_I3_n0098_14_CYSELF,
      O => Cpu16_I3_n0098_14_CYAND
    );
  Cpu16_I3_n0098_14_CYMUXFAST_296 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_14_CYMUXG2,
      IB => Cpu16_I3_n0098_14_FASTCARRY,
      SEL => Cpu16_I3_n0098_14_CYAND,
      O => Cpu16_I3_n0098_14_CYMUXFAST
    );
  Cpu16_I3_n0098_14_CYMUXG2_297 : X_MUX2
    port map (
      IA => Cpu16_I3_n0098_14_CY0G,
      IB => Cpu16_I3_n0098_14_CYMUXF2,
      SEL => Cpu16_I3_n0098_14_CYSELG,
      O => Cpu16_I3_n0098_14_CYMUXG2
    );
  Cpu16_I3_n0098_14_CY0G_298 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_15,
      O => Cpu16_I3_n0098_14_CY0G
    );
  Cpu16_I3_n0098_14_CYSELG_299 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Madd_n0098_inst_lut2_591_O,
      O => Cpu16_I3_n0098_14_CYSELG
    );
  Cpu16_I3_Msub_n0090_inst_lut2_281 : X_LUT4
    generic map(
      INIT => X"A965"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_1,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => CHOICE1485,
      ADR3 => Cpu16_I2_data_is_c(1),
      O => Cpu16_I3_Msub_n0090_inst_lut2_281_O
    );
  Cpu16_I3_n0090_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_0_XORF,
      O => Cpu16_I3_n0090(0)
    );
  Cpu16_I3_n0090_0_XORF_300 : X_XOR2
    port map (
      I0 => Cpu16_I3_n0090_0_CYINIT,
      I1 => Cpu16_I3_n0090_0_F,
      O => Cpu16_I3_n0090_0_XORF
    );
  Cpu16_I3_n0090_0_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_0_CY0F,
      IB => Cpu16_I3_n0090_0_CYINIT,
      SEL => Cpu16_I3_n0090_0_CYSELF,
      O => Cpu16_I3_Msub_n0090_inst_cy_28
    );
  Cpu16_I3_n0090_0_CYINIT_301 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GLOBAL_LOGIC1_1,
      O => Cpu16_I3_n0090_0_CYINIT
    );
  Cpu16_I3_n0090_0_CY0F_302 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_0,
      O => Cpu16_I3_n0090_0_CY0F
    );
  Cpu16_I3_n0090_0_CYSELF_303 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_0_F,
      O => Cpu16_I3_n0090_0_CYSELF
    );
  Cpu16_I3_n0090_0_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_0_XORG,
      O => Cpu16_I3_n0090(1)
    );
  Cpu16_I3_n0090_0_XORG_304 : X_XOR2
    port map (
      I0 => Cpu16_I3_Msub_n0090_inst_cy_28,
      I1 => Cpu16_I3_Msub_n0090_inst_lut2_281_O,
      O => Cpu16_I3_n0090_0_XORG
    );
  Cpu16_I3_n0090_0_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_0_CYMUXG,
      O => Cpu16_I3_Msub_n0090_inst_cy_29
    );
  Cpu16_I3_n0090_0_CYMUXG_305 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_0_CY0G,
      IB => Cpu16_I3_Msub_n0090_inst_cy_28,
      SEL => Cpu16_I3_n0090_0_CYSELG,
      O => Cpu16_I3_n0090_0_CYMUXG
    );
  Cpu16_I3_n0090_0_CY0G_306 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_1,
      O => Cpu16_I3_n0090_0_CY0G
    );
  Cpu16_I3_n0090_0_CYSELG_307 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_lut2_281_O,
      O => Cpu16_I3_n0090_0_CYSELG
    );
  Cpu16_I3_Msub_n0090_inst_lut2_301 : X_LUT4
    generic map(
      INIT => X"A965"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_3,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => CHOICE1342,
      ADR3 => Cpu16_I2_data_is_c(3),
      O => Cpu16_I3_Msub_n0090_inst_lut2_301_O
    );
  Cpu16_I3_n0090_2_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_2_XORF,
      O => Cpu16_I3_n0090(2)
    );
  Cpu16_I3_n0090_2_XORF_308 : X_XOR2
    port map (
      I0 => Cpu16_I3_n0090_2_CYINIT,
      I1 => Cpu16_I3_Msub_n0090_inst_lut2_291_O,
      O => Cpu16_I3_n0090_2_XORF
    );
  Cpu16_I3_n0090_2_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_2_CY0F,
      IB => Cpu16_I3_n0090_2_CYINIT,
      SEL => Cpu16_I3_n0090_2_CYSELF,
      O => Cpu16_I3_Msub_n0090_inst_cy_30
    );
  Cpu16_I3_n0090_2_CYMUXF2_309 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_2_CY0F,
      IB => Cpu16_I3_n0090_2_CY0F,
      SEL => Cpu16_I3_n0090_2_CYSELF,
      O => Cpu16_I3_n0090_2_CYMUXF2
    );
  Cpu16_I3_n0090_2_CYINIT_310 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_cy_29,
      O => Cpu16_I3_n0090_2_CYINIT
    );
  Cpu16_I3_n0090_2_CY0F_311 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_2,
      O => Cpu16_I3_n0090_2_CY0F
    );
  Cpu16_I3_n0090_2_CYSELF_312 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_lut2_291_O,
      O => Cpu16_I3_n0090_2_CYSELF
    );
  Cpu16_I3_n0090_2_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_2_XORG,
      O => Cpu16_I3_n0090(3)
    );
  Cpu16_I3_n0090_2_XORG_313 : X_XOR2
    port map (
      I0 => Cpu16_I3_Msub_n0090_inst_cy_30,
      I1 => Cpu16_I3_Msub_n0090_inst_lut2_301_O,
      O => Cpu16_I3_n0090_2_XORG
    );
  Cpu16_I3_n0090_2_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_2_CYMUXFAST,
      O => Cpu16_I3_Msub_n0090_inst_cy_31
    );
  Cpu16_I3_n0090_2_FASTCARRY_314 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_cy_29,
      O => Cpu16_I3_n0090_2_FASTCARRY
    );
  Cpu16_I3_n0090_2_CYAND_315 : X_AND2
    port map (
      I0 => Cpu16_I3_n0090_2_CYSELG,
      I1 => Cpu16_I3_n0090_2_CYSELF,
      O => Cpu16_I3_n0090_2_CYAND
    );
  Cpu16_I3_n0090_2_CYMUXFAST_316 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_2_CYMUXG2,
      IB => Cpu16_I3_n0090_2_FASTCARRY,
      SEL => Cpu16_I3_n0090_2_CYAND,
      O => Cpu16_I3_n0090_2_CYMUXFAST
    );
  Cpu16_I3_n0090_2_CYMUXG2_317 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_2_CY0G,
      IB => Cpu16_I3_n0090_2_CYMUXF2,
      SEL => Cpu16_I3_n0090_2_CYSELG,
      O => Cpu16_I3_n0090_2_CYMUXG2
    );
  Cpu16_I3_n0090_2_CY0G_318 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_3,
      O => Cpu16_I3_n0090_2_CY0G
    );
  Cpu16_I3_n0090_2_CYSELG_319 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_lut2_301_O,
      O => Cpu16_I3_n0090_2_CYSELG
    );
  Cpu16_I3_Msub_n0090_inst_lut2_321 : X_LUT4
    generic map(
      INIT => X"C963"
    )
    port map (
      ADR0 => Cpu16_I3_n0025,
      ADR1 => Cpu16_I3_acc_c_0_5,
      ADR2 => CHOICE1232,
      ADR3 => Cpu16_I2_data_is_c(5),
      O => Cpu16_I3_Msub_n0090_inst_lut2_321_O
    );
  Cpu16_I3_n0090_4_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_4_XORF,
      O => Cpu16_I3_n0090(4)
    );
  Cpu16_I3_n0090_4_XORF_320 : X_XOR2
    port map (
      I0 => Cpu16_I3_n0090_4_CYINIT,
      I1 => Cpu16_I3_Msub_n0090_inst_lut2_311_O,
      O => Cpu16_I3_n0090_4_XORF
    );
  Cpu16_I3_n0090_4_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_4_CY0F,
      IB => Cpu16_I3_n0090_4_CYINIT,
      SEL => Cpu16_I3_n0090_4_CYSELF,
      O => Cpu16_I3_Msub_n0090_inst_cy_32
    );
  Cpu16_I3_n0090_4_CYMUXF2_321 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_4_CY0F,
      IB => Cpu16_I3_n0090_4_CY0F,
      SEL => Cpu16_I3_n0090_4_CYSELF,
      O => Cpu16_I3_n0090_4_CYMUXF2
    );
  Cpu16_I3_n0090_4_CYINIT_322 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_cy_31,
      O => Cpu16_I3_n0090_4_CYINIT
    );
  Cpu16_I3_n0090_4_CY0F_323 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_4,
      O => Cpu16_I3_n0090_4_CY0F
    );
  Cpu16_I3_n0090_4_CYSELF_324 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_lut2_311_O,
      O => Cpu16_I3_n0090_4_CYSELF
    );
  Cpu16_I3_n0090_4_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_4_XORG,
      O => Cpu16_I3_n0090(5)
    );
  Cpu16_I3_n0090_4_XORG_325 : X_XOR2
    port map (
      I0 => Cpu16_I3_Msub_n0090_inst_cy_32,
      I1 => Cpu16_I3_Msub_n0090_inst_lut2_321_O,
      O => Cpu16_I3_n0090_4_XORG
    );
  Cpu16_I3_n0090_4_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_4_CYMUXFAST,
      O => Cpu16_I3_Msub_n0090_inst_cy_33
    );
  Cpu16_I3_n0090_4_FASTCARRY_326 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_cy_31,
      O => Cpu16_I3_n0090_4_FASTCARRY
    );
  Cpu16_I3_n0090_4_CYAND_327 : X_AND2
    port map (
      I0 => Cpu16_I3_n0090_4_CYSELG,
      I1 => Cpu16_I3_n0090_4_CYSELF,
      O => Cpu16_I3_n0090_4_CYAND
    );
  Cpu16_I3_n0090_4_CYMUXFAST_328 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_4_CYMUXG2,
      IB => Cpu16_I3_n0090_4_FASTCARRY,
      SEL => Cpu16_I3_n0090_4_CYAND,
      O => Cpu16_I3_n0090_4_CYMUXFAST
    );
  Cpu16_I3_n0090_4_CYMUXG2_329 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_4_CY0G,
      IB => Cpu16_I3_n0090_4_CYMUXF2,
      SEL => Cpu16_I3_n0090_4_CYSELG,
      O => Cpu16_I3_n0090_4_CYMUXG2
    );
  Cpu16_I3_n0090_4_CY0G_330 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_5,
      O => Cpu16_I3_n0090_4_CY0G
    );
  Cpu16_I3_n0090_4_CYSELG_331 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_lut2_321_O,
      O => Cpu16_I3_n0090_4_CYSELG
    );
  Cpu16_I3_Msub_n0090_inst_lut2_331 : X_LUT4
    generic map(
      INIT => X"C963"
    )
    port map (
      ADR0 => Cpu16_I3_n0025,
      ADR1 => Cpu16_I3_acc_c_0_6,
      ADR2 => CHOICE1177,
      ADR3 => Cpu16_I2_data_is_c(6),
      O => Cpu16_I3_Msub_n0090_inst_lut2_331_O
    );
  Cpu16_I3_n0090_6_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_6_XORF,
      O => Cpu16_I3_n0090(6)
    );
  Cpu16_I3_n0090_6_XORF_332 : X_XOR2
    port map (
      I0 => Cpu16_I3_n0090_6_CYINIT,
      I1 => Cpu16_I3_Msub_n0090_inst_lut2_331_O,
      O => Cpu16_I3_n0090_6_XORF
    );
  Cpu16_I3_n0090_6_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_6_CY0F,
      IB => Cpu16_I3_n0090_6_CYINIT,
      SEL => Cpu16_I3_n0090_6_CYSELF,
      O => Cpu16_I3_Msub_n0090_inst_cy_34
    );
  Cpu16_I3_n0090_6_CYMUXF2_333 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_6_CY0F,
      IB => Cpu16_I3_n0090_6_CY0F,
      SEL => Cpu16_I3_n0090_6_CYSELF,
      O => Cpu16_I3_n0090_6_CYMUXF2
    );
  Cpu16_I3_n0090_6_CYINIT_334 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_cy_33,
      O => Cpu16_I3_n0090_6_CYINIT
    );
  Cpu16_I3_n0090_6_CY0F_335 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_6,
      O => Cpu16_I3_n0090_6_CY0F
    );
  Cpu16_I3_n0090_6_CYSELF_336 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_lut2_331_O,
      O => Cpu16_I3_n0090_6_CYSELF
    );
  Cpu16_I3_n0090_6_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_6_XORG,
      O => Cpu16_I3_n0090(7)
    );
  Cpu16_I3_n0090_6_XORG_337 : X_XOR2
    port map (
      I0 => Cpu16_I3_Msub_n0090_inst_cy_34,
      I1 => Cpu16_I3_Msub_n0090_inst_lut2_341_O,
      O => Cpu16_I3_n0090_6_XORG
    );
  Cpu16_I3_n0090_6_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_6_CYMUXFAST,
      O => Cpu16_I3_Msub_n0090_inst_cy_35
    );
  Cpu16_I3_n0090_6_FASTCARRY_338 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_cy_33,
      O => Cpu16_I3_n0090_6_FASTCARRY
    );
  Cpu16_I3_n0090_6_CYAND_339 : X_AND2
    port map (
      I0 => Cpu16_I3_n0090_6_CYSELG,
      I1 => Cpu16_I3_n0090_6_CYSELF,
      O => Cpu16_I3_n0090_6_CYAND
    );
  Cpu16_I3_n0090_6_CYMUXFAST_340 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_6_CYMUXG2,
      IB => Cpu16_I3_n0090_6_FASTCARRY,
      SEL => Cpu16_I3_n0090_6_CYAND,
      O => Cpu16_I3_n0090_6_CYMUXFAST
    );
  Cpu16_I3_n0090_6_CYMUXG2_341 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_6_CY0G,
      IB => Cpu16_I3_n0090_6_CYMUXF2,
      SEL => Cpu16_I3_n0090_6_CYSELG,
      O => Cpu16_I3_n0090_6_CYMUXG2
    );
  Cpu16_I3_n0090_6_CY0G_342 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_7,
      O => Cpu16_I3_n0090_6_CY0G
    );
  Cpu16_I3_n0090_6_CYSELG_343 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_lut2_341_O,
      O => Cpu16_I3_n0090_6_CYSELG
    );
  Cpu16_I3_Msub_n0090_inst_lut2_351 : X_LUT4
    generic map(
      INIT => X"C693"
    )
    port map (
      ADR0 => Cpu16_I3_n0025,
      ADR1 => Cpu16_I3_acc_c_0_8,
      ADR2 => Cpu16_I2_data_is_c(8),
      ADR3 => CHOICE1067,
      O => Cpu16_I3_Msub_n0090_inst_lut2_351_O
    );
  Cpu16_I3_n0090_8_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_8_XORF,
      O => Cpu16_I3_n0090(8)
    );
  Cpu16_I3_n0090_8_XORF_344 : X_XOR2
    port map (
      I0 => Cpu16_I3_n0090_8_CYINIT,
      I1 => Cpu16_I3_Msub_n0090_inst_lut2_351_O,
      O => Cpu16_I3_n0090_8_XORF
    );
  Cpu16_I3_n0090_8_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_8_CY0F,
      IB => Cpu16_I3_n0090_8_CYINIT,
      SEL => Cpu16_I3_n0090_8_CYSELF,
      O => Cpu16_I3_Msub_n0090_inst_cy_36
    );
  Cpu16_I3_n0090_8_CYMUXF2_345 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_8_CY0F,
      IB => Cpu16_I3_n0090_8_CY0F,
      SEL => Cpu16_I3_n0090_8_CYSELF,
      O => Cpu16_I3_n0090_8_CYMUXF2
    );
  Cpu16_I3_n0090_8_CYINIT_346 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_cy_35,
      O => Cpu16_I3_n0090_8_CYINIT
    );
  Cpu16_I3_n0090_8_CY0F_347 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_8,
      O => Cpu16_I3_n0090_8_CY0F
    );
  Cpu16_I3_n0090_8_CYSELF_348 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_lut2_351_O,
      O => Cpu16_I3_n0090_8_CYSELF
    );
  Cpu16_I3_n0090_8_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_8_XORG,
      O => Cpu16_I3_n0090(9)
    );
  Cpu16_I3_n0090_8_XORG_349 : X_XOR2
    port map (
      I0 => Cpu16_I3_Msub_n0090_inst_cy_36,
      I1 => Cpu16_I3_Msub_n0090_inst_lut2_361_O,
      O => Cpu16_I3_n0090_8_XORG
    );
  Cpu16_I3_n0090_8_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_8_CYMUXFAST,
      O => Cpu16_I3_Msub_n0090_inst_cy_37
    );
  Cpu16_I3_n0090_8_FASTCARRY_350 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_cy_35,
      O => Cpu16_I3_n0090_8_FASTCARRY
    );
  Cpu16_I3_n0090_8_CYAND_351 : X_AND2
    port map (
      I0 => Cpu16_I3_n0090_8_CYSELG,
      I1 => Cpu16_I3_n0090_8_CYSELF,
      O => Cpu16_I3_n0090_8_CYAND
    );
  Cpu16_I3_n0090_8_CYMUXFAST_352 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_8_CYMUXG2,
      IB => Cpu16_I3_n0090_8_FASTCARRY,
      SEL => Cpu16_I3_n0090_8_CYAND,
      O => Cpu16_I3_n0090_8_CYMUXFAST
    );
  Cpu16_I3_n0090_8_CYMUXG2_353 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_8_CY0G,
      IB => Cpu16_I3_n0090_8_CYMUXF2,
      SEL => Cpu16_I3_n0090_8_CYSELG,
      O => Cpu16_I3_n0090_8_CYMUXG2
    );
  Cpu16_I3_n0090_8_CY0G_354 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_9,
      O => Cpu16_I3_n0090_8_CY0G
    );
  Cpu16_I3_n0090_8_CYSELG_355 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_lut2_361_O,
      O => Cpu16_I3_n0090_8_CYSELG
    );
  XLXI_4_Maddsub_n0001_inst_lut2_11 : X_LUT4
    generic map(
      INIT => X"1D55"
    )
    port map (
      ADR0 => N30770,
      ADR1 => Cpu16_pc_mux(1),
      ADR2 => XLXI_4_n00021_SW3_O,
      ADR3 => Cpu16_pc_mux(0),
      O => XLXI_4_Maddsub_n0001_inst_lut2_1
    );
  Cpu16_I3_Msub_n0090_inst_lut2_371 : X_LUT4
    generic map(
      INIT => X"C963"
    )
    port map (
      ADR0 => Cpu16_I3_n0025,
      ADR1 => Cpu16_I3_acc_c_0_10,
      ADR2 => CHOICE957,
      ADR3 => Cpu16_I2_data_is_c(10),
      O => Cpu16_I3_Msub_n0090_inst_lut2_371_O
    );
  Cpu16_I3_Msub_n0090_inst_lut2_381 : X_LUT4
    generic map(
      INIT => X"C693"
    )
    port map (
      ADR0 => Cpu16_I3_n0025,
      ADR1 => Cpu16_I3_acc_c_0_11,
      ADR2 => Cpu16_I2_data_is_c(11),
      ADR3 => CHOICE902,
      O => Cpu16_I3_Msub_n0090_inst_lut2_381_O
    );
  Cpu16_I3_n0090_10_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_10_XORF,
      O => Cpu16_I3_n0090(10)
    );
  Cpu16_I3_n0090_10_XORF_356 : X_XOR2
    port map (
      I0 => Cpu16_I3_n0090_10_CYINIT,
      I1 => Cpu16_I3_Msub_n0090_inst_lut2_371_O,
      O => Cpu16_I3_n0090_10_XORF
    );
  Cpu16_I3_n0090_10_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_10_CY0F,
      IB => Cpu16_I3_n0090_10_CYINIT,
      SEL => Cpu16_I3_n0090_10_CYSELF,
      O => Cpu16_I3_Msub_n0090_inst_cy_38
    );
  Cpu16_I3_n0090_10_CYMUXF2_357 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_10_CY0F,
      IB => Cpu16_I3_n0090_10_CY0F,
      SEL => Cpu16_I3_n0090_10_CYSELF,
      O => Cpu16_I3_n0090_10_CYMUXF2
    );
  Cpu16_I3_n0090_10_CYINIT_358 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_cy_37,
      O => Cpu16_I3_n0090_10_CYINIT
    );
  Cpu16_I3_n0090_10_CY0F_359 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_10,
      O => Cpu16_I3_n0090_10_CY0F
    );
  Cpu16_I3_n0090_10_CYSELF_360 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_lut2_371_O,
      O => Cpu16_I3_n0090_10_CYSELF
    );
  Cpu16_I3_n0090_10_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_10_XORG,
      O => Cpu16_I3_n0090(11)
    );
  Cpu16_I3_n0090_10_XORG_361 : X_XOR2
    port map (
      I0 => Cpu16_I3_Msub_n0090_inst_cy_38,
      I1 => Cpu16_I3_Msub_n0090_inst_lut2_381_O,
      O => Cpu16_I3_n0090_10_XORG
    );
  Cpu16_I3_n0090_10_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_10_CYMUXFAST,
      O => Cpu16_I3_Msub_n0090_inst_cy_39
    );
  Cpu16_I3_n0090_10_FASTCARRY_362 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_cy_37,
      O => Cpu16_I3_n0090_10_FASTCARRY
    );
  Cpu16_I3_n0090_10_CYAND_363 : X_AND2
    port map (
      I0 => Cpu16_I3_n0090_10_CYSELG,
      I1 => Cpu16_I3_n0090_10_CYSELF,
      O => Cpu16_I3_n0090_10_CYAND
    );
  Cpu16_I3_n0090_10_CYMUXFAST_364 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_10_CYMUXG2,
      IB => Cpu16_I3_n0090_10_FASTCARRY,
      SEL => Cpu16_I3_n0090_10_CYAND,
      O => Cpu16_I3_n0090_10_CYMUXFAST
    );
  Cpu16_I3_n0090_10_CYMUXG2_365 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_10_CY0G,
      IB => Cpu16_I3_n0090_10_CYMUXF2,
      SEL => Cpu16_I3_n0090_10_CYSELG,
      O => Cpu16_I3_n0090_10_CYMUXG2
    );
  Cpu16_I3_n0090_10_CY0G_366 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_11,
      O => Cpu16_I3_n0090_10_CY0G
    );
  Cpu16_I3_n0090_10_CYSELG_367 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_lut2_381_O,
      O => Cpu16_I3_n0090_10_CYSELG
    );
  Cpu16_I3_n0090_12_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_12_XORF,
      O => Cpu16_I3_n0090(12)
    );
  Cpu16_I3_n0090_12_XORF_368 : X_XOR2
    port map (
      I0 => Cpu16_I3_n0090_12_CYINIT,
      I1 => Cpu16_I3_Msub_n0090_inst_lut2_39,
      O => Cpu16_I3_n0090_12_XORF
    );
  Cpu16_I3_n0090_12_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_12_CY0F,
      IB => Cpu16_I3_n0090_12_CYINIT,
      SEL => Cpu16_I3_n0090_12_CYSELF,
      O => Cpu16_I3_Msub_n0090_inst_cy_40
    );
  Cpu16_I3_n0090_12_CYMUXF2_369 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_12_CY0F,
      IB => Cpu16_I3_n0090_12_CY0F,
      SEL => Cpu16_I3_n0090_12_CYSELF,
      O => Cpu16_I3_n0090_12_CYMUXF2
    );
  Cpu16_I3_n0090_12_CYINIT_370 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_cy_39,
      O => Cpu16_I3_n0090_12_CYINIT
    );
  Cpu16_I3_n0090_12_CY0F_371 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_12,
      O => Cpu16_I3_n0090_12_CY0F
    );
  Cpu16_I3_n0090_12_CYSELF_372 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_lut2_39,
      O => Cpu16_I3_n0090_12_CYSELF
    );
  Cpu16_I3_n0090_12_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_12_XORG,
      O => Cpu16_I3_n0090(13)
    );
  Cpu16_I3_n0090_12_XORG_373 : X_XOR2
    port map (
      I0 => Cpu16_I3_Msub_n0090_inst_cy_40,
      I1 => Cpu16_I3_Msub_n0090_inst_lut2_40,
      O => Cpu16_I3_n0090_12_XORG
    );
  Cpu16_I3_n0090_12_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_12_CYMUXFAST,
      O => Cpu16_I3_Msub_n0090_inst_cy_41
    );
  Cpu16_I3_n0090_12_FASTCARRY_374 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_cy_39,
      O => Cpu16_I3_n0090_12_FASTCARRY
    );
  Cpu16_I3_n0090_12_CYAND_375 : X_AND2
    port map (
      I0 => Cpu16_I3_n0090_12_CYSELG,
      I1 => Cpu16_I3_n0090_12_CYSELF,
      O => Cpu16_I3_n0090_12_CYAND
    );
  Cpu16_I3_n0090_12_CYMUXFAST_376 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_12_CYMUXG2,
      IB => Cpu16_I3_n0090_12_FASTCARRY,
      SEL => Cpu16_I3_n0090_12_CYAND,
      O => Cpu16_I3_n0090_12_CYMUXFAST
    );
  Cpu16_I3_n0090_12_CYMUXG2_377 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_12_CY0G,
      IB => Cpu16_I3_n0090_12_CYMUXF2,
      SEL => Cpu16_I3_n0090_12_CYSELG,
      O => Cpu16_I3_n0090_12_CYMUXG2
    );
  Cpu16_I3_n0090_12_CY0G_378 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_13,
      O => Cpu16_I3_n0090_12_CY0G
    );
  Cpu16_I3_n0090_12_CYSELG_379 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_lut2_40,
      O => Cpu16_I3_n0090_12_CYSELG
    );
  Cpu16_I3_Msub_n0090_inst_lut2_421 : X_LUT4
    generic map(
      INIT => X"AA55"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_15,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => Cpu16_I3_data_x_15_Q,
      O => Cpu16_I3_Msub_n0090_inst_lut2_421_O
    );
  Cpu16_I3_n0090_14_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_14_XORF,
      O => Cpu16_I3_n0090(14)
    );
  Cpu16_I3_n0090_14_XORF_380 : X_XOR2
    port map (
      I0 => Cpu16_I3_n0090_14_CYINIT,
      I1 => Cpu16_I3_Msub_n0090_inst_lut2_41,
      O => Cpu16_I3_n0090_14_XORF
    );
  Cpu16_I3_n0090_14_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_14_CY0F,
      IB => Cpu16_I3_n0090_14_CYINIT,
      SEL => Cpu16_I3_n0090_14_CYSELF,
      O => Cpu16_I3_Msub_n0090_inst_cy_42
    );
  Cpu16_I3_n0090_14_CYMUXF2_381 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_14_CY0F,
      IB => Cpu16_I3_n0090_14_CY0F,
      SEL => Cpu16_I3_n0090_14_CYSELF,
      O => Cpu16_I3_n0090_14_CYMUXF2
    );
  Cpu16_I3_n0090_14_CYINIT_382 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_cy_41,
      O => Cpu16_I3_n0090_14_CYINIT
    );
  Cpu16_I3_n0090_14_CY0F_383 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_14,
      O => Cpu16_I3_n0090_14_CY0F
    );
  Cpu16_I3_n0090_14_CYSELF_384 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_lut2_41,
      O => Cpu16_I3_n0090_14_CYSELF
    );
  Cpu16_I3_n0090_14_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_14_XORG,
      O => Cpu16_I3_n0090(15)
    );
  Cpu16_I3_n0090_14_XORG_385 : X_XOR2
    port map (
      I0 => Cpu16_I3_Msub_n0090_inst_cy_42,
      I1 => Cpu16_I3_Msub_n0090_inst_lut2_421_O,
      O => Cpu16_I3_n0090_14_XORG
    );
  Cpu16_I3_n0090_14_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_14_CYMUXFAST,
      O => Cpu16_I3_Msub_n0090_inst_cy_43
    );
  Cpu16_I3_n0090_14_FASTCARRY_386 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_cy_41,
      O => Cpu16_I3_n0090_14_FASTCARRY
    );
  Cpu16_I3_n0090_14_CYAND_387 : X_AND2
    port map (
      I0 => Cpu16_I3_n0090_14_CYSELG,
      I1 => Cpu16_I3_n0090_14_CYSELF,
      O => Cpu16_I3_n0090_14_CYAND
    );
  Cpu16_I3_n0090_14_CYMUXFAST_388 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_14_CYMUXG2,
      IB => Cpu16_I3_n0090_14_FASTCARRY,
      SEL => Cpu16_I3_n0090_14_CYAND,
      O => Cpu16_I3_n0090_14_CYMUXFAST
    );
  Cpu16_I3_n0090_14_CYMUXG2_389 : X_MUX2
    port map (
      IA => Cpu16_I3_n0090_14_CY0G,
      IB => Cpu16_I3_n0090_14_CYMUXF2,
      SEL => Cpu16_I3_n0090_14_CYSELG,
      O => Cpu16_I3_n0090_14_CYMUXG2
    );
  Cpu16_I3_n0090_14_CY0G_390 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_15,
      O => Cpu16_I3_n0090_14_CY0G
    );
  Cpu16_I3_n0090_14_CYSELG_391 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_lut2_421_O,
      O => Cpu16_I3_n0090_14_CYSELG
    );
  XLXI_4_Maddsub_n0001_inst_lut2_61 : X_LUT4
    generic map(
      INIT => X"3C3C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_4_n0002,
      ADR2 => XLXI_4_addr_c(7),
      ADR3 => VCC,
      O => XLXI_4_Maddsub_n0001_inst_lut2_61_O
    );
  Cpu16_I4_Madd_n0182_inst_lut2_601 : X_LUT4
    generic map(
      INIT => X"33CC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I4_iinc_c(0),
      ADR2 => VCC,
      ADR3 => Cpu16_I4_ireg_c(0),
      O => Cpu16_I4_Madd_n0182_inst_lut2_60_F
    );
  Cpu16_I4_Madd_n0182_inst_lut2_611 : X_LUT4
    generic map(
      INIT => X"55AA"
    )
    port map (
      ADR0 => Cpu16_I4_iinc_c(1),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => Cpu16_I4_ireg_c(1),
      O => Cpu16_I4_Madd_n0182_inst_lut2_61
    );
  Cpu16_I4_Madd_n0182_inst_lut2_60_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_lut2_60_F,
      O => Cpu16_I4_Madd_n0182_inst_lut2_60
    );
  Cpu16_I4_Madd_n0182_inst_lut2_60_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I4_Madd_n0182_inst_lut2_60_CY0F,
      IB => Cpu16_I4_Madd_n0182_inst_lut2_60_CYINIT,
      SEL => Cpu16_I4_Madd_n0182_inst_lut2_60_CYSELF,
      O => Cpu16_I4_Madd_n0182_inst_cy_61
    );
  Cpu16_I4_Madd_n0182_inst_lut2_60_CYINIT_392 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_lut2_60_BXINVNOT,
      O => Cpu16_I4_Madd_n0182_inst_lut2_60_CYINIT
    );
  Cpu16_I4_Madd_n0182_inst_lut2_60_CY0F_393 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_c(0),
      O => Cpu16_I4_Madd_n0182_inst_lut2_60_CY0F
    );
  Cpu16_I4_Madd_n0182_inst_lut2_60_CYSELF_394 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_lut2_60_F,
      O => Cpu16_I4_Madd_n0182_inst_lut2_60_CYSELF
    );
  Cpu16_I4_Madd_n0182_inst_lut2_60_BXINV : X_INV
    port map (
      I => GLOBAL_LOGIC1_3,
      O => Cpu16_I4_Madd_n0182_inst_lut2_60_BXINVNOT
    );
  Cpu16_I4_Madd_n0182_inst_lut2_60_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_lut2_60_XORG,
      O => Cpu16_I4_n0182(1)
    );
  Cpu16_I4_Madd_n0182_inst_lut2_60_XORG_395 : X_XOR2
    port map (
      I0 => Cpu16_I4_Madd_n0182_inst_cy_61,
      I1 => Cpu16_I4_Madd_n0182_inst_lut2_61,
      O => Cpu16_I4_Madd_n0182_inst_lut2_60_XORG
    );
  Cpu16_I4_Madd_n0182_inst_lut2_60_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_lut2_60_CYMUXG,
      O => Cpu16_I4_Madd_n0182_inst_cy_62
    );
  Cpu16_I4_Madd_n0182_inst_lut2_60_CYMUXG_396 : X_MUX2
    port map (
      IA => Cpu16_I4_Madd_n0182_inst_lut2_60_CY0G,
      IB => Cpu16_I4_Madd_n0182_inst_cy_61,
      SEL => Cpu16_I4_Madd_n0182_inst_lut2_60_CYSELG,
      O => Cpu16_I4_Madd_n0182_inst_lut2_60_CYMUXG
    );
  Cpu16_I4_Madd_n0182_inst_lut2_60_CY0G_397 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_c(1),
      O => Cpu16_I4_Madd_n0182_inst_lut2_60_CY0G
    );
  Cpu16_I4_Madd_n0182_inst_lut2_60_CYSELG_398 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_lut2_61,
      O => Cpu16_I4_Madd_n0182_inst_lut2_60_CYSELG
    );
  Cpu16_I4_Madd_n0182_inst_lut2_621 : X_LUT4
    generic map(
      INIT => X"6666"
    )
    port map (
      ADR0 => Cpu16_I4_iinc_c(2),
      ADR1 => Cpu16_I4_ireg_c(2),
      ADR2 => VCC,
      ADR3 => VCC,
      O => Cpu16_I4_Madd_n0182_inst_lut2_62
    );
  Cpu16_I4_Madd_n0182_inst_lut2_631 : X_LUT4
    generic map(
      INIT => X"3C3C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I4_iinc_c(3),
      ADR2 => Cpu16_I4_ireg_c(3),
      ADR3 => VCC,
      O => Cpu16_I4_Madd_n0182_inst_lut2_63
    );
  Cpu16_I4_n0182_2_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0182_2_XORF,
      O => Cpu16_I4_n0182(2)
    );
  Cpu16_I4_n0182_2_XORF_399 : X_XOR2
    port map (
      I0 => Cpu16_I4_n0182_2_CYINIT,
      I1 => Cpu16_I4_Madd_n0182_inst_lut2_62,
      O => Cpu16_I4_n0182_2_XORF
    );
  Cpu16_I4_n0182_2_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I4_n0182_2_CY0F,
      IB => Cpu16_I4_n0182_2_CYINIT,
      SEL => Cpu16_I4_n0182_2_CYSELF,
      O => Cpu16_I4_Madd_n0182_inst_cy_63
    );
  Cpu16_I4_n0182_2_CYMUXF2_400 : X_MUX2
    port map (
      IA => Cpu16_I4_n0182_2_CY0F,
      IB => Cpu16_I4_n0182_2_CY0F,
      SEL => Cpu16_I4_n0182_2_CYSELF,
      O => Cpu16_I4_n0182_2_CYMUXF2
    );
  Cpu16_I4_n0182_2_CYINIT_401 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_cy_62,
      O => Cpu16_I4_n0182_2_CYINIT
    );
  Cpu16_I4_n0182_2_CY0F_402 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_c(2),
      O => Cpu16_I4_n0182_2_CY0F
    );
  Cpu16_I4_n0182_2_CYSELF_403 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_lut2_62,
      O => Cpu16_I4_n0182_2_CYSELF
    );
  Cpu16_I4_n0182_2_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0182_2_XORG,
      O => Cpu16_I4_n0182(3)
    );
  Cpu16_I4_n0182_2_XORG_404 : X_XOR2
    port map (
      I0 => Cpu16_I4_Madd_n0182_inst_cy_63,
      I1 => Cpu16_I4_Madd_n0182_inst_lut2_63,
      O => Cpu16_I4_n0182_2_XORG
    );
  Cpu16_I4_n0182_2_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0182_2_CYMUXFAST,
      O => Cpu16_I4_Madd_n0182_inst_cy_64
    );
  Cpu16_I4_n0182_2_FASTCARRY_405 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_cy_62,
      O => Cpu16_I4_n0182_2_FASTCARRY
    );
  Cpu16_I4_n0182_2_CYAND_406 : X_AND2
    port map (
      I0 => Cpu16_I4_n0182_2_CYSELG,
      I1 => Cpu16_I4_n0182_2_CYSELF,
      O => Cpu16_I4_n0182_2_CYAND
    );
  Cpu16_I4_n0182_2_CYMUXFAST_407 : X_MUX2
    port map (
      IA => Cpu16_I4_n0182_2_CYMUXG2,
      IB => Cpu16_I4_n0182_2_FASTCARRY,
      SEL => Cpu16_I4_n0182_2_CYAND,
      O => Cpu16_I4_n0182_2_CYMUXFAST
    );
  Cpu16_I4_n0182_2_CYMUXG2_408 : X_MUX2
    port map (
      IA => Cpu16_I4_n0182_2_CY0G,
      IB => Cpu16_I4_n0182_2_CYMUXF2,
      SEL => Cpu16_I4_n0182_2_CYSELG,
      O => Cpu16_I4_n0182_2_CYMUXG2
    );
  Cpu16_I4_n0182_2_CY0G_409 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_c(3),
      O => Cpu16_I4_n0182_2_CY0G
    );
  Cpu16_I4_n0182_2_CYSELG_410 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_lut2_63,
      O => Cpu16_I4_n0182_2_CYSELG
    );
  Cpu16_I4_Madd_n0182_inst_lut2_641 : X_LUT4
    generic map(
      INIT => X"6666"
    )
    port map (
      ADR0 => Cpu16_I4_iinc_c(4),
      ADR1 => Cpu16_I4_ireg_c(4),
      ADR2 => VCC,
      ADR3 => VCC,
      O => Cpu16_I4_Madd_n0182_inst_lut2_64
    );
  Cpu16_I4_Madd_n0182_inst_lut2_651 : X_LUT4
    generic map(
      INIT => X"33CC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I4_iinc_c(5),
      ADR2 => VCC,
      ADR3 => Cpu16_I4_ireg_c(5),
      O => Cpu16_I4_Madd_n0182_inst_lut2_65
    );
  Cpu16_I4_n0182_4_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0182_4_XORF,
      O => Cpu16_I4_n0182(4)
    );
  Cpu16_I4_n0182_4_XORF_411 : X_XOR2
    port map (
      I0 => Cpu16_I4_n0182_4_CYINIT,
      I1 => Cpu16_I4_Madd_n0182_inst_lut2_64,
      O => Cpu16_I4_n0182_4_XORF
    );
  Cpu16_I4_n0182_4_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I4_n0182_4_CY0F,
      IB => Cpu16_I4_n0182_4_CYINIT,
      SEL => Cpu16_I4_n0182_4_CYSELF,
      O => Cpu16_I4_Madd_n0182_inst_cy_65
    );
  Cpu16_I4_n0182_4_CYMUXF2_412 : X_MUX2
    port map (
      IA => Cpu16_I4_n0182_4_CY0F,
      IB => Cpu16_I4_n0182_4_CY0F,
      SEL => Cpu16_I4_n0182_4_CYSELF,
      O => Cpu16_I4_n0182_4_CYMUXF2
    );
  Cpu16_I4_n0182_4_CYINIT_413 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_cy_64,
      O => Cpu16_I4_n0182_4_CYINIT
    );
  Cpu16_I4_n0182_4_CY0F_414 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_c(4),
      O => Cpu16_I4_n0182_4_CY0F
    );
  Cpu16_I4_n0182_4_CYSELF_415 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_lut2_64,
      O => Cpu16_I4_n0182_4_CYSELF
    );
  Cpu16_I4_n0182_4_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0182_4_XORG,
      O => Cpu16_I4_n0182(5)
    );
  Cpu16_I4_n0182_4_XORG_416 : X_XOR2
    port map (
      I0 => Cpu16_I4_Madd_n0182_inst_cy_65,
      I1 => Cpu16_I4_Madd_n0182_inst_lut2_65,
      O => Cpu16_I4_n0182_4_XORG
    );
  Cpu16_I4_n0182_4_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0182_4_CYMUXFAST,
      O => Cpu16_I4_Madd_n0182_inst_cy_66
    );
  Cpu16_I4_n0182_4_FASTCARRY_417 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_cy_64,
      O => Cpu16_I4_n0182_4_FASTCARRY
    );
  Cpu16_I4_n0182_4_CYAND_418 : X_AND2
    port map (
      I0 => Cpu16_I4_n0182_4_CYSELG,
      I1 => Cpu16_I4_n0182_4_CYSELF,
      O => Cpu16_I4_n0182_4_CYAND
    );
  Cpu16_I4_n0182_4_CYMUXFAST_419 : X_MUX2
    port map (
      IA => Cpu16_I4_n0182_4_CYMUXG2,
      IB => Cpu16_I4_n0182_4_FASTCARRY,
      SEL => Cpu16_I4_n0182_4_CYAND,
      O => Cpu16_I4_n0182_4_CYMUXFAST
    );
  Cpu16_I4_n0182_4_CYMUXG2_420 : X_MUX2
    port map (
      IA => Cpu16_I4_n0182_4_CY0G,
      IB => Cpu16_I4_n0182_4_CYMUXF2,
      SEL => Cpu16_I4_n0182_4_CYSELG,
      O => Cpu16_I4_n0182_4_CYMUXG2
    );
  Cpu16_I4_n0182_4_CY0G_421 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_c(5),
      O => Cpu16_I4_n0182_4_CY0G
    );
  Cpu16_I4_n0182_4_CYSELG_422 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_lut2_65,
      O => Cpu16_I4_n0182_4_CYSELG
    );
  Cpu16_I4_Madd_n0182_inst_lut2_671 : X_LUT4
    generic map(
      INIT => X"33CC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I4_iinc_c(7),
      ADR2 => VCC,
      ADR3 => Cpu16_I4_ireg_c(7),
      O => Cpu16_I4_Madd_n0182_inst_lut2_67
    );
  Cpu16_I4_Madd_n0182_inst_lut2_661 : X_LUT4
    generic map(
      INIT => X"3C3C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I4_iinc_c(6),
      ADR2 => Cpu16_I4_ireg_c(6),
      ADR3 => VCC,
      O => Cpu16_I4_Madd_n0182_inst_lut2_66
    );
  Cpu16_I4_n0182_6_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0182_6_XORF,
      O => Cpu16_I4_n0182(6)
    );
  Cpu16_I4_n0182_6_XORF_423 : X_XOR2
    port map (
      I0 => Cpu16_I4_n0182_6_CYINIT,
      I1 => Cpu16_I4_Madd_n0182_inst_lut2_66,
      O => Cpu16_I4_n0182_6_XORF
    );
  Cpu16_I4_n0182_6_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I4_n0182_6_CY0F,
      IB => Cpu16_I4_n0182_6_CYINIT,
      SEL => Cpu16_I4_n0182_6_CYSELF,
      O => Cpu16_I4_Madd_n0182_inst_cy_67
    );
  Cpu16_I4_n0182_6_CYMUXF2_424 : X_MUX2
    port map (
      IA => Cpu16_I4_n0182_6_CY0F,
      IB => Cpu16_I4_n0182_6_CY0F,
      SEL => Cpu16_I4_n0182_6_CYSELF,
      O => Cpu16_I4_n0182_6_CYMUXF2
    );
  Cpu16_I4_n0182_6_CYINIT_425 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_cy_66,
      O => Cpu16_I4_n0182_6_CYINIT
    );
  Cpu16_I4_n0182_6_CY0F_426 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_c(6),
      O => Cpu16_I4_n0182_6_CY0F
    );
  Cpu16_I4_n0182_6_CYSELF_427 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_lut2_66,
      O => Cpu16_I4_n0182_6_CYSELF
    );
  Cpu16_I4_n0182_6_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0182_6_XORG,
      O => Cpu16_I4_n0182(7)
    );
  Cpu16_I4_n0182_6_XORG_428 : X_XOR2
    port map (
      I0 => Cpu16_I4_Madd_n0182_inst_cy_67,
      I1 => Cpu16_I4_Madd_n0182_inst_lut2_67,
      O => Cpu16_I4_n0182_6_XORG
    );
  Cpu16_I4_n0182_6_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0182_6_CYMUXFAST,
      O => Cpu16_I4_Madd_n0182_inst_cy_68
    );
  Cpu16_I4_n0182_6_FASTCARRY_429 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_cy_66,
      O => Cpu16_I4_n0182_6_FASTCARRY
    );
  Cpu16_I4_n0182_6_CYAND_430 : X_AND2
    port map (
      I0 => Cpu16_I4_n0182_6_CYSELG,
      I1 => Cpu16_I4_n0182_6_CYSELF,
      O => Cpu16_I4_n0182_6_CYAND
    );
  Cpu16_I4_n0182_6_CYMUXFAST_431 : X_MUX2
    port map (
      IA => Cpu16_I4_n0182_6_CYMUXG2,
      IB => Cpu16_I4_n0182_6_FASTCARRY,
      SEL => Cpu16_I4_n0182_6_CYAND,
      O => Cpu16_I4_n0182_6_CYMUXFAST
    );
  Cpu16_I4_n0182_6_CYMUXG2_432 : X_MUX2
    port map (
      IA => Cpu16_I4_n0182_6_CY0G,
      IB => Cpu16_I4_n0182_6_CYMUXF2,
      SEL => Cpu16_I4_n0182_6_CYSELG,
      O => Cpu16_I4_n0182_6_CYMUXG2
    );
  Cpu16_I4_n0182_6_CY0G_433 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_c(7),
      O => Cpu16_I4_n0182_6_CY0G
    );
  Cpu16_I4_n0182_6_CYSELG_434 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_lut2_67,
      O => Cpu16_I4_n0182_6_CYSELG
    );
  Cpu16_I4_Madd_n0182_inst_lut2_691 : X_LUT4
    generic map(
      INIT => X"5A5A"
    )
    port map (
      ADR0 => Cpu16_I4_iinc_c(9),
      ADR1 => VCC,
      ADR2 => Cpu16_I4_ireg_c(9),
      ADR3 => VCC,
      O => Cpu16_I4_Madd_n0182_inst_lut2_69
    );
  Cpu16_I4_Madd_n0182_inst_lut2_681 : X_LUT4
    generic map(
      INIT => X"33CC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I4_iinc_c(8),
      ADR2 => VCC,
      ADR3 => Cpu16_I4_ireg_c(8),
      O => Cpu16_I4_Madd_n0182_inst_lut2_68
    );
  Cpu16_I4_n0182_8_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0182_8_XORF,
      O => Cpu16_I4_n0182(8)
    );
  Cpu16_I4_n0182_8_XORF_435 : X_XOR2
    port map (
      I0 => Cpu16_I4_n0182_8_CYINIT,
      I1 => Cpu16_I4_Madd_n0182_inst_lut2_68,
      O => Cpu16_I4_n0182_8_XORF
    );
  Cpu16_I4_n0182_8_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I4_n0182_8_CY0F,
      IB => Cpu16_I4_n0182_8_CYINIT,
      SEL => Cpu16_I4_n0182_8_CYSELF,
      O => Cpu16_I4_Madd_n0182_inst_cy_69
    );
  Cpu16_I4_n0182_8_CYMUXF2_436 : X_MUX2
    port map (
      IA => Cpu16_I4_n0182_8_CY0F,
      IB => Cpu16_I4_n0182_8_CY0F,
      SEL => Cpu16_I4_n0182_8_CYSELF,
      O => Cpu16_I4_n0182_8_CYMUXF2
    );
  Cpu16_I4_n0182_8_CYINIT_437 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_cy_68,
      O => Cpu16_I4_n0182_8_CYINIT
    );
  Cpu16_I4_n0182_8_CY0F_438 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_c(8),
      O => Cpu16_I4_n0182_8_CY0F
    );
  Cpu16_I4_n0182_8_CYSELF_439 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_lut2_68,
      O => Cpu16_I4_n0182_8_CYSELF
    );
  Cpu16_I4_n0182_8_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0182_8_XORG,
      O => Cpu16_I4_n0182(9)
    );
  Cpu16_I4_n0182_8_XORG_440 : X_XOR2
    port map (
      I0 => Cpu16_I4_Madd_n0182_inst_cy_69,
      I1 => Cpu16_I4_Madd_n0182_inst_lut2_69,
      O => Cpu16_I4_n0182_8_XORG
    );
  Cpu16_I4_n0182_8_COUTUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0182_8_CYMUXFAST,
      O => Cpu16_I4_Madd_n0182_inst_cy_70
    );
  Cpu16_I4_n0182_8_FASTCARRY_441 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_cy_68,
      O => Cpu16_I4_n0182_8_FASTCARRY
    );
  Cpu16_I4_n0182_8_CYAND_442 : X_AND2
    port map (
      I0 => Cpu16_I4_n0182_8_CYSELG,
      I1 => Cpu16_I4_n0182_8_CYSELF,
      O => Cpu16_I4_n0182_8_CYAND
    );
  Cpu16_I4_n0182_8_CYMUXFAST_443 : X_MUX2
    port map (
      IA => Cpu16_I4_n0182_8_CYMUXG2,
      IB => Cpu16_I4_n0182_8_FASTCARRY,
      SEL => Cpu16_I4_n0182_8_CYAND,
      O => Cpu16_I4_n0182_8_CYMUXFAST
    );
  Cpu16_I4_n0182_8_CYMUXG2_444 : X_MUX2
    port map (
      IA => Cpu16_I4_n0182_8_CY0G,
      IB => Cpu16_I4_n0182_8_CYMUXF2,
      SEL => Cpu16_I4_n0182_8_CYSELG,
      O => Cpu16_I4_n0182_8_CYMUXG2
    );
  Cpu16_I4_n0182_8_CY0G_445 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_c(9),
      O => Cpu16_I4_n0182_8_CY0G
    );
  Cpu16_I4_n0182_8_CYSELG_446 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_lut2_69,
      O => Cpu16_I4_n0182_8_CYSELG
    );
  Cpu16_I4_Madd_n0182_inst_lut2_71_rt_447 : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I4_Madd_n0182_inst_lut2_71,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Cpu16_I4_Madd_n0182_inst_lut2_71_rt
    );
  Cpu16_I4_Madd_n0182_inst_lut2_701 : X_LUT4
    generic map(
      INIT => X"55AA"
    )
    port map (
      ADR0 => Cpu16_I4_iinc_c(10),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => Cpu16_I4_ireg_c(10),
      O => Cpu16_I4_Madd_n0182_inst_lut2_70
    );
  Cpu16_I4_n0182_10_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0182_10_XORF,
      O => Cpu16_I4_n0182(10)
    );
  Cpu16_I4_n0182_10_XORF_448 : X_XOR2
    port map (
      I0 => Cpu16_I4_n0182_10_CYINIT,
      I1 => Cpu16_I4_Madd_n0182_inst_lut2_70,
      O => Cpu16_I4_n0182_10_XORF
    );
  Cpu16_I4_n0182_10_CYMUXF : X_MUX2
    port map (
      IA => Cpu16_I4_n0182_10_CY0F,
      IB => Cpu16_I4_n0182_10_CYINIT,
      SEL => Cpu16_I4_n0182_10_CYSELF,
      O => Cpu16_I4_Madd_n0182_inst_cy_71
    );
  Cpu16_I4_n0182_10_CYINIT_449 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_cy_70,
      O => Cpu16_I4_n0182_10_CYINIT
    );
  Cpu16_I4_n0182_10_CY0F_450 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_c(10),
      O => Cpu16_I4_n0182_10_CY0F
    );
  Cpu16_I4_n0182_10_CYSELF_451 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_lut2_70,
      O => Cpu16_I4_n0182_10_CYSELF
    );
  Cpu16_I4_n0182_10_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0182_10_XORG,
      O => Cpu16_I4_n0182(11)
    );
  Cpu16_I4_n0182_10_XORG_452 : X_XOR2
    port map (
      I0 => Cpu16_I4_Madd_n0182_inst_cy_71,
      I1 => Cpu16_I4_Madd_n0182_inst_lut2_71_rt,
      O => Cpu16_I4_n0182_10_XORG
    );
  NWE_EXT_OBUF : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => NWE_EXT_O,
      CTL => NWE_EXT_ENABLE,
      O => NWE_EXT
    );
  NWE_EXT_ENABLEINV : X_INV
    port map (
      I => NWE_EXT_GTS_OR_T,
      O => NWE_EXT_ENABLE
    );
  NWE_EXT_GTS_OR_T_453 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => NWE_EXT_GTS_OR_T
    );
  NWE_EXT_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => NWE_EXT_SRINVNOT
    );
  DATA_OUT_EXT_0_OBUF_454 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_0_O,
      CTL => DATA_OUT_EXT_0_ENABLE,
      O => DATA_OUT_EXT(0)
    );
  DATA_OUT_EXT_0_ENABLEINV : X_INV
    port map (
      I => DATA_OUT_EXT_0_GTS_OR_T,
      O => DATA_OUT_EXT_0_ENABLE
    );
  DATA_OUT_EXT_0_GTS_OR_T_455 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => DATA_OUT_EXT_0_GTS_OR_T
    );
  DATA_OUT_EXT_1_OBUF_456 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_1_O,
      CTL => DATA_OUT_EXT_1_ENABLE,
      O => DATA_OUT_EXT(1)
    );
  DATA_OUT_EXT_1_ENABLEINV : X_INV
    port map (
      I => DATA_OUT_EXT_1_GTS_OR_T,
      O => DATA_OUT_EXT_1_ENABLE
    );
  DATA_OUT_EXT_1_GTS_OR_T_457 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => DATA_OUT_EXT_1_GTS_OR_T
    );
  DATA_OUT_EXT_2_OBUF_458 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_2_O,
      CTL => DATA_OUT_EXT_2_ENABLE,
      O => DATA_OUT_EXT(2)
    );
  DATA_OUT_EXT_2_ENABLEINV : X_INV
    port map (
      I => DATA_OUT_EXT_2_GTS_OR_T,
      O => DATA_OUT_EXT_2_ENABLE
    );
  DATA_OUT_EXT_2_GTS_OR_T_459 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => DATA_OUT_EXT_2_GTS_OR_T
    );
  DATA_OUT_EXT_3_OBUF_460 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_3_O,
      CTL => DATA_OUT_EXT_3_ENABLE,
      O => DATA_OUT_EXT(3)
    );
  DATA_OUT_EXT_3_ENABLEINV : X_INV
    port map (
      I => DATA_OUT_EXT_3_GTS_OR_T,
      O => DATA_OUT_EXT_3_ENABLE
    );
  DATA_OUT_EXT_3_GTS_OR_T_461 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => DATA_OUT_EXT_3_GTS_OR_T
    );
  DATA_OUT_EXT_4_OBUF_462 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_4_O,
      CTL => DATA_OUT_EXT_4_ENABLE,
      O => DATA_OUT_EXT(4)
    );
  DATA_OUT_EXT_4_ENABLEINV : X_INV
    port map (
      I => DATA_OUT_EXT_4_GTS_OR_T,
      O => DATA_OUT_EXT_4_ENABLE
    );
  DATA_OUT_EXT_4_GTS_OR_T_463 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => DATA_OUT_EXT_4_GTS_OR_T
    );
  DATA_OUT_EXT_5_OBUF_464 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_5_O,
      CTL => DATA_OUT_EXT_5_ENABLE,
      O => DATA_OUT_EXT(5)
    );
  DATA_OUT_EXT_5_ENABLEINV : X_INV
    port map (
      I => DATA_OUT_EXT_5_GTS_OR_T,
      O => DATA_OUT_EXT_5_ENABLE
    );
  DATA_OUT_EXT_5_GTS_OR_T_465 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => DATA_OUT_EXT_5_GTS_OR_T
    );
  DATA_OUT_EXT_6_OBUF_466 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_6_O,
      CTL => DATA_OUT_EXT_6_ENABLE,
      O => DATA_OUT_EXT(6)
    );
  DATA_OUT_EXT_6_ENABLEINV : X_INV
    port map (
      I => DATA_OUT_EXT_6_GTS_OR_T,
      O => DATA_OUT_EXT_6_ENABLE
    );
  DATA_OUT_EXT_6_GTS_OR_T_467 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => DATA_OUT_EXT_6_GTS_OR_T
    );
  DATA_OUT_EXT_7_OBUF_468 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_7_O,
      CTL => DATA_OUT_EXT_7_ENABLE,
      O => DATA_OUT_EXT(7)
    );
  DATA_OUT_EXT_7_ENABLEINV : X_INV
    port map (
      I => DATA_OUT_EXT_7_GTS_OR_T,
      O => DATA_OUT_EXT_7_ENABLE
    );
  DATA_OUT_EXT_7_GTS_OR_T_469 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => DATA_OUT_EXT_7_GTS_OR_T
    );
  DATA_OUT_EXT_8_OBUF_470 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_8_O,
      CTL => DATA_OUT_EXT_8_ENABLE,
      O => DATA_OUT_EXT(8)
    );
  DATA_OUT_EXT_8_ENABLEINV : X_INV
    port map (
      I => DATA_OUT_EXT_8_GTS_OR_T,
      O => DATA_OUT_EXT_8_ENABLE
    );
  DATA_OUT_EXT_8_GTS_OR_T_471 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => DATA_OUT_EXT_8_GTS_OR_T
    );
  DATA_OUT_EXT_9_OBUF_472 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_9_O,
      CTL => DATA_OUT_EXT_9_ENABLE,
      O => DATA_OUT_EXT(9)
    );
  DATA_OUT_EXT_9_ENABLEINV : X_INV
    port map (
      I => DATA_OUT_EXT_9_GTS_OR_T,
      O => DATA_OUT_EXT_9_ENABLE
    );
  DATA_OUT_EXT_9_GTS_OR_T_473 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => DATA_OUT_EXT_9_GTS_OR_T
    );
  CPU_INT_IBUF_474 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_INT,
      O => CPU_INT_INBUF
    );
  ADDR_OUT_EXT_0_OBUF_475 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_0_O,
      CTL => ADDR_OUT_EXT_0_ENABLE,
      O => ADDR_OUT_EXT(0)
    );
  ADDR_OUT_EXT_0_ENABLEINV : X_INV
    port map (
      I => ADDR_OUT_EXT_0_GTS_OR_T,
      O => ADDR_OUT_EXT_0_ENABLE
    );
  ADDR_OUT_EXT_0_GTS_OR_T_476 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => ADDR_OUT_EXT_0_GTS_OR_T
    );
  ADDR_OUT_EXT_1_OBUF_477 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_1_O,
      CTL => ADDR_OUT_EXT_1_ENABLE,
      O => ADDR_OUT_EXT(1)
    );
  ADDR_OUT_EXT_1_ENABLEINV : X_INV
    port map (
      I => ADDR_OUT_EXT_1_GTS_OR_T,
      O => ADDR_OUT_EXT_1_ENABLE
    );
  ADDR_OUT_EXT_1_GTS_OR_T_478 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => ADDR_OUT_EXT_1_GTS_OR_T
    );
  ADDR_OUT_EXT_2_OBUF_479 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_2_O,
      CTL => ADDR_OUT_EXT_2_ENABLE,
      O => ADDR_OUT_EXT(2)
    );
  ADDR_OUT_EXT_2_ENABLEINV : X_INV
    port map (
      I => ADDR_OUT_EXT_2_GTS_OR_T,
      O => ADDR_OUT_EXT_2_ENABLE
    );
  ADDR_OUT_EXT_2_GTS_OR_T_480 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => ADDR_OUT_EXT_2_GTS_OR_T
    );
  ADDR_OUT_EXT_3_OBUF_481 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_3_O,
      CTL => ADDR_OUT_EXT_3_ENABLE,
      O => ADDR_OUT_EXT(3)
    );
  ADDR_OUT_EXT_3_ENABLEINV : X_INV
    port map (
      I => ADDR_OUT_EXT_3_GTS_OR_T,
      O => ADDR_OUT_EXT_3_ENABLE
    );
  ADDR_OUT_EXT_3_GTS_OR_T_482 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => ADDR_OUT_EXT_3_GTS_OR_T
    );
  ADDR_OUT_EXT_4_OBUF_483 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_4_O,
      CTL => ADDR_OUT_EXT_4_ENABLE,
      O => ADDR_OUT_EXT(4)
    );
  ADDR_OUT_EXT_4_ENABLEINV : X_INV
    port map (
      I => ADDR_OUT_EXT_4_GTS_OR_T,
      O => ADDR_OUT_EXT_4_ENABLE
    );
  ADDR_OUT_EXT_4_GTS_OR_T_484 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => ADDR_OUT_EXT_4_GTS_OR_T
    );
  ADDR_OUT_EXT_5_OBUF_485 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_5_O,
      CTL => ADDR_OUT_EXT_5_ENABLE,
      O => ADDR_OUT_EXT(5)
    );
  ADDR_OUT_EXT_5_ENABLEINV : X_INV
    port map (
      I => ADDR_OUT_EXT_5_GTS_OR_T,
      O => ADDR_OUT_EXT_5_ENABLE
    );
  ADDR_OUT_EXT_5_GTS_OR_T_486 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => ADDR_OUT_EXT_5_GTS_OR_T
    );
  ADDR_OUT_EXT_6_OBUF_487 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_6_O,
      CTL => ADDR_OUT_EXT_6_ENABLE,
      O => ADDR_OUT_EXT(6)
    );
  ADDR_OUT_EXT_6_ENABLEINV : X_INV
    port map (
      I => ADDR_OUT_EXT_6_GTS_OR_T,
      O => ADDR_OUT_EXT_6_ENABLE
    );
  ADDR_OUT_EXT_6_GTS_OR_T_488 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => ADDR_OUT_EXT_6_GTS_OR_T
    );
  ADDR_OUT_EXT_7_OBUF_489 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_7_O,
      CTL => ADDR_OUT_EXT_7_ENABLE,
      O => ADDR_OUT_EXT(7)
    );
  ADDR_OUT_EXT_7_ENABLEINV : X_INV
    port map (
      I => ADDR_OUT_EXT_7_GTS_OR_T,
      O => ADDR_OUT_EXT_7_ENABLE
    );
  ADDR_OUT_EXT_7_GTS_OR_T_490 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => ADDR_OUT_EXT_7_GTS_OR_T
    );
  ADDR_OUT_EXT_8_OBUF_491 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_8_O,
      CTL => ADDR_OUT_EXT_8_ENABLE,
      O => ADDR_OUT_EXT(8)
    );
  ADDR_OUT_EXT_8_ENABLEINV : X_INV
    port map (
      I => ADDR_OUT_EXT_8_GTS_OR_T,
      O => ADDR_OUT_EXT_8_ENABLE
    );
  ADDR_OUT_EXT_8_GTS_OR_T_492 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => ADDR_OUT_EXT_8_GTS_OR_T
    );
  ADDR_OUT_EXT_9_OBUF_493 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_9_O,
      CTL => ADDR_OUT_EXT_9_ENABLE,
      O => ADDR_OUT_EXT(9)
    );
  ADDR_OUT_EXT_9_ENABLEINV : X_INV
    port map (
      I => ADDR_OUT_EXT_9_GTS_OR_T,
      O => ADDR_OUT_EXT_9_ENABLE
    );
  ADDR_OUT_EXT_9_GTS_OR_T_494 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => ADDR_OUT_EXT_9_GTS_OR_T
    );
  DATA_IN_EXT_10_IBUF_495 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT(10),
      O => DATA_IN_EXT_10_INBUF
    );
  DATA_IN_EXT_11_IBUF_496 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT(11),
      O => DATA_IN_EXT_11_INBUF
    );
  DATA_IN_EXT_12_IBUF_497 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT(12),
      O => DATA_IN_EXT_12_INBUF
    );
  DATA_IN_EXT_13_IBUF_498 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT(13),
      O => DATA_IN_EXT_13_INBUF
    );
  DATA_IN_EXT_14_IBUF_499 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT(14),
      O => DATA_IN_EXT_14_INBUF
    );
  DATA_IN_EXT_15_IBUF_500 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT(15),
      O => DATA_IN_EXT_15_INBUF
    );
  DATA_OUT_EXT_10_OBUF_501 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_10_O,
      CTL => DATA_OUT_EXT_10_ENABLE,
      O => DATA_OUT_EXT(10)
    );
  DATA_OUT_EXT_10_ENABLEINV : X_INV
    port map (
      I => DATA_OUT_EXT_10_GTS_OR_T,
      O => DATA_OUT_EXT_10_ENABLE
    );
  DATA_OUT_EXT_10_GTS_OR_T_502 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => DATA_OUT_EXT_10_GTS_OR_T
    );
  DATA_OUT_EXT_11_OBUF_503 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_11_O,
      CTL => DATA_OUT_EXT_11_ENABLE,
      O => DATA_OUT_EXT(11)
    );
  DATA_OUT_EXT_11_ENABLEINV : X_INV
    port map (
      I => DATA_OUT_EXT_11_GTS_OR_T,
      O => DATA_OUT_EXT_11_ENABLE
    );
  DATA_OUT_EXT_11_GTS_OR_T_504 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => DATA_OUT_EXT_11_GTS_OR_T
    );
  DATA_OUT_EXT_12_OBUF_505 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_12_O,
      CTL => DATA_OUT_EXT_12_ENABLE,
      O => DATA_OUT_EXT(12)
    );
  DATA_OUT_EXT_12_ENABLEINV : X_INV
    port map (
      I => DATA_OUT_EXT_12_GTS_OR_T,
      O => DATA_OUT_EXT_12_ENABLE
    );
  DATA_OUT_EXT_12_GTS_OR_T_506 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => DATA_OUT_EXT_12_GTS_OR_T
    );
  DATA_OUT_EXT_13_OBUF_507 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_13_O,
      CTL => DATA_OUT_EXT_13_ENABLE,
      O => DATA_OUT_EXT(13)
    );
  DATA_OUT_EXT_13_ENABLEINV : X_INV
    port map (
      I => DATA_OUT_EXT_13_GTS_OR_T,
      O => DATA_OUT_EXT_13_ENABLE
    );
  DATA_OUT_EXT_13_GTS_OR_T_508 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => DATA_OUT_EXT_13_GTS_OR_T
    );
  DATA_OUT_EXT_14_OBUF_509 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_14_O,
      CTL => DATA_OUT_EXT_14_ENABLE,
      O => DATA_OUT_EXT(14)
    );
  DATA_OUT_EXT_14_ENABLEINV : X_INV
    port map (
      I => DATA_OUT_EXT_14_GTS_OR_T,
      O => DATA_OUT_EXT_14_ENABLE
    );
  DATA_OUT_EXT_14_GTS_OR_T_510 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => DATA_OUT_EXT_14_GTS_OR_T
    );
  DATA_OUT_EXT_15_OBUF_511 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_15_O,
      CTL => DATA_OUT_EXT_15_ENABLE,
      O => DATA_OUT_EXT(15)
    );
  DATA_OUT_EXT_15_ENABLEINV : X_INV
    port map (
      I => DATA_OUT_EXT_15_GTS_OR_T,
      O => DATA_OUT_EXT_15_ENABLE
    );
  DATA_OUT_EXT_15_GTS_OR_T_512 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => DATA_OUT_EXT_15_GTS_OR_T
    );
  CLK_IN_BUFGP_IBUFG_513 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN,
      O => CLK_IN_INBUF
    );
  NRESET_IN_BUFGP_IBUFG_514 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => NRESET_IN,
      O => NRESET_IN_INBUF
    );
  XLXI_4_Maddsub_n0001_inst_lut2_31 : X_LUT4
    generic map(
      INIT => X"5333"
    )
    port map (
      ADR0 => XLXI_4_n00021_SW7_O,
      ADR1 => N30782,
      ADR2 => Cpu16_pc_mux(1),
      ADR3 => Cpu16_pc_mux(0),
      O => XLXI_4_Maddsub_n0001_inst_lut2_3
    );
  NCS_EXT_OBUF : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => NCS_EXT_O,
      CTL => NCS_EXT_ENABLE,
      O => NCS_EXT
    );
  NCS_EXT_ENABLEINV : X_INV
    port map (
      I => NCS_EXT_GTS_OR_T,
      O => NCS_EXT_ENABLE
    );
  NCS_EXT_GTS_OR_T_515 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => NCS_EXT_GTS_OR_T
    );
  NCS_EXT_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => NCS_EXT_SRINVNOT
    );
  DATA_IN_EXT_0_IBUF_516 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT(0),
      O => DATA_IN_EXT_0_INBUF
    );
  DATA_IN_EXT_1_IBUF_517 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT(1),
      O => DATA_IN_EXT_1_INBUF
    );
  DATA_IN_EXT_2_IBUF_518 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT(2),
      O => DATA_IN_EXT_2_INBUF
    );
  DATA_IN_EXT_3_IBUF_519 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT(3),
      O => DATA_IN_EXT_3_INBUF
    );
  DATA_IN_EXT_4_IBUF_520 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT(4),
      O => DATA_IN_EXT_4_INBUF
    );
  DATA_IN_EXT_5_IBUF_521 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT(5),
      O => DATA_IN_EXT_5_INBUF
    );
  DATA_IN_EXT_6_IBUF_522 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT(6),
      O => DATA_IN_EXT_6_INBUF
    );
  DATA_IN_EXT_7_IBUF_523 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT(7),
      O => DATA_IN_EXT_7_INBUF
    );
  DATA_IN_EXT_8_IBUF_524 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT(8),
      O => DATA_IN_EXT_8_INBUF
    );
  DATA_IN_EXT_9_IBUF_525 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT(9),
      O => DATA_IN_EXT_9_INBUF
    );
  NRE_EXT_OBUF_526 : X_TRI_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => NRE_EXT_O,
      CTL => NRE_EXT_ENABLE,
      O => NRE_EXT
    );
  NRE_EXT_ENABLEINV : X_INV
    port map (
      I => NRE_EXT_GTS_OR_T,
      O => NRE_EXT_ENABLE
    );
  NRE_EXT_GTS_OR_T_527 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GTS,
      O => NRE_EXT_GTS_OR_T
    );
  NRESET_IN_BUFGP_BUFG : X_BUFGMUX
    port map (
      I0 => NRESET_IN_BUFGP_IBUFG,
      I1 => GND,
      S => NRESET_IN_BUFGP_BUFG_S_INVNOT,
      O => NRESET_IN_BUFGP,
      GSR => GSR
    );
  NRESET_IN_BUFGP_BUFG_SINV : X_INV
    port map (
      I => GLOBAL_LOGIC1_4,
      O => NRESET_IN_BUFGP_BUFG_S_INVNOT
    );
  CLK_IN_BUFGP_BUFG : X_BUFGMUX
    port map (
      I0 => CLK_IN_BUFGP_IBUFG,
      I1 => GND,
      S => CLK_IN_BUFGP_BUFG_S_INVNOT,
      O => CLK_IN_BUFGP,
      GSR => GSR
    );
  CLK_IN_BUFGP_BUFG_SINV : X_INV
    port map (
      I => GLOBAL_LOGIC1_4,
      O => CLK_IN_BUFGP_BUFG_S_INVNOT
    );
  XLXI_6_B5_SSRAINV : X_INV
    port map (
      I => GLOBAL_LOGIC1_9,
      O => XLXI_6_B5_SSRA_INTNOT
    );
  XLXI_6_B5_WEAINV : X_INV
    port map (
      I => XLXI_2_nWE_RAM_c,
      O => XLXI_6_B5_WEA_INTNOT
    );
  XLXI_6_B5 : X_RAMB16_S18
    generic map(
      INIT_00 => X"000000A1001C00A200C020010091001E0092000800790091005C009420020092",
      INIT_01 => X"00000000000000000000000000000000000000000000000000000000000000D0",
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
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000C800000031000A0081003A00000000000000000000000000000000",
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      SRVAL => X"00000",
      INIT => X"00000",
      WRITE_MODE => "WRITE_FIRST"
    )
    port map (
      CLK => CLK_IN_BUFGP,
      EN => GLOBAL_LOGIC1_10,
      SSR => XLXI_6_B5_SSRA_INTNOT,
      WE => XLXI_6_B5_WEA_INTNOT,
      GSR => GSR,
      ADDR(9) => MADDR(9),
      ADDR(8) => MADDR(8),
      ADDR(7) => MADDR(7),
      ADDR(6) => MADDR(6),
      ADDR(5) => MADDR(5),
      ADDR(4) => MADDR(4),
      ADDR(3) => MADDR(3),
      ADDR(2) => MADDR(2),
      ADDR(1) => MADDR(1),
      ADDR(0) => MADDR(0),
      DI(15) => DATA_OUT_EXT_15_OBUF,
      DI(14) => DATA_OUT_EXT_14_OBUF,
      DI(13) => DATA_OUT_EXT_13_OBUF,
      DI(12) => DATA_OUT_EXT_12_OBUF,
      DI(11) => DATA_OUT_EXT_11_OBUF,
      DI(10) => DATA_OUT_EXT_10_OBUF,
      DI(9) => DATA_OUT_EXT_9_OBUF,
      DI(8) => DATA_OUT_EXT_8_OBUF,
      DI(7) => DATA_OUT_EXT_7_OBUF,
      DI(6) => DATA_OUT_EXT_6_OBUF,
      DI(5) => DATA_OUT_EXT_5_OBUF,
      DI(4) => DATA_OUT_EXT_4_OBUF,
      DI(3) => DATA_OUT_EXT_3_OBUF,
      DI(2) => DATA_OUT_EXT_2_OBUF,
      DI(1) => DATA_OUT_EXT_1_OBUF,
      DI(0) => DATA_OUT_EXT_0_OBUF,
      DIP(1) => GLOBAL_LOGIC0,
      DIP(0) => GLOBAL_LOGIC0,
      DO(15) => MEM_DATA_OUT(15),
      DO(14) => MEM_DATA_OUT(14),
      DO(13) => MEM_DATA_OUT(13),
      DO(12) => MEM_DATA_OUT(12),
      DO(11) => MEM_DATA_OUT(11),
      DO(10) => MEM_DATA_OUT(10),
      DO(9) => MEM_DATA_OUT(9),
      DO(8) => MEM_DATA_OUT(8),
      DO(7) => MEM_DATA_OUT(7),
      DO(6) => MEM_DATA_OUT(6),
      DO(5) => MEM_DATA_OUT(5),
      DO(4) => MEM_DATA_OUT(4),
      DO(3) => MEM_DATA_OUT(3),
      DO(2) => MEM_DATA_OUT(2),
      DO(1) => MEM_DATA_OUT(1),
      DO(0) => MEM_DATA_OUT(0),
      DOP(1) => XLXI_6_B5_DOPA1,
      DOP(0) => XLXI_6_B5_DOPA0
    );
  XLXI_7_B5_SSRAINV : X_INV
    port map (
      I => GLOBAL_LOGIC1_7,
      O => XLXI_7_B5_SSRA_INTNOT
    );
  XLXI_7_B5 : X_RAMB16_S18
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
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      SRVAL => X"00000",
      INIT => X"00000",
      WRITE_MODE => "WRITE_FIRST"
    )
    port map (
      CLK => CLK_IN_BUFGP,
      EN => GLOBAL_LOGIC1_8,
      SSR => XLXI_7_B5_SSRA_INTNOT,
      WE => XLXN_1,
      GSR => GSR,
      ADDR(9) => GLOBAL_LOGIC0_0,
      ADDR(8) => GLOBAL_LOGIC0_0,
      ADDR(7) => XLXN_19(7),
      ADDR(6) => XLXN_19(6),
      ADDR(5) => XLXN_19(5),
      ADDR(4) => XLXN_19(4),
      ADDR(3) => XLXN_19(3),
      ADDR(2) => XLXN_19(2),
      ADDR(1) => XLXN_19(1),
      ADDR(0) => XLXN_19(0),
      DI(15) => GLOBAL_LOGIC0_1,
      DI(14) => GLOBAL_LOGIC0_1,
      DI(13) => GLOBAL_LOGIC0_0,
      DI(12) => GLOBAL_LOGIC0_0,
      DI(11) => XLXN_14(11),
      DI(10) => XLXN_14(10),
      DI(9) => XLXN_14(9),
      DI(8) => XLXN_14(8),
      DI(7) => XLXN_14(7),
      DI(6) => XLXN_14(6),
      DI(5) => XLXN_14(5),
      DI(4) => XLXN_14(4),
      DI(3) => XLXN_14(3),
      DI(2) => XLXN_14(2),
      DI(1) => XLXN_14(1),
      DI(0) => XLXN_14(0),
      DIP(1) => GLOBAL_LOGIC0_0,
      DIP(0) => GLOBAL_LOGIC0,
      DO(15) => XLXI_7_B5_DOA15,
      DO(14) => XLXI_7_B5_DOA14,
      DO(13) => XLXI_7_B5_DOA13,
      DO(12) => XLXI_7_B5_DOA12,
      DO(11) => XLXN_20(11),
      DO(10) => XLXN_20(10),
      DO(9) => XLXN_20(9),
      DO(8) => XLXN_20(8),
      DO(7) => XLXN_20(7),
      DO(6) => XLXN_20(6),
      DO(5) => XLXN_20(5),
      DO(4) => XLXN_20(4),
      DO(3) => XLXN_20(3),
      DO(2) => XLXN_20(2),
      DO(1) => XLXN_20(1),
      DO(0) => XLXN_20(0),
      DOP(1) => XLXI_7_B5_DOPA1,
      DOP(0) => XLXI_7_B5_DOPA0
    );
  Cpu16_I4_ireg_x_0_14_F : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_we_c,
      ADR1 => Cpu16_I4_Madd_n0182_inst_lut2_60,
      ADR2 => Cpu16_I4_N18286,
      ADR3 => Cpu16_I3_acc_c_0_0_1,
      O => N32086
    );
  Cpu16_I4_ireg_i_0_DXMUX_528 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_0_FXMUX,
      O => Cpu16_I4_ireg_i_0_DXMUX
    );
  Cpu16_I4_ireg_i_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_0_FXMUX,
      O => Cpu16_I4_ireg_x(0)
    );
  Cpu16_I4_ireg_i_0_FXMUX_529 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_0_F5MUX,
      O => Cpu16_I4_ireg_i_0_FXMUX
    );
  Cpu16_I4_ireg_i_0_F5MUX_530 : X_MUX2
    port map (
      IA => N32086,
      IB => N32088,
      SEL => Cpu16_I4_ireg_i_0_BXINV,
      O => Cpu16_I4_ireg_i_0_F5MUX
    );
  Cpu16_I4_ireg_i_0_BXINV_531 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18033,
      O => Cpu16_I4_ireg_i_0_BXINV
    );
  Cpu16_I4_ireg_i_0_CLKINV_532 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_i_0_CLKINV
    );
  Cpu16_I4_ireg_i_0_CEINV_533 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_ireg_i_0_CEINV
    );
  Cpu16_I3_Mmux_data_x_Result_0_85_SW21_F : X_LUT4
    generic map(
      INIT => X"A05F"
    )
    port map (
      ADR0 => Cpu16_I2_data_is_c(0),
      ADR1 => VCC,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => Cpu16_I3_acc_c_0_0,
      O => N32151
    );
  N31024_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31024_F5MUX,
      O => N31024
    );
  N31024_F5MUX_534 : X_MUX2
    port map (
      IA => N32151,
      IB => N32153,
      SEL => N31024_BXINV,
      O => N31024_F5MUX
    );
  N31024_BXINV_535 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18018,
      O => N31024_BXINV
    );
  Cpu16_I4_ireg_i_1_DXMUX_536 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_1_FXMUX,
      O => Cpu16_I4_ireg_i_1_DXMUX
    );
  Cpu16_I4_ireg_i_1_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_1_FXMUX,
      O => Cpu16_I4_ireg_x(1)
    );
  Cpu16_I4_ireg_i_1_FXMUX_537 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_1_F5MUX,
      O => Cpu16_I4_ireg_i_1_FXMUX
    );
  Cpu16_I4_ireg_i_1_F5MUX_538 : X_MUX2
    port map (
      IA => N32116,
      IB => N32118,
      SEL => Cpu16_I4_ireg_i_1_BXINV,
      O => Cpu16_I4_ireg_i_1_F5MUX
    );
  Cpu16_I4_ireg_i_1_BXINV_539 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18033,
      O => Cpu16_I4_ireg_i_1_BXINV
    );
  Cpu16_I4_ireg_i_1_CLKINV_540 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_i_1_CLKINV
    );
  Cpu16_I4_ireg_i_1_CEINV_541 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_ireg_i_1_CEINV
    );
  Cpu16_I4_ireg_i_10_DXMUX_542 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_10_FXMUX,
      O => Cpu16_I4_ireg_i_10_DXMUX
    );
  Cpu16_I4_ireg_i_10_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_10_FXMUX,
      O => Cpu16_I4_ireg_x(10)
    );
  Cpu16_I4_ireg_i_10_FXMUX_543 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_10_F5MUX,
      O => Cpu16_I4_ireg_i_10_FXMUX
    );
  Cpu16_I4_ireg_i_10_F5MUX_544 : X_MUX2
    port map (
      IA => N32091,
      IB => N32093,
      SEL => Cpu16_I4_ireg_i_10_BXINV,
      O => Cpu16_I4_ireg_i_10_F5MUX
    );
  Cpu16_I4_ireg_i_10_BXINV_545 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18033,
      O => Cpu16_I4_ireg_i_10_BXINV
    );
  Cpu16_I4_ireg_i_10_CLKINV_546 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_i_10_CLKINV
    );
  Cpu16_I4_ireg_i_10_CEINV_547 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_ireg_i_10_CEINV
    );
  Cpu16_I4_ireg_i_2_DXMUX_548 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_2_FXMUX,
      O => Cpu16_I4_ireg_i_2_DXMUX
    );
  Cpu16_I4_ireg_i_2_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_2_FXMUX,
      O => Cpu16_I4_ireg_x(2)
    );
  Cpu16_I4_ireg_i_2_FXMUX_549 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_2_F5MUX,
      O => Cpu16_I4_ireg_i_2_FXMUX
    );
  Cpu16_I4_ireg_i_2_F5MUX_550 : X_MUX2
    port map (
      IA => N32111,
      IB => N32113,
      SEL => Cpu16_I4_ireg_i_2_BXINV,
      O => Cpu16_I4_ireg_i_2_F5MUX
    );
  Cpu16_I4_ireg_i_2_BXINV_551 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18033,
      O => Cpu16_I4_ireg_i_2_BXINV
    );
  Cpu16_I4_ireg_i_2_CLKINV_552 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_i_2_CLKINV
    );
  Cpu16_I4_ireg_i_2_CEINV_553 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_ireg_i_2_CEINV
    );
  Cpu16_I4_ireg_i_11_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_ireg_i_11_FFX_RST
    );
  Cpu16_I4_ireg_i_11 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_i_11_DXMUX,
      CE => Cpu16_I4_ireg_i_11_CEINV,
      CLK => Cpu16_I4_ireg_i_11_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_i_11_FFX_RST,
      O => Cpu16_I4_ireg_i(11)
    );
  Cpu16_I4_ireg_i_11_DXMUX_554 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_11_FXMUX,
      O => Cpu16_I4_ireg_i_11_DXMUX
    );
  Cpu16_I4_ireg_i_11_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_11_FXMUX,
      O => Cpu16_I4_ireg_x(11)
    );
  Cpu16_I4_ireg_i_11_FXMUX_555 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_11_F5MUX,
      O => Cpu16_I4_ireg_i_11_FXMUX
    );
  Cpu16_I4_ireg_i_11_F5MUX_556 : X_MUX2
    port map (
      IA => N32136,
      IB => N32138,
      SEL => Cpu16_I4_ireg_i_11_BXINV,
      O => Cpu16_I4_ireg_i_11_F5MUX
    );
  Cpu16_I4_ireg_i_11_BXINV_557 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18033,
      O => Cpu16_I4_ireg_i_11_BXINV
    );
  Cpu16_I4_ireg_i_11_CLKINV_558 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_i_11_CLKINV
    );
  Cpu16_I4_ireg_i_11_CEINV_559 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_ireg_i_11_CEINV
    );
  Cpu16_I4_ireg_i_3_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_ireg_i_3_FFX_RST
    );
  Cpu16_I4_ireg_i_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_i_3_DXMUX,
      CE => Cpu16_I4_ireg_i_3_CEINV,
      CLK => Cpu16_I4_ireg_i_3_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_i_3_FFX_RST,
      O => Cpu16_I4_ireg_i(3)
    );
  Cpu16_I4_ireg_x_3_14_G : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_we_c,
      ADR1 => Cpu16_I3_acc_c_0_3,
      ADR2 => Cpu16_I4_N18286,
      ADR3 => Cpu16_I4_ireg_c(3),
      O => N32073
    );
  Cpu16_I4_ireg_i_3_DXMUX_560 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_3_FXMUX,
      O => Cpu16_I4_ireg_i_3_DXMUX
    );
  Cpu16_I4_ireg_i_3_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_3_FXMUX,
      O => Cpu16_I4_ireg_x(3)
    );
  Cpu16_I4_ireg_i_3_FXMUX_561 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_3_F5MUX,
      O => Cpu16_I4_ireg_i_3_FXMUX
    );
  Cpu16_I4_ireg_i_3_F5MUX_562 : X_MUX2
    port map (
      IA => N32071,
      IB => N32073,
      SEL => Cpu16_I4_ireg_i_3_BXINV,
      O => Cpu16_I4_ireg_i_3_F5MUX
    );
  Cpu16_I4_ireg_i_3_BXINV_563 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18033,
      O => Cpu16_I4_ireg_i_3_BXINV
    );
  Cpu16_I4_ireg_i_3_CLKINV_564 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_i_3_CLKINV
    );
  Cpu16_I4_ireg_i_3_CEINV_565 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_ireg_i_3_CEINV
    );
  Cpu16_I4_ireg_i_4_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_ireg_i_4_FFX_RST
    );
  Cpu16_I4_ireg_i_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_i_4_DXMUX,
      CE => Cpu16_I4_ireg_i_4_CEINV,
      CLK => Cpu16_I4_ireg_i_4_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_i_4_FFX_RST,
      O => Cpu16_I4_ireg_i(4)
    );
  Cpu16_I4_ireg_x_4_14_G : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => Cpu16_I4_N18286,
      ADR1 => Cpu16_I4_ireg_c(4),
      ADR2 => Cpu16_I4_ireg_we_c,
      ADR3 => Cpu16_I3_acc_c_0_4,
      O => N32173
    );
  Cpu16_I4_ireg_x_4_14_F : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => Cpu16_I4_N18286,
      ADR1 => Cpu16_I4_n0182(4),
      ADR2 => Cpu16_I4_ireg_we_c,
      ADR3 => Cpu16_I3_acc_c_0_4,
      O => N32171
    );
  Cpu16_I4_ireg_i_4_DXMUX_566 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_4_FXMUX,
      O => Cpu16_I4_ireg_i_4_DXMUX
    );
  Cpu16_I4_ireg_i_4_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_4_FXMUX,
      O => Cpu16_I4_ireg_x(4)
    );
  Cpu16_I4_ireg_i_4_FXMUX_567 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_4_F5MUX,
      O => Cpu16_I4_ireg_i_4_FXMUX
    );
  Cpu16_I4_ireg_i_4_F5MUX_568 : X_MUX2
    port map (
      IA => N32171,
      IB => N32173,
      SEL => Cpu16_I4_ireg_i_4_BXINV,
      O => Cpu16_I4_ireg_i_4_F5MUX
    );
  Cpu16_I4_ireg_i_4_BXINV_569 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18033,
      O => Cpu16_I4_ireg_i_4_BXINV
    );
  Cpu16_I4_ireg_i_4_CLKINV_570 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_i_4_CLKINV
    );
  Cpu16_I4_ireg_i_4_CEINV_571 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_ireg_i_4_CEINV
    );
  Cpu16_I4_ireg_x_5_14_G : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_5,
      ADR1 => Cpu16_I4_ireg_we_c,
      ADR2 => Cpu16_I4_N18286,
      ADR3 => Cpu16_I4_ireg_c(5),
      O => N32168
    );
  Cpu16_I4_ireg_x_5_14_F : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_5,
      ADR1 => Cpu16_I4_ireg_we_c,
      ADR2 => Cpu16_I4_n0182(5),
      ADR3 => Cpu16_I4_N18286,
      O => N32166
    );
  Cpu16_I4_ireg_i_5_DXMUX_572 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_5_FXMUX,
      O => Cpu16_I4_ireg_i_5_DXMUX
    );
  Cpu16_I4_ireg_i_5_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_5_FXMUX,
      O => Cpu16_I4_ireg_x(5)
    );
  Cpu16_I4_ireg_i_5_FXMUX_573 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_5_F5MUX,
      O => Cpu16_I4_ireg_i_5_FXMUX
    );
  Cpu16_I4_ireg_i_5_F5MUX_574 : X_MUX2
    port map (
      IA => N32166,
      IB => N32168,
      SEL => Cpu16_I4_ireg_i_5_BXINV,
      O => Cpu16_I4_ireg_i_5_F5MUX
    );
  Cpu16_I4_ireg_i_5_BXINV_575 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18033,
      O => Cpu16_I4_ireg_i_5_BXINV
    );
  Cpu16_I4_ireg_i_5_CLKINV_576 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_i_5_CLKINV
    );
  Cpu16_I4_ireg_i_5_CEINV_577 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_ireg_i_5_CEINV
    );
  Cpu16_I4_ireg_x_6_14_F : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_6,
      ADR1 => Cpu16_I4_N18286,
      ADR2 => Cpu16_I4_ireg_we_c,
      ADR3 => Cpu16_I4_n0182(6),
      O => N32061
    );
  Cpu16_I4_ireg_i_6_DXMUX_578 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_6_FXMUX,
      O => Cpu16_I4_ireg_i_6_DXMUX
    );
  Cpu16_I4_ireg_i_6_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_6_FXMUX,
      O => Cpu16_I4_ireg_x(6)
    );
  Cpu16_I4_ireg_i_6_FXMUX_579 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_6_F5MUX,
      O => Cpu16_I4_ireg_i_6_FXMUX
    );
  Cpu16_I4_ireg_i_6_F5MUX_580 : X_MUX2
    port map (
      IA => N32061,
      IB => N32063,
      SEL => Cpu16_I4_ireg_i_6_BXINV,
      O => Cpu16_I4_ireg_i_6_F5MUX
    );
  Cpu16_I4_ireg_i_6_BXINV_581 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18033,
      O => Cpu16_I4_ireg_i_6_BXINV
    );
  Cpu16_I4_ireg_i_6_CLKINV_582 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_i_6_CLKINV
    );
  Cpu16_I4_ireg_i_6_CEINV_583 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_ireg_i_6_CEINV
    );
  Cpu16_I4_ireg_i_7_DXMUX_584 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_7_FXMUX,
      O => Cpu16_I4_ireg_i_7_DXMUX
    );
  Cpu16_I4_ireg_i_7_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_7_FXMUX,
      O => Cpu16_I4_ireg_x(7)
    );
  Cpu16_I4_ireg_i_7_FXMUX_585 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_7_F5MUX,
      O => Cpu16_I4_ireg_i_7_FXMUX
    );
  Cpu16_I4_ireg_i_7_F5MUX_586 : X_MUX2
    port map (
      IA => N32056,
      IB => N32058,
      SEL => Cpu16_I4_ireg_i_7_BXINV,
      O => Cpu16_I4_ireg_i_7_F5MUX
    );
  Cpu16_I4_ireg_i_7_BXINV_587 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18033,
      O => Cpu16_I4_ireg_i_7_BXINV
    );
  Cpu16_I4_ireg_i_7_CLKINV_588 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_i_7_CLKINV
    );
  Cpu16_I4_ireg_i_7_CEINV_589 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_ireg_i_7_CEINV
    );
  XLXI_4_Maddsub_n0001_inst_lut2_51 : X_LUT4
    generic map(
      INIT => X"3555"
    )
    port map (
      ADR0 => N30794,
      ADR1 => XLXI_4_n00021_SW11_O,
      ADR2 => Cpu16_pc_mux(1),
      ADR3 => Cpu16_pc_mux(0),
      O => XLXI_4_Maddsub_n0001_inst_lut2_5
    );
  Cpu16_I4_ireg_i_8_DXMUX_590 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_8_FXMUX,
      O => Cpu16_I4_ireg_i_8_DXMUX
    );
  Cpu16_I4_ireg_i_8_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_8_FXMUX,
      O => Cpu16_I4_ireg_x(8)
    );
  Cpu16_I4_ireg_i_8_FXMUX_591 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_i_8_F5MUX,
      O => Cpu16_I4_ireg_i_8_FXMUX
    );
  Cpu16_I4_ireg_i_8_F5MUX_592 : X_MUX2
    port map (
      IA => N32096,
      IB => N32098,
      SEL => Cpu16_I4_ireg_i_8_BXINV,
      O => Cpu16_I4_ireg_i_8_F5MUX
    );
  Cpu16_I4_ireg_i_8_BXINV_593 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18033,
      O => Cpu16_I4_ireg_i_8_BXINV
    );
  Cpu16_I4_ireg_i_8_CLKINV_594 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_i_8_CLKINV
    );
  Cpu16_I4_ireg_i_8_CEINV_595 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_ireg_i_8_CEINV
    );
  Cpu16_I3_n0147_0_82_SW11_F : X_LUT4
    generic map(
      INIT => X"FEF2"
    )
    port map (
      ADR0 => N30440,
      ADR1 => Cpu16_I2_TD_c_3_1,
      ADR2 => CHOICE746,
      ADR3 => N30438,
      O => N32051
    );
  N30892_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30892_F5MUX,
      O => N30892
    );
  N30892_F5MUX_596 : X_MUX2
    port map (
      IA => N32051,
      IB => N32053,
      SEL => N30892_BXINV,
      O => N30892_F5MUX
    );
  N30892_BXINV_597 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE712,
      O => N30892_BXINV
    );
  Cpu16_I1_pc_6_DXMUX_598 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_6_FXMUX,
      O => Cpu16_I1_pc_6_DXMUX
    );
  Cpu16_I1_pc_6_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_6_FXMUX,
      O => CPU_IADDR_OUT(6)
    );
  Cpu16_I1_pc_6_FXMUX_599 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_6_F,
      O => Cpu16_I1_pc_6_FXMUX
    );
  Cpu16_I1_pc_6_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_6_G,
      O => Cpu16_I1_iaddr_x_6_14_O
    );
  Cpu16_I1_pc_6_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_pc_6_SRINVNOT
    );
  Cpu16_I1_pc_6_CLKINV_600 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I1_pc_6_CLKINV
    );
  Cpu16_I1_Mmux_saddr_out_Result_11_6 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => Cpu16_I1_eaddr_x(11),
      ADR1 => Cpu16_I1_n0009(11),
      ADR2 => Cpu16_I1_n0024,
      ADR3 => Cpu16_I1_n0020,
      O => XLXN_14_11_G
    );
  XLXN_14_11_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_11_F,
      O => XLXN_14(11)
    );
  XLXN_14_11_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_11_G,
      O => Cpu16_I1_Mmux_saddr_out_Result_11_6_O
    );
  Cpu16_I1_iaddr_x_10_14 : X_LUT4
    generic map(
      INIT => X"5140"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_1_44_1,
      ADR1 => Cpu16_I2_pc_mux_x_0_104_1,
      ADR2 => Cpu16_I1_n0009(10),
      ADR3 => Cpu16_I1_pc(10),
      O => Cpu16_I1_pc_10_G
    );
  Cpu16_I1_pc_10_DXMUX_601 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_iaddr_x_10_47_O,
      O => Cpu16_I1_pc_10_DXMUX
    );
  Cpu16_I1_pc_10_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_10_G,
      O => Cpu16_I1_iaddr_x_10_14_O
    );
  Cpu16_I1_pc_10_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_pc_10_SRINVNOT
    );
  Cpu16_I1_pc_10_CLKINV_602 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I1_pc_10_CLKINV
    );
  Cpu16_I1_pc_7_DXMUX_603 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_7_FXMUX,
      O => Cpu16_I1_pc_7_DXMUX
    );
  Cpu16_I1_pc_7_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_7_FXMUX,
      O => CPU_IADDR_OUT(7)
    );
  Cpu16_I1_pc_7_FXMUX_604 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_7_F,
      O => Cpu16_I1_pc_7_FXMUX
    );
  Cpu16_I1_pc_7_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_7_G,
      O => Cpu16_I1_iaddr_x_7_14_O
    );
  Cpu16_I1_pc_7_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_pc_7_SRINVNOT
    );
  Cpu16_I1_pc_7_CLKINV_605 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I1_pc_7_CLKINV
    );
  Cpu16_I1_pc_11_DXMUX_606 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_iaddr_x_11_47_O,
      O => Cpu16_I1_pc_11_DXMUX
    );
  Cpu16_I1_pc_11_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_11_G,
      O => Cpu16_I1_iaddr_x_11_14_O
    );
  Cpu16_I1_pc_11_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_pc_11_SRINVNOT
    );
  Cpu16_I1_pc_11_CLKINV_607 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I1_pc_11_CLKINV
    );
  Cpu16_I1_pc_8_DXMUX_608 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_8_FXMUX,
      O => Cpu16_I1_pc_8_DXMUX
    );
  Cpu16_I1_pc_8_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_8_FXMUX,
      O => CPU_IADDR_OUT(8)
    );
  Cpu16_I1_pc_8_FXMUX_609 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_8_F,
      O => Cpu16_I1_pc_8_FXMUX
    );
  Cpu16_I1_pc_8_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_8_G,
      O => Cpu16_I1_iaddr_x_8_14_O
    );
  Cpu16_I1_pc_8_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_pc_8_SRINVNOT
    );
  Cpu16_I1_pc_8_CLKINV_610 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I1_pc_8_CLKINV
    );
  Cpu16_I3_n0147_9_72_SW1 : X_LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      ADR0 => Cpu16_I3_n0023,
      ADR1 => CHOICE1186,
      ADR2 => N30619,
      ADR3 => N30617,
      O => N31976_G
    );
  N31976_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31976_F,
      O => N31976
    );
  N31976_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31976_G,
      O => N30337
    );
  Cpu16_I3_skip_l62 : X_LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c(0),
      ADR1 => Cpu16_I3_acc_c_0_16,
      ADR2 => Cpu16_I2_TD_c(2),
      ADR3 => Cpu16_I2_TD_c(1),
      O => N31120_G
    );
  N31120_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31120_F,
      O => N31120
    );
  N31120_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31120_G,
      O => CHOICE1584
    );
  Cpu16_I2_n01011_SW3 : X_LUT4
    generic map(
      INIT => X"F1FF"
    )
    port map (
      ADR0 => MEM_DATA_OUT(2),
      ADR1 => MEM_DATA_OUT(1),
      ADR2 => MEM_DATA_OUT(3),
      ADR3 => Cpu16_I2_N15717,
      O => Cpu16_I2_C_mem_x_G
    );
  Cpu16_I2_C_mem_x_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_C_mem_x_F,
      O => Cpu16_I2_C_mem_x
    );
  Cpu16_I2_C_mem_x_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_C_mem_x_G,
      O => Cpu16_I2_n01011_SW3_O
    );
  Cpu16_I2_int_stop_c_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_stop_c_F,
      O => Cpu16_I4_n0216
    );
  Cpu16_I2_int_stop_c_DYMUX_611 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_stop_c_GYMUX,
      O => Cpu16_I2_int_stop_c_DYMUX
    );
  Cpu16_I2_int_stop_c_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_stop_c_GYMUX,
      O => Cpu16_int_stop
    );
  Cpu16_I2_int_stop_c_GYMUX_612 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_stop_c_G,
      O => Cpu16_I2_int_stop_c_GYMUX
    );
  Cpu16_I2_int_stop_c_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_int_stop_c_SRINVNOT
    );
  Cpu16_I2_int_stop_c_CLKINV_613 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_int_stop_c_CLKINV
    );
  XLXI_3_nadwe_c_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_nadwe_c_F,
      O => Cpu16_I4_N18224
    );
  XLXI_3_nadwe_c_DYMUX_614 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_nadwe_c_GYMUX,
      O => XLXI_3_nadwe_c_DYMUX
    );
  XLXI_3_nadwe_c_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_nadwe_c_GYMUX,
      O => CPU_NADWE
    );
  XLXI_3_nadwe_c_GYMUX_615 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_nadwe_c_G,
      O => XLXI_3_nadwe_c_GYMUX
    );
  XLXI_3_nadwe_c_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_3_nadwe_c_SRINVNOT
    );
  XLXI_3_nadwe_c_CLKINV_616 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_3_nadwe_c_CLKINV
    );
  XLXI_3_nadwe_c_CEINV_617 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_nadwe_c_N1214,
      O => XLXI_3_nadwe_c_CEINV
    );
  Cpu16_I2_Ker157051_SW0 : X_LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      ADR0 => Cpu16_I2_skip_c,
      ADR1 => Cpu16_I2_TC_c(2),
      ADR2 => Cpu16_I2_TC_c(0),
      ADR3 => XLXI_5_dw_s(0),
      O => Cpu16_I2_n0150_G
    );
  Cpu16_I2_n0150_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n0150_F,
      O => Cpu16_I2_n0150
    );
  Cpu16_I2_n0150_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n0150_G,
      O => N30488
    );
  XLXI_4_addr_c_1_DXMUX_618 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_1_FXMUX,
      O => XLXI_4_addr_c_1_DXMUX
    );
  XLXI_4_addr_c_1_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_1_FXMUX,
      O => XLXN_19(1)
    );
  XLXI_4_addr_c_1_FXMUX_619 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_1_F,
      O => XLXI_4_addr_c_1_FXMUX
    );
  XLXI_4_addr_c_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_1_G,
      O => XLXN_1
    );
  XLXI_4_addr_c_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_4_addr_c_1_SRINVNOT
    );
  XLXI_4_addr_c_1_CLKINV_620 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_4_addr_c_1_CLKINV
    );
  Cpu16_I2_Mmux_skip_x_Result1_1_621 : X_LUT4
    generic map(
      INIT => X"E4CC"
    )
    port map (
      ADR0 => Cpu16_I2_E_c_FFd2,
      ADR1 => Cpu16_skip,
      ADR2 => Cpu16_I2_skip_c,
      ADR3 => Cpu16_I2_nreset_v(1),
      O => N30884_G
    );
  N30884_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30884_F,
      O => N30884
    );
  N30884_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30884_G,
      O => Cpu16_I2_Mmux_skip_x_Result1_1
    );
  Cpu16_I4_ireg_c_11_DXMUX_622 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Mmux_n0158_Result_11_1_O,
      O => Cpu16_I4_ireg_c_11_DXMUX
    );
  Cpu16_I4_ireg_c_11_DYMUX_623 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Mmux_n0158_Result_10_1_O,
      O => Cpu16_I4_ireg_c_11_DYMUX
    );
  Cpu16_I4_ireg_c_11_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_ireg_c_11_SRINVNOT
    );
  Cpu16_I4_ireg_c_11_CLKINV_624 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_c_11_CLKINV
    );
  Cpu16_I2_TC_c_1_1_DXMUX_625 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TC_x(1),
      O => Cpu16_I2_TC_c_1_1_DXMUX
    );
  Cpu16_I2_TC_c_1_1_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TC_c_1_1_F,
      O => Cpu16_I2_C_rti
    );
  Cpu16_I2_TC_c_1_1_DYMUX_626 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TC_c_1_1_GYMUX,
      O => Cpu16_I2_TC_c_1_1_DYMUX
    );
  Cpu16_I2_TC_c_1_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TC_c_1_1_GYMUX,
      O => Cpu16_I2_TC_x(1)
    );
  Cpu16_I2_TC_c_1_1_GYMUX_627 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TC_c_1_1_G,
      O => Cpu16_I2_TC_c_1_1_GYMUX
    );
  Cpu16_I2_TC_c_1_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_TC_c_1_1_SRINVNOT
    );
  Cpu16_I2_TC_c_1_1_CLKINV_628 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_TC_c_1_1_CLKINV
    );
  XLXI_4_addr_c_7_DXMUX_629 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_7_FXMUX,
      O => XLXI_4_addr_c_7_DXMUX
    );
  XLXI_4_addr_c_7_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_7_FXMUX,
      O => XLXN_19(7)
    );
  XLXI_4_addr_c_7_FXMUX_630 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_7_F,
      O => XLXI_4_addr_c_7_FXMUX
    );
  XLXI_4_addr_c_7_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_7_G,
      O => XLXN_2
    );
  XLXI_4_addr_c_7_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_4_addr_c_7_SRINVNOT
    );
  XLXI_4_addr_c_7_CLKINV_631 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_4_addr_c_7_CLKINV
    );
  XLXI_2_mux_c_0_DXMUX_632 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_2_n00071_O,
      O => XLXI_2_mux_c_0_DXMUX
    );
  XLXI_2_mux_c_0_DYMUX_633 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_Mmux_n0016_Result43_O,
      O => XLXI_2_mux_c_0_DYMUX
    );
  XLXI_2_mux_c_0_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_2_mux_c_0_SRINVNOT
    );
  XLXI_2_mux_c_0_CLKINV_634 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_2_mux_c_0_CLKINV
    );
  Cpu16_I4_n020220_SW0 : X_LUT4
    generic map(
      INIT => X"0505"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(13),
      ADR1 => VCC,
      ADR2 => Cpu16_I2_idata_c(10),
      ADR3 => VCC,
      O => N31064_G
    );
  N31064_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31064_F,
      O => N31064
    );
  N31064_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31064_G,
      O => Cpu16_I4_n020220_SW0_O
    );
  Cpu16_I2_n00951_SW0 : X_LUT4
    generic map(
      INIT => X"FCFA"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(3),
      ADR1 => MEM_DATA_OUT(3),
      ADR2 => N30265,
      ADR3 => Cpu16_I2_n0150,
      O => N30976_G
    );
  N30976_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30976_F,
      O => N30976
    );
  N30976_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30976_G,
      O => N30562
    );
  Cpu16_I2_pc_mux_x_1_44_SW1 : X_LUT4
    generic map(
      INIT => X"CFCF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_n0166(2),
      ADR2 => Cpu16_I2_N15700,
      ADR3 => VCC,
      O => Cpu16_I2_pc_mux_x_1_44_2_G
    );
  Cpu16_I2_pc_mux_x_1_44_2_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_pc_mux_x_1_44_2_F,
      O => Cpu16_I2_pc_mux_x_1_44_2
    );
  Cpu16_I2_pc_mux_x_1_44_2_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_pc_mux_x_1_44_2_G,
      O => N31355
    );
  Cpu16_I1_Mmux_saddr_out_Result_0_6 : X_LUT4
    generic map(
      INIT => X"BA30"
    )
    port map (
      ADR0 => Cpu16_I1_n0020,
      ADR1 => Cpu16_I1_pc(0),
      ADR2 => Cpu16_I1_n0024,
      ADR3 => Cpu16_I1_eaddr_x(0),
      O => XLXN_14_0_G
    );
  XLXN_14_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_0_F,
      O => XLXN_14(0)
    );
  XLXN_14_0_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_0_G,
      O => Cpu16_I1_Mmux_saddr_out_Result_0_6_O
    );
  Cpu16_I3_n0023_SW14 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => Cpu16_I3_nreset_v(0),
      ADR1 => NRESET_IN_BUFGP,
      ADR2 => Cpu16_I3_nreset_v(1),
      ADR3 => Cpu16_I2_valid_c,
      O => CHOICE1593_G
    );
  CHOICE1593_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1593_F,
      O => CHOICE1593
    );
  CHOICE1593_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1593_G,
      O => CHOICE255
    );
  Cpu16_I1_Mmux_saddr_out_Result_1_6 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => Cpu16_I1_n0020,
      ADR1 => Cpu16_I1_eaddr_x(1),
      ADR2 => Cpu16_I1_n0024,
      ADR3 => Cpu16_I1_n0009(1),
      O => XLXN_14_1_G
    );
  XLXN_14_1_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_1_F,
      O => XLXN_14(1)
    );
  XLXN_14_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_1_G,
      O => Cpu16_I1_Mmux_saddr_out_Result_1_6_O
    );
  Cpu16_I2_n01501_2_635 : X_LUT4
    generic map(
      INIT => X"DFFF"
    )
    port map (
      ADR0 => Cpu16_I2_N15618,
      ADR1 => N30488,
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => Cpu16_I2_nreset_v(1),
      O => N31223_G
    );
  N31223_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31223_F,
      O => N31223
    );
  N31223_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31223_G,
      O => Cpu16_I2_n01501_2
    );
  XLXN_14_2_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_2_F,
      O => XLXN_14(2)
    );
  XLXN_14_2_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_2_G,
      O => Cpu16_I1_Mmux_saddr_out_Result_2_6_O
    );
  Cpu16_I2_ndre_x1_SW0_SW2_SW0 : X_LUT4
    generic map(
      INIT => X"FCAA"
    )
    port map (
      ADR0 => N31173,
      ADR1 => MEM_DATA_OUT(10),
      ADR2 => MEM_DATA_OUT(12),
      ADR3 => Cpu16_I2_n01501_2,
      O => N31051_G
    );
  N31051_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31051_F,
      O => N31051
    );
  N31051_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31051_G,
      O => Cpu16_I2_ndre_x1_SW0_SW2_SW0_O
    );
  XLXN_14_3_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_3_F,
      O => XLXN_14(3)
    );
  XLXN_14_3_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_3_G,
      O => Cpu16_I1_Mmux_saddr_out_Result_3_6_O
    );
  XLXI_2_nWE_RAM_c_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_2_nWE_RAM_c_F,
      O => ADDR_OUT_EXT_9_OBUF
    );
  XLXI_2_nWE_RAM_c_DYMUX_636 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_2_nWE_RAM_x1_O,
      O => XLXI_2_nWE_RAM_c_DYMUX
    );
  XLXI_2_nWE_RAM_c_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_2_nWE_RAM_c_SRINVNOT
    );
  XLXI_2_nWE_RAM_c_CLKINV_637 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_2_nWE_RAM_c_CLKINV
    );
  Cpu16_I1_Mmux_saddr_out_Result_4_6 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => Cpu16_I1_n0009(4),
      ADR1 => Cpu16_I1_n0024,
      ADR2 => Cpu16_I1_n0020,
      ADR3 => Cpu16_I1_eaddr_x(4),
      O => XLXN_14_4_G
    );
  XLXN_14_4_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_4_F,
      O => XLXN_14(4)
    );
  XLXN_14_4_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_4_G,
      O => Cpu16_I1_Mmux_saddr_out_Result_4_6_O
    );
  XLXI_5_nwait_c_0_DXMUX_638 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0009_0_1_O,
      O => XLXI_5_nwait_c_0_DXMUX
    );
  XLXI_5_nwait_c_0_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_nwait_c_0_G,
      O => NACS_EXT
    );
  XLXI_5_nwait_c_0_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_5_nwait_c_0_SRINVNOT
    );
  XLXI_5_nwait_c_0_CLKINV_639 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_5_nwait_c_0_CLKINV
    );
  XLXI_5_nwait_c_1_DYMUX_640 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0009_1_1_O,
      O => XLXI_5_nwait_c_1_DYMUX
    );
  XLXI_5_nwait_c_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_5_nwait_c_1_SRINVNOT
    );
  XLXI_5_nwait_c_1_CLKINV_641 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_5_nwait_c_1_CLKINV
    );
  XLXI_5_nwait_c_3_DXMUX_642 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0009_3_1_O,
      O => XLXI_5_nwait_c_3_DXMUX
    );
  XLXI_5_nwait_c_3_DYMUX_643 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0009_2_1_O,
      O => XLXI_5_nwait_c_3_DYMUX
    );
  XLXI_5_nwait_c_3_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_5_nwait_c_3_SRINVNOT
    );
  XLXI_5_nwait_c_3_CLKINV_644 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_5_nwait_c_3_CLKINV
    );
  XLXN_14_5_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_5_F,
      O => XLXN_14(5)
    );
  XLXN_14_5_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_5_G,
      O => Cpu16_I1_Mmux_saddr_out_Result_5_6_O
    );
  XLXI_5_nwait_c_5_DXMUX_645 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0009_5_1_O,
      O => XLXI_5_nwait_c_5_DXMUX
    );
  XLXI_5_nwait_c_5_DYMUX_646 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0009_4_1_O,
      O => XLXI_5_nwait_c_5_DYMUX
    );
  XLXI_5_nwait_c_5_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_5_nwait_c_5_SRINVNOT
    );
  XLXI_5_nwait_c_5_CLKINV_647 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_5_nwait_c_5_CLKINV
    );
  XLXI_5_n0009_6_1 : X_LUT4
    generic map(
      INIT => X"F040"
    )
    port map (
      ADR0 => NACS_EXT,
      ADR1 => CHOICE589,
      ADR2 => XLXI_5_n0011(6),
      ADR3 => CHOICE583,
      O => XLXI_5_n0009_6_1_O
    );
  XLXI_5_nwait_c_7_DXMUX_648 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0009_7_1_O,
      O => XLXI_5_nwait_c_7_DXMUX
    );
  XLXI_5_nwait_c_7_DYMUX_649 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0009_6_1_O,
      O => XLXI_5_nwait_c_7_DYMUX
    );
  XLXI_5_nwait_c_7_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_5_nwait_c_7_SRINVNOT
    );
  XLXI_5_nwait_c_7_CLKINV_650 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_5_nwait_c_7_CLKINV
    );
  XLXI_4_addr_c_0_DYMUX_651 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_0_GYMUX,
      O => XLXI_4_addr_c_0_DYMUX
    );
  XLXI_4_addr_c_0_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_0_GYMUX,
      O => XLXN_19(0)
    );
  XLXI_4_addr_c_0_GYMUX_652 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_0_G,
      O => XLXI_4_addr_c_0_GYMUX
    );
  XLXI_4_addr_c_0_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_4_addr_c_0_SRINVNOT
    );
  XLXI_4_addr_c_0_CLKINV_653 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_4_addr_c_0_CLKINV
    );
  XLXN_14_6_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_6_F,
      O => XLXN_14(6)
    );
  XLXN_14_6_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_6_G,
      O => Cpu16_I1_Mmux_saddr_out_Result_6_6_O
    );
  XLXI_4_addr_c_3_DXMUX_654 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_3_FXMUX,
      O => XLXI_4_addr_c_3_DXMUX
    );
  XLXI_4_addr_c_3_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_3_FXMUX,
      O => XLXN_19(3)
    );
  XLXI_4_addr_c_3_FXMUX_655 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_3_F,
      O => XLXI_4_addr_c_3_FXMUX
    );
  XLXI_4_addr_c_3_DYMUX_656 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_3_GYMUX,
      O => XLXI_4_addr_c_3_DYMUX
    );
  XLXI_4_addr_c_3_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_3_GYMUX,
      O => XLXN_19(2)
    );
  XLXI_4_addr_c_3_GYMUX_657 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_3_G,
      O => XLXI_4_addr_c_3_GYMUX
    );
  XLXI_4_addr_c_3_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_4_addr_c_3_SRINVNOT
    );
  XLXI_4_addr_c_3_CLKINV_658 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_4_addr_c_3_CLKINV
    );
  XLXI_4_addr_c_5_DXMUX_659 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_5_FXMUX,
      O => XLXI_4_addr_c_5_DXMUX
    );
  XLXI_4_addr_c_5_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_5_FXMUX,
      O => XLXN_19(5)
    );
  XLXI_4_addr_c_5_FXMUX_660 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_5_F,
      O => XLXI_4_addr_c_5_FXMUX
    );
  XLXI_4_addr_c_5_DYMUX_661 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_5_GYMUX,
      O => XLXI_4_addr_c_5_DYMUX
    );
  XLXI_4_addr_c_5_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_5_GYMUX,
      O => XLXN_19(4)
    );
  XLXI_4_addr_c_5_GYMUX_662 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_5_G,
      O => XLXI_4_addr_c_5_GYMUX
    );
  XLXI_4_addr_c_5_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_4_addr_c_5_SRINVNOT
    );
  XLXI_4_addr_c_5_CLKINV_663 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_4_addr_c_5_CLKINV
    );
  XLXI_4_addr_c_6_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_6_F,
      O => XLXI_4_n00021_SW11_O
    );
  XLXI_4_addr_c_6_DYMUX_664 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_6_GYMUX,
      O => XLXI_4_addr_c_6_DYMUX
    );
  XLXI_4_addr_c_6_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_6_GYMUX,
      O => XLXN_19(6)
    );
  XLXI_4_addr_c_6_GYMUX_665 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_addr_c_6_G,
      O => XLXI_4_addr_c_6_GYMUX
    );
  XLXI_4_addr_c_6_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_4_addr_c_6_SRINVNOT
    );
  XLXI_4_addr_c_6_CLKINV_666 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_4_addr_c_6_CLKINV
    );
  XLXN_14_7_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_7_F,
      O => XLXN_14(7)
    );
  XLXN_14_7_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_7_G,
      O => Cpu16_I1_Mmux_saddr_out_Result_7_6_O
    );
  CHOICE421_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE421_F,
      O => CHOICE421
    );
  CHOICE421_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE421_G,
      O => Cpu16_I2_pc_mux_x_0_104_1
    );
  Cpu16_I1_Ker136321 : X_LUT4
    generic map(
      INIT => X"B73F"
    )
    port map (
      ADR0 => Cpu16_pc_mux(1),
      ADR1 => Cpu16_I1_n0010,
      ADR2 => Cpu16_pc_mux(2),
      ADR3 => Cpu16_pc_mux(0),
      O => CHOICE436_G
    );
  CHOICE436_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE436_F,
      O => CHOICE436
    );
  CHOICE436_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE436_G,
      O => Cpu16_I1_N13634
    );
  CHOICE437_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE437_F,
      O => CHOICE437
    );
  CHOICE437_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE437_G,
      O => Cpu16_I2_pc_mux_x_1_44_1
    );
  XLXN_14_8_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_8_F,
      O => XLXN_14(8)
    );
  XLXN_14_8_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_8_G,
      O => Cpu16_I1_Mmux_saddr_out_Result_8_6_O
    );
  Cpu16_I1_Mmux_saddr_out_Result_9_6 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => Cpu16_I1_n0020,
      ADR1 => Cpu16_I1_eaddr_x(9),
      ADR2 => Cpu16_I1_n0024,
      ADR3 => Cpu16_I1_n0009(9),
      O => XLXN_14_9_G
    );
  XLXN_14_9_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_9_F,
      O => XLXN_14(9)
    );
  XLXN_14_9_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXN_14_9_G,
      O => Cpu16_I1_Mmux_saddr_out_Result_9_6_O
    );
  CHOICE469_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE469_F,
      O => CHOICE469
    );
  CHOICE469_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE469_G,
      O => Cpu16_I2_pc_mux_x_2_46_1
    );
  Cpu16_I2_skip_c_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_skip_c_F,
      O => Cpu16_I2_skip_x
    );
  Cpu16_I2_skip_c_DYMUX_667 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_skip_c_GYMUX,
      O => Cpu16_I2_skip_c_DYMUX
    );
  Cpu16_I2_skip_c_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_skip_c_GYMUX,
      O => Cpu16_skip
    );
  Cpu16_I2_skip_c_GYMUX_668 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_skip_c_G,
      O => Cpu16_I2_skip_c_GYMUX
    );
  Cpu16_I2_skip_c_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_skip_c_SRINVNOT
    );
  Cpu16_I2_skip_c_CLKINV_669 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_skip_c_CLKINV
    );
  Cpu16_I2_skip_c_CEINV_670 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n0151,
      O => Cpu16_I2_skip_c_CEINV
    );
  XLXI_5_ndre_c_DXMUX_671 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_ndre_c_FXMUX,
      O => XLXI_5_ndre_c_DXMUX
    );
  XLXI_5_ndre_c_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_ndre_c_FXMUX,
      O => Cpu16_I4_ndre_x1_1
    );
  XLXI_5_ndre_c_FXMUX_672 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_ndre_c_F,
      O => XLXI_5_ndre_c_FXMUX
    );
  XLXI_5_ndre_c_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_ndre_c_G,
      O => Cpu16_ndre_int
    );
  XLXI_5_ndre_c_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_5_ndre_c_SRINVNOT
    );
  XLXI_5_ndre_c_CLKINV_673 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_5_ndre_c_CLKINV
    );
  XLXI_5_ndre_c_CEINV : X_INV
    port map (
      I => XLXI_5_dw_s(0),
      O => XLXI_5_ndre_c_CEINVNOT
    );
  Cpu16_I3_Mmux_data_x_Result_0_32_SW1 : X_LUT4
    generic map(
      INIT => X"CDEF"
    )
    port map (
      ADR0 => MEM_DATA_OUT(6),
      ADR1 => MEM_DATA_OUT(5),
      ADR2 => Cpu16_I4_ireg_c(0),
      ADR3 => Cpu16_I4_data_exp_c(0),
      O => CHOICE1531_G
    );
  CHOICE1531_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1531_F,
      O => CHOICE1531
    );
  CHOICE1531_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1531_G,
      O => Cpu16_I3_Mmux_data_x_Result_0_32_SW1_O
    );
  CHOICE1553_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1553_F,
      O => CHOICE1553
    );
  CHOICE1553_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1553_G,
      O => N31072
    );
  CHOICE1538_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1538_F,
      O => CHOICE1538
    );
  CHOICE1538_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1538_G,
      O => Cpu16_I2_C_store_x
    );
  CHOICE1562_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1562_F,
      O => CHOICE1562
    );
  CHOICE1562_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1562_G,
      O => N31066
    );
  CHOICE1476_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1476_F,
      O => CHOICE1476
    );
  CHOICE1476_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1476_G,
      O => Cpu16_daddr_is(2)
    );
  Cpu16_I2_ndre_x1_SW1 : X_LUT4
    generic map(
      INIT => X"DFFF"
    )
    port map (
      ADR0 => CHOICE1562,
      ADR1 => N31926,
      ADR2 => CHOICE1553,
      ADR3 => Cpu16_I2_C_mem_x,
      O => Cpu16_I4_n0202_G
    );
  Cpu16_I4_n0202_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0202_F,
      O => Cpu16_I4_n0202
    );
  Cpu16_I4_n0202_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0202_G,
      O => Cpu16_I2_ndre_x1_SW1_O
    );
  Cpu16_I3_acc_c_0_0_1_DXMUX_674 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0147_0_208_1_O,
      O => Cpu16_I3_acc_c_0_0_1_DXMUX
    );
  Cpu16_I3_acc_c_0_0_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_0_1_G,
      O => N30890
    );
  Cpu16_I3_acc_c_0_0_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_0_1_SRINVNOT
    );
  Cpu16_I3_acc_c_0_0_1_CLKINV_675 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_0_1_CLKINV
    );
  Cpu16_I2_data_is_c_1_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_1_F,
      O => CHOICE1479
    );
  Cpu16_I2_data_is_c_1_DYMUX_676 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_1_GYMUX,
      O => Cpu16_I2_data_is_c_1_DYMUX
    );
  Cpu16_I2_data_is_c_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_1_GYMUX,
      O => Cpu16_daddr_is(1)
    );
  Cpu16_I2_data_is_c_1_GYMUX_677 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_1_G,
      O => Cpu16_I2_data_is_c_1_GYMUX
    );
  Cpu16_I2_data_is_c_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_data_is_c_1_SRINVNOT
    );
  Cpu16_I2_data_is_c_1_CLKINV_678 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_data_is_c_1_CLKINV
    );
  Cpu16_I2_ndre_x1_SW1_SW0 : X_LUT4
    generic map(
      INIT => X"FFEF"
    )
    port map (
      ADR0 => Cpu16_I2_skip_x,
      ADR1 => N31234,
      ADR2 => N30562,
      ADR3 => N30558,
      O => CHOICE1483_G
    );
  CHOICE1483_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1483_F,
      O => CHOICE1483
    );
  CHOICE1483_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1483_G,
      O => Cpu16_I2_ndre_x1_SW1_SW0_O
    );
  Cpu16_I3_Mmux_data_x_Result_10_85 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => Cpu16_I4_N18018,
      ADR1 => Cpu16_I4_n0202,
      ADR2 => CHOICE955,
      ADR3 => CHOICE942,
      O => CHOICE1241_G
    );
  CHOICE1241_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1241_F,
      O => CHOICE1241
    );
  CHOICE1241_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1241_G,
      O => CHOICE957
    );
  Cpu16_I4_Ker183551 : X_LUT4
    generic map(
      INIT => X"11D1"
    )
    port map (
      ADR0 => N30694,
      ADR1 => Cpu16_I2_n01501_2,
      ADR2 => MEM_DATA_OUT(4),
      ADR3 => MEM_DATA_OUT(5),
      O => CHOICE1421_G
    );
  CHOICE1421_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1421_F,
      O => CHOICE1421
    );
  CHOICE1421_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1421_G,
      O => Cpu16_I4_N18357
    );
  Cpu16_I2_ndre_x1_SW2_SW0 : X_LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      ADR0 => Cpu16_I2_skip_x,
      ADR1 => N30562,
      ADR2 => N31238,
      ADR3 => N30558,
      O => CHOICE1428_G
    );
  CHOICE1428_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1428_F,
      O => CHOICE1428
    );
  CHOICE1428_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1428_G,
      O => Cpu16_I2_ndre_x1_SW2_SW0_O
    );
  CHOICE1424_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1424_F,
      O => CHOICE1424
    );
  CHOICE1424_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1424_G,
      O => Cpu16_daddr_is(0)
    );
  CHOICE1296_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1296_F,
      O => CHOICE1296
    );
  CHOICE1296_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1296_G,
      O => CHOICE902
    );
  Cpu16_I2_ndre_x1_SW3_SW0 : X_LUT4
    generic map(
      INIT => X"FFFD"
    )
    port map (
      ADR0 => N30562,
      ADR1 => Cpu16_I2_skip_x,
      ADR2 => N30558,
      ADR3 => N31242,
      O => CHOICE1340_G
    );
  CHOICE1340_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1340_F,
      O => CHOICE1340
    );
  CHOICE1340_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1340_G,
      O => Cpu16_I2_ndre_x1_SW3_SW0_O
    );
  Cpu16_I2_ndre_x1_SW12 : X_LUT4
    generic map(
      INIT => X"FBFF"
    )
    port map (
      ADR0 => N31230,
      ADR1 => N30562,
      ADR2 => Cpu16_I2_skip_x,
      ADR3 => CHOICE1562,
      O => Cpu16_I4_N18018_G
    );
  Cpu16_I4_N18018_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18018_F,
      O => Cpu16_I4_N18018
    );
  Cpu16_I4_N18018_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18018_G,
      O => Cpu16_I2_ndre_x1_SW12_O
    );
  Cpu16_I3_Mmux_data_x_Result_12_Q : X_LUT4
    generic map(
      INIT => X"CE02"
    )
    port map (
      ADR0 => Cpu16_I4_N18350,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => N24899,
      ADR3 => Cpu16_data_is_int(12),
      O => CHOICE1351_G
    );
  CHOICE1351_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1351_F,
      O => CHOICE1351
    );
  CHOICE1351_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1351_G,
      O => Cpu16_I3_data_x_12_Q
    );
  Cpu16_I2_ndre_x1_SW4_SW0 : X_LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      ADR0 => Cpu16_I2_skip_x,
      ADR1 => N30558,
      ADR2 => N31271,
      ADR3 => N30562,
      O => CHOICE1285_G
    );
  CHOICE1285_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1285_F,
      O => CHOICE1285
    );
  CHOICE1285_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1285_G,
      O => Cpu16_I2_ndre_x1_SW4_SW0_O
    );
  CHOICE1439_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1439_F,
      O => CHOICE1439
    );
  CHOICE1439_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1439_G,
      O => Cpu16_I3_data_x_13_Q
    );
  Cpu16_I2_ndre_x1_SW5_SW0 : X_LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      ADR0 => N30558,
      ADR1 => Cpu16_I2_Mmux_skip_x_Result1_1,
      ADR2 => N31405,
      ADR3 => N30562,
      O => CHOICE1230_G
    );
  CHOICE1230_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1230_F,
      O => CHOICE1230
    );
  CHOICE1230_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1230_G,
      O => Cpu16_I2_ndre_x1_SW5_SW0_O
    );
  Cpu16_I3_Mmux_data_x_Result_14_Q : X_LUT4
    generic map(
      INIT => X"D1C0"
    )
    port map (
      ADR0 => N24783,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => Cpu16_data_is_int(14),
      ADR3 => Cpu16_I4_N18350,
      O => CHOICE1494_G
    );
  CHOICE1494_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1494_F,
      O => CHOICE1494
    );
  CHOICE1494_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1494_G,
      O => Cpu16_I3_data_x_14_Q
    );
  Cpu16_I2_ndre_x1_SW6_SW0 : X_LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      ADR0 => N30558,
      ADR1 => N30562,
      ADR2 => N31409,
      ADR3 => Cpu16_I2_Mmux_skip_x_Result1_1,
      O => CHOICE1175_G
    );
  CHOICE1175_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1175_F,
      O => CHOICE1175
    );
  CHOICE1175_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1175_G,
      O => Cpu16_I2_ndre_x1_SW6_SW0_O
    );
  Cpu16_I3_Mmux_data_x_Result_15_Q : X_LUT4
    generic map(
      INIT => X"F202"
    )
    port map (
      ADR0 => Cpu16_I4_N18350,
      ADR1 => N24468,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => Cpu16_data_is_int(15),
      O => CHOICE1631_G
    );
  CHOICE1631_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1631_F,
      O => CHOICE1631
    );
  CHOICE1631_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1631_G,
      O => Cpu16_I3_data_x_15_Q
    );
  Cpu16_I2_ndre_x1_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => N30558,
      ADR1 => Cpu16_I2_skip_x,
      ADR2 => N30269,
      ADR3 => N30976,
      O => CHOICE1120_G
    );
  CHOICE1120_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1120_F,
      O => CHOICE1120
    );
  CHOICE1120_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1120_G,
      O => N30906
    );
  Cpu16_I3_acc_i_0_0_DXMUX_679 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_0_FXMUX,
      O => Cpu16_I3_acc_i_0_0_DXMUX
    );
  Cpu16_I3_acc_i_0_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_0_FXMUX,
      O => Cpu16_I3_acc(0, 0)
    );
  Cpu16_I3_acc_i_0_0_FXMUX_680 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_0_F,
      O => Cpu16_I3_acc_i_0_0_FXMUX
    );
  Cpu16_I3_acc_i_0_0_DYMUX_681 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc(0, 1),
      O => Cpu16_I3_acc_i_0_0_DYMUX
    );
  Cpu16_I3_acc_i_0_0_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_0_G,
      O => CHOICE720
    );
  Cpu16_I3_acc_i_0_0_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_0_SRINVNOT
    );
  Cpu16_I3_acc_i_0_0_CLKINV_682 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_0_CLKINV
    );
  Cpu16_I3_acc_i_0_0_CEINV_683 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_start_c,
      O => Cpu16_I3_acc_i_0_0_CEINV
    );
  Cpu16_I3_Mmux_data_x_Result_8_37 : X_LUT4
    generic map(
      INIT => X"0200"
    )
    port map (
      ADR0 => Cpu16_I4_iinc_c(8),
      ADR1 => Cpu16_I2_Mmux_idata_x_Result_4_1_1,
      ADR2 => Cpu16_I2_Mmux_idata_x_Result_6_1_1,
      ADR3 => Cpu16_daddr_is(1),
      O => CHOICE1065_G
    );
  CHOICE1065_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1065_F,
      O => CHOICE1065
    );
  CHOICE1065_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1065_G,
      O => Cpu16_I3_Mmux_data_x_Result_8_37_O
    );
  Cpu16_I3_Mmux_data_x_Result_9_37 : X_LUT4
    generic map(
      INIT => X"0200"
    )
    port map (
      ADR0 => Cpu16_daddr_is(1),
      ADR1 => Cpu16_I2_Mmux_idata_x_Result_4_1_1,
      ADR2 => Cpu16_I2_Mmux_idata_x_Result_6_1_1,
      ADR3 => Cpu16_I4_iinc_c(9),
      O => CHOICE1010_G
    );
  CHOICE1010_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1010_F,
      O => CHOICE1010
    );
  CHOICE1010_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1010_G,
      O => Cpu16_I3_Mmux_data_x_Result_9_37_O
    );
  Cpu16_I3_acc_i_0_2_DXMUX_684 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_2_FXMUX,
      O => Cpu16_I3_acc_i_0_2_DXMUX
    );
  Cpu16_I3_acc_i_0_2_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_2_FXMUX,
      O => Cpu16_I3_acc(0, 2)
    );
  Cpu16_I3_acc_i_0_2_FXMUX_685 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_2_F,
      O => Cpu16_I3_acc_i_0_2_FXMUX
    );
  Cpu16_I3_acc_i_0_2_DYMUX_686 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc(0, 3),
      O => Cpu16_I3_acc_i_0_2_DYMUX
    );
  Cpu16_I3_acc_i_0_2_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_2_G,
      O => Cpu16_I3_n0147_2_39_SW0_O
    );
  Cpu16_I3_acc_i_0_2_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_2_SRINVNOT
    );
  Cpu16_I3_acc_i_0_2_CLKINV_687 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_2_CLKINV
    );
  Cpu16_I3_acc_i_0_2_CEINV_688 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_start_c_1,
      O => Cpu16_I3_acc_i_0_2_CEINV
    );
  Cpu16_I2_TC_x_2_SW0_SW1 : X_LUT4
    generic map(
      INIT => X"FFFD"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_I2_idata_c(1),
      ADR2 => Cpu16_I2_idata_c(2),
      ADR3 => Cpu16_I2_n0150,
      O => N21764_G
    );
  N21764_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N21764_F,
      O => N21764
    );
  N21764_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N21764_G,
      O => Cpu16_I2_TC_x_2_SW0_SW1_O
    );
  Cpu16_I4_n020216_SW0 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(7),
      ADR1 => Cpu16_I2_idata_c(12),
      ADR2 => Cpu16_I2_idata_c(8),
      ADR3 => Cpu16_I2_idata_c(9),
      O => N31173_G
    );
  N31173_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31173_F,
      O => N31173
    );
  N31173_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31173_G,
      O => N31070
    );
  Cpu16_I3_acc_i_0_4_DXMUX_689 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_4_FXMUX,
      O => Cpu16_I3_acc_i_0_4_DXMUX
    );
  Cpu16_I3_acc_i_0_4_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_4_FXMUX,
      O => Cpu16_I3_acc(0, 4)
    );
  Cpu16_I3_acc_i_0_4_FXMUX_690 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_4_F,
      O => Cpu16_I3_acc_i_0_4_FXMUX
    );
  Cpu16_I3_acc_i_0_4_DYMUX_691 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc(0, 5),
      O => Cpu16_I3_acc_i_0_4_DYMUX
    );
  Cpu16_I3_acc_i_0_4_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_4_G,
      O => Cpu16_I3_n0147_4_39_SW0_O
    );
  Cpu16_I3_acc_i_0_4_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_4_SRINVNOT
    );
  Cpu16_I3_acc_i_0_4_CLKINV_692 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_4_CLKINV
    );
  Cpu16_I3_acc_i_0_4_CEINV_693 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_start_c_1,
      O => Cpu16_I3_acc_i_0_4_CEINV
    );
  Cpu16_I2_Ker156731_SW0 : X_LUT4
    generic map(
      INIT => X"FCFA"
    )
    port map (
      ADR0 => Cpu16_skip,
      ADR1 => Cpu16_I2_skip_c,
      ADR2 => N31580,
      ADR3 => Cpu16_I2_E_c_FFd2,
      O => N31230_G
    );
  N31230_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31230_F,
      O => N31230
    );
  N31230_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31230_G,
      O => N30269
    );
  N31926_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31926_F,
      O => N31926
    );
  N31926_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31926_G,
      O => Cpu16_I2_C_raw
    );
  Cpu16_I2_pc_mux_x_0_38 : X_LUT4
    generic map(
      INIT => X"0023"
    )
    port map (
      ADR0 => Cpu16_I2_C_rti,
      ADR1 => Cpu16_I2_C_jmp,
      ADR2 => N30405,
      ADR3 => Cpu16_I2_Mmux_skip_x_Result1_1,
      O => Cpu16_pc_mux_0_G
    );
  Cpu16_pc_mux_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_pc_mux_0_F,
      O => Cpu16_pc_mux(0)
    );
  Cpu16_pc_mux_0_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_pc_mux_0_G,
      O => CHOICE679
    );
  Cpu16_I3_acc_i_0_6_DXMUX_694 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_6_FXMUX,
      O => Cpu16_I3_acc_i_0_6_DXMUX
    );
  Cpu16_I3_acc_i_0_6_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_6_FXMUX,
      O => Cpu16_I3_acc(0, 6)
    );
  Cpu16_I3_acc_i_0_6_FXMUX_695 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_6_F,
      O => Cpu16_I3_acc_i_0_6_FXMUX
    );
  Cpu16_I3_acc_i_0_6_DYMUX_696 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc(0, 7),
      O => Cpu16_I3_acc_i_0_6_DYMUX
    );
  Cpu16_I3_acc_i_0_6_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_6_G,
      O => Cpu16_I3_n0147_6_39_SW0_O
    );
  Cpu16_I3_acc_i_0_6_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_6_SRINVNOT
    );
  Cpu16_I3_acc_i_0_6_CLKINV_697 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_6_CLKINV
    );
  Cpu16_I3_acc_i_0_6_CEINV_698 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_start_c_1,
      O => Cpu16_I3_acc_i_0_6_CEINV
    );
  Cpu16_I2_n00771 : X_LUT4
    generic map(
      INIT => X"03AA"
    )
    port map (
      ADR0 => N30698,
      ADR1 => MEM_DATA_OUT(1),
      ADR2 => MEM_DATA_OUT(2),
      ADR3 => Cpu16_I2_n0150,
      O => N30261_G
    );
  N30261_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30261_F,
      O => N30261
    );
  N30261_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30261_G,
      O => Cpu16_I2_n0077
    );
  N30412_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30412_F,
      O => N30412
    );
  N30412_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30412_G,
      O => Cpu16_I4_n020253_SW0_SW0_SW1_O
    );
  Cpu16_I2_n01011_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"A000"
    )
    port map (
      ADR0 => Cpu16_I2_nreset_v(1),
      ADR1 => VCC,
      ADR2 => Cpu16_I2_TC_c(1),
      ADR3 => NRESET_IN_BUFGP,
      O => N30265_G
    );
  N30265_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30265_F,
      O => N30265
    );
  N30265_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30265_G,
      O => Cpu16_I2_n01011_SW0_SW0_O
    );
  N30416_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30416_F,
      O => N30416
    );
  N30416_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30416_G,
      O => Cpu16_I4_N18068
    );
  Cpu16_I3_acc_i_0_8_DXMUX_699 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_8_FXMUX,
      O => Cpu16_I3_acc_i_0_8_DXMUX
    );
  Cpu16_I3_acc_i_0_8_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_8_FXMUX,
      O => Cpu16_I3_acc(0, 8)
    );
  Cpu16_I3_acc_i_0_8_FXMUX_700 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_8_F,
      O => Cpu16_I3_acc_i_0_8_FXMUX
    );
  Cpu16_I3_acc_i_0_8_DYMUX_701 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc(0, 9),
      O => Cpu16_I3_acc_i_0_8_DYMUX
    );
  Cpu16_I3_acc_i_0_8_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_8_G,
      O => Cpu16_I3_n0147_8_39_SW0_O
    );
  Cpu16_I3_acc_i_0_8_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_8_SRINVNOT
    );
  Cpu16_I3_acc_i_0_8_CLKINV_702 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_8_CLKINV
    );
  Cpu16_I3_acc_i_0_8_CEINV_703 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_start_c_1,
      O => Cpu16_I3_acc_i_0_8_CEINV
    );
  Cpu16_I2_data_is_c_2_DXMUX_704 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_2_FXMUX,
      O => Cpu16_I2_data_is_c_2_DXMUX
    );
  Cpu16_I2_data_is_c_2_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_2_FXMUX,
      O => Cpu16_I2_Mmux_idata_x_Result_6_1_1
    );
  Cpu16_I2_data_is_c_2_FXMUX_705 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_2_F,
      O => Cpu16_I2_data_is_c_2_FXMUX
    );
  Cpu16_I2_data_is_c_2_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_2_G,
      O => Cpu16_I2_n01501_1
    );
  Cpu16_I2_data_is_c_2_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_data_is_c_2_SRINVNOT
    );
  Cpu16_I2_data_is_c_2_CLKINV_706 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_data_is_c_2_CLKINV
    );
  CHOICE1577_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1577_F,
      O => CHOICE1577
    );
  CHOICE1577_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1577_G,
      O => Cpu16_I3_n009675_O
    );
  Cpu16_I2_TC_c_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TC_c_0_F,
      O => Cpu16_ndwe_int
    );
  Cpu16_I2_TC_c_0_DYMUX_707 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TC_c_0_GYMUX,
      O => Cpu16_I2_TC_c_0_DYMUX
    );
  Cpu16_I2_TC_c_0_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TC_c_0_GYMUX,
      O => Cpu16_I2_TC_x(0)
    );
  Cpu16_I2_TC_c_0_GYMUX_708 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TC_c_0_G,
      O => Cpu16_I2_TC_c_0_GYMUX
    );
  Cpu16_I2_TC_c_0_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_TC_c_0_SRINVNOT
    );
  Cpu16_I2_TC_c_0_CLKINV_709 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_TC_c_0_CLKINV
    );
  Cpu16_I1_iaddr_x_9_47 : X_LUT4
    generic map(
      INIT => X"F0E0"
    )
    port map (
      ADR0 => CHOICE387,
      ADR1 => Cpu16_I1_N13702,
      ADR2 => Cpu16_I1_n0010,
      ADR3 => CHOICE392,
      O => Cpu16_I1_pc_9_G
    );
  Cpu16_I1_pc_9_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_9_F,
      O => MADDR(9)
    );
  Cpu16_I1_pc_9_DYMUX_710 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_9_GYMUX,
      O => Cpu16_I1_pc_9_DYMUX
    );
  Cpu16_I1_pc_9_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_9_GYMUX,
      O => Cpu16_I1_iaddr_x_9_47_O
    );
  Cpu16_I1_pc_9_GYMUX_711 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_pc_9_G,
      O => Cpu16_I1_pc_9_GYMUX
    );
  Cpu16_I1_pc_9_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_pc_9_SRINVNOT
    );
  Cpu16_I1_pc_9_CLKINV_712 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I1_pc_9_CLKINV
    );
  Cpu16_I3_Mmux_data_x_Result_0_85 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => CHOICE1538,
      ADR1 => Cpu16_I4_N18018,
      ADR2 => Cpu16_I4_n0202,
      ADR3 => CHOICE1525,
      O => CHOICE712_G
    );
  CHOICE712_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE712_F,
      O => CHOICE712
    );
  CHOICE712_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE712_G,
      O => CHOICE1540
    );
  Cpu16_I3_Mmux_data_x_Result_1_85 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => CHOICE1483,
      ADR1 => Cpu16_I4_n0202,
      ADR2 => CHOICE1470,
      ADR3 => Cpu16_I4_N18018,
      O => CHOICE794_G
    );
  CHOICE794_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE794_F,
      O => CHOICE794
    );
  CHOICE794_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE794_G,
      O => CHOICE1485
    );
  Cpu16_I3_Madd_n0098_inst_lut2_441 : X_LUT4
    generic map(
      INIT => X"1D55"
    )
    port map (
      ADR0 => N31024,
      ADR1 => Cpu16_I4_n0202,
      ADR2 => N31026,
      ADR3 => CHOICE1538,
      O => CHOICE713_G
    );
  CHOICE713_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE713_F,
      O => CHOICE713
    );
  CHOICE713_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE713_G,
      O => Cpu16_I3_Madd_n0098_inst_lut2_44
    );
  Cpu16_I3_Mmux_data_x_Result_2_85 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => CHOICE1415,
      ADR1 => Cpu16_I4_n0202,
      ADR2 => CHOICE1428,
      ADR3 => Cpu16_I4_N18018,
      O => CHOICE825_G
    );
  CHOICE825_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE825_F,
      O => CHOICE825
    );
  CHOICE825_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE825_G,
      O => CHOICE1430
    );
  CHOICE856_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE856_F,
      O => CHOICE856
    );
  CHOICE856_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE856_G,
      O => CHOICE1342
    );
  Cpu16_I3_Mmux_data_x_Result_4_85 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => CHOICE1272,
      ADR1 => Cpu16_I4_n0202,
      ADR2 => CHOICE1285,
      ADR3 => Cpu16_I4_N18018,
      O => CHOICE911_G
    );
  CHOICE911_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE911_F,
      O => CHOICE911
    );
  CHOICE911_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE911_G,
      O => CHOICE1287
    );
  Cpu16_I3_Mmux_data_x_Result_5_85 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => Cpu16_I4_N18018,
      ADR1 => CHOICE1230,
      ADR2 => Cpu16_I4_n0202,
      ADR3 => CHOICE1217,
      O => CHOICE966_G
    );
  CHOICE966_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE966_F,
      O => CHOICE966
    );
  CHOICE966_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE966_G,
      O => CHOICE1232
    );
  Cpu16_I3_Mmux_data_x_Result_10_37 : X_LUT4
    generic map(
      INIT => X"0200"
    )
    port map (
      ADR0 => Cpu16_daddr_is(1),
      ADR1 => Cpu16_daddr_is(0),
      ADR2 => Cpu16_daddr_is(2),
      ADR3 => Cpu16_I4_iinc_c(10),
      O => CHOICE955_G
    );
  CHOICE955_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE955_F,
      O => CHOICE955
    );
  CHOICE955_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE955_G,
      O => Cpu16_I3_Mmux_data_x_Result_10_37_O
    );
  Cpu16_I2_Ker156981_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"CCAA"
    )
    port map (
      ADR0 => Cpu16_skip,
      ADR1 => Cpu16_I2_skip_c,
      ADR2 => VCC,
      ADR3 => Cpu16_I2_E_c_FFd2,
      O => N30430_G
    );
  N30430_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30430_F,
      O => N30430
    );
  N30430_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30430_G,
      O => Cpu16_I2_Ker156981_SW0_SW0_O
    );
  CHOICE1021_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1021_F,
      O => CHOICE1021
    );
  CHOICE1021_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1021_G,
      O => CHOICE1177
    );
  CHOICE900_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE900_F,
      O => CHOICE900
    );
  CHOICE900_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE900_G,
      O => Cpu16_I3_Mmux_data_x_Result_11_37_O
    );
  Cpu16_I3_Mmux_data_x_Result_7_85 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => CHOICE1120,
      ADR1 => CHOICE1107,
      ADR2 => Cpu16_I4_n0202,
      ADR3 => Cpu16_I4_N18018,
      O => CHOICE1076_G
    );
  CHOICE1076_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1076_F,
      O => CHOICE1076
    );
  CHOICE1076_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1076_G,
      O => CHOICE1122
    );
  Cpu16_I2_n00971_SW1 : X_LUT4
    generic map(
      INIT => X"CCD8"
    )
    port map (
      ADR0 => Cpu16_I2_C_raw,
      ADR1 => N30426,
      ADR2 => N30424,
      ADR3 => Cpu16_I2_TC_x(1),
      O => CHOICE687_G
    );
  CHOICE687_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE687_F,
      O => CHOICE687
    );
  CHOICE687_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE687_G,
      O => Cpu16_I2_n00971_SW1_O
    );
  Cpu16_I2_pc_mux_x_1_44_SW0 : X_LUT4
    generic map(
      INIT => X"888D"
    )
    port map (
      ADR0 => Cpu16_I2_TC_x(1),
      ADR1 => Cpu16_I2_N15700,
      ADR2 => N31146,
      ADR3 => N30430,
      O => Cpu16_pc_mux_1_G
    );
  Cpu16_pc_mux_1_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_pc_mux_1_F,
      O => Cpu16_pc_mux(1)
    );
  Cpu16_pc_mux_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_pc_mux_1_G,
      O => N31353
    );
  CHOICE1131_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1131_F,
      O => CHOICE1131
    );
  CHOICE1131_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1131_G,
      O => CHOICE1067
    );
  Cpu16_I3_Mmux_data_x_Result_9_85 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => CHOICE997,
      ADR1 => Cpu16_I4_n0202,
      ADR2 => CHOICE1010,
      ADR3 => Cpu16_I4_N18018,
      O => CHOICE1186_G
    );
  CHOICE1186_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1186_F,
      O => CHOICE1186
    );
  CHOICE1186_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1186_G,
      O => CHOICE1012
    );
  Cpu16_pc_mux_2_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_pc_mux_2_F,
      O => Cpu16_pc_mux(2)
    );
  Cpu16_pc_mux_2_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_pc_mux_2_G,
      O => CHOICE660
    );
  Cpu16_I2_ndre_x1_SW1_SW0_SW0_SW1 : X_LUT4
    generic map(
      INIT => X"E000"
    )
    port map (
      ADR0 => MEM_DATA_OUT(2),
      ADR1 => MEM_DATA_OUT(1),
      ADR2 => Cpu16_I4_nreset_v(1),
      ADR3 => NRESET_IN_BUFGP,
      O => N31234_G
    );
  N31234_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31234_F,
      O => N31234
    );
  N31234_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31234_G,
      O => Cpu16_I2_ndre_x1_SW1_SW0_SW0_SW1_O
    );
  Cpu16_I2_n01451_SW0 : X_LUT4
    generic map(
      INIT => X"55FF"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => Cpu16_I2_nreset_v(1),
      O => N30434_G
    );
  N30434_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30434_F,
      O => N30434
    );
  N30434_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30434_G,
      O => Cpu16_I2_n01451_SW0_O
    );
  N31934_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31934_F,
      O => N31934
    );
  N31934_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31934_G,
      O => N30331
    );
  Cpu16_I2_E_c_FFd1_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_E_c_FFd1_F,
      O => N30426
    );
  Cpu16_I2_E_c_FFd1_DYMUX_713 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_E_c_FFd1_GYMUX,
      O => Cpu16_I2_E_c_FFd1_DYMUX
    );
  Cpu16_I2_E_c_FFd1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_E_c_FFd1_GYMUX,
      O => Cpu16_I2_n0166(2)
    );
  Cpu16_I2_E_c_FFd1_GYMUX_714 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_E_c_FFd1_G,
      O => Cpu16_I2_E_c_FFd1_GYMUX
    );
  Cpu16_I2_E_c_FFd1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_E_c_FFd1_SRINVNOT
    );
  Cpu16_I2_E_c_FFd1_CLKINV_715 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_E_c_FFd1_CLKINV
    );
  Cpu16_I3_acc_i_0_10_DXMUX_716 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_10_FXMUX,
      O => Cpu16_I3_acc_i_0_10_DXMUX
    );
  Cpu16_I3_acc_i_0_10_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_10_FXMUX,
      O => Cpu16_I3_acc(0, 10)
    );
  Cpu16_I3_acc_i_0_10_FXMUX_717 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_10_F,
      O => Cpu16_I3_acc_i_0_10_FXMUX
    );
  Cpu16_I3_acc_i_0_10_DYMUX_718 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc(0, 11),
      O => Cpu16_I3_acc_i_0_10_DYMUX
    );
  Cpu16_I3_acc_i_0_10_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_10_G,
      O => Cpu16_I3_n0147_10_39_SW0_O
    );
  Cpu16_I3_acc_i_0_10_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_10_SRINVNOT
    );
  Cpu16_I3_acc_i_0_10_CLKINV_719 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_10_CLKINV
    );
  Cpu16_I3_acc_i_0_10_CEINV_720 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_start_c,
      O => Cpu16_I3_acc_i_0_10_CEINV
    );
  Cpu16_I3_acc_i_0_12_DXMUX_721 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_12_FXMUX,
      O => Cpu16_I3_acc_i_0_12_DXMUX
    );
  Cpu16_I3_acc_i_0_12_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_12_FXMUX,
      O => Cpu16_I3_acc(0, 12)
    );
  Cpu16_I3_acc_i_0_12_FXMUX_722 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_12_F,
      O => Cpu16_I3_acc_i_0_12_FXMUX
    );
  Cpu16_I3_acc_i_0_12_DYMUX_723 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc(0, 13),
      O => Cpu16_I3_acc_i_0_12_DYMUX
    );
  Cpu16_I3_acc_i_0_12_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_12_G,
      O => Cpu16_I3_n0147_12_39_SW0_O
    );
  Cpu16_I3_acc_i_0_12_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_12_SRINVNOT
    );
  Cpu16_I3_acc_i_0_12_CLKINV_724 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_12_CLKINV
    );
  Cpu16_I3_acc_i_0_12_CEINV_725 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_start_c,
      O => Cpu16_I3_acc_i_0_12_CEINV
    );
  Cpu16_I3_acc_i_0_14_DXMUX_726 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_14_FXMUX,
      O => Cpu16_I3_acc_i_0_14_DXMUX
    );
  Cpu16_I3_acc_i_0_14_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_14_FXMUX,
      O => Cpu16_I3_acc(0, 14)
    );
  Cpu16_I3_acc_i_0_14_FXMUX_727 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_14_F,
      O => Cpu16_I3_acc_i_0_14_FXMUX
    );
  Cpu16_I3_acc_i_0_14_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_14_G,
      O => Cpu16_I3_n0147_14_39_SW0_O
    );
  Cpu16_I3_acc_i_0_14_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_14_SRINVNOT
    );
  Cpu16_I3_acc_i_0_14_CLKINV_728 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_14_CLKINV
    );
  Cpu16_I3_acc_i_0_14_CEINV_729 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_start_c,
      O => Cpu16_I3_acc_i_0_14_CEINV
    );
  Cpu16_I3_n0147_15_39_SW0 : X_LUT4
    generic map(
      INIT => X"DF80"
    )
    port map (
      ADR0 => Cpu16_I3_n0098(15),
      ADR1 => N30301,
      ADR2 => Cpu16_I3_n0083,
      ADR3 => N31944,
      O => Cpu16_I3_acc_i_0_15_G
    );
  Cpu16_I3_acc_i_0_15_DXMUX_730 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_15_FXMUX,
      O => Cpu16_I3_acc_i_0_15_DXMUX
    );
  Cpu16_I3_acc_i_0_15_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_15_FXMUX,
      O => Cpu16_I3_acc(0, 15)
    );
  Cpu16_I3_acc_i_0_15_FXMUX_731 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_15_F,
      O => Cpu16_I3_acc_i_0_15_FXMUX
    );
  Cpu16_I3_acc_i_0_15_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_15_G,
      O => Cpu16_I3_n0147_15_39_SW0_O
    );
  Cpu16_I3_acc_i_0_15_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_15_SRINVNOT
    );
  Cpu16_I3_acc_i_0_15_CLKINV_732 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_15_CLKINV
    );
  Cpu16_I3_acc_i_0_15_CEINV_733 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_start_c_1,
      O => Cpu16_I3_acc_i_0_15_CEINV
    );
  Cpu16_I2_Ker156981 : X_LUT4
    generic map(
      INIT => X"2232"
    )
    port map (
      ADR0 => Cpu16_I2_idata_x(3),
      ADR1 => N30430,
      ADR2 => Cpu16_I2_n0142,
      ADR3 => Cpu16_I2_idata_x(0),
      O => N30405_G
    );
  N30405_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30405_F,
      O => N30405
    );
  N30405_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30405_G,
      O => Cpu16_I2_N15700
    );
  Cpu16_I3_acc_i_0_16_DXMUX_734 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_16_FXMUX,
      O => Cpu16_I3_acc_i_0_16_DXMUX
    );
  Cpu16_I3_acc_i_0_16_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_16_FXMUX,
      O => Cpu16_I3_acc(0, 16)
    );
  Cpu16_I3_acc_i_0_16_FXMUX_735 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_16_F,
      O => Cpu16_I3_acc_i_0_16_FXMUX
    );
  Cpu16_I3_acc_i_0_16_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_i_0_16_G,
      O => Cpu16_I3_n0147_16_13_SW1_O
    );
  Cpu16_I3_acc_i_0_16_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_16_SRINVNOT
    );
  Cpu16_I3_acc_i_0_16_CLKINV_736 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_i_0_16_CLKINV
    );
  Cpu16_I3_acc_i_0_16_CEINV_737 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_start_c_1,
      O => Cpu16_I3_acc_i_0_16_CEINV
    );
  Cpu16_I2_N15561_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_N15561_F,
      O => Cpu16_I2_N15561
    );
  Cpu16_I2_N15561_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_N15561_G,
      O => Cpu16_I2_N15717
    );
  Cpu16_I3_n0147_11_72_SW1 : X_LUT4
    generic map(
      INIT => X"E040"
    )
    port map (
      ADR0 => CHOICE1296,
      ADR1 => N30599,
      ADR2 => Cpu16_I3_n0023,
      ADR3 => N30601,
      O => N31954_G
    );
  N31954_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31954_F,
      O => N31954
    );
  N31954_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31954_G,
      O => N30325
    );
  Cpu16_I2_ndre_x1_SW2_SW0_SW0_SW1 : X_LUT4
    generic map(
      INIT => X"C080"
    )
    port map (
      ADR0 => MEM_DATA_OUT(2),
      ADR1 => Cpu16_I4_nreset_v(1),
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => MEM_DATA_OUT(1),
      O => N31238_G
    );
  N31238_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31238_F,
      O => N31238
    );
  N31238_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31238_G,
      O => Cpu16_I2_ndre_x1_SW2_SW0_SW0_SW1_O
    );
  Cpu16_I3_n0147_12_72_SW1 : X_LUT4
    generic map(
      INIT => X"C088"
    )
    port map (
      ADR0 => N30641,
      ADR1 => Cpu16_I3_n0023,
      ADR2 => N30643,
      ADR3 => CHOICE1351,
      O => N31900_G
    );
  N31900_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31900_F,
      O => N31900
    );
  N31900_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31900_G,
      O => N30319
    );
  Cpu16_I2_ndre_x1_SW13 : X_LUT4
    generic map(
      INIT => X"FDFF"
    )
    port map (
      ADR0 => Cpu16_I2_C_mem_x,
      ADR1 => N30269,
      ADR2 => Cpu16_I2_C_raw,
      ADR3 => CHOICE1562,
      O => Cpu16_I4_N18350_G
    );
  Cpu16_I4_N18350_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18350_F,
      O => Cpu16_I4_N18350
    );
  Cpu16_I4_N18350_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18350_G,
      O => Cpu16_I2_ndre_x1_SW13_O
    );
  N30964_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30964_F,
      O => N30964
    );
  N30964_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30964_G,
      O => Cpu16_I2_N15618
    );
  N31922_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31922_F,
      O => N31922
    );
  N31922_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31922_G,
      O => N30385
    );
  Cpu16_I2_n0103_SW1_SW0 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(0),
      ADR1 => Cpu16_I2_idata_c(3),
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => Cpu16_I2_nreset_v(1),
      O => N30966_G
    );
  N30966_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30966_F,
      O => N30966
    );
  N30966_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30966_G,
      O => Cpu16_I2_n0103_SW1_SW0_O
    );
  Cpu16_I3_n0147_13_72_SW1 : X_LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      ADR0 => Cpu16_I3_n0023,
      ADR1 => N30629,
      ADR2 => CHOICE1439,
      ADR3 => N30631,
      O => N31972_G
    );
  N31972_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31972_F,
      O => N31972
    );
  N31972_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31972_G,
      O => N30313
    );
  Cpu16_I2_ndre_x1_SW3_SW0_SW0_SW1 : X_LUT4
    generic map(
      INIT => X"C800"
    )
    port map (
      ADR0 => MEM_DATA_OUT(2),
      ADR1 => Cpu16_I4_nreset_v(1),
      ADR2 => MEM_DATA_OUT(1),
      ADR3 => NRESET_IN_BUFGP,
      O => N31242_G
    );
  N31242_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31242_F,
      O => N31242
    );
  N31242_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31242_G,
      O => Cpu16_I2_ndre_x1_SW3_SW0_SW0_SW1_O
    );
  Cpu16_I3_n0147_2_72_SW1 : X_LUT4
    generic map(
      INIT => X"D080"
    )
    port map (
      ADR0 => CHOICE825,
      ADR1 => N30649,
      ADR2 => Cpu16_I3_n0023,
      ADR3 => N30647,
      O => N31948_G
    );
  N31948_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31948_F,
      O => N31948
    );
  N31948_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31948_G,
      O => N30379
    );
  N31896_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31896_F,
      O => N31896
    );
  N31896_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31896_G,
      O => N30307
    );
  XLXI_3_daddr_c_3_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_3_F,
      O => CHOICE302
    );
  XLXI_3_daddr_c_3_DYMUX_738 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_3_GYMUX,
      O => XLXI_3_daddr_c_3_DYMUX
    );
  XLXI_3_daddr_c_3_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_3_GYMUX,
      O => CPU_ADADDR_OUT(3)
    );
  XLXI_3_daddr_c_3_GYMUX_739 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_3_G,
      O => XLXI_3_daddr_c_3_GYMUX
    );
  XLXI_3_daddr_c_3_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_3_daddr_c_3_SRINVNOT
    );
  XLXI_3_daddr_c_3_CLKINV_740 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_3_daddr_c_3_CLKINV
    );
  XLXI_3_daddr_c_3_CEINV_741 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_nadwe_c_N1214,
      O => XLXI_3_daddr_c_3_CEINV
    );
  XLXI_3_daddr_c_5_DXMUX_742 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_5_FXMUX,
      O => XLXI_3_daddr_c_5_DXMUX
    );
  XLXI_3_daddr_c_5_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_5_FXMUX,
      O => CPU_ADADDR_OUT(5)
    );
  XLXI_3_daddr_c_5_FXMUX_743 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_5_F,
      O => XLXI_3_daddr_c_5_FXMUX
    );
  XLXI_3_daddr_c_5_DYMUX_744 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_5_GYMUX,
      O => XLXI_3_daddr_c_5_DYMUX
    );
  XLXI_3_daddr_c_5_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_5_GYMUX,
      O => CPU_ADADDR_OUT(4)
    );
  XLXI_3_daddr_c_5_GYMUX_745 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_5_G,
      O => XLXI_3_daddr_c_5_GYMUX
    );
  XLXI_3_daddr_c_5_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_3_daddr_c_5_SRINVNOT
    );
  XLXI_3_daddr_c_5_CLKINV_746 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_3_daddr_c_5_CLKINV
    );
  XLXI_3_daddr_c_5_CEINV_747 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_nadwe_c_N1214,
      O => XLXI_3_daddr_c_5_CEINV
    );
  XLXI_3_daddr_c_7_DXMUX_748 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_7_FXMUX,
      O => XLXI_3_daddr_c_7_DXMUX
    );
  XLXI_3_daddr_c_7_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_7_FXMUX,
      O => CPU_ADADDR_OUT(7)
    );
  XLXI_3_daddr_c_7_FXMUX_749 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_7_F,
      O => XLXI_3_daddr_c_7_FXMUX
    );
  XLXI_3_daddr_c_7_DYMUX_750 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_7_GYMUX,
      O => XLXI_3_daddr_c_7_DYMUX
    );
  XLXI_3_daddr_c_7_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_7_GYMUX,
      O => CPU_ADADDR_OUT(6)
    );
  XLXI_3_daddr_c_7_GYMUX_751 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_7_G,
      O => XLXI_3_daddr_c_7_GYMUX
    );
  XLXI_3_daddr_c_7_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_3_daddr_c_7_SRINVNOT
    );
  XLXI_3_daddr_c_7_CLKINV_752 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_3_daddr_c_7_CLKINV
    );
  XLXI_3_daddr_c_7_CEINV_753 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_nadwe_c_N1214,
      O => XLXI_3_daddr_c_7_CEINV
    );
  XLXI_3_daddr_c_8_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_8_F,
      O => CHOICE1058
    );
  XLXI_3_daddr_c_8_DYMUX_754 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_8_GYMUX,
      O => XLXI_3_daddr_c_8_DYMUX
    );
  XLXI_3_daddr_c_8_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_8_GYMUX,
      O => CPU_ADADDR_OUT(8)
    );
  XLXI_3_daddr_c_8_GYMUX_755 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_8_G,
      O => XLXI_3_daddr_c_8_GYMUX
    );
  XLXI_3_daddr_c_8_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_3_daddr_c_8_SRINVNOT
    );
  XLXI_3_daddr_c_8_CLKINV_756 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_3_daddr_c_8_CLKINV
    );
  XLXI_3_daddr_c_8_CEINV_757 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_nadwe_c_N1214,
      O => XLXI_3_daddr_c_8_CEINV
    );
  Cpu16_I3_n0147_3_72_SW1 : X_LUT4
    generic map(
      INIT => X"B080"
    )
    port map (
      ADR0 => N30667,
      ADR1 => CHOICE856,
      ADR2 => Cpu16_I3_n0023,
      ADR3 => N30665,
      O => N31984_G
    );
  N31984_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31984_F,
      O => N31984
    );
  N31984_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31984_G,
      O => N30373
    );
  N31944_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31944_F,
      O => N31944
    );
  N31944_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31944_G,
      O => N30301
    );
  Cpu16_I2_ndre_x1_SW4_SW0_SW0_SW1 : X_LUT4
    generic map(
      INIT => X"A800"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => MEM_DATA_OUT(2),
      ADR2 => MEM_DATA_OUT(1),
      ADR3 => Cpu16_I4_nreset_v(1),
      O => N31271_G
    );
  N31271_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31271_F,
      O => N31271
    );
  N31271_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31271_G,
      O => Cpu16_I2_ndre_x1_SW4_SW0_SW0_SW1_O
    );
  Cpu16_I3_n0147_4_72_SW1 : X_LUT4
    generic map(
      INIT => X"D800"
    )
    port map (
      ADR0 => CHOICE911,
      ADR1 => N30655,
      ADR2 => N30653,
      ADR3 => Cpu16_I3_n0023,
      O => N31904_G
    );
  N31904_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31904_F,
      O => N31904
    );
  N31904_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31904_G,
      O => N30367
    );
  Cpu16_I4_data_exp_c_1_DXMUX_758 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0160(1),
      O => Cpu16_I4_data_exp_c_1_DXMUX
    );
  Cpu16_I4_data_exp_c_1_DYMUX_759 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0160(0),
      O => Cpu16_I4_data_exp_c_1_DYMUX
    );
  Cpu16_I4_data_exp_c_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_data_exp_c_1_SRINVNOT
    );
  Cpu16_I4_data_exp_c_1_CLKINV_760 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_data_exp_c_1_CLKINV
    );
  Cpu16_I4_data_exp_c_1_CEINV_761 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0216,
      O => Cpu16_I4_data_exp_c_1_CEINV
    );
  Cpu16_I4_data_exp_c_3_DXMUX_762 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0160(3),
      O => Cpu16_I4_data_exp_c_3_DXMUX
    );
  Cpu16_I4_data_exp_c_3_DYMUX_763 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0160(2),
      O => Cpu16_I4_data_exp_c_3_DYMUX
    );
  Cpu16_I4_data_exp_c_3_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_data_exp_c_3_SRINVNOT
    );
  Cpu16_I4_data_exp_c_3_CLKINV_764 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_data_exp_c_3_CLKINV
    );
  Cpu16_I4_data_exp_c_3_CEINV_765 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0216,
      O => Cpu16_I4_data_exp_c_3_CEINV
    );
  Cpu16_I4_data_exp_c_5_DXMUX_766 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0160(5),
      O => Cpu16_I4_data_exp_c_5_DXMUX
    );
  Cpu16_I4_data_exp_c_5_DYMUX_767 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0160(4),
      O => Cpu16_I4_data_exp_c_5_DYMUX
    );
  Cpu16_I4_data_exp_c_5_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_data_exp_c_5_SRINVNOT
    );
  Cpu16_I4_data_exp_c_5_CLKINV_768 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_data_exp_c_5_CLKINV
    );
  Cpu16_I4_data_exp_c_5_CEINV_769 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0216,
      O => Cpu16_I4_data_exp_c_5_CEINV
    );
  Cpu16_I4_data_exp_c_7_DXMUX_770 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0160(7),
      O => Cpu16_I4_data_exp_c_7_DXMUX
    );
  Cpu16_I4_data_exp_c_7_DYMUX_771 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0160(6),
      O => Cpu16_I4_data_exp_c_7_DYMUX
    );
  Cpu16_I4_data_exp_c_7_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_data_exp_c_7_SRINVNOT
    );
  Cpu16_I4_data_exp_c_7_CLKINV_772 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_data_exp_c_7_CLKINV
    );
  Cpu16_I4_data_exp_c_7_CEINV_773 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0216,
      O => Cpu16_I4_data_exp_c_7_CEINV
    );
  Cpu16_I4_n0160_8_1 : X_LUT4
    generic map(
      INIT => X"F088"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_8,
      ADR1 => Cpu16_I4_dexp_we_c,
      ADR2 => Cpu16_I4_data_exp_i(8),
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I4_n0160(8)
    );
  Cpu16_I4_data_exp_c_9_DXMUX_774 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0160(9),
      O => Cpu16_I4_data_exp_c_9_DXMUX
    );
  Cpu16_I4_data_exp_c_9_DYMUX_775 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0160(8),
      O => Cpu16_I4_data_exp_c_9_DYMUX
    );
  Cpu16_I4_data_exp_c_9_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_data_exp_c_9_SRINVNOT
    );
  Cpu16_I4_data_exp_c_9_CLKINV_776 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_data_exp_c_9_CLKINV
    );
  Cpu16_I4_data_exp_c_9_CEINV_777 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0216,
      O => Cpu16_I4_data_exp_c_9_CEINV
    );
  Cpu16_I4_data_exp_i_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_data_exp_i_0_F,
      O => N30281
    );
  Cpu16_I4_data_exp_i_0_DYMUX_778 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_data_exp_i_0_GYMUX,
      O => Cpu16_I4_data_exp_i_0_DYMUX
    );
  Cpu16_I4_data_exp_i_0_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_data_exp_i_0_GYMUX,
      O => Cpu16_data_is_int(12)
    );
  Cpu16_I4_data_exp_i_0_GYMUX_779 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_data_exp_i_0_G,
      O => Cpu16_I4_data_exp_i_0_GYMUX
    );
  Cpu16_I4_data_exp_i_0_CLKINV_780 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_data_exp_i_0_CLKINV
    );
  Cpu16_I4_data_exp_i_0_CEINV_781 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_data_exp_i_0_CEINV
    );
  Cpu16_I4_data_exp_i_1_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_data_exp_i_1_F,
      O => N30287
    );
  Cpu16_I4_data_exp_i_1_DYMUX_782 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_data_exp_i_1_GYMUX,
      O => Cpu16_I4_data_exp_i_1_DYMUX
    );
  Cpu16_I4_data_exp_i_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_data_exp_i_1_GYMUX,
      O => Cpu16_data_is_int(13)
    );
  Cpu16_I4_data_exp_i_1_GYMUX_783 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_data_exp_i_1_G,
      O => Cpu16_I4_data_exp_i_1_GYMUX
    );
  Cpu16_I4_data_exp_i_1_CLKINV_784 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_data_exp_i_1_CLKINV
    );
  Cpu16_I4_data_exp_i_1_CEINV_785 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_data_exp_i_1_CEINV
    );
  Cpu16_I4_data_exp_i_3_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_data_exp_i_3_F,
      O => CHOICE851
    );
  Cpu16_I4_data_exp_i_3_DYMUX_786 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_data_exp_i_3_GYMUX,
      O => Cpu16_I4_data_exp_i_3_DYMUX
    );
  Cpu16_I4_data_exp_i_3_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_data_exp_i_3_GYMUX,
      O => Cpu16_data_is_int(15)
    );
  Cpu16_I4_data_exp_i_3_GYMUX_787 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_data_exp_i_3_G,
      O => Cpu16_I4_data_exp_i_3_GYMUX
    );
  Cpu16_I4_data_exp_i_3_CLKINV_788 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_data_exp_i_3_CLKINV
    );
  Cpu16_I4_data_exp_i_3_CEINV_789 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_data_exp_i_3_CEINV
    );
  Cpu16_I4_data_exp_i_5_DXMUX_790 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iadata_x(17),
      O => Cpu16_I4_data_exp_i_5_DXMUX
    );
  Cpu16_I4_data_exp_i_5_DYMUX_791 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iadata_x(16),
      O => Cpu16_I4_data_exp_i_5_DYMUX
    );
  Cpu16_I4_data_exp_i_5_CLKINV_792 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_data_exp_i_5_CLKINV
    );
  Cpu16_I4_data_exp_i_5_CEINV_793 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_data_exp_i_5_CEINV
    );
  Cpu16_I4_data_exp_i_7_DXMUX_794 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iadata_x(19),
      O => Cpu16_I4_data_exp_i_7_DXMUX
    );
  Cpu16_I4_data_exp_i_7_DYMUX_795 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iadata_x(18),
      O => Cpu16_I4_data_exp_i_7_DYMUX
    );
  Cpu16_I4_data_exp_i_7_CLKINV_796 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_data_exp_i_7_CLKINV
    );
  Cpu16_I4_data_exp_i_7_CEINV_797 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_data_exp_i_7_CEINV
    );
  Cpu16_I4_data_exp_i_9_DXMUX_798 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iadata_x(21),
      O => Cpu16_I4_data_exp_i_9_DXMUX
    );
  Cpu16_I4_data_exp_i_9_DYMUX_799 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iadata_x(20),
      O => Cpu16_I4_data_exp_i_9_DYMUX
    );
  Cpu16_I4_data_exp_i_9_CLKINV_800 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_data_exp_i_9_CLKINV
    );
  Cpu16_I4_data_exp_i_9_CEINV_801 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_data_exp_i_9_CEINV
    );
  Cpu16_I4_ireg_we_c_DXMUX_802 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_ireg_we_x,
      O => Cpu16_I4_ireg_we_c_DXMUX
    );
  Cpu16_I4_ireg_we_c_DYMUX_803 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_dexp_we_x,
      O => Cpu16_I4_ireg_we_c_DYMUX
    );
  Cpu16_I4_ireg_we_c_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_ireg_we_c_SRINVNOT
    );
  Cpu16_I4_ireg_we_c_CLKINV_804 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_ireg_we_c_CLKINV
    );
  Cpu16_I4_data_exp_c_11_DXMUX_805 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0160(11),
      O => Cpu16_I4_data_exp_c_11_DXMUX
    );
  Cpu16_I4_data_exp_c_11_DYMUX_806 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0160(10),
      O => Cpu16_I4_data_exp_c_11_DYMUX
    );
  Cpu16_I4_data_exp_c_11_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_data_exp_c_11_SRINVNOT
    );
  Cpu16_I4_data_exp_c_11_CLKINV_807 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_data_exp_c_11_CLKINV
    );
  Cpu16_I4_data_exp_c_11_CEINV_808 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0216,
      O => Cpu16_I4_data_exp_c_11_CEINV
    );
  Cpu16_I4_data_exp_i_11_DXMUX_809 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iadata_x(23),
      O => Cpu16_I4_data_exp_i_11_DXMUX
    );
  Cpu16_I4_data_exp_i_11_DYMUX_810 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iadata_x(22),
      O => Cpu16_I4_data_exp_i_11_DYMUX
    );
  Cpu16_I4_data_exp_i_11_CLKINV_811 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_data_exp_i_11_CLKINV
    );
  Cpu16_I4_data_exp_i_11_CEINV_812 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_data_exp_i_11_CEINV
    );
  Cpu16_I2_data_is_c_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_0_F,
      O => CHOICE345
    );
  Cpu16_I2_data_is_c_0_DYMUX_813 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_0_GYMUX,
      O => Cpu16_I2_data_is_c_0_DYMUX
    );
  Cpu16_I2_data_is_c_0_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_0_GYMUX,
      O => Cpu16_I2_Mmux_idata_x_Result_4_1_1
    );
  Cpu16_I2_data_is_c_0_GYMUX_814 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_0_G,
      O => Cpu16_I2_data_is_c_0_GYMUX
    );
  Cpu16_I2_data_is_c_0_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_data_is_c_0_SRINVNOT
    );
  Cpu16_I2_data_is_c_0_CLKINV_815 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_data_is_c_0_CLKINV
    );
  Cpu16_I2_data_is_c_3_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_3_F,
      O => CHOICE321
    );
  Cpu16_I2_data_is_c_3_DYMUX_816 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_3_GYMUX,
      O => Cpu16_I2_data_is_c_3_DYMUX
    );
  Cpu16_I2_data_is_c_3_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_3_GYMUX,
      O => Cpu16_daddr_is(3)
    );
  Cpu16_I2_data_is_c_3_GYMUX_817 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_3_G,
      O => Cpu16_I2_data_is_c_3_GYMUX
    );
  Cpu16_I2_data_is_c_3_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_data_is_c_3_SRINVNOT
    );
  Cpu16_I2_data_is_c_3_CLKINV_818 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_data_is_c_3_CLKINV
    );
  Cpu16_I2_data_is_c_5_DXMUX_819 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_5_FXMUX,
      O => Cpu16_I2_data_is_c_5_DXMUX
    );
  Cpu16_I2_data_is_c_5_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_5_FXMUX,
      O => Cpu16_daddr_is(5)
    );
  Cpu16_I2_data_is_c_5_FXMUX_820 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_5_F,
      O => Cpu16_I2_data_is_c_5_FXMUX
    );
  Cpu16_I2_data_is_c_5_DYMUX_821 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_5_GYMUX,
      O => Cpu16_I2_data_is_c_5_DYMUX
    );
  Cpu16_I2_data_is_c_5_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_5_GYMUX,
      O => Cpu16_daddr_is(4)
    );
  Cpu16_I2_data_is_c_5_GYMUX_822 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_5_G,
      O => Cpu16_I2_data_is_c_5_GYMUX
    );
  Cpu16_I2_data_is_c_5_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_data_is_c_5_SRINVNOT
    );
  Cpu16_I2_data_is_c_5_CLKINV_823 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_data_is_c_5_CLKINV
    );
  Cpu16_I2_data_is_c_7_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_data_is_c_7_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_data_is_c_7_FFX_RST
    );
  Cpu16_I2_data_is_c_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_data_is_c_7_DXMUX,
      CE => VCC,
      CLK => Cpu16_I2_data_is_c_7_CLKINV,
      SET => GND,
      RST => Cpu16_I2_data_is_c_7_FFX_RST,
      O => Cpu16_I2_data_is_c(7)
    );
  Cpu16_I2_Mmux_idata_x_Result_11_1 : X_LUT4
    generic map(
      INIT => X"FC30"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_n01501_1,
      ADR2 => Cpu16_I2_idata_c(11),
      ADR3 => MEM_DATA_OUT(11),
      O => Cpu16_I2_data_is_c_7_F
    );
  Cpu16_I2_data_is_c_7_DXMUX_824 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_7_FXMUX,
      O => Cpu16_I2_data_is_c_7_DXMUX
    );
  Cpu16_I2_data_is_c_7_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_7_FXMUX,
      O => Cpu16_daddr_is(7)
    );
  Cpu16_I2_data_is_c_7_FXMUX_825 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_7_F,
      O => Cpu16_I2_data_is_c_7_FXMUX
    );
  Cpu16_I2_data_is_c_7_DYMUX_826 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_7_GYMUX,
      O => Cpu16_I2_data_is_c_7_DYMUX
    );
  Cpu16_I2_data_is_c_7_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_7_GYMUX,
      O => Cpu16_daddr_is(6)
    );
  Cpu16_I2_data_is_c_7_GYMUX_827 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_7_G,
      O => Cpu16_I2_data_is_c_7_GYMUX
    );
  Cpu16_I2_data_is_c_7_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_data_is_c_7_SRINVNOT
    );
  Cpu16_I2_data_is_c_7_CLKINV_828 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_data_is_c_7_CLKINV
    );
  Cpu16_I2_data_is_c_9_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_data_is_c_9_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_data_is_c_9_FFX_RST
    );
  Cpu16_I2_data_is_c_9 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_data_is_c_9_DXMUX,
      CE => VCC,
      CLK => Cpu16_I2_data_is_c_9_CLKINV,
      SET => GND,
      RST => Cpu16_I2_data_is_c_9_FFX_RST,
      O => Cpu16_I2_data_is_c(9)
    );
  Cpu16_I2_Mmux_idata_x_Result_13_1 : X_LUT4
    generic map(
      INIT => X"AACC"
    )
    port map (
      ADR0 => MEM_DATA_OUT(13),
      ADR1 => Cpu16_I2_idata_c(13),
      ADR2 => VCC,
      ADR3 => Cpu16_I2_n01501_1,
      O => Cpu16_I2_data_is_c_9_F
    );
  Cpu16_I2_data_is_c_9_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_data_is_c_9_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_data_is_c_9_FFY_RST
    );
  Cpu16_I2_data_is_c_8 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_data_is_c_9_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_data_is_c_9_CLKINV,
      SET => GND,
      RST => Cpu16_I2_data_is_c_9_FFY_RST,
      O => Cpu16_I2_data_is_c(8)
    );
  Cpu16_I2_data_is_c_9_DXMUX_829 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_9_FXMUX,
      O => Cpu16_I2_data_is_c_9_DXMUX
    );
  Cpu16_I2_data_is_c_9_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_9_FXMUX,
      O => Cpu16_daddr_is(9)
    );
  Cpu16_I2_data_is_c_9_FXMUX_830 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_9_F,
      O => Cpu16_I2_data_is_c_9_FXMUX
    );
  Cpu16_I2_data_is_c_9_DYMUX_831 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_9_GYMUX,
      O => Cpu16_I2_data_is_c_9_DYMUX
    );
  Cpu16_I2_data_is_c_9_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_9_GYMUX,
      O => Cpu16_daddr_is(8)
    );
  Cpu16_I2_data_is_c_9_GYMUX_832 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_data_is_c_9_G,
      O => Cpu16_I2_data_is_c_9_GYMUX
    );
  Cpu16_I2_data_is_c_9_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_data_is_c_9_SRINVNOT
    );
  Cpu16_I2_data_is_c_9_CLKINV_833 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_data_is_c_9_CLKINV
    );
  Cpu16_I2_int_start_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_int_start_c_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_int_start_c_1_FFX_RST
    );
  Cpu16_I2_int_start_c_1_834 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_int_start_c_1_DXMUX,
      CE => VCC,
      CLK => Cpu16_I2_int_start_c_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_int_start_c_1_FFX_RST,
      O => Cpu16_I2_int_start_c_1
    );
  Cpu16_I2_int_start_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_int_start_c_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_int_start_c_1_FFY_RST
    );
  Cpu16_I2_int_start_c_835 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_int_start_c_1_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_int_start_c_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_int_start_c_1_FFY_RST,
      O => Cpu16_I2_int_start_c
    );
  Cpu16_I2_n00751 : X_LUT4
    generic map(
      INIT => X"CC80"
    )
    port map (
      ADR0 => Cpu16_I2_int_start_c,
      ADR1 => Cpu16_I2_nreset_v_1_1,
      ADR2 => Cpu16_I2_n0062,
      ADR3 => Cpu16_I2_n0166(2),
      O => Cpu16_I2_int_start_c_1_G
    );
  Cpu16_I2_int_start_c_1_DXMUX_836 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n0075,
      O => Cpu16_I2_int_start_c_1_DXMUX
    );
  Cpu16_I2_int_start_c_1_DYMUX_837 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_start_c_1_GYMUX,
      O => Cpu16_I2_int_start_c_1_DYMUX
    );
  Cpu16_I2_int_start_c_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_start_c_1_GYMUX,
      O => Cpu16_I2_n0075
    );
  Cpu16_I2_int_start_c_1_GYMUX_838 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_start_c_1_G,
      O => Cpu16_I2_int_start_c_1_GYMUX
    );
  Cpu16_I2_int_start_c_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_int_start_c_1_SRINVNOT
    );
  Cpu16_I2_int_start_c_1_CLKINV_839 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_int_start_c_1_CLKINV
    );
  Cpu16_I1_Mmux_n0008_Result_0_1 : X_LUT4
    generic map(
      INIT => X"CCF0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => MEM_DATA_OUT(4),
      ADR2 => Cpu16_I1_eaddr_x(0),
      ADR3 => Cpu16_I1_n00201_1,
      O => Cpu16_I1_n0008(0)
    );
  Cpu16_I1_eaddr_x_1_DXMUX_840 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0008(1),
      O => Cpu16_I1_eaddr_x_1_DXMUX
    );
  Cpu16_I1_eaddr_x_1_DYMUX_841 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0008(0),
      O => Cpu16_I1_eaddr_x_1_DYMUX
    );
  Cpu16_I1_eaddr_x_1_CLKINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_eaddr_x_1_CLKINVNOT
    );
  Cpu16_I1_eaddr_x_1_CEINV_842 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_nreset_v(1),
      O => Cpu16_I1_eaddr_x_1_CEINV
    );
  Cpu16_I1_eaddr_x_3_DXMUX_843 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0008(3),
      O => Cpu16_I1_eaddr_x_3_DXMUX
    );
  Cpu16_I1_eaddr_x_3_DYMUX_844 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0008(2),
      O => Cpu16_I1_eaddr_x_3_DYMUX
    );
  Cpu16_I1_eaddr_x_3_CLKINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_eaddr_x_3_CLKINVNOT
    );
  Cpu16_I1_eaddr_x_3_CEINV_845 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_nreset_v(1),
      O => Cpu16_I1_eaddr_x_3_CEINV
    );
  Cpu16_I1_eaddr_x_5_DXMUX_846 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0008(5),
      O => Cpu16_I1_eaddr_x_5_DXMUX
    );
  Cpu16_I1_eaddr_x_5_DYMUX_847 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0008(4),
      O => Cpu16_I1_eaddr_x_5_DYMUX
    );
  Cpu16_I1_eaddr_x_5_CLKINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_eaddr_x_5_CLKINVNOT
    );
  Cpu16_I1_eaddr_x_5_CEINV_848 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_nreset_v(1),
      O => Cpu16_I1_eaddr_x_5_CEINV
    );
  Cpu16_I1_eaddr_x_7_DXMUX_849 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0008(7),
      O => Cpu16_I1_eaddr_x_7_DXMUX
    );
  Cpu16_I1_eaddr_x_7_DYMUX_850 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0008(6),
      O => Cpu16_I1_eaddr_x_7_DYMUX
    );
  Cpu16_I1_eaddr_x_7_CLKINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_eaddr_x_7_CLKINVNOT
    );
  Cpu16_I1_eaddr_x_7_CEINV_851 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_nreset_v(1),
      O => Cpu16_I1_eaddr_x_7_CEINV
    );
  Cpu16_I1_eaddr_x_9_DXMUX_852 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0008(9),
      O => Cpu16_I1_eaddr_x_9_DXMUX
    );
  Cpu16_I1_eaddr_x_9_DYMUX_853 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0008(8),
      O => Cpu16_I1_eaddr_x_9_DYMUX
    );
  Cpu16_I1_eaddr_x_9_CLKINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_eaddr_x_9_CLKINVNOT
    );
  Cpu16_I1_eaddr_x_9_CEINV_854 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_nreset_v(1),
      O => Cpu16_I1_eaddr_x_9_CEINV
    );
  Cpu16_I1_nreset_v_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_nreset_v_0_F,
      O => XLXI_4_n00021_SW3_O
    );
  Cpu16_I1_nreset_v_0_DYMUX_855 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0006(0),
      O => Cpu16_I1_nreset_v_0_DYMUX
    );
  Cpu16_I1_nreset_v_0_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_nreset_v_0_SRINVNOT
    );
  Cpu16_I1_nreset_v_0_CLKINV_856 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I1_nreset_v_0_CLKINV
    );
  Cpu16_I2_nreset_v_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_nreset_v_0_F,
      O => Cpu16_I2_n0151
    );
  Cpu16_I2_nreset_v_0_DYMUX_857 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n0076(0),
      O => Cpu16_I2_nreset_v_0_DYMUX
    );
  Cpu16_I2_nreset_v_0_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_nreset_v_0_SRINVNOT
    );
  Cpu16_I2_nreset_v_0_CLKINV_858 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_nreset_v_0_CLKINV
    );
  Cpu16_I4_iinc_c_11_DXMUX_859 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0159(11),
      O => Cpu16_I4_iinc_c_11_DXMUX
    );
  Cpu16_I4_iinc_c_11_DYMUX_860 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0159(10),
      O => Cpu16_I4_iinc_c_11_DYMUX
    );
  Cpu16_I4_iinc_c_11_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_iinc_c_11_SRINVNOT
    );
  Cpu16_I4_iinc_c_11_CLKINV_861 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_iinc_c_11_CLKINV
    );
  Cpu16_I4_iinc_c_11_CEINV_862 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0215,
      O => Cpu16_I4_iinc_c_11_CEINV
    );
  Cpu16_I3_nreset_v_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_nreset_v_0_F,
      O => CHOICE1408
    );
  Cpu16_I3_nreset_v_0_DYMUX_863 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0022(0),
      O => Cpu16_I3_nreset_v_0_DYMUX
    );
  Cpu16_I3_nreset_v_0_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_nreset_v_0_SRINVNOT
    );
  Cpu16_I3_nreset_v_0_CLKINV_864 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_nreset_v_0_CLKINV
    );
  Cpu16_I4_nreset_v_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_nreset_v_0_F,
      O => DATA_OUT_EXT_1_OBUF
    );
  Cpu16_I4_nreset_v_0_DYMUX_865 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0161(0),
      O => Cpu16_I4_nreset_v_0_DYMUX
    );
  Cpu16_I4_nreset_v_0_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_nreset_v_0_SRINVNOT
    );
  Cpu16_I4_nreset_v_0_CLKINV_866 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_nreset_v_0_CLKINV
    );
  Cpu16_I4_iinc_i_11_DXMUX_867 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_x(11),
      O => Cpu16_I4_iinc_i_11_DXMUX
    );
  Cpu16_I4_iinc_i_11_DYMUX_868 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_x(10),
      O => Cpu16_I4_iinc_i_11_DYMUX
    );
  Cpu16_I4_iinc_i_11_CLKINV_869 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_iinc_i_11_CLKINV
    );
  Cpu16_I4_iinc_i_11_CEINV_870 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_iinc_i_11_CEINV
    );
  Cpu16_I2_data_is_c_11_DXMUX_871 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_daddr_is(11),
      O => Cpu16_I2_data_is_c_11_DXMUX
    );
  Cpu16_I2_data_is_c_11_DYMUX_872 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_daddr_is(10),
      O => Cpu16_I2_data_is_c_11_DYMUX
    );
  Cpu16_I2_data_is_c_11_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_data_is_c_11_SRINVNOT
    );
  Cpu16_I2_data_is_c_11_CLKINV_873 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_data_is_c_11_CLKINV
    );
  Cpu16_I1_eaddr_x_10_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_eaddr_x_10_F,
      O => N24783
    );
  Cpu16_I1_eaddr_x_10_DYMUX_874 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0008(10),
      O => Cpu16_I1_eaddr_x_10_DYMUX
    );
  Cpu16_I1_eaddr_x_10_CLKINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_eaddr_x_10_CLKINVNOT
    );
  Cpu16_I1_eaddr_x_10_CEINV_875 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_nreset_v(1),
      O => Cpu16_I1_eaddr_x_10_CEINV
    );
  Cpu16_I2_TC_c_2_1_DXMUX_876 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TC_x(2),
      O => Cpu16_I2_TC_c_2_1_DXMUX
    );
  Cpu16_I2_TC_c_2_1_DYMUX_877 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TC_c_2_1_GYMUX,
      O => Cpu16_I2_TC_c_2_1_DYMUX
    );
  Cpu16_I2_TC_c_2_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TC_c_2_1_GYMUX,
      O => Cpu16_I2_TC_x(2)
    );
  Cpu16_I2_TC_c_2_1_GYMUX_878 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TC_c_2_1_G,
      O => Cpu16_I2_TC_c_2_1_GYMUX
    );
  Cpu16_I2_TC_c_2_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_TC_c_2_1_SRINVNOT
    );
  Cpu16_I2_TC_c_2_1_CLKINV_879 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_TC_c_2_1_CLKINV
    );
  Cpu16_I4_iinc_c_1_DXMUX_880 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0159(1),
      O => Cpu16_I4_iinc_c_1_DXMUX
    );
  Cpu16_I4_iinc_c_1_DYMUX_881 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0159(0),
      O => Cpu16_I4_iinc_c_1_DYMUX
    );
  Cpu16_I4_iinc_c_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_iinc_c_1_SRINVNOT
    );
  Cpu16_I4_iinc_c_1_CLKINV_882 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_iinc_c_1_CLKINV
    );
  Cpu16_I4_iinc_c_1_CEINV_883 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0215,
      O => Cpu16_I4_iinc_c_1_CEINV
    );
  Cpu16_I4_iinc_c_3_DXMUX_884 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0159(3),
      O => Cpu16_I4_iinc_c_3_DXMUX
    );
  Cpu16_I4_iinc_c_3_DYMUX_885 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0159(2),
      O => Cpu16_I4_iinc_c_3_DYMUX
    );
  Cpu16_I4_iinc_c_3_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_iinc_c_3_SRINVNOT
    );
  Cpu16_I4_iinc_c_3_CLKINV_886 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_iinc_c_3_CLKINV
    );
  Cpu16_I4_iinc_c_3_CEINV_887 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0215,
      O => Cpu16_I4_iinc_c_3_CEINV
    );
  Cpu16_I4_iinc_c_5_DXMUX_888 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0159(5),
      O => Cpu16_I4_iinc_c_5_DXMUX
    );
  Cpu16_I4_iinc_c_5_DYMUX_889 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0159(4),
      O => Cpu16_I4_iinc_c_5_DYMUX
    );
  Cpu16_I4_iinc_c_5_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_iinc_c_5_SRINVNOT
    );
  Cpu16_I4_iinc_c_5_CLKINV_890 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_iinc_c_5_CLKINV
    );
  Cpu16_I4_iinc_c_5_CEINV_891 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0215,
      O => Cpu16_I4_iinc_c_5_CEINV
    );
  Cpu16_I4_iinc_c_7_DXMUX_892 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0159(7),
      O => Cpu16_I4_iinc_c_7_DXMUX
    );
  Cpu16_I4_iinc_c_7_DYMUX_893 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0159(6),
      O => Cpu16_I4_iinc_c_7_DYMUX
    );
  Cpu16_I4_iinc_c_7_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_iinc_c_7_SRINVNOT
    );
  Cpu16_I4_iinc_c_7_CLKINV_894 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_iinc_c_7_CLKINV
    );
  Cpu16_I4_iinc_c_7_CEINV_895 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0215,
      O => Cpu16_I4_iinc_c_7_CEINV
    );
  Cpu16_I4_iinc_c_9_DXMUX_896 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0159(9),
      O => Cpu16_I4_iinc_c_9_DXMUX
    );
  Cpu16_I4_iinc_c_9_DYMUX_897 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0159(8),
      O => Cpu16_I4_iinc_c_9_DYMUX
    );
  Cpu16_I4_iinc_c_9_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_iinc_c_9_SRINVNOT
    );
  Cpu16_I4_iinc_c_9_CLKINV_898 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_iinc_c_9_CLKINV
    );
  Cpu16_I4_iinc_c_9_CEINV_899 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0215,
      O => Cpu16_I4_iinc_c_9_CEINV
    );
  Cpu16_I4_iinc_i_1_DXMUX_900 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_x(1),
      O => Cpu16_I4_iinc_i_1_DXMUX
    );
  Cpu16_I4_iinc_i_1_DYMUX_901 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_x(0),
      O => Cpu16_I4_iinc_i_1_DYMUX
    );
  Cpu16_I4_iinc_i_1_CLKINV_902 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_iinc_i_1_CLKINV
    );
  Cpu16_I4_iinc_i_1_CEINV_903 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_iinc_i_1_CEINV
    );
  Cpu16_I4_iinc_i_2_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_i_2_F,
      O => CHOICE820
    );
  Cpu16_I4_iinc_i_2_DYMUX_904 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_x(2),
      O => Cpu16_I4_iinc_i_2_DYMUX
    );
  Cpu16_I4_iinc_i_2_CLKINV_905 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_iinc_i_2_CLKINV
    );
  Cpu16_I4_iinc_i_2_CEINV_906 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_iinc_i_2_CEINV
    );
  Cpu16_I4_iinc_i_5_DXMUX_907 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_x(5),
      O => Cpu16_I4_iinc_i_5_DXMUX
    );
  Cpu16_I4_iinc_i_5_DYMUX_908 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_x(4),
      O => Cpu16_I4_iinc_i_5_DYMUX
    );
  Cpu16_I4_iinc_i_5_CLKINV_909 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_iinc_i_5_CLKINV
    );
  Cpu16_I4_iinc_i_5_CEINV_910 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_iinc_i_5_CEINV
    );
  Cpu16_I4_iinc_i_7_DXMUX_911 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_x(7),
      O => Cpu16_I4_iinc_i_7_DXMUX
    );
  Cpu16_I4_iinc_i_7_DYMUX_912 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_x(6),
      O => Cpu16_I4_iinc_i_7_DYMUX
    );
  Cpu16_I4_iinc_i_7_CLKINV_913 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_iinc_i_7_CLKINV
    );
  Cpu16_I4_iinc_i_7_CEINV_914 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_iinc_i_7_CEINV
    );
  Cpu16_I4_iinc_i_9_DXMUX_915 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_x(9),
      O => Cpu16_I4_iinc_i_9_DXMUX
    );
  Cpu16_I4_iinc_i_9_DYMUX_916 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_x(8),
      O => Cpu16_I4_iinc_i_9_DYMUX
    );
  Cpu16_I4_iinc_i_9_CLKINV_917 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_iinc_i_9_CLKINV
    );
  Cpu16_I4_iinc_i_9_CEINV_918 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_iinc_i_9_CEINV
    );
  Cpu16_I2_E_c_FFd2_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_E_c_FFd2_F,
      O => CHOICE47
    );
  Cpu16_I2_E_c_FFd2_DYMUX_919 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_E_c_FFd2_GYMUX,
      O => Cpu16_I2_E_c_FFd2_DYMUX
    );
  Cpu16_I2_E_c_FFd2_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_E_c_FFd2_GYMUX,
      O => Cpu16_I2_n0063
    );
  Cpu16_I2_E_c_FFd2_GYMUX_920 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_E_c_FFd2_G,
      O => Cpu16_I2_E_c_FFd2_GYMUX
    );
  Cpu16_I2_E_c_FFd2_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_E_c_FFd2_SRINVNOT
    );
  Cpu16_I2_E_c_FFd2_CLKINV_921 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_E_c_FFd2_CLKINV
    );
  Cpu16_I2_E_c_FFd4_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_E_c_FFd4_F,
      O => CHOICE606
    );
  Cpu16_I2_E_c_FFd4_DYMUX_922 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_E_c_FFd4_In,
      O => Cpu16_I2_E_c_FFd4_DYMUX
    );
  Cpu16_I2_E_c_FFd4_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_E_c_FFd4_SRINVNOT
    );
  Cpu16_I2_E_c_FFd4_CLKINV_923 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_E_c_FFd4_CLKINV
    );
  Cpu16_I4_iinc_we_c_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_we_c_F,
      O => Cpu16_I4_n0203
    );
  Cpu16_I4_iinc_we_c_DYMUX_924 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_we_x,
      O => Cpu16_I4_iinc_we_c_DYMUX
    );
  Cpu16_I4_iinc_we_c_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_iinc_we_c_SRINVNOT
    );
  Cpu16_I4_iinc_we_c_CLKINV_925 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_iinc_we_c_CLKINV
    );
  Cpu16_I2_TC_c_0_1_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TC_c_0_1_F,
      O => N31150
    );
  Cpu16_I2_TC_c_0_1_DYMUX_926 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31995,
      O => Cpu16_I2_TC_c_0_1_DYMUX
    );
  Cpu16_I2_TC_c_0_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_TC_c_0_1_SRINVNOT
    );
  Cpu16_I2_TC_c_0_1_CLKINV_927 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_TC_c_0_1_CLKINV
    );
  XLXI_3_N12472_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_N12472_F,
      O => XLXI_3_N12472
    );
  XLXI_3_N12472_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_N12472_G,
      O => N20734
    );
  ADDR_OUT_EXT_6_OBUF_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_6_OBUF_F,
      O => ADDR_OUT_EXT_6_OBUF
    );
  ADDR_OUT_EXT_6_OBUF_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_6_OBUF_G,
      O => ADDR_OUT_EXT_8_OBUF
    );
  Cpu16_I2_TD_x_0_2 : X_LUT4
    generic map(
      INIT => X"3210"
    )
    port map (
      ADR0 => Cpu16_I2_n01501_1,
      ADR1 => Cpu16_I2_n0077,
      ADR2 => Cpu16_I2_idata_c(0),
      ADR3 => MEM_DATA_OUT(0),
      O => N31801_G
    );
  N31801_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31801_F,
      O => N31801
    );
  N31801_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31801_G,
      O => CHOICE293
    );
  N31203_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31203_F,
      O => N31203
    );
  N31203_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31203_G,
      O => N31370
    );
  Cpu16_I2_TD_c_0_3_DYMUX_928 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_x(0),
      O => Cpu16_I2_TD_c_0_3_DYMUX
    );
  Cpu16_I2_TD_c_0_3_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_TD_c_0_3_SRINVNOT
    );
  Cpu16_I2_TD_c_0_3_CLKINV_929 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_TD_c_0_3_CLKINV
    );
  Cpu16_I2_TD_c_2_3_DYMUX_930 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_x(2),
      O => Cpu16_I2_TD_c_2_3_DYMUX
    );
  Cpu16_I2_TD_c_2_3_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_TD_c_2_3_SRINVNOT
    );
  Cpu16_I2_TD_c_2_3_CLKINV_931 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_TD_c_2_3_CLKINV
    );
  Cpu16_I2_TD_c_3_1_DXMUX_932 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_c_3_1_FXMUX,
      O => Cpu16_I2_TD_c_3_1_DXMUX
    );
  Cpu16_I2_TD_c_3_1_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_c_3_1_FXMUX,
      O => Cpu16_I2_TD_x(3)
    );
  Cpu16_I2_TD_c_3_1_FXMUX_933 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_c_3_1_F,
      O => Cpu16_I2_TD_c_3_1_FXMUX
    );
  Cpu16_I2_TD_c_3_1_DYMUX_934 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_x(3),
      O => Cpu16_I2_TD_c_3_1_DYMUX
    );
  Cpu16_I2_TD_c_3_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_c_3_1_G,
      O => N20207
    );
  Cpu16_I2_TD_c_3_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_TD_c_3_1_SRINVNOT
    );
  Cpu16_I2_TD_c_3_1_CLKINV_935 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_TD_c_3_1_CLKINV
    );
  XLXI_5_Mmux_n0016_Result4 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => XLXI_5_nwait_c(1),
      ADR1 => XLXI_5_nwait_c(2),
      ADR2 => XLXI_5_nwait_c(3),
      ADR3 => XLXI_5_nwait_c(0),
      O => CHOICE270_G
    );
  CHOICE270_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE270_F,
      O => CHOICE270
    );
  CHOICE270_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE270_G,
      O => CHOICE578
    );
  CHOICE583_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE583_F,
      O => CHOICE583
    );
  CHOICE583_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE583_G,
      O => CHOICE581
    );
  N31179_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31179_F,
      O => N31179
    );
  N31179_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31179_G,
      O => N30698
    );
  CHOICE288_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE288_F,
      O => CHOICE288
    );
  Cpu16_I2_TD_c_0_1_DXMUX_936 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_c_0_1_FXMUX,
      O => Cpu16_I2_TD_c_0_1_DXMUX
    );
  Cpu16_I2_TD_c_0_1_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_c_0_1_FXMUX,
      O => Cpu16_I2_TD_x(0)
    );
  Cpu16_I2_TD_c_0_1_FXMUX_937 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_c_0_1_F,
      O => Cpu16_I2_TD_c_0_1_FXMUX
    );
  Cpu16_I2_TD_c_0_1_DYMUX_938 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_x(0),
      O => Cpu16_I2_TD_c_0_1_DYMUX
    );
  Cpu16_I2_TD_c_0_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_c_0_1_G,
      O => CHOICE307
    );
  Cpu16_I2_TD_c_0_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_TD_c_0_1_SRINVNOT
    );
  Cpu16_I2_TD_c_0_1_CLKINV_939 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_TD_c_0_1_CLKINV
    );
  Cpu16_I3_n0147_6_13_SW0 : X_LUT4
    generic map(
      INIT => X"FF44"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_3_1,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => VCC,
      ADR3 => CHOICE1043,
      O => N30665_G
    );
  N30665_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30665_F,
      O => N30665
    );
  N30665_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30665_G,
      O => N30677
    );
  Cpu16_I2_pc_mux_x_2_46_SW0 : X_LUT4
    generic map(
      INIT => X"870F"
    )
    port map (
      ADR0 => Cpu16_I1_n0010,
      ADR1 => CHOICE665,
      ADR2 => XLXI_4_addr_c(1),
      ADR3 => Cpu16_I2_n0166(2),
      O => N30424_G
    );
  N30424_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30424_F,
      O => N30424
    );
  N30424_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30424_G,
      O => N31108
    );
  N30764_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30764_F,
      O => N30764
    );
  N30764_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30764_G,
      O => N31110
    );
  Cpu16_I2_TD_c_1_1_DXMUX_940 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_c_1_1_FXMUX,
      O => Cpu16_I2_TD_c_1_1_DXMUX
    );
  Cpu16_I2_TD_c_1_1_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_c_1_1_FXMUX,
      O => Cpu16_I2_TD_x(1)
    );
  Cpu16_I2_TD_c_1_1_FXMUX_941 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_c_1_1_F,
      O => Cpu16_I2_TD_c_1_1_FXMUX
    );
  Cpu16_I2_TD_c_1_1_DYMUX_942 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_x(1),
      O => Cpu16_I2_TD_c_1_1_DYMUX
    );
  Cpu16_I2_TD_c_1_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_c_1_1_G,
      O => CHOICE350
    );
  Cpu16_I2_TD_c_1_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_TD_c_1_1_SRINVNOT
    );
  Cpu16_I2_TD_c_1_1_CLKINV_943 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_TD_c_1_1_CLKINV
    );
  Cpu16_I3_n0147_6_13_SW2 : X_LUT4
    generic map(
      INIT => X"0408"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_0_1,
      ADR1 => Cpu16_I3_acc_c_0_6,
      ADR2 => Cpu16_I2_TC_c_2_1,
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => N30353_G
    );
  N30353_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30353_F,
      O => N30353
    );
  N30353_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30353_G,
      O => N30952
    );
  N31197_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31197_F,
      O => N31197
    );
  N31197_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31197_G,
      O => N30758
    );
  XLXI_4_n00021_SW1_O_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n00021_SW1_O_F,
      O => XLXI_4_n00021_SW1_O
    );
  XLXI_4_n00021_SW1_O_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n00021_SW1_O_G,
      O => N31116
    );
  XLXI_5_Msub_n0011_inst_lut2_81 : X_LUT4
    generic map(
      INIT => X"3333"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_5_nwait_c(1),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_Msub_n0011_inst_lut2_8
    );
  Cpu16_I2_ndre_x1_SW6_SW0_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"C080"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(2),
      ADR1 => NRESET_IN_BUFGP,
      ADR2 => Cpu16_I4_nreset_v(1),
      ADR3 => Cpu16_I2_idata_c(1),
      O => N31264_G
    );
  N31264_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31264_F,
      O => N31264
    );
  N31264_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31264_G,
      O => N31376
    );
  CHOICE544_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE544_F,
      O => CHOICE544
    );
  CHOICE544_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE544_G,
      O => CHOICE502
    );
  Cpu16_I2_TD_c_2_1_DXMUX_944 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_c_2_1_FXMUX,
      O => Cpu16_I2_TD_c_2_1_DXMUX
    );
  Cpu16_I2_TD_c_2_1_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_c_2_1_FXMUX,
      O => Cpu16_I2_TD_x(2)
    );
  Cpu16_I2_TD_c_2_1_FXMUX_945 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_c_2_1_F,
      O => Cpu16_I2_TD_c_2_1_FXMUX
    );
  Cpu16_I2_TD_c_2_1_DYMUX_946 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_x(2),
      O => Cpu16_I2_TD_c_2_1_DYMUX
    );
  Cpu16_I2_TD_c_2_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_c_2_1_G,
      O => CHOICE326
    );
  Cpu16_I2_TD_c_2_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_TD_c_2_1_SRINVNOT
    );
  Cpu16_I2_TD_c_2_1_CLKINV_947 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_TD_c_2_1_CLKINV
    );
  Cpu16_I4_n020253_SW0_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FEF3"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(6),
      ADR1 => Cpu16_I2_idata_c(4),
      ADR2 => N31070,
      ADR3 => Cpu16_I2_idata_c(5),
      O => N31076_F
    );
  N31076_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31076_F,
      O => N31076
    );
  DATA_OUT_EXT_2_OBUF_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_2_OBUF_F,
      O => DATA_OUT_EXT_2_OBUF
    );
  DATA_OUT_EXT_2_OBUF_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_2_OBUF_G,
      O => DATA_OUT_EXT_0_OBUF
    );
  CHOICE392_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE392_F,
      O => CHOICE392
    );
  CHOICE392_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE392_G,
      O => CHOICE572
    );
  DATA_OUT_EXT_4_OBUF_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_4_OBUF_F,
      O => DATA_OUT_EXT_4_OBUF
    );
  DATA_OUT_EXT_4_OBUF_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_4_OBUF_G,
      O => DATA_OUT_EXT_3_OBUF
    );
  Cpu16_I2_nreset_v_1_1_DYMUX_948 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GLOBAL_LOGIC1_6,
      O => Cpu16_I2_nreset_v_1_1_DYMUX
    );
  Cpu16_I2_nreset_v_1_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_nreset_v_1_1_SRINVNOT
    );
  Cpu16_I2_nreset_v_1_1_CLKINV_949 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_nreset_v_1_1_CLKINV
    );
  Cpu16_I2_nreset_v_1_1_CEINV_950 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_nreset_v(0),
      O => Cpu16_I2_nreset_v_1_1_CEINV
    );
  DATA_OUT_EXT_6_OBUF_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_6_OBUF_F,
      O => DATA_OUT_EXT_6_OBUF
    );
  DATA_OUT_EXT_6_OBUF_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_6_OBUF_G,
      O => DATA_OUT_EXT_5_OBUF
    );
  CHOICE397_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE397_F,
      O => CHOICE397
    );
  CHOICE397_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE397_G,
      O => CHOICE378
    );
  CHOICE530_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE530_F,
      O => CHOICE530
    );
  CHOICE530_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE530_G,
      O => CHOICE516
    );
  DATA_OUT_EXT_8_OBUF_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_8_OBUF_F,
      O => DATA_OUT_EXT_8_OBUF
    );
  DATA_OUT_EXT_8_OBUF_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_8_OBUF_G,
      O => DATA_OUT_EXT_7_OBUF
    );
  CHOICE485_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE485_F,
      O => CHOICE485
    );
  CHOICE485_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE485_G,
      O => CHOICE364
    );
  XLXI_3_dwait_c_DYMUX_951 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_dw_s(0),
      O => XLXI_3_dwait_c_DYMUX
    );
  XLXI_3_dwait_c_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_3_dwait_c_SRINVNOT
    );
  XLXI_3_dwait_c_CLKINV_952 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_3_dwait_c_CLKINV
    );
  N30510_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30510_F,
      O => N30510
    );
  DATA_OUT_EXT_10_OBUF_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_10_OBUF_F,
      O => DATA_OUT_EXT_10_OBUF
    );
  DATA_OUT_EXT_10_OBUF_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_10_OBUF_G,
      O => DATA_OUT_EXT_9_OBUF
    );
  CHOICE477_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE477_F,
      O => CHOICE477
    );
  CHOICE477_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE477_G,
      O => CHOICE387
    );
  Cpu16_I1_n0024_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0024_F,
      O => Cpu16_I1_n0024
    );
  Cpu16_I1_n0024_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0024_G,
      O => XLXI_4_n0002
    );
  N31908_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31908_F,
      O => N31908
    );
  N31908_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31908_G,
      O => N30293
    );
  Cpu16_I2_Mmux_idata_x_Result_1_1 : X_LUT4
    generic map(
      INIT => X"F3C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_n0150,
      ADR2 => MEM_DATA_OUT(1),
      ADR3 => Cpu16_I2_idata_c(1),
      O => N31181_G
    );
  N31181_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31181_F,
      O => N31181
    );
  N31181_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31181_G,
      O => Cpu16_I2_idata_x(1)
    );
  N31185_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31185_F,
      O => N31185
    );
  N31185_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31185_G,
      O => Cpu16_I2_idata_x(2)
    );
  CHOICE665_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE665_F,
      O => CHOICE665
    );
  CHOICE665_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE665_G,
      O => Cpu16_I2_n0145
    );
  Cpu16_I3_N17242_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_N17242_F,
      O => Cpu16_I3_N17242
    );
  Cpu16_I3_N17242_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_N17242_G,
      O => N31327
    );
  N31146_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31146_F,
      O => N31146
    );
  N31146_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31146_G,
      O => Cpu16_I2_C_jmp
    );
  N30880_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30880_F,
      O => N30880
    );
  N30880_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30880_G,
      O => N30820
    );
  N31335_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31335_F,
      O => N31335
    );
  N31335_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31335_G,
      O => N31315
    );
  N30613_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30613_F,
      O => N30613
    );
  N30613_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30613_G,
      O => N30611
    );
  N31217_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31217_F,
      O => N31217
    );
  N31217_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31217_G,
      O => N31104
    );
  N30347_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30347_F,
      O => N30347
    );
  N30347_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30347_G,
      O => N30718
    );
  Cpu16_I3_Mmux_data_x_Result_9_114_SW2 : X_LUT4
    generic map(
      INIT => X"D030"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_9,
      ADR1 => Cpu16_I2_TD_c_2_2,
      ADR2 => Cpu16_I2_TD_c_1_2,
      ADR3 => Cpu16_I2_TD_c_0_2,
      O => N31311_G
    );
  N31311_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31311_F,
      O => N31311
    );
  N31311_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31311_G,
      O => N31331
    );
  DATA_OUT_EXT_12_OBUF_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_12_OBUF_F,
      O => DATA_OUT_EXT_12_OBUF
    );
  DATA_OUT_EXT_12_OBUF_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_12_OBUF_G,
      O => DATA_OUT_EXT_11_OBUF
    );
  DATA_OUT_EXT_14_OBUF_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_14_OBUF_F,
      O => DATA_OUT_EXT_14_OBUF
    );
  DATA_OUT_EXT_14_OBUF_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_14_OBUF_G,
      O => DATA_OUT_EXT_13_OBUF
    );
  CHOICE468_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE468_F,
      O => CHOICE468
    );
  CHOICE468_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE468_G,
      O => CHOICE484
    );
  Cpu16_I4_N18286_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18286_F,
      O => Cpu16_I4_N18286
    );
  Cpu16_I4_N18286_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_N18286_G,
      O => DATA_OUT_EXT_15_OBUF
    );
  CHOICE412_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE412_F,
      O => CHOICE412
    );
  CHOICE412_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE412_G,
      O => CHOICE396
    );
  Cpu16_I1_n0020_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0020_F,
      O => Cpu16_I1_n0020
    );
  Cpu16_I1_n0020_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0020_G,
      O => N31160
    );
  CHOICE740_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE740_F,
      O => CHOICE740
    );
  CHOICE740_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE740_G,
      O => N31608
    );
  Cpu16_I4_Ker183551_SW0 : X_LUT4
    generic map(
      INIT => X"CCFF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_idata_c(5),
      ADR2 => VCC,
      ADR3 => Cpu16_I2_idata_c(4),
      O => N31258_G
    );
  N31258_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31258_F,
      O => N31258
    );
  N31258_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31258_G,
      O => N30694
    );
  CHOICE746_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE746_F,
      O => CHOICE746
    );
  CHOICE746_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE746_G,
      O => Cpu16_I3_n0023
    );
  N30440_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30440_F,
      O => N30440
    );
  N30440_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30440_G,
      O => N30438
    );
  CHOICE1587_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1587_F,
      O => CHOICE1587
    );
  CHOICE1587_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1587_G,
      O => CHOICE1565
    );
  CHOICE444_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE444_F,
      O => CHOICE444
    );
  CHOICE444_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE444_G,
      O => CHOICE404
    );
  CHOICE445_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE445_F,
      O => CHOICE445
    );
  CHOICE445_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE445_G,
      O => CHOICE405
    );
  N30842_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30842_F,
      O => N30842
    );
  N30842_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30842_G,
      O => N31838
    );
  CHOICE429_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE429_F,
      O => CHOICE429
    );
  CHOICE429_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE429_G,
      O => CHOICE413
    );
  CHOICE452_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE452_F,
      O => CHOICE452
    );
  CHOICE452_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE452_G,
      O => CHOICE428
    );
  CHOICE476_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE476_F,
      O => CHOICE476
    );
  CHOICE476_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE476_G,
      O => CHOICE420
    );
  CHOICE461_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE461_F,
      O => CHOICE461
    );
  CHOICE461_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE461_G,
      O => CHOICE453
    );
  CHOICE460_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE460_F,
      O => CHOICE460
    );
  N30607_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30607_F,
      O => N30607
    );
  N30607_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30607_G,
      O => N30605
    );
  Cpu16_I2_idata_c_11_DXMUX_953 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MEM_DATA_OUT(11),
      O => Cpu16_I2_idata_c_11_DXMUX
    );
  Cpu16_I2_idata_c_11_DYMUX_954 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MEM_DATA_OUT(10),
      O => Cpu16_I2_idata_c_11_DYMUX
    );
  Cpu16_I2_idata_c_11_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_idata_c_11_SRINVNOT
    );
  Cpu16_I2_idata_c_11_CLKINV_955 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_idata_c_11_CLKINV
    );
  Cpu16_I2_idata_c_11_CEINV_956 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n01501_1,
      O => Cpu16_I2_idata_c_11_CEINV
    );
  N30341_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30341_F,
      O => N30341
    );
  N30341_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30341_G,
      O => N30714
    );
  Cpu16_I2_idata_c_13_DXMUX_957 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MEM_DATA_OUT(13),
      O => Cpu16_I2_idata_c_13_DXMUX
    );
  Cpu16_I2_idata_c_13_DYMUX_958 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MEM_DATA_OUT(12),
      O => Cpu16_I2_idata_c_13_DYMUX
    );
  Cpu16_I2_idata_c_13_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_idata_c_13_SRINVNOT
    );
  Cpu16_I2_idata_c_13_CLKINV_959 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_idata_c_13_CLKINV
    );
  Cpu16_I2_idata_c_13_CEINV_960 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n01501_1,
      O => Cpu16_I2_idata_c_13_CEINV
    );
  Cpu16_I2_idata_c_15_DXMUX_961 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MEM_DATA_OUT(15),
      O => Cpu16_I2_idata_c_15_DXMUX
    );
  Cpu16_I2_idata_c_15_DYMUX_962 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MEM_DATA_OUT(14),
      O => Cpu16_I2_idata_c_15_DYMUX
    );
  Cpu16_I2_idata_c_15_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_idata_c_15_SRINVNOT
    );
  Cpu16_I2_idata_c_15_CLKINV_963 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_idata_c_15_CLKINV
    );
  Cpu16_I2_idata_c_15_CEINV_964 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n01501_1,
      O => Cpu16_I2_idata_c_15_CEINV
    );
  XLXI_5_Msub_n0011_inst_lut2_101 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => XLXI_5_nwait_c(3),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_Msub_n0011_inst_lut2_10
    );
  N30814_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30814_F,
      O => N30814
    );
  N30814_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30814_G,
      O => N31890
    );
  Cpu16_I3_n0091_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0091_F,
      O => Cpu16_I3_n0091
    );
  Cpu16_I3_n0091_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0091_G,
      O => CHOICE1520
    );
  N30848_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30848_F,
      O => N30848
    );
  N30848_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30848_G,
      O => N31842
    );
  N30595_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30595_F,
      O => N30595
    );
  N30595_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30595_G,
      O => N30593
    );
  CHOICE1415_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1415_F,
      O => CHOICE1415
    );
  CHOICE1415_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1415_G,
      O => CHOICE1525
    );
  N30329_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30329_F,
      O => N30329
    );
  N30329_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30329_G,
      O => N30706
    );
  CHOICE1162_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1162_F,
      O => CHOICE1162
    );
  CHOICE1162_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1162_G,
      O => CHOICE1470
    );
  CHOICE997_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE997_F,
      O => CHOICE997
    );
  CHOICE997_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE997_G,
      O => CHOICE1327
    );
  CHOICE717_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE717_F,
      O => CHOICE717
    );
  CHOICE717_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE717_G,
      O => CHOICE1243
    );
  N30812_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30812_F,
      O => N30812
    );
  N30812_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30812_G,
      O => CHOICE1247
    );
  CHOICE893_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE893_F,
      O => CHOICE893
    );
  CHOICE893_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE893_G,
      O => CHOICE1333
    );
  CHOICE1035_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1035_F,
      O => CHOICE1035
    );
  CHOICE1035_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1035_G,
      O => CHOICE1255
    );
  CHOICE1263_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1263_F,
      O => CHOICE1263
    );
  CHOICE1263_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1263_G,
      O => CHOICE1260
    );
  Cpu16_I3_n01001 : X_LUT4
    generic map(
      INIT => X"0066"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_0_1,
      ADR1 => Cpu16_I2_TC_c_1_1,
      ADR2 => VCC,
      ADR3 => Cpu16_I2_TC_c_2_1,
      O => N30679_G
    );
  N30679_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30679_F,
      O => N30679
    );
  N30679_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30679_G,
      O => Cpu16_I3_n0100
    );
  CHOICE1366_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1366_F,
      O => CHOICE1366
    );
  CHOICE1366_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1366_G,
      O => CHOICE1256
    );
  CHOICE1171_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1171_F,
      O => CHOICE1171
    );
  CHOICE1171_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1171_G,
      O => CHOICE1336
    );
  CHOICE887_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE887_F,
      O => CHOICE887
    );
  CHOICE887_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE887_G,
      O => CHOICE1272
    );
  CHOICE1441_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1441_F,
      O => CHOICE1441
    );
  CHOICE1441_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1441_G,
      O => CHOICE1298
    );
  N30808_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30808_F,
      O => N30808
    );
  N30808_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30808_G,
      O => CHOICE1302
    );
  CHOICE948_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE948_F,
      O => CHOICE948
    );
  CHOICE948_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE948_G,
      O => CHOICE1278
    );
  CHOICE808_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE808_F,
      O => CHOICE808
    );
  CHOICE808_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE808_G,
      O => CHOICE1310
    );
  Cpu16_I3_N17033_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_N17033_F,
      O => Cpu16_I3_N17033
    );
  Cpu16_I3_N17033_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_N17033_G,
      O => CHOICE1311
    );
  CHOICE1318_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1318_F,
      O => CHOICE1318
    );
  CHOICE1318_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1318_G,
      O => CHOICE1315
    );
  Cpu16_I3_n0147_12_19 : X_LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_2_1,
      ADR1 => Cpu16_I3_n0090(12),
      ADR2 => Cpu16_I2_TD_c_0_1,
      ADR3 => Cpu16_I2_TD_c_1_1,
      O => CHOICE1188_G
    );
  CHOICE1188_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1188_F,
      O => CHOICE1188
    );
  CHOICE1188_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1188_G,
      O => CHOICE1353
    );
  CHOICE942_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE942_F,
      O => CHOICE942
    );
  CHOICE942_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE942_G,
      O => CHOICE1217
    );
  CHOICE1226_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1226_F,
      O => CHOICE1226
    );
  CHOICE1226_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1226_G,
      O => CHOICE1281
    );
  N31026_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31026_F,
      O => N31026
    );
  N31026_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31026_G,
      O => Cpu16_I3_n0025
    );
  CHOICE1445_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1445_F,
      O => CHOICE1445
    );
  CHOICE1445_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1445_G,
      O => CHOICE1357
    );
  CHOICE1168_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1168_F,
      O => CHOICE1168
    );
  CHOICE1168_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1168_G,
      O => CHOICE1223
    );
  Cpu16_I3_n0085_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0085_F,
      O => Cpu16_I3_n0085
    );
  Cpu16_I3_n0085_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0085_G,
      O => N31291
    );
  CHOICE1090_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1090_F,
      O => CHOICE1090
    );
  CHOICE1090_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1090_G,
      O => CHOICE1365
    );
  XLXI_5_Msub_n0011_inst_lut2_91 : X_LUT4
    generic map(
      INIT => X"3333"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_5_nwait_c(2),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_Msub_n0011_inst_lut2_9
    );
  CHOICE1373_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1373_F,
      O => CHOICE1373
    );
  CHOICE1373_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1373_G,
      O => CHOICE1370
    );
  N30830_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30830_F,
      O => N30830
    );
  N30830_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30830_G,
      O => N31830
    );
  XLXI_4_n00021_SW5_O_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n00021_SW5_O_F,
      O => XLXI_4_n00021_SW5_O
    );
  XLXI_4_n00021_SW5_O_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n00021_SW5_O_G,
      O => N30770
    );
  CHOICE870_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE870_F,
      O => CHOICE870
    );
  CHOICE870_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE870_G,
      O => CHOICE1453
    );
  XLXI_4_n00021_SW7_O_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n00021_SW7_O_F,
      O => XLXI_4_n00021_SW7_O
    );
  XLXI_4_n00021_SW7_O_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n00021_SW7_O_G,
      O => N30776
    );
  CHOICE1461_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1461_F,
      O => CHOICE1461
    );
  CHOICE1461_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1461_G,
      O => CHOICE1458
    );
  Cpu16_I3_n0147_13_82 : X_LUT4
    generic map(
      INIT => X"00C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_TD_c(0),
      ADR2 => Cpu16_I3_acc_c_0_12,
      ADR3 => Cpu16_I2_TD_c(2),
      O => CHOICE809_G
    );
  CHOICE809_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE809_F,
      O => CHOICE809
    );
  CHOICE809_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE809_G,
      O => CHOICE1454
    );
  CHOICE1052_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1052_F,
      O => CHOICE1052
    );
  CHOICE1052_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1052_G,
      O => CHOICE1107
    );
  CHOICE827_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE827_F,
      O => CHOICE827
    );
  CHOICE827_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE827_G,
      O => CHOICE1496
    );
  XLXI_4_n00021_SW9_O_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n00021_SW9_O_F,
      O => XLXI_4_n00021_SW9_O
    );
  XLXI_4_n00021_SW9_O_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_4_n00021_SW9_O_G,
      O => N30782
    );
  Cpu16_I3_N17006_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_N17006_F,
      O => Cpu16_I3_N17006
    );
  Cpu16_I3_N17006_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_N17006_G,
      O => Cpu16_I3_n0081
    );
  CHOICE1637_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1637_F,
      O => CHOICE1637
    );
  CHOICE1637_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1637_G,
      O => CHOICE1500
    );
  N30794_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30794_F,
      O => N30794
    );
  N30794_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30794_G,
      O => N30788
    );
  CHOICE1003_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1003_F,
      O => CHOICE1003
    );
  CHOICE1003_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1003_G,
      O => CHOICE1113
    );
  Cpu16_I3_N17389_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_N17389_F,
      O => Cpu16_I3_N17389
    );
  Cpu16_I3_N17389_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_N17389_G,
      O => Cpu16_I3_n0082
    );
  CHOICE1078_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1078_F,
      O => CHOICE1078
    );
  CHOICE1078_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1078_G,
      O => Cpu16_I3_n0083
    );
  CHOICE1145_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1145_F,
      O => CHOICE1145
    );
  CHOICE1145_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1145_G,
      O => CHOICE1508
    );
  CHOICE1516_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1516_F,
      O => CHOICE1516
    );
  CHOICE1516_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1516_G,
      O => CHOICE1513
    );
  XLXI_5_Msub_n0011_inst_lut2_121 : X_LUT4
    generic map(
      INIT => X"3333"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_5_nwait_c(5),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_Msub_n0011_inst_lut2_12
    );
  Cpu16_I3_Mmux_data_x_Result_2_114_SW2 : X_LUT4
    generic map(
      INIT => X"84C4"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_2_2,
      ADR1 => Cpu16_I2_TD_c_1_2,
      ADR2 => Cpu16_I2_TD_c_0_2,
      ADR3 => Cpu16_I3_acc_c_0_2,
      O => N31307_G
    );
  N31307_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31307_F,
      O => N31307
    );
  N31307_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31307_G,
      O => N31295
    );
  CHOICE1646_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1646_F,
      O => CHOICE1646
    );
  CHOICE1646_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1646_G,
      O => Cpu16_I3_n0084
    );
  CHOICE871_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE871_F,
      O => CHOICE871
    );
  CHOICE871_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE871_G,
      O => CHOICE1509
    );
  CHOICE1116_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1116_F,
      O => CHOICE1116
    );
  CHOICE913_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE913_F,
      O => CHOICE913
    );
  CHOICE913_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE913_G,
      O => CHOICE1633
    );
  CHOICE1390_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1390_F,
      O => CHOICE1390
    );
  CHOICE1390_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1390_G,
      O => Cpu16_I3_n0087
    );
  CHOICE980_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE980_F,
      O => CHOICE980
    );
  CHOICE980_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE980_G,
      O => CHOICE1645
    );
  CHOICE1653_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1653_F,
      O => CHOICE1653
    );
  CHOICE1653_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1653_G,
      O => CHOICE1650
    );
  N30673_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30673_F,
      O => N30673
    );
  N30673_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30673_G,
      O => N30671
    );
  CHOICE1201_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1201_F,
      O => CHOICE1201
    );
  CHOICE1201_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1201_G,
      O => CHOICE1395
    );
  N30383_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30383_F,
      O => N30383
    );
  N30383_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30383_G,
      O => N31035
    );
  CHOICE1402_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1402_F,
      O => CHOICE1402
    );
  CHOICE1402_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1402_G,
      O => CHOICE1401
    );
  Cpu16_I1_nreset_v_1_DYMUX_965 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GLOBAL_LOGIC1_6,
      O => Cpu16_I1_nreset_v_1_DYMUX
    );
  Cpu16_I1_nreset_v_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_nreset_v_1_SRINVNOT
    );
  Cpu16_I1_nreset_v_1_CLKINV_966 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I1_nreset_v_1_CLKINV
    );
  Cpu16_I1_nreset_v_1_CEINV_967 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_nreset_v(0),
      O => Cpu16_I1_nreset_v_1_CEINV
    );
  N31299_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31299_F,
      O => N31299
    );
  N31299_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31299_G,
      O => N31323
    );
  N30619_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30619_F,
      O => N30619
    );
  N30619_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30619_G,
      O => N30617
    );
  N30335_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30335_F,
      O => N30335
    );
  N30335_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30335_G,
      O => N30710
    );
  N30824_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30824_F,
      O => N30824
    );
  N30824_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30824_G,
      O => N31826
    );
  Cpu16_I2_nreset_v_1_DYMUX_968 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GLOBAL_LOGIC1_6,
      O => Cpu16_I2_nreset_v_1_DYMUX
    );
  Cpu16_I2_nreset_v_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_nreset_v_1_SRINVNOT
    );
  Cpu16_I2_nreset_v_1_CLKINV_969 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_nreset_v_1_CLKINV
    );
  Cpu16_I2_nreset_v_1_CEINV_970 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_nreset_v(0),
      O => Cpu16_I2_nreset_v_1_CEINV
    );
  N31319_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31319_F,
      O => N31319
    );
  N31319_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31319_G,
      O => N31303
    );
  N30601_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30601_F,
      O => N30601
    );
  N30601_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30601_G,
      O => N30599
    );
  N30323_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30323_F,
      O => N30323
    );
  N30323_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30323_G,
      O => N30702
    );
  Cpu16_I2_valid_c_DXMUX_971 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_valid_x,
      O => Cpu16_I2_valid_c_DXMUX
    );
  Cpu16_I2_valid_c_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_valid_c_G,
      O => N20348
    );
  Cpu16_I2_valid_c_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_valid_c_SRINVNOT
    );
  Cpu16_I2_valid_c_CLKINV_972 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_valid_c_CLKINV
    );
  Cpu16_I3_nreset_v_1_DYMUX_973 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GLOBAL_LOGIC1_5,
      O => Cpu16_I3_nreset_v_1_DYMUX
    );
  Cpu16_I3_nreset_v_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_nreset_v_1_SRINVNOT
    );
  Cpu16_I3_nreset_v_1_CLKINV_974 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_nreset_v_1_CLKINV
    );
  Cpu16_I3_nreset_v_1_CEINV_975 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_nreset_v(0),
      O => Cpu16_I3_nreset_v_1_CEINV
    );
  N30558_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30558_F,
      O => N30558
    );
  N30558_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30558_G,
      O => N31187
    );
  N30818_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30818_F,
      O => N30818
    );
  N30818_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30818_G,
      O => N31822
    );
  Cpu16_I4_nreset_v_1_DYMUX_976 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GLOBAL_LOGIC1,
      O => Cpu16_I4_nreset_v_1_DYMUX
    );
  Cpu16_I4_nreset_v_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I4_nreset_v_1_SRINVNOT
    );
  Cpu16_I4_nreset_v_1_CLKINV_977 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_nreset_v_1_CLKINV
    );
  Cpu16_I4_nreset_v_1_CEINV_978 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_nreset_v(0),
      O => Cpu16_I4_nreset_v_1_CEINV
    );
  N24841_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N24841_F,
      O => N24841
    );
  N24841_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N24841_G,
      O => N24899
    );
  N30802_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30802_F,
      O => N30802
    );
  N30802_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30802_G,
      O => N30283
    );
  CHOICE1346_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1346_F,
      O => CHOICE1346
    );
  CHOICE1346_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1346_G,
      O => N30800
    );
  N31191_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31191_F,
      O => N31191
    );
  N31191_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31191_G,
      O => N31252
    );
  XLXI_5_Msub_n0011_inst_lut2_111 : X_LUT4
    generic map(
      INIT => X"5555"
    )
    port map (
      ADR0 => XLXI_5_nwait_c(4),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_Msub_n0011_inst_lut2_11
    );
  N30641_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30641_F,
      O => N30641
    );
  N30641_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30641_G,
      O => N30647
    );
  N31584_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31584_F,
      O => N31584
    );
  N31584_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31584_G,
      O => N20432
    );
  N30659_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30659_F,
      O => N30659
    );
  N30659_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30659_G,
      O => N30649
    );
  N30377_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30377_F,
      O => N30377
    );
  N30377_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30377_G,
      O => N31039
    );
  N30806_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30806_F,
      O => N30806
    );
  N30806_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30806_G,
      O => N30289
    );
  Cpu16_I2_S_c_1_DXMUX_979 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n0073(1),
      O => Cpu16_I2_S_c_1_DXMUX
    );
  Cpu16_I2_S_c_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_S_c_1_G,
      O => CHOICE24
    );
  Cpu16_I2_S_c_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_S_c_1_SRINVNOT
    );
  Cpu16_I2_S_c_1_CLKINV_980 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_S_c_1_CLKINV
    );
  Cpu16_I3_Mmux_data_x_Result_6_114_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FDFF"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_0_1,
      ADR2 => Cpu16_I2_TC_c_2_1,
      ADR3 => Cpu16_I2_data_is_c(6),
      O => N30836_G
    );
  N30836_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30836_F,
      O => N30836
    );
  N30836_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30836_G,
      O => N31834
    );
  XLXI_5_cpu_daddr_c_1_DXMUX_981 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_ADADDR_OUT(1),
      O => XLXI_5_cpu_daddr_c_1_DXMUX
    );
  XLXI_5_cpu_daddr_c_1_DYMUX_982 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_ADADDR_OUT(0),
      O => XLXI_5_cpu_daddr_c_1_DYMUX
    );
  XLXI_5_cpu_daddr_c_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_5_cpu_daddr_c_1_SRINVNOT
    );
  XLXI_5_cpu_daddr_c_1_CLKINV_983 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_5_cpu_daddr_c_1_CLKINV
    );
  XLXI_5_cpu_daddr_c_1_CEINV_984 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0032,
      O => XLXI_5_cpu_daddr_c_1_CEINV
    );
  Cpu16_I3_Mmux_data_x_Result_14_SW1 : X_LUT4
    generic map(
      INIT => X"9595"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_14,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => Cpu16_data_is_int(14),
      ADR3 => VCC,
      O => N30494_G
    );
  N30494_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30494_F,
      O => N30494
    );
  N30494_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30494_G,
      O => N30492
    );
  XLXI_5_cpu_daddr_c_3_DXMUX_985 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_ADADDR_OUT(3),
      O => XLXI_5_cpu_daddr_c_3_DXMUX
    );
  XLXI_5_cpu_daddr_c_3_DYMUX_986 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_ADADDR_OUT(2),
      O => XLXI_5_cpu_daddr_c_3_DYMUX
    );
  XLXI_5_cpu_daddr_c_3_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_5_cpu_daddr_c_3_SRINVNOT
    );
  XLXI_5_cpu_daddr_c_3_CLKINV_987 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_5_cpu_daddr_c_3_CLKINV
    );
  XLXI_5_cpu_daddr_c_3_CEINV_988 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0032,
      O => XLXI_5_cpu_daddr_c_3_CEINV
    );
  XLXI_5_cpu_daddr_c_5_DXMUX_989 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_ADADDR_OUT(5),
      O => XLXI_5_cpu_daddr_c_5_DXMUX
    );
  XLXI_5_cpu_daddr_c_5_DYMUX_990 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_ADADDR_OUT(4),
      O => XLXI_5_cpu_daddr_c_5_DYMUX
    );
  XLXI_5_cpu_daddr_c_5_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_5_cpu_daddr_c_5_SRINVNOT
    );
  XLXI_5_cpu_daddr_c_5_CLKINV_991 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_5_cpu_daddr_c_5_CLKINV
    );
  XLXI_5_cpu_daddr_c_5_CEINV_992 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0032,
      O => XLXI_5_cpu_daddr_c_5_CEINV
    );
  XLXI_5_cpu_daddr_c_7_DXMUX_993 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_ADADDR_OUT(7),
      O => XLXI_5_cpu_daddr_c_7_DXMUX
    );
  XLXI_5_cpu_daddr_c_7_DYMUX_994 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_ADADDR_OUT(6),
      O => XLXI_5_cpu_daddr_c_7_DYMUX
    );
  XLXI_5_cpu_daddr_c_7_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_5_cpu_daddr_c_7_SRINVNOT
    );
  XLXI_5_cpu_daddr_c_7_CLKINV_995 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_5_cpu_daddr_c_7_CLKINV
    );
  XLXI_5_cpu_daddr_c_7_CEINV_996 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0032,
      O => XLXI_5_cpu_daddr_c_7_CEINV
    );
  XLXI_5_cpu_daddr_c_9_DXMUX_997 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_cpu_daddr_c_9_FXMUX,
      O => XLXI_5_cpu_daddr_c_9_DXMUX
    );
  XLXI_5_cpu_daddr_c_9_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_cpu_daddr_c_9_FXMUX,
      O => CPU_ADADDR_OUT(9)
    );
  XLXI_5_cpu_daddr_c_9_FXMUX_998 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_cpu_daddr_c_9_F,
      O => XLXI_5_cpu_daddr_c_9_FXMUX
    );
  XLXI_5_cpu_daddr_c_9_DYMUX_999 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_ADADDR_OUT(8),
      O => XLXI_5_cpu_daddr_c_9_DYMUX
    );
  XLXI_5_cpu_daddr_c_9_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_cpu_daddr_c_9_G,
      O => Cpu16_I4_N18033
    );
  XLXI_5_cpu_daddr_c_9_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_5_cpu_daddr_c_9_SRINVNOT
    );
  XLXI_5_cpu_daddr_c_9_CLKINV_1000 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_5_cpu_daddr_c_9_CLKINV
    );
  XLXI_5_cpu_daddr_c_9_CEINV_1001 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0032,
      O => XLXI_5_cpu_daddr_c_9_CEINV
    );
  N30635_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30635_F,
      O => N30635
    );
  N30635_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30635_G,
      O => N30643
    );
  Cpu16_I3_skip_i_DXMUX_1002 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_skip_l,
      O => Cpu16_I3_skip_i_DXMUX
    );
  Cpu16_I3_skip_i_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_skip_i_G,
      O => CHOICE1588
    );
  Cpu16_I3_skip_i_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_skip_i_SRINVNOT
    );
  Cpu16_I3_skip_i_CLKINV_1003 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_skip_i_CLKINV
    );
  Cpu16_I3_skip_i_CEINV_1004 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_int_start_c_1,
      O => Cpu16_I3_skip_i_CEINV
    );
  N30317_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30317_F,
      O => N30317
    );
  N30317_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30317_G,
      O => N30734
    );
  Cpu16_I3_acc_c_0_11_DXMUX_1005 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_11_FXMUX,
      O => Cpu16_I3_acc_c_0_11_DXMUX
    );
  Cpu16_I3_acc_c_0_11_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_11_FXMUX,
      O => Cpu16_I3_acc(0, 11)
    );
  Cpu16_I3_acc_c_0_11_FXMUX_1006 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_11_F,
      O => Cpu16_I3_acc_c_0_11_FXMUX
    );
  Cpu16_I3_acc_c_0_11_DYMUX_1007 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc(0, 10),
      O => Cpu16_I3_acc_c_0_11_DYMUX
    );
  Cpu16_I3_acc_c_0_11_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_11_G,
      O => Cpu16_I3_n0147_11_39_SW0_O
    );
  Cpu16_I3_acc_c_0_11_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_11_SRINVNOT
    );
  Cpu16_I3_acc_c_0_11_CLKINV_1008 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_11_CLKINV
    );
  Cpu16_I3_acc_c_0_13_DXMUX_1009 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_13_FXMUX,
      O => Cpu16_I3_acc_c_0_13_DXMUX
    );
  Cpu16_I3_acc_c_0_13_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_13_FXMUX,
      O => Cpu16_I3_acc(0, 13)
    );
  Cpu16_I3_acc_c_0_13_FXMUX_1010 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_13_F,
      O => Cpu16_I3_acc_c_0_13_FXMUX
    );
  Cpu16_I3_acc_c_0_13_DYMUX_1011 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc(0, 12),
      O => Cpu16_I3_acc_c_0_13_DYMUX
    );
  Cpu16_I3_acc_c_0_13_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_13_G,
      O => Cpu16_I3_n0147_13_39_SW0_O
    );
  Cpu16_I3_acc_c_0_13_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_13_SRINVNOT
    );
  Cpu16_I3_acc_c_0_13_CLKINV_1012 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_13_CLKINV
    );
  Cpu16_I3_acc_c_0_15_DXMUX_1013 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc(0, 15),
      O => Cpu16_I3_acc_c_0_15_DXMUX
    );
  Cpu16_I3_acc_c_0_15_DYMUX_1014 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc(0, 14),
      O => Cpu16_I3_acc_c_0_15_DYMUX
    );
  Cpu16_I3_acc_c_0_15_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_15_SRINVNOT
    );
  Cpu16_I3_acc_c_0_15_CLKINV_1015 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_15_CLKINV
    );
  Cpu16_I3_acc_c_0_16_DYMUX_1016 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc(0, 16),
      O => Cpu16_I3_acc_c_0_16_DYMUX
    );
  Cpu16_I3_acc_c_0_16_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_16_SRINVNOT
    );
  Cpu16_I3_acc_c_0_16_CLKINV_1017 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_16_CLKINV
    );
  N24468_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N24468_F,
      O => N24468
    );
  Cpu16_I2_idata_c_1_DXMUX_1018 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MEM_DATA_OUT(1),
      O => Cpu16_I2_idata_c_1_DXMUX
    );
  Cpu16_I2_idata_c_1_DYMUX_1019 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MEM_DATA_OUT(0),
      O => Cpu16_I2_idata_c_1_DYMUX
    );
  Cpu16_I2_idata_c_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_idata_c_1_SRINVNOT
    );
  Cpu16_I2_idata_c_1_CLKINV_1020 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_idata_c_1_CLKINV
    );
  Cpu16_I2_idata_c_1_CEINV_1021 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n01501_1,
      O => Cpu16_I2_idata_c_1_CEINV
    );
  Cpu16_I2_idata_c_3_DXMUX_1022 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MEM_DATA_OUT(3),
      O => Cpu16_I2_idata_c_3_DXMUX
    );
  Cpu16_I2_idata_c_3_DYMUX_1023 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MEM_DATA_OUT(2),
      O => Cpu16_I2_idata_c_3_DYMUX
    );
  Cpu16_I2_idata_c_3_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_idata_c_3_SRINVNOT
    );
  Cpu16_I2_idata_c_3_CLKINV_1024 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_idata_c_3_CLKINV
    );
  Cpu16_I2_idata_c_3_CEINV_1025 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n01501_1,
      O => Cpu16_I2_idata_c_3_CEINV
    );
  Cpu16_I2_idata_c_5_DXMUX_1026 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MEM_DATA_OUT(5),
      O => Cpu16_I2_idata_c_5_DXMUX
    );
  Cpu16_I2_idata_c_5_DYMUX_1027 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MEM_DATA_OUT(4),
      O => Cpu16_I2_idata_c_5_DYMUX
    );
  Cpu16_I2_idata_c_5_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_idata_c_5_SRINVNOT
    );
  Cpu16_I2_idata_c_5_CLKINV_1028 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_idata_c_5_CLKINV
    );
  Cpu16_I2_idata_c_5_CEINV_1029 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n01501_1,
      O => Cpu16_I2_idata_c_5_CEINV
    );
  Cpu16_I2_idata_c_7_DXMUX_1030 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MEM_DATA_OUT(7),
      O => Cpu16_I2_idata_c_7_DXMUX
    );
  Cpu16_I2_idata_c_7_DYMUX_1031 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MEM_DATA_OUT(6),
      O => Cpu16_I2_idata_c_7_DYMUX
    );
  Cpu16_I2_idata_c_7_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_idata_c_7_SRINVNOT
    );
  Cpu16_I2_idata_c_7_CLKINV_1032 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_idata_c_7_CLKINV
    );
  Cpu16_I2_idata_c_7_CEINV_1033 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n01501_1,
      O => Cpu16_I2_idata_c_7_CEINV
    );
  Cpu16_I2_idata_c_9_DXMUX_1034 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MEM_DATA_OUT(9),
      O => Cpu16_I2_idata_c_9_DXMUX
    );
  Cpu16_I2_idata_c_9_DYMUX_1035 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => MEM_DATA_OUT(8),
      O => Cpu16_I2_idata_c_9_DYMUX
    );
  Cpu16_I2_idata_c_9_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_idata_c_9_SRINVNOT
    );
  Cpu16_I2_idata_c_9_CLKINV_1036 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_idata_c_9_CLKINV
    );
  Cpu16_I2_idata_c_9_CEINV_1037 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n01501_1,
      O => Cpu16_I2_idata_c_9_CEINV
    );
  N30854_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30854_F,
      O => N30854
    );
  N30854_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30854_G,
      O => N31846
    );
  N30872_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30872_F,
      O => N30872
    );
  N30872_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30872_G,
      O => N31858
    );
  CHOICE1071_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1071_F,
      O => CHOICE1071
    );
  CHOICE1071_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1071_G,
      O => CHOICE1236
    );
  CHOICE789_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE789_F,
      O => CHOICE789
    );
  CHOICE789_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE789_G,
      O => CHOICE1291
    );
  Cpu16_I4_n0215_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0215_G,
      O => Cpu16_I4_n0215
    );
  Cpu16_I3_data_x_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_data_x_0_F,
      O => Cpu16_I3_data_x_0_Q
    );
  Cpu16_I3_data_x_0_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_data_x_0_G,
      O => N30542
    );
  XLXI_5_Msub_n0011_inst_lut2_131 : X_LUT4
    generic map(
      INIT => X"3333"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXI_5_nwait_c(6),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_Msub_n0011_inst_lut2_13
    );
  Cpu16_I4_data_exp_i_2_DXMUX_1038 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_data_exp_i_2_FXMUX,
      O => Cpu16_I4_data_exp_i_2_DXMUX
    );
  Cpu16_I4_data_exp_i_2_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_data_exp_i_2_FXMUX,
      O => Cpu16_data_is_int(14)
    );
  Cpu16_I4_data_exp_i_2_FXMUX_1039 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_data_exp_i_2_F,
      O => Cpu16_I4_data_exp_i_2_FXMUX
    );
  Cpu16_I4_data_exp_i_2_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_data_exp_i_2_G,
      O => Cpu16_I4_n0162
    );
  Cpu16_I4_data_exp_i_2_CLKINV_1040 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_data_exp_i_2_CLKINV
    );
  Cpu16_I4_data_exp_i_2_CEINV_1041 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_data_exp_i_2_CEINV
    );
  CHOICE1489_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1489_F,
      O => CHOICE1489
    );
  CHOICE1489_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1489_G,
      O => CHOICE1434
    );
  Cpu16_I4_n0157_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157_G,
      O => Cpu16_I4_n0157
    );
  CHOICE1126_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1126_F,
      O => CHOICE1126
    );
  CHOICE1126_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1126_G,
      O => CHOICE1626
    );
  N30653_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30653_F,
      O => N30653
    );
  N30653_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30653_G,
      O => N30667
    );
  N30371_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30371_F,
      O => N30371
    );
  N30371_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30371_G,
      O => N31031
    );
  Cpu16_I3_n0147_16_4 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => Cpu16_I3_n0081,
      ADR1 => Cpu16_I3_acc_c_0_15,
      ADR2 => Cpu16_I3_acc_c_0_0,
      ADR3 => Cpu16_I3_N17033,
      O => CHOICE1380_G
    );
  CHOICE1380_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1380_F,
      O => CHOICE1380
    );
  CHOICE1380_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1380_G,
      O => CHOICE1379
    );
  Cpu16_I2_TD_c_1_DXMUX_1042 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_x(1),
      O => Cpu16_I2_TD_c_1_DXMUX
    );
  Cpu16_I2_TD_c_1_DYMUX_1043 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_x(0),
      O => Cpu16_I2_TD_c_1_DYMUX
    );
  Cpu16_I2_TD_c_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_TD_c_1_SRINVNOT
    );
  Cpu16_I2_TD_c_1_CLKINV_1044 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_TD_c_1_CLKINV
    );
  Cpu16_I2_TD_c_2_DYMUX_1045 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_TD_x(2),
      O => Cpu16_I2_TD_c_2_DYMUX
    );
  Cpu16_I2_TD_c_2_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_TD_c_2_SRINVNOT
    );
  Cpu16_I2_TD_c_2_CLKINV_1046 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_TD_c_2_CLKINV
    );
  CHOICE1023_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1023_F,
      O => CHOICE1023
    );
  CHOICE1023_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1023_G,
      O => CHOICE796
    );
  Cpu16_I3_Madd_n0098_inst_lut2_451 : X_LUT4
    generic map(
      INIT => X"596A"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_1,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => Cpu16_I2_data_is_c(1),
      ADR3 => CHOICE1485,
      O => Cpu16_I3_Madd_n0098_inst_lut2_451_O
    );
  CHOICE1137_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1137_F,
      O => CHOICE1137
    );
  CHOICE1137_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1137_G,
      O => CHOICE800
    );
  N30860_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30860_F,
      O => N30860
    );
  N30860_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30860_G,
      O => N31850
    );
  CHOICE816_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE816_F,
      O => CHOICE816
    );
  CHOICE816_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE816_G,
      O => CHOICE813
    );
  CHOICE1192_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1192_F,
      O => CHOICE1192
    );
  CHOICE1192_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1192_G,
      O => CHOICE831
    );
  CHOICE925_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE925_F,
      O => CHOICE925
    );
  CHOICE925_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE925_G,
      O => CHOICE839
    );
  CHOICE981_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE981_F,
      O => CHOICE981
    );
  CHOICE981_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE981_G,
      O => CHOICE840
    );
  CHOICE847_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE847_F,
      O => CHOICE847
    );
  CHOICE847_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE847_G,
      O => CHOICE844
    );
  CHOICE968_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE968_F,
      O => CHOICE968
    );
  CHOICE968_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE968_G,
      O => CHOICE858
    );
  CHOICE1027_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1027_F,
      O => CHOICE1027
    );
  CHOICE1027_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1027_G,
      O => CHOICE862
    );
  N30878_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30878_F,
      O => N30878
    );
  N30878_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30878_G,
      O => N31862
    );
  NRE_EXT_OBUF_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => NRE_EXT_OBUF_G,
      O => NRE_EXT_OBUF
    );
  CHOICE878_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE878_F,
      O => CHOICE878
    );
  CHOICE878_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE878_G,
      O => CHOICE875
    );
  CHOICE972_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE972_F,
      O => CHOICE972
    );
  CHOICE972_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE972_G,
      O => CHOICE917
    );
  CHOICE933_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE933_F,
      O => CHOICE933
    );
  CHOICE933_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE933_G,
      O => CHOICE930
    );
  Cpu16_I3_n0147_4_82 : X_LUT4
    generic map(
      INIT => X"0808"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c(0),
      ADR1 => Cpu16_I3_acc_c_0_3,
      ADR2 => Cpu16_I2_TD_c(2),
      ADR3 => VCC,
      O => CHOICE1601_G
    );
  CHOICE1601_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1601_F,
      O => CHOICE1601
    );
  CHOICE1601_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1601_G,
      O => CHOICE926
    );
  N30631_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30631_F,
      O => N30631
    );
  N30631_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30631_G,
      O => N30629
    );
  CHOICE988_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE988_F,
      O => CHOICE988
    );
  CHOICE988_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE988_G,
      O => CHOICE985
    );
  N30311_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30311_F,
      O => N30311
    );
  N30311_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30311_G,
      O => N30730
    );
  XLXI_3_daddr_c_0_DXMUX_1047 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_0_FXMUX,
      O => XLXI_3_daddr_c_0_DXMUX
    );
  XLXI_3_daddr_c_0_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_0_FXMUX,
      O => CPU_ADADDR_OUT(0)
    );
  XLXI_3_daddr_c_0_FXMUX_1048 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_0_F,
      O => XLXI_3_daddr_c_0_FXMUX
    );
  XLXI_3_daddr_c_0_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_0_G,
      O => N20679
    );
  XLXI_3_daddr_c_0_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_3_daddr_c_0_SRINVNOT
    );
  XLXI_3_daddr_c_0_CLKINV_1049 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_3_daddr_c_0_CLKINV
    );
  XLXI_3_daddr_c_0_CEINV_1050 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_nadwe_c_N1214,
      O => XLXI_3_daddr_c_0_CEINV
    );
  CHOICE1043_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1043_F,
      O => CHOICE1043
    );
  CHOICE1043_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1043_G,
      O => CHOICE1040
    );
  Cpu16_I3_n0147_6_82 : X_LUT4
    generic map(
      INIT => X"4400"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_2_3,
      ADR1 => Cpu16_I3_acc_c_0_5,
      ADR2 => VCC,
      ADR3 => Cpu16_I2_TD_c_0_3,
      O => CHOICE1146_G
    );
  CHOICE1146_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1146_F,
      O => CHOICE1146
    );
  CHOICE1146_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1146_G,
      O => CHOICE1036
    );
  CHOICE1082_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1082_F,
      O => CHOICE1082
    );
  CHOICE1098_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1098_F,
      O => CHOICE1098
    );
  CHOICE1098_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1098_G,
      O => CHOICE1095
    );
  Cpu16_I3_n0147_7_82 : X_LUT4
    generic map(
      INIT => X"0C00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_TD_c_0_3,
      ADR2 => Cpu16_I2_TD_c_2_3,
      ADR3 => Cpu16_I3_acc_c_0_6,
      O => CHOICE1016_G
    );
  CHOICE1016_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1016_F,
      O => CHOICE1016
    );
  CHOICE1016_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1016_G,
      O => CHOICE1091
    );
  CHOICE1133_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1133_F,
      O => CHOICE1133
    );
  CHOICE1153_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1153_F,
      O => CHOICE1153
    );
  CHOICE1153_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1153_G,
      O => CHOICE1150
    );
  N30866_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30866_F,
      O => N30866
    );
  N30866_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30866_G,
      O => N31854
    );
  CHOICE52_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE52_F,
      O => CHOICE52
    );
  CHOICE52_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE52_G,
      O => CHOICE17
    );
  Cpu16_I3_N17531_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_N17531_F,
      O => Cpu16_I3_N17531
    );
  Cpu16_I3_N17531_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_N17531_G,
      O => CHOICE1200
    );
  CHOICE1208_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1208_F,
      O => CHOICE1208
    );
  CHOICE1208_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1208_G,
      O => CHOICE1205
    );
  Cpu16_I1_eaddr_x_11_DXMUX_1051 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_n0008(11),
      O => Cpu16_I1_eaddr_x_11_DXMUX
    );
  Cpu16_I1_eaddr_x_11_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_eaddr_x_11_G,
      O => Cpu16_I1_n00201_1
    );
  Cpu16_I1_eaddr_x_11_CLKINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I1_eaddr_x_11_CLKINVNOT
    );
  Cpu16_I1_eaddr_x_11_CEINV_1052 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I1_nreset_v(1),
      O => Cpu16_I1_eaddr_x_11_CEINV
    );
  Cpu16_I2_S_c_2_DXMUX_1053 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_n0073(2),
      O => Cpu16_I2_S_c_2_DXMUX
    );
  Cpu16_I2_S_c_2_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I2_S_c_2_G,
      O => CHOICE37
    );
  Cpu16_I2_S_c_2_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I2_S_c_2_SRINVNOT
    );
  Cpu16_I2_S_c_2_CLKINV_1054 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I2_S_c_2_CLKINV
    );
  XLXI_5_Msub_n0011_inst_lut2_14_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_Msub_n0011_inst_lut2_14_G,
      O => XLXI_5_Msub_n0011_inst_lut2_14
    );
  XLXI_3_daddr_c_1_DXMUX_1055 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_1_FXMUX,
      O => XLXI_3_daddr_c_1_DXMUX
    );
  XLXI_3_daddr_c_1_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_1_FXMUX,
      O => CPU_ADADDR_OUT(1)
    );
  XLXI_3_daddr_c_1_FXMUX_1056 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_1_F,
      O => XLXI_3_daddr_c_1_FXMUX
    );
  XLXI_3_daddr_c_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_1_G,
      O => N20593
    );
  XLXI_3_daddr_c_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_3_daddr_c_1_SRINVNOT
    );
  XLXI_3_daddr_c_1_CLKINV_1057 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_3_daddr_c_1_CLKINV
    );
  XLXI_3_daddr_c_1_CEINV_1058 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_nadwe_c_N1214,
      O => XLXI_3_daddr_c_1_CEINV
    );
  Cpu16_I3_Madd_n0098_inst_lut2_44_rt_1059 : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => Cpu16_I3_Madd_n0098_inst_lut2_44,
      ADR1 => Cpu16_I3_acc_c_0_0,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Cpu16_I3_Madd_n0098_inst_lut2_44_rt
    );
  Cpu16_I3_acc_c_0_1_DXMUX_1060 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_1_FXMUX,
      O => Cpu16_I3_acc_c_0_1_DXMUX
    );
  Cpu16_I3_acc_c_0_1_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_1_FXMUX,
      O => Cpu16_I3_acc(0, 1)
    );
  Cpu16_I3_acc_c_0_1_FXMUX_1061 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_1_F,
      O => Cpu16_I3_acc_c_0_1_FXMUX
    );
  Cpu16_I3_acc_c_0_1_DYMUX_1062 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc(0, 0),
      O => Cpu16_I3_acc_c_0_1_DYMUX
    );
  Cpu16_I3_acc_c_0_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_1_G,
      O => Cpu16_I3_n0147_1_39_SW0_O
    );
  Cpu16_I3_acc_c_0_1_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_1_SRINVNOT
    );
  Cpu16_I3_acc_c_0_1_CLKINV_1063 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_1_CLKINV
    );
  Cpu16_I3_acc_c_0_3_DXMUX_1064 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_3_FXMUX,
      O => Cpu16_I3_acc_c_0_3_DXMUX
    );
  Cpu16_I3_acc_c_0_3_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_3_FXMUX,
      O => Cpu16_I3_acc(0, 3)
    );
  Cpu16_I3_acc_c_0_3_FXMUX_1065 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_3_F,
      O => Cpu16_I3_acc_c_0_3_FXMUX
    );
  Cpu16_I3_acc_c_0_3_DYMUX_1066 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc(0, 2),
      O => Cpu16_I3_acc_c_0_3_DYMUX
    );
  Cpu16_I3_acc_c_0_3_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_3_G,
      O => Cpu16_I3_n0147_3_39_SW0_O
    );
  Cpu16_I3_acc_c_0_3_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_3_SRINVNOT
    );
  Cpu16_I3_acc_c_0_3_CLKINV_1067 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_3_CLKINV
    );
  Cpu16_I3_acc_c_0_5_DXMUX_1068 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_5_FXMUX,
      O => Cpu16_I3_acc_c_0_5_DXMUX
    );
  Cpu16_I3_acc_c_0_5_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_5_FXMUX,
      O => Cpu16_I3_acc(0, 5)
    );
  Cpu16_I3_acc_c_0_5_FXMUX_1069 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_5_F,
      O => Cpu16_I3_acc_c_0_5_FXMUX
    );
  Cpu16_I3_acc_c_0_5_DYMUX_1070 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc(0, 4),
      O => Cpu16_I3_acc_c_0_5_DYMUX
    );
  Cpu16_I3_acc_c_0_5_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_5_G,
      O => Cpu16_I3_n0147_5_39_SW0_O
    );
  Cpu16_I3_acc_c_0_5_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_5_SRINVNOT
    );
  Cpu16_I3_acc_c_0_5_CLKINV_1071 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_5_CLKINV
    );
  Cpu16_I3_acc_c_0_7_DXMUX_1072 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_7_FXMUX,
      O => Cpu16_I3_acc_c_0_7_DXMUX
    );
  Cpu16_I3_acc_c_0_7_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_7_FXMUX,
      O => Cpu16_I3_acc(0, 7)
    );
  Cpu16_I3_acc_c_0_7_FXMUX_1073 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_7_F,
      O => Cpu16_I3_acc_c_0_7_FXMUX
    );
  Cpu16_I3_acc_c_0_7_DYMUX_1074 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc(0, 6),
      O => Cpu16_I3_acc_c_0_7_DYMUX
    );
  Cpu16_I3_acc_c_0_7_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_7_G,
      O => Cpu16_I3_n0147_7_39_SW0_O
    );
  Cpu16_I3_acc_c_0_7_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_7_SRINVNOT
    );
  Cpu16_I3_acc_c_0_7_CLKINV_1075 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_7_CLKINV
    );
  XLXI_5_N12936_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_N12936_F,
      O => XLXI_5_N12936
    );
  Cpu16_I3_acc_c_0_9_DXMUX_1076 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_9_FXMUX,
      O => Cpu16_I3_acc_c_0_9_DXMUX
    );
  Cpu16_I3_acc_c_0_9_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_9_FXMUX,
      O => Cpu16_I3_acc(0, 9)
    );
  Cpu16_I3_acc_c_0_9_FXMUX_1077 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_9_F,
      O => Cpu16_I3_acc_c_0_9_FXMUX
    );
  Cpu16_I3_acc_c_0_9_DYMUX_1078 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc(0, 8),
      O => Cpu16_I3_acc_c_0_9_DYMUX
    );
  Cpu16_I3_acc_c_0_9_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_acc_c_0_9_G,
      O => Cpu16_I3_n0147_9_39_SW0_O
    );
  Cpu16_I3_acc_c_0_9_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_9_SRINVNOT
    );
  Cpu16_I3_acc_c_0_9_CLKINV_1079 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I3_acc_c_0_9_CLKINV
    );
  XLXI_5_Ker129551 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_I4_ndre_x1_1,
      ADR2 => CHOICE277,
      ADR3 => CHOICE270,
      O => ADDR_OUT_EXT_3_OBUF_G
    );
  ADDR_OUT_EXT_3_OBUF_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_3_OBUF_F,
      O => ADDR_OUT_EXT_3_OBUF
    );
  ADDR_OUT_EXT_3_OBUF_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_3_OBUF_G,
      O => XLXI_5_N12957
    );
  XLXI_3_daddr_c_2_DXMUX_1080 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_2_FXMUX,
      O => XLXI_3_daddr_c_2_DXMUX
    );
  XLXI_3_daddr_c_2_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_2_FXMUX,
      O => CPU_ADADDR_OUT(2)
    );
  XLXI_3_daddr_c_2_FXMUX_1081 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_2_F,
      O => XLXI_3_daddr_c_2_FXMUX
    );
  XLXI_3_daddr_c_2_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_daddr_c_2_G,
      O => N20628
    );
  XLXI_3_daddr_c_2_SRINV : X_INV
    port map (
      I => NRESET_IN_BUFGP,
      O => XLXI_3_daddr_c_2_SRINVNOT
    );
  XLXI_3_daddr_c_2_CLKINV_1082 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => XLXI_3_daddr_c_2_CLKINV
    );
  XLXI_3_daddr_c_2_CEINV_1083 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_3_nadwe_c_N1214,
      O => XLXI_3_daddr_c_2_CEINV
    );
  CHOICE4_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE4_F,
      O => CHOICE4
    );
  CHOICE4_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE4_G,
      O => N31797
    );
  CHOICE1181_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1181_F,
      O => CHOICE1181
    );
  CHOICE1181_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1181_G,
      O => Cpu16_I3_N17152
    );
  N30661_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30661_F,
      O => N30661
    );
  N30661_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30661_G,
      O => N30655
    );
  N30365_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30365_F,
      O => N30365
    );
  N30365_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30365_G,
      O => N31043
    );
  CHOICE961_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE961_F,
      O => CHOICE961
    );
  CHOICE961_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE961_G,
      O => CHOICE906
    );
  N31289_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31289_F,
      O => N31289
    );
  N31289_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31289_G,
      O => N31886
    );
  XLXI_5_n0032_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0032_F,
      O => XLXI_5_n0032
    );
  XLXI_5_n0032_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_n0032_G,
      O => CHOICE277
    );
  N30625_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30625_F,
      O => N30625
    );
  N30625_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30625_G,
      O => N30623
    );
  N30305_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30305_F,
      O => N30305
    );
  N30305_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30305_G,
      O => N30726
    );
  N31114_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31114_F,
      O => N31114
    );
  N31114_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N31114_G,
      O => Cpu16_I1_n0010
    );
  CHOICE1608_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1608_F,
      O => CHOICE1608
    );
  Cpu16_I4_Madd_n0182_inst_lut2_71_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_Madd_n0182_inst_lut2_71_G,
      O => Cpu16_I4_Madd_n0182_inst_lut2_71
    );
  N30637_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30637_F,
      O => N30637
    );
  N30637_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30637_G,
      O => CHOICE1623
    );
  CHOICE1616_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CHOICE1616_F,
      O => CHOICE1616
    );
  Cpu16_I4_iinc_i_3_DXMUX_1084 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_x(3),
      O => Cpu16_I4_iinc_i_3_DXMUX
    );
  Cpu16_I4_iinc_i_3_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_iinc_i_3_G,
      O => Cpu16_I4_n01621_1
    );
  Cpu16_I4_iinc_i_3_CLKINV_1085 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => Cpu16_I4_iinc_i_3_CLKINV
    );
  Cpu16_I4_iinc_i_3_CEINV_1086 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I4_n0157,
      O => Cpu16_I4_iinc_i_3_CEINV
    );
  N30359_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30359_F,
      O => N30359
    );
  N30359_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30359_G,
      O => N30956
    );
  N30295_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30295_F,
      O => N30295
    );
  N30295_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30295_G,
      O => N31964
    );
  ADDR_OUT_EXT_4_OBUF_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_4_OBUF_F,
      O => ADDR_OUT_EXT_4_OBUF
    );
  ADDR_OUT_EXT_4_OBUF_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_4_OBUF_G,
      O => ADDR_OUT_EXT_0_OBUF
    );
  ADDR_OUT_EXT_5_OBUF_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_5_OBUF_F,
      O => ADDR_OUT_EXT_5_OBUF
    );
  ADDR_OUT_EXT_5_OBUF_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_5_OBUF_G,
      O => ADDR_OUT_EXT_1_OBUF
    );
  Cpu16_I2_idata_c_14 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_idata_c_15_DYMUX,
      CE => Cpu16_I2_idata_c_15_CEINV,
      CLK => Cpu16_I2_idata_c_15_CLKINV,
      SET => GND,
      RST => Cpu16_I2_idata_c_15_FFY_RST,
      O => Cpu16_I2_idata_c(14)
    );
  Cpu16_I2_idata_c_15_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_idata_c_15_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_idata_c_15_FFY_RST
    );
  Cpu16_I2_idata_c_15 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_idata_c_15_DXMUX,
      CE => Cpu16_I2_idata_c_15_CEINV,
      CLK => Cpu16_I2_idata_c_15_CLKINV,
      SET => GND,
      RST => Cpu16_I2_idata_c_15_FFX_RST,
      O => Cpu16_I2_idata_c(15)
    );
  Cpu16_I2_idata_c_15_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_idata_c_15_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_idata_c_15_FFX_RST
    );
  Cpu16_I3_Mmux_data_x_Result_14_SW4 : X_LUT4
    generic map(
      INIT => X"CF30"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_data_is_int(14),
      ADR2 => Cpu16_I3_n0025,
      ADR3 => Cpu16_I3_acc_c_0_14,
      O => N30814_F
    );
  Cpu16_I3_Mmux_data_x_Result_0_0 : X_LUT4
    generic map(
      INIT => X"0200"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I2_TC_c_0_1,
      ADR3 => Cpu16_I2_data_is_c(0),
      O => Cpu16_I3_n0091_G
    );
  Cpu16_I3_n0147_10_13_SW2 : X_LUT4
    generic map(
      INIT => X"0220"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_10,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I2_TC_c_0_1,
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => N30329_G
    );
  Cpu16_I3_n00911 : X_LUT4
    generic map(
      INIT => X"000C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I2_TC_c_0_1,
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => Cpu16_I3_n0091_F
    );
  Cpu16_I3_Mmux_data_x_Result_2_114_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_0_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I2_data_is_c(2),
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => N30848_G
    );
  Cpu16_I3_n0147_10_13_SW0 : X_LUT4
    generic map(
      INIT => X"FF30"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_TD_c(3),
      ADR2 => Cpu16_I3_n0100,
      ADR3 => CHOICE1263,
      O => N30595_G
    );
  Cpu16_I3_Mmux_data_x_Result_2_114_SW0 : X_LUT4
    generic map(
      INIT => X"C48C"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_2_3,
      ADR1 => Cpu16_I2_TD_c_0_3,
      ADR2 => Cpu16_I2_TD_c(1),
      ADR3 => N31842,
      O => N30848_F
    );
  Cpu16_I3_Mmux_data_x_Result_0_13 : X_LUT4
    generic map(
      INIT => X"A088"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => MEM_DATA_OUT(0),
      ADR2 => DATA_IN_EXT_0_IBUF,
      ADR3 => XLXI_2_mux_c(0),
      O => CHOICE1415_G
    );
  Cpu16_I3_n0147_10_13_SW1 : X_LUT4
    generic map(
      INIT => X"FFB0"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_10,
      ADR1 => Cpu16_I2_TD_c(3),
      ADR2 => Cpu16_I3_n0100,
      ADR3 => CHOICE1263,
      O => N30595_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_2_1 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => Cpu16_I1_pc(2),
      ADR1 => Cpu16_I2_pc_mux_x_0_104_1,
      ADR2 => Cpu16_I2_pc_mux_x_2_46_1,
      ADR3 => Cpu16_I2_pc_mux_x_1_44_1,
      O => CHOICE429_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_6_0 : X_LUT4
    generic map(
      INIT => X"C0C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I1_N13634,
      ADR2 => XLXN_20(6),
      ADR3 => VCC,
      O => CHOICE452_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_3_0 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXN_20(3),
      ADR3 => Cpu16_I1_N13634,
      O => CHOICE476_G
    );
  Cpu16_I1_Mmux_saddr_out_Result_9_0 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXN_20(9),
      ADR2 => VCC,
      ADR3 => Cpu16_I1_N13634,
      O => CHOICE476_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_6_1 : X_LUT4
    generic map(
      INIT => X"4000"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_1_44_1,
      ADR1 => Cpu16_I1_pc(6),
      ADR2 => Cpu16_I2_pc_mux_x_0_104_1,
      ADR3 => Cpu16_I2_pc_mux_x_2_46_1,
      O => CHOICE461_G
    );
  Cpu16_I1_Mmux_saddr_out_Result_7_1 : X_LUT4
    generic map(
      INIT => X"4000"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_1_44_1,
      ADR1 => Cpu16_I1_pc(7),
      ADR2 => Cpu16_I2_pc_mux_x_0_104_1,
      ADR3 => Cpu16_I2_pc_mux_x_2_46_1,
      O => CHOICE461_F
    );
  Cpu16_I3_n0147_8_13_SW0 : X_LUT4
    generic map(
      INIT => X"AAEE"
    )
    port map (
      ADR0 => CHOICE1153,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => VCC,
      ADR3 => Cpu16_I2_TD_c_3_1,
      O => N30607_G
    );
  Cpu16_I1_Mmux_saddr_out_Result_7_0 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXN_20(7),
      ADR2 => VCC,
      ADR3 => Cpu16_I1_N13634,
      O => CHOICE460_F
    );
  Cpu16_I3_Ker172401 : X_LUT4
    generic map(
      INIT => X"C00C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_TD_c_1_2,
      ADR2 => Cpu16_I2_TD_c_2_2,
      ADR3 => Cpu16_I2_TD_c_0_2,
      O => Cpu16_I3_N17242_F
    );
  Cpu16_I2_Ker156981_SW2 : X_LUT4
    generic map(
      INIT => X"51FF"
    )
    port map (
      ADR0 => Cpu16_I2_idata_x(3),
      ADR1 => Cpu16_I2_n0142,
      ADR2 => Cpu16_I2_idata_x(0),
      ADR3 => Cpu16_I2_S_c(2),
      O => N31146_F
    );
  Cpu16_I3_Mmux_data_x_Result_5_114_SW1 : X_LUT4
    generic map(
      INIT => X"AA0A"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_0_3,
      ADR1 => VCC,
      ADR2 => Cpu16_I2_TD_c(1),
      ADR3 => Cpu16_I2_TD_c_2_3,
      O => N30880_G
    );
  Cpu16_I3_Mmux_data_x_Result_11_114_SW1 : X_LUT4
    generic map(
      INIT => X"AA0A"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_0_3,
      ADR1 => VCC,
      ADR2 => Cpu16_I2_TD_c(1),
      ADR3 => Cpu16_I2_TD_c_2_3,
      O => N30880_F
    );
  Cpu16_I3_Mmux_data_x_Result_5_114_SW2 : X_LUT4
    generic map(
      INIT => X"C070"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_5,
      ADR1 => Cpu16_I2_TD_c_0_2,
      ADR2 => Cpu16_I2_TD_c_1_2,
      ADR3 => Cpu16_I2_TD_c_2_2,
      O => N31335_G
    );
  Cpu16_I3_Mmux_data_x_Result_8_114_SW2 : X_LUT4
    generic map(
      INIT => X"C070"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_8,
      ADR1 => Cpu16_I2_TD_c_0_2,
      ADR2 => Cpu16_I2_TD_c_1_2,
      ADR3 => Cpu16_I2_TD_c_2_2,
      O => N31335_F
    );
  Cpu16_I3_n0147_7_13_SW0 : X_LUT4
    generic map(
      INIT => X"F5F0"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_3_1,
      ADR1 => VCC,
      ADR2 => CHOICE1098,
      ADR3 => Cpu16_I3_n0100,
      O => N30613_G
    );
  Cpu16_I2_Ker157051_SW2 : X_LUT4
    generic map(
      INIT => X"FDFF"
    )
    port map (
      ADR0 => Cpu16_I2_nreset_v(1),
      ADR1 => Cpu16_I2_TC_c(2),
      ADR2 => Cpu16_I2_skip_c,
      ADR3 => XLXI_5_dw_s(0),
      O => N31217_G
    );
  Cpu16_I3_n0147_7_13_SW1 : X_LUT4
    generic map(
      INIT => X"FDF0"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_3_1,
      ADR1 => Cpu16_I3_acc_c_0_7,
      ADR2 => CHOICE1098,
      ADR3 => Cpu16_I3_n0100,
      O => N30613_F
    );
  Cpu16_I3_n0147_7_13_SW2 : X_LUT4
    generic map(
      INIT => X"0408"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_0_1,
      ADR1 => Cpu16_I3_acc_c_0_7,
      ADR2 => Cpu16_I2_TC_c_2_1,
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => N30347_G
    );
  Cpu16_I2_n01501_SW1 : X_LUT4
    generic map(
      INIT => X"A0A0"
    )
    port map (
      ADR0 => Cpu16_I2_nreset_v(1),
      ADR1 => VCC,
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => VCC,
      O => N31217_F
    );
  Cpu16_I3_Mmux_data_x_Result_11_32 : X_LUT4
    generic map(
      INIT => X"D080"
    )
    port map (
      ADR0 => Cpu16_daddr_is(2),
      ADR1 => Cpu16_I4_data_exp_c(11),
      ADR2 => Cpu16_I4_N18357,
      ADR3 => Cpu16_I4_ireg_c(11),
      O => CHOICE893_F
    );
  Cpu16_I3_n0147_6_81 : X_LUT4
    generic map(
      INIT => X"0400"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I2_TC_c_0_1,
      ADR3 => Cpu16_I3_acc_i_0_6,
      O => CHOICE1035_F
    );
  Cpu16_I3_n0147_10_90 : X_LUT4
    generic map(
      INIT => X"8F88"
    )
    port map (
      ADR0 => Cpu16_I3_N17033,
      ADR1 => Cpu16_I3_acc_c_0_9,
      ADR2 => Cpu16_I3_acc_c_0_10,
      ADR3 => Cpu16_I3_n0084,
      O => CHOICE1263_G
    );
  Cpu16_I3_n0147_10_106 : X_LUT4
    generic map(
      INIT => X"FFA8"
    )
    port map (
      ADR0 => Cpu16_I3_N17531,
      ADR1 => CHOICE1256,
      ADR2 => CHOICE1260,
      ADR3 => CHOICE1255,
      O => CHOICE1263_F
    );
  Cpu16_I3_n0147_6_13_SW1 : X_LUT4
    generic map(
      INIT => X"EAFA"
    )
    port map (
      ADR0 => CHOICE1043,
      ADR1 => Cpu16_I3_acc_c_0_6,
      ADR2 => Cpu16_I3_n0100,
      ADR3 => Cpu16_I2_TD_c_3_1,
      O => N30679_F
    );
  Cpu16_I3_n0147_10_82 : X_LUT4
    generic map(
      INIT => X"1200"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c(2),
      ADR1 => Cpu16_I2_TD_c(0),
      ADR2 => Cpu16_I2_TD_c(1),
      ADR3 => Cpu16_I3_acc_c_0_11,
      O => CHOICE1366_G
    );
  Cpu16_I3_n0147_12_82 : X_LUT4
    generic map(
      INIT => X"5000"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c(2),
      ADR1 => VCC,
      ADR2 => Cpu16_I2_TD_c(0),
      ADR3 => Cpu16_I3_acc_c_0_11,
      O => CHOICE1366_F
    );
  Cpu16_I3_Mmux_data_x_Result_4_13 : X_LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => XLXI_2_mux_c(0),
      ADR2 => DATA_IN_EXT_4_IBUF,
      ADR3 => MEM_DATA_OUT(4),
      O => CHOICE887_G
    );
  Cpu16_I3_Mmux_data_x_Result_3_37 : X_LUT4
    generic map(
      INIT => X"0200"
    )
    port map (
      ADR0 => Cpu16_daddr_is(1),
      ADR1 => Cpu16_daddr_is(2),
      ADR2 => Cpu16_daddr_is(0),
      ADR3 => Cpu16_I4_iinc_c(3),
      O => CHOICE1171_G
    );
  Cpu16_I3_Mmux_data_x_Result_6_37 : X_LUT4
    generic map(
      INIT => X"0020"
    )
    port map (
      ADR0 => Cpu16_daddr_is(1),
      ADR1 => Cpu16_daddr_is(2),
      ADR2 => Cpu16_I4_iinc_c(6),
      ADR3 => Cpu16_daddr_is(0),
      O => CHOICE1171_F
    );
  Cpu16_I3_n0147_11_19 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => Cpu16_I3_n0090(11),
      ADR1 => Cpu16_I2_TD_c_2_1,
      ADR2 => Cpu16_I2_TD_c_1_1,
      ADR3 => Cpu16_I2_TD_c_0_1,
      O => CHOICE1441_G
    );
  Cpu16_I3_n0147_8_13_SW1 : X_LUT4
    generic map(
      INIT => X"EAEE"
    )
    port map (
      ADR0 => CHOICE1153,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => Cpu16_I3_acc_c_0_8,
      ADR3 => Cpu16_I2_TD_c_3_1,
      O => N30607_F
    );
  Cpu16_I2_idata_c_10 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_idata_c_11_DYMUX,
      CE => Cpu16_I2_idata_c_11_CEINV,
      CLK => Cpu16_I2_idata_c_11_CLKINV,
      SET => GND,
      RST => Cpu16_I2_idata_c_11_FFY_RST,
      O => Cpu16_I2_idata_c(10)
    );
  Cpu16_I2_idata_c_11_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_idata_c_11_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_idata_c_11_FFY_RST
    );
  Cpu16_I3_n0147_8_13_SW2 : X_LUT4
    generic map(
      INIT => X"0408"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_0_1,
      ADR1 => Cpu16_I3_acc_c_0_8,
      ADR2 => Cpu16_I2_TC_c_2_1,
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => N30341_G
    );
  Cpu16_I2_idata_c_11 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_idata_c_11_DXMUX,
      CE => Cpu16_I2_idata_c_11_CEINV,
      CLK => Cpu16_I2_idata_c_11_CLKINV,
      SET => GND,
      RST => Cpu16_I2_idata_c_11_FFX_RST,
      O => Cpu16_I2_idata_c(11)
    );
  Cpu16_I2_idata_c_11_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_idata_c_11_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_idata_c_11_FFX_RST
    );
  Cpu16_I3_n0147_8_72_SW0 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => Cpu16_I3_n0023,
      ADR1 => CHOICE1153,
      ADR2 => CHOICE1131,
      ADR3 => N30714,
      O => N30341_F
    );
  Cpu16_I3_Mmux_data_x_Result_0_85_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"0A0A"
    )
    port map (
      ADR0 => CHOICE1538,
      ADR1 => VCC,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => VCC,
      O => N30814_G
    );
  Cpu16_I2_idata_c_12 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_idata_c_13_DYMUX,
      CE => Cpu16_I2_idata_c_13_CEINV,
      CLK => Cpu16_I2_idata_c_13_CLKINV,
      SET => GND,
      RST => Cpu16_I2_idata_c_13_FFY_RST,
      O => Cpu16_I2_idata_c(12)
    );
  Cpu16_I2_idata_c_13_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_idata_c_13_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_idata_c_13_FFY_RST
    );
  Cpu16_I2_idata_c_13 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_idata_c_13_DXMUX,
      CE => Cpu16_I2_idata_c_13_CEINV,
      CLK => Cpu16_I2_idata_c_13_CLKINV,
      SET => GND,
      RST => Cpu16_I2_idata_c_13_FFX_RST,
      O => Cpu16_I2_idata_c(13)
    );
  Cpu16_I2_idata_c_13_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_idata_c_13_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_idata_c_13_FFX_RST
    );
  Cpu16_I3_n0147_0_207 : X_LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_0_1,
      ADR1 => Cpu16_I3_nreset_v(0),
      ADR2 => Cpu16_I3_n0023,
      ADR3 => Cpu16_I3_nreset_v(1),
      O => CHOICE746_F
    );
  Cpu16_I3_n0147_0_190_SW1 : X_LUT4
    generic map(
      INIT => X"A800"
    )
    port map (
      ADR0 => Cpu16_I2_n01501_1,
      ADR1 => CHOICE740,
      ADR2 => Cpu16_I3_n0100,
      ADR3 => CHOICE255,
      O => N30440_F
    );
  Cpu16_I3_skip_l0 : X_LUT4
    generic map(
      INIT => X"C0C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_skip_i,
      ADR2 => Cpu16_I2_TC_c(2),
      ADR3 => VCC,
      O => CHOICE1587_G
    );
  Cpu16_I3_skip_l82 : X_LUT4
    generic map(
      INIT => X"0A0A"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c(3),
      ADR1 => VCC,
      ADR2 => Cpu16_I2_TC_c(2),
      ADR3 => VCC,
      O => CHOICE1587_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_0_0 : X_LUT4
    generic map(
      INIT => X"AA00"
    )
    port map (
      ADR0 => XLXN_20(0),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => Cpu16_I1_N13634,
      O => CHOICE444_G
    );
  Cpu16_I1_Mmux_saddr_out_Result_5_0 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXN_20(5),
      ADR2 => VCC,
      ADR3 => Cpu16_I1_N13634,
      O => CHOICE444_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_0_1 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_2_46_1,
      ADR1 => Cpu16_I1_pc(0),
      ADR2 => Cpu16_I2_pc_mux_x_0_104_2,
      ADR3 => Cpu16_I2_pc_mux_x_1_44_1,
      O => CHOICE445_G
    );
  Cpu16_I1_Mmux_saddr_out_Result_5_1 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_2_46_1,
      ADR1 => Cpu16_I1_pc(5),
      ADR2 => Cpu16_I2_pc_mux_x_0_104_1,
      ADR3 => Cpu16_I2_pc_mux_x_1_44_1,
      O => CHOICE445_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_1_1 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => Cpu16_I1_pc(1),
      ADR1 => Cpu16_I2_pc_mux_x_0_104_1,
      ADR2 => Cpu16_I2_pc_mux_x_2_46_1,
      ADR3 => Cpu16_I2_pc_mux_x_1_44_1,
      O => CHOICE429_G
    );
  Cpu16_I1_Mmux_saddr_out_Result_2_0 : X_LUT4
    generic map(
      INIT => X"C0C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I1_N13634,
      ADR2 => XLXN_20(2),
      ADR3 => VCC,
      O => CHOICE452_G
    );
  Cpu16_I3_Mmux_data_x_Result_1_114_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FDFF"
    )
    port map (
      ADR0 => Cpu16_I2_data_is_c(1),
      ADR1 => Cpu16_I2_TC_c_0_1,
      ADR2 => Cpu16_I2_TC_c_2_1,
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => N30842_G
    );
  Cpu16_I3_Mmux_data_x_Result_1_114_SW0 : X_LUT4
    generic map(
      INIT => X"DB00"
    )
    port map (
      ADR0 => N31838,
      ADR1 => Cpu16_I2_TD_c(1),
      ADR2 => Cpu16_I2_TD_c_2_3,
      ADR3 => Cpu16_I2_TD_c_0_3,
      O => N30842_F
    );
  ADDR_OUT_EXT_7_OBUF_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_7_OBUF_F,
      O => ADDR_OUT_EXT_7_OBUF
    );
  ADDR_OUT_EXT_7_OBUF_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_7_OBUF_G,
      O => ADDR_OUT_EXT_2_OBUF
    );
  N30299_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30299_F,
      O => N30299
    );
  N30299_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => N30299_G,
      O => N30722
    );
  Cpu16_I3_Madd_n0098_inst_lut2_461 : X_LUT4
    generic map(
      INIT => X"369C"
    )
    port map (
      ADR0 => Cpu16_I3_n0025,
      ADR1 => Cpu16_I3_acc_c_0_2,
      ADR2 => CHOICE1430,
      ADR3 => Cpu16_I2_data_is_c(2),
      O => Cpu16_I3_Madd_n0098_inst_lut2_461_O
    );
  Cpu16_I3_Madd_n0098_inst_lut2_481 : X_LUT4
    generic map(
      INIT => X"569A"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_4,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => CHOICE1287,
      ADR3 => Cpu16_I2_data_is_c(4),
      O => Cpu16_I3_Madd_n0098_inst_lut2_481_O
    );
  Cpu16_I4_ireg_i_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_i_0_DXMUX,
      CE => Cpu16_I4_ireg_i_0_CEINV,
      CLK => Cpu16_I4_ireg_i_0_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_i_0_FFX_RST,
      O => Cpu16_I4_ireg_i(0)
    );
  Cpu16_I4_ireg_i_0_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_ireg_i_0_FFX_RST
    );
  Cpu16_I3_Mmux_data_x_Result_0_85_SW21_G : X_LUT4
    generic map(
      INIT => X"AC53"
    )
    port map (
      ADR0 => Cpu16_I2_data_is_c(0),
      ADR1 => CHOICE1525,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => Cpu16_I3_acc_c_0_0,
      O => N32153
    );
  Cpu16_I4_ireg_x_0_14_G : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_we_c,
      ADR1 => Cpu16_I3_acc_c_0_0_1,
      ADR2 => Cpu16_I4_N18286,
      ADR3 => Cpu16_I4_ireg_c(0),
      O => N32088
    );
  Cpu16_I4_ireg_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_c_1_DYMUX,
      CE => VCC,
      CLK => Cpu16_I4_ireg_c_1_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_c_1_FFY_RST,
      O => Cpu16_I4_ireg_c(0)
    );
  Cpu16_I4_ireg_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_ireg_c_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_ireg_c_1_FFY_RST
    );
  Cpu16_I4_Mmux_n0158_Result_2_1 : X_LUT4
    generic map(
      INIT => X"CCF0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I4_ireg_i(2),
      ADR2 => Cpu16_I4_ireg_x(2),
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I4_Mmux_n0158_Result_2_1_O
    );
  Cpu16_I4_Mmux_n0158_Result_1_1 : X_LUT4
    generic map(
      INIT => X"DD88"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I4_ireg_i(1),
      ADR2 => VCC,
      ADR3 => Cpu16_I4_ireg_x(1),
      O => Cpu16_I4_Mmux_n0158_Result_1_1_O
    );
  Cpu16_I4_ireg_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_c_1_DXMUX,
      CE => VCC,
      CLK => Cpu16_I4_ireg_c_1_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_c_1_FFX_RST,
      O => Cpu16_I4_ireg_c(1)
    );
  Cpu16_I4_ireg_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_ireg_c_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_ireg_c_1_FFX_RST
    );
  Cpu16_I4_ireg_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_c_3_DYMUX,
      CE => VCC,
      CLK => Cpu16_I4_ireg_c_3_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_c_3_FFY_RST,
      O => Cpu16_I4_ireg_c(2)
    );
  Cpu16_I4_ireg_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_ireg_c_3_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_ireg_c_3_FFY_RST
    );
  Cpu16_I4_Mmux_n0158_Result_3_1 : X_LUT4
    generic map(
      INIT => X"DD88"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I4_ireg_i(3),
      ADR2 => VCC,
      ADR3 => Cpu16_I4_ireg_x(3),
      O => Cpu16_I4_Mmux_n0158_Result_3_1_O
    );
  Cpu16_I4_ireg_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_c_3_DXMUX,
      CE => VCC,
      CLK => Cpu16_I4_ireg_c_3_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_c_3_FFX_RST,
      O => Cpu16_I4_ireg_c(3)
    );
  Cpu16_I4_ireg_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_ireg_c_3_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_ireg_c_3_FFX_RST
    );
  Cpu16_I3_n0147_7_39_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FC30"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CHOICE1082,
      ADR2 => N30347,
      ADR3 => N30349,
      O => N31968_F
    );
  Cpu16_I4_Mmux_n0158_Result_4_1 : X_LUT4
    generic map(
      INIT => X"AACC"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_i(4),
      ADR1 => Cpu16_I4_ireg_x(4),
      ADR2 => VCC,
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I4_Mmux_n0158_Result_4_1_O
    );
  Cpu16_I3_Madd_n0098_inst_lut2_571 : X_LUT4
    generic map(
      INIT => X"0F27"
    )
    port map (
      ADR0 => Cpu16_I4_N18350,
      ADR1 => N30808,
      ADR2 => N30806,
      ADR3 => N24841,
      O => Cpu16_I3_Madd_n0098_inst_lut2_57
    );
  Cpu16_I3_Madd_n0098_inst_lut2_541 : X_LUT4
    generic map(
      INIT => X"596A"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_10,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => Cpu16_I2_data_is_c(10),
      ADR3 => CHOICE957,
      O => Cpu16_I3_Madd_n0098_inst_lut2_541_O
    );
  Cpu16_I3_Madd_n0098_inst_lut2_561 : X_LUT4
    generic map(
      INIT => X"02F7"
    )
    port map (
      ADR0 => Cpu16_I4_N18350,
      ADR1 => N30802,
      ADR2 => N24899,
      ADR3 => N30800,
      O => Cpu16_I3_Madd_n0098_inst_lut2_56
    );
  Cpu16_I3_Msub_n0090_inst_lut2_291 : X_LUT4
    generic map(
      INIT => X"C693"
    )
    port map (
      ADR0 => Cpu16_I3_n0025,
      ADR1 => Cpu16_I3_acc_c_0_2,
      ADR2 => Cpu16_I2_data_is_c(2),
      ADR3 => CHOICE1430,
      O => Cpu16_I3_Msub_n0090_inst_lut2_291_O
    );
  Cpu16_I3_Msub_n0090_inst_lut2_341 : X_LUT4
    generic map(
      INIT => X"A695"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_7,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => Cpu16_I2_data_is_c(7),
      ADR3 => CHOICE1122,
      O => Cpu16_I3_Msub_n0090_inst_lut2_341_O
    );
  Cpu16_I3_Msub_n0090_inst_lut2_311 : X_LUT4
    generic map(
      INIT => X"A965"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_4,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => CHOICE1287,
      ADR3 => Cpu16_I2_data_is_c(4),
      O => Cpu16_I3_Msub_n0090_inst_lut2_311_O
    );
  Cpu16_I3_Msub_n0090_inst_lut2_361 : X_LUT4
    generic map(
      INIT => X"C963"
    )
    port map (
      ADR0 => Cpu16_I3_n0025,
      ADR1 => Cpu16_I3_acc_c_0_9,
      ADR2 => CHOICE1012,
      ADR3 => Cpu16_I2_data_is_c(9),
      O => Cpu16_I3_Msub_n0090_inst_lut2_361_O
    );
  NCS_EXT_OUTPUT_OTCLK1INV_1087 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => NCS_EXT_OUTPUT_OTCLK1INV
    );
  NCS_EXT_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_2_nCS_EXT_c,
      O => NCS_EXT_O
    );
  NCS_EXT_OUTPUT_OFF_OSR_USED_1088 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => NCS_EXT_SRINVNOT,
      O => NCS_EXT_OUTPUT_OFF_OSR_USED
    );
  NCS_EXT_OUTPUT_OFF_O1INV_1089 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => NACS_EXT,
      O => NCS_EXT_OUTPUT_OFF_O1INV
    );
  XLXI_2_nCS_EXT_c_1090 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NCS_EXT_OUTPUT_OFF_O1INV,
      CE => VCC,
      CLK => NCS_EXT_OUTPUT_OTCLK1INV,
      SET => NCS_EXT_OUTPUT_OFF_OFF1_SET,
      RST => GND,
      O => XLXI_2_nCS_EXT_c
    );
  NCS_EXT_OUTPUT_OFF_OFF1_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => NCS_EXT_OUTPUT_OFF_OSR_USED,
      O => NCS_EXT_OUTPUT_OFF_OFF1_SET
    );
  Cpu16_I3_Msub_n0090_inst_lut2_401 : X_LUT4
    generic map(
      INIT => X"B8AA"
    )
    port map (
      ADR0 => N30287,
      ADR1 => N24841,
      ADR2 => N30289,
      ADR3 => Cpu16_I4_N18350,
      O => Cpu16_I3_Msub_n0090_inst_lut2_40
    );
  Cpu16_I3_Msub_n0090_inst_lut2_391 : X_LUT4
    generic map(
      INIT => X"ACAA"
    )
    port map (
      ADR0 => N30281,
      ADR1 => N30283,
      ADR2 => N24899,
      ADR3 => Cpu16_I4_N18350,
      O => Cpu16_I3_Msub_n0090_inst_lut2_39
    );
  Cpu16_I3_Msub_n0090_inst_lut2_411 : X_LUT4
    generic map(
      INIT => X"CACC"
    )
    port map (
      ADR0 => N30494,
      ADR1 => N30492,
      ADR2 => N24783,
      ADR3 => Cpu16_I4_N18350,
      O => Cpu16_I3_Msub_n0090_inst_lut2_41
    );
  Cpu16_I1_iaddr_x_8_47 : X_LUT4
    generic map(
      INIT => X"F0E0"
    )
    port map (
      ADR0 => Cpu16_I1_N13702,
      ADR1 => CHOICE530,
      ADR2 => Cpu16_I1_n0010,
      ADR3 => Cpu16_I1_iaddr_x_8_14_O,
      O => Cpu16_I1_pc_8_F
    );
  Cpu16_I2_int_stop_x27 : X_LUT4
    generic map(
      INIT => X"C8C0"
    )
    port map (
      ADR0 => Cpu16_I2_C_rti,
      ADR1 => Cpu16_I2_nreset_v_1_1,
      ADR2 => CHOICE47,
      ADR3 => CHOICE52,
      O => Cpu16_I2_int_stop_c_G
    );
  Cpu16_I3_n0147_9_39_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"F3C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CHOICE1192,
      ADR2 => N30337,
      ADR3 => N30335,
      O => N31976_F
    );
  Cpu16_I1_pc_8 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_pc_8_DXMUX,
      CE => VCC,
      CLK => Cpu16_I1_pc_8_CLKINV,
      SET => GND,
      RST => Cpu16_I1_pc_8_FFX_RST,
      O => Cpu16_I1_pc(8)
    );
  Cpu16_I1_pc_8_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I1_pc_8_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I1_pc_8_FFX_RST
    );
  Cpu16_I3_skip_l86_SW0 : X_LUT4
    generic map(
      INIT => X"CDCF"
    )
    port map (
      ADR0 => CHOICE1587,
      ADR1 => Cpu16_I2_int_start_c,
      ADR2 => CHOICE1565,
      ADR3 => CHOICE1584,
      O => N31120_F
    );
  Cpu16_I2_n01011 : X_LUT4
    generic map(
      INIT => X"0207"
    )
    port map (
      ADR0 => Cpu16_I2_n0150,
      ADR1 => Cpu16_I2_n01011_SW3_O,
      ADR2 => Cpu16_I2_skip_x,
      ADR3 => N31252,
      O => Cpu16_I2_C_mem_x_F
    );
  Cpu16_I2_int_stop_c_1091 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_int_stop_c_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_int_stop_c_CLKINV,
      SET => GND,
      RST => Cpu16_I2_int_stop_c_FFY_RST,
      O => Cpu16_I2_int_stop_c
    );
  Cpu16_I2_int_stop_c_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_int_stop_c_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_int_stop_c_FFY_RST
    );
  Cpu16_I1_iaddr_x_1_5 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_0_104_2,
      ADR1 => Cpu16_I2_pc_mux_x_2_46_2,
      ADR2 => Cpu16_pc_mux(1),
      ADR3 => XLXN_20(1),
      O => Cpu16_I1_pc_1_G
    );
  Cpu16_I4_ireg_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_c_5_DYMUX,
      CE => VCC,
      CLK => Cpu16_I4_ireg_c_5_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_c_5_FFY_RST,
      O => Cpu16_I4_ireg_c(4)
    );
  Cpu16_I4_ireg_c_5_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_ireg_c_5_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_ireg_c_5_FFY_RST
    );
  Cpu16_I3_Msub_n0090_inst_lut2_271 : X_LUT4
    generic map(
      INIT => X"EA2A"
    )
    port map (
      ADR0 => Cpu16_I3_Mmux_data_x_Result_0_85_SW0_O,
      ADR1 => CHOICE1525,
      ADR2 => Cpu16_I4_N18018,
      ADR3 => N30542,
      O => Cpu16_I3_Msub_n0090_inst_lut2_27_F
    );
  Cpu16_I4_Mmux_n0158_Result_5_1 : X_LUT4
    generic map(
      INIT => X"CCAA"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_x(5),
      ADR1 => Cpu16_I4_ireg_i(5),
      ADR2 => VCC,
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I4_Mmux_n0158_Result_5_1_O
    );
  Cpu16_I4_ireg_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_c_5_DXMUX,
      CE => VCC,
      CLK => Cpu16_I4_ireg_c_5_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_c_5_FFX_RST,
      O => Cpu16_I4_ireg_c(5)
    );
  Cpu16_I4_ireg_c_5_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_ireg_c_5_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_ireg_c_5_FFX_RST
    );
  Cpu16_I4_Mmux_n0158_Result_6_1 : X_LUT4
    generic map(
      INIT => X"AAF0"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_i(6),
      ADR1 => VCC,
      ADR2 => Cpu16_I4_ireg_x(6),
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I4_Mmux_n0158_Result_6_1_O
    );
  Cpu16_I1_iaddr_x_1_55 : X_LUT4
    generic map(
      INIT => X"C4C0"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_2_46_2,
      ADR1 => Cpu16_I1_n0010,
      ADR2 => Cpu16_I1_iaddr_x_1_5_O,
      ADR3 => N31168,
      O => Cpu16_I1_pc_1_F
    );
  Cpu16_I1_pc_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_pc_1_DXMUX,
      CE => VCC,
      CLK => Cpu16_I1_pc_1_CLKINV,
      SET => GND,
      RST => Cpu16_I1_pc_1_FFX_RST,
      O => Cpu16_I1_pc(1)
    );
  Cpu16_I1_pc_1_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I1_pc_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I1_pc_1_FFX_RST
    );
  Cpu16_I2_ndre_x1_SW6_SW0_SW0_SW1 : X_LUT4
    generic map(
      INIT => X"C080"
    )
    port map (
      ADR0 => MEM_DATA_OUT(1),
      ADR1 => NRESET_IN_BUFGP,
      ADR2 => Cpu16_I4_nreset_v(1),
      ADR3 => MEM_DATA_OUT(2),
      O => N31409_G
    );
  Cpu16_I4_ireg_c_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_c_7_DYMUX,
      CE => VCC,
      CLK => Cpu16_I4_ireg_c_7_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_c_7_FFY_RST,
      O => Cpu16_I4_ireg_c(6)
    );
  Cpu16_I4_ireg_c_7_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_ireg_c_7_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_ireg_c_7_FFY_RST
    );
  Cpu16_I1_iaddr_x_1_44_SW01_G : X_LUT4
    generic map(
      INIT => X"ACAC"
    )
    port map (
      ADR0 => MEM_DATA_OUT(5),
      ADR1 => Cpu16_I1_n0009(1),
      ADR2 => Cpu16_pc_mux(1),
      ADR3 => VCC,
      O => N32083
    );
  Cpu16_I3_Ker1725810_F : X_LUT4
    generic map(
      INIT => X"E8FB"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I2_TC_c_0_1,
      ADR3 => N31797,
      O => N32046
    );
  Cpu16_I3_Mmux_data_x_Result_0_37_G : X_LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      ADR0 => MEM_DATA_OUT(5),
      ADR1 => Cpu16_I4_iinc_c(0),
      ADR2 => MEM_DATA_OUT(6),
      ADR3 => MEM_DATA_OUT(4),
      O => N32028
    );
  XLXI_3_maddr_1_16_F : X_LUT4
    generic map(
      INIT => X"E444"
    )
    port map (
      ADR0 => CPU_NDRE,
      ADR1 => CPU_ADADDR_OUT(1),
      ADR2 => XLXI_3_N12472,
      ADR3 => XLXI_3_daddr_c(1),
      O => N32031
    );
  XLXI_3_maddr_1_16_G : X_LUT4
    generic map(
      INIT => X"EE4E"
    )
    port map (
      ADR0 => CPU_NDRE,
      ADR1 => CPU_ADADDR_OUT(1),
      ADR2 => XLXI_3_N12472,
      ADR3 => XLXI_3_daddr_c(1),
      O => N32033
    );
  XLXI_3_maddr_2_16_G : X_LUT4
    generic map(
      INIT => X"FA3A"
    )
    port map (
      ADR0 => CPU_ADADDR_OUT(2),
      ADR1 => XLXI_3_N12472,
      ADR2 => CPU_NDRE,
      ADR3 => XLXI_3_daddr_c(2),
      O => N32068
    );
  Cpu16_I3_n0147_0_130_G : X_LUT4
    generic map(
      INIT => X"1098"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_0_3,
      ADR1 => Cpu16_I2_TD_c_2_3,
      ADR2 => Cpu16_I3_acc_c_0_1,
      ADR3 => Cpu16_I3_acc_c_0_0,
      O => N32043
    );
  Cpu16_I1_iaddr_x_2_44_SW01_G : X_LUT4
    generic map(
      INIT => X"E2E2"
    )
    port map (
      ADR0 => Cpu16_I1_n0009(2),
      ADR1 => Cpu16_pc_mux(1),
      ADR2 => MEM_DATA_OUT(6),
      ADR3 => VCC,
      O => N32163
    );
  XLXI_3_maddr_3_161_F : X_LUT4
    generic map(
      INIT => X"D580"
    )
    port map (
      ADR0 => CPU_NDRE,
      ADR1 => XLXI_3_daddr_c(3),
      ADR2 => XLXI_3_N12472,
      ADR3 => CPU_ADADDR_OUT(3),
      O => N32101
    );
  Cpu16_I2_TC_x_1_1 : X_LUT4
    generic map(
      INIT => X"F080"
    )
    port map (
      ADR0 => Cpu16_I2_idata_x(0),
      ADR1 => Cpu16_I2_n0077,
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => Cpu16_I2_idata_x(3),
      O => Cpu16_I2_TC_c_1_1_G
    );
  Cpu16_I4_ireg_c_10 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_c_11_DYMUX,
      CE => VCC,
      CLK => Cpu16_I4_ireg_c_11_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_c_11_FFY_RST,
      O => Cpu16_I4_ireg_c(10)
    );
  Cpu16_I4_ireg_c_11_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_ireg_c_11_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_ireg_c_11_FFY_RST
    );
  Cpu16_I4_Mmux_n0158_Result_11_1 : X_LUT4
    generic map(
      INIT => X"AAF0"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_i(11),
      ADR1 => VCC,
      ADR2 => Cpu16_I4_ireg_x(11),
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I4_Mmux_n0158_Result_11_1_O
    );
  Cpu16_I4_ireg_c_11 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_c_11_DXMUX,
      CE => VCC,
      CLK => Cpu16_I4_ireg_c_11_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_c_11_FFX_RST,
      O => Cpu16_I4_ireg_c(11)
    );
  Cpu16_I4_ireg_c_11_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_ireg_c_11_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_ireg_c_11_FFX_RST
    );
  Cpu16_I2_TC_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TC_c_1_1_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_TC_c_1_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TC_c_1_1_FFY_RST,
      O => Cpu16_I2_TC_c(1)
    );
  Cpu16_I2_TC_c_1_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TC_c_1_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TC_c_1_1_FFY_RST
    );
  Cpu16_I2_n00991 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => N30430,
      ADR1 => N31146,
      ADR2 => Cpu16_I2_TC_x(0),
      ADR3 => Cpu16_I2_TC_x(1),
      O => Cpu16_I2_TC_c_1_1_F
    );
  Cpu16_I1_ipop_out1 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_0_104_2,
      ADR1 => Cpu16_I2_pc_mux_x_2_46_2,
      ADR2 => Cpu16_I1_n0010,
      ADR3 => Cpu16_I2_pc_mux_x_1_44_2,
      O => XLXI_4_addr_c_7_G
    );
  Cpu16_I2_TC_c_1_1_1092 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TC_c_1_1_DXMUX,
      CE => VCC,
      CLK => Cpu16_I2_TC_c_1_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TC_c_1_1_FFX_RST,
      O => Cpu16_I2_TC_c_1_1
    );
  Cpu16_I2_TC_c_1_1_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TC_c_1_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TC_c_1_1_FFX_RST
    );
  Cpu16_I4_ireg_x_9_14_G : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_9,
      ADR1 => Cpu16_I4_ireg_we_c,
      ADR2 => Cpu16_I4_N18286,
      ADR3 => Cpu16_I4_ireg_c(9),
      O => N32078
    );
  Cpu16_I2_n01421_G : X_LUT4
    generic map(
      INIT => X"2020"
    )
    port map (
      ADR0 => MEM_DATA_OUT(7),
      ADR1 => MEM_DATA_OUT(5),
      ADR2 => MEM_DATA_OUT(6),
      ADR3 => VCC,
      O => N32038
    );
  Cpu16_I4_ireg_i_9 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_i_9_DXMUX,
      CE => Cpu16_I4_ireg_i_9_CEINV,
      CLK => Cpu16_I4_ireg_i_9_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_i_9_FFX_RST,
      O => Cpu16_I4_ireg_i(9)
    );
  Cpu16_I4_ireg_i_9_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_ireg_i_9_FFX_RST
    );
  Cpu16_I3_skip_l86_SW11_G : X_LUT4
    generic map(
      INIT => X"F1F0"
    )
    port map (
      ADR0 => CHOICE1584,
      ADR1 => CHOICE1565,
      ADR2 => Cpu16_I2_int_start_c,
      ADR3 => Cpu16_I2_TD_c(0),
      O => N32158
    );
  XLXI_3_maddr_0_16_G : X_LUT4
    generic map(
      INIT => X"DFD0"
    )
    port map (
      ADR0 => XLXI_3_N12472,
      ADR1 => XLXI_3_daddr_c(0),
      ADR2 => CPU_NDRE,
      ADR3 => CPU_ADADDR_OUT(0),
      O => N32133
    );
  Cpu16_I3_Mmux_data_x_Result_0_37_F : X_LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(4),
      ADR1 => Cpu16_I4_iinc_c(0),
      ADR2 => Cpu16_I2_idata_c(5),
      ADR3 => Cpu16_I2_idata_c(6),
      O => N32026
    );
  NWE_EXT_OUTPUT_OTCLK1INV_1093 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_BUFGP,
      O => NWE_EXT_OUTPUT_OTCLK1INV
    );
  NWE_EXT_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => XLXI_5_ndwe_c,
      O => NWE_EXT_O
    );
  NWE_EXT_OUTPUT_OFF_OSR_USED_1094 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => NWE_EXT_SRINVNOT,
      O => NWE_EXT_OUTPUT_OFF_OSR_USED
    );
  NWE_EXT_OUTPUT_OFF_OCEINV : X_INV
    port map (
      I => XLXI_5_dw_s(0),
      O => NWE_EXT_OUTPUT_OFF_OCEINVNOT
    );
  NWE_EXT_OUTPUT_OFF_O1INV_1095 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_NADWE,
      O => NWE_EXT_OUTPUT_OFF_O1INV
    );
  XLXI_5_ndwe_c_1096 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => NWE_EXT_OUTPUT_OFF_O1INV,
      CE => NWE_EXT_OUTPUT_OFF_OCEINVNOT,
      CLK => NWE_EXT_OUTPUT_OTCLK1INV,
      SET => NWE_EXT_OUTPUT_OFF_OFF1_SET,
      RST => GND,
      O => XLXI_5_ndwe_c
    );
  NWE_EXT_OUTPUT_OFF_OFF1_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => NWE_EXT_OUTPUT_OFF_OSR_USED,
      O => NWE_EXT_OUTPUT_OFF_OFF1_SET
    );
  Cpu16_I4_ireg_i_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_i_5_DXMUX,
      CE => Cpu16_I4_ireg_i_5_CEINV,
      CLK => Cpu16_I4_ireg_i_5_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_i_5_FFX_RST,
      O => Cpu16_I4_ireg_i(5)
    );
  Cpu16_I4_ireg_i_5_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_ireg_i_5_FFX_RST
    );
  Cpu16_I4_ireg_x_6_14_G : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_6,
      ADR1 => Cpu16_I4_N18286,
      ADR2 => Cpu16_I4_ireg_we_c,
      ADR3 => Cpu16_I4_ireg_c(6),
      O => N32063
    );
  Cpu16_I4_ireg_x_8_14_F : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => Cpu16_I4_n0182(8),
      ADR1 => Cpu16_I4_N18286,
      ADR2 => Cpu16_I4_ireg_we_c,
      ADR3 => Cpu16_I3_acc_c_0_8,
      O => N32096
    );
  Cpu16_I3_n0147_0_82_SW11_G : X_LUT4
    generic map(
      INIT => X"FAF8"
    )
    port map (
      ADR0 => Cpu16_I3_n0023,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => CHOICE746,
      ADR3 => CHOICE740,
      O => N32053
    );
  Cpu16_I4_ireg_x_7_14_F : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => Cpu16_I4_n0182(7),
      ADR1 => Cpu16_I3_acc_c_0_7,
      ADR2 => Cpu16_I4_ireg_we_c,
      ADR3 => Cpu16_I4_N18286,
      O => N32056
    );
  Cpu16_I4_ireg_i_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_i_6_DXMUX,
      CE => Cpu16_I4_ireg_i_6_CEINV,
      CLK => Cpu16_I4_ireg_i_6_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_i_6_FFX_RST,
      O => Cpu16_I4_ireg_i(6)
    );
  Cpu16_I4_ireg_i_6_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_ireg_i_6_FFX_RST
    );
  Cpu16_I4_ireg_x_7_14_G : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_c(7),
      ADR1 => Cpu16_I3_acc_c_0_7,
      ADR2 => Cpu16_I4_ireg_we_c,
      ADR3 => Cpu16_I4_N18286,
      O => N32058
    );
  Cpu16_I4_ireg_x_9_14_F : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_9,
      ADR1 => Cpu16_I4_n0182(9),
      ADR2 => Cpu16_I4_ireg_we_c,
      ADR3 => Cpu16_I4_N18286,
      O => N32076
    );
  Cpu16_I4_ireg_i_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_i_7_DXMUX,
      CE => Cpu16_I4_ireg_i_7_CEINV,
      CLK => Cpu16_I4_ireg_i_7_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_i_7_FFX_RST,
      O => Cpu16_I4_ireg_i(7)
    );
  Cpu16_I4_ireg_i_7_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_ireg_i_7_FFX_RST
    );
  Cpu16_I4_ireg_x_8_14_G : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_c(8),
      ADR1 => Cpu16_I4_N18286,
      ADR2 => Cpu16_I4_ireg_we_c,
      ADR3 => Cpu16_I3_acc_c_0_8,
      O => N32098
    );
  Cpu16_I4_ireg_i_8 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_i_8_DXMUX,
      CE => Cpu16_I4_ireg_i_8_CEINV,
      CLK => Cpu16_I4_ireg_i_8_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_i_8_FFX_RST,
      O => Cpu16_I4_ireg_i(8)
    );
  Cpu16_I4_ireg_i_8_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_ireg_i_8_FFX_RST
    );
  Cpu16_I4_ireg_x_1_14_G : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => Cpu16_I4_N18286,
      ADR1 => Cpu16_I4_ireg_c(1),
      ADR2 => Cpu16_I3_acc_c_0_1,
      ADR3 => Cpu16_I4_ireg_we_c,
      O => N32118
    );
  Cpu16_I4_ireg_x_2_14_F : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_we_c,
      ADR1 => Cpu16_I4_n0182(2),
      ADR2 => Cpu16_I4_N18286,
      ADR3 => Cpu16_I3_acc_c_0_2,
      O => N32111
    );
  Cpu16_I4_ireg_x_10_14_F : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => Cpu16_I4_N18286,
      ADR1 => Cpu16_I3_acc_c_0_10,
      ADR2 => Cpu16_I4_ireg_we_c,
      ADR3 => Cpu16_I4_n0182(10),
      O => N32091
    );
  Cpu16_I4_ireg_i_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_i_1_DXMUX,
      CE => Cpu16_I4_ireg_i_1_CEINV,
      CLK => Cpu16_I4_ireg_i_1_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_i_1_FFX_RST,
      O => Cpu16_I4_ireg_i(1)
    );
  Cpu16_I4_ireg_i_1_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_ireg_i_1_FFX_RST
    );
  Cpu16_I4_ireg_x_10_14_G : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => Cpu16_I4_N18286,
      ADR1 => Cpu16_I3_acc_c_0_10,
      ADR2 => Cpu16_I4_ireg_we_c,
      ADR3 => Cpu16_I4_ireg_c(10),
      O => N32093
    );
  Cpu16_I4_ireg_i_10 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_i_10_DXMUX,
      CE => Cpu16_I4_ireg_i_10_CEINV,
      CLK => Cpu16_I4_ireg_i_10_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_i_10_FFX_RST,
      O => Cpu16_I4_ireg_i(10)
    );
  Cpu16_I4_ireg_i_10_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_ireg_i_10_FFX_RST
    );
  Cpu16_I4_ireg_x_11_14_F : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => Cpu16_I4_n0182(11),
      ADR1 => Cpu16_I4_ireg_we_c,
      ADR2 => Cpu16_I4_N18286,
      ADR3 => Cpu16_I3_acc_c_0_11,
      O => N32136
    );
  Cpu16_I4_ireg_x_2_14_G : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_we_c,
      ADR1 => Cpu16_I4_ireg_c(2),
      ADR2 => Cpu16_I4_N18286,
      ADR3 => Cpu16_I3_acc_c_0_2,
      O => N32113
    );
  Cpu16_I4_ireg_i_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_i_2_DXMUX,
      CE => Cpu16_I4_ireg_i_2_CEINV,
      CLK => Cpu16_I4_ireg_i_2_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_i_2_FFX_RST,
      O => Cpu16_I4_ireg_i(2)
    );
  Cpu16_I4_ireg_i_2_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_ireg_i_2_FFX_RST
    );
  Cpu16_I4_ireg_x_11_14_G : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_c(11),
      ADR1 => Cpu16_I4_ireg_we_c,
      ADR2 => Cpu16_I4_N18286,
      ADR3 => Cpu16_I3_acc_c_0_11,
      O => N32138
    );
  Cpu16_I4_ireg_x_3_14_F : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_we_c,
      ADR1 => Cpu16_I3_acc_c_0_3,
      ADR2 => Cpu16_I4_N18286,
      ADR3 => Cpu16_I4_n0182(3),
      O => N32071
    );
  Cpu16_I4_Mmux_n0158_Result_7_1 : X_LUT4
    generic map(
      INIT => X"CCAA"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_x(7),
      ADR1 => Cpu16_I4_ireg_i(7),
      ADR2 => VCC,
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I4_Mmux_n0158_Result_7_1_O
    );
  Cpu16_I4_ireg_c_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_c_7_DXMUX,
      CE => VCC,
      CLK => Cpu16_I4_ireg_c_7_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_c_7_FFX_RST,
      O => Cpu16_I4_ireg_c(7)
    );
  Cpu16_I4_ireg_c_7_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_ireg_c_7_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_ireg_c_7_FFX_RST
    );
  Cpu16_I4_Mmux_n0158_Result_8_1 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I4_ireg_i(8),
      ADR2 => Cpu16_I4_ireg_x(8),
      ADR3 => VCC,
      O => Cpu16_I4_Mmux_n0158_Result_8_1_O
    );
  Cpu16_I4_ireg_c_8 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_c_9_DYMUX,
      CE => VCC,
      CLK => Cpu16_I4_ireg_c_9_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_c_9_FFY_RST,
      O => Cpu16_I4_ireg_c(8)
    );
  Cpu16_I4_ireg_c_9_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_ireg_c_9_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_ireg_c_9_FFY_RST
    );
  Cpu16_I4_Mmux_n0158_Result_9_1 : X_LUT4
    generic map(
      INIT => X"FA50"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => VCC,
      ADR2 => Cpu16_I4_ireg_x(9),
      ADR3 => Cpu16_I4_ireg_i(9),
      O => Cpu16_I4_Mmux_n0158_Result_9_1_O
    );
  Cpu16_I4_ireg_c_9 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_c_9_DXMUX,
      CE => VCC,
      CLK => Cpu16_I4_ireg_c_9_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_c_9_FFX_RST,
      O => Cpu16_I4_ireg_c(9)
    );
  Cpu16_I4_ireg_c_9_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_ireg_c_9_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_ireg_c_9_FFX_RST
    );
  Cpu16_I2_ndre_x1_SW6_SW0_SW0_SW2 : X_LUT4
    generic map(
      INIT => X"ABFB"
    )
    port map (
      ADR0 => N30269,
      ADR1 => N31376,
      ADR2 => Cpu16_I2_n01501_2,
      ADR3 => Cpu16_I2_ndre_x1_SW6_SW0_SW0_SW1_O,
      O => N31409_F
    );
  Cpu16_I1_iaddr_x_3_14 : X_LUT4
    generic map(
      INIT => X"3022"
    )
    port map (
      ADR0 => Cpu16_I1_pc(3),
      ADR1 => Cpu16_I2_pc_mux_x_1_44_2,
      ADR2 => Cpu16_I1_n0009(3),
      ADR3 => Cpu16_I2_pc_mux_x_0_104_2,
      O => CHOICE497_F
    );
  Cpu16_I1_iaddr_x_2_5 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_0_104_2,
      ADR1 => XLXN_20(2),
      ADR2 => Cpu16_I2_pc_mux_x_1_44_2,
      ADR3 => Cpu16_I2_pc_mux_x_2_46_2,
      O => Cpu16_I1_pc_2_G
    );
  Cpu16_I1_Ker137001 : X_LUT4
    generic map(
      INIT => X"0CCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_pc_mux(2),
      ADR2 => Cpu16_pc_mux(1),
      ADR3 => Cpu16_pc_mux(0),
      O => Cpu16_I1_pc_3_G
    );
  Cpu16_I1_iaddr_x_2_55 : X_LUT4
    generic map(
      INIT => X"88C8"
    )
    port map (
      ADR0 => Cpu16_I1_iaddr_x_2_5_O,
      ADR1 => Cpu16_I1_n0010,
      ADR2 => N31164,
      ADR3 => Cpu16_I2_pc_mux_x_2_46_2,
      O => Cpu16_I1_pc_2_F
    );
  Cpu16_I1_pc_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_pc_2_DXMUX,
      CE => VCC,
      CLK => Cpu16_I1_pc_2_CLKINV,
      SET => GND,
      RST => Cpu16_I1_pc_2_FFX_RST,
      O => Cpu16_I1_pc(2)
    );
  Cpu16_I1_pc_2_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I1_pc_2_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I1_pc_2_FFX_RST
    );
  Cpu16_I1_iaddr_x_3_47 : X_LUT4
    generic map(
      INIT => X"CCC8"
    )
    port map (
      ADR0 => CHOICE502,
      ADR1 => Cpu16_I1_n0010,
      ADR2 => Cpu16_I1_N13702,
      ADR3 => CHOICE497,
      O => Cpu16_I1_pc_3_F
    );
  Cpu16_I2_E_c_FFd3_In1 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => Cpu16_I2_N15717,
      ADR1 => Cpu16_I2_N15618,
      ADR2 => Cpu16_I2_TC_c(0),
      ADR3 => N31104,
      O => Cpu16_I2_E_c_FFd3_G
    );
  Cpu16_I1_pc_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_pc_3_DXMUX,
      CE => VCC,
      CLK => Cpu16_I1_pc_3_CLKINV,
      SET => GND,
      RST => Cpu16_I1_pc_3_FFX_RST,
      O => Cpu16_I1_pc(3)
    );
  Cpu16_I1_pc_3_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I1_pc_3_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I1_pc_3_FFX_RST
    );
  Cpu16_I2_E_c_FFd3_1097 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_E_c_FFd3_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_E_c_FFd3_CLKINV,
      SET => GND,
      RST => Cpu16_I2_E_c_FFd3_FFY_RST,
      O => Cpu16_I2_E_c_FFd3
    );
  Cpu16_I2_E_c_FFd3_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_E_c_FFd3_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_E_c_FFd3_FFY_RST
    );
  Cpu16_I2_Ker156731_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"ECFF"
    )
    port map (
      ADR0 => Cpu16_I2_N15561,
      ADR1 => Cpu16_I2_n0062,
      ADR2 => XLXI_3_a2vi_s(0),
      ADR3 => Cpu16_I2_nreset_v(1),
      O => Cpu16_I2_E_c_FFd3_F
    );
  Cpu16_I4_ireg_x_1_14_F : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => Cpu16_I4_n0182(1),
      ADR1 => Cpu16_I4_N18286,
      ADR2 => Cpu16_I3_acc_c_0_1,
      ADR3 => Cpu16_I4_ireg_we_c,
      O => N32116
    );
  Cpu16_I1_iaddr_x_7_14 : X_LUT4
    generic map(
      INIT => X"00D8"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_0_104_2,
      ADR1 => Cpu16_I1_n0009(7),
      ADR2 => Cpu16_I1_pc(7),
      ADR3 => Cpu16_I2_pc_mux_x_1_44_2,
      O => Cpu16_I1_pc_7_G
    );
  Cpu16_I1_iaddr_x_10_47 : X_LUT4
    generic map(
      INIT => X"CCC8"
    )
    port map (
      ADR0 => CHOICE378,
      ADR1 => Cpu16_I1_n0010,
      ADR2 => Cpu16_I1_N13702,
      ADR3 => Cpu16_I1_iaddr_x_10_14_O,
      O => Cpu16_I1_iaddr_x_10_47_O
    );
  Cpu16_I1_pc_10 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_pc_10_DXMUX,
      CE => VCC,
      CLK => Cpu16_I1_pc_10_CLKINV,
      SET => GND,
      RST => Cpu16_I1_pc_10_FFX_RST,
      O => Cpu16_I1_pc(10)
    );
  Cpu16_I1_pc_10_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I1_pc_10_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I1_pc_10_FFX_RST
    );
  Cpu16_I1_iaddr_x_7_47 : X_LUT4
    generic map(
      INIT => X"F0E0"
    )
    port map (
      ADR0 => CHOICE516,
      ADR1 => Cpu16_I1_N13702,
      ADR2 => Cpu16_I1_n0010,
      ADR3 => Cpu16_I1_iaddr_x_7_14_O,
      O => Cpu16_I1_pc_7_F
    );
  Cpu16_I1_iaddr_x_11_14 : X_LUT4
    generic map(
      INIT => X"5410"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_1_44_1,
      ADR1 => Cpu16_I2_pc_mux_x_0_104_1,
      ADR2 => Cpu16_I1_pc(11),
      ADR3 => Cpu16_I1_n0009(11),
      O => Cpu16_I1_pc_11_G
    );
  Cpu16_I1_pc_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_pc_7_DXMUX,
      CE => VCC,
      CLK => Cpu16_I1_pc_7_CLKINV,
      SET => GND,
      RST => Cpu16_I1_pc_7_FFX_RST,
      O => Cpu16_I1_pc(7)
    );
  Cpu16_I1_pc_7_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I1_pc_7_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I1_pc_7_FFX_RST
    );
  Cpu16_I1_iaddr_x_11_47 : X_LUT4
    generic map(
      INIT => X"F0E0"
    )
    port map (
      ADR0 => Cpu16_I1_N13702,
      ADR1 => Cpu16_I1_iaddr_x_11_14_O,
      ADR2 => Cpu16_I1_n0010,
      ADR3 => CHOICE364,
      O => Cpu16_I1_iaddr_x_11_47_O
    );
  Cpu16_I1_iaddr_x_8_14 : X_LUT4
    generic map(
      INIT => X"00E4"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_0_104_2,
      ADR1 => Cpu16_I1_pc(8),
      ADR2 => Cpu16_I1_n0009(8),
      ADR3 => Cpu16_I2_pc_mux_x_1_44_2,
      O => Cpu16_I1_pc_8_G
    );
  Cpu16_I1_pc_11 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_pc_11_DXMUX,
      CE => VCC,
      CLK => Cpu16_I1_pc_11_CLKINV,
      SET => GND,
      RST => Cpu16_I1_pc_11_FFX_RST,
      O => Cpu16_I1_pc(11)
    );
  Cpu16_I1_pc_11_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I1_pc_11_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I1_pc_11_FFX_RST
    );
  Cpu16_I1_iaddr_x_5_47 : X_LUT4
    generic map(
      INIT => X"CCC8"
    )
    port map (
      ADR0 => CHOICE558,
      ADR1 => Cpu16_I1_n0010,
      ADR2 => Cpu16_I1_iaddr_x_5_14_O,
      ADR3 => Cpu16_I1_N13702,
      O => Cpu16_I1_pc_5_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_10_20 : X_LUT4
    generic map(
      INIT => X"FCF8"
    )
    port map (
      ADR0 => CHOICE485,
      ADR1 => Cpu16_I1_n0010,
      ADR2 => CHOICE484,
      ADR3 => Cpu16_I1_Mmux_saddr_out_Result_10_6_O,
      O => XLXN_14_10_F
    );
  Cpu16_I1_pc_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_pc_5_DXMUX,
      CE => VCC,
      CLK => Cpu16_I1_pc_5_CLKINV,
      SET => GND,
      RST => Cpu16_I1_pc_5_FFX_RST,
      O => Cpu16_I1_pc(5)
    );
  Cpu16_I1_pc_5_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I1_pc_5_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I1_pc_5_FFX_RST
    );
  XLXI_5_Mmux_n0016_Result34 : X_LUT4
    generic map(
      INIT => X"0707"
    )
    port map (
      ADR0 => CPU_NDRE,
      ADR1 => CPU_NADWE,
      ADR2 => XLXI_5_dw_s(0),
      ADR3 => VCC,
      O => CHOICE589_F
    );
  Cpu16_I1_iaddr_x_6_14 : X_LUT4
    generic map(
      INIT => X"2320"
    )
    port map (
      ADR0 => Cpu16_I1_n0009(6),
      ADR1 => Cpu16_I2_pc_mux_x_1_44_2,
      ADR2 => Cpu16_I2_pc_mux_x_0_104_2,
      ADR3 => Cpu16_I1_pc(6),
      O => Cpu16_I1_pc_6_G
    );
  Cpu16_I1_Mmux_saddr_out_Result_11_20 : X_LUT4
    generic map(
      INIT => X"FCEC"
    )
    port map (
      ADR0 => CHOICE397,
      ADR1 => CHOICE396,
      ADR2 => Cpu16_I1_n0010,
      ADR3 => Cpu16_I1_Mmux_saddr_out_Result_11_6_O,
      O => XLXN_14_11_F
    );
  Cpu16_I1_iaddr_x_6_47 : X_LUT4
    generic map(
      INIT => X"F0E0"
    )
    port map (
      ADR0 => Cpu16_I1_N13702,
      ADR1 => CHOICE544,
      ADR2 => Cpu16_I1_n0010,
      ADR3 => Cpu16_I1_iaddr_x_6_14_O,
      O => Cpu16_I1_pc_6_F
    );
  Cpu16_I1_pc_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_pc_6_DXMUX,
      CE => VCC,
      CLK => Cpu16_I1_pc_6_CLKINV,
      SET => GND,
      RST => Cpu16_I1_pc_6_FFX_RST,
      O => Cpu16_I1_pc(6)
    );
  Cpu16_I1_pc_6_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I1_pc_6_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I1_pc_6_FFX_RST
    );
  XLXI_4_Mmux_addr_x_Result_7_1 : X_LUT4
    generic map(
      INIT => X"AAAC"
    )
    port map (
      ADR0 => XLXI_4_n0005(15),
      ADR1 => XLXI_4_addr_c(7),
      ADR2 => XLXN_2,
      ADR3 => XLXN_1,
      O => XLXI_4_addr_c_7_F
    );
  XLXI_4_addr_c_7 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_4_addr_c_7_DXMUX,
      CE => VCC,
      CLK => XLXI_4_addr_c_7_CLKINV,
      SET => XLXI_4_addr_c_7_FFX_SET,
      RST => GND,
      O => XLXI_4_addr_c(7)
    );
  XLXI_4_addr_c_7_FFX_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_4_addr_c_7_SRINVNOT,
      O => XLXI_4_addr_c_7_FFX_SET
    );
  XLXI_5_Mmux_n0016_Result43 : X_LUT4
    generic map(
      INIT => X"FF80"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => CPU_ADADDR_OUT(9),
      ADR2 => CHOICE589,
      ADR3 => CHOICE583,
      O => XLXI_5_Mmux_n0016_Result43_O
    );
  XLXI_5_dw_s_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_mux_c_0_DYMUX,
      CE => VCC,
      CLK => XLXI_2_mux_c_0_CLKINV,
      SET => GND,
      RST => XLXI_2_mux_c_0_FFY_RST,
      O => XLXI_5_dw_s(0)
    );
  XLXI_2_mux_c_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_2_mux_c_0_SRINVNOT,
      I1 => GSR,
      O => XLXI_2_mux_c_0_FFY_RST
    );
  XLXI_2_n00071 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => CPU_ADADDR_OUT(9),
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_2_n00071_O
    );
  XLXI_2_mux_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_2_mux_c_0_DXMUX,
      CE => VCC,
      CLK => XLXI_2_mux_c_0_CLKINV,
      SET => GND,
      RST => XLXI_2_mux_c_0_FFX_RST,
      O => XLXI_2_mux_c(0)
    );
  XLXI_2_mux_c_0_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_2_mux_c_0_SRINVNOT,
      I1 => GSR,
      O => XLXI_2_mux_c_0_FFX_RST
    );
  Cpu16_I4_n020234_SW0 : X_LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(15),
      ADR1 => Cpu16_I4_n020220_SW0_O,
      ADR2 => Cpu16_I2_idata_c(11),
      ADR3 => Cpu16_I2_idata_c(14),
      O => N31064_F
    );
  Cpu16_I2_ndre_x1_SW0_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"3F7F"
    )
    port map (
      ADR0 => Cpu16_I2_idata_x(1),
      ADR1 => N30562,
      ADR2 => Cpu16_I4_n0162,
      ADR3 => Cpu16_I2_idata_x(2),
      O => N30976_F
    );
  Cpu16_I2_pc_mux_x_1_44_2_1098 : X_LUT4
    generic map(
      INIT => X"40C8"
    )
    port map (
      ADR0 => Cpu16_I2_TC_x(0),
      ADR1 => CHOICE606,
      ADR2 => N31353,
      ADR3 => N31355,
      O => Cpu16_I2_pc_mux_x_1_44_2_F
    );
  Cpu16_I3_Ker1725810_G : X_LUT4
    generic map(
      INIT => X"E9FB"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I2_TC_c_0_1,
      ADR3 => N31797,
      O => N32048
    );
  XLXI_3_maddr_8_161_F : X_LUT4
    generic map(
      INIT => X"AC0C"
    )
    port map (
      ADR0 => XLXI_3_daddr_c(8),
      ADR1 => CPU_ADADDR_OUT(8),
      ADR2 => Cpu16_I4_ndre_x1_1,
      ADR3 => XLXI_3_N12472,
      O => N32141
    );
  XLXI_3_maddr_3_161_G : X_LUT4
    generic map(
      INIT => X"DF8A"
    )
    port map (
      ADR0 => CPU_NDRE,
      ADR1 => XLXI_3_daddr_c(3),
      ADR2 => XLXI_3_N12472,
      ADR3 => CPU_ADADDR_OUT(3),
      O => N32103
    );
  XLXI_3_maddr_4_161_G : X_LUT4
    generic map(
      INIT => X"DFD0"
    )
    port map (
      ADR0 => XLXI_3_N12472,
      ADR1 => XLXI_3_daddr_c(4),
      ADR2 => CPU_NDRE,
      ADR3 => CPU_ADADDR_OUT(4),
      O => N32123
    );
  XLXI_3_maddr_5_161_G : X_LUT4
    generic map(
      INIT => X"ACFC"
    )
    port map (
      ADR0 => XLXI_3_daddr_c(5),
      ADR1 => CPU_ADADDR_OUT(5),
      ADR2 => Cpu16_I4_ndre_x1_1,
      ADR3 => XLXI_3_N12472,
      O => N32128
    );
  XLXI_3_maddr_6_161_G : X_LUT4
    generic map(
      INIT => X"DFD0"
    )
    port map (
      ADR0 => XLXI_3_N12472,
      ADR1 => XLXI_3_daddr_c(6),
      ADR2 => Cpu16_I4_ndre_x1_1,
      ADR3 => CPU_ADADDR_OUT(6),
      O => N32148
    );
  Cpu16_I2_TC_x_0_SW0_SW1 : X_LUT4
    generic map(
      INIT => X"A222"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_I2_idata_x(3),
      ADR2 => Cpu16_I2_idata_x(0),
      ADR3 => Cpu16_I2_n0077,
      O => N30972_F
    );
  Cpu16_I1_iaddr_x_0_5 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_2_46_2,
      ADR1 => Cpu16_I2_pc_mux_x_0_104_2,
      ADR2 => Cpu16_pc_mux(1),
      ADR3 => XLXN_20(0),
      O => Cpu16_I1_pc_0_G
    );
  Cpu16_I2_TC_x_0_SW0_SW3 : X_LUT4
    generic map(
      INIT => X"FF4F"
    )
    port map (
      ADR0 => Cpu16_I2_idata_x(0),
      ADR1 => Cpu16_I2_TC_x_0_SW0_SW3_SW0_O,
      ADR2 => Cpu16_I2_n0077,
      ADR3 => N30420,
      O => N31060_F
    );
  Cpu16_I2_TC_x_0_SW0_SW2 : X_LUT4
    generic map(
      INIT => X"EFEA"
    )
    port map (
      ADR0 => N30420,
      ADR1 => N31181,
      ADR2 => Cpu16_I2_n0150,
      ADR3 => N31179,
      O => N31058_F
    );
  Cpu16_I1_iaddr_x_0_55 : X_LUT4
    generic map(
      INIT => X"C4C0"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_2_46_2,
      ADR1 => Cpu16_I1_n0010,
      ADR2 => Cpu16_I1_iaddr_x_0_5_O,
      ADR3 => N31160,
      O => Cpu16_I1_pc_0_F
    );
  Cpu16_I1_pc_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_pc_0_DXMUX,
      CE => VCC,
      CLK => Cpu16_I1_pc_0_CLKINV,
      SET => GND,
      RST => Cpu16_I1_pc_0_FFX_RST,
      O => Cpu16_I1_pc(0)
    );
  Cpu16_I1_pc_0_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I1_pc_0_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I1_pc_0_FFX_RST
    );
  Cpu16_I4_Mmux_n0158_Result_0_1 : X_LUT4
    generic map(
      INIT => X"AACC"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_i(0),
      ADR1 => Cpu16_I4_ireg_x(0),
      ADR2 => VCC,
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I4_Mmux_n0158_Result_0_1_O
    );
  Cpu16_I3_n0147_7_72_SW1 : X_LUT4
    generic map(
      INIT => X"C808"
    )
    port map (
      ADR0 => N30611,
      ADR1 => Cpu16_I3_n0023,
      ADR2 => CHOICE1076,
      ADR3 => N30613,
      O => N31968_G
    );
  Cpu16_I1_Mmux_saddr_out_Result_0_20 : X_LUT4
    generic map(
      INIT => X"EEEA"
    )
    port map (
      ADR0 => CHOICE404,
      ADR1 => Cpu16_I1_n0010,
      ADR2 => Cpu16_I1_Mmux_saddr_out_Result_0_6_O,
      ADR3 => CHOICE405,
      O => XLXN_14_0_F
    );
  Cpu16_I3_skip_l121 : X_LUT4
    generic map(
      INIT => X"0200"
    )
    port map (
      ADR0 => Cpu16_I2_n0150,
      ADR1 => Cpu16_I2_TC_c(0),
      ADR2 => Cpu16_I2_TC_c(1),
      ADR3 => CHOICE255,
      O => CHOICE1593_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_1_20 : X_LUT4
    generic map(
      INIT => X"EEEA"
    )
    port map (
      ADR0 => CHOICE412,
      ADR1 => Cpu16_I1_n0010,
      ADR2 => Cpu16_I1_Mmux_saddr_out_Result_1_6_O,
      ADR3 => CHOICE413,
      O => XLXN_14_1_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_2_6 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => Cpu16_I1_n0020,
      ADR1 => Cpu16_I1_n0009(2),
      ADR2 => Cpu16_I1_n0024,
      ADR3 => Cpu16_I1_eaddr_x(2),
      O => XLXN_14_2_G
    );
  Cpu16_I2_ndre_x1_SW0_SW2_SW1 : X_LUT4
    generic map(
      INIT => X"FFEE"
    )
    port map (
      ADR0 => Cpu16_I2_n01501_2,
      ADR1 => N31070,
      ADR2 => VCC,
      ADR3 => N31064,
      O => N31223_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_2_20 : X_LUT4
    generic map(
      INIT => X"FFC8"
    )
    port map (
      ADR0 => Cpu16_I1_Mmux_saddr_out_Result_2_6_O,
      ADR1 => Cpu16_I1_n0010,
      ADR2 => CHOICE429,
      ADR3 => CHOICE428,
      O => XLXN_14_2_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_3_6 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => Cpu16_I1_n0009(3),
      ADR1 => Cpu16_I1_n0020,
      ADR2 => Cpu16_I1_n0024,
      ADR3 => Cpu16_I1_eaddr_x(3),
      O => XLXN_14_3_G
    );
  XLXI_3_maddr_7_161_G : X_LUT4
    generic map(
      INIT => X"FC5C"
    )
    port map (
      ADR0 => XLXI_3_N12472,
      ADR1 => CPU_ADADDR_OUT(7),
      ADR2 => Cpu16_I4_ndre_x1_1,
      ADR3 => XLXI_3_daddr_c(7),
      O => N32108
    );
  XLXI_3_maddr_8_161_G : X_LUT4
    generic map(
      INIT => X"ACFC"
    )
    port map (
      ADR0 => XLXI_3_daddr_c(8),
      ADR1 => CPU_ADADDR_OUT(8),
      ADR2 => Cpu16_I4_ndre_x1_1,
      ADR3 => XLXI_3_N12472,
      O => N32143
    );
  Cpu16_I3_n0147_5_39_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"EE44"
    )
    port map (
      ADR0 => CHOICE972,
      ADR1 => N30359,
      ADR2 => VCC,
      ADR3 => N30361,
      O => N31988_F
    );
  Cpu16_I2_ndre_x1_SW5_SW0_SW0_SW2 : X_LUT4
    generic map(
      INIT => X"CFDD"
    )
    port map (
      ADR0 => N31370,
      ADR1 => N30269,
      ADR2 => Cpu16_I2_ndre_x1_SW5_SW0_SW0_SW1_O,
      ADR3 => Cpu16_I2_n01501_2,
      O => N31405_F
    );
  Cpu16_I3_n0147_6_39_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"EE22"
    )
    port map (
      ADR0 => N30353,
      ADR1 => CHOICE1027,
      ADR2 => VCC,
      ADR3 => N30355,
      O => N31914_F
    );
  Cpu16_I2_TC_x_0_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"80B0"
    )
    port map (
      ADR0 => Cpu16_I2_idata_x(0),
      ADR1 => Cpu16_I2_n0077,
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => Cpu16_I2_idata_x(3),
      O => N30970_F
    );
  Cpu16_I2_Mmux_idata_x_Result_3_1 : X_LUT4
    generic map(
      INIT => X"E4E4"
    )
    port map (
      ADR0 => Cpu16_I2_n0150,
      ADR1 => Cpu16_I2_idata_c(3),
      ADR2 => MEM_DATA_OUT(3),
      ADR3 => VCC,
      O => N30972_G
    );
  Cpu16_I3_Mmux_data_x_Result_2_61 : X_LUT4
    generic map(
      INIT => X"0302"
    )
    port map (
      ADR0 => CHOICE1424,
      ADR1 => Cpu16_I2_C_store_x,
      ADR2 => Cpu16_I2_ndre_x1_SW2_SW0_O,
      ADR3 => CHOICE1421,
      O => CHOICE1428_F
    );
  Cpu16_I3_Mmux_data_x_Result_11_85 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => Cpu16_I4_N18018,
      ADR1 => Cpu16_I4_n0202,
      ADR2 => CHOICE900,
      ADR3 => CHOICE887,
      O => CHOICE1296_G
    );
  Cpu16_I3_Mmux_data_x_Result_2_37 : X_LUT4
    generic map(
      INIT => X"0200"
    )
    port map (
      ADR0 => Cpu16_daddr_is(1),
      ADR1 => Cpu16_daddr_is(2),
      ADR2 => Cpu16_daddr_is(0),
      ADR3 => Cpu16_I4_iinc_c(2),
      O => CHOICE1424_F
    );
  Cpu16_I3_n0147_11_12 : X_LUT4
    generic map(
      INIT => X"E2F0"
    )
    port map (
      ADR0 => N30880,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => N30878,
      ADR3 => CHOICE902,
      O => CHOICE1296_F
    );
  Cpu16_I3_Mmux_data_x_Result_3_61 : X_LUT4
    generic map(
      INIT => X"000E"
    )
    port map (
      ADR0 => CHOICE1333,
      ADR1 => CHOICE1336,
      ADR2 => Cpu16_I2_C_store_x,
      ADR3 => Cpu16_I2_ndre_x1_SW3_SW0_O,
      O => CHOICE1340_F
    );
  Cpu16_I4_Ker18016 : X_LUT4
    generic map(
      INIT => X"F0E0"
    )
    port map (
      ADR0 => Cpu16_I2_C_store_x,
      ADR1 => N30412,
      ADR2 => Cpu16_I4_n0162,
      ADR3 => Cpu16_I2_ndre_x1_SW12_O,
      O => Cpu16_I4_N18018_F
    );
  Cpu16_I3_Mmux_data_x_Result_13_Q : X_LUT4
    generic map(
      INIT => X"F202"
    )
    port map (
      ADR0 => Cpu16_I4_N18350,
      ADR1 => N24841,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => Cpu16_data_is_int(13),
      O => CHOICE1439_G
    );
  Cpu16_I3_n0147_12_12 : X_LUT4
    generic map(
      INIT => X"EEFA"
    )
    port map (
      ADR0 => Cpu16_I3_N17389,
      ADR1 => Cpu16_I3_n0087,
      ADR2 => Cpu16_I3_n0082,
      ADR3 => Cpu16_I3_data_x_12_Q,
      O => CHOICE1351_F
    );
  XLXI_5_nwait_c_0 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_5_nwait_c_0_DXMUX,
      CE => VCC,
      CLK => XLXI_5_nwait_c_0_CLKINV,
      SET => XLXI_5_nwait_c_0_FFX_SET,
      RST => GND,
      O => XLXI_5_nwait_c(0)
    );
  XLXI_5_nwait_c_0_FFX_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_5_nwait_c_0_SRINVNOT,
      O => XLXI_5_nwait_c_0_FFX_SET
    );
  XLXI_5_n0009_2_1 : X_LUT4
    generic map(
      INIT => X"F0FB"
    )
    port map (
      ADR0 => NACS_EXT,
      ADR1 => CHOICE589,
      ADR2 => XLXI_5_n0011(2),
      ADR3 => CHOICE583,
      O => XLXI_5_n0009_2_1_O
    );
  XLXI_5_nwait_c_1 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_5_nwait_c_1_DYMUX,
      CE => VCC,
      CLK => XLXI_5_nwait_c_1_CLKINV,
      SET => XLXI_5_nwait_c_1_FFY_SET,
      RST => GND,
      O => XLXI_5_nwait_c(1)
    );
  XLXI_5_nwait_c_1_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_5_nwait_c_1_SRINVNOT,
      O => XLXI_5_nwait_c_1_FFY_SET
    );
  XLXI_5_n0009_4_1 : X_LUT4
    generic map(
      INIT => X"AA08"
    )
    port map (
      ADR0 => XLXI_5_n0011(4),
      ADR1 => CHOICE589,
      ADR2 => NACS_EXT,
      ADR3 => CHOICE583,
      O => XLXI_5_n0009_4_1_O
    );
  XLXI_5_nwait_c_2 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_5_nwait_c_3_DYMUX,
      CE => VCC,
      CLK => XLXI_5_nwait_c_3_CLKINV,
      SET => XLXI_5_nwait_c_3_FFY_SET,
      RST => GND,
      O => XLXI_5_nwait_c(2)
    );
  XLXI_5_nwait_c_3_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_5_nwait_c_3_SRINVNOT,
      O => XLXI_5_nwait_c_3_FFY_SET
    );
  Cpu16_I1_Mmux_saddr_out_Result_5_6 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => Cpu16_I1_n0020,
      ADR1 => Cpu16_I1_eaddr_x(5),
      ADR2 => Cpu16_I1_n0024,
      ADR3 => Cpu16_I1_n0009(5),
      O => XLXN_14_5_G
    );
  XLXI_5_n0009_3_1 : X_LUT4
    generic map(
      INIT => X"AA08"
    )
    port map (
      ADR0 => XLXI_5_n0011(3),
      ADR1 => CHOICE589,
      ADR2 => NACS_EXT,
      ADR3 => CHOICE583,
      O => XLXI_5_n0009_3_1_O
    );
  XLXI_5_nwait_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_nwait_c_3_DXMUX,
      CE => VCC,
      CLK => XLXI_5_nwait_c_3_CLKINV,
      SET => GND,
      RST => XLXI_5_nwait_c_3_FFX_RST,
      O => XLXI_5_nwait_c(3)
    );
  XLXI_5_nwait_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_nwait_c_3_SRINVNOT,
      I1 => GSR,
      O => XLXI_5_nwait_c_3_FFX_RST
    );
  Cpu16_I1_Mmux_saddr_out_Result_5_20 : X_LUT4
    generic map(
      INIT => X"EEEA"
    )
    port map (
      ADR0 => CHOICE444,
      ADR1 => Cpu16_I1_n0010,
      ADR2 => Cpu16_I1_Mmux_saddr_out_Result_5_6_O,
      ADR3 => CHOICE445,
      O => XLXN_14_5_F
    );
  XLXI_5_nwait_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_nwait_c_5_DYMUX,
      CE => VCC,
      CLK => XLXI_5_nwait_c_5_CLKINV,
      SET => GND,
      RST => XLXI_5_nwait_c_5_FFY_RST,
      O => XLXI_5_nwait_c(4)
    );
  XLXI_5_nwait_c_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_nwait_c_5_SRINVNOT,
      I1 => GSR,
      O => XLXI_5_nwait_c_5_FFY_RST
    );
  Cpu16_I3_acc_i_0_9_1099 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_i_0_8_DYMUX,
      CE => Cpu16_I3_acc_i_0_8_CEINV,
      CLK => Cpu16_I3_acc_i_0_8_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_i_0_8_FFY_RST,
      O => Cpu16_I3_acc_i_0_9
    );
  Cpu16_I3_acc_i_0_8_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_i_0_8_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_i_0_8_FFY_RST
    );
  Cpu16_I3_n0147_8_139 : X_LUT4
    generic map(
      INIT => X"FBF8"
    )
    port map (
      ADR0 => N30343,
      ADR1 => CHOICE1133,
      ADR2 => CHOICE1126,
      ADR3 => Cpu16_I3_n0147_8_39_SW0_O,
      O => Cpu16_I3_acc_i_0_8_F
    );
  Cpu16_I3_acc_i_0_8_1100 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_i_0_8_DXMUX,
      CE => Cpu16_I3_acc_i_0_8_CEINV,
      CLK => Cpu16_I3_acc_i_0_8_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_i_0_8_FFX_RST,
      O => Cpu16_I3_acc_i_0_8
    );
  Cpu16_I3_acc_i_0_8_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_i_0_8_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_i_0_8_FFX_RST
    );
  Cpu16_I2_Mmux_idata_x_Result_6_1_1_1101 : X_LUT4
    generic map(
      INIT => X"CACA"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(6),
      ADR1 => MEM_DATA_OUT(6),
      ADR2 => Cpu16_I2_n01501_1,
      ADR3 => VCC,
      O => Cpu16_I2_data_is_c_2_F
    );
  Cpu16_I2_data_is_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_data_is_c_2_DXMUX,
      CE => VCC,
      CLK => Cpu16_I2_data_is_c_2_CLKINV,
      SET => GND,
      RST => Cpu16_I2_data_is_c_2_FFX_RST,
      O => Cpu16_I2_data_is_c(2)
    );
  Cpu16_I2_data_is_c_2_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_data_is_c_2_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_data_is_c_2_FFX_RST
    );
  Cpu16_I3_skip_l37 : X_LUT4
    generic map(
      INIT => X"0374"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_16,
      ADR1 => Cpu16_I2_TD_c(2),
      ADR2 => Cpu16_I3_n009675_O,
      ADR3 => Cpu16_I2_TD_c(1),
      O => CHOICE1577_F
    );
  Cpu16_I2_TC_x_0_Q : X_LUT4
    generic map(
      INIT => X"F0B8"
    )
    port map (
      ADR0 => N30972,
      ADR1 => Cpu16_I2_n0142,
      ADR2 => N30970,
      ADR3 => Cpu16_daddr_is(0),
      O => Cpu16_I2_TC_c_0_G
    );
  Cpu16_I2_TC_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TC_c_0_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_TC_c_0_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TC_c_0_FFY_RST,
      O => Cpu16_I2_TC_c(0)
    );
  Cpu16_I2_TC_c_0_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TC_c_0_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TC_c_0_FFY_RST
    );
  Cpu16_I1_iaddr_x_4_47 : X_LUT4
    generic map(
      INIT => X"F0E0"
    )
    port map (
      ADR0 => CHOICE572,
      ADR1 => Cpu16_I1_N13702,
      ADR2 => Cpu16_I1_n0010,
      ADR3 => Cpu16_I1_iaddr_x_4_14_O,
      O => Cpu16_I1_pc_4_F
    );
  Cpu16_I1_iaddr_x_5_25 : X_LUT4
    generic map(
      INIT => X"CAC0"
    )
    port map (
      ADR0 => MEM_DATA_OUT(9),
      ADR1 => XLXN_20(5),
      ADR2 => Cpu16_I2_pc_mux_x_2_46_2,
      ADR3 => Cpu16_I2_pc_mux_x_1_44_2,
      O => CHOICE558_F
    );
  Cpu16_I1_pc_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_pc_4_DXMUX,
      CE => VCC,
      CLK => Cpu16_I1_pc_4_CLKINV,
      SET => GND,
      RST => Cpu16_I1_pc_4_FFX_RST,
      O => Cpu16_I1_pc(4)
    );
  Cpu16_I1_pc_4_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I1_pc_4_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I1_pc_4_FFX_RST
    );
  Cpu16_I3_n0147_8_39_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FA50"
    )
    port map (
      ADR0 => CHOICE1137,
      ADR1 => VCC,
      ADR2 => N30341,
      ADR3 => N30343,
      O => N31938_F
    );
  XLXI_3_n0006 : X_LUT4
    generic map(
      INIT => X"F707"
    )
    port map (
      ADR0 => CPU_NADWE,
      ADR1 => Cpu16_I4_ndre_x1_1,
      ADR2 => XLXI_3_a2vi_s(0),
      ADR3 => N20734,
      O => XLXI_3_n0006_O
    );
  Cpu16_I1_iaddr_x_5_14 : X_LUT4
    generic map(
      INIT => X"0E04"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_0_104_2,
      ADR1 => Cpu16_I1_pc(5),
      ADR2 => Cpu16_I2_pc_mux_x_1_44_2,
      ADR3 => Cpu16_I1_n0009(5),
      O => Cpu16_I1_pc_5_G
    );
  XLXI_3_a2vi_s_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_a2vi_s_0_DYMUX,
      CE => VCC,
      CLK => XLXI_3_a2vi_s_0_CLKINV,
      SET => GND,
      RST => XLXI_3_a2vi_s_0_FFY_RST,
      O => XLXI_3_a2vi_s(0)
    );
  XLXI_3_a2vi_s_0_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_a2vi_s_0_SRINVNOT,
      I1 => GSR,
      O => XLXI_3_a2vi_s_0_FFY_RST
    );
  XLXI_3_nadwe_c_N12141 : X_LUT4
    generic map(
      INIT => X"5F5F"
    )
    port map (
      ADR0 => XLXI_5_dw_s(0),
      ADR1 => VCC,
      ADR2 => XLXI_3_a2vi_s(0),
      ADR3 => VCC,
      O => XLXI_3_a2vi_s_0_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_10_6 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => Cpu16_I1_n0009(10),
      ADR1 => Cpu16_I1_eaddr_x(10),
      ADR2 => Cpu16_I1_n0024,
      ADR3 => Cpu16_I1_n0020,
      O => XLXN_14_10_G
    );
  Cpu16_I3_n0147_3_12 : X_LUT4
    generic map(
      INIT => X"EF20"
    )
    port map (
      ADR0 => N30820,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => CHOICE1342,
      ADR3 => N30830,
      O => CHOICE856_F
    );
  Cpu16_I3_n0147_4_12 : X_LUT4
    generic map(
      INIT => X"E2F0"
    )
    port map (
      ADR0 => N30820,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => N30824,
      ADR3 => CHOICE1287,
      O => CHOICE911_F
    );
  Cpu16_I3_n0147_5_12 : X_LUT4
    generic map(
      INIT => X"CEC4"
    )
    port map (
      ADR0 => CHOICE1232,
      ADR1 => N30818,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => N30820,
      O => CHOICE966_F
    );
  Cpu16_I3_Mmux_data_x_Result_10_61 : X_LUT4
    generic map(
      INIT => X"000E"
    )
    port map (
      ADR0 => Cpu16_I3_Mmux_data_x_Result_10_37_O,
      ADR1 => CHOICE948,
      ADR2 => Cpu16_I2_C_store_x,
      ADR3 => N30906,
      O => CHOICE955_F
    );
  Cpu16_I3_Mmux_data_x_Result_6_85 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => CHOICE1162,
      ADR1 => Cpu16_I4_n0202,
      ADR2 => Cpu16_I4_N18018,
      ADR3 => CHOICE1175,
      O => CHOICE1021_G
    );
  Cpu16_I2_Ker156981_SW0 : X_LUT4
    generic map(
      INIT => X"F7FF"
    )
    port map (
      ADR0 => Cpu16_I2_nreset_v(1),
      ADR1 => N21764,
      ADR2 => Cpu16_I2_Ker156981_SW0_SW0_O,
      ADR3 => NRESET_IN_BUFGP,
      O => N30430_F
    );
  Cpu16_I3_Mmux_data_x_Result_11_37 : X_LUT4
    generic map(
      INIT => X"0020"
    )
    port map (
      ADR0 => Cpu16_daddr_is(1),
      ADR1 => Cpu16_daddr_is(2),
      ADR2 => Cpu16_I4_iinc_c(11),
      ADR3 => Cpu16_daddr_is(0),
      O => CHOICE900_G
    );
  Cpu16_I3_n0147_6_12 : X_LUT4
    generic map(
      INIT => X"FD20"
    )
    port map (
      ADR0 => CHOICE1177,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => N30820,
      ADR3 => N30836,
      O => CHOICE1021_F
    );
  Cpu16_I4_n02161 : X_LUT4
    generic map(
      INIT => X"FFCF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I4_dexp_we_c,
      ADR2 => Cpu16_I4_nreset_v(1),
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I2_int_stop_c_F
    );
  Cpu16_I4_ndwe_x1 : X_LUT4
    generic map(
      INIT => X"F7F3"
    )
    port map (
      ADR0 => N31051,
      ADR1 => Cpu16_I4_n0162,
      ADR2 => Cpu16_ndwe_int,
      ADR3 => Cpu16_I4_n0203,
      O => XLXI_3_nadwe_c_G
    );
  Cpu16_I2_n00971_SW0 : X_LUT4
    generic map(
      INIT => X"B0A0"
    )
    port map (
      ADR0 => Cpu16_I2_n0166(2),
      ADR1 => Cpu16_I2_Mmux_skip_x_Result1_1,
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => Cpu16_I2_C_raw,
      O => N30884_F
    );
  Cpu16_I2_n01501 : X_LUT4
    generic map(
      INIT => X"FF7F"
    )
    port map (
      ADR0 => Cpu16_I2_nreset_v(1),
      ADR1 => Cpu16_I2_N15618,
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => N30488,
      O => Cpu16_I2_n0150_F
    );
  XLXI_3_nadwe_c_1102 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_3_nadwe_c_DYMUX,
      CE => XLXI_3_nadwe_c_CEINV,
      CLK => XLXI_3_nadwe_c_CLKINV,
      SET => XLXI_3_nadwe_c_FFY_SET,
      RST => GND,
      O => XLXI_3_nadwe_c
    );
  XLXI_3_nadwe_c_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_3_nadwe_c_SRINVNOT,
      O => XLXI_3_nadwe_c_FFY_SET
    );
  Cpu16_I4_Ker182221 : X_LUT4
    generic map(
      INIT => X"0400"
    )
    port map (
      ADR0 => N31051,
      ADR1 => Cpu16_ndre_int,
      ADR2 => Cpu16_ndwe_int,
      ADR3 => Cpu16_I4_n01621_1,
      O => XLXI_3_nadwe_c_F
    );
  Cpu16_I1_ipush_out1 : X_LUT4
    generic map(
      INIT => X"60C0"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_0_104_2,
      ADR1 => Cpu16_I2_pc_mux_x_2_46_2,
      ADR2 => Cpu16_I1_n0010,
      ADR3 => Cpu16_I2_pc_mux_x_1_44_2,
      O => XLXI_4_addr_c_1_G
    );
  XLXI_4_Mmux_addr_x_Result_1_1 : X_LUT4
    generic map(
      INIT => X"F0E2"
    )
    port map (
      ADR0 => XLXI_4_addr_c(1),
      ADR1 => XLXN_2,
      ADR2 => XLXI_4_n0005(9),
      ADR3 => XLXN_1,
      O => XLXI_4_addr_c_1_F
    );
  XLXI_4_addr_c_1 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_4_addr_c_1_DXMUX,
      CE => VCC,
      CLK => XLXI_4_addr_c_1_CLKINV,
      SET => XLXI_4_addr_c_1_FFX_SET,
      RST => GND,
      O => XLXI_4_addr_c(1)
    );
  XLXI_4_addr_c_1_FFX_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_4_addr_c_1_SRINVNOT,
      O => XLXI_4_addr_c_1_FFX_SET
    );
  Cpu16_I4_Mmux_n0158_Result_10_1 : X_LUT4
    generic map(
      INIT => X"AAF0"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_i(10),
      ADR1 => VCC,
      ADR2 => Cpu16_I4_ireg_x(10),
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I4_Mmux_n0158_Result_10_1_O
    );
  XLXI_5_n0009_5_1 : X_LUT4
    generic map(
      INIT => X"AA08"
    )
    port map (
      ADR0 => XLXI_5_n0011(5),
      ADR1 => CHOICE589,
      ADR2 => NACS_EXT,
      ADR3 => CHOICE583,
      O => XLXI_5_n0009_5_1_O
    );
  XLXI_4_Mmux_addr_x_Result_0_1 : X_LUT4
    generic map(
      INIT => X"11EE"
    )
    port map (
      ADR0 => XLXN_1,
      ADR1 => XLXN_2,
      ADR2 => VCC,
      ADR3 => XLXI_4_addr_c(0),
      O => XLXI_4_addr_c_0_G
    );
  XLXI_5_nwait_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_nwait_c_5_DXMUX,
      CE => VCC,
      CLK => XLXI_5_nwait_c_5_CLKINV,
      SET => GND,
      RST => XLXI_5_nwait_c_5_FFX_RST,
      O => XLXI_5_nwait_c(5)
    );
  XLXI_5_nwait_c_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_nwait_c_5_SRINVNOT,
      I1 => GSR,
      O => XLXI_5_nwait_c_5_FFX_RST
    );
  XLXI_5_nwait_c_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_nwait_c_7_DYMUX,
      CE => VCC,
      CLK => XLXI_5_nwait_c_7_CLKINV,
      SET => GND,
      RST => XLXI_5_nwait_c_7_FFY_RST,
      O => XLXI_5_nwait_c(6)
    );
  XLXI_5_nwait_c_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_nwait_c_7_SRINVNOT,
      I1 => GSR,
      O => XLXI_5_nwait_c_7_FFY_RST
    );
  XLXI_5_n0009_7_1 : X_LUT4
    generic map(
      INIT => X"CC40"
    )
    port map (
      ADR0 => NACS_EXT,
      ADR1 => XLXI_5_n0011(7),
      ADR2 => CHOICE589,
      ADR3 => CHOICE583,
      O => XLXI_5_n0009_7_1_O
    );
  XLXI_4_Mmux_addr_x_Result_2_1 : X_LUT4
    generic map(
      INIT => X"F0E2"
    )
    port map (
      ADR0 => XLXI_4_addr_c(2),
      ADR1 => XLXN_2,
      ADR2 => XLXI_4_n0005(10),
      ADR3 => XLXN_1,
      O => XLXI_4_addr_c_3_G
    );
  XLXI_5_nwait_c_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_nwait_c_7_DXMUX,
      CE => VCC,
      CLK => XLXI_5_nwait_c_7_CLKINV,
      SET => GND,
      RST => XLXI_5_nwait_c_7_FFX_RST,
      O => XLXI_5_nwait_c(7)
    );
  XLXI_5_nwait_c_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_nwait_c_7_SRINVNOT,
      I1 => GSR,
      O => XLXI_5_nwait_c_7_FFX_RST
    );
  XLXI_4_addr_c_0 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_4_addr_c_0_DYMUX,
      CE => VCC,
      CLK => XLXI_4_addr_c_0_CLKINV,
      SET => XLXI_4_addr_c_0_FFY_SET,
      RST => GND,
      O => XLXI_4_addr_c(0)
    );
  XLXI_4_addr_c_0_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_4_addr_c_0_SRINVNOT,
      O => XLXI_4_addr_c_0_FFY_SET
    );
  Cpu16_I1_Mmux_saddr_out_Result_6_6 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => Cpu16_I1_n0020,
      ADR1 => Cpu16_I1_eaddr_x(6),
      ADR2 => Cpu16_I1_n0024,
      ADR3 => Cpu16_I1_n0009(6),
      O => XLXN_14_6_G
    );
  Cpu16_I1_Mmux_saddr_out_Result_6_20 : X_LUT4
    generic map(
      INIT => X"EEEA"
    )
    port map (
      ADR0 => CHOICE452,
      ADR1 => Cpu16_I1_n0010,
      ADR2 => CHOICE453,
      ADR3 => Cpu16_I1_Mmux_saddr_out_Result_6_6_O,
      O => XLXN_14_6_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_7_20 : X_LUT4
    generic map(
      INIT => X"FFE0"
    )
    port map (
      ADR0 => Cpu16_I1_Mmux_saddr_out_Result_7_6_O,
      ADR1 => CHOICE461,
      ADR2 => Cpu16_I1_n0010,
      ADR3 => CHOICE460,
      O => XLXN_14_7_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_3_1 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => Cpu16_I1_pc(3),
      ADR1 => Cpu16_I2_pc_mux_x_2_46_1,
      ADR2 => Cpu16_I2_pc_mux_x_0_104_1,
      ADR3 => Cpu16_I2_pc_mux_x_1_44_1,
      O => CHOICE421_F
    );
  Cpu16_I2_pc_mux_x_1_44_1_1103 : X_LUT4
    generic map(
      INIT => X"2A08"
    )
    port map (
      ADR0 => CHOICE606,
      ADR1 => Cpu16_I2_TC_x(0),
      ADR2 => N31355,
      ADR3 => N31353,
      O => CHOICE437_G
    );
  Cpu16_I1_Mmux_saddr_out_Result_4_0 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => Cpu16_I1_N13634,
      ADR3 => XLXN_20(4),
      O => CHOICE436_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_4_1 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_0_104_1,
      ADR1 => Cpu16_I2_pc_mux_x_2_46_1,
      ADR2 => Cpu16_I1_pc(4),
      ADR3 => Cpu16_I2_pc_mux_x_1_44_1,
      O => CHOICE437_F
    );
  Cpu16_I2_pc_mux_x_2_46_1_1104 : X_LUT4
    generic map(
      INIT => X"A0E0"
    )
    port map (
      ADR0 => Cpu16_I2_n0166(2),
      ADR1 => CHOICE660,
      ADR2 => CHOICE665,
      ADR3 => Cpu16_I2_Mmux_skip_x_Result1_1,
      O => CHOICE469_G
    );
  Cpu16_I1_Mmux_saddr_out_Result_8_6 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => Cpu16_I1_n0020,
      ADR1 => Cpu16_I1_n0024,
      ADR2 => Cpu16_I1_eaddr_x(8),
      ADR3 => Cpu16_I1_n0009(8),
      O => XLXN_14_8_G
    );
  Cpu16_I1_Mmux_saddr_out_Result_8_20 : X_LUT4
    generic map(
      INIT => X"FCEC"
    )
    port map (
      ADR0 => CHOICE469,
      ADR1 => CHOICE468,
      ADR2 => Cpu16_I1_n0010,
      ADR3 => Cpu16_I1_Mmux_saddr_out_Result_8_6_O,
      O => XLXN_14_8_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_9_20 : X_LUT4
    generic map(
      INIT => X"EEEA"
    )
    port map (
      ADR0 => CHOICE476,
      ADR1 => Cpu16_I1_n0010,
      ADR2 => CHOICE477,
      ADR3 => Cpu16_I1_Mmux_saddr_out_Result_9_6_O,
      O => XLXN_14_9_F
    );
  Cpu16_I2_ndre_x1_SW0 : X_LUT4
    generic map(
      INIT => X"CDC8"
    )
    port map (
      ADR0 => N31072,
      ADR1 => N31223,
      ADR2 => N31066,
      ADR3 => Cpu16_I2_ndre_x1_SW0_SW2_SW0_O,
      O => N31051_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_3_20 : X_LUT4
    generic map(
      INIT => X"FCEC"
    )
    port map (
      ADR0 => CHOICE421,
      ADR1 => CHOICE420,
      ADR2 => Cpu16_I1_n0010,
      ADR3 => Cpu16_I1_Mmux_saddr_out_Result_3_6_O,
      O => XLXN_14_3_F
    );
  XLXI_2_nWE_RAM_x1 : X_LUT4
    generic map(
      INIT => X"FAFF"
    )
    port map (
      ADR0 => CPU_ADADDR_OUT(9),
      ADR1 => VCC,
      ADR2 => CPU_NADWE,
      ADR3 => NRESET_IN_BUFGP,
      O => XLXI_2_nWE_RAM_x1_O
    );
  XLXI_2_nWE_RAM_c_1105 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_2_nWE_RAM_c_DYMUX,
      CE => VCC,
      CLK => XLXI_2_nWE_RAM_c_CLKINV,
      SET => XLXI_2_nWE_RAM_c_FFY_SET,
      RST => GND,
      O => XLXI_2_nWE_RAM_c
    );
  XLXI_2_nWE_RAM_c_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_2_nWE_RAM_c_SRINVNOT,
      O => XLXI_2_nWE_RAM_c_FFY_SET
    );
  XLXI_2_nCS_EXT_x1 : X_LUT4
    generic map(
      INIT => X"55FF"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => CPU_ADADDR_OUT(9),
      O => XLXI_5_nwait_c_0_G
    );
  XLXI_5_Mmux_cpu_daddr_out_Result_9_1 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => CPU_ADADDR_OUT(9),
      ADR1 => XLXI_5_cpu_daddr_c(9),
      ADR2 => XLXI_5_N12957,
      ADR3 => XLXI_5_N12936,
      O => XLXI_2_nWE_RAM_c_F
    );
  XLXI_5_n0009_1_1 : X_LUT4
    generic map(
      INIT => X"FF45"
    )
    port map (
      ADR0 => CHOICE583,
      ADR1 => NACS_EXT,
      ADR2 => CHOICE589,
      ADR3 => XLXI_5_n0011(1),
      O => XLXI_5_n0009_1_1_O
    );
  Cpu16_I1_Mmux_saddr_out_Result_4_20 : X_LUT4
    generic map(
      INIT => X"FFE0"
    )
    port map (
      ADR0 => CHOICE437,
      ADR1 => Cpu16_I1_Mmux_saddr_out_Result_4_6_O,
      ADR2 => Cpu16_I1_n0010,
      ADR3 => CHOICE436,
      O => XLXN_14_4_F
    );
  XLXI_5_n0009_0_1 : X_LUT4
    generic map(
      INIT => X"AAFB"
    )
    port map (
      ADR0 => XLXI_5_n0011(0),
      ADR1 => CHOICE589,
      ADR2 => NACS_EXT,
      ADR3 => CHOICE583,
      O => XLXI_5_n0009_0_1_O
    );
  Cpu16_I2_pc_mux_x_2_46 : X_LUT4
    generic map(
      INIT => X"A0A8"
    )
    port map (
      ADR0 => CHOICE665,
      ADR1 => CHOICE660,
      ADR2 => Cpu16_I2_n0166(2),
      ADR3 => Cpu16_I2_Mmux_skip_x_Result1_1,
      O => Cpu16_pc_mux_2_F
    );
  Cpu16_I2_ndre_x1_SW1_SW0_SW0_SW2 : X_LUT4
    generic map(
      INIT => X"F3F5"
    )
    port map (
      ADR0 => N31191,
      ADR1 => Cpu16_I2_ndre_x1_SW1_SW0_SW0_SW1_O,
      ADR2 => N30269,
      ADR3 => Cpu16_I2_n01501_2,
      O => N31234_F
    );
  Cpu16_I3_n0147_10_72_SW1 : X_LUT4
    generic map(
      INIT => X"C0A0"
    )
    port map (
      ADR0 => N30593,
      ADR1 => N30595,
      ADR2 => Cpu16_I3_n0023,
      ADR3 => CHOICE1241,
      O => N31934_G
    );
  Cpu16_I2_ndwe_x1_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FEEE"
    )
    port map (
      ADR0 => Cpu16_I2_n01451_SW0_O,
      ADR1 => Cpu16_I2_n0062,
      ADR2 => XLXI_3_a2vi_s(0),
      ADR3 => Cpu16_I2_N15561,
      O => N30434_F
    );
  Cpu16_I2_E_c_FFd1_In : X_LUT4
    generic map(
      INIT => X"0200"
    )
    port map (
      ADR0 => Cpu16_I2_N15561,
      ADR1 => N20432,
      ADR2 => XLXI_3_a2vi_s(0),
      ADR3 => Cpu16_I2_nreset_v(1),
      O => Cpu16_I2_E_c_FFd1_G
    );
  Cpu16_I3_n0147_10_39_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"F0AA"
    )
    port map (
      ADR0 => N30329,
      ADR1 => VCC,
      ADR2 => N30331,
      ADR3 => CHOICE1247,
      O => N31934_F
    );
  Cpu16_I2_E_c_FFd1_1106 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_E_c_FFd1_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_E_c_FFd1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_E_c_FFd1_FFY_RST,
      O => Cpu16_I2_E_c_FFd1
    );
  Cpu16_I2_E_c_FFd1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_E_c_FFd1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_E_c_FFd1_FFY_RST
    );
  Cpu16_I3_acc_i_0_12_1107 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_i_0_12_DXMUX,
      CE => Cpu16_I3_acc_i_0_12_CEINV,
      CLK => Cpu16_I3_acc_i_0_12_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_i_0_12_FFX_RST,
      O => Cpu16_I3_acc_i_0_12
    );
  Cpu16_I3_acc_i_0_12_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_i_0_12_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_i_0_12_FFX_RST
    );
  Cpu16_I3_n0147_14_139 : X_LUT4
    generic map(
      INIT => X"FDF8"
    )
    port map (
      ADR0 => CHOICE1496,
      ADR1 => N30307,
      ADR2 => CHOICE1489,
      ADR3 => Cpu16_I3_n0147_14_39_SW0_O,
      O => Cpu16_I3_acc_i_0_14_F
    );
  Cpu16_I2_pc_mux_x_0_38_SW0 : X_LUT4
    generic map(
      INIT => X"0777"
    )
    port map (
      ADR0 => Cpu16_I2_N15700,
      ADR1 => Cpu16_I2_TC_x(0),
      ADR2 => Cpu16_I2_n0166(2),
      ADR3 => Cpu16_I2_C_raw,
      O => N30405_F
    );
  Cpu16_I3_acc_i_0_14_1108 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_i_0_14_DXMUX,
      CE => Cpu16_I3_acc_i_0_14_CEINV,
      CLK => Cpu16_I3_acc_i_0_14_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_i_0_14_FFX_RST,
      O => Cpu16_I3_acc_i_0_14
    );
  Cpu16_I3_acc_i_0_14_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_i_0_14_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_i_0_14_FFX_RST
    );
  Cpu16_I3_n0147_15_139 : X_LUT4
    generic map(
      INIT => X"EEFC"
    )
    port map (
      ADR0 => N30301,
      ADR1 => CHOICE1626,
      ADR2 => Cpu16_I3_n0147_15_39_SW0_O,
      ADR3 => CHOICE1633,
      O => Cpu16_I3_acc_i_0_15_F
    );
  Cpu16_I3_acc_i_0_15_1109 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_i_0_15_DXMUX,
      CE => Cpu16_I3_acc_i_0_15_CEINV,
      CLK => Cpu16_I3_acc_i_0_15_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_i_0_15_FFX_RST,
      O => Cpu16_I3_acc_i_0_15
    );
  Cpu16_I3_acc_i_0_15_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_i_0_15_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_i_0_15_FFX_RST
    );
  Cpu16_I3_n0147_16_13_SW1 : X_LUT4
    generic map(
      INIT => X"ACCC"
    )
    port map (
      ADR0 => N30295,
      ADR1 => N31908,
      ADR2 => Cpu16_I3_n0083,
      ADR3 => Cpu16_I3_n0089(16),
      O => Cpu16_I3_acc_i_0_16_G
    );
  Cpu16_I2_Ker157151 : X_LUT4
    generic map(
      INIT => X"AA00"
    )
    port map (
      ADR0 => Cpu16_I2_nreset_v(1),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => NRESET_IN_BUFGP,
      O => Cpu16_I2_N15561_G
    );
  Cpu16_I1_Mmux_saddr_out_Result_8_1 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_0_104_1,
      ADR1 => Cpu16_I1_pc(8),
      ADR2 => Cpu16_I2_pc_mux_x_2_46_1,
      ADR3 => Cpu16_I2_pc_mux_x_1_44_1,
      O => CHOICE469_F
    );
  Cpu16_I3_skip1 : X_LUT4
    generic map(
      INIT => X"2700"
    )
    port map (
      ADR0 => CHOICE1577,
      ADR1 => N31122,
      ADR2 => N31120,
      ADR3 => CHOICE1593,
      O => Cpu16_I2_skip_c_G
    );
  Cpu16_I2_skip_c_1110 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_skip_c_DYMUX,
      CE => Cpu16_I2_skip_c_CEINV,
      CLK => Cpu16_I2_skip_c_CLKINV,
      SET => GND,
      RST => Cpu16_I2_skip_c_FFY_RST,
      O => Cpu16_I2_skip_c
    );
  Cpu16_I2_skip_c_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_skip_c_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_skip_c_FFY_RST
    );
  Cpu16_I2_Mmux_skip_x_Result1 : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => Cpu16_I2_nreset_v(1),
      ADR1 => Cpu16_I2_E_c_FFd2,
      ADR2 => Cpu16_skip,
      ADR3 => Cpu16_I2_skip_c,
      O => Cpu16_I2_skip_c_F
    );
  Cpu16_I2_ndre_x1 : X_LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      ADR0 => Cpu16_I2_C_raw,
      ADR1 => N30269,
      ADR2 => Cpu16_I2_C_store_x,
      ADR3 => Cpu16_I2_C_mem_x,
      O => XLXI_5_ndre_c_G
    );
  Cpu16_I3_Mmux_data_x_Result_0_32 : X_LUT4
    generic map(
      INIT => X"4073"
    )
    port map (
      ADR0 => Cpu16_I3_Mmux_data_x_Result_0_32_SW1_O,
      ADR1 => Cpu16_I2_n01501_2,
      ADR2 => MEM_DATA_OUT(4),
      ADR3 => N31258,
      O => CHOICE1531_F
    );
  Cpu16_I4_ndre_x1_1_1111 : X_LUT4
    generic map(
      INIT => X"FF8F"
    )
    port map (
      ADR0 => Cpu16_I4_n0202,
      ADR1 => Cpu16_I4_n0203,
      ADR2 => Cpu16_I4_n0162,
      ADR3 => Cpu16_ndre_int,
      O => XLXI_5_ndre_c_F
    );
  Cpu16_I2_n0103 : X_LUT4
    generic map(
      INIT => X"0123"
    )
    port map (
      ADR0 => Cpu16_I2_n0142,
      ADR1 => Cpu16_I2_skip_x,
      ADR2 => N31058,
      ADR3 => N31060,
      O => CHOICE1538_G
    );
  XLXI_5_ndre_c_1112 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_5_ndre_c_DXMUX,
      CE => XLXI_5_ndre_c_CEINVNOT,
      CLK => XLXI_5_ndre_c_CLKINV,
      SET => XLXI_5_ndre_c_FFX_SET,
      RST => GND,
      O => XLXI_5_ndre_c
    );
  XLXI_5_ndre_c_FFX_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_5_ndre_c_SRINVNOT,
      O => XLXI_5_ndre_c_FFX_SET
    );
  Cpu16_I4_n020216_SW1 : X_LUT4
    generic map(
      INIT => X"FEFE"
    )
    port map (
      ADR0 => MEM_DATA_OUT(7),
      ADR1 => MEM_DATA_OUT(8),
      ADR2 => MEM_DATA_OUT(9),
      ADR3 => VCC,
      O => CHOICE1553_G
    );
  Cpu16_I2_Mmux_idata_x_Result_4_1_1_1113 : X_LUT4
    generic map(
      INIT => X"CCAA"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(4),
      ADR1 => MEM_DATA_OUT(4),
      ADR2 => VCC,
      ADR3 => Cpu16_I2_n0150,
      O => Cpu16_I2_data_is_c_0_G
    );
  Cpu16_I4_data_exp_c_10 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_c_11_DYMUX,
      CE => Cpu16_I4_data_exp_c_11_CEINV,
      CLK => Cpu16_I4_data_exp_c_11_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_c_11_FFY_RST,
      O => Cpu16_I4_data_exp_c(10)
    );
  Cpu16_I4_data_exp_c_11_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_data_exp_c_11_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_data_exp_c_11_FFY_RST
    );
  Cpu16_I4_data_exp_x_10_1 : X_LUT4
    generic map(
      INIT => X"CCA0"
    )
    port map (
      ADR0 => Cpu16_I4_data_exp_c(10),
      ADR1 => Cpu16_I3_acc_c_0_10,
      ADR2 => Cpu16_I4_n01621_1,
      ADR3 => Cpu16_I4_dexp_we_c,
      O => Cpu16_I4_iadata_x(22)
    );
  Cpu16_I4_n0160_11_1 : X_LUT4
    generic map(
      INIT => X"EA40"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I3_acc_c_0_11,
      ADR2 => Cpu16_I4_dexp_we_c,
      ADR3 => Cpu16_I4_data_exp_i(11),
      O => Cpu16_I4_n0160(11)
    );
  Cpu16_I4_data_exp_c_11 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_c_11_DXMUX,
      CE => Cpu16_I4_data_exp_c_11_CEINV,
      CLK => Cpu16_I4_data_exp_c_11_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_c_11_FFX_RST,
      O => Cpu16_I4_data_exp_c(11)
    );
  Cpu16_I4_data_exp_c_11_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_data_exp_c_11_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_data_exp_c_11_FFX_RST
    );
  Cpu16_I4_data_exp_i_10 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_i_11_DYMUX,
      CE => Cpu16_I4_data_exp_i_11_CEINV,
      CLK => Cpu16_I4_data_exp_i_11_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_i_11_FFY_RST,
      O => Cpu16_I4_data_exp_i(10)
    );
  Cpu16_I4_data_exp_i_11_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_data_exp_i_11_FFY_RST
    );
  Cpu16_I4_data_exp_x_11_1 : X_LUT4
    generic map(
      INIT => X"EA40"
    )
    port map (
      ADR0 => Cpu16_I4_dexp_we_c,
      ADR1 => Cpu16_I4_data_exp_c(11),
      ADR2 => Cpu16_I4_n01621_1,
      ADR3 => Cpu16_I3_acc_c_0_11,
      O => Cpu16_I4_iadata_x(23)
    );
  Cpu16_I4_data_exp_i_11 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_i_11_DXMUX,
      CE => Cpu16_I4_data_exp_i_11_CEINV,
      CLK => Cpu16_I4_data_exp_i_11_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_i_11_FFX_RST,
      O => Cpu16_I4_data_exp_i(11)
    );
  Cpu16_I4_data_exp_i_11_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_data_exp_i_11_FFX_RST
    );
  Cpu16_I2_data_is_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_data_is_c_0_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_data_is_c_0_CLKINV,
      SET => GND,
      RST => Cpu16_I2_data_is_c_0_FFY_RST,
      O => Cpu16_I2_data_is_c(0)
    );
  Cpu16_I2_data_is_c_0_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_data_is_c_0_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_data_is_c_0_FFY_RST
    );
  Cpu16_I2_TD_x_1_52 : X_LUT4
    generic map(
      INIT => X"122A"
    )
    port map (
      ADR0 => Cpu16_daddr_is(1),
      ADR1 => Cpu16_daddr_is(3),
      ADR2 => Cpu16_I2_Mmux_idata_x_Result_6_1_1,
      ADR3 => Cpu16_I2_Mmux_idata_x_Result_4_1_1,
      O => Cpu16_I2_data_is_c_0_F
    );
  Cpu16_I2_Mmux_idata_x_Result_7_1 : X_LUT4
    generic map(
      INIT => X"AACC"
    )
    port map (
      ADR0 => MEM_DATA_OUT(7),
      ADR1 => Cpu16_I2_idata_c(7),
      ADR2 => VCC,
      ADR3 => Cpu16_I2_n01501_1,
      O => Cpu16_I2_data_is_c_3_G
    );
  XLXI_4_addr_c_2 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_4_addr_c_3_DYMUX,
      CE => VCC,
      CLK => XLXI_4_addr_c_3_CLKINV,
      SET => XLXI_4_addr_c_3_FFY_SET,
      RST => GND,
      O => XLXI_4_addr_c(2)
    );
  XLXI_4_addr_c_3_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_4_addr_c_3_SRINVNOT,
      O => XLXI_4_addr_c_3_FFY_SET
    );
  XLXI_4_Mmux_addr_x_Result_3_1 : X_LUT4
    generic map(
      INIT => X"FE10"
    )
    port map (
      ADR0 => XLXN_1,
      ADR1 => XLXN_2,
      ADR2 => XLXI_4_addr_c(3),
      ADR3 => XLXI_4_n0005(11),
      O => XLXI_4_addr_c_3_F
    );
  XLXI_4_Mmux_addr_x_Result_6_1 : X_LUT4
    generic map(
      INIT => X"F0E2"
    )
    port map (
      ADR0 => XLXI_4_addr_c(6),
      ADR1 => XLXN_2,
      ADR2 => XLXI_4_n0005(14),
      ADR3 => XLXN_1,
      O => XLXI_4_addr_c_6_G
    );
  XLXI_4_addr_c_3 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_4_addr_c_3_DXMUX,
      CE => VCC,
      CLK => XLXI_4_addr_c_3_CLKINV,
      SET => XLXI_4_addr_c_3_FFX_SET,
      RST => GND,
      O => XLXI_4_addr_c(3)
    );
  XLXI_4_addr_c_3_FFX_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_4_addr_c_3_SRINVNOT,
      O => XLXI_4_addr_c_3_FFX_SET
    );
  XLXI_4_Mmux_addr_x_Result_4_1 : X_LUT4
    generic map(
      INIT => X"CCCA"
    )
    port map (
      ADR0 => XLXI_4_addr_c(4),
      ADR1 => XLXI_4_n0005(12),
      ADR2 => XLXN_2,
      ADR3 => XLXN_1,
      O => XLXI_4_addr_c_5_G
    );
  XLXI_4_addr_c_4 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_4_addr_c_5_DYMUX,
      CE => VCC,
      CLK => XLXI_4_addr_c_5_CLKINV,
      SET => XLXI_4_addr_c_5_FFY_SET,
      RST => GND,
      O => XLXI_4_addr_c(4)
    );
  XLXI_4_addr_c_5_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_4_addr_c_5_SRINVNOT,
      O => XLXI_4_addr_c_5_FFY_SET
    );
  XLXI_4_Mmux_addr_x_Result_5_1 : X_LUT4
    generic map(
      INIT => X"AAAC"
    )
    port map (
      ADR0 => XLXI_4_n0005(13),
      ADR1 => XLXI_4_addr_c(5),
      ADR2 => XLXN_2,
      ADR3 => XLXN_1,
      O => XLXI_4_addr_c_5_F
    );
  Cpu16_I2_pc_mux_x_0_104_1_1114 : X_LUT4
    generic map(
      INIT => X"3F3B"
    )
    port map (
      ADR0 => CHOICE679,
      ADR1 => Cpu16_I2_nreset_v_1_1,
      ADR2 => Cpu16_I2_n0145,
      ADR3 => CHOICE687,
      O => CHOICE421_G
    );
  XLXI_4_addr_c_5 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_4_addr_c_5_DXMUX,
      CE => VCC,
      CLK => XLXI_4_addr_c_5_CLKINV,
      SET => XLXI_4_addr_c_5_FFX_SET,
      RST => GND,
      O => XLXI_4_addr_c(5)
    );
  XLXI_4_addr_c_5_FFX_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_4_addr_c_5_SRINVNOT,
      O => XLXI_4_addr_c_5_FFX_SET
    );
  XLXI_4_addr_c_6 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => XLXI_4_addr_c_6_DYMUX,
      CE => VCC,
      CLK => XLXI_4_addr_c_6_CLKINV,
      SET => XLXI_4_addr_c_6_FFY_SET,
      RST => GND,
      O => XLXI_4_addr_c(6)
    );
  XLXI_4_addr_c_6_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => XLXI_4_addr_c_6_SRINVNOT,
      O => XLXI_4_addr_c_6_FFY_SET
    );
  Cpu16_I1_Mmux_saddr_out_Result_7_6 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => Cpu16_I1_n0020,
      ADR1 => Cpu16_I1_n0009(7),
      ADR2 => Cpu16_I1_eaddr_x(7),
      ADR3 => Cpu16_I1_n0024,
      O => XLXN_14_7_G
    );
  XLXI_4_n00021_SW11 : X_LUT4
    generic map(
      INIT => X"CC6C"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => XLXI_4_addr_c(6),
      ADR2 => Cpu16_I1_nreset_v(1),
      ADR3 => Cpu16_pc_mux(2),
      O => XLXI_4_addr_c_6_F
    );
  Cpu16_I3_Mmux_data_x_Result_7_61 : X_LUT4
    generic map(
      INIT => X"000E"
    )
    port map (
      ADR0 => CHOICE1116,
      ADR1 => CHOICE1113,
      ADR2 => N30906,
      ADR3 => Cpu16_I2_C_store_x,
      O => CHOICE1120_F
    );
  Cpu16_I3_n0147_0_53 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => CHOICE717,
      ADR1 => Cpu16_I3_n0085,
      ADR2 => Cpu16_I3_n0090(0),
      ADR3 => Cpu16_I3_data_x_0_Q,
      O => Cpu16_I3_acc_i_0_0_G
    );
  Cpu16_I3_acc_i_0_1_1115 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_i_0_0_DYMUX,
      CE => Cpu16_I3_acc_i_0_0_CEINV,
      CLK => Cpu16_I3_acc_i_0_0_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_i_0_0_FFY_RST,
      O => Cpu16_I3_acc_i_0_1
    );
  Cpu16_I3_acc_i_0_0_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_i_0_0_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_i_0_0_FFY_RST
    );
  Cpu16_I3_Mmux_data_x_Result_8_61 : X_LUT4
    generic map(
      INIT => X"0504"
    )
    port map (
      ADR0 => N30906,
      ADR1 => CHOICE1058,
      ADR2 => Cpu16_I2_C_store_x,
      ADR3 => Cpu16_I3_Mmux_data_x_Result_8_37_O,
      O => CHOICE1065_F
    );
  Cpu16_I3_n0147_0_208 : X_LUT4
    generic map(
      INIT => X"FE10"
    )
    port map (
      ADR0 => CHOICE713,
      ADR1 => CHOICE720,
      ADR2 => N30890,
      ADR3 => N30892,
      O => Cpu16_I3_acc_i_0_0_F
    );
  Cpu16_I3_acc_i_0_0_1116 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_i_0_0_DXMUX,
      CE => Cpu16_I3_acc_i_0_0_CEINV,
      CLK => Cpu16_I3_acc_i_0_0_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_i_0_0_FFX_RST,
      O => Cpu16_I3_acc_i_0_0
    );
  Cpu16_I3_acc_i_0_0_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_i_0_0_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_i_0_0_FFX_RST
    );
  Cpu16_I3_Mmux_data_x_Result_9_61 : X_LUT4
    generic map(
      INIT => X"000E"
    )
    port map (
      ADR0 => Cpu16_I3_Mmux_data_x_Result_9_37_O,
      ADR1 => CHOICE1003,
      ADR2 => Cpu16_I2_C_store_x,
      ADR3 => N30906,
      O => CHOICE1010_F
    );
  Cpu16_I3_n0147_2_39_SW0 : X_LUT4
    generic map(
      INIT => X"F780"
    )
    port map (
      ADR0 => Cpu16_I3_n0083,
      ADR1 => Cpu16_I3_n0098(2),
      ADR2 => N30379,
      ADR3 => N31948,
      O => Cpu16_I3_acc_i_0_2_G
    );
  Cpu16_I2_ndwe_x1 : X_LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      ADR0 => Cpu16_I2_skip_x,
      ADR1 => Cpu16_I2_TC_x(0),
      ADR2 => N30261,
      ADR3 => Cpu16_I2_C_raw,
      O => Cpu16_I2_TC_c_0_F
    );
  Cpu16_I1_pc_9 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_pc_9_DYMUX,
      CE => VCC,
      CLK => Cpu16_I1_pc_9_CLKINV,
      SET => GND,
      RST => Cpu16_I1_pc_9_FFY_RST,
      O => Cpu16_I1_pc(9)
    );
  Cpu16_I1_pc_9_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I1_pc_9_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I1_pc_9_FFY_RST
    );
  XLXI_3_maddr_9_1 : X_LUT4
    generic map(
      INIT => X"FFDF"
    )
    port map (
      ADR0 => XLXI_3_nadwe_c,
      ADR1 => XLXI_5_dw_s(0),
      ADR2 => Cpu16_I4_ndre_x1_1,
      ADR3 => Cpu16_I1_iaddr_x_9_47_O,
      O => Cpu16_I1_pc_9_F
    );
  Cpu16_I3_n0147_0_27 : X_LUT4
    generic map(
      INIT => X"E2F0"
    )
    port map (
      ADR0 => N31291,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => N31289,
      ADR3 => CHOICE1540,
      O => CHOICE712_F
    );
  Cpu16_I3_Mmux_data_x_Result_3_85 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => CHOICE1340,
      ADR1 => Cpu16_I4_n0202,
      ADR2 => CHOICE1327,
      ADR3 => Cpu16_I4_N18018,
      O => CHOICE856_G
    );
  Cpu16_I3_n0147_1_12 : X_LUT4
    generic map(
      INIT => X"EF40"
    )
    port map (
      ADR0 => Cpu16_I3_n0025,
      ADR1 => N30820,
      ADR2 => CHOICE1485,
      ADR3 => N30842,
      O => CHOICE794_F
    );
  Cpu16_I3_n0147_0_36 : X_LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_0_1,
      ADR1 => Cpu16_I3_Madd_n0098_inst_lut2_44,
      ADR2 => Cpu16_I2_TD_c_2_1,
      ADR3 => Cpu16_I2_TD_c_1_1,
      O => CHOICE713_F
    );
  Cpu16_I3_n0147_2_12 : X_LUT4
    generic map(
      INIT => X"DC8C"
    )
    port map (
      ADR0 => Cpu16_I3_n0025,
      ADR1 => N30848,
      ADR2 => CHOICE1430,
      ADR3 => N30820,
      O => CHOICE825_F
    );
  Cpu16_I4_n020216 : X_LUT4
    generic map(
      INIT => X"0257"
    )
    port map (
      ADR0 => Cpu16_I2_n01501_2,
      ADR1 => MEM_DATA_OUT(12),
      ADR2 => N31072,
      ADR3 => N31070,
      O => CHOICE1553_F
    );
  Cpu16_I4_n020234_SW1 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => MEM_DATA_OUT(11),
      ADR1 => MEM_DATA_OUT(13),
      ADR2 => MEM_DATA_OUT(15),
      ADR3 => MEM_DATA_OUT(14),
      O => CHOICE1562_G
    );
  Cpu16_I3_Mmux_data_x_Result_0_61 : X_LUT4
    generic map(
      INIT => X"0302"
    )
    port map (
      ADR0 => CHOICE1534,
      ADR1 => Cpu16_I2_C_store_x,
      ADR2 => N30906,
      ADR3 => CHOICE1531,
      O => CHOICE1538_F
    );
  Cpu16_I4_n020234 : X_LUT4
    generic map(
      INIT => X"0355"
    )
    port map (
      ADR0 => N31064,
      ADR1 => MEM_DATA_OUT(10),
      ADR2 => N31066,
      ADR3 => Cpu16_I2_n01501_2,
      O => CHOICE1562_F
    );
  Cpu16_I2_Mmux_idata_x_Result_6_1 : X_LUT4
    generic map(
      INIT => X"CCF0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => MEM_DATA_OUT(6),
      ADR2 => Cpu16_I2_idata_c(6),
      ADR3 => Cpu16_I2_n0150,
      O => CHOICE1476_G
    );
  Cpu16_I3_Mmux_data_x_Result_1_32 : X_LUT4
    generic map(
      INIT => X"8A80"
    )
    port map (
      ADR0 => Cpu16_I4_N18357,
      ADR1 => Cpu16_I4_data_exp_c(1),
      ADR2 => Cpu16_daddr_is(2),
      ADR3 => Cpu16_I4_ireg_c(1),
      O => CHOICE1476_F
    );
  Cpu16_I4_n020253 : X_LUT4
    generic map(
      INIT => X"0437"
    )
    port map (
      ADR0 => Cpu16_I2_C_store_x,
      ADR1 => Cpu16_ndwe_int,
      ADR2 => Cpu16_I2_ndre_x1_SW1_O,
      ADR3 => N31051,
      O => Cpu16_I4_n0202_F
    );
  Cpu16_I3_n0147_0_82_SW0 : X_LUT4
    generic map(
      INIT => X"FEDC"
    )
    port map (
      ADR0 => CHOICE712,
      ADR1 => CHOICE746,
      ADR2 => N30438,
      ADR3 => N30440,
      O => Cpu16_I3_acc_c_0_0_1_G
    );
  Cpu16_I2_Mmux_idata_x_Result_5_1 : X_LUT4
    generic map(
      INIT => X"AAF0"
    )
    port map (
      ADR0 => MEM_DATA_OUT(5),
      ADR1 => VCC,
      ADR2 => Cpu16_I2_idata_c(5),
      ADR3 => Cpu16_I2_n0150,
      O => Cpu16_I2_data_is_c_1_G
    );
  Cpu16_I3_n0147_0_208_1 : X_LUT4
    generic map(
      INIT => X"FE10"
    )
    port map (
      ADR0 => CHOICE713,
      ADR1 => CHOICE720,
      ADR2 => N30890,
      ADR3 => N30892,
      O => Cpu16_I3_n0147_0_208_1_O
    );
  Cpu16_I3_Mmux_data_x_Result_11_61 : X_LUT4
    generic map(
      INIT => X"1110"
    )
    port map (
      ADR0 => N30906,
      ADR1 => Cpu16_I2_C_store_x,
      ADR2 => CHOICE893,
      ADR3 => Cpu16_I3_Mmux_data_x_Result_11_37_O,
      O => CHOICE900_F
    );
  Cpu16_I3_n0147_7_12 : X_LUT4
    generic map(
      INIT => X"BA8A"
    )
    port map (
      ADR0 => N30854,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => CHOICE1122,
      ADR3 => N30820,
      O => CHOICE1076_F
    );
  Cpu16_I2_pc_mux_x_0_63 : X_LUT4
    generic map(
      INIT => X"0D2F"
    )
    port map (
      ADR0 => Cpu16_I2_N15700,
      ADR1 => Cpu16_I2_TC_x(0),
      ADR2 => N30884,
      ADR3 => Cpu16_I2_n00971_SW1_O,
      O => CHOICE687_F
    );
  Cpu16_I2_pc_mux_x_1_44 : X_LUT4
    generic map(
      INIT => X"40C8"
    )
    port map (
      ADR0 => Cpu16_I2_TC_x(0),
      ADR1 => CHOICE606,
      ADR2 => N31353,
      ADR3 => N31355,
      O => Cpu16_pc_mux_1_F
    );
  Cpu16_I2_pc_mux_x_2_19 : X_LUT4
    generic map(
      INIT => X"1110"
    )
    port map (
      ADR0 => N30430,
      ADR1 => N31150,
      ADR2 => Cpu16_I2_S_c(2),
      ADR3 => Cpu16_I2_TC_x(0),
      O => Cpu16_pc_mux_2_G
    );
  Cpu16_I3_Mmux_data_x_Result_8_85 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => CHOICE1065,
      ADR1 => Cpu16_I4_N18018,
      ADR2 => Cpu16_I4_n0202,
      ADR3 => CHOICE1052,
      O => CHOICE1131_G
    );
  Cpu16_I3_n0147_8_12 : X_LUT4
    generic map(
      INIT => X"CACC"
    )
    port map (
      ADR0 => N30820,
      ADR1 => N30860,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => CHOICE1067,
      O => CHOICE1131_F
    );
  Cpu16_I3_n0147_9_12 : X_LUT4
    generic map(
      INIT => X"AACA"
    )
    port map (
      ADR0 => N30866,
      ADR1 => N30820,
      ADR2 => CHOICE1012,
      ADR3 => Cpu16_I3_n0025,
      O => CHOICE1186_F
    );
  Cpu16_I3_n0147_6_139 : X_LUT4
    generic map(
      INIT => X"FDF8"
    )
    port map (
      ADR0 => CHOICE1023,
      ADR1 => N30355,
      ADR2 => CHOICE1016,
      ADR3 => Cpu16_I3_n0147_6_39_SW0_O,
      O => Cpu16_I3_acc_i_0_6_F
    );
  Cpu16_I3_acc_i_0_6_1117 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_i_0_6_DXMUX,
      CE => Cpu16_I3_acc_i_0_6_CEINV,
      CLK => Cpu16_I3_acc_i_0_6_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_i_0_6_FFX_RST,
      O => Cpu16_I3_acc_i_0_6
    );
  Cpu16_I3_acc_i_0_6_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_i_0_6_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_i_0_6_FFX_RST
    );
  Cpu16_I4_n020253_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FACA"
    )
    port map (
      ADR0 => N31076,
      ADR1 => N31072,
      ADR2 => Cpu16_I2_n01501_1,
      ADR3 => Cpu16_I4_n020253_SW0_SW0_SW1_O,
      O => N30412_F
    );
  Cpu16_I4_Ker180661 : X_LUT4
    generic map(
      INIT => X"FDEC"
    )
    port map (
      ADR0 => Cpu16_I2_n01501_2,
      ADR1 => Cpu16_daddr_is(2),
      ADR2 => MEM_DATA_OUT(4),
      ADR3 => Cpu16_I2_idata_c(4),
      O => N30416_G
    );
  Cpu16_I2_n01011_SW0 : X_LUT4
    generic map(
      INIT => X"FFDF"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c(0),
      ADR1 => Cpu16_I2_TC_c(2),
      ADR2 => Cpu16_I2_n01011_SW0_SW0_O,
      ADR3 => Cpu16_I2_skip_c,
      O => N30265_F
    );
  Cpu16_I4_n020253_SW1_SW0 : X_LUT4
    generic map(
      INIT => X"8C88"
    )
    port map (
      ADR0 => Cpu16_I4_N18357,
      ADR1 => CHOICE1553,
      ADR2 => Cpu16_I4_N18068,
      ADR3 => Cpu16_daddr_is(1),
      O => N30416_F
    );
  Cpu16_I3_n009675 : X_LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      ADR0 => CHOICE1623,
      ADR1 => CHOICE1608,
      ADR2 => CHOICE1616,
      ADR3 => CHOICE1601,
      O => CHOICE1577_G
    );
  Cpu16_I3_n0147_8_39_SW0 : X_LUT4
    generic map(
      INIT => X"F780"
    )
    port map (
      ADR0 => Cpu16_I3_n0098(8),
      ADR1 => Cpu16_I3_n0083,
      ADR2 => N30343,
      ADR3 => N31938,
      O => Cpu16_I3_acc_i_0_8_G
    );
  Cpu16_I2_n01501_1_1118 : X_LUT4
    generic map(
      INIT => X"BFFF"
    )
    port map (
      ADR0 => N30488,
      ADR1 => NRESET_IN_BUFGP,
      ADR2 => Cpu16_I2_N15618,
      ADR3 => Cpu16_I2_nreset_v(1),
      O => Cpu16_I2_data_is_c_2_G
    );
  Cpu16_I3_Mmux_data_x_Result_4_61 : X_LUT4
    generic map(
      INIT => X"0032"
    )
    port map (
      ADR0 => CHOICE1278,
      ADR1 => Cpu16_I2_ndre_x1_SW4_SW0_O,
      ADR2 => CHOICE1281,
      ADR3 => Cpu16_I2_C_store_x,
      O => CHOICE1285_F
    );
  Cpu16_I3_n0147_13_12 : X_LUT4
    generic map(
      INIT => X"EFEA"
    )
    port map (
      ADR0 => Cpu16_I3_N17389,
      ADR1 => Cpu16_I3_n0087,
      ADR2 => Cpu16_I3_data_x_13_Q,
      ADR3 => Cpu16_I3_n0082,
      O => CHOICE1439_F
    );
  Cpu16_I3_Mmux_data_x_Result_5_61 : X_LUT4
    generic map(
      INIT => X"000E"
    )
    port map (
      ADR0 => CHOICE1226,
      ADR1 => CHOICE1223,
      ADR2 => Cpu16_I2_ndre_x1_SW5_SW0_O,
      ADR3 => Cpu16_I2_C_store_x,
      O => CHOICE1230_F
    );
  Cpu16_I3_n0147_14_12 : X_LUT4
    generic map(
      INIT => X"FCFA"
    )
    port map (
      ADR0 => Cpu16_I3_n0082,
      ADR1 => Cpu16_I3_n0087,
      ADR2 => Cpu16_I3_N17389,
      ADR3 => Cpu16_I3_data_x_14_Q,
      O => CHOICE1494_F
    );
  Cpu16_I3_Mmux_data_x_Result_6_61 : X_LUT4
    generic map(
      INIT => X"0302"
    )
    port map (
      ADR0 => CHOICE1168,
      ADR1 => Cpu16_I2_ndre_x1_SW6_SW0_O,
      ADR2 => Cpu16_I2_C_store_x,
      ADR3 => CHOICE1171,
      O => CHOICE1175_F
    );
  Cpu16_I3_n0147_15_12 : X_LUT4
    generic map(
      INIT => X"FAFC"
    )
    port map (
      ADR0 => Cpu16_I3_n0087,
      ADR1 => Cpu16_I3_n0082,
      ADR2 => Cpu16_I3_N17389,
      ADR3 => Cpu16_I3_data_x_15_Q,
      O => CHOICE1631_F
    );
  Cpu16_I3_n0147_4_139 : X_LUT4
    generic map(
      INIT => X"FEBA"
    )
    port map (
      ADR0 => CHOICE906,
      ADR1 => CHOICE913,
      ADR2 => Cpu16_I3_n0147_4_39_SW0_O,
      ADR3 => N30367,
      O => Cpu16_I3_acc_i_0_4_F
    );
  Cpu16_I3_acc_i_0_4_1119 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_i_0_4_DXMUX,
      CE => Cpu16_I3_acc_i_0_4_CEINV,
      CLK => Cpu16_I3_acc_i_0_4_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_i_0_4_FFX_RST,
      O => Cpu16_I3_acc_i_0_4
    );
  Cpu16_I3_acc_i_0_4_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_i_0_4_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_i_0_4_FFX_RST
    );
  Cpu16_I2_ndre_x1_SW1_SW1 : X_LUT4
    generic map(
      INIT => X"FFCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => N30269,
      ADR2 => VCC,
      ADR3 => Cpu16_I2_C_raw,
      O => N31926_F
    );
  Cpu16_I2_ndwe_x1_SW0 : X_LUT4
    generic map(
      INIT => X"EDFD"
    )
    port map (
      ADR0 => Cpu16_I2_idata_x(3),
      ADR1 => N30434,
      ADR2 => Cpu16_I2_n0077,
      ADR3 => Cpu16_I2_idata_x(0),
      O => N30261_F
    );
  Cpu16_I2_pc_mux_x_0_104 : X_LUT4
    generic map(
      INIT => X"5F4F"
    )
    port map (
      ADR0 => Cpu16_I2_n0145,
      ADR1 => CHOICE687,
      ADR2 => Cpu16_I2_nreset_v_1_1,
      ADR3 => CHOICE679,
      O => Cpu16_pc_mux_0_F
    );
  Cpu16_I3_n0147_6_39_SW0 : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => N31914,
      ADR1 => N30355,
      ADR2 => Cpu16_I3_n0083,
      ADR3 => Cpu16_I3_n0098(6),
      O => Cpu16_I3_acc_i_0_6_G
    );
  Cpu16_I4_n020253_SW0_SW0_SW1 : X_LUT4
    generic map(
      INIT => X"FECF"
    )
    port map (
      ADR0 => MEM_DATA_OUT(6),
      ADR1 => MEM_DATA_OUT(12),
      ADR2 => MEM_DATA_OUT(4),
      ADR3 => MEM_DATA_OUT(5),
      O => N30412_G
    );
  Cpu16_I3_acc_i_0_7_1120 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_i_0_6_DYMUX,
      CE => Cpu16_I3_acc_i_0_6_CEINV,
      CLK => Cpu16_I3_acc_i_0_6_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_i_0_6_FFY_RST,
      O => Cpu16_I3_acc_i_0_7
    );
  Cpu16_I3_acc_i_0_6_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_i_0_6_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_i_0_6_FFY_RST
    );
  Cpu16_I3_acc_c_0_0_1_1121 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_0_1_DXMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_0_1_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_0_1_FFX_RST,
      O => Cpu16_I3_acc_c_0_0_1
    );
  Cpu16_I3_acc_c_0_0_1_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_0_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_0_1_FFX_RST
    );
  Cpu16_I2_data_is_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_data_is_c_1_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_data_is_c_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_data_is_c_1_FFY_RST,
      O => Cpu16_I2_data_is_c(1)
    );
  Cpu16_I2_data_is_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_data_is_c_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_data_is_c_1_FFY_RST
    );
  Cpu16_I3_Mmux_data_x_Result_1_37 : X_LUT4
    generic map(
      INIT => X"0200"
    )
    port map (
      ADR0 => Cpu16_I4_iinc_c(1),
      ADR1 => Cpu16_daddr_is(0),
      ADR2 => Cpu16_daddr_is(2),
      ADR3 => Cpu16_daddr_is(1),
      O => Cpu16_I2_data_is_c_1_F
    );
  Cpu16_I3_Mmux_data_x_Result_1_61 : X_LUT4
    generic map(
      INIT => X"000E"
    )
    port map (
      ADR0 => CHOICE1479,
      ADR1 => CHOICE1476,
      ADR2 => Cpu16_I2_C_store_x,
      ADR3 => Cpu16_I2_ndre_x1_SW1_SW0_O,
      O => CHOICE1483_F
    );
  Cpu16_I2_Mmux_idata_x_Result_4_1 : X_LUT4
    generic map(
      INIT => X"DD88"
    )
    port map (
      ADR0 => Cpu16_I2_n0150,
      ADR1 => MEM_DATA_OUT(4),
      ADR2 => VCC,
      ADR3 => Cpu16_I2_idata_c(4),
      O => CHOICE1424_G
    );
  Cpu16_I3_n0147_10_12 : X_LUT4
    generic map(
      INIT => X"CACC"
    )
    port map (
      ADR0 => N30820,
      ADR1 => N30872,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => CHOICE957,
      O => CHOICE1241_F
    );
  Cpu16_I3_Mmux_data_x_Result_2_32 : X_LUT4
    generic map(
      INIT => X"E200"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_c(2),
      ADR1 => Cpu16_daddr_is(2),
      ADR2 => Cpu16_I4_data_exp_c(2),
      ADR3 => Cpu16_I4_N18357,
      O => CHOICE1421_F
    );
  Cpu16_I4_n0159_2_1 : X_LUT4
    generic map(
      INIT => X"EA40"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I4_iinc_we_c,
      ADR2 => Cpu16_I3_acc_c_0_2,
      ADR3 => Cpu16_I4_iinc_i(2),
      O => Cpu16_I4_n0159(2)
    );
  Cpu16_I4_iinc_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_c_1_DYMUX,
      CE => Cpu16_I4_iinc_c_1_CEINV,
      CLK => Cpu16_I4_iinc_c_1_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_c_1_FFY_RST,
      O => Cpu16_I4_iinc_c(0)
    );
  Cpu16_I4_iinc_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_iinc_c_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_iinc_c_1_FFY_RST
    );
  Cpu16_I4_n0159_1_1 : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I4_iinc_i(1),
      ADR2 => Cpu16_I4_iinc_we_c,
      ADR3 => Cpu16_I3_acc_c_0_1,
      O => Cpu16_I4_n0159(1)
    );
  Cpu16_I4_iinc_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_c_1_DXMUX,
      CE => Cpu16_I4_iinc_c_1_CEINV,
      CLK => Cpu16_I4_iinc_c_1_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_c_1_FFX_RST,
      O => Cpu16_I4_iinc_c(1)
    );
  Cpu16_I4_iinc_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_iinc_c_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_iinc_c_1_FFX_RST
    );
  Cpu16_I4_iinc_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_c_3_DYMUX,
      CE => Cpu16_I4_iinc_c_3_CEINV,
      CLK => Cpu16_I4_iinc_c_3_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_c_3_FFY_RST,
      O => Cpu16_I4_iinc_c(2)
    );
  Cpu16_I4_iinc_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_iinc_c_3_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_iinc_c_3_FFY_RST
    );
  Cpu16_I4_n0159_3_1 : X_LUT4
    generic map(
      INIT => X"AAC0"
    )
    port map (
      ADR0 => Cpu16_I4_iinc_i(3),
      ADR1 => Cpu16_I4_iinc_we_c,
      ADR2 => Cpu16_I3_acc_c_0_3,
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I4_n0159(3)
    );
  Cpu16_I4_n0159_4_1 : X_LUT4
    generic map(
      INIT => X"CCA0"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_4,
      ADR1 => Cpu16_I4_iinc_i(4),
      ADR2 => Cpu16_I4_iinc_we_c,
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I4_n0159(4)
    );
  Cpu16_I4_iinc_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_c_3_DXMUX,
      CE => Cpu16_I4_iinc_c_3_CEINV,
      CLK => Cpu16_I4_iinc_c_3_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_c_3_FFX_RST,
      O => Cpu16_I4_iinc_c(3)
    );
  Cpu16_I4_iinc_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_iinc_c_3_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_iinc_c_3_FFX_RST
    );
  Cpu16_I4_iinc_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_c_5_DYMUX,
      CE => Cpu16_I4_iinc_c_5_CEINV,
      CLK => Cpu16_I4_iinc_c_5_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_c_5_FFY_RST,
      O => Cpu16_I4_iinc_c(4)
    );
  Cpu16_I4_iinc_c_5_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_iinc_c_5_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_iinc_c_5_FFY_RST
    );
  Cpu16_I3_n0147_16_135 : X_LUT4
    generic map(
      INIT => X"FFAC"
    )
    port map (
      ADR0 => Cpu16_I3_n0147_16_13_SW1_O,
      ADR1 => N30510,
      ADR2 => Cpu16_I3_n0090(16),
      ADR3 => CHOICE1408,
      O => Cpu16_I3_acc_i_0_16_F
    );
  Cpu16_I2_Ker155591 : X_LUT4
    generic map(
      INIT => X"ECEE"
    )
    port map (
      ADR0 => Cpu16_I2_N15618,
      ADR1 => Cpu16_I2_E_c_FFd2,
      ADR2 => N30488,
      ADR3 => Cpu16_I2_N15717,
      O => Cpu16_I2_N15561_F
    );
  Cpu16_I3_acc_i_0_16_1122 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_i_0_16_DXMUX,
      CE => Cpu16_I3_acc_i_0_16_CEINV,
      CLK => Cpu16_I3_acc_i_0_16_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_i_0_16_FFX_RST,
      O => Cpu16_I3_acc_i_0_16
    );
  Cpu16_I3_acc_i_0_16_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_i_0_16_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_i_0_16_FFX_RST
    );
  Cpu16_I3_n0147_11_39_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"D8D8"
    )
    port map (
      ADR0 => CHOICE1302,
      ADR1 => N30325,
      ADR2 => N30323,
      ADR3 => VCC,
      O => N31954_F
    );
  Cpu16_I2_ndre_x1_SW2_SW0_SW0_SW2 : X_LUT4
    generic map(
      INIT => X"FF47"
    )
    port map (
      ADR0 => Cpu16_I2_ndre_x1_SW2_SW0_SW0_SW1_O,
      ADR1 => Cpu16_I2_n01501_2,
      ADR2 => N31197,
      ADR3 => N30269,
      O => N31238_F
    );
  Cpu16_I3_n0147_1_72_SW1 : X_LUT4
    generic map(
      INIT => X"E400"
    )
    port map (
      ADR0 => CHOICE794,
      ADR1 => N30671,
      ADR2 => N30673,
      ADR3 => Cpu16_I3_n0023,
      O => N31922_G
    );
  Cpu16_I3_n0147_12_39_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"E2E2"
    )
    port map (
      ADR0 => N30317,
      ADR1 => CHOICE1357,
      ADR2 => N30319,
      ADR3 => VCC,
      O => N31900_F
    );
  Cpu16_I2_Ker156161 : X_LUT4
    generic map(
      INIT => X"FFFC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_E_c_FFd1,
      ADR2 => Cpu16_I2_E_c_FFd4,
      ADR3 => Cpu16_I2_E_c_FFd3,
      O => N30964_G
    );
  Cpu16_I4_Ker183481 : X_LUT4
    generic map(
      INIT => X"F0B0"
    )
    port map (
      ADR0 => Cpu16_I2_C_store_x,
      ADR1 => N30416,
      ADR2 => Cpu16_I4_n0162,
      ADR3 => Cpu16_I2_ndre_x1_SW13_O,
      O => Cpu16_I4_N18350_F
    );
  Cpu16_I2_TC_x_2_SW0 : X_LUT4
    generic map(
      INIT => X"01EF"
    )
    port map (
      ADR0 => MEM_DATA_OUT(2),
      ADR1 => MEM_DATA_OUT(1),
      ADR2 => N30758,
      ADR3 => Cpu16_I2_TC_x_2_SW0_SW1_O,
      O => N21764_F
    );
  Cpu16_I3_acc_i_0_3_1123 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_i_0_2_DYMUX,
      CE => Cpu16_I3_acc_i_0_2_CEINV,
      CLK => Cpu16_I3_acc_i_0_2_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_i_0_2_FFY_RST,
      O => Cpu16_I3_acc_i_0_3
    );
  Cpu16_I3_acc_i_0_2_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_i_0_2_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_i_0_2_FFY_RST
    );
  Cpu16_I3_n0147_2_139 : X_LUT4
    generic map(
      INIT => X"FFE4"
    )
    port map (
      ADR0 => CHOICE827,
      ADR1 => Cpu16_I3_n0147_2_39_SW0_O,
      ADR2 => N30379,
      ADR3 => CHOICE820,
      O => Cpu16_I3_acc_i_0_2_F
    );
  Cpu16_I3_acc_i_0_2_1124 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_i_0_2_DXMUX,
      CE => Cpu16_I3_acc_i_0_2_CEINV,
      CLK => Cpu16_I3_acc_i_0_2_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_i_0_2_FFX_RST,
      O => Cpu16_I3_acc_i_0_2
    );
  Cpu16_I3_acc_i_0_2_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_i_0_2_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_i_0_2_FFX_RST
    );
  Cpu16_I2_ndre_x1_SW0_SW1 : X_LUT4
    generic map(
      INIT => X"FCFC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => N31064,
      ADR2 => N31070,
      ADR3 => VCC,
      O => N31173_F
    );
  Cpu16_I2_ndre_x1_SW12_SW0_SW2 : X_LUT4
    generic map(
      INIT => X"FCFA"
    )
    port map (
      ADR0 => N31185,
      ADR1 => N31187,
      ADR2 => N30269,
      ADR3 => Cpu16_I2_n01501_2,
      O => N31230_F
    );
  Cpu16_I3_n0147_4_39_SW0 : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => N31904,
      ADR1 => N30367,
      ADR2 => Cpu16_I3_n0083,
      ADR3 => Cpu16_I3_n0098(4),
      O => Cpu16_I3_acc_i_0_4_G
    );
  Cpu16_I2_n00951 : X_LUT4
    generic map(
      INIT => X"000E"
    )
    port map (
      ADR0 => Cpu16_I2_idata_x(2),
      ADR1 => Cpu16_I2_idata_x(1),
      ADR2 => Cpu16_I2_skip_x,
      ADR3 => N30562,
      O => N31926_G
    );
  Cpu16_I3_acc_i_0_5_1125 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_i_0_4_DYMUX,
      CE => Cpu16_I3_acc_i_0_4_CEINV,
      CLK => Cpu16_I3_acc_i_0_4_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_i_0_4_FFY_RST,
      O => Cpu16_I3_acc_i_0_5
    );
  Cpu16_I3_acc_i_0_4_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_i_0_4_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_i_0_4_FFY_RST
    );
  Cpu16_I3_n0147_11_106 : X_LUT4
    generic map(
      INIT => X"FAF8"
    )
    port map (
      ADR0 => Cpu16_I3_N17531,
      ADR1 => CHOICE1311,
      ADR2 => CHOICE1310,
      ADR3 => CHOICE1315,
      O => CHOICE1318_F
    );
  Cpu16_I3_n0147_9_19 : X_LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_2_1,
      ADR1 => Cpu16_I3_n0090(9),
      ADR2 => Cpu16_I2_TD_c_0_1,
      ADR3 => Cpu16_I2_TD_c_1_1,
      O => CHOICE1188_F
    );
  Cpu16_I3_Mmux_data_x_Result_5_13 : X_LUT4
    generic map(
      INIT => X"E200"
    )
    port map (
      ADR0 => MEM_DATA_OUT(5),
      ADR1 => XLXI_2_mux_c(0),
      ADR2 => DATA_IN_EXT_5_IBUF,
      ADR3 => NRESET_IN_BUFGP,
      O => CHOICE942_G
    );
  Cpu16_I3_Mmux_data_x_Result_10_13 : X_LUT4
    generic map(
      INIT => X"B800"
    )
    port map (
      ADR0 => DATA_IN_EXT_10_IBUF,
      ADR1 => XLXI_2_mux_c(0),
      ADR2 => MEM_DATA_OUT(10),
      ADR3 => NRESET_IN_BUFGP,
      O => CHOICE942_F
    );
  Cpu16_I3_Mmux_data_x_Result_4_37 : X_LUT4
    generic map(
      INIT => X"0200"
    )
    port map (
      ADR0 => Cpu16_I4_iinc_c(4),
      ADR1 => Cpu16_daddr_is(0),
      ADR2 => Cpu16_daddr_is(2),
      ADR3 => Cpu16_daddr_is(1),
      O => CHOICE1226_G
    );
  Cpu16_I3_Mmux_data_x_Result_5_37 : X_LUT4
    generic map(
      INIT => X"0400"
    )
    port map (
      ADR0 => Cpu16_daddr_is(0),
      ADR1 => Cpu16_I4_iinc_c(5),
      ADR2 => Cpu16_daddr_is(2),
      ADR3 => Cpu16_daddr_is(1),
      O => CHOICE1226_F
    );
  Cpu16_I3_n00251 : X_LUT4
    generic map(
      INIT => X"0202"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_0_1,
      ADR2 => Cpu16_I2_TC_c_2_1,
      ADR3 => VCC,
      O => N31026_G
    );
  Cpu16_I3_Mmux_data_x_Result_0_85_SW3 : X_LUT4
    generic map(
      INIT => X"AF50"
    )
    port map (
      ADR0 => Cpu16_I2_data_is_c(0),
      ADR1 => VCC,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => Cpu16_I3_acc_c_0_0,
      O => N31026_F
    );
  Cpu16_I3_Mmux_data_x_Result_5_32 : X_LUT4
    generic map(
      INIT => X"C088"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_c(5),
      ADR1 => Cpu16_I4_N18357,
      ADR2 => Cpu16_I4_data_exp_c(5),
      ADR3 => Cpu16_daddr_is(2),
      O => CHOICE1168_G
    );
  Cpu16_I3_n0147_12_29 : X_LUT4
    generic map(
      INIT => X"A0A8"
    )
    port map (
      ADR0 => Cpu16_I3_data_x_12_Q,
      ADR1 => Cpu16_I3_n0082,
      ADR2 => Cpu16_I3_N17242,
      ADR3 => Cpu16_I3_acc_c_0_12,
      O => CHOICE1445_G
    );
  Cpu16_I3_n0147_13_29 : X_LUT4
    generic map(
      INIT => X"C0C8"
    )
    port map (
      ADR0 => Cpu16_I3_n0082,
      ADR1 => Cpu16_I3_data_x_13_Q,
      ADR2 => Cpu16_I3_N17242,
      ADR3 => Cpu16_I3_acc_c_0_13,
      O => CHOICE1445_F
    );
  XLXI_5_Mmux_cpu_daddr_out_Result_6_1 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_5_cpu_daddr_c(6),
      ADR1 => XLXI_5_N12936,
      ADR2 => XLXI_5_N12957,
      ADR3 => CPU_ADADDR_OUT(6),
      O => ADDR_OUT_EXT_6_OBUF_F
    );
  Cpu16_I2_n0103_SW1_SW1_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"CFFF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_idata_c(3),
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => Cpu16_I2_idata_c(0),
      O => N31801_F
    );
  Cpu16_I2_ndre_x1_SW5_SW0_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"C080"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(2),
      ADR1 => NRESET_IN_BUFGP,
      ADR2 => Cpu16_I4_nreset_v(1),
      ADR3 => Cpu16_I2_idata_c(1),
      O => N31203_G
    );
  Cpu16_I2_ndre_x1_SW3_SW0_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"C080"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(2),
      ADR1 => NRESET_IN_BUFGP,
      ADR2 => Cpu16_I4_nreset_v(1),
      ADR3 => Cpu16_I2_idata_c(1),
      O => N31203_F
    );
  Cpu16_I2_TD_c_0_3_1126 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TD_c_0_3_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_TD_c_0_3_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TD_c_0_3_FFY_RST,
      O => Cpu16_I2_TD_c_0_3
    );
  Cpu16_I2_TD_c_0_3_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TD_c_0_3_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TD_c_0_3_FFY_RST
    );
  Cpu16_I2_TD_c_2_3_1127 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TD_c_2_3_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_TD_c_2_3_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TD_c_2_3_FFY_RST,
      O => Cpu16_I2_TD_c_2_3
    );
  Cpu16_I2_TD_c_2_3_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TD_c_2_3_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TD_c_2_3_FFY_RST
    );
  Cpu16_I3_n0147_7_39_SW0 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N30349,
      ADR1 => Cpu16_I3_n0083,
      ADR2 => N31968,
      ADR3 => Cpu16_I3_n0098(7),
      O => Cpu16_I3_acc_c_0_7_G
    );
  Cpu16_I3_acc_c_0_3_1128 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_3_DXMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_3_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_3_FFX_RST,
      O => Cpu16_I3_acc_c_0_3
    );
  Cpu16_I3_acc_c_0_3_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_3_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_3_FFX_RST
    );
  Cpu16_I3_acc_c_0_4_1129 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_5_DYMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_5_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_5_FFY_RST,
      O => Cpu16_I3_acc_c_0_4
    );
  Cpu16_I3_acc_c_0_5_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_5_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_5_FFY_RST
    );
  Cpu16_I3_n0147_5_139 : X_LUT4
    generic map(
      INIT => X"FFD8"
    )
    port map (
      ADR0 => CHOICE968,
      ADR1 => N30361,
      ADR2 => Cpu16_I3_n0147_5_39_SW0_O,
      ADR3 => CHOICE961,
      O => Cpu16_I3_acc_c_0_5_F
    );
  Cpu16_I3_acc_c_0_5_1130 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_5_DXMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_5_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_5_FFX_RST,
      O => Cpu16_I3_acc_c_0_5
    );
  Cpu16_I3_acc_c_0_5_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_5_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_5_FFX_RST
    );
  Cpu16_I3_acc_c_0_6_1131 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_7_DYMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_7_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_7_FFY_RST,
      O => Cpu16_I3_acc_c_0_6
    );
  Cpu16_I3_acc_c_0_7_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_7_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_7_FFY_RST
    );
  Cpu16_I3_n0147_7_139 : X_LUT4
    generic map(
      INIT => X"EFEC"
    )
    port map (
      ADR0 => N30349,
      ADR1 => CHOICE1071,
      ADR2 => CHOICE1078,
      ADR3 => Cpu16_I3_n0147_7_39_SW0_O,
      O => Cpu16_I3_acc_c_0_7_F
    );
  Cpu16_I3_acc_c_0_7_1132 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_7_DXMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_7_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_7_FFX_RST,
      O => Cpu16_I3_acc_c_0_7
    );
  Cpu16_I3_acc_c_0_7_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_7_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_7_FFX_RST
    );
  Cpu16_I2_pc_mux_x_0_61_SW1 : X_LUT4
    generic map(
      INIT => X"AA22"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_I2_skip_x,
      ADR2 => VCC,
      ADR3 => Cpu16_I2_n0166(2),
      O => Cpu16_I2_E_c_FFd1_F
    );
  Cpu16_I3_n0147_10_39_SW0 : X_LUT4
    generic map(
      INIT => X"E2AA"
    )
    port map (
      ADR0 => N31934,
      ADR1 => Cpu16_I3_n0083,
      ADR2 => N30331,
      ADR3 => Cpu16_I3_n0098(10),
      O => Cpu16_I3_acc_i_0_10_G
    );
  Cpu16_I3_n0147_12_39_SW0 : X_LUT4
    generic map(
      INIT => X"CAAA"
    )
    port map (
      ADR0 => N31900,
      ADR1 => N30319,
      ADR2 => Cpu16_I3_n0083,
      ADR3 => Cpu16_I3_n0098(12),
      O => Cpu16_I3_acc_i_0_12_G
    );
  Cpu16_I3_acc_i_0_11_1133 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_i_0_10_DYMUX,
      CE => Cpu16_I3_acc_i_0_10_CEINV,
      CLK => Cpu16_I3_acc_i_0_10_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_i_0_10_FFY_RST,
      O => Cpu16_I3_acc_i_0_11
    );
  Cpu16_I3_acc_i_0_10_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_i_0_10_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_i_0_10_FFY_RST
    );
  Cpu16_I3_n0147_10_139 : X_LUT4
    generic map(
      INIT => X"FBEA"
    )
    port map (
      ADR0 => CHOICE1236,
      ADR1 => CHOICE1243,
      ADR2 => N30331,
      ADR3 => Cpu16_I3_n0147_10_39_SW0_O,
      O => Cpu16_I3_acc_i_0_10_F
    );
  Cpu16_I3_acc_i_0_10_1134 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_i_0_10_DXMUX,
      CE => Cpu16_I3_acc_i_0_10_CEINV,
      CLK => Cpu16_I3_acc_i_0_10_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_i_0_10_FFX_RST,
      O => Cpu16_I3_acc_i_0_10
    );
  Cpu16_I3_acc_i_0_10_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_i_0_10_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_i_0_10_FFX_RST
    );
  Cpu16_I3_n0147_14_39_SW0 : X_LUT4
    generic map(
      INIT => X"D8F0"
    )
    port map (
      ADR0 => Cpu16_I3_n0098(14),
      ADR1 => N30307,
      ADR2 => N31896,
      ADR3 => Cpu16_I3_n0083,
      O => Cpu16_I3_acc_i_0_14_G
    );
  Cpu16_I3_acc_i_0_13_1135 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_i_0_12_DYMUX,
      CE => Cpu16_I3_acc_i_0_12_CEINV,
      CLK => Cpu16_I3_acc_i_0_12_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_i_0_12_FFY_RST,
      O => Cpu16_I3_acc_i_0_13
    );
  Cpu16_I3_acc_i_0_12_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_i_0_12_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_i_0_12_FFY_RST
    );
  Cpu16_I3_n0147_12_139 : X_LUT4
    generic map(
      INIT => X"FDF8"
    )
    port map (
      ADR0 => CHOICE1353,
      ADR1 => N30319,
      ADR2 => CHOICE1346,
      ADR3 => Cpu16_I3_n0147_12_39_SW0_O,
      O => Cpu16_I3_acc_i_0_12_F
    );
  Cpu16_I3_n0147_15_39_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FA50"
    )
    port map (
      ADR0 => CHOICE1637,
      ADR1 => VCC,
      ADR2 => N30299,
      ADR3 => N30301,
      O => N31944_F
    );
  Cpu16_I2_ndre_x1_SW4_SW0_SW0_SW2 : X_LUT4
    generic map(
      INIT => X"F2F7"
    )
    port map (
      ADR0 => Cpu16_I2_n01501_2,
      ADR1 => Cpu16_I2_ndre_x1_SW4_SW0_SW0_SW1_O,
      ADR2 => N30269,
      ADR3 => N31264,
      O => N31271_F
    );
  Cpu16_I3_n0147_4_39_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FA0A"
    )
    port map (
      ADR0 => N30365,
      ADR1 => VCC,
      ADR2 => CHOICE917,
      ADR3 => N30367,
      O => N31904_F
    );
  Cpu16_I4_n0160_0_1 : X_LUT4
    generic map(
      INIT => X"E4A0"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I3_acc_c_0_0_1,
      ADR2 => Cpu16_I4_data_exp_i(0),
      ADR3 => Cpu16_I4_dexp_we_c,
      O => Cpu16_I4_n0160(0)
    );
  Cpu16_I4_data_exp_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_c_1_DYMUX,
      CE => Cpu16_I4_data_exp_c_1_CEINV,
      CLK => Cpu16_I4_data_exp_c_1_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_c_1_FFY_RST,
      O => Cpu16_I4_data_exp_c(0)
    );
  Cpu16_I4_data_exp_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_data_exp_c_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_data_exp_c_1_FFY_RST
    );
  Cpu16_I4_n0160_1_1 : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I4_data_exp_i(1),
      ADR2 => Cpu16_I3_acc_c_0_1,
      ADR3 => Cpu16_I4_dexp_we_c,
      O => Cpu16_I4_n0160(1)
    );
  Cpu16_I4_n0160_2_1 : X_LUT4
    generic map(
      INIT => X"EA40"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I3_acc_c_0_2,
      ADR2 => Cpu16_I4_dexp_we_c,
      ADR3 => Cpu16_I4_data_exp_i(2),
      O => Cpu16_I4_n0160(2)
    );
  Cpu16_I4_data_exp_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_c_1_DXMUX,
      CE => Cpu16_I4_data_exp_c_1_CEINV,
      CLK => Cpu16_I4_data_exp_c_1_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_c_1_FFX_RST,
      O => Cpu16_I4_data_exp_c(1)
    );
  Cpu16_I4_data_exp_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_data_exp_c_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_data_exp_c_1_FFX_RST
    );
  Cpu16_I4_data_exp_x_8_1 : X_LUT4
    generic map(
      INIT => X"F808"
    )
    port map (
      ADR0 => Cpu16_I4_data_exp_c(8),
      ADR1 => Cpu16_I4_n01621_1,
      ADR2 => Cpu16_I4_dexp_we_c,
      ADR3 => Cpu16_I3_acc_c_0_8,
      O => Cpu16_I4_iadata_x(20)
    );
  Cpu16_I4_data_exp_x_7_1 : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => Cpu16_I4_dexp_we_c,
      ADR1 => Cpu16_I3_acc_c_0_7,
      ADR2 => Cpu16_I4_n01621_1,
      ADR3 => Cpu16_I4_data_exp_c(7),
      O => Cpu16_I4_iadata_x(19)
    );
  Cpu16_I4_dexp_we_x1 : X_LUT4
    generic map(
      INIT => X"C000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I4_N18224,
      ADR2 => Cpu16_I2_Mmux_idata_x_Result_6_1_1,
      ADR3 => Cpu16_I4_N18357,
      O => Cpu16_I4_dexp_we_x
    );
  Cpu16_I4_data_exp_i_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_i_7_DXMUX,
      CE => Cpu16_I4_data_exp_i_7_CEINV,
      CLK => Cpu16_I4_data_exp_i_7_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_i_7_FFX_RST,
      O => Cpu16_I4_data_exp_i(7)
    );
  Cpu16_I4_data_exp_i_7_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_data_exp_i_7_FFX_RST
    );
  Cpu16_I4_data_exp_i_8 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_i_9_DYMUX,
      CE => Cpu16_I4_data_exp_i_9_CEINV,
      CLK => Cpu16_I4_data_exp_i_9_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_i_9_FFY_RST,
      O => Cpu16_I4_data_exp_i(8)
    );
  Cpu16_I4_data_exp_i_9_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_data_exp_i_9_FFY_RST
    );
  Cpu16_I4_n0160_10_1 : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I4_data_exp_i(10),
      ADR2 => Cpu16_I3_acc_c_0_10,
      ADR3 => Cpu16_I4_dexp_we_c,
      O => Cpu16_I4_n0160(10)
    );
  Cpu16_I4_data_exp_x_9_1 : X_LUT4
    generic map(
      INIT => X"CAC0"
    )
    port map (
      ADR0 => Cpu16_I4_data_exp_c(9),
      ADR1 => Cpu16_I3_acc_c_0_9,
      ADR2 => Cpu16_I4_dexp_we_c,
      ADR3 => Cpu16_I4_n01621_1,
      O => Cpu16_I4_iadata_x(21)
    );
  Cpu16_I4_data_exp_i_9 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_i_9_DXMUX,
      CE => Cpu16_I4_data_exp_i_9_CEINV,
      CLK => Cpu16_I4_data_exp_i_9_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_i_9_FFX_RST,
      O => Cpu16_I4_data_exp_i(9)
    );
  Cpu16_I4_data_exp_i_9_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_data_exp_i_9_FFX_RST
    );
  Cpu16_I4_dexp_we_c_1136 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_we_c_DYMUX,
      CE => VCC,
      CLK => Cpu16_I4_ireg_we_c_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_we_c_FFY_RST,
      O => Cpu16_I4_dexp_we_c
    );
  Cpu16_I4_ireg_we_c_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_ireg_we_c_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_ireg_we_c_FFY_RST
    );
  Cpu16_I4_ireg_we_x1 : X_LUT4
    generic map(
      INIT => X"0C00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I4_N18224,
      ADR2 => Cpu16_I2_Mmux_idata_x_Result_6_1_1,
      ADR3 => Cpu16_I4_N18357,
      O => Cpu16_I4_ireg_we_x
    );
  Cpu16_I4_ireg_we_c_1137 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_ireg_we_c_DXMUX,
      CE => VCC,
      CLK => Cpu16_I4_ireg_we_c_CLKINV,
      SET => GND,
      RST => Cpu16_I4_ireg_we_c_FFX_RST,
      O => Cpu16_I4_ireg_we_c
    );
  Cpu16_I4_ireg_we_c_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_ireg_we_c_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_ireg_we_c_FFX_RST
    );
  Cpu16_I4_data_exp_i_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_i_1_DYMUX,
      CE => Cpu16_I4_data_exp_i_1_CEINV,
      CLK => Cpu16_I4_data_exp_i_1_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_i_1_FFY_RST,
      O => Cpu16_I4_data_exp_i(1)
    );
  Cpu16_I4_data_exp_i_1_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_data_exp_i_1_FFY_RST
    );
  Cpu16_I4_data_exp_x_3_1 : X_LUT4
    generic map(
      INIT => X"E2C0"
    )
    port map (
      ADR0 => Cpu16_I4_data_exp_c(3),
      ADR1 => Cpu16_I4_dexp_we_c,
      ADR2 => Cpu16_I3_acc_c_0_3,
      ADR3 => Cpu16_I4_n0162,
      O => Cpu16_I4_data_exp_i_3_G
    );
  Cpu16_I3_Mmux_data_x_Result_13_SW1 : X_LUT4
    generic map(
      INIT => X"A555"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_13,
      ADR1 => VCC,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => Cpu16_data_is_int(13),
      O => Cpu16_I4_data_exp_i_1_F
    );
  Cpu16_I4_data_exp_x_4_1 : X_LUT4
    generic map(
      INIT => X"F088"
    )
    port map (
      ADR0 => Cpu16_I4_data_exp_c(4),
      ADR1 => Cpu16_I4_n01621_1,
      ADR2 => Cpu16_I3_acc_c_0_4,
      ADR3 => Cpu16_I4_dexp_we_c,
      O => Cpu16_I4_iadata_x(16)
    );
  Cpu16_I4_data_exp_i_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_i_3_DYMUX,
      CE => Cpu16_I4_data_exp_i_3_CEINV,
      CLK => Cpu16_I4_data_exp_i_3_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_i_3_FFY_RST,
      O => Cpu16_I4_data_exp_i(3)
    );
  Cpu16_I4_data_exp_i_3_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_data_exp_i_3_FFY_RST
    );
  Cpu16_I3_n0147_3_0 : X_LUT4
    generic map(
      INIT => X"C0C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_N17152,
      ADR2 => Cpu16_I3_acc_c_0_3,
      ADR3 => VCC,
      O => Cpu16_I4_data_exp_i_3_F
    );
  Cpu16_I4_data_exp_x_6_1 : X_LUT4
    generic map(
      INIT => X"EA40"
    )
    port map (
      ADR0 => Cpu16_I4_dexp_we_c,
      ADR1 => Cpu16_I4_data_exp_c(6),
      ADR2 => Cpu16_I4_n01621_1,
      ADR3 => Cpu16_I3_acc_c_0_6,
      O => Cpu16_I4_iadata_x(18)
    );
  Cpu16_I4_data_exp_i_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_i_5_DYMUX,
      CE => Cpu16_I4_data_exp_i_5_CEINV,
      CLK => Cpu16_I4_data_exp_i_5_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_i_5_FFY_RST,
      O => Cpu16_I4_data_exp_i(4)
    );
  Cpu16_I4_data_exp_i_5_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_data_exp_i_5_FFY_RST
    );
  Cpu16_I4_data_exp_x_5_1 : X_LUT4
    generic map(
      INIT => X"CCA0"
    )
    port map (
      ADR0 => Cpu16_I4_data_exp_c(5),
      ADR1 => Cpu16_I3_acc_c_0_5,
      ADR2 => Cpu16_I4_n01621_1,
      ADR3 => Cpu16_I4_dexp_we_c,
      O => Cpu16_I4_iadata_x(17)
    );
  Cpu16_I4_data_exp_i_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_i_5_DXMUX,
      CE => Cpu16_I4_data_exp_i_5_CEINV,
      CLK => Cpu16_I4_data_exp_i_5_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_i_5_FFX_RST,
      O => Cpu16_I4_data_exp_i(5)
    );
  Cpu16_I4_data_exp_i_5_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_data_exp_i_5_FFX_RST
    );
  Cpu16_I4_data_exp_i_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_i_7_DYMUX,
      CE => Cpu16_I4_data_exp_i_7_CEINV,
      CLK => Cpu16_I4_data_exp_i_7_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_i_7_FFY_RST,
      O => Cpu16_I4_data_exp_i(6)
    );
  Cpu16_I4_data_exp_i_7_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_data_exp_i_7_FFY_RST
    );
  Cpu16_I4_n0160_7_1 : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I4_data_exp_i(7),
      ADR2 => Cpu16_I3_acc_c_0_7,
      ADR3 => Cpu16_I4_dexp_we_c,
      O => Cpu16_I4_n0160(7)
    );
  Cpu16_I4_data_exp_c_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_c_7_DXMUX,
      CE => Cpu16_I4_data_exp_c_7_CEINV,
      CLK => Cpu16_I4_data_exp_c_7_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_c_7_FFX_RST,
      O => Cpu16_I4_data_exp_c(7)
    );
  Cpu16_I4_data_exp_c_7_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_data_exp_c_7_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_data_exp_c_7_FFX_RST
    );
  Cpu16_I4_data_exp_c_8 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_c_9_DYMUX,
      CE => Cpu16_I4_data_exp_c_9_CEINV,
      CLK => Cpu16_I4_data_exp_c_9_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_c_9_FFY_RST,
      O => Cpu16_I4_data_exp_c(8)
    );
  Cpu16_I4_data_exp_c_9_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_data_exp_c_9_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_data_exp_c_9_FFY_RST
    );
  Cpu16_I4_data_exp_x_0_1 : X_LUT4
    generic map(
      INIT => X"F088"
    )
    port map (
      ADR0 => Cpu16_I4_data_exp_c(0),
      ADR1 => Cpu16_I4_n0162,
      ADR2 => Cpu16_I3_acc_c_0_0,
      ADR3 => Cpu16_I4_dexp_we_c,
      O => Cpu16_I4_data_exp_i_0_G
    );
  Cpu16_I4_n0160_9_1 : X_LUT4
    generic map(
      INIT => X"AAC0"
    )
    port map (
      ADR0 => Cpu16_I4_data_exp_i(9),
      ADR1 => Cpu16_I4_dexp_we_c,
      ADR2 => Cpu16_I3_acc_c_0_9,
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I4_n0160(9)
    );
  Cpu16_I4_data_exp_x_1_1 : X_LUT4
    generic map(
      INIT => X"EA40"
    )
    port map (
      ADR0 => Cpu16_I4_dexp_we_c,
      ADR1 => Cpu16_I4_n0162,
      ADR2 => Cpu16_I4_data_exp_c(1),
      ADR3 => Cpu16_I3_acc_c_0_1,
      O => Cpu16_I4_data_exp_i_1_G
    );
  Cpu16_I4_data_exp_c_9 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_c_9_DXMUX,
      CE => Cpu16_I4_data_exp_c_9_CEINV,
      CLK => Cpu16_I4_data_exp_c_9_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_c_9_FFX_RST,
      O => Cpu16_I4_data_exp_c(9)
    );
  Cpu16_I4_data_exp_c_9_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_data_exp_c_9_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_data_exp_c_9_FFX_RST
    );
  Cpu16_I4_data_exp_i_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_i_0_DYMUX,
      CE => Cpu16_I4_data_exp_i_0_CEINV,
      CLK => Cpu16_I4_data_exp_i_0_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_i_0_FFY_RST,
      O => Cpu16_I4_data_exp_i(0)
    );
  Cpu16_I4_data_exp_i_0_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_data_exp_i_0_FFY_RST
    );
  Cpu16_I3_Mmux_data_x_Result_12_SW1 : X_LUT4
    generic map(
      INIT => X"C03F"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => Cpu16_data_is_int(12),
      ADR3 => Cpu16_I3_acc_c_0_12,
      O => Cpu16_I4_data_exp_i_0_F
    );
  Cpu16_I4_daddr_x_8_1 : X_LUT4
    generic map(
      INIT => X"B080"
    )
    port map (
      ADR0 => Cpu16_daddr_is(8),
      ADR1 => Cpu16_I4_N18033,
      ADR2 => Cpu16_I4_n0162,
      ADR3 => Cpu16_I4_ireg_c(8),
      O => XLXI_3_daddr_c_8_G
    );
  XLXI_3_daddr_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_daddr_c_5_DXMUX,
      CE => XLXI_3_daddr_c_5_CEINV,
      CLK => XLXI_3_daddr_c_5_CLKINV,
      SET => GND,
      RST => XLXI_3_daddr_c_5_FFX_RST,
      O => XLXI_3_daddr_c(5)
    );
  XLXI_3_daddr_c_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_daddr_c_5_SRINVNOT,
      I1 => GSR,
      O => XLXI_3_daddr_c_5_FFX_RST
    );
  XLXI_3_daddr_c_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_daddr_c_7_DYMUX,
      CE => XLXI_3_daddr_c_7_CEINV,
      CLK => XLXI_3_daddr_c_7_CLKINV,
      SET => GND,
      RST => XLXI_3_daddr_c_7_FFY_RST,
      O => XLXI_3_daddr_c(6)
    );
  XLXI_3_daddr_c_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_daddr_c_7_SRINVNOT,
      I1 => GSR,
      O => XLXI_3_daddr_c_7_FFY_RST
    );
  Cpu16_I4_daddr_x_7_1 : X_LUT4
    generic map(
      INIT => X"A0C0"
    )
    port map (
      ADR0 => Cpu16_daddr_is(7),
      ADR1 => Cpu16_I4_ireg_c(7),
      ADR2 => Cpu16_I4_n0162,
      ADR3 => Cpu16_I4_N18033,
      O => XLXI_3_daddr_c_7_F
    );
  XLXI_3_daddr_c_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_daddr_c_7_DXMUX,
      CE => XLXI_3_daddr_c_7_CEINV,
      CLK => XLXI_3_daddr_c_7_CLKINV,
      SET => GND,
      RST => XLXI_3_daddr_c_7_FFX_RST,
      O => XLXI_3_daddr_c(7)
    );
  XLXI_3_daddr_c_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_daddr_c_7_SRINVNOT,
      I1 => GSR,
      O => XLXI_3_daddr_c_7_FFX_RST
    );
  Cpu16_I3_n0147_3_39_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"F5A0"
    )
    port map (
      ADR0 => CHOICE862,
      ADR1 => VCC,
      ADR2 => N30373,
      ADR3 => N30371,
      O => N31984_F
    );
  Cpu16_I3_n0147_15_72_SW1 : X_LUT4
    generic map(
      INIT => X"C808"
    )
    port map (
      ADR0 => N30635,
      ADR1 => Cpu16_I3_n0023,
      ADR2 => CHOICE1631,
      ADR3 => N30637,
      O => N31944_G
    );
  XLXI_3_daddr_c_8 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_daddr_c_8_DYMUX,
      CE => XLXI_3_daddr_c_8_CEINV,
      CLK => XLXI_3_daddr_c_8_CLKINV,
      SET => GND,
      RST => XLXI_3_daddr_c_8_FFY_RST,
      O => XLXI_3_daddr_c(8)
    );
  XLXI_3_daddr_c_8_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_daddr_c_8_SRINVNOT,
      I1 => GSR,
      O => XLXI_3_daddr_c_8_FFY_RST
    );
  Cpu16_I3_Mmux_data_x_Result_8_32 : X_LUT4
    generic map(
      INIT => X"E200"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_c(8),
      ADR1 => Cpu16_I2_Mmux_idata_x_Result_6_1_1,
      ADR2 => Cpu16_I4_data_exp_c(8),
      ADR3 => Cpu16_I4_N18357,
      O => XLXI_3_daddr_c_8_F
    );
  Cpu16_I3_n0147_14_39_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"F3C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CHOICE1500,
      ADR2 => N30307,
      ADR3 => N30305,
      O => N31896_F
    );
  Cpu16_I4_daddr_x_3_1 : X_LUT4
    generic map(
      INIT => X"C480"
    )
    port map (
      ADR0 => Cpu16_I4_N18033,
      ADR1 => Cpu16_I4_n0162,
      ADR2 => Cpu16_daddr_is(3),
      ADR3 => Cpu16_I4_ireg_c(3),
      O => XLXI_3_daddr_c_3_G
    );
  Cpu16_I4_daddr_x_6_1 : X_LUT4
    generic map(
      INIT => X"C088"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_c(6),
      ADR1 => Cpu16_I4_n0162,
      ADR2 => Cpu16_daddr_is(6),
      ADR3 => Cpu16_I4_N18033,
      O => XLXI_3_daddr_c_7_G
    );
  XLXI_3_daddr_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_daddr_c_3_DYMUX,
      CE => XLXI_3_daddr_c_3_CEINV,
      CLK => XLXI_3_daddr_c_3_CLKINV,
      SET => GND,
      RST => XLXI_3_daddr_c_3_FFY_RST,
      O => XLXI_3_daddr_c(3)
    );
  XLXI_3_daddr_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_daddr_c_3_SRINVNOT,
      I1 => GSR,
      O => XLXI_3_daddr_c_3_FFY_RST
    );
  Cpu16_I2_TD_x_0_22 : X_LUT4
    generic map(
      INIT => X"033F"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_Mmux_idata_x_Result_6_1_1,
      ADR2 => Cpu16_daddr_is(3),
      ADR3 => Cpu16_daddr_is(1),
      O => XLXI_3_daddr_c_3_F
    );
  Cpu16_I4_daddr_x_4_1 : X_LUT4
    generic map(
      INIT => X"8A80"
    )
    port map (
      ADR0 => Cpu16_I4_n0162,
      ADR1 => Cpu16_daddr_is(4),
      ADR2 => Cpu16_I4_N18033,
      ADR3 => Cpu16_I4_ireg_c(4),
      O => XLXI_3_daddr_c_5_G
    );
  XLXI_3_daddr_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_daddr_c_5_DYMUX,
      CE => XLXI_3_daddr_c_5_CEINV,
      CLK => XLXI_3_daddr_c_5_CLKINV,
      SET => GND,
      RST => XLXI_3_daddr_c_5_FFY_RST,
      O => XLXI_3_daddr_c(4)
    );
  XLXI_3_daddr_c_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_daddr_c_5_SRINVNOT,
      I1 => GSR,
      O => XLXI_3_daddr_c_5_FFY_RST
    );
  Cpu16_I4_daddr_x_5_1 : X_LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      ADR0 => Cpu16_I4_n0162,
      ADR1 => Cpu16_I4_ireg_c(5),
      ADR2 => Cpu16_I4_N18033,
      ADR3 => Cpu16_daddr_is(5),
      O => XLXI_3_daddr_c_5_F
    );
  Cpu16_I2_n0103_SW1_SW1_SW0 : X_LUT4
    generic map(
      INIT => X"0020"
    )
    port map (
      ADR0 => Cpu16_I2_nreset_v(1),
      ADR1 => N31801,
      ADR2 => Cpu16_I2_N15618,
      ADR3 => N30488,
      O => N30964_F
    );
  Cpu16_I3_n0147_1_39_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FC0C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => N30383,
      ADR2 => CHOICE800,
      ADR3 => N30385,
      O => N31922_F
    );
  Cpu16_I2_n0103_SW1_SW1_SW1 : X_LUT4
    generic map(
      INIT => X"CC8C"
    )
    port map (
      ADR0 => N30488,
      ADR1 => N31217,
      ADR2 => Cpu16_I2_N15618,
      ADR3 => Cpu16_I2_n0103_SW1_SW0_O,
      O => N30966_F
    );
  Cpu16_I3_n0147_13_39_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FC0C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => N30311,
      ADR2 => CHOICE1445,
      ADR3 => N30313,
      O => N31972_F
    );
  Cpu16_I3_n0147_14_72_SW1 : X_LUT4
    generic map(
      INIT => X"E040"
    )
    port map (
      ADR0 => CHOICE1494,
      ADR1 => N30623,
      ADR2 => Cpu16_I3_n0023,
      ADR3 => N30625,
      O => N31896_G
    );
  Cpu16_I2_ndre_x1_SW3_SW0_SW0_SW2 : X_LUT4
    generic map(
      INIT => X"DDCF"
    )
    port map (
      ADR0 => Cpu16_I2_ndre_x1_SW3_SW0_SW0_SW1_O,
      ADR1 => N30269,
      ADR2 => N31203,
      ADR3 => Cpu16_I2_n01501_2,
      O => N31242_F
    );
  Cpu16_I3_n0147_2_39_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"EE44"
    )
    port map (
      ADR0 => CHOICE831,
      ADR1 => N30377,
      ADR2 => VCC,
      ADR3 => N30379,
      O => N31948_F
    );
  Cpu16_I4_n0160_4_1 : X_LUT4
    generic map(
      INIT => X"F088"
    )
    port map (
      ADR0 => Cpu16_I4_dexp_we_c,
      ADR1 => Cpu16_I3_acc_c_0_4,
      ADR2 => Cpu16_I4_data_exp_i(4),
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I4_n0160(4)
    );
  Cpu16_I4_data_exp_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_c_3_DYMUX,
      CE => Cpu16_I4_data_exp_c_3_CEINV,
      CLK => Cpu16_I4_data_exp_c_3_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_c_3_FFY_RST,
      O => Cpu16_I4_data_exp_c(2)
    );
  Cpu16_I4_data_exp_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_data_exp_c_3_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_data_exp_c_3_FFY_RST
    );
  Cpu16_I4_n0160_3_1 : X_LUT4
    generic map(
      INIT => X"EA40"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I3_acc_c_0_3,
      ADR2 => Cpu16_I4_dexp_we_c,
      ADR3 => Cpu16_I4_data_exp_i(3),
      O => Cpu16_I4_n0160(3)
    );
  Cpu16_I4_data_exp_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_c_3_DXMUX,
      CE => Cpu16_I4_data_exp_c_3_CEINV,
      CLK => Cpu16_I4_data_exp_c_3_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_c_3_FFX_RST,
      O => Cpu16_I4_data_exp_c(3)
    );
  Cpu16_I4_data_exp_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_data_exp_c_3_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_data_exp_c_3_FFX_RST
    );
  Cpu16_I4_data_exp_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_c_5_DYMUX,
      CE => Cpu16_I4_data_exp_c_5_CEINV,
      CLK => Cpu16_I4_data_exp_c_5_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_c_5_FFY_RST,
      O => Cpu16_I4_data_exp_c(4)
    );
  Cpu16_I4_data_exp_c_5_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_data_exp_c_5_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_data_exp_c_5_FFY_RST
    );
  Cpu16_I4_n0160_5_1 : X_LUT4
    generic map(
      INIT => X"CCA0"
    )
    port map (
      ADR0 => Cpu16_I4_dexp_we_c,
      ADR1 => Cpu16_I4_data_exp_i(5),
      ADR2 => Cpu16_I3_acc_c_0_5,
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I4_n0160(5)
    );
  Cpu16_I4_n0160_6_1 : X_LUT4
    generic map(
      INIT => X"E2C0"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_6,
      ADR1 => Cpu16_int_stop,
      ADR2 => Cpu16_I4_data_exp_i(6),
      ADR3 => Cpu16_I4_dexp_we_c,
      O => Cpu16_I4_n0160(6)
    );
  Cpu16_I4_data_exp_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_c_5_DXMUX,
      CE => Cpu16_I4_data_exp_c_5_CEINV,
      CLK => Cpu16_I4_data_exp_c_5_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_c_5_FFX_RST,
      O => Cpu16_I4_data_exp_c(5)
    );
  Cpu16_I4_data_exp_c_5_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_data_exp_c_5_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_data_exp_c_5_FFX_RST
    );
  Cpu16_I4_data_exp_c_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_c_7_DYMUX,
      CE => Cpu16_I4_data_exp_c_7_CEINV,
      CLK => Cpu16_I4_data_exp_c_7_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_c_7_FFY_RST,
      O => Cpu16_I4_data_exp_c(6)
    );
  Cpu16_I4_data_exp_c_7_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_data_exp_c_7_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_data_exp_c_7_FFY_RST
    );
  Cpu16_I1_eaddr_x_5 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_eaddr_x_5_DXMUX,
      GE => Cpu16_I1_eaddr_x_5_CEINV,
      CLK => NlwInverterSignal_Cpu16_I1_eaddr_x_5_CLK,
      SET => GND,
      RST => Cpu16_I1_eaddr_x_5_FFX_RST,
      O => Cpu16_I1_eaddr_x(5)
    );
  Cpu16_I1_eaddr_x_5_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I1_eaddr_x_5_FFX_RST
    );
  Cpu16_I1_Mmux_n0008_Result_8_1 : X_LUT4
    generic map(
      INIT => X"AACC"
    )
    port map (
      ADR0 => MEM_DATA_OUT(12),
      ADR1 => Cpu16_I1_eaddr_x(8),
      ADR2 => VCC,
      ADR3 => Cpu16_I1_n00201_1,
      O => Cpu16_I1_n0008(8)
    );
  Cpu16_I1_eaddr_x_6 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_eaddr_x_7_DYMUX,
      GE => Cpu16_I1_eaddr_x_7_CEINV,
      CLK => NlwInverterSignal_Cpu16_I1_eaddr_x_6_CLK,
      SET => GND,
      RST => Cpu16_I1_eaddr_x_7_FFY_RST,
      O => Cpu16_I1_eaddr_x(6)
    );
  Cpu16_I1_eaddr_x_7_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I1_eaddr_x_7_FFY_RST
    );
  Cpu16_I1_Mmux_n0008_Result_7_1 : X_LUT4
    generic map(
      INIT => X"DD88"
    )
    port map (
      ADR0 => Cpu16_I1_n00201_1,
      ADR1 => MEM_DATA_OUT(11),
      ADR2 => VCC,
      ADR3 => Cpu16_I1_eaddr_x(7),
      O => Cpu16_I1_n0008(7)
    );
  Cpu16_I1_eaddr_x_7 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_eaddr_x_7_DXMUX,
      GE => Cpu16_I1_eaddr_x_7_CEINV,
      CLK => NlwInverterSignal_Cpu16_I1_eaddr_x_7_CLK,
      SET => GND,
      RST => Cpu16_I1_eaddr_x_7_FFX_RST,
      O => Cpu16_I1_eaddr_x(7)
    );
  Cpu16_I1_eaddr_x_7_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I1_eaddr_x_7_FFX_RST
    );
  Cpu16_I1_eaddr_x_8 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_eaddr_x_9_DYMUX,
      GE => Cpu16_I1_eaddr_x_9_CEINV,
      CLK => NlwInverterSignal_Cpu16_I1_eaddr_x_8_CLK,
      SET => GND,
      RST => Cpu16_I1_eaddr_x_9_FFY_RST,
      O => Cpu16_I1_eaddr_x(8)
    );
  Cpu16_I1_eaddr_x_9_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I1_eaddr_x_9_FFY_RST
    );
  Cpu16_I1_Mmux_n0008_Result_9_1 : X_LUT4
    generic map(
      INIT => X"CCAA"
    )
    port map (
      ADR0 => Cpu16_I1_eaddr_x(9),
      ADR1 => MEM_DATA_OUT(13),
      ADR2 => VCC,
      ADR3 => Cpu16_I1_n00201_1,
      O => Cpu16_I1_n0008(9)
    );
  Cpu16_I1_n0006_0_1 : X_LUT4
    generic map(
      INIT => X"AAFF"
    )
    port map (
      ADR0 => Cpu16_I1_nreset_v(1),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => Cpu16_I1_nreset_v(0),
      O => Cpu16_I1_n0006(0)
    );
  Cpu16_I1_eaddr_x_9 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_eaddr_x_9_DXMUX,
      GE => Cpu16_I1_eaddr_x_9_CEINV,
      CLK => NlwInverterSignal_Cpu16_I1_eaddr_x_9_CLK,
      SET => GND,
      RST => Cpu16_I1_eaddr_x_9_FFX_RST,
      O => Cpu16_I1_eaddr_x(9)
    );
  Cpu16_I1_eaddr_x_9_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I1_eaddr_x_9_FFX_RST
    );
  Cpu16_I1_nreset_v_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_nreset_v_0_DYMUX,
      CE => VCC,
      CLK => Cpu16_I1_nreset_v_0_CLKINV,
      SET => GND,
      RST => Cpu16_I1_nreset_v_0_FFY_RST,
      O => Cpu16_I1_nreset_v(0)
    );
  Cpu16_I1_nreset_v_0_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I1_nreset_v_0_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I1_nreset_v_0_FFY_RST
    );
  Cpu16_I4_iinc_c_9 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_c_9_DXMUX,
      CE => Cpu16_I4_iinc_c_9_CEINV,
      CLK => Cpu16_I4_iinc_c_9_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_c_9_FFX_RST,
      O => Cpu16_I4_iinc_c(9)
    );
  Cpu16_I4_iinc_c_9_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_iinc_c_9_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_iinc_c_9_FFX_RST
    );
  Cpu16_I4_iinc_i_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_i_1_DYMUX,
      CE => Cpu16_I4_iinc_i_1_CEINV,
      CLK => Cpu16_I4_iinc_i_1_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_i_1_FFY_RST,
      O => Cpu16_I4_iinc_i(0)
    );
  Cpu16_I4_iinc_i_1_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_iinc_i_1_FFY_RST
    );
  Cpu16_I4_iinc_x_1_1 : X_LUT4
    generic map(
      INIT => X"B888"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_1,
      ADR1 => Cpu16_I4_iinc_we_c,
      ADR2 => Cpu16_I4_n01621_1,
      ADR3 => Cpu16_I4_iinc_c(1),
      O => Cpu16_I4_iinc_x(1)
    );
  Cpu16_I4_iinc_i_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_i_1_DXMUX,
      CE => Cpu16_I4_iinc_i_1_CEINV,
      CLK => Cpu16_I4_iinc_i_1_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_i_1_FFX_RST,
      O => Cpu16_I4_iinc_i(1)
    );
  Cpu16_I4_iinc_i_1_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_iinc_i_1_FFX_RST
    );
  Cpu16_I4_iinc_x_2_1 : X_LUT4
    generic map(
      INIT => X"EC20"
    )
    port map (
      ADR0 => Cpu16_I4_iinc_c(2),
      ADR1 => Cpu16_I4_iinc_we_c,
      ADR2 => Cpu16_I4_n01621_1,
      ADR3 => Cpu16_I3_acc_c_0_2,
      O => Cpu16_I4_iinc_x(2)
    );
  Cpu16_I4_iinc_x_4_1 : X_LUT4
    generic map(
      INIT => X"F808"
    )
    port map (
      ADR0 => Cpu16_I4_iinc_c(4),
      ADR1 => Cpu16_I4_n01621_1,
      ADR2 => Cpu16_I4_iinc_we_c,
      ADR3 => Cpu16_I3_acc_c_0_4,
      O => Cpu16_I4_iinc_x(4)
    );
  Cpu16_I4_iinc_i_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_i_2_DYMUX,
      CE => Cpu16_I4_iinc_i_2_CEINV,
      CLK => Cpu16_I4_iinc_i_2_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_i_2_FFY_RST,
      O => Cpu16_I4_iinc_i(2)
    );
  Cpu16_I4_iinc_i_2_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_iinc_i_2_FFY_RST
    );
  Cpu16_I3_n0147_2_0 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => Cpu16_I3_N17152,
      ADR3 => Cpu16_I3_acc_c_0_2,
      O => Cpu16_I4_iinc_i_2_F
    );
  Cpu16_I4_iinc_i_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_i_5_DYMUX,
      CE => Cpu16_I4_iinc_i_5_CEINV,
      CLK => Cpu16_I4_iinc_i_5_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_i_5_FFY_RST,
      O => Cpu16_I4_iinc_i(4)
    );
  Cpu16_I4_iinc_i_5_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_iinc_i_5_FFY_RST
    );
  Cpu16_I4_iinc_x_5_1 : X_LUT4
    generic map(
      INIT => X"ACA0"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_5,
      ADR1 => Cpu16_I4_n01621_1,
      ADR2 => Cpu16_I4_iinc_we_c,
      ADR3 => Cpu16_I4_iinc_c(5),
      O => Cpu16_I4_iinc_x(5)
    );
  Cpu16_I4_iinc_x_6_1 : X_LUT4
    generic map(
      INIT => X"F808"
    )
    port map (
      ADR0 => Cpu16_I4_n01621_1,
      ADR1 => Cpu16_I4_iinc_c(6),
      ADR2 => Cpu16_I4_iinc_we_c,
      ADR3 => Cpu16_I3_acc_c_0_6,
      O => Cpu16_I4_iinc_x(6)
    );
  Cpu16_I3_Mmux_data_x_Result_11_13 : X_LUT4
    generic map(
      INIT => X"B800"
    )
    port map (
      ADR0 => DATA_IN_EXT_11_IBUF,
      ADR1 => XLXI_2_mux_c(0),
      ADR2 => MEM_DATA_OUT(11),
      ADR3 => NRESET_IN_BUFGP,
      O => CHOICE887_F
    );
  Cpu16_I3_n0147_13_19 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_2_1,
      ADR1 => Cpu16_I3_n0090(13),
      ADR2 => Cpu16_I2_TD_c_1_1,
      ADR3 => Cpu16_I2_TD_c_0_1,
      O => CHOICE1441_F
    );
  Cpu16_I3_n0147_11_29 : X_LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      ADR0 => N31299,
      ADR1 => CHOICE902,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => Cpu16_I2_data_is_c(11),
      O => N30808_G
    );
  Cpu16_I3_Mmux_data_x_Result_4_32 : X_LUT4
    generic map(
      INIT => X"88C0"
    )
    port map (
      ADR0 => Cpu16_I4_data_exp_c(4),
      ADR1 => Cpu16_I4_N18357,
      ADR2 => Cpu16_I4_ireg_c(4),
      ADR3 => Cpu16_daddr_is(2),
      O => CHOICE948_G
    );
  Cpu16_I3_Mmux_data_x_Result_13_SW4 : X_LUT4
    generic map(
      INIT => X"9C9C"
    )
    port map (
      ADR0 => Cpu16_data_is_int(13),
      ADR1 => Cpu16_I3_acc_c_0_13,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => VCC,
      O => N30808_F
    );
  Cpu16_I3_Mmux_data_x_Result_10_32 : X_LUT4
    generic map(
      INIT => X"88C0"
    )
    port map (
      ADR0 => Cpu16_I4_data_exp_c(10),
      ADR1 => Cpu16_I4_N18357,
      ADR2 => Cpu16_I4_ireg_c(10),
      ADR3 => Cpu16_daddr_is(2),
      O => CHOICE948_F
    );
  Cpu16_I3_n0147_11_90 : X_LUT4
    generic map(
      INIT => X"DC50"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_11,
      ADR1 => Cpu16_I3_N17006,
      ADR2 => Cpu16_I3_n0084,
      ADR3 => Cpu16_I3_acc_c_0_12,
      O => CHOICE1318_G
    );
  Cpu16_I3_n0147_11_81 : X_LUT4
    generic map(
      INIT => X"0200"
    )
    port map (
      ADR0 => Cpu16_I3_acc_i_0_11,
      ADR1 => Cpu16_I2_TC_c_0_1,
      ADR2 => Cpu16_I2_TC_c_1_1,
      ADR3 => Cpu16_I2_TC_c_2_1,
      O => CHOICE808_G
    );
  Cpu16_I3_n0147_1_81 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_0_1,
      ADR2 => Cpu16_I3_acc_i_0_1,
      ADR3 => Cpu16_I2_TC_c_2_1,
      O => CHOICE808_F
    );
  Cpu16_I3_n0147_11_82 : X_LUT4
    generic map(
      INIT => X"4040"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c(2),
      ADR1 => Cpu16_I3_acc_c_0_10,
      ADR2 => Cpu16_I2_TD_c(0),
      ADR3 => VCC,
      O => Cpu16_I3_N17033_G
    );
  Cpu16_I3_Ker170311 : X_LUT4
    generic map(
      INIT => X"5050"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c(2),
      ADR1 => VCC,
      ADR2 => Cpu16_I2_TD_c(0),
      ADR3 => VCC,
      O => Cpu16_I3_N17033_F
    );
  Cpu16_I2_ndre_x1_SW4_SW0_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"C080"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(2),
      ADR1 => NRESET_IN_BUFGP,
      ADR2 => Cpu16_I4_nreset_v(1),
      ADR3 => Cpu16_I2_idata_c(1),
      O => N31264_F
    );
  Cpu16_I1_iaddr_x_6_25 : X_LUT4
    generic map(
      INIT => X"CAC0"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_1_44_2,
      ADR1 => XLXN_20(6),
      ADR2 => Cpu16_I2_pc_mux_x_2_46_2,
      ADR3 => MEM_DATA_OUT(10),
      O => CHOICE544_F
    );
  Cpu16_I1_iaddr_x_4_25 : X_LUT4
    generic map(
      INIT => X"AAC0"
    )
    port map (
      ADR0 => XLXN_20(4),
      ADR1 => Cpu16_I2_pc_mux_x_1_44_2,
      ADR2 => MEM_DATA_OUT(8),
      ADR3 => Cpu16_I2_pc_mux_x_2_46_2,
      O => CHOICE392_G
    );
  Cpu16_I2_TD_x_2_38 : X_LUT4
    generic map(
      INIT => X"0005"
    )
    port map (
      ADR0 => Cpu16_I2_idata_x(1),
      ADR1 => VCC,
      ADR2 => Cpu16_I2_idata_x(3),
      ADR3 => Cpu16_I2_idata_x(0),
      O => Cpu16_I2_TD_c_2_1_G
    );
  Cpu16_I4_data_ox_0_1 : X_LUT4
    generic map(
      INIT => X"8800"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_I3_acc_c_0_0_1,
      ADR2 => VCC,
      ADR3 => Cpu16_I4_nreset_v(1),
      O => DATA_OUT_EXT_2_OBUF_G
    );
  Cpu16_I2_TD_c_2_2_1138 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TD_c_2_1_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_TD_c_2_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TD_c_2_1_FFY_RST,
      O => Cpu16_I2_TD_c_2_2
    );
  Cpu16_I2_TD_c_2_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TD_c_2_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TD_c_2_1_FFY_RST
    );
  Cpu16_I2_TD_x_2_72 : X_LUT4
    generic map(
      INIT => X"CC80"
    )
    port map (
      ADR0 => CHOICE326,
      ADR1 => NRESET_IN_BUFGP,
      ADR2 => CHOICE321,
      ADR3 => Cpu16_I2_idata_x(2),
      O => Cpu16_I2_TD_c_2_1_F
    );
  Cpu16_I2_TD_c_2_1_1139 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TD_c_2_1_DXMUX,
      CE => VCC,
      CLK => Cpu16_I2_TD_c_2_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TD_c_2_1_FFX_RST,
      O => Cpu16_I2_TD_c_2_1
    );
  Cpu16_I2_TD_c_2_1_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TD_c_2_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TD_c_2_1_FFX_RST
    );
  Cpu16_I4_data_ox_2_1 : X_LUT4
    generic map(
      INIT => X"8800"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_I3_acc_c_0_2,
      ADR2 => VCC,
      ADR3 => Cpu16_I4_nreset_v(1),
      O => DATA_OUT_EXT_2_OBUF_F
    );
  Cpu16_I4_data_ox_3_1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_I3_acc_c_0_3,
      ADR2 => Cpu16_I4_nreset_v(1),
      ADR3 => VCC,
      O => DATA_OUT_EXT_4_OBUF_G
    );
  Cpu16_I2_Mmux_idata_x_Result_8_1 : X_LUT4
    generic map(
      INIT => X"F0CC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_idata_c(8),
      ADR2 => MEM_DATA_OUT(8),
      ADR3 => Cpu16_I2_n01501_1,
      O => Cpu16_I2_data_is_c_5_G
    );
  Cpu16_I2_data_is_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_data_is_c_3_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_data_is_c_3_CLKINV,
      SET => GND,
      RST => Cpu16_I2_data_is_c_3_FFY_RST,
      O => Cpu16_I2_data_is_c(3)
    );
  Cpu16_I2_data_is_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_data_is_c_3_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_data_is_c_3_FFY_RST
    );
  Cpu16_I2_TD_x_2_29 : X_LUT4
    generic map(
      INIT => X"0870"
    )
    port map (
      ADR0 => Cpu16_daddr_is(1),
      ADR1 => Cpu16_I2_Mmux_idata_x_Result_4_1_1,
      ADR2 => Cpu16_I2_Mmux_idata_x_Result_6_1_1,
      ADR3 => Cpu16_daddr_is(3),
      O => Cpu16_I2_data_is_c_3_F
    );
  Cpu16_I2_Mmux_idata_x_Result_10_1 : X_LUT4
    generic map(
      INIT => X"F0CC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_idata_c(10),
      ADR2 => MEM_DATA_OUT(10),
      ADR3 => Cpu16_I2_n01501_1,
      O => Cpu16_I2_data_is_c_7_G
    );
  Cpu16_I2_Mmux_idata_x_Result_12_1 : X_LUT4
    generic map(
      INIT => X"F0CC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_idata_c(12),
      ADR2 => MEM_DATA_OUT(12),
      ADR3 => Cpu16_I2_n01501_1,
      O => Cpu16_I2_data_is_c_9_G
    );
  Cpu16_I2_data_is_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_data_is_c_5_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_data_is_c_5_CLKINV,
      SET => GND,
      RST => Cpu16_I2_data_is_c_5_FFY_RST,
      O => Cpu16_I2_data_is_c(4)
    );
  Cpu16_I2_data_is_c_5_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_data_is_c_5_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_data_is_c_5_FFY_RST
    );
  Cpu16_I2_Mmux_idata_x_Result_9_1 : X_LUT4
    generic map(
      INIT => X"B8B8"
    )
    port map (
      ADR0 => MEM_DATA_OUT(9),
      ADR1 => Cpu16_I2_n01501_1,
      ADR2 => Cpu16_I2_idata_c(9),
      ADR3 => VCC,
      O => Cpu16_I2_data_is_c_5_F
    );
  Cpu16_I2_data_is_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_data_is_c_5_DXMUX,
      CE => VCC,
      CLK => Cpu16_I2_data_is_c_5_CLKINV,
      SET => GND,
      RST => Cpu16_I2_data_is_c_5_FFX_RST,
      O => Cpu16_I2_data_is_c(5)
    );
  Cpu16_I2_data_is_c_5_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_data_is_c_5_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_data_is_c_5_FFX_RST
    );
  Cpu16_I2_data_is_c_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_data_is_c_7_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_data_is_c_7_CLKINV,
      SET => GND,
      RST => Cpu16_I2_data_is_c_7_FFY_RST,
      O => Cpu16_I2_data_is_c(6)
    );
  Cpu16_I2_data_is_c_7_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_data_is_c_7_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_data_is_c_7_FFY_RST
    );
  Cpu16_I1_iaddr_x_8_25 : X_LUT4
    generic map(
      INIT => X"B888"
    )
    port map (
      ADR0 => XLXN_20(8),
      ADR1 => Cpu16_I2_pc_mux_x_2_46_2,
      ADR2 => MEM_DATA_OUT(12),
      ADR3 => Cpu16_I2_pc_mux_x_1_44_2,
      O => CHOICE530_F
    );
  Cpu16_I4_data_ox_8_1 : X_LUT4
    generic map(
      INIT => X"8800"
    )
    port map (
      ADR0 => Cpu16_I4_nreset_v(1),
      ADR1 => Cpu16_I3_acc_c_0_8,
      ADR2 => VCC,
      ADR3 => NRESET_IN_BUFGP,
      O => DATA_OUT_EXT_8_OBUF_F
    );
  Cpu16_I1_iaddr_x_11_25 : X_LUT4
    generic map(
      INIT => X"B888"
    )
    port map (
      ADR0 => XLXN_20(11),
      ADR1 => Cpu16_I2_pc_mux_x_2_46_1,
      ADR2 => MEM_DATA_OUT(15),
      ADR3 => Cpu16_I2_pc_mux_x_1_44_1,
      O => CHOICE485_G
    );
  Cpu16_I1_Mmux_saddr_out_Result_10_1 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => Cpu16_I1_pc(10),
      ADR1 => Cpu16_I2_pc_mux_x_2_46_1,
      ADR2 => Cpu16_I2_pc_mux_x_0_104_2,
      ADR3 => Cpu16_I2_pc_mux_x_1_44_1,
      O => CHOICE485_F
    );
  XLXI_3_dwait_c_1140 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_dwait_c_DYMUX,
      CE => VCC,
      CLK => XLXI_3_dwait_c_CLKINV,
      SET => GND,
      RST => XLXI_3_dwait_c_FFY_RST,
      O => XLXI_3_dwait_c
    );
  XLXI_3_dwait_c_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_dwait_c_SRINVNOT,
      I1 => GSR,
      O => XLXI_3_dwait_c_FFY_RST
    );
  Cpu16_I3_n0147_16_13_SW0 : X_LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      ADR0 => N30295,
      ADR1 => Cpu16_I3_n0089(16),
      ADR2 => Cpu16_I3_n0083,
      ADR3 => N30293,
      O => N30510_F
    );
  Cpu16_I4_data_ox_9_1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_I4_nreset_v(1),
      ADR2 => Cpu16_I3_acc_c_0_9,
      ADR3 => VCC,
      O => DATA_OUT_EXT_10_OBUF_G
    );
  Cpu16_I4_data_ox_10_1 : X_LUT4
    generic map(
      INIT => X"8800"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_I3_acc_c_0_10,
      ADR2 => VCC,
      ADR3 => Cpu16_I4_nreset_v(1),
      O => DATA_OUT_EXT_10_OBUF_F
    );
  XLXI_4_n00021 : X_LUT4
    generic map(
      INIT => X"D777"
    )
    port map (
      ADR0 => Cpu16_I1_n0010,
      ADR1 => Cpu16_pc_mux(2),
      ADR2 => Cpu16_pc_mux(0),
      ADR3 => Cpu16_pc_mux(1),
      O => Cpu16_I1_n0024_G
    );
  Cpu16_I1_iaddr_x_9_14 : X_LUT4
    generic map(
      INIT => X"0E04"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_0_104_2,
      ADR1 => Cpu16_I1_pc(9),
      ADR2 => Cpu16_I2_pc_mux_x_1_44_2,
      ADR3 => Cpu16_I1_n0009(9),
      O => CHOICE477_G
    );
  Cpu16_I1_Mmux_saddr_out_Result_9_1 : X_LUT4
    generic map(
      INIT => X"4000"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_1_44_1,
      ADR1 => Cpu16_I1_pc(9),
      ADR2 => Cpu16_I2_pc_mux_x_2_46_1,
      ADR3 => Cpu16_I2_pc_mux_x_0_104_1,
      O => CHOICE477_F
    );
  Cpu16_I3_n0147_16_31_SW0 : X_LUT4
    generic map(
      INIT => X"F200"
    )
    port map (
      ADR0 => CHOICE1380,
      ADR1 => Cpu16_I2_TD_c_3_1,
      ADR2 => CHOICE1402,
      ADR3 => Cpu16_I3_n0023,
      O => N31908_G
    );
  Cpu16_I1_n00241 : X_LUT4
    generic map(
      INIT => X"0A50"
    )
    port map (
      ADR0 => Cpu16_pc_mux(0),
      ADR1 => VCC,
      ADR2 => Cpu16_pc_mux(2),
      ADR3 => Cpu16_pc_mux(1),
      O => Cpu16_I1_n0024_F
    );
  Cpu16_I3_n0147_16_13_SW1_SW0 : X_LUT4
    generic map(
      INIT => X"AFA0"
    )
    port map (
      ADR0 => N30295,
      ADR1 => VCC,
      ADR2 => Cpu16_I3_n0085,
      ADR3 => N30293,
      O => N31908_F
    );
  Cpu16_I2_TC_x_0_SW0_SW2_SW1 : X_LUT4
    generic map(
      INIT => X"FFDD"
    )
    port map (
      ADR0 => MEM_DATA_OUT(0),
      ADR1 => MEM_DATA_OUT(1),
      ADR2 => VCC,
      ADR3 => MEM_DATA_OUT(2),
      O => N31181_F
    );
  Cpu16_I2_Mmux_idata_x_Result_2_1 : X_LUT4
    generic map(
      INIT => X"F3C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_n0150,
      ADR2 => MEM_DATA_OUT(2),
      ADR3 => Cpu16_I2_idata_c(2),
      O => N31185_G
    );
  Cpu16_I2_ndre_x1_SW12_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"ABFF"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(3),
      ADR1 => Cpu16_I2_idata_c(1),
      ADR2 => Cpu16_I2_idata_c(2),
      ADR3 => Cpu16_I2_N15717,
      O => N31185_F
    );
  Cpu16_I3_Mmux_data_x_Result_1_114_SW2 : X_LUT4
    generic map(
      INIT => X"C40C"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_1,
      ADR1 => Cpu16_I2_TD_c_1_2,
      ADR2 => Cpu16_I2_TD_c_2_2,
      ADR3 => Cpu16_I2_TD_c_0_2,
      O => Cpu16_I3_N17242_G
    );
  Cpu16_I2_n01451 : X_LUT4
    generic map(
      INIT => X"ECCC"
    )
    port map (
      ADR0 => Cpu16_I2_N15561,
      ADR1 => Cpu16_I2_n0062,
      ADR2 => XLXI_3_a2vi_s(0),
      ADR3 => Cpu16_I2_nreset_v(1),
      O => CHOICE665_G
    );
  Cpu16_I2_pc_mux_x_2_42 : X_LUT4
    generic map(
      INIT => X"0088"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_I2_nreset_v_1_1,
      ADR2 => VCC,
      ADR3 => Cpu16_I2_n0145,
      O => CHOICE665_F
    );
  Cpu16_I2_n00971 : X_LUT4
    generic map(
      INIT => X"000A"
    )
    port map (
      ADR0 => Cpu16_I2_idata_x(3),
      ADR1 => VCC,
      ADR2 => Cpu16_I2_TC_x(0),
      ADR3 => N30430,
      O => N31146_G
    );
  Cpu16_I1_Mmux_n0008_Result_2_1 : X_LUT4
    generic map(
      INIT => X"F0AA"
    )
    port map (
      ADR0 => Cpu16_I1_eaddr_x(2),
      ADR1 => VCC,
      ADR2 => MEM_DATA_OUT(6),
      ADR3 => Cpu16_I1_n00201_1,
      O => Cpu16_I1_n0008(2)
    );
  Cpu16_I1_eaddr_x_0 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_eaddr_x_1_DYMUX,
      GE => Cpu16_I1_eaddr_x_1_CEINV,
      CLK => NlwInverterSignal_Cpu16_I1_eaddr_x_0_CLK,
      SET => GND,
      RST => Cpu16_I1_eaddr_x_1_FFY_RST,
      O => Cpu16_I1_eaddr_x(0)
    );
  Cpu16_I1_eaddr_x_1_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I1_eaddr_x_1_FFY_RST
    );
  Cpu16_I1_Mmux_n0008_Result_1_1 : X_LUT4
    generic map(
      INIT => X"CCF0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => MEM_DATA_OUT(5),
      ADR2 => Cpu16_I1_eaddr_x(1),
      ADR3 => Cpu16_I1_n00201_1,
      O => Cpu16_I1_n0008(1)
    );
  Cpu16_I1_eaddr_x_1 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_eaddr_x_1_DXMUX,
      GE => Cpu16_I1_eaddr_x_1_CEINV,
      CLK => NlwInverterSignal_Cpu16_I1_eaddr_x_1_CLK,
      SET => GND,
      RST => Cpu16_I1_eaddr_x_1_FFX_RST,
      O => Cpu16_I1_eaddr_x(1)
    );
  Cpu16_I1_eaddr_x_1_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I1_eaddr_x_1_FFX_RST
    );
  Cpu16_I1_Mmux_n0008_Result_6_1 : X_LUT4
    generic map(
      INIT => X"DD88"
    )
    port map (
      ADR0 => Cpu16_I1_n00201_1,
      ADR1 => MEM_DATA_OUT(10),
      ADR2 => VCC,
      ADR3 => Cpu16_I1_eaddr_x(6),
      O => Cpu16_I1_n0008(6)
    );
  Cpu16_I1_eaddr_x_2 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_eaddr_x_3_DYMUX,
      GE => Cpu16_I1_eaddr_x_3_CEINV,
      CLK => NlwInverterSignal_Cpu16_I1_eaddr_x_2_CLK,
      SET => GND,
      RST => Cpu16_I1_eaddr_x_3_FFY_RST,
      O => Cpu16_I1_eaddr_x(2)
    );
  Cpu16_I1_eaddr_x_3_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I1_eaddr_x_3_FFY_RST
    );
  Cpu16_I1_Mmux_n0008_Result_3_1 : X_LUT4
    generic map(
      INIT => X"AACC"
    )
    port map (
      ADR0 => MEM_DATA_OUT(7),
      ADR1 => Cpu16_I1_eaddr_x(3),
      ADR2 => VCC,
      ADR3 => Cpu16_I1_n00201_1,
      O => Cpu16_I1_n0008(3)
    );
  Cpu16_I1_Mmux_n0008_Result_4_1 : X_LUT4
    generic map(
      INIT => X"CACA"
    )
    port map (
      ADR0 => Cpu16_I1_eaddr_x(4),
      ADR1 => MEM_DATA_OUT(8),
      ADR2 => Cpu16_I1_n00201_1,
      ADR3 => VCC,
      O => Cpu16_I1_n0008(4)
    );
  Cpu16_I1_eaddr_x_3 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_eaddr_x_3_DXMUX,
      GE => Cpu16_I1_eaddr_x_3_CEINV,
      CLK => NlwInverterSignal_Cpu16_I1_eaddr_x_3_CLK,
      SET => GND,
      RST => Cpu16_I1_eaddr_x_3_FFX_RST,
      O => Cpu16_I1_eaddr_x(3)
    );
  Cpu16_I1_eaddr_x_3_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I1_eaddr_x_3_FFX_RST
    );
  Cpu16_I1_eaddr_x_4 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_eaddr_x_5_DYMUX,
      GE => Cpu16_I1_eaddr_x_5_CEINV,
      CLK => NlwInverterSignal_Cpu16_I1_eaddr_x_4_CLK,
      SET => GND,
      RST => Cpu16_I1_eaddr_x_5_FFY_RST,
      O => Cpu16_I1_eaddr_x(4)
    );
  Cpu16_I1_eaddr_x_5_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I1_eaddr_x_5_FFY_RST
    );
  Cpu16_I1_Mmux_n0008_Result_5_1 : X_LUT4
    generic map(
      INIT => X"E4E4"
    )
    port map (
      ADR0 => Cpu16_I1_n00201_1,
      ADR1 => Cpu16_I1_eaddr_x(5),
      ADR2 => MEM_DATA_OUT(9),
      ADR3 => VCC,
      O => Cpu16_I1_n0008(5)
    );
  Cpu16_I2_data_is_c_10 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_data_is_c_11_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_data_is_c_11_CLKINV,
      SET => GND,
      RST => Cpu16_I2_data_is_c_11_FFY_RST,
      O => Cpu16_I2_data_is_c(10)
    );
  Cpu16_I2_data_is_c_11_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_data_is_c_11_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_data_is_c_11_FFY_RST
    );
  Cpu16_I2_Mmux_idata_x_Result_15_1 : X_LUT4
    generic map(
      INIT => X"F3C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_n01501_1,
      ADR2 => MEM_DATA_OUT(15),
      ADR3 => Cpu16_I2_idata_c(15),
      O => Cpu16_daddr_is(11)
    );
  Cpu16_I2_data_is_c_11 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_data_is_c_11_DXMUX,
      CE => VCC,
      CLK => Cpu16_I2_data_is_c_11_CLKINV,
      SET => GND,
      RST => Cpu16_I2_data_is_c_11_FFX_RST,
      O => Cpu16_I2_data_is_c(11)
    );
  Cpu16_I2_data_is_c_11_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_data_is_c_11_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_data_is_c_11_FFX_RST
    );
  Cpu16_I1_Mmux_n0008_Result_10_1 : X_LUT4
    generic map(
      INIT => X"BB88"
    )
    port map (
      ADR0 => MEM_DATA_OUT(14),
      ADR1 => Cpu16_I1_n00201_1,
      ADR2 => VCC,
      ADR3 => Cpu16_I1_eaddr_x(10),
      O => Cpu16_I1_n0008(10)
    );
  Cpu16_I1_eaddr_x_10 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_eaddr_x_10_DYMUX,
      GE => Cpu16_I1_eaddr_x_10_CEINV,
      CLK => NlwInverterSignal_Cpu16_I1_eaddr_x_10_CLK,
      SET => GND,
      RST => Cpu16_I1_eaddr_x_10_FFY_RST,
      O => Cpu16_I1_eaddr_x(10)
    );
  Cpu16_I1_eaddr_x_10_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I1_eaddr_x_10_FFY_RST
    );
  Cpu16_I3_Mmux_data_x_Result_14_SW0 : X_LUT4
    generic map(
      INIT => X"3F5F"
    )
    port map (
      ADR0 => MEM_DATA_OUT(14),
      ADR1 => DATA_IN_EXT_14_IBUF,
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => XLXI_2_mux_c(0),
      O => Cpu16_I1_eaddr_x_10_F
    );
  Cpu16_I2_TC_x_2_Q : X_LUT4
    generic map(
      INIT => X"A0E0"
    )
    port map (
      ADR0 => Cpu16_I2_idata_x(3),
      ADR1 => Cpu16_I2_n0142,
      ADR2 => N21764,
      ADR3 => Cpu16_I2_idata_x(0),
      O => Cpu16_I2_TC_c_2_1_G
    );
  Cpu16_I2_TC_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TC_c_2_1_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_TC_c_2_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TC_c_2_1_FFY_RST,
      O => Cpu16_I2_TC_c(2)
    );
  Cpu16_I2_TC_c_2_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TC_c_2_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TC_c_2_1_FFY_RST
    );
  Cpu16_I4_n0159_0_1 : X_LUT4
    generic map(
      INIT => X"EA40"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I3_acc_c_0_0_1,
      ADR2 => Cpu16_I4_iinc_we_c,
      ADR3 => Cpu16_I4_iinc_i(0),
      O => Cpu16_I4_n0159(0)
    );
  Cpu16_I2_TC_c_2_1_1141 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TC_c_2_1_DXMUX,
      CE => VCC,
      CLK => Cpu16_I2_TC_c_2_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TC_c_2_1_FFX_RST,
      O => Cpu16_I2_TC_c_2_1
    );
  Cpu16_I2_TC_c_2_1_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TC_c_2_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TC_c_2_1_FFX_RST
    );
  Cpu16_I4_iinc_we_x1 : X_LUT4
    generic map(
      INIT => X"0088"
    )
    port map (
      ADR0 => Cpu16_daddr_is(1),
      ADR1 => Cpu16_I4_N18224,
      ADR2 => VCC,
      ADR3 => Cpu16_I4_N18068,
      O => Cpu16_I4_iinc_we_x
    );
  Cpu16_I2_E_c_FFd4_1142 : X_FF
    generic map(
      INIT => '1'
    )
    port map (
      I => Cpu16_I2_E_c_FFd4_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_E_c_FFd4_CLKINV,
      SET => Cpu16_I2_E_c_FFd4_FFY_SET,
      RST => GND,
      O => Cpu16_I2_E_c_FFd4
    );
  Cpu16_I2_E_c_FFd4_FFY_SETOR : X_OR2
    port map (
      I0 => GSR,
      I1 => Cpu16_I2_E_c_FFd4_SRINVNOT,
      O => Cpu16_I2_E_c_FFd4_FFY_SET
    );
  Cpu16_I2_pc_mux_x_1_41 : X_LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      ADR0 => Cpu16_I2_Mmux_skip_x_Result1_1,
      ADR1 => Cpu16_I2_nreset_v_1_1,
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => Cpu16_I2_n0145,
      O => Cpu16_I2_E_c_FFd4_F
    );
  Cpu16_I4_iinc_we_c_1143 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_we_c_DYMUX,
      CE => VCC,
      CLK => Cpu16_I4_iinc_we_c_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_we_c_FFY_RST,
      O => Cpu16_I4_iinc_we_c
    );
  Cpu16_I4_iinc_we_c_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_iinc_we_c_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_iinc_we_c_FFY_RST
    );
  XLXI_5_Mmux_cpu_daddr_out_Result_8_1 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_5_cpu_daddr_c(8),
      ADR1 => XLXI_5_N12936,
      ADR2 => CPU_ADADDR_OUT(8),
      ADR3 => XLXI_5_N12957,
      O => ADDR_OUT_EXT_6_OBUF_G
    );
  Cpu16_I4_n02031 : X_LUT4
    generic map(
      INIT => X"F0FC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_daddr_is(1),
      ADR2 => Cpu16_I4_N18357,
      ADR3 => Cpu16_I4_N18068,
      O => Cpu16_I4_iinc_we_c_F
    );
  Cpu16_I2_TC_x_0_1 : X_LUT4
    generic map(
      INIT => X"FD20"
    )
    port map (
      ADR0 => Cpu16_I2_n0142,
      ADR1 => Cpu16_I2_Mmux_idata_x_Result_4_1_1,
      ADR2 => N30972,
      ADR3 => N30970,
      O => N31995
    );
  Cpu16_I2_TC_c_0_1_1144 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TC_c_0_1_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_TC_c_0_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TC_c_0_1_FFY_RST,
      O => Cpu16_I2_TC_c_0_1
    );
  Cpu16_I2_TC_c_0_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TC_c_0_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TC_c_0_1_FFY_RST
    );
  XLXI_3_n0006_SW0 : X_LUT4
    generic map(
      INIT => X"FAFF"
    )
    port map (
      ADR0 => XLXI_5_dw_s(0),
      ADR1 => VCC,
      ADR2 => XLXI_3_dwait_c,
      ADR3 => XLXI_3_nadwe_c,
      O => XLXI_3_N12472_G
    );
  Cpu16_I2_Ker156981_SW3 : X_LUT4
    generic map(
      INIT => X"DD8D"
    )
    port map (
      ADR0 => Cpu16_I2_idata_x(3),
      ADR1 => NRESET_IN_BUFGP,
      ADR2 => Cpu16_I2_n0142,
      ADR3 => Cpu16_I2_idata_x(0),
      O => Cpu16_I2_TC_c_0_1_F
    );
  XLXI_3_Ker124701 : X_LUT4
    generic map(
      INIT => X"AAFF"
    )
    port map (
      ADR0 => XLXI_5_dw_s(0),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => XLXI_3_nadwe_c,
      O => XLXI_3_N12472_F
    );
  XLXI_4_n00021_SW3 : X_LUT4
    generic map(
      INIT => X"D2F0"
    )
    port map (
      ADR0 => Cpu16_I1_nreset_v(1),
      ADR1 => Cpu16_pc_mux(2),
      ADR2 => XLXI_4_addr_c(2),
      ADR3 => NRESET_IN_BUFGP,
      O => Cpu16_I1_nreset_v_0_F
    );
  Cpu16_I2_n0076_0_1 : X_LUT4
    generic map(
      INIT => X"F3F3"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_nreset_v(0),
      ADR2 => Cpu16_I2_nreset_v_1_1,
      ADR3 => VCC,
      O => Cpu16_I2_n0076(0)
    );
  Cpu16_I2_nreset_v_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_nreset_v_0_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_nreset_v_0_CLKINV,
      SET => GND,
      RST => Cpu16_I2_nreset_v_0_FFY_RST,
      O => Cpu16_I2_nreset_v(0)
    );
  Cpu16_I2_nreset_v_0_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_nreset_v_0_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_nreset_v_0_FFY_RST
    );
  Cpu16_I2_n01511 : X_LUT4
    generic map(
      INIT => X"3F3F"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_E_c_FFd2,
      ADR2 => Cpu16_I2_nreset_v_1_1,
      ADR3 => VCC,
      O => Cpu16_I2_nreset_v_0_F
    );
  Cpu16_I4_n0159_10_1 : X_LUT4
    generic map(
      INIT => X"E4A0"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I4_iinc_we_c,
      ADR2 => Cpu16_I4_iinc_i(10),
      ADR3 => Cpu16_I3_acc_c_0_10,
      O => Cpu16_I4_n0159(10)
    );
  Cpu16_I3_n0022_0_1 : X_LUT4
    generic map(
      INIT => X"F3F3"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_nreset_v(0),
      ADR2 => Cpu16_I3_nreset_v(1),
      ADR3 => VCC,
      O => Cpu16_I3_n0022(0)
    );
  Cpu16_I4_iinc_c_10 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_c_11_DYMUX,
      CE => Cpu16_I4_iinc_c_11_CEINV,
      CLK => Cpu16_I4_iinc_c_11_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_c_11_FFY_RST,
      O => Cpu16_I4_iinc_c(10)
    );
  Cpu16_I4_iinc_c_11_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_iinc_c_11_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_iinc_c_11_FFY_RST
    );
  Cpu16_I4_n0159_11_1 : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I4_iinc_i(11),
      ADR2 => Cpu16_I4_iinc_we_c,
      ADR3 => Cpu16_I3_acc_c_0_11,
      O => Cpu16_I4_n0159(11)
    );
  Cpu16_I4_iinc_c_11 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_c_11_DXMUX,
      CE => Cpu16_I4_iinc_c_11_CEINV,
      CLK => Cpu16_I4_iinc_c_11_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_c_11_FFX_RST,
      O => Cpu16_I4_iinc_c(11)
    );
  Cpu16_I4_iinc_c_11_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_iinc_c_11_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_iinc_c_11_FFX_RST
    );
  Cpu16_I3_nreset_v_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_nreset_v_0_DYMUX,
      CE => VCC,
      CLK => Cpu16_I3_nreset_v_0_CLKINV,
      SET => GND,
      RST => Cpu16_I3_nreset_v_0_FFY_RST,
      O => Cpu16_I3_nreset_v(0)
    );
  Cpu16_I3_nreset_v_0_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_nreset_v_0_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_nreset_v_0_FFY_RST
    );
  Cpu16_I3_n0147_16_132 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_16,
      ADR1 => Cpu16_I3_nreset_v(0),
      ADR2 => Cpu16_I3_nreset_v(1),
      ADR3 => Cpu16_I3_n0023,
      O => Cpu16_I3_nreset_v_0_F
    );
  Cpu16_I4_n0161_0_1 : X_LUT4
    generic map(
      INIT => X"F0FF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => Cpu16_I4_nreset_v(1),
      ADR3 => Cpu16_I4_nreset_v(0),
      O => Cpu16_I4_n0161(0)
    );
  Cpu16_I4_nreset_v_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_nreset_v_0_DYMUX,
      CE => VCC,
      CLK => Cpu16_I4_nreset_v_0_CLKINV,
      SET => GND,
      RST => Cpu16_I4_nreset_v_0_FFY_RST,
      O => Cpu16_I4_nreset_v(0)
    );
  Cpu16_I4_nreset_v_0_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_nreset_v_0_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_nreset_v_0_FFY_RST
    );
  Cpu16_I4_data_ox_1_1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_I3_acc_c_0_1,
      ADR2 => Cpu16_I4_nreset_v(1),
      ADR3 => VCC,
      O => Cpu16_I4_nreset_v_0_F
    );
  Cpu16_I4_iinc_x_10_1 : X_LUT4
    generic map(
      INIT => X"F808"
    )
    port map (
      ADR0 => Cpu16_I4_iinc_c(10),
      ADR1 => Cpu16_I4_n01621_1,
      ADR2 => Cpu16_I4_iinc_we_c,
      ADR3 => Cpu16_I3_acc_c_0_10,
      O => Cpu16_I4_iinc_x(10)
    );
  Cpu16_I4_iinc_i_10 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_i_11_DYMUX,
      CE => Cpu16_I4_iinc_i_11_CEINV,
      CLK => Cpu16_I4_iinc_i_11_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_i_11_FFY_RST,
      O => Cpu16_I4_iinc_i(10)
    );
  Cpu16_I4_iinc_i_11_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_iinc_i_11_FFY_RST
    );
  Cpu16_I4_iinc_x_11_1 : X_LUT4
    generic map(
      INIT => X"EA40"
    )
    port map (
      ADR0 => Cpu16_I4_iinc_we_c,
      ADR1 => Cpu16_I4_iinc_c(11),
      ADR2 => Cpu16_I4_n01621_1,
      ADR3 => Cpu16_I3_acc_c_0_11,
      O => Cpu16_I4_iinc_x(11)
    );
  Cpu16_I2_Mmux_idata_x_Result_14_1 : X_LUT4
    generic map(
      INIT => X"EE22"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(14),
      ADR1 => Cpu16_I2_n01501_1,
      ADR2 => VCC,
      ADR3 => MEM_DATA_OUT(14),
      O => Cpu16_daddr_is(10)
    );
  Cpu16_I4_iinc_i_11 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_i_11_DXMUX,
      CE => Cpu16_I4_iinc_i_11_CEINV,
      CLK => Cpu16_I4_iinc_i_11_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_i_11_FFX_RST,
      O => Cpu16_I4_iinc_i(11)
    );
  Cpu16_I4_iinc_i_11_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_iinc_i_11_FFX_RST
    );
  Cpu16_I3_n0147_0_27_SW1 : X_LUT4
    generic map(
      INIT => X"C400"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_1_1,
      ADR1 => Cpu16_I2_TD_c_0_2,
      ADR2 => Cpu16_I2_TD_c_2_2,
      ADR3 => Cpu16_I3_acc_c_0_0_1,
      O => Cpu16_I3_n0085_G
    );
  Cpu16_I3_Mmux_data_x_Result_6_32 : X_LUT4
    generic map(
      INIT => X"C088"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_c(6),
      ADR1 => Cpu16_I4_N18357,
      ADR2 => Cpu16_I4_data_exp_c(6),
      ADR3 => Cpu16_daddr_is(2),
      O => CHOICE1168_F
    );
  Cpu16_I3_n00851 : X_LUT4
    generic map(
      INIT => X"2020"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_1_1,
      ADR1 => Cpu16_I2_TD_c_0_2,
      ADR2 => Cpu16_I2_TD_c_2_2,
      ADR3 => VCC,
      O => Cpu16_I3_n0085_F
    );
  Cpu16_I3_n0147_12_81 : X_LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I3_acc_i_0_12,
      ADR3 => Cpu16_I2_TC_c_0_1,
      O => CHOICE1090_G
    );
  Cpu16_I3_n0147_7_81 : X_LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I3_acc_i_0_7,
      ADR3 => Cpu16_I2_TC_c_0_1,
      O => CHOICE1090_F
    );
  Cpu16_I3_n0147_12_90 : X_LUT4
    generic map(
      INIT => X"F444"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_12,
      ADR1 => Cpu16_I3_n0084,
      ADR2 => Cpu16_I3_acc_c_0_13,
      ADR3 => Cpu16_I3_N17006,
      O => CHOICE1373_G
    );
  Cpu16_I3_Mmux_data_x_Result_3_114_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FDFF"
    )
    port map (
      ADR0 => Cpu16_I2_data_is_c(3),
      ADR1 => Cpu16_I2_TC_c_0_1,
      ADR2 => Cpu16_I2_TC_c_2_1,
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => N30830_G
    );
  Cpu16_I3_n0147_12_106 : X_LUT4
    generic map(
      INIT => X"FFA8"
    )
    port map (
      ADR0 => Cpu16_I3_N17531,
      ADR1 => CHOICE1370,
      ADR2 => CHOICE1366,
      ADR3 => CHOICE1365,
      O => CHOICE1373_F
    );
  Cpu16_I3_n0147_13_81 : X_LUT4
    generic map(
      INIT => X"0020"
    )
    port map (
      ADR0 => Cpu16_I3_acc_i_0_13,
      ADR1 => Cpu16_I2_TC_c_0_1,
      ADR2 => Cpu16_I2_TC_c_2_1,
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => CHOICE870_G
    );
  XLXI_4_n00021_SW2 : X_LUT4
    generic map(
      INIT => X"6CCC"
    )
    port map (
      ADR0 => Cpu16_I1_nreset_v(1),
      ADR1 => XLXI_4_addr_c(2),
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => Cpu16_pc_mux(2),
      O => XLXI_4_n00021_SW5_O_G
    );
  Cpu16_I3_Mmux_data_x_Result_3_114_SW0 : X_LUT4
    generic map(
      INIT => X"C48C"
    )
    port map (
      ADR0 => N31830,
      ADR1 => Cpu16_I2_TD_c_0_3,
      ADR2 => Cpu16_I2_TD_c_1_2,
      ADR3 => Cpu16_I2_TD_c_2_3,
      O => N30830_F
    );
  XLXI_4_n00021_SW5 : X_LUT4
    generic map(
      INIT => X"9AAA"
    )
    port map (
      ADR0 => XLXI_4_addr_c(3),
      ADR1 => Cpu16_pc_mux(2),
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => Cpu16_I1_nreset_v(1),
      O => XLXI_4_n00021_SW5_O_F
    );
  Cpu16_I4_n0159_5_1 : X_LUT4
    generic map(
      INIT => X"F088"
    )
    port map (
      ADR0 => Cpu16_I4_iinc_we_c,
      ADR1 => Cpu16_I3_acc_c_0_5,
      ADR2 => Cpu16_I4_iinc_i(5),
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I4_n0159(5)
    );
  Cpu16_I4_iinc_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_c_5_DXMUX,
      CE => Cpu16_I4_iinc_c_5_CEINV,
      CLK => Cpu16_I4_iinc_c_5_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_c_5_FFX_RST,
      O => Cpu16_I4_iinc_c(5)
    );
  Cpu16_I4_iinc_c_5_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_iinc_c_5_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_iinc_c_5_FFX_RST
    );
  Cpu16_I4_n0159_6_1 : X_LUT4
    generic map(
      INIT => X"EA40"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I4_iinc_we_c,
      ADR2 => Cpu16_I3_acc_c_0_6,
      ADR3 => Cpu16_I4_iinc_i(6),
      O => Cpu16_I4_n0159(6)
    );
  Cpu16_I4_n0159_8_1 : X_LUT4
    generic map(
      INIT => X"AAC0"
    )
    port map (
      ADR0 => Cpu16_I4_iinc_i(8),
      ADR1 => Cpu16_I3_acc_c_0_8,
      ADR2 => Cpu16_I4_iinc_we_c,
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I4_n0159(8)
    );
  Cpu16_I4_iinc_c_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_c_7_DYMUX,
      CE => Cpu16_I4_iinc_c_7_CEINV,
      CLK => Cpu16_I4_iinc_c_7_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_c_7_FFY_RST,
      O => Cpu16_I4_iinc_c(6)
    );
  Cpu16_I4_iinc_c_7_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_iinc_c_7_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_iinc_c_7_FFY_RST
    );
  Cpu16_I4_n0159_7_1 : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I4_iinc_i(7),
      ADR2 => Cpu16_I4_iinc_we_c,
      ADR3 => Cpu16_I3_acc_c_0_7,
      O => Cpu16_I4_n0159(7)
    );
  Cpu16_I4_iinc_c_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_c_7_DXMUX,
      CE => Cpu16_I4_iinc_c_7_CEINV,
      CLK => Cpu16_I4_iinc_c_7_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_c_7_FFX_RST,
      O => Cpu16_I4_iinc_c(7)
    );
  Cpu16_I4_iinc_c_7_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_iinc_c_7_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_iinc_c_7_FFX_RST
    );
  Cpu16_I4_iinc_c_8 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_c_9_DYMUX,
      CE => Cpu16_I4_iinc_c_9_CEINV,
      CLK => Cpu16_I4_iinc_c_9_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_c_9_FFY_RST,
      O => Cpu16_I4_iinc_c(8)
    );
  Cpu16_I4_iinc_c_9_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_iinc_c_9_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_iinc_c_9_FFY_RST
    );
  Cpu16_I4_n0159_9_1 : X_LUT4
    generic map(
      INIT => X"CCA0"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_9,
      ADR1 => Cpu16_I4_iinc_i(9),
      ADR2 => Cpu16_I4_iinc_we_c,
      ADR3 => Cpu16_int_stop,
      O => Cpu16_I4_n0159(9)
    );
  Cpu16_I4_iinc_x_0_1 : X_LUT4
    generic map(
      INIT => X"B888"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_0_1,
      ADR1 => Cpu16_I4_iinc_we_c,
      ADR2 => Cpu16_I4_n01621_1,
      ADR3 => Cpu16_I4_iinc_c(0),
      O => Cpu16_I4_iinc_x(0)
    );
  Cpu16_I4_iinc_i_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_i_5_DXMUX,
      CE => Cpu16_I4_iinc_i_5_CEINV,
      CLK => Cpu16_I4_iinc_i_5_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_i_5_FFX_RST,
      O => Cpu16_I4_iinc_i(5)
    );
  Cpu16_I4_iinc_i_5_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_iinc_i_5_FFX_RST
    );
  Cpu16_I4_iinc_x_8_1 : X_LUT4
    generic map(
      INIT => X"EC20"
    )
    port map (
      ADR0 => Cpu16_I4_iinc_c(8),
      ADR1 => Cpu16_I4_iinc_we_c,
      ADR2 => Cpu16_I4_n01621_1,
      ADR3 => Cpu16_I3_acc_c_0_8,
      O => Cpu16_I4_iinc_x(8)
    );
  Cpu16_I4_iinc_i_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_i_7_DYMUX,
      CE => Cpu16_I4_iinc_i_7_CEINV,
      CLK => Cpu16_I4_iinc_i_7_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_i_7_FFY_RST,
      O => Cpu16_I4_iinc_i(6)
    );
  Cpu16_I4_iinc_i_7_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_iinc_i_7_FFY_RST
    );
  Cpu16_I4_iinc_x_7_1 : X_LUT4
    generic map(
      INIT => X"CAC0"
    )
    port map (
      ADR0 => Cpu16_I4_n01621_1,
      ADR1 => Cpu16_I3_acc_c_0_7,
      ADR2 => Cpu16_I4_iinc_we_c,
      ADR3 => Cpu16_I4_iinc_c(7),
      O => Cpu16_I4_iinc_x(7)
    );
  Cpu16_I4_iinc_i_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_i_7_DXMUX,
      CE => Cpu16_I4_iinc_i_7_CEINV,
      CLK => Cpu16_I4_iinc_i_7_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_i_7_FFX_RST,
      O => Cpu16_I4_iinc_i(7)
    );
  Cpu16_I4_iinc_i_7_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_iinc_i_7_FFX_RST
    );
  Cpu16_I2_E_c_FFd2_In1 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => XLXI_3_a2vi_s(0),
      ADR1 => Cpu16_I2_N15561,
      ADR2 => Cpu16_I2_nreset_v_1_1,
      ADR3 => VCC,
      O => Cpu16_I2_E_c_FFd2_G
    );
  Cpu16_I4_iinc_i_8 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_i_9_DYMUX,
      CE => Cpu16_I4_iinc_i_9_CEINV,
      CLK => Cpu16_I4_iinc_i_9_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_i_9_FFY_RST,
      O => Cpu16_I4_iinc_i(8)
    );
  Cpu16_I4_iinc_i_9_FFY_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_iinc_i_9_FFY_RST
    );
  Cpu16_I4_iinc_x_9_1 : X_LUT4
    generic map(
      INIT => X"B888"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_9,
      ADR1 => Cpu16_I4_iinc_we_c,
      ADR2 => Cpu16_I4_n01621_1,
      ADR3 => Cpu16_I4_iinc_c(9),
      O => Cpu16_I4_iinc_x(9)
    );
  Cpu16_I4_iinc_i_9 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_i_9_DXMUX,
      CE => Cpu16_I4_iinc_i_9_CEINV,
      CLK => Cpu16_I4_iinc_i_9_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_i_9_FFX_RST,
      O => Cpu16_I4_iinc_i(9)
    );
  Cpu16_I4_iinc_i_9_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_iinc_i_9_FFX_RST
    );
  Cpu16_I2_E_c_FFd2_1145 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_E_c_FFd2_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_E_c_FFd2_CLKINV,
      SET => GND,
      RST => Cpu16_I2_E_c_FFd2_FFY_RST,
      O => Cpu16_I2_E_c_FFd2
    );
  Cpu16_I2_E_c_FFd2_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_E_c_FFd2_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_E_c_FFd2_FFY_RST
    );
  Cpu16_I2_int_stop_x2 : X_LUT4
    generic map(
      INIT => X"C8C8"
    )
    port map (
      ADR0 => Cpu16_I2_n0062,
      ADR1 => Cpu16_I2_int_stop_c,
      ADR2 => Cpu16_I2_n0063,
      ADR3 => VCC,
      O => Cpu16_I2_E_c_FFd2_F
    );
  Cpu16_I2_E_c_FFd4_In31 : X_LUT4
    generic map(
      INIT => X"7530"
    )
    port map (
      ADR0 => N31584,
      ADR1 => Cpu16_I2_nreset_v_1_1,
      ADR2 => CHOICE288,
      ADR3 => Cpu16_I2_N15561,
      O => Cpu16_I2_E_c_FFd4_In
    );
  Cpu16_I2_TD_x_0_35 : X_LUT4
    generic map(
      INIT => X"0020"
    )
    port map (
      ADR0 => Cpu16_I2_n0077,
      ADR1 => Cpu16_I2_idata_x(3),
      ADR2 => Cpu16_I2_Mmux_idata_x_Result_4_1_1,
      ADR3 => Cpu16_I2_idata_x(0),
      O => Cpu16_I2_TD_c_0_1_G
    );
  Cpu16_I2_TD_c_0_2_1146 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TD_c_0_1_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_TD_c_0_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TD_c_0_1_FFY_RST,
      O => Cpu16_I2_TD_c_0_2
    );
  Cpu16_I2_TD_c_0_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TD_c_0_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TD_c_0_1_FFY_RST
    );
  Cpu16_I2_TD_x_0_67 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => CHOICE293,
      ADR2 => CHOICE307,
      ADR3 => CHOICE302,
      O => Cpu16_I2_TD_c_0_1_F
    );
  Cpu16_I3_n0147_3_13_SW0 : X_LUT4
    generic map(
      INIT => X"F0FC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => CHOICE878,
      ADR3 => Cpu16_I2_TD_c_3_1,
      O => N30665_F
    );
  Cpu16_I2_TD_c_0_1_1147 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TD_c_0_1_DXMUX,
      CE => VCC,
      CLK => Cpu16_I2_TD_c_0_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TD_c_0_1_FFX_RST,
      O => Cpu16_I2_TD_c_0_1
    );
  Cpu16_I2_TD_c_0_1_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TD_c_0_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TD_c_0_1_FFX_RST
    );
  Cpu16_I2_pc_mux_x_0_61_SW0 : X_LUT4
    generic map(
      INIT => X"AA00"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => Cpu16_I2_n0166(2),
      O => N30424_F
    );
  Cpu16_I2_pc_mux_x_2_46_SW1 : X_LUT4
    generic map(
      INIT => X"6333"
    )
    port map (
      ADR0 => Cpu16_I2_n0145,
      ADR1 => XLXI_4_addr_c(1),
      ADR2 => Cpu16_I2_N15717,
      ADR3 => Cpu16_I1_n0010,
      O => N30764_G
    );
  XLXI_4_n00021_SW0 : X_LUT4
    generic map(
      INIT => X"2733"
    )
    port map (
      ADR0 => Cpu16_I2_Mmux_skip_x_Result1_1,
      ADR1 => N31108,
      ADR2 => N31110,
      ADR3 => CHOICE660,
      O => N30764_F
    );
  Cpu16_I2_TD_x_3_SW0 : X_LUT4
    generic map(
      INIT => X"FFF3"
    )
    port map (
      ADR0 => VCC,
      ADR1 => NRESET_IN_BUFGP,
      ADR2 => Cpu16_I2_idata_x(0),
      ADR3 => Cpu16_I2_idata_x(3),
      O => Cpu16_I2_TD_c_3_1_G
    );
  Cpu16_I2_TD_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TD_c_3_1_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_TD_c_3_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TD_c_3_1_FFY_RST,
      O => Cpu16_I2_TD_c(3)
    );
  Cpu16_I2_TD_c_3_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TD_c_3_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TD_c_3_1_FFY_RST
    );
  Cpu16_I2_TD_x_3_Q : X_LUT4
    generic map(
      INIT => X"0200"
    )
    port map (
      ADR0 => Cpu16_daddr_is(3),
      ADR1 => Cpu16_I2_Mmux_idata_x_Result_6_1_1,
      ADR2 => N20207,
      ADR3 => Cpu16_I2_n0077,
      O => Cpu16_I2_TD_c_3_1_F
    );
  XLXI_5_n00287 : X_LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      ADR0 => XLXI_5_nwait_c(1),
      ADR1 => XLXI_5_nwait_c(2),
      ADR2 => XLXI_5_nwait_c(3),
      ADR3 => XLXI_5_nwait_c(0),
      O => CHOICE270_F
    );
  Cpu16_I2_TD_c_3_1_1148 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TD_c_3_1_DXMUX,
      CE => VCC,
      CLK => Cpu16_I2_TD_c_3_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TD_c_3_1_FFX_RST,
      O => Cpu16_I2_TD_c_3_1
    );
  Cpu16_I2_TD_c_3_1_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TD_c_3_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TD_c_3_1_FFX_RST
    );
  XLXI_5_Mmux_n0016_Result9 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => XLXI_5_nwait_c(4),
      ADR1 => XLXI_5_nwait_c(5),
      ADR2 => XLXI_5_nwait_c(7),
      ADR3 => XLXI_5_nwait_c(6),
      O => CHOICE583_G
    );
  Cpu16_I2_n00771_SW0 : X_LUT4
    generic map(
      INIT => X"0055"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(2),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => Cpu16_I2_idata_c(1),
      O => N31179_G
    );
  XLXI_5_Mmux_n0016_Result18 : X_LUT4
    generic map(
      INIT => X"AAA0"
    )
    port map (
      ADR0 => XLXI_5_dw_s(0),
      ADR1 => VCC,
      ADR2 => CHOICE578,
      ADR3 => CHOICE581,
      O => CHOICE583_F
    );
  Cpu16_I2_TC_x_0_SW0_SW2_SW0 : X_LUT4
    generic map(
      INIT => X"FFBB"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(2),
      ADR1 => Cpu16_I2_idata_c(0),
      ADR2 => VCC,
      ADR3 => Cpu16_I2_idata_c(1),
      O => N31179_F
    );
  Cpu16_I2_E_c_FFd4_In23 : X_LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      ADR0 => Cpu16_I2_E_c_FFd3,
      ADR1 => Cpu16_I2_E_c_FFd2,
      ADR2 => Cpu16_I2_E_c_FFd1,
      ADR3 => Cpu16_I2_E_c_FFd4,
      O => CHOICE288_F
    );
  Cpu16_I1_iaddr_x_9_25 : X_LUT4
    generic map(
      INIT => X"CCA0"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_1_44_2,
      ADR1 => XLXN_20(9),
      ADR2 => MEM_DATA_OUT(13),
      ADR3 => Cpu16_I2_pc_mux_x_2_46_2,
      O => CHOICE392_F
    );
  Cpu16_I4_data_ox_4_1 : X_LUT4
    generic map(
      INIT => X"A000"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => VCC,
      ADR2 => Cpu16_I4_nreset_v(1),
      ADR3 => Cpu16_I3_acc_c_0_4,
      O => DATA_OUT_EXT_4_OBUF_F
    );
  Cpu16_I2_nreset_v_1_1_1149 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_nreset_v_1_1_DYMUX,
      CE => Cpu16_I2_nreset_v_1_1_CEINV,
      CLK => Cpu16_I2_nreset_v_1_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_nreset_v_1_1_FFY_RST,
      O => Cpu16_I2_nreset_v_1_1
    );
  Cpu16_I2_nreset_v_1_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_nreset_v_1_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_nreset_v_1_1_FFY_RST
    );
  Cpu16_I4_data_ox_5_1 : X_LUT4
    generic map(
      INIT => X"8800"
    )
    port map (
      ADR0 => Cpu16_I4_nreset_v(1),
      ADR1 => Cpu16_I3_acc_c_0_5,
      ADR2 => VCC,
      ADR3 => NRESET_IN_BUFGP,
      O => DATA_OUT_EXT_6_OBUF_G
    );
  Cpu16_I4_data_ox_6_1 : X_LUT4
    generic map(
      INIT => X"A000"
    )
    port map (
      ADR0 => Cpu16_I4_nreset_v(1),
      ADR1 => VCC,
      ADR2 => Cpu16_I3_acc_c_0_6,
      ADR3 => NRESET_IN_BUFGP,
      O => DATA_OUT_EXT_6_OBUF_F
    );
  Cpu16_I1_iaddr_x_10_25 : X_LUT4
    generic map(
      INIT => X"D888"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_2_46_1,
      ADR1 => XLXN_20(10),
      ADR2 => MEM_DATA_OUT(14),
      ADR3 => Cpu16_I2_pc_mux_x_1_44_1,
      O => CHOICE397_G
    );
  Cpu16_I4_data_ox_7_1 : X_LUT4
    generic map(
      INIT => X"8800"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_I4_nreset_v(1),
      ADR2 => VCC,
      ADR3 => Cpu16_I3_acc_c_0_7,
      O => DATA_OUT_EXT_8_OBUF_G
    );
  Cpu16_I1_Mmux_saddr_out_Result_11_1 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_2_46_1,
      ADR1 => Cpu16_I1_pc(11),
      ADR2 => Cpu16_I2_pc_mux_x_0_104_1,
      ADR3 => Cpu16_I2_pc_mux_x_1_44_1,
      O => CHOICE397_F
    );
  Cpu16_I1_iaddr_x_7_25 : X_LUT4
    generic map(
      INIT => X"E2C0"
    )
    port map (
      ADR0 => MEM_DATA_OUT(11),
      ADR1 => Cpu16_I2_pc_mux_x_2_46_2,
      ADR2 => XLXN_20(7),
      ADR3 => Cpu16_I2_pc_mux_x_1_44_2,
      O => CHOICE530_G
    );
  Cpu16_I3_n0147_7_72_SW0 : X_LUT4
    generic map(
      INIT => X"F800"
    )
    port map (
      ADR0 => N30718,
      ADR1 => CHOICE1076,
      ADR2 => CHOICE1098,
      ADR3 => Cpu16_I3_n0023,
      O => N30347_F
    );
  Cpu16_I3_Mmux_data_x_Result_4_114_SW2 : X_LUT4
    generic map(
      INIT => X"D030"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_4,
      ADR1 => Cpu16_I2_TD_c_2_2,
      ADR2 => Cpu16_I2_TD_c_1_2,
      ADR3 => Cpu16_I2_TD_c_0_2,
      O => N31311_F
    );
  Cpu16_I4_data_ox_11_1 : X_LUT4
    generic map(
      INIT => X"8800"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_I4_nreset_v(1),
      ADR2 => VCC,
      ADR3 => Cpu16_I3_acc_c_0_11,
      O => DATA_OUT_EXT_12_OBUF_G
    );
  Cpu16_I4_data_ox_12_1 : X_LUT4
    generic map(
      INIT => X"C000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I4_nreset_v(1),
      ADR2 => Cpu16_I3_acc_c_0_12,
      ADR3 => NRESET_IN_BUFGP,
      O => DATA_OUT_EXT_12_OBUF_F
    );
  Cpu16_I4_data_ox_13_1 : X_LUT4
    generic map(
      INIT => X"A000"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => VCC,
      ADR2 => Cpu16_I4_nreset_v(1),
      ADR3 => Cpu16_I3_acc_c_0_13,
      O => DATA_OUT_EXT_14_OBUF_G
    );
  Cpu16_I4_data_ox_14_1 : X_LUT4
    generic map(
      INIT => X"C000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_acc_c_0_14,
      ADR2 => Cpu16_I4_nreset_v(1),
      ADR3 => NRESET_IN_BUFGP,
      O => DATA_OUT_EXT_14_OBUF_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_10_0 : X_LUT4
    generic map(
      INIT => X"A0A0"
    )
    port map (
      ADR0 => Cpu16_I1_N13634,
      ADR1 => VCC,
      ADR2 => XLXN_20(10),
      ADR3 => VCC,
      O => CHOICE468_G
    );
  Cpu16_I1_Mmux_saddr_out_Result_8_0 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => Cpu16_I1_N13634,
      ADR1 => XLXN_20(8),
      ADR2 => VCC,
      ADR3 => VCC,
      O => CHOICE468_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_11_0 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => XLXN_20(11),
      ADR2 => VCC,
      ADR3 => Cpu16_I1_N13634,
      O => CHOICE412_G
    );
  Cpu16_I4_data_ox_15_1 : X_LUT4
    generic map(
      INIT => X"A000"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => VCC,
      ADR2 => Cpu16_I4_nreset_v(1),
      ADR3 => Cpu16_I3_acc_c_0_15,
      O => Cpu16_I4_N18286_G
    );
  Cpu16_I2_TD_x_1_61 : X_LUT4
    generic map(
      INIT => X"0005"
    )
    port map (
      ADR0 => Cpu16_I2_idata_x(2),
      ADR1 => VCC,
      ADR2 => Cpu16_I2_idata_x(3),
      ADR3 => Cpu16_I2_idata_x(0),
      O => Cpu16_I2_TD_c_1_1_G
    );
  Cpu16_I1_iaddr_x_3_25 : X_LUT4
    generic map(
      INIT => X"CAC0"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_1_44_2,
      ADR1 => XLXN_20(3),
      ADR2 => Cpu16_I2_pc_mux_x_2_46_2,
      ADR3 => MEM_DATA_OUT(7),
      O => CHOICE544_G
    );
  Cpu16_I2_TD_c_1_2_1150 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TD_c_1_1_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_TD_c_1_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TD_c_1_1_FFY_RST,
      O => Cpu16_I2_TD_c_1_2
    );
  Cpu16_I2_TD_c_1_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TD_c_1_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TD_c_1_1_FFY_RST
    );
  Cpu16_I2_TD_x_1_97 : X_LUT4
    generic map(
      INIT => X"EC00"
    )
    port map (
      ADR0 => CHOICE345,
      ADR1 => Cpu16_I2_idata_x(1),
      ADR2 => CHOICE350,
      ADR3 => NRESET_IN_BUFGP,
      O => Cpu16_I2_TD_c_1_1_F
    );
  Cpu16_I2_TC_x_2_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"7773"
    )
    port map (
      ADR0 => Cpu16_I2_n0150,
      ADR1 => NRESET_IN_BUFGP,
      ADR2 => Cpu16_I2_idata_c(1),
      ADR3 => Cpu16_I2_idata_c(2),
      O => N31197_G
    );
  Cpu16_I3_n0147_6_72_SW0 : X_LUT4
    generic map(
      INIT => X"E0A0"
    )
    port map (
      ADR0 => CHOICE1043,
      ADR1 => N30952,
      ADR2 => Cpu16_I3_n0023,
      ADR3 => CHOICE1021,
      O => N30353_F
    );
  Cpu16_I2_TD_c_1_1_1151 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TD_c_1_1_DXMUX,
      CE => VCC,
      CLK => Cpu16_I2_TD_c_1_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TD_c_1_1_FFX_RST,
      O => Cpu16_I2_TD_c_1_1
    );
  Cpu16_I2_TD_c_1_1_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TD_c_1_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TD_c_1_1_FFX_RST
    );
  Cpu16_I2_ndre_x1_SW2_SW0_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"8880"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_I4_nreset_v(1),
      ADR2 => Cpu16_I2_idata_c(1),
      ADR3 => Cpu16_I2_idata_c(2),
      O => N31197_F
    );
  Cpu16_I2_pc_mux_x_2_46_SW3 : X_LUT4
    generic map(
      INIT => X"4BF0"
    )
    port map (
      ADR0 => Cpu16_I2_n0145,
      ADR1 => Cpu16_I2_N15717,
      ADR2 => XLXI_4_addr_c(1),
      ADR3 => Cpu16_I1_n0010,
      O => XLXI_4_n00021_SW1_O_G
    );
  XLXI_4_n00021_SW1 : X_LUT4
    generic map(
      INIT => X"F0D8"
    )
    port map (
      ADR0 => CHOICE660,
      ADR1 => N31116,
      ADR2 => N31114,
      ADR3 => Cpu16_I2_Mmux_skip_x_Result1_1,
      O => XLXI_4_n00021_SW1_O_F
    );
  Cpu16_I4_Ker182841 : X_LUT4
    generic map(
      INIT => X"2020"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_I4_ireg_we_c,
      ADR2 => Cpu16_I4_nreset_v(1),
      ADR3 => VCC,
      O => Cpu16_I4_N18286_F
    );
  Cpu16_I1_Mmux_saddr_out_Result_1_0 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXN_20(1),
      ADR3 => Cpu16_I1_N13634,
      O => CHOICE412_F
    );
  Cpu16_I1_iaddr_x_0_44_SW0 : X_LUT4
    generic map(
      INIT => X"A3AC"
    )
    port map (
      ADR0 => MEM_DATA_OUT(4),
      ADR1 => Cpu16_I1_pc(0),
      ADR2 => Cpu16_pc_mux(1),
      ADR3 => Cpu16_pc_mux(0),
      O => Cpu16_I1_n0020_G
    );
  Cpu16_I1_n00201 : X_LUT4
    generic map(
      INIT => X"00C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_pc_mux(2),
      ADR2 => Cpu16_pc_mux(1),
      ADR3 => Cpu16_pc_mux(0),
      O => Cpu16_I1_n0020_F
    );
  Cpu16_I3_n0147_0_164_SW0 : X_LUT4
    generic map(
      INIT => X"ECA0"
    )
    port map (
      ADR0 => Cpu16_I3_N17531,
      ADR1 => Cpu16_I3_n0091,
      ADR2 => CHOICE737,
      ADR3 => Cpu16_I3_acc_i_0_0,
      O => CHOICE740_G
    );
  Cpu16_I3_n0147_0_164 : X_LUT4
    generic map(
      INIT => X"F8F8"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_0_1,
      ADR1 => Cpu16_I3_N17260,
      ADR2 => N31608,
      ADR3 => VCC,
      O => CHOICE740_F
    );
  Cpu16_I3_Mmux_data_x_Result_0_32_SW0 : X_LUT4
    generic map(
      INIT => X"ABFB"
    )
    port map (
      ADR0 => N30694,
      ADR1 => Cpu16_I4_ireg_c(0),
      ADR2 => Cpu16_I2_idata_c(6),
      ADR3 => Cpu16_I4_data_exp_c(0),
      O => N31258_F
    );
  Cpu16_I3_n0023_SW15 : X_LUT4
    generic map(
      INIT => X"AA00"
    )
    port map (
      ADR0 => CHOICE255,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => Cpu16_I2_n01501_1,
      O => CHOICE746_G
    );
  Cpu16_I3_n0147_0_190_SW0 : X_LUT4
    generic map(
      INIT => X"8800"
    )
    port map (
      ADR0 => Cpu16_I2_n01501_1,
      ADR1 => CHOICE740,
      ADR2 => VCC,
      ADR3 => CHOICE255,
      O => N30440_G
    );
  Cpu16_I3_n0147_15_13_SW1 : X_LUT4
    generic map(
      INIT => X"EEAE"
    )
    port map (
      ADR0 => CHOICE1653,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => Cpu16_I2_TD_c(3),
      ADR3 => Cpu16_I3_acc_c_0_15,
      O => N30637_F
    );
  Cpu16_I4_n01621_1_1152 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => NRESET_IN_BUFGP,
      ADR2 => VCC,
      ADR3 => Cpu16_I4_nreset_v(1),
      O => Cpu16_I4_iinc_i_3_G
    );
  Cpu16_I3_n0147_5_13_SW2 : X_LUT4
    generic map(
      INIT => X"1400"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_2_1,
      ADR1 => Cpu16_I2_TC_c_1_1,
      ADR2 => Cpu16_I2_TC_c_0_1,
      ADR3 => Cpu16_I3_acc_c_0_5,
      O => N30359_G
    );
  Cpu16_I4_iinc_x_3_1 : X_LUT4
    generic map(
      INIT => X"F088"
    )
    port map (
      ADR0 => Cpu16_I4_iinc_c(3),
      ADR1 => Cpu16_I4_n01621_1,
      ADR2 => Cpu16_I3_acc_c_0_3,
      ADR3 => Cpu16_I4_iinc_we_c,
      O => Cpu16_I4_iinc_x(3)
    );
  Cpu16_I4_iinc_i_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_iinc_i_3_DXMUX,
      CE => Cpu16_I4_iinc_i_3_CEINV,
      CLK => Cpu16_I4_iinc_i_3_CLKINV,
      SET => GND,
      RST => Cpu16_I4_iinc_i_3_FFX_RST,
      O => Cpu16_I4_iinc_i(3)
    );
  Cpu16_I4_iinc_i_3_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_iinc_i_3_FFX_RST
    );
  Cpu16_I3_n0147_5_72_SW0 : X_LUT4
    generic map(
      INIT => X"EC00"
    )
    port map (
      ADR0 => N30956,
      ADR1 => CHOICE988,
      ADR2 => CHOICE966,
      ADR3 => Cpu16_I3_n0023,
      O => N30359_F
    );
  Cpu16_I3_n0147_16_31_SW1_SW0 : X_LUT4
    generic map(
      INIT => X"0303"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => CHOICE1380,
      ADR3 => VCC,
      O => N30295_G
    );
  XLXI_5_Mmux_cpu_daddr_out_Result_0_1 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_5_N12936,
      ADR1 => XLXI_5_N12957,
      ADR2 => CPU_ADADDR_OUT(0),
      ADR3 => XLXI_5_cpu_daddr_c(0),
      O => ADDR_OUT_EXT_4_OBUF_G
    );
  Cpu16_I3_n0147_16_31_SW1 : X_LUT4
    generic map(
      INIT => X"A0A2"
    )
    port map (
      ADR0 => Cpu16_I3_n0023,
      ADR1 => Cpu16_I2_TD_c_3_1,
      ADR2 => CHOICE1402,
      ADR3 => N31964,
      O => N30295_F
    );
  XLXI_5_Mmux_cpu_daddr_out_Result_1_1 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_5_N12936,
      ADR1 => CPU_ADADDR_OUT(1),
      ADR2 => XLXI_5_N12957,
      ADR3 => XLXI_5_cpu_daddr_c(1),
      O => ADDR_OUT_EXT_5_OBUF_G
    );
  XLXI_5_Mmux_cpu_daddr_out_Result_4_1 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_5_N12936,
      ADR1 => XLXI_5_cpu_daddr_c(4),
      ADR2 => CPU_ADADDR_OUT(4),
      ADR3 => XLXI_5_N12957,
      O => ADDR_OUT_EXT_4_OBUF_F
    );
  Cpu16_I3_n0147_1_13_SW1 : X_LUT4
    generic map(
      INIT => X"ECFC"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_1,
      ADR1 => CHOICE816,
      ADR2 => Cpu16_I3_n0100,
      ADR3 => Cpu16_I2_TD_c(3),
      O => N30673_F
    );
  Cpu16_I3_n0147_9_82 : X_LUT4
    generic map(
      INIT => X"0060"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_2_3,
      ADR1 => Cpu16_I2_TD_c(1),
      ADR2 => Cpu16_I3_acc_c_0_10,
      ADR3 => Cpu16_I2_TD_c_0_3,
      O => CHOICE1201_F
    );
  Cpu16_I3_n0147_1_13_SW2 : X_LUT4
    generic map(
      INIT => X"0440"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_2_1,
      ADR1 => Cpu16_I3_acc_c_0_1,
      ADR2 => Cpu16_I2_TC_c_0_1,
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => N30383_G
    );
  Cpu16_I3_n0147_16_80 : X_LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_16,
      ADR1 => CHOICE4,
      ADR2 => CHOICE1395,
      ADR3 => CHOICE1390,
      O => CHOICE1402_G
    );
  Cpu16_I3_n0147_1_72_SW0 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => Cpu16_I3_n0023,
      ADR1 => CHOICE816,
      ADR2 => N31035,
      ADR3 => CHOICE794,
      O => N30383_F
    );
  Cpu16_I3_n0147_16_90 : X_LUT4
    generic map(
      INIT => X"EECC"
    )
    port map (
      ADR0 => Cpu16_I3_acc_i_0_16,
      ADR1 => CHOICE1401,
      ADR2 => VCC,
      ADR3 => Cpu16_I3_n0091,
      O => CHOICE1402_F
    );
  Cpu16_I1_nreset_v_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_nreset_v_1_DYMUX,
      CE => Cpu16_I1_nreset_v_1_CEINV,
      CLK => Cpu16_I1_nreset_v_1_CLKINV,
      SET => GND,
      RST => Cpu16_I1_nreset_v_1_FFY_RST,
      O => Cpu16_I1_nreset_v(1)
    );
  Cpu16_I1_nreset_v_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I1_nreset_v_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I1_nreset_v_1_FFY_RST
    );
  Cpu16_I3_Mmux_data_x_Result_6_114_SW2 : X_LUT4
    generic map(
      INIT => X"84C4"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_2_2,
      ADR1 => Cpu16_I2_TD_c_1_2,
      ADR2 => Cpu16_I2_TD_c_0_2,
      ADR3 => Cpu16_I3_acc_c_0_6,
      O => N31299_G
    );
  Cpu16_I3_n0147_9_13_SW2 : X_LUT4
    generic map(
      INIT => X"0220"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_9,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I2_TC_c_1_1,
      ADR3 => Cpu16_I2_TC_c_0_1,
      O => N30335_G
    );
  Cpu16_I3_n0147_9_13_SW0 : X_LUT4
    generic map(
      INIT => X"AAEE"
    )
    port map (
      ADR0 => CHOICE1208,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => VCC,
      ADR3 => Cpu16_I2_TD_c_3_1,
      O => N30619_G
    );
  Cpu16_I3_Mmux_data_x_Result_11_114_SW2 : X_LUT4
    generic map(
      INIT => X"84C4"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_2_2,
      ADR1 => Cpu16_I2_TD_c_1_2,
      ADR2 => Cpu16_I2_TD_c_0_2,
      ADR3 => Cpu16_I3_acc_c_0_11,
      O => N31299_F
    );
  Cpu16_I3_Mmux_data_x_Result_2_13 : X_LUT4
    generic map(
      INIT => X"88A0"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => DATA_IN_EXT_2_IBUF,
      ADR2 => MEM_DATA_OUT(2),
      ADR3 => XLXI_2_mux_c(0),
      O => CHOICE1415_F
    );
  Cpu16_I3_Mmux_data_x_Result_1_13 : X_LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => XLXI_2_mux_c(0),
      ADR2 => DATA_IN_EXT_1_IBUF,
      ADR3 => MEM_DATA_OUT(1),
      O => CHOICE1162_G
    );
  Cpu16_I3_n0147_10_72_SW0 : X_LUT4
    generic map(
      INIT => X"CC80"
    )
    port map (
      ADR0 => CHOICE1241,
      ADR1 => Cpu16_I3_n0023,
      ADR2 => N30706,
      ADR3 => CHOICE1263,
      O => N30329_F
    );
  Cpu16_I3_Mmux_data_x_Result_6_13 : X_LUT4
    generic map(
      INIT => X"E200"
    )
    port map (
      ADR0 => MEM_DATA_OUT(6),
      ADR1 => XLXI_2_mux_c(0),
      ADR2 => DATA_IN_EXT_6_IBUF,
      ADR3 => NRESET_IN_BUFGP,
      O => CHOICE1162_F
    );
  Cpu16_I3_Mmux_data_x_Result_3_13 : X_LUT4
    generic map(
      INIT => X"CA00"
    )
    port map (
      ADR0 => MEM_DATA_OUT(3),
      ADR1 => DATA_IN_EXT_3_IBUF,
      ADR2 => XLXI_2_mux_c(0),
      ADR3 => NRESET_IN_BUFGP,
      O => CHOICE997_G
    );
  Cpu16_I3_Mmux_data_x_Result_9_13 : X_LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => MEM_DATA_OUT(9),
      ADR2 => XLXI_2_mux_c(0),
      ADR3 => DATA_IN_EXT_9_IBUF,
      O => CHOICE997_F
    );
  Cpu16_I3_n0147_10_19 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_1_1,
      ADR1 => Cpu16_I2_TD_c_2_1,
      ADR2 => Cpu16_I3_n0090(10),
      ADR3 => Cpu16_I2_TD_c_0_1,
      O => CHOICE717_G
    );
  Cpu16_I3_n0147_0_44 : X_LUT4
    generic map(
      INIT => X"8A22"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_1_1,
      ADR1 => Cpu16_I2_TD_c_2_1,
      ADR2 => Cpu16_I3_acc_c_0_0_1,
      ADR3 => Cpu16_I2_TD_c_0_1,
      O => CHOICE717_F
    );
  Cpu16_I3_n0147_10_81 : X_LUT4
    generic map(
      INIT => X"0400"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I2_TC_c_0_1,
      ADR3 => Cpu16_I3_acc_i_0_10,
      O => CHOICE1035_G
    );
  Cpu16_I3_n0147_10_29 : X_LUT4
    generic map(
      INIT => X"E020"
    )
    port map (
      ADR0 => CHOICE957,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => N31303,
      ADR3 => Cpu16_I2_data_is_c(10),
      O => N30812_G
    );
  Cpu16_I3_Mmux_data_x_Result_3_32 : X_LUT4
    generic map(
      INIT => X"D080"
    )
    port map (
      ADR0 => Cpu16_daddr_is(2),
      ADR1 => Cpu16_I4_data_exp_c(3),
      ADR2 => Cpu16_I4_N18357,
      ADR3 => Cpu16_I4_ireg_c(3),
      O => CHOICE893_G
    );
  Cpu16_I3_Mmux_data_x_Result_14_SW3 : X_LUT4
    generic map(
      INIT => X"C03F"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => Cpu16_data_is_int(14),
      ADR3 => Cpu16_I3_acc_c_0_14,
      O => N30812_F
    );
  Cpu16_I3_acc_c_0_15_1153 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_15_DXMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_15_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_15_FFX_RST,
      O => Cpu16_I3_acc_c_0_15
    );
  Cpu16_I3_acc_c_0_15_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_15_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_15_FFX_RST
    );
  Cpu16_I3_acc_c_0_16_1154 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_16_DYMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_16_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_16_FFY_RST,
      O => Cpu16_I3_acc_c_0_16
    );
  Cpu16_I3_acc_c_0_16_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_16_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_16_FFY_RST
    );
  Cpu16_I3_Mmux_data_x_Result_15_SW0 : X_LUT4
    generic map(
      INIT => X"27FF"
    )
    port map (
      ADR0 => XLXI_2_mux_c(0),
      ADR1 => DATA_IN_EXT_15_IBUF,
      ADR2 => MEM_DATA_OUT(15),
      ADR3 => NRESET_IN_BUFGP,
      O => N24468_F
    );
  Cpu16_I2_idata_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_idata_c_1_DYMUX,
      CE => Cpu16_I2_idata_c_1_CEINV,
      CLK => Cpu16_I2_idata_c_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_idata_c_1_FFY_RST,
      O => Cpu16_I2_idata_c(0)
    );
  Cpu16_I2_idata_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_idata_c_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_idata_c_1_FFY_RST
    );
  Cpu16_I2_idata_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_idata_c_1_DXMUX,
      CE => Cpu16_I2_idata_c_1_CEINV,
      CLK => Cpu16_I2_idata_c_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_idata_c_1_FFX_RST,
      O => Cpu16_I2_idata_c(1)
    );
  Cpu16_I2_idata_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_idata_c_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_idata_c_1_FFX_RST
    );
  Cpu16_I2_idata_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_idata_c_3_DYMUX,
      CE => Cpu16_I2_idata_c_3_CEINV,
      CLK => Cpu16_I2_idata_c_3_CLKINV,
      SET => GND,
      RST => Cpu16_I2_idata_c_3_FFY_RST,
      O => Cpu16_I2_idata_c(2)
    );
  Cpu16_I2_idata_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_idata_c_3_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_idata_c_3_FFY_RST
    );
  Cpu16_I2_idata_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_idata_c_3_DXMUX,
      CE => Cpu16_I2_idata_c_3_CEINV,
      CLK => Cpu16_I2_idata_c_3_CLKINV,
      SET => GND,
      RST => Cpu16_I2_idata_c_3_FFX_RST,
      O => Cpu16_I2_idata_c(3)
    );
  Cpu16_I2_idata_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_idata_c_3_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_idata_c_3_FFX_RST
    );
  Cpu16_I3_n0147_2_19 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_1_1,
      ADR1 => Cpu16_I2_TD_c_2_1,
      ADR2 => Cpu16_I3_n0090(2),
      ADR3 => Cpu16_I2_TD_c_0_1,
      O => CHOICE827_F
    );
  Cpu16_I3_n00831 : X_LUT4
    generic map(
      INIT => X"0030"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_TD_c_0_2,
      ADR2 => Cpu16_I2_TD_c_2_1,
      ADR3 => Cpu16_I2_TD_c_1_1,
      O => CHOICE1078_G
    );
  Cpu16_I3_n00811 : X_LUT4
    generic map(
      INIT => X"000C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_TD_c(1),
      ADR2 => Cpu16_I2_TD_c(0),
      ADR3 => Cpu16_I2_TD_c(2),
      O => Cpu16_I3_N17006_G
    );
  XLXI_4_n00021_SW9 : X_LUT4
    generic map(
      INIT => X"D2F0"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_pc_mux(2),
      ADR2 => XLXI_4_addr_c(5),
      ADR3 => Cpu16_I1_nreset_v(1),
      O => XLXI_4_n00021_SW9_O_F
    );
  Cpu16_I3_Ker170041 : X_LUT4
    generic map(
      INIT => X"030C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_TD_c(1),
      ADR2 => Cpu16_I2_TD_c(0),
      ADR3 => Cpu16_I2_TD_c(2),
      O => Cpu16_I3_N17006_F
    );
  Cpu16_I3_n0147_14_29 : X_LUT4
    generic map(
      INIT => X"88A8"
    )
    port map (
      ADR0 => Cpu16_I3_data_x_14_Q,
      ADR1 => Cpu16_I3_N17242,
      ADR2 => Cpu16_I3_n0082,
      ADR3 => Cpu16_I3_acc_c_0_14,
      O => CHOICE1637_G
    );
  Cpu16_I3_n0147_15_29 : X_LUT4
    generic map(
      INIT => X"DC00"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_15,
      ADR1 => Cpu16_I3_N17242,
      ADR2 => Cpu16_I3_n0082,
      ADR3 => Cpu16_I3_data_x_15_Q,
      O => CHOICE1637_F
    );
  XLXI_4_n00021_SW8 : X_LUT4
    generic map(
      INIT => X"7F80"
    )
    port map (
      ADR0 => Cpu16_I1_nreset_v(1),
      ADR1 => Cpu16_pc_mux(2),
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => XLXI_4_addr_c(5),
      O => N30794_G
    );
  XLXI_4_n00021_SW10 : X_LUT4
    generic map(
      INIT => X"6CCC"
    )
    port map (
      ADR0 => Cpu16_I1_nreset_v(1),
      ADR1 => XLXI_4_addr_c(6),
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => Cpu16_pc_mux(2),
      O => N30794_F
    );
  Cpu16_I3_Mmux_data_x_Result_7_32 : X_LUT4
    generic map(
      INIT => X"8C80"
    )
    port map (
      ADR0 => Cpu16_I4_data_exp_c(7),
      ADR1 => Cpu16_I4_N18357,
      ADR2 => Cpu16_I2_Mmux_idata_x_Result_6_1_1,
      ADR3 => Cpu16_I4_ireg_c(7),
      O => CHOICE1003_G
    );
  Cpu16_I3_Mmux_data_x_Result_9_32 : X_LUT4
    generic map(
      INIT => X"8C80"
    )
    port map (
      ADR0 => Cpu16_I4_data_exp_c(9),
      ADR1 => Cpu16_I4_N18357,
      ADR2 => Cpu16_I2_Mmux_idata_x_Result_6_1_1,
      ADR3 => Cpu16_I4_ireg_c(9),
      O => CHOICE1003_F
    );
  Cpu16_I3_n00821 : X_LUT4
    generic map(
      INIT => X"4040"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_2_3,
      ADR1 => Cpu16_I2_TD_c_0_3,
      ADR2 => Cpu16_I2_TD_c(1),
      ADR3 => VCC,
      O => Cpu16_I3_N17389_G
    );
  Cpu16_I3_n0147_3_82 : X_LUT4
    generic map(
      INIT => X"00C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_TD_c(0),
      ADR2 => Cpu16_I3_acc_c_0_2,
      ADR3 => Cpu16_I2_TD_c(2),
      O => CHOICE871_F
    );
  Cpu16_I3_n0147_15_19 : X_LUT4
    generic map(
      INIT => X"4000"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_0_1,
      ADR1 => Cpu16_I2_TD_c_2_1,
      ADR2 => Cpu16_I3_n0090(15),
      ADR3 => Cpu16_I2_TD_c_1_1,
      O => CHOICE913_G
    );
  Cpu16_I3_n0147_16_53 : X_LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_2_3,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => Cpu16_I2_TD_c_0_3,
      ADR3 => Cpu16_I2_TD_c(1),
      O => CHOICE1201_G
    );
  Cpu16_I3_n0147_4_19 : X_LUT4
    generic map(
      INIT => X"4000"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_0_1,
      ADR1 => Cpu16_I2_TD_c_2_1,
      ADR2 => Cpu16_I3_n0090(4),
      ADR3 => Cpu16_I2_TD_c_1_1,
      O => CHOICE913_F
    );
  Cpu16_I3_n00871 : X_LUT4
    generic map(
      INIT => X"0C00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_TD_c(0),
      ADR2 => Cpu16_I2_TD_c(1),
      ADR3 => Cpu16_I2_TD_c(2),
      O => CHOICE1390_G
    );
  Cpu16_I3_n0147_16_42 : X_LUT4
    generic map(
      INIT => X"EE98"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_0_1,
      ADR2 => Cpu16_I3_n0087,
      ADR3 => Cpu16_I2_TC_c_2_1,
      O => CHOICE1390_F
    );
  Cpu16_I3_n0147_15_81 : X_LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I3_acc_i_0_15,
      ADR3 => Cpu16_I2_TC_c_0_1,
      O => CHOICE980_G
    );
  Cpu16_I3_n0147_5_81 : X_LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I3_acc_i_0_5,
      ADR3 => Cpu16_I2_TC_c_0_1,
      O => CHOICE980_F
    );
  Cpu16_I3_n0147_15_90 : X_LUT4
    generic map(
      INIT => X"88F8"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_14,
      ADR1 => Cpu16_I3_N17033,
      ADR2 => Cpu16_I3_n0084,
      ADR3 => Cpu16_I3_acc_c_0_15,
      O => CHOICE1653_G
    );
  Cpu16_I3_n0147_1_13_SW0 : X_LUT4
    generic map(
      INIT => X"CCFC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CHOICE816,
      ADR2 => Cpu16_I3_n0100,
      ADR3 => Cpu16_I2_TD_c(3),
      O => N30673_G
    );
  Cpu16_I3_n0147_15_106 : X_LUT4
    generic map(
      INIT => X"FFA8"
    )
    port map (
      ADR0 => Cpu16_I3_N17531,
      ADR1 => CHOICE1646,
      ADR2 => CHOICE1650,
      ADR3 => CHOICE1645,
      O => CHOICE1653_F
    );
  XLXI_4_n00021_SW4 : X_LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      ADR0 => XLXI_4_addr_c(3),
      ADR1 => Cpu16_pc_mux(2),
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => Cpu16_I1_nreset_v(1),
      O => XLXI_4_n00021_SW7_O_G
    );
  Cpu16_I3_n0147_3_81 : X_LUT4
    generic map(
      INIT => X"0020"
    )
    port map (
      ADR0 => Cpu16_I3_acc_i_0_3,
      ADR1 => Cpu16_I2_TC_c_0_1,
      ADR2 => Cpu16_I2_TC_c_2_1,
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => CHOICE870_F
    );
  XLXI_4_n00021_SW7 : X_LUT4
    generic map(
      INIT => X"DF20"
    )
    port map (
      ADR0 => Cpu16_I1_nreset_v(1),
      ADR1 => Cpu16_pc_mux(2),
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => XLXI_4_addr_c(4),
      O => XLXI_4_n00021_SW7_O_F
    );
  Cpu16_I3_n0147_13_90 : X_LUT4
    generic map(
      INIT => X"C0EA"
    )
    port map (
      ADR0 => Cpu16_I3_n0084,
      ADR1 => Cpu16_I3_N17006,
      ADR2 => Cpu16_I3_acc_c_0_14,
      ADR3 => Cpu16_I3_acc_c_0_13,
      O => CHOICE1461_G
    );
  Cpu16_I3_n0147_13_106 : X_LUT4
    generic map(
      INIT => X"FEAA"
    )
    port map (
      ADR0 => CHOICE1453,
      ADR1 => CHOICE1454,
      ADR2 => CHOICE1458,
      ADR3 => Cpu16_I3_N17531,
      O => CHOICE1461_F
    );
  Cpu16_I3_n0147_1_82 : X_LUT4
    generic map(
      INIT => X"0088"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_0,
      ADR1 => Cpu16_I2_TD_c(0),
      ADR2 => VCC,
      ADR3 => Cpu16_I2_TD_c(2),
      O => CHOICE809_F
    );
  Cpu16_I3_Mmux_data_x_Result_7_13 : X_LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => MEM_DATA_OUT(7),
      ADR2 => XLXI_2_mux_c(0),
      ADR3 => DATA_IN_EXT_7_IBUF,
      O => CHOICE1052_G
    );
  Cpu16_I3_Mmux_data_x_Result_8_13 : X_LUT4
    generic map(
      INIT => X"8A80"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => DATA_IN_EXT_8_IBUF,
      ADR2 => XLXI_2_mux_c(0),
      ADR3 => MEM_DATA_OUT(8),
      O => CHOICE1052_F
    );
  XLXI_4_n00021_SW6 : X_LUT4
    generic map(
      INIT => X"7F80"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_pc_mux(2),
      ADR2 => Cpu16_I1_nreset_v(1),
      ADR3 => XLXI_4_addr_c(4),
      O => XLXI_4_n00021_SW9_O_G
    );
  Cpu16_I3_n0147_14_19 : X_LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_1_1,
      ADR1 => Cpu16_I2_TD_c_2_1,
      ADR2 => Cpu16_I3_n0090(14),
      ADR3 => Cpu16_I2_TD_c_0_1,
      O => CHOICE827_G
    );
  Cpu16_I3_Ker173871 : X_LUT4
    generic map(
      INIT => X"8484"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_2_3,
      ADR1 => Cpu16_I2_TD_c_0_3,
      ADR2 => Cpu16_I2_TD_c(1),
      ADR3 => VCC,
      O => Cpu16_I3_N17389_F
    );
  Cpu16_I3_n0147_7_19 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => Cpu16_I3_n0090(7),
      ADR1 => Cpu16_I2_TD_c_0_1,
      ADR2 => Cpu16_I2_TD_c_2_1,
      ADR3 => Cpu16_I2_TD_c_1_1,
      O => CHOICE1078_F
    );
  Cpu16_I3_n0147_14_81 : X_LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_0_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I3_acc_i_0_14,
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => CHOICE1145_G
    );
  Cpu16_I3_n0147_8_81 : X_LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_0_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I3_acc_i_0_8,
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => CHOICE1145_F
    );
  Cpu16_I3_n0147_14_90 : X_LUT4
    generic map(
      INIT => X"F222"
    )
    port map (
      ADR0 => Cpu16_I3_n0084,
      ADR1 => Cpu16_I3_acc_c_0_14,
      ADR2 => Cpu16_I3_N17006,
      ADR3 => Cpu16_I3_acc_c_0_15,
      O => CHOICE1516_G
    );
  Cpu16_I3_n0147_14_106 : X_LUT4
    generic map(
      INIT => X"FAF8"
    )
    port map (
      ADR0 => Cpu16_I3_N17531,
      ADR1 => CHOICE1509,
      ADR2 => CHOICE1508,
      ADR3 => CHOICE1513,
      O => CHOICE1516_F
    );
  Cpu16_I3_n0147_14_82 : X_LUT4
    generic map(
      INIT => X"0088"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_13,
      ADR1 => Cpu16_I2_TD_c(0),
      ADR2 => VCC,
      ADR3 => Cpu16_I2_TD_c(2),
      O => CHOICE871_G
    );
  Cpu16_I3_Mmux_data_x_Result_7_114_SW2 : X_LUT4
    generic map(
      INIT => X"84C4"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_2_2,
      ADR1 => Cpu16_I2_TD_c_1_2,
      ADR2 => Cpu16_I2_TD_c_0_2,
      ADR3 => Cpu16_I3_acc_c_0_7,
      O => N31307_F
    );
  Cpu16_I3_n00841 : X_LUT4
    generic map(
      INIT => X"8080"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c(2),
      ADR1 => Cpu16_I2_TD_c(0),
      ADR2 => Cpu16_I2_TD_c(1),
      ADR3 => VCC,
      O => CHOICE1646_G
    );
  Cpu16_I3_n0147_15_82 : X_LUT4
    generic map(
      INIT => X"1200"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c(2),
      ADR1 => Cpu16_I2_TD_c(0),
      ADR2 => Cpu16_I2_TD_c(1),
      ADR3 => Cpu16_I3_acc_c_0_16,
      O => CHOICE1646_F
    );
  Cpu16_I3_Mmux_data_x_Result_7_37 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => Cpu16_daddr_is(0),
      ADR1 => Cpu16_I2_Mmux_idata_x_Result_6_1_1,
      ADR2 => Cpu16_I4_iinc_c(7),
      ADR3 => Cpu16_daddr_is(1),
      O => CHOICE1116_F
    );
  Cpu16_I3_n0147_12_72_SW0 : X_LUT4
    generic map(
      INIT => X"F080"
    )
    port map (
      ADR0 => CHOICE1351,
      ADR1 => N30734,
      ADR2 => Cpu16_I3_n0023,
      ADR3 => CHOICE1373,
      O => N30317_F
    );
  XLXI_5_cpu_daddr_c_8 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_cpu_daddr_c_9_DYMUX,
      CE => XLXI_5_cpu_daddr_c_9_CEINV,
      CLK => XLXI_5_cpu_daddr_c_9_CLKINV,
      SET => GND,
      RST => XLXI_5_cpu_daddr_c_9_FFY_RST,
      O => XLXI_5_cpu_daddr_c(8)
    );
  XLXI_5_cpu_daddr_c_9_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_cpu_daddr_c_9_SRINVNOT,
      I1 => GSR,
      O => XLXI_5_cpu_daddr_c_9_FFY_RST
    );
  Cpu16_I4_daddr_x_9_1 : X_LUT4
    generic map(
      INIT => X"88C0"
    )
    port map (
      ADR0 => Cpu16_daddr_is(9),
      ADR1 => Cpu16_I4_n0162,
      ADR2 => Cpu16_I4_ireg_c(9),
      ADR3 => Cpu16_I4_N18033,
      O => XLXI_5_cpu_daddr_c_9_F
    );
  Cpu16_I3_n0147_15_13_SW0 : X_LUT4
    generic map(
      INIT => X"CFCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => CHOICE1653,
      ADR2 => Cpu16_I2_TD_c(3),
      ADR3 => Cpu16_I3_n0100,
      O => N30635_F
    );
  XLXI_5_cpu_daddr_c_9 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_cpu_daddr_c_9_DXMUX,
      CE => XLXI_5_cpu_daddr_c_9_CEINV,
      CLK => XLXI_5_cpu_daddr_c_9_CLKINV,
      SET => GND,
      RST => XLXI_5_cpu_daddr_c_9_FFX_RST,
      O => XLXI_5_cpu_daddr_c(9)
    );
  XLXI_5_cpu_daddr_c_9_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_cpu_daddr_c_9_SRINVNOT,
      I1 => GSR,
      O => XLXI_5_cpu_daddr_c_9_FFX_RST
    );
  Cpu16_I3_skip_l86 : X_LUT4
    generic map(
      INIT => X"CC40"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_0_1,
      ADR1 => CHOICE1587,
      ADR2 => CHOICE1577,
      ADR3 => CHOICE1584,
      O => Cpu16_I3_skip_i_G
    );
  Cpu16_I3_skip_l123 : X_LUT4
    generic map(
      INIT => X"AA80"
    )
    port map (
      ADR0 => CHOICE1593,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I3_skip_i,
      ADR3 => CHOICE1588,
      O => Cpu16_I3_skip_l
    );
  Cpu16_I3_skip_i_1155 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_skip_i_DXMUX,
      CE => Cpu16_I3_skip_i_CEINV,
      CLK => Cpu16_I3_skip_i_CLKINV,
      SET => GND,
      RST => Cpu16_I3_skip_i_FFX_RST,
      O => Cpu16_I3_skip_i
    );
  Cpu16_I3_skip_i_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_skip_i_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_skip_i_FFX_RST
    );
  Cpu16_I4_nreset_v_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_nreset_v_1_DYMUX,
      CE => Cpu16_I4_nreset_v_1_CEINV,
      CLK => Cpu16_I4_nreset_v_1_CLKINV,
      SET => GND,
      RST => Cpu16_I4_nreset_v_1_FFY_RST,
      O => Cpu16_I4_nreset_v(1)
    );
  Cpu16_I4_nreset_v_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I4_nreset_v_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I4_nreset_v_1_FFY_RST
    );
  Cpu16_I3_Mmux_data_x_Result_13_SW0 : X_LUT4
    generic map(
      INIT => X"757F"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => DATA_IN_EXT_13_IBUF,
      ADR2 => XLXI_2_mux_c(0),
      ADR3 => MEM_DATA_OUT(13),
      O => N24841_F
    );
  Cpu16_I3_Mmux_data_x_Result_12_SW2 : X_LUT4
    generic map(
      INIT => X"F03C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => Cpu16_I3_acc_c_0_12,
      ADR3 => Cpu16_data_is_int(12),
      O => N30802_G
    );
  Cpu16_I3_Mmux_data_x_Result_12_SW4 : X_LUT4
    generic map(
      INIT => X"F03C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => Cpu16_I3_acc_c_0_12,
      ADR3 => Cpu16_data_is_int(12),
      O => N30802_F
    );
  Cpu16_I3_Mmux_data_x_Result_12_SW3 : X_LUT4
    generic map(
      INIT => X"9595"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_12,
      ADR1 => Cpu16_data_is_int(12),
      ADR2 => Cpu16_I3_n0025,
      ADR3 => VCC,
      O => CHOICE1346_G
    );
  Cpu16_I3_n0147_12_0 : X_LUT4
    generic map(
      INIT => X"A0A0"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_12,
      ADR1 => VCC,
      ADR2 => Cpu16_I3_N17152,
      ADR3 => VCC,
      O => CHOICE1346_F
    );
  Cpu16_I3_n0147_2_13_SW0 : X_LUT4
    generic map(
      INIT => X"F0FC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => CHOICE847,
      ADR3 => Cpu16_I2_TD_c(3),
      O => N30641_G
    );
  Cpu16_I2_n01011_SW2 : X_LUT4
    generic map(
      INIT => X"AFBF"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(3),
      ADR1 => Cpu16_I2_idata_c(2),
      ADR2 => Cpu16_I2_N15717,
      ADR3 => Cpu16_I2_idata_c(1),
      O => N31191_G
    );
  Cpu16_I2_ndre_x1_SW1_SW0_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"A080"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => Cpu16_I2_idata_c(2),
      ADR2 => Cpu16_I4_nreset_v(1),
      ADR3 => Cpu16_I2_idata_c(1),
      O => N31191_F
    );
  Cpu16_I2_E_c_FFd1_In_SW0 : X_LUT4
    generic map(
      INIT => X"BFBF"
    )
    port map (
      ADR0 => Cpu16_I2_int_stop_c,
      ADR1 => CPU_INT_IBUF,
      ADR2 => Cpu16_I2_S_c(1),
      ADR3 => VCC,
      O => N31584_G
    );
  Cpu16_I3_n0147_11_72_SW0 : X_LUT4
    generic map(
      INIT => X"C888"
    )
    port map (
      ADR0 => CHOICE1318,
      ADR1 => Cpu16_I3_n0023,
      ADR2 => N30702,
      ADR3 => CHOICE1296,
      O => N30323_F
    );
  Cpu16_I2_valid_x_SW0 : X_LUT4
    generic map(
      INIT => X"ECCC"
    )
    port map (
      ADR0 => XLXI_3_a2vi_s(0),
      ADR1 => Cpu16_I2_Mmux_skip_x_Result1_1,
      ADR2 => Cpu16_I2_N15561,
      ADR3 => Cpu16_I2_nreset_v_1_1,
      O => Cpu16_I2_valid_c_G
    );
  Cpu16_I2_valid_x_1156 : X_LUT4
    generic map(
      INIT => X"CC04"
    )
    port map (
      ADR0 => N20348,
      ADR1 => Cpu16_I2_nreset_v_1_1,
      ADR2 => Cpu16_I2_C_raw,
      ADR3 => Cpu16_I2_n0062,
      O => Cpu16_I2_valid_x
    );
  Cpu16_I2_valid_c_1157 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_valid_c_DXMUX,
      CE => VCC,
      CLK => Cpu16_I2_valid_c_CLKINV,
      SET => GND,
      RST => Cpu16_I2_valid_c_FFX_RST,
      O => Cpu16_I2_valid_c
    );
  Cpu16_I2_valid_c_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_valid_c_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_valid_c_FFX_RST
    );
  Cpu16_I3_nreset_v_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_nreset_v_1_DYMUX,
      CE => Cpu16_I3_nreset_v_1_CEINV,
      CLK => Cpu16_I3_nreset_v_1_CLKINV,
      SET => GND,
      RST => Cpu16_I3_nreset_v_1_FFY_RST,
      O => Cpu16_I3_nreset_v(1)
    );
  Cpu16_I3_nreset_v_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_nreset_v_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_nreset_v_1_FFY_RST
    );
  Cpu16_I2_ndre_x1_SW12_SW0_SW1 : X_LUT4
    generic map(
      INIT => X"CDFF"
    )
    port map (
      ADR0 => MEM_DATA_OUT(2),
      ADR1 => MEM_DATA_OUT(3),
      ADR2 => MEM_DATA_OUT(1),
      ADR3 => Cpu16_I2_N15717,
      O => N30558_G
    );
  Cpu16_I3_Mmux_data_x_Result_12_SW0 : X_LUT4
    generic map(
      INIT => X"53FF"
    )
    port map (
      ADR0 => DATA_IN_EXT_12_IBUF,
      ADR1 => MEM_DATA_OUT(12),
      ADR2 => XLXI_2_mux_c(0),
      ADR3 => NRESET_IN_BUFGP,
      O => N24841_G
    );
  Cpu16_I2_n01011_SW1 : X_LUT4
    generic map(
      INIT => X"E2FF"
    )
    port map (
      ADR0 => Cpu16_I2_idata_c(3),
      ADR1 => Cpu16_I2_n0150,
      ADR2 => MEM_DATA_OUT(3),
      ADR3 => Cpu16_I2_N15717,
      O => N30558_F
    );
  Cpu16_I3_Mmux_data_x_Result_5_114_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FDFF"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_0_1,
      ADR2 => Cpu16_I2_TC_c_2_1,
      ADR3 => Cpu16_I2_data_is_c(5),
      O => N30818_G
    );
  Cpu16_I3_Mmux_data_x_Result_5_114_SW0 : X_LUT4
    generic map(
      INIT => X"C84C"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_2_3,
      ADR1 => Cpu16_I2_TD_c_0_3,
      ADR2 => N31822,
      ADR3 => Cpu16_I2_TD_c_1_2,
      O => N30818_F
    );
  Cpu16_I3_n0147_11_39_SW0 : X_LUT4
    generic map(
      INIT => X"E4CC"
    )
    port map (
      ADR0 => Cpu16_I3_n0098(11),
      ADR1 => N31954,
      ADR2 => N30325,
      ADR3 => Cpu16_I3_n0083,
      O => Cpu16_I3_acc_c_0_11_G
    );
  Cpu16_I3_n0147_13_39_SW0 : X_LUT4
    generic map(
      INIT => X"D8F0"
    )
    port map (
      ADR0 => Cpu16_I3_n0083,
      ADR1 => N30313,
      ADR2 => N31972,
      ADR3 => Cpu16_I3_n0098(13),
      O => Cpu16_I3_acc_c_0_13_G
    );
  Cpu16_I3_acc_c_0_10_1158 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_11_DYMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_11_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_11_FFY_RST,
      O => Cpu16_I3_acc_c_0_10
    );
  Cpu16_I3_acc_c_0_11_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_11_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_11_FFY_RST
    );
  Cpu16_I3_n0147_11_139 : X_LUT4
    generic map(
      INIT => X"FCEE"
    )
    port map (
      ADR0 => Cpu16_I3_n0147_11_39_SW0_O,
      ADR1 => CHOICE1291,
      ADR2 => N30325,
      ADR3 => CHOICE1298,
      O => Cpu16_I3_acc_c_0_11_F
    );
  Cpu16_I3_acc_c_0_11_1159 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_11_DXMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_11_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_11_FFX_RST,
      O => Cpu16_I3_acc_c_0_11
    );
  Cpu16_I3_acc_c_0_11_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_11_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_11_FFX_RST
    );
  Cpu16_I3_acc_c_0_12_1160 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_13_DYMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_13_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_13_FFY_RST,
      O => Cpu16_I3_acc_c_0_12
    );
  Cpu16_I3_acc_c_0_13_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_13_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_13_FFY_RST
    );
  Cpu16_I3_n0147_13_139 : X_LUT4
    generic map(
      INIT => X"FFD8"
    )
    port map (
      ADR0 => CHOICE1441,
      ADR1 => N30313,
      ADR2 => Cpu16_I3_n0147_13_39_SW0_O,
      ADR3 => CHOICE1434,
      O => Cpu16_I3_acc_c_0_13_F
    );
  Cpu16_I3_acc_c_0_14_1161 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_15_DYMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_15_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_15_FFY_RST,
      O => Cpu16_I3_acc_c_0_14
    );
  Cpu16_I3_acc_c_0_15_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_15_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_15_FFY_RST
    );
  Cpu16_I3_acc_c_0_13_1162 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_13_DXMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_13_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_13_FFX_RST,
      O => Cpu16_I3_acc_c_0_13
    );
  Cpu16_I3_acc_c_0_13_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_13_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_13_FFX_RST
    );
  Cpu16_I2_n0073_1_34 : X_LUT4
    generic map(
      INIT => X"ECFF"
    )
    port map (
      ADR0 => Cpu16_I2_C_rti,
      ADR1 => CHOICE17,
      ADR2 => CHOICE24,
      ADR3 => Cpu16_I2_nreset_v_1_1,
      O => Cpu16_I2_n0073(1)
    );
  Cpu16_I2_S_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_S_c_1_DXMUX,
      CE => VCC,
      CLK => Cpu16_I2_S_c_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_S_c_1_FFX_RST,
      O => Cpu16_I2_S_c(1)
    );
  Cpu16_I2_S_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_S_c_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_S_c_1_FFX_RST
    );
  Cpu16_I3_Mmux_data_x_Result_6_114_SW0 : X_LUT4
    generic map(
      INIT => X"C48C"
    )
    port map (
      ADR0 => N31834,
      ADR1 => Cpu16_I2_TD_c_0_3,
      ADR2 => Cpu16_I2_TD_c_1_2,
      ADR3 => Cpu16_I2_TD_c_2_3,
      O => N30836_F
    );
  XLXI_5_cpu_daddr_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_cpu_daddr_c_1_DYMUX,
      CE => XLXI_5_cpu_daddr_c_1_CEINV,
      CLK => XLXI_5_cpu_daddr_c_1_CLKINV,
      SET => GND,
      RST => XLXI_5_cpu_daddr_c_1_FFY_RST,
      O => XLXI_5_cpu_daddr_c(0)
    );
  XLXI_5_cpu_daddr_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_cpu_daddr_c_1_SRINVNOT,
      I1 => GSR,
      O => XLXI_5_cpu_daddr_c_1_FFY_RST
    );
  XLXI_5_cpu_daddr_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_cpu_daddr_c_1_DXMUX,
      CE => XLXI_5_cpu_daddr_c_1_CEINV,
      CLK => XLXI_5_cpu_daddr_c_1_CLKINV,
      SET => GND,
      RST => XLXI_5_cpu_daddr_c_1_FFX_RST,
      O => XLXI_5_cpu_daddr_c(1)
    );
  XLXI_5_cpu_daddr_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_cpu_daddr_c_1_SRINVNOT,
      I1 => GSR,
      O => XLXI_5_cpu_daddr_c_1_FFX_RST
    );
  Cpu16_I3_Mmux_data_x_Result_14_SW2 : X_LUT4
    generic map(
      INIT => X"A6A6"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_14,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => Cpu16_data_is_int(14),
      ADR3 => VCC,
      O => N30494_F
    );
  XLXI_5_cpu_daddr_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_cpu_daddr_c_3_DYMUX,
      CE => XLXI_5_cpu_daddr_c_3_CEINV,
      CLK => XLXI_5_cpu_daddr_c_3_CLKINV,
      SET => GND,
      RST => XLXI_5_cpu_daddr_c_3_FFY_RST,
      O => XLXI_5_cpu_daddr_c(2)
    );
  XLXI_5_cpu_daddr_c_3_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_cpu_daddr_c_3_SRINVNOT,
      I1 => GSR,
      O => XLXI_5_cpu_daddr_c_3_FFY_RST
    );
  Cpu16_I3_n0147_9_13_SW1 : X_LUT4
    generic map(
      INIT => X"EAEE"
    )
    port map (
      ADR0 => CHOICE1208,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => Cpu16_I3_acc_c_0_9,
      ADR3 => Cpu16_I2_TD_c_3_1,
      O => N30619_F
    );
  Cpu16_I3_Mmux_data_x_Result_4_114_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_0_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I2_data_is_c(4),
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => N30824_G
    );
  Cpu16_I3_n0147_9_72_SW0 : X_LUT4
    generic map(
      INIT => X"EA00"
    )
    port map (
      ADR0 => CHOICE1208,
      ADR1 => N30710,
      ADR2 => CHOICE1186,
      ADR3 => Cpu16_I3_n0023,
      O => N30335_F
    );
  Cpu16_I3_Mmux_data_x_Result_4_114_SW0 : X_LUT4
    generic map(
      INIT => X"B0D0"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_1_2,
      ADR1 => N31826,
      ADR2 => Cpu16_I2_TD_c_0_3,
      ADR3 => Cpu16_I2_TD_c_2_3,
      O => N30824_F
    );
  Cpu16_I2_nreset_v_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_nreset_v_1_DYMUX,
      CE => Cpu16_I2_nreset_v_1_CEINV,
      CLK => Cpu16_I2_nreset_v_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_nreset_v_1_FFY_RST,
      O => Cpu16_I2_nreset_v(1)
    );
  Cpu16_I2_nreset_v_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_nreset_v_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_nreset_v_1_FFY_RST
    );
  Cpu16_I3_Mmux_data_x_Result_10_114_SW2 : X_LUT4
    generic map(
      INIT => X"C070"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_10,
      ADR1 => Cpu16_I2_TD_c_0_2,
      ADR2 => Cpu16_I2_TD_c_1_2,
      ADR3 => Cpu16_I2_TD_c_2_2,
      O => N31319_G
    );
  Cpu16_I3_Mmux_data_x_Result_3_114_SW2 : X_LUT4
    generic map(
      INIT => X"C070"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_3,
      ADR1 => Cpu16_I2_TD_c_0_2,
      ADR2 => Cpu16_I2_TD_c_1_2,
      ADR3 => Cpu16_I2_TD_c_2_2,
      O => N31319_F
    );
  Cpu16_I3_n0147_11_13_SW2 : X_LUT4
    generic map(
      INIT => X"1200"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I2_TC_c_0_1,
      ADR3 => Cpu16_I3_acc_c_0_11,
      O => N30323_G
    );
  Cpu16_I3_n0147_11_13_SW0 : X_LUT4
    generic map(
      INIT => X"FF0C"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => Cpu16_I2_TD_c(3),
      ADR3 => CHOICE1318,
      O => N30601_G
    );
  Cpu16_I3_n0147_11_13_SW1 : X_LUT4
    generic map(
      INIT => X"FF8C"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_11,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => Cpu16_I2_TD_c(3),
      ADR3 => CHOICE1318,
      O => N30601_F
    );
  XLXI_5_cpu_daddr_c_3 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_cpu_daddr_c_3_DXMUX,
      CE => XLXI_5_cpu_daddr_c_3_CEINV,
      CLK => XLXI_5_cpu_daddr_c_3_CLKINV,
      SET => GND,
      RST => XLXI_5_cpu_daddr_c_3_FFX_RST,
      O => XLXI_5_cpu_daddr_c(3)
    );
  XLXI_5_cpu_daddr_c_3_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_cpu_daddr_c_3_SRINVNOT,
      I1 => GSR,
      O => XLXI_5_cpu_daddr_c_3_FFX_RST
    );
  Cpu16_I3_n0147_12_13_SW2 : X_LUT4
    generic map(
      INIT => X"0208"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_12,
      ADR1 => Cpu16_I2_TC_c_0_1,
      ADR2 => Cpu16_I2_TC_c_2_1,
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => N30317_G
    );
  XLXI_5_cpu_daddr_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_cpu_daddr_c_5_DYMUX,
      CE => XLXI_5_cpu_daddr_c_5_CEINV,
      CLK => XLXI_5_cpu_daddr_c_5_CLKINV,
      SET => GND,
      RST => XLXI_5_cpu_daddr_c_5_FFY_RST,
      O => XLXI_5_cpu_daddr_c(4)
    );
  XLXI_5_cpu_daddr_c_5_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_cpu_daddr_c_5_SRINVNOT,
      I1 => GSR,
      O => XLXI_5_cpu_daddr_c_5_FFY_RST
    );
  XLXI_5_cpu_daddr_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_cpu_daddr_c_5_DXMUX,
      CE => XLXI_5_cpu_daddr_c_5_CEINV,
      CLK => XLXI_5_cpu_daddr_c_5_CLKINV,
      SET => GND,
      RST => XLXI_5_cpu_daddr_c_5_FFX_RST,
      O => XLXI_5_cpu_daddr_c(5)
    );
  XLXI_5_cpu_daddr_c_5_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_cpu_daddr_c_5_SRINVNOT,
      I1 => GSR,
      O => XLXI_5_cpu_daddr_c_5_FFX_RST
    );
  XLXI_5_cpu_daddr_c_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_cpu_daddr_c_7_DYMUX,
      CE => XLXI_5_cpu_daddr_c_7_CEINV,
      CLK => XLXI_5_cpu_daddr_c_7_CLKINV,
      SET => GND,
      RST => XLXI_5_cpu_daddr_c_7_FFY_RST,
      O => XLXI_5_cpu_daddr_c(6)
    );
  XLXI_5_cpu_daddr_c_7_FFY_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_cpu_daddr_c_7_SRINVNOT,
      I1 => GSR,
      O => XLXI_5_cpu_daddr_c_7_FFY_RST
    );
  XLXI_5_cpu_daddr_c_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_5_cpu_daddr_c_7_DXMUX,
      CE => XLXI_5_cpu_daddr_c_7_CEINV,
      CLK => XLXI_5_cpu_daddr_c_7_CLKINV,
      SET => GND,
      RST => XLXI_5_cpu_daddr_c_7_FFX_RST,
      O => XLXI_5_cpu_daddr_c(7)
    );
  XLXI_5_cpu_daddr_c_7_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_5_cpu_daddr_c_7_SRINVNOT,
      I1 => GSR,
      O => XLXI_5_cpu_daddr_c_7_FFX_RST
    );
  Cpu16_I4_Ker180311 : X_LUT4
    generic map(
      INIT => X"FFFB"
    )
    port map (
      ADR0 => Cpu16_I2_Mmux_idata_x_Result_4_1_1,
      ADR1 => Cpu16_I4_n0202,
      ADR2 => Cpu16_I2_Mmux_idata_x_Result_6_1_1,
      ADR3 => Cpu16_daddr_is(1),
      O => XLXI_5_cpu_daddr_c_9_G
    );
  Cpu16_I3_n0147_12_13_SW1 : X_LUT4
    generic map(
      INIT => X"EEAE"
    )
    port map (
      ADR0 => CHOICE1373,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => Cpu16_I2_TD_c(3),
      ADR3 => Cpu16_I3_acc_c_0_12,
      O => N30635_G
    );
  Cpu16_I3_n0147_12_13_SW0 : X_LUT4
    generic map(
      INIT => X"F0FC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => CHOICE1373,
      ADR3 => Cpu16_I2_TD_c(3),
      O => N30641_F
    );
  Cpu16_I3_n0147_2_13_SW1 : X_LUT4
    generic map(
      INIT => X"FFD0"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_3_1,
      ADR1 => Cpu16_I3_acc_c_0_2,
      ADR2 => Cpu16_I3_n0100,
      ADR3 => CHOICE847,
      O => N30659_G
    );
  Cpu16_I2_E_c_FFd4_In31_SW0 : X_LUT4
    generic map(
      INIT => X"DCCC"
    )
    port map (
      ADR0 => Cpu16_I2_int_stop_c,
      ADR1 => XLXI_3_a2vi_s(0),
      ADR2 => Cpu16_I2_S_c(1),
      ADR3 => CPU_INT_IBUF,
      O => N31584_F
    );
  Cpu16_I3_n0147_2_13_SW2 : X_LUT4
    generic map(
      INIT => X"1020"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I3_acc_c_0_2,
      ADR3 => Cpu16_I2_TC_c_0_1,
      O => N30377_G
    );
  Cpu16_I3_n0147_5_13_SW0 : X_LUT4
    generic map(
      INIT => X"F4F4"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_3_1,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => CHOICE988,
      ADR3 => VCC,
      O => N30659_F
    );
  Cpu16_I3_Mmux_data_x_Result_13_SW2 : X_LUT4
    generic map(
      INIT => X"AA66"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_13,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => VCC,
      ADR3 => Cpu16_data_is_int(13),
      O => N30806_G
    );
  Cpu16_I3_n0147_2_72_SW0 : X_LUT4
    generic map(
      INIT => X"EA00"
    )
    port map (
      ADR0 => CHOICE847,
      ADR1 => CHOICE825,
      ADR2 => N31039,
      ADR3 => Cpu16_I3_n0023,
      O => N30377_F
    );
  Cpu16_I3_Mmux_data_x_Result_13_SW3 : X_LUT4
    generic map(
      INIT => X"9955"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_13,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => VCC,
      ADR3 => Cpu16_data_is_int(13),
      O => N30806_F
    );
  Cpu16_I2_n0073_1_25 : X_LUT4
    generic map(
      INIT => X"0011"
    )
    port map (
      ADR0 => Cpu16_I2_n0166(2),
      ADR1 => Cpu16_I2_n0063,
      ADR2 => VCC,
      ADR3 => Cpu16_I2_n0062,
      O => Cpu16_I2_S_c_1_G
    );
  Cpu16_I3_Mmux_data_x_Result_7_114_SW0 : X_LUT4
    generic map(
      INIT => X"C48C"
    )
    port map (
      ADR0 => N31846,
      ADR1 => Cpu16_I2_TD_c_0_2,
      ADR2 => Cpu16_I2_TD_c_1_2,
      ADR3 => Cpu16_I2_TD_c_2_2,
      O => N30854_F
    );
  Cpu16_I3_n0147_10_0 : X_LUT4
    generic map(
      INIT => X"F000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => Cpu16_I3_N17152,
      ADR3 => Cpu16_I3_acc_c_0_10,
      O => CHOICE1071_G
    );
  Cpu16_I3_Mmux_data_x_Result_10_114_SW0 : X_LUT4
    generic map(
      INIT => X"C84C"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_2_3,
      ADR1 => Cpu16_I2_TD_c_0_3,
      ADR2 => N31858,
      ADR3 => Cpu16_I2_TD_c(1),
      O => N30872_F
    );
  Cpu16_I3_n0147_7_0 : X_LUT4
    generic map(
      INIT => X"A0A0"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_7,
      ADR1 => VCC,
      ADR2 => Cpu16_I3_N17152,
      ADR3 => VCC,
      O => CHOICE1071_F
    );
  Cpu16_I3_n0147_11_0 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_11,
      ADR1 => Cpu16_I3_N17152,
      ADR2 => VCC,
      ADR3 => VCC,
      O => CHOICE789_G
    );
  Cpu16_I3_n0147_1_0 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_N17152,
      ADR2 => VCC,
      ADR3 => Cpu16_I3_acc_c_0_1,
      O => CHOICE789_F
    );
  Cpu16_I3_Mmux_data_x_Result_0_85_SW1 : X_LUT4
    generic map(
      INIT => X"AA5A"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_0,
      ADR1 => VCC,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => CHOICE1520,
      O => Cpu16_I3_data_x_0_G
    );
  Cpu16_I4_n02151 : X_LUT4
    generic map(
      INIT => X"FBFB"
    )
    port map (
      ADR0 => Cpu16_int_stop,
      ADR1 => Cpu16_I4_nreset_v(1),
      ADR2 => Cpu16_I4_iinc_we_c,
      ADR3 => VCC,
      O => Cpu16_I4_n0215_G
    );
  Cpu16_I3_n0147_13_0 : X_LUT4
    generic map(
      INIT => X"C0C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_N17152,
      ADR2 => Cpu16_I3_acc_c_0_13,
      ADR3 => VCC,
      O => CHOICE1489_G
    );
  Cpu16_I3_Mmux_data_x_Result_0_114 : X_LUT4
    generic map(
      INIT => X"FF0A"
    )
    port map (
      ADR0 => CHOICE1540,
      ADR1 => VCC,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => CHOICE1520,
      O => Cpu16_I3_data_x_0_F
    );
  Cpu16_I3_n0147_3_19 : X_LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      ADR0 => Cpu16_I3_n0090(3),
      ADR1 => Cpu16_I2_TD_c_2_1,
      ADR2 => Cpu16_I2_TD_c_0_1,
      ADR3 => Cpu16_I2_TD_c_1_1,
      O => CHOICE968_G
    );
  Cpu16_I3_n0147_2_106 : X_LUT4
    generic map(
      INIT => X"EEEC"
    )
    port map (
      ADR0 => Cpu16_I3_N17531,
      ADR1 => CHOICE839,
      ADR2 => CHOICE840,
      ADR3 => CHOICE844,
      O => CHOICE847_F
    );
  Cpu16_I3_n0147_5_19 : X_LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_1_1,
      ADR1 => Cpu16_I2_TD_c_2_1,
      ADR2 => Cpu16_I2_TD_c_0_1,
      ADR3 => Cpu16_I3_n0090(5),
      O => CHOICE968_F
    );
  Cpu16_I3_n0147_3_29 : X_LUT4
    generic map(
      INIT => X"8C80"
    )
    port map (
      ADR0 => Cpu16_I2_data_is_c(3),
      ADR1 => N31319,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => CHOICE1342,
      O => CHOICE1027_G
    );
  Cpu16_I3_n0147_6_29 : X_LUT4
    generic map(
      INIT => X"AC00"
    )
    port map (
      ADR0 => Cpu16_I2_data_is_c(6),
      ADR1 => CHOICE1177,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => N31323,
      O => CHOICE1027_F
    );
  Cpu16_I3_n0147_3_90 : X_LUT4
    generic map(
      INIT => X"F222"
    )
    port map (
      ADR0 => Cpu16_I3_n0084,
      ADR1 => Cpu16_I3_acc_c_0_3,
      ADR2 => Cpu16_I3_N17006,
      ADR3 => Cpu16_I3_acc_c_0_4,
      O => CHOICE878_G
    );
  Cpu16_I3_Mmux_data_x_Result_11_114_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FDFF"
    )
    port map (
      ADR0 => Cpu16_I2_data_is_c(11),
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I2_TC_c_0_1,
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => N30878_G
    );
  XLXI_5_ndre_out1 : X_LUT4
    generic map(
      INIT => X"FF0F"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => NRESET_IN_BUFGP,
      ADR3 => XLXI_5_ndre_c,
      O => NRE_EXT_OBUF_G
    );
  Cpu16_I3_Mmux_data_x_Result_11_114_SW0 : X_LUT4
    generic map(
      INIT => X"D0B0"
    )
    port map (
      ADR0 => N31862,
      ADR1 => Cpu16_I2_TD_c(1),
      ADR2 => Cpu16_I2_TD_c_0_3,
      ADR3 => Cpu16_I2_TD_c_2_3,
      O => N30878_F
    );
  Cpu16_I3_n0147_4_90 : X_LUT4
    generic map(
      INIT => X"F444"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_4,
      ADR1 => Cpu16_I3_n0084,
      ADR2 => Cpu16_I3_acc_c_0_5,
      ADR3 => Cpu16_I3_N17006,
      O => CHOICE933_G
    );
  Cpu16_I3_n0147_4_29 : X_LUT4
    generic map(
      INIT => X"AC00"
    )
    port map (
      ADR0 => Cpu16_I2_data_is_c(4),
      ADR1 => CHOICE1287,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => N31311,
      O => CHOICE972_G
    );
  Cpu16_I3_n0147_3_106 : X_LUT4
    generic map(
      INIT => X"FFA8"
    )
    port map (
      ADR0 => Cpu16_I3_N17531,
      ADR1 => CHOICE871,
      ADR2 => CHOICE875,
      ADR3 => CHOICE870,
      O => CHOICE878_F
    );
  Cpu16_I3_n0147_3_72_SW0 : X_LUT4
    generic map(
      INIT => X"C888"
    )
    port map (
      ADR0 => CHOICE878,
      ADR1 => Cpu16_I3_n0023,
      ADR2 => CHOICE856,
      ADR3 => N31031,
      O => N30371_F
    );
  Cpu16_I3_n0147_16_5 : X_LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      ADR0 => CHOICE1379,
      ADR1 => Cpu16_I2_TC_c_0_1,
      ADR2 => Cpu16_I2_TC_c_2_1,
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => CHOICE1380_F
    );
  Cpu16_I2_TD_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TD_c_1_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_TD_c_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TD_c_1_FFY_RST,
      O => Cpu16_I2_TD_c(0)
    );
  Cpu16_I2_TD_c_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TD_c_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TD_c_1_FFY_RST
    );
  Cpu16_I2_TD_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TD_c_1_DXMUX,
      CE => VCC,
      CLK => Cpu16_I2_TD_c_1_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TD_c_1_FFX_RST,
      O => Cpu16_I2_TD_c(1)
    );
  Cpu16_I2_TD_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TD_c_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TD_c_1_FFX_RST
    );
  Cpu16_I2_TD_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_TD_c_2_DYMUX,
      CE => VCC,
      CLK => Cpu16_I2_TD_c_2_CLKINV,
      SET => GND,
      RST => Cpu16_I2_TD_c_2_FFY_RST,
      O => Cpu16_I2_TD_c(2)
    );
  Cpu16_I2_TD_c_2_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_TD_c_2_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_TD_c_2_FFY_RST
    );
  Cpu16_I3_n0147_1_19 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => Cpu16_I3_n0090(1),
      ADR1 => Cpu16_I2_TD_c_0_1,
      ADR2 => Cpu16_I2_TD_c_2_1,
      ADR3 => Cpu16_I2_TD_c_1_1,
      O => CHOICE1023_G
    );
  Cpu16_I3_n0147_1_29 : X_LUT4
    generic map(
      INIT => X"88C0"
    )
    port map (
      ADR0 => Cpu16_I2_data_is_c(1),
      ADR1 => N31327,
      ADR2 => CHOICE1485,
      ADR3 => Cpu16_I3_n0025,
      O => CHOICE1137_G
    );
  Cpu16_I3_Mmux_data_x_Result_8_114_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_0_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I2_data_is_c(8),
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => N30860_G
    );
  Cpu16_I3_n0147_6_19 : X_LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      ADR0 => Cpu16_I3_n0090(6),
      ADR1 => Cpu16_I2_TD_c_0_1,
      ADR2 => Cpu16_I2_TD_c_2_1,
      ADR3 => Cpu16_I2_TD_c_1_1,
      O => CHOICE1023_F
    );
  Cpu16_I4_n01621 : X_LUT4
    generic map(
      INIT => X"A0A0"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => VCC,
      ADR2 => Cpu16_I4_nreset_v(1),
      ADR3 => VCC,
      O => Cpu16_I4_data_exp_i_2_G
    );
  Cpu16_I4_data_exp_x_2_1 : X_LUT4
    generic map(
      INIT => X"EC20"
    )
    port map (
      ADR0 => Cpu16_I4_data_exp_c(2),
      ADR1 => Cpu16_I4_dexp_we_c,
      ADR2 => Cpu16_I4_n0162,
      ADR3 => Cpu16_I3_acc_c_0_2,
      O => Cpu16_I4_data_exp_i_2_F
    );
  Cpu16_I4_data_exp_i_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I4_data_exp_i_2_DXMUX,
      CE => Cpu16_I4_data_exp_i_2_CEINV,
      CLK => Cpu16_I4_data_exp_i_2_CLKINV,
      SET => GND,
      RST => Cpu16_I4_data_exp_i_2_FFX_RST,
      O => Cpu16_I4_data_exp_i(2)
    );
  Cpu16_I4_data_exp_i_2_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I4_data_exp_i_2_FFX_RST
    );
  Cpu16_I3_n0147_14_0 : X_LUT4
    generic map(
      INIT => X"8888"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_14,
      ADR1 => Cpu16_I3_N17152,
      ADR2 => VCC,
      ADR3 => VCC,
      O => CHOICE1489_F
    );
  Cpu16_I3_n0147_15_0 : X_LUT4
    generic map(
      INIT => X"A0A0"
    )
    port map (
      ADR0 => Cpu16_I3_N17152,
      ADR1 => VCC,
      ADR2 => Cpu16_I3_acc_c_0_15,
      ADR3 => VCC,
      O => CHOICE1126_G
    );
  Cpu16_I4_n01571 : X_LUT4
    generic map(
      INIT => X"A0A0"
    )
    port map (
      ADR0 => NRESET_IN_BUFGP,
      ADR1 => VCC,
      ADR2 => Cpu16_I2_int_start_c,
      ADR3 => VCC,
      O => Cpu16_I4_n0157_G
    );
  Cpu16_I3_n0147_8_0 : X_LUT4
    generic map(
      INIT => X"A0A0"
    )
    port map (
      ADR0 => Cpu16_I3_N17152,
      ADR1 => VCC,
      ADR2 => Cpu16_I3_acc_c_0_8,
      ADR3 => VCC,
      O => CHOICE1126_F
    );
  Cpu16_I3_n0147_3_13_SW1 : X_LUT4
    generic map(
      INIT => X"F8FC"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_3,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => CHOICE878,
      ADR3 => Cpu16_I2_TD_c_3_1,
      O => N30653_G
    );
  Cpu16_I3_n0147_3_13_SW2 : X_LUT4
    generic map(
      INIT => X"0220"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_3,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I2_TC_c_1_1,
      ADR3 => Cpu16_I2_TC_c_0_1,
      O => N30371_G
    );
  Cpu16_I3_n0147_4_13_SW0 : X_LUT4
    generic map(
      INIT => X"AAFA"
    )
    port map (
      ADR0 => CHOICE933,
      ADR1 => VCC,
      ADR2 => Cpu16_I3_n0100,
      ADR3 => Cpu16_I2_TD_c_3_1,
      O => N30653_F
    );
  Cpu16_I3_n0147_5_29 : X_LUT4
    generic map(
      INIT => X"AC00"
    )
    port map (
      ADR0 => Cpu16_I2_data_is_c(5),
      ADR1 => CHOICE1232,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => N31315,
      O => CHOICE972_F
    );
  Cpu16_I3_n0147_4_106 : X_LUT4
    generic map(
      INIT => X"FFA8"
    )
    port map (
      ADR0 => Cpu16_I3_N17531,
      ADR1 => CHOICE926,
      ADR2 => CHOICE930,
      ADR3 => CHOICE925,
      O => CHOICE933_F
    );
  Cpu16_I3_n009612 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_2,
      ADR1 => Cpu16_I3_acc_c_0_3,
      ADR2 => Cpu16_I3_acc_c_0_0,
      ADR3 => Cpu16_I3_acc_c_0_1,
      O => CHOICE1601_F
    );
  Cpu16_I3_n0147_13_13_SW0 : X_LUT4
    generic map(
      INIT => X"F0FC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => CHOICE1461,
      ADR3 => Cpu16_I2_TD_c(3),
      O => N30631_G
    );
  Cpu16_I3_n0147_13_13_SW1 : X_LUT4
    generic map(
      INIT => X"F8FC"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_13,
      ADR1 => Cpu16_I3_n0100,
      ADR2 => CHOICE1461,
      ADR3 => Cpu16_I2_TD_c(3),
      O => N30631_F
    );
  Cpu16_I3_n0147_5_90 : X_LUT4
    generic map(
      INIT => X"CE0A"
    )
    port map (
      ADR0 => Cpu16_I3_n0084,
      ADR1 => Cpu16_I3_acc_c_0_6,
      ADR2 => Cpu16_I3_acc_c_0_5,
      ADR3 => Cpu16_I3_N17006,
      O => CHOICE988_G
    );
  Cpu16_I3_n0147_13_13_SW2 : X_LUT4
    generic map(
      INIT => X"1400"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_2_1,
      ADR1 => Cpu16_I2_TC_c_1_1,
      ADR2 => Cpu16_I2_TC_c_0_1,
      ADR3 => Cpu16_I3_acc_c_0_13,
      O => N30311_G
    );
  Cpu16_I3_n0147_5_106 : X_LUT4
    generic map(
      INIT => X"EEEA"
    )
    port map (
      ADR0 => CHOICE980,
      ADR1 => Cpu16_I3_N17531,
      ADR2 => CHOICE981,
      ADR3 => CHOICE985,
      O => CHOICE988_F
    );
  Cpu16_I3_n0147_13_72_SW0 : X_LUT4
    generic map(
      INIT => X"EC00"
    )
    port map (
      ADR0 => N30730,
      ADR1 => CHOICE1461,
      ADR2 => CHOICE1439,
      ADR3 => Cpu16_I3_n0023,
      O => N30311_F
    );
  Cpu16_I3_n0147_6_90 : X_LUT4
    generic map(
      INIT => X"BA30"
    )
    port map (
      ADR0 => Cpu16_I3_N17006,
      ADR1 => Cpu16_I3_acc_c_0_6,
      ADR2 => Cpu16_I3_n0084,
      ADR3 => Cpu16_I3_acc_c_0_7,
      O => CHOICE1043_G
    );
  XLXI_5_Mmux_cpu_daddr_out_Result_2_1 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_5_N12936,
      ADR1 => CPU_ADADDR_OUT(2),
      ADR2 => XLXI_5_N12957,
      ADR3 => XLXI_5_cpu_daddr_c(2),
      O => ADDR_OUT_EXT_7_OBUF_G
    );
  XLXI_5_Mmux_cpu_daddr_out_Result_5_1 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_5_N12936,
      ADR1 => XLXI_5_cpu_daddr_c(5),
      ADR2 => XLXI_5_N12957,
      ADR3 => CPU_ADADDR_OUT(5),
      O => ADDR_OUT_EXT_5_OBUF_F
    );
  XLXI_5_Mmux_cpu_daddr_out_Result_7_1 : X_LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      ADR0 => XLXI_5_N12936,
      ADR1 => CPU_ADADDR_OUT(7),
      ADR2 => XLXI_5_N12957,
      ADR3 => XLXI_5_cpu_daddr_c(7),
      O => ADDR_OUT_EXT_7_OBUF_F
    );
  Cpu16_I3_n0147_15_13_SW2 : X_LUT4
    generic map(
      INIT => X"0600"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_0_1,
      ADR2 => Cpu16_I2_TC_c_2_1,
      ADR3 => Cpu16_I3_acc_c_0_15,
      O => N30299_G
    );
  Cpu16_I3_n0147_15_72_SW0 : X_LUT4
    generic map(
      INIT => X"A8A0"
    )
    port map (
      ADR0 => Cpu16_I3_n0023,
      ADR1 => CHOICE1631,
      ADR2 => CHOICE1653,
      ADR3 => N30722,
      O => N30299_F
    );
  Cpu16_I2_idata_c_4 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_idata_c_5_DYMUX,
      CE => Cpu16_I2_idata_c_5_CEINV,
      CLK => Cpu16_I2_idata_c_5_CLKINV,
      SET => GND,
      RST => Cpu16_I2_idata_c_5_FFY_RST,
      O => Cpu16_I2_idata_c(4)
    );
  Cpu16_I2_idata_c_5_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_idata_c_5_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_idata_c_5_FFY_RST
    );
  Cpu16_I2_idata_c_5 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_idata_c_5_DXMUX,
      CE => Cpu16_I2_idata_c_5_CEINV,
      CLK => Cpu16_I2_idata_c_5_CLKINV,
      SET => GND,
      RST => Cpu16_I2_idata_c_5_FFX_RST,
      O => Cpu16_I2_idata_c(5)
    );
  Cpu16_I2_idata_c_5_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_idata_c_5_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_idata_c_5_FFX_RST
    );
  Cpu16_I2_idata_c_6 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_idata_c_7_DYMUX,
      CE => Cpu16_I2_idata_c_7_CEINV,
      CLK => Cpu16_I2_idata_c_7_CLKINV,
      SET => GND,
      RST => Cpu16_I2_idata_c_7_FFY_RST,
      O => Cpu16_I2_idata_c(6)
    );
  Cpu16_I2_idata_c_7_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_idata_c_7_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_idata_c_7_FFY_RST
    );
  Cpu16_I2_idata_c_7 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_idata_c_7_DXMUX,
      CE => Cpu16_I2_idata_c_7_CEINV,
      CLK => Cpu16_I2_idata_c_7_CLKINV,
      SET => GND,
      RST => Cpu16_I2_idata_c_7_FFX_RST,
      O => Cpu16_I2_idata_c(7)
    );
  Cpu16_I2_idata_c_7_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_idata_c_7_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_idata_c_7_FFX_RST
    );
  Cpu16_I3_Mmux_data_x_Result_10_114_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FDFF"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_0_1,
      ADR2 => Cpu16_I2_TC_c_2_1,
      ADR3 => Cpu16_I2_data_is_c(10),
      O => N30872_G
    );
  Cpu16_I2_idata_c_8 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_idata_c_9_DYMUX,
      CE => Cpu16_I2_idata_c_9_CEINV,
      CLK => Cpu16_I2_idata_c_9_CLKINV,
      SET => GND,
      RST => Cpu16_I2_idata_c_9_FFY_RST,
      O => Cpu16_I2_idata_c(8)
    );
  Cpu16_I2_idata_c_9_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_idata_c_9_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_idata_c_9_FFY_RST
    );
  Cpu16_I3_Mmux_data_x_Result_7_114_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FFDF"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_0_1,
      ADR2 => Cpu16_I2_data_is_c(7),
      ADR3 => Cpu16_I2_TC_c_2_1,
      O => N30854_G
    );
  Cpu16_I2_idata_c_9 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_idata_c_9_DXMUX,
      CE => Cpu16_I2_idata_c_9_CEINV,
      CLK => Cpu16_I2_idata_c_9_CLKINV,
      SET => GND,
      RST => Cpu16_I2_idata_c_9_FFX_RST,
      O => Cpu16_I2_idata_c(9)
    );
  Cpu16_I2_idata_c_9_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_idata_c_9_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_idata_c_9_FFX_RST
    );
  Cpu16_I3_n0147_8_29 : X_LUT4
    generic map(
      INIT => X"88C0"
    )
    port map (
      ADR0 => Cpu16_I2_data_is_c(8),
      ADR1 => N31335,
      ADR2 => CHOICE1067,
      ADR3 => Cpu16_I3_n0025,
      O => CHOICE1137_F
    );
  Cpu16_I3_n0147_1_90 : X_LUT4
    generic map(
      INIT => X"F222"
    )
    port map (
      ADR0 => Cpu16_I3_n0084,
      ADR1 => Cpu16_I3_acc_c_0_1,
      ADR2 => Cpu16_I3_N17006,
      ADR3 => Cpu16_I3_acc_c_0_2,
      O => CHOICE816_G
    );
  Cpu16_I3_Mmux_data_x_Result_8_114_SW0 : X_LUT4
    generic map(
      INIT => X"E070"
    )
    port map (
      ADR0 => N31850,
      ADR1 => Cpu16_I2_TD_c_2_2,
      ADR2 => Cpu16_I2_TD_c_0_2,
      ADR3 => Cpu16_I2_TD_c_1_2,
      O => N30860_F
    );
  Cpu16_I3_n0147_2_29 : X_LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      ADR0 => N31295,
      ADR1 => CHOICE1430,
      ADR2 => Cpu16_I3_n0025,
      ADR3 => Cpu16_I2_data_is_c(2),
      O => CHOICE1192_G
    );
  Cpu16_I3_n0147_1_106 : X_LUT4
    generic map(
      INIT => X"FCF8"
    )
    port map (
      ADR0 => CHOICE809,
      ADR1 => Cpu16_I3_N17531,
      ADR2 => CHOICE808,
      ADR3 => CHOICE813,
      O => CHOICE816_F
    );
  Cpu16_I3_n0147_9_29 : X_LUT4
    generic map(
      INIT => X"E020"
    )
    port map (
      ADR0 => CHOICE1012,
      ADR1 => Cpu16_I3_n0025,
      ADR2 => N31331,
      ADR3 => Cpu16_I2_data_is_c(9),
      O => CHOICE1192_F
    );
  Cpu16_I3_n0147_2_81 : X_LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I3_acc_i_0_2,
      ADR3 => Cpu16_I2_TC_c_0_1,
      O => CHOICE925_G
    );
  Cpu16_I3_n0147_4_81 : X_LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I3_acc_i_0_4,
      ADR3 => Cpu16_I2_TC_c_0_1,
      O => CHOICE925_F
    );
  Cpu16_I3_n0147_2_90 : X_LUT4
    generic map(
      INIT => X"F222"
    )
    port map (
      ADR0 => Cpu16_I3_n0084,
      ADR1 => Cpu16_I3_acc_c_0_2,
      ADR2 => Cpu16_I3_acc_c_0_3,
      ADR3 => Cpu16_I3_N17006,
      O => CHOICE847_G
    );
  Cpu16_I3_n0147_2_82 : X_LUT4
    generic map(
      INIT => X"0A00"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c(0),
      ADR1 => VCC,
      ADR2 => Cpu16_I2_TD_c(2),
      ADR3 => Cpu16_I3_acc_c_0_1,
      O => CHOICE981_G
    );
  Cpu16_I3_n0147_5_82 : X_LUT4
    generic map(
      INIT => X"0A00"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c(0),
      ADR1 => VCC,
      ADR2 => Cpu16_I2_TD_c(2),
      ADR3 => Cpu16_I3_acc_c_0_4,
      O => CHOICE981_F
    );
  Cpu16_I3_n0147_9_39_SW0 : X_LUT4
    generic map(
      INIT => X"E4CC"
    )
    port map (
      ADR0 => Cpu16_I3_n0083,
      ADR1 => N31976,
      ADR2 => N30337,
      ADR3 => Cpu16_I3_n0098(9),
      O => Cpu16_I3_acc_c_0_9_G
    );
  Cpu16_I3_acc_c_0_8_1163 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_9_DYMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_9_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_9_FFY_RST,
      O => Cpu16_I3_acc_c_0_8
    );
  Cpu16_I3_acc_c_0_9_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_9_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_9_FFY_RST
    );
  Cpu16_I3_n0147_9_139 : X_LUT4
    generic map(
      INIT => X"FFE4"
    )
    port map (
      ADR0 => CHOICE1188,
      ADR1 => Cpu16_I3_n0147_9_39_SW0_O,
      ADR2 => N30337,
      ADR3 => CHOICE1181,
      O => Cpu16_I3_acc_c_0_9_F
    );
  XLXI_5_Mmux_cpu_daddr_out_Result_3_1 : X_LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      ADR0 => XLXI_5_cpu_daddr_c(3),
      ADR1 => XLXI_5_N12936,
      ADR2 => CPU_ADADDR_OUT(3),
      ADR3 => XLXI_5_N12957,
      O => ADDR_OUT_EXT_3_OBUF_F
    );
  Cpu16_I3_acc_c_0_9_1164 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_9_DXMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_9_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_9_FFX_RST,
      O => Cpu16_I3_acc_c_0_9
    );
  Cpu16_I3_acc_c_0_9_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_9_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_9_FFX_RST
    );
  Cpu16_I4_daddr_x_2_SW0 : X_LUT4
    generic map(
      INIT => X"FFDD"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_c(2),
      ADR1 => Cpu16_daddr_is(1),
      ADR2 => VCC,
      ADR3 => Cpu16_I2_Mmux_idata_x_Result_4_1_1,
      O => XLXI_3_daddr_c_2_G
    );
  Cpu16_I3_Ker171501 : X_LUT4
    generic map(
      INIT => X"E4A0"
    )
    port map (
      ADR0 => Cpu16_I3_n0023,
      ADR1 => Cpu16_I3_nreset_v(1),
      ADR2 => Cpu16_I3_N17260,
      ADR3 => Cpu16_I3_nreset_v(0),
      O => CHOICE1181_G
    );
  Cpu16_I3_Ker172587_SW0 : X_LUT4
    generic map(
      INIT => X"0F0E"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c(1),
      ADR1 => Cpu16_I2_TD_c(2),
      ADR2 => Cpu16_I2_TD_c(3),
      ADR3 => Cpu16_I2_TD_c(0),
      O => CHOICE4_G
    );
  Cpu16_I4_daddr_x_2_Q : X_LUT4
    generic map(
      INIT => X"C0E0"
    )
    port map (
      ADR0 => Cpu16_I4_n0202,
      ADR1 => Cpu16_I2_Mmux_idata_x_Result_6_1_1,
      ADR2 => Cpu16_I4_n0162,
      ADR3 => N20628,
      O => XLXI_3_daddr_c_2_F
    );
  XLXI_3_daddr_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_daddr_c_2_DXMUX,
      CE => XLXI_3_daddr_c_2_CEINV,
      CLK => XLXI_3_daddr_c_2_CLKINV,
      SET => GND,
      RST => XLXI_3_daddr_c_2_FFX_RST,
      O => XLXI_3_daddr_c(2)
    );
  XLXI_3_daddr_c_2_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_daddr_c_2_SRINVNOT,
      I1 => GSR,
      O => XLXI_3_daddr_c_2_FFX_RST
    );
  Cpu16_I3_n0147_6_106 : X_LUT4
    generic map(
      INIT => X"FEF0"
    )
    port map (
      ADR0 => CHOICE1040,
      ADR1 => CHOICE1036,
      ADR2 => CHOICE1035,
      ADR3 => Cpu16_I3_N17531,
      O => CHOICE1043_F
    );
  Cpu16_I4_daddr_x_0_SW0 : X_LUT4
    generic map(
      INIT => X"FFCF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_Mmux_idata_x_Result_6_1_1,
      ADR2 => Cpu16_I4_ireg_c(0),
      ADR3 => Cpu16_daddr_is(1),
      O => XLXI_3_daddr_c_0_G
    );
  Cpu16_I4_daddr_x_0_Q : X_LUT4
    generic map(
      INIT => X"88C8"
    )
    port map (
      ADR0 => Cpu16_I2_Mmux_idata_x_Result_4_1_1,
      ADR1 => Cpu16_I4_n0162,
      ADR2 => Cpu16_I4_n0202,
      ADR3 => N20679,
      O => XLXI_3_daddr_c_0_F
    );
  XLXI_3_daddr_c_0 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_daddr_c_0_DXMUX,
      CE => XLXI_3_daddr_c_0_CEINV,
      CLK => XLXI_3_daddr_c_0_CLKINV,
      SET => GND,
      RST => XLXI_3_daddr_c_0_FFX_RST,
      O => XLXI_3_daddr_c(0)
    );
  XLXI_3_daddr_c_0_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_daddr_c_0_SRINVNOT,
      I1 => GSR,
      O => XLXI_3_daddr_c_0_FFX_RST
    );
  Cpu16_I3_n0147_8_82 : X_LUT4
    generic map(
      INIT => X"4400"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_2_3,
      ADR1 => Cpu16_I3_acc_c_0_7,
      ADR2 => VCC,
      ADR3 => Cpu16_I2_TD_c_0_3,
      O => CHOICE1146_F
    );
  Cpu16_I3_n0147_7_90 : X_LUT4
    generic map(
      INIT => X"AE0C"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_8,
      ADR1 => Cpu16_I3_n0084,
      ADR2 => Cpu16_I3_acc_c_0_7,
      ADR3 => Cpu16_I3_N17006,
      O => CHOICE1098_G
    );
  Cpu16_I3_n0147_7_29 : X_LUT4
    generic map(
      INIT => X"C088"
    )
    port map (
      ADR0 => CHOICE1122,
      ADR1 => N31307,
      ADR2 => Cpu16_I2_data_is_c(7),
      ADR3 => Cpu16_I3_n0025,
      O => CHOICE1082_F
    );
  Cpu16_I3_n0147_8_19 : X_LUT4
    generic map(
      INIT => X"0800"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_2_1,
      ADR1 => Cpu16_I3_n0090(8),
      ADR2 => Cpu16_I2_TD_c_0_1,
      ADR3 => Cpu16_I2_TD_c_1_1,
      O => CHOICE1133_F
    );
  Cpu16_I3_n0147_7_106 : X_LUT4
    generic map(
      INIT => X"FAF8"
    )
    port map (
      ADR0 => Cpu16_I3_N17531,
      ADR1 => CHOICE1091,
      ADR2 => CHOICE1090,
      ADR3 => CHOICE1095,
      O => CHOICE1098_F
    );
  Cpu16_I3_n0147_6_0 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_acc_c_0_6,
      ADR2 => VCC,
      ADR3 => Cpu16_I3_N17152,
      O => CHOICE1016_F
    );
  Cpu16_I3_n0147_8_90 : X_LUT4
    generic map(
      INIT => X"F444"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_8,
      ADR1 => Cpu16_I3_n0084,
      ADR2 => Cpu16_I3_acc_c_0_9,
      ADR3 => Cpu16_I3_N17006,
      O => CHOICE1153_G
    );
  Cpu16_I3_Mmux_data_x_Result_9_114_SW0_SW0 : X_LUT4
    generic map(
      INIT => X"FDFF"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_0_1,
      ADR2 => Cpu16_I2_TC_c_2_1,
      ADR3 => Cpu16_I2_data_is_c(9),
      O => N30866_G
    );
  Cpu16_I3_n0147_8_106 : X_LUT4
    generic map(
      INIT => X"EEEA"
    )
    port map (
      ADR0 => CHOICE1145,
      ADR1 => Cpu16_I3_N17531,
      ADR2 => CHOICE1146,
      ADR3 => CHOICE1150,
      O => CHOICE1153_F
    );
  Cpu16_I2_n0073_1_9 : X_LUT4
    generic map(
      INIT => X"FD00"
    )
    port map (
      ADR0 => Cpu16_I2_n0166(2),
      ADR1 => Cpu16_I2_n0062,
      ADR2 => Cpu16_I2_n0063,
      ADR3 => Cpu16_I2_S_c(1),
      O => CHOICE52_G
    );
  Cpu16_I3_Mmux_data_x_Result_9_114_SW0 : X_LUT4
    generic map(
      INIT => X"8CC4"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c_1_2,
      ADR1 => Cpu16_I2_TD_c_0_2,
      ADR2 => Cpu16_I2_TD_c_2_2,
      ADR3 => N31854,
      O => N30866_F
    );
  Cpu16_I2_int_stop_x11 : X_LUT4
    generic map(
      INIT => X"0005"
    )
    port map (
      ADR0 => Cpu16_I2_n0062,
      ADR1 => VCC,
      ADR2 => Cpu16_I2_n0063,
      ADR3 => Cpu16_I2_n0166(2),
      O => CHOICE52_F
    );
  Cpu16_I3_n0147_9_81 : X_LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_0_1,
      ADR2 => Cpu16_I2_TC_c_2_1,
      ADR3 => Cpu16_I3_acc_i_0_9,
      O => Cpu16_I3_N17531_G
    );
  Cpu16_I3_Ker175291 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => Cpu16_I2_TD_c(3),
      ADR1 => Cpu16_I2_TC_c_1_1,
      ADR2 => Cpu16_I2_TC_c_2_1,
      ADR3 => Cpu16_I2_TC_c_0_1,
      O => Cpu16_I3_N17531_F
    );
  Cpu16_I3_n0147_9_90 : X_LUT4
    generic map(
      INIT => X"8F88"
    )
    port map (
      ADR0 => Cpu16_I3_N17033,
      ADR1 => Cpu16_I3_acc_c_0_8,
      ADR2 => Cpu16_I3_acc_c_0_9,
      ADR3 => Cpu16_I3_n0084,
      O => CHOICE1208_G
    );
  Cpu16_I3_n0147_9_106 : X_LUT4
    generic map(
      INIT => X"FCEC"
    )
    port map (
      ADR0 => CHOICE1201,
      ADR1 => CHOICE1200,
      ADR2 => Cpu16_I3_N17531,
      ADR3 => CHOICE1205,
      O => CHOICE1208_F
    );
  Cpu16_I1_n00201_1_1165 : X_LUT4
    generic map(
      INIT => X"0808"
    )
    port map (
      ADR0 => Cpu16_I2_pc_mux_x_1_44_1,
      ADR1 => Cpu16_I2_pc_mux_x_2_46_1,
      ADR2 => Cpu16_I2_pc_mux_x_0_104_1,
      ADR3 => VCC,
      O => Cpu16_I1_eaddr_x_11_G
    );
  Cpu16_I1_Mmux_n0008_Result_11_1 : X_LUT4
    generic map(
      INIT => X"CFC0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => MEM_DATA_OUT(15),
      ADR2 => Cpu16_I1_n00201_1,
      ADR3 => Cpu16_I1_eaddr_x(11),
      O => Cpu16_I1_n0008(11)
    );
  Cpu16_I2_n0073_2_9 : X_LUT4
    generic map(
      INIT => X"EECE"
    )
    port map (
      ADR0 => Cpu16_I2_S_c(2),
      ADR1 => Cpu16_I2_n0166(2),
      ADR2 => Cpu16_I2_C_rti,
      ADR3 => Cpu16_I2_n0145,
      O => Cpu16_I2_S_c_2_G
    );
  Cpu16_I1_eaddr_x_11 : X_LATCHE
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I1_eaddr_x_11_DXMUX,
      GE => Cpu16_I1_eaddr_x_11_CEINV,
      CLK => NlwInverterSignal_Cpu16_I1_eaddr_x_11_CLK,
      SET => GND,
      RST => Cpu16_I1_eaddr_x_11_FFX_RST,
      O => Cpu16_I1_eaddr_x(11)
    );
  Cpu16_I1_eaddr_x_11_FFX_RSTOR : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => GSR,
      O => Cpu16_I1_eaddr_x_11_FFX_RST
    );
  Cpu16_I2_n0073_2_10 : X_LUT4
    generic map(
      INIT => X"C0C0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_nreset_v_1_1,
      ADR2 => CHOICE37,
      ADR3 => VCC,
      O => Cpu16_I2_n0073(2)
    );
  Cpu16_I2_S_c_2 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I2_S_c_2_DXMUX,
      CE => VCC,
      CLK => Cpu16_I2_S_c_2_CLKINV,
      SET => GND,
      RST => Cpu16_I2_S_c_2_FFX_RST,
      O => Cpu16_I2_S_c(2)
    );
  Cpu16_I2_S_c_2_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I2_S_c_2_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I2_S_c_2_FFX_RST
    );
  XLXI_5_Msub_n0011_inst_lut2_141 : X_LUT4
    generic map(
      INIT => X"0F0F"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => XLXI_5_nwait_c(7),
      ADR3 => VCC,
      O => XLXI_5_Msub_n0011_inst_lut2_14_G
    );
  Cpu16_I4_daddr_x_1_SW0 : X_LUT4
    generic map(
      INIT => X"FF33"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I4_ireg_c(1),
      ADR2 => VCC,
      ADR3 => Cpu16_I4_N18068,
      O => XLXI_3_daddr_c_1_G
    );
  Cpu16_I4_daddr_x_1_Q : X_LUT4
    generic map(
      INIT => X"CC40"
    )
    port map (
      ADR0 => N20593,
      ADR1 => Cpu16_I4_n0162,
      ADR2 => Cpu16_I4_n0202,
      ADR3 => Cpu16_daddr_is(1),
      O => XLXI_3_daddr_c_1_F
    );
  Cpu16_I3_n0147_1_39_SW0 : X_LUT4
    generic map(
      INIT => X"B8F0"
    )
    port map (
      ADR0 => N30385,
      ADR1 => Cpu16_I3_n0083,
      ADR2 => N31922,
      ADR3 => Cpu16_I3_n0098(1),
      O => Cpu16_I3_acc_c_0_1_G
    );
  XLXI_3_daddr_c_1 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => XLXI_3_daddr_c_1_DXMUX,
      CE => XLXI_3_daddr_c_1_CEINV,
      CLK => XLXI_3_daddr_c_1_CLKINV,
      SET => GND,
      RST => XLXI_3_daddr_c_1_FFX_RST,
      O => XLXI_3_daddr_c(1)
    );
  XLXI_3_daddr_c_1_FFX_RSTOR : X_OR2
    port map (
      I0 => XLXI_3_daddr_c_1_SRINVNOT,
      I1 => GSR,
      O => XLXI_3_daddr_c_1_FFX_RST
    );
  XLXI_5_Ker129341 : X_LUT4
    generic map(
      INIT => X"F7F0"
    )
    port map (
      ADR0 => CHOICE270,
      ADR1 => CHOICE277,
      ADR2 => Cpu16_I4_ndre_x1_1,
      ADR3 => NRESET_IN_BUFGP,
      O => XLXI_5_N12936_F
    );
  Cpu16_I3_n0147_3_39_SW0 : X_LUT4
    generic map(
      INIT => X"F870"
    )
    port map (
      ADR0 => Cpu16_I3_n0098(3),
      ADR1 => Cpu16_I3_n0083,
      ADR2 => N31984,
      ADR3 => N30373,
      O => Cpu16_I3_acc_c_0_3_G
    );
  Cpu16_I3_n0147_5_39_SW0 : X_LUT4
    generic map(
      INIT => X"E2AA"
    )
    port map (
      ADR0 => N31988,
      ADR1 => Cpu16_I3_n0083,
      ADR2 => N30361,
      ADR3 => Cpu16_I3_n0098(5),
      O => Cpu16_I3_acc_c_0_5_G
    );
  Cpu16_I3_acc_c_0_0_1166 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_1_DYMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_1_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_1_FFY_RST,
      O => Cpu16_I3_acc_c_0_0
    );
  Cpu16_I3_acc_c_0_1_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_1_FFY_RST
    );
  Cpu16_I3_n0147_1_139 : X_LUT4
    generic map(
      INIT => X"EFEC"
    )
    port map (
      ADR0 => N30385,
      ADR1 => CHOICE789,
      ADR2 => CHOICE796,
      ADR3 => Cpu16_I3_n0147_1_39_SW0_O,
      O => Cpu16_I3_acc_c_0_1_F
    );
  Cpu16_I3_acc_c_0_1_1167 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_1_DXMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_1_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_1_FFX_RST,
      O => Cpu16_I3_acc_c_0_1
    );
  Cpu16_I3_acc_c_0_1_FFX_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_1_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_1_FFX_RST
    );
  Cpu16_I3_acc_c_0_2_1168 : X_FF
    generic map(
      INIT => '0'
    )
    port map (
      I => Cpu16_I3_acc_c_0_3_DYMUX,
      CE => VCC,
      CLK => Cpu16_I3_acc_c_0_3_CLKINV,
      SET => GND,
      RST => Cpu16_I3_acc_c_0_3_FFY_RST,
      O => Cpu16_I3_acc_c_0_2
    );
  Cpu16_I3_acc_c_0_3_FFY_RSTOR : X_OR2
    port map (
      I0 => Cpu16_I3_acc_c_0_3_SRINVNOT,
      I1 => GSR,
      O => Cpu16_I3_acc_c_0_3_FFY_RST
    );
  Cpu16_I3_n0147_3_139 : X_LUT4
    generic map(
      INIT => X"FFCA"
    )
    port map (
      ADR0 => Cpu16_I3_n0147_3_39_SW0_O,
      ADR1 => N30373,
      ADR2 => CHOICE858,
      ADR3 => CHOICE851,
      O => Cpu16_I3_acc_c_0_3_F
    );
  XLXI_5_n00321 : X_LUT4
    generic map(
      INIT => X"4040"
    )
    port map (
      ADR0 => XLXI_5_dw_s(0),
      ADR1 => CHOICE270,
      ADR2 => CHOICE277,
      ADR3 => VCC,
      O => XLXI_5_n0032_F
    );
  Cpu16_I3_n0147_14_13_SW0 : X_LUT4
    generic map(
      INIT => X"BABA"
    )
    port map (
      ADR0 => CHOICE1516,
      ADR1 => Cpu16_I2_TD_c(3),
      ADR2 => Cpu16_I3_n0100,
      ADR3 => VCC,
      O => N30625_G
    );
  Cpu16_I3_n0147_14_13_SW1 : X_LUT4
    generic map(
      INIT => X"FABA"
    )
    port map (
      ADR0 => CHOICE1516,
      ADR1 => Cpu16_I2_TD_c(3),
      ADR2 => Cpu16_I3_n0100,
      ADR3 => Cpu16_I3_acc_c_0_14,
      O => N30625_F
    );
  Cpu16_I3_n0147_14_13_SW2 : X_LUT4
    generic map(
      INIT => X"0440"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_2_1,
      ADR1 => Cpu16_I3_acc_c_0_14,
      ADR2 => Cpu16_I2_TC_c_0_1,
      ADR3 => Cpu16_I2_TC_c_1_1,
      O => N30305_G
    );
  Cpu16_I1_n00101 : X_LUT4
    generic map(
      INIT => X"AA00"
    )
    port map (
      ADR0 => Cpu16_I1_nreset_v(1),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => NRESET_IN_BUFGP,
      O => N31114_G
    );
  Cpu16_I3_n0147_14_72_SW0 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => Cpu16_I3_n0023,
      ADR1 => CHOICE1516,
      ADR2 => N30726,
      ADR3 => CHOICE1494,
      O => N30305_F
    );
  Cpu16_I2_pc_mux_x_2_46_SW2 : X_LUT4
    generic map(
      INIT => X"93CC"
    )
    port map (
      ADR0 => Cpu16_I2_n0166(2),
      ADR1 => XLXI_4_addr_c(1),
      ADR2 => CHOICE665,
      ADR3 => Cpu16_I1_n0010,
      O => N31114_F
    );
  Cpu16_I4_Madd_n0182_inst_lut2_711 : X_LUT4
    generic map(
      INIT => X"5A5A"
    )
    port map (
      ADR0 => Cpu16_I4_ireg_c(11),
      ADR1 => VCC,
      ADR2 => Cpu16_I4_iinc_c(11),
      ADR3 => VCC,
      O => Cpu16_I4_Madd_n0182_inst_lut2_71_G
    );
  Cpu16_I3_n009625 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_5,
      ADR1 => Cpu16_I3_acc_c_0_7,
      ADR2 => Cpu16_I3_acc_c_0_6,
      ADR3 => Cpu16_I3_acc_c_0_4,
      O => CHOICE1608_F
    );
  Cpu16_I3_n009662 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_15,
      ADR1 => Cpu16_I3_acc_c_0_14,
      ADR2 => Cpu16_I3_acc_c_0_13,
      ADR3 => Cpu16_I3_acc_c_0_12,
      O => N30637_G
    );
  Cpu16_I3_n009649 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => Cpu16_I3_acc_c_0_11,
      ADR1 => Cpu16_I3_acc_c_0_10,
      ADR2 => Cpu16_I3_acc_c_0_8,
      ADR3 => Cpu16_I3_acc_c_0_9,
      O => CHOICE1616_F
    );
  Cpu16_I3_Ker172587 : X_LUT4
    generic map(
      INIT => X"0013"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I2_TC_c_0_1,
      ADR3 => N31797,
      O => CHOICE4_F
    );
  Cpu16_I3_n0147_9_0 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I3_acc_c_0_9,
      ADR2 => VCC,
      ADR3 => Cpu16_I3_N17152,
      O => CHOICE1181_F
    );
  Cpu16_I3_n0147_4_13_SW1 : X_LUT4
    generic map(
      INIT => X"FF8A"
    )
    port map (
      ADR0 => Cpu16_I3_n0100,
      ADR1 => Cpu16_I3_acc_c_0_4,
      ADR2 => Cpu16_I2_TD_c_3_1,
      ADR3 => CHOICE933,
      O => N30661_G
    );
  Cpu16_I3_n0147_5_13_SW1 : X_LUT4
    generic map(
      INIT => X"EECE"
    )
    port map (
      ADR0 => Cpu16_I3_n0100,
      ADR1 => CHOICE988,
      ADR2 => Cpu16_I2_TD_c_3_1,
      ADR3 => Cpu16_I3_acc_c_0_5,
      O => N30661_F
    );
  Cpu16_I3_n0147_4_13_SW2 : X_LUT4
    generic map(
      INIT => X"1200"
    )
    port map (
      ADR0 => Cpu16_I2_TC_c_1_1,
      ADR1 => Cpu16_I2_TC_c_2_1,
      ADR2 => Cpu16_I2_TC_c_0_1,
      ADR3 => Cpu16_I3_acc_c_0_4,
      O => N30365_G
    );
  Cpu16_I3_n0147_4_0 : X_LUT4
    generic map(
      INIT => X"AA00"
    )
    port map (
      ADR0 => Cpu16_I3_N17152,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => Cpu16_I3_acc_c_0_4,
      O => CHOICE961_G
    );
  Cpu16_I3_n0147_4_72_SW0 : X_LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      ADR0 => Cpu16_I3_n0023,
      ADR1 => CHOICE933,
      ADR2 => CHOICE911,
      ADR3 => N31043,
      O => N30365_F
    );
  Cpu16_I3_n0147_5_0 : X_LUT4
    generic map(
      INIT => X"A0A0"
    )
    port map (
      ADR0 => Cpu16_I3_N17152,
      ADR1 => VCC,
      ADR2 => Cpu16_I3_acc_c_0_5,
      ADR3 => VCC,
      O => CHOICE961_F
    );
  Cpu16_I3_n0147_0_27_SW0_SW2 : X_LUT4
    generic map(
      INIT => X"CC00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I2_TD_c_0_2,
      ADR2 => VCC,
      ADR3 => Cpu16_I3_acc_c_0_0,
      O => N31289_G
    );
  XLXI_5_n002820 : X_LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      ADR0 => XLXI_5_nwait_c(5),
      ADR1 => XLXI_5_nwait_c(4),
      ADR2 => XLXI_5_nwait_c(7),
      ADR3 => XLXI_5_nwait_c(6),
      O => XLXI_5_n0032_G
    );
  Cpu16_I3_n0147_0_27_SW0 : X_LUT4
    generic map(
      INIT => X"DB00"
    )
    port map (
      ADR0 => CHOICE1520,
      ADR1 => Cpu16_I2_TD_c_2_2,
      ADR2 => Cpu16_I2_TD_c_1_2,
      ADR3 => N31886,
      O => N31289_F
    );
  Cpu16_I3_n0090_16_XUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_n0090_16_XORF,
      O => Cpu16_I3_n0090(16)
    );
  Cpu16_I3_n0090_16_XORF_1169 : X_XOR2
    port map (
      I0 => Cpu16_I3_n0090_16_CYINIT,
      I1 => Cpu16_I3_n0090_16_F,
      O => Cpu16_I3_n0090_16_XORF
    );
  Cpu16_I3_n0090_16_CYINIT_1170 : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => Cpu16_I3_Msub_n0090_inst_cy_43,
      O => Cpu16_I3_n0090_16_CYINIT
    );
  Cpu16_I3_n0090_16_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FFFF"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Cpu16_I3_n0090_16_F
    );
  PWR_VCC_0_LOGICAL_ONE : X_ONE
    port map (
      O => GLOBAL_LOGIC1
    );
  PWR_VCC_1_LOGICAL_ONE : X_ONE
    port map (
      O => GLOBAL_LOGIC1_0
    );
  PWR_VCC_2_LOGICAL_ONE : X_ONE
    port map (
      O => GLOBAL_LOGIC1_1
    );
  PWR_VCC_3_LOGICAL_ONE : X_ONE
    port map (
      O => GLOBAL_LOGIC1_2
    );
  PWR_VCC_4_LOGICAL_ONE : X_ONE
    port map (
      O => GLOBAL_LOGIC1_3
    );
  PWR_VCC_5_LOGICAL_ONE : X_ONE
    port map (
      O => GLOBAL_LOGIC1_4
    );
  PWR_VCC_6_LOGICAL_ONE : X_ONE
    port map (
      O => GLOBAL_LOGIC1_5
    );
  PWR_VCC_7_LOGICAL_ONE : X_ONE
    port map (
      O => GLOBAL_LOGIC1_6
    );
  PWR_VCC_8_LOGICAL_ONE : X_ONE
    port map (
      O => GLOBAL_LOGIC1_7
    );
  PWR_VCC_9_LOGICAL_ONE : X_ONE
    port map (
      O => GLOBAL_LOGIC1_8
    );
  PWR_VCC_10_LOGICAL_ONE : X_ONE
    port map (
      O => GLOBAL_LOGIC1_9
    );
  PWR_VCC_11_LOGICAL_ONE : X_ONE
    port map (
      O => GLOBAL_LOGIC1_10
    );
  PWR_VCC_12_LOGICAL_ONE : X_ONE
    port map (
      O => GLOBAL_LOGIC1_11
    );
  PWR_VCC_13_LOGICAL_ONE : X_ONE
    port map (
      O => GLOBAL_LOGIC1_12
    );
  PWR_GND_0_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => PWR_GND_0_G,
      O => GLOBAL_LOGIC0
    );
  PWR_GND_0_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_GND_0_G
    );
  PWR_GND_1_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => PWR_GND_1_G,
      O => GLOBAL_LOGIC0_0
    );
  PWR_GND_1_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_GND_1_G
    );
  PWR_GND_2_YUSED : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => PWR_GND_2_G,
      O => GLOBAL_LOGIC0_1
    );
  PWR_GND_2_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => PWR_GND_2_G
    );
  Cpu16_I1_n0009_1_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => Cpu16_I1_pc(1),
      ADR3 => VCC,
      O => Cpu16_I1_n0009_1_G
    );
  Cpu16_I1_n0009_2_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => Cpu16_I1_pc(2),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Cpu16_I1_n0009_2_F
    );
  Cpu16_I1_n0009_2_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => Cpu16_I1_pc(3),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Cpu16_I1_n0009_2_G
    );
  Cpu16_I1_n0009_4_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => Cpu16_I1_pc(4),
      ADR3 => VCC,
      O => Cpu16_I1_n0009_4_F
    );
  Cpu16_I1_n0009_4_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => Cpu16_I1_pc(5),
      ADR3 => VCC,
      O => Cpu16_I1_n0009_4_G
    );
  Cpu16_I1_n0009_6_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => Cpu16_I1_pc(6),
      ADR3 => VCC,
      O => Cpu16_I1_n0009_6_F
    );
  Cpu16_I1_n0009_6_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => Cpu16_I1_pc(7),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Cpu16_I1_n0009_6_G
    );
  Cpu16_I1_n0009_8_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"FF00"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => Cpu16_I1_pc(8),
      O => Cpu16_I1_n0009_8_F
    );
  Cpu16_I1_n0009_8_G_X_LUT4 : X_LUT4
    generic map(
      INIT => X"F0F0"
    )
    port map (
      ADR0 => VCC,
      ADR1 => VCC,
      ADR2 => Cpu16_I1_pc(9),
      ADR3 => VCC,
      O => Cpu16_I1_n0009_8_G
    );
  Cpu16_I1_n0009_10_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"CCCC"
    )
    port map (
      ADR0 => VCC,
      ADR1 => Cpu16_I1_pc(10),
      ADR2 => VCC,
      ADR3 => VCC,
      O => Cpu16_I1_n0009_10_F
    );
  XLXI_5_n0011_0_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => XLXI_5_nwait_c(0),
      ADR1 => VCC,
      ADR2 => VCC,
      ADR3 => VCC,
      O => XLXI_5_n0011_0_F
    );
  Cpu16_I3_n0090_0_F_X_LUT4 : X_LUT4
    generic map(
      INIT => X"AAAA"
    )
    port map (
      ADR0 => Cpu16_I3_Msub_n0090_inst_lut2_27,
      ADR1 => Cpu16_I3_acc_c_0_0,
      ADR2 => VCC,
      ADR3 => VCC,
      O => Cpu16_I3_n0090_0_F
    );
  DATA_OUT_EXT_0_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_0_OBUF,
      O => DATA_OUT_EXT_0_O
    );
  DATA_OUT_EXT_1_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_1_OBUF,
      O => DATA_OUT_EXT_1_O
    );
  DATA_OUT_EXT_2_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_2_OBUF,
      O => DATA_OUT_EXT_2_O
    );
  DATA_OUT_EXT_3_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_3_OBUF,
      O => DATA_OUT_EXT_3_O
    );
  DATA_OUT_EXT_4_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_4_OBUF,
      O => DATA_OUT_EXT_4_O
    );
  DATA_OUT_EXT_5_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_5_OBUF,
      O => DATA_OUT_EXT_5_O
    );
  DATA_OUT_EXT_6_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_6_OBUF,
      O => DATA_OUT_EXT_6_O
    );
  DATA_OUT_EXT_7_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_7_OBUF,
      O => DATA_OUT_EXT_7_O
    );
  DATA_OUT_EXT_8_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_8_OBUF,
      O => DATA_OUT_EXT_8_O
    );
  DATA_OUT_EXT_9_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_9_OBUF,
      O => DATA_OUT_EXT_9_O
    );
  CPU_INT_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CPU_INT_INBUF,
      O => CPU_INT_IBUF
    );
  ADDR_OUT_EXT_0_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_0_OBUF,
      O => ADDR_OUT_EXT_0_O
    );
  ADDR_OUT_EXT_1_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_1_OBUF,
      O => ADDR_OUT_EXT_1_O
    );
  ADDR_OUT_EXT_2_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_2_OBUF,
      O => ADDR_OUT_EXT_2_O
    );
  ADDR_OUT_EXT_3_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_3_OBUF,
      O => ADDR_OUT_EXT_3_O
    );
  ADDR_OUT_EXT_4_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_4_OBUF,
      O => ADDR_OUT_EXT_4_O
    );
  ADDR_OUT_EXT_5_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_5_OBUF,
      O => ADDR_OUT_EXT_5_O
    );
  ADDR_OUT_EXT_6_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_6_OBUF,
      O => ADDR_OUT_EXT_6_O
    );
  ADDR_OUT_EXT_7_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_7_OBUF,
      O => ADDR_OUT_EXT_7_O
    );
  ADDR_OUT_EXT_8_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_8_OBUF,
      O => ADDR_OUT_EXT_8_O
    );
  ADDR_OUT_EXT_9_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => ADDR_OUT_EXT_9_OBUF,
      O => ADDR_OUT_EXT_9_O
    );
  DATA_IN_EXT_10_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT_10_INBUF,
      O => DATA_IN_EXT_10_IBUF
    );
  DATA_IN_EXT_11_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT_11_INBUF,
      O => DATA_IN_EXT_11_IBUF
    );
  DATA_IN_EXT_12_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT_12_INBUF,
      O => DATA_IN_EXT_12_IBUF
    );
  DATA_IN_EXT_13_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT_13_INBUF,
      O => DATA_IN_EXT_13_IBUF
    );
  DATA_IN_EXT_14_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT_14_INBUF,
      O => DATA_IN_EXT_14_IBUF
    );
  DATA_IN_EXT_15_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT_15_INBUF,
      O => DATA_IN_EXT_15_IBUF
    );
  DATA_OUT_EXT_10_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_10_OBUF,
      O => DATA_OUT_EXT_10_O
    );
  DATA_OUT_EXT_11_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_11_OBUF,
      O => DATA_OUT_EXT_11_O
    );
  DATA_OUT_EXT_12_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_12_OBUF,
      O => DATA_OUT_EXT_12_O
    );
  DATA_OUT_EXT_13_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_13_OBUF,
      O => DATA_OUT_EXT_13_O
    );
  DATA_OUT_EXT_14_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_14_OBUF,
      O => DATA_OUT_EXT_14_O
    );
  DATA_OUT_EXT_15_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_OUT_EXT_15_OBUF,
      O => DATA_OUT_EXT_15_O
    );
  CLK_IN_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => CLK_IN_INBUF,
      O => CLK_IN_BUFGP_IBUFG
    );
  NRESET_IN_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => NRESET_IN_INBUF,
      O => NRESET_IN_BUFGP_IBUFG
    );
  DATA_IN_EXT_0_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT_0_INBUF,
      O => DATA_IN_EXT_0_IBUF
    );
  DATA_IN_EXT_1_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT_1_INBUF,
      O => DATA_IN_EXT_1_IBUF
    );
  DATA_IN_EXT_2_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT_2_INBUF,
      O => DATA_IN_EXT_2_IBUF
    );
  DATA_IN_EXT_3_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT_3_INBUF,
      O => DATA_IN_EXT_3_IBUF
    );
  DATA_IN_EXT_4_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT_4_INBUF,
      O => DATA_IN_EXT_4_IBUF
    );
  DATA_IN_EXT_5_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT_5_INBUF,
      O => DATA_IN_EXT_5_IBUF
    );
  DATA_IN_EXT_6_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT_6_INBUF,
      O => DATA_IN_EXT_6_IBUF
    );
  DATA_IN_EXT_7_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT_7_INBUF,
      O => DATA_IN_EXT_7_IBUF
    );
  DATA_IN_EXT_8_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT_8_INBUF,
      O => DATA_IN_EXT_8_IBUF
    );
  DATA_IN_EXT_9_IFF_IMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => DATA_IN_EXT_9_INBUF,
      O => DATA_IN_EXT_9_IBUF
    );
  NRE_EXT_OUTPUT_OFF_OMUX : X_BUF_PP
    generic map(
      PATHPULSE => 785 ps
    )
    port map (
      I => NRE_EXT_OBUF,
      O => NRE_EXT_O
    );
  NlwBlock_cpu16bit_VCC : X_ONE
    port map (
      O => VCC
    );
  NlwBlock_cpu16bit_GND : X_ZERO
    port map (
      O => GND
    );
  NlwInverterBlock_Cpu16_I1_eaddr_x_5_CLK : X_INV
    port map (
      I => Cpu16_I1_eaddr_x_5_CLKINVNOT,
      O => NlwInverterSignal_Cpu16_I1_eaddr_x_5_CLK
    );
  NlwInverterBlock_Cpu16_I1_eaddr_x_6_CLK : X_INV
    port map (
      I => Cpu16_I1_eaddr_x_7_CLKINVNOT,
      O => NlwInverterSignal_Cpu16_I1_eaddr_x_6_CLK
    );
  NlwInverterBlock_Cpu16_I1_eaddr_x_7_CLK : X_INV
    port map (
      I => Cpu16_I1_eaddr_x_7_CLKINVNOT,
      O => NlwInverterSignal_Cpu16_I1_eaddr_x_7_CLK
    );
  NlwInverterBlock_Cpu16_I1_eaddr_x_8_CLK : X_INV
    port map (
      I => Cpu16_I1_eaddr_x_9_CLKINVNOT,
      O => NlwInverterSignal_Cpu16_I1_eaddr_x_8_CLK
    );
  NlwInverterBlock_Cpu16_I1_eaddr_x_9_CLK : X_INV
    port map (
      I => Cpu16_I1_eaddr_x_9_CLKINVNOT,
      O => NlwInverterSignal_Cpu16_I1_eaddr_x_9_CLK
    );
  NlwInverterBlock_Cpu16_I1_eaddr_x_0_CLK : X_INV
    port map (
      I => Cpu16_I1_eaddr_x_1_CLKINVNOT,
      O => NlwInverterSignal_Cpu16_I1_eaddr_x_0_CLK
    );
  NlwInverterBlock_Cpu16_I1_eaddr_x_1_CLK : X_INV
    port map (
      I => Cpu16_I1_eaddr_x_1_CLKINVNOT,
      O => NlwInverterSignal_Cpu16_I1_eaddr_x_1_CLK
    );
  NlwInverterBlock_Cpu16_I1_eaddr_x_2_CLK : X_INV
    port map (
      I => Cpu16_I1_eaddr_x_3_CLKINVNOT,
      O => NlwInverterSignal_Cpu16_I1_eaddr_x_2_CLK
    );
  NlwInverterBlock_Cpu16_I1_eaddr_x_3_CLK : X_INV
    port map (
      I => Cpu16_I1_eaddr_x_3_CLKINVNOT,
      O => NlwInverterSignal_Cpu16_I1_eaddr_x_3_CLK
    );
  NlwInverterBlock_Cpu16_I1_eaddr_x_4_CLK : X_INV
    port map (
      I => Cpu16_I1_eaddr_x_5_CLKINVNOT,
      O => NlwInverterSignal_Cpu16_I1_eaddr_x_4_CLK
    );
  NlwInverterBlock_Cpu16_I1_eaddr_x_10_CLK : X_INV
    port map (
      I => Cpu16_I1_eaddr_x_10_CLKINVNOT,
      O => NlwInverterSignal_Cpu16_I1_eaddr_x_10_CLK
    );
  NlwInverterBlock_Cpu16_I1_eaddr_x_11_CLK : X_INV
    port map (
      I => Cpu16_I1_eaddr_x_11_CLKINVNOT,
      O => NlwInverterSignal_Cpu16_I1_eaddr_x_11_CLK
    );
  NlwBlockROC : X_ROC
    generic map (ROC_WIDTH => 100 ns)
    port map (O => GSR);
  NlwBlockTOC : X_TOC
    port map (O => GTS);

end Structure;

