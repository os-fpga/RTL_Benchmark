----------------------------------------------------------------------  
----  mont_mult_sys_pipeline                                       ---- 
----                                                              ---- 
----  This file is part of the                                    ----
----    Modular Simultaneous Exponentiation Core project          ---- 
----    http://www.opencores.org/cores/mod_sim_exp/               ---- 
----                                                              ---- 
----  Description                                                 ---- 
----    n-bit montgomery multiplier with a pipelined systolic     ----
----    array                                                     ----
----                                                              ----
----  Dependencies:                                               ----
----    - x_shift_reg                                             ----
----    - adder_n                                                 ----
----    - d_flip_flop                                             ----
----    - systolic_pipeline                                       ----
----    - cell_1b_adder                                           ----
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


-- Structural description of the montgommery multiply pipeline
-- contains the x operand shift register, my adder, the pipeline and 
-- reduction adder. To do a multiplication, the following actions must take place:
-- 
--    * load in the x operand in the shift register using the xy bus and load_x
--    * place the y operand on the xy bus for the rest of the operation
--    * generate a start pulse of 1 clk cycle long on start
--    * wait for ready signal
--    * result is avaiable on the r bus
-- 
entity mont_mult_sys_pipeline is
  generic (
    n          : integer := 1536; -- width of the operands
    nr_stages  : integer := 96; -- total number of stages
    stages_low : integer := 32  -- lower number of stages
  );
  port (
    -- clock input
    core_clk : in std_logic;
    -- operand inputs
    xy       : in std_logic_vector((n-1) downto 0); -- bus for x or y operand
    m        : in std_logic_vector((n-1) downto 0); -- modulus
    -- result output
    r        : out std_logic_vector((n-1) downto 0);  -- result
    -- control signals
    start    : in std_logic;
    reset    : in std_logic;
    p_sel    : in std_logic_vector(1 downto 0);
    load_x   : in std_logic;
    ready    : out std_logic
  );
end mont_mult_sys_pipeline;

architecture Structural of mont_mult_sys_pipeline is
  constant stage_width : integer := n/nr_stages;
  constant bits_l      : integer := stage_width * stages_low;
  constant bits_h      : integer := n - bits_l;

  signal my               : std_logic_vector(n downto 0);
  signal my_h_cin         : std_logic;
  signal my_l_cout        : std_logic;
  signal r_pipeline       : std_logic_vector(n+1 downto 0);
  signal r_red            : std_logic_vector(n-1 downto 0);
  signal r_i              : std_logic_vector(n-1 downto 0);
  signal c_red_l          : std_logic_vector(2 downto 0);
  signal c_red_h          : std_logic_vector(2 downto 0);
  signal cin_red_h        : std_logic;
  signal r_sel            : std_logic;
  signal reset_multiplier : std_logic;
  signal start_multiplier : std_logic;
  signal m_inv            : std_logic_vector(n-1 downto 0);

  signal next_xi : std_logic;
  signal xi : std_logic;
