-- WAITSTATEGEN
-- gferrante@opencores.org
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity WAITSTATEGEN is
	
	generic(
		DADDR_LEN:	integer:= 10;
		DATA_LEN:	integer:= 16;
		NWAIT:		std_logic_vector(7 downto 0):= "00000111"
	);
	port(	
		dwait_out:			out std_logic;
		cpu_data_in_m:		out	std_logic_vector((DATA_LEN - 1) downto 0);
		cpu_daddr_out:		out	std_logic_vector((DADDR_LEN - 1) downto 0);
		ndre_out:			out	std_logic;
		ndwe_out:			out	std_logic;			
		cpu_data_in:		in	std_logic_vector((DATA_LEN - 1) downto 0);
		cpu_adaddr_out_m: 	in	std_logic_vector((DADDR_LEN - 1) downto 0);	
		nacs_wait:			in	std_logic;			
		ndre_in:			in	std_logic;
		nadwe_in:			in	std_logic;							
		nreset_in:			in	std_logic;
		clk_in:				in	std_logic
	);
end;

architecture WAITSTATEGEN_STRUCT of WAITSTATEGEN is

constant	WAIT_LEN:	integer:= 8;

-- constant	NWAIT: std_logic_vector((WAIT_LEN - 1) downto 0):= "00000111";

constant	ALL_ZERO: std_logic_vector((WAIT_LEN - 1) downto 0):= (others => '0');
constant	LAST_WAIT: std_logic_vector((WAIT_LEN - 1) downto 0):= (0 => '1', others => '0');
type		DW_STATE is (IDLE_S, DWAIT_S); 
signal		dwait_c: std_logic;		
signal		ndre_c: std_logic;		
signal		ndwe_c: std_logic;		
signal		nwait_c: std_logic_vector((WAIT_LEN - 1) downto 0);	
signal		cpu_daddr_c: std_logic_vector((DADDR_LEN - 1) downto 0);		
signal		cpu_daddr_x: std_logic_vector((DADDR_LEN - 1) downto 0);																																																																																																								
										 
begin

	process (nreset_in, clk_in)
	
	variable 	dw_s: 	DW_STATE;

	begin

		if (nreset_in = '0') then

			dwait_c		<=	'0';
			nwait_c		<=  NWAIT;	
			cpu_daddr_c		<=	(others => '0');
			ndwe_c		<=	'1';
			ndre_c		<=	'1';			
			dw_s			:= 	IDLE_S ;

		elsif (rising_edge(clk_in)) then

			case dw_s is
					
				when IDLE_S 	=>
					
					ndre_c			<=	ndre_in;
					ndwe_c			<=	nadwe_in;
					cpu_daddr_c		<=	cpu_daddr_x;
					
					if ((NWAIT /= ALL_ZERO) and ((nadwe_in = '0') or (ndre_in = '0')) and (nacs_wait = '0')) then

						dwait_c		<=	'1';						
						nwait_c		<=	nwait_c - 1;
						dw_s		:= 	DWAIT_S;
					else
						dwait_c		<=	'0';
						nwait_c		<=  NWAIT;
						dw_s		:= 	IDLE_S ;
					end if;
					
				when DWAIT_S 	=>
				
					if (nwait_c /= ALL_ZERO) then
						dwait_c		<=	'1';
						nwait_c		<=	nwait_c - 1;
						dw_s		:= 	DWAIT_S ;
					else
						dwait_c		<=	'0';
						nwait_c		<= 	NWAIT;
						dw_s		:= 	IDLE_S ;
					end if;
					
				when others => 
	
					dwait_c		<=	'0';
					nwait_c		<= 	NWAIT;
					dw_s		:= 	IDLE_S ;
			
			end case;
							
		end if;

	end process;

	process (nreset_in, nwait_c, ndre_c, ndre_in, cpu_data_in, ndwe_c, cpu_daddr_c, cpu_adaddr_out_m)
	
	begin

		if (nreset_in = '0') then

			cpu_data_in_m	<=	(others => '0');
			ndre_out		<=	'1';
			cpu_daddr_x		<=	(others => '0');

		else
						
			cpu_data_in_m	<= cpu_data_in;

			if (nwait_c /= NWAIT) then
				cpu_daddr_x		<=	cpu_daddr_c;
			else
				cpu_daddr_x		<=	cpu_adaddr_out_m;
			end if;

			if (NWAIT = ALL_ZERO) then
				ndre_out	<= ndre_in;			
			else
				ndre_out	<= 	ndre_c;	
			end if;
													
		end if;

	end process;
	
	dwait_out		<=	dwait_c;
	ndwe_out		<=	ndwe_c;
	cpu_daddr_out	<=	cpu_daddr_x when (ndre_in = '0') else cpu_daddr_c;
	
end WAITSTATEGEN_STRUCT;
