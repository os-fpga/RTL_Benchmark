-- Copyright (C) 1991-2003 Altera Corporation
-- Any  megafunction  design,  and related netlist (encrypted  or  decrypted),
-- support information,  device programming or simulation file,  and any other
-- associated  documentation or information  provided by  Altera  or a partner
-- under  Altera's   Megafunction   Partnership   Program  may  be  used  only
-- to program  PLD  devices (but not masked  PLD  devices) from  Altera.   Any
-- other  use  of such  megafunction  design,  netlist,  support  information,
-- device programming or simulation file,  or any other  related documentation
-- or information  is prohibited  for  any  other purpose,  including, but not
-- limited to  modification,  reverse engineering,  de-compiling, or use  with
-- any other  silicon devices,  unless such use is  explicitly  licensed under
-- a separate agreement with  Altera  or a megafunction partner.  Title to the
-- intellectual property,  including patents,  copyrights,  trademarks,  trade
-- secrets,  or maskworks,  embodied in any such megafunction design, netlist,
-- support  information,  device programming or simulation file,  or any other
-- related documentation or information provided by  Altera  or a megafunction
-- partner, remains with Altera, the megafunction partner, or their respective
-- licensors. No other licenses, including any licenses needed under any third
-- party's intellectual property, are provided herein.

-- VENDOR "Altera"
-- PROGRAM "Quartus II"
-- VERSION "Version 3.0 Build 223 08/14/2003 Service Pack 1 SJ Web Edition"

-- DATE "02/25/2004 22:57:37"

--
-- Device: Altera EP1K10TC100-3 Package TQFP100
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL output from Quartus II) only
-- 

LIBRARY IEEE, flex10ke;
USE IEEE.std_logic_1164.all;
USE flex10ke.flex10ke_components.all;

ENTITY 	cpu4bit IS
    PORT (
	nreset : IN std_logic;
	clk : IN std_logic;
	CTRL_DATA_IN : IN std_logic_vector(3 DOWNTO 0);
	pwm_out : OUT std_logic;
	CPU_DADDR_OUT : OUT std_logic_vector(5 DOWNTO 0);
	nWE_CPU : OUT std_logic;
	nRE_CPU : OUT std_logic;
	CPU_DATA_OUT : OUT std_logic_vector(3 DOWNTO 0);
	CPU_IADDR_OUT : OUT std_logic_vector(7 DOWNTO 0);
	CTRL_DATA_OUT : OUT std_logic_vector(3 DOWNTO 0)
	);
END cpu4bit;

ARCHITECTURE structure OF cpu4bit IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL devoe : std_logic := '0';
SIGNAL ww_nreset : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_CTRL_DATA_IN : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_pwm_out : std_logic;
SIGNAL ww_CPU_DADDR_OUT : std_logic_vector(5 DOWNTO 0);
SIGNAL ww_nWE_CPU : std_logic;
SIGNAL ww_nRE_CPU : std_logic;
SIGNAL ww_CPU_DATA_OUT : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_CPU_IADDR_OUT : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_CTRL_DATA_OUT : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a9_a_waddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a9_a_raddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a6_a_waddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a6_a_raddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a5_a_waddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a5_a_raddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a4_a_waddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a4_a_raddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a7_a_waddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a7_a_raddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a8_a_waddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a8_a_raddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a0_a_waddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a0_a_raddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a1_a_waddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a1_a_raddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a2_a_waddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a2_a_raddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a3_a_waddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a3_a_raddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a3_a_waddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a3_a_raddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a2_a_waddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a2_a_raddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a1_a_waddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a1_a_raddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a0_a_waddr : std_logic_vector(10 DOWNTO 0);
SIGNAL ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a0_a_raddr : std_logic_vector(10 DOWNTO 0);
SIGNAL inst1_alpm_rom_component_asrom_asegment_a0_a_a3_a_modesel : std_logic_vector(15 DOWNTO 0) := "0100000000010000";
SIGNAL inst1_alpm_rom_component_asrom_asegment_a0_a_a4_a_modesel : std_logic_vector(15 DOWNTO 0) := "0100000000010000";
SIGNAL inst2_alpm_ram_dq_component_asram_asegment_a0_a_a1_a_modesel : std_logic_vector(15 DOWNTO 0) := "0000000000010101";
SIGNAL inst2_alpm_ram_dq_component_asram_asegment_a0_a_a0_a_modesel : std_logic_vector(15 DOWNTO 0) := "0000000000010101";
SIGNAL inst2_alpm_ram_dq_component_asram_asegment_a0_a_a2_a_modesel : std_logic_vector(15 DOWNTO 0) := "0000000000010101";
SIGNAL inst2_alpm_ram_dq_component_asram_asegment_a0_a_a3_a_modesel : std_logic_vector(15 DOWNTO 0) := "0000000000010101";
SIGNAL inst1_alpm_rom_component_asrom_asegment_a0_a_a2_a_modesel : std_logic_vector(15 DOWNTO 0) := "0100000000010000";
SIGNAL inst1_alpm_rom_component_asrom_asegment_a0_a_a9_a_modesel : std_logic_vector(15 DOWNTO 0) := "0100000000010000";
SIGNAL inst1_alpm_rom_component_asrom_asegment_a0_a_a8_a_modesel : std_logic_vector(15 DOWNTO 0) := "0100000000010000";
SIGNAL inst1_alpm_rom_component_asrom_asegment_a0_a_a7_a_modesel : std_logic_vector(15 DOWNTO 0) := "0100000000010000";
SIGNAL inst1_alpm_rom_component_asrom_asegment_a0_a_a0_a_modesel : std_logic_vector(15 DOWNTO 0) := "0100000000010000";
SIGNAL inst1_alpm_rom_component_asrom_asegment_a0_a_a5_a_modesel : std_logic_vector(15 DOWNTO 0) := "0100000000010000";
SIGNAL inst1_alpm_rom_component_asrom_asegment_a0_a_a1_a_modesel : std_logic_vector(15 DOWNTO 0) := "0100000000010000";
SIGNAL inst1_alpm_rom_component_asrom_asegment_a0_a_a6_a_modesel : std_logic_vector(15 DOWNTO 0) := "0100000000010000";
SIGNAL rtl_a6788_1 : std_logic;
SIGNAL rtl_a6541_1 : std_logic;
SIGNAL rtl_a6832_1 : std_logic;
SIGNAL inst_aI3_adata_x_a1_a_a199_1 : std_logic;
SIGNAL inst_aI3_adata_x_a1_a_a769_1 : std_logic;
SIGNAL inst_aI3_adata_x_a0_a_a269_1 : std_logic;
SIGNAL inst_aI3_adata_x_a0_a_a770_1 : std_logic;
SIGNAL nreset_apadio : std_logic;
SIGNAL clk_apadio : std_logic;
SIGNAL CTRL_DATA_IN_a3_a_apadio : std_logic;
SIGNAL CTRL_DATA_IN_a2_a_apadio : std_logic;
SIGNAL CTRL_DATA_IN_a1_a_apadio : std_logic;
SIGNAL CTRL_DATA_IN_a0_a_apadio : std_logic;
SIGNAL pwm_out_apadio : std_logic;
SIGNAL CPU_DADDR_OUT_a5_a_apadio : std_logic;
SIGNAL CPU_DADDR_OUT_a4_a_apadio : std_logic;
SIGNAL CPU_DADDR_OUT_a3_a_apadio : std_logic;
SIGNAL CPU_DADDR_OUT_a2_a_apadio : std_logic;
SIGNAL CPU_DADDR_OUT_a1_a_apadio : std_logic;
SIGNAL CPU_DADDR_OUT_a0_a_apadio : std_logic;
SIGNAL nWE_CPU_apadio : std_logic;
SIGNAL nRE_CPU_apadio : std_logic;
SIGNAL CPU_DATA_OUT_a3_a_apadio : std_logic;
SIGNAL CPU_DATA_OUT_a2_a_apadio : std_logic;
SIGNAL CPU_DATA_OUT_a1_a_apadio : std_logic;
SIGNAL CPU_DATA_OUT_a0_a_apadio : std_logic;
SIGNAL CPU_IADDR_OUT_a7_a_apadio : std_logic;
SIGNAL CPU_IADDR_OUT_a6_a_apadio : std_logic;
SIGNAL CPU_IADDR_OUT_a5_a_apadio : std_logic;
SIGNAL CPU_IADDR_OUT_a4_a_apadio : std_logic;
SIGNAL CPU_IADDR_OUT_a3_a_apadio : std_logic;
SIGNAL CPU_IADDR_OUT_a2_a_apadio : std_logic;
SIGNAL CPU_IADDR_OUT_a1_a_apadio : std_logic;
SIGNAL CPU_IADDR_OUT_a0_a_apadio : std_logic;
SIGNAL CTRL_DATA_OUT_a3_a_apadio : std_logic;
SIGNAL CTRL_DATA_OUT_a2_a_apadio : std_logic;
SIGNAL CTRL_DATA_OUT_a1_a_apadio : std_logic;
SIGNAL CTRL_DATA_OUT_a0_a_apadio : std_logic;
SIGNAL nreset_adataout : std_logic;
SIGNAL clk_adataout : std_logic;
SIGNAL inst_aI1_anreset_v_rtl_3_awysi_counter_aq_a0_a : std_logic;
SIGNAL inst_aI1_aLessThan_7_a5 : std_logic;
SIGNAL inst_aI1_anreset_v_rtl_3_awysi_counter_acounter_cell_a0_a_aCOUT : std_logic;
SIGNAL inst_aI1_anreset_v_rtl_3_awysi_counter_aq_a1_a : std_logic;
SIGNAL inst_aI1_ai_a2 : std_logic;
SIGNAL inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a0_a : std_logic;
SIGNAL inst_aI2_aLessThan_7_a5 : std_logic;
SIGNAL inst_aI2_anreset_v_rtl_2_awysi_counter_acounter_cell_a0_a_aCOUT : std_logic;
SIGNAL inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a : std_logic;
SIGNAL inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a0_a : std_logic;
SIGNAL inst_aI3_ai_a128 : std_logic;
SIGNAL inst_aI3_anreset_v_rtl_1_awysi_counter_acounter_cell_a0_a_aCOUT : std_logic;
SIGNAL inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a1_a : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a2_a_a33 : std_logic;
SIGNAL inst1_alpm_rom_component_asrom_aq_a3_a : std_logic;
SIGNAL rtl_a6467 : std_logic;
SIGNAL inst1_alpm_rom_component_asrom_aq_a4_a : std_logic;
SIGNAL inst_aI2_aMux_52_a0 : std_logic;
SIGNAL inst_aI2_aTD_c_a2_a : std_logic;
SIGNAL inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a0_a : std_logic;
SIGNAL inst_aI4_aLessThan_7_a5 : std_logic;
SIGNAL inst_aI4_anreset_v_rtl_0_awysi_counter_acounter_cell_a0_a_aCOUT : std_logic;
SIGNAL inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a : std_logic;
SIGNAL inst_aI5_adaddr_c_a1_a : std_logic;
SIGNAL inst_aI4_adaddr_x_a1_a_a4 : std_logic;
SIGNAL inst_aI2_andre_x_a45 : std_logic;
SIGNAL inst_aI2_aTC_x_a1_a_a1 : std_logic;
SIGNAL inst_aI2_aTC_x_a0_a_a120 : std_logic;
SIGNAL inst_aI2_aC_store_x_a68 : std_logic;
SIGNAL inst_aI2_aC_mem_x_a0 : std_logic;
SIGNAL inst_aI2_andre_x_a47 : std_logic;
SIGNAL inst_aI4_andre_x_a1 : std_logic;
SIGNAL inst_aI5_adaddr_c_a4_a : std_logic;
SIGNAL inst_aI4_adaddr_x_a4_a_a1 : std_logic;
SIGNAL inst_aI5_adaddr_c_a2_a : std_logic;
SIGNAL inst_aI4_ai_a2 : std_logic;
SIGNAL inst_aI5_ai_a17 : std_logic;
SIGNAL inst6_areduce_nor_30_a12 : std_logic;
SIGNAL inst_aI5_adaddr_c_a3_a : std_logic;
SIGNAL inst_aI5_ai_a14 : std_logic;
SIGNAL inst_aI5_adaddr_c_a0_a : std_logic;
SIGNAL inst_aI5_ai_a23 : std_logic;
SIGNAL inst6_areduce_nor_30_a8 : std_logic;
SIGNAL inst6_amux_c_a0_a : std_logic;
SIGNAL inst_aI4_adata_ox_a1_a_a2 : std_logic;
SIGNAL inst6_actrl_data_c_a3_a_a19 : std_logic;
SIGNAL inst6_ai_a32 : std_logic;
SIGNAL inst_aI5_ai_a20 : std_logic;
SIGNAL inst2_alpm_ram_dq_component_asram_aq_a1_a : std_logic;
SIGNAL CTRL_DATA_IN_a1_a_adataout : std_logic;
SIGNAL inst_aI2_aTC_x_a2_a_a109 : std_logic;
SIGNAL inst_aI2_aTC_c_a2_a : std_logic;
SIGNAL inst_aI3_adata_x_a3_a_a597 : std_logic;
SIGNAL inst_aI3_adata_x_a1_a_a602 : std_logic;
SIGNAL inst_aI2_adata_is_c_a1_a : std_logic;
SIGNAL inst_aI3_adata_x_a1_a_a199 : std_logic;
SIGNAL inst_aI3_adata_x_a1_a_a769 : std_logic;
SIGNAL inst_aI3_adata_x_a1_a_a767 : std_logic;
SIGNAL inst_aI3_ai_a9 : std_logic;
SIGNAL inst_aI2_aMux_54_a0 : std_logic;
SIGNAL inst_aI2_aTD_c_a0_a : std_logic;
SIGNAL inst_aI4_adata_ox_a0_a_a3 : std_logic;
SIGNAL inst2_alpm_ram_dq_component_asram_aq_a0_a : std_logic;
SIGNAL CTRL_DATA_IN_a0_a_adataout : std_logic;
SIGNAL inst_aI2_adata_is_c_a0_a : std_logic;
SIGNAL inst_aI3_adata_x_a0_a_a269 : std_logic;
SIGNAL inst_aI3_adata_x_a0_a_a770 : std_logic;
SIGNAL inst_aI3_adata_x_a0_a_a768 : std_logic;
SIGNAL inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a1_a_a37 : std_logic;
SIGNAL inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a2_a_a33 : std_logic;
SIGNAL inst_aI2_aMux_53_a0 : std_logic;
SIGNAL inst_aI2_aTD_c_a1_a : std_logic;
SIGNAL inst_aI3_aadd_89_aadder_aresult_node_acout_a0_a : std_logic;
SIGNAL inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a1_a : std_logic;
SIGNAL inst_aI3_aMux_121_rtl_43_rtl_258_a0 : std_logic;
SIGNAL inst_aI3_ai_a13 : std_logic;
SIGNAL inst_aI3_aMux_121_rtl_43_rtl_258_a1 : std_logic;
SIGNAL rtl_a1490 : std_logic;
SIGNAL inst_aI2_adata_is_c_a2_a : std_logic;
SIGNAL inst_aI3_adata_x_a2_a_a12 : std_logic;
SIGNAL CTRL_DATA_IN_a2_a_adataout : std_logic;
SIGNAL inst_aI4_adata_ox_a2_a_a1 : std_logic;
SIGNAL inst2_alpm_ram_dq_component_asram_aq_a2_a : std_logic;
SIGNAL inst_aI3_adata_x_a2_a_a600 : std_logic;
SIGNAL inst_aI4_areduce_nor_27_a23 : std_logic;
SIGNAL inst_aI3_adata_x_a2_a_a668 : std_logic;
SIGNAL inst_aI4_ai_a397 : std_logic;
SIGNAL inst_aI4_ai_a385 : std_logic;
SIGNAL inst_aI4_ai_a254 : std_logic;
SIGNAL inst_aI3_adata_x_a2_a_a13 : std_logic;
SIGNAL inst_aI3_ai_a10 : std_logic;
SIGNAL inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a2_a_a29 : std_logic;
SIGNAL inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a3_a_a25 : std_logic;
SIGNAL inst_aI3_aadd_89_aadder_aresult_node_acout_a1_a : std_logic;
SIGNAL inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a2_a : std_logic;
SIGNAL inst_aI3_aMux_120_rtl_37_rtl_252_a0 : std_logic;
SIGNAL inst_aI3_ai_a14 : std_logic;
SIGNAL inst_aI3_aMux_120_rtl_37_rtl_252_a1 : std_logic;
SIGNAL rtl_a1480 : std_logic;
SIGNAL inst_aI2_adata_is_c_a3_a : std_logic;
SIGNAL inst_aI3_adata_x_a3_a_a9 : std_logic;
SIGNAL CTRL_DATA_IN_a3_a_adataout : std_logic;
SIGNAL inst_aI4_adata_ox_a3_a_a0 : std_logic;
SIGNAL inst2_alpm_ram_dq_component_asram_aq_a3_a : std_logic;
SIGNAL inst_aI3_adata_x_a3_a_a599 : std_logic;
SIGNAL inst_aI3_adata_x_a3_a_a633 : std_logic;
SIGNAL inst_aI3_adata_x_a3_a_a10 : std_logic;
SIGNAL inst_aI3_ai_a11 : std_logic;
SIGNAL inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a3_a_a21 : std_logic;
SIGNAL inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a4_a_a17 : std_logic;
SIGNAL inst_aI3_aadd_89_aadder_aresult_node_acout_a2_a : std_logic;
SIGNAL inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a3_a : std_logic;
SIGNAL inst_aI3_aMux_119_rtl_31_rtl_246_a0 : std_logic;
SIGNAL inst_aI3_ai_a15 : std_logic;
SIGNAL inst_aI3_aMux_119_rtl_31_rtl_246_a1 : std_logic;
SIGNAL rtl_a1470 : std_logic;
SIGNAL inst_aI3_aMux_141_rtl_83_a0 : std_logic;
SIGNAL inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a4_a_a13 : std_logic;
SIGNAL inst_aI3_aadd_89_aadder_aresult_node_acout_a3_a : std_logic;
SIGNAL rtl_a1680 : std_logic;
SIGNAL rtl_a1691 : std_logic;
SIGNAL rtl_a1685 : std_logic;
SIGNAL rtl_a1690 : std_logic;
SIGNAL rtl_a1400 : std_logic;
SIGNAL rtl_a1468 : std_logic;
SIGNAL inst_aI3_aacc_c_a0_a_a4_a : std_logic;
SIGNAL rtl_a1408 : std_logic;
SIGNAL rtl_a1475 : std_logic;
SIGNAL rtl_a6632 : std_logic;
SIGNAL rtl_a1018 : std_logic;
SIGNAL rtl_a1338 : std_logic;
SIGNAL inst_aI3_aacc_c_a0_a_a3_a : std_logic;
SIGNAL rtl_a1419 : std_logic;
SIGNAL rtl_a1485 : std_logic;
SIGNAL rtl_a6672 : std_logic;
SIGNAL rtl_a1030 : std_logic;
SIGNAL rtl_a1353 : std_logic;
SIGNAL inst_aI3_aacc_c_a0_a_a2_a : std_logic;
SIGNAL rtl_a1430 : std_logic;
SIGNAL rtl_a1495 : std_logic;
SIGNAL rtl_a6719 : std_logic;
SIGNAL rtl_a6695 : std_logic;
SIGNAL rtl_a1368 : std_logic;
SIGNAL inst_aI3_aacc_c_a0_a_a1_a : std_logic;
SIGNAL inst_aI4_aipage_we_c : std_logic;
SIGNAL inst_aI4_aipage_c_a1_a : std_logic;
SIGNAL rtl_a549 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a7_a : std_logic;
SIGNAL rtl_a1227 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a7_a : std_logic;
SIGNAL rtl_a1147 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a7_a : std_logic;
SIGNAL rtl_a1067 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a7_a : std_logic;
SIGNAL inst_aI1_apc_a7_a : std_logic;
SIGNAL rtl_a552 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a6_a : std_logic;
SIGNAL rtl_a1237 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a6_a : std_logic;
SIGNAL rtl_a1157 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a6_a : std_logic;
SIGNAL rtl_a555 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a5_a : std_logic;
SIGNAL rtl_a1247 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a5_a : std_logic;
SIGNAL rtl_a1167 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a5_a : std_logic;
SIGNAL rtl_a558 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a4_a : std_logic;
SIGNAL rtl_a1257 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a4_a : std_logic;
SIGNAL rtl_a1177 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a4_a : std_logic;
SIGNAL rtl_a561 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a3_a : std_logic;
SIGNAL rtl_a1267 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a3_a : std_logic;
SIGNAL rtl_a1187 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a3_a : std_logic;
SIGNAL rtl_a567 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a1_a : std_logic;
SIGNAL rtl_a1287 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a1_a : std_logic;
SIGNAL rtl_a1207 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a1_a : std_logic;
SIGNAL inst_aI1_apc_a0_a : std_logic;
SIGNAL inst_aI1_aadd_87_aadder_aresult_node_acout_a0_a : std_logic;
SIGNAL inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a1_a : std_logic;
SIGNAL rtl_a1127 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a1_a : std_logic;
SIGNAL inst_aI1_apc_a1_a : std_logic;
SIGNAL inst_aI1_aadd_87_aadder_aresult_node_acout_a1_a : std_logic;
SIGNAL inst_aI1_aadd_87_aadder_aresult_node_acout_a2_a : std_logic;
SIGNAL inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a3_a : std_logic;
SIGNAL rtl_a1107 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a3_a : std_logic;
SIGNAL inst_aI1_apc_a3_a : std_logic;
SIGNAL inst_aI1_aadd_87_aadder_aresult_node_acout_a3_a : std_logic;
SIGNAL inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a4_a : std_logic;
SIGNAL rtl_a1097 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a4_a : std_logic;
SIGNAL inst_aI1_apc_a4_a : std_logic;
SIGNAL inst_aI1_aadd_87_aadder_aresult_node_acout_a4_a : std_logic;
SIGNAL inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a5_a : std_logic;
SIGNAL rtl_a1087 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a5_a : std_logic;
SIGNAL inst_aI1_apc_a5_a : std_logic;
SIGNAL inst_aI1_aadd_87_aadder_aresult_node_acout_a5_a : std_logic;
SIGNAL inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a6_a : std_logic;
SIGNAL rtl_a1077 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a6_a : std_logic;
SIGNAL inst_aI1_apc_a6_a : std_logic;
SIGNAL inst_aI1_aadd_87_aadder_aresult_node_acout_a6_a : std_logic;
SIGNAL inst_aI1_aadd_87_aadder_aunreg_res_node_a7_a : std_logic;
SIGNAL inst_aI2_ai_a519 : std_logic;
SIGNAL inst_aI2_aC_jmp_a85 : std_logic;
SIGNAL inst_aI2_ai_a490 : std_logic;
SIGNAL inst_aI2_ai_a494 : std_logic;
SIGNAL inst_aI2_apc_mux_x_a0_a_a8 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a7_a_a154 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a7_a_a166 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a7_a_a170 : std_logic;
SIGNAL inst1_alpm_rom_component_asrom_aq_a2_a : std_logic;
SIGNAL inst_aI2_aTC_x_a2_a_a225 : std_logic;
SIGNAL inst_aI2_aTC_x_a0_a_a114 : std_logic;
SIGNAL inst_aI2_aTC_x_a0_a_a121 : std_logic;
SIGNAL inst_aI2_aTC_c_a0_a : std_logic;
SIGNAL inst_aI2_aTD_c_a3_a : std_logic;
SIGNAL rtl_a6586 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a3_a_a2125 : std_logic;
SIGNAL rtl_a1057 : std_logic;
SIGNAL inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a0_a : std_logic;
SIGNAL rtl_a6745 : std_logic;
SIGNAL rtl_a1054 : std_logic;
SIGNAL rtl_a1447 : std_logic;
SIGNAL rtl_a1446 : std_logic;
SIGNAL rtl_a6768 : std_logic;
SIGNAL inst_aI3_ai_a8 : std_logic;
SIGNAL inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a1_a_a40 : std_logic;
SIGNAL inst_aI3_aMux_122_rtl_49_rtl_264_a0 : std_logic;
SIGNAL inst_aI3_ai_a12 : std_logic;
SIGNAL inst_aI3_aMux_122_rtl_49_rtl_264_a1 : std_logic;
SIGNAL rtl_a824 : std_logic;
SIGNAL rtl_a6788 : std_logic;
SIGNAL rtl_a6831 : std_logic;
SIGNAL rtl_a1456 : std_logic;
SIGNAL inst_aI3_aacc_c_a0_a_a0_a : std_logic;
SIGNAL inst_aI4_aipage_c_a0_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a6_a_a171 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a6_a_a183 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a6_a_a187 : std_logic;
SIGNAL inst1_alpm_rom_component_asrom_aq_a9_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a5_a_a188 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a5_a_a200 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a5_a_a204 : std_logic;
SIGNAL inst1_alpm_rom_component_asrom_aq_a8_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a4_a_a205 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a4_a_a217 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a4_a_a221 : std_logic;
SIGNAL inst1_alpm_rom_component_asrom_aq_a7_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a3_a_a222 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a3_a_a234 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a3_a_a238 : std_logic;
SIGNAL inst1_alpm_rom_component_asrom_aq_a0_a : std_logic;
SIGNAL inst_aI2_aMux_58_a0 : std_logic;
SIGNAL inst_aI2_aTC_c_a1_a : std_logic;
SIGNAL inst_aI2_aC_raw_a28 : std_logic;
SIGNAL inst_aI3_askip_l_a196 : std_logic;
SIGNAL rtl_a6550 : std_logic;
SIGNAL inst_aI3_areduce_nor_59_a11 : std_logic;
SIGNAL rtl_a6541 : std_logic;
SIGNAL rtl_a6832 : std_logic;
SIGNAL rtl_a6830 : std_logic;
SIGNAL inst_aI2_askip_c : std_logic;
SIGNAL inst_aI2_aC_raw_a13 : std_logic;
SIGNAL inst_aI2_avalid_c : std_logic;
SIGNAL inst_aI3_ai_a135 : std_logic;
SIGNAL inst_aI3_askip_l_a1 : std_logic;
SIGNAL inst_aI2_apc_mux_x_a2_a_a47 : std_logic;
SIGNAL inst_aI2_apc_mux_x_a1_a_a46 : std_logic;
SIGNAL inst_aI1_aMux_89_rtl_60_a0 : std_logic;
SIGNAL rtl_a564 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a2_a : std_logic;
SIGNAL rtl_a1277 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a2_a : std_logic;
SIGNAL rtl_a1197 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a2_a : std_logic;
SIGNAL rtl_a1117 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a2_a : std_logic;
SIGNAL inst_aI1_apc_a2_a : std_logic;
SIGNAL inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a2_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a2_a_a239 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a2_a_a251 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a2_a_a255 : std_logic;
SIGNAL inst1_alpm_rom_component_asrom_aq_a5_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a1_a_a256 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a1_a_a268 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a1_a_a272 : std_logic;
SIGNAL inst1_alpm_rom_component_asrom_aq_a1_a : std_logic;
SIGNAL inst_aI2_aTD_x_a3_a_a9 : std_logic;
SIGNAL inst_aI2_aTC_x_a2_a_a113 : std_logic;
SIGNAL inst_aI2_apc_mux_x_a2_a_a24 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a7_a_a2010 : std_logic;
SIGNAL rtl_a570 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a0_a : std_logic;
SIGNAL rtl_a1297 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a0_a : std_logic;
SIGNAL rtl_a1217 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a0_a : std_logic;
SIGNAL rtl_a1137 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a0_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a0_a_a278 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a0_a_a283 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a0_a_a289 : std_logic;
SIGNAL inst1_alpm_rom_component_asrom_aq_a6_a : std_logic;
SIGNAL inst_aI4_areduce_nor_24_a14 : std_logic;
SIGNAL inst_aI2_andre_x_a46 : std_logic;
SIGNAL inst_aI5_andwe_c : std_logic;
SIGNAL inst6_areduce_nor_27 : std_logic;
SIGNAL inst6_actrl_data_c_a3_a_a8 : std_logic;
SIGNAL inst6_actrl_data_c_a0_a : std_logic;
SIGNAL inst6_areduce_nor_30 : std_logic;
SIGNAL inst6_ai_a145 : std_logic;
SIGNAL inst6_ai_a125 : std_logic;
SIGNAL inst6_apwm_data_c_a3_a_a68 : std_logic;
SIGNAL inst6_apwm_data_c_a3_a_a48 : std_logic;
SIGNAL inst6_ai_a101 : std_logic;
SIGNAL inst5_ai_a0 : std_logic;
SIGNAL inst6_apwm_data_c_a3_a_a30 : std_logic;
SIGNAL inst6_ai_a120 : std_logic;
SIGNAL inst6_ai_a121 : std_logic;
SIGNAL inst6_ai_a164 : std_logic;
SIGNAL inst6_ai_a117 : std_logic;
SIGNAL inst6_apwm_data_c_a3_a : std_logic;
SIGNAL inst5_apwm_low_a7_a : std_logic;
SIGNAL inst6_apwm_data_c_a2_a : std_logic;
SIGNAL inst5_apwm_low_a6_a : std_logic;
SIGNAL inst6_apwm_data_c_a1_a : std_logic;
SIGNAL inst5_apwm_low_a5_a : std_logic;
SIGNAL inst6_apwm_data_c_a0_a : std_logic;
SIGNAL inst5_apwm_low_a4_a : std_logic;
SIGNAL inst5_apwm_low_a3_a : std_logic;
SIGNAL inst5_apwm_low_a2_a : std_logic;
SIGNAL inst5_apwm_low_a1_a : std_logic;
SIGNAL inst5_apwm_low_a0_a : std_logic;
SIGNAL inst5_apwm_period_a7_a_a87 : std_logic;
SIGNAL inst5_apwm_period_a7_a : std_logic;
SIGNAL inst5_apwm_period_a6_a : std_logic;
SIGNAL inst5_apwm_period_a5_a : std_logic;
SIGNAL inst5_apwm_period_a4_a : std_logic;
SIGNAL inst5_apwm_period_a3_a : std_logic;
SIGNAL inst5_apwm_period_a2_a : std_logic;
SIGNAL inst5_apwm_period_a1_a : std_logic;
SIGNAL inst5_apwm_period_a0_a : std_logic;
SIGNAL inst5_aadd_20_aadder_aresult_node_acout_a1_a : std_logic;
SIGNAL inst5_aadd_20_aadder_aresult_node_acout_a2_a : std_logic;
SIGNAL inst5_aadd_20_aadder_aresult_node_acout_a3_a : std_logic;
SIGNAL inst5_aadd_20_aadder_aresult_node_acout_a4_a : std_logic;
SIGNAL inst5_aadd_20_aadder_aresult_node_acout_a5_a : std_logic;
SIGNAL inst5_aadd_20_aadder_aresult_node_acout_a6_a : std_logic;
SIGNAL inst5_aadd_20_aadder_aresult_node_acout_a7_a : std_logic;
SIGNAL inst5_aadd_20_aadder_aunreg_res_node_a8_a : std_logic;
SIGNAL inst5_aadd_36_aadder_aresult_node_acout_a1_a : std_logic;
SIGNAL inst5_aadd_36_aadder_aresult_node_acout_a2_a : std_logic;
SIGNAL inst5_aadd_36_aadder_aresult_node_acout_a3_a : std_logic;
SIGNAL inst5_aadd_36_aadder_aresult_node_acout_a4_a : std_logic;
SIGNAL inst5_aadd_36_aadder_aresult_node_acout_a5_a : std_logic;
SIGNAL inst5_aadd_36_aadder_aresult_node_acout_a6_a : std_logic;
SIGNAL inst5_aadd_36_aadder_aresult_node_acout_a7_a : std_logic;
SIGNAL inst5_aadd_36_aadder_aunreg_res_node_a8_a : std_logic;
SIGNAL inst5_ai_a180 : std_logic;
SIGNAL inst5_apwm_high_a7_a : std_logic;
SIGNAL inst5_aadd_20_aadder_aresult_node_acs_buffer_a7_a : std_logic;
SIGNAL inst5_aadd_36_aadder_aresult_node_acs_buffer_a7_a : std_logic;
SIGNAL inst5_ai_a190 : std_logic;
SIGNAL inst5_apwm_high_a6_a : std_logic;
SIGNAL inst5_aadd_20_aadder_aresult_node_acs_buffer_a6_a : std_logic;
SIGNAL inst5_aadd_36_aadder_aresult_node_acs_buffer_a6_a : std_logic;
SIGNAL inst5_ai_a200 : std_logic;
SIGNAL inst5_apwm_high_a5_a : std_logic;
SIGNAL inst5_aadd_20_aadder_aresult_node_acs_buffer_a5_a : std_logic;
SIGNAL inst5_aadd_36_aadder_aresult_node_acs_buffer_a5_a : std_logic;
SIGNAL inst5_ai_a210 : std_logic;
SIGNAL inst5_apwm_high_a4_a : std_logic;
SIGNAL inst5_aadd_20_aadder_aresult_node_acs_buffer_a4_a : std_logic;
SIGNAL inst5_aadd_36_aadder_aresult_node_acs_buffer_a4_a : std_logic;
SIGNAL inst5_ai_a220 : std_logic;
SIGNAL inst5_apwm_high_a3_a : std_logic;
SIGNAL inst5_aadd_20_aadder_aresult_node_acs_buffer_a3_a : std_logic;
SIGNAL inst5_aadd_36_aadder_aresult_node_acs_buffer_a3_a : std_logic;
SIGNAL inst5_ai_a230 : std_logic;
SIGNAL inst5_apwm_high_a2_a : std_logic;
SIGNAL inst5_aadd_20_aadder_aresult_node_acs_buffer_a2_a : std_logic;
SIGNAL inst5_aadd_36_aadder_aresult_node_acs_buffer_a2_a : std_logic;
SIGNAL inst5_ai_a240 : std_logic;
SIGNAL inst5_apwm_high_a1_a : std_logic;
SIGNAL inst5_aadd_36_aadder_aresult_node_acs_buffer_a1_a : std_logic;
SIGNAL inst5_ai_a250 : std_logic;
SIGNAL inst5_aadd_20_aadder_aresult_node_acs_buffer_a1_a : std_logic;
SIGNAL inst5_apwm_high_a0_a : std_logic;
SIGNAL inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a0_a_aCOUT : std_logic;
SIGNAL inst5_apwm_count_rtl_4_awysi_counter_aq_a1_a : std_logic;
SIGNAL inst5_aLessThan_82_a81 : std_logic;
SIGNAL inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a1_a_aCOUT : std_logic;
SIGNAL inst5_apwm_count_rtl_4_awysi_counter_aq_a2_a : std_logic;
SIGNAL inst5_aLessThan_82_a96 : std_logic;
SIGNAL inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a2_a_aCOUT : std_logic;
SIGNAL inst5_apwm_count_rtl_4_awysi_counter_aq_a3_a : std_logic;
SIGNAL inst5_aLessThan_82_a101 : std_logic;
SIGNAL inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a3_a_aCOUT : std_logic;
SIGNAL inst5_apwm_count_rtl_4_awysi_counter_aq_a4_a : std_logic;
SIGNAL inst5_aLessThan_82_a103 : std_logic;
SIGNAL inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a4_a_aCOUT : std_logic;
SIGNAL inst5_apwm_count_rtl_4_awysi_counter_aq_a5_a : std_logic;
SIGNAL inst5_aLessThan_82_a108 : std_logic;
SIGNAL inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a5_a_aCOUT : std_logic;
SIGNAL inst5_apwm_count_rtl_4_awysi_counter_aq_a6_a : std_logic;
SIGNAL inst5_aLessThan_82_a110 : std_logic;
SIGNAL inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a6_a_aCOUT : std_logic;
SIGNAL inst5_apwm_count_rtl_4_awysi_counter_aq_a7_a : std_logic;
SIGNAL inst5_aLessThan_82_a115 : std_logic;
SIGNAL inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16 : std_logic;
SIGNAL inst5_apwm_count_rtl_4_awysi_counter_aq_a0_a : std_logic;
SIGNAL inst5_aLessThan_79_a81 : std_logic;
SIGNAL inst5_aLessThan_79_a96 : std_logic;
SIGNAL inst5_aLessThan_79_a101 : std_logic;
SIGNAL inst5_aLessThan_79_a103 : std_logic;
SIGNAL inst5_aLessThan_79_a108 : std_logic;
SIGNAL inst5_aLessThan_79_a110 : std_logic;
SIGNAL inst5_aLessThan_79_a115 : std_logic;
SIGNAL inst5_apwm_c_a19 : std_logic;
SIGNAL inst5_apwm_c : std_logic;
SIGNAL inst_aI5_adaddr_c_a5_a : std_logic;
SIGNAL inst_aI5_ai_a8 : std_logic;
SIGNAL inst_aI5_ai_a11 : std_logic;
SIGNAL inst6_actrl_data_c_a3_a : std_logic;
SIGNAL inst6_actrl_data_c_a2_a : std_logic;
SIGNAL inst6_actrl_data_c_a1_a : std_logic;
SIGNAL NOT_nreset_adataout : std_logic;
SIGNAL NOT_inst_aI5_andwe_c : std_logic;

