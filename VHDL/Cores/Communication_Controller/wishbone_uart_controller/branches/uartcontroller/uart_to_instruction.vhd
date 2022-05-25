----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:03:15 04/17/2013 
-- Design Name: 
-- Module Name:    uart_to_instruction - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_to_instruction is
    Port ( 	uart_rx_data_out_stb : in  STD_LOGIC;
				rd:out  STD_LOGIC;
				data_in: IN std_logic_vector(7 downto 0);
				next_instructie:in std_logic;
				enable:out std_logic;
				clock:in  STD_LOGIC;
				send_data: out std_logic;
				queue_empty:in std_logic;
				opcode:out std_logic;
				adress:out std_logic_vector(7 downto 0);
				data:out std_logic_vector(7 downto 0)
			);
end uart_to_instruction;

architecture Behavioral of uart_to_instruction is
signal count : integer range 0 to 3:=0;
signal send_data_int: std_logic:='0';
signal instructie_i:std_logic_vector(15 downto 0);
begin
process(clock)
begin
	if rising_edge(clock) then
			if uart_rx_data_out_stb ='1' then
				if count=0 then
					instructie_i(15 downto 8) <=data_in;
					if data_in(7)='0' then
						if data_in = x"00" then
							count<=3;-- to pc
						else
							count <=  2;
						end if;
					else
						count<=1;--write instructie wacht tot volgende byte.
					end if;
					rd<='1';
				elsif count=1 then
					count<=2;
					instructie_i(7 downto 0) <=data_in;
					rd<='1';
				end if;
			elsif uart_rx_data_out_stb ='0' then
				rd<='0';
			end if;
			if next_instructie ='1' then
				if count=2 then
					opcode<=instructie_i(15);
					adress<='0'&instructie_i(14 downto 8); 
					data<=instructie_i(7 downto 0); 
					enable<='1';
					count<=0;
				elsif count=3 then
					send_data_int<='1';
				end if;
			else
				enable<='0';
			end if;
		if count=3 and send_data_int='1' and queue_empty='1' then
			count<=0;
			send_data_int<='0';
		end if;
	end if;
end process;
send_data<=send_data_int;
end Behavioral;

