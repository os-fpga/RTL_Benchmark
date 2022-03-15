-- H2V
-- gferrante@opencores.org
--

library ieee;
use ieee.std_logic_1164.all;

entity H2V is

  generic(
		MADDR_LEN:	integer:= 10
	);    	
	port(
		maddr:		out	std_logic_vector((MADDR_LEN - 1) downto 0);							
		iwait_out:	out std_logic;
		iaddr:		in	std_logic_vector((MADDR_LEN - 1) downto 0);		
		daddr:		in	std_logic_vector((MADDR_LEN - 1) downto 0);				
		ndre_in:	in	std_logic;
		nadwe_in:	in	std_logic;
		dwait_in:	in	std_logic;		
		nreset_in:	in	std_logic;
		clk_in:		in	std_logic
	);
end;

architecture H2V_STRUCT of H2V is

type	A2VI_STATE is (IDLE_S, IWAIT_S); 
signal	daddr_c: 	std_logic_vector((MADDR_LEN - 1) downto 0);
signal	nadwe_c: 	std_logic;
signal	ndre_c: 	std_logic;
signal	dwait_c: 	std_logic;

begin

	process (nreset_in, clk_in)
	
	variable 	a2vi_s: 	A2VI_STATE;

	begin
	
		if (nreset_in = '0') then

			iwait_out	<=	'0';
			a2vi_s		:= 	IDLE_S ;
			nadwe_c		<=	'1';
			ndre_c		<=	'1';
			dwait_c		<=	'0';
			daddr_c		<= (others => '0');
			
		elsif (rising_edge(clk_in)) then
	
			dwait_c	<=	dwait_in;

			case a2vi_s is
					
				when IDLE_S 	=>

					ndre_c	<=	ndre_in;
					nadwe_c	<= 	nadwe_in;
					daddr_c	<= 	daddr;
					
					if ((ndre_in = '0') or (nadwe_in = '0')) then
					
						iwait_out	<=	'1';
						a2vi_s		:= 	IWAIT_S;
					
					else

						iwait_out	<=	'0';
						a2vi_s		:= 	IDLE_S;
											
					end if;
					
				when IWAIT_S 	=>

					if (dwait_in = '1') then
						ndre_c	<=	ndre_c;	
						nadwe_c	<= 	nadwe_c;
						daddr_c	<= 	daddr_c;		
						iwait_out	<=	'1';
						a2vi_s		:= 	IWAIT_S;
					elsif ((nadwe_c = '0') or (dwait_c = '1')) then	
						ndre_c	<=	ndre_in;	
						nadwe_c	<= 	nadwe_in;
						daddr_c	<= 	daddr;		
						iwait_out	<=	'1';
						a2vi_s		:= 	IWAIT_S;			
					else
						ndre_c	<=	ndre_in;
						nadwe_c	<= 	nadwe_in;
						daddr_c	<= 	daddr;
						iwait_out	<=	'0';
						a2vi_s		:= 	IDLE_S;		
					end if;
	
				when others => 
	
					iwait_out	<=	'0';
					a2vi_s	:= 	IDLE_S ;
					ndre_c	<=	ndre_in;
					nadwe_c	<= 	nadwe_in;
					daddr_c	<= 	daddr;

			end case;
							
		end if;

	end process;
	
	process (ndre_in, nadwe_c, daddr, iaddr, daddr_c, dwait_in)
	
	begin
	
	-- LOW 		RAM AREA = ISTRUCTION
	-- HIGH 	RAM AREA = DATA

		if (ndre_in = '0') then

			maddr		<=	'1' & daddr((MADDR_LEN - 2) downto 0);		

		elsif ((nadwe_c = '0') or (dwait_in = '1'))  then
		
			maddr		<=	'1' & daddr_c((MADDR_LEN - 2) downto 0);
			
		else
		
			maddr		<=	iaddr;
		
		end if;
		
	end process;
		
end H2V_STRUCT;
