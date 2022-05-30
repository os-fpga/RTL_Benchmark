---------------------------------------------------------------------- 
----                                                              ---- 
----  VHDL Wishbone TESTBENCH                                     ---- 
----                                                              ---- 
----  This file is part of the vhdl_wb_tb project                 ---- 
----  http://www.opencores.org/cores/vhdl_wb_tb/                  ---- 
----                                                              ---- 
----  This file contains constants for the test bench, such as    ----
----  register definitions.                                       ---- 
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
use work.wishbone_bfm_pkg.all;

-- package -----------------------------------------------------------
package tb_pkg is
  ----------------------------------------------------------------------
  --  address definitions
  ----------------------------------------------------------------------
  -- ??? model registers
  constant stimuator_base_c                  : integer := 16#00000000#;
  constant stimulator_register0_c            : integer := stimuator_base_c + 16#0000_0000#;
  constant stimulator_register1_c            : integer := stimuator_base_c + 16#0000_0004#;
  
  -- ??? model registers
  constant verifier_base_c                   : integer := 16#10000000#;
  constant verifier_register0_c              : integer := verifier_base_c + 16#0000_0000#;
  constant verifier_register1_c              : integer := verifier_base_c + 16#0000_0004#;
  constant verifier_register2_c              : integer := verifier_base_c + 16#0000_0008#;
----------------------------------------------------------------------
end package;
----------------------------------------------------------------------
---- end of file                                                  ---- 
----------------------------------------------------------------------