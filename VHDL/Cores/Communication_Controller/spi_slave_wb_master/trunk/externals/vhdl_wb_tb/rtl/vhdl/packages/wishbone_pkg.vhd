---------------------------------------------------------------------- 
----                                                              ---- 
----  VHDL Wishbone TESTBENCH                                     ---- 
----                                                              ---- 
----  This file is part of the vhdl_wb_tb project                 ---- 
----  http://www.opencores.org/cores/vhdl_wb_tb/                  ---- 
----                                                              ---- 
----  This file contains the wishbone_pkg package and defines     ----
----  basic wishbone types.                                       ---- 
----                                                              ---- 
----  This file bases on the file wishbone_pkg.vhd located at     ----
----  https://github.com/twlostow/dsi-shield/blob/master/hdl/ip_cores/local/wishbone_pkg.vhd ---
----  See this file also for the authors name.                    ---- 
----  Its original file was licensed under LGPL 3.0               ---- 
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
use work.my_project_pkg.all;

-- package -----------------------------------------------------------
package wishbone_pkg is

  subtype wishbone_address_t is std_logic_vector(wishbone_address_width_c-1 downto 0);
  subtype wishbone_data_t is std_logic_vector(wishbone_data_width_c-1 downto 0);
  subtype wishbone_byte_select_t is std_logic_vector((wishbone_address_width_c/8)-1 downto 0);
  --subtype wishbone_cycle_type_t is std_logic_vector(2 downto 0);
  --subtype wishbone_burst_type_t is std_logic_vector(1 downto 0);

  type wishbone_master_out_t is record
    -- 2.2.2 Signals Common to MASTER and SLAVE Interfaces 
    clk : std_logic; -- clock [mandatory RULE 3.40]
    dat : wishbone_data_t; -- data []
    rst : std_logic; -- reset [mandatory RULE 3.40]
    tgd : wishbone_tag_data_t; -- data tag []
    -- 2.2.3 MASTER Signals
    adr : wishbone_address_t; -- address [optional]
    cyc : std_logic; -- cycle [mandatory RULE 3.40]
    lock: std_logic; -- lock []
    sel : wishbone_byte_select_t;
    stb : std_logic; -- strobe [mandatory RULE 3.40]
    tga : wishbone_tag_address_t; -- address tag []
    tgc : wishbone_tag_cycle_t; -- cycle tag []
    we  : std_logic; -- write enable []
  end record wishbone_master_out_t;
  subtype wishbone_slave_in_t is wishbone_master_out_t;

  type wishbone_slave_out_t is record
    -- 2.2.2 Signals Common to MASTER and SLAVE Interfaces 
    dat   : wishbone_data_t; -- read data []
    tgd   : wishbone_tag_data_t; -- read data tag []
    -- 2.2.4 SLAVE Signals 
    ack   : std_logic; -- acknowledge [mandatory RULE 3.40]
    err   : std_logic; -- error [optional PERMISSION 3.20]
    rty   : std_logic; -- retry [optional PERMISSION 3.25]
    --stall : std_logic;
    int   : std_logic; -- interrupt [non WB signal]
  end record wishbone_slave_out_t;
  subtype wishbone_master_in_t is wishbone_slave_out_t;

  -- subtype wishbone_device_descriptor_t is std_logic_vector(255 downto 0);

  -- type wishbone_byte_select_array_t is array(natural range <>) of wishbone_byte_select_t; 
  -- type wishbone_data_array_t is array(natural range <>) of wishbone_data_t; 
  type wishbone_address_array_t is array(natural range <>) of wishbone_address_t;
  type wishbone_master_out_array_t is array (natural range <>) of wishbone_master_out_t;
  type wishbone_slave_in_array_t is array (natural range <>) of wishbone_slave_in_t;
  -- subtype wishbone_slave_in_array_t is wishbone_master_out_array_t;
  type wishbone_slave_out_array_t is array (natural range <>) of wishbone_slave_out_t;
  --type wishbone_master_in_array_t is array (natural range <>) of wishbone_master_in_t;
  subtype wishbone_master_in_array_t is wishbone_slave_out_array_t;

  constant wb_master_out_idle_c : wishbone_master_out_t := (
                                                        clk  =>  '0',
                                                        dat  =>  wishbone_data_of_unused_address_c,
                                                        rst  =>  '0',
                                                        tgd  =>  (others=>'0'),
                                                        adr  =>  (others=>'U'),
                                                        cyc  =>  '0',
                                                        lock =>  '0',
                                                        sel  =>  (others=>'0'),
                                                        stb  =>  '0',
                                                        tga  =>  (others=>'0'),
                                                        tgc  =>  (others=>'0'),
                                                        we   =>  '0'
                                                        );

  -- constant cc_dummy_address : std_logic_vector(wishbone_address_width_c-1 downto 0) :=(others => 'X');
  -- constant cc_dummy_data : std_logic_vector(wishbone_address_width_c-1 downto 0) := (others => 'X');
  -- constant cc_dummy_sel : std_logic_vector(wishbone_data_width_c/8-1 downto 0) := (others => 'X');
  -- constant cc_dummy_slave_in : wishbone_slave_in_t :=('0', '0', cc_dummy_address, cc_dummy_sel, 'X', cc_dummy_data);
  -- constant cc_dummy_master_out : wishbone_master_out_t := cc_dummy_slave_in;

  -- -- Dangerous! Will stall a bus.
  -- constant cc_dummy_slave_out : wishbone_slave_out_t :=('X', 'X', 'X', 'X', 'X', cc_dummy_data);
  -- constant cc_dummy_master_in : wishbone_master_in_t := cc_dummy_slave_out;

  -- constant cc_dummy_address_array : wishbone_address_array_t(0 downto 0) := (0 => cc_dummy_address);

end wishbone_pkg;

-- package body ------------------------------------------------------
package body wishbone_pkg is
end wishbone_pkg;
----------------------------------------------------------------------
---- end of file                                                  ---- 
----------------------------------------------------------------------