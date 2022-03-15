--
-- 	CPUC_WD
--	rel. 2.0
-- 	by 	gferrante@opencores.org
--

library ieee;
use ieee.std_logic_1164.all;
use work.CPUC_UTILS.all;

entity CPUC_WD is

	port(
		daddr_out:		out	Cpu_daddr;
		ndwe_out:		out std_logic;
		adaddr_out_int:	in	Cpu_daddr;
		ndre_out_int:	in	std_logic;
		nadwe_out_int:	in	std_logic;
		nreset_in:		in	std_logic;
		clk_in:			in	std_logic
	);
end;

architecture WDC_STRUCT of CPUC_WD is

SIGNAL	daddr_c:	Cpu_daddr;
SIGNAL	ndwe_c:		std_logic;

begin

	process (nreset_in, clk_in)

	begin

		if (nreset_in = nreset_value) then

			daddr_c	<= (others => '0');
			ndwe_c	<= '1';

		elsif (rising_edge(clk_in)) then

			daddr_c	<= adaddr_out_int;
			ndwe_c	<= nadwe_out_int;

		end if;

	end process;

	ndwe_out	<=	ndwe_c;
	daddr_out	<=	adaddr_out_int when (ndre_out_int = '0') else daddr_c;

end WDC_STRUCT;

