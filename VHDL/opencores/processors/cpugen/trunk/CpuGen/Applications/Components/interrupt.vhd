--
-- INTERRUPT CONTROLLER
-- on rising edge
--
-- by gferrante@opencores.org
--
--	nCS_INT = 0 and addr = 0 => int_mask	<=	int_data;	-- bit = '0' => interrupt disabled
--	nCS_INT = 0 and addr = 1 => int_clr		<=	int_data;	-- bit = '1' => interrupt cleared and disabled
--

library ieee;
use ieee.std_logic_1164.all;

entity INTERRUPT is

	generic (NI : integer := 8);
	port(	
		int_ext:	out 	std_logic;
		int_out:	out	std_logic_vector((NI - 1) downto 0);
		int_in:		in 	std_logic_vector((NI - 1) downto 0);
		int_data:	in 	std_logic_vector((NI - 1) downto 0);
		addr:		in	std_logic;
		nWE:		in	std_logic;
		nCS_INT:	in	std_logic;
		clk:		in	std_logic;
		nreset:	in	std_logic
	);
end;

architecture INTERRUPT_STRUCT of INTERRUPT is
   
CONSTANT		ALL_ZERO		: std_logic_vector((NI - 1) downto 0) := (others => '0');
SIGNAL 		int_masked		: std_logic_vector((NI - 1) downto 0);
SIGNAL 		int_masked_c	: std_logic_vector((NI - 1) downto 0);
SIGNAL 		int_mask_c		: std_logic_vector((NI - 1) downto 0);
SIGNAL 		int_clr_c		: std_logic_vector((NI - 1) downto 0);
SIGNAL 		int_pending_c	: std_logic_vector((NI - 1) downto 0);
  
begin

	process (nreset, clk)

	begin

		if (nreset = '0') then

			int_pending_c	<= (others => '0'); 
			int_masked_c	<= (others => '0');
			int_masked		<= (others => '0');
			int_mask_c		<= (others => '0');
			int_clr_c		<= (others => '0');

		elsif (rising_edge(clk)) then
			
			if ((nWE = '0') and (nCS_INT = '0') and (addr = '0')) then		
						
				int_mask_c		<=	int_data;

			elsif ((nWE = '0') and (nCS_INT = '0') and (addr = '1')) then		
						
				int_clr_c		<=	int_data;
				
			end if;

			int_masked		<=  (int_in and int_mask_c);
			int_masked_c	<=  int_masked;							
			int_pending_c 	<=  (not int_clr_c) and ((int_masked and (not int_masked_c)) or int_pending_c);					                              			
														
		end if;

	end process;

	int_out			<=	int_pending_c;	
	int_ext			<=	'0' when (int_pending_c = ALL_ZERO) else '1';

end INTERRUPT_STRUCT;
