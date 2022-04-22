----------------------------------------------------------------------  
----  operand_mem                                                 ---- 
----                                                              ---- 
----  This file is part of the                                    ----
----    Modular Simultaneous Exponentiation Core project          ---- 
----    http://www.opencores.org/cores/mod_sim_exp/               ---- 
----                                                              ---- 
----  Description                                                 ---- 
----    BRAM memory and logic to the store 4 (1536-bit) operands  ----
----    and the modulus for the montgomery multiplier             ----            
----                                                              ---- 
----  Dependencies:                                               ----
----    - operand_ram                                             ----
----    - modulus_ram                                             ----
----                                                              ----
----  Authors:                                                    ----
----      - Geoffrey Ottoy, DraMCo research group                 ----
----      - Jonas De Craene, JonasDC@opencores.org                ---- 
----                                                              ---- 
---------------------------------------------------------------------- 
----                                                              ---- 
---- Copyright (C) 2011 DraMCo research group and OPENCORES.ORG   ---- 
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library mod_sim_exp;
use mod_sim_exp.mod_sim_exp_pkg.all;


entity operand_mem is
  generic(n : integer := 1536
  );
  port(
      -- data interface (plb side)
    data_in    : in  std_logic_vector(31 downto 0);
    data_out   : out  std_logic_vector(31 downto 0);
    rw_address : in  std_logic_vector(8 downto 0);
      -- address structure:
      -- bit:  8   -> '1': modulus
      --              '0': operands
      -- bits: 7-6 -> operand_in_sel in case of bit 8 = '0'
      --              don't care in case of modulus
      -- bits: 5-0 -> modulus_addr / operand_addr resp.

      -- operand interface (multiplier side)
    op_sel    : in  std_logic_vector(1 downto 0);
    xy_out    : out  std_logic_vector(1535 downto 0);
    m         : out  std_logic_vector(1535 downto 0);
    result_in : in std_logic_vector(1535 downto 0);
      -- control signals
    load_op        : in std_logic;
    load_m         : in std_logic;
    load_result    : in std_logic;
    result_dest_op : in std_logic_vector(1 downto 0);
    collision      : out std_logic;
      -- system clock
    clk : in  std_logic
  );
end operand_mem;


architecture Behavioral of operand_mem is
  signal xy_data_i        : std_logic_vector(31 downto 0);
  signal xy_addr_i        : std_logic_vector(5 downto 0);
  signal operand_in_sel_i : std_logic_vector(1 downto 0);
  signal collision_i      : std_logic;

  signal xy_op_i : std_logic_vector(1535 downto 0);

  signal m_addr_i  : std_logic_vector(5 downto 0);
  signal write_m_i : std_logic;
  signal m_data_i  : std_logic_vector(31 downto 0);

begin

	-- map outputs
	xy_out <= xy_op_i;
	collision <= collision_i;

	-- map inputs
	xy_addr_i <= rw_address(5 downto 0);
	m_addr_i <= rw_address(5 downto 0);
	operand_in_sel_i <= rw_address(7 downto 6);
	xy_data_i <= data_in;
	m_data_i <= data_in;
	write_m_i <= load_m;

  -- xy operand storage
  xy_ram : operand_ram 
  port map(
    clk             => clk,
    collision       => collision_i,
    operand_addr    => xy_addr_i,
    operand_in      => xy_data_i,
    operand_in_sel  => operand_in_sel_i,
    result_out      => data_out,
    write_operand   => load_op,
    operand_out     => xy_op_i,
    operand_out_sel => op_sel,
    result_dest_op  => result_dest_op,
    write_result    => load_result,
    result_in       => result_in
  );

  -- modulus storage
  m_ram : modulus_ram
  port map(
    clk           => clk,
    modulus_addr  => m_addr_i,
    write_modulus => write_m_i,
    modulus_in    => m_data_i,
    modulus_out   => m
  );
	
end Behavioral;
