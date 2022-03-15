--
-- VHDL: EXTERNAL WORLD Behavioral
--          gferrante@opencores.org
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;

entity WORLD is
	port (
		clk:			in std_logic;
		ctrl_data_in:	out std_logic_vector(3 DOWNTO 0);
		nreset: 		out std_logic := '1'
		);
end WORLD;

architecture behavioral of WORLD is
signal cont		:std_logic_vector(9 downto 0) := (others => '0');
signal ctrl_x	:std_logic_vector(3 downto 0) := (others => '0');
signal ctrl_c	:std_logic_vector(3 downto 0) := (others => '0');

begin
	process(clk)
	  begin
		if (rising_edge(clk)) then
			cont 	<= cont + "000000001";
			ctrl_c	<= ctrl_x;
		end if;

	end process;

	process(cont)
	   
         begin
		if (cont < "000000010") then

			nreset		<=	'0';
			ctrl_data_in		<=	"0000";
			ctrl_x		<=	"0000";
		
		elsif (cont(3 downto 0) = "0000") then

			nreset		<=	'1';
			ctrl_data_in		<=	ctrl_c;
			ctrl_x		<=	ctrl_c + 1;

		elsif (cont(7) = '1') then

			nreset		<=	'1';
			ctrl_data_in		<=	ctrl_c;
			ctrl_x		<=	ctrl_c;

		elsif (cont(6) = '1') then

			nreset		<=	'1';
			ctrl_data_in		<=	ctrl_c;
			ctrl_x		<=	ctrl_c;

		elsif (cont(5) = '1') then

			nreset		<=	'1';
			ctrl_data_in		<=	ctrl_c;
			ctrl_x		<=	ctrl_c;

		elsif (cont(4) = '1') then

			nreset		<=	'1';
			ctrl_data_in		<=	ctrl_c;
			ctrl_x		<=	ctrl_c;

		else 

			nreset		<=	'1';
			ctrl_data_in		<=	ctrl_c;
			ctrl_x		<=	ctrl_c;

		end if;
	end process;

end behavioral ;




