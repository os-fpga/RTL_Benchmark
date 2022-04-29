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
-- One round of decryption is done
--Logic type : Combinational
--*************************************************************

library ieee;
use ieee.std_logic_1164.all;

entity one_round_decrypt is
   port(
          cipher : in std_logic_vector(127 downto 0);
		  text_out: out std_logic_vector(127 downto 0);
		  round_key: in std_logic_vector(127 downto 0)
       );
end one_round_decrypt;    

architecture beh_one_round_decrypt of one_round_decrypt is

component InvSub_addRk 
   port(
        state_in : in std_logic_vector(127 downto 0);
        state_out : out std_logic_vector(127 downto 0);
		key : in std_logic_vector(127 downto 0)
         );
end component;

component inv_mix_column
   port(
           column: in std_logic_vector(31 downto 0);
		   p0,p1,p2,p3: out std_logic_vector(31 downto 0)
        );
end component;

signal p00,p01,p02,p03,
       p10,p11,p12,p13,
	   p20,p21,p22,p23,
	   p30,p31,p32,p33:std_logic_vector(31 downto 0);
	   
signal c0,c1,c2,c3:std_logic_vector(31 downto 0);
signal out0,out1,out2,out3: std_logic_vector(31 downto 0);
signal t0,t1,t2,t3:std_logic_vector(31 downto 0);
signal state_out: std_logic_vector(127 downto 0);

begin
    InvSub_addRk_inst:InvSub_addRk
	port map(state_in=>cipher,state_out=>state_out,key=>round_key);
	
	inv_mix_column_inst0:inv_mix_column
	port map(column=>c0,p0=>p00,p1=>p01,p2=>p02,p3=>p03);
	
	inv_mix_column_inst1:inv_mix_column
	port map(column=>c1,p0=>p10,p1=>p11,p2=>p12,p3=>p13);
	
	inv_mix_column_inst2:inv_mix_column
	port map(column=>c2,p0=>p20,p1=>p21,p2=>p22,p3=>p23);
	
	inv_mix_column_inst3:inv_mix_column
	port map(column=>c3,p0=>p30,p1=>p31,p2=>p32,p3=>p33);
	
	c0<=state_out(127 downto 96);
	c1<=state_out(95 downto 64);
	c2<=state_out(63 downto 32);
	c3<=state_out(31 downto 0);
	
	out0 <= p00 xor p01 xor p02 xor p03;
	out1 <= p10 xor p11 xor p12 xor p13;
	out2 <= p20 xor p21 xor p22 xor p23;
	out3 <= p30 xor p31 xor p32 xor p33;
	
	text_out<=out0 & out1 & out2 & out3;
	
end  beh_one_round_decrypt;