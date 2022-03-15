--==========================> Gator uProccessor <===========================--
-- MUL.VHD	
-- Engineer:	Kevin Phillipson
-- Date:		11/27/2007									Revision:11.27.07
-- Description: 
--
--==========================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity mul is

--============================> Port Map <==================================--

port
(
	----------------------------------------> Inputs
	--
	clk			:	in	std_logic;
	
	mul_a		:	in	std_logic_vector( 7 downto  0);
	mul_b		:	in	std_logic_vector( 7 downto  0);
	--
	---------------------------------------->

	----------------------------------------> Outputs
	--
	c_flag		:	out	std_logic;
	
	product		:	out	std_logic_vector(15 downto  0)
	--
	----------------------------------------< 

);

--==========================================================================--

end mul;

architecture behavior of mul is 

--==============================> Signals <=================================--


---------------------------------------->
--
signal		a_int			:	unsigned( 7 downto 0);
signal		b_int			:	unsigned( 7 downto 0);
signal		q_int			:	unsigned(15 downto 0);

signal		product_nxt		:	std_logic_vector(15 downto 0);
signal		product_reg		:	std_logic_vector(15 downto 0);

--
----------------------------------------<

--==========================================================================--

begin

--====================> Multiplication Architecture <=======================--

----------------------------------------> 8bit by 8bit Unsigned Multiply
--
a_int		<= unsigned(mul_a);
b_int		<= unsigned(mul_b);

q_int		<= a_int * b_int;

product_nxt	<= std_logic_vector(q_int);
--
----------------------------------------<

----------------------------------------> Output Registers
--
process
(
	clk,
	product_nxt
)
begin

	if (clk'event  and clk = '1') then

		product_reg	<=	product_nxt;

	end if;
	
end process;
--
----------------------------------------<

----------------------------------------> Outputs
--
c_flag	<=	product_reg(7);
product	<=	product_reg;
--
----------------------------------------<

--==========================================================================--
end behavior;

