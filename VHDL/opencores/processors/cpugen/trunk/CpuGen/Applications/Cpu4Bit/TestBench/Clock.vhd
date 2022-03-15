--
-- VHDL: EXTERNAL OSCILLATOR Behavioral
-- gferrante@opencores.org
--

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

entity CLOCK is
	generic (
		Tclock: TIME := 16 ns;
		Tuclock: TIME := 66 ns		
	);
	port (clk: out std_logic;
		uclk: out std_logic);
end CLOCK;

architecture behavioral of CLOCK is

begin

    clock: process

        variable clktmp: std_logic := '0';

    begin

        clktmp := not clktmp;
        clk <= clktmp;
        wait for (Tclock/2);

    end process;

    uclock: process

        variable uclktmp: std_logic := '0';

    begin

        uclktmp := not uclktmp;
        uclk <= uclktmp;
        wait for (Tuclock/2);

    end process;

end behavioral ;




