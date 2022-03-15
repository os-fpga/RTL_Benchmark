------------------------------------------------------------------------------
--
-- Written by: Andreas Hilvarsson, s.p.a.m ¤ opencores.org (www.syntera.se)
--                                 (Replace s.p.a.m with avmcu in email address above)
-- Project...: Alwcpu66
--
-- Purpose:
-- Alu of cpu
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
entity alu is
	Generic (
		G_have_shift_instr	: std_logic := '0' -- Set to '1' for shift instructions, '0' to skip shift instructions
	);
	Port (
		-- In data and ctrl
		Kdata			: in std_logic_vector(15 downto 0);
		Mdata			: in std_logic_vector(15 downto 0);
		DataIn		: in std_logic_vector(15 downto 0);
		ImmData		: in std_logic_vector(15 downto 0);
		BitGenData	: in std_logic_vector(15 downto 0);
		UseALU		: in std_logic;
		ALUctrl		: in std_logic_vector(1 downto 0);
		ShiftCtrl	: in std_logic_vector(2 downto 0);
		AKmux			: in std_logic_vector(1 downto 0);
		AMmux			: in std_logic_vector(1 downto 0);
		-- Result
		DataOut		: out std_logic_vector(15 downto 0);
		FlagIn		: in std_logic_vector(3 downto 0);
		FlagOut		: out std_logic_vector(3 downto 0)
	);
end alu;
------------------------------------------------------------------------------
architecture Beh of alu is
------------------------------------------------------------------------------
	-- Mux signals
	signal AKmuxD	: std_logic_vector(15 downto 0);
	signal AMmuxD	: std_logic_vector(15 downto 0);
	
	-- Result signals
	signal ALUsum		: std_logic_vector(15 downto 0);
	signal SHIFTsum	: std_logic_vector(15 downto 0);
	signal TOTsum		: std_logic_vector(15 downto 0);
	signal ALUflags	: std_logic_vector(3 downto 0);
	signal ShFlags		: std_logic_vector(3 downto 0);
------------------------------------------------------------------------------
begin
------------------------------------------------------------------------------
	-- AK mux
	akmdp: process(AKmux, Kdata)
	begin
		case(AKmux) is
			when C_AKmux_Reg	=>	AKmuxD <= Kdata;
			when C_AKmux_1		=>	AKmuxD <= (0=>'1',OTHERS=>'0');
			when C_AKmux_0		=>	AKmuxD <= (OTHERS=>'0');
			when C_AKmux_m1	=>	AKmuxD <= (OTHERS=>'1');
			when others			=>	AKmuxD <= (OTHERS=>'1');
		end case;
	end process akmdp;

	-- AM mux
	ammdp: process(AMmux, Mdata, BitGenData, ImmData, DataIn)
	begin
		case(AMmux) is
			when C_AMmux_Reg	=>	AMmuxD <= Mdata;
			when C_AMmux_BG	=>	AMmuxD <= BitGenData;
			when C_AMmux_Imm	=>	AMmuxD <= ImmData;
			when C_AMmux_Din	=>	AMmuxD <= DataIn;
			when others			=>	AMmuxD <= DataIn;
		end case;
	end process ammdp;
