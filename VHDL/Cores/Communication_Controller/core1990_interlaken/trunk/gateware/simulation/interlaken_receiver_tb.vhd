library ieee;
use ieee.std_logic_1164.all;

entity testbench_interlaken_receiver is
end entity testbench_interlaken_receiver;

architecture tb_interlaken_receiver of testbench_interlaken_receiver is
    
    signal fifo_read_clk   : std_logic;
    signal clk   		    : std_logic;
    signal reset 		    : std_logic;
    
    signal RX_Data_In 	: std_logic_vector(66 downto 0);
    signal RX_Data_Out  : std_logic_vector (63 downto 0);        -- Data ready to transmit
    
    signal RX_Valid_Out : std_logic;
    
    signal RX_SOP        	: std_logic;                         -- Start of Packet
    signal RX_EOP_Valid 	: std_logic_vector(2 downto 0);      -- Valid bytes packet contains
    signal RX_EOP        	: std_logic;                         -- End of Packet
    signal RX_FlowControl	: std_logic_vector(15 downto 0);     -- Flow control data (yet unutilized)
    signal RX_prog_full     : std_logic_vector(15 downto 0);      -- Indication FIFO of this channel is full
    signal RX_Channel    	: std_logic_vector(7 downto 0);      -- Select transmit channel (yet unutilized)
    signal RX_Datavalid     : std_logic;
    
    signal CRC24_Error       : std_logic;
    signal CRC32_Error       : std_logic;
    signal Decoder_lock      : std_logic;
    signal Descrambler_lock  : std_logic;
    
    signal Data_Descrambler : std_logic_vector(63 downto 0);
    signal Data_Decoder     : std_logic_vector(63 downto 0);
    
    signal RX_FIFO_Full     : std_logic;
    signal RX_FIFO_Read     : std_logic;
    
    signal RX_Link_Up      : std_logic;
    signal Bitslip         : std_logic;
	
	constant CLK_PERIOD : time := 10 ns;

