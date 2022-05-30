---------------------------------------------------------------------- 
----                                                              ---- 
----  VHDL Wishbone TESTBENCH                                     ---- 
----                                                              ---- 
----  This file is part of the vhdl_wb_tb project                 ---- 
----  https://opencores.org/project/vhdl_wb_tb                    ---- 
----                                                              ---- 
----  This file contains the highest (top) module for synthesis.  ----
----  Like tb_top it instantiates the core_top module and         ----
----  provides parameters/generics. Where the tb_top module       ----
----  provides parameters for simulation this file provides       ----
----  parameters for synthesis.                                   ----
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
entity top is
  port( 
    clock_i                         : in std_logic;  
    signals_i                       : in std_logic_vector(7 downto 0);
    signals_o                       : out std_logic_vector(7 downto 0)
    );            
end entity top;

-- architecture ------------------------------------------------------
architecture rtl of top is
  -----------------------------------------------------------------------------
  -- constant number_of_stimulus_signals_c : integer := 8;
  -- signal verify_s                     : std_logic_vector(number_of_verify_signals_c-1 downto 0);
  -----------------------------------------------------------------------------
begin
  -----------------------------------------------------------------------------
  -- instance of design
  core_top_inst : entity work.core_top
    generic map(
      number_of_in_signals_g              => 8,
      number_of_out_signals_g             => 8
      )
    port map(
      clock_i                             => clock_i,
      reset_i                             => '0',
      signals_i                           => signals_i,
      signals_o                           => signals_o
      );
  -----------------------------------------------------------------------------
end rtl;
----------------------------------------------------------------------
---- end of file                                                  ---- 
----------------------------------------------------------------------