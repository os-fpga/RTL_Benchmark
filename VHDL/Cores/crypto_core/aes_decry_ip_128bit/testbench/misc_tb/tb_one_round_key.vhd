library ieee;
use ieee.std_logic_1164.all;

entity tb_one_round_key is 
end tb_one_round_key;

architecture beh_tb_one_round_key of tb_one_round_key is
   component one_round_key 
   port(
	    in_key: in std_logic_vector(127 downto 0);
	    out_key: out std_logic_vector(127 downto 0);
	    rcon: in std_logic_vector(7 downto 0)
	   );
    end component;
	
component Sbox 
port (
	data_in: in std_logic_vector(7 downto 0);
	data_out:out std_logic_vector(7 downto 0)
);
end component;

   signal key_in,key_out:std_logic_vector(127 downto 0);
   signal rcon,in_data,out_data:std_logic_vector(7 downto 0);
   
begin
   uut:one_round_key
   port map(in_key=>key_in,out_key=>key_out,rcon=>rcon);
 process
 begin
 wait for 100 ns;
 key_in<=x"000102030405060708090a0b0c0d0e0f";
 rcon<=x"01";  
 wait for 100 ns;
 end process;     
end beh_tb_one_round_key;