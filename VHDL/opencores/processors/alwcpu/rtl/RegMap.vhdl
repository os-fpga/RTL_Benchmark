------------------------------------------------------------------------------
--
-- Written by: Andreas Hilvarsson, s.p.a.m ¤ opencores.org (www.syntera.se)
--                                 (Replace s.p.a.m with avmcu in email address above)
-- Project...: Alwcpu66
--
-- Purpose:
-- Register map of cpu
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

------------------------------------------------------------------------------
entity reg_map is
	Generic (
		G_have_16_regs		: std_logic := '0' -- Set to '1' for 16 registers and '0' for 8 registers
	);
	Port (
		Clk	: in std_logic;
		Rst	: in std_logic; -- Reset core when Rst='1'
		--
		Dwr		: in std_logic_vector(15 downto 0);	-- Register write bus
		DwrEnK	: in std_logic;							-- Write register according to K mux ptr
		DwrEnM	: in std_logic;							-- Write register according to M mux ptr
		DrdK		: out std_logic_vector(15 downto 0); -- From K mux
		DrdM		: out std_logic_vector(15 downto 0); -- From M mux
		Kmux		: in std_logic_vector(3 downto 0); -- bit 3 ignored in 8 register mode
		Mmux		: in std_logic_vector(3 downto 0); -- bit 3 ignored in 8 register mode
		-- Special flag handling
		Fwr		: in std_logic_vector(15 downto 0); -- Flag write bus, most bits ignored
		FwrEn		: in std_logic;							-- Flag write enable
		Frd		: out std_logic_vector(15 downto 0) -- Flag read bus, most bits ignored
	);
end reg_map;
------------------------------------------------------------------------------
architecture Beh of reg_map is
------------------------------------------------------------------------------
	-- REG
	signal reg_pc : std_logic_vector(15 downto 0);
	signal reg_sp : std_logic_vector(15 downto 0);
	signal reg_st_store : std_logic_vector(3 downto 0); -- Store of status
	signal reg_st_out : std_logic_vector(15 downto 0); -- Output for status register if read
	signal reg_map_r47 : std_logic_vector(1 downto 0); -- Control map for reg 7-4
	signal reg_map_r168 : std_logic_vector(4 downto 4); -- Control map for reg 16-8
	signal reg_map_out : std_logic_vector(15 downto 0); -- Output for map register if read
	signal KmuxOut : std_logic_vector(15 downto 0);
	signal MmuxOut : std_logic_vector(15 downto 0);
	-- WE signals
	signal reg_we	: std_logic_vector(3 downto 0); -- we for reg 16-4 is handled in r74we/r168wea
	signal WEmux	: std_logic_vector(3 downto 0);
	signal tmp_we0	: std_logic;
	constant C_no_reg_we	: std_logic_vector(15 downto 0) := (OTHERS=>'0');
------------------------------------------------------------------------------
	signal r74AdrA		: std_logic_vector(3 downto 0);
	signal r74DataRdA	: std_logic_vector(15 downto 0);
	signal r74WeA		: std_logic;
	signal r74AdrB		: std_logic_vector(3 downto 0);
	signal r74DataRdB	: std_logic_vector(15 downto 0);
	signal r168AdrA		: std_logic_vector(3 downto 0);
	signal r168DataRdA	: std_logic_vector(15 downto 0);
	signal r168WeA			: std_logic;
	signal r168AdrB		: std_logic_vector(3 downto 0);
	signal r168DataRdB	: std_logic_vector(15 downto 0);
------------------------------------------------------------------------------
begin
------------------------------------------------------------------------------
	-- WE mux generation
	--WEsum	<= DwrEnK or DwrEnM; -- If any WE then set WEsum
	WEmux	<= Kmux when (DwrEnK='1') else
				Mmux when (DwrEnM='1') else (OTHERS=>'0');
