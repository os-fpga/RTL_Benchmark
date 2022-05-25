--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:38:05 12/08/2014
-- Design Name:   
-- Module Name:   /home/craig/Documents/CW/Git_Repos/hw_client/TB_led_mod.vhd
-- Project Name:  hw_client
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: led_mod
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
 
ENTITY TB_led_mod IS
END TB_led_mod;
 
ARCHITECTURE behavior OF TB_led_mod IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT led_mod
    PORT(
         CLK_IN : IN  std_logic;
         LED_STATE_IN : IN  std_logic_vector(2 downto 0);
         ERROR_CODE_IN : IN  std_logic_vector(4 downto 0);
         ERROR_CODE_EN_IN : IN  std_logic;
         LEDS_OUT : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_IN : std_logic := '0';
   signal LED_STATE_IN : std_logic_vector(2 downto 0) := (others => '0');
   signal ERROR_CODE_IN : std_logic_vector(4 downto 0) := (others => '0');
   signal ERROR_CODE_EN_IN : std_logic := '0';

 	--Outputs
   signal LEDS_OUT : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant CLK_IN_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: led_mod PORT MAP (
          CLK_IN => CLK_IN,
          LED_STATE_IN => LED_STATE_IN,
          ERROR_CODE_IN => ERROR_CODE_IN,
          ERROR_CODE_EN_IN => ERROR_CODE_EN_IN,
          LEDS_OUT => LEDS_OUT
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_IN_period*10;

		ERROR_CODE_EN_IN <= '0';
		wait for CLK_IN_period;
		ERROR_CODE_IN <= "01101";
		ERROR_CODE_EN_IN <= '1';
		wait for CLK_IN_period;
		ERROR_CODE_EN_IN <= '0';

		wait for CLK_IN_period*10;
		LED_STATE_IN <= "111";

      wait;
   end process;

END;
