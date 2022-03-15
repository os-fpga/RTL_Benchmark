--
-- VHDL: EXTERNAL WORLD Behavioral
--	gferrante@opencores.org
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;

entity WORLD is
	port (
		clk:		in  std_logic;
		cpu_int: 	out std_logic;
		nreset: 	out std_logic
		);
end WORLD;

architecture behavioral of WORLD is
signal cont		:std_logic_vector(15 downto 0) := (others => '0');
signal nreset_x	:std_logic;		

begin
	process(clk)
	  begin
		if (rising_edge(clk)) then
			cont 	<= cont + 1;
		end if;

	end process;

	process(cont)
	   
         begin
		if (cont < "0000000000000010") then

			nreset_x		<=	'0';
			cpu_int		<=	'0';
		
		elsif (cont(3 downto 0) = "0000") then

			nreset_x		<=	'1';
			cpu_int		<=	'0';

		elsif (cont(12) = '1') then

			nreset_x		<=	'1';
			cpu_int		<=	'0';

		elsif (cont(7) = '1') then

			nreset_x		<=	'1';
			cpu_int		<=	'0';

		elsif (cont(6) = '1') then

			nreset_x		<=	'1';
			cpu_int		<=	'0';

		elsif (cont(5) = '1') then

			nreset_x		<=	'1';
			cpu_int		<=	'0';

		elsif (cont(4) = '1') then

			nreset_x		<=	'1';
			cpu_int		<=	'0';

		else 

			nreset_x		<=	'1';
			cpu_int		<=	'0';

		end if;
	end process;

	nreset	<=	nreset_x;

end behavioral ;