BEGIN

ww_nreset <= nreset;
ww_clk <= clk;
ww_CTRL_DATA_IN <= CTRL_DATA_IN;
pwm_out <= ww_pwm_out;
CPU_DADDR_OUT <= ww_CPU_DADDR_OUT;
nWE_CPU <= ww_nWE_CPU;
nRE_CPU <= ww_nRE_CPU;
CPU_DATA_OUT <= ww_CPU_DATA_OUT;
CPU_IADDR_OUT <= ww_CPU_IADDR_OUT;
CTRL_DATA_OUT <= ww_CTRL_DATA_OUT;

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a9_a_waddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a9_a_raddr <= (gnd & gnd & gnd & inst_aI1_aiaddr_x_a7_a_a170 & inst_aI1_aiaddr_x_a6_a_a187 & inst_aI1_aiaddr_x_a5_a_a204 & inst_aI1_aiaddr_x_a4_a_a221 & inst_aI1_aiaddr_x_a3_a_a238 & 
inst_aI1_aiaddr_x_a2_a_a255 & inst_aI1_aiaddr_x_a1_a_a272 & inst_aI1_aiaddr_x_a0_a_a289);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a6_a_waddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a6_a_raddr <= (gnd & gnd & gnd & inst_aI1_aiaddr_x_a7_a_a170 & inst_aI1_aiaddr_x_a6_a_a187 & inst_aI1_aiaddr_x_a5_a_a204 & inst_aI1_aiaddr_x_a4_a_a221 & inst_aI1_aiaddr_x_a3_a_a238 & 
inst_aI1_aiaddr_x_a2_a_a255 & inst_aI1_aiaddr_x_a1_a_a272 & inst_aI1_aiaddr_x_a0_a_a289);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a5_a_waddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a5_a_raddr <= (gnd & gnd & gnd & inst_aI1_aiaddr_x_a7_a_a170 & inst_aI1_aiaddr_x_a6_a_a187 & inst_aI1_aiaddr_x_a5_a_a204 & inst_aI1_aiaddr_x_a4_a_a221 & inst_aI1_aiaddr_x_a3_a_a238 & 
inst_aI1_aiaddr_x_a2_a_a255 & inst_aI1_aiaddr_x_a1_a_a272 & inst_aI1_aiaddr_x_a0_a_a289);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a4_a_waddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a4_a_raddr <= (gnd & gnd & gnd & inst_aI1_aiaddr_x_a7_a_a170 & inst_aI1_aiaddr_x_a6_a_a187 & inst_aI1_aiaddr_x_a5_a_a204 & inst_aI1_aiaddr_x_a4_a_a221 & inst_aI1_aiaddr_x_a3_a_a238 & 
inst_aI1_aiaddr_x_a2_a_a255 & inst_aI1_aiaddr_x_a1_a_a272 & inst_aI1_aiaddr_x_a0_a_a289);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a7_a_waddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a7_a_raddr <= (gnd & gnd & gnd & inst_aI1_aiaddr_x_a7_a_a170 & inst_aI1_aiaddr_x_a6_a_a187 & inst_aI1_aiaddr_x_a5_a_a204 & inst_aI1_aiaddr_x_a4_a_a221 & inst_aI1_aiaddr_x_a3_a_a238 & 
inst_aI1_aiaddr_x_a2_a_a255 & inst_aI1_aiaddr_x_a1_a_a272 & inst_aI1_aiaddr_x_a0_a_a289);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a8_a_waddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a8_a_raddr <= (gnd & gnd & gnd & inst_aI1_aiaddr_x_a7_a_a170 & inst_aI1_aiaddr_x_a6_a_a187 & inst_aI1_aiaddr_x_a5_a_a204 & inst_aI1_aiaddr_x_a4_a_a221 & inst_aI1_aiaddr_x_a3_a_a238 & 
inst_aI1_aiaddr_x_a2_a_a255 & inst_aI1_aiaddr_x_a1_a_a272 & inst_aI1_aiaddr_x_a0_a_a289);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a0_a_waddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a0_a_raddr <= (gnd & gnd & gnd & inst_aI1_aiaddr_x_a7_a_a170 & inst_aI1_aiaddr_x_a6_a_a187 & inst_aI1_aiaddr_x_a5_a_a204 & inst_aI1_aiaddr_x_a4_a_a221 & inst_aI1_aiaddr_x_a3_a_a238 & 
inst_aI1_aiaddr_x_a2_a_a255 & inst_aI1_aiaddr_x_a1_a_a272 & inst_aI1_aiaddr_x_a0_a_a289);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a1_a_waddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a1_a_raddr <= (gnd & gnd & gnd & inst_aI1_aiaddr_x_a7_a_a170 & inst_aI1_aiaddr_x_a6_a_a187 & inst_aI1_aiaddr_x_a5_a_a204 & inst_aI1_aiaddr_x_a4_a_a221 & inst_aI1_aiaddr_x_a3_a_a238 & 
inst_aI1_aiaddr_x_a2_a_a255 & inst_aI1_aiaddr_x_a1_a_a272 & inst_aI1_aiaddr_x_a0_a_a289);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a2_a_waddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a2_a_raddr <= (gnd & gnd & gnd & inst_aI1_aiaddr_x_a7_a_a170 & inst_aI1_aiaddr_x_a6_a_a187 & inst_aI1_aiaddr_x_a5_a_a204 & inst_aI1_aiaddr_x_a4_a_a221 & inst_aI1_aiaddr_x_a3_a_a238 & 
inst_aI1_aiaddr_x_a2_a_a255 & inst_aI1_aiaddr_x_a1_a_a272 & inst_aI1_aiaddr_x_a0_a_a289);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a3_a_waddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd);

ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a3_a_raddr <= (gnd & gnd & gnd & inst_aI1_aiaddr_x_a7_a_a170 & inst_aI1_aiaddr_x_a6_a_a187 & inst_aI1_aiaddr_x_a5_a_a204 & inst_aI1_aiaddr_x_a4_a_a221 & inst_aI1_aiaddr_x_a3_a_a238 & 
inst_aI1_aiaddr_x_a2_a_a255 & inst_aI1_aiaddr_x_a1_a_a272 & inst_aI1_aiaddr_x_a0_a_a289);

ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a3_a_waddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & inst_aI5_ai_a14 & inst_aI5_ai_a17 & inst_aI5_ai_a20 & inst_aI5_ai_a23);

ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a3_a_raddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & inst_aI5_ai_a14 & inst_aI5_ai_a17 & inst_aI5_ai_a20 & inst_aI5_ai_a23);

ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a2_a_waddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & inst_aI5_ai_a14 & inst_aI5_ai_a17 & inst_aI5_ai_a20 & inst_aI5_ai_a23);

ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a2_a_raddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & inst_aI5_ai_a14 & inst_aI5_ai_a17 & inst_aI5_ai_a20 & inst_aI5_ai_a23);

ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a1_a_waddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & inst_aI5_ai_a14 & inst_aI5_ai_a17 & inst_aI5_ai_a20 & inst_aI5_ai_a23);

ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a1_a_raddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & inst_aI5_ai_a14 & inst_aI5_ai_a17 & inst_aI5_ai_a20 & inst_aI5_ai_a23);

ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a0_a_waddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & inst_aI5_ai_a14 & inst_aI5_ai_a17 & inst_aI5_ai_a20 & inst_aI5_ai_a23);

ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a0_a_raddr <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & inst_aI5_ai_a14 & inst_aI5_ai_a17 & inst_aI5_ai_a20 & inst_aI5_ai_a23);
NOT_nreset_adataout <= NOT nreset_adataout;
NOT_inst_aI5_andwe_c <= NOT inst_aI5_andwe_c;

nreset_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_nreset,
	dataout => nreset_adataout);

clk_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_clk,
	dataout => clk_adataout);

inst_aI1_anreset_v_rtl_3_awysi_counter_acounter_cell_a0_a : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_anreset_v_rtl_3_awysi_counter_aq_a0_a = DFFEA((!inst_aI1_anreset_v_rtl_3_awysi_counter_aq_a0_a & inst_aI1_aLessThan_7_a5) # (VCC & !inst_aI1_aLessThan_7_a5), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )
-- inst_aI1_anreset_v_rtl_3_awysi_counter_acounter_cell_a0_a_aCOUT = CARRY(inst_aI1_anreset_v_rtl_3_awysi_counter_aq_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "up_dn_cntr",
	packed_mode => "false",
	lut_mask => "33AA",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => VCC,
	datac => VCC,
	datad => inst_aI1_aLessThan_7_a5,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_anreset_v_rtl_3_awysi_counter_aq_a0_a,
	cout => inst_aI1_anreset_v_rtl_3_awysi_counter_acounter_cell_a0_a_aCOUT);

inst_aI1_aLessThan_7_a5_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aLessThan_7_a5 = !inst_aI1_anreset_v_rtl_3_awysi_counter_aq_a0_a # !inst_aI1_anreset_v_rtl_3_awysi_counter_aq_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0FFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI1_anreset_v_rtl_3_awysi_counter_aq_a1_a,
	datad => inst_aI1_anreset_v_rtl_3_awysi_counter_aq_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aLessThan_7_a5);

inst_aI1_anreset_v_rtl_3_awysi_counter_acounter_cell_a1_a : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_anreset_v_rtl_3_awysi_counter_aq_a1_a = DFFEA((inst_aI1_anreset_v_rtl_3_awysi_counter_aq_a1_a $ inst_aI1_anreset_v_rtl_3_awysi_counter_acounter_cell_a0_a_aCOUT & inst_aI1_aLessThan_7_a5) # (VCC & !inst_aI1_aLessThan_7_a5), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "up_dn_cntr",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3C3C",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => VCC,
	datac => VCC,
	datad => inst_aI1_aLessThan_7_a5,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	cin => inst_aI1_anreset_v_rtl_3_awysi_counter_acounter_cell_a0_a_aCOUT,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_anreset_v_rtl_3_awysi_counter_aq_a1_a);

inst_aI1_ai_a2_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_ai_a2 = nreset_adataout & inst_aI1_anreset_v_rtl_3_awysi_counter_aq_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => nreset_adataout,
	datad => inst_aI1_anreset_v_rtl_3_awysi_counter_aq_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_ai_a2);

inst_aI2_anreset_v_rtl_2_awysi_counter_acounter_cell_a0_a : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a0_a = DFFEA((!inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a0_a & inst_aI2_aLessThan_7_a5) # (VCC & !inst_aI2_aLessThan_7_a5), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )
-- inst_aI2_anreset_v_rtl_2_awysi_counter_acounter_cell_a0_a_aCOUT = CARRY(inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "up_dn_cntr",
	packed_mode => "false",
	lut_mask => "33AA",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => VCC,
	datac => VCC,
	datad => inst_aI2_aLessThan_7_a5,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a0_a,
	cout => inst_aI2_anreset_v_rtl_2_awysi_counter_acounter_cell_a0_a_aCOUT);

inst_aI2_aLessThan_7_a5_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aLessThan_7_a5 = !inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a0_a # !inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0FFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a,
	datad => inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aLessThan_7_a5);

inst_aI2_anreset_v_rtl_2_awysi_counter_acounter_cell_a1_a : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a = DFFEA((inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a $ inst_aI2_anreset_v_rtl_2_awysi_counter_acounter_cell_a0_a_aCOUT & inst_aI2_aLessThan_7_a5) # (VCC & !inst_aI2_aLessThan_7_a5), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "up_dn_cntr",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3C3C",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => VCC,
	datac => VCC,
	datad => inst_aI2_aLessThan_7_a5,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	cin => inst_aI2_anreset_v_rtl_2_awysi_counter_acounter_cell_a0_a_aCOUT,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a);

inst_aI3_anreset_v_rtl_1_awysi_counter_acounter_cell_a0_a : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a0_a = DFFEA((!inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a0_a & inst_aI3_ai_a128) # (VCC & !inst_aI3_ai_a128), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )
-- inst_aI3_anreset_v_rtl_1_awysi_counter_acounter_cell_a0_a_aCOUT = CARRY(inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "up_dn_cntr",
	packed_mode => "false",
	lut_mask => "33AA",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => VCC,
	datac => VCC,
	datad => inst_aI3_ai_a128,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a0_a,
	cout => inst_aI3_anreset_v_rtl_1_awysi_counter_acounter_cell_a0_a_aCOUT);

inst_aI3_ai_a128_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_ai_a128 = !inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a0_a # !inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0FFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a1_a,
	datad => inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_ai_a128);

inst_aI3_anreset_v_rtl_1_awysi_counter_acounter_cell_a1_a : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a1_a = DFFEA((inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a1_a $ inst_aI3_anreset_v_rtl_1_awysi_counter_acounter_cell_a0_a_aCOUT & inst_aI3_ai_a128) # (VCC & !inst_aI3_ai_a128), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "up_dn_cntr",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3C3C",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => VCC,
	datac => VCC,
	datad => inst_aI3_ai_a128,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	cin => inst_aI3_anreset_v_rtl_1_awysi_counter_acounter_cell_a0_a_aCOUT,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a1_a);

inst_aI3_aacc_a0_a_a2_a_a33_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a2_a_a33 = inst_aI3_ai_a135 & !rtl_a6586 # !inst_aI3_ai_a135 & inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a1_a & inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "08F8",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a1_a,
	datab => inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a0_a,
	datac => inst_aI3_ai_a135,
	datad => rtl_a6586,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a2_a_a33);

inst1_alpm_rom_component_asrom_asegment_a0_a_a3_a : flex10ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000101010110101011010101101010100000000000000000000000000000000000000000000000000000101010101010000000000000000000000000000000000000110101010101010100101011001",
	operation_mode => "rom",
	logical_ram_name => "lpm_rom0:inst1|lpm_rom:lpm_rom_component|altrom:srom|content",
	init_file => "../rom.mif",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 3,
	data_in_clock => "none",
	data_in_clear => "none",
	write_logic_clock => "none",
	write_enable_clear => "none",
	write_address_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none")
-- pragma translate_on
PORT MAP (
	clk0 => clk_adataout,
	waddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a3_a_waddr,
	raddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a3_a_raddr,
	devclrn => devclrn,
	devpor => devpor,
	modesel => inst1_alpm_rom_component_asrom_asegment_a0_a_a3_a_modesel,
	dataout => inst1_alpm_rom_component_asrom_aq_a3_a);

rtl_a6467_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a6467 = !inst1_alpm_rom_component_asrom_aq_a0_a & !inst1_alpm_rom_component_asrom_aq_a3_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "000F",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst1_alpm_rom_component_asrom_aq_a0_a,
	datad => inst1_alpm_rom_component_asrom_aq_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a6467);

inst1_alpm_rom_component_asrom_asegment_a0_a_a4_a : flex10ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010001100000111000011000001110000000000000000000000000000000000000000000000000000000100100011000000000000000000000000000000000000000011000100110001001010100011",
	operation_mode => "rom",
	logical_ram_name => "lpm_rom0:inst1|lpm_rom:lpm_rom_component|altrom:srom|content",
	init_file => "../rom.mif",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 4,
	data_in_clock => "none",
	data_in_clear => "none",
	write_logic_clock => "none",
	write_enable_clear => "none",
	write_address_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none")
-- pragma translate_on
PORT MAP (
	clk0 => clk_adataout,
	waddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a4_a_waddr,
	raddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a4_a_raddr,
	devclrn => devclrn,
	devpor => devpor,
	modesel => inst1_alpm_rom_component_asrom_asegment_a0_a_a4_a_modesel,
	dataout => inst1_alpm_rom_component_asrom_aq_a4_a);

inst_aI2_aMux_52_a0_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aMux_52_a0 = inst1_alpm_rom_component_asrom_aq_a6_a & !inst1_alpm_rom_component_asrom_aq_a7_a & (!inst1_alpm_rom_component_asrom_aq_a5_a # !inst1_alpm_rom_component_asrom_aq_a4_a) # !inst1_alpm_rom_component_asrom_aq_a6_a & inst1_alpm_rom_component_asrom_aq_a4_a & inst1_alpm_rom_component_asrom_aq_a5_a & inst1_alpm_rom_component_asrom_aq_a7_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0870",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_alpm_rom_component_asrom_aq_a4_a,
	datab => inst1_alpm_rom_component_asrom_aq_a5_a,
	datac => inst1_alpm_rom_component_asrom_aq_a6_a,
	datad => inst1_alpm_rom_component_asrom_aq_a7_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aMux_52_a0);

inst_aI2_aTD_c_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aTD_c_a2_a = DFFEA(inst1_alpm_rom_component_asrom_aq_a2_a # rtl_a6467 & inst_aI2_aMux_52_a0 & !inst1_alpm_rom_component_asrom_aq_a1_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAEA",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_alpm_rom_component_asrom_aq_a2_a,
	datab => rtl_a6467,
	datac => inst_aI2_aMux_52_a0,
	datad => inst1_alpm_rom_component_asrom_aq_a1_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_aTD_c_a2_a);

inst_aI4_anreset_v_rtl_0_awysi_counter_acounter_cell_a0_a : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a0_a = DFFEA((!inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a0_a & inst_aI4_aLessThan_7_a5) # (VCC & !inst_aI4_aLessThan_7_a5), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )
-- inst_aI4_anreset_v_rtl_0_awysi_counter_acounter_cell_a0_a_aCOUT = CARRY(inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "up_dn_cntr",
	packed_mode => "false",
	lut_mask => "33AA",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => VCC,
	datac => VCC,
	datad => inst_aI4_aLessThan_7_a5,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a0_a,
	cout => inst_aI4_anreset_v_rtl_0_awysi_counter_acounter_cell_a0_a_aCOUT);

inst_aI4_aLessThan_7_a5_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_aLessThan_7_a5 = !inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a0_a # !inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0FFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	datad => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aLessThan_7_a5);

inst_aI4_anreset_v_rtl_0_awysi_counter_acounter_cell_a1_a : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a = DFFEA((inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a $ inst_aI4_anreset_v_rtl_0_awysi_counter_acounter_cell_a0_a_aCOUT & inst_aI4_aLessThan_7_a5) # (VCC & !inst_aI4_aLessThan_7_a5), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "up_dn_cntr",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3C3C",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => VCC,
	datac => VCC,
	datad => inst_aI4_aLessThan_7_a5,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	cin => inst_aI4_anreset_v_rtl_0_awysi_counter_acounter_cell_a0_a_aCOUT,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a);

inst_aI5_adaddr_c_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI5_adaddr_c_a1_a = DFFEA(inst1_alpm_rom_component_asrom_aq_a5_a & nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => inst1_alpm_rom_component_asrom_aq_a5_a,
	datac => nreset_adataout,
	datad => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI5_adaddr_c_a1_a);

inst_aI4_adaddr_x_a1_a_a4_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_adaddr_x_a1_a_a4 = inst1_alpm_rom_component_asrom_aq_a5_a & nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst1_alpm_rom_component_asrom_aq_a5_a,
	datac => nreset_adataout,
	datad => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adaddr_x_a1_a_a4);

inst_aI2_andre_x_a45_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_andre_x_a45 = inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a & !inst_aI2_aC_raw_a13 & !inst_aI3_askip_l_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "000C",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a,
	datac => inst_aI2_aC_raw_a13,
	datad => inst_aI3_askip_l_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_andre_x_a45);

inst_aI2_aTC_x_a1_a_a1_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aTC_x_a1_a_a1 = nreset_adataout & inst_aI2_aMux_58_a0

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => nreset_adataout,
	datad => inst_aI2_aMux_58_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aTC_x_a1_a_a1);

inst_aI2_aTC_x_a0_a_a120_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aTC_x_a0_a_a120 = inst_aI2_aTC_x_a0_a_a121 # inst1_alpm_rom_component_asrom_aq_a0_a & nreset_adataout & inst_aI2_aTD_x_a3_a_a9

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EAAA",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_x_a0_a_a121,
	datab => inst1_alpm_rom_component_asrom_aq_a0_a,
	datac => nreset_adataout,
	datad => inst_aI2_aTD_x_a3_a_a9,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aTC_x_a0_a_a120);

inst_aI2_aC_store_x_a68_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aC_store_x_a68 = inst_aI2_apc_mux_x_a2_a_a47 & inst_aI2_aTC_x_a0_a_a120 & !inst_aI2_aTC_x_a2_a_a113

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00C0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI2_apc_mux_x_a2_a_a47,
	datac => inst_aI2_aTC_x_a0_a_a120,
	datad => inst_aI2_aTC_x_a2_a_a113,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aC_store_x_a68);

inst_aI2_aC_mem_x_a0_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aC_mem_x_a0 = inst_aI2_aTC_x_a1_a_a1 # inst_aI2_aTC_x_a2_a_a113 # !inst_aI2_aTC_x_a0_a_a120 # !inst_aI2_apc_mux_x_a2_a_a47

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EFFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_x_a1_a_a1,
	datab => inst_aI2_aTC_x_a2_a_a113,
	datac => inst_aI2_apc_mux_x_a2_a_a47,
	datad => inst_aI2_aTC_x_a0_a_a120,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aC_mem_x_a0);

inst_aI2_andre_x_a47_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_andre_x_a47 = inst_aI2_andre_x_a45 & !inst_aI2_aC_mem_x_a0 & (!inst_aI2_aC_store_x_a68 # !inst_aI2_aTC_x_a1_a_a1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "002A",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_andre_x_a45,
	datab => inst_aI2_aTC_x_a1_a_a1,
	datac => inst_aI2_aC_store_x_a68,
	datad => inst_aI2_aC_mem_x_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_andre_x_a47);

inst_aI4_andre_x_a1_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_andre_x_a1 = inst_aI2_andre_x_a46 # !inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a # !nreset_adataout # !inst_aI2_andre_x_a47

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BFFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_andre_x_a46,
	datab => inst_aI2_andre_x_a47,
	datac => nreset_adataout,
	datad => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_andre_x_a1);

inst_aI5_adaddr_c_a4_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI5_adaddr_c_a4_a = DFFEA(inst1_alpm_rom_component_asrom_aq_a8_a & nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => inst1_alpm_rom_component_asrom_aq_a8_a,
	datac => nreset_adataout,
	datad => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI5_adaddr_c_a4_a);

inst_aI4_adaddr_x_a4_a_a1_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_adaddr_x_a4_a_a1 = inst1_alpm_rom_component_asrom_aq_a8_a & nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst1_alpm_rom_component_asrom_aq_a8_a,
	datac => nreset_adataout,
	datad => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adaddr_x_a4_a_a1);

inst_aI5_adaddr_c_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI5_adaddr_c_a2_a = DFFEA(inst1_alpm_rom_component_asrom_aq_a6_a & nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => inst1_alpm_rom_component_asrom_aq_a6_a,
	datac => nreset_adataout,
	datad => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI5_adaddr_c_a2_a);

