--
-- SRam from file
-- gferrante@opencores.org
-- 

LIBRARY ieee,std;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.utils_pkg.all;
use std.textio.all;

ENTITY sram IS
  generic(
		DADDR_LEN:	integer:= 8;
		DATA_LEN:	integer:= 8
	);    
   port(	
		ram_data_out: 	out 	std_logic_vector((DATA_LEN - 1) downto 0);
		ram_data_in: 	in 	std_logic_vector((DATA_LEN - 1) downto 0);
		ram_addr_in: 	in 	std_logic_vector((DADDR_LEN - 1) downto 0);
		nwe:			in	std_logic;
		nreset:		in	std_logic;
		clk:			in	std_logic
	);

-- Declarations

END sram;

ARCHITECTURE struct OF sram IS

	TYPE		ram_area is array	(((2 ** DADDR_LEN) - 1) downto 0) of std_logic_vector((DATA_LEN - 1) downto 0);
	SIGNAL 	ram_data: 	ram_area;
	SIGNAL 	ram_data_c: std_logic_vector((DATA_LEN - 1) downto 0):= (others => '0');

begin

	-- Configuration

	process(clk,nreset)
    	begin

		if (nreset = '0') then

			ram_data((2 ** DADDR_LEN) - 1)	<= (others => '0');
			ram_data(0)					<= (others => '0');

		elsif rising_edge(clk) then

			if (nwe = '0') then 
				ram_data(to_integer(ram_addr_in)) <= ram_data_in;
			end if;

			ram_data_c <= ram_data(to_integer(ram_addr_in));
		
		end if;
		
	end process;

	ram_data_out <= ram_data_c;

END struct;
