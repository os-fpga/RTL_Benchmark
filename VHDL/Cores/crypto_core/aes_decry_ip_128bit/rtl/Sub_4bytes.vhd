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
--This module will perform byte substitution for the given input word.
--Logic type : Combinational
--*************************************************************

library ieee;
use ieee.std_logic_1164.all;

entity Sub_4bytes is
port(
     word_in: in std_logic_vector(31 downto 0);
	 word_out: out std_logic_vector(31 downto 0)
     );
end Sub_4bytes;

architecture Sub_4bytes_beh of Sub_4bytes is
   signal b0,b1,b2,b3: std_logic_vector(7 downto 0);
   component Sbox 
   port (
	data_in: in std_logic_vector(7 downto 0);
	data_out:out std_logic_vector(7 downto 0)
   );
   end component;
begin
   b0<=word_in(31 downto 24);
   b1<=word_in(23 downto 16);
   b2<=word_in(15 downto 8);
   b3<=word_in(7 downto 0);
   
   Inst1:Sbox
      port map(data_in=>b0,data_out=>word_out(31 downto 24));
   Inst2:Sbox
      port map(data_in=>b1,data_out=>word_out(23 downto 16));
   Inst3:Sbox
      port map(data_in=>b2,data_out=>word_out(15 downto 8));
   Inst4:Sbox
      port map(data_in=>b3,data_out=>word_out(7 downto 0));
	  
end Sub_4bytes_beh;