inst_aI4_ai_a2_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_ai_a2 = nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => nreset_adataout,
	datad => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_ai_a2);

inst_aI5_ai_a17_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI5_ai_a17 = inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a2_a # !inst_aI4_andre_x_a1 & inst1_alpm_rom_component_asrom_aq_a6_a & inst_aI4_ai_a2

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAC0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_adaddr_c_a2_a,
	datab => inst1_alpm_rom_component_asrom_aq_a6_a,
	datac => inst_aI4_ai_a2,
	datad => inst_aI4_andre_x_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI5_ai_a17);

inst6_areduce_nor_30_a12_I : flex10ke_lcell 
-- Equation(s):
-- inst6_areduce_nor_30_a12 = !inst_aI5_ai_a17 & (inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a4_a # !inst_aI4_andre_x_a1 & inst_aI4_adaddr_x_a4_a_a1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00AC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_adaddr_c_a4_a,
	datab => inst_aI4_adaddr_x_a4_a_a1,
	datac => inst_aI4_andre_x_a1,
	datad => inst_aI5_ai_a17,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst6_areduce_nor_30_a12);

inst_aI5_adaddr_c_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI5_adaddr_c_a3_a = DFFEA(inst1_alpm_rom_component_asrom_aq_a7_a & nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => inst1_alpm_rom_component_asrom_aq_a7_a,
	datac => nreset_adataout,
	datad => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI5_adaddr_c_a3_a);

inst_aI5_ai_a14_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI5_ai_a14 = inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a3_a # !inst_aI4_andre_x_a1 & inst1_alpm_rom_component_asrom_aq_a7_a & inst_aI4_ai_a2

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAC0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_adaddr_c_a3_a,
	datab => inst1_alpm_rom_component_asrom_aq_a7_a,
	datac => inst_aI4_ai_a2,
	datad => inst_aI4_andre_x_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI5_ai_a14);

inst_aI5_adaddr_c_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI5_adaddr_c_a0_a = DFFEA(inst1_alpm_rom_component_asrom_aq_a4_a & nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => inst1_alpm_rom_component_asrom_aq_a4_a,
	datac => nreset_adataout,
	datad => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI5_adaddr_c_a0_a);

inst_aI5_ai_a23_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI5_ai_a23 = inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a0_a # !inst_aI4_andre_x_a1 & inst1_alpm_rom_component_asrom_aq_a4_a & inst_aI4_ai_a2

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAC0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_adaddr_c_a0_a,
	datab => inst1_alpm_rom_component_asrom_aq_a4_a,
	datac => inst_aI4_ai_a2,
	datad => inst_aI4_andre_x_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI5_ai_a23);

inst6_areduce_nor_30_a8_I : flex10ke_lcell 
-- Equation(s):
-- inst6_areduce_nor_30_a8 = inst6_areduce_nor_30_a12 & !inst_aI5_ai_a14 & !inst_aI5_ai_a23

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "000C",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst6_areduce_nor_30_a12,
	datac => inst_aI5_ai_a14,
	datad => inst_aI5_ai_a23,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst6_areduce_nor_30_a8);

inst6_amux_c_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst6_amux_c_a0_a = DFFEA(inst6_areduce_nor_30_a8 & (inst_aI4_andre_x_a1 & !inst_aI5_adaddr_c_a1_a # !inst_aI4_andre_x_a1 & !inst_aI4_adaddr_x_a1_a_a4), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5300",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_adaddr_c_a1_a,
	datab => inst_aI4_adaddr_x_a1_a_a4,
	datac => inst_aI4_andre_x_a1,
	datad => inst6_areduce_nor_30_a8,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst6_amux_c_a0_a);

inst_aI4_adata_ox_a1_a_a2_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_adata_ox_a1_a_a2 = inst_aI3_aacc_c_a0_a_a1_a & nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI3_aacc_c_a0_a_a1_a,
	datac => nreset_adataout,
	datad => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adata_ox_a1_a_a2);

inst6_actrl_data_c_a3_a_a19_I : flex10ke_lcell 
-- Equation(s):
-- inst6_actrl_data_c_a3_a_a19 = nreset_adataout & inst_aI5_andwe_c

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => nreset_adataout,
	datad => inst_aI5_andwe_c,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst6_actrl_data_c_a3_a_a19);

inst6_ai_a32_I : flex10ke_lcell 
-- Equation(s):
-- inst6_ai_a32 = inst6_actrl_data_c_a3_a_a19 & (inst_aI4_andre_x_a1 & !inst_aI5_adaddr_c_a4_a # !inst_aI4_andre_x_a1 & !inst_aI4_adaddr_x_a4_a_a1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5300",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_adaddr_c_a4_a,
	datab => inst_aI4_adaddr_x_a4_a_a1,
	datac => inst_aI4_andre_x_a1,
	datad => inst6_actrl_data_c_a3_a_a19,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst6_ai_a32);

inst_aI5_ai_a20_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI5_ai_a20 = inst_aI5_adaddr_c_a1_a & (inst_aI4_adaddr_x_a1_a_a4 # inst_aI4_andre_x_a1) # !inst_aI5_adaddr_c_a1_a & inst_aI4_adaddr_x_a1_a_a4 & !inst_aI4_andre_x_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI5_adaddr_c_a1_a,
	datac => inst_aI4_adaddr_x_a1_a_a4,
	datad => inst_aI4_andre_x_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI5_ai_a20);

inst2_alpm_ram_dq_component_asram_asegment_a0_a_a1_a : flex10ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	operation_mode => "single_port",
	logical_ram_name => "lpm_ram_dq0:inst2|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "../ram.mif",
	logical_ram_depth => 16,
	logical_ram_width => 4,
	address_width => 4,
	first_address => 0,
	last_address => 15,
	bit_number => 1,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_enable_clear => "none",
	write_address_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI4_adata_ox_a1_a_a2,
	clk0 => clk_adataout,
	we => inst6_ai_a32,
	waddr => ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a1_a_waddr,
	raddr => ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a1_a_raddr,
	devclrn => devclrn,
	devpor => devpor,
	modesel => inst2_alpm_ram_dq_component_asram_asegment_a0_a_a1_a_modesel,
	dataout => inst2_alpm_ram_dq_component_asram_aq_a1_a);

CTRL_DATA_IN_a1_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CTRL_DATA_IN(1),
	dataout => CTRL_DATA_IN_a1_a_adataout);

inst_aI2_aTC_x_a2_a_a109_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aTC_x_a2_a_a109 = inst1_alpm_rom_component_asrom_aq_a6_a & inst1_alpm_rom_component_asrom_aq_a7_a & !inst1_alpm_rom_component_asrom_aq_a0_a & !inst1_alpm_rom_component_asrom_aq_a5_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0008",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_alpm_rom_component_asrom_aq_a6_a,
	datab => inst1_alpm_rom_component_asrom_aq_a7_a,
	datac => inst1_alpm_rom_component_asrom_aq_a0_a,
	datad => inst1_alpm_rom_component_asrom_aq_a5_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aTC_x_a2_a_a109);

inst_aI2_aTC_c_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aTC_c_a2_a = DFFEA(nreset_adataout & inst_aI2_aTD_x_a3_a_a9 & (inst1_alpm_rom_component_asrom_aq_a3_a # inst_aI2_aTC_x_a2_a_a109), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8880",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => nreset_adataout,
	datab => inst_aI2_aTD_x_a3_a_a9,
	datac => inst1_alpm_rom_component_asrom_aq_a3_a,
	datad => inst_aI2_aTC_x_a2_a_a109,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_aTC_c_a2_a);

inst_aI3_adata_x_a3_a_a597_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a3_a_a597 = inst_aI4_ai_a2 & (inst_aI2_aTC_c_a2_a # inst_aI2_aTC_c_a0_a # !inst_aI2_aTC_c_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A8AA",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_ai_a2,
	datab => inst_aI2_aTC_c_a2_a,
	datac => inst_aI2_aTC_c_a0_a,
	datad => inst_aI2_aTC_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a3_a_a597);

inst_aI3_adata_x_a1_a_a602_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a1_a_a602 = inst_aI3_adata_x_a3_a_a597 & (!inst_aI2_andre_x_a46 # !inst_aI2_andre_x_a47)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0CCC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI3_adata_x_a3_a_a597,
	datac => inst_aI2_andre_x_a47,
	datad => inst_aI2_andre_x_a46,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a1_a_a602);

inst_aI2_adata_is_c_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_adata_is_c_a1_a = DFFEA(inst1_alpm_rom_component_asrom_aq_a5_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => inst1_alpm_rom_component_asrom_aq_a5_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_adata_is_c_a1_a);

inst_aI3_adata_x_a1_a_a199_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a1_a_a199 = inst_aI2_aTC_c_a2_a # inst_aI2_aTC_c_a0_a # !inst_aI2_adata_is_c_a1_a # !inst_aI2_aTC_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EFFF",
	clock_enable_mode => "false",
	output_mode => "none")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_c_a2_a,
	datab => inst_aI2_aTC_c_a0_a,
	datac => inst_aI2_aTC_c_a1_a,
	datad => inst_aI2_adata_is_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	cascout => inst_aI3_adata_x_a1_a_a199);

inst_aI3_adata_x_a1_a_a769_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a1_a_a769 = (!inst_aI2_andre_x_a46 # !inst_aI2_andre_x_a47 # !inst_aI3_adata_x_a3_a_a597 # !inst_aI4_aipage_c_a1_a) & CASCADE(inst_aI3_adata_x_a1_a_a199)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7FFF",
	clock_enable_mode => "false",
	output_mode => "none")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aipage_c_a1_a,
	datab => inst_aI3_adata_x_a3_a_a597,
	datac => inst_aI2_andre_x_a47,
	datad => inst_aI2_andre_x_a46,
	cascin => inst_aI3_adata_x_a1_a_a199,
	devclrn => devclrn,
	devpor => devpor,
	cascout => inst_aI3_adata_x_a1_a_a769);

inst_aI3_adata_x_a1_a_a767_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a1_a_a767 = (inst6_amux_c_a0_a & !CTRL_DATA_IN_a1_a_adataout # !inst6_amux_c_a0_a & !inst2_alpm_ram_dq_component_asram_aq_a1_a # !inst_aI3_adata_x_a1_a_a602) & CASCADE(inst_aI3_adata_x_a1_a_a769)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "1BFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_amux_c_a0_a,
	datab => inst2_alpm_ram_dq_component_asram_aq_a1_a,
	datac => CTRL_DATA_IN_a1_a_adataout,
	datad => inst_aI3_adata_x_a1_a_a602,
	cascin => inst_aI3_adata_x_a1_a_a769,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a1_a_a767);

inst_aI3_ai_a9_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_ai_a9 = inst_aI3_aacc_c_a0_a_a1_a & !inst_aI3_adata_x_a1_a_a767

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00F0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI3_aacc_c_a0_a_a1_a,
	datad => inst_aI3_adata_x_a1_a_a767,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_ai_a9);

inst_aI2_aMux_54_a0_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aMux_54_a0 = inst1_alpm_rom_component_asrom_aq_a4_a & (inst1_alpm_rom_component_asrom_aq_a5_a & !inst1_alpm_rom_component_asrom_aq_a6_a & !inst1_alpm_rom_component_asrom_aq_a7_a # !inst1_alpm_rom_component_asrom_aq_a5_a & (!inst1_alpm_rom_component_asrom_aq_a7_a # !inst1_alpm_rom_component_asrom_aq_a6_a))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "022A",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_alpm_rom_component_asrom_aq_a4_a,
	datab => inst1_alpm_rom_component_asrom_aq_a5_a,
	datac => inst1_alpm_rom_component_asrom_aq_a6_a,
	datad => inst1_alpm_rom_component_asrom_aq_a7_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aMux_54_a0);

inst_aI2_aTD_c_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aTD_c_a0_a = DFFEA(inst1_alpm_rom_component_asrom_aq_a0_a & !inst_aI2_aTD_x_a3_a_a9 # !inst1_alpm_rom_component_asrom_aq_a0_a & inst_aI2_aMux_54_a0 & !inst1_alpm_rom_component_asrom_aq_a3_a & inst_aI2_aTD_x_a3_a_a9, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "02CC",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aMux_54_a0,
	datab => inst1_alpm_rom_component_asrom_aq_a0_a,
	datac => inst1_alpm_rom_component_asrom_aq_a3_a,
	datad => inst_aI2_aTD_x_a3_a_a9,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_aTD_c_a0_a);

inst_aI4_adata_ox_a0_a_a3_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_adata_ox_a0_a_a3 = inst_aI3_aacc_c_a0_a_a0_a & nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI3_aacc_c_a0_a_a0_a,
	datac => nreset_adataout,
	datad => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adata_ox_a0_a_a3);

inst2_alpm_ram_dq_component_asram_asegment_a0_a_a0_a : flex10ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	operation_mode => "single_port",
	logical_ram_name => "lpm_ram_dq0:inst2|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "../ram.mif",
	logical_ram_depth => 16,
	logical_ram_width => 4,
	address_width => 4,
	first_address => 0,
	last_address => 15,
	bit_number => 0,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_enable_clear => "none",
	write_address_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI4_adata_ox_a0_a_a3,
	clk0 => clk_adataout,
	we => inst6_ai_a32,
	waddr => ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a0_a_waddr,
	raddr => ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a0_a_raddr,
	devclrn => devclrn,
	devpor => devpor,
	modesel => inst2_alpm_ram_dq_component_asram_asegment_a0_a_a0_a_modesel,
	dataout => inst2_alpm_ram_dq_component_asram_aq_a0_a);

CTRL_DATA_IN_a0_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CTRL_DATA_IN(0),
	dataout => CTRL_DATA_IN_a0_a_adataout);

inst_aI2_adata_is_c_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_adata_is_c_a0_a = DFFEA(inst1_alpm_rom_component_asrom_aq_a4_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => inst1_alpm_rom_component_asrom_aq_a4_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_adata_is_c_a0_a);

inst_aI3_adata_x_a0_a_a269_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a0_a_a269 = inst_aI2_aTC_c_a2_a # inst_aI2_aTC_c_a0_a # !inst_aI2_adata_is_c_a0_a # !inst_aI2_aTC_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EFFF",
	clock_enable_mode => "false",
	output_mode => "none")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_c_a2_a,
	datab => inst_aI2_aTC_c_a0_a,
	datac => inst_aI2_aTC_c_a1_a,
	datad => inst_aI2_adata_is_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	cascout => inst_aI3_adata_x_a0_a_a269);

inst_aI3_adata_x_a0_a_a770_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a0_a_a770 = (!inst_aI2_andre_x_a46 # !inst_aI2_andre_x_a47 # !inst_aI3_adata_x_a3_a_a597 # !inst_aI4_aipage_c_a0_a) & CASCADE(inst_aI3_adata_x_a0_a_a269)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7FFF",
	clock_enable_mode => "false",
	output_mode => "none")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aipage_c_a0_a,
	datab => inst_aI3_adata_x_a3_a_a597,
	datac => inst_aI2_andre_x_a47,
	datad => inst_aI2_andre_x_a46,
	cascin => inst_aI3_adata_x_a0_a_a269,
	devclrn => devclrn,
	devpor => devpor,
	cascout => inst_aI3_adata_x_a0_a_a770);

inst_aI3_adata_x_a0_a_a768_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a0_a_a768 = (inst6_amux_c_a0_a & !CTRL_DATA_IN_a0_a_adataout # !inst6_amux_c_a0_a & !inst2_alpm_ram_dq_component_asram_aq_a0_a # !inst_aI3_adata_x_a1_a_a602) & CASCADE(inst_aI3_adata_x_a0_a_a770)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "1BFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_amux_c_a0_a,
	datab => inst2_alpm_ram_dq_component_asram_aq_a0_a,
	datac => CTRL_DATA_IN_a0_a_adataout,
	datad => inst_aI3_adata_x_a1_a_a602,
	cascin => inst_aI3_adata_x_a0_a_a770,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a0_a_a768);

inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a1_a_a37_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a1_a_a37 = inst_aI3_aacc_c_a0_a_a0_a # inst_aI3_adata_x_a0_a_a768

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI3_aacc_c_a0_a_a0_a,
	datad => inst_aI3_adata_x_a0_a_a768,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a1_a_a37);

inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a2_a_a33_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a2_a_a33 = inst_aI3_aacc_c_a0_a_a1_a $ inst_aI3_adata_x_a1_a_a767 $ inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a1_a_a37

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C33C",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI3_aacc_c_a0_a_a1_a,
	datac => inst_aI3_adata_x_a1_a_a767,
	datad => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a1_a_a37,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a2_a_a33);

inst_aI2_aMux_53_a0_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aMux_53_a0 = inst1_alpm_rom_component_asrom_aq_a4_a & !inst1_alpm_rom_component_asrom_aq_a7_a & (inst1_alpm_rom_component_asrom_aq_a5_a $ inst1_alpm_rom_component_asrom_aq_a6_a) # !inst1_alpm_rom_component_asrom_aq_a4_a & inst1_alpm_rom_component_asrom_aq_a5_a & (!inst1_alpm_rom_component_asrom_aq_a7_a # !inst1_alpm_rom_component_asrom_aq_a6_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "046C",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_alpm_rom_component_asrom_aq_a4_a,
	datab => inst1_alpm_rom_component_asrom_aq_a5_a,
	datac => inst1_alpm_rom_component_asrom_aq_a6_a,
	datad => inst1_alpm_rom_component_asrom_aq_a7_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aMux_53_a0);

inst_aI2_aTD_c_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aTD_c_a1_a = DFFEA(inst1_alpm_rom_component_asrom_aq_a1_a # rtl_a6467 & inst_aI2_aMux_53_a0 & !inst1_alpm_rom_component_asrom_aq_a2_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAEA",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_alpm_rom_component_asrom_aq_a1_a,
	datab => rtl_a6467,
	datac => inst_aI2_aMux_53_a0,
	datad => inst1_alpm_rom_component_asrom_aq_a2_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_aTD_c_a1_a);

inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a0_a = inst_aI3_aacc_c_a0_a_a0_a $ !inst_aI3_adata_x_a0_a_a768
-- inst_aI3_aadd_89_aadder_aresult_node_acout_a0_a = CARRY(inst_aI3_aacc_c_a0_a_a0_a & !inst_aI3_adata_x_a0_a_a768)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	packed_mode => "false",
	lut_mask => "9922",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a0_a,
	datab => inst_aI3_adata_x_a0_a_a768,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a0_a,
	cout => inst_aI3_aadd_89_aadder_aresult_node_acout_a0_a);

inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a1_a = inst_aI3_adata_x_a1_a_a767 $ inst_aI3_aacc_c_a0_a_a1_a $ !inst_aI3_aadd_89_aadder_aresult_node_acout_a0_a
-- inst_aI3_aadd_89_aadder_aresult_node_acout_a1_a = CARRY(inst_aI3_adata_x_a1_a_a767 & inst_aI3_aacc_c_a0_a_a1_a & inst_aI3_aadd_89_aadder_aresult_node_acout_a0_a # !inst_aI3_adata_x_a1_a_a767 & (inst_aI3_aacc_c_a0_a_a1_a # inst_aI3_aadd_89_aadder_aresult_node_acout_a0_a))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "69D4",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a1_a_a767,
	datab => inst_aI3_aacc_c_a0_a_a1_a,
	cin => inst_aI3_aadd_89_aadder_aresult_node_acout_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a1_a,
	cout => inst_aI3_aadd_89_aadder_aresult_node_acout_a1_a);

inst_aI3_aMux_121_rtl_43_rtl_258_a0_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aMux_121_rtl_43_rtl_258_a0 = inst_aI2_aTD_c_a1_a & (inst_aI2_aTD_c_a0_a # inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a2_a_a33) # !inst_aI2_aTD_c_a1_a & !inst_aI2_aTD_c_a0_a & inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E5E0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a2_a_a33,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_121_rtl_43_rtl_258_a0);

inst_aI3_ai_a13_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_ai_a13 = inst_aI3_aacc_c_a0_a_a1_a # !inst_aI3_adata_x_a1_a_a767

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0FF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI3_aacc_c_a0_a_a1_a,
	datad => inst_aI3_adata_x_a1_a_a767,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_ai_a13);

inst_aI3_aMux_121_rtl_43_rtl_258_a1_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aMux_121_rtl_43_rtl_258_a1 = inst_aI3_aMux_121_rtl_43_rtl_258_a0 & (inst_aI3_ai_a13 # !inst_aI2_aTD_c_a0_a) # !inst_aI3_aMux_121_rtl_43_rtl_258_a0 & inst_aI3_ai_a9 & inst_aI2_aTD_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F838",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_ai_a9,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_aMux_121_rtl_43_rtl_258_a0,
	datad => inst_aI3_ai_a13,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_121_rtl_43_rtl_258_a1);

rtl_a1490_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1490 = inst_aI2_aTD_c_a2_a & (inst_aI3_aacc_c_a0_a_a1_a $ inst_aI2_aTD_c_a1_a) # !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2EE2",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a0_a,
	datab => inst_aI2_aTD_c_a2_a,
	datac => inst_aI3_aacc_c_a0_a_a1_a,
	datad => inst_aI2_aTD_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1490);

inst_aI2_adata_is_c_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_adata_is_c_a2_a = DFFEA(inst1_alpm_rom_component_asrom_aq_a6_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => inst1_alpm_rom_component_asrom_aq_a6_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_adata_is_c_a2_a);

inst_aI3_adata_x_a2_a_a12_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a2_a_a12 = inst_aI2_aTC_c_a1_a & inst_aI2_adata_is_c_a2_a & !inst_aI2_aTC_c_a2_a & !inst_aI2_aTC_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0008",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_c_a1_a,
	datab => inst_aI2_adata_is_c_a2_a,
	datac => inst_aI2_aTC_c_a2_a,
	datad => inst_aI2_aTC_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a2_a_a12);

CTRL_DATA_IN_a2_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CTRL_DATA_IN(2),
	dataout => CTRL_DATA_IN_a2_a_adataout);

inst_aI4_adata_ox_a2_a_a1_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_adata_ox_a2_a_a1 = inst_aI3_aacc_c_a0_a_a2_a & nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI3_aacc_c_a0_a_a2_a,
	datac => nreset_adataout,
	datad => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adata_ox_a2_a_a1);

inst2_alpm_ram_dq_component_asram_asegment_a0_a_a2_a : flex10ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	operation_mode => "single_port",
	logical_ram_name => "lpm_ram_dq0:inst2|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "../ram.mif",
	logical_ram_depth => 16,
	logical_ram_width => 4,
	address_width => 4,
	first_address => 0,
	last_address => 15,
	bit_number => 2,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_enable_clear => "none",
	write_address_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI4_adata_ox_a2_a_a1,
	clk0 => clk_adataout,
	we => inst6_ai_a32,
	waddr => ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a2_a_waddr,
	raddr => ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a2_a_raddr,
	devclrn => devclrn,
	devpor => devpor,
	modesel => inst2_alpm_ram_dq_component_asram_asegment_a0_a_a2_a_modesel,
	dataout => inst2_alpm_ram_dq_component_asram_aq_a2_a);

inst_aI3_adata_x_a2_a_a600_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a2_a_a600 = inst_aI3_adata_x_a3_a_a597 & (inst6_amux_c_a0_a & CTRL_DATA_IN_a2_a_adataout # !inst6_amux_c_a0_a & inst2_alpm_ram_dq_component_asram_aq_a2_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88A0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a3_a_a597,
	datab => CTRL_DATA_IN_a2_a_adataout,
	datac => inst2_alpm_ram_dq_component_asram_aq_a2_a,
	datad => inst6_amux_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a2_a_a600);

inst_aI4_areduce_nor_27_a23_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_areduce_nor_27_a23 = inst1_alpm_rom_component_asrom_aq_a6_a # !inst1_alpm_rom_component_asrom_aq_a4_a # !inst1_alpm_rom_component_asrom_aq_a5_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CFFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst1_alpm_rom_component_asrom_aq_a6_a,
	datac => inst1_alpm_rom_component_asrom_aq_a5_a,
	datad => inst1_alpm_rom_component_asrom_aq_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_areduce_nor_27_a23);

inst_aI3_adata_x_a2_a_a668_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a2_a_a668 = inst_aI3_adata_x_a2_a_a12 # inst_aI3_adata_x_a2_a_a600 & (inst_aI4_areduce_nor_27_a23 # !inst_aI4_areduce_nor_24_a14)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EAEE",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a2_a_a12,
	datab => inst_aI3_adata_x_a2_a_a600,
	datac => inst_aI4_areduce_nor_27_a23,
	datad => inst_aI4_areduce_nor_24_a14,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a2_a_a668);

inst_aI4_ai_a397_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_ai_a397 = !inst1_alpm_rom_component_asrom_aq_a7_a & !inst1_alpm_rom_component_asrom_aq_a9_a & !inst1_alpm_rom_component_asrom_aq_a8_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0003",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst1_alpm_rom_component_asrom_aq_a7_a,
	datac => inst1_alpm_rom_component_asrom_aq_a9_a,
	datad => inst1_alpm_rom_component_asrom_aq_a8_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_ai_a397);

inst_aI4_ai_a385_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_ai_a385 = inst_aI2_andre_x_a45 & inst_aI2_aC_store_x_a68 & nreset_adataout & inst_aI2_aMux_58_a0

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_andre_x_a45,
	datab => inst_aI2_aC_store_x_a68,
	datac => nreset_adataout,
	datad => inst_aI2_aMux_58_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_ai_a385);

inst_aI4_ai_a254_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_ai_a254 = inst_aI4_ai_a397 & (inst_aI2_andre_x_a47 # inst_aI4_ai_a385)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCC0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI4_ai_a397,
	datac => inst_aI2_andre_x_a47,
	datad => inst_aI4_ai_a385,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_ai_a254);

inst_aI3_adata_x_a2_a_a13_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a2_a_a13 = inst_aI3_adata_x_a2_a_a668 # inst_aI3_adata_x_a2_a_a600 & (!inst_aI2_andre_x_a47 # !inst_aI4_ai_a254)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AEEE",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a2_a_a668,
	datab => inst_aI3_adata_x_a2_a_a600,
	datac => inst_aI4_ai_a254,
	datad => inst_aI2_andre_x_a47,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a2_a_a13);

inst_aI3_ai_a10_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_ai_a10 = inst_aI3_aacc_c_a0_a_a2_a & inst_aI3_adata_x_a2_a_a13

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI3_aacc_c_a0_a_a2_a,
	datad => inst_aI3_adata_x_a2_a_a13,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_ai_a10);

inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a2_a_a29_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a2_a_a29 = inst_aI3_aacc_c_a0_a_a1_a & (inst_aI3_adata_x_a1_a_a767 # inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a1_a_a37) # !inst_aI3_aacc_c_a0_a_a1_a & inst_aI3_adata_x_a1_a_a767 & inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a1_a_a37

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FCC0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI3_aacc_c_a0_a_a1_a,
	datac => inst_aI3_adata_x_a1_a_a767,
	datad => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a1_a_a37,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a2_a_a29);

inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a3_a_a25_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a3_a_a25 = inst_aI3_aacc_c_a0_a_a2_a $ inst_aI3_adata_x_a2_a_a13 $ !inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a2_a_a29

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "3CC3",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI3_aacc_c_a0_a_a2_a,
	datac => inst_aI3_adata_x_a2_a_a13,
	datad => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a2_a_a29,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a3_a_a25);

inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a2_a = inst_aI3_adata_x_a2_a_a13 $ inst_aI3_aacc_c_a0_a_a2_a $ inst_aI3_aadd_89_aadder_aresult_node_acout_a1_a
-- inst_aI3_aadd_89_aadder_aresult_node_acout_a2_a = CARRY(inst_aI3_adata_x_a2_a_a13 & (inst_aI3_aacc_c_a0_a_a2_a # inst_aI3_aadd_89_aadder_aresult_node_acout_a1_a) # !inst_aI3_adata_x_a2_a_a13 & inst_aI3_aacc_c_a0_a_a2_a & inst_aI3_aadd_89_aadder_aresult_node_acout_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "96E8",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a2_a_a13,
	datab => inst_aI3_aacc_c_a0_a_a2_a,
	cin => inst_aI3_aadd_89_aadder_aresult_node_acout_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a2_a,
	cout => inst_aI3_aadd_89_aadder_aresult_node_acout_a2_a);

inst_aI3_aMux_120_rtl_37_rtl_252_a0_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aMux_120_rtl_37_rtl_252_a0 = inst_aI2_aTD_c_a1_a & (inst_aI2_aTD_c_a0_a # inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a3_a_a25) # !inst_aI2_aTD_c_a1_a & !inst_aI2_aTD_c_a0_a & inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E5E0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a3_a_a25,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_120_rtl_37_rtl_252_a0);

inst_aI3_ai_a14_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_ai_a14 = inst_aI3_aacc_c_a0_a_a2_a # inst_aI3_adata_x_a2_a_a13

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI3_aacc_c_a0_a_a2_a,
	datad => inst_aI3_adata_x_a2_a_a13,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_ai_a14);

inst_aI3_aMux_120_rtl_37_rtl_252_a1_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aMux_120_rtl_37_rtl_252_a1 = inst_aI3_aMux_120_rtl_37_rtl_252_a0 & (inst_aI3_ai_a14 # !inst_aI2_aTD_c_a0_a) # !inst_aI3_aMux_120_rtl_37_rtl_252_a0 & inst_aI3_ai_a10 & inst_aI2_aTD_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F838",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_ai_a10,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_aMux_120_rtl_37_rtl_252_a0,
	datad => inst_aI3_ai_a14,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_120_rtl_37_rtl_252_a1);

rtl_a1480_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1480 = inst_aI2_aTD_c_a2_a & (inst_aI3_aacc_c_a0_a_a2_a $ inst_aI2_aTD_c_a1_a) # !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2EE2",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a1_a,
	datab => inst_aI2_aTD_c_a2_a,
	datac => inst_aI3_aacc_c_a0_a_a2_a,
	datad => inst_aI2_aTD_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1480);

