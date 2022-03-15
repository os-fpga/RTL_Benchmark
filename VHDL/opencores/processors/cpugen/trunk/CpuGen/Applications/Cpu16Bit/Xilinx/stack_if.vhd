--
-- STACK_IF
--       
-- gferrante@opencores.org
--   

LIBRARY ieee,std;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY stack_if IS
  generic(
		DATA_LEN:	integer:= 8
	);    
  port(	
		addr_out: 		out 	std_logic_vector((DATA_LEN - 1) downto 0);
		push_in: 		in 	std_logic;
		pop_in:		in	std_logic;
		nreset_in:		in	std_logic;
		clk_in:		in	std_logic
	);

-- Declarations

END stack_if ;

ARCHITECTURE struct OF stack_if IS

	SIGNAL 	addr_x: 	std_logic_vector((DATA_LEN - 1) downto 0);
	SIGNAL 	addr_c: 	std_logic_vector((DATA_LEN - 1) downto 0);

begin

	process(clk_in, nreset_in)

    	begin

		if (nreset_in = '0') then

			addr_c	<=	(others => '1');

		elsif rising_edge(clk_in) then

			addr_c	<=	addr_x;

		end if;
		
	end process;

	process(push_in, pop_in, addr_c)

    	begin

		if (push_in = '1') then

			addr_x	<=	addr_c + 1;

		elsif (pop_in = '1') then

			addr_x	<=	addr_c - 1;

		else 
	
			addr_x	<=	addr_c;			

		end if;
		
	end process;

	addr_out	<=	addr_x;

END struct;
