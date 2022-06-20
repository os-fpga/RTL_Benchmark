-------------------------------------------------------------------------------
--
-- (C) Copyright 2013 DFC Design, s.r.o., Brno, Czech Republic
-- Author: Marek Kvas (m.kvas@dfcdesign.cz)
--
-------------------------------------------------------------------------------
-- This file is part of UDP/IPv4 for 10 G Ethernet core.
-- 
-- UDP/IPv4 for 10 G Ethernet core is free software: you can 
-- redistribute it and/or modify it under the terms of 
-- the GNU Lesser General Public License as published by the Free 
-- Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-- 
-- UDP/IPv4 for 10 G Ethernet core is distributed in the hope that 
-- it will be useful, but WITHOUT ANY WARRANTY; without even 
-- the implied warranty of MERCHANTABILITY or FITNESS FOR A 
-- PARTICULAR PURPOSE.  See the GNU Lesser General Public License 
-- for more details.
-- 
-- You should have received a copy of the GNU Lesser General Public 
-- License along with UDP/IPv4 for 10 G Ethernet core.  If not, 
-- see <http://www.gnu.org/licenses/>.
-------------------------------------------------------------------------------
--
-- First block of the receiver chain. It has XGMII as an input.
-- Output is raw 64 bit data guaranteed to be aligned on the frame start and 
-- stripped of preamble and CRC, valid signal covering frame data,
-- and byte enable signal that shall be used in case data amount is not
-- 8 byte aligned. Another signal indicates either CRC error or line
-- signalized error, in which case frame should be discarded.
--
-- Byte enable signal is guaranteed to be all ones for whole frame except
-- for the last word, in case packet length is not 8 byte integer divisible.
--
-- This can work under assumption that minimum IPG in incoming stream is
-- 4 bytes. This means when T is on L0-L4, S cannot be on L5-L7 of the same
-- cycle and when T is on L5-L7 S cannot be on L0-L3 of the next cycle. Under
-- this condition DV is always at leased one cycle deasserted between
-- frames.
--
--
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package srl_pkg is
   component ssrl_bus is
   generic (
      g_width     : positive;
      g_delay     : positive
           );
   port (
      CLK         : in  std_logic;
      DATA_IN     : in  std_logic_vector(g_width - 1 downto 0);
      DATA_OUT    : out std_logic_vector(g_width - 1 downto 0)
        );
   end component;

   component ssrl is
   generic (
      g_delay     : positive
           );
   port (
      CLK         : in  std_logic;
      DATA_IN     : in  std_logic;
      DATA_OUT    : out std_logic
   );
   end component;

end package;




library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ssrl_bus is
   generic (
      g_width     : positive;
      g_delay     : positive
           );
   port (
      CLK         : in  std_logic;
      DATA_IN     : in  std_logic_vector(g_width - 1 downto 0);
      DATA_OUT    : out std_logic_vector(g_width - 1 downto 0)
        );
end entity;


architecture synthesis of ssrl_bus is

   type array_slv is array (g_width-1 downto 0) of 
                        std_logic_vector(g_delay-1 downto 0);
   signal shift_reg : array_slv;


begin


   shift_proc: process (CLK)
   begin
      if rising_edge(CLK) then
         for i in 0 to g_width-1 loop
             shift_reg(i) <= shift_reg(i)(g_delay-2 downto 0) & DATA_IN(i);
         end loop;
      end if;
   end process;
   
   output_proc : process (shift_reg)
   begin
      for i in 0 to g_width-1 loop
         DATA_OUT(i) <= shift_reg(i)(g_delay-1);
      end loop;
   end process;
   
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.srl_pkg.all;

entity ssrl is
   generic (
      g_delay     : positive
           );
   port (
      CLK         : in  std_logic;
      DATA_IN     : in  std_logic;
      DATA_OUT    : out std_logic
   );
end entity;


architecture synthesis of ssrl is


begin

   ssrl_bus_inst : ssrl_bus
   generic map (
      g_width     => 1,
      g_delay     => g_delay
           )
   port map (
      CLK         => CLK,
      DATA_IN(0)     => DATA_IN,
      DATA_OUT(0)    => DATA_OUT
        );
   
   
end architecture;


