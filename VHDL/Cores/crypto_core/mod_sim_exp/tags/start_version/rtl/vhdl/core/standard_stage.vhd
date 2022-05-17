------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	standard_stage.vhd / entity standard_stage
-- 
-- Last Modified:	24/11/2011 
-- 
-- Description: 	standard stage for use in the montgommery multiplier systolic
--						array pipeline
--
--
-- Dependencies: 	standard_cell_block,
--						register_n,
--						register_1b,
--						d_flip_flop
--
-- Revision:
-- Revision 4.00 - Removed input registers and used start signal as load_out_regs
-- Revision 3.00 - Removed "a" input and replaced with "a_msb" (which is the only one 
--                 that matters.
-- Revision 2.02 - removed "ready" output signal
-- Revision 2.01 - replaced the behavioral description of the registers with a
--                 component instantiation
-- Revision 2.00 - added registers to store input values xin, cin, qin (because they
--					    can change during operation)
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

entity standard_stage is
	generic(width : integer := 32
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
	--		  ready : out STD_LOGIC;
			   done : out STD_LOGIC;
               r : out STD_LOGIC_VECTOR((width-1) downto 0)
	);
end standard_stage;

architecture Structural of standard_stage is
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

	-- input
	signal cin_i : std_logic;
	signal xin_i : std_logic;
	signal qin_i : std_logic;
	signal a_msb_i : std_logic;
--	signal cin_reg_i : std_logic;
--	signal xin_reg_i : std_logic;
--	signal qin_reg_i : std_logic;
--	signal a_msb_reg_i : std_logic;

	-- output
	signal cout_i : std_logic;
	signal r_i : std_logic_vector((width-1) downto 0);
	signal cout_reg_i : std_logic;
	signal xout_reg_i : std_logic;
	signal qout_reg_i : std_logic;
	signal r_reg_i : std_logic_vector((width-1) downto 0);

	-- interconnect
	signal a_i : std_logic_vector((width-1) downto 0);

	-- control
--	signal load_out_regs_i : std_logic;
	signal done_i : std_logic := '1';
	--signal ready_del_i : std_logic := '1';
begin
	-- map internal signals to outputs
	done <= done_i;
	r <= r_reg_i;
	cout <= cout_reg_i;
	qout <= qout_reg_i;
	xout <= xout_reg_i;
		-- two posibilities:
	--done <= ready_i and (not ready_del_i); -- slow
	--done <= not ready_i; -- faster but not sure if it will work (DONE_PROC can be omitted)
	
	-- map inputs to internal signals
	xin_i <= xin;
	qin_i <= qin;
	cin_i <= cin;
	a_msb_i <= a_msb;
	
--	a_i <= a_msb_reg_i & r_reg_i((width-1) downto 1);
	a_i <= a_msb_i & r_reg_i((width-1) downto 1);
	
	-- input registers
--	A_REG: register_1b
--   port map(core_clk => core_clk,
--			     ce => start,
--			  reset => reset,
--			    din => a_msb_i,
--		      dout => a_msb_reg_i
--	);
	
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
	
	cell_block: standard_cell_block
	generic map( width => width
	)
   Port map( my => my,
			 y => y,
			 m => m,
--			 x => xin_reg_i,
--			 q => qin_reg_i,
			 x => xin_i,
			 q => qin_i,
			 a => a_i,
--			 cin => cin_reg_i,
			 cin => cin_i,
			 cout => cout_i,
			 r => r_i
	);
	
--	delay_1_cycle: d_flip_flop
--   port map(core_clk => core_clk,
--			  reset => reset,
--			    din => start,
--		      dout => load_out_regs_i
--	);
	
	done_signal: d_flip_flop
   port map(core_clk => core_clk,
			  reset => reset,
--			    din => load_out_regs_i,
				 din => start,
		      dout => done_i
	);
	
	-- output registers
	RESULT_REG: register_n
	generic map( n => width
	)
   port map(core_clk => core_clk,
--			     ce => load_out_regs_i,
				  ce => start,
			  reset => reset,
			    din => r_i,
		      dout => r_reg_i
	);
	
	XOUT_REG: register_1b
   port map(core_clk => core_clk,
--			     ce => load_out_regs_i,
				  ce => start,
			  reset => reset,
--			    din => xin_reg_i,
				 din => xin_i,
		      dout => xout_reg_i
	);
	
	QOUT_REG: register_1b
   port map(core_clk => core_clk,
--			     ce => load_out_regs_i,
				  ce => start,
			  reset => reset,
--			    din => qin_reg_i,
				 din => qin_i,
		      dout => qout_reg_i
	);
	
	COUT_REG: register_1b
   port map(core_clk => core_clk,
--			     ce => load_out_regs_i,
				  ce => start,
			  reset => reset,
			    din => cout_i,
		      dout => cout_reg_i
	);
	
end Structural;