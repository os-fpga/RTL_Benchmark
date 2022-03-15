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
		nwe:		in  std_logic;
		ncs:		in  std_logic;
		port_out: 	in  std_logic_vector(15 downto 0);
		port_in: 	out std_logic_vector(15 downto 0);
		cpu_int: 	out std_logic;
		nreset: 	out std_logic
		);
end WORLD;

architecture behavioral of WORLD is
signal cont		:std_logic_vector(15 downto 0) := (others => '0');
signal reg		:std_logic_vector(15 downto 0) := (others => '0');
signal nreset_x	:std_logic;		

begin
	process(clk)
	  begin
		if (rising_edge(clk)) then
			cont 	<= cont + 1;
			if (nreset_x = '0') then
				reg	<=	(others => '0');
			elsif ((ncs = '0') and (nwe = '0')) then
				reg	<=	port_out;
			end if;
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

	port_in	<=	reg;
	nreset	<=	nreset_x;

end behavioral ;




