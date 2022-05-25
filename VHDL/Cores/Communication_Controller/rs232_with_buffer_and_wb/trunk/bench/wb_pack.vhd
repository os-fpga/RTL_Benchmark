--
--
--  This file is a part of JOP, the Java Optimized Processor
--
--  Copyright (C) 2001-2008, Martin Schoeberl (martin@jopdesign.com)
--
--  This program is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, either version 3 of the License, or
--  (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program.  If not, see <http://www.gnu.org/licenses/>.
--


--
--
--	Package for Wishbone defines and testbench procedures
--
--	31012013 - TNJ - Adopted the package for testing the WB interface
--	31012013 - TNJ - Added wb_naive_connect to make interface easier
--	
--

library std;
use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package wb_pack is

	constant TIMEOUT : integer := 10;
	constant M_DATA_SIZE : integer := 8;
	constant M_ADDR_SIZE : integer := 8;
	constant S_DATA_SIZE : integer := 8;
	constant S_ADDR_SIZE : integer := 8;

--
--	type definitions for the memory WISHBONE interface
--

	-- 21 bits as example for the SRAM/Flash/NAND interface
	constant MEM_ADDR_SIZE : integer := 21;

	type wb_mem_out_type is record
		dat : std_logic_vector(31 downto 0);
		adr : std_logic_vector(MEM_ADDR_SIZE-1 downto 0);
		we  : std_logic;
		cyc : std_logic;
		sel : std_logic_vector(3 downto 0);
		stb : std_logic;
	end record;
	type wb_mem_in_type is record
		dat : std_logic_vector(31 downto 0);
		ack : std_logic;
	end record;

--
--	type definitions for the IO WISHBONE interface
--

	type wb_slave_in_type is record
		dat_i : std_logic_vector(S_DATA_SIZE-1 downto 0);
		adr_i : std_logic_vector(S_ADDR_SIZE-1 downto 0);
		we_i  : std_logic;
		cyc_i : std_logic;
		stb_i : std_logic;
	end record;
	type wb_slave_out_type is record
		dat_o : std_logic_vector(S_DATA_SIZE-1 downto 0);
		ack_o : std_logic;
	end record;

	type wb_master_out_type is record
		dat_o : std_logic_vector(M_DATA_SIZE-1 downto 0);
		adr_o : std_logic_vector(M_ADDR_SIZE-1 downto 0);
		we_o  : std_logic;
		cyc_o : std_logic;
		stb_o : std_logic;
	end record;
	type wb_master_in_type is record
		dat_i : std_logic_vector(M_DATA_SIZE-1 downto 0);
		ack_i : std_logic;
	end record;

	procedure wb_connect(
		signal m_in	: out wb_master_in_type;
		signal m_out : in wb_master_out_type;
		signal s_in	: out wb_slave_in_type;
		signal s_out : in wb_slave_out_type);
		
	procedure wb_reset(
		signal clk		: in	std_logic;
		signal m_out	: out	wb_master_out_type);
	
	procedure wb_naive_connect(
		signal s_cyc_i	: out	std_logic;
		signal s_stb_i	: out	std_logic;
		signal s_ack_o	: in	std_logic;
		signal s_we_i	: out	std_logic;
		signal s_adr_i	: out	std_logic_vector(S_ADDR_SIZE-1 downto 0);
		signal s_dat_i	: out	std_logic_vector(S_DATA_SIZE-1 downto 0);
		signal s_dat_o	: in	std_logic_vector(S_DATA_SIZE-1 downto 0);
		signal m_in		: out	wb_master_in_type;
		signal m_out 	: in	wb_master_out_type);

	procedure wb_write(
		signal clk : in std_logic;
		constant addr : in natural;
		constant data : in natural;
		signal wb_in	: in wb_master_in_type;
		signal wb_out : out wb_master_out_type);

	procedure wb_read(
		signal clk : in std_logic;
		constant addr : in natural;
		variable data : out natural;
		signal wb_in	: in wb_master_in_type;
		signal wb_out : out wb_master_out_type);
	
	procedure wb_confirme_write(
		signal clk 		: in	std_logic;
		constant addr 	: in	natural;
		constant data 	: in	natural;
		signal wb_in	: in	wb_master_in_type;
		signal wb_out	: out	wb_master_out_type);

end wb_pack;

package body wb_pack is

	procedure wb_connect(
		signal m_in	: out wb_master_in_type;
		signal m_out : in wb_master_out_type;
		signal s_in	: out wb_slave_in_type;
		signal s_out : in wb_slave_out_type) is

	begin

		s_in.dat_i <= m_out.dat_o(S_DATA_SIZE-1 downto 0);
		s_in.we_i <= m_out.we_o;
		s_in.adr_i <= m_out.adr_o(S_ADDR_SIZE-1 downto 0);
		s_in.cyc_i <= m_out.cyc_o;
		s_in.stb_i <= m_out.stb_o;

		m_in.dat_i <= s_out.dat_o;
		m_in.ack_i <= s_out.ack_o;

	end;
	
	procedure wb_reset(
		signal clk		: in std_logic;
		signal m_out	: out wb_master_out_type) is
	begin
		wait until rising_edge(clk);
		m_out.dat_o <= (others => '0');
		m_out.adr_o	<= (others => '0');
		m_out.we_o 	<= '0';
		m_out.cyc_o	<= '0';
		m_out.stb_o	<= '0';
	end;
	
	procedure wb_naive_connect(
		signal s_cyc_i	: out	std_logic;
		signal s_stb_i	: out	std_logic;
		signal s_ack_o	: in	std_logic;
		signal s_we_i	: out	std_logic;
		signal s_adr_i	: out	std_logic_vector(S_ADDR_SIZE-1 downto 0);
		signal s_dat_i	: out	std_logic_vector(S_DATA_SIZE-1 downto 0);
		signal s_dat_o	: in	std_logic_vector(S_DATA_SIZE-1 downto 0);
		signal m_in		: out	wb_master_in_type;
		signal m_out 	: in	wb_master_out_type) is
	
	begin
		
		s_cyc_i 	<= m_out.cyc_o;
		s_stb_i		<= m_out.stb_o;
		s_we_i		<= m_out.we_o;
		s_adr_i		<= m_out.adr_o;
		s_dat_i		<= m_out.dat_o;
		
		m_in.dat_i 	<= s_dat_o;
		m_in.ack_i 	<= s_ack_o;
		
	end;
		

	procedure wb_write(
		signal clk : in std_logic;
		constant addr : in natural;
		constant data : in natural;
		signal wb_in	: in wb_master_in_type;
		signal wb_out : out wb_master_out_type) is

		variable txt : line;

	begin

		-- start cycle on positive edge
		wait until rising_edge(clk);
		write(txt, now, right, 8);
		write(txt, string'(" wrote "));
		write(txt, data);
		write(txt, string'(" to addr. "));
		write(txt, addr);

		wb_out.dat_o <= std_logic_vector(to_unsigned(data, wb_out.dat_o'length));
		wb_out.adr_o <= std_logic_vector(to_unsigned(addr, wb_out.adr_o'length));

		wb_out.we_o <= '1';
		wb_out.cyc_o <= '1';
		wb_out.stb_o <= '1';

		-- wait for acknowledge
		wait until rising_edge(clk);
		if wb_in.ack_i /= '1' then
			for i in 1 to TIMEOUT loop
				wait until rising_edge(clk);
				exit when wb_in.ack_i = '1';
				if (i = TIMEOUT) then
					write (txt, string'("No acknowledge recevied!"));
				end if;		
			end loop;
		end if;

		wb_out.dat_o <= (others => '0');
		wb_out.adr_o <= (others => '0');
		wb_out.we_o <= '0';
		wb_out.cyc_o <= '0';
		wb_out.stb_o <= '0';

		writeline(output, txt);

	end;

	procedure wb_read(
		signal clk : in std_logic;
		constant addr : in natural;
		variable data : out natural;
		signal wb_in	: in wb_master_in_type;
		signal wb_out : out wb_master_out_type) is

		variable txt : line;
		variable in_data : natural;

	begin

		-- start cycle on positive edge
		wait until rising_edge(clk);
		write(txt, now, right, 8);
		write(txt, string'(" read from addr. "));
		write(txt, addr);
		writeline(output, txt);

		wb_out.adr_o <= std_logic_vector(to_unsigned(addr, wb_out.adr_o'length));
		wb_out.dat_o <= (others => '0');

		wb_out.we_o <= '0';
		wb_out.cyc_o <= '1';
		wb_out.stb_o <= '1';

		-- wait for acknowledge
		wait until rising_edge(clk);
		if wb_in.ack_i /= '1' then
			for i in 1 to TIMEOUT loop
				wait until rising_edge(clk);
				exit when wb_in.ack_i = '1';
				if (i = TIMEOUT) then
					write (txt, string'("No acknowledge recevied!"));
				end if;		
			end loop;
		end if;

		in_data := to_integer(unsigned(wb_in.dat_i));
		data := in_data;

		wb_out.adr_o <= (others => '0');
		wb_out.we_o <= '0';
		wb_out.cyc_o <= '0';
		wb_out.stb_o <= '0';

		write(txt, now, right, 8);
		write(txt, string'(" value: "));
		write(txt, in_data);

		writeline(output, txt);

	end;
	
	procedure wb_confirme_write(
		signal clk 		: in	std_logic;
		constant addr 	: in	natural;
		constant data 	: in	natural;
		signal wb_in	: in	wb_master_in_type;
		signal wb_out	: out	wb_master_out_type) is
	
		variable wb_data_read : natural;
	begin
		
		wb_write(clk, addr, data, wb_in, wb_out);
		
		wb_read(clk, addr, wb_data_read, wb_in, wb_out);
		
		assert wb_data_read = data
			report "not the same written as read"
				severity error;
		
	end;


end wb_pack;