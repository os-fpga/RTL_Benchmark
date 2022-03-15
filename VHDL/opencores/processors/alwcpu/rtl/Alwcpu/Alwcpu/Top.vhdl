------------------------------------------------------------------------------
--
-- Written by: Andreas Hilvarsson, s.p.a.m ¤ opencores.org (www.syntera.se)
--                                 (Replace s.p.a.m with avmcu in email address above)
-- Project...: Alwcpu66
--
-- Purpose:
-- Top of cpu
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
entity cpu is
	Generic (
		G_have_shift_instr	: std_logic := '0'; -- Set to '1' for shift instructions, '0' to skip shift instructions
		G_have_16_regs			: std_logic := '0' -- Set to '1' for 16 registers and '0' for 8 registers
	);
	Port (
		CLK_I	: in std_logic;
		RST_I	: in std_logic; -- Reset core when Rst='1'
		-- WB interface
		CYC_O	: out std_logic;
		STB_O	: out std_logic;
		SEL_O	: out std_logic;
		WE_O	: out std_logic;
		ACK_I	: in std_logic;
		ADR_O	: out std_logic_vector(15 downto 0);
		DAT_O	: out std_logic_vector(15 downto 0);
		DAT_I	: in std_logic_vector(15 downto 0)
	);
end cpu;
------------------------------------------------------------------------------
architecture Beh of cpu is
------------------------------------------------------------------------------
	--
	signal Clk	: std_logic;
	signal Rst	: std_logic;
	-- WB internal signals
	signal WB_Adr		: std_logic_vector(15 downto 0);
	signal WB_Stb	: std_logic;
	signal WB_We	: std_logic;
	signal WB_Ack	: std_logic;
	-- Hold registers
	signal Instr	: std_logic_vector(15 downto 0);
	signal DH		: std_logic_vector(7 downto 0);
	signal LoadInstr		: std_logic;
	signal LoadDH			: std_logic;
	signal SignExtendDH	: std_logic;
	-- Alias
	signal Imm		: std_logic_vector(15 downto 0);
	-- Mux and control signals
	signal RegWeD		: std_logic_vector(15 downto 0);
	signal RegKrdD		: std_logic_vector(15 downto 0);
	signal RegMrdD		: std_logic_vector(15 downto 0);
	signal RegKWE		: std_logic;
	signal RegMWE		: std_logic;
	signal KmuxCtrl	: std_logic_vector(3 downto 0);
	signal MmuxCtrl	: std_logic_vector(3 downto 0);
	signal AKmuxCtrl	: std_logic_vector(1 downto 0);
	signal AMmuxCtrl	: std_logic_vector(1 downto 0);
	signal BitGenBit	: std_logic_vector(3 downto 0);
	signal BitGenInv	: std_logic;
	signal BitGenD		: std_logic_vector(15 downto 0);
	signal AluD			: std_logic_vector(15 downto 0);
	signal Fwr			: std_logic_vector(15 downto 0);
	signal Frd			: std_logic_vector(15 downto 0);
	signal FWE			: std_logic;
	signal UseALU		: std_logic;
	signal ALUctrl		: std_logic_vector(1 downto 0);
	signal ShiftCtrl	: std_logic_vector(2 downto 0);
	signal InMuxCtrl	: std_logic_vector(1 downto 0);
	signal AoutMuxCtrl	: std_logic;
------------------------------------------------------------------------------
begin
------------------------------------------------------------------------------
	-- WB interface
	Clk	<= CLK_I;
	Rst	<= RST_I;
	ADR_O	<= WB_Adr;
	DAT_O	<= RegKrdD;
	CYC_O	<= WB_Stb;
	STB_O	<= wB_Stb;
	SEL_O	<= WB_stb;
	WE_O	<= WB_We;
	
	WB_Ack <= ACK_I;
------------------------------------------------------------------------------
	-- Mux and bitgens
	MBGb: MuxBG
		Port map (
			Clk				=> Clk,
			Rst				=> Rst,
			--
			InMuxCtrl		=> InMuxCtrl,
			DataIn			=> DAT_I,
			Instr				=> Instr,
			Imm				=> Imm,
			AluD				=> AluD,
			RegWeD			=> RegWeD,
			--
			AoutMuxCtrl		=> AoutMuxCtrl,
			RegMrdD			=> RegMrdD,
			WB_Adr			=> WB_Adr,
			--
			BitGenBit		=> BitGenBit,
			BitGenInv		=> BitGenInv,
			BitGenD			=> BitGenD,
			--
			LoadInstr		=> LoadInstr,
			LoadDH			=> LoadDH,
			SignExtendDH	=> SignExtendDH
		);
------------------------------------------------------------------------------
	-- ALU
	ALUb: alu
		Generic map (
			G_have_shift_instr	=> G_have_shift_instr
		)
		Port map (
			-- In data and ctrl
			Kdata			=> RegKrdD,
			Mdata			=> RegMrdD,
			DataIn		=> DAT_I,
			ImmData		=> Imm,
			BitGenData	=> BitGenD,
			UseALU		=> UseALU,
			ALUctrl		=> ALUctrl,
			ShiftCtrl	=> ShiftCtrl,
			AKmux			=> AKmuxCtrl,
			AMmux			=> AMmuxCtrl,
			-- Result
			DataOut		=> AluD,
			FlagIn		=> Frd(3 downto 0),
			FlagOut		=> Fwr(3 downto 0)
		);
		Fwr(15 downto 4) <= (OTHERS=>'0');
------------------------------------------------------------------------------
	-- Register map
	RMb: reg_map
		Generic map (
			G_have_16_regs	=> G_have_16_regs
		)
		Port map (
			Clk	=> Clk,
			Rst	=> Rst,
			--
			Dwr		=> RegWeD,
			DwrEnK	=> RegKWE,
			DwrEnM	=> RegMWE,
			DrdK		=> RegKrdD,
			DrdM		=> RegMrdD,
			Kmux		=> KmuxCtrl,
			Mmux		=> MmuxCtrl,
			-- Special flag handling
			Fwr		=> Fwr,
			FwrEn		=> FWE,
			Frd		=> Frd
		);
------------------------------------------------------------------------------
	-- Controller
	Ctrlb: Ctrl
		Generic map (
			G_have_shift_instr => G_have_shift_instr
		)
		Port map (
			Clk	=> Clk,
			Rst	=> Rst,
			--
			Instr				=> Instr,
			ZeroFlag			=> Fwr(C_reg_st_Z),
			-- Int ctrl
			LoadInstr		=> LoadInstr,
			LoadDH			=> LoadDH,
			SignExtendDH	=> SignExtendDH,
			InMuxCtrl		=> InMuxCtrl,
			AoutMuxCtrl		=> AoutMuxCtrl,
			AKmuxCtrl		=> AKmuxCtrl,
			AMmuxCtrl		=> AMmuxCtrl,
			ALUctrl			=> AluCtrl,
			KmuxCtrl			=> KmuxCtrl,
			MmuxCtrl			=> MmuxCtrl,
			WrKreg			=> RegKWE,
			WrMreg			=> RegMWE,
			BitGenBit		=> BitGenBit,
			BitGenInv		=> BitGenInv,
			ShiftCtrl		=> ShiftCtrl,
			UseALU			=> UseALU,
			UpdateFlags		=> FWE,
			-- WB ctrl
			WB_Ack			=> WB_Ack,
			WB_Stb			=> WB_Stb,
			WB_We				=> WB_We
		);
------------------------------------------------------------------------------
end architecture Beh;
------------------------------------------------------------------------------
