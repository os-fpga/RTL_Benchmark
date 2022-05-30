library ieee;
use ieee.std_logic_1164.all;

entity testbench_descrambler is
end entity testbench_descrambler;

architecture tb_descrambler of testbench_descrambler is

    signal Clk          : std_logic;                     -- Interface clock
	signal Reset		: std_logic;					 -- Descrambler reset, use for initialization
	
	signal Data_In      : std_logic_vector(63 downto 0); -- Data input
	signal Data_Out     : std_logic_vector(63 downto 0); -- Data output
	
	signal Lane_Number      : std_logic_vector (3 downto 0); -- Each lane number starts with different scrambler word
	signal Data_Control_In  : std_logic;                    --	Indicates a control word
	signal Data_Control_Out : std_logic;                    -- Output control word indication
    signal Data_Valid_In    : std_logic;                    -- Only valid data will be processed
    signal Data_Valid_Out   : std_logic;
    signal Lock             : std_logic;
    	
	signal Error_BadSync  		: std_logic;
	signal Error_StateMismatch	: std_logic;
	signal Error_NoSync			: std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin
    uut : entity work.Descrambler 
    port map (
        clk => clk,
        reset => reset,
        
        Data_in => Data_in,
        Data_out => Data_out,
        
        Lane_Number => Lane_Number,
        Data_control_In  => Data_control_In,
        Data_control_Out => Data_control_Out,
        Data_valid_in  => Data_valid_in,
        Data_valid_out => Data_valid_out,
        Lock           => Lock,
        
        Error_BadSync => Error_BadSync,
        Error_StateMismatch => Error_StateMismatch,
        Error_NoSync => Error_NoSync
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
        Data_Control_In <= '0';
        reset <= '1';
        Lane_Number <= "0001";
        data_in <= (others=>'0');
        
        wait for CLK_PERIOD;
        
        wait for CLK_PERIOD;
        
        reset <= '0';
        Data_in <= X"1f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        Data_Control_In <= '1';
        Data_in <= X"78f6_78f6_78f6_78f6"; --1
        wait for CLK_PERIOD;
        
        Data_Control_In <= '0';
        data_in <= X"3f5e5d5c5b5a5958";
        wait for CLK_PERIOD*23;
        
        Data_Control_In <= '1';
        Data_in <= X"78f6_78f6_78f6_78f6";--2
        wait for CLK_PERIOD;
        
        Data_Control_In <= '0';
        data_in <= X"5f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD*23;
        
        Data_Control_In <= '1';
        data_in  <= X"78f6_78f6_78f6_78f6";--3
        wait for CLK_PERIOD;
        
        Data_Control_In <= '0';
        data_in  <= X"70000FFF000000F0";
        wait for CLK_PERIOD*23;
        
        Data_Control_In <= '1';
        data_in  <= X"78f6_78f6_78f6_78f6";--4 -> lock
        wait for CLK_PERIOD;
        
        data_in  <= X"5f5e5a5c5b60f2a0";
        wait for CLK_PERIOD;
        
        data_in  <= X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        Data_Control_In <= '0';
        data_in  <= X"70000FFF000000F0";
        wait for CLK_PERIOD*21;
        
        Data_Control_In <= '1';
        data_in  <= X"78f6_78f6_78f6_78f6"; --Sync & 
        wait for CLK_PERIOD;
        
        Data_In  <= X"2Bfe_d100_19e0_1dbd";
        wait for CLK_PERIOD;
        
        Data_Control_In <= '0';
        data_in  <= X"70000FFF000000F0";
        wait for CLK_PERIOD*2;
        
        Data_Control_In <= '1';
        Data_in <= X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        Data_Control_In <= '0';
        data_in  <= X"9486576758050505";
        wait for CLK_PERIOD*19; 
        
        wait for CLK_PERIOD;
        
        
        data_in  <= X"8050505050050505";
        wait for CLK_PERIOD*3;                          
        
        data_in  <= X"9486576758050505";
        wait for CLK_PERIOD; 
        
                           
        data_in <= X"60b35d5dc4a582a7";
        wait for CLK_PERIOD;
        
        
        data_in <= X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD*12;
        
        data_in <= X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
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
        
        data_in <= X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        data_in <= X"5f5e5a5c5b60f2a0";      
        wait for CLK_PERIOD;
        
        data_in <= X"635e22a3a4a5a7a7";
        wait for CLK_PERIOD;
        
        data_in <= X"70000FFF000000F0";
        wait for CLK_PERIOD*2;
        
        
        Data_in <= X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        data_in  <= X"8050505050050505";
        wait for CLK_PERIOD*3;                          
        
        data_in  <= X"9486576758050505";
        wait for CLK_PERIOD; 
                          
        data_in <= X"60b35d5dc4a582a7";
        wait for CLK_PERIOD*60;
        
        data_in  <= X"8050505050050505";
        wait for CLK_PERIOD*3;                          
        
        data_in  <= X"9486576758050505";
        wait for CLK_PERIOD; 
        
                    
        data_in <= X"60b35d5dc4a582a7";
        wait for CLK_PERIOD;
        
        
        data_in <= X"2f5e5d5c5b5a5958";
        wait for CLK_PERIOD*12;
        
        data_in <= X"2c8e5d5c5b5a5958";
        wait for CLK_PERIOD;
        
        Data_in <= X"1f5e5d5c5b5a5958";
        wait for CLK_PERIOD*26;
        
        data_in <= X"2c8e5d5c5b5a5958";
        wait for CLK_PERIOD*18;
        
        data_in <= X"1f5e5d5c5b5a5958";
        wait for CLK_PERIOD;
        wait;
    end process;
  
end architecture tb_descrambler;