inst_aI2_adata_is_c_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_adata_is_c_a3_a = DFFEA(inst1_alpm_rom_component_asrom_aq_a7_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => inst1_alpm_rom_component_asrom_aq_a7_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_adata_is_c_a3_a);

inst_aI3_adata_x_a3_a_a9_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a3_a_a9 = inst_aI2_aTC_c_a1_a & inst_aI2_adata_is_c_a3_a & !inst_aI2_aTC_c_a2_a & !inst_aI2_aTC_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0008",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_c_a1_a,
	datab => inst_aI2_adata_is_c_a3_a,
	datac => inst_aI2_aTC_c_a2_a,
	datad => inst_aI2_aTC_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a3_a_a9);

CTRL_DATA_IN_a3_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CTRL_DATA_IN(3),
	dataout => CTRL_DATA_IN_a3_a_adataout);

inst_aI4_adata_ox_a3_a_a0_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_adata_ox_a3_a_a0 = inst_aI3_aacc_c_a0_a_a3_a & nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI3_aacc_c_a0_a_a3_a,
	datac => nreset_adataout,
	datad => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adata_ox_a3_a_a0);

inst2_alpm_ram_dq_component_asram_asegment_a0_a_a3_a : flex10ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	operation_mode => "single_port",
	logical_ram_name => "lpm_ram_dq0:inst2|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "../ram.mif",
	logical_ram_depth => 16,
	logical_ram_width => 4,
	address_width => 4,
	first_address => 0,
	last_address => 15,
	bit_number => 3,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_enable_clear => "none",
	write_address_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI4_adata_ox_a3_a_a0,
	clk0 => clk_adataout,
	we => inst6_ai_a32,
	waddr => ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a3_a_waddr,
	raddr => ww_inst2_alpm_ram_dq_component_asram_asegment_a0_a_a3_a_raddr,
	devclrn => devclrn,
	devpor => devpor,
	modesel => inst2_alpm_ram_dq_component_asram_asegment_a0_a_a3_a_modesel,
	dataout => inst2_alpm_ram_dq_component_asram_aq_a3_a);

inst_aI3_adata_x_a3_a_a599_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a3_a_a599 = inst_aI3_adata_x_a3_a_a597 & (inst6_amux_c_a0_a & CTRL_DATA_IN_a3_a_adataout # !inst6_amux_c_a0_a & inst2_alpm_ram_dq_component_asram_aq_a3_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88A0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a3_a_a597,
	datab => CTRL_DATA_IN_a3_a_adataout,
	datac => inst2_alpm_ram_dq_component_asram_aq_a3_a,
	datad => inst6_amux_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a3_a_a599);

inst_aI3_adata_x_a3_a_a633_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a3_a_a633 = inst_aI3_adata_x_a3_a_a9 # inst_aI3_adata_x_a3_a_a599 & (inst_aI4_areduce_nor_27_a23 # !inst_aI4_areduce_nor_24_a14)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EAEE",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a3_a_a9,
	datab => inst_aI3_adata_x_a3_a_a599,
	datac => inst_aI4_areduce_nor_27_a23,
	datad => inst_aI4_areduce_nor_24_a14,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a3_a_a633);

inst_aI3_adata_x_a3_a_a10_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a3_a_a10 = inst_aI3_adata_x_a3_a_a633 # inst_aI3_adata_x_a3_a_a599 & (!inst_aI2_andre_x_a47 # !inst_aI4_ai_a254)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AEEE",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a3_a_a633,
	datab => inst_aI3_adata_x_a3_a_a599,
	datac => inst_aI4_ai_a254,
	datad => inst_aI2_andre_x_a47,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a3_a_a10);

inst_aI3_ai_a11_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_ai_a11 = inst_aI3_aacc_c_a0_a_a3_a & inst_aI3_adata_x_a3_a_a10

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI3_aacc_c_a0_a_a3_a,
	datad => inst_aI3_adata_x_a3_a_a10,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_ai_a11);

inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a3_a_a21_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a3_a_a21 = inst_aI3_aacc_c_a0_a_a2_a & (inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a2_a_a29 # !inst_aI3_adata_x_a2_a_a13) # !inst_aI3_aacc_c_a0_a_a2_a & !inst_aI3_adata_x_a2_a_a13 & inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a2_a_a29

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CF0C",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI3_aacc_c_a0_a_a2_a,
	datac => inst_aI3_adata_x_a2_a_a13,
	datad => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a2_a_a29,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a3_a_a21);

inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a4_a_a17_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a4_a_a17 = inst_aI3_aacc_c_a0_a_a3_a $ inst_aI3_adata_x_a3_a_a10 $ !inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a3_a_a21

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "3CC3",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI3_aacc_c_a0_a_a3_a,
	datac => inst_aI3_adata_x_a3_a_a10,
	datad => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a3_a_a21,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a4_a_a17);

inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a3_a = inst_aI3_adata_x_a3_a_a10 $ inst_aI3_aacc_c_a0_a_a3_a $ inst_aI3_aadd_89_aadder_aresult_node_acout_a2_a
-- inst_aI3_aadd_89_aadder_aresult_node_acout_a3_a = CARRY(inst_aI3_adata_x_a3_a_a10 & (inst_aI3_aacc_c_a0_a_a3_a # inst_aI3_aadd_89_aadder_aresult_node_acout_a2_a) # !inst_aI3_adata_x_a3_a_a10 & inst_aI3_aacc_c_a0_a_a3_a & inst_aI3_aadd_89_aadder_aresult_node_acout_a2_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "96E8",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a3_a_a10,
	datab => inst_aI3_aacc_c_a0_a_a3_a,
	cin => inst_aI3_aadd_89_aadder_aresult_node_acout_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a3_a,
	cout => inst_aI3_aadd_89_aadder_aresult_node_acout_a3_a);

inst_aI3_aMux_119_rtl_31_rtl_246_a0_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aMux_119_rtl_31_rtl_246_a0 = inst_aI2_aTD_c_a1_a & (inst_aI2_aTD_c_a0_a # inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a4_a_a17) # !inst_aI2_aTD_c_a1_a & !inst_aI2_aTD_c_a0_a & inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a3_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E5E0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a4_a_a17,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_119_rtl_31_rtl_246_a0);

inst_aI3_ai_a15_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_ai_a15 = inst_aI3_aacc_c_a0_a_a3_a # inst_aI3_adata_x_a3_a_a10

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI3_aacc_c_a0_a_a3_a,
	datad => inst_aI3_adata_x_a3_a_a10,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_ai_a15);

inst_aI3_aMux_119_rtl_31_rtl_246_a1_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aMux_119_rtl_31_rtl_246_a1 = inst_aI3_aMux_119_rtl_31_rtl_246_a0 & (inst_aI3_ai_a15 # !inst_aI2_aTD_c_a0_a) # !inst_aI3_aMux_119_rtl_31_rtl_246_a0 & inst_aI3_ai_a11 & inst_aI2_aTD_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F838",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_ai_a11,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_aMux_119_rtl_31_rtl_246_a0,
	datad => inst_aI3_ai_a15,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_119_rtl_31_rtl_246_a1);

rtl_a1470_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1470 = inst_aI2_aTD_c_a2_a & (inst_aI3_aacc_c_a0_a_a3_a $ inst_aI2_aTD_c_a1_a) # !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2EE2",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a2_a,
	datab => inst_aI2_aTD_c_a2_a,
	datac => inst_aI3_aacc_c_a0_a_a3_a,
	datad => inst_aI2_aTD_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1470);

inst_aI3_aMux_141_rtl_83_a0_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aMux_141_rtl_83_a0 = inst_aI2_aTC_c_a0_a $ inst_aI2_aTC_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0FF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI2_aTC_c_a0_a,
	datad => inst_aI2_aTC_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_141_rtl_83_a0);

inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a4_a_a13_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a4_a_a13 = inst_aI3_aacc_c_a0_a_a3_a & (inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a3_a_a21 # !inst_aI3_adata_x_a3_a_a10) # !inst_aI3_aacc_c_a0_a_a3_a & !inst_aI3_adata_x_a3_a_a10 & inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a3_a_a21

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CF0C",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI3_aacc_c_a0_a_a3_a,
	datac => inst_aI3_adata_x_a3_a_a10,
	datad => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a3_a_a21,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a4_a_a13);

rtl_a1680_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1680 = inst_aI2_aTD_c_a1_a & !inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a4_a_a13 # !inst_aI2_aTD_c_a1_a & inst_aI3_aadd_89_aadder_aresult_node_acout_a3_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "30FC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI2_aTD_c_a1_a,
	datad => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a4_a_a13,
	cin => inst_aI3_aadd_89_aadder_aresult_node_acout_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1680);

rtl_a1691_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1691 = inst_aI2_aTD_c_a2_a & inst_aI3_aMux_141_rtl_83_a0 & rtl_a1680 & !inst_aI2_aTD_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0080",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI3_aMux_141_rtl_83_a0,
	datac => rtl_a1680,
	datad => inst_aI2_aTD_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1691);

rtl_a1685_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1685 = inst_aI2_aTD_c_a0_a & inst_aI3_aacc_c_a0_a_a3_a # !inst_aI2_aTD_c_a0_a & inst_aI3_aacc_c_a0_a_a0_a & inst_aI2_aTD_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAC0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a3_a,
	datab => inst_aI3_aacc_c_a0_a_a0_a,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI2_aTD_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1685);

rtl_a1690_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1690 = rtl_a1691 # rtl_a1685 & !inst_aI2_aTD_c_a2_a & !inst_aI3_aMux_141_rtl_83_a0

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAAE",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a1691,
	datab => rtl_a1685,
	datac => inst_aI2_aTD_c_a2_a,
	datad => inst_aI3_aMux_141_rtl_83_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1690);

rtl_a1400_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1400 = !inst_aI2_aTD_c_a1_a & (inst_aI2_aTD_c_a2_a $ (inst_aI3_aMux_141_rtl_83_a0 # !inst_aI2_aTD_c_a0_a))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "002D",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI3_aMux_141_rtl_83_a0,
	datac => inst_aI2_aTD_c_a2_a,
	datad => inst_aI2_aTD_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1400);

rtl_a1468_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1468 = inst_aI3_aacc_c_a0_a_a4_a & (rtl_a1690 # rtl_a1400 # !rtl_a6586) # !inst_aI3_aacc_c_a0_a_a4_a & rtl_a1690 & rtl_a6586

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EACA",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a4_a,
	datab => rtl_a1690,
	datac => rtl_a6586,
	datad => rtl_a1400,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1468);

inst_aI3_aacc_c_a0_a_a4_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aacc_c_a0_a_a4_a = DFFEA(inst_aI3_ai_a135 & rtl_a1468 # !inst_aI3_ai_a135 & inst_aI3_aacc_c_a0_a_a4_a & !inst_aI3_ai_a128, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AA0C",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a1468,
	datab => inst_aI3_aacc_c_a0_a_a4_a,
	datac => inst_aI3_ai_a128,
	datad => inst_aI3_ai_a135,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI3_aacc_c_a0_a_a4_a);

rtl_a1408_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1408 = inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a4_a & !inst_aI2_aTD_c_a1_a # !inst_aI2_aTD_c_a2_a & (inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a4_a # !inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a3_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0AAC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a4_a,
	datab => inst_aI3_aacc_c_a0_a_a3_a,
	datac => inst_aI2_aTD_c_a2_a,
	datad => inst_aI2_aTD_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1408);

rtl_a1475_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1475 = rtl_a1470 & (rtl_a1408 # inst_aI2_aTD_c_a0_a) # !rtl_a1470 & rtl_a1408 & !inst_aI2_aTD_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => rtl_a1470,
	datac => rtl_a1408,
	datad => inst_aI2_aTD_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1475);

rtl_a6632_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a6632 = inst_aI3_aMux_141_rtl_83_a0 & inst_aI2_aTD_c_a2_a & inst_aI3_aMux_119_rtl_31_rtl_246_a1 # !inst_aI3_aMux_141_rtl_83_a0 & rtl_a1475

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88F0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI3_aMux_119_rtl_31_rtl_246_a1,
	datac => rtl_a1475,
	datad => inst_aI3_aMux_141_rtl_83_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a6632);

rtl_a1018_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1018 = inst_aI3_aacc_c_a0_a_a3_a & (inst_aI3_adata_x_a3_a_a10 $ inst_aI2_aTD_c_a0_a # !inst_aI2_aTD_c_a1_a) # !inst_aI3_aacc_c_a0_a_a3_a & inst_aI3_adata_x_a3_a_a10 & inst_aI2_aTD_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "6ACA",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a3_a,
	datab => inst_aI3_adata_x_a3_a_a10,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI2_aTD_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1018);

rtl_a1338_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1338 = rtl_a6632 # inst_aI3_aMux_141_rtl_83_a0 & rtl_a1018 & !inst_aI2_aTD_c_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAEA",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a6632,
	datab => inst_aI3_aMux_141_rtl_83_a0,
	datac => rtl_a1018,
	datad => inst_aI2_aTD_c_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1338);

inst_aI3_aacc_c_a0_a_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aacc_c_a0_a_a3_a = DFFEA(inst_aI3_aacc_a0_a_a3_a_a2125 & (rtl_a1338 # inst_aI3_aacc_c_a0_a_a3_a & inst_aI3_aacc_a0_a_a2_a_a33) # !inst_aI3_aacc_a0_a_a3_a_a2125 & inst_aI3_aacc_c_a0_a_a3_a & inst_aI3_aacc_a0_a_a2_a_a33, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EAC0",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_a0_a_a3_a_a2125,
	datab => inst_aI3_aacc_c_a0_a_a3_a,
	datac => inst_aI3_aacc_a0_a_a2_a_a33,
	datad => rtl_a1338,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI3_aacc_c_a0_a_a3_a);

rtl_a1419_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1419 = inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a3_a & !inst_aI2_aTD_c_a1_a # !inst_aI2_aTD_c_a2_a & (inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a3_a # !inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a2_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0AAC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a3_a,
	datab => inst_aI3_aacc_c_a0_a_a2_a,
	datac => inst_aI2_aTD_c_a2_a,
	datad => inst_aI2_aTD_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1419);

rtl_a1485_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1485 = rtl_a1480 & (rtl_a1419 # inst_aI2_aTD_c_a0_a) # !rtl_a1480 & rtl_a1419 & !inst_aI2_aTD_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => rtl_a1480,
	datac => rtl_a1419,
	datad => inst_aI2_aTD_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1485);

rtl_a6672_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a6672 = inst_aI3_aMux_141_rtl_83_a0 & inst_aI2_aTD_c_a2_a & inst_aI3_aMux_120_rtl_37_rtl_252_a1 # !inst_aI3_aMux_141_rtl_83_a0 & rtl_a1485

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88F0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI3_aMux_120_rtl_37_rtl_252_a1,
	datac => rtl_a1485,
	datad => inst_aI3_aMux_141_rtl_83_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a6672);

rtl_a1030_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1030 = inst_aI3_aacc_c_a0_a_a2_a & (inst_aI3_adata_x_a2_a_a13 $ inst_aI2_aTD_c_a0_a # !inst_aI2_aTD_c_a1_a) # !inst_aI3_aacc_c_a0_a_a2_a & inst_aI3_adata_x_a2_a_a13 & inst_aI2_aTD_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "6ACA",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a2_a,
	datab => inst_aI3_adata_x_a2_a_a13,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI2_aTD_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1030);

rtl_a1353_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1353 = rtl_a6672 # inst_aI3_aMux_141_rtl_83_a0 & rtl_a1030 & !inst_aI2_aTD_c_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAEA",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a6672,
	datab => inst_aI3_aMux_141_rtl_83_a0,
	datac => rtl_a1030,
	datad => inst_aI2_aTD_c_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1353);

inst_aI3_aacc_c_a0_a_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aacc_c_a0_a_a2_a = DFFEA(inst_aI3_aacc_a0_a_a3_a_a2125 & (rtl_a1353 # inst_aI3_aacc_c_a0_a_a2_a & inst_aI3_aacc_a0_a_a2_a_a33) # !inst_aI3_aacc_a0_a_a3_a_a2125 & inst_aI3_aacc_c_a0_a_a2_a & inst_aI3_aacc_a0_a_a2_a_a33, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EAC0",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_a0_a_a3_a_a2125,
	datab => inst_aI3_aacc_c_a0_a_a2_a,
	datac => inst_aI3_aacc_a0_a_a2_a_a33,
	datad => rtl_a1353,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI3_aacc_c_a0_a_a2_a);

rtl_a1430_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1430 = inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a2_a & !inst_aI2_aTD_c_a1_a # !inst_aI2_aTD_c_a2_a & (inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a2_a # !inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0AAC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a2_a,
	datab => inst_aI3_aacc_c_a0_a_a1_a,
	datac => inst_aI2_aTD_c_a2_a,
	datad => inst_aI2_aTD_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1430);

rtl_a1495_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1495 = rtl_a1490 & (rtl_a1430 # inst_aI2_aTD_c_a0_a) # !rtl_a1490 & rtl_a1430 & !inst_aI2_aTD_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => rtl_a1490,
	datac => rtl_a1430,
	datad => inst_aI2_aTD_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1495);

rtl_a6719_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a6719 = inst_aI3_aMux_141_rtl_83_a0 & inst_aI2_aTD_c_a2_a & inst_aI3_aMux_121_rtl_43_rtl_258_a1 # !inst_aI3_aMux_141_rtl_83_a0 & rtl_a1495

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88F0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI3_aMux_121_rtl_43_rtl_258_a1,
	datac => rtl_a1495,
	datad => inst_aI3_aMux_141_rtl_83_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a6719);

rtl_a6695_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a6695 = inst_aI3_aacc_c_a0_a_a1_a & (inst_aI2_aTD_c_a0_a $ !inst_aI3_adata_x_a1_a_a767 # !inst_aI2_aTD_c_a1_a) # !inst_aI3_aacc_c_a0_a_a1_a & !inst_aI3_adata_x_a1_a_a767 & inst_aI2_aTD_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "87AA",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a1_a,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_adata_x_a1_a_a767,
	datad => inst_aI2_aTD_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a6695);

rtl_a1368_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1368 = rtl_a6719 # inst_aI3_aMux_141_rtl_83_a0 & rtl_a6695 & !inst_aI2_aTD_c_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAEA",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a6719,
	datab => inst_aI3_aMux_141_rtl_83_a0,
	datac => rtl_a6695,
	datad => inst_aI2_aTD_c_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1368);

inst_aI3_aacc_c_a0_a_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aacc_c_a0_a_a1_a = DFFEA(inst_aI3_aacc_a0_a_a3_a_a2125 & (rtl_a1368 # inst_aI3_aacc_c_a0_a_a1_a & inst_aI3_aacc_a0_a_a2_a_a33) # !inst_aI3_aacc_a0_a_a3_a_a2125 & inst_aI3_aacc_c_a0_a_a1_a & inst_aI3_aacc_a0_a_a2_a_a33, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EAC0",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_a0_a_a3_a_a2125,
	datab => inst_aI3_aacc_c_a0_a_a1_a,
	datac => inst_aI3_aacc_a0_a_a2_a_a33,
	datad => rtl_a1368,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI3_aacc_c_a0_a_a1_a);

inst_aI4_aipage_we_c_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_aipage_we_c = DFFEA(!inst_aI4_areduce_nor_27_a23 & inst_aI4_ai_a254 & inst_aI4_ai_a385 & inst_aI4_ai_a2, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4000",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_areduce_nor_27_a23,
	datab => inst_aI4_ai_a254,
	datac => inst_aI4_ai_a385,
	datad => inst_aI4_ai_a2,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aipage_we_c);

inst_aI4_aipage_c_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_aipage_c_a1_a = DFFEA(inst_aI4_aipage_we_c & inst_aI3_aacc_c_a0_a_a1_a # !inst_aI4_aipage_we_c & inst_aI4_aipage_c_a1_a & inst_aI4_ai_a2, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAC0",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a1_a,
	datab => inst_aI4_aipage_c_a1_a,
	datac => inst_aI4_ai_a2,
	datad => inst_aI4_aipage_we_c,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aipage_c_a1_a);

rtl_a549_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a549 = inst_aI1_aMux_89_rtl_60_a0 & inst_aI1_astack_addrs_c_a3_a_a7_a # !inst_aI1_aMux_89_rtl_60_a0 & inst_aI1_astack_addrs_c_a2_a_a7_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88B8",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a3_a_a7_a,
	datab => inst_aI1_aMux_89_rtl_60_a0,
	datac => inst_aI1_astack_addrs_c_a2_a_a7_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a549);

inst_aI1_astack_addrs_c_a3_a_a7_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a7_a = DFFEA(rtl_a549, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datad => rtl_a549,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a7_a);

rtl_a1227_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1227 = inst_aI1_astack_addrs_c_a3_a_a7_a & (inst_aI1_astack_addrs_c_a1_a_a7_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a3_a_a7_a & inst_aI1_astack_addrs_c_a1_a_a7_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a3_a_a7_a,
	datac => inst_aI1_astack_addrs_c_a1_a_a7_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1227);

