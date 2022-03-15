--
-- Ram from file
-- gferrante@opencores.org
-- 

LIBRARY ieee,std;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.utils_pkg.all;
use std.textio.all;

ENTITY ram IS
  generic(
		DADDR_LEN:	integer:= 8;
		DATA_LEN:	integer:= 8;
	      FILENAME:   STRING:="ram.vin"
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

END ram;

ARCHITECTURE struct OF ram IS

	TYPE		ram_area is array	(((2 ** DADDR_LEN) - 1) downto 0) of std_logic_vector((DATA_LEN - 1) downto 0);

	CONSTANT 	RAM_ZERO:	std_logic_vector((DATA_LEN - 1) downto 0):= (others => '0');
	SIGNAL 	ram_data: 	ram_area := (others => RAM_ZERO);
	SIGNAL 	ram_data_c: std_logic_vector((DATA_LEN - 1) downto 0):= (others => '0');

begin

	-- Configuration

	process(clk,nreset)
		FILE		RAMFILE	: text open READ_MODE is FILENAME;
	
		VARIABLE	LINE_BUFFER	: line;
		VARIABLE	LINE		: natural := 0;
		VARIABLE	DATA		: natural := 0;                                  
    	begin

		if rising_edge(nreset) then

			while (not endfile(RAMFILE)) loop
			readline(RAMFILE, LINE_BUFFER);
			if LINE_BUFFER(1) = '-' or LINE_BUFFER(1) = ' ' then
				next;
			end if;
			read (LINE_BUFFER, LINE);
			read (LINE_BUFFER, DATA);
			ram_data(LINE)	<=	to_stdnlogic_vector(DATA,DATA_LEN);	
			end loop;
	--		file_close(RAMFILE);

			report ("Load data ram ") severity WARNING;

		elsif rising_edge(clk) then

			if (nwe = '0') then 
				ram_data(to_integer(ram_addr_in)) <= ram_data_in;
			end if;

			ram_data_c <= ram_data(to_integer(ram_addr_in));
		
		end if;
		
	end process;

	ram_data_out <= ram_data_c;

END struct;
