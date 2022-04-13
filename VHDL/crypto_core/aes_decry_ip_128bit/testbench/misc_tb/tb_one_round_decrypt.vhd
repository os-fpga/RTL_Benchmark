library ieee;
use ieee.std_logic_1164.all;

entity tb_one_round_decrypt is 
end tb_one_round_decrypt;

architecture beh_tb_one_round_decrypt of tb_one_round_decrypt is
   component one_round_decrypt
      port(
             cipher : in std_logic_vector(127 downto 0);
   		     text_out: out std_logic_vector(127 downto 0);
   		     round_key: in std_logic_vector(127 downto 0)
          );
   end component;
   signal cipher,text_out: std_logic_vector(127 downto 0);
   signal round_key:std_logic_vector(127 downto 0);
begin
    uut:one_round_decrypt
	port map(cipher=>cipher,text_out=>text_out,round_key=>round_key);
	
	process
	begin
	   wait for 50 ns;
	   cipher<=x"7ad5fda789ef4e272bca100b3d9ff59f";
	   round_key<=x"549932d1f08557681093ed9cbe2c974e";
	   wait for 10 ns;
	   cipher<=x"b458124c68b68a014b99f82e5f15554c";
	   round_key<=x"5e390f7df7a69296a7553dc10aa31f6b";
	   wait;
	end process;
	

end beh_tb_one_round_decrypt;