----------------------------------------------------------------------------------
-- Company: @Home
-- Engineer: zpekic@hotmail.com
-- 
-- Create Date:    15:37:39 02/04/2018 
-- Design Name: 
-- Module Name:    signedmultiplier - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Mostly bsed on Chapter 7-3 from "Computer Organization and Architecture" by William Stallings
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

entity signedmultiplier is
    Port ( reset : in  STD_LOGIC;		-- Active high to initialize. Note that ready will be low as long as it remains high
           clk : in  STD_LOGIC;			-- Clock to drive the FSM
           start : in  STD_LOGIC;		-- Apply high for at least 1 clock cycle to start computation
			  mode: in STD_LOGIC_VECTOR(1 downto 0);	-- 00: unsigned multiply, 01: signed multiply, 10: unsigned divide, 11: signed divide
			  dividend32: in STD_LOGIC;	-- 0: 16/16 divide, 1: 32/16 divide
           arg0h : in  STD_LOGIC_VECTOR (15 downto 0);		-- used as MSW for 32/16 divide
           arg0l : in  STD_LOGIC_VECTOR (15 downto 0);		-- LSW for 32/16 divide, factor0 for 16*16 multiplication
           arg1 : in  STD_LOGIC_VECTOR (15 downto 0);			-- factor1 for 16*16 multiplication
           result : buffer  STD_LOGIC_VECTOR (31 downto 0);	-- 32 bit result when multiplying, when dividing quotient is MSW, remainder is LSW
           ready : out  STD_LOGIC;		-- goes high when done
           error : out  STD_LOGIC;		-- goes high when dividing by 0
           zero : out  STD_LOGIC;		-- quotient is zero (divide) or whole product is zero (multiplication)
           sign : out  STD_LOGIC;		-- same result checked like for zero, only meaningful for signed operation
			  debug : out STD_LOGIC_VECTOR(3 downto 0));	-- debug output (leave open)
end signedmultiplier;

architecture Behavioral of signedmultiplier is

constant min_value: std_logic_vector(15 downto 0):= 			X"8000";
constant zero_value: std_logic_vector(15 downto 0):= 			X"0000";
constant minusone_value: std_logic_vector(15 downto 0):= 	X"FFFF";
constant min_value32: std_logic_vector(31 downto 0):= 		X"80000000";
constant zero_value32: std_logic_vector(31 downto 0):= 		X"00000000";
constant minusone_value32: std_logic_vector(31 downto 0):= 	X"FFFFFFFF";

type state is (st_reset, st_readytostart, 
					-- Multiply
					st_mul_checkzero, st_mul_setzero, st_mul_setprod,
					st_ms_checkq, st_ms_aplusm, st_ms_aminusm, st_ms_shiftanddecrement, st_ms_checkcounter, 
					st_mu_checkq, st_mu_aplusm, 					 st_mu_shiftanddecrement, st_mu_checkcounter,
					-- Divide
					st_div_checkzero, st_div_setresult, st_div_setzero,
					st_dq_posdivneg, st_dq_negdivpos, st_dq_negdivneg, st_dq_checkquadrant, 
					st_du_checkfit, st_du_shiftleft, st_du_aminusm, st_du_checka, st_du_setq0decrement, st_du_clearq0decrementaplusm, st_du_checkcounter,
					-- Common
					st_done_ok, st_done_error);
					
signal state_current, state_next: state;

signal m32: std_logic_vector(31 downto 0);
signal caqx32: std_logic_vector(65 downto 0);
alias c32: std_logic is caqx32(65);
alias a32: std_logic_vector(31 downto 0) is caqx32(64 downto 33);
alias q32: std_logic_vector(31 downto 0) is caqx32(32 downto 1);
alias aq32: std_logic_vector(63 downto 0) is caqx32(64 downto 1);
alias ca32: std_logic_vector(32 downto 0) is caqx32(65 downto 33);

signal m: std_logic_vector(15 downto 0);
signal caqx: std_logic_vector(33 downto 0);
alias c: std_logic is caqx(33);
alias a: std_logic_vector(15 downto 0) is caqx(32 downto 17);
alias q: std_logic_vector(15 downto 0) is caqx(16 downto 1);
alias x: std_logic is caqx(0);
alias caq: std_logic_vector(32 downto 0) is caqx(33 downto 1);
alias aq: std_logic_vector(31 downto 0) is caqx(32 downto 1);
alias aqx: std_logic_vector(32 downto 0) is caqx(32 downto 0);
alias ca: std_logic_vector(16 downto 0) is caqx(33 downto 17);
alias prod: std_logic_vector(31 downto 0) is result;
alias quotient: std_logic_vector(15 downto 0) is result(31 downto 16);
alias remainder: std_logic_vector(15 downto 0) is result(15 downto 0);
signal m_is_zero, q_is_zero, m_is_minusone, q_is_min: std_logic;

