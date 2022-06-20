library ieee;
use ieee.std_logic_1164.all;

entity testbench_meta is
end entity testbench_meta;

architecture tb_meta of testbench_meta is
    signal clk   : std_logic;
    signal reset : std_logic;
    
    signal TX_Enable : std_logic;
    
    signal HealthLane       : std_logic;                      -- Lane status bit transmitted in diagnostic
    signal HealthInterface  : std_logic;                      -- Interface status bit transmitted in diagnostic
    
    signal Data_In          : std_logic_vector(63 downto 0);  -- Input data
    signal Data_Out         : std_logic_vector(63 downto 0); -- To scrambling/framing
    signal Data_Valid_In    : std_logic;				      -- Indicate data received is valid
    signal Data_Valid_Out   : std_logic;				      -- Indicate data transmitted is valid
    signal Data_Control_In  : std_logic;                      -- Control word indication from the burst component
    signal Data_Control_Out : std_logic;                     -- Control word indication
    
    signal Gearboxready : std_logic;
    signal FIFO_read    : std_logic;
    	
    constant CLK_PERIOD : time := 10 ns;

begin
    uut : entity work.Meta_Framer 
    port map (
        clk => clk,
        reset => reset,
        
        TX_Enable => TX_Enable,
        
        HealthLane => HealthLane,
        HealthInterface => HealthInterface,
        
        Data_in => Data_in,
        Data_out => Data_out,
        Data_valid_in => Data_valid_in,
        Data_valid_out => Data_valid_out,
        Data_control_in => Data_control_in,
        Data_control_out => Data_control_out,
        
        Gearboxready => Gearboxready,
        FIFO_read => FIFO_read
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
        
        reset <= '1';
        data_in <= (others=>'0');
        
        wait for CLK_PERIOD;
        
        wait for CLK_PERIOD;
        
        Gearboxready <= '1';
        reset <= '0';
        TX_Enable <= '1';
        Data_valid_in <= '1';
        Data_in <= X"1f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        
        Data_in <= X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        
        data_in <= X"3f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        Data_in <= X"4f21a2a3a4a5a6a7";
        wait for CLK_PERIOD;
        
        
        data_in <= X"5f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD;
        
        data_in  <= X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        data_in  <= X"70000FFF000000F0";
        wait for CLK_PERIOD*2;
        
        Data_in <= X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        Gearboxready <= '0';
        data_in  <= X"8050505050050505";
        wait for CLK_PERIOD*2; 
                              
        Gearboxready <= '1';
        data_in  <= X"9486576758050505";
        wait for CLK_PERIOD; 
                         
        data_in <= X"60b35d5dc4a582a7";
        wait for CLK_PERIOD;
        
        data_in <= X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        data_in <= X"5f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD;
        
        data_in  <= X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        data_in  <= X"70000FFF000000F0";
        wait for CLK_PERIOD*2;
        
        Data_in <= X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        data_in  <= X"8050505050050505";
        wait for CLK_PERIOD*3;                          
        
        data_in  <= X"9486576758050505";
        wait for CLK_PERIOD; 
                         
        data_in <= X"60b35d5dc4a582a7";
        wait for CLK_PERIOD;
        
        data_in <= X"5f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD;
        
        data_in  <= X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        data_in  <= X"70000FFF000000F0";
        wait for CLK_PERIOD*2;
        
        Data_in <= X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        data_in  <= X"8050505050050505";
        
        wait;
    end process;
  
end architecture tb_meta;

