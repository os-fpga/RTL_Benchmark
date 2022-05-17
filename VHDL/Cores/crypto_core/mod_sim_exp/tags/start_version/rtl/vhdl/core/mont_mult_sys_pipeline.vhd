------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	mont_mult_sys_pipeline.vhd / entity mont_mult_sys_pipeline
-- 
-- Last Modified:	18/06/2012 
-- 
-- Description: 	n-bit montgomery multiplier with a pipelined systolic array
--
--
-- Dependencies: 	systolic_pipeline
--						adder_n
--						cell_1b_adder
--                x_shift_register
--
-- Revision:
-- Revision 3.00 - shift register for x selection in stead of decoding logic
-- Revision 2.01 - Bug fix of the bug fix
-- Revision 2.00 - Major bug fix in reduction logic (carry in upper part)
--	Revision 1.00 - Architecture
--	Revision 0.01 - File Created
--
--
------------------------------------------------------------------------------------
--
-- NOTICE:
--
-- Copyright DraMCo research group. 2011. This code may be contain portions patented
-- by other third parties!
--
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mont_mult_sys_pipeline is
	generic ( n : integer := 1536;
		nr_stages : integer := 96; --(divides n, bits_low & (n-bits_low))
		stages_low : integer := 32
	);
   Port ( core_clk : in STD_LOGIC;
           xy : in  STD_LOGIC_VECTOR((n-1) downto 0);
           m : in  STD_LOGIC_VECTOR((n-1) downto 0);
           r : out  STD_LOGIC_VECTOR((n-1) downto 0);
			  start : in STD_LOGIC;
			  reset : in STD_LOGIC;
			  p_sel : in  STD_LOGIC_VECTOR(1 downto 0);
			  load_x : in std_logic;
			  ready : out STD_LOGIC
	);
end mont_mult_sys_pipeline;

