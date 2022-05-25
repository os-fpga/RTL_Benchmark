library ieee;
use ieee.std_logic_1164.all;

entity testbench_interlaken_interface is
end entity testbench_interlaken_interface;

architecture tb_interlaken_interface of testbench_interlaken_interface is
    
    constant   TX_REFCLK_PERIOD        :   time :=  8.0 ns;
    constant   RX_REFCLK_PERIOD        :   time :=  8.0 ns;
    constant   SYSCLK_PERIOD           :   time :=  25.0 ns;    
    constant   DCLK_PERIOD             :   time :=  5.0 ns;

    signal System_Clock_In_P : std_logic;
    signal System_Clock_In_N : std_logic;
    
    signal GTREFCLK_IN_P : std_logic;
    signal GTREFCLK_IN_N : std_logic;

    signal Reset 		: std_logic;
    
    signal TX_Data 	: std_logic_vector(63 downto 0);          -- Data transmitted
    signal RX_Data  : std_logic_vector (63 downto 0);        -- Data received
    
    signal TX_Out_P     : std_logic;
    signal TX_Out_N     : std_logic;
    signal RX_In_P      : std_logic;
    signal RX_In_N      : std_logic;
    
    signal TX_Link_Up      : std_logic;                         -- In case signal is high transmission may start
    signal TX_SOP          : std_logic;
    signal TX_EOP          : std_logic;
    signal TX_EOP_Valid    : std_logic_vector(2 downto 0);
    signal TX_FlowControl  : std_logic_vector(15 downto 0);
    signal TX_Channel      : std_logic_vector(7 downto 0);
    
    signal RX_SOP        	: std_logic;                         -- Start of Packet
    signal RX_EOP        	: std_logic;                         -- End of Packet
    signal RX_EOP_Valid 	: std_logic_vector(2 downto 0);      -- Valid bytes packet contains
    signal RX_FlowControl	: std_logic_vector(15 downto 0);     -- Flow control data (yet unutilized)
    signal RX_Channel    	: std_logic_vector(7 downto 0);      -- Select transmit channel (yet unutilized)
    
    signal RX_Link_Up       : std_logic;
    
    signal TX_Overflow      : std_logic;
    signal TX_Underflow     : std_logic;
    
    signal RX_FIFO_Full      : std_logic;
    signal RX_FIFO_Empty     : std_logic;
    signal Decoder_lock      : std_logic;
    signal Descrambler_lock  : std_logic;
    signal CRC24_Error       : std_logic;
    signal CRC32_Error       : std_logic;
	
begin
    RX_In_N <=  TX_Out_N;
    RX_In_P <=  TX_Out_P;  
    
    uut : entity work.interlaken_interface
    port map (
        System_Clock_In_P => System_Clock_In_P,
        System_Clock_In_N => System_Clock_In_N,
        GTREFCLK_IN_P => GTREFCLK_IN_P,
        GTREFCLK_IN_N => GTREFCLK_IN_N,
        
        reset => reset,
        
        TX_Data => TX_Data,
        RX_Data => RX_Data,
        
        RX_In_N => RX_In_N,
        RX_In_P => RX_In_P,  
        TX_Out_N => TX_Out_N,
        TX_Out_P => TX_Out_P,  
        
        TX_Link_Up => TX_Link_Up,
        TX_SOP => TX_SOP,
        TX_EOP => TX_EOP,
        TX_EOP_Valid => TX_EOP_Valid,
        TX_FlowControl => TX_FlowControl,
        TX_Channel => TX_Channel,
        
        RX_SOP => RX_SOP, 
        RX_EOP => RX_EOP,
        RX_EOP_Valid => RX_EOP_Valid,
        RX_FlowControl => RX_FlowControl,
        RX_Channel => RX_Channel,
        
        RX_Link_Up => RX_Link_Up,
        
        TX_Overflow => TX_Overflow,
        TX_Underflow => TX_Underflow,
        
        RX_FIFO_Full => RX_FIFO_Full,
        RX_FIFO_Empty => RX_FIFO_Empty,
        Decoder_lock => Decoder_lock,
        Descrambler_lock => Descrambler_lock,
        CRC24_Error => CRC24_Error,
        CRC32_Error => CRC32_Error
    );
    
    process
    begin
        GTREFCLK_IN_N  <=  '1';
        wait for TX_REFCLK_PERIOD/2;
        GTREFCLK_IN_N  <=  '0';
        wait for TX_REFCLK_PERIOD/2;
    end process;

    GTREFCLK_IN_P <= not GTREFCLK_IN_N;
    
    process
    begin
        rx_refclk_n_r  <=  '1';
        wait for RX_REFCLK_PERIOD/2;
        rx_refclk_n_r  <=  '0';
        wait for RX_REFCLK_PERIOD/2;
    end process;

    rx_refclk_p_r <= not rx_refclk_n_r;
    
    process
    begin
        System_Clock_In_N  <=  '1';
        wait for DCLK_PERIOD/2;
        System_Clock_In_N  <=  '0';
        wait for DCLK_PERIOD/2;
    end process;
    
    System_Clock_In_P <= not System_Clock_In_N;

               
    
    simulation : process
    begin
        wait for 1 ps;
            --TX_Enable <= '0';
        TX_EOP <= '0';
        TX_SOP <= '0';
        TX_Channel <= X"01";
        TX_EOP_Valid <= "111";
        TX_Data <= (others=>'0');
        reset <= '1';
        TX_FlowControl <= (others => '0');
        
        wait for 20*SYSCLK_PERIOD;
        
        wait for SYSCLK_PERIOD;
        reset <= '0';
        --TX_SOP <= '1';
        --TX_Enable <= '1';
        TX_Data <= X"1f5e5d5c5b5a5958";
        wait for SYSCLK_PERIOD;
        --TX_EOP <= '1';
        
        wait until (TX_Link_Up = '1');
    
        wait for SYSCLK_PERIOD*10;
        TX_FlowControl(0) <= '1';
        TX_SOP <= '1';
        TX_EOP <= '1';
        TX_Data <= X"2f5e5d5c5b5a5958";
        wait for SYSCLK_PERIOD;
        
        TX_EOP <= '0';
        TX_Data <= X"3f5e5d5c5b5a5958";
        wait for SYSCLK_PERIOD;
        
         
        TX_SOP <= '0';
        TX_EOP <= '0';
        TX_EOP <= '0';
        --reset <= '1';
        TX_Data <= X"4f21a2a3a4a5a6a7";
        wait for SYSCLK_PERIOD;
