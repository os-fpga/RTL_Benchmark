----------------------------------------------------------------------
----                                                              ----
---- WISHBONE SPDIF IP Core                                       ----
----                                                              ----
---- This file is part of the SPDIF project                       ----
---- http://www.opencores.org/cores/spdif_interface/              ----
----                                                              ----
---- Description                                                  ----
---- SPDIF transmitter TxVersion register.                        ----
----                                                              ----
----                                                              ----
---- To Do:                                                       ----
---- -                                                            ----
----                                                              ----
---- Author(s):                                                   ----
---- - Geir Drange, gedra@opencores.org                           ----
----                                                              ----
----------------------------------------------------------------------
----                                                              ----
---- Copyright (C) 2004 Authors and OPENCORES.ORG                 ----
----                                                              ----
---- This source file may be used and distributed without         ----
---- restriction provided that this copyright statement is not    ----
---- removed from the file and that any derivative work contains  ----
---- the original copyright notice and the associated disclaimer. ----
----                                                              ----
---- This source file is free software; you can redistribute it   ----
---- and/or modify it under the terms of the GNU Lesser General   ----
---- Public License as published by the Free Software Foundation; ----
---- either version 2.1 of the License, or (at your option) any   ----
---- later version.                                               ----
----                                                              ----
---- This source is distributed in the hope that it will be       ----
---- useful, but WITHOUT ANY WARRANTY; without even the implied   ----
---- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ----
---- PURPOSE. See the GNU Lesser General Public License for more  ----
---- details.                                                     ----
----                                                              ----
---- You should have received a copy of the GNU Lesser General    ----
---- Public License along with this source; if not, download it   ----
---- from http://www.opencores.org/lgpl.shtml                     ----
----                                                              ----
----------------------------------------------------------------------
--
-- CVS Revision History
--
-- $Log: not supported by cvs2svn $
--
--

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity tx_ver_reg is	 
  generic (DATA_WIDTH: integer;
           ADDR_WIDTH: integer;
           USER_DATA_BUF: integer;
           CH_STAT_BUF: integer);
  port (
    ver_rd: in std_logic; -- version register read
    ver_dout: out std_logic_vector(DATA_WIDTH - 1 downto 0));
end tx_ver_reg;

architecture rtl of tx_ver_reg is

  signal version : std_logic_vector(DATA_WIDTH - 1 downto 0);

begin
  ver_dout <= version when ver_rd = '1' else (others => '0');

  -- version vector generation
  version(3 downto 0) <= "0001";        -- version 1
  G32: if DATA_WIDTH = 32 generate
    version(4) <= '1';
    version(31 downto 16) <= (others => '0');
  end generate G32;
  G16: if DATA_WIDTH = 16 generate
    version(4) <= '0';
  end generate G16;
  version(11 downto 5) <= std_logic_vector(to_unsigned(ADDR_WIDTH, 7));
  version(15 downto 14) <= (others => '0');
  version(12) <= '1' when USER_DATA_BUF = 1 else '0';
  version(13) <= '1' when CH_STAT_BUF = 1 else '0';
 
end rtl;
