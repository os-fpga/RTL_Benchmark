--==========================> Gator uProccessor <===========================--
-- hprio_reg.vhd	
-- Engineer:	Peter Flores
-- Date:		10/29/2007									Revision:10.29.07
--
-- Description: HPRIO - highest priority I-bit interrupt and miscellaneous
-- register. The HPRIO may be read at any time, but may be written only under
-- certain circumstances. PSEL3:0 can only be written when I-bit in CCR is 1.
--
--==========================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity hprio_reg is

--============================> Port Map <==================================--

port
(
	----------------------------------------> Inputs
	--
	sys_rst			:	in	std_logic;
	clk				:	in	std_logic;

	ibit			:	in	std_logic;

	hprio_wr_en		:	in	std_logic;
	
	wr_data_bus		:	in	std_logic_vector( 7 downto  0);
	--
	----------------------------------------<

	----------------------------------------> Outputs
	--
	psel			:	out	std_logic_vector( 3 downto 0 );
	
	hprio_rd_db		:	out	std_logic_vector( 7 downto 0 )
	--
	----------------------------------------< 
);
end hprio_reg;

--==========================================================================--


architecture behavior of hprio_reg is

--==============================> Signals <=================================--

signal		hprio		:	std_logic_vector( 7 downto  0);

--==========================================================================--

begin

--============================> Reg Architecture <==========================--

----------------------------------------> HPRIO Register
--
process
(
	sys_rst,
	clk,
	hprio_wr_en
)
begin
	if (clk'event and clk = '1') then
		if (sys_rst = '1') then
			hprio <= "00000101"; -- Start in Normal Single-chip mode on reset
		elsif (hprio_wr_en = '1') then
			hprio( 7 downto 4 ) <= wr_data_bus( 7 downto 4 );
			if (ibit = '1') then
				hprio( 3 downto 0 ) <= wr_data_bus( 3 downto 0 );
			end if;
		end if;
	end if;
end process;
--
----------------------------------------<

hprio_rd_db		<= hprio;
psel 			<= hprio( 3 downto 0 );

--==========================================================================--

end behavior;