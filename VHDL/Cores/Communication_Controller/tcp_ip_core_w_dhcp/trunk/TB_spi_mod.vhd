--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:47:27 12/04/2014
-- Design Name:   
-- Module Name:   /home/craig/Documents/CW/Git_Repos/hw_client/TB_spi_mod.vhd
-- Project Name:  hw_client
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: spi_mod
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
 
ENTITY TB_spi_mod IS
END TB_spi_mod;
 
ARCHITECTURE behavior OF TB_spi_mod IS 
 
    COMPONENT spi_mod
    PORT(
         CLK_IN 						: IN  std_logic;
         RST_IN 						: IN  std_logic;
         WR_CONTINUOUS_IN 			: IN  std_logic;
         WE_IN 						: IN  std_logic;
         WR_ADDR_IN 					: IN  std_logic_vector(7 downto 0);
         WR_DATA_IN 					: IN  std_logic_vector(7 downto 0);
         WR_DATA_CMPLT_OUT 		: OUT std_logic;
			RD_CONTINUOUS_IN 			: IN  std_logic;
         RD_IN 						: IN  std_logic;
         RD_WIDTH_IN 				: IN  std_logic;
         RD_ADDR_IN 					: IN  std_logic_vector(7 downto 0);
         RD_DATA_OUT 				: OUT std_logic_vector(7 downto 0);
			RD_DATA_CMPLT_OUT			: out STD_LOGIC;
			SLOW_CS_EN_IN				: in STD_LOGIC;
			OPER_CMPLT_POST_CS_OUT 	: out STD_LOGIC;
         SDI_OUT 						: OUT std_logic;
         SDO_IN 						: IN  std_logic;
         SCLK_OUT 					: OUT std_logic;
         CS_OUT 						: OUT std_logic);
    END COMPONENT;
    

   --Inputs
   signal CLK_IN : std_logic := '0';
   signal RST_IN : std_logic := '0';
   signal WR_CONTINUOUS_IN : std_logic := '0';
   signal RD_CONTINUOUS_IN : std_logic := '0';
   signal WE_IN : std_logic := '0';
   signal WR_ADDR_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal WR_DATA_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal RD_IN, OPER_CMPLT_POST_CS_OUT : std_logic := '0';
   signal RD_WIDTH_IN : std_logic := '0';
   signal RD_ADDR_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal SDO : std_logic := '0';

 	--Outputs
   signal WR_DATA_CMPLT_OUT, SLOW_CS_EN_IN : std_logic;
   signal RD_DATA_OUT : std_logic_vector(7 downto 0);
   signal SDI, RD_DATA_CMPLT_OUT : std_logic;
   signal SCLK : std_logic;
   signal CS : std_logic;

   -- Clock period definitions
   constant CLK_IN_period : time := 9 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: spi_mod PORT MAP (
          CLK_IN => CLK_IN,
          RST_IN => RST_IN,
          WR_CONTINUOUS_IN => WR_CONTINUOUS_IN,
          WE_IN => WE_IN,
          WR_ADDR_IN => WR_ADDR_IN,
          WR_DATA_IN => WR_DATA_IN,
          WR_DATA_CMPLT_OUT => WR_DATA_CMPLT_OUT,
			 RD_CONTINUOUS_IN => RD_CONTINUOUS_IN,
          RD_IN => RD_IN,
          RD_WIDTH_IN => RD_WIDTH_IN,
          RD_ADDR_IN => RD_ADDR_IN,
          RD_DATA_OUT => RD_DATA_OUT,
			 RD_DATA_CMPLT_OUT => RD_DATA_CMPLT_OUT,
			 SLOW_CS_EN_IN => SLOW_CS_EN_IN,
			 OPER_CMPLT_POST_CS_OUT => OPER_CMPLT_POST_CS_OUT,
          SDI_OUT => SDI,
          SDO_IN => SDO,
          SCLK_OUT => SCLK,
          CS_OUT => CS
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

		SLOW_CS_EN_IN <= '1';

		WE_IN <= '0';
		wait for CLK_IN_period;
		WR_DATA_IN <= X"AE";
		WR_ADDR_IN <= X"45";
		WE_IN <= '1';
		wait for CLK_IN_period;
		WE_IN <= '0';
		
		wait for 30 us;
		
		WE_IN <= '0';
		wait for CLK_IN_period;
		WR_DATA_IN <= X"F2";
		WR_ADDR_IN <= X"9B";
		WE_IN <= '1';
		WR_CONTINUOUS_IN <= '1';
		wait for CLK_IN_period;
		WE_IN <= '0';
	
		wait for 1310 ns;
		WR_DATA_IN <= X"2B";
		
		wait for 640 ns;
		WR_DATA_IN <= X"E7";
		
		wait for 640 ns;
		WR_DATA_IN <= X"A1";
		
		wait for 640 ns;
		WR_DATA_IN <= X"43";
		
		wait for 50 us;
		WR_CONTINUOUS_IN <= '0';
		
		wait for 30 us;
		SLOW_CS_EN_IN <= '0';
		
		RD_IN <= '0';
		wait for CLK_IN_period;
		RD_ADDR_IN <= X"26";
		RD_IN <= '1';
		wait for CLK_IN_period;
		RD_IN <= '0';
		
		wait for 670 ns;

		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;

		wait for 30 us;

		RD_IN <= '0';
		wait for CLK_IN_period;
		RD_ADDR_IN <= X"62";
		RD_IN <= '1';
		RD_WIDTH_IN <= '0';
		wait for CLK_IN_period;
		RD_IN <= '0';
		RD_WIDTH_IN <= '1';
	
		wait for 670 ns;
	
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
	
		wait for 30 us;

		RD_IN <= '0';
		wait for CLK_IN_period;
		RD_CONTINUOUS_IN <= '1';
		RD_ADDR_IN <= X"62";
		RD_IN <= '1';
		RD_WIDTH_IN <= '0';
		wait for CLK_IN_period;
		RD_IN <= '0';
		
		wait for 820 ns;

		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		
		wait for 820 ns;

		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		
		wait for 820 ns;

		SDO <= '1';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '0';
		wait for 80 ns;
		SDO <= '1';
		wait for 80 ns;
		
		wait for 20 us;
		RD_CONTINUOUS_IN <= '0';
	
		wait for 30 us;
		SLOW_CS_EN_IN <= '0';
		
		RD_IN <= '0';
		wait for CLK_IN_period;
		RD_ADDR_IN <= X"26";
		RD_IN <= '1';
		wait for CLK_IN_period;
		RD_IN <= '0';
	
      wait;
   end process;

END;
