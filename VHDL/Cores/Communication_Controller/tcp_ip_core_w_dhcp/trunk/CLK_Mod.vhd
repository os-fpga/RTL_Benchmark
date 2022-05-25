----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:16:23 10/19/2014 
-- Design Name: 
-- Module Name:    clk_mod - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity clk_mod is
    Port ( CLK_100MHz_IN 	: in  STD_LOGIC;
			  CLK_100Mhz_OUT	: out STD_LOGIC);
end clk_mod;

architecture Behavioral of clk_mod is

signal clk_1x, clk_1x_bufg 				: std_logic:='0';
signal clk0_2xout_tmp, clk0_2xout_bufg : std_logic:='0';
signal clk0_1xout_tmp, clk0_1xout_bufg : std_logic:='0';

begin

	CLK_100Mhz_OUT <= clk0_1xout_bufg;

 	U01_BUFG : BUFG
    port map (I => clk0_1xout_tmp, O => clk0_1xout_bufg);
 	U0_BUFG : BUFG
    port map (I => clk0_2xout_tmp, O => clk0_2xout_bufg);

	DCM_SP_inst : DCM_SP
   generic map (
      CLKDV_DIVIDE => 4.0,                   -- CLKDV divide value (1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,9,10,11,12,13,14,15,16).
      CLKFX_DIVIDE => 2,                     -- Divide value on CLKFX outputs - D - (1-32)
      CLKFX_MULTIPLY => 2,                   -- Multiply value on CLKFX outputs - M - (2-32)
      CLKIN_DIVIDE_BY_2 => FALSE,            -- CLKIN divide by two (TRUE/FALSE)
      CLKIN_PERIOD => 10.0,                  -- Input clock period specified in nS
      CLKOUT_PHASE_SHIFT => "NONE",          -- Output phase shift (NONE, FIXED, VARIABLE)
      CLK_FEEDBACK => "2X",                  -- Feedback source (NONE, 1X, 2X)
      DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS", -- SYSTEM_SYNCHRNOUS or SOURCE_SYNCHRONOUS
      DFS_FREQUENCY_MODE => "LOW",           -- Unsupported - Do not change value
      DLL_FREQUENCY_MODE => "LOW",           -- Unsupported - Do not change value
      DSS_MODE => "NONE",                    -- Unsupported - Do not change value
      DUTY_CYCLE_CORRECTION => TRUE,         -- Unsupported - Do not change value
      FACTORY_JF => X"c080",                 -- Unsupported - Do not change value
      PHASE_SHIFT => 0,                      -- Amount of fixed phase shift (-255 to 255)
      STARTUP_WAIT => FALSE                  -- Delay configock frequency clock output
		)
   port map (
      CLK2X180 => open, 				-- 1-bit output: 2X clock frequency, 180 degree clock output
      CLK90 	=> open,       		-- 1-bit output: 90 degree clock output
      CLKDV 	=> open,     -- 1-bit output: Divided clock output
      CLKFX 	=> clk0_1xout_tmp,   -- 1-bit output: Digital Frequency Synthesizer output (DFS)
      CLKFX180 => open, 				-- 1-bit output: 180 degree CLKFX output
      LOCKED 	=> open,     			-- 1-bit output: DCM_SP Lock Output
      PSDONE 	=> open,     			-- 1-bit output: Phase shift done output
      STATUS 	=> open,     			-- 8-bit output: DCM_SP status output
      CLKFB 	=> clk0_2xout_bufg,  -- 1-bit input: Cl DONE until DCM_SP LOCKED (TRUE/FALSE)
      CLK0 		=> open, 	-- 1-bit output: 0 degree clock output
      CLK180 	=> open,     			-- 1-bit output: 180 degree clock output
      CLK270 	=> open,     			-- 1-bit output: 270 degree clock output
      CLK2X 	=> clk0_2xout_tmp,   -- 1-bit output: 2X clock feedback input
      CLKIN 	=> CLK_100MHz_IN,     -- 1-bit input: Clock input
      DSSEN 	=> '0',       			-- 1-bit input: Unsupported, specify to GND.
      PSCLK 	=> '0',       			-- 1-bit input: Phase shift clock input
      PSEN 		=> '0',         		-- 1-bit input: Phase shift enable
      PSINCDEC => '0', 					-- 1-bit input: Phase shift increment/decrement input
      RST 		=> '0'            	-- 1-bit input: Active high reset input
   );

end Behavioral;

