--==========================> Gator uProccessor <===========================--
-- DATA_ALU.VHD	
-- Engineer:	Kevin Phillipson
-- Date:		02/09/2007									Revision:10.19.07
-- Description: 
--
--==========================================================================--

library ieee;
use ieee.std_logic_1164.all;

entity data_alu is

--============================> Port Map <==================================--

port
(
	----------------------------------------> Inputs
	--
	alu_op		:	in	std_logic_vector( 2 downto  0);
	alu_mode	:	in	std_logic;

	alu_cond	:	in	std_logic;

	alu_a		:	in	std_logic_vector(15 downto  0);
	alu_b		:	in	std_logic_vector(15 downto  0);
	--
	---------------------------------------->


	----------------------------------------> Outputs
	--
	alu_q		:	out	std_logic_vector(15 downto  0);

	alu_flags	:	out	std_logic_vector( 5 downto  0)
	--
	----------------------------------------< 

);

--==========================================================================--

end data_alu;

architecture behavior of data_alu is 

--==============================> Signals <=================================--


----------------------------------------> Operation Select Constants
--
constant	A_PLUS_B			:	std_logic_vector(2 downto 0)	:= "000";
constant	A_PLUS_NOT_B		:	std_logic_vector(2 downto 0)	:= "001";
constant	A_AND_B				:	std_logic_vector(2 downto 0)	:= "010";
constant	A_AND_NOT_B			:	std_logic_vector(2 downto 0)	:= "011";
constant	A_OR_B				:	std_logic_vector(2 downto 0)	:= "100";
constant	A_XOR_B				:	std_logic_vector(2 downto 0)	:= "101";
constant	LSHIFT_A			:	std_logic_vector(2 downto 0)	:= "110";
constant	RSHIFT_A			:	std_logic_vector(2 downto 0)	:= "111";
--
----------------------------------------<

----------------------------------------> Mode Select Constants
--
constant	MODE_8				:	std_logic	:=	'0';
constant	MODE_16				:	std_logic	:=	'1';
--
----------------------------------------<

----------------------------------------> Internal ALU Signals
--
signal		sig_a_plus_b		:	std_logic_vector(15 downto  0);
signal		sig_a_plus_not_b	:	std_logic_vector(15 downto  0);
signal		sig_a_and_b			:	std_logic_vector(15 downto  0);
signal		sig_a_and_not_b		:	std_logic_vector(15 downto  0);
signal		sig_a_or_b			:	std_logic_vector(15 downto  0);
signal		sig_a_xor_b			:	std_logic_vector(15 downto  0);
signal		sig_lshift_a		:	std_logic_vector(15 downto  0);
signal		sig_rshift_a		:	std_logic_vector(15 downto  0);

signal		sig_cin				:	std_logic_vector(15 downto  0);
signal		sig_cout			:	std_logic_vector(15 downto  0);
signal		sig_vout			:	std_logic_vector(15 downto  0);

signal		sig_a				:	std_logic_vector(15 downto  0);
signal		sig_b				:	std_logic_vector(15 downto  0);
signal		sig_q				:	std_logic_vector(15 downto  0);

signal		sig_cond			:	std_logic;

signal		sig_c8				:	std_logic;	-- 8bit Carry
signal		sig_v8				:	std_logic;	-- 8bit Overflow
signal		sig_z8				:	std_logic;	-- 8bit Zero
signal		sig_n8				:	std_logic;	-- 8bit Negative
signal		sig_h8				:	std_logic;	-- 8bit Half Carry
signal		sig_a8				:	std_logic;	-- 8bit A Input Sign Bit

signal		sig_c16				:	std_logic;	-- 16bit Carry
signal		sig_v16				:	std_logic;	-- 16bit Overflow
signal		sig_z16				:	std_logic;	-- 16bit Zero
signal		sig_n16				:	std_logic;	-- 16bit Negative
signal		sig_h16				:	std_logic;	-- 16bit Half Carry
signal		sig_a16				:	std_logic;	-- 16bit A Input Sign Bit
--
----------------------------------------<

--==========================================================================--

begin

--=========================> ALU Architecture <=============================--

----------------------------------------> Input Signals
--
sig_a	<=	alu_a;

with alu_op select
sig_b	<=	not alu_b	when A_PLUS_NOT_B,
			not alu_b	when A_AND_NOT_B,
			alu_b		when others;

