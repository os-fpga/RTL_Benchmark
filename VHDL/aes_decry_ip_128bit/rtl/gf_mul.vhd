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
-- Multiply given word with 0x0E,0x09,0x0D and 0x0B
-- This module does the job of GF multiplication of a given byte.
-- The output is a 32bit word such that MSByte to LSByte are 
-- product(GF) of 0x0E,0x09,0x0D and 0x0B with input byte.
--
--Logic type : Combinational
--*************************************************************

library ieee;
use ieee.std_logic_1164.all;

entity GF_mul is
   port(
        in_byte: in std_logic_vector(7 downto 0);
		out_word: out std_logic_vector(31 downto 0)--0x0E,0x09,0x0D,0x0B
        );
end GF_mul;

architecture beh_GF_mul of GF_mul is

    component xE 
    port (
    	--clk,reset : in std_logic;
    	data_in: in std_logic_vector(7 downto 0);
    	data_out:out std_logic_vector(7 downto 0)
    );
    end component;
    
    component x9
    port (
    	--clk,reset : in std_logic;
    	data_in: in std_logic_vector(7 downto 0);
    	data_out:out std_logic_vector(7 downto 0)
    );
    end component;
    
    component xD 
    port (
    	--clk,reset : in std_logic;
    	data_in: in std_logic_vector(7 downto 0);
    	data_out:out std_logic_vector(7 downto 0)
    );
    end component;
    
    component xB
    port (
    	--clk,reset : in std_logic;
    	data_in: in std_logic_vector(7 downto 0);
    	data_out:out std_logic_vector(7 downto 0)
    );
    end component;
    
	signal b0,b1,b2,b3:std_logic_vector(7 downto 0);
begin
   xD_inst:xD
   port map(data_in=>in_byte,data_out=>b2);
   
   xE_inst:xE
   port map(data_in=>in_byte,data_out=>b0);
   
   x9_inst:x9
   port map(data_in=>in_byte,data_out=>b1);
   
   xB_inst:xB
   port map(data_in=>in_byte,data_out=>b3);
   
   out_word <= b0&b1&b2&b3;--0x0E,0x09,0x0D,0x0B
   
end beh_GF_mul;
