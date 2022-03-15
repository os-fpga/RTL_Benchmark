-- CTRL16CPU 
-- gferrante@opencores.org
--

library ieee;
use ieee.std_logic_1164.all;

entity ctrl16cpu is

	generic(
		DADDR_LEN:	integer:= 10;
		DATA_LEN:	integer:= 16
	);
	port(
		nWE_RAM:		out	std_logic;		
		nCS_EXT:		out	std_logic;								
		nACS_EXT:		out	std_logic;								
		DATA_OUT:		out	std_logic_vector((DATA_LEN - 1) downto 0);
		DATA_IN_RAM:	in	std_logic_vector((DATA_LEN - 1) downto 0);
		DATA_IN_EXT:	in	std_logic_vector((DATA_LEN - 1) downto 0);		
		ADADDR_IN:		in	std_logic_vector((DADDR_LEN - 1) downto 0);	
		nADWE_CPU:		in	std_logic;	
		nreset_in:		in	std_logic;				
		clk_in:			in	std_logic
	);
end;

architecture ctrl16cpu_struct of ctrl16cpu is
 
CONSTANT 	MUX_IN		: integer := 1;

CONSTANT	DATA_RAM_IN	:std_logic_vector((MUX_IN - 1) downto 0) := "0";
CONSTANT	DATA_EXT_IN	:std_logic_vector((MUX_IN - 1) downto 0) := "1";
SIGNAL 		mux_x		:std_logic_vector((MUX_IN - 1) downto 0);  
SIGNAL 		mux_c		:std_logic_vector((MUX_IN - 1) downto 0);  
SIGNAL		nWE_RAM_x	:std_logic;
SIGNAL		nWE_RAM_c	:std_logic;
SIGNAL		nCS_EXT_x	:std_logic;
SIGNAL		nCS_EXT_c	:std_logic;

begin
	
	CTRL16: process (clk_in, nreset_in)

	begin

		if (nreset_in = '0') then
			mux_c		<=	DATA_RAM_IN;
			nWE_RAM_c	<=	'1';
			nCS_EXT_c	<=	'1';
		elsif (rising_edge(clk_in)) then
			mux_c		<=	mux_x;
			nWE_RAM_c	<=	nWE_RAM_x;
			nCS_EXT_c	<=	nCS_EXT_x;
		end if;

	end process;
	
	process (nreset_in,ADADDR_IN,mux_c,nADWE_CPU,DATA_IN_RAM,DATA_IN_EXT)

	begin

		case	mux_c is
			when DATA_RAM_IN 	=>	DATA_OUT	<=	DATA_IN_RAM;
			when DATA_EXT_IN 	=>	DATA_OUT	<=	DATA_IN_EXT;
			when others			=>	DATA_OUT	<=	DATA_IN_RAM;
		end case;
		
		if (nreset_in = '1') then
			if (ADADDR_IN((DADDR_LEN - 1) downto (DADDR_LEN - MUX_IN)) = "0") then		
				mux_x			<= DATA_RAM_IN;
				if (nADWE_CPU = '0') then
					nWE_RAM_x	<= '0';
				else
					nWE_RAM_x	<= '1';				
				end if;
				nCS_EXT_x		<= '1';
			elsif (ADADDR_IN((DADDR_LEN - 1) downto (DADDR_LEN - MUX_IN)) = "1") then		
				mux_x			<= DATA_EXT_IN;
				nWE_RAM_x		<= '1';
				nCS_EXT_x		<= '0';
			else
				mux_x			<= DATA_RAM_IN;
				nWE_RAM_x		<= '1';
				nCS_EXT_x		<= '1';
			end if;
		else
			mux_x			<= DATA_RAM_IN;
			nWE_RAM_x		<= '1';
			nCS_EXT_x		<= '1';
		end if;
	
	end process;
	
	nWE_RAM		<=	nWE_RAM_c;
	nACS_EXT	<=	nCS_EXT_x;
	nCS_EXT		<=	nCS_EXT_c;
								                              			
end ctrl16cpu_struct;
