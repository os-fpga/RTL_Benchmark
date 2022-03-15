-- PDFF
-- gferrante@opencores.org
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity PDFF is

	generic (NI : integer := 8);
	port(	
		q:		out	std_logic_vector((NI - 1) downto 0);
		d:		in 	std_logic_vector((NI - 1) downto 0);
		nen:	in	std_logic;
		clk:	in	std_logic;
		nreset:	in	std_logic
	);
end;

architecture PDFF_STRUCT of PDFF is
   
SIGNAL 	dff_c		: std_logic_vector((NI - 1) downto 0);
SIGNAL 	dff_x		: std_logic_vector((NI - 1) downto 0);
  
begin

	process (nreset, clk, nen)

	begin

		if (nreset = '0') then

			dff_c	<=	(others => '0');	

		elsif (rising_edge(clk)) then

				dff_c	<=	dff_x;	

		end if;		
		
	end process;
	
	process(nreset, nen, d, dff_c)
	
	begin
	
		if (nreset = '0') then

			dff_x	<=	(others => '0');

		elsif (nen = '0') then

			dff_x	<=	d;
				
		else 

			dff_x	<=	dff_c;

		end if;	

	end process;

	q		<=	dff_c;					
					                              			
end PDFF_STRUCT;
