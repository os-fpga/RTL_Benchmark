--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
package sys_primegen_package is

-- 1 bit microinstruction fields
constant i_nop, 	m_nop, 	n_nop, 	ci_zero, muldiv_nop, 	uart_nop: std_logic		:= '0';
constant i_load, 	m_load, 	n_load, 	ci_one, 	muldiv_start, 	uart_send: std_logic		:= '1';

-- 2 bit microinstruction fields
constant mode_umul: std_logic_vector(1 downto 0) 		:= "00";
constant mode_smul: std_logic_vector(1 downto 0) 		:= "01";
constant mode_udiv: std_logic_vector(1 downto 0) 		:= "10";
constant mode_sdiv: std_logic_vector(1 downto 0) 		:= "11";

-- 3 bit microinstruction fields
constant muxa_zero,	muxb_const, alu_adc,		if_next_else_next		: std_logic_vector(2 downto 0) := "000";
constant muxa_m, 		muxb_m,		alu_sbc,		if_next_else_repeat	: std_logic_vector(2 downto 0) := "001";
constant muxa_arg0,	muxb_two,					if_goto_else_next		: std_logic_vector(2 downto 0) := "010";
constant muxa_n,		muxb_n,						if_gosub_else_next	: std_logic_vector(2 downto 0) := "011";
constant muxa_prod,	muxb_four,	alu_asc0,	if_return_else_next	: std_logic_vector(2 downto 0) := "100";
constant muxa_ibcd,	muxb_i,		alu_asc1,	if_goto_else_start	: std_logic_vector(2 downto 0) := "101";
constant muxa_nbcdh,	muxb_modulo,alu_asc2,	if_gosub_else_repeat	: std_logic_vector(2 downto 0) := "110";
constant muxa_nbcdl,	muxb_arg1,	alu_asc3									: std_logic_vector(2 downto 0) := "111";

-- 4 bit microinstruction fields
constant cond_buttonstart		: std_logic_vector(3 downto 0) := "0000";
constant cond_uartbusy	 		: std_logic_vector(3 downto 0) := "0001";
constant cond_alugreaterthan	: std_logic_vector(3 downto 0) := "0010";
constant cond_alulessthan		: std_logic_vector(3 downto 0) := "0011";
constant cond_muldivready		: std_logic_vector(3 downto 0) := "0100";
constant cond_aluzero			: std_logic_vector(3 downto 0) := "0101";
constant cond_muldiverror		: std_logic_vector(3 downto 0) := "0110";
constant cond_false				: std_logic_vector(3 downto 0) := "0111";
constant cond_ibcdready			: std_logic_vector(3 downto 0) := "1000";
constant cond_uartready		 	: std_logic_vector(3 downto 0) := "1001";
constant cond_alugreaterorequal: std_logic_vector(3 downto 0):= "1010";
constant cond_nbcdready			: std_logic_vector(3 downto 0) := "1011";
constant cond_muldivnotready	: std_logic_vector(3 downto 0) := "1100";
constant cond_alunotzero		: std_logic_vector(3 downto 0) := "1101";
constant cond_muldivok			: std_logic_vector(3 downto 0) := "1110";
constant cond_true				: std_logic_vector(3 downto 0) := "1111";

end sys_primegen_package;
