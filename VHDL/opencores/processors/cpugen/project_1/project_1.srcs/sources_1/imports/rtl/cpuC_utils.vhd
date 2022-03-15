--
--	CPUC_UTILS
--	rel. 2.0
-- 	by gferrante@opencores.org
--

library ieee;
use ieee.std_logic_1164.all;

package CPUC_UTILS is


-- CONFIGURATION SETTING

	constant	 IPAGE_LEN 	: integer := 0;
	constant	 DPAGE_LEN 	: integer := 0;
	constant	 DATA_LEN 	: integer := 32;
	constant	 ISTR_LEN 	: integer := 32;
	constant	 STACK_SIZE : integer := 8;
	constant	 MBUS_LEN 	: integer := 27; -- CUSTOM:  28 => 27 (ENCODING)
	constant	 DIN_LEN 	: integer := 32; 
	constant	 DOUT_LEN 	: integer := 32; 
	constant	 CODE_LEN 	: integer := 5; 	-- CUSTOM:  4 => 5 (ENCODING)
	constant	 ICODE_LEN 	: integer := 5; 	-- CUSTOM:  4 => 5 (ENCODING)
	constant	 CCLASS_LEN : integer := 3; 	-- CCLASS_LEN >= 3 and CCLASS_LEN <= ISTR_LEN  
	constant	 DCLASS_LEN : integer := 5; 	-- CUSTOM:  4 => 5 (ENCODING)
	constant	 ACC_NUM	: integer := 3;	-- CUSTOM:  1 => 3 (NUM OF INTERNAL REGISTERS)
	constant	 BUS_LEN 	: integer := (ISTR_LEN - CODE_LEN);
	constant	 DADDR_LEN 	: integer := (DPAGE_LEN + BUS_LEN);
	constant	 IADDR_LEN 	: integer := (IPAGE_LEN + BUS_LEN);
	constant	 IMEM_ADDR 	: integer := (2 ** IADDR_LEN);
	constant	 DMEM_ADDR 	: integer := (2 ** DADDR_LEN);
	constant	 IMUX_LEN 	: integer := 3;
	constant	 OA_LEN 	: integer := 3;
	constant	 RESET_LEN 	: integer := 2;

-- SUBTYPE SETTING

	subtype Cpu_imux     is std_logic_vector((IMUX_LEN - 1) downto 0);
	subtype Cpu_iaddr    is std_logic_vector((IADDR_LEN - 1) downto 0);
	subtype Cpu_daddr    is std_logic_vector((DADDR_LEN - 1) downto 0);
	subtype Cpu_ibus     is std_logic_vector((ISTR_LEN - 1) downto 0);
	subtype Cpu_dbus     is std_logic_vector((DATA_LEN - 1) downto 0);
	subtype Cpu_dobus    is std_logic_vector((DOUT_LEN - 1) downto 0);
	subtype Cpu_dibus    is std_logic_vector((DIN_LEN - 1) downto 0);
	subtype Cpu_acc      is std_logic_vector(DATA_LEN downto 0);
	subtype Cpu_acc2bus  is std_logic_vector((2 * DATA_LEN - 1) downto 0); -- CUSTOM
	type 	Cpu_abus       is array	((ACC_NUM - 1) downto 0) of Cpu_acc;
	subtype Cpu_bus      is std_logic_vector((BUS_LEN - 1) downto 0);
	subtype Cpu_mbus     is std_logic_vector((MBUS_LEN - 1) downto 0);
	subtype Cpu_ia       is std_logic_vector((OA_LEN - 1) downto 0);
	subtype Cpu_di       is std_logic_vector((DATA_LEN - IPAGE_LEN - 1) downto 0);
	subtype Cpu_ba       is std_logic_vector((BUS_LEN - OA_LEN - 1) downto 0);
	subtype Cpu_ma       is std_logic_vector(((2 * MBUS_LEN) - 1) downto 0);

	subtype Cpu_nreset   is std_logic_vector((RESET_LEN - 1) downto 0);
	subtype Cpu_code     is std_logic_vector((CODE_LEN - 1) downto 0);
	subtype Cpu_icode    is std_logic_vector((ICODE_LEN - 1) downto 0);
	subtype Cpu_cclass   is std_logic_vector((CCLASS_LEN - 1) downto 0);
	subtype Cpu_dclass   is std_logic_vector((DCLASS_LEN - 1) downto 0);

	type	stack_area   is array	((STACK_SIZE - 1) downto 0) of Cpu_iaddr;

	type	Cpu_status   is (RESET, NORMAL, INTERRUPT);
	type	Cpu_event    is (NONE_E, DWAIT_E, IWAIT_E, INT_E);


