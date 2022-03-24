------------------------------------------------------------------
--	6502 support module.
--
--	Copyright Ian Chapman October 28 2010
--
--	This file is part of the Lattice 6502 project
--	It is used to compile with Linux ghdl and ispLeaver.
--	The baude rate is 9600.
--
--	To do
--		Nothing.
--
--	*************************************************************
--	Distributed under the GNU Lesser General Public License.    *
--	This can be obtained from “www.gnu.org”.                    *
--	*************************************************************
--	This program is free software: you can redistribute it and/or modify
--	it under the terms of the GNU General Public License as published by
--	the Free Software Foundation, either version 3 of the License, or
--	(at your option) any later version.
--
--	This program is distributed in the hope that it will be useful,
--	but WITHOUT ANY WARRANTY; without even the implied warranty of
--	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--	GNU General Public License for more details.
--
--	You should have received a copy of the GNU General Public License
--	along with this program.  If not, see <http://www.gnu.org/licenses/>
--
--	UART_TX.vhd
--	*************************************************************
--
library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;			--Needed for GHDL

--	RX baude rate generator.  Zero sync to transitions on RX
entity UART_TX is
port(
	OSC_10MHz, PG, csw_usart :in std_logic;
	tx_dat : in unsigned(7 downto 0);
	TX, tx_rdy : out std_logic
	);
end UART_TX;

Architecture behavioral of UART_TX is

--constant define_tx_baude_rate : unsigned (6 downto 0) := "1010111"; --115.2 Kbps
constant define_tx_baude_rate : unsigned (10 downto 0) := "10000010010"; --9.6 Kbps
constant define_tx_bits : unsigned (3 downto 0) := x"B"; --start+8+stop+extra

signal tx_clk_int : unsigned (3 downto 0);
--	signal tx_clk : unsigned (3 downto 0);
signal br_ctr_tx_int : unsigned (10 downto 0);
signal br_strob : std_logic;
signal reg_tx_dat : unsigned (7 downto 0);

begin

--	=================================================
--	Load data to be transmitted
ld_tx : process (osc_10MHz, csw_usart, PG)
begin
if PG = '0' then
	reg_tx_dat <= (others => '0');
elsif rising_edge(osc_10MHz)then
	if csw_usart = '1' then
		reg_tx_dat <= tx_dat;
	end if;
end if;
end process;
--	=================================================
--	TX baude rate generator
TX_brg:process (OSC_10MHz, csw_usart, br_ctr_tx_int)
begin
if PG = '0' then
		br_ctr_tx_int <= (others => '0');
		br_strob <= '0';
elsif rising_edge (OSC_10MHz) then
          if br_ctr_tx_int = define_tx_baude_rate or csw_usart = '1' then
                br_ctr_tx_int <= (others => '0');
         else
		br_ctr_tx_int <= br_ctr_tx_int + 1;
         end if;
	
	if br_ctr_tx_int = define_tx_baude_rate then
		br_strob <= '1';
	else
		br_strob <= '0';
	end if;
end if;
end process;

-- =================================================
--	TX process gen clk for uart tx
transmit_ctr:process(osc_10MHz, csw_usart, br_strob, tx_clk_int, reg_tx_dat)
begin

if PG = '0' then
	tx_clk_int <= define_tx_bits;
	TX <= '1';
elsif rising_edge (osc_10MHz) then
	if csw_usart = '1' then
		tx_clk_int <= (others => '0');
	elsif tx_clk_int /= define_tx_bits and br_strob = '1' then
		tx_clk_int <= tx_clk_int + 1;
	end if;
end if;
--------------------------------------
case tx_clk_int is
--		Start bit
		when X"0" =>
			TX <= '0';
			tx_rdy <= '1';
		when X"1" =>
			TX <= reg_tx_dat(0);
		when X"2" =>
			TX <= reg_tx_dat(1);
		when X"3" =>
			TX <= reg_tx_dat(2);
		when X"4" =>
			TX <= reg_tx_dat(3);
		when X"5" =>
			TX <= reg_tx_dat(4);
		when X"6" =>
			TX <= reg_tx_dat(5);
		when X"7" =>
			TX <= reg_tx_dat(6);
		when X"8" =>
			TX <= reg_tx_dat(7);
--		Stop bit
		when X"9" =>
			TX <= '1';

		when X"A" =>
			TX <= '1';
--			tx_rdy <= '0';
		when X"b" =>
			TX <= '1';
			tx_rdy <= '0';
--		when X"c" =>
--			TX <= '1';
--			tx_rdy <= '0';
--		when X"d" =>
--			TX <= '1';
--			tx_rdy <= '0';
		when others =>
			TX <= '1';
			tx_rdy <= '0';
	end case;
--end if;
end process;

end behavioral;


