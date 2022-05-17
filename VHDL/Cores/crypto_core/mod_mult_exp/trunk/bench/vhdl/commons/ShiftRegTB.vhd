----                                                               ----
---- This file is part of the Montgomery modular multiplier        ----
---- and exponentiator                                             ----
---- https://opencores.org/projects/mod_mult_exp                   ----
----                                                               ----
---- Description:                                                  ----
----     Test bench of shift register - nothing special.           ----
---- To Do:                                                        ----
----                                                               ----
---- Author(s):                                                    ----
---- - Krzysztof Gajewski, gajos@opencores.org                     ----
----                       k.gajewski@gmail.com                    ----
----                                                               ----
-----------------------------------------------------------------------
----                                                               ----
---- Copyright (C) 2019 Authors and OPENCORES.ORG                  ----
----                                                               ----
---- This source file may be used and distributed without          ----
---- restriction provided that this copyright statement is not     ----
---- removed from the file and that any derivative work contains   ----
---- the original copyright notice and the associated disclaimer.  ----
----                                                               ----
---- This source file is free software; you can redistribute it    ----
---- and-or modify it under the terms of the GNU Lesser General    ----
---- Public License as published by the Free Software Foundation;  ----
---- either version 2.1 of the License, or (at your option) any    ----
---- later version.                                                ----
----                                                               ----
---- This source is distributed in the hope that it will be        ----
---- useful, but WITHOUT ANY WARRANTY; without even the implied    ----
---- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR       ----
---- PURPOSE. See the GNU Lesser General Public License for more   ----
---- details.                                                      ----
----                                                               ----
---- You should have received a copy of the GNU Lesser General     ----
---- Public License along with this source; if not, download it    ----
---- from http://www.opencores.org/lgpl.shtml                      ----
----                                                               ----
-----------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.properties.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ShiftRegTB IS
END ShiftRegTB;
 
ARCHITECTURE behavior OF ShiftRegTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ShiftReg
	 GENERIC (
	     length_1      : integer :=  BYTE;
	     length_2      : integer :=  WORD_LENGTH
	 );
    PORT(
        input  : in  STD_LOGIC_VECTOR(BYTE - 1 downto 0);
        output : out STD_LOGIC_VECTOR(WORD_LENGTH - 1 downto 0);
        en     : in  STD_LOGIC;
        shift  : in  STD_LOGIC;
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC
    );
    END COMPONENT;
    

   --Inputs
   signal input : STD_LOGIC_VECTOR(BYTE - 1  downto 0) := (others => '0');
   signal en    : STD_LOGIC := '0';
   signal shift : STD_LOGIC := '0';
   signal clk   : STD_LOGIC := '0';
   signal reset : STD_LOGIC := '0';

 	--Outputs
   signal output : STD_LOGIC_VECTOR(WORD_LENGTH - 1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ShiftReg PORT MAP (
          input => input,
          output => output,
          en => en,
          shift => shift,
          clk => clk,
          reset => reset
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

  -- Stimulus process
   stim_proc: process
   begin		
      reset <= '0';
		shift <= '0';
		input <= "10101010";
      wait for 100 ns;	
		reset <= '1';
      wait for clk_period*10;
		
		reset <= '0';
		en <= '1';
		wait for clk_period*1;
		
		en <= '0';
		wait for clk_period*1;

------------- Test case 1 ------------------------
--   expected_output <= x"aa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
--------------------------------------------------

		if output /= x"aa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" then
			report "RESULT MISMATCH! Test case 1 failed" severity ERROR;
			assert false severity failure;
		else
			report "Test case 1 successful" severity note;	
		end if;
		
		shift <= '1';
		wait for clk_period*10;
      
------------- Test case 2 ------------------------
--   expected_output <= x"002a800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
--------------------------------------------------

		if output /= x"002a8000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" then
			report "RESULT MISMATCH! Test case 2 failed" severity ERROR;
			assert false severity failure;
		else
			report "Test case 2 successful" severity note;	
		end if;
				
		
		assert false severity failure;
   end process;

END;
