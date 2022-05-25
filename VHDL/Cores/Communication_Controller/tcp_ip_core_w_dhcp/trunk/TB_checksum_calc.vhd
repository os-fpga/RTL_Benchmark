--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:21:24 12/30/2014
-- Design Name:   
-- Module Name:   /home/craig/Documents/CW/Git_Repos/hw_client/TB_checksum_calc.vhd
-- Project Name:  hw_client
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: checksum_calc
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
 
ENTITY TB_checksum_calc IS
END TB_checksum_calc;
 
ARCHITECTURE behavior OF TB_checksum_calc IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT checksum_calc
    PORT(
         CLK_IN : IN  std_logic;
         RST_IN : IN  std_logic;
         CHECKSUM_CALC_IN : IN  std_logic;
         START_ADDR_IN : IN  std_logic_vector(10 downto 0);
         COUNT_IN : IN  std_logic_vector(10 downto 0);
         VALUE_IN : IN  std_logic_vector(7 downto 0);
         VALUE_ADDR_OUT : OUT  std_logic_vector(10 downto 0);
			CHECKSUM_INIT_IN		: in  STD_LOGIC_VECTOR (15 downto 0);
			CHECKSUM_SET_INIT_IN	: in  STD_LOGIC;
			CHECKSUM_ODD_LENGTH_IN	: in  STD_LOGIC;
         CHECKSUM_OUT : OUT  std_logic_vector(15 downto 0);
         CHECKSUM_DONE_OUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_IN : std_logic := '0';
   signal RST_IN : std_logic := '0';
   signal CHECKSUM_CALC_IN : std_logic := '0';
   signal START_ADDR_IN : std_logic_vector(10 downto 0) := (others => '0');
   signal COUNT_IN : std_logic_vector(10 downto 0) := (others => '0');
   signal VALUE_IN : std_logic_vector(7 downto 0) := (others => '0');

	signal CHECKSUM_INIT_IN			: STD_LOGIC_VECTOR (15 downto 0);
	signal CHECKSUM_SET_INIT_IN	: STD_LOGIC;
	signal CHECKSUM_ODD_LENGTH_IN	: STD_LOGIC;

 	--Outputs
   signal VALUE_ADDR_OUT : std_logic_vector(10 downto 0);
   signal CHECKSUM_OUT : std_logic_vector(15 downto 0);
   signal CHECKSUM_DONE_OUT : std_logic;

   -- Clock period definitions
   constant CLK_IN_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: checksum_calc PORT MAP (
          CLK_IN => CLK_IN,
          RST_IN => RST_IN,
          CHECKSUM_CALC_IN => CHECKSUM_CALC_IN,
          START_ADDR_IN => START_ADDR_IN,
          COUNT_IN => COUNT_IN,
          VALUE_IN => VALUE_IN,
          VALUE_ADDR_OUT => VALUE_ADDR_OUT,
			 CHECKSUM_INIT_IN		=> CHECKSUM_INIT_IN,
			 CHECKSUM_SET_INIT_IN	=> CHECKSUM_SET_INIT_IN,
			 CHECKSUM_ODD_LENGTH_IN	=> CHECKSUM_ODD_LENGTH_IN,
          CHECKSUM_OUT => CHECKSUM_OUT,
          CHECKSUM_DONE_OUT => CHECKSUM_DONE_OUT
        );

   -- Clock process definitions
   CLK_IN_process :process
   begin
		CLK_IN <= '0';
		wait for CLK_IN_period/2;
		CLK_IN <= '1';
		wait for CLK_IN_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
      wait for CLK_IN_period*10;
		
		COUNT_IN <= "00000000100";
		VALUE_IN <= X"15";
		wait for CLK_IN_period;
		
		CHECKSUM_CALC_IN <= '0';
		wait for CLK_IN_period;
		CHECKSUM_CALC_IN <= '1';
		wait for CLK_IN_period;
		CHECKSUM_CALC_IN <= '0';
		wait for CLK_IN_period;
	
		wait for CLK_IN_period*50;

		COUNT_IN <= "00000001000";
		CHECKSUM_INIT_IN <= X"1234";
		CHECKSUM_SET_INIT_IN <= '0';
		wait for CLK_IN_period;
		CHECKSUM_SET_INIT_IN <= '1';
		wait for CLK_IN_period;
		CHECKSUM_SET_INIT_IN <= '0';
		wait for CLK_IN_period;
		CHECKSUM_CALC_IN <= '0';
		wait for CLK_IN_period;
		CHECKSUM_CALC_IN <= '1';
		CHECKSUM_ODD_LENGTH_IN <= '1';
		wait for CLK_IN_period;
		CHECKSUM_ODD_LENGTH_IN <= '0';
		CHECKSUM_CALC_IN <= '0';
		wait for CLK_IN_period;

      wait;
   end process;

END;
