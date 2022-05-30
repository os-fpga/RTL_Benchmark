library ieee;
use ieee.std_logic_1164.all;

entity testbench_interlaken_transmitter is
end entity testbench_interlaken_transmitter;

architecture tb_interlaken_transmitter of testbench_interlaken_transmitter is

	signal write_clk   : std_logic;
	signal clk   : std_logic;
	signal reset : std_logic;
	
	signal TX_Data_In 	: std_logic_vector(63 downto 0);
	signal TX_Data_Out : std_logic_vector (66 downto 0); -- later 66 downto 0
	
	signal TX_SOP        	: std_logic;                         -- Start of Packet
	signal TX_EOP_Valid 	: std_logic_vector(2 downto 0);      -- Valid bytes packet contains
	signal TX_EOP        	: std_logic;                         -- End of Packet
	signal TX_Channel    	: std_logic_vector(7 downto 0);      -- Select transmit channel (yet unutilized)
	signal TX_Gearboxready  : std_logic;
	signal TX_Startseq      : std_logic;
	
	signal TX_FlowControl   : std_logic_vector(15 downto 0);
	signal RX_prog_full     : std_logic_vector(15 downto 0);
	
	signal FIFO_Write_Data : std_logic;
    signal FIFO_prog_full  : std_logic;
    signal FIFO_Full       : std_logic;
    
    signal Link_up         : std_logic;
    signal TX_valid_out    : std_logic;
    
    constant CLK_PERIOD : time := 10 ns;

begin
    uut : entity work.interlaken_transmitter 
    port map (
        write_clk   => write_clk,
        clk         => clk,
        reset       => reset,
        
        TX_Data_In  => TX_Data_In,
        TX_Data_Out => TX_Data_Out,
        
        TX_SOP      => TX_SOP,
        TX_EOP_Valid=> TX_ValidBytes,
        TX_EOP      => TX_EOP,
        TX_Channel  => TX_Channel,
        TX_Gearboxready => TX_Gearboxready,
        TX_Startseq => TX_Startseq,
        
        TX_FlowControl => TX_FlowControl,
        RX_prog_full   => RX_prog_full,
        
        FIFO_Write_Data => FIFO_Write_Data,
        FIFO_prog_full  => FIFO_prog_full,
        FIFO_Full       => FIFO_Full,
            
        Link_up         => Link_up,
        TX_valid_out    => TX_valid_out
    );

    Clk_process :process
    begin
        write_clk <= '1';
        clk <= '1';
        wait for CLK_PERIOD/2;  --for half of clock period clk stays at '0'.
        clk <= '0';
        write_clk <= '0';
        wait for CLK_PERIOD/2;  --for next half of clock period clk stays at '1'.
    end process;
    
    simulation : process
    begin
        wait for 1 ps;
        TX_Enable <= '0';
        TX_EOP <= '0';
        TX_SOP <= '0';
        TX_Channel <= X"01";
        TX_ValidBytes <= "111";
        TX_data_in <= (others=>'0');
        reset <= '1';
        TX_FlowControl <= (others => '0');
        
        wait for CLK_PERIOD;
        
        wait for CLK_PERIOD;
        --FIFO_meta <= '1';
        reset <= '0';
        TX_Enable <= '1';
        TX_Data_in <= X"1f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        
        wait for CLK_PERIOD*10;
        TX_SOP <= '1';
        TX_EOP <= '1';
        TX_Data_in <= X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        TX_EOP <= '0';
        TX_data_in <= X"3f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
         
               TX_SOP <= '0';
               TX_EOP <= '0';
        TX_EOP <= '0';
        --reset <= '1';
        TX_Data_in <= X"4f21a2a3a4a5a6a7";
        wait for CLK_PERIOD;
        TX_FlowControl(0) <= '1';
        TX_SOP <= '1';
        TX_data_in <= X"5f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD;
        
        TX_SOP <= '0';
        TX_EOP <= '1';
        TX_data_in  <= X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        TX_EOP <= '0';
        --TX_SOP <= '1';
        TX_data_in  <= X"70000FFF000000F0";
        wait for CLK_PERIOD*2;
        
        TX_SOP <= '1';
        TX_Data_in <= X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
              
        TX_SOP <= '0';
        TX_EOP <= '1';
        wait for CLK_PERIOD;
        
        TX_EOP <= '0';
        TX_data_in  <= X"8050505050050505";      
        wait for CLK_PERIOD;
        
        TX_data_in  <= X"9486576758050505";
        wait for CLK_PERIOD; 
        
        TX_EOP <= '1';                          
        TX_data_in <= X"60b35d5dc4a582a7";
        wait for CLK_PERIOD; --Test influencing pause state position
        
        TX_EOP <= '0';
        wait for CLK_period*16;
        
        TX_SOP <= '1';
        TX_Data_in <= X"4f21a2a3a4a5a6a7";
        --wait for CLK_PERIOD;
        
        TX_data_in <= X"995e5a5c5b60f2a0";      
        wait for CLK_PERIOD;
        
        TX_data_in  <= X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        TX_data_in  <= X"70000FFF000000F0";
        wait for CLK_PERIOD*2;
        
        TX_Data_in <= X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        TX_Data_in <= X"4f21a2a3a4a5a6a7";
        wait for CLK_PERIOD;
        
        TX_data_in <= X"5f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD;
        
        TX_data_in  <= X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        TX_data_in  <= X"70000FFF000000F0";
        wait for CLK_PERIOD*2;
       
        
        TX_data_in <= X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD*12;
        
        TX_Data_in <= X"4f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        TX_SOP <= '0';
        TX_EOP <= '1';
        
        wait;
    end process;

end architecture tb_interlaken_transmitter;


