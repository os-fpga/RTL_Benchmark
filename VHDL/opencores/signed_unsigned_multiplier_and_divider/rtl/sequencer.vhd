----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:09:31 03/10/2018 
-- Design Name: 
-- Module Name:    sequencer - Behavioral 
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
use work.sys_primegen_package.all;

entity sequencer is
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           operation : in  STD_LOGIC_VECTOR (2 downto 0);
           condition : in  STD_LOGIC;
           directvalue : in  STD_LOGIC_VECTOR (7 downto 0);
           uIP : out  STD_LOGIC_VECTOR (7 downto 0));
end sequencer;

architecture Behavioral of sequencer is

type ip_stack is array(0 to 3) of integer range 0 to 255;

signal ip: ip_stack;
signal ip_sp: integer range 0 to 3; -- 2 bit "stack pointer" allows 4 level nesting

begin

setnextip: process(reset, clk, operation, condition, directvalue)
begin
	if (reset = '1') then
		ip_sp <= 0;
		ip(0) <= 0;
	else
		if (rising_edge(clk)) then
			case operation is
				when if_next_else_next =>
					ip(ip_sp) <= ip(ip_sp) + 1;
					
				when if_next_else_repeat =>
					if (condition = '1') then
						ip(ip_sp) <= ip(ip_sp) + 1;
					end if;
					
				when if_goto_else_next	=>
					if (condition = '1') then
						ip(ip_sp) <= to_integer(unsigned(directvalue));
					else
						ip(ip_sp) <= ip(ip_sp) + 1;
					end if;

				when if_gosub_else_next =>
					if (condition = '1') then
						ip(ip_sp) <= ip(ip_sp) + 1;
						ip(ip_sp + 1) <= to_integer(unsigned(directvalue));
						ip_sp <= ip_sp + 1;
					else
						ip(ip_sp) <= ip(ip_sp) + 1;
					end if;

				when if_gosub_else_repeat =>
					if (condition = '1') then
						ip(ip_sp) <= ip(ip_sp) + 1;
						ip(ip_sp + 1) <= to_integer(unsigned(directvalue));
						ip_sp <= ip_sp + 1;
					end if;

				when if_return_else_next =>
					if (condition = '1') then
						ip_sp <= ip_sp - 1;
					else
						ip(ip_sp) <= ip(ip_sp) + 1;
					end if;
				
				when if_goto_else_start =>
					if (condition = '1') then
						ip(ip_sp) <= to_integer(unsigned(directvalue));
					else
						ip_sp <= 0;
						ip(0) <= 0;
					end if;
					
				when others =>
					null;
			end case;
		end if;
	end if;
end process;

with ip_sp select
	uIP <= 	std_logic_vector(to_unsigned(ip(0), 8)) when 0,
				std_logic_vector(to_unsigned(ip(1), 8)) when 1,
				std_logic_vector(to_unsigned(ip(2), 8))	when 2,
				std_logic_vector(to_unsigned(ip(3), 8)) when others;

end Behavioral;