------------------------------------------------------------------------------
	-- Reg WE generation
	reg_we(0) <= tmp_we0 when (DwrEnK='1' or DwrEnM='1') else '0';
	we16r0: if (G_have_16_regs = '0') generate
		tmp_we0	  <= '1' when WEmux(2 downto 0)="000" else '0';
		reg_we(1)  <= '1' when WEmux(2 downto 0)="001" else '0';
		reg_we(2)  <= '1' when WEmux(2 downto 0)="010" else '0';
		reg_we(3)  <= '1' when WEmux(2 downto 0)="011" else '0';
	end generate we16r0;
	we16r1: if (G_have_16_regs = '1') generate
		tmp_we0	  <= '1' when WEmux="0000" else '0';
		reg_we(1)  <= '1' when WEmux="0001" else '0';
		reg_we(2)  <= '1' when WEmux="0010" else '0';
		reg_we(3)  <= '1' when WEmux="0011" else '0';
	end generate we16r1;
	
------------------------------------------------------------------------------
	-- Reg write
	rwr8proc: process(Clk,Rst)
	begin
		if (Clk'event and Clk='1') then
			if (Rst = '1') then
				reg_pc	<= (OTHERS=>'0');
				reg_sp	<= (OTHERS=>'0');
			else
				if (reg_we(0)='1') then	reg_pc	<= Dwr;	end if;
				if (reg_we(1)='1') then	reg_sp	<= Dwr;	end if;
			end if; -- Rst           
		end if; -- Clk
	end process rwr8proc;
------------------------------------------------------------------------------
	-- Reg STATUS fix
	stwrproc: process(Clk,Rst)
	begin
		if (Clk'event and Clk='1') then
			if (Rst = '1') then
				reg_st_store <= (OTHERS=>'0');
			else
				if (reg_we(2)='1') then
					reg_st_store <= Dwr(reg_st_store'range);
				elsif (FwrEn='1') then
					reg_st_store <= Fwr(reg_st_store'range);
				end if;
			end if; -- Rst
		end if; -- Clk
	end process stwrproc;
	
	stproc: process(reg_st_store)
	begin
		reg_st_out <= (OTHERS=>'0'); -- default
		reg_st_out(reg_st_store'range) <= reg_st_store; -- real flags
		reg_st_out(C_reg_st_LT) <= reg_st_store(C_reg_st_N) xor reg_st_store(C_reg_st_V); -- calc flags
		reg_st_out(C_reg_st_LE) <= reg_st_store(C_reg_st_Z) or (reg_st_store(C_reg_st_N) xor reg_st_store(C_reg_st_V)); -- calc flags
		reg_st_out(C_reg_st_LS) <= reg_st_store(C_reg_st_C) or reg_st_store(C_reg_st_Z); -- calc flags
	end process stproc;

	Frd <= reg_st_out;
------------------------------------------------------------------------------
	-- Reg map handling
	rmwrp: process(Clk, Rst)
	begin
		if (Clk'event and Clk='1') then
			if (Rst = '1') then
				reg_map_r47		<= (OTHERS=>'0');
				reg_map_r168	<= (OTHERS=>'0');
			else
				if (reg_we(3)='1') then
					reg_map_r47		<= Dwr(reg_map_r47'range);
					reg_map_r168	<= Dwr(reg_map_r168'range);
				end if;
			end if; -- Rst
		end if; -- Clk
	end process rmwrp;

	rmproc: process(reg_map_r47, reg_map_r168)
	begin
		reg_map_out <= (OTHERS=>'0'); -- default
		reg_map_out(reg_map_r47'range) <= reg_map_r47;
		reg_map_out(reg_map_r168'range) <= reg_map_r168;
	end process rmproc;
------------------------------------------------------------------------------
	-- Reg output mux
	rr16r0: if (G_have_16_regs = '0') generate
		rrproc8: process(Kmux,Mmux,reg_pc,reg_sp,reg_st_out,reg_map_out,r74DataRdA,r74DataRdB)
		begin
			if (Kmux(2) = '0') then
				case(Kmux(1 downto 0)) is
					when "00" => KmuxOut <= reg_pc;
					when "01" => KmuxOut <= reg_sp;
					when "10" => KmuxOut <= reg_st_out;
					when "11" => KmuxOut <= reg_map_out;
					when others => KmuxOut	<= reg_pc;
				end case; -- Kmux
			else
				KmuxOut <= r74DataRdA;
			end if;
			--
			if (Mmux(2) = '0') then
				case(Mmux(1 downto 0)) is
					when "00" => MmuxOut <= reg_pc;
					when "01" => MmuxOut <= reg_sp;
					when "10" => MmuxOut <= reg_st_out;
					when "11" => MmuxOut <= reg_map_out;
					when others => MmuxOut	<= reg_pc;
				end case; -- Mmux
			else
				MmuxOut <= r74DataRdB;
			end if;
		end process rrproc8;
	end generate rR16r0;
	
	rr16r1: if (G_have_16_regs = '1') generate
		rrproc16: process(Kmux,Mmux,reg_pc,reg_sp,reg_st_out,reg_map_out,r74DataRdA,r74DataRdB,r168DataRdA,r168DataRdB)
		begin
			if (Kmux(3) = '0') then
				if (Kmux(2) = '0') then
					case(Kmux(1 downto 0)) is
						when "00" => KmuxOut <= reg_pc;
						when "01" => KmuxOut <= reg_sp;
						when "10" => KmuxOut <= reg_st_out;
						when "11" => KmuxOut <= reg_map_out;
						when others => KmuxOut	<= reg_pc;
					end case; -- Kmux
				else
					KmuxOut <= r74DataRdA;
				end if;
			else
				KmuxOut <= r168DataRdA;
			end if;
			--
			if (Mmux(3) = '0') then
				if (Mmux(2) = '0') then
					case(Mmux(1 downto 0)) is
						when "00" => MmuxOut <= reg_pc;
						when "01" => MmuxOut <= reg_sp;
						when "10" => MmuxOut <= reg_st_out;
						when "11" => MmuxOut <= reg_map_out;
						when others => MmuxOut	<= reg_pc;
					end case; -- Mmux
				else
					MmuxOut <= r74DataRdB;
				end if;
			else
				MmuxOut <= r168DataRdB;
			end if;
		end process rrproc16;
	end generate rR16r1;
	
	DrdK	<= KmuxOut;
	DrdM	<= MmuxOut;
------------------------------------------------------------------------------
	-- Register map for register 7-4
	r74AdrA		<= (reg_map_r47 & Mmux(1 downto 0)) when (DwrEnM='1') else (reg_map_r47 & Kmux(1 downto 0));
	r74WeA		<= '1' when (WEmux(3 downto 2)="01") else '0'; -- WEmux=0 if no write --((DwrEnK='1' or DwrEnM='1') and 
	r74AdrB		<= reg_map_r47 & Mmux(1 downto 0);

	r74b: DPLRAM Port map (
		Clk		=> Clk,
		-- Port A
		AdrA		=> r74AdrA,
		DataRdA	=> r74DataRdA,
		DataWrA	=> Dwr,
		WeA		=> r74WeA,
		-- Port B
		AdrB		=> r74AdrB,
		DataRdB	=> r74DataRdB
	);

------------------------------------------------------------------------------
	-- Register map for register 16-8
	rm16r0: if (G_have_16_regs = '0') generate
		r168DataRdA	<= (OTHERS=> '0');
		r168DataRdB	<= (OTHERS=> '0');
	end generate rm16r0;

	rm16r1: if (G_have_16_regs = '1') generate
		r168AdrA		<= (reg_map_r168 & Mmux(2 downto 0)) when (DwrEnM='1') else (reg_map_r168 & Kmux(2 downto 0));
		r168WeA		<= '1' when (WEmux(3)='1') else '0'; -- WEmux=0 if no write --((DwrEnK='1' or DwrEnM='1') and 
		r168AdrB		<= reg_map_r168 & Mmux(2 downto 0);

		r168b: DPLRAM Port map (
			Clk		=> Clk,
			-- Port A
			AdrA		=> r168AdrA,
			DataRdA	=> r168DataRdA,
			DataWrA	=> Dwr,
			WeA		=> r168WeA,
			-- Port B
			AdrB		=> r168AdrB,
			DataRdB	=> r168DataRdB
		);
	end generate rm16r1;

------------------------------------------------------------------------------
end architecture Beh;
------------------------------------------------------------------------------
