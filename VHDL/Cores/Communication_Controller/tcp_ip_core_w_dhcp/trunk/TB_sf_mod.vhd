--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:08:24 12/11/2014
-- Design Name:   
-- Module Name:   /home/craig/Documents/CW/Git_Repos/hw_client/TB_sf_mod.vhd
-- Project Name:  hw_client
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sf_mod
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
 
ENTITY TB_sf_mod IS
END TB_sf_mod;
 
ARCHITECTURE behavior OF TB_sf_mod IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sf_mod
    PORT(
         CLK_IN 				: IN  std_logic;
         RESET_IN 			: IN  std_logic;
         INIT_IN 				: IN  std_logic;
         INIT_CMPLT_OUT 	: OUT  std_logic;
         ERROR_OUT 			: OUT  std_logic;
         ADDR_IN 				: IN  std_logic_vector(23 downto 1);
         DATA_OUT 			: OUT  std_logic_vector(15 downto 0);
         RD_IN 				: IN  std_logic;
         RD_CMPLT_OUT 		: OUT  std_logic;
         SF_DATA_IN 			: IN  std_logic_vector(15 downto 0);
         SF_ADDR_OUT 		: OUT  std_logic_vector(23 downto 1);
         SF_CS_BAR_OUT 		: OUT  std_logic;
         SF_OE_BAR_OUT 		: OUT  std_logic;
         SF_RESET_BAR_OUT 	: OUT  std_logic;
         SF_STATUS_IN 		: IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_IN : std_logic := '0';
   signal RESET_IN : std_logic := '0';
   signal INIT_IN : std_logic := '0';
   signal ADDR_IN : std_logic_vector(23 downto 1) := (others => '0');
   signal RD_IN : std_logic := '0';
   signal SF_DATA_IN : std_logic_vector(15 downto 0) := (others => '0');
   signal SF_STATUS_IN : std_logic := '0';

 	--Outputs
   signal INIT_CMPLT_OUT : std_logic;
   signal ERROR_OUT : std_logic;
   signal DATA_OUT : std_logic_vector(15 downto 0);
   signal RD_CMPLT_OUT : std_logic;
   signal SF_ADDR_OUT : std_logic_vector(23 downto 1);
   signal SF_CS_BAR_OUT : std_logic;
   signal SF_OE_BAR_OUT : std_logic;
   signal SF_RESET_BAR_OUT : std_logic;

   -- Clock period definitions
   constant CLK_IN_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sf_mod PORT MAP (
          CLK_IN => CLK_IN,
          RESET_IN => RESET_IN,
          INIT_IN => INIT_IN,
          INIT_CMPLT_OUT => INIT_CMPLT_OUT,
          ERROR_OUT => ERROR_OUT,
          ADDR_IN => ADDR_IN,
          DATA_OUT => DATA_OUT,
          RD_IN => RD_IN,
          RD_CMPLT_OUT => RD_CMPLT_OUT,
          SF_DATA_IN => SF_DATA_IN,
          SF_ADDR_OUT => SF_ADDR_OUT,
          SF_CS_BAR_OUT => SF_CS_BAR_OUT,
          SF_OE_BAR_OUT => SF_OE_BAR_OUT,
          SF_RESET_BAR_OUT => SF_RESET_BAR_OUT,
          SF_STATUS_IN => SF_STATUS_IN
        );

   -- Clock process definitions
   CLK_IN_process :process
   begin
		CLK_IN <= '0';
		wait for CLK_IN_period/2;
		CLK_IN <= '1';
		wait for CLK_IN_period/2;
   end process;

	DATA_PROC :process
	begin
		wait for CLK_IN_period;
		if SF_ADDR_OUT(23 downto 1) = "000"&X"00000" then
			SF_DATA_IN <= X"7B25";
		elsif SF_ADDR_OUT(23 downto 1) = "000"&X"0003F" then
			SF_DATA_IN <= X"ED4A";
		elsif SF_ADDR_OUT(23 downto 1) = "000"&X"00001" then
			SF_DATA_IN <= X"1111";
		elsif SF_ADDR_OUT(23 downto 1) = "000"&X"00002" then
			SF_DATA_IN <= X"2222";
		end if;
	end process;

   -- Stimulus process
   stim_proc: process
   begin		

      wait for CLK_IN_period*10;

		INIT_IN <= '0';
		wait for CLK_IN_period;
      INIT_IN <= '1';
		wait for CLK_IN_period;
		INIT_IN <= '0';
		wait for CLK_IN_period;
		
		wait for CLK_IN_period*10;
		
		ADDR_IN <= "000"&X"00001";
		RD_IN <= '0';
		wait for CLK_IN_period;
      RD_IN <= '1';
		wait for CLK_IN_period;
		RD_IN <= '0';
		wait for CLK_IN_period;
		
		wait for CLK_IN_period*10;
		
		ADDR_IN <= "000"&X"00002";
		RD_IN <= '0';
		wait for CLK_IN_period;
      RD_IN <= '1';
		wait for CLK_IN_period;
		RD_IN <= '0';
		wait for CLK_IN_period;
		
      wait;
   end process;

END;
