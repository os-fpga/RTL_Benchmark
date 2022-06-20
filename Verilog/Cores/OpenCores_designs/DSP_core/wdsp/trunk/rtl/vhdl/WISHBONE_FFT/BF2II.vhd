--Butterfly stage type 2 
--7/17/0 2  
 
library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
 
entity BF2II is 
 
generic (   data_width : INTEGER :=13; 
   add_g: INTEGER :=1 
           ); 
 
port    (   fromreg_r :in std_logic_vector(data_width-1 downto 
0 ); 
   fromreg_i :in std_logic_vector(data_width-1 downto 
0) ; 
     prvs_r :in std_logic_vector(data_width-1-add_g downto 
0) ; 
   prvs_i :in std_logic_vector(data_width-1-add_g downto 0); 
   t : in std_logic; 
   s : in std_logic; 
      toreg_r :out std_logic_vector(data_width                        -1 downto 0); 
  
      toreg_i :out std_logic_vector(data_width                        -1 downto 0);  
    tonext_r :out std_logic_vector(data_width-1 downto 0);    
      tonext_i :out std_logic_vector(data_width-1 downto 0)  
  );  
 
end BF2II; 
 
architecture behavior of  BF2II is 
signal prvs_ext_r  : std_logic_vector(data_width-1 downto 0); 
signal prvs_ext_i : std_logic_vector(data_width-1 downto 0); 
signal add1_out : std_logic_vector(data_width downto 0); 
signal add2_out : std_logic_vector(data_width downto 0); 
signal sub1_out : std_logic_vector(data_width downto 0); 
signal sub2_out : std_logic_vector(data_width downto 0); 
signal swapadd  : std_logic_vector(data_width downto 0); 
signal swapsub  : std_logic_vector(data_width downto 0); 
 
component  adder  
  generic (inst_width:integer); 
        port( 
             inst_A : in std_logic_vector(       data_width-1 downto 0); 
             inst_B : in  std_logic_vector( data_width-1 downto 0); 
             SUM : out std_logic_vector(data_width downto 0)    
                  ); 
end component;

component subtract 
 generic (inst_width:integer); 
         port( 
             inst_A : in std_logic_vector(data_width-1 downto 0); 
             inst_B : in std_logic_vector(data_width-1 downto 0); 
         DIFF : out std_logic_vector(data_width downto 0)   
            ); 
end component; 
 
component mux2_mmw 
 generic (data_width:integer); 
  port(  
   s :  in std_logic; 
       in0:     in std_logic_vector(data_width-1 downto 0); 
      in1: in std_logic_vector(data_width downto 0);  
       data: out std_logic_vector(data_width-1 downto 0) 
                     ); 
end component; 
 
begin 
 
  add1 : adder 
  generic map (inst_width=>data_width) 
  port map (inst_A=>prvs_ext_r, inst_B=>fromreg_r, SUM=>add1_out); 
  
  add2 : adder 
  generic map (inst_width=>data_width) 
  port map (inst_A=>prvs_ext_i, inst_B=>fromreg_i, SUM=>add2_out); 
  
  sub1 : subtract 
  generic map (inst_width=>data_width) 
  port map (inst_A=>fromreg_r, inst_B=>prvs_ext_r, DIFF=>sub1_out);                   
  
  sub2 : subtract 
  generic map (inst_width=>data_width) 
  port map (inst_A=>fromreg_i, inst_B=>prvs_ext_i, DIFF=>sub2_out);                  
   
  mux_1 : mux2_mmw 
  generic map (data_width=>data_width) 
  port map (s=>s, in0=>fromreg_r, in1=>add1_out, data=>tonext_r); 
  
  mux_2 : mux2_mmw 
  generic map       (data_width=>data_width) 
  port map (s=>s, in0=>fromreg_i, in1=>swapadd, data=>tonext_i); 
   
  mux_3 : mux2_mmw 
  generic      map (data_width=>data_width) 
     port map (s=>s, in0=>prvs_ext_r, in1=>sub1_out, data=>toreg_r);   
    
     mux_4 : mux2_mmw 
     generic map (data_width=>data_width) 
     port map (s=>s, in0=>prvs_ext_i, in1=>swapsub, data=>toreg_i); 
process(prvs_r,prvs_i,s,t) 
begin 
     if add_g=1 then 
    if            (t='0' and s='1') then 
      prvs_ext_r <= prvs_i(data_width-2) & prvs_i; 
      prvs_ext_i <= prvs_r(data_width-2) & prvs_r; 
  else 
         prvs_ext_r <=              prvs_r(data_width-2) & prvs_r; 
                     prvs_ext_i <= prvs_i(data_width-2) & prvs_i; 
   end if;   
 else 
    if (t='0' and s='1') then 
    prvs_ext_r <= prvs_i; 
     prvs_ext_i <= prvs_r; 
  else 
   prvs_ext_r <= prvs_r; 
   prvs_ext_i <= prvs_i; 
  end if;  
 end if;   
end process; 
 
process(add2_out, sub2_out, s, t) 
begin 
  if (t='0' and s='1') then 
  swapadd<=sub2_out; 
  swapsub<=add2_out; 
 else 
  swapadd<=add2_out; 
  swapsub<=sub2_out; 
 end   if;
end process; 
end; 
