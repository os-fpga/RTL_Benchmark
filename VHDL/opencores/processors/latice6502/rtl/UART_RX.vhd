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
--	UART_RX.vhd
--	*************************************************************
--
library IEEE;
--Library UNISIM;
--library WORK;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;			--Needed for GHDL
--use UNISIM.vcomponents.all;
--use WORK.ALFT_GLOBAL_lib.all;


--	RX baude rate generator.  Zero sync to transitions on RX
entity UART_RX is
port(
	RX, OSC_10MHz, csr_usart :in std_logic;
	PG : in std_logic;			--Power Good.
	RX_rdy : out std_logic;
	rx_reg : out unsigned(7 downto 0)
	);
end UART_RX;

Architecture behavioral of UART_RX is

--constant define_rx_baude_rate : unsigned (5 downto 0) := "101011";  --115.2 Kbps
constant define_rx_baude_rate : unsigned (10 downto 0) := "10000010010"; --9.6 Kbps
constant define_rx_mid_strob : unsigned (10 downto 0)  := "01000001001";
constant define_rx_bits : unsigned (3 downto 0) := x"A"; --start+8+stop
signal rx_start_pul, br_start_pul, RX_BR_clk : std_logic;
signal RX_sr : std_logic_vector (1 downto 0);
signal rx_clk_int : unsigned (3 downto 0);
signal rx_br_ctr_int   : unsigned (10 downto 0);
signal br_strob, br_mid_strob, end_ff : std_logic;

--	=============================================================
--	Synchronize BR counter to RX data transitions.

begin
Start_up:process (OSC_10MHz, PG,  RX)
begin
if PG = '0' then
	rx_start_pul <= '0';
elsif falling_edge (OSC_10MHz) then
	RX_sr <= RX_sr(0) & RX;
	if RX_sr = "10" and RX = '0' and rx_clk_int = define_rx_bits then
		rx_start_pul <= '1';		--Used to sync the BR clock
	else
		rx_start_pul <= '0';
	end if;
end if;
end process;
--====================================
--	The receive counter sits at end of count until transition
--	on the RX data in line then it is set to zero
Init_BR:process (rx_start_pul, rx_clk_int)
begin
if rx_clk_int = define_rx_bits then
	br_start_pul <= rx_start_pul;	--rx_start_pul is the transition
else
	br_start_pul <= '0';		--Used to start the Receive counter
end if;
end process;
--	=================================================

--	This divides the 10MHz down to the baud rate
--	The baude rate clock the receive counter
--	that counts the RX data bits into a register.

RX_BR_counter:process (OSC_10MHz, PG, rx_start_pul, rx_br_ctr_int, rx_clk_int, br_start_pul)
begin
if PG = '0' then
	rx_br_ctr_int <= define_rx_baude_rate;
	br_strob <= '0';
	br_mid_strob <= '0';
elsif rising_edge (OSC_10MHz) then
	if rx_start_pul = '1' or rx_br_ctr_int = define_rx_baude_rate then
		rx_br_ctr_int <= (others => '0');
	else
		rx_br_ctr_int <= rx_br_ctr_int + "1";		-- + 1;
	end if;
	if rx_br_ctr_int = define_rx_baude_rate then
		br_strob <= '1';
	else
		br_strob <= '0';
	end if;
	if rx_br_ctr_int = define_rx_mid_strob then
		br_mid_strob <= '1';
	else
		br_mid_strob <= '0';
	end if;
end if;
end process;

-- =================================================

--	This flip flop clocks the counter and Rx data

RX_clock:process (OSC_10MHz, br_strob, br_start_pul, rx_clk_int, rx_br_ctr_int)
begin
if br_start_pul = '1' then
	RX_BR_clk <= '0';
elsif falling_edge (OSC_10MHz) then
	if br_strob = '1' then
		RX_BR_clk <= not RX_BR_clk;
	end if;
end if;
end process;
--	====================================================

--	This process counts the bits starting with the start bit

receive_ctr:process(OSC_10MHz, br_strob, br_start_pul, RX_BR_clk, RX,rx_clk_int)
begin
if PG = '0' then
	rx_clk_int <= define_rx_bits;
elsif rising_edge (OSC_10MHz) then
	if (rx_clk_int /= define_rx_bits and br_strob = '1') then
		rx_clk_int <= rx_clk_int + X"1";
	elsif br_start_pul = '1' then
		rx_clk_int <= (others => '0');
	end if;
end if;
end process;

Receiver:process (OSC_10MHz, RX, RX_BR_clk, rx_clk_int)
begin
if PG = '0' then
	rx_reg <= (others => '0');

elsif rising_edge (OSC_10MHz) then
	if br_mid_strob = '1' then
		case rx_clk_int is
			when X"1" =>
				rx_reg(0) <= RX;
			when X"2" =>
				rx_reg(1) <= RX;
			when X"3" =>
				rx_reg(2) <= RX;
			when X"4" =>
				rx_reg(3) <= RX;
			when X"5" =>
				rx_reg(4) <= RX;
			when X"6" =>
				rx_reg(5) <= RX;
			when X"7" =>
				rx_reg(6) <= RX;
			when X"8" =>
				rx_reg(7) <= RX;
			when others =>
				null;
	end case;
	end if;
end if;
end process;

Set_rdy :process (OSC_10MHz, rx_start_pul, rx_clk_int)
begin
if PG = '0' then
	RX_rdy <= '0';
	end_ff <= '0';
elsif rising_edge (OSC_10MHz) then
	if rx_clk_int = 9 then
		end_ff <= '1';
	end if;
	if rx_clk_int = 9 and end_ff ='0' then
		RX_rdy <= '1';
	elsif csr_usart = '1' then
		RX_rdy <= '0';
	elsif rx_start_pul = '1'then
		end_ff <= '0';
	end if;
end if;
end process;

end behavioral;

