----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:57:21 03/08/2012 
-- Design Name: 
-- Module Name:    modulus_ram - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity modulus_ram is
	port(
		clk : in std_logic;
		modulus_addr : in std_logic_vector(5 downto 0);
		write_modulus : in std_logic;
		modulus_in : in std_logic_vector(31 downto 0);
		modulus_out : out std_logic_vector(1535 downto 0)
	);
end modulus_ram;

architecture Behavioral of modulus_ram is
	-- single port blockram to store modulus
	component operands_sp
	port(
		clka: in std_logic;
		wea: in std_logic_vector(0 downto 0);
		addra: in std_logic_vector(4 downto 0);
		dina: in std_logic_vector(31 downto 0);
		douta: out std_logic_vector(511 downto 0)
	);
	end component;
	
	signal part_enable : std_logic_vector(3 downto 0);
	signal wea : std_logic_vector(3 downto 0);
	signal addra : std_logic_vector(4 downto 0);
begin

	-- the blockram has a write depth of 2 but we only use the lower half
	addra <= '0' & modulus_addr(3 downto 0);
	
	-- the two highest bits of the address are used to select the bloc
	with modulus_addr(5 downto 4) select
		part_enable <= "0001" when "00",
		               "0010" when "01",
				         "0100" when "10",
				         "1000" when others;

	with write_modulus select
		wea <= part_enable when '1',
		       "0000" when others;
	
	-- 4 instances of 512 bits blockram
	modulus_0 : operands_sp
	port map (
			clka => clk,
			wea => wea(0 downto 0),
			addra => addra,
			dina => modulus_in,
			douta => modulus_out(511 downto 0)
	);
	
	modulus_1 : operands_sp
	port map (
			clka => clk,
			wea => wea(1 downto 1),
			addra => addra,
			dina => modulus_in,
			douta => modulus_out(1023 downto 512)
	);
	
	modulus_2 : operands_sp
	port map (
			clka => clk,
			wea => wea(2 downto 2),
			addra => addra,
			dina => modulus_in,
			douta => modulus_out(1535 downto 1024)
	);
	
--	modulus_3 : operands_sp
--	port map (
--			clka => clk,
--			wea => wea(3 downto 3),
--			addra => addra,
--			dina => modulus_in,
--			douta => modulus_out(2047 downto 1536)
--	);

end Behavioral;

