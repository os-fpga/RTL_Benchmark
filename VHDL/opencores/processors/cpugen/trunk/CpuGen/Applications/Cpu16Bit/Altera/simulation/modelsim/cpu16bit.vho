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

-- DATE "02/25/2004 23:17:32"

--
-- Device: Altera EP1C3T100C8 Package TQFP100
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL output from Quartus II) only
-- 

LIBRARY IEEE, cyclone;
USE IEEE.std_logic_1164.all;
USE cyclone.cyclone_components.all;

ENTITY 	cpu16bit IS
    PORT (
	nreset_in : IN std_logic;
	clk_in : IN std_logic;
	cpu_int : IN std_logic;
	DATA_IN_EXT : IN std_logic_vector(15 DOWNTO 0);
	NRE_EXT : OUT std_logic;
	NWE_EXT : OUT std_logic;
	NCS_EXT : OUT std_logic;
	ADDR_OUT_EXT : OUT std_logic_vector(9 DOWNTO 0);
	DATA_OUT_EXT : OUT std_logic_vector(15 DOWNTO 0)
	);
END cpu16bit;

ARCHITECTURE structure OF cpu16bit IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL devoe : std_logic := '0';
SIGNAL ww_nreset_in : std_logic;
SIGNAL ww_clk_in : std_logic;
SIGNAL ww_cpu_int : std_logic;
SIGNAL ww_DATA_IN_EXT : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_NRE_EXT : std_logic;
SIGNAL ww_NWE_EXT : std_logic;
SIGNAL ww_NCS_EXT : std_logic;
SIGNAL ww_ADDR_OUT_EXT : std_logic_vector(9 DOWNTO 0);
SIGNAL ww_DATA_OUT_EXT : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst|altsyncram_component|ram_block[0][13]_aaddress\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst|altsyncram_component|ram_block[0][13]_adatain\ : std_logic_vector(143 DOWNTO 0);
SIGNAL \ww_inst|altsyncram_component|ram_block[0][13]_adataout\ : std_logic_vector(143 DOWNTO 0);
SIGNAL \ww_inst|altsyncram_component|ram_block[0][7]_aaddress\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst|altsyncram_component|ram_block[0][7]_adatain\ : std_logic_vector(143 DOWNTO 0);
SIGNAL \ww_inst|altsyncram_component|ram_block[0][7]_adataout\ : std_logic_vector(143 DOWNTO 0);
SIGNAL \ww_inst|altsyncram_component|ram_block[0][11]_aaddress\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst|altsyncram_component|ram_block[0][11]_adatain\ : std_logic_vector(143 DOWNTO 0);
SIGNAL \ww_inst|altsyncram_component|ram_block[0][11]_adataout\ : std_logic_vector(143 DOWNTO 0);
SIGNAL \ww_inst|altsyncram_component|ram_block[0][2]_aaddress\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst|altsyncram_component|ram_block[0][2]_adatain\ : std_logic_vector(143 DOWNTO 0);
SIGNAL \ww_inst|altsyncram_component|ram_block[0][2]_adataout\ : std_logic_vector(143 DOWNTO 0);
SIGNAL \ww_inst11|inst1|altsyncram_component|ram_block[0][0]_aaddress\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst11|inst1|altsyncram_component|ram_block[0][0]_adatain\ : std_logic_vector(143 DOWNTO 0);
SIGNAL \ww_inst11|inst1|altsyncram_component|ram_block[0][0]_adataout\ : std_logic_vector(143 DOWNTO 0);
SIGNAL \inst1|I3|add_185~0COUT\ : std_logic;
SIGNAL \inst1|I3|add_185~1COUT\ : std_logic;
SIGNAL \inst1|I3|add_185~3COUT\ : std_logic;
SIGNAL \inst1|I3|add_185~4COUT\ : std_logic;
SIGNAL \inst1|I3|add_185~5COUT\ : std_logic;
SIGNAL \inst1|I3|add_185~6COUT\ : std_logic;
SIGNAL \inst1|I3|add_185~8COUT\ : std_logic;
SIGNAL \inst1|I3|add_185~9COUT\ : std_logic;
SIGNAL \inst1|I3|add_185~10COUT\ : std_logic;
SIGNAL \inst1|I3|add_185~11COUT\ : std_logic;
SIGNAL \inst1|I3|add_185~13COUT\ : std_logic;
SIGNAL \inst1|I3|add_185~14COUT\ : std_logic;
SIGNAL \inst1|I3|add_185~15COUT\ : std_logic;
SIGNAL \inst1|I3|add_225~1COUT\ : std_logic;
SIGNAL \inst1|I3|add_225~2COUT\ : std_logic;
SIGNAL \inst1|I3|add_225~4COUT\ : std_logic;
SIGNAL \inst1|I3|add_225~5COUT\ : std_logic;
SIGNAL \inst1|I3|add_225~6COUT\ : std_logic;
SIGNAL \inst1|I3|add_225~7COUT\ : std_logic;
SIGNAL \inst1|I3|add_225~9COUT\ : std_logic;
SIGNAL \inst1|I3|add_225~10COUT\ : std_logic;
SIGNAL \inst1|I3|add_225~11COUT\ : std_logic;
SIGNAL \inst1|I3|add_225~12COUT\ : std_logic;
SIGNAL \inst1|I3|add_225~14COUT\ : std_logic;
SIGNAL \inst1|I3|add_225~15COUT\ : std_logic;
SIGNAL \inst1|I3|add_225~16COUT\ : std_logic;
SIGNAL \inst1|I4|add_205~1COUT\ : std_logic;
SIGNAL \inst1|I4|add_205~2COUT\ : std_logic;
SIGNAL \inst1|I4|add_205~3COUT\ : std_logic;
SIGNAL \inst1|I4|add_205~4COUT\ : std_logic;
SIGNAL \inst1|I4|add_205~6COUT\ : std_logic;
SIGNAL \inst1|I4|add_205~7COUT\ : std_logic;
SIGNAL \inst1|I4|add_205~8COUT\ : std_logic;
SIGNAL \inst1|I4|add_205~9COUT\ : std_logic;
SIGNAL \inst4|nwait_c[0]~COUT\ : std_logic;
SIGNAL \inst4|nwait_c[1]~COUT\ : std_logic;
SIGNAL \inst4|nwait_c[2]~COUT\ : std_logic;
SIGNAL \inst4|nwait_c[3]~COUT\ : std_logic;
SIGNAL \inst4|nwait_c[5]~COUT\ : std_logic;
SIGNAL \inst4|nwait_c[6]~COUT\ : std_logic;
SIGNAL \inst1|I1|add_27~0COUT\ : std_logic;
SIGNAL \inst1|I1|add_27~1COUT\ : std_logic;
SIGNAL \inst1|I1|add_27~2COUT\ : std_logic;
SIGNAL \inst1|I1|add_27~3COUT\ : std_logic;
SIGNAL \inst1|I1|add_27~5COUT\ : std_logic;
SIGNAL \inst1|I1|add_27~6COUT\ : std_logic;
SIGNAL \inst1|I1|add_27~7COUT\ : std_logic;
SIGNAL \inst1|I1|add_27~8COUT\ : std_logic;
SIGNAL \inst11|inst8|add_15~0COUT\ : std_logic;
SIGNAL \inst11|inst8|add_15~0\ : std_logic;
SIGNAL \inst11|inst8|add_15~1COUT\ : std_logic;
SIGNAL \inst11|inst8|add_15~2COUT\ : std_logic;
SIGNAL \inst11|inst8|add_15~3COUT\ : std_logic;
SIGNAL \inst11|inst8|add_15~5COUT\ : std_logic;
SIGNAL \inst11|inst8|add_15~6COUT\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~0COUT\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~1COUT\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~2COUT\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~3COUT\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~5COUT\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~6COUT\ : std_logic;
SIGNAL \inst1|I1|nreset_v_rtl_5|wysi_counter|counter_cell[0]~COUT\ : std_logic;
SIGNAL \inst1|I4|nreset_v_rtl_4|wysi_counter|counter_cell[0]~COUT\ : std_logic;
SIGNAL \inst1|I3|nreset_v_rtl_3|wysi_counter|counter_cell[0]~COUT\ : std_logic;
SIGNAL \inst1|I2|nreset_v_rtl_2|wysi_counter|counter_cell[0]~COUT\ : std_logic;
SIGNAL \inst1|I3|skip_i\ : std_logic;
SIGNAL \inst1|I2|idata_c[1]\ : std_logic;
SIGNAL \inst1|I2|idata_c[3]\ : std_logic;
SIGNAL \inst1|I3|acc_i[0][13]\ : std_logic;
SIGNAL \inst1|I3|acc_i[0][9]\ : std_logic;
SIGNAL \inst1|I3|acc_i[0][6]\ : std_logic;
SIGNAL \inst1|I3|acc_i[0][5]\ : std_logic;
SIGNAL \inst1|I3|acc_i[0][4]\ : std_logic;
SIGNAL \inst1|I3|acc_i[0][15]\ : std_logic;
SIGNAL \inst1|I3|acc_i[0][14]\ : std_logic;
SIGNAL \inst1|I3|acc_i[0][12]\ : std_logic;
SIGNAL \inst1|I3|acc_i[0][11]\ : std_logic;
SIGNAL \inst1|I3|acc_i[0][10]\ : std_logic;
SIGNAL \inst1|I3|acc_i[0][8]\ : std_logic;
SIGNAL \inst1|I3|acc_i[0][7]\ : std_logic;
SIGNAL \inst1|I3|acc_i[0][3]\ : std_logic;
SIGNAL \inst1|I3|acc_i[0][2]\ : std_logic;
SIGNAL \inst1|I3|acc_i[0][1]\ : std_logic;
SIGNAL \inst1|I3|acc_i[0][0]\ : std_logic;
SIGNAL \inst1|I3|acc_i[0][16]\ : std_logic;
SIGNAL \nreset_in~padio\ : std_logic;
SIGNAL \clk_in~padio\ : std_logic;
SIGNAL \cpu_int~padio\ : std_logic;
SIGNAL \DATA_IN_EXT[13]~padio\ : std_logic;
SIGNAL \DATA_IN_EXT[9]~padio\ : std_logic;
SIGNAL \DATA_IN_EXT[6]~padio\ : std_logic;
SIGNAL \DATA_IN_EXT[5]~padio\ : std_logic;
SIGNAL \DATA_IN_EXT[4]~padio\ : std_logic;
SIGNAL \DATA_IN_EXT[15]~padio\ : std_logic;
SIGNAL \DATA_IN_EXT[14]~padio\ : std_logic;
SIGNAL \DATA_IN_EXT[12]~padio\ : std_logic;
SIGNAL \DATA_IN_EXT[11]~padio\ : std_logic;
SIGNAL \DATA_IN_EXT[10]~padio\ : std_logic;
SIGNAL \DATA_IN_EXT[8]~padio\ : std_logic;
SIGNAL \DATA_IN_EXT[7]~padio\ : std_logic;
SIGNAL \DATA_IN_EXT[3]~padio\ : std_logic;
SIGNAL \DATA_IN_EXT[2]~padio\ : std_logic;
SIGNAL \DATA_IN_EXT[1]~padio\ : std_logic;
SIGNAL \DATA_IN_EXT[0]~padio\ : std_logic;
SIGNAL \NRE_EXT~padio\ : std_logic;
SIGNAL \NWE_EXT~padio\ : std_logic;
SIGNAL \NCS_EXT~padio\ : std_logic;
SIGNAL \ADDR_OUT_EXT[9]~padio\ : std_logic;
SIGNAL \ADDR_OUT_EXT[8]~padio\ : std_logic;
SIGNAL \ADDR_OUT_EXT[7]~padio\ : std_logic;
SIGNAL \ADDR_OUT_EXT[6]~padio\ : std_logic;
SIGNAL \ADDR_OUT_EXT[5]~padio\ : std_logic;
SIGNAL \ADDR_OUT_EXT[4]~padio\ : std_logic;
SIGNAL \ADDR_OUT_EXT[3]~padio\ : std_logic;
SIGNAL \ADDR_OUT_EXT[2]~padio\ : std_logic;
SIGNAL \ADDR_OUT_EXT[1]~padio\ : std_logic;
SIGNAL \ADDR_OUT_EXT[0]~padio\ : std_logic;
SIGNAL \DATA_OUT_EXT[15]~padio\ : std_logic;
SIGNAL \DATA_OUT_EXT[14]~padio\ : std_logic;
SIGNAL \DATA_OUT_EXT[13]~padio\ : std_logic;
SIGNAL \DATA_OUT_EXT[12]~padio\ : std_logic;
SIGNAL \DATA_OUT_EXT[11]~padio\ : std_logic;
SIGNAL \DATA_OUT_EXT[10]~padio\ : std_logic;
SIGNAL \DATA_OUT_EXT[9]~padio\ : std_logic;
SIGNAL \DATA_OUT_EXT[8]~padio\ : std_logic;
SIGNAL \DATA_OUT_EXT[7]~padio\ : std_logic;
SIGNAL \DATA_OUT_EXT[6]~padio\ : std_logic;
SIGNAL \DATA_OUT_EXT[5]~padio\ : std_logic;
SIGNAL \DATA_OUT_EXT[4]~padio\ : std_logic;
SIGNAL \DATA_OUT_EXT[3]~padio\ : std_logic;
SIGNAL \DATA_OUT_EXT[2]~padio\ : std_logic;
SIGNAL \DATA_OUT_EXT[1]~padio\ : std_logic;
SIGNAL \DATA_OUT_EXT[0]~padio\ : std_logic;
SIGNAL \nreset_in~combout\ : std_logic;
SIGNAL \clk_in~combout\ : std_logic;
SIGNAL \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]\ : std_logic;
SIGNAL \inst1|I4|LessThan_79~5\ : std_logic;
SIGNAL \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]~COUT0\ : std_logic;
SIGNAL \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]~COUT1\ : std_logic;
SIGNAL \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ : std_logic;
SIGNAL \~GND\ : std_logic;
SIGNAL \inst4|nwait_c[0]\ : std_logic;
SIGNAL \inst4|nwait_c[0]~COUT0\ : std_logic;
SIGNAL \inst4|nwait_c[0]~COUT1\ : std_logic;
SIGNAL \inst4|nwait_c[1]\ : std_logic;
SIGNAL \inst4|nwait_c[1]~COUT0\ : std_logic;
SIGNAL \inst4|nwait_c[1]~COUT1\ : std_logic;
SIGNAL \inst4|nwait_c[2]\ : std_logic;
SIGNAL \inst4|nwait_c[2]~COUT0\ : std_logic;
SIGNAL \inst4|nwait_c[2]~COUT1\ : std_logic;
SIGNAL \inst4|nwait_c[3]\ : std_logic;
SIGNAL \inst4|nwait_c[3]~COUT0\ : std_logic;
SIGNAL \inst4|nwait_c[3]~COUT1\ : std_logic;
SIGNAL \inst4|nwait_c[4]\ : std_logic;
SIGNAL \inst4|nwait_c[4]~COUT\ : std_logic;
SIGNAL \inst4|nwait_c[5]\ : std_logic;
SIGNAL \inst4|nwait_c[5]~COUT0\ : std_logic;
SIGNAL \inst4|nwait_c[5]~COUT1\ : std_logic;
SIGNAL \inst4|nwait_c[6]\ : std_logic;
SIGNAL \inst4|nwait_c[6]~COUT0\ : std_logic;
SIGNAL \inst4|nwait_c[6]~COUT1\ : std_logic;
SIGNAL \inst4|nwait_c[7]\ : std_logic;
SIGNAL \inst4|reduce_or_23~25\ : std_logic;
SIGNAL \inst4|reduce_or_23~0\ : std_logic;
SIGNAL \inst4|reduce_or_23\ : std_logic;
SIGNAL \inst1|I4|i~38\ : std_logic;
SIGNAL \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]~COUT0\ : std_logic;
SIGNAL \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]~COUT1\ : std_logic;
SIGNAL \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[1]\ : std_logic;
SIGNAL \inst1|I3|i~195\ : std_logic;
SIGNAL \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]\ : std_logic;
SIGNAL \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]\ : std_logic;
SIGNAL \inst1|I2|LessThan_7~5\ : std_logic;
SIGNAL \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]~COUT0\ : std_logic;
SIGNAL \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]~COUT1\ : std_logic;
SIGNAL \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\ : std_logic;
SIGNAL \inst1|I2|i~413\ : std_logic;
SIGNAL \inst2|dwait_c\ : std_logic;
SIGNAL \inst1|I4|ndwe_x~10\ : std_logic;
SIGNAL \inst1|I2|pc_mux_x[2]~233\ : std_logic;
SIGNAL \inst1|I2|TC_c[1]\ : std_logic;
SIGNAL \cpu_int~combout\ : std_logic;
SIGNAL \inst1|I2|S_x.normal~6\ : std_logic;
SIGNAL \inst1|I2|S_c~10\ : std_logic;
SIGNAL \inst1|I2|pc_mux_x[2]~234\ : std_logic;
SIGNAL \inst1|I2|i~411\ : std_logic;
SIGNAL \inst1|I2|i~412\ : std_logic;
SIGNAL \inst1|I2|i~284\ : std_logic;
SIGNAL \inst1|I2|int_stop_c\ : std_logic;
SIGNAL \inst1|I2|S_c~9\ : std_logic;
SIGNAL \inst1|I2|E_x.int_e~67\ : std_logic;
SIGNAL \inst1|I2|E_x.int_e~23\ : std_logic;
SIGNAL \inst1|I2|int_start_c\ : std_logic;
SIGNAL \inst1|I3|i~161\ : std_logic;
SIGNAL \rtl~13740\ : std_logic;
SIGNAL \inst1|I2|idata_c[0]\ : std_logic;
SIGNAL \rtl~13594\ : std_logic;
SIGNAL \inst1|I2|int_stop_x~11\ : std_logic;
SIGNAL \inst1|I3|reduce_nor_95\ : std_logic;
SIGNAL \inst1|I2|data_is_c[3]\ : std_logic;
SIGNAL \inst1|I4|dexp_we_c\ : std_logic;
SIGNAL \inst1|I4|ireg_i[9]~1\ : std_logic;
SIGNAL \inst1|I4|data_exp_x[3]~5\ : std_logic;
SIGNAL \inst1|I4|data_exp_i[3]\ : std_logic;
SIGNAL \inst1|I4|data_exp_c[3]\ : std_logic;
SIGNAL \inst1|I4|iinc_i[3]\ : std_logic;
SIGNAL \inst1|I4|iinc_x[3]~26\ : std_logic;
SIGNAL \inst1|I4|iinc_c[3]\ : std_logic;
SIGNAL \inst1|I4|reduce_nor_207\ : std_logic;
SIGNAL \inst1|I3|data_x[9]~3459\ : std_logic;
SIGNAL \inst1|I3|data_x[3]~3886\ : std_logic;
SIGNAL \inst1|I3|data_x[9]~3457\ : std_logic;
SIGNAL \inst1|I3|data_x[6]~3461\ : std_logic;
SIGNAL \inst1|I4|i~2618\ : std_logic;
SIGNAL \inst1|I3|data_x[9]~3458\ : std_logic;
SIGNAL \inst1|I3|data_x[3]~3093\ : std_logic;
SIGNAL \DATA_IN_EXT[3]~combout\ : std_logic;
SIGNAL \DATA_IN_EXT[13]~combout\ : std_logic;
SIGNAL \inst1|I4|iinc_i[7]\ : std_logic;
SIGNAL \inst1|I4|iinc_x[7]~23\ : std_logic;
SIGNAL \inst1|I4|iinc_c[7]\ : std_logic;
SIGNAL \inst1|I2|data_is_c[5]\ : std_logic;
SIGNAL \DATA_IN_EXT[5]~combout\ : std_logic;
SIGNAL \inst1|I3|data_x[6]~329\ : std_logic;
SIGNAL \inst1|I3|data_x[6]~3456\ : std_logic;
SIGNAL \inst1|I3|data_x[5]~447\ : std_logic;
SIGNAL \inst1|I4|iadata_x[17]~8\ : std_logic;
SIGNAL \inst1|I4|data_exp_i[5]\ : std_logic;
SIGNAL \inst1|I4|data_exp_c[5]\ : std_logic;
SIGNAL \inst1|I2|Mux_77~0\ : std_logic;
SIGNAL \inst1|I2|TD_c[1]\ : std_logic;
SIGNAL \rtl~13595\ : std_logic;
SIGNAL \DATA_IN_EXT[15]~combout\ : std_logic;
SIGNAL \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]\ : std_logic;
SIGNAL \inst1|I1|LessThan_7~5\ : std_logic;
SIGNAL \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]~COUT0\ : std_logic;
SIGNAL \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]~COUT1\ : std_logic;
SIGNAL \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\ : std_logic;
SIGNAL \inst1|I1|i~2\ : std_logic;
SIGNAL \inst1|I2|pc_mux_x[2]~236\ : std_logic;
SIGNAL \inst1|I2|pc_mux_x[2]~352\ : std_logic;
SIGNAL \inst1|I2|i~105\ : std_logic;
SIGNAL \inst1|I2|pc_mux_x[2]~26\ : std_logic;
SIGNAL \inst1|I2|pc_mux_x[1]~346\ : std_logic;
SIGNAL \inst1|I2|reduce_nor_136\ : std_logic;
SIGNAL \inst1|I2|pc_mux_x[1]~328\ : std_logic;
SIGNAL \inst1|I2|i~9\ : std_logic;
SIGNAL \inst1|I2|pc_mux_x[1]~49\ : std_logic;
SIGNAL \inst1|I2|ndre_x~50\ : std_logic;
SIGNAL \inst1|I2|pc_mux_x[0]~282\ : std_logic;
SIGNAL \inst1|I2|pc_mux_x[0]~161\ : std_logic;
SIGNAL \inst1|I2|pc_mux_x[0]~158\ : std_logic;
SIGNAL \inst1|I2|pc_mux_x[0]~171\ : std_logic;
SIGNAL \inst1|I2|pc_mux_x[0]~167\ : std_logic;
SIGNAL \inst1|I1|Mux_41_rtl_211~0\ : std_logic;
SIGNAL \inst1|I1|i~17\ : std_logic;
SIGNAL \inst1|I1|Mux_67~8\ : std_logic;
SIGNAL \inst11|inst8|addr_c[0]\ : std_logic;
SIGNAL \inst1|I1|i~18\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~0\ : std_logic;
SIGNAL \inst11|inst8|add_15_rtl_597~10\ : std_logic;
SIGNAL \inst11|inst8|addr_c[1]\ : std_logic;
SIGNAL \inst11|inst8|add_15~0COUT0\ : std_logic;
SIGNAL \inst11|inst8|add_15~0COUT1\ : std_logic;
SIGNAL \inst11|inst8|add_15~1\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~0COUT0\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~0COUT1\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~1\ : std_logic;
SIGNAL \inst11|inst8|add_15_rtl_597~13\ : std_logic;
SIGNAL \inst11|inst8|addr_c[2]\ : std_logic;
SIGNAL \inst11|inst8|add_15~1COUT0\ : std_logic;
SIGNAL \inst11|inst8|add_15~1COUT1\ : std_logic;
SIGNAL \inst11|inst8|add_15~2\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~1COUT0\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~1COUT1\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~2\ : std_logic;
SIGNAL \inst11|inst8|add_15_rtl_597~16\ : std_logic;
SIGNAL \inst11|inst8|addr_c[3]\ : std_logic;
SIGNAL \inst11|inst8|add_15~2COUT0\ : std_logic;
SIGNAL \inst11|inst8|add_15~2COUT1\ : std_logic;
SIGNAL \inst11|inst8|add_15~3\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~2COUT0\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~2COUT1\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~3\ : std_logic;
SIGNAL \inst11|inst8|add_15_rtl_597~19\ : std_logic;
SIGNAL \inst11|inst8|addr_c[4]\ : std_logic;
SIGNAL \inst11|inst8|add_15~3COUT0\ : std_logic;
SIGNAL \inst11|inst8|add_15~3COUT1\ : std_logic;
SIGNAL \inst11|inst8|add_15~4\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~3COUT0\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~3COUT1\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~4\ : std_logic;
SIGNAL \inst11|inst8|add_15_rtl_597~22\ : std_logic;
SIGNAL \inst11|inst8|addr_c[5]\ : std_logic;
SIGNAL \inst11|inst8|add_15~4COUT\ : std_logic;
SIGNAL \inst11|inst8|add_15~5\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~4COUT\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~5\ : std_logic;
SIGNAL \inst11|inst8|add_15_rtl_597~25\ : std_logic;
SIGNAL \inst11|inst8|addr_c[6]\ : std_logic;
SIGNAL \inst11|inst8|add_15~5COUT0\ : std_logic;
SIGNAL \inst11|inst8|add_15~5COUT1\ : std_logic;
SIGNAL \inst11|inst8|add_15~6\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~5COUT0\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~5COUT1\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~6\ : std_logic;
SIGNAL \inst11|inst8|add_15_rtl_597~28\ : std_logic;
SIGNAL \inst11|inst8|addr_c[7]\ : std_logic;
SIGNAL \inst11|inst8|add_15~6COUT0\ : std_logic;
SIGNAL \inst11|inst8|add_15~6COUT1\ : std_logic;
SIGNAL \inst11|inst8|add_15~7\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~6COUT0\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~6COUT1\ : std_logic;
SIGNAL \inst11|inst8|add_17_rtl_0~7\ : std_logic;
SIGNAL \inst11|inst8|add_15_rtl_597~31\ : std_logic;
SIGNAL \rtl~2482\ : std_logic;
SIGNAL \inst1|I1|pc[9]\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[4]~1824\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[3]~120\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[3]~1801\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[3]~1716\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[3]~1715\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[1]~344\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[0]~302\ : std_logic;
SIGNAL \inst1|I1|add_27~0\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[0]~304\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[0]~301\ : std_logic;
SIGNAL \inst1|I1|pc[0]\ : std_logic;
SIGNAL \inst1|I1|add_27~0COUT0\ : std_logic;
SIGNAL \inst1|I1|add_27~0COUT1\ : std_logic;
SIGNAL \inst1|I1|add_27~1\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[1]~346\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[1]~343\ : std_logic;
SIGNAL \inst1|I1|pc[1]\ : std_logic;
SIGNAL \inst1|I1|add_27~1COUT0\ : std_logic;
SIGNAL \inst1|I1|add_27~1COUT1\ : std_logic;
SIGNAL \inst1|I1|add_27~2\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[2]~388\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[2]~1783\ : std_logic;
SIGNAL \inst1|I1|pc[2]\ : std_logic;
SIGNAL \inst1|I1|add_27~2COUT0\ : std_logic;
SIGNAL \inst1|I1|add_27~2COUT1\ : std_logic;
SIGNAL \inst1|I1|add_27~3\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[3]~189\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[3]~1806\ : std_logic;
SIGNAL \inst1|I1|pc[3]\ : std_logic;
SIGNAL \inst1|I1|add_27~3COUT0\ : std_logic;
SIGNAL \inst1|I1|add_27~3COUT1\ : std_logic;
SIGNAL \inst1|I1|add_27~4\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[4]~205\ : std_logic;
SIGNAL \inst1|I1|pc[4]\ : std_logic;
SIGNAL \inst1|I1|add_27~4COUT\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[6]~1870\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[5]~1847\ : std_logic;
SIGNAL \inst1|I1|add_27~5\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[5]~215\ : std_logic;
SIGNAL \inst1|I1|pc[5]\ : std_logic;
SIGNAL \inst1|I1|add_27~5COUT0\ : std_logic;
SIGNAL \inst1|I1|add_27~5COUT1\ : std_logic;
SIGNAL \inst1|I1|add_27~6\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[6]~225\ : std_logic;
SIGNAL \inst1|I1|pc[6]\ : std_logic;
SIGNAL \inst1|I1|add_27~6COUT0\ : std_logic;
SIGNAL \inst1|I1|add_27~6COUT1\ : std_logic;
SIGNAL \inst1|I1|add_27~7\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[7]~235\ : std_logic;
SIGNAL \inst1|I4|data_ox[15]~4\ : std_logic;
SIGNAL \inst1|I4|data_exp_i[2]\ : std_logic;
SIGNAL \inst1|I4|data_exp_c[2]\ : std_logic;
SIGNAL \inst1|I4|data_exp_x[2]~8\ : std_logic;
SIGNAL \DATA_IN_EXT[14]~combout\ : std_logic;
SIGNAL \inst1|I3|data_x[14]~92\ : std_logic;
SIGNAL \inst1|I3|data_x[13]~3460\ : std_logic;
SIGNAL \inst1|I3|data_x[14]~97\ : std_logic;
SIGNAL \rtl~1541\ : std_logic;
SIGNAL \rtl~13592\ : std_logic;
SIGNAL \inst1|I3|Mux_297_rtl_171~0\ : std_logic;
SIGNAL \rtl~2571\ : std_logic;
SIGNAL \rtl~2760\ : std_logic;
SIGNAL \rtl~2246\ : std_logic;
SIGNAL \rtl~13596\ : std_logic;
SIGNAL \rtl~13900\ : std_logic;
SIGNAL \inst1|I4|data_exp_i[0]\ : std_logic;
SIGNAL \inst1|I4|data_exp_c[0]\ : std_logic;
SIGNAL \inst1|I4|data_exp_x[0]~11\ : std_logic;
SIGNAL \DATA_IN_EXT[12]~combout\ : std_logic;
SIGNAL \inst1|I3|data_x[12]~102\ : std_logic;
SIGNAL \inst1|I3|data_x[12]~107\ : std_logic;
SIGNAL \rtl~1576\ : std_logic;
SIGNAL \rtl~2582\ : std_logic;
SIGNAL \rtl~2770\ : std_logic;
SIGNAL \rtl~2261\ : std_logic;
SIGNAL \inst1|I2|data_is_c[7]\ : std_logic;
SIGNAL \inst1|I4|iadata_x[19]~23\ : std_logic;
SIGNAL \inst1|I4|data_exp_i[7]\ : std_logic;
SIGNAL \inst1|I4|data_exp_c[7]\ : std_logic;
SIGNAL \inst1|I3|data_x[7]~3844\ : std_logic;
SIGNAL \inst1|I3|data_x[7]~2987\ : std_logic;
SIGNAL \DATA_IN_EXT[7]~combout\ : std_logic;
SIGNAL \inst1|I3|data_x[7]~1047\ : std_logic;
SIGNAL \inst1|I3|data_x[7]~3872\ : std_logic;
SIGNAL \inst1|I2|data_is_c[2]\ : std_logic;
SIGNAL \inst1|I3|data_x[2]~3928\ : std_logic;
SIGNAL \inst1|I3|data_x[2]~3199\ : std_logic;
SIGNAL \DATA_IN_EXT[2]~combout\ : std_logic;
SIGNAL \inst1|I3|data_x[2]~1251\ : std_logic;
SIGNAL \inst1|I3|data_x[2]~3956\ : std_logic;
SIGNAL \inst1|I2|data_is_c[1]\ : std_logic;
SIGNAL \inst1|I4|data_exp_i[1]\ : std_logic;
SIGNAL \inst1|I4|data_exp_x[1]~2\ : std_logic;
SIGNAL \inst1|I4|data_exp_c[1]\ : std_logic;
SIGNAL \inst1|I4|iinc_i[1]\ : std_logic;
SIGNAL \inst1|I4|iinc_x[1]~32\ : std_logic;
SIGNAL \inst1|I4|iinc_c[1]\ : std_logic;
SIGNAL \inst1|I3|data_x[1]~3970\ : std_logic;
SIGNAL \inst1|I3|data_x[1]~3305\ : std_logic;
SIGNAL \DATA_IN_EXT[1]~combout\ : std_logic;
SIGNAL \inst1|I3|data_x[1]~1353\ : std_logic;
SIGNAL \inst1|I3|data_x[1]~3998\ : std_logic;
SIGNAL \inst1|I2|data_is_c[0]\ : std_logic;
SIGNAL \inst1|I3|data_x[0]~4012\ : std_logic;
SIGNAL \inst1|I3|data_x[0]~3411\ : std_logic;
SIGNAL \DATA_IN_EXT[0]~combout\ : std_logic;
SIGNAL \inst1|I3|data_x[0]~1455\ : std_logic;
SIGNAL \inst1|I3|data_x[0]~4040\ : std_logic;
SIGNAL \inst1|I3|add_225~1COUT0\ : std_logic;
SIGNAL \inst1|I3|add_225~1COUT1\ : std_logic;
SIGNAL \inst1|I3|add_225~2COUT0\ : std_logic;
SIGNAL \inst1|I3|add_225~2COUT1\ : std_logic;
SIGNAL \inst1|I3|add_225~3COUT\ : std_logic;
SIGNAL \inst1|I2|data_is_c[4]\ : std_logic;
SIGNAL \DATA_IN_EXT[4]~combout\ : std_logic;
SIGNAL \inst1|I3|data_x[4]~549\ : std_logic;
SIGNAL \inst1|I4|iinc_x[4]~11\ : std_logic;
SIGNAL \inst1|I4|iinc_i[4]\ : std_logic;
SIGNAL \inst1|I4|iinc_c[4]\ : std_logic;
SIGNAL \inst1|I4|add_205~1COUT0\ : std_logic;
SIGNAL \inst1|I4|add_205~1COUT1\ : std_logic;
SIGNAL \inst1|I4|add_205~2COUT0\ : std_logic;
SIGNAL \inst1|I4|add_205~2COUT1\ : std_logic;
SIGNAL \inst1|I4|add_205~3COUT0\ : std_logic;
SIGNAL \inst1|I4|add_205~3COUT1\ : std_logic;
SIGNAL \inst1|I4|add_205~4\ : std_logic;
SIGNAL \inst1|I4|i~2616\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~122\ : std_logic;
SIGNAL \inst1|I4|ireg_i[4]\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~127\ : std_logic;
SIGNAL \inst1|I4|ireg_c[4]\ : std_logic;
SIGNAL \inst1|I3|data_x[4]~3664\ : std_logic;
SIGNAL \inst1|I4|iadata_x[16]~11\ : std_logic;
SIGNAL \inst1|I4|data_exp_i[4]\ : std_logic;
SIGNAL \inst1|I4|data_exp_c[4]\ : std_logic;
SIGNAL \inst1|I3|data_x[4]~2473\ : std_logic;
SIGNAL \inst1|I3|data_x[4]~3692\ : std_logic;
SIGNAL \rtl~14126\ : std_logic;
SIGNAL \rtl~2549\ : std_logic;
SIGNAL \rtl~2740\ : std_logic;
SIGNAL \rtl~2745\ : std_logic;
SIGNAL \inst1|I3|add_225~4COUT0\ : std_logic;
SIGNAL \inst1|I3|add_225~4COUT1\ : std_logic;
SIGNAL \inst1|I3|add_225~5\ : std_logic;
SIGNAL \inst1|I3|add_185~0COUT0\ : std_logic;
SIGNAL \inst1|I3|add_185~0COUT1\ : std_logic;
SIGNAL \inst1|I3|add_185~1COUT0\ : std_logic;
SIGNAL \inst1|I3|add_185~1COUT1\ : std_logic;
SIGNAL \inst1|I3|add_185~2COUT\ : std_logic;
SIGNAL \inst1|I3|add_185~3COUT0\ : std_logic;
SIGNAL \inst1|I3|add_185~3COUT1\ : std_logic;
SIGNAL \inst1|I3|add_185~4\ : std_logic;
SIGNAL \inst1|I3|Mux_262_rtl_86_rtl_367~0\ : std_logic;
SIGNAL \inst1|I3|Mux_262_rtl_86_rtl_367~1\ : std_logic;
SIGNAL \rtl~14104\ : std_logic;
SIGNAL \rtl~14109\ : std_logic;
SIGNAL \inst1|I3|acc[0][4]~156\ : std_logic;
SIGNAL \inst1|I3|acc[0][4]~8234\ : std_logic;
SIGNAL \inst1|I3|acc_c[0][4]\ : std_logic;
SIGNAL \inst1|I3|add_225~5COUT0\ : std_logic;
SIGNAL \inst1|I3|add_225~5COUT1\ : std_logic;
SIGNAL \inst1|I3|add_225~6COUT0\ : std_logic;
SIGNAL \inst1|I3|add_225~6COUT1\ : std_logic;
SIGNAL \inst1|I3|add_225~7COUT0\ : std_logic;
SIGNAL \inst1|I3|add_225~7COUT1\ : std_logic;
SIGNAL \inst1|I3|add_225~8COUT\ : std_logic;
SIGNAL \inst1|I2|data_is_c[11]\ : std_logic;
SIGNAL \DATA_IN_EXT[11]~combout\ : std_logic;
SIGNAL \inst1|I3|data_x[11]~741\ : std_logic;
SIGNAL \inst1|I4|data_exp_i[11]\ : std_logic;
SIGNAL \inst1|I4|iadata_x[23]~14\ : std_logic;
SIGNAL \inst1|I4|data_exp_c[11]\ : std_logic;
SIGNAL \inst1|I4|iinc_i[11]\ : std_logic;
SIGNAL \inst1|I4|iinc_x[11]~14\ : std_logic;
SIGNAL \inst1|I4|iinc_c[11]\ : std_logic;
SIGNAL \inst1|I4|data_exp_i[10]\ : std_logic;
SIGNAL \inst1|I4|iadata_x[22]~17\ : std_logic;
SIGNAL \inst1|I4|data_exp_c[10]\ : std_logic;
SIGNAL \inst1|I4|iinc_x[10]~17\ : std_logic;
SIGNAL \inst1|I4|iinc_i[10]\ : std_logic;
SIGNAL \inst1|I4|iinc_c[10]\ : std_logic;
SIGNAL \inst1|I3|data_x[10]~3760\ : std_logic;
SIGNAL \inst1|I3|data_x[10]~2775\ : std_logic;
SIGNAL \DATA_IN_EXT[10]~combout\ : std_logic;
SIGNAL \inst1|I3|data_x[10]~843\ : std_logic;
SIGNAL \inst1|I3|data_x[10]~3788\ : std_logic;
SIGNAL \rtl~14343\ : std_logic;
SIGNAL \inst1|I2|data_is_c[9]\ : std_logic;
SIGNAL \inst1|I4|data_exp_i[9]\ : std_logic;
SIGNAL \inst1|I4|iadata_x[21]~2\ : std_logic;
SIGNAL \inst1|I4|data_exp_c[9]\ : std_logic;
SIGNAL \inst1|I4|iinc_i[9]\ : std_logic;
SIGNAL \inst1|I4|iinc_x[9]~2\ : std_logic;
SIGNAL \inst1|I4|iinc_c[9]\ : std_logic;
SIGNAL \inst1|I4|iinc_i[8]\ : std_logic;
SIGNAL \inst1|I4|iinc_x[8]~20\ : std_logic;
SIGNAL \inst1|I4|iinc_c[8]\ : std_logic;
SIGNAL \inst1|I4|iinc_i[6]\ : std_logic;
SIGNAL \inst1|I4|iinc_x[6]~5\ : std_logic;
SIGNAL \inst1|I4|iinc_c[6]\ : std_logic;
SIGNAL \inst1|I4|add_205~6COUT0\ : std_logic;
SIGNAL \inst1|I4|add_205~6COUT1\ : std_logic;
SIGNAL \inst1|I4|add_205~7COUT0\ : std_logic;
SIGNAL \inst1|I4|add_205~7COUT1\ : std_logic;
SIGNAL \inst1|I4|add_205~8COUT0\ : std_logic;
SIGNAL \inst1|I4|add_205~8COUT1\ : std_logic;
SIGNAL \inst1|I4|add_205~9\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~72\ : std_logic;
SIGNAL \inst1|I4|ireg_i[9]\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~77\ : std_logic;
SIGNAL \inst1|I4|ireg_c[9]\ : std_logic;
SIGNAL \inst1|I3|data_x[9]~3536\ : std_logic;
SIGNAL \inst1|I3|data_x[9]~2155\ : std_logic;
SIGNAL \DATA_IN_EXT[9]~combout\ : std_logic;
SIGNAL \inst1|I3|data_x[9]~243\ : std_logic;
SIGNAL \inst1|I3|data_x[9]~3566\ : std_logic;
SIGNAL \rtl~13994\ : std_logic;
SIGNAL \rtl~2710\ : std_logic;
SIGNAL \rtl~2516\ : std_logic;
SIGNAL \rtl~2715\ : std_logic;
SIGNAL \inst1|I3|add_185~4COUT0\ : std_logic;
SIGNAL \inst1|I3|add_185~4COUT1\ : std_logic;
SIGNAL \inst1|I3|add_185~5COUT0\ : std_logic;
SIGNAL \inst1|I3|add_185~5COUT1\ : std_logic;
SIGNAL \inst1|I3|add_185~6COUT0\ : std_logic;
SIGNAL \inst1|I3|add_185~6COUT1\ : std_logic;
SIGNAL \inst1|I3|add_185~7COUT\ : std_logic;
SIGNAL \inst1|I3|add_185~8COUT0\ : std_logic;
SIGNAL \inst1|I3|add_185~8COUT1\ : std_logic;
SIGNAL \inst1|I3|add_185~9\ : std_logic;
SIGNAL \inst1|I3|add_225~9COUT0\ : std_logic;
SIGNAL \inst1|I3|add_225~9COUT1\ : std_logic;
SIGNAL \inst1|I3|add_225~10\ : std_logic;
SIGNAL \inst1|I3|Mux_257_rtl_68_rtl_349~0\ : std_logic;
SIGNAL \inst1|I3|Mux_257_rtl_68_rtl_349~1\ : std_logic;
SIGNAL \rtl~13972\ : std_logic;
SIGNAL \rtl~13977\ : std_logic;
SIGNAL \inst1|I3|acc[0][9]~126\ : std_logic;
SIGNAL \inst1|I3|acc[0][9]~8204\ : std_logic;
SIGNAL \inst1|I3|acc_c[0][9]\ : std_logic;
SIGNAL \rtl~2790\ : std_logic;
SIGNAL \rtl~2604\ : std_logic;
SIGNAL \rtl~2795\ : std_logic;
SIGNAL \inst1|I3|add_185~9COUT0\ : std_logic;
SIGNAL \inst1|I3|add_185~9COUT1\ : std_logic;
SIGNAL \inst1|I3|add_185~10\ : std_logic;
SIGNAL \inst1|I3|add_225~10COUT0\ : std_logic;
SIGNAL \inst1|I3|add_225~10COUT1\ : std_logic;
SIGNAL \inst1|I3|add_225~11\ : std_logic;
SIGNAL \inst1|I3|Mux_256_rtl_116_rtl_397~0\ : std_logic;
SIGNAL \inst1|I3|Mux_256_rtl_116_rtl_397~1\ : std_logic;
SIGNAL \rtl~14321\ : std_logic;
SIGNAL \rtl~14326\ : std_logic;
SIGNAL \inst1|I3|acc[0][10]~206\ : std_logic;
SIGNAL \inst1|I3|acc[0][10]~8284\ : std_logic;
SIGNAL \inst1|I3|acc_c[0][10]\ : std_logic;
SIGNAL \inst1|I4|add_205~9COUT0\ : std_logic;
SIGNAL \inst1|I4|add_205~9COUT1\ : std_logic;
SIGNAL \inst1|I4|add_205~10\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~182\ : std_logic;
SIGNAL \inst1|I4|ireg_i[10]\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~187\ : std_logic;
SIGNAL \inst1|I4|ireg_c[10]\ : std_logic;
SIGNAL \inst1|I4|add_205~10COUT\ : std_logic;
SIGNAL \inst1|I4|add_205~11\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~172\ : std_logic;
SIGNAL \inst1|I4|ireg_i[11]\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~177\ : std_logic;
SIGNAL \inst1|I4|ireg_c[11]\ : std_logic;
SIGNAL \inst1|I3|data_x[11]~3718\ : std_logic;
SIGNAL \inst1|I3|data_x[11]~2669\ : std_logic;
SIGNAL \inst1|I3|data_x[11]~3746\ : std_logic;
SIGNAL \inst1|I3|add_225~11COUT0\ : std_logic;
SIGNAL \inst1|I3|add_225~11COUT1\ : std_logic;
SIGNAL \inst1|I3|add_225~12COUT0\ : std_logic;
SIGNAL \inst1|I3|add_225~12COUT1\ : std_logic;
SIGNAL \inst1|I3|add_225~13\ : std_logic;
SIGNAL \inst1|I3|add_185~10COUT0\ : std_logic;
SIGNAL \inst1|I3|add_185~10COUT1\ : std_logic;
SIGNAL \inst1|I3|add_185~11COUT0\ : std_logic;
SIGNAL \inst1|I3|add_185~11COUT1\ : std_logic;
SIGNAL \inst1|I3|add_185~12\ : std_logic;
SIGNAL \inst1|I3|Mux_254_rtl_104_rtl_385~0\ : std_logic;
SIGNAL \inst1|I3|Mux_254_rtl_104_rtl_385~1\ : std_logic;
SIGNAL \rtl~14234\ : std_logic;
SIGNAL \rtl~14256\ : std_logic;
SIGNAL \inst1|I3|acc[0][12]~186\ : std_logic;
SIGNAL \inst1|I3|acc[0][12]~8264\ : std_logic;
SIGNAL \inst1|I3|acc_c[0][12]\ : std_logic;
SIGNAL \inst1|I3|add_225~13COUT\ : std_logic;
SIGNAL \inst1|I3|add_225~14COUT0\ : std_logic;
SIGNAL \inst1|I3|add_225~14COUT1\ : std_logic;
SIGNAL \inst1|I3|add_225~15\ : std_logic;
SIGNAL \inst1|I3|add_185~12COUT\ : std_logic;
SIGNAL \inst1|I3|add_185~13COUT0\ : std_logic;
SIGNAL \inst1|I3|add_185~13COUT1\ : std_logic;
SIGNAL \inst1|I3|add_185~14\ : std_logic;
SIGNAL \inst1|I3|Mux_252_rtl_98_rtl_379~0\ : std_logic;
SIGNAL \inst1|I3|Mux_252_rtl_98_rtl_379~1\ : std_logic;
SIGNAL \rtl~14191\ : std_logic;
SIGNAL \rtl~14213\ : std_logic;
SIGNAL \inst1|I3|acc[0][14]~176\ : std_logic;
SIGNAL \inst1|I3|acc[0][14]~8254\ : std_logic;
SIGNAL \inst1|I3|acc_c[0][14]\ : std_logic;
SIGNAL \inst1|I4|data_ox[14]~5\ : std_logic;
SIGNAL \inst1|I4|data_ox[5]~2\ : std_logic;
SIGNAL \inst|altsyncram_component|q_a[11]\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[7]~1893\ : std_logic;
SIGNAL \inst1|I1|pc[7]\ : std_logic;
SIGNAL \inst1|I1|add_27~7COUT0\ : std_logic;
SIGNAL \inst1|I1|add_27~7COUT1\ : std_logic;
SIGNAL \inst1|I1|add_27~8COUT0\ : std_logic;
SIGNAL \inst1|I1|add_27~8COUT1\ : std_logic;
SIGNAL \inst1|I1|add_27~9\ : std_logic;
SIGNAL \rtl~1958\ : std_logic;
SIGNAL \inst1|I1|Mux_67~0\ : std_logic;
SIGNAL \rtl~345\ : std_logic;
SIGNAL \inst1|I1|Mux_46_rtl_63_rtl_343~0\ : std_logic;
SIGNAL \inst1|I1|Mux_46_rtl_63_rtl_343~1\ : std_logic;
SIGNAL \rtl~2481\ : std_logic;
SIGNAL \inst11|inst1|altsyncram_component|q_a[8]\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[8]~1916\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[8]~245\ : std_logic;
SIGNAL \inst1|I1|pc[8]\ : std_logic;
SIGNAL \inst1|I1|add_27~8\ : std_logic;
SIGNAL \rtl~1949\ : std_logic;
SIGNAL \inst1|I1|Mux_47_rtl_60_rtl_340~0\ : std_logic;
SIGNAL \rtl~344\ : std_logic;
SIGNAL \inst1|I1|Mux_47_rtl_60_rtl_340~1\ : std_logic;
SIGNAL \rtl~2472\ : std_logic;
SIGNAL \rtl~2471\ : std_logic;
SIGNAL \inst11|inst1|altsyncram_component|q_a[7]\ : std_logic;
SIGNAL \rtl~2462\ : std_logic;
SIGNAL \rtl~1940\ : std_logic;
SIGNAL \rtl~343\ : std_logic;
SIGNAL \inst1|I1|Mux_48_rtl_57_rtl_337~0\ : std_logic;
SIGNAL \inst1|I1|Mux_48_rtl_57_rtl_337~1\ : std_logic;
SIGNAL \rtl~2461\ : std_logic;
SIGNAL \inst11|inst1|altsyncram_component|q_a[6]\ : std_logic;
SIGNAL \rtl~2452\ : std_logic;
SIGNAL \rtl~1931\ : std_logic;
SIGNAL \inst1|I1|Mux_49_rtl_54_rtl_334~0\ : std_logic;
SIGNAL \rtl~342\ : std_logic;
SIGNAL \inst1|I1|Mux_49_rtl_54_rtl_334~1\ : std_logic;
SIGNAL \rtl~2451\ : std_logic;
SIGNAL \inst11|inst1|altsyncram_component|q_a[5]\ : std_logic;
SIGNAL \rtl~2442\ : std_logic;
SIGNAL \rtl~1922\ : std_logic;
SIGNAL \rtl~341\ : std_logic;
SIGNAL \inst1|I1|Mux_50_rtl_51_rtl_331~0\ : std_logic;
SIGNAL \inst1|I1|Mux_50_rtl_51_rtl_331~1\ : std_logic;
SIGNAL \rtl~2441\ : std_logic;
SIGNAL \inst11|inst1|altsyncram_component|q_a[4]\ : std_logic;
SIGNAL \rtl~2432\ : std_logic;
SIGNAL \rtl~1913\ : std_logic;
SIGNAL \rtl~340\ : std_logic;
SIGNAL \inst1|I1|Mux_51_rtl_48_rtl_328~0\ : std_logic;
SIGNAL \inst1|I1|Mux_51_rtl_48_rtl_328~1\ : std_logic;
SIGNAL \rtl~2431\ : std_logic;
SIGNAL \inst11|inst1|altsyncram_component|q_a[3]\ : std_logic;
SIGNAL \rtl~2422\ : std_logic;
SIGNAL \rtl~1904\ : std_logic;
SIGNAL \rtl~339\ : std_logic;
SIGNAL \inst1|I1|Mux_52_rtl_45_rtl_325~0\ : std_logic;
SIGNAL \inst1|I1|Mux_52_rtl_45_rtl_325~1\ : std_logic;
SIGNAL \rtl~2421\ : std_logic;
SIGNAL \inst11|inst1|altsyncram_component|q_a[2]\ : std_logic;
SIGNAL \inst1|I1|Mux_53_rtl_42_rtl_322~0\ : std_logic;
SIGNAL \rtl~338\ : std_logic;
SIGNAL \inst1|I1|Mux_53_rtl_42_rtl_322~1\ : std_logic;
SIGNAL \rtl~2412\ : std_logic;
SIGNAL \rtl~1895\ : std_logic;
SIGNAL \rtl~2411\ : std_logic;
SIGNAL \inst11|inst1|altsyncram_component|q_a[1]\ : std_logic;
SIGNAL \rtl~2402\ : std_logic;
SIGNAL \rtl~337\ : std_logic;
SIGNAL \inst1|I1|Mux_54_rtl_39_rtl_319~0\ : std_logic;
SIGNAL \inst1|I1|Mux_54_rtl_39_rtl_319~1\ : std_logic;
SIGNAL \rtl~1886\ : std_logic;
SIGNAL \rtl~2401\ : std_logic;
SIGNAL \inst11|inst1|altsyncram_component|q_a[0]\ : std_logic;
SIGNAL \rtl~2392\ : std_logic;
SIGNAL \rtl~1877\ : std_logic;
SIGNAL \inst1|I1|Mux_55_rtl_36_rtl_316~0\ : std_logic;
SIGNAL \rtl~336\ : std_logic;
SIGNAL \inst1|I1|Mux_55_rtl_36_rtl_316~1\ : std_logic;
SIGNAL \rtl~2391\ : std_logic;
SIGNAL \inst11|inst1|altsyncram_component|q_a[9]\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[9]~875\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[9]~885\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[9]~890\ : std_logic;
SIGNAL \inst2|i~46\ : std_logic;
SIGNAL \inst1|I4|data_ox[9]~9\ : std_logic;
SIGNAL \inst1|I4|data_ox[12]~6\ : std_logic;
SIGNAL \inst1|I4|data_ox[10]~8\ : std_logic;
SIGNAL \inst|altsyncram_component|q_a[12]\ : std_logic;
SIGNAL \inst1|I2|data_is_c[8]\ : std_logic;
SIGNAL \DATA_IN_EXT[8]~combout\ : std_logic;
SIGNAL \inst1|I3|data_x[8]~945\ : std_logic;
SIGNAL \inst1|I4|iadata_x[20]~20\ : std_logic;
SIGNAL \inst1|I4|data_exp_i[8]\ : std_logic;
SIGNAL \inst1|I4|data_exp_c[8]\ : std_logic;
SIGNAL \inst1|I3|data_x[8]~3802\ : std_logic;
SIGNAL \inst1|I3|data_x[8]~2881\ : std_logic;
SIGNAL \inst1|I3|data_x[8]~3830\ : std_logic;
SIGNAL \rtl~14387\ : std_logic;
SIGNAL \rtl~2800\ : std_logic;
SIGNAL \rtl~2615\ : std_logic;
SIGNAL \rtl~2805\ : std_logic;
SIGNAL \inst1|I3|add_185~8\ : std_logic;
SIGNAL \inst1|I3|add_225~9\ : std_logic;
SIGNAL \inst1|I3|Mux_258_rtl_122_rtl_403~0\ : std_logic;
SIGNAL \inst1|I3|Mux_258_rtl_122_rtl_403~1\ : std_logic;
SIGNAL \rtl~14365\ : std_logic;
SIGNAL \rtl~14370\ : std_logic;
SIGNAL \inst1|I3|acc[0][8]~216\ : std_logic;
SIGNAL \inst1|I3|acc[0][8]~8294\ : std_logic;
SIGNAL \inst1|I3|acc_c[0][8]\ : std_logic;
SIGNAL \inst1|I4|add_205~8\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~82\ : std_logic;
SIGNAL \inst1|I4|ireg_i[8]\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~87\ : std_logic;
SIGNAL \inst1|I4|ireg_c[8]\ : std_logic;
SIGNAL \inst1|I2|idata_x[12]~51\ : std_logic;
SIGNAL \inst1|I4|daddr_x[8]~79\ : std_logic;
SIGNAL \inst2|daddr_c[8]\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[8]~178\ : std_logic;
SIGNAL \inst2|i~280\ : std_logic;
SIGNAL \inst2|i~285\ : std_logic;
SIGNAL \inst|altsyncram_component|q_a[15]\ : std_logic;
SIGNAL \inst1|I3|data_x[15]~82\ : std_logic;
SIGNAL \inst1|I3|data_x[15]~87\ : std_logic;
SIGNAL \rtl~1506\ : std_logic;
SIGNAL \rtl~2560\ : std_logic;
SIGNAL \rtl~2750\ : std_logic;
SIGNAL \rtl~2231\ : std_logic;
SIGNAL \inst1|I3|add_225~15COUT0\ : std_logic;
SIGNAL \inst1|I3|add_225~15COUT1\ : std_logic;
SIGNAL \inst1|I3|add_225~16\ : std_logic;
SIGNAL \inst1|I3|add_185~14COUT0\ : std_logic;
SIGNAL \inst1|I3|add_185~14COUT1\ : std_logic;
SIGNAL \inst1|I3|add_185~15\ : std_logic;
SIGNAL \inst1|I3|Mux_251_rtl_92_rtl_373~0\ : std_logic;
SIGNAL \inst1|I3|Mux_251_rtl_92_rtl_373~1\ : std_logic;
SIGNAL \rtl~14148\ : std_logic;
SIGNAL \rtl~14170\ : std_logic;
SIGNAL \inst1|I3|acc[0][15]~166\ : std_logic;
SIGNAL \inst1|I3|acc[0][15]~8244\ : std_logic;
SIGNAL \inst1|I3|acc_c[0][15]\ : std_logic;
SIGNAL \rtl~3100\ : std_logic;
SIGNAL \rtl~3108\ : std_logic;
SIGNAL \inst1|I3|acc[0][16]~106\ : std_logic;
SIGNAL \rtl~13603\ : std_logic;
SIGNAL \rtl~3106\ : std_logic;
SIGNAL \inst1|I3|add_225~16COUT0\ : std_logic;
SIGNAL \inst1|I3|add_225~16COUT1\ : std_logic;
SIGNAL \inst1|I3|add_225~17\ : std_logic;
SIGNAL \inst1|I3|add_185~15COUT0\ : std_logic;
SIGNAL \inst1|I3|add_185~15COUT1\ : std_logic;
SIGNAL \inst1|I3|add_185~16\ : std_logic;
SIGNAL \rtl~3095\ : std_logic;
SIGNAL \rtl~13872\ : std_logic;
SIGNAL \rtl~2877\ : std_logic;
SIGNAL \inst1|I3|acc_c[0][16]\ : std_logic;
SIGNAL \rtl~2856\ : std_logic;
SIGNAL \rtl~2855\ : std_logic;
SIGNAL \rtl~2861\ : std_logic;
SIGNAL \rtl~2866\ : std_logic;
SIGNAL \inst1|I3|add_225~1\ : std_logic;
SIGNAL \inst1|I3|add_185~0\ : std_logic;
SIGNAL \inst1|I3|Mux_266_rtl_152_rtl_433~0\ : std_logic;
SIGNAL \inst1|I3|Mux_266_rtl_152_rtl_433~1\ : std_logic;
SIGNAL \rtl~14621\ : std_logic;
SIGNAL \inst1|I3|Mux_150_rtl_149_rtl_429~0\ : std_logic;
SIGNAL \rtl~14580\ : std_logic;
SIGNAL \rtl~14592\ : std_logic;
SIGNAL \rtl~2373\ : std_logic;
SIGNAL \rtl~2865\ : std_logic;
SIGNAL \inst1|I3|acc[0][0]~266\ : std_logic;
SIGNAL \inst1|I3|acc[0][0]~8344\ : std_logic;
SIGNAL \inst1|I3|acc_c[0][0]\ : std_logic;
SIGNAL \inst1|I4|iinc_i[0]\ : std_logic;
SIGNAL \inst1|I4|iinc_x[0]~35\ : std_logic;
SIGNAL \inst1|I4|iinc_c[0]\ : std_logic;
SIGNAL \inst1|I4|add_205~0COUT\ : std_logic;
SIGNAL \inst1|I4|add_205~4COUT0\ : std_logic;
SIGNAL \inst1|I4|add_205~4COUT1\ : std_logic;
SIGNAL \inst1|I4|add_205~5\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~112\ : std_logic;
SIGNAL \inst1|I4|ireg_i[5]\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~117\ : std_logic;
SIGNAL \inst1|I4|ireg_c[5]\ : std_logic;
SIGNAL \inst1|I3|data_x[5]~3622\ : std_logic;
SIGNAL \inst1|I3|data_x[5]~2367\ : std_logic;
SIGNAL \inst1|I3|data_x[5]~3650\ : std_logic;
SIGNAL \rtl~14082\ : std_logic;
SIGNAL \rtl~2730\ : std_logic;
SIGNAL \rtl~2538\ : std_logic;
SIGNAL \rtl~2735\ : std_logic;
SIGNAL \inst1|I3|add_185~5\ : std_logic;
SIGNAL \inst1|I3|add_225~6\ : std_logic;
SIGNAL \inst1|I3|Mux_261_rtl_80_rtl_361~0\ : std_logic;
SIGNAL \inst1|I3|Mux_261_rtl_80_rtl_361~1\ : std_logic;
SIGNAL \rtl~14060\ : std_logic;
SIGNAL \rtl~14065\ : std_logic;
SIGNAL \inst1|I3|acc[0][5]~146\ : std_logic;
SIGNAL \inst1|I3|acc[0][5]~8224\ : std_logic;
SIGNAL \inst1|I3|acc_c[0][5]\ : std_logic;
SIGNAL \inst1|I4|iinc_i[5]\ : std_logic;
SIGNAL \inst1|I4|iinc_x[5]~8\ : std_logic;
SIGNAL \inst1|I4|iinc_c[5]\ : std_logic;
SIGNAL \inst1|I4|add_205~5COUT\ : std_logic;
SIGNAL \inst1|I4|add_205~7\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~92\ : std_logic;
SIGNAL \inst1|I4|ireg_i[7]\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~97\ : std_logic;
SIGNAL \inst1|I4|ireg_c[7]\ : std_logic;
SIGNAL \inst1|I2|idata_x[11]~54\ : std_logic;
SIGNAL \inst1|I4|daddr_x[7]~86\ : std_logic;
SIGNAL \inst2|daddr_c[7]\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[7]~168\ : std_logic;
SIGNAL \inst2|i~270\ : std_logic;
SIGNAL \inst2|i~275\ : std_logic;
SIGNAL \inst|altsyncram_component|q_a[10]\ : std_logic;
SIGNAL \inst1|I2|data_is_c[6]\ : std_logic;
SIGNAL \DATA_IN_EXT[6]~combout\ : std_logic;
SIGNAL \inst1|I3|data_x[6]~345\ : std_logic;
SIGNAL \inst1|I3|data_x[6]~3580\ : std_logic;
SIGNAL \inst1|I4|iadata_x[18]~5\ : std_logic;
SIGNAL \inst1|I4|data_exp_i[6]\ : std_logic;
SIGNAL \inst1|I4|data_exp_c[6]\ : std_logic;
SIGNAL \inst1|I3|data_x[6]~2261\ : std_logic;
SIGNAL \inst1|I3|data_x[6]~3608\ : std_logic;
SIGNAL \rtl~14038\ : std_logic;
SIGNAL \rtl~2527\ : std_logic;
SIGNAL \rtl~2720\ : std_logic;
SIGNAL \rtl~2725\ : std_logic;
SIGNAL \inst1|I3|add_225~7\ : std_logic;
SIGNAL \inst1|I3|add_185~6\ : std_logic;
SIGNAL \inst1|I3|Mux_260_rtl_74_rtl_355~0\ : std_logic;
SIGNAL \inst1|I3|Mux_260_rtl_74_rtl_355~1\ : std_logic;
SIGNAL \rtl~14016\ : std_logic;
SIGNAL \rtl~14021\ : std_logic;
SIGNAL \inst1|I3|acc[0][6]~136\ : std_logic;
SIGNAL \inst1|I3|acc[0][6]~8214\ : std_logic;
SIGNAL \inst1|I3|acc_c[0][6]\ : std_logic;
SIGNAL \inst1|I4|add_205~6\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~102\ : std_logic;
SIGNAL \inst1|I4|ireg_i[6]\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~107\ : std_logic;
SIGNAL \inst1|I4|ireg_c[6]\ : std_logic;
SIGNAL \inst1|I2|idata_x[10]~57\ : std_logic;
SIGNAL \inst1|I4|daddr_x[6]~93\ : std_logic;
SIGNAL \inst2|daddr_c[6]\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[6]~158\ : std_logic;
SIGNAL \inst2|i~260\ : std_logic;
SIGNAL \inst2|i~265\ : std_logic;
SIGNAL \inst|altsyncram_component|q_a[13]\ : std_logic;
SIGNAL \inst1|I2|idata_x[13]~42\ : std_logic;
SIGNAL \inst1|I4|daddr_x[9]~72\ : std_logic;
SIGNAL \inst3|mux_c[0]\ : std_logic;
SIGNAL \inst1|I3|data_x[13]~72\ : std_logic;
SIGNAL \inst1|I3|data_x[13]~77\ : std_logic;
SIGNAL \rtl~1331\ : std_logic;
SIGNAL \rtl~2505\ : std_logic;
SIGNAL \rtl~2700\ : std_logic;
SIGNAL \rtl~2156\ : std_logic;
SIGNAL \inst1|I3|add_185~13\ : std_logic;
SIGNAL \inst1|I3|add_225~14\ : std_logic;
SIGNAL \inst1|I3|Mux_253_rtl_32_rtl_313~0\ : std_logic;
SIGNAL \inst1|I3|Mux_253_rtl_32_rtl_313~1\ : std_logic;
SIGNAL \rtl~13927\ : std_logic;
SIGNAL \rtl~13949\ : std_logic;
SIGNAL \inst1|I3|acc[0][13]~116\ : std_logic;
SIGNAL \inst1|I3|acc[0][13]~8194\ : std_logic;
SIGNAL \inst1|I3|acc_c[0][13]\ : std_logic;
SIGNAL \inst1|I4|data_ox[13]~0\ : std_logic;
SIGNAL \inst|altsyncram_component|q_a[9]\ : std_logic;
SIGNAL \inst1|I2|idata_x[9]~60\ : std_logic;
SIGNAL \inst1|I4|daddr_x[5]~100\ : std_logic;
SIGNAL \inst2|daddr_c[5]\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[5]~148\ : std_logic;
SIGNAL \inst2|i~250\ : std_logic;
SIGNAL \inst2|i~255\ : std_logic;
SIGNAL \inst1|I4|data_ox[8]~10\ : std_logic;
SIGNAL \inst1|I4|data_ox[6]~1\ : std_logic;
SIGNAL \inst1|I4|data_ox[4]~3\ : std_logic;
SIGNAL \inst|altsyncram_component|q_a[8]\ : std_logic;
SIGNAL \inst1|I2|idata_x[8]~63\ : std_logic;
SIGNAL \inst1|I4|daddr_x[4]~107\ : std_logic;
SIGNAL \inst2|daddr_c[4]\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[4]~138\ : std_logic;
SIGNAL \inst2|i~240\ : std_logic;
SIGNAL \inst2|i~245\ : std_logic;
SIGNAL \inst1|I4|data_ox[1]~14\ : std_logic;
SIGNAL \inst1|I4|data_ox[3]~12\ : std_logic;
SIGNAL \inst1|I4|data_ox[0]~15\ : std_logic;
SIGNAL \inst|altsyncram_component|q_a[3]\ : std_logic;
SIGNAL \inst1|I3|data_x[3]~1149\ : std_logic;
SIGNAL \inst1|I3|data_x[3]~3914\ : std_logic;
SIGNAL \rtl~14475\ : std_logic;
SIGNAL \rtl~2820\ : std_logic;
SIGNAL \rtl~2637\ : std_logic;
SIGNAL \rtl~2825\ : std_logic;
SIGNAL \inst1|I3|add_225~4\ : std_logic;
SIGNAL \inst1|I3|add_185~3\ : std_logic;
SIGNAL \inst1|I3|Mux_263_rtl_134_rtl_415~0\ : std_logic;
SIGNAL \inst1|I3|Mux_263_rtl_134_rtl_415~1\ : std_logic;
SIGNAL \rtl~14453\ : std_logic;
SIGNAL \rtl~14458\ : std_logic;
SIGNAL \inst1|I3|acc[0][3]~236\ : std_logic;
SIGNAL \inst1|I3|acc[0][3]~8314\ : std_logic;
SIGNAL \inst1|I3|acc_c[0][3]\ : std_logic;
SIGNAL \inst1|I4|add_205~3\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~132\ : std_logic;
SIGNAL \inst1|I4|ireg_i[3]\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~137\ : std_logic;
SIGNAL \inst1|I4|ireg_c[3]\ : std_logic;
SIGNAL \inst1|I4|daddr_x[3]~114\ : std_logic;
SIGNAL \inst2|daddr_c[3]\ : std_logic;
SIGNAL \inst2|i~230\ : std_logic;
SIGNAL \inst2|i~235\ : std_logic;
SIGNAL \inst|altsyncram_component|q_a[14]\ : std_logic;
SIGNAL \inst1|I2|data_is_c[10]\ : std_logic;
SIGNAL \inst1|I4|i~2639\ : std_logic;
SIGNAL \inst1|I4|i~2668\ : std_logic;
SIGNAL \inst1|I4|i~2661\ : std_logic;
SIGNAL \inst1|I4|i~2671\ : std_logic;
SIGNAL \inst1|I4|i~40\ : std_logic;
SIGNAL \inst1|I4|ireg_we_x~10\ : std_logic;
SIGNAL \inst1|I4|iinc_we_c\ : std_logic;
SIGNAL \inst1|I4|iinc_x[2]~29\ : std_logic;
SIGNAL \inst1|I4|iinc_i[2]\ : std_logic;
SIGNAL \inst1|I4|iinc_c[2]\ : std_logic;
SIGNAL \inst1|I4|add_205~2\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~142\ : std_logic;
SIGNAL \inst1|I4|ireg_i[2]\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~147\ : std_logic;
SIGNAL \inst1|I4|ireg_c[2]\ : std_logic;
SIGNAL \inst1|I4|daddr_x[2]~121\ : std_logic;
SIGNAL \inst2|daddr_c[2]\ : std_logic;
SIGNAL \inst1|I1|iaddr_x[2]~391\ : std_logic;
SIGNAL \inst2|i~220\ : std_logic;
SIGNAL \inst2|i~225\ : std_logic;
SIGNAL \inst|altsyncram_component|q_a[1]\ : std_logic;
SIGNAL \inst1|I2|idata_x[1]~24\ : std_logic;
SIGNAL \inst1|I2|idata_c[2]\ : std_logic;
SIGNAL \inst1|I2|idata_x[2]~27\ : std_logic;
SIGNAL \inst1|I2|Mux_76~0\ : std_logic;
SIGNAL \inst1|I2|TD_c[2]\ : std_logic;
SIGNAL \rtl~13588\ : std_logic;
SIGNAL \rtl~14299\ : std_logic;
SIGNAL \rtl~2593\ : std_logic;
SIGNAL \rtl~2780\ : std_logic;
SIGNAL \rtl~2785\ : std_logic;
SIGNAL \inst1|I3|add_185~11\ : std_logic;
SIGNAL \inst1|I3|add_225~12\ : std_logic;
SIGNAL \inst1|I3|Mux_255_rtl_110_rtl_391~0\ : std_logic;
SIGNAL \inst1|I3|Mux_255_rtl_110_rtl_391~1\ : std_logic;
SIGNAL \rtl~14277\ : std_logic;
SIGNAL \rtl~14282\ : std_logic;
SIGNAL \inst1|I3|acc[0][11]~196\ : std_logic;
SIGNAL \inst1|I3|acc[0][11]~8274\ : std_logic;
SIGNAL \inst1|I3|acc_c[0][11]\ : std_logic;
SIGNAL \inst1|I4|data_ox[11]~7\ : std_logic;
SIGNAL \inst|altsyncram_component|q_a[5]\ : std_logic;
SIGNAL \inst1|I2|idata_x[5]~36\ : std_logic;
SIGNAL \inst1|I2|Mux_78~0\ : std_logic;
SIGNAL \inst1|I2|TD_c[0]\ : std_logic;
SIGNAL \rtl~13599\ : std_logic;
SIGNAL \inst1|I3|reduce_nor_131~52\ : std_logic;
SIGNAL \inst1|I3|reduce_nor_131~61\ : std_logic;
SIGNAL \inst1|I3|reduce_nor_131~74\ : std_logic;
SIGNAL \inst1|I3|reduce_nor_131~47\ : std_logic;
SIGNAL \inst1|I3|reduce_nor_131~99\ : std_logic;
SIGNAL \rtl~1119\ : std_logic;
SIGNAL \rtl~13789\ : std_logic;
SIGNAL \rtl~13776\ : std_logic;
SIGNAL \rtl~13804\ : std_logic;
SIGNAL \rtl~1120\ : std_logic;
SIGNAL \rtl~13815\ : std_logic;
SIGNAL \inst1|I3|skip_l~8\ : std_logic;
SIGNAL \inst1|I2|skip_x~62\ : std_logic;
SIGNAL \inst1|I2|skip_c\ : std_logic;
SIGNAL \inst1|I2|C_raw~32\ : std_logic;
SIGNAL \inst1|I2|C_raw~47\ : std_logic;
SIGNAL \inst1|I2|C_raw~6\ : std_logic;
SIGNAL \inst1|I2|ndwe_x~51\ : std_logic;
SIGNAL \inst1|I4|ndwe_x~1\ : std_logic;
SIGNAL \inst2|nadwe_c\ : std_logic;
SIGNAL \inst2|i~1057\ : std_logic;
SIGNAL \inst2|a2vi_s\ : std_logic;
SIGNAL \inst1|I2|E_x.iwait_e~1\ : std_logic;
SIGNAL \inst1|I2|E_c~10\ : std_logic;
SIGNAL \inst1|I2|skip_x~61\ : std_logic;
SIGNAL \inst1|I2|valid_x~7\ : std_logic;
SIGNAL \inst1|I2|valid_c\ : std_logic;
SIGNAL \inst1|I3|i~204\ : std_logic;
SIGNAL \inst1|I3|acc[0][16]~8145\ : std_logic;
SIGNAL \inst1|I3|acc[0][13]~8146\ : std_logic;
SIGNAL \rtl~14563\ : std_logic;
SIGNAL \rtl~2659\ : std_logic;
SIGNAL \rtl~2840\ : std_logic;
SIGNAL \rtl~2845\ : std_logic;
SIGNAL \inst1|I3|add_185~1\ : std_logic;
SIGNAL \inst1|I3|add_225~2\ : std_logic;
SIGNAL \inst1|I3|Mux_265_rtl_146_rtl_427~0\ : std_logic;
SIGNAL \inst1|I3|Mux_265_rtl_146_rtl_427~1\ : std_logic;
SIGNAL \rtl~14541\ : std_logic;
SIGNAL \rtl~14546\ : std_logic;
SIGNAL \inst1|I3|acc[0][1]~256\ : std_logic;
SIGNAL \inst1|I3|acc[0][1]~8334\ : std_logic;
SIGNAL \inst1|I3|acc_c[0][1]\ : std_logic;
SIGNAL \inst1|I4|add_205~1\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~152\ : std_logic;
SIGNAL \inst1|I4|ireg_i[1]\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~157\ : std_logic;
SIGNAL \inst1|I4|ireg_c[1]\ : std_logic;
SIGNAL \inst1|I4|daddr_x[1]~128\ : std_logic;
SIGNAL \inst2|daddr_c[1]\ : std_logic;
SIGNAL \inst2|i~210\ : std_logic;
SIGNAL \inst2|i~215\ : std_logic;
SIGNAL \inst|altsyncram_component|q_a[7]\ : std_logic;
SIGNAL \inst1|I2|idata_x[7]~33\ : std_logic;
SIGNAL \inst1|I2|TD_c[3]\ : std_logic;
SIGNAL \rtl~2129\ : std_logic;
SIGNAL \inst1|I3|acc[0][13]~111\ : std_logic;
SIGNAL \rtl~14431\ : std_logic;
SIGNAL \rtl~2626\ : std_logic;
SIGNAL \rtl~2810\ : std_logic;
SIGNAL \rtl~2815\ : std_logic;
SIGNAL \inst1|I3|add_225~8\ : std_logic;
SIGNAL \inst1|I3|add_185~7\ : std_logic;
SIGNAL \inst1|I3|Mux_259_rtl_128_rtl_409~0\ : std_logic;
SIGNAL \inst1|I3|Mux_259_rtl_128_rtl_409~1\ : std_logic;
SIGNAL \rtl~14409\ : std_logic;
SIGNAL \rtl~14414\ : std_logic;
SIGNAL \inst1|I3|acc[0][7]~226\ : std_logic;
SIGNAL \inst1|I3|acc[0][7]~8304\ : std_logic;
SIGNAL \inst1|I3|acc_c[0][7]\ : std_logic;
SIGNAL \inst1|I4|data_ox[7]~11\ : std_logic;
SIGNAL \inst|altsyncram_component|q_a[4]\ : std_logic;
SIGNAL \inst1|I2|idata_x[4]~39\ : std_logic;
SIGNAL \inst1|I4|ireg_we_c\ : std_logic;
SIGNAL \inst1|I4|add_205~0\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~162\ : std_logic;
SIGNAL \inst1|I4|ireg_i[0]\ : std_logic;
SIGNAL \inst1|I4|add_205_rtl_595~167\ : std_logic;
SIGNAL \inst1|I4|ireg_c[0]\ : std_logic;
SIGNAL \inst1|I4|daddr_x[0]~135\ : std_logic;
SIGNAL \inst2|daddr_c[0]\ : std_logic;
SIGNAL \inst2|i~200\ : std_logic;
SIGNAL \inst2|i~205\ : std_logic;
SIGNAL \inst|altsyncram_component|q_a[0]\ : std_logic;
SIGNAL \inst1|I2|idata_x[0]~21\ : std_logic;
SIGNAL \inst1|I2|TC_x[0]~141\ : std_logic;
SIGNAL \inst1|I2|TC_x[0]~147\ : std_logic;
SIGNAL \inst1|I2|TC_x[0]~146\ : std_logic;
SIGNAL \inst1|I2|TC_c[0]\ : std_logic;
SIGNAL \inst1|I2|TC_c[2]\ : std_logic;
SIGNAL \inst1|I3|acc[0][13]~8147\ : std_logic;
SIGNAL \rtl~14519\ : std_logic;
SIGNAL \rtl~2648\ : std_logic;
SIGNAL \rtl~2830\ : std_logic;
SIGNAL \rtl~2835\ : std_logic;
SIGNAL \inst1|I3|add_185~2\ : std_logic;
SIGNAL \inst1|I3|add_225~3\ : std_logic;
SIGNAL \inst1|I3|Mux_264_rtl_140_rtl_421~0\ : std_logic;
SIGNAL \inst1|I3|Mux_264_rtl_140_rtl_421~1\ : std_logic;
SIGNAL \rtl~14497\ : std_logic;
SIGNAL \rtl~14502\ : std_logic;
SIGNAL \inst1|I3|acc[0][2]~246\ : std_logic;
SIGNAL \inst1|I3|acc[0][2]~8324\ : std_logic;
SIGNAL \inst1|I3|acc_c[0][2]\ : std_logic;
SIGNAL \inst1|I4|data_ox[2]~13\ : std_logic;
SIGNAL \inst|altsyncram_component|q_a[2]\ : std_logic;
SIGNAL \inst1|I2|TD_x[3]~35\ : std_logic;
SIGNAL \inst1|I2|TC_x[2]~135\ : std_logic;
SIGNAL \inst1|I2|TC_x[2]~139\ : std_logic;
SIGNAL \inst1|I2|C_store_x~0\ : std_logic;
SIGNAL \inst1|I4|i~1280\ : std_logic;
SIGNAL \inst3|nWE_RAM_c\ : std_logic;
SIGNAL \inst|altsyncram_component|q_a[6]\ : std_logic;
SIGNAL \inst1|I2|idata_x[6]~30\ : std_logic;
SIGNAL \inst1|I4|i~2617\ : std_logic;
SIGNAL \inst4|i~326\ : std_logic;
SIGNAL \inst4|i~331\ : std_logic;
SIGNAL \inst4|dwait_c\ : std_logic;
SIGNAL \inst1|I2|i~219\ : std_logic;
SIGNAL \inst1|I2|E_x.dwait_e~0\ : std_logic;
SIGNAL \inst1|I2|idata_x[3]~18\ : std_logic;
SIGNAL \inst1|I2|TC_x[1]~22\ : std_logic;
SIGNAL \inst1|I2|ndre_x~49\ : std_logic;
SIGNAL \inst1|I4|ndre_x~1\ : std_logic;
SIGNAL \inst4|ndre_c\ : std_logic;
SIGNAL \inst4|i~88\ : std_logic;
SIGNAL \inst4|ndwe_c\ : std_logic;
SIGNAL \inst3|nCS_EXT_c\ : std_logic;
SIGNAL \inst4|reduce_or_84\ : std_logic;
SIGNAL \inst4|cpu_daddr_c[9]\ : std_logic;
SIGNAL \inst4|cpu_daddr_x[9]~56\ : std_logic;
SIGNAL \inst4|i~114\ : std_logic;
SIGNAL \inst4|cpu_daddr_c[8]\ : std_logic;
SIGNAL \inst4|cpu_daddr_x[8]~63\ : std_logic;
SIGNAL \inst4|i~120\ : std_logic;
SIGNAL \inst4|cpu_daddr_c[7]\ : std_logic;
SIGNAL \inst4|cpu_daddr_x[7]~70\ : std_logic;
SIGNAL \inst4|i~126\ : std_logic;
SIGNAL \inst4|cpu_daddr_c[6]\ : std_logic;
SIGNAL \inst4|cpu_daddr_x[6]~77\ : std_logic;
SIGNAL \inst4|i~132\ : std_logic;
SIGNAL \inst4|cpu_daddr_x[5]~84\ : std_logic;
SIGNAL \inst4|cpu_daddr_c[5]\ : std_logic;
SIGNAL \inst4|i~138\ : std_logic;
SIGNAL \inst4|cpu_daddr_c[4]\ : std_logic;
SIGNAL \inst4|cpu_daddr_x[4]~91\ : std_logic;
SIGNAL \inst4|i~144\ : std_logic;
SIGNAL \inst4|cpu_daddr_c[3]\ : std_logic;
SIGNAL \inst4|cpu_daddr_x[3]~98\ : std_logic;
SIGNAL \inst4|i~150\ : std_logic;
SIGNAL \inst4|cpu_daddr_c[2]\ : std_logic;
SIGNAL \inst4|cpu_daddr_x[2]~105\ : std_logic;
SIGNAL \inst4|i~156\ : std_logic;
SIGNAL \inst4|cpu_daddr_x[1]~112\ : std_logic;
SIGNAL \inst4|cpu_daddr_c[1]\ : std_logic;
SIGNAL \inst4|i~162\ : std_logic;
SIGNAL \inst4|cpu_daddr_c[0]\ : std_logic;
SIGNAL \inst4|cpu_daddr_x[0]~119\ : std_logic;
SIGNAL \inst4|i~168\ : std_logic;
SIGNAL \NOT_nreset_in~combout\ : std_logic;
SIGNAL \NOT_inst4|ndwe_c\ : std_logic;
SIGNAL \NOT_inst4|dwait_c\ : std_logic;
SIGNAL \NOT_inst3|nCS_EXT_c\ : std_logic;

BEGIN

ww_nreset_in <= nreset_in;
ww_clk_in <= clk_in;
ww_cpu_int <= cpu_int;
ww_DATA_IN_EXT <= DATA_IN_EXT;
NRE_EXT <= ww_NRE_EXT;
NWE_EXT <= ww_NWE_EXT;
NCS_EXT <= ww_NCS_EXT;
ADDR_OUT_EXT <= ww_ADDR_OUT_EXT;
DATA_OUT_EXT <= ww_DATA_OUT_EXT;

\ww_inst|altsyncram_component|ram_block[0][13]_aaddress\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst2|i~46\ & \inst2|i~285\ & \inst2|i~275\ & \inst2|i~265\ & \inst2|i~255\ & \inst2|i~245\ & \inst2|i~235\ & \inst2|i~225\ & \inst2|i~215\ & \inst2|i~205\);

\ww_inst|altsyncram_component|ram_block[0][13]_adatain\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst1|I4|data_ox[10]~8\ & \inst1|I4|data_ox[12]~6\ & \inst1|I4|data_ox[9]~9\ & \inst1|I4|data_ox[13]~0\);

\inst|altsyncram_component|q_a[13]\ <= \ww_inst|altsyncram_component|ram_block[0][13]_adataout\(0);
\inst|altsyncram_component|q_a[9]\ <= \ww_inst|altsyncram_component|ram_block[0][13]_adataout\(1);
\inst|altsyncram_component|q_a[12]\ <= \ww_inst|altsyncram_component|ram_block[0][13]_adataout\(2);
\inst|altsyncram_component|q_a[10]\ <= \ww_inst|altsyncram_component|ram_block[0][13]_adataout\(3);

\ww_inst|altsyncram_component|ram_block[0][7]_aaddress\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst2|i~46\ & \inst2|i~285\ & \inst2|i~275\ & \inst2|i~265\ & \inst2|i~255\ & \inst2|i~245\ & \inst2|i~235\ & \inst2|i~225\ & \inst2|i~215\ & \inst2|i~205\);

\ww_inst|altsyncram_component|ram_block[0][7]_adatain\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst1|I4|data_ox[4]~3\ & \inst1|I4|data_ox[6]~1\ & \inst1|I4|data_ox[8]~10\ & \inst1|I4|data_ox[7]~11\);

\inst|altsyncram_component|q_a[7]\ <= \ww_inst|altsyncram_component|ram_block[0][7]_adataout\(0);
\inst|altsyncram_component|q_a[8]\ <= \ww_inst|altsyncram_component|ram_block[0][7]_adataout\(1);
\inst|altsyncram_component|q_a[6]\ <= \ww_inst|altsyncram_component|ram_block[0][7]_adataout\(2);
\inst|altsyncram_component|q_a[4]\ <= \ww_inst|altsyncram_component|ram_block[0][7]_adataout\(3);

\ww_inst|altsyncram_component|ram_block[0][11]_aaddress\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst2|i~46\ & \inst2|i~285\ & \inst2|i~275\ & \inst2|i~265\ & \inst2|i~255\ & \inst2|i~245\ & \inst2|i~235\ & \inst2|i~225\ & \inst2|i~215\ & \inst2|i~205\);

\ww_inst|altsyncram_component|ram_block[0][11]_adatain\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst1|I4|data_ox[5]~2\ & \inst1|I4|data_ox[14]~5\ & \inst1|I4|data_ox[15]~4\ & \inst1|I4|data_ox[11]~7\);

\inst|altsyncram_component|q_a[11]\ <= \ww_inst|altsyncram_component|ram_block[0][11]_adataout\(0);
\inst|altsyncram_component|q_a[15]\ <= \ww_inst|altsyncram_component|ram_block[0][11]_adataout\(1);
\inst|altsyncram_component|q_a[14]\ <= \ww_inst|altsyncram_component|ram_block[0][11]_adataout\(2);
\inst|altsyncram_component|q_a[5]\ <= \ww_inst|altsyncram_component|ram_block[0][11]_adataout\(3);

\ww_inst|altsyncram_component|ram_block[0][2]_aaddress\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst2|i~46\ & \inst2|i~285\ & \inst2|i~275\ & \inst2|i~265\ & \inst2|i~255\ & \inst2|i~245\ & \inst2|i~235\ & \inst2|i~225\ & \inst2|i~215\ & \inst2|i~205\);

\ww_inst|altsyncram_component|ram_block[0][2]_adatain\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst1|I4|data_ox[0]~15\ & \inst1|I4|data_ox[3]~12\ & \inst1|I4|data_ox[1]~14\ & \inst1|I4|data_ox[2]~13\);

\inst|altsyncram_component|q_a[2]\ <= \ww_inst|altsyncram_component|ram_block[0][2]_adataout\(0);
\inst|altsyncram_component|q_a[1]\ <= \ww_inst|altsyncram_component|ram_block[0][2]_adataout\(1);
\inst|altsyncram_component|q_a[3]\ <= \ww_inst|altsyncram_component|ram_block[0][2]_adataout\(2);
\inst|altsyncram_component|q_a[0]\ <= \ww_inst|altsyncram_component|ram_block[0][2]_adataout\(3);

\ww_inst11|inst1|altsyncram_component|ram_block[0][0]_aaddress\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst11|inst8|add_15_rtl_597~31\ & \inst11|inst8|add_15_rtl_597~28\ & \inst11|inst8|add_15_rtl_597~25\ & \inst11|inst8|add_15_rtl_597~22\
& \inst11|inst8|add_15_rtl_597~19\ & \inst11|inst8|add_15_rtl_597~16\ & \inst11|inst8|add_15_rtl_597~13\ & \inst11|inst8|add_15_rtl_597~10\);

\ww_inst11|inst1|altsyncram_component|ram_block[0][0]_adatain\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd
& gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \rtl~2481\ & \rtl~2471\ & \rtl~2461\ & \rtl~2451\ & \rtl~2441\ & \rtl~2431\ & \rtl~2421\ & \rtl~2411\ & \rtl~2401\ & \rtl~2391\);

\inst11|inst1|altsyncram_component|q_a[0]\ <= \ww_inst11|inst1|altsyncram_component|ram_block[0][0]_adataout\(0);
\inst11|inst1|altsyncram_component|q_a[1]\ <= \ww_inst11|inst1|altsyncram_component|ram_block[0][0]_adataout\(1);
\inst11|inst1|altsyncram_component|q_a[2]\ <= \ww_inst11|inst1|altsyncram_component|ram_block[0][0]_adataout\(2);
\inst11|inst1|altsyncram_component|q_a[3]\ <= \ww_inst11|inst1|altsyncram_component|ram_block[0][0]_adataout\(3);
\inst11|inst1|altsyncram_component|q_a[4]\ <= \ww_inst11|inst1|altsyncram_component|ram_block[0][0]_adataout\(4);
\inst11|inst1|altsyncram_component|q_a[5]\ <= \ww_inst11|inst1|altsyncram_component|ram_block[0][0]_adataout\(5);
\inst11|inst1|altsyncram_component|q_a[6]\ <= \ww_inst11|inst1|altsyncram_component|ram_block[0][0]_adataout\(6);
\inst11|inst1|altsyncram_component|q_a[7]\ <= \ww_inst11|inst1|altsyncram_component|ram_block[0][0]_adataout\(7);
\inst11|inst1|altsyncram_component|q_a[8]\ <= \ww_inst11|inst1|altsyncram_component|ram_block[0][0]_adataout\(8);
\inst11|inst1|altsyncram_component|q_a[9]\ <= \ww_inst11|inst1|altsyncram_component|ram_block[0][0]_adataout\(9);
\NOT_nreset_in~combout\ <= NOT \nreset_in~combout\;
\NOT_inst4|ndwe_c\ <= NOT \inst4|ndwe_c\;
\NOT_inst4|dwait_c\ <= NOT \inst4|dwait_c\;
\NOT_inst3|nCS_EXT_c\ <= NOT \inst3|nCS_EXT_c\;

\nreset_in~I\ : cyclone_io 
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
	padio => ww_nreset_in,
	combout => \nreset_in~combout\);

\clk_in~I\ : cyclone_io 
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
	padio => ww_clk_in,
	combout => \clk_in~combout\);

\inst1|I4|nreset_v_rtl_4|wysi_counter|counter_cell[0]\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]\ = DFFEA(!\inst1|I4|LessThan_79~5\ # !\inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )
-- \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]~COUT0\ = CARRY(\inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]\)
-- \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]~COUT1\ = CARRY(\inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]\)

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
	clk => \clk_in~combout\,
	dataa => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]\,
	datab => \inst1|I4|LessThan_79~5\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]\,
	cout0 => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]~COUT0\,
	cout1 => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]~COUT1\);

\inst1|I4|LessThan_79~5_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|LessThan_79~5\ = !\inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]\ # !\inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\

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
	datac => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	datad => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|LessThan_79~5\);

\inst1|I4|nreset_v_rtl_4|wysi_counter|counter_cell[1]\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ = DFFEA(\inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]~COUT0\ $ \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ # !\inst1|I4|LessThan_79~5\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "3FF3",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|LessThan_79~5\,
	datad => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	aclr => \NOT_nreset_in~combout\,
	cin0 => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]~COUT0\,
	cin1 => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[0]~COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\);

\~GND~I\ : cyclone_lcell 
-- Equation(s):
-- \~GND\ = GND

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	combout => \~GND\);

\inst4|nwait_c[0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|nwait_c[0]\ = DFFEA((\inst4|i~331\ & VCC) # (!\inst4|i~331\ & !\inst4|nwait_c[0]\), GLOBAL(\clk_in~combout\), VCC, , , VCC, !GLOBAL(\nreset_in~combout\))
-- \inst4|nwait_c[0]~COUT0\ = CARRY(\inst4|nwait_c[0]\)
-- \inst4|nwait_c[0]~COUT1\ = CARRY(\inst4|nwait_c[0]\)

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
	clk => \clk_in~combout\,
	datab => \inst4|nwait_c[0]\,
	datac => VCC,
	aclr => GND,
	aload => \NOT_nreset_in~combout\,
	sload => \inst4|i~331\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst4|nwait_c[0]\,
	cout0 => \inst4|nwait_c[0]~COUT0\,
	cout1 => \inst4|nwait_c[0]~COUT1\);

\inst4|nwait_c[1]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|nwait_c[1]\ = DFFEA((\inst4|i~331\ & VCC) # (!\inst4|i~331\ & \inst4|nwait_c[1]\ $ !\inst4|nwait_c[0]~COUT0\), GLOBAL(\clk_in~combout\), VCC, , , VCC, !GLOBAL(\nreset_in~combout\))
-- \inst4|nwait_c[1]~COUT0\ = CARRY(!\inst4|nwait_c[1]\ & !\inst4|nwait_c[0]~COUT0\)
-- \inst4|nwait_c[1]~COUT1\ = CARRY(!\inst4|nwait_c[1]\ & !\inst4|nwait_c[0]~COUT1\)

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
	clk => \clk_in~combout\,
	dataa => \inst4|nwait_c[1]\,
	datac => VCC,
	aclr => GND,
	aload => \NOT_nreset_in~combout\,
	sload => \inst4|i~331\,
	cin0 => \inst4|nwait_c[0]~COUT0\,
	cin1 => \inst4|nwait_c[0]~COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst4|nwait_c[1]\,
	cout0 => \inst4|nwait_c[1]~COUT0\,
	cout1 => \inst4|nwait_c[1]~COUT1\);

\inst4|nwait_c[2]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|nwait_c[2]\ = DFFEA((\inst4|i~331\ & VCC) # (!\inst4|i~331\ & \inst4|nwait_c[2]\ $ \inst4|nwait_c[1]~COUT0\), GLOBAL(\clk_in~combout\), VCC, , , VCC, !GLOBAL(\nreset_in~combout\))
-- \inst4|nwait_c[2]~COUT0\ = CARRY(\inst4|nwait_c[2]\ # !\inst4|nwait_c[1]~COUT0\)
-- \inst4|nwait_c[2]~COUT1\ = CARRY(\inst4|nwait_c[2]\ # !\inst4|nwait_c[1]~COUT1\)

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
	clk => \clk_in~combout\,
	dataa => \inst4|nwait_c[2]\,
	datac => VCC,
	aclr => GND,
	aload => \NOT_nreset_in~combout\,
	sload => \inst4|i~331\,
	cin0 => \inst4|nwait_c[1]~COUT0\,
	cin1 => \inst4|nwait_c[1]~COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst4|nwait_c[2]\,
	cout0 => \inst4|nwait_c[2]~COUT0\,
	cout1 => \inst4|nwait_c[2]~COUT1\);

\inst4|nwait_c[3]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|nwait_c[3]\ = DFFEA((\inst4|i~331\ & \~GND\) # (!\inst4|i~331\ & \inst4|nwait_c[3]\ $ !\inst4|nwait_c[2]~COUT0\), GLOBAL(\clk_in~combout\), VCC, , , \~GND\, !GLOBAL(\nreset_in~combout\))
-- \inst4|nwait_c[3]~COUT0\ = CARRY(!\inst4|nwait_c[3]\ & !\inst4|nwait_c[2]~COUT0\)
-- \inst4|nwait_c[3]~COUT1\ = CARRY(!\inst4|nwait_c[3]\ & !\inst4|nwait_c[2]~COUT1\)

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
	clk => \clk_in~combout\,
	datab => \inst4|nwait_c[3]\,
	datac => \~GND\,
	aclr => GND,
	aload => \NOT_nreset_in~combout\,
	sload => \inst4|i~331\,
	cin0 => \inst4|nwait_c[2]~COUT0\,
	cin1 => \inst4|nwait_c[2]~COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst4|nwait_c[3]\,
	cout0 => \inst4|nwait_c[3]~COUT0\,
	cout1 => \inst4|nwait_c[3]~COUT1\);

\inst4|nwait_c[4]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|nwait_c[4]\ = DFFEA((\inst4|i~331\ & \~GND\) # (!\inst4|i~331\ & \inst4|nwait_c[4]\ $ \inst4|nwait_c[3]~COUT0\), GLOBAL(\clk_in~combout\), VCC, , , \~GND\, !GLOBAL(\nreset_in~combout\))
-- \inst4|nwait_c[4]~COUT\ = 

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
	clk => \clk_in~combout\,
	datab => \inst4|nwait_c[4]\,
	datac => \~GND\,
	aclr => GND,
	aload => \NOT_nreset_in~combout\,
	sload => \inst4|i~331\,
	cin0 => \inst4|nwait_c[3]~COUT0\,
	cin1 => \inst4|nwait_c[3]~COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst4|nwait_c[4]\,
	cout => \inst4|nwait_c[4]~COUT\);

\inst4|nwait_c[5]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|nwait_c[5]\ = DFFEA((\inst4|i~331\ & \~GND\) # (!\inst4|i~331\ & \inst4|nwait_c[5]\ $ !(!\inst4|nwait_c[4]~COUT\ & GND) # (\inst4|nwait_c[4]~COUT\ & VCC)), GLOBAL(\clk_in~combout\), VCC, , , \~GND\, !GLOBAL(\nreset_in~combout\))
-- \inst4|nwait_c[5]~COUT0\ = CARRY(!\inst4|nwait_c[5]\ & !\inst4|nwait_c[4]~COUT\)
-- \inst4|nwait_c[5]~COUT1\ = CARRY(!\inst4|nwait_c[5]\ & !\inst4|nwait_c[4]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "C303",
	cin_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst4|nwait_c[5]\,
	datac => \~GND\,
	aclr => GND,
	aload => \NOT_nreset_in~combout\,
	sload => \inst4|i~331\,
	cin => \inst4|nwait_c[4]~COUT\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst4|nwait_c[5]\,
	cout0 => \inst4|nwait_c[5]~COUT0\,
	cout1 => \inst4|nwait_c[5]~COUT1\);

\inst4|nwait_c[6]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|nwait_c[6]\ = DFFEA((\inst4|i~331\ & \~GND\) # (!\inst4|i~331\ & \inst4|nwait_c[6]\ $ (!\inst4|nwait_c[4]~COUT\ & \inst4|nwait_c[5]~COUT0\) # (\inst4|nwait_c[4]~COUT\ & \inst4|nwait_c[5]~COUT1\)), GLOBAL(\clk_in~combout\), VCC, , , \~GND\, !GLOBAL(\nreset_in~combout\))
-- \inst4|nwait_c[6]~COUT0\ = CARRY(\inst4|nwait_c[6]\ # !\inst4|nwait_c[5]~COUT0\)
-- \inst4|nwait_c[6]~COUT1\ = CARRY(\inst4|nwait_c[6]\ # !\inst4|nwait_c[5]~COUT1\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "5AAF",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst4|nwait_c[6]\,
	datac => \~GND\,
	aclr => GND,
	aload => \NOT_nreset_in~combout\,
	sload => \inst4|i~331\,
	cin => \inst4|nwait_c[4]~COUT\,
	cin0 => \inst4|nwait_c[5]~COUT0\,
	cin1 => \inst4|nwait_c[5]~COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst4|nwait_c[6]\,
	cout0 => \inst4|nwait_c[6]~COUT0\,
	cout1 => \inst4|nwait_c[6]~COUT1\);

\inst4|nwait_c[7]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|nwait_c[7]\ = DFFEA((\inst4|i~331\ & \~GND\) # (!\inst4|i~331\ & \inst4|nwait_c[7]\ $ !(!\inst4|nwait_c[4]~COUT\ & \inst4|nwait_c[6]~COUT0\) # (\inst4|nwait_c[4]~COUT\ & \inst4|nwait_c[6]~COUT1\)), GLOBAL(\clk_in~combout\), VCC, , , \~GND\, !GLOBAL(\nreset_in~combout\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "A5A5",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst4|nwait_c[7]\,
	datac => \~GND\,
	aclr => GND,
	aload => \NOT_nreset_in~combout\,
	sload => \inst4|i~331\,
	cin => \inst4|nwait_c[4]~COUT\,
	cin0 => \inst4|nwait_c[6]~COUT0\,
	cin1 => \inst4|nwait_c[6]~COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst4|nwait_c[7]\);

\inst4|reduce_or_23~25_I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|reduce_or_23~25\ = !\inst4|nwait_c[5]\ & !\inst4|nwait_c[6]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0033",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst4|nwait_c[5]\,
	datad => \inst4|nwait_c[6]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|reduce_or_23~25\);

\inst4|reduce_or_23~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|reduce_or_23~0\ = !\inst4|nwait_c[7]\ & !\inst4|nwait_c[3]\ & !\inst4|nwait_c[4]\ & \inst4|reduce_or_23~25\

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
	dataa => \inst4|nwait_c[7]\,
	datab => \inst4|nwait_c[3]\,
	datac => \inst4|nwait_c[4]\,
	datad => \inst4|reduce_or_23~25\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|reduce_or_23~0\);

\inst4|reduce_or_23~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|reduce_or_23\ = \inst4|nwait_c[1]\ # \inst4|nwait_c[2]\ # \inst4|nwait_c[0]\ # !\inst4|reduce_or_23~0\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFFD",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst4|reduce_or_23~0\,
	datab => \inst4|nwait_c[1]\,
	datac => \inst4|nwait_c[2]\,
	datad => \inst4|nwait_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|reduce_or_23\);

\inst1|I4|i~38_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|i~38\ = \nreset_in~combout\ & \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\

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
	dataa => \nreset_in~combout\,
	datad => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|i~38\);

\inst1|I3|nreset_v_rtl_3|wysi_counter|counter_cell[0]\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]\ = DFFEA(\inst1|I3|i~195\ # !\inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )
-- \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]~COUT0\ = CARRY(\inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]\)
-- \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]~COUT1\ = CARRY(\inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]\)

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]\,
	datab => \inst1|I3|i~195\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]\,
	cout0 => \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]~COUT0\,
	cout1 => \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]~COUT1\);

\inst1|I3|nreset_v_rtl_3|wysi_counter|counter_cell[1]\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[1]\ = DFFEA(\inst1|I3|i~195\ # \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[1]\ $ \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]~COUT0\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "BEBE",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I3|i~195\,
	datab => \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[1]\,
	aclr => \NOT_nreset_in~combout\,
	cin0 => \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]~COUT0\,
	cin1 => \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]~COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[1]\);

\inst1|I3|i~195_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|i~195\ = \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]\ & \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A0A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]\,
	datac => \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|i~195\);

\inst1|I2|nreset_v_rtl_2|wysi_counter|counter_cell[0]\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]\ = DFFEA(!\inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]\ # !\inst1|I2|LessThan_7~5\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )
-- \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]~COUT0\ = CARRY(\inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]\)
-- \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]~COUT1\ = CARRY(\inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]\)

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
	clk => \clk_in~combout\,
	dataa => \inst1|I2|LessThan_7~5\,
	datab => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]\,
	cout0 => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]~COUT0\,
	cout1 => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]~COUT1\);

\inst1|I2|LessThan_7~5_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|LessThan_7~5\ = !\inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]\ # !\inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\

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
	dataa => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	datad => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|LessThan_7~5\);

\inst1|I2|nreset_v_rtl_2|wysi_counter|counter_cell[1]\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\ = DFFEA(\inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\ $ \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]~COUT0\ # !\inst1|I2|LessThan_7~5\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	datad => \inst1|I2|LessThan_7~5\,
	aclr => \NOT_nreset_in~combout\,
	cin0 => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]~COUT0\,
	cin1 => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[0]~COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\);

\inst1|I2|i~413_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|i~413\ = \nreset_in~combout\ & \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\

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
	dataa => \nreset_in~combout\,
	datad => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|i~413\);

\inst2|dwait_c~I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|dwait_c\ = DFFEA(\inst4|dwait_c\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	datac => \inst4|dwait_c\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst2|dwait_c\);

\inst1|I4|ndwe_x~10_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ndwe_x~10\ = \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ & !\inst1|I2|C_store_x~0\ & \nreset_in~combout\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2020",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	datab => \inst1|I2|C_store_x~0\,
	datac => \nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|ndwe_x~10\);

\inst1|I2|pc_mux_x[2]~233_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|pc_mux_x[2]~233\ = !\inst2|a2vi_s\ & !\inst1|I2|i~219\ # !\inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\ # !\nreset_in~combout\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5F7F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \nreset_in~combout\,
	datab => \inst2|a2vi_s\,
	datac => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	datad => \inst1|I2|i~219\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|pc_mux_x[2]~233\);

\inst1|I2|TC_c[1]~I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13789\ = \inst1|I2|TC_c[2]\ & !K1_TC_c[1] & !\inst1|I2|TC_c[0]\
-- \inst1|I2|TC_c[1]\ = DFFEA(\inst1|I2|TC_x[1]~22\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "000C",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I2|TC_c[2]\,
	datac => \inst1|I2|TC_x[1]~22\,
	datad => \inst1|I2|TC_c[0]\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13789\,
	regout => \inst1|I2|TC_c[1]\);

\cpu_int~I\ : cyclone_io 
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
	padio => ww_cpu_int,
	combout => \cpu_int~combout\);

\inst1|I2|S_x.normal~6_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|S_x.normal~6\ = !\inst1|I2|pc_mux_x[2]~233\ # !\inst1|I2|E_x.int_e~23\

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
	datac => \inst1|I2|E_x.int_e~23\,
	datad => \inst1|I2|pc_mux_x[2]~233\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|S_x.normal~6\);

\inst1|I2|S_c~10_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|S_c~10\ = DFFEA(\inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\ & (\inst1|I2|S_c~10\ & !\inst1|I2|i~412\ # !\inst1|I2|S_x.normal~6\), GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "50D0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I2|S_x.normal~6\,
	datab => \inst1|I2|S_c~10\,
	datac => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	datad => \inst1|I2|i~412\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I2|S_c~10\);

\inst1|I2|pc_mux_x[2]~234_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|pc_mux_x[2]~234\ = \nreset_in~combout\ & !\inst2|a2vi_s\ & \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\ & !\inst1|I2|i~219\

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
	dataa => \nreset_in~combout\,
	datab => \inst2|a2vi_s\,
	datac => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	datad => \inst1|I2|i~219\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|pc_mux_x[2]~234\);

\inst1|I2|i~411_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|i~411\ = !\inst1|I2|skip_x~61\ & \inst1|I2|TC_x[2]~139\ & !\inst1|I2|TC_x[1]~22\

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
	datab => \inst1|I2|skip_x~61\,
	datac => \inst1|I2|TC_x[2]~139\,
	datad => \inst1|I2|TC_x[1]~22\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|i~411\);

\inst1|I2|i~412_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|i~412\ = !\inst1|I2|TC_x[0]~146\ & \inst1|I2|S_c~10\ & \inst1|I2|pc_mux_x[2]~234\ & \inst1|I2|i~411\

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
	dataa => \inst1|I2|TC_x[0]~146\,
	datab => \inst1|I2|S_c~10\,
	datac => \inst1|I2|pc_mux_x[2]~234\,
	datad => \inst1|I2|i~411\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|i~412\);

\inst1|I2|i~284_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|i~284\ = !\inst1|I2|E_x.int_e~23\ & \inst1|I2|i~412\

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
	datac => \inst1|I2|E_x.int_e~23\,
	datad => \inst1|I2|i~412\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|i~284\);

\inst1|I2|int_stop_c~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|int_stop_x~11\ = \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\ & (\inst1|I2|i~284\ # !\inst1|I2|pc_mux_x[2]~233\ & K1_int_stop_c)
-- \inst1|I2|int_stop_c\ = DFFEA(\inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "AA20",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	datab => \inst1|I2|pc_mux_x[2]~233\,
	datad => \inst1|I2|i~284\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|int_stop_x~11\,
	regout => \inst1|I2|int_stop_c\);

\inst1|I2|S_c~9_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|S_c~9\ = DFFEA(\inst1|I2|i~284\ # \inst1|I2|S_x.normal~6\ & \inst1|I2|S_c~9\ # !\inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FBF3",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I2|S_x.normal~6\,
	datab => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	datac => \inst1|I2|i~284\,
	datad => \inst1|I2|S_c~9\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I2|S_c~9\);

\inst1|I2|E_x.int_e~67_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|E_x.int_e~67\ = \cpu_int~combout\ & !\inst2|a2vi_s\ & !\inst1|I2|int_stop_c\ & \inst1|I2|S_c~9\

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
	dataa => \cpu_int~combout\,
	datab => \inst2|a2vi_s\,
	datac => \inst1|I2|int_stop_c\,
	datad => \inst1|I2|S_c~9\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|E_x.int_e~67\);

\inst1|I2|E_x.int_e~23_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|E_x.int_e~23\ = \nreset_in~combout\ & !\inst1|I2|i~219\ & \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\ & \inst1|I2|E_x.int_e~67\

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
	dataa => \nreset_in~combout\,
	datab => \inst1|I2|i~219\,
	datac => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	datad => \inst1|I2|E_x.int_e~67\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|E_x.int_e~23\);

\inst1|I2|int_start_c~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|int_start_c\ = DFFEA(\inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\ & (\inst1|I2|E_x.int_e~23\ # \inst1|I2|int_start_c\ & \inst1|I2|E_x.dwait_e~0\), GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EC00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I2|int_start_c\,
	datab => \inst1|I2|E_x.int_e~23\,
	datac => \inst1|I2|E_x.dwait_e~0\,
	datad => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I2|int_start_c\);

\inst1|I3|i~161_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|i~161\ = \inst1|I3|i~204\ & (!\inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\ # !\inst1|I2|i~219\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "50F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|i~219\,
	datac => \inst1|I3|i~204\,
	datad => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|i~161\);

\inst1|I2|TC_c[2]~I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13740\ = !\inst1|I2|TC_c[0]\ & \inst1|I2|TD_c[3]\ & !K1_TC_c[2] & !\inst1|I2|TC_c[1]\
-- \inst1|I2|TC_c[2]\ = DFFEA(\inst1|I2|TC_x[2]~139\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "0004",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I2|TC_c[0]\,
	datab => \inst1|I2|TD_c[3]\,
	datac => \inst1|I2|TC_x[2]~139\,
	datad => \inst1|I2|TC_c[1]\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13740\,
	regout => \inst1|I2|TC_c[2]\);

\inst1|I2|idata_c[0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|idata_x[0]~21\ = \inst1|I2|E_x.dwait_e~0\ & K1_idata_c[0] # !\inst1|I2|E_x.dwait_e~0\ & \inst|altsyncram_component|q_a[0]\
-- \inst1|I2|idata_c[0]\ = DFFEA(\inst1|I2|idata_x[0]~21\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "F3C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I2|E_x.dwait_e~0\,
	datad => \inst|altsyncram_component|q_a[0]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|idata_x[0]~21\,
	regout => \inst1|I2|idata_c[0]\);

\rtl~13594_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13594\ = !\inst1|I2|idata_x[3]~18\ & (\inst1|I2|E_x.dwait_e~0\ & !\inst1|I2|idata_c[0]\ # !\inst1|I2|E_x.dwait_e~0\ & !\inst|altsyncram_component|q_a[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "010D",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst|altsyncram_component|q_a[0]\,
	datab => \inst1|I2|E_x.dwait_e~0\,
	datac => \inst1|I2|idata_x[3]~18\,
	datad => \inst1|I2|idata_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13594\);

\inst1|I3|reduce_nor_95~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|reduce_nor_95\ = \inst1|I2|TC_c[2]\ # \inst1|I2|TC_c[0]\ # !\inst1|I2|TC_c[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FCFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst1|I2|TC_c[2]\,
	datac => \inst1|I2|TC_c[0]\,
	datad => \inst1|I2|TC_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|reduce_nor_95\);

\inst1|I2|data_is_c[3]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|idata_x[7]~33\ = \inst1|I2|E_x.dwait_e~0\ & K1_data_is_c[3] # !\inst1|I2|E_x.dwait_e~0\ & \inst|altsyncram_component|q_a[7]\
-- \inst1|I2|data_is_c[3]\ = DFFEA(\inst1|I2|idata_x[7]~33\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "F3C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I2|E_x.dwait_e~0\,
	datad => \inst|altsyncram_component|q_a[7]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|idata_x[7]~33\,
	regout => \inst1|I2|data_is_c[3]\);

\inst1|I4|dexp_we_c~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|dexp_we_c\ = DFFEA(\inst1|I2|idata_x[4]~39\ & !\inst1|I2|idata_x[5]~36\ & \inst1|I2|idata_x[6]~30\ & \inst1|I4|ireg_we_x~10\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I2|idata_x[4]~39\,
	datab => \inst1|I2|idata_x[5]~36\,
	datac => \inst1|I2|idata_x[6]~30\,
	datad => \inst1|I4|ireg_we_x~10\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|dexp_we_c\);

\inst1|I4|ireg_i[9]~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ireg_i[9]~1\ = \inst1|I2|int_start_c\ & \nreset_in~combout\

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
	datac => \inst1|I2|int_start_c\,
	datad => \nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|ireg_i[9]~1\);

\inst1|I4|data_exp_i[3]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_exp_x[3]~5\ = \inst1|I4|dexp_we_c\ & \inst1|I3|acc_c[0][3]\ # !\inst1|I4|dexp_we_c\ & \inst1|I4|data_exp_c[3]\ & \inst1|I4|i~38\
-- \inst1|I4|data_exp_i[3]\ = DFFEA(\inst1|I4|data_exp_x[3]~5\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F808",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|data_exp_c[3]\,
	datab => \inst1|I4|i~38\,
	datac => \inst1|I4|dexp_we_c\,
	datad => \inst1|I3|acc_c[0][3]\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_exp_x[3]~5\,
	regout => \inst1|I4|data_exp_i[3]\);

\inst1|I4|data_exp_c[3]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_exp_c[3]\ = DFFEA(\inst1|I4|data_exp_x[3]~5\ & (\inst1|I4|data_exp_i[3]\ # !\inst1|I2|int_stop_x~11\) # !\inst1|I4|data_exp_x[3]~5\ & \inst1|I4|data_exp_i[3]\ & \inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|data_exp_x[3]~5\,
	datac => \inst1|I4|data_exp_i[3]\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|data_exp_c[3]\);

\inst1|I4|iinc_i[3]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_x[3]~26\ = \inst1|I4|iinc_we_c\ & \inst1|I3|acc_c[0][3]\ # !\inst1|I4|iinc_we_c\ & \inst1|I4|i~38\ & \inst1|I4|iinc_c[3]\
-- \inst1|I4|iinc_i[3]\ = DFFEA(\inst1|I4|iinc_x[3]~26\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAC0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][3]\,
	datab => \inst1|I4|i~38\,
	datac => \inst1|I4|iinc_c[3]\,
	datad => \inst1|I4|iinc_we_c\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iinc_x[3]~26\,
	regout => \inst1|I4|iinc_i[3]\);

\inst1|I4|iinc_c[3]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_c[3]\ = DFFEA(\inst1|I4|iinc_i[3]\ & (\inst1|I4|iinc_x[3]~26\ # \inst1|I2|int_stop_x~11\) # !\inst1|I4|iinc_i[3]\ & \inst1|I4|iinc_x[3]~26\ & !\inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|iinc_i[3]\,
	datac => \inst1|I4|iinc_x[3]~26\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|iinc_c[3]\);

\inst1|I4|reduce_nor_207~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|reduce_nor_207\ = \inst1|I2|idata_x[6]~30\ # \inst1|I2|idata_x[5]~36\ # !\inst1|I2|idata_x[4]~39\

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
	datab => \inst1|I2|idata_x[4]~39\,
	datac => \inst1|I2|idata_x[6]~30\,
	datad => \inst1|I2|idata_x[5]~36\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|reduce_nor_207\);

\inst1|I3|data_x[9]~3459_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[9]~3459\ = !\inst1|I2|idata_x[4]~39\ & !\inst1|I2|idata_x[6]~30\ & \inst1|I2|idata_x[5]~36\

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
	datab => \inst1|I2|idata_x[4]~39\,
	datac => \inst1|I2|idata_x[6]~30\,
	datad => \inst1|I2|idata_x[5]~36\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[9]~3459\);

\inst1|I3|data_x[3]~3886_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[3]~3886\ = \inst1|I4|ireg_c[3]\ & (\inst1|I4|iinc_c[3]\ & \inst1|I3|data_x[9]~3459\ # !\inst1|I4|reduce_nor_207\) # !\inst1|I4|ireg_c[3]\ & \inst1|I4|iinc_c[3]\ & \inst1|I3|data_x[9]~3459\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CE0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ireg_c[3]\,
	datab => \inst1|I4|iinc_c[3]\,
	datac => \inst1|I4|reduce_nor_207\,
	datad => \inst1|I3|data_x[9]~3459\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[3]~3886\);

\inst1|I3|data_x[9]~3457_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[9]~3457\ = \inst1|I2|ndre_x~49\ & (\inst1|I2|idata_x[6]~30\ # \inst1|I2|idata_x[4]~39\ $ !\inst1|I2|idata_x[5]~36\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EB00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|idata_x[6]~30\,
	datab => \inst1|I2|idata_x[4]~39\,
	datac => \inst1|I2|idata_x[5]~36\,
	datad => \inst1|I2|ndre_x~49\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[9]~3457\);

\inst1|I3|data_x[6]~3461_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[6]~3461\ = \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ & \nreset_in~combout\ & \inst1|I3|reduce_nor_95\

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
	datab => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	datac => \nreset_in~combout\,
	datad => \inst1|I3|reduce_nor_95\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[6]~3461\);

\inst1|I4|i~2618_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|i~2618\ = \inst1|I2|idata_x[6]~30\ # \inst1|I2|idata_x[4]~39\ $ !\inst1|I2|idata_x[5]~36\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FCF3",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst1|I2|idata_x[4]~39\,
	datac => \inst1|I2|idata_x[6]~30\,
	datad => \inst1|I2|idata_x[5]~36\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|i~2618\);

\inst1|I3|data_x[9]~3458_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[9]~3458\ = \inst1|I3|data_x[6]~3461\ & \inst1|I4|i~2617\ & (\inst1|I4|i~2618\ # \inst1|I2|ndre_x~49\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|data_x[6]~3461\,
	datab => \inst1|I4|i~2618\,
	datac => \inst1|I2|ndre_x~49\,
	datad => \inst1|I4|i~2617\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[9]~3458\);

\inst1|I3|data_x[3]~3093_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[3]~3093\ = \inst1|I3|data_x[9]~3458\ & (\inst1|I3|data_x[3]~3886\ # \inst1|I4|data_exp_c[3]\ & \inst1|I3|data_x[9]~3457\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EC00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|data_exp_c[3]\,
	datab => \inst1|I3|data_x[3]~3886\,
	datac => \inst1|I3|data_x[9]~3457\,
	datad => \inst1|I3|data_x[9]~3458\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[3]~3093\);

\DATA_IN_EXT[3]~I\ : cyclone_io 
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
	padio => ww_DATA_IN_EXT(3),
	combout => \DATA_IN_EXT[3]~combout\);

\DATA_IN_EXT[13]~I\ : cyclone_io 
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
	padio => ww_DATA_IN_EXT(13),
	combout => \DATA_IN_EXT[13]~combout\);

\inst1|I4|iinc_i[7]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_x[7]~23\ = \inst1|I4|iinc_we_c\ & \inst1|I3|acc_c[0][7]\ # !\inst1|I4|iinc_we_c\ & \inst1|I4|i~38\ & \inst1|I4|iinc_c[7]\
-- \inst1|I4|iinc_i[7]\ = DFFEA(\inst1|I4|iinc_x[7]~23\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|i~38\,
	datab => \inst1|I4|iinc_we_c\,
	datac => \inst1|I3|acc_c[0][7]\,
	datad => \inst1|I4|iinc_c[7]\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iinc_x[7]~23\,
	regout => \inst1|I4|iinc_i[7]\);

\inst1|I4|iinc_c[7]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_c[7]\ = DFFEA(\inst1|I4|iinc_i[7]\ & (\inst1|I4|iinc_x[7]~23\ # \inst1|I2|int_stop_x~11\) # !\inst1|I4|iinc_i[7]\ & \inst1|I4|iinc_x[7]~23\ & !\inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|iinc_i[7]\,
	datac => \inst1|I4|iinc_x[7]~23\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|iinc_c[7]\);

\inst1|I2|data_is_c[5]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|idata_x[9]~60\ = \inst1|I2|E_x.dwait_e~0\ & K1_data_is_c[5] # !\inst1|I2|E_x.dwait_e~0\ & \inst|altsyncram_component|q_a[9]\
-- \inst1|I2|data_is_c[5]\ = DFFEA(\inst1|I2|idata_x[9]~60\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "F3C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I2|E_x.dwait_e~0\,
	datad => \inst|altsyncram_component|q_a[9]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|idata_x[9]~60\,
	regout => \inst1|I2|data_is_c[5]\);

\DATA_IN_EXT[5]~I\ : cyclone_io 
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
	padio => ww_DATA_IN_EXT(5),
	combout => \DATA_IN_EXT[5]~combout\);

\inst1|I3|data_x[6]~329_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[6]~329\ = !\inst1|I4|i~2617\ # !\inst1|I2|ndre_x~49\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "33FF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst1|I2|ndre_x~49\,
	datad => \inst1|I4|i~2617\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[6]~329\);

\inst1|I3|data_x[6]~3456_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[6]~3456\ = \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ & \nreset_in~combout\ & \inst1|I3|reduce_nor_95\ & \inst1|I3|data_x[6]~329\

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
	dataa => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	datab => \nreset_in~combout\,
	datac => \inst1|I3|reduce_nor_95\,
	datad => \inst1|I3|data_x[6]~329\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[6]~3456\);

\inst1|I3|data_x[5]~447_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[5]~447\ = \inst1|I3|data_x[6]~3456\ & (\inst3|mux_c[0]\ & \DATA_IN_EXT[5]~combout\ # !\inst3|mux_c[0]\ & \inst|altsyncram_component|q_a[5]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst3|mux_c[0]\,
	datab => \inst|altsyncram_component|q_a[5]\,
	datac => \DATA_IN_EXT[5]~combout\,
	datad => \inst1|I3|data_x[6]~3456\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[5]~447\);

\inst1|I4|data_exp_i[5]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iadata_x[17]~8\ = \inst1|I4|dexp_we_c\ & \inst1|I3|acc_c[0][5]\ # !\inst1|I4|dexp_we_c\ & \inst1|I4|data_exp_c[5]\ & \inst1|I4|i~38\
-- \inst1|I4|data_exp_i[5]\ = DFFEA(\inst1|I4|iadata_x[17]~8\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|data_exp_c[5]\,
	datab => \inst1|I4|dexp_we_c\,
	datac => \inst1|I3|acc_c[0][5]\,
	datad => \inst1|I4|i~38\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iadata_x[17]~8\,
	regout => \inst1|I4|data_exp_i[5]\);

\inst1|I4|data_exp_c[5]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_exp_c[5]\ = DFFEA(\inst1|I4|iadata_x[17]~8\ & (\inst1|I4|data_exp_i[5]\ # !\inst1|I2|int_stop_x~11\) # !\inst1|I4|iadata_x[17]~8\ & \inst1|I4|data_exp_i[5]\ & \inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|iadata_x[17]~8\,
	datac => \inst1|I4|data_exp_i[5]\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|data_exp_c[5]\);

\inst1|I2|Mux_77~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|Mux_77~0\ = \inst1|I2|idata_x[4]~39\ & !\inst1|I2|idata_x[7]~33\ & (\inst1|I2|idata_x[5]~36\ $ \inst1|I2|idata_x[6]~30\) # !\inst1|I2|idata_x[4]~39\ & \inst1|I2|idata_x[5]~36\ & (!\inst1|I2|idata_x[7]~33\ # !\inst1|I2|idata_x[6]~30\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "026A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|idata_x[5]~36\,
	datab => \inst1|I2|idata_x[4]~39\,
	datac => \inst1|I2|idata_x[6]~30\,
	datad => \inst1|I2|idata_x[7]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|Mux_77~0\);

\inst1|I2|TD_c[1]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|TD_c[1]\ = DFFEA(\inst1|I2|idata_x[1]~24\ # \inst1|I2|Mux_77~0\ & !\inst1|I2|idata_x[2]~27\ & \rtl~13594\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CECC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I2|Mux_77~0\,
	datab => \inst1|I2|idata_x[1]~24\,
	datac => \inst1|I2|idata_x[2]~27\,
	datad => \rtl~13594\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I2|TD_c[1]\);

\rtl~13595_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13595\ = \inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[2]\

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
	datac => \inst1|I2|TD_c[1]\,
	datad => \inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13595\);

\DATA_IN_EXT[15]~I\ : cyclone_io 
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
	padio => ww_DATA_IN_EXT(15),
	combout => \DATA_IN_EXT[15]~combout\);

\inst1|I1|nreset_v_rtl_5|wysi_counter|counter_cell[0]\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]\ = DFFEA(!\inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]\ # !\inst1|I1|LessThan_7~5\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )
-- \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]~COUT0\ = CARRY(\inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]\)
-- \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]~COUT1\ = CARRY(\inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]\)

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
	clk => \clk_in~combout\,
	dataa => \inst1|I1|LessThan_7~5\,
	datab => \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]\,
	cout0 => \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]~COUT0\,
	cout1 => \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]~COUT1\);

\inst1|I1|LessThan_7~5_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|LessThan_7~5\ = !\inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]\ # !\inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\

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
	dataa => \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\,
	datad => \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|LessThan_7~5\);

\inst1|I1|nreset_v_rtl_5|wysi_counter|counter_cell[1]\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\ = DFFEA(\inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\ $ \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]~COUT0\ # !\inst1|I1|LessThan_7~5\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\,
	datad => \inst1|I1|LessThan_7~5\,
	aclr => \NOT_nreset_in~combout\,
	cin0 => \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]~COUT0\,
	cin1 => \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[0]~COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\);

\inst1|I1|i~2_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|i~2\ = \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\ & \nreset_in~combout\

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
	datac => \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\,
	datad => \nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|i~2\);

\inst1|I2|pc_mux_x[2]~236_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|pc_mux_x[2]~236\ = \nreset_in~combout\ & \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\ & !\inst1|I2|skip_x~61\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0088",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \nreset_in~combout\,
	datab => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	datad => \inst1|I2|skip_x~61\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|pc_mux_x[2]~236\);

\inst1|I2|pc_mux_x[2]~352_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|pc_mux_x[2]~352\ = \inst1|I2|pc_mux_x[2]~236\ & (!\inst1|I2|TC_x[2]~139\ # !\inst1|I2|TC_x[1]~22\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0CCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst1|I2|pc_mux_x[2]~236\,
	datac => \inst1|I2|TC_x[1]~22\,
	datad => \inst1|I2|TC_x[2]~139\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|pc_mux_x[2]~352\);

\inst1|I2|i~105_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|i~105\ = \inst1|I2|i~411\ & (\inst1|I2|S_c~10\ # \inst1|I2|TC_x[0]~146\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FC00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst1|I2|S_c~10\,
	datac => \inst1|I2|TC_x[0]~146\,
	datad => \inst1|I2|i~411\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|i~105\);

\inst1|I2|pc_mux_x[2]~26_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|pc_mux_x[2]~26\ = \inst1|I2|pc_mux_x[2]~234\ & (\inst1|I2|E_x.int_e~23\ # \inst1|I2|pc_mux_x[2]~352\ & \inst1|I2|i~105\)

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
	dataa => \inst1|I2|pc_mux_x[2]~234\,
	datab => \inst1|I2|E_x.int_e~23\,
	datac => \inst1|I2|pc_mux_x[2]~352\,
	datad => \inst1|I2|i~105\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|pc_mux_x[2]~26\);

\inst1|I2|pc_mux_x[1]~346_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|pc_mux_x[1]~346\ = \nreset_in~combout\ & \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\ & !\inst1|I2|skip_x~61\ & \inst1|I2|pc_mux_x[2]~233\

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
	dataa => \nreset_in~combout\,
	datab => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	datac => \inst1|I2|skip_x~61\,
	datad => \inst1|I2|pc_mux_x[2]~233\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|pc_mux_x[1]~346\);

\inst1|I2|reduce_nor_136~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|reduce_nor_136\ = !\inst1|I2|TC_x[1]~22\ # !\inst1|I2|TC_x[0]~146\ # !\inst1|I2|TC_x[2]~139\

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
	datab => \inst1|I2|TC_x[2]~139\,
	datac => \inst1|I2|TC_x[0]~146\,
	datad => \inst1|I2|TC_x[1]~22\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|reduce_nor_136\);

\inst1|I2|pc_mux_x[1]~328_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|pc_mux_x[1]~328\ = \inst1|I2|TC_x[2]~139\ & (\inst1|I2|TC_x[0]~146\ & !\inst1|I2|E_x.int_e~23\ # !\inst1|I2|TC_x[0]~146\ & \inst1|I2|TC_x[1]~22\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5C00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|E_x.int_e~23\,
	datab => \inst1|I2|TC_x[1]~22\,
	datac => \inst1|I2|TC_x[0]~146\,
	datad => \inst1|I2|TC_x[2]~139\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|pc_mux_x[1]~328\);

\inst1|I2|i~9_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|i~9\ = \inst1|I2|S_c~10\ & !\inst1|I2|TC_x[0]~146\ & \inst1|I2|i~411\

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
	datab => \inst1|I2|S_c~10\,
	datac => \inst1|I2|TC_x[0]~146\,
	datad => \inst1|I2|i~411\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|i~9\);

\inst1|I2|pc_mux_x[1]~49_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|pc_mux_x[1]~49\ = \inst1|I2|pc_mux_x[1]~346\ & (\inst1|I2|pc_mux_x[1]~328\ # \inst1|I2|reduce_nor_136\ & \inst1|I2|i~9\)

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
	dataa => \inst1|I2|pc_mux_x[1]~346\,
	datab => \inst1|I2|reduce_nor_136\,
	datac => \inst1|I2|pc_mux_x[1]~328\,
	datad => \inst1|I2|i~9\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|pc_mux_x[1]~49\);

\inst1|I2|ndre_x~50_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|ndre_x~50\ = !\inst1|I2|skip_x~61\ & \inst1|I2|pc_mux_x[2]~233\

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
	datac => \inst1|I2|skip_x~61\,
	datad => \inst1|I2|pc_mux_x[2]~233\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|ndre_x~50\);

\inst1|I2|pc_mux_x[0]~282_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|pc_mux_x[0]~282\ = \inst1|I2|ndre_x~50\ & (\inst1|I2|TC_x[0]~146\ # !\inst1|I2|TC_x[2]~139\ # !\inst1|I2|TC_x[1]~22\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AA2A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|ndre_x~50\,
	datab => \inst1|I2|TC_x[1]~22\,
	datac => \inst1|I2|TC_x[2]~139\,
	datad => \inst1|I2|TC_x[0]~146\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|pc_mux_x[0]~282\);

\inst1|I2|pc_mux_x[0]~161_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|pc_mux_x[0]~161\ = \inst1|I2|i~105\ # \inst1|I2|E_x.int_e~23\ & \inst1|I2|C_raw~6\ # !\inst1|I2|reduce_nor_136\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FBBB",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|i~105\,
	datab => \inst1|I2|reduce_nor_136\,
	datac => \inst1|I2|E_x.int_e~23\,
	datad => \inst1|I2|C_raw~6\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|pc_mux_x[0]~161\);

\inst1|I2|pc_mux_x[0]~158_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|pc_mux_x[0]~158\ = !\inst1|I2|C_raw~6\ & (\inst1|I2|TC_x[0]~146\ # !\inst1|I2|TC_x[1]~22\ # !\inst1|I2|TC_x[2]~139\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00F7",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TC_x[2]~139\,
	datab => \inst1|I2|TC_x[1]~22\,
	datac => \inst1|I2|TC_x[0]~146\,
	datad => \inst1|I2|C_raw~6\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|pc_mux_x[0]~158\);

\inst1|I2|pc_mux_x[0]~171_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|pc_mux_x[0]~171\ = !\inst1|I2|E_x.int_e~23\ & \inst1|I2|pc_mux_x[2]~233\ & (\inst1|I2|skip_x~61\ # \inst1|I2|pc_mux_x[0]~158\)

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
	dataa => \inst1|I2|E_x.int_e~23\,
	datab => \inst1|I2|pc_mux_x[2]~233\,
	datac => \inst1|I2|skip_x~61\,
	datad => \inst1|I2|pc_mux_x[0]~158\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|pc_mux_x[0]~171\);

\inst1|I2|pc_mux_x[0]~167_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|pc_mux_x[0]~167\ = \inst1|I2|pc_mux_x[0]~171\ # \inst1|I2|pc_mux_x[0]~282\ & \inst1|I2|pc_mux_x[0]~161\ # !\inst1|I2|i~413\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFD5",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|i~413\,
	datab => \inst1|I2|pc_mux_x[0]~282\,
	datac => \inst1|I2|pc_mux_x[0]~161\,
	datad => \inst1|I2|pc_mux_x[0]~171\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|pc_mux_x[0]~167\);

\inst1|I1|Mux_41_rtl_211~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_41_rtl_211~0\ = \inst1|I2|pc_mux_x[1]~49\ & \inst1|I2|pc_mux_x[0]~167\

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
	datac => \inst1|I2|pc_mux_x[1]~49\,
	datad => \inst1|I2|pc_mux_x[0]~167\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_41_rtl_211~0\);

\inst1|I1|i~17_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|i~17\ = \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\ & \nreset_in~combout\ & (\inst1|I2|pc_mux_x[2]~26\ $ \inst1|I1|Mux_41_rtl_211~0\)

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
	dataa => \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\,
	datab => \inst1|I2|pc_mux_x[2]~26\,
	datac => \nreset_in~combout\,
	datad => \inst1|I1|Mux_41_rtl_211~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|i~17\);

\inst1|I1|Mux_67~8_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_67~8\ = \nreset_in~combout\ & \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\ & \inst1|I2|pc_mux_x[2]~26\

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
	dataa => \nreset_in~combout\,
	datac => \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\,
	datad => \inst1|I2|pc_mux_x[2]~26\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_67~8\);

\inst11|inst8|addr_c[0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|addr_c[0]\ = DFFEA(!\inst11|inst8|add_15_rtl_597~10\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	datad => \inst11|inst8|add_15_rtl_597~10\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst11|inst8|addr_c[0]\);

\inst1|I1|i~18_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|i~18\ = \inst1|I2|pc_mux_x[1]~49\ & \inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|Mux_67~8\

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
	dataa => \inst1|I2|pc_mux_x[1]~49\,
	datac => \inst1|I2|pc_mux_x[0]~167\,
	datad => \inst1|I1|Mux_67~8\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|i~18\);

\inst11|inst8|add_17_rtl_0~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_17_rtl_0~0\ = \inst11|inst8|addr_c[0]\ $ !\inst1|I1|i~18\
-- \inst11|inst8|add_17_rtl_0~0COUT0\ = CARRY(!\inst11|inst8|addr_c[0]\ & \inst1|I1|i~18\)
-- \inst11|inst8|add_17_rtl_0~0COUT1\ = CARRY(!\inst11|inst8|addr_c[0]\ & \inst1|I1|i~18\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "9944",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst11|inst8|addr_c[0]\,
	datab => \inst1|I1|i~18\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_17_rtl_0~0\,
	cout0 => \inst11|inst8|add_17_rtl_0~0COUT0\,
	cout1 => \inst11|inst8|add_17_rtl_0~0COUT1\);

\inst11|inst8|add_15_rtl_597~10_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_15_rtl_597~10\ = \inst11|inst8|addr_c[0]\ & (\inst11|inst8|add_17_rtl_0~0\ # \inst1|I1|i~17\) # !\inst11|inst8|addr_c[0]\ & \inst11|inst8|add_17_rtl_0~0\ & !\inst1|I1|i~17\

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
	dataa => \inst11|inst8|addr_c[0]\,
	datac => \inst11|inst8|add_17_rtl_0~0\,
	datad => \inst1|I1|i~17\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_15_rtl_597~10\);

\inst11|inst8|addr_c[1]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|addr_c[1]\ = DFFEA(!\inst11|inst8|add_15_rtl_597~13\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	datac => \inst11|inst8|add_15_rtl_597~13\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst11|inst8|addr_c[1]\);

\inst11|inst8|add_15~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_15~0COUT0\ = CARRY(!\inst11|inst8|addr_c[0]\)
-- \inst11|inst8|add_15~0COUT1\ = CARRY(!\inst11|inst8|addr_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF33",
	output_mode => "none")
-- pragma translate_on
PORT MAP (
	datab => \inst11|inst8|addr_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	cout0 => \inst11|inst8|add_15~0COUT0\,
	cout1 => \inst11|inst8|add_15~0COUT1\);

\inst11|inst8|add_15~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_15~1\ = \inst11|inst8|addr_c[1]\ $ !\inst11|inst8|add_15~0COUT0\
-- \inst11|inst8|add_15~1COUT0\ = CARRY(\inst11|inst8|addr_c[1]\ # !\inst11|inst8|add_15~0COUT0\)
-- \inst11|inst8|add_15~1COUT1\ = CARRY(\inst11|inst8|addr_c[1]\ # !\inst11|inst8|add_15~0COUT1\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "C3CF",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst11|inst8|addr_c[1]\,
	cin0 => \inst11|inst8|add_15~0COUT0\,
	cin1 => \inst11|inst8|add_15~0COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_15~1\,
	cout0 => \inst11|inst8|add_15~1COUT0\,
	cout1 => \inst11|inst8|add_15~1COUT1\);

\inst11|inst8|add_17_rtl_0~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_17_rtl_0~1\ = \inst11|inst8|addr_c[1]\ $ \inst1|I1|i~18\ $ !\inst11|inst8|add_17_rtl_0~0COUT0\
-- \inst11|inst8|add_17_rtl_0~1COUT0\ = CARRY(\inst11|inst8|addr_c[1]\ & (!\inst11|inst8|add_17_rtl_0~0COUT0\ # !\inst1|I1|i~18\) # !\inst11|inst8|addr_c[1]\ & !\inst1|I1|i~18\ & !\inst11|inst8|add_17_rtl_0~0COUT0\)
-- \inst11|inst8|add_17_rtl_0~1COUT1\ = CARRY(\inst11|inst8|addr_c[1]\ & (!\inst11|inst8|add_17_rtl_0~0COUT1\ # !\inst1|I1|i~18\) # !\inst11|inst8|addr_c[1]\ & !\inst1|I1|i~18\ & !\inst11|inst8|add_17_rtl_0~0COUT1\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "692B",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst11|inst8|addr_c[1]\,
	datab => \inst1|I1|i~18\,
	cin0 => \inst11|inst8|add_17_rtl_0~0COUT0\,
	cin1 => \inst11|inst8|add_17_rtl_0~0COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_17_rtl_0~1\,
	cout0 => \inst11|inst8|add_17_rtl_0~1COUT0\,
	cout1 => \inst11|inst8|add_17_rtl_0~1COUT1\);

\inst11|inst8|add_15_rtl_597~13_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_15_rtl_597~13\ = \inst11|inst8|add_15~1\ & (\inst1|I1|i~17\ # \inst11|inst8|add_17_rtl_0~1\) # !\inst11|inst8|add_15~1\ & !\inst1|I1|i~17\ & \inst11|inst8|add_17_rtl_0~1\

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
	dataa => \inst11|inst8|add_15~1\,
	datac => \inst1|I1|i~17\,
	datad => \inst11|inst8|add_17_rtl_0~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_15_rtl_597~13\);

\inst11|inst8|addr_c[2]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|addr_c[2]\ = DFFEA(!\inst11|inst8|add_15_rtl_597~16\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	datad => \inst11|inst8|add_15_rtl_597~16\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst11|inst8|addr_c[2]\);

\inst11|inst8|add_15~2_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_15~2\ = \inst11|inst8|addr_c[2]\ $ \inst11|inst8|add_15~1COUT0\
-- \inst11|inst8|add_15~2COUT0\ = CARRY(!\inst11|inst8|addr_c[2]\ & !\inst11|inst8|add_15~1COUT0\)
-- \inst11|inst8|add_15~2COUT1\ = CARRY(!\inst11|inst8|addr_c[2]\ & !\inst11|inst8|add_15~1COUT1\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "3C03",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst11|inst8|addr_c[2]\,
	cin0 => \inst11|inst8|add_15~1COUT0\,
	cin1 => \inst11|inst8|add_15~1COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_15~2\,
	cout0 => \inst11|inst8|add_15~2COUT0\,
	cout1 => \inst11|inst8|add_15~2COUT1\);

\inst11|inst8|add_17_rtl_0~2_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_17_rtl_0~2\ = \inst11|inst8|addr_c[2]\ $ \inst1|I1|i~18\ $ \inst11|inst8|add_17_rtl_0~1COUT0\
-- \inst11|inst8|add_17_rtl_0~2COUT0\ = CARRY(\inst11|inst8|addr_c[2]\ & \inst1|I1|i~18\ & !\inst11|inst8|add_17_rtl_0~1COUT0\ # !\inst11|inst8|addr_c[2]\ & (\inst1|I1|i~18\ # !\inst11|inst8|add_17_rtl_0~1COUT0\))
-- \inst11|inst8|add_17_rtl_0~2COUT1\ = CARRY(\inst11|inst8|addr_c[2]\ & \inst1|I1|i~18\ & !\inst11|inst8|add_17_rtl_0~1COUT1\ # !\inst11|inst8|addr_c[2]\ & (\inst1|I1|i~18\ # !\inst11|inst8|add_17_rtl_0~1COUT1\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "964D",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst11|inst8|addr_c[2]\,
	datab => \inst1|I1|i~18\,
	cin0 => \inst11|inst8|add_17_rtl_0~1COUT0\,
	cin1 => \inst11|inst8|add_17_rtl_0~1COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_17_rtl_0~2\,
	cout0 => \inst11|inst8|add_17_rtl_0~2COUT0\,
	cout1 => \inst11|inst8|add_17_rtl_0~2COUT1\);

\inst11|inst8|add_15_rtl_597~16_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_15_rtl_597~16\ = \inst11|inst8|add_15~2\ & (\inst1|I1|i~17\ # \inst11|inst8|add_17_rtl_0~2\) # !\inst11|inst8|add_15~2\ & !\inst1|I1|i~17\ & \inst11|inst8|add_17_rtl_0~2\

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
	datab => \inst11|inst8|add_15~2\,
	datac => \inst1|I1|i~17\,
	datad => \inst11|inst8|add_17_rtl_0~2\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_15_rtl_597~16\);

\inst11|inst8|addr_c[3]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|addr_c[3]\ = DFFEA(!\inst11|inst8|add_15_rtl_597~19\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	datad => \inst11|inst8|add_15_rtl_597~19\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst11|inst8|addr_c[3]\);

\inst11|inst8|add_15~3_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_15~3\ = \inst11|inst8|addr_c[3]\ $ !\inst11|inst8|add_15~2COUT0\
-- \inst11|inst8|add_15~3COUT0\ = CARRY(\inst11|inst8|addr_c[3]\ # !\inst11|inst8|add_15~2COUT0\)
-- \inst11|inst8|add_15~3COUT1\ = CARRY(\inst11|inst8|addr_c[3]\ # !\inst11|inst8|add_15~2COUT1\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "A5AF",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst11|inst8|addr_c[3]\,
	cin0 => \inst11|inst8|add_15~2COUT0\,
	cin1 => \inst11|inst8|add_15~2COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_15~3\,
	cout0 => \inst11|inst8|add_15~3COUT0\,
	cout1 => \inst11|inst8|add_15~3COUT1\);

\inst11|inst8|add_17_rtl_0~3_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_17_rtl_0~3\ = \inst11|inst8|addr_c[3]\ $ \inst1|I1|i~18\ $ !\inst11|inst8|add_17_rtl_0~2COUT0\
-- \inst11|inst8|add_17_rtl_0~3COUT0\ = CARRY(\inst11|inst8|addr_c[3]\ & (!\inst11|inst8|add_17_rtl_0~2COUT0\ # !\inst1|I1|i~18\) # !\inst11|inst8|addr_c[3]\ & !\inst1|I1|i~18\ & !\inst11|inst8|add_17_rtl_0~2COUT0\)
-- \inst11|inst8|add_17_rtl_0~3COUT1\ = CARRY(\inst11|inst8|addr_c[3]\ & (!\inst11|inst8|add_17_rtl_0~2COUT1\ # !\inst1|I1|i~18\) # !\inst11|inst8|addr_c[3]\ & !\inst1|I1|i~18\ & !\inst11|inst8|add_17_rtl_0~2COUT1\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "692B",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst11|inst8|addr_c[3]\,
	datab => \inst1|I1|i~18\,
	cin0 => \inst11|inst8|add_17_rtl_0~2COUT0\,
	cin1 => \inst11|inst8|add_17_rtl_0~2COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_17_rtl_0~3\,
	cout0 => \inst11|inst8|add_17_rtl_0~3COUT0\,
	cout1 => \inst11|inst8|add_17_rtl_0~3COUT1\);

\inst11|inst8|add_15_rtl_597~19_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_15_rtl_597~19\ = \inst11|inst8|add_15~3\ & (\inst11|inst8|add_17_rtl_0~3\ # \inst1|I1|i~17\) # !\inst11|inst8|add_15~3\ & \inst11|inst8|add_17_rtl_0~3\ & !\inst1|I1|i~17\

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
	dataa => \inst11|inst8|add_15~3\,
	datac => \inst11|inst8|add_17_rtl_0~3\,
	datad => \inst1|I1|i~17\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_15_rtl_597~19\);

\inst11|inst8|addr_c[4]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|addr_c[4]\ = DFFEA(!\inst11|inst8|add_15_rtl_597~22\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	datad => \inst11|inst8|add_15_rtl_597~22\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst11|inst8|addr_c[4]\);

\inst11|inst8|add_15~4_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_15~4\ = \inst11|inst8|addr_c[4]\ $ \inst11|inst8|add_15~3COUT0\
-- \inst11|inst8|add_15~4COUT\ = 

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "3C03",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst11|inst8|addr_c[4]\,
	cin0 => \inst11|inst8|add_15~3COUT0\,
	cin1 => \inst11|inst8|add_15~3COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_15~4\,
	cout => \inst11|inst8|add_15~4COUT\);

\inst11|inst8|add_17_rtl_0~4_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_17_rtl_0~4\ = \inst11|inst8|addr_c[4]\ $ \inst1|I1|i~18\ $ \inst11|inst8|add_17_rtl_0~3COUT0\
-- \inst11|inst8|add_17_rtl_0~4COUT\ = 

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "964D",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst11|inst8|addr_c[4]\,
	datab => \inst1|I1|i~18\,
	cin0 => \inst11|inst8|add_17_rtl_0~3COUT0\,
	cin1 => \inst11|inst8|add_17_rtl_0~3COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_17_rtl_0~4\,
	cout => \inst11|inst8|add_17_rtl_0~4COUT\);

\inst11|inst8|add_15_rtl_597~22_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_15_rtl_597~22\ = \inst11|inst8|add_15~4\ & (\inst1|I1|i~17\ # \inst11|inst8|add_17_rtl_0~4\) # !\inst11|inst8|add_15~4\ & !\inst1|I1|i~17\ & \inst11|inst8|add_17_rtl_0~4\

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
	datab => \inst11|inst8|add_15~4\,
	datac => \inst1|I1|i~17\,
	datad => \inst11|inst8|add_17_rtl_0~4\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_15_rtl_597~22\);

\inst11|inst8|addr_c[5]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|addr_c[5]\ = DFFEA(!\inst11|inst8|add_15_rtl_597~25\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	datad => \inst11|inst8|add_15_rtl_597~25\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst11|inst8|addr_c[5]\);

\inst11|inst8|add_15~5_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_15~5\ = \inst11|inst8|addr_c[5]\ $ !(!\inst11|inst8|add_15~4COUT\ & GND) # (\inst11|inst8|add_15~4COUT\ & VCC)
-- \inst11|inst8|add_15~5COUT0\ = CARRY(\inst11|inst8|addr_c[5]\ # !\inst11|inst8|add_15~4COUT\)
-- \inst11|inst8|add_15~5COUT1\ = CARRY(\inst11|inst8|addr_c[5]\ # !\inst11|inst8|add_15~4COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "A5AF",
	cin_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst11|inst8|addr_c[5]\,
	cin => \inst11|inst8|add_15~4COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_15~5\,
	cout0 => \inst11|inst8|add_15~5COUT0\,
	cout1 => \inst11|inst8|add_15~5COUT1\);

\inst11|inst8|add_17_rtl_0~5_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_17_rtl_0~5\ = \inst11|inst8|addr_c[5]\ $ \inst1|I1|i~18\ $ !(!\inst11|inst8|add_17_rtl_0~4COUT\ & GND) # (\inst11|inst8|add_17_rtl_0~4COUT\ & VCC)
-- \inst11|inst8|add_17_rtl_0~5COUT0\ = CARRY(\inst11|inst8|addr_c[5]\ & (!\inst11|inst8|add_17_rtl_0~4COUT\ # !\inst1|I1|i~18\) # !\inst11|inst8|addr_c[5]\ & !\inst1|I1|i~18\ & !\inst11|inst8|add_17_rtl_0~4COUT\)
-- \inst11|inst8|add_17_rtl_0~5COUT1\ = CARRY(\inst11|inst8|addr_c[5]\ & (!\inst11|inst8|add_17_rtl_0~4COUT\ # !\inst1|I1|i~18\) # !\inst11|inst8|addr_c[5]\ & !\inst1|I1|i~18\ & !\inst11|inst8|add_17_rtl_0~4COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "692B",
	cin_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst11|inst8|addr_c[5]\,
	datab => \inst1|I1|i~18\,
	cin => \inst11|inst8|add_17_rtl_0~4COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_17_rtl_0~5\,
	cout0 => \inst11|inst8|add_17_rtl_0~5COUT0\,
	cout1 => \inst11|inst8|add_17_rtl_0~5COUT1\);

\inst11|inst8|add_15_rtl_597~25_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_15_rtl_597~25\ = \inst11|inst8|add_15~5\ & (\inst1|I1|i~17\ # \inst11|inst8|add_17_rtl_0~5\) # !\inst11|inst8|add_15~5\ & !\inst1|I1|i~17\ & \inst11|inst8|add_17_rtl_0~5\

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
	datab => \inst11|inst8|add_15~5\,
	datac => \inst1|I1|i~17\,
	datad => \inst11|inst8|add_17_rtl_0~5\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_15_rtl_597~25\);

\inst11|inst8|addr_c[6]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|addr_c[6]\ = DFFEA(!\inst11|inst8|add_15_rtl_597~28\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	datad => \inst11|inst8|add_15_rtl_597~28\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst11|inst8|addr_c[6]\);

\inst11|inst8|add_15~6_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_15~6\ = \inst11|inst8|addr_c[6]\ $ (!\inst11|inst8|add_15~4COUT\ & \inst11|inst8|add_15~5COUT0\) # (\inst11|inst8|add_15~4COUT\ & \inst11|inst8|add_15~5COUT1\)
-- \inst11|inst8|add_15~6COUT0\ = CARRY(!\inst11|inst8|addr_c[6]\ & !\inst11|inst8|add_15~5COUT0\)
-- \inst11|inst8|add_15~6COUT1\ = CARRY(!\inst11|inst8|addr_c[6]\ & !\inst11|inst8|add_15~5COUT1\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "5A05",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst11|inst8|addr_c[6]\,
	cin => \inst11|inst8|add_15~4COUT\,
	cin0 => \inst11|inst8|add_15~5COUT0\,
	cin1 => \inst11|inst8|add_15~5COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_15~6\,
	cout0 => \inst11|inst8|add_15~6COUT0\,
	cout1 => \inst11|inst8|add_15~6COUT1\);

\inst11|inst8|add_17_rtl_0~6_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_17_rtl_0~6\ = \inst11|inst8|addr_c[6]\ $ \inst1|I1|i~18\ $ (!\inst11|inst8|add_17_rtl_0~4COUT\ & \inst11|inst8|add_17_rtl_0~5COUT0\) # (\inst11|inst8|add_17_rtl_0~4COUT\ & \inst11|inst8|add_17_rtl_0~5COUT1\)
-- \inst11|inst8|add_17_rtl_0~6COUT0\ = CARRY(\inst11|inst8|addr_c[6]\ & \inst1|I1|i~18\ & !\inst11|inst8|add_17_rtl_0~5COUT0\ # !\inst11|inst8|addr_c[6]\ & (\inst1|I1|i~18\ # !\inst11|inst8|add_17_rtl_0~5COUT0\))
-- \inst11|inst8|add_17_rtl_0~6COUT1\ = CARRY(\inst11|inst8|addr_c[6]\ & \inst1|I1|i~18\ & !\inst11|inst8|add_17_rtl_0~5COUT1\ # !\inst11|inst8|addr_c[6]\ & (\inst1|I1|i~18\ # !\inst11|inst8|add_17_rtl_0~5COUT1\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "964D",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst11|inst8|addr_c[6]\,
	datab => \inst1|I1|i~18\,
	cin => \inst11|inst8|add_17_rtl_0~4COUT\,
	cin0 => \inst11|inst8|add_17_rtl_0~5COUT0\,
	cin1 => \inst11|inst8|add_17_rtl_0~5COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_17_rtl_0~6\,
	cout0 => \inst11|inst8|add_17_rtl_0~6COUT0\,
	cout1 => \inst11|inst8|add_17_rtl_0~6COUT1\);

\inst11|inst8|add_15_rtl_597~28_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_15_rtl_597~28\ = \inst11|inst8|add_15~6\ & (\inst1|I1|i~17\ # \inst11|inst8|add_17_rtl_0~6\) # !\inst11|inst8|add_15~6\ & !\inst1|I1|i~17\ & \inst11|inst8|add_17_rtl_0~6\

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
	datab => \inst11|inst8|add_15~6\,
	datac => \inst1|I1|i~17\,
	datad => \inst11|inst8|add_17_rtl_0~6\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_15_rtl_597~28\);

\inst11|inst8|addr_c[7]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|addr_c[7]\ = DFFEA(!\inst11|inst8|add_15_rtl_597~31\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	datac => \inst11|inst8|add_15_rtl_597~31\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst11|inst8|addr_c[7]\);

\inst11|inst8|add_15~7_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_15~7\ = (!\inst11|inst8|add_15~4COUT\ & \inst11|inst8|add_15~6COUT0\) # (\inst11|inst8|add_15~4COUT\ & \inst11|inst8|add_15~6COUT1\) $ !\inst11|inst8|addr_c[7]\

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
	datad => \inst11|inst8|addr_c[7]\,
	cin => \inst11|inst8|add_15~4COUT\,
	cin0 => \inst11|inst8|add_15~6COUT0\,
	cin1 => \inst11|inst8|add_15~6COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_15~7\);

\inst11|inst8|add_17_rtl_0~7_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_17_rtl_0~7\ = \inst11|inst8|addr_c[7]\ $ (!\inst11|inst8|add_17_rtl_0~4COUT\ & \inst11|inst8|add_17_rtl_0~6COUT0\) # (\inst11|inst8|add_17_rtl_0~4COUT\ & \inst11|inst8|add_17_rtl_0~6COUT1\) $ !\inst1|I1|i~18\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "5AA5",
	cin_used => "true",
	cin0_used => "true",
	cin1_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst11|inst8|addr_c[7]\,
	datad => \inst1|I1|i~18\,
	cin => \inst11|inst8|add_17_rtl_0~4COUT\,
	cin0 => \inst11|inst8|add_17_rtl_0~6COUT0\,
	cin1 => \inst11|inst8|add_17_rtl_0~6COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_17_rtl_0~7\);

\inst11|inst8|add_15_rtl_597~31_I\ : cyclone_lcell 
-- Equation(s):
-- \inst11|inst8|add_15_rtl_597~31\ = \inst11|inst8|add_15~7\ & (\inst1|I1|i~17\ # \inst11|inst8|add_17_rtl_0~7\) # !\inst11|inst8|add_15~7\ & !\inst1|I1|i~17\ & \inst11|inst8|add_17_rtl_0~7\

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
	dataa => \inst11|inst8|add_15~7\,
	datac => \inst1|I1|i~17\,
	datad => \inst11|inst8|add_17_rtl_0~7\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst11|inst8|add_15_rtl_597~31\);

\rtl~2482_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2482\ = \inst11|inst1|altsyncram_component|q_a[9]\ & (!\inst1|I1|Mux_41_rtl_211~0\ & !\inst1|I2|pc_mux_x[2]~26\ # !\inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "222A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst11|inst1|altsyncram_component|q_a[9]\,
	datab => \inst1|I1|i~2\,
	datac => \inst1|I1|Mux_41_rtl_211~0\,
	datad => \inst1|I2|pc_mux_x[2]~26\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2482\);

\inst1|I1|pc[9]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|pc[9]\ = DFFEA(\nreset_in~combout\ & \inst1|I1|iaddr_x[9]~890\ & \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \nreset_in~combout\,
	datac => \inst1|I1|iaddr_x[9]~890\,
	datad => \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I1|pc[9]\);

\inst1|I1|iaddr_x[4]~1824_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[4]~1824\ = \inst1|I2|pc_mux_x[2]~26\ & \inst11|inst1|altsyncram_component|q_a[4]\ # !\inst1|I2|pc_mux_x[2]~26\ & \inst1|I2|pc_mux_x[1]~49\ & \inst|altsyncram_component|q_a[8]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F088",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|pc_mux_x[1]~49\,
	datab => \inst|altsyncram_component|q_a[8]\,
	datac => \inst11|inst1|altsyncram_component|q_a[4]\,
	datad => \inst1|I2|pc_mux_x[2]~26\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[4]~1824\);

\inst1|I1|iaddr_x[3]~120_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[3]~120\ = \inst1|I2|pc_mux_x[2]~26\ & (!\inst1|I2|pc_mux_x[0]~167\ # !\inst1|I2|pc_mux_x[1]~49\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0CCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst1|I2|pc_mux_x[2]~26\,
	datac => \inst1|I2|pc_mux_x[1]~49\,
	datad => \inst1|I2|pc_mux_x[0]~167\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[3]~120\);

\inst1|I1|iaddr_x[3]~1801_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[3]~1801\ = \inst1|I2|pc_mux_x[2]~26\ & \inst11|inst1|altsyncram_component|q_a[3]\ # !\inst1|I2|pc_mux_x[2]~26\ & \inst|altsyncram_component|q_a[7]\ & \inst1|I2|pc_mux_x[1]~49\

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
	dataa => \inst11|inst1|altsyncram_component|q_a[3]\,
	datab => \inst|altsyncram_component|q_a[7]\,
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I2|pc_mux_x[1]~49\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[3]~1801\);

\inst1|I1|iaddr_x[3]~1716_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[3]~1716\ = !\inst1|I2|pc_mux_x[2]~26\ & !\inst1|I2|pc_mux_x[1]~49\

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
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I2|pc_mux_x[1]~49\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[3]~1716\);

\inst1|I1|iaddr_x[3]~1715_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[3]~1715\ = \inst1|I2|pc_mux_x[1]~49\ & !\inst1|I2|pc_mux_x[2]~26\

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
	datac => \inst1|I2|pc_mux_x[1]~49\,
	datad => \inst1|I2|pc_mux_x[2]~26\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[3]~1715\);

\inst1|I1|iaddr_x[1]~344_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[1]~344\ = \inst11|inst1|altsyncram_component|q_a[1]\ & \inst1|I2|pc_mux_x[2]~26\ & \inst1|I2|pc_mux_x[1]~49\ & \inst1|I2|pc_mux_x[0]~167\

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
	dataa => \inst11|inst1|altsyncram_component|q_a[1]\,
	datab => \inst1|I2|pc_mux_x[2]~26\,
	datac => \inst1|I2|pc_mux_x[1]~49\,
	datad => \inst1|I2|pc_mux_x[0]~167\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[1]~344\);

\inst1|I1|iaddr_x[0]~302_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[0]~302\ = \inst1|I2|pc_mux_x[1]~49\ & \inst1|I2|pc_mux_x[2]~26\ & \inst11|inst1|altsyncram_component|q_a[0]\ & \inst1|I2|pc_mux_x[0]~167\

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
	dataa => \inst1|I2|pc_mux_x[1]~49\,
	datab => \inst1|I2|pc_mux_x[2]~26\,
	datac => \inst11|inst1|altsyncram_component|q_a[0]\,
	datad => \inst1|I2|pc_mux_x[0]~167\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[0]~302\);

\inst1|I1|add_27~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|add_27~0\ = !\inst1|I1|pc[0]\
-- \inst1|I1|add_27~0COUT0\ = CARRY(\inst1|I1|pc[0]\)
-- \inst1|I1|add_27~0COUT1\ = CARRY(\inst1|I1|pc[0]\)

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
	datab => \inst1|I1|pc[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|add_27~0\,
	cout0 => \inst1|I1|add_27~0COUT0\,
	cout1 => \inst1|I1|add_27~0COUT1\);

\inst1|I1|iaddr_x[0]~304_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[0]~304\ = \inst1|I1|iaddr_x[3]~1716\ & (\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|add_27~0\ # !\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|pc[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E200",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|pc[0]\,
	datab => \inst1|I2|pc_mux_x[0]~167\,
	datac => \inst1|I1|add_27~0\,
	datad => \inst1|I1|iaddr_x[3]~1716\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[0]~304\);

\inst1|I1|iaddr_x[0]~301_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[0]~301\ = \inst1|I1|iaddr_x[0]~302\ # \inst1|I1|iaddr_x[0]~304\ # \inst|altsyncram_component|q_a[4]\ & \inst1|I1|iaddr_x[3]~1715\

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
	dataa => \inst|altsyncram_component|q_a[4]\,
	datab => \inst1|I1|iaddr_x[0]~302\,
	datac => \inst1|I1|iaddr_x[3]~1715\,
	datad => \inst1|I1|iaddr_x[0]~304\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[0]~301\);

\inst1|I1|pc[0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|pc[0]\ = DFFEA(\inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\ & \inst1|I1|iaddr_x[0]~301\ & \nreset_in~combout\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\,
	datac => \inst1|I1|iaddr_x[0]~301\,
	datad => \nreset_in~combout\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I1|pc[0]\);

\inst1|I1|add_27~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|add_27~1\ = \inst1|I1|pc[1]\ $ \inst1|I1|add_27~0COUT0\
-- \inst1|I1|add_27~1COUT0\ = CARRY(!\inst1|I1|add_27~0COUT0\ # !\inst1|I1|pc[1]\)
-- \inst1|I1|add_27~1COUT1\ = CARRY(!\inst1|I1|add_27~0COUT1\ # !\inst1|I1|pc[1]\)

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
	datab => \inst1|I1|pc[1]\,
	cin0 => \inst1|I1|add_27~0COUT0\,
	cin1 => \inst1|I1|add_27~0COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|add_27~1\,
	cout0 => \inst1|I1|add_27~1COUT0\,
	cout1 => \inst1|I1|add_27~1COUT1\);

\inst1|I1|iaddr_x[1]~346_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[1]~346\ = \inst1|I1|iaddr_x[3]~1716\ & (\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|add_27~1\ # !\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|pc[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A0C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|add_27~1\,
	datab => \inst1|I1|pc[1]\,
	datac => \inst1|I1|iaddr_x[3]~1716\,
	datad => \inst1|I2|pc_mux_x[0]~167\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[1]~346\);

\inst1|I1|iaddr_x[1]~343_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[1]~343\ = \inst1|I1|iaddr_x[1]~344\ # \inst1|I1|iaddr_x[1]~346\ # \inst1|I1|iaddr_x[3]~1715\ & \inst|altsyncram_component|q_a[5]\

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
	dataa => \inst1|I1|iaddr_x[3]~1715\,
	datab => \inst|altsyncram_component|q_a[5]\,
	datac => \inst1|I1|iaddr_x[1]~344\,
	datad => \inst1|I1|iaddr_x[1]~346\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[1]~343\);

\inst1|I1|pc[1]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|pc[1]\ = DFFEA(\inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\ & \inst1|I1|iaddr_x[1]~343\ & \nreset_in~combout\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\,
	datac => \inst1|I1|iaddr_x[1]~343\,
	datad => \nreset_in~combout\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I1|pc[1]\);

\inst1|I1|add_27~2_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|add_27~2\ = \inst1|I1|pc[2]\ $ !\inst1|I1|add_27~1COUT0\
-- \inst1|I1|add_27~2COUT0\ = CARRY(\inst1|I1|pc[2]\ & !\inst1|I1|add_27~1COUT0\)
-- \inst1|I1|add_27~2COUT1\ = CARRY(\inst1|I1|pc[2]\ & !\inst1|I1|add_27~1COUT1\)

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
	datab => \inst1|I1|pc[2]\,
	cin0 => \inst1|I1|add_27~1COUT0\,
	cin1 => \inst1|I1|add_27~1COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|add_27~2\,
	cout0 => \inst1|I1|add_27~2COUT0\,
	cout1 => \inst1|I1|add_27~2COUT1\);

\inst1|I1|iaddr_x[2]~388_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[2]~388\ = \inst1|I1|iaddr_x[3]~1716\ & (\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|add_27~2\ # !\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|pc[2]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E200",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|pc[2]\,
	datab => \inst1|I2|pc_mux_x[0]~167\,
	datac => \inst1|I1|add_27~2\,
	datad => \inst1|I1|iaddr_x[3]~1716\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[2]~388\);

\inst1|I1|iaddr_x[2]~1783_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[2]~1783\ = \inst1|I1|iaddr_x[2]~388\ # \inst11|inst1|altsyncram_component|q_a[2]\ & \inst1|I2|pc_mux_x[2]~26\ & \inst1|I1|Mux_41_rtl_211~0\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst11|inst1|altsyncram_component|q_a[2]\,
	datab => \inst1|I2|pc_mux_x[2]~26\,
	datac => \inst1|I1|Mux_41_rtl_211~0\,
	datad => \inst1|I1|iaddr_x[2]~388\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[2]~1783\);

\inst1|I1|pc[2]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[2]~391\ = \inst1|I1|i~2\ & (\inst1|I1|iaddr_x[2]~1783\ # \inst1|I1|iaddr_x[3]~1715\ & \inst|altsyncram_component|q_a[6]\)
-- \inst1|I1|pc[2]\ = DFFEA(\inst1|I1|iaddr_x[2]~391\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CC80",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I1|iaddr_x[3]~1715\,
	datab => \inst1|I1|i~2\,
	datac => \inst|altsyncram_component|q_a[6]\,
	datad => \inst1|I1|iaddr_x[2]~1783\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[2]~391\,
	regout => \inst1|I1|pc[2]\);

\inst1|I1|add_27~3_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|add_27~3\ = \inst1|I1|pc[3]\ $ \inst1|I1|add_27~2COUT0\
-- \inst1|I1|add_27~3COUT0\ = CARRY(!\inst1|I1|add_27~2COUT0\ # !\inst1|I1|pc[3]\)
-- \inst1|I1|add_27~3COUT1\ = CARRY(!\inst1|I1|add_27~2COUT1\ # !\inst1|I1|pc[3]\)

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
	datab => \inst1|I1|pc[3]\,
	cin0 => \inst1|I1|add_27~2COUT0\,
	cin1 => \inst1|I1|add_27~2COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|add_27~3\,
	cout0 => \inst1|I1|add_27~3COUT0\,
	cout1 => \inst1|I1|add_27~3COUT1\);

\inst1|I1|iaddr_x[3]~189_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[3]~189\ = \inst1|I1|add_27~3\ & (\inst1|I1|pc[3]\ # \inst1|I2|pc_mux_x[0]~167\) # !\inst1|I1|add_27~3\ & \inst1|I1|pc[3]\ & !\inst1|I2|pc_mux_x[0]~167\

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
	dataa => \inst1|I1|add_27~3\,
	datab => \inst1|I1|pc[3]\,
	datad => \inst1|I2|pc_mux_x[0]~167\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[3]~189\);

\inst1|I1|iaddr_x[3]~1806_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[3]~1806\ = \inst1|I1|iaddr_x[3]~1801\ # \inst1|I1|iaddr_x[3]~120\ # \inst1|I1|iaddr_x[3]~1716\ & \inst1|I1|iaddr_x[3]~189\

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
	dataa => \inst1|I1|iaddr_x[3]~1801\,
	datab => \inst1|I1|iaddr_x[3]~1716\,
	datac => \inst1|I1|iaddr_x[3]~120\,
	datad => \inst1|I1|iaddr_x[3]~189\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[3]~1806\);

\inst1|I1|pc[3]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|pc[3]\ = DFFEA(\inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\ & \nreset_in~combout\ & \inst1|I1|iaddr_x[3]~1806\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I1|nreset_v_rtl_5|wysi_counter|safe_q[1]\,
	datac => \nreset_in~combout\,
	datad => \inst1|I1|iaddr_x[3]~1806\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I1|pc[3]\);

\inst1|I1|add_27~4_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|add_27~4\ = \inst1|I1|pc[4]\ $ !\inst1|I1|add_27~3COUT0\
-- \inst1|I1|add_27~4COUT\ = CARRY(\inst1|I1|pc[4]\ & !\inst1|I1|add_27~3COUT1\)

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
	dataa => \inst1|I1|pc[4]\,
	cin0 => \inst1|I1|add_27~3COUT0\,
	cin1 => \inst1|I1|add_27~3COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|add_27~4\,
	cout => \inst1|I1|add_27~4COUT\);

\inst1|I1|iaddr_x[4]~205_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[4]~205\ = \inst1|I1|iaddr_x[3]~1716\ & (\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|add_27~4\ # !\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|pc[4]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A0C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|add_27~4\,
	datab => \inst1|I1|pc[4]\,
	datac => \inst1|I1|iaddr_x[3]~1716\,
	datad => \inst1|I2|pc_mux_x[0]~167\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[4]~205\);

\inst1|I1|pc[4]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[4]~138\ = \inst1|I1|i~2\ & (\inst1|I1|iaddr_x[4]~1824\ # \inst1|I1|iaddr_x[3]~120\ # \inst1|I1|iaddr_x[4]~205\)
-- \inst1|I1|pc[4]\ = DFFEA(\inst1|I1|iaddr_x[4]~138\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCC8",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I1|iaddr_x[4]~1824\,
	datab => \inst1|I1|i~2\,
	datac => \inst1|I1|iaddr_x[3]~120\,
	datad => \inst1|I1|iaddr_x[4]~205\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[4]~138\,
	regout => \inst1|I1|pc[4]\);

\inst1|I1|iaddr_x[6]~1870_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[6]~1870\ = \inst1|I2|pc_mux_x[2]~26\ & \inst11|inst1|altsyncram_component|q_a[6]\ # !\inst1|I2|pc_mux_x[2]~26\ & \inst|altsyncram_component|q_a[10]\ & \inst1|I2|pc_mux_x[1]~49\

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
	dataa => \inst11|inst1|altsyncram_component|q_a[6]\,
	datab => \inst|altsyncram_component|q_a[10]\,
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I2|pc_mux_x[1]~49\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[6]~1870\);

\inst1|I1|iaddr_x[5]~1847_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[5]~1847\ = \inst1|I2|pc_mux_x[2]~26\ & \inst11|inst1|altsyncram_component|q_a[5]\ # !\inst1|I2|pc_mux_x[2]~26\ & \inst|altsyncram_component|q_a[9]\ & \inst1|I2|pc_mux_x[1]~49\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst|altsyncram_component|q_a[9]\,
	datab => \inst1|I2|pc_mux_x[2]~26\,
	datac => \inst11|inst1|altsyncram_component|q_a[5]\,
	datad => \inst1|I2|pc_mux_x[1]~49\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[5]~1847\);

\inst1|I1|add_27~5_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|add_27~5\ = \inst1|I1|pc[5]\ $ \inst1|I1|add_27~4COUT\
-- \inst1|I1|add_27~5COUT0\ = CARRY(!\inst1|I1|add_27~4COUT\ # !\inst1|I1|pc[5]\)
-- \inst1|I1|add_27~5COUT1\ = CARRY(!\inst1|I1|add_27~4COUT\ # !\inst1|I1|pc[5]\)

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
	datab => \inst1|I1|pc[5]\,
	cin => \inst1|I1|add_27~4COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|add_27~5\,
	cout0 => \inst1|I1|add_27~5COUT0\,
	cout1 => \inst1|I1|add_27~5COUT1\);

\inst1|I1|iaddr_x[5]~215_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[5]~215\ = \inst1|I1|iaddr_x[3]~1716\ & (\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|add_27~5\ # !\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|pc[5]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CA00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|pc[5]\,
	datab => \inst1|I1|add_27~5\,
	datac => \inst1|I2|pc_mux_x[0]~167\,
	datad => \inst1|I1|iaddr_x[3]~1716\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[5]~215\);

\inst1|I1|pc[5]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[5]~148\ = \inst1|I1|i~2\ & (\inst1|I1|iaddr_x[5]~1847\ # \inst1|I1|iaddr_x[3]~120\ # \inst1|I1|iaddr_x[5]~215\)
-- \inst1|I1|pc[5]\ = DFFEA(\inst1|I1|iaddr_x[5]~148\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FE00",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I1|iaddr_x[5]~1847\,
	datab => \inst1|I1|iaddr_x[3]~120\,
	datac => \inst1|I1|iaddr_x[5]~215\,
	datad => \inst1|I1|i~2\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[5]~148\,
	regout => \inst1|I1|pc[5]\);

\inst1|I1|add_27~6_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|add_27~6\ = \inst1|I1|pc[6]\ $ !(!\inst1|I1|add_27~4COUT\ & \inst1|I1|add_27~5COUT0\) # (\inst1|I1|add_27~4COUT\ & \inst1|I1|add_27~5COUT1\)
-- \inst1|I1|add_27~6COUT0\ = CARRY(\inst1|I1|pc[6]\ & !\inst1|I1|add_27~5COUT0\)
-- \inst1|I1|add_27~6COUT1\ = CARRY(\inst1|I1|pc[6]\ & !\inst1|I1|add_27~5COUT1\)

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
	dataa => \inst1|I1|pc[6]\,
	cin => \inst1|I1|add_27~4COUT\,
	cin0 => \inst1|I1|add_27~5COUT0\,
	cin1 => \inst1|I1|add_27~5COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|add_27~6\,
	cout0 => \inst1|I1|add_27~6COUT0\,
	cout1 => \inst1|I1|add_27~6COUT1\);

\inst1|I1|iaddr_x[6]~225_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[6]~225\ = \inst1|I1|iaddr_x[3]~1716\ & (\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|add_27~6\ # !\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|pc[6]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A0C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|add_27~6\,
	datab => \inst1|I1|pc[6]\,
	datac => \inst1|I1|iaddr_x[3]~1716\,
	datad => \inst1|I2|pc_mux_x[0]~167\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[6]~225\);

\inst1|I1|pc[6]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[6]~158\ = \inst1|I1|i~2\ & (\inst1|I1|iaddr_x[3]~120\ # \inst1|I1|iaddr_x[6]~1870\ # \inst1|I1|iaddr_x[6]~225\)
-- \inst1|I1|pc[6]\ = DFFEA(\inst1|I1|iaddr_x[6]~158\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAA8",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I1|i~2\,
	datab => \inst1|I1|iaddr_x[3]~120\,
	datac => \inst1|I1|iaddr_x[6]~1870\,
	datad => \inst1|I1|iaddr_x[6]~225\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[6]~158\,
	regout => \inst1|I1|pc[6]\);

\inst1|I1|add_27~7_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|add_27~7\ = \inst1|I1|pc[7]\ $ (!\inst1|I1|add_27~4COUT\ & \inst1|I1|add_27~6COUT0\) # (\inst1|I1|add_27~4COUT\ & \inst1|I1|add_27~6COUT1\)
-- \inst1|I1|add_27~7COUT0\ = CARRY(!\inst1|I1|add_27~6COUT0\ # !\inst1|I1|pc[7]\)
-- \inst1|I1|add_27~7COUT1\ = CARRY(!\inst1|I1|add_27~6COUT1\ # !\inst1|I1|pc[7]\)

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
	datab => \inst1|I1|pc[7]\,
	cin => \inst1|I1|add_27~4COUT\,
	cin0 => \inst1|I1|add_27~6COUT0\,
	cin1 => \inst1|I1|add_27~6COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|add_27~7\,
	cout0 => \inst1|I1|add_27~7COUT0\,
	cout1 => \inst1|I1|add_27~7COUT1\);

\inst1|I1|iaddr_x[7]~235_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[7]~235\ = \inst1|I1|iaddr_x[3]~1716\ & (\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|add_27~7\ # !\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|pc[7]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CA00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|pc[7]\,
	datab => \inst1|I1|add_27~7\,
	datac => \inst1|I2|pc_mux_x[0]~167\,
	datad => \inst1|I1|iaddr_x[3]~1716\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[7]~235\);

\inst1|I4|data_ox[15]~4_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_ox[15]~4\ = \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ & \inst1|I3|acc_c[0][15]\ & \nreset_in~combout\

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
	datab => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	datac => \inst1|I3|acc_c[0][15]\,
	datad => \nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_ox[15]~4\);

\inst1|I4|data_exp_i[2]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_exp_x[2]~8\ = \inst1|I4|dexp_we_c\ & \inst1|I3|acc_c[0][2]\ # !\inst1|I4|dexp_we_c\ & \inst1|I4|data_exp_c[2]\ & \inst1|I4|i~38\
-- \inst1|I4|data_exp_i[2]\ = DFFEA(\inst1|I4|data_exp_x[2]~8\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAC0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][2]\,
	datab => \inst1|I4|data_exp_c[2]\,
	datac => \inst1|I4|i~38\,
	datad => \inst1|I4|dexp_we_c\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_exp_x[2]~8\,
	regout => \inst1|I4|data_exp_i[2]\);

\inst1|I4|data_exp_c[2]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_exp_c[2]\ = DFFEA(\inst1|I4|data_exp_i[2]\ & (\inst1|I4|data_exp_x[2]~8\ # \inst1|I2|int_stop_x~11\) # !\inst1|I4|data_exp_i[2]\ & \inst1|I4|data_exp_x[2]~8\ & !\inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|data_exp_i[2]\,
	datac => \inst1|I4|data_exp_x[2]~8\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|data_exp_c[2]\);

\DATA_IN_EXT[14]~I\ : cyclone_io 
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
	padio => ww_DATA_IN_EXT(14),
	combout => \DATA_IN_EXT[14]~combout\);

\inst1|I3|data_x[14]~92_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[14]~92\ = \DATA_IN_EXT[14]~combout\ & (\inst3|mux_c[0]\ # \inst|altsyncram_component|q_a[14]\) # !\DATA_IN_EXT[14]~combout\ & !\inst3|mux_c[0]\ & \inst|altsyncram_component|q_a[14]\

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
	dataa => \DATA_IN_EXT[14]~combout\,
	datac => \inst3|mux_c[0]\,
	datad => \inst|altsyncram_component|q_a[14]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[14]~92\);

\inst1|I3|data_x[13]~3460_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[13]~3460\ = \inst1|I3|data_x[6]~3461\ & (\nreset_in~combout\ & !\inst1|I2|ndre_x~49\ # !\inst1|I4|i~2617\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "08AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|data_x[6]~3461\,
	datab => \nreset_in~combout\,
	datac => \inst1|I2|ndre_x~49\,
	datad => \inst1|I4|i~2617\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[13]~3460\);

\inst1|I3|data_x[14]~97_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[14]~97\ = \inst1|I3|reduce_nor_95\ & \inst1|I3|data_x[14]~92\ & \inst1|I3|data_x[13]~3460\ # !\inst1|I3|reduce_nor_95\ & (\inst1|I4|data_exp_x[2]~8\ # \inst1|I3|data_x[14]~92\ & \inst1|I3|data_x[13]~3460\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F444",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|reduce_nor_95\,
	datab => \inst1|I4|data_exp_x[2]~8\,
	datac => \inst1|I3|data_x[14]~92\,
	datad => \inst1|I3|data_x[13]~3460\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[14]~97\);

\rtl~1541_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~1541\ = \inst1|I2|TD_c[0]\ & \rtl~13588\ & (\inst1|I3|acc_c[0][14]\ $ \inst1|I3|data_x[14]~97\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I3|acc_c[0][14]\,
	datac => \inst1|I3|data_x[14]~97\,
	datad => \rtl~13588\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1541\);

\rtl~13592_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13592\ = !\inst1|I2|TD_c[0]\ & \rtl~13588\

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
	datac => \inst1|I2|TD_c[0]\,
	datad => \rtl~13588\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13592\);

\inst1|I3|Mux_297_rtl_171~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_297_rtl_171~0\ = \inst1|I2|TC_c[0]\ $ \inst1|I2|TC_c[1]\

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
	datac => \inst1|I2|TC_c[0]\,
	datad => \inst1|I2|TC_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_297_rtl_171~0\);

\rtl~2571_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2571\ = \inst1|I2|TD_c[2]\ & !\inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][15]\ # !\inst1|I2|TD_c[2]\ & (\inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][15]\ # !\inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][14]\)

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
	dataa => \inst1|I3|acc_c[0][14]\,
	datab => \inst1|I2|TD_c[2]\,
	datac => \inst1|I2|TD_c[1]\,
	datad => \inst1|I3|acc_c[0][15]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2571\);

\rtl~2760_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2760\ = \inst1|I2|TD_c[2]\ & (\inst1|I2|TD_c[1]\ $ \inst1|I3|acc_c[0][14]\) # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][13]\

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
	dataa => \inst1|I2|TD_c[2]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I3|acc_c[0][14]\,
	datad => \inst1|I3|acc_c[0][13]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2760\);

\rtl~2246_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2246\ = !\inst1|I3|Mux_297_rtl_171~0\ & (\inst1|I2|TD_c[0]\ & \rtl~2760\ # !\inst1|I2|TD_c[0]\ & \rtl~2571\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5044",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|Mux_297_rtl_171~0\,
	datab => \rtl~2571\,
	datac => \rtl~2760\,
	datad => \inst1|I2|TD_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2246\);

\rtl~13596_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13596\ = \inst1|I2|TD_c[2]\ & (\inst1|I2|TC_c[1]\ $ \inst1|I2|TC_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2828",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[2]\,
	datab => \inst1|I2|TC_c[1]\,
	datac => \inst1|I2|TC_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13596\);

\rtl~13900_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13900\ = !\inst1|I2|TD_c[2]\ & !\inst1|I2|TD_c[1]\ & (\inst1|I2|TC_c[1]\ $ \inst1|I2|TC_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0012",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TC_c[1]\,
	datab => \inst1|I2|TD_c[2]\,
	datac => \inst1|I2|TC_c[0]\,
	datad => \inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13900\);

\inst1|I4|data_exp_i[0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_exp_x[0]~11\ = \inst1|I4|dexp_we_c\ & \inst1|I3|acc_c[0][0]\ # !\inst1|I4|dexp_we_c\ & \inst1|I4|data_exp_c[0]\ & \inst1|I4|i~38\
-- \inst1|I4|data_exp_i[0]\ = DFFEA(\inst1|I4|data_exp_x[0]~11\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][0]\,
	datab => \inst1|I4|dexp_we_c\,
	datac => \inst1|I4|data_exp_c[0]\,
	datad => \inst1|I4|i~38\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_exp_x[0]~11\,
	regout => \inst1|I4|data_exp_i[0]\);

\inst1|I4|data_exp_c[0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_exp_c[0]\ = DFFEA(\inst1|I4|data_exp_x[0]~11\ & (\inst1|I4|data_exp_i[0]\ # !\inst1|I2|int_stop_x~11\) # !\inst1|I4|data_exp_x[0]~11\ & \inst1|I4|data_exp_i[0]\ & \inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|data_exp_x[0]~11\,
	datac => \inst1|I4|data_exp_i[0]\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|data_exp_c[0]\);

\DATA_IN_EXT[12]~I\ : cyclone_io 
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
	padio => ww_DATA_IN_EXT(12),
	combout => \DATA_IN_EXT[12]~combout\);

\inst1|I3|data_x[12]~102_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[12]~102\ = \DATA_IN_EXT[12]~combout\ & (\inst|altsyncram_component|q_a[12]\ # \inst3|mux_c[0]\) # !\DATA_IN_EXT[12]~combout\ & \inst|altsyncram_component|q_a[12]\ & !\inst3|mux_c[0]\

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
	datab => \DATA_IN_EXT[12]~combout\,
	datac => \inst|altsyncram_component|q_a[12]\,
	datad => \inst3|mux_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[12]~102\);

\inst1|I3|data_x[12]~107_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[12]~107\ = \inst1|I3|reduce_nor_95\ & \inst1|I3|data_x[12]~102\ & \inst1|I3|data_x[13]~3460\ # !\inst1|I3|reduce_nor_95\ & (\inst1|I4|data_exp_x[0]~11\ # \inst1|I3|data_x[12]~102\ & \inst1|I3|data_x[13]~3460\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F444",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|reduce_nor_95\,
	datab => \inst1|I4|data_exp_x[0]~11\,
	datac => \inst1|I3|data_x[12]~102\,
	datad => \inst1|I3|data_x[13]~3460\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[12]~107\);

\rtl~1576_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~1576\ = \inst1|I2|TD_c[0]\ & \rtl~13588\ & (\inst1|I3|acc_c[0][12]\ $ \inst1|I3|data_x[12]~107\)

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
	dataa => \inst1|I2|TD_c[0]\,
	datab => \rtl~13588\,
	datac => \inst1|I3|acc_c[0][12]\,
	datad => \inst1|I3|data_x[12]~107\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1576\);

\rtl~2582_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2582\ = \inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][13]\ & !\inst1|I2|TD_c[1]\ # !\inst1|I2|TD_c[2]\ & (\inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][13]\ # !\inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][12]\)

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
	dataa => \inst1|I3|acc_c[0][12]\,
	datab => \inst1|I3|acc_c[0][13]\,
	datac => \inst1|I2|TD_c[2]\,
	datad => \inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2582\);

\rtl~2770_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2770\ = \inst1|I2|TD_c[2]\ & (\inst1|I3|acc_c[0][12]\ $ \inst1|I2|TD_c[1]\) # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][11]\

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
	dataa => \inst1|I3|acc_c[0][12]\,
	datab => \inst1|I3|acc_c[0][11]\,
	datac => \inst1|I2|TD_c[2]\,
	datad => \inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2770\);

\rtl~2261_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2261\ = !\inst1|I3|Mux_297_rtl_171~0\ & (\inst1|I2|TD_c[0]\ & \rtl~2770\ # !\inst1|I2|TD_c[0]\ & \rtl~2582\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "00E4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datab => \rtl~2582\,
	datac => \rtl~2770\,
	datad => \inst1|I3|Mux_297_rtl_171~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2261\);

\inst1|I2|data_is_c[7]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|idata_x[11]~54\ = \inst1|I2|E_x.dwait_e~0\ & K1_data_is_c[7] # !\inst1|I2|E_x.dwait_e~0\ & \inst|altsyncram_component|q_a[11]\
-- \inst1|I2|data_is_c[7]\ = DFFEA(\inst1|I2|idata_x[11]~54\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "F3C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I2|E_x.dwait_e~0\,
	datad => \inst|altsyncram_component|q_a[11]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|idata_x[11]~54\,
	regout => \inst1|I2|data_is_c[7]\);

\inst1|I4|data_exp_i[7]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iadata_x[19]~23\ = \inst1|I4|dexp_we_c\ & \inst1|I3|acc_c[0][7]\ # !\inst1|I4|dexp_we_c\ & \inst1|I4|data_exp_c[7]\ & \inst1|I4|i~38\
-- \inst1|I4|data_exp_i[7]\ = DFFEA(\inst1|I4|iadata_x[19]~23\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|data_exp_c[7]\,
	datab => \inst1|I4|dexp_we_c\,
	datac => \inst1|I3|acc_c[0][7]\,
	datad => \inst1|I4|i~38\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iadata_x[19]~23\,
	regout => \inst1|I4|data_exp_i[7]\);

\inst1|I4|data_exp_c[7]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_exp_c[7]\ = DFFEA(\inst1|I4|iadata_x[19]~23\ & (\inst1|I4|data_exp_i[7]\ # !\inst1|I2|int_stop_x~11\) # !\inst1|I4|iadata_x[19]~23\ & \inst1|I4|data_exp_i[7]\ & \inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0AA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|iadata_x[19]~23\,
	datac => \inst1|I4|data_exp_i[7]\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|data_exp_c[7]\);

\inst1|I3|data_x[7]~3844_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[7]~3844\ = \inst1|I4|ireg_c[7]\ & (\inst1|I4|iinc_c[7]\ & \inst1|I3|data_x[9]~3459\ # !\inst1|I4|reduce_nor_207\) # !\inst1|I4|ireg_c[7]\ & \inst1|I4|iinc_c[7]\ & \inst1|I3|data_x[9]~3459\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CE0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ireg_c[7]\,
	datab => \inst1|I4|iinc_c[7]\,
	datac => \inst1|I4|reduce_nor_207\,
	datad => \inst1|I3|data_x[9]~3459\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[7]~3844\);

\inst1|I3|data_x[7]~2987_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[7]~2987\ = \inst1|I3|data_x[9]~3458\ & (\inst1|I3|data_x[7]~3844\ # \inst1|I4|data_exp_c[7]\ & \inst1|I3|data_x[9]~3457\)

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
	dataa => \inst1|I4|data_exp_c[7]\,
	datab => \inst1|I3|data_x[9]~3457\,
	datac => \inst1|I3|data_x[7]~3844\,
	datad => \inst1|I3|data_x[9]~3458\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[7]~2987\);

\DATA_IN_EXT[7]~I\ : cyclone_io 
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
	padio => ww_DATA_IN_EXT(7),
	combout => \DATA_IN_EXT[7]~combout\);

\inst1|I3|data_x[7]~1047_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[7]~1047\ = \inst1|I3|data_x[6]~3456\ & (\inst3|mux_c[0]\ & \DATA_IN_EXT[7]~combout\ # !\inst3|mux_c[0]\ & \inst|altsyncram_component|q_a[7]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "B800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \DATA_IN_EXT[7]~combout\,
	datab => \inst3|mux_c[0]\,
	datac => \inst|altsyncram_component|q_a[7]\,
	datad => \inst1|I3|data_x[6]~3456\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[7]~1047\);

\inst1|I3|data_x[7]~3872_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[7]~3872\ = \inst1|I3|data_x[7]~2987\ # \inst1|I3|data_x[7]~1047\ # \inst1|I2|data_is_c[7]\ & !\inst1|I3|reduce_nor_95\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|data_is_c[7]\,
	datab => \inst1|I3|reduce_nor_95\,
	datac => \inst1|I3|data_x[7]~2987\,
	datad => \inst1|I3|data_x[7]~1047\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[7]~3872\);

\inst1|I2|data_is_c[2]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|idata_x[6]~30\ = \inst1|I2|E_x.dwait_e~0\ & K1_data_is_c[2] # !\inst1|I2|E_x.dwait_e~0\ & \inst|altsyncram_component|q_a[6]\
-- \inst1|I2|data_is_c[2]\ = DFFEA(\inst1|I2|idata_x[6]~30\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "F3C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I2|E_x.dwait_e~0\,
	datad => \inst|altsyncram_component|q_a[6]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|idata_x[6]~30\,
	regout => \inst1|I2|data_is_c[2]\);

\inst1|I3|data_x[2]~3928_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[2]~3928\ = \inst1|I4|ireg_c[2]\ & (\inst1|I4|iinc_c[2]\ & \inst1|I3|data_x[9]~3459\ # !\inst1|I4|reduce_nor_207\) # !\inst1|I4|ireg_c[2]\ & \inst1|I4|iinc_c[2]\ & \inst1|I3|data_x[9]~3459\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CE0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ireg_c[2]\,
	datab => \inst1|I4|iinc_c[2]\,
	datac => \inst1|I4|reduce_nor_207\,
	datad => \inst1|I3|data_x[9]~3459\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[2]~3928\);

\inst1|I3|data_x[2]~3199_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[2]~3199\ = \inst1|I3|data_x[9]~3458\ & (\inst1|I3|data_x[2]~3928\ # \inst1|I4|data_exp_c[2]\ & \inst1|I3|data_x[9]~3457\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E0A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|data_x[2]~3928\,
	datab => \inst1|I4|data_exp_c[2]\,
	datac => \inst1|I3|data_x[9]~3458\,
	datad => \inst1|I3|data_x[9]~3457\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[2]~3199\);

\DATA_IN_EXT[2]~I\ : cyclone_io 
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
	padio => ww_DATA_IN_EXT(2),
	combout => \DATA_IN_EXT[2]~combout\);

\inst1|I3|data_x[2]~1251_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[2]~1251\ = \inst1|I3|data_x[6]~3456\ & (\inst3|mux_c[0]\ & \DATA_IN_EXT[2]~combout\ # !\inst3|mux_c[0]\ & \inst|altsyncram_component|q_a[2]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst3|mux_c[0]\,
	datab => \inst|altsyncram_component|q_a[2]\,
	datac => \DATA_IN_EXT[2]~combout\,
	datad => \inst1|I3|data_x[6]~3456\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[2]~1251\);

\inst1|I3|data_x[2]~3956_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[2]~3956\ = \inst1|I3|data_x[2]~3199\ # \inst1|I3|data_x[2]~1251\ # !\inst1|I3|reduce_nor_95\ & \inst1|I2|data_is_c[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|reduce_nor_95\,
	datab => \inst1|I2|data_is_c[2]\,
	datac => \inst1|I3|data_x[2]~3199\,
	datad => \inst1|I3|data_x[2]~1251\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[2]~3956\);

\inst1|I2|data_is_c[1]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|idata_x[5]~36\ = \inst1|I2|E_x.dwait_e~0\ & K1_data_is_c[1] # !\inst1|I2|E_x.dwait_e~0\ & \inst|altsyncram_component|q_a[5]\
-- \inst1|I2|data_is_c[1]\ = DFFEA(\inst1|I2|idata_x[5]~36\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "F3C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I2|E_x.dwait_e~0\,
	datad => \inst|altsyncram_component|q_a[5]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|idata_x[5]~36\,
	regout => \inst1|I2|data_is_c[1]\);

\inst1|I4|data_exp_i[1]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_exp_x[1]~2\ = \inst1|I4|dexp_we_c\ & \inst1|I3|acc_c[0][1]\ # !\inst1|I4|dexp_we_c\ & \inst1|I4|i~38\ & \inst1|I4|data_exp_c[1]\
-- \inst1|I4|data_exp_i[1]\ = DFFEA(\inst1|I4|data_exp_x[1]~2\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][1]\,
	datab => \inst1|I4|i~38\,
	datac => \inst1|I4|dexp_we_c\,
	datad => \inst1|I4|data_exp_c[1]\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_exp_x[1]~2\,
	regout => \inst1|I4|data_exp_i[1]\);

\inst1|I4|data_exp_c[1]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_exp_c[1]\ = DFFEA(\inst1|I4|data_exp_i[1]\ & (\inst1|I4|data_exp_x[1]~2\ # \inst1|I2|int_stop_x~11\) # !\inst1|I4|data_exp_i[1]\ & \inst1|I4|data_exp_x[1]~2\ & !\inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|data_exp_i[1]\,
	datac => \inst1|I4|data_exp_x[1]~2\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|data_exp_c[1]\);

\inst1|I4|iinc_i[1]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_x[1]~32\ = \inst1|I4|iinc_we_c\ & \inst1|I3|acc_c[0][1]\ # !\inst1|I4|iinc_we_c\ & \inst1|I4|iinc_c[1]\ & \inst1|I4|i~38\
-- \inst1|I4|iinc_i[1]\ = DFFEA(\inst1|I4|iinc_x[1]~32\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F088",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|iinc_c[1]\,
	datab => \inst1|I4|i~38\,
	datac => \inst1|I3|acc_c[0][1]\,
	datad => \inst1|I4|iinc_we_c\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iinc_x[1]~32\,
	regout => \inst1|I4|iinc_i[1]\);

\inst1|I4|iinc_c[1]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_c[1]\ = DFFEA(\inst1|I4|iinc_i[1]\ & (\inst1|I4|iinc_x[1]~32\ # \inst1|I2|int_stop_x~11\) # !\inst1|I4|iinc_i[1]\ & \inst1|I4|iinc_x[1]~32\ & !\inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|iinc_i[1]\,
	datac => \inst1|I4|iinc_x[1]~32\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|iinc_c[1]\);

\inst1|I3|data_x[1]~3970_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[1]~3970\ = \inst1|I4|ireg_c[1]\ & (\inst1|I4|iinc_c[1]\ & \inst1|I3|data_x[9]~3459\ # !\inst1|I4|reduce_nor_207\) # !\inst1|I4|ireg_c[1]\ & \inst1|I4|iinc_c[1]\ & \inst1|I3|data_x[9]~3459\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CE0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ireg_c[1]\,
	datab => \inst1|I4|iinc_c[1]\,
	datac => \inst1|I4|reduce_nor_207\,
	datad => \inst1|I3|data_x[9]~3459\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[1]~3970\);

\inst1|I3|data_x[1]~3305_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[1]~3305\ = \inst1|I3|data_x[9]~3458\ & (\inst1|I3|data_x[1]~3970\ # \inst1|I4|data_exp_c[1]\ & \inst1|I3|data_x[9]~3457\)

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
	dataa => \inst1|I4|data_exp_c[1]\,
	datab => \inst1|I3|data_x[9]~3457\,
	datac => \inst1|I3|data_x[1]~3970\,
	datad => \inst1|I3|data_x[9]~3458\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[1]~3305\);

\DATA_IN_EXT[1]~I\ : cyclone_io 
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
	padio => ww_DATA_IN_EXT(1),
	combout => \DATA_IN_EXT[1]~combout\);

\inst1|I3|data_x[1]~1353_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[1]~1353\ = \inst1|I3|data_x[6]~3456\ & (\inst3|mux_c[0]\ & \DATA_IN_EXT[1]~combout\ # !\inst3|mux_c[0]\ & \inst|altsyncram_component|q_a[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "B080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \DATA_IN_EXT[1]~combout\,
	datab => \inst3|mux_c[0]\,
	datac => \inst1|I3|data_x[6]~3456\,
	datad => \inst|altsyncram_component|q_a[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[1]~1353\);

\inst1|I3|data_x[1]~3998_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[1]~3998\ = \inst1|I3|data_x[1]~3305\ # \inst1|I3|data_x[1]~1353\ # !\inst1|I3|reduce_nor_95\ & \inst1|I2|data_is_c[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|reduce_nor_95\,
	datab => \inst1|I2|data_is_c[1]\,
	datac => \inst1|I3|data_x[1]~3305\,
	datad => \inst1|I3|data_x[1]~1353\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[1]~3998\);

\inst1|I2|data_is_c[0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|idata_x[4]~39\ = \inst1|I2|E_x.dwait_e~0\ & K1_data_is_c[0] # !\inst1|I2|E_x.dwait_e~0\ & \inst|altsyncram_component|q_a[4]\
-- \inst1|I2|data_is_c[0]\ = DFFEA(\inst1|I2|idata_x[4]~39\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "F3C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I2|E_x.dwait_e~0\,
	datad => \inst|altsyncram_component|q_a[4]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|idata_x[4]~39\,
	regout => \inst1|I2|data_is_c[0]\);

\inst1|I3|data_x[0]~4012_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[0]~4012\ = \inst1|I4|iinc_c[0]\ & (\inst1|I3|data_x[9]~3459\ # \inst1|I4|ireg_c[0]\ & !\inst1|I4|reduce_nor_207\) # !\inst1|I4|iinc_c[0]\ & \inst1|I4|ireg_c[0]\ & !\inst1|I4|reduce_nor_207\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AE0C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|iinc_c[0]\,
	datab => \inst1|I4|ireg_c[0]\,
	datac => \inst1|I4|reduce_nor_207\,
	datad => \inst1|I3|data_x[9]~3459\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[0]~4012\);

\inst1|I3|data_x[0]~3411_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[0]~3411\ = \inst1|I3|data_x[9]~3458\ & (\inst1|I3|data_x[0]~4012\ # \inst1|I4|data_exp_c[0]\ & \inst1|I3|data_x[9]~3457\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E0C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|data_exp_c[0]\,
	datab => \inst1|I3|data_x[0]~4012\,
	datac => \inst1|I3|data_x[9]~3458\,
	datad => \inst1|I3|data_x[9]~3457\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[0]~3411\);

\DATA_IN_EXT[0]~I\ : cyclone_io 
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
	padio => ww_DATA_IN_EXT(0),
	combout => \DATA_IN_EXT[0]~combout\);

\inst1|I3|data_x[0]~1455_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[0]~1455\ = \inst1|I3|data_x[6]~3456\ & (\inst3|mux_c[0]\ & \DATA_IN_EXT[0]~combout\ # !\inst3|mux_c[0]\ & \inst|altsyncram_component|q_a[0]\)

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
	dataa => \inst3|mux_c[0]\,
	datab => \DATA_IN_EXT[0]~combout\,
	datac => \inst|altsyncram_component|q_a[0]\,
	datad => \inst1|I3|data_x[6]~3456\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[0]~1455\);

\inst1|I3|data_x[0]~4040_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[0]~4040\ = \inst1|I3|data_x[0]~3411\ # \inst1|I3|data_x[0]~1455\ # \inst1|I2|data_is_c[0]\ & !\inst1|I3|reduce_nor_95\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|data_is_c[0]\,
	datab => \inst1|I3|reduce_nor_95\,
	datac => \inst1|I3|data_x[0]~3411\,
	datad => \inst1|I3|data_x[0]~1455\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[0]~4040\);

\inst1|I3|add_225~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_225~1\ = \inst1|I3|acc_c[0][0]\ $ \inst1|I3|data_x[0]~4040\
-- \inst1|I3|add_225~1COUT0\ = CARRY(\inst1|I3|acc_c[0][0]\ # !\inst1|I3|data_x[0]~4040\)
-- \inst1|I3|add_225~1COUT1\ = CARRY(\inst1|I3|acc_c[0][0]\ # !\inst1|I3|data_x[0]~4040\)

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
	dataa => \inst1|I3|acc_c[0][0]\,
	datab => \inst1|I3|data_x[0]~4040\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_225~1\,
	cout0 => \inst1|I3|add_225~1COUT0\,
	cout1 => \inst1|I3|add_225~1COUT1\);

\inst1|I3|add_225~2_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_225~2\ = \inst1|I3|acc_c[0][1]\ $ \inst1|I3|data_x[1]~3998\ $ !\inst1|I3|add_225~1COUT0\
-- \inst1|I3|add_225~2COUT0\ = CARRY(\inst1|I3|acc_c[0][1]\ & \inst1|I3|data_x[1]~3998\ & !\inst1|I3|add_225~1COUT0\ # !\inst1|I3|acc_c[0][1]\ & (\inst1|I3|data_x[1]~3998\ # !\inst1|I3|add_225~1COUT0\))
-- \inst1|I3|add_225~2COUT1\ = CARRY(\inst1|I3|acc_c[0][1]\ & \inst1|I3|data_x[1]~3998\ & !\inst1|I3|add_225~1COUT1\ # !\inst1|I3|acc_c[0][1]\ & (\inst1|I3|data_x[1]~3998\ # !\inst1|I3|add_225~1COUT1\))

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
	dataa => \inst1|I3|acc_c[0][1]\,
	datab => \inst1|I3|data_x[1]~3998\,
	cin0 => \inst1|I3|add_225~1COUT0\,
	cin1 => \inst1|I3|add_225~1COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_225~2\,
	cout0 => \inst1|I3|add_225~2COUT0\,
	cout1 => \inst1|I3|add_225~2COUT1\);

\inst1|I3|add_225~3_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_225~3\ = \inst1|I3|acc_c[0][2]\ $ \inst1|I3|data_x[2]~3956\ $ \inst1|I3|add_225~2COUT0\
-- \inst1|I3|add_225~3COUT\ = CARRY(\inst1|I3|acc_c[0][2]\ & (!\inst1|I3|add_225~2COUT1\ # !\inst1|I3|data_x[2]~3956\) # !\inst1|I3|acc_c[0][2]\ & !\inst1|I3|data_x[2]~3956\ & !\inst1|I3|add_225~2COUT1\)

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
	dataa => \inst1|I3|acc_c[0][2]\,
	datab => \inst1|I3|data_x[2]~3956\,
	cin0 => \inst1|I3|add_225~2COUT0\,
	cin1 => \inst1|I3|add_225~2COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_225~3\,
	cout => \inst1|I3|add_225~3COUT\);

\inst1|I2|data_is_c[4]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|idata_x[8]~63\ = \inst1|I2|E_x.dwait_e~0\ & K1_data_is_c[4] # !\inst1|I2|E_x.dwait_e~0\ & \inst|altsyncram_component|q_a[8]\
-- \inst1|I2|data_is_c[4]\ = DFFEA(\inst1|I2|idata_x[8]~63\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "F3C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I2|E_x.dwait_e~0\,
	datad => \inst|altsyncram_component|q_a[8]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|idata_x[8]~63\,
	regout => \inst1|I2|data_is_c[4]\);

\DATA_IN_EXT[4]~I\ : cyclone_io 
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
	padio => ww_DATA_IN_EXT(4),
	combout => \DATA_IN_EXT[4]~combout\);

\inst1|I3|data_x[4]~549_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[4]~549\ = \inst1|I3|data_x[6]~3456\ & (\inst3|mux_c[0]\ & \DATA_IN_EXT[4]~combout\ # !\inst3|mux_c[0]\ & \inst|altsyncram_component|q_a[4]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "B080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \DATA_IN_EXT[4]~combout\,
	datab => \inst3|mux_c[0]\,
	datac => \inst1|I3|data_x[6]~3456\,
	datad => \inst|altsyncram_component|q_a[4]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[4]~549\);

\inst1|I4|iinc_i[4]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_x[4]~11\ = \inst1|I4|iinc_we_c\ & \inst1|I3|acc_c[0][4]\ # !\inst1|I4|iinc_we_c\ & \inst1|I4|i~38\ & \inst1|I4|iinc_c[4]\
-- \inst1|I4|iinc_i[4]\ = DFFEA(\inst1|I4|iinc_x[4]~11\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAC0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][4]\,
	datab => \inst1|I4|i~38\,
	datac => \inst1|I4|iinc_c[4]\,
	datad => \inst1|I4|iinc_we_c\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iinc_x[4]~11\,
	regout => \inst1|I4|iinc_i[4]\);

\inst1|I4|iinc_c[4]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_c[4]\ = DFFEA(\inst1|I4|iinc_x[4]~11\ & (\inst1|I4|iinc_i[4]\ # !\inst1|I2|int_stop_x~11\) # !\inst1|I4|iinc_x[4]~11\ & \inst1|I4|iinc_i[4]\ & \inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|iinc_x[4]~11\,
	datac => \inst1|I4|iinc_i[4]\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|iinc_c[4]\);

\inst1|I4|add_205~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205~1\ = \inst1|I4|iinc_c[1]\ $ \inst1|I4|ireg_c[1]\ $ \inst1|I4|add_205~0COUT\
-- \inst1|I4|add_205~1COUT0\ = CARRY(\inst1|I4|iinc_c[1]\ & !\inst1|I4|ireg_c[1]\ & !\inst1|I4|add_205~0COUT\ # !\inst1|I4|iinc_c[1]\ & (!\inst1|I4|add_205~0COUT\ # !\inst1|I4|ireg_c[1]\))
-- \inst1|I4|add_205~1COUT1\ = CARRY(\inst1|I4|iinc_c[1]\ & !\inst1|I4|ireg_c[1]\ & !\inst1|I4|add_205~0COUT\ # !\inst1|I4|iinc_c[1]\ & (!\inst1|I4|add_205~0COUT\ # !\inst1|I4|ireg_c[1]\))

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
	dataa => \inst1|I4|iinc_c[1]\,
	datab => \inst1|I4|ireg_c[1]\,
	cin => \inst1|I4|add_205~0COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205~1\,
	cout0 => \inst1|I4|add_205~1COUT0\,
	cout1 => \inst1|I4|add_205~1COUT1\);

\inst1|I4|add_205~2_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205~2\ = \inst1|I4|iinc_c[2]\ $ \inst1|I4|ireg_c[2]\ $ !(!\inst1|I4|add_205~0COUT\ & \inst1|I4|add_205~1COUT0\) # (\inst1|I4|add_205~0COUT\ & \inst1|I4|add_205~1COUT1\)
-- \inst1|I4|add_205~2COUT0\ = CARRY(\inst1|I4|iinc_c[2]\ & (\inst1|I4|ireg_c[2]\ # !\inst1|I4|add_205~1COUT0\) # !\inst1|I4|iinc_c[2]\ & \inst1|I4|ireg_c[2]\ & !\inst1|I4|add_205~1COUT0\)
-- \inst1|I4|add_205~2COUT1\ = CARRY(\inst1|I4|iinc_c[2]\ & (\inst1|I4|ireg_c[2]\ # !\inst1|I4|add_205~1COUT1\) # !\inst1|I4|iinc_c[2]\ & \inst1|I4|ireg_c[2]\ & !\inst1|I4|add_205~1COUT1\)

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
	dataa => \inst1|I4|iinc_c[2]\,
	datab => \inst1|I4|ireg_c[2]\,
	cin => \inst1|I4|add_205~0COUT\,
	cin0 => \inst1|I4|add_205~1COUT0\,
	cin1 => \inst1|I4|add_205~1COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205~2\,
	cout0 => \inst1|I4|add_205~2COUT0\,
	cout1 => \inst1|I4|add_205~2COUT1\);

\inst1|I4|add_205~3_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205~3\ = \inst1|I4|ireg_c[3]\ $ \inst1|I4|iinc_c[3]\ $ (!\inst1|I4|add_205~0COUT\ & \inst1|I4|add_205~2COUT0\) # (\inst1|I4|add_205~0COUT\ & \inst1|I4|add_205~2COUT1\)
-- \inst1|I4|add_205~3COUT0\ = CARRY(\inst1|I4|ireg_c[3]\ & !\inst1|I4|iinc_c[3]\ & !\inst1|I4|add_205~2COUT0\ # !\inst1|I4|ireg_c[3]\ & (!\inst1|I4|add_205~2COUT0\ # !\inst1|I4|iinc_c[3]\))
-- \inst1|I4|add_205~3COUT1\ = CARRY(\inst1|I4|ireg_c[3]\ & !\inst1|I4|iinc_c[3]\ & !\inst1|I4|add_205~2COUT1\ # !\inst1|I4|ireg_c[3]\ & (!\inst1|I4|add_205~2COUT1\ # !\inst1|I4|iinc_c[3]\))

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
	dataa => \inst1|I4|ireg_c[3]\,
	datab => \inst1|I4|iinc_c[3]\,
	cin => \inst1|I4|add_205~0COUT\,
	cin0 => \inst1|I4|add_205~2COUT0\,
	cin1 => \inst1|I4|add_205~2COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205~3\,
	cout0 => \inst1|I4|add_205~3COUT0\,
	cout1 => \inst1|I4|add_205~3COUT1\);

\inst1|I4|add_205~4_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205~4\ = \inst1|I4|ireg_c[4]\ $ \inst1|I4|iinc_c[4]\ $ !(!\inst1|I4|add_205~0COUT\ & \inst1|I4|add_205~3COUT0\) # (\inst1|I4|add_205~0COUT\ & \inst1|I4|add_205~3COUT1\)
-- \inst1|I4|add_205~4COUT0\ = CARRY(\inst1|I4|ireg_c[4]\ & (\inst1|I4|iinc_c[4]\ # !\inst1|I4|add_205~3COUT0\) # !\inst1|I4|ireg_c[4]\ & \inst1|I4|iinc_c[4]\ & !\inst1|I4|add_205~3COUT0\)
-- \inst1|I4|add_205~4COUT1\ = CARRY(\inst1|I4|ireg_c[4]\ & (\inst1|I4|iinc_c[4]\ # !\inst1|I4|add_205~3COUT1\) # !\inst1|I4|ireg_c[4]\ & \inst1|I4|iinc_c[4]\ & !\inst1|I4|add_205~3COUT1\)

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
	dataa => \inst1|I4|ireg_c[4]\,
	datab => \inst1|I4|iinc_c[4]\,
	cin => \inst1|I4|add_205~0COUT\,
	cin0 => \inst1|I4|add_205~3COUT0\,
	cin1 => \inst1|I4|add_205~3COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205~4\,
	cout0 => \inst1|I4|add_205~4COUT0\,
	cout1 => \inst1|I4|add_205~4COUT1\);

\inst1|I4|i~2616_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|i~2616\ = !\inst1|I2|idata_x[5]~36\ & !\inst1|I2|idata_x[6]~30\ & !\inst1|I2|idata_x[4]~39\ & \inst1|I4|i~40\

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
	dataa => \inst1|I2|idata_x[5]~36\,
	datab => \inst1|I2|idata_x[6]~30\,
	datac => \inst1|I2|idata_x[4]~39\,
	datad => \inst1|I4|i~40\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|i~2616\);

\inst1|I4|add_205_rtl_595~122_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~122\ = \inst1|I4|ireg_c[4]\ & (\inst1|I4|add_205~4\ # !\inst1|I4|i~2616\) # !\inst1|I4|ireg_c[4]\ & \inst1|I4|add_205~4\ & \inst1|I4|i~2616\

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
	dataa => \inst1|I4|ireg_c[4]\,
	datac => \inst1|I4|add_205~4\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~122\);

\inst1|I4|ireg_i[4]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~127\ = \inst1|I4|ireg_we_c\ & \inst1|I3|acc_c[0][4]\ # !\inst1|I4|ireg_we_c\ & \inst1|I4|i~38\ & \inst1|I4|add_205_rtl_595~122\
-- \inst1|I4|ireg_i[4]\ = DFFEA(\inst1|I4|add_205_rtl_595~127\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][4]\,
	datab => \inst1|I4|ireg_we_c\,
	datac => \inst1|I4|i~38\,
	datad => \inst1|I4|add_205_rtl_595~122\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~127\,
	regout => \inst1|I4|ireg_i[4]\);

\inst1|I4|ireg_c[4]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ireg_c[4]\ = DFFEA(\inst1|I4|ireg_i[4]\ & (\inst1|I4|add_205_rtl_595~127\ # \inst1|I2|int_stop_x~11\) # !\inst1|I4|ireg_i[4]\ & \inst1|I4|add_205_rtl_595~127\ & !\inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|ireg_i[4]\,
	datac => \inst1|I4|add_205_rtl_595~127\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|ireg_c[4]\);

\inst1|I3|data_x[4]~3664_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[4]~3664\ = \inst1|I4|ireg_c[4]\ & (\inst1|I4|iinc_c[4]\ & \inst1|I3|data_x[9]~3459\ # !\inst1|I4|reduce_nor_207\) # !\inst1|I4|ireg_c[4]\ & \inst1|I4|iinc_c[4]\ & \inst1|I3|data_x[9]~3459\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F222",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ireg_c[4]\,
	datab => \inst1|I4|reduce_nor_207\,
	datac => \inst1|I4|iinc_c[4]\,
	datad => \inst1|I3|data_x[9]~3459\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[4]~3664\);

\inst1|I4|data_exp_i[4]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iadata_x[16]~11\ = \inst1|I4|dexp_we_c\ & \inst1|I3|acc_c[0][4]\ # !\inst1|I4|dexp_we_c\ & \inst1|I4|i~38\ & \inst1|I4|data_exp_c[4]\
-- \inst1|I4|data_exp_i[4]\ = DFFEA(\inst1|I4|iadata_x[16]~11\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I4|i~38\,
	datab => \inst1|I4|dexp_we_c\,
	datac => \inst1|I4|data_exp_c[4]\,
	datad => \inst1|I3|acc_c[0][4]\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iadata_x[16]~11\,
	regout => \inst1|I4|data_exp_i[4]\);

\inst1|I4|data_exp_c[4]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_exp_c[4]\ = DFFEA(\inst1|I4|iadata_x[16]~11\ & (\inst1|I4|data_exp_i[4]\ # !\inst1|I2|int_stop_x~11\) # !\inst1|I4|iadata_x[16]~11\ & \inst1|I4|data_exp_i[4]\ & \inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|iadata_x[16]~11\,
	datac => \inst1|I4|data_exp_i[4]\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|data_exp_c[4]\);

\inst1|I3|data_x[4]~2473_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[4]~2473\ = \inst1|I3|data_x[9]~3458\ & (\inst1|I3|data_x[4]~3664\ # \inst1|I4|data_exp_c[4]\ & \inst1|I3|data_x[9]~3457\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E0A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|data_x[4]~3664\,
	datab => \inst1|I4|data_exp_c[4]\,
	datac => \inst1|I3|data_x[9]~3458\,
	datad => \inst1|I3|data_x[9]~3457\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[4]~2473\);

\inst1|I3|data_x[4]~3692_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[4]~3692\ = \inst1|I3|data_x[4]~549\ # \inst1|I3|data_x[4]~2473\ # \inst1|I2|data_is_c[4]\ & !\inst1|I3|reduce_nor_95\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|data_is_c[4]\,
	datab => \inst1|I3|reduce_nor_95\,
	datac => \inst1|I3|data_x[4]~549\,
	datad => \inst1|I3|data_x[4]~2473\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[4]~3692\);

\rtl~14126_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14126\ = \rtl~13588\ & (\inst1|I3|data_x[4]~3692\ $ (\inst1|I3|acc_c[0][4]\ & \inst1|I2|TD_c[0]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "7080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][4]\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \rtl~13588\,
	datad => \inst1|I3|data_x[4]~3692\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14126\);

\rtl~2549_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2549\ = \inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][5]\ & !\inst1|I2|TD_c[2]\ # !\inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][5]\ # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][4]\)

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
	dataa => \inst1|I3|acc_c[0][5]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I3|acc_c[0][4]\,
	datad => \inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2549\);

\rtl~2740_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2740\ = \inst1|I2|TD_c[2]\ & (\inst1|I3|acc_c[0][4]\ $ \inst1|I2|TD_c[1]\) # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][3]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "74B8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][4]\,
	datab => \inst1|I2|TD_c[2]\,
	datac => \inst1|I3|acc_c[0][3]\,
	datad => \inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2740\);

\rtl~2745_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2745\ = \inst1|I2|TD_c[0]\ & \rtl~2740\ # !\inst1|I2|TD_c[0]\ & \rtl~2549\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EE44",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datab => \rtl~2549\,
	datad => \rtl~2740\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2745\);

\inst1|I3|add_225~4_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_225~4\ = \inst1|I3|acc_c[0][3]\ $ \inst1|I3|data_x[3]~3914\ $ !\inst1|I3|add_225~3COUT\
-- \inst1|I3|add_225~4COUT0\ = CARRY(\inst1|I3|acc_c[0][3]\ & \inst1|I3|data_x[3]~3914\ & !\inst1|I3|add_225~3COUT\ # !\inst1|I3|acc_c[0][3]\ & (\inst1|I3|data_x[3]~3914\ # !\inst1|I3|add_225~3COUT\))
-- \inst1|I3|add_225~4COUT1\ = CARRY(\inst1|I3|acc_c[0][3]\ & \inst1|I3|data_x[3]~3914\ & !\inst1|I3|add_225~3COUT\ # !\inst1|I3|acc_c[0][3]\ & (\inst1|I3|data_x[3]~3914\ # !\inst1|I3|add_225~3COUT\))

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
	dataa => \inst1|I3|acc_c[0][3]\,
	datab => \inst1|I3|data_x[3]~3914\,
	cin => \inst1|I3|add_225~3COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_225~4\,
	cout0 => \inst1|I3|add_225~4COUT0\,
	cout1 => \inst1|I3|add_225~4COUT1\);

\inst1|I3|add_225~5_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_225~5\ = \inst1|I3|acc_c[0][4]\ $ \inst1|I3|data_x[4]~3692\ $ (!\inst1|I3|add_225~3COUT\ & \inst1|I3|add_225~4COUT0\) # (\inst1|I3|add_225~3COUT\ & \inst1|I3|add_225~4COUT1\)
-- \inst1|I3|add_225~5COUT0\ = CARRY(\inst1|I3|acc_c[0][4]\ & (!\inst1|I3|add_225~4COUT0\ # !\inst1|I3|data_x[4]~3692\) # !\inst1|I3|acc_c[0][4]\ & !\inst1|I3|data_x[4]~3692\ & !\inst1|I3|add_225~4COUT0\)
-- \inst1|I3|add_225~5COUT1\ = CARRY(\inst1|I3|acc_c[0][4]\ & (!\inst1|I3|add_225~4COUT1\ # !\inst1|I3|data_x[4]~3692\) # !\inst1|I3|acc_c[0][4]\ & !\inst1|I3|data_x[4]~3692\ & !\inst1|I3|add_225~4COUT1\)

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
	dataa => \inst1|I3|acc_c[0][4]\,
	datab => \inst1|I3|data_x[4]~3692\,
	cin => \inst1|I3|add_225~3COUT\,
	cin0 => \inst1|I3|add_225~4COUT0\,
	cin1 => \inst1|I3|add_225~4COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_225~5\,
	cout0 => \inst1|I3|add_225~5COUT0\,
	cout1 => \inst1|I3|add_225~5COUT1\);

\inst1|I3|add_185~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_185~0\ = \inst1|I3|acc_c[0][0]\ $ \inst1|I3|data_x[0]~4040\
-- \inst1|I3|add_185~0COUT0\ = CARRY(\inst1|I3|acc_c[0][0]\ & \inst1|I3|data_x[0]~4040\)
-- \inst1|I3|add_185~0COUT1\ = CARRY(\inst1|I3|acc_c[0][0]\ & \inst1|I3|data_x[0]~4040\)

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
	dataa => \inst1|I3|acc_c[0][0]\,
	datab => \inst1|I3|data_x[0]~4040\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_185~0\,
	cout0 => \inst1|I3|add_185~0COUT0\,
	cout1 => \inst1|I3|add_185~0COUT1\);

\inst1|I3|add_185~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_185~1\ = \inst1|I3|acc_c[0][1]\ $ \inst1|I3|data_x[1]~3998\ $ \inst1|I3|add_185~0COUT0\
-- \inst1|I3|add_185~1COUT0\ = CARRY(\inst1|I3|acc_c[0][1]\ & !\inst1|I3|data_x[1]~3998\ & !\inst1|I3|add_185~0COUT0\ # !\inst1|I3|acc_c[0][1]\ & (!\inst1|I3|add_185~0COUT0\ # !\inst1|I3|data_x[1]~3998\))
-- \inst1|I3|add_185~1COUT1\ = CARRY(\inst1|I3|acc_c[0][1]\ & !\inst1|I3|data_x[1]~3998\ & !\inst1|I3|add_185~0COUT1\ # !\inst1|I3|acc_c[0][1]\ & (!\inst1|I3|add_185~0COUT1\ # !\inst1|I3|data_x[1]~3998\))

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
	dataa => \inst1|I3|acc_c[0][1]\,
	datab => \inst1|I3|data_x[1]~3998\,
	cin0 => \inst1|I3|add_185~0COUT0\,
	cin1 => \inst1|I3|add_185~0COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_185~1\,
	cout0 => \inst1|I3|add_185~1COUT0\,
	cout1 => \inst1|I3|add_185~1COUT1\);

\inst1|I3|add_185~2_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_185~2\ = \inst1|I3|acc_c[0][2]\ $ \inst1|I3|data_x[2]~3956\ $ !\inst1|I3|add_185~1COUT0\
-- \inst1|I3|add_185~2COUT\ = CARRY(\inst1|I3|acc_c[0][2]\ & (\inst1|I3|data_x[2]~3956\ # !\inst1|I3|add_185~1COUT1\) # !\inst1|I3|acc_c[0][2]\ & \inst1|I3|data_x[2]~3956\ & !\inst1|I3|add_185~1COUT1\)

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
	dataa => \inst1|I3|acc_c[0][2]\,
	datab => \inst1|I3|data_x[2]~3956\,
	cin0 => \inst1|I3|add_185~1COUT0\,
	cin1 => \inst1|I3|add_185~1COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_185~2\,
	cout => \inst1|I3|add_185~2COUT\);

\inst1|I3|add_185~3_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_185~3\ = \inst1|I3|acc_c[0][3]\ $ \inst1|I3|data_x[3]~3914\ $ \inst1|I3|add_185~2COUT\
-- \inst1|I3|add_185~3COUT0\ = CARRY(\inst1|I3|acc_c[0][3]\ & !\inst1|I3|data_x[3]~3914\ & !\inst1|I3|add_185~2COUT\ # !\inst1|I3|acc_c[0][3]\ & (!\inst1|I3|add_185~2COUT\ # !\inst1|I3|data_x[3]~3914\))
-- \inst1|I3|add_185~3COUT1\ = CARRY(\inst1|I3|acc_c[0][3]\ & !\inst1|I3|data_x[3]~3914\ & !\inst1|I3|add_185~2COUT\ # !\inst1|I3|acc_c[0][3]\ & (!\inst1|I3|add_185~2COUT\ # !\inst1|I3|data_x[3]~3914\))

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
	dataa => \inst1|I3|acc_c[0][3]\,
	datab => \inst1|I3|data_x[3]~3914\,
	cin => \inst1|I3|add_185~2COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_185~3\,
	cout0 => \inst1|I3|add_185~3COUT0\,
	cout1 => \inst1|I3|add_185~3COUT1\);

\inst1|I3|add_185~4_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_185~4\ = \inst1|I3|acc_c[0][4]\ $ \inst1|I3|data_x[4]~3692\ $ !(!\inst1|I3|add_185~2COUT\ & \inst1|I3|add_185~3COUT0\) # (\inst1|I3|add_185~2COUT\ & \inst1|I3|add_185~3COUT1\)
-- \inst1|I3|add_185~4COUT0\ = CARRY(\inst1|I3|acc_c[0][4]\ & (\inst1|I3|data_x[4]~3692\ # !\inst1|I3|add_185~3COUT0\) # !\inst1|I3|acc_c[0][4]\ & \inst1|I3|data_x[4]~3692\ & !\inst1|I3|add_185~3COUT0\)
-- \inst1|I3|add_185~4COUT1\ = CARRY(\inst1|I3|acc_c[0][4]\ & (\inst1|I3|data_x[4]~3692\ # !\inst1|I3|add_185~3COUT1\) # !\inst1|I3|acc_c[0][4]\ & \inst1|I3|data_x[4]~3692\ & !\inst1|I3|add_185~3COUT1\)

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
	dataa => \inst1|I3|acc_c[0][4]\,
	datab => \inst1|I3|data_x[4]~3692\,
	cin => \inst1|I3|add_185~2COUT\,
	cin0 => \inst1|I3|add_185~3COUT0\,
	cin1 => \inst1|I3|add_185~3COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_185~4\,
	cout0 => \inst1|I3|add_185~4COUT0\,
	cout1 => \inst1|I3|add_185~4COUT1\);

\inst1|I3|Mux_262_rtl_86_rtl_367~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_262_rtl_86_rtl_367~0\ = \inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[0]\ # \inst1|I3|add_225~5\) # !\inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[0]\ & \inst1|I3|add_185~4\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "D9C8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I3|add_225~5\,
	datad => \inst1|I3|add_185~4\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_262_rtl_86_rtl_367~0\);

\inst1|I3|Mux_262_rtl_86_rtl_367~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_262_rtl_86_rtl_367~1\ = \inst1|I3|acc_c[0][4]\ & (\inst1|I3|Mux_262_rtl_86_rtl_367~0\ # \inst1|I2|TD_c[0]\ & \inst1|I3|data_x[4]~3692\) # !\inst1|I3|acc_c[0][4]\ & \inst1|I3|Mux_262_rtl_86_rtl_367~0\ & (\inst1|I3|data_x[4]~3692\ # !\inst1|I2|TD_c[0]\)

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
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I3|acc_c[0][4]\,
	datac => \inst1|I3|data_x[4]~3692\,
	datad => \inst1|I3|Mux_262_rtl_86_rtl_367~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_262_rtl_86_rtl_367~1\);

\rtl~14104_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14104\ = \inst1|I3|acc_c[0][4]\ & (\rtl~13900\ # \rtl~13596\ & \inst1|I3|Mux_262_rtl_86_rtl_367~1\) # !\inst1|I3|acc_c[0][4]\ & \rtl~13596\ & \inst1|I3|Mux_262_rtl_86_rtl_367~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][4]\,
	datab => \rtl~13900\,
	datac => \rtl~13596\,
	datad => \inst1|I3|Mux_262_rtl_86_rtl_367~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14104\);

\rtl~14109_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14109\ = \rtl~14104\ # \rtl~2745\ & (\inst1|I2|TC_c[1]\ $ !\inst1|I2|TC_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF82",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~2745\,
	datab => \inst1|I2|TC_c[1]\,
	datac => \inst1|I2|TC_c[0]\,
	datad => \rtl~14104\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14109\);

\inst1|I3|acc_c[0][4]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][4]~156\ = \inst1|I3|acc[0][4]~8234\ # \inst1|I3|acc[0][13]~8146\ & (\rtl~14126\ # \rtl~14109\)
-- \inst1|I3|acc_c[0][4]\ = DFFEA(\inst1|I3|acc[0][4]~156\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][13]~8146\,
	datab => \inst1|I3|acc[0][4]~8234\,
	datac => \rtl~14126\,
	datad => \rtl~14109\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][4]~156\,
	regout => \inst1|I3|acc_c[0][4]\);

\inst1|I3|acc_i[0][4]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][4]~8234\ = \inst1|I3|acc[0][13]~8147\ & (L1_acc_i[0][4] # \inst1|I3|acc[0][13]~111\ & \inst1|I3|acc_c[0][4]\) # !\inst1|I3|acc[0][13]~8147\ & \inst1|I3|acc[0][13]~111\ & \inst1|I3|acc_c[0][4]\

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][13]~8147\,
	datab => \inst1|I3|acc[0][13]~111\,
	datac => \inst1|I3|acc[0][4]~156\,
	datad => \inst1|I3|acc_c[0][4]\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][4]~8234\);

\inst1|I3|add_225~6_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_225~6\ = \inst1|I3|acc_c[0][5]\ $ \inst1|I3|data_x[5]~3650\ $ !(!\inst1|I3|add_225~3COUT\ & \inst1|I3|add_225~5COUT0\) # (\inst1|I3|add_225~3COUT\ & \inst1|I3|add_225~5COUT1\)
-- \inst1|I3|add_225~6COUT0\ = CARRY(\inst1|I3|acc_c[0][5]\ & \inst1|I3|data_x[5]~3650\ & !\inst1|I3|add_225~5COUT0\ # !\inst1|I3|acc_c[0][5]\ & (\inst1|I3|data_x[5]~3650\ # !\inst1|I3|add_225~5COUT0\))
-- \inst1|I3|add_225~6COUT1\ = CARRY(\inst1|I3|acc_c[0][5]\ & \inst1|I3|data_x[5]~3650\ & !\inst1|I3|add_225~5COUT1\ # !\inst1|I3|acc_c[0][5]\ & (\inst1|I3|data_x[5]~3650\ # !\inst1|I3|add_225~5COUT1\))

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
	dataa => \inst1|I3|acc_c[0][5]\,
	datab => \inst1|I3|data_x[5]~3650\,
	cin => \inst1|I3|add_225~3COUT\,
	cin0 => \inst1|I3|add_225~5COUT0\,
	cin1 => \inst1|I3|add_225~5COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_225~6\,
	cout0 => \inst1|I3|add_225~6COUT0\,
	cout1 => \inst1|I3|add_225~6COUT1\);

\inst1|I3|add_225~7_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_225~7\ = \inst1|I3|acc_c[0][6]\ $ \inst1|I3|data_x[6]~3608\ $ (!\inst1|I3|add_225~3COUT\ & \inst1|I3|add_225~6COUT0\) # (\inst1|I3|add_225~3COUT\ & \inst1|I3|add_225~6COUT1\)
-- \inst1|I3|add_225~7COUT0\ = CARRY(\inst1|I3|acc_c[0][6]\ & (!\inst1|I3|add_225~6COUT0\ # !\inst1|I3|data_x[6]~3608\) # !\inst1|I3|acc_c[0][6]\ & !\inst1|I3|data_x[6]~3608\ & !\inst1|I3|add_225~6COUT0\)
-- \inst1|I3|add_225~7COUT1\ = CARRY(\inst1|I3|acc_c[0][6]\ & (!\inst1|I3|add_225~6COUT1\ # !\inst1|I3|data_x[6]~3608\) # !\inst1|I3|acc_c[0][6]\ & !\inst1|I3|data_x[6]~3608\ & !\inst1|I3|add_225~6COUT1\)

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
	dataa => \inst1|I3|acc_c[0][6]\,
	datab => \inst1|I3|data_x[6]~3608\,
	cin => \inst1|I3|add_225~3COUT\,
	cin0 => \inst1|I3|add_225~6COUT0\,
	cin1 => \inst1|I3|add_225~6COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_225~7\,
	cout0 => \inst1|I3|add_225~7COUT0\,
	cout1 => \inst1|I3|add_225~7COUT1\);

\inst1|I3|add_225~8_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_225~8\ = \inst1|I3|acc_c[0][7]\ $ \inst1|I3|data_x[7]~3872\ $ !(!\inst1|I3|add_225~3COUT\ & \inst1|I3|add_225~7COUT0\) # (\inst1|I3|add_225~3COUT\ & \inst1|I3|add_225~7COUT1\)
-- \inst1|I3|add_225~8COUT\ = CARRY(\inst1|I3|acc_c[0][7]\ & \inst1|I3|data_x[7]~3872\ & !\inst1|I3|add_225~7COUT1\ # !\inst1|I3|acc_c[0][7]\ & (\inst1|I3|data_x[7]~3872\ # !\inst1|I3|add_225~7COUT1\))

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
	dataa => \inst1|I3|acc_c[0][7]\,
	datab => \inst1|I3|data_x[7]~3872\,
	cin => \inst1|I3|add_225~3COUT\,
	cin0 => \inst1|I3|add_225~7COUT0\,
	cin1 => \inst1|I3|add_225~7COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_225~8\,
	cout => \inst1|I3|add_225~8COUT\);

\inst1|I2|data_is_c[11]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|data_is_c[11]\ = DFFEA(\inst1|I2|data_is_c[11]\ & (\inst1|I2|E_x.dwait_e~0\ # \inst|altsyncram_component|q_a[15]\) # !\inst1|I2|data_is_c[11]\ & !\inst1|I2|E_x.dwait_e~0\ & \inst|altsyncram_component|q_a[15]\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "B8B8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I2|data_is_c[11]\,
	datab => \inst1|I2|E_x.dwait_e~0\,
	datac => \inst|altsyncram_component|q_a[15]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I2|data_is_c[11]\);

\DATA_IN_EXT[11]~I\ : cyclone_io 
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
	padio => ww_DATA_IN_EXT(11),
	combout => \DATA_IN_EXT[11]~combout\);

\inst1|I3|data_x[11]~741_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[11]~741\ = \inst1|I3|data_x[6]~3456\ & (\inst3|mux_c[0]\ & \DATA_IN_EXT[11]~combout\ # !\inst3|mux_c[0]\ & \inst|altsyncram_component|q_a[11]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "B800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \DATA_IN_EXT[11]~combout\,
	datab => \inst3|mux_c[0]\,
	datac => \inst|altsyncram_component|q_a[11]\,
	datad => \inst1|I3|data_x[6]~3456\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[11]~741\);

\inst1|I4|data_exp_i[11]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iadata_x[23]~14\ = \inst1|I4|dexp_we_c\ & \inst1|I3|acc_c[0][11]\ # !\inst1|I4|dexp_we_c\ & \inst1|I4|i~38\ & \inst1|I4|data_exp_c[11]\
-- \inst1|I4|data_exp_i[11]\ = DFFEA(\inst1|I4|iadata_x[23]~14\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I4|dexp_we_c\,
	datab => \inst1|I3|acc_c[0][11]\,
	datac => \inst1|I4|i~38\,
	datad => \inst1|I4|data_exp_c[11]\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iadata_x[23]~14\,
	regout => \inst1|I4|data_exp_i[11]\);

\inst1|I4|data_exp_c[11]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_exp_c[11]\ = DFFEA(\inst1|I4|data_exp_i[11]\ & (\inst1|I4|iadata_x[23]~14\ # \inst1|I2|int_stop_x~11\) # !\inst1|I4|data_exp_i[11]\ & \inst1|I4|iadata_x[23]~14\ & !\inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|data_exp_i[11]\,
	datac => \inst1|I4|iadata_x[23]~14\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|data_exp_c[11]\);

\inst1|I4|iinc_i[11]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_x[11]~14\ = \inst1|I4|iinc_we_c\ & \inst1|I3|acc_c[0][11]\ # !\inst1|I4|iinc_we_c\ & \inst1|I4|iinc_c[11]\ & \inst1|I4|i~38\
-- \inst1|I4|iinc_i[11]\ = DFFEA(\inst1|I4|iinc_x[11]~14\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I4|iinc_c[11]\,
	datab => \inst1|I3|acc_c[0][11]\,
	datac => \inst1|I4|iinc_we_c\,
	datad => \inst1|I4|i~38\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iinc_x[11]~14\,
	regout => \inst1|I4|iinc_i[11]\);

\inst1|I4|iinc_c[11]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_c[11]\ = DFFEA(\inst1|I4|iinc_i[11]\ & (\inst1|I4|iinc_x[11]~14\ # \inst1|I2|int_stop_x~11\) # !\inst1|I4|iinc_i[11]\ & \inst1|I4|iinc_x[11]~14\ & !\inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|iinc_i[11]\,
	datac => \inst1|I4|iinc_x[11]~14\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|iinc_c[11]\);

\inst1|I4|data_exp_i[10]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iadata_x[22]~17\ = \inst1|I4|dexp_we_c\ & \inst1|I3|acc_c[0][10]\ # !\inst1|I4|dexp_we_c\ & \inst1|I4|data_exp_c[10]\ & \inst1|I4|i~38\
-- \inst1|I4|data_exp_i[10]\ = DFFEA(\inst1|I4|iadata_x[22]~17\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|data_exp_c[10]\,
	datab => \inst1|I4|dexp_we_c\,
	datac => \inst1|I3|acc_c[0][10]\,
	datad => \inst1|I4|i~38\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iadata_x[22]~17\,
	regout => \inst1|I4|data_exp_i[10]\);

\inst1|I4|data_exp_c[10]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_exp_c[10]\ = DFFEA(\inst1|I4|data_exp_i[10]\ & (\inst1|I4|iadata_x[22]~17\ # \inst1|I2|int_stop_x~11\) # !\inst1|I4|data_exp_i[10]\ & \inst1|I4|iadata_x[22]~17\ & !\inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AACC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|data_exp_i[10]\,
	datab => \inst1|I4|iadata_x[22]~17\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|data_exp_c[10]\);

\inst1|I4|iinc_i[10]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_x[10]~17\ = \inst1|I4|iinc_we_c\ & \inst1|I3|acc_c[0][10]\ # !\inst1|I4|iinc_we_c\ & \inst1|I4|iinc_c[10]\ & \inst1|I4|i~38\
-- \inst1|I4|iinc_i[10]\ = DFFEA(\inst1|I4|iinc_x[10]~17\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I4|iinc_we_c\,
	datab => \inst1|I3|acc_c[0][10]\,
	datac => \inst1|I4|iinc_c[10]\,
	datad => \inst1|I4|i~38\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iinc_x[10]~17\,
	regout => \inst1|I4|iinc_i[10]\);

\inst1|I4|iinc_c[10]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_c[10]\ = DFFEA(\inst1|I4|iinc_x[10]~17\ & (\inst1|I4|iinc_i[10]\ # !\inst1|I2|int_stop_x~11\) # !\inst1|I4|iinc_x[10]~17\ & \inst1|I4|iinc_i[10]\ & \inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|iinc_x[10]~17\,
	datac => \inst1|I4|iinc_i[10]\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|iinc_c[10]\);

\inst1|I3|data_x[10]~3760_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[10]~3760\ = \inst1|I4|iinc_c[10]\ & (\inst1|I3|data_x[9]~3459\ # \inst1|I4|ireg_c[10]\ & !\inst1|I4|reduce_nor_207\) # !\inst1|I4|iinc_c[10]\ & \inst1|I4|ireg_c[10]\ & !\inst1|I4|reduce_nor_207\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AE0C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|iinc_c[10]\,
	datab => \inst1|I4|ireg_c[10]\,
	datac => \inst1|I4|reduce_nor_207\,
	datad => \inst1|I3|data_x[9]~3459\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[10]~3760\);

\inst1|I3|data_x[10]~2775_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[10]~2775\ = \inst1|I3|data_x[9]~3458\ & (\inst1|I3|data_x[10]~3760\ # \inst1|I4|data_exp_c[10]\ & \inst1|I3|data_x[9]~3457\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EC00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|data_exp_c[10]\,
	datab => \inst1|I3|data_x[10]~3760\,
	datac => \inst1|I3|data_x[9]~3457\,
	datad => \inst1|I3|data_x[9]~3458\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[10]~2775\);

\DATA_IN_EXT[10]~I\ : cyclone_io 
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
	padio => ww_DATA_IN_EXT(10),
	combout => \DATA_IN_EXT[10]~combout\);

\inst1|I3|data_x[10]~843_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[10]~843\ = \inst1|I3|data_x[6]~3456\ & (\inst3|mux_c[0]\ & \DATA_IN_EXT[10]~combout\ # !\inst3|mux_c[0]\ & \inst|altsyncram_component|q_a[10]\)

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
	dataa => \inst3|mux_c[0]\,
	datab => \DATA_IN_EXT[10]~combout\,
	datac => \inst|altsyncram_component|q_a[10]\,
	datad => \inst1|I3|data_x[6]~3456\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[10]~843\);

\inst1|I3|data_x[10]~3788_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[10]~3788\ = \inst1|I3|data_x[10]~2775\ # \inst1|I3|data_x[10]~843\ # \inst1|I2|data_is_c[10]\ & !\inst1|I3|reduce_nor_95\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|data_is_c[10]\,
	datab => \inst1|I3|reduce_nor_95\,
	datac => \inst1|I3|data_x[10]~2775\,
	datad => \inst1|I3|data_x[10]~843\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[10]~3788\);

\rtl~14343_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14343\ = \rtl~13588\ & (\inst1|I3|data_x[10]~3788\ $ (\inst1|I2|TD_c[0]\ & \inst1|I3|acc_c[0][10]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "28A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~13588\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \inst1|I3|data_x[10]~3788\,
	datad => \inst1|I3|acc_c[0][10]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14343\);

\inst1|I2|data_is_c[9]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|idata_x[13]~42\ = \inst|altsyncram_component|q_a[13]\ & (K1_data_is_c[9] # !\inst1|I2|E_x.dwait_e~0\) # !\inst|altsyncram_component|q_a[13]\ & K1_data_is_c[9] & \inst1|I2|E_x.dwait_e~0\
-- \inst1|I2|data_is_c[9]\ = DFFEA(\inst1|I2|idata_x[13]~42\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "F0CC",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst|altsyncram_component|q_a[13]\,
	datad => \inst1|I2|E_x.dwait_e~0\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|idata_x[13]~42\,
	regout => \inst1|I2|data_is_c[9]\);

\inst1|I4|data_exp_i[9]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iadata_x[21]~2\ = \inst1|I4|dexp_we_c\ & \inst1|I3|acc_c[0][9]\ # !\inst1|I4|dexp_we_c\ & \inst1|I4|data_exp_c[9]\ & \inst1|I4|i~38\
-- \inst1|I4|data_exp_i[9]\ = DFFEA(\inst1|I4|iadata_x[21]~2\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I4|dexp_we_c\,
	datab => \inst1|I4|data_exp_c[9]\,
	datac => \inst1|I3|acc_c[0][9]\,
	datad => \inst1|I4|i~38\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iadata_x[21]~2\,
	regout => \inst1|I4|data_exp_i[9]\);

\inst1|I4|data_exp_c[9]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_exp_c[9]\ = DFFEA(\inst1|I4|data_exp_i[9]\ & (\inst1|I2|int_stop_x~11\ # \inst1|I4|iadata_x[21]~2\) # !\inst1|I4|data_exp_i[9]\ & !\inst1|I2|int_stop_x~11\ & \inst1|I4|iadata_x[21]~2\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFA0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|data_exp_i[9]\,
	datac => \inst1|I2|int_stop_x~11\,
	datad => \inst1|I4|iadata_x[21]~2\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|data_exp_c[9]\);

\inst1|I4|iinc_i[9]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_x[9]~2\ = \inst1|I4|iinc_we_c\ & \inst1|I3|acc_c[0][9]\ # !\inst1|I4|iinc_we_c\ & \inst1|I4|iinc_c[9]\ & \inst1|I4|i~38\
-- \inst1|I4|iinc_i[9]\ = DFFEA(\inst1|I4|iinc_x[9]~2\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|iinc_c[9]\,
	datab => \inst1|I4|iinc_we_c\,
	datac => \inst1|I3|acc_c[0][9]\,
	datad => \inst1|I4|i~38\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iinc_x[9]~2\,
	regout => \inst1|I4|iinc_i[9]\);

\inst1|I4|iinc_c[9]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_c[9]\ = DFFEA(\inst1|I4|iinc_i[9]\ & (\inst1|I2|int_stop_x~11\ # \inst1|I4|iinc_x[9]~2\) # !\inst1|I4|iinc_i[9]\ & !\inst1|I2|int_stop_x~11\ & \inst1|I4|iinc_x[9]~2\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CFC0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|iinc_i[9]\,
	datac => \inst1|I2|int_stop_x~11\,
	datad => \inst1|I4|iinc_x[9]~2\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|iinc_c[9]\);

\inst1|I4|iinc_i[8]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_x[8]~20\ = \inst1|I4|iinc_we_c\ & \inst1|I3|acc_c[0][8]\ # !\inst1|I4|iinc_we_c\ & \inst1|I4|iinc_c[8]\ & \inst1|I4|i~38\
-- \inst1|I4|iinc_i[8]\ = DFFEA(\inst1|I4|iinc_x[8]~20\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F088",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|iinc_c[8]\,
	datab => \inst1|I4|i~38\,
	datac => \inst1|I3|acc_c[0][8]\,
	datad => \inst1|I4|iinc_we_c\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iinc_x[8]~20\,
	regout => \inst1|I4|iinc_i[8]\);

\inst1|I4|iinc_c[8]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_c[8]\ = DFFEA(\inst1|I4|iinc_i[8]\ & (\inst1|I4|iinc_x[8]~20\ # \inst1|I2|int_stop_x~11\) # !\inst1|I4|iinc_i[8]\ & \inst1|I4|iinc_x[8]~20\ & !\inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|iinc_i[8]\,
	datac => \inst1|I4|iinc_x[8]~20\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|iinc_c[8]\);

\inst1|I4|iinc_i[6]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_x[6]~5\ = \inst1|I4|iinc_we_c\ & \inst1|I3|acc_c[0][6]\ # !\inst1|I4|iinc_we_c\ & \inst1|I4|i~38\ & \inst1|I4|iinc_c[6]\
-- \inst1|I4|iinc_i[6]\ = DFFEA(\inst1|I4|iinc_x[6]~5\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EA40",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|iinc_we_c\,
	datab => \inst1|I4|i~38\,
	datac => \inst1|I4|iinc_c[6]\,
	datad => \inst1|I3|acc_c[0][6]\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iinc_x[6]~5\,
	regout => \inst1|I4|iinc_i[6]\);

\inst1|I4|iinc_c[6]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_c[6]\ = DFFEA(\inst1|I4|iinc_i[6]\ & (\inst1|I4|iinc_x[6]~5\ # \inst1|I2|int_stop_x~11\) # !\inst1|I4|iinc_i[6]\ & \inst1|I4|iinc_x[6]~5\ & !\inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|iinc_i[6]\,
	datac => \inst1|I4|iinc_x[6]~5\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|iinc_c[6]\);

\inst1|I4|add_205~6_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205~6\ = \inst1|I4|iinc_c[6]\ $ \inst1|I4|ireg_c[6]\ $ !\inst1|I4|add_205~5COUT\
-- \inst1|I4|add_205~6COUT0\ = CARRY(\inst1|I4|iinc_c[6]\ & (\inst1|I4|ireg_c[6]\ # !\inst1|I4|add_205~5COUT\) # !\inst1|I4|iinc_c[6]\ & \inst1|I4|ireg_c[6]\ & !\inst1|I4|add_205~5COUT\)
-- \inst1|I4|add_205~6COUT1\ = CARRY(\inst1|I4|iinc_c[6]\ & (\inst1|I4|ireg_c[6]\ # !\inst1|I4|add_205~5COUT\) # !\inst1|I4|iinc_c[6]\ & \inst1|I4|ireg_c[6]\ & !\inst1|I4|add_205~5COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "698E",
	cin_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|iinc_c[6]\,
	datab => \inst1|I4|ireg_c[6]\,
	cin => \inst1|I4|add_205~5COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205~6\,
	cout0 => \inst1|I4|add_205~6COUT0\,
	cout1 => \inst1|I4|add_205~6COUT1\);

\inst1|I4|add_205~7_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205~7\ = \inst1|I4|ireg_c[7]\ $ \inst1|I4|iinc_c[7]\ $ (!\inst1|I4|add_205~5COUT\ & \inst1|I4|add_205~6COUT0\) # (\inst1|I4|add_205~5COUT\ & \inst1|I4|add_205~6COUT1\)
-- \inst1|I4|add_205~7COUT0\ = CARRY(\inst1|I4|ireg_c[7]\ & !\inst1|I4|iinc_c[7]\ & !\inst1|I4|add_205~6COUT0\ # !\inst1|I4|ireg_c[7]\ & (!\inst1|I4|add_205~6COUT0\ # !\inst1|I4|iinc_c[7]\))
-- \inst1|I4|add_205~7COUT1\ = CARRY(\inst1|I4|ireg_c[7]\ & !\inst1|I4|iinc_c[7]\ & !\inst1|I4|add_205~6COUT1\ # !\inst1|I4|ireg_c[7]\ & (!\inst1|I4|add_205~6COUT1\ # !\inst1|I4|iinc_c[7]\))

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
	dataa => \inst1|I4|ireg_c[7]\,
	datab => \inst1|I4|iinc_c[7]\,
	cin => \inst1|I4|add_205~5COUT\,
	cin0 => \inst1|I4|add_205~6COUT0\,
	cin1 => \inst1|I4|add_205~6COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205~7\,
	cout0 => \inst1|I4|add_205~7COUT0\,
	cout1 => \inst1|I4|add_205~7COUT1\);

\inst1|I4|add_205~8_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205~8\ = \inst1|I4|iinc_c[8]\ $ \inst1|I4|ireg_c[8]\ $ !(!\inst1|I4|add_205~5COUT\ & \inst1|I4|add_205~7COUT0\) # (\inst1|I4|add_205~5COUT\ & \inst1|I4|add_205~7COUT1\)
-- \inst1|I4|add_205~8COUT0\ = CARRY(\inst1|I4|iinc_c[8]\ & (\inst1|I4|ireg_c[8]\ # !\inst1|I4|add_205~7COUT0\) # !\inst1|I4|iinc_c[8]\ & \inst1|I4|ireg_c[8]\ & !\inst1|I4|add_205~7COUT0\)
-- \inst1|I4|add_205~8COUT1\ = CARRY(\inst1|I4|iinc_c[8]\ & (\inst1|I4|ireg_c[8]\ # !\inst1|I4|add_205~7COUT1\) # !\inst1|I4|iinc_c[8]\ & \inst1|I4|ireg_c[8]\ & !\inst1|I4|add_205~7COUT1\)

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
	dataa => \inst1|I4|iinc_c[8]\,
	datab => \inst1|I4|ireg_c[8]\,
	cin => \inst1|I4|add_205~5COUT\,
	cin0 => \inst1|I4|add_205~7COUT0\,
	cin1 => \inst1|I4|add_205~7COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205~8\,
	cout0 => \inst1|I4|add_205~8COUT0\,
	cout1 => \inst1|I4|add_205~8COUT1\);

\inst1|I4|add_205~9_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205~9\ = \inst1|I4|iinc_c[9]\ $ \inst1|I4|ireg_c[9]\ $ (!\inst1|I4|add_205~5COUT\ & \inst1|I4|add_205~8COUT0\) # (\inst1|I4|add_205~5COUT\ & \inst1|I4|add_205~8COUT1\)
-- \inst1|I4|add_205~9COUT0\ = CARRY(\inst1|I4|iinc_c[9]\ & !\inst1|I4|ireg_c[9]\ & !\inst1|I4|add_205~8COUT0\ # !\inst1|I4|iinc_c[9]\ & (!\inst1|I4|add_205~8COUT0\ # !\inst1|I4|ireg_c[9]\))
-- \inst1|I4|add_205~9COUT1\ = CARRY(\inst1|I4|iinc_c[9]\ & !\inst1|I4|ireg_c[9]\ & !\inst1|I4|add_205~8COUT1\ # !\inst1|I4|iinc_c[9]\ & (!\inst1|I4|add_205~8COUT1\ # !\inst1|I4|ireg_c[9]\))

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
	dataa => \inst1|I4|iinc_c[9]\,
	datab => \inst1|I4|ireg_c[9]\,
	cin => \inst1|I4|add_205~5COUT\,
	cin0 => \inst1|I4|add_205~8COUT0\,
	cin1 => \inst1|I4|add_205~8COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205~9\,
	cout0 => \inst1|I4|add_205~9COUT0\,
	cout1 => \inst1|I4|add_205~9COUT1\);

\inst1|I4|add_205_rtl_595~72_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~72\ = \inst1|I4|ireg_c[9]\ & (\inst1|I4|add_205~9\ # !\inst1|I4|i~2616\) # !\inst1|I4|ireg_c[9]\ & \inst1|I4|add_205~9\ & \inst1|I4|i~2616\

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
	datab => \inst1|I4|ireg_c[9]\,
	datac => \inst1|I4|add_205~9\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~72\);

\inst1|I4|ireg_i[9]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~77\ = \inst1|I4|ireg_we_c\ & \inst1|I3|acc_c[0][9]\ # !\inst1|I4|ireg_we_c\ & \inst1|I4|i~38\ & \inst1|I4|add_205_rtl_595~72\
-- \inst1|I4|ireg_i[9]\ = DFFEA(\inst1|I4|add_205_rtl_595~77\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|i~38\,
	datab => \inst1|I4|ireg_we_c\,
	datac => \inst1|I3|acc_c[0][9]\,
	datad => \inst1|I4|add_205_rtl_595~72\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~77\,
	regout => \inst1|I4|ireg_i[9]\);

\inst1|I4|ireg_c[9]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ireg_c[9]\ = DFFEA(\inst1|I4|ireg_i[9]\ & (\inst1|I2|int_stop_x~11\ # \inst1|I4|add_205_rtl_595~77\) # !\inst1|I4|ireg_i[9]\ & !\inst1|I2|int_stop_x~11\ & \inst1|I4|add_205_rtl_595~77\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFA0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|ireg_i[9]\,
	datac => \inst1|I2|int_stop_x~11\,
	datad => \inst1|I4|add_205_rtl_595~77\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|ireg_c[9]\);

\inst1|I3|data_x[9]~3536_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[9]~3536\ = \inst1|I4|iinc_c[9]\ & (\inst1|I3|data_x[9]~3459\ # \inst1|I4|ireg_c[9]\ & !\inst1|I4|reduce_nor_207\) # !\inst1|I4|iinc_c[9]\ & \inst1|I4|ireg_c[9]\ & !\inst1|I4|reduce_nor_207\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AE0C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|iinc_c[9]\,
	datab => \inst1|I4|ireg_c[9]\,
	datac => \inst1|I4|reduce_nor_207\,
	datad => \inst1|I3|data_x[9]~3459\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[9]~3536\);

\inst1|I3|data_x[9]~2155_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[9]~2155\ = \inst1|I3|data_x[9]~3458\ & (\inst1|I3|data_x[9]~3536\ # \inst1|I4|data_exp_c[9]\ & \inst1|I3|data_x[9]~3457\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EC00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|data_exp_c[9]\,
	datab => \inst1|I3|data_x[9]~3536\,
	datac => \inst1|I3|data_x[9]~3457\,
	datad => \inst1|I3|data_x[9]~3458\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[9]~2155\);

\DATA_IN_EXT[9]~I\ : cyclone_io 
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
	padio => ww_DATA_IN_EXT(9),
	combout => \DATA_IN_EXT[9]~combout\);

\inst1|I3|data_x[9]~243_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[9]~243\ = \inst1|I3|data_x[6]~3456\ & (\inst3|mux_c[0]\ & \DATA_IN_EXT[9]~combout\ # !\inst3|mux_c[0]\ & \inst|altsyncram_component|q_a[9]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "B800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \DATA_IN_EXT[9]~combout\,
	datab => \inst3|mux_c[0]\,
	datac => \inst|altsyncram_component|q_a[9]\,
	datad => \inst1|I3|data_x[6]~3456\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[9]~243\);

\inst1|I3|data_x[9]~3566_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[9]~3566\ = \inst1|I3|data_x[9]~2155\ # \inst1|I3|data_x[9]~243\ # !\inst1|I3|reduce_nor_95\ & \inst1|I2|data_is_c[9]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|reduce_nor_95\,
	datab => \inst1|I2|data_is_c[9]\,
	datac => \inst1|I3|data_x[9]~2155\,
	datad => \inst1|I3|data_x[9]~243\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[9]~3566\);

\rtl~13994_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13994\ = \rtl~13588\ & (\inst1|I3|data_x[9]~3566\ $ (\inst1|I2|TD_c[0]\ & \inst1|I3|acc_c[0][9]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "7080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I3|acc_c[0][9]\,
	datac => \rtl~13588\,
	datad => \inst1|I3|data_x[9]~3566\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13994\);

\rtl~2710_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2710\ = \inst1|I2|TD_c[2]\ & (\inst1|I3|acc_c[0][9]\ $ \inst1|I2|TD_c[1]\) # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][8]\

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
	dataa => \inst1|I2|TD_c[2]\,
	datab => \inst1|I3|acc_c[0][9]\,
	datac => \inst1|I2|TD_c[1]\,
	datad => \inst1|I3|acc_c[0][8]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2710\);

\rtl~2516_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2516\ = \inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][10]\ & !\inst1|I2|TD_c[2]\ # !\inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][10]\ # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][9]\)

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
	dataa => \inst1|I3|acc_c[0][10]\,
	datab => \inst1|I3|acc_c[0][9]\,
	datac => \inst1|I2|TD_c[1]\,
	datad => \inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2516\);

\rtl~2715_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2715\ = \rtl~2710\ & (\inst1|I2|TD_c[0]\ # \rtl~2516\) # !\rtl~2710\ & !\inst1|I2|TD_c[0]\ & \rtl~2516\

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
	datab => \rtl~2710\,
	datac => \inst1|I2|TD_c[0]\,
	datad => \rtl~2516\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2715\);

\inst1|I3|add_185~5_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_185~5\ = \inst1|I3|acc_c[0][5]\ $ \inst1|I3|data_x[5]~3650\ $ (!\inst1|I3|add_185~2COUT\ & \inst1|I3|add_185~4COUT0\) # (\inst1|I3|add_185~2COUT\ & \inst1|I3|add_185~4COUT1\)
-- \inst1|I3|add_185~5COUT0\ = CARRY(\inst1|I3|acc_c[0][5]\ & !\inst1|I3|data_x[5]~3650\ & !\inst1|I3|add_185~4COUT0\ # !\inst1|I3|acc_c[0][5]\ & (!\inst1|I3|add_185~4COUT0\ # !\inst1|I3|data_x[5]~3650\))
-- \inst1|I3|add_185~5COUT1\ = CARRY(\inst1|I3|acc_c[0][5]\ & !\inst1|I3|data_x[5]~3650\ & !\inst1|I3|add_185~4COUT1\ # !\inst1|I3|acc_c[0][5]\ & (!\inst1|I3|add_185~4COUT1\ # !\inst1|I3|data_x[5]~3650\))

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
	dataa => \inst1|I3|acc_c[0][5]\,
	datab => \inst1|I3|data_x[5]~3650\,
	cin => \inst1|I3|add_185~2COUT\,
	cin0 => \inst1|I3|add_185~4COUT0\,
	cin1 => \inst1|I3|add_185~4COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_185~5\,
	cout0 => \inst1|I3|add_185~5COUT0\,
	cout1 => \inst1|I3|add_185~5COUT1\);

\inst1|I3|add_185~6_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_185~6\ = \inst1|I3|acc_c[0][6]\ $ \inst1|I3|data_x[6]~3608\ $ !(!\inst1|I3|add_185~2COUT\ & \inst1|I3|add_185~5COUT0\) # (\inst1|I3|add_185~2COUT\ & \inst1|I3|add_185~5COUT1\)
-- \inst1|I3|add_185~6COUT0\ = CARRY(\inst1|I3|acc_c[0][6]\ & (\inst1|I3|data_x[6]~3608\ # !\inst1|I3|add_185~5COUT0\) # !\inst1|I3|acc_c[0][6]\ & \inst1|I3|data_x[6]~3608\ & !\inst1|I3|add_185~5COUT0\)
-- \inst1|I3|add_185~6COUT1\ = CARRY(\inst1|I3|acc_c[0][6]\ & (\inst1|I3|data_x[6]~3608\ # !\inst1|I3|add_185~5COUT1\) # !\inst1|I3|acc_c[0][6]\ & \inst1|I3|data_x[6]~3608\ & !\inst1|I3|add_185~5COUT1\)

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
	dataa => \inst1|I3|acc_c[0][6]\,
	datab => \inst1|I3|data_x[6]~3608\,
	cin => \inst1|I3|add_185~2COUT\,
	cin0 => \inst1|I3|add_185~5COUT0\,
	cin1 => \inst1|I3|add_185~5COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_185~6\,
	cout0 => \inst1|I3|add_185~6COUT0\,
	cout1 => \inst1|I3|add_185~6COUT1\);

\inst1|I3|add_185~7_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_185~7\ = \inst1|I3|acc_c[0][7]\ $ \inst1|I3|data_x[7]~3872\ $ (!\inst1|I3|add_185~2COUT\ & \inst1|I3|add_185~6COUT0\) # (\inst1|I3|add_185~2COUT\ & \inst1|I3|add_185~6COUT1\)
-- \inst1|I3|add_185~7COUT\ = CARRY(\inst1|I3|acc_c[0][7]\ & !\inst1|I3|data_x[7]~3872\ & !\inst1|I3|add_185~6COUT1\ # !\inst1|I3|acc_c[0][7]\ & (!\inst1|I3|add_185~6COUT1\ # !\inst1|I3|data_x[7]~3872\))

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
	dataa => \inst1|I3|acc_c[0][7]\,
	datab => \inst1|I3|data_x[7]~3872\,
	cin => \inst1|I3|add_185~2COUT\,
	cin0 => \inst1|I3|add_185~6COUT0\,
	cin1 => \inst1|I3|add_185~6COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_185~7\,
	cout => \inst1|I3|add_185~7COUT\);

\inst1|I3|add_185~8_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_185~8\ = \inst1|I3|acc_c[0][8]\ $ \inst1|I3|data_x[8]~3830\ $ !\inst1|I3|add_185~7COUT\
-- \inst1|I3|add_185~8COUT0\ = CARRY(\inst1|I3|acc_c[0][8]\ & (\inst1|I3|data_x[8]~3830\ # !\inst1|I3|add_185~7COUT\) # !\inst1|I3|acc_c[0][8]\ & \inst1|I3|data_x[8]~3830\ & !\inst1|I3|add_185~7COUT\)
-- \inst1|I3|add_185~8COUT1\ = CARRY(\inst1|I3|acc_c[0][8]\ & (\inst1|I3|data_x[8]~3830\ # !\inst1|I3|add_185~7COUT\) # !\inst1|I3|acc_c[0][8]\ & \inst1|I3|data_x[8]~3830\ & !\inst1|I3|add_185~7COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "698E",
	cin_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][8]\,
	datab => \inst1|I3|data_x[8]~3830\,
	cin => \inst1|I3|add_185~7COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_185~8\,
	cout0 => \inst1|I3|add_185~8COUT0\,
	cout1 => \inst1|I3|add_185~8COUT1\);

\inst1|I3|add_185~9_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_185~9\ = \inst1|I3|acc_c[0][9]\ $ \inst1|I3|data_x[9]~3566\ $ (!\inst1|I3|add_185~7COUT\ & \inst1|I3|add_185~8COUT0\) # (\inst1|I3|add_185~7COUT\ & \inst1|I3|add_185~8COUT1\)
-- \inst1|I3|add_185~9COUT0\ = CARRY(\inst1|I3|acc_c[0][9]\ & !\inst1|I3|data_x[9]~3566\ & !\inst1|I3|add_185~8COUT0\ # !\inst1|I3|acc_c[0][9]\ & (!\inst1|I3|add_185~8COUT0\ # !\inst1|I3|data_x[9]~3566\))
-- \inst1|I3|add_185~9COUT1\ = CARRY(\inst1|I3|acc_c[0][9]\ & !\inst1|I3|data_x[9]~3566\ & !\inst1|I3|add_185~8COUT1\ # !\inst1|I3|acc_c[0][9]\ & (!\inst1|I3|add_185~8COUT1\ # !\inst1|I3|data_x[9]~3566\))

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
	dataa => \inst1|I3|acc_c[0][9]\,
	datab => \inst1|I3|data_x[9]~3566\,
	cin => \inst1|I3|add_185~7COUT\,
	cin0 => \inst1|I3|add_185~8COUT0\,
	cin1 => \inst1|I3|add_185~8COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_185~9\,
	cout0 => \inst1|I3|add_185~9COUT0\,
	cout1 => \inst1|I3|add_185~9COUT1\);

\inst1|I3|add_225~9_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_225~9\ = \inst1|I3|acc_c[0][8]\ $ \inst1|I3|data_x[8]~3830\ $ \inst1|I3|add_225~8COUT\
-- \inst1|I3|add_225~9COUT0\ = CARRY(\inst1|I3|acc_c[0][8]\ & (!\inst1|I3|add_225~8COUT\ # !\inst1|I3|data_x[8]~3830\) # !\inst1|I3|acc_c[0][8]\ & !\inst1|I3|data_x[8]~3830\ & !\inst1|I3|add_225~8COUT\)
-- \inst1|I3|add_225~9COUT1\ = CARRY(\inst1|I3|acc_c[0][8]\ & (!\inst1|I3|add_225~8COUT\ # !\inst1|I3|data_x[8]~3830\) # !\inst1|I3|acc_c[0][8]\ & !\inst1|I3|data_x[8]~3830\ & !\inst1|I3|add_225~8COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "962B",
	cin_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][8]\,
	datab => \inst1|I3|data_x[8]~3830\,
	cin => \inst1|I3|add_225~8COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_225~9\,
	cout0 => \inst1|I3|add_225~9COUT0\,
	cout1 => \inst1|I3|add_225~9COUT1\);

\inst1|I3|add_225~10_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_225~10\ = \inst1|I3|acc_c[0][9]\ $ \inst1|I3|data_x[9]~3566\ $ !(!\inst1|I3|add_225~8COUT\ & \inst1|I3|add_225~9COUT0\) # (\inst1|I3|add_225~8COUT\ & \inst1|I3|add_225~9COUT1\)
-- \inst1|I3|add_225~10COUT0\ = CARRY(\inst1|I3|acc_c[0][9]\ & \inst1|I3|data_x[9]~3566\ & !\inst1|I3|add_225~9COUT0\ # !\inst1|I3|acc_c[0][9]\ & (\inst1|I3|data_x[9]~3566\ # !\inst1|I3|add_225~9COUT0\))
-- \inst1|I3|add_225~10COUT1\ = CARRY(\inst1|I3|acc_c[0][9]\ & \inst1|I3|data_x[9]~3566\ & !\inst1|I3|add_225~9COUT1\ # !\inst1|I3|acc_c[0][9]\ & (\inst1|I3|data_x[9]~3566\ # !\inst1|I3|add_225~9COUT1\))

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
	dataa => \inst1|I3|acc_c[0][9]\,
	datab => \inst1|I3|data_x[9]~3566\,
	cin => \inst1|I3|add_225~8COUT\,
	cin0 => \inst1|I3|add_225~9COUT0\,
	cin1 => \inst1|I3|add_225~9COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_225~10\,
	cout0 => \inst1|I3|add_225~10COUT0\,
	cout1 => \inst1|I3|add_225~10COUT1\);

\inst1|I3|Mux_257_rtl_68_rtl_349~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_257_rtl_68_rtl_349~0\ = \inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[0]\ # \inst1|I3|add_225~10\) # !\inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[0]\ & \inst1|I3|add_185~9\

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
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I3|add_185~9\,
	datad => \inst1|I3|add_225~10\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_257_rtl_68_rtl_349~0\);

\inst1|I3|Mux_257_rtl_68_rtl_349~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_257_rtl_68_rtl_349~1\ = \inst1|I3|acc_c[0][9]\ & (\inst1|I3|Mux_257_rtl_68_rtl_349~0\ # \inst1|I3|data_x[9]~3566\ & \inst1|I2|TD_c[0]\) # !\inst1|I3|acc_c[0][9]\ & \inst1|I3|Mux_257_rtl_68_rtl_349~0\ & (\inst1|I3|data_x[9]~3566\ # !\inst1|I2|TD_c[0]\)

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
	dataa => \inst1|I3|acc_c[0][9]\,
	datab => \inst1|I3|data_x[9]~3566\,
	datac => \inst1|I2|TD_c[0]\,
	datad => \inst1|I3|Mux_257_rtl_68_rtl_349~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_257_rtl_68_rtl_349~1\);

\rtl~13972_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13972\ = \inst1|I3|acc_c[0][9]\ & (\rtl~13900\ # \rtl~13596\ & \inst1|I3|Mux_257_rtl_68_rtl_349~1\) # !\inst1|I3|acc_c[0][9]\ & \rtl~13596\ & \inst1|I3|Mux_257_rtl_68_rtl_349~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ECA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][9]\,
	datab => \rtl~13596\,
	datac => \rtl~13900\,
	datad => \inst1|I3|Mux_257_rtl_68_rtl_349~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13972\);

\rtl~13977_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13977\ = \rtl~13972\ # \rtl~2715\ & (\inst1|I2|TC_c[1]\ $ !\inst1|I2|TC_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF90",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TC_c[1]\,
	datab => \inst1|I2|TC_c[0]\,
	datac => \rtl~2715\,
	datad => \rtl~13972\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13977\);

\inst1|I3|acc_c[0][9]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][9]~126\ = \inst1|I3|acc[0][9]~8204\ # \inst1|I3|acc[0][13]~8146\ & (\rtl~13994\ # \rtl~13977\)
-- \inst1|I3|acc_c[0][9]\ = DFFEA(\inst1|I3|acc[0][9]~126\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][13]~8146\,
	datab => \inst1|I3|acc[0][9]~8204\,
	datac => \rtl~13994\,
	datad => \rtl~13977\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][9]~126\,
	regout => \inst1|I3|acc_c[0][9]\);

\inst1|I3|acc_i[0][9]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][9]~8204\ = \inst1|I3|acc[0][13]~111\ & (\inst1|I3|acc_c[0][9]\ # L1_acc_i[0][9] & \inst1|I3|acc[0][13]~8147\) # !\inst1|I3|acc[0][13]~111\ & L1_acc_i[0][9] & \inst1|I3|acc[0][13]~8147\

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][13]~111\,
	datab => \inst1|I3|acc_c[0][9]\,
	datac => \inst1|I3|acc[0][9]~126\,
	datad => \inst1|I3|acc[0][13]~8147\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][9]~8204\);

\rtl~2790_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2790\ = \inst1|I2|TD_c[2]\ & (\inst1|I3|acc_c[0][10]\ $ \inst1|I2|TD_c[1]\) # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][9]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4EE4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[2]\,
	datab => \inst1|I3|acc_c[0][9]\,
	datac => \inst1|I3|acc_c[0][10]\,
	datad => \inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2790\);

\rtl~2604_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2604\ = \inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][11]\ & !\inst1|I2|TD_c[2]\ # !\inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][11]\ # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][10]\)

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
	dataa => \inst1|I2|TD_c[1]\,
	datab => \inst1|I3|acc_c[0][11]\,
	datac => \inst1|I2|TD_c[2]\,
	datad => \inst1|I3|acc_c[0][10]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2604\);

\rtl~2795_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2795\ = \rtl~2790\ & (\inst1|I2|TD_c[0]\ # \rtl~2604\) # !\rtl~2790\ & !\inst1|I2|TD_c[0]\ & \rtl~2604\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "B8B8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~2790\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \rtl~2604\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2795\);

\inst1|I3|add_185~10_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_185~10\ = \inst1|I3|acc_c[0][10]\ $ \inst1|I3|data_x[10]~3788\ $ !(!\inst1|I3|add_185~7COUT\ & \inst1|I3|add_185~9COUT0\) # (\inst1|I3|add_185~7COUT\ & \inst1|I3|add_185~9COUT1\)
-- \inst1|I3|add_185~10COUT0\ = CARRY(\inst1|I3|acc_c[0][10]\ & (\inst1|I3|data_x[10]~3788\ # !\inst1|I3|add_185~9COUT0\) # !\inst1|I3|acc_c[0][10]\ & \inst1|I3|data_x[10]~3788\ & !\inst1|I3|add_185~9COUT0\)
-- \inst1|I3|add_185~10COUT1\ = CARRY(\inst1|I3|acc_c[0][10]\ & (\inst1|I3|data_x[10]~3788\ # !\inst1|I3|add_185~9COUT1\) # !\inst1|I3|acc_c[0][10]\ & \inst1|I3|data_x[10]~3788\ & !\inst1|I3|add_185~9COUT1\)

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
	dataa => \inst1|I3|acc_c[0][10]\,
	datab => \inst1|I3|data_x[10]~3788\,
	cin => \inst1|I3|add_185~7COUT\,
	cin0 => \inst1|I3|add_185~9COUT0\,
	cin1 => \inst1|I3|add_185~9COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_185~10\,
	cout0 => \inst1|I3|add_185~10COUT0\,
	cout1 => \inst1|I3|add_185~10COUT1\);

\inst1|I3|add_225~11_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_225~11\ = \inst1|I3|acc_c[0][10]\ $ \inst1|I3|data_x[10]~3788\ $ (!\inst1|I3|add_225~8COUT\ & \inst1|I3|add_225~10COUT0\) # (\inst1|I3|add_225~8COUT\ & \inst1|I3|add_225~10COUT1\)
-- \inst1|I3|add_225~11COUT0\ = CARRY(\inst1|I3|acc_c[0][10]\ & (!\inst1|I3|add_225~10COUT0\ # !\inst1|I3|data_x[10]~3788\) # !\inst1|I3|acc_c[0][10]\ & !\inst1|I3|data_x[10]~3788\ & !\inst1|I3|add_225~10COUT0\)
-- \inst1|I3|add_225~11COUT1\ = CARRY(\inst1|I3|acc_c[0][10]\ & (!\inst1|I3|add_225~10COUT1\ # !\inst1|I3|data_x[10]~3788\) # !\inst1|I3|acc_c[0][10]\ & !\inst1|I3|data_x[10]~3788\ & !\inst1|I3|add_225~10COUT1\)

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
	dataa => \inst1|I3|acc_c[0][10]\,
	datab => \inst1|I3|data_x[10]~3788\,
	cin => \inst1|I3|add_225~8COUT\,
	cin0 => \inst1|I3|add_225~10COUT0\,
	cin1 => \inst1|I3|add_225~10COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_225~11\,
	cout0 => \inst1|I3|add_225~11COUT0\,
	cout1 => \inst1|I3|add_225~11COUT1\);

\inst1|I3|Mux_256_rtl_116_rtl_397~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_256_rtl_116_rtl_397~0\ = \inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[0]\ # \inst1|I3|add_225~11\) # !\inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[0]\ & \inst1|I3|add_185~10\

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
	dataa => \inst1|I2|TD_c[1]\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \inst1|I3|add_185~10\,
	datad => \inst1|I3|add_225~11\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_256_rtl_116_rtl_397~0\);

\inst1|I3|Mux_256_rtl_116_rtl_397~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_256_rtl_116_rtl_397~1\ = \inst1|I3|acc_c[0][10]\ & (\inst1|I3|Mux_256_rtl_116_rtl_397~0\ # \inst1|I2|TD_c[0]\ & \inst1|I3|data_x[10]~3788\) # !\inst1|I3|acc_c[0][10]\ & \inst1|I3|Mux_256_rtl_116_rtl_397~0\ & (\inst1|I3|data_x[10]~3788\ # !\inst1|I2|TD_c[0]\)

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
	dataa => \inst1|I3|acc_c[0][10]\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \inst1|I3|data_x[10]~3788\,
	datad => \inst1|I3|Mux_256_rtl_116_rtl_397~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_256_rtl_116_rtl_397~1\);

\rtl~14321_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14321\ = \rtl~13900\ & (\inst1|I3|acc_c[0][10]\ # \rtl~13596\ & \inst1|I3|Mux_256_rtl_116_rtl_397~1\) # !\rtl~13900\ & \rtl~13596\ & \inst1|I3|Mux_256_rtl_116_rtl_397~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~13900\,
	datab => \inst1|I3|acc_c[0][10]\,
	datac => \rtl~13596\,
	datad => \inst1|I3|Mux_256_rtl_116_rtl_397~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14321\);

\rtl~14326_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14326\ = \rtl~14321\ # \rtl~2795\ & (\inst1|I2|TC_c[0]\ $ !\inst1|I2|TC_c[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF84",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TC_c[0]\,
	datab => \rtl~2795\,
	datac => \inst1|I2|TC_c[1]\,
	datad => \rtl~14321\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14326\);

\inst1|I3|acc_c[0][10]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][10]~206\ = \inst1|I3|acc[0][10]~8284\ # \inst1|I3|acc[0][13]~8146\ & (\rtl~14343\ # \rtl~14326\)
-- \inst1|I3|acc_c[0][10]\ = DFFEA(\inst1|I3|acc[0][10]~206\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][10]~8284\,
	datab => \inst1|I3|acc[0][13]~8146\,
	datac => \rtl~14343\,
	datad => \rtl~14326\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][10]~206\,
	regout => \inst1|I3|acc_c[0][10]\);

\inst1|I3|acc_i[0][10]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][10]~8284\ = \inst1|I3|acc[0][13]~111\ & (\inst1|I3|acc_c[0][10]\ # L1_acc_i[0][10] & \inst1|I3|acc[0][13]~8147\) # !\inst1|I3|acc[0][13]~111\ & L1_acc_i[0][10] & \inst1|I3|acc[0][13]~8147\

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][13]~111\,
	datab => \inst1|I3|acc_c[0][10]\,
	datac => \inst1|I3|acc[0][10]~206\,
	datad => \inst1|I3|acc[0][13]~8147\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][10]~8284\);

\inst1|I4|add_205~10_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205~10\ = \inst1|I4|ireg_c[10]\ $ \inst1|I4|iinc_c[10]\ $ !(!\inst1|I4|add_205~5COUT\ & \inst1|I4|add_205~9COUT0\) # (\inst1|I4|add_205~5COUT\ & \inst1|I4|add_205~9COUT1\)
-- \inst1|I4|add_205~10COUT\ = CARRY(\inst1|I4|ireg_c[10]\ & (\inst1|I4|iinc_c[10]\ # !\inst1|I4|add_205~9COUT1\) # !\inst1|I4|ireg_c[10]\ & \inst1|I4|iinc_c[10]\ & !\inst1|I4|add_205~9COUT1\)

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
	dataa => \inst1|I4|ireg_c[10]\,
	datab => \inst1|I4|iinc_c[10]\,
	cin => \inst1|I4|add_205~5COUT\,
	cin0 => \inst1|I4|add_205~9COUT0\,
	cin1 => \inst1|I4|add_205~9COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205~10\,
	cout => \inst1|I4|add_205~10COUT\);

\inst1|I4|add_205_rtl_595~182_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~182\ = \inst1|I4|ireg_c[10]\ & (\inst1|I4|add_205~10\ # !\inst1|I4|i~2616\) # !\inst1|I4|ireg_c[10]\ & \inst1|I4|add_205~10\ & \inst1|I4|i~2616\

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
	dataa => \inst1|I4|ireg_c[10]\,
	datac => \inst1|I4|add_205~10\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~182\);

\inst1|I4|ireg_i[10]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~187\ = \inst1|I4|ireg_we_c\ & \inst1|I3|acc_c[0][10]\ # !\inst1|I4|ireg_we_c\ & \inst1|I4|i~38\ & \inst1|I4|add_205_rtl_595~182\
-- \inst1|I4|ireg_i[10]\ = DFFEA(\inst1|I4|add_205_rtl_595~187\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I4|ireg_we_c\,
	datab => \inst1|I4|i~38\,
	datac => \inst1|I3|acc_c[0][10]\,
	datad => \inst1|I4|add_205_rtl_595~182\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~187\,
	regout => \inst1|I4|ireg_i[10]\);

\inst1|I4|ireg_c[10]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ireg_c[10]\ = DFFEA(\inst1|I4|ireg_i[10]\ & (\inst1|I2|int_stop_x~11\ # \inst1|I4|add_205_rtl_595~187\) # !\inst1|I4|ireg_i[10]\ & !\inst1|I2|int_stop_x~11\ & \inst1|I4|add_205_rtl_595~187\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BB88",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|ireg_i[10]\,
	datab => \inst1|I2|int_stop_x~11\,
	datad => \inst1|I4|add_205_rtl_595~187\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|ireg_c[10]\);

\inst1|I4|add_205~11_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205~11\ = \inst1|I4|ireg_c[11]\ $ \inst1|I4|iinc_c[11]\ $ \inst1|I4|add_205~10COUT\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	lut_mask => "9696",
	cin_used => "true",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ireg_c[11]\,
	datab => \inst1|I4|iinc_c[11]\,
	cin => \inst1|I4|add_205~10COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205~11\);

\inst1|I4|add_205_rtl_595~172_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~172\ = \inst1|I4|add_205~11\ & (\inst1|I4|ireg_c[11]\ # \inst1|I4|i~2616\) # !\inst1|I4|add_205~11\ & \inst1|I4|ireg_c[11]\ & !\inst1|I4|i~2616\

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
	datab => \inst1|I4|add_205~11\,
	datac => \inst1|I4|ireg_c[11]\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~172\);

\inst1|I4|ireg_i[11]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~177\ = \inst1|I4|ireg_we_c\ & \inst1|I3|acc_c[0][11]\ # !\inst1|I4|ireg_we_c\ & \inst1|I4|i~38\ & \inst1|I4|add_205_rtl_595~172\
-- \inst1|I4|ireg_i[11]\ = DFFEA(\inst1|I4|add_205_rtl_595~177\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][11]\,
	datab => \inst1|I4|ireg_we_c\,
	datac => \inst1|I4|i~38\,
	datad => \inst1|I4|add_205_rtl_595~172\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~177\,
	regout => \inst1|I4|ireg_i[11]\);

\inst1|I4|ireg_c[11]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ireg_c[11]\ = DFFEA(\inst1|I4|ireg_i[11]\ & (\inst1|I2|int_stop_x~11\ # \inst1|I4|add_205_rtl_595~177\) # !\inst1|I4|ireg_i[11]\ & !\inst1|I2|int_stop_x~11\ & \inst1|I4|add_205_rtl_595~177\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BB88",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|ireg_i[11]\,
	datab => \inst1|I2|int_stop_x~11\,
	datad => \inst1|I4|add_205_rtl_595~177\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|ireg_c[11]\);

\inst1|I3|data_x[11]~3718_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[11]~3718\ = \inst1|I4|iinc_c[11]\ & (\inst1|I3|data_x[9]~3459\ # \inst1|I4|ireg_c[11]\ & !\inst1|I4|reduce_nor_207\) # !\inst1|I4|iinc_c[11]\ & \inst1|I4|ireg_c[11]\ & !\inst1|I4|reduce_nor_207\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AE0C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|iinc_c[11]\,
	datab => \inst1|I4|ireg_c[11]\,
	datac => \inst1|I4|reduce_nor_207\,
	datad => \inst1|I3|data_x[9]~3459\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[11]~3718\);

\inst1|I3|data_x[11]~2669_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[11]~2669\ = \inst1|I3|data_x[9]~3458\ & (\inst1|I3|data_x[11]~3718\ # \inst1|I4|data_exp_c[11]\ & \inst1|I3|data_x[9]~3457\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EC00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|data_exp_c[11]\,
	datab => \inst1|I3|data_x[11]~3718\,
	datac => \inst1|I3|data_x[9]~3457\,
	datad => \inst1|I3|data_x[9]~3458\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[11]~2669\);

\inst1|I3|data_x[11]~3746_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[11]~3746\ = \inst1|I3|data_x[11]~741\ # \inst1|I3|data_x[11]~2669\ # \inst1|I2|data_is_c[11]\ & !\inst1|I3|reduce_nor_95\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|data_is_c[11]\,
	datab => \inst1|I3|reduce_nor_95\,
	datac => \inst1|I3|data_x[11]~741\,
	datad => \inst1|I3|data_x[11]~2669\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[11]~3746\);

\inst1|I3|add_225~12_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_225~12\ = \inst1|I3|acc_c[0][11]\ $ \inst1|I3|data_x[11]~3746\ $ !(!\inst1|I3|add_225~8COUT\ & \inst1|I3|add_225~11COUT0\) # (\inst1|I3|add_225~8COUT\ & \inst1|I3|add_225~11COUT1\)
-- \inst1|I3|add_225~12COUT0\ = CARRY(\inst1|I3|acc_c[0][11]\ & \inst1|I3|data_x[11]~3746\ & !\inst1|I3|add_225~11COUT0\ # !\inst1|I3|acc_c[0][11]\ & (\inst1|I3|data_x[11]~3746\ # !\inst1|I3|add_225~11COUT0\))
-- \inst1|I3|add_225~12COUT1\ = CARRY(\inst1|I3|acc_c[0][11]\ & \inst1|I3|data_x[11]~3746\ & !\inst1|I3|add_225~11COUT1\ # !\inst1|I3|acc_c[0][11]\ & (\inst1|I3|data_x[11]~3746\ # !\inst1|I3|add_225~11COUT1\))

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
	dataa => \inst1|I3|acc_c[0][11]\,
	datab => \inst1|I3|data_x[11]~3746\,
	cin => \inst1|I3|add_225~8COUT\,
	cin0 => \inst1|I3|add_225~11COUT0\,
	cin1 => \inst1|I3|add_225~11COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_225~12\,
	cout0 => \inst1|I3|add_225~12COUT0\,
	cout1 => \inst1|I3|add_225~12COUT1\);

\inst1|I3|add_225~13_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_225~13\ = \inst1|I3|acc_c[0][12]\ $ \inst1|I3|data_x[12]~107\ $ (!\inst1|I3|add_225~8COUT\ & \inst1|I3|add_225~12COUT0\) # (\inst1|I3|add_225~8COUT\ & \inst1|I3|add_225~12COUT1\)
-- \inst1|I3|add_225~13COUT\ = CARRY(\inst1|I3|acc_c[0][12]\ & (!\inst1|I3|add_225~12COUT1\ # !\inst1|I3|data_x[12]~107\) # !\inst1|I3|acc_c[0][12]\ & !\inst1|I3|data_x[12]~107\ & !\inst1|I3|add_225~12COUT1\)

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
	dataa => \inst1|I3|acc_c[0][12]\,
	datab => \inst1|I3|data_x[12]~107\,
	cin => \inst1|I3|add_225~8COUT\,
	cin0 => \inst1|I3|add_225~12COUT0\,
	cin1 => \inst1|I3|add_225~12COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_225~13\,
	cout => \inst1|I3|add_225~13COUT\);

\inst1|I3|add_185~11_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_185~11\ = \inst1|I3|acc_c[0][11]\ $ \inst1|I3|data_x[11]~3746\ $ (!\inst1|I3|add_185~7COUT\ & \inst1|I3|add_185~10COUT0\) # (\inst1|I3|add_185~7COUT\ & \inst1|I3|add_185~10COUT1\)
-- \inst1|I3|add_185~11COUT0\ = CARRY(\inst1|I3|acc_c[0][11]\ & !\inst1|I3|data_x[11]~3746\ & !\inst1|I3|add_185~10COUT0\ # !\inst1|I3|acc_c[0][11]\ & (!\inst1|I3|add_185~10COUT0\ # !\inst1|I3|data_x[11]~3746\))
-- \inst1|I3|add_185~11COUT1\ = CARRY(\inst1|I3|acc_c[0][11]\ & !\inst1|I3|data_x[11]~3746\ & !\inst1|I3|add_185~10COUT1\ # !\inst1|I3|acc_c[0][11]\ & (!\inst1|I3|add_185~10COUT1\ # !\inst1|I3|data_x[11]~3746\))

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
	dataa => \inst1|I3|acc_c[0][11]\,
	datab => \inst1|I3|data_x[11]~3746\,
	cin => \inst1|I3|add_185~7COUT\,
	cin0 => \inst1|I3|add_185~10COUT0\,
	cin1 => \inst1|I3|add_185~10COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_185~11\,
	cout0 => \inst1|I3|add_185~11COUT0\,
	cout1 => \inst1|I3|add_185~11COUT1\);

\inst1|I3|add_185~12_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_185~12\ = \inst1|I3|acc_c[0][12]\ $ \inst1|I3|data_x[12]~107\ $ !(!\inst1|I3|add_185~7COUT\ & \inst1|I3|add_185~11COUT0\) # (\inst1|I3|add_185~7COUT\ & \inst1|I3|add_185~11COUT1\)
-- \inst1|I3|add_185~12COUT\ = CARRY(\inst1|I3|acc_c[0][12]\ & (\inst1|I3|data_x[12]~107\ # !\inst1|I3|add_185~11COUT1\) # !\inst1|I3|acc_c[0][12]\ & \inst1|I3|data_x[12]~107\ & !\inst1|I3|add_185~11COUT1\)

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
	dataa => \inst1|I3|acc_c[0][12]\,
	datab => \inst1|I3|data_x[12]~107\,
	cin => \inst1|I3|add_185~7COUT\,
	cin0 => \inst1|I3|add_185~11COUT0\,
	cin1 => \inst1|I3|add_185~11COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_185~12\,
	cout => \inst1|I3|add_185~12COUT\);

\inst1|I3|Mux_254_rtl_104_rtl_385~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_254_rtl_104_rtl_385~0\ = \inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[0]\ # \inst1|I3|add_225~13\) # !\inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[0]\ & \inst1|I3|add_185~12\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "D9C8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I3|add_225~13\,
	datad => \inst1|I3|add_185~12\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_254_rtl_104_rtl_385~0\);

\inst1|I3|Mux_254_rtl_104_rtl_385~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_254_rtl_104_rtl_385~1\ = \inst1|I3|data_x[12]~107\ & (\inst1|I3|Mux_254_rtl_104_rtl_385~0\ # \inst1|I2|TD_c[0]\ & \inst1|I3|acc_c[0][12]\) # !\inst1|I3|data_x[12]~107\ & \inst1|I3|Mux_254_rtl_104_rtl_385~0\ & (\inst1|I3|acc_c[0][12]\ # !\inst1|I2|TD_c[0]\)

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
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I3|data_x[12]~107\,
	datac => \inst1|I3|acc_c[0][12]\,
	datad => \inst1|I3|Mux_254_rtl_104_rtl_385~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_254_rtl_104_rtl_385~1\);

\rtl~14234_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14234\ = \rtl~13596\ & (\inst1|I3|Mux_254_rtl_104_rtl_385~1\ # \rtl~13900\ & \inst1|I3|acc_c[0][12]\) # !\rtl~13596\ & \rtl~13900\ & \inst1|I3|acc_c[0][12]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EAC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~13596\,
	datab => \rtl~13900\,
	datac => \inst1|I3|acc_c[0][12]\,
	datad => \inst1|I3|Mux_254_rtl_104_rtl_385~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14234\);

\rtl~14256_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14256\ = \rtl~2261\ # \rtl~14234\ # \rtl~13592\ & \inst1|I3|data_x[12]~107\

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
	dataa => \rtl~13592\,
	datab => \inst1|I3|data_x[12]~107\,
	datac => \rtl~2261\,
	datad => \rtl~14234\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14256\);

\inst1|I3|acc_c[0][12]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][12]~186\ = \inst1|I3|acc[0][12]~8264\ # \inst1|I3|acc[0][13]~8146\ & (\rtl~1576\ # \rtl~14256\)
-- \inst1|I3|acc_c[0][12]\ = DFFEA(\inst1|I3|acc[0][12]~186\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FCEC",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \rtl~1576\,
	datab => \inst1|I3|acc[0][12]~8264\,
	datac => \inst1|I3|acc[0][13]~8146\,
	datad => \rtl~14256\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][12]~186\,
	regout => \inst1|I3|acc_c[0][12]\);

\inst1|I3|acc_i[0][12]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][12]~8264\ = \inst1|I3|acc_c[0][12]\ & (\inst1|I3|acc[0][13]~111\ # \inst1|I3|acc[0][13]~8147\ & L1_acc_i[0][12]) # !\inst1|I3|acc_c[0][12]\ & \inst1|I3|acc[0][13]~8147\ & L1_acc_i[0][12]

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][12]\,
	datab => \inst1|I3|acc[0][13]~8147\,
	datac => \inst1|I3|acc[0][12]~186\,
	datad => \inst1|I3|acc[0][13]~111\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][12]~8264\);

\inst1|I3|add_225~14_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_225~14\ = \inst1|I3|acc_c[0][13]\ $ \inst1|I3|data_x[13]~77\ $ !\inst1|I3|add_225~13COUT\
-- \inst1|I3|add_225~14COUT0\ = CARRY(\inst1|I3|acc_c[0][13]\ & \inst1|I3|data_x[13]~77\ & !\inst1|I3|add_225~13COUT\ # !\inst1|I3|acc_c[0][13]\ & (\inst1|I3|data_x[13]~77\ # !\inst1|I3|add_225~13COUT\))
-- \inst1|I3|add_225~14COUT1\ = CARRY(\inst1|I3|acc_c[0][13]\ & \inst1|I3|data_x[13]~77\ & !\inst1|I3|add_225~13COUT\ # !\inst1|I3|acc_c[0][13]\ & (\inst1|I3|data_x[13]~77\ # !\inst1|I3|add_225~13COUT\))

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
	dataa => \inst1|I3|acc_c[0][13]\,
	datab => \inst1|I3|data_x[13]~77\,
	cin => \inst1|I3|add_225~13COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_225~14\,
	cout0 => \inst1|I3|add_225~14COUT0\,
	cout1 => \inst1|I3|add_225~14COUT1\);

\inst1|I3|add_225~15_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_225~15\ = \inst1|I3|acc_c[0][14]\ $ \inst1|I3|data_x[14]~97\ $ (!\inst1|I3|add_225~13COUT\ & \inst1|I3|add_225~14COUT0\) # (\inst1|I3|add_225~13COUT\ & \inst1|I3|add_225~14COUT1\)
-- \inst1|I3|add_225~15COUT0\ = CARRY(\inst1|I3|acc_c[0][14]\ & (!\inst1|I3|add_225~14COUT0\ # !\inst1|I3|data_x[14]~97\) # !\inst1|I3|acc_c[0][14]\ & !\inst1|I3|data_x[14]~97\ & !\inst1|I3|add_225~14COUT0\)
-- \inst1|I3|add_225~15COUT1\ = CARRY(\inst1|I3|acc_c[0][14]\ & (!\inst1|I3|add_225~14COUT1\ # !\inst1|I3|data_x[14]~97\) # !\inst1|I3|acc_c[0][14]\ & !\inst1|I3|data_x[14]~97\ & !\inst1|I3|add_225~14COUT1\)

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
	dataa => \inst1|I3|acc_c[0][14]\,
	datab => \inst1|I3|data_x[14]~97\,
	cin => \inst1|I3|add_225~13COUT\,
	cin0 => \inst1|I3|add_225~14COUT0\,
	cin1 => \inst1|I3|add_225~14COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_225~15\,
	cout0 => \inst1|I3|add_225~15COUT0\,
	cout1 => \inst1|I3|add_225~15COUT1\);

\inst1|I3|add_185~13_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_185~13\ = \inst1|I3|data_x[13]~77\ $ \inst1|I3|acc_c[0][13]\ $ \inst1|I3|add_185~12COUT\
-- \inst1|I3|add_185~13COUT0\ = CARRY(\inst1|I3|data_x[13]~77\ & !\inst1|I3|acc_c[0][13]\ & !\inst1|I3|add_185~12COUT\ # !\inst1|I3|data_x[13]~77\ & (!\inst1|I3|add_185~12COUT\ # !\inst1|I3|acc_c[0][13]\))
-- \inst1|I3|add_185~13COUT1\ = CARRY(\inst1|I3|data_x[13]~77\ & !\inst1|I3|acc_c[0][13]\ & !\inst1|I3|add_185~12COUT\ # !\inst1|I3|data_x[13]~77\ & (!\inst1|I3|add_185~12COUT\ # !\inst1|I3|acc_c[0][13]\))

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
	dataa => \inst1|I3|data_x[13]~77\,
	datab => \inst1|I3|acc_c[0][13]\,
	cin => \inst1|I3|add_185~12COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_185~13\,
	cout0 => \inst1|I3|add_185~13COUT0\,
	cout1 => \inst1|I3|add_185~13COUT1\);

\inst1|I3|add_185~14_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_185~14\ = \inst1|I3|acc_c[0][14]\ $ \inst1|I3|data_x[14]~97\ $ !(!\inst1|I3|add_185~12COUT\ & \inst1|I3|add_185~13COUT0\) # (\inst1|I3|add_185~12COUT\ & \inst1|I3|add_185~13COUT1\)
-- \inst1|I3|add_185~14COUT0\ = CARRY(\inst1|I3|acc_c[0][14]\ & (\inst1|I3|data_x[14]~97\ # !\inst1|I3|add_185~13COUT0\) # !\inst1|I3|acc_c[0][14]\ & \inst1|I3|data_x[14]~97\ & !\inst1|I3|add_185~13COUT0\)
-- \inst1|I3|add_185~14COUT1\ = CARRY(\inst1|I3|acc_c[0][14]\ & (\inst1|I3|data_x[14]~97\ # !\inst1|I3|add_185~13COUT1\) # !\inst1|I3|acc_c[0][14]\ & \inst1|I3|data_x[14]~97\ & !\inst1|I3|add_185~13COUT1\)

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
	dataa => \inst1|I3|acc_c[0][14]\,
	datab => \inst1|I3|data_x[14]~97\,
	cin => \inst1|I3|add_185~12COUT\,
	cin0 => \inst1|I3|add_185~13COUT0\,
	cin1 => \inst1|I3|add_185~13COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_185~14\,
	cout0 => \inst1|I3|add_185~14COUT0\,
	cout1 => \inst1|I3|add_185~14COUT1\);

\inst1|I3|Mux_252_rtl_98_rtl_379~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_252_rtl_98_rtl_379~0\ = \inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[0]\ # \inst1|I3|add_225~15\) # !\inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[0]\ & \inst1|I3|add_185~14\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "D9C8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I3|add_225~15\,
	datad => \inst1|I3|add_185~14\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_252_rtl_98_rtl_379~0\);

\inst1|I3|Mux_252_rtl_98_rtl_379~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_252_rtl_98_rtl_379~1\ = \inst1|I3|acc_c[0][14]\ & (\inst1|I3|Mux_252_rtl_98_rtl_379~0\ # \inst1|I2|TD_c[0]\ & \inst1|I3|data_x[14]~97\) # !\inst1|I3|acc_c[0][14]\ & \inst1|I3|Mux_252_rtl_98_rtl_379~0\ & (\inst1|I3|data_x[14]~97\ # !\inst1|I2|TD_c[0]\)

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
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I3|acc_c[0][14]\,
	datac => \inst1|I3|data_x[14]~97\,
	datad => \inst1|I3|Mux_252_rtl_98_rtl_379~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_252_rtl_98_rtl_379~1\);

\rtl~14191_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14191\ = \inst1|I3|acc_c[0][14]\ & (\rtl~13900\ # \rtl~13596\ & \inst1|I3|Mux_252_rtl_98_rtl_379~1\) # !\inst1|I3|acc_c[0][14]\ & \rtl~13596\ & \inst1|I3|Mux_252_rtl_98_rtl_379~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ECA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][14]\,
	datab => \rtl~13596\,
	datac => \rtl~13900\,
	datad => \inst1|I3|Mux_252_rtl_98_rtl_379~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14191\);

\rtl~14213_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14213\ = \rtl~2246\ # \rtl~14191\ # \rtl~13592\ & \inst1|I3|data_x[14]~97\

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
	dataa => \rtl~13592\,
	datab => \inst1|I3|data_x[14]~97\,
	datac => \rtl~2246\,
	datad => \rtl~14191\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14213\);

\inst1|I3|acc_c[0][14]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][14]~176\ = \inst1|I3|acc[0][14]~8254\ # \inst1|I3|acc[0][13]~8146\ & (\rtl~1541\ # \rtl~14213\)
-- \inst1|I3|acc_c[0][14]\ = DFFEA(\inst1|I3|acc[0][14]~176\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][14]~8254\,
	datab => \inst1|I3|acc[0][13]~8146\,
	datac => \rtl~1541\,
	datad => \rtl~14213\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][14]~176\,
	regout => \inst1|I3|acc_c[0][14]\);

\inst1|I3|acc_i[0][14]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][14]~8254\ = \inst1|I3|acc_c[0][14]\ & (\inst1|I3|acc[0][13]~111\ # L1_acc_i[0][14] & \inst1|I3|acc[0][13]~8147\) # !\inst1|I3|acc_c[0][14]\ & L1_acc_i[0][14] & \inst1|I3|acc[0][13]~8147\

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][14]\,
	datab => \inst1|I3|acc[0][13]~111\,
	datac => \inst1|I3|acc[0][14]~176\,
	datad => \inst1|I3|acc[0][13]~8147\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][14]~8254\);

\inst1|I4|data_ox[14]~5_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_ox[14]~5\ = \inst1|I3|acc_c[0][14]\ & \nreset_in~combout\ & \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\

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
	datab => \inst1|I3|acc_c[0][14]\,
	datac => \nreset_in~combout\,
	datad => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_ox[14]~5\);

\inst1|I4|data_ox[5]~2_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_ox[5]~2\ = \inst1|I3|acc_c[0][5]\ & \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ & \nreset_in~combout\

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
	datab => \inst1|I3|acc_c[0][5]\,
	datac => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	datad => \nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_ox[5]~2\);

\inst|altsyncram_component|ram_block[0][11]\ : cyclone_ram_block 
-- pragma translate_off
GENERIC MAP (
	mem8 => "00101001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem7 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001010001001000000101011",
	mem6 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem5 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000",
	mem4 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem3 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000",
	mem2 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000",
	operation_mode => "single_port",
	ram_block_type => "auto",
	logical_ram_name => "lpm_ram_dq:inst|altsyncram:altsyncram_component|ALTSYNCRAM INSTANTIATION",
	init_file => "../rom.mif",
	init_file_layout => "port_a",
	data_interleave_width_in_bits => 1,
	data_interleave_offset_in_bits => 1,
	port_a_byte_enable_clock => "none",
	port_a_logical_ram_depth => 1024,
	port_a_logical_ram_width => 16,
	port_a_data_in_clear => "none",
	port_a_address_clear => "none",
	port_a_write_enable_clear => "none",
	port_a_byte_enable_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_out_clear => "none",
	port_a_first_address => 0,
	port_a_last_address => 1023,
	port_a_first_bit_number => 11,
	port_a_data_width => 4,
	port_a_address_width => 10)
-- pragma translate_on
PORT MAP (
	portawe => \inst3|nWE_RAM_c\,
	clk0 => \clk_in~combout\,
	ena0 => VCC,
	portaaddr => \ww_inst|altsyncram_component|ram_block[0][11]_aaddress\,
	portadatain => \ww_inst|altsyncram_component|ram_block[0][11]_adatain\,
	devclrn => devclrn,
	devpor => devpor,
	portadataout => \ww_inst|altsyncram_component|ram_block[0][11]_adataout\);

\inst1|I1|iaddr_x[7]~1893_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[7]~1893\ = \inst1|I2|pc_mux_x[2]~26\ & \inst11|inst1|altsyncram_component|q_a[7]\ # !\inst1|I2|pc_mux_x[2]~26\ & \inst|altsyncram_component|q_a[11]\ & \inst1|I2|pc_mux_x[1]~49\

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
	dataa => \inst11|inst1|altsyncram_component|q_a[7]\,
	datab => \inst|altsyncram_component|q_a[11]\,
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I2|pc_mux_x[1]~49\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[7]~1893\);

\inst1|I1|pc[7]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[7]~168\ = \inst1|I1|i~2\ & (\inst1|I1|iaddr_x[7]~235\ # \inst1|I1|iaddr_x[7]~1893\ # \inst1|I1|iaddr_x[3]~120\)
-- \inst1|I1|pc[7]\ = DFFEA(\inst1|I1|iaddr_x[7]~168\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAA8",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I1|i~2\,
	datab => \inst1|I1|iaddr_x[7]~235\,
	datac => \inst1|I1|iaddr_x[7]~1893\,
	datad => \inst1|I1|iaddr_x[3]~120\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[7]~168\,
	regout => \inst1|I1|pc[7]\);

\inst1|I1|add_27~8_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|add_27~8\ = \inst1|I1|pc[8]\ $ !(!\inst1|I1|add_27~4COUT\ & \inst1|I1|add_27~7COUT0\) # (\inst1|I1|add_27~4COUT\ & \inst1|I1|add_27~7COUT1\)
-- \inst1|I1|add_27~8COUT0\ = CARRY(\inst1|I1|pc[8]\ & !\inst1|I1|add_27~7COUT0\)
-- \inst1|I1|add_27~8COUT1\ = CARRY(\inst1|I1|pc[8]\ & !\inst1|I1|add_27~7COUT1\)

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
	datab => \inst1|I1|pc[8]\,
	cin => \inst1|I1|add_27~4COUT\,
	cin0 => \inst1|I1|add_27~7COUT0\,
	cin1 => \inst1|I1|add_27~7COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|add_27~8\,
	cout0 => \inst1|I1|add_27~8COUT0\,
	cout1 => \inst1|I1|add_27~8COUT1\);

\inst1|I1|add_27~9_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|add_27~9\ = (!\inst1|I1|add_27~4COUT\ & \inst1|I1|add_27~8COUT0\) # (\inst1|I1|add_27~4COUT\ & \inst1|I1|add_27~8COUT1\) $ \inst1|I1|pc[9]\

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
	datad => \inst1|I1|pc[9]\,
	cin => \inst1|I1|add_27~4COUT\,
	cin0 => \inst1|I1|add_27~8COUT0\,
	cin1 => \inst1|I1|add_27~8COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|add_27~9\);

\rtl~1958_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~1958\ = \inst1|I1|add_27~9\ & \inst1|I1|i~2\ & \inst1|I1|Mux_41_rtl_211~0\ & !\inst1|I2|pc_mux_x[2]~26\

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
	dataa => \inst1|I1|add_27~9\,
	datab => \inst1|I1|i~2\,
	datac => \inst1|I1|Mux_41_rtl_211~0\,
	datad => \inst1|I2|pc_mux_x[2]~26\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1958\);

\inst1|I1|Mux_67~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_67~0\ = !\inst1|I2|pc_mux_x[0]~167\ & \inst1|I2|pc_mux_x[1]~49\ & \inst1|I1|Mux_67~8\

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
	datab => \inst1|I2|pc_mux_x[0]~167\,
	datac => \inst1|I2|pc_mux_x[1]~49\,
	datad => \inst1|I1|Mux_67~8\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_67~0\);

\rtl~1020\ : cyclone_lcell 
-- Equation(s):
-- \rtl~345\ = LCELL(\rtl~345\ & (\inst|altsyncram_component|q_a[13]\ # !\inst1|I1|Mux_67~0\) # !\rtl~345\ & \inst|altsyncram_component|q_a[13]\ & \inst1|I1|Mux_67~0\)

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
	datab => \rtl~345\,
	datac => \inst|altsyncram_component|q_a[13]\,
	datad => \inst1|I1|Mux_67~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~345\);

\inst1|I1|Mux_46_rtl_63_rtl_343~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_46_rtl_63_rtl_343~0\ = \inst1|I2|pc_mux_x[1]~49\ & (\inst1|I2|pc_mux_x[0]~167\ # \rtl~345\) # !\inst1|I2|pc_mux_x[1]~49\ & !\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|add_27~9\

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
	dataa => \inst1|I2|pc_mux_x[1]~49\,
	datab => \inst1|I2|pc_mux_x[0]~167\,
	datac => \inst1|I1|add_27~9\,
	datad => \rtl~345\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_46_rtl_63_rtl_343~0\);

\inst1|I1|Mux_46_rtl_63_rtl_343~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_46_rtl_63_rtl_343~1\ = \inst1|I1|Mux_46_rtl_63_rtl_343~0\ & (\inst11|inst1|altsyncram_component|q_a[9]\ # !\inst1|I2|pc_mux_x[0]~167\) # !\inst1|I1|Mux_46_rtl_63_rtl_343~0\ & \inst1|I1|pc[9]\ & \inst1|I2|pc_mux_x[0]~167\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F388",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|pc[9]\,
	datab => \inst1|I2|pc_mux_x[0]~167\,
	datac => \inst11|inst1|altsyncram_component|q_a[9]\,
	datad => \inst1|I1|Mux_46_rtl_63_rtl_343~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_46_rtl_63_rtl_343~1\);

\rtl~2481_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2481\ = \rtl~2482\ # \rtl~1958\ # \inst1|I1|Mux_67~8\ & \inst1|I1|Mux_46_rtl_63_rtl_343~1\

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
	dataa => \rtl~2482\,
	datab => \inst1|I1|Mux_67~8\,
	datac => \rtl~1958\,
	datad => \inst1|I1|Mux_46_rtl_63_rtl_343~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2481\);

\inst11|inst1|altsyncram_component|ram_block[0][0]\ : cyclone_ram_block 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "single_port",
	ram_block_type => "auto",
	logical_ram_name => "stack:inst11|lpm_ram_stack:inst1|altsyncram:altsyncram_component|ALTSYNCRAM INSTANTIATION",
	data_interleave_width_in_bits => 1,
	data_interleave_offset_in_bits => 1,
	port_a_byte_enable_clock => "none",
	port_a_logical_ram_depth => 256,
	port_a_logical_ram_width => 12,
	port_a_data_in_clear => "none",
	port_a_address_clear => "none",
	port_a_write_enable_clear => "none",
	port_a_byte_enable_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_out_clear => "none",
	port_a_first_address => 0,
	port_a_last_address => 255,
	port_a_first_bit_number => 0,
	port_a_data_width => 10,
	port_a_address_width => 8)
-- pragma translate_on
PORT MAP (
	portawe => \inst1|I1|i~17\,
	clk0 => \clk_in~combout\,
	ena0 => VCC,
	portaaddr => \ww_inst11|inst1|altsyncram_component|ram_block[0][0]_aaddress\,
	portadatain => \ww_inst11|inst1|altsyncram_component|ram_block[0][0]_adatain\,
	devclrn => devclrn,
	devpor => devpor,
	portadataout => \ww_inst11|inst1|altsyncram_component|ram_block[0][0]_adataout\);

\inst1|I1|iaddr_x[8]~1916_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[8]~1916\ = \inst1|I2|pc_mux_x[2]~26\ & \inst11|inst1|altsyncram_component|q_a[8]\ # !\inst1|I2|pc_mux_x[2]~26\ & \inst|altsyncram_component|q_a[12]\ & \inst1|I2|pc_mux_x[1]~49\

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
	dataa => \inst11|inst1|altsyncram_component|q_a[8]\,
	datab => \inst|altsyncram_component|q_a[12]\,
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I2|pc_mux_x[1]~49\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[8]~1916\);

\inst1|I1|iaddr_x[8]~245_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[8]~245\ = \inst1|I1|iaddr_x[3]~1716\ & (\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|add_27~8\ # !\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|pc[8]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AC00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|add_27~8\,
	datab => \inst1|I1|pc[8]\,
	datac => \inst1|I2|pc_mux_x[0]~167\,
	datad => \inst1|I1|iaddr_x[3]~1716\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[8]~245\);

\inst1|I1|pc[8]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[8]~178\ = \inst1|I1|i~2\ & (\inst1|I1|iaddr_x[8]~1916\ # \inst1|I1|iaddr_x[3]~120\ # \inst1|I1|iaddr_x[8]~245\)
-- \inst1|I1|pc[8]\ = DFFEA(\inst1|I1|iaddr_x[8]~178\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAA8",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I1|i~2\,
	datab => \inst1|I1|iaddr_x[8]~1916\,
	datac => \inst1|I1|iaddr_x[3]~120\,
	datad => \inst1|I1|iaddr_x[8]~245\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[8]~178\,
	regout => \inst1|I1|pc[8]\);

\rtl~1949_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~1949\ = \inst1|I1|i~2\ & !\inst1|I2|pc_mux_x[2]~26\ & \inst1|I1|add_27~8\ & \inst1|I1|Mux_41_rtl_211~0\

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
	dataa => \inst1|I1|i~2\,
	datab => \inst1|I2|pc_mux_x[2]~26\,
	datac => \inst1|I1|add_27~8\,
	datad => \inst1|I1|Mux_41_rtl_211~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1949\);

\inst1|I1|Mux_47_rtl_60_rtl_340~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_47_rtl_60_rtl_340~0\ = \inst1|I2|pc_mux_x[0]~167\ & (\inst1|I1|pc[8]\ # \inst1|I2|pc_mux_x[1]~49\) # !\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|add_27~8\ & !\inst1|I2|pc_mux_x[1]~49\

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
	dataa => \inst1|I1|add_27~8\,
	datab => \inst1|I1|pc[8]\,
	datac => \inst1|I2|pc_mux_x[0]~167\,
	datad => \inst1|I2|pc_mux_x[1]~49\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_47_rtl_60_rtl_340~0\);

\rtl~1017\ : cyclone_lcell 
-- Equation(s):
-- \rtl~344\ = LCELL(\rtl~344\ & (\inst|altsyncram_component|q_a[12]\ # !\inst1|I1|Mux_67~0\) # !\rtl~344\ & \inst|altsyncram_component|q_a[12]\ & \inst1|I1|Mux_67~0\)

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
	datab => \rtl~344\,
	datac => \inst|altsyncram_component|q_a[12]\,
	datad => \inst1|I1|Mux_67~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~344\);

\inst1|I1|Mux_47_rtl_60_rtl_340~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_47_rtl_60_rtl_340~1\ = \inst1|I1|Mux_47_rtl_60_rtl_340~0\ & (\inst11|inst1|altsyncram_component|q_a[8]\ # !\inst1|I2|pc_mux_x[1]~49\) # !\inst1|I1|Mux_47_rtl_60_rtl_340~0\ & \inst1|I2|pc_mux_x[1]~49\ & \rtl~344\

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
	dataa => \inst1|I2|pc_mux_x[1]~49\,
	datab => \inst11|inst1|altsyncram_component|q_a[8]\,
	datac => \inst1|I1|Mux_47_rtl_60_rtl_340~0\,
	datad => \rtl~344\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_47_rtl_60_rtl_340~1\);

\rtl~2472_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2472\ = \inst11|inst1|altsyncram_component|q_a[8]\ & (!\inst1|I2|pc_mux_x[2]~26\ & !\inst1|I1|Mux_41_rtl_211~0\ # !\inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "444C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|i~2\,
	datab => \inst11|inst1|altsyncram_component|q_a[8]\,
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I1|Mux_41_rtl_211~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2472\);

\rtl~2471_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2471\ = \rtl~1949\ # \rtl~2472\ # \inst1|I1|Mux_67~8\ & \inst1|I1|Mux_47_rtl_60_rtl_340~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFEA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~1949\,
	datab => \inst1|I1|Mux_67~8\,
	datac => \inst1|I1|Mux_47_rtl_60_rtl_340~1\,
	datad => \rtl~2472\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2471\);

\rtl~2462_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2462\ = \inst11|inst1|altsyncram_component|q_a[7]\ & (!\inst1|I2|pc_mux_x[2]~26\ & !\inst1|I1|Mux_41_rtl_211~0\ # !\inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "444C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|i~2\,
	datab => \inst11|inst1|altsyncram_component|q_a[7]\,
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I1|Mux_41_rtl_211~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2462\);

\rtl~1940_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~1940\ = \inst1|I1|i~2\ & \inst1|I1|add_27~7\ & !\inst1|I2|pc_mux_x[2]~26\ & \inst1|I1|Mux_41_rtl_211~0\

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
	dataa => \inst1|I1|i~2\,
	datab => \inst1|I1|add_27~7\,
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I1|Mux_41_rtl_211~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1940\);

\rtl~1014\ : cyclone_lcell 
-- Equation(s):
-- \rtl~343\ = LCELL(\rtl~343\ & (\inst|altsyncram_component|q_a[11]\ # !\inst1|I1|Mux_67~0\) # !\rtl~343\ & \inst|altsyncram_component|q_a[11]\ & \inst1|I1|Mux_67~0\)

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
	dataa => \rtl~343\,
	datab => \inst|altsyncram_component|q_a[11]\,
	datad => \inst1|I1|Mux_67~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~343\);

\inst1|I1|Mux_48_rtl_57_rtl_337~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_48_rtl_57_rtl_337~0\ = \inst1|I2|pc_mux_x[1]~49\ & (\inst1|I2|pc_mux_x[0]~167\ # \rtl~343\) # !\inst1|I2|pc_mux_x[1]~49\ & \inst1|I1|add_27~7\ & !\inst1|I2|pc_mux_x[0]~167\

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
	dataa => \inst1|I1|add_27~7\,
	datab => \inst1|I2|pc_mux_x[1]~49\,
	datac => \inst1|I2|pc_mux_x[0]~167\,
	datad => \rtl~343\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_48_rtl_57_rtl_337~0\);

\inst1|I1|Mux_48_rtl_57_rtl_337~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_48_rtl_57_rtl_337~1\ = \inst1|I1|Mux_48_rtl_57_rtl_337~0\ & (\inst11|inst1|altsyncram_component|q_a[7]\ # !\inst1|I2|pc_mux_x[0]~167\) # !\inst1|I1|Mux_48_rtl_57_rtl_337~0\ & \inst1|I1|pc[7]\ & \inst1|I2|pc_mux_x[0]~167\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F388",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|pc[7]\,
	datab => \inst1|I2|pc_mux_x[0]~167\,
	datac => \inst11|inst1|altsyncram_component|q_a[7]\,
	datad => \inst1|I1|Mux_48_rtl_57_rtl_337~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_48_rtl_57_rtl_337~1\);

\rtl~2461_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2461\ = \rtl~2462\ # \rtl~1940\ # \inst1|I1|Mux_67~8\ & \inst1|I1|Mux_48_rtl_57_rtl_337~1\

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
	dataa => \inst1|I1|Mux_67~8\,
	datab => \rtl~2462\,
	datac => \rtl~1940\,
	datad => \inst1|I1|Mux_48_rtl_57_rtl_337~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2461\);

\rtl~2452_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2452\ = \inst11|inst1|altsyncram_component|q_a[6]\ & (!\inst1|I2|pc_mux_x[2]~26\ & !\inst1|I1|Mux_41_rtl_211~0\ # !\inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "444C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|i~2\,
	datab => \inst11|inst1|altsyncram_component|q_a[6]\,
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I1|Mux_41_rtl_211~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2452\);

\rtl~1931_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~1931\ = \inst1|I1|i~2\ & \inst1|I1|add_27~6\ & !\inst1|I2|pc_mux_x[2]~26\ & \inst1|I1|Mux_41_rtl_211~0\

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
	dataa => \inst1|I1|i~2\,
	datab => \inst1|I1|add_27~6\,
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I1|Mux_41_rtl_211~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1931\);

\inst1|I1|Mux_49_rtl_54_rtl_334~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_49_rtl_54_rtl_334~0\ = \inst1|I2|pc_mux_x[0]~167\ & (\inst1|I1|pc[6]\ # \inst1|I2|pc_mux_x[1]~49\) # !\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|add_27~6\ & !\inst1|I2|pc_mux_x[1]~49\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FC0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|add_27~6\,
	datab => \inst1|I1|pc[6]\,
	datac => \inst1|I2|pc_mux_x[1]~49\,
	datad => \inst1|I2|pc_mux_x[0]~167\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_49_rtl_54_rtl_334~0\);

\rtl~1011\ : cyclone_lcell 
-- Equation(s):
-- \rtl~342\ = LCELL(\inst|altsyncram_component|q_a[10]\ & (\rtl~342\ # \inst1|I1|Mux_67~0\) # !\inst|altsyncram_component|q_a[10]\ & \rtl~342\ & !\inst1|I1|Mux_67~0\)

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
	dataa => \inst|altsyncram_component|q_a[10]\,
	datab => \rtl~342\,
	datad => \inst1|I1|Mux_67~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~342\);

\inst1|I1|Mux_49_rtl_54_rtl_334~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_49_rtl_54_rtl_334~1\ = \inst1|I1|Mux_49_rtl_54_rtl_334~0\ & (\inst11|inst1|altsyncram_component|q_a[6]\ # !\inst1|I2|pc_mux_x[1]~49\) # !\inst1|I1|Mux_49_rtl_54_rtl_334~0\ & \inst1|I2|pc_mux_x[1]~49\ & \rtl~342\

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
	dataa => \inst1|I2|pc_mux_x[1]~49\,
	datab => \inst11|inst1|altsyncram_component|q_a[6]\,
	datac => \inst1|I1|Mux_49_rtl_54_rtl_334~0\,
	datad => \rtl~342\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_49_rtl_54_rtl_334~1\);

\rtl~2451_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2451\ = \rtl~2452\ # \rtl~1931\ # \inst1|I1|Mux_67~8\ & \inst1|I1|Mux_49_rtl_54_rtl_334~1\

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
	dataa => \inst1|I1|Mux_67~8\,
	datab => \rtl~2452\,
	datac => \rtl~1931\,
	datad => \inst1|I1|Mux_49_rtl_54_rtl_334~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2451\);

\rtl~2442_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2442\ = \inst11|inst1|altsyncram_component|q_a[5]\ & (!\inst1|I2|pc_mux_x[2]~26\ & !\inst1|I1|Mux_41_rtl_211~0\ # !\inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "444C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|i~2\,
	datab => \inst11|inst1|altsyncram_component|q_a[5]\,
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I1|Mux_41_rtl_211~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2442\);

\rtl~1922_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~1922\ = \inst1|I1|i~2\ & \inst1|I1|add_27~5\ & !\inst1|I2|pc_mux_x[2]~26\ & \inst1|I1|Mux_41_rtl_211~0\

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
	dataa => \inst1|I1|i~2\,
	datab => \inst1|I1|add_27~5\,
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I1|Mux_41_rtl_211~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1922\);

\rtl~1008\ : cyclone_lcell 
-- Equation(s):
-- \rtl~341\ = LCELL(\rtl~341\ & (\inst|altsyncram_component|q_a[9]\ # !\inst1|I1|Mux_67~0\) # !\rtl~341\ & \inst|altsyncram_component|q_a[9]\ & \inst1|I1|Mux_67~0\)

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
	datab => \rtl~341\,
	datac => \inst|altsyncram_component|q_a[9]\,
	datad => \inst1|I1|Mux_67~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~341\);

\inst1|I1|Mux_50_rtl_51_rtl_331~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_50_rtl_51_rtl_331~0\ = \inst1|I2|pc_mux_x[1]~49\ & (\inst1|I2|pc_mux_x[0]~167\ # \rtl~341\) # !\inst1|I2|pc_mux_x[1]~49\ & \inst1|I1|add_27~5\ & !\inst1|I2|pc_mux_x[0]~167\

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
	dataa => \inst1|I1|add_27~5\,
	datab => \inst1|I2|pc_mux_x[1]~49\,
	datac => \inst1|I2|pc_mux_x[0]~167\,
	datad => \rtl~341\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_50_rtl_51_rtl_331~0\);

\inst1|I1|Mux_50_rtl_51_rtl_331~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_50_rtl_51_rtl_331~1\ = \inst1|I1|Mux_50_rtl_51_rtl_331~0\ & (\inst11|inst1|altsyncram_component|q_a[5]\ # !\inst1|I2|pc_mux_x[0]~167\) # !\inst1|I1|Mux_50_rtl_51_rtl_331~0\ & \inst1|I1|pc[5]\ & \inst1|I2|pc_mux_x[0]~167\

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
	dataa => \inst1|I1|pc[5]\,
	datab => \inst11|inst1|altsyncram_component|q_a[5]\,
	datac => \inst1|I2|pc_mux_x[0]~167\,
	datad => \inst1|I1|Mux_50_rtl_51_rtl_331~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_50_rtl_51_rtl_331~1\);

\rtl~2441_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2441\ = \rtl~2442\ # \rtl~1922\ # \inst1|I1|Mux_67~8\ & \inst1|I1|Mux_50_rtl_51_rtl_331~1\

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
	dataa => \rtl~2442\,
	datab => \inst1|I1|Mux_67~8\,
	datac => \rtl~1922\,
	datad => \inst1|I1|Mux_50_rtl_51_rtl_331~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2441\);

\rtl~2432_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2432\ = \inst11|inst1|altsyncram_component|q_a[4]\ & (!\inst1|I2|pc_mux_x[2]~26\ & !\inst1|I1|Mux_41_rtl_211~0\ # !\inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "444C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|i~2\,
	datab => \inst11|inst1|altsyncram_component|q_a[4]\,
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I1|Mux_41_rtl_211~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2432\);

\rtl~1913_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~1913\ = \inst1|I1|i~2\ & \inst1|I1|add_27~4\ & !\inst1|I2|pc_mux_x[2]~26\ & \inst1|I1|Mux_41_rtl_211~0\

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
	dataa => \inst1|I1|i~2\,
	datab => \inst1|I1|add_27~4\,
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I1|Mux_41_rtl_211~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1913\);

\rtl~1005\ : cyclone_lcell 
-- Equation(s):
-- \rtl~340\ = LCELL(\rtl~340\ & (\inst|altsyncram_component|q_a[8]\ # !\inst1|I1|Mux_67~0\) # !\rtl~340\ & \inst|altsyncram_component|q_a[8]\ & \inst1|I1|Mux_67~0\)

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
	dataa => \rtl~340\,
	datac => \inst|altsyncram_component|q_a[8]\,
	datad => \inst1|I1|Mux_67~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~340\);

\inst1|I1|Mux_51_rtl_48_rtl_328~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_51_rtl_48_rtl_328~0\ = \inst1|I2|pc_mux_x[0]~167\ & (\inst1|I2|pc_mux_x[1]~49\ # \inst1|I1|pc[4]\) # !\inst1|I2|pc_mux_x[0]~167\ & !\inst1|I2|pc_mux_x[1]~49\ & \inst1|I1|add_27~4\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EE50",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|pc_mux_x[1]~49\,
	datab => \inst1|I1|pc[4]\,
	datac => \inst1|I1|add_27~4\,
	datad => \inst1|I2|pc_mux_x[0]~167\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_51_rtl_48_rtl_328~0\);

\inst1|I1|Mux_51_rtl_48_rtl_328~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_51_rtl_48_rtl_328~1\ = \inst1|I1|Mux_51_rtl_48_rtl_328~0\ & (\inst11|inst1|altsyncram_component|q_a[4]\ # !\inst1|I2|pc_mux_x[1]~49\) # !\inst1|I1|Mux_51_rtl_48_rtl_328~0\ & \inst1|I2|pc_mux_x[1]~49\ & \rtl~340\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DDA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|pc_mux_x[1]~49\,
	datab => \inst11|inst1|altsyncram_component|q_a[4]\,
	datac => \rtl~340\,
	datad => \inst1|I1|Mux_51_rtl_48_rtl_328~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_51_rtl_48_rtl_328~1\);

\rtl~2431_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2431\ = \rtl~2432\ # \rtl~1913\ # \inst1|I1|Mux_67~8\ & \inst1|I1|Mux_51_rtl_48_rtl_328~1\

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
	dataa => \inst1|I1|Mux_67~8\,
	datab => \rtl~2432\,
	datac => \rtl~1913\,
	datad => \inst1|I1|Mux_51_rtl_48_rtl_328~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2431\);

\rtl~2422_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2422\ = \inst11|inst1|altsyncram_component|q_a[3]\ & (!\inst1|I2|pc_mux_x[2]~26\ & !\inst1|I1|Mux_41_rtl_211~0\ # !\inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5070",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|i~2\,
	datab => \inst1|I2|pc_mux_x[2]~26\,
	datac => \inst11|inst1|altsyncram_component|q_a[3]\,
	datad => \inst1|I1|Mux_41_rtl_211~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2422\);

\rtl~1904_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~1904\ = \inst1|I1|i~2\ & \inst1|I1|add_27~3\ & !\inst1|I2|pc_mux_x[2]~26\ & \inst1|I1|Mux_41_rtl_211~0\

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
	dataa => \inst1|I1|i~2\,
	datab => \inst1|I1|add_27~3\,
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I1|Mux_41_rtl_211~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1904\);

\rtl~1002\ : cyclone_lcell 
-- Equation(s):
-- \rtl~339\ = LCELL(\rtl~339\ & (\inst|altsyncram_component|q_a[7]\ # !\inst1|I1|Mux_67~0\) # !\rtl~339\ & \inst|altsyncram_component|q_a[7]\ & \inst1|I1|Mux_67~0\)

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
	datab => \rtl~339\,
	datac => \inst|altsyncram_component|q_a[7]\,
	datad => \inst1|I1|Mux_67~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~339\);

\inst1|I1|Mux_52_rtl_45_rtl_325~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_52_rtl_45_rtl_325~0\ = \inst1|I2|pc_mux_x[1]~49\ & (\inst1|I2|pc_mux_x[0]~167\ # \rtl~339\) # !\inst1|I2|pc_mux_x[1]~49\ & !\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|add_27~3\

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
	dataa => \inst1|I2|pc_mux_x[1]~49\,
	datab => \inst1|I2|pc_mux_x[0]~167\,
	datac => \inst1|I1|add_27~3\,
	datad => \rtl~339\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_52_rtl_45_rtl_325~0\);

\inst1|I1|Mux_52_rtl_45_rtl_325~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_52_rtl_45_rtl_325~1\ = \inst1|I1|Mux_52_rtl_45_rtl_325~0\ & (\inst11|inst1|altsyncram_component|q_a[3]\ # !\inst1|I2|pc_mux_x[0]~167\) # !\inst1|I1|Mux_52_rtl_45_rtl_325~0\ & \inst1|I1|pc[3]\ & \inst1|I2|pc_mux_x[0]~167\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F388",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|pc[3]\,
	datab => \inst1|I2|pc_mux_x[0]~167\,
	datac => \inst11|inst1|altsyncram_component|q_a[3]\,
	datad => \inst1|I1|Mux_52_rtl_45_rtl_325~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_52_rtl_45_rtl_325~1\);

\rtl~2421_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2421\ = \rtl~2422\ # \rtl~1904\ # \inst1|I1|Mux_67~8\ & \inst1|I1|Mux_52_rtl_45_rtl_325~1\

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
	dataa => \rtl~2422\,
	datab => \inst1|I1|Mux_67~8\,
	datac => \rtl~1904\,
	datad => \inst1|I1|Mux_52_rtl_45_rtl_325~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2421\);

\inst1|I1|Mux_53_rtl_42_rtl_322~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_53_rtl_42_rtl_322~0\ = \inst1|I2|pc_mux_x[0]~167\ & (\inst1|I1|pc[2]\ # \inst1|I2|pc_mux_x[1]~49\) # !\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|add_27~2\ & !\inst1|I2|pc_mux_x[1]~49\

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
	dataa => \inst1|I1|pc[2]\,
	datab => \inst1|I1|add_27~2\,
	datac => \inst1|I2|pc_mux_x[1]~49\,
	datad => \inst1|I2|pc_mux_x[0]~167\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_53_rtl_42_rtl_322~0\);

\rtl~999\ : cyclone_lcell 
-- Equation(s):
-- \rtl~338\ = LCELL(\rtl~338\ & (\inst|altsyncram_component|q_a[6]\ # !\inst1|I1|Mux_67~0\) # !\rtl~338\ & \inst|altsyncram_component|q_a[6]\ & \inst1|I1|Mux_67~0\)

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
	datab => \rtl~338\,
	datac => \inst|altsyncram_component|q_a[6]\,
	datad => \inst1|I1|Mux_67~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~338\);

\inst1|I1|Mux_53_rtl_42_rtl_322~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_53_rtl_42_rtl_322~1\ = \inst1|I1|Mux_53_rtl_42_rtl_322~0\ & (\inst11|inst1|altsyncram_component|q_a[2]\ # !\inst1|I2|pc_mux_x[1]~49\) # !\inst1|I1|Mux_53_rtl_42_rtl_322~0\ & \inst1|I2|pc_mux_x[1]~49\ & \rtl~338\

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
	dataa => \inst11|inst1|altsyncram_component|q_a[2]\,
	datab => \inst1|I2|pc_mux_x[1]~49\,
	datac => \inst1|I1|Mux_53_rtl_42_rtl_322~0\,
	datad => \rtl~338\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_53_rtl_42_rtl_322~1\);

\rtl~2412_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2412\ = \inst11|inst1|altsyncram_component|q_a[2]\ & (!\inst1|I2|pc_mux_x[2]~26\ & !\inst1|I1|Mux_41_rtl_211~0\ # !\inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5700",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|i~2\,
	datab => \inst1|I2|pc_mux_x[2]~26\,
	datac => \inst1|I1|Mux_41_rtl_211~0\,
	datad => \inst11|inst1|altsyncram_component|q_a[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2412\);

\rtl~1895_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~1895\ = \inst1|I1|i~2\ & \inst1|I1|add_27~2\ & !\inst1|I2|pc_mux_x[2]~26\ & \inst1|I1|Mux_41_rtl_211~0\

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
	dataa => \inst1|I1|i~2\,
	datab => \inst1|I1|add_27~2\,
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I1|Mux_41_rtl_211~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1895\);

\rtl~2411_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2411\ = \rtl~2412\ # \rtl~1895\ # \inst1|I1|Mux_67~8\ & \inst1|I1|Mux_53_rtl_42_rtl_322~1\

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
	dataa => \inst1|I1|Mux_67~8\,
	datab => \inst1|I1|Mux_53_rtl_42_rtl_322~1\,
	datac => \rtl~2412\,
	datad => \rtl~1895\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2411\);

\rtl~2402_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2402\ = \inst11|inst1|altsyncram_component|q_a[1]\ & (!\inst1|I1|Mux_41_rtl_211~0\ & !\inst1|I2|pc_mux_x[2]~26\ # !\inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "222A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst11|inst1|altsyncram_component|q_a[1]\,
	datab => \inst1|I1|i~2\,
	datac => \inst1|I1|Mux_41_rtl_211~0\,
	datad => \inst1|I2|pc_mux_x[2]~26\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2402\);

\rtl~996\ : cyclone_lcell 
-- Equation(s):
-- \rtl~337\ = LCELL(\rtl~337\ & (\inst|altsyncram_component|q_a[5]\ # !\inst1|I1|Mux_67~0\) # !\rtl~337\ & \inst|altsyncram_component|q_a[5]\ & \inst1|I1|Mux_67~0\)

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
	dataa => \rtl~337\,
	datac => \inst|altsyncram_component|q_a[5]\,
	datad => \inst1|I1|Mux_67~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~337\);

\inst1|I1|Mux_54_rtl_39_rtl_319~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_54_rtl_39_rtl_319~0\ = \inst1|I2|pc_mux_x[1]~49\ & (\rtl~337\ # \inst1|I2|pc_mux_x[0]~167\) # !\inst1|I2|pc_mux_x[1]~49\ & \inst1|I1|add_27~1\ & !\inst1|I2|pc_mux_x[0]~167\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCE2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|add_27~1\,
	datab => \inst1|I2|pc_mux_x[1]~49\,
	datac => \rtl~337\,
	datad => \inst1|I2|pc_mux_x[0]~167\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_54_rtl_39_rtl_319~0\);

\inst1|I1|Mux_54_rtl_39_rtl_319~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_54_rtl_39_rtl_319~1\ = \inst1|I1|Mux_54_rtl_39_rtl_319~0\ & (\inst11|inst1|altsyncram_component|q_a[1]\ # !\inst1|I2|pc_mux_x[0]~167\) # !\inst1|I1|Mux_54_rtl_39_rtl_319~0\ & \inst1|I1|pc[1]\ & \inst1|I2|pc_mux_x[0]~167\

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
	dataa => \inst11|inst1|altsyncram_component|q_a[1]\,
	datab => \inst1|I1|pc[1]\,
	datac => \inst1|I2|pc_mux_x[0]~167\,
	datad => \inst1|I1|Mux_54_rtl_39_rtl_319~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_54_rtl_39_rtl_319~1\);

\rtl~1886_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~1886\ = \inst1|I1|add_27~1\ & \inst1|I1|i~2\ & \inst1|I1|Mux_41_rtl_211~0\ & !\inst1|I2|pc_mux_x[2]~26\

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
	dataa => \inst1|I1|add_27~1\,
	datab => \inst1|I1|i~2\,
	datac => \inst1|I1|Mux_41_rtl_211~0\,
	datad => \inst1|I2|pc_mux_x[2]~26\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1886\);

\rtl~2401_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2401\ = \rtl~2402\ # \rtl~1886\ # \inst1|I1|Mux_67~8\ & \inst1|I1|Mux_54_rtl_39_rtl_319~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFEA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~2402\,
	datab => \inst1|I1|Mux_67~8\,
	datac => \inst1|I1|Mux_54_rtl_39_rtl_319~1\,
	datad => \rtl~1886\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2401\);

\rtl~2392_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2392\ = \inst11|inst1|altsyncram_component|q_a[0]\ & (!\inst1|I2|pc_mux_x[2]~26\ & !\inst1|I1|Mux_41_rtl_211~0\ # !\inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "444C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|i~2\,
	datab => \inst11|inst1|altsyncram_component|q_a[0]\,
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I1|Mux_41_rtl_211~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2392\);

\rtl~1877_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~1877\ = \inst1|I1|i~2\ & \inst1|I1|add_27~0\ & !\inst1|I2|pc_mux_x[2]~26\ & \inst1|I1|Mux_41_rtl_211~0\

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
	dataa => \inst1|I1|i~2\,
	datab => \inst1|I1|add_27~0\,
	datac => \inst1|I2|pc_mux_x[2]~26\,
	datad => \inst1|I1|Mux_41_rtl_211~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1877\);

\inst1|I1|Mux_55_rtl_36_rtl_316~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_55_rtl_36_rtl_316~0\ = \inst1|I2|pc_mux_x[0]~167\ & (\inst1|I1|pc[0]\ # \inst1|I2|pc_mux_x[1]~49\) # !\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|add_27~0\ & !\inst1|I2|pc_mux_x[1]~49\

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
	dataa => \inst1|I1|add_27~0\,
	datab => \inst1|I1|pc[0]\,
	datac => \inst1|I2|pc_mux_x[0]~167\,
	datad => \inst1|I2|pc_mux_x[1]~49\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_55_rtl_36_rtl_316~0\);

\rtl~993\ : cyclone_lcell 
-- Equation(s):
-- \rtl~336\ = LCELL(\inst|altsyncram_component|q_a[4]\ & (\rtl~336\ # \inst1|I1|Mux_67~0\) # !\inst|altsyncram_component|q_a[4]\ & \rtl~336\ & !\inst1|I1|Mux_67~0\)

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
	dataa => \inst|altsyncram_component|q_a[4]\,
	datac => \rtl~336\,
	datad => \inst1|I1|Mux_67~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~336\);

\inst1|I1|Mux_55_rtl_36_rtl_316~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|Mux_55_rtl_36_rtl_316~1\ = \inst1|I1|Mux_55_rtl_36_rtl_316~0\ & (\inst11|inst1|altsyncram_component|q_a[0]\ # !\inst1|I2|pc_mux_x[1]~49\) # !\inst1|I1|Mux_55_rtl_36_rtl_316~0\ & \inst1|I2|pc_mux_x[1]~49\ & \rtl~336\

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
	dataa => \inst1|I2|pc_mux_x[1]~49\,
	datab => \inst11|inst1|altsyncram_component|q_a[0]\,
	datac => \inst1|I1|Mux_55_rtl_36_rtl_316~0\,
	datad => \rtl~336\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|Mux_55_rtl_36_rtl_316~1\);

\rtl~2391_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2391\ = \rtl~2392\ # \rtl~1877\ # \inst1|I1|Mux_67~8\ & \inst1|I1|Mux_55_rtl_36_rtl_316~1\

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
	dataa => \inst1|I1|Mux_67~8\,
	datab => \rtl~2392\,
	datac => \rtl~1877\,
	datad => \inst1|I1|Mux_55_rtl_36_rtl_316~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2391\);

\inst1|I1|iaddr_x[9]~875_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[9]~875\ = \inst1|I1|add_27~9\ & (\inst1|I2|pc_mux_x[0]~167\ # \inst1|I1|pc[9]\) # !\inst1|I1|add_27~9\ & !\inst1|I2|pc_mux_x[0]~167\ & \inst1|I1|pc[9]\

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
	dataa => \inst1|I1|add_27~9\,
	datac => \inst1|I2|pc_mux_x[0]~167\,
	datad => \inst1|I1|pc[9]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[9]~875\);

\inst1|I1|iaddr_x[9]~885_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[9]~885\ = \inst1|I2|pc_mux_x[1]~49\ & \inst|altsyncram_component|q_a[13]\ # !\inst1|I2|pc_mux_x[1]~49\ & \inst1|I1|iaddr_x[9]~875\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F5A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|pc_mux_x[1]~49\,
	datac => \inst|altsyncram_component|q_a[13]\,
	datad => \inst1|I1|iaddr_x[9]~875\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[9]~885\);

\inst1|I1|iaddr_x[9]~890_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I1|iaddr_x[9]~890\ = \inst1|I2|pc_mux_x[2]~26\ & (\inst11|inst1|altsyncram_component|q_a[9]\ # !\inst1|I1|Mux_41_rtl_211~0\) # !\inst1|I2|pc_mux_x[2]~26\ & \inst1|I1|iaddr_x[9]~885\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BF8C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst11|inst1|altsyncram_component|q_a[9]\,
	datab => \inst1|I2|pc_mux_x[2]~26\,
	datac => \inst1|I1|Mux_41_rtl_211~0\,
	datad => \inst1|I1|iaddr_x[9]~885\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I1|iaddr_x[9]~890\);

\inst2|i~46_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~46\ = \inst1|I1|i~2\ & \inst1|I1|iaddr_x[9]~890\ # !\inst1|I4|ndre_x~1\ # !\inst2|i~1057\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DF5F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst2|i~1057\,
	datab => \inst1|I1|i~2\,
	datac => \inst1|I4|ndre_x~1\,
	datad => \inst1|I1|iaddr_x[9]~890\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~46\);

\inst1|I4|data_ox[9]~9_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_ox[9]~9\ = \inst1|I3|acc_c[0][9]\ & \nreset_in~combout\ & \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\

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
	dataa => \inst1|I3|acc_c[0][9]\,
	datac => \nreset_in~combout\,
	datad => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_ox[9]~9\);

\inst1|I4|data_ox[12]~6_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_ox[12]~6\ = \nreset_in~combout\ & \inst1|I3|acc_c[0][12]\ & \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\

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
	dataa => \nreset_in~combout\,
	datab => \inst1|I3|acc_c[0][12]\,
	datad => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_ox[12]~6\);

\inst1|I4|data_ox[10]~8_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_ox[10]~8\ = \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ & \inst1|I3|acc_c[0][10]\ & \nreset_in~combout\

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
	datab => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	datac => \inst1|I3|acc_c[0][10]\,
	datad => \nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_ox[10]~8\);

\inst|altsyncram_component|ram_block[0][13]\ : cyclone_ram_block 
-- pragma translate_off
GENERIC MAP (
	mem8 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem7 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000",
	mem6 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem5 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000",
	mem4 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem3 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000",
	mem2 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000010011000",
	operation_mode => "single_port",
	ram_block_type => "auto",
	logical_ram_name => "lpm_ram_dq:inst|altsyncram:altsyncram_component|ALTSYNCRAM INSTANTIATION",
	init_file => "../rom.mif",
	init_file_layout => "port_a",
	data_interleave_width_in_bits => 1,
	data_interleave_offset_in_bits => 1,
	port_a_byte_enable_clock => "none",
	port_a_logical_ram_depth => 1024,
	port_a_logical_ram_width => 16,
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
	portawe => \inst3|nWE_RAM_c\,
	clk0 => \clk_in~combout\,
	ena0 => VCC,
	portaaddr => \ww_inst|altsyncram_component|ram_block[0][13]_aaddress\,
	portadatain => \ww_inst|altsyncram_component|ram_block[0][13]_adatain\,
	devclrn => devclrn,
	devpor => devpor,
	portadataout => \ww_inst|altsyncram_component|ram_block[0][13]_adataout\);

\inst1|I2|data_is_c[8]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|idata_x[12]~51\ = \inst1|I2|E_x.dwait_e~0\ & K1_data_is_c[8] # !\inst1|I2|E_x.dwait_e~0\ & \inst|altsyncram_component|q_a[12]\
-- \inst1|I2|data_is_c[8]\ = DFFEA(\inst1|I2|idata_x[12]~51\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "F3C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I2|E_x.dwait_e~0\,
	datad => \inst|altsyncram_component|q_a[12]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|idata_x[12]~51\,
	regout => \inst1|I2|data_is_c[8]\);

\DATA_IN_EXT[8]~I\ : cyclone_io 
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
	padio => ww_DATA_IN_EXT(8),
	combout => \DATA_IN_EXT[8]~combout\);

\inst1|I3|data_x[8]~945_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[8]~945\ = \inst1|I3|data_x[6]~3456\ & (\inst3|mux_c[0]\ & \DATA_IN_EXT[8]~combout\ # !\inst3|mux_c[0]\ & \inst|altsyncram_component|q_a[8]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AC00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \DATA_IN_EXT[8]~combout\,
	datab => \inst|altsyncram_component|q_a[8]\,
	datac => \inst3|mux_c[0]\,
	datad => \inst1|I3|data_x[6]~3456\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[8]~945\);

\inst1|I4|data_exp_i[8]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iadata_x[20]~20\ = \inst1|I4|dexp_we_c\ & \inst1|I3|acc_c[0][8]\ # !\inst1|I4|dexp_we_c\ & \inst1|I4|data_exp_c[8]\ & \inst1|I4|i~38\
-- \inst1|I4|data_exp_i[8]\ = DFFEA(\inst1|I4|iadata_x[20]~20\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][8]\,
	datab => \inst1|I4|dexp_we_c\,
	datac => \inst1|I4|data_exp_c[8]\,
	datad => \inst1|I4|i~38\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iadata_x[20]~20\,
	regout => \inst1|I4|data_exp_i[8]\);

\inst1|I4|data_exp_c[8]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_exp_c[8]\ = DFFEA(\inst1|I4|iadata_x[20]~20\ & (\inst1|I4|data_exp_i[8]\ # !\inst1|I2|int_stop_x~11\) # !\inst1|I4|iadata_x[20]~20\ & \inst1|I4|data_exp_i[8]\ & \inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0AA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|iadata_x[20]~20\,
	datac => \inst1|I4|data_exp_i[8]\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|data_exp_c[8]\);

\inst1|I3|data_x[8]~3802_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[8]~3802\ = \inst1|I4|ireg_c[8]\ & (\inst1|I4|iinc_c[8]\ & \inst1|I3|data_x[9]~3459\ # !\inst1|I4|reduce_nor_207\) # !\inst1|I4|ireg_c[8]\ & \inst1|I4|iinc_c[8]\ & \inst1|I3|data_x[9]~3459\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CE0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ireg_c[8]\,
	datab => \inst1|I4|iinc_c[8]\,
	datac => \inst1|I4|reduce_nor_207\,
	datad => \inst1|I3|data_x[9]~3459\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[8]~3802\);

\inst1|I3|data_x[8]~2881_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[8]~2881\ = \inst1|I3|data_x[9]~3458\ & (\inst1|I3|data_x[8]~3802\ # \inst1|I4|data_exp_c[8]\ & \inst1|I3|data_x[9]~3457\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E0C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|data_exp_c[8]\,
	datab => \inst1|I3|data_x[8]~3802\,
	datac => \inst1|I3|data_x[9]~3458\,
	datad => \inst1|I3|data_x[9]~3457\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[8]~2881\);

\inst1|I3|data_x[8]~3830_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[8]~3830\ = \inst1|I3|data_x[8]~945\ # \inst1|I3|data_x[8]~2881\ # !\inst1|I3|reduce_nor_95\ & \inst1|I2|data_is_c[8]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|reduce_nor_95\,
	datab => \inst1|I2|data_is_c[8]\,
	datac => \inst1|I3|data_x[8]~945\,
	datad => \inst1|I3|data_x[8]~2881\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[8]~3830\);

\rtl~14387_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14387\ = \rtl~13588\ & (\inst1|I3|data_x[8]~3830\ $ (\inst1|I2|TD_c[0]\ & \inst1|I3|acc_c[0][8]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2A80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~13588\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \inst1|I3|acc_c[0][8]\,
	datad => \inst1|I3|data_x[8]~3830\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14387\);

\rtl~2800_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2800\ = \inst1|I2|TD_c[2]\ & (\inst1|I2|TD_c[1]\ $ \inst1|I3|acc_c[0][8]\) # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][7]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3ACA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][7]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I2|TD_c[2]\,
	datad => \inst1|I3|acc_c[0][8]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2800\);

\rtl~2615_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2615\ = \inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][9]\ & !\inst1|I2|TD_c[2]\ # !\inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][9]\ # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][8]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2B28",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][9]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I2|TD_c[2]\,
	datad => \inst1|I3|acc_c[0][8]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2615\);

\rtl~2805_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2805\ = \inst1|I2|TD_c[0]\ & \rtl~2800\ # !\inst1|I2|TD_c[0]\ & \rtl~2615\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DD88",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datab => \rtl~2800\,
	datad => \rtl~2615\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2805\);

\inst1|I3|Mux_258_rtl_122_rtl_403~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_258_rtl_122_rtl_403~0\ = \inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[0]\ # \inst1|I3|add_225~9\) # !\inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[0]\ & \inst1|I3|add_185~8\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FA44",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I3|add_185~8\,
	datac => \inst1|I3|add_225~9\,
	datad => \inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_258_rtl_122_rtl_403~0\);

\inst1|I3|Mux_258_rtl_122_rtl_403~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_258_rtl_122_rtl_403~1\ = \inst1|I3|data_x[8]~3830\ & (\inst1|I3|Mux_258_rtl_122_rtl_403~0\ # \inst1|I3|acc_c[0][8]\ & \inst1|I2|TD_c[0]\) # !\inst1|I3|data_x[8]~3830\ & \inst1|I3|Mux_258_rtl_122_rtl_403~0\ & (\inst1|I3|acc_c[0][8]\ # !\inst1|I2|TD_c[0]\)

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
	dataa => \inst1|I3|data_x[8]~3830\,
	datab => \inst1|I3|acc_c[0][8]\,
	datac => \inst1|I2|TD_c[0]\,
	datad => \inst1|I3|Mux_258_rtl_122_rtl_403~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_258_rtl_122_rtl_403~1\);

\rtl~14365_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14365\ = \rtl~13596\ & (\inst1|I3|Mux_258_rtl_122_rtl_403~1\ # \rtl~13900\ & \inst1|I3|acc_c[0][8]\) # !\rtl~13596\ & \rtl~13900\ & \inst1|I3|acc_c[0][8]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EAC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~13596\,
	datab => \rtl~13900\,
	datac => \inst1|I3|acc_c[0][8]\,
	datad => \inst1|I3|Mux_258_rtl_122_rtl_403~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14365\);

\rtl~14370_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14370\ = \rtl~14365\ # \rtl~2805\ & (\inst1|I2|TC_c[0]\ $ !\inst1|I2|TC_c[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF90",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TC_c[0]\,
	datab => \inst1|I2|TC_c[1]\,
	datac => \rtl~2805\,
	datad => \rtl~14365\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14370\);

\inst1|I3|acc_c[0][8]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][8]~216\ = \inst1|I3|acc[0][8]~8294\ # \inst1|I3|acc[0][13]~8146\ & (\rtl~14387\ # \rtl~14370\)
-- \inst1|I3|acc_c[0][8]\ = DFFEA(\inst1|I3|acc[0][8]~216\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FCF8",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \rtl~14387\,
	datab => \inst1|I3|acc[0][13]~8146\,
	datac => \inst1|I3|acc[0][8]~8294\,
	datad => \rtl~14370\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][8]~216\,
	regout => \inst1|I3|acc_c[0][8]\);

\inst1|I3|acc_i[0][8]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][8]~8294\ = \inst1|I3|acc_c[0][8]\ & (\inst1|I3|acc[0][13]~111\ # \inst1|I3|acc[0][13]~8147\ & L1_acc_i[0][8]) # !\inst1|I3|acc_c[0][8]\ & \inst1|I3|acc[0][13]~8147\ & L1_acc_i[0][8]

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][8]\,
	datab => \inst1|I3|acc[0][13]~8147\,
	datac => \inst1|I3|acc[0][8]~216\,
	datad => \inst1|I3|acc[0][13]~111\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][8]~8294\);

\inst1|I4|add_205_rtl_595~82_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~82\ = \inst1|I4|add_205~8\ & (\inst1|I4|ireg_c[8]\ # \inst1|I4|i~2616\) # !\inst1|I4|add_205~8\ & \inst1|I4|ireg_c[8]\ & !\inst1|I4|i~2616\

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
	dataa => \inst1|I4|add_205~8\,
	datab => \inst1|I4|ireg_c[8]\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~82\);

\inst1|I4|ireg_i[8]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~87\ = \inst1|I4|ireg_we_c\ & \inst1|I3|acc_c[0][8]\ # !\inst1|I4|ireg_we_c\ & \inst1|I4|i~38\ & \inst1|I4|add_205_rtl_595~82\
-- \inst1|I4|ireg_i[8]\ = DFFEA(\inst1|I4|add_205_rtl_595~87\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|i~38\,
	datab => \inst1|I4|ireg_we_c\,
	datac => \inst1|I3|acc_c[0][8]\,
	datad => \inst1|I4|add_205_rtl_595~82\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~87\,
	regout => \inst1|I4|ireg_i[8]\);

\inst1|I4|ireg_c[8]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ireg_c[8]\ = DFFEA(\inst1|I4|ireg_i[8]\ & (\inst1|I4|add_205_rtl_595~87\ # \inst1|I2|int_stop_x~11\) # !\inst1|I4|ireg_i[8]\ & \inst1|I4|add_205_rtl_595~87\ & !\inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CCF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|ireg_i[8]\,
	datac => \inst1|I4|add_205_rtl_595~87\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|ireg_c[8]\);

\inst1|I4|daddr_x[8]~79_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|daddr_x[8]~79\ = \inst1|I4|i~38\ & (\inst1|I2|idata_x[12]~51\ # \inst1|I4|ireg_c[8]\ & \inst1|I4|i~2616\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C8C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ireg_c[8]\,
	datab => \inst1|I4|i~38\,
	datac => \inst1|I2|idata_x[12]~51\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|daddr_x[8]~79\);

\inst2|daddr_c[8]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|daddr_c[8]\ = DFFEA(\inst2|a2vi_s\ & (\inst4|dwait_c\ & \inst2|daddr_c[8]\ # !\inst4|dwait_c\ & \inst1|I4|daddr_x[8]~79\) # !\inst2|a2vi_s\ & \inst1|I4|daddr_x[8]~79\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "B8F0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst2|daddr_c[8]\,
	datab => \inst2|a2vi_s\,
	datac => \inst1|I4|daddr_x[8]~79\,
	datad => \inst4|dwait_c\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst2|daddr_c[8]\);

\inst2|i~280_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~280\ = \inst4|dwait_c\ & \inst2|daddr_c[8]\ # !\inst4|dwait_c\ & (\inst2|nadwe_c\ & \inst2|daddr_c[8]\ # !\inst2|nadwe_c\ & \inst1|I1|iaddr_x[8]~178\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ABA8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst2|daddr_c[8]\,
	datab => \inst4|dwait_c\,
	datac => \inst2|nadwe_c\,
	datad => \inst1|I1|iaddr_x[8]~178\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~280\);

\inst2|i~285_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~285\ = \inst1|I4|ndre_x~1\ & \inst2|i~280\ # !\inst1|I4|ndre_x~1\ & \inst1|I4|daddr_x[8]~79\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FC30",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst1|I4|ndre_x~1\,
	datac => \inst1|I4|daddr_x[8]~79\,
	datad => \inst2|i~280\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~285\);

\inst1|I3|data_x[15]~82_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[15]~82\ = \DATA_IN_EXT[15]~combout\ & (\inst3|mux_c[0]\ # \inst|altsyncram_component|q_a[15]\) # !\DATA_IN_EXT[15]~combout\ & !\inst3|mux_c[0]\ & \inst|altsyncram_component|q_a[15]\

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
	dataa => \DATA_IN_EXT[15]~combout\,
	datac => \inst3|mux_c[0]\,
	datad => \inst|altsyncram_component|q_a[15]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[15]~82\);

\inst1|I3|data_x[15]~87_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[15]~87\ = \inst1|I3|reduce_nor_95\ & \inst1|I3|data_x[15]~82\ & \inst1|I3|data_x[13]~3460\ # !\inst1|I3|reduce_nor_95\ & (\inst1|I4|data_exp_x[3]~5\ # \inst1|I3|data_x[15]~82\ & \inst1|I3|data_x[13]~3460\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F444",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|reduce_nor_95\,
	datab => \inst1|I4|data_exp_x[3]~5\,
	datac => \inst1|I3|data_x[15]~82\,
	datad => \inst1|I3|data_x[13]~3460\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[15]~87\);

\rtl~1506_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~1506\ = \inst1|I2|TD_c[0]\ & \rtl~13588\ & (\inst1|I3|acc_c[0][15]\ $ \inst1|I3|data_x[15]~87\)

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
	dataa => \inst1|I3|acc_c[0][15]\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \rtl~13588\,
	datad => \inst1|I3|data_x[15]~87\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1506\);

\rtl~2560_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2560\ = \inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][16]\ # !\inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][16]\ # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][15]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "7160",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[1]\,
	datab => \inst1|I2|TD_c[2]\,
	datac => \inst1|I3|acc_c[0][16]\,
	datad => \inst1|I3|acc_c[0][15]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2560\);

\rtl~2750_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2750\ = \inst1|I2|TD_c[2]\ & (\inst1|I3|acc_c[0][15]\ $ \inst1|I2|TD_c[1]\) # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][14]\

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
	dataa => \inst1|I3|acc_c[0][15]\,
	datab => \inst1|I2|TD_c[2]\,
	datac => \inst1|I2|TD_c[1]\,
	datad => \inst1|I3|acc_c[0][14]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2750\);

\rtl~2231_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2231\ = !\inst1|I3|Mux_297_rtl_171~0\ & (\inst1|I2|TD_c[0]\ & \rtl~2750\ # !\inst1|I2|TD_c[0]\ & \rtl~2560\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3210",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I3|Mux_297_rtl_171~0\,
	datac => \rtl~2560\,
	datad => \rtl~2750\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2231\);

\inst1|I3|add_225~16_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_225~16\ = \inst1|I3|acc_c[0][15]\ $ \inst1|I3|data_x[15]~87\ $ !(!\inst1|I3|add_225~13COUT\ & \inst1|I3|add_225~15COUT0\) # (\inst1|I3|add_225~13COUT\ & \inst1|I3|add_225~15COUT1\)
-- \inst1|I3|add_225~16COUT0\ = CARRY(\inst1|I3|acc_c[0][15]\ & \inst1|I3|data_x[15]~87\ & !\inst1|I3|add_225~15COUT0\ # !\inst1|I3|acc_c[0][15]\ & (\inst1|I3|data_x[15]~87\ # !\inst1|I3|add_225~15COUT0\))
-- \inst1|I3|add_225~16COUT1\ = CARRY(\inst1|I3|acc_c[0][15]\ & \inst1|I3|data_x[15]~87\ & !\inst1|I3|add_225~15COUT1\ # !\inst1|I3|acc_c[0][15]\ & (\inst1|I3|data_x[15]~87\ # !\inst1|I3|add_225~15COUT1\))

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
	dataa => \inst1|I3|acc_c[0][15]\,
	datab => \inst1|I3|data_x[15]~87\,
	cin => \inst1|I3|add_225~13COUT\,
	cin0 => \inst1|I3|add_225~15COUT0\,
	cin1 => \inst1|I3|add_225~15COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_225~16\,
	cout0 => \inst1|I3|add_225~16COUT0\,
	cout1 => \inst1|I3|add_225~16COUT1\);

\inst1|I3|add_185~15_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_185~15\ = \inst1|I3|acc_c[0][15]\ $ \inst1|I3|data_x[15]~87\ $ (!\inst1|I3|add_185~12COUT\ & \inst1|I3|add_185~14COUT0\) # (\inst1|I3|add_185~12COUT\ & \inst1|I3|add_185~14COUT1\)
-- \inst1|I3|add_185~15COUT0\ = CARRY(\inst1|I3|acc_c[0][15]\ & !\inst1|I3|data_x[15]~87\ & !\inst1|I3|add_185~14COUT0\ # !\inst1|I3|acc_c[0][15]\ & (!\inst1|I3|add_185~14COUT0\ # !\inst1|I3|data_x[15]~87\))
-- \inst1|I3|add_185~15COUT1\ = CARRY(\inst1|I3|acc_c[0][15]\ & !\inst1|I3|data_x[15]~87\ & !\inst1|I3|add_185~14COUT1\ # !\inst1|I3|acc_c[0][15]\ & (!\inst1|I3|add_185~14COUT1\ # !\inst1|I3|data_x[15]~87\))

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
	dataa => \inst1|I3|acc_c[0][15]\,
	datab => \inst1|I3|data_x[15]~87\,
	cin => \inst1|I3|add_185~12COUT\,
	cin0 => \inst1|I3|add_185~14COUT0\,
	cin1 => \inst1|I3|add_185~14COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_185~15\,
	cout0 => \inst1|I3|add_185~15COUT0\,
	cout1 => \inst1|I3|add_185~15COUT1\);

\inst1|I3|Mux_251_rtl_92_rtl_373~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_251_rtl_92_rtl_373~0\ = \inst1|I2|TD_c[1]\ & (\inst1|I3|add_225~16\ # \inst1|I2|TD_c[0]\) # !\inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[0]\ & \inst1|I3|add_185~15\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ADA8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[1]\,
	datab => \inst1|I3|add_225~16\,
	datac => \inst1|I2|TD_c[0]\,
	datad => \inst1|I3|add_185~15\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_251_rtl_92_rtl_373~0\);

\inst1|I3|Mux_251_rtl_92_rtl_373~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_251_rtl_92_rtl_373~1\ = \inst1|I3|acc_c[0][15]\ & (\inst1|I3|Mux_251_rtl_92_rtl_373~0\ # \inst1|I2|TD_c[0]\ & \inst1|I3|data_x[15]~87\) # !\inst1|I3|acc_c[0][15]\ & \inst1|I3|Mux_251_rtl_92_rtl_373~0\ & (\inst1|I3|data_x[15]~87\ # !\inst1|I2|TD_c[0]\)

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
	dataa => \inst1|I3|acc_c[0][15]\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \inst1|I3|data_x[15]~87\,
	datad => \inst1|I3|Mux_251_rtl_92_rtl_373~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_251_rtl_92_rtl_373~1\);

\rtl~14148_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14148\ = \inst1|I3|acc_c[0][15]\ & (\rtl~13900\ # \rtl~13596\ & \inst1|I3|Mux_251_rtl_92_rtl_373~1\) # !\inst1|I3|acc_c[0][15]\ & \rtl~13596\ & \inst1|I3|Mux_251_rtl_92_rtl_373~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ECA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][15]\,
	datab => \rtl~13596\,
	datac => \rtl~13900\,
	datad => \inst1|I3|Mux_251_rtl_92_rtl_373~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14148\);

\rtl~14170_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14170\ = \rtl~2231\ # \rtl~14148\ # \rtl~13592\ & \inst1|I3|data_x[15]~87\

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
	dataa => \rtl~13592\,
	datab => \rtl~2231\,
	datac => \inst1|I3|data_x[15]~87\,
	datad => \rtl~14148\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14170\);

\inst1|I3|acc_c[0][15]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][15]~166\ = \inst1|I3|acc[0][15]~8244\ # \inst1|I3|acc[0][13]~8146\ & (\rtl~1506\ # \rtl~14170\)
-- \inst1|I3|acc_c[0][15]\ = DFFEA(\inst1|I3|acc[0][15]~166\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FAEA",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][15]~8244\,
	datab => \rtl~1506\,
	datac => \inst1|I3|acc[0][13]~8146\,
	datad => \rtl~14170\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][15]~166\,
	regout => \inst1|I3|acc_c[0][15]\);

\inst1|I3|acc_i[0][15]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][15]~8244\ = \inst1|I3|acc_c[0][15]\ & (\inst1|I3|acc[0][13]~111\ # L1_acc_i[0][15] & \inst1|I3|acc[0][13]~8147\) # !\inst1|I3|acc_c[0][15]\ & L1_acc_i[0][15] & \inst1|I3|acc[0][13]~8147\

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][15]\,
	datab => \inst1|I3|acc[0][13]~111\,
	datac => \inst1|I3|acc[0][15]~166\,
	datad => \inst1|I3|acc[0][13]~8147\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][15]~8244\);

\rtl~3100_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~3100\ = \inst1|I2|TD_c[0]\ & \inst1|I3|acc_c[0][15]\ # !\inst1|I2|TD_c[0]\ & \inst1|I3|acc_c[0][0]\ & \inst1|I2|TD_c[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F808",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][0]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I2|TD_c[0]\,
	datad => \inst1|I3|acc_c[0][15]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~3100\);

\rtl~3108_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~3108\ = !\inst1|I2|TD_c[2]\ & \rtl~3100\ & (\inst1|I2|TC_c[0]\ $ !\inst1|I2|TC_c[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2100",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TC_c[0]\,
	datab => \inst1|I2|TD_c[2]\,
	datac => \inst1|I2|TC_c[1]\,
	datad => \rtl~3100\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~3108\);

\inst1|I3|acc_c[0][16]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][16]~106\ = \inst1|I3|acc[0][16]~8145\ & (\rtl~2877\ # \inst1|I3|acc[0][13]~111\ & L1_acc_c[0][16]) # !\inst1|I3|acc[0][16]~8145\ & \inst1|I3|acc[0][13]~111\ & L1_acc_c[0][16]
-- \inst1|I3|acc_c[0][16]\ = DFFEA(\inst1|I3|acc[0][16]~106\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "EAC0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][16]~8145\,
	datab => \inst1|I3|acc[0][13]~111\,
	datad => \rtl~2877\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][16]~106\,
	regout => \inst1|I3|acc_c[0][16]\);

\rtl~13603_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13603\ = \inst1|I2|TD_c[0]\ & (\inst1|I2|TC_c[1]\ $ !\inst1|I2|TC_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A050",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TC_c[1]\,
	datac => \inst1|I2|TD_c[0]\,
	datad => \inst1|I2|TC_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13603\);

\rtl~3106_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~3106\ = \inst1|I3|acc_c[0][16]\ & !\inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[2]\ $ !\rtl~13603\)

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
	dataa => \inst1|I3|acc_c[0][16]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I2|TD_c[2]\,
	datad => \rtl~13603\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~3106\);

\inst1|I3|add_225~17_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_225~17\ = !(!\inst1|I3|add_225~13COUT\ & \inst1|I3|add_225~16COUT0\) # (\inst1|I3|add_225~13COUT\ & \inst1|I3|add_225~16COUT1\)

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
	cin => \inst1|I3|add_225~13COUT\,
	cin0 => \inst1|I3|add_225~16COUT0\,
	cin1 => \inst1|I3|add_225~16COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_225~17\);

\inst1|I3|add_185~16_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|add_185~16\ = !(!\inst1|I3|add_185~12COUT\ & \inst1|I3|add_185~15COUT0\) # (\inst1|I3|add_185~12COUT\ & \inst1|I3|add_185~15COUT1\)

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
	cin => \inst1|I3|add_185~12COUT\,
	cin0 => \inst1|I3|add_185~15COUT0\,
	cin1 => \inst1|I3|add_185~15COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|add_185~16\);

\rtl~3095_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~3095\ = \inst1|I2|TD_c[1]\ & !\inst1|I3|add_225~17\ # !\inst1|I2|TD_c[1]\ & \inst1|I3|add_185~16\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5F0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[1]\,
	datac => \inst1|I3|add_225~17\,
	datad => \inst1|I3|add_185~16\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~3095\);

\rtl~13872_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13872\ = \rtl~3106\ # \rtl~13596\ & !\inst1|I2|TD_c[0]\ & \rtl~3095\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AEAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~3106\,
	datab => \rtl~13596\,
	datac => \inst1|I2|TD_c[0]\,
	datad => \rtl~3095\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13872\);

\inst1|I3|acc_i[0][16]~I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2877\ = \inst1|I2|TC_c[2]\ & L1_acc_i[0][16] # !\inst1|I2|TC_c[2]\ & (\rtl~3108\ # \rtl~13872\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "F5E4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I2|TC_c[2]\,
	datab => \rtl~3108\,
	datac => \inst1|I3|acc[0][16]~106\,
	datad => \rtl~13872\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2877\);

\rtl~2856_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2856\ = \inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][1]\ & !\inst1|I2|TD_c[0]\ # !\inst1|I2|TD_c[2]\ & \inst1|I2|TD_c[0]\ & \inst1|I3|acc_c[0][16]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "5808",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[2]\,
	datab => \inst1|I3|acc_c[0][1]\,
	datac => \inst1|I2|TD_c[0]\,
	datad => \inst1|I3|acc_c[0][16]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2856\);

\rtl~2855_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2855\ = \rtl~2856\ # \inst1|I3|acc_c[0][0]\ & (\inst1|I2|TD_c[2]\ $ !\inst1|I2|TD_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF90",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[2]\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \inst1|I3|acc_c[0][0]\,
	datad => \rtl~2856\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2855\);

\rtl~2861_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2861\ = \inst1|I2|TD_c[2]\ & \inst1|I2|TD_c[0]\ & !\inst1|I3|acc_c[0][0]\ & \inst1|I2|TD_c[1]\

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
	dataa => \inst1|I2|TD_c[2]\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \inst1|I3|acc_c[0][0]\,
	datad => \inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2861\);

\rtl~2866_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2866\ = !\inst1|I3|Mux_297_rtl_171~0\ & (\rtl~2861\ # !\inst1|I2|TD_c[1]\ & \rtl~2855\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0F04",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[1]\,
	datab => \rtl~2855\,
	datac => \inst1|I3|Mux_297_rtl_171~0\,
	datad => \rtl~2861\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2866\);

\inst1|I3|Mux_266_rtl_152_rtl_433~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_266_rtl_152_rtl_433~0\ = \inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[0]\ # \inst1|I3|add_225~1\) # !\inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[0]\ & \inst1|I3|add_185~0\

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
	dataa => \inst1|I2|TD_c[1]\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \inst1|I3|add_225~1\,
	datad => \inst1|I3|add_185~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_266_rtl_152_rtl_433~0\);

\inst1|I3|Mux_266_rtl_152_rtl_433~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_266_rtl_152_rtl_433~1\ = \inst1|I3|acc_c[0][0]\ & (\inst1|I3|Mux_266_rtl_152_rtl_433~0\ # \inst1|I2|TD_c[0]\ & \inst1|I3|data_x[0]~4040\) # !\inst1|I3|acc_c[0][0]\ & \inst1|I3|Mux_266_rtl_152_rtl_433~0\ & (\inst1|I3|data_x[0]~4040\ # !\inst1|I2|TD_c[0]\)

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
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I3|acc_c[0][0]\,
	datac => \inst1|I3|data_x[0]~4040\,
	datad => \inst1|I3|Mux_266_rtl_152_rtl_433~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_266_rtl_152_rtl_433~1\);

\rtl~14621_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14621\ = \rtl~13900\ & (\inst1|I3|acc_c[0][0]\ # \rtl~13596\ & \inst1|I3|Mux_266_rtl_152_rtl_433~1\) # !\rtl~13900\ & \rtl~13596\ & \inst1|I3|Mux_266_rtl_152_rtl_433~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~13900\,
	datab => \inst1|I3|acc_c[0][0]\,
	datac => \rtl~13596\,
	datad => \inst1|I3|Mux_266_rtl_152_rtl_433~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14621\);

\inst1|I3|Mux_150_rtl_149_rtl_429~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_150_rtl_149_rtl_429~0\ = \inst1|I2|TD_c[0]\ $ \inst1|I2|TD_c[2]\

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
	datac => \inst1|I2|TD_c[0]\,
	datad => \inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_150_rtl_149_rtl_429~0\);

\rtl~14580_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14580\ = \inst1|I2|TD_c[0]\ & \inst1|I3|add_185~0\

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
	datac => \inst1|I2|TD_c[0]\,
	datad => \inst1|I3|add_185~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14580\);

\rtl~14592_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14592\ = \inst1|I3|Mux_297_rtl_171~0\ & \rtl~14580\ # !\inst1|I3|Mux_297_rtl_171~0\ & !\inst1|I3|Mux_150_rtl_149_rtl_429~0\ & \inst1|I3|acc_c[0][1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DC10",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|Mux_150_rtl_149_rtl_429~0\,
	datab => \inst1|I3|Mux_297_rtl_171~0\,
	datac => \inst1|I3|acc_c[0][1]\,
	datad => \rtl~14580\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14592\);

\rtl~2373_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2373\ = \rtl~14592\ # !\inst1|I2|TD_c[0]\ & \inst1|I3|Mux_297_rtl_171~0\ & \inst1|I3|data_x[0]~4040\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF40",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I3|Mux_297_rtl_171~0\,
	datac => \inst1|I3|data_x[0]~4040\,
	datad => \rtl~14592\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2373\);

\rtl~2865_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2865\ = \rtl~2866\ # \rtl~14621\ # \rtl~13595\ & \rtl~2373\

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
	dataa => \rtl~13595\,
	datab => \rtl~2866\,
	datac => \rtl~14621\,
	datad => \rtl~2373\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2865\);

\inst1|I3|acc_c[0][0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][0]~266\ = \inst1|I3|acc[0][0]~8344\ # \inst1|I3|acc[0][16]~8145\ & !\inst1|I2|TC_c[2]\ & \rtl~2865\
-- \inst1|I3|acc_c[0][0]\ = DFFEA(\inst1|I3|acc[0][0]~266\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AEAA",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][0]~8344\,
	datab => \inst1|I3|acc[0][16]~8145\,
	datac => \inst1|I2|TC_c[2]\,
	datad => \rtl~2865\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][0]~266\,
	regout => \inst1|I3|acc_c[0][0]\);

\inst1|I3|acc_i[0][0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][0]~8344\ = \inst1|I3|acc[0][13]~111\ & (\inst1|I3|acc_c[0][0]\ # L1_acc_i[0][0] & \inst1|I3|acc[0][13]~8147\) # !\inst1|I3|acc[0][13]~111\ & L1_acc_i[0][0] & \inst1|I3|acc[0][13]~8147\

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][13]~111\,
	datab => \inst1|I3|acc_c[0][0]\,
	datac => \inst1|I3|acc[0][0]~266\,
	datad => \inst1|I3|acc[0][13]~8147\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][0]~8344\);

\inst1|I4|iinc_i[0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_x[0]~35\ = \inst1|I4|iinc_we_c\ & \inst1|I3|acc_c[0][0]\ # !\inst1|I4|iinc_we_c\ & \inst1|I4|iinc_c[0]\ & \inst1|I4|i~38\
-- \inst1|I4|iinc_i[0]\ = DFFEA(\inst1|I4|iinc_x[0]~35\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F088",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|iinc_c[0]\,
	datab => \inst1|I4|i~38\,
	datac => \inst1|I3|acc_c[0][0]\,
	datad => \inst1|I4|iinc_we_c\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iinc_x[0]~35\,
	regout => \inst1|I4|iinc_i[0]\);

\inst1|I4|iinc_c[0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_c[0]\ = DFFEA(\inst1|I4|iinc_i[0]\ & (\inst1|I4|iinc_x[0]~35\ # \inst1|I2|int_stop_x~11\) # !\inst1|I4|iinc_i[0]\ & \inst1|I4|iinc_x[0]~35\ & !\inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AAF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|iinc_i[0]\,
	datac => \inst1|I4|iinc_x[0]~35\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|iinc_c[0]\);

\inst1|I4|add_205~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205~0\ = \inst1|I4|iinc_c[0]\ $ \inst1|I4|ireg_c[0]\
-- \inst1|I4|add_205~0COUT\ = CARRY(\inst1|I4|iinc_c[0]\ & \inst1|I4|ireg_c[0]\)

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
	dataa => \inst1|I4|iinc_c[0]\,
	datab => \inst1|I4|ireg_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205~0\,
	cout => \inst1|I4|add_205~0COUT\);

\inst1|I4|add_205~5_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205~5\ = \inst1|I4|iinc_c[5]\ $ \inst1|I4|ireg_c[5]\ $ (!\inst1|I4|add_205~0COUT\ & \inst1|I4|add_205~4COUT0\) # (\inst1|I4|add_205~0COUT\ & \inst1|I4|add_205~4COUT1\)
-- \inst1|I4|add_205~5COUT\ = CARRY(\inst1|I4|iinc_c[5]\ & !\inst1|I4|ireg_c[5]\ & !\inst1|I4|add_205~4COUT1\ # !\inst1|I4|iinc_c[5]\ & (!\inst1|I4|add_205~4COUT1\ # !\inst1|I4|ireg_c[5]\))

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
	dataa => \inst1|I4|iinc_c[5]\,
	datab => \inst1|I4|ireg_c[5]\,
	cin => \inst1|I4|add_205~0COUT\,
	cin0 => \inst1|I4|add_205~4COUT0\,
	cin1 => \inst1|I4|add_205~4COUT1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205~5\,
	cout => \inst1|I4|add_205~5COUT\);

\inst1|I4|add_205_rtl_595~112_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~112\ = \inst1|I4|ireg_c[5]\ & (\inst1|I4|add_205~5\ # !\inst1|I4|i~2616\) # !\inst1|I4|ireg_c[5]\ & \inst1|I4|add_205~5\ & \inst1|I4|i~2616\

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
	dataa => \inst1|I4|ireg_c[5]\,
	datab => \inst1|I4|add_205~5\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~112\);

\inst1|I4|ireg_i[5]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~117\ = \inst1|I4|ireg_we_c\ & \inst1|I3|acc_c[0][5]\ # !\inst1|I4|ireg_we_c\ & \inst1|I4|i~38\ & \inst1|I4|add_205_rtl_595~112\
-- \inst1|I4|ireg_i[5]\ = DFFEA(\inst1|I4|add_205_rtl_595~117\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][5]\,
	datab => \inst1|I4|ireg_we_c\,
	datac => \inst1|I4|i~38\,
	datad => \inst1|I4|add_205_rtl_595~112\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~117\,
	regout => \inst1|I4|ireg_i[5]\);

\inst1|I4|ireg_c[5]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ireg_c[5]\ = DFFEA(\inst1|I4|ireg_i[5]\ & (\inst1|I2|int_stop_x~11\ # \inst1|I4|add_205_rtl_595~117\) # !\inst1|I4|ireg_i[5]\ & !\inst1|I2|int_stop_x~11\ & \inst1|I4|add_205_rtl_595~117\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BB88",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|ireg_i[5]\,
	datab => \inst1|I2|int_stop_x~11\,
	datad => \inst1|I4|add_205_rtl_595~117\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|ireg_c[5]\);

\inst1|I3|data_x[5]~3622_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[5]~3622\ = \inst1|I4|ireg_c[5]\ & (\inst1|I4|iinc_c[5]\ & \inst1|I3|data_x[9]~3459\ # !\inst1|I4|reduce_nor_207\) # !\inst1|I4|ireg_c[5]\ & \inst1|I4|iinc_c[5]\ & \inst1|I3|data_x[9]~3459\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CE0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ireg_c[5]\,
	datab => \inst1|I4|iinc_c[5]\,
	datac => \inst1|I4|reduce_nor_207\,
	datad => \inst1|I3|data_x[9]~3459\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[5]~3622\);

\inst1|I3|data_x[5]~2367_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[5]~2367\ = \inst1|I3|data_x[9]~3458\ & (\inst1|I3|data_x[5]~3622\ # \inst1|I4|data_exp_c[5]\ & \inst1|I3|data_x[9]~3457\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E0C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|data_exp_c[5]\,
	datab => \inst1|I3|data_x[5]~3622\,
	datac => \inst1|I3|data_x[9]~3458\,
	datad => \inst1|I3|data_x[9]~3457\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[5]~2367\);

\inst1|I3|data_x[5]~3650_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[5]~3650\ = \inst1|I3|data_x[5]~447\ # \inst1|I3|data_x[5]~2367\ # !\inst1|I3|reduce_nor_95\ & \inst1|I2|data_is_c[5]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|reduce_nor_95\,
	datab => \inst1|I2|data_is_c[5]\,
	datac => \inst1|I3|data_x[5]~447\,
	datad => \inst1|I3|data_x[5]~2367\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[5]~3650\);

\rtl~14082_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14082\ = \rtl~13588\ & (\inst1|I3|data_x[5]~3650\ $ (\inst1|I3|acc_c[0][5]\ & \inst1|I2|TD_c[0]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "60A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|data_x[5]~3650\,
	datab => \inst1|I3|acc_c[0][5]\,
	datac => \rtl~13588\,
	datad => \inst1|I2|TD_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14082\);

\rtl~2730_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2730\ = \inst1|I2|TD_c[2]\ & (\inst1|I2|TD_c[1]\ $ \inst1|I3|acc_c[0][5]\) # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][4]\

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
	dataa => \inst1|I3|acc_c[0][4]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I3|acc_c[0][5]\,
	datad => \inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2730\);

\rtl~2538_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2538\ = \inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][6]\ & !\inst1|I2|TD_c[2]\ # !\inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][6]\ # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][5]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "30E2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][5]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I3|acc_c[0][6]\,
	datad => \inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2538\);

\rtl~2735_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2735\ = \rtl~2730\ & (\rtl~2538\ # \inst1|I2|TD_c[0]\) # !\rtl~2730\ & \rtl~2538\ & !\inst1|I2|TD_c[0]\

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
	datab => \rtl~2730\,
	datac => \rtl~2538\,
	datad => \inst1|I2|TD_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2735\);

\inst1|I3|Mux_261_rtl_80_rtl_361~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_261_rtl_80_rtl_361~0\ = \inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[0]\ # \inst1|I3|add_225~6\) # !\inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[0]\ & \inst1|I3|add_185~5\

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
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I3|add_185~5\,
	datad => \inst1|I3|add_225~6\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_261_rtl_80_rtl_361~0\);

\inst1|I3|Mux_261_rtl_80_rtl_361~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_261_rtl_80_rtl_361~1\ = \inst1|I3|acc_c[0][5]\ & (\inst1|I3|Mux_261_rtl_80_rtl_361~0\ # \inst1|I2|TD_c[0]\ & \inst1|I3|data_x[5]~3650\) # !\inst1|I3|acc_c[0][5]\ & \inst1|I3|Mux_261_rtl_80_rtl_361~0\ & (\inst1|I3|data_x[5]~3650\ # !\inst1|I2|TD_c[0]\)

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
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I3|acc_c[0][5]\,
	datac => \inst1|I3|data_x[5]~3650\,
	datad => \inst1|I3|Mux_261_rtl_80_rtl_361~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_261_rtl_80_rtl_361~1\);

\rtl~14060_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14060\ = \inst1|I3|acc_c[0][5]\ & (\rtl~13900\ # \rtl~13596\ & \inst1|I3|Mux_261_rtl_80_rtl_361~1\) # !\inst1|I3|acc_c[0][5]\ & \rtl~13596\ & \inst1|I3|Mux_261_rtl_80_rtl_361~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][5]\,
	datab => \rtl~13900\,
	datac => \rtl~13596\,
	datad => \inst1|I3|Mux_261_rtl_80_rtl_361~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14060\);

\rtl~14065_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14065\ = \rtl~14060\ # \rtl~2735\ & (\inst1|I2|TC_c[0]\ $ !\inst1|I2|TC_c[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF84",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TC_c[0]\,
	datab => \rtl~2735\,
	datac => \inst1|I2|TC_c[1]\,
	datad => \rtl~14060\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14065\);

\inst1|I3|acc_c[0][5]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][5]~146\ = \inst1|I3|acc[0][5]~8224\ # \inst1|I3|acc[0][13]~8146\ & (\rtl~14082\ # \rtl~14065\)
-- \inst1|I3|acc_c[0][5]\ = DFFEA(\inst1|I3|acc[0][5]~146\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][13]~8146\,
	datab => \inst1|I3|acc[0][5]~8224\,
	datac => \rtl~14082\,
	datad => \rtl~14065\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][5]~146\,
	regout => \inst1|I3|acc_c[0][5]\);

\inst1|I3|acc_i[0][5]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][5]~8224\ = \inst1|I3|acc_c[0][5]\ & (\inst1|I3|acc[0][13]~111\ # \inst1|I3|acc[0][13]~8147\ & L1_acc_i[0][5]) # !\inst1|I3|acc_c[0][5]\ & \inst1|I3|acc[0][13]~8147\ & L1_acc_i[0][5]

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][5]\,
	datab => \inst1|I3|acc[0][13]~8147\,
	datac => \inst1|I3|acc[0][5]~146\,
	datad => \inst1|I3|acc[0][13]~111\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][5]~8224\);

\inst1|I4|iinc_i[5]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_x[5]~8\ = \inst1|I4|iinc_we_c\ & \inst1|I3|acc_c[0][5]\ # !\inst1|I4|iinc_we_c\ & \inst1|I4|iinc_c[5]\ & \inst1|I4|i~38\
-- \inst1|I4|iinc_i[5]\ = DFFEA(\inst1|I4|iinc_x[5]~8\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I4|iinc_c[5]\,
	datab => \inst1|I3|acc_c[0][5]\,
	datac => \inst1|I4|i~38\,
	datad => \inst1|I4|iinc_we_c\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iinc_x[5]~8\,
	regout => \inst1|I4|iinc_i[5]\);

\inst1|I4|iinc_c[5]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_c[5]\ = DFFEA(\inst1|I4|iinc_i[5]\ & (\inst1|I2|int_stop_x~11\ # \inst1|I4|iinc_x[5]~8\) # !\inst1|I4|iinc_i[5]\ & !\inst1|I2|int_stop_x~11\ & \inst1|I4|iinc_x[5]~8\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFA0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|iinc_i[5]\,
	datac => \inst1|I2|int_stop_x~11\,
	datad => \inst1|I4|iinc_x[5]~8\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|iinc_c[5]\);

\inst1|I4|add_205_rtl_595~92_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~92\ = \inst1|I4|add_205~7\ & (\inst1|I4|ireg_c[7]\ # \inst1|I4|i~2616\) # !\inst1|I4|add_205~7\ & \inst1|I4|ireg_c[7]\ & !\inst1|I4|i~2616\

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
	datab => \inst1|I4|add_205~7\,
	datac => \inst1|I4|ireg_c[7]\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~92\);

\inst1|I4|ireg_i[7]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~97\ = \inst1|I4|ireg_we_c\ & \inst1|I3|acc_c[0][7]\ # !\inst1|I4|ireg_we_c\ & \inst1|I4|i~38\ & \inst1|I4|add_205_rtl_595~92\
-- \inst1|I4|ireg_i[7]\ = DFFEA(\inst1|I4|add_205_rtl_595~97\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I4|ireg_we_c\,
	datab => \inst1|I3|acc_c[0][7]\,
	datac => \inst1|I4|i~38\,
	datad => \inst1|I4|add_205_rtl_595~92\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~97\,
	regout => \inst1|I4|ireg_i[7]\);

\inst1|I4|ireg_c[7]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ireg_c[7]\ = DFFEA(\inst1|I2|int_stop_x~11\ & \inst1|I4|ireg_i[7]\ # !\inst1|I2|int_stop_x~11\ & \inst1|I4|add_205_rtl_595~97\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F3C0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I2|int_stop_x~11\,
	datac => \inst1|I4|ireg_i[7]\,
	datad => \inst1|I4|add_205_rtl_595~97\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|ireg_c[7]\);

\inst1|I4|daddr_x[7]~86_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|daddr_x[7]~86\ = \inst1|I4|i~38\ & (\inst1|I2|idata_x[11]~54\ # \inst1|I4|ireg_c[7]\ & \inst1|I4|i~2616\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CC80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ireg_c[7]\,
	datab => \inst1|I4|i~38\,
	datac => \inst1|I4|i~2616\,
	datad => \inst1|I2|idata_x[11]~54\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|daddr_x[7]~86\);

\inst2|daddr_c[7]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|daddr_c[7]\ = DFFEA(\inst4|dwait_c\ & (\inst2|a2vi_s\ & \inst2|daddr_c[7]\ # !\inst2|a2vi_s\ & \inst1|I4|daddr_x[7]~86\) # !\inst4|dwait_c\ & \inst1|I4|daddr_x[7]~86\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst2|daddr_c[7]\,
	datab => \inst4|dwait_c\,
	datac => \inst2|a2vi_s\,
	datad => \inst1|I4|daddr_x[7]~86\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst2|daddr_c[7]\);

\inst2|i~270_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~270\ = \inst2|nadwe_c\ & \inst2|daddr_c[7]\ # !\inst2|nadwe_c\ & (\inst4|dwait_c\ & \inst2|daddr_c[7]\ # !\inst4|dwait_c\ & \inst1|I1|iaddr_x[7]~168\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CDC8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst2|nadwe_c\,
	datab => \inst2|daddr_c[7]\,
	datac => \inst4|dwait_c\,
	datad => \inst1|I1|iaddr_x[7]~168\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~270\);

\inst2|i~275_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~275\ = \inst1|I4|ndre_x~1\ & \inst2|i~270\ # !\inst1|I4|ndre_x~1\ & \inst1|I4|daddr_x[7]~86\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FC30",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst1|I4|ndre_x~1\,
	datac => \inst1|I4|daddr_x[7]~86\,
	datad => \inst2|i~270\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~275\);

\inst1|I2|data_is_c[6]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|idata_x[10]~57\ = \inst1|I2|E_x.dwait_e~0\ & K1_data_is_c[6] # !\inst1|I2|E_x.dwait_e~0\ & \inst|altsyncram_component|q_a[10]\
-- \inst1|I2|data_is_c[6]\ = DFFEA(\inst1|I2|idata_x[10]~57\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "F3C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I2|E_x.dwait_e~0\,
	datad => \inst|altsyncram_component|q_a[10]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|idata_x[10]~57\,
	regout => \inst1|I2|data_is_c[6]\);

\DATA_IN_EXT[6]~I\ : cyclone_io 
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
	padio => ww_DATA_IN_EXT(6),
	combout => \DATA_IN_EXT[6]~combout\);

\inst1|I3|data_x[6]~345_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[6]~345\ = \inst1|I3|data_x[6]~3456\ & (\inst3|mux_c[0]\ & \DATA_IN_EXT[6]~combout\ # !\inst3|mux_c[0]\ & \inst|altsyncram_component|q_a[6]\)

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
	dataa => \inst3|mux_c[0]\,
	datab => \DATA_IN_EXT[6]~combout\,
	datac => \inst|altsyncram_component|q_a[6]\,
	datad => \inst1|I3|data_x[6]~3456\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[6]~345\);

\inst1|I3|data_x[6]~3580_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[6]~3580\ = \inst1|I4|iinc_c[6]\ & (\inst1|I3|data_x[9]~3459\ # \inst1|I4|ireg_c[6]\ & !\inst1|I4|reduce_nor_207\) # !\inst1|I4|iinc_c[6]\ & \inst1|I4|ireg_c[6]\ & !\inst1|I4|reduce_nor_207\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AE0C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|iinc_c[6]\,
	datab => \inst1|I4|ireg_c[6]\,
	datac => \inst1|I4|reduce_nor_207\,
	datad => \inst1|I3|data_x[9]~3459\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[6]~3580\);

\inst1|I4|data_exp_i[6]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iadata_x[18]~5\ = \inst1|I4|dexp_we_c\ & \inst1|I3|acc_c[0][6]\ # !\inst1|I4|dexp_we_c\ & \inst1|I4|data_exp_c[6]\ & \inst1|I4|i~38\
-- \inst1|I4|data_exp_i[6]\ = DFFEA(\inst1|I4|iadata_x[18]~5\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|data_exp_c[6]\,
	datab => \inst1|I4|dexp_we_c\,
	datac => \inst1|I3|acc_c[0][6]\,
	datad => \inst1|I4|i~38\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iadata_x[18]~5\,
	regout => \inst1|I4|data_exp_i[6]\);

\inst1|I4|data_exp_c[6]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_exp_c[6]\ = DFFEA(\inst1|I4|iadata_x[18]~5\ & (\inst1|I4|data_exp_i[6]\ # !\inst1|I2|int_stop_x~11\) # !\inst1|I4|iadata_x[18]~5\ & \inst1|I4|data_exp_i[6]\ & \inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|iadata_x[18]~5\,
	datac => \inst1|I4|data_exp_i[6]\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|data_exp_c[6]\);

\inst1|I3|data_x[6]~2261_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[6]~2261\ = \inst1|I3|data_x[9]~3458\ & (\inst1|I3|data_x[6]~3580\ # \inst1|I4|data_exp_c[6]\ & \inst1|I3|data_x[9]~3457\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EA00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|data_x[6]~3580\,
	datab => \inst1|I4|data_exp_c[6]\,
	datac => \inst1|I3|data_x[9]~3457\,
	datad => \inst1|I3|data_x[9]~3458\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[6]~2261\);

\inst1|I3|data_x[6]~3608_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[6]~3608\ = \inst1|I3|data_x[6]~345\ # \inst1|I3|data_x[6]~2261\ # \inst1|I2|data_is_c[6]\ & !\inst1|I3|reduce_nor_95\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|data_is_c[6]\,
	datab => \inst1|I3|reduce_nor_95\,
	datac => \inst1|I3|data_x[6]~345\,
	datad => \inst1|I3|data_x[6]~2261\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[6]~3608\);

\rtl~14038_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14038\ = \rtl~13588\ & (\inst1|I3|data_x[6]~3608\ $ (\inst1|I2|TD_c[0]\ & \inst1|I3|acc_c[0][6]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4C80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datab => \rtl~13588\,
	datac => \inst1|I3|acc_c[0][6]\,
	datad => \inst1|I3|data_x[6]~3608\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14038\);

\rtl~2527_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2527\ = \inst1|I2|TD_c[2]\ & !\inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][7]\ # !\inst1|I2|TD_c[2]\ & (\inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][7]\ # !\inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][6]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "7610",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[2]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I3|acc_c[0][6]\,
	datad => \inst1|I3|acc_c[0][7]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2527\);

\rtl~2720_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2720\ = \inst1|I2|TD_c[2]\ & (\inst1|I2|TD_c[1]\ $ \inst1|I3|acc_c[0][6]\) # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][5]\

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
	dataa => \inst1|I3|acc_c[0][5]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I3|acc_c[0][6]\,
	datad => \inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2720\);

\rtl~2725_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2725\ = \inst1|I2|TD_c[0]\ & \rtl~2720\ # !\inst1|I2|TD_c[0]\ & \rtl~2527\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FC30",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst1|I2|TD_c[0]\,
	datac => \rtl~2527\,
	datad => \rtl~2720\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2725\);

\inst1|I3|Mux_260_rtl_74_rtl_355~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_260_rtl_74_rtl_355~0\ = \inst1|I2|TD_c[1]\ & (\inst1|I3|add_225~7\ # \inst1|I2|TD_c[0]\) # !\inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[0]\ & \inst1|I3|add_185~6\

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
	dataa => \inst1|I3|add_225~7\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \inst1|I2|TD_c[1]\,
	datad => \inst1|I3|add_185~6\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_260_rtl_74_rtl_355~0\);

\inst1|I3|Mux_260_rtl_74_rtl_355~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_260_rtl_74_rtl_355~1\ = \inst1|I3|acc_c[0][6]\ & (\inst1|I3|Mux_260_rtl_74_rtl_355~0\ # \inst1|I2|TD_c[0]\ & \inst1|I3|data_x[6]~3608\) # !\inst1|I3|acc_c[0][6]\ & \inst1|I3|Mux_260_rtl_74_rtl_355~0\ & (\inst1|I3|data_x[6]~3608\ # !\inst1|I2|TD_c[0]\)

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
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I3|acc_c[0][6]\,
	datac => \inst1|I3|data_x[6]~3608\,
	datad => \inst1|I3|Mux_260_rtl_74_rtl_355~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_260_rtl_74_rtl_355~1\);

\rtl~14016_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14016\ = \inst1|I3|acc_c[0][6]\ & (\rtl~13900\ # \rtl~13596\ & \inst1|I3|Mux_260_rtl_74_rtl_355~1\) # !\inst1|I3|acc_c[0][6]\ & \rtl~13596\ & \inst1|I3|Mux_260_rtl_74_rtl_355~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][6]\,
	datab => \rtl~13900\,
	datac => \rtl~13596\,
	datad => \inst1|I3|Mux_260_rtl_74_rtl_355~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14016\);

\rtl~14021_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14021\ = \rtl~14016\ # \rtl~2725\ & (\inst1|I2|TC_c[0]\ $ !\inst1|I2|TC_c[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF82",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~2725\,
	datab => \inst1|I2|TC_c[0]\,
	datac => \inst1|I2|TC_c[1]\,
	datad => \rtl~14016\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14021\);

\inst1|I3|acc_c[0][6]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][6]~136\ = \inst1|I3|acc[0][6]~8214\ # \inst1|I3|acc[0][13]~8146\ & (\rtl~14038\ # \rtl~14021\)
-- \inst1|I3|acc_c[0][6]\ = DFFEA(\inst1|I3|acc[0][6]~136\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FAEA",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][6]~8214\,
	datab => \rtl~14038\,
	datac => \inst1|I3|acc[0][13]~8146\,
	datad => \rtl~14021\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][6]~136\,
	regout => \inst1|I3|acc_c[0][6]\);

\inst1|I3|acc_i[0][6]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][6]~8214\ = \inst1|I3|acc[0][13]~111\ & (\inst1|I3|acc_c[0][6]\ # \inst1|I3|acc[0][13]~8147\ & L1_acc_i[0][6]) # !\inst1|I3|acc[0][13]~111\ & \inst1|I3|acc[0][13]~8147\ & L1_acc_i[0][6]

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][13]~111\,
	datab => \inst1|I3|acc[0][13]~8147\,
	datac => \inst1|I3|acc[0][6]~136\,
	datad => \inst1|I3|acc_c[0][6]\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][6]~8214\);

\inst1|I4|add_205_rtl_595~102_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~102\ = \inst1|I4|ireg_c[6]\ & (\inst1|I4|add_205~6\ # !\inst1|I4|i~2616\) # !\inst1|I4|ireg_c[6]\ & \inst1|I4|add_205~6\ & \inst1|I4|i~2616\

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
	dataa => \inst1|I4|ireg_c[6]\,
	datab => \inst1|I4|add_205~6\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~102\);

\inst1|I4|ireg_i[6]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~107\ = \inst1|I4|ireg_we_c\ & \inst1|I3|acc_c[0][6]\ # !\inst1|I4|ireg_we_c\ & \inst1|I4|i~38\ & \inst1|I4|add_205_rtl_595~102\
-- \inst1|I4|ireg_i[6]\ = DFFEA(\inst1|I4|add_205_rtl_595~107\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|i~38\,
	datab => \inst1|I4|ireg_we_c\,
	datac => \inst1|I3|acc_c[0][6]\,
	datad => \inst1|I4|add_205_rtl_595~102\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~107\,
	regout => \inst1|I4|ireg_i[6]\);

\inst1|I4|ireg_c[6]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ireg_c[6]\ = DFFEA(\inst1|I4|ireg_i[6]\ & (\inst1|I2|int_stop_x~11\ # \inst1|I4|add_205_rtl_595~107\) # !\inst1|I4|ireg_i[6]\ & !\inst1|I2|int_stop_x~11\ & \inst1|I4|add_205_rtl_595~107\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFA0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|ireg_i[6]\,
	datac => \inst1|I2|int_stop_x~11\,
	datad => \inst1|I4|add_205_rtl_595~107\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|ireg_c[6]\);

\inst1|I4|daddr_x[6]~93_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|daddr_x[6]~93\ = \inst1|I4|i~38\ & (\inst1|I2|idata_x[10]~57\ # \inst1|I4|ireg_c[6]\ & \inst1|I4|i~2616\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C8C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ireg_c[6]\,
	datab => \inst1|I4|i~38\,
	datac => \inst1|I2|idata_x[10]~57\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|daddr_x[6]~93\);

\inst2|daddr_c[6]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|daddr_c[6]\ = DFFEA(\inst2|a2vi_s\ & (\inst4|dwait_c\ & \inst2|daddr_c[6]\ # !\inst4|dwait_c\ & \inst1|I4|daddr_x[6]~93\) # !\inst2|a2vi_s\ & \inst1|I4|daddr_x[6]~93\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F780",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst2|a2vi_s\,
	datab => \inst4|dwait_c\,
	datac => \inst2|daddr_c[6]\,
	datad => \inst1|I4|daddr_x[6]~93\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst2|daddr_c[6]\);

\inst2|i~260_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~260\ = \inst2|nadwe_c\ & \inst2|daddr_c[6]\ # !\inst2|nadwe_c\ & (\inst4|dwait_c\ & \inst2|daddr_c[6]\ # !\inst4|dwait_c\ & \inst1|I1|iaddr_x[6]~158\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F1E0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst2|nadwe_c\,
	datab => \inst4|dwait_c\,
	datac => \inst2|daddr_c[6]\,
	datad => \inst1|I1|iaddr_x[6]~158\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~260\);

\inst2|i~265_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~265\ = \inst1|I4|ndre_x~1\ & \inst2|i~260\ # !\inst1|I4|ndre_x~1\ & \inst1|I4|daddr_x[6]~93\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F3C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst1|I4|ndre_x~1\,
	datac => \inst2|i~260\,
	datad => \inst1|I4|daddr_x[6]~93\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~265\);

\inst3|nCS_EXT_c~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|daddr_x[9]~72\ = \inst1|I4|i~38\ & (\inst1|I2|idata_x[13]~42\ # \inst1|I4|ireg_c[9]\ & \inst1|I4|i~2616\)
-- \inst3|nCS_EXT_c\ = DFFEA(\inst1|I4|daddr_x[9]~72\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "A888",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|i~38\,
	datab => \inst1|I2|idata_x[13]~42\,
	datac => \inst1|I4|ireg_c[9]\,
	datad => \inst1|I4|i~2616\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|daddr_x[9]~72\,
	regout => \inst3|nCS_EXT_c\);

\inst3|mux_c[0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[3]~1149\ = \inst1|I3|data_x[6]~3456\ & (E1_mux_c[0] & \DATA_IN_EXT[3]~combout\ # !E1_mux_c[0] & \inst|altsyncram_component|q_a[3]\)
-- \inst3|mux_c[0]\ = DFFEA(\inst1|I4|daddr_x[9]~72\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "AC00",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \DATA_IN_EXT[3]~combout\,
	datab => \inst|altsyncram_component|q_a[3]\,
	datac => \inst1|I4|daddr_x[9]~72\,
	datad => \inst1|I3|data_x[6]~3456\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[3]~1149\,
	regout => \inst3|mux_c[0]\);

\inst1|I3|data_x[13]~72_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[13]~72\ = \DATA_IN_EXT[13]~combout\ & (\inst3|mux_c[0]\ # \inst|altsyncram_component|q_a[13]\) # !\DATA_IN_EXT[13]~combout\ & !\inst3|mux_c[0]\ & \inst|altsyncram_component|q_a[13]\

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
	datab => \DATA_IN_EXT[13]~combout\,
	datac => \inst3|mux_c[0]\,
	datad => \inst|altsyncram_component|q_a[13]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[13]~72\);

\inst1|I3|data_x[13]~77_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[13]~77\ = \inst1|I3|reduce_nor_95\ & \inst1|I3|data_x[13]~72\ & \inst1|I3|data_x[13]~3460\ # !\inst1|I3|reduce_nor_95\ & (\inst1|I4|data_exp_x[1]~2\ # \inst1|I3|data_x[13]~72\ & \inst1|I3|data_x[13]~3460\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DC50",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|reduce_nor_95\,
	datab => \inst1|I3|data_x[13]~72\,
	datac => \inst1|I4|data_exp_x[1]~2\,
	datad => \inst1|I3|data_x[13]~3460\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[13]~77\);

\rtl~1331_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~1331\ = \rtl~13588\ & \inst1|I2|TD_c[0]\ & (\inst1|I3|acc_c[0][13]\ $ \inst1|I3|data_x[13]~77\)

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
	dataa => \rtl~13588\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \inst1|I3|acc_c[0][13]\,
	datad => \inst1|I3|data_x[13]~77\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1331\);

\rtl~2505_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2505\ = \inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][14]\ & !\inst1|I2|TD_c[2]\ # !\inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][14]\ # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][13]\)

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
	dataa => \inst1|I3|acc_c[0][14]\,
	datab => \inst1|I3|acc_c[0][13]\,
	datac => \inst1|I2|TD_c[1]\,
	datad => \inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2505\);

\rtl~2700_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2700\ = \inst1|I2|TD_c[2]\ & (\inst1|I2|TD_c[1]\ $ \inst1|I3|acc_c[0][13]\) # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][12]\

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
	dataa => \inst1|I2|TD_c[1]\,
	datab => \inst1|I3|acc_c[0][13]\,
	datac => \inst1|I2|TD_c[2]\,
	datad => \inst1|I3|acc_c[0][12]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2700\);

\rtl~2156_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2156\ = !\inst1|I3|Mux_297_rtl_171~0\ & (\inst1|I2|TD_c[0]\ & \rtl~2700\ # !\inst1|I2|TD_c[0]\ & \rtl~2505\)

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
	dataa => \rtl~2505\,
	datab => \inst1|I3|Mux_297_rtl_171~0\,
	datac => \inst1|I2|TD_c[0]\,
	datad => \rtl~2700\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2156\);

\inst1|I3|Mux_253_rtl_32_rtl_313~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_253_rtl_32_rtl_313~0\ = \inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[0]\ # \inst1|I3|add_225~14\) # !\inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[0]\ & \inst1|I3|add_185~13\

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
	dataa => \inst1|I2|TD_c[1]\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \inst1|I3|add_185~13\,
	datad => \inst1|I3|add_225~14\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_253_rtl_32_rtl_313~0\);

\inst1|I3|Mux_253_rtl_32_rtl_313~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_253_rtl_32_rtl_313~1\ = \inst1|I3|data_x[13]~77\ & (\inst1|I3|Mux_253_rtl_32_rtl_313~0\ # \inst1|I3|acc_c[0][13]\ & \inst1|I2|TD_c[0]\) # !\inst1|I3|data_x[13]~77\ & \inst1|I3|Mux_253_rtl_32_rtl_313~0\ & (\inst1|I3|acc_c[0][13]\ # !\inst1|I2|TD_c[0]\)

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
	dataa => \inst1|I3|data_x[13]~77\,
	datab => \inst1|I3|acc_c[0][13]\,
	datac => \inst1|I2|TD_c[0]\,
	datad => \inst1|I3|Mux_253_rtl_32_rtl_313~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_253_rtl_32_rtl_313~1\);

\rtl~13927_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13927\ = \inst1|I3|acc_c[0][13]\ & (\rtl~13900\ # \rtl~13596\ & \inst1|I3|Mux_253_rtl_32_rtl_313~1\) # !\inst1|I3|acc_c[0][13]\ & \rtl~13596\ & \inst1|I3|Mux_253_rtl_32_rtl_313~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ECA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][13]\,
	datab => \rtl~13596\,
	datac => \rtl~13900\,
	datad => \inst1|I3|Mux_253_rtl_32_rtl_313~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13927\);

\rtl~13949_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13949\ = \rtl~2156\ # \rtl~13927\ # \inst1|I3|data_x[13]~77\ & \rtl~13592\

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
	dataa => \inst1|I3|data_x[13]~77\,
	datab => \rtl~2156\,
	datac => \rtl~13592\,
	datad => \rtl~13927\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13949\);

\inst1|I3|acc_c[0][13]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][13]~116\ = \inst1|I3|acc[0][13]~8194\ # \inst1|I3|acc[0][13]~8146\ & (\rtl~1331\ # \rtl~13949\)
-- \inst1|I3|acc_c[0][13]\ = DFFEA(\inst1|I3|acc[0][13]~116\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][13]~8146\,
	datab => \inst1|I3|acc[0][13]~8194\,
	datac => \rtl~1331\,
	datad => \rtl~13949\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][13]~116\,
	regout => \inst1|I3|acc_c[0][13]\);

\inst1|I3|acc_i[0][13]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][13]~8194\ = \inst1|I3|acc[0][13]~111\ & (\inst1|I3|acc_c[0][13]\ # L1_acc_i[0][13] & \inst1|I3|acc[0][13]~8147\) # !\inst1|I3|acc[0][13]~111\ & L1_acc_i[0][13] & \inst1|I3|acc[0][13]~8147\

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][13]~111\,
	datab => \inst1|I3|acc_c[0][13]\,
	datac => \inst1|I3|acc[0][13]~116\,
	datad => \inst1|I3|acc[0][13]~8147\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][13]~8194\);

\inst1|I4|data_ox[13]~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_ox[13]~0\ = \nreset_in~combout\ & \inst1|I3|acc_c[0][13]\ & \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\

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
	dataa => \nreset_in~combout\,
	datac => \inst1|I3|acc_c[0][13]\,
	datad => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_ox[13]~0\);

\inst1|I4|daddr_x[5]~100_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|daddr_x[5]~100\ = \inst1|I4|i~38\ & (\inst1|I2|idata_x[9]~60\ # \inst1|I4|ireg_c[5]\ & \inst1|I4|i~2616\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E0A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|idata_x[9]~60\,
	datab => \inst1|I4|ireg_c[5]\,
	datac => \inst1|I4|i~38\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|daddr_x[5]~100\);

\inst2|daddr_c[5]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|daddr_c[5]\ = DFFEA(\inst4|dwait_c\ & (\inst2|a2vi_s\ & \inst2|daddr_c[5]\ # !\inst2|a2vi_s\ & \inst1|I4|daddr_x[5]~100\) # !\inst4|dwait_c\ & \inst1|I4|daddr_x[5]~100\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F780",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst4|dwait_c\,
	datab => \inst2|a2vi_s\,
	datac => \inst2|daddr_c[5]\,
	datad => \inst1|I4|daddr_x[5]~100\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst2|daddr_c[5]\);

\inst2|i~250_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~250\ = \inst2|nadwe_c\ & \inst2|daddr_c[5]\ # !\inst2|nadwe_c\ & (\inst4|dwait_c\ & \inst2|daddr_c[5]\ # !\inst4|dwait_c\ & \inst1|I1|iaddr_x[5]~148\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F1E0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst2|nadwe_c\,
	datab => \inst4|dwait_c\,
	datac => \inst2|daddr_c[5]\,
	datad => \inst1|I1|iaddr_x[5]~148\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~250\);

\inst2|i~255_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~255\ = \inst1|I4|ndre_x~1\ & \inst2|i~250\ # !\inst1|I4|ndre_x~1\ & \inst1|I4|daddr_x[5]~100\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FA50",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ndre_x~1\,
	datac => \inst1|I4|daddr_x[5]~100\,
	datad => \inst2|i~250\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~255\);

\inst1|I4|data_ox[8]~10_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_ox[8]~10\ = \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ & \inst1|I3|acc_c[0][8]\ & \nreset_in~combout\

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
	dataa => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	datac => \inst1|I3|acc_c[0][8]\,
	datad => \nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_ox[8]~10\);

\inst1|I4|data_ox[6]~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_ox[6]~1\ = \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ & \nreset_in~combout\ & \inst1|I3|acc_c[0][6]\

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
	datab => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	datac => \nreset_in~combout\,
	datad => \inst1|I3|acc_c[0][6]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_ox[6]~1\);

\inst1|I4|data_ox[4]~3_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_ox[4]~3\ = \nreset_in~combout\ & \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ & \inst1|I3|acc_c[0][4]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \nreset_in~combout\,
	datab => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	datac => \inst1|I3|acc_c[0][4]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_ox[4]~3\);

\inst|altsyncram_component|ram_block[0][7]\ : cyclone_ram_block 
-- pragma translate_off
GENERIC MAP (
	mem8 => "00101001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem7 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100100010111111101001110",
	mem6 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem5 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100001000001101001101111",
	mem4 => "00100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem3 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000",
	mem2 => "00000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101011011010110100001010",
	operation_mode => "single_port",
	ram_block_type => "auto",
	logical_ram_name => "lpm_ram_dq:inst|altsyncram:altsyncram_component|ALTSYNCRAM INSTANTIATION",
	init_file => "../rom.mif",
	init_file_layout => "port_a",
	data_interleave_width_in_bits => 1,
	data_interleave_offset_in_bits => 1,
	port_a_byte_enable_clock => "none",
	port_a_logical_ram_depth => 1024,
	port_a_logical_ram_width => 16,
	port_a_data_in_clear => "none",
	port_a_address_clear => "none",
	port_a_write_enable_clear => "none",
	port_a_byte_enable_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_out_clear => "none",
	port_a_first_address => 0,
	port_a_last_address => 1023,
	port_a_first_bit_number => 7,
	port_a_data_width => 4,
	port_a_address_width => 10)
-- pragma translate_on
PORT MAP (
	portawe => \inst3|nWE_RAM_c\,
	clk0 => \clk_in~combout\,
	ena0 => VCC,
	portaaddr => \ww_inst|altsyncram_component|ram_block[0][7]_aaddress\,
	portadatain => \ww_inst|altsyncram_component|ram_block[0][7]_adatain\,
	devclrn => devclrn,
	devpor => devpor,
	portadataout => \ww_inst|altsyncram_component|ram_block[0][7]_adataout\);

\inst1|I4|daddr_x[4]~107_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|daddr_x[4]~107\ = \inst1|I4|i~38\ & (\inst1|I2|idata_x[8]~63\ # \inst1|I4|ireg_c[4]\ & \inst1|I4|i~2616\)

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
	dataa => \inst1|I4|i~38\,
	datab => \inst1|I2|idata_x[8]~63\,
	datac => \inst1|I4|ireg_c[4]\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|daddr_x[4]~107\);

\inst2|daddr_c[4]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|daddr_c[4]\ = DFFEA(\inst2|a2vi_s\ & (\inst4|dwait_c\ & \inst2|daddr_c[4]\ # !\inst4|dwait_c\ & \inst1|I4|daddr_x[4]~107\) # !\inst2|a2vi_s\ & \inst1|I4|daddr_x[4]~107\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst2|daddr_c[4]\,
	datab => \inst2|a2vi_s\,
	datac => \inst4|dwait_c\,
	datad => \inst1|I4|daddr_x[4]~107\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst2|daddr_c[4]\);

\inst2|i~240_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~240\ = \inst4|dwait_c\ & \inst2|daddr_c[4]\ # !\inst4|dwait_c\ & (\inst2|nadwe_c\ & \inst2|daddr_c[4]\ # !\inst2|nadwe_c\ & \inst1|I1|iaddr_x[4]~138\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F1E0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst4|dwait_c\,
	datab => \inst2|nadwe_c\,
	datac => \inst2|daddr_c[4]\,
	datad => \inst1|I1|iaddr_x[4]~138\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~240\);

\inst2|i~245_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~245\ = \inst1|I4|daddr_x[4]~107\ & (\inst2|i~240\ # !\inst1|I4|ndre_x~1\) # !\inst1|I4|daddr_x[4]~107\ & \inst1|I4|ndre_x~1\ & \inst2|i~240\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FC0C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst1|I4|daddr_x[4]~107\,
	datac => \inst1|I4|ndre_x~1\,
	datad => \inst2|i~240\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~245\);

\inst1|I4|data_ox[1]~14_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_ox[1]~14\ = \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ & \inst1|I3|acc_c[0][1]\ & \nreset_in~combout\

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
	dataa => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	datac => \inst1|I3|acc_c[0][1]\,
	datad => \nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_ox[1]~14\);

\inst1|I4|data_ox[3]~12_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_ox[3]~12\ = \inst1|I3|acc_c[0][3]\ & \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ & \nreset_in~combout\

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
	dataa => \inst1|I3|acc_c[0][3]\,
	datac => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	datad => \nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_ox[3]~12\);

\inst1|I4|data_ox[0]~15_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_ox[0]~15\ = \nreset_in~combout\ & \inst1|I3|acc_c[0][0]\ & \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "8080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \nreset_in~combout\,
	datab => \inst1|I3|acc_c[0][0]\,
	datac => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_ox[0]~15\);

\inst|altsyncram_component|ram_block[0][2]\ : cyclone_ram_block 
-- pragma translate_off
GENERIC MAP (
	mem8 => "00001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem7 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000110000110001010100",
	mem6 => "00100101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem5 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000101101000001010",
	mem4 => "00000101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem3 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000110000010001010",
	mem2 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100001100001100000000",
	operation_mode => "single_port",
	ram_block_type => "auto",
	logical_ram_name => "lpm_ram_dq:inst|altsyncram:altsyncram_component|ALTSYNCRAM INSTANTIATION",
	init_file => "../rom.mif",
	init_file_layout => "port_a",
	data_interleave_width_in_bits => 1,
	data_interleave_offset_in_bits => 1,
	port_a_byte_enable_clock => "none",
	port_a_logical_ram_depth => 1024,
	port_a_logical_ram_width => 16,
	port_a_data_in_clear => "none",
	port_a_address_clear => "none",
	port_a_write_enable_clear => "none",
	port_a_byte_enable_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_out_clear => "none",
	port_a_first_address => 0,
	port_a_last_address => 1023,
	port_a_first_bit_number => 2,
	port_a_data_width => 4,
	port_a_address_width => 10)
-- pragma translate_on
PORT MAP (
	portawe => \inst3|nWE_RAM_c\,
	clk0 => \clk_in~combout\,
	ena0 => VCC,
	portaaddr => \ww_inst|altsyncram_component|ram_block[0][2]_aaddress\,
	portadatain => \ww_inst|altsyncram_component|ram_block[0][2]_adatain\,
	devclrn => devclrn,
	devpor => devpor,
	portadataout => \ww_inst|altsyncram_component|ram_block[0][2]_adataout\);

\inst1|I3|data_x[3]~3914_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|data_x[3]~3914\ = \inst1|I3|data_x[3]~3093\ # \inst1|I3|data_x[3]~1149\ # !\inst1|I3|reduce_nor_95\ & \inst1|I2|data_is_c[3]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FFF4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|reduce_nor_95\,
	datab => \inst1|I2|data_is_c[3]\,
	datac => \inst1|I3|data_x[3]~3093\,
	datad => \inst1|I3|data_x[3]~1149\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|data_x[3]~3914\);

\rtl~14475_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14475\ = \rtl~13588\ & (\inst1|I3|data_x[3]~3914\ $ (\inst1|I2|TD_c[0]\ & \inst1|I3|acc_c[0][3]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "7800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I3|acc_c[0][3]\,
	datac => \inst1|I3|data_x[3]~3914\,
	datad => \rtl~13588\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14475\);

\rtl~2820_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2820\ = \inst1|I2|TD_c[2]\ & (\inst1|I3|acc_c[0][3]\ $ \inst1|I2|TD_c[1]\) # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][2]\

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
	dataa => \inst1|I2|TD_c[2]\,
	datab => \inst1|I3|acc_c[0][3]\,
	datac => \inst1|I2|TD_c[1]\,
	datad => \inst1|I3|acc_c[0][2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2820\);

\rtl~2637_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2637\ = \inst1|I2|TD_c[2]\ & !\inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][4]\ # !\inst1|I2|TD_c[2]\ & (\inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][4]\ # !\inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][3]\)

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
	dataa => \inst1|I2|TD_c[2]\,
	datab => \inst1|I3|acc_c[0][3]\,
	datac => \inst1|I2|TD_c[1]\,
	datad => \inst1|I3|acc_c[0][4]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2637\);

\rtl~2825_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2825\ = \inst1|I2|TD_c[0]\ & \rtl~2820\ # !\inst1|I2|TD_c[0]\ & \rtl~2637\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F3C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst1|I2|TD_c[0]\,
	datac => \rtl~2820\,
	datad => \rtl~2637\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2825\);

\inst1|I3|Mux_263_rtl_134_rtl_415~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_263_rtl_134_rtl_415~0\ = \inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[0]\ # \inst1|I3|add_225~4\) # !\inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[0]\ & \inst1|I3|add_185~3\

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
	dataa => \inst1|I2|TD_c[1]\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \inst1|I3|add_225~4\,
	datad => \inst1|I3|add_185~3\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_263_rtl_134_rtl_415~0\);

\inst1|I3|Mux_263_rtl_134_rtl_415~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_263_rtl_134_rtl_415~1\ = \inst1|I3|acc_c[0][3]\ & (\inst1|I3|Mux_263_rtl_134_rtl_415~0\ # \inst1|I2|TD_c[0]\ & \inst1|I3|data_x[3]~3914\) # !\inst1|I3|acc_c[0][3]\ & \inst1|I3|Mux_263_rtl_134_rtl_415~0\ & (\inst1|I3|data_x[3]~3914\ # !\inst1|I2|TD_c[0]\)

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
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I3|acc_c[0][3]\,
	datac => \inst1|I3|data_x[3]~3914\,
	datad => \inst1|I3|Mux_263_rtl_134_rtl_415~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_263_rtl_134_rtl_415~1\);

\rtl~14453_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14453\ = \rtl~13900\ & (\inst1|I3|acc_c[0][3]\ # \rtl~13596\ & \inst1|I3|Mux_263_rtl_134_rtl_415~1\) # !\rtl~13900\ & \rtl~13596\ & \inst1|I3|Mux_263_rtl_134_rtl_415~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~13900\,
	datab => \inst1|I3|acc_c[0][3]\,
	datac => \rtl~13596\,
	datad => \inst1|I3|Mux_263_rtl_134_rtl_415~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14453\);

\rtl~14458_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14458\ = \rtl~14453\ # \rtl~2825\ & (\inst1|I2|TC_c[0]\ $ !\inst1|I2|TC_c[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF84",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TC_c[0]\,
	datab => \rtl~2825\,
	datac => \inst1|I2|TC_c[1]\,
	datad => \rtl~14453\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14458\);

\inst1|I3|acc_c[0][3]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][3]~236\ = \inst1|I3|acc[0][3]~8314\ # \inst1|I3|acc[0][13]~8146\ & (\rtl~14475\ # \rtl~14458\)
-- \inst1|I3|acc_c[0][3]\ = DFFEA(\inst1|I3|acc[0][3]~236\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FCEC",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \rtl~14475\,
	datab => \inst1|I3|acc[0][3]~8314\,
	datac => \inst1|I3|acc[0][13]~8146\,
	datad => \rtl~14458\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][3]~236\,
	regout => \inst1|I3|acc_c[0][3]\);

\inst1|I3|acc_i[0][3]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][3]~8314\ = \inst1|I3|acc[0][13]~111\ & (\inst1|I3|acc_c[0][3]\ # L1_acc_i[0][3] & \inst1|I3|acc[0][13]~8147\) # !\inst1|I3|acc[0][13]~111\ & L1_acc_i[0][3] & \inst1|I3|acc[0][13]~8147\

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][13]~111\,
	datab => \inst1|I3|acc_c[0][3]\,
	datac => \inst1|I3|acc[0][3]~236\,
	datad => \inst1|I3|acc[0][13]~8147\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][3]~8314\);

\inst1|I4|add_205_rtl_595~132_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~132\ = \inst1|I4|ireg_c[3]\ & (\inst1|I4|add_205~3\ # !\inst1|I4|i~2616\) # !\inst1|I4|ireg_c[3]\ & \inst1|I4|add_205~3\ & \inst1|I4|i~2616\

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
	dataa => \inst1|I4|ireg_c[3]\,
	datac => \inst1|I4|add_205~3\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~132\);

\inst1|I4|ireg_i[3]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~137\ = \inst1|I4|ireg_we_c\ & \inst1|I3|acc_c[0][3]\ # !\inst1|I4|ireg_we_c\ & \inst1|I4|i~38\ & \inst1|I4|add_205_rtl_595~132\
-- \inst1|I4|ireg_i[3]\ = DFFEA(\inst1|I4|add_205_rtl_595~137\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][3]\,
	datab => \inst1|I4|ireg_we_c\,
	datac => \inst1|I4|i~38\,
	datad => \inst1|I4|add_205_rtl_595~132\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~137\,
	regout => \inst1|I4|ireg_i[3]\);

\inst1|I4|ireg_c[3]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ireg_c[3]\ = DFFEA(\inst1|I2|int_stop_x~11\ & \inst1|I4|ireg_i[3]\ # !\inst1|I2|int_stop_x~11\ & \inst1|I4|add_205_rtl_595~137\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F3C0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I2|int_stop_x~11\,
	datac => \inst1|I4|ireg_i[3]\,
	datad => \inst1|I4|add_205_rtl_595~137\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|ireg_c[3]\);

\inst1|I4|daddr_x[3]~114_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|daddr_x[3]~114\ = \inst1|I4|i~38\ & (\inst1|I2|idata_x[7]~33\ # \inst1|I4|ireg_c[3]\ & \inst1|I4|i~2616\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C8C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ireg_c[3]\,
	datab => \inst1|I4|i~38\,
	datac => \inst1|I2|idata_x[7]~33\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|daddr_x[3]~114\);

\inst2|daddr_c[3]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|daddr_c[3]\ = DFFEA(\inst4|dwait_c\ & (\inst2|a2vi_s\ & \inst2|daddr_c[3]\ # !\inst2|a2vi_s\ & \inst1|I4|daddr_x[3]~114\) # !\inst4|dwait_c\ & \inst1|I4|daddr_x[3]~114\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "B8F0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst2|daddr_c[3]\,
	datab => \inst4|dwait_c\,
	datac => \inst1|I4|daddr_x[3]~114\,
	datad => \inst2|a2vi_s\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst2|daddr_c[3]\);

\inst2|i~230_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~230\ = \inst2|i~1057\ & \inst1|I1|i~2\ & \inst1|I1|iaddr_x[3]~1806\ # !\inst2|i~1057\ & \inst2|daddr_c[3]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "B830",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I1|i~2\,
	datab => \inst2|i~1057\,
	datac => \inst2|daddr_c[3]\,
	datad => \inst1|I1|iaddr_x[3]~1806\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~230\);

\inst2|i~235_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~235\ = \inst1|I4|ndre_x~1\ & \inst2|i~230\ # !\inst1|I4|ndre_x~1\ & \inst1|I4|daddr_x[3]~114\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FA50",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ndre_x~1\,
	datac => \inst1|I4|daddr_x[3]~114\,
	datad => \inst2|i~230\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~235\);

\inst1|I2|data_is_c[10]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|data_is_c[10]\ = DFFEA(\inst1|I2|data_is_c[10]\ & (\inst1|I2|E_x.dwait_e~0\ # \inst|altsyncram_component|q_a[14]\) # !\inst1|I2|data_is_c[10]\ & !\inst1|I2|E_x.dwait_e~0\ & \inst|altsyncram_component|q_a[14]\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFA0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I2|data_is_c[10]\,
	datac => \inst1|I2|E_x.dwait_e~0\,
	datad => \inst|altsyncram_component|q_a[14]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I2|data_is_c[10]\);

\inst1|I4|i~2639_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|i~2639\ = !\inst1|I2|idata_x[13]~42\ & (\inst1|I2|E_x.dwait_e~0\ & !\inst1|I2|data_is_c[11]\ # !\inst1|I2|E_x.dwait_e~0\ & !\inst|altsyncram_component|q_a[15]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0047",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|data_is_c[11]\,
	datab => \inst1|I2|E_x.dwait_e~0\,
	datac => \inst|altsyncram_component|q_a[15]\,
	datad => \inst1|I2|idata_x[13]~42\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|i~2639\);

\inst1|I4|i~2668_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|i~2668\ = !\inst1|I2|idata_x[11]~54\ & !\inst1|I2|idata_x[12]~51\ & !\inst1|I2|idata_x[9]~60\ & !\inst1|I2|idata_x[7]~33\

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
	dataa => \inst1|I2|idata_x[11]~54\,
	datab => \inst1|I2|idata_x[12]~51\,
	datac => \inst1|I2|idata_x[9]~60\,
	datad => \inst1|I2|idata_x[7]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|i~2668\);

\inst1|I4|i~2661_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|i~2661\ = \inst1|I4|i~2639\ & !\inst1|I2|idata_x[10]~57\ & !\inst1|I2|idata_x[8]~63\ & \inst1|I4|i~2668\

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
	dataa => \inst1|I4|i~2639\,
	datab => \inst1|I2|idata_x[10]~57\,
	datac => \inst1|I2|idata_x[8]~63\,
	datad => \inst1|I4|i~2668\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|i~2661\);

\inst1|I4|i~2671_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|i~2671\ = \inst1|I4|i~2661\ & (\inst1|I2|E_x.dwait_e~0\ & !\inst1|I2|data_is_c[10]\ # !\inst1|I2|E_x.dwait_e~0\ & !\inst|altsyncram_component|q_a[14]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4700",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|data_is_c[10]\,
	datab => \inst1|I2|E_x.dwait_e~0\,
	datac => \inst|altsyncram_component|q_a[14]\,
	datad => \inst1|I4|i~2661\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|i~2671\);

\inst1|I4|i~40_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|i~40\ = \inst1|I4|i~2671\ & (\inst1|I2|ndre_x~49\ # \inst1|I2|ndwe_x~51\ & !\inst1|I2|C_store_x~0\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F020",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|ndwe_x~51\,
	datab => \inst1|I2|C_store_x~0\,
	datac => \inst1|I4|i~2671\,
	datad => \inst1|I2|ndre_x~49\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|i~40\);

\inst1|I4|ireg_we_x~10_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ireg_we_x~10\ = \inst1|I4|ndwe_x~10\ & \inst1|I2|ndwe_x~51\ & \inst1|I4|i~40\

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
	dataa => \inst1|I4|ndwe_x~10\,
	datac => \inst1|I2|ndwe_x~51\,
	datad => \inst1|I4|i~40\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|ireg_we_x~10\);

\inst1|I4|iinc_we_c~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_we_c\ = DFFEA(!\inst1|I2|idata_x[4]~39\ & \inst1|I2|idata_x[5]~36\ & !\inst1|I2|idata_x[6]~30\ & \inst1|I4|ireg_we_x~10\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0400",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I2|idata_x[4]~39\,
	datab => \inst1|I2|idata_x[5]~36\,
	datac => \inst1|I2|idata_x[6]~30\,
	datad => \inst1|I4|ireg_we_x~10\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|iinc_we_c\);

\inst1|I4|iinc_i[2]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_x[2]~29\ = \inst1|I4|iinc_we_c\ & \inst1|I3|acc_c[0][2]\ # !\inst1|I4|iinc_we_c\ & \inst1|I4|i~38\ & \inst1|I4|iinc_c[2]\
-- \inst1|I4|iinc_i[2]\ = DFFEA(\inst1|I4|iinc_x[2]~29\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F088",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|i~38\,
	datab => \inst1|I4|iinc_c[2]\,
	datac => \inst1|I3|acc_c[0][2]\,
	datad => \inst1|I4|iinc_we_c\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|iinc_x[2]~29\,
	regout => \inst1|I4|iinc_i[2]\);

\inst1|I4|iinc_c[2]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|iinc_c[2]\ = DFFEA(\inst1|I4|iinc_x[2]~29\ & (\inst1|I4|iinc_i[2]\ # !\inst1|I2|int_stop_x~11\) # !\inst1|I4|iinc_x[2]~29\ & \inst1|I4|iinc_i[2]\ & \inst1|I2|int_stop_x~11\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F0CC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|iinc_x[2]~29\,
	datac => \inst1|I4|iinc_i[2]\,
	datad => \inst1|I2|int_stop_x~11\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|iinc_c[2]\);

\inst1|I4|add_205_rtl_595~142_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~142\ = \inst1|I4|add_205~2\ & (\inst1|I4|ireg_c[2]\ # \inst1|I4|i~2616\) # !\inst1|I4|add_205~2\ & \inst1|I4|ireg_c[2]\ & !\inst1|I4|i~2616\

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
	dataa => \inst1|I4|add_205~2\,
	datab => \inst1|I4|ireg_c[2]\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~142\);

\inst1|I4|ireg_i[2]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~147\ = \inst1|I4|ireg_we_c\ & \inst1|I3|acc_c[0][2]\ # !\inst1|I4|ireg_we_c\ & \inst1|I4|i~38\ & \inst1|I4|add_205_rtl_595~142\
-- \inst1|I4|ireg_i[2]\ = DFFEA(\inst1|I4|add_205_rtl_595~147\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][2]\,
	datab => \inst1|I4|ireg_we_c\,
	datac => \inst1|I4|i~38\,
	datad => \inst1|I4|add_205_rtl_595~142\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~147\,
	regout => \inst1|I4|ireg_i[2]\);

\inst1|I4|ireg_c[2]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ireg_c[2]\ = DFFEA(\inst1|I4|ireg_i[2]\ & (\inst1|I2|int_stop_x~11\ # \inst1|I4|add_205_rtl_595~147\) # !\inst1|I4|ireg_i[2]\ & !\inst1|I2|int_stop_x~11\ & \inst1|I4|add_205_rtl_595~147\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CFC0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I4|ireg_i[2]\,
	datac => \inst1|I2|int_stop_x~11\,
	datad => \inst1|I4|add_205_rtl_595~147\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|ireg_c[2]\);

\inst1|I4|daddr_x[2]~121_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|daddr_x[2]~121\ = \inst1|I4|i~38\ & (\inst1|I2|idata_x[6]~30\ # \inst1|I4|ireg_c[2]\ & \inst1|I4|i~2616\)

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
	dataa => \inst1|I4|i~38\,
	datab => \inst1|I2|idata_x[6]~30\,
	datac => \inst1|I4|ireg_c[2]\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|daddr_x[2]~121\);

\inst2|daddr_c[2]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|daddr_c[2]\ = DFFEA(\inst2|a2vi_s\ & (\inst4|dwait_c\ & \inst2|daddr_c[2]\ # !\inst4|dwait_c\ & \inst1|I4|daddr_x[2]~121\) # !\inst2|a2vi_s\ & \inst1|I4|daddr_x[2]~121\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst2|daddr_c[2]\,
	datab => \inst2|a2vi_s\,
	datac => \inst4|dwait_c\,
	datad => \inst1|I4|daddr_x[2]~121\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst2|daddr_c[2]\);

\inst2|i~220_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~220\ = \inst2|nadwe_c\ & \inst2|daddr_c[2]\ # !\inst2|nadwe_c\ & (\inst4|dwait_c\ & \inst2|daddr_c[2]\ # !\inst4|dwait_c\ & \inst1|I1|iaddr_x[2]~391\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CDC8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst2|nadwe_c\,
	datab => \inst2|daddr_c[2]\,
	datac => \inst4|dwait_c\,
	datad => \inst1|I1|iaddr_x[2]~391\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~220\);

\inst2|i~225_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~225\ = \inst1|I4|ndre_x~1\ & \inst2|i~220\ # !\inst1|I4|ndre_x~1\ & \inst1|I4|daddr_x[2]~121\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FC30",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst1|I4|ndre_x~1\,
	datac => \inst1|I4|daddr_x[2]~121\,
	datad => \inst2|i~220\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~225\);

\inst1|I2|idata_c[1]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|idata_x[1]~24\ = \inst1|I2|E_x.dwait_e~0\ & K1_idata_c[1] # !\inst1|I2|E_x.dwait_e~0\ & \inst|altsyncram_component|q_a[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "F3C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I2|E_x.dwait_e~0\,
	datad => \inst|altsyncram_component|q_a[1]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|idata_x[1]~24\);

\inst1|I2|idata_c[2]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|TD_x[3]~35\ = !\inst1|I2|idata_x[1]~24\ & (\inst1|I2|E_x.dwait_e~0\ & !K1_idata_c[2] # !\inst1|I2|E_x.dwait_e~0\ & !\inst|altsyncram_component|q_a[2]\)
-- \inst1|I2|idata_c[2]\ = DFFEA(\inst1|I2|idata_x[2]~27\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "001B",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I2|E_x.dwait_e~0\,
	datab => \inst|altsyncram_component|q_a[2]\,
	datac => \inst1|I2|idata_x[2]~27\,
	datad => \inst1|I2|idata_x[1]~24\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|TD_x[3]~35\,
	regout => \inst1|I2|idata_c[2]\);

\inst1|I2|idata_x[2]~27_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|idata_x[2]~27\ = \inst1|I2|idata_c[2]\ & (\inst1|I2|E_x.dwait_e~0\ # \inst|altsyncram_component|q_a[2]\) # !\inst1|I2|idata_c[2]\ & !\inst1|I2|E_x.dwait_e~0\ & \inst|altsyncram_component|q_a[2]\

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
	datab => \inst1|I2|idata_c[2]\,
	datac => \inst1|I2|E_x.dwait_e~0\,
	datad => \inst|altsyncram_component|q_a[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|idata_x[2]~27\);

\inst1|I2|Mux_76~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|Mux_76~0\ = \inst1|I2|idata_x[6]~30\ & !\inst1|I2|idata_x[7]~33\ & (!\inst1|I2|idata_x[5]~36\ # !\inst1|I2|idata_x[4]~39\) # !\inst1|I2|idata_x[6]~30\ & \inst1|I2|idata_x[4]~39\ & \inst1|I2|idata_x[5]~36\ & \inst1|I2|idata_x[7]~33\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "204C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|idata_x[4]~39\,
	datab => \inst1|I2|idata_x[6]~30\,
	datac => \inst1|I2|idata_x[5]~36\,
	datad => \inst1|I2|idata_x[7]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|Mux_76~0\);

\inst1|I2|TD_c[2]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|TD_c[2]\ = DFFEA(\inst1|I2|idata_x[2]~27\ # \inst1|I2|Mux_76~0\ & !\inst1|I2|idata_x[1]~24\ & \rtl~13594\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I2|idata_x[2]~27\,
	datab => \inst1|I2|Mux_76~0\,
	datac => \inst1|I2|idata_x[1]~24\,
	datad => \rtl~13594\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I2|TD_c[2]\);

\rtl~13588_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13588\ = !\inst1|I2|TD_c[2]\ & \inst1|I2|TD_c[1]\ & (\inst1|I2|TC_c[0]\ $ \inst1|I2|TC_c[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "1200",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TC_c[0]\,
	datab => \inst1|I2|TD_c[2]\,
	datac => \inst1|I2|TC_c[1]\,
	datad => \inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13588\);

\rtl~14299_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14299\ = \rtl~13588\ & (\inst1|I3|data_x[11]~3746\ $ (\inst1|I3|acc_c[0][11]\ & \inst1|I2|TD_c[0]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "7080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][11]\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \rtl~13588\,
	datad => \inst1|I3|data_x[11]~3746\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14299\);

\rtl~2593_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2593\ = \inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][12]\ # !\inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][12]\ # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][11]\)

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
	dataa => \inst1|I2|TD_c[1]\,
	datab => \inst1|I3|acc_c[0][11]\,
	datac => \inst1|I2|TD_c[2]\,
	datad => \inst1|I3|acc_c[0][12]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2593\);

\rtl~2780_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2780\ = \inst1|I2|TD_c[2]\ & (\inst1|I3|acc_c[0][11]\ $ \inst1|I2|TD_c[1]\) # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][10]\

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
	dataa => \inst1|I3|acc_c[0][10]\,
	datab => \inst1|I3|acc_c[0][11]\,
	datac => \inst1|I2|TD_c[1]\,
	datad => \inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2780\);

\rtl~2785_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2785\ = \rtl~2593\ & (\rtl~2780\ # !\inst1|I2|TD_c[0]\) # !\rtl~2593\ & \inst1|I2|TD_c[0]\ & \rtl~2780\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EE22",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~2593\,
	datab => \inst1|I2|TD_c[0]\,
	datad => \rtl~2780\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2785\);

\inst1|I3|Mux_255_rtl_110_rtl_391~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_255_rtl_110_rtl_391~0\ = \inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[0]\ # \inst1|I3|add_225~12\) # !\inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[0]\ & \inst1|I3|add_185~11\

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
	dataa => \inst1|I2|TD_c[1]\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \inst1|I3|add_185~11\,
	datad => \inst1|I3|add_225~12\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_255_rtl_110_rtl_391~0\);

\inst1|I3|Mux_255_rtl_110_rtl_391~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_255_rtl_110_rtl_391~1\ = \inst1|I3|acc_c[0][11]\ & (\inst1|I3|Mux_255_rtl_110_rtl_391~0\ # \inst1|I2|TD_c[0]\ & \inst1|I3|data_x[11]~3746\) # !\inst1|I3|acc_c[0][11]\ & \inst1|I3|Mux_255_rtl_110_rtl_391~0\ & (\inst1|I3|data_x[11]~3746\ # !\inst1|I2|TD_c[0]\)

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
	dataa => \inst1|I3|acc_c[0][11]\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \inst1|I3|data_x[11]~3746\,
	datad => \inst1|I3|Mux_255_rtl_110_rtl_391~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_255_rtl_110_rtl_391~1\);

\rtl~14277_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14277\ = \inst1|I3|acc_c[0][11]\ & (\rtl~13900\ # \rtl~13596\ & \inst1|I3|Mux_255_rtl_110_rtl_391~1\) # !\inst1|I3|acc_c[0][11]\ & \rtl~13596\ & \inst1|I3|Mux_255_rtl_110_rtl_391~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ECA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][11]\,
	datab => \rtl~13596\,
	datac => \rtl~13900\,
	datad => \inst1|I3|Mux_255_rtl_110_rtl_391~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14277\);

\rtl~14282_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14282\ = \rtl~14277\ # \rtl~2785\ & (\inst1|I2|TC_c[1]\ $ !\inst1|I2|TC_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF84",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TC_c[1]\,
	datab => \rtl~2785\,
	datac => \inst1|I2|TC_c[0]\,
	datad => \rtl~14277\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14282\);

\inst1|I3|acc_c[0][11]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][11]~196\ = \inst1|I3|acc[0][11]~8274\ # \inst1|I3|acc[0][13]~8146\ & (\rtl~14299\ # \rtl~14282\)
-- \inst1|I3|acc_c[0][11]\ = DFFEA(\inst1|I3|acc[0][11]~196\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][13]~8146\,
	datab => \inst1|I3|acc[0][11]~8274\,
	datac => \rtl~14299\,
	datad => \rtl~14282\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][11]~196\,
	regout => \inst1|I3|acc_c[0][11]\);

\inst1|I3|acc_i[0][11]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][11]~8274\ = \inst1|I3|acc_c[0][11]\ & (\inst1|I3|acc[0][13]~111\ # L1_acc_i[0][11] & \inst1|I3|acc[0][13]~8147\) # !\inst1|I3|acc_c[0][11]\ & L1_acc_i[0][11] & \inst1|I3|acc[0][13]~8147\

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][11]\,
	datab => \inst1|I3|acc[0][13]~111\,
	datac => \inst1|I3|acc[0][11]~196\,
	datad => \inst1|I3|acc[0][13]~8147\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][11]~8274\);

\inst1|I4|data_ox[11]~7_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_ox[11]~7\ = \inst1|I3|acc_c[0][11]\ & \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ & \nreset_in~combout\

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
	datab => \inst1|I3|acc_c[0][11]\,
	datac => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	datad => \nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_ox[11]~7\);

\inst1|I2|Mux_78~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|Mux_78~0\ = \inst1|I2|idata_x[4]~39\ & (\inst1|I2|idata_x[5]~36\ & !\inst1|I2|idata_x[7]~33\ & !\inst1|I2|idata_x[6]~30\ # !\inst1|I2|idata_x[5]~36\ & (!\inst1|I2|idata_x[6]~30\ # !\inst1|I2|idata_x[7]~33\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "022A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|idata_x[4]~39\,
	datab => \inst1|I2|idata_x[5]~36\,
	datac => \inst1|I2|idata_x[7]~33\,
	datad => \inst1|I2|idata_x[6]~30\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|Mux_78~0\);

\inst1|I2|TD_c[0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|TD_c[0]\ = DFFEA(\inst1|I2|TD_x[3]~35\ & \rtl~13594\ & \inst1|I2|Mux_78~0\ # !\inst1|I2|TD_x[3]~35\ & \inst1|I2|idata_x[0]~21\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "CA0A",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I2|idata_x[0]~21\,
	datab => \rtl~13594\,
	datac => \inst1|I2|TD_x[3]~35\,
	datad => \inst1|I2|Mux_78~0\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I2|TD_c[0]\);

\rtl~13599_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13599\ = \rtl~13740\ & !\inst1|I2|TD_c[0]\ & !\inst1|I2|TD_c[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "000C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \rtl~13740\,
	datac => \inst1|I2|TD_c[0]\,
	datad => \inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13599\);

\inst1|I3|reduce_nor_131~52_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|reduce_nor_131~52\ = \inst1|I3|acc_c[0][12]\ # \inst1|I3|acc_c[0][14]\ # \inst1|I3|acc_c[0][4]\ # \inst1|I3|acc_c[0][15]\

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
	dataa => \inst1|I3|acc_c[0][12]\,
	datab => \inst1|I3|acc_c[0][14]\,
	datac => \inst1|I3|acc_c[0][4]\,
	datad => \inst1|I3|acc_c[0][15]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|reduce_nor_131~52\);

\inst1|I3|reduce_nor_131~61_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|reduce_nor_131~61\ = \inst1|I3|acc_c[0][10]\ # \inst1|I3|acc_c[0][11]\ # \inst1|I3|acc_c[0][7]\ # \inst1|I3|acc_c[0][8]\

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
	dataa => \inst1|I3|acc_c[0][10]\,
	datab => \inst1|I3|acc_c[0][11]\,
	datac => \inst1|I3|acc_c[0][7]\,
	datad => \inst1|I3|acc_c[0][8]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|reduce_nor_131~61\);

\inst1|I3|reduce_nor_131~74_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|reduce_nor_131~74\ = \inst1|I3|acc_c[0][2]\ # \inst1|I3|acc_c[0][0]\ # \inst1|I3|acc_c[0][1]\ # \inst1|I3|acc_c[0][3]\

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
	dataa => \inst1|I3|acc_c[0][2]\,
	datab => \inst1|I3|acc_c[0][0]\,
	datac => \inst1|I3|acc_c[0][1]\,
	datad => \inst1|I3|acc_c[0][3]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|reduce_nor_131~74\);

\inst1|I3|reduce_nor_131~47_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|reduce_nor_131~47\ = \inst1|I3|acc_c[0][13]\ # \inst1|I3|acc_c[0][9]\ # \inst1|I3|acc_c[0][6]\ # \inst1|I3|acc_c[0][5]\

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
	dataa => \inst1|I3|acc_c[0][13]\,
	datab => \inst1|I3|acc_c[0][9]\,
	datac => \inst1|I3|acc_c[0][6]\,
	datad => \inst1|I3|acc_c[0][5]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|reduce_nor_131~47\);

\inst1|I3|reduce_nor_131~99_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|reduce_nor_131~99\ = \inst1|I3|reduce_nor_131~52\ # \inst1|I3|reduce_nor_131~61\ # \inst1|I3|reduce_nor_131~74\ # \inst1|I3|reduce_nor_131~47\

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
	dataa => \inst1|I3|reduce_nor_131~52\,
	datab => \inst1|I3|reduce_nor_131~61\,
	datac => \inst1|I3|reduce_nor_131~74\,
	datad => \inst1|I3|reduce_nor_131~47\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|reduce_nor_131~99\);

\rtl~1119_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~1119\ = \rtl~13599\ & !\inst1|I2|TD_c[2]\ & !\inst1|I3|reduce_nor_131~99\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "000C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \rtl~13599\,
	datac => \inst1|I2|TD_c[2]\,
	datad => \inst1|I3|reduce_nor_131~99\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1119\);

\rtl~13776_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13776\ = !\inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[2]\ & \inst1|I2|TD_c[0]\ & \inst1|I3|acc_c[0][16]\

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
	dataa => \inst1|I2|TD_c[1]\,
	datab => \inst1|I2|TD_c[2]\,
	datac => \inst1|I2|TD_c[0]\,
	datad => \inst1|I3|acc_c[0][16]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13776\);

\inst1|I3|skip_i~I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13804\ = \rtl~13789\ & (L1_skip_i # \rtl~13776\ & \rtl~13740\) # !\rtl~13789\ & \rtl~13776\ & \rtl~13740\

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
	clk => \clk_in~combout\,
	dataa => \rtl~13789\,
	datab => \rtl~13776\,
	datac => \inst1|I3|skip_l~8\,
	datad => \rtl~13740\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13804\);

\rtl~1120_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~1120\ = \rtl~13595\ & \rtl~13740\ & !\inst1|I2|TD_c[0]\ & \inst1|I3|reduce_nor_131~99\

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
	dataa => \rtl~13595\,
	datab => \rtl~13740\,
	datac => \inst1|I2|TD_c[0]\,
	datad => \inst1|I3|reduce_nor_131~99\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1120\);

\rtl~13815_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~13815\ = \rtl~1120\ # \rtl~13599\ & \inst1|I2|TD_c[2]\ & !\inst1|I3|acc_c[0][16]\

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
	dataa => \rtl~13599\,
	datab => \inst1|I2|TD_c[2]\,
	datac => \inst1|I3|acc_c[0][16]\,
	datad => \rtl~1120\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~13815\);

\inst1|I3|skip_l~8_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|skip_l~8\ = \inst1|I3|i~161\ & (\rtl~1119\ # \rtl~13804\ # \rtl~13815\)

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
	dataa => \inst1|I3|i~161\,
	datab => \rtl~1119\,
	datac => \rtl~13804\,
	datad => \rtl~13815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|skip_l~8\);

\inst1|I2|skip_x~62_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|skip_x~62\ = !\inst1|I2|int_start_c\ & \inst1|I3|skip_l~8\ & (!\inst1|I2|E_c~10\ # !\inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "1500",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|int_start_c\,
	datab => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	datac => \inst1|I2|E_c~10\,
	datad => \inst1|I3|skip_l~8\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|skip_x~62\);

\inst1|I2|skip_c~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|skip_x~61\ = \inst1|I2|skip_x~62\ # \inst1|I2|E_c~10\ & \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\ & K1_skip_c
-- \inst1|I2|skip_c\ = DFFEA(\inst1|I2|skip_x~61\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "FF80",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I2|E_c~10\,
	datab => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	datad => \inst1|I2|skip_x~62\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|skip_x~61\,
	regout => \inst1|I2|skip_c\);

\inst1|I2|TC_c[0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|C_raw~32\ = !\inst1|I2|TC_c[2]\ & K1_TC_c[0] & !\inst1|I2|skip_c\
-- \inst1|I2|TC_c[0]\ = DFFEA(\inst1|I2|TC_x[0]~146\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "0050",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I2|TC_c[2]\,
	datac => \inst1|I2|TC_x[0]~146\,
	datad => \inst1|I2|skip_c\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|C_raw~32\,
	regout => \inst1|I2|TC_c[0]\);

\inst1|I2|C_raw~47_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|C_raw~47\ = \inst1|I2|pc_mux_x[2]~236\ & !\inst1|I2|TC_x[2]~139\ & \inst1|I2|TC_x[0]~146\

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
	datab => \inst1|I2|pc_mux_x[2]~236\,
	datac => \inst1|I2|TC_x[2]~139\,
	datad => \inst1|I2|TC_x[0]~146\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|C_raw~47\);

\inst1|I2|C_raw~6_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|C_raw~6\ = \inst1|I2|TC_c[1]\ & \inst1|I2|C_raw~32\ & !\inst1|I2|TC_x[1]~22\ & \inst1|I2|C_raw~47\

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
	dataa => \inst1|I2|TC_c[1]\,
	datab => \inst1|I2|C_raw~32\,
	datac => \inst1|I2|TC_x[1]~22\,
	datad => \inst1|I2|C_raw~47\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|C_raw~6\);

\inst1|I2|ndwe_x~51_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|ndwe_x~51\ = \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\ & !\inst1|I2|skip_x~61\ & \inst1|I2|pc_mux_x[2]~233\ & !\inst1|I2|C_raw~6\

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
	dataa => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	datab => \inst1|I2|skip_x~61\,
	datac => \inst1|I2|pc_mux_x[2]~233\,
	datad => \inst1|I2|C_raw~6\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|ndwe_x~51\);

\inst1|I4|ndwe_x~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ndwe_x~1\ = \inst1|I4|i~2617\ # !\inst1|I2|ndwe_x~51\ # !\inst1|I4|ndwe_x~10\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF77",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ndwe_x~10\,
	datab => \inst1|I2|ndwe_x~51\,
	datad => \inst1|I4|i~2617\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|ndwe_x~1\);

\inst2|nadwe_c~I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|nadwe_c\ = DFFEA(\inst4|dwait_c\ & (\inst2|a2vi_s\ & \inst2|nadwe_c\ # !\inst2|a2vi_s\ & !\inst1|I4|ndwe_x~1\) # !\inst4|dwait_c\ & !\inst1|I4|ndwe_x~1\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "80BF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst2|nadwe_c\,
	datab => \inst4|dwait_c\,
	datac => \inst2|a2vi_s\,
	datad => \inst1|I4|ndwe_x~1\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst2|nadwe_c\);

\inst2|i~1057_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~1057\ = !\inst4|dwait_c\ & !\inst2|nadwe_c\

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
	datac => \inst4|dwait_c\,
	datad => \inst2|nadwe_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~1057\);

\inst2|a2vi_s~I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|a2vi_s\ = DFFEA(\inst2|a2vi_s\ & (\inst2|dwait_c\ # !\inst2|i~1057\) # !\inst2|a2vi_s\ & \inst4|i~326\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFCC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst2|dwait_c\,
	datab => \inst4|i~326\,
	datac => \inst2|i~1057\,
	datad => \inst2|a2vi_s\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst2|a2vi_s\);

\inst1|I2|E_x.iwait_e~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|E_x.iwait_e~1\ = \nreset_in~combout\ & \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\ & !\inst1|I2|i~219\ & \inst2|a2vi_s\

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
	dataa => \nreset_in~combout\,
	datab => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	datac => \inst1|I2|i~219\,
	datad => \inst2|a2vi_s\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|E_x.iwait_e~1\);

\inst1|I2|E_c~10_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|i~219\ = \inst4|dwait_c\ & \inst1|I2|i~413\ & !K1L81Q & \inst1|I2|C_raw~32\
-- \inst1|I2|E_c~10\ = DFFEA(\inst1|I2|E_x.iwait_e~1\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "on",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "0800",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst4|dwait_c\,
	datab => \inst1|I2|i~413\,
	datac => \inst1|I2|E_x.iwait_e~1\,
	datad => \inst1|I2|C_raw~32\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|i~219\,
	regout => \inst1|I2|E_c~10\);

\inst1|I2|valid_x~7_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|valid_x~7\ = !\inst1|I2|skip_x~61\ & !\inst1|I2|E_x.iwait_e~1\ & !\inst1|I2|C_raw~6\

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
	datab => \inst1|I2|skip_x~61\,
	datac => \inst1|I2|E_x.iwait_e~1\,
	datad => \inst1|I2|C_raw~6\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|valid_x~7\);

\inst1|I2|valid_c~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|valid_c\ = DFFEA(\inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\ & (\inst1|I2|valid_x~7\ # \inst1|I2|i~219\ & \nreset_in~combout\), GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	datab => \inst1|I2|i~219\,
	datac => \inst1|I2|valid_x~7\,
	datad => \nreset_in~combout\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I2|valid_c\);

\inst1|I3|i~204_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|i~204\ = \nreset_in~combout\ & \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[1]\ & \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]\ & \inst1|I2|valid_c\

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
	dataa => \nreset_in~combout\,
	datab => \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[1]\,
	datac => \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]\,
	datad => \inst1|I2|valid_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|i~204\);

\inst1|I3|acc[0][16]~8145_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][16]~8145\ = \inst1|I3|i~204\ & \rtl~2129\ & (!\inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\ # !\inst1|I2|i~219\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "40C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|i~219\,
	datab => \inst1|I3|i~204\,
	datac => \rtl~2129\,
	datad => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][16]~8145\);

\inst1|I3|acc[0][13]~8146_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][13]~8146\ = !\inst1|I2|TC_c[2]\ & \inst1|I3|acc[0][16]~8145\

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
	datac => \inst1|I2|TC_c[2]\,
	datad => \inst1|I3|acc[0][16]~8145\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][13]~8146\);

\rtl~14563_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14563\ = \rtl~13588\ & (\inst1|I3|data_x[1]~3998\ $ (\inst1|I2|TD_c[0]\ & \inst1|I3|acc_c[0][1]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "4C80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datab => \rtl~13588\,
	datac => \inst1|I3|acc_c[0][1]\,
	datad => \inst1|I3|data_x[1]~3998\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14563\);

\rtl~2659_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2659\ = \inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][2]\ # !\inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][2]\ # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "7610",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[1]\,
	datab => \inst1|I2|TD_c[2]\,
	datac => \inst1|I3|acc_c[0][1]\,
	datad => \inst1|I3|acc_c[0][2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2659\);

\rtl~2840_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2840\ = \inst1|I2|TD_c[2]\ & (\inst1|I3|acc_c[0][1]\ $ \inst1|I2|TD_c[1]\) # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "72D8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[2]\,
	datab => \inst1|I3|acc_c[0][1]\,
	datac => \inst1|I3|acc_c[0][0]\,
	datad => \inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2840\);

\rtl~2845_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2845\ = \inst1|I2|TD_c[0]\ & \rtl~2840\ # !\inst1|I2|TD_c[0]\ & \rtl~2659\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FA50",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datac => \rtl~2659\,
	datad => \rtl~2840\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2845\);

\inst1|I3|Mux_265_rtl_146_rtl_427~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_265_rtl_146_rtl_427~0\ = \inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[0]\ # \inst1|I3|add_225~2\) # !\inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[0]\ & \inst1|I3|add_185~1\

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
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I3|add_185~1\,
	datad => \inst1|I3|add_225~2\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_265_rtl_146_rtl_427~0\);

\inst1|I3|Mux_265_rtl_146_rtl_427~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_265_rtl_146_rtl_427~1\ = \inst1|I3|data_x[1]~3998\ & (\inst1|I3|Mux_265_rtl_146_rtl_427~0\ # \inst1|I3|acc_c[0][1]\ & \inst1|I2|TD_c[0]\) # !\inst1|I3|data_x[1]~3998\ & \inst1|I3|Mux_265_rtl_146_rtl_427~0\ & (\inst1|I3|acc_c[0][1]\ # !\inst1|I2|TD_c[0]\)

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
	dataa => \inst1|I3|data_x[1]~3998\,
	datab => \inst1|I3|acc_c[0][1]\,
	datac => \inst1|I2|TD_c[0]\,
	datad => \inst1|I3|Mux_265_rtl_146_rtl_427~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_265_rtl_146_rtl_427~1\);

\rtl~14541_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14541\ = \rtl~13596\ & (\inst1|I3|Mux_265_rtl_146_rtl_427~1\ # \rtl~13900\ & \inst1|I3|acc_c[0][1]\) # !\rtl~13596\ & \rtl~13900\ & \inst1|I3|acc_c[0][1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "EAC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~13596\,
	datab => \rtl~13900\,
	datac => \inst1|I3|acc_c[0][1]\,
	datad => \inst1|I3|Mux_265_rtl_146_rtl_427~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14541\);

\rtl~14546_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14546\ = \rtl~14541\ # \rtl~2845\ & (\inst1|I2|TC_c[1]\ $ !\inst1|I2|TC_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF82",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~2845\,
	datab => \inst1|I2|TC_c[1]\,
	datac => \inst1|I2|TC_c[0]\,
	datad => \rtl~14541\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14546\);

\inst1|I3|acc_c[0][1]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][1]~256\ = \inst1|I3|acc[0][1]~8334\ # \inst1|I3|acc[0][13]~8146\ & (\rtl~14563\ # \rtl~14546\)
-- \inst1|I3|acc_c[0][1]\ = DFFEA(\inst1|I3|acc[0][1]~256\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][13]~8146\,
	datab => \inst1|I3|acc[0][1]~8334\,
	datac => \rtl~14563\,
	datad => \rtl~14546\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][1]~256\,
	regout => \inst1|I3|acc_c[0][1]\);

\inst1|I3|acc_i[0][1]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][1]~8334\ = \inst1|I3|acc[0][13]~8147\ & (L1_acc_i[0][1] # \inst1|I3|acc[0][13]~111\ & \inst1|I3|acc_c[0][1]\) # !\inst1|I3|acc[0][13]~8147\ & \inst1|I3|acc[0][13]~111\ & \inst1|I3|acc_c[0][1]\

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][13]~8147\,
	datab => \inst1|I3|acc[0][13]~111\,
	datac => \inst1|I3|acc[0][1]~256\,
	datad => \inst1|I3|acc_c[0][1]\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][1]~8334\);

\inst1|I4|add_205_rtl_595~152_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~152\ = \inst1|I4|add_205~1\ & (\inst1|I4|ireg_c[1]\ # \inst1|I4|i~2616\) # !\inst1|I4|add_205~1\ & \inst1|I4|ireg_c[1]\ & !\inst1|I4|i~2616\

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
	datab => \inst1|I4|add_205~1\,
	datac => \inst1|I4|ireg_c[1]\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~152\);

\inst1|I4|ireg_i[1]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~157\ = \inst1|I4|ireg_we_c\ & \inst1|I3|acc_c[0][1]\ # !\inst1|I4|ireg_we_c\ & \inst1|I4|i~38\ & \inst1|I4|add_205_rtl_595~152\
-- \inst1|I4|ireg_i[1]\ = DFFEA(\inst1|I4|add_205_rtl_595~157\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|i~38\,
	datab => \inst1|I4|ireg_we_c\,
	datac => \inst1|I3|acc_c[0][1]\,
	datad => \inst1|I4|add_205_rtl_595~152\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~157\,
	regout => \inst1|I4|ireg_i[1]\);

\inst1|I4|ireg_c[1]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ireg_c[1]\ = DFFEA(\inst1|I4|ireg_i[1]\ & (\inst1|I2|int_stop_x~11\ # \inst1|I4|add_205_rtl_595~157\) # !\inst1|I4|ireg_i[1]\ & !\inst1|I2|int_stop_x~11\ & \inst1|I4|add_205_rtl_595~157\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFA0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|ireg_i[1]\,
	datac => \inst1|I2|int_stop_x~11\,
	datad => \inst1|I4|add_205_rtl_595~157\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|ireg_c[1]\);

\inst1|I4|daddr_x[1]~128_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|daddr_x[1]~128\ = \inst1|I4|i~38\ & (\inst1|I2|idata_x[5]~36\ # \inst1|I4|ireg_c[1]\ & \inst1|I4|i~2616\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C8C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ireg_c[1]\,
	datab => \inst1|I4|i~38\,
	datac => \inst1|I2|idata_x[5]~36\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|daddr_x[1]~128\);

\inst2|daddr_c[1]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|daddr_c[1]\ = DFFEA(\inst2|a2vi_s\ & (\inst4|dwait_c\ & \inst2|daddr_c[1]\ # !\inst4|dwait_c\ & \inst1|I4|daddr_x[1]~128\) # !\inst2|a2vi_s\ & \inst1|I4|daddr_x[1]~128\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "DF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst2|a2vi_s\,
	datab => \inst2|daddr_c[1]\,
	datac => \inst4|dwait_c\,
	datad => \inst1|I4|daddr_x[1]~128\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst2|daddr_c[1]\);

\inst2|i~210_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~210\ = \inst2|i~1057\ & \inst1|I1|i~2\ & \inst1|I1|iaddr_x[1]~343\ # !\inst2|i~1057\ & \inst2|daddr_c[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E222",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst2|daddr_c[1]\,
	datab => \inst2|i~1057\,
	datac => \inst1|I1|i~2\,
	datad => \inst1|I1|iaddr_x[1]~343\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~210\);

\inst2|i~215_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~215\ = \inst1|I4|ndre_x~1\ & \inst2|i~210\ # !\inst1|I4|ndre_x~1\ & \inst1|I4|daddr_x[1]~128\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FC30",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst1|I4|ndre_x~1\,
	datac => \inst1|I4|daddr_x[1]~128\,
	datad => \inst2|i~210\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~215\);

\inst1|I2|TD_c[3]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|TD_c[3]\ = DFFEA(\inst1|I2|idata_x[7]~33\ & \rtl~13594\ & \inst1|I2|TD_x[3]~35\ & !\inst1|I2|idata_x[6]~30\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I2|idata_x[7]~33\,
	datab => \rtl~13594\,
	datac => \inst1|I2|TD_x[3]~35\,
	datad => \inst1|I2|idata_x[6]~30\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I2|TD_c[3]\);

\rtl~2129_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2129\ = \inst1|I2|TC_c[2]\ & !\inst1|I2|TC_c[0]\ & !\inst1|I2|TC_c[1]\ # !\inst1|I2|TC_c[2]\ & !\inst1|I2|TD_c[3]\ & (!\inst1|I2|TC_c[1]\ # !\inst1|I2|TC_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0153",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TC_c[0]\,
	datab => \inst1|I2|TD_c[3]\,
	datac => \inst1|I2|TC_c[2]\,
	datad => \inst1|I2|TC_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2129\);

\inst1|I3|acc[0][13]~111_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][13]~111\ = \inst1|I3|i~161\ & !\rtl~2129\ # !\inst1|I3|i~161\ & \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]\ & \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "33A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[0]\,
	datab => \rtl~2129\,
	datac => \inst1|I3|nreset_v_rtl_3|wysi_counter|safe_q[1]\,
	datad => \inst1|I3|i~161\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][13]~111\);

\rtl~14431_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14431\ = \rtl~13588\ & (\inst1|I3|data_x[7]~3872\ $ (\inst1|I2|TD_c[0]\ & \inst1|I3|acc_c[0][7]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "60C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I3|data_x[7]~3872\,
	datac => \rtl~13588\,
	datad => \inst1|I3|acc_c[0][7]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14431\);

\rtl~2626_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2626\ = \inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][8]\ & !\inst1|I2|TD_c[1]\ # !\inst1|I2|TD_c[2]\ & (\inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][8]\ # !\inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][7]\)

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
	dataa => \inst1|I3|acc_c[0][7]\,
	datab => \inst1|I3|acc_c[0][8]\,
	datac => \inst1|I2|TD_c[2]\,
	datad => \inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2626\);

\rtl~2810_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2810\ = \inst1|I2|TD_c[2]\ & (\inst1|I3|acc_c[0][7]\ $ \inst1|I2|TD_c[1]\) # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][6]\

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
	dataa => \inst1|I3|acc_c[0][7]\,
	datab => \inst1|I3|acc_c[0][6]\,
	datac => \inst1|I2|TD_c[2]\,
	datad => \inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2810\);

\rtl~2815_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2815\ = \rtl~2626\ & (\rtl~2810\ # !\inst1|I2|TD_c[0]\) # !\rtl~2626\ & \rtl~2810\ & \inst1|I2|TD_c[0]\

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
	dataa => \rtl~2626\,
	datac => \rtl~2810\,
	datad => \inst1|I2|TD_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2815\);

\inst1|I3|Mux_259_rtl_128_rtl_409~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_259_rtl_128_rtl_409~0\ = \inst1|I2|TD_c[1]\ & (\inst1|I3|add_225~8\ # \inst1|I2|TD_c[0]\) # !\inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[0]\ & \inst1|I3|add_185~7\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "ADA8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[1]\,
	datab => \inst1|I3|add_225~8\,
	datac => \inst1|I2|TD_c[0]\,
	datad => \inst1|I3|add_185~7\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_259_rtl_128_rtl_409~0\);

\inst1|I3|Mux_259_rtl_128_rtl_409~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_259_rtl_128_rtl_409~1\ = \inst1|I3|acc_c[0][7]\ & (\inst1|I3|Mux_259_rtl_128_rtl_409~0\ # \inst1|I3|data_x[7]~3872\ & \inst1|I2|TD_c[0]\) # !\inst1|I3|acc_c[0][7]\ & \inst1|I3|Mux_259_rtl_128_rtl_409~0\ & (\inst1|I3|data_x[7]~3872\ # !\inst1|I2|TD_c[0]\)

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
	dataa => \inst1|I3|acc_c[0][7]\,
	datab => \inst1|I3|data_x[7]~3872\,
	datac => \inst1|I2|TD_c[0]\,
	datad => \inst1|I3|Mux_259_rtl_128_rtl_409~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_259_rtl_128_rtl_409~1\);

\rtl~14409_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14409\ = \inst1|I3|acc_c[0][7]\ & (\rtl~13900\ # \rtl~13596\ & \inst1|I3|Mux_259_rtl_128_rtl_409~1\) # !\inst1|I3|acc_c[0][7]\ & \rtl~13596\ & \inst1|I3|Mux_259_rtl_128_rtl_409~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][7]\,
	datab => \rtl~13900\,
	datac => \rtl~13596\,
	datad => \inst1|I3|Mux_259_rtl_128_rtl_409~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14409\);

\rtl~14414_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14414\ = \rtl~14409\ # \rtl~2815\ & (\inst1|I2|TC_c[0]\ $ !\inst1|I2|TC_c[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF84",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TC_c[0]\,
	datab => \rtl~2815\,
	datac => \inst1|I2|TC_c[1]\,
	datad => \rtl~14409\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14414\);

\inst1|I3|acc_c[0][7]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][7]~226\ = \inst1|I3|acc[0][7]~8304\ # \inst1|I3|acc[0][13]~8146\ & (\rtl~14431\ # \rtl~14414\)
-- \inst1|I3|acc_c[0][7]\ = DFFEA(\inst1|I3|acc[0][7]~226\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][7]~8304\,
	datab => \inst1|I3|acc[0][13]~8146\,
	datac => \rtl~14431\,
	datad => \rtl~14414\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][7]~226\,
	regout => \inst1|I3|acc_c[0][7]\);

\inst1|I3|acc_i[0][7]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][7]~8304\ = \inst1|I3|acc[0][13]~111\ & (\inst1|I3|acc_c[0][7]\ # \inst1|I3|acc[0][13]~8147\ & L1_acc_i[0][7]) # !\inst1|I3|acc[0][13]~111\ & \inst1|I3|acc[0][13]~8147\ & L1_acc_i[0][7]

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][13]~111\,
	datab => \inst1|I3|acc[0][13]~8147\,
	datac => \inst1|I3|acc[0][7]~226\,
	datad => \inst1|I3|acc_c[0][7]\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][7]~8304\);

\inst1|I4|data_ox[7]~11_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_ox[7]~11\ = \inst1|I3|acc_c[0][7]\ & \nreset_in~combout\ & \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\

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
	datab => \inst1|I3|acc_c[0][7]\,
	datac => \nreset_in~combout\,
	datad => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_ox[7]~11\);

\inst1|I4|ireg_we_c~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ireg_we_c\ = DFFEA(\inst1|I2|idata_x[4]~39\ & !\inst1|I2|idata_x[5]~36\ & !\inst1|I2|idata_x[6]~30\ & \inst1|I4|ireg_we_x~10\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0200",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I2|idata_x[4]~39\,
	datab => \inst1|I2|idata_x[5]~36\,
	datac => \inst1|I2|idata_x[6]~30\,
	datad => \inst1|I4|ireg_we_x~10\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|ireg_we_c\);

\inst1|I4|add_205_rtl_595~162_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~162\ = \inst1|I4|ireg_c[0]\ & (\inst1|I4|add_205~0\ # !\inst1|I4|i~2616\) # !\inst1|I4|ireg_c[0]\ & \inst1|I4|add_205~0\ & \inst1|I4|i~2616\

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
	datab => \inst1|I4|ireg_c[0]\,
	datac => \inst1|I4|add_205~0\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~162\);

\inst1|I4|ireg_i[0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|add_205_rtl_595~167\ = \inst1|I4|ireg_we_c\ & \inst1|I3|acc_c[0][0]\ # !\inst1|I4|ireg_we_c\ & \inst1|I4|i~38\ & \inst1|I4|add_205_rtl_595~162\
-- \inst1|I4|ireg_i[0]\ = DFFEA(\inst1|I4|add_205_rtl_595~167\, GLOBAL(\clk_in~combout\), VCC, , \inst1|I4|ireg_i[9]~1\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E2C0",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|i~38\,
	datab => \inst1|I4|ireg_we_c\,
	datac => \inst1|I3|acc_c[0][0]\,
	datad => \inst1|I4|add_205_rtl_595~162\,
	aclr => GND,
	ena => \inst1|I4|ireg_i[9]~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|add_205_rtl_595~167\,
	regout => \inst1|I4|ireg_i[0]\);

\inst1|I4|ireg_c[0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ireg_c[0]\ = DFFEA(\inst1|I4|ireg_i[0]\ & (\inst1|I2|int_stop_x~11\ # \inst1|I4|add_205_rtl_595~167\) # !\inst1|I4|ireg_i[0]\ & !\inst1|I2|int_stop_x~11\ & \inst1|I4|add_205_rtl_595~167\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "AFA0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|ireg_i[0]\,
	datac => \inst1|I2|int_stop_x~11\,
	datad => \inst1|I4|add_205_rtl_595~167\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst1|I4|ireg_c[0]\);

\inst1|I4|daddr_x[0]~135_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|daddr_x[0]~135\ = \inst1|I4|i~38\ & (\inst1|I2|idata_x[4]~39\ # \inst1|I4|ireg_c[0]\ & \inst1|I4|i~2616\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C8C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ireg_c[0]\,
	datab => \inst1|I4|i~38\,
	datac => \inst1|I2|idata_x[4]~39\,
	datad => \inst1|I4|i~2616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|daddr_x[0]~135\);

\inst2|daddr_c[0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|daddr_c[0]\ = DFFEA(\inst4|dwait_c\ & (\inst2|a2vi_s\ & \inst2|daddr_c[0]\ # !\inst2|a2vi_s\ & \inst1|I4|daddr_x[0]~135\) # !\inst4|dwait_c\ & \inst1|I4|daddr_x[0]~135\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F780",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst4|dwait_c\,
	datab => \inst2|a2vi_s\,
	datac => \inst2|daddr_c[0]\,
	datad => \inst1|I4|daddr_x[0]~135\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst2|daddr_c[0]\);

\inst2|i~200_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~200\ = \inst2|i~1057\ & \inst1|I1|i~2\ & \inst1|I1|iaddr_x[0]~301\ # !\inst2|i~1057\ & \inst2|daddr_c[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "E444",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst2|i~1057\,
	datab => \inst2|daddr_c[0]\,
	datac => \inst1|I1|i~2\,
	datad => \inst1|I1|iaddr_x[0]~301\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~200\);

\inst2|i~205_I\ : cyclone_lcell 
-- Equation(s):
-- \inst2|i~205\ = \inst1|I4|ndre_x~1\ & \inst2|i~200\ # !\inst1|I4|ndre_x~1\ & \inst1|I4|daddr_x[0]~135\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FC30",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst1|I4|ndre_x~1\,
	datac => \inst1|I4|daddr_x[0]~135\,
	datad => \inst2|i~200\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst2|i~205\);

\inst1|I2|TC_x[0]~141_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|TC_x[0]~141\ = \inst1|I2|idata_x[6]~30\ & !\inst1|I2|idata_x[4]~39\ & \inst1|I2|idata_x[7]~33\ & !\inst1|I2|idata_x[5]~36\

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
	dataa => \inst1|I2|idata_x[6]~30\,
	datab => \inst1|I2|idata_x[4]~39\,
	datac => \inst1|I2|idata_x[7]~33\,
	datad => \inst1|I2|idata_x[5]~36\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|TC_x[0]~141\);

\inst1|I2|TC_x[0]~147_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|TC_x[0]~147\ = \nreset_in~combout\ & !\inst1|I2|idata_x[3]~18\ & (\inst1|I2|TC_x[0]~141\ # !\inst1|I2|TD_x[3]~35\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2202",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \nreset_in~combout\,
	datab => \inst1|I2|idata_x[3]~18\,
	datac => \inst1|I2|TD_x[3]~35\,
	datad => \inst1|I2|TC_x[0]~141\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|TC_x[0]~147\);

\inst1|I2|TC_x[0]~146_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|TC_x[0]~146\ = \inst1|I2|TC_x[0]~147\ # \nreset_in~combout\ & \inst1|I2|idata_x[0]~21\ & \inst1|I2|TD_x[3]~35\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \nreset_in~combout\,
	datab => \inst1|I2|idata_x[0]~21\,
	datac => \inst1|I2|TD_x[3]~35\,
	datad => \inst1|I2|TC_x[0]~147\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|TC_x[0]~146\);

\inst1|I3|acc[0][13]~8147_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][13]~8147\ = \inst1|I2|TC_c[2]\ & \inst1|I3|acc[0][16]~8145\

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
	datac => \inst1|I2|TC_c[2]\,
	datad => \inst1|I3|acc[0][16]~8145\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][13]~8147\);

\rtl~14519_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14519\ = \rtl~13588\ & (\inst1|I3|data_x[2]~3956\ $ (\inst1|I2|TD_c[0]\ & \inst1|I3|acc_c[0][2]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "7080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datab => \inst1|I3|acc_c[0][2]\,
	datac => \rtl~13588\,
	datad => \inst1|I3|data_x[2]~3956\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14519\);

\rtl~2648_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2648\ = \inst1|I2|TD_c[1]\ & \inst1|I3|acc_c[0][3]\ & !\inst1|I2|TD_c[2]\ # !\inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][3]\ # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][2]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2B28",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][3]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I2|TD_c[2]\,
	datad => \inst1|I3|acc_c[0][2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2648\);

\rtl~2830_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2830\ = \inst1|I2|TD_c[2]\ & (\inst1|I2|TD_c[1]\ $ \inst1|I3|acc_c[0][2]\) # !\inst1|I2|TD_c[2]\ & \inst1|I3|acc_c[0][1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "3ACA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][1]\,
	datab => \inst1|I2|TD_c[1]\,
	datac => \inst1|I2|TD_c[2]\,
	datad => \inst1|I3|acc_c[0][2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2830\);

\rtl~2835_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~2835\ = \inst1|I2|TD_c[0]\ & \rtl~2830\ # !\inst1|I2|TD_c[0]\ & \rtl~2648\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FA50",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TD_c[0]\,
	datac => \rtl~2648\,
	datad => \rtl~2830\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2835\);

\inst1|I3|Mux_264_rtl_140_rtl_421~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_264_rtl_140_rtl_421~0\ = \inst1|I2|TD_c[1]\ & (\inst1|I2|TD_c[0]\ # \inst1|I3|add_225~3\) # !\inst1|I2|TD_c[1]\ & !\inst1|I2|TD_c[0]\ & \inst1|I3|add_185~2\

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
	dataa => \inst1|I2|TD_c[1]\,
	datab => \inst1|I2|TD_c[0]\,
	datac => \inst1|I3|add_185~2\,
	datad => \inst1|I3|add_225~3\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_264_rtl_140_rtl_421~0\);

\inst1|I3|Mux_264_rtl_140_rtl_421~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|Mux_264_rtl_140_rtl_421~1\ = \inst1|I3|acc_c[0][2]\ & (\inst1|I3|Mux_264_rtl_140_rtl_421~0\ # \inst1|I3|data_x[2]~3956\ & \inst1|I2|TD_c[0]\) # !\inst1|I3|acc_c[0][2]\ & \inst1|I3|Mux_264_rtl_140_rtl_421~0\ & (\inst1|I3|data_x[2]~3956\ # !\inst1|I2|TD_c[0]\)

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
	dataa => \inst1|I3|acc_c[0][2]\,
	datab => \inst1|I3|data_x[2]~3956\,
	datac => \inst1|I2|TD_c[0]\,
	datad => \inst1|I3|Mux_264_rtl_140_rtl_421~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|Mux_264_rtl_140_rtl_421~1\);

\rtl~14497_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14497\ = \inst1|I3|acc_c[0][2]\ & (\rtl~13900\ # \rtl~13596\ & \inst1|I3|Mux_264_rtl_140_rtl_421~1\) # !\inst1|I3|acc_c[0][2]\ & \rtl~13596\ & \inst1|I3|Mux_264_rtl_140_rtl_421~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I3|acc_c[0][2]\,
	datab => \rtl~13900\,
	datac => \rtl~13596\,
	datad => \inst1|I3|Mux_264_rtl_140_rtl_421~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14497\);

\rtl~14502_I\ : cyclone_lcell 
-- Equation(s):
-- \rtl~14502\ = \rtl~14497\ # \rtl~2835\ & (\inst1|I2|TC_c[0]\ $ !\inst1|I2|TC_c[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF82",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~2835\,
	datab => \inst1|I2|TC_c[0]\,
	datac => \inst1|I2|TC_c[1]\,
	datad => \rtl~14497\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~14502\);

\inst1|I3|acc_c[0][2]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][2]~246\ = \inst1|I3|acc[0][2]~8324\ # \inst1|I3|acc[0][13]~8146\ & (\rtl~14519\ # \rtl~14502\)
-- \inst1|I3|acc_c[0][2]\ = DFFEA(\inst1|I3|acc[0][2]~246\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc[0][2]~8324\,
	datab => \inst1|I3|acc[0][13]~8146\,
	datac => \rtl~14519\,
	datad => \rtl~14502\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][2]~246\,
	regout => \inst1|I3|acc_c[0][2]\);

\inst1|I3|acc_i[0][2]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I3|acc[0][2]~8324\ = \inst1|I3|acc_c[0][2]\ & (\inst1|I3|acc[0][13]~111\ # \inst1|I3|acc[0][13]~8147\ & L1_acc_i[0][2]) # !\inst1|I3|acc_c[0][2]\ & \inst1|I3|acc[0][13]~8147\ & L1_acc_i[0][2]

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
	clk => \clk_in~combout\,
	dataa => \inst1|I3|acc_c[0][2]\,
	datab => \inst1|I3|acc[0][13]~8147\,
	datac => \inst1|I3|acc[0][2]~246\,
	datad => \inst1|I3|acc[0][13]~111\,
	aclr => \NOT_nreset_in~combout\,
	sload => VCC,
	ena => \inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I3|acc[0][2]~8324\);

\inst1|I4|data_ox[2]~13_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|data_ox[2]~13\ = \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ & \inst1|I3|acc_c[0][2]\ & \nreset_in~combout\

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
	dataa => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	datac => \inst1|I3|acc_c[0][2]\,
	datad => \nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|data_ox[2]~13\);

\inst1|I2|TC_x[2]~135_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|TC_x[2]~135\ = \inst1|I2|idata_x[6]~30\ & !\inst1|I2|idata_x[0]~21\ & \inst1|I2|idata_x[7]~33\ & !\inst1|I2|idata_x[5]~36\

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
	dataa => \inst1|I2|idata_x[6]~30\,
	datab => \inst1|I2|idata_x[0]~21\,
	datac => \inst1|I2|idata_x[7]~33\,
	datad => \inst1|I2|idata_x[5]~36\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|TC_x[2]~135\);

\inst1|I2|TC_x[2]~139_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|TC_x[2]~139\ = \nreset_in~combout\ & \inst1|I2|TD_x[3]~35\ & (\inst1|I2|idata_x[3]~18\ # \inst1|I2|TC_x[2]~135\)

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
	dataa => \nreset_in~combout\,
	datab => \inst1|I2|TD_x[3]~35\,
	datac => \inst1|I2|idata_x[3]~18\,
	datad => \inst1|I2|TC_x[2]~135\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|TC_x[2]~139\);

\inst1|I2|C_store_x~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|C_store_x~0\ = \inst1|I2|TC_x[2]~139\ # !\inst1|I2|TC_x[0]~146\ # !\inst1|I2|TC_x[1]~22\ # !\inst1|I2|pc_mux_x[2]~236\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "BFFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|TC_x[2]~139\,
	datab => \inst1|I2|pc_mux_x[2]~236\,
	datac => \inst1|I2|TC_x[1]~22\,
	datad => \inst1|I2|TC_x[0]~146\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|C_store_x~0\);

\inst1|I4|i~1280_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|i~1280\ = \inst1|I2|ndwe_x~51\ & !\inst1|I4|i~2617\

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
	datac => \inst1|I2|ndwe_x~51\,
	datad => \inst1|I4|i~2617\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|i~1280\);

\inst3|nWE_RAM_c~I\ : cyclone_lcell 
-- Equation(s):
-- \inst3|nWE_RAM_c\ = DFFEA(!\inst1|I2|C_store_x~0\ & \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ & \inst1|I4|i~1280\ & !\inst1|I4|daddr_x[9]~72\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "0040",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I2|C_store_x~0\,
	datab => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	datac => \inst1|I4|i~1280\,
	datad => \inst1|I4|daddr_x[9]~72\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst3|nWE_RAM_c\);

\inst1|I4|i~2617_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|i~2617\ = \inst1|I4|i~40\ & (\inst1|I2|idata_x[4]~39\ & !\inst1|I2|idata_x[5]~36\ # !\inst1|I2|idata_x[4]~39\ & !\inst1|I2|idata_x[6]~30\ & \inst1|I2|idata_x[5]~36\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "1C00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|idata_x[6]~30\,
	datab => \inst1|I2|idata_x[4]~39\,
	datac => \inst1|I2|idata_x[5]~36\,
	datad => \inst1|I4|i~40\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|i~2617\);

\inst4|i~326_I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|i~326\ = !\inst1|I4|i~2617\ & \inst1|I2|ndwe_x~51\ & \inst1|I4|ndwe_x~10\ # !\inst1|I4|ndre_x~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "40FF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|i~2617\,
	datab => \inst1|I2|ndwe_x~51\,
	datac => \inst1|I4|ndwe_x~10\,
	datad => \inst1|I4|ndre_x~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|i~326\);

\inst4|i~331_I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|i~331\ = \inst4|dwait_c\ & !\inst4|reduce_or_23\ # !\inst4|dwait_c\ & (!\inst1|I4|daddr_x[9]~72\ # !\inst4|i~326\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "2777",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst4|dwait_c\,
	datab => \inst4|reduce_or_23\,
	datac => \inst4|i~326\,
	datad => \inst1|I4|daddr_x[9]~72\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|i~331\);

\inst4|dwait_c~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|dwait_c\ = DFFEA(!\inst4|i~331\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , , , )

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
	clk => \clk_in~combout\,
	datad => \inst4|i~331\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst4|dwait_c\);

\inst1|I2|E_x.dwait_e~0_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|E_x.dwait_e~0\ = \nreset_in~combout\ & \inst1|I2|i~219\ & \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\

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
	dataa => \nreset_in~combout\,
	datac => \inst1|I2|i~219\,
	datad => \inst1|I2|nreset_v_rtl_2|wysi_counter|safe_q[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|E_x.dwait_e~0\);

\inst1|I2|idata_c[3]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|idata_x[3]~18\ = \inst1|I2|E_x.dwait_e~0\ & K1_idata_c[3] # !\inst1|I2|E_x.dwait_e~0\ & \inst|altsyncram_component|q_a[3]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "F3C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datab => \inst1|I2|E_x.dwait_e~0\,
	datad => \inst|altsyncram_component|q_a[3]\,
	aclr => \NOT_nreset_in~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|idata_x[3]~18\);

\inst1|I2|TC_x[1]~22_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|TC_x[1]~22\ = \nreset_in~combout\ & (\inst1|I2|idata_x[3]~18\ # \inst1|I2|idata_x[0]~21\ & \inst1|I2|TD_x[3]~35\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "C888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I2|idata_x[3]~18\,
	datab => \nreset_in~combout\,
	datac => \inst1|I2|idata_x[0]~21\,
	datad => \inst1|I2|TD_x[3]~35\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|TC_x[1]~22\);

\inst1|I2|ndre_x~49_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I2|ndre_x~49\ = !\inst1|I2|TC_x[1]~22\ & \inst1|I2|C_raw~47\ & \inst1|I2|C_store_x~0\ & \inst1|I2|ndwe_x~51\

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
	dataa => \inst1|I2|TC_x[1]~22\,
	datab => \inst1|I2|C_raw~47\,
	datac => \inst1|I2|C_store_x~0\,
	datad => \inst1|I2|ndwe_x~51\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I2|ndre_x~49\);

\inst1|I4|ndre_x~1_I\ : cyclone_lcell 
-- Equation(s):
-- \inst1|I4|ndre_x~1\ = \inst1|I4|i~2617\ # !\inst1|I2|ndre_x~49\ # !\inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\ # !\nreset_in~combout\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "FF7F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \nreset_in~combout\,
	datab => \inst1|I4|nreset_v_rtl_4|wysi_counter|safe_q[1]\,
	datac => \inst1|I2|ndre_x~49\,
	datad => \inst1|I4|i~2617\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst1|I4|ndre_x~1\);

\inst4|ndre_c~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|ndre_c\ = DFFEA(!\inst1|I4|ndre_x~1\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , !\inst4|dwait_c\, , )

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
	clk => \clk_in~combout\,
	datad => \inst1|I4|ndre_x~1\,
	aclr => \NOT_nreset_in~combout\,
	ena => \NOT_inst4|dwait_c\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst4|ndre_c\);

\inst4|i~88_I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|i~88\ = !\inst4|ndre_c\ # !\nreset_in~combout\

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
	datac => \nreset_in~combout\,
	datad => \inst4|ndre_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|i~88\);

\inst4|ndwe_c~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|ndwe_c\ = DFFEA(!\inst1|I4|ndwe_x~1\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , !\inst4|dwait_c\, , )

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
	clk => \clk_in~combout\,
	datad => \inst1|I4|ndwe_x~1\,
	aclr => \NOT_nreset_in~combout\,
	ena => \NOT_inst4|dwait_c\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst4|ndwe_c\);

\inst4|reduce_or_84~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|reduce_or_84\ = !\inst4|nwait_c[0]\ # !\inst4|nwait_c[2]\ # !\inst4|nwait_c[1]\ # !\inst4|reduce_or_23~0\

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
	dataa => \inst4|reduce_or_23~0\,
	datab => \inst4|nwait_c[1]\,
	datac => \inst4|nwait_c[2]\,
	datad => \inst4|nwait_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|reduce_or_84\);

\inst4|cpu_daddr_c[9]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|cpu_daddr_x[9]~56\ = \nreset_in~combout\ & (\inst4|reduce_or_84\ & F1_cpu_daddr_c[9] # !\inst4|reduce_or_84\ & \inst1|I4|daddr_x[9]~72\)
-- \inst4|cpu_daddr_c[9]\ = DFFEA(\inst4|cpu_daddr_x[9]~56\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , !\inst4|dwait_c\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "C480",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst4|reduce_or_84\,
	datab => \nreset_in~combout\,
	datad => \inst1|I4|daddr_x[9]~72\,
	aclr => \NOT_nreset_in~combout\,
	ena => \NOT_inst4|dwait_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|cpu_daddr_x[9]~56\,
	regout => \inst4|cpu_daddr_c[9]\);

\inst4|i~114_I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|i~114\ = \inst4|cpu_daddr_c[9]\ & (\inst1|I4|ndre_x~1\ # \inst4|cpu_daddr_x[9]~56\) # !\inst4|cpu_daddr_c[9]\ & !\inst1|I4|ndre_x~1\ & \inst4|cpu_daddr_x[9]~56\

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
	datab => \inst4|cpu_daddr_c[9]\,
	datac => \inst1|I4|ndre_x~1\,
	datad => \inst4|cpu_daddr_x[9]~56\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|i~114\);

\inst4|cpu_daddr_c[8]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|cpu_daddr_x[8]~63\ = \nreset_in~combout\ & (\inst4|reduce_or_84\ & F1_cpu_daddr_c[8] # !\inst4|reduce_or_84\ & \inst1|I4|daddr_x[8]~79\)
-- \inst4|cpu_daddr_c[8]\ = DFFEA(\inst4|cpu_daddr_x[8]~63\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , !\inst4|dwait_c\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "A280",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \nreset_in~combout\,
	datab => \inst4|reduce_or_84\,
	datad => \inst1|I4|daddr_x[8]~79\,
	aclr => \NOT_nreset_in~combout\,
	ena => \NOT_inst4|dwait_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|cpu_daddr_x[8]~63\,
	regout => \inst4|cpu_daddr_c[8]\);

\inst4|i~120_I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|i~120\ = \inst1|I4|ndre_x~1\ & \inst4|cpu_daddr_c[8]\ # !\inst1|I4|ndre_x~1\ & \inst4|cpu_daddr_x[8]~63\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F5A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ndre_x~1\,
	datac => \inst4|cpu_daddr_c[8]\,
	datad => \inst4|cpu_daddr_x[8]~63\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|i~120\);

\inst4|cpu_daddr_c[7]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|cpu_daddr_x[7]~70\ = \nreset_in~combout\ & (\inst4|reduce_or_84\ & F1_cpu_daddr_c[7] # !\inst4|reduce_or_84\ & \inst1|I4|daddr_x[7]~86\)
-- \inst4|cpu_daddr_c[7]\ = DFFEA(\inst4|cpu_daddr_x[7]~70\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , !\inst4|dwait_c\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "A280",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \nreset_in~combout\,
	datab => \inst4|reduce_or_84\,
	datad => \inst1|I4|daddr_x[7]~86\,
	aclr => \NOT_nreset_in~combout\,
	ena => \NOT_inst4|dwait_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|cpu_daddr_x[7]~70\,
	regout => \inst4|cpu_daddr_c[7]\);

\inst4|i~126_I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|i~126\ = \inst4|cpu_daddr_c[7]\ & (\inst4|cpu_daddr_x[7]~70\ # \inst1|I4|ndre_x~1\) # !\inst4|cpu_daddr_c[7]\ & \inst4|cpu_daddr_x[7]~70\ & !\inst1|I4|ndre_x~1\

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
	datab => \inst4|cpu_daddr_c[7]\,
	datac => \inst4|cpu_daddr_x[7]~70\,
	datad => \inst1|I4|ndre_x~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|i~126\);

\inst4|cpu_daddr_c[6]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|cpu_daddr_x[6]~77\ = \nreset_in~combout\ & (\inst4|reduce_or_84\ & F1_cpu_daddr_c[6] # !\inst4|reduce_or_84\ & \inst1|I4|daddr_x[6]~93\)
-- \inst4|cpu_daddr_c[6]\ = DFFEA(\inst4|cpu_daddr_x[6]~77\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , !\inst4|dwait_c\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "A280",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \nreset_in~combout\,
	datab => \inst4|reduce_or_84\,
	datad => \inst1|I4|daddr_x[6]~93\,
	aclr => \NOT_nreset_in~combout\,
	ena => \NOT_inst4|dwait_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|cpu_daddr_x[6]~77\,
	regout => \inst4|cpu_daddr_c[6]\);

\inst4|i~132_I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|i~132\ = \inst1|I4|ndre_x~1\ & \inst4|cpu_daddr_c[6]\ # !\inst1|I4|ndre_x~1\ & \inst4|cpu_daddr_x[6]~77\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F3C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst1|I4|ndre_x~1\,
	datac => \inst4|cpu_daddr_c[6]\,
	datad => \inst4|cpu_daddr_x[6]~77\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|i~132\);

\inst4|cpu_daddr_c[5]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|cpu_daddr_x[5]~84\ = \nreset_in~combout\ & (\inst4|reduce_or_84\ & F1_cpu_daddr_c[5] # !\inst4|reduce_or_84\ & \inst1|I4|daddr_x[5]~100\)
-- \inst4|cpu_daddr_c[5]\ = DFFEA(\inst4|cpu_daddr_x[5]~84\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , !\inst4|dwait_c\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "A280",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \nreset_in~combout\,
	datab => \inst4|reduce_or_84\,
	datad => \inst1|I4|daddr_x[5]~100\,
	aclr => \NOT_nreset_in~combout\,
	ena => \NOT_inst4|dwait_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|cpu_daddr_x[5]~84\,
	regout => \inst4|cpu_daddr_c[5]\);

\inst4|i~138_I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|i~138\ = \inst4|cpu_daddr_x[5]~84\ & (\inst4|cpu_daddr_c[5]\ # !\inst1|I4|ndre_x~1\) # !\inst4|cpu_daddr_x[5]~84\ & \inst4|cpu_daddr_c[5]\ & \inst1|I4|ndre_x~1\

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
	dataa => \inst4|cpu_daddr_x[5]~84\,
	datab => \inst4|cpu_daddr_c[5]\,
	datac => \inst1|I4|ndre_x~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|i~138\);

\inst4|cpu_daddr_c[4]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|cpu_daddr_x[4]~91\ = \nreset_in~combout\ & (\inst4|reduce_or_84\ & F1_cpu_daddr_c[4] # !\inst4|reduce_or_84\ & \inst1|I4|daddr_x[4]~107\)
-- \inst4|cpu_daddr_c[4]\ = DFFEA(\inst4|cpu_daddr_x[4]~91\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , !\inst4|dwait_c\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "A280",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \nreset_in~combout\,
	datab => \inst4|reduce_or_84\,
	datad => \inst1|I4|daddr_x[4]~107\,
	aclr => \NOT_nreset_in~combout\,
	ena => \NOT_inst4|dwait_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|cpu_daddr_x[4]~91\,
	regout => \inst4|cpu_daddr_c[4]\);

\inst4|i~144_I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|i~144\ = \inst4|cpu_daddr_c[4]\ & (\inst1|I4|ndre_x~1\ # \inst4|cpu_daddr_x[4]~91\) # !\inst4|cpu_daddr_c[4]\ & !\inst1|I4|ndre_x~1\ & \inst4|cpu_daddr_x[4]~91\

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
	datab => \inst4|cpu_daddr_c[4]\,
	datac => \inst1|I4|ndre_x~1\,
	datad => \inst4|cpu_daddr_x[4]~91\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|i~144\);

\inst4|cpu_daddr_c[3]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|cpu_daddr_x[3]~98\ = \nreset_in~combout\ & (\inst4|reduce_or_84\ & F1_cpu_daddr_c[3] # !\inst4|reduce_or_84\ & \inst1|I4|daddr_x[3]~114\)
-- \inst4|cpu_daddr_c[3]\ = DFFEA(\inst4|cpu_daddr_x[3]~98\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , !\inst4|dwait_c\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "E200",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \inst1|I4|daddr_x[3]~114\,
	datab => \inst4|reduce_or_84\,
	datad => \nreset_in~combout\,
	aclr => \NOT_nreset_in~combout\,
	ena => \NOT_inst4|dwait_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|cpu_daddr_x[3]~98\,
	regout => \inst4|cpu_daddr_c[3]\);

\inst4|i~150_I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|i~150\ = \inst4|cpu_daddr_c[3]\ & (\inst4|cpu_daddr_x[3]~98\ # \inst1|I4|ndre_x~1\) # !\inst4|cpu_daddr_c[3]\ & \inst4|cpu_daddr_x[3]~98\ & !\inst1|I4|ndre_x~1\

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
	datab => \inst4|cpu_daddr_c[3]\,
	datac => \inst4|cpu_daddr_x[3]~98\,
	datad => \inst1|I4|ndre_x~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|i~150\);

\inst4|cpu_daddr_c[2]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|cpu_daddr_x[2]~105\ = \nreset_in~combout\ & (\inst4|reduce_or_84\ & F1_cpu_daddr_c[2] # !\inst4|reduce_or_84\ & \inst1|I4|daddr_x[2]~121\)
-- \inst4|cpu_daddr_c[2]\ = DFFEA(\inst4|cpu_daddr_x[2]~105\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , !\inst4|dwait_c\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "A280",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \nreset_in~combout\,
	datab => \inst4|reduce_or_84\,
	datad => \inst1|I4|daddr_x[2]~121\,
	aclr => \NOT_nreset_in~combout\,
	ena => \NOT_inst4|dwait_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|cpu_daddr_x[2]~105\,
	regout => \inst4|cpu_daddr_c[2]\);

\inst4|i~156_I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|i~156\ = \inst1|I4|ndre_x~1\ & \inst4|cpu_daddr_c[2]\ # !\inst1|I4|ndre_x~1\ & \inst4|cpu_daddr_x[2]~105\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	lut_mask => "F5A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|I4|ndre_x~1\,
	datac => \inst4|cpu_daddr_c[2]\,
	datad => \inst4|cpu_daddr_x[2]~105\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|i~156\);

\inst4|cpu_daddr_c[1]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|cpu_daddr_x[1]~112\ = \nreset_in~combout\ & (\inst4|reduce_or_84\ & F1_cpu_daddr_c[1] # !\inst4|reduce_or_84\ & \inst1|I4|daddr_x[1]~128\)
-- \inst4|cpu_daddr_c[1]\ = DFFEA(\inst4|cpu_daddr_x[1]~112\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , !\inst4|dwait_c\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "A280",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \nreset_in~combout\,
	datab => \inst4|reduce_or_84\,
	datad => \inst1|I4|daddr_x[1]~128\,
	aclr => \NOT_nreset_in~combout\,
	ena => \NOT_inst4|dwait_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|cpu_daddr_x[1]~112\,
	regout => \inst4|cpu_daddr_c[1]\);

\inst4|i~162_I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|i~162\ = \inst4|cpu_daddr_x[1]~112\ & (\inst4|cpu_daddr_c[1]\ # !\inst1|I4|ndre_x~1\) # !\inst4|cpu_daddr_x[1]~112\ & \inst4|cpu_daddr_c[1]\ & \inst1|I4|ndre_x~1\

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
	dataa => \inst4|cpu_daddr_x[1]~112\,
	datab => \inst4|cpu_daddr_c[1]\,
	datad => \inst1|I4|ndre_x~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|i~162\);

\inst4|cpu_daddr_c[0]~I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|cpu_daddr_x[0]~119\ = \nreset_in~combout\ & (\inst4|reduce_or_84\ & F1_cpu_daddr_c[0] # !\inst4|reduce_or_84\ & \inst1|I4|daddr_x[0]~135\)
-- \inst4|cpu_daddr_c[0]\ = DFFEA(\inst4|cpu_daddr_x[0]~119\, GLOBAL(\clk_in~combout\), GLOBAL(\nreset_in~combout\), , !\inst4|dwait_c\, , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	synch_mode => "off",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	lut_mask => "A280",
	output_mode => "reg_and_comb")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => \nreset_in~combout\,
	datab => \inst4|reduce_or_84\,
	datad => \inst1|I4|daddr_x[0]~135\,
	aclr => \NOT_nreset_in~combout\,
	ena => \NOT_inst4|dwait_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|cpu_daddr_x[0]~119\,
	regout => \inst4|cpu_daddr_c[0]\);

\inst4|i~168_I\ : cyclone_lcell 
-- Equation(s):
-- \inst4|i~168\ = \inst4|cpu_daddr_c[0]\ & (\inst4|cpu_daddr_x[0]~119\ # \inst1|I4|ndre_x~1\) # !\inst4|cpu_daddr_c[0]\ & \inst4|cpu_daddr_x[0]~119\ & !\inst1|I4|ndre_x~1\

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
	datab => \inst4|cpu_daddr_c[0]\,
	datac => \inst4|cpu_daddr_x[0]~119\,
	datad => \inst1|I4|ndre_x~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst4|i~168\);

\NRE_EXT~I\ : cyclone_io 
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
	datain => \inst4|i~88\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_NRE_EXT);

\NWE_EXT~I\ : cyclone_io 
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
	datain => \NOT_inst4|ndwe_c\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_NWE_EXT);

\NCS_EXT~I\ : cyclone_io 
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
	datain => \NOT_inst3|nCS_EXT_c\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_NCS_EXT);

\ADDR_OUT_EXT[9]~I\ : cyclone_io 
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
	datain => \inst4|i~114\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_ADDR_OUT_EXT(9));

\ADDR_OUT_EXT[8]~I\ : cyclone_io 
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
	datain => \inst4|i~120\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_ADDR_OUT_EXT(8));

\ADDR_OUT_EXT[7]~I\ : cyclone_io 
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
	datain => \inst4|i~126\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_ADDR_OUT_EXT(7));

\ADDR_OUT_EXT[6]~I\ : cyclone_io 
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
	datain => \inst4|i~132\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_ADDR_OUT_EXT(6));

\ADDR_OUT_EXT[5]~I\ : cyclone_io 
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
	datain => \inst4|i~138\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_ADDR_OUT_EXT(5));

\ADDR_OUT_EXT[4]~I\ : cyclone_io 
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
	datain => \inst4|i~144\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_ADDR_OUT_EXT(4));

\ADDR_OUT_EXT[3]~I\ : cyclone_io 
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
	datain => \inst4|i~150\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_ADDR_OUT_EXT(3));

\ADDR_OUT_EXT[2]~I\ : cyclone_io 
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
	datain => \inst4|i~156\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_ADDR_OUT_EXT(2));

\ADDR_OUT_EXT[1]~I\ : cyclone_io 
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
	datain => \inst4|i~162\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_ADDR_OUT_EXT(1));

\ADDR_OUT_EXT[0]~I\ : cyclone_io 
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
	datain => \inst4|i~168\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_ADDR_OUT_EXT(0));

\DATA_OUT_EXT[15]~I\ : cyclone_io 
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
	datain => \inst1|I4|data_ox[15]~4\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_DATA_OUT_EXT(15));

\DATA_OUT_EXT[14]~I\ : cyclone_io 
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
	datain => \inst1|I4|data_ox[14]~5\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_DATA_OUT_EXT(14));

\DATA_OUT_EXT[13]~I\ : cyclone_io 
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
	datain => \inst1|I4|data_ox[13]~0\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_DATA_OUT_EXT(13));

\DATA_OUT_EXT[12]~I\ : cyclone_io 
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
	datain => \inst1|I4|data_ox[12]~6\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_DATA_OUT_EXT(12));

\DATA_OUT_EXT[11]~I\ : cyclone_io 
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
	datain => \inst1|I4|data_ox[11]~7\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_DATA_OUT_EXT(11));

\DATA_OUT_EXT[10]~I\ : cyclone_io 
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
	datain => \inst1|I4|data_ox[10]~8\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_DATA_OUT_EXT(10));

\DATA_OUT_EXT[9]~I\ : cyclone_io 
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
	datain => \inst1|I4|data_ox[9]~9\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_DATA_OUT_EXT(9));

\DATA_OUT_EXT[8]~I\ : cyclone_io 
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
	datain => \inst1|I4|data_ox[8]~10\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_DATA_OUT_EXT(8));

\DATA_OUT_EXT[7]~I\ : cyclone_io 
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
	datain => \inst1|I4|data_ox[7]~11\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_DATA_OUT_EXT(7));

\DATA_OUT_EXT[6]~I\ : cyclone_io 
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
	datain => \inst1|I4|data_ox[6]~1\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_DATA_OUT_EXT(6));

\DATA_OUT_EXT[5]~I\ : cyclone_io 
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
	datain => \inst1|I4|data_ox[5]~2\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_DATA_OUT_EXT(5));

\DATA_OUT_EXT[4]~I\ : cyclone_io 
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
	datain => \inst1|I4|data_ox[4]~3\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_DATA_OUT_EXT(4));

\DATA_OUT_EXT[3]~I\ : cyclone_io 
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
	datain => \inst1|I4|data_ox[3]~12\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_DATA_OUT_EXT(3));

\DATA_OUT_EXT[2]~I\ : cyclone_io 
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
	datain => \inst1|I4|data_ox[2]~13\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_DATA_OUT_EXT(2));

\DATA_OUT_EXT[1]~I\ : cyclone_io 
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
	datain => \inst1|I4|data_ox[1]~14\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_DATA_OUT_EXT(1));

\DATA_OUT_EXT[0]~I\ : cyclone_io 
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
	datain => \inst1|I4|data_ox[0]~15\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	padio => ww_DATA_OUT_EXT(0));
END structure;


