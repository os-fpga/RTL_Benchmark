--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:45:41 01/21/2015
-- Design Name:   
-- Module Name:   /home/craig/Documents/CW/Git_Repos/vault/TB_bin_to_bcd.vhd
-- Project Name:  vault
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: bin_to_bcd
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
 
ENTITY TB_bin_to_bcd IS
END TB_bin_to_bcd;
 
ARCHITECTURE behavior OF TB_bin_to_bcd IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bin_to_bcd
    PORT(
         CLK_IN : IN  std_logic;
         CONV_IN : IN  std_logic;
         BIN_IN : IN  std_logic_vector(7 downto 0);
         BCD_OUT : OUT  std_logic_vector(11 downto 0);
         CONV_DONE_OUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_IN : std_logic := '0';
   signal CONV_IN : std_logic := '0';
   signal BIN_IN : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal BCD_OUT : std_logic_vector(11 downto 0);
   signal CONV_DONE_OUT : std_logic;

   -- Clock period definitions
   constant CLK_IN_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bin_to_bcd PORT MAP (
          CLK_IN 			=> CLK_IN,
          CONV_IN 		=> CONV_IN,
          BIN_IN 			=> BIN_IN,
          BCD_OUT			=> BCD_OUT,
          CONV_DONE_OUT => CONV_DONE_OUT
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

      wait for 100 ns;
		
		CONV_IN <= '1';
		BIN_IN <= X"C0";
		wait for CLK_IN_period;
      CONV_IN <= '0';
		wait for CLK_IN_period;
		
		wait for 200 ns;
		
		CONV_IN <= '1';
		BIN_IN <= X"D0";
		wait for CLK_IN_period;
      CONV_IN <= '0';
		wait for CLK_IN_period;
		
		wait for 200 ns;
		
		CONV_IN <= '1';
		BIN_IN <= X"FF";
		wait for CLK_IN_period;
      CONV_IN <= '0';
		wait for CLK_IN_period;

      wait;
   end process;

END;
