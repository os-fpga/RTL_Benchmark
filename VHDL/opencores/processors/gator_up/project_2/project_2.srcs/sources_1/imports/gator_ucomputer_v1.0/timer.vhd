--==========================> Gator uProccessor <===========================--
-- TIMER.VHD	
-- Engineer:	Kevin Phillipson
-- Revision:	01/24/2008
--				
--==========================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity timer is		-- the shit

--============================> Port Map <==================================--

port
(
	----------------------------------------> Inputs
	--
	sys_rst			: 	in		std_logic;
	clk				: 	in		std_logic;

--	wr_data_bus		:	in		std_logic_vector( 7 downto  0);

	tcnt_hi_rd_en	:	in		std_logic;
	--
	---------------------------------------->

	----------------------------------------> Outputs
	--
	tcnt_hi_rd_db	:	out		std_logic_vector( 7 downto  0);
	tcnt_lo_rd_db	:	out		std_logic_vector( 7 downto  0)
	--
	----------------------------------------< 
);

--==========================================================================--

end timer;

architecture behavior of timer is 

--==============================> Signals <=================================--

signal	tcnt_reg		:	std_logic_vector(15 downto  0);
signal	tcnt_lo_rd_reg	:	std_logic_vector( 7 downto  0);

--==========================================================================--

begin

--=========================> Timer Architecture <=============================--


----------------------------------------> TCNT Register
--
process
(
	sys_rst,
	clk
)
begin
	if (clk'event and clk = '1') then

		if (sys_rst = '1') then
		
			tcnt_reg	<= (others => '0');

		else

			tcnt_reg	<=	tcnt_reg + '1';
			
		end if;

	end if;

end process;
--
----------------------------------------<

----------------------------------------> TCNT LO Read Register
--
process
(
	clk,
	tcnt_hi_rd_en
)
begin
	if (clk'event and clk = '1') then

		if (tcnt_hi_rd_en = '1') then

			tcnt_lo_rd_reg	<=	tcnt_reg(7 downto 0);
			
		end if;

	end if;

end process;
--
----------------------------------------<

----------------------------------------> Outputs
--
tcnt_hi_rd_db	<=	tcnt_reg(15 downto 8);
tcnt_lo_rd_db	<=	tcnt_lo_rd_reg;
--
----------------------------------------<


--==========================================================================--

end behavior;