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
--Multiply one column 
--
--Logic type : Combinational
--*************************************************************


library ieee;
use ieee.std_logic_1164.all;

entity inv_mix_column is
   port(
           column: in std_logic_vector(31 downto 0);
		   p0,p1,p2,p3: out std_logic_vector(31 downto 0)
        );
end inv_mix_column;

architecture beh_inv_mix_column of inv_mix_column is
   component GF_mul
   port(
        in_byte: in std_logic_vector(7 downto 0);
		out_word: out std_logic_vector(31 downto 0)--0x0E,0x09,0x0D,0x0B
        );
   end component;

   signal b0,b1,b2,b3: std_logic_vector(7 downto 0);
   signal k0,k1,k2,k3: std_logic_vector(31 downto 0);
begin

   GF_mul_inst1:GF_mul
   port map(in_byte=>b0,out_word=>k0);
   
   GF_mul_inst2:GF_mul
   port map(in_byte=>b1,out_word=>k1);
   
   GF_mul_inst3:GF_mul
   port map(in_byte=>b2,out_word=>k2);
   
   GF_mul_inst4:GF_mul
   port map(in_byte=>b3,out_word=>k3);
   
   b0 <= column(31 downto 24);
   b1 <= column(23 downto 16);
   b2 <= column(15 downto 8);
   b3 <= column(7 downto 0);
   
   p0 <= k0;
   p1 <= k1(7 downto 0) & k1(31 downto 8);
   p2 <= k2(15 downto 0) & k2(31 downto 16);
   p3 <= k3(23 downto 0) & k3(31 downto 24);
end beh_inv_mix_column;