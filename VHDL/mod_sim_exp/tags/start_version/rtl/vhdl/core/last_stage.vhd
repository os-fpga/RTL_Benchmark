------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	last_stage.vhd / entity last_stage
-- 
-- Last Modified:	24/11/2011 
-- 
-- Description: 	last stage for use in the montgommery multiplier systolic
--						array pipeline
--
--
-- Dependencies: 	standard_cell_block
--						cell_1b
--
-- Revision:
-- Revision 5.00 - Removed input registers and used start signal as load_out_regs
-- Revision 4.01 - Remove "done" input
-- Revision 4.00 - Removed "a" input with internal feedback
-- Revision 3.03 - fixed switched last two bits
-- Revision 3.02 - removed "ready" output signal
-- Revision 3.01 - replaced the behavioral description of the registers with a
--                 component instantiation
-- Revision 3.00 - added registers to store input values xin, cin, qin (because they
--					    can change during operation)
-- Revision 2.00 - changed indices in signals my, y and m
-- Revision 1.03 - added done pulse
-- Revision 1.02 - appended "_i" to name of all internal signals
-- Revision 1.01 - ready is '1' after reset
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

entity last_stage is
	generic(width : integer := 16 -- must be the same as width of the standard stage
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
			 --  done : out STD_LOGIC;
               r : out STD_LOGIC_VECTOR((width+1) downto 0)
	);
end last_stage;

architecture Structural of last_stage is
	
	component d_flip_flop
   port(core_clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			    din : in  STD_LOGIC;
		      dout : out STD_LOGIC
	);
	end component;

	component register_1b
   port(core_clk : in  STD_LOGIC;
			     ce : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			    din : in  STD_LOGIC;
		      dout : out STD_LOGIC
	);
	end component;
	
	component register_n
	generic( n : integer := 4
	);
   port(core_clk : in  STD_LOGIC;
			     ce : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			    din : in  STD_LOGIC_VECTOR((n-1) downto 0);
		      dout : out STD_LOGIC_VECTOR((n-1) downto 0)
	);
	end component;
	
	component standard_cell_block
	generic ( width : integer := 32
	);
   Port ( my : in  STD_LOGIC_VECTOR((width-1) downto 0);
           y : in  STD_LOGIC_VECTOR((width-1) downto 0);
           m : in  STD_LOGIC_VECTOR((width-1) downto 0);
           x : in  STD_LOGIC;
           q : in  STD_LOGIC;
			  a : in  STD_LOGIC_VECTOR((width-1) downto 0);
			  cin : in STD_LOGIC;
			  cout : out STD_LOGIC;
           r : out  STD_LOGIC_VECTOR((width-1) downto 0));
	end component;

	component cell_1b
   port ( my : in  STD_LOGIC;
           y : in  STD_LOGIC;
           m : in  STD_LOGIC;
           x : in  STD_LOGIC;
           q : in  STD_LOGIC;
			  a : in  STD_LOGIC;
			  cin : in STD_LOGIC;
			  cout : out STD_LOGIC;
           r : out  STD_LOGIC);
	end component;

	-- input
	signal my_i : std_logic_vector(width downto 0);
	signal m_i : std_logic_vector(width downto 0);
	signal y_i : std_logic_vector(width downto 0);
	signal cin_i : std_logic;
	signal xin_i : std_logic;
	signal qin_i : std_logic;
	signal a_i : std_logic_vector((width) downto 0);
--	signal cin_reg_i : std_logic;
--	signal xin_reg_i : std_logic;
--	signal qin_reg_i : std_logic;
--	signal a_reg_i : std_logic_vector((width) downto 0);
	
	-- output
	signal r_i : std_logic_vector((width+1) downto 0);	
	signal r_reg_i : std_logic_vector((width+1) downto 0);

	-- interconnection
	signal cout_i : std_logic;
	
	-- control signals
--	signal load_out_regs_i : std_logic;
--	signal done_i : std_logic := '1';
	--signal ready_del_i : std_logic := '1';
	
begin
	-- map internal signals to outputs
--	done <= done_i;
	r <= r_reg_i;
		-- two posibilities:
	--done <= ready_i and (not ready_del_i); -- slow
	--done <= not ready_i; -- faster but not sure if it will work (DONE_PROC can be omitted)
	
	-- map inputs to internal signals
	my_i <= '0' & my;
	m_i <= "00" & m;
	y_i <= "00" & y;
	xin_i <= xin;
	qin_i <= qin;
	cin_i <= cin;

	a_i <= r_reg_i((width+1) downto 1);
	
	cell_block: standard_cell_block
	generic map( width => width
	)
   Port map( my => my_i(width-1 downto 0),
			 y => y_i(width-1 downto 0),
			 m => m_i(width-1 downto 0),
--			 x => xin_reg_i,
--			 q => qin_reg_i,
			 x => xin_i,
			 q => qin_i,
			 a => a_i((width-1) downto 0),
--			 cin => cin_reg_i,
			 cin => cin_i,
			 cout => cout_i,
			 r => r_i((width-1) downto 0)
	);
	
	last_cell: cell_1b
   port map( my => my_i(width),
           y => y_i(width),
           m => m_i(width),
--	        x => xin_reg_i,
--	        q => qin_reg_i,
			  x => xin_i,
           q => qin_i,
			  a => a_i(width),
			  cin => cout_i,
			  cout => r_i(width+1),
           r => r_i(width)
	);
	
--	XIN_REG: register_1b
--   port map(core_clk => core_clk,
--			     ce => start,
--			  reset => reset,
--			    din => xin_i,
--		      dout => xin_reg_i
--	);
	
--	QIN_REG: register_1b
--   port map(core_clk => core_clk,
--			     ce => start,
--			  reset => reset,
--			    din => qin_i,
--		      dout => qin_reg_i
--	);
	
--	CIN_REG: register_1b
--   port map(core_clk => core_clk,
--			     ce => start,
--			  reset => reset,
--			    din => cin_i,
--		      dout => cin_reg_i
--	);
	
	-- control
--	delay_1_cycle: d_flip_flop
--   port map(core_clk => core_clk,
--			  reset => reset,
--			    din => start,
--		      dout => load_out_regs_i
--	);
	
--	done_signal: d_flip_flop
--   port map(core_clk => core_clk,
--			  reset => reset,
--			    din => load_out_regs_i,
--		      dout => done_i
--	);
	
	-- output registers
	RESULT_REG: register_n
	generic map( n => (width+2)
	)
   port map(core_clk => core_clk,
--			     ce => load_out_regs_i,
				  ce => start,
			  reset => reset,
			    din => r_i,
		      dout => r_reg_i
	);
	
end Structural;