-- CONSTANTS

	constant 	nreset_value: Std_logic := '0';

-- 	Control & Data Unit

	constant	 M_LK		: Cpu_code     := "00000"; -- CUSTOM
	constant	 M_J		: Cpu_code     := "01000"; -- CUSTOM
	constant	 M_JS		: Cpu_code     := "01001"; -- CUSTOM
	constant	 M_S		: Cpu_code     := "00001"; -- CUSTOM

	constant	 M_LK_NOP	: Cpu_icode    := "00000"; -- CUSTOM
	constant	 M_LK_ROL	: Cpu_icode    := "00001"; -- CUSTOM
	constant	 M_LK_ROR	: Cpu_icode    := "00010"; -- CUSTOM
	constant	 M_LK_SHL	: Cpu_icode    := "00011"; -- CUSTOM
	constant	 M_LK_SHR	: Cpu_icode    := "00100"; -- CUSTOM
	constant	 M_LK_NOT	: Cpu_icode    := "00101"; -- CUSTOM
	constant	 M_LK_CLA	: Cpu_icode    := "00110"; -- CUSTOM
	constant	 M_LK_LMUHA	: Cpu_icode    := "00111"; -- CUSTOM
	constant	 M_LK_SKZ	: Cpu_icode    := "01000"; -- CUSTOM
	constant	 M_LK_SKC	: Cpu_icode    := "01001"; -- CUSTOM
	constant	 M_LK_SKNZ	: Cpu_icode    := "01010"; -- CUSTOM
	constant	 M_LK_SKNC	: Cpu_icode    := "01011"; -- CUSTOM
	constant	 M_LK_RTS	: Cpu_icode    := "01100"; -- CUSTOM
	constant	 M_LK_RTI	: Cpu_icode    := "01101"; -- CUSTOM
	constant	 M_LK_SKV	: Cpu_icode    := "01110"; -- CUSTOM
	constant	 M_LK_SKNV	: Cpu_icode    := "01111"; -- CUSTOM

	constant	 TC_OTH		: Cpu_cclass   := "000";
	constant	 TC_LDA		: Cpu_cclass   := "001";
	constant	 TC_DAT		: Cpu_cclass   := "010";
	constant	 TC_STA		: Cpu_cclass   := "011";
	constant	 TC_RTI		: Cpu_cclass   := "100";
	constant	 TC_RTS		: Cpu_cclass   := "101";
	constant	 TC_JMP		: Cpu_cclass   := "110";
	constant	 TC_JMS		: Cpu_cclass   := "111";

	constant	 TD_NOP		: Cpu_dclass   := "00000"; -- CUSTOM
	constant	 TD_ROL		: Cpu_dclass   := "00001"; -- CUSTOM
	constant	 TD_ROR		: Cpu_dclass   := "00010"; -- CUSTOM  
	constant	 TD_SHL		: Cpu_dclass   := "00011"; -- CUSTOM
	constant	 TD_SHR		: Cpu_dclass   := "00100"; -- CUSTOM
	constant	 TD_CLA		: Cpu_dclass   := "00110"; -- CUSTOM
	constant	 TD_NOT		: Cpu_dclass   := "00111"; -- CUSTOM
	constant	 TD_LMUHA		: Cpu_dclass   := "01000"; -- CUSTOM

	constant	 TD_SKZ		: Cpu_dclass   := "10000"; -- CUSTOM
	constant	 TD_SKC		: Cpu_dclass   := "10001"; -- CUSTOM
	constant	 TD_SKNZ		: Cpu_dclass   := "10010"; -- CUSTOM
	constant	 TD_SKNC		: Cpu_dclass   := "10011"; -- CUSTOM
	constant	 TD_SKV		: Cpu_dclass   := "10100"; -- CUSTOM
	constant	 TD_SKNV		: Cpu_dclass   := "10101"; -- CUSTOM

	constant	 TD_LDA		: Cpu_dclass   := "00010"; -- CUSTOM
	constant	 TD_XOR		: Cpu_dclass   := "00011"; -- CUSTOM
	constant	 TD_ADD		: Cpu_dclass   := "00100"; -- CUSTOM
	constant	 TD_AND		: Cpu_dclass   := "00101"; -- CUSTOM
	constant	 TD_SUB		: Cpu_dclass   := "00110"; -- CUSTOM
	constant	 TD_OR		: Cpu_dclass   := "00111"; -- CUSTOM
	constant	 TD_ADDS		: Cpu_dclass   := "01010"; -- CUSTOM
	constant	 TD_SUBS		: Cpu_dclass   := "01011"; -- CUSTOM
	constant	 TD_MULS		: Cpu_dclass   := "01100"; -- CUSTOM
	constant	 TD_MUL		: Cpu_dclass   := "01101"; -- CUSTOM
	constant	 TD_SHLN		: Cpu_dclass   := "01110"; -- CUSTOM
	constant	 TD_SHRN		: Cpu_dclass   := "01111"; -- CUSTOM

