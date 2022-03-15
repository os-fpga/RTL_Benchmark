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
		clk:		in std_logic;
		porta: 	out std_logic_vector(7 downto 0);
		portb: 	out std_logic_vector(7 downto 0);
		in_int: 	out std_logic_vector(3 downto 0);
		rxd: 		out std_logic := '1';
		nreset: 	out std_logic := '1'
		);
end WORLD;

architecture behavioral of WORLD is
signal cont		:std_logic_vector(15 downto 0) := (others => '0');
signal in_int_x	:std_logic_vector(3 downto 0) := (others => '0');
signal in_int_c	:std_logic_vector(3 downto 0) := (others => '0');
signal port_x	:std_logic_vector(7 downto 0) := (others => '0');
signal port_c	:std_logic_vector(7 downto 0) := (others => '0');

begin
	process(clk)
	  begin
		if (rising_edge(clk)) then
			cont 	<= cont + 1;
			in_int_c	<= in_int_x;
			port_c	<= port_x + 1;
		end if;

	end process;

	process(cont)
	   
         begin
		if (cont < "0000000000000010") then

			nreset		<=	'0';
			rxd			<=	'1';
			in_int		<=	"0000";
			in_int_x		<=	"0000";
			port_x 		<=	(others => '0');
		
		elsif (cont(3 downto 0) = "0000") then

			nreset		<=	'1';
			rxd			<=	'1';
			in_int		<=	in_int_c;
			in_int_x		<=	in_int_c + 1;
			port_x 		<=	port_c;

		elsif (cont(12) = '1') then

			nreset		<=	'1';
			rxd			<=	'1';
			in_int		<=	in_int_c;
			in_int_x		<=	in_int_c;
			port_x 		<=	port_c;

		elsif (cont(7) = '1') then

			nreset		<=	'1';
			rxd			<=	'1';
			in_int		<=	in_int_c;
			in_int_x		<=	in_int_c;
			port_x 		<=	port_c;

		elsif (cont(6) = '1') then

			nreset		<=	'1';
			rxd			<=	'1';
			in_int		<=	in_int_c;
			in_int_x		<=	in_int_c;
			port_x 		<=	port_c;

		elsif (cont(5) = '1') then

			nreset		<=	'1';
			rxd			<=	'1';
			in_int		<=	in_int_c;
			in_int_x		<=	in_int_c;
			port_x 		<=	port_c;

		elsif (cont(4) = '1') then

			nreset		<=	'1';
			rxd			<=	'1';
			in_int		<=	in_int_c;
			in_int_x		<=	in_int_c;
			port_x 		<=	port_c;

		else 

			nreset		<=	'1';
			rxd			<=	'1';
			in_int		<=	in_int_c;
			in_int_x		<=	in_int_c;
			port_x 		<=	port_c;

		end if;
	end process;

			porta			<=	port_c;
			portb			<=	port_c;

end behavioral ;




