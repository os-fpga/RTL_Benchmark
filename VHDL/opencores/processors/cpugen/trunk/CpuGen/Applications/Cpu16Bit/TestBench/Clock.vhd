--
-- VHDL: EXTERNAL OSCILLATOR Behavioral
-- gferrante@opencores.org
--

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

entity CLOCK is
	generic (
		Tclock: TIME := 100 ns		
	);
	port (
		clk: out std_logic
	);
end CLOCK;

architecture behavioral of CLOCK is

begin

--  Processo di clock

    clock: process

        variable clktmp: std_logic := '0';

    begin

        clktmp := not clktmp;
        clk <= clktmp;
        wait for (Tclock/2);

    end process;

end behavioral ;




