----------------------------------------------------------------------------------
-- Company: SDO
-- Engineer: CW
-- 
-- Create Date:    13:26:28 09/05/2013 
-- Design Name: 
-- Module Name:    TDport_RAM - Behavioral 
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
use ieee.numeric_std.all;

library std;
use std.textio.all;

library UNISIM;
use UNISIM.VComponents.all;

entity TDP_RAM is
	Generic (G_DATA_A_SIZE 	:natural :=32;
				G_ADDR_A_SIZE	:natural :=9;
				G_RELATION		:natural :=3;
				G_INIT_ZERO		:boolean := true;
				G_INIT_FILE		:string :="");--log2(SIZE_A/SIZE_B)
   Port ( CLK_A_IN 	: in  STD_LOGIC;
          WE_A_IN 	: in  STD_LOGIC;
          ADDR_A_IN 	: in  STD_LOGIC_VECTOR (G_ADDR_A_SIZE-1 downto 0);
          DATA_A_IN	: in  STD_LOGIC_VECTOR (G_DATA_A_SIZE-1 downto 0);
          DATA_A_OUT	: out  STD_LOGIC_VECTOR (G_DATA_A_SIZE-1 downto 0);
          CLK_B_IN 	: in  STD_LOGIC;
			 WE_B_IN 	: in  STD_LOGIC;
          ADDR_B_IN 	: in  STD_LOGIC_VECTOR (G_ADDR_A_SIZE+G_RELATION-1 downto 0);
          DATA_B_IN 	: in  STD_LOGIC_VECTOR (G_DATA_A_SIZE/(2**G_RELATION)-1 downto 0);
          DATA_B_OUT : out STD_LOGIC_VECTOR (G_DATA_A_SIZE/(2**G_RELATION)-1 downto 0));

	attribute ram_style : string; 
	attribute ram_style of TDP_RAM : entity is "block";

end TDP_RAM;

architecture Behavioral of TDP_RAM is

subtype slv   is std_logic_vector;

type RAM_TYPE is array(2**(G_ADDR_A_SIZE+G_RELATION)-1 downto 0) of std_logic_vector(G_DATA_A_SIZE/(2**G_RELATION)-1 downto 0);

impure function InitRamFromFile (InitZero : in boolean; RamFileName : in string) return RAM_TYPE is
	FILE RamFile : text;
	variable RamFileLine : line;
	variable RAM : RAM_TYPE;
	variable tmp : bit_vector(G_DATA_A_SIZE/(2**G_RELATION)-1 downto 0);
begin
	if InitZero = true then
		for I in 0 to (2**(G_ADDR_A_SIZE+G_RELATION))-1 loop
			RAM(I) := (others => '0');
		end loop;
		return RAM;
	else
		file_open(RamFile, RamFileName, READ_MODE);
		for I in 0 to (2**(G_ADDR_A_SIZE+G_RELATION))-1 loop
			readline(RamFile, RamFileLine);
			read(RamFileLine, tmp);
			RAM(I) := To_StdLogicVector(tmp);
		end loop;
		return RAM;
	end if;
end InitRamFromFile;

shared variable memory : RAM_TYPE  := InitRamFromFile(G_INIT_ZERO, G_INIT_FILE);

begin

process(CLK_A_IN)  begin
	if rising_edge(CLK_A_IN)  then
		if G_RELATION = 0 then
			if WE_A_IN = '1'  then
				memory(to_integer(unsigned(ADDR_A_IN))) := DATA_A_IN;
			end if;	
			DATA_A_OUT <= memory(to_integer(unsigned(ADDR_A_IN)));
		else
			for I in 0 to 2**G_RELATION-1 loop
				DATA_A_OUT(G_DATA_A_SIZE/(2**G_RELATION)*(I+1)-1 downto G_DATA_A_SIZE/(2**G_RELATION)*(I)) <= memory(to_integer(unsigned(ADDR_A_IN) & to_unsigned(I,G_RELATION)));
				if WE_A_IN = '1'  then
					memory(to_integer(unsigned(ADDR_A_IN) & to_unsigned(I,G_RELATION))) := DATA_A_IN(G_DATA_A_SIZE/(2**G_RELATION)*(I+1)-1 downto G_DATA_A_SIZE/(2**G_RELATION)*(I));
				end if;	
			end loop;
		end if;	
	end if;	
end process;

process(CLK_B_IN)  begin
	if rising_edge(CLK_B_IN)  then
		if WE_B_IN = '1'  then
			memory(to_integer(unsigned(ADDR_B_IN))) := DATA_B_IN;
		end if;	
		DATA_B_OUT <= memory(to_integer(unsigned(ADDR_B_IN)));
	end if;
end process;
	
end Behavioral;

