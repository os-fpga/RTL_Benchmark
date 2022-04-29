----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2018 05:14:44 PM
-- Design Name: 
-- Module Name: rom32x32 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use work.sys_primegen_package.all;

entity rom32x32 is
    Port ( nCS : in STD_LOGIC;
           a : in STD_LOGIC_VECTOR (4 downto 0);
           d : out STD_LOGIC_VECTOR (31 downto 0));
end rom32x32;

architecture Behavioral of rom32x32 is

--signal a_int: std_logic_vector(7 downto 0);
--signal d_int: std_logic_vector(31 downto 0);
type rom is array(0 to 31) of std_logic_vector(31 downto 0);

constant ucode: rom := (
        0 => -- Start: PRINT "*"
            X"2A" & muxa_zero & muxb_const 	& alu_adc 	& ci_zero 	& i_nop 		& m_nop 	& n_nop 		& mode_umul & muldiv_nop 	& uart_send & if_next_else_repeat 	& cond_uartready,

        1 => -- WaitForStart: i = 0; IF (buttonstart != 1) THEN GOTO WaitForStart
            X"00" & muxa_m 	& muxb_m 		& alu_sbc 	& ci_one 	& i_load 	& m_nop	& n_nop	 	& mode_umul & muldiv_nop 	& uart_nop 	& if_next_else_repeat 	& cond_buttonstart,

        2 => -- n = Arg0;
            X"00" & muxa_arg0 & muxb_const 	& alu_adc 	& ci_zero 	& i_nop 		& m_nop  & n_load 	& mode_umul & muldiv_nop 	& uart_nop 	& if_next_else_next	 	& cond_true,

        3 => -- LoopN: IF (n > Arg1) THEN GOTO WaitForStart
            X"01" & muxa_n 	& muxb_arg1 	& alu_sbc 	& ci_one 	& i_nop 		& m_nop 	& n_nop 		& mode_umul & muldiv_nop 	& uart_nop 	& if_goto_else_next	 	& cond_alugreaterthan,
  
        4 => -- IF (n < 2) THEN GOTO NextN 
            X"10" & muxa_n 	& muxb_two	 	& alu_sbc 	& ci_one 	& i_nop 		& m_nop 	& n_nop 		& mode_umul & muldiv_nop 	& uart_nop 	& if_goto_else_next	 	& cond_alulessthan,

        5 => -- IF (n < 4) THEN GOTO FoundPrime
            X"0F" & muxa_n 	& muxb_four	 	& alu_sbc 	& ci_one 	& i_nop 		& m_nop 	& n_nop 		& mode_umul & muldiv_nop 	& uart_nop 	& if_goto_else_next	 	& cond_alulessthan,

        6 => -- m = 1;
            X"01" & muxa_zero & muxb_const 	& alu_adc 	& ci_zero 	& i_nop 		& m_load & n_nop 	& mode_umul & muldiv_nop 	& uart_nop 	& if_next_else_next	 	& cond_true,

        7 => -- NextM: m = m + 1;
            X"00" & muxa_zero & muxb_m		 	& alu_adc 	& ci_one 	& i_nop 		& m_load & n_nop 	& mode_umul & muldiv_nop 	& uart_nop 	& if_next_else_next	 	& cond_true,

        8 => -- kick off division n / m, note that n must be presented as dividend, divisor is hard coded to m. Keep the start signal on until unit responds with not ready
            X"00" & muxa_n		& muxb_const	& alu_adc 	& ci_zero 	& i_nop 		& m_nop  & n_nop  	& mode_udiv & muldiv_start & uart_nop 	& if_next_else_repeat	& cond_muldivnotready,

        9 => -- wait for division to finish
            X"00" & muxa_n		& muxb_const	& alu_adc 	& ci_zero 	& i_nop 		& m_nop  & n_nop  	& mode_udiv & muldiv_nop	& uart_nop 	& if_next_else_repeat	& cond_muldivready,

		  10 => -- IF (n // m = 0) THEN GOTO NextN 
            X"10" & muxa_zero & muxb_modulo	& alu_sbc 	& ci_one 	& i_nop 		& m_nop 	& n_nop 		& mode_udiv & muldiv_nop 	& uart_nop 	& if_goto_else_next	 	& cond_aluzero,

        11 => -- kick off multiplication m * m, note that m must be presented as factor0, factor1 is hard coded to m. Keep the start signal on until unit responds with not ready
            X"00" & muxa_m		& muxb_const	& alu_adc 	& ci_zero 	& i_nop 		& m_nop  & n_nop  	& mode_umul & muldiv_start & uart_nop 	& if_next_else_repeat	& cond_muldivnotready,

        12 => -- wait for multiplication to finish
            X"00" & muxa_m		& muxb_const	& alu_adc 	& ci_zero 	& i_nop 		& m_nop  & n_nop  	& mode_umul & muldiv_nop	& uart_nop 	& if_next_else_repeat	& cond_muldivready,
				
		  13 => -- IF (m * m >= n) THEN GOTO FoundPrime 
            X"0F" & muxa_prod & muxb_n		 	& alu_sbc 	& ci_one 	& i_nop 		& m_nop 	& n_nop 		& mode_umul & muldiv_nop 	& uart_nop 	& if_goto_else_next	 	& cond_alugreaterorequal,
			
		  14 => -- GOTO NextM
            X"07" & muxa_zero & muxb_const 	& alu_adc 	& ci_zero 	& i_nop	 	& m_nop	& n_nop 		& mode_umul & muldiv_nop 	& uart_nop 	& if_goto_else_next	 	& cond_true,

		  15 => -- FoundPrime: GOSUB PrintIandN
            X"11" & muxa_zero & muxb_const 	& alu_adc 	& ci_zero 	& i_nop	 	& m_nop	& n_nop 		& mode_umul & muldiv_nop 	& uart_nop 	& if_gosub_else_repeat	& cond_ibcdready,

		  16 => -- NextN: n = n + 1; IF (n != 0) GOTO LoopN else GOTO Start
            X"03" & muxa_zero & muxb_n		 	& alu_adc 	& ci_one 	& i_nop 		& m_nop  & n_load 	& mode_umul & muldiv_nop 	& uart_nop 	& if_goto_else_start	 	& cond_alunotzero,

		  17 => -- PrintIandN: i = i + 1
            X"00" & muxa_zero & muxb_i		 	& alu_adc 	& ci_one 	& i_load 	& m_nop  & n_nop 		& mode_umul & muldiv_nop 	& uart_nop 	& if_next_else_next	 	& cond_true,

        18 => -- PRINT "<CR>"
            X"0D" & muxa_zero & muxb_const 	& alu_adc 	& ci_zero 	& i_nop 		& m_nop 	& n_nop 		& mode_umul & muldiv_nop 	& uart_send & if_next_else_repeat 	& cond_uartready,

        19 => -- PRINT ASC(BCD(i) >> 12 AND 0x000F)
            X"00" & muxa_ibcd & muxb_const   & alu_asc3  & ci_zero 	& i_nop 		& m_nop 	& n_nop 		& mode_umul & muldiv_nop 	& uart_send & if_next_else_repeat 	& cond_uartready,

        20 => -- PRINT ASC(BCD(i) >> 8 AND 0x000F)
            X"00" & muxa_ibcd & muxb_const   & alu_asc2  & ci_zero 	& i_nop 		& m_nop 	& n_nop 		& mode_umul & muldiv_nop 	& uart_send & if_next_else_repeat 	& cond_uartready,

        21 => -- PRINT ASC(BCD(i) >> 4 AND 0x000F)
            X"00" & muxa_ibcd & muxb_const   & alu_asc1  & ci_zero 	& i_nop 		& m_nop 	& n_nop 		& mode_umul & muldiv_nop 	& uart_send & if_next_else_repeat 	& cond_uartready,

        22 => -- PRINT ASC(BCD(i) >> 0 AND 0x000F)
            X"00" & muxa_ibcd & muxb_const   & alu_asc0  & ci_zero 	& i_nop 		& m_nop 	& n_nop 		& mode_umul & muldiv_nop 	& uart_send & if_next_else_repeat 	& cond_uartready,

        23 => -- PRINT " "
            X"20" & muxa_zero & muxb_const 	& alu_adc 	& ci_zero 	& i_nop 		& m_nop 	& n_nop 		& mode_umul & muldiv_nop 	& uart_send & if_next_else_repeat 	& cond_uartready,
		
		  24 => -- Wait for BCD(n) ready
            X"00" & muxa_zero & muxb_const 	& alu_adc 	& ci_zero 	& i_nop	 	& m_nop	& n_nop 		& mode_umul & muldiv_nop 	& uart_nop 	& if_next_else_repeat 	& cond_nbcdready,

        25 => -- PRINT ASC(BCD(n) >> 0 AND 0x000F)
            X"00" & muxa_nbcdh & muxb_const  & alu_asc0  & ci_zero 	& i_nop 		& m_nop 	& n_nop 		& mode_umul & muldiv_nop 	& uart_send & if_next_else_repeat 	& cond_uartready,

        26 => -- PRINT ASC(BCD(n) >> 12 AND 0x000F)
            X"00" & muxa_nbcdl & muxb_const  & alu_asc3  & ci_zero 	& i_nop 		& m_nop 	& n_nop 		& mode_umul & muldiv_nop 	& uart_send & if_next_else_repeat 	& cond_uartready,

        27 => -- PRINT ASC(BCD(n) >> 8 AND 0x000F)
            X"00" & muxa_nbcdl & muxb_const  & alu_asc2  & ci_zero 	& i_nop 		& m_nop 	& n_nop 		& mode_umul & muldiv_nop 	& uart_send & if_next_else_repeat 	& cond_uartready,

        28 => -- PRINT ASC(BCD(n) >> 4 AND 0x000F)
            X"00" & muxa_nbcdl & muxb_const  & alu_asc1  & ci_zero 	& i_nop 		& m_nop 	& n_nop 		& mode_umul & muldiv_nop 	& uart_send & if_next_else_repeat 	& cond_uartready,

        29 => -- PRINT ASC(BCD(n) >> 0 AND 0x000F)
            X"00" & muxa_nbcdl & muxb_const  & alu_asc0  & ci_zero 	& i_nop 		& m_nop 	& n_nop 		& mode_umul & muldiv_nop 	& uart_send & if_next_else_repeat 	& cond_uartready,

		  30 => -- RETURN
            X"00" & muxa_zero & muxb_const 	& alu_adc 	& ci_zero 	& i_nop	 	& m_nop	& n_nop 		& mode_umul & muldiv_nop 	& uart_nop 	& if_return_else_next	& cond_true,
		  ------------------------
        others => -- HALT
            X"00" & muxa_zero & muxb_const 	& alu_adc 	& ci_zero 	& i_nop	 	& m_nop	& n_nop 		& mode_umul & muldiv_nop 	& uart_nop 	& if_next_else_repeat 	& cond_false
    );

begin

	d <= ucode(to_integer(unsigned(a))) when (nCS = '0') else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";

end Behavioral;