inst_aI1_astack_addrs_c_a2_a_a7_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a7_a = DFFEA(rtl_a1227 & (inst_aI1_astack_addrs_c_a2_a_a7_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1227 & inst_aI1_astack_addrs_c_a2_a_a7_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1227,
	datac => inst_aI1_astack_addrs_c_a2_a_a7_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a7_a);

rtl_a1147_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1147 = inst_aI1_astack_addrs_c_a2_a_a7_a & (inst_aI1_astack_addrs_c_a0_a_a7_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a2_a_a7_a & inst_aI1_astack_addrs_c_a0_a_a7_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a2_a_a7_a,
	datac => inst_aI1_astack_addrs_c_a0_a_a7_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1147);

inst_aI1_astack_addrs_c_a1_a_a7_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a7_a = DFFEA(rtl_a1147 & (inst_aI1_astack_addrs_c_a1_a_a7_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1147 & inst_aI1_astack_addrs_c_a1_a_a7_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1147,
	datac => inst_aI1_astack_addrs_c_a1_a_a7_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a7_a);

rtl_a1067_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1067 = inst_aI1_astack_addrs_c_a1_a_a7_a & (inst_aI1_aadd_87_aadder_aunreg_res_node_a7_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a1_a_a7_a & inst_aI1_aadd_87_aadder_aunreg_res_node_a7_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a1_a_a7_a,
	datac => inst_aI1_aadd_87_aadder_aunreg_res_node_a7_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1067);

inst_aI1_astack_addrs_c_a0_a_a7_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a7_a = DFFEA(rtl_a1067 & (inst_aI1_astack_addrs_c_a0_a_a7_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1067 & inst_aI1_astack_addrs_c_a0_a_a7_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1067,
	datac => inst_aI1_astack_addrs_c_a0_a_a7_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a7_a);

inst_aI1_apc_a7_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_apc_a7_a = DFFEA(inst_aI1_ai_a2 & (inst_aI1_aiaddr_x_a7_a_a166 # inst_aI1_astack_addrs_c_a0_a_a7_a & inst_aI1_aiaddr_x_a7_a_a2010), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A888",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => inst_aI1_aiaddr_x_a7_a_a166,
	datac => inst_aI1_astack_addrs_c_a0_a_a7_a,
	datad => inst_aI1_aiaddr_x_a7_a_a2010,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_apc_a7_a);

rtl_a552_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a552 = inst_aI1_aMux_89_rtl_60_a0 & inst_aI1_astack_addrs_c_a3_a_a6_a # !inst_aI1_aMux_89_rtl_60_a0 & inst_aI1_astack_addrs_c_a2_a_a6_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88B8",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a3_a_a6_a,
	datab => inst_aI1_aMux_89_rtl_60_a0,
	datac => inst_aI1_astack_addrs_c_a2_a_a6_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a552);

inst_aI1_astack_addrs_c_a3_a_a6_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a6_a = DFFEA(rtl_a552, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datad => rtl_a552,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a6_a);

rtl_a1237_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1237 = inst_aI1_astack_addrs_c_a3_a_a6_a & (inst_aI1_astack_addrs_c_a1_a_a6_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a3_a_a6_a & inst_aI1_astack_addrs_c_a1_a_a6_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a3_a_a6_a,
	datac => inst_aI1_astack_addrs_c_a1_a_a6_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1237);

inst_aI1_astack_addrs_c_a2_a_a6_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a6_a = DFFEA(rtl_a1237 & (inst_aI1_astack_addrs_c_a2_a_a6_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1237 & inst_aI1_astack_addrs_c_a2_a_a6_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1237,
	datac => inst_aI1_astack_addrs_c_a2_a_a6_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a6_a);

rtl_a1157_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1157 = inst_aI1_astack_addrs_c_a2_a_a6_a & (inst_aI1_astack_addrs_c_a0_a_a6_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a2_a_a6_a & inst_aI1_astack_addrs_c_a0_a_a6_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a2_a_a6_a,
	datac => inst_aI1_astack_addrs_c_a0_a_a6_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1157);

inst_aI1_astack_addrs_c_a1_a_a6_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a6_a = DFFEA(rtl_a1157 & (inst_aI1_astack_addrs_c_a1_a_a6_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1157 & inst_aI1_astack_addrs_c_a1_a_a6_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1157,
	datac => inst_aI1_astack_addrs_c_a1_a_a6_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a6_a);

rtl_a555_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a555 = inst_aI1_aMux_89_rtl_60_a0 & inst_aI1_astack_addrs_c_a3_a_a5_a # !inst_aI1_aMux_89_rtl_60_a0 & inst_aI1_astack_addrs_c_a2_a_a5_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88B8",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a3_a_a5_a,
	datab => inst_aI1_aMux_89_rtl_60_a0,
	datac => inst_aI1_astack_addrs_c_a2_a_a5_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a555);

inst_aI1_astack_addrs_c_a3_a_a5_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a5_a = DFFEA(rtl_a555, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datad => rtl_a555,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a5_a);

rtl_a1247_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1247 = inst_aI1_astack_addrs_c_a3_a_a5_a & (inst_aI1_astack_addrs_c_a1_a_a5_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a3_a_a5_a & inst_aI1_astack_addrs_c_a1_a_a5_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a3_a_a5_a,
	datac => inst_aI1_astack_addrs_c_a1_a_a5_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1247);

inst_aI1_astack_addrs_c_a2_a_a5_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a5_a = DFFEA(rtl_a1247 & (inst_aI1_astack_addrs_c_a2_a_a5_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1247 & inst_aI1_astack_addrs_c_a2_a_a5_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1247,
	datac => inst_aI1_astack_addrs_c_a2_a_a5_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a5_a);

rtl_a1167_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1167 = inst_aI1_astack_addrs_c_a2_a_a5_a & (inst_aI1_astack_addrs_c_a0_a_a5_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a2_a_a5_a & inst_aI1_astack_addrs_c_a0_a_a5_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a2_a_a5_a,
	datac => inst_aI1_astack_addrs_c_a0_a_a5_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1167);

inst_aI1_astack_addrs_c_a1_a_a5_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a5_a = DFFEA(rtl_a1167 & (inst_aI1_astack_addrs_c_a1_a_a5_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1167 & inst_aI1_astack_addrs_c_a1_a_a5_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1167,
	datac => inst_aI1_astack_addrs_c_a1_a_a5_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a5_a);

rtl_a558_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a558 = inst_aI1_aMux_89_rtl_60_a0 & inst_aI1_astack_addrs_c_a3_a_a4_a # !inst_aI1_aMux_89_rtl_60_a0 & inst_aI1_astack_addrs_c_a2_a_a4_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88B8",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a3_a_a4_a,
	datab => inst_aI1_aMux_89_rtl_60_a0,
	datac => inst_aI1_astack_addrs_c_a2_a_a4_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a558);

inst_aI1_astack_addrs_c_a3_a_a4_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a4_a = DFFEA(rtl_a558, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datad => rtl_a558,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a4_a);

rtl_a1257_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1257 = inst_aI1_astack_addrs_c_a3_a_a4_a & (inst_aI1_astack_addrs_c_a1_a_a4_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a3_a_a4_a & inst_aI1_astack_addrs_c_a1_a_a4_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a3_a_a4_a,
	datac => inst_aI1_astack_addrs_c_a1_a_a4_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1257);

inst_aI1_astack_addrs_c_a2_a_a4_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a4_a = DFFEA(rtl_a1257 & (inst_aI1_astack_addrs_c_a2_a_a4_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1257 & inst_aI1_astack_addrs_c_a2_a_a4_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1257,
	datac => inst_aI1_astack_addrs_c_a2_a_a4_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a4_a);

rtl_a1177_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1177 = inst_aI1_astack_addrs_c_a2_a_a4_a & (inst_aI1_astack_addrs_c_a0_a_a4_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a2_a_a4_a & inst_aI1_astack_addrs_c_a0_a_a4_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a2_a_a4_a,
	datac => inst_aI1_astack_addrs_c_a0_a_a4_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1177);

inst_aI1_astack_addrs_c_a1_a_a4_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a4_a = DFFEA(rtl_a1177 & (inst_aI1_astack_addrs_c_a1_a_a4_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1177 & inst_aI1_astack_addrs_c_a1_a_a4_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1177,
	datac => inst_aI1_astack_addrs_c_a1_a_a4_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a4_a);

rtl_a561_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a561 = inst_aI1_aMux_89_rtl_60_a0 & inst_aI1_astack_addrs_c_a3_a_a3_a # !inst_aI1_aMux_89_rtl_60_a0 & inst_aI1_astack_addrs_c_a2_a_a3_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88B8",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a3_a_a3_a,
	datab => inst_aI1_aMux_89_rtl_60_a0,
	datac => inst_aI1_astack_addrs_c_a2_a_a3_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a561);

inst_aI1_astack_addrs_c_a3_a_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a3_a = DFFEA(rtl_a561, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datad => rtl_a561,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a3_a);

rtl_a1267_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1267 = inst_aI1_astack_addrs_c_a3_a_a3_a & (inst_aI1_astack_addrs_c_a1_a_a3_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a3_a_a3_a & inst_aI1_astack_addrs_c_a1_a_a3_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a3_a_a3_a,
	datac => inst_aI1_astack_addrs_c_a1_a_a3_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1267);

inst_aI1_astack_addrs_c_a2_a_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a3_a = DFFEA(rtl_a1267 & (inst_aI1_astack_addrs_c_a2_a_a3_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1267 & inst_aI1_astack_addrs_c_a2_a_a3_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1267,
	datac => inst_aI1_astack_addrs_c_a2_a_a3_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a3_a);

rtl_a1187_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1187 = inst_aI1_astack_addrs_c_a2_a_a3_a & (inst_aI1_astack_addrs_c_a0_a_a3_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a2_a_a3_a & inst_aI1_astack_addrs_c_a0_a_a3_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a2_a_a3_a,
	datac => inst_aI1_astack_addrs_c_a0_a_a3_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1187);

inst_aI1_astack_addrs_c_a1_a_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a3_a = DFFEA(rtl_a1187 & (inst_aI1_astack_addrs_c_a1_a_a3_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1187 & inst_aI1_astack_addrs_c_a1_a_a3_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1187,
	datac => inst_aI1_astack_addrs_c_a1_a_a3_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a3_a);

rtl_a567_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a567 = inst_aI1_aMux_89_rtl_60_a0 & inst_aI1_astack_addrs_c_a3_a_a1_a # !inst_aI1_aMux_89_rtl_60_a0 & inst_aI1_astack_addrs_c_a2_a_a1_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88B8",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a3_a_a1_a,
	datab => inst_aI1_aMux_89_rtl_60_a0,
	datac => inst_aI1_astack_addrs_c_a2_a_a1_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a567);

inst_aI1_astack_addrs_c_a3_a_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a1_a = DFFEA(rtl_a567, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datad => rtl_a567,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a1_a);

rtl_a1287_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1287 = inst_aI1_astack_addrs_c_a3_a_a1_a & (inst_aI1_astack_addrs_c_a1_a_a1_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a3_a_a1_a & inst_aI1_astack_addrs_c_a1_a_a1_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a3_a_a1_a,
	datac => inst_aI1_astack_addrs_c_a1_a_a1_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1287);

inst_aI1_astack_addrs_c_a2_a_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a1_a = DFFEA(rtl_a1287 & (inst_aI1_astack_addrs_c_a2_a_a1_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1287 & inst_aI1_astack_addrs_c_a2_a_a1_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1287,
	datac => inst_aI1_astack_addrs_c_a2_a_a1_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a1_a);

rtl_a1207_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1207 = inst_aI1_astack_addrs_c_a2_a_a1_a & (inst_aI1_astack_addrs_c_a0_a_a1_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a2_a_a1_a & inst_aI1_astack_addrs_c_a0_a_a1_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a2_a_a1_a,
	datac => inst_aI1_astack_addrs_c_a0_a_a1_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1207);

inst_aI1_astack_addrs_c_a1_a_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a1_a = DFFEA(rtl_a1207 & (inst_aI1_astack_addrs_c_a1_a_a1_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1207 & inst_aI1_astack_addrs_c_a1_a_a1_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1207,
	datac => inst_aI1_astack_addrs_c_a1_a_a1_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a1_a);

inst_aI1_apc_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_apc_a0_a = DFFEA(inst_aI1_aiaddr_x_a0_a_a289, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )
-- inst_aI1_aadd_87_aadder_aresult_node_acout_a0_a = CARRY(inst_aI1_apc_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	packed_mode => "false",
	lut_mask => "CCAA",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_apc_a0_a,
	datab => inst_aI1_aiaddr_x_a0_a_a289,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_apc_a0_a,
	cout => inst_aI1_aadd_87_aadder_aresult_node_acout_a0_a);

inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a1_a = inst_aI1_apc_a1_a $ inst_aI1_aadd_87_aadder_aresult_node_acout_a0_a
-- inst_aI1_aadd_87_aadder_aresult_node_acout_a1_a = CARRY(inst_aI1_apc_a1_a & inst_aI1_aadd_87_aadder_aresult_node_acout_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3CC0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_apc_a1_a,
	cin => inst_aI1_aadd_87_aadder_aresult_node_acout_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a1_a,
	cout => inst_aI1_aadd_87_aadder_aresult_node_acout_a1_a);

rtl_a1127_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1127 = inst_aI1_astack_addrs_c_a1_a_a1_a & (inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a1_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a1_a_a1_a & inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a1_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a1_a_a1_a,
	datac => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a1_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1127);

inst_aI1_astack_addrs_c_a0_a_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a1_a = DFFEA(rtl_a1127 & (inst_aI1_astack_addrs_c_a0_a_a1_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1127 & inst_aI1_astack_addrs_c_a0_a_a1_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1127,
	datac => inst_aI1_astack_addrs_c_a0_a_a1_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a1_a);

inst_aI1_apc_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_apc_a1_a = DFFEA(inst_aI1_ai_a2 & (inst_aI1_aiaddr_x_a1_a_a268 # inst_aI1_aiaddr_x_a7_a_a2010 & inst_aI1_astack_addrs_c_a0_a_a1_a), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A888",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => inst_aI1_aiaddr_x_a1_a_a268,
	datac => inst_aI1_aiaddr_x_a7_a_a2010,
	datad => inst_aI1_astack_addrs_c_a0_a_a1_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_apc_a1_a);

inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a2_a = inst_aI1_apc_a2_a $ inst_aI1_aadd_87_aadder_aresult_node_acout_a1_a
-- inst_aI1_aadd_87_aadder_aresult_node_acout_a2_a = CARRY(inst_aI1_apc_a2_a & inst_aI1_aadd_87_aadder_aresult_node_acout_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3CC0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_apc_a2_a,
	cin => inst_aI1_aadd_87_aadder_aresult_node_acout_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a2_a,
	cout => inst_aI1_aadd_87_aadder_aresult_node_acout_a2_a);

inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a3_a = inst_aI1_apc_a3_a $ inst_aI1_aadd_87_aadder_aresult_node_acout_a2_a
-- inst_aI1_aadd_87_aadder_aresult_node_acout_a3_a = CARRY(inst_aI1_apc_a3_a & inst_aI1_aadd_87_aadder_aresult_node_acout_a2_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3CC0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_apc_a3_a,
	cin => inst_aI1_aadd_87_aadder_aresult_node_acout_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a3_a,
	cout => inst_aI1_aadd_87_aadder_aresult_node_acout_a3_a);

rtl_a1107_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1107 = inst_aI1_astack_addrs_c_a1_a_a3_a & (inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a3_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a1_a_a3_a & inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a3_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a1_a_a3_a,
	datac => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a3_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1107);

inst_aI1_astack_addrs_c_a0_a_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a3_a = DFFEA(rtl_a1107 & (inst_aI1_astack_addrs_c_a0_a_a3_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1107 & inst_aI1_astack_addrs_c_a0_a_a3_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1107,
	datac => inst_aI1_astack_addrs_c_a0_a_a3_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a3_a);

inst_aI1_apc_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_apc_a3_a = DFFEA(inst_aI1_ai_a2 & (inst_aI1_aiaddr_x_a3_a_a234 # inst_aI1_aiaddr_x_a7_a_a2010 & inst_aI1_astack_addrs_c_a0_a_a3_a), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A888",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => inst_aI1_aiaddr_x_a3_a_a234,
	datac => inst_aI1_aiaddr_x_a7_a_a2010,
	datad => inst_aI1_astack_addrs_c_a0_a_a3_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_apc_a3_a);

inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a4_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a4_a = inst_aI1_apc_a4_a $ inst_aI1_aadd_87_aadder_aresult_node_acout_a3_a
-- inst_aI1_aadd_87_aadder_aresult_node_acout_a4_a = CARRY(inst_aI1_apc_a4_a & inst_aI1_aadd_87_aadder_aresult_node_acout_a3_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3CC0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_apc_a4_a,
	cin => inst_aI1_aadd_87_aadder_aresult_node_acout_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a4_a,
	cout => inst_aI1_aadd_87_aadder_aresult_node_acout_a4_a);

rtl_a1097_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1097 = inst_aI1_astack_addrs_c_a1_a_a4_a & (inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a4_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a1_a_a4_a & inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a4_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a1_a_a4_a,
	datac => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a4_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1097);

inst_aI1_astack_addrs_c_a0_a_a4_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a4_a = DFFEA(rtl_a1097 & (inst_aI1_astack_addrs_c_a0_a_a4_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1097 & inst_aI1_astack_addrs_c_a0_a_a4_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1097,
	datac => inst_aI1_astack_addrs_c_a0_a_a4_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a4_a);

inst_aI1_apc_a4_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_apc_a4_a = DFFEA(inst_aI1_ai_a2 & (inst_aI1_aiaddr_x_a4_a_a217 # inst_aI1_aiaddr_x_a7_a_a2010 & inst_aI1_astack_addrs_c_a0_a_a4_a), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A888",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => inst_aI1_aiaddr_x_a4_a_a217,
	datac => inst_aI1_aiaddr_x_a7_a_a2010,
	datad => inst_aI1_astack_addrs_c_a0_a_a4_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_apc_a4_a);

inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a5_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a5_a = inst_aI1_apc_a5_a $ inst_aI1_aadd_87_aadder_aresult_node_acout_a4_a
-- inst_aI1_aadd_87_aadder_aresult_node_acout_a5_a = CARRY(inst_aI1_apc_a5_a & inst_aI1_aadd_87_aadder_aresult_node_acout_a4_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3CC0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_apc_a5_a,
	cin => inst_aI1_aadd_87_aadder_aresult_node_acout_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a5_a,
	cout => inst_aI1_aadd_87_aadder_aresult_node_acout_a5_a);

rtl_a1087_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1087 = inst_aI1_astack_addrs_c_a1_a_a5_a & (inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a5_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a1_a_a5_a & inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a5_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a1_a_a5_a,
	datac => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a5_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1087);

inst_aI1_astack_addrs_c_a0_a_a5_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a5_a = DFFEA(rtl_a1087 & (inst_aI1_astack_addrs_c_a0_a_a5_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1087 & inst_aI1_astack_addrs_c_a0_a_a5_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1087,
	datac => inst_aI1_astack_addrs_c_a0_a_a5_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a5_a);

inst_aI1_apc_a5_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_apc_a5_a = DFFEA(inst_aI1_ai_a2 & (inst_aI1_aiaddr_x_a5_a_a200 # inst_aI1_aiaddr_x_a7_a_a2010 & inst_aI1_astack_addrs_c_a0_a_a5_a), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A888",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => inst_aI1_aiaddr_x_a5_a_a200,
	datac => inst_aI1_aiaddr_x_a7_a_a2010,
	datad => inst_aI1_astack_addrs_c_a0_a_a5_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_apc_a5_a);

inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a6_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a6_a = inst_aI1_apc_a6_a $ inst_aI1_aadd_87_aadder_aresult_node_acout_a5_a
-- inst_aI1_aadd_87_aadder_aresult_node_acout_a6_a = CARRY(inst_aI1_apc_a6_a & inst_aI1_aadd_87_aadder_aresult_node_acout_a5_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3CC0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_apc_a6_a,
	cin => inst_aI1_aadd_87_aadder_aresult_node_acout_a5_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a6_a,
	cout => inst_aI1_aadd_87_aadder_aresult_node_acout_a6_a);

rtl_a1077_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1077 = inst_aI1_astack_addrs_c_a1_a_a6_a & (inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a6_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a1_a_a6_a & inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a6_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a1_a_a6_a,
	datac => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a6_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1077);

inst_aI1_astack_addrs_c_a0_a_a6_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a6_a = DFFEA(rtl_a1077 & (inst_aI1_astack_addrs_c_a0_a_a6_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1077 & inst_aI1_astack_addrs_c_a0_a_a6_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1077,
	datac => inst_aI1_astack_addrs_c_a0_a_a6_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a6_a);

inst_aI1_apc_a6_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_apc_a6_a = DFFEA(inst_aI1_ai_a2 & (inst_aI1_aiaddr_x_a6_a_a183 # inst_aI1_aiaddr_x_a7_a_a2010 & inst_aI1_astack_addrs_c_a0_a_a6_a), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A888",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => inst_aI1_aiaddr_x_a6_a_a183,
	datac => inst_aI1_aiaddr_x_a7_a_a2010,
	datad => inst_aI1_astack_addrs_c_a0_a_a6_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_apc_a6_a);

inst_aI1_aadd_87_aadder_aunreg_res_node_a7_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aadd_87_aadder_aunreg_res_node_a7_a = inst_aI1_aadd_87_aadder_aresult_node_acout_a6_a $ inst_aI1_apc_a7_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "0FF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datad => inst_aI1_apc_a7_a,
	cin => inst_aI1_aadd_87_aadder_aresult_node_acout_a6_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aadd_87_aadder_aunreg_res_node_a7_a);

inst_aI2_ai_a519_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_ai_a519 = inst_aI2_aTC_x_a0_a_a120 & inst_aI2_aTC_x_a2_a_a113 & (!inst_aI2_aTC_x_a1_a_a1 # !inst_aI3_askip_l_a1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0888",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_x_a0_a_a120,
	datab => inst_aI2_aTC_x_a2_a_a113,
	datac => inst_aI3_askip_l_a1,
	datad => inst_aI2_aTC_x_a1_a_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_ai_a519);

inst_aI2_aC_jmp_a85_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aC_jmp_a85 = inst_aI2_aTC_x_a0_a_a120 # !inst_aI2_aMux_58_a0 # !inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a # !nreset_adataout

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BFFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_x_a0_a_a120,
	datab => nreset_adataout,
	datac => inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a,
	datad => inst_aI2_aMux_58_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aC_jmp_a85);

inst_aI2_ai_a490_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_ai_a490 = inst_aI2_aTC_x_a2_a_a113 & !inst_aI3_askip_l_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00F0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI2_aTC_x_a2_a_a113,
	datad => inst_aI3_askip_l_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_ai_a490);

inst_aI2_ai_a494_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_ai_a494 = inst_aI2_ai_a519 & (inst_aI2_aC_jmp_a85 # !inst_aI2_ai_a490) # !inst_aI2_ai_a519 & !inst_aI2_aC_raw_a13 & (inst_aI2_aC_jmp_a85 # !inst_aI2_ai_a490)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8ACF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_ai_a519,
	datab => inst_aI2_aC_jmp_a85,
	datac => inst_aI2_ai_a490,
	datad => inst_aI2_aC_raw_a13,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_ai_a494);

inst_aI2_apc_mux_x_a0_a_a8_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_apc_mux_x_a0_a_a8 = inst_aI2_ai_a494 # inst_aI3_askip_l_a1 # !inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a # !nreset_adataout

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EFFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_ai_a494,
	datab => inst_aI3_askip_l_a1,
	datac => nreset_adataout,
	datad => inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_apc_mux_x_a0_a_a8);

inst_aI1_aiaddr_x_a7_a_a154_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a7_a_a154 = inst_aI1_aadd_87_aadder_aunreg_res_node_a7_a & (inst_aI1_apc_a7_a # inst_aI2_apc_mux_x_a0_a_a8) # !inst_aI1_aadd_87_aadder_aunreg_res_node_a7_a & inst_aI1_apc_a7_a & !inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_aadd_87_aadder_aunreg_res_node_a7_a,
	datac => inst_aI1_apc_a7_a,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a7_a_a154);

inst_aI1_aiaddr_x_a7_a_a166_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a7_a_a166 = !inst_aI2_apc_mux_x_a2_a_a24 & (inst_aI2_apc_mux_x_a1_a_a46 & inst_aI4_aipage_c_a1_a # !inst_aI2_apc_mux_x_a1_a_a46 & inst_aI1_aiaddr_x_a7_a_a154)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00AC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aipage_c_a1_a,
	datab => inst_aI1_aiaddr_x_a7_a_a154,
	datac => inst_aI2_apc_mux_x_a1_a_a46,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a7_a_a166);

inst_aI1_aiaddr_x_a7_a_a170_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a7_a_a170 = inst_aI1_ai_a2 & (inst_aI1_aiaddr_x_a7_a_a166 # inst_aI1_astack_addrs_c_a0_a_a7_a & inst_aI1_aiaddr_x_a7_a_a2010)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A888",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => inst_aI1_aiaddr_x_a7_a_a166,
	datac => inst_aI1_astack_addrs_c_a0_a_a7_a,
	datad => inst_aI1_aiaddr_x_a7_a_a2010,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a7_a_a170);

inst1_alpm_rom_component_asrom_asegment_a0_a_a2_a : flex10ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000100000010000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100010001000100000000000",
	operation_mode => "rom",
	logical_ram_name => "lpm_rom0:inst1|lpm_rom:lpm_rom_component|altrom:srom|content",
	init_file => "../rom.mif",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 2,
	data_in_clock => "none",
	data_in_clear => "none",
	write_logic_clock => "none",
	write_enable_clear => "none",
	write_address_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none")
-- pragma translate_on
PORT MAP (
	clk0 => clk_adataout,
	waddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a2_a_waddr,
	raddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a2_a_raddr,
	devclrn => devclrn,
	devpor => devpor,
	modesel => inst1_alpm_rom_component_asrom_asegment_a0_a_a2_a_modesel,
	dataout => inst1_alpm_rom_component_asrom_aq_a2_a);

inst_aI2_aTC_x_a2_a_a225_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aTC_x_a2_a_a225 = inst1_alpm_rom_component_asrom_aq_a6_a & inst1_alpm_rom_component_asrom_aq_a7_a & !inst1_alpm_rom_component_asrom_aq_a5_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00C0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst1_alpm_rom_component_asrom_aq_a6_a,
	datac => inst1_alpm_rom_component_asrom_aq_a7_a,
	datad => inst1_alpm_rom_component_asrom_aq_a5_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aTC_x_a2_a_a225);

inst_aI2_aTC_x_a0_a_a114_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aTC_x_a0_a_a114 = inst1_alpm_rom_component_asrom_aq_a1_a # inst1_alpm_rom_component_asrom_aq_a2_a # inst_aI2_aTC_x_a2_a_a225 & !inst1_alpm_rom_component_asrom_aq_a4_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EEFE",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_alpm_rom_component_asrom_aq_a1_a,
	datab => inst1_alpm_rom_component_asrom_aq_a2_a,
	datac => inst_aI2_aTC_x_a2_a_a225,
	datad => inst1_alpm_rom_component_asrom_aq_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aTC_x_a0_a_a114);

inst_aI2_aTC_x_a0_a_a121_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aTC_x_a0_a_a121 = inst_aI2_aTC_x_a0_a_a114 & nreset_adataout & !inst1_alpm_rom_component_asrom_aq_a3_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00C0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI2_aTC_x_a0_a_a114,
	datac => nreset_adataout,
	datad => inst1_alpm_rom_component_asrom_aq_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aTC_x_a0_a_a121);

inst_aI2_aTC_c_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aTC_c_a0_a = DFFEA(inst_aI2_aTC_x_a0_a_a121 # inst1_alpm_rom_component_asrom_aq_a0_a & nreset_adataout & inst_aI2_aTD_x_a3_a_a9, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EAAA",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_x_a0_a_a121,
	datab => inst1_alpm_rom_component_asrom_aq_a0_a,
	datac => nreset_adataout,
	datad => inst_aI2_aTD_x_a3_a_a9,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_aTC_c_a0_a);

inst_aI2_aTD_c_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aTD_c_a3_a = DFFEA(inst_aI2_aTD_x_a3_a_a9 & rtl_a6467 & inst1_alpm_rom_component_asrom_aq_a7_a & !inst1_alpm_rom_component_asrom_aq_a6_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0080",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_x_a3_a_a9,
	datab => rtl_a6467,
	datac => inst1_alpm_rom_component_asrom_aq_a7_a,
	datad => inst1_alpm_rom_component_asrom_aq_a6_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_aTD_c_a3_a);

rtl_a6586_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a6586 = !inst_aI2_aTC_c_a2_a & !inst_aI2_aTD_c_a3_a & (!inst_aI2_aTC_c_a0_a # !inst_aI2_aTC_c_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0007",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_c_a1_a,
	datab => inst_aI2_aTC_c_a0_a,
	datac => inst_aI2_aTC_c_a2_a,
	datad => inst_aI2_aTD_c_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a6586);

inst_aI3_aacc_a0_a_a3_a_a2125_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a3_a_a2125 = inst_aI3_ai_a135 & rtl_a6586

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI3_ai_a135,
	datad => rtl_a6586,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a3_a_a2125);

rtl_a1057_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1057 = inst_aI3_aacc_c_a0_a_a1_a & !inst_aI3_aMux_141_rtl_83_a0 & (inst_aI2_aTD_c_a2_a $ !inst_aI2_aTD_c_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0082",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a1_a,
	datab => inst_aI2_aTD_c_a2_a,
	datac => inst_aI2_aTD_c_a0_a,
	datad => inst_aI3_aMux_141_rtl_83_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1057);

rtl_a6745_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a6745 = rtl_a1057 # inst_aI3_aMux_141_rtl_83_a0 & inst_aI2_aTD_c_a0_a & inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EAAA",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a1057,
	datab => inst_aI3_aMux_141_rtl_83_a0,
	datac => inst_aI2_aTD_c_a0_a,
	datad => inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a6745);

rtl_a1054_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1054 = rtl_a6745 # inst_aI3_aMux_141_rtl_83_a0 & !inst_aI3_adata_x_a0_a_a768 & !inst_aI2_aTD_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAAE",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a6745,
	datab => inst_aI3_aMux_141_rtl_83_a0,
	datac => inst_aI3_adata_x_a0_a_a768,
	datad => inst_aI2_aTD_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1054);

rtl_a1447_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1447 = inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a1_a & !inst_aI2_aTD_c_a0_a # !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a4_a & inst_aI2_aTD_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0AC0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a4_a,
	datab => inst_aI3_aacc_c_a0_a_a1_a,
	datac => inst_aI2_aTD_c_a2_a,
	datad => inst_aI2_aTD_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1447);

rtl_a1446_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1446 = rtl_a1447 # inst_aI3_aacc_c_a0_a_a0_a & (inst_aI2_aTD_c_a2_a $ !inst_aI2_aTD_c_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EAAE",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a1447,
	datab => inst_aI3_aacc_c_a0_a_a0_a,
	datac => inst_aI2_aTD_c_a2_a,
	datad => inst_aI2_aTD_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1446);

rtl_a6768_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a6768 = inst_aI2_aTD_c_a2_a & inst_aI2_aTD_c_a0_a & !inst_aI3_aacc_c_a0_a_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00C0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI2_aTD_c_a2_a,
	datac => inst_aI2_aTD_c_a0_a,
	datad => inst_aI3_aacc_c_a0_a_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a6768);

inst_aI3_ai_a8_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_ai_a8 = inst_aI3_aacc_c_a0_a_a0_a & !inst_aI3_adata_x_a0_a_a768

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00F0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI3_aacc_c_a0_a_a0_a,
	datad => inst_aI3_adata_x_a0_a_a768,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_ai_a8);

inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a1_a_a40_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a1_a_a40 = inst_aI3_aacc_c_a0_a_a0_a $ inst_aI3_adata_x_a0_a_a768

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0FF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI3_aacc_c_a0_a_a0_a,
	datad => inst_aI3_adata_x_a0_a_a768,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a1_a_a40);

inst_aI3_aMux_122_rtl_49_rtl_264_a0_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aMux_122_rtl_49_rtl_264_a0 = inst_aI2_aTD_c_a1_a & (inst_aI2_aTD_c_a0_a # !inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a1_a_a40) # !inst_aI2_aTD_c_a1_a & !inst_aI2_aTD_c_a0_a & inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "B5B0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI3_aadd_105_aadder_aresult_node_acs_buffer_a1_a_a40,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI3_aadd_89_aadder_aresult_node_acs_buffer_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_122_rtl_49_rtl_264_a0);

inst_aI3_ai_a12_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_ai_a12 = inst_aI3_aacc_c_a0_a_a0_a # !inst_aI3_adata_x_a0_a_a768

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0FF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI3_aacc_c_a0_a_a0_a,
	datad => inst_aI3_adata_x_a0_a_a768,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_ai_a12);

inst_aI3_aMux_122_rtl_49_rtl_264_a1_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aMux_122_rtl_49_rtl_264_a1 = inst_aI3_aMux_122_rtl_49_rtl_264_a0 & (inst_aI3_ai_a12 # !inst_aI2_aTD_c_a0_a) # !inst_aI3_aMux_122_rtl_49_rtl_264_a0 & inst_aI3_ai_a8 & inst_aI2_aTD_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F838",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_ai_a8,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_aMux_122_rtl_49_rtl_264_a0,
	datad => inst_aI3_ai_a12,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_122_rtl_49_rtl_264_a1);

rtl_a824_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a824 = inst_aI3_aacc_c_a0_a_a0_a & inst_aI3_aMux_141_rtl_83_a0 & !inst_aI2_aTD_c_a1_a & !inst_aI2_aTD_c_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0008",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a0_a,
	datab => inst_aI3_aMux_141_rtl_83_a0,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI2_aTD_c_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a824);

rtl_a6788_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a6788 = !rtl_a824 & (!inst_aI3_aMux_122_rtl_49_rtl_264_a1 # !inst_aI3_aMux_141_rtl_83_a0 # !inst_aI2_aTD_c_a2_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "007F",
	clock_enable_mode => "false",
	output_mode => "none")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI3_aMux_141_rtl_83_a0,
	datac => inst_aI3_aMux_122_rtl_49_rtl_264_a1,
	datad => rtl_a824,
	devclrn => devclrn,
	devpor => devpor,
	cascout => rtl_a6788);

rtl_a6831_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a6831 = (inst_aI3_aMux_141_rtl_83_a0 # inst_aI2_aTD_c_a1_a & !rtl_a6768 # !inst_aI2_aTD_c_a1_a & !rtl_a1446) & CASCADE(rtl_a6788)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ABEF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aMux_141_rtl_83_a0,
	datab => inst_aI2_aTD_c_a1_a,
	datac => rtl_a1446,
	datad => rtl_a6768,
	cascin => rtl_a6788,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a6831);

rtl_a1456_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1456 = rtl_a1054 & inst_aI2_aTD_c_a1_a & !inst_aI2_aTD_c_a2_a # !rtl_a6831

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "08FF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a1054,
	datab => inst_aI2_aTD_c_a1_a,
	datac => inst_aI2_aTD_c_a2_a,
	datad => rtl_a6831,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1456);

inst_aI3_aacc_c_a0_a_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_aacc_c_a0_a_a0_a = DFFEA(inst_aI3_aacc_a0_a_a3_a_a2125 & (rtl_a1456 # inst_aI3_aacc_c_a0_a_a0_a & inst_aI3_aacc_a0_a_a2_a_a33) # !inst_aI3_aacc_a0_a_a3_a_a2125 & inst_aI3_aacc_c_a0_a_a0_a & inst_aI3_aacc_a0_a_a2_a_a33, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EAC0",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_a0_a_a3_a_a2125,
	datab => inst_aI3_aacc_c_a0_a_a0_a,
	datac => inst_aI3_aacc_a0_a_a2_a_a33,
	datad => rtl_a1456,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI3_aacc_c_a0_a_a0_a);

inst_aI4_aipage_c_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_aipage_c_a0_a = DFFEA(inst_aI4_aipage_we_c & inst_aI3_aacc_c_a0_a_a0_a # !inst_aI4_aipage_we_c & inst_aI4_aipage_c_a0_a & inst_aI4_ai_a2, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAC0",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a0_a,
	datab => inst_aI4_aipage_c_a0_a,
	datac => inst_aI4_ai_a2,
	datad => inst_aI4_aipage_we_c,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aipage_c_a0_a);

inst_aI1_aiaddr_x_a6_a_a171_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a6_a_a171 = inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a6_a & (inst_aI1_apc_a6_a # inst_aI2_apc_mux_x_a0_a_a8) # !inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a6_a & inst_aI1_apc_a6_a & !inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a6_a,
	datac => inst_aI1_apc_a6_a,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a6_a_a171);

inst_aI1_aiaddr_x_a6_a_a183_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a6_a_a183 = !inst_aI2_apc_mux_x_a2_a_a24 & (inst_aI2_apc_mux_x_a1_a_a46 & inst_aI4_aipage_c_a0_a # !inst_aI2_apc_mux_x_a1_a_a46 & inst_aI1_aiaddr_x_a6_a_a171)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00AC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aipage_c_a0_a,
	datab => inst_aI1_aiaddr_x_a6_a_a171,
	datac => inst_aI2_apc_mux_x_a1_a_a46,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a6_a_a183);

inst_aI1_aiaddr_x_a6_a_a187_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a6_a_a187 = inst_aI1_ai_a2 & (inst_aI1_aiaddr_x_a6_a_a183 # inst_aI1_aiaddr_x_a7_a_a2010 & inst_aI1_astack_addrs_c_a0_a_a6_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A888",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => inst_aI1_aiaddr_x_a6_a_a183,
	datac => inst_aI1_aiaddr_x_a7_a_a2010,
	datad => inst_aI1_astack_addrs_c_a0_a_a6_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a6_a_a187);

inst1_alpm_rom_component_asrom_asegment_a0_a_a9_a : flex10ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	operation_mode => "rom",
	logical_ram_name => "lpm_rom0:inst1|lpm_rom:lpm_rom_component|altrom:srom|content",
	init_file => "../rom.mif",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 9,
	data_in_clock => "none",
	data_in_clear => "none",
	write_logic_clock => "none",
	write_enable_clear => "none",
	write_address_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none")
-- pragma translate_on
PORT MAP (
	clk0 => clk_adataout,
	waddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a9_a_waddr,
	raddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a9_a_raddr,
	devclrn => devclrn,
	devpor => devpor,
	modesel => inst1_alpm_rom_component_asrom_asegment_a0_a_a9_a_modesel,
	dataout => inst1_alpm_rom_component_asrom_aq_a9_a);

inst_aI1_aiaddr_x_a5_a_a188_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a5_a_a188 = inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a5_a & (inst_aI1_apc_a5_a # inst_aI2_apc_mux_x_a0_a_a8) # !inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a5_a & inst_aI1_apc_a5_a & !inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a5_a,
	datac => inst_aI1_apc_a5_a,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a5_a_a188);

inst_aI1_aiaddr_x_a5_a_a200_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a5_a_a200 = !inst_aI2_apc_mux_x_a2_a_a24 & (inst_aI2_apc_mux_x_a1_a_a46 & inst1_alpm_rom_component_asrom_aq_a9_a # !inst_aI2_apc_mux_x_a1_a_a46 & inst_aI1_aiaddr_x_a5_a_a188)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00AC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_alpm_rom_component_asrom_aq_a9_a,
	datab => inst_aI1_aiaddr_x_a5_a_a188,
	datac => inst_aI2_apc_mux_x_a1_a_a46,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a5_a_a200);

inst_aI1_aiaddr_x_a5_a_a204_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a5_a_a204 = inst_aI1_ai_a2 & (inst_aI1_aiaddr_x_a5_a_a200 # inst_aI1_aiaddr_x_a7_a_a2010 & inst_aI1_astack_addrs_c_a0_a_a5_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A888",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => inst_aI1_aiaddr_x_a5_a_a200,
	datac => inst_aI1_aiaddr_x_a7_a_a2010,
	datad => inst_aI1_astack_addrs_c_a0_a_a5_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a5_a_a204);

inst1_alpm_rom_component_asrom_asegment_a0_a_a8_a : flex10ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110001011000101100010110001000000000000000000000000000000000000000000000000000001010101010100000000000000000000000000000000000000010010001000100011000000000",
	operation_mode => "rom",
	logical_ram_name => "lpm_rom0:inst1|lpm_rom:lpm_rom_component|altrom:srom|content",
	init_file => "../rom.mif",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 8,
	data_in_clock => "none",
	data_in_clear => "none",
	write_logic_clock => "none",
	write_enable_clear => "none",
	write_address_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none")
-- pragma translate_on
PORT MAP (
	clk0 => clk_adataout,
	waddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a8_a_waddr,
	raddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a8_a_raddr,
	devclrn => devclrn,
	devpor => devpor,
	modesel => inst1_alpm_rom_component_asrom_asegment_a0_a_a8_a_modesel,
	dataout => inst1_alpm_rom_component_asrom_aq_a8_a);

inst_aI1_aiaddr_x_a4_a_a205_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a4_a_a205 = inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a4_a & (inst_aI1_apc_a4_a # inst_aI2_apc_mux_x_a0_a_a8) # !inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a4_a & inst_aI1_apc_a4_a & !inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a4_a,
	datac => inst_aI1_apc_a4_a,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a4_a_a205);

inst_aI1_aiaddr_x_a4_a_a217_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a4_a_a217 = !inst_aI2_apc_mux_x_a2_a_a24 & (inst_aI2_apc_mux_x_a1_a_a46 & inst1_alpm_rom_component_asrom_aq_a8_a # !inst_aI2_apc_mux_x_a1_a_a46 & inst_aI1_aiaddr_x_a4_a_a205)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00AC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_alpm_rom_component_asrom_aq_a8_a,
	datab => inst_aI1_aiaddr_x_a4_a_a205,
	datac => inst_aI2_apc_mux_x_a1_a_a46,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a4_a_a217);

inst_aI1_aiaddr_x_a4_a_a221_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a4_a_a221 = inst_aI1_ai_a2 & (inst_aI1_aiaddr_x_a4_a_a217 # inst_aI1_aiaddr_x_a7_a_a2010 & inst_aI1_astack_addrs_c_a0_a_a4_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A888",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => inst_aI1_aiaddr_x_a4_a_a217,
	datac => inst_aI1_aiaddr_x_a7_a_a2010,
	datad => inst_aI1_astack_addrs_c_a0_a_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a4_a_a221);

inst1_alpm_rom_component_asrom_asegment_a0_a_a7_a : flex10ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000110000011000000100000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000001101100010001000000000000",
	operation_mode => "rom",
	logical_ram_name => "lpm_rom0:inst1|lpm_rom:lpm_rom_component|altrom:srom|content",
	init_file => "../rom.mif",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 7,
	data_in_clock => "none",
	data_in_clear => "none",
	write_logic_clock => "none",
	write_enable_clear => "none",
	write_address_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none")
-- pragma translate_on
PORT MAP (
	clk0 => clk_adataout,
	waddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a7_a_waddr,
	raddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a7_a_raddr,
	devclrn => devclrn,
	devpor => devpor,
	modesel => inst1_alpm_rom_component_asrom_asegment_a0_a_a7_a_modesel,
	dataout => inst1_alpm_rom_component_asrom_aq_a7_a);

inst_aI1_aiaddr_x_a3_a_a222_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a3_a_a222 = inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a3_a & (inst_aI1_apc_a3_a # inst_aI2_apc_mux_x_a0_a_a8) # !inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a3_a & inst_aI1_apc_a3_a & !inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a3_a,
	datac => inst_aI1_apc_a3_a,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a3_a_a222);

inst_aI1_aiaddr_x_a3_a_a234_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a3_a_a234 = !inst_aI2_apc_mux_x_a2_a_a24 & (inst_aI2_apc_mux_x_a1_a_a46 & inst1_alpm_rom_component_asrom_aq_a7_a # !inst_aI2_apc_mux_x_a1_a_a46 & inst_aI1_aiaddr_x_a3_a_a222)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00AC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_alpm_rom_component_asrom_aq_a7_a,
	datab => inst_aI1_aiaddr_x_a3_a_a222,
	datac => inst_aI2_apc_mux_x_a1_a_a46,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a3_a_a234);

inst_aI1_aiaddr_x_a3_a_a238_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a3_a_a238 = inst_aI1_ai_a2 & (inst_aI1_aiaddr_x_a3_a_a234 # inst_aI1_aiaddr_x_a7_a_a2010 & inst_aI1_astack_addrs_c_a0_a_a3_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A888",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => inst_aI1_aiaddr_x_a3_a_a234,
	datac => inst_aI1_aiaddr_x_a7_a_a2010,
	datad => inst_aI1_astack_addrs_c_a0_a_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a3_a_a238);

inst1_alpm_rom_component_asrom_asegment_a0_a_a0_a : flex10ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010010001001000100100010010001000000000000000000000000000000000000000000000000000001010101010100000000000000000000000000000000000000000000000000000001010101010",
	operation_mode => "rom",
	logical_ram_name => "lpm_rom0:inst1|lpm_rom:lpm_rom_component|altrom:srom|content",
	init_file => "../rom.mif",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 0,
	data_in_clock => "none",
	data_in_clear => "none",
	write_logic_clock => "none",
	write_enable_clear => "none",
	write_address_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none")
-- pragma translate_on
PORT MAP (
	clk0 => clk_adataout,
	waddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a0_a_waddr,
	raddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a0_a_raddr,
	devclrn => devclrn,
	devpor => devpor,
	modesel => inst1_alpm_rom_component_asrom_asegment_a0_a_a0_a_modesel,
	dataout => inst1_alpm_rom_component_asrom_aq_a0_a);

inst_aI2_aMux_58_a0_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aMux_58_a0 = inst1_alpm_rom_component_asrom_aq_a3_a # inst1_alpm_rom_component_asrom_aq_a0_a & !inst1_alpm_rom_component_asrom_aq_a1_a & !inst1_alpm_rom_component_asrom_aq_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF02",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_alpm_rom_component_asrom_aq_a0_a,
	datab => inst1_alpm_rom_component_asrom_aq_a1_a,
	datac => inst1_alpm_rom_component_asrom_aq_a2_a,
	datad => inst1_alpm_rom_component_asrom_aq_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aMux_58_a0);

inst_aI2_aTC_c_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aTC_c_a1_a = DFFEA(nreset_adataout & inst_aI2_aMux_58_a0, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => nreset_adataout,
	datad => inst_aI2_aMux_58_a0,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_aTC_c_a1_a);

inst_aI2_aC_raw_a28_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aC_raw_a28 = nreset_adataout & inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a & inst_aI2_aTC_c_a1_a & !inst_aI2_aTC_c_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0080",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => nreset_adataout,
	datab => inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a,
	datac => inst_aI2_aTC_c_a1_a,
	datad => inst_aI2_aTC_c_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aC_raw_a28);