sig_cond	<=	not alu_cond when (alu_op = A_PLUS_NOT_B) else alu_cond;
--
----------------------------------------<

----------------------------------------> Boolean Logic
--
sig_a_and_b		<=	sig_a	and	sig_b;
sig_a_or_b		<=	sig_a	or	sig_b;
sig_a_xor_b		<=	sig_a	xor	sig_b;

sig_a_and_not_b	<=	sig_a_and_b;
--
----------------------------------------<

----------------------------------------> Full Look Ahead Carry Adder
--
sig_cin					<=	sig_cout(14 downto  0)	&	sig_cond;
sig_cout				<=	sig_a_and_b				or	(sig_a_or_b	and	sig_cin);
sig_a_plus_b 			<=	sig_a_xor_b				xor	sig_cin;
sig_vout(15 downto 1)	<=	sig_cout(15 downto 1)	xor	sig_cout(14 downto 0);

sig_a_plus_not_b		<=	sig_a_plus_b;
--
----------------------------------------<

----------------------------------------> Shifters
--
sig_lshift_a				<=	sig_a(14 downto  0)	&	sig_cond;

sig_rshift_a(15	downto  8)	<=	sig_cond			&	sig_a(15 downto  9);

with alu_mode select
sig_rshift_a( 7 downto  0)	<=	sig_cond			&	sig_a( 7 downto  1)	when MODE_8,
								sig_a( 8)			&	sig_a( 7 downto  1)	when others;
--
----------------------------------------<

----------------------------------------> ALU Operation Output
--
with alu_op select
sig_q	<=	sig_a_plus_b		when	A_PLUS_B,
			sig_a_plus_not_b	when	A_PLUS_NOT_B,
			sig_a_and_b			when	A_AND_B,
			sig_a_and_not_b		when	A_AND_NOT_B,
			sig_a_or_b			when	A_OR_B,
			sig_a_xor_b			when	A_XOR_B,
			sig_lshift_a		when	LSHIFT_A,
			sig_rshift_a		when	others;

alu_q	<=	sig_q;
--
----------------------------------------<

----------------------------------------> 8bit Flags
--
with alu_op select
sig_c8	<=	sig_cout( 7)		when	A_PLUS_B,
			not sig_cout( 7)	when	A_PLUS_NOT_B,
			sig_a( 7)			when	LSHIFT_A,
			sig_a( 0)			when	RSHIFT_A,
			'0'					when	others;

with alu_op select
sig_v8	<=	sig_vout( 7)		when	A_PLUS_B,
			sig_vout( 7)		when	A_PLUS_NOT_B,
			'0'					when	others;

sig_z8	<=	'1' when (sig_q( 7 downto  0) = x"00") else '0';

sig_n8	<=	sig_q( 7);

sig_h8	<=	sig_cout( 3);

sig_a8	<=	sig_a( 7);
--
----------------------------------------<

----------------------------------------> 16bit Flags
--
with alu_op select
sig_c16	<=	sig_cout(15)		when	A_PLUS_B,
			not sig_cout(15)	when	A_PLUS_NOT_B,
			sig_a(15)			when	LSHIFT_A,
			sig_a( 0)			when	RSHIFT_A,
			'0'					when	others;

with alu_op select
sig_v16	<=	sig_vout(15)		when	A_PLUS_B,
			sig_vout(15)		when	A_PLUS_NOT_B,
			'0'					when	others;

sig_z16	<=	'1' when (sig_q = x"0000") else '0';

sig_n16	<=	sig_q(15);

sig_h16	<=	sig_cout( 3); -- Not used in 16bit instructions so keep the same to minimize logic

sig_a16	<=	sig_a(15);
--
----------------------------------------<

----------------------------------------> ALU Flag Output
--
alu_flags( 0)	<=	sig_c8 when (alu_mode = MODE_8) else sig_c16;
alu_flags( 1)	<=	sig_v8 when (alu_mode = MODE_8) else sig_v16;
alu_flags( 2)	<=	sig_z8 when (alu_mode = MODE_8) else sig_z16;
alu_flags( 3)	<=	sig_n8 when (alu_mode = MODE_8) else sig_n16;
alu_flags( 4)	<=	sig_h8 when (alu_mode = MODE_8) else sig_h16;
alu_flags( 5)	<=	sig_a8 when (alu_mode = MODE_8) else sig_a16;
--
----------------------------------------<

--==========================================================================--
end behavior;