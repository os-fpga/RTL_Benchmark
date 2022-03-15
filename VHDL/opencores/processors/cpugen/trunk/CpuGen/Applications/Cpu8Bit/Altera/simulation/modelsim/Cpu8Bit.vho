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

-- DATE "02/25/2004 23:02:07"

--
-- Device: Altera EP1C3T100C8 Package TQFP100
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL output from Quartus II) only
-- 

LIBRARY IEEE, cyclone;
USE IEEE.std_logic_1164.all;
USE cyclone.cyclone_components.all;

ENTITY 	Cpu8Bit IS
    PORT (
	UCLK : IN std_logic;
	nRESET : IN std_logic;
	PORTA_IN : IN std_logic_vector(7 DOWNTO 0);
	PORTB_IN : IN std_logic_vector(7 DOWNTO 0);
	RXD : IN std_logic;
	IN_INT : IN std_logic_vector(3 DOWNTO 0);
	TXD : OUT std_logic;
	PORTA_OUT : OUT std_logic_vector(7 DOWNTO 0);
	PORTB_OUT : OUT std_logic_vector(7 DOWNTO 0)
	);
END Cpu8Bit;

ARCHITECTURE structure OF Cpu8Bit IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL devoe : std_logic := '0';
SIGNAL ww_UCLK : std_logic;
SIGNAL ww_nRESET : std_logic;
SIGNAL ww_PORTA_IN : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_PORTB_IN : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_RXD : std_logic;
SIGNAL ww_IN_INT : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_TXD : std_logic;
SIGNAL ww_PORTA_OUT : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_PORTB_OUT : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_inst6_aaltsyncram_component_aram_block_a0_a_a4_a_aaddress : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_inst6_aaltsyncram_component_aram_block_a0_a_a4_a_adataout : std_logic_vector(143 DOWNTO 0);
SIGNAL ww_inst6_aaltsyncram_component_aram_block_a0_a_a0_a_aaddress : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_inst6_aaltsyncram_component_aram_block_a0_a_a0_a_adataout : std_logic_vector(143 DOWNTO 0);
SIGNAL ww_inst6_aaltsyncram_component_aram_block_a0_a_a1_a_aaddress : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_inst6_aaltsyncram_component_aram_block_a0_a_a1_a_adataout : std_logic_vector(143 DOWNTO 0);
SIGNAL ww_inst6_aaltsyncram_component_aram_block_a0_a_a13_a_aaddress : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_inst6_aaltsyncram_component_aram_block_a0_a_a13_a_adataout : std_logic_vector(143 DOWNTO 0);
SIGNAL ww_inst7_aaltsyncram_component_aram_block_a0_a_a7_a_aaddress : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_inst7_aaltsyncram_component_aram_block_a0_a_a7_a_adatain : std_logic_vector(143 DOWNTO 0);
SIGNAL ww_inst7_aaltsyncram_component_aram_block_a0_a_a7_a_adataout : std_logic_vector(143 DOWNTO 0);
SIGNAL inst_aI3_aadd_129_a0COUT : std_logic;
SIGNAL inst_aI3_aadd_129_a1COUT : std_logic;
SIGNAL inst_aI3_aadd_129_a2COUT : std_logic;
SIGNAL inst_aI3_aadd_129_a3COUT : std_logic;
SIGNAL inst_aI3_aadd_129_a5COUT : std_logic;
SIGNAL inst_aI3_aadd_129_a6COUT : std_logic;
SIGNAL inst_aI3_aadd_129_a7COUT : std_logic;
SIGNAL inst_aI3_aadd_153_a1COUT : std_logic;
SIGNAL inst_aI3_aadd_153_a2COUT : std_logic;
SIGNAL inst_aI3_aadd_153_a3COUT : std_logic;
SIGNAL inst_aI3_aadd_153_a4COUT : std_logic;
SIGNAL inst_aI3_aadd_153_a6COUT : std_logic;
SIGNAL inst_aI3_aadd_153_a7COUT : std_logic;
SIGNAL inst_aI3_aadd_153_a8COUT : std_logic;
SIGNAL inst_aI4_aadd_104_a0COUT : std_logic;
SIGNAL inst_aI4_aadd_104_a1COUT : std_logic;
SIGNAL inst_aI4_aadd_104_a2COUT : std_logic;
SIGNAL inst_aI4_aadd_104_a3COUT : std_logic;
SIGNAL inst_aI4_aadd_104_a5COUT : std_logic;
SIGNAL inst_aI4_aadd_104_a6COUT : std_logic;
SIGNAL inst_aI1_aadd_185_a0COUT : std_logic;
SIGNAL inst_aI1_aadd_185_a1COUT : std_logic;
SIGNAL inst_aI1_aadd_185_a2COUT : std_logic;
SIGNAL inst_aI1_aadd_185_a3COUT : std_logic;
SIGNAL inst_aI1_aadd_185_a5COUT : std_logic;
SIGNAL inst_aI1_aadd_185_a6COUT : std_logic;
SIGNAL inst_aI1_aadd_185_a7COUT : std_logic;
SIGNAL inst_aI1_aadd_185_a8COUT : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a0COUT : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a1COUT : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a2COUT : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a3COUT : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a5COUT : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a6COUT : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a6_a_aCOUT : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a5_a_aCOUT : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a3_a_aCOUT : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a2_a_aCOUT : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a1_a_aCOUT : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a0_a_aCOUT : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a6_a_aCOUT : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a5_a_aCOUT : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a3_a_aCOUT : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a2_a_aCOUT : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a1_a_aCOUT : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a0_a_aCOUT : std_logic;
SIGNAL inst_aI1_anreset_v_rtl_9_awysi_counter_acounter_cell_a0_a_aCOUT : std_logic;
SIGNAL inst1_atx_16_count_rtl_8_awysi_counter_acounter_cell_a2_a_aCOUT : std_logic;
SIGNAL inst1_atx_16_count_rtl_8_awysi_counter_acounter_cell_a1_a_aCOUT : std_logic;
SIGNAL inst1_atx_16_count_rtl_8_awysi_counter_acounter_cell_a0_a_aCOUT : std_logic;
SIGNAL inst1_atx_bit_count_rtl_7_awysi_counter_acounter_cell_a2_a_aCOUT : std_logic;
SIGNAL inst1_atx_bit_count_rtl_7_awysi_counter_acounter_cell_a1_a_aCOUT : std_logic;
SIGNAL inst1_atx_bit_count_rtl_7_awysi_counter_acounter_cell_a0_a_aCOUT : std_logic;
SIGNAL inst_aI4_anreset_v_rtl_6_awysi_counter_acounter_cell_a0_a_aCOUT : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a6_a_aCOUT : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a5_a_aCOUT : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a3_a_aCOUT : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a2_a_aCOUT : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a1_a_aCOUT : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a0_a_aCOUT : std_logic;
SIGNAL inst_aI2_anreset_v_rtl_4_awysi_counter_acounter_cell_a0_a_aCOUT : std_logic;
SIGNAL inst_aI3_anreset_v_rtl_3_awysi_counter_acounter_cell_a0_a_aCOUT : std_logic;
SIGNAL inst1_atx_uart_shift_a6_a : std_logic;
SIGNAL inst1_atx_uart_shift_a5_a : std_logic;
SIGNAL inst1_atx_uart_shift_a2_a : std_logic;
SIGNAL inst1_atx_uart_shift_a1_a : std_logic;
SIGNAL inst1_atx_uart_shift_a8_a : std_logic;
SIGNAL inst_aI3_askip_i : std_logic;
SIGNAL inst_aI2_askip_c : std_logic;
SIGNAL inst_aI3_aacc_i_a0_a_a7_a : std_logic;
SIGNAL inst_aI2_adata_is_c_a7_a : std_logic;
SIGNAL inst10_areg_data_out_c_a7_a : std_logic;
SIGNAL inst_aI3_aacc_i_a0_a_a8_a : std_logic;
SIGNAL inst_aI3_aacc_i_a0_a_a6_a : std_logic;
SIGNAL inst_aI2_adata_is_c_a6_a : std_logic;
SIGNAL inst10_areg_data_out_c_a6_a : std_logic;
SIGNAL inst_aI3_aacc_i_a0_a_a0_a : std_logic;
SIGNAL inst_aI2_adata_is_c_a0_a : std_logic;
SIGNAL inst10_areg_data_out_c_a0_a : std_logic;
SIGNAL inst_aI2_adata_is_c_a1_a : std_logic;
SIGNAL inst10_areg_data_out_c_a1_a : std_logic;
SIGNAL inst_aI3_aacc_i_a0_a_a1_a : std_logic;
SIGNAL inst_aI2_adata_is_c_a2_a : std_logic;
SIGNAL inst10_areg_data_out_c_a2_a : std_logic;
SIGNAL inst_aI3_aacc_i_a0_a_a2_a : std_logic;
SIGNAL inst_aI3_aacc_i_a0_a_a3_a : std_logic;
SIGNAL inst_aI2_adata_is_c_a3_a : std_logic;
SIGNAL inst10_areg_data_out_c_a3_a : std_logic;
SIGNAL inst_aI3_aacc_i_a0_a_a4_a : std_logic;
SIGNAL inst_aI2_adata_is_c_a4_a : std_logic;
SIGNAL inst10_areg_data_out_c_a4_a : std_logic;
SIGNAL inst_aI3_aacc_i_a0_a_a5_a : std_logic;
SIGNAL inst_aI2_adata_is_c_a5_a : std_logic;
SIGNAL inst10_areg_data_out_c_a5_a : std_logic;
SIGNAL inst2_atmr_count_a7_a : std_logic;
SIGNAL inst2_atmr_count_a6_a : std_logic;
SIGNAL inst2_atmr_count_a0_a : std_logic;
SIGNAL inst2_atmr_count_a1_a : std_logic;
SIGNAL inst2_atmr_count_a2_a : std_logic;
SIGNAL inst2_atmr_count_a3_a : std_logic;
SIGNAL inst2_atmr_count_a4_a : std_logic;
SIGNAL inst2_atmr_count_a5_a : std_logic;
SIGNAL UCLK_apadio : std_logic;
SIGNAL nRESET_apadio : std_logic;
SIGNAL PORTA_IN_a7_a_apadio : std_logic;
SIGNAL PORTB_IN_a7_a_apadio : std_logic;
SIGNAL PORTA_IN_a6_a_apadio : std_logic;
SIGNAL PORTB_IN_a6_a_apadio : std_logic;
SIGNAL PORTA_IN_a0_a_apadio : std_logic;
SIGNAL PORTB_IN_a0_a_apadio : std_logic;
SIGNAL PORTA_IN_a1_a_apadio : std_logic;
SIGNAL PORTB_IN_a1_a_apadio : std_logic;
SIGNAL PORTA_IN_a2_a_apadio : std_logic;
SIGNAL PORTB_IN_a2_a_apadio : std_logic;
SIGNAL PORTA_IN_a3_a_apadio : std_logic;
SIGNAL PORTB_IN_a3_a_apadio : std_logic;
SIGNAL PORTA_IN_a4_a_apadio : std_logic;
SIGNAL PORTB_IN_a4_a_apadio : std_logic;
SIGNAL PORTA_IN_a5_a_apadio : std_logic;
SIGNAL PORTB_IN_a5_a_apadio : std_logic;
SIGNAL RXD_apadio : std_logic;
SIGNAL IN_INT_a0_a_apadio : std_logic;
SIGNAL IN_INT_a1_a_apadio : std_logic;
SIGNAL IN_INT_a2_a_apadio : std_logic;
SIGNAL IN_INT_a3_a_apadio : std_logic;
SIGNAL TXD_apadio : std_logic;
SIGNAL PORTA_OUT_a7_a_apadio : std_logic;
SIGNAL PORTA_OUT_a6_a_apadio : std_logic;
SIGNAL PORTA_OUT_a5_a_apadio : std_logic;
SIGNAL PORTA_OUT_a4_a_apadio : std_logic;
SIGNAL PORTA_OUT_a3_a_apadio : std_logic;
SIGNAL PORTA_OUT_a2_a_apadio : std_logic;
SIGNAL PORTA_OUT_a1_a_apadio : std_logic;
SIGNAL PORTA_OUT_a0_a_apadio : std_logic;
SIGNAL PORTB_OUT_a7_a_apadio : std_logic;
SIGNAL PORTB_OUT_a6_a_apadio : std_logic;
SIGNAL PORTB_OUT_a5_a_apadio : std_logic;
SIGNAL PORTB_OUT_a4_a_apadio : std_logic;
SIGNAL PORTB_OUT_a3_a_apadio : std_logic;
SIGNAL PORTB_OUT_a2_a_apadio : std_logic;
SIGNAL PORTB_OUT_a1_a_apadio : std_logic;
SIGNAL PORTB_OUT_a0_a_apadio : std_logic;
SIGNAL UCLK_acombout : std_logic;
SIGNAL nRESET_acombout : std_logic;
SIGNAL inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a_aCOUT0 : std_logic;
SIGNAL inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a_aCOUT1 : std_logic;
SIGNAL inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a_aCOUT0 : std_logic;
SIGNAL inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a_aCOUT1 : std_logic;
SIGNAL inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a : std_logic;
SIGNAL inst1_atx_s_a12 : std_logic;
SIGNAL inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a : std_logic;
SIGNAL inst_aI1_aLessThan_7_a5 : std_logic;
SIGNAL inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a_aCOUT0 : std_logic;
SIGNAL inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a_aCOUT1 : std_logic;
SIGNAL inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a : std_logic;
SIGNAL inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a : std_logic;
SIGNAL inst_aI2_aLessThan_7_a5 : std_logic;
SIGNAL inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a_aCOUT0 : std_logic;
SIGNAL inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a_aCOUT1 : std_logic;
SIGNAL inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a : std_logic;
SIGNAL inst_aI2_ai_a326 : std_logic;
SIGNAL inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a_aCOUT0 : std_logic;
SIGNAL inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a_aCOUT1 : std_logic;
SIGNAL inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a1_a : std_logic;
SIGNAL inst_aI3_ai_a212 : std_logic;
SIGNAL inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a : std_logic;
SIGNAL inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a : std_logic;
SIGNAL inst_aI4_aLessThan_39_a5 : std_logic;
SIGNAL inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a_aCOUT0 : std_logic;
SIGNAL inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a_aCOUT1 : std_logic;
SIGNAL inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a : std_logic;
SIGNAL inst_aI4_ai_a18 : std_logic;
SIGNAL inst_aI1_apc_a1_a : std_logic;
SIGNAL inst_aI1_apc_a0_a : std_logic;
SIGNAL inst_aI1_aadd_185_a0COUT0 : std_logic;
SIGNAL inst_aI1_aadd_185_a0COUT1 : std_logic;
SIGNAL inst_aI1_aadd_185_a1 : std_logic;
SIGNAL inst_aI2_apc_mux_x_a0_a_a214 : std_logic;
SIGNAL rtl_a2352 : std_logic;
SIGNAL inst_aI2_avalid_c : std_logic;
SIGNAL inst_aI3_ai_a224 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a7_a_a4227 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a7_a_a4226 : std_logic;
SIGNAL inst_aI1_apc_a3_a : std_logic;
SIGNAL inst_aI1_apc_a2_a : std_logic;
SIGNAL inst_aI1_aadd_185_a1COUT0 : std_logic;
SIGNAL inst_aI1_aadd_185_a1COUT1 : std_logic;
SIGNAL inst_aI1_aadd_185_a2COUT0 : std_logic;
SIGNAL inst_aI1_aadd_185_a2COUT1 : std_logic;
SIGNAL inst_aI1_aadd_185_a3 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a3_a_a369 : std_logic;
SIGNAL rtl_a2519 : std_logic;
SIGNAL inst_aI1_aMux_197_rtl_141_a0 : std_logic;
SIGNAL inst_aI1_ai_a2 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a7_a_a3_a : std_logic;
SIGNAL rtl_a3175 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a6_a_a3_a : std_logic;
SIGNAL rtl_a3075 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a5_a_a3_a : std_logic;
SIGNAL rtl_a2975 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a4_a_a3_a : std_logic;
SIGNAL rtl_a2875 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a3_a : std_logic;
SIGNAL rtl_a2775 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a3_a : std_logic;
SIGNAL rtl_a2635 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a3_a : std_logic;
SIGNAL inst_aI1_apc_a4_a : std_logic;
SIGNAL inst_aI1_aadd_185_a3COUT0 : std_logic;
SIGNAL inst_aI1_aadd_185_a3COUT1 : std_logic;
SIGNAL inst_aI1_aadd_185_a4 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a4_a_a379 : std_logic;
SIGNAL rtl_a2529 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a7_a_a4_a : std_logic;
SIGNAL rtl_a3185 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a6_a_a4_a : std_logic;
SIGNAL rtl_a3085 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a5_a_a4_a : std_logic;
SIGNAL rtl_a2985 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a4_a_a4_a : std_logic;
SIGNAL rtl_a2885 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a4_a : std_logic;
SIGNAL rtl_a2785 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a4_a : std_logic;
SIGNAL rtl_a2645 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a4_a : std_logic;
SIGNAL inst_aI1_apc_a5_a : std_logic;
SIGNAL inst_aI1_aadd_185_a4COUT : std_logic;
SIGNAL inst_aI1_aadd_185_a5 : std_logic;
SIGNAL rtl_a2539 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a7_a_a5_a : std_logic;
SIGNAL rtl_a3195 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a6_a_a5_a : std_logic;
SIGNAL rtl_a3095 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a5_a_a5_a : std_logic;
SIGNAL rtl_a2995 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a4_a_a5_a : std_logic;
SIGNAL rtl_a2895 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a5_a : std_logic;
SIGNAL rtl_a2795 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a5_a : std_logic;
SIGNAL rtl_a2655 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a5_a : std_logic;
SIGNAL inst_aI1_apc_a6_a : std_logic;
SIGNAL inst_aI1_aadd_185_a5COUT0 : std_logic;
SIGNAL inst_aI1_aadd_185_a5COUT1 : std_logic;
SIGNAL inst_aI1_aadd_185_a6 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a6_a_a399 : std_logic;
SIGNAL rtl_a2549 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a7_a_a6_a : std_logic;
SIGNAL rtl_a3205 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a6_a_a6_a : std_logic;
SIGNAL rtl_a3105 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a5_a_a6_a : std_logic;
SIGNAL rtl_a3005 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a4_a_a6_a : std_logic;
SIGNAL rtl_a2905 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a6_a : std_logic;
SIGNAL rtl_a2805 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a6_a : std_logic;
SIGNAL rtl_a2665 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a6_a : std_logic;
SIGNAL inst_aI1_aMux_287_a32 : std_logic;
SIGNAL inst_aI1_apc_a9_a : std_logic;
SIGNAL inst_aI1_apc_a8_a : std_logic;
SIGNAL inst_aI1_apc_a7_a : std_logic;
SIGNAL inst_aI1_aadd_185_a6COUT0 : std_logic;
SIGNAL inst_aI1_aadd_185_a6COUT1 : std_logic;
SIGNAL inst_aI1_aadd_185_a7COUT0 : std_logic;
SIGNAL inst_aI1_aadd_185_a7COUT1 : std_logic;
SIGNAL inst_aI1_aadd_185_a8COUT0 : std_logic;
SIGNAL inst_aI1_aadd_185_a8COUT1 : std_logic;
SIGNAL inst_aI1_aadd_185_a9 : std_logic;
SIGNAL rtl_a2579 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a7_a_a9_a : std_logic;
SIGNAL rtl_a3235 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a6_a_a9_a : std_logic;
SIGNAL rtl_a3135 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a5_a_a9_a : std_logic;
SIGNAL rtl_a3035 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a4_a_a9_a : std_logic;
SIGNAL rtl_a2935 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a9_a : std_logic;
SIGNAL rtl_a2835 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a9_a : std_logic;
SIGNAL rtl_a2695 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a9_a : std_logic;
SIGNAL inst6_aaltsyncram_component_aq_a_a13_a : std_logic;
SIGNAL rtl_a452 : std_logic;
SIGNAL inst_aI1_aMux_268_rtl_225_a0 : std_logic;
SIGNAL inst_aI1_aMux_268_rtl_225_a1 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a9_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a9_a_a358 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a9_a_a429 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a9_a_a428 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a9_a_a432 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a9_a_a182 : std_logic;
SIGNAL inst6_aaltsyncram_component_aq_a_a12_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a8_a_a418 : std_logic;
SIGNAL inst_aI1_aadd_185_a8 : std_logic;
SIGNAL rtl_a2569 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a7_a_a8_a : std_logic;
SIGNAL rtl_a3225 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a6_a_a8_a : std_logic;
SIGNAL rtl_a3125 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a5_a_a8_a : std_logic;
SIGNAL rtl_a3025 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a4_a_a8_a : std_logic;
SIGNAL rtl_a2925 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a8_a : std_logic;
SIGNAL rtl_a2825 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a8_a : std_logic;
SIGNAL rtl_a2685 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a8_a : std_logic;
SIGNAL rtl_a451 : std_logic;
SIGNAL inst_aI1_aMux_269_rtl_222_a0 : std_logic;
SIGNAL inst_aI1_aMux_269_rtl_222_a1 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a8_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a8_a_a349 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a8_a_a419 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a8_a_a422 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a8_a_a172 : std_logic;
SIGNAL inst6_aaltsyncram_component_aq_a_a11_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a7_a_a408 : std_logic;
SIGNAL inst_aI1_aadd_185_a7 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a7_a_a409 : std_logic;
SIGNAL rtl_a2559 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a7_a_a7_a : std_logic;
SIGNAL rtl_a3215 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a6_a_a7_a : std_logic;
SIGNAL rtl_a3115 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a5_a_a7_a : std_logic;
SIGNAL rtl_a3015 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a4_a_a7_a : std_logic;
SIGNAL rtl_a2915 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a7_a : std_logic;
SIGNAL rtl_a2815 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a7_a : std_logic;
SIGNAL rtl_a2675 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a7_a : std_logic;
SIGNAL rtl_a450 : std_logic;
SIGNAL inst_aI1_aMux_270_rtl_219_a0 : std_logic;
SIGNAL inst_aI1_aMux_270_rtl_219_a1 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a7_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a7_a_a340 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a7_a_a412 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a7_a_a162 : std_logic;
SIGNAL inst6_aaltsyncram_component_aq_a_a10_a : std_logic;
SIGNAL rtl_a449 : std_logic;
SIGNAL inst_aI1_aMux_271_rtl_216_a0 : std_logic;
SIGNAL inst_aI1_aMux_271_rtl_216_a1 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a6_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a6_a_a331 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a6_a_a398 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a6_a_a402 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a6_a_a152 : std_logic;
SIGNAL inst6_aaltsyncram_component_aq_a_a9_a : std_logic;
SIGNAL rtl_a448 : std_logic;
SIGNAL inst_aI1_aMux_272_rtl_213_a0 : std_logic;
SIGNAL inst_aI1_aMux_272_rtl_213_a1 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a5_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a5_a_a322 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a5_a_a388 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a5_a_a389 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a5_a_a392 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a5_a_a142 : std_logic;
SIGNAL inst6_aaltsyncram_component_aq_a_a8_a : std_logic;
SIGNAL rtl_a447 : std_logic;
SIGNAL inst_aI1_aMux_273_rtl_210_a0 : std_logic;
SIGNAL inst_aI1_aMux_273_rtl_210_a1 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a4_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a4_a_a313 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a4_a_a378 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a4_a_a382 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a4_a_a132 : std_logic;
SIGNAL inst6_aaltsyncram_component_aq_a_a7_a : std_logic;
SIGNAL rtl_a446 : std_logic;
SIGNAL inst_aI1_aMux_274_rtl_207_a0 : std_logic;
SIGNAL inst_aI1_aMux_274_rtl_207_a1 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a3_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a3_a_a304 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a3_a_a368 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a3_a_a372 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a3_a_a122 : std_logic;
SIGNAL inst6_aaltsyncram_component_aq_a_a1_a : std_logic;
SIGNAL inst6_aaltsyncram_component_aq_a_a5_a : std_logic;
SIGNAL inst6_aaltsyncram_component_aq_a_a4_a : std_logic;
SIGNAL inst_aI2_aMux_66_a0 : std_logic;
SIGNAL inst6_aaltsyncram_component_aq_a_a3_a : std_logic;
SIGNAL rtl_a14849 : std_logic;
SIGNAL inst_aI2_aTD_c_a2_a : std_logic;
SIGNAL inst_aI2_aMux_67_a0 : std_logic;
SIGNAL inst_aI2_aTD_c_a1_a : std_logic;
SIGNAL inst_aI4_adaddr_x_a8_a_a4 : std_logic;
SIGNAL inst_aI4_ai_a1256 : std_logic;
SIGNAL inst_aI4_ai_a1234 : std_logic;
SIGNAL inst_aI4_ai_a1250 : std_logic;
SIGNAL inst_aI2_aTC_x_a2_a_a108 : std_logic;
SIGNAL inst_aI2_aTD_x_a3_a_a9 : std_logic;
SIGNAL inst_aI2_aTC_x_a2_a_a112 : std_logic;
SIGNAL inst_aI2_aC_store_x_a24 : std_logic;
SIGNAL inst_aI4_ai_a20 : std_logic;
SIGNAL inst_aI2_aC_store_x_a32 : std_logic;
SIGNAL inst_aI2_aC_mem_x_a0 : std_logic;
SIGNAL inst_aI2_andre_x_a43 : std_logic;
SIGNAL inst_aI4_andre_x_a1 : std_logic;
SIGNAL inst_aI5_ai_a24 : std_logic;
SIGNAL inst_aI4_ai_a133 : std_logic;
SIGNAL inst_aI2_aS_c_a9 : std_logic;
SIGNAL inst_aI2_ai_a352 : std_logic;
SIGNAL inst_aI2_andwe_x_a51 : std_logic;
SIGNAL inst_aI5_andwe_c : std_logic;
SIGNAL inst1_ai_a457 : std_logic;
SIGNAL inst_aI4_areduce_nor_106 : std_logic;
SIGNAL inst_aI4_aireg_we_c : std_logic;
SIGNAL inst_aI4_areduce_nor_103 : std_logic;
SIGNAL inst_aI4_areduce_nor_119_a19 : std_logic;
SIGNAL inst_aI4_aiinc_we_c : std_logic;
SIGNAL inst_aI4_aireg_i_a0_a_a6 : std_logic;
SIGNAL inst_aI4_aiinc_i_a0_a : std_logic;
SIGNAL inst_aI4_aiinc_x_a0_a_a23 : std_logic;
SIGNAL inst_aI4_aiinc_c_a0_a : std_logic;
SIGNAL inst_aI4_aadd_104_a0 : std_logic;
SIGNAL inst_aI4_aadd_104_rtl_648_a48 : std_logic;
SIGNAL inst_aI4_aireg_i_a0_a : std_logic;
SIGNAL inst_aI4_aadd_104_rtl_648_a53 : std_logic;
SIGNAL inst_aI4_aireg_c_a0_a : std_logic;
SIGNAL inst_aI5_adaddr_c_a0_a : std_logic;
SIGNAL inst_aI4_adaddr_x_a0_a_a27 : std_logic;
SIGNAL inst_aI4_adaddr_x_a0_a_a28 : std_logic;
SIGNAL inst_aI5_ai_a12 : std_logic;
SIGNAL inst_aI4_adaddr_x_a2_a_a29 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a8_a_a63 : std_logic;
SIGNAL inst_aI3_adata_x_a7_a_a1620 : std_logic;
SIGNAL inst_aI3_adata_x_a2_a_a449 : std_logic;
SIGNAL inst_aI4_aiinc_i_a2_a : std_logic;
SIGNAL inst_aI4_aiinc_x_a2_a_a17 : std_logic;
SIGNAL inst_aI4_aiinc_c_a2_a : std_logic;
SIGNAL inst_aI3_adata_x_a2_a_a442 : std_logic;
SIGNAL inst_aI4_ai_a528 : std_logic;
SIGNAL inst_aI3_adata_x_a2_a_a1844 : std_logic;
SIGNAL RXD_acombout : std_logic;
SIGNAL rtl_a1015 : std_logic;
SIGNAL rtl_a14838 : std_logic;
SIGNAL inst_aI2_aMux_68_a0 : std_logic;
SIGNAL inst_aI2_aTD_c_a0_a : std_logic;
SIGNAL rtl_a2707 : std_logic;
SIGNAL rtl_a2715 : std_logic;
SIGNAL rtl_a14840 : std_logic;
SIGNAL inst8_arx_bit_count_a0_a : std_logic;
SIGNAL inst8_arx_bit_count_a1_a : std_logic;
SIGNAL inst8_aadd_39_a10 : std_logic;
SIGNAL rtl_a2058 : std_logic;
SIGNAL inst8_arx_bit_count_a2_a : std_logic;
SIGNAL rtl_a15502 : std_logic;
SIGNAL rtl_a2060 : std_logic;
SIGNAL inst8_arx_bit_count_a3_a : std_logic;
SIGNAL inst8_aDecoder_28_a17 : std_logic;
SIGNAL inst8_arx_uart_reg_a1_a_a7 : std_logic;
SIGNAL inst8_arx_uart_reg_a1_a : std_logic;
SIGNAL inst8_aDecoder_28_a24 : std_logic;
SIGNAL inst8_arx_uart_reg_a8_a_a0 : std_logic;
SIGNAL inst8_arx_uart_reg_a8_a : std_logic;
SIGNAL inst8_arx_uart_fifo_a7_a_a29 : std_logic;
SIGNAL inst8_aadd_72_a52 : std_logic;
SIGNAL inst8_arx_8_count_a2_a : std_logic;
SIGNAL inst8_arx_uart_fifo_a7_a_a32 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a7_a_a4225 : std_logic;
SIGNAL inst_aI3_aMux_201_rtl_95_a0 : std_logic;
SIGNAL rtl_a14847 : std_logic;
SIGNAL inst_aI3_adata_x_a7_a_a99 : std_logic;
SIGNAL inst_aI4_aiinc_i_a7_a : std_logic;
SIGNAL inst_aI4_aiinc_x_a7_a_a2 : std_logic;
SIGNAL inst_aI4_aiinc_c_a7_a : std_logic;
SIGNAL inst_aI3_adata_x_a4_a_a309 : std_logic;
SIGNAL inst_aI4_aiinc_i_a4_a : std_logic;
SIGNAL inst_aI4_aiinc_x_a4_a_a11 : std_logic;
SIGNAL inst_aI4_aiinc_c_a4_a : std_logic;
SIGNAL inst_aI3_adata_x_a4_a_a302 : std_logic;
SIGNAL inst_aI3_adata_x_a4_a_a1778 : std_logic;
SIGNAL inst8_aDecoder_28_a20 : std_logic;
SIGNAL inst8_arx_uart_reg_a4_a_a4 : std_logic;
SIGNAL inst8_arx_uart_reg_a4_a : std_logic;
SIGNAL inst8_arx_uart_fifo_a4_a : std_logic;
SIGNAL inst_aI4_adaddr_x_a4_a_a31 : std_logic;
SIGNAL inst_aI5_adaddr_c_a4_a : std_logic;
SIGNAL inst_aI4_adaddr_x_a4_a_a32 : std_logic;
SIGNAL inst_aI5_ai_a18 : std_logic;
SIGNAL inst5_amux_c_a1_a : std_logic;
SIGNAL inst5_amux_c_a0_a : std_logic;
SIGNAL inst_aI5_adaddr_c_a8_a : std_logic;
SIGNAL inst5_ai_a45 : std_logic;
SIGNAL inst_aI4_aiinc_i_a1_a : std_logic;
SIGNAL inst_aI4_aiinc_x_a1_a_a20 : std_logic;
SIGNAL inst_aI4_aiinc_c_a1_a : std_logic;
SIGNAL inst_aI4_aadd_104_a0COUT0 : std_logic;
SIGNAL inst_aI4_aadd_104_a0COUT1 : std_logic;
SIGNAL inst_aI4_aadd_104_a1 : std_logic;
SIGNAL inst_aI4_aadd_104_rtl_648_a118 : std_logic;
SIGNAL inst_aI4_aireg_i_a1_a : std_logic;
SIGNAL inst_aI4_aadd_104_rtl_648_a123 : std_logic;
SIGNAL inst_aI4_aireg_c_a1_a : std_logic;
SIGNAL inst_aI5_adaddr_c_a1_a : std_logic;
SIGNAL inst_aI4_adaddr_x_a1_a_a45 : std_logic;
SIGNAL inst_aI5_ai_a27 : std_logic;
SIGNAL inst8_aDecoder_28_a21 : std_logic;
SIGNAL inst8_arx_uart_reg_a5_a_a3 : std_logic;
SIGNAL inst8_arx_uart_reg_a5_a : std_logic;
SIGNAL inst8_arx_uart_fifo_a5_a : std_logic;
SIGNAL inst_aI4_aiinc_i_a6_a : std_logic;
SIGNAL inst_aI4_aiinc_x_a6_a_a5 : std_logic;
SIGNAL inst_aI4_aiinc_c_a6_a : std_logic;
SIGNAL inst_aI4_aiinc_i_a5_a : std_logic;
SIGNAL inst_aI4_aiinc_x_a5_a_a8 : std_logic;
SIGNAL inst_aI4_aiinc_c_a5_a : std_logic;
SIGNAL inst_aI4_aadd_104_a5COUT0 : std_logic;
SIGNAL inst_aI4_aadd_104_a5COUT1 : std_logic;
SIGNAL inst_aI4_aadd_104_a6 : std_logic;
SIGNAL inst_aI4_aadd_104_rtl_648_a98 : std_logic;
SIGNAL inst_aI4_aireg_i_a6_a : std_logic;
SIGNAL inst_aI4_aadd_104_rtl_648_a103 : std_logic;
SIGNAL inst_aI4_aireg_c_a6_a : std_logic;
SIGNAL inst_aI5_adaddr_c_a6_a : std_logic;
SIGNAL inst_aI4_adaddr_x_a6_a_a59 : std_logic;
SIGNAL inst_aI5_ai_a33 : std_logic;
SIGNAL inst_aI5_adaddr_c_a7_a : std_logic;
SIGNAL inst_aI4_adaddr_x_a7_a_a66 : std_logic;
SIGNAL inst_aI5_ai_a36 : std_logic;
SIGNAL inst2_ai_a300 : std_logic;
SIGNAL inst5_areduce_nor_21 : std_logic;
SIGNAL inst10_ai_a1 : std_logic;
SIGNAL inst_aI4_adata_ox_a2_a_a5 : std_logic;
SIGNAL inst_aI3_adata_x_a3_a_a379 : std_logic;
SIGNAL inst_aI4_aiinc_i_a3_a : std_logic;
SIGNAL inst_aI4_aiinc_x_a3_a_a14 : std_logic;
SIGNAL inst_aI4_aiinc_c_a3_a : std_logic;
SIGNAL inst_aI3_adata_x_a3_a_a372 : std_logic;
SIGNAL inst_aI3_adata_x_a3_a_a1811 : std_logic;
SIGNAL inst8_aDecoder_28_a19 : std_logic;
SIGNAL inst8_arx_uart_reg_a3_a_a5 : std_logic;
SIGNAL inst8_arx_uart_reg_a3_a : std_logic;
SIGNAL inst8_arx_uart_fifo_a3_a : std_logic;
SIGNAL inst_aI4_adata_ox_a4_a_a3 : std_logic;
SIGNAL inst_aI4_adata_ox_a5_a_a2 : std_logic;
SIGNAL inst7_aaltsyncram_component_aq_a_a3_a : std_logic;
SIGNAL inst_aI3_adata_x_a3_a_a367 : std_logic;
SIGNAL inst_aI3_adata_x_a3_a_a381 : std_logic;
SIGNAL inst_aI4_adaddr_x_a0_a_a18 : std_logic;
SIGNAL inst2_ai_a301 : std_logic;
SIGNAL inst2_ai_a142 : std_logic;
SIGNAL inst2_atmr_reset : std_logic;
SIGNAL inst2_ai_a74 : std_logic;
SIGNAL inst2_ai_a80 : std_logic;
SIGNAL inst2_ai_a77 : std_logic;
SIGNAL inst2_ai_a76 : std_logic;
SIGNAL inst2_ai_a75 : std_logic;
SIGNAL inst2_ai_a73 : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a_aCOUT0 : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a_aCOUT1 : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a_aCOUT0 : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a_aCOUT1 : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a_aCOUT0 : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a_aCOUT1 : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a_aCOUT0 : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a_aCOUT1 : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a4_a : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a4_a_aCOUT : std_logic;
SIGNAL inst2_ai_a79 : std_logic;
SIGNAL inst2_ai_a78 : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a_aCOUT0 : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a_aCOUT1 : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a_aCOUT0 : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a_aCOUT1 : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a7_a : std_logic;
SIGNAL inst2_areduce_nor_58_a30 : std_logic;
SIGNAL inst2_atmr_enable : std_logic;
SIGNAL inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a : std_logic;
SIGNAL inst2_areduce_nor_58_a35 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a152 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a0 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a375 : std_logic;
SIGNAL inst2_atmr_count_a7_a_a7 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a435 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a366 : std_logic;
SIGNAL inst2_atmr_high_a0_a : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a0COUT0 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a0COUT1 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a1 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a357 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a428 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a348 : std_logic;
SIGNAL inst2_atmr_high_a1_a : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a1COUT0 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a1COUT1 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a2 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a339 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a421 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a330 : std_logic;
SIGNAL inst2_atmr_high_a2_a : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a2COUT0 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a2COUT1 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a3COUT0 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a3COUT1 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a4 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a303 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a407 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a294 : std_logic;
SIGNAL inst2_atmr_high_a4_a : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a4COUT : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a5 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a285 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a400 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a276 : std_logic;
SIGNAL inst2_atmr_high_a5_a : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a5COUT0 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a5COUT1 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a6 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a267 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a393 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a258 : std_logic;
SIGNAL inst2_atmr_high_a6_a : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a6COUT0 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a6COUT1 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a7 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a249 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a386 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a240 : std_logic;
SIGNAL inst2_atmr_high_a7_a : std_logic;
SIGNAL inst2_ai_a327 : std_logic;
SIGNAL inst2_ai_a332 : std_logic;
SIGNAL inst2_ai_a345 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_a3 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a321 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a414 : std_logic;
SIGNAL inst2_aadd_47_rtl_1_rtl_652_a312 : std_logic;
SIGNAL inst2_atmr_high_a3_a : std_logic;
SIGNAL IN_INT_a3_a_acombout : std_logic;
SIGNAL inst3_ai_a1 : std_logic;
SIGNAL inst3_aint_mask_c_a3_a : std_logic;
SIGNAL inst3_aint_masked_a3_a : std_logic;
SIGNAL inst3_aint_masked_c_a3_a : std_logic;
SIGNAL inst3_aint_clr_c_a3_a : std_logic;
SIGNAL inst3_aint_pending_c_a3_a : std_logic;
SIGNAL inst5_aMux_14_rtl_239_a0 : std_logic;
SIGNAL inst10_ai_a113 : std_logic;
SIGNAL inst10_ai_a3 : std_logic;
SIGNAL PORTA_IN_a3_a_acombout : std_logic;
SIGNAL inst_aI4_andre_x_a26 : std_logic;
SIGNAL inst10_ai_a108 : std_logic;
SIGNAL PORTB_IN_a3_a_acombout : std_logic;
SIGNAL inst10_areg_data_out_x_a3_a_a81 : std_logic;
SIGNAL inst10_areg_data_out_x_a3_a_a82 : std_logic;
SIGNAL inst10_areg_data_out_x_a3_a_a85 : std_logic;
SIGNAL inst5_aMux_14_rtl_239_a1 : std_logic;
SIGNAL inst_aI3_adata_x_a3_a_a377 : std_logic;
SIGNAL rtl_a1829 : std_logic;
SIGNAL rtl_a14854 : std_logic;
SIGNAL rtl_a2292 : std_logic;
SIGNAL rtl_a3418 : std_logic;
SIGNAL rtl_a3308 : std_logic;
SIGNAL rtl_a2439 : std_logic;
SIGNAL inst_aI3_aadd_153_a1COUT0 : std_logic;
SIGNAL inst_aI3_aadd_153_a1COUT1 : std_logic;
SIGNAL inst_aI3_aadd_153_a2COUT0 : std_logic;
SIGNAL inst_aI3_aadd_153_a2COUT1 : std_logic;
SIGNAL inst_aI3_aadd_153_a3COUT0 : std_logic;
SIGNAL inst_aI3_aadd_153_a3COUT1 : std_logic;
SIGNAL inst_aI3_aadd_153_a4 : std_logic;
SIGNAL inst_aI3_aadd_129_a0COUT0 : std_logic;
SIGNAL inst_aI3_aadd_129_a0COUT1 : std_logic;
SIGNAL inst_aI3_aadd_129_a1COUT0 : std_logic;
SIGNAL inst_aI3_aadd_129_a1COUT1 : std_logic;
SIGNAL inst_aI3_aadd_129_a2COUT0 : std_logic;
SIGNAL inst_aI3_aadd_129_a2COUT1 : std_logic;
SIGNAL inst_aI3_aadd_129_a3 : std_logic;
SIGNAL inst_aI3_aMux_175_rtl_67_rtl_534_a0 : std_logic;
SIGNAL inst_aI3_aMux_175_rtl_67_rtl_534_a1 : std_logic;
SIGNAL rtl_a15320 : std_logic;
SIGNAL rtl_a2438 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a3_a_a108 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a3_a_a4273 : std_logic;
SIGNAL inst_aI3_aacc_c_a0_a_a3_a : std_logic;
SIGNAL inst_aI4_adata_ox_a3_a_a4 : std_logic;
SIGNAL inst7_aaltsyncram_component_aq_a_a5_a : std_logic;
SIGNAL inst_aI3_adata_x_a5_a_a227 : std_logic;
SIGNAL inst_aI3_adata_x_a5_a_a241 : std_logic;
SIGNAL inst_aI3_adata_x_a5_a_a239 : std_logic;
SIGNAL inst_aI3_adata_x_a5_a_a232 : std_logic;
SIGNAL inst_aI3_adata_x_a5_a_a1745 : std_logic;
SIGNAL inst3_aint_mask_c_a5_a : std_logic;
SIGNAL rtl_a15549 : std_logic;
SIGNAL inst1_ai_a500 : std_logic;
SIGNAL inst8_arx_uart_full_c : std_logic;
SIGNAL inst8_arx_uart_full_s : std_logic;
SIGNAL inst8_arx_uart_full_d : std_logic;
SIGNAL inst3_aint_masked_a5_a : std_logic;
SIGNAL inst3_aint_masked_c_a5_a : std_logic;
SIGNAL inst3_aint_clr_c_a5_a : std_logic;
SIGNAL inst3_aint_pending_c_a5_a : std_logic;
SIGNAL inst5_aMux_12_rtl_233_a0 : std_logic;
SIGNAL PORTA_IN_a5_a_acombout : std_logic;
SIGNAL PORTB_IN_a5_a_acombout : std_logic;
SIGNAL inst10_areg_data_out_x_a5_a_a61 : std_logic;
SIGNAL inst10_areg_data_out_x_a5_a_a62 : std_logic;
SIGNAL inst10_areg_data_out_x_a5_a_a65 : std_logic;
SIGNAL inst5_aMux_12_rtl_233_a1 : std_logic;
SIGNAL inst_aI3_adata_x_a5_a_a237 : std_logic;
SIGNAL rtl_a1747 : std_logic;
SIGNAL rtl_a2280 : std_logic;
SIGNAL rtl_a3398 : std_logic;
SIGNAL rtl_a3286 : std_logic;
SIGNAL rtl_a2409 : std_logic;
SIGNAL inst_aI3_aadd_129_a3COUT0 : std_logic;
SIGNAL inst_aI3_aadd_129_a3COUT1 : std_logic;
SIGNAL inst_aI3_aadd_129_a4COUT : std_logic;
SIGNAL inst_aI3_aadd_129_a5 : std_logic;
SIGNAL inst_aI3_aadd_153_a4COUT0 : std_logic;
SIGNAL inst_aI3_aadd_153_a4COUT1 : std_logic;
SIGNAL inst_aI3_aadd_153_a5COUT : std_logic;
SIGNAL inst_aI3_aadd_153_a6 : std_logic;
SIGNAL inst_aI3_aMux_173_rtl_55_rtl_522_a0 : std_logic;
SIGNAL inst_aI3_aMux_173_rtl_55_rtl_522_a1 : std_logic;
SIGNAL rtl_a15234 : std_logic;
SIGNAL rtl_a2408 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a5_a_a88 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a5_a_a4263 : std_logic;
SIGNAL inst_aI3_aacc_c_a0_a_a5_a : std_logic;
SIGNAL inst_aI4_aadd_104_a5 : std_logic;
SIGNAL inst_aI4_aadd_104_rtl_648_a108 : std_logic;
SIGNAL inst_aI4_aireg_i_a5_a : std_logic;
SIGNAL inst_aI4_aadd_104_rtl_648_a113 : std_logic;
SIGNAL inst_aI4_aireg_c_a5_a : std_logic;
SIGNAL inst_aI5_adaddr_c_a5_a : std_logic;
SIGNAL inst_aI4_adaddr_x_a5_a_a52 : std_logic;
SIGNAL inst_aI5_ai_a30 : std_logic;
SIGNAL inst7_aaltsyncram_component_aq_a_a4_a : std_logic;
SIGNAL inst_aI3_adata_x_a4_a_a297 : std_logic;
SIGNAL inst_aI3_adata_x_a4_a_a311 : std_logic;
SIGNAL inst3_aint_mask_c_a4_a : std_logic;
SIGNAL inst8_arx_uart_ovr_s : std_logic;
SIGNAL inst8_arx_uart_ovr_d : std_logic;
SIGNAL inst3_aint_masked_a4_a : std_logic;
SIGNAL inst3_aint_masked_c_a4_a : std_logic;
SIGNAL inst3_aint_clr_c_a4_a : std_logic;
SIGNAL inst3_aint_pending_c_a4_a : std_logic;
SIGNAL PORTA_IN_a4_a_acombout : std_logic;
SIGNAL PORTB_IN_a4_a_acombout : std_logic;
SIGNAL inst10_areg_data_out_x_a4_a_a71 : std_logic;
SIGNAL inst10_areg_data_out_x_a4_a_a72 : std_logic;
SIGNAL inst10_areg_data_out_x_a4_a_a75 : std_logic;
SIGNAL inst5_aMux_13_rtl_236_a0 : std_logic;
SIGNAL inst5_aMux_13_rtl_236_a1 : std_logic;
SIGNAL inst_aI3_adata_x_a4_a_a307 : std_logic;
SIGNAL rtl_a1788 : std_logic;
SIGNAL rtl_a2286 : std_logic;
SIGNAL rtl_a3297 : std_logic;
SIGNAL rtl_a3408 : std_logic;
SIGNAL rtl_a2424 : std_logic;
SIGNAL inst_aI3_aadd_129_a4 : std_logic;
SIGNAL inst_aI3_aadd_153_a5 : std_logic;
SIGNAL inst_aI3_aMux_174_rtl_61_rtl_528_a0 : std_logic;
SIGNAL inst_aI3_aMux_174_rtl_61_rtl_528_a1 : std_logic;
SIGNAL rtl_a15277 : std_logic;
SIGNAL rtl_a2423 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a4_a_a98 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a4_a_a4268 : std_logic;
SIGNAL inst_aI3_aacc_c_a0_a_a4_a : std_logic;
SIGNAL inst_aI4_aadd_104_a1COUT0 : std_logic;
SIGNAL inst_aI4_aadd_104_a1COUT1 : std_logic;
SIGNAL inst_aI4_aadd_104_a2COUT0 : std_logic;
SIGNAL inst_aI4_aadd_104_a2COUT1 : std_logic;
SIGNAL inst_aI4_aadd_104_a3COUT0 : std_logic;
SIGNAL inst_aI4_aadd_104_a3COUT1 : std_logic;
SIGNAL inst_aI4_aadd_104_a4 : std_logic;
SIGNAL inst_aI4_aadd_104_rtl_648_a68 : std_logic;
SIGNAL inst_aI4_aireg_i_a4_a : std_logic;
SIGNAL inst_aI4_aadd_104_rtl_648_a73 : std_logic;
SIGNAL inst_aI4_aireg_c_a4_a : std_logic;
SIGNAL inst_aI4_aadd_104_a4COUT : std_logic;
SIGNAL inst_aI4_aadd_104_a6COUT0 : std_logic;
SIGNAL inst_aI4_aadd_104_a6COUT1 : std_logic;
SIGNAL inst_aI4_aadd_104_a7 : std_logic;
SIGNAL inst_aI4_aadd_104_rtl_648_a88 : std_logic;
SIGNAL inst_aI4_aireg_i_a7_a : std_logic;
SIGNAL inst_aI4_aadd_104_rtl_648_a93 : std_logic;
SIGNAL inst_aI4_aireg_c_a7_a : std_logic;
SIGNAL inst_aI3_adata_x_a7_a_a92 : std_logic;
SIGNAL inst_aI3_adata_x_a7_a_a1679 : std_logic;
SIGNAL inst8_aDecoder_28_a23 : std_logic;
SIGNAL inst8_arx_uart_reg_a7_a_a1 : std_logic;
SIGNAL inst8_arx_uart_reg_a7_a : std_logic;
SIGNAL inst8_arx_uart_fifo_a7_a : std_logic;
SIGNAL inst7_aaltsyncram_component_aq_a_a7_a : std_logic;
SIGNAL inst_aI3_adata_x_a7_a_a87 : std_logic;
SIGNAL inst_aI3_adata_x_a7_a_a101 : std_logic;
SIGNAL inst3_aint_mask_c_a7_a : std_logic;
SIGNAL inst2_atmr_int_x : std_logic;
SIGNAL inst3_aint_masked_a7_a : std_logic;
SIGNAL inst3_aint_masked_c_a7_a : std_logic;
SIGNAL inst3_aint_clr_c_a7_a : std_logic;
SIGNAL inst3_aint_pending_c_a7_a : std_logic;
SIGNAL inst5_aMux_10_rtl_227_a0 : std_logic;
SIGNAL PORTA_IN_a7_a_acombout : std_logic;
SIGNAL PORTB_IN_a7_a_acombout : std_logic;
SIGNAL inst10_areg_data_out_x_a7_a_a41 : std_logic;
SIGNAL inst10_areg_data_out_x_a7_a_a42 : std_logic;
SIGNAL inst10_areg_data_out_x_a7_a_a45 : std_logic;
SIGNAL inst5_aMux_10_rtl_227_a1 : std_logic;
SIGNAL inst_aI3_adata_x_a7_a_a97 : std_logic;
SIGNAL rtl_a1516 : std_logic;
SIGNAL rtl_a3360 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a8_a_a69 : std_logic;
SIGNAL rtl_a3872 : std_logic;
SIGNAL rtl_a3880 : std_logic;
SIGNAL rtl_a14862 : std_logic;
SIGNAL rtl_a3878 : std_logic;
SIGNAL rtl_a15139 : std_logic;
SIGNAL inst8_aDecoder_28_a22 : std_logic;
SIGNAL inst8_arx_uart_reg_a6_a_a2 : std_logic;
SIGNAL inst8_arx_uart_reg_a6_a : std_logic;
SIGNAL inst8_arx_uart_fifo_a6_a : std_logic;
SIGNAL inst7_aaltsyncram_component_aq_a_a6_a : std_logic;
SIGNAL inst_aI3_adata_x_a6_a_a157 : std_logic;
SIGNAL inst_aI3_adata_x_a6_a_a171 : std_logic;
SIGNAL inst_aI3_adata_x_a6_a_a169 : std_logic;
SIGNAL inst_aI3_adata_x_a6_a_a162 : std_logic;
SIGNAL inst_aI3_adata_x_a6_a_a1712 : std_logic;
SIGNAL PORTA_IN_a6_a_acombout : std_logic;
SIGNAL inst10_areg_data_out_x_a6_a_a52 : std_logic;
SIGNAL PORTB_IN_a6_a_acombout : std_logic;
SIGNAL inst10_areg_data_out_x_a6_a_a51 : std_logic;
SIGNAL inst10_areg_data_out_x_a6_a_a55 : std_logic;
SIGNAL inst5_aMux_11_rtl_230_a0 : std_logic;
SIGNAL inst5_aMux_11_rtl_230_a1 : std_logic;
SIGNAL inst_aI3_adata_x_a6_a_a167 : std_logic;
SIGNAL inst_aI3_aadd_129_a5COUT0 : std_logic;
SIGNAL inst_aI3_aadd_129_a5COUT1 : std_logic;
SIGNAL inst_aI3_aadd_129_a6COUT0 : std_logic;
SIGNAL inst_aI3_aadd_129_a6COUT1 : std_logic;
SIGNAL inst_aI3_aadd_129_a7COUT0 : std_logic;
SIGNAL inst_aI3_aadd_129_a7COUT1 : std_logic;
SIGNAL inst_aI3_aadd_129_a8 : std_logic;
SIGNAL inst_aI3_aadd_153_a6COUT0 : std_logic;
SIGNAL inst_aI3_aadd_153_a6COUT1 : std_logic;
SIGNAL inst_aI3_aadd_153_a7COUT0 : std_logic;
SIGNAL inst_aI3_aadd_153_a7COUT1 : std_logic;
SIGNAL inst_aI3_aadd_153_a8COUT0 : std_logic;
SIGNAL inst_aI3_aadd_153_a8COUT1 : std_logic;
SIGNAL inst_aI3_aadd_153_a9 : std_logic;
SIGNAL rtl_a3879 : std_logic;
SIGNAL rtl_a3476 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a8_a_a68 : std_logic;
SIGNAL rtl_a601 : std_logic;
SIGNAL inst_aI3_aacc_c_a0_a_a8_a : std_logic;
SIGNAL rtl_a3245 : std_logic;
SIGNAL rtl_a2364 : std_logic;
SIGNAL rtl_a2268 : std_logic;
SIGNAL inst_aI3_aadd_129_a7 : std_logic;
SIGNAL inst_aI3_aadd_153_a8 : std_logic;
SIGNAL inst_aI3_aMux_171_rtl_43_rtl_510_a0 : std_logic;
SIGNAL inst_aI3_aMux_171_rtl_43_rtl_510_a1 : std_logic;
SIGNAL rtl_a15072 : std_logic;
SIGNAL rtl_a2363 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a7_a_a58 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a7_a_a4253 : std_logic;
SIGNAL inst_aI3_aacc_c_a0_a_a7_a : std_logic;
SIGNAL inst_aI4_adata_ox_a7_a_a0 : std_logic;
SIGNAL inst1_ai_a138 : std_logic;
SIGNAL inst1_atx_clk_div_a7_a : std_logic;
SIGNAL inst1_atx_clk_div_a4_a : std_logic;
SIGNAL inst1_atx_clk_div_a3_a : std_logic;
SIGNAL inst1_atx_clk_div_a2_a : std_logic;
SIGNAL inst1_atx_clk_div_a0_a : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a_aCOUT0 : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a_aCOUT1 : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a_aCOUT0 : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a_aCOUT1 : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a_aCOUT0 : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a_aCOUT1 : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a_aCOUT0 : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a_aCOUT1 : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a4_a : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a4_a_aCOUT : std_logic;
SIGNAL inst1_atx_clk_div_a5_a : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a_aCOUT0 : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a_aCOUT1 : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a_aCOUT0 : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a_aCOUT1 : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a7_a : std_logic;
SIGNAL inst8_areduce_nor_7_a23 : std_logic;
SIGNAL inst8_arx_uart_fifo_a7_a_a37 : std_logic;
SIGNAL inst8_arx_uart_fifo_a1_a : std_logic;
SIGNAL inst7_aaltsyncram_component_aq_a_a1_a : std_logic;
SIGNAL inst_aI3_adata_x_a1_a_a507 : std_logic;
SIGNAL inst_aI3_adata_x_a1_a_a521 : std_logic;
SIGNAL inst_aI3_adata_x_a1_a_a512 : std_logic;
SIGNAL inst_aI3_adata_x_a1_a_a519 : std_logic;
SIGNAL inst_aI3_adata_x_a1_a_a1877 : std_logic;
SIGNAL inst3_aint_mask_c_a1_a : std_logic;
SIGNAL IN_INT_a1_a_acombout : std_logic;
SIGNAL inst3_aint_masked_a1_a : std_logic;
SIGNAL inst3_aint_masked_c_a1_a : std_logic;
SIGNAL inst3_aint_clr_c_a1_a : std_logic;
SIGNAL inst3_aint_pending_c_a1_a : std_logic;
SIGNAL inst5_aMux_16_rtl_245_a0 : std_logic;
SIGNAL PORTA_IN_a1_a_acombout : std_logic;
SIGNAL inst10_areg_data_out_x_a1_a_a102 : std_logic;
SIGNAL PORTB_IN_a1_a_acombout : std_logic;
SIGNAL inst10_areg_data_out_x_a1_a_a101 : std_logic;
SIGNAL inst10_areg_data_out_x_a1_a_a105 : std_logic;
SIGNAL inst5_aMux_16_rtl_245_a1 : std_logic;
SIGNAL inst_aI3_adata_x_a1_a_a517 : std_logic;
SIGNAL rtl_a1911 : std_logic;
SIGNAL rtl_a1910 : std_logic;
SIGNAL rtl_a2304 : std_logic;
SIGNAL rtl_a3330 : std_logic;
SIGNAL rtl_a3438 : std_logic;
SIGNAL rtl_a2469 : std_logic;
SIGNAL inst_aI3_aadd_129_a1 : std_logic;
SIGNAL inst_aI3_aadd_153_a2 : std_logic;
SIGNAL inst_aI3_aMux_177_rtl_79_rtl_546_a0 : std_logic;
SIGNAL inst_aI3_aMux_177_rtl_79_rtl_546_a1 : std_logic;
SIGNAL rtl_a15406 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a1_a_a48 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a1_a_a128 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a1_a_a49 : std_logic;
SIGNAL inst_aI3_aacc_c_a0_a_a1_a : std_logic;
SIGNAL inst_aI4_adata_ox_a1_a_a6 : std_logic;
SIGNAL inst1_atx_clk_div_a1_a : std_logic;
SIGNAL inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a : std_logic;
SIGNAL inst8_areduce_nor_7_a28 : std_logic;
SIGNAL inst8_areduce_nor_7_a35 : std_logic;
SIGNAL inst8_areduce_nor_7 : std_logic;
SIGNAL inst8_arx_8_count_a0_a : std_logic;
SIGNAL inst8_arx_8_count_a1_a : std_logic;
SIGNAL inst8_areduce_nor_68 : std_logic;
SIGNAL inst8_arx_s_a1_a : std_logic;
SIGNAL inst8_arx_16_count_a0_a : std_logic;
SIGNAL inst8_aadd_45_a5 : std_logic;
SIGNAL inst8_arx_16_count_a1_a : std_logic;
SIGNAL inst8_areduce_nor_27_a4 : std_logic;
SIGNAL inst8_arx_16_count_a3_a : std_logic;
SIGNAL rtl_a14863 : std_logic;
SIGNAL rtl_a15506 : std_logic;
SIGNAL inst8_arx_8z_count_a0_a : std_logic;
SIGNAL rtl_a1038 : std_logic;
SIGNAL inst8_aadd_13_a5 : std_logic;
SIGNAL rtl_a14845 : std_logic;
SIGNAL inst8_arx_8z_count_a1_a : std_logic;
SIGNAL inst8_aadd_13_a10 : std_logic;
SIGNAL rtl_a1035 : std_logic;
SIGNAL inst8_arx_8z_count_a2_a : std_logic;
SIGNAL rtl_a14867 : std_logic;
SIGNAL inst8_aMux_103_a0 : std_logic;
SIGNAL inst8_arx_8z_count_a3_a : std_logic;
SIGNAL rtl_a3354 : std_logic;
SIGNAL inst8_arx_s_a0_a : std_logic;
SIGNAL rtl_a14851 : std_logic;
SIGNAL rtl_a1012 : std_logic;
SIGNAL inst8_aadd_45_a10 : std_logic;
SIGNAL inst8_arx_16_count_a2_a : std_logic;
SIGNAL inst8_areduce_nor_27 : std_logic;
SIGNAL inst8_aDecoder_28_a18 : std_logic;
SIGNAL inst8_arx_uart_reg_a2_a_a6 : std_logic;
SIGNAL inst8_arx_uart_reg_a2_a : std_logic;
SIGNAL inst8_arx_uart_fifo_a2_a : std_logic;
SIGNAL inst7_aaltsyncram_component_aq_a_a2_a : std_logic;
SIGNAL inst_aI3_adata_x_a2_a_a437 : std_logic;
SIGNAL inst_aI3_adata_x_a2_a_a451 : std_logic;
SIGNAL inst3_aint_clr_c_a2_a : std_logic;
SIGNAL inst3_aint_mask_c_a2_a : std_logic;
SIGNAL IN_INT_a2_a_acombout : std_logic;
SIGNAL inst3_aint_masked_a2_a : std_logic;
SIGNAL inst3_aint_masked_c_a2_a : std_logic;
SIGNAL inst3_aint_pending_c_a2_a : std_logic;
SIGNAL PORTA_IN_a2_a_acombout : std_logic;
SIGNAL PORTB_IN_a2_a_acombout : std_logic;
SIGNAL inst10_areg_data_out_x_a2_a_a91 : std_logic;
SIGNAL inst10_areg_data_out_x_a2_a_a92 : std_logic;
SIGNAL inst10_areg_data_out_x_a2_a_a95 : std_logic;
SIGNAL inst5_aMux_15_rtl_242_a0 : std_logic;
SIGNAL inst5_aMux_15_rtl_242_a1 : std_logic;
SIGNAL inst_aI3_adata_x_a2_a_a447 : std_logic;
SIGNAL rtl_a1870 : std_logic;
SIGNAL rtl_a1869 : std_logic;
SIGNAL rtl_a2298 : std_logic;
SIGNAL rtl_a3319 : std_logic;
SIGNAL rtl_a3428 : std_logic;
SIGNAL rtl_a2454 : std_logic;
SIGNAL inst_aI3_aadd_153_a3 : std_logic;
SIGNAL inst_aI3_aadd_129_a2 : std_logic;
SIGNAL inst_aI3_aMux_176_rtl_73_rtl_540_a0 : std_logic;
SIGNAL inst_aI3_aMux_176_rtl_73_rtl_540_a1 : std_logic;
SIGNAL rtl_a15363 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a2_a_a45 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a2_a_a118 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a2_a_a46 : std_logic;
SIGNAL inst_aI3_aacc_c_a0_a_a2_a : std_logic;
SIGNAL inst_aI4_aadd_104_a2 : std_logic;
SIGNAL inst_aI4_aadd_104_rtl_648_a58 : std_logic;
SIGNAL inst_aI4_aireg_i_a2_a : std_logic;
SIGNAL inst_aI4_aadd_104_rtl_648_a63 : std_logic;
SIGNAL inst_aI4_aireg_c_a2_a : std_logic;
SIGNAL inst_aI5_adaddr_c_a2_a : std_logic;
SIGNAL inst_aI4_adaddr_x_a2_a_a30 : std_logic;
SIGNAL inst_aI5_ai_a15 : std_logic;
SIGNAL inst5_areduce_nor_19_a54 : std_logic;
SIGNAL inst3_ai_a121 : std_logic;
SIGNAL inst3_aint_clr_c_a6_a : std_logic;
SIGNAL inst3_aint_mask_c_a6_a : std_logic;
SIGNAL inst3_aint_masked_a6_a : std_logic;
SIGNAL inst3_aint_masked_c_a6_a : std_logic;
SIGNAL inst3_aint_pending_c_a6_a : std_logic;
SIGNAL inst3_areduce_nor_128_a23 : std_logic;
SIGNAL inst_aI2_aE_x_aint_e_a0 : std_logic;
SIGNAL inst_aI4_aadd_104_a3 : std_logic;
SIGNAL inst_aI4_aadd_104_rtl_648_a78 : std_logic;
SIGNAL inst_aI4_aireg_i_a3_a : std_logic;
SIGNAL inst_aI4_aadd_104_rtl_648_a83 : std_logic;
SIGNAL inst_aI4_aireg_c_a3_a : std_logic;
SIGNAL inst_aI5_adaddr_c_a3_a : std_logic;
SIGNAL inst_aI4_adaddr_x_a3_a_a33 : std_logic;
SIGNAL inst_aI4_adaddr_x_a3_a_a34 : std_logic;
SIGNAL inst_aI5_ai_a21 : std_logic;
SIGNAL inst5_amux_c_a2_a : std_logic;
SIGNAL inst_aI3_areduce_nor_71 : std_logic;
SIGNAL inst_aI3_adata_x_a7_a_a1618 : std_logic;
SIGNAL inst8_aDecoder_28_a16 : std_logic;
SIGNAL inst8_arx_uart_reg_a0_a_a8 : std_logic;
SIGNAL inst8_arx_uart_reg_a0_a : std_logic;
SIGNAL inst8_arx_uart_fifo_a0_a : std_logic;
SIGNAL inst7_aaltsyncram_component_aq_a_a0_a : std_logic;
SIGNAL inst_aI3_adata_x_a0_a_a577 : std_logic;
SIGNAL inst_aI3_adata_x_a0_a_a591 : std_logic;
SIGNAL inst_aI3_adata_x_a0_a_a589 : std_logic;
SIGNAL inst_aI3_adata_x_a0_a_a582 : std_logic;
SIGNAL inst_aI3_adata_x_a0_a_a1910 : std_logic;
SIGNAL PORTA_IN_a0_a_acombout : std_logic;
SIGNAL inst10_areg_data_out_x_a0_a_a112 : std_logic;
SIGNAL PORTB_IN_a0_a_acombout : std_logic;
SIGNAL inst10_areg_data_out_x_a0_a_a111 : std_logic;
SIGNAL inst10_areg_data_out_x_a0_a_a115 : std_logic;
SIGNAL inst5_aMux_17_rtl_248_a0 : std_logic;
SIGNAL inst5_aMux_17_rtl_248_a1 : std_logic;
SIGNAL inst_aI3_adata_x_a0_a_a587 : std_logic;
SIGNAL rtl_a2477 : std_logic;
SIGNAL rtl_a2479 : std_logic;
SIGNAL inst_aI3_aadd_129_a0 : std_logic;
SIGNAL rtl_a15451 : std_logic;
SIGNAL rtl_a2483 : std_logic;
SIGNAL rtl_a1956 : std_logic;
SIGNAL rtl_a3454 : std_logic;
SIGNAL rtl_a3342 : std_logic;
SIGNAL rtl_a3459 : std_logic;
SIGNAL rtl_a3458 : std_logic;
SIGNAL rtl_a3464 : std_logic;
SIGNAL inst_aI3_aadd_153_a1 : std_logic;
SIGNAL inst_aI3_aMux_178_rtl_85_rtl_552_a0 : std_logic;
SIGNAL inst_aI3_aMux_178_rtl_85_rtl_552_a1 : std_logic;
SIGNAL rtl_a15483 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a0_a_a138 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a0_a_a4288 : std_logic;
SIGNAL inst_aI3_aacc_c_a0_a_a0_a : std_logic;
SIGNAL inst_aI4_adata_ox_a0_a_a7 : std_logic;
SIGNAL inst3_aint_mask_c_a0_a : std_logic;
SIGNAL IN_INT_a0_a_acombout : std_logic;
SIGNAL inst3_aint_masked_a0_a : std_logic;
SIGNAL inst3_aint_clr_c_a0_a : std_logic;
SIGNAL inst3_aint_masked_c_a0_a : std_logic;
SIGNAL inst3_aint_pending_c_a0_a : std_logic;
SIGNAL inst3_areduce_nor_128_a28 : std_logic;
SIGNAL inst_aI2_aint_start_c : std_logic;
SIGNAL rtl_a14960 : std_logic;
SIGNAL rtl_a14987 : std_logic;
SIGNAL rtl_a15003 : std_logic;
SIGNAL inst_aI3_areduce_nor_91_a35 : std_logic;
SIGNAL inst_aI3_areduce_nor_91_a28 : std_logic;
SIGNAL inst_aI3_areduce_nor_91 : std_logic;
SIGNAL rtl_a14972 : std_logic;
SIGNAL rtl_a2261 : std_logic;
SIGNAL rtl_a15027 : std_logic;
SIGNAL rtl_a1444 : std_logic;
SIGNAL rtl_a14994 : std_logic;
SIGNAL rtl_a15020 : std_logic;
SIGNAL inst_aI3_ai_a213 : std_logic;
SIGNAL inst_aI2_apc_mux_x_a1_a_a170 : std_logic;
SIGNAL inst_aI2_apc_mux_x_a1_a_a204 : std_logic;
SIGNAL inst_aI2_apc_mux_x_a1_a_a169 : std_logic;
SIGNAL inst_aI2_apc_mux_x_a1_a_a199 : std_logic;
SIGNAL inst_aI2_aS_c_a10 : std_logic;
SIGNAL inst_aI2_ai_a364 : std_logic;
SIGNAL inst_aI2_apc_mux_x_a1_a_a30 : std_logic;
SIGNAL inst_aI2_apc_mux_x_a1_a_a42 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a2_a_a102 : std_logic;
SIGNAL inst_aI1_aadd_185_a2 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a2_a_a223 : std_logic;
SIGNAL rtl_a2509 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a7_a_a2_a : std_logic;
SIGNAL rtl_a3165 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a6_a_a2_a : std_logic;
SIGNAL rtl_a3065 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a5_a_a2_a : std_logic;
SIGNAL rtl_a2965 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a4_a_a2_a : std_logic;
SIGNAL rtl_a2865 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a2_a : std_logic;
SIGNAL rtl_a2765 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a2_a : std_logic;
SIGNAL rtl_a2625 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a2_a : std_logic;
SIGNAL rtl_a445 : std_logic;
SIGNAL inst_aI1_aMux_275_rtl_204_a0 : std_logic;
SIGNAL inst_aI1_aMux_275_rtl_204_a1 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a2_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a2_a_a228 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a2_a_a227 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a2_a_a233 : std_logic;
SIGNAL inst6_aaltsyncram_component_aq_a_a0_a : std_logic;
SIGNAL inst_aI2_aTC_x_a1_a_a22 : std_logic;
SIGNAL inst_aI2_areduce_nor_126 : std_logic;
SIGNAL inst_aI2_ai_a43 : std_logic;
SIGNAL inst_aI2_ai_a379 : std_logic;
SIGNAL inst_aI2_ai_a328 : std_logic;
SIGNAL inst_aI2_apc_mux_x_a0_a_a8 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a1_a_a206 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a1_a_a90 : std_logic;
SIGNAL rtl_a2499 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a7_a_a1_a : std_logic;
SIGNAL rtl_a3155 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a6_a_a1_a : std_logic;
SIGNAL rtl_a3055 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a5_a_a1_a : std_logic;
SIGNAL rtl_a2955 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a4_a_a1_a : std_logic;
SIGNAL rtl_a2855 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a1_a : std_logic;
SIGNAL rtl_a2755 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a1_a : std_logic;
SIGNAL rtl_a2615 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a1_a : std_logic;
SIGNAL rtl_a444 : std_logic;
SIGNAL inst_aI1_aMux_276_rtl_201_a0 : std_logic;
SIGNAL inst_aI1_aMux_276_rtl_201_a1 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a1_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a1_a_a211 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a1_a_a210 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a1_a_a216 : std_logic;
SIGNAL inst6_aaltsyncram_component_aq_a_a2_a : std_logic;
SIGNAL inst_aI2_aTC_x_a1_a_a42 : std_logic;
SIGNAL inst_aI2_aTC_x_a0_a_a233 : std_logic;
SIGNAL inst_aI2_aTC_x_a0_a_a114 : std_logic;
SIGNAL inst_aI2_aTC_x_a0_a_a119 : std_logic;
SIGNAL inst_aI2_aTC_c_a0_a : std_logic;
SIGNAL inst_aI2_aTC_c_a1_a : std_logic;
SIGNAL inst_aI2_ai_a342 : std_logic;
SIGNAL inst_aI2_andre_x_a63 : std_logic;
SIGNAL inst_aI2_andre_x_a44 : std_logic;
SIGNAL inst_aI3_ai_a220 : std_logic;
SIGNAL inst_aI3_ai_a85 : std_logic;
SIGNAL inst_aI2_aint_stop_x_a10 : std_logic;
SIGNAL inst_aI2_aint_stop_c : std_logic;
SIGNAL inst_aI2_ai_a13 : std_logic;
SIGNAL inst_aI2_apc_mux_x_a2_a_a187 : std_logic;
SIGNAL inst_aI2_apc_mux_x_a2_a_a27 : std_logic;
SIGNAL inst_aI1_aadd_185_a0 : std_logic;
SIGNAL rtl_a2489 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a7_a_a0_a : std_logic;
SIGNAL rtl_a3145 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a6_a_a0_a : std_logic;
SIGNAL rtl_a3045 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a5_a_a0_a : std_logic;
SIGNAL rtl_a2945 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a4_a_a0_a : std_logic;
SIGNAL rtl_a2845 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a3_a_a0_a : std_logic;
SIGNAL rtl_a2745 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a2_a_a0_a : std_logic;
SIGNAL rtl_a2605 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a1_a_a0_a : std_logic;
SIGNAL inst_aI1_aMux_277_rtl_198_a0 : std_logic;
SIGNAL rtl_a443 : std_logic;
SIGNAL inst_aI1_aMux_277_rtl_198_a1 : std_logic;
SIGNAL inst_aI1_astack_addrs_c_a0_a_a0_a : std_logic;
SIGNAL inst_aI1_aiaddr_x_a0_a_a194 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a0_a_a189 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a0_a_a78 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a0_a_a193 : std_logic;
SIGNAL inst_aI1_aiaddr_x_a0_a_a199 : std_logic;
SIGNAL inst6_aaltsyncram_component_aq_a_a6_a : std_logic;
SIGNAL inst_aI2_aTD_c_a3_a : std_logic;
SIGNAL inst_aI2_aTC_c_a2_a : std_logic;
SIGNAL rtl_a1706 : std_logic;
SIGNAL rtl_a2274 : std_logic;
SIGNAL rtl_a3388 : std_logic;
SIGNAL rtl_a3275 : std_logic;
SIGNAL rtl_a2394 : std_logic;
SIGNAL inst_aI3_aadd_153_a7 : std_logic;
SIGNAL inst_aI3_aadd_129_a6 : std_logic;
SIGNAL inst_aI3_aMux_172_rtl_49_rtl_516_a0 : std_logic;
SIGNAL inst_aI3_aMux_172_rtl_49_rtl_516_a1 : std_logic;
SIGNAL rtl_a15191 : std_logic;
SIGNAL rtl_a2393 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a6_a_a78 : std_logic;
SIGNAL inst_aI3_aacc_a0_a_a6_a_a4258 : std_logic;
SIGNAL inst_aI3_aacc_c_a0_a_a6_a : std_logic;
SIGNAL inst_aI4_adata_ox_a6_a_a1 : std_logic;
SIGNAL inst1_atx_clk_div_a6_a : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a_aCOUT0 : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a_aCOUT1 : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a_aCOUT0 : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a_aCOUT1 : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a_aCOUT0 : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a_aCOUT1 : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a : std_logic;
SIGNAL inst1_areduce_nor_7_a32 : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a_aCOUT0 : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a_aCOUT1 : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a4_a : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a4_a_aCOUT : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a_aCOUT0 : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a_aCOUT1 : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a_aCOUT0 : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a_aCOUT1 : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a7_a : std_logic;
SIGNAL inst1_areduce_nor_7_a39 : std_logic;
SIGNAL inst1_areduce_nor_7 : std_logic;
SIGNAL inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a : std_logic;
SIGNAL inst1_areduce_nor_7_a27 : std_logic;
SIGNAL inst1_ai_a182 : std_logic;
SIGNAL inst1_atx_uart_busy : std_logic;
SIGNAL inst1_ai_a114 : std_logic;
SIGNAL inst1_atx_16_count_a3_a_a3 : std_logic;
SIGNAL inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a : std_logic;
SIGNAL inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a_aCOUT0 : std_logic;
SIGNAL inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a_aCOUT1 : std_logic;
SIGNAL inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a : std_logic;
SIGNAL inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a_aCOUT0 : std_logic;
SIGNAL inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a_aCOUT1 : std_logic;
SIGNAL inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a : std_logic;
SIGNAL inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a_aCOUT0 : std_logic;
SIGNAL inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a_aCOUT1 : std_logic;
SIGNAL inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a3_a : std_logic;
SIGNAL inst1_areduce_nor_34_a11 : std_logic;
SIGNAL inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a_aCOUT0 : std_logic;
SIGNAL inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a_aCOUT1 : std_logic;
SIGNAL inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a3_a : std_logic;
SIGNAL inst1_atx_s_a23 : std_logic;
SIGNAL inst1_atx_s_a27 : std_logic;
SIGNAL inst1_atx_s : std_logic;
SIGNAL inst1_atx_bit_count_a3_a_a15 : std_logic;
SIGNAL inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a : std_logic;
SIGNAL inst1_ai_a175 : std_logic;
SIGNAL inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a : std_logic;
SIGNAL inst1_ai_a45 : std_logic;
SIGNAL inst1_atx_uart_fifo_a2_a : std_logic;
SIGNAL inst1_atx_uart_shift_a8_a_a2 : std_logic;
SIGNAL inst1_atx_uart_shift_a3_a : std_logic;
SIGNAL inst1_atx_uart_fifo_a0_a : std_logic;
SIGNAL inst1_atx_uart_fifo_a1_a : std_logic;
SIGNAL inst1_atx_uart_shift_a0_a : std_logic;
SIGNAL inst1_aMux_29_rtl_21_a0 : std_logic;
SIGNAL inst1_aMux_29_rtl_21_a1 : std_logic;
SIGNAL inst1_atx_uart_fifo_a5_a : std_logic;
SIGNAL inst1_atx_uart_fifo_a3_a : std_logic;
SIGNAL inst1_atx_uart_shift_a4_a : std_logic;
SIGNAL inst1_aMux_29_rtl_22_a0 : std_logic;
SIGNAL inst1_atx_uart_fifo_a4_a : std_logic;
SIGNAL inst1_atx_uart_fifo_a6_a : std_logic;
SIGNAL inst1_atx_uart_shift_a7_a : std_logic;
SIGNAL inst1_aMux_29_rtl_22_a1 : std_logic;
SIGNAL inst1_ai_a191 : std_logic;
SIGNAL inst1_atx_uart_fifo_a7_a : std_logic;
SIGNAL inst1_ai_a472 : std_logic;
SIGNAL inst1_atx_uart_areg0 : std_logic;
SIGNAL inst10_ai_a74 : std_logic;
SIGNAL inst10_aout_1reg_a7_a_areg0 : std_logic;
SIGNAL inst10_aout_1reg_a6_a_areg0 : std_logic;
SIGNAL inst10_aout_1reg_a5_a_areg0 : std_logic;
SIGNAL inst10_aout_1reg_a4_a_areg0 : std_logic;
SIGNAL inst10_aout_1reg_a3_a_areg0 : std_logic;
SIGNAL inst10_aout_1reg_a2_a_areg0 : std_logic;
SIGNAL inst10_aout_1reg_a1_a_areg0 : std_logic;
SIGNAL inst10_aout_1reg_a0_a_areg0 : std_logic;
SIGNAL inst10_aout_0reg_a7_a_areg0 : std_logic;
SIGNAL inst10_aout_0reg_a6_a_areg0 : std_logic;
SIGNAL inst10_aout_0reg_a5_a_areg0 : std_logic;
SIGNAL inst10_aout_0reg_a4_a_areg0 : std_logic;
SIGNAL inst10_aout_0reg_a3_a_areg0 : std_logic;
SIGNAL inst10_aout_0reg_a2_a_areg0 : std_logic;
SIGNAL inst10_aout_0reg_a1_a_areg0 : std_logic;
SIGNAL inst10_aout_0reg_a0_a_areg0 : std_logic;
SIGNAL NOT_inst1_atx_uart_areg0 : std_logic;
SIGNAL NOT_inst2_atmr_reset : std_logic;
SIGNAL NOT_inst2_atmr_enable : std_logic;
SIGNAL NOT_nRESET_acombout : std_logic;

BEGIN

ww_UCLK <= UCLK;
ww_nRESET <= nRESET;
ww_PORTA_IN <= PORTA_IN;
ww_PORTB_IN <= PORTB_IN;
ww_RXD <= RXD;
ww_IN_INT <= IN_INT;
TXD <= ww_TXD;
PORTA_OUT <= ww_PORTA_OUT;
PORTB_OUT <= ww_PORTB_OUT;

ww_inst6_aaltsyncram_component_aram_block_a0_a_a4_a_aaddress <= (gnd & gnd & gnd & gnd & gnd & gnd & inst_aI1_aiaddr_x_a9_a_a182 & inst_aI1_aiaddr_x_a8_a_a172 & inst_aI1_aiaddr_x_a7_a_a162 & inst_aI1_aiaddr_x_a6_a_a152 & inst_aI1_aiaddr_x_a5_a_a142 & 
inst_aI1_aiaddr_x_a4_a_a132 & inst_aI1_aiaddr_x_a3_a_a122 & inst_aI1_aiaddr_x_a2_a_a233 & inst_aI1_aiaddr_x_a1_a_a216 & inst_aI1_aiaddr_x_a0_a_a199);

inst6_aaltsyncram_component_aq_a_a4_a <= ww_inst6_aaltsyncram_component_aram_block_a0_a_a4_a_adataout(0);
inst6_aaltsyncram_component_aq_a_a7_a <= ww_inst6_aaltsyncram_component_aram_block_a0_a_a4_a_adataout(1);
inst6_aaltsyncram_component_aq_a_a6_a <= ww_inst6_aaltsyncram_component_aram_block_a0_a_a4_a_adataout(2);
inst6_aaltsyncram_component_aq_a_a5_a <= ww_inst6_aaltsyncram_component_aram_block_a0_a_a4_a_adataout(3);

ww_inst6_aaltsyncram_component_aram_block_a0_a_a0_a_aaddress <= (gnd & gnd & gnd & gnd & gnd & gnd & inst_aI1_aiaddr_x_a9_a_a182 & inst_aI1_aiaddr_x_a8_a_a172 & inst_aI1_aiaddr_x_a7_a_a162 & inst_aI1_aiaddr_x_a6_a_a152 & inst_aI1_aiaddr_x_a5_a_a142 & 
inst_aI1_aiaddr_x_a4_a_a132 & inst_aI1_aiaddr_x_a3_a_a122 & inst_aI1_aiaddr_x_a2_a_a233 & inst_aI1_aiaddr_x_a1_a_a216 & inst_aI1_aiaddr_x_a0_a_a199);

inst6_aaltsyncram_component_aq_a_a0_a <= ww_inst6_aaltsyncram_component_aram_block_a0_a_a0_a_adataout(0);
inst6_aaltsyncram_component_aq_a_a2_a <= ww_inst6_aaltsyncram_component_aram_block_a0_a_a0_a_adataout(1);

ww_inst6_aaltsyncram_component_aram_block_a0_a_a1_a_aaddress <= (gnd & gnd & gnd & gnd & gnd & gnd & inst_aI1_aiaddr_x_a9_a_a182 & inst_aI1_aiaddr_x_a8_a_a172 & inst_aI1_aiaddr_x_a7_a_a162 & inst_aI1_aiaddr_x_a6_a_a152 & inst_aI1_aiaddr_x_a5_a_a142 & 
inst_aI1_aiaddr_x_a4_a_a132 & inst_aI1_aiaddr_x_a3_a_a122 & inst_aI1_aiaddr_x_a2_a_a233 & inst_aI1_aiaddr_x_a1_a_a216 & inst_aI1_aiaddr_x_a0_a_a199);

inst6_aaltsyncram_component_aq_a_a1_a <= ww_inst6_aaltsyncram_component_aram_block_a0_a_a1_a_adataout(0);
inst6_aaltsyncram_component_aq_a_a3_a <= ww_inst6_aaltsyncram_component_aram_block_a0_a_a1_a_adataout(1);
inst6_aaltsyncram_component_aq_a_a12_a <= ww_inst6_aaltsyncram_component_aram_block_a0_a_a1_a_adataout(2);
inst6_aaltsyncram_component_aq_a_a10_a <= ww_inst6_aaltsyncram_component_aram_block_a0_a_a1_a_adataout(3);

ww_inst6_aaltsyncram_component_aram_block_a0_a_a13_a_aaddress <= (gnd & gnd & gnd & gnd & gnd & gnd & inst_aI1_aiaddr_x_a9_a_a182 & inst_aI1_aiaddr_x_a8_a_a172 & inst_aI1_aiaddr_x_a7_a_a162 & inst_aI1_aiaddr_x_a6_a_a152 & inst_aI1_aiaddr_x_a5_a_a142 & 
inst_aI1_aiaddr_x_a4_a_a132 & inst_aI1_aiaddr_x_a3_a_a122 & inst_aI1_aiaddr_x_a2_a_a233 & inst_aI1_aiaddr_x_a1_a_a216 & inst_aI1_aiaddr_x_a0_a_a199);

inst6_aaltsyncram_component_aq_a_a13_a <= ww_inst6_aaltsyncram_component_aram_block_a0_a_a13_a_adataout(0);
inst6_aaltsyncram_component_aq_a_a11_a <= ww_inst6_aaltsyncram_component_aram_block_a0_a_a13_a_adataout(1);
inst6_aaltsyncram_component_aq_a_a9_a <= ww_inst6_aaltsyncram_component_aram_block_a0_a_a13_a_adataout(2);
inst6_aaltsyncram_component_aq_a_a8_a <= ww_inst6_aaltsyncram_component_aram_block_a0_a_a13_a_adataout(3);

ww_inst7_aaltsyncram_component_aram_block_a0_a_a7_a_aaddress <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & inst_aI5_ai_a36 & inst_aI5_ai_a33 & inst_aI5_ai_a30 & inst_aI5_ai_a18 & inst_aI5_ai_a21 & inst_aI5_ai_a15 & inst_aI5_ai_a27 & inst_aI5_ai_a12
);

ww_inst7_aaltsyncram_component_aram_block_a0_a_a7_a_adatain <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & inst_aI4_adata_ox_a5_a_a2 & inst_aI4_adata_ox_a4_a_a3 & inst_aI4_adata_ox_a3_a_a4 & inst_aI4_adata_ox_a2_a_a5 & 
inst_aI4_adata_ox_a1_a_a6 & inst_aI4_adata_ox_a0_a_a7 & inst_aI4_adata_ox_a6_a_a1 & inst_aI4_adata_ox_a7_a_a0);

inst7_aaltsyncram_component_aq_a_a7_a <= ww_inst7_aaltsyncram_component_aram_block_a0_a_a7_a_adataout(0);
inst7_aaltsyncram_component_aq_a_a6_a <= ww_inst7_aaltsyncram_component_aram_block_a0_a_a7_a_adataout(1);
inst7_aaltsyncram_component_aq_a_a0_a <= ww_inst7_aaltsyncram_component_aram_block_a0_a_a7_a_adataout(2);
inst7_aaltsyncram_component_aq_a_a1_a <= ww_inst7_aaltsyncram_component_aram_block_a0_a_a7_a_adataout(3);
inst7_aaltsyncram_component_aq_a_a2_a <= ww_inst7_aaltsyncram_component_aram_block_a0_a_a7_a_adataout(4);
inst7_aaltsyncram_component_aq_a_a3_a <= ww_inst7_aaltsyncram_component_aram_block_a0_a_a7_a_adataout(5);
inst7_aaltsyncram_component_aq_a_a4_a <= ww_inst7_aaltsyncram_component_aram_block_a0_a_a7_a_adataout(6);
inst7_aaltsyncram_component_aq_a_a5_a <= ww_inst7_aaltsyncram_component_aram_block_a0_a_a7_a_adataout(7);
NOT_inst1_atx_uart_areg0 <= NOT inst1_atx_uart_areg0;
NOT_inst2_atmr_reset <= NOT inst2_atmr_reset;
NOT_inst2_atmr_enable <= NOT inst2_atmr_enable;
NOT_nRESET_acombout <= NOT nRESET_acombout;

UCLK_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_UCLK,
	combout => UCLK_acombout);

nRESET_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_nRESET,
	combout => nRESET_acombout);

inst1_atx_bit_count_rtl_7_awysi_counter_acounter_cell_a0_a : cyclone_lcell 
-- Equation(s):
-- inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a = DFFEA(!inst1_ai_a175 & !inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_atx_bit_count_a3_a_a15, , )
-- inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a_aCOUT0 = CARRY(inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a)
-- inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a_aCOUT1 = CARRY(inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "55AA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a,
	aclr => NOT_nRESET_acombout,
	sclr => inst1_ai_a175,
	ena => inst1_atx_bit_count_a3_a_a15,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a,
	cout0 => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a_aCOUT0,
	cout1 => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a_aCOUT1);

inst1_atx_bit_count_rtl_7_awysi_counter_acounter_cell_a1_a : cyclone_lcell 
-- Equation(s):
-- inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a = DFFEA(!inst1_ai_a175 & inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a $ inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a_aCOUT0, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_atx_bit_count_a3_a_a15, , )
-- inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a_aCOUT0 = CARRY(!inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a_aCOUT0 # !inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a)
-- inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a_aCOUT1 = CARRY(!inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a_aCOUT1 # !inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "5A5F",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a,
	aclr => NOT_nRESET_acombout,
	sclr => inst1_ai_a175,
	ena => inst1_atx_bit_count_a3_a_a15,
	cin0 => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a_aCOUT0,
	cin1 => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a,
	cout0 => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a_aCOUT0,
	cout1 => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a_aCOUT1);

inst1_atx_bit_count_rtl_7_awysi_counter_acounter_cell_a2_a : cyclone_lcell 
-- Equation(s):
-- inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a = DFFEA(!inst1_ai_a175 & inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a $ !inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a_aCOUT0, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_atx_bit_count_a3_a_a15, , )
-- inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a_aCOUT0 = CARRY(inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a & !inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a_aCOUT0)
-- inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a_aCOUT1 = CARRY(inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a & !inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a_aCOUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "C30C",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a,
	aclr => NOT_nRESET_acombout,
	sclr => inst1_ai_a175,
	ena => inst1_atx_bit_count_a3_a_a15,
	cin0 => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a_aCOUT0,
	cin1 => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a,
	cout0 => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a_aCOUT0,
	cout1 => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a_aCOUT1);

inst1_atx_s_a12_I : cyclone_lcell 
-- Equation(s):
-- inst1_atx_s_a12 = inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a # inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a,
	datad => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_atx_s_a12);

inst_aI1_anreset_v_rtl_9_awysi_counter_acounter_cell_a0_a : cyclone_lcell 
-- Equation(s):
-- inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a = DFFEA(!inst_aI1_aLessThan_7_a5 # !inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a_aCOUT0 = CARRY(inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a)
-- inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a_aCOUT1 = CARRY(inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "77AA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a,
	datab => inst_aI1_aLessThan_7_a5,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a,
	cout0 => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a_aCOUT0,
	cout1 => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a_aCOUT1);

inst_aI1_aLessThan_7_a5_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aLessThan_7_a5 = !inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a # !inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3F3F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a,
	datac => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aLessThan_7_a5);

inst_aI1_anreset_v_rtl_9_awysi_counter_acounter_cell_a1_a : cyclone_lcell 
-- Equation(s):
-- inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a = DFFEA(inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a $ inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a_aCOUT0 # !inst_aI1_aLessThan_7_a5, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "3CFF",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a,
	datad => inst_aI1_aLessThan_7_a5,
	aclr => NOT_nRESET_acombout,
	cin0 => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a_aCOUT0,
	cin1 => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a0_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a);

inst_aI2_anreset_v_rtl_4_awysi_counter_acounter_cell_a0_a : cyclone_lcell 
-- Equation(s):
-- inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a = DFFEA(!inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a # !inst_aI2_aLessThan_7_a5, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a_aCOUT0 = CARRY(inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a)
-- inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a_aCOUT1 = CARRY(inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "77CC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aLessThan_7_a5,
	datab => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a,
	cout0 => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a_aCOUT0,
	cout1 => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a_aCOUT1);

inst_aI2_aLessThan_7_a5_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aLessThan_7_a5 = !inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a # !inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "55FF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a,
	datad => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aLessThan_7_a5);

inst_aI2_anreset_v_rtl_4_awysi_counter_acounter_cell_a1_a : cyclone_lcell 
-- Equation(s):
-- inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a = DFFEA(inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a_aCOUT0 $ inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a # !inst_aI2_aLessThan_7_a5, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "5FF5",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aLessThan_7_a5,
	datad => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a,
	aclr => NOT_nRESET_acombout,
	cin0 => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a_aCOUT0,
	cin1 => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a0_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a);

inst_aI2_ai_a326_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_ai_a326 = nRESET_acombout & inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => nRESET_acombout,
	datad => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_ai_a326);

inst_aI3_anreset_v_rtl_3_awysi_counter_acounter_cell_a0_a : cyclone_lcell 
-- Equation(s):
-- inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a = DFFEA(inst_aI3_ai_a212 # !inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a_aCOUT0 = CARRY(inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a)
-- inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a_aCOUT1 = CARRY(inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DDAA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a,
	datab => inst_aI3_ai_a212,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a,
	cout0 => inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a_aCOUT0,
	cout1 => inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a_aCOUT1);

inst_aI3_anreset_v_rtl_3_awysi_counter_acounter_cell_a1_a : cyclone_lcell 
-- Equation(s):
-- inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a1_a = DFFEA(inst_aI3_ai_a212 # inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a_aCOUT0 $ inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a1_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "CFFC",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst_aI3_ai_a212,
	datad => inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a1_a,
	aclr => NOT_nRESET_acombout,
	cin0 => inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a_aCOUT0,
	cin1 => inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a1_a);

inst_aI3_ai_a212_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_ai_a212 = inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a & inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CC00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a,
	datad => inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_ai_a212);

inst_aI4_anreset_v_rtl_6_awysi_counter_acounter_cell_a0_a : cyclone_lcell 
-- Equation(s):
-- inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a = DFFEA(!inst_aI4_aLessThan_39_a5 # !inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a_aCOUT0 = CARRY(inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a)
-- inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a_aCOUT1 = CARRY(inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "77AA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a,
	datab => inst_aI4_aLessThan_39_a5,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a,
	cout0 => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a_aCOUT0,
	cout1 => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a_aCOUT1);

inst_aI4_aLessThan_39_a5_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aLessThan_39_a5 = !inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a # !inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0FFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a,
	datad => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aLessThan_39_a5);

inst_aI4_anreset_v_rtl_6_awysi_counter_acounter_cell_a1_a : cyclone_lcell 
-- Equation(s):
-- inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a = DFFEA(inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a $ inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a_aCOUT0 # !inst_aI4_aLessThan_39_a5, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "5AFF",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a,
	datad => inst_aI4_aLessThan_39_a5,
	aclr => NOT_nRESET_acombout,
	cin0 => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a_aCOUT0,
	cin1 => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a0_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a);

inst_aI4_ai_a18_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_ai_a18 = nRESET_acombout & inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => nRESET_acombout,
	datad => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_ai_a18);

inst_aI1_apc_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a1_a_a216 = inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a & nRESET_acombout & inst_aI1_aiaddr_x_a1_a_a210
-- inst_aI1_apc_a1_a = DFFEA(inst_aI1_aiaddr_x_a1_a_a216, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C000",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a,
	datac => nRESET_acombout,
	datad => inst_aI1_aiaddr_x_a1_a_a210,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a1_a_a216,
	regout => inst_aI1_apc_a1_a);

inst_aI1_apc_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a0_a_a199 = inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a & nRESET_acombout & inst_aI1_aiaddr_x_a0_a_a193
-- inst_aI1_apc_a0_a = DFFEA(inst_aI1_aiaddr_x_a0_a_a199, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C000",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a,
	datac => nRESET_acombout,
	datad => inst_aI1_aiaddr_x_a0_a_a193,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a0_a_a199,
	regout => inst_aI1_apc_a0_a);

inst_aI1_aadd_185_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aadd_185_a0 = !inst_aI1_apc_a0_a
-- inst_aI1_aadd_185_a0COUT0 = CARRY(inst_aI1_apc_a0_a)
-- inst_aI1_aadd_185_a0COUT1 = CARRY(inst_aI1_apc_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "33CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_apc_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aadd_185_a0,
	cout0 => inst_aI1_aadd_185_a0COUT0,
	cout1 => inst_aI1_aadd_185_a0COUT1);

inst_aI1_aadd_185_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aadd_185_a1 = inst_aI1_apc_a1_a $ inst_aI1_aadd_185_a0COUT0
-- inst_aI1_aadd_185_a1COUT0 = CARRY(!inst_aI1_aadd_185_a0COUT0 # !inst_aI1_apc_a1_a)
-- inst_aI1_aadd_185_a1COUT1 = CARRY(!inst_aI1_aadd_185_a0COUT1 # !inst_aI1_apc_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "3C3F",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_apc_a1_a,
	cin0 => inst_aI1_aadd_185_a0COUT0,
	cin1 => inst_aI1_aadd_185_a0COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aadd_185_a1,
	cout0 => inst_aI1_aadd_185_a1COUT0,
	cout1 => inst_aI1_aadd_185_a1COUT1);

inst_aI2_apc_mux_x_a0_a_a214_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_apc_mux_x_a0_a_a214 = inst_aI3_ai_a85 & !inst_aI2_ai_a13 # !inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a # !nRESET_acombout

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5FDF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => nRESET_acombout,
	datab => inst_aI3_ai_a85,
	datac => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a,
	datad => inst_aI2_ai_a13,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_apc_mux_x_a0_a_a214);

rtl_a2352_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2352 = inst_aI2_aTC_c_a2_a & !inst_aI2_aTC_c_a0_a & !inst_aI2_aTC_c_a1_a # !inst_aI2_aTC_c_a2_a & !inst_aI2_aTD_c_a3_a & (!inst_aI2_aTC_c_a1_a # !inst_aI2_aTC_c_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "1107",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_c_a0_a,
	datab => inst_aI2_aTC_c_a1_a,
	datac => inst_aI2_aTD_c_a3_a,
	datad => inst_aI2_aTC_c_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2352);

inst_aI2_avalid_c_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_ai_a220 = nRESET_acombout & inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a & M1_valid_c & inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a1_a
-- inst_aI2_avalid_c = DFFEA(inst_aI2_andre_x_a44, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "8000",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => nRESET_acombout,
	datab => inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a,
	datac => inst_aI2_andre_x_a44,
	datad => inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a1_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_ai_a220,
	regout => inst_aI2_avalid_c);

inst_aI3_ai_a224_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_ai_a224 = nRESET_acombout & inst_aI2_avalid_c

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => nRESET_acombout,
	datad => inst_aI2_avalid_c,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_ai_a224);

inst_aI3_aacc_a0_a_a7_a_a4227_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a7_a_a4227 = inst_aI2_aTC_c_a2_a & inst_aI3_ai_a212 & rtl_a2352 & inst_aI3_ai_a224

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_c_a2_a,
	datab => inst_aI3_ai_a212,
	datac => rtl_a2352,
	datad => inst_aI3_ai_a224,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a7_a_a4227);

inst_aI3_aacc_a0_a_a7_a_a4226_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a7_a_a4226 = !inst_aI2_aTC_c_a2_a & inst_aI3_ai_a212 & rtl_a2352 & inst_aI3_ai_a224

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_c_a2_a,
	datab => inst_aI3_ai_a212,
	datac => rtl_a2352,
	datad => inst_aI3_ai_a224,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a7_a_a4226);

inst_aI1_apc_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a3_a_a122 = inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a & nRESET_acombout & inst_aI1_aiaddr_x_a3_a_a372
-- inst_aI1_apc_a3_a = DFFEA(inst_aI1_aiaddr_x_a3_a_a122, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C000",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a,
	datac => nRESET_acombout,
	datad => inst_aI1_aiaddr_x_a3_a_a372,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a3_a_a122,
	regout => inst_aI1_apc_a3_a);

inst_aI1_apc_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a2_a_a233 = nRESET_acombout & inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a & inst_aI1_aiaddr_x_a2_a_a227
-- inst_aI1_apc_a2_a = DFFEA(inst_aI1_aiaddr_x_a2_a_a233, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A000",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => nRESET_acombout,
	datac => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a,
	datad => inst_aI1_aiaddr_x_a2_a_a227,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a2_a_a233,
	regout => inst_aI1_apc_a2_a);

inst_aI1_aadd_185_a2_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aadd_185_a2 = inst_aI1_apc_a2_a $ !inst_aI1_aadd_185_a1COUT0
-- inst_aI1_aadd_185_a2COUT0 = CARRY(inst_aI1_apc_a2_a & !inst_aI1_aadd_185_a1COUT0)
-- inst_aI1_aadd_185_a2COUT1 = CARRY(inst_aI1_apc_a2_a & !inst_aI1_aadd_185_a1COUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "C30C",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_apc_a2_a,
	cin0 => inst_aI1_aadd_185_a1COUT0,
	cin1 => inst_aI1_aadd_185_a1COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aadd_185_a2,
	cout0 => inst_aI1_aadd_185_a2COUT0,
	cout1 => inst_aI1_aadd_185_a2COUT1);

inst_aI1_aadd_185_a3_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aadd_185_a3 = inst_aI1_apc_a3_a $ inst_aI1_aadd_185_a2COUT0
-- inst_aI1_aadd_185_a3COUT0 = CARRY(!inst_aI1_aadd_185_a2COUT0 # !inst_aI1_apc_a3_a)
-- inst_aI1_aadd_185_a3COUT1 = CARRY(!inst_aI1_aadd_185_a2COUT1 # !inst_aI1_apc_a3_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "3C3F",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_apc_a3_a,
	cin0 => inst_aI1_aadd_185_a2COUT0,
	cin1 => inst_aI1_aadd_185_a2COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aadd_185_a3,
	cout0 => inst_aI1_aadd_185_a3COUT0,
	cout1 => inst_aI1_aadd_185_a3COUT1);

inst_aI1_aiaddr_x_a3_a_a369_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a3_a_a369 = !inst_aI2_apc_mux_x_a1_a_a42 & (inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a3 # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_apc_a3_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0C0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_apc_a3_a,
	datab => inst_aI1_aadd_185_a3,
	datac => inst_aI2_apc_mux_x_a1_a_a42,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a3_a_a369);

rtl_a2519_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2519 = inst_aI2_apc_mux_x_a1_a_a42 & (inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a3 # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_astack_addrs_c_a0_a_a3_a) # !inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_astack_addrs_c_a0_a_a3_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CAAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a0_a_a3_a,
	datab => inst_aI1_aadd_185_a3,
	datac => inst_aI2_apc_mux_x_a1_a_a42,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2519);

inst_aI1_aMux_197_rtl_141_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_197_rtl_141_a0 = inst_aI2_apc_mux_x_a0_a_a8 & inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_197_rtl_141_a0);

inst_aI1_ai_a2_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_ai_a2 = inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a & nRESET_acombout

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a,
	datad => nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_ai_a2);

inst_aI1_astack_addrs_c_a7_a_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a7_a_a3_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a6_a_a3_a & !inst_aI1_aMux_197_rtl_141_a0 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a6_a_a3_a # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a7_a_a3_a), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "30E2",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a7_a_a3_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_astack_addrs_c_a6_a_a3_a,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a7_a_a3_a);

rtl_a3175_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3175 = inst_aI1_astack_addrs_c_a7_a_a3_a & (inst_aI1_astack_addrs_c_a6_a_a3_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a7_a_a3_a & inst_aI1_astack_addrs_c_a6_a_a3_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AACC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a7_a_a3_a,
	datab => inst_aI1_astack_addrs_c_a6_a_a3_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3175);

inst_aI1_astack_addrs_c_a6_a_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a6_a_a3_a = DFFEA(inst_aI1_astack_addrs_c_a5_a_a3_a & (rtl_a3175 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a5_a_a3_a & rtl_a3175 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2B8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a5_a_a3_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a3175,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a6_a_a3_a);

rtl_a3075_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3075 = inst_aI1_astack_addrs_c_a6_a_a3_a & (inst_aI1_astack_addrs_c_a5_a_a3_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a6_a_a3_a & inst_aI1_astack_addrs_c_a5_a_a3_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a6_a_a3_a,
	datac => inst_aI1_astack_addrs_c_a5_a_a3_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3075);

inst_aI1_astack_addrs_c_a5_a_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a5_a_a3_a = DFFEA(inst_aI1_astack_addrs_c_a4_a_a3_a & (rtl_a3075 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a4_a_a3_a & rtl_a3075 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a4_a_a3_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a3075,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a5_a_a3_a);

rtl_a2975_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2975 = inst_aI1_astack_addrs_c_a4_a_a3_a & (inst_aI1_astack_addrs_c_a5_a_a3_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a4_a_a3_a & inst_aI1_astack_addrs_c_a5_a_a3_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a4_a_a3_a,
	datac => inst_aI1_astack_addrs_c_a5_a_a3_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2975);

inst_aI1_astack_addrs_c_a4_a_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a4_a_a3_a = DFFEA(inst_aI1_astack_addrs_c_a3_a_a3_a & (rtl_a2975 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a3_a_a3_a & rtl_a2975 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a3_a_a3_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a2975,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a4_a_a3_a);

rtl_a2875_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2875 = inst_aI1_astack_addrs_c_a4_a_a3_a & (inst_aI1_astack_addrs_c_a3_a_a3_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a4_a_a3_a & inst_aI1_astack_addrs_c_a3_a_a3_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a4_a_a3_a,
	datac => inst_aI1_astack_addrs_c_a3_a_a3_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2875);

inst_aI1_astack_addrs_c_a3_a_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a3_a = DFFEA(inst_aI1_astack_addrs_c_a2_a_a3_a & (rtl_a2875 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a2_a_a3_a & rtl_a2875 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2B8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a2_a_a3_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a2875,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a3_a);

rtl_a2775_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2775 = inst_aI1_astack_addrs_c_a2_a_a3_a & (inst_aI1_astack_addrs_c_a3_a_a3_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a2_a_a3_a & inst_aI1_astack_addrs_c_a3_a_a3_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a2_a_a3_a,
	datac => inst_aI1_astack_addrs_c_a3_a_a3_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2775);

inst_aI1_astack_addrs_c_a2_a_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a3_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a2775 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a1_a_a3_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a1_a_a3_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a2775), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a1_a_a3_a,
	datac => rtl_a2775,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a3_a);

rtl_a2635_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2635 = inst_aI1_astack_addrs_c_a2_a_a3_a & (inst_aI1_astack_addrs_c_a1_a_a3_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a2_a_a3_a & inst_aI1_astack_addrs_c_a1_a_a3_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a2_a_a3_a,
	datac => inst_aI1_astack_addrs_c_a1_a_a3_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2635);

inst_aI1_astack_addrs_c_a1_a_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a3_a = DFFEA(inst_aI1_astack_addrs_c_a0_a_a3_a & (rtl_a2635 # inst_aI1_aMux_197_rtl_141_a0 $ inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a0_a_a3_a & rtl_a2635 & (inst_aI1_aMux_197_rtl_141_a0 $ !inst_aI2_apc_mux_x_a2_a_a27), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CAAC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a0_a_a3_a,
	datab => rtl_a2635,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a3_a);

inst_aI1_apc_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a4_a_a132 = inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a & nRESET_acombout & inst_aI1_aiaddr_x_a4_a_a382
-- inst_aI1_apc_a4_a = DFFEA(inst_aI1_aiaddr_x_a4_a_a132, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A000",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a,
	datac => nRESET_acombout,
	datad => inst_aI1_aiaddr_x_a4_a_a382,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a4_a_a132,
	regout => inst_aI1_apc_a4_a);

inst_aI1_aadd_185_a4_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aadd_185_a4 = inst_aI1_apc_a4_a $ !inst_aI1_aadd_185_a3COUT0
-- inst_aI1_aadd_185_a4COUT = CARRY(inst_aI1_apc_a4_a & !inst_aI1_aadd_185_a3COUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "A50A",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_apc_a4_a,
	cin0 => inst_aI1_aadd_185_a3COUT0,
	cin1 => inst_aI1_aadd_185_a3COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aadd_185_a4,
	cout => inst_aI1_aadd_185_a4COUT);

inst_aI1_aiaddr_x_a4_a_a379_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a4_a_a379 = !inst_aI2_apc_mux_x_a1_a_a42 & (inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a4 # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_apc_a4_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00B8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_aadd_185_a4,
	datab => inst_aI2_apc_mux_x_a0_a_a8,
	datac => inst_aI1_apc_a4_a,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a4_a_a379);

rtl_a2529_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2529 = inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_aadd_185_a4 # !inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_astack_addrs_c_a0_a_a4_a) # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_astack_addrs_c_a0_a_a4_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ACCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_aadd_185_a4,
	datab => inst_aI1_astack_addrs_c_a0_a_a4_a,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2529);

inst_aI1_astack_addrs_c_a7_a_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a7_a_a4_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a6_a_a4_a & !inst_aI1_aMux_197_rtl_141_a0 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a6_a_a4_a # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a7_a_a4_a), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0CCA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a7_a_a4_a,
	datab => inst_aI1_astack_addrs_c_a6_a_a4_a,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a7_a_a4_a);

rtl_a3185_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3185 = inst_aI1_astack_addrs_c_a7_a_a4_a & (inst_aI1_astack_addrs_c_a6_a_a4_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a7_a_a4_a & inst_aI1_astack_addrs_c_a6_a_a4_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a7_a_a4_a,
	datac => inst_aI1_astack_addrs_c_a6_a_a4_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3185);

inst_aI1_astack_addrs_c_a6_a_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a6_a_a4_a = DFFEA(inst_aI1_astack_addrs_c_a5_a_a4_a & (rtl_a3185 # inst_aI1_aMux_197_rtl_141_a0 $ inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a5_a_a4_a & rtl_a3185 & (inst_aI1_aMux_197_rtl_141_a0 $ !inst_aI2_apc_mux_x_a2_a_a27), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a5_a_a4_a,
	datab => inst_aI1_aMux_197_rtl_141_a0,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => rtl_a3185,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a6_a_a4_a);

rtl_a3085_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3085 = inst_aI1_astack_addrs_c_a5_a_a4_a & (inst_aI1_astack_addrs_c_a6_a_a4_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a5_a_a4_a & inst_aI1_astack_addrs_c_a6_a_a4_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a5_a_a4_a,
	datac => inst_aI1_astack_addrs_c_a6_a_a4_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3085);

inst_aI1_astack_addrs_c_a5_a_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a5_a_a4_a = DFFEA(inst_aI1_astack_addrs_c_a4_a_a4_a & (rtl_a3085 # inst_aI1_aMux_197_rtl_141_a0 $ inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a4_a_a4_a & rtl_a3085 & (inst_aI1_aMux_197_rtl_141_a0 $ !inst_aI2_apc_mux_x_a2_a_a27), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a4_a_a4_a,
	datab => inst_aI1_aMux_197_rtl_141_a0,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => rtl_a3085,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a5_a_a4_a);

rtl_a2985_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2985 = inst_aI1_astack_addrs_c_a5_a_a4_a & (inst_aI1_astack_addrs_c_a4_a_a4_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a5_a_a4_a & inst_aI1_astack_addrs_c_a4_a_a4_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a5_a_a4_a,
	datac => inst_aI1_astack_addrs_c_a4_a_a4_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2985);

inst_aI1_astack_addrs_c_a4_a_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a4_a_a4_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a2985 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a3_a_a4_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a3_a_a4_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a2985), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a3_a_a4_a,
	datac => rtl_a2985,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a4_a_a4_a);

rtl_a2885_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2885 = inst_aI1_astack_addrs_c_a4_a_a4_a & (inst_aI1_astack_addrs_c_a3_a_a4_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a4_a_a4_a & inst_aI1_astack_addrs_c_a3_a_a4_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a4_a_a4_a,
	datac => inst_aI1_astack_addrs_c_a3_a_a4_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2885);

inst_aI1_astack_addrs_c_a3_a_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a4_a = DFFEA(inst_aI1_astack_addrs_c_a2_a_a4_a & (rtl_a2885 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a2_a_a4_a & rtl_a2885 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CAAC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a2_a_a4_a,
	datab => rtl_a2885,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a4_a);

rtl_a2785_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2785 = inst_aI1_astack_addrs_c_a2_a_a4_a & (inst_aI1_astack_addrs_c_a3_a_a4_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a2_a_a4_a & inst_aI1_astack_addrs_c_a3_a_a4_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a2_a_a4_a,
	datac => inst_aI1_astack_addrs_c_a3_a_a4_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2785);

inst_aI1_astack_addrs_c_a2_a_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a4_a = DFFEA(inst_aI1_astack_addrs_c_a1_a_a4_a & (rtl_a2785 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a1_a_a4_a & rtl_a2785 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a1_a_a4_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a2785,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a4_a);

rtl_a2645_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2645 = inst_aI1_astack_addrs_c_a1_a_a4_a & (inst_aI1_astack_addrs_c_a2_a_a4_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a1_a_a4_a & inst_aI1_astack_addrs_c_a2_a_a4_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a1_a_a4_a,
	datac => inst_aI1_astack_addrs_c_a2_a_a4_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2645);

inst_aI1_astack_addrs_c_a1_a_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a4_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a2645 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a0_a_a4_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a0_a_a4_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a2645), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ED48",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a0_a_a4_a,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a2645,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a4_a);

inst_aI1_apc_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a5_a_a142 = nRESET_acombout & inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a & inst_aI1_aiaddr_x_a5_a_a392
-- inst_aI1_apc_a5_a = DFFEA(inst_aI1_aiaddr_x_a5_a_a142, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A000",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => nRESET_acombout,
	datac => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a,
	datad => inst_aI1_aiaddr_x_a5_a_a392,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a5_a_a142,
	regout => inst_aI1_apc_a5_a);

inst_aI1_aadd_185_a5_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aadd_185_a5 = inst_aI1_apc_a5_a $ inst_aI1_aadd_185_a4COUT
-- inst_aI1_aadd_185_a5COUT0 = CARRY(!inst_aI1_aadd_185_a4COUT # !inst_aI1_apc_a5_a)
-- inst_aI1_aadd_185_a5COUT1 = CARRY(!inst_aI1_aadd_185_a4COUT # !inst_aI1_apc_a5_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "3C3F",
	cin_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_apc_a5_a,
	cin => inst_aI1_aadd_185_a4COUT,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aadd_185_a5,
	cout0 => inst_aI1_aadd_185_a5COUT0,
	cout1 => inst_aI1_aadd_185_a5COUT1);

rtl_a2539_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2539 = inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_aadd_185_a5 # !inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_astack_addrs_c_a0_a_a5_a) # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_astack_addrs_c_a0_a_a5_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_apc_mux_x_a0_a_a8,
	datab => inst_aI1_astack_addrs_c_a0_a_a5_a,
	datac => inst_aI1_aadd_185_a5,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2539);

inst_aI1_astack_addrs_c_a7_a_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a7_a_a5_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a6_a_a5_a & !inst_aI1_aMux_197_rtl_141_a0 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a6_a_a5_a # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a7_a_a5_a), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0AAC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a6_a_a5_a,
	datab => inst_aI1_astack_addrs_c_a7_a_a5_a,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a7_a_a5_a);

rtl_a3195_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3195 = inst_aI1_astack_addrs_c_a7_a_a5_a & (inst_aI1_astack_addrs_c_a6_a_a5_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a7_a_a5_a & inst_aI1_astack_addrs_c_a6_a_a5_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a7_a_a5_a,
	datac => inst_aI1_astack_addrs_c_a6_a_a5_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3195);

inst_aI1_astack_addrs_c_a6_a_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a6_a_a5_a = DFFEA(inst_aI1_astack_addrs_c_a5_a_a5_a & (rtl_a3195 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a5_a_a5_a & rtl_a3195 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2B8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a5_a_a5_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a3195,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a6_a_a5_a);

rtl_a3095_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3095 = inst_aI1_astack_addrs_c_a6_a_a5_a & (inst_aI1_astack_addrs_c_a5_a_a5_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a6_a_a5_a & inst_aI1_astack_addrs_c_a5_a_a5_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a6_a_a5_a,
	datac => inst_aI1_astack_addrs_c_a5_a_a5_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3095);

inst_aI1_astack_addrs_c_a5_a_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a5_a_a5_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a3095 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a4_a_a5_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a4_a_a5_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a3095), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a4_a_a5_a,
	datac => rtl_a3095,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a5_a_a5_a);

rtl_a2995_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2995 = inst_aI1_astack_addrs_c_a4_a_a5_a & (inst_aI1_astack_addrs_c_a5_a_a5_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a4_a_a5_a & inst_aI1_astack_addrs_c_a5_a_a5_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a4_a_a5_a,
	datac => inst_aI1_astack_addrs_c_a5_a_a5_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2995);

inst_aI1_astack_addrs_c_a4_a_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a4_a_a5_a = DFFEA(inst_aI1_astack_addrs_c_a3_a_a5_a & (rtl_a2995 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a3_a_a5_a & rtl_a2995 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a3_a_a5_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a2995,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a4_a_a5_a);

rtl_a2895_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2895 = inst_aI1_astack_addrs_c_a4_a_a5_a & (inst_aI1_astack_addrs_c_a3_a_a5_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a4_a_a5_a & inst_aI1_astack_addrs_c_a3_a_a5_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a4_a_a5_a,
	datac => inst_aI1_astack_addrs_c_a3_a_a5_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2895);

inst_aI1_astack_addrs_c_a3_a_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a5_a = DFFEA(inst_aI1_aMux_197_rtl_141_a0 & (inst_aI2_apc_mux_x_a2_a_a27 & rtl_a2895 # !inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a2_a_a5_a) # !inst_aI1_aMux_197_rtl_141_a0 & (inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a2_a_a5_a # !inst_aI2_apc_mux_x_a2_a_a27 & rtl_a2895), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ED48",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_aMux_197_rtl_141_a0,
	datab => inst_aI1_astack_addrs_c_a2_a_a5_a,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => rtl_a2895,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a5_a);

rtl_a2795_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2795 = inst_aI1_astack_addrs_c_a2_a_a5_a & (inst_aI1_astack_addrs_c_a3_a_a5_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a2_a_a5_a & inst_aI1_astack_addrs_c_a3_a_a5_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a2_a_a5_a,
	datac => inst_aI1_astack_addrs_c_a3_a_a5_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2795);

inst_aI1_astack_addrs_c_a2_a_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a5_a = DFFEA(inst_aI1_astack_addrs_c_a1_a_a5_a & (rtl_a2795 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a1_a_a5_a & rtl_a2795 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2B8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a1_a_a5_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a2795,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a5_a);

rtl_a2655_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2655 = inst_aI1_astack_addrs_c_a2_a_a5_a & (inst_aI1_astack_addrs_c_a1_a_a5_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a2_a_a5_a & inst_aI1_astack_addrs_c_a1_a_a5_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a2_a_a5_a,
	datac => inst_aI1_astack_addrs_c_a1_a_a5_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2655);

inst_aI1_astack_addrs_c_a1_a_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a5_a = DFFEA(inst_aI1_astack_addrs_c_a0_a_a5_a & (rtl_a2655 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a0_a_a5_a & rtl_a2655 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a0_a_a5_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a2655,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a5_a);

inst_aI1_apc_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a6_a_a152 = inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a & nRESET_acombout & inst_aI1_aiaddr_x_a6_a_a402
-- inst_aI1_apc_a6_a = DFFEA(inst_aI1_aiaddr_x_a6_a_a152, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C000",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a,
	datac => nRESET_acombout,
	datad => inst_aI1_aiaddr_x_a6_a_a402,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a6_a_a152,
	regout => inst_aI1_apc_a6_a);

inst_aI1_aadd_185_a6_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aadd_185_a6 = inst_aI1_apc_a6_a $ !(!inst_aI1_aadd_185_a4COUT & inst_aI1_aadd_185_a5COUT0) # (inst_aI1_aadd_185_a4COUT & inst_aI1_aadd_185_a5COUT1)
-- inst_aI1_aadd_185_a6COUT0 = CARRY(inst_aI1_apc_a6_a & !inst_aI1_aadd_185_a5COUT0)
-- inst_aI1_aadd_185_a6COUT1 = CARRY(inst_aI1_apc_a6_a & !inst_aI1_aadd_185_a5COUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "A50A",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_apc_a6_a,
	cin => inst_aI1_aadd_185_a4COUT,
	cin0 => inst_aI1_aadd_185_a5COUT0,
	cin1 => inst_aI1_aadd_185_a5COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aadd_185_a6,
	cout0 => inst_aI1_aadd_185_a6COUT0,
	cout1 => inst_aI1_aadd_185_a6COUT1);

inst_aI1_aiaddr_x_a6_a_a399_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a6_a_a399 = !inst_aI2_apc_mux_x_a1_a_a42 & (inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a6 # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_apc_a6_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0C0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_apc_a6_a,
	datab => inst_aI1_aadd_185_a6,
	datac => inst_aI2_apc_mux_x_a1_a_a42,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a6_a_a399);

rtl_a2549_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2549 = inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_aadd_185_a6 # !inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_astack_addrs_c_a0_a_a6_a) # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_astack_addrs_c_a0_a_a6_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EA2A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a0_a_a6_a,
	datab => inst_aI2_apc_mux_x_a0_a_a8,
	datac => inst_aI2_apc_mux_x_a1_a_a42,
	datad => inst_aI1_aadd_185_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2549);

inst_aI1_astack_addrs_c_a7_a_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a7_a_a6_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a6_a_a6_a & !inst_aI1_aMux_197_rtl_141_a0 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a6_a_a6_a # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a7_a_a6_a), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "22B8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a6_a_a6_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_astack_addrs_c_a7_a_a6_a,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a7_a_a6_a);

rtl_a3205_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3205 = inst_aI1_astack_addrs_c_a6_a_a6_a & (inst_aI1_astack_addrs_c_a7_a_a6_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a6_a_a6_a & inst_aI1_astack_addrs_c_a7_a_a6_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a6_a_a6_a,
	datac => inst_aI1_astack_addrs_c_a7_a_a6_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3205);

inst_aI1_astack_addrs_c_a6_a_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a6_a_a6_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a3205 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a5_a_a6_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a5_a_a6_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a3205), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a5_a_a6_a,
	datac => rtl_a3205,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a6_a_a6_a);

rtl_a3105_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3105 = inst_aI1_astack_addrs_c_a6_a_a6_a & (inst_aI1_astack_addrs_c_a5_a_a6_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a6_a_a6_a & inst_aI1_astack_addrs_c_a5_a_a6_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AACC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a6_a_a6_a,
	datab => inst_aI1_astack_addrs_c_a5_a_a6_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3105);

inst_aI1_astack_addrs_c_a5_a_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a5_a_a6_a = DFFEA(inst_aI1_astack_addrs_c_a4_a_a6_a & (rtl_a3105 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a4_a_a6_a & rtl_a3105 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2B8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a4_a_a6_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a3105,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a5_a_a6_a);

rtl_a3005_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3005 = inst_aI1_astack_addrs_c_a4_a_a6_a & (inst_aI1_astack_addrs_c_a5_a_a6_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a4_a_a6_a & inst_aI1_astack_addrs_c_a5_a_a6_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a4_a_a6_a,
	datab => inst_aI1_astack_addrs_c_a5_a_a6_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3005);

inst_aI1_astack_addrs_c_a4_a_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a4_a_a6_a = DFFEA(inst_aI1_astack_addrs_c_a3_a_a6_a & (rtl_a3005 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a3_a_a6_a & rtl_a3005 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2B8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a3_a_a6_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a3005,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a4_a_a6_a);

rtl_a2905_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2905 = inst_aI1_astack_addrs_c_a4_a_a6_a & (inst_aI1_astack_addrs_c_a3_a_a6_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a4_a_a6_a & inst_aI1_astack_addrs_c_a3_a_a6_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a4_a_a6_a,
	datac => inst_aI1_astack_addrs_c_a3_a_a6_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2905);

inst_aI1_astack_addrs_c_a3_a_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a6_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a2905 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a2_a_a6_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a2_a_a6_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a2905), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a2_a_a6_a,
	datac => rtl_a2905,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a6_a);

rtl_a2805_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2805 = inst_aI1_astack_addrs_c_a2_a_a6_a & (inst_aI1_astack_addrs_c_a3_a_a6_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a2_a_a6_a & inst_aI1_astack_addrs_c_a3_a_a6_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a2_a_a6_a,
	datac => inst_aI1_astack_addrs_c_a3_a_a6_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2805);

inst_aI1_astack_addrs_c_a2_a_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a6_a = DFFEA(rtl_a2805 & (inst_aI1_astack_addrs_c_a1_a_a6_a # inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0) # !rtl_a2805 & inst_aI1_astack_addrs_c_a1_a_a6_a & (inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ACCA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => rtl_a2805,
	datab => inst_aI1_astack_addrs_c_a1_a_a6_a,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a6_a);

rtl_a2665_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2665 = inst_aI1_astack_addrs_c_a2_a_a6_a & (inst_aI1_astack_addrs_c_a1_a_a6_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a2_a_a6_a & inst_aI1_astack_addrs_c_a1_a_a6_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a2_a_a6_a,
	datac => inst_aI1_astack_addrs_c_a1_a_a6_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2665);

inst_aI1_astack_addrs_c_a1_a_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a6_a = DFFEA(inst_aI1_astack_addrs_c_a0_a_a6_a & (rtl_a2665 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a0_a_a6_a & rtl_a2665 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2B8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a0_a_a6_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a2665,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a6_a);

inst_aI1_aMux_287_a32_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_287_a32 = nRESET_acombout & inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a & inst_aI2_apc_mux_x_a2_a_a27 & inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => nRESET_acombout,
	datab => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_287_a32);

inst_aI1_apc_a9_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a9_a_a182 = nRESET_acombout & inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a & inst_aI1_aiaddr_x_a9_a_a432
-- inst_aI1_apc_a9_a = DFFEA(inst_aI1_aiaddr_x_a9_a_a182, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A000",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => nRESET_acombout,
	datac => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a,
	datad => inst_aI1_aiaddr_x_a9_a_a432,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a9_a_a182,
	regout => inst_aI1_apc_a9_a);

inst_aI1_apc_a8_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a8_a_a172 = inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a & nRESET_acombout & inst_aI1_aiaddr_x_a8_a_a422
-- inst_aI1_apc_a8_a = DFFEA(inst_aI1_aiaddr_x_a8_a_a172, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C000",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a,
	datac => nRESET_acombout,
	datad => inst_aI1_aiaddr_x_a8_a_a422,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a8_a_a172,
	regout => inst_aI1_apc_a8_a);

inst_aI1_apc_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a7_a_a162 = nRESET_acombout & inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a & inst_aI1_aiaddr_x_a7_a_a412
-- inst_aI1_apc_a7_a = DFFEA(inst_aI1_aiaddr_x_a7_a_a162, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A000",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => nRESET_acombout,
	datac => inst_aI1_anreset_v_rtl_9_awysi_counter_asafe_q_a1_a,
	datad => inst_aI1_aiaddr_x_a7_a_a412,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a7_a_a162,
	regout => inst_aI1_apc_a7_a);

inst_aI1_aadd_185_a7_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aadd_185_a7 = inst_aI1_apc_a7_a $ (!inst_aI1_aadd_185_a4COUT & inst_aI1_aadd_185_a6COUT0) # (inst_aI1_aadd_185_a4COUT & inst_aI1_aadd_185_a6COUT1)
-- inst_aI1_aadd_185_a7COUT0 = CARRY(!inst_aI1_aadd_185_a6COUT0 # !inst_aI1_apc_a7_a)
-- inst_aI1_aadd_185_a7COUT1 = CARRY(!inst_aI1_aadd_185_a6COUT1 # !inst_aI1_apc_a7_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "3C3F",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_apc_a7_a,
	cin => inst_aI1_aadd_185_a4COUT,
	cin0 => inst_aI1_aadd_185_a6COUT0,
	cin1 => inst_aI1_aadd_185_a6COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aadd_185_a7,
	cout0 => inst_aI1_aadd_185_a7COUT0,
	cout1 => inst_aI1_aadd_185_a7COUT1);

inst_aI1_aadd_185_a8_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aadd_185_a8 = inst_aI1_apc_a8_a $ !(!inst_aI1_aadd_185_a4COUT & inst_aI1_aadd_185_a7COUT0) # (inst_aI1_aadd_185_a4COUT & inst_aI1_aadd_185_a7COUT1)
-- inst_aI1_aadd_185_a8COUT0 = CARRY(inst_aI1_apc_a8_a & !inst_aI1_aadd_185_a7COUT0)
-- inst_aI1_aadd_185_a8COUT1 = CARRY(inst_aI1_apc_a8_a & !inst_aI1_aadd_185_a7COUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "C30C",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_apc_a8_a,
	cin => inst_aI1_aadd_185_a4COUT,
	cin0 => inst_aI1_aadd_185_a7COUT0,
	cin1 => inst_aI1_aadd_185_a7COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aadd_185_a8,
	cout0 => inst_aI1_aadd_185_a8COUT0,
	cout1 => inst_aI1_aadd_185_a8COUT1);

inst_aI1_aadd_185_a9_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aadd_185_a9 = (!inst_aI1_aadd_185_a4COUT & inst_aI1_aadd_185_a8COUT0) # (inst_aI1_aadd_185_a4COUT & inst_aI1_aadd_185_a8COUT1) $ inst_aI1_apc_a9_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "0FF0",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datad => inst_aI1_apc_a9_a,
	cin => inst_aI1_aadd_185_a4COUT,
	cin0 => inst_aI1_aadd_185_a8COUT0,
	cin1 => inst_aI1_aadd_185_a8COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aadd_185_a9);

rtl_a2579_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2579 = inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_aadd_185_a9 # !inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_astack_addrs_c_a0_a_a9_a) # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_astack_addrs_c_a0_a_a9_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a0_a_a9_a,
	datab => inst_aI2_apc_mux_x_a0_a_a8,
	datac => inst_aI1_aadd_185_a9,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2579);

inst_aI1_astack_addrs_c_a7_a_a9_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a7_a_a9_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a6_a_a9_a & !inst_aI1_aMux_197_rtl_141_a0 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a6_a_a9_a # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a7_a_a9_a), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0CCA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a7_a_a9_a,
	datab => inst_aI1_astack_addrs_c_a6_a_a9_a,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a7_a_a9_a);

rtl_a3235_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3235 = inst_aI1_astack_addrs_c_a7_a_a9_a & (inst_aI1_astack_addrs_c_a6_a_a9_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a7_a_a9_a & inst_aI1_astack_addrs_c_a6_a_a9_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AACC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a7_a_a9_a,
	datab => inst_aI1_astack_addrs_c_a6_a_a9_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3235);

inst_aI1_astack_addrs_c_a6_a_a9_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a6_a_a9_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a3235 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a5_a_a9_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a5_a_a9_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a3235), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a5_a_a9_a,
	datac => rtl_a3235,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a6_a_a9_a);

rtl_a3135_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3135 = inst_aI1_astack_addrs_c_a6_a_a9_a & (inst_aI2_apc_mux_x_a2_a_a27 # inst_aI1_astack_addrs_c_a5_a_a9_a) # !inst_aI1_astack_addrs_c_a6_a_a9_a & !inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a5_a_a9_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CFC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a6_a_a9_a,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => inst_aI1_astack_addrs_c_a5_a_a9_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3135);

inst_aI1_astack_addrs_c_a5_a_a9_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a5_a_a9_a = DFFEA(inst_aI1_astack_addrs_c_a4_a_a9_a & (rtl_a3135 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a4_a_a9_a & rtl_a3135 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a4_a_a9_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a3135,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a5_a_a9_a);

rtl_a3035_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3035 = inst_aI1_astack_addrs_c_a4_a_a9_a & (inst_aI1_astack_addrs_c_a5_a_a9_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a4_a_a9_a & inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a5_a_a9_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FA0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a4_a_a9_a,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => inst_aI1_astack_addrs_c_a5_a_a9_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3035);

inst_aI1_astack_addrs_c_a4_a_a9_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a4_a_a9_a = DFFEA(inst_aI1_astack_addrs_c_a3_a_a9_a & (rtl_a3035 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a3_a_a9_a & rtl_a3035 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a3_a_a9_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a3035,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a4_a_a9_a);

rtl_a2935_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2935 = inst_aI1_astack_addrs_c_a3_a_a9_a & (inst_aI1_astack_addrs_c_a4_a_a9_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a3_a_a9_a & inst_aI1_astack_addrs_c_a4_a_a9_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a3_a_a9_a,
	datac => inst_aI1_astack_addrs_c_a4_a_a9_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2935);

inst_aI1_astack_addrs_c_a3_a_a9_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a9_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a2935 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a2_a_a9_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a2_a_a9_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a2935), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a2_a_a9_a,
	datac => rtl_a2935,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a9_a);

rtl_a2835_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2835 = inst_aI1_astack_addrs_c_a3_a_a9_a & (inst_aI2_apc_mux_x_a2_a_a27 # inst_aI1_astack_addrs_c_a2_a_a9_a) # !inst_aI1_astack_addrs_c_a3_a_a9_a & !inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a2_a_a9_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a3_a_a9_a,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => inst_aI1_astack_addrs_c_a2_a_a9_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2835);

inst_aI1_astack_addrs_c_a2_a_a9_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a9_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a2835 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a1_a_a9_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a1_a_a9_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a2835), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a1_a_a9_a,
	datac => rtl_a2835,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a9_a);

rtl_a2695_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2695 = inst_aI1_astack_addrs_c_a1_a_a9_a & (inst_aI1_astack_addrs_c_a2_a_a9_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a1_a_a9_a & inst_aI1_astack_addrs_c_a2_a_a9_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a1_a_a9_a,
	datac => inst_aI1_astack_addrs_c_a2_a_a9_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2695);

inst_aI1_astack_addrs_c_a1_a_a9_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a9_a = DFFEA(inst_aI1_astack_addrs_c_a0_a_a9_a & (rtl_a2695 # inst_aI1_aMux_197_rtl_141_a0 $ inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a0_a_a9_a & rtl_a2695 & (inst_aI1_aMux_197_rtl_141_a0 $ !inst_aI2_apc_mux_x_a2_a_a27), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a0_a_a9_a,
	datab => inst_aI1_aMux_197_rtl_141_a0,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => rtl_a2695,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a9_a);

inst6_aaltsyncram_component_aram_block_a0_a_a13_a : cyclone_ram_block 
-- pragma translate_off
GENERIC MAP (
	mem8 => "00000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem7 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001010100110000000101010001100000000000110000001001000000101000000000101100000000101000000000101000010100010000001000101010110101010100000100000100000000",
	mem6 => "00000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem5 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100010100000100000000000100000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000",
	mem4 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem3 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000100010100000000000100001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000",
	mem2 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	operation_mode => "rom",
	ram_block_type => "auto",
	logical_ram_name => "lpm_rom0:inst6|altsyncram:altsyncram_component|ALTSYNCRAM INSTANTIATION",
	init_file => "../rom.mif",
	init_file_layout => "port_a",
	data_interleave_width_in_bits => 1,
	data_interleave_offset_in_bits => 1,
	port_a_write_enable_clock => "none",
	port_a_byte_enable_clock => "none",
	port_a_logical_ram_depth => 1024,
	port_a_logical_ram_width => 14,
	port_a_data_in_clear => "none",
	port_a_address_clear => "none",
	port_a_write_enable_clear => "none",
	port_a_byte_enable_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_out_clear => "none",
	port_a_first_address => 0,
	port_a_last_address => 1023,
	port_a_first_bit_number => 13,
	port_a_data_width => 4,
	port_a_address_width => 10)
-- pragma translate_on
PORT MAP (
	clk0 => UCLK_acombout,
	ena0 => VCC,
	portaaddr => ww_inst6_aaltsyncram_component_aram_block_a0_a_a13_a_aaddress,
	devclrn => devclrn,
	devpor => devpor,
	portadataout => ww_inst6_aaltsyncram_component_aram_block_a0_a_a13_a_adataout);

rtl_a1001 : cyclone_lcell 
-- Equation(s):
-- rtl_a452 = LCELL(inst_aI2_apc_mux_x_a0_a_a8 & rtl_a452 # !inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI1_aMux_287_a32 & inst6_aaltsyncram_component_aq_a_a13_a # !inst_aI1_aMux_287_a32 & rtl_a452))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ACAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a452,
	datab => inst6_aaltsyncram_component_aq_a_a13_a,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI1_aMux_287_a32,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a452);

inst_aI1_aMux_268_rtl_225_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_268_rtl_225_a0 = inst_aI2_apc_mux_x_a1_a_a42 & (inst_aI2_apc_mux_x_a0_a_a8 # rtl_a452) # !inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_aadd_185_a9 & !inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AEA4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_apc_mux_x_a1_a_a42,
	datab => inst_aI1_aadd_185_a9,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => rtl_a452,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_268_rtl_225_a0);

inst_aI1_aMux_268_rtl_225_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_268_rtl_225_a1 = inst_aI1_aMux_268_rtl_225_a0 & (inst_aI1_astack_addrs_c_a1_a_a9_a # !inst_aI2_apc_mux_x_a0_a_a8) # !inst_aI1_aMux_268_rtl_225_a0 & inst_aI1_apc_a9_a & inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a1_a_a9_a,
	datab => inst_aI1_apc_a9_a,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI1_aMux_268_rtl_225_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_268_rtl_225_a1);

inst_aI1_astack_addrs_c_a0_a_a9_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a9_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_aMux_268_rtl_225_a1 # !inst_aI2_apc_mux_x_a2_a_a27 & rtl_a2579, GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FA50",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a2579,
	datad => inst_aI1_aMux_268_rtl_225_a1,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a9_a);

inst_aI1_aiaddr_x_a9_a_a358_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a9_a_a358 = inst_aI1_astack_addrs_c_a0_a_a9_a # !inst_aI2_apc_mux_x_a1_a_a42 # !inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a0_a_a9_a,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a9_a_a358);

inst_aI1_aiaddr_x_a9_a_a429_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a9_a_a429 = !inst_aI2_apc_mux_x_a1_a_a42 & (inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a9 # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_apc_a9_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00AC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_aadd_185_a9,
	datab => inst_aI1_apc_a9_a,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a9_a_a429);

inst_aI1_aiaddr_x_a9_a_a428_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a9_a_a428 = inst6_aaltsyncram_component_aq_a_a13_a & inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst6_aaltsyncram_component_aq_a_a13_a,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a9_a_a428);

inst_aI1_aiaddr_x_a9_a_a432_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a9_a_a432 = inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_aiaddr_x_a9_a_a358 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aiaddr_x_a9_a_a429 # inst_aI1_aiaddr_x_a9_a_a428)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DDD8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_aiaddr_x_a9_a_a358,
	datac => inst_aI1_aiaddr_x_a9_a_a429,
	datad => inst_aI1_aiaddr_x_a9_a_a428,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a9_a_a432);

inst6_aaltsyncram_component_aram_block_a0_a_a1_a : cyclone_ram_block 
-- pragma translate_off
GENERIC MAP (
	mem8 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem7 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000010000000010000000100000000000100000000000100000000000100000000000100000000000000000000000000000000000000000100000000000000",
	mem6 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem5 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010100010000000011010001000000000001101010100011010000110101000000110101000000110101000000110101000000100000000010100000000100000001000000001010110101010100",
	mem4 => "00000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem3 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001010100101010100101010001100011010010100010100101101001010010101001010010101001010010101001010010101001100010000001010100001001010001101010101001010101000",
	mem2 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001010101000100010101010101001010001010100100010101000101010011000101010011000101010011000101010011000101001010010101001001000101010101101010101001010101000",
	operation_mode => "rom",
	ram_block_type => "auto",
	logical_ram_name => "lpm_rom0:inst6|altsyncram:altsyncram_component|ALTSYNCRAM INSTANTIATION",
	init_file => "../rom.mif",
	init_file_layout => "port_a",
	data_interleave_width_in_bits => 1,
	data_interleave_offset_in_bits => 1,
	port_a_write_enable_clock => "none",
	port_a_byte_enable_clock => "none",
	port_a_logical_ram_depth => 1024,
	port_a_logical_ram_width => 14,
	port_a_data_in_clear => "none",
	port_a_address_clear => "none",
	port_a_write_enable_clear => "none",
	port_a_byte_enable_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_out_clear => "none",
	port_a_first_address => 0,
	port_a_last_address => 1023,
	port_a_first_bit_number => 1,
	port_a_data_width => 4,
	port_a_address_width => 10)
-- pragma translate_on
PORT MAP (
	clk0 => UCLK_acombout,
	ena0 => VCC,
	portaaddr => ww_inst6_aaltsyncram_component_aram_block_a0_a_a1_a_aaddress,
	devclrn => devclrn,
	devpor => devpor,
	portadataout => ww_inst6_aaltsyncram_component_aram_block_a0_a_a1_a_adataout);

inst_aI1_aiaddr_x_a8_a_a418_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a8_a_a418 = inst6_aaltsyncram_component_aq_a_a12_a & inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst6_aaltsyncram_component_aq_a_a12_a,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a8_a_a418);

rtl_a2569_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2569 = inst_aI2_apc_mux_x_a1_a_a42 & (inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a8 # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_astack_addrs_c_a0_a_a8_a) # !inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_astack_addrs_c_a0_a_a8_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CAAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a0_a_a8_a,
	datab => inst_aI1_aadd_185_a8,
	datac => inst_aI2_apc_mux_x_a1_a_a42,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2569);

inst_aI1_astack_addrs_c_a7_a_a8_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a7_a_a8_a = DFFEA(inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a6_a_a8_a & !inst_aI2_apc_mux_x_a2_a_a27 # !inst_aI1_aMux_197_rtl_141_a0 & (inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a6_a_a8_a # !inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a7_a_a8_a), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0AAC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a6_a_a8_a,
	datab => inst_aI1_astack_addrs_c_a7_a_a8_a,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a7_a_a8_a);

rtl_a3225_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3225 = inst_aI1_astack_addrs_c_a6_a_a8_a & (inst_aI1_astack_addrs_c_a7_a_a8_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a6_a_a8_a & inst_aI1_astack_addrs_c_a7_a_a8_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a6_a_a8_a,
	datab => inst_aI1_astack_addrs_c_a7_a_a8_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3225);

inst_aI1_astack_addrs_c_a6_a_a8_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a6_a_a8_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a3225 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a5_a_a8_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a5_a_a8_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a3225), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ED48",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a5_a_a8_a,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a3225,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a6_a_a8_a);

rtl_a3125_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3125 = inst_aI1_astack_addrs_c_a6_a_a8_a & (inst_aI1_astack_addrs_c_a5_a_a8_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a6_a_a8_a & inst_aI1_astack_addrs_c_a5_a_a8_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AACC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a6_a_a8_a,
	datab => inst_aI1_astack_addrs_c_a5_a_a8_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3125);

inst_aI1_astack_addrs_c_a5_a_a8_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a5_a_a8_a = DFFEA(inst_aI1_astack_addrs_c_a4_a_a8_a & (rtl_a3125 # inst_aI1_aMux_197_rtl_141_a0 $ inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a4_a_a8_a & rtl_a3125 & (inst_aI1_aMux_197_rtl_141_a0 $ !inst_aI2_apc_mux_x_a2_a_a27), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a4_a_a8_a,
	datab => inst_aI1_aMux_197_rtl_141_a0,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => rtl_a3125,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a5_a_a8_a);

rtl_a3025_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3025 = inst_aI1_astack_addrs_c_a5_a_a8_a & (inst_aI1_astack_addrs_c_a4_a_a8_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a5_a_a8_a & inst_aI1_astack_addrs_c_a4_a_a8_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a5_a_a8_a,
	datac => inst_aI1_astack_addrs_c_a4_a_a8_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3025);

inst_aI1_astack_addrs_c_a4_a_a8_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a4_a_a8_a = DFFEA(inst_aI1_astack_addrs_c_a3_a_a8_a & (rtl_a3025 # inst_aI1_aMux_197_rtl_141_a0 $ inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a3_a_a8_a & rtl_a3025 & (inst_aI1_aMux_197_rtl_141_a0 $ !inst_aI2_apc_mux_x_a2_a_a27), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a3_a_a8_a,
	datab => inst_aI1_aMux_197_rtl_141_a0,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => rtl_a3025,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a4_a_a8_a);

rtl_a2925_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2925 = inst_aI1_astack_addrs_c_a4_a_a8_a & (inst_aI1_astack_addrs_c_a3_a_a8_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a4_a_a8_a & inst_aI1_astack_addrs_c_a3_a_a8_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a4_a_a8_a,
	datac => inst_aI1_astack_addrs_c_a3_a_a8_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2925);

inst_aI1_astack_addrs_c_a3_a_a8_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a8_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a2925 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a2_a_a8_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a2_a_a8_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a2925), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ED48",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a2_a_a8_a,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a2925,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a8_a);

rtl_a2825_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2825 = inst_aI1_astack_addrs_c_a2_a_a8_a & (inst_aI1_astack_addrs_c_a3_a_a8_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a2_a_a8_a & inst_aI1_astack_addrs_c_a3_a_a8_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a2_a_a8_a,
	datac => inst_aI1_astack_addrs_c_a3_a_a8_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2825);

inst_aI1_astack_addrs_c_a2_a_a8_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a8_a = DFFEA(inst_aI1_astack_addrs_c_a1_a_a8_a & (rtl_a2825 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a1_a_a8_a & rtl_a2825 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CAAC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a1_a_a8_a,
	datab => rtl_a2825,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a8_a);

rtl_a2685_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2685 = inst_aI1_astack_addrs_c_a1_a_a8_a & (inst_aI1_astack_addrs_c_a2_a_a8_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a1_a_a8_a & inst_aI1_astack_addrs_c_a2_a_a8_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CACA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a1_a_a8_a,
	datab => inst_aI1_astack_addrs_c_a2_a_a8_a,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2685);

inst_aI1_astack_addrs_c_a1_a_a8_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a8_a = DFFEA(inst_aI1_astack_addrs_c_a0_a_a8_a & (rtl_a2685 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a0_a_a8_a & rtl_a2685 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2B8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a0_a_a8_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a2685,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a8_a);

rtl_a992 : cyclone_lcell 
-- Equation(s):
-- rtl_a451 = LCELL(inst_aI1_aMux_287_a32 & (inst_aI2_apc_mux_x_a0_a_a8 & rtl_a451 # !inst_aI2_apc_mux_x_a0_a_a8 & inst6_aaltsyncram_component_aq_a_a12_a) # !inst_aI1_aMux_287_a32 & rtl_a451)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AACA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a451,
	datab => inst6_aaltsyncram_component_aq_a_a12_a,
	datac => inst_aI1_aMux_287_a32,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a451);

inst_aI1_aMux_269_rtl_222_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_269_rtl_222_a0 = inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI1_apc_a8_a # inst_aI2_apc_mux_x_a1_a_a42) # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a8 & !inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FA0C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_apc_a8_a,
	datab => inst_aI1_aadd_185_a8,
	datac => inst_aI2_apc_mux_x_a1_a_a42,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_269_rtl_222_a0);

inst_aI1_aMux_269_rtl_222_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_269_rtl_222_a1 = inst_aI1_aMux_269_rtl_222_a0 & (inst_aI1_astack_addrs_c_a1_a_a8_a # !inst_aI2_apc_mux_x_a1_a_a42) # !inst_aI1_aMux_269_rtl_222_a0 & rtl_a451 & inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a1_a_a8_a,
	datab => rtl_a451,
	datac => inst_aI2_apc_mux_x_a1_a_a42,
	datad => inst_aI1_aMux_269_rtl_222_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_269_rtl_222_a1);

inst_aI1_astack_addrs_c_a0_a_a8_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a8_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_aMux_269_rtl_222_a1 # !inst_aI2_apc_mux_x_a2_a_a27 & rtl_a2569, GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FC30",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a2569,
	datad => inst_aI1_aMux_269_rtl_222_a1,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a8_a);

inst_aI1_aiaddr_x_a8_a_a349_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a8_a_a349 = inst_aI1_astack_addrs_c_a0_a_a8_a # !inst_aI2_apc_mux_x_a0_a_a8 # !inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a0_a_a8_a,
	datac => inst_aI2_apc_mux_x_a1_a_a42,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a8_a_a349);

inst_aI1_aiaddr_x_a8_a_a419_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a8_a_a419 = !inst_aI2_apc_mux_x_a1_a_a42 & (inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a8 # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_apc_a8_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0C0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_apc_a8_a,
	datab => inst_aI1_aadd_185_a8,
	datac => inst_aI2_apc_mux_x_a1_a_a42,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a8_a_a419);

inst_aI1_aiaddr_x_a8_a_a422_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a8_a_a422 = inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_aiaddr_x_a8_a_a349 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aiaddr_x_a8_a_a418 # inst_aI1_aiaddr_x_a8_a_a419)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F3E2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_aiaddr_x_a8_a_a418,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aiaddr_x_a8_a_a349,
	datad => inst_aI1_aiaddr_x_a8_a_a419,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a8_a_a422);

inst_aI1_aiaddr_x_a7_a_a408_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a7_a_a408 = inst6_aaltsyncram_component_aq_a_a11_a & inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst6_aaltsyncram_component_aq_a_a11_a,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a7_a_a408);

inst_aI1_aiaddr_x_a7_a_a409_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a7_a_a409 = !inst_aI2_apc_mux_x_a1_a_a42 & (inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a7 # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_apc_a7_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00AC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_aadd_185_a7,
	datab => inst_aI1_apc_a7_a,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a7_a_a409);

rtl_a2559_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2559 = inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_aadd_185_a7 # !inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_astack_addrs_c_a0_a_a7_a) # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_astack_addrs_c_a0_a_a7_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a0_a_a7_a,
	datab => inst_aI2_apc_mux_x_a0_a_a8,
	datac => inst_aI1_aadd_185_a7,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2559);

inst_aI1_astack_addrs_c_a7_a_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a7_a_a7_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a6_a_a7_a & !inst_aI1_aMux_197_rtl_141_a0 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a6_a_a7_a # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a7_a_a7_a), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "44D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a6_a_a7_a,
	datac => inst_aI1_astack_addrs_c_a7_a_a7_a,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a7_a_a7_a);

rtl_a3215_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3215 = inst_aI1_astack_addrs_c_a6_a_a7_a & (inst_aI1_astack_addrs_c_a7_a_a7_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a6_a_a7_a & inst_aI1_astack_addrs_c_a7_a_a7_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a6_a_a7_a,
	datac => inst_aI1_astack_addrs_c_a7_a_a7_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3215);

inst_aI1_astack_addrs_c_a6_a_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a6_a_a7_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a3215 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a5_a_a7_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a5_a_a7_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a3215), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a5_a_a7_a,
	datac => rtl_a3215,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a6_a_a7_a);

rtl_a3115_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3115 = inst_aI1_astack_addrs_c_a6_a_a7_a & (inst_aI1_astack_addrs_c_a5_a_a7_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a6_a_a7_a & inst_aI1_astack_addrs_c_a5_a_a7_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AACC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a6_a_a7_a,
	datab => inst_aI1_astack_addrs_c_a5_a_a7_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3115);

inst_aI1_astack_addrs_c_a5_a_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a5_a_a7_a = DFFEA(inst_aI1_astack_addrs_c_a4_a_a7_a & (rtl_a3115 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a4_a_a7_a & rtl_a3115 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2B8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a4_a_a7_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a3115,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a5_a_a7_a);

rtl_a3015_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3015 = inst_aI1_astack_addrs_c_a5_a_a7_a & (inst_aI1_astack_addrs_c_a4_a_a7_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a5_a_a7_a & inst_aI1_astack_addrs_c_a4_a_a7_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a5_a_a7_a,
	datac => inst_aI1_astack_addrs_c_a4_a_a7_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3015);

inst_aI1_astack_addrs_c_a4_a_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a4_a_a7_a = DFFEA(inst_aI1_astack_addrs_c_a3_a_a7_a & (rtl_a3015 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a3_a_a7_a & rtl_a3015 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a3_a_a7_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a3015,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a4_a_a7_a);

rtl_a2915_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2915 = inst_aI1_astack_addrs_c_a3_a_a7_a & (inst_aI1_astack_addrs_c_a4_a_a7_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a3_a_a7_a & inst_aI1_astack_addrs_c_a4_a_a7_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a3_a_a7_a,
	datac => inst_aI1_astack_addrs_c_a4_a_a7_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2915);

inst_aI1_astack_addrs_c_a3_a_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a7_a = DFFEA(inst_aI1_astack_addrs_c_a2_a_a7_a & (rtl_a2915 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a2_a_a7_a & rtl_a2915 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a2_a_a7_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a2915,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a7_a);

rtl_a2815_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2815 = inst_aI1_astack_addrs_c_a3_a_a7_a & (inst_aI1_astack_addrs_c_a2_a_a7_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a3_a_a7_a & inst_aI1_astack_addrs_c_a2_a_a7_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a3_a_a7_a,
	datac => inst_aI1_astack_addrs_c_a2_a_a7_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2815);

inst_aI1_astack_addrs_c_a2_a_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a7_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a2815 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a1_a_a7_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a1_a_a7_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a2815), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a1_a_a7_a,
	datac => rtl_a2815,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a7_a);

rtl_a2675_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2675 = inst_aI1_astack_addrs_c_a2_a_a7_a & (inst_aI1_astack_addrs_c_a1_a_a7_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a2_a_a7_a & inst_aI1_astack_addrs_c_a1_a_a7_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ACAC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a2_a_a7_a,
	datab => inst_aI1_astack_addrs_c_a1_a_a7_a,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2675);

inst_aI1_astack_addrs_c_a1_a_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a7_a = DFFEA(inst_aI1_astack_addrs_c_a0_a_a7_a & (rtl_a2675 # inst_aI1_aMux_197_rtl_141_a0 $ inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a0_a_a7_a & rtl_a2675 & (inst_aI1_aMux_197_rtl_141_a0 $ !inst_aI2_apc_mux_x_a2_a_a27), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CAAC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a0_a_a7_a,
	datab => rtl_a2675,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a7_a);

rtl_a983 : cyclone_lcell 
-- Equation(s):
-- rtl_a450 = LCELL(inst_aI2_apc_mux_x_a0_a_a8 & rtl_a450 # !inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI1_aMux_287_a32 & inst6_aaltsyncram_component_aq_a_a11_a # !inst_aI1_aMux_287_a32 & rtl_a450))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ACAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a450,
	datab => inst6_aaltsyncram_component_aq_a_a11_a,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI1_aMux_287_a32,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a450);

inst_aI1_aMux_270_rtl_219_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_270_rtl_219_a0 = inst_aI2_apc_mux_x_a1_a_a42 & (inst_aI2_apc_mux_x_a0_a_a8 # rtl_a450) # !inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_aadd_185_a7 & !inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CEC2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_aadd_185_a7,
	datab => inst_aI2_apc_mux_x_a1_a_a42,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => rtl_a450,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_270_rtl_219_a0);

inst_aI1_aMux_270_rtl_219_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_270_rtl_219_a1 = inst_aI1_aMux_270_rtl_219_a0 & (inst_aI1_astack_addrs_c_a1_a_a7_a # !inst_aI2_apc_mux_x_a0_a_a8) # !inst_aI1_aMux_270_rtl_219_a0 & inst_aI1_apc_a7_a & inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a1_a_a7_a,
	datab => inst_aI1_apc_a7_a,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI1_aMux_270_rtl_219_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_270_rtl_219_a1);

inst_aI1_astack_addrs_c_a0_a_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a7_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_aMux_270_rtl_219_a1 # !inst_aI2_apc_mux_x_a2_a_a27 & rtl_a2559, GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FC30",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a2559,
	datad => inst_aI1_aMux_270_rtl_219_a1,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a7_a);

inst_aI1_aiaddr_x_a7_a_a340_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a7_a_a340 = inst_aI1_astack_addrs_c_a0_a_a7_a # !inst_aI2_apc_mux_x_a1_a_a42 # !inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a0_a_a7_a,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a7_a_a340);

inst_aI1_aiaddr_x_a7_a_a412_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a7_a_a412 = inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_aiaddr_x_a7_a_a340 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aiaddr_x_a7_a_a408 # inst_aI1_aiaddr_x_a7_a_a409)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FE32",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_aiaddr_x_a7_a_a408,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aiaddr_x_a7_a_a409,
	datad => inst_aI1_aiaddr_x_a7_a_a340,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a7_a_a412);

rtl_a974 : cyclone_lcell 
-- Equation(s):
-- rtl_a449 = LCELL(inst_aI1_aMux_287_a32 & (inst_aI2_apc_mux_x_a0_a_a8 & rtl_a449 # !inst_aI2_apc_mux_x_a0_a_a8 & inst6_aaltsyncram_component_aq_a_a10_a) # !inst_aI1_aMux_287_a32 & rtl_a449)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAE2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a449,
	datab => inst_aI1_aMux_287_a32,
	datac => inst6_aaltsyncram_component_aq_a_a10_a,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a449);

inst_aI1_aMux_271_rtl_216_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_271_rtl_216_a0 = inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI1_apc_a6_a # inst_aI2_apc_mux_x_a1_a_a42) # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a6 & !inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FA0C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_apc_a6_a,
	datab => inst_aI1_aadd_185_a6,
	datac => inst_aI2_apc_mux_x_a1_a_a42,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_271_rtl_216_a0);

inst_aI1_aMux_271_rtl_216_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_271_rtl_216_a1 = inst_aI1_aMux_271_rtl_216_a0 & (inst_aI1_astack_addrs_c_a1_a_a6_a # !inst_aI2_apc_mux_x_a1_a_a42) # !inst_aI1_aMux_271_rtl_216_a0 & inst_aI2_apc_mux_x_a1_a_a42 & rtl_a449

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BBC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a1_a_a6_a,
	datab => inst_aI2_apc_mux_x_a1_a_a42,
	datac => rtl_a449,
	datad => inst_aI1_aMux_271_rtl_216_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_271_rtl_216_a1);

inst_aI1_astack_addrs_c_a0_a_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a6_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_aMux_271_rtl_216_a1 # !inst_aI2_apc_mux_x_a2_a_a27 & rtl_a2549, GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FC30",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a2549,
	datad => inst_aI1_aMux_271_rtl_216_a1,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a6_a);

inst_aI1_aiaddr_x_a6_a_a331_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a6_a_a331 = inst_aI1_astack_addrs_c_a0_a_a6_a # !inst_aI2_apc_mux_x_a0_a_a8 # !inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a0_a_a6_a,
	datac => inst_aI2_apc_mux_x_a1_a_a42,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a6_a_a331);

inst_aI1_aiaddr_x_a6_a_a398_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a6_a_a398 = inst_aI2_apc_mux_x_a1_a_a42 & inst6_aaltsyncram_component_aq_a_a10_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI2_apc_mux_x_a1_a_a42,
	datad => inst6_aaltsyncram_component_aq_a_a10_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a6_a_a398);

inst_aI1_aiaddr_x_a6_a_a402_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a6_a_a402 = inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_aiaddr_x_a6_a_a331 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aiaddr_x_a6_a_a399 # inst_aI1_aiaddr_x_a6_a_a398)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F3E2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_aiaddr_x_a6_a_a399,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aiaddr_x_a6_a_a331,
	datad => inst_aI1_aiaddr_x_a6_a_a398,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a6_a_a402);

rtl_a965 : cyclone_lcell 
-- Equation(s):
-- rtl_a448 = LCELL(inst_aI2_apc_mux_x_a0_a_a8 & rtl_a448 # !inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI1_aMux_287_a32 & inst6_aaltsyncram_component_aq_a_a9_a # !inst_aI1_aMux_287_a32 & rtl_a448))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CACC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_aaltsyncram_component_aq_a_a9_a,
	datab => rtl_a448,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI1_aMux_287_a32,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a448);

inst_aI1_aMux_272_rtl_213_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_272_rtl_213_a0 = inst_aI2_apc_mux_x_a1_a_a42 & (inst_aI2_apc_mux_x_a0_a_a8 # rtl_a448) # !inst_aI2_apc_mux_x_a1_a_a42 & !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a5

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DC98",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_apc_mux_x_a0_a_a8,
	datab => inst_aI2_apc_mux_x_a1_a_a42,
	datac => inst_aI1_aadd_185_a5,
	datad => rtl_a448,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_272_rtl_213_a0);

inst_aI1_aMux_272_rtl_213_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_272_rtl_213_a1 = inst_aI1_aMux_272_rtl_213_a0 & (inst_aI1_astack_addrs_c_a1_a_a5_a # !inst_aI2_apc_mux_x_a0_a_a8) # !inst_aI1_aMux_272_rtl_213_a0 & inst_aI1_apc_a5_a & inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a1_a_a5_a,
	datab => inst_aI1_apc_a5_a,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI1_aMux_272_rtl_213_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_272_rtl_213_a1);

inst_aI1_astack_addrs_c_a0_a_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a5_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_aMux_272_rtl_213_a1 # !inst_aI2_apc_mux_x_a2_a_a27 & rtl_a2539, GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FC30",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a2539,
	datad => inst_aI1_aMux_272_rtl_213_a1,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a5_a);

inst_aI1_aiaddr_x_a5_a_a322_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a5_a_a322 = inst_aI1_astack_addrs_c_a0_a_a5_a # !inst_aI2_apc_mux_x_a0_a_a8 # !inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CFFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a0_a_a5_a,
	datac => inst_aI2_apc_mux_x_a1_a_a42,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a5_a_a322);

inst_aI1_aiaddr_x_a5_a_a388_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a5_a_a388 = inst6_aaltsyncram_component_aq_a_a9_a & inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst6_aaltsyncram_component_aq_a_a9_a,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a5_a_a388);

inst_aI1_aiaddr_x_a5_a_a389_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a5_a_a389 = !inst_aI2_apc_mux_x_a1_a_a42 & (inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a5 # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_apc_a5_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0C0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_apc_a5_a,
	datab => inst_aI1_aadd_185_a5,
	datac => inst_aI2_apc_mux_x_a1_a_a42,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a5_a_a389);

inst_aI1_aiaddr_x_a5_a_a392_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a5_a_a392 = inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_aiaddr_x_a5_a_a322 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aiaddr_x_a5_a_a388 # inst_aI1_aiaddr_x_a5_a_a389)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DDD8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_aiaddr_x_a5_a_a322,
	datac => inst_aI1_aiaddr_x_a5_a_a388,
	datad => inst_aI1_aiaddr_x_a5_a_a389,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a5_a_a392);

rtl_a956 : cyclone_lcell 
-- Equation(s):
-- rtl_a447 = LCELL(inst_aI1_aMux_287_a32 & (inst_aI2_apc_mux_x_a0_a_a8 & rtl_a447 # !inst_aI2_apc_mux_x_a0_a_a8 & inst6_aaltsyncram_component_aq_a_a8_a) # !inst_aI1_aMux_287_a32 & rtl_a447)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCAC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_aaltsyncram_component_aq_a_a8_a,
	datab => rtl_a447,
	datac => inst_aI1_aMux_287_a32,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a447);

inst_aI1_aMux_273_rtl_210_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_273_rtl_210_a0 = inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI1_apc_a4_a # inst_aI2_apc_mux_x_a1_a_a42) # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a4 & !inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_aadd_185_a4,
	datab => inst_aI1_apc_a4_a,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_273_rtl_210_a0);

inst_aI1_aMux_273_rtl_210_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_273_rtl_210_a1 = inst_aI1_aMux_273_rtl_210_a0 & (inst_aI1_astack_addrs_c_a1_a_a4_a # !inst_aI2_apc_mux_x_a1_a_a42) # !inst_aI1_aMux_273_rtl_210_a0 & inst_aI2_apc_mux_x_a1_a_a42 & rtl_a447

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BBC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a1_a_a4_a,
	datab => inst_aI2_apc_mux_x_a1_a_a42,
	datac => rtl_a447,
	datad => inst_aI1_aMux_273_rtl_210_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_273_rtl_210_a1);

inst_aI1_astack_addrs_c_a0_a_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a4_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_aMux_273_rtl_210_a1 # !inst_aI2_apc_mux_x_a2_a_a27 & rtl_a2529, GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FC30",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a2529,
	datad => inst_aI1_aMux_273_rtl_210_a1,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a4_a);

inst_aI1_aiaddr_x_a4_a_a313_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a4_a_a313 = inst_aI1_astack_addrs_c_a0_a_a4_a # !inst_aI2_apc_mux_x_a1_a_a42 # !inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CFFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a0_a_a4_a,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a4_a_a313);

inst_aI1_aiaddr_x_a4_a_a378_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a4_a_a378 = inst6_aaltsyncram_component_aq_a_a8_a & inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CC00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst6_aaltsyncram_component_aq_a_a8_a,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a4_a_a378);

inst_aI1_aiaddr_x_a4_a_a382_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a4_a_a382 = inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_aiaddr_x_a4_a_a313 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aiaddr_x_a4_a_a379 # inst_aI1_aiaddr_x_a4_a_a378)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F3E2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_aiaddr_x_a4_a_a379,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aiaddr_x_a4_a_a313,
	datad => inst_aI1_aiaddr_x_a4_a_a378,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a4_a_a382);

inst6_aaltsyncram_component_aram_block_a0_a_a4_a : cyclone_ram_block 
-- pragma translate_off
GENERIC MAP (
	mem8 => "00000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem7 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000100111000000100000110101100000000001000000010000000101010000000101010000010111011000000101010010000010000001010000000000100000001100100000010000001",
	mem6 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem5 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110101000100100011010100000100100001101000000011010100110100101100110110111001110100101100110100101000110100000000000000100000000100000000001010000001010001",
	mem4 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem3 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000001010011000000000000010001100000011011000000110000011010011000001000110000001000110000001000010000110000110100111110110110000000001000110110011000010",
	mem2 => "00000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110100100101010001010010011101001000101000000001010100010100101100010100101100010100101100010110111101010100100010010000101101000010011010010011100100100010",
	operation_mode => "rom",
	ram_block_type => "auto",
	logical_ram_name => "lpm_rom0:inst6|altsyncram:altsyncram_component|ALTSYNCRAM INSTANTIATION",
	init_file => "../rom.mif",
	init_file_layout => "port_a",
	data_interleave_width_in_bits => 1,
	data_interleave_offset_in_bits => 1,
	port_a_write_enable_clock => "none",
	port_a_byte_enable_clock => "none",
	port_a_logical_ram_depth => 1024,
	port_a_logical_ram_width => 14,
	port_a_data_in_clear => "none",
	port_a_address_clear => "none",
	port_a_write_enable_clear => "none",
	port_a_byte_enable_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_out_clear => "none",
	port_a_first_address => 0,
	port_a_last_address => 1023,
	port_a_first_bit_number => 4,
	port_a_data_width => 4,
	port_a_address_width => 10)
-- pragma translate_on
PORT MAP (
	clk0 => UCLK_acombout,
	ena0 => VCC,
	portaaddr => ww_inst6_aaltsyncram_component_aram_block_a0_a_a4_a_aaddress,
	devclrn => devclrn,
	devpor => devpor,
	portadataout => ww_inst6_aaltsyncram_component_aram_block_a0_a_a4_a_adataout);

rtl_a947 : cyclone_lcell 
-- Equation(s):
-- rtl_a446 = LCELL(inst_aI1_aMux_287_a32 & (inst_aI2_apc_mux_x_a0_a_a8 & rtl_a446 # !inst_aI2_apc_mux_x_a0_a_a8 & inst6_aaltsyncram_component_aq_a_a7_a) # !inst_aI1_aMux_287_a32 & rtl_a446)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AACA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a446,
	datab => inst6_aaltsyncram_component_aq_a_a7_a,
	datac => inst_aI1_aMux_287_a32,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a446);

inst_aI1_aMux_274_rtl_207_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_274_rtl_207_a0 = inst_aI2_apc_mux_x_a1_a_a42 & (rtl_a446 # inst_aI2_apc_mux_x_a0_a_a8) # !inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_aadd_185_a3 & !inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0AC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a446,
	datab => inst_aI1_aadd_185_a3,
	datac => inst_aI2_apc_mux_x_a1_a_a42,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_274_rtl_207_a0);

inst_aI1_aMux_274_rtl_207_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_274_rtl_207_a1 = inst_aI1_aMux_274_rtl_207_a0 & (inst_aI1_astack_addrs_c_a1_a_a3_a # !inst_aI2_apc_mux_x_a0_a_a8) # !inst_aI1_aMux_274_rtl_207_a0 & inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_apc_a3_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F588",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_apc_mux_x_a0_a_a8,
	datab => inst_aI1_apc_a3_a,
	datac => inst_aI1_astack_addrs_c_a1_a_a3_a,
	datad => inst_aI1_aMux_274_rtl_207_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_274_rtl_207_a1);

inst_aI1_astack_addrs_c_a0_a_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a3_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_aMux_274_rtl_207_a1 # !inst_aI2_apc_mux_x_a2_a_a27 & rtl_a2519, GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FA50",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a2519,
	datad => inst_aI1_aMux_274_rtl_207_a1,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a3_a);

inst_aI1_aiaddr_x_a3_a_a304_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a3_a_a304 = inst_aI1_astack_addrs_c_a0_a_a3_a # !inst_aI2_apc_mux_x_a0_a_a8 # !inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a0_a_a3_a,
	datac => inst_aI2_apc_mux_x_a1_a_a42,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a3_a_a304);

inst_aI1_aiaddr_x_a3_a_a368_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a3_a_a368 = inst6_aaltsyncram_component_aq_a_a7_a & inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst6_aaltsyncram_component_aq_a_a7_a,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a3_a_a368);

inst_aI1_aiaddr_x_a3_a_a372_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a3_a_a372 = inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_aiaddr_x_a3_a_a304 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aiaddr_x_a3_a_a369 # inst_aI1_aiaddr_x_a3_a_a368)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F5E4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_aiaddr_x_a3_a_a369,
	datac => inst_aI1_aiaddr_x_a3_a_a304,
	datad => inst_aI1_aiaddr_x_a3_a_a368,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a3_a_a372);

inst_aI2_aMux_66_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aMux_66_a0 = inst6_aaltsyncram_component_aq_a_a6_a & !inst6_aaltsyncram_component_aq_a_a7_a & (!inst6_aaltsyncram_component_aq_a_a4_a # !inst6_aaltsyncram_component_aq_a_a5_a) # !inst6_aaltsyncram_component_aq_a_a6_a & inst6_aaltsyncram_component_aq_a_a5_a & inst6_aaltsyncram_component_aq_a_a7_a & inst6_aaltsyncram_component_aq_a_a4_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "240C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_aaltsyncram_component_aq_a_a5_a,
	datab => inst6_aaltsyncram_component_aq_a_a6_a,
	datac => inst6_aaltsyncram_component_aq_a_a7_a,
	datad => inst6_aaltsyncram_component_aq_a_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aMux_66_a0);

rtl_a14849_I : cyclone_lcell 
-- Equation(s):
-- rtl_a14849 = !inst6_aaltsyncram_component_aq_a_a3_a & !inst6_aaltsyncram_component_aq_a_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "000F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst6_aaltsyncram_component_aq_a_a3_a,
	datad => inst6_aaltsyncram_component_aq_a_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a14849);

inst_aI2_aTD_c_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aTD_c_a2_a = DFFEA(inst6_aaltsyncram_component_aq_a_a2_a # !inst6_aaltsyncram_component_aq_a_a1_a & inst_aI2_aMux_66_a0 & rtl_a14849, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DCCC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst6_aaltsyncram_component_aq_a_a1_a,
	datab => inst6_aaltsyncram_component_aq_a_a2_a,
	datac => inst_aI2_aMux_66_a0,
	datad => rtl_a14849,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_aTD_c_a2_a);

inst_aI2_aMux_67_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aMux_67_a0 = inst6_aaltsyncram_component_aq_a_a6_a & !inst6_aaltsyncram_component_aq_a_a7_a & (inst6_aaltsyncram_component_aq_a_a5_a $ inst6_aaltsyncram_component_aq_a_a4_a) # !inst6_aaltsyncram_component_aq_a_a6_a & inst6_aaltsyncram_component_aq_a_a5_a & (!inst6_aaltsyncram_component_aq_a_a4_a # !inst6_aaltsyncram_component_aq_a_a7_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "062A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_aaltsyncram_component_aq_a_a5_a,
	datab => inst6_aaltsyncram_component_aq_a_a6_a,
	datac => inst6_aaltsyncram_component_aq_a_a7_a,
	datad => inst6_aaltsyncram_component_aq_a_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aMux_67_a0);

inst_aI2_aTD_c_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aTD_c_a1_a = DFFEA(inst6_aaltsyncram_component_aq_a_a1_a # rtl_a14849 & !inst6_aaltsyncram_component_aq_a_a2_a & inst_aI2_aMux_67_a0, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AEAA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst6_aaltsyncram_component_aq_a_a1_a,
	datab => rtl_a14849,
	datac => inst6_aaltsyncram_component_aq_a_a2_a,
	datad => inst_aI2_aMux_67_a0,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_aTD_c_a1_a);

inst_aI4_adaddr_x_a8_a_a4_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adaddr_x_a8_a_a4 = nRESET_acombout & inst6_aaltsyncram_component_aq_a_a12_a & inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => nRESET_acombout,
	datac => inst6_aaltsyncram_component_aq_a_a12_a,
	datad => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adaddr_x_a8_a_a4);

inst_aI4_ai_a1256_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_ai_a1256 = !inst6_aaltsyncram_component_aq_a_a6_a & (inst6_aaltsyncram_component_aq_a_a5_a $ inst6_aaltsyncram_component_aq_a_a4_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0330",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst6_aaltsyncram_component_aq_a_a6_a,
	datac => inst6_aaltsyncram_component_aq_a_a5_a,
	datad => inst6_aaltsyncram_component_aq_a_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_ai_a1256);

inst_aI4_ai_a1234_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_ai_a1234 = !inst6_aaltsyncram_component_aq_a_a11_a & !inst6_aaltsyncram_component_aq_a_a13_a & !inst6_aaltsyncram_component_aq_a_a7_a & !inst6_aaltsyncram_component_aq_a_a12_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0001",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_aaltsyncram_component_aq_a_a11_a,
	datab => inst6_aaltsyncram_component_aq_a_a13_a,
	datac => inst6_aaltsyncram_component_aq_a_a7_a,
	datad => inst6_aaltsyncram_component_aq_a_a12_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_ai_a1234);

inst_aI4_ai_a1250_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_ai_a1250 = !inst6_aaltsyncram_component_aq_a_a8_a & !inst6_aaltsyncram_component_aq_a_a10_a & !inst6_aaltsyncram_component_aq_a_a9_a & inst_aI4_ai_a1234

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0100",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_aaltsyncram_component_aq_a_a8_a,
	datab => inst6_aaltsyncram_component_aq_a_a10_a,
	datac => inst6_aaltsyncram_component_aq_a_a9_a,
	datad => inst_aI4_ai_a1234,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_ai_a1250);

inst_aI2_aTC_x_a2_a_a108_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aTC_x_a2_a_a108 = inst6_aaltsyncram_component_aq_a_a6_a & inst6_aaltsyncram_component_aq_a_a7_a & !inst6_aaltsyncram_component_aq_a_a5_a & !inst6_aaltsyncram_component_aq_a_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0008",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_aaltsyncram_component_aq_a_a6_a,
	datab => inst6_aaltsyncram_component_aq_a_a7_a,
	datac => inst6_aaltsyncram_component_aq_a_a5_a,
	datad => inst6_aaltsyncram_component_aq_a_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aTC_x_a2_a_a108);

inst_aI2_aTD_x_a3_a_a9_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aTD_x_a3_a_a9 = !inst6_aaltsyncram_component_aq_a_a1_a & !inst6_aaltsyncram_component_aq_a_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "000F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst6_aaltsyncram_component_aq_a_a1_a,
	datad => inst6_aaltsyncram_component_aq_a_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aTD_x_a3_a_a9);

inst_aI2_aTC_x_a2_a_a112_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aTC_x_a2_a_a112 = nRESET_acombout & inst_aI2_aTD_x_a3_a_a9 & (inst6_aaltsyncram_component_aq_a_a3_a # inst_aI2_aTC_x_a2_a_a108)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_aaltsyncram_component_aq_a_a3_a,
	datab => nRESET_acombout,
	datac => inst_aI2_aTC_x_a2_a_a108,
	datad => inst_aI2_aTD_x_a3_a_a9,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aTC_x_a2_a_a112);

inst_aI2_aC_store_x_a24_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aC_store_x_a24 = inst_aI2_ai_a326 & inst_aI2_aTC_x_a0_a_a119 & !inst_aI3_ai_a85 & !inst_aI2_aTC_x_a2_a_a112

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0008",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_ai_a326,
	datab => inst_aI2_aTC_x_a0_a_a119,
	datac => inst_aI3_ai_a85,
	datad => inst_aI2_aTC_x_a2_a_a112,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aC_store_x_a24);

inst_aI4_ai_a20_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_ai_a20 = inst_aI4_ai_a1250 & inst_aI2_aC_store_x_a24 & inst_aI2_andre_x_a44

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI4_ai_a1250,
	datac => inst_aI2_aC_store_x_a24,
	datad => inst_aI2_andre_x_a44,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_ai_a20);

inst_aI2_aC_store_x_a32_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aC_store_x_a32 = !inst_aI2_aTC_x_a2_a_a112 & inst_aI2_aTC_x_a0_a_a119

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI2_aTC_x_a2_a_a112,
	datad => inst_aI2_aTC_x_a0_a_a119,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aC_store_x_a32);

inst_aI2_aC_mem_x_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aC_mem_x_a0 = inst_aI3_ai_a85 # inst_aI2_aTC_x_a1_a_a22 # !inst_aI2_aC_store_x_a32 # !inst_aI2_ai_a326

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FBFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_ai_a85,
	datab => inst_aI2_ai_a326,
	datac => inst_aI2_aTC_x_a1_a_a22,
	datad => inst_aI2_aC_store_x_a32,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aC_mem_x_a0);

inst_aI2_andre_x_a43_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_andre_x_a43 = !inst_aI2_aC_mem_x_a0 & inst_aI2_andre_x_a44 & (!inst_aI2_aC_store_x_a24 # !inst_aI2_aTC_x_a1_a_a22)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0700",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_x_a1_a_a22,
	datab => inst_aI2_aC_store_x_a24,
	datac => inst_aI2_aC_mem_x_a0,
	datad => inst_aI2_andre_x_a44,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_andre_x_a43);

inst_aI4_andre_x_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_andre_x_a1 = inst_aI4_ai_a1256 & inst_aI4_ai_a20 # !inst_aI2_andre_x_a43 # !inst_aI4_ai_a18

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "D5FF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_ai_a18,
	datab => inst_aI4_ai_a1256,
	datac => inst_aI4_ai_a20,
	datad => inst_aI2_andre_x_a43,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_andre_x_a1);

inst_aI5_adaddr_c_a8_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI5_ai_a24 = inst_aI4_andre_x_a1 & Q1_daddr_c[8] # !inst_aI4_andre_x_a1 & inst_aI4_ai_a18 & inst6_aaltsyncram_component_aq_a_a12_a
-- inst_aI5_adaddr_c_a8_a = DFFEA(inst_aI4_adaddr_x_a8_a_a4, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "F088",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_ai_a18,
	datab => inst6_aaltsyncram_component_aq_a_a12_a,
	datac => inst_aI4_adaddr_x_a8_a_a4,
	datad => inst_aI4_andre_x_a1,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI5_ai_a24,
	regout => inst_aI5_adaddr_c_a8_a);

inst_aI4_ai_a133_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_ai_a133 = !inst6_aaltsyncram_component_aq_a_a4_a & !inst6_aaltsyncram_component_aq_a_a5_a & !inst6_aaltsyncram_component_aq_a_a6_a & inst_aI4_ai_a20

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0100",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_aaltsyncram_component_aq_a_a4_a,
	datab => inst6_aaltsyncram_component_aq_a_a5_a,
	datac => inst6_aaltsyncram_component_aq_a_a6_a,
	datad => inst_aI4_ai_a20,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_ai_a133);

inst_aI2_aS_c_a9_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aS_c_a9 = DFFEA(!inst_aI2_aE_x_aint_e_a0 & (inst_aI2_aS_c_a9 # inst_aI2_aint_stop_x_a10) # !inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3F3B",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aS_c_a9,
	datab => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a,
	datac => inst_aI2_aE_x_aint_e_a0,
	datad => inst_aI2_aint_stop_x_a10,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_aS_c_a9);

inst_aI2_ai_a352_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_ai_a352 = !inst_aI2_aint_stop_c & inst_aI2_aS_c_a9

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI2_aint_stop_c,
	datad => inst_aI2_aS_c_a9,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_ai_a352);

inst_aI2_andwe_x_a51_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_andwe_x_a51 = inst_aI2_aTC_x_a1_a_a22 & inst_aI2_apc_mux_x_a1_a_a170 & inst_aI2_aC_store_x_a32 & inst_aI2_andre_x_a44

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_x_a1_a_a22,
	datab => inst_aI2_apc_mux_x_a1_a_a170,
	datac => inst_aI2_aC_store_x_a32,
	datad => inst_aI2_andre_x_a44,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_andwe_x_a51);

inst_aI5_andwe_c_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI5_andwe_c = DFFEA(inst_aI4_ai_a18 & inst_aI2_andwe_x_a51 & (!inst_aI4_ai_a20 # !inst_aI4_ai_a1256), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "40C0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_ai_a1256,
	datab => inst_aI4_ai_a18,
	datac => inst_aI2_andwe_x_a51,
	datad => inst_aI4_ai_a20,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI5_andwe_c);

inst1_ai_a457_I : cyclone_lcell 
-- Equation(s):
-- inst1_ai_a457 = nRESET_acombout & inst_aI5_andwe_c

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => nRESET_acombout,
	datad => inst_aI5_andwe_c,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_ai_a457);

inst_aI4_areduce_nor_106_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_areduce_nor_106 = inst6_aaltsyncram_component_aq_a_a6_a # inst6_aaltsyncram_component_aq_a_a5_a # !inst6_aaltsyncram_component_aq_a_a4_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF3",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst6_aaltsyncram_component_aq_a_a4_a,
	datac => inst6_aaltsyncram_component_aq_a_a6_a,
	datad => inst6_aaltsyncram_component_aq_a_a5_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_areduce_nor_106);

inst_aI4_aireg_we_c_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aireg_we_c = DFFEA(!inst_aI4_areduce_nor_106 & inst_aI4_ai_a18 & inst_aI4_ai_a20 & inst_aI2_andwe_x_a51, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_areduce_nor_106,
	datab => inst_aI4_ai_a18,
	datac => inst_aI4_ai_a20,
	datad => inst_aI2_andwe_x_a51,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aireg_we_c);

inst_aI4_areduce_nor_103_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_areduce_nor_103 = inst6_aaltsyncram_component_aq_a_a5_a # inst6_aaltsyncram_component_aq_a_a6_a # inst6_aaltsyncram_component_aq_a_a4_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFFC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst6_aaltsyncram_component_aq_a_a5_a,
	datac => inst6_aaltsyncram_component_aq_a_a6_a,
	datad => inst6_aaltsyncram_component_aq_a_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_areduce_nor_103);

inst_aI4_areduce_nor_119_a19_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_areduce_nor_119_a19 = inst6_aaltsyncram_component_aq_a_a6_a # inst6_aaltsyncram_component_aq_a_a4_a # !inst6_aaltsyncram_component_aq_a_a5_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF3",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst6_aaltsyncram_component_aq_a_a5_a,
	datac => inst6_aaltsyncram_component_aq_a_a6_a,
	datad => inst6_aaltsyncram_component_aq_a_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_areduce_nor_119_a19);

inst_aI4_aiinc_we_c_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aiinc_we_c = DFFEA(inst_aI4_ai_a18 & !inst_aI4_areduce_nor_119_a19 & inst_aI4_ai_a20 & inst_aI2_andwe_x_a51, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_ai_a18,
	datab => inst_aI4_areduce_nor_119_a19,
	datac => inst_aI4_ai_a20,
	datad => inst_aI2_andwe_x_a51,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aiinc_we_c);

inst_aI4_aireg_i_a0_a_a6_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aireg_i_a0_a_a6 = nRESET_acombout & inst_aI2_aint_start_c

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => nRESET_acombout,
	datad => inst_aI2_aint_start_c,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aireg_i_a0_a_a6);

inst_aI4_aiinc_i_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aiinc_x_a0_a_a23 = inst_aI4_aiinc_we_c & inst_aI3_aacc_c_a0_a_a0_a # !inst_aI4_aiinc_we_c & inst_aI4_aiinc_c_a0_a & inst_aI4_ai_a18
-- inst_aI4_aiinc_i_a0_a = DFFEA(inst_aI4_aiinc_x_a0_a_a23, GLOBAL(UCLK_acombout), VCC, , inst_aI4_aireg_i_a0_a_a6, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CAC0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aiinc_c_a0_a,
	datab => inst_aI3_aacc_c_a0_a_a0_a,
	datac => inst_aI4_aiinc_we_c,
	datad => inst_aI4_ai_a18,
	aclr => GND,
	ena => inst_aI4_aireg_i_a0_a_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aiinc_x_a0_a_a23,
	regout => inst_aI4_aiinc_i_a0_a);

inst_aI4_aiinc_c_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aiinc_c_a0_a = DFFEA(inst_aI2_aE_x_aint_e_a0 & inst_aI4_aiinc_x_a0_a_a23 # !inst_aI2_aE_x_aint_e_a0 & (inst_aI2_aint_stop_x_a10 & inst_aI4_aiinc_i_a0_a # !inst_aI2_aint_stop_x_a10 & inst_aI4_aiinc_x_a0_a_a23), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EF20",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aiinc_i_a0_a,
	datab => inst_aI2_aE_x_aint_e_a0,
	datac => inst_aI2_aint_stop_x_a10,
	datad => inst_aI4_aiinc_x_a0_a_a23,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aiinc_c_a0_a);

inst_aI4_aadd_104_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_a0 = inst_aI4_aireg_c_a0_a $ inst_aI4_aiinc_c_a0_a
-- inst_aI4_aadd_104_a0COUT0 = CARRY(inst_aI4_aireg_c_a0_a & inst_aI4_aiinc_c_a0_a)
-- inst_aI4_aadd_104_a0COUT1 = CARRY(inst_aI4_aireg_c_a0_a & inst_aI4_aiinc_c_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "6688",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aireg_c_a0_a,
	datab => inst_aI4_aiinc_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_a0,
	cout0 => inst_aI4_aadd_104_a0COUT0,
	cout1 => inst_aI4_aadd_104_a0COUT1);

inst_aI4_aadd_104_rtl_648_a48_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_rtl_648_a48 = inst_aI4_areduce_nor_103 & inst_aI4_aireg_c_a0_a # !inst_aI4_areduce_nor_103 & (inst_aI4_ai_a20 & inst_aI4_aadd_104_a0 # !inst_aI4_ai_a20 & inst_aI4_aireg_c_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_areduce_nor_103,
	datab => inst_aI4_aadd_104_a0,
	datac => inst_aI4_aireg_c_a0_a,
	datad => inst_aI4_ai_a20,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_rtl_648_a48);

inst_aI4_aireg_i_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_rtl_648_a53 = inst_aI4_aireg_we_c & inst_aI3_aacc_c_a0_a_a0_a # !inst_aI4_aireg_we_c & inst_aI4_ai_a18 & inst_aI4_aadd_104_rtl_648_a48
-- inst_aI4_aireg_i_a0_a = DFFEA(inst_aI4_aadd_104_rtl_648_a53, GLOBAL(UCLK_acombout), VCC, , inst_aI4_aireg_i_a0_a_a6, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ACA0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_c_a0_a_a0_a,
	datab => inst_aI4_ai_a18,
	datac => inst_aI4_aireg_we_c,
	datad => inst_aI4_aadd_104_rtl_648_a48,
	aclr => GND,
	ena => inst_aI4_aireg_i_a0_a_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_rtl_648_a53,
	regout => inst_aI4_aireg_i_a0_a);

inst_aI4_aireg_c_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aireg_c_a0_a = DFFEA(inst_aI2_aE_x_aint_e_a0 & inst_aI4_aadd_104_rtl_648_a53 # !inst_aI2_aE_x_aint_e_a0 & (inst_aI2_aint_stop_x_a10 & inst_aI4_aireg_i_a0_a # !inst_aI2_aint_stop_x_a10 & inst_aI4_aadd_104_rtl_648_a53), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EF20",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aireg_i_a0_a,
	datab => inst_aI2_aE_x_aint_e_a0,
	datac => inst_aI2_aint_stop_x_a10,
	datad => inst_aI4_aadd_104_rtl_648_a53,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aireg_c_a0_a);

inst_aI5_adaddr_c_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adaddr_x_a0_a_a18 = inst_aI4_ai_a18 & (inst6_aaltsyncram_component_aq_a_a4_a # inst_aI4_aireg_c_a0_a & inst_aI4_ai_a133)
-- inst_aI5_adaddr_c_a0_a = DFFEA(inst_aI4_adaddr_x_a0_a_a18, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A8A0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_ai_a18,
	datab => inst_aI4_aireg_c_a0_a,
	datac => inst6_aaltsyncram_component_aq_a_a4_a,
	datad => inst_aI4_ai_a133,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adaddr_x_a0_a_a18,
	regout => inst_aI5_adaddr_c_a0_a);

inst_aI4_adaddr_x_a0_a_a27_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adaddr_x_a0_a_a27 = nRESET_acombout & inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a & inst6_aaltsyncram_component_aq_a_a4_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => nRESET_acombout,
	datac => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a,
	datad => inst6_aaltsyncram_component_aq_a_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adaddr_x_a0_a_a27);

inst_aI4_adaddr_x_a0_a_a28_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adaddr_x_a0_a_a28 = inst_aI4_ai_a18 & inst_aI4_aireg_c_a0_a & !inst_aI4_areduce_nor_103 & inst_aI4_ai_a20

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_ai_a18,
	datab => inst_aI4_aireg_c_a0_a,
	datac => inst_aI4_areduce_nor_103,
	datad => inst_aI4_ai_a20,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adaddr_x_a0_a_a28);

inst_aI5_ai_a12_I : cyclone_lcell 
-- Equation(s):
-- inst_aI5_ai_a12 = inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a0_a # !inst_aI4_andre_x_a1 & (inst_aI4_adaddr_x_a0_a_a27 # inst_aI4_adaddr_x_a0_a_a28)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAFC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_adaddr_c_a0_a,
	datab => inst_aI4_adaddr_x_a0_a_a27,
	datac => inst_aI4_adaddr_x_a0_a_a28,
	datad => inst_aI4_andre_x_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI5_ai_a12);

inst_aI4_adaddr_x_a2_a_a29_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adaddr_x_a2_a_a29 = inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a & inst6_aaltsyncram_component_aq_a_a6_a & nRESET_acombout

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a,
	datac => inst6_aaltsyncram_component_aq_a_a6_a,
	datad => nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adaddr_x_a2_a_a29);

inst_aI3_aacc_a0_a_a8_a_a63_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a8_a_a63 = inst_aI3_ai_a220 & !rtl_a2352 # !inst_aI3_ai_a220 & inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a1_a & inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F88",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a1_a,
	datab => inst_aI3_anreset_v_rtl_3_awysi_counter_asafe_q_a0_a,
	datac => rtl_a2352,
	datad => inst_aI3_ai_a220,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a8_a_a63);

inst_aI2_aTC_c_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a7_a_a1620 = inst_aI4_ai_a18 & (M1_TC_c[0] # inst_aI2_aTC_c_a2_a # !inst_aI2_aTC_c_a1_a)
-- inst_aI2_aTC_c_a0_a = DFFEA(inst_aI2_aTC_x_a0_a_a119, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "CCC4",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aTC_c_a1_a,
	datab => inst_aI4_ai_a18,
	datac => inst_aI2_aTC_x_a0_a_a119,
	datad => inst_aI2_aTC_c_a2_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a7_a_a1620,
	regout => inst_aI2_aTC_c_a0_a);

inst_aI2_adata_is_c_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a2_a_a449 = !inst_aI2_aTC_c_a0_a & !inst_aI2_aTC_c_a2_a & M1_data_is_c[2] & inst_aI2_aTC_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "1000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aTC_c_a0_a,
	datab => inst_aI2_aTC_c_a2_a,
	datac => inst6_aaltsyncram_component_aq_a_a6_a,
	datad => inst_aI2_aTC_c_a1_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a2_a_a449);

inst_aI4_aiinc_i_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aiinc_x_a2_a_a17 = inst_aI4_aiinc_we_c & inst_aI3_aacc_c_a0_a_a2_a # !inst_aI4_aiinc_we_c & inst_aI4_aiinc_c_a2_a & inst_aI4_ai_a18
-- inst_aI4_aiinc_i_a2_a = DFFEA(inst_aI4_aiinc_x_a2_a_a17, GLOBAL(UCLK_acombout), VCC, , inst_aI4_aireg_i_a0_a_a6, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "B888",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_c_a0_a_a2_a,
	datab => inst_aI4_aiinc_we_c,
	datac => inst_aI4_aiinc_c_a2_a,
	datad => inst_aI4_ai_a18,
	aclr => GND,
	ena => inst_aI4_aireg_i_a0_a_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aiinc_x_a2_a_a17,
	regout => inst_aI4_aiinc_i_a2_a);

inst_aI4_aiinc_c_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aiinc_c_a2_a = DFFEA(inst_aI2_aint_stop_x_a10 & (inst_aI2_aE_x_aint_e_a0 & inst_aI4_aiinc_x_a2_a_a17 # !inst_aI2_aE_x_aint_e_a0 & inst_aI4_aiinc_i_a2_a) # !inst_aI2_aint_stop_x_a10 & inst_aI4_aiinc_x_a2_a_a17, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aint_stop_x_a10,
	datab => inst_aI4_aiinc_i_a2_a,
	datac => inst_aI4_aiinc_x_a2_a_a17,
	datad => inst_aI2_aE_x_aint_e_a0,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aiinc_c_a2_a);

inst_aI3_adata_x_a2_a_a442_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a2_a_a442 = inst_aI4_aireg_c_a2_a & (inst_aI4_aiinc_c_a2_a # !inst_aI4_areduce_nor_106) # !inst_aI4_aireg_c_a2_a & inst_aI4_aiinc_c_a2_a & inst_aI4_areduce_nor_106

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aireg_c_a2_a,
	datac => inst_aI4_aiinc_c_a2_a,
	datad => inst_aI4_areduce_nor_106,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a2_a_a442);

inst_aI4_ai_a528_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_ai_a528 = inst_aI4_ai_a1256 & inst_aI4_ai_a1250 & inst_aI2_andre_x_a43

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI4_ai_a1256,
	datac => inst_aI4_ai_a1250,
	datad => inst_aI2_andre_x_a43,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_ai_a528);

inst_aI3_adata_x_a2_a_a1844_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a2_a_a1844 = inst_aI3_adata_x_a2_a_a449 # inst_aI3_adata_x_a7_a_a1620 & inst_aI3_adata_x_a2_a_a442 & inst_aI4_ai_a528

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ECCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a7_a_a1620,
	datab => inst_aI3_adata_x_a2_a_a449,
	datac => inst_aI3_adata_x_a2_a_a442,
	datad => inst_aI4_ai_a528,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a2_a_a1844);

RXD_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_RXD,
	combout => RXD_acombout);

rtl_a1015_I : cyclone_lcell 
-- Equation(s):
-- rtl_a1015 = inst8_arx_16_count_a1_a & !inst8_arx_s_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst8_arx_16_count_a1_a,
	datad => inst8_arx_s_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1015);

rtl_a14838_I : cyclone_lcell 
-- Equation(s):
-- rtl_a14838 = inst_aI2_aTD_c_a1_a & !inst_aI2_aTD_c_a2_a & (inst_aI2_aTC_c_a1_a $ inst_aI2_aTC_c_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0208",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a1_a,
	datab => inst_aI2_aTC_c_a1_a,
	datac => inst_aI2_aTD_c_a2_a,
	datad => inst_aI2_aTC_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a14838);

inst_aI2_aMux_68_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aMux_68_a0 = inst6_aaltsyncram_component_aq_a_a4_a & (inst6_aaltsyncram_component_aq_a_a5_a & !inst6_aaltsyncram_component_aq_a_a6_a & !inst6_aaltsyncram_component_aq_a_a7_a # !inst6_aaltsyncram_component_aq_a_a5_a & (!inst6_aaltsyncram_component_aq_a_a7_a # !inst6_aaltsyncram_component_aq_a_a6_a))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "1700",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_aaltsyncram_component_aq_a_a5_a,
	datab => inst6_aaltsyncram_component_aq_a_a6_a,
	datac => inst6_aaltsyncram_component_aq_a_a7_a,
	datad => inst6_aaltsyncram_component_aq_a_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aMux_68_a0);

inst_aI2_aTD_c_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aTD_c_a0_a = DFFEA(inst6_aaltsyncram_component_aq_a_a0_a & !inst_aI2_aTD_x_a3_a_a9 # !inst6_aaltsyncram_component_aq_a_a0_a & !inst6_aaltsyncram_component_aq_a_a3_a & inst_aI2_aTD_x_a3_a_a9 & inst_aI2_aMux_68_a0, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "1A0A",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst6_aaltsyncram_component_aq_a_a0_a,
	datab => inst6_aaltsyncram_component_aq_a_a3_a,
	datac => inst_aI2_aTD_x_a3_a_a9,
	datad => inst_aI2_aMux_68_a0,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_aTD_c_a0_a);

rtl_a2707_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2707 = !inst8_arx_s_a1_a & (!inst8_areduce_nor_27_a4 # !inst8_arx_16_count_a3_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "003F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst8_arx_16_count_a3_a,
	datac => inst8_areduce_nor_27_a4,
	datad => inst8_arx_s_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2707);

rtl_a2715_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2715 = !inst8_arx_s_a1_a & (!inst8_areduce_nor_27_a4 # !inst8_arx_16_count_a3_a) # !inst8_arx_s_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "557F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_s_a0_a,
	datab => inst8_arx_16_count_a3_a,
	datac => inst8_areduce_nor_27_a4,
	datad => inst8_arx_s_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2715);

rtl_a14840_I : cyclone_lcell 
-- Equation(s):
-- rtl_a14840 = inst8_arx_16_count_a3_a & rtl_a14851 & inst8_areduce_nor_27_a4 & !inst8_arx_bit_count_a3_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_16_count_a3_a,
	datab => rtl_a14851,
	datac => inst8_areduce_nor_27_a4,
	datad => inst8_arx_bit_count_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a14840);

inst8_arx_bit_count_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_bit_count_a0_a = DFFEA(inst8_arx_bit_count_a0_a & (rtl_a2707 # !inst8_arx_s_a0_a) # !inst8_arx_bit_count_a0_a & rtl_a14840, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "B8FC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => rtl_a2707,
	datab => inst8_arx_bit_count_a0_a,
	datac => rtl_a14840,
	datad => inst8_arx_s_a0_a,
	aclr => NOT_nRESET_acombout,
	ena => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_bit_count_a0_a);

inst8_arx_bit_count_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_bit_count_a1_a = DFFEA(inst8_arx_bit_count_a1_a & (rtl_a2715 # !inst8_arx_bit_count_a0_a & rtl_a14840) # !inst8_arx_bit_count_a1_a & inst8_arx_bit_count_a0_a & rtl_a14840, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BAC0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => rtl_a2715,
	datab => inst8_arx_bit_count_a0_a,
	datac => rtl_a14840,
	datad => inst8_arx_bit_count_a1_a,
	aclr => NOT_nRESET_acombout,
	ena => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_bit_count_a1_a);

inst8_aadd_39_a10_I : cyclone_lcell 
-- Equation(s):
-- inst8_aadd_39_a10 = inst8_arx_bit_count_a2_a $ (inst8_arx_bit_count_a1_a & inst8_arx_bit_count_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3CF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst8_arx_bit_count_a1_a,
	datac => inst8_arx_bit_count_a2_a,
	datad => inst8_arx_bit_count_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_aadd_39_a10);

rtl_a2058_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2058 = !inst8_arx_bit_count_a3_a & rtl_a14851 & !inst8_areduce_nor_27 & inst8_aadd_39_a10

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_bit_count_a3_a,
	datab => rtl_a14851,
	datac => inst8_areduce_nor_27,
	datad => inst8_aadd_39_a10,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2058);

inst8_arx_bit_count_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_bit_count_a2_a = DFFEA(rtl_a2058 # inst8_arx_bit_count_a2_a & (rtl_a2707 # !inst8_arx_s_a0_a), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFB0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => rtl_a2707,
	datab => inst8_arx_s_a0_a,
	datac => inst8_arx_bit_count_a2_a,
	datad => rtl_a2058,
	aclr => NOT_nRESET_acombout,
	ena => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_bit_count_a2_a);

rtl_a15502_I : cyclone_lcell 
-- Equation(s):
-- rtl_a15502 = inst8_arx_bit_count_a2_a & inst8_arx_bit_count_a0_a & inst8_arx_bit_count_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_bit_count_a2_a,
	datab => inst8_arx_bit_count_a0_a,
	datad => inst8_arx_bit_count_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a15502);

rtl_a2060_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2060 = !inst8_arx_bit_count_a3_a & rtl_a15502 & !inst8_areduce_nor_27 & rtl_a14851

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_bit_count_a3_a,
	datab => rtl_a15502,
	datac => inst8_areduce_nor_27,
	datad => rtl_a14851,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2060);

inst8_arx_bit_count_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_bit_count_a3_a = DFFEA(rtl_a2060 # inst8_arx_bit_count_a3_a & (rtl_a2707 # !inst8_arx_s_a0_a), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFB0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => rtl_a2707,
	datab => inst8_arx_s_a0_a,
	datac => inst8_arx_bit_count_a3_a,
	datad => rtl_a2060,
	aclr => NOT_nRESET_acombout,
	ena => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_bit_count_a3_a);

inst8_aDecoder_28_a17_I : cyclone_lcell 
-- Equation(s):
-- inst8_aDecoder_28_a17 = !inst8_arx_bit_count_a3_a & inst8_arx_bit_count_a0_a & !inst8_arx_bit_count_a2_a & !inst8_arx_bit_count_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0004",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_bit_count_a3_a,
	datab => inst8_arx_bit_count_a0_a,
	datac => inst8_arx_bit_count_a2_a,
	datad => inst8_arx_bit_count_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_aDecoder_28_a17);

inst8_arx_uart_reg_a1_a_a7_I : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a1_a_a7 = inst8_areduce_nor_7 & rtl_a14851 & !inst8_areduce_nor_27 & inst8_aDecoder_28_a17

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_areduce_nor_7,
	datab => rtl_a14851,
	datac => inst8_areduce_nor_27,
	datad => inst8_aDecoder_28_a17,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_arx_uart_reg_a1_a_a7);

inst8_arx_uart_reg_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a1_a = DFFEA(!RXD_acombout, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_arx_uart_reg_a1_a_a7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => RXD_acombout,
	aclr => NOT_nRESET_acombout,
	ena => inst8_arx_uart_reg_a1_a_a7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_reg_a1_a);

inst8_aDecoder_28_a24_I : cyclone_lcell 
-- Equation(s):
-- inst8_aDecoder_28_a24 = inst8_arx_bit_count_a3_a & !inst8_arx_bit_count_a2_a & !inst8_arx_bit_count_a1_a & !inst8_arx_bit_count_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0002",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_bit_count_a3_a,
	datab => inst8_arx_bit_count_a2_a,
	datac => inst8_arx_bit_count_a1_a,
	datad => inst8_arx_bit_count_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_aDecoder_28_a24);

inst8_arx_uart_reg_a8_a_a0_I : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a8_a_a0 = !inst8_areduce_nor_27 & inst8_areduce_nor_7 & rtl_a14851 & inst8_aDecoder_28_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_areduce_nor_27,
	datab => inst8_areduce_nor_7,
	datac => rtl_a14851,
	datad => inst8_aDecoder_28_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_arx_uart_reg_a8_a_a0);

inst8_arx_uart_reg_a8_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a8_a = DFFEA(!RXD_acombout, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_arx_uart_reg_a8_a_a0, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => RXD_acombout,
	aclr => NOT_nRESET_acombout,
	ena => inst8_arx_uart_reg_a8_a_a0,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_reg_a8_a);

inst8_arx_uart_fifo_a7_a_a29_I : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_fifo_a7_a_a29 = !inst8_arx_uart_reg_a8_a & !inst8_arx_s_a0_a & inst8_arx_s_a1_a & !inst8_arx_8_count_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0010",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_uart_reg_a8_a,
	datab => inst8_arx_s_a0_a,
	datac => inst8_arx_s_a1_a,
	datad => inst8_arx_8_count_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_arx_uart_fifo_a7_a_a29);

inst8_aadd_72_a52_I : cyclone_lcell 
-- Equation(s):
-- inst8_aadd_72_a52 = inst8_arx_8_count_a1_a & inst8_arx_8_count_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CC00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst8_arx_8_count_a1_a,
	datad => inst8_arx_8_count_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_aadd_72_a52);

inst8_arx_8_count_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_8_count_a2_a = DFFEA(inst8_arx_s_a1_a & !inst8_arx_s_a0_a & (inst8_arx_8_count_a2_a $ inst8_aadd_72_a52) # !inst8_arx_s_a1_a & inst8_arx_8_count_a2_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5270",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst8_arx_s_a1_a,
	datab => inst8_arx_s_a0_a,
	datac => inst8_arx_8_count_a2_a,
	datad => inst8_aadd_72_a52,
	aclr => NOT_nRESET_acombout,
	ena => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_8_count_a2_a);

inst8_arx_uart_fifo_a7_a_a32_I : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_fifo_a7_a_a32 = !inst8_arx_8_count_a2_a & !inst8_arx_8_count_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "000F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst8_arx_8_count_a2_a,
	datad => inst8_arx_8_count_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_arx_uart_fifo_a7_a_a32);

inst_aI3_aacc_a0_a_a7_a_a4225_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a7_a_a4225 = nRESET_acombout & inst_aI3_ai_a212 & rtl_a2352 & inst_aI2_avalid_c

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => nRESET_acombout,
	datab => inst_aI3_ai_a212,
	datac => rtl_a2352,
	datad => inst_aI2_avalid_c,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a7_a_a4225);

inst_aI3_aMux_201_rtl_95_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aMux_201_rtl_95_a0 = inst_aI2_aTC_c_a1_a $ inst_aI2_aTC_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0FF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI2_aTC_c_a1_a,
	datad => inst_aI2_aTC_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_201_rtl_95_a0);

rtl_a14847_I : cyclone_lcell 
-- Equation(s):
-- rtl_a14847 = !inst_aI2_aTD_c_a0_a & !inst_aI2_aTD_c_a2_a & inst_aI2_aTD_c_a1_a & inst_aI3_aMux_201_rtl_95_a0

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "1000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI2_aTD_c_a2_a,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI3_aMux_201_rtl_95_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a14847);

inst_aI2_adata_is_c_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a7_a_a99 = !inst_aI2_aTC_c_a0_a & !inst_aI2_aTC_c_a2_a & M1_data_is_c[7] & inst_aI2_aTC_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "1000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aTC_c_a0_a,
	datab => inst_aI2_aTC_c_a2_a,
	datac => inst6_aaltsyncram_component_aq_a_a11_a,
	datad => inst_aI2_aTC_c_a1_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a7_a_a99);

inst_aI4_aiinc_i_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aiinc_x_a7_a_a2 = inst_aI4_aiinc_we_c & inst_aI3_aacc_c_a0_a_a7_a # !inst_aI4_aiinc_we_c & inst_aI4_aiinc_c_a7_a & inst_aI4_ai_a18
-- inst_aI4_aiinc_i_a7_a = DFFEA(inst_aI4_aiinc_x_a7_a_a2, GLOBAL(UCLK_acombout), VCC, , inst_aI4_aireg_i_a0_a_a6, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCA0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aiinc_c_a7_a,
	datab => inst_aI3_aacc_c_a0_a_a7_a,
	datac => inst_aI4_ai_a18,
	datad => inst_aI4_aiinc_we_c,
	aclr => GND,
	ena => inst_aI4_aireg_i_a0_a_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aiinc_x_a7_a_a2,
	regout => inst_aI4_aiinc_i_a7_a);

inst_aI4_aiinc_c_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aiinc_c_a7_a = DFFEA(inst_aI2_aE_x_aint_e_a0 & inst_aI4_aiinc_x_a7_a_a2 # !inst_aI2_aE_x_aint_e_a0 & (inst_aI2_aint_stop_x_a10 & inst_aI4_aiinc_i_a7_a # !inst_aI2_aint_stop_x_a10 & inst_aI4_aiinc_x_a7_a_a2), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4F0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aE_x_aint_e_a0,
	datab => inst_aI4_aiinc_i_a7_a,
	datac => inst_aI4_aiinc_x_a7_a_a2,
	datad => inst_aI2_aint_stop_x_a10,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aiinc_c_a7_a);

inst_aI2_adata_is_c_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a4_a_a309 = inst_aI2_aTC_c_a1_a & !inst_aI2_aTC_c_a0_a & M1_data_is_c[4] & !inst_aI2_aTC_c_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "0020",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aTC_c_a1_a,
	datab => inst_aI2_aTC_c_a0_a,
	datac => inst6_aaltsyncram_component_aq_a_a8_a,
	datad => inst_aI2_aTC_c_a2_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a4_a_a309);

inst_aI4_aiinc_i_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aiinc_x_a4_a_a11 = inst_aI4_aiinc_we_c & inst_aI3_aacc_c_a0_a_a4_a # !inst_aI4_aiinc_we_c & inst_aI4_aiinc_c_a4_a & inst_aI4_ai_a18
-- inst_aI4_aiinc_i_a4_a = DFFEA(inst_aI4_aiinc_x_a4_a_a11, GLOBAL(UCLK_acombout), VCC, , inst_aI4_aireg_i_a0_a_a6, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "D888",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aiinc_we_c,
	datab => inst_aI3_aacc_c_a0_a_a4_a,
	datac => inst_aI4_aiinc_c_a4_a,
	datad => inst_aI4_ai_a18,
	aclr => GND,
	ena => inst_aI4_aireg_i_a0_a_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aiinc_x_a4_a_a11,
	regout => inst_aI4_aiinc_i_a4_a);

inst_aI4_aiinc_c_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aiinc_c_a4_a = DFFEA(inst_aI2_aint_stop_x_a10 & (inst_aI2_aE_x_aint_e_a0 & inst_aI4_aiinc_x_a4_a_a11 # !inst_aI2_aE_x_aint_e_a0 & inst_aI4_aiinc_i_a4_a) # !inst_aI2_aint_stop_x_a10 & inst_aI4_aiinc_x_a4_a_a11, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FD20",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aint_stop_x_a10,
	datab => inst_aI2_aE_x_aint_e_a0,
	datac => inst_aI4_aiinc_i_a4_a,
	datad => inst_aI4_aiinc_x_a4_a_a11,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aiinc_c_a4_a);

inst_aI3_adata_x_a4_a_a302_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a4_a_a302 = inst_aI4_aireg_c_a4_a & (inst_aI4_aiinc_c_a4_a # !inst_aI4_areduce_nor_106) # !inst_aI4_aireg_c_a4_a & inst_aI4_aiinc_c_a4_a & inst_aI4_areduce_nor_106

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI4_aireg_c_a4_a,
	datac => inst_aI4_aiinc_c_a4_a,
	datad => inst_aI4_areduce_nor_106,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a4_a_a302);

inst_aI3_adata_x_a4_a_a1778_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a4_a_a1778 = inst_aI3_adata_x_a4_a_a309 # inst_aI3_adata_x_a4_a_a302 & inst_aI3_adata_x_a7_a_a1620 & inst_aI4_ai_a528

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EAAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a4_a_a309,
	datab => inst_aI3_adata_x_a4_a_a302,
	datac => inst_aI3_adata_x_a7_a_a1620,
	datad => inst_aI4_ai_a528,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a4_a_a1778);

inst8_aDecoder_28_a20_I : cyclone_lcell 
-- Equation(s):
-- inst8_aDecoder_28_a20 = !inst8_arx_bit_count_a3_a & inst8_arx_bit_count_a2_a & !inst8_arx_bit_count_a1_a & !inst8_arx_bit_count_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0004",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_bit_count_a3_a,
	datab => inst8_arx_bit_count_a2_a,
	datac => inst8_arx_bit_count_a1_a,
	datad => inst8_arx_bit_count_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_aDecoder_28_a20);

inst8_arx_uart_reg_a4_a_a4_I : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a4_a_a4 = !inst8_areduce_nor_27 & rtl_a14851 & inst8_areduce_nor_7 & inst8_aDecoder_28_a20

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_areduce_nor_27,
	datab => rtl_a14851,
	datac => inst8_areduce_nor_7,
	datad => inst8_aDecoder_28_a20,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_arx_uart_reg_a4_a_a4);

inst8_arx_uart_reg_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a4_a = DFFEA(!RXD_acombout, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_arx_uart_reg_a4_a_a4, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => RXD_acombout,
	aclr => NOT_nRESET_acombout,
	ena => inst8_arx_uart_reg_a4_a_a4,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_reg_a4_a);

inst8_arx_uart_fifo_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_fifo_a4_a = DFFEA(!inst8_arx_uart_reg_a4_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_arx_uart_fifo_a7_a_a37, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst8_arx_uart_reg_a4_a,
	aclr => NOT_nRESET_acombout,
	ena => inst8_arx_uart_fifo_a7_a_a37,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_fifo_a4_a);

inst_aI4_adaddr_x_a4_a_a31_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adaddr_x_a4_a_a31 = nRESET_acombout & inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a & inst6_aaltsyncram_component_aq_a_a8_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => nRESET_acombout,
	datac => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a,
	datad => inst6_aaltsyncram_component_aq_a_a8_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adaddr_x_a4_a_a31);

inst_aI5_adaddr_c_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI5_adaddr_c_a4_a = DFFEA(inst_aI4_ai_a18 & (inst6_aaltsyncram_component_aq_a_a8_a # inst_aI4_aireg_c_a4_a & inst_aI4_ai_a133), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C8C0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aireg_c_a4_a,
	datab => inst_aI4_ai_a18,
	datac => inst6_aaltsyncram_component_aq_a_a8_a,
	datad => inst_aI4_ai_a133,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI5_adaddr_c_a4_a);

inst_aI4_adaddr_x_a4_a_a32_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adaddr_x_a4_a_a32 = inst_aI4_ai_a18 & inst_aI4_aireg_c_a4_a & !inst_aI4_areduce_nor_103 & inst_aI4_ai_a20

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_ai_a18,
	datab => inst_aI4_aireg_c_a4_a,
	datac => inst_aI4_areduce_nor_103,
	datad => inst_aI4_ai_a20,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adaddr_x_a4_a_a32);

inst_aI5_ai_a18_I : cyclone_lcell 
-- Equation(s):
-- inst_aI5_ai_a18 = inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a4_a # !inst_aI4_andre_x_a1 & (inst_aI4_adaddr_x_a4_a_a31 # inst_aI4_adaddr_x_a4_a_a32)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CFCA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_adaddr_x_a4_a_a31,
	datab => inst_aI5_adaddr_c_a4_a,
	datac => inst_aI4_andre_x_a1,
	datad => inst_aI4_adaddr_x_a4_a_a32,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI5_ai_a18);

inst5_amux_c_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst5_amux_c_a1_a = DFFEA(inst_aI5_ai_a24 & !inst_aI5_ai_a18 & inst_aI5_ai_a21, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0A00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI5_ai_a24,
	datac => inst_aI5_ai_a18,
	datad => inst_aI5_ai_a21,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_amux_c_a1_a);

inst5_amux_c_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst5_amux_c_a0_a = DFFEA(!inst_aI5_ai_a18 & inst_aI5_ai_a24 & inst_aI5_ai_a15, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4040",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI5_ai_a18,
	datab => inst_aI5_ai_a24,
	datac => inst_aI5_ai_a15,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst5_amux_c_a0_a);

inst5_ai_a45_I : cyclone_lcell 
-- Equation(s):
-- inst5_ai_a45 = inst1_ai_a457 & (inst_aI4_andre_x_a1 & !inst_aI5_adaddr_c_a8_a # !inst_aI4_andre_x_a1 & !inst_aI4_adaddr_x_a8_a_a4)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "220A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_ai_a457,
	datab => inst_aI5_adaddr_c_a8_a,
	datac => inst_aI4_adaddr_x_a8_a_a4,
	datad => inst_aI4_andre_x_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_ai_a45);

inst_aI4_aiinc_i_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aiinc_x_a1_a_a20 = inst_aI4_aiinc_we_c & inst_aI3_aacc_c_a0_a_a1_a # !inst_aI4_aiinc_we_c & inst_aI4_aiinc_c_a1_a & inst_aI4_ai_a18
-- inst_aI4_aiinc_i_a1_a = DFFEA(inst_aI4_aiinc_x_a1_a_a20, GLOBAL(UCLK_acombout), VCC, , inst_aI4_aireg_i_a0_a_a6, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EC20",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aiinc_c_a1_a,
	datab => inst_aI4_aiinc_we_c,
	datac => inst_aI4_ai_a18,
	datad => inst_aI3_aacc_c_a0_a_a1_a,
	aclr => GND,
	ena => inst_aI4_aireg_i_a0_a_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aiinc_x_a1_a_a20,
	regout => inst_aI4_aiinc_i_a1_a);

inst_aI4_aiinc_c_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aiinc_c_a1_a = DFFEA(inst_aI2_aE_x_aint_e_a0 & inst_aI4_aiinc_x_a1_a_a20 # !inst_aI2_aE_x_aint_e_a0 & (inst_aI2_aint_stop_x_a10 & inst_aI4_aiinc_i_a1_a # !inst_aI2_aint_stop_x_a10 & inst_aI4_aiinc_x_a1_a_a20), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EF20",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aiinc_i_a1_a,
	datab => inst_aI2_aE_x_aint_e_a0,
	datac => inst_aI2_aint_stop_x_a10,
	datad => inst_aI4_aiinc_x_a1_a_a20,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aiinc_c_a1_a);

inst_aI4_aadd_104_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_a1 = inst_aI4_aiinc_c_a1_a $ inst_aI4_aireg_c_a1_a $ inst_aI4_aadd_104_a0COUT0
-- inst_aI4_aadd_104_a1COUT0 = CARRY(inst_aI4_aiinc_c_a1_a & !inst_aI4_aireg_c_a1_a & !inst_aI4_aadd_104_a0COUT0 # !inst_aI4_aiinc_c_a1_a & (!inst_aI4_aadd_104_a0COUT0 # !inst_aI4_aireg_c_a1_a))
-- inst_aI4_aadd_104_a1COUT1 = CARRY(inst_aI4_aiinc_c_a1_a & !inst_aI4_aireg_c_a1_a & !inst_aI4_aadd_104_a0COUT1 # !inst_aI4_aiinc_c_a1_a & (!inst_aI4_aadd_104_a0COUT1 # !inst_aI4_aireg_c_a1_a))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "9617",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aiinc_c_a1_a,
	datab => inst_aI4_aireg_c_a1_a,
	cin0 => inst_aI4_aadd_104_a0COUT0,
	cin1 => inst_aI4_aadd_104_a0COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_a1,
	cout0 => inst_aI4_aadd_104_a1COUT0,
	cout1 => inst_aI4_aadd_104_a1COUT1);

inst_aI4_aadd_104_rtl_648_a118_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_rtl_648_a118 = inst_aI4_areduce_nor_103 & inst_aI4_aireg_c_a1_a # !inst_aI4_areduce_nor_103 & (inst_aI4_ai_a20 & inst_aI4_aadd_104_a1 # !inst_aI4_ai_a20 & inst_aI4_aireg_c_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aadd_104_a1,
	datab => inst_aI4_areduce_nor_103,
	datac => inst_aI4_aireg_c_a1_a,
	datad => inst_aI4_ai_a20,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_rtl_648_a118);

inst_aI4_aireg_i_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_rtl_648_a123 = inst_aI4_aireg_we_c & inst_aI3_aacc_c_a0_a_a1_a # !inst_aI4_aireg_we_c & inst_aI4_ai_a18 & inst_aI4_aadd_104_rtl_648_a118
-- inst_aI4_aireg_i_a1_a = DFFEA(inst_aI4_aadd_104_rtl_648_a123, GLOBAL(UCLK_acombout), VCC, , inst_aI4_aireg_i_a0_a_a6, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CAC0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_ai_a18,
	datab => inst_aI3_aacc_c_a0_a_a1_a,
	datac => inst_aI4_aireg_we_c,
	datad => inst_aI4_aadd_104_rtl_648_a118,
	aclr => GND,
	ena => inst_aI4_aireg_i_a0_a_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_rtl_648_a123,
	regout => inst_aI4_aireg_i_a1_a);

inst_aI4_aireg_c_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aireg_c_a1_a = DFFEA(inst_aI2_aE_x_aint_e_a0 & inst_aI4_aadd_104_rtl_648_a123 # !inst_aI2_aE_x_aint_e_a0 & (inst_aI2_aint_stop_x_a10 & inst_aI4_aireg_i_a1_a # !inst_aI2_aint_stop_x_a10 & inst_aI4_aadd_104_rtl_648_a123), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EF20",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aireg_i_a1_a,
	datab => inst_aI2_aE_x_aint_e_a0,
	datac => inst_aI2_aint_stop_x_a10,
	datad => inst_aI4_aadd_104_rtl_648_a123,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aireg_c_a1_a);

inst_aI5_adaddr_c_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI5_adaddr_c_a1_a = DFFEA(inst_aI4_ai_a18 & (inst6_aaltsyncram_component_aq_a_a5_a # inst_aI4_aireg_c_a1_a & inst_aI4_ai_a133), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E0C0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aireg_c_a1_a,
	datab => inst6_aaltsyncram_component_aq_a_a5_a,
	datac => inst_aI4_ai_a18,
	datad => inst_aI4_ai_a133,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI5_adaddr_c_a1_a);

inst_aI4_adaddr_x_a1_a_a45_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adaddr_x_a1_a_a45 = inst6_aaltsyncram_component_aq_a_a5_a # inst_aI4_aireg_c_a1_a & !inst_aI4_areduce_nor_103 & inst_aI4_ai_a20

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F2F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aireg_c_a1_a,
	datab => inst_aI4_areduce_nor_103,
	datac => inst6_aaltsyncram_component_aq_a_a5_a,
	datad => inst_aI4_ai_a20,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adaddr_x_a1_a_a45);

inst_aI5_ai_a27_I : cyclone_lcell 
-- Equation(s):
-- inst_aI5_ai_a27 = inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a1_a # !inst_aI4_andre_x_a1 & inst_aI4_ai_a18 & inst_aI4_adaddr_x_a1_a_a45

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "B888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_adaddr_c_a1_a,
	datab => inst_aI4_andre_x_a1,
	datac => inst_aI4_ai_a18,
	datad => inst_aI4_adaddr_x_a1_a_a45,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI5_ai_a27);

inst8_aDecoder_28_a21_I : cyclone_lcell 
-- Equation(s):
-- inst8_aDecoder_28_a21 = !inst8_arx_bit_count_a3_a & inst8_arx_bit_count_a2_a & !inst8_arx_bit_count_a1_a & inst8_arx_bit_count_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_bit_count_a3_a,
	datab => inst8_arx_bit_count_a2_a,
	datac => inst8_arx_bit_count_a1_a,
	datad => inst8_arx_bit_count_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_aDecoder_28_a21);

inst8_arx_uart_reg_a5_a_a3_I : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a5_a_a3 = !inst8_areduce_nor_27 & rtl_a14851 & inst8_areduce_nor_7 & inst8_aDecoder_28_a21

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_areduce_nor_27,
	datab => rtl_a14851,
	datac => inst8_areduce_nor_7,
	datad => inst8_aDecoder_28_a21,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_arx_uart_reg_a5_a_a3);

inst8_arx_uart_reg_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a5_a = DFFEA(!RXD_acombout, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_arx_uart_reg_a5_a_a3, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => RXD_acombout,
	aclr => NOT_nRESET_acombout,
	ena => inst8_arx_uart_reg_a5_a_a3,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_reg_a5_a);

inst8_arx_uart_fifo_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_fifo_a5_a = DFFEA(!inst8_arx_uart_reg_a5_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_arx_uart_fifo_a7_a_a37, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst8_arx_uart_reg_a5_a,
	aclr => NOT_nRESET_acombout,
	ena => inst8_arx_uart_fifo_a7_a_a37,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_fifo_a5_a);

inst_aI4_aiinc_i_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aiinc_x_a6_a_a5 = inst_aI4_aiinc_we_c & inst_aI3_aacc_c_a0_a_a6_a # !inst_aI4_aiinc_we_c & inst_aI4_ai_a18 & inst_aI4_aiinc_c_a6_a
-- inst_aI4_aiinc_i_a6_a = DFFEA(inst_aI4_aiinc_x_a6_a_a5, GLOBAL(UCLK_acombout), VCC, , inst_aI4_aireg_i_a0_a_a6, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCA0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_ai_a18,
	datab => inst_aI3_aacc_c_a0_a_a6_a,
	datac => inst_aI4_aiinc_c_a6_a,
	datad => inst_aI4_aiinc_we_c,
	aclr => GND,
	ena => inst_aI4_aireg_i_a0_a_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aiinc_x_a6_a_a5,
	regout => inst_aI4_aiinc_i_a6_a);

inst_aI4_aiinc_c_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aiinc_c_a6_a = DFFEA(inst_aI2_aE_x_aint_e_a0 & inst_aI4_aiinc_x_a6_a_a5 # !inst_aI2_aE_x_aint_e_a0 & (inst_aI2_aint_stop_x_a10 & inst_aI4_aiinc_i_a6_a # !inst_aI2_aint_stop_x_a10 & inst_aI4_aiinc_x_a6_a_a5), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EF20",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aiinc_i_a6_a,
	datab => inst_aI2_aE_x_aint_e_a0,
	datac => inst_aI2_aint_stop_x_a10,
	datad => inst_aI4_aiinc_x_a6_a_a5,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aiinc_c_a6_a);

inst_aI4_aiinc_i_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aiinc_x_a5_a_a8 = inst_aI4_aiinc_we_c & inst_aI3_aacc_c_a0_a_a5_a # !inst_aI4_aiinc_we_c & inst_aI4_ai_a18 & inst_aI4_aiinc_c_a5_a
-- inst_aI4_aiinc_i_a5_a = DFFEA(inst_aI4_aiinc_x_a5_a_a8, GLOBAL(UCLK_acombout), VCC, , inst_aI4_aireg_i_a0_a_a6, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCA0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_ai_a18,
	datab => inst_aI3_aacc_c_a0_a_a5_a,
	datac => inst_aI4_aiinc_c_a5_a,
	datad => inst_aI4_aiinc_we_c,
	aclr => GND,
	ena => inst_aI4_aireg_i_a0_a_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aiinc_x_a5_a_a8,
	regout => inst_aI4_aiinc_i_a5_a);

inst_aI4_aiinc_c_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aiinc_c_a5_a = DFFEA(inst_aI2_aE_x_aint_e_a0 & inst_aI4_aiinc_x_a5_a_a8 # !inst_aI2_aE_x_aint_e_a0 & (inst_aI2_aint_stop_x_a10 & inst_aI4_aiinc_i_a5_a # !inst_aI2_aint_stop_x_a10 & inst_aI4_aiinc_x_a5_a_a8), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EF20",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aiinc_i_a5_a,
	datab => inst_aI2_aE_x_aint_e_a0,
	datac => inst_aI2_aint_stop_x_a10,
	datad => inst_aI4_aiinc_x_a5_a_a8,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aiinc_c_a5_a);

inst_aI4_aadd_104_a5_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_a5 = inst_aI4_aiinc_c_a5_a $ inst_aI4_aireg_c_a5_a $ (!inst_aI4_aadd_104_a4COUT & GND) # (inst_aI4_aadd_104_a4COUT & VCC)
-- inst_aI4_aadd_104_a5COUT0 = CARRY(inst_aI4_aiinc_c_a5_a & !inst_aI4_aireg_c_a5_a & !inst_aI4_aadd_104_a4COUT # !inst_aI4_aiinc_c_a5_a & (!inst_aI4_aadd_104_a4COUT # !inst_aI4_aireg_c_a5_a))
-- inst_aI4_aadd_104_a5COUT1 = CARRY(inst_aI4_aiinc_c_a5_a & !inst_aI4_aireg_c_a5_a & !inst_aI4_aadd_104_a4COUT # !inst_aI4_aiinc_c_a5_a & (!inst_aI4_aadd_104_a4COUT # !inst_aI4_aireg_c_a5_a))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "9617",
	cin_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aiinc_c_a5_a,
	datab => inst_aI4_aireg_c_a5_a,
	cin => inst_aI4_aadd_104_a4COUT,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_a5,
	cout0 => inst_aI4_aadd_104_a5COUT0,
	cout1 => inst_aI4_aadd_104_a5COUT1);

inst_aI4_aadd_104_a6_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_a6 = inst_aI4_aiinc_c_a6_a $ inst_aI4_aireg_c_a6_a $ !(!inst_aI4_aadd_104_a4COUT & inst_aI4_aadd_104_a5COUT0) # (inst_aI4_aadd_104_a4COUT & inst_aI4_aadd_104_a5COUT1)
-- inst_aI4_aadd_104_a6COUT0 = CARRY(inst_aI4_aiinc_c_a6_a & (inst_aI4_aireg_c_a6_a # !inst_aI4_aadd_104_a5COUT0) # !inst_aI4_aiinc_c_a6_a & inst_aI4_aireg_c_a6_a & !inst_aI4_aadd_104_a5COUT0)
-- inst_aI4_aadd_104_a6COUT1 = CARRY(inst_aI4_aiinc_c_a6_a & (inst_aI4_aireg_c_a6_a # !inst_aI4_aadd_104_a5COUT1) # !inst_aI4_aiinc_c_a6_a & inst_aI4_aireg_c_a6_a & !inst_aI4_aadd_104_a5COUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "698E",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aiinc_c_a6_a,
	datab => inst_aI4_aireg_c_a6_a,
	cin => inst_aI4_aadd_104_a4COUT,
	cin0 => inst_aI4_aadd_104_a5COUT0,
	cin1 => inst_aI4_aadd_104_a5COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_a6,
	cout0 => inst_aI4_aadd_104_a6COUT0,
	cout1 => inst_aI4_aadd_104_a6COUT1);

inst_aI4_aadd_104_rtl_648_a98_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_rtl_648_a98 = inst_aI4_areduce_nor_103 & inst_aI4_aireg_c_a6_a # !inst_aI4_areduce_nor_103 & (inst_aI4_ai_a20 & inst_aI4_aadd_104_a6 # !inst_aI4_ai_a20 & inst_aI4_aireg_c_a6_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BA8A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aireg_c_a6_a,
	datab => inst_aI4_areduce_nor_103,
	datac => inst_aI4_ai_a20,
	datad => inst_aI4_aadd_104_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_rtl_648_a98);

inst_aI4_aireg_i_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_rtl_648_a103 = inst_aI4_aireg_we_c & inst_aI3_aacc_c_a0_a_a6_a # !inst_aI4_aireg_we_c & inst_aI4_ai_a18 & inst_aI4_aadd_104_rtl_648_a98
-- inst_aI4_aireg_i_a6_a = DFFEA(inst_aI4_aadd_104_rtl_648_a103, GLOBAL(UCLK_acombout), VCC, , inst_aI4_aireg_i_a0_a_a6, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "D888",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aireg_we_c,
	datab => inst_aI3_aacc_c_a0_a_a6_a,
	datac => inst_aI4_ai_a18,
	datad => inst_aI4_aadd_104_rtl_648_a98,
	aclr => GND,
	ena => inst_aI4_aireg_i_a0_a_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_rtl_648_a103,
	regout => inst_aI4_aireg_i_a6_a);

inst_aI4_aireg_c_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aireg_c_a6_a = DFFEA(inst_aI2_aE_x_aint_e_a0 & inst_aI4_aadd_104_rtl_648_a103 # !inst_aI2_aE_x_aint_e_a0 & (inst_aI2_aint_stop_x_a10 & inst_aI4_aireg_i_a6_a # !inst_aI2_aint_stop_x_a10 & inst_aI4_aadd_104_rtl_648_a103), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EF20",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aireg_i_a6_a,
	datab => inst_aI2_aE_x_aint_e_a0,
	datac => inst_aI2_aint_stop_x_a10,
	datad => inst_aI4_aadd_104_rtl_648_a103,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aireg_c_a6_a);

inst_aI5_adaddr_c_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI5_adaddr_c_a6_a = DFFEA(inst_aI4_ai_a18 & (inst6_aaltsyncram_component_aq_a_a10_a # inst_aI4_aireg_c_a6_a & inst_aI4_ai_a133), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aireg_c_a6_a,
	datab => inst_aI4_ai_a133,
	datac => inst_aI4_ai_a18,
	datad => inst6_aaltsyncram_component_aq_a_a10_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI5_adaddr_c_a6_a);

inst_aI4_adaddr_x_a6_a_a59_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adaddr_x_a6_a_a59 = inst6_aaltsyncram_component_aq_a_a10_a # inst_aI4_aireg_c_a6_a & !inst_aI4_areduce_nor_103 & inst_aI4_ai_a20

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF20",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aireg_c_a6_a,
	datab => inst_aI4_areduce_nor_103,
	datac => inst_aI4_ai_a20,
	datad => inst6_aaltsyncram_component_aq_a_a10_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adaddr_x_a6_a_a59);

inst_aI5_ai_a33_I : cyclone_lcell 
-- Equation(s):
-- inst_aI5_ai_a33 = inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a6_a # !inst_aI4_andre_x_a1 & inst_aI4_ai_a18 & inst_aI4_adaddr_x_a6_a_a59

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "B888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_adaddr_c_a6_a,
	datab => inst_aI4_andre_x_a1,
	datac => inst_aI4_ai_a18,
	datad => inst_aI4_adaddr_x_a6_a_a59,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI5_ai_a33);

inst_aI5_adaddr_c_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI5_adaddr_c_a7_a = DFFEA(inst_aI4_ai_a18 & (inst6_aaltsyncram_component_aq_a_a11_a # inst_aI4_aireg_c_a7_a & inst_aI4_ai_a133), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C888",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst6_aaltsyncram_component_aq_a_a11_a,
	datab => inst_aI4_ai_a18,
	datac => inst_aI4_aireg_c_a7_a,
	datad => inst_aI4_ai_a133,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI5_adaddr_c_a7_a);

inst_aI4_adaddr_x_a7_a_a66_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adaddr_x_a7_a_a66 = inst6_aaltsyncram_component_aq_a_a11_a # !inst_aI4_areduce_nor_103 & inst_aI4_aireg_c_a7_a & inst_aI4_ai_a20

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F4F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_areduce_nor_103,
	datab => inst_aI4_aireg_c_a7_a,
	datac => inst6_aaltsyncram_component_aq_a_a11_a,
	datad => inst_aI4_ai_a20,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adaddr_x_a7_a_a66);

inst_aI5_ai_a36_I : cyclone_lcell 
-- Equation(s):
-- inst_aI5_ai_a36 = inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a7_a # !inst_aI4_andre_x_a1 & inst_aI4_ai_a18 & inst_aI4_adaddr_x_a7_a_a66

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ACA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_adaddr_c_a7_a,
	datab => inst_aI4_ai_a18,
	datac => inst_aI4_andre_x_a1,
	datad => inst_aI4_adaddr_x_a7_a_a66,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI5_ai_a36);

inst2_ai_a300_I : cyclone_lcell 
-- Equation(s):
-- inst2_ai_a300 = inst1_ai_a457 & (inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a8_a # !inst_aI4_andre_x_a1 & inst_aI4_adaddr_x_a8_a_a4)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "88A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_ai_a457,
	datab => inst_aI5_adaddr_c_a8_a,
	datac => inst_aI4_adaddr_x_a8_a_a4,
	datad => inst_aI4_andre_x_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_ai_a300);

inst5_areduce_nor_21_aI : cyclone_lcell 
-- Equation(s):
-- inst5_areduce_nor_21 = inst_aI5_ai_a15 # inst_aI5_ai_a18 # !inst_aI5_ai_a21

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF3",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI5_ai_a21,
	datac => inst_aI5_ai_a15,
	datad => inst_aI5_ai_a18,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_areduce_nor_21);

inst10_ai_a1_I : cyclone_lcell 
-- Equation(s):
-- inst10_ai_a1 = !inst_aI5_ai_a12 & inst2_ai_a300 & inst5_areduce_nor_19_a54 & !inst5_areduce_nor_21

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0040",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_ai_a12,
	datab => inst2_ai_a300,
	datac => inst5_areduce_nor_19_a54,
	datad => inst5_areduce_nor_21,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_ai_a1);

inst10_aout_0reg_a2_a_areg0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adata_ox_a2_a_a5 = nRESET_acombout & inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a & inst_aI3_aacc_c_a0_a_a2_a
-- inst10_aout_0reg_a2_a_areg0 = DFFEA(inst_aI4_adata_ox_a2_a_a5, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst10_ai_a1, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8800",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => nRESET_acombout,
	datab => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a2_a,
	aclr => NOT_nRESET_acombout,
	ena => inst10_ai_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adata_ox_a2_a_a5,
	regout => inst10_aout_0reg_a2_a_areg0);

inst_aI2_adata_is_c_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a3_a_a379 = inst_aI2_aTC_c_a1_a & !inst_aI2_aTC_c_a0_a & M1_data_is_c[3] & !inst_aI2_aTC_c_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "0020",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aTC_c_a1_a,
	datab => inst_aI2_aTC_c_a0_a,
	datac => inst6_aaltsyncram_component_aq_a_a7_a,
	datad => inst_aI2_aTC_c_a2_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a3_a_a379);

inst_aI4_aiinc_i_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aiinc_x_a3_a_a14 = inst_aI4_aiinc_we_c & inst_aI3_aacc_c_a0_a_a3_a # !inst_aI4_aiinc_we_c & inst_aI4_aiinc_c_a3_a & inst_aI4_ai_a18
-- inst_aI4_aiinc_i_a3_a = DFFEA(inst_aI4_aiinc_x_a3_a_a14, GLOBAL(UCLK_acombout), VCC, , inst_aI4_aireg_i_a0_a_a6, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "D888",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aiinc_we_c,
	datab => inst_aI3_aacc_c_a0_a_a3_a,
	datac => inst_aI4_aiinc_c_a3_a,
	datad => inst_aI4_ai_a18,
	aclr => GND,
	ena => inst_aI4_aireg_i_a0_a_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aiinc_x_a3_a_a14,
	regout => inst_aI4_aiinc_i_a3_a);

inst_aI4_aiinc_c_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aiinc_c_a3_a = DFFEA(inst_aI2_aE_x_aint_e_a0 & inst_aI4_aiinc_x_a3_a_a14 # !inst_aI2_aE_x_aint_e_a0 & (inst_aI2_aint_stop_x_a10 & inst_aI4_aiinc_i_a3_a # !inst_aI2_aint_stop_x_a10 & inst_aI4_aiinc_x_a3_a_a14), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EF20",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aiinc_i_a3_a,
	datab => inst_aI2_aE_x_aint_e_a0,
	datac => inst_aI2_aint_stop_x_a10,
	datad => inst_aI4_aiinc_x_a3_a_a14,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aiinc_c_a3_a);

inst_aI3_adata_x_a3_a_a372_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a3_a_a372 = inst_aI4_aiinc_c_a3_a & (inst_aI4_aireg_c_a3_a # inst_aI4_areduce_nor_106) # !inst_aI4_aiinc_c_a3_a & inst_aI4_aireg_c_a3_a & !inst_aI4_areduce_nor_106

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aiinc_c_a3_a,
	datac => inst_aI4_aireg_c_a3_a,
	datad => inst_aI4_areduce_nor_106,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a3_a_a372);

inst_aI3_adata_x_a3_a_a1811_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a3_a_a1811 = inst_aI3_adata_x_a3_a_a379 # inst_aI3_adata_x_a3_a_a372 & inst_aI3_adata_x_a7_a_a1620 & inst_aI4_ai_a528

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EAAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a3_a_a379,
	datab => inst_aI3_adata_x_a3_a_a372,
	datac => inst_aI3_adata_x_a7_a_a1620,
	datad => inst_aI4_ai_a528,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a3_a_a1811);

inst8_aDecoder_28_a19_I : cyclone_lcell 
-- Equation(s):
-- inst8_aDecoder_28_a19 = !inst8_arx_bit_count_a3_a & !inst8_arx_bit_count_a2_a & inst8_arx_bit_count_a1_a & inst8_arx_bit_count_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "1000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_bit_count_a3_a,
	datab => inst8_arx_bit_count_a2_a,
	datac => inst8_arx_bit_count_a1_a,
	datad => inst8_arx_bit_count_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_aDecoder_28_a19);

inst8_arx_uart_reg_a3_a_a5_I : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a3_a_a5 = !inst8_areduce_nor_27 & rtl_a14851 & inst8_areduce_nor_7 & inst8_aDecoder_28_a19

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_areduce_nor_27,
	datab => rtl_a14851,
	datac => inst8_areduce_nor_7,
	datad => inst8_aDecoder_28_a19,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_arx_uart_reg_a3_a_a5);

inst8_arx_uart_reg_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a3_a = DFFEA(!RXD_acombout, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_arx_uart_reg_a3_a_a5, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => RXD_acombout,
	aclr => NOT_nRESET_acombout,
	ena => inst8_arx_uart_reg_a3_a_a5,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_reg_a3_a);

inst8_arx_uart_fifo_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_fifo_a3_a = DFFEA(!inst8_arx_uart_reg_a3_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_arx_uart_fifo_a7_a_a37, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst8_arx_uart_reg_a3_a,
	aclr => NOT_nRESET_acombout,
	ena => inst8_arx_uart_fifo_a7_a_a37,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_fifo_a3_a);

inst10_aout_0reg_a4_a_areg0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adata_ox_a4_a_a3 = nRESET_acombout & inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a & inst_aI3_aacc_c_a0_a_a4_a
-- inst10_aout_0reg_a4_a_areg0 = DFFEA(inst_aI4_adata_ox_a4_a_a3, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst10_ai_a1, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A000",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => nRESET_acombout,
	datac => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a4_a,
	aclr => NOT_nRESET_acombout,
	ena => inst10_ai_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adata_ox_a4_a_a3,
	regout => inst10_aout_0reg_a4_a_areg0);

inst10_aout_0reg_a5_a_areg0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adata_ox_a5_a_a2 = inst_aI3_aacc_c_a0_a_a5_a & inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a & nRESET_acombout
-- inst10_aout_0reg_a5_a_areg0 = DFFEA(inst_aI4_adata_ox_a5_a_a2, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst10_ai_a1, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A000",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_c_a0_a_a5_a,
	datac => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a,
	datad => nRESET_acombout,
	aclr => NOT_nRESET_acombout,
	ena => inst10_ai_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adata_ox_a5_a_a2,
	regout => inst10_aout_0reg_a5_a_areg0);

inst7_aaltsyncram_component_aram_block_a0_a_a7_a : cyclone_ram_block 
-- pragma translate_off
GENERIC MAP (
	mem4 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem3 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011110100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111100000000000",
	mem2 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001100100000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	operation_mode => "single_port",
	ram_block_type => "auto",
	logical_ram_name => "lpm_ram_dq0:inst7|altsyncram:altsyncram_component|ALTSYNCRAM INSTANTIATION",
	init_file => "../ram.mif",
	init_file_layout => "port_a",
	data_interleave_width_in_bits => 1,
	data_interleave_offset_in_bits => 1,
	port_a_byte_enable_clock => "none",
	port_a_logical_ram_depth => 256,
	port_a_logical_ram_width => 8,
	port_a_data_in_clear => "none",
	port_a_address_clear => "none",
	port_a_write_enable_clear => "none",
	port_a_byte_enable_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_out_clear => "none",
	port_a_first_address => 0,
	port_a_last_address => 255,
	port_a_first_bit_number => 7,
	port_a_data_width => 8,
	port_a_address_width => 8)
-- pragma translate_on
PORT MAP (
	portawe => inst5_ai_a45,
	clk0 => UCLK_acombout,
	ena0 => VCC,
	portaaddr => ww_inst7_aaltsyncram_component_aram_block_a0_a_a7_a_aaddress,
	portadatain => ww_inst7_aaltsyncram_component_aram_block_a0_a_a7_a_adatain,
	devclrn => devclrn,
	devpor => devpor,
	portadataout => ww_inst7_aaltsyncram_component_aram_block_a0_a_a7_a_adataout);

inst_aI3_adata_x_a3_a_a367_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a3_a_a367 = inst5_amux_c_a0_a & inst7_aaltsyncram_component_aq_a_a3_a # !inst5_amux_c_a0_a & (inst5_amux_c_a1_a & inst7_aaltsyncram_component_aq_a_a3_a # !inst5_amux_c_a1_a & inst8_arx_uart_fifo_a3_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FE10",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_amux_c_a0_a,
	datab => inst5_amux_c_a1_a,
	datac => inst8_arx_uart_fifo_a3_a,
	datad => inst7_aaltsyncram_component_aq_a_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a3_a_a367);

inst_aI3_adata_x_a3_a_a381_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a3_a_a381 = inst5_amux_c_a2_a & inst_aI3_adata_x_a7_a_a1620 & inst_aI3_adata_x_a3_a_a367 & !inst_aI4_ai_a528

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_amux_c_a2_a,
	datab => inst_aI3_adata_x_a7_a_a1620,
	datac => inst_aI3_adata_x_a3_a_a367,
	datad => inst_aI4_ai_a528,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a3_a_a381);

inst2_ai_a301_I : cyclone_lcell 
-- Equation(s):
-- inst2_ai_a301 = !inst_aI5_ai_a18 & inst_aI5_ai_a21 & inst_aI5_ai_a15 & inst2_ai_a300

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_ai_a18,
	datab => inst_aI5_ai_a21,
	datac => inst_aI5_ai_a15,
	datad => inst2_ai_a300,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_ai_a301);

inst2_ai_a142_I : cyclone_lcell 
-- Equation(s):
-- inst2_ai_a142 = inst2_ai_a301 & (inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a0_a # !inst_aI4_andre_x_a1 & inst_aI4_adaddr_x_a0_a_a18)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "D800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_andre_x_a1,
	datab => inst_aI5_adaddr_c_a0_a,
	datac => inst_aI4_adaddr_x_a0_a_a18,
	datad => inst2_ai_a301,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_ai_a142);

inst2_atmr_reset_aI : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_reset = DFFEA(!inst_aI4_adata_ox_a1_a_a6, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst2_ai_a142, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a1_a_a6,
	aclr => NOT_nRESET_acombout,
	ena => inst2_ai_a142,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_reset);

inst2_ai_a74_I : cyclone_lcell 
-- Equation(s):
-- inst2_ai_a74 = inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a & (inst_aI5_ai_a12 # !inst2_ai_a301)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A0AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a,
	datac => inst_aI5_ai_a12,
	datad => inst2_ai_a301,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_ai_a74);

inst2_ai_a80_I : cyclone_lcell 
-- Equation(s):
-- inst2_ai_a80 = inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a7_a & (inst_aI5_ai_a12 # !inst2_ai_a301)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A0AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a7_a,
	datac => inst_aI5_ai_a12,
	datad => inst2_ai_a301,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_ai_a80);

inst2_ai_a77_I : cyclone_lcell 
-- Equation(s):
-- inst2_ai_a77 = inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a4_a & (inst_aI5_ai_a12 # !inst2_ai_a301)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a4_a,
	datac => inst_aI5_ai_a12,
	datad => inst2_ai_a301,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_ai_a77);

inst2_ai_a76_I : cyclone_lcell 
-- Equation(s):
-- inst2_ai_a76 = inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a & (inst_aI5_ai_a12 # !inst2_ai_a301)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a,
	datac => inst_aI5_ai_a12,
	datad => inst2_ai_a301,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_ai_a76);

inst2_ai_a75_I : cyclone_lcell 
-- Equation(s):
-- inst2_ai_a75 = inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a & (inst_aI5_ai_a12 # !inst2_ai_a301)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A0AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a,
	datac => inst_aI5_ai_a12,
	datad => inst2_ai_a301,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_ai_a75);

inst2_ai_a73_I : cyclone_lcell 
-- Equation(s):
-- inst2_ai_a73 = inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a & (inst_aI5_ai_a12 # !inst2_ai_a301)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a,
	datac => inst_aI5_ai_a12,
	datad => inst2_ai_a301,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_ai_a73);

inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a0_a : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a = DFFEA((!inst2_atmr_enable & inst2_ai_a73) # (inst2_atmr_enable & !inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a) & inst2_atmr_reset, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a_aCOUT0 = CARRY(inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a)
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a_aCOUT1 = CARRY(inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "33CC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a,
	datac => inst2_ai_a73,
	aclr => NOT_nRESET_acombout,
	sclr => NOT_inst2_atmr_reset,
	sload => NOT_inst2_atmr_enable,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a,
	cout0 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a_aCOUT0,
	cout1 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a_aCOUT1);

inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a1_a : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a = DFFEA((!inst2_atmr_enable & inst2_ai_a74) # (inst2_atmr_enable & inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a $ inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a_aCOUT0) & inst2_atmr_reset, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a_aCOUT0 = CARRY(!inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a_aCOUT0 # !inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a)
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a_aCOUT1 = CARRY(!inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a_aCOUT1 # !inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "5A5F",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a,
	datac => inst2_ai_a74,
	aclr => NOT_nRESET_acombout,
	sclr => NOT_inst2_atmr_reset,
	sload => NOT_inst2_atmr_enable,
	cin0 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a_aCOUT0,
	cin1 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a,
	cout0 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a_aCOUT0,
	cout1 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a_aCOUT1);

inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a2_a : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a = DFFEA((!inst2_atmr_enable & inst2_ai_a75) # (inst2_atmr_enable & inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a $ !inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a_aCOUT0) & inst2_atmr_reset, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a_aCOUT0 = CARRY(inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a & !inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a_aCOUT0)
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a_aCOUT1 = CARRY(inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a & !inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a_aCOUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "A50A",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a,
	datac => inst2_ai_a75,
	aclr => NOT_nRESET_acombout,
	sclr => NOT_inst2_atmr_reset,
	sload => NOT_inst2_atmr_enable,
	cin0 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a_aCOUT0,
	cin1 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a,
	cout0 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a_aCOUT0,
	cout1 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a_aCOUT1);

inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a3_a : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a = DFFEA((!inst2_atmr_enable & inst2_ai_a76) # (inst2_atmr_enable & inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a $ inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a_aCOUT0) & inst2_atmr_reset, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a_aCOUT0 = CARRY(!inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a_aCOUT0 # !inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a)
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a_aCOUT1 = CARRY(!inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a_aCOUT1 # !inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "3C3F",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a,
	datac => inst2_ai_a76,
	aclr => NOT_nRESET_acombout,
	sclr => NOT_inst2_atmr_reset,
	sload => NOT_inst2_atmr_enable,
	cin0 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a_aCOUT0,
	cin1 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a,
	cout0 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a_aCOUT0,
	cout1 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a_aCOUT1);

inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a4_a : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a4_a = DFFEA((!inst2_atmr_enable & inst2_ai_a77) # (inst2_atmr_enable & inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a4_a $ !inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a_aCOUT0) & inst2_atmr_reset, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a4_a_aCOUT = 

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "C30C",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a4_a,
	datac => inst2_ai_a77,
	aclr => NOT_nRESET_acombout,
	sclr => NOT_inst2_atmr_reset,
	sload => NOT_inst2_atmr_enable,
	cin0 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a_aCOUT0,
	cin1 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a4_a,
	cout => inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a4_a_aCOUT);

inst2_ai_a79_I : cyclone_lcell 
-- Equation(s):
-- inst2_ai_a79 = inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a & (inst_aI5_ai_a12 # !inst2_ai_a301)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a,
	datac => inst_aI5_ai_a12,
	datad => inst2_ai_a301,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_ai_a79);

inst2_ai_a78_I : cyclone_lcell 
-- Equation(s):
-- inst2_ai_a78 = inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a & (inst_aI5_ai_a12 # !inst2_ai_a301)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A0AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a,
	datac => inst_aI5_ai_a12,
	datad => inst2_ai_a301,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_ai_a78);

inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a5_a : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a = DFFEA((!inst2_atmr_enable & inst2_ai_a78) # (inst2_atmr_enable & inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a $ (!inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a4_a_aCOUT & GND) # (inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a4_a_aCOUT & VCC)) & inst2_atmr_reset, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a_aCOUT0 = CARRY(!inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a4_a_aCOUT # !inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a)
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a_aCOUT1 = CARRY(!inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a4_a_aCOUT # !inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "3C3F",
	cin_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a,
	datac => inst2_ai_a78,
	aclr => NOT_nRESET_acombout,
	sclr => NOT_inst2_atmr_reset,
	sload => NOT_inst2_atmr_enable,
	cin => inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a4_a_aCOUT,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a,
	cout0 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a_aCOUT0,
	cout1 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a_aCOUT1);

inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a6_a : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a = DFFEA((!inst2_atmr_enable & inst2_ai_a79) # (inst2_atmr_enable & inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a $ !(!inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a4_a_aCOUT & inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a_aCOUT0) # (inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a4_a_aCOUT & inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a_aCOUT1)) & inst2_atmr_reset, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a_aCOUT0 = CARRY(inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a & !inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a_aCOUT0)
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a_aCOUT1 = CARRY(inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a & !inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a_aCOUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "A50A",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a,
	datac => inst2_ai_a79,
	aclr => NOT_nRESET_acombout,
	sclr => NOT_inst2_atmr_reset,
	sload => NOT_inst2_atmr_enable,
	cin => inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a4_a_aCOUT,
	cin0 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a_aCOUT0,
	cin1 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a,
	cout0 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a_aCOUT0,
	cout1 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a_aCOUT1);

inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a7_a : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a7_a = DFFEA((!inst2_atmr_enable & inst2_ai_a80) # (inst2_atmr_enable & inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a7_a $ (!inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a4_a_aCOUT & inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a_aCOUT0) # (inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a4_a_aCOUT & inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a_aCOUT1)) & inst2_atmr_reset, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "5A5A",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a7_a,
	datac => inst2_ai_a80,
	aclr => NOT_nRESET_acombout,
	sclr => NOT_inst2_atmr_reset,
	sload => NOT_inst2_atmr_enable,
	cin => inst2_atmr_low_rtl_10_awysi_counter_acounter_cell_a4_a_aCOUT,
	cin0 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a_aCOUT0,
	cin1 => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a7_a);

inst2_areduce_nor_58_a30_I : cyclone_lcell 
-- Equation(s):
-- inst2_areduce_nor_58_a30 = inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a7_a # inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a # inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a # inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a4_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a7_a,
	datab => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a6_a,
	datac => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a5_a,
	datad => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_areduce_nor_58_a30);

inst2_atmr_enable_aI : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a152 = inst2_areduce_nor_58_a30 # inst2_areduce_nor_58_a35 # !D1_tmr_enable
-- inst2_atmr_enable = DFFEA(inst_aI4_adata_ox_a0_a_a7, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst2_ai_a142, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "FFAF",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_areduce_nor_58_a30,
	datac => inst_aI4_adata_ox_a0_a_a7,
	datad => inst2_areduce_nor_58_a35,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst2_ai_a142,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a152,
	regout => inst2_atmr_enable);

inst2_areduce_nor_58_a35_I : cyclone_lcell 
-- Equation(s):
-- inst2_areduce_nor_58_a35 = inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a # inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a # inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a # inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a1_a,
	datab => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a3_a,
	datac => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a2_a,
	datad => inst2_atmr_low_rtl_10_awysi_counter_asafe_q_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_areduce_nor_58_a35);

inst2_aadd_47_rtl_1_a0_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_a0 = !inst2_atmr_high_a0_a
-- inst2_aadd_47_rtl_1_a0COUT0 = CARRY(inst2_atmr_high_a0_a)
-- inst2_aadd_47_rtl_1_a0COUT1 = CARRY(inst2_atmr_high_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "33CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst2_atmr_high_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_a0,
	cout0 => inst2_aadd_47_rtl_1_a0COUT0,
	cout1 => inst2_aadd_47_rtl_1_a0COUT1);

inst2_aadd_47_rtl_1_rtl_652_a375_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a375 = inst2_ai_a345 & !inst2_areduce_nor_58_a30 & inst2_aadd_47_rtl_1_a0 & !inst2_areduce_nor_58_a35

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0020",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_ai_a345,
	datab => inst2_areduce_nor_58_a30,
	datac => inst2_aadd_47_rtl_1_a0,
	datad => inst2_areduce_nor_58_a35,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a375);

inst2_atmr_count_a7_a_a7_I : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_count_a7_a_a7 = !inst_aI5_ai_a12 & nRESET_acombout & inst2_ai_a301

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI5_ai_a12,
	datac => nRESET_acombout,
	datad => inst2_ai_a301,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_atmr_count_a7_a_a7);

inst2_atmr_count_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a435 = inst2_atmr_enable & (inst2_aadd_47_rtl_1_rtl_652_a375 # !inst2_ai_a345 & D1_tmr_count[0])

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "BA00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_aadd_47_rtl_1_rtl_652_a375,
	datab => inst2_ai_a345,
	datac => inst_aI4_adata_ox_a0_a_a7,
	datad => inst2_atmr_enable,
	aclr => GND,
	sload => VCC,
	ena => inst2_atmr_count_a7_a_a7,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a435);

inst2_aadd_47_rtl_1_rtl_652_a366_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a366 = inst_aI5_ai_a12 & inst2_atmr_high_a0_a # !inst_aI5_ai_a12 & (inst2_ai_a301 & inst_aI4_adata_ox_a0_a_a7 # !inst2_ai_a301 & inst2_atmr_high_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_adata_ox_a0_a_a7,
	datab => inst_aI5_ai_a12,
	datac => inst2_atmr_high_a0_a,
	datad => inst2_ai_a301,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a366);

inst2_atmr_high_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_high_a0_a = DFFEA(inst2_atmr_reset & (inst2_aadd_47_rtl_1_rtl_652_a435 # inst2_aadd_47_rtl_1_rtl_652_a152 & inst2_aadd_47_rtl_1_rtl_652_a366), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A8A0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_atmr_reset,
	datab => inst2_aadd_47_rtl_1_rtl_652_a152,
	datac => inst2_aadd_47_rtl_1_rtl_652_a435,
	datad => inst2_aadd_47_rtl_1_rtl_652_a366,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_high_a0_a);

inst2_aadd_47_rtl_1_a1_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_a1 = inst2_atmr_high_a1_a $ !inst2_aadd_47_rtl_1_a0COUT0
-- inst2_aadd_47_rtl_1_a1COUT0 = CARRY(!inst2_atmr_high_a1_a & !inst2_aadd_47_rtl_1_a0COUT0)
-- inst2_aadd_47_rtl_1_a1COUT1 = CARRY(!inst2_atmr_high_a1_a & !inst2_aadd_47_rtl_1_a0COUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "C303",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst2_atmr_high_a1_a,
	cin0 => inst2_aadd_47_rtl_1_a0COUT0,
	cin1 => inst2_aadd_47_rtl_1_a0COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_a1,
	cout0 => inst2_aadd_47_rtl_1_a1COUT0,
	cout1 => inst2_aadd_47_rtl_1_a1COUT1);

inst2_aadd_47_rtl_1_rtl_652_a357_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a357 = inst2_ai_a345 & !inst2_areduce_nor_58_a30 & inst2_aadd_47_rtl_1_a1 & !inst2_areduce_nor_58_a35

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0020",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_ai_a345,
	datab => inst2_areduce_nor_58_a30,
	datac => inst2_aadd_47_rtl_1_a1,
	datad => inst2_areduce_nor_58_a35,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a357);

inst2_atmr_count_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a428 = inst2_atmr_enable & (inst2_aadd_47_rtl_1_rtl_652_a357 # !inst2_ai_a345 & D1_tmr_count[1])

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "CC40",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_ai_a345,
	datab => inst2_atmr_enable,
	datac => inst_aI4_adata_ox_a1_a_a6,
	datad => inst2_aadd_47_rtl_1_rtl_652_a357,
	aclr => GND,
	sload => VCC,
	ena => inst2_atmr_count_a7_a_a7,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a428);

inst2_aadd_47_rtl_1_rtl_652_a348_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a348 = inst_aI5_ai_a12 & inst2_atmr_high_a1_a # !inst_aI5_ai_a12 & (inst2_ai_a301 & inst_aI4_adata_ox_a1_a_a6 # !inst2_ai_a301 & inst2_atmr_high_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_adata_ox_a1_a_a6,
	datab => inst_aI5_ai_a12,
	datac => inst2_atmr_high_a1_a,
	datad => inst2_ai_a301,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a348);

inst2_atmr_high_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_high_a1_a = DFFEA(inst2_atmr_reset & (inst2_aadd_47_rtl_1_rtl_652_a428 # inst2_aadd_47_rtl_1_rtl_652_a152 & inst2_aadd_47_rtl_1_rtl_652_a348), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A8A0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_atmr_reset,
	datab => inst2_aadd_47_rtl_1_rtl_652_a152,
	datac => inst2_aadd_47_rtl_1_rtl_652_a428,
	datad => inst2_aadd_47_rtl_1_rtl_652_a348,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_high_a1_a);

inst2_aadd_47_rtl_1_a2_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_a2 = inst2_atmr_high_a2_a $ inst2_aadd_47_rtl_1_a1COUT0
-- inst2_aadd_47_rtl_1_a2COUT0 = CARRY(inst2_atmr_high_a2_a # !inst2_aadd_47_rtl_1_a1COUT0)
-- inst2_aadd_47_rtl_1_a2COUT1 = CARRY(inst2_atmr_high_a2_a # !inst2_aadd_47_rtl_1_a1COUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "3CCF",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst2_atmr_high_a2_a,
	cin0 => inst2_aadd_47_rtl_1_a1COUT0,
	cin1 => inst2_aadd_47_rtl_1_a1COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_a2,
	cout0 => inst2_aadd_47_rtl_1_a2COUT0,
	cout1 => inst2_aadd_47_rtl_1_a2COUT1);

inst2_aadd_47_rtl_1_rtl_652_a339_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a339 = !inst2_areduce_nor_58_a35 & !inst2_areduce_nor_58_a30 & inst2_ai_a345 & inst2_aadd_47_rtl_1_a2

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "1000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_areduce_nor_58_a35,
	datab => inst2_areduce_nor_58_a30,
	datac => inst2_ai_a345,
	datad => inst2_aadd_47_rtl_1_a2,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a339);

inst2_atmr_count_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a421 = inst2_atmr_enable & (inst2_aadd_47_rtl_1_rtl_652_a339 # !inst2_ai_a345 & D1_tmr_count[2])

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "BA00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_aadd_47_rtl_1_rtl_652_a339,
	datab => inst2_ai_a345,
	datac => inst_aI4_adata_ox_a2_a_a5,
	datad => inst2_atmr_enable,
	aclr => GND,
	sload => VCC,
	ena => inst2_atmr_count_a7_a_a7,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a421);

inst2_aadd_47_rtl_1_rtl_652_a330_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a330 = inst2_ai_a301 & (inst_aI5_ai_a12 & inst2_atmr_high_a2_a # !inst_aI5_ai_a12 & inst_aI4_adata_ox_a2_a_a5) # !inst2_ai_a301 & inst2_atmr_high_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCAC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_adata_ox_a2_a_a5,
	datab => inst2_atmr_high_a2_a,
	datac => inst2_ai_a301,
	datad => inst_aI5_ai_a12,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a330);

inst2_atmr_high_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_high_a2_a = DFFEA(inst2_atmr_reset & (inst2_aadd_47_rtl_1_rtl_652_a421 # inst2_aadd_47_rtl_1_rtl_652_a152 & inst2_aadd_47_rtl_1_rtl_652_a330), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A888",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_atmr_reset,
	datab => inst2_aadd_47_rtl_1_rtl_652_a421,
	datac => inst2_aadd_47_rtl_1_rtl_652_a152,
	datad => inst2_aadd_47_rtl_1_rtl_652_a330,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_high_a2_a);

inst2_aadd_47_rtl_1_a3_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_a3 = inst2_atmr_high_a3_a $ !inst2_aadd_47_rtl_1_a2COUT0
-- inst2_aadd_47_rtl_1_a3COUT0 = CARRY(!inst2_atmr_high_a3_a & !inst2_aadd_47_rtl_1_a2COUT0)
-- inst2_aadd_47_rtl_1_a3COUT1 = CARRY(!inst2_atmr_high_a3_a & !inst2_aadd_47_rtl_1_a2COUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "A505",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_high_a3_a,
	cin0 => inst2_aadd_47_rtl_1_a2COUT0,
	cin1 => inst2_aadd_47_rtl_1_a2COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_a3,
	cout0 => inst2_aadd_47_rtl_1_a3COUT0,
	cout1 => inst2_aadd_47_rtl_1_a3COUT1);

inst2_aadd_47_rtl_1_a4_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_a4 = inst2_atmr_high_a4_a $ inst2_aadd_47_rtl_1_a3COUT0
-- inst2_aadd_47_rtl_1_a4COUT = 

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "3CCF",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst2_atmr_high_a4_a,
	cin0 => inst2_aadd_47_rtl_1_a3COUT0,
	cin1 => inst2_aadd_47_rtl_1_a3COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_a4,
	cout => inst2_aadd_47_rtl_1_a4COUT);

inst2_aadd_47_rtl_1_rtl_652_a303_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a303 = !inst2_areduce_nor_58_a35 & inst2_aadd_47_rtl_1_a4 & inst2_ai_a345 & !inst2_areduce_nor_58_a30

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0040",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_areduce_nor_58_a35,
	datab => inst2_aadd_47_rtl_1_a4,
	datac => inst2_ai_a345,
	datad => inst2_areduce_nor_58_a30,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a303);

inst2_atmr_count_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a407 = inst2_atmr_enable & (inst2_aadd_47_rtl_1_rtl_652_a303 # !inst2_ai_a345 & D1_tmr_count[4])

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "BA00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_aadd_47_rtl_1_rtl_652_a303,
	datab => inst2_ai_a345,
	datac => inst_aI4_adata_ox_a4_a_a3,
	datad => inst2_atmr_enable,
	aclr => GND,
	sload => VCC,
	ena => inst2_atmr_count_a7_a_a7,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a407);

inst2_aadd_47_rtl_1_rtl_652_a294_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a294 = inst_aI5_ai_a12 & inst2_atmr_high_a4_a # !inst_aI5_ai_a12 & (inst2_ai_a301 & inst_aI4_adata_ox_a4_a_a3 # !inst2_ai_a301 & inst2_atmr_high_a4_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CACC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_adata_ox_a4_a_a3,
	datab => inst2_atmr_high_a4_a,
	datac => inst_aI5_ai_a12,
	datad => inst2_ai_a301,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a294);

inst2_atmr_high_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_high_a4_a = DFFEA(inst2_atmr_reset & (inst2_aadd_47_rtl_1_rtl_652_a407 # inst2_aadd_47_rtl_1_rtl_652_a152 & inst2_aadd_47_rtl_1_rtl_652_a294), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A888",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_atmr_reset,
	datab => inst2_aadd_47_rtl_1_rtl_652_a407,
	datac => inst2_aadd_47_rtl_1_rtl_652_a152,
	datad => inst2_aadd_47_rtl_1_rtl_652_a294,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_high_a4_a);

inst2_aadd_47_rtl_1_a5_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_a5 = inst2_atmr_high_a5_a $ !(!inst2_aadd_47_rtl_1_a4COUT & GND) # (inst2_aadd_47_rtl_1_a4COUT & VCC)
-- inst2_aadd_47_rtl_1_a5COUT0 = CARRY(!inst2_atmr_high_a5_a & !inst2_aadd_47_rtl_1_a4COUT)
-- inst2_aadd_47_rtl_1_a5COUT1 = CARRY(!inst2_atmr_high_a5_a & !inst2_aadd_47_rtl_1_a4COUT)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "A505",
	cin_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_high_a5_a,
	cin => inst2_aadd_47_rtl_1_a4COUT,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_a5,
	cout0 => inst2_aadd_47_rtl_1_a5COUT0,
	cout1 => inst2_aadd_47_rtl_1_a5COUT1);

inst2_aadd_47_rtl_1_rtl_652_a285_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a285 = !inst2_areduce_nor_58_a35 & inst2_aadd_47_rtl_1_a5 & inst2_ai_a345 & !inst2_areduce_nor_58_a30

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0040",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_areduce_nor_58_a35,
	datab => inst2_aadd_47_rtl_1_a5,
	datac => inst2_ai_a345,
	datad => inst2_areduce_nor_58_a30,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a285);

inst2_atmr_count_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a400 = inst2_atmr_enable & (inst2_aadd_47_rtl_1_rtl_652_a285 # !inst2_ai_a345 & D1_tmr_count[5])

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "BA00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_aadd_47_rtl_1_rtl_652_a285,
	datab => inst2_ai_a345,
	datac => inst_aI4_adata_ox_a5_a_a2,
	datad => inst2_atmr_enable,
	aclr => GND,
	sload => VCC,
	ena => inst2_atmr_count_a7_a_a7,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a400);

inst2_aadd_47_rtl_1_rtl_652_a276_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a276 = inst_aI5_ai_a12 & inst2_atmr_high_a5_a # !inst_aI5_ai_a12 & (inst2_ai_a301 & inst_aI4_adata_ox_a5_a_a2 # !inst2_ai_a301 & inst2_atmr_high_a5_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_adata_ox_a5_a_a2,
	datab => inst_aI5_ai_a12,
	datac => inst2_atmr_high_a5_a,
	datad => inst2_ai_a301,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a276);

inst2_atmr_high_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_high_a5_a = DFFEA(inst2_atmr_reset & (inst2_aadd_47_rtl_1_rtl_652_a400 # inst2_aadd_47_rtl_1_rtl_652_a152 & inst2_aadd_47_rtl_1_rtl_652_a276), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A8A0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_atmr_reset,
	datab => inst2_aadd_47_rtl_1_rtl_652_a152,
	datac => inst2_aadd_47_rtl_1_rtl_652_a400,
	datad => inst2_aadd_47_rtl_1_rtl_652_a276,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_high_a5_a);

inst2_aadd_47_rtl_1_a6_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_a6 = inst2_atmr_high_a6_a $ (!inst2_aadd_47_rtl_1_a4COUT & inst2_aadd_47_rtl_1_a5COUT0) # (inst2_aadd_47_rtl_1_a4COUT & inst2_aadd_47_rtl_1_a5COUT1)
-- inst2_aadd_47_rtl_1_a6COUT0 = CARRY(inst2_atmr_high_a6_a # !inst2_aadd_47_rtl_1_a5COUT0)
-- inst2_aadd_47_rtl_1_a6COUT1 = CARRY(inst2_atmr_high_a6_a # !inst2_aadd_47_rtl_1_a5COUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "5AAF",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_high_a6_a,
	cin => inst2_aadd_47_rtl_1_a4COUT,
	cin0 => inst2_aadd_47_rtl_1_a5COUT0,
	cin1 => inst2_aadd_47_rtl_1_a5COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_a6,
	cout0 => inst2_aadd_47_rtl_1_a6COUT0,
	cout1 => inst2_aadd_47_rtl_1_a6COUT1);

inst2_aadd_47_rtl_1_rtl_652_a267_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a267 = !inst2_areduce_nor_58_a35 & inst2_aadd_47_rtl_1_a6 & !inst2_areduce_nor_58_a30 & inst2_ai_a345

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_areduce_nor_58_a35,
	datab => inst2_aadd_47_rtl_1_a6,
	datac => inst2_areduce_nor_58_a30,
	datad => inst2_ai_a345,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a267);

inst2_atmr_count_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a393 = inst2_atmr_enable & (inst2_aadd_47_rtl_1_rtl_652_a267 # !inst2_ai_a345 & D1_tmr_count[6])

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "CC40",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_ai_a345,
	datab => inst2_atmr_enable,
	datac => inst_aI4_adata_ox_a6_a_a1,
	datad => inst2_aadd_47_rtl_1_rtl_652_a267,
	aclr => GND,
	sload => VCC,
	ena => inst2_atmr_count_a7_a_a7,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a393);

inst2_aadd_47_rtl_1_rtl_652_a258_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a258 = inst_aI5_ai_a12 & inst2_atmr_high_a6_a # !inst_aI5_ai_a12 & (inst2_ai_a301 & inst_aI4_adata_ox_a6_a_a1 # !inst2_ai_a301 & inst2_atmr_high_a6_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ACAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_high_a6_a,
	datab => inst_aI4_adata_ox_a6_a_a1,
	datac => inst_aI5_ai_a12,
	datad => inst2_ai_a301,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a258);

inst2_atmr_high_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_high_a6_a = DFFEA(inst2_atmr_reset & (inst2_aadd_47_rtl_1_rtl_652_a393 # inst2_aadd_47_rtl_1_rtl_652_a152 & inst2_aadd_47_rtl_1_rtl_652_a258), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A8A0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_atmr_reset,
	datab => inst2_aadd_47_rtl_1_rtl_652_a152,
	datac => inst2_aadd_47_rtl_1_rtl_652_a393,
	datad => inst2_aadd_47_rtl_1_rtl_652_a258,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_high_a6_a);

inst2_aadd_47_rtl_1_a7_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_a7 = (!inst2_aadd_47_rtl_1_a4COUT & inst2_aadd_47_rtl_1_a6COUT0) # (inst2_aadd_47_rtl_1_a4COUT & inst2_aadd_47_rtl_1_a6COUT1) $ !inst2_atmr_high_a7_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "F00F",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datad => inst2_atmr_high_a7_a,
	cin => inst2_aadd_47_rtl_1_a4COUT,
	cin0 => inst2_aadd_47_rtl_1_a6COUT0,
	cin1 => inst2_aadd_47_rtl_1_a6COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_a7);

inst2_aadd_47_rtl_1_rtl_652_a249_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a249 = inst2_ai_a345 & !inst2_areduce_nor_58_a30 & inst2_aadd_47_rtl_1_a7 & !inst2_areduce_nor_58_a35

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0020",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_ai_a345,
	datab => inst2_areduce_nor_58_a30,
	datac => inst2_aadd_47_rtl_1_a7,
	datad => inst2_areduce_nor_58_a35,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a249);

inst2_atmr_count_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a386 = inst2_atmr_enable & (inst2_aadd_47_rtl_1_rtl_652_a249 # !inst2_ai_a345 & D1_tmr_count[7])

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "CC40",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_ai_a345,
	datab => inst2_atmr_enable,
	datac => inst_aI4_adata_ox_a7_a_a0,
	datad => inst2_aadd_47_rtl_1_rtl_652_a249,
	aclr => GND,
	sload => VCC,
	ena => inst2_atmr_count_a7_a_a7,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a386);

inst2_aadd_47_rtl_1_rtl_652_a240_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a240 = inst_aI5_ai_a12 & inst2_atmr_high_a7_a # !inst_aI5_ai_a12 & (inst2_ai_a301 & inst_aI4_adata_ox_a7_a_a0 # !inst2_ai_a301 & inst2_atmr_high_a7_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ACAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_high_a7_a,
	datab => inst_aI4_adata_ox_a7_a_a0,
	datac => inst_aI5_ai_a12,
	datad => inst2_ai_a301,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a240);

inst2_atmr_high_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_high_a7_a = DFFEA(inst2_atmr_reset & (inst2_aadd_47_rtl_1_rtl_652_a386 # inst2_aadd_47_rtl_1_rtl_652_a152 & inst2_aadd_47_rtl_1_rtl_652_a240), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A8A0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_atmr_reset,
	datab => inst2_aadd_47_rtl_1_rtl_652_a152,
	datac => inst2_aadd_47_rtl_1_rtl_652_a386,
	datad => inst2_aadd_47_rtl_1_rtl_652_a240,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_high_a7_a);

inst2_ai_a327_I : cyclone_lcell 
-- Equation(s):
-- inst2_ai_a327 = inst2_atmr_high_a6_a # inst2_atmr_high_a4_a # inst2_atmr_high_a5_a # inst2_atmr_high_a7_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_high_a6_a,
	datab => inst2_atmr_high_a4_a,
	datac => inst2_atmr_high_a5_a,
	datad => inst2_atmr_high_a7_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_ai_a327);

inst2_ai_a332_I : cyclone_lcell 
-- Equation(s):
-- inst2_ai_a332 = inst2_atmr_high_a3_a # inst2_atmr_high_a2_a # inst2_atmr_high_a1_a # inst2_atmr_high_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_high_a3_a,
	datab => inst2_atmr_high_a2_a,
	datac => inst2_atmr_high_a1_a,
	datad => inst2_atmr_high_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_ai_a332);

inst2_ai_a345_I : cyclone_lcell 
-- Equation(s):
-- inst2_ai_a345 = inst2_areduce_nor_58_a35 # inst2_ai_a327 # inst2_ai_a332 # inst2_areduce_nor_58_a30

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_areduce_nor_58_a35,
	datab => inst2_ai_a327,
	datac => inst2_ai_a332,
	datad => inst2_areduce_nor_58_a30,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_ai_a345);

inst2_aadd_47_rtl_1_rtl_652_a321_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a321 = inst2_ai_a345 & !inst2_areduce_nor_58_a30 & inst2_aadd_47_rtl_1_a3 & !inst2_areduce_nor_58_a35

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0020",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_ai_a345,
	datab => inst2_areduce_nor_58_a30,
	datac => inst2_aadd_47_rtl_1_a3,
	datad => inst2_areduce_nor_58_a35,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a321);

inst2_atmr_count_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a414 = inst2_atmr_enable & (inst2_aadd_47_rtl_1_rtl_652_a321 # !inst2_ai_a345 & D1_tmr_count[3])

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "BA00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_aadd_47_rtl_1_rtl_652_a321,
	datab => inst2_ai_a345,
	datac => inst_aI4_adata_ox_a3_a_a4,
	datad => inst2_atmr_enable,
	aclr => GND,
	sload => VCC,
	ena => inst2_atmr_count_a7_a_a7,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a414);

inst2_aadd_47_rtl_1_rtl_652_a312_I : cyclone_lcell 
-- Equation(s):
-- inst2_aadd_47_rtl_1_rtl_652_a312 = inst2_ai_a301 & (inst_aI5_ai_a12 & inst2_atmr_high_a3_a # !inst_aI5_ai_a12 & inst_aI4_adata_ox_a3_a_a4) # !inst2_ai_a301 & inst2_atmr_high_a3_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AACA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_high_a3_a,
	datab => inst_aI4_adata_ox_a3_a_a4,
	datac => inst2_ai_a301,
	datad => inst_aI5_ai_a12,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst2_aadd_47_rtl_1_rtl_652_a312);

inst2_atmr_high_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_high_a3_a = DFFEA(inst2_atmr_reset & (inst2_aadd_47_rtl_1_rtl_652_a414 # inst2_aadd_47_rtl_1_rtl_652_a152 & inst2_aadd_47_rtl_1_rtl_652_a312), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A888",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_atmr_reset,
	datab => inst2_aadd_47_rtl_1_rtl_652_a414,
	datac => inst2_aadd_47_rtl_1_rtl_652_a152,
	datad => inst2_aadd_47_rtl_1_rtl_652_a312,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_high_a3_a);

IN_INT_a3_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_IN_INT(3),
	combout => IN_INT_a3_a_acombout);

inst3_ai_a1_I : cyclone_lcell 
-- Equation(s):
-- inst3_ai_a1 = inst1_ai_a457 & !inst_aI5_ai_a12 & !inst5_areduce_nor_19_a54 & inst_aI5_ai_a24

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0200",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_ai_a457,
	datab => inst_aI5_ai_a12,
	datac => inst5_areduce_nor_19_a54,
	datad => inst_aI5_ai_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst3_ai_a1);

inst3_aint_mask_c_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_mask_c_a3_a = DFFEA(inst_aI4_adata_ox_a3_a_a4, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst3_ai_a1, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a3_a_a4,
	aclr => NOT_nRESET_acombout,
	ena => inst3_ai_a1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_mask_c_a3_a);

inst3_aint_masked_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_masked_a3_a = DFFEA(IN_INT_a3_a_acombout & inst3_aint_mask_c_a3_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => IN_INT_a3_a_acombout,
	datad => inst3_aint_mask_c_a3_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_masked_a3_a);

inst3_aint_masked_c_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_masked_c_a3_a = DFFEA(inst3_aint_masked_a3_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst3_aint_masked_a3_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_masked_c_a3_a);

inst3_aint_clr_c_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_clr_c_a3_a = DFFEA(inst_aI4_adata_ox_a3_a_a4, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst3_ai_a121, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a3_a_a4,
	aclr => NOT_nRESET_acombout,
	ena => inst3_ai_a121,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_clr_c_a3_a);

inst3_aint_pending_c_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_pending_c_a3_a = DFFEA(!inst3_aint_clr_c_a3_a & (inst3_aint_pending_c_a3_a # !inst3_aint_masked_c_a3_a & inst3_aint_masked_a3_a), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00DC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst3_aint_masked_c_a3_a,
	datab => inst3_aint_pending_c_a3_a,
	datac => inst3_aint_masked_a3_a,
	datad => inst3_aint_clr_c_a3_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_pending_c_a3_a);

inst5_aMux_14_rtl_239_a0_I : cyclone_lcell 
-- Equation(s):
-- inst5_aMux_14_rtl_239_a0 = inst5_amux_c_a0_a & (inst3_aint_pending_c_a3_a # inst5_amux_c_a1_a) # !inst5_amux_c_a0_a & !inst5_amux_c_a1_a & inst7_aaltsyncram_component_aq_a_a3_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E3E0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst3_aint_pending_c_a3_a,
	datab => inst5_amux_c_a1_a,
	datac => inst5_amux_c_a0_a,
	datad => inst7_aaltsyncram_component_aq_a_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aMux_14_rtl_239_a0);

inst10_ai_a113_I : cyclone_lcell 
-- Equation(s):
-- inst10_ai_a113 = inst_aI5_ai_a24 & inst_aI5_ai_a21 & !inst_aI5_ai_a18 & !inst_aI5_ai_a15

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0008",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_ai_a24,
	datab => inst_aI5_ai_a21,
	datac => inst_aI5_ai_a18,
	datad => inst_aI5_ai_a15,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_ai_a113);

inst10_ai_a3_I : cyclone_lcell 
-- Equation(s):
-- inst10_ai_a3 = inst_aI4_andre_x_a1 # inst_aI5_ai_a12 # !inst10_ai_a113 # !nRESET_acombout

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FBFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_andre_x_a1,
	datab => nRESET_acombout,
	datac => inst_aI5_ai_a12,
	datad => inst10_ai_a113,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_ai_a3);

PORTA_IN_a3_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTA_IN(3),
	combout => PORTA_IN_a3_a_acombout);

inst_aI4_andre_x_a26_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_andre_x_a26 = inst_aI2_aTC_x_a1_a_a22 # !inst_aI2_aC_store_x_a24 # !inst_aI2_andre_x_a44 # !inst_aI4_ai_a18

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F7FF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_ai_a18,
	datab => inst_aI2_andre_x_a44,
	datac => inst_aI2_aTC_x_a1_a_a22,
	datad => inst_aI2_aC_store_x_a24,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_andre_x_a26);

inst10_ai_a108_I : cyclone_lcell 
-- Equation(s):
-- inst10_ai_a108 = nRESET_acombout & !inst_aI4_andre_x_a26 & (!inst_aI4_ai_a20 # !inst_aI4_ai_a1256)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "020A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => nRESET_acombout,
	datab => inst_aI4_ai_a1256,
	datac => inst_aI4_andre_x_a26,
	datad => inst_aI4_ai_a20,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_ai_a108);

PORTB_IN_a3_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTB_IN(3),
	combout => PORTB_IN_a3_a_acombout);

inst10_areg_data_out_x_a3_a_a81_I : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a3_a_a81 = inst_aI5_ai_a12 & inst10_ai_a108 & PORTB_IN_a3_a_acombout & inst10_ai_a113

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_ai_a12,
	datab => inst10_ai_a108,
	datac => PORTB_IN_a3_a_acombout,
	datad => inst10_ai_a113,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a3_a_a81);

inst10_areg_data_out_c_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a3_a_a82 = K1_reg_data_out_c[3] & (!inst10_ai_a113 # !inst10_ai_a108 # !inst_aI5_ai_a12)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "70F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI5_ai_a12,
	datab => inst10_ai_a108,
	datac => inst10_areg_data_out_x_a3_a_a85,
	datad => inst10_ai_a113,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a3_a_a82);

inst10_areg_data_out_x_a3_a_a85_I : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a3_a_a85 = inst10_ai_a3 & (inst10_areg_data_out_x_a3_a_a81 # inst10_areg_data_out_x_a3_a_a82) # !inst10_ai_a3 & PORTA_IN_a3_a_acombout

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EEE4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst10_ai_a3,
	datab => PORTA_IN_a3_a_acombout,
	datac => inst10_areg_data_out_x_a3_a_a81,
	datad => inst10_areg_data_out_x_a3_a_a82,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a3_a_a85);

inst5_aMux_14_rtl_239_a1_I : cyclone_lcell 
-- Equation(s):
-- inst5_aMux_14_rtl_239_a1 = inst5_aMux_14_rtl_239_a0 & (inst2_atmr_high_a3_a # !inst5_amux_c_a1_a) # !inst5_aMux_14_rtl_239_a0 & inst5_amux_c_a1_a & inst10_areg_data_out_x_a3_a_a85

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BC8C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_high_a3_a,
	datab => inst5_aMux_14_rtl_239_a0,
	datac => inst5_amux_c_a1_a,
	datad => inst10_areg_data_out_x_a3_a_a85,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aMux_14_rtl_239_a1);

inst_aI3_adata_x_a3_a_a377_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a3_a_a377 = inst_aI3_adata_x_a3_a_a1811 # inst_aI3_adata_x_a3_a_a381 # inst_aI3_adata_x_a7_a_a1618 & inst5_aMux_14_rtl_239_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FEFA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a3_a_a1811,
	datab => inst_aI3_adata_x_a7_a_a1618,
	datac => inst_aI3_adata_x_a3_a_a381,
	datad => inst5_aMux_14_rtl_239_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a3_a_a377);

rtl_a1829_I : cyclone_lcell 
-- Equation(s):
-- rtl_a1829 = inst_aI2_aTD_c_a0_a & rtl_a14838 & (inst_aI3_aacc_c_a0_a_a3_a $ inst_aI3_adata_x_a3_a_a377)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI3_aacc_c_a0_a_a3_a,
	datac => rtl_a14838,
	datad => inst_aI3_adata_x_a3_a_a377,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1829);

rtl_a14854_I : cyclone_lcell 
-- Equation(s):
-- rtl_a14854 = inst_aI2_aTD_c_a2_a & (inst_aI2_aTC_c_a1_a $ inst_aI2_aTC_c_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "30C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI2_aTC_c_a1_a,
	datac => inst_aI2_aTD_c_a2_a,
	datad => inst_aI2_aTC_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a14854);

rtl_a2292_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2292 = !inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a3_a & !inst_aI2_aTD_c_a2_a & inst_aI3_aMux_201_rtl_95_a0

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a1_a,
	datab => inst_aI3_aacc_c_a0_a_a3_a,
	datac => inst_aI2_aTD_c_a2_a,
	datad => inst_aI3_aMux_201_rtl_95_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2292);

rtl_a3418_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3418 = inst_aI2_aTD_c_a2_a & (inst_aI3_aacc_c_a0_a_a3_a $ inst_aI2_aTD_c_a1_a) # !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "7D28",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI3_aacc_c_a0_a_a3_a,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3418);

rtl_a3308_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3308 = inst_aI2_aTD_c_a2_a & !inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a4_a # !inst_aI2_aTD_c_a2_a & (inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a4_a # !inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a3_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5E04",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI3_aacc_c_a0_a_a3_a,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3308);

rtl_a2439_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2439 = !inst_aI3_aMux_201_rtl_95_a0 & (inst_aI2_aTD_c_a0_a & rtl_a3418 # !inst_aI2_aTD_c_a0_a & rtl_a3308)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5140",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aMux_201_rtl_95_a0,
	datab => inst_aI2_aTD_c_a0_a,
	datac => rtl_a3418,
	datad => rtl_a3308,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2439);

inst_aI3_aadd_153_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_153_a1 = inst_aI3_aacc_c_a0_a_a0_a $ inst_aI3_adata_x_a0_a_a587
-- inst_aI3_aadd_153_a1COUT0 = CARRY(inst_aI3_aacc_c_a0_a_a0_a # !inst_aI3_adata_x_a0_a_a587)
-- inst_aI3_aadd_153_a1COUT1 = CARRY(inst_aI3_aacc_c_a0_a_a0_a # !inst_aI3_adata_x_a0_a_a587)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "66BB",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a0_a,
	datab => inst_aI3_adata_x_a0_a_a587,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_153_a1,
	cout0 => inst_aI3_aadd_153_a1COUT0,
	cout1 => inst_aI3_aadd_153_a1COUT1);

inst_aI3_aadd_153_a2_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_153_a2 = inst_aI3_aacc_c_a0_a_a1_a $ inst_aI3_adata_x_a1_a_a517 $ !inst_aI3_aadd_153_a1COUT0
-- inst_aI3_aadd_153_a2COUT0 = CARRY(inst_aI3_aacc_c_a0_a_a1_a & inst_aI3_adata_x_a1_a_a517 & !inst_aI3_aadd_153_a1COUT0 # !inst_aI3_aacc_c_a0_a_a1_a & (inst_aI3_adata_x_a1_a_a517 # !inst_aI3_aadd_153_a1COUT0))
-- inst_aI3_aadd_153_a2COUT1 = CARRY(inst_aI3_aacc_c_a0_a_a1_a & inst_aI3_adata_x_a1_a_a517 & !inst_aI3_aadd_153_a1COUT1 # !inst_aI3_aacc_c_a0_a_a1_a & (inst_aI3_adata_x_a1_a_a517 # !inst_aI3_aadd_153_a1COUT1))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "694D",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a1_a,
	datab => inst_aI3_adata_x_a1_a_a517,
	cin0 => inst_aI3_aadd_153_a1COUT0,
	cin1 => inst_aI3_aadd_153_a1COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_153_a2,
	cout0 => inst_aI3_aadd_153_a2COUT0,
	cout1 => inst_aI3_aadd_153_a2COUT1);

inst_aI3_aadd_153_a3_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_153_a3 = inst_aI3_aacc_c_a0_a_a2_a $ inst_aI3_adata_x_a2_a_a447 $ inst_aI3_aadd_153_a2COUT0
-- inst_aI3_aadd_153_a3COUT0 = CARRY(inst_aI3_aacc_c_a0_a_a2_a & (!inst_aI3_aadd_153_a2COUT0 # !inst_aI3_adata_x_a2_a_a447) # !inst_aI3_aacc_c_a0_a_a2_a & !inst_aI3_adata_x_a2_a_a447 & !inst_aI3_aadd_153_a2COUT0)
-- inst_aI3_aadd_153_a3COUT1 = CARRY(inst_aI3_aacc_c_a0_a_a2_a & (!inst_aI3_aadd_153_a2COUT1 # !inst_aI3_adata_x_a2_a_a447) # !inst_aI3_aacc_c_a0_a_a2_a & !inst_aI3_adata_x_a2_a_a447 & !inst_aI3_aadd_153_a2COUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "962B",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a2_a,
	datab => inst_aI3_adata_x_a2_a_a447,
	cin0 => inst_aI3_aadd_153_a2COUT0,
	cin1 => inst_aI3_aadd_153_a2COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_153_a3,
	cout0 => inst_aI3_aadd_153_a3COUT0,
	cout1 => inst_aI3_aadd_153_a3COUT1);

inst_aI3_aadd_153_a4_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_153_a4 = inst_aI3_aacc_c_a0_a_a3_a $ inst_aI3_adata_x_a3_a_a377 $ !inst_aI3_aadd_153_a3COUT0
-- inst_aI3_aadd_153_a4COUT0 = CARRY(inst_aI3_aacc_c_a0_a_a3_a & inst_aI3_adata_x_a3_a_a377 & !inst_aI3_aadd_153_a3COUT0 # !inst_aI3_aacc_c_a0_a_a3_a & (inst_aI3_adata_x_a3_a_a377 # !inst_aI3_aadd_153_a3COUT0))
-- inst_aI3_aadd_153_a4COUT1 = CARRY(inst_aI3_aacc_c_a0_a_a3_a & inst_aI3_adata_x_a3_a_a377 & !inst_aI3_aadd_153_a3COUT1 # !inst_aI3_aacc_c_a0_a_a3_a & (inst_aI3_adata_x_a3_a_a377 # !inst_aI3_aadd_153_a3COUT1))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "694D",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a3_a,
	datab => inst_aI3_adata_x_a3_a_a377,
	cin0 => inst_aI3_aadd_153_a3COUT0,
	cin1 => inst_aI3_aadd_153_a3COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_153_a4,
	cout0 => inst_aI3_aadd_153_a4COUT0,
	cout1 => inst_aI3_aadd_153_a4COUT1);

inst_aI3_aadd_129_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_129_a0 = inst_aI3_aacc_c_a0_a_a0_a $ inst_aI3_adata_x_a0_a_a587
-- inst_aI3_aadd_129_a0COUT0 = CARRY(inst_aI3_aacc_c_a0_a_a0_a & inst_aI3_adata_x_a0_a_a587)
-- inst_aI3_aadd_129_a0COUT1 = CARRY(inst_aI3_aacc_c_a0_a_a0_a & inst_aI3_adata_x_a0_a_a587)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "6688",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a0_a,
	datab => inst_aI3_adata_x_a0_a_a587,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_129_a0,
	cout0 => inst_aI3_aadd_129_a0COUT0,
	cout1 => inst_aI3_aadd_129_a0COUT1);

inst_aI3_aadd_129_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_129_a1 = inst_aI3_aacc_c_a0_a_a1_a $ inst_aI3_adata_x_a1_a_a517 $ inst_aI3_aadd_129_a0COUT0
-- inst_aI3_aadd_129_a1COUT0 = CARRY(inst_aI3_aacc_c_a0_a_a1_a & !inst_aI3_adata_x_a1_a_a517 & !inst_aI3_aadd_129_a0COUT0 # !inst_aI3_aacc_c_a0_a_a1_a & (!inst_aI3_aadd_129_a0COUT0 # !inst_aI3_adata_x_a1_a_a517))
-- inst_aI3_aadd_129_a1COUT1 = CARRY(inst_aI3_aacc_c_a0_a_a1_a & !inst_aI3_adata_x_a1_a_a517 & !inst_aI3_aadd_129_a0COUT1 # !inst_aI3_aacc_c_a0_a_a1_a & (!inst_aI3_aadd_129_a0COUT1 # !inst_aI3_adata_x_a1_a_a517))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "9617",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a1_a,
	datab => inst_aI3_adata_x_a1_a_a517,
	cin0 => inst_aI3_aadd_129_a0COUT0,
	cin1 => inst_aI3_aadd_129_a0COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_129_a1,
	cout0 => inst_aI3_aadd_129_a1COUT0,
	cout1 => inst_aI3_aadd_129_a1COUT1);

inst_aI3_aadd_129_a2_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_129_a2 = inst_aI3_aacc_c_a0_a_a2_a $ inst_aI3_adata_x_a2_a_a447 $ !inst_aI3_aadd_129_a1COUT0
-- inst_aI3_aadd_129_a2COUT0 = CARRY(inst_aI3_aacc_c_a0_a_a2_a & (inst_aI3_adata_x_a2_a_a447 # !inst_aI3_aadd_129_a1COUT0) # !inst_aI3_aacc_c_a0_a_a2_a & inst_aI3_adata_x_a2_a_a447 & !inst_aI3_aadd_129_a1COUT0)
-- inst_aI3_aadd_129_a2COUT1 = CARRY(inst_aI3_aacc_c_a0_a_a2_a & (inst_aI3_adata_x_a2_a_a447 # !inst_aI3_aadd_129_a1COUT1) # !inst_aI3_aacc_c_a0_a_a2_a & inst_aI3_adata_x_a2_a_a447 & !inst_aI3_aadd_129_a1COUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "698E",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a2_a,
	datab => inst_aI3_adata_x_a2_a_a447,
	cin0 => inst_aI3_aadd_129_a1COUT0,
	cin1 => inst_aI3_aadd_129_a1COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_129_a2,
	cout0 => inst_aI3_aadd_129_a2COUT0,
	cout1 => inst_aI3_aadd_129_a2COUT1);

inst_aI3_aadd_129_a3_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_129_a3 = inst_aI3_aacc_c_a0_a_a3_a $ inst_aI3_adata_x_a3_a_a377 $ inst_aI3_aadd_129_a2COUT0
-- inst_aI3_aadd_129_a3COUT0 = CARRY(inst_aI3_aacc_c_a0_a_a3_a & !inst_aI3_adata_x_a3_a_a377 & !inst_aI3_aadd_129_a2COUT0 # !inst_aI3_aacc_c_a0_a_a3_a & (!inst_aI3_aadd_129_a2COUT0 # !inst_aI3_adata_x_a3_a_a377))
-- inst_aI3_aadd_129_a3COUT1 = CARRY(inst_aI3_aacc_c_a0_a_a3_a & !inst_aI3_adata_x_a3_a_a377 & !inst_aI3_aadd_129_a2COUT1 # !inst_aI3_aacc_c_a0_a_a3_a & (!inst_aI3_aadd_129_a2COUT1 # !inst_aI3_adata_x_a3_a_a377))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "9617",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a3_a,
	datab => inst_aI3_adata_x_a3_a_a377,
	cin0 => inst_aI3_aadd_129_a2COUT0,
	cin1 => inst_aI3_aadd_129_a2COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_129_a3,
	cout0 => inst_aI3_aadd_129_a3COUT0,
	cout1 => inst_aI3_aadd_129_a3COUT1);

inst_aI3_aMux_175_rtl_67_rtl_534_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aMux_175_rtl_67_rtl_534_a0 = inst_aI2_aTD_c_a1_a & (inst_aI3_aadd_153_a4 # inst_aI2_aTD_c_a0_a) # !inst_aI2_aTD_c_a1_a & !inst_aI2_aTD_c_a0_a & inst_aI3_aadd_129_a3

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E3E0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aadd_153_a4,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI3_aadd_129_a3,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_175_rtl_67_rtl_534_a0);

inst_aI3_aMux_175_rtl_67_rtl_534_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aMux_175_rtl_67_rtl_534_a1 = inst_aI3_aacc_c_a0_a_a3_a & (inst_aI3_aMux_175_rtl_67_rtl_534_a0 # inst_aI2_aTD_c_a0_a & inst_aI3_adata_x_a3_a_a377) # !inst_aI3_aacc_c_a0_a_a3_a & inst_aI3_aMux_175_rtl_67_rtl_534_a0 & (inst_aI3_adata_x_a3_a_a377 # !inst_aI2_aTD_c_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FD80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI3_aacc_c_a0_a_a3_a,
	datac => inst_aI3_adata_x_a3_a_a377,
	datad => inst_aI3_aMux_175_rtl_67_rtl_534_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_175_rtl_67_rtl_534_a1);

rtl_a15320_I : cyclone_lcell 
-- Equation(s):
-- rtl_a15320 = rtl_a2292 # rtl_a2439 # rtl_a14854 & inst_aI3_aMux_175_rtl_67_rtl_534_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FEFC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a14854,
	datab => rtl_a2292,
	datac => rtl_a2439,
	datad => inst_aI3_aMux_175_rtl_67_rtl_534_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a15320);

rtl_a2438_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2438 = rtl_a1829 # rtl_a15320 # rtl_a14847 & inst_aI3_adata_x_a3_a_a377

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFEC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a14847,
	datab => rtl_a1829,
	datac => inst_aI3_adata_x_a3_a_a377,
	datad => rtl_a15320,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2438);

inst_aI3_aacc_c_a0_a_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a3_a_a108 = inst_aI3_aacc_a0_a_a3_a_a4273 # inst_aI3_aacc_a0_a_a7_a_a4225 & !inst_aI2_aTC_c_a2_a & rtl_a2438
-- inst_aI3_aacc_c_a0_a_a3_a = DFFEA(inst_aI3_aacc_a0_a_a3_a_a108, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F2F0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_a0_a_a7_a_a4225,
	datab => inst_aI2_aTC_c_a2_a,
	datac => inst_aI3_aacc_a0_a_a3_a_a4273,
	datad => rtl_a2438,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a3_a_a108,
	regout => inst_aI3_aacc_c_a0_a_a3_a);

inst_aI3_aacc_i_a0_a_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a3_a_a4273 = inst_aI3_aacc_a0_a_a8_a_a63 & (inst_aI3_aacc_c_a0_a_a3_a # inst_aI3_aacc_a0_a_a7_a_a4227 & N1_acc_i[0][3]) # !inst_aI3_aacc_a0_a_a8_a_a63 & inst_aI3_aacc_a0_a_a7_a_a4227 & N1_acc_i[0][3]

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "EAC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_a0_a_a8_a_a63,
	datab => inst_aI3_aacc_a0_a_a7_a_a4227,
	datac => inst_aI3_aacc_a0_a_a3_a_a108,
	datad => inst_aI3_aacc_c_a0_a_a3_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst_aI2_aint_start_c,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a3_a_a4273);

inst10_aout_0reg_a3_a_areg0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adata_ox_a3_a_a4 = inst_aI3_aacc_c_a0_a_a3_a & inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a & nRESET_acombout
-- inst10_aout_0reg_a3_a_areg0 = DFFEA(inst_aI4_adata_ox_a3_a_a4, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst10_ai_a1, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C000",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst_aI3_aacc_c_a0_a_a3_a,
	datac => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a,
	datad => nRESET_acombout,
	aclr => NOT_nRESET_acombout,
	ena => inst10_ai_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adata_ox_a3_a_a4,
	regout => inst10_aout_0reg_a3_a_areg0);

inst_aI3_adata_x_a5_a_a227_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a5_a_a227 = inst5_amux_c_a1_a & inst7_aaltsyncram_component_aq_a_a5_a # !inst5_amux_c_a1_a & (inst5_amux_c_a0_a & inst7_aaltsyncram_component_aq_a_a5_a # !inst5_amux_c_a0_a & inst8_arx_uart_fifo_a5_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FE04",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_amux_c_a1_a,
	datab => inst8_arx_uart_fifo_a5_a,
	datac => inst5_amux_c_a0_a,
	datad => inst7_aaltsyncram_component_aq_a_a5_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a5_a_a227);

inst_aI3_adata_x_a5_a_a241_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a5_a_a241 = inst5_amux_c_a2_a & inst_aI3_adata_x_a5_a_a227 & inst_aI3_adata_x_a7_a_a1620 & !inst_aI4_ai_a528

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_amux_c_a2_a,
	datab => inst_aI3_adata_x_a5_a_a227,
	datac => inst_aI3_adata_x_a7_a_a1620,
	datad => inst_aI4_ai_a528,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a5_a_a241);

inst_aI2_adata_is_c_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a5_a_a239 = !inst_aI2_aTC_c_a0_a & !inst_aI2_aTC_c_a2_a & M1_data_is_c[5] & inst_aI2_aTC_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "1000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aTC_c_a0_a,
	datab => inst_aI2_aTC_c_a2_a,
	datac => inst6_aaltsyncram_component_aq_a_a9_a,
	datad => inst_aI2_aTC_c_a1_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a5_a_a239);

inst_aI3_adata_x_a5_a_a232_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a5_a_a232 = inst_aI4_aireg_c_a5_a & (inst_aI4_aiinc_c_a5_a # !inst_aI4_areduce_nor_106) # !inst_aI4_aireg_c_a5_a & inst_aI4_aiinc_c_a5_a & inst_aI4_areduce_nor_106

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI4_aireg_c_a5_a,
	datac => inst_aI4_aiinc_c_a5_a,
	datad => inst_aI4_areduce_nor_106,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a5_a_a232);

inst_aI3_adata_x_a5_a_a1745_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a5_a_a1745 = inst_aI3_adata_x_a5_a_a239 # inst_aI3_adata_x_a7_a_a1620 & inst_aI3_adata_x_a5_a_a232 & inst_aI4_ai_a528

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ECCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a7_a_a1620,
	datab => inst_aI3_adata_x_a5_a_a239,
	datac => inst_aI3_adata_x_a5_a_a232,
	datad => inst_aI4_ai_a528,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a5_a_a1745);

inst3_aint_mask_c_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_mask_c_a5_a = DFFEA(inst_aI4_adata_ox_a5_a_a2, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst3_ai_a1, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a5_a_a2,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst3_ai_a1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_mask_c_a5_a);

rtl_a15549_I : cyclone_lcell 
-- Equation(s):
-- rtl_a15549 = !inst_aI5_adaddr_c_a0_a & inst_aI4_andre_x_a1 # !nRESET_acombout

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5F0F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_adaddr_c_a0_a,
	datac => nRESET_acombout,
	datad => inst_aI4_andre_x_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a15549);

inst5_amux_c_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_ai_a500 = inst_aI5_ai_a24 & !inst_aI5_ai_a21 & !inst_aI5_ai_a15 & inst_aI5_ai_a18
-- inst5_amux_c_a2_a = DFFEA(inst1_ai_a500, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0200",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI5_ai_a24,
	datab => inst_aI5_ai_a21,
	datac => inst_aI5_ai_a15,
	datad => inst_aI5_ai_a18,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_ai_a500,
	regout => inst5_amux_c_a2_a);

inst8_arx_uart_full_c_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_full_c = DFFEA(!rtl_a15549 & inst1_ai_a500 & (inst_aI5_andwe_c # !inst_aI5_ai_a12), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4500",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => rtl_a15549,
	datab => inst_aI5_andwe_c,
	datac => inst_aI5_ai_a12,
	datad => inst1_ai_a500,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_full_c);

inst8_arx_uart_full_s_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_full_s = DFFEA(inst8_arx_uart_fifo_a7_a_a37 & (!inst8_arx_8_count_a2_a # !inst8_arx_8_count_a1_a # !inst8_arx_8_count_a0_a), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "7F00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst8_arx_8_count_a0_a,
	datab => inst8_arx_8_count_a1_a,
	datac => inst8_arx_8_count_a2_a,
	datad => inst8_arx_uart_fifo_a7_a_a37,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_full_s);

inst8_arx_uart_full_d_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_full_d = DFFEA(inst8_arx_uart_full_s # inst8_arx_uart_full_d & !inst8_arx_uart_full_c, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0FC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst8_arx_uart_full_d,
	datac => inst8_arx_uart_full_s,
	datad => inst8_arx_uart_full_c,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_full_d);

inst3_aint_masked_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_masked_a5_a = DFFEA(inst3_aint_mask_c_a5_a & !inst8_arx_uart_full_c & inst8_arx_uart_full_d, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0C00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst3_aint_mask_c_a5_a,
	datac => inst8_arx_uart_full_c,
	datad => inst8_arx_uart_full_d,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_masked_a5_a);

inst3_aint_masked_c_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_masked_c_a5_a = DFFEA(inst3_aint_masked_a5_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst3_aint_masked_a5_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_masked_c_a5_a);

inst3_aint_clr_c_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_clr_c_a5_a = DFFEA(inst_aI4_adata_ox_a5_a_a2, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst3_ai_a121, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a5_a_a2,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst3_ai_a121,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_clr_c_a5_a);

inst3_aint_pending_c_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_pending_c_a5_a = DFFEA(!inst3_aint_clr_c_a5_a & (inst3_aint_pending_c_a5_a # !inst3_aint_masked_c_a5_a & inst3_aint_masked_a5_a), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0B0A",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst3_aint_pending_c_a5_a,
	datab => inst3_aint_masked_c_a5_a,
	datac => inst3_aint_clr_c_a5_a,
	datad => inst3_aint_masked_a5_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_pending_c_a5_a);

inst5_aMux_12_rtl_233_a0_I : cyclone_lcell 
-- Equation(s):
-- inst5_aMux_12_rtl_233_a0 = inst5_amux_c_a0_a & (inst3_aint_pending_c_a5_a # inst5_amux_c_a1_a) # !inst5_amux_c_a0_a & inst7_aaltsyncram_component_aq_a_a5_a & !inst5_amux_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FA0C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst3_aint_pending_c_a5_a,
	datab => inst7_aaltsyncram_component_aq_a_a5_a,
	datac => inst5_amux_c_a1_a,
	datad => inst5_amux_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aMux_12_rtl_233_a0);

PORTA_IN_a5_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTA_IN(5),
	combout => PORTA_IN_a5_a_acombout);

PORTB_IN_a5_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTB_IN(5),
	combout => PORTB_IN_a5_a_acombout);

inst10_areg_data_out_x_a5_a_a61_I : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a5_a_a61 = PORTB_IN_a5_a_acombout & inst_aI5_ai_a12 & inst10_ai_a108 & inst10_ai_a113

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => PORTB_IN_a5_a_acombout,
	datab => inst_aI5_ai_a12,
	datac => inst10_ai_a108,
	datad => inst10_ai_a113,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a5_a_a61);

inst10_areg_data_out_c_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a5_a_a62 = K1_reg_data_out_c[5] & (!inst10_ai_a113 # !inst_aI5_ai_a12 # !inst10_ai_a108)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "70F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst10_ai_a108,
	datab => inst_aI5_ai_a12,
	datac => inst10_areg_data_out_x_a5_a_a65,
	datad => inst10_ai_a113,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a5_a_a62);

inst10_areg_data_out_x_a5_a_a65_I : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a5_a_a65 = inst10_ai_a3 & (inst10_areg_data_out_x_a5_a_a61 # inst10_areg_data_out_x_a5_a_a62) # !inst10_ai_a3 & PORTA_IN_a5_a_acombout

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EEE2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => PORTA_IN_a5_a_acombout,
	datab => inst10_ai_a3,
	datac => inst10_areg_data_out_x_a5_a_a61,
	datad => inst10_areg_data_out_x_a5_a_a62,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a5_a_a65);

inst5_aMux_12_rtl_233_a1_I : cyclone_lcell 
-- Equation(s):
-- inst5_aMux_12_rtl_233_a1 = inst5_aMux_12_rtl_233_a0 & (inst2_atmr_high_a5_a # !inst5_amux_c_a1_a) # !inst5_aMux_12_rtl_233_a0 & inst5_amux_c_a1_a & inst10_areg_data_out_x_a5_a_a65

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BCB0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_high_a5_a,
	datab => inst5_amux_c_a1_a,
	datac => inst5_aMux_12_rtl_233_a0,
	datad => inst10_areg_data_out_x_a5_a_a65,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aMux_12_rtl_233_a1);

inst_aI3_adata_x_a5_a_a237_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a5_a_a237 = inst_aI3_adata_x_a5_a_a241 # inst_aI3_adata_x_a5_a_a1745 # inst_aI3_adata_x_a7_a_a1618 & inst5_aMux_12_rtl_233_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FEFA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a5_a_a241,
	datab => inst_aI3_adata_x_a7_a_a1618,
	datac => inst_aI3_adata_x_a5_a_a1745,
	datad => inst5_aMux_12_rtl_233_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a5_a_a237);

rtl_a1747_I : cyclone_lcell 
-- Equation(s):
-- rtl_a1747 = inst_aI2_aTD_c_a0_a & rtl_a14838 & (inst_aI3_aacc_c_a0_a_a5_a $ inst_aI3_adata_x_a5_a_a237)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI3_aacc_c_a0_a_a5_a,
	datac => rtl_a14838,
	datad => inst_aI3_adata_x_a5_a_a237,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1747);

rtl_a2280_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2280 = !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a5_a & !inst_aI2_aTD_c_a1_a & inst_aI3_aMux_201_rtl_95_a0

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI3_aacc_c_a0_a_a5_a,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI3_aMux_201_rtl_95_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2280);

rtl_a3398_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3398 = inst_aI2_aTD_c_a2_a & (inst_aI3_aacc_c_a0_a_a5_a $ inst_aI2_aTD_c_a1_a) # !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a4_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3CAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a4_a,
	datab => inst_aI3_aacc_c_a0_a_a5_a,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI2_aTD_c_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3398);

rtl_a3286_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3286 = inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a6_a & !inst_aI2_aTD_c_a2_a # !inst_aI2_aTD_c_a1_a & (inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a6_a # !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a5_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "22B8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a6_a,
	datab => inst_aI2_aTD_c_a1_a,
	datac => inst_aI3_aacc_c_a0_a_a5_a,
	datad => inst_aI2_aTD_c_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3286);

rtl_a2409_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2409 = !inst_aI3_aMux_201_rtl_95_a0 & (inst_aI2_aTD_c_a0_a & rtl_a3398 # !inst_aI2_aTD_c_a0_a & rtl_a3286)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3120",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI3_aMux_201_rtl_95_a0,
	datac => rtl_a3398,
	datad => rtl_a3286,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2409);

inst_aI3_aadd_129_a4_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_129_a4 = inst_aI3_aacc_c_a0_a_a4_a $ inst_aI3_adata_x_a4_a_a307 $ !inst_aI3_aadd_129_a3COUT0
-- inst_aI3_aadd_129_a4COUT = 

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "698E",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a4_a,
	datab => inst_aI3_adata_x_a4_a_a307,
	cin0 => inst_aI3_aadd_129_a3COUT0,
	cin1 => inst_aI3_aadd_129_a3COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_129_a4,
	cout => inst_aI3_aadd_129_a4COUT);

inst_aI3_aadd_129_a5_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_129_a5 = inst_aI3_aacc_c_a0_a_a5_a $ inst_aI3_adata_x_a5_a_a237 $ (!inst_aI3_aadd_129_a4COUT & GND) # (inst_aI3_aadd_129_a4COUT & VCC)
-- inst_aI3_aadd_129_a5COUT0 = CARRY(inst_aI3_aacc_c_a0_a_a5_a & !inst_aI3_adata_x_a5_a_a237 & !inst_aI3_aadd_129_a4COUT # !inst_aI3_aacc_c_a0_a_a5_a & (!inst_aI3_aadd_129_a4COUT # !inst_aI3_adata_x_a5_a_a237))
-- inst_aI3_aadd_129_a5COUT1 = CARRY(inst_aI3_aacc_c_a0_a_a5_a & !inst_aI3_adata_x_a5_a_a237 & !inst_aI3_aadd_129_a4COUT # !inst_aI3_aacc_c_a0_a_a5_a & (!inst_aI3_aadd_129_a4COUT # !inst_aI3_adata_x_a5_a_a237))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "9617",
	cin_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a5_a,
	datab => inst_aI3_adata_x_a5_a_a237,
	cin => inst_aI3_aadd_129_a4COUT,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_129_a5,
	cout0 => inst_aI3_aadd_129_a5COUT0,
	cout1 => inst_aI3_aadd_129_a5COUT1);

inst_aI3_aadd_153_a5_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_153_a5 = inst_aI3_aacc_c_a0_a_a4_a $ inst_aI3_adata_x_a4_a_a307 $ inst_aI3_aadd_153_a4COUT0
-- inst_aI3_aadd_153_a5COUT = 

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "962B",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a4_a,
	datab => inst_aI3_adata_x_a4_a_a307,
	cin0 => inst_aI3_aadd_153_a4COUT0,
	cin1 => inst_aI3_aadd_153_a4COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_153_a5,
	cout => inst_aI3_aadd_153_a5COUT);

inst_aI3_aadd_153_a6_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_153_a6 = inst_aI3_aacc_c_a0_a_a5_a $ inst_aI3_adata_x_a5_a_a237 $ !(!inst_aI3_aadd_153_a5COUT & GND) # (inst_aI3_aadd_153_a5COUT & VCC)
-- inst_aI3_aadd_153_a6COUT0 = CARRY(inst_aI3_aacc_c_a0_a_a5_a & inst_aI3_adata_x_a5_a_a237 & !inst_aI3_aadd_153_a5COUT # !inst_aI3_aacc_c_a0_a_a5_a & (inst_aI3_adata_x_a5_a_a237 # !inst_aI3_aadd_153_a5COUT))
-- inst_aI3_aadd_153_a6COUT1 = CARRY(inst_aI3_aacc_c_a0_a_a5_a & inst_aI3_adata_x_a5_a_a237 & !inst_aI3_aadd_153_a5COUT # !inst_aI3_aacc_c_a0_a_a5_a & (inst_aI3_adata_x_a5_a_a237 # !inst_aI3_aadd_153_a5COUT))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "694D",
	cin_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a5_a,
	datab => inst_aI3_adata_x_a5_a_a237,
	cin => inst_aI3_aadd_153_a5COUT,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_153_a6,
	cout0 => inst_aI3_aadd_153_a6COUT0,
	cout1 => inst_aI3_aadd_153_a6COUT1);

inst_aI3_aMux_173_rtl_55_rtl_522_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aMux_173_rtl_55_rtl_522_a0 = inst_aI2_aTD_c_a1_a & (inst_aI2_aTD_c_a0_a # inst_aI3_aadd_153_a6) # !inst_aI2_aTD_c_a1_a & !inst_aI2_aTD_c_a0_a & inst_aI3_aadd_129_a5

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DC98",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI2_aTD_c_a1_a,
	datac => inst_aI3_aadd_129_a5,
	datad => inst_aI3_aadd_153_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_173_rtl_55_rtl_522_a0);

inst_aI3_aMux_173_rtl_55_rtl_522_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aMux_173_rtl_55_rtl_522_a1 = inst_aI3_adata_x_a5_a_a237 & (inst_aI3_aMux_173_rtl_55_rtl_522_a0 # inst_aI3_aacc_c_a0_a_a5_a & inst_aI2_aTD_c_a0_a) # !inst_aI3_adata_x_a5_a_a237 & inst_aI3_aMux_173_rtl_55_rtl_522_a0 & (inst_aI3_aacc_c_a0_a_a5_a # !inst_aI2_aTD_c_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a5_a_a237,
	datab => inst_aI3_aacc_c_a0_a_a5_a,
	datac => inst_aI2_aTD_c_a0_a,
	datad => inst_aI3_aMux_173_rtl_55_rtl_522_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_173_rtl_55_rtl_522_a1);

rtl_a15234_I : cyclone_lcell 
-- Equation(s):
-- rtl_a15234 = rtl_a2280 # rtl_a2409 # rtl_a14854 & inst_aI3_aMux_173_rtl_55_rtl_522_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FEFA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a2280,
	datab => rtl_a14854,
	datac => rtl_a2409,
	datad => inst_aI3_aMux_173_rtl_55_rtl_522_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a15234);

rtl_a2408_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2408 = rtl_a1747 # rtl_a15234 # rtl_a14847 & inst_aI3_adata_x_a5_a_a237

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a14847,
	datab => inst_aI3_adata_x_a5_a_a237,
	datac => rtl_a1747,
	datad => rtl_a15234,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2408);

inst_aI3_aacc_c_a0_a_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a5_a_a88 = inst_aI3_aacc_a0_a_a5_a_a4263 # !inst_aI2_aTC_c_a2_a & inst_aI3_aacc_a0_a_a7_a_a4225 & rtl_a2408
-- inst_aI3_aacc_c_a0_a_a5_a = DFFEA(inst_aI3_aacc_a0_a_a5_a_a88, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BAAA",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_a0_a_a5_a_a4263,
	datab => inst_aI2_aTC_c_a2_a,
	datac => inst_aI3_aacc_a0_a_a7_a_a4225,
	datad => rtl_a2408,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a5_a_a88,
	regout => inst_aI3_aacc_c_a0_a_a5_a);

inst_aI3_aacc_i_a0_a_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a5_a_a4263 = inst_aI3_aacc_c_a0_a_a5_a & (inst_aI3_aacc_a0_a_a8_a_a63 # inst_aI3_aacc_a0_a_a7_a_a4227 & N1_acc_i[0][5]) # !inst_aI3_aacc_c_a0_a_a5_a & inst_aI3_aacc_a0_a_a7_a_a4227 & N1_acc_i[0][5]

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "EAC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_c_a0_a_a5_a,
	datab => inst_aI3_aacc_a0_a_a7_a_a4227,
	datac => inst_aI3_aacc_a0_a_a5_a_a88,
	datad => inst_aI3_aacc_a0_a_a8_a_a63,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst_aI2_aint_start_c,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a5_a_a4263);

inst_aI4_aadd_104_rtl_648_a108_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_rtl_648_a108 = inst_aI4_ai_a20 & (inst_aI4_areduce_nor_103 & inst_aI4_aireg_c_a5_a # !inst_aI4_areduce_nor_103 & inst_aI4_aadd_104_a5) # !inst_aI4_ai_a20 & inst_aI4_aireg_c_a5_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AEA2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aireg_c_a5_a,
	datab => inst_aI4_ai_a20,
	datac => inst_aI4_areduce_nor_103,
	datad => inst_aI4_aadd_104_a5,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_rtl_648_a108);

inst_aI4_aireg_i_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_rtl_648_a113 = inst_aI4_aireg_we_c & inst_aI3_aacc_c_a0_a_a5_a # !inst_aI4_aireg_we_c & inst_aI4_ai_a18 & inst_aI4_aadd_104_rtl_648_a108
-- inst_aI4_aireg_i_a5_a = DFFEA(inst_aI4_aadd_104_rtl_648_a113, GLOBAL(UCLK_acombout), VCC, , inst_aI4_aireg_i_a0_a_a6, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4A0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aireg_we_c,
	datab => inst_aI4_ai_a18,
	datac => inst_aI3_aacc_c_a0_a_a5_a,
	datad => inst_aI4_aadd_104_rtl_648_a108,
	aclr => GND,
	ena => inst_aI4_aireg_i_a0_a_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_rtl_648_a113,
	regout => inst_aI4_aireg_i_a5_a);

inst_aI4_aireg_c_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aireg_c_a5_a = DFFEA(inst_aI2_aE_x_aint_e_a0 & inst_aI4_aadd_104_rtl_648_a113 # !inst_aI2_aE_x_aint_e_a0 & (inst_aI2_aint_stop_x_a10 & inst_aI4_aireg_i_a5_a # !inst_aI2_aint_stop_x_a10 & inst_aI4_aadd_104_rtl_648_a113), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EF20",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aireg_i_a5_a,
	datab => inst_aI2_aE_x_aint_e_a0,
	datac => inst_aI2_aint_stop_x_a10,
	datad => inst_aI4_aadd_104_rtl_648_a113,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aireg_c_a5_a);

inst_aI5_adaddr_c_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI5_adaddr_c_a5_a = DFFEA(inst_aI4_ai_a18 & (inst6_aaltsyncram_component_aq_a_a9_a # inst_aI4_aireg_c_a5_a & inst_aI4_ai_a133), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C888",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst6_aaltsyncram_component_aq_a_a9_a,
	datab => inst_aI4_ai_a18,
	datac => inst_aI4_aireg_c_a5_a,
	datad => inst_aI4_ai_a133,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI5_adaddr_c_a5_a);

inst_aI4_adaddr_x_a5_a_a52_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adaddr_x_a5_a_a52 = inst6_aaltsyncram_component_aq_a_a9_a # inst_aI4_aireg_c_a5_a & inst_aI4_ai_a20 & !inst_aI4_areduce_nor_103

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF08",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aireg_c_a5_a,
	datab => inst_aI4_ai_a20,
	datac => inst_aI4_areduce_nor_103,
	datad => inst6_aaltsyncram_component_aq_a_a9_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adaddr_x_a5_a_a52);

inst_aI5_ai_a30_I : cyclone_lcell 
-- Equation(s):
-- inst_aI5_ai_a30 = inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a5_a # !inst_aI4_andre_x_a1 & inst_aI4_ai_a18 & inst_aI4_adaddr_x_a5_a_a52

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ACA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_adaddr_c_a5_a,
	datab => inst_aI4_ai_a18,
	datac => inst_aI4_andre_x_a1,
	datad => inst_aI4_adaddr_x_a5_a_a52,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI5_ai_a30);

inst_aI3_adata_x_a4_a_a297_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a4_a_a297 = inst5_amux_c_a1_a & inst7_aaltsyncram_component_aq_a_a4_a # !inst5_amux_c_a1_a & (inst5_amux_c_a0_a & inst7_aaltsyncram_component_aq_a_a4_a # !inst5_amux_c_a0_a & inst8_arx_uart_fifo_a4_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FE02",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_uart_fifo_a4_a,
	datab => inst5_amux_c_a1_a,
	datac => inst5_amux_c_a0_a,
	datad => inst7_aaltsyncram_component_aq_a_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a4_a_a297);

inst_aI3_adata_x_a4_a_a311_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a4_a_a311 = inst5_amux_c_a2_a & inst_aI3_adata_x_a7_a_a1620 & inst_aI3_adata_x_a4_a_a297 & !inst_aI4_ai_a528

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_amux_c_a2_a,
	datab => inst_aI3_adata_x_a7_a_a1620,
	datac => inst_aI3_adata_x_a4_a_a297,
	datad => inst_aI4_ai_a528,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a4_a_a311);

inst3_aint_mask_c_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_mask_c_a4_a = DFFEA(inst_aI4_adata_ox_a4_a_a3, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst3_ai_a1, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a4_a_a3,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst3_ai_a1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_mask_c_a4_a);

inst8_arx_uart_ovr_s_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_ovr_s = DFFEA(inst8_arx_uart_fifo_a7_a_a32 & inst8_arx_uart_fifo_a7_a_a29 & inst8_arx_uart_full_d & inst8_areduce_nor_7, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst8_arx_uart_fifo_a7_a_a32,
	datab => inst8_arx_uart_fifo_a7_a_a29,
	datac => inst8_arx_uart_full_d,
	datad => inst8_areduce_nor_7,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_ovr_s);

inst8_arx_uart_ovr_d_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_ovr_d = DFFEA(inst8_arx_uart_ovr_s # inst8_arx_uart_ovr_d & !inst8_arx_uart_full_c, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF0A",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst8_arx_uart_ovr_d,
	datac => inst8_arx_uart_full_c,
	datad => inst8_arx_uart_ovr_s,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_ovr_d);

inst3_aint_masked_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_masked_a4_a = DFFEA(!inst8_arx_uart_full_c & inst3_aint_mask_c_a4_a & inst8_arx_uart_ovr_d, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4400",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst8_arx_uart_full_c,
	datab => inst3_aint_mask_c_a4_a,
	datad => inst8_arx_uart_ovr_d,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_masked_a4_a);

inst3_aint_masked_c_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_masked_c_a4_a = DFFEA(inst3_aint_masked_a4_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst3_aint_masked_a4_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_masked_c_a4_a);

inst3_aint_clr_c_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_clr_c_a4_a = DFFEA(inst_aI4_adata_ox_a4_a_a3, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst3_ai_a121, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a4_a_a3,
	aclr => NOT_nRESET_acombout,
	ena => inst3_ai_a121,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_clr_c_a4_a);

inst3_aint_pending_c_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_pending_c_a4_a = DFFEA(!inst3_aint_clr_c_a4_a & (inst3_aint_pending_c_a4_a # !inst3_aint_masked_c_a4_a & inst3_aint_masked_a4_a), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00BA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst3_aint_pending_c_a4_a,
	datab => inst3_aint_masked_c_a4_a,
	datac => inst3_aint_masked_a4_a,
	datad => inst3_aint_clr_c_a4_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_pending_c_a4_a);

PORTA_IN_a4_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTA_IN(4),
	combout => PORTA_IN_a4_a_acombout);

PORTB_IN_a4_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTB_IN(4),
	combout => PORTB_IN_a4_a_acombout);

inst10_areg_data_out_x_a4_a_a71_I : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a4_a_a71 = inst10_ai_a108 & PORTB_IN_a4_a_acombout & inst_aI5_ai_a12 & inst10_ai_a113

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst10_ai_a108,
	datab => PORTB_IN_a4_a_acombout,
	datac => inst_aI5_ai_a12,
	datad => inst10_ai_a113,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a4_a_a71);

inst10_areg_data_out_c_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a4_a_a72 = K1_reg_data_out_c[4] & (!inst10_ai_a113 # !inst_aI5_ai_a12 # !inst10_ai_a108)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "70F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst10_ai_a108,
	datab => inst_aI5_ai_a12,
	datac => inst10_areg_data_out_x_a4_a_a75,
	datad => inst10_ai_a113,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a4_a_a72);

inst10_areg_data_out_x_a4_a_a75_I : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a4_a_a75 = inst10_ai_a3 & (inst10_areg_data_out_x_a4_a_a71 # inst10_areg_data_out_x_a4_a_a72) # !inst10_ai_a3 & PORTA_IN_a4_a_acombout

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EEE2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => PORTA_IN_a4_a_acombout,
	datab => inst10_ai_a3,
	datac => inst10_areg_data_out_x_a4_a_a71,
	datad => inst10_areg_data_out_x_a4_a_a72,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a4_a_a75);

inst5_aMux_13_rtl_236_a0_I : cyclone_lcell 
-- Equation(s):
-- inst5_aMux_13_rtl_236_a0 = inst5_amux_c_a1_a & (inst5_amux_c_a0_a # inst10_areg_data_out_x_a4_a_a75) # !inst5_amux_c_a1_a & inst7_aaltsyncram_component_aq_a_a4_a & !inst5_amux_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CEC2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst7_aaltsyncram_component_aq_a_a4_a,
	datab => inst5_amux_c_a1_a,
	datac => inst5_amux_c_a0_a,
	datad => inst10_areg_data_out_x_a4_a_a75,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aMux_13_rtl_236_a0);

inst5_aMux_13_rtl_236_a1_I : cyclone_lcell 
-- Equation(s):
-- inst5_aMux_13_rtl_236_a1 = inst5_aMux_13_rtl_236_a0 & (inst2_atmr_high_a4_a # !inst5_amux_c_a0_a) # !inst5_aMux_13_rtl_236_a0 & inst3_aint_pending_c_a4_a & inst5_amux_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CFA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst3_aint_pending_c_a4_a,
	datab => inst2_atmr_high_a4_a,
	datac => inst5_amux_c_a0_a,
	datad => inst5_aMux_13_rtl_236_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aMux_13_rtl_236_a1);

inst_aI3_adata_x_a4_a_a307_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a4_a_a307 = inst_aI3_adata_x_a4_a_a1778 # inst_aI3_adata_x_a4_a_a311 # inst_aI3_adata_x_a7_a_a1618 & inst5_aMux_13_rtl_236_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FEFA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a4_a_a1778,
	datab => inst_aI3_adata_x_a7_a_a1618,
	datac => inst_aI3_adata_x_a4_a_a311,
	datad => inst5_aMux_13_rtl_236_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a4_a_a307);

rtl_a1788_I : cyclone_lcell 
-- Equation(s):
-- rtl_a1788 = inst_aI2_aTD_c_a0_a & rtl_a14838 & (inst_aI3_adata_x_a4_a_a307 $ inst_aI3_aacc_c_a0_a_a4_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0880",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => rtl_a14838,
	datac => inst_aI3_adata_x_a4_a_a307,
	datad => inst_aI3_aacc_c_a0_a_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1788);

rtl_a2286_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2286 = inst_aI3_aacc_c_a0_a_a4_a & !inst_aI2_aTD_c_a2_a & !inst_aI2_aTD_c_a1_a & inst_aI3_aMux_201_rtl_95_a0

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0200",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a4_a,
	datab => inst_aI2_aTD_c_a2_a,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI3_aMux_201_rtl_95_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2286);

rtl_a3297_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3297 = inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a5_a & !inst_aI2_aTD_c_a1_a # !inst_aI2_aTD_c_a2_a & (inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a5_a # !inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a4_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0CCA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a4_a,
	datab => inst_aI3_aacc_c_a0_a_a5_a,
	datac => inst_aI2_aTD_c_a2_a,
	datad => inst_aI2_aTD_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3297);

rtl_a3408_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3408 = inst_aI2_aTD_c_a2_a & (inst_aI3_aacc_c_a0_a_a4_a $ inst_aI2_aTD_c_a1_a) # !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a3_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "6F60",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a4_a,
	datab => inst_aI2_aTD_c_a1_a,
	datac => inst_aI2_aTD_c_a2_a,
	datad => inst_aI3_aacc_c_a0_a_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3408);

rtl_a2424_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2424 = !inst_aI3_aMux_201_rtl_95_a0 & (inst_aI2_aTD_c_a0_a & rtl_a3408 # !inst_aI2_aTD_c_a0_a & rtl_a3297)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0E02",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a3297,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_aMux_201_rtl_95_a0,
	datad => rtl_a3408,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2424);

inst_aI3_aMux_174_rtl_61_rtl_528_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aMux_174_rtl_61_rtl_528_a0 = inst_aI2_aTD_c_a1_a & (inst_aI2_aTD_c_a0_a # inst_aI3_aadd_153_a5) # !inst_aI2_aTD_c_a1_a & !inst_aI2_aTD_c_a0_a & inst_aI3_aadd_129_a4

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DC98",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI2_aTD_c_a1_a,
	datac => inst_aI3_aadd_129_a4,
	datad => inst_aI3_aadd_153_a5,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_174_rtl_61_rtl_528_a0);

inst_aI3_aMux_174_rtl_61_rtl_528_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aMux_174_rtl_61_rtl_528_a1 = inst_aI3_aacc_c_a0_a_a4_a & (inst_aI3_aMux_174_rtl_61_rtl_528_a0 # inst_aI2_aTD_c_a0_a & inst_aI3_adata_x_a4_a_a307) # !inst_aI3_aacc_c_a0_a_a4_a & inst_aI3_aMux_174_rtl_61_rtl_528_a0 & (inst_aI3_adata_x_a4_a_a307 # !inst_aI2_aTD_c_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FD80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI3_aacc_c_a0_a_a4_a,
	datac => inst_aI3_adata_x_a4_a_a307,
	datad => inst_aI3_aMux_174_rtl_61_rtl_528_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_174_rtl_61_rtl_528_a1);

rtl_a15277_I : cyclone_lcell 
-- Equation(s):
-- rtl_a15277 = rtl_a2286 # rtl_a2424 # rtl_a14854 & inst_aI3_aMux_174_rtl_61_rtl_528_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FEEE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a2286,
	datab => rtl_a2424,
	datac => rtl_a14854,
	datad => inst_aI3_aMux_174_rtl_61_rtl_528_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a15277);

rtl_a2423_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2423 = rtl_a1788 # rtl_a15277 # rtl_a14847 & inst_aI3_adata_x_a4_a_a307

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a14847,
	datab => inst_aI3_adata_x_a4_a_a307,
	datac => rtl_a1788,
	datad => rtl_a15277,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2423);

inst_aI3_aacc_c_a0_a_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a4_a_a98 = inst_aI3_aacc_a0_a_a4_a_a4268 # inst_aI3_aacc_a0_a_a7_a_a4225 & !inst_aI2_aTC_c_a2_a & rtl_a2423
-- inst_aI3_aacc_c_a0_a_a4_a = DFFEA(inst_aI3_aacc_a0_a_a4_a_a98, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F2F0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_a0_a_a7_a_a4225,
	datab => inst_aI2_aTC_c_a2_a,
	datac => inst_aI3_aacc_a0_a_a4_a_a4268,
	datad => rtl_a2423,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a4_a_a98,
	regout => inst_aI3_aacc_c_a0_a_a4_a);

inst_aI3_aacc_i_a0_a_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a4_a_a4268 = inst_aI3_aacc_a0_a_a8_a_a63 & (inst_aI3_aacc_c_a0_a_a4_a # N1_acc_i[0][4] & inst_aI3_aacc_a0_a_a7_a_a4227) # !inst_aI3_aacc_a0_a_a8_a_a63 & N1_acc_i[0][4] & inst_aI3_aacc_a0_a_a7_a_a4227

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "F888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_a0_a_a8_a_a63,
	datab => inst_aI3_aacc_c_a0_a_a4_a,
	datac => inst_aI3_aacc_a0_a_a4_a_a98,
	datad => inst_aI3_aacc_a0_a_a7_a_a4227,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst_aI2_aint_start_c,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a4_a_a4268);

inst_aI4_aadd_104_a2_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_a2 = inst_aI4_aiinc_c_a2_a $ inst_aI4_aireg_c_a2_a $ !inst_aI4_aadd_104_a1COUT0
-- inst_aI4_aadd_104_a2COUT0 = CARRY(inst_aI4_aiinc_c_a2_a & (inst_aI4_aireg_c_a2_a # !inst_aI4_aadd_104_a1COUT0) # !inst_aI4_aiinc_c_a2_a & inst_aI4_aireg_c_a2_a & !inst_aI4_aadd_104_a1COUT0)
-- inst_aI4_aadd_104_a2COUT1 = CARRY(inst_aI4_aiinc_c_a2_a & (inst_aI4_aireg_c_a2_a # !inst_aI4_aadd_104_a1COUT1) # !inst_aI4_aiinc_c_a2_a & inst_aI4_aireg_c_a2_a & !inst_aI4_aadd_104_a1COUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "698E",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aiinc_c_a2_a,
	datab => inst_aI4_aireg_c_a2_a,
	cin0 => inst_aI4_aadd_104_a1COUT0,
	cin1 => inst_aI4_aadd_104_a1COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_a2,
	cout0 => inst_aI4_aadd_104_a2COUT0,
	cout1 => inst_aI4_aadd_104_a2COUT1);

inst_aI4_aadd_104_a3_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_a3 = inst_aI4_aiinc_c_a3_a $ inst_aI4_aireg_c_a3_a $ inst_aI4_aadd_104_a2COUT0
-- inst_aI4_aadd_104_a3COUT0 = CARRY(inst_aI4_aiinc_c_a3_a & !inst_aI4_aireg_c_a3_a & !inst_aI4_aadd_104_a2COUT0 # !inst_aI4_aiinc_c_a3_a & (!inst_aI4_aadd_104_a2COUT0 # !inst_aI4_aireg_c_a3_a))
-- inst_aI4_aadd_104_a3COUT1 = CARRY(inst_aI4_aiinc_c_a3_a & !inst_aI4_aireg_c_a3_a & !inst_aI4_aadd_104_a2COUT1 # !inst_aI4_aiinc_c_a3_a & (!inst_aI4_aadd_104_a2COUT1 # !inst_aI4_aireg_c_a3_a))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "9617",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aiinc_c_a3_a,
	datab => inst_aI4_aireg_c_a3_a,
	cin0 => inst_aI4_aadd_104_a2COUT0,
	cin1 => inst_aI4_aadd_104_a2COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_a3,
	cout0 => inst_aI4_aadd_104_a3COUT0,
	cout1 => inst_aI4_aadd_104_a3COUT1);

inst_aI4_aadd_104_a4_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_a4 = inst_aI4_aireg_c_a4_a $ inst_aI4_aiinc_c_a4_a $ !inst_aI4_aadd_104_a3COUT0
-- inst_aI4_aadd_104_a4COUT = 

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "698E",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aireg_c_a4_a,
	datab => inst_aI4_aiinc_c_a4_a,
	cin0 => inst_aI4_aadd_104_a3COUT0,
	cin1 => inst_aI4_aadd_104_a3COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_a4,
	cout => inst_aI4_aadd_104_a4COUT);

inst_aI4_aadd_104_rtl_648_a68_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_rtl_648_a68 = inst_aI4_ai_a20 & (inst_aI4_areduce_nor_103 & inst_aI4_aireg_c_a4_a # !inst_aI4_areduce_nor_103 & inst_aI4_aadd_104_a4) # !inst_aI4_ai_a20 & inst_aI4_aireg_c_a4_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCAC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aadd_104_a4,
	datab => inst_aI4_aireg_c_a4_a,
	datac => inst_aI4_ai_a20,
	datad => inst_aI4_areduce_nor_103,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_rtl_648_a68);

inst_aI4_aireg_i_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_rtl_648_a73 = inst_aI4_aireg_we_c & inst_aI3_aacc_c_a0_a_a4_a # !inst_aI4_aireg_we_c & inst_aI4_ai_a18 & inst_aI4_aadd_104_rtl_648_a68
-- inst_aI4_aireg_i_a4_a = DFFEA(inst_aI4_aadd_104_rtl_648_a73, GLOBAL(UCLK_acombout), VCC, , inst_aI4_aireg_i_a0_a_a6, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4A0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_aireg_we_c,
	datab => inst_aI4_ai_a18,
	datac => inst_aI3_aacc_c_a0_a_a4_a,
	datad => inst_aI4_aadd_104_rtl_648_a68,
	aclr => GND,
	ena => inst_aI4_aireg_i_a0_a_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_rtl_648_a73,
	regout => inst_aI4_aireg_i_a4_a);

inst_aI4_aireg_c_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aireg_c_a4_a = DFFEA(inst_aI2_aint_stop_x_a10 & (inst_aI2_aE_x_aint_e_a0 & inst_aI4_aadd_104_rtl_648_a73 # !inst_aI2_aE_x_aint_e_a0 & inst_aI4_aireg_i_a4_a) # !inst_aI2_aint_stop_x_a10 & inst_aI4_aadd_104_rtl_648_a73, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FD20",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aint_stop_x_a10,
	datab => inst_aI2_aE_x_aint_e_a0,
	datac => inst_aI4_aireg_i_a4_a,
	datad => inst_aI4_aadd_104_rtl_648_a73,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aireg_c_a4_a);

inst_aI4_aadd_104_a7_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_a7 = inst_aI4_aiinc_c_a7_a $ (!inst_aI4_aadd_104_a4COUT & inst_aI4_aadd_104_a6COUT0) # (inst_aI4_aadd_104_a4COUT & inst_aI4_aadd_104_a6COUT1) $ inst_aI4_aireg_c_a7_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "A55A",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aiinc_c_a7_a,
	datad => inst_aI4_aireg_c_a7_a,
	cin => inst_aI4_aadd_104_a4COUT,
	cin0 => inst_aI4_aadd_104_a6COUT0,
	cin1 => inst_aI4_aadd_104_a6COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_a7);

inst_aI4_aadd_104_rtl_648_a88_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_rtl_648_a88 = inst_aI4_areduce_nor_103 & inst_aI4_aireg_c_a7_a # !inst_aI4_areduce_nor_103 & (inst_aI4_ai_a20 & inst_aI4_aadd_104_a7 # !inst_aI4_ai_a20 & inst_aI4_aireg_c_a7_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "D8CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_areduce_nor_103,
	datab => inst_aI4_aireg_c_a7_a,
	datac => inst_aI4_aadd_104_a7,
	datad => inst_aI4_ai_a20,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_rtl_648_a88);

inst_aI4_aireg_i_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_rtl_648_a93 = inst_aI4_aireg_we_c & inst_aI3_aacc_c_a0_a_a7_a # !inst_aI4_aireg_we_c & inst_aI4_ai_a18 & inst_aI4_aadd_104_rtl_648_a88
-- inst_aI4_aireg_i_a7_a = DFFEA(inst_aI4_aadd_104_rtl_648_a93, GLOBAL(UCLK_acombout), VCC, , inst_aI4_aireg_i_a0_a_a6, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ACA0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_c_a0_a_a7_a,
	datab => inst_aI4_ai_a18,
	datac => inst_aI4_aireg_we_c,
	datad => inst_aI4_aadd_104_rtl_648_a88,
	aclr => GND,
	ena => inst_aI4_aireg_i_a0_a_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_rtl_648_a93,
	regout => inst_aI4_aireg_i_a7_a);

inst_aI4_aireg_c_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aireg_c_a7_a = DFFEA(inst_aI2_aint_stop_x_a10 & (inst_aI2_aE_x_aint_e_a0 & inst_aI4_aadd_104_rtl_648_a93 # !inst_aI2_aE_x_aint_e_a0 & inst_aI4_aireg_i_a7_a) # !inst_aI2_aint_stop_x_a10 & inst_aI4_aadd_104_rtl_648_a93, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FD20",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aint_stop_x_a10,
	datab => inst_aI2_aE_x_aint_e_a0,
	datac => inst_aI4_aireg_i_a7_a,
	datad => inst_aI4_aadd_104_rtl_648_a93,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aireg_c_a7_a);

inst_aI3_adata_x_a7_a_a92_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a7_a_a92 = inst_aI4_aireg_c_a7_a & (inst_aI4_aiinc_c_a7_a # !inst_aI4_areduce_nor_106) # !inst_aI4_aireg_c_a7_a & inst_aI4_aiinc_c_a7_a & inst_aI4_areduce_nor_106

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI4_aireg_c_a7_a,
	datac => inst_aI4_aiinc_c_a7_a,
	datad => inst_aI4_areduce_nor_106,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a7_a_a92);

inst_aI3_adata_x_a7_a_a1679_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a7_a_a1679 = inst_aI3_adata_x_a7_a_a99 # inst_aI3_adata_x_a7_a_a1620 & inst_aI4_ai_a528 & inst_aI3_adata_x_a7_a_a92

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EAAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a7_a_a99,
	datab => inst_aI3_adata_x_a7_a_a1620,
	datac => inst_aI4_ai_a528,
	datad => inst_aI3_adata_x_a7_a_a92,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a7_a_a1679);

inst8_aDecoder_28_a23_I : cyclone_lcell 
-- Equation(s):
-- inst8_aDecoder_28_a23 = !inst8_arx_bit_count_a3_a & inst8_arx_bit_count_a1_a & inst8_arx_bit_count_a2_a & inst8_arx_bit_count_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_bit_count_a3_a,
	datab => inst8_arx_bit_count_a1_a,
	datac => inst8_arx_bit_count_a2_a,
	datad => inst8_arx_bit_count_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_aDecoder_28_a23);

inst8_arx_uart_reg_a7_a_a1_I : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a7_a_a1 = inst8_areduce_nor_7 & !inst8_areduce_nor_27 & rtl_a14851 & inst8_aDecoder_28_a23

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_areduce_nor_7,
	datab => inst8_areduce_nor_27,
	datac => rtl_a14851,
	datad => inst8_aDecoder_28_a23,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_arx_uart_reg_a7_a_a1);

inst8_arx_uart_reg_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a7_a = DFFEA(!RXD_acombout, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_arx_uart_reg_a7_a_a1, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => RXD_acombout,
	aclr => NOT_nRESET_acombout,
	ena => inst8_arx_uart_reg_a7_a_a1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_reg_a7_a);

inst8_arx_uart_fifo_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_fifo_a7_a = DFFEA(!inst8_arx_uart_reg_a7_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_arx_uart_fifo_a7_a_a37, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst8_arx_uart_reg_a7_a,
	aclr => NOT_nRESET_acombout,
	ena => inst8_arx_uart_fifo_a7_a_a37,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_fifo_a7_a);

inst_aI3_adata_x_a7_a_a87_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a7_a_a87 = inst5_amux_c_a0_a & inst7_aaltsyncram_component_aq_a_a7_a # !inst5_amux_c_a0_a & (inst5_amux_c_a1_a & inst7_aaltsyncram_component_aq_a_a7_a # !inst5_amux_c_a1_a & inst8_arx_uart_fifo_a7_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FE02",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_uart_fifo_a7_a,
	datab => inst5_amux_c_a0_a,
	datac => inst5_amux_c_a1_a,
	datad => inst7_aaltsyncram_component_aq_a_a7_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a7_a_a87);

inst_aI3_adata_x_a7_a_a101_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a7_a_a101 = inst5_amux_c_a2_a & inst_aI3_adata_x_a7_a_a1620 & inst_aI3_adata_x_a7_a_a87 & !inst_aI4_ai_a528

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_amux_c_a2_a,
	datab => inst_aI3_adata_x_a7_a_a1620,
	datac => inst_aI3_adata_x_a7_a_a87,
	datad => inst_aI4_ai_a528,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a7_a_a101);

inst3_aint_mask_c_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_mask_c_a7_a = DFFEA(inst_aI4_adata_ox_a7_a_a0, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst3_ai_a1, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a7_a_a0,
	aclr => NOT_nRESET_acombout,
	ena => inst3_ai_a1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_mask_c_a7_a);

inst2_atmr_int_x_aI : cyclone_lcell 
-- Equation(s):
-- inst2_atmr_int_x = DFFEA(inst2_atmr_reset & (inst2_atmr_enable & !inst2_ai_a345 # !inst2_atmr_enable & inst2_atmr_int_x), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2A08",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst2_atmr_reset,
	datab => inst2_atmr_enable,
	datac => inst2_ai_a345,
	datad => inst2_atmr_int_x,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst2_atmr_int_x);

inst3_aint_masked_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_masked_a7_a = DFFEA(inst3_aint_mask_c_a7_a & inst2_atmr_int_x, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst3_aint_mask_c_a7_a,
	datad => inst2_atmr_int_x,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_masked_a7_a);

inst3_aint_masked_c_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_masked_c_a7_a = DFFEA(inst3_aint_masked_a7_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst3_aint_masked_a7_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_masked_c_a7_a);

inst3_aint_clr_c_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_clr_c_a7_a = DFFEA(inst_aI4_adata_ox_a7_a_a0, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst3_ai_a121, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a7_a_a0,
	aclr => NOT_nRESET_acombout,
	ena => inst3_ai_a121,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_clr_c_a7_a);

inst3_aint_pending_c_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_pending_c_a7_a = DFFEA(!inst3_aint_clr_c_a7_a & (inst3_aint_pending_c_a7_a # !inst3_aint_masked_c_a7_a & inst3_aint_masked_a7_a), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3310",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst3_aint_masked_c_a7_a,
	datab => inst3_aint_clr_c_a7_a,
	datac => inst3_aint_masked_a7_a,
	datad => inst3_aint_pending_c_a7_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_pending_c_a7_a);

inst5_aMux_10_rtl_227_a0_I : cyclone_lcell 
-- Equation(s):
-- inst5_aMux_10_rtl_227_a0 = inst5_amux_c_a0_a & (inst3_aint_pending_c_a7_a # inst5_amux_c_a1_a) # !inst5_amux_c_a0_a & !inst5_amux_c_a1_a & inst7_aaltsyncram_component_aq_a_a7_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EE30",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst3_aint_pending_c_a7_a,
	datab => inst5_amux_c_a1_a,
	datac => inst7_aaltsyncram_component_aq_a_a7_a,
	datad => inst5_amux_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aMux_10_rtl_227_a0);

PORTA_IN_a7_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTA_IN(7),
	combout => PORTA_IN_a7_a_acombout);

PORTB_IN_a7_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTB_IN(7),
	combout => PORTB_IN_a7_a_acombout);

inst10_areg_data_out_x_a7_a_a41_I : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a7_a_a41 = PORTB_IN_a7_a_acombout & inst10_ai_a108 & inst_aI5_ai_a12 & inst10_ai_a113

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => PORTB_IN_a7_a_acombout,
	datab => inst10_ai_a108,
	datac => inst_aI5_ai_a12,
	datad => inst10_ai_a113,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a7_a_a41);

inst10_areg_data_out_c_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a7_a_a42 = K1_reg_data_out_c[7] & (!inst10_ai_a113 # !inst_aI5_ai_a12 # !inst10_ai_a108)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "70F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst10_ai_a108,
	datab => inst_aI5_ai_a12,
	datac => inst10_areg_data_out_x_a7_a_a45,
	datad => inst10_ai_a113,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a7_a_a42);

inst10_areg_data_out_x_a7_a_a45_I : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a7_a_a45 = inst10_ai_a3 & (inst10_areg_data_out_x_a7_a_a41 # inst10_areg_data_out_x_a7_a_a42) # !inst10_ai_a3 & PORTA_IN_a7_a_acombout

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EEE2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => PORTA_IN_a7_a_acombout,
	datab => inst10_ai_a3,
	datac => inst10_areg_data_out_x_a7_a_a41,
	datad => inst10_areg_data_out_x_a7_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a7_a_a45);

inst5_aMux_10_rtl_227_a1_I : cyclone_lcell 
-- Equation(s):
-- inst5_aMux_10_rtl_227_a1 = inst5_aMux_10_rtl_227_a0 & (inst2_atmr_high_a7_a # !inst5_amux_c_a1_a) # !inst5_aMux_10_rtl_227_a0 & inst5_amux_c_a1_a & inst10_areg_data_out_x_a7_a_a45

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BCB0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_high_a7_a,
	datab => inst5_amux_c_a1_a,
	datac => inst5_aMux_10_rtl_227_a0,
	datad => inst10_areg_data_out_x_a7_a_a45,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aMux_10_rtl_227_a1);

inst_aI3_adata_x_a7_a_a97_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a7_a_a97 = inst_aI3_adata_x_a7_a_a1679 # inst_aI3_adata_x_a7_a_a101 # inst_aI3_adata_x_a7_a_a1618 & inst5_aMux_10_rtl_227_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FEFC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a7_a_a1618,
	datab => inst_aI3_adata_x_a7_a_a1679,
	datac => inst_aI3_adata_x_a7_a_a101,
	datad => inst5_aMux_10_rtl_227_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a7_a_a97);

rtl_a1516_I : cyclone_lcell 
-- Equation(s):
-- rtl_a1516 = rtl_a14838 & inst_aI2_aTD_c_a0_a & (inst_aI3_aacc_c_a0_a_a7_a $ inst_aI3_adata_x_a7_a_a97)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0880",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a14838,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_aacc_c_a0_a_a7_a,
	datad => inst_aI3_adata_x_a7_a_a97,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1516);

rtl_a3360_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3360 = inst_aI2_aTD_c_a2_a & (inst_aI2_aTD_c_a1_a $ inst_aI3_aacc_c_a0_a_a7_a) # !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a6_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5ACC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a1_a,
	datab => inst_aI3_aacc_c_a0_a_a6_a,
	datac => inst_aI3_aacc_c_a0_a_a7_a,
	datad => inst_aI2_aTD_c_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3360);

inst_aI3_aacc_a0_a_a8_a_a69_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a8_a_a69 = inst_aI3_aacc_c_a0_a_a8_a & (inst_aI3_ai_a220 & !rtl_a2352 # !inst_aI3_ai_a220 & inst_aI3_ai_a212)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "22A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a8_a,
	datab => rtl_a2352,
	datac => inst_aI3_ai_a212,
	datad => inst_aI3_ai_a220,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a8_a_a69);

rtl_a3872_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3872 = inst_aI2_aTD_c_a0_a & inst_aI3_aacc_c_a0_a_a7_a # !inst_aI2_aTD_c_a0_a & inst_aI3_aacc_c_a0_a_a0_a & inst_aI2_aTD_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CAC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a0_a,
	datab => inst_aI3_aacc_c_a0_a_a7_a,
	datac => inst_aI2_aTD_c_a0_a,
	datad => inst_aI2_aTD_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3872);

rtl_a3880_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3880 = !inst_aI2_aTD_c_a2_a & rtl_a3872 & (inst_aI2_aTC_c_a1_a $ !inst_aI2_aTC_c_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4010",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI2_aTC_c_a1_a,
	datac => rtl_a3872,
	datad => inst_aI2_aTC_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3880);

rtl_a14862_I : cyclone_lcell 
-- Equation(s):
-- rtl_a14862 = inst_aI2_aTD_c_a0_a & (inst_aI2_aTC_c_a0_a $ !inst_aI2_aTC_c_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A500",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_c_a0_a,
	datac => inst_aI2_aTC_c_a1_a,
	datad => inst_aI2_aTD_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a14862);

rtl_a3878_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3878 = inst_aI3_aacc_c_a0_a_a8_a & !inst_aI2_aTD_c_a1_a & (inst_aI2_aTD_c_a2_a $ !rtl_a14862)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2002",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a8_a,
	datab => inst_aI2_aTD_c_a1_a,
	datac => inst_aI2_aTD_c_a2_a,
	datad => rtl_a14862,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3878);

rtl_a15139_I : cyclone_lcell 
-- Equation(s):
-- rtl_a15139 = inst_aI2_aTD_c_a2_a & !inst_aI2_aTD_c_a0_a & (inst_aI2_aTC_c_a0_a $ inst_aI2_aTC_c_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0028",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI2_aTC_c_a0_a,
	datac => inst_aI2_aTC_c_a1_a,
	datad => inst_aI2_aTD_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a15139);

inst8_aDecoder_28_a22_I : cyclone_lcell 
-- Equation(s):
-- inst8_aDecoder_28_a22 = !inst8_arx_bit_count_a3_a & !inst8_arx_bit_count_a0_a & inst8_arx_bit_count_a2_a & inst8_arx_bit_count_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "1000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_bit_count_a3_a,
	datab => inst8_arx_bit_count_a0_a,
	datac => inst8_arx_bit_count_a2_a,
	datad => inst8_arx_bit_count_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_aDecoder_28_a22);

inst8_arx_uart_reg_a6_a_a2_I : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a6_a_a2 = inst8_areduce_nor_7 & rtl_a14851 & !inst8_areduce_nor_27 & inst8_aDecoder_28_a22

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_areduce_nor_7,
	datab => rtl_a14851,
	datac => inst8_areduce_nor_27,
	datad => inst8_aDecoder_28_a22,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_arx_uart_reg_a6_a_a2);

inst8_arx_uart_reg_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a6_a = DFFEA(!RXD_acombout, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_arx_uart_reg_a6_a_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => RXD_acombout,
	aclr => NOT_nRESET_acombout,
	ena => inst8_arx_uart_reg_a6_a_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_reg_a6_a);

inst8_arx_uart_fifo_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_fifo_a6_a = DFFEA(!inst8_arx_uart_reg_a6_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_arx_uart_fifo_a7_a_a37, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst8_arx_uart_reg_a6_a,
	aclr => NOT_nRESET_acombout,
	ena => inst8_arx_uart_fifo_a7_a_a37,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_fifo_a6_a);

inst_aI3_adata_x_a6_a_a157_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a6_a_a157 = inst5_amux_c_a0_a & inst7_aaltsyncram_component_aq_a_a6_a # !inst5_amux_c_a0_a & (inst5_amux_c_a1_a & inst7_aaltsyncram_component_aq_a_a6_a # !inst5_amux_c_a1_a & inst8_arx_uart_fifo_a6_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FE02",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_uart_fifo_a6_a,
	datab => inst5_amux_c_a0_a,
	datac => inst5_amux_c_a1_a,
	datad => inst7_aaltsyncram_component_aq_a_a6_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a6_a_a157);

inst_aI3_adata_x_a6_a_a171_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a6_a_a171 = inst5_amux_c_a2_a & inst_aI3_adata_x_a7_a_a1620 & inst_aI3_adata_x_a6_a_a157 & !inst_aI4_ai_a528

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_amux_c_a2_a,
	datab => inst_aI3_adata_x_a7_a_a1620,
	datac => inst_aI3_adata_x_a6_a_a157,
	datad => inst_aI4_ai_a528,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a6_a_a171);

inst_aI2_adata_is_c_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a6_a_a169 = !inst_aI2_aTC_c_a2_a & inst_aI2_aTC_c_a1_a & M1_data_is_c[6] & !inst_aI2_aTC_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "0040",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aTC_c_a2_a,
	datab => inst_aI2_aTC_c_a1_a,
	datac => inst6_aaltsyncram_component_aq_a_a10_a,
	datad => inst_aI2_aTC_c_a0_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a6_a_a169);

inst_aI3_adata_x_a6_a_a162_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a6_a_a162 = inst_aI4_aiinc_c_a6_a & (inst_aI4_aireg_c_a6_a # inst_aI4_areduce_nor_106) # !inst_aI4_aiinc_c_a6_a & inst_aI4_aireg_c_a6_a & !inst_aI4_areduce_nor_106

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI4_aiinc_c_a6_a,
	datac => inst_aI4_aireg_c_a6_a,
	datad => inst_aI4_areduce_nor_106,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a6_a_a162);

inst_aI3_adata_x_a6_a_a1712_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a6_a_a1712 = inst_aI3_adata_x_a6_a_a169 # inst_aI3_adata_x_a7_a_a1620 & inst_aI4_ai_a528 & inst_aI3_adata_x_a6_a_a162

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ECCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a7_a_a1620,
	datab => inst_aI3_adata_x_a6_a_a169,
	datac => inst_aI4_ai_a528,
	datad => inst_aI3_adata_x_a6_a_a162,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a6_a_a1712);

PORTA_IN_a6_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTA_IN(6),
	combout => PORTA_IN_a6_a_acombout);

inst10_areg_data_out_c_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a6_a_a52 = K1_reg_data_out_c[6] & (!inst10_ai_a113 # !inst_aI5_ai_a12 # !inst10_ai_a108)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "70F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst10_ai_a108,
	datab => inst_aI5_ai_a12,
	datac => inst10_areg_data_out_x_a6_a_a55,
	datad => inst10_ai_a113,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a6_a_a52);

PORTB_IN_a6_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTB_IN(6),
	combout => PORTB_IN_a6_a_acombout);

inst10_areg_data_out_x_a6_a_a51_I : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a6_a_a51 = PORTB_IN_a6_a_acombout & inst_aI5_ai_a12 & inst10_ai_a108 & inst10_ai_a113

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => PORTB_IN_a6_a_acombout,
	datab => inst_aI5_ai_a12,
	datac => inst10_ai_a108,
	datad => inst10_ai_a113,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a6_a_a51);

inst10_areg_data_out_x_a6_a_a55_I : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a6_a_a55 = inst10_ai_a3 & (inst10_areg_data_out_x_a6_a_a52 # inst10_areg_data_out_x_a6_a_a51) # !inst10_ai_a3 & PORTA_IN_a6_a_acombout

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EEE2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => PORTA_IN_a6_a_acombout,
	datab => inst10_ai_a3,
	datac => inst10_areg_data_out_x_a6_a_a52,
	datad => inst10_areg_data_out_x_a6_a_a51,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a6_a_a55);

inst5_aMux_11_rtl_230_a0_I : cyclone_lcell 
-- Equation(s):
-- inst5_aMux_11_rtl_230_a0 = inst5_amux_c_a1_a & (inst5_amux_c_a0_a # inst10_areg_data_out_x_a6_a_a55) # !inst5_amux_c_a1_a & !inst5_amux_c_a0_a & inst7_aaltsyncram_component_aq_a_a6_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DC98",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_amux_c_a0_a,
	datab => inst5_amux_c_a1_a,
	datac => inst7_aaltsyncram_component_aq_a_a6_a,
	datad => inst10_areg_data_out_x_a6_a_a55,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aMux_11_rtl_230_a0);

inst5_aMux_11_rtl_230_a1_I : cyclone_lcell 
-- Equation(s):
-- inst5_aMux_11_rtl_230_a1 = inst5_aMux_11_rtl_230_a0 & (inst2_atmr_high_a6_a # !inst5_amux_c_a0_a) # !inst5_aMux_11_rtl_230_a0 & inst5_amux_c_a0_a & inst3_aint_pending_c_a6_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BBC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_high_a6_a,
	datab => inst5_amux_c_a0_a,
	datac => inst3_aint_pending_c_a6_a,
	datad => inst5_aMux_11_rtl_230_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aMux_11_rtl_230_a1);

inst_aI3_adata_x_a6_a_a167_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a6_a_a167 = inst_aI3_adata_x_a6_a_a171 # inst_aI3_adata_x_a6_a_a1712 # inst_aI3_adata_x_a7_a_a1618 & inst5_aMux_11_rtl_230_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FEFA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a6_a_a171,
	datab => inst_aI3_adata_x_a7_a_a1618,
	datac => inst_aI3_adata_x_a6_a_a1712,
	datad => inst5_aMux_11_rtl_230_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a6_a_a167);

inst_aI3_aadd_129_a6_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_129_a6 = inst_aI3_aacc_c_a0_a_a6_a $ inst_aI3_adata_x_a6_a_a167 $ !(!inst_aI3_aadd_129_a4COUT & inst_aI3_aadd_129_a5COUT0) # (inst_aI3_aadd_129_a4COUT & inst_aI3_aadd_129_a5COUT1)
-- inst_aI3_aadd_129_a6COUT0 = CARRY(inst_aI3_aacc_c_a0_a_a6_a & (inst_aI3_adata_x_a6_a_a167 # !inst_aI3_aadd_129_a5COUT0) # !inst_aI3_aacc_c_a0_a_a6_a & inst_aI3_adata_x_a6_a_a167 & !inst_aI3_aadd_129_a5COUT0)
-- inst_aI3_aadd_129_a6COUT1 = CARRY(inst_aI3_aacc_c_a0_a_a6_a & (inst_aI3_adata_x_a6_a_a167 # !inst_aI3_aadd_129_a5COUT1) # !inst_aI3_aacc_c_a0_a_a6_a & inst_aI3_adata_x_a6_a_a167 & !inst_aI3_aadd_129_a5COUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "698E",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a6_a,
	datab => inst_aI3_adata_x_a6_a_a167,
	cin => inst_aI3_aadd_129_a4COUT,
	cin0 => inst_aI3_aadd_129_a5COUT0,
	cin1 => inst_aI3_aadd_129_a5COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_129_a6,
	cout0 => inst_aI3_aadd_129_a6COUT0,
	cout1 => inst_aI3_aadd_129_a6COUT1);

inst_aI3_aadd_129_a7_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_129_a7 = inst_aI3_aacc_c_a0_a_a7_a $ inst_aI3_adata_x_a7_a_a97 $ (!inst_aI3_aadd_129_a4COUT & inst_aI3_aadd_129_a6COUT0) # (inst_aI3_aadd_129_a4COUT & inst_aI3_aadd_129_a6COUT1)
-- inst_aI3_aadd_129_a7COUT0 = CARRY(inst_aI3_aacc_c_a0_a_a7_a & !inst_aI3_adata_x_a7_a_a97 & !inst_aI3_aadd_129_a6COUT0 # !inst_aI3_aacc_c_a0_a_a7_a & (!inst_aI3_aadd_129_a6COUT0 # !inst_aI3_adata_x_a7_a_a97))
-- inst_aI3_aadd_129_a7COUT1 = CARRY(inst_aI3_aacc_c_a0_a_a7_a & !inst_aI3_adata_x_a7_a_a97 & !inst_aI3_aadd_129_a6COUT1 # !inst_aI3_aacc_c_a0_a_a7_a & (!inst_aI3_aadd_129_a6COUT1 # !inst_aI3_adata_x_a7_a_a97))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "9617",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a7_a,
	datab => inst_aI3_adata_x_a7_a_a97,
	cin => inst_aI3_aadd_129_a4COUT,
	cin0 => inst_aI3_aadd_129_a6COUT0,
	cin1 => inst_aI3_aadd_129_a6COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_129_a7,
	cout0 => inst_aI3_aadd_129_a7COUT0,
	cout1 => inst_aI3_aadd_129_a7COUT1);

inst_aI3_aadd_129_a8_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_129_a8 = !(!inst_aI3_aadd_129_a4COUT & inst_aI3_aadd_129_a7COUT0) # (inst_aI3_aadd_129_a4COUT & inst_aI3_aadd_129_a7COUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "0F0F",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	cin => inst_aI3_aadd_129_a4COUT,
	cin0 => inst_aI3_aadd_129_a7COUT0,
	cin1 => inst_aI3_aadd_129_a7COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_129_a8);

inst_aI3_aadd_153_a7_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_153_a7 = inst_aI3_aacc_c_a0_a_a6_a $ inst_aI3_adata_x_a6_a_a167 $ (!inst_aI3_aadd_153_a5COUT & inst_aI3_aadd_153_a6COUT0) # (inst_aI3_aadd_153_a5COUT & inst_aI3_aadd_153_a6COUT1)
-- inst_aI3_aadd_153_a7COUT0 = CARRY(inst_aI3_aacc_c_a0_a_a6_a & (!inst_aI3_aadd_153_a6COUT0 # !inst_aI3_adata_x_a6_a_a167) # !inst_aI3_aacc_c_a0_a_a6_a & !inst_aI3_adata_x_a6_a_a167 & !inst_aI3_aadd_153_a6COUT0)
-- inst_aI3_aadd_153_a7COUT1 = CARRY(inst_aI3_aacc_c_a0_a_a6_a & (!inst_aI3_aadd_153_a6COUT1 # !inst_aI3_adata_x_a6_a_a167) # !inst_aI3_aacc_c_a0_a_a6_a & !inst_aI3_adata_x_a6_a_a167 & !inst_aI3_aadd_153_a6COUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "962B",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a6_a,
	datab => inst_aI3_adata_x_a6_a_a167,
	cin => inst_aI3_aadd_153_a5COUT,
	cin0 => inst_aI3_aadd_153_a6COUT0,
	cin1 => inst_aI3_aadd_153_a6COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_153_a7,
	cout0 => inst_aI3_aadd_153_a7COUT0,
	cout1 => inst_aI3_aadd_153_a7COUT1);

inst_aI3_aadd_153_a8_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_153_a8 = inst_aI3_aacc_c_a0_a_a7_a $ inst_aI3_adata_x_a7_a_a97 $ !(!inst_aI3_aadd_153_a5COUT & inst_aI3_aadd_153_a7COUT0) # (inst_aI3_aadd_153_a5COUT & inst_aI3_aadd_153_a7COUT1)
-- inst_aI3_aadd_153_a8COUT0 = CARRY(inst_aI3_aacc_c_a0_a_a7_a & inst_aI3_adata_x_a7_a_a97 & !inst_aI3_aadd_153_a7COUT0 # !inst_aI3_aacc_c_a0_a_a7_a & (inst_aI3_adata_x_a7_a_a97 # !inst_aI3_aadd_153_a7COUT0))
-- inst_aI3_aadd_153_a8COUT1 = CARRY(inst_aI3_aacc_c_a0_a_a7_a & inst_aI3_adata_x_a7_a_a97 & !inst_aI3_aadd_153_a7COUT1 # !inst_aI3_aacc_c_a0_a_a7_a & (inst_aI3_adata_x_a7_a_a97 # !inst_aI3_aadd_153_a7COUT1))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "694D",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a7_a,
	datab => inst_aI3_adata_x_a7_a_a97,
	cin => inst_aI3_aadd_153_a5COUT,
	cin0 => inst_aI3_aadd_153_a7COUT0,
	cin1 => inst_aI3_aadd_153_a7COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_153_a8,
	cout0 => inst_aI3_aadd_153_a8COUT0,
	cout1 => inst_aI3_aadd_153_a8COUT1);

inst_aI3_aadd_153_a9_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aadd_153_a9 = !(!inst_aI3_aadd_153_a5COUT & inst_aI3_aadd_153_a8COUT0) # (inst_aI3_aadd_153_a5COUT & inst_aI3_aadd_153_a8COUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "0F0F",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	cin => inst_aI3_aadd_153_a5COUT,
	cin0 => inst_aI3_aadd_153_a8COUT0,
	cin1 => inst_aI3_aadd_153_a8COUT1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aadd_153_a9);

rtl_a3879_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3879 = rtl_a15139 & (inst_aI2_aTD_c_a1_a & !inst_aI3_aadd_153_a9 # !inst_aI2_aTD_c_a1_a & inst_aI3_aadd_129_a8)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "08A8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a15139,
	datab => inst_aI3_aadd_129_a8,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI3_aadd_153_a9,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3879);

rtl_a3476_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3476 = !inst_aI2_aTC_c_a2_a & (rtl_a3880 # rtl_a3878 # rtl_a3879)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F0E",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a3880,
	datab => rtl_a3878,
	datac => inst_aI2_aTC_c_a2_a,
	datad => rtl_a3879,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3476);

inst_aI3_aacc_c_a0_a_a8_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a8_a_a68 = inst_aI3_aacc_a0_a_a8_a_a69 # inst_aI3_aacc_a0_a_a7_a_a4225 & (rtl_a601 # rtl_a3476)
-- inst_aI3_aacc_c_a0_a_a8_a = DFFEA(inst_aI3_aacc_a0_a_a8_a_a68, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EEEC",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_a0_a_a7_a_a4225,
	datab => inst_aI3_aacc_a0_a_a8_a_a69,
	datac => rtl_a601,
	datad => rtl_a3476,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a8_a_a68,
	regout => inst_aI3_aacc_c_a0_a_a8_a);

inst_aI3_aacc_i_a0_a_a8_a_aI : cyclone_lcell 
-- Equation(s):
-- rtl_a601 = inst_aI2_aTC_c_a2_a & N1_acc_i[0][8]

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "A0A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aTC_c_a2_a,
	datac => inst_aI3_aacc_a0_a_a8_a_a68,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst_aI2_aint_start_c,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a601);

rtl_a3245_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3245 = inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a8_a & !inst_aI2_aTD_c_a2_a # !inst_aI2_aTD_c_a1_a & (inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a8_a # !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a7_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0AAC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a8_a,
	datab => inst_aI3_aacc_c_a0_a_a7_a,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI2_aTD_c_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3245);

rtl_a2364_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2364 = !inst_aI3_aMux_201_rtl_95_a0 & (inst_aI2_aTD_c_a0_a & rtl_a3360 # !inst_aI2_aTD_c_a0_a & rtl_a3245)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5140",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aMux_201_rtl_95_a0,
	datab => inst_aI2_aTD_c_a0_a,
	datac => rtl_a3360,
	datad => rtl_a3245,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2364);

rtl_a2268_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2268 = inst_aI3_aMux_201_rtl_95_a0 & !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a7_a & !inst_aI2_aTD_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0020",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aMux_201_rtl_95_a0,
	datab => inst_aI2_aTD_c_a2_a,
	datac => inst_aI3_aacc_c_a0_a_a7_a,
	datad => inst_aI2_aTD_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2268);

inst_aI3_aMux_171_rtl_43_rtl_510_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aMux_171_rtl_43_rtl_510_a0 = inst_aI2_aTD_c_a1_a & (inst_aI2_aTD_c_a0_a # inst_aI3_aadd_153_a8) # !inst_aI2_aTD_c_a1_a & !inst_aI2_aTD_c_a0_a & inst_aI3_aadd_129_a7

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DC98",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI2_aTD_c_a1_a,
	datac => inst_aI3_aadd_129_a7,
	datad => inst_aI3_aadd_153_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_171_rtl_43_rtl_510_a0);

inst_aI3_aMux_171_rtl_43_rtl_510_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aMux_171_rtl_43_rtl_510_a1 = inst_aI3_aacc_c_a0_a_a7_a & (inst_aI3_aMux_171_rtl_43_rtl_510_a0 # inst_aI2_aTD_c_a0_a & inst_aI3_adata_x_a7_a_a97) # !inst_aI3_aacc_c_a0_a_a7_a & inst_aI3_aMux_171_rtl_43_rtl_510_a0 & (inst_aI3_adata_x_a7_a_a97 # !inst_aI2_aTD_c_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FD80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI3_aacc_c_a0_a_a7_a,
	datac => inst_aI3_adata_x_a7_a_a97,
	datad => inst_aI3_aMux_171_rtl_43_rtl_510_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_171_rtl_43_rtl_510_a1);

rtl_a15072_I : cyclone_lcell 
-- Equation(s):
-- rtl_a15072 = rtl_a2364 # rtl_a2268 # rtl_a14854 & inst_aI3_aMux_171_rtl_43_rtl_510_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FEEE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a2364,
	datab => rtl_a2268,
	datac => rtl_a14854,
	datad => inst_aI3_aMux_171_rtl_43_rtl_510_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a15072);

rtl_a2363_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2363 = rtl_a1516 # rtl_a15072 # rtl_a14847 & inst_aI3_adata_x_a7_a_a97

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a14847,
	datab => inst_aI3_adata_x_a7_a_a97,
	datac => rtl_a1516,
	datad => rtl_a15072,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2363);

inst_aI3_aacc_c_a0_a_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a7_a_a58 = inst_aI3_aacc_a0_a_a7_a_a4253 # inst_aI3_aacc_a0_a_a7_a_a4225 & !inst_aI2_aTC_c_a2_a & rtl_a2363
-- inst_aI3_aacc_c_a0_a_a7_a = DFFEA(inst_aI3_aacc_a0_a_a7_a_a58, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F2F0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_a0_a_a7_a_a4225,
	datab => inst_aI2_aTC_c_a2_a,
	datac => inst_aI3_aacc_a0_a_a7_a_a4253,
	datad => rtl_a2363,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a7_a_a58,
	regout => inst_aI3_aacc_c_a0_a_a7_a);

inst_aI3_aacc_i_a0_a_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a7_a_a4253 = inst_aI3_aacc_a0_a_a7_a_a4227 & (N1_acc_i[0][7] # inst_aI3_aacc_a0_a_a8_a_a63 & inst_aI3_aacc_c_a0_a_a7_a) # !inst_aI3_aacc_a0_a_a7_a_a4227 & inst_aI3_aacc_a0_a_a8_a_a63 & inst_aI3_aacc_c_a0_a_a7_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "ECA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_a0_a_a7_a_a4227,
	datab => inst_aI3_aacc_a0_a_a8_a_a63,
	datac => inst_aI3_aacc_a0_a_a7_a_a58,
	datad => inst_aI3_aacc_c_a0_a_a7_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst_aI2_aint_start_c,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a7_a_a4253);

inst10_aout_0reg_a7_a_areg0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adata_ox_a7_a_a0 = inst_aI3_aacc_c_a0_a_a7_a & inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a & nRESET_acombout
-- inst10_aout_0reg_a7_a_areg0 = DFFEA(inst_aI4_adata_ox_a7_a_a0, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst10_ai_a1, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A000",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_c_a0_a_a7_a,
	datac => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a,
	datad => nRESET_acombout,
	aclr => NOT_nRESET_acombout,
	ena => inst10_ai_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adata_ox_a7_a_a0,
	regout => inst10_aout_0reg_a7_a_areg0);

inst1_ai_a138_I : cyclone_lcell 
-- Equation(s):
-- inst1_ai_a138 = nRESET_acombout & inst_aI5_andwe_c & inst_aI5_ai_a12 & inst1_ai_a500

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => nRESET_acombout,
	datab => inst_aI5_andwe_c,
	datac => inst_aI5_ai_a12,
	datad => inst1_ai_a500,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_ai_a138);

inst1_atx_clk_div_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_clk_div_a7_a = DFFEA(inst_aI4_adata_ox_a7_a_a0, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_ai_a138, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a7_a_a0,
	aclr => NOT_nRESET_acombout,
	ena => inst1_ai_a138,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_clk_div_a7_a);

inst1_atx_clk_div_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_clk_div_a4_a = DFFEA(inst_aI4_adata_ox_a4_a_a3, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_ai_a138, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a4_a_a3,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst1_ai_a138,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_clk_div_a4_a);

inst1_atx_clk_div_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_clk_div_a3_a = DFFEA(inst_aI4_adata_ox_a3_a_a4, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_ai_a138, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a3_a_a4,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst1_ai_a138,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_clk_div_a3_a);

inst1_atx_clk_div_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_clk_div_a2_a = DFFEA(inst_aI4_adata_ox_a2_a_a5, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_ai_a138, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a2_a_a5,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst1_ai_a138,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_clk_div_a2_a);

inst1_atx_clk_div_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_clk_div_a0_a = DFFEA(inst_aI4_adata_ox_a0_a_a7, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_ai_a138, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a0_a_a7,
	aclr => NOT_nRESET_acombout,
	ena => inst1_ai_a138,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_clk_div_a0_a);

inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a0_a : cyclone_lcell 
-- Equation(s):
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a = DFFEA((inst8_areduce_nor_7 & inst1_atx_clk_div_a0_a) # (!inst8_areduce_nor_7 & !inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a_aCOUT0 = CARRY(!inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a)
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a_aCOUT1 = CARRY(!inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3333",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a,
	datac => inst1_atx_clk_div_a0_a,
	aclr => NOT_nRESET_acombout,
	sload => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a,
	cout0 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a_aCOUT0,
	cout1 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a_aCOUT1);

inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a1_a : cyclone_lcell 
-- Equation(s):
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a = DFFEA((inst8_areduce_nor_7 & inst1_atx_clk_div_a1_a) # (!inst8_areduce_nor_7 & inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a $ inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a_aCOUT0), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a_aCOUT0 = CARRY(inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a # !inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a_aCOUT0)
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a_aCOUT1 = CARRY(inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a # !inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a_aCOUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "5AAF",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a,
	datac => inst1_atx_clk_div_a1_a,
	aclr => NOT_nRESET_acombout,
	sload => inst8_areduce_nor_7,
	cin0 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a_aCOUT0,
	cin1 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a,
	cout0 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a_aCOUT0,
	cout1 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a_aCOUT1);

inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a2_a : cyclone_lcell 
-- Equation(s):
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a = DFFEA((inst8_areduce_nor_7 & inst1_atx_clk_div_a2_a) # (!inst8_areduce_nor_7 & inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a $ !inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a_aCOUT0), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a_aCOUT0 = CARRY(!inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a & !inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a_aCOUT0)
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a_aCOUT1 = CARRY(!inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a & !inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a_aCOUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "A505",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a,
	datac => inst1_atx_clk_div_a2_a,
	aclr => NOT_nRESET_acombout,
	sload => inst8_areduce_nor_7,
	cin0 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a_aCOUT0,
	cin1 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a,
	cout0 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a_aCOUT0,
	cout1 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a_aCOUT1);

inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a3_a : cyclone_lcell 
-- Equation(s):
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a = DFFEA((inst8_areduce_nor_7 & inst1_atx_clk_div_a3_a) # (!inst8_areduce_nor_7 & inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a $ inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a_aCOUT0), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a_aCOUT0 = CARRY(inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a # !inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a_aCOUT0)
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a_aCOUT1 = CARRY(inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a # !inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a_aCOUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "3CCF",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a,
	datac => inst1_atx_clk_div_a3_a,
	aclr => NOT_nRESET_acombout,
	sload => inst8_areduce_nor_7,
	cin0 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a_aCOUT0,
	cin1 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a,
	cout0 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a_aCOUT0,
	cout1 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a_aCOUT1);

inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a4_a : cyclone_lcell 
-- Equation(s):
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a4_a = DFFEA((inst8_areduce_nor_7 & inst1_atx_clk_div_a4_a) # (!inst8_areduce_nor_7 & inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a4_a $ !inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a_aCOUT0), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a4_a_aCOUT = 

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "C303",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a4_a,
	datac => inst1_atx_clk_div_a4_a,
	aclr => NOT_nRESET_acombout,
	sload => inst8_areduce_nor_7,
	cin0 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a_aCOUT0,
	cin1 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a4_a,
	cout => inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a4_a_aCOUT);

inst1_atx_clk_div_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_clk_div_a5_a = DFFEA(inst_aI4_adata_ox_a5_a_a2, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_ai_a138, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a5_a_a2,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst1_ai_a138,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_clk_div_a5_a);

inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a5_a : cyclone_lcell 
-- Equation(s):
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a = DFFEA((inst8_areduce_nor_7 & inst1_atx_clk_div_a5_a) # (!inst8_areduce_nor_7 & inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a $ (!inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a4_a_aCOUT & GND) # (inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a4_a_aCOUT & VCC)), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a_aCOUT0 = CARRY(inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a # !inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a4_a_aCOUT)
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a_aCOUT1 = CARRY(inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a # !inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a4_a_aCOUT)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "3CCF",
	cin_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a,
	datac => inst1_atx_clk_div_a5_a,
	aclr => NOT_nRESET_acombout,
	sload => inst8_areduce_nor_7,
	cin => inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a4_a_aCOUT,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a,
	cout0 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a_aCOUT0,
	cout1 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a_aCOUT1);

inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a6_a : cyclone_lcell 
-- Equation(s):
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a = DFFEA((inst8_areduce_nor_7 & inst1_atx_clk_div_a6_a) # (!inst8_areduce_nor_7 & inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a $ !(!inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a4_a_aCOUT & inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a_aCOUT0) # (inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a4_a_aCOUT & inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a_aCOUT1)), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a_aCOUT0 = CARRY(!inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a & !inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a_aCOUT0)
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a_aCOUT1 = CARRY(!inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a & !inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a_aCOUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "A505",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a,
	datac => inst1_atx_clk_div_a6_a,
	aclr => NOT_nRESET_acombout,
	sload => inst8_areduce_nor_7,
	cin => inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a4_a_aCOUT,
	cin0 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a_aCOUT0,
	cin1 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a,
	cout0 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a_aCOUT0,
	cout1 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a_aCOUT1);

inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a7_a : cyclone_lcell 
-- Equation(s):
-- inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a7_a = DFFEA((inst8_areduce_nor_7 & inst1_atx_clk_div_a7_a) # (!inst8_areduce_nor_7 & inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a7_a $ (!inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a4_a_aCOUT & inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a_aCOUT0) # (inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a4_a_aCOUT & inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a_aCOUT1)), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "5A5A",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a7_a,
	datac => inst1_atx_clk_div_a7_a,
	aclr => NOT_nRESET_acombout,
	sload => inst8_areduce_nor_7,
	cin => inst8_arx_clk_count_rtl_11_awysi_counter_acounter_cell_a4_a_aCOUT,
	cin0 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a_aCOUT0,
	cin1 => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a7_a);

inst8_areduce_nor_7_a23_I : cyclone_lcell 
-- Equation(s):
-- inst8_areduce_nor_7_a23 = inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a7_a # inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a4_a # inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a # inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a7_a,
	datab => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a4_a,
	datac => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a,
	datad => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_areduce_nor_7_a23);

inst8_arx_uart_fifo_a7_a_a37_I : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_fifo_a7_a_a37 = !inst8_areduce_nor_7_a28 & inst8_arx_uart_fifo_a7_a_a29 & inst8_arx_uart_fifo_a7_a_a32 & !inst8_areduce_nor_7_a23

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0040",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_areduce_nor_7_a28,
	datab => inst8_arx_uart_fifo_a7_a_a29,
	datac => inst8_arx_uart_fifo_a7_a_a32,
	datad => inst8_areduce_nor_7_a23,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_arx_uart_fifo_a7_a_a37);

inst8_arx_uart_fifo_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_fifo_a1_a = DFFEA(!inst8_arx_uart_reg_a1_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_arx_uart_fifo_a7_a_a37, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst8_arx_uart_reg_a1_a,
	aclr => NOT_nRESET_acombout,
	ena => inst8_arx_uart_fifo_a7_a_a37,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_fifo_a1_a);

inst_aI3_adata_x_a1_a_a507_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a1_a_a507 = inst5_amux_c_a1_a & inst7_aaltsyncram_component_aq_a_a1_a # !inst5_amux_c_a1_a & (inst5_amux_c_a0_a & inst7_aaltsyncram_component_aq_a_a1_a # !inst5_amux_c_a0_a & inst8_arx_uart_fifo_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FE02",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_uart_fifo_a1_a,
	datab => inst5_amux_c_a1_a,
	datac => inst5_amux_c_a0_a,
	datad => inst7_aaltsyncram_component_aq_a_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a1_a_a507);

inst_aI3_adata_x_a1_a_a521_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a1_a_a521 = inst5_amux_c_a2_a & inst_aI3_adata_x_a1_a_a507 & inst_aI3_adata_x_a7_a_a1620 & !inst_aI4_ai_a528

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_amux_c_a2_a,
	datab => inst_aI3_adata_x_a1_a_a507,
	datac => inst_aI3_adata_x_a7_a_a1620,
	datad => inst_aI4_ai_a528,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a1_a_a521);

inst_aI3_adata_x_a1_a_a512_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a1_a_a512 = inst_aI4_aiinc_c_a1_a & (inst_aI4_aireg_c_a1_a # inst_aI4_areduce_nor_106) # !inst_aI4_aiinc_c_a1_a & inst_aI4_aireg_c_a1_a & !inst_aI4_areduce_nor_106

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI4_aiinc_c_a1_a,
	datac => inst_aI4_aireg_c_a1_a,
	datad => inst_aI4_areduce_nor_106,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a1_a_a512);

inst_aI2_adata_is_c_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a1_a_a519 = !inst_aI2_aTC_c_a0_a & inst_aI2_aTC_c_a1_a & M1_data_is_c[1] & !inst_aI2_aTC_c_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "0040",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aTC_c_a0_a,
	datab => inst_aI2_aTC_c_a1_a,
	datac => inst6_aaltsyncram_component_aq_a_a5_a,
	datad => inst_aI2_aTC_c_a2_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a1_a_a519);

inst_aI3_adata_x_a1_a_a1877_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a1_a_a1877 = inst_aI3_adata_x_a1_a_a519 # inst_aI3_adata_x_a1_a_a512 & inst_aI3_adata_x_a7_a_a1620 & inst_aI4_ai_a528

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ECCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a1_a_a512,
	datab => inst_aI3_adata_x_a1_a_a519,
	datac => inst_aI3_adata_x_a7_a_a1620,
	datad => inst_aI4_ai_a528,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a1_a_a1877);

inst3_aint_mask_c_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_mask_c_a1_a = DFFEA(inst_aI4_adata_ox_a1_a_a6, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst3_ai_a1, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a1_a_a6,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst3_ai_a1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_mask_c_a1_a);

IN_INT_a1_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_IN_INT(1),
	combout => IN_INT_a1_a_acombout);

inst3_aint_masked_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_masked_a1_a = DFFEA(inst3_aint_mask_c_a1_a & IN_INT_a1_a_acombout, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst3_aint_mask_c_a1_a,
	datad => IN_INT_a1_a_acombout,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_masked_a1_a);

inst3_aint_masked_c_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_masked_c_a1_a = DFFEA(inst3_aint_masked_a1_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst3_aint_masked_a1_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_masked_c_a1_a);

inst3_aint_clr_c_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_clr_c_a1_a = DFFEA(inst_aI4_adata_ox_a1_a_a6, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst3_ai_a121, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a1_a_a6,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst3_ai_a121,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_clr_c_a1_a);

inst3_aint_pending_c_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_pending_c_a1_a = DFFEA(!inst3_aint_clr_c_a1_a & (inst3_aint_pending_c_a1_a # !inst3_aint_masked_c_a1_a & inst3_aint_masked_a1_a), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0B0A",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst3_aint_pending_c_a1_a,
	datab => inst3_aint_masked_c_a1_a,
	datac => inst3_aint_clr_c_a1_a,
	datad => inst3_aint_masked_a1_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_pending_c_a1_a);

inst5_aMux_16_rtl_245_a0_I : cyclone_lcell 
-- Equation(s):
-- inst5_aMux_16_rtl_245_a0 = inst5_amux_c_a0_a & (inst3_aint_pending_c_a1_a # inst5_amux_c_a1_a) # !inst5_amux_c_a0_a & !inst5_amux_c_a1_a & inst7_aaltsyncram_component_aq_a_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CBC8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst3_aint_pending_c_a1_a,
	datab => inst5_amux_c_a0_a,
	datac => inst5_amux_c_a1_a,
	datad => inst7_aaltsyncram_component_aq_a_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aMux_16_rtl_245_a0);

PORTA_IN_a1_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTA_IN(1),
	combout => PORTA_IN_a1_a_acombout);

inst10_areg_data_out_c_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a1_a_a102 = K1_reg_data_out_c[1] & (!inst10_ai_a113 # !inst10_ai_a108 # !inst_aI5_ai_a12)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "70F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI5_ai_a12,
	datab => inst10_ai_a108,
	datac => inst10_areg_data_out_x_a1_a_a105,
	datad => inst10_ai_a113,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a1_a_a102);

PORTB_IN_a1_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTB_IN(1),
	combout => PORTB_IN_a1_a_acombout);

inst10_areg_data_out_x_a1_a_a101_I : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a1_a_a101 = PORTB_IN_a1_a_acombout & inst10_ai_a108 & inst_aI5_ai_a12 & inst10_ai_a113

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => PORTB_IN_a1_a_acombout,
	datab => inst10_ai_a108,
	datac => inst_aI5_ai_a12,
	datad => inst10_ai_a113,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a1_a_a101);

inst10_areg_data_out_x_a1_a_a105_I : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a1_a_a105 = inst10_ai_a3 & (inst10_areg_data_out_x_a1_a_a102 # inst10_areg_data_out_x_a1_a_a101) # !inst10_ai_a3 & PORTA_IN_a1_a_acombout

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EEE2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => PORTA_IN_a1_a_acombout,
	datab => inst10_ai_a3,
	datac => inst10_areg_data_out_x_a1_a_a102,
	datad => inst10_areg_data_out_x_a1_a_a101,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a1_a_a105);

inst5_aMux_16_rtl_245_a1_I : cyclone_lcell 
-- Equation(s):
-- inst5_aMux_16_rtl_245_a1 = inst5_aMux_16_rtl_245_a0 & (inst2_atmr_high_a1_a # !inst5_amux_c_a1_a) # !inst5_aMux_16_rtl_245_a0 & inst5_amux_c_a1_a & inst10_areg_data_out_x_a1_a_a105

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BC8C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_high_a1_a,
	datab => inst5_aMux_16_rtl_245_a0,
	datac => inst5_amux_c_a1_a,
	datad => inst10_areg_data_out_x_a1_a_a105,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aMux_16_rtl_245_a1);

inst_aI3_adata_x_a1_a_a517_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a1_a_a517 = inst_aI3_adata_x_a1_a_a521 # inst_aI3_adata_x_a1_a_a1877 # inst_aI3_adata_x_a7_a_a1618 & inst5_aMux_16_rtl_245_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FEFC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a7_a_a1618,
	datab => inst_aI3_adata_x_a1_a_a521,
	datac => inst_aI3_adata_x_a1_a_a1877,
	datad => inst5_aMux_16_rtl_245_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a1_a_a517);

rtl_a1911_I : cyclone_lcell 
-- Equation(s):
-- rtl_a1911 = rtl_a14838 & inst_aI2_aTD_c_a0_a & (inst_aI3_aacc_c_a0_a_a1_a $ inst_aI3_adata_x_a1_a_a517)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a1_a,
	datab => rtl_a14838,
	datac => inst_aI2_aTD_c_a0_a,
	datad => inst_aI3_adata_x_a1_a_a517,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1911);

rtl_a1910_I : cyclone_lcell 
-- Equation(s):
-- rtl_a1910 = rtl_a14838 & !inst_aI2_aTD_c_a0_a & inst_aI3_adata_x_a1_a_a517

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0C00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => rtl_a14838,
	datac => inst_aI2_aTD_c_a0_a,
	datad => inst_aI3_adata_x_a1_a_a517,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1910);

rtl_a2304_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2304 = !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a1_a & !inst_aI2_aTD_c_a1_a & inst_aI3_aMux_201_rtl_95_a0

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI3_aacc_c_a0_a_a1_a,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI3_aMux_201_rtl_95_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2304);

rtl_a3330_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3330 = inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a2_a & !inst_aI2_aTD_c_a1_a # !inst_aI2_aTD_c_a2_a & (inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a2_a # !inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4D48",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI3_aacc_c_a0_a_a2_a,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3330);

rtl_a3438_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3438 = inst_aI2_aTD_c_a2_a & (inst_aI3_aacc_c_a0_a_a1_a $ inst_aI2_aTD_c_a1_a) # !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "6F60",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a1_a,
	datab => inst_aI2_aTD_c_a1_a,
	datac => inst_aI2_aTD_c_a2_a,
	datad => inst_aI3_aacc_c_a0_a_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3438);

rtl_a2469_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2469 = !inst_aI3_aMux_201_rtl_95_a0 & (inst_aI2_aTD_c_a0_a & rtl_a3438 # !inst_aI2_aTD_c_a0_a & rtl_a3330)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3202",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a3330,
	datab => inst_aI3_aMux_201_rtl_95_a0,
	datac => inst_aI2_aTD_c_a0_a,
	datad => rtl_a3438,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2469);

inst_aI3_aMux_177_rtl_79_rtl_546_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aMux_177_rtl_79_rtl_546_a0 = inst_aI2_aTD_c_a1_a & (inst_aI2_aTD_c_a0_a # inst_aI3_aadd_153_a2) # !inst_aI2_aTD_c_a1_a & !inst_aI2_aTD_c_a0_a & inst_aI3_aadd_129_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DC98",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI2_aTD_c_a1_a,
	datac => inst_aI3_aadd_129_a1,
	datad => inst_aI3_aadd_153_a2,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_177_rtl_79_rtl_546_a0);

inst_aI3_aMux_177_rtl_79_rtl_546_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aMux_177_rtl_79_rtl_546_a1 = inst_aI3_aacc_c_a0_a_a1_a & (inst_aI3_aMux_177_rtl_79_rtl_546_a0 # inst_aI2_aTD_c_a0_a & inst_aI3_adata_x_a1_a_a517) # !inst_aI3_aacc_c_a0_a_a1_a & inst_aI3_aMux_177_rtl_79_rtl_546_a0 & (inst_aI3_adata_x_a1_a_a517 # !inst_aI2_aTD_c_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FB80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a1_a,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_adata_x_a1_a_a517,
	datad => inst_aI3_aMux_177_rtl_79_rtl_546_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_177_rtl_79_rtl_546_a1);

rtl_a15406_I : cyclone_lcell 
-- Equation(s):
-- rtl_a15406 = rtl_a2304 # rtl_a2469 # rtl_a14854 & inst_aI3_aMux_177_rtl_79_rtl_546_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FEEE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a2304,
	datab => rtl_a2469,
	datac => rtl_a14854,
	datad => inst_aI3_aMux_177_rtl_79_rtl_546_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a15406);

inst_aI3_aacc_a0_a_a1_a_a48_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a1_a_a48 = inst_aI3_aacc_a0_a_a7_a_a4226 & (rtl_a1911 # rtl_a1910 # rtl_a15406)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAA8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_a0_a_a7_a_a4226,
	datab => rtl_a1911,
	datac => rtl_a1910,
	datad => rtl_a15406,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a1_a_a48);

inst_aI3_aacc_c_a0_a_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a1_a_a128 = inst_aI3_aacc_a0_a_a1_a_a49 # inst_aI3_aacc_a0_a_a1_a_a48 # inst_aI3_aacc_a0_a_a8_a_a63 & N1_acc_c[0][1]
-- inst_aI3_aacc_c_a0_a_a1_a = DFFEA(inst_aI3_aacc_a0_a_a1_a_a128, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "FFEC",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_a0_a_a8_a_a63,
	datab => inst_aI3_aacc_a0_a_a1_a_a49,
	datad => inst_aI3_aacc_a0_a_a1_a_a48,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a1_a_a128,
	regout => inst_aI3_aacc_c_a0_a_a1_a);

inst_aI3_aacc_i_a0_a_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a1_a_a49 = rtl_a2352 & inst_aI2_aTC_c_a2_a & N1_acc_i[0][1] & inst_aI3_ai_a220

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => rtl_a2352,
	datab => inst_aI2_aTC_c_a2_a,
	datac => inst_aI3_aacc_a0_a_a1_a_a128,
	datad => inst_aI3_ai_a220,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst_aI2_aint_start_c,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a1_a_a49);

inst10_aout_0reg_a1_a_areg0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adata_ox_a1_a_a6 = inst_aI3_aacc_c_a0_a_a1_a & inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a & nRESET_acombout
-- inst10_aout_0reg_a1_a_areg0 = DFFEA(inst_aI4_adata_ox_a1_a_a6, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst10_ai_a1, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C000",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst_aI3_aacc_c_a0_a_a1_a,
	datac => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a,
	datad => nRESET_acombout,
	aclr => NOT_nRESET_acombout,
	ena => inst10_ai_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adata_ox_a1_a_a6,
	regout => inst10_aout_0reg_a1_a_areg0);

inst1_atx_clk_div_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_clk_div_a1_a = DFFEA(inst_aI4_adata_ox_a1_a_a6, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_ai_a138, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0F0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a1_a_a6,
	aclr => NOT_nRESET_acombout,
	ena => inst1_ai_a138,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_clk_div_a1_a);

inst8_areduce_nor_7_a28_I : cyclone_lcell 
-- Equation(s):
-- inst8_areduce_nor_7_a28 = inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a # inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a # inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a # inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a1_a,
	datab => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a3_a,
	datac => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a2_a,
	datad => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_areduce_nor_7_a28);

inst8_areduce_nor_7_a35_I : cyclone_lcell 
-- Equation(s):
-- inst8_areduce_nor_7_a35 = inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a7_a # inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a7_a,
	datad => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a6_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_areduce_nor_7_a35);

inst8_areduce_nor_7_aI : cyclone_lcell 
-- Equation(s):
-- inst8_areduce_nor_7 = !inst8_areduce_nor_7_a28 & !inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a & !inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a4_a & !inst8_areduce_nor_7_a35

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0001",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_areduce_nor_7_a28,
	datab => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a5_a,
	datac => inst8_arx_clk_count_rtl_11_awysi_counter_asafe_q_a4_a,
	datad => inst8_areduce_nor_7_a35,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_areduce_nor_7);

inst8_arx_8_count_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_8_count_a0_a = DFFEA(inst8_arx_s_a0_a & !inst8_arx_s_a1_a & inst8_arx_8_count_a0_a # !inst8_arx_s_a0_a & (inst8_arx_s_a1_a $ inst8_arx_8_count_a0_a), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F30",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst8_arx_s_a0_a,
	datac => inst8_arx_s_a1_a,
	datad => inst8_arx_8_count_a0_a,
	aclr => NOT_nRESET_acombout,
	ena => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_8_count_a0_a);

inst8_arx_8_count_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_8_count_a1_a = DFFEA(inst8_arx_s_a1_a & !inst8_arx_s_a0_a & (inst8_arx_8_count_a0_a $ inst8_arx_8_count_a1_a) # !inst8_arx_s_a1_a & inst8_arx_8_count_a1_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0C6C",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst8_arx_8_count_a0_a,
	datab => inst8_arx_8_count_a1_a,
	datac => inst8_arx_s_a1_a,
	datad => inst8_arx_s_a0_a,
	aclr => NOT_nRESET_acombout,
	ena => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_8_count_a1_a);

inst8_areduce_nor_68_aI : cyclone_lcell 
-- Equation(s):
-- inst8_areduce_nor_68 = !inst8_arx_8_count_a0_a # !inst8_arx_8_count_a2_a # !inst8_arx_8_count_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3FFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst8_arx_8_count_a1_a,
	datac => inst8_arx_8_count_a2_a,
	datad => inst8_arx_8_count_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_areduce_nor_68);

inst8_arx_s_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_s_a1_a = DFFEA(inst8_arx_s_a0_a & rtl_a14863 & !inst8_arx_s_a1_a # !inst8_arx_s_a0_a & inst8_arx_s_a1_a & inst8_areduce_nor_68, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3808",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => rtl_a14863,
	datab => inst8_arx_s_a0_a,
	datac => inst8_arx_s_a1_a,
	datad => inst8_areduce_nor_68,
	aclr => NOT_nRESET_acombout,
	ena => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_s_a1_a);

inst8_arx_16_count_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_16_count_a0_a = DFFEA(inst8_arx_16_count_a0_a & !inst8_arx_s_a0_a # !inst8_arx_16_count_a0_a & inst8_arx_s_a0_a & !inst8_arx_s_a1_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0C3C",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst8_arx_16_count_a0_a,
	datac => inst8_arx_s_a0_a,
	datad => inst8_arx_s_a1_a,
	aclr => NOT_nRESET_acombout,
	ena => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_16_count_a0_a);

inst8_aadd_45_a5_I : cyclone_lcell 
-- Equation(s):
-- inst8_aadd_45_a5 = inst8_arx_16_count_a1_a $ inst8_arx_16_count_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "33CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst8_arx_16_count_a1_a,
	datad => inst8_arx_16_count_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_aadd_45_a5);

inst8_arx_16_count_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_16_count_a1_a = DFFEA(rtl_a1015 # rtl_a14851 & inst8_areduce_nor_27 & inst8_aadd_45_a5, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EAAA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => rtl_a1015,
	datab => rtl_a14851,
	datac => inst8_areduce_nor_27,
	datad => inst8_aadd_45_a5,
	aclr => NOT_nRESET_acombout,
	ena => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_16_count_a1_a);

inst8_areduce_nor_27_a4_I : cyclone_lcell 
-- Equation(s):
-- inst8_areduce_nor_27_a4 = inst8_arx_16_count_a1_a & inst8_arx_16_count_a0_a & inst8_arx_16_count_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst8_arx_16_count_a1_a,
	datac => inst8_arx_16_count_a0_a,
	datad => inst8_arx_16_count_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_areduce_nor_27_a4);

inst8_arx_16_count_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_16_count_a3_a = DFFEA(inst8_arx_s_a0_a & !inst8_arx_s_a1_a & (inst8_arx_16_count_a3_a $ inst8_areduce_nor_27_a4) # !inst8_arx_s_a0_a & inst8_arx_16_count_a3_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "446C",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst8_arx_s_a0_a,
	datab => inst8_arx_16_count_a3_a,
	datac => inst8_areduce_nor_27_a4,
	datad => inst8_arx_s_a1_a,
	aclr => NOT_nRESET_acombout,
	ena => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_16_count_a3_a);

rtl_a14863_I : cyclone_lcell 
-- Equation(s):
-- rtl_a14863 = inst8_arx_16_count_a3_a & inst8_areduce_nor_27_a4 & inst8_arx_bit_count_a3_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst8_arx_16_count_a3_a,
	datac => inst8_areduce_nor_27_a4,
	datad => inst8_arx_bit_count_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a14863);

rtl_a15506_I : cyclone_lcell 
-- Equation(s):
-- rtl_a15506 = !RXD_acombout & !inst8_arx_s_a0_a & !inst8_arx_s_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0003",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => RXD_acombout,
	datac => inst8_arx_s_a0_a,
	datad => inst8_arx_s_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a15506);

inst8_arx_8z_count_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_8z_count_a0_a = DFFEA(inst8_arx_8z_count_a0_a & (inst8_arx_s_a0_a $ inst8_arx_s_a1_a) # !inst8_arx_8z_count_a0_a & !inst8_arx_s_a0_a & !RXD_acombout & !inst8_arx_s_a1_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "50A1",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst8_arx_s_a0_a,
	datab => RXD_acombout,
	datac => inst8_arx_8z_count_a0_a,
	datad => inst8_arx_s_a1_a,
	aclr => NOT_nRESET_acombout,
	ena => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_8z_count_a0_a);

rtl_a1038_I : cyclone_lcell 
-- Equation(s):
-- rtl_a1038 = inst8_arx_8z_count_a1_a & (inst8_arx_s_a1_a $ inst8_arx_s_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3C00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst8_arx_s_a1_a,
	datac => inst8_arx_s_a0_a,
	datad => inst8_arx_8z_count_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1038);

inst8_aadd_13_a5_I : cyclone_lcell 
-- Equation(s):
-- inst8_aadd_13_a5 = inst8_arx_8z_count_a0_a $ inst8_arx_8z_count_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0FF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst8_arx_8z_count_a0_a,
	datad => inst8_arx_8z_count_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_aadd_13_a5);

rtl_a14845_I : cyclone_lcell 
-- Equation(s):
-- rtl_a14845 = !inst8_arx_8z_count_a3_a & inst8_arx_8z_count_a2_a & inst8_arx_8z_count_a0_a & inst8_arx_8z_count_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_8z_count_a3_a,
	datab => inst8_arx_8z_count_a2_a,
	datac => inst8_arx_8z_count_a0_a,
	datad => inst8_arx_8z_count_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a14845);

inst8_arx_8z_count_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_8z_count_a1_a = DFFEA(rtl_a1038 # inst8_aadd_13_a5 & rtl_a15506 & !rtl_a14845, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAEA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => rtl_a1038,
	datab => inst8_aadd_13_a5,
	datac => rtl_a15506,
	datad => rtl_a14845,
	aclr => NOT_nRESET_acombout,
	ena => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_8z_count_a1_a);

inst8_aadd_13_a10_I : cyclone_lcell 
-- Equation(s):
-- inst8_aadd_13_a10 = inst8_arx_8z_count_a2_a $ (inst8_arx_8z_count_a0_a & inst8_arx_8z_count_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3CCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst8_arx_8z_count_a2_a,
	datac => inst8_arx_8z_count_a0_a,
	datad => inst8_arx_8z_count_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_aadd_13_a10);

rtl_a1035_I : cyclone_lcell 
-- Equation(s):
-- rtl_a1035 = inst8_arx_8z_count_a2_a & (inst8_arx_s_a0_a $ inst8_arx_s_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "50A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_s_a0_a,
	datac => inst8_arx_8z_count_a2_a,
	datad => inst8_arx_s_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1035);

inst8_arx_8z_count_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_8z_count_a2_a = DFFEA(rtl_a1035 # inst8_aadd_13_a10 & !rtl_a14845 & rtl_a15506, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF20",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst8_aadd_13_a10,
	datab => rtl_a14845,
	datac => rtl_a15506,
	datad => rtl_a1035,
	aclr => NOT_nRESET_acombout,
	ena => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_8z_count_a2_a);

rtl_a14867_I : cyclone_lcell 
-- Equation(s):
-- rtl_a14867 = inst8_arx_8z_count_a2_a & inst8_arx_8z_count_a0_a & inst8_arx_8z_count_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst8_arx_8z_count_a2_a,
	datac => inst8_arx_8z_count_a0_a,
	datad => inst8_arx_8z_count_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a14867);

inst8_aMux_103_a0_I : cyclone_lcell 
-- Equation(s):
-- inst8_aMux_103_a0 = inst8_arx_s_a0_a $ inst8_arx_s_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0FF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst8_arx_s_a0_a,
	datad => inst8_arx_s_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_aMux_103_a0);

inst8_arx_8z_count_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_8z_count_a3_a = DFFEA(inst8_arx_8z_count_a3_a & (inst8_aMux_103_a0 # rtl_a15506 & !rtl_a14867), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AA08",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst8_arx_8z_count_a3_a,
	datab => rtl_a15506,
	datac => rtl_a14867,
	datad => inst8_aMux_103_a0,
	aclr => NOT_nRESET_acombout,
	ena => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_8z_count_a3_a);

rtl_a3354_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3354 = !inst8_arx_8z_count_a3_a & !RXD_acombout & !inst8_arx_s_a0_a & rtl_a14867

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0100",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_8z_count_a3_a,
	datab => RXD_acombout,
	datac => inst8_arx_s_a0_a,
	datad => rtl_a14867,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3354);

inst8_arx_s_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_s_a0_a = DFFEA(!inst8_arx_s_a1_a & (rtl_a3354 # !rtl_a14863 & inst8_arx_s_a0_a), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F04",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => rtl_a14863,
	datab => inst8_arx_s_a0_a,
	datac => inst8_arx_s_a1_a,
	datad => rtl_a3354,
	aclr => NOT_nRESET_acombout,
	ena => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_s_a0_a);

rtl_a14851_I : cyclone_lcell 
-- Equation(s):
-- rtl_a14851 = inst8_arx_s_a0_a & !inst8_arx_s_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst8_arx_s_a0_a,
	datad => inst8_arx_s_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a14851);

rtl_a1012_I : cyclone_lcell 
-- Equation(s):
-- rtl_a1012 = !inst8_arx_s_a0_a & inst8_arx_16_count_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3300",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst8_arx_s_a0_a,
	datad => inst8_arx_16_count_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1012);

inst8_aadd_45_a10_I : cyclone_lcell 
-- Equation(s):
-- inst8_aadd_45_a10 = inst8_arx_16_count_a2_a $ (inst8_arx_16_count_a1_a & inst8_arx_16_count_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3FC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst8_arx_16_count_a1_a,
	datac => inst8_arx_16_count_a0_a,
	datad => inst8_arx_16_count_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_aadd_45_a10);

inst8_arx_16_count_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_16_count_a2_a = DFFEA(rtl_a1012 # rtl_a14851 & inst8_areduce_nor_27 & inst8_aadd_45_a10, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ECCC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => rtl_a14851,
	datab => rtl_a1012,
	datac => inst8_areduce_nor_27,
	datad => inst8_aadd_45_a10,
	aclr => NOT_nRESET_acombout,
	ena => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_16_count_a2_a);

inst8_areduce_nor_27_aI : cyclone_lcell 
-- Equation(s):
-- inst8_areduce_nor_27 = !inst8_arx_16_count_a0_a # !inst8_arx_16_count_a3_a # !inst8_arx_16_count_a1_a # !inst8_arx_16_count_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "7FFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_16_count_a2_a,
	datab => inst8_arx_16_count_a1_a,
	datac => inst8_arx_16_count_a3_a,
	datad => inst8_arx_16_count_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_areduce_nor_27);

inst8_aDecoder_28_a18_I : cyclone_lcell 
-- Equation(s):
-- inst8_aDecoder_28_a18 = !inst8_arx_bit_count_a3_a & !inst8_arx_bit_count_a0_a & !inst8_arx_bit_count_a2_a & inst8_arx_bit_count_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0100",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_bit_count_a3_a,
	datab => inst8_arx_bit_count_a0_a,
	datac => inst8_arx_bit_count_a2_a,
	datad => inst8_arx_bit_count_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_aDecoder_28_a18);

inst8_arx_uart_reg_a2_a_a6_I : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a2_a_a6 = !inst8_areduce_nor_27 & rtl_a14851 & inst8_aDecoder_28_a18 & inst8_areduce_nor_7

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_areduce_nor_27,
	datab => rtl_a14851,
	datac => inst8_aDecoder_28_a18,
	datad => inst8_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_arx_uart_reg_a2_a_a6);

inst8_arx_uart_reg_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a2_a = DFFEA(!RXD_acombout, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_arx_uart_reg_a2_a_a6, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => RXD_acombout,
	aclr => NOT_nRESET_acombout,
	ena => inst8_arx_uart_reg_a2_a_a6,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_reg_a2_a);

inst8_arx_uart_fifo_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_fifo_a2_a = DFFEA(!inst8_arx_uart_reg_a2_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_arx_uart_fifo_a7_a_a37, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst8_arx_uart_reg_a2_a,
	aclr => NOT_nRESET_acombout,
	ena => inst8_arx_uart_fifo_a7_a_a37,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_fifo_a2_a);

inst_aI3_adata_x_a2_a_a437_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a2_a_a437 = inst5_amux_c_a0_a & inst7_aaltsyncram_component_aq_a_a2_a # !inst5_amux_c_a0_a & (inst5_amux_c_a1_a & inst7_aaltsyncram_component_aq_a_a2_a # !inst5_amux_c_a1_a & inst8_arx_uart_fifo_a2_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FE02",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_uart_fifo_a2_a,
	datab => inst5_amux_c_a0_a,
	datac => inst5_amux_c_a1_a,
	datad => inst7_aaltsyncram_component_aq_a_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a2_a_a437);

inst_aI3_adata_x_a2_a_a451_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a2_a_a451 = inst5_amux_c_a2_a & inst_aI3_adata_x_a7_a_a1620 & inst_aI3_adata_x_a2_a_a437 & !inst_aI4_ai_a528

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_amux_c_a2_a,
	datab => inst_aI3_adata_x_a7_a_a1620,
	datac => inst_aI3_adata_x_a2_a_a437,
	datad => inst_aI4_ai_a528,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a2_a_a451);

inst3_aint_clr_c_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_clr_c_a2_a = DFFEA(inst_aI4_adata_ox_a2_a_a5, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst3_ai_a121, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a2_a_a5,
	aclr => NOT_nRESET_acombout,
	ena => inst3_ai_a121,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_clr_c_a2_a);

inst3_aint_mask_c_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_mask_c_a2_a = DFFEA(inst_aI4_adata_ox_a2_a_a5, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst3_ai_a1, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a2_a_a5,
	aclr => NOT_nRESET_acombout,
	ena => inst3_ai_a1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_mask_c_a2_a);

IN_INT_a2_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_IN_INT(2),
	combout => IN_INT_a2_a_acombout);

inst3_aint_masked_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_masked_a2_a = DFFEA(inst3_aint_mask_c_a2_a & IN_INT_a2_a_acombout, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst3_aint_mask_c_a2_a,
	datad => IN_INT_a2_a_acombout,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_masked_a2_a);

inst3_aint_masked_c_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_masked_c_a2_a = DFFEA(inst3_aint_masked_a2_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst3_aint_masked_a2_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_masked_c_a2_a);

inst3_aint_pending_c_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_pending_c_a2_a = DFFEA(!inst3_aint_clr_c_a2_a & (inst3_aint_pending_c_a2_a # inst3_aint_masked_a2_a & !inst3_aint_masked_c_a2_a), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5504",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst3_aint_clr_c_a2_a,
	datab => inst3_aint_masked_a2_a,
	datac => inst3_aint_masked_c_a2_a,
	datad => inst3_aint_pending_c_a2_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_pending_c_a2_a);

PORTA_IN_a2_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTA_IN(2),
	combout => PORTA_IN_a2_a_acombout);

PORTB_IN_a2_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTB_IN(2),
	combout => PORTB_IN_a2_a_acombout);

inst10_areg_data_out_x_a2_a_a91_I : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a2_a_a91 = PORTB_IN_a2_a_acombout & inst10_ai_a108 & inst_aI5_ai_a12 & inst10_ai_a113

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => PORTB_IN_a2_a_acombout,
	datab => inst10_ai_a108,
	datac => inst_aI5_ai_a12,
	datad => inst10_ai_a113,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a2_a_a91);

inst10_areg_data_out_c_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a2_a_a92 = K1_reg_data_out_c[2] & (!inst10_ai_a113 # !inst10_ai_a108 # !inst_aI5_ai_a12)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "70F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI5_ai_a12,
	datab => inst10_ai_a108,
	datac => inst10_areg_data_out_x_a2_a_a95,
	datad => inst10_ai_a113,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a2_a_a92);

inst10_areg_data_out_x_a2_a_a95_I : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a2_a_a95 = inst10_ai_a3 & (inst10_areg_data_out_x_a2_a_a91 # inst10_areg_data_out_x_a2_a_a92) # !inst10_ai_a3 & PORTA_IN_a2_a_acombout

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EEE2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => PORTA_IN_a2_a_acombout,
	datab => inst10_ai_a3,
	datac => inst10_areg_data_out_x_a2_a_a91,
	datad => inst10_areg_data_out_x_a2_a_a92,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a2_a_a95);

inst5_aMux_15_rtl_242_a0_I : cyclone_lcell 
-- Equation(s):
-- inst5_aMux_15_rtl_242_a0 = inst5_amux_c_a1_a & (inst5_amux_c_a0_a # inst10_areg_data_out_x_a2_a_a95) # !inst5_amux_c_a1_a & !inst5_amux_c_a0_a & inst7_aaltsyncram_component_aq_a_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BA98",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_amux_c_a1_a,
	datab => inst5_amux_c_a0_a,
	datac => inst7_aaltsyncram_component_aq_a_a2_a,
	datad => inst10_areg_data_out_x_a2_a_a95,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aMux_15_rtl_242_a0);

inst5_aMux_15_rtl_242_a1_I : cyclone_lcell 
-- Equation(s):
-- inst5_aMux_15_rtl_242_a1 = inst5_aMux_15_rtl_242_a0 & (inst2_atmr_high_a2_a # !inst5_amux_c_a0_a) # !inst5_aMux_15_rtl_242_a0 & inst3_aint_pending_c_a2_a & inst5_amux_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_high_a2_a,
	datab => inst3_aint_pending_c_a2_a,
	datac => inst5_amux_c_a0_a,
	datad => inst5_aMux_15_rtl_242_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aMux_15_rtl_242_a1);

inst_aI3_adata_x_a2_a_a447_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a2_a_a447 = inst_aI3_adata_x_a2_a_a1844 # inst_aI3_adata_x_a2_a_a451 # inst_aI3_adata_x_a7_a_a1618 & inst5_aMux_15_rtl_242_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FEFC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a7_a_a1618,
	datab => inst_aI3_adata_x_a2_a_a1844,
	datac => inst_aI3_adata_x_a2_a_a451,
	datad => inst5_aMux_15_rtl_242_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a2_a_a447);

rtl_a1870_I : cyclone_lcell 
-- Equation(s):
-- rtl_a1870 = rtl_a14838 & inst_aI2_aTD_c_a0_a & (inst_aI3_aacc_c_a0_a_a2_a $ inst_aI3_adata_x_a2_a_a447)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "6000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a2_a,
	datab => inst_aI3_adata_x_a2_a_a447,
	datac => rtl_a14838,
	datad => inst_aI2_aTD_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1870);

rtl_a1869_I : cyclone_lcell 
-- Equation(s):
-- rtl_a1869 = !inst_aI2_aTD_c_a0_a & inst_aI3_adata_x_a2_a_a447 & rtl_a14838

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_adata_x_a2_a_a447,
	datad => rtl_a14838,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1869);

rtl_a2298_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2298 = !inst_aI2_aTD_c_a1_a & !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a2_a & inst_aI3_aMux_201_rtl_95_a0

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "1000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a1_a,
	datab => inst_aI2_aTD_c_a2_a,
	datac => inst_aI3_aacc_c_a0_a_a2_a,
	datad => inst_aI3_aMux_201_rtl_95_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2298);

rtl_a3319_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3319 = inst_aI2_aTD_c_a2_a & !inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a3_a # !inst_aI2_aTD_c_a2_a & (inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a3_a # !inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a2_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3E02",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a2_a,
	datab => inst_aI2_aTD_c_a2_a,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI3_aacc_c_a0_a_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3319);

rtl_a3428_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3428 = inst_aI2_aTD_c_a2_a & (inst_aI2_aTD_c_a1_a $ inst_aI3_aacc_c_a0_a_a2_a) # !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "7B48",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a1_a,
	datab => inst_aI2_aTD_c_a2_a,
	datac => inst_aI3_aacc_c_a0_a_a2_a,
	datad => inst_aI3_aacc_c_a0_a_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3428);

rtl_a2454_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2454 = !inst_aI3_aMux_201_rtl_95_a0 & (inst_aI2_aTD_c_a0_a & rtl_a3428 # !inst_aI2_aTD_c_a0_a & rtl_a3319)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0E02",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a3319,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_aMux_201_rtl_95_a0,
	datad => rtl_a3428,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2454);

inst_aI3_aMux_176_rtl_73_rtl_540_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aMux_176_rtl_73_rtl_540_a0 = inst_aI2_aTD_c_a1_a & (inst_aI2_aTD_c_a0_a # inst_aI3_aadd_153_a3) # !inst_aI2_aTD_c_a1_a & !inst_aI2_aTD_c_a0_a & inst_aI3_aadd_129_a2

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "B9A8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a1_a,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_aadd_153_a3,
	datad => inst_aI3_aadd_129_a2,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_176_rtl_73_rtl_540_a0);

inst_aI3_aMux_176_rtl_73_rtl_540_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aMux_176_rtl_73_rtl_540_a1 = inst_aI3_aacc_c_a0_a_a2_a & (inst_aI3_aMux_176_rtl_73_rtl_540_a0 # inst_aI2_aTD_c_a0_a & inst_aI3_adata_x_a2_a_a447) # !inst_aI3_aacc_c_a0_a_a2_a & inst_aI3_aMux_176_rtl_73_rtl_540_a0 & (inst_aI3_adata_x_a2_a_a447 # !inst_aI2_aTD_c_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FB80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a2_a,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_adata_x_a2_a_a447,
	datad => inst_aI3_aMux_176_rtl_73_rtl_540_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_176_rtl_73_rtl_540_a1);

rtl_a15363_I : cyclone_lcell 
-- Equation(s):
-- rtl_a15363 = rtl_a2298 # rtl_a2454 # rtl_a14854 & inst_aI3_aMux_176_rtl_73_rtl_540_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FEFC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a14854,
	datab => rtl_a2298,
	datac => rtl_a2454,
	datad => inst_aI3_aMux_176_rtl_73_rtl_540_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a15363);

inst_aI3_aacc_a0_a_a2_a_a45_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a2_a_a45 = inst_aI3_aacc_a0_a_a7_a_a4226 & (rtl_a1870 # rtl_a1869 # rtl_a15363)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAA8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_a0_a_a7_a_a4226,
	datab => rtl_a1870,
	datac => rtl_a1869,
	datad => rtl_a15363,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a2_a_a45);

inst_aI3_aacc_c_a0_a_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a2_a_a118 = inst_aI3_aacc_a0_a_a2_a_a46 # inst_aI3_aacc_a0_a_a2_a_a45 # inst_aI3_aacc_a0_a_a8_a_a63 & N1_acc_c[0][2]
-- inst_aI3_aacc_c_a0_a_a2_a = DFFEA(inst_aI3_aacc_a0_a_a2_a_a118, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "FFEA",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_a0_a_a2_a_a46,
	datab => inst_aI3_aacc_a0_a_a8_a_a63,
	datad => inst_aI3_aacc_a0_a_a2_a_a45,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a2_a_a118,
	regout => inst_aI3_aacc_c_a0_a_a2_a);

inst_aI3_aacc_i_a0_a_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a2_a_a46 = inst_aI3_ai_a220 & rtl_a2352 & N1_acc_i[0][2] & inst_aI2_aTC_c_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_ai_a220,
	datab => rtl_a2352,
	datac => inst_aI3_aacc_a0_a_a2_a_a118,
	datad => inst_aI2_aTC_c_a2_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst_aI2_aint_start_c,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a2_a_a46);

inst_aI4_aadd_104_rtl_648_a58_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_rtl_648_a58 = inst_aI4_areduce_nor_103 & inst_aI4_aireg_c_a2_a # !inst_aI4_areduce_nor_103 & (inst_aI4_ai_a20 & inst_aI4_aadd_104_a2 # !inst_aI4_ai_a20 & inst_aI4_aireg_c_a2_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "D8CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_areduce_nor_103,
	datab => inst_aI4_aireg_c_a2_a,
	datac => inst_aI4_aadd_104_a2,
	datad => inst_aI4_ai_a20,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_rtl_648_a58);

inst_aI4_aireg_i_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_rtl_648_a63 = inst_aI4_aireg_we_c & inst_aI3_aacc_c_a0_a_a2_a # !inst_aI4_aireg_we_c & inst_aI4_ai_a18 & inst_aI4_aadd_104_rtl_648_a58
-- inst_aI4_aireg_i_a2_a = DFFEA(inst_aI4_aadd_104_rtl_648_a63, GLOBAL(UCLK_acombout), VCC, , inst_aI4_aireg_i_a0_a_a6, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CAC0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_ai_a18,
	datab => inst_aI3_aacc_c_a0_a_a2_a,
	datac => inst_aI4_aireg_we_c,
	datad => inst_aI4_aadd_104_rtl_648_a58,
	aclr => GND,
	ena => inst_aI4_aireg_i_a0_a_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_rtl_648_a63,
	regout => inst_aI4_aireg_i_a2_a);

inst_aI4_aireg_c_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aireg_c_a2_a = DFFEA(inst_aI2_aE_x_aint_e_a0 & inst_aI4_aadd_104_rtl_648_a63 # !inst_aI2_aE_x_aint_e_a0 & (inst_aI2_aint_stop_x_a10 & inst_aI4_aireg_i_a2_a # !inst_aI2_aint_stop_x_a10 & inst_aI4_aadd_104_rtl_648_a63), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EF40",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aE_x_aint_e_a0,
	datab => inst_aI4_aireg_i_a2_a,
	datac => inst_aI2_aint_stop_x_a10,
	datad => inst_aI4_aadd_104_rtl_648_a63,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aireg_c_a2_a);

inst_aI5_adaddr_c_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI5_adaddr_c_a2_a = DFFEA(inst_aI4_ai_a18 & (inst6_aaltsyncram_component_aq_a_a6_a # inst_aI4_aireg_c_a2_a & inst_aI4_ai_a133), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A8A0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_ai_a18,
	datab => inst_aI4_aireg_c_a2_a,
	datac => inst6_aaltsyncram_component_aq_a_a6_a,
	datad => inst_aI4_ai_a133,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI5_adaddr_c_a2_a);

inst_aI4_adaddr_x_a2_a_a30_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adaddr_x_a2_a_a30 = inst_aI4_ai_a18 & inst_aI4_aireg_c_a2_a & !inst_aI4_areduce_nor_103 & inst_aI4_ai_a20

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_ai_a18,
	datab => inst_aI4_aireg_c_a2_a,
	datac => inst_aI4_areduce_nor_103,
	datad => inst_aI4_ai_a20,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adaddr_x_a2_a_a30);

inst_aI5_ai_a15_I : cyclone_lcell 
-- Equation(s):
-- inst_aI5_ai_a15 = inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a2_a # !inst_aI4_andre_x_a1 & (inst_aI4_adaddr_x_a2_a_a29 # inst_aI4_adaddr_x_a2_a_a30)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CFCA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_adaddr_x_a2_a_a29,
	datab => inst_aI5_adaddr_c_a2_a,
	datac => inst_aI4_andre_x_a1,
	datad => inst_aI4_adaddr_x_a2_a_a30,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI5_ai_a15);

inst5_areduce_nor_19_a54_I : cyclone_lcell 
-- Equation(s):
-- inst5_areduce_nor_19_a54 = inst_aI5_ai_a21 # inst_aI5_ai_a18 # !inst_aI5_ai_a15

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFCF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI5_ai_a21,
	datac => inst_aI5_ai_a15,
	datad => inst_aI5_ai_a18,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_areduce_nor_19_a54);

inst3_ai_a121_I : cyclone_lcell 
-- Equation(s):
-- inst3_ai_a121 = inst1_ai_a457 & inst_aI5_ai_a24 & inst_aI5_ai_a12 & !inst5_areduce_nor_19_a54

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_ai_a457,
	datab => inst_aI5_ai_a24,
	datac => inst_aI5_ai_a12,
	datad => inst5_areduce_nor_19_a54,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst3_ai_a121);

inst3_aint_clr_c_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_clr_c_a6_a = DFFEA(inst_aI4_adata_ox_a6_a_a1, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst3_ai_a121, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a6_a_a1,
	aclr => NOT_nRESET_acombout,
	ena => inst3_ai_a121,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_clr_c_a6_a);

inst3_aint_mask_c_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_mask_c_a6_a = DFFEA(inst_aI4_adata_ox_a6_a_a1, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst3_ai_a1, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a6_a_a1,
	aclr => NOT_nRESET_acombout,
	ena => inst3_ai_a1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_mask_c_a6_a);

inst3_aint_masked_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_masked_a6_a = DFFEA(!inst1_atx_uart_busy & inst3_aint_mask_c_a6_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst1_atx_uart_busy,
	datad => inst3_aint_mask_c_a6_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_masked_a6_a);

inst3_aint_masked_c_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_masked_c_a6_a = DFFEA(inst3_aint_masked_a6_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst3_aint_masked_a6_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_masked_c_a6_a);

inst3_aint_pending_c_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_pending_c_a6_a = DFFEA(!inst3_aint_clr_c_a6_a & (inst3_aint_pending_c_a6_a # inst3_aint_masked_a6_a & !inst3_aint_masked_c_a6_a), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5054",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst3_aint_clr_c_a6_a,
	datab => inst3_aint_masked_a6_a,
	datac => inst3_aint_pending_c_a6_a,
	datad => inst3_aint_masked_c_a6_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_pending_c_a6_a);

inst3_areduce_nor_128_a23_I : cyclone_lcell 
-- Equation(s):
-- inst3_areduce_nor_128_a23 = inst3_aint_pending_c_a6_a # inst3_aint_pending_c_a4_a # inst3_aint_pending_c_a7_a # inst3_aint_pending_c_a5_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst3_aint_pending_c_a6_a,
	datab => inst3_aint_pending_c_a4_a,
	datac => inst3_aint_pending_c_a7_a,
	datad => inst3_aint_pending_c_a5_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst3_areduce_nor_128_a23);

inst_aI2_aE_x_aint_e_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aE_x_aint_e_a0 = inst_aI2_ai_a352 & inst_aI2_ai_a326 & (inst3_areduce_nor_128_a28 # inst3_areduce_nor_128_a23)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8880",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_ai_a352,
	datab => inst_aI2_ai_a326,
	datac => inst3_areduce_nor_128_a28,
	datad => inst3_areduce_nor_128_a23,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aE_x_aint_e_a0);

inst_aI4_aadd_104_rtl_648_a78_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_rtl_648_a78 = inst_aI4_ai_a20 & (inst_aI4_areduce_nor_103 & inst_aI4_aireg_c_a3_a # !inst_aI4_areduce_nor_103 & inst_aI4_aadd_104_a3) # !inst_aI4_ai_a20 & inst_aI4_aireg_c_a3_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCE4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_ai_a20,
	datab => inst_aI4_aireg_c_a3_a,
	datac => inst_aI4_aadd_104_a3,
	datad => inst_aI4_areduce_nor_103,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_rtl_648_a78);

inst_aI4_aireg_i_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aadd_104_rtl_648_a83 = inst_aI4_aireg_we_c & inst_aI3_aacc_c_a0_a_a3_a # !inst_aI4_aireg_we_c & inst_aI4_ai_a18 & inst_aI4_aadd_104_rtl_648_a78
-- inst_aI4_aireg_i_a3_a = DFFEA(inst_aI4_aadd_104_rtl_648_a83, GLOBAL(UCLK_acombout), VCC, , inst_aI4_aireg_i_a0_a_a6, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CAC0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_ai_a18,
	datab => inst_aI3_aacc_c_a0_a_a3_a,
	datac => inst_aI4_aireg_we_c,
	datad => inst_aI4_aadd_104_rtl_648_a78,
	aclr => GND,
	ena => inst_aI4_aireg_i_a0_a_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_aadd_104_rtl_648_a83,
	regout => inst_aI4_aireg_i_a3_a);

inst_aI4_aireg_c_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI4_aireg_c_a3_a = DFFEA(inst_aI2_aE_x_aint_e_a0 & inst_aI4_aadd_104_rtl_648_a83 # !inst_aI2_aE_x_aint_e_a0 & (inst_aI2_aint_stop_x_a10 & inst_aI4_aireg_i_a3_a # !inst_aI2_aint_stop_x_a10 & inst_aI4_aadd_104_rtl_648_a83), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EF40",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aE_x_aint_e_a0,
	datab => inst_aI4_aireg_i_a3_a,
	datac => inst_aI2_aint_stop_x_a10,
	datad => inst_aI4_aadd_104_rtl_648_a83,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI4_aireg_c_a3_a);

inst_aI5_adaddr_c_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI5_adaddr_c_a3_a = DFFEA(inst_aI4_ai_a18 & (inst6_aaltsyncram_component_aq_a_a7_a # inst_aI4_ai_a133 & inst_aI4_aireg_c_a3_a), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AA80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI4_ai_a18,
	datab => inst_aI4_ai_a133,
	datac => inst_aI4_aireg_c_a3_a,
	datad => inst6_aaltsyncram_component_aq_a_a7_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI5_adaddr_c_a3_a);

inst_aI4_adaddr_x_a3_a_a33_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adaddr_x_a3_a_a33 = nRESET_acombout & inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a & inst6_aaltsyncram_component_aq_a_a7_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => nRESET_acombout,
	datac => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a,
	datad => inst6_aaltsyncram_component_aq_a_a7_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adaddr_x_a3_a_a33);

inst_aI4_adaddr_x_a3_a_a34_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adaddr_x_a3_a_a34 = inst_aI4_aireg_c_a3_a & inst_aI4_ai_a18 & inst_aI4_ai_a20 & !inst_aI4_areduce_nor_103

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI4_aireg_c_a3_a,
	datab => inst_aI4_ai_a18,
	datac => inst_aI4_ai_a20,
	datad => inst_aI4_areduce_nor_103,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adaddr_x_a3_a_a34);

inst_aI5_ai_a21_I : cyclone_lcell 
-- Equation(s):
-- inst_aI5_ai_a21 = inst_aI4_andre_x_a1 & inst_aI5_adaddr_c_a3_a # !inst_aI4_andre_x_a1 & (inst_aI4_adaddr_x_a3_a_a33 # inst_aI4_adaddr_x_a3_a_a34)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFAC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_adaddr_c_a3_a,
	datab => inst_aI4_adaddr_x_a3_a_a33,
	datac => inst_aI4_andre_x_a1,
	datad => inst_aI4_adaddr_x_a3_a_a34,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI5_ai_a21);

inst_aI2_aTC_c_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_areduce_nor_71 = inst_aI2_aTC_c_a0_a # inst_aI2_aTC_c_a2_a # !M1_TC_c[1]
-- inst_aI2_aTC_c_a1_a = DFFEA(inst_aI2_aTC_x_a1_a_a22, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "FFCF",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst_aI2_aTC_c_a0_a,
	datac => inst_aI2_aTC_x_a1_a_a22,
	datad => inst_aI2_aTC_c_a2_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_areduce_nor_71,
	regout => inst_aI2_aTC_c_a1_a);

inst_aI3_adata_x_a7_a_a1618_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a7_a_a1618 = !inst5_amux_c_a2_a & inst_aI3_areduce_nor_71 & inst_aI4_ai_a18 & !inst_aI4_ai_a528

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0040",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_amux_c_a2_a,
	datab => inst_aI3_areduce_nor_71,
	datac => inst_aI4_ai_a18,
	datad => inst_aI4_ai_a528,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a7_a_a1618);

inst8_aDecoder_28_a16_I : cyclone_lcell 
-- Equation(s):
-- inst8_aDecoder_28_a16 = !inst8_arx_bit_count_a3_a & !inst8_arx_bit_count_a1_a & !inst8_arx_bit_count_a2_a & !inst8_arx_bit_count_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0001",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_bit_count_a3_a,
	datab => inst8_arx_bit_count_a1_a,
	datac => inst8_arx_bit_count_a2_a,
	datad => inst8_arx_bit_count_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_aDecoder_28_a16);

inst8_arx_uart_reg_a0_a_a8_I : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a0_a_a8 = inst8_areduce_nor_7 & !inst8_areduce_nor_27 & rtl_a14851 & inst8_aDecoder_28_a16

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_areduce_nor_7,
	datab => inst8_areduce_nor_27,
	datac => rtl_a14851,
	datad => inst8_aDecoder_28_a16,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst8_arx_uart_reg_a0_a_a8);

inst8_arx_uart_reg_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_reg_a0_a = DFFEA(!RXD_acombout, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_arx_uart_reg_a0_a_a8, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => RXD_acombout,
	aclr => NOT_nRESET_acombout,
	ena => inst8_arx_uart_reg_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_reg_a0_a);

inst8_arx_uart_fifo_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst8_arx_uart_fifo_a0_a = DFFEA(!inst8_arx_uart_reg_a0_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst8_arx_uart_fifo_a7_a_a37, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst8_arx_uart_reg_a0_a,
	aclr => NOT_nRESET_acombout,
	ena => inst8_arx_uart_fifo_a7_a_a37,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst8_arx_uart_fifo_a0_a);

inst_aI3_adata_x_a0_a_a577_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a0_a_a577 = inst5_amux_c_a0_a & inst7_aaltsyncram_component_aq_a_a0_a # !inst5_amux_c_a0_a & (inst5_amux_c_a1_a & inst7_aaltsyncram_component_aq_a_a0_a # !inst5_amux_c_a1_a & inst8_arx_uart_fifo_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FE02",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst8_arx_uart_fifo_a0_a,
	datab => inst5_amux_c_a0_a,
	datac => inst5_amux_c_a1_a,
	datad => inst7_aaltsyncram_component_aq_a_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a0_a_a577);

inst_aI3_adata_x_a0_a_a591_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a0_a_a591 = inst5_amux_c_a2_a & inst_aI3_adata_x_a0_a_a577 & inst_aI3_adata_x_a7_a_a1620 & !inst_aI4_ai_a528

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_amux_c_a2_a,
	datab => inst_aI3_adata_x_a0_a_a577,
	datac => inst_aI3_adata_x_a7_a_a1620,
	datad => inst_aI4_ai_a528,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a0_a_a591);

inst_aI2_adata_is_c_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a0_a_a589 = !inst_aI2_aTC_c_a0_a & !inst_aI2_aTC_c_a2_a & M1_data_is_c[0] & inst_aI2_aTC_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "1000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aTC_c_a0_a,
	datab => inst_aI2_aTC_c_a2_a,
	datac => inst6_aaltsyncram_component_aq_a_a4_a,
	datad => inst_aI2_aTC_c_a1_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a0_a_a589);

inst_aI3_adata_x_a0_a_a582_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a0_a_a582 = inst_aI4_aiinc_c_a0_a & (inst_aI4_aireg_c_a0_a # inst_aI4_areduce_nor_106) # !inst_aI4_aiinc_c_a0_a & inst_aI4_aireg_c_a0_a & !inst_aI4_areduce_nor_106

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI4_aiinc_c_a0_a,
	datac => inst_aI4_aireg_c_a0_a,
	datad => inst_aI4_areduce_nor_106,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a0_a_a582);

inst_aI3_adata_x_a0_a_a1910_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a0_a_a1910 = inst_aI3_adata_x_a0_a_a589 # inst_aI3_adata_x_a0_a_a582 & inst_aI3_adata_x_a7_a_a1620 & inst_aI4_ai_a528

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EAAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a0_a_a589,
	datab => inst_aI3_adata_x_a0_a_a582,
	datac => inst_aI3_adata_x_a7_a_a1620,
	datad => inst_aI4_ai_a528,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a0_a_a1910);

PORTA_IN_a0_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTA_IN(0),
	combout => PORTA_IN_a0_a_acombout);

inst10_areg_data_out_c_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a0_a_a112 = K1_reg_data_out_c[0] & (!inst10_ai_a113 # !inst_aI5_ai_a12 # !inst10_ai_a108)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "70F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst10_ai_a108,
	datab => inst_aI5_ai_a12,
	datac => inst10_areg_data_out_x_a0_a_a115,
	datad => inst10_ai_a113,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a0_a_a112);

PORTB_IN_a0_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTB_IN(0),
	combout => PORTB_IN_a0_a_acombout);

inst10_areg_data_out_x_a0_a_a111_I : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a0_a_a111 = PORTB_IN_a0_a_acombout & inst_aI5_ai_a12 & inst10_ai_a108 & inst10_ai_a113

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => PORTB_IN_a0_a_acombout,
	datab => inst_aI5_ai_a12,
	datac => inst10_ai_a108,
	datad => inst10_ai_a113,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a0_a_a111);

inst10_areg_data_out_x_a0_a_a115_I : cyclone_lcell 
-- Equation(s):
-- inst10_areg_data_out_x_a0_a_a115 = inst10_ai_a3 & (inst10_areg_data_out_x_a0_a_a112 # inst10_areg_data_out_x_a0_a_a111) # !inst10_ai_a3 & PORTA_IN_a0_a_acombout

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EEE4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst10_ai_a3,
	datab => PORTA_IN_a0_a_acombout,
	datac => inst10_areg_data_out_x_a0_a_a112,
	datad => inst10_areg_data_out_x_a0_a_a111,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_areg_data_out_x_a0_a_a115);

inst5_aMux_17_rtl_248_a0_I : cyclone_lcell 
-- Equation(s):
-- inst5_aMux_17_rtl_248_a0 = inst5_amux_c_a1_a & (inst5_amux_c_a0_a # inst10_areg_data_out_x_a0_a_a115) # !inst5_amux_c_a1_a & !inst5_amux_c_a0_a & inst7_aaltsyncram_component_aq_a_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DC98",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst5_amux_c_a0_a,
	datab => inst5_amux_c_a1_a,
	datac => inst7_aaltsyncram_component_aq_a_a0_a,
	datad => inst10_areg_data_out_x_a0_a_a115,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aMux_17_rtl_248_a0);

inst5_aMux_17_rtl_248_a1_I : cyclone_lcell 
-- Equation(s):
-- inst5_aMux_17_rtl_248_a1 = inst5_aMux_17_rtl_248_a0 & (inst2_atmr_high_a0_a # !inst5_amux_c_a0_a) # !inst5_aMux_17_rtl_248_a0 & inst3_aint_pending_c_a0_a & inst5_amux_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst2_atmr_high_a0_a,
	datab => inst3_aint_pending_c_a0_a,
	datac => inst5_amux_c_a0_a,
	datad => inst5_aMux_17_rtl_248_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst5_aMux_17_rtl_248_a1);

inst_aI3_adata_x_a0_a_a587_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_adata_x_a0_a_a587 = inst_aI3_adata_x_a0_a_a591 # inst_aI3_adata_x_a0_a_a1910 # inst_aI3_adata_x_a7_a_a1618 & inst5_aMux_17_rtl_248_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FEFC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_adata_x_a7_a_a1618,
	datab => inst_aI3_adata_x_a0_a_a591,
	datac => inst_aI3_adata_x_a0_a_a1910,
	datad => inst5_aMux_17_rtl_248_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_adata_x_a0_a_a587);

rtl_a2477_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2477 = inst_aI3_adata_x_a0_a_a587 & !inst_aI2_aTD_c_a0_a & (inst_aI2_aTC_c_a0_a $ inst_aI2_aTC_c_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0060",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_c_a0_a,
	datab => inst_aI2_aTC_c_a1_a,
	datac => inst_aI3_adata_x_a0_a_a587,
	datad => inst_aI2_aTD_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2477);

rtl_a2479_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2479 = !inst_aI3_aMux_201_rtl_95_a0 & inst_aI3_aacc_c_a0_a_a1_a & (inst_aI2_aTD_c_a2_a $ !inst_aI2_aTD_c_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2010",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI3_aMux_201_rtl_95_a0,
	datac => inst_aI3_aacc_c_a0_a_a1_a,
	datad => inst_aI2_aTD_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2479);

rtl_a15451_I : cyclone_lcell 
-- Equation(s):
-- rtl_a15451 = rtl_a2479 # inst_aI3_aMux_201_rtl_95_a0 & inst_aI2_aTD_c_a0_a & inst_aI3_aadd_129_a0

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ECCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aMux_201_rtl_95_a0,
	datab => rtl_a2479,
	datac => inst_aI2_aTD_c_a0_a,
	datad => inst_aI3_aadd_129_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a15451);

rtl_a2483_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2483 = !inst_aI2_aTD_c_a2_a & inst_aI2_aTD_c_a1_a & (rtl_a2477 # rtl_a15451)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4440",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI2_aTD_c_a1_a,
	datac => rtl_a2477,
	datad => rtl_a15451,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2483);

rtl_a1956_I : cyclone_lcell 
-- Equation(s):
-- rtl_a1956 = inst_aI3_aacc_c_a0_a_a0_a & !inst_aI2_aTD_c_a2_a & inst_aI3_aMux_201_rtl_95_a0 & !inst_aI2_aTD_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0020",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a0_a,
	datab => inst_aI2_aTD_c_a2_a,
	datac => inst_aI3_aMux_201_rtl_95_a0,
	datad => inst_aI2_aTD_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1956);

rtl_a3454_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3454 = inst_aI2_aTD_c_a0_a & inst_aI3_aacc_c_a0_a_a8_a & !inst_aI2_aTD_c_a2_a # !inst_aI2_aTD_c_a0_a & inst_aI3_aacc_c_a0_a_a1_a & inst_aI2_aTD_c_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3088",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a8_a,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_aacc_c_a0_a_a1_a,
	datad => inst_aI2_aTD_c_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3454);

rtl_a3342_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3342 = inst_aI3_aacc_c_a0_a_a0_a & (inst_aI2_aTD_c_a0_a $ !inst_aI2_aTD_c_a2_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C030",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_aacc_c_a0_a_a0_a,
	datad => inst_aI2_aTD_c_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3342);

rtl_a3459_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3459 = inst_aI2_aTD_c_a2_a & inst_aI2_aTD_c_a0_a & !inst_aI3_aacc_c_a0_a_a0_a & inst_aI2_aTD_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a2_a,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_aacc_c_a0_a_a0_a,
	datad => inst_aI2_aTD_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3459);

rtl_a3458_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3458 = rtl_a3459 # !inst_aI2_aTD_c_a1_a & (rtl_a3454 # rtl_a3342)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0FE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a3454,
	datab => rtl_a3342,
	datac => rtl_a3459,
	datad => inst_aI2_aTD_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3458);

rtl_a3464_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3464 = rtl_a3458 & (inst_aI2_aTC_c_a0_a $ !inst_aI2_aTC_c_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A500",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_c_a0_a,
	datac => inst_aI2_aTC_c_a1_a,
	datad => rtl_a3458,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3464);

inst_aI3_aMux_178_rtl_85_rtl_552_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aMux_178_rtl_85_rtl_552_a0 = inst_aI2_aTD_c_a1_a & (inst_aI2_aTD_c_a0_a # inst_aI3_aadd_153_a1) # !inst_aI2_aTD_c_a1_a & !inst_aI2_aTD_c_a0_a & inst_aI3_aadd_129_a0

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DC98",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI2_aTD_c_a1_a,
	datac => inst_aI3_aadd_129_a0,
	datad => inst_aI3_aadd_153_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_178_rtl_85_rtl_552_a0);

inst_aI3_aMux_178_rtl_85_rtl_552_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aMux_178_rtl_85_rtl_552_a1 = inst_aI3_aacc_c_a0_a_a0_a & (inst_aI3_aMux_178_rtl_85_rtl_552_a0 # inst_aI2_aTD_c_a0_a & inst_aI3_adata_x_a0_a_a587) # !inst_aI3_aacc_c_a0_a_a0_a & inst_aI3_aMux_178_rtl_85_rtl_552_a0 & (inst_aI3_adata_x_a0_a_a587 # !inst_aI2_aTD_c_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FD80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => inst_aI3_aacc_c_a0_a_a0_a,
	datac => inst_aI3_adata_x_a0_a_a587,
	datad => inst_aI3_aMux_178_rtl_85_rtl_552_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_178_rtl_85_rtl_552_a1);

rtl_a15483_I : cyclone_lcell 
-- Equation(s):
-- rtl_a15483 = rtl_a1956 # rtl_a3464 # rtl_a14854 & inst_aI3_aMux_178_rtl_85_rtl_552_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FEFA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a1956,
	datab => rtl_a14854,
	datac => rtl_a3464,
	datad => inst_aI3_aMux_178_rtl_85_rtl_552_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a15483);

inst_aI3_aacc_c_a0_a_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a0_a_a138 = inst_aI3_aacc_a0_a_a0_a_a4288 # inst_aI3_aacc_a0_a_a7_a_a4226 & (rtl_a2483 # rtl_a15483)
-- inst_aI3_aacc_c_a0_a_a0_a = DFFEA(inst_aI3_aacc_a0_a_a0_a_a138, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EEEA",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_a0_a_a0_a_a4288,
	datab => inst_aI3_aacc_a0_a_a7_a_a4226,
	datac => rtl_a2483,
	datad => rtl_a15483,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a0_a_a138,
	regout => inst_aI3_aacc_c_a0_a_a0_a);

inst_aI3_aacc_i_a0_a_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a0_a_a4288 = inst_aI3_aacc_a0_a_a7_a_a4227 & (N1_acc_i[0][0] # inst_aI3_aacc_c_a0_a_a0_a & inst_aI3_aacc_a0_a_a8_a_a63) # !inst_aI3_aacc_a0_a_a7_a_a4227 & inst_aI3_aacc_c_a0_a_a0_a & inst_aI3_aacc_a0_a_a8_a_a63

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "ECA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_a0_a_a7_a_a4227,
	datab => inst_aI3_aacc_c_a0_a_a0_a,
	datac => inst_aI3_aacc_a0_a_a0_a_a138,
	datad => inst_aI3_aacc_a0_a_a8_a_a63,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst_aI2_aint_start_c,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a0_a_a4288);

inst10_aout_0reg_a0_a_areg0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adata_ox_a0_a_a7 = nRESET_acombout & inst_aI3_aacc_c_a0_a_a0_a & inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a
-- inst10_aout_0reg_a0_a_areg0 = DFFEA(inst_aI4_adata_ox_a0_a_a7, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst10_ai_a1, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8080",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => nRESET_acombout,
	datab => inst_aI3_aacc_c_a0_a_a0_a,
	datac => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a,
	aclr => NOT_nRESET_acombout,
	ena => inst10_ai_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adata_ox_a0_a_a7,
	regout => inst10_aout_0reg_a0_a_areg0);

inst3_aint_mask_c_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_mask_c_a0_a = DFFEA(inst_aI4_adata_ox_a0_a_a7, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst3_ai_a1, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a0_a_a7,
	aclr => NOT_nRESET_acombout,
	ena => inst3_ai_a1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_mask_c_a0_a);

IN_INT_a0_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_IN_INT(0),
	combout => IN_INT_a0_a_acombout);

inst3_aint_masked_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_masked_a0_a = DFFEA(inst3_aint_mask_c_a0_a & IN_INT_a0_a_acombout, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AA00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst3_aint_mask_c_a0_a,
	datad => IN_INT_a0_a_acombout,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_masked_a0_a);

inst3_aint_clr_c_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_clr_c_a0_a = DFFEA(inst_aI4_adata_ox_a0_a_a7, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst3_ai_a121, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a0_a_a7,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst3_ai_a121,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_clr_c_a0_a);

inst3_aint_masked_c_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_masked_c_a0_a = DFFEA(inst3_aint_masked_a0_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst3_aint_masked_a0_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_masked_c_a0_a);

inst3_aint_pending_c_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst3_aint_pending_c_a0_a = DFFEA(!inst3_aint_clr_c_a0_a & (inst3_aint_pending_c_a0_a # inst3_aint_masked_a0_a & !inst3_aint_masked_c_a0_a), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0A0E",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst3_aint_pending_c_a0_a,
	datab => inst3_aint_masked_a0_a,
	datac => inst3_aint_clr_c_a0_a,
	datad => inst3_aint_masked_c_a0_a,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst3_aint_pending_c_a0_a);

inst3_areduce_nor_128_a28_I : cyclone_lcell 
-- Equation(s):
-- inst3_areduce_nor_128_a28 = inst3_aint_pending_c_a0_a # inst3_aint_pending_c_a2_a # inst3_aint_pending_c_a3_a # inst3_aint_pending_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst3_aint_pending_c_a0_a,
	datab => inst3_aint_pending_c_a2_a,
	datac => inst3_aint_pending_c_a3_a,
	datad => inst3_aint_pending_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst3_areduce_nor_128_a28);

inst_aI2_aint_start_c_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aint_start_c = DFFEA(inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a & inst_aI2_ai_a352 & (inst3_areduce_nor_128_a28 # inst3_areduce_nor_128_a23), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst3_areduce_nor_128_a28,
	datab => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a,
	datac => inst_aI2_ai_a352,
	datad => inst3_areduce_nor_128_a23,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_aint_start_c);

inst_aI2_aTC_c_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- rtl_a14960 = inst_aI2_aTD_c_a3_a & !inst_aI2_aTC_c_a0_a & !M1_TC_c[2] & !inst_aI2_aTC_c_a1_a
-- inst_aI2_aTC_c_a2_a = DFFEA(inst_aI2_aTC_x_a2_a_a112, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "0002",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aTD_c_a3_a,
	datab => inst_aI2_aTC_c_a0_a,
	datac => inst_aI2_aTC_x_a2_a_a112,
	datad => inst_aI2_aTC_c_a1_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a14960,
	regout => inst_aI2_aTC_c_a2_a);

rtl_a14987_I : cyclone_lcell 
-- Equation(s):
-- rtl_a14987 = !inst_aI2_aTD_c_a0_a & rtl_a14960 & !inst_aI2_aTD_c_a2_a & inst_aI2_aTD_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => rtl_a14960,
	datac => inst_aI2_aTD_c_a2_a,
	datad => inst_aI2_aTD_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a14987);

rtl_a15003_I : cyclone_lcell 
-- Equation(s):
-- rtl_a15003 = !inst_aI2_aTD_c_a0_a & rtl_a14960 & !inst_aI2_aTD_c_a2_a & !inst_aI2_aTD_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0004",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a0_a,
	datab => rtl_a14960,
	datac => inst_aI2_aTD_c_a2_a,
	datad => inst_aI2_aTD_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a15003);

inst_aI3_areduce_nor_91_a35_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_areduce_nor_91_a35 = inst_aI3_aacc_c_a0_a_a7_a # inst_aI3_aacc_c_a0_a_a6_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI3_aacc_c_a0_a_a7_a,
	datad => inst_aI3_aacc_c_a0_a_a6_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_areduce_nor_91_a35);

inst_aI3_areduce_nor_91_a28_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_areduce_nor_91_a28 = inst_aI3_aacc_c_a0_a_a0_a # inst_aI3_aacc_c_a0_a_a3_a # inst_aI3_aacc_c_a0_a_a2_a # inst_aI3_aacc_c_a0_a_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a0_a,
	datab => inst_aI3_aacc_c_a0_a_a3_a,
	datac => inst_aI3_aacc_c_a0_a_a2_a,
	datad => inst_aI3_aacc_c_a0_a_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_areduce_nor_91_a28);

inst_aI3_areduce_nor_91_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_areduce_nor_91 = inst_aI3_aacc_c_a0_a_a4_a # inst_aI3_aacc_c_a0_a_a5_a # inst_aI3_areduce_nor_91_a35 # inst_aI3_areduce_nor_91_a28

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a4_a,
	datab => inst_aI3_aacc_c_a0_a_a5_a,
	datac => inst_aI3_areduce_nor_91_a35,
	datad => inst_aI3_areduce_nor_91_a28,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_areduce_nor_91);

rtl_a14972_I : cyclone_lcell 
-- Equation(s):
-- rtl_a14972 = inst_aI3_aacc_c_a0_a_a8_a & inst_aI2_aTD_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AA00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a8_a,
	datad => inst_aI2_aTD_c_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a14972);

rtl_a2261_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2261 = !inst_aI2_aTD_c_a1_a & rtl_a14960 & !inst_aI2_aTD_c_a2_a & rtl_a14972

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a1_a,
	datab => rtl_a14960,
	datac => inst_aI2_aTD_c_a2_a,
	datad => rtl_a14972,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2261);

rtl_a15027_I : cyclone_lcell 
-- Equation(s):
-- rtl_a15027 = rtl_a2261 # inst_aI3_areduce_nor_91 & rtl_a14987 # !inst_aI3_areduce_nor_91 & rtl_a15003

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFAC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a14987,
	datab => rtl_a15003,
	datac => inst_aI3_areduce_nor_91,
	datad => rtl_a2261,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a15027);

inst_aI3_askip_i_aI : cyclone_lcell 
-- Equation(s):
-- rtl_a1444 = !inst_aI2_aTC_c_a1_a & inst_aI2_aTC_c_a2_a & N1_skip_i & !inst_aI2_aTC_c_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "0040",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aTC_c_a1_a,
	datab => inst_aI2_aTC_c_a2_a,
	datac => inst_aI3_ai_a213,
	datad => inst_aI2_aTC_c_a0_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst_aI2_aint_start_c,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1444);

rtl_a14994_I : cyclone_lcell 
-- Equation(s):
-- rtl_a14994 = !inst_aI3_aacc_c_a0_a_a8_a & !inst_aI2_aTD_c_a0_a & inst_aI2_aTD_c_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0300",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI3_aacc_c_a0_a_a8_a,
	datac => inst_aI2_aTD_c_a0_a,
	datad => inst_aI2_aTD_c_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a14994);

rtl_a15020_I : cyclone_lcell 
-- Equation(s):
-- rtl_a15020 = rtl_a1444 # !inst_aI2_aTD_c_a1_a & rtl_a14960 & rtl_a14994

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F4F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a1_a,
	datab => rtl_a14960,
	datac => rtl_a1444,
	datad => rtl_a14994,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a15020);

inst_aI3_ai_a213_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_ai_a213 = inst_aI3_ai_a224 & inst_aI3_ai_a212 & (rtl_a15027 # rtl_a15020)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8880",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_ai_a224,
	datab => inst_aI3_ai_a212,
	datac => rtl_a15027,
	datad => rtl_a15020,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_ai_a213);

inst_aI2_apc_mux_x_a1_a_a170_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_apc_mux_x_a1_a_a170 = inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a & nRESET_acombout & (inst_aI2_aint_start_c # !inst_aI3_ai_a213)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "80A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a,
	datab => inst_aI2_aint_start_c,
	datac => nRESET_acombout,
	datad => inst_aI3_ai_a213,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_apc_mux_x_a1_a_a170);

inst_aI2_apc_mux_x_a1_a_a204_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_apc_mux_x_a1_a_a204 = inst_aI2_aTC_x_a1_a_a22 & inst_aI2_aTC_x_a2_a_a112 & (!inst_aI2_aTC_x_a0_a_a119 # !inst_aI2_aE_x_aint_e_a0)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "20A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_x_a1_a_a22,
	datab => inst_aI2_aE_x_aint_e_a0,
	datac => inst_aI2_aTC_x_a2_a_a112,
	datad => inst_aI2_aTC_x_a0_a_a119,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_apc_mux_x_a1_a_a204);

inst_aI2_apc_mux_x_a1_a_a169_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_apc_mux_x_a1_a_a169 = inst_aI2_aTC_x_a2_a_a112 & !inst_aI2_aTC_x_a1_a_a42 & (!inst6_aaltsyncram_component_aq_a_a3_a # !nRESET_acombout)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0222",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_x_a2_a_a112,
	datab => inst_aI2_aTC_x_a1_a_a42,
	datac => nRESET_acombout,
	datad => inst6_aaltsyncram_component_aq_a_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_apc_mux_x_a1_a_a169);

inst_aI2_apc_mux_x_a1_a_a199_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_apc_mux_x_a1_a_a199 = inst_aI2_aTC_x_a0_a_a119 & (!inst3_areduce_nor_128_a23 & !inst3_areduce_nor_128_a28 # !inst_aI2_ai_a352)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "1F00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst3_areduce_nor_128_a23,
	datab => inst3_areduce_nor_128_a28,
	datac => inst_aI2_ai_a352,
	datad => inst_aI2_aTC_x_a0_a_a119,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_apc_mux_x_a1_a_a199);

inst_aI2_aS_c_a10_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aS_c_a10 = DFFEA(inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a & (inst_aI2_aE_x_aint_e_a0 # inst_aI2_aS_c_a10 & !inst_aI2_aint_stop_x_a10), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "88C8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aE_x_aint_e_a0,
	datab => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a,
	datac => inst_aI2_aS_c_a10,
	datad => inst_aI2_aint_stop_x_a10,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_aS_c_a10);

inst_aI2_ai_a364_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_ai_a364 = inst_aI2_aS_c_a10 & !inst_aI2_aTC_x_a0_a_a119

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst_aI2_aS_c_a10,
	datad => inst_aI2_aTC_x_a0_a_a119,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_ai_a364);

inst_aI2_apc_mux_x_a1_a_a30_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_apc_mux_x_a1_a_a30 = inst_aI2_apc_mux_x_a1_a_a169 & (inst_aI2_apc_mux_x_a1_a_a199 # !inst_aI3_ai_a85 & inst_aI2_ai_a364)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C4C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_ai_a85,
	datab => inst_aI2_apc_mux_x_a1_a_a169,
	datac => inst_aI2_apc_mux_x_a1_a_a199,
	datad => inst_aI2_ai_a364,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_apc_mux_x_a1_a_a30);

inst_aI2_apc_mux_x_a1_a_a42_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_apc_mux_x_a1_a_a42 = inst_aI2_apc_mux_x_a1_a_a170 & (inst_aI2_apc_mux_x_a1_a_a204 # inst_aI2_areduce_nor_126 & inst_aI2_apc_mux_x_a1_a_a30)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A8A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_apc_mux_x_a1_a_a170,
	datab => inst_aI2_areduce_nor_126,
	datac => inst_aI2_apc_mux_x_a1_a_a204,
	datad => inst_aI2_apc_mux_x_a1_a_a30,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_apc_mux_x_a1_a_a42);

inst_aI1_aiaddr_x_a2_a_a102_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a2_a_a102 = inst6_aaltsyncram_component_aq_a_a6_a & inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst6_aaltsyncram_component_aq_a_a6_a,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a2_a_a102);

inst_aI1_aiaddr_x_a2_a_a223_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a2_a_a223 = !inst_aI2_apc_mux_x_a1_a_a42 & (inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a2 # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_apc_a2_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00CA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_apc_a2_a,
	datab => inst_aI1_aadd_185_a2,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a2_a_a223);

rtl_a2509_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2509 = inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_aadd_185_a2 # !inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_astack_addrs_c_a0_a_a2_a) # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_astack_addrs_c_a0_a_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a0_a_a2_a,
	datab => inst_aI2_apc_mux_x_a0_a_a8,
	datac => inst_aI1_aadd_185_a2,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2509);

inst_aI1_astack_addrs_c_a7_a_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a7_a_a2_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a6_a_a2_a & !inst_aI1_aMux_197_rtl_141_a0 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a6_a_a2_a # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a7_a_a2_a), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "22B8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a6_a_a2_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_astack_addrs_c_a7_a_a2_a,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a7_a_a2_a);

rtl_a3165_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3165 = inst_aI1_astack_addrs_c_a6_a_a2_a & (inst_aI1_astack_addrs_c_a7_a_a2_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a6_a_a2_a & inst_aI1_astack_addrs_c_a7_a_a2_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a6_a_a2_a,
	datac => inst_aI1_astack_addrs_c_a7_a_a2_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3165);

inst_aI1_astack_addrs_c_a6_a_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a6_a_a2_a = DFFEA(inst_aI1_astack_addrs_c_a5_a_a2_a & (rtl_a3165 # inst_aI1_aMux_197_rtl_141_a0 $ inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a5_a_a2_a & rtl_a3165 & (inst_aI1_aMux_197_rtl_141_a0 $ !inst_aI2_apc_mux_x_a2_a_a27), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a5_a_a2_a,
	datab => inst_aI1_aMux_197_rtl_141_a0,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => rtl_a3165,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a6_a_a2_a);

rtl_a3065_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3065 = inst_aI1_astack_addrs_c_a6_a_a2_a & (inst_aI1_astack_addrs_c_a5_a_a2_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a6_a_a2_a & inst_aI1_astack_addrs_c_a5_a_a2_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a6_a_a2_a,
	datac => inst_aI1_astack_addrs_c_a5_a_a2_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3065);

inst_aI1_astack_addrs_c_a5_a_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a5_a_a2_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a3065 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a4_a_a2_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a4_a_a2_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a3065), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a4_a_a2_a,
	datac => rtl_a3065,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a5_a_a2_a);

rtl_a2965_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2965 = inst_aI1_astack_addrs_c_a4_a_a2_a & (inst_aI1_astack_addrs_c_a5_a_a2_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a4_a_a2_a & inst_aI1_astack_addrs_c_a5_a_a2_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a4_a_a2_a,
	datac => inst_aI1_astack_addrs_c_a5_a_a2_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2965);

inst_aI1_astack_addrs_c_a4_a_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a4_a_a2_a = DFFEA(inst_aI1_astack_addrs_c_a3_a_a2_a & (rtl_a2965 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a3_a_a2_a & rtl_a2965 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CAAC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a3_a_a2_a,
	datab => rtl_a2965,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a4_a_a2_a);

rtl_a2865_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2865 = inst_aI1_astack_addrs_c_a3_a_a2_a & (inst_aI1_astack_addrs_c_a4_a_a2_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a3_a_a2_a & inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a4_a_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FA0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a3_a_a2_a,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => inst_aI1_astack_addrs_c_a4_a_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2865);

inst_aI1_astack_addrs_c_a3_a_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a2_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a2865 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a2_a_a2_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a2_a_a2_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a2865), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a2_a_a2_a,
	datac => rtl_a2865,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a2_a);

rtl_a2765_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2765 = inst_aI1_astack_addrs_c_a3_a_a2_a & (inst_aI1_astack_addrs_c_a2_a_a2_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a3_a_a2_a & inst_aI1_astack_addrs_c_a2_a_a2_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a3_a_a2_a,
	datac => inst_aI1_astack_addrs_c_a2_a_a2_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2765);

inst_aI1_astack_addrs_c_a2_a_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a2_a = DFFEA(inst_aI1_astack_addrs_c_a1_a_a2_a & (rtl_a2765 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a1_a_a2_a & rtl_a2765 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2B8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a1_a_a2_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a2765,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a2_a);

rtl_a2625_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2625 = inst_aI1_astack_addrs_c_a2_a_a2_a & (inst_aI1_astack_addrs_c_a1_a_a2_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a2_a_a2_a & inst_aI1_astack_addrs_c_a1_a_a2_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a2_a_a2_a,
	datac => inst_aI1_astack_addrs_c_a1_a_a2_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2625);

inst_aI1_astack_addrs_c_a1_a_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a2_a = DFFEA(inst_aI1_astack_addrs_c_a0_a_a2_a & (rtl_a2625 # inst_aI1_aMux_197_rtl_141_a0 $ inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a0_a_a2_a & rtl_a2625 & (inst_aI1_aMux_197_rtl_141_a0 $ !inst_aI2_apc_mux_x_a2_a_a27), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a0_a_a2_a,
	datab => inst_aI1_aMux_197_rtl_141_a0,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => rtl_a2625,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a2_a);

rtl_a938 : cyclone_lcell 
-- Equation(s):
-- rtl_a445 = LCELL(inst_aI2_apc_mux_x_a0_a_a8 & rtl_a445 # !inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI1_aMux_287_a32 & inst6_aaltsyncram_component_aq_a_a6_a # !inst_aI1_aMux_287_a32 & rtl_a445))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ACAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a445,
	datab => inst6_aaltsyncram_component_aq_a_a6_a,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI1_aMux_287_a32,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a445);

inst_aI1_aMux_275_rtl_204_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_275_rtl_204_a0 = inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI1_apc_a2_a # inst_aI2_apc_mux_x_a1_a_a42) # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a2 & !inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0AC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_apc_a2_a,
	datab => inst_aI1_aadd_185_a2,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_275_rtl_204_a0);

inst_aI1_aMux_275_rtl_204_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_275_rtl_204_a1 = inst_aI1_aMux_275_rtl_204_a0 & (inst_aI1_astack_addrs_c_a1_a_a2_a # !inst_aI2_apc_mux_x_a1_a_a42) # !inst_aI1_aMux_275_rtl_204_a0 & inst_aI2_apc_mux_x_a1_a_a42 & rtl_a445

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BBC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a1_a_a2_a,
	datab => inst_aI2_apc_mux_x_a1_a_a42,
	datac => rtl_a445,
	datad => inst_aI1_aMux_275_rtl_204_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_275_rtl_204_a1);

inst_aI1_astack_addrs_c_a0_a_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a2_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_aMux_275_rtl_204_a1 # !inst_aI2_apc_mux_x_a2_a_a27 & rtl_a2509, GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FC30",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a2509,
	datad => inst_aI1_aMux_275_rtl_204_a1,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a2_a);

inst_aI1_aiaddr_x_a2_a_a228_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a2_a_a228 = inst_aI1_astack_addrs_c_a0_a_a2_a & inst_aI2_apc_mux_x_a2_a_a27 & inst_aI2_apc_mux_x_a0_a_a8 & inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a0_a_a2_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a2_a_a228);

inst_aI1_aiaddr_x_a2_a_a227_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a2_a_a227 = inst_aI1_aiaddr_x_a2_a_a228 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aiaddr_x_a2_a_a102 # inst_aI1_aiaddr_x_a2_a_a223)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF32",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_aiaddr_x_a2_a_a102,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aiaddr_x_a2_a_a223,
	datad => inst_aI1_aiaddr_x_a2_a_a228,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a2_a_a227);

inst6_aaltsyncram_component_aram_block_a0_a_a0_a : cyclone_ram_block 
-- pragma translate_off
GENERIC MAP (
	mem4 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem3 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000100000000001000000010000001000100000001000000010001000000010001000000010001000000010001000000000100000010000001000000001000000000000000000000",
	mem2 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010101010001000101010101010000100010101010000101010001010101110001010101110001010101110001010101110001010010101001010100000110010101010010101010110101010110",
	operation_mode => "rom",
	ram_block_type => "auto",
	logical_ram_name => "lpm_rom0:inst6|altsyncram:altsyncram_component|ALTSYNCRAM INSTANTIATION",
	init_file => "../rom.mif",
	init_file_layout => "port_a",
	data_interleave_width_in_bits => 1,
	data_interleave_offset_in_bits => 1,
	port_a_write_enable_clock => "none",
	port_a_byte_enable_clock => "none",
	port_a_logical_ram_depth => 1024,
	port_a_logical_ram_width => 14,
	port_a_data_in_clear => "none",
	port_a_address_clear => "none",
	port_a_write_enable_clear => "none",
	port_a_byte_enable_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_out_clear => "none",
	port_a_first_address => 0,
	port_a_last_address => 1023,
	port_a_first_bit_number => 0,
	port_a_data_width => 2,
	port_a_address_width => 10)
-- pragma translate_on
PORT MAP (
	clk0 => UCLK_acombout,
	ena0 => VCC,
	portaaddr => ww_inst6_aaltsyncram_component_aram_block_a0_a_a0_a_aaddress,
	devclrn => devclrn,
	devpor => devpor,
	portadataout => ww_inst6_aaltsyncram_component_aram_block_a0_a_a0_a_adataout);

inst_aI2_aTC_x_a1_a_a22_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aTC_x_a1_a_a22 = nRESET_acombout & (inst6_aaltsyncram_component_aq_a_a3_a # inst6_aaltsyncram_component_aq_a_a0_a & inst_aI2_aTD_x_a3_a_a9)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_aaltsyncram_component_aq_a_a0_a,
	datab => inst_aI2_aTD_x_a3_a_a9,
	datac => inst6_aaltsyncram_component_aq_a_a3_a,
	datad => nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aTC_x_a1_a_a22);

inst_aI2_areduce_nor_126_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI2_areduce_nor_126 = !inst_aI2_aTC_x_a0_a_a119 # !inst_aI2_aTC_x_a2_a_a112 # !inst_aI2_aTC_x_a1_a_a22

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5FFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_x_a1_a_a22,
	datac => inst_aI2_aTC_x_a2_a_a112,
	datad => inst_aI2_aTC_x_a0_a_a119,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_areduce_nor_126);

inst_aI2_ai_a43_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_ai_a43 = !inst_aI3_ai_a85 & inst_aI2_apc_mux_x_a1_a_a169 & (inst_aI2_aS_c_a10 # inst_aI2_aTC_x_a0_a_a119)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3020",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aS_c_a10,
	datab => inst_aI3_ai_a85,
	datac => inst_aI2_apc_mux_x_a1_a_a169,
	datad => inst_aI2_aTC_x_a0_a_a119,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_ai_a43);

inst_aI2_ai_a379_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_ai_a379 = inst_aI2_ai_a43 # inst_aI2_ai_a13 $ (inst_aI2_ai_a342 # inst_aI2_aC_mem_x_a0)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF36",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_ai_a342,
	datab => inst_aI2_ai_a13,
	datac => inst_aI2_aC_mem_x_a0,
	datad => inst_aI2_ai_a43,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_ai_a379);

inst_aI2_ai_a328_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_ai_a328 = !inst_aI3_ai_a85 & (inst_aI2_aTC_x_a0_a_a119 # !inst_aI2_aTC_x_a1_a_a22 # !inst_aI2_aTC_x_a2_a_a112)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0D0F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_x_a2_a_a112,
	datab => inst_aI2_aTC_x_a0_a_a119,
	datac => inst_aI3_ai_a85,
	datad => inst_aI2_aTC_x_a1_a_a22,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_ai_a328);

inst_aI2_apc_mux_x_a0_a_a8_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_apc_mux_x_a0_a_a8 = inst_aI2_apc_mux_x_a0_a_a214 # inst_aI2_ai_a328 & (inst_aI2_ai_a379 # !inst_aI2_areduce_nor_126)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FBAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_apc_mux_x_a0_a_a214,
	datab => inst_aI2_areduce_nor_126,
	datac => inst_aI2_ai_a379,
	datad => inst_aI2_ai_a328,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_apc_mux_x_a0_a_a8);

inst_aI1_aiaddr_x_a1_a_a206_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a1_a_a206 = !inst_aI2_apc_mux_x_a1_a_a42 & (inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a1 # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_apc_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00CA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_apc_a1_a,
	datab => inst_aI1_aadd_185_a1,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a1_a_a206);

inst_aI1_aiaddr_x_a1_a_a90_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a1_a_a90 = inst6_aaltsyncram_component_aq_a_a5_a & inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst6_aaltsyncram_component_aq_a_a5_a,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a1_a_a90);

rtl_a2499_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2499 = inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_aadd_185_a1 # !inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_astack_addrs_c_a0_a_a1_a) # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_astack_addrs_c_a0_a_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CAAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a0_a_a1_a,
	datab => inst_aI1_aadd_185_a1,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2499);

inst_aI1_astack_addrs_c_a7_a_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a7_a_a1_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a6_a_a1_a & !inst_aI1_aMux_197_rtl_141_a0 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a6_a_a1_a # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a7_a_a1_a), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0CCA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a7_a_a1_a,
	datab => inst_aI1_astack_addrs_c_a6_a_a1_a,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a7_a_a1_a);

rtl_a3155_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3155 = inst_aI1_astack_addrs_c_a6_a_a1_a & (inst_aI1_astack_addrs_c_a7_a_a1_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a6_a_a1_a & inst_aI1_astack_addrs_c_a7_a_a1_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a6_a_a1_a,
	datac => inst_aI1_astack_addrs_c_a7_a_a1_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3155);

inst_aI1_astack_addrs_c_a6_a_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a6_a_a1_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a3155 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a5_a_a1_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a5_a_a1_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a3155), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a5_a_a1_a,
	datac => rtl_a3155,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a6_a_a1_a);

rtl_a3055_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3055 = inst_aI1_astack_addrs_c_a5_a_a1_a & (inst_aI1_astack_addrs_c_a6_a_a1_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a5_a_a1_a & inst_aI1_astack_addrs_c_a6_a_a1_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a5_a_a1_a,
	datac => inst_aI1_astack_addrs_c_a6_a_a1_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3055);

inst_aI1_astack_addrs_c_a5_a_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a5_a_a1_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a3055 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a4_a_a1_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a4_a_a1_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a3055), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ED48",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a4_a_a1_a,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a3055,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a5_a_a1_a);

rtl_a2955_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2955 = inst_aI1_astack_addrs_c_a4_a_a1_a & (inst_aI1_astack_addrs_c_a5_a_a1_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a4_a_a1_a & inst_aI1_astack_addrs_c_a5_a_a1_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a4_a_a1_a,
	datac => inst_aI1_astack_addrs_c_a5_a_a1_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2955);

inst_aI1_astack_addrs_c_a4_a_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a4_a_a1_a = DFFEA(inst_aI1_astack_addrs_c_a3_a_a1_a & (rtl_a2955 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a3_a_a1_a & rtl_a2955 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a3_a_a1_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a2955,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a4_a_a1_a);

rtl_a2855_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2855 = inst_aI1_astack_addrs_c_a4_a_a1_a & (inst_aI1_astack_addrs_c_a3_a_a1_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a4_a_a1_a & inst_aI1_astack_addrs_c_a3_a_a1_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a4_a_a1_a,
	datac => inst_aI1_astack_addrs_c_a3_a_a1_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2855);

inst_aI1_astack_addrs_c_a3_a_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a1_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a2855 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a2_a_a1_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a2_a_a1_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a2855), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ED48",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a2_a_a1_a,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a2855,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a1_a);

rtl_a2755_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2755 = inst_aI1_astack_addrs_c_a2_a_a1_a & (inst_aI1_astack_addrs_c_a3_a_a1_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a2_a_a1_a & inst_aI1_astack_addrs_c_a3_a_a1_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a2_a_a1_a,
	datac => inst_aI1_astack_addrs_c_a3_a_a1_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2755);

inst_aI1_astack_addrs_c_a2_a_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a1_a = DFFEA(inst_aI1_astack_addrs_c_a1_a_a1_a & (rtl_a2755 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a1_a_a1_a & rtl_a2755 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a1_a_a1_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a2755,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a1_a);

rtl_a2615_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2615 = inst_aI1_astack_addrs_c_a2_a_a1_a & (inst_aI1_astack_addrs_c_a1_a_a1_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a2_a_a1_a & inst_aI1_astack_addrs_c_a1_a_a1_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a2_a_a1_a,
	datac => inst_aI1_astack_addrs_c_a1_a_a1_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2615);

inst_aI1_astack_addrs_c_a1_a_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a1_a = DFFEA(inst_aI1_astack_addrs_c_a0_a_a1_a & (rtl_a2615 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a0_a_a1_a & rtl_a2615 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB28",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a0_a_a1_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a2615,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a1_a);

rtl_a929 : cyclone_lcell 
-- Equation(s):
-- rtl_a444 = LCELL(inst_aI2_apc_mux_x_a0_a_a8 & rtl_a444 # !inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI1_aMux_287_a32 & inst6_aaltsyncram_component_aq_a_a5_a # !inst_aI1_aMux_287_a32 & rtl_a444))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ACAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a444,
	datab => inst6_aaltsyncram_component_aq_a_a5_a,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI1_aMux_287_a32,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a444);

inst_aI1_aMux_276_rtl_201_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_276_rtl_201_a0 = inst_aI2_apc_mux_x_a1_a_a42 & (inst_aI2_apc_mux_x_a0_a_a8 # rtl_a444) # !inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_aadd_185_a1 & !inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AEA4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_apc_mux_x_a1_a_a42,
	datab => inst_aI1_aadd_185_a1,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => rtl_a444,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_276_rtl_201_a0);

inst_aI1_aMux_276_rtl_201_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_276_rtl_201_a1 = inst_aI1_aMux_276_rtl_201_a0 & (inst_aI1_astack_addrs_c_a1_a_a1_a # !inst_aI2_apc_mux_x_a0_a_a8) # !inst_aI1_aMux_276_rtl_201_a0 & inst_aI1_apc_a1_a & inst_aI2_apc_mux_x_a0_a_a8

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a1_a_a1_a,
	datab => inst_aI1_apc_a1_a,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI1_aMux_276_rtl_201_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_276_rtl_201_a1);

inst_aI1_astack_addrs_c_a0_a_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a1_a = DFFEA(rtl_a2499 & (inst_aI1_aMux_276_rtl_201_a1 # !inst_aI2_apc_mux_x_a2_a_a27) # !rtl_a2499 & inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_aMux_276_rtl_201_a1, GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FC0C",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => rtl_a2499,
	datac => inst_aI2_apc_mux_x_a2_a_a27,
	datad => inst_aI1_aMux_276_rtl_201_a1,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a1_a);

inst_aI1_aiaddr_x_a1_a_a211_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a1_a_a211 = inst_aI1_astack_addrs_c_a0_a_a1_a & inst_aI2_apc_mux_x_a2_a_a27 & inst_aI2_apc_mux_x_a0_a_a8 & inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a0_a_a1_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a1_a_a211);

inst_aI1_aiaddr_x_a1_a_a210_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a1_a_a210 = inst_aI1_aiaddr_x_a1_a_a211 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aiaddr_x_a1_a_a206 # inst_aI1_aiaddr_x_a1_a_a90)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF32",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_aiaddr_x_a1_a_a206,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aiaddr_x_a1_a_a90,
	datad => inst_aI1_aiaddr_x_a1_a_a211,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a1_a_a210);

inst_aI2_aTC_x_a1_a_a42_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aTC_x_a1_a_a42 = nRESET_acombout & !inst6_aaltsyncram_component_aq_a_a2_a & !inst6_aaltsyncram_component_aq_a_a1_a & inst6_aaltsyncram_component_aq_a_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0200",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => nRESET_acombout,
	datab => inst6_aaltsyncram_component_aq_a_a2_a,
	datac => inst6_aaltsyncram_component_aq_a_a1_a,
	datad => inst6_aaltsyncram_component_aq_a_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aTC_x_a1_a_a42);

inst_aI2_aTC_x_a0_a_a233_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aTC_x_a0_a_a233 = !inst6_aaltsyncram_component_aq_a_a3_a & nRESET_acombout

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst6_aaltsyncram_component_aq_a_a3_a,
	datad => nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aTC_x_a0_a_a233);

inst_aI2_aTC_x_a0_a_a114_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aTC_x_a0_a_a114 = !inst6_aaltsyncram_component_aq_a_a4_a & inst6_aaltsyncram_component_aq_a_a7_a & !inst6_aaltsyncram_component_aq_a_a5_a & inst6_aaltsyncram_component_aq_a_a6_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_aaltsyncram_component_aq_a_a4_a,
	datab => inst6_aaltsyncram_component_aq_a_a7_a,
	datac => inst6_aaltsyncram_component_aq_a_a5_a,
	datad => inst6_aaltsyncram_component_aq_a_a6_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aTC_x_a0_a_a114);

inst_aI2_aTC_x_a0_a_a119_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aTC_x_a0_a_a119 = inst_aI2_aTC_x_a1_a_a42 # inst_aI2_aTC_x_a0_a_a233 & (inst_aI2_aTC_x_a0_a_a114 # !inst_aI2_aTD_x_a3_a_a9)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FABA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTC_x_a1_a_a42,
	datab => inst_aI2_aTD_x_a3_a_a9,
	datac => inst_aI2_aTC_x_a0_a_a233,
	datad => inst_aI2_aTC_x_a0_a_a114,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aTC_x_a0_a_a119);

inst_aI2_askip_c_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI2_ai_a342 = M1_skip_c # inst_aI2_aTC_c_a2_a # !inst_aI2_aTC_c_a0_a # !inst_aI2_aTC_c_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "FFF7",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aTC_c_a1_a,
	datab => inst_aI2_aTC_c_a0_a,
	datac => inst_aI3_ai_a85,
	datad => inst_aI2_aTC_c_a2_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_ai_a342);

inst_aI2_andre_x_a63_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_andre_x_a63 = inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a & (inst_aI2_aint_start_c # !inst_aI3_ai_a213)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C0F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI2_aint_start_c,
	datac => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a,
	datad => inst_aI3_ai_a213,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_andre_x_a63);

inst_aI2_andre_x_a44_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_andre_x_a44 = inst_aI2_andre_x_a63 & (inst_aI2_ai_a342 # inst_aI2_aC_mem_x_a0 # !inst_aI2_ai_a326)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0B0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_ai_a342,
	datab => inst_aI2_ai_a326,
	datac => inst_aI2_andre_x_a63,
	datad => inst_aI2_aC_mem_x_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_andre_x_a44);

inst_aI3_ai_a85_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_ai_a85 = inst_aI3_ai_a220 & !inst_aI2_aint_start_c & (rtl_a15020 # rtl_a15027)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2220",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_ai_a220,
	datab => inst_aI2_aint_start_c,
	datac => rtl_a15020,
	datad => rtl_a15027,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_ai_a85);

inst_aI2_aint_stop_x_a10_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aint_stop_x_a10 = !inst_aI3_ai_a85 & inst_aI2_ai_a326 & inst_aI2_apc_mux_x_a1_a_a169 & inst_aI2_ai_a364

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_ai_a85,
	datab => inst_aI2_ai_a326,
	datac => inst_aI2_apc_mux_x_a1_a_a169,
	datad => inst_aI2_ai_a364,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_aint_stop_x_a10);

inst_aI2_aint_stop_c_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aint_stop_c = DFFEA(inst_aI2_aint_stop_x_a10 & (!inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a # !inst_aI2_ai_a13 # !nRESET_acombout), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "7F00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => nRESET_acombout,
	datab => inst_aI2_ai_a13,
	datac => inst_aI2_anreset_v_rtl_4_awysi_counter_asafe_q_a1_a,
	datad => inst_aI2_aint_stop_x_a10,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_aint_stop_c);

inst_aI2_ai_a13_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_ai_a13 = !inst_aI2_aint_stop_c & inst_aI2_aS_c_a9 & (inst3_areduce_nor_128_a23 # inst3_areduce_nor_128_a28)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4440",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aint_stop_c,
	datab => inst_aI2_aS_c_a9,
	datac => inst3_areduce_nor_128_a23,
	datad => inst3_areduce_nor_128_a28,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_ai_a13);

inst_aI2_apc_mux_x_a2_a_a187_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_apc_mux_x_a2_a_a187 = !inst_aI3_ai_a85 & (!inst_aI2_aTC_x_a1_a_a22 # !inst_aI2_aTC_x_a2_a_a112)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "030F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI2_aTC_x_a2_a_a112,
	datac => inst_aI3_ai_a85,
	datad => inst_aI2_aTC_x_a1_a_a22,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_apc_mux_x_a2_a_a187);

inst_aI2_apc_mux_x_a2_a_a27_I : cyclone_lcell 
-- Equation(s):
-- inst_aI2_apc_mux_x_a2_a_a27 = inst_aI2_ai_a326 & (inst_aI2_ai_a13 # inst_aI2_apc_mux_x_a2_a_a187 & inst_aI2_ai_a43)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_ai_a326,
	datab => inst_aI2_ai_a13,
	datac => inst_aI2_apc_mux_x_a2_a_a187,
	datad => inst_aI2_ai_a43,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI2_apc_mux_x_a2_a_a27);

rtl_a2489_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2489 = inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_aadd_185_a0 # !inst_aI2_apc_mux_x_a1_a_a42 & inst_aI1_astack_addrs_c_a0_a_a0_a) # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_astack_addrs_c_a0_a_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CAAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a0_a_a0_a,
	datab => inst_aI1_aadd_185_a0,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2489);

inst_aI1_astack_addrs_c_a7_a_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a7_a_a0_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a6_a_a0_a & !inst_aI1_aMux_197_rtl_141_a0 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a6_a_a0_a # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a7_a_a0_a), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "22B8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a6_a_a0_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_astack_addrs_c_a7_a_a0_a,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a7_a_a0_a);

rtl_a3145_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3145 = inst_aI1_astack_addrs_c_a6_a_a0_a & (inst_aI1_astack_addrs_c_a7_a_a0_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a6_a_a0_a & inst_aI1_astack_addrs_c_a7_a_a0_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a6_a_a0_a,
	datac => inst_aI1_astack_addrs_c_a7_a_a0_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3145);

inst_aI1_astack_addrs_c_a6_a_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a6_a_a0_a = DFFEA(inst_aI1_aMux_197_rtl_141_a0 & (inst_aI2_apc_mux_x_a2_a_a27 & rtl_a3145 # !inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a5_a_a0_a) # !inst_aI1_aMux_197_rtl_141_a0 & (inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_astack_addrs_c_a5_a_a0_a # !inst_aI2_apc_mux_x_a2_a_a27 & rtl_a3145), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F960",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_aMux_197_rtl_141_a0,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_astack_addrs_c_a5_a_a0_a,
	datad => rtl_a3145,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a6_a_a0_a);

rtl_a3045_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3045 = inst_aI1_astack_addrs_c_a6_a_a0_a & (inst_aI1_astack_addrs_c_a5_a_a0_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a6_a_a0_a & inst_aI1_astack_addrs_c_a5_a_a0_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AACC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a6_a_a0_a,
	datab => inst_aI1_astack_addrs_c_a5_a_a0_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3045);

inst_aI1_astack_addrs_c_a5_a_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a5_a_a0_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a3045 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a4_a_a0_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a4_a_a0_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a3045), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a4_a_a0_a,
	datac => rtl_a3045,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a5_a_a0_a);

rtl_a2945_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2945 = inst_aI1_astack_addrs_c_a4_a_a0_a & (inst_aI1_astack_addrs_c_a5_a_a0_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a4_a_a0_a & inst_aI1_astack_addrs_c_a5_a_a0_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a4_a_a0_a,
	datac => inst_aI1_astack_addrs_c_a5_a_a0_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2945);

inst_aI1_astack_addrs_c_a4_a_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a4_a_a0_a = DFFEA(inst_aI1_astack_addrs_c_a3_a_a0_a & (rtl_a2945 # inst_aI2_apc_mux_x_a2_a_a27 $ inst_aI1_aMux_197_rtl_141_a0) # !inst_aI1_astack_addrs_c_a3_a_a0_a & rtl_a2945 & (inst_aI2_apc_mux_x_a2_a_a27 $ !inst_aI1_aMux_197_rtl_141_a0), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2B8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI1_astack_addrs_c_a3_a_a0_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a2945,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a4_a_a0_a);

rtl_a2845_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2845 = inst_aI1_astack_addrs_c_a4_a_a0_a & (inst_aI1_astack_addrs_c_a3_a_a0_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a4_a_a0_a & inst_aI1_astack_addrs_c_a3_a_a0_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a4_a_a0_a,
	datac => inst_aI1_astack_addrs_c_a3_a_a0_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2845);

inst_aI1_astack_addrs_c_a3_a_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a3_a_a0_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a2845 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a2_a_a0_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a2_a_a0_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a2845), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a2_a_a0_a,
	datac => rtl_a2845,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a3_a_a0_a);

rtl_a2745_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2745 = inst_aI1_astack_addrs_c_a3_a_a0_a & (inst_aI1_astack_addrs_c_a2_a_a0_a # inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a3_a_a0_a & inst_aI1_astack_addrs_c_a2_a_a0_a & !inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a3_a_a0_a,
	datac => inst_aI1_astack_addrs_c_a2_a_a0_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2745);

inst_aI1_astack_addrs_c_a2_a_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a2_a_a0_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a2745 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a1_a_a0_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a1_a_a0_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a2745), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E4D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a1_a_a0_a,
	datac => rtl_a2745,
	datad => inst_aI1_aMux_197_rtl_141_a0,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a2_a_a0_a);

rtl_a2605_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2605 = inst_aI1_astack_addrs_c_a1_a_a0_a & (inst_aI1_astack_addrs_c_a2_a_a0_a # !inst_aI2_apc_mux_x_a2_a_a27) # !inst_aI1_astack_addrs_c_a1_a_a0_a & inst_aI1_astack_addrs_c_a2_a_a0_a & inst_aI2_apc_mux_x_a2_a_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst_aI1_astack_addrs_c_a1_a_a0_a,
	datac => inst_aI1_astack_addrs_c_a2_a_a0_a,
	datad => inst_aI2_apc_mux_x_a2_a_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2605);

inst_aI1_astack_addrs_c_a1_a_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a1_a_a0_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & rtl_a2605 # !inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a0_a_a0_a) # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aMux_197_rtl_141_a0 & inst_aI1_astack_addrs_c_a0_a_a0_a # !inst_aI1_aMux_197_rtl_141_a0 & rtl_a2605), GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ED48",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datab => inst_aI1_astack_addrs_c_a0_a_a0_a,
	datac => inst_aI1_aMux_197_rtl_141_a0,
	datad => rtl_a2605,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a1_a_a0_a);

inst_aI1_aMux_277_rtl_198_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_277_rtl_198_a0 = inst_aI2_apc_mux_x_a0_a_a8 & (inst_aI1_apc_a0_a # inst_aI2_apc_mux_x_a1_a_a42) # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a0 & !inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0AC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_apc_a0_a,
	datab => inst_aI1_aadd_185_a0,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_277_rtl_198_a0);

rtl_a920 : cyclone_lcell 
-- Equation(s):
-- rtl_a443 = LCELL(inst_aI1_aMux_287_a32 & (inst_aI2_apc_mux_x_a0_a_a8 & rtl_a443 # !inst_aI2_apc_mux_x_a0_a_a8 & inst6_aaltsyncram_component_aq_a_a4_a) # !inst_aI1_aMux_287_a32 & rtl_a443)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCAC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst6_aaltsyncram_component_aq_a_a4_a,
	datab => rtl_a443,
	datac => inst_aI1_aMux_287_a32,
	datad => inst_aI2_apc_mux_x_a0_a_a8,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a443);

inst_aI1_aMux_277_rtl_198_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aMux_277_rtl_198_a1 = inst_aI1_aMux_277_rtl_198_a0 & (inst_aI1_astack_addrs_c_a1_a_a0_a # !inst_aI2_apc_mux_x_a1_a_a42) # !inst_aI1_aMux_277_rtl_198_a0 & inst_aI2_apc_mux_x_a1_a_a42 & rtl_a443

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DAD0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_apc_mux_x_a1_a_a42,
	datab => inst_aI1_astack_addrs_c_a1_a_a0_a,
	datac => inst_aI1_aMux_277_rtl_198_a0,
	datad => rtl_a443,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aMux_277_rtl_198_a1);

inst_aI1_astack_addrs_c_a0_a_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI1_astack_addrs_c_a0_a_a0_a = DFFEA(inst_aI2_apc_mux_x_a2_a_a27 & inst_aI1_aMux_277_rtl_198_a1 # !inst_aI2_apc_mux_x_a2_a_a27 & rtl_a2489, GLOBAL(UCLK_acombout), VCC, , inst_aI1_ai_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FA50",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_apc_mux_x_a2_a_a27,
	datac => rtl_a2489,
	datad => inst_aI1_aMux_277_rtl_198_a1,
	aclr => GND,
	ena => inst_aI1_ai_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI1_astack_addrs_c_a0_a_a0_a);

inst_aI1_aiaddr_x_a0_a_a194_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a0_a_a194 = inst_aI1_astack_addrs_c_a0_a_a0_a & inst_aI2_apc_mux_x_a2_a_a27 & inst_aI2_apc_mux_x_a0_a_a8 & inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_astack_addrs_c_a0_a_a0_a,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a0_a_a194);

inst_aI1_aiaddr_x_a0_a_a189_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a0_a_a189 = !inst_aI2_apc_mux_x_a1_a_a42 & (inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_aadd_185_a0 # !inst_aI2_apc_mux_x_a0_a_a8 & inst_aI1_apc_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00CA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_apc_a0_a,
	datab => inst_aI1_aadd_185_a0,
	datac => inst_aI2_apc_mux_x_a0_a_a8,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a0_a_a189);

inst_aI1_aiaddr_x_a0_a_a78_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a0_a_a78 = inst6_aaltsyncram_component_aq_a_a4_a & inst_aI2_apc_mux_x_a1_a_a42

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst6_aaltsyncram_component_aq_a_a4_a,
	datad => inst_aI2_apc_mux_x_a1_a_a42,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a0_a_a78);

inst_aI1_aiaddr_x_a0_a_a193_I : cyclone_lcell 
-- Equation(s):
-- inst_aI1_aiaddr_x_a0_a_a193 = inst_aI1_aiaddr_x_a0_a_a194 # !inst_aI2_apc_mux_x_a2_a_a27 & (inst_aI1_aiaddr_x_a0_a_a189 # inst_aI1_aiaddr_x_a0_a_a78)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BBBA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI1_aiaddr_x_a0_a_a194,
	datab => inst_aI2_apc_mux_x_a2_a_a27,
	datac => inst_aI1_aiaddr_x_a0_a_a189,
	datad => inst_aI1_aiaddr_x_a0_a_a78,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI1_aiaddr_x_a0_a_a193);

inst_aI2_aTD_c_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI2_aTD_c_a3_a = DFFEA(!inst6_aaltsyncram_component_aq_a_a6_a & rtl_a14849 & inst6_aaltsyncram_component_aq_a_a7_a & inst_aI2_aTD_x_a3_a_a9, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst6_aaltsyncram_component_aq_a_a6_a,
	datab => rtl_a14849,
	datac => inst6_aaltsyncram_component_aq_a_a7_a,
	datad => inst_aI2_aTD_x_a3_a_a9,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst_aI2_aTD_c_a3_a);

rtl_a1706_I : cyclone_lcell 
-- Equation(s):
-- rtl_a1706 = rtl_a14838 & inst_aI2_aTD_c_a0_a & (inst_aI3_aacc_c_a0_a_a6_a $ inst_aI3_adata_x_a6_a_a167)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a6_a,
	datab => rtl_a14838,
	datac => inst_aI2_aTD_c_a0_a,
	datad => inst_aI3_adata_x_a6_a_a167,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a1706);

rtl_a2274_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2274 = inst_aI3_aacc_c_a0_a_a6_a & !inst_aI2_aTD_c_a1_a & inst_aI3_aMux_201_rtl_95_a0 & !inst_aI2_aTD_c_a2_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0020",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a6_a,
	datab => inst_aI2_aTD_c_a1_a,
	datac => inst_aI3_aMux_201_rtl_95_a0,
	datad => inst_aI2_aTD_c_a2_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2274);

rtl_a3388_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3388 = inst_aI2_aTD_c_a2_a & (inst_aI3_aacc_c_a0_a_a6_a $ inst_aI2_aTD_c_a1_a) # !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a5_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5CAC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a6_a,
	datab => inst_aI3_aacc_c_a0_a_a5_a,
	datac => inst_aI2_aTD_c_a2_a,
	datad => inst_aI2_aTD_c_a1_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3388);

rtl_a3275_I : cyclone_lcell 
-- Equation(s):
-- rtl_a3275 = inst_aI2_aTD_c_a1_a & inst_aI3_aacc_c_a0_a_a7_a & !inst_aI2_aTD_c_a2_a # !inst_aI2_aTD_c_a1_a & (inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a7_a # !inst_aI2_aTD_c_a2_a & inst_aI3_aacc_c_a0_a_a6_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4D48",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI2_aTD_c_a1_a,
	datab => inst_aI3_aacc_c_a0_a_a7_a,
	datac => inst_aI2_aTD_c_a2_a,
	datad => inst_aI3_aacc_c_a0_a_a6_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a3275);

rtl_a2394_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2394 = !inst_aI3_aMux_201_rtl_95_a0 & (inst_aI2_aTD_c_a0_a & rtl_a3388 # !inst_aI2_aTD_c_a0_a & rtl_a3275)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0B08",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a3388,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_aMux_201_rtl_95_a0,
	datad => rtl_a3275,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2394);

inst_aI3_aMux_172_rtl_49_rtl_516_a0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aMux_172_rtl_49_rtl_516_a0 = inst_aI2_aTD_c_a1_a & (inst_aI3_aadd_153_a7 # inst_aI2_aTD_c_a0_a) # !inst_aI2_aTD_c_a1_a & !inst_aI2_aTD_c_a0_a & inst_aI3_aadd_129_a6

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E3E0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aadd_153_a7,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI2_aTD_c_a1_a,
	datad => inst_aI3_aadd_129_a6,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_172_rtl_49_rtl_516_a0);

inst_aI3_aMux_172_rtl_49_rtl_516_a1_I : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aMux_172_rtl_49_rtl_516_a1 = inst_aI3_aacc_c_a0_a_a6_a & (inst_aI3_aMux_172_rtl_49_rtl_516_a0 # inst_aI2_aTD_c_a0_a & inst_aI3_adata_x_a6_a_a167) # !inst_aI3_aacc_c_a0_a_a6_a & inst_aI3_aMux_172_rtl_49_rtl_516_a0 & (inst_aI3_adata_x_a6_a_a167 # !inst_aI2_aTD_c_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FB80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI3_aacc_c_a0_a_a6_a,
	datab => inst_aI2_aTD_c_a0_a,
	datac => inst_aI3_adata_x_a6_a_a167,
	datad => inst_aI3_aMux_172_rtl_49_rtl_516_a0,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aMux_172_rtl_49_rtl_516_a1);

rtl_a15191_I : cyclone_lcell 
-- Equation(s):
-- rtl_a15191 = rtl_a2274 # rtl_a2394 # rtl_a14854 & inst_aI3_aMux_172_rtl_49_rtl_516_a1

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FEEE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a2274,
	datab => rtl_a2394,
	datac => rtl_a14854,
	datad => inst_aI3_aMux_172_rtl_49_rtl_516_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a15191);

rtl_a2393_I : cyclone_lcell 
-- Equation(s):
-- rtl_a2393 = rtl_a1706 # rtl_a15191 # rtl_a14847 & inst_aI3_adata_x_a6_a_a167

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => rtl_a14847,
	datab => inst_aI3_adata_x_a6_a_a167,
	datac => rtl_a1706,
	datad => rtl_a15191,
	devclrn => devclrn,
	devpor => devpor,
	combout => rtl_a2393);

inst_aI3_aacc_c_a0_a_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a6_a_a78 = inst_aI3_aacc_a0_a_a6_a_a4258 # !inst_aI2_aTC_c_a2_a & inst_aI3_aacc_a0_a_a7_a_a4225 & rtl_a2393
-- inst_aI3_aacc_c_a0_a_a6_a = DFFEA(inst_aI3_aacc_a0_a_a6_a_a78, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DCCC",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI2_aTC_c_a2_a,
	datab => inst_aI3_aacc_a0_a_a6_a_a4258,
	datac => inst_aI3_aacc_a0_a_a7_a_a4225,
	datad => rtl_a2393,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a6_a_a78,
	regout => inst_aI3_aacc_c_a0_a_a6_a);

inst_aI3_aacc_i_a0_a_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst_aI3_aacc_a0_a_a6_a_a4258 = inst_aI3_aacc_c_a0_a_a6_a & (inst_aI3_aacc_a0_a_a8_a_a63 # N1_acc_i[0][6] & inst_aI3_aacc_a0_a_a7_a_a4227) # !inst_aI3_aacc_c_a0_a_a6_a & N1_acc_i[0][6] & inst_aI3_aacc_a0_a_a7_a_a4227

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "F888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst_aI3_aacc_c_a0_a_a6_a,
	datab => inst_aI3_aacc_a0_a_a8_a_a63,
	datac => inst_aI3_aacc_a0_a_a6_a_a78,
	datad => inst_aI3_aacc_a0_a_a7_a_a4227,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst_aI2_aint_start_c,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI3_aacc_a0_a_a6_a_a4258);

inst10_aout_0reg_a6_a_areg0_I : cyclone_lcell 
-- Equation(s):
-- inst_aI4_adata_ox_a6_a_a1 = nRESET_acombout & inst_aI3_aacc_c_a0_a_a6_a & inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a
-- inst10_aout_0reg_a6_a_areg0 = DFFEA(inst_aI4_adata_ox_a6_a_a1, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst10_ai_a1, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8080",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => nRESET_acombout,
	datab => inst_aI3_aacc_c_a0_a_a6_a,
	datac => inst_aI4_anreset_v_rtl_6_awysi_counter_asafe_q_a1_a,
	aclr => NOT_nRESET_acombout,
	ena => inst10_ai_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst_aI4_adata_ox_a6_a_a1,
	regout => inst10_aout_0reg_a6_a_areg0);

inst1_atx_clk_div_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_clk_div_a6_a = DFFEA(inst_aI4_adata_ox_a6_a_a1, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_ai_a138, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a6_a_a1,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst1_ai_a138,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_clk_div_a6_a);

inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a0_a : cyclone_lcell 
-- Equation(s):
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a = DFFEA((inst1_areduce_nor_7 & inst1_atx_clk_div_a0_a) # (!inst1_areduce_nor_7 & !inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a_aCOUT0 = CARRY(!inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a)
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a_aCOUT1 = CARRY(!inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3333",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a,
	datac => inst1_atx_clk_div_a0_a,
	aclr => NOT_nRESET_acombout,
	sload => inst1_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a,
	cout0 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a_aCOUT0,
	cout1 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a_aCOUT1);

inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a1_a : cyclone_lcell 
-- Equation(s):
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a = DFFEA((inst1_areduce_nor_7 & inst1_atx_clk_div_a1_a) # (!inst1_areduce_nor_7 & inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a $ inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a_aCOUT0), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a_aCOUT0 = CARRY(inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a # !inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a_aCOUT0)
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a_aCOUT1 = CARRY(inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a # !inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a_aCOUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "5AAF",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a,
	datac => inst1_atx_clk_div_a1_a,
	aclr => NOT_nRESET_acombout,
	sload => inst1_areduce_nor_7,
	cin0 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a_aCOUT0,
	cin1 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a,
	cout0 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a_aCOUT0,
	cout1 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a_aCOUT1);

inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a2_a : cyclone_lcell 
-- Equation(s):
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a = DFFEA((inst1_areduce_nor_7 & inst1_atx_clk_div_a2_a) # (!inst1_areduce_nor_7 & inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a $ !inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a_aCOUT0), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a_aCOUT0 = CARRY(!inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a & !inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a_aCOUT0)
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a_aCOUT1 = CARRY(!inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a & !inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a_aCOUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "A505",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a,
	datac => inst1_atx_clk_div_a2_a,
	aclr => NOT_nRESET_acombout,
	sload => inst1_areduce_nor_7,
	cin0 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a_aCOUT0,
	cin1 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a,
	cout0 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a_aCOUT0,
	cout1 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a_aCOUT1);

inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a3_a : cyclone_lcell 
-- Equation(s):
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a = DFFEA((inst1_areduce_nor_7 & inst1_atx_clk_div_a3_a) # (!inst1_areduce_nor_7 & inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a $ inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a_aCOUT0), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a_aCOUT0 = CARRY(inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a # !inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a_aCOUT0)
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a_aCOUT1 = CARRY(inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a # !inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a_aCOUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "3CCF",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a,
	datac => inst1_atx_clk_div_a3_a,
	aclr => NOT_nRESET_acombout,
	sload => inst1_areduce_nor_7,
	cin0 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a_aCOUT0,
	cin1 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a,
	cout0 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a_aCOUT0,
	cout1 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a_aCOUT1);

inst1_areduce_nor_7_a32_I : cyclone_lcell 
-- Equation(s):
-- inst1_areduce_nor_7_a32 = inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a # inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a # inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a # inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a1_a,
	datab => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a0_a,
	datac => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a2_a,
	datad => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_areduce_nor_7_a32);

inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a4_a : cyclone_lcell 
-- Equation(s):
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a4_a = DFFEA((inst1_areduce_nor_7 & inst1_atx_clk_div_a4_a) # (!inst1_areduce_nor_7 & inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a4_a $ !inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a_aCOUT0), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a4_a_aCOUT = 

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "C303",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a4_a,
	datac => inst1_atx_clk_div_a4_a,
	aclr => NOT_nRESET_acombout,
	sload => inst1_areduce_nor_7,
	cin0 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a_aCOUT0,
	cin1 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a3_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a4_a,
	cout => inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a4_a_aCOUT);

inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a5_a : cyclone_lcell 
-- Equation(s):
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a = DFFEA((inst1_areduce_nor_7 & inst1_atx_clk_div_a5_a) # (!inst1_areduce_nor_7 & inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a $ (!inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a4_a_aCOUT & GND) # (inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a4_a_aCOUT & VCC)), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a_aCOUT0 = CARRY(inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a # !inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a4_a_aCOUT)
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a_aCOUT1 = CARRY(inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a # !inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a4_a_aCOUT)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "3CCF",
	cin_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a,
	datac => inst1_atx_clk_div_a5_a,
	aclr => NOT_nRESET_acombout,
	sload => inst1_areduce_nor_7,
	cin => inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a4_a_aCOUT,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a,
	cout0 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a_aCOUT0,
	cout1 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a_aCOUT1);

inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a6_a : cyclone_lcell 
-- Equation(s):
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a = DFFEA((inst1_areduce_nor_7 & inst1_atx_clk_div_a6_a) # (!inst1_areduce_nor_7 & inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a $ !(!inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a4_a_aCOUT & inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a_aCOUT0) # (inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a4_a_aCOUT & inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a_aCOUT1)), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a_aCOUT0 = CARRY(!inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a & !inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a_aCOUT0)
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a_aCOUT1 = CARRY(!inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a & !inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a_aCOUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "A505",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a,
	datac => inst1_atx_clk_div_a6_a,
	aclr => NOT_nRESET_acombout,
	sload => inst1_areduce_nor_7,
	cin => inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a4_a_aCOUT,
	cin0 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a_aCOUT0,
	cin1 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a,
	cout0 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a_aCOUT0,
	cout1 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a_aCOUT1);

inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a7_a : cyclone_lcell 
-- Equation(s):
-- inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a7_a = DFFEA((inst1_areduce_nor_7 & inst1_atx_clk_div_a7_a) # (!inst1_areduce_nor_7 & inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a7_a $ (!inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a4_a_aCOUT & inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a_aCOUT0) # (inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a4_a_aCOUT & inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a_aCOUT1)), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "5A5A",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a7_a,
	datac => inst1_atx_clk_div_a7_a,
	aclr => NOT_nRESET_acombout,
	sload => inst1_areduce_nor_7,
	cin => inst1_atx_clk_count_rtl_5_awysi_counter_acounter_cell_a4_a_aCOUT,
	cin0 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a_aCOUT0,
	cin1 => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a7_a);

inst1_areduce_nor_7_a39_I : cyclone_lcell 
-- Equation(s):
-- inst1_areduce_nor_7_a39 = inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a7_a # inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a7_a,
	datad => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_areduce_nor_7_a39);

inst1_areduce_nor_7_aI : cyclone_lcell 
-- Equation(s):
-- inst1_areduce_nor_7 = !inst1_areduce_nor_7_a32 & !inst1_areduce_nor_7_a39 & !inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a & !inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a4_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0001",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_areduce_nor_7_a32,
	datab => inst1_areduce_nor_7_a39,
	datac => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a,
	datad => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_areduce_nor_7);

inst1_areduce_nor_7_a27_I : cyclone_lcell 
-- Equation(s):
-- inst1_areduce_nor_7_a27 = inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a # inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a # inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a7_a # inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a4_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a6_a,
	datab => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a5_a,
	datac => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a7_a,
	datad => inst1_atx_clk_count_rtl_5_awysi_counter_asafe_q_a4_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_areduce_nor_7_a27);

inst1_ai_a182_I : cyclone_lcell 
-- Equation(s):
-- inst1_ai_a182 = inst1_atx_uart_busy & (inst1_atx_s # inst1_areduce_nor_7_a27 # inst1_areduce_nor_7_a32)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FE00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_atx_s,
	datab => inst1_areduce_nor_7_a27,
	datac => inst1_areduce_nor_7_a32,
	datad => inst1_atx_uart_busy,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_ai_a182);

inst1_atx_uart_busy_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_uart_busy = DFFEA(inst1_ai_a182 # inst1_ai_a457 & !inst_aI5_ai_a12 & inst1_ai_a500, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AEAA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst1_ai_a182,
	datab => inst1_ai_a457,
	datac => inst_aI5_ai_a12,
	datad => inst1_ai_a500,
	aclr => NOT_nRESET_acombout,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_uart_busy);

inst1_ai_a114_I : cyclone_lcell 
-- Equation(s):
-- inst1_ai_a114 = inst1_atx_uart_busy & (!inst1_areduce_nor_34_a11 # !inst1_atx_s) # !inst1_atx_uart_busy & inst1_atx_s & !inst1_areduce_nor_34_a11

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0CFC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst1_atx_uart_busy,
	datac => inst1_atx_s,
	datad => inst1_areduce_nor_34_a11,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_ai_a114);

inst1_atx_16_count_a3_a_a3_I : cyclone_lcell 
-- Equation(s):
-- inst1_atx_16_count_a3_a_a3 = !inst1_areduce_nor_7_a32 & nRESET_acombout & !inst1_areduce_nor_7_a27

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0030",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => inst1_areduce_nor_7_a32,
	datac => nRESET_acombout,
	datad => inst1_areduce_nor_7_a27,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_atx_16_count_a3_a_a3);

inst1_atx_16_count_rtl_8_awysi_counter_acounter_cell_a0_a : cyclone_lcell 
-- Equation(s):
-- inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a = DFFEA(!inst1_ai_a114 & inst1_atx_s $ inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a, GLOBAL(UCLK_acombout), VCC, , inst1_atx_16_count_a3_a_a3, , )
-- inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a_aCOUT0 = CARRY(inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a)
-- inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a_aCOUT1 = CARRY(inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "66CC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst1_atx_s,
	datab => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a,
	aclr => GND,
	sclr => inst1_ai_a114,
	ena => inst1_atx_16_count_a3_a_a3,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a,
	cout0 => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a_aCOUT0,
	cout1 => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a_aCOUT1);

inst1_atx_16_count_rtl_8_awysi_counter_acounter_cell_a1_a : cyclone_lcell 
-- Equation(s):
-- inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a = DFFEA(!inst1_ai_a114 & inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a $ (inst1_atx_s & inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a_aCOUT0), GLOBAL(UCLK_acombout), VCC, , inst1_atx_16_count_a3_a_a3, , )
-- inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a_aCOUT0 = CARRY(!inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a_aCOUT0 # !inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a)
-- inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a_aCOUT1 = CARRY(!inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a_aCOUT1 # !inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "6A5F",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a,
	datab => inst1_atx_s,
	aclr => GND,
	sclr => inst1_ai_a114,
	ena => inst1_atx_16_count_a3_a_a3,
	cin0 => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a_aCOUT0,
	cin1 => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a,
	cout0 => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a_aCOUT0,
	cout1 => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a_aCOUT1);

inst1_atx_16_count_rtl_8_awysi_counter_acounter_cell_a2_a : cyclone_lcell 
-- Equation(s):
-- inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a = DFFEA(!inst1_ai_a114 & inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a $ (inst1_atx_s & !inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a_aCOUT0), GLOBAL(UCLK_acombout), VCC, , inst1_atx_16_count_a3_a_a3, , )
-- inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a_aCOUT0 = CARRY(inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a & !inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a_aCOUT0)
-- inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a_aCOUT1 = CARRY(inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a & !inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a_aCOUT1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "A60A",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a,
	datab => inst1_atx_s,
	aclr => GND,
	sclr => inst1_ai_a114,
	ena => inst1_atx_16_count_a3_a_a3,
	cin0 => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a_aCOUT0,
	cin1 => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a,
	cout0 => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a_aCOUT0,
	cout1 => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a_aCOUT1);

inst1_atx_16_count_rtl_8_awysi_counter_acounter_cell_a3_a : cyclone_lcell 
-- Equation(s):
-- inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a3_a = DFFEA(!inst1_ai_a114 & inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a3_a $ (inst1_atx_s & inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a_aCOUT0), GLOBAL(UCLK_acombout), VCC, , inst1_atx_16_count_a3_a_a3, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "6C6C",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst1_atx_s,
	datab => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a3_a,
	aclr => GND,
	sclr => inst1_ai_a114,
	ena => inst1_atx_16_count_a3_a_a3,
	cin0 => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a_aCOUT0,
	cin1 => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a3_a);

inst1_areduce_nor_34_a11_I : cyclone_lcell 
-- Equation(s):
-- inst1_areduce_nor_34_a11 = !inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a # !inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a # !inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a3_a # !inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "7FFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a1_a,
	datab => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a3_a,
	datac => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a2_a,
	datad => inst1_atx_16_count_rtl_8_awysi_counter_asafe_q_a0_a,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_areduce_nor_34_a11);

inst1_atx_bit_count_rtl_7_awysi_counter_acounter_cell_a3_a : cyclone_lcell 
-- Equation(s):
-- inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a3_a = DFFEA(!inst1_ai_a175 & inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a3_a $ inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a_aCOUT0, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_atx_bit_count_a3_a_a15, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "3C3C",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datab => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a3_a,
	aclr => NOT_nRESET_acombout,
	sclr => inst1_ai_a175,
	ena => inst1_atx_bit_count_a3_a_a15,
	cin0 => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a_aCOUT0,
	cin1 => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a_aCOUT1,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a3_a);

inst1_atx_s_a23_I : cyclone_lcell 
-- Equation(s):
-- inst1_atx_s_a23 = inst1_atx_s_a12 & !inst1_areduce_nor_34_a11 & inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a3_a & inst1_atx_s

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_atx_s_a12,
	datab => inst1_areduce_nor_34_a11,
	datac => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a3_a,
	datad => inst1_atx_s,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_atx_s_a23);

inst1_atx_s_a27_I : cyclone_lcell 
-- Equation(s):
-- inst1_atx_s_a27 = inst1_areduce_nor_7 & (inst1_atx_s_a23 # inst1_atx_uart_busy & !inst1_atx_s)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AE00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_atx_s_a23,
	datab => inst1_atx_uart_busy,
	datac => inst1_atx_s,
	datad => inst1_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_atx_s_a27);

inst1_atx_s_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_s = DFFEA(!inst1_atx_s, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_atx_s_a27, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst1_atx_s,
	aclr => NOT_nRESET_acombout,
	ena => inst1_atx_s_a27,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_s);

inst1_atx_bit_count_a3_a_a15_I : cyclone_lcell 
-- Equation(s):
-- inst1_atx_bit_count_a3_a_a15 = inst1_areduce_nor_7 & (inst1_atx_s & !inst1_areduce_nor_34_a11 # !inst1_atx_s & inst1_atx_uart_busy)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4C08",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_atx_s,
	datab => inst1_areduce_nor_7,
	datac => inst1_areduce_nor_34_a11,
	datad => inst1_atx_uart_busy,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_atx_bit_count_a3_a_a15);

inst1_ai_a175_I : cyclone_lcell 
-- Equation(s):
-- inst1_ai_a175 = inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a3_a & (inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a # inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a) # !inst1_atx_s

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E0FF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a,
	datab => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a,
	datac => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a3_a,
	datad => inst1_atx_s,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_ai_a175);

inst1_ai_a45_I : cyclone_lcell 
-- Equation(s):
-- inst1_ai_a45 = nRESET_acombout & inst_aI5_andwe_c & !inst_aI5_ai_a12 & inst1_ai_a500

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => nRESET_acombout,
	datab => inst_aI5_andwe_c,
	datac => inst_aI5_ai_a12,
	datad => inst1_ai_a500,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_ai_a45);

inst1_atx_uart_fifo_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_uart_fifo_a2_a = DFFEA(!inst_aI4_adata_ox_a2_a_a5, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_ai_a45, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a2_a_a5,
	aclr => NOT_nRESET_acombout,
	ena => inst1_ai_a45,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_uart_fifo_a2_a);

inst1_atx_uart_shift_a8_a_a2_I : cyclone_lcell 
-- Equation(s):
-- inst1_atx_uart_shift_a8_a_a2 = !inst1_areduce_nor_7_a32 & !inst1_areduce_nor_7_a27 & !inst1_atx_s & inst1_atx_uart_busy

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0100",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_areduce_nor_7_a32,
	datab => inst1_areduce_nor_7_a27,
	datac => inst1_atx_s,
	datad => inst1_atx_uart_busy,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_atx_uart_shift_a8_a_a2);

inst1_atx_uart_shift_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_uart_shift_a3_a = DFFEA(inst1_atx_uart_fifo_a2_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_atx_uart_shift_a8_a_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst1_atx_uart_fifo_a2_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst1_atx_uart_shift_a8_a_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_uart_shift_a3_a);

inst1_atx_uart_fifo_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_uart_fifo_a0_a = DFFEA(!inst_aI4_adata_ox_a0_a_a7, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_ai_a45, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a0_a_a7,
	aclr => NOT_nRESET_acombout,
	ena => inst1_ai_a45,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_uart_fifo_a0_a);

inst1_atx_uart_fifo_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_uart_fifo_a1_a = DFFEA(!inst_aI4_adata_ox_a1_a_a6, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_ai_a45, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a1_a_a6,
	aclr => NOT_nRESET_acombout,
	ena => inst1_ai_a45,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_uart_fifo_a1_a);

inst1_atx_uart_shift_a0_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_uart_shift_a0_a = DFFEA(VCC, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_atx_uart_shift_a8_a_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFFF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	aclr => NOT_nRESET_acombout,
	ena => inst1_atx_uart_shift_a8_a_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_uart_shift_a0_a);

inst1_atx_uart_shift_a2_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_aMux_29_rtl_21_a0 = inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a & (inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a # !C1_tx_uart_shift[2]) # !inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a & !inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a & !inst1_atx_uart_shift_a0_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "8C9D",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a,
	datab => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a,
	datac => inst1_atx_uart_fifo_a1_a,
	datad => inst1_atx_uart_shift_a0_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst1_atx_uart_shift_a8_a_a2,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_aMux_29_rtl_21_a0);

inst1_atx_uart_shift_a1_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_aMux_29_rtl_21_a1 = inst1_aMux_29_rtl_21_a0 & (!inst1_atx_uart_shift_a3_a # !inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a) # !inst1_aMux_29_rtl_21_a0 & inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a & !C1_tx_uart_shift[1]

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "770A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a,
	datab => inst1_atx_uart_shift_a3_a,
	datac => inst1_atx_uart_fifo_a0_a,
	datad => inst1_aMux_29_rtl_21_a0,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst1_atx_uart_shift_a8_a_a2,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_aMux_29_rtl_21_a1);

inst1_atx_uart_fifo_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_uart_fifo_a5_a = DFFEA(!inst_aI4_adata_ox_a5_a_a2, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_ai_a45, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a5_a_a2,
	aclr => NOT_nRESET_acombout,
	ena => inst1_ai_a45,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_uart_fifo_a5_a);

inst1_atx_uart_fifo_a3_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_uart_fifo_a3_a = DFFEA(!inst_aI4_adata_ox_a3_a_a4, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_ai_a45, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a3_a_a4,
	aclr => NOT_nRESET_acombout,
	ena => inst1_ai_a45,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_uart_fifo_a3_a);

inst1_atx_uart_shift_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_uart_shift_a4_a = DFFEA(inst1_atx_uart_fifo_a3_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_atx_uart_shift_a8_a_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst1_atx_uart_fifo_a3_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst1_atx_uart_shift_a8_a_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_uart_shift_a4_a);

inst1_atx_uart_shift_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_aMux_29_rtl_22_a0 = inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a & (inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a # !C1_tx_uart_shift[6]) # !inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a & !inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a & !inst1_atx_uart_shift_a4_a

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "8C9D",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a,
	datab => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a,
	datac => inst1_atx_uart_fifo_a5_a,
	datad => inst1_atx_uart_shift_a4_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst1_atx_uart_shift_a8_a_a2,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_aMux_29_rtl_22_a0);

inst1_atx_uart_fifo_a4_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_uart_fifo_a4_a = DFFEA(!inst_aI4_adata_ox_a4_a_a3, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_ai_a45, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a4_a_a3,
	aclr => NOT_nRESET_acombout,
	ena => inst1_ai_a45,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_uart_fifo_a4_a);

inst1_atx_uart_fifo_a6_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_uart_fifo_a6_a = DFFEA(!inst_aI4_adata_ox_a6_a_a1, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_ai_a45, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a6_a_a1,
	aclr => NOT_nRESET_acombout,
	ena => inst1_ai_a45,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_uart_fifo_a6_a);

inst1_atx_uart_shift_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_uart_shift_a7_a = DFFEA(inst1_atx_uart_fifo_a6_a, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_atx_uart_shift_a8_a_a2, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst1_atx_uart_fifo_a6_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst1_atx_uart_shift_a8_a_a2,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_uart_shift_a7_a);

inst1_atx_uart_shift_a5_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_aMux_29_rtl_22_a1 = inst1_aMux_29_rtl_22_a0 & (!inst1_atx_uart_shift_a7_a # !inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a) # !inst1_aMux_29_rtl_22_a0 & inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a & !C1_tx_uart_shift[5]

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "46CE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a,
	datab => inst1_aMux_29_rtl_22_a0,
	datac => inst1_atx_uart_fifo_a4_a,
	datad => inst1_atx_uart_shift_a7_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst1_atx_uart_shift_a8_a_a2,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_aMux_29_rtl_22_a1);

inst1_ai_a191_I : cyclone_lcell 
-- Equation(s):
-- inst1_ai_a191 = !inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a3_a & (inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a & inst1_aMux_29_rtl_22_a1 # !inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a & inst1_aMux_29_rtl_21_a1)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0E02",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst1_aMux_29_rtl_21_a1,
	datab => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a,
	datac => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a3_a,
	datad => inst1_aMux_29_rtl_22_a1,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_ai_a191);

inst1_atx_uart_fifo_a7_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_atx_uart_fifo_a7_a = DFFEA(!inst_aI4_adata_ox_a7_a_a0, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_ai_a45, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a7_a_a0,
	aclr => NOT_nRESET_acombout,
	ena => inst1_ai_a45,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_uart_fifo_a7_a);

inst1_atx_uart_shift_a8_a_aI : cyclone_lcell 
-- Equation(s):
-- inst1_ai_a472 = inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a3_a & (inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a & !inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a # !inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a & (inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a # !C1_tx_uart_shift[8]))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "6700",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a0_a,
	datab => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a1_a,
	datac => inst1_atx_uart_fifo_a7_a,
	datad => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a3_a,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst1_atx_uart_shift_a8_a_a2,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst1_ai_a472);

inst1_atx_uart_areg0_I : cyclone_lcell 
-- Equation(s):
-- inst1_atx_uart_areg0 = DFFEA(!inst1_ai_a191 & inst1_atx_s & (inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a # !inst1_ai_a472), GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst1_areduce_nor_7, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4404",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	dataa => inst1_ai_a191,
	datab => inst1_atx_s,
	datac => inst1_ai_a472,
	datad => inst1_atx_bit_count_rtl_7_awysi_counter_asafe_q_a2_a,
	aclr => NOT_nRESET_acombout,
	ena => inst1_areduce_nor_7,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst1_atx_uart_areg0);

inst10_ai_a74_I : cyclone_lcell 
-- Equation(s):
-- inst10_ai_a74 = inst_aI5_ai_a12 & inst2_ai_a300 & !inst5_areduce_nor_21 & inst5_areduce_nor_19_a54

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => inst_aI5_ai_a12,
	datab => inst2_ai_a300,
	datac => inst5_areduce_nor_21,
	datad => inst5_areduce_nor_19_a54,
	devclrn => devclrn,
	devpor => devpor,
	combout => inst10_ai_a74);

inst10_aout_1reg_a7_a_areg0_I : cyclone_lcell 
-- Equation(s):
-- inst10_aout_1reg_a7_a_areg0 = DFFEA(inst_aI4_adata_ox_a7_a_a0, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst10_ai_a74, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a7_a_a0,
	aclr => NOT_nRESET_acombout,
	ena => inst10_ai_a74,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst10_aout_1reg_a7_a_areg0);

inst10_aout_1reg_a6_a_areg0_I : cyclone_lcell 
-- Equation(s):
-- inst10_aout_1reg_a6_a_areg0 = DFFEA(inst_aI4_adata_ox_a6_a_a1, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst10_ai_a74, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a6_a_a1,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst10_ai_a74,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst10_aout_1reg_a6_a_areg0);

inst10_aout_1reg_a5_a_areg0_I : cyclone_lcell 
-- Equation(s):
-- inst10_aout_1reg_a5_a_areg0 = DFFEA(inst_aI4_adata_ox_a5_a_a2, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst10_ai_a74, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a5_a_a2,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst10_ai_a74,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst10_aout_1reg_a5_a_areg0);

inst10_aout_1reg_a4_a_areg0_I : cyclone_lcell 
-- Equation(s):
-- inst10_aout_1reg_a4_a_areg0 = DFFEA(inst_aI4_adata_ox_a4_a_a3, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst10_ai_a74, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a4_a_a3,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst10_ai_a74,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst10_aout_1reg_a4_a_areg0);

inst10_aout_1reg_a3_a_areg0_I : cyclone_lcell 
-- Equation(s):
-- inst10_aout_1reg_a3_a_areg0 = DFFEA(inst_aI4_adata_ox_a3_a_a4, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst10_ai_a74, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a3_a_a4,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst10_ai_a74,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst10_aout_1reg_a3_a_areg0);

inst10_aout_1reg_a2_a_areg0_I : cyclone_lcell 
-- Equation(s):
-- inst10_aout_1reg_a2_a_areg0 = DFFEA(inst_aI4_adata_ox_a2_a_a5, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst10_ai_a74, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a2_a_a5,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst10_ai_a74,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst10_aout_1reg_a2_a_areg0);

inst10_aout_1reg_a1_a_areg0_I : cyclone_lcell 
-- Equation(s):
-- inst10_aout_1reg_a1_a_areg0 = DFFEA(inst_aI4_adata_ox_a1_a_a6, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst10_ai_a74, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datac => inst_aI4_adata_ox_a1_a_a6,
	aclr => NOT_nRESET_acombout,
	sload => VCC,
	ena => inst10_ai_a74,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst10_aout_1reg_a1_a_areg0);

inst10_aout_1reg_a0_a_areg0_I : cyclone_lcell 
-- Equation(s):
-- inst10_aout_1reg_a0_a_areg0 = DFFEA(inst_aI4_adata_ox_a0_a_a7, GLOBAL(UCLK_acombout), GLOBAL(nRESET_acombout), , inst10_ai_a74, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => UCLK_acombout,
	datad => inst_aI4_adata_ox_a0_a_a7,
	aclr => NOT_nRESET_acombout,
	ena => inst10_ai_a74,
	devclrn => devclrn,
	devpor => devpor,
	regout => inst10_aout_1reg_a0_a_areg0);

TXD_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => NOT_inst1_atx_uart_areg0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_TXD);

PORTB_OUT_a7_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => inst10_aout_1reg_a7_a_areg0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTB_OUT(7));

PORTB_OUT_a6_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => inst10_aout_1reg_a6_a_areg0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTB_OUT(6));

PORTB_OUT_a5_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => inst10_aout_1reg_a5_a_areg0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTB_OUT(5));

PORTB_OUT_a4_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => inst10_aout_1reg_a4_a_areg0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTB_OUT(4));

PORTB_OUT_a3_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => inst10_aout_1reg_a3_a_areg0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTB_OUT(3));

PORTB_OUT_a2_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => inst10_aout_1reg_a2_a_areg0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTB_OUT(2));

PORTB_OUT_a1_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => inst10_aout_1reg_a1_a_areg0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTB_OUT(1));

PORTB_OUT_a0_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => inst10_aout_1reg_a0_a_areg0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTB_OUT(0));

PORTA_OUT_a7_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => inst10_aout_0reg_a7_a_areg0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTA_OUT(7));

PORTA_OUT_a6_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => inst10_aout_0reg_a6_a_areg0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTA_OUT(6));

PORTA_OUT_a5_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => inst10_aout_0reg_a5_a_areg0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTA_OUT(5));

PORTA_OUT_a4_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => inst10_aout_0reg_a4_a_areg0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTA_OUT(4));

PORTA_OUT_a3_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => inst10_aout_0reg_a3_a_areg0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTA_OUT(3));

PORTA_OUT_a2_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => inst10_aout_0reg_a2_a_areg0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTA_OUT(2));

PORTA_OUT_a1_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => inst10_aout_0reg_a1_a_areg0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTA_OUT(1));

PORTA_OUT_a0_a_aI : cyclone_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	input_register_mode => "none",
	output_register_mode => "none",
	oe_register_mode => "none",
	input_async_reset => "none",
	output_async_reset => "none",
	oe_async_reset => "none",
	input_sync_reset => "none",
	output_sync_reset => "none",
	oe_sync_reset => "none",
	input_power_up => "low",
	output_power_up => "low",
	oe_power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => inst10_aout_0reg_a0_a_areg0,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_PORTA_OUT(0));
END structure;


