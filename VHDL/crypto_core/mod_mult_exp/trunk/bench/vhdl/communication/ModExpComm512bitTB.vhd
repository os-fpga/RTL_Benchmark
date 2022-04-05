----                                                               ----
---- This file is part of the Montgomery modular multiplier        ----
---- and exponentiator                                             ----
---- https://opencores.org/projects/mod_mult_exp                   ----
----                                                               ----
---- Description:                                                  ----
----     Test bench for Montgomery multiplier and exponentiator    ----
----     with 512 bit word length enclosed in RS232 communication  ----
----     with computer. Some kind of demo application of the       ----
----     project. Due to it uses serial communication, demo of     ----
----     this part is somewhat tricky. Most convienient way is to  ----
----     use graphical window. It is simulated all communication   ----
----     - sending data and exponentiation.                        ----
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
USE std.textio.all;
USE work.txt_util.all;
USE ieee.std_logic_textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ModExpComm512bitTB IS
END ModExpComm512bitTB;
 
ARCHITECTURE behavior OF ModExpComm512bitTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ModExpComm
    port (
	     DATA_RXD : in  STD_LOGIC;
		  CLK      : in  STD_LOGIC;
		  RESET    : in  STD_LOGIC;
		  DATA_TXD : out STD_LOGIC
	 );
    END COMPONENT;
    

   --Inputs
   signal DATA_RXD : STD_LOGIC := '0';
   signal CLK      : STD_LOGIC := '0';
   signal RESET    : STD_LOGIC := '0';

 	--Outputs
   signal DATA_TXD : STD_LOGIC;

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ModExpComm 
	    PORT MAP (
           DATA_RXD => DATA_RXD,
           CLK => CLK,
           RESET => RESET,
           DATA_TXD => DATA_TXD
       );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
	
	-- All data sent are prepared in files listed below. Data are stored 
	-- in sim/rtl_sim/bin folder . Data are grouped in packets of bytes. 
	-- Data from the files are explained in the Result.txt folder.
	file BaseFile     :text is in "testData512bit/Base.txt";
	file ModulusFile  :text is in "testData512bit/Modulus.txt";
	file ExponentFile :text is in "testData512bit/Exponent.txt";
	file ResiduumFile :text is in "testData512bit/Residuum.txt";
	
	variable line_in      : line;
	variable line_content : string(1 to 8);
	variable data         : STD_LOGIC;
	
   begin		
		DATA_RXD <= '1';
		RESET <= '1';
      wait for 1000 ns;	
		RESET <= '0';
		
      wait for CLK_period*10;

      -- Data transmission
	  -- All data are sent in direction from LSB to MSB
	  -- 8.75 us is due to estimation of period of time needed for sending
	  -- one bit in RS-232 with 115 200 bps bandwith
	  
      -- Command mn_read_base 00000 000
		DATA_RXD <= '0'; -- start bit
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '1'; -- parity bit
		wait for 8.75 us;
		DATA_RXD <= '1'; -- stop bit
		wait for 100 us;

      -- READ base - 512-bit number from the file
		
		while not (endfile(BaseFile)) loop
			readline(BaseFile, line_in);  -- info line
			read(line_in, line_content);
			report line_content;
			
			DATA_RXD <= '0'; -- start bit
			wait for 8.75 us;
			
			readline(BaseFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(BaseFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(BaseFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(BaseFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(BaseFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(BaseFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(BaseFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(BaseFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(BaseFile, line_in);
			read(line_in, data);
			DATA_RXD <= data; -- parity bit
			wait for 8.75 us;
			
			report "End of byte";
			DATA_RXD <= '1'; -- stop bit
			wait for 100 us;
		end loop;

      -- Command mn_read_modulus 00000 001
		DATA_RXD <= '0'; -- start bit
		wait for 8.75 us;
		DATA_RXD <= '1';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0'; -- parity bit
		wait for 8.75 us;
		DATA_RXD <= '1'; -- stop bit
		wait for 100 us;
		
		-- READ modulus - 512-bit number from the file
		
		while not (endfile(ModulusFile)) loop
			readline(ModulusFile, line_in);  -- info line
			read(line_in, line_content);
			report line_content;
			
			DATA_RXD <= '0'; -- start bit
			wait for 8.75 us;
			
			readline(ModulusFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ModulusFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ModulusFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ModulusFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ModulusFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ModulusFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ModulusFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ModulusFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ModulusFile, line_in);
			read(line_in, data);
			DATA_RXD <= data; -- parity bit
			wait for 8.75 us;
			
			report "End of byte";
			DATA_RXD <= '1'; -- stop bit
			wait for 100 us;
		end loop;

      -- Command mn_read_exponent 00000 010
		DATA_RXD <= '0'; -- start bit
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '1';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0'; -- parity bit
		wait for 8.75 us;
		DATA_RXD <= '1'; -- stop bit
		wait for 100 us;
		
		-- READ exponent - 512-bit number from the file
		
		while not (endfile(ExponentFile)) loop
			readline(ExponentFile, line_in);  -- info line
			read(line_in, line_content);
			report line_content;
			
			DATA_RXD <= '0'; -- start bit
			wait for 8.75 us;
			
			readline(ExponentFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ExponentFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ExponentFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ExponentFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ExponentFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ExponentFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ExponentFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ExponentFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ExponentFile, line_in);
			read(line_in, data);
			DATA_RXD <= data; -- parity bit
			wait for 8.75 us;
			
			report "End of byte";
			DATA_RXD <= '1'; -- stop bit
			wait for 100 us;
		end loop;
		
		-- Command mn_read_residuum 00000 011
		DATA_RXD <= '0'; -- start bit
		wait for 8.75 us;
		DATA_RXD <= '1';
		wait for 8.75 us;
		DATA_RXD <= '1';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '1'; -- parity bit
		wait for 8.75 us;
		DATA_RXD <= '1'; -- stop bit
		wait for 100 us;
		
		-- READ residuum - 512-bit number from the file
		
		while not (endfile(ResiduumFile)) loop
			readline(ResiduumFile, line_in);  -- info line
			read(line_in, line_content);
			report line_content;
			
			DATA_RXD <= '0'; -- start bit
			wait for 8.75 us;
			
			readline(ResiduumFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ResiduumFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ResiduumFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ResiduumFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ResiduumFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ResiduumFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ResiduumFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ResiduumFile, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(ResiduumFile, line_in);
			read(line_in, data);
			DATA_RXD <= data; -- parity bit
			wait for 8.75 us;
			
			report "End of byte";
			DATA_RXD <= '1'; -- stop bit
			wait for 100 us;
		end loop;

		-- Command mn_count_power  -- 00000 100
		DATA_RXD <= '0'; -- start bit
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '1';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0'; -- parity bit
		wait for 8.75 us;
		DATA_RXD <= '1'; -- stop bit
		wait for 64 ms;
		
		-- Wait for exponentiation process
		
		-- Command mn_show_result -- 00000 101
		DATA_RXD <= '0'; -- start bit
		wait for 8.75 us;
		DATA_RXD <= '1';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '1';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '1'; -- parity bit
		wait for 8.75 us;
		DATA_RXD <= '1'; -- stop bit
		wait for 15 ms;
		
		-- Command mn_prepare_for_data -- 00000 111
		DATA_RXD <= '0'; -- start bit
		wait for 8.75 us;
		DATA_RXD <= '1';
		wait for 8.75 us;
		DATA_RXD <= '1';
		wait for 8.75 us;
		DATA_RXD <= '1';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0';
		wait for 8.75 us;
		DATA_RXD <= '0'; -- parity bit
		wait for 8.75 us;
		DATA_RXD <= '1'; -- stop bit
		wait for 100 us;
		
		assert false severity failure;
		
   end process;

END;