architecture Structural of mont_mult_sys_pipeline is
	component adder_n
	generic ( width : integer := 16;
		block_width : integer := 4
	);
   Port ( core_clk : in STD_LOGIC;
			  a : in  STD_LOGIC_VECTOR((width-1) downto 0);
           b : in  STD_LOGIC_VECTOR((width-1) downto 0);
			  cin : in STD_LOGIC;
			  cout : out STD_LOGIC;
           s : out  STD_LOGIC_VECTOR((width-1) downto 0)
	);
	end component;
	
	component systolic_pipeline
	generic( n : integer := 1536; -- width of the operands (# bits)
				t : integer := 96;  -- number of stages (divider of n) >= 2
				tl: integer := 32
	);
   port(core_clk : in  STD_LOGIC;
			     my : in  STD_LOGIC_VECTOR((n) downto 0);
               y : in  STD_LOGIC_VECTOR((n-1) downto 0);
               m : in  STD_LOGIC_VECTOR((n-1) downto 0);
              xi : in  STD_LOGIC;
			  start : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			  p_sel : in  STD_LOGIC_VECTOR(1 downto 0);
			  ready : out STD_LOGIC;
			 next_x : out STD_LOGIC;
               r : out STD_LOGIC_VECTOR((n+1) downto 0)
	);
	end component;
	
	component x_shift_reg
	generic(  n : integer := 32;
		       t : integer := 8;
				tl : integer := 3
	);
	port(   clk : in  STD_LOGIC;
         reset : in  STD_LOGIC;
          x_in : in  STD_LOGIC_VECTOR((n-1) downto 0);
        load_x : in  STD_LOGIC;
        next_x : in  STD_LOGIC;
		   p_sel : in  STD_LOGIC_VECTOR(1 downto 0);
           x_i : out STD_LOGIC
	);
	end component;
	
	component cell_1b_adder
		 Port ( a : in  STD_LOGIC;
				  mux_result : in  STD_LOGIC;
				  cin : in  STD_LOGIC;
				  cout : out  STD_LOGIC;
				  r : out  STD_LOGIC);
	end component;

	component d_flip_flop
   port(core_clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			    din : in  STD_LOGIC;
		      dout : out STD_LOGIC
	);
	end component;

	constant stage_width : integer := n/nr_stages;
	constant bits_l : integer := stage_width * stages_low;
	constant bits_h : integer := n - bits_l;
	
	signal my : std_logic_vector(n downto 0);
	signal my_h_cin : std_logic;
	signal my_l_cout : std_logic;
	signal r_pipeline : std_logic_vector(n+1 downto 0);
	signal r_red : std_logic_vector(n-1 downto 0);
	signal r_i : std_logic_vector(n-1 downto 0);
	signal c_red_l : std_logic_vector(2 downto 0);
	signal c_red_h : std_logic_vector(2 downto 0);
	signal cin_red_h : std_logic;
	signal r_sel : std_logic;
	signal reset_multiplier : std_logic;
	signal start_multiplier : std_logic;
	signal m_inv : std_logic_vector(n-1 downto 0);
	
	signal next_x_i : std_logic;
	signal x_i : std_logic;
begin
	-- x selection
	x_selection: x_shift_reg
	generic map(  n => n,
		       t => nr_stages,
		      tl => stages_low
	)
	port map(clk => core_clk,
         reset => reset,
          x_in => xy,
        load_x => load_x,
        next_x => next_x_i,
		   p_sel => p_sel,
           x_i => x_i
	);

	-- precomputation of my (m+y)
	my_adder_l: adder_n
	generic map( width => bits_l,
		block_width => stage_width
	)
   port map( core_clk => core_clk,
			  a => m((bits_l-1) downto 0),
           b => xy((bits_l-1) downto 0),
			  cin => '0',
			  cout => my_l_cout,
           s => my((bits_l-1) downto 0)
	);
	
	my_adder_h: adder_n
	generic map( width => bits_h,
		block_width => stage_width
	)
   port map( core_clk => core_clk,
			  a => m((n-1) downto bits_l),
           b => xy((n-1) downto bits_l),
			  cin => my_h_cin,
			  cout => my(n),
           s => my((n-1) downto bits_l)
	);
	
	my_h_cin <= '0' when (p_sel(1) and (not p_sel(0)))='1' else my_l_cout;
	
	-- multiplication	
	reset_multiplier <= reset or start;

	delay_1_cycle: d_flip_flop
   port map(core_clk => core_clk,
			  reset => reset,
			    din => start,
		      dout => start_multiplier
	);
	

	the_multiplier: systolic_pipeline
	generic map( n => n, -- width of the operands (# bits)
				t => nr_stages,  -- number of stages (divider of n) >= 2
				tl => stages_low
	)
   port map(core_clk => core_clk,
			     my => my,
               y => xy,
               m => m,
              xi => x_i,
			  start => start_multiplier,
			  reset => reset_multiplier,
			  p_sel => p_sel,
			  ready => ready, -- misschien net iets te vroeg?
			 next_x => next_x_i,
               r => r_pipeline
	);
	
	-- post-computation (reduction)
	m_inv <= not(m);
	
	reduction_adder_l: adder_n
	generic map( width => bits_l,
		block_width => stage_width
	)
   port map( core_clk => core_clk,
			  a => m_inv((bits_l-1) downto 0),
           b => r_pipeline((bits_l-1) downto 0),
			  cin => '1',
			  cout => c_red_l(0),
           s => r_red((bits_l-1) downto 0)
	);
	
	reduction_adder_l_a: cell_1b_adder
	port map(a => '1',
				mux_result => r_pipeline(bits_l),
				cin => c_red_l(0),
				cout => c_red_l(1)
				--r => 
	);
	
	reduction_adder_l_b: cell_1b_adder
	port map(a => '1',
				mux_result => r_pipeline(bits_l+1),
				cin => c_red_l(1),
				cout => c_red_l(2)
	--			r => 
	);
	
	--cin_red_h <= p_sel(1) and (not p_sel(0));
	cin_red_h <= c_red_l(0) when p_sel(0) = '1' else '1';
	
	reduction_adder_h: adder_n
	generic map( width => bits_h,
		block_width => stage_width
	)
   port map( core_clk => core_clk,
			  a => m_inv((n-1) downto bits_l),
           b => r_pipeline((n-1) downto bits_l),
			  cin => cin_red_h,
			  cout => c_red_h(0),
           s => r_red((n-1) downto bits_l)
	);
	
	reduction_adder_h_a: cell_1b_adder
	port map(a => '1',
				mux_result => r_pipeline(n),
				cin => c_red_h(0),
				cout => c_red_h(1)
	);
	
	reduction_adder_h_b: cell_1b_adder
	port map(a => '1',
				mux_result => r_pipeline(n+1),
				cin => c_red_h(1),
				cout => c_red_h(2)
	);

	r_sel <= (c_red_h(2) and p_sel(1)) or (c_red_l(2) and (p_sel(0) and (not p_sel(1))));
	r_i <= r_red when r_sel = '1' else r_pipeline((n-1) downto 0);
	
	-- output
	r <= r_i;
end Structural;