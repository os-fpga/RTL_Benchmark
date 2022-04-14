------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	x_shift_reg.vhd / entity x_shift_reg
-- 
-- Last Modified:	18/06/2012 
-- 
-- Description: 	n-bit shift register with lsb output
--
--
-- Dependencies: 	none
--
-- Revision:
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

entity x_shift_reg is
	generic(  n : integer := 1536;
		       t : integer := 48;
				tl : integer := 16
	);
	port(   clk : in  STD_LOGIC;
         reset : in  STD_LOGIC;
          x_in : in  STD_LOGIC_VECTOR((n-1) downto 0);
        load_x : in  STD_LOGIC;
        next_x : in  STD_LOGIC;
		   p_sel : in  STD_LOGIC_VECTOR(1 downto 0);
           x_i : out  STD_LOGIC
	);
end x_shift_reg;

architecture Behavioral of x_shift_reg is
	signal x_reg_i : std_logic_vector((n-1) downto 0); -- register
	constant s : integer := n/t;   -- nr of stages
	constant offset : integer := s*tl; -- calculate startbit pos of higher part of pipeline
begin
	
	REG_PROC: process(reset, clk)
	begin
		if reset = '1' then -- Reset, clear the register
			x_reg_i <= (others => '0');
		elsif rising_edge(clk) then
			if load_x = '1' then -- Load_x, load the register with x_in
				x_reg_i <= x_in;
			elsif next_x = '1' then  -- next_x, shift to right. LSbit gets lost and zero's are shifted in
				x_reg_i((n-2) downto 0) <= x_reg_i((n-1) downto 1);
			else -- else remember state
				x_reg_i <= x_reg_i;
			end if;
		end if;
	end process;

	with p_sel select  -- pipeline select
		x_i <= x_reg_i(offset) when "10",   -- use bit at offset for high part of pipeline
				 x_reg_i(0) when others;    -- use LS bit for lower part of pipeline

end Behavioral;

