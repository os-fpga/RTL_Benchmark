-----------------------------------------------------------------------
----                                                               ----
---- Montgomery modular multiplier and exponentiator               ----
----                                                               ----
---- This file is part of the Montgomery modular multiplier        ----
---- and exponentiator project                                     ----
---- http://opencores.org/project,mod_mult_exp                     ----
----                                                               ----
---- Description:                                                  ----
----     Counter - nothing special.                                ----
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.properties.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is 
    generic(
	     size : integer := 4
	 );
    port ( 
	     count  : in STD_LOGIC;
		  zero   : in STD_LOGIC;
	     output : out STD_LOGIC_VECTOR(size - 1 downto 0); 
        clk    : in STD_LOGIC;
        reset  : in STD_LOGIC
	 ); 
end counter;

architecture Behavioral of Counter is
    signal c : STD_LOGIC_VECTOR(size - 1 downto 0); 
    begin
        licznik: process (reset,clk)
        begin
            if (clk = '1' and clk'Event) then
				    if (reset = '1') then
                    c <= (others => '0');
                elsif count = '1' then
                    c <= c + 1;
                elsif zero = '1' then
                    c <= (others => '0');
                else 
					     c <= c;
					 end if;
            end if;
        end process licznik;
    OUTPUT <= c;
end Behavioral;