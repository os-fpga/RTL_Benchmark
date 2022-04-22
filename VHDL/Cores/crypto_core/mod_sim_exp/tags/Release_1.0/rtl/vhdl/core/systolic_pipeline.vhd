----------------------------------------------------------------------  
----  systolic_pipeline                                           ---- 
----                                                              ---- 
----  This file is part of the                                    ----
----    Modular Simultaneous Exponentiation Core project          ---- 
----    http://www.opencores.org/cores/mod_sim_exp/               ---- 
----                                                              ---- 
----  Description                                                 ---- 
----    structural description of a pipelined systolic array      ----
----    implementation of a montgomery multiplier.                ----
----                                                              ----
----  Dependencies:                                               ----
----    - stepping_logic                                          ----
----    - first_stage                                             ----
----    - standard_stage                                          ----
----    - last_stage                                              ----
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

-- systolic pipeline implementation of the montgommery multiplier
-- devides the pipeline into 2 parts, so 3 operand widths are supported
-- 
-- p_sel: 
--  01 = lower part
--  10 = upper part
--  11 = full range
entity systolic_pipeline is
  generic(
    n  : integer := 1536; -- width of the operands (# bits)
    t  : integer := 192;  -- total number of stages (divider of n) >= 2
    tl : integer := 64    -- lower number of stages (best take t = sqrt(n))
  );
  port(
    -- clock input
    core_clk : in  std_logic;
    -- modulus and y opperand input (n)-bit
    my       : in  std_logic_vector((n) downto 0); -- m+y
    y        : in  std_logic_vector((n-1) downto 0);
    m        : in  std_logic_vector((n-1) downto 0);
    -- x operand input (serial)
    xi       : in  std_logic;
    -- control signals
    start    : in  std_logic; -- start multiplier
    reset    : in  std_logic;
    p_sel    : in  std_logic_vector(1 downto 0); -- select which piece of the multiplier will be used
    ready    : out std_logic; -- multiplication ready
    next_x   : out std_logic; -- next x operand bit
    -- result out
    r        : out std_logic_vector((n+1) downto 0)
  );
end systolic_pipeline;


architecture Structural of systolic_pipeline is
  constant s  : integer := n/t;   -- stage width (# bits)
  constant nl : integer := s*tl;  -- lower pipeline width (# bits)
  constant nh : integer :=  n - nl; -- higher pipeline width (# bits)

  -- pipeline selection flags
  signal p_full_selected      : std_logic; -- full
  signal p_low_full_selected  : std_logic; -- low or full
  signal p_high_selected      : std_logic; -- high
  
  signal t_sel  : integer range 0 to t;  -- width in stages of selected pipeline part
  signal n_sel  : integer range 0 to n;  -- width in bits of selected pipeline part
  
  -- general stage interconnect signals
  signal start_stage  : std_logic_vector((t-1) downto 0); -- vector for the start bits for the stages
  signal done_stage   : std_logic_vector((t-2) downto 0); -- vector for the done bits of the stages
  signal xin_stage    : std_logic_vector((t-1) downto 0); -- vector for the xin bits of the stages
  signal qout_stage   : std_logic_vector((t-2) downto 0); -- vector for the qout bits of the stages
  signal cout_stage   : std_logic_vector((t-2) downto 0); -- vector for the cout bits of the stages
  
  -- stage result signals
  signal r_tot            : std_logic_vector((n+1) downto 0); -- result of the total multiplier
  signal r_stage_midstart : std_logic_vector(s-1 downto 0);   -- result of the mid-start stage of the multiplier
  signal r_stage_midend   : std_logic_vector((s+1) downto 0); -- result of the mid-end stage of the multiplier
  
  -- mapped result registers
  signal r_i     : std_logic_vector((n+1) downto 0);
  signal r_i_stage_midstart   : std_logic_vector((s*2)-1 downto 0);
  signal r_i_stage_midend   : std_logic_vector((s*2)-1 downto 0);

  -- pipeline start signals
  signal start_first_stage    : std_logic;  -- start for full and low pipeline
  signal start_higher         : std_logic;  -- start for higher pipeline
  
  -- midstart stage signals
  signal done_stage_midstart  : std_logic;
  signal xout_stage_midstart  : std_logic;
  signal qout_stage_midstart  : std_logic;
  signal cout_stage_midstart  : std_logic;
  
  -- tl+1 stage signals
  signal xin_stage_tl_1 : std_logic;
  signal qin_stage_tl_1 : std_logic;
  signal cin_stage_tl_1 : std_logic;
begin

	-- output mapping
	r <= r_i;

	-- result feedback
	r_i((n+1) downto ((tl+1)*s)) <= r_tot((n+1) downto ((tl+1)*s));
	r_i(((tl-1)*s-1) downto 0) <= r_tot(((tl-1)*s-1) downto 0);
	
	r_i_stage_midend((s*2)-1 downto s+2) <= (others=>'0');
	r_i_stage_midend((s+1) downto 0) <= r_stage_midend;
	r_i_stage_midstart((s*2)-1 downto s) <= r_stage_midstart;
	r_i_stage_midstart((s-1) downto 0) <= (others=>'0');
	with p_sel select
		r_i(((tl+1)*s-1) downto ((tl-1)*s)) <=  r_i_stage_midend    when "01",
		                                        r_i_stage_midstart  when "10",
		                      r_tot(((tl+1)*s-1) downto ((tl-1)*s)) when others;

	-- signals from x_selection
	next_x <= start_stage(1) or (start_stage(tl+1) and p_high_selected);
	xin_stage(0) <= xi;
	
	-- this module controls the pipeline operation
	--   width in stages for selected pipeline
	with p_sel select
		t_sel <=    tl when "01",   -- lower pipeline part
		          t-tl when "10",   -- higher pipeline part
					       t when others; -- full pipeline

  --   width in bits for selected pipeline
	with p_sel select
		n_sel <= nl-1 when "01",  -- lower pipeline part
					   nh-1 when "10",  -- higher pipeline part
					   n-1 when others; -- full pipeline
	
	with p_sel select
		p_low_full_selected <=  '0' when "10",    -- higher pipeline part
						                '1' when others;  -- full or lower pipeline
	
	with p_sel select
		p_high_selected <= '1' when "10",    -- higher pipeline part
						           '0' when others;  -- full or lower pipeline
	
	p_full_selected <= p_sel(0) and p_sel(1);
	
	-- stepping control logic to keep track off the multiplication and when it is done
  stepping_control : stepping_logic
  generic map(
    n => n, -- max nr of steps required to complete a multiplication
    t => t -- total nr of steps in the pipeline
  )
  port map(
    core_clk          => core_clk,
    start             => start,
    reset             => reset,
    t_sel             => t_sel,
    n_sel             => n_sel,
    start_first_stage => start_first_stage,
    stepping_done     => ready
  );
	
	-- start signals for first stage of lower and higher part
	start_stage(0) <= start_first_stage and p_low_full_selected;
	start_higher <= start_first_stage and p_high_selected;
	
	-- start signals for stage tl and tl+1 (full pipeline operation)
	start_stage(tl) <= done_stage(tl-1) and p_full_selected; -- only pass the start signal if full pipeline
	start_stage(tl+1) <= done_stage(tl) or done_stage_midstart;
	
	-- nothing special here, previous stages starts the next
	start_signals_l: for i in 1 to tl-1 generate
    start_stage(i) <= done_stage(i-1);
	end generate;
	
	start_signals_h: for i in tl+2 to t-1 generate
    start_stage(i) <= done_stage(i-1);
	end generate;
  
  -- first stage 
  -- bits (s downto 0)
  stage_0 : first_stage
  generic map(
    width => s
  )
  port map(
    core_clk => core_clk,
    my       => my(s downto 0),
    y        => y(s downto 0),
    m        => m(s downto 0),
    xin      => xin_stage(0),
    xout     => xin_stage(1),
    qout     => qout_stage(0),
    a_msb    => r_i(s),
    cout     => cout_stage(0),
    start    => start_stage(0),
    reset    => reset,
    done     => done_stage(0),
    r        => r_tot((s-1) downto 0)
  );
	
	-- lower pipeline standard stages: stages tl downto 1
	-- bits ((tl+1)*s downto s+1)
	--                                      (nl downto s+1)
  stages_l : for i in 1 to (tl) generate
    standard_stages : standard_stage
    generic map(
      width => s
    )
    port map(
      core_clk => core_clk,
      my       => my(((i+1)*s) downto ((s*i)+1)),
      y        => y(((i+1)*s) downto ((s*i)+1)),
      m        => m(((i+1)*s) downto ((s*i)+1)),
      xin      => xin_stage(i),
      qin      => qout_stage(i-1),
      xout     => xin_stage(i+1),
      qout     => qout_stage(i),
      a_msb    => r_i((i+1)*s),
      cin      => cout_stage(i-1),
      cout     => cout_stage(i),
      start    => start_stage(i),
      reset    => reset,
      done     => done_stage(i),
      r        => r_tot((((i+1)*s)-1) downto (s*i))
    );
  end generate;
	
	cin_stage_tl_1 <= cout_stage_midstart or cout_stage(tl);
	qin_stage_tl_1 <= qout_stage_midstart or qout_stage(tl);
	xin_stage_tl_1 <= xout_stage_midstart or xin_stage(tl+1);
	
  stage_tl_1 : standard_stage
  generic map(
    width => s
  )
  port map(
    core_clk => core_clk,
    my       => my(((tl+2)*s) downto ((s*(tl+1))+1)),
    y        => y(((tl+2)*s) downto ((s*(tl+1))+1)),
    m        => m(((tl+2)*s) downto ((s*(tl+1))+1)),
    xin      => xin_stage_tl_1,
    qin      => qin_stage_tl_1,
    xout     => xin_stage(tl+2),
    qout     => qout_stage(tl+1),
    a_msb    => r_i((tl+2)*s),
    cin      => cin_stage_tl_1,
    cout     => cout_stage(tl+1),
    start    => start_stage(tl+1),
    reset    => reset,
    done     => done_stage(tl+1),
    r        => r_tot((((tl+2)*s)-1) downto (s*(tl+1)))
  );

	
  stages_h : for i in (tl+2) to (t-2) generate
    standard_stages : standard_stage
    generic map(
      width => s
    )
    port map(
      core_clk => core_clk,
      my       => my(((i+1)*s) downto ((s*i)+1)),
      y        => y(((i+1)*s) downto ((s*i)+1)),
      m        => m(((i+1)*s) downto ((s*i)+1)),
      xin      => xin_stage(i),
      qin      => qout_stage(i-1),
      xout     => xin_stage(i+1),
      qout     => qout_stage(i),
      a_msb    => r_i((i+1)*s),
      cin      => cout_stage(i-1),
      cout     => cout_stage(i),
      start    => start_stage(i),
      reset    => reset,
      done     => done_stage(i),
      r        => r_tot((((i+1)*s)-1) downto (s*i))
    );
  end generate;

  stage_t : last_stage
  generic map(
    width => s -- must be the same as width of the standard stage
  )
  port map(
    core_clk => core_clk,
    my       => my(n downto ((n-s)+1)),       --width-1
    y        => y((n-1) downto ((n-s)+1)),    --width-2
    m        => m((n-1) downto ((n-s)+1)),    --width-2
    xin      => xin_stage(t-1),
    qin      => qout_stage(t-2),
    cin      => cout_stage(t-2),
    start    => start_stage(t-1),
    reset    => reset,
    r => r_tot((n+1) downto (n-s))     --width+1
  );

  mid_start : first_stage
  generic map(
    width => s
  )
  port map(
    core_clk => core_clk,
    my       => my((tl*s+s) downto tl*s),
    y        => y((tl*s+s) downto tl*s),
    m        => m((tl*s+s) downto tl*s),
    xin      => xin_stage(0),
    xout     => xout_stage_midstart,
    qout     => qout_stage_midstart,
    a_msb    => r_i((tl+1)*s),
    cout     => cout_stage_midstart,
    start    => start_higher,
    reset    => reset,
    done => done_stage_midstart,
    r    => r_stage_midstart
  );

  mid_end : last_stage
  generic map(
    width => s -- must be the same as width of the standard stage
  )
  port map(
    core_clk => core_clk,
    my       => my((tl*s) downto ((tl-1)*s)+1),       --width-1
    y        => y(((tl*s)-1) downto ((tl-1)*s)+1),    --width-2
    m        => m(((tl*s)-1) downto ((tl-1)*s)+1),    --width-2
    xin      => xin_stage(tl-1),
    qin      => qout_stage(tl-2),
    cin      => cout_stage(tl-2),
    start    => start_stage(tl-1),
    reset    => reset,
    r => r_stage_midend     --width+1
  );

end Structural;
