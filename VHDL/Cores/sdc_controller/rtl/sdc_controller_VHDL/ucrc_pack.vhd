--------------------------------------------------------------------------
-- Package
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package ucrc_pack is

  component ucrc_ser
    generic (
      POLYNOMIAL : unsigned; -- 4 to 32 bits
      INIT_VALUE : unsigned
    );
    port (
      -- System clock and asynchronous reset
      sys_clk    : in  std_logic; -- clock
      sys_rst_n  : in  std_logic; -- asynchronous reset
      sys_clk_en : in  std_logic; -- clock enable

      -- Input and Control
      clear_i : in  std_logic;    -- synchronous reset
      data_i  : in  std_logic;    -- data input
      flush_i : in  std_logic;    -- flush crc

      -- Output
      match_o : out std_logic;    -- CRC match flag
      crc_o   : out unsigned(POLYNOMIAL'length - 1 downto 0)  -- CRC output
    );
  end component;

  component ucrc_par
    generic (
      POLYNOMIAL : unsigned;
      INIT_VALUE : unsigned;
      DATA_WIDTH : integer range 2 to 256
    );
    port (
      -- System clock and asynchronous reset
      sys_clk    : in  std_logic;       -- clock
      sys_rst_n  : in  std_logic;       -- asynchronous reset
      sys_clk_en : in  std_logic;       -- clock enable

      -- Input and Control
      clear_i : in  std_logic;    -- synchronous reset
      data_i  : in  unsigned(DATA_WIDTH - 1 downto 0);  -- data input

      -- Output
      match_o : out std_logic;       -- CRC match flag
      crc_o   : out unsigned(POLYNOMIAL'length - 1 downto 0)  -- CRC output
    );
  end component;

end ucrc_pack;

-------------------------------------------------------------------------------
-- Serial CRC module
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Date  : Jan.  8, 2014 Wrote description and began coding.
--                       Added separate asynchronous and synchronous
--                       reset inputs.  Changed signal names to resemble
--                       other packages within the project, and modified
--                       format to match my own personal coding style.
--
-- Description
-------------------------------------------------------------------------------
-- This is a CRC calculator.
-- It was obtained from http://www.opencores.org.
----------------------------------------------------------------------
----                                                              ----
---- Ultimate CRC.                                                ----
----                                                              ----
---- This file is part of the ultimate CRC project                ----
---- http://www.opencores.org/cores/ultimate_crc/                 ----
----                                                              ----
---- Description                                                  ----
---- CRC generator/checker, serial implementation.                ----
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
---- Copyright (C) 2005 Authors and OPENCORES.ORG                 ----
----                                                              ----
---- This source file may be used and distributed without         ----
---- restriction provided that this copyright statement is not    ----
---- removed from the file and that any derivative work contains  ----
---- the original copyright notice and the associated disclaimer. ----
----                                                              ----
---- This source file is free software; you can redistribute it   ----
---- and/or modify it under the terms of the GNU General          ----
---- Public License as published by the Free Software Foundation; ----
---- either version 2.0 of the License, or (at your option) any   ----
---- later version.                                               ----
----                                                              ----
---- This source is distributed in the hope that it will be       ----
---- useful, but WITHOUT ANY WARRANTY; without even the implied   ----
---- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ----
---- PURPOSE. See the GNU General Public License for more details.----
----                                                              ----
---- You should have received a copy of the GNU General           ----
---- Public License along with this source; if not, download it   ----
---- from http://www.gnu.org/licenses/gpl.txt                     ----
----                                                              ----
----------------------------------------------------------------------
--
-- CVS Revision History
--
-- $Log: not supported by cvs2svn $
-- Revision 1.2  2005/05/09 19:26:58  gedra
-- Moved match signal into clock enable
--
-- Revision 1.1  2005/05/07 12:47:47  gedra
-- Serial implementation.
--
--
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ucrc_ser is
  generic (
    POLYNOMIAL : unsigned := "0001000000100001"; -- 4 to 32 bits
    INIT_VALUE : unsigned := "1111111111111111"
  );
  port (
    -- System clock and asynchronous reset
    sys_clk    : in  std_logic; -- clock
    sys_rst_n  : in  std_logic; -- asynchronous reset
    sys_clk_en : in  std_logic; -- clock enable

    -- Input and Control
    clear_i : in  std_logic;    -- synchronous reset
    data_i  : in  std_logic;    -- data input
    flush_i : in  std_logic;    -- flush crc

    -- Output
    match_o : out std_logic;    -- CRC match flag
    crc_o   : out unsigned(POLYNOMIAL'length - 1 downto 0)  -- CRC output
  );
end ucrc_ser;

architecture rtl of ucrc_ser is

  constant msb         : integer                        := POLYNOMIAL'length - 1;
  constant init_msb    : integer                        := INIT_VALUE'length - 1;
  constant p           : unsigned(msb downto 0) := POLYNOMIAL;

  signal din, crc_msb  : unsigned(msb downto 1);
  signal crc, zero, fb : unsigned(msb downto 0);
   
begin

-- Parameter checking: Invalid generics will abort simulation/synthesis
  PCHK : if msb /= init_msb generate
    process
    begin
      report "POLYNOMIAL and INIT_VALUE vectors must be equal length!"
        severity failure;
      wait;
    end process;
  end generate PCHK;

  PCHK2 : if (msb < 3) or (msb > 31) generate
    process
    begin
      report "POLYNOMIAL must be of order 4 to 32!"
        severity failure;
      wait;
    end process;
  end generate PCHK2;

  PCHK3 : if p(0) /= '1' generate      -- LSB must be 1
    process
    begin
      report "POLYNOMIAL must have lsb set to 1!"
        severity failure;
      wait;
    end process;
  end generate PCHK3;

   zero  <= (others => '0');
   crc_o <= crc;

-- Create vectors of data input and MSB of CRC
   DI : for i in 1 to msb generate
     din(i)     <= data_i;
     crc_msb(i) <= crc(msb);
   end generate DI;

-- Feedback signals
   fb(0)            <= data_i xor crc(msb);
   fb(msb downto 1) <= crc(msb-1 downto 0) xor ((din xor crc_msb) and p(msb downto 1));

-- CRC process
  CRCP : process (sys_clk, sys_rst_n)
  begin
    if sys_rst_n='0' then -- async. reset
      crc     <= INIT_VALUE;
      match_o <= '0';
    elsif rising_edge(sys_clk) then
      if clear_i='1' then -- sync. reset
        crc     <= INIT_VALUE;
        match_o <= '0';
      else
        if sys_clk_en = '1' then
          -- CRC generation
          if flush_i = '1' then
            crc(0)            <= '0';
            crc(msb downto 1) <= crc(msb - 1 downto 0);
          else
            crc <= fb;
          end if;
          -- CRC match checker (if data plus CRC is clocked in without errors,
          -- the CRC register ends up with all zeroes)
          if fb = zero then
            match_o <= '1';
          else
            match_o <= '0';
          end if;
        end if;
      end if;
    end if;
  end process;
   
end rtl;

-------------------------------------------------------------------------------
-- Parallel CRC module
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Date  : Jan.  8, 2014 Wrote description and began coding.
--                       Added separate asynchronous and synchronous
--                       reset inputs.  Changed signal names to resemble
--                       other packages within the project, and modified
--                       format to match my own personal coding style.
--
-- Description
-------------------------------------------------------------------------------
-- This is a CRC calculator.
-- It was obtained from http://www.opencores.org.
----------------------------------------------------------------------
----                                                              ----
---- Ultimate CRC.                                                ----
----                                                              ----
---- This file is part of the ultimate CRC projectt               ----
---- http://www.opencores.org/cores/ultimate_crc/                 ----
----                                                              ----
---- Description                                                  ----
---- CRC generator/checker, parallel implementation.              ----
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
---- Copyright (C) 2005 Authors and OPENCORES.ORG                 ----
----                                                              ----
---- This source file may be used and distributed without         ----
---- restriction provided that this copyright statement is not    ----
---- removed from the file and that any derivative work contains  ----
---- the original copyright notice and the associated disclaimer. ----
----                                                              ----
---- This source file is free software; you can redistribute it   ----
---- and/or modify it under the terms of the GNU General          ----
---- Public License as published by the Free Software Foundation; ----
---- either version 2.0 of the License, or (at your option) any   ----
---- later version.                                               ----
----                                                              ----
---- This source is distributed in the hope that it will be       ----
---- useful, but WITHOUT ANY WARRANTY; without even the implied   ----
---- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ----
---- PURPOSE. See the GNU General Public License for more details.----
----                                                              ----
---- You should have received a copy of the GNU General           ----
---- Public License along with this source; if not, download it   ----
---- from http://www.gnu.org/licenses/gpl.txt                     ----
----                                                              ----
----------------------------------------------------------------------
--
-- CVS Revision History
--
-- $Log: not supported by cvs2svn $
-- Revision 1.1  2005/05/09 15:58:38  gedra
-- Parallel implementation
--
--
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ucrc_par is
  generic (
    POLYNOMIAL : unsigned := "0001000000100001";
    INIT_VALUE : unsigned := "1111111111111111";
    DATA_WIDTH : integer range 2 to 256 := 8
  );
  port (
    -- System clock and asynchronous reset
    sys_clk    : in  std_logic;       -- clock
    sys_rst_n  : in  std_logic;       -- asynchronous reset
    sys_clk_en : in  std_logic;       -- clock enable

    -- Input and Control
    clear_i : in  std_logic; -- synchronous reset
    data_i  : in  unsigned(DATA_WIDTH - 1 downto 0);  -- data input

    -- Output
    match_o : out std_logic;       -- CRC match flag
    crc_o   : out unsigned(POLYNOMIAL'length - 1 downto 0)  -- CRC output
  );
end ucrc_par;

architecture rtl of ucrc_par is

  constant msb      : integer                := POLYNOMIAL'length - 1;
  constant init_msb : integer                := INIT_VALUE'length - 1;
  constant p        : unsigned(msb downto 0) := POLYNOMIAL;
  constant dw       : integer                := DATA_WIDTH;
  constant pw       : integer                := POLYNOMIAL'length;
  type fb_array is array (dw downto 1) of unsigned(msb downto 0);
  type dmsb_array is array (dw downto 1) of unsigned(msb downto 1);
  signal crca       : fb_array;
  signal da, ma     : dmsb_array;
  signal crc, zero  : unsigned(msb downto 0);
   
begin

-- Parameter checking: Invalid generics will abort simulation/synthesis
  PCHK1 : if msb /= init_msb generate
    process
    begin
      report "POLYNOMIAL and INIT_VALUE vectors must be equal length!"
        severity failure;
      wait;
    end process;
  end generate PCHK1;

  PCHK2 : if (msb < 3) or (msb > 31) generate
    process
    begin
      report "POLYNOMIAL must be of order 4 to 32!"
        severity failure;
      wait;
    end process;
  end generate PCHK2;

  PCHK3 : if p(0) /= '1' generate      -- LSB must be 1
    process
    begin
      report "POLYNOMIAL must have lsb set to 1!"
        severity failure;
      wait;
    end process;
  end generate PCHK3;

-- Generate vector of each data bit
  CA : for i in 1 to dw generate       -- data bits
    DAT : for j in 1 to msb generate
      da(i)(j) <= data_i(i - 1);
    end generate DAT;
  end generate CA;

-- Generate vector of each CRC MSB
   MS0 : for i in 1 to msb generate
     ma(1)(i) <= crc(msb);
   end generate MS0;
   MSP : for i in 2 to dw generate
     MSU : for j in 1 to msb generate
       ma(i)(j) <= crca(i - 1)(msb);
     end generate MSU;
   end generate MSP;

-- Generate feedback matrix
   crca(1)(0)            <= da(1)(1) xor crc(msb);
   crca(1)(msb downto 1) <= crc(msb - 1 downto 0) xor ((da(1) xor ma(1)) and p(msb downto 1));
   FB : for i in 2 to dw generate
     crca(i)(0)            <= da(i)(1) xor crca(i - 1)(msb);
     crca(i)(msb downto 1) <= crca(i - 1)(msb - 1 downto 0) xor
                              ((da(i) xor ma(i)) and p(msb downto 1));
   end generate FB;

-- CRC process
  crc_o <= crc;
  zero  <= (others => '0');

  CRCP : process (sys_clk, sys_rst_n)
  begin
    if sys_rst_n='0' then -- async. reset
      crc     <= INIT_VALUE;
      match_o <= '0';
    elsif rising_edge(sys_clk) then
      if clear_i='1' then -- sync. reset
        crc     <= INIT_VALUE;
        match_o <= '0';
      elsif sys_clk_en = '1' then
        crc <= crca(dw);
        if crca(dw) = zero then
          match_o <= '1';
        else
          match_o <= '0';
        end if;
      end if;
    end if;
  end process;
   
end rtl;