------------------------------------------------------------------------------
	-- ALU operation
	--constant C_ALUctrl_AND		: std_logic_vector(1 downto 0) := "00";
	--constant C_ALUctrl_OR			: std_logic_vector(1 downto 0) := "01";
	--constant C_ALUctrl_XOR		: std_logic_vector(1 downto 0) := "10";
	--constant C_ALUctrl_ADD		: std_logic_vector(1 downto 0) := "11";
	
	asp: process(ALUctrl, AKmuxD, AMmuxD)
		variable lsum : std_logic_vector(15 downto 0);
		variable asum : std_logic_vector(15 downto 0);
	begin
		if (ALUctrl(1) = '1') then -- xor ((add)
			lsum := AKmuxD xor AMmuxD;
		elsif (ALUctrl(0) = '1') then -- or
			lsum := AKmuxD or AMmuxD;
		else                         -- and
			lsum := AKmuxD and AMmuxD;
		end if;
		--
		asum := AKmuxD + AMmuxD; -- add
		--
		if (ALUctrl="11") then
			ALUsum <= asum;
		else
			ALUsum <= lsum;
		end if;
	end process asp;

	-- Fix ALU flags
	ALUFlags(C_reg_st_N)	<= '1' when (ALUsum(15)='1') else '0';
	ALUFlags(C_reg_st_Z)	<= '1' when (ALUsum=X"0000") else '0';
	ALUFlags(C_reg_st_C)	<=	(AKmuxD(15) and AMmuxD(15)) or 
									(AKmuxD(15) and (not ALUsum(15))) or
									(AMmuxD(15) and (not ALUsum(15)));
	ALUFlags(C_reg_st_V)	<=	(AKmuxD(15) and AMmuxD(15) and (not ALUsum(15))) or
									((not AKmuxD(15)) and (not AMmuxD(15)) and ALUsum(15));
------------------------------------------------------------------------------
	--	Shift operation
	nso: if (G_have_shift_instr='0') generate
		ShFlags <= (OTHERS=>'0');
		SHIFTsum <= (OTHERS=>'0');
	end generate nso;
	
	eso: if (G_have_shift_instr='1') generate
		ssp: process(SHIFTctrl, AKmuxD, FlagIn)
		begin
			ShFlags <= (OTHERS=>'0');
			case (SHIFTctrl) is
				-- Shift right
				when C_SHctrl_ROR 	=> SHIFTsum <= AKmuxD(0)				& AKmuxD(15 downto 1); ShFlags(C_reg_st_C) <= AKmuxD(0);
				when C_SHctrl_RORC	=> SHIFTsum <= FlagIn(C_reg_st_C)	& AKmuxD(15 downto 1); ShFlags(C_reg_st_C) <= AKmuxD(0);
				when C_SHctrl_LSR 	=> SHIFTsum <= '0'						& AKmuxD(15 downto 1); ShFlags(C_reg_st_C) <= AKmuxD(0);
				when C_SHctrl_ASR 	=> SHIFTsum <= AKmuxD(15)				& AKmuxD(15 downto 1); ShFlags(C_reg_st_C) <= AKmuxD(0);
				-- Shift left
				when C_SHctrl_ROL 	=> SHIFTsum <= AKmuxD(14 downto 0)	& AKmuxD(15);				ShFlags(C_reg_st_C) <= AKmuxD(15);
				when C_SHctrl_ROLC	=> SHIFTsum <= AKmuxD(14 downto 0)	& FlagIn(C_reg_st_C);	ShFlags(C_reg_st_C) <= AKmuxD(15);
				when C_SHctrl_LSL 	=> SHIFTsum <= AKmuxD(14 downto 0)	& '0';						ShFlags(C_reg_st_C) <= AKmuxD(15);
				when C_SHctrl_ASL		=> SHIFTsum <= AKmuxD(14 downto 0)	& '0';						ShFlags(C_reg_st_C) <= AKmuxD(15);
				when others				=> SHIFTsum <= AKmuxD(14 downto 0)	& '0';						ShFlags(C_reg_st_C) <= AKmuxD(15);
			end case;
		end process ssp;
	end generate eso;
------------------------------------------------------------------------------
	-- Select operation to use
	nsg: if (G_have_shift_instr='0') generate
		TOTsum	<= ALUsum;
		FlagOut	<= ALUFlags;
	end generate nsg;

	esg: if (G_have_shift_instr='1') generate
		TOTsum	<= ALUsum when (UseALU='1') else SHIFTsum;
		FlagOut	<= ALUFlags when (UseALU='1') else ShFlags;
	end generate esg;
	
	DataOut	<= TOTsum;
------------------------------------------------------------------------------
end architecture Beh;
------------------------------------------------------------------------------