inst_aI3_askip_l_a196_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_askip_l_a196 = inst_aI2_aTD_c_a3_a & !inst_aI2_aTC_c_a2_a & !inst_aI2_aTC_c_a0_a & !inst_aI2_aTC_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0002",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a3_a,
	datab => inst_aI2_aTC_c_a2_a,
	datac => inst_aI2_aTC_c_a0_a,
	datad => inst_aI2_aTC_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_askip_l_a196);

rtl_a6550_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a6550 = inst_aI2_aTD_c_a2_a & !inst_aI2_aTD_c_a1_a & !inst_aI2_aTD_c_a0_a & !inst_aI3_aacc_c_a0_a_a4_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0002",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI2_aTD_c_a1_a,
	datac => inst_aI2_aTD_c_a0_a,
	datad => inst_aI3_aacc_c_a0_a_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a6550);

inst_aI3_areduce_nor_59_a11_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_areduce_nor_59_a11 = inst_aI3_aacc_c_a0_a_a3_a # inst_aI3_aacc_c_a0_a_a2_a # inst_aI3_aacc_c_a0_a_a1_a # inst_aI3_aacc_c_a0_a_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFE",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a3_a,
	datab => inst_aI3_aacc_c_a0_a_a2_a,
	datac => inst_aI3_aacc_c_a0_a_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_areduce_nor_59_a11);

rtl_a6541_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a6541 = inst_aI2_aTD_c_a2_a # inst_aI2_aTD_c_a1_a # !inst_aI2_aTD_c_a0_a # !inst_aI3_aacc_c_a0_a_a4_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EFFF",
	clock_enable_mode => "false",
	output_mode => "none")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI2_aTD_c_a1_a,
	datac => inst_aI3_aacc_c_a0_a_a4_a,
	datad => inst_aI2_aTD_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	cascout => rtl_a6541);

rtl_a6832_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a6832 = (inst_aI2_aTD_c_a2_a # inst_aI2_aTD_c_a0_a # !inst_aI2_aTD_c_a1_a # !inst_aI3_areduce_nor_59_a11) & CASCADE(rtl_a6541)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EFFF",
	clock_enable_mode => "false",
	output_mode => "none")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_areduce_nor_59_a11,
	datad => inst_aI2_aTD_c_a1_a,
	cascin => rtl_a6541,
	devclrn => devclrn,
	devpor => devpor,
	cascout => rtl_a6832);

rtl_a6830_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a6830 = (inst_aI3_areduce_nor_59_a11 # inst_aI2_aTD_c_a2_a # inst_aI2_aTD_c_a1_a # inst_aI2_aTD_c_a0_a) & CASCADE(rtl_a6832)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFE",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_areduce_nor_59_a11,
	datab => inst_aI2_aTD_c_a2_a,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI2_aTD_c_a0_a,
	cascin => rtl_a6832,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a6830);

inst_aI2_askip_c_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_askip_c = DFFEA(inst_aI3_ai_a135 & inst_aI3_askip_l_a196 & (rtl_a6550 # !rtl_a6830), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8088",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_ai_a135,
	datab => inst_aI3_askip_l_a196,
	datac => rtl_a6550,
	datad => rtl_a6830,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_askip_c);

inst_aI2_aC_raw_a13_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aC_raw_a13 = inst_aI2_aC_raw_a28 & inst_aI2_aTC_c_a0_a & !inst_aI2_aC_mem_x_a0 & !inst_aI2_askip_c

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0008",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aC_raw_a28,
	datab => inst_aI2_aTC_c_a0_a,
	datac => inst_aI2_aC_mem_x_a0,
	datad => inst_aI2_askip_c,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aC_raw_a13);

inst_aI2_avalid_c_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_avalid_c = DFFEA(inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a & !inst_aI2_aC_raw_a13 & !inst_aI3_askip_l_a1, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "000C",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a,
	datac => inst_aI2_aC_raw_a13,
	datad => inst_aI3_askip_l_a1,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_avalid_c);

inst_aI3_ai_a135_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_ai_a135 = nreset_adataout & inst_aI2_avalid_c & inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a1_a & inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => nreset_adataout,
	datab => inst_aI2_avalid_c,
	datac => inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a1_a,
	datad => inst_aI3_anreset_v_rtl_1_awysi_counter_aq_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_ai_a135);

inst_aI3_askip_l_a1_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI3_askip_l_a1 = inst_aI3_ai_a135 & inst_aI3_askip_l_a196 & (rtl_a6550 # !rtl_a6830)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8088",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_ai_a135,
	datab => inst_aI3_askip_l_a196,
	datac => rtl_a6550,
	datad => rtl_a6830,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_askip_l_a1);

inst_aI2_apc_mux_x_a2_a_a47_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_apc_mux_x_a2_a_a47 = nreset_adataout & inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a & !inst_aI3_askip_l_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00C0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => nreset_adataout,
	datac => inst_aI2_anreset_v_rtl_2_awysi_counter_aq_a1_a,
	datad => inst_aI3_askip_l_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_apc_mux_x_a2_a_a47);

inst_aI2_apc_mux_x_a1_a_a46_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_apc_mux_x_a1_a_a46 = inst_aI2_apc_mux_x_a2_a_a47 & inst_aI2_ai_a490 & (inst_aI2_aTC_x_a1_a_a1 # inst_aI2_aTC_x_a0_a_a120)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8880",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_apc_mux_x_a2_a_a47,
	datab => inst_aI2_ai_a490,
	datac => inst_aI2_aTC_x_a1_a_a1,
	datad => inst_aI2_aTC_x_a0_a_a120,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_apc_mux_x_a1_a_a46);

inst_aI1_aMux_89_rtl_60_a0_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aMux_89_rtl_60_a0 = !inst_aI2_ai_a494 # !inst_aI2_apc_mux_x_a1_a_a46

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0FFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI2_apc_mux_x_a1_a_a46,
	datad => inst_aI2_ai_a494,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_89_rtl_60_a0);

rtl_a564_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a564 = inst_aI1_aMux_89_rtl_60_a0 & inst_aI1_astack_addrs_c_a3_a_a2_a # !inst_aI1_aMux_89_rtl_60_a0 & inst_aI1_astack_addrs_c_a2_a_a2_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88B8",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a3_a_a2_a,
	datab => inst_aI1_aMux_89_rtl_60_a0,
	datac => inst_aI1_astack_addrs_c_a2_a_a2_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a564);

inst_aI1_astack_addrs_c_a3_a_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a2_a = DFFEA(rtl_a564, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datad => rtl_a564,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a2_a);

rtl_a1277_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1277 = inst_aI1_astack_addrs_c_a3_a_a2_a & (inst_aI1_astack_addrs_c_a1_a_a2_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a3_a_a2_a & inst_aI1_astack_addrs_c_a1_a_a2_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a3_a_a2_a,
	datac => inst_aI1_astack_addrs_c_a1_a_a2_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1277);

inst_aI1_astack_addrs_c_a2_a_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a2_a = DFFEA(rtl_a1277 & (inst_aI1_astack_addrs_c_a2_a_a2_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1277 & inst_aI1_astack_addrs_c_a2_a_a2_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1277,
	datac => inst_aI1_astack_addrs_c_a2_a_a2_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a2_a);

rtl_a1197_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1197 = inst_aI1_astack_addrs_c_a2_a_a2_a & (inst_aI1_astack_addrs_c_a0_a_a2_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a2_a_a2_a & inst_aI1_astack_addrs_c_a0_a_a2_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a2_a_a2_a,
	datac => inst_aI1_astack_addrs_c_a0_a_a2_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1197);

inst_aI1_astack_addrs_c_a1_a_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a2_a = DFFEA(rtl_a1197 & (inst_aI1_astack_addrs_c_a1_a_a2_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1197 & inst_aI1_astack_addrs_c_a1_a_a2_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1197,
	datac => inst_aI1_astack_addrs_c_a1_a_a2_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a2_a);

rtl_a1117_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1117 = inst_aI1_astack_addrs_c_a1_a_a2_a & (inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a2_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a1_a_a2_a & inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a2_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a1_a_a2_a,
	datac => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a2_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1117);

inst_aI1_astack_addrs_c_a0_a_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a2_a = DFFEA(rtl_a1117 & (inst_aI1_astack_addrs_c_a0_a_a2_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1117 & inst_aI1_astack_addrs_c_a0_a_a2_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1117,
	datac => inst_aI1_astack_addrs_c_a0_a_a2_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a2_a);

inst_aI1_apc_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_apc_a2_a = DFFEA(inst_aI1_ai_a2 & (inst_aI1_aiaddr_x_a2_a_a251 # inst_aI1_aiaddr_x_a7_a_a2010 & inst_aI1_astack_addrs_c_a0_a_a2_a), GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A888",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => inst_aI1_aiaddr_x_a2_a_a251,
	datac => inst_aI1_aiaddr_x_a7_a_a2010,
	datad => inst_aI1_astack_addrs_c_a0_a_a2_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_apc_a2_a);

inst_aI1_aiaddr_x_a2_a_a239_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a2_a_a239 = inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a2_a & (inst_aI1_apc_a2_a # inst_aI2_apc_mux_x_a0_a_a8) # !inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a2_a & inst_aI1_apc_a2_a & !inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a2_a,
	datac => inst_aI1_apc_a2_a,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a2_a_a239);

inst_aI1_aiaddr_x_a2_a_a251_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a2_a_a251 = !inst_aI2_apc_mux_x_a2_a_a24 & (inst_aI2_apc_mux_x_a1_a_a46 & inst1_alpm_rom_component_asrom_aq_a6_a # !inst_aI2_apc_mux_x_a1_a_a46 & inst_aI1_aiaddr_x_a2_a_a239)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00AC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_alpm_rom_component_asrom_aq_a6_a,
	datab => inst_aI1_aiaddr_x_a2_a_a239,
	datac => inst_aI2_apc_mux_x_a1_a_a46,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a2_a_a251);

inst_aI1_aiaddr_x_a2_a_a255_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a2_a_a255 = inst_aI1_ai_a2 & (inst_aI1_aiaddr_x_a2_a_a251 # inst_aI1_aiaddr_x_a7_a_a2010 & inst_aI1_astack_addrs_c_a0_a_a2_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A888",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => inst_aI1_aiaddr_x_a2_a_a251,
	datac => inst_aI1_aiaddr_x_a7_a_a2010,
	datad => inst_aI1_astack_addrs_c_a0_a_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a2_a_a255);

inst1_alpm_rom_component_asrom_asegment_a0_a_a5_a : flex10ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001010000100100011010001101000100100000000000000000000000000000000000000000000000000000001001010000000000000000000000000000000000000000101001110110001100011100010",
	operation_mode => "rom",
	logical_ram_name => "lpm_rom0:inst1|lpm_rom:lpm_rom_component|altrom:srom|content",
	init_file => "../rom.mif",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 5,
	data_in_clock => "none",
	data_in_clear => "none",
	write_logic_clock => "none",
	write_enable_clear => "none",
	write_address_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none")
-- pragma translate_on
PORT MAP (
	clk0 => clk_adataout,
	waddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a5_a_waddr,
	raddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a5_a_raddr,
	devclrn => devclrn,
	devpor => devpor,
	modesel => inst1_alpm_rom_component_asrom_asegment_a0_a_a5_a_modesel,
	dataout => inst1_alpm_rom_component_asrom_aq_a5_a);

inst_aI1_aiaddr_x_a1_a_a256_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a1_a_a256 = inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a1_a & (inst_aI1_apc_a1_a # inst_aI2_apc_mux_x_a0_a_a8) # !inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a1_a & inst_aI1_apc_a1_a & !inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_aadd_87_aadder_aresult_node_acs_buffer_a1_a,
	datac => inst_aI1_apc_a1_a,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a1_a_a256);

inst_aI1_aiaddr_x_a1_a_a268_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a1_a_a268 = !inst_aI2_apc_mux_x_a2_a_a24 & (inst_aI2_apc_mux_x_a1_a_a46 & inst1_alpm_rom_component_asrom_aq_a5_a # !inst_aI2_apc_mux_x_a1_a_a46 & inst_aI1_aiaddr_x_a1_a_a256)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00AC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_alpm_rom_component_asrom_aq_a5_a,
	datab => inst_aI1_aiaddr_x_a1_a_a256,
	datac => inst_aI2_apc_mux_x_a1_a_a46,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a1_a_a268);

inst_aI1_aiaddr_x_a1_a_a272_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a1_a_a272 = inst_aI1_ai_a2 & (inst_aI1_aiaddr_x_a1_a_a268 # inst_aI1_aiaddr_x_a7_a_a2010 & inst_aI1_astack_addrs_c_a0_a_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A888",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => inst_aI1_aiaddr_x_a1_a_a268,
	datac => inst_aI1_aiaddr_x_a7_a_a2010,
	datad => inst_aI1_astack_addrs_c_a0_a_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a1_a_a272);

inst1_alpm_rom_component_asrom_asegment_a0_a_a1_a : flex10ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000010100001010000101000010100000000000000000000000000000000000000000000000000000101010101010000000000000000000000000000000000000000110011001100110101010001",
	operation_mode => "rom",
	logical_ram_name => "lpm_rom0:inst1|lpm_rom:lpm_rom_component|altrom:srom|content",
	init_file => "../rom.mif",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 1,
	data_in_clock => "none",
	data_in_clear => "none",
	write_logic_clock => "none",
	write_enable_clear => "none",
	write_address_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none")
-- pragma translate_on
PORT MAP (
	clk0 => clk_adataout,
	waddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a1_a_waddr,
	raddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a1_a_raddr,
	devclrn => devclrn,
	devpor => devpor,
	modesel => inst1_alpm_rom_component_asrom_asegment_a0_a_a1_a_modesel,
	dataout => inst1_alpm_rom_component_asrom_aq_a1_a);

inst_aI2_aTD_x_a3_a_a9_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aTD_x_a3_a_a9 = !inst1_alpm_rom_component_asrom_aq_a1_a & !inst1_alpm_rom_component_asrom_aq_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "000F",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst1_alpm_rom_component_asrom_aq_a1_a,
	datad => inst1_alpm_rom_component_asrom_aq_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aTD_x_a3_a_a9);

inst_aI2_aTC_x_a2_a_a113_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_aTC_x_a2_a_a113 = nreset_adataout & inst_aI2_aTD_x_a3_a_a9 & (inst1_alpm_rom_component_asrom_aq_a3_a # inst_aI2_aTC_x_a2_a_a109)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8880",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => nreset_adataout,
	datab => inst_aI2_aTD_x_a3_a_a9,
	datac => inst1_alpm_rom_component_asrom_aq_a3_a,
	datad => inst_aI2_aTC_x_a2_a_a109,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aTC_x_a2_a_a113);

inst_aI2_apc_mux_x_a2_a_a24_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_apc_mux_x_a2_a_a24 = inst_aI2_aTC_x_a2_a_a113 & inst_aI2_aTC_x_a0_a_a120 & inst_aI2_apc_mux_x_a2_a_a47 & !inst_aI2_aTC_x_a1_a_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0080",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_x_a2_a_a113,
	datab => inst_aI2_aTC_x_a0_a_a120,
	datac => inst_aI2_apc_mux_x_a2_a_a47,
	datad => inst_aI2_aTC_x_a1_a_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_apc_mux_x_a2_a_a24);

inst_aI1_aiaddr_x_a7_a_a2010_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a7_a_a2010 = inst_aI2_apc_mux_x_a2_a_a24 & inst_aI2_apc_mux_x_a1_a_a46 & inst_aI2_ai_a494

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI2_apc_mux_x_a2_a_a24,
	datac => inst_aI2_apc_mux_x_a1_a_a46,
	datad => inst_aI2_ai_a494,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a7_a_a2010);

rtl_a570_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a570 = inst_aI1_aMux_89_rtl_60_a0 & inst_aI1_astack_addrs_c_a3_a_a0_a # !inst_aI1_aMux_89_rtl_60_a0 & inst_aI1_astack_addrs_c_a2_a_a0_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88B8",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a3_a_a0_a,
	datab => inst_aI1_aMux_89_rtl_60_a0,
	datac => inst_aI1_astack_addrs_c_a2_a_a0_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a570);

inst_aI1_astack_addrs_c_a3_a_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a0_a = DFFEA(rtl_a570, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datad => rtl_a570,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a0_a);

rtl_a1297_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1297 = inst_aI1_astack_addrs_c_a3_a_a0_a & (inst_aI1_astack_addrs_c_a1_a_a0_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a3_a_a0_a & inst_aI1_astack_addrs_c_a1_a_a0_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a3_a_a0_a,
	datac => inst_aI1_astack_addrs_c_a1_a_a0_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1297);

inst_aI1_astack_addrs_c_a2_a_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a0_a = DFFEA(rtl_a1297 & (inst_aI1_astack_addrs_c_a2_a_a0_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1297 & inst_aI1_astack_addrs_c_a2_a_a0_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1297,
	datac => inst_aI1_astack_addrs_c_a2_a_a0_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a0_a);

rtl_a1217_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1217 = inst_aI1_astack_addrs_c_a2_a_a0_a & (inst_aI1_astack_addrs_c_a0_a_a0_a # inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_astack_addrs_c_a2_a_a0_a & inst_aI1_astack_addrs_c_a0_a_a0_a & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a2_a_a0_a,
	datac => inst_aI1_astack_addrs_c_a0_a_a0_a,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1217);

inst_aI1_astack_addrs_c_a1_a_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a0_a = DFFEA(rtl_a1217 & (inst_aI1_astack_addrs_c_a1_a_a0_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1217 & inst_aI1_astack_addrs_c_a1_a_a0_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1217,
	datac => inst_aI1_astack_addrs_c_a1_a_a0_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a0_a);

rtl_a1137_I : flex10ke_lcell 
-- Equation(s):
-- rtl_a1137 = inst_aI1_astack_addrs_c_a1_a_a0_a & (inst_aI2_apc_mux_x_a2_a_a24 # !inst_aI1_apc_a0_a) # !inst_aI1_astack_addrs_c_a1_a_a0_a & !inst_aI2_apc_mux_x_a2_a_a24 & !inst_aI1_apc_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0CF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a1_a_a0_a,
	datac => inst_aI2_apc_mux_x_a2_a_a24,
	datad => inst_aI1_apc_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1137);

inst_aI1_astack_addrs_c_a0_a_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a0_a = DFFEA(rtl_a1137 & (inst_aI1_astack_addrs_c_a0_a_a0_a # !inst_aI1_aMux_89_rtl_60_a0) # !rtl_a1137 & inst_aI1_astack_addrs_c_a0_a_a0_a & inst_aI1_aMux_89_rtl_60_a0, GLOBAL(clk_adataout), , , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_ai_a2,
	datab => rtl_a1137,
	datac => inst_aI1_astack_addrs_c_a0_a_a0_a,
	datad => inst_aI1_aMux_89_rtl_60_a0,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a0_a);

inst_aI1_aiaddr_x_a0_a_a278_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a0_a_a278 = inst_aI2_apc_mux_x_a1_a_a46 & inst1_alpm_rom_component_asrom_aq_a4_a # !inst_aI2_apc_mux_x_a1_a_a46 & (inst_aI2_apc_mux_x_a0_a_a8 $ inst_aI1_apc_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8BB8",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_alpm_rom_component_asrom_aq_a4_a,
	datab => inst_aI2_apc_mux_x_a1_a_a46,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI1_apc_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a0_a_a278);

inst_aI1_aiaddr_x_a0_a_a283_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a0_a_a283 = inst_aI1_aiaddr_x_a7_a_a2010 & (inst_aI1_astack_addrs_c_a0_a_a0_a # inst_aI1_aiaddr_x_a0_a_a278 & !inst_aI2_apc_mux_x_a2_a_a24) # !inst_aI1_aiaddr_x_a7_a_a2010 & inst_aI1_aiaddr_x_a0_a_a278 & !inst_aI2_apc_mux_x_a2_a_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88F8",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_aiaddr_x_a7_a_a2010,
	datab => inst_aI1_astack_addrs_c_a0_a_a0_a,
	datac => inst_aI1_aiaddr_x_a0_a_a278,
	datad => inst_aI2_apc_mux_x_a2_a_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a0_a_a283);

inst_aI1_aiaddr_x_a0_a_a289_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a0_a_a289 = inst_aI1_ai_a2 & inst_aI1_aiaddr_x_a0_a_a283

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI1_ai_a2,
	datad => inst_aI1_aiaddr_x_a0_a_a283,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a0_a_a289);

inst1_alpm_rom_component_asrom_asegment_a0_a_a6_a : flex10ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000100011110000101000011100001000000000000000000000000000000000000000000000000000010010100000000000000000000000000000000000000000000110001010101000001000000000",
	operation_mode => "rom",
	logical_ram_name => "lpm_rom0:inst1|lpm_rom:lpm_rom_component|altrom:srom|content",
	init_file => "../rom.mif",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 6,
	data_in_clock => "none",
	data_in_clear => "none",
	write_logic_clock => "none",
	write_enable_clear => "none",
	write_address_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none")
-- pragma translate_on
PORT MAP (
	clk0 => clk_adataout,
	waddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a6_a_waddr,
	raddr => ww_inst1_alpm_rom_component_asrom_asegment_a0_a_a6_a_raddr,
	devclrn => devclrn,
	devpor => devpor,
	modesel => inst1_alpm_rom_component_asrom_asegment_a0_a_a6_a_modesel,
	dataout => inst1_alpm_rom_component_asrom_aq_a6_a);

inst_aI4_areduce_nor_24_a14_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI4_areduce_nor_24_a14 = inst1_alpm_rom_component_asrom_aq_a6_a # inst1_alpm_rom_component_asrom_aq_a5_a # inst1_alpm_rom_component_asrom_aq_a4_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst1_alpm_rom_component_asrom_aq_a6_a,
	datac => inst1_alpm_rom_component_asrom_aq_a5_a,
	datad => inst1_alpm_rom_component_asrom_aq_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_areduce_nor_24_a14);