-- DEBUG

	type		 OP is (NOP_I, ROL_I, ROR_I, SHL_I, SHR_I, NOT_I, CLA_I,
				  SKZ_I, SKC_I, SKNZ_I, SKNC_I, RTS_I, RTI_I,
				  JMP_I, JMS_I, STA_I, LDA_I, XOR_I, ADD_I,
				  AND_I, SUB_I, OR_I, LDAI_I, XORI_I, ADDI_I,
				  ANDI_I, SUBI_I, ORI_I, ADDS_I, ADDSI_I, 
				  SUBS_I, SUBSI_I, MULS_I, MUL_I, MULI_I, MULSI_I,
				  SKV_I, SKNV_I, LMUHA_I, SHLN_I, SHRN_I, SHLNI_I, SHRNI_I);

-- 	Instruction Unit

	constant	 SAME_I		: Cpu_imux     := "000";
	constant	 NEXT_I		: Cpu_imux     := "001";
	constant	 EXT_I		: Cpu_imux     := "010";
	constant	 EXTS_I		: Cpu_imux     := "011";
	constant	 INTSN_I	: Cpu_imux     := "100";
	constant	 INTSS_I	: Cpu_imux     := "101";
	constant	 INTSE_I	: Cpu_imux     := "110";
	constant	 STACK_I	: Cpu_imux     := "111";

	constant	 INT_ADDR	: Cpu_iaddr    := (0 => '0', 1 => '0', 2 => '0', others => '1');

-- 	Over Addressing Unit

	constant	 IND_ADD	: Cpu_ia       := "000";   	-- Indirect addressing
	constant	 IND_REG 	: Cpu_ia       := "001"; 	-- Indirect register
	constant	 IND_INC 	: Cpu_ia       := "010"; 	-- Indirect register increment
	constant	 ISTR_PAGE	: Cpu_ia       := "011"; 	-- Instruction memory extension
	constant	 DATA_PAGE	: Cpu_ia       := "100"; 	-- Data memory extension
	constant	 DATA_EXP	: Cpu_ia       := "101"; 	-- Data register expansion

-- 	Reset states

	constant	 RESET_ALL	: Cpu_nreset   := "00";   	-- Reset all
	constant	 UNRESET_IU : Cpu_nreset   := "01"; 	-- Unreset IU
	constant	 UNRESET_CU : Cpu_nreset   := "10"; 	-- Unreset CU
	constant	 UNRESET_DU : Cpu_nreset   := "11"; 	-- Unreset DU
	constant	 UNRESET_ALL: Cpu_nreset   := "11"; 	-- Unreset all

end CPUC_UTILS;

package body CPUC_UTILS is

end CPUC_UTILS;

