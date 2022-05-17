----------------------------------------------------------------------  
----  standard_stage                                              ---- 
----                                                              ---- 
----  This file is part of the                                    ----
----    Modular Simultaneous Exponentiation Core project          ---- 
----    http://www.opencores.org/cores/mod_sim_exp/               ---- 
----                                                              ---- 
----  Description                                                 ---- 
----    standard stage for use in the montgommery multiplier      ----
----    systolic array pipeline                                   ----
----                                                              ----
----  Dependencies:                                               ----
----    - standard_cell_block                                     ----
----    - d_flip_flop                                             ----
----    - register_n                                              ----
----    - register_1b                                             ----
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

-- standard stage for use in the montgommery multiplier pipeline
-- the result is available after 1 clock cycle
entity standard_stage is
  generic(
    width : integer := 32
  );
  port(
    -- clock input
    core_clk : in  std_logic;
    -- modulus and y operand input (width)-bit
    my       : in  std_logic_vector((width-1) downto 0);
    y        : in  std_logic_vector((width-1) downto 0);
    m        : in  std_logic_vector((width-1) downto 0);
    -- q and x operand input (serial input)
    xin      : in  std_logic;
    qin      : in  std_logic;
    -- q and x operand output (serial output)
    xout     : out std_logic;
    qout     : out std_logic;
    -- msb input (lsb from next stage, for shift right operation)
    a_msb    : in  std_logic;
    -- carry out(clocked) and in
    cin      : in  std_logic;
    cout     : out std_logic;
    -- control singals
    start    : in  std_logic;
    reset    : in  std_logic;
    done : out std_logic;
    -- result out
    r    : out std_logic_vector((width-1) downto 0)
  );
end standard_stage;


architecture Structural of standard_stage is
  -- output
  signal cout_i     : std_logic;
  signal r_i        : std_logic_vector((width-1) downto 0);
  signal r_i_reg    : std_logic_vector((width-1) downto 0);

  -- interconnect
  signal a : std_logic_vector((width-1) downto 0);

begin

	-- map internal signals to outputs
	r <= r_i_reg;
	
	-- a is equal to the right shifted version(/2) of r_reg with a_msb as MSB
	a <= a_msb & r_i_reg((width-1) downto 1);
	
	-- structure of (width) standard_cell_blocks
  cell_block : standard_cell_block
  generic map(
    width => width
  )
  port map(
    my   => my,
    y    => y,
    m    => m,
    x    => xin,
    q    => qin,
    a    => a,
    cin  => cin,
    cout => cout_i,
    r    => r_i
  );
	
  -- stage done signal
  -- 1 cycle after start of stage
  done_signal : d_flip_flop
  port map(
    core_clk  => core_clk,
    reset => reset,
    din   => start,
    dout  => done
  );

  -- output registers
  --------------------
  
  -- result register (width)-bit
  result_reg : register_n
  generic map(
    width => width
  )
  port map(
    core_clk => core_clk,
    ce    => start,
    reset => reset,
    din   => r_i,
    dout  => r_i_reg
  );
  
  -- xout register
  xout_reg : register_1b
  port map(
    core_clk => core_clk,
    ce    => start,
    reset => reset,
    din   => xin,
    dout  => xout
  );
  
  -- qout register
  qout_reg : register_1b
  port map(
    core_clk => core_clk,
    ce    => start,
    reset => reset,
    din   => qin,
    dout  => qout
  );

  -- carry out register
  cout_reg : register_1b
  port map(
    core_clk => core_clk,
    ce    => start,
    reset => reset,
    din   => cout_i,
    dout  => cout
  );
  
end Structural;