library ieee;
use ieee.std_logic_1164.all;

entity testbench_burst is
end entity testbench_burst;

architecture tb_burst of testbench_burst is

    constant BurstMax   : positive := 64; --256
    constant BurstShort : positive := 32;  --512 - 256 - 128 - 64 - 32

	signal clk	 : std_logic;          -- System clock
	signal reset : std_logic;          -- Reset, use for initialization.

	signal TX_Enable : std_logic := '0';                           -- Enable the TX
	signal TX_SOP : std_logic := '0';                              -- Start of Packet
	signal TX_ValidBytes : std_logic_vector(2 downto 0) := "000";    -- Valid bytes packet contains
	signal TX_EOP : std_logic := '0';                              -- End of Packet
	signal TX_FlowControl : std_logic_vector(15 downto 0) := (others => '0');  -- Flow control data (yet unutilized)
	signal TX_Channel    : std_logic_vector(7 downto 0);

	signal Data_in : std_logic_vector(63 downto 0);         -- Input data
	signal Data_out : std_logic_vector(63 downto 0);       -- To scrambling/framing
	signal Data_valid_out : std_logic;						-- Indicate data transmitted is valid
	signal Data_control_out : std_logic;                   -- Control word indication

    signal FIFO_meta : std_logic;
	signal FIFO_read : std_logic; 						-- Request data from the FIFO
	signal FIFO_data : std_logic_vector(9 downto 0);         -- Determines how many bytes have to be transmitted
		


    constant CLK_PERIOD : time := 10 ns;

begin
    uut : entity work.Burst_Framer 
    generic map(
        BurstShort => BurstShort,
        BurstMax => BurstMax
    )
    port map (
        clk => clk,
        reset => reset,
        TX_Enable => TX_Enable,
        TX_SOP => TX_SOP,
        TX_ValidBytes => TX_ValidBytes,
        TX_EOP => TX_EOP,
        TX_FlowControl => TX_FlowControl,
        TX_Channel => TX_Channel,
        Data_in => Data_in,
        Data_out => Data_out,
        Data_valid_out => Data_valid_out,
        Data_control_out => Data_control_out,
        
        FIFO_read => FIFO_read,
        FIFO_meta => FIFO_meta,
        FIFO_data => FIFO_data
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
       TX_SOP <= '0';
       reset <= '1';
       data_in <= (others=>'0');
   
       wait for CLK_PERIOD;
  
       wait for CLK_PERIOD;
       FIFO_meta <= '1';
       reset <= '0';
       TX_Enable <= '1';
       TX_ValidBytes <= "111";
       Data_in <= X"1f5e5d5c5b5a5958";
       wait for CLK_PERIOD;
       
       TX_SOP <= '1';
       TX_EOP <= '1';
       Data_in <= X"2f5e5d5c5b5a5958";
       wait for CLK_PERIOD;
       
       TX_SOP <= '1';
       TX_EOP <= '0';
       data_in <= X"3f5e5d5c5b5a5958";
       wait for CLK_PERIOD;
       
       TX_EOP <= '0';
       --reset <= '1';
       Data_in <= X"4f21a2a3a4a5a6a7";
       wait for CLK_PERIOD;
       
       --reset <= '0';
       data_in <= X"5f5e5a5c5b60f2a0";      
       wait for CLK_PERIOD;
       --TX_EOP <= '1';
       data_in  <= X"635e22a3a4a5a7a7";
       wait for CLK_PERIOD;
       --TX_EOP <= '0';
       --TX_SOP <= '1';
       data_in  <= X"70000FFF000000F0";
       wait for CLK_PERIOD*2;
       
       TX_SOP <= '1';
       Data_in <= X"2f5e5d5c5b5a5958";
       wait for CLK_PERIOD;
              
       TX_SOP <= '0';
       TX_EOP <= '1';
       wait for CLK_PERIOD;
       
       TX_EOP <= '0';
       --TX_SOP <= '0';
       data_in  <= X"8050505050050505";
       wait for CLK_PERIOD*3;                          
  
       data_in  <= X"9486576758050505";
       wait for CLK_PERIOD; 
       
       TX_EOP <= '1';                          
       data_in <= X"60b35d5dc4a582a7";
       wait for CLK_PERIOD;
       
       TX_EOP <= '0';
       TX_SOP <= '1';
       data_in <= X"2f5e5d5c5b5a5958";
       wait for CLK_PERIOD*6;
       
       FIFO_meta<= '0';
       wait for CLK_PERIOD;
       FIFO_meta<= '1';
       wait for CLK_PERIOD*6;
       TX_SOP <= '0';
       TX_EOP <= '1';
       wait for CLK_PERIOD;
       
       FIFO_meta <= '0';
       wait for CLK_PERIOD*4;
       FIFO_meta <= '1';
       wait;
    end process;
  
end architecture tb_burst;