--        TX_FlowControl(0) <= '1';
        TX_SOP <= '1';
        TX_Data <= X"5f5e5a5c5b60f2a0";      
        wait for SYSCLK_PERIOD;
        
        TX_SOP <= '0';
        TX_EOP <= '1';
        TX_Data  <= X"635e22a3a4a5a7a7";
        wait for SYSCLK_PERIOD;
        
        TX_EOP <= '0';
        --TX_SOP <= '1';
        TX_Data  <= X"70000FFF000000F0";
        wait for SYSCLK_PERIOD*2;
        
        TX_SOP <= '1';
        TX_Data <= X"2f5e5d5c5b5a5958";
        wait for SYSCLK_PERIOD;
              
        TX_SOP <= '0';
        TX_EOP <= '1';
        wait for SYSCLK_PERIOD;
        
        TX_EOP <= '0';
        --TX_SOP <= '0';
        TX_Data  <= X"8050505050050505";
        --wait for SYSCLK_PERIOD*3;                          
        wait for SYSCLK_PERIOD;
        TX_Data  <= X"9486576758050505";
        wait for SYSCLK_PERIOD; 
        
        TX_EOP <= '1';                          
        TX_Data <= X"60b35d5dc4a582a7";
        wait for SYSCLK_PERIOD; --Test influencing pause state position
        
        TX_EOP <= '0';
        wait for SYSCLK_PERIOD*16;
        
        TX_SOP <= '1';
        TX_Data <= X"4f21a2a3a4a5a6a7";
        wait for SYSCLK_PERIOD;
        
        TX_Data <= X"995e5a5c5b60f2a0";      
        wait for SYSCLK_PERIOD;
        
        TX_Data  <= X"635e22a3a4a5a7a7";
        wait for SYSCLK_PERIOD;
        
        TX_Data  <= X"70000FFF000000F0";
        wait for SYSCLK_PERIOD*2;
        
        TX_Data <= X"2f5e5d5c5b5a5958";
        wait for SYSCLK_PERIOD;
        
        TX_Data <= X"4f21a2a3a4a5a6a7";
        wait for SYSCLK_PERIOD;
        
        TX_Data <= X"5f5e5a5c5b60f2a0";      
        wait for SYSCLK_PERIOD;
        
        TX_Data  <= X"635e22a3a4a5a7a7";
        wait for SYSCLK_PERIOD;
        
        TX_Data  <= X"70000FFF000000F0";
        wait for SYSCLK_PERIOD*2;
        
        
        TX_Data <= X"2f5e5d5c5b5a5958";
        wait for SYSCLK_PERIOD*12;
        
        TX_Data <= X"4f5e5d5c5b5a5958";
        wait for SYSCLK_PERIOD;
        
        TX_SOP <= '0';
        TX_EOP <= '1';
        wait for SYSCLK_PERIOD;
        
        wait for SYSCLK_PERIOD*4;
        wait;
    end process;

end architecture tb_interlaken_interface;


