------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	autorun_cntrl.vhd / entity autorun_cntrl
-- 
-- Last Modified:	25/04/2012 
-- 
-- Description: 	autorun control unit for a pipelined montgomery multiplier
--
--
-- Dependencies: 	none
--
-- Revision 2.00 - Major bug fix: bit_counter should count from 15 downto 0.
-- Revision 1.00 - Architecture created
-- Revision 0.01 - File Created
-- Additional Comments: 
--
--
------------------------------------------------------------------------------------
--
-- NOTICE:
--
-- Copyright DraMCo research group. 2011. This code may be contain portions patented
-- by other third parties!
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity autorun_cntrl is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           start : in  STD_LOGIC;
           done : out  STD_LOGIC;
           op_sel : out  STD_LOGIC_VECTOR (1 downto 0);
           start_multiplier : out  STD_LOGIC;
           multiplier_done : in  STD_LOGIC;
           read_buffer : out  STD_LOGIC;
           buffer_din : in  STD_LOGIC_VECTOR (31 downto 0);
           buffer_empty : in  STD_LOGIC);
end autorun_cntrl;

architecture Behavioral of autorun_cntrl is

	signal bit_counter_i : integer range 0 to 15 := 0;
	signal bit_counter_0_i : std_logic;
	signal bit_counter_15_i : std_logic;
	signal next_bit_i : std_logic := '0';
	signal next_bit_del_i : std_logic;
	
	signal start_cycle_i : std_logic := '0';
	signal start_cycle_del_i : std_logic;

	signal done_i : std_logic;
	signal start_i : std_logic;
	signal running_i : std_logic;
	
	signal start_multiplier_i : std_logic;
	signal start_multiplier_del_i : std_logic;
	signal mult_done_del_i : std_logic;
	
	signal e0_i : std_logic_vector(15 downto 0);
	signal e1_i : std_logic_vector(15 downto 0);
	signal e0_bit_i : std_logic;
	signal e1_bit_i : std_logic;
	signal e_bits_i : std_logic_vector(1 downto 0);
	signal e_bits_0_i : std_logic;
	signal cycle_counter_i : std_logic;
	signal op_sel_sel_i : std_logic;
	signal op_sel_i : std_logic_vector(1 downto 0);
begin
	--done <= (multiplier_done and (not running_i)) or (start and buffer_empty);
	done <= done_i;
	
	-- the two exponents
	e0_i <= buffer_din(15 downto 0);
	e1_i <= buffer_din(31 downto 16);

	-- generate the index to select a single bit from the two exponents
	SYNC_BIT_COUNTER: process (clk, reset)
	begin
		if reset = '1' then
			bit_counter_i <= 15;
		elsif rising_edge(clk) then
			if start = '1' then -- make sure we start @ bit 0
				bit_counter_i <= 15;
			elsif next_bit_i = '1' then -- count
				if bit_counter_i = 0 then
					bit_counter_i <= 15;
				else
					bit_counter_i <= bit_counter_i - 1;
				end if;
			end if;
		end if;
	end process SYNC_BIT_COUNTER;
	-- signal when bit_counter_i = 0
	bit_counter_0_i <= '1' when bit_counter_i=0 else '0';
	bit_counter_15_i <= '1' when bit_counter_i=15 else '0';
	-- the bits...
	e0_bit_i <= e0_i(bit_counter_i);
	e1_bit_i <= e1_i(bit_counter_i);
	e_bits_i <= e0_bit_i & e1_bit_i;
	e_bits_0_i <= '1' when (e_bits_i = "00") else '0';
	
	-- operand pre-select
	with e_bits_i select
		op_sel_i <= "00" when "10", -- gt0
						"01" when "01", -- gt1
						"10" when "11", -- gt01
						"11" when others;
						
	-- select operands
	op_sel_sel_i <= '0' when e_bits_0_i = '1' else (cycle_counter_i);
	op_sel <= op_sel_i when op_sel_sel_i = '1' else "11";
	
	-- process that drives running_i signal ('1' when in autorun, '0' when not)
	RUNNING_PROC: process(clk, reset)
	begin
		if reset = '1' then
			running_i <= '0';
		elsif rising_edge(clk) then
			running_i <= start or (running_i and (not done_i));
		end if;
	end process RUNNING_PROC;
	
	-- ctrl logic
	start_multiplier_i <= start_cycle_del_i or (mult_done_del_i and (cycle_counter_i) and (not e_bits_0_i));
	read_buffer <= start_cycle_del_i and bit_counter_15_i and running_i; -- pop new word from fifo when bit_counter is back at '15'
	start_multiplier <= start_multiplier_del_i and running_i;
	
	-- start/stop logic
	start_cycle_i <= (start and (not buffer_empty)) or next_bit_i; -- start pulse (external or internal)
	done_i <= (start and buffer_empty) or (next_bit_i and bit_counter_0_i and buffer_empty); -- stop when buffer is empty
	next_bit_i <= (mult_done_del_i and e_bits_0_i) or (mult_done_del_i and (not e_bits_0_i) and (not cycle_counter_i));

	-- process for delaying signals with 1 clock cycle
	DEL_PROC: process(clk)
	begin
		if rising_edge(clk) then
			start_multiplier_del_i <= start_multiplier_i;
			start_cycle_del_i <= start_cycle_i;
			mult_done_del_i <= multiplier_done;
		end if;
	end process DEL_PROC;
	
	-- process for delaying signals with 1 clock cycle
	CYCLE_CNTR_PROC: process(clk, start)
	begin
		if start = '1' or reset = '1' then
			cycle_counter_i <= '0';
		elsif rising_edge(clk) then
			if (e_bits_0_i = '0') and (multiplier_done = '1') then
				cycle_counter_i <= not cycle_counter_i;
			elsif (e_bits_0_i = '1') and (multiplier_done = '1') then
				cycle_counter_i <= '0';
			else
				cycle_counter_i <= cycle_counter_i;
			end if;
		end if;
	end process CYCLE_CNTR_PROC;
	
end Behavioral;