inst_aI2_andre_x_a46_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI2_andre_x_a46 = inst_aI4_areduce_nor_24_a14 & inst_aI4_ai_a254 & !inst_aI4_areduce_nor_27_a23

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00C0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI4_areduce_nor_24_a14,
	datac => inst_aI4_ai_a254,
	datad => inst_aI4_areduce_nor_27_a23,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_andre_x_a46);

inst_aI5_andwe_c_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI5_andwe_c = DFFEA(!inst_aI2_andre_x_a46 & inst_aI4_ai_a385 & nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4000",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_andre_x_a46,
	datab => inst_aI4_ai_a385,
	datac => nreset_adataout,
	datad => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI5_andwe_c);

inst6_areduce_nor_27_aI : flex10ke_lcell 
-- Equation(s):
-- inst6_areduce_nor_27 = inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a1_a # !inst_aI4_andre_x_a1 & inst_aI4_adaddr_x_a1_a_a4 # !inst6_areduce_nor_30_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ACFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_adaddr_c_a1_a,
	datab => inst_aI4_adaddr_x_a1_a_a4,
	datac => inst_aI4_andre_x_a1,
	datad => inst6_areduce_nor_30_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst6_areduce_nor_27);

inst6_actrl_data_c_a3_a_a8_I : flex10ke_lcell 
-- Equation(s):
-- inst6_actrl_data_c_a3_a_a8 = nreset_adataout & inst_aI5_andwe_c & !inst6_areduce_nor_27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00C0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => nreset_adataout,
	datac => inst_aI5_andwe_c,
	datad => inst6_areduce_nor_27,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst6_actrl_data_c_a3_a_a8);

inst6_actrl_data_c_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst6_actrl_data_c_a0_a = DFFEA(nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a & inst_aI3_aacc_c_a0_a_a0_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst6_actrl_data_c_a3_a_a8, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_actrl_data_c_a3_a_a8,
	datab => nreset_adataout,
	datac => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a0_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst6_actrl_data_c_a0_a);

inst6_areduce_nor_30_aI : flex10ke_lcell 
-- Equation(s):
-- inst6_areduce_nor_30 = inst_aI4_andre_x_a1 & !inst_aI5_adaddr_c_a1_a # !inst_aI4_andre_x_a1 & !inst_aI4_adaddr_x_a1_a_a4 # !inst6_areduce_nor_30_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "1BFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_andre_x_a1,
	datab => inst_aI4_adaddr_x_a1_a_a4,
	datac => inst_aI5_adaddr_c_a1_a,
	datad => inst6_areduce_nor_30_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst6_areduce_nor_30);

inst6_ai_a145_I : flex10ke_lcell 
-- Equation(s):
-- inst6_ai_a145 = inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a1_a # !inst_aI4_andre_x_a1 & inst_aI4_adaddr_x_a1_a_a4 # !inst_aI5_ai_a17

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ACFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_adaddr_c_a1_a,
	datab => inst_aI4_adaddr_x_a1_a_a4,
	datac => inst_aI4_andre_x_a1,
	datad => inst_aI5_ai_a17,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst6_ai_a145);

inst6_ai_a125_I : flex10ke_lcell 
-- Equation(s):
-- inst6_ai_a125 = !inst_aI5_ai_a14 & !inst_aI5_ai_a23

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "000F",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI5_ai_a14,
	datad => inst_aI5_ai_a23,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst6_ai_a125);

inst6_apwm_data_c_a3_a_a68_I : flex10ke_lcell 
-- Equation(s):
-- inst6_apwm_data_c_a3_a_a68 = inst6_actrl_data_c_a3_a_a19 & (inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a4_a # !inst_aI4_andre_x_a1 & inst_aI4_adaddr_x_a4_a_a1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88A0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_actrl_data_c_a3_a_a19,
	datab => inst_aI5_adaddr_c_a4_a,
	datac => inst_aI4_adaddr_x_a4_a_a1,
	datad => inst_aI4_andre_x_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst6_apwm_data_c_a3_a_a68);

inst6_apwm_data_c_a3_a_a48_I : flex10ke_lcell 
-- Equation(s):
-- inst6_apwm_data_c_a3_a_a48 = inst6_areduce_nor_27 & inst6_apwm_data_c_a3_a_a68

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst6_areduce_nor_27,
	datad => inst6_apwm_data_c_a3_a_a68,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst6_apwm_data_c_a3_a_a48);

inst6_ai_a101_I : flex10ke_lcell 
-- Equation(s):
-- inst6_ai_a101 = inst6_areduce_nor_30 & (inst6_ai_a145 # !inst6_ai_a125) # !inst6_apwm_data_c_a3_a_a48

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8AFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_areduce_nor_30,
	datab => inst6_ai_a145,
	datac => inst6_ai_a125,
	datad => inst6_apwm_data_c_a3_a_a48,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst6_ai_a101);

inst5_ai_a0_I : flex10ke_lcell 
-- Equation(s):
-- inst5_ai_a0 = inst_aI5_ai_a17 & !inst6_ai_a101

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00F0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI5_ai_a17,
	datad => inst6_ai_a101,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_ai_a0);

inst6_apwm_data_c_a3_a_a30_I : flex10ke_lcell 
-- Equation(s):
-- inst6_apwm_data_c_a3_a_a30 = inst6_areduce_nor_30 & inst6_areduce_nor_27 & inst6_apwm_data_c_a3_a_a68

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst6_areduce_nor_30,
	datac => inst6_areduce_nor_27,
	datad => inst6_apwm_data_c_a3_a_a68,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst6_apwm_data_c_a3_a_a30);

inst6_ai_a120_I : flex10ke_lcell 
-- Equation(s):
-- inst6_ai_a120 = inst_aI5_ai_a17 & (inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a1_a # !inst_aI4_andre_x_a1 & inst_aI4_adaddr_x_a1_a_a4)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88A0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_ai_a17,
	datab => inst_aI5_adaddr_c_a1_a,
	datac => inst_aI4_adaddr_x_a1_a_a4,
	datad => inst_aI4_andre_x_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst6_ai_a120);

inst6_ai_a121_I : flex10ke_lcell 
-- Equation(s):
-- inst6_ai_a121 = !inst_aI5_ai_a17 & (inst_aI4_andre_x_a1 & !inst_aI5_adaddr_c_a1_a # !inst_aI4_andre_x_a1 & !inst_aI4_adaddr_x_a1_a_a4)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "001B",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_andre_x_a1,
	datab => inst_aI4_adaddr_x_a1_a_a4,
	datac => inst_aI5_adaddr_c_a1_a,
	datad => inst_aI5_ai_a17,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst6_ai_a121);

inst6_ai_a164_I : flex10ke_lcell 
-- Equation(s):
-- inst6_ai_a164 = inst_aI5_ai_a14 # inst_aI4_andre_x_a1 & !inst_aI5_adaddr_c_a4_a # !inst_aI4_andre_x_a1 & !inst_aI4_adaddr_x_a4_a_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ABEF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_ai_a14,
	datab => inst_aI4_andre_x_a1,
	datac => inst_aI4_adaddr_x_a4_a_a1,
	datad => inst_aI5_adaddr_c_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst6_ai_a164);

inst6_ai_a117_I : flex10ke_lcell 
-- Equation(s):
-- inst6_ai_a117 = inst6_ai_a120 # inst6_ai_a121 # inst6_ai_a164 # !inst_aI5_ai_a23

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FEFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_ai_a120,
	datab => inst6_ai_a121,
	datac => inst6_ai_a164,
	datad => inst_aI5_ai_a23,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst6_ai_a117);

