----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:02:11 03/25/2018 
-- Design Name: 
-- Module Name:    bin2bcd - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bin2bcd is
    Port ( reset : in  STD_LOGIC;		-- Initialize when high, note that it will drive ready low
           clk : in  STD_LOGIC;			-- Drives the FSM
           start : in  STD_LOGIC;		-- Keep high for at least 1 clock cycle to start conversion
           bin : in  STD_LOGIC_VECTOR (15 downto 0);		-- 16-bit unsigned binary input value
			  ready : out  STD_LOGIC;		-- pulse high when conversion is done
           bcd : buffer STD_LOGIC_VECTOR (23 downto 0);	-- 6 BCD digits output
			  debug: out STD_LOGIC_VECTOR(3 downto 0));		-- debug port, leave open
end bin2bcd;

architecture Behavioral of bin2bcd is

component bcddigitadder is
    Port ( ci : in  STD_LOGIC;
           a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           y : out  STD_LOGIC_VECTOR (3 downto 0);
           cout : inout  STD_LOGIC);
end component;

type state is (st_reset, st_readytostart, st_loadbinval, st_checkzero,
					st_delay, st_update,
					st_shiftdown, st_done);
					
type rom24x16 is array(0 to 15) of std_logic_vector(23 downto 0);
constant bcd_lookup: rom24x16 := (
	0 => 	X"000001",
	1 =>	X"000002",
	2 =>	X"000004",
	3 =>	X"000008",
	4 =>	X"000016",
	5 =>	X"000032",
	6 =>	X"000064",
	7 =>	X"000128",
	8 =>	X"000256",
	9 =>	X"000512",
	10 =>	X"001024",
	11 => X"002048",
	12 =>	X"004096",
	13 =>	X"008192",
	14 =>	X"016384",
	15 =>	X"032768"
);

signal state_current, state_next: state;

signal power: integer range 0 to 15;	-- index to bcd lookup table (2^power in bcd format)
signal zero: std_logic;
signal ripple_carry: std_logic_vector(6 downto 0);
signal bin_val: std_logic_vector(15 downto 0);
signal power_val: std_logic_vector(23 downto 0);
signal bcd_plus_power: std_logic_vector(23 downto 0);

begin

debug <= std_logic_vector(to_unsigned(power, 4));

power_val <= bcd_lookup(power);
ripple_carry(0) <= '0';
zero <= '1' when bin_val = X"0000" else '0';

gen_digit_adders: for i in 0 to 5 generate -- six output digits
	digadd: bcddigitadder port map 
				(
					ci => ripple_carry(i),
					a => bcd(3 + 4 * i downto 4 * i),
					b => power_val(3 + 4 * i downto 4 * i),
					y => bcd_plus_power(3 + 4 * i downto 4 * i),
					cout => ripple_carry(i + 1)
				);
end generate;

-- FSM
drive: process(reset, clk, state_next)
begin
	if (reset = '1') then
		state_current <= st_reset;
	else
		if (rising_edge(clk)) then
			state_current <= state_next;
		end if;
	end if;
end process;

execute: process(clk, state_current)
begin
	if (rising_edge(clk)) then
		case state_current is
			when st_reset =>
				ready <= '0';
				
			when st_readytostart =>
				ready <= '1';
				power <= 0;

			when st_loadbinval =>
				ready <= '0';
				bin_val <= bin;
				bcd <= X"000000";

			when st_checkzero =>
					
			when st_delay =>

			when st_update =>
				bcd <= bcd_plus_power;

			when st_shiftdown =>
				bin_val <= '0' & bin_val(15 downto 1);
				power <= power + 1;
				
			when st_done =>
				ready <= '1';

			when others =>
				null;
				
		end case;
	end if;
end process;

sequence: process(state_current, zero, bin_val) 
begin
	case state_current is
		when st_reset =>
			state_next <= st_readytostart;
			
		when st_readytostart =>
			if (start = '1') then
				state_next <= st_loadbinval; 
			else
				state_next <= st_readytostart; -- continue waiting for start
			end if;

		when st_loadbinval =>
			state_next <= st_checkzero;
			
		when st_checkzero =>
			if (zero = '1') then
				state_next <= st_done;
			else
				if (bin_val(0) = '1') then
					state_next <= st_delay;
				else
					state_next <= st_shiftdown;
				end if;
			end if;
			
		when st_delay =>
			state_next <= st_update;
			
		when st_update =>
			state_next <= st_shiftdown;

		when st_shiftdown =>
			state_next <= st_checkzero;
			
		when st_done =>
			state_next <= st_readytostart;

		when others =>
			null;
	end case;
end process;
		
				
end Behavioral;

