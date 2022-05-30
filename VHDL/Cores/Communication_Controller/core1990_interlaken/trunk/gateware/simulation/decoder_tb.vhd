library ieee;
use ieee.std_logic_1164.all;

entity testbench_decoder is
end entity testbench_decoder;

architecture tb_decoder of testbench_decoder is

    signal Clk             : std_logic;                      -- Clock input
    signal Reset		   : std_logic;					     -- Reset decoder
    signal Data_In         :  std_logic_vector(66 downto 0); -- Data input
    signal Decoder_En      :  std_logic;                     -- Enables the decoder
    signal Data_Valid_In   :  std_logic;
    signal Data_Valid_Out  :  std_logic;
    signal Data_Out        :  std_logic_vector(63 downto 0);-- Decoded 64-bit output
    signal Data_Control    :  std_logic;                    --	Indicates whether the word is data or control
    
    signal Sync_Locked  :  std_logic;
    signal Sync_Error	:  std_logic;
    signal Bitslip      :  std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin
    uut : entity work.decoder 
    port map (
        clk => clk,
        reset => reset,
        Decoder_En => Decoder_En,
        
        Data_in => Data_in,
        Data_out => Data_out,
        Data_Valid_In => Data_Valid_In,
        Data_Valid_Out => Data_Valid_Out,
        Data_control => Data_control,
        
        Sync_Locked => Sync_locked,
        Sync_error => Sync_error,
        Bitslip => Bitslip
    );

    Clk_process :process
    begin
        clk <= '1';
        wait for CLK_PERIOD/2;  --for half of clock period clk stays at '0'.
        clk <= '0';
        wait for CLK_PERIOD/2;  --for next half of clock period clk stays at '1'.
    end process;
     
    simulation : process
    begin
        wait for 1 ps;
        decoder_en <= '1';
        reset <= '1';
        data_in <= (others=>'0');
        
        wait for CLK_PERIOD;
        
        wait for CLK_PERIOD;
        
        reset <= '0';
        Data_in <= "101" & X"1f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        
        Data_in <= "101" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        
        data_in <= "101" & X"3f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        
        Data_in <= "101" & X"4f21a2a3a4a5a6a7";
        wait for CLK_PERIOD;
        
        
        data_in <= "101" & X"5f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD;
        
        data_in  <= "001" & X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        data_in  <= "101" & X"70000FFF000000F0";
        wait for CLK_PERIOD*2;
        
        
        Data_in <= "101" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        wait for CLK_PERIOD;
        
        
        data_in  <= "110" & X"8050505050050505";
        wait for CLK_PERIOD*3;                          
        
        data_in  <= "101" & X"9486576758050505";
        wait for CLK_PERIOD; 
        
                           
        data_in <= "101" & X"60b35d5dc4a582a7";
        wait for CLK_PERIOD;
        
        
        data_in <= "101" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD*12;
        
        data_in <= "111" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        Data_in <= "101" & X"1f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        
        Data_in <= "101" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        
        data_in <= "101" & X"3f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        
        Data_in <= "101" & X"4f21a2a3a4a5a6a7";
        wait for CLK_PERIOD;
        
        
        data_in <= "101" & X"5f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD;
        
        data_in  <= "001" & X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        data_in <= "101" & X"5f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD;
        
        data_in  <= "001" & X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        data_in  <= "101" & X"70000FFF000000F0";
        wait for CLK_PERIOD*2;
        
        
        Data_in <= "101" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        data_in  <= "110" & X"8050505050050505";
        wait for CLK_PERIOD*3;                          
        
        data_in  <= "101" & X"9486576758050505";
        wait for CLK_PERIOD; 
                          
        data_in <= "101" & X"60b35d5dc4a582a7";
        wait for CLK_PERIOD*60;
        
        data_in  <= "110" & X"8050505050050505";
        wait for CLK_PERIOD*3;                          
        
        data_in  <= "101" & X"9486576758050505";
        wait for CLK_PERIOD; 
        
                    
        data_in <= "101" & X"60b35d5dc4a582a7";
        wait for CLK_PERIOD;
        
        
        data_in <= "101" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD*12;
        
        data_in <= "111" & X"2c8e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        Data_in <= "101" & X"1f5e5d5c5b5a5958";
        wait for CLK_PERIOD*26;
        
        data_in <= "111" & X"2c8e5d5c5b5a5958";
        wait for CLK_PERIOD*18;
        
        data_in <= "101" & X"1f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        wait;
    end process;
  
end architecture tb_decoder;

