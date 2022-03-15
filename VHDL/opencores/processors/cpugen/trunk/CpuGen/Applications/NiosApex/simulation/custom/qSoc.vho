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

-- DATE "01/13/2004 21:43:02"

--
-- Device: Altera EP20K200EFC484-2X Package FBGA484
-- 

-- 
-- This VHDL file should be used for Custom VHDL only
-- 

LIBRARY IEEE, apex20ke;
USE IEEE.std_logic_1164.all;
USE apex20ke.apex20ke_components.all;

ENTITY 	qSoc IS
    PORT (
	user_pb2 : IN std_logic;
	user_sw : IN std_logic_vector(7 DOWNTO 0);
	RXD : IN std_logic;
	clk : IN std_logic;
	user_pb1 : IN std_logic;
	user_LED1 : OUT std_logic;
	TXD : OUT std_logic;
	user_LED0 : OUT std_logic;
	display_e : OUT std_logic;
	display_rw : OUT std_logic;
	display_rs : OUT std_logic;
	HEADER_SWITCH_enable1_n : OUT std_logic;
	display : OUT std_logic_vector(7 DOWNTO 0);
	hex : OUT std_logic_vector(7 DOWNTO 0)
	);
END qSoc;

ARCHITECTURE structure OF qSoc IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL devoe : std_logic := '0';
SIGNAL ww_user_pb2 : std_logic;
SIGNAL ww_user_sw : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_RXD : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_user_pb1 : std_logic;
SIGNAL ww_user_LED1 : std_logic;
SIGNAL ww_TXD : std_logic;
SIGNAL ww_user_LED0 : std_logic;
SIGNAL ww_display_e : std_logic;
SIGNAL ww_display_rw : std_logic;
SIGNAL ww_display_rs : std_logic;
SIGNAL ww_HEADER_SWITCH_enable1_n : std_logic;
SIGNAL ww_display : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_hex : std_logic_vector(7 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][6]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][6]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][4]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][4]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][5]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][5]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][3]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][3]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][0]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][0]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][2]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][2]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][1]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][1]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][7]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][7]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][8]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][8]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][12]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][12]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][0]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][0]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][1]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][1]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][2]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][2]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][3]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][3]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][4]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][4]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][9]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][9]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][5]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][5]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][10]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][10]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][6]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][6]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][7]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][7]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][11]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][11]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][8]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][8]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][9]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][9]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][13]_waddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][13]_raddr\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][0]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][1]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][2]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][3]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][5]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][6]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][7]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][8]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|segment[0][13]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][9]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|segment[0][10]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|segment[0][8]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][4]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|segment[0][0]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|segment[0][1]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|segment[0][4]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|segment[0][9]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|segment[0][5]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|segment[0][12]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|segment[0][11]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|segment[0][7]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|segment[0][3]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|segment[0][2]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|segment[0][6]_modesel\ : std_logic_vector(17 DOWNTO 0) := "000000000000010101";
SIGNAL \inst9|inst1|I2|TD_x[3]~36_1\ : std_logic;
SIGNAL \inst9|inst1|I2|E_x.int_e~80_1\ : std_logic;
SIGNAL \inst9|inst1|I4|i~796_1\ : std_logic;
SIGNAL \inst9|inst1|I4|i~816_1\ : std_logic;
SIGNAL \rtl~2426_1\ : std_logic;
SIGNAL \rtl~2416_1\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~608_1\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[2]~2292_1\ : std_logic;
SIGNAL \user_pb2~padio\ : std_logic;
SIGNAL \user_sw[7]~padio\ : std_logic;
SIGNAL \user_sw[6]~padio\ : std_logic;
SIGNAL \user_sw[5]~padio\ : std_logic;
SIGNAL \user_sw[4]~padio\ : std_logic;
SIGNAL \user_sw[3]~padio\ : std_logic;
SIGNAL \user_sw[2]~padio\ : std_logic;
SIGNAL \user_sw[1]~padio\ : std_logic;
SIGNAL \user_sw[0]~padio\ : std_logic;
SIGNAL \RXD~padio\ : std_logic;
SIGNAL \clk~padio\ : std_logic;
SIGNAL \user_pb1~padio\ : std_logic;
SIGNAL \user_LED1~padio\ : std_logic;
SIGNAL \TXD~padio\ : std_logic;
SIGNAL \user_LED0~padio\ : std_logic;
SIGNAL \display_e~padio\ : std_logic;
SIGNAL \display_rw~padio\ : std_logic;
SIGNAL \display_rs~padio\ : std_logic;
SIGNAL \HEADER_SWITCH_enable1_n~padio\ : std_logic;
SIGNAL \display[7]~padio\ : std_logic;
SIGNAL \display[6]~padio\ : std_logic;
SIGNAL \display[5]~padio\ : std_logic;
SIGNAL \display[4]~padio\ : std_logic;
SIGNAL \display[3]~padio\ : std_logic;
SIGNAL \display[2]~padio\ : std_logic;
SIGNAL \display[1]~padio\ : std_logic;
SIGNAL \display[0]~padio\ : std_logic;
SIGNAL \hex[7]~padio\ : std_logic;
SIGNAL \hex[6]~padio\ : std_logic;
SIGNAL \hex[5]~padio\ : std_logic;
SIGNAL \hex[4]~padio\ : std_logic;
SIGNAL \hex[3]~padio\ : std_logic;
SIGNAL \hex[2]~padio\ : std_logic;
SIGNAL \hex[1]~padio\ : std_logic;
SIGNAL \hex[0]~padio\ : std_logic;
SIGNAL \clk~combout\ : std_logic;
SIGNAL \user_pb1~combout\ : std_logic;
SIGNAL \inst9|inst7\ : std_logic;
SIGNAL \inst9|inst1|I2|LessThan_7~5\ : std_logic;
SIGNAL \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[0]\ : std_logic;
SIGNAL \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|counter_cell[0]~COUT\ : std_logic;
SIGNAL \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\ : std_logic;
SIGNAL \inst9|inst1|I2|i~2\ : std_logic;
SIGNAL \~GND\ : std_logic;
SIGNAL \inst9|inst1|I1|LessThan_7~5\ : std_logic;
SIGNAL \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[0]\ : std_logic;
SIGNAL \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|counter_cell[0]~COUT\ : std_logic;
SIGNAL \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\ : std_logic;
SIGNAL \inst9|inst1|I1|i~2\ : std_logic;
SIGNAL \inst9|inst1|I4|LessThan_39~5\ : std_logic;
SIGNAL \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[0]\ : std_logic;
SIGNAL \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|counter_cell[0]~COUT\ : std_logic;
SIGNAL \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ : std_logic;
SIGNAL \inst9|inst1|I4|i~18\ : std_logic;
SIGNAL \inst9|inst1|I2|E_c~10\ : std_logic;
SIGNAL \inst9|inst1|I2|skip_x~107\ : std_logic;
SIGNAL \inst9|inst1|I3|acc[0][4]~4339\ : std_logic;
SIGNAL \inst9|inst1|I3|reduce_nor_71\ : std_logic;
SIGNAL \inst9|inst4|i~379\ : std_logic;
SIGNAL \inst9|inst4|i~48\ : std_logic;
SIGNAL \inst9|inst1|I4|data_ox[4]~3\ : std_logic;
SIGNAL \inst9|inst1|I2|E_x.dwait_e~0\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[2]~27\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[5]~34\ : std_logic;
SIGNAL \inst9|inst1|I4|reduce_nor_106\ : std_logic;
SIGNAL \inst9|inst1|I2|C_raw~56\ : std_logic;
SIGNAL \inst9|inst1|I2|skip_x~41\ : std_logic;
SIGNAL \inst9|inst1|I2|skip_x~112\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[7]~30\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[6]~26\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[7]~29\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[6]~27\ : std_logic;
SIGNAL \inst9|inst1|I4|data_ox[1]~6\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[3]~30\ : std_logic;
SIGNAL \inst9|inst1|I2|TC_x[1]~22\ : std_logic;
SIGNAL \inst9|inst1|I2|ndwe_x~45\ : std_logic;
SIGNAL \inst9|inst1|I4|reduce_nor_119\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_we_c\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_i[4]~2\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_i[3]\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_x[3]~8\ : std_logic;
SIGNAL \inst9|inst1|I2|E_x.iwait_e~1\ : std_logic;
SIGNAL \inst9|inst1|I2|S_x.normal~6\ : std_logic;
SIGNAL \inst9|inst1|I2|S_c~10\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[2]~25\ : std_logic;
SIGNAL \inst9|inst1|I2|TC_x[1]~532\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[5]~32\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[5]~33\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[6]~991\ : std_logic;
SIGNAL \inst9|inst1|I2|TC_x[2]~571\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[3]~14\ : std_logic;
SIGNAL \inst9|inst1|I2|TC_x[0]~550\ : std_logic;
SIGNAL \inst9|inst1|I2|TC_x[0]~147\ : std_logic;
SIGNAL \inst9|inst1|I2|i~513\ : std_logic;
SIGNAL \inst9|inst1|I2|i~514\ : std_logic;
SIGNAL \inst9|inst1|I2|i~511\ : std_logic;
SIGNAL \inst9|inst1|I2|int_stop_c\ : std_logic;
SIGNAL \inst9|inst1|I2|int_stop_x~6\ : std_logic;
SIGNAL \inst9|inst1|I2|int_stop_x~11\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_c[3]\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_x[2]~5\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_i[2]\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_c[2]\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_i[1]\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_x[1]~23\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_c[1]\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[0]~17\ : std_logic;
SIGNAL \inst9|inst1|I4|data_ox[0]~7\ : std_logic;
SIGNAL \inst9|inst1|I2|TC_x[1]~42\ : std_logic;
SIGNAL \inst9|inst1|I2|reduce_nor_128\ : std_logic;
SIGNAL \inst9|inst1|I2|i~420\ : std_logic;
SIGNAL \inst9|inst1|I2|i~103\ : std_logic;
SIGNAL \inst9|inst1|I2|pc_mux_x[2]~348\ : std_logic;
SIGNAL \inst9|inst1|I2|TC_x[0]~146\ : std_logic;
SIGNAL \inst9|inst1|I2|pc_mux_x[2]~377\ : std_logic;
SIGNAL \inst9|inst1|I2|pc_mux_x[2]~446\ : std_logic;
SIGNAL \inst9|inst1|I2|pc_mux_x[2]~444\ : std_logic;
SIGNAL \inst9|inst1|I2|pc_mux_x[2]~443\ : std_logic;
SIGNAL \inst9|inst1|I2|pc_mux_x[1]~422\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_x[5]~20\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_i[5]\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_c[5]\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_x[4]~2\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_i[4]\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_c[4]\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104~3COUT\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104~4\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~68\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_i[4]\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~73\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_c[4]\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104~4COUT\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104~5\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~108\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_i[5]\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~113\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_c[5]\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[9]~55\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[5]~70\ : std_logic;
SIGNAL \inst9|inst4|daddr_c[5]\ : std_logic;
SIGNAL \inst9|inst1|I4|i~760\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[5]~76\ : std_logic;
SIGNAL \inst9|inst4|i~444\ : std_logic;
SIGNAL \inst9|inst1|I1|pc[5]\ : std_logic;
SIGNAL \inst9|inst1|I1|pc[4]\ : std_logic;
SIGNAL \inst9|inst1|I2|pc_mux_x[1]~408\ : std_logic;
SIGNAL \inst9|inst1|I2|pc_mux_x[1]~48\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[3]~386\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[2]~350\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[1]~321\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[0]~292\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~0\ : std_logic;
SIGNAL \inst9|inst1|I2|i~510\ : std_logic;
SIGNAL \inst9|inst1|I2|pc_mux_x[1]~53\ : std_logic;
SIGNAL \inst9|inst1|I2|i~422\ : std_logic;
SIGNAL \inst9|inst1|I2|pc_mux_x[0]~402\ : std_logic;
SIGNAL \rtl~0\ : std_logic;
SIGNAL \inst9|inst1|I3|skip_l~8\ : std_logic;
SIGNAL \inst9|inst1|I2|skip_x~61\ : std_logic;
SIGNAL \inst9|inst1|I2|pc_mux_x[0]~390\ : std_logic;
SIGNAL \inst9|inst1|I2|pc_mux_x[0]~30\ : std_logic;
SIGNAL \inst9|inst1|I2|pc_mux_x[0]~33\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[0]~293\ : std_logic;
SIGNAL \inst9|inst1|I2|pc_mux_x[2]~386\ : std_logic;
SIGNAL \inst9|inst1|I2|i~515\ : std_logic;
SIGNAL \inst9|inst1|I2|pc_mux_x[2]~445\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_59~8\ : std_logic;
SIGNAL \rtl~10683\ : std_logic;
SIGNAL \rtl~1455\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_59~9\ : std_logic;
SIGNAL \rtl~313\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_49_rtl_59_rtl_294~0\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_49_rtl_59_rtl_294~1\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_37_rtl_186~0\ : std_logic;
SIGNAL \rtl~1837\ : std_logic;
SIGNAL \rtl~1836\ : std_logic;
SIGNAL \inst9|inst1|I1|i~15\ : std_logic;
SIGNAL \inst9|inst1|I1|i~16\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_17_rtl_16~0\ : std_logic;
SIGNAL \inst9|inst11|inst8|addr_c[0]\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15~0\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15_rtl_477~10\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_17_rtl_16~0COUT\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_17_rtl_16~1\ : std_logic;
SIGNAL \inst9|inst11|inst8|addr_c[1]\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15~0COUT\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15~1\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15_rtl_477~13\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_17_rtl_16~1COUT\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_17_rtl_16~2\ : std_logic;
SIGNAL \inst9|inst11|inst8|addr_c[2]\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15~1COUT\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15~2\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15_rtl_477~16\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_17_rtl_16~2COUT\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_17_rtl_16~3\ : std_logic;
SIGNAL \inst9|inst11|inst8|addr_c[3]\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15~2COUT\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15~3\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15_rtl_477~19\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_17_rtl_16~3COUT\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_17_rtl_16~4\ : std_logic;
SIGNAL \inst9|inst11|inst8|addr_c[4]\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15~3COUT\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15~4\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15_rtl_477~22\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_17_rtl_16~4COUT\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_17_rtl_16~5\ : std_logic;
SIGNAL \inst9|inst11|inst8|addr_c[5]\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15~4COUT\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15~5\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15_rtl_477~25\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_17_rtl_16~5COUT\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_17_rtl_16~6\ : std_logic;
SIGNAL \inst9|inst11|inst8|addr_c[6]\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15~5COUT\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15~6\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15_rtl_477~28\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_17_rtl_16~6COUT\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_17_rtl_16~7\ : std_logic;
SIGNAL \inst9|inst11|inst8|addr_c[7]\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15~6COUT\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15~7\ : std_logic;
SIGNAL \inst9|inst11|inst8|add_15_rtl_477~31\ : std_logic;
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|q[0]\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[0]~297\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[0]~296\ : std_logic;
SIGNAL \inst9|inst1|I1|pc[0]\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~0COUT\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~1\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[1]~322\ : std_logic;
SIGNAL \rtl~314\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_48_rtl_62_rtl_297~0\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_48_rtl_62_rtl_297~1\ : std_logic;
SIGNAL \rtl~1464\ : std_logic;
SIGNAL \rtl~1847\ : std_logic;
SIGNAL \rtl~1846\ : std_logic;
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|q[1]\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[1]~326\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[1]~325\ : std_logic;
SIGNAL \inst9|inst1|I1|pc[1]\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~1COUT\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~2\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[2]~351\ : std_logic;
SIGNAL \rtl~1473\ : std_logic;
SIGNAL \rtl~1857\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_47_rtl_65_rtl_300~0\ : std_logic;
SIGNAL \rtl~315\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_47_rtl_65_rtl_300~1\ : std_logic;
SIGNAL \rtl~1856\ : std_logic;
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|q[2]\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[2]~355\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[2]~354\ : std_logic;
SIGNAL \inst9|inst1|I1|pc[2]\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~2COUT\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~3\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[3]~387\ : std_logic;
SIGNAL \rtl~1867\ : std_logic;
SIGNAL \rtl~1482\ : std_logic;
SIGNAL \rtl~316\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_46_rtl_68_rtl_303~0\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_46_rtl_68_rtl_303~1\ : std_logic;
SIGNAL \rtl~1866\ : std_logic;
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|q[3]\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[3]~380\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[3]~390\ : std_logic;
SIGNAL \inst9|inst1|I1|pc[3]\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~3COUT\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~4COUT\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~5\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[5]~531\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[5]~530\ : std_logic;
SIGNAL \rtl~1500\ : std_logic;
SIGNAL \rtl~1887\ : std_logic;
SIGNAL \rtl~318\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_44_rtl_74_rtl_309~0\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_44_rtl_74_rtl_309~1\ : std_logic;
SIGNAL \rtl~1886\ : std_logic;
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|q[5]\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[5]~524\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[5]~534\ : std_logic;
SIGNAL \inst9|inst4|i~93\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[11]~49\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_x[7]~14\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_i[7]\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_c[7]\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_i[6]\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_x[6]~17\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_c[6]\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104~5COUT\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104~6\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~98\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_i[6]\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~103\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_c[6]\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104~6COUT\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104~7\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~608\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~627\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_i[7]\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~30\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_c[7]\ : std_logic;
SIGNAL \inst9|inst1|I4|i~818\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[7]~266\ : std_logic;
SIGNAL \inst9|inst4|daddr_c[7]\ : std_logic;
SIGNAL \inst9|inst4|i~458\ : std_logic;
SIGNAL \inst9|inst1|I1|pc[7]\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[6]~602\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~5COUT\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~6\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[6]~603\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_43_rtl_77_rtl_312~0\ : std_logic;
SIGNAL \rtl~319\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_43_rtl_77_rtl_312~1\ : std_logic;
SIGNAL \rtl~1509\ : std_logic;
SIGNAL \rtl~1897\ : std_logic;
SIGNAL \rtl~1896\ : std_logic;
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|q[6]\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[6]~596\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[6]~606\ : std_logic;
SIGNAL \inst9|inst1|I1|pc[6]\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~6COUT\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~7\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[7]~675\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[7]~674\ : std_logic;
SIGNAL \rtl~1907\ : std_logic;
SIGNAL \rtl~1518\ : std_logic;
SIGNAL \rtl~320\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_42_rtl_80_rtl_315~0\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_42_rtl_80_rtl_315~1\ : std_logic;
SIGNAL \rtl~1906\ : std_logic;
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|q[7]\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[7]~668\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[7]~678\ : std_logic;
SIGNAL \inst9|inst4|i~105\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[12]~40\ : std_logic;
SIGNAL \inst9|inst4|daddr_c[8]\ : std_logic;
SIGNAL \inst9|inst4|i~468\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[8]~746\ : std_logic;
SIGNAL \inst9|inst1|I1|pc[8]\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~7COUT\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~8\ : std_logic;
SIGNAL \rtl~1527\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_41_rtl_83_rtl_318~0\ : std_logic;
SIGNAL \rtl~321\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_41_rtl_83_rtl_318~1\ : std_logic;
SIGNAL \rtl~1917\ : std_logic;
SIGNAL \rtl~1916\ : std_logic;
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|q[8]\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[8]~740\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[8]~747\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[8]~750\ : std_logic;
SIGNAL \inst9|inst4|i~111\ : std_logic;
SIGNAL \rtl~1927\ : std_logic;
SIGNAL \inst9|inst1|I1|pc[9]\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~8COUT\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~9\ : std_logic;
SIGNAL \rtl~1536\ : std_logic;
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|q[13]\ : std_logic;
SIGNAL \rtl~322\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_40_rtl_86_rtl_321~0\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_40_rtl_86_rtl_321~1\ : std_logic;
SIGNAL \rtl~1926\ : std_logic;
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|q[9]\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[9]~812\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[9]~818\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[9]~819\ : std_logic;
SIGNAL \inst9|inst1|I1|i~71\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[9]~2199\ : std_logic;
SIGNAL \inst9|inst4|i~46\ : std_logic;
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|q[10]\ : std_logic;
SIGNAL \inst9|inst1|I2|data_is_c[6]\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[10]~52\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[6]~77\ : std_logic;
SIGNAL \inst9|inst4|daddr_c[6]\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[6]~83\ : std_logic;
SIGNAL \inst9|inst4|i~451\ : std_logic;
SIGNAL \inst9|inst4|i~99\ : std_logic;
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|q[8]\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[4]~458\ : std_logic;
SIGNAL \inst9|inst1|I1|add_25~4\ : std_logic;
SIGNAL \rtl~1491\ : std_logic;
SIGNAL \rtl~1877\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_45_rtl_71_rtl_306~0\ : std_logic;
SIGNAL \rtl~317\ : std_logic;
SIGNAL \inst9|inst1|I1|Mux_45_rtl_71_rtl_306~1\ : std_logic;
SIGNAL \rtl~1876\ : std_logic;
SIGNAL \inst9|inst11|inst|lpm_ram_dq_component|sram|q[4]\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[4]~452\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[4]~459\ : std_logic;
SIGNAL \inst9|inst1|I1|iaddr_x[4]~462\ : std_logic;
SIGNAL \inst9|inst1|I2|data_is_c[4]\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[4]~32\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[4]~33\ : std_logic;
SIGNAL \inst9|inst4|daddr_c[4]\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[8]~43\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[4]~20\ : std_logic;
SIGNAL \inst9|inst4|i~437\ : std_logic;
SIGNAL \inst9|inst4|i~87\ : std_logic;
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|q[0]\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[0]~18\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[3]~15\ : std_logic;
SIGNAL \rtl~9984\ : std_logic;
SIGNAL \inst9|inst1|I2|Mux_69~0\ : std_logic;
SIGNAL \inst9|inst1|I2|TD_c[1]\ : std_logic;
SIGNAL \inst9|inst1|I2|Mux_68~0\ : std_logic;
SIGNAL \inst9|inst1|I2|TD_c[2]\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[0]~10\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[2]~1983\ : std_logic;
SIGNAL \inst9|inst1|I4|i~800\ : std_logic;
SIGNAL \inst9|inst1|I4|i~616\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_i[0]\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_x[0]~11\ : std_logic;
SIGNAL \inst9|inst1|I4|iinc_c[0]\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[0]~145\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[0]~2144\ : std_logic;
SIGNAL \inst9|inst1|I3|Mux_201_rtl_146~0\ : std_logic;
SIGNAL \inst9|inst12|reduce_or_23~33\ : std_logic;
SIGNAL \inst9|inst12|i~128\ : std_logic;
SIGNAL \inst9|inst12|i~1193\ : std_logic;
SIGNAL \inst9|inst12|i~1131\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[3]~19\ : std_logic;
SIGNAL \inst9|inst12|i~130\ : std_logic;
SIGNAL \inst9|inst12|nwait_c[0]\ : std_logic;
SIGNAL \inst9|inst12|nwait_c[0]~COUT\ : std_logic;
SIGNAL \inst9|inst12|nwait_c[1]\ : std_logic;
SIGNAL \inst9|inst12|nwait_c[1]~COUT\ : std_logic;
SIGNAL \inst9|inst12|nwait_c[2]\ : std_logic;
SIGNAL \inst9|inst12|nwait_c[2]~COUT\ : std_logic;
SIGNAL \inst9|inst12|nwait_c[3]\ : std_logic;
SIGNAL \inst9|inst12|nwait_c[3]~COUT\ : std_logic;
SIGNAL \inst9|inst12|nwait_c[4]\ : std_logic;
SIGNAL \inst9|inst12|nwait_c[4]~COUT\ : std_logic;
SIGNAL \inst9|inst12|nwait_c[5]\ : std_logic;
SIGNAL \inst9|inst12|nwait_c[5]~COUT\ : std_logic;
SIGNAL \inst9|inst12|nwait_c[6]\ : std_logic;
SIGNAL \inst9|inst12|nwait_c[6]~COUT\ : std_logic;
SIGNAL \inst9|inst12|nwait_c[7]\ : std_logic;
SIGNAL \inst9|inst12|reduce_or_23~16\ : std_logic;
SIGNAL \inst9|inst12|reduce_or_73~22\ : std_logic;
SIGNAL \inst9|inst12|reduce_or_73~21\ : std_logic;
SIGNAL \inst9|inst12|cpu_daddr_x[2]~347\ : std_logic;
SIGNAL \inst9|inst12|reduce_or_73~14\ : std_logic;
SIGNAL \inst9|inst12|cpu_daddr_x[3]~17\ : std_logic;
SIGNAL \inst9|inst12|cpu_daddr_c[3]\ : std_logic;
SIGNAL \inst9|inst12|cpu_daddr_x[3]~11\ : std_logic;
SIGNAL \inst9|inst12|i~109\ : std_logic;
SIGNAL \inst9|inst12|cpu_daddr_x[4]~19\ : std_logic;
SIGNAL \inst9|inst12|cpu_daddr_c[4]\ : std_logic;
SIGNAL \inst9|inst12|cpu_daddr_x[4]~12\ : std_logic;
SIGNAL \inst9|inst12|i~115\ : std_logic;
SIGNAL \inst9|inst12|reduce_or_73\ : std_logic;
SIGNAL \inst9|inst12|cpu_daddr_x[8]~32\ : std_logic;
SIGNAL \inst9|inst12|i~121\ : std_logic;
SIGNAL \inst9|inst12|cpu_daddr_x[2]~15\ : std_logic;
SIGNAL \inst9|inst12|cpu_daddr_c[2]\ : std_logic;
SIGNAL \inst9|inst12|cpu_daddr_x[2]~10\ : std_logic;
SIGNAL \inst9|inst12|i~103\ : std_logic;
SIGNAL \inst9|inst19|mux_c[1]\ : std_logic;
SIGNAL \inst9|inst19|mux_c[0]\ : std_logic;
SIGNAL \inst9|inst19|Mux_13_rtl_0~0\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[2]~2292\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[2]~2293\ : std_logic;
SIGNAL \RXD~combout\ : std_logic;
SIGNAL \inst9|inst|add_45~5\ : std_logic;
SIGNAL \rtl~9986\ : std_logic;
SIGNAL \rtl~843\ : std_logic;
SIGNAL \inst9|inst12|cpu_daddr_x[0]~23\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[0]~34\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[0]~35\ : std_logic;
SIGNAL \inst9|inst12|cpu_daddr_c[0]\ : std_logic;
SIGNAL \inst9|inst12|cpu_daddr_x[0]~14\ : std_logic;
SIGNAL \inst9|inst12|ndwe_c\ : std_logic;
SIGNAL \inst9|inst19|i~81\ : std_logic;
SIGNAL \inst9|inst2|i~455\ : std_logic;
SIGNAL \inst9|inst2|i~456\ : std_logic;
SIGNAL \inst9|inst|i~204\ : std_logic;
SIGNAL \inst9|inst|rx_clk_div[7]\ : std_logic;
SIGNAL \inst9|inst|rx_clk_div[6]\ : std_logic;
SIGNAL \inst9|inst|rx_clk_div[5]\ : std_logic;
SIGNAL \inst9|inst|rx_clk_div[4]\ : std_logic;
SIGNAL \inst9|inst|rx_clk_div[3]\ : std_logic;
SIGNAL \inst9|inst|rx_clk_div[2]\ : std_logic;
SIGNAL \inst9|inst|rx_clk_div[1]\ : std_logic;
SIGNAL \inst9|inst|rx_clk_div[0]\ : std_logic;
SIGNAL \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[0]~COUT\ : std_logic;
SIGNAL \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[1]\ : std_logic;
SIGNAL \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[1]~COUT\ : std_logic;
SIGNAL \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[2]\ : std_logic;
SIGNAL \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[2]~COUT\ : std_logic;
SIGNAL \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[3]\ : std_logic;
SIGNAL \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[3]~COUT\ : std_logic;
SIGNAL \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[4]\ : std_logic;
SIGNAL \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[4]~COUT\ : std_logic;
SIGNAL \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[5]\ : std_logic;
SIGNAL \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[5]~COUT\ : std_logic;
SIGNAL \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[6]\ : std_logic;
SIGNAL \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[6]~COUT\ : std_logic;
SIGNAL \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[7]\ : std_logic;
SIGNAL \inst9|inst|reduce_nor_7~35\ : std_logic;
SIGNAL \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[0]\ : std_logic;
SIGNAL \inst9|inst|reduce_nor_7~28\ : std_logic;
SIGNAL \inst9|inst|reduce_nor_7\ : std_logic;
SIGNAL \inst9|inst|rx_16_count[1]\ : std_logic;
SIGNAL \inst9|inst|add_45~10\ : std_logic;
SIGNAL \rtl~840\ : std_logic;
SIGNAL \inst9|inst|rx_16_count[2]\ : std_logic;
SIGNAL \inst9|inst|reduce_nor_27~4\ : std_logic;
SIGNAL \inst9|inst|rx_16_count[3]\ : std_logic;
SIGNAL \rtl~1957\ : std_logic;
SIGNAL \rtl~9994\ : std_logic;
SIGNAL \inst9|inst|rx_bit_count[0]\ : std_logic;
SIGNAL \rtl~9974\ : std_logic;
SIGNAL \inst9|inst|rx_bit_count[1]\ : std_logic;
SIGNAL \inst9|inst|add_39~7\ : std_logic;
SIGNAL \inst9|inst|rx_bit_count[2]\ : std_logic;
SIGNAL \rtl~10855\ : std_logic;
SIGNAL \inst9|inst|rx_bit_count[3]\ : std_logic;
SIGNAL \inst9|inst|rx_8_count[0]\ : std_logic;
SIGNAL \inst9|inst|rx_8_count[1]\ : std_logic;
SIGNAL \inst9|inst|add_72~52\ : std_logic;
SIGNAL \inst9|inst|rx_8_count[2]\ : std_logic;
SIGNAL \inst9|inst|reduce_nor_68\ : std_logic;
SIGNAL \inst9|inst|Mux_103~2\ : std_logic;
SIGNAL \inst9|inst|rx_s[1]\ : std_logic;
SIGNAL \inst9|inst|Mux_103~0\ : std_logic;
SIGNAL \rtl~9992\ : std_logic;
SIGNAL \inst9|inst|rx_8z_count[0]\ : std_logic;
SIGNAL \rtl~10859\ : std_logic;
SIGNAL \rtl~866\ : std_logic;
SIGNAL \inst9|inst|add_13~5\ : std_logic;
SIGNAL \inst9|inst|rx_8z_count[1]\ : std_logic;
SIGNAL \rtl~10000\ : std_logic;
SIGNAL \inst9|inst|rx_8z_count[3]\ : std_logic;
SIGNAL \rtl~9979\ : std_logic;
SIGNAL \inst9|inst|add_13~10\ : std_logic;
SIGNAL \rtl~863\ : std_logic;
SIGNAL \inst9|inst|rx_8z_count[2]\ : std_logic;
SIGNAL \rtl~10914\ : std_logic;
SIGNAL \rtl~10910\ : std_logic;
SIGNAL \rtl~9997\ : std_logic;
SIGNAL \inst9|inst|rx_s[0]\ : std_logic;
SIGNAL \inst9|inst|rx_16_count[0]\ : std_logic;
SIGNAL \inst9|inst|reduce_nor_27\ : std_logic;
SIGNAL \inst9|inst|Decoder_28~16\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[0]~4\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[0]\ : std_logic;
SIGNAL \inst9|inst|Decoder_28~24\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[8]~0\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[8]\ : std_logic;
SIGNAL \inst9|inst|rx_uart_fifo[4]~29\ : std_logic;
SIGNAL \inst9|inst|rx_uart_fifo[4]~37\ : std_logic;
SIGNAL \inst9|inst|rx_uart_fifo[0]\ : std_logic;
SIGNAL \inst9|inst5|i~137\ : std_logic;
SIGNAL \inst9|inst2|i~45\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_busy\ : std_logic;
SIGNAL \inst9|inst12|i~356\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[0]~236\ : std_logic;
SIGNAL \rtl~1759\ : std_logic;
SIGNAL \rtl~1761\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[0]~151\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[0]~2140\ : std_logic;
SIGNAL \inst9|inst1|I3|add_129~0\ : std_logic;
SIGNAL \rtl~10455\ : std_logic;
SIGNAL \rtl~1765\ : std_logic;
SIGNAL \rtl~2161\ : std_logic;
SIGNAL \rtl~2040\ : std_logic;
SIGNAL \inst9|inst1|I2|valid_x~23\ : std_logic;
SIGNAL \inst9|inst1|I2|valid_x~7\ : std_logic;
SIGNAL \inst9|inst1|I2|valid_c\ : std_logic;
SIGNAL \inst9|inst1|I3|i~147\ : std_logic;
SIGNAL \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[0]\ : std_logic;
SIGNAL \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|counter_cell[0]~COUT\ : std_logic;
SIGNAL \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[1]\ : std_logic;
SIGNAL \inst9|inst1|I3|i~156\ : std_logic;
SIGNAL \inst9|inst1|I3|acc[0][8]~4337\ : std_logic;
SIGNAL \inst9|inst1|I3|acc[0][8]~59\ : std_logic;
SIGNAL \rtl~2426\ : std_logic;
SIGNAL \rtl~10907\ : std_logic;
SIGNAL \rtl~2416\ : std_logic;
SIGNAL \rtl~10908\ : std_logic;
SIGNAL \rtl~10238\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[6]~167\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[6]~173\ : std_logic;
SIGNAL \inst9|inst|Decoder_28~22\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[6]~6\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[6]\ : std_logic;
SIGNAL \inst9|inst|rx_uart_fifo[6]\ : std_logic;
SIGNAL \inst9|inst12|i~374\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[6]~256\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[6]~2206\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[4]~112\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[4]~118\ : std_logic;
SIGNAL \inst9|inst|Decoder_28~20\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[4]~1\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[4]\ : std_logic;
SIGNAL \inst9|inst|rx_uart_fifo[4]\ : std_logic;
SIGNAL \inst9|inst12|i~332\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[4]~206\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[4]~2041\ : std_logic;
SIGNAL \inst9|inst|Decoder_28~19\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[3]~3\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[3]\ : std_logic;
SIGNAL \inst9|inst|rx_uart_fifo[3]\ : std_logic;
SIGNAL \inst9|inst12|i~346\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[3]~226\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[3]~134\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[3]~140\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[3]~2107\ : std_logic;
SIGNAL \inst9|inst|rx_uart_fifo[4]~45\ : std_logic;
SIGNAL \inst9|inst|rx_uart_fifo[4]~44\ : std_logic;
SIGNAL \inst9|inst12|ndre_c\ : std_logic;
SIGNAL \inst9|inst12|i~127\ : std_logic;
SIGNAL \rtl~10839\ : std_logic;
SIGNAL \inst9|inst19|mux_x[1]~4\ : std_logic;
SIGNAL \inst9|inst|rx_uart_full_c\ : std_logic;
SIGNAL \inst9|inst|rx_uart_full_s\ : std_logic;
SIGNAL \inst9|inst|rx_uart_full_d\ : std_logic;
SIGNAL \inst9|inst|rx_uart_ovr_s\ : std_logic;
SIGNAL \inst9|inst|rx_uart_ovr_d\ : std_logic;
SIGNAL \inst9|inst|Decoder_28~18\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[2]~2\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[2]\ : std_logic;
SIGNAL \inst9|inst|rx_uart_fifo[2]\ : std_logic;
SIGNAL \inst9|inst19|Mux_13_rtl_0~2\ : std_logic;
SIGNAL \inst9|inst12|i~1197\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[2]~216\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[2]~123\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[2]~129\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[2]~2074\ : std_logic;
SIGNAL \inst9|inst1|I3|add_129~0COUT\ : std_logic;
SIGNAL \inst9|inst1|I3|add_129~1COUT\ : std_logic;
SIGNAL \inst9|inst1|I3|add_129~2COUT\ : std_logic;
SIGNAL \inst9|inst1|I3|add_129~3COUT\ : std_logic;
SIGNAL \inst9|inst1|I3|add_129~4COUT\ : std_logic;
SIGNAL \inst9|inst1|I3|add_129~5COUT\ : std_logic;
SIGNAL \inst9|inst1|I3|add_129~6COUT\ : std_logic;
SIGNAL \inst9|inst1|I3|add_129~7COUT\ : std_logic;
SIGNAL \inst9|inst1|I3|add_129~8\ : std_logic;
SIGNAL \inst9|inst1|I3|add_153~1COUT\ : std_logic;
SIGNAL \inst9|inst1|I3|add_153~2COUT\ : std_logic;
SIGNAL \inst9|inst1|I3|add_153~3COUT\ : std_logic;
SIGNAL \inst9|inst1|I3|add_153~4COUT\ : std_logic;
SIGNAL \inst9|inst1|I3|add_153~5COUT\ : std_logic;
SIGNAL \inst9|inst1|I3|add_153~6COUT\ : std_logic;
SIGNAL \inst9|inst1|I3|add_153~7COUT\ : std_logic;
SIGNAL \inst9|inst1|I3|add_153~8COUT\ : std_logic;
SIGNAL \inst9|inst1|I3|add_153~9\ : std_logic;
SIGNAL \rtl~2433\ : std_logic;
SIGNAL \rtl~2218\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_i[0][8]\ : std_logic;
SIGNAL \rtl~432\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_c[0][8]\ : std_logic;
SIGNAL \rtl~2156\ : std_logic;
SIGNAL \rtl~2160\ : std_logic;
SIGNAL \rtl~2166\ : std_logic;
SIGNAL \rtl~9988\ : std_logic;
SIGNAL \rtl~1286\ : std_logic;
SIGNAL \inst9|inst1|I3|add_153~1\ : std_logic;
SIGNAL \inst9|inst1|I3|Mux_178_rtl_109_rtl_345~0\ : std_logic;
SIGNAL \inst9|inst1|I3|Mux_178_rtl_109_rtl_345~1\ : std_logic;
SIGNAL \rtl~10487\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_i[0][0]\ : std_logic;
SIGNAL \inst9|inst1|I3|acc[0][0]~4400\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_c[0][0]\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104~0\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~78\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_i[0]\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~83\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_c[0]\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104~0COUT\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104~1\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~118\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_i[1]\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~123\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_c[1]\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104~1COUT\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104~2COUT\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104~3\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~58\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_i[3]\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~63\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_c[3]\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[3]~31\ : std_logic;
SIGNAL \inst9|inst4|daddr_c[3]\ : std_logic;
SIGNAL \inst9|inst4|i~430\ : std_logic;
SIGNAL \inst9|inst4|i~81\ : std_logic;
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|q[1]\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_c[1]\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[1]~22\ : std_logic;
SIGNAL \inst9|inst1|I2|TD_x[3]~36\ : std_logic;
SIGNAL \inst9|inst1|I2|TD_c[3]\ : std_logic;
SIGNAL \rtl~10117\ : std_logic;
SIGNAL \rtl~10129\ : std_logic;
SIGNAL \rtl~1553\ : std_logic;
SIGNAL \rtl~10911\ : std_logic;
SIGNAL \rtl~10906\ : std_logic;
SIGNAL \rtl~10171\ : std_logic;
SIGNAL \inst9|inst1|I3|reduce_nor_91~35\ : std_logic;
SIGNAL \inst9|inst1|I3|reduce_nor_91~28\ : std_logic;
SIGNAL \inst9|inst1|I3|reduce_nor_91\ : std_logic;
SIGNAL \rtl~10195\ : std_logic;
SIGNAL \inst9|inst1|I3|skip_i\ : std_logic;
SIGNAL \rtl~940\ : std_logic;
SIGNAL \rtl~10162\ : std_logic;
SIGNAL \rtl~10188\ : std_logic;
SIGNAL \inst9|inst1|I2|skip_x~62\ : std_logic;
SIGNAL \inst9|inst1|I2|TC_x[0]~573\ : std_logic;
SIGNAL \inst9|inst1|I2|C_raw~61\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_c[13]\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[13]~46\ : std_logic;
SIGNAL \inst9|inst1|I4|i~796\ : std_logic;
SIGNAL \inst9|inst1|I4|i~816\ : std_logic;
SIGNAL \inst9|inst1|I4|i~815\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_we_c\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104~2\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~48\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_i[2]\ : std_logic;
SIGNAL \inst9|inst1|I4|add_104_rtl_475~53\ : std_logic;
SIGNAL \inst9|inst1|I4|ireg_c[2]\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[2]~28\ : std_logic;
SIGNAL \inst9|inst4|daddr_c[2]\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[2]~18\ : std_logic;
SIGNAL \inst9|inst4|i~423\ : std_logic;
SIGNAL \inst9|inst4|i~75\ : std_logic;
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|q[4]\ : std_logic;
SIGNAL \inst9|inst1|I2|data_is_c[0]\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[4]~37\ : std_logic;
SIGNAL \inst9|inst1|I4|reduce_nor_103\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[1]~63\ : std_logic;
SIGNAL \inst9|inst4|daddr_c[1]\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[1]~69\ : std_logic;
SIGNAL \inst9|inst4|i~416\ : std_logic;
SIGNAL \inst9|inst4|i~69\ : std_logic;
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|q[9]\ : std_logic;
SIGNAL \inst9|inst1|I2|data_is_c[5]\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[5]~178\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[5]~184\ : std_logic;
SIGNAL \inst9|inst|Decoder_28~21\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[5]~7\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[5]\ : std_logic;
SIGNAL \inst9|inst|rx_uart_fifo[5]\ : std_logic;
SIGNAL \inst9|inst12|i~381\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[5]~266\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[5]~2239\ : std_logic;
SIGNAL \rtl~10617\ : std_logic;
SIGNAL \rtl~1590\ : std_logic;
SIGNAL \rtl~2073\ : std_logic;
SIGNAL \rtl~2192\ : std_logic;
SIGNAL \rtl~1809\ : std_logic;
SIGNAL \inst9|inst1|I3|add_129~5\ : std_logic;
SIGNAL \inst9|inst1|I3|add_153~6\ : std_logic;
SIGNAL \inst9|inst1|I3|Mux_173_rtl_127_rtl_363~0\ : std_logic;
SIGNAL \inst9|inst1|I3|Mux_173_rtl_127_rtl_363~1\ : std_logic;
SIGNAL \rtl~10600\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_i[0][5]\ : std_logic;
SIGNAL \inst9|inst1|I3|acc[0][5]~4430\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_c[0][5]\ : std_logic;
SIGNAL \inst9|inst1|I4|data_ox[5]~2\ : std_logic;
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|q[5]\ : std_logic;
SIGNAL \inst9|inst1|I2|data_is_c[1]\ : std_logic;
SIGNAL \inst9|inst|Decoder_28~17\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[1]~8\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[1]\ : std_logic;
SIGNAL \inst9|inst|rx_uart_fifo[1]\ : std_logic;
SIGNAL \inst9|inst12|i~420\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[1]~276\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[1]~189\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[1]~195\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[1]~2272\ : std_logic;
SIGNAL \rtl~10661\ : std_logic;
SIGNAL \rtl~2084\ : std_logic;
SIGNAL \rtl~2202\ : std_logic;
SIGNAL \rtl~1824\ : std_logic;
SIGNAL \rtl~1596\ : std_logic;
SIGNAL \inst9|inst1|I3|add_153~2\ : std_logic;
SIGNAL \inst9|inst1|I3|add_129~1\ : std_logic;
SIGNAL \inst9|inst1|I3|Mux_177_rtl_133_rtl_369~0\ : std_logic;
SIGNAL \inst9|inst1|I3|Mux_177_rtl_133_rtl_369~1\ : std_logic;
SIGNAL \rtl~10644\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_i[0][1]\ : std_logic;
SIGNAL \inst9|inst1|I3|acc[0][1]~4440\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_c[0][1]\ : std_logic;
SIGNAL \inst9|inst10|i~366\ : std_logic;
SIGNAL \inst9|inst10|i~71\ : std_logic;
SIGNAL \inst9|inst10|tmr_reset\ : std_logic;
SIGNAL \inst9|inst19|reduce_nor_26~32\ : std_logic;
SIGNAL \inst9|inst10|i~80\ : std_logic;
SIGNAL \inst9|inst10|i~79\ : std_logic;
SIGNAL \inst9|inst10|i~78\ : std_logic;
SIGNAL \inst9|inst10|i~77\ : std_logic;
SIGNAL \inst9|inst10|i~76\ : std_logic;
SIGNAL \inst9|inst10|i~75\ : std_logic;
SIGNAL \inst9|inst10|i~74\ : std_logic;
SIGNAL \inst9|inst10|tmr_enable\ : std_logic;
SIGNAL \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[0]\ : std_logic;
SIGNAL \inst9|inst10|i~73\ : std_logic;
SIGNAL \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[0]~COUT\ : std_logic;
SIGNAL \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[1]\ : std_logic;
SIGNAL \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[1]~COUT\ : std_logic;
SIGNAL \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[2]\ : std_logic;
SIGNAL \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[2]~COUT\ : std_logic;
SIGNAL \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[3]\ : std_logic;
SIGNAL \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[3]~COUT\ : std_logic;
SIGNAL \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[4]\ : std_logic;
SIGNAL \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[4]~COUT\ : std_logic;
SIGNAL \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[5]\ : std_logic;
SIGNAL \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[5]~COUT\ : std_logic;
SIGNAL \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[6]\ : std_logic;
SIGNAL \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[6]~COUT\ : std_logic;
SIGNAL \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[7]\ : std_logic;
SIGNAL \inst9|inst10|reduce_nor_58~42\ : std_logic;
SIGNAL \inst9|inst10|reduce_nor_58~35\ : std_logic;
SIGNAL \inst9|inst10|reduce_nor_58\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17~0\ : std_logic;
SIGNAL \inst9|inst10|tmr_count[7]~7\ : std_logic;
SIGNAL \inst9|inst10|tmr_count[0]\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17_rtl_481~373\ : std_logic;
SIGNAL \inst9|inst10|reduce_nor_58~30\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17_rtl_481~2506\ : std_logic;
SIGNAL \inst9|inst10|i~1\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17_rtl_481~236\ : std_logic;
SIGNAL \inst9|inst10|tmr_high[0]\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17~0COUT\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17~1\ : std_logic;
SIGNAL \inst9|inst10|tmr_count[1]\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17_rtl_481~355\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17_rtl_481~225\ : std_logic;
SIGNAL \inst9|inst10|tmr_high[1]\ : std_logic;
SIGNAL \inst9|inst10|tmr_count[3]\ : std_logic;
SIGNAL \inst9|inst10|tmr_count[2]\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17~1COUT\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17~2\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17_rtl_481~337\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17_rtl_481~214\ : std_logic;
SIGNAL \inst9|inst10|tmr_high[2]\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17~2COUT\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17~3\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17_rtl_481~319\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17_rtl_481~203\ : std_logic;
SIGNAL \inst9|inst10|tmr_high[3]\ : std_logic;
SIGNAL \inst9|inst10|i~339\ : std_logic;
SIGNAL \inst9|inst10|tmr_count[6]\ : std_logic;
SIGNAL \inst9|inst10|tmr_count[5]\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17_rtl_481~192\ : std_logic;
SIGNAL \inst9|inst10|tmr_count[4]\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17~3COUT\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17~4\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17_rtl_481~301\ : std_logic;
SIGNAL \inst9|inst10|tmr_high[4]\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17~4COUT\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17~5\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17_rtl_481~283\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17_rtl_481~181\ : std_logic;
SIGNAL \inst9|inst10|tmr_high[5]\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17~5COUT\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17~6\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17_rtl_481~265\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17_rtl_481~170\ : std_logic;
SIGNAL \inst9|inst10|tmr_high[6]\ : std_logic;
SIGNAL \inst9|inst10|tmr_count[7]\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17~6COUT\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17~7\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17_rtl_481~247\ : std_logic;
SIGNAL \inst9|inst10|add_47_rtl_17_rtl_481~159\ : std_logic;
SIGNAL \inst9|inst10|tmr_high[7]\ : std_logic;
SIGNAL \inst9|inst10|i~334\ : std_logic;
SIGNAL \inst9|inst10|i~352\ : std_logic;
SIGNAL \inst9|inst10|tmr_int_x\ : std_logic;
SIGNAL \inst9|inst5|i~1\ : std_logic;
SIGNAL \inst9|inst5|int_mask_c[3]\ : std_logic;
SIGNAL \inst9|inst5|int_masked[3]\ : std_logic;
SIGNAL \inst9|inst5|i~65\ : std_logic;
SIGNAL \inst9|inst5|int_clr_c[3]\ : std_logic;
SIGNAL \inst9|inst5|int_masked_c[3]\ : std_logic;
SIGNAL \inst9|inst5|int_pending_c[3]\ : std_logic;
SIGNAL \inst9|inst5|int_mask_c[0]\ : std_logic;
SIGNAL \inst9|inst5|int_masked[0]\ : std_logic;
SIGNAL \inst9|inst5|int_clr_c[0]\ : std_logic;
SIGNAL \inst9|inst5|int_masked_c[0]\ : std_logic;
SIGNAL \inst9|inst5|int_pending_c[0]\ : std_logic;
SIGNAL \inst9|inst5|int_mask_c[2]\ : std_logic;
SIGNAL \inst9|inst5|int_masked[2]\ : std_logic;
SIGNAL \inst9|inst5|int_masked_c[2]\ : std_logic;
SIGNAL \inst9|inst5|int_clr_c[2]\ : std_logic;
SIGNAL \inst9|inst5|int_pending_c[2]\ : std_logic;
SIGNAL \inst9|inst5|int_mask_c[1]\ : std_logic;
SIGNAL \inst9|inst5|int_masked[1]\ : std_logic;
SIGNAL \inst9|inst5|int_masked_c[1]\ : std_logic;
SIGNAL \inst9|inst5|int_clr_c[1]\ : std_logic;
SIGNAL \inst9|inst5|int_pending_c[1]\ : std_logic;
SIGNAL \inst9|inst1|I2|i~457\ : std_logic;
SIGNAL \inst9|inst1|I2|S_x.normal~12\ : std_logic;
SIGNAL \inst9|inst1|I2|S_c~9\ : std_logic;
SIGNAL \inst9|inst1|I2|E_x.int_e~80\ : std_logic;
SIGNAL \inst9|inst1|I2|E_x.int_e~96\ : std_logic;
SIGNAL \inst9|inst1|I2|int_start_c\ : std_logic;
SIGNAL \inst9|inst1|I2|skip_c\ : std_logic;
SIGNAL \inst9|inst1|I2|ndre_x~40\ : std_logic;
SIGNAL \inst9|inst1|I2|ndre_x~41\ : std_logic;
SIGNAL \inst9|inst1|I4|ndre_x~1\ : std_logic;
SIGNAL \inst9|inst4|dwait_c\ : std_logic;
SIGNAL \inst9|inst4|i~200\ : std_logic;
SIGNAL \inst9|inst1|I4|ndwe_x~1\ : std_logic;
SIGNAL \inst9|inst4|a2vi_s\ : std_logic;
SIGNAL \inst9|inst4|nadwe_c\ : std_logic;
SIGNAL \inst9|inst4|i~382\ : std_logic;
SIGNAL \inst9|inst4|daddr_c[0]\ : std_logic;
SIGNAL \inst9|inst1|I4|daddr_x[0]~22\ : std_logic;
SIGNAL \inst9|inst4|i~409\ : std_logic;
SIGNAL \inst9|inst4|i~63\ : std_logic;
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|q[12]\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_c[12]\ : std_logic;
SIGNAL \inst9|inst4|i~381\ : std_logic;
SIGNAL \inst9|inst12|cpu_daddr_c[8]\ : std_logic;
SIGNAL \inst9|inst19|i~50\ : std_logic;
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|q[11]\ : std_logic;
SIGNAL \inst9|inst1|I2|data_is_c[7]\ : std_logic;
SIGNAL \inst9|inst|Decoder_28~23\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[7]~5\ : std_logic;
SIGNAL \inst9|inst|rx_uart_reg[7]\ : std_logic;
SIGNAL \inst9|inst|rx_uart_fifo[7]\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[2]~2296\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[7]~2294\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[7]~156\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[7]~162\ : std_logic;
SIGNAL \inst9|inst1|I3|data_x[7]~2173\ : std_logic;
SIGNAL \rtl~10529\ : std_logic;
SIGNAL \rtl~1578\ : std_logic;
SIGNAL \rtl~2172\ : std_logic;
SIGNAL \rtl~2051\ : std_logic;
SIGNAL \rtl~1779\ : std_logic;
SIGNAL \inst9|inst1|I3|add_153~8\ : std_logic;
SIGNAL \inst9|inst1|I3|add_129~7\ : std_logic;
SIGNAL \inst9|inst1|I3|Mux_171_rtl_115_rtl_351~0\ : std_logic;
SIGNAL \inst9|inst1|I3|Mux_171_rtl_115_rtl_351~1\ : std_logic;
SIGNAL \rtl~10512\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_i[0][7]\ : std_logic;
SIGNAL \inst9|inst1|I3|acc[0][7]~4410\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_c[0][7]\ : std_logic;
SIGNAL \inst9|inst1|I4|data_ox[7]~0\ : std_logic;
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|q[7]\ : std_logic;
SIGNAL \inst9|inst1|I2|data_is_c[3]\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[7]~31\ : std_logic;
SIGNAL \inst9|inst1|I2|TC_x[0]~141\ : std_logic;
SIGNAL \inst9|inst1|I2|TC_c[0]\ : std_logic;
SIGNAL \inst9|inst1|I2|i~441\ : std_logic;
SIGNAL \inst9|inst1|I3|i~174\ : std_logic;
SIGNAL \inst9|inst1|I3|i~173\ : std_logic;
SIGNAL \inst9|inst1|I3|acc[0][4]~63\ : std_logic;
SIGNAL \rtl~10426\ : std_logic;
SIGNAL \rtl~2028\ : std_logic;
SIGNAL \rtl~2140\ : std_logic;
SIGNAL \rtl~1751\ : std_logic;
SIGNAL \rtl~1572\ : std_logic;
SIGNAL \inst9|inst1|I3|add_153~4\ : std_logic;
SIGNAL \inst9|inst1|I3|add_129~3\ : std_logic;
SIGNAL \inst9|inst1|I3|Mux_175_rtl_103_rtl_339~0\ : std_logic;
SIGNAL \inst9|inst1|I3|Mux_175_rtl_103_rtl_339~1\ : std_logic;
SIGNAL \rtl~10409\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_i[0][3]\ : std_logic;
SIGNAL \inst9|inst1|I3|acc[0][3]~4390\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_c[0][3]\ : std_logic;
SIGNAL \inst9|inst1|I4|data_ox[3]~4\ : std_logic;
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|q[3]\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_c[3]\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[3]~16\ : std_logic;
SIGNAL \inst9|inst1|I2|TC_c[1]\ : std_logic;
SIGNAL \rtl~9972\ : std_logic;
SIGNAL \rtl~10382\ : std_logic;
SIGNAL \rtl~2017\ : std_logic;
SIGNAL \rtl~2130\ : std_logic;
SIGNAL \rtl~1736\ : std_logic;
SIGNAL \rtl~1566\ : std_logic;
SIGNAL \inst9|inst1|I3|add_153~3\ : std_logic;
SIGNAL \inst9|inst1|I3|add_129~2\ : std_logic;
SIGNAL \inst9|inst1|I3|Mux_176_rtl_97_rtl_333~0\ : std_logic;
SIGNAL \inst9|inst1|I3|Mux_176_rtl_97_rtl_333~1\ : std_logic;
SIGNAL \rtl~10365\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_i[0][2]\ : std_logic;
SIGNAL \inst9|inst1|I3|acc[0][2]~4380\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_c[0][2]\ : std_logic;
SIGNAL \inst9|inst1|I4|data_ox[2]~5\ : std_logic;
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|q[2]\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_c[2]\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[2]~23\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[1]~20\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[1]~21\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[2]~24\ : std_logic;
SIGNAL \inst9|inst1|I2|TD_x[3]~35\ : std_logic;
SIGNAL \inst9|inst1|I2|Mux_70~0\ : std_logic;
SIGNAL \inst9|inst1|I2|TD_c[0]\ : std_logic;
SIGNAL \rtl~10573\ : std_logic;
SIGNAL \rtl~2062\ : std_logic;
SIGNAL \rtl~2182\ : std_logic;
SIGNAL \rtl~1794\ : std_logic;
SIGNAL \rtl~1584\ : std_logic;
SIGNAL \inst9|inst1|I3|add_153~7\ : std_logic;
SIGNAL \inst9|inst1|I3|add_129~6\ : std_logic;
SIGNAL \inst9|inst1|I3|Mux_172_rtl_121_rtl_357~0\ : std_logic;
SIGNAL \inst9|inst1|I3|Mux_172_rtl_121_rtl_357~1\ : std_logic;
SIGNAL \rtl~10556\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_i[0][6]\ : std_logic;
SIGNAL \inst9|inst1|I3|acc[0][6]~4420\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_c[0][6]\ : std_logic;
SIGNAL \inst9|inst1|I4|data_ox[6]~1\ : std_logic;
SIGNAL \inst9|inst15|lpm_ram_dq_component|sram|q[6]\ : std_logic;
SIGNAL \inst9|inst1|I2|data_is_c[2]\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[6]~28\ : std_logic;
SIGNAL \inst9|inst12|i~1151\ : std_logic;
SIGNAL \inst9|inst12|dwait_c\ : std_logic;
SIGNAL \inst9|inst1|I2|i~512\ : std_logic;
SIGNAL \inst9|inst1|I2|i~509\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_c[0]\ : std_logic;
SIGNAL \inst9|inst1|I2|idata_x[0]~19\ : std_logic;
SIGNAL \inst9|inst1|I2|TC_x[1]~572\ : std_logic;
SIGNAL \inst9|inst1|I2|TC_x[2]~570\ : std_logic;
SIGNAL \inst9|inst1|I2|TC_c[2]\ : std_logic;
SIGNAL \rtl~1694\ : std_logic;
SIGNAL \inst9|inst1|I3|acc[0][4]~4338\ : std_logic;
SIGNAL \rtl~10336\ : std_logic;
SIGNAL \rtl~1560\ : std_logic;
SIGNAL \rtl~2006\ : std_logic;
SIGNAL \rtl~2120\ : std_logic;
SIGNAL \rtl~1721\ : std_logic;
SIGNAL \inst9|inst1|I3|add_153~5\ : std_logic;
SIGNAL \inst9|inst1|I3|add_129~4\ : std_logic;
SIGNAL \inst9|inst1|I3|Mux_174_rtl_91_rtl_327~0\ : std_logic;
SIGNAL \inst9|inst1|I3|Mux_174_rtl_91_rtl_327~1\ : std_logic;
SIGNAL \rtl~10319\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_i[0][4]\ : std_logic;
SIGNAL \inst9|inst1|I3|acc[0][4]~4370\ : std_logic;
SIGNAL \inst9|inst1|I3|acc_c[0][4]\ : std_logic;
SIGNAL \inst9|inst2|i~137\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_div[4]\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_div[3]\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_div[2]\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_div[1]\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_div[0]\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[0]~COUT\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[1]\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[1]~COUT\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[2]\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[2]~COUT\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[3]\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[3]~COUT\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[4]\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_div[5]\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[4]~COUT\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[5]\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[0]\ : std_logic;
SIGNAL \inst9|inst2|reduce_nor_7~32\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_div[7]\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_div[6]\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[5]~COUT\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[6]\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[6]~COUT\ : std_logic;
SIGNAL \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[7]\ : std_logic;
SIGNAL \inst9|inst2|reduce_nor_7~39\ : std_logic;
SIGNAL \inst9|inst2|reduce_nor_7\ : std_logic;
SIGNAL \inst9|inst2|reduce_nor_7~27\ : std_logic;
SIGNAL \inst9|inst2|tx_16_count[3]~3\ : std_logic;
SIGNAL \inst9|inst2|i~113\ : std_logic;
SIGNAL \inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[0]~COUT\ : std_logic;
SIGNAL \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[1]\ : std_logic;
SIGNAL \inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[1]~COUT\ : std_logic;
SIGNAL \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[2]\ : std_logic;
SIGNAL \inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[2]~COUT\ : std_logic;
SIGNAL \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[3]\ : std_logic;
SIGNAL \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[0]\ : std_logic;
SIGNAL \inst9|inst2|reduce_nor_34~11\ : std_logic;
SIGNAL \inst9|inst2|tx_bit_count[3]~15\ : std_logic;
SIGNAL \inst9|inst2|i~174\ : std_logic;
SIGNAL \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[0]~COUT\ : std_logic;
SIGNAL \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\ : std_logic;
SIGNAL \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[1]~COUT\ : std_logic;
SIGNAL \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[2]\ : std_logic;
SIGNAL \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[2]~COUT\ : std_logic;
SIGNAL \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[3]\ : std_logic;
SIGNAL \inst9|inst2|tx_s~12\ : std_logic;
SIGNAL \inst9|inst2|tx_s~23\ : std_logic;
SIGNAL \inst9|inst2|tx_s~27\ : std_logic;
SIGNAL \inst9|inst2|tx_s\ : std_logic;
SIGNAL \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_fifo[7]\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_shift[8]~2\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_shift[8]\ : std_logic;
SIGNAL \inst9|inst2|i~471\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_shift[0]\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_fifo[1]\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_shift[2]\ : std_logic;
SIGNAL \inst9|inst2|Mux_29_rtl_39~0\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_fifo[2]\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_shift[3]\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_fifo[0]\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_shift[1]\ : std_logic;
SIGNAL \inst9|inst2|Mux_29_rtl_39~1\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_fifo[6]\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_shift[7]\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_fifo[3]\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_shift[4]\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_fifo[5]\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_shift[6]\ : std_logic;
SIGNAL \inst9|inst2|Mux_29_rtl_40~0\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_fifo[4]\ : std_logic;
SIGNAL \inst9|inst2|tx_uart_shift[5]\ : std_logic;
SIGNAL \inst9|inst2|Mux_29_rtl_40~1\ : std_logic;
SIGNAL \inst9|inst2|i~190\ : std_logic;
SIGNAL \inst9|inst2|tx_uart~reg0\ : std_logic;
SIGNAL \inst9|inst33\ : std_logic;
SIGNAL \inst9|inst19|i~93\ : std_logic;
SIGNAL \inst9|inst34\ : std_logic;
SIGNAL \inst9|inst19|i~89\ : std_logic;
SIGNAL \inst9|inst25\ : std_logic;
SIGNAL \inst9|inst28\ : std_logic;
SIGNAL \inst9|inst36[7]\ : std_logic;
SIGNAL \inst9|inst36[6]\ : std_logic;
SIGNAL \inst9|inst36[5]\ : std_logic;
SIGNAL \inst9|inst36[4]\ : std_logic;
SIGNAL \inst9|inst36[3]\ : std_logic;
SIGNAL \inst9|inst36[2]\ : std_logic;
SIGNAL \inst9|inst36[1]\ : std_logic;
SIGNAL \inst9|inst36[0]\ : std_logic;
SIGNAL \NOT_inst9|inst2|tx_uart~reg0\ : std_logic;
SIGNAL \NOT_inst9|inst7\ : std_logic;
SIGNAL \NOT_inst9|inst10|tmr_reset\ : std_logic;
SIGNAL \NOT_inst9|inst10|tmr_enable\ : std_logic;

BEGIN

ww_user_pb2 <= user_pb2;
ww_user_sw <= user_sw;
ww_RXD <= RXD;
ww_clk <= clk;
ww_user_pb1 <= user_pb1;
user_LED1 <= ww_user_LED1;
TXD <= ww_TXD;
user_LED0 <= ww_user_LED0;
display_e <= ww_display_e;
display_rw <= ww_display_rw;
display_rs <= ww_display_rs;
HEADER_SWITCH_enable1_n <= ww_HEADER_SWITCH_enable1_n;
display <= ww_display;
hex <= ww_hex;

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][6]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][6]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][4]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][4]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][5]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][5]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][3]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][3]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][0]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][0]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][2]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][2]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][1]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][1]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][7]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][7]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][8]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][8]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][12]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][12]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][0]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][0]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][1]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][1]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][2]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][2]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][3]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][3]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][4]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][4]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][9]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][9]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][5]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][5]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][10]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][10]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][6]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][6]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][7]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][7]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][11]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][11]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][8]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][8]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][9]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][9]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst11|inst8|add_15_rtl_477~31\ & \inst9|inst11|inst8|add_15_rtl_477~28\ & \inst9|inst11|inst8|add_15_rtl_477~25\ & 
\inst9|inst11|inst8|add_15_rtl_477~22\ & \inst9|inst11|inst8|add_15_rtl_477~19\ & \inst9|inst11|inst8|add_15_rtl_477~16\ & \inst9|inst11|inst8|add_15_rtl_477~13\ & \inst9|inst11|inst8|add_15_rtl_477~10\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][13]_waddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);

\ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][13]_raddr\ <= (gnd & gnd & gnd & gnd & gnd & gnd & \inst9|inst4|i~46\ & \inst9|inst4|i~111\ & \inst9|inst4|i~105\ & \inst9|inst4|i~99\ & \inst9|inst4|i~93\ & \inst9|inst4|i~87\ & \inst9|inst4|i~81\ & 
\inst9|inst4|i~75\ & \inst9|inst4|i~69\ & \inst9|inst4|i~63\);
\NOT_inst9|inst2|tx_uart~reg0\ <= NOT \inst9|inst2|tx_uart~reg0\;
\NOT_inst9|inst7\ <= NOT \inst9|inst7\;
\NOT_inst9|inst10|tmr_reset\ <= NOT \inst9|inst10|tmr_reset\;
\NOT_inst9|inst10|tmr_enable\ <= NOT \inst9|inst10|tmr_enable\;

\clk~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => GND,
	ena => VCC,
	padio => ww_clk,
	combout => \clk~combout\);

\user_pb1~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => GND,
	ena => VCC,
	padio => ww_user_pb1,
	combout => \user_pb1~combout\);

\inst9|inst7~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst7\ = DFFE(\user_pb1~combout\, GLOBAL(\clk~combout\), , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \user_pb1~combout\,
	clk => \clk~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst7\);

\inst9|inst1|I2|LessThan_7~5_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|LessThan_7~5\ = \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\ & \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CC00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datad => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|LessThan_7~5\);

\inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|counter_cell[0]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[0]\ = DFFE((\inst9|inst1|I2|LessThan_7~5\ & \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[0]\) # (!\inst9|inst1|I2|LessThan_7~5\ & !\inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[0]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|counter_cell[0]~COUT\ = CARRY(\inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "qfbk_counter",
	packed_mode => "false",
	lut_mask => "0FF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[0]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst1|I2|LessThan_7~5\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[0]\,
	cout => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|counter_cell[0]~COUT\);

\inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|counter_cell[1]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\ = DFFE((\inst9|inst1|I2|LessThan_7~5\ & \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\) # (!\inst9|inst1|I2|LessThan_7~5\ & \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|counter_cell[0]~COUT\ $ \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "0FF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datad => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	cin => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|counter_cell[0]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst1|I2|LessThan_7~5\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\);

\inst9|inst1|I2|i~2_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|i~2\ = \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\ & \inst9|inst7\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datad => \inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|i~2\);

\~GND~I\ : apex20ke_lcell 
-- Equation(s):
-- \~GND\ = GND

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	combout => \~GND\);

\inst9|inst1|I1|LessThan_7~5_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|LessThan_7~5\ = \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[0]\ & \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[0]\,
	datad => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|LessThan_7~5\);

\inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|counter_cell[0]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[0]\ = DFFE((\inst9|inst1|I1|LessThan_7~5\ & \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[0]\) # (!\inst9|inst1|I1|LessThan_7~5\ & !\inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[0]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|counter_cell[0]~COUT\ = CARRY(\inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "qfbk_counter",
	packed_mode => "false",
	lut_mask => "0FF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[0]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst1|I1|LessThan_7~5\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[0]\,
	cout => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|counter_cell[0]~COUT\);

\inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|counter_cell[1]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\ = DFFE((\inst9|inst1|I1|LessThan_7~5\ & \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\) # (!\inst9|inst1|I1|LessThan_7~5\ & \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|counter_cell[0]~COUT\ $ \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "0FF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\,
	datad => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\,
	cin => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|counter_cell[0]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst1|I1|LessThan_7~5\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\);

\inst9|inst1|I1|i~2_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|i~2\ = \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\ & \inst9|inst7\
-- \inst9|inst1|I1|i~71\ = \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\ & \inst9|inst7\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\,
	datad => \inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|i~2\,
	cascout => \inst9|inst1|I1|i~71\);

\inst9|inst1|I4|LessThan_39~5_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|LessThan_39~5\ = \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CC00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datad => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|LessThan_39~5\);

\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|counter_cell[0]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[0]\ = DFFE((\inst9|inst1|I4|LessThan_39~5\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[0]\) # (!\inst9|inst1|I4|LessThan_39~5\ & !\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[0]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|counter_cell[0]~COUT\ = CARRY(\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "qfbk_counter",
	packed_mode => "false",
	lut_mask => "0FF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[0]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst1|I4|LessThan_39~5\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[0]\,
	cout => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|counter_cell[0]~COUT\);

\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|counter_cell[1]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ = DFFE((\inst9|inst1|I4|LessThan_39~5\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\) # (!\inst9|inst1|I4|LessThan_39~5\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|counter_cell[0]~COUT\ $ \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "0FF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datad => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	cin => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|counter_cell[0]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst1|I4|LessThan_39~5\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\);

\inst9|inst1|I4|i~18_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|i~18\ = \inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\
-- \inst9|inst1|I4|i~818\ = \inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|i~18\,
	cascout => \inst9|inst1|I4|i~818\);

\inst9|inst1|I2|E_c~10_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|E_c~10\ = DFFE(\inst9|inst1|I2|i~2\ & \inst9|inst4|a2vi_s\ & (!\inst9|inst12|dwait_c\ # !\inst9|inst1|I2|i~441\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~441\,
	datab => \inst9|inst12|dwait_c\,
	datac => \inst9|inst1|I2|i~2\,
	datad => \inst9|inst4|a2vi_s\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|E_c~10\);

\inst9|inst1|I2|skip_x~107_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|skip_x~107\ = \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\ & \inst9|inst1|I2|E_c~10\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datad => \inst9|inst1|I2|E_c~10\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|skip_x~107\);

\inst9|inst1|I3|acc[0][4]~4339_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc[0][4]~4339\ = \rtl~1694\ & \inst9|inst1|I2|TC_c[2]\ & \inst9|inst1|I3|i~173\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~1694\,
	datab => \inst9|inst1|I2|TC_c[2]\,
	datac => \inst9|inst1|I3|i~173\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|acc[0][4]~4339\);

\inst9|inst1|I3|reduce_nor_71~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|reduce_nor_71\ = \inst9|inst1|I2|TC_c[0]\ # \inst9|inst1|I2|TC_c[2]\ # !\inst9|inst1|I2|TC_c[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FCFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|TC_c[0]\,
	datac => \inst9|inst1|I2|TC_c[2]\,
	datad => \inst9|inst1|I2|TC_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|reduce_nor_71\);

\inst9|inst4|i~379_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~379\ = !\inst9|inst4|nadwe_c\ & !\inst9|inst12|dwait_c\ & \inst9|inst1|I4|ndre_x~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0300",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst4|nadwe_c\,
	datac => \inst9|inst12|dwait_c\,
	datad => \inst9|inst1|I4|ndre_x~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~379\);

\inst9|inst4|i~48_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~48\ = \inst9|inst4|a2vi_s\ & \inst9|inst12|dwait_c\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst4|a2vi_s\,
	datad => \inst9|inst12|dwait_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~48\);

\inst9|inst1|I4|data_ox[4]~3_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|data_ox[4]~3\ = \inst9|inst1|I3|acc_c[0][4]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][4]\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|data_ox[4]~3\);

\inst9|inst1|I2|E_x.dwait_e~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|E_x.dwait_e~0\ = \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst12|dwait_c\ & \inst9|inst1|I2|i~441\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datab => \inst9|inst7\,
	datac => \inst9|inst12|dwait_c\,
	datad => \inst9|inst1|I2|i~441\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|E_x.dwait_e~0\);

\inst9|inst1|I4|daddr_x[2]~27_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[2]~27\ = \inst9|inst1|I4|i~18\ & (\inst9|inst1|I2|E_x.dwait_e~0\ & \inst9|inst1|I2|data_is_c[2]\ # !\inst9|inst1|I2|E_x.dwait_e~0\ & \inst9|inst15|lpm_ram_dq_component|sram|q[6]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AC00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|data_is_c[2]\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[6]\,
	datac => \inst9|inst1|I2|E_x.dwait_e~0\,
	datad => \inst9|inst1|I4|i~18\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[2]~27\);

\inst9|inst1|I2|idata_x[5]~34_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[5]~34\ = \inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|data_is_c[1]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[5]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[5]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|data_is_c[1]\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst1|I2|i~509\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[5]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[5]~34\);

\inst9|inst1|I4|reduce_nor_106~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|reduce_nor_106\ = \inst9|inst1|I2|idata_x[6]~28\ # \inst9|inst1|I2|idata_x[5]~34\ # !\inst9|inst1|I2|idata_x[4]~37\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFAF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[6]~28\,
	datac => \inst9|inst1|I2|idata_x[4]~37\,
	datad => \inst9|inst1|I2|idata_x[5]~34\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|reduce_nor_106\);

\inst9|inst1|I2|C_raw~56_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|C_raw~56\ = \inst9|inst1|I2|TC_c[0]\ & \inst9|inst1|I2|TC_c[1]\ & !\inst9|inst1|I2|TC_c[2]\ & !\inst9|inst1|I2|skip_c\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0008",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TC_c[0]\,
	datab => \inst9|inst1|I2|TC_c[1]\,
	datac => \inst9|inst1|I2|TC_c[2]\,
	datad => \inst9|inst1|I2|skip_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|C_raw~56\);

\inst9|inst1|I2|skip_x~41_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|skip_x~41\ = \inst9|inst1|I2|skip_c\ & \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\ & \inst9|inst1|I2|E_c~10\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|skip_c\,
	datac => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datad => \inst9|inst1|I2|E_c~10\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|skip_x~41\);

\inst9|inst1|I2|skip_x~112_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|skip_x~112\ = !\inst9|inst1|I2|int_start_c\ & (!\inst9|inst1|I2|E_c~10\ # !\inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "003F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datac => \inst9|inst1|I2|E_c~10\,
	datad => \inst9|inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|skip_x~112\);

\inst9|inst1|I2|idata_x[7]~30_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[7]~30\ = \inst9|inst15|lpm_ram_dq_component|sram|q[7]\ & (!\inst9|inst12|dwait_c\ # !\inst9|inst1|I2|i~2\ # !\inst9|inst1|I2|i~441\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7F00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~441\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst12|dwait_c\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[7]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[7]~30\);

\inst9|inst1|I2|idata_x[6]~26_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[6]~26\ = \inst9|inst12|dwait_c\ & \inst9|inst1|I2|i~2\ & \inst9|inst1|I2|data_is_c[2]\ & \inst9|inst1|I2|i~441\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|dwait_c\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst1|I2|data_is_c[2]\,
	datad => \inst9|inst1|I2|i~441\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[6]~26\);

\inst9|inst1|I2|idata_x[7]~29_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[7]~29\ = \inst9|inst12|dwait_c\ & \inst9|inst1|I2|data_is_c[3]\ & \inst9|inst1|I2|i~441\ & \inst9|inst1|I2|i~2\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|dwait_c\,
	datab => \inst9|inst1|I2|data_is_c[3]\,
	datac => \inst9|inst1|I2|i~441\,
	datad => \inst9|inst1|I2|i~2\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[7]~29\);

\inst9|inst1|I2|idata_x[6]~27_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[6]~27\ = \inst9|inst15|lpm_ram_dq_component|sram|q[6]\ & (!\inst9|inst1|I2|i~441\ # !\inst9|inst1|I2|i~2\ # !\inst9|inst12|dwait_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7F00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|dwait_c\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst1|I2|i~441\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[6]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[6]~27\);

\inst9|inst1|I4|data_ox[1]~6_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|data_ox[1]~6\ = \inst9|inst7\ & \inst9|inst1|I3|acc_c[0][1]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datab => \inst9|inst1|I3|acc_c[0][1]\,
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|data_ox[1]~6\);

\inst9|inst1|I4|daddr_x[3]~30_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[3]~30\ = \inst9|inst1|I4|i~18\ & (\inst9|inst1|I2|E_x.dwait_e~0\ & \inst9|inst1|I2|data_is_c[3]\ # !\inst9|inst1|I2|E_x.dwait_e~0\ & \inst9|inst15|lpm_ram_dq_component|sram|q[7]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8A80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~18\,
	datab => \inst9|inst1|I2|data_is_c[3]\,
	datac => \inst9|inst1|I2|E_x.dwait_e~0\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[7]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[3]~30\);

\inst9|inst1|I2|TC_x[1]~22_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TC_x[1]~22\ = \inst9|inst7\ & (\inst9|inst1|I2|idata_x[3]~16\ # \inst9|inst1|I2|idata_x[0]~19\ & \inst9|inst1|I2|TD_x[3]~35\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C8C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[0]~19\,
	datab => \inst9|inst7\,
	datac => \inst9|inst1|I2|idata_x[3]~16\,
	datad => \inst9|inst1|I2|TD_x[3]~35\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|TC_x[1]~22\);

\inst9|inst1|I2|ndwe_x~45_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|ndwe_x~45\ = \inst9|inst1|I2|ndre_x~40\ & \inst9|inst1|I2|TC_x[1]~22\ & \inst9|inst1|I2|C_raw~61\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|ndre_x~40\,
	datac => \inst9|inst1|I2|TC_x[1]~22\,
	datad => \inst9|inst1|I2|C_raw~61\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|ndwe_x~45\);

\inst9|inst1|I4|reduce_nor_119~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|reduce_nor_119\ = \inst9|inst1|I2|idata_x[4]~37\ # \inst9|inst1|I2|idata_x[6]~28\ # !\inst9|inst1|I2|idata_x[5]~34\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF3",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|idata_x[5]~34\,
	datac => \inst9|inst1|I2|idata_x[4]~37\,
	datad => \inst9|inst1|I2|idata_x[6]~28\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|reduce_nor_119\);

\inst9|inst1|I4|iinc_we_c~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_we_c\ = DFFE(\inst9|inst1|I2|ndwe_x~45\ & !\inst9|inst1|I4|reduce_nor_119\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|i~815\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|ndwe_x~45\,
	datab => \inst9|inst1|I4|reduce_nor_119\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I4|i~815\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|iinc_we_c\);

\inst9|inst1|I4|ireg_i[4]~2_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_i[4]~2\ = \inst9|inst7\ & \inst9|inst1|I2|int_start_c\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst7\,
	datac => \inst9|inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|ireg_i[4]~2\);

\inst9|inst1|I4|iinc_i[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_i[3]\ = DFFE(\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I3|acc_c[0][3]\ # !\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|iinc_c[3]\, GLOBAL(\clk~combout\), , , \inst9|inst1|I4|ireg_i[4]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F088",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~18\,
	datab => \inst9|inst1|I4|iinc_c[3]\,
	datac => \inst9|inst1|I3|acc_c[0][3]\,
	datad => \inst9|inst1|I4|iinc_we_c\,
	clk => \clk~combout\,
	ena => \inst9|inst1|I4|ireg_i[4]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|iinc_i[3]\);

\inst9|inst1|I4|iinc_x[3]~8_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_x[3]~8\ = \inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I3|acc_c[0][3]\ # !\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|iinc_c[3]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F088",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~18\,
	datab => \inst9|inst1|I4|iinc_c[3]\,
	datac => \inst9|inst1|I3|acc_c[0][3]\,
	datad => \inst9|inst1|I4|iinc_we_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|iinc_x[3]~8\);

\inst9|inst1|I2|E_x.iwait_e~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|E_x.iwait_e~1\ = \inst9|inst4|a2vi_s\ & \inst9|inst1|I2|i~2\ & (!\inst9|inst1|I2|i~441\ # !\inst9|inst12|dwait_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "40C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|dwait_c\,
	datab => \inst9|inst4|a2vi_s\,
	datac => \inst9|inst1|I2|i~2\,
	datad => \inst9|inst1|I2|i~441\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|E_x.iwait_e~1\);

\inst9|inst1|I2|S_x.normal~6_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|S_x.normal~6\ = \inst9|inst1|I2|E_x.iwait_e~1\ # \inst9|inst1|I2|i~2\ & \inst9|inst1|I2|i~509\ # !\inst9|inst1|I2|E_x.int_e~96\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F8FF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~2\,
	datab => \inst9|inst1|I2|i~509\,
	datac => \inst9|inst1|I2|E_x.iwait_e~1\,
	datad => \inst9|inst1|I2|E_x.int_e~96\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|S_x.normal~6\);

\inst9|inst1|I2|S_c~10_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|S_c~10\ = DFFE(\inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\ & (\inst9|inst1|I2|S_c~10\ & !\inst9|inst1|I2|i~511\ # !\inst9|inst1|I2|S_x.normal~6\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "20F0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|S_c~10\,
	datab => \inst9|inst1|I2|i~511\,
	datac => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datad => \inst9|inst1|I2|S_x.normal~6\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|S_c~10\);

\inst9|inst1|I2|idata_x[2]~25_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[2]~25\ = \inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|idata_c[2]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[2]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_c[2]\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst1|I2|i~509\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[2]~25\);

\inst9|inst1|I2|TC_x[1]~532_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TC_x[1]~532\ = !\inst9|inst1|I2|idata_x[1]~22\ & \inst9|inst7\ & !\inst9|inst1|I2|idata_x[2]~25\
-- \inst9|inst1|I2|TC_x[1]~572\ = !\inst9|inst1|I2|idata_x[1]~22\ & \inst9|inst7\ & !\inst9|inst1|I2|idata_x[2]~25\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0030",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|idata_x[1]~22\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I2|idata_x[2]~25\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|TC_x[1]~532\,
	cascout => \inst9|inst1|I2|TC_x[1]~572\);

\inst9|inst1|I2|idata_x[5]~32_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[5]~32\ = \inst9|inst1|I2|data_is_c[1]\ & \inst9|inst12|dwait_c\ & \inst9|inst1|I2|i~441\ & \inst9|inst1|I2|i~2\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|data_is_c[1]\,
	datab => \inst9|inst12|dwait_c\,
	datac => \inst9|inst1|I2|i~441\,
	datad => \inst9|inst1|I2|i~2\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[5]~32\);

\inst9|inst1|I2|idata_x[5]~33_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[5]~33\ = \inst9|inst15|lpm_ram_dq_component|sram|q[5]\ & (!\inst9|inst1|I2|i~441\ # !\inst9|inst1|I2|i~2\ # !\inst9|inst12|dwait_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7F00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|dwait_c\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst1|I2|i~441\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[5]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[5]~33\);

\inst9|inst1|I2|idata_x[6]~28_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[6]~28\ = \inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|data_is_c[2]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[6]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[6]\
-- \inst9|inst1|I2|idata_x[6]~991\ = \inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|data_is_c[2]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[6]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[6]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|data_is_c[2]\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst1|I2|i~509\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[6]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[6]~28\,
	cascout => \inst9|inst1|I2|idata_x[6]~991\);

\inst9|inst1|I2|TC_x[2]~571_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TC_x[2]~571\ = (!\inst9|inst1|I2|idata_x[5]~32\ & !\inst9|inst1|I2|idata_x[5]~33\ & (\inst9|inst1|I2|idata_x[7]~30\ # \inst9|inst1|I2|idata_x[7]~29\)) & CASCADE(\inst9|inst1|I2|idata_x[6]~991\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0054",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[5]~32\,
	datab => \inst9|inst1|I2|idata_x[7]~30\,
	datac => \inst9|inst1|I2|idata_x[7]~29\,
	datad => \inst9|inst1|I2|idata_x[5]~33\,
	cascin => \inst9|inst1|I2|idata_x[6]~991\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|TC_x[2]~571\);

\inst9|inst1|I2|idata_x[3]~14_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[3]~14\ = \inst9|inst1|I2|i~2\ & \inst9|inst1|I2|idata_c[3]\ & \inst9|inst12|dwait_c\ & \inst9|inst1|I2|i~441\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~2\,
	datab => \inst9|inst1|I2|idata_c[3]\,
	datac => \inst9|inst12|dwait_c\,
	datad => \inst9|inst1|I2|i~441\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[3]~14\);

\inst9|inst1|I2|TC_x[0]~550_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TC_x[0]~550\ = \inst9|inst7\ & !\inst9|inst1|I2|idata_x[3]~14\ & (\inst9|inst1|I2|E_x.dwait_e~0\ # !\inst9|inst15|lpm_ram_dq_component|sram|q[3]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "008C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|E_x.dwait_e~0\,
	datab => \inst9|inst7\,
	datac => \inst9|inst15|lpm_ram_dq_component|sram|q[3]\,
	datad => \inst9|inst1|I2|idata_x[3]~14\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|TC_x[0]~550\);

\inst9|inst1|I2|TC_x[0]~147_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TC_x[0]~147\ = \inst9|inst1|I2|TC_x[0]~550\ & (\inst9|inst1|I2|TC_x[2]~571\ & !\inst9|inst1|I2|idata_x[4]~37\ # !\inst9|inst1|I2|TD_x[3]~35\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "20F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TC_x[2]~571\,
	datab => \inst9|inst1|I2|idata_x[4]~37\,
	datac => \inst9|inst1|I2|TC_x[0]~550\,
	datad => \inst9|inst1|I2|TD_x[3]~35\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|TC_x[0]~147\);

\inst9|inst1|I2|i~420_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|i~420\ = !\inst9|inst1|I2|skip_x~62\ & !\inst9|inst1|I2|skip_x~41\ & !\inst9|inst1|I2|TC_x[1]~22\ & \inst9|inst1|I2|TC_x[2]~570\
-- \inst9|inst1|I2|i~513\ = !\inst9|inst1|I2|skip_x~62\ & !\inst9|inst1|I2|skip_x~41\ & !\inst9|inst1|I2|TC_x[1]~22\ & \inst9|inst1|I2|TC_x[2]~570\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0100",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|skip_x~62\,
	datab => \inst9|inst1|I2|skip_x~41\,
	datac => \inst9|inst1|I2|TC_x[1]~22\,
	datad => \inst9|inst1|I2|TC_x[2]~570\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|i~420\,
	cascout => \inst9|inst1|I2|i~513\);

\inst9|inst1|I2|i~510_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|i~510\ = (\inst9|inst1|I2|S_c~10\ & !\inst9|inst1|I2|TC_x[0]~147\ & (!\inst9|inst1|I2|TC_x[1]~532\ # !\inst9|inst1|I2|idata_x[0]~19\)) & CASCADE(\inst9|inst1|I2|i~513\)
-- \inst9|inst1|I2|i~514\ = (\inst9|inst1|I2|S_c~10\ & !\inst9|inst1|I2|TC_x[0]~147\ & (!\inst9|inst1|I2|TC_x[1]~532\ # !\inst9|inst1|I2|idata_x[0]~19\)) & CASCADE(\inst9|inst1|I2|i~513\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "004C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[0]~19\,
	datab => \inst9|inst1|I2|S_c~10\,
	datac => \inst9|inst1|I2|TC_x[1]~532\,
	datad => \inst9|inst1|I2|TC_x[0]~147\,
	cascin => \inst9|inst1|I2|i~513\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|i~510\,
	cascout => \inst9|inst1|I2|i~514\);

\inst9|inst1|I2|i~511_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|i~511\ = (\inst9|inst1|I2|i~2\ & !\inst9|inst4|a2vi_s\ & (!\inst9|inst1|I2|i~441\ # !\inst9|inst12|dwait_c\)) & CASCADE(\inst9|inst1|I2|i~514\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "020A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~2\,
	datab => \inst9|inst12|dwait_c\,
	datac => \inst9|inst4|a2vi_s\,
	datad => \inst9|inst1|I2|i~441\,
	cascin => \inst9|inst1|I2|i~514\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|i~511\);

\inst9|inst1|I2|int_stop_c~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|int_stop_c\ = DFFE(\inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\ & (\inst9|inst1|I2|int_stop_x~6\ # !\inst9|inst1|I2|E_x.int_e~96\ & \inst9|inst1|I2|i~511\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8A88",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datab => \inst9|inst1|I2|int_stop_x~6\,
	datac => \inst9|inst1|I2|E_x.int_e~96\,
	datad => \inst9|inst1|I2|i~511\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|int_stop_c\);

\inst9|inst1|I2|int_stop_x~6_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|int_stop_x~6\ = \inst9|inst1|I2|i~2\ & \inst9|inst1|I2|int_stop_c\ & (\inst9|inst4|a2vi_s\ # \inst9|inst1|I2|i~509\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~2\,
	datab => \inst9|inst4|a2vi_s\,
	datac => \inst9|inst1|I2|int_stop_c\,
	datad => \inst9|inst1|I2|i~509\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|int_stop_x~6\);

\inst9|inst1|I2|int_stop_x~11_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|int_stop_x~11\ = \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\ & (\inst9|inst1|I2|int_stop_x~6\ # !\inst9|inst1|I2|E_x.int_e~96\ & \inst9|inst1|I2|i~511\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8A88",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datab => \inst9|inst1|I2|int_stop_x~6\,
	datac => \inst9|inst1|I2|E_x.int_e~96\,
	datad => \inst9|inst1|I2|i~511\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|int_stop_x~11\);

\inst9|inst1|I4|iinc_c[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_c[3]\ = DFFE(\inst9|inst1|I4|iinc_i[3]\ & (\inst9|inst1|I4|iinc_x[3]~8\ # \inst9|inst1|I2|int_stop_x~11\) # !\inst9|inst1|I4|iinc_i[3]\ & \inst9|inst1|I4|iinc_x[3]~8\ & !\inst9|inst1|I2|int_stop_x~11\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|iinc_i[3]\,
	datac => \inst9|inst1|I4|iinc_x[3]~8\,
	datad => \inst9|inst1|I2|int_stop_x~11\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|iinc_c[3]\);

\inst9|inst1|I4|iinc_x[2]~5_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_x[2]~5\ = \inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I3|acc_c[0][2]\ # !\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I4|iinc_c[2]\ & \inst9|inst1|I4|i~18\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EA40",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|iinc_we_c\,
	datab => \inst9|inst1|I4|iinc_c[2]\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I3|acc_c[0][2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|iinc_x[2]~5\);

\inst9|inst1|I4|iinc_i[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_i[2]\ = DFFE(\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I3|acc_c[0][2]\ # !\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I4|iinc_c[2]\ & \inst9|inst1|I4|i~18\, GLOBAL(\clk~combout\), , , \inst9|inst1|I4|ireg_i[4]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EA40",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|iinc_we_c\,
	datab => \inst9|inst1|I4|iinc_c[2]\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I3|acc_c[0][2]\,
	clk => \clk~combout\,
	ena => \inst9|inst1|I4|ireg_i[4]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|iinc_i[2]\);

\inst9|inst1|I4|iinc_c[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_c[2]\ = DFFE(\inst9|inst1|I4|iinc_x[2]~5\ & (\inst9|inst1|I4|iinc_i[2]\ # !\inst9|inst1|I2|int_stop_x~11\) # !\inst9|inst1|I4|iinc_x[2]~5\ & \inst9|inst1|I4|iinc_i[2]\ & \inst9|inst1|I2|int_stop_x~11\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|iinc_x[2]~5\,
	datac => \inst9|inst1|I4|iinc_i[2]\,
	datad => \inst9|inst1|I2|int_stop_x~11\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|iinc_c[2]\);

\inst9|inst1|I4|iinc_i[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_i[1]\ = DFFE(\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I3|acc_c[0][1]\ # !\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I4|iinc_c[1]\ & \inst9|inst1|I4|i~18\, GLOBAL(\clk~combout\), , , \inst9|inst1|I4|ireg_i[4]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E4A0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|iinc_we_c\,
	datab => \inst9|inst1|I4|iinc_c[1]\,
	datac => \inst9|inst1|I3|acc_c[0][1]\,
	datad => \inst9|inst1|I4|i~18\,
	clk => \clk~combout\,
	ena => \inst9|inst1|I4|ireg_i[4]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|iinc_i[1]\);

\inst9|inst1|I4|iinc_x[1]~23_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_x[1]~23\ = \inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I3|acc_c[0][1]\ # !\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I4|iinc_c[1]\ & \inst9|inst1|I4|i~18\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E4A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|iinc_we_c\,
	datab => \inst9|inst1|I4|iinc_c[1]\,
	datac => \inst9|inst1|I3|acc_c[0][1]\,
	datad => \inst9|inst1|I4|i~18\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|iinc_x[1]~23\);

\inst9|inst1|I4|iinc_c[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_c[1]\ = DFFE(\inst9|inst1|I4|iinc_i[1]\ & (\inst9|inst1|I4|iinc_x[1]~23\ # \inst9|inst1|I2|int_stop_x~11\) # !\inst9|inst1|I4|iinc_i[1]\ & \inst9|inst1|I4|iinc_x[1]~23\ & !\inst9|inst1|I2|int_stop_x~11\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|iinc_i[1]\,
	datac => \inst9|inst1|I4|iinc_x[1]~23\,
	datad => \inst9|inst1|I2|int_stop_x~11\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|iinc_c[1]\);

\inst9|inst1|I2|idata_x[0]~17_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[0]~17\ = \inst9|inst1|I2|i~441\ & \inst9|inst1|I2|idata_c[0]\ & \inst9|inst1|I2|i~2\ & \inst9|inst12|dwait_c\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~441\,
	datab => \inst9|inst1|I2|idata_c[0]\,
	datac => \inst9|inst1|I2|i~2\,
	datad => \inst9|inst12|dwait_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[0]~17\);

\inst9|inst1|I4|data_ox[0]~7_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|data_ox[0]~7\ = \inst9|inst1|I3|acc_c[0][0]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][0]\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|data_ox[0]~7\);

\inst9|inst1|I2|TC_x[1]~42_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TC_x[1]~42\ = \inst9|inst7\ & !\inst9|inst1|I2|idata_x[1]~22\ & \inst9|inst1|I2|idata_x[0]~19\ & !\inst9|inst1|I2|idata_x[2]~25\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0020",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datab => \inst9|inst1|I2|idata_x[1]~22\,
	datac => \inst9|inst1|I2|idata_x[0]~19\,
	datad => \inst9|inst1|I2|idata_x[2]~25\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|TC_x[1]~42\);

\inst9|inst1|I2|reduce_nor_128~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|reduce_nor_128\ = !\inst9|inst1|I2|TC_x[1]~42\ & !\inst9|inst1|I2|TC_x[0]~147\ # !\inst9|inst1|I2|TC_x[1]~22\ # !\inst9|inst1|I2|TC_x[2]~570\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "37FF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TC_x[1]~42\,
	datab => \inst9|inst1|I2|TC_x[2]~570\,
	datac => \inst9|inst1|I2|TC_x[0]~147\,
	datad => \inst9|inst1|I2|TC_x[1]~22\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|reduce_nor_128\);

\inst9|inst1|I2|i~103_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|i~103\ = \inst9|inst1|I2|i~420\ & (\inst9|inst1|I2|TC_x[1]~42\ # \inst9|inst1|I2|S_c~10\ # \inst9|inst1|I2|TC_x[0]~147\)
-- \inst9|inst1|I2|i~515\ = \inst9|inst1|I2|i~420\ & (\inst9|inst1|I2|TC_x[1]~42\ # \inst9|inst1|I2|S_c~10\ # \inst9|inst1|I2|TC_x[0]~147\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FE00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TC_x[1]~42\,
	datab => \inst9|inst1|I2|S_c~10\,
	datac => \inst9|inst1|I2|TC_x[0]~147\,
	datad => \inst9|inst1|I2|i~420\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|i~103\,
	cascout => \inst9|inst1|I2|i~515\);

\inst9|inst1|I2|pc_mux_x[2]~348_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|pc_mux_x[2]~348\ = \inst9|inst1|I2|i~2\ & !\inst9|inst1|I2|skip_x~62\ & (!\inst9|inst1|I2|skip_x~107\ # !\inst9|inst1|I2|skip_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "004C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|skip_c\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst1|I2|skip_x~107\,
	datad => \inst9|inst1|I2|skip_x~62\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|pc_mux_x[2]~348\);

\inst9|inst1|I2|TC_x[0]~146_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TC_x[0]~146\ = \inst9|inst1|I2|TC_x[1]~42\ # \inst9|inst1|I2|TC_x[0]~550\ & (\inst9|inst1|I2|TC_x[0]~141\ # !\inst9|inst1|I2|TD_x[3]~35\)
-- \inst9|inst1|I2|TC_x[0]~573\ = \inst9|inst1|I2|TC_x[1]~42\ # \inst9|inst1|I2|TC_x[0]~550\ & (\inst9|inst1|I2|TC_x[0]~141\ # !\inst9|inst1|I2|TD_x[3]~35\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EECE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TC_x[0]~550\,
	datab => \inst9|inst1|I2|TC_x[1]~42\,
	datac => \inst9|inst1|I2|TD_x[3]~35\,
	datad => \inst9|inst1|I2|TC_x[0]~141\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|TC_x[0]~146\,
	cascout => \inst9|inst1|I2|TC_x[0]~573\);

\inst9|inst1|I2|pc_mux_x[2]~377_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|pc_mux_x[2]~377\ = \inst9|inst1|I2|pc_mux_x[2]~348\ & (\inst9|inst1|I2|TC_x[0]~146\ # !\inst9|inst1|I2|TC_x[1]~22\ # !\inst9|inst1|I2|TC_x[2]~570\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CC4C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TC_x[2]~570\,
	datab => \inst9|inst1|I2|pc_mux_x[2]~348\,
	datac => \inst9|inst1|I2|TC_x[1]~22\,
	datad => \inst9|inst1|I2|TC_x[0]~146\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|pc_mux_x[2]~377\);

\inst9|inst1|I2|pc_mux_x[2]~386_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|pc_mux_x[2]~386\ = \inst9|inst7\ & \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\ & !\inst9|inst1|I2|i~509\ & !\inst9|inst4|a2vi_s\
-- \inst9|inst1|I2|pc_mux_x[2]~446\ = \inst9|inst7\ & \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\ & !\inst9|inst1|I2|i~509\ & !\inst9|inst4|a2vi_s\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0008",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datab => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datac => \inst9|inst1|I2|i~509\,
	datad => \inst9|inst4|a2vi_s\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|pc_mux_x[2]~386\,
	cascout => \inst9|inst1|I2|pc_mux_x[2]~446\);

\inst9|inst1|I2|pc_mux_x[2]~444_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|pc_mux_x[2]~444\ = (\inst9|inst1|I2|E_x.int_e~96\ # \inst9|inst1|I2|reduce_nor_128\ & \inst9|inst1|I2|i~103\ & \inst9|inst1|I2|pc_mux_x[2]~377\) & CASCADE(\inst9|inst1|I2|pc_mux_x[2]~446\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ECCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|reduce_nor_128\,
	datab => \inst9|inst1|I2|E_x.int_e~96\,
	datac => \inst9|inst1|I2|i~103\,
	datad => \inst9|inst1|I2|pc_mux_x[2]~377\,
	cascin => \inst9|inst1|I2|pc_mux_x[2]~446\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|pc_mux_x[2]~444\);

\inst9|inst1|I2|pc_mux_x[2]~443_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|pc_mux_x[2]~443\ = \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\ & (!\inst9|inst4|a2vi_s\ & !\inst9|inst1|I2|i~509\ # !\inst9|inst7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5070",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datab => \inst9|inst4|a2vi_s\,
	datac => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datad => \inst9|inst1|I2|i~509\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|pc_mux_x[2]~443\);

\inst9|inst1|I2|pc_mux_x[1]~422_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|pc_mux_x[1]~422\ = \inst9|inst1|I2|i~2\ & \inst9|inst1|I2|pc_mux_x[2]~443\ & !\inst9|inst1|I2|skip_x~41\ & !\inst9|inst1|I2|skip_x~62\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0008",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~2\,
	datab => \inst9|inst1|I2|pc_mux_x[2]~443\,
	datac => \inst9|inst1|I2|skip_x~41\,
	datad => \inst9|inst1|I2|skip_x~62\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|pc_mux_x[1]~422\);

\inst9|inst1|I4|iinc_x[5]~20_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_x[5]~20\ = \inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I3|acc_c[0][5]\ # !\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|iinc_c[5]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "D888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|iinc_we_c\,
	datab => \inst9|inst1|I3|acc_c[0][5]\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I4|iinc_c[5]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|iinc_x[5]~20\);

\inst9|inst1|I4|iinc_i[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_i[5]\ = DFFE(\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I3|acc_c[0][5]\ # !\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|iinc_c[5]\, GLOBAL(\clk~combout\), , , \inst9|inst1|I4|ireg_i[4]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "D888",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|iinc_we_c\,
	datab => \inst9|inst1|I3|acc_c[0][5]\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I4|iinc_c[5]\,
	clk => \clk~combout\,
	ena => \inst9|inst1|I4|ireg_i[4]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|iinc_i[5]\);

\inst9|inst1|I4|iinc_c[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_c[5]\ = DFFE(\inst9|inst1|I4|iinc_x[5]~20\ & (\inst9|inst1|I4|iinc_i[5]\ # !\inst9|inst1|I2|int_stop_x~11\) # !\inst9|inst1|I4|iinc_x[5]~20\ & \inst9|inst1|I4|iinc_i[5]\ & \inst9|inst1|I2|int_stop_x~11\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0AA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|iinc_x[5]~20\,
	datac => \inst9|inst1|I4|iinc_i[5]\,
	datad => \inst9|inst1|I2|int_stop_x~11\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|iinc_c[5]\);

\inst9|inst1|I4|iinc_x[4]~2_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_x[4]~2\ = \inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I3|acc_c[0][4]\ # !\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|iinc_c[4]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F808",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~18\,
	datab => \inst9|inst1|I4|iinc_c[4]\,
	datac => \inst9|inst1|I4|iinc_we_c\,
	datad => \inst9|inst1|I3|acc_c[0][4]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|iinc_x[4]~2\);

\inst9|inst1|I4|iinc_i[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_i[4]\ = DFFE(\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I3|acc_c[0][4]\ # !\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|iinc_c[4]\, GLOBAL(\clk~combout\), , , \inst9|inst1|I4|ireg_i[4]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CAC0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~18\,
	datab => \inst9|inst1|I3|acc_c[0][4]\,
	datac => \inst9|inst1|I4|iinc_we_c\,
	datad => \inst9|inst1|I4|iinc_c[4]\,
	clk => \clk~combout\,
	ena => \inst9|inst1|I4|ireg_i[4]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|iinc_i[4]\);

\inst9|inst1|I4|iinc_c[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_c[4]\ = DFFE(\inst9|inst1|I4|iinc_x[4]~2\ & (\inst9|inst1|I4|iinc_i[4]\ # !\inst9|inst1|I2|int_stop_x~11\) # !\inst9|inst1|I4|iinc_x[4]~2\ & \inst9|inst1|I4|iinc_i[4]\ & \inst9|inst1|I2|int_stop_x~11\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|iinc_x[4]~2\,
	datac => \inst9|inst1|I4|iinc_i[4]\,
	datad => \inst9|inst1|I2|int_stop_x~11\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|iinc_c[4]\);

\inst9|inst1|I4|add_104~3_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104~3\ = \inst9|inst1|I4|ireg_c[3]\ $ \inst9|inst1|I4|iinc_c[3]\ $ \inst9|inst1|I4|add_104~2COUT\
-- \inst9|inst1|I4|add_104~3COUT\ = CARRY(\inst9|inst1|I4|ireg_c[3]\ & !\inst9|inst1|I4|iinc_c[3]\ & !\inst9|inst1|I4|add_104~2COUT\ # !\inst9|inst1|I4|ireg_c[3]\ & (!\inst9|inst1|I4|add_104~2COUT\ # !\inst9|inst1|I4|iinc_c[3]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "9617",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[3]\,
	datab => \inst9|inst1|I4|iinc_c[3]\,
	cin => \inst9|inst1|I4|add_104~2COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104~3\,
	cout => \inst9|inst1|I4|add_104~3COUT\);

\inst9|inst1|I4|add_104~4_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104~4\ = \inst9|inst1|I4|iinc_c[4]\ $ \inst9|inst1|I4|ireg_c[4]\ $ !\inst9|inst1|I4|add_104~3COUT\
-- \inst9|inst1|I4|add_104~4COUT\ = CARRY(\inst9|inst1|I4|iinc_c[4]\ & (\inst9|inst1|I4|ireg_c[4]\ # !\inst9|inst1|I4|add_104~3COUT\) # !\inst9|inst1|I4|iinc_c[4]\ & \inst9|inst1|I4|ireg_c[4]\ & !\inst9|inst1|I4|add_104~3COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "698E",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|iinc_c[4]\,
	datab => \inst9|inst1|I4|ireg_c[4]\,
	cin => \inst9|inst1|I4|add_104~3COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104~4\,
	cout => \inst9|inst1|I4|add_104~4COUT\);

\inst9|inst1|I4|add_104_rtl_475~68_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104_rtl_475~68\ = \inst9|inst1|I4|reduce_nor_103\ & \inst9|inst1|I4|ireg_c[4]\ # !\inst9|inst1|I4|reduce_nor_103\ & (\inst9|inst1|I4|i~815\ & \inst9|inst1|I4|add_104~4\ # !\inst9|inst1|I4|i~815\ & \inst9|inst1|I4|ireg_c[4]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "B8AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[4]\,
	datab => \inst9|inst1|I4|reduce_nor_103\,
	datac => \inst9|inst1|I4|add_104~4\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104_rtl_475~68\);

\inst9|inst1|I4|ireg_i[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_i[4]\ = DFFE(\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I3|acc_c[0][4]\ # !\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|add_104_rtl_475~68\, GLOBAL(\clk~combout\), , , \inst9|inst1|I4|ireg_i[4]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CAC0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~18\,
	datab => \inst9|inst1|I3|acc_c[0][4]\,
	datac => \inst9|inst1|I4|ireg_we_c\,
	datad => \inst9|inst1|I4|add_104_rtl_475~68\,
	clk => \clk~combout\,
	ena => \inst9|inst1|I4|ireg_i[4]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|ireg_i[4]\);

\inst9|inst1|I4|add_104_rtl_475~73_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104_rtl_475~73\ = \inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I3|acc_c[0][4]\ # !\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|add_104_rtl_475~68\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CAC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~18\,
	datab => \inst9|inst1|I3|acc_c[0][4]\,
	datac => \inst9|inst1|I4|ireg_we_c\,
	datad => \inst9|inst1|I4|add_104_rtl_475~68\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104_rtl_475~73\);

\inst9|inst1|I4|ireg_c[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_c[4]\ = DFFE(\inst9|inst1|I4|ireg_i[4]\ & (\inst9|inst1|I2|int_stop_x~11\ # \inst9|inst1|I4|add_104_rtl_475~73\) # !\inst9|inst1|I4|ireg_i[4]\ & !\inst9|inst1|I2|int_stop_x~11\ & \inst9|inst1|I4|add_104_rtl_475~73\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CFC0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|ireg_i[4]\,
	datac => \inst9|inst1|I2|int_stop_x~11\,
	datad => \inst9|inst1|I4|add_104_rtl_475~73\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|ireg_c[4]\);

\inst9|inst1|I4|add_104~5_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104~5\ = \inst9|inst1|I4|iinc_c[5]\ $ \inst9|inst1|I4|ireg_c[5]\ $ \inst9|inst1|I4|add_104~4COUT\
-- \inst9|inst1|I4|add_104~5COUT\ = CARRY(\inst9|inst1|I4|iinc_c[5]\ & !\inst9|inst1|I4|ireg_c[5]\ & !\inst9|inst1|I4|add_104~4COUT\ # !\inst9|inst1|I4|iinc_c[5]\ & (!\inst9|inst1|I4|add_104~4COUT\ # !\inst9|inst1|I4|ireg_c[5]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "9617",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|iinc_c[5]\,
	datab => \inst9|inst1|I4|ireg_c[5]\,
	cin => \inst9|inst1|I4|add_104~4COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104~5\,
	cout => \inst9|inst1|I4|add_104~5COUT\);

\inst9|inst1|I4|add_104_rtl_475~108_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104_rtl_475~108\ = \inst9|inst1|I4|reduce_nor_103\ & \inst9|inst1|I4|ireg_c[5]\ # !\inst9|inst1|I4|reduce_nor_103\ & (\inst9|inst1|I4|i~815\ & \inst9|inst1|I4|add_104~5\ # !\inst9|inst1|I4|i~815\ & \inst9|inst1|I4|ireg_c[5]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E2F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|add_104~5\,
	datab => \inst9|inst1|I4|reduce_nor_103\,
	datac => \inst9|inst1|I4|ireg_c[5]\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104_rtl_475~108\);

\inst9|inst1|I4|ireg_i[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_i[5]\ = DFFE(\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I3|acc_c[0][5]\ # !\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|add_104_rtl_475~108\, GLOBAL(\clk~combout\), , , \inst9|inst1|I4|ireg_i[4]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "D888",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_we_c\,
	datab => \inst9|inst1|I3|acc_c[0][5]\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I4|add_104_rtl_475~108\,
	clk => \clk~combout\,
	ena => \inst9|inst1|I4|ireg_i[4]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|ireg_i[5]\);

\inst9|inst1|I4|add_104_rtl_475~113_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104_rtl_475~113\ = \inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I3|acc_c[0][5]\ # !\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|add_104_rtl_475~108\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "D888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_we_c\,
	datab => \inst9|inst1|I3|acc_c[0][5]\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I4|add_104_rtl_475~108\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104_rtl_475~113\);

\inst9|inst1|I4|ireg_c[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_c[5]\ = DFFE(\inst9|inst1|I4|ireg_i[5]\ & (\inst9|inst1|I4|add_104_rtl_475~113\ # \inst9|inst1|I2|int_stop_x~11\) # !\inst9|inst1|I4|ireg_i[5]\ & \inst9|inst1|I4|add_104_rtl_475~113\ & !\inst9|inst1|I2|int_stop_x~11\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|ireg_i[5]\,
	datac => \inst9|inst1|I4|add_104_rtl_475~113\,
	datad => \inst9|inst1|I2|int_stop_x~11\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|ireg_c[5]\);

\inst9|inst1|I2|idata_x[9]~55_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[9]~55\ = \inst9|inst1|I2|i~509\ & (\inst9|inst1|I2|i~2\ & \inst9|inst1|I2|data_is_c[5]\ # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[9]\) # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[9]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~509\,
	datab => \inst9|inst1|I2|data_is_c[5]\,
	datac => \inst9|inst1|I2|i~2\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[9]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[9]~55\);

\inst9|inst1|I4|daddr_x[5]~70_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[5]~70\ = \inst9|inst1|I2|idata_x[9]~55\ # \inst9|inst1|I4|ireg_c[5]\ & !\inst9|inst1|I4|reduce_nor_103\ & \inst9|inst1|I4|i~815\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F2F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[5]\,
	datab => \inst9|inst1|I4|reduce_nor_103\,
	datac => \inst9|inst1|I2|idata_x[9]~55\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[5]~70\);

\inst9|inst4|daddr_c[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|daddr_c[5]\ = DFFE(\inst9|inst4|i~48\ & \inst9|inst4|daddr_c[5]\ # !\inst9|inst4|i~48\ & \inst9|inst1|I4|daddr_x[5]~70\ & \inst9|inst1|I4|i~18\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CAC0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|daddr_x[5]~70\,
	datab => \inst9|inst4|daddr_c[5]\,
	datac => \inst9|inst4|i~48\,
	datad => \inst9|inst1|I4|i~18\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst4|daddr_c[5]\);

\inst9|inst1|I4|i~760_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|i~760\ = !\inst9|inst1|I2|idata_x[6]~28\ & !\inst9|inst1|I2|idata_x[5]~34\ & !\inst9|inst1|I2|idata_x[4]~37\ & \inst9|inst1|I4|i~815\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0100",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[6]~28\,
	datab => \inst9|inst1|I2|idata_x[5]~34\,
	datac => \inst9|inst1|I2|idata_x[4]~37\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|i~760\);

\inst9|inst1|I4|daddr_x[5]~76_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[5]~76\ = \inst9|inst1|I4|i~18\ & (\inst9|inst1|I2|idata_x[9]~55\ # \inst9|inst1|I4|ireg_c[5]\ & \inst9|inst1|I4|i~760\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C8C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[5]\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I2|idata_x[9]~55\,
	datad => \inst9|inst1|I4|i~760\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[5]~76\);

\inst9|inst4|i~444_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~444\ = \inst9|inst1|I4|ndre_x~1\ & \inst9|inst4|daddr_c[5]\ & !\inst9|inst4|i~382\ # !\inst9|inst1|I4|ndre_x~1\ & \inst9|inst1|I4|daddr_x[5]~76\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "22F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst4|daddr_c[5]\,
	datab => \inst9|inst4|i~382\,
	datac => \inst9|inst1|I4|daddr_x[5]~76\,
	datad => \inst9|inst1|I4|ndre_x~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~444\);

\inst9|inst1|I1|pc[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|pc[5]\ = DFFE(\inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I1|iaddr_x[5]~534\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I1|iaddr_x[5]~534\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I1|pc[5]\);

\inst9|inst1|I1|pc[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|pc[4]\ = DFFE(\inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\ & \inst9|inst1|I1|iaddr_x[4]~462\ & \inst9|inst7\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\,
	datac => \inst9|inst1|I1|iaddr_x[4]~462\,
	datad => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I1|pc[4]\);

\inst9|inst1|I2|pc_mux_x[1]~408_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|pc_mux_x[1]~408\ = \inst9|inst1|I2|TC_x[2]~570\ & (\inst9|inst1|I2|TC_x[0]~146\ & !\inst9|inst1|I2|E_x.int_e~96\ # !\inst9|inst1|I2|TC_x[0]~146\ & \inst9|inst1|I2|TC_x[1]~22\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "44C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|E_x.int_e~96\,
	datab => \inst9|inst1|I2|TC_x[2]~570\,
	datac => \inst9|inst1|I2|TC_x[1]~22\,
	datad => \inst9|inst1|I2|TC_x[0]~146\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|pc_mux_x[1]~408\);

\inst9|inst1|I2|pc_mux_x[1]~48_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|pc_mux_x[1]~48\ = \inst9|inst1|I2|S_c~10\ & \inst9|inst1|I2|reduce_nor_128\ & !\inst9|inst1|I2|TC_x[0]~146\ & \inst9|inst1|I2|i~420\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|S_c~10\,
	datab => \inst9|inst1|I2|reduce_nor_128\,
	datac => \inst9|inst1|I2|TC_x[0]~146\,
	datad => \inst9|inst1|I2|i~420\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|pc_mux_x[1]~48\);

\inst9|inst1|I1|iaddr_x[3]~386_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[3]~386\ = \inst9|inst1|I2|pc_mux_x[1]~422\ & \inst9|inst15|lpm_ram_dq_component|sram|q[7]\ & (\inst9|inst1|I2|pc_mux_x[1]~408\ # \inst9|inst1|I2|pc_mux_x[1]~48\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8880",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~422\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[7]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~408\,
	datad => \inst9|inst1|I2|pc_mux_x[1]~48\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[3]~386\);

\inst9|inst1|I1|iaddr_x[2]~350_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[2]~350\ = \inst9|inst1|I2|pc_mux_x[1]~422\ & \inst9|inst15|lpm_ram_dq_component|sram|q[6]\ & (\inst9|inst1|I2|pc_mux_x[1]~408\ # \inst9|inst1|I2|pc_mux_x[1]~48\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8880",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~422\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[6]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~408\,
	datad => \inst9|inst1|I2|pc_mux_x[1]~48\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[2]~350\);

\inst9|inst1|I1|iaddr_x[1]~321_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[1]~321\ = \inst9|inst1|I2|pc_mux_x[1]~422\ & \inst9|inst15|lpm_ram_dq_component|sram|q[5]\ & (\inst9|inst1|I2|pc_mux_x[1]~408\ # \inst9|inst1|I2|pc_mux_x[1]~48\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8880",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~422\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[5]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~408\,
	datad => \inst9|inst1|I2|pc_mux_x[1]~48\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[1]~321\);

\inst9|inst1|I1|iaddr_x[0]~292_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[0]~292\ = \inst9|inst1|I2|pc_mux_x[1]~422\ & \inst9|inst15|lpm_ram_dq_component|sram|q[4]\ & (\inst9|inst1|I2|pc_mux_x[1]~408\ # \inst9|inst1|I2|pc_mux_x[1]~48\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8880",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~422\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[4]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~408\,
	datad => \inst9|inst1|I2|pc_mux_x[1]~48\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[0]~292\);

\inst9|inst1|I1|add_25~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|add_25~0\ = !\inst9|inst1|I1|pc[0]\
-- \inst9|inst1|I1|add_25~0COUT\ = CARRY(\inst9|inst1|I1|pc[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	packed_mode => "false",
	lut_mask => "33CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I1|pc[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|add_25~0\,
	cout => \inst9|inst1|I1|add_25~0COUT\);

\inst9|inst1|I2|pc_mux_x[1]~53_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|pc_mux_x[1]~53\ = \inst9|inst1|I2|pc_mux_x[1]~422\ & (\inst9|inst1|I2|pc_mux_x[1]~408\ # \inst9|inst1|I2|reduce_nor_128\ & \inst9|inst1|I2|i~510\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~422\,
	datab => \inst9|inst1|I2|pc_mux_x[1]~408\,
	datac => \inst9|inst1|I2|reduce_nor_128\,
	datad => \inst9|inst1|I2|i~510\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|pc_mux_x[1]~53\);

\inst9|inst1|I2|i~422_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|i~422\ = !\inst9|inst4|a2vi_s\ & (!\inst9|inst12|dwait_c\ # !\inst9|inst1|I2|i~441\) # !\inst9|inst1|I2|i~2\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "13FF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~441\,
	datab => \inst9|inst4|a2vi_s\,
	datac => \inst9|inst12|dwait_c\,
	datad => \inst9|inst1|I2|i~2\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|i~422\);

\inst9|inst1|I2|pc_mux_x[0]~402_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|pc_mux_x[0]~402\ = !\inst9|inst1|I2|E_x.int_e~96\ & (\inst9|inst1|I2|skip_x~41\ # \inst9|inst1|I2|skip_x~62\) # !\inst9|inst1|I2|i~2\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "3F3B",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|skip_x~41\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst1|I2|E_x.int_e~96\,
	datad => \inst9|inst1|I2|skip_x~62\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|pc_mux_x[0]~402\);

\rtl~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~0\ = \inst9|inst1|I2|E_x.int_e~96\ $ (\inst9|inst1|I2|C_raw~56\ & !\inst9|inst1|I2|TC_x[1]~22\ & \inst9|inst1|I2|C_raw~61\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A6AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|E_x.int_e~96\,
	datab => \inst9|inst1|I2|C_raw~56\,
	datac => \inst9|inst1|I2|TC_x[1]~22\,
	datad => \inst9|inst1|I2|C_raw~61\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~0\);

\inst9|inst1|I3|skip_l~8_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|skip_l~8\ = \inst9|inst1|I3|i~173\ & (\rtl~10188\ # \rtl~10195\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \rtl~10188\,
	datac => \inst9|inst1|I3|i~173\,
	datad => \rtl~10195\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|skip_l~8\);

\inst9|inst1|I2|skip_x~61_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|skip_x~61\ = \inst9|inst1|I2|skip_x~107\ & \inst9|inst1|I2|skip_c\ # !\inst9|inst1|I2|skip_x~107\ & !\inst9|inst1|I2|int_start_c\ & \inst9|inst1|I3|skip_l~8\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "D1C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|int_start_c\,
	datab => \inst9|inst1|I2|skip_x~107\,
	datac => \inst9|inst1|I2|skip_c\,
	datad => \inst9|inst1|I3|skip_l~8\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|skip_x~61\);

\inst9|inst1|I2|pc_mux_x[0]~390_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|pc_mux_x[0]~390\ = !\inst9|inst1|I2|skip_x~61\ & (\inst9|inst1|I2|TC_x[0]~146\ # !\inst9|inst1|I2|TC_x[1]~22\ # !\inst9|inst1|I2|TC_x[2]~570\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "3313",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TC_x[2]~570\,
	datab => \inst9|inst1|I2|skip_x~61\,
	datac => \inst9|inst1|I2|TC_x[1]~22\,
	datad => \inst9|inst1|I2|TC_x[0]~146\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|pc_mux_x[0]~390\);

\inst9|inst1|I2|pc_mux_x[0]~30_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|pc_mux_x[0]~30\ = \inst9|inst1|I2|pc_mux_x[0]~390\ & (\inst9|inst1|I2|i~103\ # !\rtl~0\ # !\inst9|inst1|I2|reduce_nor_128\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F700",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|reduce_nor_128\,
	datab => \rtl~0\,
	datac => \inst9|inst1|I2|i~103\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~390\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|pc_mux_x[0]~30\);

\inst9|inst1|I2|pc_mux_x[0]~33_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|pc_mux_x[0]~33\ = \inst9|inst1|I2|i~422\ & (\inst9|inst1|I2|pc_mux_x[0]~402\ # \inst9|inst1|I2|pc_mux_x[0]~30\) # !\inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BBB3",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~422\,
	datab => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~402\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~30\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|pc_mux_x[0]~33\);

\inst9|inst1|I1|iaddr_x[0]~293_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[0]~293\ = !\inst9|inst1|I2|pc_mux_x[1]~53\ & (\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|add_25~0\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|pc[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2230",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~0\,
	datab => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datac => \inst9|inst1|I1|pc[0]\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[0]~293\);

\inst9|inst1|I2|pc_mux_x[2]~445_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|pc_mux_x[2]~445\ = (\inst9|inst1|I2|pc_mux_x[2]~348\ & (!\inst9|inst1|I2|TC_x[2]~570\ # !\inst9|inst1|I2|TC_x[1]~22\)) & CASCADE(\inst9|inst1|I2|i~515\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0CCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|pc_mux_x[2]~348\,
	datac => \inst9|inst1|I2|TC_x[1]~22\,
	datad => \inst9|inst1|I2|TC_x[2]~570\,
	cascin => \inst9|inst1|I2|i~515\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|pc_mux_x[2]~445\);

\inst9|inst1|I1|Mux_59~8_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_59~8\ = \inst9|inst1|I2|pc_mux_x[2]~386\ & \inst9|inst1|I1|i~2\ & (\inst9|inst1|I2|E_x.int_e~96\ # \inst9|inst1|I2|pc_mux_x[2]~445\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[2]~386\,
	datab => \inst9|inst1|I2|E_x.int_e~96\,
	datac => \inst9|inst1|I1|i~2\,
	datad => \inst9|inst1|I2|pc_mux_x[2]~445\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_59~8\);

\rtl~10683_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10683\ = \inst9|inst1|I1|i~2\ & (!\inst9|inst1|I2|E_x.int_e~96\ & !\inst9|inst1|I2|pc_mux_x[2]~445\ # !\inst9|inst1|I2|pc_mux_x[2]~386\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0A2A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|i~2\,
	datab => \inst9|inst1|I2|E_x.int_e~96\,
	datac => \inst9|inst1|I2|pc_mux_x[2]~386\,
	datad => \inst9|inst1|I2|pc_mux_x[2]~445\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10683\);

\rtl~1455_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1455\ = \inst9|inst1|I1|add_25~0\ & \inst9|inst1|I2|pc_mux_x[1]~53\ & \inst9|inst1|I2|pc_mux_x[0]~33\ & \rtl~10683\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~0\,
	datab => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datad => \rtl~10683\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1455\);

\inst9|inst1|I1|Mux_59~9_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_59~9\ = \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I2|pc_mux_x[2]~444\ & \inst9|inst1|I2|pc_mux_x[1]~53\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\,
	datab => \inst9|inst7\,
	datac => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datad => \inst9|inst1|I2|pc_mux_x[1]~53\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_59~9\);

\rtl~790\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~313\ = \inst9|inst1|I2|pc_mux_x[0]~33\ & \rtl~313\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & (\inst9|inst1|I1|Mux_59~9\ & \inst9|inst15|lpm_ram_dq_component|sram|q[4]\ # !\inst9|inst1|I1|Mux_59~9\ & \rtl~313\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E2F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst15|lpm_ram_dq_component|sram|q[4]\,
	datab => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datac => \rtl~313\,
	datad => \inst9|inst1|I1|Mux_59~9\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~313\);

\inst9|inst1|I1|Mux_49_rtl_59_rtl_294~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_49_rtl_59_rtl_294~0\ = \inst9|inst1|I2|pc_mux_x[0]~33\ & (\inst9|inst1|I1|pc[0]\ # \inst9|inst1|I2|pc_mux_x[1]~53\) # !\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|add_25~0\ & !\inst9|inst1|I2|pc_mux_x[1]~53\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0CA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~0\,
	datab => \inst9|inst1|I1|pc[0]\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datad => \inst9|inst1|I2|pc_mux_x[1]~53\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_49_rtl_59_rtl_294~0\);

\inst9|inst1|I1|Mux_49_rtl_59_rtl_294~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_49_rtl_59_rtl_294~1\ = \inst9|inst1|I1|Mux_49_rtl_59_rtl_294~0\ & (\inst9|inst11|inst|lpm_ram_dq_component|sram|q[0]\ # !\inst9|inst1|I2|pc_mux_x[1]~53\) # !\inst9|inst1|I1|Mux_49_rtl_59_rtl_294~0\ & \inst9|inst1|I2|pc_mux_x[1]~53\ & \rtl~313\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DDA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[0]\,
	datac => \rtl~313\,
	datad => \inst9|inst1|I1|Mux_49_rtl_59_rtl_294~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_49_rtl_59_rtl_294~1\);

\inst9|inst1|I1|Mux_37_rtl_186~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_37_rtl_186~0\ = \inst9|inst1|I2|pc_mux_x[1]~53\ & \inst9|inst1|I2|pc_mux_x[0]~33\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_37_rtl_186~0\);

\rtl~1837_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1837\ = \inst9|inst11|inst|lpm_ram_dq_component|sram|q[0]\ & (!\inst9|inst1|I2|pc_mux_x[2]~444\ & !\inst9|inst1|I1|Mux_37_rtl_186~0\ # !\inst9|inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5070",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|i~2\,
	datab => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datac => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[0]\,
	datad => \inst9|inst1|I1|Mux_37_rtl_186~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1837\);

\rtl~1836_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1836\ = \rtl~1455\ # \rtl~1837\ # \inst9|inst1|I1|Mux_59~8\ & \inst9|inst1|I1|Mux_49_rtl_59_rtl_294~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFEC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|Mux_59~8\,
	datab => \rtl~1455\,
	datac => \inst9|inst1|I1|Mux_49_rtl_59_rtl_294~1\,
	datad => \rtl~1837\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1836\);

\inst9|inst1|I1|i~15_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|i~15\ = \inst9|inst1|I1|i~2\ & (\inst9|inst1|I2|pc_mux_x[2]~444\ $ (\inst9|inst1|I2|pc_mux_x[1]~53\ & \inst9|inst1|I2|pc_mux_x[0]~33\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|i~2\,
	datab => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|i~15\);

\inst9|inst1|I1|i~16_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|i~16\ = \inst9|inst1|I1|i~2\ & \inst9|inst1|I2|pc_mux_x[2]~444\ & \inst9|inst1|I2|pc_mux_x[1]~53\ & \inst9|inst1|I2|pc_mux_x[0]~33\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|i~2\,
	datab => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|i~16\);

\inst9|inst11|inst8|add_17_rtl_16~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_17_rtl_16~0\ = \inst9|inst11|inst8|addr_c[0]\ $ !\inst9|inst1|I1|i~16\
-- \inst9|inst11|inst8|add_17_rtl_16~0COUT\ = CARRY(!\inst9|inst11|inst8|addr_c[0]\ & \inst9|inst1|I1|i~16\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	packed_mode => "false",
	lut_mask => "9944",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst8|addr_c[0]\,
	datab => \inst9|inst1|I1|i~16\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_17_rtl_16~0\,
	cout => \inst9|inst11|inst8|add_17_rtl_16~0COUT\);

\inst9|inst11|inst8|addr_c[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|addr_c[0]\ = DFFE(\inst9|inst11|inst8|add_15~0\ & !\inst9|inst1|I1|i~15\ & !\inst9|inst11|inst8|add_17_rtl_16~0\ # !\inst9|inst11|inst8|add_15~0\ & (\inst9|inst1|I1|i~15\ # !\inst9|inst11|inst8|add_17_rtl_16~0\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "303F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst8|add_15~0\,
	datac => \inst9|inst1|I1|i~15\,
	datad => \inst9|inst11|inst8|add_17_rtl_16~0\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst11|inst8|addr_c[0]\);

\inst9|inst11|inst8|add_15~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_15~0\ = \inst9|inst11|inst8|addr_c[0]\
-- \inst9|inst11|inst8|add_15~0COUT\ = CARRY(!\inst9|inst11|inst8|addr_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	packed_mode => "false",
	lut_mask => "CC33",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst8|addr_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_15~0\,
	cout => \inst9|inst11|inst8|add_15~0COUT\);

\inst9|inst11|inst8|add_15_rtl_477~10_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_15_rtl_477~10\ = \inst9|inst11|inst8|add_15~0\ & (\inst9|inst1|I1|i~15\ # \inst9|inst11|inst8|add_17_rtl_16~0\) # !\inst9|inst11|inst8|add_15~0\ & !\inst9|inst1|I1|i~15\ & \inst9|inst11|inst8|add_17_rtl_16~0\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CFC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst8|add_15~0\,
	datac => \inst9|inst1|I1|i~15\,
	datad => \inst9|inst11|inst8|add_17_rtl_16~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_15_rtl_477~10\);

\inst9|inst11|inst8|add_17_rtl_16~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_17_rtl_16~1\ = \inst9|inst11|inst8|addr_c[1]\ $ \inst9|inst1|I1|i~16\ $ !\inst9|inst11|inst8|add_17_rtl_16~0COUT\
-- \inst9|inst11|inst8|add_17_rtl_16~1COUT\ = CARRY(\inst9|inst11|inst8|addr_c[1]\ & (!\inst9|inst11|inst8|add_17_rtl_16~0COUT\ # !\inst9|inst1|I1|i~16\) # !\inst9|inst11|inst8|addr_c[1]\ & !\inst9|inst1|I1|i~16\ & !\inst9|inst11|inst8|add_17_rtl_16~0COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "692B",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst8|addr_c[1]\,
	datab => \inst9|inst1|I1|i~16\,
	cin => \inst9|inst11|inst8|add_17_rtl_16~0COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_17_rtl_16~1\,
	cout => \inst9|inst11|inst8|add_17_rtl_16~1COUT\);

\inst9|inst11|inst8|addr_c[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|addr_c[1]\ = DFFE(\inst9|inst11|inst8|add_15~1\ & !\inst9|inst11|inst8|add_17_rtl_16~1\ & !\inst9|inst1|I1|i~15\ # !\inst9|inst11|inst8|add_15~1\ & (\inst9|inst1|I1|i~15\ # !\inst9|inst11|inst8|add_17_rtl_16~1\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "330F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst8|add_15~1\,
	datac => \inst9|inst11|inst8|add_17_rtl_16~1\,
	datad => \inst9|inst1|I1|i~15\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst11|inst8|addr_c[1]\);

\inst9|inst11|inst8|add_15~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_15~1\ = \inst9|inst11|inst8|addr_c[1]\ $ !\inst9|inst11|inst8|add_15~0COUT\
-- \inst9|inst11|inst8|add_15~1COUT\ = CARRY(\inst9|inst11|inst8|addr_c[1]\ # !\inst9|inst11|inst8|add_15~0COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "A5AF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst8|addr_c[1]\,
	cin => \inst9|inst11|inst8|add_15~0COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_15~1\,
	cout => \inst9|inst11|inst8|add_15~1COUT\);

\inst9|inst11|inst8|add_15_rtl_477~13_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_15_rtl_477~13\ = \inst9|inst11|inst8|add_15~1\ & (\inst9|inst11|inst8|add_17_rtl_16~1\ # \inst9|inst1|I1|i~15\) # !\inst9|inst11|inst8|add_15~1\ & \inst9|inst11|inst8|add_17_rtl_16~1\ & !\inst9|inst1|I1|i~15\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst8|add_15~1\,
	datac => \inst9|inst11|inst8|add_17_rtl_16~1\,
	datad => \inst9|inst1|I1|i~15\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_15_rtl_477~13\);

\inst9|inst11|inst8|add_17_rtl_16~2_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_17_rtl_16~2\ = \inst9|inst11|inst8|addr_c[2]\ $ \inst9|inst1|I1|i~16\ $ \inst9|inst11|inst8|add_17_rtl_16~1COUT\
-- \inst9|inst11|inst8|add_17_rtl_16~2COUT\ = CARRY(\inst9|inst11|inst8|addr_c[2]\ & \inst9|inst1|I1|i~16\ & !\inst9|inst11|inst8|add_17_rtl_16~1COUT\ # !\inst9|inst11|inst8|addr_c[2]\ & (\inst9|inst1|I1|i~16\ # !\inst9|inst11|inst8|add_17_rtl_16~1COUT\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "964D",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst8|addr_c[2]\,
	datab => \inst9|inst1|I1|i~16\,
	cin => \inst9|inst11|inst8|add_17_rtl_16~1COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_17_rtl_16~2\,
	cout => \inst9|inst11|inst8|add_17_rtl_16~2COUT\);

\inst9|inst11|inst8|addr_c[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|addr_c[2]\ = DFFE(\inst9|inst11|inst8|add_15~2\ & !\inst9|inst11|inst8|add_17_rtl_16~2\ & !\inst9|inst1|I1|i~15\ # !\inst9|inst11|inst8|add_15~2\ & (\inst9|inst1|I1|i~15\ # !\inst9|inst11|inst8|add_17_rtl_16~2\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "330F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst8|add_15~2\,
	datac => \inst9|inst11|inst8|add_17_rtl_16~2\,
	datad => \inst9|inst1|I1|i~15\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst11|inst8|addr_c[2]\);

\inst9|inst11|inst8|add_15~2_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_15~2\ = \inst9|inst11|inst8|addr_c[2]\ $ \inst9|inst11|inst8|add_15~1COUT\
-- \inst9|inst11|inst8|add_15~2COUT\ = CARRY(!\inst9|inst11|inst8|addr_c[2]\ & !\inst9|inst11|inst8|add_15~1COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5A05",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst8|addr_c[2]\,
	cin => \inst9|inst11|inst8|add_15~1COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_15~2\,
	cout => \inst9|inst11|inst8|add_15~2COUT\);

\inst9|inst11|inst8|add_15_rtl_477~16_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_15_rtl_477~16\ = \inst9|inst11|inst8|add_15~2\ & (\inst9|inst11|inst8|add_17_rtl_16~2\ # \inst9|inst1|I1|i~15\) # !\inst9|inst11|inst8|add_15~2\ & \inst9|inst11|inst8|add_17_rtl_16~2\ & !\inst9|inst1|I1|i~15\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst8|add_15~2\,
	datac => \inst9|inst11|inst8|add_17_rtl_16~2\,
	datad => \inst9|inst1|I1|i~15\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_15_rtl_477~16\);

\inst9|inst11|inst8|add_17_rtl_16~3_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_17_rtl_16~3\ = \inst9|inst11|inst8|addr_c[3]\ $ \inst9|inst1|I1|i~16\ $ !\inst9|inst11|inst8|add_17_rtl_16~2COUT\
-- \inst9|inst11|inst8|add_17_rtl_16~3COUT\ = CARRY(\inst9|inst11|inst8|addr_c[3]\ & (!\inst9|inst11|inst8|add_17_rtl_16~2COUT\ # !\inst9|inst1|I1|i~16\) # !\inst9|inst11|inst8|addr_c[3]\ & !\inst9|inst1|I1|i~16\ & !\inst9|inst11|inst8|add_17_rtl_16~2COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "692B",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst8|addr_c[3]\,
	datab => \inst9|inst1|I1|i~16\,
	cin => \inst9|inst11|inst8|add_17_rtl_16~2COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_17_rtl_16~3\,
	cout => \inst9|inst11|inst8|add_17_rtl_16~3COUT\);

\inst9|inst11|inst8|addr_c[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|addr_c[3]\ = DFFE(\inst9|inst1|I1|i~15\ & !\inst9|inst11|inst8|add_15~3\ # !\inst9|inst1|I1|i~15\ & !\inst9|inst11|inst8|add_17_rtl_16~3\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0C3F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I1|i~15\,
	datac => \inst9|inst11|inst8|add_15~3\,
	datad => \inst9|inst11|inst8|add_17_rtl_16~3\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst11|inst8|addr_c[3]\);

\inst9|inst11|inst8|add_15~3_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_15~3\ = \inst9|inst11|inst8|addr_c[3]\ $ !\inst9|inst11|inst8|add_15~2COUT\
-- \inst9|inst11|inst8|add_15~3COUT\ = CARRY(\inst9|inst11|inst8|addr_c[3]\ # !\inst9|inst11|inst8|add_15~2COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "A5AF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst8|addr_c[3]\,
	cin => \inst9|inst11|inst8|add_15~2COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_15~3\,
	cout => \inst9|inst11|inst8|add_15~3COUT\);

\inst9|inst11|inst8|add_15_rtl_477~19_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_15_rtl_477~19\ = \inst9|inst1|I1|i~15\ & \inst9|inst11|inst8|add_15~3\ # !\inst9|inst1|I1|i~15\ & \inst9|inst11|inst8|add_17_rtl_16~3\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F3C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I1|i~15\,
	datac => \inst9|inst11|inst8|add_15~3\,
	datad => \inst9|inst11|inst8|add_17_rtl_16~3\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_15_rtl_477~19\);

\inst9|inst11|inst8|add_17_rtl_16~4_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_17_rtl_16~4\ = \inst9|inst11|inst8|addr_c[4]\ $ \inst9|inst1|I1|i~16\ $ \inst9|inst11|inst8|add_17_rtl_16~3COUT\
-- \inst9|inst11|inst8|add_17_rtl_16~4COUT\ = CARRY(\inst9|inst11|inst8|addr_c[4]\ & \inst9|inst1|I1|i~16\ & !\inst9|inst11|inst8|add_17_rtl_16~3COUT\ # !\inst9|inst11|inst8|addr_c[4]\ & (\inst9|inst1|I1|i~16\ # !\inst9|inst11|inst8|add_17_rtl_16~3COUT\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "964D",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst8|addr_c[4]\,
	datab => \inst9|inst1|I1|i~16\,
	cin => \inst9|inst11|inst8|add_17_rtl_16~3COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_17_rtl_16~4\,
	cout => \inst9|inst11|inst8|add_17_rtl_16~4COUT\);

\inst9|inst11|inst8|addr_c[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|addr_c[4]\ = DFFE(\inst9|inst1|I1|i~15\ & !\inst9|inst11|inst8|add_15~4\ # !\inst9|inst1|I1|i~15\ & !\inst9|inst11|inst8|add_17_rtl_16~4\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0C3F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I1|i~15\,
	datac => \inst9|inst11|inst8|add_15~4\,
	datad => \inst9|inst11|inst8|add_17_rtl_16~4\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst11|inst8|addr_c[4]\);

\inst9|inst11|inst8|add_15~4_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_15~4\ = \inst9|inst11|inst8|addr_c[4]\ $ \inst9|inst11|inst8|add_15~3COUT\
-- \inst9|inst11|inst8|add_15~4COUT\ = CARRY(!\inst9|inst11|inst8|addr_c[4]\ & !\inst9|inst11|inst8|add_15~3COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5A05",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst8|addr_c[4]\,
	cin => \inst9|inst11|inst8|add_15~3COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_15~4\,
	cout => \inst9|inst11|inst8|add_15~4COUT\);

\inst9|inst11|inst8|add_15_rtl_477~22_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_15_rtl_477~22\ = \inst9|inst1|I1|i~15\ & \inst9|inst11|inst8|add_15~4\ # !\inst9|inst1|I1|i~15\ & \inst9|inst11|inst8|add_17_rtl_16~4\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F3C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I1|i~15\,
	datac => \inst9|inst11|inst8|add_15~4\,
	datad => \inst9|inst11|inst8|add_17_rtl_16~4\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_15_rtl_477~22\);

\inst9|inst11|inst8|add_17_rtl_16~5_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_17_rtl_16~5\ = \inst9|inst11|inst8|addr_c[5]\ $ \inst9|inst1|I1|i~16\ $ !\inst9|inst11|inst8|add_17_rtl_16~4COUT\
-- \inst9|inst11|inst8|add_17_rtl_16~5COUT\ = CARRY(\inst9|inst11|inst8|addr_c[5]\ & (!\inst9|inst11|inst8|add_17_rtl_16~4COUT\ # !\inst9|inst1|I1|i~16\) # !\inst9|inst11|inst8|addr_c[5]\ & !\inst9|inst1|I1|i~16\ & !\inst9|inst11|inst8|add_17_rtl_16~4COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "692B",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst8|addr_c[5]\,
	datab => \inst9|inst1|I1|i~16\,
	cin => \inst9|inst11|inst8|add_17_rtl_16~4COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_17_rtl_16~5\,
	cout => \inst9|inst11|inst8|add_17_rtl_16~5COUT\);

\inst9|inst11|inst8|addr_c[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|addr_c[5]\ = DFFE(\inst9|inst11|inst8|add_15~5\ & !\inst9|inst11|inst8|add_17_rtl_16~5\ & !\inst9|inst1|I1|i~15\ # !\inst9|inst11|inst8|add_15~5\ & (\inst9|inst1|I1|i~15\ # !\inst9|inst11|inst8|add_17_rtl_16~5\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "330F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst8|add_15~5\,
	datac => \inst9|inst11|inst8|add_17_rtl_16~5\,
	datad => \inst9|inst1|I1|i~15\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst11|inst8|addr_c[5]\);

\inst9|inst11|inst8|add_15~5_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_15~5\ = \inst9|inst11|inst8|addr_c[5]\ $ !\inst9|inst11|inst8|add_15~4COUT\
-- \inst9|inst11|inst8|add_15~5COUT\ = CARRY(\inst9|inst11|inst8|addr_c[5]\ # !\inst9|inst11|inst8|add_15~4COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "A5AF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst8|addr_c[5]\,
	cin => \inst9|inst11|inst8|add_15~4COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_15~5\,
	cout => \inst9|inst11|inst8|add_15~5COUT\);

\inst9|inst11|inst8|add_15_rtl_477~25_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_15_rtl_477~25\ = \inst9|inst11|inst8|add_15~5\ & (\inst9|inst11|inst8|add_17_rtl_16~5\ # \inst9|inst1|I1|i~15\) # !\inst9|inst11|inst8|add_15~5\ & \inst9|inst11|inst8|add_17_rtl_16~5\ & !\inst9|inst1|I1|i~15\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst8|add_15~5\,
	datac => \inst9|inst11|inst8|add_17_rtl_16~5\,
	datad => \inst9|inst1|I1|i~15\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_15_rtl_477~25\);

\inst9|inst11|inst8|add_17_rtl_16~6_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_17_rtl_16~6\ = \inst9|inst11|inst8|addr_c[6]\ $ \inst9|inst1|I1|i~16\ $ \inst9|inst11|inst8|add_17_rtl_16~5COUT\
-- \inst9|inst11|inst8|add_17_rtl_16~6COUT\ = CARRY(\inst9|inst11|inst8|addr_c[6]\ & \inst9|inst1|I1|i~16\ & !\inst9|inst11|inst8|add_17_rtl_16~5COUT\ # !\inst9|inst11|inst8|addr_c[6]\ & (\inst9|inst1|I1|i~16\ # !\inst9|inst11|inst8|add_17_rtl_16~5COUT\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "964D",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst8|addr_c[6]\,
	datab => \inst9|inst1|I1|i~16\,
	cin => \inst9|inst11|inst8|add_17_rtl_16~5COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_17_rtl_16~6\,
	cout => \inst9|inst11|inst8|add_17_rtl_16~6COUT\);

\inst9|inst11|inst8|addr_c[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|addr_c[6]\ = DFFE(\inst9|inst11|inst8|add_15~6\ & !\inst9|inst11|inst8|add_17_rtl_16~6\ & !\inst9|inst1|I1|i~15\ # !\inst9|inst11|inst8|add_15~6\ & (\inst9|inst1|I1|i~15\ # !\inst9|inst11|inst8|add_17_rtl_16~6\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "330F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst8|add_15~6\,
	datac => \inst9|inst11|inst8|add_17_rtl_16~6\,
	datad => \inst9|inst1|I1|i~15\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst11|inst8|addr_c[6]\);

\inst9|inst11|inst8|add_15~6_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_15~6\ = \inst9|inst11|inst8|addr_c[6]\ $ \inst9|inst11|inst8|add_15~5COUT\
-- \inst9|inst11|inst8|add_15~6COUT\ = CARRY(!\inst9|inst11|inst8|addr_c[6]\ & !\inst9|inst11|inst8|add_15~5COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5A05",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst8|addr_c[6]\,
	cin => \inst9|inst11|inst8|add_15~5COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_15~6\,
	cout => \inst9|inst11|inst8|add_15~6COUT\);

\inst9|inst11|inst8|add_15_rtl_477~28_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_15_rtl_477~28\ = \inst9|inst1|I1|i~15\ & \inst9|inst11|inst8|add_15~6\ # !\inst9|inst1|I1|i~15\ & \inst9|inst11|inst8|add_17_rtl_16~6\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F3C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I1|i~15\,
	datac => \inst9|inst11|inst8|add_15~6\,
	datad => \inst9|inst11|inst8|add_17_rtl_16~6\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_15_rtl_477~28\);

\inst9|inst11|inst8|add_17_rtl_16~7_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_17_rtl_16~7\ = \inst9|inst11|inst8|addr_c[7]\ $ \inst9|inst11|inst8|add_17_rtl_16~6COUT\ $ !\inst9|inst1|I1|i~16\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3CC3",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst8|addr_c[7]\,
	datad => \inst9|inst1|I1|i~16\,
	cin => \inst9|inst11|inst8|add_17_rtl_16~6COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_17_rtl_16~7\);

\inst9|inst11|inst8|addr_c[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|addr_c[7]\ = DFFE(\inst9|inst11|inst8|add_15~7\ & !\inst9|inst11|inst8|add_17_rtl_16~7\ & !\inst9|inst1|I1|i~15\ # !\inst9|inst11|inst8|add_15~7\ & (\inst9|inst1|I1|i~15\ # !\inst9|inst11|inst8|add_17_rtl_16~7\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "330F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst8|add_15~7\,
	datac => \inst9|inst11|inst8|add_17_rtl_16~7\,
	datad => \inst9|inst1|I1|i~15\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst11|inst8|addr_c[7]\);

\inst9|inst11|inst8|add_15~7_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_15~7\ = \inst9|inst11|inst8|addr_c[7]\ $ !\inst9|inst11|inst8|add_15~6COUT\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "A5A5",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst8|addr_c[7]\,
	cin => \inst9|inst11|inst8|add_15~6COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_15~7\);

\inst9|inst11|inst8|add_15_rtl_477~31_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst11|inst8|add_15_rtl_477~31\ = \inst9|inst1|I1|i~15\ & \inst9|inst11|inst8|add_15~7\ # !\inst9|inst1|I1|i~15\ & \inst9|inst11|inst8|add_17_rtl_16~7\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F3C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I1|i~15\,
	datac => \inst9|inst11|inst8|add_15~7\,
	datad => \inst9|inst11|inst8|add_17_rtl_16~7\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst11|inst8|add_15_rtl_477~31\);

\inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][0]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|stack:inst11|lpm_ram_dq0:inst|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "none",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 0,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \rtl~1836\,
	clk0 => \clk~combout\,
	we => \inst9|inst1|I1|i~15\,
	waddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][0]_waddr\,
	raddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][0]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][0]_modesel\,
	dataout => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[0]\);

\inst9|inst1|I1|iaddr_x[0]~297_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[0]~297\ = \inst9|inst1|I2|pc_mux_x[2]~444\ & \inst9|inst11|inst|lpm_ram_dq_component|sram|q[0]\ & \inst9|inst1|I2|pc_mux_x[1]~53\ & \inst9|inst1|I2|pc_mux_x[0]~33\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[0]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[0]~297\);

\inst9|inst1|I1|iaddr_x[0]~296_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[0]~296\ = \inst9|inst1|I1|iaddr_x[0]~297\ # !\inst9|inst1|I2|pc_mux_x[2]~444\ & (\inst9|inst1|I1|iaddr_x[0]~292\ # \inst9|inst1|I1|iaddr_x[0]~293\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF54",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datab => \inst9|inst1|I1|iaddr_x[0]~292\,
	datac => \inst9|inst1|I1|iaddr_x[0]~293\,
	datad => \inst9|inst1|I1|iaddr_x[0]~297\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[0]~296\);

\inst9|inst1|I1|pc[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|pc[0]\ = DFFE(\inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I1|iaddr_x[0]~296\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I1|iaddr_x[0]~296\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I1|pc[0]\);

\inst9|inst1|I1|add_25~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|add_25~1\ = \inst9|inst1|I1|pc[1]\ $ \inst9|inst1|I1|add_25~0COUT\
-- \inst9|inst1|I1|add_25~1COUT\ = CARRY(!\inst9|inst1|I1|add_25~0COUT\ # !\inst9|inst1|I1|pc[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3C3F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I1|pc[1]\,
	cin => \inst9|inst1|I1|add_25~0COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|add_25~1\,
	cout => \inst9|inst1|I1|add_25~1COUT\);

\inst9|inst1|I1|iaddr_x[1]~322_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[1]~322\ = !\inst9|inst1|I2|pc_mux_x[1]~53\ & (\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|add_25~1\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|pc[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2230",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~1\,
	datab => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datac => \inst9|inst1|I1|pc[1]\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[1]~322\);

\rtl~793\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~314\ = \inst9|inst1|I1|Mux_59~9\ & (\inst9|inst1|I2|pc_mux_x[0]~33\ & \rtl~314\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst15|lpm_ram_dq_component|sram|q[5]\) # !\inst9|inst1|I1|Mux_59~9\ & \rtl~314\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCAC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst15|lpm_ram_dq_component|sram|q[5]\,
	datab => \rtl~314\,
	datac => \inst9|inst1|I1|Mux_59~9\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~314\);

\inst9|inst1|I1|Mux_48_rtl_62_rtl_297~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_48_rtl_62_rtl_297~0\ = \inst9|inst1|I2|pc_mux_x[1]~53\ & (\inst9|inst1|I2|pc_mux_x[0]~33\ # \rtl~314\) # !\inst9|inst1|I2|pc_mux_x[1]~53\ & \inst9|inst1|I1|add_25~1\ & !\inst9|inst1|I2|pc_mux_x[0]~33\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F2C2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~1\,
	datab => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \rtl~314\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_48_rtl_62_rtl_297~0\);

\inst9|inst1|I1|Mux_48_rtl_62_rtl_297~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_48_rtl_62_rtl_297~1\ = \inst9|inst1|I1|Mux_48_rtl_62_rtl_297~0\ & (\inst9|inst11|inst|lpm_ram_dq_component|sram|q[1]\ # !\inst9|inst1|I2|pc_mux_x[0]~33\) # !\inst9|inst1|I1|Mux_48_rtl_62_rtl_297~0\ & \inst9|inst1|I1|pc[1]\ & \inst9|inst1|I2|pc_mux_x[0]~33\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CFA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|pc[1]\,
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[1]\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datad => \inst9|inst1|I1|Mux_48_rtl_62_rtl_297~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_48_rtl_62_rtl_297~1\);

\rtl~1464_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1464\ = \inst9|inst1|I1|add_25~1\ & \inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I2|pc_mux_x[1]~53\ & \rtl~10683\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~1\,
	datab => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \rtl~10683\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1464\);

\rtl~1847_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1847\ = \inst9|inst11|inst|lpm_ram_dq_component|sram|q[1]\ & (!\inst9|inst1|I2|pc_mux_x[2]~444\ & !\inst9|inst1|I1|Mux_37_rtl_186~0\ # !\inst9|inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "444C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|i~2\,
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[1]\,
	datac => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datad => \inst9|inst1|I1|Mux_37_rtl_186~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1847\);

\rtl~1846_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1846\ = \rtl~1464\ # \rtl~1847\ # \inst9|inst1|I1|Mux_59~8\ & \inst9|inst1|I1|Mux_48_rtl_62_rtl_297~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|Mux_59~8\,
	datab => \inst9|inst1|I1|Mux_48_rtl_62_rtl_297~1\,
	datac => \rtl~1464\,
	datad => \rtl~1847\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1846\);

\inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][1]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|stack:inst11|lpm_ram_dq0:inst|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "none",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 1,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \rtl~1846\,
	clk0 => \clk~combout\,
	we => \inst9|inst1|I1|i~15\,
	waddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][1]_waddr\,
	raddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][1]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][1]_modesel\,
	dataout => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[1]\);

\inst9|inst1|I1|iaddr_x[1]~326_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[1]~326\ = \inst9|inst1|I2|pc_mux_x[2]~444\ & \inst9|inst11|inst|lpm_ram_dq_component|sram|q[1]\ & \inst9|inst1|I2|pc_mux_x[1]~53\ & \inst9|inst1|I2|pc_mux_x[0]~33\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[1]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[1]~326\);

\inst9|inst1|I1|iaddr_x[1]~325_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[1]~325\ = \inst9|inst1|I1|iaddr_x[1]~326\ # !\inst9|inst1|I2|pc_mux_x[2]~444\ & (\inst9|inst1|I1|iaddr_x[1]~321\ # \inst9|inst1|I1|iaddr_x[1]~322\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF54",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datab => \inst9|inst1|I1|iaddr_x[1]~321\,
	datac => \inst9|inst1|I1|iaddr_x[1]~322\,
	datad => \inst9|inst1|I1|iaddr_x[1]~326\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[1]~325\);

\inst9|inst1|I1|pc[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|pc[1]\ = DFFE(\inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I1|iaddr_x[1]~325\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I1|iaddr_x[1]~325\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I1|pc[1]\);

\inst9|inst1|I1|add_25~2_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|add_25~2\ = \inst9|inst1|I1|pc[2]\ $ !\inst9|inst1|I1|add_25~1COUT\
-- \inst9|inst1|I1|add_25~2COUT\ = CARRY(\inst9|inst1|I1|pc[2]\ & !\inst9|inst1|I1|add_25~1COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "C30C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I1|pc[2]\,
	cin => \inst9|inst1|I1|add_25~1COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|add_25~2\,
	cout => \inst9|inst1|I1|add_25~2COUT\);

\inst9|inst1|I1|iaddr_x[2]~351_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[2]~351\ = !\inst9|inst1|I2|pc_mux_x[1]~53\ & (\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|add_25~2\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|pc[2]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0C0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|pc[2]\,
	datab => \inst9|inst1|I1|add_25~2\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[2]~351\);

\rtl~1473_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1473\ = \inst9|inst1|I2|pc_mux_x[1]~53\ & \inst9|inst1|I1|add_25~2\ & \rtl~10683\ & \inst9|inst1|I2|pc_mux_x[0]~33\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datab => \inst9|inst1|I1|add_25~2\,
	datac => \rtl~10683\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1473\);

\rtl~1857_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1857\ = \inst9|inst11|inst|lpm_ram_dq_component|sram|q[2]\ & (!\inst9|inst1|I2|pc_mux_x[2]~444\ & !\inst9|inst1|I1|Mux_37_rtl_186~0\ # !\inst9|inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0A2A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[2]\,
	datab => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datac => \inst9|inst1|I1|i~2\,
	datad => \inst9|inst1|I1|Mux_37_rtl_186~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1857\);

\inst9|inst1|I1|Mux_47_rtl_65_rtl_300~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_47_rtl_65_rtl_300~0\ = \inst9|inst1|I2|pc_mux_x[0]~33\ & (\inst9|inst1|I1|pc[2]\ # \inst9|inst1|I2|pc_mux_x[1]~53\) # !\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|add_25~2\ & !\inst9|inst1|I2|pc_mux_x[1]~53\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FA0C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|pc[2]\,
	datab => \inst9|inst1|I1|add_25~2\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_47_rtl_65_rtl_300~0\);

\rtl~796\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~315\ = \inst9|inst1|I2|pc_mux_x[0]~33\ & \rtl~315\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & (\inst9|inst1|I1|Mux_59~9\ & \inst9|inst15|lpm_ram_dq_component|sram|q[6]\ # !\inst9|inst1|I1|Mux_59~9\ & \rtl~315\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ACAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~315\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[6]\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datad => \inst9|inst1|I1|Mux_59~9\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~315\);

\inst9|inst1|I1|Mux_47_rtl_65_rtl_300~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_47_rtl_65_rtl_300~1\ = \inst9|inst1|I1|Mux_47_rtl_65_rtl_300~0\ & (\inst9|inst11|inst|lpm_ram_dq_component|sram|q[2]\ # !\inst9|inst1|I2|pc_mux_x[1]~53\) # !\inst9|inst1|I1|Mux_47_rtl_65_rtl_300~0\ & \inst9|inst1|I2|pc_mux_x[1]~53\ & \rtl~315\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DAD0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[2]\,
	datac => \inst9|inst1|I1|Mux_47_rtl_65_rtl_300~0\,
	datad => \rtl~315\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_47_rtl_65_rtl_300~1\);

\rtl~1856_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1856\ = \rtl~1473\ # \rtl~1857\ # \inst9|inst1|I1|Mux_59~8\ & \inst9|inst1|I1|Mux_47_rtl_65_rtl_300~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FEFC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|Mux_59~8\,
	datab => \rtl~1473\,
	datac => \rtl~1857\,
	datad => \inst9|inst1|I1|Mux_47_rtl_65_rtl_300~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1856\);

\inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][2]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|stack:inst11|lpm_ram_dq0:inst|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "none",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 2,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \rtl~1856\,
	clk0 => \clk~combout\,
	we => \inst9|inst1|I1|i~15\,
	waddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][2]_waddr\,
	raddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][2]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][2]_modesel\,
	dataout => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[2]\);

\inst9|inst1|I1|iaddr_x[2]~355_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[2]~355\ = \inst9|inst1|I2|pc_mux_x[2]~444\ & \inst9|inst11|inst|lpm_ram_dq_component|sram|q[2]\ & \inst9|inst1|I2|pc_mux_x[1]~53\ & \inst9|inst1|I2|pc_mux_x[0]~33\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[2]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[2]~355\);

\inst9|inst1|I1|iaddr_x[2]~354_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[2]~354\ = \inst9|inst1|I1|iaddr_x[2]~355\ # !\inst9|inst1|I2|pc_mux_x[2]~444\ & (\inst9|inst1|I1|iaddr_x[2]~350\ # \inst9|inst1|I1|iaddr_x[2]~351\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF54",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datab => \inst9|inst1|I1|iaddr_x[2]~350\,
	datac => \inst9|inst1|I1|iaddr_x[2]~351\,
	datad => \inst9|inst1|I1|iaddr_x[2]~355\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[2]~354\);

\inst9|inst1|I1|pc[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|pc[2]\ = DFFE(\inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I1|iaddr_x[2]~354\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I1|iaddr_x[2]~354\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I1|pc[2]\);

\inst9|inst1|I1|add_25~3_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|add_25~3\ = \inst9|inst1|I1|pc[3]\ $ \inst9|inst1|I1|add_25~2COUT\
-- \inst9|inst1|I1|add_25~3COUT\ = CARRY(!\inst9|inst1|I1|add_25~2COUT\ # !\inst9|inst1|I1|pc[3]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3C3F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I1|pc[3]\,
	cin => \inst9|inst1|I1|add_25~2COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|add_25~3\,
	cout => \inst9|inst1|I1|add_25~3COUT\);

\inst9|inst1|I1|iaddr_x[3]~387_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[3]~387\ = !\inst9|inst1|I2|pc_mux_x[1]~53\ & (\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|add_25~3\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|pc[3]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0A0C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~3\,
	datab => \inst9|inst1|I1|pc[3]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[3]~387\);

\rtl~1867_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1867\ = \inst9|inst11|inst|lpm_ram_dq_component|sram|q[3]\ & (!\inst9|inst1|I2|pc_mux_x[2]~444\ & !\inst9|inst1|I1|Mux_37_rtl_186~0\ # !\inst9|inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "222A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[3]\,
	datab => \inst9|inst1|I1|i~2\,
	datac => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datad => \inst9|inst1|I1|Mux_37_rtl_186~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1867\);

\rtl~1482_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1482\ = \inst9|inst1|I1|add_25~3\ & \inst9|inst1|I2|pc_mux_x[1]~53\ & \inst9|inst1|I2|pc_mux_x[0]~33\ & \rtl~10683\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~3\,
	datab => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datad => \rtl~10683\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1482\);

\rtl~799\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~316\ = \inst9|inst1|I2|pc_mux_x[0]~33\ & \rtl~316\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & (\inst9|inst1|I1|Mux_59~9\ & \inst9|inst15|lpm_ram_dq_component|sram|q[7]\ # !\inst9|inst1|I1|Mux_59~9\ & \rtl~316\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CACC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst15|lpm_ram_dq_component|sram|q[7]\,
	datab => \rtl~316\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datad => \inst9|inst1|I1|Mux_59~9\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~316\);

\inst9|inst1|I1|Mux_46_rtl_68_rtl_303~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_46_rtl_68_rtl_303~0\ = \inst9|inst1|I2|pc_mux_x[1]~53\ & (\inst9|inst1|I2|pc_mux_x[0]~33\ # \rtl~316\) # !\inst9|inst1|I2|pc_mux_x[1]~53\ & \inst9|inst1|I1|add_25~3\ & !\inst9|inst1|I2|pc_mux_x[0]~33\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CEC2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~3\,
	datab => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datad => \rtl~316\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_46_rtl_68_rtl_303~0\);

\inst9|inst1|I1|Mux_46_rtl_68_rtl_303~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_46_rtl_68_rtl_303~1\ = \inst9|inst1|I1|Mux_46_rtl_68_rtl_303~0\ & (\inst9|inst11|inst|lpm_ram_dq_component|sram|q[3]\ # !\inst9|inst1|I2|pc_mux_x[0]~33\) # !\inst9|inst1|I1|Mux_46_rtl_68_rtl_303~0\ & \inst9|inst1|I1|pc[3]\ & \inst9|inst1|I2|pc_mux_x[0]~33\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AFC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[3]\,
	datab => \inst9|inst1|I1|pc[3]\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datad => \inst9|inst1|I1|Mux_46_rtl_68_rtl_303~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_46_rtl_68_rtl_303~1\);

\rtl~1866_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1866\ = \rtl~1867\ # \rtl~1482\ # \inst9|inst1|I1|Mux_59~8\ & \inst9|inst1|I1|Mux_46_rtl_68_rtl_303~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FEFC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|Mux_59~8\,
	datab => \rtl~1867\,
	datac => \rtl~1482\,
	datad => \inst9|inst1|I1|Mux_46_rtl_68_rtl_303~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1866\);

\inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][3]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|stack:inst11|lpm_ram_dq0:inst|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "none",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 3,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \rtl~1866\,
	clk0 => \clk~combout\,
	we => \inst9|inst1|I1|i~15\,
	waddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][3]_waddr\,
	raddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][3]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][3]_modesel\,
	dataout => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[3]\);

\inst9|inst1|I1|iaddr_x[3]~380_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[3]~380\ = \inst9|inst11|inst|lpm_ram_dq_component|sram|q[3]\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ # !\inst9|inst1|I2|pc_mux_x[1]~53\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CFFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[3]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[3]~380\);

\inst9|inst1|I1|iaddr_x[3]~390_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[3]~390\ = \inst9|inst1|I2|pc_mux_x[2]~444\ & \inst9|inst1|I1|iaddr_x[3]~380\ # !\inst9|inst1|I2|pc_mux_x[2]~444\ & (\inst9|inst1|I1|iaddr_x[3]~386\ # \inst9|inst1|I1|iaddr_x[3]~387\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FE54",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datab => \inst9|inst1|I1|iaddr_x[3]~386\,
	datac => \inst9|inst1|I1|iaddr_x[3]~387\,
	datad => \inst9|inst1|I1|iaddr_x[3]~380\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[3]~390\);

\inst9|inst1|I1|pc[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|pc[3]\ = DFFE(\inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I1|iaddr_x[3]~390\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I1|iaddr_x[3]~390\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I1|pc[3]\);

\inst9|inst1|I1|add_25~4_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|add_25~4\ = \inst9|inst1|I1|pc[4]\ $ !\inst9|inst1|I1|add_25~3COUT\
-- \inst9|inst1|I1|add_25~4COUT\ = CARRY(\inst9|inst1|I1|pc[4]\ & !\inst9|inst1|I1|add_25~3COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "C30C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I1|pc[4]\,
	cin => \inst9|inst1|I1|add_25~3COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|add_25~4\,
	cout => \inst9|inst1|I1|add_25~4COUT\);

\inst9|inst1|I1|add_25~5_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|add_25~5\ = \inst9|inst1|I1|pc[5]\ $ \inst9|inst1|I1|add_25~4COUT\
-- \inst9|inst1|I1|add_25~5COUT\ = CARRY(!\inst9|inst1|I1|add_25~4COUT\ # !\inst9|inst1|I1|pc[5]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3C3F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I1|pc[5]\,
	cin => \inst9|inst1|I1|add_25~4COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|add_25~5\,
	cout => \inst9|inst1|I1|add_25~5COUT\);

\inst9|inst1|I1|iaddr_x[5]~531_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[5]~531\ = !\inst9|inst1|I2|pc_mux_x[1]~53\ & (\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|add_25~5\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|pc[5]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2230",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~5\,
	datab => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datac => \inst9|inst1|I1|pc[5]\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[5]~531\);

\inst9|inst1|I1|iaddr_x[5]~530_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[5]~530\ = \inst9|inst1|I2|pc_mux_x[1]~422\ & \inst9|inst15|lpm_ram_dq_component|sram|q[9]\ & (\inst9|inst1|I2|pc_mux_x[1]~48\ # \inst9|inst1|I2|pc_mux_x[1]~408\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8880",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~422\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[9]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~48\,
	datad => \inst9|inst1|I2|pc_mux_x[1]~408\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[5]~530\);

\rtl~1500_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1500\ = \inst9|inst1|I1|add_25~5\ & \inst9|inst1|I2|pc_mux_x[1]~53\ & \inst9|inst1|I2|pc_mux_x[0]~33\ & \rtl~10683\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~5\,
	datab => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datad => \rtl~10683\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1500\);

\rtl~1887_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1887\ = \inst9|inst11|inst|lpm_ram_dq_component|sram|q[5]\ & (!\inst9|inst1|I2|pc_mux_x[2]~444\ & !\inst9|inst1|I1|Mux_37_rtl_186~0\ # !\inst9|inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "444C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|i~2\,
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[5]\,
	datac => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datad => \inst9|inst1|I1|Mux_37_rtl_186~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1887\);

\rtl~805\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~318\ = \inst9|inst1|I2|pc_mux_x[0]~33\ & \rtl~318\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & (\inst9|inst1|I1|Mux_59~9\ & \inst9|inst15|lpm_ram_dq_component|sram|q[9]\ # !\inst9|inst1|I1|Mux_59~9\ & \rtl~318\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CACC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst15|lpm_ram_dq_component|sram|q[9]\,
	datab => \rtl~318\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datad => \inst9|inst1|I1|Mux_59~9\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~318\);

\inst9|inst1|I1|Mux_44_rtl_74_rtl_309~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_44_rtl_74_rtl_309~0\ = \inst9|inst1|I2|pc_mux_x[1]~53\ & (\inst9|inst1|I2|pc_mux_x[0]~33\ # \rtl~318\) # !\inst9|inst1|I2|pc_mux_x[1]~53\ & \inst9|inst1|I1|add_25~5\ & !\inst9|inst1|I2|pc_mux_x[0]~33\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CEC2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~5\,
	datab => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datad => \rtl~318\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_44_rtl_74_rtl_309~0\);

\inst9|inst1|I1|Mux_44_rtl_74_rtl_309~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_44_rtl_74_rtl_309~1\ = \inst9|inst1|I1|Mux_44_rtl_74_rtl_309~0\ & (\inst9|inst11|inst|lpm_ram_dq_component|sram|q[5]\ # !\inst9|inst1|I2|pc_mux_x[0]~33\) # !\inst9|inst1|I1|Mux_44_rtl_74_rtl_309~0\ & \inst9|inst1|I1|pc[5]\ & \inst9|inst1|I2|pc_mux_x[0]~33\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AFC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[5]\,
	datab => \inst9|inst1|I1|pc[5]\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datad => \inst9|inst1|I1|Mux_44_rtl_74_rtl_309~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_44_rtl_74_rtl_309~1\);

\rtl~1886_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1886\ = \rtl~1500\ # \rtl~1887\ # \inst9|inst1|I1|Mux_59~8\ & \inst9|inst1|I1|Mux_44_rtl_74_rtl_309~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FEFC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|Mux_59~8\,
	datab => \rtl~1500\,
	datac => \rtl~1887\,
	datad => \inst9|inst1|I1|Mux_44_rtl_74_rtl_309~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1886\);

\inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][5]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|stack:inst11|lpm_ram_dq0:inst|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "none",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 5,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \rtl~1886\,
	clk0 => \clk~combout\,
	we => \inst9|inst1|I1|i~15\,
	waddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][5]_waddr\,
	raddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][5]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][5]_modesel\,
	dataout => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[5]\);

\inst9|inst1|I1|iaddr_x[5]~524_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[5]~524\ = \inst9|inst11|inst|lpm_ram_dq_component|sram|q[5]\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ # !\inst9|inst1|I2|pc_mux_x[1]~53\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CFFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[5]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[5]~524\);

\inst9|inst1|I1|iaddr_x[5]~534_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[5]~534\ = \inst9|inst1|I2|pc_mux_x[2]~444\ & \inst9|inst1|I1|iaddr_x[5]~524\ # !\inst9|inst1|I2|pc_mux_x[2]~444\ & (\inst9|inst1|I1|iaddr_x[5]~531\ # \inst9|inst1|I1|iaddr_x[5]~530\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FE54",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datab => \inst9|inst1|I1|iaddr_x[5]~531\,
	datac => \inst9|inst1|I1|iaddr_x[5]~530\,
	datad => \inst9|inst1|I1|iaddr_x[5]~524\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[5]~534\);

\inst9|inst4|i~93_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~93\ = \inst9|inst4|i~444\ # \inst9|inst1|I1|i~2\ & \inst9|inst4|i~379\ & \inst9|inst1|I1|iaddr_x[5]~534\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F8F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|i~2\,
	datab => \inst9|inst4|i~379\,
	datac => \inst9|inst4|i~444\,
	datad => \inst9|inst1|I1|iaddr_x[5]~534\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~93\);

\inst9|inst1|I2|idata_x[11]~49_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[11]~49\ = \inst9|inst1|I2|i~509\ & (\inst9|inst1|I2|i~2\ & \inst9|inst1|I2|data_is_c[7]\ # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[11]\) # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[11]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~509\,
	datab => \inst9|inst1|I2|data_is_c[7]\,
	datac => \inst9|inst1|I2|i~2\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[11]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[11]~49\);

\inst9|inst1|I4|iinc_x[7]~14_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_x[7]~14\ = \inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I3|acc_c[0][7]\ # !\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I4|iinc_c[7]\ & \inst9|inst1|I4|i~18\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "D888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|iinc_we_c\,
	datab => \inst9|inst1|I3|acc_c[0][7]\,
	datac => \inst9|inst1|I4|iinc_c[7]\,
	datad => \inst9|inst1|I4|i~18\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|iinc_x[7]~14\);

\inst9|inst1|I4|iinc_i[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_i[7]\ = DFFE(\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I3|acc_c[0][7]\ # !\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|iinc_c[7]\, GLOBAL(\clk~combout\), , , \inst9|inst1|I4|ireg_i[4]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EA40",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|iinc_we_c\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I4|iinc_c[7]\,
	datad => \inst9|inst1|I3|acc_c[0][7]\,
	clk => \clk~combout\,
	ena => \inst9|inst1|I4|ireg_i[4]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|iinc_i[7]\);

\inst9|inst1|I4|iinc_c[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_c[7]\ = DFFE(\inst9|inst1|I4|iinc_x[7]~14\ & (\inst9|inst1|I4|iinc_i[7]\ # !\inst9|inst1|I2|int_stop_x~11\) # !\inst9|inst1|I4|iinc_x[7]~14\ & \inst9|inst1|I2|int_stop_x~11\ & \inst9|inst1|I4|iinc_i[7]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FC0C",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|iinc_x[7]~14\,
	datac => \inst9|inst1|I2|int_stop_x~11\,
	datad => \inst9|inst1|I4|iinc_i[7]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|iinc_c[7]\);

\inst9|inst1|I4|iinc_i[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_i[6]\ = DFFE(\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I3|acc_c[0][6]\ # !\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I4|iinc_c[6]\ & \inst9|inst1|I4|i~18\, GLOBAL(\clk~combout\), , , \inst9|inst1|I4|ireg_i[4]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EA40",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|iinc_we_c\,
	datab => \inst9|inst1|I4|iinc_c[6]\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I3|acc_c[0][6]\,
	clk => \clk~combout\,
	ena => \inst9|inst1|I4|ireg_i[4]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|iinc_i[6]\);

\inst9|inst1|I4|iinc_x[6]~17_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_x[6]~17\ = \inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I3|acc_c[0][6]\ # !\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I4|iinc_c[6]\ & \inst9|inst1|I4|i~18\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EA40",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|iinc_we_c\,
	datab => \inst9|inst1|I4|iinc_c[6]\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I3|acc_c[0][6]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|iinc_x[6]~17\);

\inst9|inst1|I4|iinc_c[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_c[6]\ = DFFE(\inst9|inst1|I4|iinc_i[6]\ & (\inst9|inst1|I4|iinc_x[6]~17\ # \inst9|inst1|I2|int_stop_x~11\) # !\inst9|inst1|I4|iinc_i[6]\ & \inst9|inst1|I4|iinc_x[6]~17\ & !\inst9|inst1|I2|int_stop_x~11\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|iinc_i[6]\,
	datac => \inst9|inst1|I4|iinc_x[6]~17\,
	datad => \inst9|inst1|I2|int_stop_x~11\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|iinc_c[6]\);

\inst9|inst1|I4|add_104~6_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104~6\ = \inst9|inst1|I4|ireg_c[6]\ $ \inst9|inst1|I4|iinc_c[6]\ $ !\inst9|inst1|I4|add_104~5COUT\
-- \inst9|inst1|I4|add_104~6COUT\ = CARRY(\inst9|inst1|I4|ireg_c[6]\ & (\inst9|inst1|I4|iinc_c[6]\ # !\inst9|inst1|I4|add_104~5COUT\) # !\inst9|inst1|I4|ireg_c[6]\ & \inst9|inst1|I4|iinc_c[6]\ & !\inst9|inst1|I4|add_104~5COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "698E",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[6]\,
	datab => \inst9|inst1|I4|iinc_c[6]\,
	cin => \inst9|inst1|I4|add_104~5COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104~6\,
	cout => \inst9|inst1|I4|add_104~6COUT\);

\inst9|inst1|I4|add_104_rtl_475~98_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104_rtl_475~98\ = \inst9|inst1|I4|reduce_nor_103\ & \inst9|inst1|I4|ireg_c[6]\ # !\inst9|inst1|I4|reduce_nor_103\ & (\inst9|inst1|I4|i~815\ & \inst9|inst1|I4|add_104~6\ # !\inst9|inst1|I4|i~815\ & \inst9|inst1|I4|ireg_c[6]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CACC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|add_104~6\,
	datab => \inst9|inst1|I4|ireg_c[6]\,
	datac => \inst9|inst1|I4|reduce_nor_103\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104_rtl_475~98\);

\inst9|inst1|I4|ireg_i[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_i[6]\ = DFFE(\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I3|acc_c[0][6]\ # !\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|add_104_rtl_475~98\, GLOBAL(\clk~combout\), , , \inst9|inst1|I4|ireg_i[4]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "D888",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_we_c\,
	datab => \inst9|inst1|I3|acc_c[0][6]\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I4|add_104_rtl_475~98\,
	clk => \clk~combout\,
	ena => \inst9|inst1|I4|ireg_i[4]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|ireg_i[6]\);

\inst9|inst1|I4|add_104_rtl_475~103_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104_rtl_475~103\ = \inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I3|acc_c[0][6]\ # !\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|add_104_rtl_475~98\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "D888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_we_c\,
	datab => \inst9|inst1|I3|acc_c[0][6]\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I4|add_104_rtl_475~98\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104_rtl_475~103\);

\inst9|inst1|I4|ireg_c[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_c[6]\ = DFFE(\inst9|inst1|I2|int_stop_x~11\ & \inst9|inst1|I4|ireg_i[6]\ # !\inst9|inst1|I2|int_stop_x~11\ & \inst9|inst1|I4|add_104_rtl_475~103\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F3C0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|int_stop_x~11\,
	datac => \inst9|inst1|I4|ireg_i[6]\,
	datad => \inst9|inst1|I4|add_104_rtl_475~103\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|ireg_c[6]\);

\inst9|inst1|I4|add_104~7_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104~7\ = \inst9|inst1|I4|ireg_c[7]\ $ \inst9|inst1|I4|add_104~6COUT\ $ \inst9|inst1|I4|iinc_c[7]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "C33C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|ireg_c[7]\,
	datad => \inst9|inst1|I4|iinc_c[7]\,
	cin => \inst9|inst1|I4|add_104~6COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104~7\);

\inst9|inst1|I4|add_104_rtl_475~608_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104_rtl_475~608\ = !\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4040",
	output_mode => "none")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_we_c\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	cascout => \inst9|inst1|I4|add_104_rtl_475~608\);

\inst9|inst1|I4|add_104_rtl_475~627_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104_rtl_475~627\ = (\inst9|inst1|I4|i~815\ & (\inst9|inst1|I4|reduce_nor_103\ & \inst9|inst1|I4|ireg_c[7]\ # !\inst9|inst1|I4|reduce_nor_103\ & \inst9|inst1|I4|add_104~7\) # !\inst9|inst1|I4|i~815\ & \inst9|inst1|I4|ireg_c[7]\) & CASCADE(\inst9|inst1|I4|add_104_rtl_475~608\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAE2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[7]\,
	datab => \inst9|inst1|I4|i~815\,
	datac => \inst9|inst1|I4|add_104~7\,
	datad => \inst9|inst1|I4|reduce_nor_103\,
	cascin => \inst9|inst1|I4|add_104_rtl_475~608\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104_rtl_475~627\);

\inst9|inst1|I4|ireg_i[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_i[7]\ = DFFE(\inst9|inst1|I4|add_104_rtl_475~627\ # \inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I3|acc_c[0][7]\, GLOBAL(\clk~combout\), , , \inst9|inst1|I4|ireg_i[4]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFC0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|ireg_we_c\,
	datac => \inst9|inst1|I3|acc_c[0][7]\,
	datad => \inst9|inst1|I4|add_104_rtl_475~627\,
	clk => \clk~combout\,
	ena => \inst9|inst1|I4|ireg_i[4]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|ireg_i[7]\);

\inst9|inst1|I4|add_104_rtl_475~30_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104_rtl_475~30\ = \inst9|inst1|I3|acc_c[0][7]\ & \inst9|inst1|I4|ireg_we_c\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CC00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I3|acc_c[0][7]\,
	datad => \inst9|inst1|I4|ireg_we_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104_rtl_475~30\);

\inst9|inst1|I4|ireg_c[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_c[7]\ = DFFE(\inst9|inst1|I2|int_stop_x~11\ & \inst9|inst1|I4|ireg_i[7]\ # !\inst9|inst1|I2|int_stop_x~11\ & (\inst9|inst1|I4|add_104_rtl_475~30\ # \inst9|inst1|I4|add_104_rtl_475~627\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DDD8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|int_stop_x~11\,
	datab => \inst9|inst1|I4|ireg_i[7]\,
	datac => \inst9|inst1|I4|add_104_rtl_475~30\,
	datad => \inst9|inst1|I4|add_104_rtl_475~627\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|ireg_c[7]\);

\inst9|inst1|I4|daddr_x[7]~266_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[7]~266\ = (\inst9|inst1|I2|idata_x[11]~49\ # !\inst9|inst1|I4|reduce_nor_103\ & \inst9|inst1|I4|ireg_c[7]\ & \inst9|inst1|I4|i~815\) & CASCADE(\inst9|inst1|I4|i~818\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DCCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|reduce_nor_103\,
	datab => \inst9|inst1|I2|idata_x[11]~49\,
	datac => \inst9|inst1|I4|ireg_c[7]\,
	datad => \inst9|inst1|I4|i~815\,
	cascin => \inst9|inst1|I4|i~818\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[7]~266\);

\inst9|inst4|daddr_c[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|daddr_c[7]\ = DFFE(\inst9|inst12|dwait_c\ & (\inst9|inst4|a2vi_s\ & \inst9|inst4|daddr_c[7]\ # !\inst9|inst4|a2vi_s\ & \inst9|inst1|I4|daddr_x[7]~266\) # !\inst9|inst12|dwait_c\ & \inst9|inst1|I4|daddr_x[7]~266\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|dwait_c\,
	datab => \inst9|inst4|daddr_c[7]\,
	datac => \inst9|inst4|a2vi_s\,
	datad => \inst9|inst1|I4|daddr_x[7]~266\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst4|daddr_c[7]\);

\inst9|inst4|i~458_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~458\ = \inst9|inst1|I4|ndre_x~1\ & !\inst9|inst4|i~382\ & \inst9|inst4|daddr_c[7]\ # !\inst9|inst1|I4|ndre_x~1\ & \inst9|inst1|I4|daddr_x[7]~266\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4F40",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst4|i~382\,
	datab => \inst9|inst4|daddr_c[7]\,
	datac => \inst9|inst1|I4|ndre_x~1\,
	datad => \inst9|inst1|I4|daddr_x[7]~266\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~458\);

\inst9|inst1|I1|pc[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|pc[7]\ = DFFE(\inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I1|iaddr_x[7]~678\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I1|iaddr_x[7]~678\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I1|pc[7]\);

\inst9|inst1|I1|iaddr_x[6]~602_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[6]~602\ = \inst9|inst1|I2|pc_mux_x[1]~422\ & \inst9|inst15|lpm_ram_dq_component|sram|q[10]\ & (\inst9|inst1|I2|pc_mux_x[1]~408\ # \inst9|inst1|I2|pc_mux_x[1]~48\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8880",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~422\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[10]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~408\,
	datad => \inst9|inst1|I2|pc_mux_x[1]~48\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[6]~602\);

\inst9|inst1|I1|add_25~6_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|add_25~6\ = \inst9|inst1|I1|pc[6]\ $ !\inst9|inst1|I1|add_25~5COUT\
-- \inst9|inst1|I1|add_25~6COUT\ = CARRY(\inst9|inst1|I1|pc[6]\ & !\inst9|inst1|I1|add_25~5COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "A50A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|pc[6]\,
	cin => \inst9|inst1|I1|add_25~5COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|add_25~6\,
	cout => \inst9|inst1|I1|add_25~6COUT\);

\inst9|inst1|I1|iaddr_x[6]~603_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[6]~603\ = !\inst9|inst1|I2|pc_mux_x[1]~53\ & (\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|add_25~6\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|pc[6]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0A0C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~6\,
	datab => \inst9|inst1|I1|pc[6]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[6]~603\);

\inst9|inst1|I1|Mux_43_rtl_77_rtl_312~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_43_rtl_77_rtl_312~0\ = \inst9|inst1|I2|pc_mux_x[0]~33\ & (\inst9|inst1|I2|pc_mux_x[1]~53\ # \inst9|inst1|I1|pc[6]\) # !\inst9|inst1|I2|pc_mux_x[0]~33\ & !\inst9|inst1|I2|pc_mux_x[1]~53\ & \inst9|inst1|I1|add_25~6\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EE50",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datab => \inst9|inst1|I1|pc[6]\,
	datac => \inst9|inst1|I1|add_25~6\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_43_rtl_77_rtl_312~0\);

\rtl~808\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~319\ = \inst9|inst1|I2|pc_mux_x[0]~33\ & \rtl~319\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & (\inst9|inst1|I1|Mux_59~9\ & \inst9|inst15|lpm_ram_dq_component|sram|q[10]\ # !\inst9|inst1|I1|Mux_59~9\ & \rtl~319\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "D8CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datab => \rtl~319\,
	datac => \inst9|inst15|lpm_ram_dq_component|sram|q[10]\,
	datad => \inst9|inst1|I1|Mux_59~9\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~319\);

\inst9|inst1|I1|Mux_43_rtl_77_rtl_312~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_43_rtl_77_rtl_312~1\ = \inst9|inst1|I1|Mux_43_rtl_77_rtl_312~0\ & (\inst9|inst11|inst|lpm_ram_dq_component|sram|q[6]\ # !\inst9|inst1|I2|pc_mux_x[1]~53\) # !\inst9|inst1|I1|Mux_43_rtl_77_rtl_312~0\ & \inst9|inst1|I2|pc_mux_x[1]~53\ & \rtl~319\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DAD0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[6]\,
	datac => \inst9|inst1|I1|Mux_43_rtl_77_rtl_312~0\,
	datad => \rtl~319\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_43_rtl_77_rtl_312~1\);

\rtl~1509_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1509\ = \inst9|inst1|I1|add_25~6\ & \inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I2|pc_mux_x[1]~53\ & \rtl~10683\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~6\,
	datab => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \rtl~10683\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1509\);

\rtl~1897_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1897\ = \inst9|inst11|inst|lpm_ram_dq_component|sram|q[6]\ & (!\inst9|inst1|I2|pc_mux_x[2]~444\ & !\inst9|inst1|I1|Mux_37_rtl_186~0\ # !\inst9|inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "444C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|i~2\,
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[6]\,
	datac => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datad => \inst9|inst1|I1|Mux_37_rtl_186~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1897\);

\rtl~1896_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1896\ = \rtl~1509\ # \rtl~1897\ # \inst9|inst1|I1|Mux_43_rtl_77_rtl_312~1\ & \inst9|inst1|I1|Mux_59~8\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|Mux_43_rtl_77_rtl_312~1\,
	datab => \inst9|inst1|I1|Mux_59~8\,
	datac => \rtl~1509\,
	datad => \rtl~1897\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1896\);

\inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][6]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|stack:inst11|lpm_ram_dq0:inst|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "none",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 6,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \rtl~1896\,
	clk0 => \clk~combout\,
	we => \inst9|inst1|I1|i~15\,
	waddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][6]_waddr\,
	raddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][6]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][6]_modesel\,
	dataout => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[6]\);

\inst9|inst1|I1|iaddr_x[6]~596_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[6]~596\ = \inst9|inst11|inst|lpm_ram_dq_component|sram|q[6]\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ # !\inst9|inst1|I2|pc_mux_x[1]~53\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CFFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[6]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[6]~596\);

\inst9|inst1|I1|iaddr_x[6]~606_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[6]~606\ = \inst9|inst1|I2|pc_mux_x[2]~444\ & \inst9|inst1|I1|iaddr_x[6]~596\ # !\inst9|inst1|I2|pc_mux_x[2]~444\ & (\inst9|inst1|I1|iaddr_x[6]~602\ # \inst9|inst1|I1|iaddr_x[6]~603\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FE54",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datab => \inst9|inst1|I1|iaddr_x[6]~602\,
	datac => \inst9|inst1|I1|iaddr_x[6]~603\,
	datad => \inst9|inst1|I1|iaddr_x[6]~596\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[6]~606\);

\inst9|inst1|I1|pc[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|pc[6]\ = DFFE(\inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I1|iaddr_x[6]~606\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I1|iaddr_x[6]~606\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I1|pc[6]\);

\inst9|inst1|I1|add_25~7_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|add_25~7\ = \inst9|inst1|I1|pc[7]\ $ \inst9|inst1|I1|add_25~6COUT\
-- \inst9|inst1|I1|add_25~7COUT\ = CARRY(!\inst9|inst1|I1|add_25~6COUT\ # !\inst9|inst1|I1|pc[7]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5A5F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|pc[7]\,
	cin => \inst9|inst1|I1|add_25~6COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|add_25~7\,
	cout => \inst9|inst1|I1|add_25~7COUT\);

\inst9|inst1|I1|iaddr_x[7]~675_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[7]~675\ = !\inst9|inst1|I2|pc_mux_x[1]~53\ & (\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|add_25~7\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|pc[7]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0C0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|pc[7]\,
	datab => \inst9|inst1|I1|add_25~7\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[7]~675\);

\inst9|inst1|I1|iaddr_x[7]~674_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[7]~674\ = \inst9|inst15|lpm_ram_dq_component|sram|q[11]\ & \inst9|inst1|I2|pc_mux_x[1]~422\ & (\inst9|inst1|I2|pc_mux_x[1]~408\ # \inst9|inst1|I2|pc_mux_x[1]~48\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8880",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst15|lpm_ram_dq_component|sram|q[11]\,
	datab => \inst9|inst1|I2|pc_mux_x[1]~422\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~408\,
	datad => \inst9|inst1|I2|pc_mux_x[1]~48\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[7]~674\);

\rtl~1907_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1907\ = \inst9|inst11|inst|lpm_ram_dq_component|sram|q[7]\ & (!\inst9|inst1|I2|pc_mux_x[2]~444\ & !\inst9|inst1|I1|Mux_37_rtl_186~0\ # !\inst9|inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "444C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|i~2\,
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[7]\,
	datac => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datad => \inst9|inst1|I1|Mux_37_rtl_186~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1907\);

\rtl~1518_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1518\ = \inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|add_25~7\ & \inst9|inst1|I2|pc_mux_x[1]~53\ & \rtl~10683\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datab => \inst9|inst1|I1|add_25~7\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \rtl~10683\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1518\);

\rtl~811\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~320\ = \inst9|inst1|I2|pc_mux_x[0]~33\ & \rtl~320\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & (\inst9|inst1|I1|Mux_59~9\ & \inst9|inst15|lpm_ram_dq_component|sram|q[11]\ # !\inst9|inst1|I1|Mux_59~9\ & \rtl~320\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CACC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst15|lpm_ram_dq_component|sram|q[11]\,
	datab => \rtl~320\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datad => \inst9|inst1|I1|Mux_59~9\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~320\);

\inst9|inst1|I1|Mux_42_rtl_80_rtl_315~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_42_rtl_80_rtl_315~0\ = \inst9|inst1|I2|pc_mux_x[1]~53\ & (\inst9|inst1|I2|pc_mux_x[0]~33\ # \rtl~320\) # !\inst9|inst1|I2|pc_mux_x[1]~53\ & !\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|add_25~7\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F4A4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datab => \inst9|inst1|I1|add_25~7\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \rtl~320\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_42_rtl_80_rtl_315~0\);

\inst9|inst1|I1|Mux_42_rtl_80_rtl_315~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_42_rtl_80_rtl_315~1\ = \inst9|inst1|I1|Mux_42_rtl_80_rtl_315~0\ & (\inst9|inst11|inst|lpm_ram_dq_component|sram|q[7]\ # !\inst9|inst1|I2|pc_mux_x[0]~33\) # !\inst9|inst1|I1|Mux_42_rtl_80_rtl_315~0\ & \inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|pc[7]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DDA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[7]\,
	datac => \inst9|inst1|I1|pc[7]\,
	datad => \inst9|inst1|I1|Mux_42_rtl_80_rtl_315~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_42_rtl_80_rtl_315~1\);

\rtl~1906_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1906\ = \rtl~1907\ # \rtl~1518\ # \inst9|inst1|I1|Mux_59~8\ & \inst9|inst1|I1|Mux_42_rtl_80_rtl_315~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FEFA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~1907\,
	datab => \inst9|inst1|I1|Mux_59~8\,
	datac => \rtl~1518\,
	datad => \inst9|inst1|I1|Mux_42_rtl_80_rtl_315~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1906\);

\inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][7]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|stack:inst11|lpm_ram_dq0:inst|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "none",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 7,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \rtl~1906\,
	clk0 => \clk~combout\,
	we => \inst9|inst1|I1|i~15\,
	waddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][7]_waddr\,
	raddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][7]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][7]_modesel\,
	dataout => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[7]\);

\inst9|inst1|I1|iaddr_x[7]~668_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[7]~668\ = \inst9|inst11|inst|lpm_ram_dq_component|sram|q[7]\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ # !\inst9|inst1|I2|pc_mux_x[1]~53\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CFFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[7]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[7]~668\);

\inst9|inst1|I1|iaddr_x[7]~678_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[7]~678\ = \inst9|inst1|I2|pc_mux_x[2]~444\ & \inst9|inst1|I1|iaddr_x[7]~668\ # !\inst9|inst1|I2|pc_mux_x[2]~444\ & (\inst9|inst1|I1|iaddr_x[7]~675\ # \inst9|inst1|I1|iaddr_x[7]~674\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FE54",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datab => \inst9|inst1|I1|iaddr_x[7]~675\,
	datac => \inst9|inst1|I1|iaddr_x[7]~674\,
	datad => \inst9|inst1|I1|iaddr_x[7]~668\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[7]~678\);

\inst9|inst4|i~105_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~105\ = \inst9|inst4|i~458\ # \inst9|inst1|I1|i~2\ & \inst9|inst4|i~379\ & \inst9|inst1|I1|iaddr_x[7]~678\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F8F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|i~2\,
	datab => \inst9|inst4|i~379\,
	datac => \inst9|inst4|i~458\,
	datad => \inst9|inst1|I1|iaddr_x[7]~678\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~105\);

\inst9|inst1|I2|idata_x[12]~40_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[12]~40\ = \inst9|inst1|I2|i~509\ & (\inst9|inst1|I2|i~2\ & \inst9|inst1|I2|idata_c[12]\ # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[12]\) # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[12]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_c[12]\,
	datab => \inst9|inst1|I2|i~509\,
	datac => \inst9|inst1|I2|i~2\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[12]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[12]~40\);

\inst9|inst4|daddr_c[8]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|daddr_c[8]\ = DFFE(\inst9|inst4|i~48\ & \inst9|inst4|daddr_c[8]\ # !\inst9|inst4|i~48\ & \inst9|inst1|I2|idata_x[12]~40\ & \inst9|inst1|I4|i~18\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CAC0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[12]~40\,
	datab => \inst9|inst4|daddr_c[8]\,
	datac => \inst9|inst4|i~48\,
	datad => \inst9|inst1|I4|i~18\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst4|daddr_c[8]\);

\inst9|inst4|i~468_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~468\ = \inst9|inst1|I4|ndre_x~1\ & !\inst9|inst4|i~382\ & \inst9|inst4|daddr_c[8]\ # !\inst9|inst1|I4|ndre_x~1\ & \inst9|inst4|i~381\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "44F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst4|i~382\,
	datab => \inst9|inst4|daddr_c[8]\,
	datac => \inst9|inst4|i~381\,
	datad => \inst9|inst1|I4|ndre_x~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~468\);

\inst9|inst1|I1|iaddr_x[8]~746_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[8]~746\ = \inst9|inst1|I2|pc_mux_x[1]~422\ & \inst9|inst15|lpm_ram_dq_component|sram|q[12]\ & (\inst9|inst1|I2|pc_mux_x[1]~408\ # \inst9|inst1|I2|pc_mux_x[1]~48\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8880",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~422\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[12]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~408\,
	datad => \inst9|inst1|I2|pc_mux_x[1]~48\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[8]~746\);

\inst9|inst1|I1|pc[8]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|pc[8]\ = DFFE(\inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I1|iaddr_x[8]~750\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I1|nreset_v_rtl_25|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I1|iaddr_x[8]~750\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I1|pc[8]\);

\inst9|inst1|I1|add_25~8_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|add_25~8\ = \inst9|inst1|I1|pc[8]\ $ !\inst9|inst1|I1|add_25~7COUT\
-- \inst9|inst1|I1|add_25~8COUT\ = CARRY(\inst9|inst1|I1|pc[8]\ & !\inst9|inst1|I1|add_25~7COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "C30C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I1|pc[8]\,
	cin => \inst9|inst1|I1|add_25~7COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|add_25~8\,
	cout => \inst9|inst1|I1|add_25~8COUT\);

\rtl~1527_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1527\ = \inst9|inst1|I2|pc_mux_x[1]~53\ & \inst9|inst1|I1|add_25~8\ & \rtl~10683\ & \inst9|inst1|I2|pc_mux_x[0]~33\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datab => \inst9|inst1|I1|add_25~8\,
	datac => \rtl~10683\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1527\);

\inst9|inst1|I1|Mux_41_rtl_83_rtl_318~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_41_rtl_83_rtl_318~0\ = \inst9|inst1|I2|pc_mux_x[0]~33\ & (\inst9|inst1|I1|pc[8]\ # \inst9|inst1|I2|pc_mux_x[1]~53\) # !\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|add_25~8\ & !\inst9|inst1|I2|pc_mux_x[1]~53\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCE2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~8\,
	datab => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datac => \inst9|inst1|I1|pc[8]\,
	datad => \inst9|inst1|I2|pc_mux_x[1]~53\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_41_rtl_83_rtl_318~0\);

\rtl~814\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~321\ = \inst9|inst1|I2|pc_mux_x[0]~33\ & \rtl~321\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & (\inst9|inst1|I1|Mux_59~9\ & \inst9|inst15|lpm_ram_dq_component|sram|q[12]\ # !\inst9|inst1|I1|Mux_59~9\ & \rtl~321\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ACAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~321\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[12]\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datad => \inst9|inst1|I1|Mux_59~9\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~321\);

\inst9|inst1|I1|Mux_41_rtl_83_rtl_318~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_41_rtl_83_rtl_318~1\ = \inst9|inst1|I1|Mux_41_rtl_83_rtl_318~0\ & (\inst9|inst11|inst|lpm_ram_dq_component|sram|q[8]\ # !\inst9|inst1|I2|pc_mux_x[1]~53\) # !\inst9|inst1|I1|Mux_41_rtl_83_rtl_318~0\ & \inst9|inst1|I2|pc_mux_x[1]~53\ & \rtl~321\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BCB0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[8]\,
	datab => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datac => \inst9|inst1|I1|Mux_41_rtl_83_rtl_318~0\,
	datad => \rtl~321\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_41_rtl_83_rtl_318~1\);

\rtl~1917_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1917\ = \inst9|inst11|inst|lpm_ram_dq_component|sram|q[8]\ & (!\inst9|inst1|I2|pc_mux_x[2]~444\ & !\inst9|inst1|I1|Mux_37_rtl_186~0\ # !\inst9|inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "222A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[8]\,
	datab => \inst9|inst1|I1|i~2\,
	datac => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datad => \inst9|inst1|I1|Mux_37_rtl_186~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1917\);

\rtl~1916_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1916\ = \rtl~1527\ # \rtl~1917\ # \inst9|inst1|I1|Mux_59~8\ & \inst9|inst1|I1|Mux_41_rtl_83_rtl_318~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFEC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|Mux_59~8\,
	datab => \rtl~1527\,
	datac => \inst9|inst1|I1|Mux_41_rtl_83_rtl_318~1\,
	datad => \rtl~1917\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1916\);

\inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][8]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|stack:inst11|lpm_ram_dq0:inst|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "none",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 8,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \rtl~1916\,
	clk0 => \clk~combout\,
	we => \inst9|inst1|I1|i~15\,
	waddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][8]_waddr\,
	raddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][8]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][8]_modesel\,
	dataout => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[8]\);

\inst9|inst1|I1|iaddr_x[8]~740_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[8]~740\ = \inst9|inst11|inst|lpm_ram_dq_component|sram|q[8]\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ # !\inst9|inst1|I2|pc_mux_x[1]~53\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F3FF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datac => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[8]\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[8]~740\);

\inst9|inst1|I1|iaddr_x[8]~747_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[8]~747\ = !\inst9|inst1|I2|pc_mux_x[1]~53\ & (\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|add_25~8\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|pc[8]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2230",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~8\,
	datab => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datac => \inst9|inst1|I1|pc[8]\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[8]~747\);

\inst9|inst1|I1|iaddr_x[8]~750_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[8]~750\ = \inst9|inst1|I2|pc_mux_x[2]~444\ & \inst9|inst1|I1|iaddr_x[8]~740\ # !\inst9|inst1|I2|pc_mux_x[2]~444\ & (\inst9|inst1|I1|iaddr_x[8]~746\ # \inst9|inst1|I1|iaddr_x[8]~747\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F5E4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datab => \inst9|inst1|I1|iaddr_x[8]~746\,
	datac => \inst9|inst1|I1|iaddr_x[8]~740\,
	datad => \inst9|inst1|I1|iaddr_x[8]~747\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[8]~750\);

\inst9|inst4|i~111_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~111\ = \inst9|inst4|i~468\ # \inst9|inst1|I1|i~2\ & \inst9|inst4|i~379\ & \inst9|inst1|I1|iaddr_x[8]~750\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ECCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|i~2\,
	datab => \inst9|inst4|i~468\,
	datac => \inst9|inst4|i~379\,
	datad => \inst9|inst1|I1|iaddr_x[8]~750\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~111\);

\rtl~1927_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1927\ = \inst9|inst11|inst|lpm_ram_dq_component|sram|q[9]\ & (!\inst9|inst1|I2|pc_mux_x[2]~444\ & !\inst9|inst1|I1|Mux_37_rtl_186~0\ # !\inst9|inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "222A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[9]\,
	datab => \inst9|inst1|I1|i~2\,
	datac => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datad => \inst9|inst1|I1|Mux_37_rtl_186~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1927\);

\inst9|inst1|I1|pc[9]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|pc[9]\ = DFFE(\inst9|inst1|I1|iaddr_x[9]~2199\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst1|I1|iaddr_x[9]~2199\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I1|pc[9]\);

\inst9|inst1|I1|add_25~9_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|add_25~9\ = \inst9|inst1|I1|pc[9]\ $ \inst9|inst1|I1|add_25~8COUT\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5A5A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|pc[9]\,
	cin => \inst9|inst1|I1|add_25~8COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|add_25~9\);

\rtl~1536_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1536\ = \inst9|inst1|I2|pc_mux_x[1]~53\ & \inst9|inst1|I1|add_25~9\ & \rtl~10683\ & \inst9|inst1|I2|pc_mux_x[0]~33\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datab => \inst9|inst1|I1|add_25~9\,
	datac => \rtl~10683\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1536\);

\inst9|inst15|lpm_ram_dq_component|sram|segment[0][13]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem2 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|lpm_ram_dq1:inst15|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "rom.mif",
	logical_ram_depth => 1024,
	logical_ram_width => 14,
	address_width => 10,
	first_address => 0,
	last_address => 1023,
	bit_number => 13,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \~GND\,
	clk0 => \clk~combout\,
	we => \inst9|inst19|i~50\,
	waddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][13]_waddr\,
	raddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][13]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst15|lpm_ram_dq_component|sram|segment[0][13]_modesel\,
	dataout => \inst9|inst15|lpm_ram_dq_component|sram|q[13]\);

\rtl~817\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~322\ = \inst9|inst1|I2|pc_mux_x[0]~33\ & \rtl~322\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & (\inst9|inst1|I1|Mux_59~9\ & \inst9|inst15|lpm_ram_dq_component|sram|q[13]\ # !\inst9|inst1|I1|Mux_59~9\ & \rtl~322\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CACC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst15|lpm_ram_dq_component|sram|q[13]\,
	datab => \rtl~322\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datad => \inst9|inst1|I1|Mux_59~9\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~322\);

\inst9|inst1|I1|Mux_40_rtl_86_rtl_321~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_40_rtl_86_rtl_321~0\ = \inst9|inst1|I2|pc_mux_x[1]~53\ & (\inst9|inst1|I2|pc_mux_x[0]~33\ # \rtl~322\) # !\inst9|inst1|I2|pc_mux_x[1]~53\ & !\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|add_25~9\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F4A4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datab => \inst9|inst1|I1|add_25~9\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \rtl~322\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_40_rtl_86_rtl_321~0\);

\inst9|inst1|I1|Mux_40_rtl_86_rtl_321~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_40_rtl_86_rtl_321~1\ = \inst9|inst1|I1|Mux_40_rtl_86_rtl_321~0\ & (\inst9|inst11|inst|lpm_ram_dq_component|sram|q[9]\ # !\inst9|inst1|I2|pc_mux_x[0]~33\) # !\inst9|inst1|I1|Mux_40_rtl_86_rtl_321~0\ & \inst9|inst1|I1|pc[9]\ & \inst9|inst1|I2|pc_mux_x[0]~33\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AFC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[9]\,
	datab => \inst9|inst1|I1|pc[9]\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datad => \inst9|inst1|I1|Mux_40_rtl_86_rtl_321~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_40_rtl_86_rtl_321~1\);

\rtl~1926_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1926\ = \rtl~1927\ # \rtl~1536\ # \inst9|inst1|I1|Mux_59~8\ & \inst9|inst1|I1|Mux_40_rtl_86_rtl_321~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FEEE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~1927\,
	datab => \rtl~1536\,
	datac => \inst9|inst1|I1|Mux_59~8\,
	datad => \inst9|inst1|I1|Mux_40_rtl_86_rtl_321~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1926\);

\inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][9]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|stack:inst11|lpm_ram_dq0:inst|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "none",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 9,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \rtl~1926\,
	clk0 => \clk~combout\,
	we => \inst9|inst1|I1|i~15\,
	waddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][9]_waddr\,
	raddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][9]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][9]_modesel\,
	dataout => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[9]\);

\inst9|inst1|I1|iaddr_x[9]~812_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[9]~812\ = \inst9|inst11|inst|lpm_ram_dq_component|sram|q[9]\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ # !\inst9|inst1|I2|pc_mux_x[1]~53\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CFFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[9]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[9]~812\);

\inst9|inst1|I1|iaddr_x[9]~818_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[9]~818\ = \inst9|inst1|I2|pc_mux_x[1]~422\ & \inst9|inst15|lpm_ram_dq_component|sram|q[13]\ & (\inst9|inst1|I2|pc_mux_x[1]~408\ # \inst9|inst1|I2|pc_mux_x[1]~48\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8880",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~422\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[13]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~408\,
	datad => \inst9|inst1|I2|pc_mux_x[1]~48\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[9]~818\);

\inst9|inst1|I1|iaddr_x[9]~819_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[9]~819\ = !\inst9|inst1|I2|pc_mux_x[1]~53\ & (\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|add_25~9\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|pc[9]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0C0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|pc[9]\,
	datab => \inst9|inst1|I1|add_25~9\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[9]~819\);

\inst9|inst1|I1|iaddr_x[9]~2199_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[9]~2199\ = (\inst9|inst1|I2|pc_mux_x[2]~444\ & \inst9|inst1|I1|iaddr_x[9]~812\ # !\inst9|inst1|I2|pc_mux_x[2]~444\ & (\inst9|inst1|I1|iaddr_x[9]~818\ # \inst9|inst1|I1|iaddr_x[9]~819\)) & CASCADE(\inst9|inst1|I1|i~71\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BBB8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|iaddr_x[9]~812\,
	datab => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datac => \inst9|inst1|I1|iaddr_x[9]~818\,
	datad => \inst9|inst1|I1|iaddr_x[9]~819\,
	cascin => \inst9|inst1|I1|i~71\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[9]~2199\);

\inst9|inst4|i~46_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~46\ = \inst9|inst12|dwait_c\ # \inst9|inst4|nadwe_c\ # \inst9|inst1|I1|iaddr_x[9]~2199\ # !\inst9|inst1|I4|ndre_x~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFEF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|dwait_c\,
	datab => \inst9|inst4|nadwe_c\,
	datac => \inst9|inst1|I4|ndre_x~1\,
	datad => \inst9|inst1|I1|iaddr_x[9]~2199\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~46\);

\inst9|inst15|lpm_ram_dq_component|sram|segment[0][10]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem2 => "00000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000010000000000000000000000000010100100000000100000100000100000000100000100000100000100000100001001000000001000000000000000000000000000000000000000001010101010000000000",
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|lpm_ram_dq1:inst15|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "rom.mif",
	logical_ram_depth => 1024,
	logical_ram_width => 14,
	address_width => 10,
	first_address => 0,
	last_address => 1023,
	bit_number => 10,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \~GND\,
	clk0 => \clk~combout\,
	we => \inst9|inst19|i~50\,
	waddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][10]_waddr\,
	raddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][10]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst15|lpm_ram_dq_component|sram|segment[0][10]_modesel\,
	dataout => \inst9|inst15|lpm_ram_dq_component|sram|q[10]\);

\inst9|inst1|I2|data_is_c[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|data_is_c[6]\ = DFFE(\inst9|inst1|I2|i~509\ & (\inst9|inst1|I2|i~2\ & \inst9|inst1|I2|data_is_c[6]\ # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[10]\) # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[10]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~509\,
	datab => \inst9|inst1|I2|data_is_c[6]\,
	datac => \inst9|inst1|I2|i~2\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[10]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|data_is_c[6]\);

\inst9|inst1|I2|idata_x[10]~52_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[10]~52\ = \inst9|inst1|I2|i~509\ & (\inst9|inst1|I2|i~2\ & \inst9|inst1|I2|data_is_c[6]\ # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[10]\) # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[10]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~509\,
	datab => \inst9|inst1|I2|data_is_c[6]\,
	datac => \inst9|inst1|I2|i~2\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[10]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[10]~52\);

\inst9|inst1|I4|daddr_x[6]~77_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[6]~77\ = \inst9|inst1|I2|idata_x[10]~52\ # !\inst9|inst1|I4|reduce_nor_103\ & \inst9|inst1|I4|ireg_c[6]\ & \inst9|inst1|I4|i~815\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BAAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[10]~52\,
	datab => \inst9|inst1|I4|reduce_nor_103\,
	datac => \inst9|inst1|I4|ireg_c[6]\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[6]~77\);

\inst9|inst4|daddr_c[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|daddr_c[6]\ = DFFE(\inst9|inst4|i~48\ & \inst9|inst4|daddr_c[6]\ # !\inst9|inst4|i~48\ & \inst9|inst1|I4|daddr_x[6]~77\ & \inst9|inst1|I4|i~18\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CAC0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|daddr_x[6]~77\,
	datab => \inst9|inst4|daddr_c[6]\,
	datac => \inst9|inst4|i~48\,
	datad => \inst9|inst1|I4|i~18\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst4|daddr_c[6]\);

\inst9|inst1|I4|daddr_x[6]~83_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[6]~83\ = \inst9|inst1|I4|i~18\ & (\inst9|inst1|I2|idata_x[10]~52\ # \inst9|inst1|I4|ireg_c[6]\ & \inst9|inst1|I4|i~760\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C8C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[6]\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I2|idata_x[10]~52\,
	datad => \inst9|inst1|I4|i~760\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[6]~83\);

\inst9|inst4|i~451_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~451\ = \inst9|inst1|I4|ndre_x~1\ & \inst9|inst4|daddr_c[6]\ & !\inst9|inst4|i~382\ # !\inst9|inst1|I4|ndre_x~1\ & \inst9|inst1|I4|daddr_x[6]~83\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5D08",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ndre_x~1\,
	datab => \inst9|inst4|daddr_c[6]\,
	datac => \inst9|inst4|i~382\,
	datad => \inst9|inst1|I4|daddr_x[6]~83\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~451\);

\inst9|inst4|i~99_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~99\ = \inst9|inst4|i~451\ # \inst9|inst1|I1|i~2\ & \inst9|inst4|i~379\ & \inst9|inst1|I1|iaddr_x[6]~606\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F8F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|i~2\,
	datab => \inst9|inst4|i~379\,
	datac => \inst9|inst4|i~451\,
	datad => \inst9|inst1|I1|iaddr_x[6]~606\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~99\);

\inst9|inst15|lpm_ram_dq_component|sram|segment[0][8]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem2 => "00000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101001010000000000001000000011101100011100110000100110011010001000011001001100001100000100000100011001110101110000110100000000000001000000000001110101101101101101111111100000000000000000000000000000010100",
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|lpm_ram_dq1:inst15|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "rom.mif",
	logical_ram_depth => 1024,
	logical_ram_width => 14,
	address_width => 10,
	first_address => 0,
	last_address => 1023,
	bit_number => 8,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \~GND\,
	clk0 => \clk~combout\,
	we => \inst9|inst19|i~50\,
	waddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][8]_waddr\,
	raddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][8]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst15|lpm_ram_dq_component|sram|segment[0][8]_modesel\,
	dataout => \inst9|inst15|lpm_ram_dq_component|sram|q[8]\);

\inst9|inst1|I1|iaddr_x[4]~458_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[4]~458\ = \inst9|inst1|I2|pc_mux_x[1]~422\ & \inst9|inst15|lpm_ram_dq_component|sram|q[8]\ & (\inst9|inst1|I2|pc_mux_x[1]~408\ # \inst9|inst1|I2|pc_mux_x[1]~48\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8880",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~422\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[8]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~408\,
	datad => \inst9|inst1|I2|pc_mux_x[1]~48\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[4]~458\);

\rtl~1491_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1491\ = \inst9|inst1|I2|pc_mux_x[1]~53\ & \inst9|inst1|I1|add_25~4\ & \rtl~10683\ & \inst9|inst1|I2|pc_mux_x[0]~33\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datab => \inst9|inst1|I1|add_25~4\,
	datac => \rtl~10683\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1491\);

\rtl~1877_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1877\ = \inst9|inst11|inst|lpm_ram_dq_component|sram|q[4]\ & (!\inst9|inst1|I2|pc_mux_x[2]~444\ & !\inst9|inst1|I1|Mux_37_rtl_186~0\ # !\inst9|inst1|I1|i~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "444C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|i~2\,
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[4]\,
	datac => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datad => \inst9|inst1|I1|Mux_37_rtl_186~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1877\);

\inst9|inst1|I1|Mux_45_rtl_71_rtl_306~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_45_rtl_71_rtl_306~0\ = \inst9|inst1|I2|pc_mux_x[0]~33\ & (\inst9|inst1|I1|pc[4]\ # \inst9|inst1|I2|pc_mux_x[1]~53\) # !\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|add_25~4\ & !\inst9|inst1|I2|pc_mux_x[1]~53\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FC0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~4\,
	datab => \inst9|inst1|I1|pc[4]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_45_rtl_71_rtl_306~0\);

\rtl~802\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~317\ = \inst9|inst1|I2|pc_mux_x[0]~33\ & \rtl~317\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & (\inst9|inst1|I1|Mux_59~9\ & \inst9|inst15|lpm_ram_dq_component|sram|q[8]\ # !\inst9|inst1|I1|Mux_59~9\ & \rtl~317\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CACC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst15|lpm_ram_dq_component|sram|q[8]\,
	datab => \rtl~317\,
	datac => \inst9|inst1|I2|pc_mux_x[0]~33\,
	datad => \inst9|inst1|I1|Mux_59~9\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~317\);

\inst9|inst1|I1|Mux_45_rtl_71_rtl_306~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|Mux_45_rtl_71_rtl_306~1\ = \inst9|inst1|I1|Mux_45_rtl_71_rtl_306~0\ & (\inst9|inst11|inst|lpm_ram_dq_component|sram|q[4]\ # !\inst9|inst1|I2|pc_mux_x[1]~53\) # !\inst9|inst1|I1|Mux_45_rtl_71_rtl_306~0\ & \inst9|inst1|I2|pc_mux_x[1]~53\ & \rtl~317\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DAD0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[4]\,
	datac => \inst9|inst1|I1|Mux_45_rtl_71_rtl_306~0\,
	datad => \rtl~317\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|Mux_45_rtl_71_rtl_306~1\);

\rtl~1876_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1876\ = \rtl~1491\ # \rtl~1877\ # \inst9|inst1|I1|Mux_59~8\ & \inst9|inst1|I1|Mux_45_rtl_71_rtl_306~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FEFC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|Mux_59~8\,
	datab => \rtl~1491\,
	datac => \rtl~1877\,
	datad => \inst9|inst1|I1|Mux_45_rtl_71_rtl_306~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1876\);

\inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][4]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|stack:inst11|lpm_ram_dq0:inst|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "none",
	logical_ram_depth => 256,
	logical_ram_width => 10,
	address_width => 8,
	first_address => 0,
	last_address => 255,
	bit_number => 4,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \rtl~1876\,
	clk0 => \clk~combout\,
	we => \inst9|inst1|I1|i~15\,
	waddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][4]_waddr\,
	raddr => \ww_inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][4]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst11|inst|lpm_ram_dq_component|sram|segment[0][4]_modesel\,
	dataout => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[4]\);

\inst9|inst1|I1|iaddr_x[4]~452_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[4]~452\ = \inst9|inst11|inst|lpm_ram_dq_component|sram|q[4]\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ # !\inst9|inst1|I2|pc_mux_x[1]~53\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CFFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst11|inst|lpm_ram_dq_component|sram|q[4]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[4]~452\);

\inst9|inst1|I1|iaddr_x[4]~459_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[4]~459\ = !\inst9|inst1|I2|pc_mux_x[1]~53\ & (\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|add_25~4\ # !\inst9|inst1|I2|pc_mux_x[0]~33\ & \inst9|inst1|I1|pc[4]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0A0C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|add_25~4\,
	datab => \inst9|inst1|I1|pc[4]\,
	datac => \inst9|inst1|I2|pc_mux_x[1]~53\,
	datad => \inst9|inst1|I2|pc_mux_x[0]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[4]~459\);

\inst9|inst1|I1|iaddr_x[4]~462_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I1|iaddr_x[4]~462\ = \inst9|inst1|I2|pc_mux_x[2]~444\ & \inst9|inst1|I1|iaddr_x[4]~452\ # !\inst9|inst1|I2|pc_mux_x[2]~444\ & (\inst9|inst1|I1|iaddr_x[4]~458\ # \inst9|inst1|I1|iaddr_x[4]~459\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F5E4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|pc_mux_x[2]~444\,
	datab => \inst9|inst1|I1|iaddr_x[4]~458\,
	datac => \inst9|inst1|I1|iaddr_x[4]~452\,
	datad => \inst9|inst1|I1|iaddr_x[4]~459\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I1|iaddr_x[4]~462\);

\inst9|inst1|I2|data_is_c[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|data_is_c[4]\ = DFFE(\inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|data_is_c[4]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[8]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[8]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F780",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~2\,
	datab => \inst9|inst1|I2|i~509\,
	datac => \inst9|inst1|I2|data_is_c[4]\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[8]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|data_is_c[4]\);

\inst9|inst1|I4|daddr_x[4]~32_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[4]~32\ = \inst9|inst1|I4|i~18\ & (\inst9|inst1|I2|E_x.dwait_e~0\ & \inst9|inst1|I2|data_is_c[4]\ # !\inst9|inst1|I2|E_x.dwait_e~0\ & \inst9|inst15|lpm_ram_dq_component|sram|q[8]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "B080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|data_is_c[4]\,
	datab => \inst9|inst1|I2|E_x.dwait_e~0\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[8]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[4]~32\);

\inst9|inst1|I4|daddr_x[4]~33_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[4]~33\ = \inst9|inst1|I4|ireg_c[4]\ & !\inst9|inst1|I4|reduce_nor_103\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|i~815\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[4]\,
	datab => \inst9|inst1|I4|reduce_nor_103\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[4]~33\);

\inst9|inst4|daddr_c[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|daddr_c[4]\ = DFFE(\inst9|inst4|i~48\ & \inst9|inst4|daddr_c[4]\ # !\inst9|inst4|i~48\ & (\inst9|inst1|I4|daddr_x[4]~32\ # \inst9|inst1|I4|daddr_x[4]~33\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DDD8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst4|i~48\,
	datab => \inst9|inst4|daddr_c[4]\,
	datac => \inst9|inst1|I4|daddr_x[4]~32\,
	datad => \inst9|inst1|I4|daddr_x[4]~33\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst4|daddr_c[4]\);

\inst9|inst1|I2|idata_x[8]~43_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[8]~43\ = \inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|data_is_c[4]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[8]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[8]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ACCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|data_is_c[4]\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[8]\,
	datac => \inst9|inst1|I2|i~2\,
	datad => \inst9|inst1|I2|i~509\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[8]~43\);

\inst9|inst1|I4|daddr_x[4]~20_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[4]~20\ = \inst9|inst1|I4|i~18\ & (\inst9|inst1|I2|idata_x[8]~43\ # \inst9|inst1|I4|ireg_c[4]\ & \inst9|inst1|I4|i~760\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C8C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[4]\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I2|idata_x[8]~43\,
	datad => \inst9|inst1|I4|i~760\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[4]~20\);

\inst9|inst4|i~437_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~437\ = \inst9|inst1|I4|ndre_x~1\ & \inst9|inst4|daddr_c[4]\ & !\inst9|inst4|i~382\ # !\inst9|inst1|I4|ndre_x~1\ & \inst9|inst1|I4|daddr_x[4]~20\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5D08",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ndre_x~1\,
	datab => \inst9|inst4|daddr_c[4]\,
	datac => \inst9|inst4|i~382\,
	datad => \inst9|inst1|I4|daddr_x[4]~20\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~437\);

\inst9|inst4|i~87_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~87\ = \inst9|inst4|i~437\ # \inst9|inst1|I1|i~2\ & \inst9|inst4|i~379\ & \inst9|inst1|I1|iaddr_x[4]~462\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|i~2\,
	datab => \inst9|inst4|i~379\,
	datac => \inst9|inst1|I1|iaddr_x[4]~462\,
	datad => \inst9|inst4|i~437\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~87\);

\inst9|inst15|lpm_ram_dq_component|sram|segment[0][0]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem2 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010100001001010010101010010000001101010101100110001001100110010000000001001001000000010010001010001011010111010110000101010001010010100000010101010110101101101101101101111011101010100101010101010101010101010",
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|lpm_ram_dq1:inst15|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "rom.mif",
	logical_ram_depth => 1024,
	logical_ram_width => 14,
	address_width => 10,
	first_address => 0,
	last_address => 1023,
	bit_number => 0,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst1|I4|data_ox[0]~7\,
	clk0 => \clk~combout\,
	we => \inst9|inst19|i~50\,
	waddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][0]_waddr\,
	raddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][0]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst15|lpm_ram_dq_component|sram|segment[0][0]_modesel\,
	dataout => \inst9|inst15|lpm_ram_dq_component|sram|q[0]\);

\inst9|inst1|I2|idata_x[0]~18_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[0]~18\ = \inst9|inst15|lpm_ram_dq_component|sram|q[0]\ & (!\inst9|inst1|I2|i~2\ # !\inst9|inst1|I2|i~441\ # !\inst9|inst12|dwait_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7F00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|dwait_c\,
	datab => \inst9|inst1|I2|i~441\,
	datac => \inst9|inst1|I2|i~2\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[0]~18\);

\inst9|inst1|I2|idata_x[3]~15_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[3]~15\ = \inst9|inst15|lpm_ram_dq_component|sram|q[3]\ & (!\inst9|inst1|I2|i~2\ # !\inst9|inst1|I2|i~441\ # !\inst9|inst12|dwait_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7F00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|dwait_c\,
	datab => \inst9|inst1|I2|i~441\,
	datac => \inst9|inst1|I2|i~2\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[3]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[3]~15\);

\rtl~9984_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~9984\ = !\inst9|inst1|I2|idata_x[0]~17\ & !\inst9|inst1|I2|idata_x[0]~18\ & !\inst9|inst1|I2|idata_x[3]~14\ & !\inst9|inst1|I2|idata_x[3]~15\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0001",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[0]~17\,
	datab => \inst9|inst1|I2|idata_x[0]~18\,
	datac => \inst9|inst1|I2|idata_x[3]~14\,
	datad => \inst9|inst1|I2|idata_x[3]~15\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~9984\);

\inst9|inst1|I2|Mux_69~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|Mux_69~0\ = \inst9|inst1|I2|idata_x[7]~31\ & \inst9|inst1|I2|idata_x[5]~34\ & !\inst9|inst1|I2|idata_x[4]~37\ & !\inst9|inst1|I2|idata_x[6]~28\ # !\inst9|inst1|I2|idata_x[7]~31\ & (\inst9|inst1|I2|idata_x[5]~34\ $ (\inst9|inst1|I2|idata_x[4]~37\ & \inst9|inst1|I2|idata_x[6]~28\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "144C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[7]~31\,
	datab => \inst9|inst1|I2|idata_x[5]~34\,
	datac => \inst9|inst1|I2|idata_x[4]~37\,
	datad => \inst9|inst1|I2|idata_x[6]~28\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|Mux_69~0\);

\inst9|inst1|I2|TD_c[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TD_c[1]\ = DFFE(\inst9|inst1|I2|idata_x[1]~22\ # !\inst9|inst1|I2|idata_x[2]~25\ & \rtl~9984\ & \inst9|inst1|I2|Mux_69~0\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F4F0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[2]~25\,
	datab => \rtl~9984\,
	datac => \inst9|inst1|I2|idata_x[1]~22\,
	datad => \inst9|inst1|I2|Mux_69~0\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|TD_c[1]\);

\inst9|inst1|I2|Mux_68~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|Mux_68~0\ = \inst9|inst1|I2|idata_x[7]~31\ & \inst9|inst1|I2|idata_x[5]~34\ & !\inst9|inst1|I2|idata_x[6]~28\ & \inst9|inst1|I2|idata_x[4]~37\ # !\inst9|inst1|I2|idata_x[7]~31\ & \inst9|inst1|I2|idata_x[6]~28\ & (!\inst9|inst1|I2|idata_x[4]~37\ # !\inst9|inst1|I2|idata_x[5]~34\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "1850",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[7]~31\,
	datab => \inst9|inst1|I2|idata_x[5]~34\,
	datac => \inst9|inst1|I2|idata_x[6]~28\,
	datad => \inst9|inst1|I2|idata_x[4]~37\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|Mux_68~0\);

\inst9|inst1|I2|TD_c[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TD_c[2]\ = DFFE(\inst9|inst1|I2|idata_x[2]~25\ # \rtl~9984\ & !\inst9|inst1|I2|idata_x[1]~22\ & \inst9|inst1|I2|Mux_68~0\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AEAA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[2]~25\,
	datab => \rtl~9984\,
	datac => \inst9|inst1|I2|idata_x[1]~22\,
	datad => \inst9|inst1|I2|Mux_68~0\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|TD_c[2]\);

\inst9|inst1|I3|data_x[0]~10_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[0]~10\ = !\inst9|inst1|I2|TC_c[0]\ & \inst9|inst1|I2|TC_c[1]\ & !\inst9|inst1|I2|TC_c[2]\ & \inst9|inst1|I2|data_is_c[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TC_c[0]\,
	datab => \inst9|inst1|I2|TC_c[1]\,
	datac => \inst9|inst1|I2|TC_c[2]\,
	datad => \inst9|inst1|I2|data_is_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[0]~10\);

\inst9|inst1|I3|data_x[2]~1983_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[2]~1983\ = \inst9|inst1|I4|i~18\ & (\inst9|inst1|I2|TC_c[2]\ # \inst9|inst1|I2|TC_c[0]\ # !\inst9|inst1|I2|TC_c[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EF00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TC_c[2]\,
	datab => \inst9|inst1|I2|TC_c[0]\,
	datac => \inst9|inst1|I2|TC_c[1]\,
	datad => \inst9|inst1|I4|i~18\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[2]~1983\);

\inst9|inst1|I4|i~800_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|i~800\ = !\inst9|inst1|I2|idata_x[6]~28\ & (\inst9|inst1|I2|idata_x[5]~34\ $ \inst9|inst1|I2|idata_x[4]~37\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "030C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|idata_x[5]~34\,
	datac => \inst9|inst1|I2|idata_x[6]~28\,
	datad => \inst9|inst1|I2|idata_x[4]~37\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|i~800\);

\inst9|inst1|I4|i~616_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|i~616\ = \inst9|inst1|I4|i~800\ & \inst9|inst1|I4|i~815\ & (\inst9|inst1|I4|reduce_nor_106\ # \inst9|inst1|I2|ndre_x~41\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|reduce_nor_106\,
	datab => \inst9|inst1|I2|ndre_x~41\,
	datac => \inst9|inst1|I4|i~800\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|i~616\);

\inst9|inst1|I4|iinc_i[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_i[0]\ = DFFE(\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I3|acc_c[0][0]\ # !\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I4|iinc_c[0]\ & \inst9|inst1|I4|i~18\, GLOBAL(\clk~combout\), , , \inst9|inst1|I4|ireg_i[4]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAC0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][0]\,
	datab => \inst9|inst1|I4|iinc_c[0]\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I4|iinc_we_c\,
	clk => \clk~combout\,
	ena => \inst9|inst1|I4|ireg_i[4]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|iinc_i[0]\);

\inst9|inst1|I4|iinc_x[0]~11_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_x[0]~11\ = \inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I3|acc_c[0][0]\ # !\inst9|inst1|I4|iinc_we_c\ & \inst9|inst1|I4|iinc_c[0]\ & \inst9|inst1|I4|i~18\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][0]\,
	datab => \inst9|inst1|I4|iinc_c[0]\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I4|iinc_we_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|iinc_x[0]~11\);

\inst9|inst1|I4|iinc_c[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|iinc_c[0]\ = DFFE(\inst9|inst1|I2|int_stop_x~11\ & \inst9|inst1|I4|iinc_i[0]\ # !\inst9|inst1|I2|int_stop_x~11\ & \inst9|inst1|I4|iinc_x[0]~11\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "D8D8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|int_stop_x~11\,
	datab => \inst9|inst1|I4|iinc_i[0]\,
	datac => \inst9|inst1|I4|iinc_x[0]~11\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|iinc_c[0]\);

\inst9|inst1|I3|data_x[0]~145_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[0]~145\ = \inst9|inst1|I4|reduce_nor_106\ & \inst9|inst1|I4|iinc_c[0]\ & \inst9|inst1|I2|ndre_x~41\ # !\inst9|inst1|I4|reduce_nor_106\ & \inst9|inst1|I4|ireg_c[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AC0C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|iinc_c[0]\,
	datab => \inst9|inst1|I4|ireg_c[0]\,
	datac => \inst9|inst1|I4|reduce_nor_106\,
	datad => \inst9|inst1|I2|ndre_x~41\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[0]~145\);

\inst9|inst1|I3|data_x[0]~2144_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[0]~2144\ = \inst9|inst1|I3|data_x[0]~10\ # \inst9|inst1|I3|data_x[2]~1983\ & \inst9|inst1|I4|i~616\ & \inst9|inst1|I3|data_x[0]~145\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EAAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|data_x[0]~10\,
	datab => \inst9|inst1|I3|data_x[2]~1983\,
	datac => \inst9|inst1|I4|i~616\,
	datad => \inst9|inst1|I3|data_x[0]~145\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[0]~2144\);

\inst9|inst1|I3|Mux_201_rtl_146~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|Mux_201_rtl_146~0\ = \inst9|inst1|I2|TC_c[0]\ $ \inst9|inst1|I2|TC_c[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0FF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst1|I2|TC_c[0]\,
	datad => \inst9|inst1|I2|TC_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|Mux_201_rtl_146~0\);

\inst9|inst12|reduce_or_23~33_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|reduce_or_23~33\ = !\inst9|inst12|nwait_c[2]\ # !\inst9|inst12|nwait_c[3]\ # !\inst9|inst12|nwait_c[1]\ # !\inst9|inst12|nwait_c[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7FFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|nwait_c[0]\,
	datab => \inst9|inst12|nwait_c[1]\,
	datac => \inst9|inst12|nwait_c[3]\,
	datad => \inst9|inst12|nwait_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|reduce_or_23~33\);

\inst9|inst12|i~128_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|i~128\ = \inst9|inst12|dwait_c\ & (\inst9|inst12|reduce_or_23~33\ # !\inst9|inst12|reduce_or_23~16\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F050",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|reduce_or_23~16\,
	datac => \inst9|inst12|dwait_c\,
	datad => \inst9|inst12|reduce_or_23~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|i~128\);

\inst9|inst12|i~1193_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|i~1193\ = \inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & !\inst9|inst12|dwait_c\ & \inst9|inst15|lpm_ram_dq_component|sram|q[12]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst12|dwait_c\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[12]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|i~1193\);

\inst9|inst12|i~1131_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|i~1131\ = \inst9|inst12|i~1193\ & (\inst9|inst1|I4|daddr_x[4]~33\ # \inst9|inst1|I4|i~18\ & \inst9|inst1|I2|idata_x[8]~43\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~18\,
	datab => \inst9|inst1|I2|idata_x[8]~43\,
	datac => \inst9|inst12|i~1193\,
	datad => \inst9|inst1|I4|daddr_x[4]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|i~1131\);

\inst9|inst1|I4|daddr_x[3]~19_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[3]~19\ = \inst9|inst1|I4|daddr_x[3]~31\ # \inst9|inst1|I2|idata_x[7]~31\ & \inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[7]~31\,
	datab => \inst9|inst7\,
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datad => \inst9|inst1|I4|daddr_x[3]~31\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[3]~19\);

\inst9|inst12|i~130_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|i~130\ = !\inst9|inst12|i~128\ & (\inst9|inst1|I4|daddr_x[3]~19\ # !\inst9|inst12|i~1151\ # !\inst9|inst12|i~1131\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5155",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|i~128\,
	datab => \inst9|inst12|i~1131\,
	datac => \inst9|inst1|I4|daddr_x[3]~19\,
	datad => \inst9|inst12|i~1151\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|i~130\);

\inst9|inst12|nwait_c[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|nwait_c[0]\ = DFFE((\inst9|inst12|i~130\ & \~GND\) # (!\inst9|inst12|i~130\ & !\inst9|inst12|nwait_c[0]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst12|nwait_c[0]~COUT\ = CARRY(!\inst9|inst12|nwait_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	packed_mode => "false",
	lut_mask => "5555",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|nwait_c[0]\,
	datac => \~GND\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst12|i~130\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst12|nwait_c[0]\,
	cout => \inst9|inst12|nwait_c[0]~COUT\);

\inst9|inst12|nwait_c[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|nwait_c[1]\ = DFFE((\inst9|inst12|i~130\ & \~GND\) # (!\inst9|inst12|i~130\ & \inst9|inst12|nwait_c[1]\ $ !\inst9|inst12|nwait_c[0]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst12|nwait_c[1]~COUT\ = CARRY(\inst9|inst12|nwait_c[1]\ & !\inst9|inst12|nwait_c[0]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "C30C",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst12|nwait_c[1]\,
	datac => \~GND\,
	cin => \inst9|inst12|nwait_c[0]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst12|i~130\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst12|nwait_c[1]\,
	cout => \inst9|inst12|nwait_c[1]~COUT\);

\inst9|inst12|nwait_c[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|nwait_c[2]\ = DFFE((\inst9|inst12|i~130\ & \~GND\) # (!\inst9|inst12|i~130\ & \inst9|inst12|nwait_c[2]\ $ \inst9|inst12|nwait_c[1]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst12|nwait_c[2]~COUT\ = CARRY(!\inst9|inst12|nwait_c[1]~COUT\ # !\inst9|inst12|nwait_c[2]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3C3F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst12|nwait_c[2]\,
	datac => \~GND\,
	cin => \inst9|inst12|nwait_c[1]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst12|i~130\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst12|nwait_c[2]\,
	cout => \inst9|inst12|nwait_c[2]~COUT\);

\inst9|inst12|nwait_c[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|nwait_c[3]\ = DFFE((\inst9|inst12|i~130\ & \~GND\) # (!\inst9|inst12|i~130\ & \inst9|inst12|nwait_c[3]\ $ !\inst9|inst12|nwait_c[2]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst12|nwait_c[3]~COUT\ = CARRY(\inst9|inst12|nwait_c[3]\ & !\inst9|inst12|nwait_c[2]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "A50A",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|nwait_c[3]\,
	datac => \~GND\,
	cin => \inst9|inst12|nwait_c[2]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst12|i~130\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst12|nwait_c[3]\,
	cout => \inst9|inst12|nwait_c[3]~COUT\);

\inst9|inst12|nwait_c[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|nwait_c[4]\ = DFFE((\inst9|inst12|i~130\ & \~GND\) # (!\inst9|inst12|i~130\ & \inst9|inst12|nwait_c[4]\ $ \inst9|inst12|nwait_c[3]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst12|nwait_c[4]~COUT\ = CARRY(\inst9|inst12|nwait_c[4]\ # !\inst9|inst12|nwait_c[3]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5AAF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|nwait_c[4]\,
	datac => \~GND\,
	cin => \inst9|inst12|nwait_c[3]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst12|i~130\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst12|nwait_c[4]\,
	cout => \inst9|inst12|nwait_c[4]~COUT\);

\inst9|inst12|nwait_c[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|nwait_c[5]\ = DFFE((\inst9|inst12|i~130\ & \~GND\) # (!\inst9|inst12|i~130\ & \inst9|inst12|nwait_c[5]\ $ !\inst9|inst12|nwait_c[4]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst12|nwait_c[5]~COUT\ = CARRY(!\inst9|inst12|nwait_c[5]\ & !\inst9|inst12|nwait_c[4]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "A505",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|nwait_c[5]\,
	datac => \~GND\,
	cin => \inst9|inst12|nwait_c[4]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst12|i~130\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst12|nwait_c[5]\,
	cout => \inst9|inst12|nwait_c[5]~COUT\);

\inst9|inst12|nwait_c[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|nwait_c[6]\ = DFFE((\inst9|inst12|i~130\ & \~GND\) # (!\inst9|inst12|i~130\ & \inst9|inst12|nwait_c[6]\ $ \inst9|inst12|nwait_c[5]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst12|nwait_c[6]~COUT\ = CARRY(\inst9|inst12|nwait_c[6]\ # !\inst9|inst12|nwait_c[5]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5AAF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|nwait_c[6]\,
	datac => \~GND\,
	cin => \inst9|inst12|nwait_c[5]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst12|i~130\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst12|nwait_c[6]\,
	cout => \inst9|inst12|nwait_c[6]~COUT\);

\inst9|inst12|nwait_c[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|nwait_c[7]\ = DFFE((\inst9|inst12|i~130\ & \~GND\) # (!\inst9|inst12|i~130\ & \inst9|inst12|nwait_c[6]~COUT\ $ !\inst9|inst12|nwait_c[7]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "F00F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \~GND\,
	datad => \inst9|inst12|nwait_c[7]\,
	cin => \inst9|inst12|nwait_c[6]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst12|i~130\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst12|nwait_c[7]\);

\inst9|inst12|reduce_or_23~16_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|reduce_or_23~16\ = !\inst9|inst12|nwait_c[7]\ & !\inst9|inst12|nwait_c[5]\ & !\inst9|inst12|nwait_c[6]\ & !\inst9|inst12|nwait_c[4]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0001",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|nwait_c[7]\,
	datab => \inst9|inst12|nwait_c[5]\,
	datac => \inst9|inst12|nwait_c[6]\,
	datad => \inst9|inst12|nwait_c[4]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|reduce_or_23~16\);

\inst9|inst12|reduce_or_73~22_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|reduce_or_73~22\ = \inst9|inst12|nwait_c[3]\ # \inst9|inst12|nwait_c[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst12|nwait_c[3]\,
	datad => \inst9|inst12|nwait_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|reduce_or_73~22\);

\inst9|inst12|reduce_or_73~21_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|reduce_or_73~21\ = \inst9|inst12|nwait_c[0]\ # \inst9|inst12|nwait_c[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst12|nwait_c[0]\,
	datad => \inst9|inst12|nwait_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|reduce_or_73~21\);

\inst9|inst12|cpu_daddr_x[2]~347_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|cpu_daddr_x[2]~347\ = \inst9|inst12|reduce_or_23~16\ & \inst9|inst7\ & !\inst9|inst12|reduce_or_73~22\ & !\inst9|inst12|reduce_or_73~21\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0008",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|reduce_or_23~16\,
	datab => \inst9|inst7\,
	datac => \inst9|inst12|reduce_or_73~22\,
	datad => \inst9|inst12|reduce_or_73~21\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|cpu_daddr_x[2]~347\);

\inst9|inst12|reduce_or_73~14_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|reduce_or_73~14\ = \inst9|inst12|nwait_c[2]\ # \inst9|inst12|nwait_c[0]\ # \inst9|inst12|nwait_c[1]\ # \inst9|inst12|nwait_c[3]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|nwait_c[2]\,
	datab => \inst9|inst12|nwait_c[0]\,
	datac => \inst9|inst12|nwait_c[1]\,
	datad => \inst9|inst12|nwait_c[3]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|reduce_or_73~14\);

\inst9|inst12|cpu_daddr_x[3]~17_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|cpu_daddr_x[3]~17\ = \inst9|inst12|cpu_daddr_c[3]\ & \inst9|inst7\ & (\inst9|inst12|reduce_or_73~14\ # !\inst9|inst12|reduce_or_23~16\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A200",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|cpu_daddr_c[3]\,
	datab => \inst9|inst12|reduce_or_23~16\,
	datac => \inst9|inst12|reduce_or_73~14\,
	datad => \inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|cpu_daddr_x[3]~17\);

\inst9|inst12|cpu_daddr_c[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|cpu_daddr_c[3]\ = DFFE(\inst9|inst12|cpu_daddr_x[3]~17\ # \inst9|inst12|cpu_daddr_x[2]~347\ & (\inst9|inst1|I4|daddr_x[3]~30\ # \inst9|inst1|I4|daddr_x[3]~31\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FAF8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|cpu_daddr_x[2]~347\,
	datab => \inst9|inst1|I4|daddr_x[3]~30\,
	datac => \inst9|inst12|cpu_daddr_x[3]~17\,
	datad => \inst9|inst1|I4|daddr_x[3]~31\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst12|cpu_daddr_c[3]\);

\inst9|inst12|cpu_daddr_x[3]~11_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|cpu_daddr_x[3]~11\ = \inst9|inst12|cpu_daddr_x[3]~17\ # \inst9|inst12|cpu_daddr_x[2]~347\ & (\inst9|inst1|I4|daddr_x[3]~30\ # \inst9|inst1|I4|daddr_x[3]~31\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FAEA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|cpu_daddr_x[3]~17\,
	datab => \inst9|inst1|I4|daddr_x[3]~30\,
	datac => \inst9|inst12|cpu_daddr_x[2]~347\,
	datad => \inst9|inst1|I4|daddr_x[3]~31\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|cpu_daddr_x[3]~11\);

\inst9|inst12|i~109_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|i~109\ = \inst9|inst1|I4|ndre_x~1\ & \inst9|inst12|cpu_daddr_c[3]\ # !\inst9|inst1|I4|ndre_x~1\ & \inst9|inst12|cpu_daddr_x[3]~11\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F3C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|ndre_x~1\,
	datac => \inst9|inst12|cpu_daddr_c[3]\,
	datad => \inst9|inst12|cpu_daddr_x[3]~11\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|i~109\);

\inst9|inst12|cpu_daddr_x[4]~19_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|cpu_daddr_x[4]~19\ = \inst9|inst12|cpu_daddr_c[4]\ & \inst9|inst7\ & (\inst9|inst12|reduce_or_73~14\ # !\inst9|inst12|reduce_or_23~16\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C040",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|reduce_or_23~16\,
	datab => \inst9|inst12|cpu_daddr_c[4]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst12|reduce_or_73~14\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|cpu_daddr_x[4]~19\);

\inst9|inst12|cpu_daddr_c[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|cpu_daddr_c[4]\ = DFFE(\inst9|inst12|cpu_daddr_x[4]~19\ # \inst9|inst12|cpu_daddr_x[2]~347\ & (\inst9|inst1|I4|daddr_x[4]~32\ # \inst9|inst1|I4|daddr_x[4]~33\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FCF8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|daddr_x[4]~32\,
	datab => \inst9|inst12|cpu_daddr_x[2]~347\,
	datac => \inst9|inst12|cpu_daddr_x[4]~19\,
	datad => \inst9|inst1|I4|daddr_x[4]~33\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst12|cpu_daddr_c[4]\);

\inst9|inst12|cpu_daddr_x[4]~12_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|cpu_daddr_x[4]~12\ = \inst9|inst12|cpu_daddr_x[4]~19\ # \inst9|inst12|cpu_daddr_x[2]~347\ & (\inst9|inst1|I4|daddr_x[4]~32\ # \inst9|inst1|I4|daddr_x[4]~33\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EEEA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|cpu_daddr_x[4]~19\,
	datab => \inst9|inst12|cpu_daddr_x[2]~347\,
	datac => \inst9|inst1|I4|daddr_x[4]~32\,
	datad => \inst9|inst1|I4|daddr_x[4]~33\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|cpu_daddr_x[4]~12\);

\inst9|inst12|i~115_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|i~115\ = \inst9|inst12|cpu_daddr_c[4]\ & (\inst9|inst1|I4|ndre_x~1\ # \inst9|inst12|cpu_daddr_x[4]~12\) # !\inst9|inst12|cpu_daddr_c[4]\ & !\inst9|inst1|I4|ndre_x~1\ & \inst9|inst12|cpu_daddr_x[4]~12\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CFC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst12|cpu_daddr_c[4]\,
	datac => \inst9|inst1|I4|ndre_x~1\,
	datad => \inst9|inst12|cpu_daddr_x[4]~12\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|i~115\);

\inst9|inst12|reduce_or_73~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|reduce_or_73\ = !\inst9|inst12|nwait_c[3]\ & !\inst9|inst12|nwait_c[2]\ & \inst9|inst12|reduce_or_23~16\ & !\inst9|inst12|reduce_or_73~21\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0010",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|nwait_c[3]\,
	datab => \inst9|inst12|nwait_c[2]\,
	datac => \inst9|inst12|reduce_or_23~16\,
	datad => \inst9|inst12|reduce_or_73~21\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|reduce_or_73\);

\inst9|inst12|cpu_daddr_x[8]~32_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|cpu_daddr_x[8]~32\ = \inst9|inst7\ & (\inst9|inst12|reduce_or_73\ & \inst9|inst4|i~381\ # !\inst9|inst12|reduce_or_73\ & \inst9|inst12|cpu_daddr_c[8]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A808",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datab => \inst9|inst12|cpu_daddr_c[8]\,
	datac => \inst9|inst12|reduce_or_73\,
	datad => \inst9|inst4|i~381\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|cpu_daddr_x[8]~32\);

\inst9|inst12|i~121_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|i~121\ = \inst9|inst12|cpu_daddr_c[8]\ & (\inst9|inst12|cpu_daddr_x[8]~32\ # \inst9|inst1|I4|ndre_x~1\) # !\inst9|inst12|cpu_daddr_c[8]\ & \inst9|inst12|cpu_daddr_x[8]~32\ & !\inst9|inst1|I4|ndre_x~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CCF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst12|cpu_daddr_c[8]\,
	datac => \inst9|inst12|cpu_daddr_x[8]~32\,
	datad => \inst9|inst1|I4|ndre_x~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|i~121\);

\inst9|inst12|cpu_daddr_x[2]~15_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|cpu_daddr_x[2]~15\ = \inst9|inst7\ & \inst9|inst12|cpu_daddr_c[2]\ & (\inst9|inst12|reduce_or_73~14\ # !\inst9|inst12|reduce_or_23~16\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8088",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datab => \inst9|inst12|cpu_daddr_c[2]\,
	datac => \inst9|inst12|reduce_or_73~14\,
	datad => \inst9|inst12|reduce_or_23~16\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|cpu_daddr_x[2]~15\);

\inst9|inst12|cpu_daddr_c[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|cpu_daddr_c[2]\ = DFFE(\inst9|inst12|cpu_daddr_x[2]~15\ # \inst9|inst12|cpu_daddr_x[2]~347\ & (\inst9|inst1|I4|daddr_x[2]~27\ # \inst9|inst1|I4|daddr_x[2]~28\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FAF8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|cpu_daddr_x[2]~347\,
	datab => \inst9|inst1|I4|daddr_x[2]~27\,
	datac => \inst9|inst12|cpu_daddr_x[2]~15\,
	datad => \inst9|inst1|I4|daddr_x[2]~28\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst12|cpu_daddr_c[2]\);

\inst9|inst12|cpu_daddr_x[2]~10_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|cpu_daddr_x[2]~10\ = \inst9|inst12|cpu_daddr_x[2]~15\ # \inst9|inst12|cpu_daddr_x[2]~347\ & (\inst9|inst1|I4|daddr_x[2]~27\ # \inst9|inst1|I4|daddr_x[2]~28\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FAF8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|cpu_daddr_x[2]~347\,
	datab => \inst9|inst1|I4|daddr_x[2]~27\,
	datac => \inst9|inst12|cpu_daddr_x[2]~15\,
	datad => \inst9|inst1|I4|daddr_x[2]~28\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|cpu_daddr_x[2]~10\);

\inst9|inst12|i~103_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|i~103\ = \inst9|inst12|cpu_daddr_c[2]\ & (\inst9|inst1|I4|ndre_x~1\ # \inst9|inst12|cpu_daddr_x[2]~10\) # !\inst9|inst12|cpu_daddr_c[2]\ & !\inst9|inst1|I4|ndre_x~1\ & \inst9|inst12|cpu_daddr_x[2]~10\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AFA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|cpu_daddr_c[2]\,
	datac => \inst9|inst1|I4|ndre_x~1\,
	datad => \inst9|inst12|cpu_daddr_x[2]~10\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|i~103\);

\inst9|inst19|mux_c[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst19|mux_c[1]\ = DFFE(\inst9|inst12|i~109\ & !\inst9|inst12|i~115\ & \inst9|inst12|i~121\ & !\inst9|inst12|i~103\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0020",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|i~109\,
	datab => \inst9|inst12|i~115\,
	datac => \inst9|inst12|i~121\,
	datad => \inst9|inst12|i~103\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst19|mux_c[1]\);

\inst9|inst19|mux_c[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst19|mux_c[0]\ = DFFE(!\inst9|inst12|i~103\ & \inst9|inst12|i~121\ & !\inst9|inst12|i~109\ & !\inst9|inst12|i~115\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0004",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|i~103\,
	datab => \inst9|inst12|i~121\,
	datac => \inst9|inst12|i~109\,
	datad => \inst9|inst12|i~115\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst19|mux_c[0]\);

\inst9|inst19|Mux_13_rtl_0~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst19|Mux_13_rtl_0~0\ = \inst9|inst19|mux_c[1]\ $ \inst9|inst19|mux_c[0]\
-- \inst9|inst19|Mux_13_rtl_0~2\ = \inst9|inst19|mux_c[1]\ $ \inst9|inst19|mux_c[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "33CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst19|mux_c[1]\,
	datad => \inst9|inst19|mux_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst19|Mux_13_rtl_0~0\,
	cascout => \inst9|inst19|Mux_13_rtl_0~2\);

\inst9|inst1|I3|data_x[2]~2292_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[2]~2292\ = \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I3|reduce_nor_71\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8800",
	output_mode => "none")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datab => \inst9|inst7\,
	datad => \inst9|inst1|I3|reduce_nor_71\,
	devclrn => devclrn,
	devpor => devpor,
	cascout => \inst9|inst1|I3|data_x[2]~2292\);

\inst9|inst1|I3|data_x[2]~2293_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[2]~2293\ = (!\inst9|inst1|I4|i~815\ # !\inst9|inst1|I4|i~800\ # !\inst9|inst1|I2|ndre_x~41\) & CASCADE(\inst9|inst1|I3|data_x[2]~2292\)
-- \inst9|inst1|I3|data_x[2]~2296\ = (!\inst9|inst1|I4|i~815\ # !\inst9|inst1|I4|i~800\ # !\inst9|inst1|I2|ndre_x~41\) & CASCADE(\inst9|inst1|I3|data_x[2]~2292\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "3FFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|ndre_x~41\,
	datac => \inst9|inst1|I4|i~800\,
	datad => \inst9|inst1|I4|i~815\,
	cascin => \inst9|inst1|I3|data_x[2]~2292\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[2]~2293\,
	cascout => \inst9|inst1|I3|data_x[2]~2296\);

\RXD~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => GND,
	ena => VCC,
	padio => ww_RXD,
	combout => \RXD~combout\);

\inst9|inst|add_45~5_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|add_45~5\ = \inst9|inst|rx_16_count[1]\ $ \inst9|inst|rx_16_count[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0FF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst|rx_16_count[1]\,
	datad => \inst9|inst|rx_16_count[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|add_45~5\);

\rtl~9986_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~9986\ = \inst9|inst|rx_s[0]\ & !\inst9|inst|rx_s[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0A0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_s[0]\,
	datac => \inst9|inst|rx_s[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~9986\);

\rtl~843_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~843\ = !\inst9|inst|rx_s[0]\ & \inst9|inst|rx_16_count[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5050",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_s[0]\,
	datac => \inst9|inst|rx_16_count[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~843\);

\inst9|inst12|cpu_daddr_x[0]~23_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|cpu_daddr_x[0]~23\ = \inst9|inst7\ & \inst9|inst12|cpu_daddr_c[0]\ & (\inst9|inst12|reduce_or_73~14\ # !\inst9|inst12|reduce_or_23~16\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A200",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datab => \inst9|inst12|reduce_or_23~16\,
	datac => \inst9|inst12|reduce_or_73~14\,
	datad => \inst9|inst12|cpu_daddr_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|cpu_daddr_x[0]~23\);

\inst9|inst1|I4|daddr_x[0]~34_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[0]~34\ = \inst9|inst1|I4|i~18\ & (\inst9|inst1|I2|E_x.dwait_e~0\ & \inst9|inst1|I2|data_is_c[0]\ # !\inst9|inst1|I2|E_x.dwait_e~0\ & \inst9|inst15|lpm_ram_dq_component|sram|q[4]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8C80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|data_is_c[0]\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I2|E_x.dwait_e~0\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[4]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[0]~34\);

\inst9|inst1|I4|daddr_x[0]~35_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[0]~35\ = \inst9|inst1|I4|ireg_c[0]\ & \inst9|inst1|I4|i~18\ & !\inst9|inst1|I4|reduce_nor_103\ & \inst9|inst1|I4|i~815\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[0]\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I4|reduce_nor_103\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[0]~35\);

\inst9|inst12|cpu_daddr_c[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|cpu_daddr_c[0]\ = DFFE(\inst9|inst12|cpu_daddr_x[0]~23\ # \inst9|inst12|cpu_daddr_x[2]~347\ & (\inst9|inst1|I4|daddr_x[0]~34\ # \inst9|inst1|I4|daddr_x[0]~35\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EEEC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|cpu_daddr_x[2]~347\,
	datab => \inst9|inst12|cpu_daddr_x[0]~23\,
	datac => \inst9|inst1|I4|daddr_x[0]~34\,
	datad => \inst9|inst1|I4|daddr_x[0]~35\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst12|cpu_daddr_c[0]\);

\inst9|inst12|cpu_daddr_x[0]~14_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|cpu_daddr_x[0]~14\ = \inst9|inst12|cpu_daddr_x[0]~23\ # \inst9|inst12|cpu_daddr_x[2]~347\ & (\inst9|inst1|I4|daddr_x[0]~34\ # \inst9|inst1|I4|daddr_x[0]~35\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EEEC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|cpu_daddr_x[2]~347\,
	datab => \inst9|inst12|cpu_daddr_x[0]~23\,
	datac => \inst9|inst1|I4|daddr_x[0]~34\,
	datad => \inst9|inst1|I4|daddr_x[0]~35\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|cpu_daddr_x[0]~14\);

\inst9|inst12|ndwe_c~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|ndwe_c\ = DFFE(\inst9|inst1|I4|i~18\ & \inst9|inst1|I2|ndwe_x~45\ & (!\inst9|inst1|I4|i~815\ # !\inst9|inst1|I4|i~800\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst12|reduce_or_73\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "40C0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~800\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I2|ndwe_x~45\,
	datad => \inst9|inst1|I4|i~815\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst12|reduce_or_73\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst12|ndwe_c\);

\inst9|inst19|i~81_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst19|i~81\ = \inst9|inst7\ & \inst9|inst12|ndwe_c\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst7\,
	datad => \inst9|inst12|ndwe_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst19|i~81\);

\inst9|inst2|i~455_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|i~455\ = \inst9|inst19|i~81\ & (\inst9|inst1|I4|ndre_x~1\ & \inst9|inst12|cpu_daddr_c[8]\ # !\inst9|inst1|I4|ndre_x~1\ & \inst9|inst12|cpu_daddr_x[8]~32\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|cpu_daddr_c[8]\,
	datab => \inst9|inst19|i~81\,
	datac => \inst9|inst12|cpu_daddr_x[8]~32\,
	datad => \inst9|inst1|I4|ndre_x~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|i~455\);

\inst9|inst2|i~456_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|i~456\ = \inst9|inst2|i~455\ & (\inst9|inst1|I4|ndre_x~1\ & \inst9|inst12|cpu_daddr_c[0]\ # !\inst9|inst1|I4|ndre_x~1\ & \inst9|inst12|cpu_daddr_x[0]~14\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AC00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|cpu_daddr_c[0]\,
	datab => \inst9|inst12|cpu_daddr_x[0]~14\,
	datac => \inst9|inst1|I4|ndre_x~1\,
	datad => \inst9|inst2|i~455\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|i~456\);

\inst9|inst|i~204_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|i~204\ = \inst9|inst12|i~109\ & !\inst9|inst12|i~103\ & !\inst9|inst12|i~115\ & \inst9|inst2|i~456\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0200",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|i~109\,
	datab => \inst9|inst12|i~103\,
	datac => \inst9|inst12|i~115\,
	datad => \inst9|inst2|i~456\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|i~204\);

\inst9|inst|rx_clk_div[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_clk_div[7]\ = DFFE(\inst9|inst1|I3|acc_c[0][7]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|i~204\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][7]\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|i~204\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_clk_div[7]\);

\inst9|inst|rx_clk_div[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_clk_div[6]\ = DFFE(\inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst1|I3|acc_c[0][6]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|i~204\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst7\,
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datad => \inst9|inst1|I3|acc_c[0][6]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|i~204\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_clk_div[6]\);

\inst9|inst|rx_clk_div[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_clk_div[5]\ = DFFE(\inst9|inst1|I3|acc_c[0][5]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|i~204\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][5]\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|i~204\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_clk_div[5]\);

\inst9|inst|rx_clk_div[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_clk_div[4]\ = DFFE(\inst9|inst1|I3|acc_c[0][4]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|i~204\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][4]\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|i~204\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_clk_div[4]\);

\inst9|inst|rx_clk_div[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_clk_div[3]\ = DFFE(\inst9|inst1|I3|acc_c[0][3]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|i~204\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][3]\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|i~204\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_clk_div[3]\);

\inst9|inst|rx_clk_div[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_clk_div[2]\ = DFFE(\inst9|inst1|I3|acc_c[0][2]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|i~204\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][2]\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|i~204\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_clk_div[2]\);

\inst9|inst|rx_clk_div[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_clk_div[1]\ = DFFE(\inst9|inst1|I3|acc_c[0][1]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|i~204\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][1]\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|i~204\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_clk_div[1]\);

\inst9|inst|rx_clk_div[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_clk_div[0]\ = DFFE(\inst9|inst1|I3|acc_c[0][0]\ & \inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|i~204\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][0]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|i~204\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_clk_div[0]\);

\inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[0]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[0]\ = DFFE((\inst9|inst|reduce_nor_7\ & \inst9|inst|rx_clk_div[0]\) # (!\inst9|inst|reduce_nor_7\ & !\inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[0]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[0]~COUT\ = CARRY(!\inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "qfbk_counter",
	packed_mode => "false",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst|rx_clk_div[0]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[0]\,
	cout => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[0]~COUT\);

\inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[1]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[1]\ = DFFE((\inst9|inst|reduce_nor_7\ & \inst9|inst|rx_clk_div[1]\) # (!\inst9|inst|reduce_nor_7\ & \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[1]\ $ \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[0]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[1]~COUT\ = CARRY(\inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[1]\ # !\inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[0]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3CCF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[1]\,
	datac => \inst9|inst|rx_clk_div[1]\,
	cin => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[0]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[1]\,
	cout => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[1]~COUT\);

\inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[2]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[2]\ = DFFE((\inst9|inst|reduce_nor_7\ & \inst9|inst|rx_clk_div[2]\) # (!\inst9|inst|reduce_nor_7\ & \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[2]\ $ !\inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[1]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[2]~COUT\ = CARRY(!\inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[2]\ & !\inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[1]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "C303",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[2]\,
	datac => \inst9|inst|rx_clk_div[2]\,
	cin => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[1]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[2]\,
	cout => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[2]~COUT\);

\inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[3]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[3]\ = DFFE((\inst9|inst|reduce_nor_7\ & \inst9|inst|rx_clk_div[3]\) # (!\inst9|inst|reduce_nor_7\ & \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[3]\ $ \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[2]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[3]~COUT\ = CARRY(\inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[3]\ # !\inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[2]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5AAF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[3]\,
	datac => \inst9|inst|rx_clk_div[3]\,
	cin => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[2]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[3]\,
	cout => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[3]~COUT\);

\inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[4]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[4]\ = DFFE((\inst9|inst|reduce_nor_7\ & \inst9|inst|rx_clk_div[4]\) # (!\inst9|inst|reduce_nor_7\ & \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[4]\ $ !\inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[3]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[4]~COUT\ = CARRY(!\inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[4]\ & !\inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[3]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "C303",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[4]\,
	datac => \inst9|inst|rx_clk_div[4]\,
	cin => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[3]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[4]\,
	cout => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[4]~COUT\);

\inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[5]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[5]\ = DFFE((\inst9|inst|reduce_nor_7\ & \inst9|inst|rx_clk_div[5]\) # (!\inst9|inst|reduce_nor_7\ & \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[5]\ $ \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[4]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[5]~COUT\ = CARRY(\inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[5]\ # !\inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[4]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5AAF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[5]\,
	datac => \inst9|inst|rx_clk_div[5]\,
	cin => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[4]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[5]\,
	cout => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[5]~COUT\);

\inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[6]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[6]\ = DFFE((\inst9|inst|reduce_nor_7\ & \inst9|inst|rx_clk_div[6]\) # (!\inst9|inst|reduce_nor_7\ & \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[6]\ $ !\inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[5]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[6]~COUT\ = CARRY(!\inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[6]\ & !\inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[5]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "C303",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[6]\,
	datac => \inst9|inst|rx_clk_div[6]\,
	cin => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[5]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[6]\,
	cout => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[6]~COUT\);

\inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[7]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[7]\ = DFFE((\inst9|inst|reduce_nor_7\ & \inst9|inst|rx_clk_div[7]\) # (!\inst9|inst|reduce_nor_7\ & \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[7]\ $ \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[6]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5A5A",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[7]\,
	datac => \inst9|inst|rx_clk_div[7]\,
	cin => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|counter_cell[6]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[7]\);

\inst9|inst|reduce_nor_7~35_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|reduce_nor_7~35\ = \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[7]\ # \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[6]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[7]\,
	datad => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[6]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|reduce_nor_7~35\);

\inst9|inst|reduce_nor_7~28_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|reduce_nor_7~28\ = \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[2]\ # \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[3]\ # \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[0]\ # \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[2]\,
	datab => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[3]\,
	datac => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[0]\,
	datad => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|reduce_nor_7~28\);

\inst9|inst|reduce_nor_7~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|reduce_nor_7\ = !\inst9|inst|reduce_nor_7~35\ & !\inst9|inst|reduce_nor_7~28\ & !\inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[5]\ & !\inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[4]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0001",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|reduce_nor_7~35\,
	datab => \inst9|inst|reduce_nor_7~28\,
	datac => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[5]\,
	datad => \inst9|inst|rx_clk_count_rtl_29|wysi_counter|q[4]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|reduce_nor_7\);

\inst9|inst|rx_16_count[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_16_count[1]\ = DFFE(\rtl~843\ # \inst9|inst|reduce_nor_27\ & \inst9|inst|add_45~5\ & \rtl~9986\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|reduce_nor_27\,
	datab => \inst9|inst|add_45~5\,
	datac => \rtl~9986\,
	datad => \rtl~843\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_16_count[1]\);

\inst9|inst|add_45~10_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|add_45~10\ = \inst9|inst|rx_16_count[2]\ $ (\inst9|inst|rx_16_count[1]\ & \inst9|inst|rx_16_count[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5AF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_16_count[1]\,
	datac => \inst9|inst|rx_16_count[2]\,
	datad => \inst9|inst|rx_16_count[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|add_45~10\);

\rtl~840_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~840\ = !\inst9|inst|rx_s[0]\ & \inst9|inst|rx_16_count[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5050",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_s[0]\,
	datac => \inst9|inst|rx_16_count[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~840\);

\inst9|inst|rx_16_count[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_16_count[2]\ = DFFE(\rtl~840\ # \inst9|inst|reduce_nor_27\ & \inst9|inst|add_45~10\ & \rtl~9986\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|reduce_nor_27\,
	datab => \inst9|inst|add_45~10\,
	datac => \rtl~9986\,
	datad => \rtl~840\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_16_count[2]\);

\inst9|inst|reduce_nor_27~4_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|reduce_nor_27~4\ = \inst9|inst|rx_16_count[1]\ & \inst9|inst|rx_16_count[0]\ & \inst9|inst|rx_16_count[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst|rx_16_count[1]\,
	datac => \inst9|inst|rx_16_count[0]\,
	datad => \inst9|inst|rx_16_count[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|reduce_nor_27~4\);

\inst9|inst|rx_16_count[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_16_count[3]\ = DFFE(\inst9|inst|rx_s[0]\ & !\inst9|inst|rx_s[1]\ & (\inst9|inst|reduce_nor_27~4\ $ \inst9|inst|rx_16_count[3]\) # !\inst9|inst|rx_s[0]\ & \inst9|inst|rx_16_count[3]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0C6C",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|reduce_nor_27~4\,
	datab => \inst9|inst|rx_16_count[3]\,
	datac => \inst9|inst|rx_s[0]\,
	datad => \inst9|inst|rx_s[1]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_16_count[3]\);

\rtl~1957_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1957\ = !\inst9|inst|rx_s[1]\ & (!\inst9|inst|rx_16_count[3]\ # !\inst9|inst|reduce_nor_27~4\) # !\inst9|inst|rx_s[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0F7F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|reduce_nor_27~4\,
	datab => \inst9|inst|rx_16_count[3]\,
	datac => \inst9|inst|rx_s[0]\,
	datad => \inst9|inst|rx_s[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1957\);

\rtl~9994_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~9994\ = \inst9|inst|rx_16_count[3]\ & \inst9|inst|reduce_nor_27~4\ & !\inst9|inst|rx_s[1]\ & \inst9|inst|rx_s[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_16_count[3]\,
	datab => \inst9|inst|reduce_nor_27~4\,
	datac => \inst9|inst|rx_s[1]\,
	datad => \inst9|inst|rx_s[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~9994\);

\inst9|inst|rx_bit_count[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_bit_count[0]\ = DFFE(\inst9|inst|rx_bit_count[0]\ & \rtl~1957\ # !\inst9|inst|rx_bit_count[0]\ & !\inst9|inst|rx_bit_count[3]\ & \rtl~9994\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8B88",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~1957\,
	datab => \inst9|inst|rx_bit_count[0]\,
	datac => \inst9|inst|rx_bit_count[3]\,
	datad => \rtl~9994\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_bit_count[0]\);

\rtl~9974_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~9974\ = \inst9|inst|reduce_nor_27~4\ & !\inst9|inst|rx_bit_count[3]\ & \rtl~9986\ & \inst9|inst|rx_16_count[3]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|reduce_nor_27~4\,
	datab => \inst9|inst|rx_bit_count[3]\,
	datac => \rtl~9986\,
	datad => \inst9|inst|rx_16_count[3]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~9974\);

\inst9|inst|rx_bit_count[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_bit_count[1]\ = DFFE(\inst9|inst|rx_bit_count[1]\ & (\rtl~1957\ # !\inst9|inst|rx_bit_count[0]\ & \rtl~9974\) # !\inst9|inst|rx_bit_count[1]\ & \inst9|inst|rx_bit_count[0]\ & \rtl~9974\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E6A0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_bit_count[1]\,
	datab => \inst9|inst|rx_bit_count[0]\,
	datac => \rtl~1957\,
	datad => \rtl~9974\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_bit_count[1]\);

\inst9|inst|add_39~7_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|add_39~7\ = \inst9|inst|rx_bit_count[1]\ & \inst9|inst|rx_bit_count[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst|rx_bit_count[1]\,
	datad => \inst9|inst|rx_bit_count[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|add_39~7\);

\inst9|inst|rx_bit_count[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_bit_count[2]\ = DFFE(\inst9|inst|rx_bit_count[2]\ & (\rtl~1957\ # !\inst9|inst|add_39~7\ & \rtl~9974\) # !\inst9|inst|rx_bit_count[2]\ & \inst9|inst|add_39~7\ & \rtl~9974\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BCA0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~1957\,
	datab => \inst9|inst|add_39~7\,
	datac => \inst9|inst|rx_bit_count[2]\,
	datad => \rtl~9974\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_bit_count[2]\);

\rtl~10855_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10855\ = \inst9|inst|rx_bit_count[1]\ & \inst9|inst|rx_bit_count[0]\ & \inst9|inst|rx_bit_count[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_bit_count[1]\,
	datac => \inst9|inst|rx_bit_count[0]\,
	datad => \inst9|inst|rx_bit_count[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10855\);

\inst9|inst|rx_bit_count[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_bit_count[3]\ = DFFE(\inst9|inst|rx_bit_count[3]\ & \rtl~1957\ # !\inst9|inst|rx_bit_count[3]\ & \rtl~10855\ & \rtl~9994\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E4A0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_bit_count[3]\,
	datab => \rtl~10855\,
	datac => \rtl~1957\,
	datad => \rtl~9994\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_bit_count[3]\);

\inst9|inst|rx_8_count[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_8_count[0]\ = DFFE(\inst9|inst|rx_s[1]\ & !\inst9|inst|rx_s[0]\ & !\inst9|inst|rx_8_count[0]\ # !\inst9|inst|rx_s[1]\ & \inst9|inst|rx_8_count[0]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "330C",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst|rx_s[1]\,
	datac => \inst9|inst|rx_s[0]\,
	datad => \inst9|inst|rx_8_count[0]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_8_count[0]\);

\inst9|inst|rx_8_count[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_8_count[1]\ = DFFE(\inst9|inst|rx_s[0]\ & !\inst9|inst|rx_s[1]\ & \inst9|inst|rx_8_count[1]\ # !\inst9|inst|rx_s[0]\ & (\inst9|inst|rx_8_count[1]\ $ (\inst9|inst|rx_8_count[0]\ & \inst9|inst|rx_s[1]\)), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "1F20",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_8_count[0]\,
	datab => \inst9|inst|rx_s[0]\,
	datac => \inst9|inst|rx_s[1]\,
	datad => \inst9|inst|rx_8_count[1]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_8_count[1]\);

\inst9|inst|add_72~52_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|add_72~52\ = \inst9|inst|rx_8_count[0]\ & \inst9|inst|rx_8_count[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst|rx_8_count[0]\,
	datad => \inst9|inst|rx_8_count[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|add_72~52\);

\inst9|inst|rx_8_count[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_8_count[2]\ = DFFE(\inst9|inst|rx_s[1]\ & !\inst9|inst|rx_s[0]\ & (\inst9|inst|rx_8_count[2]\ $ \inst9|inst|add_72~52\) # !\inst9|inst|rx_s[1]\ & \inst9|inst|rx_8_count[2]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5270",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_s[1]\,
	datab => \inst9|inst|rx_s[0]\,
	datac => \inst9|inst|rx_8_count[2]\,
	datad => \inst9|inst|add_72~52\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_8_count[2]\);

\inst9|inst|reduce_nor_68~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|reduce_nor_68\ = !\inst9|inst|rx_8_count[1]\ # !\inst9|inst|rx_8_count[0]\ # !\inst9|inst|rx_8_count[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5FFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_8_count[2]\,
	datac => \inst9|inst|rx_8_count[0]\,
	datad => \inst9|inst|rx_8_count[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|reduce_nor_68\);

\inst9|inst|Mux_103~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|Mux_103~0\ = \inst9|inst|rx_s[1]\ $ \inst9|inst|rx_s[0]\
-- \inst9|inst|Mux_103~2\ = \inst9|inst|rx_s[1]\ $ \inst9|inst|rx_s[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "33CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst|rx_s[1]\,
	datad => \inst9|inst|rx_s[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|Mux_103~0\,
	cascout => \inst9|inst|Mux_103~2\);

\inst9|inst|rx_s[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_s[1]\ = DFFE((\inst9|inst|rx_s[1]\ & \inst9|inst|reduce_nor_68\ # !\inst9|inst|rx_s[1]\ & !\inst9|inst|reduce_nor_27\ & \inst9|inst|rx_bit_count[3]\) & CASCADE(\inst9|inst|Mux_103~2\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DC10",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|reduce_nor_27\,
	datab => \inst9|inst|rx_s[1]\,
	datac => \inst9|inst|rx_bit_count[3]\,
	datad => \inst9|inst|reduce_nor_68\,
	cascin => \inst9|inst|Mux_103~2\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_s[1]\);

\rtl~9992_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~9992\ = !\inst9|inst|rx_s[1]\ & !\RXD~combout\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0033",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst|rx_s[1]\,
	datad => \RXD~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~9992\);

\inst9|inst|rx_8z_count[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_8z_count[0]\ = DFFE(\inst9|inst|rx_8z_count[0]\ & (\inst9|inst|rx_s[1]\ $ \inst9|inst|rx_s[0]\) # !\inst9|inst|rx_8z_count[0]\ & !\inst9|inst|rx_s[1]\ & !\RXD~combout\ & !\inst9|inst|rx_s[0]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5A01",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_s[1]\,
	datab => \RXD~combout\,
	datac => \inst9|inst|rx_s[0]\,
	datad => \inst9|inst|rx_8z_count[0]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_8z_count[0]\);

\rtl~10859_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10859\ = !\inst9|inst|rx_s[1]\ & !\inst9|inst|rx_s[0]\ & !\RXD~combout\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0003",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst|rx_s[1]\,
	datac => \inst9|inst|rx_s[0]\,
	datad => \RXD~combout\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10859\);

\rtl~866_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~866\ = \inst9|inst|rx_8z_count[1]\ & (\inst9|inst|rx_s[0]\ $ \inst9|inst|rx_s[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "3C00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst|rx_s[0]\,
	datac => \inst9|inst|rx_s[1]\,
	datad => \inst9|inst|rx_8z_count[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~866\);

\inst9|inst|add_13~5_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|add_13~5\ = \inst9|inst|rx_8z_count[0]\ $ \inst9|inst|rx_8z_count[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0FF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst|rx_8z_count[0]\,
	datad => \inst9|inst|rx_8z_count[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|add_13~5\);

\inst9|inst|rx_8z_count[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_8z_count[1]\ = DFFE(\rtl~866\ # !\rtl~9979\ & \rtl~10859\ & \inst9|inst|add_13~5\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F4F0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~9979\,
	datab => \rtl~10859\,
	datac => \rtl~866\,
	datad => \inst9|inst|add_13~5\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_8z_count[1]\);

\rtl~10000_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10000\ = \inst9|inst|rx_8z_count[2]\ & \inst9|inst|rx_8z_count[0]\ & \inst9|inst|rx_8z_count[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst|rx_8z_count[2]\,
	datac => \inst9|inst|rx_8z_count[0]\,
	datad => \inst9|inst|rx_8z_count[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10000\);

\inst9|inst|rx_8z_count[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_8z_count[3]\ = DFFE(\inst9|inst|rx_8z_count[3]\ & (\inst9|inst|Mux_103~0\ # \rtl~9992\ & !\rtl~10000\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AE00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|Mux_103~0\,
	datab => \rtl~9992\,
	datac => \rtl~10000\,
	datad => \inst9|inst|rx_8z_count[3]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_8z_count[3]\);

\rtl~9979_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~9979\ = \inst9|inst|rx_8z_count[2]\ & !\inst9|inst|rx_8z_count[3]\ & \inst9|inst|rx_8z_count[1]\ & \inst9|inst|rx_8z_count[0]\
-- \rtl~10914\ = \inst9|inst|rx_8z_count[2]\ & !\inst9|inst|rx_8z_count[3]\ & \inst9|inst|rx_8z_count[1]\ & \inst9|inst|rx_8z_count[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_8z_count[2]\,
	datab => \inst9|inst|rx_8z_count[3]\,
	datac => \inst9|inst|rx_8z_count[1]\,
	datad => \inst9|inst|rx_8z_count[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~9979\,
	cascout => \rtl~10914\);

\inst9|inst|add_13~10_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|add_13~10\ = \inst9|inst|rx_8z_count[2]\ $ (\inst9|inst|rx_8z_count[0]\ & \inst9|inst|rx_8z_count[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "3CCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst|rx_8z_count[2]\,
	datac => \inst9|inst|rx_8z_count[0]\,
	datad => \inst9|inst|rx_8z_count[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|add_13~10\);

\rtl~863_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~863\ = \inst9|inst|rx_8z_count[2]\ & (\inst9|inst|rx_s[0]\ $ \inst9|inst|rx_s[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "50A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_s[0]\,
	datac => \inst9|inst|rx_8z_count[2]\,
	datad => \inst9|inst|rx_s[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~863\);

\inst9|inst|rx_8z_count[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_8z_count[2]\ = DFFE(\rtl~863\ # !\rtl~9979\ & \rtl~10859\ & \inst9|inst|add_13~10\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF40",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~9979\,
	datab => \rtl~10859\,
	datac => \inst9|inst|add_13~10\,
	datad => \rtl~863\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_8z_count[2]\);

\rtl~10910_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10910\ = (!\inst9|inst|rx_s[0]\ & !\RXD~combout\) & CASCADE(\rtl~10914\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "000F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst|rx_s[0]\,
	datad => \RXD~combout\,
	cascin => \rtl~10914\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10910\);

\rtl~9997_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~9997\ = \inst9|inst|rx_16_count[3]\ & \inst9|inst|rx_bit_count[3]\ & \inst9|inst|reduce_nor_27~4\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_16_count[3]\,
	datac => \inst9|inst|rx_bit_count[3]\,
	datad => \inst9|inst|reduce_nor_27~4\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~9997\);

\inst9|inst|rx_s[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_s[0]\ = DFFE(!\inst9|inst|rx_s[1]\ & (\rtl~10910\ # \inst9|inst|rx_s[0]\ & !\rtl~9997\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4454",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_s[1]\,
	datab => \rtl~10910\,
	datac => \inst9|inst|rx_s[0]\,
	datad => \rtl~9997\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_s[0]\);

\inst9|inst|rx_16_count[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_16_count[0]\ = DFFE(\inst9|inst|rx_16_count[0]\ & !\inst9|inst|rx_s[0]\ # !\inst9|inst|rx_16_count[0]\ & \inst9|inst|rx_s[0]\ & !\inst9|inst|rx_s[1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0C3C",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst|rx_16_count[0]\,
	datac => \inst9|inst|rx_s[0]\,
	datad => \inst9|inst|rx_s[1]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_16_count[0]\);

\inst9|inst|reduce_nor_27~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|reduce_nor_27\ = !\inst9|inst|rx_16_count[2]\ # !\inst9|inst|rx_16_count[3]\ # !\inst9|inst|rx_16_count[1]\ # !\inst9|inst|rx_16_count[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7FFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_16_count[0]\,
	datab => \inst9|inst|rx_16_count[1]\,
	datac => \inst9|inst|rx_16_count[3]\,
	datad => \inst9|inst|rx_16_count[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|reduce_nor_27\);

\inst9|inst|Decoder_28~16_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|Decoder_28~16\ = !\inst9|inst|rx_bit_count[0]\ & !\inst9|inst|rx_bit_count[1]\ & !\inst9|inst|rx_bit_count[3]\ & !\inst9|inst|rx_bit_count[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0001",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_bit_count[0]\,
	datab => \inst9|inst|rx_bit_count[1]\,
	datac => \inst9|inst|rx_bit_count[3]\,
	datad => \inst9|inst|rx_bit_count[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|Decoder_28~16\);

\inst9|inst|rx_uart_reg[0]~4_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[0]~4\ = !\inst9|inst|reduce_nor_27\ & \rtl~9986\ & \inst9|inst|reduce_nor_7\ & \inst9|inst|Decoder_28~16\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|reduce_nor_27\,
	datab => \rtl~9986\,
	datac => \inst9|inst|reduce_nor_7\,
	datad => \inst9|inst|Decoder_28~16\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|rx_uart_reg[0]~4\);

\inst9|inst|rx_uart_reg[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[0]\ = DFFE(!\RXD~combout\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|rx_uart_reg[0]~4\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \RXD~combout\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|rx_uart_reg[0]~4\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_reg[0]\);

\inst9|inst|Decoder_28~24_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|Decoder_28~24\ = !\inst9|inst|rx_bit_count[0]\ & !\inst9|inst|rx_bit_count[1]\ & \inst9|inst|rx_bit_count[3]\ & !\inst9|inst|rx_bit_count[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0010",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_bit_count[0]\,
	datab => \inst9|inst|rx_bit_count[1]\,
	datac => \inst9|inst|rx_bit_count[3]\,
	datad => \inst9|inst|rx_bit_count[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|Decoder_28~24\);

\inst9|inst|rx_uart_reg[8]~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[8]~0\ = \rtl~9986\ & !\inst9|inst|reduce_nor_27\ & \inst9|inst|Decoder_28~24\ & \inst9|inst|reduce_nor_7\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~9986\,
	datab => \inst9|inst|reduce_nor_27\,
	datac => \inst9|inst|Decoder_28~24\,
	datad => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|rx_uart_reg[8]~0\);

\inst9|inst|rx_uart_reg[8]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[8]\ = DFFE(!\RXD~combout\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|rx_uart_reg[8]~0\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \RXD~combout\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|rx_uart_reg[8]~0\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_reg[8]\);

\inst9|inst|rx_uart_fifo[4]~29_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_fifo[4]~29\ = \inst9|inst|rx_s[1]\ & !\inst9|inst|rx_8_count[0]\ & !\inst9|inst|rx_s[0]\ & !\inst9|inst|rx_uart_reg[8]\
-- \inst9|inst|rx_uart_fifo[4]~45\ = \inst9|inst|rx_s[1]\ & !\inst9|inst|rx_8_count[0]\ & !\inst9|inst|rx_s[0]\ & !\inst9|inst|rx_uart_reg[8]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0002",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_s[1]\,
	datab => \inst9|inst|rx_8_count[0]\,
	datac => \inst9|inst|rx_s[0]\,
	datad => \inst9|inst|rx_uart_reg[8]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|rx_uart_fifo[4]~29\,
	cascout => \inst9|inst|rx_uart_fifo[4]~45\);

\inst9|inst|rx_uart_fifo[4]~37_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_fifo[4]~37\ = !\inst9|inst|rx_8_count[2]\ & \inst9|inst|reduce_nor_7\ & !\inst9|inst|rx_8_count[1]\ & \inst9|inst|rx_uart_fifo[4]~29\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_8_count[2]\,
	datab => \inst9|inst|reduce_nor_7\,
	datac => \inst9|inst|rx_8_count[1]\,
	datad => \inst9|inst|rx_uart_fifo[4]~29\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|rx_uart_fifo[4]~37\);

\inst9|inst|rx_uart_fifo[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_fifo[0]\ = DFFE(!\inst9|inst|rx_uart_reg[0]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|rx_uart_fifo[4]~37\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst|rx_uart_reg[0]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|rx_uart_fifo[4]~37\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_fifo[0]\);

\inst9|inst5|i~137_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|i~137\ = \inst9|inst2|i~455\ & (\inst9|inst1|I4|ndre_x~1\ & !\inst9|inst12|cpu_daddr_c[0]\ # !\inst9|inst1|I4|ndre_x~1\ & !\inst9|inst12|cpu_daddr_x[0]~14\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2700",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ndre_x~1\,
	datab => \inst9|inst12|cpu_daddr_c[0]\,
	datac => \inst9|inst12|cpu_daddr_x[0]~14\,
	datad => \inst9|inst2|i~455\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst5|i~137\);

\inst9|inst2|i~45_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|i~45\ = !\inst9|inst12|i~115\ & \inst9|inst12|i~103\ & !\inst9|inst12|i~109\ & \inst9|inst5|i~137\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|i~115\,
	datab => \inst9|inst12|i~103\,
	datac => \inst9|inst12|i~109\,
	datad => \inst9|inst5|i~137\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|i~45\);

\inst9|inst2|tx_uart_busy~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_busy\ = DFFE(\inst9|inst2|i~45\ # \inst9|inst2|tx_uart_busy\ & (\inst9|inst2|tx_s\ # !\inst9|inst2|reduce_nor_7\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF8A",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_uart_busy\,
	datab => \inst9|inst2|tx_s\,
	datac => \inst9|inst2|reduce_nor_7\,
	datad => \inst9|inst2|i~45\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_busy\);

\inst9|inst12|i~356_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|i~356\ = \inst9|inst|rx_uart_fifo[0]\ & (\inst9|inst19|mux_c[1]\ # !\inst9|inst2|tx_uart_busy\) # !\inst9|inst|rx_uart_fifo[0]\ & !\inst9|inst19|mux_c[1]\ & !\inst9|inst2|tx_uart_busy\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0CF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst|rx_uart_fifo[0]\,
	datac => \inst9|inst19|mux_c[1]\,
	datad => \inst9|inst2|tx_uart_busy\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|i~356\);

\inst9|inst1|I3|data_x[0]~236_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[0]~236\ = \inst9|inst1|I3|data_x[2]~2293\ & (\inst9|inst19|Mux_13_rtl_0~0\ & \inst9|inst12|i~356\ # !\inst9|inst19|Mux_13_rtl_0~0\ & \inst9|inst15|lpm_ram_dq_component|sram|q[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E040",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst19|Mux_13_rtl_0~0\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[0]\,
	datac => \inst9|inst1|I3|data_x[2]~2293\,
	datad => \inst9|inst12|i~356\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[0]~236\);

\rtl~1759_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1759\ = !\inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|Mux_201_rtl_146~0\ & (\inst9|inst1|I3|data_x[0]~2144\ # \inst9|inst1|I3|data_x[0]~236\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5040",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[0]\,
	datab => \inst9|inst1|I3|data_x[0]~2144\,
	datac => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	datad => \inst9|inst1|I3|data_x[0]~236\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1759\);

\rtl~1761_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1761\ = \inst9|inst1|I3|acc_c[0][1]\ & !\inst9|inst1|I3|Mux_201_rtl_146~0\ & (\inst9|inst1|I2|TD_c[2]\ $ !\inst9|inst1|I2|TD_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2002",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][1]\,
	datab => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	datac => \inst9|inst1|I2|TD_c[2]\,
	datad => \inst9|inst1|I2|TD_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1761\);

\inst9|inst1|I3|data_x[0]~151_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[0]~151\ = \inst9|inst1|I3|reduce_nor_71\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I3|data_x[0]~145\ & \inst9|inst1|I4|i~616\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|reduce_nor_71\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I3|data_x[0]~145\,
	datad => \inst9|inst1|I4|i~616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[0]~151\);

\inst9|inst1|I3|data_x[0]~2140_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[0]~2140\ = \inst9|inst1|I3|data_x[0]~151\ # \inst9|inst1|I3|data_x[0]~236\ # \inst9|inst1|I2|data_is_c[0]\ & !\inst9|inst1|I3|reduce_nor_71\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|data_is_c[0]\,
	datab => \inst9|inst1|I3|reduce_nor_71\,
	datac => \inst9|inst1|I3|data_x[0]~151\,
	datad => \inst9|inst1|I3|data_x[0]~236\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[0]~2140\);

\inst9|inst1|I3|add_129~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_129~0\ = \inst9|inst1|I3|acc_c[0][0]\ $ \inst9|inst1|I3|data_x[0]~2140\
-- \inst9|inst1|I3|add_129~0COUT\ = CARRY(\inst9|inst1|I3|acc_c[0][0]\ & \inst9|inst1|I3|data_x[0]~2140\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	packed_mode => "false",
	lut_mask => "6688",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][0]\,
	datab => \inst9|inst1|I3|data_x[0]~2140\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_129~0\,
	cout => \inst9|inst1|I3|add_129~0COUT\);

\rtl~10455_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10455\ = \rtl~1761\ # \inst9|inst1|I3|Mux_201_rtl_146~0\ & \inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|add_129~0\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EAAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~1761\,
	datab => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	datac => \inst9|inst1|I2|TD_c[0]\,
	datad => \inst9|inst1|I3|add_129~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10455\);

\rtl~1765_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1765\ = \inst9|inst1|I2|TD_c[1]\ & !\inst9|inst1|I2|TD_c[2]\ & (\rtl~1759\ # \rtl~10455\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2220",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[1]\,
	datab => \inst9|inst1|I2|TD_c[2]\,
	datac => \rtl~1759\,
	datad => \rtl~10455\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1765\);

\rtl~2161_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2161\ = \inst9|inst1|I2|TD_c[1]\ & \inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I2|TD_c[0]\ & !\inst9|inst1|I3|acc_c[0][0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[1]\,
	datab => \inst9|inst1|I2|TD_c[2]\,
	datac => \inst9|inst1|I2|TD_c[0]\,
	datad => \inst9|inst1|I3|acc_c[0][0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2161\);

\rtl~2040_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2040\ = \inst9|inst1|I3|acc_c[0][0]\ & (\inst9|inst1|I2|TD_c[2]\ $ !\inst9|inst1|I2|TD_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C300",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|TD_c[2]\,
	datac => \inst9|inst1|I2|TD_c[0]\,
	datad => \inst9|inst1|I3|acc_c[0][0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2040\);

\inst9|inst1|I2|valid_x~23_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|valid_x~23\ = !\inst9|inst1|I2|skip_x~62\ & !\inst9|inst1|I2|E_x.iwait_e~1\ & (!\inst9|inst1|I2|skip_x~107\ # !\inst9|inst1|I2|skip_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0015",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|skip_x~62\,
	datab => \inst9|inst1|I2|skip_c\,
	datac => \inst9|inst1|I2|skip_x~107\,
	datad => \inst9|inst1|I2|E_x.iwait_e~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|valid_x~23\);

\inst9|inst1|I2|valid_x~7_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|valid_x~7\ = \inst9|inst1|I2|valid_x~23\ & (\inst9|inst1|I2|TC_x[1]~22\ # !\inst9|inst1|I2|C_raw~61\ # !\inst9|inst1|I2|C_raw~56\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F070",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|C_raw~56\,
	datab => \inst9|inst1|I2|C_raw~61\,
	datac => \inst9|inst1|I2|valid_x~23\,
	datad => \inst9|inst1|I2|TC_x[1]~22\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|valid_x~7\);

\inst9|inst1|I2|valid_c~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|valid_c\ = DFFE(\inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\ & (\inst9|inst1|I2|valid_x~7\ # \inst9|inst7\ & \inst9|inst1|I2|i~509\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CC80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datab => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datac => \inst9|inst1|I2|i~509\,
	datad => \inst9|inst1|I2|valid_x~7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|valid_c\);

\inst9|inst1|I3|i~147_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|i~147\ = \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[1]\ & \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A0A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[1]\,
	datac => \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|i~147\);

\inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|counter_cell[0]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[0]\ = DFFE((\inst9|inst1|I3|i~147\ & \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[0]\) # (!\inst9|inst1|I3|i~147\ & !\inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[0]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|counter_cell[0]~COUT\ = CARRY(\inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "qfbk_counter",
	packed_mode => "false",
	lut_mask => "0FF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[0]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst1|I3|i~147\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[0]\,
	cout => \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|counter_cell[0]~COUT\);

\inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|counter_cell[1]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[1]\ = DFFE((\inst9|inst1|I3|i~147\ & \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[1]\) # (!\inst9|inst1|I3|i~147\ & \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[1]\ $ \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|counter_cell[0]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5A5A",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[1]\,
	datac => \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[1]\,
	cin => \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|counter_cell[0]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst1|I3|i~147\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[1]\);

\inst9|inst1|I3|i~156_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|i~156\ = \inst9|inst1|I2|valid_c\ & \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[0]\
-- \inst9|inst1|I3|i~174\ = \inst9|inst1|I2|valid_c\ & \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|valid_c\,
	datab => \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|i~156\,
	cascout => \inst9|inst1|I3|i~174\);

\inst9|inst1|I3|acc[0][8]~4337_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc[0][8]~4337\ = \rtl~1694\ & \inst9|inst1|I3|i~156\ & (!\inst9|inst1|I2|i~509\ # !\inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2A00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~1694\,
	datab => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datac => \inst9|inst1|I2|i~509\,
	datad => \inst9|inst1|I3|i~156\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|acc[0][8]~4337\);

\inst9|inst1|I3|acc[0][8]~59_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc[0][8]~59\ = \inst9|inst1|I3|acc_c[0][8]\ & (\inst9|inst1|I3|i~173\ & !\rtl~1694\ # !\inst9|inst1|I3|i~173\ & \inst9|inst1|I3|i~147\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4C40",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~1694\,
	datab => \inst9|inst1|I3|acc_c[0][8]\,
	datac => \inst9|inst1|I3|i~173\,
	datad => \inst9|inst1|I3|i~147\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|acc[0][8]~59\);

\rtl~2426_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2426\ = \inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|acc_c[0][7]\ # !\inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|acc_c[0][0]\ & \inst9|inst1|I2|TD_c[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CAC0",
	output_mode => "none")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][0]\,
	datab => \inst9|inst1|I3|acc_c[0][7]\,
	datac => \inst9|inst1|I2|TD_c[0]\,
	datad => \inst9|inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	cascout => \rtl~2426\);

\rtl~10907_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10907\ = (!\inst9|inst1|I2|TD_c[2]\ & (\inst9|inst1|I2|TC_c[1]\ $ !\inst9|inst1|I2|TC_c[0]\)) & CASCADE(\rtl~2426\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00C3",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|TC_c[1]\,
	datac => \inst9|inst1|I2|TC_c[0]\,
	datad => \inst9|inst1|I2|TD_c[2]\,
	cascin => \rtl~2426\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10907\);

\rtl~2416_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2416\ = \inst9|inst1|I2|TD_c[2]\ $ (\inst9|inst1|I2|TC_c[0]\ $ \inst9|inst1|I2|TC_c[1]\ # !\inst9|inst1|I2|TD_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "9655",
	output_mode => "none")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[2]\,
	datab => \inst9|inst1|I2|TC_c[0]\,
	datac => \inst9|inst1|I2|TC_c[1]\,
	datad => \inst9|inst1|I2|TD_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	cascout => \rtl~2416\);

\rtl~10908_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10908\ = (!\inst9|inst1|I2|TD_c[1]\ & \inst9|inst1|I3|acc_c[0][8]\) & CASCADE(\rtl~2416\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0F00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst1|I2|TD_c[1]\,
	datad => \inst9|inst1|I3|acc_c[0][8]\,
	cascin => \rtl~2416\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10908\);

\rtl~10238_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10238\ = !\inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I2|TD_c[2]\ & (\inst9|inst1|I2|TC_c[0]\ $ \inst9|inst1|I2|TC_c[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "1020",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TC_c[0]\,
	datab => \inst9|inst1|I2|TD_c[0]\,
	datac => \inst9|inst1|I2|TD_c[2]\,
	datad => \inst9|inst1|I2|TC_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10238\);

\inst9|inst1|I3|data_x[6]~167_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[6]~167\ = \inst9|inst1|I4|reduce_nor_106\ & \inst9|inst1|I4|iinc_c[6]\ & \inst9|inst1|I2|ndre_x~41\ # !\inst9|inst1|I4|reduce_nor_106\ & \inst9|inst1|I4|ireg_c[6]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CA0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[6]\,
	datab => \inst9|inst1|I4|iinc_c[6]\,
	datac => \inst9|inst1|I4|reduce_nor_106\,
	datad => \inst9|inst1|I2|ndre_x~41\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[6]~167\);

\inst9|inst1|I3|data_x[6]~173_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[6]~173\ = \inst9|inst1|I3|reduce_nor_71\ & \inst9|inst1|I3|data_x[6]~167\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|i~616\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|reduce_nor_71\,
	datab => \inst9|inst1|I3|data_x[6]~167\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I4|i~616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[6]~173\);

\inst9|inst|Decoder_28~22_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|Decoder_28~22\ = \inst9|inst|rx_bit_count[1]\ & !\inst9|inst|rx_bit_count[0]\ & !\inst9|inst|rx_bit_count[3]\ & \inst9|inst|rx_bit_count[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0200",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_bit_count[1]\,
	datab => \inst9|inst|rx_bit_count[0]\,
	datac => \inst9|inst|rx_bit_count[3]\,
	datad => \inst9|inst|rx_bit_count[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|Decoder_28~22\);

\inst9|inst|rx_uart_reg[6]~6_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[6]~6\ = \inst9|inst|reduce_nor_7\ & \rtl~9986\ & !\inst9|inst|reduce_nor_27\ & \inst9|inst|Decoder_28~22\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|reduce_nor_7\,
	datab => \rtl~9986\,
	datac => \inst9|inst|reduce_nor_27\,
	datad => \inst9|inst|Decoder_28~22\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|rx_uart_reg[6]~6\);

\inst9|inst|rx_uart_reg[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[6]\ = DFFE(!\RXD~combout\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|rx_uart_reg[6]~6\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \RXD~combout\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|rx_uart_reg[6]~6\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_reg[6]\);

\inst9|inst|rx_uart_fifo[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_fifo[6]\ = DFFE(!\inst9|inst|rx_uart_reg[6]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|rx_uart_fifo[4]~37\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst|rx_uart_reg[6]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|rx_uart_fifo[4]~37\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_fifo[6]\);

\inst9|inst12|i~374_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|i~374\ = \inst9|inst|rx_uart_fifo[6]\ & \inst9|inst19|mux_c[1]\ & !\inst9|inst19|mux_c[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst|rx_uart_fifo[6]\,
	datac => \inst9|inst19|mux_c[1]\,
	datad => \inst9|inst19|mux_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|i~374\);

\inst9|inst1|I3|data_x[6]~256_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[6]~256\ = \inst9|inst1|I3|data_x[2]~2293\ & (\inst9|inst12|i~374\ # !\inst9|inst19|Mux_13_rtl_0~0\ & \inst9|inst15|lpm_ram_dq_component|sram|q[6]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst19|Mux_13_rtl_0~0\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[6]\,
	datac => \inst9|inst12|i~374\,
	datad => \inst9|inst1|I3|data_x[2]~2293\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[6]~256\);

\inst9|inst1|I3|data_x[6]~2206_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[6]~2206\ = \inst9|inst1|I3|data_x[6]~173\ # \inst9|inst1|I3|data_x[6]~256\ # \inst9|inst1|I2|data_is_c[6]\ & !\inst9|inst1|I3|reduce_nor_71\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFCE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|data_is_c[6]\,
	datab => \inst9|inst1|I3|data_x[6]~173\,
	datac => \inst9|inst1|I3|reduce_nor_71\,
	datad => \inst9|inst1|I3|data_x[6]~256\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[6]~2206\);

\inst9|inst1|I3|data_x[4]~112_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[4]~112\ = \inst9|inst1|I4|reduce_nor_106\ & \inst9|inst1|I4|iinc_c[4]\ & \inst9|inst1|I2|ndre_x~41\ # !\inst9|inst1|I4|reduce_nor_106\ & \inst9|inst1|I4|ireg_c[4]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CA0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[4]\,
	datab => \inst9|inst1|I4|iinc_c[4]\,
	datac => \inst9|inst1|I4|reduce_nor_106\,
	datad => \inst9|inst1|I2|ndre_x~41\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[4]~112\);

\inst9|inst1|I3|data_x[4]~118_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[4]~118\ = \inst9|inst1|I4|i~18\ & \inst9|inst1|I3|reduce_nor_71\ & \inst9|inst1|I3|data_x[4]~112\ & \inst9|inst1|I4|i~616\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~18\,
	datab => \inst9|inst1|I3|reduce_nor_71\,
	datac => \inst9|inst1|I3|data_x[4]~112\,
	datad => \inst9|inst1|I4|i~616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[4]~118\);

\inst9|inst|Decoder_28~20_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|Decoder_28~20\ = !\inst9|inst|rx_bit_count[1]\ & !\inst9|inst|rx_bit_count[0]\ & \inst9|inst|rx_bit_count[2]\ & !\inst9|inst|rx_bit_count[3]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0010",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_bit_count[1]\,
	datab => \inst9|inst|rx_bit_count[0]\,
	datac => \inst9|inst|rx_bit_count[2]\,
	datad => \inst9|inst|rx_bit_count[3]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|Decoder_28~20\);

\inst9|inst|rx_uart_reg[4]~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[4]~1\ = !\inst9|inst|reduce_nor_27\ & \inst9|inst|reduce_nor_7\ & \inst9|inst|Decoder_28~20\ & \rtl~9986\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|reduce_nor_27\,
	datab => \inst9|inst|reduce_nor_7\,
	datac => \inst9|inst|Decoder_28~20\,
	datad => \rtl~9986\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|rx_uart_reg[4]~1\);

\inst9|inst|rx_uart_reg[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[4]\ = DFFE(!\RXD~combout\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|rx_uart_reg[4]~1\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \RXD~combout\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|rx_uart_reg[4]~1\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_reg[4]\);

\inst9|inst|rx_uart_fifo[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_fifo[4]\ = DFFE(!\inst9|inst|rx_uart_reg[4]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|rx_uart_fifo[4]~37\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst|rx_uart_reg[4]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|rx_uart_fifo[4]~37\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_fifo[4]\);

\inst9|inst12|i~332_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|i~332\ = !\inst9|inst19|mux_c[0]\ & \inst9|inst19|mux_c[1]\ & \inst9|inst|rx_uart_fifo[4]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst19|mux_c[0]\,
	datac => \inst9|inst19|mux_c[1]\,
	datad => \inst9|inst|rx_uart_fifo[4]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|i~332\);

\inst9|inst1|I3|data_x[4]~206_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[4]~206\ = \inst9|inst1|I3|data_x[2]~2293\ & (\inst9|inst12|i~332\ # !\inst9|inst19|Mux_13_rtl_0~0\ & \inst9|inst15|lpm_ram_dq_component|sram|q[4]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BA00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|i~332\,
	datab => \inst9|inst19|Mux_13_rtl_0~0\,
	datac => \inst9|inst15|lpm_ram_dq_component|sram|q[4]\,
	datad => \inst9|inst1|I3|data_x[2]~2293\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[4]~206\);

\inst9|inst1|I3|data_x[4]~2041_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[4]~2041\ = \inst9|inst1|I3|data_x[4]~118\ # \inst9|inst1|I3|data_x[4]~206\ # \inst9|inst1|I2|data_is_c[4]\ & !\inst9|inst1|I3|reduce_nor_71\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|data_is_c[4]\,
	datab => \inst9|inst1|I3|reduce_nor_71\,
	datac => \inst9|inst1|I3|data_x[4]~118\,
	datad => \inst9|inst1|I3|data_x[4]~206\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[4]~2041\);

\inst9|inst|Decoder_28~19_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|Decoder_28~19\ = \inst9|inst|rx_bit_count[0]\ & \inst9|inst|rx_bit_count[1]\ & !\inst9|inst|rx_bit_count[3]\ & !\inst9|inst|rx_bit_count[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0008",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_bit_count[0]\,
	datab => \inst9|inst|rx_bit_count[1]\,
	datac => \inst9|inst|rx_bit_count[3]\,
	datad => \inst9|inst|rx_bit_count[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|Decoder_28~19\);

\inst9|inst|rx_uart_reg[3]~3_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[3]~3\ = !\inst9|inst|reduce_nor_27\ & \rtl~9986\ & \inst9|inst|reduce_nor_7\ & \inst9|inst|Decoder_28~19\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|reduce_nor_27\,
	datab => \rtl~9986\,
	datac => \inst9|inst|reduce_nor_7\,
	datad => \inst9|inst|Decoder_28~19\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|rx_uart_reg[3]~3\);

\inst9|inst|rx_uart_reg[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[3]\ = DFFE(!\RXD~combout\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|rx_uart_reg[3]~3\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \RXD~combout\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|rx_uart_reg[3]~3\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_reg[3]\);

\inst9|inst|rx_uart_fifo[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_fifo[3]\ = DFFE(!\inst9|inst|rx_uart_reg[3]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|rx_uart_fifo[4]~37\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst|rx_uart_reg[3]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|rx_uart_fifo[4]~37\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_fifo[3]\);

\inst9|inst12|i~346_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|i~346\ = \inst9|inst19|mux_c[1]\ & \inst9|inst|rx_uart_fifo[3]\ # !\inst9|inst19|mux_c[1]\ & \inst9|inst5|int_pending_c[3]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EE44",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst19|mux_c[1]\,
	datab => \inst9|inst5|int_pending_c[3]\,
	datad => \inst9|inst|rx_uart_fifo[3]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|i~346\);

\inst9|inst1|I3|data_x[3]~226_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[3]~226\ = \inst9|inst1|I3|data_x[2]~2293\ & (\inst9|inst19|Mux_13_rtl_0~0\ & \inst9|inst12|i~346\ # !\inst9|inst19|Mux_13_rtl_0~0\ & \inst9|inst15|lpm_ram_dq_component|sram|q[3]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E200",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst15|lpm_ram_dq_component|sram|q[3]\,
	datab => \inst9|inst19|Mux_13_rtl_0~0\,
	datac => \inst9|inst12|i~346\,
	datad => \inst9|inst1|I3|data_x[2]~2293\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[3]~226\);

\inst9|inst1|I3|data_x[3]~134_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[3]~134\ = \inst9|inst1|I4|reduce_nor_106\ & \inst9|inst1|I4|iinc_c[3]\ & \inst9|inst1|I2|ndre_x~41\ # !\inst9|inst1|I4|reduce_nor_106\ & \inst9|inst1|I4|ireg_c[3]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E222",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[3]\,
	datab => \inst9|inst1|I4|reduce_nor_106\,
	datac => \inst9|inst1|I4|iinc_c[3]\,
	datad => \inst9|inst1|I2|ndre_x~41\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[3]~134\);

\inst9|inst1|I3|data_x[3]~140_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[3]~140\ = \inst9|inst1|I4|i~18\ & \inst9|inst1|I3|reduce_nor_71\ & \inst9|inst1|I3|data_x[3]~134\ & \inst9|inst1|I4|i~616\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~18\,
	datab => \inst9|inst1|I3|reduce_nor_71\,
	datac => \inst9|inst1|I3|data_x[3]~134\,
	datad => \inst9|inst1|I4|i~616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[3]~140\);

\inst9|inst1|I3|data_x[3]~2107_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[3]~2107\ = \inst9|inst1|I3|data_x[3]~226\ # \inst9|inst1|I3|data_x[3]~140\ # \inst9|inst1|I2|data_is_c[3]\ & !\inst9|inst1|I3|reduce_nor_71\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|data_is_c[3]\,
	datab => \inst9|inst1|I3|reduce_nor_71\,
	datac => \inst9|inst1|I3|data_x[3]~226\,
	datad => \inst9|inst1|I3|data_x[3]~140\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[3]~2107\);

\inst9|inst|rx_uart_fifo[4]~44_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_fifo[4]~44\ = (!\inst9|inst|rx_8_count[1]\ & !\inst9|inst|rx_8_count[2]\) & CASCADE(\inst9|inst|rx_uart_fifo[4]~45\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0505",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_8_count[1]\,
	datac => \inst9|inst|rx_8_count[2]\,
	cascin => \inst9|inst|rx_uart_fifo[4]~45\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|rx_uart_fifo[4]~44\);

\inst9|inst12|ndre_c~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|ndre_c\ = DFFE(\inst9|inst1|I4|i~18\ & \inst9|inst1|I2|ndre_x~41\ & (!\inst9|inst1|I4|i~800\ # !\inst9|inst1|I4|i~815\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst12|reduce_or_73\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2A00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~18\,
	datab => \inst9|inst1|I4|i~815\,
	datac => \inst9|inst1|I4|i~800\,
	datad => \inst9|inst1|I2|ndre_x~41\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst12|reduce_or_73\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst12|ndre_c\);

\inst9|inst12|i~127_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|i~127\ = \inst9|inst12|cpu_daddr_c[0]\ & (\inst9|inst1|I4|ndre_x~1\ # \inst9|inst12|cpu_daddr_x[0]~14\) # !\inst9|inst12|cpu_daddr_c[0]\ & !\inst9|inst1|I4|ndre_x~1\ & \inst9|inst12|cpu_daddr_x[0]~14\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AFA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|cpu_daddr_c[0]\,
	datac => \inst9|inst1|I4|ndre_x~1\,
	datad => \inst9|inst12|cpu_daddr_x[0]~14\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|i~127\);

\rtl~10839_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10839\ = !\inst9|inst12|ndwe_c\ & \inst9|inst12|i~127\ # !\inst9|inst7\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5F0F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|ndwe_c\,
	datac => \inst9|inst7\,
	datad => \inst9|inst12|i~127\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10839\);

\inst9|inst19|mux_x[1]~4_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst19|mux_x[1]~4\ = !\inst9|inst12|i~103\ & \inst9|inst12|i~121\ & \inst9|inst12|i~109\ & !\inst9|inst12|i~115\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0040",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|i~103\,
	datab => \inst9|inst12|i~121\,
	datac => \inst9|inst12|i~109\,
	datad => \inst9|inst12|i~115\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst19|mux_x[1]~4\);

\inst9|inst|rx_uart_full_c~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_full_c\ = DFFE(!\rtl~10839\ & \inst9|inst19|mux_x[1]~4\ & (\inst9|inst12|ndre_c\ # \inst9|inst12|i~127\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0E00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|ndre_c\,
	datab => \inst9|inst12|i~127\,
	datac => \rtl~10839\,
	datad => \inst9|inst19|mux_x[1]~4\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_full_c\);

\inst9|inst|rx_uart_full_s~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_full_s\ = DFFE(\inst9|inst|reduce_nor_7\ & \inst9|inst|rx_uart_fifo[4]~44\ & (!\inst9|inst|add_72~52\ # !\inst9|inst|rx_8_count[2]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "20A0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|reduce_nor_7\,
	datab => \inst9|inst|rx_8_count[2]\,
	datac => \inst9|inst|rx_uart_fifo[4]~44\,
	datad => \inst9|inst|add_72~52\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_full_s\);

\inst9|inst|rx_uart_full_d~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_full_d\ = DFFE(\inst9|inst|rx_uart_full_s\ # !\inst9|inst|rx_uart_full_c\ & \inst9|inst|rx_uart_full_d\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F5F0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_uart_full_c\,
	datac => \inst9|inst|rx_uart_full_s\,
	datad => \inst9|inst|rx_uart_full_d\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_full_d\);

\inst9|inst|rx_uart_ovr_s~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_ovr_s\ = DFFE(\inst9|inst|reduce_nor_7\ & \inst9|inst|rx_uart_fifo[4]~44\ & \inst9|inst|rx_uart_full_d\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst|reduce_nor_7\,
	datac => \inst9|inst|rx_uart_fifo[4]~44\,
	datad => \inst9|inst|rx_uart_full_d\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_ovr_s\);

\inst9|inst|rx_uart_ovr_d~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_ovr_d\ = DFFE(\inst9|inst|rx_uart_ovr_s\ # \inst9|inst|rx_uart_ovr_d\ & !\inst9|inst|rx_uart_full_c\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0FA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_uart_ovr_d\,
	datac => \inst9|inst|rx_uart_ovr_s\,
	datad => \inst9|inst|rx_uart_full_c\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_ovr_d\);

\inst9|inst|Decoder_28~18_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|Decoder_28~18\ = \inst9|inst|rx_bit_count[1]\ & !\inst9|inst|rx_bit_count[0]\ & !\inst9|inst|rx_bit_count[3]\ & !\inst9|inst|rx_bit_count[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0002",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_bit_count[1]\,
	datab => \inst9|inst|rx_bit_count[0]\,
	datac => \inst9|inst|rx_bit_count[3]\,
	datad => \inst9|inst|rx_bit_count[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|Decoder_28~18\);

\inst9|inst|rx_uart_reg[2]~2_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[2]~2\ = \inst9|inst|reduce_nor_7\ & \rtl~9986\ & !\inst9|inst|reduce_nor_27\ & \inst9|inst|Decoder_28~18\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|reduce_nor_7\,
	datab => \rtl~9986\,
	datac => \inst9|inst|reduce_nor_27\,
	datad => \inst9|inst|Decoder_28~18\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|rx_uart_reg[2]~2\);

\inst9|inst|rx_uart_reg[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[2]\ = DFFE(!\RXD~combout\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|rx_uart_reg[2]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \RXD~combout\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|rx_uart_reg[2]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_reg[2]\);

\inst9|inst|rx_uart_fifo[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_fifo[2]\ = DFFE(!\inst9|inst|rx_uart_reg[2]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|rx_uart_fifo[4]~37\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst|rx_uart_reg[2]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|rx_uart_fifo[4]~37\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_fifo[2]\);

\inst9|inst12|i~1197_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|i~1197\ = (\inst9|inst19|mux_c[1]\ & \inst9|inst|rx_uart_fifo[2]\ # !\inst9|inst19|mux_c[1]\ & \inst9|inst|rx_uart_ovr_d\ & !\inst9|inst|rx_uart_full_c\) & CASCADE(\inst9|inst19|Mux_13_rtl_0~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0CA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_uart_ovr_d\,
	datab => \inst9|inst|rx_uart_fifo[2]\,
	datac => \inst9|inst19|mux_c[1]\,
	datad => \inst9|inst|rx_uart_full_c\,
	cascin => \inst9|inst19|Mux_13_rtl_0~2\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|i~1197\);

\inst9|inst1|I3|data_x[2]~216_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[2]~216\ = \inst9|inst1|I3|data_x[2]~2293\ & (\inst9|inst12|i~1197\ # !\inst9|inst19|Mux_13_rtl_0~0\ & \inst9|inst15|lpm_ram_dq_component|sram|q[2]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BA00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|i~1197\,
	datab => \inst9|inst19|Mux_13_rtl_0~0\,
	datac => \inst9|inst15|lpm_ram_dq_component|sram|q[2]\,
	datad => \inst9|inst1|I3|data_x[2]~2293\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[2]~216\);

\inst9|inst1|I3|data_x[2]~123_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[2]~123\ = \inst9|inst1|I4|reduce_nor_106\ & \inst9|inst1|I4|iinc_c[2]\ & \inst9|inst1|I2|ndre_x~41\ # !\inst9|inst1|I4|reduce_nor_106\ & \inst9|inst1|I4|ireg_c[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CA0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[2]\,
	datab => \inst9|inst1|I4|iinc_c[2]\,
	datac => \inst9|inst1|I4|reduce_nor_106\,
	datad => \inst9|inst1|I2|ndre_x~41\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[2]~123\);

\inst9|inst1|I3|data_x[2]~129_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[2]~129\ = \inst9|inst1|I3|reduce_nor_71\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I3|data_x[2]~123\ & \inst9|inst1|I4|i~616\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|reduce_nor_71\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I3|data_x[2]~123\,
	datad => \inst9|inst1|I4|i~616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[2]~129\);

\inst9|inst1|I3|data_x[2]~2074_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[2]~2074\ = \inst9|inst1|I3|data_x[2]~216\ # \inst9|inst1|I3|data_x[2]~129\ # \inst9|inst1|I2|data_is_c[2]\ & !\inst9|inst1|I3|reduce_nor_71\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|data_is_c[2]\,
	datab => \inst9|inst1|I3|reduce_nor_71\,
	datac => \inst9|inst1|I3|data_x[2]~216\,
	datad => \inst9|inst1|I3|data_x[2]~129\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[2]~2074\);

\inst9|inst1|I3|add_129~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_129~1\ = \inst9|inst1|I3|data_x[1]~2272\ $ \inst9|inst1|I3|acc_c[0][1]\ $ \inst9|inst1|I3|add_129~0COUT\
-- \inst9|inst1|I3|add_129~1COUT\ = CARRY(\inst9|inst1|I3|data_x[1]~2272\ & !\inst9|inst1|I3|acc_c[0][1]\ & !\inst9|inst1|I3|add_129~0COUT\ # !\inst9|inst1|I3|data_x[1]~2272\ & (!\inst9|inst1|I3|add_129~0COUT\ # !\inst9|inst1|I3|acc_c[0][1]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "9617",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|data_x[1]~2272\,
	datab => \inst9|inst1|I3|acc_c[0][1]\,
	cin => \inst9|inst1|I3|add_129~0COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_129~1\,
	cout => \inst9|inst1|I3|add_129~1COUT\);

\inst9|inst1|I3|add_129~2_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_129~2\ = \inst9|inst1|I3|data_x[2]~2074\ $ \inst9|inst1|I3|acc_c[0][2]\ $ !\inst9|inst1|I3|add_129~1COUT\
-- \inst9|inst1|I3|add_129~2COUT\ = CARRY(\inst9|inst1|I3|data_x[2]~2074\ & (\inst9|inst1|I3|acc_c[0][2]\ # !\inst9|inst1|I3|add_129~1COUT\) # !\inst9|inst1|I3|data_x[2]~2074\ & \inst9|inst1|I3|acc_c[0][2]\ & !\inst9|inst1|I3|add_129~1COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "698E",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|data_x[2]~2074\,
	datab => \inst9|inst1|I3|acc_c[0][2]\,
	cin => \inst9|inst1|I3|add_129~1COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_129~2\,
	cout => \inst9|inst1|I3|add_129~2COUT\);

\inst9|inst1|I3|add_129~3_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_129~3\ = \inst9|inst1|I3|data_x[3]~2107\ $ \inst9|inst1|I3|acc_c[0][3]\ $ \inst9|inst1|I3|add_129~2COUT\
-- \inst9|inst1|I3|add_129~3COUT\ = CARRY(\inst9|inst1|I3|data_x[3]~2107\ & !\inst9|inst1|I3|acc_c[0][3]\ & !\inst9|inst1|I3|add_129~2COUT\ # !\inst9|inst1|I3|data_x[3]~2107\ & (!\inst9|inst1|I3|add_129~2COUT\ # !\inst9|inst1|I3|acc_c[0][3]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "9617",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|data_x[3]~2107\,
	datab => \inst9|inst1|I3|acc_c[0][3]\,
	cin => \inst9|inst1|I3|add_129~2COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_129~3\,
	cout => \inst9|inst1|I3|add_129~3COUT\);

\inst9|inst1|I3|add_129~4_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_129~4\ = \inst9|inst1|I3|data_x[4]~2041\ $ \inst9|inst1|I3|acc_c[0][4]\ $ !\inst9|inst1|I3|add_129~3COUT\
-- \inst9|inst1|I3|add_129~4COUT\ = CARRY(\inst9|inst1|I3|data_x[4]~2041\ & (\inst9|inst1|I3|acc_c[0][4]\ # !\inst9|inst1|I3|add_129~3COUT\) # !\inst9|inst1|I3|data_x[4]~2041\ & \inst9|inst1|I3|acc_c[0][4]\ & !\inst9|inst1|I3|add_129~3COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "698E",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|data_x[4]~2041\,
	datab => \inst9|inst1|I3|acc_c[0][4]\,
	cin => \inst9|inst1|I3|add_129~3COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_129~4\,
	cout => \inst9|inst1|I3|add_129~4COUT\);

\inst9|inst1|I3|add_129~5_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_129~5\ = \inst9|inst1|I3|data_x[5]~2239\ $ \inst9|inst1|I3|acc_c[0][5]\ $ \inst9|inst1|I3|add_129~4COUT\
-- \inst9|inst1|I3|add_129~5COUT\ = CARRY(\inst9|inst1|I3|data_x[5]~2239\ & !\inst9|inst1|I3|acc_c[0][5]\ & !\inst9|inst1|I3|add_129~4COUT\ # !\inst9|inst1|I3|data_x[5]~2239\ & (!\inst9|inst1|I3|add_129~4COUT\ # !\inst9|inst1|I3|acc_c[0][5]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "9617",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|data_x[5]~2239\,
	datab => \inst9|inst1|I3|acc_c[0][5]\,
	cin => \inst9|inst1|I3|add_129~4COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_129~5\,
	cout => \inst9|inst1|I3|add_129~5COUT\);

\inst9|inst1|I3|add_129~6_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_129~6\ = \inst9|inst1|I3|acc_c[0][6]\ $ \inst9|inst1|I3|data_x[6]~2206\ $ !\inst9|inst1|I3|add_129~5COUT\
-- \inst9|inst1|I3|add_129~6COUT\ = CARRY(\inst9|inst1|I3|acc_c[0][6]\ & (\inst9|inst1|I3|data_x[6]~2206\ # !\inst9|inst1|I3|add_129~5COUT\) # !\inst9|inst1|I3|acc_c[0][6]\ & \inst9|inst1|I3|data_x[6]~2206\ & !\inst9|inst1|I3|add_129~5COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "698E",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][6]\,
	datab => \inst9|inst1|I3|data_x[6]~2206\,
	cin => \inst9|inst1|I3|add_129~5COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_129~6\,
	cout => \inst9|inst1|I3|add_129~6COUT\);

\inst9|inst1|I3|add_129~7_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_129~7\ = \inst9|inst1|I3|acc_c[0][7]\ $ \inst9|inst1|I3|data_x[7]~2173\ $ \inst9|inst1|I3|add_129~6COUT\
-- \inst9|inst1|I3|add_129~7COUT\ = CARRY(\inst9|inst1|I3|acc_c[0][7]\ & !\inst9|inst1|I3|data_x[7]~2173\ & !\inst9|inst1|I3|add_129~6COUT\ # !\inst9|inst1|I3|acc_c[0][7]\ & (!\inst9|inst1|I3|add_129~6COUT\ # !\inst9|inst1|I3|data_x[7]~2173\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "9617",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][7]\,
	datab => \inst9|inst1|I3|data_x[7]~2173\,
	cin => \inst9|inst1|I3|add_129~6COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_129~7\,
	cout => \inst9|inst1|I3|add_129~7COUT\);

\inst9|inst1|I3|add_129~8_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_129~8\ = !\inst9|inst1|I3|add_129~7COUT\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "0F0F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	cin => \inst9|inst1|I3|add_129~7COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_129~8\);

\inst9|inst1|I3|add_153~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_153~1\ = \inst9|inst1|I3|acc_c[0][0]\ $ \inst9|inst1|I3|data_x[0]~2140\
-- \inst9|inst1|I3|add_153~1COUT\ = CARRY(\inst9|inst1|I3|acc_c[0][0]\ # !\inst9|inst1|I3|data_x[0]~2140\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	packed_mode => "false",
	lut_mask => "66BB",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][0]\,
	datab => \inst9|inst1|I3|data_x[0]~2140\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_153~1\,
	cout => \inst9|inst1|I3|add_153~1COUT\);

\inst9|inst1|I3|add_153~2_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_153~2\ = \inst9|inst1|I3|acc_c[0][1]\ $ \inst9|inst1|I3|data_x[1]~2272\ $ !\inst9|inst1|I3|add_153~1COUT\
-- \inst9|inst1|I3|add_153~2COUT\ = CARRY(\inst9|inst1|I3|acc_c[0][1]\ & \inst9|inst1|I3|data_x[1]~2272\ & !\inst9|inst1|I3|add_153~1COUT\ # !\inst9|inst1|I3|acc_c[0][1]\ & (\inst9|inst1|I3|data_x[1]~2272\ # !\inst9|inst1|I3|add_153~1COUT\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "694D",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][1]\,
	datab => \inst9|inst1|I3|data_x[1]~2272\,
	cin => \inst9|inst1|I3|add_153~1COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_153~2\,
	cout => \inst9|inst1|I3|add_153~2COUT\);

\inst9|inst1|I3|add_153~3_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_153~3\ = \inst9|inst1|I3|acc_c[0][2]\ $ \inst9|inst1|I3|data_x[2]~2074\ $ \inst9|inst1|I3|add_153~2COUT\
-- \inst9|inst1|I3|add_153~3COUT\ = CARRY(\inst9|inst1|I3|acc_c[0][2]\ & (!\inst9|inst1|I3|add_153~2COUT\ # !\inst9|inst1|I3|data_x[2]~2074\) # !\inst9|inst1|I3|acc_c[0][2]\ & !\inst9|inst1|I3|data_x[2]~2074\ & !\inst9|inst1|I3|add_153~2COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "962B",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][2]\,
	datab => \inst9|inst1|I3|data_x[2]~2074\,
	cin => \inst9|inst1|I3|add_153~2COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_153~3\,
	cout => \inst9|inst1|I3|add_153~3COUT\);

\inst9|inst1|I3|add_153~4_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_153~4\ = \inst9|inst1|I3|acc_c[0][3]\ $ \inst9|inst1|I3|data_x[3]~2107\ $ !\inst9|inst1|I3|add_153~3COUT\
-- \inst9|inst1|I3|add_153~4COUT\ = CARRY(\inst9|inst1|I3|acc_c[0][3]\ & \inst9|inst1|I3|data_x[3]~2107\ & !\inst9|inst1|I3|add_153~3COUT\ # !\inst9|inst1|I3|acc_c[0][3]\ & (\inst9|inst1|I3|data_x[3]~2107\ # !\inst9|inst1|I3|add_153~3COUT\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "694D",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][3]\,
	datab => \inst9|inst1|I3|data_x[3]~2107\,
	cin => \inst9|inst1|I3|add_153~3COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_153~4\,
	cout => \inst9|inst1|I3|add_153~4COUT\);

\inst9|inst1|I3|add_153~5_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_153~5\ = \inst9|inst1|I3|data_x[4]~2041\ $ \inst9|inst1|I3|acc_c[0][4]\ $ \inst9|inst1|I3|add_153~4COUT\
-- \inst9|inst1|I3|add_153~5COUT\ = CARRY(\inst9|inst1|I3|data_x[4]~2041\ & \inst9|inst1|I3|acc_c[0][4]\ & !\inst9|inst1|I3|add_153~4COUT\ # !\inst9|inst1|I3|data_x[4]~2041\ & (\inst9|inst1|I3|acc_c[0][4]\ # !\inst9|inst1|I3|add_153~4COUT\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "964D",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|data_x[4]~2041\,
	datab => \inst9|inst1|I3|acc_c[0][4]\,
	cin => \inst9|inst1|I3|add_153~4COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_153~5\,
	cout => \inst9|inst1|I3|add_153~5COUT\);

\inst9|inst1|I3|add_153~6_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_153~6\ = \inst9|inst1|I3|acc_c[0][5]\ $ \inst9|inst1|I3|data_x[5]~2239\ $ !\inst9|inst1|I3|add_153~5COUT\
-- \inst9|inst1|I3|add_153~6COUT\ = CARRY(\inst9|inst1|I3|acc_c[0][5]\ & \inst9|inst1|I3|data_x[5]~2239\ & !\inst9|inst1|I3|add_153~5COUT\ # !\inst9|inst1|I3|acc_c[0][5]\ & (\inst9|inst1|I3|data_x[5]~2239\ # !\inst9|inst1|I3|add_153~5COUT\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "694D",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][5]\,
	datab => \inst9|inst1|I3|data_x[5]~2239\,
	cin => \inst9|inst1|I3|add_153~5COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_153~6\,
	cout => \inst9|inst1|I3|add_153~6COUT\);

\inst9|inst1|I3|add_153~7_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_153~7\ = \inst9|inst1|I3|acc_c[0][6]\ $ \inst9|inst1|I3|data_x[6]~2206\ $ \inst9|inst1|I3|add_153~6COUT\
-- \inst9|inst1|I3|add_153~7COUT\ = CARRY(\inst9|inst1|I3|acc_c[0][6]\ & (!\inst9|inst1|I3|add_153~6COUT\ # !\inst9|inst1|I3|data_x[6]~2206\) # !\inst9|inst1|I3|acc_c[0][6]\ & !\inst9|inst1|I3|data_x[6]~2206\ & !\inst9|inst1|I3|add_153~6COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "962B",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][6]\,
	datab => \inst9|inst1|I3|data_x[6]~2206\,
	cin => \inst9|inst1|I3|add_153~6COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_153~7\,
	cout => \inst9|inst1|I3|add_153~7COUT\);

\inst9|inst1|I3|add_153~8_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_153~8\ = \inst9|inst1|I3|acc_c[0][7]\ $ \inst9|inst1|I3|data_x[7]~2173\ $ !\inst9|inst1|I3|add_153~7COUT\
-- \inst9|inst1|I3|add_153~8COUT\ = CARRY(\inst9|inst1|I3|acc_c[0][7]\ & \inst9|inst1|I3|data_x[7]~2173\ & !\inst9|inst1|I3|add_153~7COUT\ # !\inst9|inst1|I3|acc_c[0][7]\ & (\inst9|inst1|I3|data_x[7]~2173\ # !\inst9|inst1|I3|add_153~7COUT\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "694D",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][7]\,
	datab => \inst9|inst1|I3|data_x[7]~2173\,
	cin => \inst9|inst1|I3|add_153~7COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_153~8\,
	cout => \inst9|inst1|I3|add_153~8COUT\);

\inst9|inst1|I3|add_153~9_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|add_153~9\ = !\inst9|inst1|I3|add_153~8COUT\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "0F0F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	cin => \inst9|inst1|I3|add_153~8COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|add_153~9\);

\rtl~2433_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2433\ = \rtl~10238\ & (\inst9|inst1|I2|TD_c[1]\ & !\inst9|inst1|I3|add_153~9\ # !\inst9|inst1|I2|TD_c[1]\ & \inst9|inst1|I3|add_129~8\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "20A8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~10238\,
	datab => \inst9|inst1|I2|TD_c[1]\,
	datac => \inst9|inst1|I3|add_129~8\,
	datad => \inst9|inst1|I3|add_153~9\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2433\);

\rtl~2218_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2218\ = !\inst9|inst1|I2|TC_c[2]\ & (\rtl~10907\ # \rtl~10908\ # \rtl~2433\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0F0E",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~10907\,
	datab => \rtl~10908\,
	datac => \inst9|inst1|I2|TC_c[2]\,
	datad => \rtl~2433\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2218\);

\inst9|inst1|I3|acc_i[0][8]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_i[0][8]\ = DFFE(\inst9|inst1|I3|acc[0][8]~59\ # \inst9|inst1|I3|acc[0][8]~4337\ & (\rtl~432\ # \rtl~2218\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst1|I2|int_start_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FCF8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~432\,
	datab => \inst9|inst1|I3|acc[0][8]~4337\,
	datac => \inst9|inst1|I3|acc[0][8]~59\,
	datad => \rtl~2218\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_i[0][8]\);

\rtl~432_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~432\ = \inst9|inst1|I2|TC_c[2]\ & \inst9|inst1|I3|acc_i[0][8]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|TC_c[2]\,
	datac => \inst9|inst1|I3|acc_i[0][8]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~432\);

\inst9|inst1|I3|acc_c[0][8]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_c[0][8]\ = DFFE(\inst9|inst1|I3|acc[0][8]~59\ # \inst9|inst1|I3|acc[0][8]~4337\ & (\rtl~432\ # \rtl~2218\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FCF8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~432\,
	datab => \inst9|inst1|I3|acc[0][8]~4337\,
	datac => \inst9|inst1|I3|acc[0][8]~59\,
	datad => \rtl~2218\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_c[0][8]\);

\rtl~2156_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2156\ = \inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|acc_c[0][8]\ & !\inst9|inst1|I2|TD_c[2]\ # !\inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|acc_c[0][1]\ & \inst9|inst1|I2|TD_c[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0CA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][8]\,
	datab => \inst9|inst1|I3|acc_c[0][1]\,
	datac => \inst9|inst1|I2|TD_c[0]\,
	datad => \inst9|inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2156\);

\rtl~2160_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2160\ = \rtl~2161\ # !\inst9|inst1|I2|TD_c[1]\ & (\rtl~2040\ # \rtl~2156\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AFAE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~2161\,
	datab => \rtl~2040\,
	datac => \inst9|inst1|I2|TD_c[1]\,
	datad => \rtl~2156\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2160\);

\rtl~2166_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2166\ = \rtl~2160\ & (\inst9|inst1|I2|TC_c[0]\ $ !\inst9|inst1|I2|TC_c[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C300",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|TC_c[0]\,
	datac => \inst9|inst1|I2|TC_c[1]\,
	datad => \rtl~2160\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2166\);

\rtl~9988_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~9988\ = \inst9|inst1|I2|TD_c[2]\ & (\inst9|inst1|I2|TC_c[1]\ $ \inst9|inst1|I2|TC_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "6060",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TC_c[1]\,
	datab => \inst9|inst1|I2|TC_c[0]\,
	datac => \inst9|inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~9988\);

\rtl~1286_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1286\ = !\inst9|inst1|I2|TD_c[1]\ & !\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][0]\ & \inst9|inst1|I3|Mux_201_rtl_146~0\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "1000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[1]\,
	datab => \inst9|inst1|I2|TD_c[2]\,
	datac => \inst9|inst1|I3|acc_c[0][0]\,
	datad => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1286\);

\inst9|inst1|I3|Mux_178_rtl_109_rtl_345~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|Mux_178_rtl_109_rtl_345~0\ = \inst9|inst1|I2|TD_c[1]\ & (\inst9|inst1|I2|TD_c[0]\ # \inst9|inst1|I3|add_153~1\) # !\inst9|inst1|I2|TD_c[1]\ & !\inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|add_129~0\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BA98",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[1]\,
	datab => \inst9|inst1|I2|TD_c[0]\,
	datac => \inst9|inst1|I3|add_129~0\,
	datad => \inst9|inst1|I3|add_153~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|Mux_178_rtl_109_rtl_345~0\);

\inst9|inst1|I3|Mux_178_rtl_109_rtl_345~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|Mux_178_rtl_109_rtl_345~1\ = \inst9|inst1|I3|data_x[0]~2140\ & (\inst9|inst1|I3|Mux_178_rtl_109_rtl_345~0\ # \inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|acc_c[0][0]\) # !\inst9|inst1|I3|data_x[0]~2140\ & \inst9|inst1|I3|Mux_178_rtl_109_rtl_345~0\ & (\inst9|inst1|I3|acc_c[0][0]\ # !\inst9|inst1|I2|TD_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FD80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[0]\,
	datab => \inst9|inst1|I3|data_x[0]~2140\,
	datac => \inst9|inst1|I3|acc_c[0][0]\,
	datad => \inst9|inst1|I3|Mux_178_rtl_109_rtl_345~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|Mux_178_rtl_109_rtl_345~1\);

\rtl~10487_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10487\ = \rtl~2166\ # \rtl~1286\ # \rtl~9988\ & \inst9|inst1|I3|Mux_178_rtl_109_rtl_345~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FEFA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~2166\,
	datab => \rtl~9988\,
	datac => \rtl~1286\,
	datad => \inst9|inst1|I3|Mux_178_rtl_109_rtl_345~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10487\);

\inst9|inst1|I3|acc_i[0][0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_i[0][0]\ = DFFE(\inst9|inst1|I3|acc[0][0]~4400\ # \inst9|inst1|I3|acc[0][4]~4338\ & (\rtl~1765\ # \rtl~10487\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst1|I2|int_start_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FAEA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][0]~4400\,
	datab => \rtl~1765\,
	datac => \inst9|inst1|I3|acc[0][4]~4338\,
	datad => \rtl~10487\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_i[0][0]\);

\inst9|inst1|I3|acc[0][0]~4400_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc[0][0]~4400\ = \inst9|inst1|I3|acc_i[0][0]\ & (\inst9|inst1|I3|acc[0][4]~4339\ # \inst9|inst1|I3|acc_c[0][0]\ & \inst9|inst1|I3|acc[0][4]~63\) # !\inst9|inst1|I3|acc_i[0][0]\ & \inst9|inst1|I3|acc_c[0][0]\ & \inst9|inst1|I3|acc[0][4]~63\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_i[0][0]\,
	datab => \inst9|inst1|I3|acc[0][4]~4339\,
	datac => \inst9|inst1|I3|acc_c[0][0]\,
	datad => \inst9|inst1|I3|acc[0][4]~63\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|acc[0][0]~4400\);

\inst9|inst1|I3|acc_c[0][0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_c[0][0]\ = DFFE(\inst9|inst1|I3|acc[0][0]~4400\ # \inst9|inst1|I3|acc[0][4]~4338\ & (\rtl~1765\ # \rtl~10487\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FAEA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][0]~4400\,
	datab => \rtl~1765\,
	datac => \inst9|inst1|I3|acc[0][4]~4338\,
	datad => \rtl~10487\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_c[0][0]\);

\inst9|inst1|I4|add_104~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104~0\ = \inst9|inst1|I4|ireg_c[0]\ $ \inst9|inst1|I4|iinc_c[0]\
-- \inst9|inst1|I4|add_104~0COUT\ = CARRY(\inst9|inst1|I4|ireg_c[0]\ & \inst9|inst1|I4|iinc_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	packed_mode => "false",
	lut_mask => "6688",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[0]\,
	datab => \inst9|inst1|I4|iinc_c[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104~0\,
	cout => \inst9|inst1|I4|add_104~0COUT\);

\inst9|inst1|I4|add_104_rtl_475~78_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104_rtl_475~78\ = \inst9|inst1|I4|reduce_nor_103\ & \inst9|inst1|I4|ireg_c[0]\ # !\inst9|inst1|I4|reduce_nor_103\ & (\inst9|inst1|I4|i~815\ & \inst9|inst1|I4|add_104~0\ # !\inst9|inst1|I4|i~815\ & \inst9|inst1|I4|ireg_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "B8AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[0]\,
	datab => \inst9|inst1|I4|reduce_nor_103\,
	datac => \inst9|inst1|I4|add_104~0\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104_rtl_475~78\);

\inst9|inst1|I4|ireg_i[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_i[0]\ = DFFE(\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I3|acc_c[0][0]\ # !\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|add_104_rtl_475~78\, GLOBAL(\clk~combout\), , , \inst9|inst1|I4|ireg_i[4]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "B888",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][0]\,
	datab => \inst9|inst1|I4|ireg_we_c\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I4|add_104_rtl_475~78\,
	clk => \clk~combout\,
	ena => \inst9|inst1|I4|ireg_i[4]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|ireg_i[0]\);

\inst9|inst1|I4|add_104_rtl_475~83_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104_rtl_475~83\ = \inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I3|acc_c[0][0]\ # !\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|add_104_rtl_475~78\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "B888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][0]\,
	datab => \inst9|inst1|I4|ireg_we_c\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I4|add_104_rtl_475~78\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104_rtl_475~83\);

\inst9|inst1|I4|ireg_c[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_c[0]\ = DFFE(\inst9|inst1|I2|int_stop_x~11\ & \inst9|inst1|I4|ireg_i[0]\ # !\inst9|inst1|I2|int_stop_x~11\ & \inst9|inst1|I4|add_104_rtl_475~83\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F3C0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|int_stop_x~11\,
	datac => \inst9|inst1|I4|ireg_i[0]\,
	datad => \inst9|inst1|I4|add_104_rtl_475~83\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|ireg_c[0]\);

\inst9|inst1|I4|add_104~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104~1\ = \inst9|inst1|I4|ireg_c[1]\ $ \inst9|inst1|I4|iinc_c[1]\ $ \inst9|inst1|I4|add_104~0COUT\
-- \inst9|inst1|I4|add_104~1COUT\ = CARRY(\inst9|inst1|I4|ireg_c[1]\ & !\inst9|inst1|I4|iinc_c[1]\ & !\inst9|inst1|I4|add_104~0COUT\ # !\inst9|inst1|I4|ireg_c[1]\ & (!\inst9|inst1|I4|add_104~0COUT\ # !\inst9|inst1|I4|iinc_c[1]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "9617",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[1]\,
	datab => \inst9|inst1|I4|iinc_c[1]\,
	cin => \inst9|inst1|I4|add_104~0COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104~1\,
	cout => \inst9|inst1|I4|add_104~1COUT\);

\inst9|inst1|I4|add_104_rtl_475~118_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104_rtl_475~118\ = \inst9|inst1|I4|reduce_nor_103\ & \inst9|inst1|I4|ireg_c[1]\ # !\inst9|inst1|I4|reduce_nor_103\ & (\inst9|inst1|I4|i~815\ & \inst9|inst1|I4|add_104~1\ # !\inst9|inst1|I4|i~815\ & \inst9|inst1|I4|ireg_c[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ACAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[1]\,
	datab => \inst9|inst1|I4|add_104~1\,
	datac => \inst9|inst1|I4|reduce_nor_103\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104_rtl_475~118\);

\inst9|inst1|I4|ireg_i[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_i[1]\ = DFFE(\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I3|acc_c[0][1]\ # !\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|add_104_rtl_475~118\, GLOBAL(\clk~combout\), , , \inst9|inst1|I4|ireg_i[4]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ACA0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][1]\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I4|ireg_we_c\,
	datad => \inst9|inst1|I4|add_104_rtl_475~118\,
	clk => \clk~combout\,
	ena => \inst9|inst1|I4|ireg_i[4]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|ireg_i[1]\);

\inst9|inst1|I4|add_104_rtl_475~123_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104_rtl_475~123\ = \inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I3|acc_c[0][1]\ # !\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|add_104_rtl_475~118\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ACA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][1]\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I4|ireg_we_c\,
	datad => \inst9|inst1|I4|add_104_rtl_475~118\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104_rtl_475~123\);

\inst9|inst1|I4|ireg_c[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_c[1]\ = DFFE(\inst9|inst1|I4|ireg_i[1]\ & (\inst9|inst1|I2|int_stop_x~11\ # \inst9|inst1|I4|add_104_rtl_475~123\) # !\inst9|inst1|I4|ireg_i[1]\ & !\inst9|inst1|I2|int_stop_x~11\ & \inst9|inst1|I4|add_104_rtl_475~123\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CFC0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|ireg_i[1]\,
	datac => \inst9|inst1|I2|int_stop_x~11\,
	datad => \inst9|inst1|I4|add_104_rtl_475~123\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|ireg_c[1]\);

\inst9|inst1|I4|add_104~2_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104~2\ = \inst9|inst1|I4|ireg_c[2]\ $ \inst9|inst1|I4|iinc_c[2]\ $ !\inst9|inst1|I4|add_104~1COUT\
-- \inst9|inst1|I4|add_104~2COUT\ = CARRY(\inst9|inst1|I4|ireg_c[2]\ & (\inst9|inst1|I4|iinc_c[2]\ # !\inst9|inst1|I4|add_104~1COUT\) # !\inst9|inst1|I4|ireg_c[2]\ & \inst9|inst1|I4|iinc_c[2]\ & !\inst9|inst1|I4|add_104~1COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "698E",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[2]\,
	datab => \inst9|inst1|I4|iinc_c[2]\,
	cin => \inst9|inst1|I4|add_104~1COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104~2\,
	cout => \inst9|inst1|I4|add_104~2COUT\);

\inst9|inst1|I4|add_104_rtl_475~58_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104_rtl_475~58\ = \inst9|inst1|I4|reduce_nor_103\ & \inst9|inst1|I4|ireg_c[3]\ # !\inst9|inst1|I4|reduce_nor_103\ & (\inst9|inst1|I4|i~815\ & \inst9|inst1|I4|add_104~3\ # !\inst9|inst1|I4|i~815\ & \inst9|inst1|I4|ireg_c[3]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ACAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[3]\,
	datab => \inst9|inst1|I4|add_104~3\,
	datac => \inst9|inst1|I4|reduce_nor_103\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104_rtl_475~58\);

\inst9|inst1|I4|ireg_i[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_i[3]\ = DFFE(\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I3|acc_c[0][3]\ # !\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|add_104_rtl_475~58\, GLOBAL(\clk~combout\), , , \inst9|inst1|I4|ireg_i[4]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ACA0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][3]\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I4|ireg_we_c\,
	datad => \inst9|inst1|I4|add_104_rtl_475~58\,
	clk => \clk~combout\,
	ena => \inst9|inst1|I4|ireg_i[4]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|ireg_i[3]\);

\inst9|inst1|I4|add_104_rtl_475~63_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104_rtl_475~63\ = \inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I3|acc_c[0][3]\ # !\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|add_104_rtl_475~58\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ACA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][3]\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I4|ireg_we_c\,
	datad => \inst9|inst1|I4|add_104_rtl_475~58\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104_rtl_475~63\);

\inst9|inst1|I4|ireg_c[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_c[3]\ = DFFE(\inst9|inst1|I4|ireg_i[3]\ & (\inst9|inst1|I2|int_stop_x~11\ # \inst9|inst1|I4|add_104_rtl_475~63\) # !\inst9|inst1|I4|ireg_i[3]\ & !\inst9|inst1|I2|int_stop_x~11\ & \inst9|inst1|I4|add_104_rtl_475~63\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CFC0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|ireg_i[3]\,
	datac => \inst9|inst1|I2|int_stop_x~11\,
	datad => \inst9|inst1|I4|add_104_rtl_475~63\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|ireg_c[3]\);

\inst9|inst1|I4|daddr_x[3]~31_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[3]~31\ = \inst9|inst1|I4|ireg_c[3]\ & \inst9|inst1|I4|i~18\ & !\inst9|inst1|I4|reduce_nor_103\ & \inst9|inst1|I4|i~815\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[3]\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I4|reduce_nor_103\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[3]~31\);

\inst9|inst4|daddr_c[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|daddr_c[3]\ = DFFE(\inst9|inst4|i~48\ & \inst9|inst4|daddr_c[3]\ # !\inst9|inst4|i~48\ & (\inst9|inst1|I4|daddr_x[3]~30\ # \inst9|inst1|I4|daddr_x[3]~31\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAFC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst4|daddr_c[3]\,
	datab => \inst9|inst1|I4|daddr_x[3]~30\,
	datac => \inst9|inst1|I4|daddr_x[3]~31\,
	datad => \inst9|inst4|i~48\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst4|daddr_c[3]\);

\inst9|inst4|i~430_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~430\ = \inst9|inst1|I4|ndre_x~1\ & !\inst9|inst4|i~382\ & \inst9|inst4|daddr_c[3]\ # !\inst9|inst1|I4|ndre_x~1\ & \inst9|inst1|I4|daddr_x[3]~19\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4F40",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst4|i~382\,
	datab => \inst9|inst4|daddr_c[3]\,
	datac => \inst9|inst1|I4|ndre_x~1\,
	datad => \inst9|inst1|I4|daddr_x[3]~19\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~430\);

\inst9|inst4|i~81_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~81\ = \inst9|inst4|i~430\ # \inst9|inst4|i~379\ & \inst9|inst1|I1|i~2\ & \inst9|inst1|I1|iaddr_x[3]~390\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F8F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst4|i~379\,
	datab => \inst9|inst1|I1|i~2\,
	datac => \inst9|inst4|i~430\,
	datad => \inst9|inst1|I1|iaddr_x[3]~390\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~81\);

\inst9|inst15|lpm_ram_dq_component|sram|segment[0][1]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem2 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001000010100001010100001000110010101010010001000100010001001001010010100000000011000101000101000100101000101000000010101000101001010010001010101001010010010010010010000100110101011010101010101010101010100",
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|lpm_ram_dq1:inst15|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "rom.mif",
	logical_ram_depth => 1024,
	logical_ram_width => 14,
	address_width => 10,
	first_address => 0,
	last_address => 1023,
	bit_number => 1,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst1|I4|data_ox[1]~6\,
	clk0 => \clk~combout\,
	we => \inst9|inst19|i~50\,
	waddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][1]_waddr\,
	raddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][1]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst15|lpm_ram_dq_component|sram|segment[0][1]_modesel\,
	dataout => \inst9|inst15|lpm_ram_dq_component|sram|q[1]\);

\inst9|inst1|I2|idata_c[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_c[1]\ = DFFE(\inst9|inst1|I2|i~509\ & (\inst9|inst1|I2|i~2\ & \inst9|inst1|I2|idata_c[1]\ # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[1]\) # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E2AA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst15|lpm_ram_dq_component|sram|q[1]\,
	datab => \inst9|inst1|I2|i~509\,
	datac => \inst9|inst1|I2|idata_c[1]\,
	datad => \inst9|inst1|I2|i~2\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|idata_c[1]\);

\inst9|inst1|I2|idata_x[1]~22_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[1]~22\ = \inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|idata_c[1]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[1]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_c[1]\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst1|I2|i~509\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[1]~22\);

\inst9|inst1|I2|TD_x[3]~36_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TD_x[3]~36\ = !\inst9|inst1|I2|idata_x[1]~22\ & !\inst9|inst1|I2|idata_x[0]~19\ & !\inst9|inst1|I2|idata_x[2]~25\ & !\inst9|inst1|I2|idata_x[3]~16\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0001",
	output_mode => "none")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[1]~22\,
	datab => \inst9|inst1|I2|idata_x[0]~19\,
	datac => \inst9|inst1|I2|idata_x[2]~25\,
	datad => \inst9|inst1|I2|idata_x[3]~16\,
	devclrn => devclrn,
	devpor => devpor,
	cascout => \inst9|inst1|I2|TD_x[3]~36\);

\inst9|inst1|I2|TD_c[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TD_c[3]\ = DFFE((!\inst9|inst1|I2|idata_x[6]~26\ & !\inst9|inst1|I2|idata_x[6]~27\ & (\inst9|inst1|I2|idata_x[7]~30\ # \inst9|inst1|I2|idata_x[7]~29\)) & CASCADE(\inst9|inst1|I2|TD_x[3]~36\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0032",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[7]~30\,
	datab => \inst9|inst1|I2|idata_x[6]~26\,
	datac => \inst9|inst1|I2|idata_x[7]~29\,
	datad => \inst9|inst1|I2|idata_x[6]~27\,
	cascin => \inst9|inst1|I2|TD_x[3]~36\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|TD_c[3]\);

\rtl~10117_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10117\ = !\inst9|inst1|I2|TC_c[2]\ & !\inst9|inst1|I2|TC_c[0]\ & \inst9|inst1|I2|TD_c[3]\ & !\inst9|inst1|I2|TC_c[1]\
-- \rtl~10911\ = !\inst9|inst1|I2|TC_c[2]\ & !\inst9|inst1|I2|TC_c[0]\ & \inst9|inst1|I2|TD_c[3]\ & !\inst9|inst1|I2|TC_c[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0010",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TC_c[2]\,
	datab => \inst9|inst1|I2|TC_c[0]\,
	datac => \inst9|inst1|I2|TD_c[3]\,
	datad => \inst9|inst1|I2|TC_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10117\,
	cascout => \rtl~10911\);

\rtl~10129_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10129\ = \inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|acc_c[0][8]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst1|I2|TD_c[0]\,
	datad => \inst9|inst1|I3|acc_c[0][8]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10129\);

\rtl~1553_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1553\ = \rtl~10117\ & !\inst9|inst1|I2|TD_c[2]\ & !\inst9|inst1|I2|TD_c[1]\ & \rtl~10129\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0200",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~10117\,
	datab => \inst9|inst1|I2|TD_c[2]\,
	datac => \inst9|inst1|I2|TD_c[1]\,
	datad => \rtl~10129\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1553\);

\rtl~10906_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10906\ = (\inst9|inst1|I2|TD_c[1]\ & !\inst9|inst1|I2|TD_c[0]\ & !\inst9|inst1|I2|TD_c[2]\) & CASCADE(\rtl~10911\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "000C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|TD_c[1]\,
	datac => \inst9|inst1|I2|TD_c[0]\,
	datad => \inst9|inst1|I2|TD_c[2]\,
	cascin => \rtl~10911\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10906\);

\rtl~10171_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10171\ = !\inst9|inst1|I2|TD_c[0]\ & !\inst9|inst1|I2|TD_c[1]\ & \rtl~10117\ & !\inst9|inst1|I2|TD_c[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0010",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[0]\,
	datab => \inst9|inst1|I2|TD_c[1]\,
	datac => \rtl~10117\,
	datad => \inst9|inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10171\);

\inst9|inst1|I3|reduce_nor_91~35_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|reduce_nor_91~35\ = \inst9|inst1|I3|acc_c[0][4]\ # \inst9|inst1|I3|acc_c[0][2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst1|I3|acc_c[0][4]\,
	datad => \inst9|inst1|I3|acc_c[0][2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|reduce_nor_91~35\);

\inst9|inst1|I3|reduce_nor_91~28_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|reduce_nor_91~28\ = \inst9|inst1|I3|acc_c[0][1]\ # \inst9|inst1|I3|acc_c[0][6]\ # \inst9|inst1|I3|acc_c[0][7]\ # \inst9|inst1|I3|acc_c[0][5]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][1]\,
	datab => \inst9|inst1|I3|acc_c[0][6]\,
	datac => \inst9|inst1|I3|acc_c[0][7]\,
	datad => \inst9|inst1|I3|acc_c[0][5]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|reduce_nor_91~28\);

\inst9|inst1|I3|reduce_nor_91~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|reduce_nor_91\ = \inst9|inst1|I3|acc_c[0][0]\ # \inst9|inst1|I3|reduce_nor_91~35\ # \inst9|inst1|I3|acc_c[0][3]\ # \inst9|inst1|I3|reduce_nor_91~28\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][0]\,
	datab => \inst9|inst1|I3|reduce_nor_91~35\,
	datac => \inst9|inst1|I3|acc_c[0][3]\,
	datad => \inst9|inst1|I3|reduce_nor_91~28\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|reduce_nor_91\);

\rtl~10195_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10195\ = \rtl~1553\ # \inst9|inst1|I3|reduce_nor_91\ & \rtl~10906\ # !\inst9|inst1|I3|reduce_nor_91\ & \rtl~10171\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EEFA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~1553\,
	datab => \rtl~10906\,
	datac => \rtl~10171\,
	datad => \inst9|inst1|I3|reduce_nor_91\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10195\);

\inst9|inst1|I3|skip_i~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|skip_i\ = DFFE(\inst9|inst1|I3|i~173\ & (\rtl~10188\ # \rtl~10195\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst1|I2|int_start_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0C0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \rtl~10188\,
	datac => \inst9|inst1|I3|i~173\,
	datad => \rtl~10195\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|skip_i\);

\rtl~940_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~940\ = !\inst9|inst1|I2|TC_c[0]\ & \inst9|inst1|I2|TC_c[2]\ & !\inst9|inst1|I2|TC_c[1]\ & \inst9|inst1|I3|skip_i\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TC_c[0]\,
	datab => \inst9|inst1|I2|TC_c[2]\,
	datac => \inst9|inst1|I2|TC_c[1]\,
	datad => \inst9|inst1|I3|skip_i\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~940\);

\rtl~10162_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10162\ = !\inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I2|TD_c[2]\ & !\inst9|inst1|I3|acc_c[0][8]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0050",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[0]\,
	datac => \inst9|inst1|I2|TD_c[2]\,
	datad => \inst9|inst1|I3|acc_c[0][8]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10162\);

\rtl~10188_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10188\ = \rtl~940\ # \rtl~10162\ & \rtl~10117\ & !\inst9|inst1|I2|TD_c[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AAEA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~940\,
	datab => \rtl~10162\,
	datac => \rtl~10117\,
	datad => \inst9|inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10188\);

\inst9|inst1|I2|skip_x~62_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|skip_x~62\ = \inst9|inst1|I2|skip_x~112\ & \inst9|inst1|I3|i~173\ & (\rtl~10188\ # \rtl~10195\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|skip_x~112\,
	datab => \rtl~10188\,
	datac => \inst9|inst1|I3|i~173\,
	datad => \rtl~10195\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|skip_x~62\);

\inst9|inst1|I2|C_raw~61_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|C_raw~61\ = (!\inst9|inst1|I2|skip_x~41\ & \inst9|inst1|I2|i~2\ & !\inst9|inst1|I2|skip_x~62\ & !\inst9|inst1|I2|TC_x[2]~570\) & CASCADE(\inst9|inst1|I2|TC_x[0]~573\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0004",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|skip_x~41\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst1|I2|skip_x~62\,
	datad => \inst9|inst1|I2|TC_x[2]~570\,
	cascin => \inst9|inst1|I2|TC_x[0]~573\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|C_raw~61\);

\inst9|inst1|I2|idata_c[13]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_c[13]\ = DFFE(\inst9|inst1|I2|i~509\ & (\inst9|inst1|I2|i~2\ & \inst9|inst1|I2|idata_c[13]\ # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[13]\) # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[13]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EC4C",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~509\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[13]\,
	datac => \inst9|inst1|I2|i~2\,
	datad => \inst9|inst1|I2|idata_c[13]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|idata_c[13]\);

\inst9|inst1|I2|idata_x[13]~46_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[13]~46\ = \inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|idata_c[13]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[13]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[13]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F780",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~2\,
	datab => \inst9|inst1|I2|i~509\,
	datac => \inst9|inst1|I2|idata_c[13]\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[13]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[13]~46\);

\inst9|inst1|I4|i~796_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|i~796\ = !\inst9|inst1|I2|idata_x[7]~31\ & !\inst9|inst1|I2|idata_x[13]~46\ & !\inst9|inst1|I2|idata_x[12]~40\ & !\inst9|inst1|I2|idata_x[8]~43\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0001",
	output_mode => "none")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[7]~31\,
	datab => \inst9|inst1|I2|idata_x[13]~46\,
	datac => \inst9|inst1|I2|idata_x[12]~40\,
	datad => \inst9|inst1|I2|idata_x[8]~43\,
	devclrn => devclrn,
	devpor => devpor,
	cascout => \inst9|inst1|I4|i~796\);

\inst9|inst1|I4|i~816_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|i~816\ = (!\inst9|inst1|I2|idata_x[11]~49\ & !\inst9|inst1|I2|idata_x[10]~52\ & !\inst9|inst1|I2|idata_x[9]~55\) & CASCADE(\inst9|inst1|I4|i~796\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0003",
	output_mode => "none")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|idata_x[11]~49\,
	datac => \inst9|inst1|I2|idata_x[10]~52\,
	datad => \inst9|inst1|I2|idata_x[9]~55\,
	cascin => \inst9|inst1|I4|i~796\,
	devclrn => devclrn,
	devpor => devpor,
	cascout => \inst9|inst1|I4|i~816\);

\inst9|inst1|I4|i~815_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|i~815\ = (\inst9|inst1|I2|ndre_x~40\ & \inst9|inst1|I2|C_raw~61\ & (\inst9|inst1|I2|TC_x[1]~22\ # !\inst9|inst1|I2|C_raw~56\)) & CASCADE(\inst9|inst1|I4|i~816\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C040",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|C_raw~56\,
	datab => \inst9|inst1|I2|ndre_x~40\,
	datac => \inst9|inst1|I2|C_raw~61\,
	datad => \inst9|inst1|I2|TC_x[1]~22\,
	cascin => \inst9|inst1|I4|i~816\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|i~815\);

\inst9|inst1|I4|ireg_we_c~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_we_c\ = DFFE(!\inst9|inst1|I4|reduce_nor_106\ & \inst9|inst1|I4|i~815\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I2|ndwe_x~45\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|reduce_nor_106\,
	datab => \inst9|inst1|I4|i~815\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I2|ndwe_x~45\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|ireg_we_c\);

\inst9|inst1|I4|add_104_rtl_475~48_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104_rtl_475~48\ = \inst9|inst1|I4|reduce_nor_103\ & \inst9|inst1|I4|ireg_c[2]\ # !\inst9|inst1|I4|reduce_nor_103\ & (\inst9|inst1|I4|i~815\ & \inst9|inst1|I4|add_104~2\ # !\inst9|inst1|I4|i~815\ & \inst9|inst1|I4|ireg_c[2]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E4F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|reduce_nor_103\,
	datab => \inst9|inst1|I4|add_104~2\,
	datac => \inst9|inst1|I4|ireg_c[2]\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104_rtl_475~48\);

\inst9|inst1|I4|ireg_i[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_i[2]\ = DFFE(\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I3|acc_c[0][2]\ # !\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|add_104_rtl_475~48\, GLOBAL(\clk~combout\), , , \inst9|inst1|I4|ireg_i[4]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E4A0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_we_c\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I3|acc_c[0][2]\,
	datad => \inst9|inst1|I4|add_104_rtl_475~48\,
	clk => \clk~combout\,
	ena => \inst9|inst1|I4|ireg_i[4]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|ireg_i[2]\);

\inst9|inst1|I4|add_104_rtl_475~53_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|add_104_rtl_475~53\ = \inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I3|acc_c[0][2]\ # !\inst9|inst1|I4|ireg_we_c\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|add_104_rtl_475~48\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E4A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_we_c\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I3|acc_c[0][2]\,
	datad => \inst9|inst1|I4|add_104_rtl_475~48\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|add_104_rtl_475~53\);

\inst9|inst1|I4|ireg_c[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ireg_c[2]\ = DFFE(\inst9|inst1|I4|ireg_i[2]\ & (\inst9|inst1|I2|int_stop_x~11\ # \inst9|inst1|I4|add_104_rtl_475~53\) # !\inst9|inst1|I4|ireg_i[2]\ & !\inst9|inst1|I2|int_stop_x~11\ & \inst9|inst1|I4|add_104_rtl_475~53\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AFA0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_i[2]\,
	datac => \inst9|inst1|I2|int_stop_x~11\,
	datad => \inst9|inst1|I4|add_104_rtl_475~53\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I4|ireg_c[2]\);

\inst9|inst1|I4|daddr_x[2]~28_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[2]~28\ = !\inst9|inst1|I4|reduce_nor_103\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|ireg_c[2]\ & \inst9|inst1|I4|i~815\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|reduce_nor_103\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I4|ireg_c[2]\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[2]~28\);

\inst9|inst4|daddr_c[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|daddr_c[2]\ = DFFE(\inst9|inst4|i~48\ & \inst9|inst4|daddr_c[2]\ # !\inst9|inst4|i~48\ & (\inst9|inst1|I4|daddr_x[2]~27\ # \inst9|inst1|I4|daddr_x[2]~28\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DDD8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst4|i~48\,
	datab => \inst9|inst4|daddr_c[2]\,
	datac => \inst9|inst1|I4|daddr_x[2]~27\,
	datad => \inst9|inst1|I4|daddr_x[2]~28\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst4|daddr_c[2]\);

\inst9|inst1|I4|daddr_x[2]~18_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[2]~18\ = \inst9|inst1|I4|i~18\ & (\inst9|inst1|I2|idata_x[6]~28\ # \inst9|inst1|I4|ireg_c[2]\ & \inst9|inst1|I4|i~760\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A8A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~18\,
	datab => \inst9|inst1|I4|ireg_c[2]\,
	datac => \inst9|inst1|I2|idata_x[6]~28\,
	datad => \inst9|inst1|I4|i~760\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[2]~18\);

\inst9|inst4|i~423_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~423\ = \inst9|inst1|I4|ndre_x~1\ & \inst9|inst4|daddr_c[2]\ & !\inst9|inst4|i~382\ # !\inst9|inst1|I4|ndre_x~1\ & \inst9|inst1|I4|daddr_x[2]~18\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2F20",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst4|daddr_c[2]\,
	datab => \inst9|inst4|i~382\,
	datac => \inst9|inst1|I4|ndre_x~1\,
	datad => \inst9|inst1|I4|daddr_x[2]~18\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~423\);

\inst9|inst4|i~75_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~75\ = \inst9|inst4|i~423\ # \inst9|inst1|I1|i~2\ & \inst9|inst4|i~379\ & \inst9|inst1|I1|iaddr_x[2]~354\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F8F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|i~2\,
	datab => \inst9|inst4|i~379\,
	datac => \inst9|inst4|i~423\,
	datad => \inst9|inst1|I1|iaddr_x[2]~354\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~75\);

\inst9|inst15|lpm_ram_dq_component|sram|segment[0][4]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem2 => "00000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111111100101011000011011010010111101001111000100101100110000001000111010000100001100001000001000000010000101100100000011110101101000110010010111101010101001001011001001110000010000110110101000001001101111100",
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|lpm_ram_dq1:inst15|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "rom.mif",
	logical_ram_depth => 1024,
	logical_ram_width => 14,
	address_width => 10,
	first_address => 0,
	last_address => 1023,
	bit_number => 4,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst1|I4|data_ox[4]~3\,
	clk0 => \clk~combout\,
	we => \inst9|inst19|i~50\,
	waddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][4]_waddr\,
	raddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][4]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst15|lpm_ram_dq_component|sram|segment[0][4]_modesel\,
	dataout => \inst9|inst15|lpm_ram_dq_component|sram|q[4]\);

\inst9|inst1|I2|data_is_c[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|data_is_c[0]\ = DFFE(\inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|data_is_c[0]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[4]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[4]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F780",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~2\,
	datab => \inst9|inst1|I2|i~509\,
	datac => \inst9|inst1|I2|data_is_c[0]\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[4]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|data_is_c[0]\);

\inst9|inst1|I2|idata_x[4]~37_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[4]~37\ = \inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|data_is_c[0]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[4]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[4]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|data_is_c[0]\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst1|I2|i~509\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[4]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[4]~37\);

\inst9|inst1|I4|reduce_nor_103~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|reduce_nor_103\ = \inst9|inst1|I2|idata_x[6]~28\ # \inst9|inst1|I2|idata_x[4]~37\ # \inst9|inst1|I2|idata_x[5]~34\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|idata_x[6]~28\,
	datac => \inst9|inst1|I2|idata_x[4]~37\,
	datad => \inst9|inst1|I2|idata_x[5]~34\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|reduce_nor_103\);

\inst9|inst1|I4|daddr_x[1]~63_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[1]~63\ = \inst9|inst1|I2|idata_x[5]~34\ # !\inst9|inst1|I4|reduce_nor_103\ & \inst9|inst1|I4|ireg_c[1]\ & \inst9|inst1|I4|i~815\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DCCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|reduce_nor_103\,
	datab => \inst9|inst1|I2|idata_x[5]~34\,
	datac => \inst9|inst1|I4|ireg_c[1]\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[1]~63\);

\inst9|inst4|daddr_c[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|daddr_c[1]\ = DFFE(\inst9|inst4|i~48\ & \inst9|inst4|daddr_c[1]\ # !\inst9|inst4|i~48\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I4|daddr_x[1]~63\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "D888",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst4|i~48\,
	datab => \inst9|inst4|daddr_c[1]\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst1|I4|daddr_x[1]~63\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst4|daddr_c[1]\);

\inst9|inst1|I4|daddr_x[1]~69_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[1]~69\ = \inst9|inst1|I4|i~18\ & (\inst9|inst1|I2|idata_x[5]~34\ # \inst9|inst1|I4|ireg_c[1]\ & \inst9|inst1|I4|i~760\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~18\,
	datab => \inst9|inst1|I2|idata_x[5]~34\,
	datac => \inst9|inst1|I4|ireg_c[1]\,
	datad => \inst9|inst1|I4|i~760\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[1]~69\);

\inst9|inst4|i~416_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~416\ = \inst9|inst1|I4|ndre_x~1\ & \inst9|inst4|daddr_c[1]\ & !\inst9|inst4|i~382\ # !\inst9|inst1|I4|ndre_x~1\ & \inst9|inst1|I4|daddr_x[1]~69\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2F20",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst4|daddr_c[1]\,
	datab => \inst9|inst4|i~382\,
	datac => \inst9|inst1|I4|ndre_x~1\,
	datad => \inst9|inst1|I4|daddr_x[1]~69\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~416\);

\inst9|inst4|i~69_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~69\ = \inst9|inst4|i~416\ # \inst9|inst1|I1|i~2\ & \inst9|inst4|i~379\ & \inst9|inst1|I1|iaddr_x[1]~325\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F8F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|i~2\,
	datab => \inst9|inst4|i~379\,
	datac => \inst9|inst4|i~416\,
	datad => \inst9|inst1|I1|iaddr_x[1]~325\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~69\);

\inst9|inst15|lpm_ram_dq_component|sram|segment[0][9]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem2 => "00000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000100001000010000000000000001000100000000000000000000010000000100000000010000100000000000100000100000100010100100000000000000001001000000000000000000010000100000010000000001010101000000000000",
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|lpm_ram_dq1:inst15|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "rom.mif",
	logical_ram_depth => 1024,
	logical_ram_width => 14,
	address_width => 10,
	first_address => 0,
	last_address => 1023,
	bit_number => 9,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \~GND\,
	clk0 => \clk~combout\,
	we => \inst9|inst19|i~50\,
	waddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][9]_waddr\,
	raddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][9]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst15|lpm_ram_dq_component|sram|segment[0][9]_modesel\,
	dataout => \inst9|inst15|lpm_ram_dq_component|sram|q[9]\);

\inst9|inst1|I2|data_is_c[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|data_is_c[5]\ = DFFE(\inst9|inst1|I2|i~509\ & (\inst9|inst1|I2|i~2\ & \inst9|inst1|I2|data_is_c[5]\ # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[9]\) # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[9]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EC4C",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~509\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[9]\,
	datac => \inst9|inst1|I2|i~2\,
	datad => \inst9|inst1|I2|data_is_c[5]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|data_is_c[5]\);

\inst9|inst1|I3|data_x[5]~178_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[5]~178\ = \inst9|inst1|I4|reduce_nor_106\ & \inst9|inst1|I4|iinc_c[5]\ & \inst9|inst1|I2|ndre_x~41\ # !\inst9|inst1|I4|reduce_nor_106\ & \inst9|inst1|I4|ireg_c[5]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E222",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ireg_c[5]\,
	datab => \inst9|inst1|I4|reduce_nor_106\,
	datac => \inst9|inst1|I4|iinc_c[5]\,
	datad => \inst9|inst1|I2|ndre_x~41\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[5]~178\);

\inst9|inst1|I3|data_x[5]~184_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[5]~184\ = \inst9|inst1|I3|reduce_nor_71\ & \inst9|inst1|I4|i~18\ & \inst9|inst1|I3|data_x[5]~178\ & \inst9|inst1|I4|i~616\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|reduce_nor_71\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I3|data_x[5]~178\,
	datad => \inst9|inst1|I4|i~616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[5]~184\);

\inst9|inst|Decoder_28~21_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|Decoder_28~21\ = \inst9|inst|rx_bit_count[0]\ & !\inst9|inst|rx_bit_count[1]\ & !\inst9|inst|rx_bit_count[3]\ & \inst9|inst|rx_bit_count[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0200",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_bit_count[0]\,
	datab => \inst9|inst|rx_bit_count[1]\,
	datac => \inst9|inst|rx_bit_count[3]\,
	datad => \inst9|inst|rx_bit_count[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|Decoder_28~21\);

\inst9|inst|rx_uart_reg[5]~7_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[5]~7\ = !\inst9|inst|reduce_nor_27\ & \rtl~9986\ & \inst9|inst|reduce_nor_7\ & \inst9|inst|Decoder_28~21\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|reduce_nor_27\,
	datab => \rtl~9986\,
	datac => \inst9|inst|reduce_nor_7\,
	datad => \inst9|inst|Decoder_28~21\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|rx_uart_reg[5]~7\);

\inst9|inst|rx_uart_reg[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[5]\ = DFFE(!\RXD~combout\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|rx_uart_reg[5]~7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \RXD~combout\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|rx_uart_reg[5]~7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_reg[5]\);

\inst9|inst|rx_uart_fifo[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_fifo[5]\ = DFFE(!\inst9|inst|rx_uart_reg[5]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|rx_uart_fifo[4]~37\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst|rx_uart_reg[5]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|rx_uart_fifo[4]~37\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_fifo[5]\);

\inst9|inst12|i~381_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|i~381\ = !\inst9|inst19|mux_c[0]\ & \inst9|inst19|mux_c[1]\ & \inst9|inst|rx_uart_fifo[5]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst19|mux_c[0]\,
	datac => \inst9|inst19|mux_c[1]\,
	datad => \inst9|inst|rx_uart_fifo[5]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|i~381\);

\inst9|inst1|I3|data_x[5]~266_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[5]~266\ = \inst9|inst1|I3|data_x[2]~2293\ & (\inst9|inst12|i~381\ # !\inst9|inst19|Mux_13_rtl_0~0\ & \inst9|inst15|lpm_ram_dq_component|sram|q[5]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DC00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst19|Mux_13_rtl_0~0\,
	datab => \inst9|inst12|i~381\,
	datac => \inst9|inst15|lpm_ram_dq_component|sram|q[5]\,
	datad => \inst9|inst1|I3|data_x[2]~2293\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[5]~266\);

\inst9|inst1|I3|data_x[5]~2239_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[5]~2239\ = \inst9|inst1|I3|data_x[5]~184\ # \inst9|inst1|I3|data_x[5]~266\ # !\inst9|inst1|I3|reduce_nor_71\ & \inst9|inst1|I2|data_is_c[5]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|reduce_nor_71\,
	datab => \inst9|inst1|I2|data_is_c[5]\,
	datac => \inst9|inst1|I3|data_x[5]~184\,
	datad => \inst9|inst1|I3|data_x[5]~266\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[5]~2239\);

\rtl~10617_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10617\ = \rtl~9972\ & (\inst9|inst1|I3|data_x[5]~2239\ $ (\inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|acc_c[0][5]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4C80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[0]\,
	datab => \rtl~9972\,
	datac => \inst9|inst1|I3|acc_c[0][5]\,
	datad => \inst9|inst1|I3|data_x[5]~2239\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10617\);

\rtl~1590_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1590\ = \inst9|inst1|I3|Mux_201_rtl_146~0\ & \inst9|inst1|I3|acc_c[0][5]\ & !\inst9|inst1|I2|TD_c[2]\ & !\inst9|inst1|I2|TD_c[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0008",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	datab => \inst9|inst1|I3|acc_c[0][5]\,
	datac => \inst9|inst1|I2|TD_c[2]\,
	datad => \inst9|inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1590\);

\rtl~2073_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2073\ = \inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][6]\ & !\inst9|inst1|I2|TD_c[1]\ # !\inst9|inst1|I2|TD_c[2]\ & (\inst9|inst1|I2|TD_c[1]\ & \inst9|inst1|I3|acc_c[0][6]\ # !\inst9|inst1|I2|TD_c[1]\ & \inst9|inst1|I3|acc_c[0][5]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "22B8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][6]\,
	datab => \inst9|inst1|I2|TD_c[2]\,
	datac => \inst9|inst1|I3|acc_c[0][5]\,
	datad => \inst9|inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2073\);

\rtl~2192_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2192\ = \inst9|inst1|I2|TD_c[2]\ & (\inst9|inst1|I2|TD_c[1]\ $ \inst9|inst1|I3|acc_c[0][5]\) # !\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][4]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "3CAA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][4]\,
	datab => \inst9|inst1|I2|TD_c[1]\,
	datac => \inst9|inst1|I3|acc_c[0][5]\,
	datad => \inst9|inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2192\);

\rtl~1809_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1809\ = !\inst9|inst1|I3|Mux_201_rtl_146~0\ & (\inst9|inst1|I2|TD_c[0]\ & \rtl~2192\ # !\inst9|inst1|I2|TD_c[0]\ & \rtl~2073\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "3210",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[0]\,
	datab => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	datac => \rtl~2073\,
	datad => \rtl~2192\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1809\);

\inst9|inst1|I3|Mux_173_rtl_127_rtl_363~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|Mux_173_rtl_127_rtl_363~0\ = \inst9|inst1|I2|TD_c[1]\ & (\inst9|inst1|I2|TD_c[0]\ # \inst9|inst1|I3|add_153~6\) # !\inst9|inst1|I2|TD_c[1]\ & !\inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|add_129~5\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DC98",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[0]\,
	datab => \inst9|inst1|I2|TD_c[1]\,
	datac => \inst9|inst1|I3|add_129~5\,
	datad => \inst9|inst1|I3|add_153~6\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|Mux_173_rtl_127_rtl_363~0\);

\inst9|inst1|I3|Mux_173_rtl_127_rtl_363~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|Mux_173_rtl_127_rtl_363~1\ = \inst9|inst1|I3|acc_c[0][5]\ & (\inst9|inst1|I3|Mux_173_rtl_127_rtl_363~0\ # \inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|data_x[5]~2239\) # !\inst9|inst1|I3|acc_c[0][5]\ & \inst9|inst1|I3|Mux_173_rtl_127_rtl_363~0\ & (\inst9|inst1|I3|data_x[5]~2239\ # !\inst9|inst1|I2|TD_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FB80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][5]\,
	datab => \inst9|inst1|I2|TD_c[0]\,
	datac => \inst9|inst1|I3|data_x[5]~2239\,
	datad => \inst9|inst1|I3|Mux_173_rtl_127_rtl_363~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|Mux_173_rtl_127_rtl_363~1\);

\rtl~10600_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10600\ = \rtl~1590\ # \rtl~1809\ # \rtl~9988\ & \inst9|inst1|I3|Mux_173_rtl_127_rtl_363~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FEFC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~9988\,
	datab => \rtl~1590\,
	datac => \rtl~1809\,
	datad => \inst9|inst1|I3|Mux_173_rtl_127_rtl_363~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10600\);

\inst9|inst1|I3|acc_i[0][5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_i[0][5]\ = DFFE(\inst9|inst1|I3|acc[0][5]~4430\ # \inst9|inst1|I3|acc[0][4]~4338\ & (\rtl~10617\ # \rtl~10600\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst1|I2|int_start_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EEEC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][4]~4338\,
	datab => \inst9|inst1|I3|acc[0][5]~4430\,
	datac => \rtl~10617\,
	datad => \rtl~10600\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_i[0][5]\);

\inst9|inst1|I3|acc[0][5]~4430_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc[0][5]~4430\ = \inst9|inst1|I3|acc[0][4]~4339\ & (\inst9|inst1|I3|acc_i[0][5]\ # \inst9|inst1|I3|acc_c[0][5]\ & \inst9|inst1|I3|acc[0][4]~63\) # !\inst9|inst1|I3|acc[0][4]~4339\ & \inst9|inst1|I3|acc_c[0][5]\ & \inst9|inst1|I3|acc[0][4]~63\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ECA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][4]~4339\,
	datab => \inst9|inst1|I3|acc_c[0][5]\,
	datac => \inst9|inst1|I3|acc_i[0][5]\,
	datad => \inst9|inst1|I3|acc[0][4]~63\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|acc[0][5]~4430\);

\inst9|inst1|I3|acc_c[0][5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_c[0][5]\ = DFFE(\inst9|inst1|I3|acc[0][5]~4430\ # \inst9|inst1|I3|acc[0][4]~4338\ & (\rtl~10617\ # \rtl~10600\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EEEC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][4]~4338\,
	datab => \inst9|inst1|I3|acc[0][5]~4430\,
	datac => \rtl~10617\,
	datad => \rtl~10600\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_c[0][5]\);

\inst9|inst1|I4|data_ox[5]~2_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|data_ox[5]~2\ = \inst9|inst1|I3|acc_c[0][5]\ & \inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][5]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|data_ox[5]~2\);

\inst9|inst15|lpm_ram_dq_component|sram|segment[0][5]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem2 => "00000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000100000000100010011101110011001100100001010100010011000111001001011011000000010000011011101111001110000000100110010100100111100000001000001001011001001001110010000000101000001000000000010000001",
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|lpm_ram_dq1:inst15|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "rom.mif",
	logical_ram_depth => 1024,
	logical_ram_width => 14,
	address_width => 10,
	first_address => 0,
	last_address => 1023,
	bit_number => 5,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst1|I4|data_ox[5]~2\,
	clk0 => \clk~combout\,
	we => \inst9|inst19|i~50\,
	waddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][5]_waddr\,
	raddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][5]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst15|lpm_ram_dq_component|sram|segment[0][5]_modesel\,
	dataout => \inst9|inst15|lpm_ram_dq_component|sram|q[5]\);

\inst9|inst1|I2|data_is_c[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|data_is_c[1]\ = DFFE(\inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|data_is_c[1]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[5]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[5]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CAAA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst15|lpm_ram_dq_component|sram|q[5]\,
	datab => \inst9|inst1|I2|data_is_c[1]\,
	datac => \inst9|inst1|I2|i~2\,
	datad => \inst9|inst1|I2|i~509\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|data_is_c[1]\);

\inst9|inst|Decoder_28~17_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|Decoder_28~17\ = !\inst9|inst|rx_bit_count[2]\ & \inst9|inst|rx_bit_count[0]\ & !\inst9|inst|rx_bit_count[1]\ & !\inst9|inst|rx_bit_count[3]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0004",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_bit_count[2]\,
	datab => \inst9|inst|rx_bit_count[0]\,
	datac => \inst9|inst|rx_bit_count[1]\,
	datad => \inst9|inst|rx_bit_count[3]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|Decoder_28~17\);

\inst9|inst|rx_uart_reg[1]~8_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[1]~8\ = \inst9|inst|Decoder_28~17\ & !\inst9|inst|reduce_nor_27\ & \rtl~9986\ & \inst9|inst|reduce_nor_7\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|Decoder_28~17\,
	datab => \inst9|inst|reduce_nor_27\,
	datac => \rtl~9986\,
	datad => \inst9|inst|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|rx_uart_reg[1]~8\);

\inst9|inst|rx_uart_reg[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[1]\ = DFFE(!\RXD~combout\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|rx_uart_reg[1]~8\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \RXD~combout\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|rx_uart_reg[1]~8\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_reg[1]\);

\inst9|inst|rx_uart_fifo[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_fifo[1]\ = DFFE(!\inst9|inst|rx_uart_reg[1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|rx_uart_fifo[4]~37\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst|rx_uart_reg[1]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|rx_uart_fifo[4]~37\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_fifo[1]\);

\inst9|inst12|i~420_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|i~420\ = \inst9|inst19|mux_c[1]\ & \inst9|inst|rx_uart_fifo[1]\ # !\inst9|inst19|mux_c[1]\ & !\inst9|inst|rx_uart_full_c\ & \inst9|inst|rx_uart_full_d\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8D88",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst19|mux_c[1]\,
	datab => \inst9|inst|rx_uart_fifo[1]\,
	datac => \inst9|inst|rx_uart_full_c\,
	datad => \inst9|inst|rx_uart_full_d\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|i~420\);

\inst9|inst1|I3|data_x[1]~276_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[1]~276\ = \inst9|inst1|I3|data_x[2]~2293\ & (\inst9|inst19|Mux_13_rtl_0~0\ & \inst9|inst12|i~420\ # !\inst9|inst19|Mux_13_rtl_0~0\ & \inst9|inst15|lpm_ram_dq_component|sram|q[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E200",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst15|lpm_ram_dq_component|sram|q[1]\,
	datab => \inst9|inst19|Mux_13_rtl_0~0\,
	datac => \inst9|inst12|i~420\,
	datad => \inst9|inst1|I3|data_x[2]~2293\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[1]~276\);

\inst9|inst1|I3|data_x[1]~189_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[1]~189\ = \inst9|inst1|I4|reduce_nor_106\ & \inst9|inst1|I4|iinc_c[1]\ & \inst9|inst1|I2|ndre_x~41\ # !\inst9|inst1|I4|reduce_nor_106\ & \inst9|inst1|I4|ireg_c[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "AC0C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|iinc_c[1]\,
	datab => \inst9|inst1|I4|ireg_c[1]\,
	datac => \inst9|inst1|I4|reduce_nor_106\,
	datad => \inst9|inst1|I2|ndre_x~41\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[1]~189\);

\inst9|inst1|I3|data_x[1]~195_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[1]~195\ = \inst9|inst1|I4|i~18\ & \inst9|inst1|I3|reduce_nor_71\ & \inst9|inst1|I3|data_x[1]~189\ & \inst9|inst1|I4|i~616\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~18\,
	datab => \inst9|inst1|I3|reduce_nor_71\,
	datac => \inst9|inst1|I3|data_x[1]~189\,
	datad => \inst9|inst1|I4|i~616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[1]~195\);

\inst9|inst1|I3|data_x[1]~2272_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[1]~2272\ = \inst9|inst1|I3|data_x[1]~276\ # \inst9|inst1|I3|data_x[1]~195\ # \inst9|inst1|I2|data_is_c[1]\ & !\inst9|inst1|I3|reduce_nor_71\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|data_is_c[1]\,
	datab => \inst9|inst1|I3|reduce_nor_71\,
	datac => \inst9|inst1|I3|data_x[1]~276\,
	datad => \inst9|inst1|I3|data_x[1]~195\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[1]~2272\);

\rtl~10661_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10661\ = \rtl~9972\ & (\inst9|inst1|I3|data_x[1]~2272\ $ (\inst9|inst1|I3|acc_c[0][1]\ & \inst9|inst1|I2|TD_c[0]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2A80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~9972\,
	datab => \inst9|inst1|I3|acc_c[0][1]\,
	datac => \inst9|inst1|I2|TD_c[0]\,
	datad => \inst9|inst1|I3|data_x[1]~2272\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10661\);

\rtl~2084_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2084\ = \inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][2]\ & !\inst9|inst1|I2|TD_c[1]\ # !\inst9|inst1|I2|TD_c[2]\ & (\inst9|inst1|I2|TD_c[1]\ & \inst9|inst1|I3|acc_c[0][2]\ # !\inst9|inst1|I2|TD_c[1]\ & \inst9|inst1|I3|acc_c[0][1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2B28",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][2]\,
	datab => \inst9|inst1|I2|TD_c[2]\,
	datac => \inst9|inst1|I2|TD_c[1]\,
	datad => \inst9|inst1|I3|acc_c[0][1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2084\);

\rtl~2202_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2202\ = \inst9|inst1|I2|TD_c[2]\ & (\inst9|inst1|I2|TD_c[1]\ $ \inst9|inst1|I3|acc_c[0][1]\) # !\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "74B8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[1]\,
	datab => \inst9|inst1|I2|TD_c[2]\,
	datac => \inst9|inst1|I3|acc_c[0][0]\,
	datad => \inst9|inst1|I3|acc_c[0][1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2202\);

\rtl~1824_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1824\ = !\inst9|inst1|I3|Mux_201_rtl_146~0\ & (\inst9|inst1|I2|TD_c[0]\ & \rtl~2202\ # !\inst9|inst1|I2|TD_c[0]\ & \rtl~2084\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5404",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	datab => \rtl~2084\,
	datac => \inst9|inst1|I2|TD_c[0]\,
	datad => \rtl~2202\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1824\);

\rtl~1596_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1596\ = !\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|Mux_201_rtl_146~0\ & !\inst9|inst1|I2|TD_c[1]\ & \inst9|inst1|I3|acc_c[0][1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[2]\,
	datab => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	datac => \inst9|inst1|I2|TD_c[1]\,
	datad => \inst9|inst1|I3|acc_c[0][1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1596\);

\inst9|inst1|I3|Mux_177_rtl_133_rtl_369~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|Mux_177_rtl_133_rtl_369~0\ = \inst9|inst1|I2|TD_c[1]\ & (\inst9|inst1|I2|TD_c[0]\ # \inst9|inst1|I3|add_153~2\) # !\inst9|inst1|I2|TD_c[1]\ & !\inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|add_129~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "D9C8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[0]\,
	datab => \inst9|inst1|I2|TD_c[1]\,
	datac => \inst9|inst1|I3|add_153~2\,
	datad => \inst9|inst1|I3|add_129~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|Mux_177_rtl_133_rtl_369~0\);

\inst9|inst1|I3|Mux_177_rtl_133_rtl_369~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|Mux_177_rtl_133_rtl_369~1\ = \inst9|inst1|I3|acc_c[0][1]\ & (\inst9|inst1|I3|Mux_177_rtl_133_rtl_369~0\ # \inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|data_x[1]~2272\) # !\inst9|inst1|I3|acc_c[0][1]\ & \inst9|inst1|I3|Mux_177_rtl_133_rtl_369~0\ & (\inst9|inst1|I3|data_x[1]~2272\ # !\inst9|inst1|I2|TD_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FD80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[0]\,
	datab => \inst9|inst1|I3|acc_c[0][1]\,
	datac => \inst9|inst1|I3|data_x[1]~2272\,
	datad => \inst9|inst1|I3|Mux_177_rtl_133_rtl_369~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|Mux_177_rtl_133_rtl_369~1\);

\rtl~10644_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10644\ = \rtl~1824\ # \rtl~1596\ # \rtl~9988\ & \inst9|inst1|I3|Mux_177_rtl_133_rtl_369~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FEEE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~1824\,
	datab => \rtl~1596\,
	datac => \rtl~9988\,
	datad => \inst9|inst1|I3|Mux_177_rtl_133_rtl_369~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10644\);

\inst9|inst1|I3|acc_i[0][1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_i[0][1]\ = DFFE(\inst9|inst1|I3|acc[0][1]~4440\ # \inst9|inst1|I3|acc[0][4]~4338\ & (\rtl~10661\ # \rtl~10644\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst1|I2|int_start_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FAEA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][1]~4440\,
	datab => \rtl~10661\,
	datac => \inst9|inst1|I3|acc[0][4]~4338\,
	datad => \rtl~10644\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_i[0][1]\);

\inst9|inst1|I3|acc[0][1]~4440_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc[0][1]~4440\ = \inst9|inst1|I3|acc_c[0][1]\ & (\inst9|inst1|I3|acc[0][4]~63\ # \inst9|inst1|I3|acc[0][4]~4339\ & \inst9|inst1|I3|acc_i[0][1]\) # !\inst9|inst1|I3|acc_c[0][1]\ & \inst9|inst1|I3|acc[0][4]~4339\ & \inst9|inst1|I3|acc_i[0][1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ECA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][1]\,
	datab => \inst9|inst1|I3|acc[0][4]~4339\,
	datac => \inst9|inst1|I3|acc[0][4]~63\,
	datad => \inst9|inst1|I3|acc_i[0][1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|acc[0][1]~4440\);

\inst9|inst1|I3|acc_c[0][1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_c[0][1]\ = DFFE(\inst9|inst1|I3|acc[0][1]~4440\ # \inst9|inst1|I3|acc[0][4]~4338\ & (\rtl~10661\ # \rtl~10644\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FAEA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][1]~4440\,
	datab => \rtl~10661\,
	datac => \inst9|inst1|I3|acc[0][4]~4338\,
	datad => \rtl~10644\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_c[0][1]\);

\inst9|inst10|i~366_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|i~366\ = \inst9|inst1|I4|ndre_x~1\ & !\inst9|inst12|cpu_daddr_c[3]\ # !\inst9|inst1|I4|ndre_x~1\ & !\inst9|inst12|cpu_daddr_x[3]~11\ # !\inst9|inst2|i~455\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4F7F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|cpu_daddr_c[3]\,
	datab => \inst9|inst1|I4|ndre_x~1\,
	datac => \inst9|inst2|i~455\,
	datad => \inst9|inst12|cpu_daddr_x[3]~11\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|i~366\);

\inst9|inst10|i~71_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|i~71\ = \inst9|inst12|i~127\ & !\inst9|inst12|i~115\ & !\inst9|inst10|i~366\ & \inst9|inst12|i~103\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0200",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|i~127\,
	datab => \inst9|inst12|i~115\,
	datac => \inst9|inst10|i~366\,
	datad => \inst9|inst12|i~103\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|i~71\);

\inst9|inst10|tmr_reset~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_reset\ = DFFE(!\inst9|inst1|I3|acc_c[0][1]\ # !\inst9|inst7\ # !\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst10|i~71\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "3FFF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I3|acc_c[0][1]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst10|i~71\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_reset\);

\inst9|inst19|reduce_nor_26~32_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst19|reduce_nor_26~32\ = !\inst9|inst12|i~115\ & (\inst9|inst1|I4|ndre_x~1\ & \inst9|inst12|cpu_daddr_c[2]\ # !\inst9|inst1|I4|ndre_x~1\ & \inst9|inst12|cpu_daddr_x[2]~10\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00AC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|cpu_daddr_c[2]\,
	datab => \inst9|inst12|cpu_daddr_x[2]~10\,
	datac => \inst9|inst1|I4|ndre_x~1\,
	datad => \inst9|inst12|i~115\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst19|reduce_nor_26~32\);

\inst9|inst10|i~80_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|i~80\ = \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[7]\ & (\inst9|inst10|i~366\ # \inst9|inst12|i~127\ # !\inst9|inst19|reduce_nor_26~32\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A8AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[7]\,
	datab => \inst9|inst10|i~366\,
	datac => \inst9|inst12|i~127\,
	datad => \inst9|inst19|reduce_nor_26~32\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|i~80\);

\inst9|inst10|i~79_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|i~79\ = \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[6]\ & (\inst9|inst10|i~366\ # \inst9|inst12|i~127\ # !\inst9|inst19|reduce_nor_26~32\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A8AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[6]\,
	datab => \inst9|inst10|i~366\,
	datac => \inst9|inst12|i~127\,
	datad => \inst9|inst19|reduce_nor_26~32\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|i~79\);

\inst9|inst10|i~78_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|i~78\ = \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[5]\ & (\inst9|inst10|i~366\ # \inst9|inst12|i~127\ # !\inst9|inst19|reduce_nor_26~32\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A8AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[5]\,
	datab => \inst9|inst10|i~366\,
	datac => \inst9|inst12|i~127\,
	datad => \inst9|inst19|reduce_nor_26~32\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|i~78\);

\inst9|inst10|i~77_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|i~77\ = \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[4]\ & (\inst9|inst10|i~366\ # \inst9|inst12|i~127\ # !\inst9|inst19|reduce_nor_26~32\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A8AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[4]\,
	datab => \inst9|inst10|i~366\,
	datac => \inst9|inst12|i~127\,
	datad => \inst9|inst19|reduce_nor_26~32\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|i~77\);

\inst9|inst10|i~76_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|i~76\ = \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[3]\ & (\inst9|inst10|i~366\ # \inst9|inst12|i~127\ # !\inst9|inst19|reduce_nor_26~32\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A8AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[3]\,
	datab => \inst9|inst10|i~366\,
	datac => \inst9|inst12|i~127\,
	datad => \inst9|inst19|reduce_nor_26~32\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|i~76\);

\inst9|inst10|i~75_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|i~75\ = \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[2]\ & (\inst9|inst10|i~366\ # \inst9|inst12|i~127\ # !\inst9|inst19|reduce_nor_26~32\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A8AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[2]\,
	datab => \inst9|inst10|i~366\,
	datac => \inst9|inst12|i~127\,
	datad => \inst9|inst19|reduce_nor_26~32\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|i~75\);

\inst9|inst10|i~74_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|i~74\ = \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[1]\ & (\inst9|inst10|i~366\ # \inst9|inst12|i~127\ # !\inst9|inst19|reduce_nor_26~32\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A8AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[1]\,
	datab => \inst9|inst10|i~366\,
	datac => \inst9|inst12|i~127\,
	datad => \inst9|inst19|reduce_nor_26~32\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|i~74\);

\inst9|inst10|tmr_enable~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_enable\ = DFFE(\inst9|inst1|I3|acc_c[0][0]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst10|i~71\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][0]\,
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datad => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst10|i~71\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_enable\);

\inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[0]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[0]\ = DFFE((!\inst9|inst10|tmr_enable\ & \inst9|inst10|i~73\) # (\inst9|inst10|tmr_enable\ & !\inst9|inst10|tmr_low_rtl_28|wysi_counter|q[0]\) & GLOBAL(\inst9|inst10|tmr_reset\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[0]~COUT\ = CARRY(\inst9|inst10|tmr_low_rtl_28|wysi_counter|q[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "qfbk_counter",
	packed_mode => "false",
	lut_mask => "0FF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst10|i~73\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sclr => \NOT_inst9|inst10|tmr_reset\,
	sload => \NOT_inst9|inst10|tmr_enable\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[0]\,
	cout => \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[0]~COUT\);

\inst9|inst10|i~73_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|i~73\ = \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[0]\ & (\inst9|inst10|i~366\ # \inst9|inst12|i~127\ # !\inst9|inst19|reduce_nor_26~32\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A8AA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[0]\,
	datab => \inst9|inst10|i~366\,
	datac => \inst9|inst12|i~127\,
	datad => \inst9|inst19|reduce_nor_26~32\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|i~73\);

\inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[1]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[1]\ = DFFE((!\inst9|inst10|tmr_enable\ & \inst9|inst10|i~74\) # (\inst9|inst10|tmr_enable\ & \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[1]\ $ \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[0]~COUT\) & GLOBAL(\inst9|inst10|tmr_reset\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[1]~COUT\ = CARRY(!\inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[0]~COUT\ # !\inst9|inst10|tmr_low_rtl_28|wysi_counter|q[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5A5F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[1]\,
	datac => \inst9|inst10|i~74\,
	cin => \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[0]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sclr => \NOT_inst9|inst10|tmr_reset\,
	sload => \NOT_inst9|inst10|tmr_enable\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[1]\,
	cout => \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[1]~COUT\);

\inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[2]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[2]\ = DFFE((!\inst9|inst10|tmr_enable\ & \inst9|inst10|i~75\) # (\inst9|inst10|tmr_enable\ & \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[2]\ $ !\inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[1]~COUT\) & GLOBAL(\inst9|inst10|tmr_reset\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[2]~COUT\ = CARRY(\inst9|inst10|tmr_low_rtl_28|wysi_counter|q[2]\ & !\inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[1]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "C30C",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[2]\,
	datac => \inst9|inst10|i~75\,
	cin => \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[1]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sclr => \NOT_inst9|inst10|tmr_reset\,
	sload => \NOT_inst9|inst10|tmr_enable\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[2]\,
	cout => \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[2]~COUT\);

\inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[3]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[3]\ = DFFE((!\inst9|inst10|tmr_enable\ & \inst9|inst10|i~76\) # (\inst9|inst10|tmr_enable\ & \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[3]\ $ \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[2]~COUT\) & GLOBAL(\inst9|inst10|tmr_reset\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[3]~COUT\ = CARRY(!\inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[2]~COUT\ # !\inst9|inst10|tmr_low_rtl_28|wysi_counter|q[3]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5A5F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[3]\,
	datac => \inst9|inst10|i~76\,
	cin => \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[2]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sclr => \NOT_inst9|inst10|tmr_reset\,
	sload => \NOT_inst9|inst10|tmr_enable\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[3]\,
	cout => \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[3]~COUT\);

\inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[4]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[4]\ = DFFE((!\inst9|inst10|tmr_enable\ & \inst9|inst10|i~77\) # (\inst9|inst10|tmr_enable\ & \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[4]\ $ !\inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[3]~COUT\) & GLOBAL(\inst9|inst10|tmr_reset\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[4]~COUT\ = CARRY(\inst9|inst10|tmr_low_rtl_28|wysi_counter|q[4]\ & !\inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[3]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "A50A",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[4]\,
	datac => \inst9|inst10|i~77\,
	cin => \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[3]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sclr => \NOT_inst9|inst10|tmr_reset\,
	sload => \NOT_inst9|inst10|tmr_enable\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[4]\,
	cout => \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[4]~COUT\);

\inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[5]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[5]\ = DFFE((!\inst9|inst10|tmr_enable\ & \inst9|inst10|i~78\) # (\inst9|inst10|tmr_enable\ & \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[5]\ $ \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[4]~COUT\) & GLOBAL(\inst9|inst10|tmr_reset\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[5]~COUT\ = CARRY(!\inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[4]~COUT\ # !\inst9|inst10|tmr_low_rtl_28|wysi_counter|q[5]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5A5F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[5]\,
	datac => \inst9|inst10|i~78\,
	cin => \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[4]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sclr => \NOT_inst9|inst10|tmr_reset\,
	sload => \NOT_inst9|inst10|tmr_enable\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[5]\,
	cout => \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[5]~COUT\);

\inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[6]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[6]\ = DFFE((!\inst9|inst10|tmr_enable\ & \inst9|inst10|i~79\) # (\inst9|inst10|tmr_enable\ & \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[6]\ $ !\inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[5]~COUT\) & GLOBAL(\inst9|inst10|tmr_reset\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[6]~COUT\ = CARRY(\inst9|inst10|tmr_low_rtl_28|wysi_counter|q[6]\ & !\inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[5]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "A50A",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[6]\,
	datac => \inst9|inst10|i~79\,
	cin => \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[5]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sclr => \NOT_inst9|inst10|tmr_reset\,
	sload => \NOT_inst9|inst10|tmr_enable\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[6]\,
	cout => \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[6]~COUT\);

\inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[7]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[7]\ = DFFE((!\inst9|inst10|tmr_enable\ & \inst9|inst10|i~80\) # (\inst9|inst10|tmr_enable\ & \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[6]~COUT\ $ \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[7]\) & GLOBAL(\inst9|inst10|tmr_reset\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "0FF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst10|i~80\,
	datad => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[7]\,
	cin => \inst9|inst10|tmr_low_rtl_28|wysi_counter|counter_cell[6]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sclr => \NOT_inst9|inst10|tmr_reset\,
	sload => \NOT_inst9|inst10|tmr_enable\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[7]\);

\inst9|inst10|reduce_nor_58~42_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|reduce_nor_58~42\ = \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[7]\ # \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[6]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[7]\,
	datad => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[6]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|reduce_nor_58~42\);

\inst9|inst10|reduce_nor_58~35_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|reduce_nor_58~35\ = \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[3]\ # \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[1]\ # \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[2]\ # \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[3]\,
	datab => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[1]\,
	datac => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[2]\,
	datad => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|reduce_nor_58~35\);

\inst9|inst10|reduce_nor_58~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|reduce_nor_58\ = \inst9|inst10|reduce_nor_58~42\ # \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[4]\ # \inst9|inst10|reduce_nor_58~35\ # \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[5]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|reduce_nor_58~42\,
	datab => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[4]\,
	datac => \inst9|inst10|reduce_nor_58~35\,
	datad => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[5]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|reduce_nor_58\);

\inst9|inst10|add_47_rtl_17~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17~0\ = !\inst9|inst10|tmr_high[0]\
-- \inst9|inst10|add_47_rtl_17~0COUT\ = CARRY(\inst9|inst10|tmr_high[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	packed_mode => "false",
	lut_mask => "33CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst10|tmr_high[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17~0\,
	cout => \inst9|inst10|add_47_rtl_17~0COUT\);

\inst9|inst10|tmr_count[7]~7_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_count[7]~7\ = !\inst9|inst10|i~366\ & \inst9|inst7\ & !\inst9|inst12|i~127\ & \inst9|inst19|reduce_nor_26~32\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|i~366\,
	datab => \inst9|inst7\,
	datac => \inst9|inst12|i~127\,
	datad => \inst9|inst19|reduce_nor_26~32\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|tmr_count[7]~7\);

\inst9|inst10|tmr_count[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_count[0]\ = DFFE(\inst9|inst7\ & \inst9|inst1|I3|acc_c[0][0]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), , , \inst9|inst10|tmr_count[7]~7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datac => \inst9|inst1|I3|acc_c[0][0]\,
	datad => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	clk => \clk~combout\,
	ena => \inst9|inst10|tmr_count[7]~7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_count[0]\);

\inst9|inst10|add_47_rtl_17_rtl_481~373_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17_rtl_481~373\ = \inst9|inst10|i~352\ & !\inst9|inst10|reduce_nor_58\ & \inst9|inst10|add_47_rtl_17~0\ # !\inst9|inst10|i~352\ & \inst9|inst10|tmr_count[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7520",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|i~352\,
	datab => \inst9|inst10|reduce_nor_58\,
	datac => \inst9|inst10|add_47_rtl_17~0\,
	datad => \inst9|inst10|tmr_count[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17_rtl_481~373\);

\inst9|inst10|reduce_nor_58~30_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|reduce_nor_58~30\ = \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[7]\ # \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[5]\ # \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[6]\ # \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[4]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[7]\,
	datab => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[5]\,
	datac => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[6]\,
	datad => \inst9|inst10|tmr_low_rtl_28|wysi_counter|q[4]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|reduce_nor_58~30\);

\inst9|inst10|add_47_rtl_17_rtl_481~2506_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17_rtl_481~2506\ = \inst9|inst10|tmr_reset\ & (\inst9|inst10|reduce_nor_58~35\ # \inst9|inst10|reduce_nor_58~30\ # !\inst9|inst10|tmr_enable\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0D0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_enable\,
	datab => \inst9|inst10|reduce_nor_58~35\,
	datac => \inst9|inst10|tmr_reset\,
	datad => \inst9|inst10|reduce_nor_58~30\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17_rtl_481~2506\);

\inst9|inst10|i~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|i~1\ = \inst9|inst12|i~115\ # \inst9|inst12|i~127\ # \inst9|inst10|i~366\ # !\inst9|inst12|i~103\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFEF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|i~115\,
	datab => \inst9|inst12|i~127\,
	datac => \inst9|inst12|i~103\,
	datad => \inst9|inst10|i~366\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|i~1\);

\inst9|inst10|add_47_rtl_17_rtl_481~236_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17_rtl_481~236\ = \inst9|inst10|add_47_rtl_17_rtl_481~2506\ & (\inst9|inst10|i~1\ & \inst9|inst10|tmr_high[0]\ # !\inst9|inst10|i~1\ & \inst9|inst1|I4|data_ox[0]~7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|add_47_rtl_17_rtl_481~2506\,
	datab => \inst9|inst10|tmr_high[0]\,
	datac => \inst9|inst1|I4|data_ox[0]~7\,
	datad => \inst9|inst10|i~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17_rtl_481~236\);

\inst9|inst10|tmr_high[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_high[0]\ = DFFE(\inst9|inst10|add_47_rtl_17_rtl_481~236\ # \inst9|inst10|add_47_rtl_17_rtl_481~373\ & \inst9|inst10|tmr_reset\ & \inst9|inst10|tmr_enable\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|add_47_rtl_17_rtl_481~373\,
	datab => \inst9|inst10|tmr_reset\,
	datac => \inst9|inst10|tmr_enable\,
	datad => \inst9|inst10|add_47_rtl_17_rtl_481~236\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_high[0]\);

\inst9|inst10|add_47_rtl_17~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17~1\ = \inst9|inst10|tmr_high[1]\ $ !\inst9|inst10|add_47_rtl_17~0COUT\
-- \inst9|inst10|add_47_rtl_17~1COUT\ = CARRY(!\inst9|inst10|tmr_high[1]\ & !\inst9|inst10|add_47_rtl_17~0COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "C303",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst10|tmr_high[1]\,
	cin => \inst9|inst10|add_47_rtl_17~0COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17~1\,
	cout => \inst9|inst10|add_47_rtl_17~1COUT\);

\inst9|inst10|tmr_count[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_count[1]\ = DFFE(\inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst1|I3|acc_c[0][1]\, GLOBAL(\clk~combout\), , , \inst9|inst10|tmr_count[7]~7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8800",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datad => \inst9|inst1|I3|acc_c[0][1]\,
	clk => \clk~combout\,
	ena => \inst9|inst10|tmr_count[7]~7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_count[1]\);

\inst9|inst10|add_47_rtl_17_rtl_481~355_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17_rtl_481~355\ = \inst9|inst10|i~352\ & !\inst9|inst10|reduce_nor_58\ & \inst9|inst10|add_47_rtl_17~1\ # !\inst9|inst10|i~352\ & \inst9|inst10|tmr_count[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7520",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|i~352\,
	datab => \inst9|inst10|reduce_nor_58\,
	datac => \inst9|inst10|add_47_rtl_17~1\,
	datad => \inst9|inst10|tmr_count[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17_rtl_481~355\);

\inst9|inst10|add_47_rtl_17_rtl_481~225_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17_rtl_481~225\ = \inst9|inst10|add_47_rtl_17_rtl_481~2506\ & (\inst9|inst10|i~1\ & \inst9|inst10|tmr_high[1]\ # !\inst9|inst10|i~1\ & \inst9|inst1|I4|data_ox[1]~6\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A088",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|add_47_rtl_17_rtl_481~2506\,
	datab => \inst9|inst1|I4|data_ox[1]~6\,
	datac => \inst9|inst10|tmr_high[1]\,
	datad => \inst9|inst10|i~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17_rtl_481~225\);

\inst9|inst10|tmr_high[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_high[1]\ = DFFE(\inst9|inst10|add_47_rtl_17_rtl_481~225\ # \inst9|inst10|tmr_reset\ & \inst9|inst10|tmr_enable\ & \inst9|inst10|add_47_rtl_17_rtl_481~355\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_reset\,
	datab => \inst9|inst10|tmr_enable\,
	datac => \inst9|inst10|add_47_rtl_17_rtl_481~355\,
	datad => \inst9|inst10|add_47_rtl_17_rtl_481~225\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_high[1]\);

\inst9|inst10|tmr_count[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_count[3]\ = DFFE(\inst9|inst1|I3|acc_c[0][3]\ & \inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), , , \inst9|inst10|tmr_count[7]~7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8800",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][3]\,
	datab => \inst9|inst7\,
	datad => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	clk => \clk~combout\,
	ena => \inst9|inst10|tmr_count[7]~7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_count[3]\);

\inst9|inst10|tmr_count[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_count[2]\ = DFFE(\inst9|inst7\ & \inst9|inst1|I3|acc_c[0][2]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), , , \inst9|inst10|tmr_count[7]~7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst7\,
	datac => \inst9|inst1|I3|acc_c[0][2]\,
	datad => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	clk => \clk~combout\,
	ena => \inst9|inst10|tmr_count[7]~7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_count[2]\);

\inst9|inst10|add_47_rtl_17~2_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17~2\ = \inst9|inst10|tmr_high[2]\ $ \inst9|inst10|add_47_rtl_17~1COUT\
-- \inst9|inst10|add_47_rtl_17~2COUT\ = CARRY(\inst9|inst10|tmr_high[2]\ # !\inst9|inst10|add_47_rtl_17~1COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5AAF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_high[2]\,
	cin => \inst9|inst10|add_47_rtl_17~1COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17~2\,
	cout => \inst9|inst10|add_47_rtl_17~2COUT\);

\inst9|inst10|add_47_rtl_17_rtl_481~337_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17_rtl_481~337\ = \inst9|inst10|i~352\ & \inst9|inst10|add_47_rtl_17~2\ & !\inst9|inst10|reduce_nor_58\ # !\inst9|inst10|i~352\ & \inst9|inst10|tmr_count[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "44E4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|i~352\,
	datab => \inst9|inst10|tmr_count[2]\,
	datac => \inst9|inst10|add_47_rtl_17~2\,
	datad => \inst9|inst10|reduce_nor_58\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17_rtl_481~337\);

\inst9|inst10|add_47_rtl_17_rtl_481~214_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17_rtl_481~214\ = \inst9|inst10|add_47_rtl_17_rtl_481~2506\ & (\inst9|inst10|i~1\ & \inst9|inst10|tmr_high[2]\ # !\inst9|inst10|i~1\ & \inst9|inst1|I4|data_ox[2]~5\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A0C0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_high[2]\,
	datab => \inst9|inst1|I4|data_ox[2]~5\,
	datac => \inst9|inst10|add_47_rtl_17_rtl_481~2506\,
	datad => \inst9|inst10|i~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17_rtl_481~214\);

\inst9|inst10|tmr_high[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_high[2]\ = DFFE(\inst9|inst10|add_47_rtl_17_rtl_481~214\ # \inst9|inst10|add_47_rtl_17_rtl_481~337\ & \inst9|inst10|tmr_reset\ & \inst9|inst10|tmr_enable\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|add_47_rtl_17_rtl_481~337\,
	datab => \inst9|inst10|tmr_reset\,
	datac => \inst9|inst10|tmr_enable\,
	datad => \inst9|inst10|add_47_rtl_17_rtl_481~214\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_high[2]\);

\inst9|inst10|add_47_rtl_17~3_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17~3\ = \inst9|inst10|tmr_high[3]\ $ !\inst9|inst10|add_47_rtl_17~2COUT\
-- \inst9|inst10|add_47_rtl_17~3COUT\ = CARRY(!\inst9|inst10|tmr_high[3]\ & !\inst9|inst10|add_47_rtl_17~2COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "C303",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst10|tmr_high[3]\,
	cin => \inst9|inst10|add_47_rtl_17~2COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17~3\,
	cout => \inst9|inst10|add_47_rtl_17~3COUT\);

\inst9|inst10|add_47_rtl_17_rtl_481~319_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17_rtl_481~319\ = \inst9|inst10|i~352\ & \inst9|inst10|add_47_rtl_17~3\ & !\inst9|inst10|reduce_nor_58\ # !\inst9|inst10|i~352\ & \inst9|inst10|tmr_count[3]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "22E2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_count[3]\,
	datab => \inst9|inst10|i~352\,
	datac => \inst9|inst10|add_47_rtl_17~3\,
	datad => \inst9|inst10|reduce_nor_58\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17_rtl_481~319\);

\inst9|inst10|add_47_rtl_17_rtl_481~203_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17_rtl_481~203\ = \inst9|inst10|add_47_rtl_17_rtl_481~2506\ & (\inst9|inst10|i~1\ & \inst9|inst10|tmr_high[3]\ # !\inst9|inst10|i~1\ & \inst9|inst1|I4|data_ox[3]~4\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8A80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|add_47_rtl_17_rtl_481~2506\,
	datab => \inst9|inst10|tmr_high[3]\,
	datac => \inst9|inst10|i~1\,
	datad => \inst9|inst1|I4|data_ox[3]~4\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17_rtl_481~203\);

\inst9|inst10|tmr_high[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_high[3]\ = DFFE(\inst9|inst10|add_47_rtl_17_rtl_481~203\ # \inst9|inst10|tmr_reset\ & \inst9|inst10|add_47_rtl_17_rtl_481~319\ & \inst9|inst10|tmr_enable\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_reset\,
	datab => \inst9|inst10|add_47_rtl_17_rtl_481~319\,
	datac => \inst9|inst10|tmr_enable\,
	datad => \inst9|inst10|add_47_rtl_17_rtl_481~203\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_high[3]\);

\inst9|inst10|i~339_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|i~339\ = \inst9|inst10|tmr_high[0]\ # \inst9|inst10|tmr_high[1]\ # \inst9|inst10|tmr_high[3]\ # \inst9|inst10|tmr_high[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_high[0]\,
	datab => \inst9|inst10|tmr_high[1]\,
	datac => \inst9|inst10|tmr_high[3]\,
	datad => \inst9|inst10|tmr_high[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|i~339\);

\inst9|inst10|tmr_count[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_count[6]\ = DFFE(\inst9|inst7\ & \inst9|inst1|I3|acc_c[0][6]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), , , \inst9|inst10|tmr_count[7]~7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datab => \inst9|inst1|I3|acc_c[0][6]\,
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	clk => \clk~combout\,
	ena => \inst9|inst10|tmr_count[7]~7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_count[6]\);

\inst9|inst10|tmr_count[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_count[5]\ = DFFE(\inst9|inst1|I3|acc_c[0][5]\ & \inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), , , \inst9|inst10|tmr_count[7]~7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][5]\,
	datab => \inst9|inst7\,
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	clk => \clk~combout\,
	ena => \inst9|inst10|tmr_count[7]~7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_count[5]\);

\inst9|inst10|add_47_rtl_17_rtl_481~192_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17_rtl_481~192\ = \inst9|inst10|add_47_rtl_17_rtl_481~2506\ & (\inst9|inst10|i~1\ & \inst9|inst10|tmr_high[4]\ # !\inst9|inst10|i~1\ & \inst9|inst1|I4|data_ox[4]~3\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "88A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|add_47_rtl_17_rtl_481~2506\,
	datab => \inst9|inst10|tmr_high[4]\,
	datac => \inst9|inst1|I4|data_ox[4]~3\,
	datad => \inst9|inst10|i~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17_rtl_481~192\);

\inst9|inst10|tmr_count[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_count[4]\ = DFFE(\inst9|inst7\ & \inst9|inst1|I3|acc_c[0][4]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), , , \inst9|inst10|tmr_count[7]~7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datab => \inst9|inst1|I3|acc_c[0][4]\,
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	clk => \clk~combout\,
	ena => \inst9|inst10|tmr_count[7]~7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_count[4]\);

\inst9|inst10|add_47_rtl_17~4_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17~4\ = \inst9|inst10|tmr_high[4]\ $ \inst9|inst10|add_47_rtl_17~3COUT\
-- \inst9|inst10|add_47_rtl_17~4COUT\ = CARRY(\inst9|inst10|tmr_high[4]\ # !\inst9|inst10|add_47_rtl_17~3COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5AAF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_high[4]\,
	cin => \inst9|inst10|add_47_rtl_17~3COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17~4\,
	cout => \inst9|inst10|add_47_rtl_17~4COUT\);

\inst9|inst10|add_47_rtl_17_rtl_481~301_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17_rtl_481~301\ = \inst9|inst10|i~352\ & !\inst9|inst10|reduce_nor_58\ & \inst9|inst10|add_47_rtl_17~4\ # !\inst9|inst10|i~352\ & \inst9|inst10|tmr_count[4]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4E44",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|i~352\,
	datab => \inst9|inst10|tmr_count[4]\,
	datac => \inst9|inst10|reduce_nor_58\,
	datad => \inst9|inst10|add_47_rtl_17~4\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17_rtl_481~301\);

\inst9|inst10|tmr_high[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_high[4]\ = DFFE(\inst9|inst10|add_47_rtl_17_rtl_481~192\ # \inst9|inst10|tmr_reset\ & \inst9|inst10|tmr_enable\ & \inst9|inst10|add_47_rtl_17_rtl_481~301\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F8F0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_reset\,
	datab => \inst9|inst10|tmr_enable\,
	datac => \inst9|inst10|add_47_rtl_17_rtl_481~192\,
	datad => \inst9|inst10|add_47_rtl_17_rtl_481~301\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_high[4]\);

\inst9|inst10|add_47_rtl_17~5_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17~5\ = \inst9|inst10|tmr_high[5]\ $ !\inst9|inst10|add_47_rtl_17~4COUT\
-- \inst9|inst10|add_47_rtl_17~5COUT\ = CARRY(!\inst9|inst10|tmr_high[5]\ & !\inst9|inst10|add_47_rtl_17~4COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "A505",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_high[5]\,
	cin => \inst9|inst10|add_47_rtl_17~4COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17~5\,
	cout => \inst9|inst10|add_47_rtl_17~5COUT\);

\inst9|inst10|add_47_rtl_17_rtl_481~283_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17_rtl_481~283\ = \inst9|inst10|i~352\ & !\inst9|inst10|reduce_nor_58\ & \inst9|inst10|add_47_rtl_17~5\ # !\inst9|inst10|i~352\ & \inst9|inst10|tmr_count[5]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7250",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|i~352\,
	datab => \inst9|inst10|reduce_nor_58\,
	datac => \inst9|inst10|tmr_count[5]\,
	datad => \inst9|inst10|add_47_rtl_17~5\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17_rtl_481~283\);

\inst9|inst10|add_47_rtl_17_rtl_481~181_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17_rtl_481~181\ = \inst9|inst10|add_47_rtl_17_rtl_481~2506\ & (\inst9|inst10|i~1\ & \inst9|inst10|tmr_high[5]\ # !\inst9|inst10|i~1\ & \inst9|inst1|I4|data_ox[5]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|data_ox[5]~2\,
	datab => \inst9|inst10|tmr_high[5]\,
	datac => \inst9|inst10|add_47_rtl_17_rtl_481~2506\,
	datad => \inst9|inst10|i~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17_rtl_481~181\);

\inst9|inst10|tmr_high[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_high[5]\ = DFFE(\inst9|inst10|add_47_rtl_17_rtl_481~181\ # \inst9|inst10|tmr_enable\ & \inst9|inst10|add_47_rtl_17_rtl_481~283\ & \inst9|inst10|tmr_reset\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_enable\,
	datab => \inst9|inst10|add_47_rtl_17_rtl_481~283\,
	datac => \inst9|inst10|tmr_reset\,
	datad => \inst9|inst10|add_47_rtl_17_rtl_481~181\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_high[5]\);

\inst9|inst10|add_47_rtl_17~6_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17~6\ = \inst9|inst10|tmr_high[6]\ $ \inst9|inst10|add_47_rtl_17~5COUT\
-- \inst9|inst10|add_47_rtl_17~6COUT\ = CARRY(\inst9|inst10|tmr_high[6]\ # !\inst9|inst10|add_47_rtl_17~5COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "arithmetic",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5AAF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_high[6]\,
	cin => \inst9|inst10|add_47_rtl_17~5COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17~6\,
	cout => \inst9|inst10|add_47_rtl_17~6COUT\);

\inst9|inst10|add_47_rtl_17_rtl_481~265_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17_rtl_481~265\ = \inst9|inst10|i~352\ & !\inst9|inst10|reduce_nor_58\ & \inst9|inst10|add_47_rtl_17~6\ # !\inst9|inst10|i~352\ & \inst9|inst10|tmr_count[6]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "3A0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_count[6]\,
	datab => \inst9|inst10|reduce_nor_58\,
	datac => \inst9|inst10|i~352\,
	datad => \inst9|inst10|add_47_rtl_17~6\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17_rtl_481~265\);

\inst9|inst10|add_47_rtl_17_rtl_481~170_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17_rtl_481~170\ = \inst9|inst10|add_47_rtl_17_rtl_481~2506\ & (\inst9|inst10|i~1\ & \inst9|inst10|tmr_high[6]\ # !\inst9|inst10|i~1\ & \inst9|inst1|I4|data_ox[6]~1\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C0A0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|data_ox[6]~1\,
	datab => \inst9|inst10|tmr_high[6]\,
	datac => \inst9|inst10|add_47_rtl_17_rtl_481~2506\,
	datad => \inst9|inst10|i~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17_rtl_481~170\);

\inst9|inst10|tmr_high[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_high[6]\ = DFFE(\inst9|inst10|add_47_rtl_17_rtl_481~170\ # \inst9|inst10|add_47_rtl_17_rtl_481~265\ & \inst9|inst10|tmr_enable\ & \inst9|inst10|tmr_reset\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|add_47_rtl_17_rtl_481~265\,
	datab => \inst9|inst10|tmr_enable\,
	datac => \inst9|inst10|tmr_reset\,
	datad => \inst9|inst10|add_47_rtl_17_rtl_481~170\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_high[6]\);

\inst9|inst10|tmr_count[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_count[7]\ = DFFE(\inst9|inst1|I3|acc_c[0][7]\ & \inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), , , \inst9|inst10|tmr_count[7]~7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I3|acc_c[0][7]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	clk => \clk~combout\,
	ena => \inst9|inst10|tmr_count[7]~7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_count[7]\);

\inst9|inst10|add_47_rtl_17~7_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17~7\ = \inst9|inst10|add_47_rtl_17~6COUT\ $ !\inst9|inst10|tmr_high[7]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "F00F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst10|tmr_high[7]\,
	cin => \inst9|inst10|add_47_rtl_17~6COUT\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17~7\);

\inst9|inst10|add_47_rtl_17_rtl_481~247_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17_rtl_481~247\ = \inst9|inst10|i~352\ & !\inst9|inst10|reduce_nor_58\ & \inst9|inst10|add_47_rtl_17~7\ # !\inst9|inst10|i~352\ & \inst9|inst10|tmr_count[7]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7430",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|reduce_nor_58\,
	datab => \inst9|inst10|i~352\,
	datac => \inst9|inst10|tmr_count[7]\,
	datad => \inst9|inst10|add_47_rtl_17~7\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17_rtl_481~247\);

\inst9|inst10|add_47_rtl_17_rtl_481~159_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|add_47_rtl_17_rtl_481~159\ = \inst9|inst10|add_47_rtl_17_rtl_481~2506\ & (\inst9|inst10|i~1\ & \inst9|inst10|tmr_high[7]\ # !\inst9|inst10|i~1\ & \inst9|inst1|I4|data_ox[7]~0\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A088",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|add_47_rtl_17_rtl_481~2506\,
	datab => \inst9|inst1|I4|data_ox[7]~0\,
	datac => \inst9|inst10|tmr_high[7]\,
	datad => \inst9|inst10|i~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|add_47_rtl_17_rtl_481~159\);

\inst9|inst10|tmr_high[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_high[7]\ = DFFE(\inst9|inst10|add_47_rtl_17_rtl_481~159\ # \inst9|inst10|add_47_rtl_17_rtl_481~247\ & \inst9|inst10|tmr_reset\ & \inst9|inst10|tmr_enable\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|add_47_rtl_17_rtl_481~247\,
	datab => \inst9|inst10|tmr_reset\,
	datac => \inst9|inst10|tmr_enable\,
	datad => \inst9|inst10|add_47_rtl_17_rtl_481~159\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_high[7]\);

\inst9|inst10|i~334_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|i~334\ = \inst9|inst10|tmr_high[6]\ # \inst9|inst10|tmr_high[5]\ # \inst9|inst10|tmr_high[7]\ # \inst9|inst10|tmr_high[4]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_high[6]\,
	datab => \inst9|inst10|tmr_high[5]\,
	datac => \inst9|inst10|tmr_high[7]\,
	datad => \inst9|inst10|tmr_high[4]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|i~334\);

\inst9|inst10|i~352_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|i~352\ = \inst9|inst10|i~339\ # \inst9|inst10|reduce_nor_58\ # \inst9|inst10|i~334\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst10|i~339\,
	datac => \inst9|inst10|reduce_nor_58\,
	datad => \inst9|inst10|i~334\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst10|i~352\);

\inst9|inst10|tmr_int_x~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst10|tmr_int_x\ = DFFE(\inst9|inst10|tmr_reset\ & (\inst9|inst10|tmr_enable\ & !\inst9|inst10|i~352\ # !\inst9|inst10|tmr_enable\ & \inst9|inst10|tmr_int_x\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "22A0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst10|tmr_reset\,
	datab => \inst9|inst10|i~352\,
	datac => \inst9|inst10|tmr_int_x\,
	datad => \inst9|inst10|tmr_enable\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst10|tmr_int_x\);

\inst9|inst5|i~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|i~1\ = \inst9|inst5|i~137\ & !\inst9|inst12|i~103\ & !\inst9|inst12|i~115\ & !\inst9|inst12|i~109\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0002",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst5|i~137\,
	datab => \inst9|inst12|i~103\,
	datac => \inst9|inst12|i~115\,
	datad => \inst9|inst12|i~109\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst5|i~1\);

\inst9|inst5|int_mask_c[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_mask_c[3]\ = DFFE(\inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst1|I3|acc_c[0][3]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst5|i~1\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datad => \inst9|inst1|I3|acc_c[0][3]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst5|i~1\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_mask_c[3]\);

\inst9|inst5|int_masked[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_masked[3]\ = DFFE(\inst9|inst10|tmr_int_x\ & \inst9|inst5|int_mask_c[3]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst10|tmr_int_x\,
	datad => \inst9|inst5|int_mask_c[3]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_masked[3]\);

\inst9|inst5|i~65_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|i~65\ = !\inst9|inst12|i~109\ & !\inst9|inst12|i~103\ & !\inst9|inst12|i~115\ & \inst9|inst2|i~456\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0100",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|i~109\,
	datab => \inst9|inst12|i~103\,
	datac => \inst9|inst12|i~115\,
	datad => \inst9|inst2|i~456\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst5|i~65\);

\inst9|inst5|int_clr_c[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_clr_c[3]\ = DFFE(\inst9|inst1|I3|acc_c[0][3]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst5|i~65\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][3]\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst5|i~65\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_clr_c[3]\);

\inst9|inst5|int_masked_c[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_masked_c[3]\ = DFFE(\inst9|inst5|int_masked[3]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F0F0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst5|int_masked[3]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_masked_c[3]\);

\inst9|inst5|int_pending_c[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_pending_c[3]\ = DFFE(!\inst9|inst5|int_clr_c[3]\ & (\inst9|inst5|int_pending_c[3]\ # \inst9|inst5|int_masked[3]\ & !\inst9|inst5|int_masked_c[3]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0C0E",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst5|int_masked[3]\,
	datab => \inst9|inst5|int_pending_c[3]\,
	datac => \inst9|inst5|int_clr_c[3]\,
	datad => \inst9|inst5|int_masked_c[3]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_pending_c[3]\);

\inst9|inst5|int_mask_c[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_mask_c[0]\ = DFFE(\inst9|inst1|I3|acc_c[0][0]\ & \inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst5|i~1\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I3|acc_c[0][0]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst5|i~1\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_mask_c[0]\);

\inst9|inst5|int_masked[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_masked[0]\ = DFFE(\inst9|inst5|int_mask_c[0]\ & !\inst9|inst2|tx_uart_busy\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00F0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst5|int_mask_c[0]\,
	datad => \inst9|inst2|tx_uart_busy\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_masked[0]\);

\inst9|inst5|int_clr_c[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_clr_c[0]\ = DFFE(\inst9|inst7\ & \inst9|inst1|I3|acc_c[0][0]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst5|i~65\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datac => \inst9|inst1|I3|acc_c[0][0]\,
	datad => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst5|i~65\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_clr_c[0]\);

\inst9|inst5|int_masked_c[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_masked_c[0]\ = DFFE(\inst9|inst5|int_masked[0]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst5|int_masked[0]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_masked_c[0]\);

\inst9|inst5|int_pending_c[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_pending_c[0]\ = DFFE(!\inst9|inst5|int_clr_c[0]\ & (\inst9|inst5|int_pending_c[0]\ # \inst9|inst5|int_masked[0]\ & !\inst9|inst5|int_masked_c[0]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0C0E",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst5|int_masked[0]\,
	datab => \inst9|inst5|int_pending_c[0]\,
	datac => \inst9|inst5|int_clr_c[0]\,
	datad => \inst9|inst5|int_masked_c[0]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_pending_c[0]\);

\inst9|inst5|int_mask_c[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_mask_c[2]\ = DFFE(\inst9|inst1|I3|acc_c[0][2]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst5|i~1\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][2]\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst5|i~1\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_mask_c[2]\);

\inst9|inst5|int_masked[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_masked[2]\ = DFFE(!\inst9|inst|rx_uart_full_c\ & \inst9|inst|rx_uart_ovr_d\ & \inst9|inst5|int_mask_c[2]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_uart_full_c\,
	datac => \inst9|inst|rx_uart_ovr_d\,
	datad => \inst9|inst5|int_mask_c[2]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_masked[2]\);

\inst9|inst5|int_masked_c[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_masked_c[2]\ = DFFE(\inst9|inst5|int_masked[2]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst5|int_masked[2]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_masked_c[2]\);

\inst9|inst5|int_clr_c[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_clr_c[2]\ = DFFE(\inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst1|I3|acc_c[0][2]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst5|i~65\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst1|I3|acc_c[0][2]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst5|i~65\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_clr_c[2]\);

\inst9|inst5|int_pending_c[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_pending_c[2]\ = DFFE(!\inst9|inst5|int_clr_c[2]\ & (\inst9|inst5|int_pending_c[2]\ # !\inst9|inst5|int_masked_c[2]\ & \inst9|inst5|int_masked[2]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00F4",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst5|int_masked_c[2]\,
	datab => \inst9|inst5|int_masked[2]\,
	datac => \inst9|inst5|int_pending_c[2]\,
	datad => \inst9|inst5|int_clr_c[2]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_pending_c[2]\);

\inst9|inst5|int_mask_c[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_mask_c[1]\ = DFFE(\inst9|inst1|I3|acc_c[0][1]\ & \inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst5|i~1\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst5|i~1\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_mask_c[1]\);

\inst9|inst5|int_masked[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_masked[1]\ = DFFE(!\inst9|inst|rx_uart_full_c\ & \inst9|inst5|int_mask_c[1]\ & \inst9|inst|rx_uart_full_d\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_uart_full_c\,
	datac => \inst9|inst5|int_mask_c[1]\,
	datad => \inst9|inst|rx_uart_full_d\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_masked[1]\);

\inst9|inst5|int_masked_c[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_masked_c[1]\ = DFFE(\inst9|inst5|int_masked[1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst5|int_masked[1]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_masked_c[1]\);

\inst9|inst5|int_clr_c[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_clr_c[1]\ = DFFE(\inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst1|I3|acc_c[0][1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst5|i~65\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst1|I3|acc_c[0][1]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst5|i~65\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_clr_c[1]\);

\inst9|inst5|int_pending_c[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst5|int_pending_c[1]\ = DFFE(!\inst9|inst5|int_clr_c[1]\ & (\inst9|inst5|int_pending_c[1]\ # !\inst9|inst5|int_masked_c[1]\ & \inst9|inst5|int_masked[1]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0F04",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst5|int_masked_c[1]\,
	datab => \inst9|inst5|int_masked[1]\,
	datac => \inst9|inst5|int_clr_c[1]\,
	datad => \inst9|inst5|int_pending_c[1]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst5|int_pending_c[1]\);

\inst9|inst1|I2|i~457_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|i~457\ = \inst9|inst5|int_pending_c[3]\ # \inst9|inst5|int_pending_c[0]\ # \inst9|inst5|int_pending_c[2]\ # \inst9|inst5|int_pending_c[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst5|int_pending_c[3]\,
	datab => \inst9|inst5|int_pending_c[0]\,
	datac => \inst9|inst5|int_pending_c[2]\,
	datad => \inst9|inst5|int_pending_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|i~457\);

\inst9|inst1|I2|S_x.normal~12_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|S_x.normal~12\ = \inst9|inst1|I2|S_c~9\ & (\inst9|inst1|I2|E_x.iwait_e~1\ # \inst9|inst1|I2|E_x.dwait_e~0\ # !\inst9|inst1|I2|E_x.int_e~96\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C8CC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|E_x.iwait_e~1\,
	datab => \inst9|inst1|I2|S_c~9\,
	datac => \inst9|inst1|I2|E_x.dwait_e~0\,
	datad => \inst9|inst1|I2|E_x.int_e~96\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|S_x.normal~12\);

\inst9|inst1|I2|S_c~9_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|S_c~9\ = DFFE(\inst9|inst1|I2|S_x.normal~12\ # !\inst9|inst1|I2|E_x.int_e~96\ & \inst9|inst1|I2|i~511\ # !\inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F7F3",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|E_x.int_e~96\,
	datab => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datac => \inst9|inst1|I2|S_x.normal~12\,
	datad => \inst9|inst1|I2|i~511\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|S_c~9\);

\inst9|inst1|I2|E_x.int_e~80_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|E_x.int_e~80\ = \inst9|inst1|I2|S_c~9\ & !\inst9|inst4|a2vi_s\ & !\inst9|inst1|I2|int_stop_c\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "000C",
	output_mode => "none")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I2|S_c~9\,
	datac => \inst9|inst4|a2vi_s\,
	datad => \inst9|inst1|I2|int_stop_c\,
	devclrn => devclrn,
	devpor => devpor,
	cascout => \inst9|inst1|I2|E_x.int_e~80\);

\inst9|inst1|I2|E_x.int_e~96_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|E_x.int_e~96\ = (\inst9|inst1|I2|i~457\ & \inst9|inst1|I2|i~2\ & (!\inst9|inst12|dwait_c\ # !\inst9|inst1|I2|i~441\)) & CASCADE(\inst9|inst1|I2|E_x.int_e~80\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4C00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~441\,
	datab => \inst9|inst1|I2|i~457\,
	datac => \inst9|inst12|dwait_c\,
	datad => \inst9|inst1|I2|i~2\,
	cascin => \inst9|inst1|I2|E_x.int_e~80\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|E_x.int_e~96\);

\inst9|inst1|I2|int_start_c~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|int_start_c\ = DFFE(\inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\ & (\inst9|inst1|I2|E_x.int_e~96\ # \inst9|inst1|I2|int_start_c\ & \inst9|inst1|I2|E_x.dwait_e~0\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A8A0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datab => \inst9|inst1|I2|int_start_c\,
	datac => \inst9|inst1|I2|E_x.int_e~96\,
	datad => \inst9|inst1|I2|E_x.dwait_e~0\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|int_start_c\);

\inst9|inst1|I2|skip_c~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|skip_c\ = DFFE(\inst9|inst1|I2|skip_x~107\ & \inst9|inst1|I2|skip_c\ # !\inst9|inst1|I2|skip_x~107\ & !\inst9|inst1|I2|int_start_c\ & \inst9|inst1|I3|skip_l~8\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8B88",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|skip_c\,
	datab => \inst9|inst1|I2|skip_x~107\,
	datac => \inst9|inst1|I2|int_start_c\,
	datad => \inst9|inst1|I3|skip_l~8\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|skip_c\);

\inst9|inst1|I2|ndre_x~40_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|ndre_x~40\ = \inst9|inst1|I2|pc_mux_x[2]~443\ & !\inst9|inst1|I2|skip_x~62\ & (!\inst9|inst1|I2|skip_c\ # !\inst9|inst1|I2|skip_x~107\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0070",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|skip_x~107\,
	datab => \inst9|inst1|I2|skip_c\,
	datac => \inst9|inst1|I2|pc_mux_x[2]~443\,
	datad => \inst9|inst1|I2|skip_x~62\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|ndre_x~40\);

\inst9|inst1|I2|ndre_x~41_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|ndre_x~41\ = \inst9|inst1|I2|ndre_x~40\ & !\inst9|inst1|I2|C_raw~56\ & !\inst9|inst1|I2|TC_x[1]~22\ & \inst9|inst1|I2|C_raw~61\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0200",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|ndre_x~40\,
	datab => \inst9|inst1|I2|C_raw~56\,
	datac => \inst9|inst1|I2|TC_x[1]~22\,
	datad => \inst9|inst1|I2|C_raw~61\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|ndre_x~41\);

\inst9|inst1|I4|ndre_x~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ndre_x~1\ = \inst9|inst1|I4|i~800\ & \inst9|inst1|I4|i~815\ # !\inst9|inst1|I2|ndre_x~41\ # !\inst9|inst1|I4|i~18\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F777",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~18\,
	datab => \inst9|inst1|I2|ndre_x~41\,
	datac => \inst9|inst1|I4|i~800\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|ndre_x~1\);

\inst9|inst4|dwait_c~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|dwait_c\ = DFFE(\inst9|inst12|dwait_c\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst12|dwait_c\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst4|dwait_c\);

\inst9|inst4|i~200_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~200\ = \inst9|inst4|dwait_c\ # \inst9|inst4|nadwe_c\ # \inst9|inst12|dwait_c\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FEFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst4|dwait_c\,
	datab => \inst9|inst4|nadwe_c\,
	datac => \inst9|inst12|dwait_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~200\);

\inst9|inst1|I4|ndwe_x~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|ndwe_x~1\ = \inst9|inst1|I4|i~800\ & \inst9|inst1|I4|i~815\ # !\inst9|inst1|I2|ndwe_x~45\ # !\inst9|inst1|I4|i~18\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F777",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~18\,
	datab => \inst9|inst1|I2|ndwe_x~45\,
	datac => \inst9|inst1|I4|i~800\,
	datad => \inst9|inst1|I4|i~815\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|ndwe_x~1\);

\inst9|inst4|a2vi_s~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|a2vi_s\ = DFFE(\inst9|inst4|a2vi_s\ & \inst9|inst4|i~200\ # !\inst9|inst4|a2vi_s\ & (!\inst9|inst1|I4|ndwe_x~1\ # !\inst9|inst1|I4|ndre_x~1\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C5CF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ndre_x~1\,
	datab => \inst9|inst4|i~200\,
	datac => \inst9|inst4|a2vi_s\,
	datad => \inst9|inst1|I4|ndwe_x~1\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst4|a2vi_s\);

\inst9|inst4|nadwe_c~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|nadwe_c\ = DFFE(\inst9|inst12|dwait_c\ & (\inst9|inst4|a2vi_s\ & \inst9|inst4|nadwe_c\ # !\inst9|inst4|a2vi_s\ & !\inst9|inst1|I4|ndwe_x~1\) # !\inst9|inst12|dwait_c\ & !\inst9|inst1|I4|ndwe_x~1\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "80BF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst4|nadwe_c\,
	datab => \inst9|inst12|dwait_c\,
	datac => \inst9|inst4|a2vi_s\,
	datad => \inst9|inst1|I4|ndwe_x~1\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst4|nadwe_c\);

\inst9|inst4|i~382_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~382\ = !\inst9|inst12|dwait_c\ & !\inst9|inst4|nadwe_c\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0033",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst12|dwait_c\,
	datad => \inst9|inst4|nadwe_c\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~382\);

\inst9|inst4|daddr_c[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|daddr_c[0]\ = DFFE(\inst9|inst4|i~48\ & \inst9|inst4|daddr_c[0]\ # !\inst9|inst4|i~48\ & (\inst9|inst1|I4|daddr_x[0]~34\ # \inst9|inst1|I4|daddr_x[0]~35\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CFCA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|daddr_x[0]~34\,
	datab => \inst9|inst4|daddr_c[0]\,
	datac => \inst9|inst4|i~48\,
	datad => \inst9|inst1|I4|daddr_x[0]~35\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst4|daddr_c[0]\);

\inst9|inst1|I4|daddr_x[0]~22_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|daddr_x[0]~22\ = \inst9|inst1|I4|daddr_x[0]~35\ # \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I2|idata_x[4]~37\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datab => \inst9|inst7\,
	datac => \inst9|inst1|I2|idata_x[4]~37\,
	datad => \inst9|inst1|I4|daddr_x[0]~35\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|daddr_x[0]~22\);

\inst9|inst4|i~409_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~409\ = \inst9|inst1|I4|ndre_x~1\ & !\inst9|inst4|i~382\ & \inst9|inst4|daddr_c[0]\ # !\inst9|inst1|I4|ndre_x~1\ & \inst9|inst1|I4|daddr_x[0]~22\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4F40",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst4|i~382\,
	datab => \inst9|inst4|daddr_c[0]\,
	datac => \inst9|inst1|I4|ndre_x~1\,
	datad => \inst9|inst1|I4|daddr_x[0]~22\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~409\);

\inst9|inst4|i~63_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~63\ = \inst9|inst4|i~409\ # \inst9|inst1|I1|i~2\ & \inst9|inst4|i~379\ & \inst9|inst1|I1|iaddr_x[0]~296\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ECCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I1|i~2\,
	datab => \inst9|inst4|i~409\,
	datac => \inst9|inst4|i~379\,
	datad => \inst9|inst1|I1|iaddr_x[0]~296\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~63\);

\inst9|inst15|lpm_ram_dq_component|sram|segment[0][12]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem2 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001010001001010001000000000000000000000000000100010000000000000000000000000010000000001000100000000000000000000000000000010000000001100010000000000000000000000000001001000000000000000000000000101010",
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|lpm_ram_dq1:inst15|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "rom.mif",
	logical_ram_depth => 1024,
	logical_ram_width => 14,
	address_width => 10,
	first_address => 0,
	last_address => 1023,
	bit_number => 12,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \~GND\,
	clk0 => \clk~combout\,
	we => \inst9|inst19|i~50\,
	waddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][12]_waddr\,
	raddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][12]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst15|lpm_ram_dq_component|sram|segment[0][12]_modesel\,
	dataout => \inst9|inst15|lpm_ram_dq_component|sram|q[12]\);

\inst9|inst1|I2|idata_c[12]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_c[12]\ = DFFE(\inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|idata_c[12]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[12]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[12]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E2AA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst15|lpm_ram_dq_component|sram|q[12]\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst1|I2|idata_c[12]\,
	datad => \inst9|inst1|I2|i~509\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|idata_c[12]\);

\inst9|inst4|i~381_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst4|i~381\ = \inst9|inst1|I4|i~18\ & (\inst9|inst1|I2|E_x.dwait_e~0\ & \inst9|inst1|I2|idata_c[12]\ # !\inst9|inst1|I2|E_x.dwait_e~0\ & \inst9|inst15|lpm_ram_dq_component|sram|q[12]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "B080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_c[12]\,
	datab => \inst9|inst1|I2|E_x.dwait_e~0\,
	datac => \inst9|inst1|I4|i~18\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[12]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst4|i~381\);

\inst9|inst12|cpu_daddr_c[8]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|cpu_daddr_c[8]\ = DFFE(\inst9|inst7\ & (\inst9|inst12|reduce_or_73\ & \inst9|inst4|i~381\ # !\inst9|inst12|reduce_or_73\ & \inst9|inst12|cpu_daddr_c[8]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8A80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datab => \inst9|inst4|i~381\,
	datac => \inst9|inst12|reduce_or_73\,
	datad => \inst9|inst12|cpu_daddr_c[8]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst12|cpu_daddr_c[8]\);

\inst9|inst19|i~50_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst19|i~50\ = \inst9|inst19|i~81\ & (\inst9|inst1|I4|ndre_x~1\ & !\inst9|inst12|cpu_daddr_c[8]\ # !\inst9|inst1|I4|ndre_x~1\ & !\inst9|inst12|cpu_daddr_x[8]~32\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5030",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|cpu_daddr_c[8]\,
	datab => \inst9|inst12|cpu_daddr_x[8]~32\,
	datac => \inst9|inst19|i~81\,
	datad => \inst9|inst1|I4|ndre_x~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst19|i~50\);

\inst9|inst15|lpm_ram_dq_component|sram|segment[0][11]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem2 => "00000011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000001000010001000000001011101100001000100100000101010000000001000000000000000000010000000000000000100000000000000000000000000001000001001001001001001110010000000000000000000000000000000000",
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|lpm_ram_dq1:inst15|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "rom.mif",
	logical_ram_depth => 1024,
	logical_ram_width => 14,
	address_width => 10,
	first_address => 0,
	last_address => 1023,
	bit_number => 11,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \~GND\,
	clk0 => \clk~combout\,
	we => \inst9|inst19|i~50\,
	waddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][11]_waddr\,
	raddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][11]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst15|lpm_ram_dq_component|sram|segment[0][11]_modesel\,
	dataout => \inst9|inst15|lpm_ram_dq_component|sram|q[11]\);

\inst9|inst1|I2|data_is_c[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|data_is_c[7]\ = DFFE(\inst9|inst1|I2|i~509\ & (\inst9|inst1|I2|i~2\ & \inst9|inst1|I2|data_is_c[7]\ # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[11]\) # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[11]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EC4C",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~509\,
	datab => \inst9|inst15|lpm_ram_dq_component|sram|q[11]\,
	datac => \inst9|inst1|I2|i~2\,
	datad => \inst9|inst1|I2|data_is_c[7]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|data_is_c[7]\);

\inst9|inst|Decoder_28~23_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|Decoder_28~23\ = \inst9|inst|rx_bit_count[0]\ & \inst9|inst|rx_bit_count[1]\ & !\inst9|inst|rx_bit_count[3]\ & \inst9|inst|rx_bit_count[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|rx_bit_count[0]\,
	datab => \inst9|inst|rx_bit_count[1]\,
	datac => \inst9|inst|rx_bit_count[3]\,
	datad => \inst9|inst|rx_bit_count[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|Decoder_28~23\);

\inst9|inst|rx_uart_reg[7]~5_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[7]~5\ = \inst9|inst|reduce_nor_7\ & !\inst9|inst|reduce_nor_27\ & \rtl~9986\ & \inst9|inst|Decoder_28~23\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst|reduce_nor_7\,
	datab => \inst9|inst|reduce_nor_27\,
	datac => \rtl~9986\,
	datad => \inst9|inst|Decoder_28~23\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst|rx_uart_reg[7]~5\);

\inst9|inst|rx_uart_reg[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_reg[7]\ = DFFE(!\RXD~combout\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|rx_uart_reg[7]~5\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \RXD~combout\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|rx_uart_reg[7]~5\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_reg[7]\);

\inst9|inst|rx_uart_fifo[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst|rx_uart_fifo[7]\ = DFFE(!\inst9|inst|rx_uart_reg[7]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst|rx_uart_fifo[4]~37\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst|rx_uart_reg[7]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst|rx_uart_fifo[4]~37\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst|rx_uart_fifo[7]\);

\inst9|inst1|I3|data_x[7]~2294_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[7]~2294\ = (\inst9|inst19|mux_c[1]\ & (\inst9|inst19|mux_c[0]\ & \inst9|inst15|lpm_ram_dq_component|sram|q[7]\ # !\inst9|inst19|mux_c[0]\ & \inst9|inst|rx_uart_fifo[7]\) # !\inst9|inst19|mux_c[1]\ & !\inst9|inst19|mux_c[0]\ & \inst9|inst15|lpm_ram_dq_component|sram|q[7]\) & CASCADE(\inst9|inst1|I3|data_x[2]~2296\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "B290",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst19|mux_c[1]\,
	datab => \inst9|inst19|mux_c[0]\,
	datac => \inst9|inst15|lpm_ram_dq_component|sram|q[7]\,
	datad => \inst9|inst|rx_uart_fifo[7]\,
	cascin => \inst9|inst1|I3|data_x[2]~2296\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[7]~2294\);

\inst9|inst1|I3|data_x[7]~156_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[7]~156\ = \inst9|inst1|I4|reduce_nor_106\ & \inst9|inst1|I4|iinc_c[7]\ & \inst9|inst1|I2|ndre_x~41\ # !\inst9|inst1|I4|reduce_nor_106\ & \inst9|inst1|I4|ireg_c[7]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "B830",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|iinc_c[7]\,
	datab => \inst9|inst1|I4|reduce_nor_106\,
	datac => \inst9|inst1|I4|ireg_c[7]\,
	datad => \inst9|inst1|I2|ndre_x~41\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[7]~156\);

\inst9|inst1|I3|data_x[7]~162_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[7]~162\ = \inst9|inst1|I4|i~18\ & \inst9|inst1|I3|reduce_nor_71\ & \inst9|inst1|I3|data_x[7]~156\ & \inst9|inst1|I4|i~616\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|i~18\,
	datab => \inst9|inst1|I3|reduce_nor_71\,
	datac => \inst9|inst1|I3|data_x[7]~156\,
	datad => \inst9|inst1|I4|i~616\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[7]~162\);

\inst9|inst1|I3|data_x[7]~2173_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|data_x[7]~2173\ = \inst9|inst1|I3|data_x[7]~2294\ # \inst9|inst1|I3|data_x[7]~162\ # \inst9|inst1|I2|data_is_c[7]\ & !\inst9|inst1|I3|reduce_nor_71\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|data_is_c[7]\,
	datab => \inst9|inst1|I3|reduce_nor_71\,
	datac => \inst9|inst1|I3|data_x[7]~2294\,
	datad => \inst9|inst1|I3|data_x[7]~162\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|data_x[7]~2173\);

\rtl~10529_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10529\ = \rtl~9972\ & (\inst9|inst1|I3|data_x[7]~2173\ $ (\inst9|inst1|I3|acc_c[0][7]\ & \inst9|inst1|I2|TD_c[0]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4C80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][7]\,
	datab => \rtl~9972\,
	datac => \inst9|inst1|I2|TD_c[0]\,
	datad => \inst9|inst1|I3|data_x[7]~2173\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10529\);

\rtl~1578_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1578\ = !\inst9|inst1|I2|TD_c[1]\ & \inst9|inst1|I3|Mux_201_rtl_146~0\ & !\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][7]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[1]\,
	datab => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	datac => \inst9|inst1|I2|TD_c[2]\,
	datad => \inst9|inst1|I3|acc_c[0][7]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1578\);

\rtl~2172_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2172\ = \inst9|inst1|I2|TD_c[2]\ & (\inst9|inst1|I3|acc_c[0][7]\ $ \inst9|inst1|I2|TD_c[1]\) # !\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][6]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "3ACA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][6]\,
	datab => \inst9|inst1|I3|acc_c[0][7]\,
	datac => \inst9|inst1|I2|TD_c[2]\,
	datad => \inst9|inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2172\);

\rtl~2051_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2051\ = \inst9|inst1|I2|TD_c[1]\ & \inst9|inst1|I3|acc_c[0][8]\ & !\inst9|inst1|I2|TD_c[2]\ # !\inst9|inst1|I2|TD_c[1]\ & (\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][8]\ # !\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][7]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0AAC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][8]\,
	datab => \inst9|inst1|I3|acc_c[0][7]\,
	datac => \inst9|inst1|I2|TD_c[1]\,
	datad => \inst9|inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2051\);

\rtl~1779_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1779\ = !\inst9|inst1|I3|Mux_201_rtl_146~0\ & (\inst9|inst1|I2|TD_c[0]\ & \rtl~2172\ # !\inst9|inst1|I2|TD_c[0]\ & \rtl~2051\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0B08",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~2172\,
	datab => \inst9|inst1|I2|TD_c[0]\,
	datac => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	datad => \rtl~2051\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1779\);

\inst9|inst1|I3|Mux_171_rtl_115_rtl_351~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|Mux_171_rtl_115_rtl_351~0\ = \inst9|inst1|I2|TD_c[1]\ & (\inst9|inst1|I2|TD_c[0]\ # \inst9|inst1|I3|add_153~8\) # !\inst9|inst1|I2|TD_c[1]\ & !\inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|add_129~7\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "D9C8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[0]\,
	datab => \inst9|inst1|I2|TD_c[1]\,
	datac => \inst9|inst1|I3|add_153~8\,
	datad => \inst9|inst1|I3|add_129~7\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|Mux_171_rtl_115_rtl_351~0\);

\inst9|inst1|I3|Mux_171_rtl_115_rtl_351~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|Mux_171_rtl_115_rtl_351~1\ = \inst9|inst1|I3|acc_c[0][7]\ & (\inst9|inst1|I3|Mux_171_rtl_115_rtl_351~0\ # \inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|data_x[7]~2173\) # !\inst9|inst1|I3|acc_c[0][7]\ & \inst9|inst1|I3|Mux_171_rtl_115_rtl_351~0\ & (\inst9|inst1|I3|data_x[7]~2173\ # !\inst9|inst1|I2|TD_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FB80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][7]\,
	datab => \inst9|inst1|I2|TD_c[0]\,
	datac => \inst9|inst1|I3|data_x[7]~2173\,
	datad => \inst9|inst1|I3|Mux_171_rtl_115_rtl_351~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|Mux_171_rtl_115_rtl_351~1\);

\rtl~10512_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10512\ = \rtl~1578\ # \rtl~1779\ # \rtl~9988\ & \inst9|inst1|I3|Mux_171_rtl_115_rtl_351~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FEFA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~1578\,
	datab => \rtl~9988\,
	datac => \rtl~1779\,
	datad => \inst9|inst1|I3|Mux_171_rtl_115_rtl_351~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10512\);

\inst9|inst1|I3|acc_i[0][7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_i[0][7]\ = DFFE(\inst9|inst1|I3|acc[0][7]~4410\ # \inst9|inst1|I3|acc[0][4]~4338\ & (\rtl~10529\ # \rtl~10512\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst1|I2|int_start_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FAF8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][4]~4338\,
	datab => \rtl~10529\,
	datac => \inst9|inst1|I3|acc[0][7]~4410\,
	datad => \rtl~10512\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_i[0][7]\);

\inst9|inst1|I3|acc[0][7]~4410_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc[0][7]~4410\ = \inst9|inst1|I3|acc[0][4]~4339\ & (\inst9|inst1|I3|acc_i[0][7]\ # \inst9|inst1|I3|acc_c[0][7]\ & \inst9|inst1|I3|acc[0][4]~63\) # !\inst9|inst1|I3|acc[0][4]~4339\ & \inst9|inst1|I3|acc_c[0][7]\ & \inst9|inst1|I3|acc[0][4]~63\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][4]~4339\,
	datab => \inst9|inst1|I3|acc_i[0][7]\,
	datac => \inst9|inst1|I3|acc_c[0][7]\,
	datad => \inst9|inst1|I3|acc[0][4]~63\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|acc[0][7]~4410\);

\inst9|inst1|I3|acc_c[0][7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_c[0][7]\ = DFFE(\inst9|inst1|I3|acc[0][7]~4410\ # \inst9|inst1|I3|acc[0][4]~4338\ & (\rtl~10529\ # \rtl~10512\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FAF8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][4]~4338\,
	datab => \rtl~10529\,
	datac => \inst9|inst1|I3|acc[0][7]~4410\,
	datad => \rtl~10512\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_c[0][7]\);

\inst9|inst1|I4|data_ox[7]~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|data_ox[7]~0\ = \inst9|inst1|I3|acc_c[0][7]\ & \inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][7]\,
	datab => \inst9|inst7\,
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|data_ox[7]~0\);

\inst9|inst15|lpm_ram_dq_component|sram|segment[0][7]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem2 => "00000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001110000110000001110100001100111000000100010000000010010001000100110101110010010010110000110010111010011000101000100000000110110100000100110100101011000000010000000010010000000100010100010101010100010100100000",
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|lpm_ram_dq1:inst15|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "rom.mif",
	logical_ram_depth => 1024,
	logical_ram_width => 14,
	address_width => 10,
	first_address => 0,
	last_address => 1023,
	bit_number => 7,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst1|I4|data_ox[7]~0\,
	clk0 => \clk~combout\,
	we => \inst9|inst19|i~50\,
	waddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][7]_waddr\,
	raddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][7]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst15|lpm_ram_dq_component|sram|segment[0][7]_modesel\,
	dataout => \inst9|inst15|lpm_ram_dq_component|sram|q[7]\);

\inst9|inst1|I2|data_is_c[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|data_is_c[3]\ = DFFE(\inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|data_is_c[3]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[7]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[7]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~2\,
	datab => \inst9|inst1|I2|data_is_c[3]\,
	datac => \inst9|inst1|I2|i~509\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[7]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|data_is_c[3]\);

\inst9|inst1|I2|idata_x[7]~31_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[7]~31\ = \inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|data_is_c[3]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[7]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[7]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~2\,
	datab => \inst9|inst1|I2|data_is_c[3]\,
	datac => \inst9|inst1|I2|i~509\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[7]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[7]~31\);

\inst9|inst1|I2|TC_x[0]~141_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TC_x[0]~141\ = \inst9|inst1|I2|idata_x[7]~31\ & !\inst9|inst1|I2|idata_x[5]~34\ & \inst9|inst1|I2|idata_x[6]~28\ & !\inst9|inst1|I2|idata_x[4]~37\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0020",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[7]~31\,
	datab => \inst9|inst1|I2|idata_x[5]~34\,
	datac => \inst9|inst1|I2|idata_x[6]~28\,
	datad => \inst9|inst1|I2|idata_x[4]~37\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|TC_x[0]~141\);

\inst9|inst1|I2|TC_c[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TC_c[0]\ = DFFE(\inst9|inst1|I2|TC_x[1]~42\ # \inst9|inst1|I2|TC_x[0]~550\ & (\inst9|inst1|I2|TC_x[0]~141\ # !\inst9|inst1|I2|TD_x[3]~35\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFD0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_x[3]~35\,
	datab => \inst9|inst1|I2|TC_x[0]~141\,
	datac => \inst9|inst1|I2|TC_x[0]~550\,
	datad => \inst9|inst1|I2|TC_x[1]~42\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|TC_c[0]\);

\inst9|inst1|I2|i~441_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|i~441\ = \inst9|inst1|I2|TC_c[0]\ & !\inst9|inst1|I2|E_c~10\ & !\inst9|inst1|I2|skip_c\ & !\inst9|inst1|I2|TC_c[2]\
-- \inst9|inst1|I2|i~512\ = \inst9|inst1|I2|TC_c[0]\ & !\inst9|inst1|I2|E_c~10\ & !\inst9|inst1|I2|skip_c\ & !\inst9|inst1|I2|TC_c[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0002",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TC_c[0]\,
	datab => \inst9|inst1|I2|E_c~10\,
	datac => \inst9|inst1|I2|skip_c\,
	datad => \inst9|inst1|I2|TC_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|i~441\,
	cascout => \inst9|inst1|I2|i~512\);

\inst9|inst1|I3|i~173_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|i~173\ = (!\inst9|inst1|I2|i~441\ # !\inst9|inst12|dwait_c\ # !\inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\ # !\inst9|inst7\) & CASCADE(\inst9|inst1|I3|i~174\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7FFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datab => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datac => \inst9|inst12|dwait_c\,
	datad => \inst9|inst1|I2|i~441\,
	cascin => \inst9|inst1|I3|i~174\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|i~173\);

\inst9|inst1|I3|acc[0][4]~63_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc[0][4]~63\ = \inst9|inst1|I3|i~173\ & !\rtl~1694\ # !\inst9|inst1|I3|i~173\ & \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[1]\ & \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4E0A",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|i~173\,
	datab => \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[1]\,
	datac => \rtl~1694\,
	datad => \inst9|inst1|I3|nreset_v_rtl_22|wysi_counter|sload_path[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|acc[0][4]~63\);

\rtl~10426_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10426\ = \rtl~9972\ & (\inst9|inst1|I3|data_x[3]~2107\ $ (\inst9|inst1|I3|acc_c[0][3]\ & \inst9|inst1|I2|TD_c[0]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2A80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~9972\,
	datab => \inst9|inst1|I3|acc_c[0][3]\,
	datac => \inst9|inst1|I2|TD_c[0]\,
	datad => \inst9|inst1|I3|data_x[3]~2107\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10426\);

\rtl~2028_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2028\ = \inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][4]\ & !\inst9|inst1|I2|TD_c[1]\ # !\inst9|inst1|I2|TD_c[2]\ & (\inst9|inst1|I2|TD_c[1]\ & \inst9|inst1|I3|acc_c[0][4]\ # !\inst9|inst1|I2|TD_c[1]\ & \inst9|inst1|I3|acc_c[0][3]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "50E4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[2]\,
	datab => \inst9|inst1|I3|acc_c[0][3]\,
	datac => \inst9|inst1|I3|acc_c[0][4]\,
	datad => \inst9|inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2028\);

\rtl~2140_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2140\ = \inst9|inst1|I2|TD_c[2]\ & (\inst9|inst1|I3|acc_c[0][3]\ $ \inst9|inst1|I2|TD_c[1]\) # !\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "6F60",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][3]\,
	datab => \inst9|inst1|I2|TD_c[1]\,
	datac => \inst9|inst1|I2|TD_c[2]\,
	datad => \inst9|inst1|I3|acc_c[0][2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2140\);

\rtl~1751_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1751\ = !\inst9|inst1|I3|Mux_201_rtl_146~0\ & (\inst9|inst1|I2|TD_c[0]\ & \rtl~2140\ # !\inst9|inst1|I2|TD_c[0]\ & \rtl~2028\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "3202",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~2028\,
	datab => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	datac => \inst9|inst1|I2|TD_c[0]\,
	datad => \rtl~2140\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1751\);

\rtl~1572_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1572\ = \inst9|inst1|I3|acc_c[0][3]\ & \inst9|inst1|I3|Mux_201_rtl_146~0\ & !\inst9|inst1|I2|TD_c[1]\ & !\inst9|inst1|I2|TD_c[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0008",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][3]\,
	datab => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	datac => \inst9|inst1|I2|TD_c[1]\,
	datad => \inst9|inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1572\);

\inst9|inst1|I3|Mux_175_rtl_103_rtl_339~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|Mux_175_rtl_103_rtl_339~0\ = \inst9|inst1|I2|TD_c[1]\ & (\inst9|inst1|I3|add_153~4\ # \inst9|inst1|I2|TD_c[0]\) # !\inst9|inst1|I2|TD_c[1]\ & !\inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|add_129~3\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ADA8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[1]\,
	datab => \inst9|inst1|I3|add_153~4\,
	datac => \inst9|inst1|I2|TD_c[0]\,
	datad => \inst9|inst1|I3|add_129~3\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|Mux_175_rtl_103_rtl_339~0\);

\inst9|inst1|I3|Mux_175_rtl_103_rtl_339~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|Mux_175_rtl_103_rtl_339~1\ = \inst9|inst1|I3|acc_c[0][3]\ & (\inst9|inst1|I3|Mux_175_rtl_103_rtl_339~0\ # \inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|data_x[3]~2107\) # !\inst9|inst1|I3|acc_c[0][3]\ & \inst9|inst1|I3|Mux_175_rtl_103_rtl_339~0\ & (\inst9|inst1|I3|data_x[3]~2107\ # !\inst9|inst1|I2|TD_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FD80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[0]\,
	datab => \inst9|inst1|I3|acc_c[0][3]\,
	datac => \inst9|inst1|I3|data_x[3]~2107\,
	datad => \inst9|inst1|I3|Mux_175_rtl_103_rtl_339~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|Mux_175_rtl_103_rtl_339~1\);

\rtl~10409_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10409\ = \rtl~1751\ # \rtl~1572\ # \rtl~9988\ & \inst9|inst1|I3|Mux_175_rtl_103_rtl_339~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FEFC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~9988\,
	datab => \rtl~1751\,
	datac => \rtl~1572\,
	datad => \inst9|inst1|I3|Mux_175_rtl_103_rtl_339~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10409\);

\inst9|inst1|I3|acc_i[0][3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_i[0][3]\ = DFFE(\inst9|inst1|I3|acc[0][3]~4390\ # \inst9|inst1|I3|acc[0][4]~4338\ & (\rtl~10426\ # \rtl~10409\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst1|I2|int_start_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FAEA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][3]~4390\,
	datab => \rtl~10426\,
	datac => \inst9|inst1|I3|acc[0][4]~4338\,
	datad => \rtl~10409\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_i[0][3]\);

\inst9|inst1|I3|acc[0][3]~4390_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc[0][3]~4390\ = \inst9|inst1|I3|acc[0][4]~63\ & (\inst9|inst1|I3|acc_c[0][3]\ # \inst9|inst1|I3|acc_i[0][3]\ & \inst9|inst1|I3|acc[0][4]~4339\) # !\inst9|inst1|I3|acc[0][4]~63\ & \inst9|inst1|I3|acc_i[0][3]\ & \inst9|inst1|I3|acc[0][4]~4339\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][4]~63\,
	datab => \inst9|inst1|I3|acc_c[0][3]\,
	datac => \inst9|inst1|I3|acc_i[0][3]\,
	datad => \inst9|inst1|I3|acc[0][4]~4339\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|acc[0][3]~4390\);

\inst9|inst1|I3|acc_c[0][3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_c[0][3]\ = DFFE(\inst9|inst1|I3|acc[0][3]~4390\ # \inst9|inst1|I3|acc[0][4]~4338\ & (\rtl~10426\ # \rtl~10409\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FAEA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][3]~4390\,
	datab => \rtl~10426\,
	datac => \inst9|inst1|I3|acc[0][4]~4338\,
	datad => \rtl~10409\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_c[0][3]\);

\inst9|inst1|I4|data_ox[3]~4_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|data_ox[3]~4\ = \inst9|inst1|I3|acc_c[0][3]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8800",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][3]\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datad => \inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|data_ox[3]~4\);

\inst9|inst15|lpm_ram_dq_component|sram|segment[0][3]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem2 => "00000011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001010000100100010010101010010101000001011011101101001000100101000111010100100111010101001101000101010100101000100000100101101001100011001010010101001011011011011011011110110110001011010101010101010101010100",
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|lpm_ram_dq1:inst15|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "rom.mif",
	logical_ram_depth => 1024,
	logical_ram_width => 14,
	address_width => 10,
	first_address => 0,
	last_address => 1023,
	bit_number => 3,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst1|I4|data_ox[3]~4\,
	clk0 => \clk~combout\,
	we => \inst9|inst19|i~50\,
	waddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][3]_waddr\,
	raddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][3]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst15|lpm_ram_dq_component|sram|segment[0][3]_modesel\,
	dataout => \inst9|inst15|lpm_ram_dq_component|sram|q[3]\);

\inst9|inst1|I2|idata_c[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_c[3]\ = DFFE(\inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|idata_c[3]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[3]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[3]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_c[3]\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst1|I2|i~509\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[3]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|idata_c[3]\);

\inst9|inst1|I2|idata_x[3]~16_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[3]~16\ = \inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|idata_c[3]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[3]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[3]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_c[3]\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst1|I2|i~509\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[3]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[3]~16\);

\inst9|inst1|I2|TC_c[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TC_c[1]\ = DFFE(\inst9|inst7\ & (\inst9|inst1|I2|idata_x[3]~16\ # \inst9|inst1|I2|idata_x[0]~19\ & \inst9|inst1|I2|TD_x[3]~35\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C888",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[3]~16\,
	datab => \inst9|inst7\,
	datac => \inst9|inst1|I2|idata_x[0]~19\,
	datad => \inst9|inst1|I2|TD_x[3]~35\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|TC_c[1]\);

\rtl~9972_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~9972\ = \inst9|inst1|I2|TD_c[1]\ & !\inst9|inst1|I2|TD_c[2]\ & (\inst9|inst1|I2|TC_c[1]\ $ \inst9|inst1|I2|TC_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0048",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TC_c[1]\,
	datab => \inst9|inst1|I2|TD_c[1]\,
	datac => \inst9|inst1|I2|TC_c[0]\,
	datad => \inst9|inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~9972\);

\rtl~10382_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10382\ = \rtl~9972\ & (\inst9|inst1|I3|data_x[2]~2074\ $ (\inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|acc_c[0][2]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2A80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~9972\,
	datab => \inst9|inst1|I2|TD_c[0]\,
	datac => \inst9|inst1|I3|acc_c[0][2]\,
	datad => \inst9|inst1|I3|data_x[2]~2074\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10382\);

\rtl~2017_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2017\ = \inst9|inst1|I2|TD_c[1]\ & \inst9|inst1|I3|acc_c[0][3]\ & !\inst9|inst1|I2|TD_c[2]\ # !\inst9|inst1|I2|TD_c[1]\ & (\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][3]\ # !\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][2]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "22B8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][3]\,
	datab => \inst9|inst1|I2|TD_c[1]\,
	datac => \inst9|inst1|I3|acc_c[0][2]\,
	datad => \inst9|inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2017\);

\rtl~2130_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2130\ = \inst9|inst1|I2|TD_c[2]\ & (\inst9|inst1|I3|acc_c[0][2]\ $ \inst9|inst1|I2|TD_c[1]\) # !\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5CAC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][2]\,
	datab => \inst9|inst1|I3|acc_c[0][1]\,
	datac => \inst9|inst1|I2|TD_c[2]\,
	datad => \inst9|inst1|I2|TD_c[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2130\);

\rtl~1736_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1736\ = !\inst9|inst1|I3|Mux_201_rtl_146~0\ & (\inst9|inst1|I2|TD_c[0]\ & \rtl~2130\ # !\inst9|inst1|I2|TD_c[0]\ & \rtl~2017\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5410",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	datab => \inst9|inst1|I2|TD_c[0]\,
	datac => \rtl~2017\,
	datad => \rtl~2130\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1736\);

\rtl~1566_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1566\ = \inst9|inst1|I3|acc_c[0][2]\ & !\inst9|inst1|I2|TD_c[1]\ & \inst9|inst1|I3|Mux_201_rtl_146~0\ & !\inst9|inst1|I2|TD_c[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0020",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][2]\,
	datab => \inst9|inst1|I2|TD_c[1]\,
	datac => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	datad => \inst9|inst1|I2|TD_c[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1566\);

\inst9|inst1|I3|Mux_176_rtl_97_rtl_333~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|Mux_176_rtl_97_rtl_333~0\ = \inst9|inst1|I2|TD_c[1]\ & (\inst9|inst1|I2|TD_c[0]\ # \inst9|inst1|I3|add_153~3\) # !\inst9|inst1|I2|TD_c[1]\ & !\inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|add_129~2\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "D9C8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[0]\,
	datab => \inst9|inst1|I2|TD_c[1]\,
	datac => \inst9|inst1|I3|add_153~3\,
	datad => \inst9|inst1|I3|add_129~2\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|Mux_176_rtl_97_rtl_333~0\);

\inst9|inst1|I3|Mux_176_rtl_97_rtl_333~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|Mux_176_rtl_97_rtl_333~1\ = \inst9|inst1|I3|acc_c[0][2]\ & (\inst9|inst1|I3|Mux_176_rtl_97_rtl_333~0\ # \inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|data_x[2]~2074\) # !\inst9|inst1|I3|acc_c[0][2]\ & \inst9|inst1|I3|Mux_176_rtl_97_rtl_333~0\ & (\inst9|inst1|I3|data_x[2]~2074\ # !\inst9|inst1|I2|TD_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FB80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][2]\,
	datab => \inst9|inst1|I2|TD_c[0]\,
	datac => \inst9|inst1|I3|data_x[2]~2074\,
	datad => \inst9|inst1|I3|Mux_176_rtl_97_rtl_333~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|Mux_176_rtl_97_rtl_333~1\);

\rtl~10365_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10365\ = \rtl~1736\ # \rtl~1566\ # \rtl~9988\ & \inst9|inst1|I3|Mux_176_rtl_97_rtl_333~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FEEE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~1736\,
	datab => \rtl~1566\,
	datac => \rtl~9988\,
	datad => \inst9|inst1|I3|Mux_176_rtl_97_rtl_333~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10365\);

\inst9|inst1|I3|acc_i[0][2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_i[0][2]\ = DFFE(\inst9|inst1|I3|acc[0][2]~4380\ # \inst9|inst1|I3|acc[0][4]~4338\ & (\rtl~10382\ # \rtl~10365\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst1|I2|int_start_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EEEC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][4]~4338\,
	datab => \inst9|inst1|I3|acc[0][2]~4380\,
	datac => \rtl~10382\,
	datad => \rtl~10365\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_i[0][2]\);

\inst9|inst1|I3|acc[0][2]~4380_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc[0][2]~4380\ = \inst9|inst1|I3|acc[0][4]~4339\ & (\inst9|inst1|I3|acc_i[0][2]\ # \inst9|inst1|I3|acc_c[0][2]\ & \inst9|inst1|I3|acc[0][4]~63\) # !\inst9|inst1|I3|acc[0][4]~4339\ & \inst9|inst1|I3|acc_c[0][2]\ & \inst9|inst1|I3|acc[0][4]~63\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F888",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][4]~4339\,
	datab => \inst9|inst1|I3|acc_i[0][2]\,
	datac => \inst9|inst1|I3|acc_c[0][2]\,
	datad => \inst9|inst1|I3|acc[0][4]~63\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|acc[0][2]~4380\);

\inst9|inst1|I3|acc_c[0][2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_c[0][2]\ = DFFE(\inst9|inst1|I3|acc[0][2]~4380\ # \inst9|inst1|I3|acc[0][4]~4338\ & (\rtl~10382\ # \rtl~10365\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FAF8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][4]~4338\,
	datab => \rtl~10382\,
	datac => \inst9|inst1|I3|acc[0][2]~4380\,
	datad => \rtl~10365\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_c[0][2]\);

\inst9|inst1|I4|data_ox[2]~5_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|data_ox[2]~5\ = \inst9|inst1|I3|acc_c[0][2]\ & \inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][2]\,
	datab => \inst9|inst7\,
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|data_ox[2]~5\);

\inst9|inst15|lpm_ram_dq_component|sram|segment[0][2]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem2 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000100000010000000010000100000000000000000001000000000001000010000000100110010001000001000001000000001000000000100000001000000010000010000000000000000000000000000000000100000010000000000000000000000000",
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|lpm_ram_dq1:inst15|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "rom.mif",
	logical_ram_depth => 1024,
	logical_ram_width => 14,
	address_width => 10,
	first_address => 0,
	last_address => 1023,
	bit_number => 2,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst1|I4|data_ox[2]~5\,
	clk0 => \clk~combout\,
	we => \inst9|inst19|i~50\,
	waddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][2]_waddr\,
	raddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][2]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst15|lpm_ram_dq_component|sram|segment[0][2]_modesel\,
	dataout => \inst9|inst15|lpm_ram_dq_component|sram|q[2]\);

\inst9|inst1|I2|idata_c[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_c[2]\ = DFFE(\inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|idata_c[2]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[2]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[2]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "E2AA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst15|lpm_ram_dq_component|sram|q[2]\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst1|I2|idata_c[2]\,
	datad => \inst9|inst1|I2|i~509\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|idata_c[2]\);

\inst9|inst1|I2|idata_x[2]~23_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[2]~23\ = \inst9|inst12|dwait_c\ & \inst9|inst1|I2|idata_c[2]\ & \inst9|inst1|I2|i~441\ & \inst9|inst1|I2|i~2\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|dwait_c\,
	datab => \inst9|inst1|I2|idata_c[2]\,
	datac => \inst9|inst1|I2|i~441\,
	datad => \inst9|inst1|I2|i~2\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[2]~23\);

\inst9|inst1|I2|idata_x[1]~20_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[1]~20\ = \inst9|inst12|dwait_c\ & \inst9|inst1|I2|idata_c[1]\ & \inst9|inst1|I2|i~441\ & \inst9|inst1|I2|i~2\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|dwait_c\,
	datab => \inst9|inst1|I2|idata_c[1]\,
	datac => \inst9|inst1|I2|i~441\,
	datad => \inst9|inst1|I2|i~2\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[1]~20\);

\inst9|inst1|I2|idata_x[1]~21_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[1]~21\ = \inst9|inst15|lpm_ram_dq_component|sram|q[1]\ & (!\inst9|inst1|I2|i~441\ # !\inst9|inst1|I2|i~2\ # !\inst9|inst12|dwait_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7F00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|dwait_c\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst1|I2|i~441\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[1]~21\);

\inst9|inst1|I2|idata_x[2]~24_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[2]~24\ = \inst9|inst15|lpm_ram_dq_component|sram|q[2]\ & (!\inst9|inst1|I2|i~441\ # !\inst9|inst1|I2|i~2\ # !\inst9|inst12|dwait_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7F00",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|dwait_c\,
	datab => \inst9|inst1|I2|i~2\,
	datac => \inst9|inst1|I2|i~441\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[2]~24\);

\inst9|inst1|I2|TD_x[3]~35_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TD_x[3]~35\ = !\inst9|inst1|I2|idata_x[2]~23\ & !\inst9|inst1|I2|idata_x[1]~20\ & !\inst9|inst1|I2|idata_x[1]~21\ & !\inst9|inst1|I2|idata_x[2]~24\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0001",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[2]~23\,
	datab => \inst9|inst1|I2|idata_x[1]~20\,
	datac => \inst9|inst1|I2|idata_x[1]~21\,
	datad => \inst9|inst1|I2|idata_x[2]~24\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|TD_x[3]~35\);

\inst9|inst1|I2|Mux_70~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|Mux_70~0\ = \inst9|inst1|I2|idata_x[4]~37\ & (\inst9|inst1|I2|idata_x[7]~31\ & !\inst9|inst1|I2|idata_x[5]~34\ & !\inst9|inst1|I2|idata_x[6]~28\ # !\inst9|inst1|I2|idata_x[7]~31\ & (!\inst9|inst1|I2|idata_x[6]~28\ # !\inst9|inst1|I2|idata_x[5]~34\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "1700",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[7]~31\,
	datab => \inst9|inst1|I2|idata_x[5]~34\,
	datac => \inst9|inst1|I2|idata_x[6]~28\,
	datad => \inst9|inst1|I2|idata_x[4]~37\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|Mux_70~0\);

\inst9|inst1|I2|TD_c[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TD_c[0]\ = DFFE(\inst9|inst1|I2|idata_x[0]~19\ & !\inst9|inst1|I2|TD_x[3]~35\ # !\inst9|inst1|I2|idata_x[0]~19\ & \inst9|inst1|I2|TD_x[3]~35\ & !\inst9|inst1|I2|idata_x[3]~16\ & \inst9|inst1|I2|Mux_70~0\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2622",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[0]~19\,
	datab => \inst9|inst1|I2|TD_x[3]~35\,
	datac => \inst9|inst1|I2|idata_x[3]~16\,
	datad => \inst9|inst1|I2|Mux_70~0\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|TD_c[0]\);

\rtl~10573_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10573\ = \rtl~9972\ & (\inst9|inst1|I3|data_x[6]~2206\ $ (\inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|acc_c[0][6]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4C80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[0]\,
	datab => \rtl~9972\,
	datac => \inst9|inst1|I3|acc_c[0][6]\,
	datad => \inst9|inst1|I3|data_x[6]~2206\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10573\);

\rtl~2062_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2062\ = \inst9|inst1|I2|TD_c[1]\ & !\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][7]\ # !\inst9|inst1|I2|TD_c[1]\ & (\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][7]\ # !\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][6]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7160",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[1]\,
	datab => \inst9|inst1|I2|TD_c[2]\,
	datac => \inst9|inst1|I3|acc_c[0][7]\,
	datad => \inst9|inst1|I3|acc_c[0][6]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2062\);

\rtl~2182_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2182\ = \inst9|inst1|I2|TD_c[2]\ & (\inst9|inst1|I2|TD_c[1]\ $ \inst9|inst1|I3|acc_c[0][6]\) # !\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][5]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2EE2",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][5]\,
	datab => \inst9|inst1|I2|TD_c[2]\,
	datac => \inst9|inst1|I2|TD_c[1]\,
	datad => \inst9|inst1|I3|acc_c[0][6]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2182\);

\rtl~1794_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1794\ = !\inst9|inst1|I3|Mux_201_rtl_146~0\ & (\inst9|inst1|I2|TD_c[0]\ & \rtl~2182\ # !\inst9|inst1|I2|TD_c[0]\ & \rtl~2062\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00CA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~2062\,
	datab => \rtl~2182\,
	datac => \inst9|inst1|I2|TD_c[0]\,
	datad => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1794\);

\rtl~1584_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1584\ = \inst9|inst1|I3|Mux_201_rtl_146~0\ & !\inst9|inst1|I2|TD_c[2]\ & !\inst9|inst1|I2|TD_c[1]\ & \inst9|inst1|I3|acc_c[0][6]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0200",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	datab => \inst9|inst1|I2|TD_c[2]\,
	datac => \inst9|inst1|I2|TD_c[1]\,
	datad => \inst9|inst1|I3|acc_c[0][6]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1584\);

\inst9|inst1|I3|Mux_172_rtl_121_rtl_357~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|Mux_172_rtl_121_rtl_357~0\ = \inst9|inst1|I2|TD_c[1]\ & (\inst9|inst1|I3|add_153~7\ # \inst9|inst1|I2|TD_c[0]\) # !\inst9|inst1|I2|TD_c[1]\ & !\inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|add_129~6\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ADA8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[1]\,
	datab => \inst9|inst1|I3|add_153~7\,
	datac => \inst9|inst1|I2|TD_c[0]\,
	datad => \inst9|inst1|I3|add_129~6\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|Mux_172_rtl_121_rtl_357~0\);

\inst9|inst1|I3|Mux_172_rtl_121_rtl_357~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|Mux_172_rtl_121_rtl_357~1\ = \inst9|inst1|I3|acc_c[0][6]\ & (\inst9|inst1|I3|Mux_172_rtl_121_rtl_357~0\ # \inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|data_x[6]~2206\) # !\inst9|inst1|I3|acc_c[0][6]\ & \inst9|inst1|I3|Mux_172_rtl_121_rtl_357~0\ & (\inst9|inst1|I3|data_x[6]~2206\ # !\inst9|inst1|I2|TD_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FD80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[0]\,
	datab => \inst9|inst1|I3|acc_c[0][6]\,
	datac => \inst9|inst1|I3|data_x[6]~2206\,
	datad => \inst9|inst1|I3|Mux_172_rtl_121_rtl_357~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|Mux_172_rtl_121_rtl_357~1\);

\rtl~10556_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10556\ = \rtl~1794\ # \rtl~1584\ # \rtl~9988\ & \inst9|inst1|I3|Mux_172_rtl_121_rtl_357~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FEEE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~1794\,
	datab => \rtl~1584\,
	datac => \rtl~9988\,
	datad => \inst9|inst1|I3|Mux_172_rtl_121_rtl_357~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10556\);

\inst9|inst1|I3|acc_i[0][6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_i[0][6]\ = DFFE(\inst9|inst1|I3|acc[0][6]~4420\ # \inst9|inst1|I3|acc[0][4]~4338\ & (\rtl~10573\ # \rtl~10556\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst1|I2|int_start_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FAF8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][4]~4338\,
	datab => \rtl~10573\,
	datac => \inst9|inst1|I3|acc[0][6]~4420\,
	datad => \rtl~10556\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_i[0][6]\);

\inst9|inst1|I3|acc[0][6]~4420_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc[0][6]~4420\ = \inst9|inst1|I3|acc[0][4]~63\ & (\inst9|inst1|I3|acc_c[0][6]\ # \inst9|inst1|I3|acc_i[0][6]\ & \inst9|inst1|I3|acc[0][4]~4339\) # !\inst9|inst1|I3|acc[0][4]~63\ & \inst9|inst1|I3|acc_i[0][6]\ & \inst9|inst1|I3|acc[0][4]~4339\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "ECA0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][4]~63\,
	datab => \inst9|inst1|I3|acc_i[0][6]\,
	datac => \inst9|inst1|I3|acc_c[0][6]\,
	datad => \inst9|inst1|I3|acc[0][4]~4339\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|acc[0][6]~4420\);

\inst9|inst1|I3|acc_c[0][6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_c[0][6]\ = DFFE(\inst9|inst1|I3|acc[0][6]~4420\ # \inst9|inst1|I3|acc[0][4]~4338\ & (\rtl~10573\ # \rtl~10556\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FAF8",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][4]~4338\,
	datab => \rtl~10573\,
	datac => \inst9|inst1|I3|acc[0][6]~4420\,
	datad => \rtl~10556\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_c[0][6]\);

\inst9|inst1|I4|data_ox[6]~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I4|data_ox[6]~1\ = \inst9|inst7\ & \inst9|inst1|I3|acc_c[0][6]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst7\,
	datab => \inst9|inst1|I3|acc_c[0][6]\,
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I4|data_ox[6]~1\);

\inst9|inst15|lpm_ram_dq_component|sram|segment[0][6]\ : apex20ke_ram_slice 
-- pragma translate_off
GENERIC MAP (
	mem2 => "00000011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	mem1 => "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001110000100000001000100001000100011001000000101010000111001101000100001010011011000001010010000100000000001011001011111000010000100010100010000101011000100110110100100100001010001010101000101010101000000001001",
	operation_mode => "single_port",
	logical_ram_name => "cpu_a:inst9|lpm_ram_dq1:inst15|lpm_ram_dq:lpm_ram_dq_component|altram:sram|content",
	init_file => "rom.mif",
	logical_ram_depth => 1024,
	logical_ram_width => 14,
	address_width => 10,
	first_address => 0,
	last_address => 1023,
	bit_number => 6,
	data_in_clock => "clock0",
	data_in_clear => "none",
	write_logic_clock => "clock0",
	write_logic_clear => "none",
	read_enable_clock => "none",
	read_enable_clear => "none",
	read_address_clock => "clock0",
	read_address_clear => "none",
	data_out_clock => "none",
	data_out_clear => "none",
	deep_ram_mode => "off")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst1|I4|data_ox[6]~1\,
	clk0 => \clk~combout\,
	we => \inst9|inst19|i~50\,
	waddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][6]_waddr\,
	raddr => \ww_inst9|inst15|lpm_ram_dq_component|sram|segment[0][6]_raddr\,
	devclrn => devclrn,
	devpor => devpor,
	modesel => \inst9|inst15|lpm_ram_dq_component|sram|segment[0][6]_modesel\,
	dataout => \inst9|inst15|lpm_ram_dq_component|sram|q[6]\);

\inst9|inst1|I2|data_is_c[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|data_is_c[2]\ = DFFE(\inst9|inst1|I2|i~2\ & (\inst9|inst1|I2|i~509\ & \inst9|inst1|I2|data_is_c[2]\ # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[6]\) # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[6]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F780",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|i~2\,
	datab => \inst9|inst1|I2|i~509\,
	datac => \inst9|inst1|I2|data_is_c[2]\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[6]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|data_is_c[2]\);

\inst9|inst12|i~1151_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|i~1151\ = !\inst9|inst1|I4|daddr_x[2]~28\ & !\inst9|inst1|I4|ndwe_x~1\ & (!\inst9|inst1|I4|i~18\ # !\inst9|inst1|I2|idata_x[6]~28\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0007",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[6]~28\,
	datab => \inst9|inst1|I4|i~18\,
	datac => \inst9|inst1|I4|daddr_x[2]~28\,
	datad => \inst9|inst1|I4|ndwe_x~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst12|i~1151\);

\inst9|inst12|dwait_c~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst12|dwait_c\ = DFFE(\inst9|inst12|i~128\ # \inst9|inst12|i~1151\ & !\inst9|inst1|I4|daddr_x[3]~19\ & \inst9|inst12|i~1131\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F2F0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|i~1151\,
	datab => \inst9|inst1|I4|daddr_x[3]~19\,
	datac => \inst9|inst12|i~128\,
	datad => \inst9|inst12|i~1131\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst12|dwait_c\);

\inst9|inst1|I2|i~509_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|i~509\ = (\inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\ & \inst9|inst12|dwait_c\ & \inst9|inst7\) & CASCADE(\inst9|inst1|I2|i~512\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|nreset_v_rtl_21|wysi_counter|sload_path[1]\,
	datac => \inst9|inst12|dwait_c\,
	datad => \inst9|inst7\,
	cascin => \inst9|inst1|I2|i~512\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|i~509\);

\inst9|inst1|I2|idata_c[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_c[0]\ = DFFE(\inst9|inst1|I2|i~509\ & (\inst9|inst1|I2|i~2\ & \inst9|inst1|I2|idata_c[0]\ # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[0]\) # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[0]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BF80",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_c[0]\,
	datab => \inst9|inst1|I2|i~509\,
	datac => \inst9|inst1|I2|i~2\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[0]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|idata_c[0]\);

\inst9|inst1|I2|idata_x[0]~19_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|idata_x[0]~19\ = \inst9|inst1|I2|i~509\ & (\inst9|inst1|I2|i~2\ & \inst9|inst1|I2|idata_c[0]\ # !\inst9|inst1|I2|i~2\ & \inst9|inst15|lpm_ram_dq_component|sram|q[0]\) # !\inst9|inst1|I2|i~509\ & \inst9|inst15|lpm_ram_dq_component|sram|q[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "BF80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_c[0]\,
	datab => \inst9|inst1|I2|i~509\,
	datac => \inst9|inst1|I2|i~2\,
	datad => \inst9|inst15|lpm_ram_dq_component|sram|q[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|idata_x[0]~19\);

\inst9|inst1|I2|TC_x[2]~570_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TC_x[2]~570\ = (\inst9|inst1|I2|idata_x[3]~16\ # !\inst9|inst1|I2|idata_x[0]~19\ & \inst9|inst1|I2|TC_x[2]~571\) & CASCADE(\inst9|inst1|I2|TC_x[1]~572\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "F5F0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|idata_x[0]~19\,
	datac => \inst9|inst1|I2|idata_x[3]~16\,
	datad => \inst9|inst1|I2|TC_x[2]~571\,
	cascin => \inst9|inst1|I2|TC_x[1]~572\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I2|TC_x[2]~570\);

\inst9|inst1|I2|TC_c[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I2|TC_c[2]\ = DFFE(\inst9|inst1|I2|TC_x[2]~570\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst1|I2|TC_x[2]~570\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I2|TC_c[2]\);

\rtl~1694_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1694\ = \inst9|inst1|I2|TC_c[2]\ & !\inst9|inst1|I2|TC_c[0]\ & !\inst9|inst1|I2|TC_c[1]\ # !\inst9|inst1|I2|TC_c[2]\ & !\inst9|inst1|I2|TD_c[3]\ & (!\inst9|inst1|I2|TC_c[1]\ # !\inst9|inst1|I2|TC_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0217",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TC_c[2]\,
	datab => \inst9|inst1|I2|TC_c[0]\,
	datac => \inst9|inst1|I2|TC_c[1]\,
	datad => \inst9|inst1|I2|TD_c[3]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1694\);

\inst9|inst1|I3|acc[0][4]~4338_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc[0][4]~4338\ = \rtl~1694\ & !\inst9|inst1|I2|TC_c[2]\ & \inst9|inst1|I3|i~173\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2020",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~1694\,
	datab => \inst9|inst1|I2|TC_c[2]\,
	datac => \inst9|inst1|I3|i~173\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|acc[0][4]~4338\);

\rtl~10336_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10336\ = \rtl~9972\ & (\inst9|inst1|I3|data_x[4]~2041\ $ (\inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|acc_c[0][4]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7080",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[0]\,
	datab => \inst9|inst1|I3|acc_c[0][4]\,
	datac => \rtl~9972\,
	datad => \inst9|inst1|I3|data_x[4]~2041\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10336\);

\rtl~1560_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1560\ = !\inst9|inst1|I2|TD_c[1]\ & !\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|Mux_201_rtl_146~0\ & \inst9|inst1|I3|acc_c[0][4]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "1000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[1]\,
	datab => \inst9|inst1|I2|TD_c[2]\,
	datac => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	datad => \inst9|inst1|I3|acc_c[0][4]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1560\);

\rtl~2006_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2006\ = \inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][5]\ & !\inst9|inst1|I2|TD_c[1]\ # !\inst9|inst1|I2|TD_c[2]\ & (\inst9|inst1|I2|TD_c[1]\ & \inst9|inst1|I3|acc_c[0][5]\ # !\inst9|inst1|I2|TD_c[1]\ & \inst9|inst1|I3|acc_c[0][4]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2B28",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][5]\,
	datab => \inst9|inst1|I2|TD_c[2]\,
	datac => \inst9|inst1|I2|TD_c[1]\,
	datad => \inst9|inst1|I3|acc_c[0][4]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2006\);

\rtl~2120_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~2120\ = \inst9|inst1|I2|TD_c[2]\ & (\inst9|inst1|I2|TD_c[1]\ $ \inst9|inst1|I3|acc_c[0][4]\) # !\inst9|inst1|I2|TD_c[2]\ & \inst9|inst1|I3|acc_c[0][3]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4EE4",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[2]\,
	datab => \inst9|inst1|I3|acc_c[0][3]\,
	datac => \inst9|inst1|I2|TD_c[1]\,
	datad => \inst9|inst1|I3|acc_c[0][4]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~2120\);

\rtl~1721_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~1721\ = !\inst9|inst1|I3|Mux_201_rtl_146~0\ & (\inst9|inst1|I2|TD_c[0]\ & \rtl~2120\ # !\inst9|inst1|I2|TD_c[0]\ & \rtl~2006\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0E02",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~2006\,
	datab => \inst9|inst1|I2|TD_c[0]\,
	datac => \inst9|inst1|I3|Mux_201_rtl_146~0\,
	datad => \rtl~2120\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~1721\);

\inst9|inst1|I3|Mux_174_rtl_91_rtl_327~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|Mux_174_rtl_91_rtl_327~0\ = \inst9|inst1|I2|TD_c[1]\ & (\inst9|inst1|I2|TD_c[0]\ # \inst9|inst1|I3|add_153~5\) # !\inst9|inst1|I2|TD_c[1]\ & !\inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|add_129~4\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "B9A8",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[1]\,
	datab => \inst9|inst1|I2|TD_c[0]\,
	datac => \inst9|inst1|I3|add_153~5\,
	datad => \inst9|inst1|I3|add_129~4\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|Mux_174_rtl_91_rtl_327~0\);

\inst9|inst1|I3|Mux_174_rtl_91_rtl_327~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|Mux_174_rtl_91_rtl_327~1\ = \inst9|inst1|I3|acc_c[0][4]\ & (\inst9|inst1|I3|Mux_174_rtl_91_rtl_327~0\ # \inst9|inst1|I2|TD_c[0]\ & \inst9|inst1|I3|data_x[4]~2041\) # !\inst9|inst1|I3|acc_c[0][4]\ & \inst9|inst1|I3|Mux_174_rtl_91_rtl_327~0\ & (\inst9|inst1|I3|data_x[4]~2041\ # !\inst9|inst1|I2|TD_c[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FD80",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I2|TD_c[0]\,
	datab => \inst9|inst1|I3|acc_c[0][4]\,
	datac => \inst9|inst1|I3|data_x[4]~2041\,
	datad => \inst9|inst1|I3|Mux_174_rtl_91_rtl_327~0\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|Mux_174_rtl_91_rtl_327~1\);

\rtl~10319_I\ : apex20ke_lcell 
-- Equation(s):
-- \rtl~10319\ = \rtl~1560\ # \rtl~1721\ # \rtl~9988\ & \inst9|inst1|I3|Mux_174_rtl_91_rtl_327~1\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FEFA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \rtl~1560\,
	datab => \rtl~9988\,
	datac => \rtl~1721\,
	datad => \inst9|inst1|I3|Mux_174_rtl_91_rtl_327~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \rtl~10319\);

\inst9|inst1|I3|acc_i[0][4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_i[0][4]\ = DFFE(\inst9|inst1|I3|acc[0][4]~4370\ # \inst9|inst1|I3|acc[0][4]~4338\ & (\rtl~10336\ # \rtl~10319\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst1|I2|int_start_c\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EEEC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][4]~4338\,
	datab => \inst9|inst1|I3|acc[0][4]~4370\,
	datac => \rtl~10336\,
	datad => \rtl~10319\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst1|I2|int_start_c\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_i[0][4]\);

\inst9|inst1|I3|acc[0][4]~4370_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc[0][4]~4370\ = \inst9|inst1|I3|acc_c[0][4]\ & (\inst9|inst1|I3|acc[0][4]~63\ # \inst9|inst1|I3|acc[0][4]~4339\ & \inst9|inst1|I3|acc_i[0][4]\) # !\inst9|inst1|I3|acc_c[0][4]\ & \inst9|inst1|I3|acc[0][4]~4339\ & \inst9|inst1|I3|acc_i[0][4]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EAC0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][4]\,
	datab => \inst9|inst1|I3|acc[0][4]~4339\,
	datac => \inst9|inst1|I3|acc_i[0][4]\,
	datad => \inst9|inst1|I3|acc[0][4]~63\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst1|I3|acc[0][4]~4370\);

\inst9|inst1|I3|acc_c[0][4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst1|I3|acc_c[0][4]\ = DFFE(\inst9|inst1|I3|acc[0][4]~4370\ # \inst9|inst1|I3|acc[0][4]~4338\ & (\rtl~10336\ # \rtl~10319\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EEEC",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc[0][4]~4338\,
	datab => \inst9|inst1|I3|acc[0][4]~4370\,
	datac => \rtl~10336\,
	datad => \rtl~10319\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst1|I3|acc_c[0][4]\);

\inst9|inst2|i~137_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|i~137\ = !\inst9|inst12|i~109\ & \inst9|inst12|i~103\ & !\inst9|inst12|i~115\ & \inst9|inst2|i~456\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0400",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|i~109\,
	datab => \inst9|inst12|i~103\,
	datac => \inst9|inst12|i~115\,
	datad => \inst9|inst2|i~456\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|i~137\);

\inst9|inst2|tx_clk_div[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_clk_div[4]\ = DFFE(\inst9|inst1|I3|acc_c[0][4]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|i~137\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][4]\,
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datad => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|i~137\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_clk_div[4]\);

\inst9|inst2|tx_clk_div[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_clk_div[3]\ = DFFE(\inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst1|I3|acc_c[0][3]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|i~137\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst7\,
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datad => \inst9|inst1|I3|acc_c[0][3]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|i~137\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_clk_div[3]\);

\inst9|inst2|tx_clk_div[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_clk_div[2]\ = DFFE(\inst9|inst1|I3|acc_c[0][2]\ & \inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|i~137\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][2]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|i~137\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_clk_div[2]\);

\inst9|inst2|tx_clk_div[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_clk_div[1]\ = DFFE(\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I3|acc_c[0][1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|i~137\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I3|acc_c[0][1]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|i~137\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_clk_div[1]\);

\inst9|inst2|tx_clk_div[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_clk_div[0]\ = DFFE(\inst9|inst1|I3|acc_c[0][0]\ & \inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|i~137\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][0]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|i~137\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_clk_div[0]\);

\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[0]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[0]\ = DFFE((\inst9|inst2|reduce_nor_7\ & \inst9|inst2|tx_clk_div[0]\) # (!\inst9|inst2|reduce_nor_7\ & !\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[0]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[0]~COUT\ = CARRY(!\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "qfbk_counter",
	packed_mode => "false",
	lut_mask => "0F0F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst2|tx_clk_div[0]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst2|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[0]\,
	cout => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[0]~COUT\);

\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[1]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[1]\ = DFFE((\inst9|inst2|reduce_nor_7\ & \inst9|inst2|tx_clk_div[1]\) # (!\inst9|inst2|reduce_nor_7\ & \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[1]\ $ \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[0]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[1]~COUT\ = CARRY(\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[1]\ # !\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[0]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3CCF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[1]\,
	datac => \inst9|inst2|tx_clk_div[1]\,
	cin => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[0]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst2|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[1]\,
	cout => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[1]~COUT\);

\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[2]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[2]\ = DFFE((\inst9|inst2|reduce_nor_7\ & \inst9|inst2|tx_clk_div[2]\) # (!\inst9|inst2|reduce_nor_7\ & \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[2]\ $ !\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[1]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[2]~COUT\ = CARRY(!\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[2]\ & !\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[1]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "A505",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[2]\,
	datac => \inst9|inst2|tx_clk_div[2]\,
	cin => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[1]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst2|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[2]\,
	cout => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[2]~COUT\);

\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[3]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[3]\ = DFFE((\inst9|inst2|reduce_nor_7\ & \inst9|inst2|tx_clk_div[3]\) # (!\inst9|inst2|reduce_nor_7\ & \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[3]\ $ \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[2]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[3]~COUT\ = CARRY(\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[3]\ # !\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[2]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5AAF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[3]\,
	datac => \inst9|inst2|tx_clk_div[3]\,
	cin => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[2]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst2|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[3]\,
	cout => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[3]~COUT\);

\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[4]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[4]\ = DFFE((\inst9|inst2|reduce_nor_7\ & \inst9|inst2|tx_clk_div[4]\) # (!\inst9|inst2|reduce_nor_7\ & \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[4]\ $ !\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[3]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[4]~COUT\ = CARRY(!\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[4]\ & !\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[3]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "C303",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[4]\,
	datac => \inst9|inst2|tx_clk_div[4]\,
	cin => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[3]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst2|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[4]\,
	cout => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[4]~COUT\);

\inst9|inst2|tx_clk_div[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_clk_div[5]\ = DFFE(\inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst1|I3|acc_c[0][5]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|i~137\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst7\,
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datad => \inst9|inst1|I3|acc_c[0][5]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|i~137\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_clk_div[5]\);

\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[5]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[5]\ = DFFE((\inst9|inst2|reduce_nor_7\ & \inst9|inst2|tx_clk_div[5]\) # (!\inst9|inst2|reduce_nor_7\ & \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[5]\ $ \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[4]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[5]~COUT\ = CARRY(\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[5]\ # !\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[4]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5AAF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[5]\,
	datac => \inst9|inst2|tx_clk_div[5]\,
	cin => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[4]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst2|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[5]\,
	cout => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[5]~COUT\);

\inst9|inst2|reduce_nor_7~32_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|reduce_nor_7~32\ = \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[3]\ # \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[1]\ # \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[2]\ # \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[3]\,
	datab => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[1]\,
	datac => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[2]\,
	datad => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|reduce_nor_7~32\);

\inst9|inst2|tx_clk_div[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_clk_div[7]\ = DFFE(\inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst1|I3|acc_c[0][7]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|i~137\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst7\,
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datad => \inst9|inst1|I3|acc_c[0][7]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|i~137\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_clk_div[7]\);

\inst9|inst2|tx_clk_div[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_clk_div[6]\ = DFFE(\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I3|acc_c[0][6]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|i~137\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I3|acc_c[0][6]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|i~137\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_clk_div[6]\);

\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[6]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[6]\ = DFFE((\inst9|inst2|reduce_nor_7\ & \inst9|inst2|tx_clk_div[6]\) # (!\inst9|inst2|reduce_nor_7\ & \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[6]\ $ !\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[5]~COUT\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )
-- \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[6]~COUT\ = CARRY(!\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[6]\ & !\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[5]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "C303",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[6]\,
	datac => \inst9|inst2|tx_clk_div[6]\,
	cin => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[5]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst2|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[6]\,
	cout => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[6]~COUT\);

\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[7]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[7]\ = DFFE((\inst9|inst2|reduce_nor_7\ & \inst9|inst2|tx_clk_div[7]\) # (!\inst9|inst2|reduce_nor_7\ & \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[6]~COUT\ $ \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[7]\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "0FF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst2|tx_clk_div[7]\,
	datad => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[7]\,
	cin => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|counter_cell[6]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	sload => \inst9|inst2|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[7]\);

\inst9|inst2|reduce_nor_7~39_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|reduce_nor_7~39\ = \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[7]\ # \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[6]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FAFA",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[7]\,
	datac => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[6]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|reduce_nor_7~39\);

\inst9|inst2|reduce_nor_7~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|reduce_nor_7\ = !\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[4]\ & !\inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[5]\ & !\inst9|inst2|reduce_nor_7~32\ & !\inst9|inst2|reduce_nor_7~39\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0001",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[4]\,
	datab => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[5]\,
	datac => \inst9|inst2|reduce_nor_7~32\,
	datad => \inst9|inst2|reduce_nor_7~39\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|reduce_nor_7\);

\inst9|inst2|reduce_nor_7~27_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|reduce_nor_7~27\ = \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[4]\ # \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[6]\ # \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[5]\ # \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[7]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFE",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[4]\,
	datab => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[6]\,
	datac => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[5]\,
	datad => \inst9|inst2|tx_clk_count_rtl_24|wysi_counter|q[7]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|reduce_nor_7~27\);

\inst9|inst2|tx_16_count[3]~3_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_16_count[3]~3\ = !\inst9|inst2|reduce_nor_7~32\ & \inst9|inst7\ & !\inst9|inst2|reduce_nor_7~27\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0030",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst2|reduce_nor_7~32\,
	datac => \inst9|inst7\,
	datad => \inst9|inst2|reduce_nor_7~27\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|tx_16_count[3]~3\);

\inst9|inst2|i~113_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|i~113\ = \inst9|inst2|tx_s\ & !\inst9|inst2|reduce_nor_34~11\ # !\inst9|inst2|tx_s\ & \inst9|inst2|tx_uart_busy\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "3F0C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst2|tx_s\,
	datac => \inst9|inst2|reduce_nor_34~11\,
	datad => \inst9|inst2|tx_uart_busy\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|i~113\);

\inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[0]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[0]\ = DFFE(!GLOBAL(\inst9|inst2|i~113\) & \inst9|inst2|tx_s\ $ \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[0]\, GLOBAL(\clk~combout\), , , \inst9|inst2|tx_16_count[3]~3\)
-- \inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[0]~COUT\ = CARRY(\inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "qfbk_counter",
	packed_mode => "false",
	lut_mask => "3CF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst2|tx_s\,
	clk => \clk~combout\,
	ena => \inst9|inst2|tx_16_count[3]~3\,
	sclr => \inst9|inst2|i~113\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[0]\,
	cout => \inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[0]~COUT\);

\inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[1]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[1]\ = DFFE(!GLOBAL(\inst9|inst2|i~113\) & \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[1]\ $ (\inst9|inst2|tx_s\ & \inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[0]~COUT\), GLOBAL(\clk~combout\), , , \inst9|inst2|tx_16_count[3]~3\)
-- \inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[1]~COUT\ = CARRY(!\inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[0]~COUT\ # !\inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "6C3F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_s\,
	datab => \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[1]\,
	cin => \inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[0]~COUT\,
	clk => \clk~combout\,
	ena => \inst9|inst2|tx_16_count[3]~3\,
	sclr => \inst9|inst2|i~113\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[1]\,
	cout => \inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[1]~COUT\);

\inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[2]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[2]\ = DFFE(!GLOBAL(\inst9|inst2|i~113\) & \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[2]\ $ (\inst9|inst2|tx_s\ & !\inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[1]~COUT\), GLOBAL(\clk~combout\), , , \inst9|inst2|tx_16_count[3]~3\)
-- \inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[2]~COUT\ = CARRY(\inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[2]\ & !\inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[1]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "A60A",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[2]\,
	datab => \inst9|inst2|tx_s\,
	cin => \inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[1]~COUT\,
	clk => \clk~combout\,
	ena => \inst9|inst2|tx_16_count[3]~3\,
	sclr => \inst9|inst2|i~113\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[2]\,
	cout => \inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[2]~COUT\);

\inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[3]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[3]\ = DFFE(!GLOBAL(\inst9|inst2|i~113\) & \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[3]\ $ (\inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[2]~COUT\ & \inst9|inst2|tx_s\), GLOBAL(\clk~combout\), , , \inst9|inst2|tx_16_count[3]~3\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5AAA",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[3]\,
	datad => \inst9|inst2|tx_s\,
	cin => \inst9|inst2|tx_16_count_rtl_27|wysi_counter|counter_cell[2]~COUT\,
	clk => \clk~combout\,
	ena => \inst9|inst2|tx_16_count[3]~3\,
	sclr => \inst9|inst2|i~113\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[3]\);

\inst9|inst2|reduce_nor_34~11_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|reduce_nor_34~11\ = !\inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[0]\ # !\inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[3]\ # !\inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[1]\ # !\inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7FFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[2]\,
	datab => \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[1]\,
	datac => \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[3]\,
	datad => \inst9|inst2|tx_16_count_rtl_27|wysi_counter|sload_path[0]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|reduce_nor_34~11\);

\inst9|inst2|tx_bit_count[3]~15_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_bit_count[3]~15\ = \inst9|inst2|reduce_nor_7\ & (\inst9|inst2|tx_s\ & !\inst9|inst2|reduce_nor_34~11\ # !\inst9|inst2|tx_s\ & \inst9|inst2|tx_uart_busy\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7040",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|reduce_nor_34~11\,
	datab => \inst9|inst2|tx_s\,
	datac => \inst9|inst2|reduce_nor_7\,
	datad => \inst9|inst2|tx_uart_busy\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|tx_bit_count[3]~15\);

\inst9|inst2|i~174_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|i~174\ = \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[3]\ & (\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\ # \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[2]\) # !\inst9|inst2|tx_s\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DDD5",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_s\,
	datab => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[3]\,
	datac => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\,
	datad => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|i~174\);

\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[0]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\ = DFFE(!GLOBAL(\inst9|inst2|i~174\) & !\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|tx_bit_count[3]~15\)
-- \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[0]~COUT\ = CARRY(\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "qfbk_counter",
	packed_mode => "false",
	lut_mask => "0FF0",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|tx_bit_count[3]~15\,
	sclr => \inst9|inst2|i~174\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\,
	cout => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[0]~COUT\);

\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[1]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\ = DFFE(!GLOBAL(\inst9|inst2|i~174\) & \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\ $ \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[0]~COUT\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|tx_bit_count[3]~15\)
-- \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[1]~COUT\ = CARRY(!\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[0]~COUT\ # !\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "3C3F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\,
	cin => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[0]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|tx_bit_count[3]~15\,
	sclr => \inst9|inst2|i~174\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\,
	cout => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[1]~COUT\);

\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[2]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[2]\ = DFFE(!GLOBAL(\inst9|inst2|i~174\) & \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[2]\ $ !\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[1]~COUT\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|tx_bit_count[3]~15\)
-- \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[2]~COUT\ = CARRY(\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[2]\ & !\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[1]~COUT\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "counter",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "A50A",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[2]\,
	cin => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[1]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|tx_bit_count[3]~15\,
	sclr => \inst9|inst2|i~174\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[2]\,
	cout => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[2]~COUT\);

\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[3]\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[3]\ = DFFE(!GLOBAL(\inst9|inst2|i~174\) & \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[3]\ $ \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[2]~COUT\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|tx_bit_count[3]~15\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	cin_used => "true",
	packed_mode => "false",
	lut_mask => "5A5A",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[3]\,
	cin => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|counter_cell[2]~COUT\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|tx_bit_count[3]~15\,
	sclr => \inst9|inst2|i~174\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[3]\);

\inst9|inst2|tx_s~12_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_s~12\ = \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\ # \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[2]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFF0",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	datac => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\,
	datad => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|tx_s~12\);

\inst9|inst2|tx_s~23_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_s~23\ = !\inst9|inst2|reduce_nor_34~11\ & \inst9|inst2|tx_s\ & \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[3]\ & \inst9|inst2|tx_s~12\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4000",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|reduce_nor_34~11\,
	datab => \inst9|inst2|tx_s\,
	datac => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[3]\,
	datad => \inst9|inst2|tx_s~12\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|tx_s~23\);

\inst9|inst2|tx_s~27_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_s~27\ = \inst9|inst2|reduce_nor_7\ & (\inst9|inst2|tx_s~23\ # !\inst9|inst2|tx_s\ & \inst9|inst2|tx_uart_busy\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "CC40",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_s\,
	datab => \inst9|inst2|reduce_nor_7\,
	datac => \inst9|inst2|tx_uart_busy\,
	datad => \inst9|inst2|tx_s~23\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|tx_s~27\);

\inst9|inst2|tx_s~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_s\ = DFFE(!\inst9|inst2|tx_s\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|tx_s~27\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00FF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst2|tx_s\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|tx_s~27\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_s\);

\inst9|inst2|tx_uart_fifo[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_fifo[7]\ = DFFE(!\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ # !\inst9|inst7\ # !\inst9|inst1|I3|acc_c[0][7]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|i~45\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5FFF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][7]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|i~45\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_fifo[7]\);

\inst9|inst2|tx_uart_shift[8]~2_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_shift[8]~2\ = !\inst9|inst2|tx_s\ & !\inst9|inst2|reduce_nor_7~32\ & \inst9|inst2|tx_uart_busy\ & !\inst9|inst2|reduce_nor_7~27\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0010",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_s\,
	datab => \inst9|inst2|reduce_nor_7~32\,
	datac => \inst9|inst2|tx_uart_busy\,
	datad => \inst9|inst2|reduce_nor_7~27\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|tx_uart_shift[8]~2\);

\inst9|inst2|tx_uart_shift[8]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_shift[8]\ = DFFE(\inst9|inst2|tx_uart_fifo[7]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|tx_uart_shift[8]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst2|tx_uart_fifo[7]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|tx_uart_shift[8]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_shift[8]\);

\inst9|inst2|i~471_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|i~471\ = \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[3]\ & (\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\ & !\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\ # !\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\ & (\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\ # !\inst9|inst2|tx_uart_shift[8]\))

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "6070",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\,
	datab => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\,
	datac => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[3]\,
	datad => \inst9|inst2|tx_uart_shift[8]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|i~471\);

\inst9|inst2|tx_uart_shift[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_shift[0]\ = DFFE(VCC, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|tx_uart_shift[8]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FFFF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|tx_uart_shift[8]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_shift[0]\);

\inst9|inst2|tx_uart_fifo[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_fifo[1]\ = DFFE(!\inst9|inst7\ # !\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ # !\inst9|inst1|I3|acc_c[0][1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|i~45\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7F7F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][1]\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|i~45\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_fifo[1]\);

\inst9|inst2|tx_uart_shift[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_shift[2]\ = DFFE(\inst9|inst2|tx_uart_fifo[1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|tx_uart_shift[8]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst2|tx_uart_fifo[1]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|tx_uart_shift[8]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_shift[2]\);

\inst9|inst2|Mux_29_rtl_39~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|Mux_29_rtl_39~0\ = \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\ & (\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\ # !\inst9|inst2|tx_uart_shift[2]\) # !\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\ & !\inst9|inst2|tx_uart_shift[0]\ & !\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C1F1",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_uart_shift[0]\,
	datab => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\,
	datac => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\,
	datad => \inst9|inst2|tx_uart_shift[2]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|Mux_29_rtl_39~0\);

\inst9|inst2|tx_uart_fifo[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_fifo[2]\ = DFFE(!\inst9|inst7\ # !\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ # !\inst9|inst1|I3|acc_c[0][2]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|i~45\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7F7F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][2]\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|i~45\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_fifo[2]\);

\inst9|inst2|tx_uart_shift[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_shift[3]\ = DFFE(\inst9|inst2|tx_uart_fifo[2]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|tx_uart_shift[8]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst2|tx_uart_fifo[2]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|tx_uart_shift[8]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_shift[3]\);

\inst9|inst2|tx_uart_fifo[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_fifo[0]\ = DFFE(!\inst9|inst7\ # !\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ # !\inst9|inst1|I3|acc_c[0][0]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|i~45\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7F7F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][0]\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|i~45\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_fifo[0]\);

\inst9|inst2|tx_uart_shift[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_shift[1]\ = DFFE(\inst9|inst2|tx_uart_fifo[0]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|tx_uart_shift[8]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst2|tx_uart_fifo[0]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|tx_uart_shift[8]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_shift[1]\);

\inst9|inst2|Mux_29_rtl_39~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|Mux_29_rtl_39~1\ = \inst9|inst2|Mux_29_rtl_39~0\ & (!\inst9|inst2|tx_uart_shift[3]\ # !\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\) # !\inst9|inst2|Mux_29_rtl_39~0\ & \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\ & !\inst9|inst2|tx_uart_shift[1]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2A6E",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|Mux_29_rtl_39~0\,
	datab => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\,
	datac => \inst9|inst2|tx_uart_shift[3]\,
	datad => \inst9|inst2|tx_uart_shift[1]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|Mux_29_rtl_39~1\);

\inst9|inst2|tx_uart_fifo[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_fifo[6]\ = DFFE(!\inst9|inst7\ # !\inst9|inst1|I3|acc_c[0][6]\ # !\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|i~45\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7F7F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datab => \inst9|inst1|I3|acc_c[0][6]\,
	datac => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|i~45\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_fifo[6]\);

\inst9|inst2|tx_uart_shift[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_shift[7]\ = DFFE(\inst9|inst2|tx_uart_fifo[6]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|tx_uart_shift[8]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst2|tx_uart_fifo[6]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|tx_uart_shift[8]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_shift[7]\);

\inst9|inst2|tx_uart_fifo[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_fifo[3]\ = DFFE(!\inst9|inst7\ # !\inst9|inst1|I3|acc_c[0][3]\ # !\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|i~45\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7F7F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datab => \inst9|inst1|I3|acc_c[0][3]\,
	datac => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|i~45\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_fifo[3]\);

\inst9|inst2|tx_uart_shift[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_shift[4]\ = DFFE(\inst9|inst2|tx_uart_fifo[3]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|tx_uart_shift[8]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst2|tx_uart_fifo[3]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|tx_uart_shift[8]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_shift[4]\);

\inst9|inst2|tx_uart_fifo[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_fifo[5]\ = DFFE(!\inst9|inst7\ # !\inst9|inst1|I3|acc_c[0][5]\ # !\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|i~45\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "7F7F",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datab => \inst9|inst1|I3|acc_c[0][5]\,
	datac => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|i~45\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_fifo[5]\);

\inst9|inst2|tx_uart_shift[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_shift[6]\ = DFFE(\inst9|inst2|tx_uart_fifo[5]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|tx_uart_shift[8]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst2|tx_uart_fifo[5]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|tx_uart_shift[8]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_shift[6]\);

\inst9|inst2|Mux_29_rtl_40~0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|Mux_29_rtl_40~0\ = \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\ & (\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\ # !\inst9|inst2|tx_uart_shift[6]\) # !\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\ & !\inst9|inst2|tx_uart_shift[4]\ & !\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C1F1",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_uart_shift[4]\,
	datab => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\,
	datac => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[1]\,
	datad => \inst9|inst2|tx_uart_shift[6]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|Mux_29_rtl_40~0\);

\inst9|inst2|tx_uart_fifo[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_fifo[4]\ = DFFE(!\inst9|inst7\ # !\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ # !\inst9|inst1|I3|acc_c[0][4]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|i~45\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "5FFF",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][4]\,
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datad => \inst9|inst7\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|i~45\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_fifo[4]\);

\inst9|inst2|tx_uart_shift[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart_shift[5]\ = DFFE(\inst9|inst2|tx_uart_fifo[4]\, GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|tx_uart_shift[8]~2\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "FF00",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datad => \inst9|inst2|tx_uart_fifo[4]\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|tx_uart_shift[8]~2\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart_shift[5]\);

\inst9|inst2|Mux_29_rtl_40~1_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|Mux_29_rtl_40~1\ = \inst9|inst2|Mux_29_rtl_40~0\ & (!\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\ # !\inst9|inst2|tx_uart_shift[7]\) # !\inst9|inst2|Mux_29_rtl_40~0\ & \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\ & !\inst9|inst2|tx_uart_shift[5]\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "4C7C",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_uart_shift[7]\,
	datab => \inst9|inst2|Mux_29_rtl_40~0\,
	datac => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[0]\,
	datad => \inst9|inst2|tx_uart_shift[5]\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|Mux_29_rtl_40~1\);

\inst9|inst2|i~190_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|i~190\ = !\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[3]\ & (\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[2]\ & \inst9|inst2|Mux_29_rtl_40~1\ # !\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[2]\ & \inst9|inst2|Mux_29_rtl_39~1\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "3202",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|Mux_29_rtl_39~1\,
	datab => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[3]\,
	datac => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[2]\,
	datad => \inst9|inst2|Mux_29_rtl_40~1\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst2|i~190\);

\inst9|inst2|tx_uart~reg0_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst2|tx_uart~reg0\ = DFFE(\inst9|inst2|tx_s\ & !\inst9|inst2|i~190\ & (\inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[2]\ # !\inst9|inst2|i~471\), GLOBAL(\clk~combout\), GLOBAL(\inst9|inst7\), , \inst9|inst2|reduce_nor_7\)

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "00A2",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst2|tx_s\,
	datab => \inst9|inst2|i~471\,
	datac => \inst9|inst2|tx_bit_count_rtl_26|wysi_counter|sload_path[2]\,
	datad => \inst9|inst2|i~190\,
	clk => \clk~combout\,
	aclr => \NOT_inst9|inst7\,
	ena => \inst9|inst2|reduce_nor_7\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst2|tx_uart~reg0\);

\inst9|inst33~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst33\ = DFFE(!\inst9|inst12|i~103\ & !\inst9|inst12|i~109\ & \inst9|inst12|i~115\ & \inst9|inst2|i~455\, GLOBAL(\clk~combout\), , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "1000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|i~103\,
	datab => \inst9|inst12|i~109\,
	datac => \inst9|inst12|i~115\,
	datad => \inst9|inst2|i~455\,
	clk => \clk~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst33\);

\inst9|inst19|i~93_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst19|i~93\ = \inst9|inst1|I4|ndre_x~1\ & !\inst9|inst12|cpu_daddr_c[4]\ # !\inst9|inst1|I4|ndre_x~1\ & !\inst9|inst12|cpu_daddr_x[4]~12\ # !\inst9|inst2|i~455\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "2F7F",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|ndre_x~1\,
	datab => \inst9|inst12|cpu_daddr_c[4]\,
	datac => \inst9|inst2|i~455\,
	datad => \inst9|inst12|cpu_daddr_x[4]~12\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst19|i~93\);

\inst9|inst34~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst34\ = \inst9|inst33\ & !\inst9|inst19|i~93\ & !\inst9|inst12|i~103\ & !\inst9|inst12|i~109\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0002",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst33\,
	datab => \inst9|inst19|i~93\,
	datac => \inst9|inst12|i~103\,
	datad => \inst9|inst12|i~109\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst34\);

\inst9|inst19|i~89_I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst19|i~89\ = \inst9|inst12|i~109\ # \inst9|inst12|i~103\ # !\inst9|inst12|i~115\ # !\inst9|inst2|i~455\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "EFFF",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|i~109\,
	datab => \inst9|inst12|i~103\,
	datac => \inst9|inst2|i~455\,
	datad => \inst9|inst12|i~115\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst19|i~89\);

\inst9|inst25~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst25\ = DFFE(\inst9|inst12|i~127\ & !\inst9|inst12|i~103\ & !\inst9|inst12|i~109\ & !\inst9|inst19|i~93\, GLOBAL(\clk~combout\), , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "0002",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst12|i~127\,
	datab => \inst9|inst12|i~103\,
	datac => \inst9|inst12|i~109\,
	datad => \inst9|inst19|i~93\,
	clk => \clk~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst25\);

\inst9|inst28~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst28\ = \inst9|inst25\ # !\inst9|inst19|i~89\ & \inst9|inst12|i~127\

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "DDCC",
	output_mode => "comb_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst19|i~89\,
	datab => \inst9|inst25\,
	datad => \inst9|inst12|i~127\,
	devclrn => devclrn,
	devpor => devpor,
	combout => \inst9|inst28\);

\inst9|inst36[7]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst36[7]\ = DFFE(\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst1|I3|acc_c[0][7]\ & \inst9|inst7\, GLOBAL(\clk~combout\), , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "A000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst1|I3|acc_c[0][7]\,
	datad => \inst9|inst7\,
	clk => \clk~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst36[7]\);

\inst9|inst36[6]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst36[6]\ = DFFE(\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I3|acc_c[0][6]\, GLOBAL(\clk~combout\), , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I3|acc_c[0][6]\,
	clk => \clk~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst36[6]\);

\inst9|inst36[5]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst36[5]\ = DFFE(\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I3|acc_c[0][5]\, GLOBAL(\clk~combout\), , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I3|acc_c[0][5]\,
	clk => \clk~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst36[5]\);

\inst9|inst36[4]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst36[4]\ = DFFE(\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I3|acc_c[0][4]\, GLOBAL(\clk~combout\), , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I3|acc_c[0][4]\,
	clk => \clk~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst36[4]\);

\inst9|inst36[3]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst36[3]\ = DFFE(\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I3|acc_c[0][3]\, GLOBAL(\clk~combout\), , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I3|acc_c[0][3]\,
	clk => \clk~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst36[3]\);

\inst9|inst36[2]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst36[2]\ = DFFE(\inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\ & \inst9|inst1|I3|acc_c[0][2]\, GLOBAL(\clk~combout\), , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "C000",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	datad => \inst9|inst1|I3|acc_c[0][2]\,
	clk => \clk~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst36[2]\);

\inst9|inst36[1]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst36[1]\ = DFFE(\inst9|inst1|I3|acc_c[0][1]\ & \inst9|inst7\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\, GLOBAL(\clk~combout\), , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][1]\,
	datab => \inst9|inst7\,
	datac => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	clk => \clk~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst36[1]\);

\inst9|inst36[0]~I\ : apex20ke_lcell 
-- Equation(s):
-- \inst9|inst36[0]\ = DFFE(\inst9|inst1|I3|acc_c[0][0]\ & \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\ & \inst9|inst7\, GLOBAL(\clk~combout\), , , )

-- pragma translate_off
GENERIC MAP (
	operation_mode => "normal",
	packed_mode => "false",
	lut_mask => "8080",
	output_mode => "reg_only")
-- pragma translate_on
PORT MAP (
	dataa => \inst9|inst1|I3|acc_c[0][0]\,
	datab => \inst9|inst1|I4|nreset_v_rtl_23|wysi_counter|sload_path[1]\,
	datac => \inst9|inst7\,
	clk => \clk~combout\,
	devclrn => devclrn,
	devpor => devpor,
	regout => \inst9|inst36[0]\);

\user_LED1~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => \NOT_inst9|inst2|tx_uart~reg0\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_user_LED1);

\TXD~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => \NOT_inst9|inst2|tx_uart~reg0\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_TXD);

\user_LED0~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => \RXD~combout\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_user_LED0);

\display_e~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst34\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_display_e);

\display_rs~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst28\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_display_rs);

\display[7]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst36[7]\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_display(7));

\display[6]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst36[6]\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_display(6));

\display[5]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst36[5]\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_display(5));

\display[4]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst36[4]\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_display(4));

\display[3]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst36[3]\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_display(3));

\display[2]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst36[2]\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_display(2));

\display[1]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst36[1]\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_display(1));

\display[0]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => \inst9|inst36[0]\,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_display(0));

\user_pb2~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => GND,
	ena => VCC,
	padio => ww_user_pb2);

\user_sw[7]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => GND,
	ena => VCC,
	padio => ww_user_sw(7));

\user_sw[6]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => GND,
	ena => VCC,
	padio => ww_user_sw(6));

\user_sw[5]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => GND,
	ena => VCC,
	padio => ww_user_sw(5));

\user_sw[4]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => GND,
	ena => VCC,
	padio => ww_user_sw(4));

\user_sw[3]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => GND,
	ena => VCC,
	padio => ww_user_sw(3));

\user_sw[2]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => GND,
	ena => VCC,
	padio => ww_user_sw(2));

\user_sw[1]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => GND,
	ena => VCC,
	padio => ww_user_sw(1));

\user_sw[0]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input",
	reg_source_mode => "none",
	feedback_mode => "from_pin",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => GND,
	ena => VCC,
	padio => ww_user_sw(0));

\display_rw~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_display_rw);

\HEADER_SWITCH_enable1_n~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_HEADER_SWITCH_enable1_n);

\hex[7]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_hex(7));

\hex[6]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_hex(6));

\hex[5]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_hex(5));

\hex[4]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_hex(4));

\hex[3]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_hex(3));

\hex[2]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_hex(2));

\hex[1]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_hex(1));

\hex[0]~I\ : apex20ke_io 
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output",
	reg_source_mode => "none",
	feedback_mode => "none",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => devclrn,
	devpor => devpor,
	devoe => devoe,
	oe => VCC,
	ena => VCC,
	padio => ww_hex(0));
END structure;


