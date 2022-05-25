----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:06:23 01/06/2015 
-- Design Name: 
-- Module Name:    lfsr16_mod - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lfsr32_mod is
    Port ( CLK_IN 		: in  STD_LOGIC;
           SEED_IN 		: in  STD_LOGIC_VECTOR(31 downto 0);
           SEED_EN_IN 	: in  STD_LOGIC;
           VAL_OUT 		: out STD_LOGIC_VECTOR(31 downto 0));
end lfsr32_mod;

architecture Behavioral of lfsr32_mod is

signal lfsr_reg : std_logic_vector(31 downto 0) := X"00000000";

begin

	VAL_OUT <= lfsr_reg;

	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if SEED_EN_IN = '1' then
				lfsr_reg <= SEED_IN;
			else
				lfsr_reg(31 downto 1) <= lfsr_reg(30 downto 0);
				lfsr_reg(0) <= not(lfsr_reg(31) XOR lfsr_reg(21) XOR lfsr_reg(1) XOR lfsr_reg(0)); 
			end if;
		end if;	
	end process;

end Behavioral;

