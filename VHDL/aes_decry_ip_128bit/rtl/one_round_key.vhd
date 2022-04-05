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
--This module generates one 128 bit key for next round given the current key as input.
--Logic type : Combinational
--*************************************************************

library ieee;
use ieee.std_logic_1164.all;

entity one_round_key is
port(
	 in_key: in std_logic_vector(127 downto 0);
	 out_key: out std_logic_vector(127 downto 0);
	 rcon: in std_logic_vector(7 downto 0)
	);
end one_round_key;

architecture beh_one_round_key of one_round_key is
   component Sub_4bytes
   port(
     word_in: in std_logic_vector(31 downto 0);
	 word_out: out std_logic_vector(31 downto 0)
     );
   end component;

   signal k0,k1,k2,k3: std_logic_vector(31 downto 0);
   signal k0out,k1out,k2out,k3out: std_logic_vector(31 downto 0);
   signal k3_rot_sub,k3_rot:std_logic_vector(31 downto 0);

begin 
	k0 <= in_key(127 downto 96);
	k1 <= in_key(95 downto 64);
	k2 <= in_key(63 downto 32);
	k3 <= in_key(31 downto 0);
    
	k3_rot <= k3(23 downto 0) & k3(31 downto 24);
	
	Sub_4bytes_inst:Sub_4bytes
	port map(word_in=>k3_rot,word_out=>k3_rot_sub);
	
	k0out <= k3_rot_sub xor k0 xor (rcon & x"000000");
	k1out <= k0out xor k1;
	k2out <= k1out xor k2;
	k3out <= k2out  xor k3;
	
	out_key <= k0out & k1out & k2out & k3out;
	
end beh_one_round_key;