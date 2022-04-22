--************************************************************
--Copyright 2015, Ganesh Hegde < ghegde@opencores.org >      
--                                                           
--This source file may be used and distributed without  
--restriction provided that this copyright statement is not 
--removed from the file and that any derivative work contains
--the original copyright notice and the associated disclaimer.
--
--This source is distributed in the hope that it will be
--useful, but WITHOUT ANY WARRANTY; without even the implied
--warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
--PURPOSE.  See the GNU Lesser General Public License for more
--details.
--
--You should have received a copy of the GNU Lesser General
--Public License along with this source; if not, download it
--from http://www.opencores.org/lgpl.shtml
--
--*************************************************************

--*************************************************************
-- Single port RAM module.
--Write latency : 1 clock cycle
-- Read latency : One clock cycle is consumed to register the address.
-- Data is valid there after. 
--Logic type : Sequential
--*************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity singleport_RAM is 
   port(
        datain : in std_logic_vector(127 downto 0);
		addr : in std_logic_vector(3 downto 0);
		we,clk   : in std_logic;
		dataout: out std_logic_vector(127 downto 0)
   );
end singleport_RAM;

architecture beh_singleport_RAM of singleport_RAM is

-- Build a 2-D array type for the RAM
subtype word_t is std_logic_vector(127  downto 0);
type memory is array (15 downto 0) of word_t;
-- Declare the RAM signal.
signal RAM:memory;
-- Register to hold the address
signal addr_reg : natural range 0 to 15;
signal ram_addr :natural range 0 to 15;

begin
   process(clk)
   begin
	if clk'event and clk='1' then
	   if(we='1') then
	     RAM(ram_addr)<= datain;
	   end if;
       -- Register the address for reading
       addr_reg <=  ram_addr;	   
	end if;   
   end process;
   
   dataout <= RAM(addr_reg);
   ram_addr <= to_integer(unsigned(addr));
   
end beh_singleport_RAM;