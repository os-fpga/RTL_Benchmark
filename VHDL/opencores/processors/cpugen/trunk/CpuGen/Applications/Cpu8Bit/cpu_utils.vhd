--
--	CPU_UTILS
--	rel. 2.0
-- 	by gferrante@opencores.org
--

library ieee;
use ieee.std_logic_1164.all;

package CPU_UTILS is


-- CONFIGURATION SETTING

	constant	 IPAGE_LEN 	: integer := 0;
	constant	 DPAGE_LEN 	: integer := 0;
	constant	 DATA_LEN 	: integer := 8;
	constant	 ISTR_LEN 	: integer := 14;
	constant	 STACK_SIZE : integer := 8;
	constant	 MBUS_LEN 	: integer := 8; -- MIN(DATA_LEN,(ISTR_LEN - CODE_LEN))
	constant	 DIN_LEN 	: integer := 8; -- DIN_LEN >= DATA_LEN
	constant	 DOUT_LEN 	: integer := 8; -- DOUT_LEN >= DATA_LEN
	constant	 CODE_LEN 	: integer := 4; 	-- CODE_LEN >= 4 and CODE_LEN <= ISTR_LEN 
	constant	 ICODE_LEN 	: integer := 4; 	-- ICODE <= BUS_LEN
	constant	 CCLASS_LEN : integer := 3; 	-- CCLASS_LEN >= 3 and CCLASS_LEN <= ISTR_LEN  
	constant	 DCLASS_LEN : integer := 4; 	-- DCLASS_LEN >= 3 and DCLASS_LEN <= ISTR_LEN  
	constant	 ACC_NUM	: integer := 1;		-- ACC_NUM >= 1
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
	type 	Cpu_abus     is array	((ACC_NUM - 1) downto 0) of Cpu_acc;
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

	constant	 M_LK		: Cpu_code     := "0000";
	constant	 M_J		: Cpu_code     := "1000";
	constant	 M_JS		: Cpu_code     := "1001";
	constant	 M_S		: Cpu_code     := "0001";

	constant	 M_LK_NOP	: Cpu_icode    := "0000";
	constant	 M_LK_ROL	: Cpu_icode    := "0001";
	constant	 M_LK_ROR	: Cpu_icode    := "0010";
	constant	 M_LK_SHL	: Cpu_icode    := "0011";
	constant	 M_LK_SHR	: Cpu_icode    := "0100";
	constant	 M_LK_NOT	: Cpu_icode    := "0101";
	constant	 M_LK_CLA	: Cpu_icode    := "0110";
	constant	 M_LK_SKZ	: Cpu_icode    := "1000";
	constant	 M_LK_SKC	: Cpu_icode    := "1001";
	constant	 M_LK_SKNZ	: Cpu_icode    := "1010";
	constant	 M_LK_SKNC	: Cpu_icode    := "1011";
	constant	 M_LK_RTS	: Cpu_icode    := "1100";
	constant	 M_LK_RTI	: Cpu_icode    := "1101";

	constant	 TC_OTH		: Cpu_cclass   := "000";
	constant	 TC_LDA		: Cpu_cclass   := "001";
	constant	 TC_DAT		: Cpu_cclass   := "010";
	constant	 TC_STA		: Cpu_cclass   := "011";
	constant	 TC_RTI		: Cpu_cclass   := "100";
	constant	 TC_RTS		: Cpu_cclass   := "101";
	constant	 TC_JMP		: Cpu_cclass   := "110";
	constant	 TC_JMS		: Cpu_cclass   := "111";

	constant	 TD_NOP		: Cpu_dclass   := "0000";
	constant	 TD_ROL		: Cpu_dclass   := "0001";
	constant	 TD_ROR		: Cpu_dclass   := "0010";
	constant	 TD_SHL		: Cpu_dclass   := "0011";
	constant	 TD_SHR		: Cpu_dclass   := "0100";
	constant	 TD_CLA		: Cpu_dclass   := "0110";
	constant	 TD_NOT		: Cpu_dclass   := "0111";

	constant	 TD_SKZ		: Cpu_dclass   := "1000";
	constant	 TD_SKC		: Cpu_dclass   := "1001";
	constant	 TD_SKNZ	: Cpu_dclass   := "1010";
	constant	 TD_SKNC	: Cpu_dclass   := "1100";

	constant	 TD_LDA		: Cpu_dclass   := "0010";
	constant	 TD_XOR		: Cpu_dclass   := "0011";
	constant	 TD_ADD		: Cpu_dclass   := "0100";
	constant	 TD_AND		: Cpu_dclass   := "0101";
	constant	 TD_SUB		: Cpu_dclass   := "0110";
	constant	 TD_OR		: Cpu_dclass   := "0111";

-- DEBUG

	type		 OP is (NOP_I, ROL_I, ROR_I, SHL_I, SHR_I, NOT_I, CLA_I,
				  SKZ_I, SKC_I, SKNZ_I, SKNC_I, RTS_I, RTI_I,
				  JMP_I, JMS_I, STA_I, LDA_I, XOR_I, ADD_I,
				  AND_I, SUB_I, OR_I, LDAI_I, XORI_I, ADDI_I,
				  ANDI_I, SUBI_I, ORI_I);

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

end CPU_UTILS;

package body CPU_UTILS is

end CPU_UTILS;

