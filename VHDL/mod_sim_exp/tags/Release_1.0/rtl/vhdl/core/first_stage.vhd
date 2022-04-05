----------------------------------------------------------------------  
----  first_stage                                                 ---- 
----                                                              ---- 
----  This file is part of the                                    ----
----    Modular Simultaneous Exponentiation Core project          ---- 
----    http://www.opencores.org/cores/mod_sim_exp/               ---- 
----                                                              ---- 
----  Description                                                 ---- 
----    first stage for use in the montgommery multiplier         ----
----    systolic array pipeline                                   ----
----                                                              ----
----  Dependencies:                                               ----
----    - standard_cell_block                                     ----
----    - d_flip_flop                                             ----
----    - register_n                                              ----
----    - register_1b                                             ----
----    - cell_1b_mux                                             ----
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

-- first stage for use in the montgommery multiplier pipeline
-- generates the q signal for all following stages
-- the result is available after 1 clock cycle
entity first_stage is
  generic(
    width : integer := 16 -- must be the same as width of the standard stage
  );
  port(
    -- clock input
    core_clk : in  std_logic;
    -- modulus and y operand input (width+1)-bit
    my       : in  std_logic_vector((width) downto 0);
    y        : in  std_logic_vector((width) downto 0);
    m        : in  std_logic_vector((width) downto 0);
    -- x operand input (serial input)
    xin      : in  std_logic;
    -- q and x operand output (serial output)
    xout     : out std_logic;
    qout     : out std_logic;
    -- msb input (lsb from next stage, for shift right operation)
    a_msb    : in  std_logic;
    -- carry out
    cout     : out std_logic;
    -- control signals
    start    : in  std_logic;
    reset    : in  std_logic;
    done     : out std_logic;
    -- result out
    r        : out std_logic_vector((width-1) downto 0)
  );
end first_stage;


architecture Structural of first_stage is
  -- output
  signal cout_i     : std_logic;
  signal r_i        : std_logic_vector((width-1) downto 0);
  signal r_i_reg    : std_logic_vector((width-1) downto 0);
  signal qout_i      : std_logic;

  -- interconnection
  signal first_res   : std_logic;
  signal c_first_res : std_logic;
  signal a           : std_logic_vector((width) downto 0);

begin
	
	-- map internal signals to outputs
	r <= r_i_reg;
	
	-- a is equal to the right shifted version(/2) of r_reg with a_msb as MSB
	a <= a_msb & r_i_reg;

	-- compute first q and carry
	qout_i <= a(0) xor (y(0) and xin);
	c_first_res <= a(0) and first_res;
	
  first_cell : cell_1b_mux
  port map(
    my     => my(0),
    y      => y(0),
    m      => m(0),
    x      => xin,
    q      => qout_i,
    result => first_res
  );

  -- structure of (width) standard_cell_blocks
  cell_block : standard_cell_block
  generic map(
    width => width
  )
  port map(
    my   => my(width downto 1),
    y    => y(width downto 1),
    m    => m(width downto 1),
    x    => xin,
    q    => qout_i,
    a    => a(width downto 1),
    cin  => c_first_res,
    cout => cout_i,
    r    => r_i((width-1) downto 0)
  );

  -- stage done signal
  -- 1 cycle after start of stage
  done_signal : d_flip_flop
  port map(
    core_clk => core_clk,
    reset    => reset,
    din      => start,
    dout     => done
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
    ce       => start,
    reset    => reset,
    din      => r_i,
    dout     => r_i_reg
  );

  -- xout register
  xout_reg : register_1b
  port map(
    core_clk => core_clk,
    ce       => start,
    reset    => reset,
    din      => xin,
    dout     => xout
  );
  
  -- qout register
  qout_reg : register_1b
  port map(
    core_clk => core_clk,
    ce       => start,
    reset    => reset,
    din      => qout_i,
    dout     => qout
  );

  -- carry out register
  cout_reg : register_1b
  port map(
    core_clk => core_clk,
    ce       => start,
    reset    => reset,
    din      => cout_i,
    dout     => cout
  );

end Structural;