signal q_is_negative, m_is_negative, carry: std_logic;
signal counter: integer range 0 to 32;
signal a_padded, m_padded, m_2compl, a_minus_m, a_plus_m: std_logic_vector(17 downto 0); -- these include carry in and out!
signal a_complement, q_complement, m_complement: std_logic_vector(15 downto 0);
signal a32_padded, m32_padded, m32_2compl, a32_minus_m32, a32_plus_m32: std_logic_vector(33 downto 0); -- these include carry in and out!
signal a32_complement, q32_complement, m32_complement: std_logic_vector(31 downto 0);
signal changesign_quotient, changesign_remainder: std_logic;
signal mode32, quotient_will_fit: std_logic;

begin

debug(3) <= q_is_negative;
debug(2) <= m_is_negative;
debug(1) <= changesign_quotient;
debug(0) <= changesign_remainder;

-- 32 bit mode only for division!
mode32 <= mode(1) and dividend32;

-- combinatorial output flags
zero <= '1' when ((prod = zero_value32 and mode(1) = '0') or (quotient = zero_value and mode(1) = '1')) else '0';
sign <= prod(31) when mode(1) = '0' else quotient(15);

-- combinatorial signals to help drive the FSM
m_is_zero <= '1' when ((m = zero_value and mode32 = '0') or (m32 = zero_value32 and mode32 = '1')) else '0';
q_is_zero <= '1' when ((q = zero_value and mode32 = '0') or (q32 = zero_value32 and mode32 = '1')) else '0';
m_is_minusone <= '1' when ((m = minusone_value and mode32 = '0') or (m32 = minusone_value32 and mode32 = '1')) else '0';
q_is_min  <= '1' when ((q = min_value and mode32 = '0') or (q32 = min_value32 and mode32 = '1')) else '0';

--q_is_negative <= q(15) when mode32 = '0' else q32(31);
--m_is_negative <= m(15) when mode32 = '0' else m32(31);

carry <= c when mode32 = '0' else c32;
quotient_will_fit <= '1' when (unsigned(m32(15 downto 0)) > unsigned(q32(31 downto 16))) else '0';

-- 2's complement add and substract
a_padded <= '0' & a & '1';
m_padded <= '0' & m & '0';
m_2compl <= "011111111111111111" xor m_padded;
a_minus_m <= std_logic_vector(unsigned(a_padded) + unsigned(m_2compl));
a_plus_m <= std_logic_vector(unsigned(a_padded) + unsigned(m_padded));
q_complement <= std_logic_vector(unsigned(q xor minusone_value) + 1);
a_complement <= std_logic_vector(unsigned(a xor minusone_value) + 1);
m_complement <= std_logic_vector(unsigned(m xor minusone_value) + 1);

