------------------------------------------------------------------------------
--
-- Written by: Andreas Hilvarsson, s.p.a.m ¤ opencores.org (www.syntera.se)
--                                 (Replace s.p.a.m with avmcu in email address above)
-- Project...: Alwcpu66
--
-- Purpose:
-- Global package of cpu
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

	
package Global_Constants_Pkg is
------------------------------------------------------------------------------
	component DPLRAM
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
	end component DPLRAM;
------------------------------------------------------------------------------
	component alu
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
	end component alu;
------------------------------------------------------------------------------
	component reg_map
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
	end component reg_map;
------------------------------------------------------------------------------
	component MuxBG
		Port (
			Clk				: in std_logic;
			Rst				: in std_logic;
			--
			InMuxCtrl		: in std_logic_vector(1 downto 0); -- In mux control
			DataIn			: in std_logic_vector(15 downto 0); -- Data from WB interface
			Instr				: out std_logic_vector(15 downto 0); -- Current instruction
			Imm				: out std_logic_vector(15 downto 0); -- Stored Imm value
			AluD				: in std_logic_vector(15 downto 0); -- Data from ALU
			RegWeD			: out std_logic_vector(15 downto 0); -- Data to Register map
			--
			AoutMuxCtrl		: in std_logic;	-- Control of Aout mux
			RegMrdD			: in std_logic_vector(15 downto 0); -- Read data from Mmux
			WB_Adr			: out std_logic_vector(15 downto 0); -- Adress bus to WB interface
			--
			BitGenBit		: in std_logic_vector(3 downto 0); -- Bit select for BitGen
			BitGenInv		: in std_logic;	-- Invert output bits from BitGen
			BitGenD			: out std_logic_vector(15 downto 0); -- Data from BitGen
			--
			LoadInstr		: in std_logic;	-- Load new instruction
			LoadDH			: in std_logic;	-- Load DH
			SignExtendDH	: in std_logic		-- Sign extend DH
		);
	end component MuxBG;
------------------------------------------------------------------------------
	component Ctrl
		Generic (
			G_have_shift_instr	: std_logic := '0' -- Set to '1' for shift instructions, '0' to skip shift instructions
		);
		Port (
			Clk	: in std_logic;
			Rst	: in std_logic; -- Reset core when Rst='1'
			--
			Instr			: in std_logic_vector(15 downto 0);	-- Current instruction
			ZeroFlag		: in std_logic;
			-- Int ctrl
			LoadInstr		: out std_logic;
			LoadDH			: out std_logic;
			SignExtendDH	: out std_logic;
			InMuxCtrl		: out std_logic_vector(1 downto 0);
			AoutMuxCtrl		: out std_logic;
			AKmuxCtrl		: out std_logic_vector(1 downto 0);
			AMmuxCtrl		: out std_logic_vector(1 downto 0);
			ALUctrl			: out std_logic_vector(1 downto 0);
			KmuxCtrl			: out std_logic_vector(3 downto 0);
			MmuxCtrl			: out std_logic_vector(3 downto 0);
			WrKreg			: out std_logic;
			WrMreg			: out std_logic;
			BitGenBit		: out std_logic_vector(3 downto 0);
			BitGenInv		: out std_logic;
			ShiftCtrl		: out std_logic_vector(2 downto 0);
			UseALU			: out std_logic;
			UpdateFlags		: out std_logic;
			-- WB ctrl
			WB_Ack			: in std_logic;
			WB_Stb			: out std_logic;
			WB_We				: out std_logic
		);
	end component Ctrl;
------------------------------------------------------------------------------
	-- ST flags
	constant C_reg_st_N	: natural := 0;  -- Neg (MI och PL_N)
	constant C_reg_st_Z	: natural := 1;  -- Zero (EQ och NE_N)
	constant C_reg_st_C	: natural := 2;  -- Carry/Borrow (LO och HS_N)
	constant C_reg_st_V	: natural := 3;  -- Signed Overflow (VS och VC_N)
	constant C_reg_st_LT	: natural := 8;  -- N xor V (LT och GE_N)
	constant C_reg_st_LE	: natural := 9;  -- Z or (N xor V) (LE och GT_N)
	constant C_reg_st_LS	: natural := 10; -- C or Z (LS och HI_N)
	-- Instruction Load
	constant C_LoadInstr_Now	: std_logic := '1';
	constant C_LoadInstr_Wait	: std_logic := '0';
	-- DH Load
	constant C_LoadDH_Now		: std_logic := '1';
	constant C_LoadDH_Wait		: std_logic := '0';
	constant C_SignExtendDH_Now			: std_logic := '1';
	constant C_SignExtendDH_Wait			: std_logic := '0';
	-- InMux control
	constant C_InMux_ALU			: std_logic_vector(1 downto 0) := "00";
	constant C_InMux_Imm			: std_logic_vector(1 downto 0) := "10";
	constant C_InMux_Din			: std_logic_vector(1 downto 0) := "11";
	-- AoutMux control
	constant C_AoutMux_Mmux		: std_logic := '0';
	constant C_AoutMux_Imm		: std_logic := '1';
	-- K and M mux constants
	constant C_KMmux_PC	: std_logic_vector(3 downto 0) := "0000";
	constant C_KMmux_SP	: std_logic_vector(3 downto 0) := "0001";
	-- AK and AM mux control
	constant C_AKmux_Reg	: std_logic_vector(1 downto 0) := "00";
	constant C_AKmux_1	: std_logic_vector(1 downto 0) := "01";
	constant C_AKmux_0	: std_logic_vector(1 downto 0) := "10";
	constant C_AKmux_m1	: std_logic_vector(1 downto 0) := "11";
	constant C_AMmux_Reg	: std_logic_vector(1 downto 0) := "00";
	constant C_AMmux_BG	: std_logic_vector(1 downto 0) := "01";
	constant C_AMmux_Imm	: std_logic_vector(1 downto 0) := "10";
	constant C_AMmux_Din	: std_logic_vector(1 downto 0) := "11";
	-- ALU/Shift select (UseALU signal)
	constant C_UseALU		: std_logic := '1';
	constant C_UseShift	: std_logic := '0';
	-- ALU ctrl
	constant C_ALUctrl_AND		: std_logic_vector(1 downto 0) := "00";
	constant C_ALUctrl_OR		: std_logic_vector(1 downto 0) := "01";
	constant C_ALUctrl_XOR		: std_logic_vector(1 downto 0) := "10";
	constant C_ALUctrl_ADD		: std_logic_vector(1 downto 0) := "11";
	-- Shift ctrls
	constant C_SHctrl_ROR 		: std_logic_vector(2 downto 0) := "000";
	constant C_SHctrl_RORC		: std_logic_vector(2 downto 0) := "001";
	constant C_SHctrl_LSR 		: std_logic_vector(2 downto 0) := "010";
	constant C_SHctrl_ASR 		: std_logic_vector(2 downto 0) := "011";
	constant C_SHctrl_ROL 		: std_logic_vector(2 downto 0) := "100";
	constant C_SHctrl_ROLC		: std_logic_vector(2 downto 0) := "101";
	constant C_SHctrl_LSL 		: std_logic_vector(2 downto 0) := "110";
	constant C_SHctrl_ASL		: std_logic_vector(2 downto 0) := "111";

------------------------------------------------------------------------------
end package Global_Constants_Pkg;