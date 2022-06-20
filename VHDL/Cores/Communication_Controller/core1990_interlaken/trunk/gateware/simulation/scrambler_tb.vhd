library ieee;
use ieee.std_logic_1164.all;

entity testbench_scrambler is
end entity testbench_scrambler;

architecture tb_interlaken_scrambler of testbench_scrambler is
    
    signal Clk				: std_logic := '1';	 -- System clock
    signal Scram_Rst        : std_logic := '1';  -- Scrambler reset, use for initialization
    
    signal Data_In          : std_logic_vector (63 downto 0);-- Data input
    signal Data_Out         : std_logic_vector (63 downto 0);-- Data output
    
    signal Lane_Number      : std_logic_vector (3 downto 0); -- Each lane number starts with different scrambler word  
    signal Scrambler_En     : std_logic;                     -- Input valid
    signal Data_Control_In  : std_logic;                     -- Indicates a control word
    signal Data_Control_Out : std_logic;                     -- Output control word indication
    
    signal Data_Valid_In    : std_logic;                     -- Input valid
    signal Data_Valid_Out   : std_logic;                     -- Output valid
    signal Gearboxready     : std_logic;
    
    constant CLK_PERIOD : time := 10 ns;

begin
    uut : entity work.Scrambler 
    port map (
        clk => clk,
        Scram_Rst => Scram_Rst,
        lane_number => lane_number,
        Data_Control_In => Data_Control_In,
        Data_Control_Out => Data_Control_Out,
        data_in => data_in,
        scram_en => scram_en,
        data_out => data_out,
        Data_Valid_Out => Data_Valid_Out
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
        Data_Valid_Out <= '0';
        Lane_number <= "0001";
        data_in <= (others=>'0');
        wait for CLK_PERIOD*2;
        
        Scram_Rst <= '0';
        scram_en <= '1';
        data_in <= X"5f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        Data_Control_In <= '1';
        Data_In <= X"78f678f678f678f6";
        wait for CLK_PERIOD;
         
        Data_Control_In <= '0';
        data_in <= X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        data_in <= X"9f5e5d5c5b5a5958";
        wait for CLK_PERIOD*2;
        
        data_in <= X"bf21a2a3a4a5a6a7";
        Scram_Rst <= '1';
        wait for CLK_PERIOD;
        
        Scram_Rst <='0';
        wait for CLK_PERIOD;
        
        data_in <= X"2f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD;
        
        data_in  <= X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        data_in <= X"60b35d5dc4a582a7";
        wait for CLK_PERIOD;
        
        data_in <= X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        Data_Control_In <= '1';
        Data_In <= X"78f678f678f678f6";
        wait for CLK_PERIOD;
        
        Data_Control_In <= '0';
        wait for CLK_PERIOD;
        
        wait for CLK_PERIOD;
        
        wait;
    end process;

end architecture tb_interlaken_scrambler;