a32_padded <= '0' & a32 & '1';
m32_padded <= '0' & m32 & '0';
m32_2compl <= "0111111111111111111111111111111111" xor m32_padded;
a32_minus_m32 <= std_logic_vector(unsigned(a32_padded) + unsigned(m32_2compl));
a32_plus_m32 <= std_logic_vector(unsigned(a32_padded) + unsigned(m32_padded));
q32_complement <= std_logic_vector(unsigned(q32 xor minusone_value32) + 1);
a32_complement <= std_logic_vector(unsigned(a32 xor minusone_value32) + 1);
m32_complement <= std_logic_vector(unsigned(m32 xor minusone_value32) + 1);

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
				error <= '0';
				
			when st_readytostart =>
				ready <= '1';
				m_is_negative <= mode(0) and arg1(15);
				if (mode32 = '0') then
					counter <= 16;
					q_is_negative <= mode(0) and arg0l(15);
				else
					counter <= 32;
					q_is_negative <= mode(0) and arg0h(15);
				end if;
				-- for 16*16 bit multiplication and 16/16 bit divisions
				m <= arg1;
				caqx <= '0' & X"0000" & arg0l & '0';
				-- for 32/16 bit divisions
				if (mode(0) = '1' and arg1(15) = '1') then
					m32 <= X"FFFF" & arg1;
				else
					m32 <= X"0000" & arg1;
				end if;
				caqx32 <= '0' & X"00000000" & arg0h & arg0l & '0';

			when st_mul_checkzero => -- clear ready and error when entering computation
				ready <= '0';
				error <= '0';
				
			when st_ms_aminusm =>
				ca <= a_minus_m(17 downto 1);
			
			when st_ms_aplusm | st_mu_aplusm =>
				ca <= a_plus_m(17 downto 1);
			
			when st_ms_shiftanddecrement =>
				aqx <= aqx(32) & aqx(32 downto 1);
				counter <= counter - 1;

			when st_mu_shiftanddecrement =>
				caq <= '0' & caq(32 downto 1);
				counter <= counter - 1;

			when st_mul_setzero =>
				prod <= X"00000000";
			
			when st_mul_setprod =>
				prod <= aq;

			when st_done_ok =>
				error <= '0';

			when st_done_error =>
				error <= '1';
			
			when st_div_checkzero =>
				ready <= '0';				-- clear ready when entering computation
				error <= '0';
				changesign_quotient <= '0';
				changesign_remainder <= '0';
				--- for debugging ---
				--result <= aq; 
				
			when st_div_setzero =>
				quotient <= q;		-- q = 0
				remainder <= m;	-- remainder = dividend

			when st_div_setresult =>
				if (mode32 = '0') then
					if (changesign_quotient = '0') then
						quotient <= q;
					else 
						quotient <= q_complement;
					end if;
					if (changesign_remainder = '0') then
						remainder <= a;
					else 
						remainder <= a_complement;
					end if;
				else
					if (changesign_quotient = '0') then
						quotient <= q32(15 downto 0);
					else 
						quotient <= q32_complement(15 downto 0);
					end if;
					if (changesign_remainder = '0') then
						remainder <= a32(15 downto 0);
					else 
						remainder <= a32_complement(15 downto 0);
					end if;
				end if;
				
			when st_du_shiftleft =>
				aq <= aq(30 downto 0) & '0';
				aq32 <= aq32(62 downto 0) & '0';
				--- for debugging ---
				result <= aq32(31 downto 0);
			
			when st_du_aminusm =>
				ca <= a_minus_m(17 downto 1); 
				ca32 <= a32_minus_m32(33 downto 1); 
				--- for debugging ---
				result <= aq32(31 downto 0);
								
			when st_du_setq0decrement => --| st_ds_setq0decrement =>
				q <= q or X"0001";
				q32 <= q32 or X"00000001";
				counter <= counter - 1;
				--- for debugging ---
				result <= aq32(31 downto 0);
				
			when st_du_clearq0decrementaplusm =>
				ca <= a_plus_m(17 downto 1);
				ca32 <= a32_plus_m32(33 downto 1);
				counter <= counter - 1;
				--- for debugging ---
				result <= aq32(31 downto 0);
			
			when st_du_checkcounter =>
				--- for debugging ---
				result <= m32; --std_logic_vector(to_unsigned(counter, 32));
				
			when st_dq_posdivneg =>
				m <= m_complement;
				m32 <= m32_complement;
				changesign_quotient <= '1';
				--- for debugging ---
				result <= aq32(31 downto 0);

			when st_dq_negdivpos =>
				q <= q_complement;
				q32 <= q32_complement;
				changesign_quotient <= '1';
				changesign_remainder <= '1';
				--- for debugging ---
				result <= aq32(31 downto 0);
				
			when st_dq_negdivneg =>
				q <= q_complement;
				q32 <= q32_complement;
				m <= m_complement;
				m32 <= m32_complement;
				changesign_remainder <= '1';
				--- for debugging ---
				result <= aq32(31 downto 0);
	
			when others =>
				null;
				
		end case;
	end if;
end process;

sequence: process(state_current, aq, m, counter, start) 
begin
	case state_current is
		when st_reset =>
			state_next <= st_readytostart;
			
--		COMMON START --	
		when st_readytostart =>
			if (start = '1') then
				if (mode(1) = '0') then
					state_next <= st_mul_checkzero; -- * starting point
				else
					state_next <= st_div_checkzero; -- / starting point
				end if;
			else
				state_next <= st_readytostart;
			end if;

