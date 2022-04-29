----------------------------------------------------------------------  
----  last_stage                                                 ---- 
----                                                              ---- 
----  This file is part of the                                    ----
----    Modular Simultaneous Exponentiation Core project          ---- 
----    http://www.opencores.org/cores/mod_sim_exp/               ---- 
----                                                              ---- 
----  Description                                                 ---- 
----    last stage for use in the montgommery multiplier          ----
----    systolic array pipeline                                   ----
----                                                              ----
----  Dependencies:                                               ----
----    - standard_cell_block                                     ----
----    - register_n                                              ----
----    - cell_1b                                                 ----
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

-- last stage for use in the montgommery multiplier pipeline
-- the result is available after 1 clock cycle
entity last_stage is
  generic(
    width : integer := 16 -- must be the same as width of the standard stage
  );
  port(
    -- clock input
    core_clk : in  std_logic;
    -- modulus and y operand input (width(-1))-bit
    my       : in  std_logic_vector((width-1) downto 0);
    y        : in  std_logic_vector((width-2) downto 0);
    m        : in  std_logic_vector((width-2) downto 0);
    -- q and x operand input (serial input)
    xin      : in  std_logic;
    qin      : in  std_logic;
    -- carry in
    cin      : in  std_logic;
    -- control signals
    start    : in  std_logic;
    reset    : in  std_logic;
    -- result out
    r        : out std_logic_vector((width+1) downto 0)
  );
end last_stage;


architecture Structural of last_stage is
  -- input
  signal my_i  : std_logic_vector(width downto 0);
  signal m_i   : std_logic_vector(width downto 0);
  signal y_i   : std_logic_vector(width downto 0);
  
  -- output
  signal r_i     : std_logic_vector((width+1) downto 0);
  signal r_i_reg : std_logic_vector((width+1) downto 0);

  -- interconnection
  signal carry : std_logic;
	signal a     : std_logic_vector((width) downto 0);
	
begin
	-- map internal signals to outputs
	r <= r_i_reg;
	
	-- map inputs to internal signals
	my_i <= '0' & my;
	m_i <= "00" & m;
	y_i <= "00" & y;

  -- a is equal to the right shifted version(/2) of r_reg
	a <= r_i_reg((width+1) downto 1);
	
	-- structure of (width) standard_cell_blocks
  cell_block : standard_cell_block
  generic map(
    width => width
  )
  port map(
    my   => my_i(width-1 downto 0),
    y    => y_i(width-1 downto 0),
    m    => m_i(width-1 downto 0),
    x    => xin,
    q    => qin,
    a    => a((width-1) downto 0),
    cin  => cin,
    cout => carry,
    r    => r_i((width-1) downto 0)
  );

  -- last cell of the pipeline
  last_cell : cell_1b
  port map(
    my   => my_i(width),
    y    => y_i(width),
    m    => m_i(width),
    x    => xin,
    q    => qin,
    a    => a(width),
    cin  => carry,
    cout => r_i(width+1),
    r    => r_i(width)
  );

  -- output register (width+2)-bit
  result_reg : register_n
  generic map(
    width => (width+2)
  )
  port map(
    core_clk => core_clk,
    ce       => start,
    reset    => reset,
    din      => r_i,
    dout     => r_i_reg
  );
	
end Structural;