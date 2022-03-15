--
-- Rom from file
-- gferrante@opencores.org
-- 

LIBRARY ieee,std;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.utils_pkg.all;
use std.textio.all;

ENTITY rom IS
  generic(
		IADDR_LEN:	integer:= 8;
		IDATA_LEN:	integer:= 10;
		FILENAME:   STRING:="rom.vin"
	);    
  port(	
		rom_data_out: 	out 	std_logic_vector((IDATA_LEN - 1) downto 0);
		rom_addr_in: 	in 	std_logic_vector((IADDR_LEN - 1) downto 0);
		clk:			in	std_logic
	);

-- Declarations

END rom;

ARCHITECTURE struct OF rom IS

	TYPE		rom_area is array	(((2 ** IADDR_LEN) - 1) downto 0) of std_logic_vector((IDATA_LEN - 1) downto 0);

	CONSTANT 	ROM_ZERO:	std_logic_vector((IDATA_LEN - 1) downto 0):= (others => '0');
	SIGNAL 	rom_data: 	rom_area := (others => ROM_ZERO);
	SIGNAL 	rom_data_c: std_logic_vector((IDATA_LEN - 1) downto 0):= (others => '0');

begin

	-- Configuration

	process(clk)

    	begin

		if rising_edge(clk) then

			rom_data_c <= rom_data(to_integer(rom_addr_in));
	
		end if;
	
	END process;

	init : process                                               
	-- variable declarations   
		FILE		ROMFILE	: text open READ_MODE is FILENAME;
	
		VARIABLE	LINE_BUFFER		: line;
		VARIABLE	LINE		: natural := 0;
		VARIABLE	DATA		: natural := 0;                                  
	begin                                                        
        -- code that executes only once 

		while (not endfile(ROMFILE)) loop
		readline(ROMFILE, LINE_BUFFER);
		if LINE_BUFFER(1) = '-' or LINE_BUFFER(1) = ' ' then
			next;
		end if;
		read (LINE_BUFFER, LINE);
		read (LINE_BUFFER, DATA);
		rom_data(LINE)	<=	to_stdnlogic_vector(DATA,IDATA_LEN);	
		end loop;
--		file_close(ROMFILE);

		report ("Load data rom ") severity WARNING;

	wait;                                                       
	end process init;                                           

	rom_data_out <= rom_data_c;

END struct;