--		DIVISION
		when st_div_checkzero =>
			if (m_is_zero = '1') then
				state_next <= st_done_error; -- all divide by zero results in error!
			else
				if (q_is_zero = '1') then
					state_next <= st_div_setzero; -- divide zero by something other then 0 is 0 with remainder
				else
					if (mode(0) = '1') then
						if (q_is_min = '1' and m_is_minusone = '1' ) then -- -32768 / -1 = overflow!
							state_next <= st_done_error;
						else 
							state_next <= st_dq_checkquadrant; -- signed divide
						end if;
					else
						state_next <= st_du_checkfit; -- unsigned divide
					end if;
				end if;
			end if;

		when st_div_setzero =>
			state_next <= st_done_ok;
		
		when st_div_setresult =>
			state_next <= st_readytostart; -- set result may have set error flag to 1!

--    signed, 4 quadrant approach --
		when st_dq_checkquadrant =>
			if (q_is_negative = '0') then
				if (m_is_negative = '0') then
					state_next <= st_du_checkfit;		-- +/+ = unsigned divide
				else
					state_next <= st_dq_posdivneg;		-- +/-
				end if;
			else
				if (m_is_negative = '0') then
					state_next <= st_dq_negdivpos;		-- -/+
				else
					state_next <= st_dq_negdivneg;		-- -/-
				end if;
			end if;
			
		when st_dq_posdivneg | st_dq_negdivpos | st_dq_negdivneg =>
			state_next <= st_du_checkfit;
			
--		unsigned --
		when st_du_checkfit =>
			if (mode32 = '0') then
				state_next <= st_du_shiftleft;
			else
				if (quotient_will_fit = '1') then
					state_next <= st_du_shiftleft;
				else
					state_next <= st_done_error;
				end if;
			end if;
			
		when st_du_shiftleft =>
			state_next <= st_du_aminusm;
		
		when st_du_aminusm =>
			state_next <= st_du_checka;
			
		when st_du_checka =>
			if (carry = '1') then -- A >= M
				state_next <= st_du_setq0decrement;
			else
				state_next <= st_du_clearq0decrementaplusm;
			end if;
		
		when st_du_setq0decrement =>
			state_next <= st_du_checkcounter;
			
		when st_du_clearq0decrementaplusm =>
			state_next <= st_du_checkcounter;
		
		when st_du_checkcounter =>
			if (counter = 0) then
				state_next <= st_div_setresult;
			else
				state_next <= st_du_shiftleft;
			end if;
		
--		MULTIPLICATION --	
		when st_mul_checkzero =>
			if (q_is_zero = '1' or m_is_zero = '1') then
				state_next <= st_mul_setzero;
			else
				if (mode(0) = '0') then
					state_next <= st_mu_checkq;
				else
					state_next <= st_ms_checkq;
				end if;
			end if;
			
		when st_mul_setzero =>
			state_next <= st_done_ok;

		when st_mul_setprod =>
			state_next <= st_done_ok;

--		Unsigned --
		when st_mu_checkq =>
			if q(0) = '1' then
				state_next <= st_mu_aplusm;
			else
				state_next <= st_mu_shiftanddecrement;
			end if;

		when st_mu_aplusm =>
			state_next <= st_mu_shiftanddecrement;
		
		when st_mu_shiftanddecrement =>
			state_next <= st_mu_checkcounter;

		when st_mu_checkcounter =>
			if (counter = 0) then
				state_next <= st_mul_setprod;
			else
				state_next <= st_mu_checkq;
			end if;
			
--		Signed --
		when st_ms_checkq =>
			case aqx(1 downto 0) is
				when "10" =>
					state_next <= st_ms_aminusm;
				when "01" =>
					state_next <= st_ms_aplusm;
				when others =>
					state_next <= st_ms_shiftanddecrement;
			end case;
			
		when st_ms_aminusm =>
			state_next <= st_ms_shiftanddecrement;
		
		when st_ms_aplusm =>
			state_next <= st_ms_shiftanddecrement;
		
		when st_ms_shiftanddecrement =>
			state_next <= st_ms_checkcounter;
		
		when st_ms_checkcounter =>
			if (counter = 0) then
				state_next <= st_mul_setprod;
			else
				state_next <= st_ms_checkq;
			end if;

--		COMMON END --		
		when st_done_ok =>
			state_next <= st_readytostart;

		when st_done_error =>
			state_next <= st_readytostart;
			
		when others =>
			null;
	end case;
end process;

end Behavioral;

