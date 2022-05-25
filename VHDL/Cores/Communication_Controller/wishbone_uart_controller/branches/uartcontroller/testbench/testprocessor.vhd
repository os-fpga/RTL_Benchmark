--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:07:53 05/23/2013
-- Design Name:   
-- Module Name:   C:/Users/boris/Documents/projects/usb_io_processor/test_IOprocessor.vhd
-- Project Name:  usb_io_processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: processor
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_IOprocessor IS
END test_IOprocessor;
 
ARCHITECTURE behavior OF test_IOprocessor IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT processor
    PORT(
         ACK_I : IN  std_logic;
         CLK_I : IN  std_logic;
         DAT_I : IN  std_logic_vector(7 downto 0);
         RST_I : IN  std_logic;
         ADR_O : OUT  std_logic_vector(7 downto 0);
         CYC_O : OUT  std_logic;
         DAT_O : OUT  std_logic_vector(7 downto 0);
         STB_O : OUT  std_logic;
         WE_O : OUT  std_logic;
         RX : IN  std_logic;
         TX : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ACK_I : std_logic := '0';
   signal CLK_I : std_logic := '0';
   signal DAT_I : std_logic_vector(7 downto 0) := (others => '0');
   signal RST_I : std_logic := '0';
   signal RX : std_logic := '0';

 	--Outputs
   signal ADR_O : std_logic_vector(7 downto 0);
   signal CYC_O : std_logic;
   signal DAT_O : std_logic_vector(7 downto 0);
   signal STB_O : std_logic;
   signal WE_O : std_logic;
   signal TX : std_logic;

   -- Clock period definitions
  constant CLK_I_period : time := 20 ns;
	constant response : time := 21 ns;
	constant datatime 	 : time := CLK_I_period*217 ;
	signal input : std_logic_vector(7 downto 0);
	signal resievedata : std_logic_vector(7 downto 0);
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: processor PORT MAP (
          ACK_I => ACK_I,
          CLK_I => CLK_I,
          DAT_I => DAT_I,
          RST_I => RST_I,
          ADR_O => ADR_O,
          CYC_O => CYC_O,
          DAT_O => DAT_O,
          STB_O => STB_O,
          WE_O => WE_O,
          RX => RX,
          TX => TX
        );

   -- Clock process definitions
   CLK_I_process :process
   begin
		CLK_I <= '0';
		wait for CLK_I_period/2;
		CLK_I <= '1';
		wait for CLK_I_period/2;
   end process;
 

   -- Stimulus process
   -- Stimulus process
   stim_proc: process
	begin
		RX<='1';
		RST_I<='1';
		wait for 101 ns;	
		RST_I<='0';
		wait for datatime ;
		
		RX<='0'; 
		input<="0000"&"0010";--opcode + const & reg
		wait for datatime ;
		for i in 0 to 7 loop
			RX<=input(i);
			wait for datatime;
		end loop;
		RX<='1';
		wait for datatime;
				RX<='0'; 
		input<="0000"&"0010";--opcode + const & reg
		wait for datatime ;
		for i in 0 to 7 loop
			RX<=input(i);
			wait for datatime;
		end loop;
		RX<='1';
		wait for datatime;
		RX<='0'; 
		input<="0000"&"0000";--opcode + const & reg
		wait for datatime ;
		for i in 0 to 7 loop
			RX<=input(i);
			wait for datatime;
		end loop;
		RX<='1';
		wait for datatime;
				RX<='0'; 
		input<="1000"&"0000";--opcode + const & reg
		wait for datatime ;
		for i in 0 to 7 loop
			RX<=input(i);
			wait for datatime;
		end loop;
		RX<='1';
		wait for datatime;
				wait for datatime;
				RX<='0'; 
		input<="1001"&"1100";--opcode + const & reg
		wait for datatime ;
		for i in 0 to 7 loop
			RX<=input(i);
			wait for datatime;
		end loop;
		RX<='1';
		wait for datatime;
		wait;

      wait;
   end process;
respons: process
begin
		wait until STB_O='1';
		wait for response;
		ack_i<='1';
		DAT_I<="11001101";
		wait until STB_O='0';
		wait for 2 ns ;
		ack_i<='0';
		DAT_I<=x"00";
		wait until STB_O='1';
		wait for response ;
		ack_i<='1';
		DAT_I<=x"ee";
		wait until STB_O='0';
		wait for 2 ns ;
		ack_i<='0';
		DAT_I<=x"00";
		wait until STB_O='1';
		wait for response ;
		ack_i<='1';
		DAT_I<=x"15";
		wait until STB_O='0';
		wait for 2 ns ;
		ack_i<='0';
		DAT_I<=x"00";
		wait until STB_O='1';
		wait for response ;
		ack_i<='1';
		DAT_I<=x"28";
		wait until STB_O='0';
		wait for 2 ns ;
		ack_i<='0';
		DAT_I<=x"00";
 end process;
 
recieve: process
	begin
	---eerste byte
--	wait until tx ='0';
--	wait for datatime ;
--	wait for 1 ns;
--	wait for datatime ;
--	for i in 0 to 7 loop
--			resievedata(i)<=TX;
--			wait for datatime ;
--	end loop;
--	wait for 1 ns;
--	assert resievedata="11001101"
--	report "foute output";
--	--- 2de byte
	wait until tx ='0';
	wait for datatime ;
	wait for datatime;
	wait for 1 ns;
	for i in 0 to 7 loop
			resievedata(i)<=TX;
			wait for datatime;
	end loop;
	wait for 1 ns;
	assert resievedata=x"ee"
	report "foute output";
	---3de byte
	wait until tx ='0';
	wait for datatime ;
	wait for datatime;
	wait for 1 ns;
	for i in 0 to 7 loop
			resievedata(i)<=TX;
			wait for datatime ;
	end loop;
	wait for 1 ns;
	assert resievedata=x"15"
	report "foute output";
	
	--4de byte
	wait until tx ='0';
	wait for datatime ;
	wait for datatime;

	wait for 1 ns;
	for i in 0 to 7 loop
			resievedata(i)<=TX;
			wait for datatime ;
	end loop;
	wait for 1 ns;
	assert resievedata=x"28"
	report "foute output";
	end process;
END;
