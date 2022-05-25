--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:10:44 01/06/2015
-- Design Name:   
-- Module Name:   /home/craig/Documents/CW/Git_Repos/hw_client/TB_lfsr16_mod.vhd
-- Project Name:  hw_client
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: lfsr16_mod
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
 
ENTITY TB_lfsr32_mod IS
END TB_lfsr32_mod;
 
ARCHITECTURE behavior OF TB_lfsr32_mod IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT lfsr32_mod
    PORT(
         CLK_IN : IN  std_logic;
         SEED_IN : IN  std_logic_vector(31 downto 0);
         SEED_EN_IN : IN  std_logic;
         VAL_OUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_IN : std_logic := '0';
   signal SEED_IN : std_logic_vector(31 downto 0) := (others => '0');
   signal SEED_EN_IN : std_logic := '0';

 	--Outputs
   signal VAL_OUT : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_IN_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: lfsr32_mod PORT MAP (
          CLK_IN => CLK_IN,
          SEED_IN => SEED_IN,
          SEED_EN_IN => SEED_EN_IN,
          VAL_OUT => VAL_OUT
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

      wait for CLK_IN_period * 1000;

		wait for CLK_IN_period;
		SEED_EN_IN <= '0';
		wait for CLK_IN_period;
		SEED_IN <= X"12341234";
		SEED_EN_IN <= '1';
		wait for CLK_IN_period;
		SEED_EN_IN <= '0';
		
      wait;
   end process;

END;