begin

  -- register to store the x value in 
  -- outputs the operand in serial using a shift register 
  x_selection : x_shift_reg
  generic map(
    n  => n,
    t  => nr_stages,
    tl => stages_low
  )
  port map(
    clk    => core_clk,
    reset  => reset,
    x_in   => xy,
    load_x => load_x,
    next_x => next_xi,
    p_sel  => p_sel,
    xi     => xi
  );

  -- precomputation of my (m+y)
  -- lower part of pipeline
  my_adder_l : adder_n
  generic map(
    width       => bits_l,
    block_width => stage_width
  )
  port map(
    core_clk => core_clk,
    a        => m((bits_l-1) downto 0),
    b        => xy((bits_l-1) downto 0),
    cin      => '0',
    cout     => my_l_cout,
    r        => my((bits_l-1) downto 0)
  );
	--higher part of pipeline
  my_adder_h : adder_n
  generic map(
    width       => bits_h,
    block_width => stage_width
  )
  port map(
    core_clk => core_clk,
    a        => m((n-1) downto bits_l),
    b        => xy((n-1) downto bits_l),
    cin      => my_h_cin,
    cout     => my(n),
    r        => my((n-1) downto bits_l)
  );
  
  -- if higher pipeline selected, do not give through carry, but 0
	my_h_cin <= '0' when (p_sel(1) and (not p_sel(0)))='1' else my_l_cout;
	
	-- multiplication
	-- multiplier is reset every calculation or reset
	reset_multiplier <= reset or start;

  -- start is delayed 1 cycle
  delay_1_cycle : d_flip_flop
  port map(
    core_clk => core_clk,
    reset    => reset,
    din      => start,
    dout     => start_multiplier
  );

  the_multiplier : systolic_pipeline
  generic map(
    n  => n, -- width of the operands (# bits)
    t  => nr_stages,  -- number of stages (divider of n) >= 2
    tl => stages_low
  )
  port map(
    core_clk => core_clk,
    my       => my,
    y        => xy,
    m        => m,
    xi       => xi,
    start    => start_multiplier,
    reset    => reset_multiplier,
    p_sel    => p_sel,
    ready    => ready,
    next_x   => next_xi,
    r        => r_pipeline
  );
	
	-- post-computation (reduction)
	-- if the result is greater than the modulus, a final reduction with m is needed
	-- this is done by using an adder and the 2s complement of m
	m_inv <= not(m);
	
	-- calculate r_l - m_l
  reduction_adder_l : adder_n
  generic map(
    width       => bits_l,
    block_width => stage_width
  )
  port map(
    core_clk => core_clk,
    a        => m_inv((bits_l-1) downto 0),
    b        => r_pipeline((bits_l-1) downto 0),
    cin      => '1', -- +1 for 2s complement
    cout     => c_red_l(0),
    r        => r_red((bits_l-1) downto 0)
  );
  
  -- pipeline result may be greater, check following bits
  reduction_adder_l_a : cell_1b_adder
  port map(
    a    => '1', -- for 2s complement of m
    b    => r_pipeline(bits_l),
    cin  => c_red_l(0),
    cout => c_red_l(1)
    --r => 
  );

  reduction_adder_l_b : cell_1b_adder
  port map(
    a     => '1', -- for 2s complement of m
    b     => r_pipeline(bits_l+1),
    cin   => c_red_l(1),
    cout  => c_red_l(2)
    -- r => 
  );

  -- pass cout from lower stages if full pipeline selected, else '1' (+1 for 2s complement)
  cin_red_h <= c_red_l(0) when p_sel(0) = '1' else '1';
	
  reduction_adder_h : adder_n
  generic map(
    width       => bits_h,
    block_width => stage_width
  )
  port map(
    core_clk => core_clk,
    a        => m_inv((n-1) downto bits_l),
    b        => r_pipeline((n-1) downto bits_l),
    cin      => cin_red_h,
    cout     => c_red_h(0),
    r        => r_red((n-1) downto bits_l)
  );
  
  -- pipeline result may be greater, check following bits
  reduction_adder_h_a : cell_1b_adder
  port map(
    a     => '1', -- for 2s complement of m
    b     => r_pipeline(n),
    cin   => c_red_h(0),
    cout  => c_red_h(1)
  );

  reduction_adder_h_b : cell_1b_adder
  port map(
    a     => '1', -- for 2s complement of m
    b     => r_pipeline(n+1),
    cin   => c_red_h(1),
    cout  => c_red_h(2)
  );
  
  -- select the correct result
  r_sel <= (c_red_h(2) and p_sel(1)) or (c_red_l(2) and (p_sel(0) and (not p_sel(1))));
  r_i <= r_red when r_sel = '1' else r_pipeline((n-1) downto 0);
  
  -- output
  r <= r_i;
end Structural;