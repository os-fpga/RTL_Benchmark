-------------------------------------------------------------------------------
--
-- (C) Copyright 2017 DFC Design, s.r.o., Brno, Czech Republic
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
-- This is minimal package of commonly used math functions. It is not
-- meant for synthesis to hw operators. It is meant for use in signal and
-- port definitions as a convenient way to calculate vector widths.
--
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package math_pack is
   -- Return integer equal to or higher than 2 base logarithm of i
   function log2(i : natural) return integer;

   -- Return smaller of two integers
   function min(a : integer; b: integer) return integer;
   -- Return higher of two integers
   function max(a : integer; b: integer) return integer;

end package;

package body math_pack is

   function log2(i : natural) return integer is
      variable ret      : integer := 0;
   begin

      while 2**ret < i loop
         ret := ret + 1;
      end loop;

      return ret;
   end function;

   function min(a : integer; b: integer) return integer is
   begin
      if a > b then
         return b;
      else
         return a;
      end if;
   end function;

   function max(a : integer; b: integer) return integer is
   begin
      if a < b then
         return b;
      else
         return a;
      end if;
   end function;

end package body;
