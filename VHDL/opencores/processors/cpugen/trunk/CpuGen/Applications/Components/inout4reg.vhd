-- INOUT4REG 
-- gferrante@opencores.org
--
--	reg_dir_in = 0 => INPUT PORT
--  reg_dir_in = 1 => OUTPUT PORT
--
--	OUTPUT PORT:
--	nCS_REG = '0' and nWE = '0' and addr = N => inout_Nreg	<= reg_data_in;
--
--	INPUT PORT:
--	nCS_REG = '0' and nRE = '0' and addr = N => reg_data_out	<= inout_Nreg;
--

library ieee;
use ieee.std_logic_1164.all;

entity INOUT4REG is

	port(	
		out_0reg:		out	std_logic_vector(7 downto 0);
		out_1reg:		out	std_logic_vector(7 downto 0);
		in_0reg:		in	std_logic_vector(7 downto 0);
		in_1reg:		in	std_logic_vector(7 downto 0);
		reg_data_out:	out	std_logic_vector(7 downto 0);		
		reg_data_in:	in	std_logic_vector(7 downto 0);
		addr:			in	std_logic;
		nWE:			in	std_logic;
		nRE:			in	std_logic;
		nCS_REG:		in	std_logic;
		nreset:		in	std_logic;
		clk:			in	std_logic
	);
end;

architecture INOUT4REG_STRUCT of INOUT4REG is
     
SIGNAL 		reg_data_out_x		: std_logic_vector(7 downto 0);
SIGNAL 		reg_data_out_c		: std_logic_vector(7 downto 0);

begin
	
	process (clk,nreset)

	begin

		if (nreset = '0') then

			out_0reg		<= (others => '0'); 
			out_1reg		<= (others => '0');			
			reg_data_out_c	<= (others => '0');

		elsif (rising_edge(clk)) then
						
			reg_data_out_c	<= reg_data_out_x;

			if ((nWE = '0') and (nCS_REG = '0') and (addr = '0')) then
				out_0reg		<=	reg_data_in;
			end if;
			if ((nWE = '0') and (nCS_REG = '0') and (addr = '1')) then
				out_1reg		<=	reg_data_in;
			end if;
				
		end if;

	end process;

	process (nRE,nCS_REG,addr,in_0reg,in_1reg,reg_data_out_c)

	begin

		if ((nRE = '0') and (nCS_REG = '0') and (addr = '0')) then

			reg_data_out_x	<= in_0reg;

		elsif ((nRE = '0') and (nCS_REG = '0') and (addr = '1')) then

			reg_data_out_x	<= in_1reg;

		else

			reg_data_out_x	<= reg_data_out_c;

		end if;

	end process;
			
	reg_data_out	<= reg_data_out_x;
					                              			
end INOUT4REG_STRUCT;
