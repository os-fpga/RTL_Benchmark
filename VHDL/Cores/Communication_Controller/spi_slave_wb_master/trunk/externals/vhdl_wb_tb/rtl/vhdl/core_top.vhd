---------------------------------------------------------------------- 
----                                                              ---- 
----  VHDL Wishbone TESTBENCH                                     ---- 
----                                                              ---- 
----  This file is part of the vhdl_wb_tb project                 ---- 
----  http://www.opencores.org/cores/vhdl_wb_tb/                  ---- 
----                                                              ---- 
----  This file contains the top functional module of the design  ----
----  under test. The top functional module will be enclosed by   ----
----  the top module for synthesis or the tb_top for simulation.  ---- 
----  The top module can contain some synthesis specific code,    ----
----  where the tb_top contains simulation specific code.          ----
----                                                              ---- 
----  To Do:                                                      ---- 
----   -                                                          ---- 
----                                                              ---- 
----  Author(s):                                                  ---- 
----      - Sinx, sinx@opencores.org                              ---- 
----                                                              ---- 
---------------------------------------------------------------------- 
----    SVN information
----
----      $URL:  $
---- $Revision:  $
----     $Date:  $
----   $Author:  $
----       $Id:  $
---------------------------------------------------------------------- 
----                                                              ---- 
---- Copyright (C) 2018 Authors and OPENCORES.ORG                 ---- 
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
---- PURPOSE.  See the GNU Lesser General Public License for more ---- 
---- details.                                                     ---- 
----                                                              ---- 
---- You should have received a copy of the GNU Lesser General    ---- 
---- Public License along with this source; if not, download it   ---- 
---- from http://www.opencores.org/lgpl.shtml                     ---- 
----                                                              ---- 
----------------------------------------------------------------------

-- library -----------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.convert_pkg.all;
use work.wishbone_pkg.all;

-- entity ------------------------------------------------------------
entity core_top is
  generic(
    number_of_in_signals_g          : natural := 1;
    number_of_out_signals_g         : natural := 1
    );
  port(
    clock_i                         : in std_logic;
    reset_i                         : in std_logic;
    signals_i                       : in std_logic_vector(number_of_in_signals_g-1 downto 0);
    signals_o                       : out std_logic_vector(number_of_out_signals_g-1 downto 0)
    );
end core_top;

-- architecture ------------------------------------------------------
architecture rtl of core_top is
  ------------------------------------------------------------------------------
  -- signal declaration
  ------------------------------------------------------------------------------
  signal    shift_register_r   : std_logic_vector (number_of_out_signals_g-1 downto 0);
  signal    old_shift_clock_r  : std_logic := '0';
  ------------------------------------------------------------------------------
begin
  ------------------------------------------------------------------------------
  -- module instantiation
  ------------------------------------------------------------------------------
  proc_shift_register : process (all)
    begin
      if (reset_i = '1' ) then
        shift_register_r <= (others => '0');
      elsif (rising_edge(clock_i)) then
        old_shift_clock_r <= signals_i(1);
        if (signals_i(1) = '1' AND old_shift_clock_r= '0') then
          shift_register_r        <= shift_register_r(shift_register_r'left-1 downto 0) & signals_i(0);
        end if;
      end if;
    end process;
  ------------------------------------------------------------------------------
  signals_o <= shift_register_r;
  ------------------------------------------------------------------------------
end rtl;
----------------------------------------------------------------------
---- end of file                                                  ---- 
----------------------------------------------------------------------