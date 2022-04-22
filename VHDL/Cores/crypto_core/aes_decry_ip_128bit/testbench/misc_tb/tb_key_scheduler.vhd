library ieee;
use ieee.std_logic_1164.all;

entity tb_key_schedular is
end tb_key_schedular;

architecture beh_tb_key_schedular of tb_key_schedular is

   component key_scheduler 
   port(
        key_in  : in std_logic_vector(127 downto 0);
   	 key_out : out std_logic_vector(127 downto 0);
   	 valid_in : in std_logic;--Input key is valid
   	 key_ready : out std_logic;
   	 round: in std_logic_vector(3 downto 0);
   	 clk,reset: in std_logic
       );
   end component; 
   
   constant clk_period: time := 10 ns;
   signal key_in,key_out:std_logic_vector(127 downto 0);
   signal valid_in,key_ready,reset,clk : std_logic;
   signal round : std_logic_vector(3 downto 0);
   
begin

  uut:key_scheduler
  port map(key_in=>key_in,key_out=>key_out,valid_in=>valid_in,key_ready=>key_ready,round=>round,reset=>reset,clk=>clk);
  
  clk_process:process
  begin
     clk<='1';
     wait for clk_period/2;
     clk<='0';
	 wait for clk_period/2;
  end process;
  
  stimulus:process
  begin
     reset<='1';
	 valid_in<='0';
	 round <=(others =>'0');
	 
	 wait for 5*clk_period;
	 reset<='0';
	 
	 wait for 2 ns;
	 valid_in <= '1';
	 key_in<=x"000102030405060708090a0b0c0d0e0f";
     
     wait until key_ready <= '1';
     wait for clk_period;
     round <= "0000";
	 
	 wait for clk_period;
     round <= "0001";
	 
	 wait for clk_period;
     round <= "0010";
	 
	 wait for clk_period;
     round <= "0011";
	
	 wait for clk_period;
     round <= "0100";
	 
	 wait for clk_period;
     round <= "0101";
	 
	 wait for clk_period;
     round <= "0110";
	 
	 wait for clk_period;
     round <= "0111";
	 
	 wait for clk_period;
     round <= "1000";
	 
	 wait for clk_period;
     round <= "1001";
	 
	 wait for clk_period;
     round <= "1010";
	 
	 wait for 20*clk_period;
	 round <= "1000";
     wait;	 
	 
  end process;

end beh_tb_key_schedular;