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
-- First three round i.e Inv shift row, Inv Sub byte, Add round
-- key are performed.
--Logic type : Combinational
--*************************************************************

library ieee;
use ieee.std_logic_1164.all;

entity InvSub_addRk is
   port(
        state_in : in std_logic_vector(127 downto 0);
        state_out : out std_logic_vector(127 downto 0);
		key : in std_logic_vector(127 downto 0)
         );
end InvSub_addRk;

architecture beh_InvSub_addRk of InvSub_addRk is

component Inv_Sub_4bytes 
   port(
        word_in: in std_logic_vector(31 downto 0);
	    word_out: out std_logic_vector(31 downto 0)
     );
   end component;

signal shc0,shc1,shc2,shc3 : std_logic_vector(31 downto 0);--Inv shifted columns
signal c0,c1,c2,c3 : std_logic_vector(31 downto 0);
signal k0,k1,k2,k3 : std_logic_vector(31 downto 0);
signal isb0,isb1,isb2,isb3:std_logic_vector(31 downto 0);
signal w0,w1,w2,w3 : std_logic_vector(31 downto 0);

begin
   Inv_Sub_4bytes_inst1:Inv_Sub_4bytes
   port map(word_in=>shc0 , word_out=>isb0 );
   
   Inv_Sub_4bytes_inst2:Inv_Sub_4bytes
   port map(word_in=>shc1 , word_out=>isb1 );
   
   Inv_Sub_4bytes_inst3:Inv_Sub_4bytes
   port map(word_in=>shc2 , word_out=>isb2 );
   
   Inv_Sub_4bytes_inst4:Inv_Sub_4bytes
   port map(word_in=>shc3 , word_out=>isb3 );
   
   k0 <= key(127 downto 96);
   k1 <= key(95 downto 64);
   k2 <= key(63 downto 32);
   k3 <= key(31 downto 0);
   
   c0 <= state_in(127 downto 96);
   c1 <= state_in(95 downto 64);
   c2 <= state_in(63 downto 32);
   c3 <= state_in(31 downto 0);
   
   shc0 <= c0(31 downto 24) & c3(23 downto 16) & c2(15 downto 8) & c1(7 downto 0);
   shc1 <= c1(31 downto 24) & c0(23 downto 16) & c3(15 downto 8) & c2(7 downto 0);
   shc2 <= c2(31 downto 24) & c1(23 downto 16) & c0(15 downto 8) & c3(7 downto 0);
   shc3 <= c3(31 downto 24) & c2(23 downto 16) & c1(15 downto 8) & c0(7 downto 0);
   
   w0 <= isb0 xor k0;
   w1 <= isb1 xor k1;
   w2 <= isb2 xor k2;
   w3 <= isb3 xor k3;
   
   state_out <= w0 & w1 & w2 & w3;
   
end beh_InvSub_addRk;