---------------------------------------------------------------------- 
----                                                              ---- 
----  VHDL Wishbone TESTBENCH                                     ---- 
----                                                              ---- 
----  This file is part of the vhdl_wb_tb project                 ---- 
----  http://www.opencores.org/cores/vhdl_wb_tb/                  ---- 
----                                                              ---- 
----  This file contains the project specific defines             ----
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

-- package -----------------------------------------------------------
package my_project_pkg is

  constant wishbone_address_width_c : integer := 32;
  constant wishbone_data_width_c    : integer := 32;
  constant wishbone_data_of_unused_address_c : std_logic_vector(wishbone_data_width_c-1 DOWNTO 0) := X"DEADDEAD"; -- "X" might lead to less resources. Meaningful value might ease debugging
  
  constant exit_simulator_at_tc_end_c        : std_logic_vector := "0"; -- "1": exit simulator at end of tc_xxxx file. used for scripted simulation runs; 
                                                                        -- "0": just pause simulator at end of tc_xxx file. used for manual simulation runs.
  
  subtype wishbone_tag_data_t is std_logic_vector(1 downto 0);
  subtype wishbone_tag_address_t is std_logic_vector(1 downto 0);
  subtype wishbone_tag_cycle_t is std_logic_vector(1 downto 0);

  --type wishbone_interface_mode_t is (CLASSIC, PIPELINED);
  --type wishbone_address_granularity_t is (BYTE, WORD);
  constant zero_c : std_logic_vector(511 downto 0) := (others => '0');
end my_project_pkg;

-- package body ------------------------------------------------------
package body my_project_pkg is
end my_project_pkg;
----------------------------------------------------------------------
---- end of file                                                  ---- 
----------------------------------------------------------------------
