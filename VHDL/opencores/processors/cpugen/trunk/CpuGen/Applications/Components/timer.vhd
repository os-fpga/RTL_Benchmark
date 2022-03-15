-- TIMER
-- gferrante@opencores.org
--
-- 	Prescaler 256 fixed 
--	@ 33MHz => / 0x10000 => about 2 ms => 
-- 	1 timer interrupt (tmr_int) each (tmr_in * 2) ms
--
--	tmr_enable 	= '1' => enable timer
--	tmr_reset  	= '1' => reset timer
--	nCS_TIMER = 0 and nWE = 0 and addr = 0=> tmr_high <= tmr_in
--    nCS_TIMER = 0 and nWE = 0 and addr = 1=> tmr_enable <= tmr_in(0); tmr_reset <= tmr_in(1); 
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity TIMER is

	port(	
		tmr_int:	out std_logic;
		tmr_out:	out	std_logic_vector(7 downto 0);
		tmr_in:	in 	std_logic_vector(7 downto 0);
		addr:		in	std_logic;
		nWE:		in	std_logic;
		nCS_TIMER:	in	std_logic;
		clk:		in	std_logic;
		nreset:	in	std_logic
	);
end;

architecture TMR_STRUCT of TIMER is
   
CONSTANT	LOW_ZERO	: std_logic_vector(7 downto 0) := (others => '0');
CONSTANT	HIGH_ZERO	: std_logic_vector(7 downto 0) := (others => '0');

SIGNAL 	tmr_low	: std_logic_vector(7 downto 0);
SIGNAL 	tmr_high	: std_logic_vector(7 downto 0);
SIGNAL 	tmr_count	: std_logic_vector(7 downto 0);
SIGNAL 	tmr_status	: std_logic_vector(7 downto 0);
SIGNAL 	tmr_enable	: std_logic;
SIGNAL 	tmr_reset	: std_logic;
SIGNAL 	tmr_int_x	: std_logic;

begin

	process (nreset, clk, tmr_high)

	begin

		if (nreset = '0') then

			tmr_low		<= (others => '0'); 
			tmr_high	<= (others => '0');
			tmr_reset	<= '1';
			tmr_enable	<= '0';			
			tmr_int_x 	<= '0';	
				
		elsif (rising_edge(clk)) then
	
			if ((nWE = '0') and (nCS_TIMER = '0') and (addr = '0')) then
				
				tmr_count	<=	tmr_in;	
				tmr_high	<=	tmr_in;					
				tmr_low		<=	(others => '0');				

			elsif ((nWE = '0') and (nCS_TIMER = '0') and (addr = '1')) then

				tmr_enable	<= tmr_in(0);
				tmr_reset	<= tmr_in(1);
				
			end if;
					
			if (tmr_reset = '1') then 	
				
				tmr_low		<= (others => '0'); 
				tmr_high	<= (others => '0');
				tmr_int_x 	<= '0';	
				
			elsif (tmr_enable = '1') then
										
				tmr_low <= tmr_low + 1;

				if (tmr_low = LOW_ZERO) then
						
					tmr_high <= tmr_high - 1;		
				
				end if;
				
				if ((tmr_high = HIGH_ZERO) and (tmr_low = LOW_ZERO)) then
				
					tmr_int_x 	<= 	'1';
					tmr_high 	<=	tmr_count;
					
				else

					tmr_int_x <= '0';	
		
				end if;
				
			end if;
							
		end if;


	end process;

	tmr_int 	<= 	tmr_int_x;
	tmr_out		<=	tmr_high;	
					                              			
end TMR_STRUCT;
