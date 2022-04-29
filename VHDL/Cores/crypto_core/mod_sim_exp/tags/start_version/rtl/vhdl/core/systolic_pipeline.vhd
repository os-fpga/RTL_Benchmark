------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	systolic_pipeline.vhd / entity systolic_pipeline
-- 
-- Last Modified:	05/01/2012 
-- 
-- Description: 	pipelined systolic array implementation of a montgomery multiplier
--
--
-- Dependencies: 	first_stage,
--                standard_stage,
--                last_stage,
--                stepping_control
--
-- Revision:
-- Revision 3.00 - Made x_selection external
-- Revision 2.02 - Changed design to cope with new stepping_control (next_x)
-- Revision 2.01 - Created an extra contant s (step size = n/t) to fix a problem
--                 that occured when t not = sqrt(n).
-- Revision 2.00 - Moved stepping logic and x_selection to seperate submodules
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

-- p_sel: 
-- 01 = lower part
-- 10 = upper part
-- 11 = full range

entity systolic_pipeline is
	generic( n : integer := 1536; -- width of the operands (# bits)
				t : integer := 192;	-- number of stages (divider of n) >= 2
				tl: integer := 64
				-- best take t = sqrt(n)
	);
   port(core_clk : in  STD_LOGIC;
			     my : in  STD_LOGIC_VECTOR((n) downto 0);
               y : in  STD_LOGIC_VECTOR((n-1) downto 0);
               m : in  STD_LOGIC_VECTOR((n-1) downto 0);
              xi : in  STD_LOGIC;
			  start : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			  p_sel : in  STD_LOGIC_VECTOR(1 downto 0); -- select which piece of the multiplier will be used
			  ready : out STD_LOGIC;
			 next_x : out STD_LOGIC;
               r : out STD_LOGIC_VECTOR((n+1) downto 0)
	);
end systolic_pipeline;

architecture Structural of systolic_pipeline is

	constant s : integer := n/t; -- defines the size of the stages (# bits)
	constant size_l : integer := s*tl;
	constant size_h : integer :=  n - size_l;
	
	component first_stage
	generic(width : integer := 4 -- must be the same as width of the standard stage
	);
	port(core_clk : in  STD_LOGIC;
				  my : in  STD_LOGIC_VECTOR((width) downto 0);
					y : in  STD_LOGIC_VECTOR((width) downto 0);
					m : in  STD_LOGIC_VECTOR((width) downto 0);
				 xin : in  STD_LOGIC;
				xout : out STD_LOGIC;
				qout : out STD_LOGIC;
			  a_msb : in  STD_LOGIC;
				cout : out STD_LOGIC;
			  start : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			  --ready : out STD_LOGIC;
			   done : out STD_LOGIC;
					r : out STD_LOGIC_VECTOR((width-1) downto 0)
	);
	end component;
	
	component standard_stage
	generic(width : integer := 4
	);
   port(core_clk : in  STD_LOGIC;
			     my : in  STD_LOGIC_VECTOR((width-1) downto 0);
               y : in  STD_LOGIC_VECTOR((width-1) downto 0);
               m : in  STD_LOGIC_VECTOR((width-1) downto 0);
             xin : in  STD_LOGIC;
             qin : in  STD_LOGIC;
			   xout : out STD_LOGIC;
            qout : out STD_LOGIC;
			  a_msb : in  STD_LOGIC;
			    cin : in  STD_LOGIC;
			   cout : out STD_LOGIC;
			  start : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			 -- ready : out STD_LOGIC;
			   done : out STD_LOGIC;
               r : out STD_LOGIC_VECTOR((width-1) downto 0)
	);
	end component;
	
	component last_stage
	generic(width : integer := 4 -- must be the same as width of the standard stage
	);
   port(core_clk : in  STD_LOGIC;
			     my : in  STD_LOGIC_VECTOR((width-1) downto 0);
               y : in  STD_LOGIC_VECTOR((width-2) downto 0);
               m : in  STD_LOGIC_VECTOR((width-2) downto 0);
             xin : in  STD_LOGIC;
             qin : in  STD_LOGIC;
			    cin : in  STD_LOGIC;
			  start : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			--  ready : out STD_LOGIC;
			--   done : out STD_LOGIC;
               r : out STD_LOGIC_VECTOR((width+1) downto 0)
	);
	end component;
	
	component stepping_logic
	generic( n : integer := 16; -- max nr of steps required to complete a multiplication
				t : integer := 4 -- total nr of steps in the pipeline
	);
   port(core_clk : in  STD_LOGIC;
			  start : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			  t_sel : in integer range 0 to t; -- nr of stages in the pipeline piece
			  n_sel : in integer range 0 to n; -- nr of steps required for a complete multiplication
		start_first_stage : out STD_LOGIC;
		stepping_done : out STD_LOGIC
	);
	end component;

	signal start_stage_i : std_logic_vector((t-1) downto 0);
	--signal stage_ready_i : std_logic_vector((t-1) downto 0);
	signal stage_done_i : std_logic_vector((t-2) downto 0);
	
	signal x_i : std_logic_vector((t-1) downto 0) := (others=>'0');
	signal q_i : std_logic_vector((t-2) downto 0) := (others=>'0');
	signal c_i : std_logic_vector((t-2) downto 0) := (others=>'0');
	signal a_i : std_logic_vector((n+1) downto 0) := (others=>'0');
	signal r_tot : std_logic_vector((n+1) downto 0) := (others=>'0');
	signal r_h : std_logic_vector(s-1 downto 0) := (others=>'0');
	signal r_l : std_logic_vector((s+1) downto 0) := (others=>'0');
	signal a_h : std_logic_vector((s*2)-1 downto 0) := (others=>'0');
	signal a_l : std_logic_vector((s*2)-1 downto 0) := (others=>'0');
	
	--signal ready_i : std_logic;
	signal stepping_done_i : std_logic;
	signal t_sel : integer range 0 to t := t;
	signal n_sel : integer range 0 to n := n;
	signal split : std_logic := '0';
	signal lower_e_i : std_logic := '0';
	signal higher_e_i : std_logic := '0';
	signal start_pulses_i : std_logic := '0';
	signal start_higher_i : std_logic := '0';
	signal higher_0_done_i : std_logic := '0';
	signal h_x_0, h_x_1 : std_logic := '0';
	signal h_q_0, h_q_1 : std_logic := '0';
	signal h_c_0, h_c_1 : std_logic := '0';
	signal x_offset_i : integer range 0 to tl*s := 0;
	signal next_x_i : std_logic := '0';
begin

	-- output mapping
	r <= a_i; -- mogelijks moet er nog een shift operatie gebeuren
	ready <= stepping_done_i;

	-- result feedback
	a_i((n+1) downto ((tl+1)*s)) <= r_tot((n+1) downto ((tl+1)*s));
	a_i(((tl-1)*s-1) downto 0) <= r_tot(((tl-1)*s-1) downto 0);
	
	a_l((s+1) downto 0) <= r_l;
	a_h((s*2)-1 downto s) <= r_h; 
	with p_sel select
		a_i(((tl+1)*s-1) downto ((tl-1)*s)) <= a_l when "01",
															a_h  when "10",
															r_tot(((tl+1)*s-1) downto ((tl-1)*s)) when others;


	-- signals from x_selection
	next_x_i <= start_stage_i(1) or (start_stage_i(tl+1) and higher_e_i);
	--
	next_x <= next_x_i;
	x_i(0) <= xi;
	
	-- this module controls the pipeline operation
	with p_sel select
		t_sel <= tl when "01",
		         t-tl when "10",
					t when others;
					
	with p_sel select
		n_sel <= size_l-1 when "01",
					size_h-1 when "10",
					n-1 when others;
	
	with p_sel select
		lower_e_i <= '0' when "10",
						 '1' when others;
	
	with p_sel select
		higher_e_i <= '1' when "10",
						 '0' when others;
	
	split <= p_sel(0) and p_sel(1);
	
	
	stepping_control: stepping_logic
	generic map( n => n, -- max nr of steps required to complete a multiplication
				t => t -- total nr of steps in the pipeline
	)
   port map(core_clk => core_clk,
			  start => start,
			  reset => reset,
			  t_sel => t_sel,
			  n_sel => n_sel,
		start_first_stage => start_pulses_i,
		stepping_done => stepping_done_i
	);
	
	-- start signals for first stage of lower and higher part
	start_stage_i(0) <= start_pulses_i and lower_e_i;
	start_higher_i <= start_pulses_i and (higher_e_i and not split);
	
	-- start signals for stage tl and tl+1 (full pipeline operation)
	start_stage_i(tl) <= stage_done_i(tl-1) and split;
	start_stage_i(tl+1) <= stage_done_i(tl) or higher_0_done_i;
	
	-- nothing special here, previous stages starts the next
	start_signals_l: for i in 1 to tl-1 generate
			start_stage_i(i) <= stage_done_i(i-1);
	end generate;
	start_signals_h: for i in tl+2 to t-1 generate
			start_stage_i(i) <= stage_done_i(i-1);
	end generate;
	
	stage_0: first_stage
	generic map(width => s
	)
	port map(core_clk => core_clk,
				  my => my(s downto 0),
					y => y(s downto 0),
					m => m(s downto 0),
				 xin => x_i(0),
				xout => x_i(1),
				qout => q_i(0),
			  a_msb => a_i(s),
				cout => c_i(0),
			  start => start_stage_i(0),
			  reset => reset,
			  --ready => stage_ready_i(0),
			   done => stage_done_i(0),
					r => r_tot((s-1) downto 0)
	);
	
	stages_l: for i in 1 to (tl) generate
		standard_stages: standard_stage
		generic map(width => s
		)
		port map(core_clk => core_clk,
					  my => my(((i+1)*s) downto ((s*i)+1)),
						y => y(((i+1)*s) downto ((s*i)+1)),
						m => m(((i+1)*s) downto ((s*i)+1)),
					 xin => x_i(i),
					 qin => q_i(i-1),
					xout => x_i(i+1),
					qout => q_i(i),
				  a_msb => a_i((i+1)*s),
					 cin => c_i(i-1),
					cout => c_i(i),
				  start => start_stage_i(i),
				  reset => reset,
				  --ready => stage_ready_i(i),
					done => stage_done_i(i),
						r => r_tot((((i+1)*s)-1) downto (s*i))
		);
	end generate;
	
	h_c_1 <= h_c_0 or c_i(tl);
	h_q_1 <= h_q_0 or q_i(tl);
	h_x_1 <= h_x_0 or x_i(tl+1);
	
	stage_tl_1: standard_stage
		generic map(width => s
		)
		port map(core_clk => core_clk,
					  my => my(((tl+2)*s) downto ((s*(tl+1))+1)),
						y => y(((tl+2)*s) downto ((s*(tl+1))+1)),
						m => m(((tl+2)*s) downto ((s*(tl+1))+1)),
					 --xin => x_i(tl+1),
					 xin => h_x_1,
					 --qin => q_i(tl),
					 qin => h_q_1,
					xout => x_i(tl+2),
					qout => q_i(tl+1),
				  a_msb => a_i((tl+2)*s),
					 --cin => c_i(tl),
					 cin => h_c_1,
					cout => c_i(tl+1),
				  start => start_stage_i(tl+1),
				  reset => reset,
				  --ready => stage_ready_i(i),
					done => stage_done_i(tl+1),
						r => r_tot((((tl+2)*s)-1) downto (s*(tl+1)))
		);
	
	stages_h: for i in (tl+2) to (t-2) generate
		standard_stages: standard_stage
		generic map(width => s
		)
		port map(core_clk => core_clk,
					  my => my(((i+1)*s) downto ((s*i)+1)),
						y => y(((i+1)*s) downto ((s*i)+1)),
						m => m(((i+1)*s) downto ((s*i)+1)),
					 xin => x_i(i),
					 qin => q_i(i-1),
					xout => x_i(i+1),
					qout => q_i(i),
				  a_msb => a_i((i+1)*s),
					 cin => c_i(i-1),
					cout => c_i(i),
				  start => start_stage_i(i),
				  reset => reset,
				  --ready => stage_ready_i(i),
					done => stage_done_i(i),
						r => r_tot((((i+1)*s)-1) downto (s*i))
		);
	end generate;
	
	stage_t: last_stage
	generic map(width => s -- must be the same as width of the standard stage
	)
   port map(core_clk => core_clk,
			         my => my(n downto ((n-s)+1)),     	--width-1
			          y => y((n-1) downto ((n-s)+1)),  	--width-2
			          m => m((n-1) downto ((n-s)+1)),  	--width-2
					  xin => x_i(t-1),
					  qin => q_i(t-2),
					  cin => c_i(t-2),
			      start => start_stage_i(t-1),
				   reset => reset,
				   --ready => stage_ready_i(t-1),
                   r => r_tot((n+1) downto (n-s)) 		--width+1
	);

	mid_start: first_stage
	generic map(width => s
	)
	port map(core_clk => core_clk,
				  my => my((tl*s+s) downto tl*s),
					y => y((tl*s+s) downto tl*s),
					m => m((tl*s+s) downto tl*s),
				 xin => x_i(0),
				xout => h_x_0,
				qout => h_q_0,
			  a_msb => a_i((tl+1)*s),
				cout => h_c_0,
			  start => start_higher_i,
			  reset => reset,
			  --ready => stage_ready_i(0),
			   done => higher_0_done_i,
					r => r_h
	);
	
	mid_end: last_stage
	generic map(width => s -- must be the same as width of the standard stage
	)
   port map(core_clk => core_clk,
			         my => my((tl*s) downto ((tl-1)*s)+1),     	--width-1
			          y => y(((tl*s)-1) downto ((tl-1)*s)+1),  	--width-2
			          m => m(((tl*s)-1) downto ((tl-1)*s)+1),  	--width-2
					  xin => x_i(tl-1),
					  qin => q_i(tl-2),
					  cin => c_i(tl-2),
			      start => start_stage_i(tl-1),
				   reset => reset,
				   --ready => stage_ready_i(t-1),
                   r => r_l 		--width+1
	);

end Structural;