------------------------------------------------------------------------------
--
-- Written by: Andreas Hilvarsson, s.p.a.m ¤ opencores.org (www.syntera.se)
--                                 (Replace s.p.a.m with avmcu in email address above)
-- Project...: Alwcpu66
--
-- Purpose:
-- Dual port LUT ram for register map in cpu
--
------------------------------------------------------------------------------
--    Alwcpu66 - A light weight CPU with 16 address and 16 data bits
--    Copyright (C) 2009  Andreas Hilvarsson
--
--    This library is free software; you can redistribute it and/or
--    modify it under the terms of the GNU Lesser General Public
--    License as published by the Free Software Foundation; either
--    version 2.1 of the License, or (at your option) any later version.
--
--    This library is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
--    Lesser General Public License for more details.
--
--    You should have received a copy of the GNU Lesser General Public
--    License along with this library; if not, write to the Free Software
--    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
--
--    Andreas Hilvarsson reserves the right to distribute this core under
--    other licenses aswell.
------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library Work;
use Work.Global_Constants_Pkg.ALL;

-- pragma translate_off
--library UNISIM;
--use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on

------------------------------------------------------------------------------
entity DPLRAM is
	Port (
		Clk		: in std_logic;
		-- Port A
		AdrA		: in std_logic_vector(3 downto 0);
		DataRdA	: out std_logic_vector(15 downto 0);
		DataWrA	: in std_logic_vector(15 downto 0);
		WeA		: in std_logic;
		-- Port B
		AdrB		: in std_logic_vector(3 downto 0);
		DataRdB	: out std_logic_vector(15 downto 0)
	);
end DPLRAM;
------------------------------------------------------------------------------
architecture Beh of DPLRAM is
------------------------------------------------------------------------------
	component RAM16X1D 
	-- pragma translate_off
	  generic (
	-- RAM initialization ("0" by default) for functional simulation:
			  INIT : bit_vector := X"0000"
		);
	-- pragma translate_on
	  port (
		D    : in std_logic;
			  WE   : in std_logic;
			  WCLK : in std_logic;
			  A0   : in std_logic;
			  A1   : in std_logic;
			  A2   : in std_logic;
			  A3   : in std_logic;
			  DPRA0   : in std_logic;
			  DPRA1   : in std_logic;
			  DPRA2   : in std_logic;
			  DPRA3   : in std_logic;       
			  SPO  : out std_logic;
			  DPO  : out std_logic
		); 
	end component;

------------------------------------------------------------------------------
	-- For easy simulation:
	type dlp_type is array(0 to 15) of std_logic_vector(15 downto 0);
	signal dlp_ram : dlp_type;
------------------------------------------------------------------------------
begin
------------------------------------------------------------------------------
	--attribute INIT: string;
	--attribute INIT of U_RAM16X1D: label is "0000";

	--grm: for i in DataRdA'range generate
	--	RAM16X1D_inst : RAM16X1D
	--	port map (
	--		WCLK => Clk,			-- Port A write clock input
	--		WE => WeA,				-- Port A write enable input
	--		D => DataWrA(i),		-- Port A 1-bit data input
	--		A0 => AdrA(0),			-- Port A address[0] input bit
	--		A1 => AdrA(1),			-- Port A address[1] input bit
	--		A2 => AdrA(2),			-- Port A address[2] input bit
	--		A3 => AdrA(3),			-- Port A address[3] input bit
	--		SPO => DataRdA(i),	-- Port B 1-bit data output
	--		--
	--		DPRA0 => AdrB(0),		-- Port B address[0] input bit
	--		DPRA1 => AdrB(1),		-- Port B address[1] input bit
	--		DPRA2 => AdrB(2),		-- Port B address[2] input bit
	--		DPRA3 => AdrB(3),		-- Port B address[3] input bit
	--		DPO => DataRdB(i)		-- Port A 1-bit data output
	--	);
	--end generate grm;
	
	-- For easy simulation:
	wrp: process (Clk)
	begin
		if (Clk'event and Clk='1') then
			if (WeA='1') then
				dlp_ram(CONV_INTEGER(AdrA)) <= DataWrA;
			end if;
		end if;
	end process wrp;
	DataRdA	<= dlp_ram(CONV_INTEGER(AdrA));
	DataRdB	<= dlp_ram(CONV_INTEGER(AdrB));

------------------------------------------------------------------------------
end architecture Beh;
------------------------------------------------------------------------------
