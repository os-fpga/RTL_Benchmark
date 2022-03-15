--==========================> Gator uProccessor <===========================--
-- MICROSQUENCER.VHD									
-- Engineer:	Kevin Phillipson
-- Date:		03/03/2007									Revision:10.16.07
-- Description: 
--
--==========================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity microsquencer is port
(
	sys_rst			: 	in		std_logic;
	clk				: 	in		std_logic;
	sync			: 	in		std_logic;
	
	condition		:	in		std_logic;
	true_false		:	in		std_logic;

	micro_op		:	in		std_logic_vector( 3 downto  0);

	branch_vector	:	in		std_logic_vector( 7 downto  0);

	map_a_vector	:	in		std_logic_vector( 7 downto  0);
	map_b_vector	:	in		std_logic_vector( 7 downto  0);
	map_c_vector	:	in		std_logic_vector( 7 downto  0);
	map_d_vector	:	in		std_logic_vector( 7 downto  0);
	map_e_vector	:	in		std_logic_vector( 7 downto  0);
	map_f_vector	:	in		std_logic_vector( 7 downto  0);
	map_g_vector	:	in		std_logic_vector( 7 downto  0);
	map_h_vector	:	in		std_logic_vector( 7 downto  0);

	micro_prog_addr	:	out		std_logic_vector( 7 downto  0)
);
end microsquencer;

architecture behavior of microsquencer is

-----------------------------------------------------------------------> Microprogram State Defines

constant 	reset_vector	:	std_logic_vector( 7 downto  0)	:=	(others => '0');
signal		state_reg		:	std_logic_vector( 7 downto  0);
signal		state_nxt		:	std_logic_vector( 7 downto  0);
signal		state_inc		:	std_logic_vector( 7 downto  0);
signal		return_reg		:	std_logic_vector( 7 downto  0);
signal		return_nxt		:	std_logic_vector( 7 downto  0);

-----------------------------------------------------------------------<

constant 	CONTINUE_OP		:	std_logic_vector( 3 downto  0)	:=	x"0";
constant 	JUMP_OP			:	std_logic_vector( 3 downto  0)	:=	x"1";
constant 	CALL_OP			:	std_logic_vector( 3 downto  0)	:=	x"2";
constant 	RETURN_OP		:	std_logic_vector( 3 downto  0)	:=	x"3";
constant 	JUMP_MAP_A_OP	:	std_logic_vector( 3 downto  0)	:=	x"4";
constant 	JUMP_MAP_B_OP	:	std_logic_vector( 3 downto  0)	:=	x"5";
constant 	JUMP_MAP_C_OP	:	std_logic_vector( 3 downto  0)	:=	x"6";
constant 	JUMP_MAP_D_OP	:	std_logic_vector( 3 downto  0)	:=	x"7";
constant 	JUMP_MAP_E_OP	:	std_logic_vector( 3 downto  0)	:=	x"8";
constant 	JUMP_MAP_F_OP	:	std_logic_vector( 3 downto  0)	:=	x"9";
constant 	JUMP_MAP_G_OP	:	std_logic_vector( 3 downto  0)	:=	x"A";
constant 	JUMP_MAP_H_OP	:	std_logic_vector( 3 downto  0)	:=	x"B";

begin

-----------------------------------------------------------------------> Next State Logic
state_inc	<=	state_reg + '1';

process
(
	micro_op,
	condition,
	true_false,
	state_inc,
	branch_vector,
	map_a_vector,
	map_b_vector,
	map_c_vector,
	map_d_vector,
	map_e_vector,
	map_f_vector,
	map_g_vector,
	map_h_vector,
	state_reg,
	return_reg
)
begin

	return_nxt	<=	return_reg;
	state_nxt	<=	state_reg;

	if (condition = true_false)	then

		case micro_op is

			when CONTINUE_OP =>
				state_nxt	<=	state_inc;

			when JUMP_OP =>
				state_nxt	<=	branch_vector;

			when CALL_OP =>
				state_nxt	<=	branch_vector;
				return_nxt	<=	state_inc;

			when RETURN_OP =>
				state_nxt	<=	return_reg;

			when JUMP_MAP_A_OP =>
				state_nxt	<=	map_a_vector;

			when JUMP_MAP_B_OP =>
				state_nxt	<=	map_b_vector;

			when JUMP_MAP_C_OP =>
				state_nxt	<=	map_c_vector;

			when JUMP_MAP_D_OP =>
				state_nxt	<=	map_d_vector;

			when JUMP_MAP_E_OP =>
				state_nxt	<=	map_e_vector;

			when JUMP_MAP_F_OP =>
				state_nxt	<=	map_f_vector;

			when JUMP_MAP_G_OP =>
				state_nxt	<=	map_g_vector;

			when JUMP_MAP_H_OP =>
				state_nxt	<=	map_h_vector;

			when others =>
				state_nxt	<=	reset_vector;
				

		end case;

	else

		state_nxt	<=	state_inc;
		
	end if;

end process;
-----------------------------------------------------------------------<


-----------------------------------------------------------------------> Microprogram State Register
process
(
	sys_rst,
	clk,
	sync,
	state_nxt,
	return_nxt
)
begin
	if (clk'event and clk = '1') then

		if (sys_rst = '1') then
		
			state_reg	<=	reset_vector;

		elsif (sync = '1') then

			state_reg	<=	state_nxt;
			return_reg	<=	return_nxt;
				
		end if;

	end if;

end process;

micro_prog_addr	<=	state_nxt when (sync = '1') else state_reg;
-----------------------------------------------------------------------<

end behavior;