begin
    uut : entity work.interlaken_receiver
    port map (
        write_clk => write_clk,
        clk => clk,
        reset => reset,
        RX_Data_In => RX_Data_In,
        RX_Data_Out => RX_Data_Out,
        RX_Enable => RX_Enable,
        RX_SOP => RX_SOP,
        RX_ValidBytes => RX_ValidBytes,
        RX_EOP => RX_EOP,
        RX_FlowControl => RX_FlowControl,
        RX_Channel => RX_Channel,
        
        RX_Link_Up => RX_Link_Up 
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
        RX_Data_In <= (others=>'0');
        reset <= '1';
        wait for CLK_PERIOD*2;
        
        reset <= '0';
        reset <= '0';
        RX_Data_in <= "101" & X"1f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "101" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "101" & X"3f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "101" & X"4f21a2a3a4a5a6a7";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "101" & X"5f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD;
        
        RX_Data_In  <= "001" & X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        RX_Data_In  <= "101" & X"70000FFF000000F0";
        wait for CLK_PERIOD*2;
        
        
        RX_Data_In <= "101" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD*2;
        
        RX_Data_In  <= "110" & X"8050505050050505";
        wait for CLK_PERIOD*3;                          
        
        RX_Data_In  <= "101" & X"9486576758050505";
        wait for CLK_PERIOD; 
                           
        RX_Data_In <= "101" & X"60b35d5dc4a582a7";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "101" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD*12;
        
        RX_Data_In <= "111" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "101" & X"1f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"5f5e5a5c5b60f2a0";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"70000FFF000000F0";
        wait for CLK_PERIOD*21;
        
        RX_Data_In <= "001" & X"78f6_78f6_78f6_78f6"; --Sync & 
        wait for CLK_PERIOD;
        
        RX_Data_In <= "101" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "101" & X"3f5e5d5c5b5a5958";
        wait for CLK_PERIOD;        
        
        RX_Data_In <= "101" & X"4f21a2a3a4a5a6a7";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "101" & X"5f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD;
        
        RX_Data_In  <= "001" & X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        RX_Data_In  <= "101" & X"70000FFF000000F0";
        wait for CLK_PERIOD*2;
        
        RX_Data_In <= "001" & X"2Bfe_d100_19e0_1dbd";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"70000FFF000000F0";
        wait for CLK_PERIOD*2;
        
        RX_Data_In <= "001" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "101" & X"3f5e5d5c5b5a5958";
        wait for CLK_PERIOD*10;
        

        RX_Data_In <= "001" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"8050505050050505";
        wait for CLK_PERIOD*3;                          
        
        RX_Data_In <= "001" & X"9486576758050505";
        wait for CLK_PERIOD; 

        
        RX_Data_In <= "101" & X"4f21a2a3a4a5a6a7";
        wait for CLK_PERIOD*20;
        
        RX_Data_In <= "101" & X"5f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD*10;
        
        RX_Data_In  <= "001" & X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "101" & X"5f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD;
        
        RX_Data_In  <= "001" & X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        RX_Data_In  <= "101" & X"70000FFF000000F0";
        wait for CLK_PERIOD*6;
        
        RX_Data_In <= "001" & X"8050505050050505";
        wait for CLK_PERIOD*9;   
        
        RX_Data_In <= "101" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In  <= "110" & X"8050505050050505";
        wait for CLK_PERIOD*3;                          
        
        RX_Data_In  <= "101" & X"9486576758050505";
        wait for CLK_PERIOD; 
        
        RX_Data_In <= "001" & X"1f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "010" & X"78f6_78f6_78f6_78f6"; --1
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"3f5e5d5c5b5a5958";
        wait for CLK_PERIOD*23;
        
        RX_Data_In <= "010" & X"78f6_78f6_78f6_78f6";--2
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"5f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD*23;
        
        RX_Data_In <= "010" & X"78f6_78f6_78f6_78f6";--3
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"70000FFF000000F0";
        wait for CLK_PERIOD*23;
       
        RX_Data_In <= "010" & X"78f6_78f6_78f6_78f6";--4 -> lock
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"5f5e5a5c5b60f2a0";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"70000FFF000000F0";
        wait for CLK_PERIOD*21;
        
        RX_Data_In <= "010" & X"78f6_78f6_78f6_78f6"; --Sync & 
        wait for CLK_PERIOD;
        
        RX_Data_In <= "010" & X"2Bfe_d100_19e0_1dbd";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "010" & X"1e1e_1e1e_1e1e_1e1e";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"70000FFF000000F0";
        wait for CLK_PERIOD*2;
        
        RX_Data_In <= "010" & X"E000_0001_0000_0000";
        wait for CLK_PERIOD*3;
        
        RX_Data_In <= "001" & X"9486576758050505";
        wait for CLK_PERIOD; 
                          
        RX_Data_In <= "001" & X"60b35d5dc4a582a7";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD*5;
        
        RX_Data_In <= "001" & X"1f5e5d5c5b5a5958";
        wait for CLK_PERIOD*3;
               
        RX_Data_In <= "010" & X"6400_0000_6222_431a";
        wait for clk_period;
        
        RX_Data_In <= "001" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"9486576758050505";
        wait for CLK_PERIOD*19; 
        
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"8050505050050505";
        wait for CLK_PERIOD*3;                          
        
        RX_Data_In <= "001" & X"9486576758050505";
        wait for CLK_PERIOD; 
                           
        RX_Data_In <= "001" & X"60b35d5dc4a582a7";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD*12;
        
        RX_Data_In <= "001" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"1f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        
        RX_Data_In <= "001" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"3f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"4f21a2a3a4a5a6a7";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"5f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"5f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"70000FFF000000F0";
        wait for CLK_PERIOD*2;
        
        RX_Data_In <= "001" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "001" & X"8050505050050505";
        wait for CLK_PERIOD*3;                          
        
        RX_Data_In <= "001" & X"9486576758050505";
        wait for CLK_PERIOD; 
                          
        RX_Data_In <= "001" & X"60b35d5dc4a582a7";
        wait for CLK_PERIOD*60;
        
        RX_Data_In <= "001" & X"8050505050050505";
        wait for CLK_PERIOD*3;                          
        
        RX_Data_In <= "001" & X"9486576758050505";
        wait for CLK_PERIOD; 
                    
        RX_Data_In <= "001" & X"60b35d5dc4a582a7";
        wait for CLK_PERIOD;
                          
        RX_Data_In <= "101" & X"60b35d5dc4a582a7";
        wait for CLK_PERIOD*60;
        
        RX_Data_In  <= "110" & X"8050505050050505";
        wait for CLK_PERIOD*3;                          
        
        RX_Data_In  <= "101" & X"9486576758050505";
        wait for CLK_PERIOD; 
                    
        RX_Data_In <= "101" & X"60b35d5dc4a582a7";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "101" & X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD*12;
        
        RX_Data_In <= "111" & X"2c8e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        RX_Data_In <= "101" & X"1f5e5d5c5b5a5958";
        wait for CLK_PERIOD*26;
        
        RX_Data_In <= "111" & X"2c8e5d5c5b5a5958";
        wait for CLK_PERIOD*18;
        
        RX_Data_In <= "101" & X"1f5e5d5c5b5a5958";
        wait;
        
    end process;

end architecture tb_interlaken_receiver;


