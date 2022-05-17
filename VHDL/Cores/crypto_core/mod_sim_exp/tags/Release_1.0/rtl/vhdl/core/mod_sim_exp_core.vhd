----------------------------------------------------------------------  
----  mod_sim_exp_core                                            ---- 
----                                                              ---- 
----  This file is part of the                                    ----
----    Modular Simultaneous Exponentiation Core project          ---- 
----    http://www.opencores.org/cores/mod_sim_exp/               ---- 
----                                                              ---- 
----  Description                                                 ---- 
----    toplevel of a modular simultaneous exponentiation core    ----
----    using a pipelined montgommery multiplier with split       ----
----    pipeline and auto-run support                             ----
----                                                              ----
----  Dependencies:                                               ----
----    - mont_mult_sys_pipeline                                  ----
----    - operand_mem                                             ----
----    - fifo_primitive                                          ----
----    - mont_ctrl                                               ----
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

-- toplevel of the modular simultaneous exponentiation core
-- contains an operand and modulus ram, multiplier, an exponent fifo
-- and control logic
entity mod_sim_exp_core is
  port(
    clk   : in  std_logic;
    reset : in  std_logic;
      -- operand memory interface (plb shared memory)
    write_enable : in  std_logic; -- write data to operand ram
    data_in      : in  std_logic_vector (31 downto 0);  -- operand ram data in
    rw_address   : in  std_logic_vector (8 downto 0);   -- operand ram address bus
    data_out     : out std_logic_vector (31 downto 0);  -- operand ram data out
    collision    : out std_logic; -- write collision
      -- op_sel fifo interface
    fifo_din    : in  std_logic_vector (31 downto 0); -- exponent fifo data in
    fifo_push   : in  std_logic;  -- push data in exponent fifo
    fifo_full   : out std_logic;  -- high if fifo is full
    fifo_nopush : out std_logic;  -- high if error during push
      -- control signals
    start          : in  std_logic; -- start multiplication/exponentiation
    run_auto       : in  std_logic; -- single multiplication if low, exponentiation if high
    ready          : out std_logic; -- calculations done
    x_sel_single   : in  std_logic_vector (1 downto 0); -- single multiplication x operand selection
    y_sel_single   : in  std_logic_vector (1 downto 0); -- single multiplication y operand selection
    dest_op_single : in  std_logic_vector (1 downto 0); -- result destination operand selection
    p_sel          : in  std_logic_vector (1 downto 0); -- pipeline part selection
    calc_time      : out std_logic
  );
end mod_sim_exp_core;


architecture Structural of mod_sim_exp_core is
  constant n : integer := 1536;
  constant t : integer := 96;
  constant tl : integer := 32;
  
  -- data busses
  signal xy   : std_logic_vector(n-1 downto 0);  -- x and y operand data bus RAM -> multiplier
  signal m    : std_logic_vector(n-1 downto 0);  -- modulus data bus RAM -> multiplier
  signal r    : std_logic_vector(n-1 downto 0);  -- result data bus RAM <- multiplier
  
  -- control signals
  signal op_sel           : std_logic_vector(1 downto 0); -- operand selection 
  signal result_dest_op   : std_logic_vector(1 downto 0); -- result destination operand
  signal mult_ready       : std_logic;
  signal start_mult       : std_logic;
  signal load_op          : std_logic;
  signal load_x         : std_logic;
  signal load_m           : std_logic;
  signal load_result      : std_logic;
  
  -- fifo signals
  signal fifo_empty : std_logic;
  signal fifo_pop   : std_logic;
  signal fifo_nopop : std_logic;
  signal fifo_dout  : std_logic_vector(31 downto 0);
begin

  -- The actual multiplier
  the_multiplier : mont_mult_sys_pipeline 
  generic map(
    n          => n,
    nr_stages  => t, --(divides n, bits_low & (n-bits_low))
    stages_low => tl
  )
  port map(
    core_clk => clk,
    xy       => xy,
    m        => m,
    r        => r,
    start    => start_mult,
    reset    => reset,
    p_sel    => p_sel,
    load_x   => load_x,
    ready    => mult_ready
  );

  -- Block ram memory for storing the operands and the modulus
  the_memory : operand_mem 
  port map(
    data_in        => data_in,
    data_out       => data_out,
    rw_address     => rw_address,
    op_sel         => op_sel,
    xy_out         => xy,
    m              => m,
    result_in      => r,
    load_op        => load_op,
    load_m         => load_m,
    load_result    => load_result,
    result_dest_op => result_dest_op,
    collision      => collision,
    clk            => clk
  );

	load_op <= write_enable when (rw_address(8) = '0') else '0';
	load_m <= write_enable when (rw_address(8) = '1') else '0';
	result_dest_op <= dest_op_single when run_auto = '0' else "11"; -- in autorun mode we always store the result in operand3
	
  -- A fifo for auto-run operand selection
  the_exponent_fifo : fifo_primitive 
  port map(
    clk    => clk,
    din    => fifo_din,
    dout   => fifo_dout,
    empty  => fifo_empty,
    full   => fifo_full,
    push   => fifo_push,
    pop    => fifo_pop,
    reset  => reset,
    nopop  => fifo_nopop,
    nopush => fifo_nopush
  );
	
  -- The control logic for the core
  the_control_unit : mont_ctrl 
  port map(
    clk              => clk,
    reset            => reset,
    start            => start,
    x_sel_single     => x_sel_single,
    y_sel_single     => y_sel_single,
    run_auto         => run_auto,
    op_buffer_empty  => fifo_empty,
    op_sel_buffer    => fifo_dout,
    read_buffer      => fifo_pop,
    buffer_noread    => fifo_nopop,
    done             => ready,
    calc_time        => calc_time,
    op_sel           => op_sel,
    load_x           => load_x,
    load_result      => load_result,
    start_multiplier => start_mult,
    multiplier_ready => mult_ready
  );

end Structural;
