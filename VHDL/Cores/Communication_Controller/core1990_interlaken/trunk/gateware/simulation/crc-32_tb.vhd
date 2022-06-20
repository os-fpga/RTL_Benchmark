library ieee;
use ieee.std_logic_1164.all;

entity testbenchcrc_32 is
end entity testbenchcrc_32;

architecture tb_CRC_32 of testbenchcrc_32 is


  --for uut : CRC use entity work.CRC(error_check);
    
  constant Nbits :  positive 	:= 64;
  constant CRC_Width          :  positive     := 32;
  constant G_Poly: Std_Logic_Vector :=x"1EDC_6F41"; --c1acf
  constant G_InitVal: std_logic_vector:=x"ffff_ffff";

  signal CRC : std_logic_vector(CRC_Width-1 downto 0);
  signal Calc : std_logic := '0';
  signal Clk : std_logic := '1';
  signal Reset: std_logic := '1';
  signal Din : std_logic_vector(Nbits-1 downto 0);


 constant CLK_PERIOD : time := 10 ns;

begin
  uut : entity work.CRC_32 
  generic map(
    Nbits => Nbits,
    CRC_Width => CRC_Width,
    G_Poly => G_Poly,
    G_InitVal => G_InitVal
  )
  port map (
    CRC => CRC,
    Calc => Calc,
    Reset => Reset,
    Clk => Clk,
    Din => Din
  );

   Clk_process :process
   begin
        Clk <= '1';
        wait for CLK_PERIOD/2;  --for half of clock period clk stays at '0'.
        Clk <= '0';
        wait for CLK_PERIOD/2;  --for next half of clock period clk stays at '1'.
   end process;
   
  simulation : process
  begin
     Din <= (others=>'0');
     wait for CLK_PERIOD*2;
     Reset <= '0';
     Calc <= '1';
     Din <= X"5f5e5d5c5b5a5958";
     --wait for CLK_PERIOD;
     --Din <= X"5f5e5d5c5b5a5958";
     wait for CLK_PERIOD;
     Din <= X"2f5e5d5c5b5a5958";
     wait for CLK_PERIOD;
     Din <= X"9f5e5d5c5b5a5958";
     wait for CLK_PERIOD;
     --Calc <= '0';
     Reset <= '1';
     --Din <= (others=>'0');
     wait for CLK_PERIOD;
     Reset <='0';
     --Calc <= '1';
     wait for CLK_PERIOD;
     Din <= X"aaa5555555554000";                        
     wait for CLK_PERIOD;
     Din  <= X"d721a28c5b5c5959";
     wait for CLK_PERIOD;
     Din <= X"60b35d5dc4a582a7";
     wait;
  end process;
  
end architecture tb_CRC_32;