inst6_apwm_data_c_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst6_apwm_data_c_a3_a = DFFEA(inst_aI4_adata_ox_a3_a_a0 & (inst6_apwm_data_c_a3_a # !inst6_ai_a117) # !inst_aI4_adata_ox_a3_a_a0 & inst6_apwm_data_c_a3_a & inst6_ai_a117, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst6_apwm_data_c_a3_a_a30, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_apwm_data_c_a3_a_a30,
	datab => inst_aI4_adata_ox_a3_a_a0,
	datac => inst6_apwm_data_c_a3_a,
	datad => inst6_ai_a117,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst6_apwm_data_c_a3_a);

inst5_apwm_low_a7_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_low_a7_a = DFFEA(inst6_apwm_data_c_a3_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst5_ai_a0, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_ai_a0,
	datad => inst6_apwm_data_c_a3_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_low_a7_a);

inst6_apwm_data_c_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst6_apwm_data_c_a2_a = DFFEA(inst_aI4_adata_ox_a2_a_a1 & (inst6_apwm_data_c_a2_a # !inst6_ai_a117) # !inst_aI4_adata_ox_a2_a_a1 & inst6_apwm_data_c_a2_a & inst6_ai_a117, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst6_apwm_data_c_a3_a_a30, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_apwm_data_c_a3_a_a30,
	datab => inst_aI4_adata_ox_a2_a_a1,
	datac => inst6_apwm_data_c_a2_a,
	datad => inst6_ai_a117,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst6_apwm_data_c_a2_a);

inst5_apwm_low_a6_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_low_a6_a = DFFEA(inst6_apwm_data_c_a2_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst5_ai_a0, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_ai_a0,
	datad => inst6_apwm_data_c_a2_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_low_a6_a);

inst6_apwm_data_c_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst6_apwm_data_c_a1_a = DFFEA(inst_aI4_adata_ox_a1_a_a2 & (inst6_apwm_data_c_a1_a # !inst6_ai_a117) # !inst_aI4_adata_ox_a1_a_a2 & inst6_apwm_data_c_a1_a & inst6_ai_a117, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst6_apwm_data_c_a3_a_a30, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_apwm_data_c_a3_a_a30,
	datab => inst_aI4_adata_ox_a1_a_a2,
	datac => inst6_apwm_data_c_a1_a,
	datad => inst6_ai_a117,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst6_apwm_data_c_a1_a);

inst5_apwm_low_a5_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_low_a5_a = DFFEA(inst6_apwm_data_c_a1_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst5_ai_a0, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_ai_a0,
	datad => inst6_apwm_data_c_a1_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_low_a5_a);

inst6_apwm_data_c_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst6_apwm_data_c_a0_a = DFFEA(inst_aI4_adata_ox_a0_a_a3 & (inst6_apwm_data_c_a0_a # !inst6_ai_a117) # !inst_aI4_adata_ox_a0_a_a3 & inst6_apwm_data_c_a0_a & inst6_ai_a117, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst6_apwm_data_c_a3_a_a30, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_apwm_data_c_a3_a_a30,
	datab => inst_aI4_adata_ox_a0_a_a3,
	datac => inst6_apwm_data_c_a0_a,
	datad => inst6_ai_a117,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst6_apwm_data_c_a0_a);

inst5_apwm_low_a4_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_low_a4_a = DFFEA(inst6_apwm_data_c_a0_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst5_ai_a0, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_ai_a0,
	datad => inst6_apwm_data_c_a0_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_low_a4_a);

inst5_apwm_low_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_low_a3_a = DFFEA(nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a & inst_aI3_aacc_c_a0_a_a3_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst5_ai_a0, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_ai_a0,
	datab => nreset_adataout,
	datac => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a3_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_low_a3_a);

inst5_apwm_low_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_low_a2_a = DFFEA(nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a & inst_aI3_aacc_c_a0_a_a2_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst5_ai_a0, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_ai_a0,
	datab => nreset_adataout,
	datac => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a2_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_low_a2_a);

inst5_apwm_low_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_low_a1_a = DFFEA(nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a & inst_aI3_aacc_c_a0_a_a1_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst5_ai_a0, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_ai_a0,
	datab => nreset_adataout,
	datac => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a1_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_low_a1_a);

inst5_apwm_low_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_low_a0_a = DFFEA(nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a & inst_aI3_aacc_c_a0_a_a0_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst5_ai_a0, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_ai_a0,
	datab => nreset_adataout,
	datac => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a0_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_low_a0_a);

inst5_apwm_period_a7_a_a87_I : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_period_a7_a_a87 = nreset_adataout & !inst5_ai_a0 & !inst_aI5_ai_a17 & !inst6_ai_a101

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0002",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => nreset_adataout,
	datab => inst5_ai_a0,
	datac => inst_aI5_ai_a17,
	datad => inst6_ai_a101,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_apwm_period_a7_a_a87);

inst5_apwm_period_a7_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_period_a7_a = DFFEA(inst6_apwm_data_c_a3_a, GLOBAL(clk_adataout), , , inst5_apwm_period_a7_a_a87, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_period_a7_a_a87,
	datad => inst6_apwm_data_c_a3_a,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_period_a7_a);

inst5_apwm_period_a6_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_period_a6_a = DFFEA(inst6_apwm_data_c_a2_a, GLOBAL(clk_adataout), , , inst5_apwm_period_a7_a_a87, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_period_a7_a_a87,
	datad => inst6_apwm_data_c_a2_a,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_period_a6_a);

inst5_apwm_period_a5_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_period_a5_a = DFFEA(inst6_apwm_data_c_a1_a, GLOBAL(clk_adataout), , , inst5_apwm_period_a7_a_a87, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_period_a7_a_a87,
	datad => inst6_apwm_data_c_a1_a,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_period_a5_a);

inst5_apwm_period_a4_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_period_a4_a = DFFEA(inst6_apwm_data_c_a0_a, GLOBAL(clk_adataout), , , inst5_apwm_period_a7_a_a87, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_period_a7_a_a87,
	datad => inst6_apwm_data_c_a0_a,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_period_a4_a);

inst5_apwm_period_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_period_a3_a = DFFEA(nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a & inst_aI3_aacc_c_a0_a_a3_a, GLOBAL(clk_adataout), , , inst5_apwm_period_a7_a_a87, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_period_a7_a_a87,
	datab => nreset_adataout,
	datac => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a3_a,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_period_a3_a);

inst5_apwm_period_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_period_a2_a = DFFEA(nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a & inst_aI3_aacc_c_a0_a_a2_a, GLOBAL(clk_adataout), , , inst5_apwm_period_a7_a_a87, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_period_a7_a_a87,
	datab => nreset_adataout,
	datac => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a2_a,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_period_a2_a);

inst5_apwm_period_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_period_a1_a = DFFEA(nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a & inst_aI3_aacc_c_a0_a_a1_a, GLOBAL(clk_adataout), , , inst5_apwm_period_a7_a_a87, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_period_a7_a_a87,
	datab => nreset_adataout,
	datac => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a1_a,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_period_a1_a);

inst5_apwm_period_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_period_a0_a = DFFEA(nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a & inst_aI3_aacc_c_a0_a_a0_a, GLOBAL(clk_adataout), , , inst5_apwm_period_a7_a_a87, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_period_a7_a_a87,
	datab => nreset_adataout,
	datac => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a0_a,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_period_a0_a);

inst5_aadd_20_aadder_aresult_node_acs_buffer_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_aadd_20_aadder_aresult_node_acs_buffer_a1_a = inst_aI4_adata_ox_a0_a_a3 $ !inst5_apwm_period_a0_a
-- inst5_aadd_20_aadder_aresult_node_acout_a1_a = CARRY(inst5_apwm_period_a0_a # !inst_aI4_adata_ox_a0_a_a3)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	packed_mode => "false",
	lut_mask => "99DD",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_adata_ox_a0_a_a3,
	datab => inst5_apwm_period_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aadd_20_aadder_aresult_node_acs_buffer_a1_a,
	cout => inst5_aadd_20_aadder_aresult_node_acout_a1_a);

inst5_aadd_20_aadder_aresult_node_acs_buffer_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_aadd_20_aadder_aresult_node_acs_buffer_a2_a = inst5_apwm_period_a1_a $ inst_aI4_adata_ox_a1_a_a2 $ !inst5_aadd_20_aadder_aresult_node_acout_a1_a
-- inst5_aadd_20_aadder_aresult_node_acout_a2_a = CARRY(inst5_apwm_period_a1_a & (inst5_aadd_20_aadder_aresult_node_acout_a1_a # !inst_aI4_adata_ox_a1_a_a2) # !inst5_apwm_period_a1_a & !inst_aI4_adata_ox_a1_a_a2 & inst5_aadd_20_aadder_aresult_node_acout_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "69B2",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_period_a1_a,
	datab => inst_aI4_adata_ox_a1_a_a2,
	cin => inst5_aadd_20_aadder_aresult_node_acout_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aadd_20_aadder_aresult_node_acs_buffer_a2_a,
	cout => inst5_aadd_20_aadder_aresult_node_acout_a2_a);

inst5_aadd_20_aadder_aresult_node_acs_buffer_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_aadd_20_aadder_aresult_node_acs_buffer_a3_a = inst5_apwm_period_a2_a $ inst_aI4_adata_ox_a2_a_a1 $ !inst5_aadd_20_aadder_aresult_node_acout_a2_a
-- inst5_aadd_20_aadder_aresult_node_acout_a3_a = CARRY(inst5_apwm_period_a2_a & (inst5_aadd_20_aadder_aresult_node_acout_a2_a # !inst_aI4_adata_ox_a2_a_a1) # !inst5_apwm_period_a2_a & !inst_aI4_adata_ox_a2_a_a1 & inst5_aadd_20_aadder_aresult_node_acout_a2_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "69B2",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_period_a2_a,
	datab => inst_aI4_adata_ox_a2_a_a1,
	cin => inst5_aadd_20_aadder_aresult_node_acout_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aadd_20_aadder_aresult_node_acs_buffer_a3_a,
	cout => inst5_aadd_20_aadder_aresult_node_acout_a3_a);

inst5_aadd_20_aadder_aresult_node_acs_buffer_a4_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_aadd_20_aadder_aresult_node_acs_buffer_a4_a = inst5_apwm_period_a3_a $ inst_aI4_adata_ox_a3_a_a0 $ !inst5_aadd_20_aadder_aresult_node_acout_a3_a
-- inst5_aadd_20_aadder_aresult_node_acout_a4_a = CARRY(inst5_apwm_period_a3_a & (inst5_aadd_20_aadder_aresult_node_acout_a3_a # !inst_aI4_adata_ox_a3_a_a0) # !inst5_apwm_period_a3_a & !inst_aI4_adata_ox_a3_a_a0 & inst5_aadd_20_aadder_aresult_node_acout_a3_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "69B2",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_period_a3_a,
	datab => inst_aI4_adata_ox_a3_a_a0,
	cin => inst5_aadd_20_aadder_aresult_node_acout_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aadd_20_aadder_aresult_node_acs_buffer_a4_a,
	cout => inst5_aadd_20_aadder_aresult_node_acout_a4_a);

inst5_aadd_20_aadder_aresult_node_acs_buffer_a5_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_aadd_20_aadder_aresult_node_acs_buffer_a5_a = inst5_apwm_period_a4_a $ inst6_apwm_data_c_a0_a $ !inst5_aadd_20_aadder_aresult_node_acout_a4_a
-- inst5_aadd_20_aadder_aresult_node_acout_a5_a = CARRY(inst5_apwm_period_a4_a & (inst5_aadd_20_aadder_aresult_node_acout_a4_a # !inst6_apwm_data_c_a0_a) # !inst5_apwm_period_a4_a & !inst6_apwm_data_c_a0_a & inst5_aadd_20_aadder_aresult_node_acout_a4_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "69B2",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_period_a4_a,
	datab => inst6_apwm_data_c_a0_a,
	cin => inst5_aadd_20_aadder_aresult_node_acout_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aadd_20_aadder_aresult_node_acs_buffer_a5_a,
	cout => inst5_aadd_20_aadder_aresult_node_acout_a5_a);

inst5_aadd_20_aadder_aresult_node_acs_buffer_a6_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_aadd_20_aadder_aresult_node_acs_buffer_a6_a = inst5_apwm_period_a5_a $ inst6_apwm_data_c_a1_a $ !inst5_aadd_20_aadder_aresult_node_acout_a5_a
-- inst5_aadd_20_aadder_aresult_node_acout_a6_a = CARRY(inst5_apwm_period_a5_a & (inst5_aadd_20_aadder_aresult_node_acout_a5_a # !inst6_apwm_data_c_a1_a) # !inst5_apwm_period_a5_a & !inst6_apwm_data_c_a1_a & inst5_aadd_20_aadder_aresult_node_acout_a5_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "69B2",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_period_a5_a,
	datab => inst6_apwm_data_c_a1_a,
	cin => inst5_aadd_20_aadder_aresult_node_acout_a5_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aadd_20_aadder_aresult_node_acs_buffer_a6_a,
	cout => inst5_aadd_20_aadder_aresult_node_acout_a6_a);

inst5_aadd_20_aadder_aresult_node_acs_buffer_a7_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_aadd_20_aadder_aresult_node_acs_buffer_a7_a = inst5_apwm_period_a6_a $ inst6_apwm_data_c_a2_a $ !inst5_aadd_20_aadder_aresult_node_acout_a6_a
-- inst5_aadd_20_aadder_aresult_node_acout_a7_a = CARRY(inst5_apwm_period_a6_a & (inst5_aadd_20_aadder_aresult_node_acout_a6_a # !inst6_apwm_data_c_a2_a) # !inst5_apwm_period_a6_a & !inst6_apwm_data_c_a2_a & inst5_aadd_20_aadder_aresult_node_acout_a6_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "69B2",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_period_a6_a,
	datab => inst6_apwm_data_c_a2_a,
	cin => inst5_aadd_20_aadder_aresult_node_acout_a6_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aadd_20_aadder_aresult_node_acs_buffer_a7_a,
	cout => inst5_aadd_20_aadder_aresult_node_acout_a7_a);

inst5_aadd_20_aadder_aunreg_res_node_a8_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_aadd_20_aadder_aunreg_res_node_a8_a = inst6_apwm_data_c_a3_a $ inst5_aadd_20_aadder_aresult_node_acout_a7_a $ !inst5_apwm_period_a7_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3CC3",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst6_apwm_data_c_a3_a,
	datad => inst5_apwm_period_a7_a,
	cin => inst5_aadd_20_aadder_aresult_node_acout_a7_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aadd_20_aadder_aunreg_res_node_a8_a);

inst5_aadd_36_aadder_aresult_node_acs_buffer_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_aadd_36_aadder_aresult_node_acs_buffer_a1_a = inst_aI4_adata_ox_a0_a_a3 $ !inst5_apwm_low_a0_a
-- inst5_aadd_36_aadder_aresult_node_acout_a1_a = CARRY(inst_aI4_adata_ox_a0_a_a3 # !inst5_apwm_low_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	packed_mode => "false",
	lut_mask => "99BB",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_adata_ox_a0_a_a3,
	datab => inst5_apwm_low_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aadd_36_aadder_aresult_node_acs_buffer_a1_a,
	cout => inst5_aadd_36_aadder_aresult_node_acout_a1_a);

inst5_aadd_36_aadder_aresult_node_acs_buffer_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_aadd_36_aadder_aresult_node_acs_buffer_a2_a = inst5_apwm_low_a1_a $ inst_aI4_adata_ox_a1_a_a2 $ !inst5_aadd_36_aadder_aresult_node_acout_a1_a
-- inst5_aadd_36_aadder_aresult_node_acout_a2_a = CARRY(inst5_apwm_low_a1_a & inst_aI4_adata_ox_a1_a_a2 & inst5_aadd_36_aadder_aresult_node_acout_a1_a # !inst5_apwm_low_a1_a & (inst_aI4_adata_ox_a1_a_a2 # inst5_aadd_36_aadder_aresult_node_acout_a1_a))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "69D4",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_low_a1_a,
	datab => inst_aI4_adata_ox_a1_a_a2,
	cin => inst5_aadd_36_aadder_aresult_node_acout_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aadd_36_aadder_aresult_node_acs_buffer_a2_a,
	cout => inst5_aadd_36_aadder_aresult_node_acout_a2_a);

inst5_aadd_36_aadder_aresult_node_acs_buffer_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_aadd_36_aadder_aresult_node_acs_buffer_a3_a = inst5_apwm_low_a2_a $ inst_aI4_adata_ox_a2_a_a1 $ !inst5_aadd_36_aadder_aresult_node_acout_a2_a
-- inst5_aadd_36_aadder_aresult_node_acout_a3_a = CARRY(inst5_apwm_low_a2_a & inst_aI4_adata_ox_a2_a_a1 & inst5_aadd_36_aadder_aresult_node_acout_a2_a # !inst5_apwm_low_a2_a & (inst_aI4_adata_ox_a2_a_a1 # inst5_aadd_36_aadder_aresult_node_acout_a2_a))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "69D4",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_low_a2_a,
	datab => inst_aI4_adata_ox_a2_a_a1,
	cin => inst5_aadd_36_aadder_aresult_node_acout_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aadd_36_aadder_aresult_node_acs_buffer_a3_a,
	cout => inst5_aadd_36_aadder_aresult_node_acout_a3_a);

inst5_aadd_36_aadder_aresult_node_acs_buffer_a4_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_aadd_36_aadder_aresult_node_acs_buffer_a4_a = inst5_apwm_low_a3_a $ inst_aI4_adata_ox_a3_a_a0 $ !inst5_aadd_36_aadder_aresult_node_acout_a3_a
-- inst5_aadd_36_aadder_aresult_node_acout_a4_a = CARRY(inst5_apwm_low_a3_a & inst_aI4_adata_ox_a3_a_a0 & inst5_aadd_36_aadder_aresult_node_acout_a3_a # !inst5_apwm_low_a3_a & (inst_aI4_adata_ox_a3_a_a0 # inst5_aadd_36_aadder_aresult_node_acout_a3_a))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "69D4",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_low_a3_a,
	datab => inst_aI4_adata_ox_a3_a_a0,
	cin => inst5_aadd_36_aadder_aresult_node_acout_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aadd_36_aadder_aresult_node_acs_buffer_a4_a,
	cout => inst5_aadd_36_aadder_aresult_node_acout_a4_a);

inst5_aadd_36_aadder_aresult_node_acs_buffer_a5_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_aadd_36_aadder_aresult_node_acs_buffer_a5_a = inst6_apwm_data_c_a0_a $ inst5_apwm_low_a4_a $ !inst5_aadd_36_aadder_aresult_node_acout_a4_a
-- inst5_aadd_36_aadder_aresult_node_acout_a5_a = CARRY(inst6_apwm_data_c_a0_a & (inst5_aadd_36_aadder_aresult_node_acout_a4_a # !inst5_apwm_low_a4_a) # !inst6_apwm_data_c_a0_a & !inst5_apwm_low_a4_a & inst5_aadd_36_aadder_aresult_node_acout_a4_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "69B2",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_apwm_data_c_a0_a,
	datab => inst5_apwm_low_a4_a,
	cin => inst5_aadd_36_aadder_aresult_node_acout_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aadd_36_aadder_aresult_node_acs_buffer_a5_a,
	cout => inst5_aadd_36_aadder_aresult_node_acout_a5_a);

inst5_aadd_36_aadder_aresult_node_acs_buffer_a6_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_aadd_36_aadder_aresult_node_acs_buffer_a6_a = inst6_apwm_data_c_a1_a $ inst5_apwm_low_a5_a $ !inst5_aadd_36_aadder_aresult_node_acout_a5_a
-- inst5_aadd_36_aadder_aresult_node_acout_a6_a = CARRY(inst6_apwm_data_c_a1_a & (inst5_aadd_36_aadder_aresult_node_acout_a5_a # !inst5_apwm_low_a5_a) # !inst6_apwm_data_c_a1_a & !inst5_apwm_low_a5_a & inst5_aadd_36_aadder_aresult_node_acout_a5_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "69B2",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_apwm_data_c_a1_a,
	datab => inst5_apwm_low_a5_a,
	cin => inst5_aadd_36_aadder_aresult_node_acout_a5_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aadd_36_aadder_aresult_node_acs_buffer_a6_a,
	cout => inst5_aadd_36_aadder_aresult_node_acout_a6_a);

inst5_aadd_36_aadder_aresult_node_acs_buffer_a7_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_aadd_36_aadder_aresult_node_acs_buffer_a7_a = inst6_apwm_data_c_a2_a $ inst5_apwm_low_a6_a $ !inst5_aadd_36_aadder_aresult_node_acout_a6_a
-- inst5_aadd_36_aadder_aresult_node_acout_a7_a = CARRY(inst6_apwm_data_c_a2_a & (inst5_aadd_36_aadder_aresult_node_acout_a6_a # !inst5_apwm_low_a6_a) # !inst6_apwm_data_c_a2_a & !inst5_apwm_low_a6_a & inst5_aadd_36_aadder_aresult_node_acout_a6_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "69B2",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_apwm_data_c_a2_a,
	datab => inst5_apwm_low_a6_a,
	cin => inst5_aadd_36_aadder_aresult_node_acout_a6_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aadd_36_aadder_aresult_node_acs_buffer_a7_a,
	cout => inst5_aadd_36_aadder_aresult_node_acout_a7_a);

inst5_aadd_36_aadder_aunreg_res_node_a8_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_aadd_36_aadder_aunreg_res_node_a8_a = inst5_apwm_low_a7_a $ inst5_aadd_36_aadder_aresult_node_acout_a7_a $ !inst6_apwm_data_c_a3_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3CC3",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_apwm_low_a7_a,
	datad => inst6_apwm_data_c_a3_a,
	cin => inst5_aadd_36_aadder_aresult_node_acout_a7_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aadd_36_aadder_aunreg_res_node_a8_a);

inst5_ai_a180_I : flex10ke_lcell 
-- Equation(s):
-- inst5_ai_a180 = inst_aI5_ai_a17 & inst5_apwm_high_a7_a # !inst_aI5_ai_a17 & (inst6_ai_a101 & inst5_apwm_high_a7_a # !inst6_ai_a101 & inst5_aadd_36_aadder_aunreg_res_node_a8_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAAC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_high_a7_a,
	datab => inst5_aadd_36_aadder_aunreg_res_node_a8_a,
	datac => inst_aI5_ai_a17,
	datad => inst6_ai_a101,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_ai_a180);

inst5_apwm_high_a7_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_high_a7_a = DFFEA(inst5_aadd_20_aadder_aunreg_res_node_a8_a & (inst5_ai_a180 # inst5_ai_a0) # !inst5_aadd_20_aadder_aunreg_res_node_a8_a & inst5_ai_a180 & !inst5_ai_a0, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_aadd_20_aadder_aunreg_res_node_a8_a,
	datac => inst5_ai_a180,
	datad => inst5_ai_a0,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_high_a7_a);

inst5_ai_a190_I : flex10ke_lcell 
-- Equation(s):
-- inst5_ai_a190 = inst_aI5_ai_a17 & inst5_apwm_high_a6_a # !inst_aI5_ai_a17 & (inst6_ai_a101 & inst5_apwm_high_a6_a # !inst6_ai_a101 & inst5_aadd_36_aadder_aresult_node_acs_buffer_a7_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAAC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_high_a6_a,
	datab => inst5_aadd_36_aadder_aresult_node_acs_buffer_a7_a,
	datac => inst_aI5_ai_a17,
	datad => inst6_ai_a101,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_ai_a190);

inst5_apwm_high_a6_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_high_a6_a = DFFEA(inst5_aadd_20_aadder_aresult_node_acs_buffer_a7_a & (inst5_ai_a190 # inst5_ai_a0) # !inst5_aadd_20_aadder_aresult_node_acs_buffer_a7_a & inst5_ai_a190 & !inst5_ai_a0, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_aadd_20_aadder_aresult_node_acs_buffer_a7_a,
	datac => inst5_ai_a190,
	datad => inst5_ai_a0,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_high_a6_a);

inst5_ai_a200_I : flex10ke_lcell 
-- Equation(s):
-- inst5_ai_a200 = inst_aI5_ai_a17 & inst5_apwm_high_a5_a # !inst_aI5_ai_a17 & (inst6_ai_a101 & inst5_apwm_high_a5_a # !inst6_ai_a101 & inst5_aadd_36_aadder_aresult_node_acs_buffer_a6_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAAC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_high_a5_a,
	datab => inst5_aadd_36_aadder_aresult_node_acs_buffer_a6_a,
	datac => inst_aI5_ai_a17,
	datad => inst6_ai_a101,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_ai_a200);

inst5_apwm_high_a5_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_high_a5_a = DFFEA(inst5_aadd_20_aadder_aresult_node_acs_buffer_a6_a & (inst5_ai_a200 # inst5_ai_a0) # !inst5_aadd_20_aadder_aresult_node_acs_buffer_a6_a & inst5_ai_a200 & !inst5_ai_a0, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_aadd_20_aadder_aresult_node_acs_buffer_a6_a,
	datac => inst5_ai_a200,
	datad => inst5_ai_a0,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_high_a5_a);

inst5_ai_a210_I : flex10ke_lcell 
-- Equation(s):
-- inst5_ai_a210 = inst_aI5_ai_a17 & inst5_apwm_high_a4_a # !inst_aI5_ai_a17 & (inst6_ai_a101 & inst5_apwm_high_a4_a # !inst6_ai_a101 & inst5_aadd_36_aadder_aresult_node_acs_buffer_a5_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAAC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_high_a4_a,
	datab => inst5_aadd_36_aadder_aresult_node_acs_buffer_a5_a,
	datac => inst_aI5_ai_a17,
	datad => inst6_ai_a101,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_ai_a210);

inst5_apwm_high_a4_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_high_a4_a = DFFEA(inst5_aadd_20_aadder_aresult_node_acs_buffer_a5_a & (inst5_ai_a210 # inst5_ai_a0) # !inst5_aadd_20_aadder_aresult_node_acs_buffer_a5_a & inst5_ai_a210 & !inst5_ai_a0, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_aadd_20_aadder_aresult_node_acs_buffer_a5_a,
	datac => inst5_ai_a210,
	datad => inst5_ai_a0,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_high_a4_a);

inst5_ai_a220_I : flex10ke_lcell 
-- Equation(s):
-- inst5_ai_a220 = inst_aI5_ai_a17 & inst5_apwm_high_a3_a # !inst_aI5_ai_a17 & (inst6_ai_a101 & inst5_apwm_high_a3_a # !inst6_ai_a101 & inst5_aadd_36_aadder_aresult_node_acs_buffer_a4_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAAC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_high_a3_a,
	datab => inst5_aadd_36_aadder_aresult_node_acs_buffer_a4_a,
	datac => inst_aI5_ai_a17,
	datad => inst6_ai_a101,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_ai_a220);

inst5_apwm_high_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_high_a3_a = DFFEA(inst5_aadd_20_aadder_aresult_node_acs_buffer_a4_a & (inst5_ai_a220 # inst5_ai_a0) # !inst5_aadd_20_aadder_aresult_node_acs_buffer_a4_a & inst5_ai_a220 & !inst5_ai_a0, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_aadd_20_aadder_aresult_node_acs_buffer_a4_a,
	datac => inst5_ai_a220,
	datad => inst5_ai_a0,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_high_a3_a);

inst5_ai_a230_I : flex10ke_lcell 
-- Equation(s):
-- inst5_ai_a230 = inst_aI5_ai_a17 & inst5_apwm_high_a2_a # !inst_aI5_ai_a17 & (inst6_ai_a101 & inst5_apwm_high_a2_a # !inst6_ai_a101 & inst5_aadd_36_aadder_aresult_node_acs_buffer_a3_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAAC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_high_a2_a,
	datab => inst5_aadd_36_aadder_aresult_node_acs_buffer_a3_a,
	datac => inst_aI5_ai_a17,
	datad => inst6_ai_a101,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_ai_a230);

inst5_apwm_high_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_high_a2_a = DFFEA(inst5_aadd_20_aadder_aresult_node_acs_buffer_a3_a & (inst5_ai_a230 # inst5_ai_a0) # !inst5_aadd_20_aadder_aresult_node_acs_buffer_a3_a & inst5_ai_a230 & !inst5_ai_a0, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_aadd_20_aadder_aresult_node_acs_buffer_a3_a,
	datac => inst5_ai_a230,
	datad => inst5_ai_a0,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_high_a2_a);

inst5_ai_a240_I : flex10ke_lcell 
-- Equation(s):
-- inst5_ai_a240 = inst_aI5_ai_a17 & inst5_apwm_high_a1_a # !inst_aI5_ai_a17 & (inst6_ai_a101 & inst5_apwm_high_a1_a # !inst6_ai_a101 & inst5_aadd_36_aadder_aresult_node_acs_buffer_a2_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAAC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_high_a1_a,
	datab => inst5_aadd_36_aadder_aresult_node_acs_buffer_a2_a,
	datac => inst_aI5_ai_a17,
	datad => inst6_ai_a101,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_ai_a240);

inst5_apwm_high_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_high_a1_a = DFFEA(inst5_aadd_20_aadder_aresult_node_acs_buffer_a2_a & (inst5_ai_a240 # inst5_ai_a0) # !inst5_aadd_20_aadder_aresult_node_acs_buffer_a2_a & inst5_ai_a240 & !inst5_ai_a0, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_aadd_20_aadder_aresult_node_acs_buffer_a2_a,
	datac => inst5_ai_a240,
	datad => inst5_ai_a0,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_high_a1_a);

inst5_ai_a250_I : flex10ke_lcell 
-- Equation(s):
-- inst5_ai_a250 = inst_aI5_ai_a17 & inst5_apwm_high_a0_a # !inst_aI5_ai_a17 & (inst6_ai_a101 & inst5_apwm_high_a0_a # !inst6_ai_a101 & !inst5_aadd_36_aadder_aresult_node_acs_buffer_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A8AB",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_high_a0_a,
	datab => inst_aI5_ai_a17,
	datac => inst6_ai_a101,
	datad => inst5_aadd_36_aadder_aresult_node_acs_buffer_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_ai_a250);

inst5_apwm_high_a0_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_high_a0_a = DFFEA(inst5_ai_a250 & (!inst5_aadd_20_aadder_aresult_node_acs_buffer_a1_a # !inst5_ai_a0) # !inst5_ai_a250 & inst5_ai_a0 & !inst5_aadd_20_aadder_aresult_node_acs_buffer_a1_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0CFC",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_ai_a250,
	datac => inst5_ai_a0,
	datad => inst5_aadd_20_aadder_aresult_node_acs_buffer_a1_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_high_a0_a);

inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a0_a : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_count_rtl_4_awysi_counter_aq_a0_a = DFFEA((inst6_actrl_data_c_a0_a $ inst5_apwm_count_rtl_4_awysi_counter_aq_a0_a) & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst6_actrl_data_c_a0_a, , )
-- inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a0_a_aCOUT = CARRY(inst5_apwm_count_rtl_4_awysi_counter_aq_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "clrb_cntr",
	packed_mode => "false",
	lut_mask => "66AA",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_actrl_data_c_a0_a,
	datab => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_count_rtl_4_awysi_counter_aq_a0_a,
	cout => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a0_a_aCOUT);

inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a1_a : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_count_rtl_4_awysi_counter_aq_a1_a = DFFEA((inst5_apwm_count_rtl_4_awysi_counter_aq_a1_a $ (inst6_actrl_data_c_a0_a & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a0_a_aCOUT)) & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst6_actrl_data_c_a0_a, , )
-- inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a1_a_aCOUT = CARRY(inst5_apwm_count_rtl_4_awysi_counter_aq_a1_a & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a0_a_aCOUT)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "clrb_cntr",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "6CA0",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_actrl_data_c_a0_a,
	datab => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	cin => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a0_a_aCOUT,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_count_rtl_4_awysi_counter_aq_a1_a,
	cout => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a1_a_aCOUT);

inst5_aLessThan_82_a81_I : flex10ke_lcell 
-- Equation(s):
-- inst5_aLessThan_82_a81 = inst5_apwm_high_a1_a & (inst5_apwm_high_a0_a & !inst5_apwm_count_rtl_4_awysi_counter_aq_a0_a # !inst5_apwm_count_rtl_4_awysi_counter_aq_a1_a) # !inst5_apwm_high_a1_a & inst5_apwm_high_a0_a & !inst5_apwm_count_rtl_4_awysi_counter_aq_a0_a & !inst5_apwm_count_rtl_4_awysi_counter_aq_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "08AE",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_high_a1_a,
	datab => inst5_apwm_high_a0_a,
	datac => inst5_apwm_count_rtl_4_awysi_counter_aq_a0_a,
	datad => inst5_apwm_count_rtl_4_awysi_counter_aq_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aLessThan_82_a81);

inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a2_a : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_count_rtl_4_awysi_counter_aq_a2_a = DFFEA((inst5_apwm_count_rtl_4_awysi_counter_aq_a2_a $ (inst6_actrl_data_c_a0_a & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a1_a_aCOUT)) & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst6_actrl_data_c_a0_a, , )
-- inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a2_a_aCOUT = CARRY(inst5_apwm_count_rtl_4_awysi_counter_aq_a2_a & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a1_a_aCOUT)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "clrb_cntr",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "6CA0",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_actrl_data_c_a0_a,
	datab => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	cin => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a1_a_aCOUT,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_count_rtl_4_awysi_counter_aq_a2_a,
	cout => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a2_a_aCOUT);

inst5_aLessThan_82_a96_I : flex10ke_lcell 
-- Equation(s):
-- inst5_aLessThan_82_a96 = inst5_apwm_high_a2_a & (inst5_aLessThan_82_a81 # !inst5_apwm_count_rtl_4_awysi_counter_aq_a2_a) # !inst5_apwm_high_a2_a & inst5_aLessThan_82_a81 & !inst5_apwm_count_rtl_4_awysi_counter_aq_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0FC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_apwm_high_a2_a,
	datac => inst5_aLessThan_82_a81,
	datad => inst5_apwm_count_rtl_4_awysi_counter_aq_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aLessThan_82_a96);

inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a3_a : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_count_rtl_4_awysi_counter_aq_a3_a = DFFEA((inst5_apwm_count_rtl_4_awysi_counter_aq_a3_a $ (inst6_actrl_data_c_a0_a & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a2_a_aCOUT)) & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst6_actrl_data_c_a0_a, , )
-- inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a3_a_aCOUT = CARRY(inst5_apwm_count_rtl_4_awysi_counter_aq_a3_a & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a2_a_aCOUT)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "clrb_cntr",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "6CA0",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_actrl_data_c_a0_a,
	datab => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	cin => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a2_a_aCOUT,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_count_rtl_4_awysi_counter_aq_a3_a,
	cout => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a3_a_aCOUT);

inst5_aLessThan_82_a101_I : flex10ke_lcell 
-- Equation(s):
-- inst5_aLessThan_82_a101 = inst5_apwm_high_a3_a & (inst5_aLessThan_82_a96 # !inst5_apwm_count_rtl_4_awysi_counter_aq_a3_a) # !inst5_apwm_high_a3_a & inst5_aLessThan_82_a96 & !inst5_apwm_count_rtl_4_awysi_counter_aq_a3_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0FC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_apwm_high_a3_a,
	datac => inst5_aLessThan_82_a96,
	datad => inst5_apwm_count_rtl_4_awysi_counter_aq_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aLessThan_82_a101);

inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a4_a : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_count_rtl_4_awysi_counter_aq_a4_a = DFFEA((inst5_apwm_count_rtl_4_awysi_counter_aq_a4_a $ (inst6_actrl_data_c_a0_a & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a3_a_aCOUT)) & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst6_actrl_data_c_a0_a, , )
-- inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a4_a_aCOUT = CARRY(inst5_apwm_count_rtl_4_awysi_counter_aq_a4_a & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a3_a_aCOUT)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "clrb_cntr",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "6CA0",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_actrl_data_c_a0_a,
	datab => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	cin => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a3_a_aCOUT,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_count_rtl_4_awysi_counter_aq_a4_a,
	cout => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a4_a_aCOUT);

inst5_aLessThan_82_a103_I : flex10ke_lcell 
-- Equation(s):
-- inst5_aLessThan_82_a103 = inst5_apwm_high_a4_a & (inst5_aLessThan_82_a101 # !inst5_apwm_count_rtl_4_awysi_counter_aq_a4_a) # !inst5_apwm_high_a4_a & inst5_aLessThan_82_a101 & !inst5_apwm_count_rtl_4_awysi_counter_aq_a4_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0FC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_apwm_high_a4_a,
	datac => inst5_aLessThan_82_a101,
	datad => inst5_apwm_count_rtl_4_awysi_counter_aq_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aLessThan_82_a103);

inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a5_a : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_count_rtl_4_awysi_counter_aq_a5_a = DFFEA((inst5_apwm_count_rtl_4_awysi_counter_aq_a5_a $ (inst6_actrl_data_c_a0_a & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a4_a_aCOUT)) & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst6_actrl_data_c_a0_a, , )
-- inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a5_a_aCOUT = CARRY(inst5_apwm_count_rtl_4_awysi_counter_aq_a5_a & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a4_a_aCOUT)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "clrb_cntr",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "6CA0",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_actrl_data_c_a0_a,
	datab => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	cin => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a4_a_aCOUT,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_count_rtl_4_awysi_counter_aq_a5_a,
	cout => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a5_a_aCOUT);

inst5_aLessThan_82_a108_I : flex10ke_lcell 
-- Equation(s):
-- inst5_aLessThan_82_a108 = inst5_apwm_high_a5_a & (inst5_aLessThan_82_a103 # !inst5_apwm_count_rtl_4_awysi_counter_aq_a5_a) # !inst5_apwm_high_a5_a & inst5_aLessThan_82_a103 & !inst5_apwm_count_rtl_4_awysi_counter_aq_a5_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0FC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_apwm_high_a5_a,
	datac => inst5_aLessThan_82_a103,
	datad => inst5_apwm_count_rtl_4_awysi_counter_aq_a5_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aLessThan_82_a108);

inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a6_a : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_count_rtl_4_awysi_counter_aq_a6_a = DFFEA((inst5_apwm_count_rtl_4_awysi_counter_aq_a6_a $ (inst6_actrl_data_c_a0_a & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a5_a_aCOUT)) & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst6_actrl_data_c_a0_a, , )
-- inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a6_a_aCOUT = CARRY(inst5_apwm_count_rtl_4_awysi_counter_aq_a6_a & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a5_a_aCOUT)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "clrb_cntr",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "6CA0",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_actrl_data_c_a0_a,
	datab => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	cin => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a5_a_aCOUT,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_count_rtl_4_awysi_counter_aq_a6_a,
	cout => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a6_a_aCOUT);

inst5_aLessThan_82_a110_I : flex10ke_lcell 
-- Equation(s):
-- inst5_aLessThan_82_a110 = inst5_apwm_high_a6_a & (inst5_aLessThan_82_a108 # !inst5_apwm_count_rtl_4_awysi_counter_aq_a6_a) # !inst5_apwm_high_a6_a & inst5_aLessThan_82_a108 & !inst5_apwm_count_rtl_4_awysi_counter_aq_a6_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0FC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_apwm_high_a6_a,
	datac => inst5_aLessThan_82_a108,
	datad => inst5_apwm_count_rtl_4_awysi_counter_aq_a6_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aLessThan_82_a110);

inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_count_rtl_4_awysi_counter_aq_a7_a = DFFEA((inst5_apwm_count_rtl_4_awysi_counter_aq_a7_a $ (inst6_actrl_data_c_a0_a & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a6_a_aCOUT)) & inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst6_actrl_data_c_a0_a, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "clrb_cntr",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "6C6C",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_actrl_data_c_a0_a,
	datab => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	cin => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a6_a_aCOUT,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_count_rtl_4_awysi_counter_aq_a7_a);

inst5_aLessThan_82_a115_I : flex10ke_lcell 
-- Equation(s):
-- inst5_aLessThan_82_a115 = inst5_apwm_high_a7_a & (inst5_aLessThan_82_a110 # !inst5_apwm_count_rtl_4_awysi_counter_aq_a7_a) # !inst5_apwm_high_a7_a & inst5_aLessThan_82_a110 & !inst5_apwm_count_rtl_4_awysi_counter_aq_a7_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0FC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_apwm_high_a7_a,
	datac => inst5_aLessThan_82_a110,
	datad => inst5_apwm_count_rtl_4_awysi_counter_aq_a7_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aLessThan_82_a115);

inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16_I : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16 = inst5_apwm_c & inst5_aLessThan_82_a115 # !inst5_apwm_c & inst5_aLessThan_79_a115 # !inst6_actrl_data_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ACFF",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_aLessThan_82_a115,
	datab => inst5_aLessThan_79_a115,
	datac => inst5_apwm_c,
	datad => inst6_actrl_data_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_apwm_count_rtl_4_awysi_counter_acounter_cell_a7_a_a16);

inst5_aLessThan_79_a81_I : flex10ke_lcell 
-- Equation(s):
-- inst5_aLessThan_79_a81 = inst5_apwm_low_a1_a & (inst5_apwm_low_a0_a & !inst5_apwm_count_rtl_4_awysi_counter_aq_a0_a # !inst5_apwm_count_rtl_4_awysi_counter_aq_a1_a) # !inst5_apwm_low_a1_a & inst5_apwm_low_a0_a & !inst5_apwm_count_rtl_4_awysi_counter_aq_a0_a & !inst5_apwm_count_rtl_4_awysi_counter_aq_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "08AE",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_low_a1_a,
	datab => inst5_apwm_low_a0_a,
	datac => inst5_apwm_count_rtl_4_awysi_counter_aq_a0_a,
	datad => inst5_apwm_count_rtl_4_awysi_counter_aq_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aLessThan_79_a81);

inst5_aLessThan_79_a96_I : flex10ke_lcell 
-- Equation(s):
-- inst5_aLessThan_79_a96 = inst5_apwm_low_a2_a & (inst5_aLessThan_79_a81 # !inst5_apwm_count_rtl_4_awysi_counter_aq_a2_a) # !inst5_apwm_low_a2_a & inst5_aLessThan_79_a81 & !inst5_apwm_count_rtl_4_awysi_counter_aq_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0FC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_apwm_low_a2_a,
	datac => inst5_aLessThan_79_a81,
	datad => inst5_apwm_count_rtl_4_awysi_counter_aq_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aLessThan_79_a96);

inst5_aLessThan_79_a101_I : flex10ke_lcell 
-- Equation(s):
-- inst5_aLessThan_79_a101 = inst5_apwm_low_a3_a & (inst5_aLessThan_79_a96 # !inst5_apwm_count_rtl_4_awysi_counter_aq_a3_a) # !inst5_apwm_low_a3_a & inst5_aLessThan_79_a96 & !inst5_apwm_count_rtl_4_awysi_counter_aq_a3_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0FC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_apwm_low_a3_a,
	datac => inst5_aLessThan_79_a96,
	datad => inst5_apwm_count_rtl_4_awysi_counter_aq_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aLessThan_79_a101);

inst5_aLessThan_79_a103_I : flex10ke_lcell 
-- Equation(s):
-- inst5_aLessThan_79_a103 = inst5_apwm_low_a4_a & (inst5_aLessThan_79_a101 # !inst5_apwm_count_rtl_4_awysi_counter_aq_a4_a) # !inst5_apwm_low_a4_a & inst5_aLessThan_79_a101 & !inst5_apwm_count_rtl_4_awysi_counter_aq_a4_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0FC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_apwm_low_a4_a,
	datac => inst5_aLessThan_79_a101,
	datad => inst5_apwm_count_rtl_4_awysi_counter_aq_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aLessThan_79_a103);

inst5_aLessThan_79_a108_I : flex10ke_lcell 
-- Equation(s):
-- inst5_aLessThan_79_a108 = inst5_apwm_low_a5_a & (inst5_aLessThan_79_a103 # !inst5_apwm_count_rtl_4_awysi_counter_aq_a5_a) # !inst5_apwm_low_a5_a & inst5_aLessThan_79_a103 & !inst5_apwm_count_rtl_4_awysi_counter_aq_a5_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0FC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_apwm_low_a5_a,
	datac => inst5_aLessThan_79_a103,
	datad => inst5_apwm_count_rtl_4_awysi_counter_aq_a5_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aLessThan_79_a108);

inst5_aLessThan_79_a110_I : flex10ke_lcell 
-- Equation(s):
-- inst5_aLessThan_79_a110 = inst5_apwm_low_a6_a & (inst5_aLessThan_79_a108 # !inst5_apwm_count_rtl_4_awysi_counter_aq_a6_a) # !inst5_apwm_low_a6_a & inst5_aLessThan_79_a108 & !inst5_apwm_count_rtl_4_awysi_counter_aq_a6_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0FC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_apwm_low_a6_a,
	datac => inst5_aLessThan_79_a108,
	datad => inst5_apwm_count_rtl_4_awysi_counter_aq_a6_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aLessThan_79_a110);

inst5_aLessThan_79_a115_I : flex10ke_lcell 
-- Equation(s):
-- inst5_aLessThan_79_a115 = inst5_apwm_low_a7_a & (inst5_aLessThan_79_a110 # !inst5_apwm_count_rtl_4_awysi_counter_aq_a7_a) # !inst5_apwm_low_a7_a & inst5_aLessThan_79_a110 & !inst5_apwm_count_rtl_4_awysi_counter_aq_a7_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0FC",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst5_apwm_low_a7_a,
	datac => inst5_aLessThan_79_a110,
	datad => inst5_apwm_count_rtl_4_awysi_counter_aq_a7_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aLessThan_79_a115);

inst5_apwm_c_a19_I : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_c_a19 = inst6_actrl_data_c_a0_a & (inst5_apwm_c & !inst5_aLessThan_82_a115 # !inst5_apwm_c & !inst5_aLessThan_79_a115)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "028A",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_actrl_data_c_a0_a,
	datab => inst5_apwm_c,
	datac => inst5_aLessThan_79_a115,
	datad => inst5_aLessThan_82_a115,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_apwm_c_a19);

inst5_apwm_c_aI : flex10ke_lcell 
-- Equation(s):
-- inst5_apwm_c = DFFEA(!inst5_apwm_c, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst5_apwm_c_a19, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00FF",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_apwm_c_a19,
	datad => inst5_apwm_c,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_apwm_c);

inst_aI5_adaddr_c_a5_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst_aI5_adaddr_c_a5_a = DFFEA(inst1_alpm_rom_component_asrom_aq_a9_a & nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "false",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => inst1_alpm_rom_component_asrom_aq_a9_a,
	datac => nreset_adataout,
	datad => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI5_adaddr_c_a5_a);

inst_aI5_ai_a8_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI5_ai_a8 = inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a5_a # !inst_aI4_andre_x_a1 & inst1_alpm_rom_component_asrom_aq_a9_a & inst_aI4_ai_a2

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAC0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_adaddr_c_a5_a,
	datab => inst1_alpm_rom_component_asrom_aq_a9_a,
	datac => inst_aI4_ai_a2,
	datad => inst_aI4_andre_x_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI5_ai_a8);

inst_aI5_ai_a11_I : flex10ke_lcell 
-- Equation(s):
-- inst_aI5_ai_a11 = inst_aI5_adaddr_c_a4_a & (inst_aI4_adaddr_x_a4_a_a1 # inst_aI4_andre_x_a1) # !inst_aI5_adaddr_c_a4_a & inst_aI4_adaddr_x_a4_a_a1 & !inst_aI4_andre_x_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	clock_enable_mode => "false",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI5_adaddr_c_a4_a,
	datac => inst_aI4_adaddr_x_a4_a_a1,
	datad => inst_aI4_andre_x_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI5_ai_a11);

inst6_actrl_data_c_a3_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst6_actrl_data_c_a3_a = DFFEA(nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a & inst_aI3_aacc_c_a0_a_a3_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst6_actrl_data_c_a3_a_a8, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_actrl_data_c_a3_a_a8,
	datab => nreset_adataout,
	datac => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a3_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst6_actrl_data_c_a3_a);

inst6_actrl_data_c_a2_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst6_actrl_data_c_a2_a = DFFEA(nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a & inst_aI3_aacc_c_a0_a_a2_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst6_actrl_data_c_a3_a_a8, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_actrl_data_c_a3_a_a8,
	datab => nreset_adataout,
	datac => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a2_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst6_actrl_data_c_a2_a);

inst6_actrl_data_c_a1_a_aI : flex10ke_lcell 
-- Equation(s):
-- inst6_actrl_data_c_a1_a = DFFEA(nreset_adataout & inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a & inst_aI3_aacc_c_a0_a_a1_a, GLOBAL(clk_adataout), GLOBAL(nreset_adataout), , inst6_actrl_data_c_a3_a_a8, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	clock_enable_mode => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_actrl_data_c_a3_a_a8,
	datab => nreset_adataout,
	datac => inst_aI4_anreset_v_rtl_0_awysi_counter_aq_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a1_a,
	aclr => NOT_nreset_adataout,
	clk => clk_adataout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst6_actrl_data_c_a1_a);

pwm_out_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst5_apwm_c,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_pwm_out);

CPU_DADDR_OUT_a5_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI5_ai_a8,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_DADDR_OUT(5));

CPU_DADDR_OUT_a4_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI5_ai_a11,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_DADDR_OUT(4));

CPU_DADDR_OUT_a3_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI5_ai_a14,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_DADDR_OUT(3));

CPU_DADDR_OUT_a2_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI5_ai_a17,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_DADDR_OUT(2));

CPU_DADDR_OUT_a1_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI5_ai_a20,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_DADDR_OUT(1));

CPU_DADDR_OUT_a0_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI5_ai_a23,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_DADDR_OUT(0));

nWE_CPU_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => NOT_inst_aI5_andwe_c,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_nWE_CPU);

nRE_CPU_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI4_andre_x_a1,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_nRE_CPU);

CPU_DATA_OUT_a3_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI4_adata_ox_a3_a_a0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_DATA_OUT(3));

CPU_DATA_OUT_a2_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI4_adata_ox_a2_a_a1,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_DATA_OUT(2));

CPU_DATA_OUT_a1_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI4_adata_ox_a1_a_a2,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_DATA_OUT(1));

CPU_DATA_OUT_a0_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI4_adata_ox_a0_a_a3,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_DATA_OUT(0));

CPU_IADDR_OUT_a7_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI1_aiaddr_x_a7_a_a170,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_IADDR_OUT(7));

CPU_IADDR_OUT_a6_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI1_aiaddr_x_a6_a_a187,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_IADDR_OUT(6));

CPU_IADDR_OUT_a5_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI1_aiaddr_x_a5_a_a204,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_IADDR_OUT(5));

CPU_IADDR_OUT_a4_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI1_aiaddr_x_a4_a_a221,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_IADDR_OUT(4));

CPU_IADDR_OUT_a3_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI1_aiaddr_x_a3_a_a238,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_IADDR_OUT(3));

CPU_IADDR_OUT_a2_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI1_aiaddr_x_a2_a_a255,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_IADDR_OUT(2));

CPU_IADDR_OUT_a1_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI1_aiaddr_x_a1_a_a272,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_IADDR_OUT(1));

CPU_IADDR_OUT_a0_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst_aI1_aiaddr_x_a0_a_a289,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CPU_IADDR_OUT(0));

CTRL_DATA_OUT_a3_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst6_actrl_data_c_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CTRL_DATA_OUT(3));

CTRL_DATA_OUT_a2_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst6_actrl_data_c_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CTRL_DATA_OUT(2));

CTRL_DATA_OUT_a1_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst6_actrl_data_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CTRL_DATA_OUT(1));

CTRL_DATA_OUT_a0_a_aI : flex10ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none")
-- pragma translate_on
PORT MAP (
	datain => inst6_actrl_data_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_CTRL_DATA_OUT(0));
END structure;


