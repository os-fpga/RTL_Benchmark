--==========================> Gator uProccessor <===========================--
-- ADDRESS_ALU.VHD	
-- Engineer:	Kevin Phillipson
-- Date:		02/09/2007									Revision:3.02.07
-- Description: 
--
--==========================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity address_alu is

--============================> Port Map <==================================--

port
(
	----------------------------------------> Inputs
	--
	addr_alu_op	:	in	std_logic_vector( 3 downto  0);

	addr_rd_db	:	in	std_logic_vector(15 downto  0);
	--
	---------------------------------------->


	----------------------------------------> Outputs
	--
	addr_wr_db	:	out	std_logic_vector(15 downto  0);

	mem_addr	:	out	std_logic_vector(15 downto  0)
	--
	----------------------------------------< 

);

--==========================================================================--

end address_alu;

architecture behavior of address_alu is 

--==============================> Signals <=================================--


----------------------------------------> Operation Select Constants
--
constant	PRE_INC		:	std_logic_vector( 3 downto  0)	:= "0000";
constant	PRE_INC2	:	std_logic_vector( 3 downto  0)	:= "0001";
constant	PRE_DEC		:	std_logic_vector( 3 downto  0)	:= "0010";
constant	PRE_DEC2	:	std_logic_vector( 3 downto  0)	:= "0011";
constant	POST_INC	:	std_logic_vector( 3 downto  0)	:= "0100";
constant	POST_INC2	:	std_logic_vector( 3 downto  0)	:= "0101";
constant	POST_DEC	:	std_logic_vector( 3 downto  0)	:= "0110";
constant	POST_DEC2	:	std_logic_vector( 3 downto  0)	:= "0111";
constant	PASS		:	std_logic_vector( 3 downto  0)	:= "1000";
--
----------------------------------------<

constant	POS1		:	std_logic_vector(15 downto  0)	:= x"0001";
constant	POS2		:	std_logic_vector(15 downto  0)	:= x"0002";
constant	NEG1		:	std_logic_vector(15 downto  0)	:= x"FFFF";
constant	NEG2		:	std_logic_vector(15 downto  0)	:= x"FFFE";
constant	ZERO		:	std_logic_vector(15 downto  0)	:= x"0000";

----------------------------------------> Internal ALU Signals
--
signal		alu_q		:	std_logic_vector(15 downto  0);
signal		alu_b		:	std_logic_vector(15 downto  0);
--
----------------------------------------<

--==========================================================================--

begin

--=========================> ALU Architecture <=============================--

with addr_alu_op select
alu_b		<=
			POS1		when	PRE_INC,
			POS2		when	PRE_INC2,
			NEG1		when	PRE_DEC,
			NEG2		when	PRE_DEC2,
			POS1		when	POST_INC,
			POS2		when	POST_INC2,
			NEG1		when	POST_DEC,
			NEG2		when	POST_DEC2,
			ZERO		when	others;--PASS
			
alu_q		<=	addr_rd_db + alu_b;

addr_wr_db	<=	alu_q;

with addr_alu_op select
mem_addr	<=
			alu_q		when	PRE_INC,
			alu_q		when	PRE_INC2,
			alu_q		when	PRE_DEC,
			alu_q		when	PRE_DEC2,
			addr_rd_db	when	POST_INC,
			addr_rd_db	when	POST_INC2,
			addr_rd_db	when	POST_DEC,
			addr_rd_db	when	POST_DEC2,
			alu_q		when	others;--PASS

--==========================================================================--
end behavior;