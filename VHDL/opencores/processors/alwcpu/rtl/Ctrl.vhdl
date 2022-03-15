------------------------------------------------------------------------------
--
-- Written by: Andreas Hilvarsson, s.p.a.m ¤ opencores.org (www.syntera.se)
--                                 (Replace s.p.a.m with avmcu in email address above)
-- Project...: Alwcpu66
--
-- Purpose:
-- Controller of cpu
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
entity Ctrl is
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
end Ctrl;
------------------------------------------------------------------------------
architecture Beh of Ctrl is
------------------------------------------------------------------------------
	-- Internal signals
	signal step						: std_logic_vector(4 downto 0);
	signal InstrRunning			: std_logic; -- If Step bit 2-'high is set
	signal nextStep				: std_logic;
	signal nextInstr				: std_logic;
	signal skipNextInstr			: std_logic;
	signal skipNextInstrHold	: std_logic;
	-- Ctrl
	signal Kmux_Force_PC	: std_logic;
	signal Mmux_Force_PC	: std_logic;
	signal Mmux_Force_SP	: std_logic;
	-- Instr alias
	signal Instr_k			: std_logic_vector(11 downto 8);
	signal Instr_m			: std_logic_vector(7 downto 4);
	signal Instr_s			: std_logic_vector(7 downto 4);
	-- DH control
	signal DHloaded		: std_logic;
	-- Instructions
	signal Instr_CALL		: std_logic;
	signal Instr_CALLR	: std_logic;
	signal Instr_ADDi		: std_logic;
	signal Instr_ANDi		: std_logic;
	signal Instr_ORi		: std_logic;
	signal Instr_XORi		: std_logic;
	signal Instr_LDi		: std_logic;
	signal Instr_8ALU		: std_logic;
	signal Instr_8ALUMOV	: std_logic;
	signal Instr_8Shift	: std_logic;
	--signal Instr_9			: std_logic;
	signal Instr_9RET		: std_logic;
	signal Instr_9DH		: std_logic;
	signal Instr_9IFSET	: std_logic;
	signal Instr_9IFCLR	: std_logic;
	signal Instr_9SETBIT	: std_logic;
	signal Instr_9CLRBIT	: std_logic;
	signal Instr_LDp		: std_logic;
	signal Instr_STp		: std_logic;
	signal Instr_LDip		: std_logic;
	signal Instr_STip		: std_logic;
------------------------------------------------------------------------------
begin
------------------------------------------------------------------------------
	Instr_k		<= Instr(Instr_k'range);
	Instr_m		<= Instr(Instr_m'range);
	Instr_s		<= Instr(Instr_s'range);
------------------------------------------------------------------------------
	Instr_CALL		<= '1' when (Instr(15 downto 12)="0000") else '0';
	Instr_CALLR		<= '1' when (Instr(15 downto 12)="0001") else '0';
	Instr_ADDi		<= '1' when (Instr(15 downto 13)="001") else '0'; -- don't care about bit 12
	Instr_ANDi		<= '1' when (Instr(15 downto 12)="0100") else '0';
	Instr_ORi		<= '1' when (Instr(15 downto 12)="0101") else '0';
	Instr_XORi		<= '1' when (Instr(15 downto 12)="0110") else '0';
	Instr_LDi		<= '1' when (Instr(15 downto 12)="0111") else '0';
	Instr_8ALU		<= '1' when (Instr(15 downto 14)="10" and Instr(12)='0' and Instr(3)='0') else '0'; -- don't care about bit 13
	Instr_8ALUMOV	<= '1' when (Instr(2 downto 0)="111") else '0'; -- This is only valid if Instr_8ALU is '1'
	--Instr_9			<= '1' when (Instr(15 downto 14)="10" and Instr(12)='1') else '0'; -- don't care about bit 13
	Instr_9RET		<= '1' when (Instr(15 downto 14)="10" and Instr(12)='1' and Instr(2 downto 1)="00") else '0'; -- don't care about bit 13
	Instr_9DH		<= '1' when (Instr(15 downto 14)="10" and Instr(12)='1' and Instr(2 downto 0)="011") else '0'; -- don't care about bit 13
	Instr_9IFSET	<= '1' when (Instr(15 downto 14)="10" and Instr(12)='1' and Instr(2 downto 0)="100") else '0'; -- don't care about bit 13
	Instr_9IFCLR	<= '1' when (Instr(15 downto 14)="10" and Instr(12)='1' and Instr(2 downto 0)="101") else '0'; -- don't care about bit 13
	Instr_9SETBIT	<= '1' when (Instr(15 downto 14)="10" and Instr(12)='1' and Instr(2 downto 0)="110") else '0'; -- don't care about bit 13
	Instr_9CLRBIT	<= '1' when (Instr(15 downto 14)="10" and Instr(12)='1' and Instr(2 downto 0)="111") else '0'; -- don't care about bit 13
	Instr_LDip		<= '1' when (Instr(15 downto 12)="1100") else '0';
	Instr_STip		<= '1' when (Instr(15 downto 12)="1101") else '0';
	Instr_LDp		<= '1' when (Instr(15 downto 12)="1110") else '0';
	Instr_STp		<= '1' when (Instr(15 downto 12)="1111") else '0';

	nsg: if (G_have_shift_instr='0') generate
		Instr_8Shift	<= '0'; -- Skip instructions
	end generate nsg;

	esg: if (G_have_shift_instr='1') generate
		Instr_8Shift	<= '1' when (Instr(15 downto 14)="10" and Instr(12)='0' and Instr(3)='1') else '0'; -- don't care about bit 14
	end generate esg;
------------------------------------------------------------------------------
	-- Step generation
	stepi: process(Clk, Rst)
	begin
		if (Clk'event and Clk='1') then
			if (Rst='1' or nextInstr='1') then
				step <= (0=>'1',OTHERS=>'0');
				InstrRunning <= '0';
			else
				if (nextStep='1') then
					step <= step(step'high-1 downto 0)&'0'; -- Shift up
					if (step(1)='1') then
						InstrRunning <= '1';
					end if;
				end if;
			end if; -- Rst
		end if; -- Clk
	end process stepi;
------------------------------------------------------------------------------
	-- Handle what to do with instruction
	KmuxCtrl		<= C_KMmux_PC when (Kmux_Force_PC='1') else Instr_k;
	MmuxCtrl		<=	C_KMmux_PC when (Mmux_Force_PC='1') else
						C_KMmux_SP when (Mmux_Force_SP='1') else Instr_m;
	BitGenBit	<= Instr_s;
	ShiftCtrl	<= Instr(2 downto 0);

	steph: process(step,WB_Ack,Instr,DHloaded, skipNextInstrHold, Instr_ADDi, Instr_ANDi, Instr_ORi, Instr_XORi, Instr_LDi, Instr_CALL, Instr_CALLR, Instr_8ALU, Instr_8Shift, Instr_8ALUMOV, Instr_9IFSET, Instr_9IFCLR, ZeroFlag, Instr_9SETBIT, Instr_9CLRBIT, Instr_LDp, Instr_STp, Instr_LDip, Instr_STip, Instr_9RET, Instr_9DH)
	begin
		-- Defaults
		LoadInstr		<= C_LoadInstr_Wait;
		LoadDH			<= C_LoadDH_Wait;
		SignExtendDH	<= C_SignExtendDH_Wait;
		InMuxCtrl		<= C_InMux_ALU;
		AoutMuxCtrl		<= C_AoutMux_Mmux;
		AKmuxCtrl		<= C_AKmux_Reg;
		AMmuxCtrl		<= C_AMmux_Reg;
		ALUctrl			<= C_ALUctrl_ADD;
		Kmux_Force_PC	<= '0';
		Mmux_Force_PC	<= '0';
		Mmux_Force_SP	<= '0';
		BitGenInv		<= '0';
		UseALU			<= C_UseALU;
		WrKreg			<= '0';
		WrMreg			<= '0';
		WB_Stb			<= '0';
		WB_We				<= '0';
		nextStep			<= '0';
		nextInstr		<= '0';
		skipNextInstr	<= '0';
		UpdateFlags		<= '0';
		
		---- Step dependent (What should the instructions do...)
		
		-- First the common steps of all instructions
		if (InstrRunning = '0') then
			AoutMuxCtrl		<= C_AoutMux_Mmux;
			Mmux_Force_PC	<= '1';
			InMuxCtrl		<= C_InMux_ALU;
			ALUctrl			<= C_ALUctrl_ADD;
			AKmuxCtrl		<= C_AKmux_1;
		end if;
		
		if (step(0) = '1') then -- Get instruction
			WB_Stb			<= '1'; -- Start PC read
			LoadInstr		<= '1'; -- Load next instruction
			if (WB_Ack='1') then	
				nextStep <= '1';
			end if;
		end if; -- step 0
		
		if (step(1) = '1') then -- Increment PC
			WrMreg			<= '1';
			nextStep			<= '1';
			if (DHloaded = '0') then
				SignExtendDH	<= C_SignExtendDH_Now;
			end if;
			if (skipNextInstrHold = '1') then
				nextInstr	<= '1';
			end if;
		end if; -- step 1
		
		-- Now some specialization
		if (Instr_ADDi='1' or Instr_ANDi='1' or Instr_ORi='1' or Instr_XORi='1' or Instr_LDi='1') then -- XXXi
			if (InstrRunning = '1') then
				InMuxCtrl	<= C_InMux_ALU;
				AKmuxCtrl	<= C_AKmux_Reg;
				if (Instr_LDi='1') then
					AKmuxCtrl	<= C_AKmux_0; -- Add with 0 to get load
				end if;
				AMmuxCtrl	<= C_AMmux_Imm;
				ALUctrl		<= Instr(13 downto 12);
				WrKreg		<= '1';
				nextInstr	<= '1';
				UpdateFlags	<= '1';
			end if;
		end if; -- XXXi
		
		if (Instr_CALL='1' or Instr_CALLR='1') then -- CALLi/CALLRi
			if (InstrRunning = '1') then
				InMuxCtrl		<= C_InMux_ALU;
				ALUctrl			<= C_ALUctrl_ADD;
				Kmux_Force_PC	<= '1';
				Mmux_Force_SP	<= '1';
			end if;

			if (step(2) = '1') then
				AKmuxCtrl	<= C_AKmux_m1;
				AMmuxCtrl	<= C_AMmux_Reg;
				WrMreg		<= '1';
				nextStep		<= '1';
			end if; -- step 2
			
			if (step(3) = '1') then
				AoutMuxCtrl	<= C_AoutMux_Mmux;
				WB_Stb		<= '1';
				WB_We			<= '1';
				if (WB_Ack='1') then
					nextStep		<= '1';
				end if;
			end if; -- step 3
			
			if (step(4) = '1') then
				AKmuxCtrl	<= C_AKmux_Reg;
				if (Instr_CALL='1') then
					AKmuxCtrl	<= C_AKmux_0; -- If not relativ, just add with 0
				end if;
				AMmuxCtrl	<= C_AMmux_Imm;
				WrKreg		<= '1';
				nextInstr	<= '1';
			end if; -- step 4
		end if; -- CALL(R)

		if (Instr_8ALU='1' or Instr_8Shift='1') then -- ALU/SHIFT
			if (InstrRunning = '1') then
				UseALU		<= C_UseALU;
				if (Instr_8Shift='1') then
					UseALU <= C_UseShift;
				end if;
				InMuxCtrl	<= C_InMux_ALU;
				AKmuxCtrl	<= C_AKmux_Reg;
				if (Instr_8ALU='1' and Instr_8ALUMOV='1') then
					AKmuxCtrl	<= C_AKmux_0; -- This is just a move!
				end if;
				AMmuxCtrl	<= C_AMmux_Reg;
				ALUctrl		<= Instr(1 downto 0);
				WrKreg		<= '1';
				nextInstr	<= '1';
				UpdateFlags	<= '1';
			end if;
		end if;
		
		if (Instr_9IFSET='1' or Instr_9IFCLR='1') then -- IFSET/IFCLR
			if (InstrRunning = '1') then
				AKmuxCtrl	<= C_AKmux_Reg;
				AMmuxCtrl	<= C_AMmux_BG;
				ALUctrl		<= C_ALUctrl_AND;
				BitGenInv	<= '0';
				if (ZeroFlag='0' and Instr_9IFCLR='1') then -- If set (zero=0) skip next instr
					skipNextInstr <= '1';
				end if;
				if (ZeroFlag='1' and Instr_9IFSET='1') then -- If not set (zero=1) skip next instr
					skipNextInstr <= '1';
				end if;
				nextInstr	<= '1';
			end if;
		end if;
		
		if (Instr_9SETBIT='1' or Instr_9CLRBIT='1') then -- SETBIT/CLRBIT
			if (InstrRunning = '1') then
				InMuxCtrl	<= C_InMux_ALU;
				AKmuxCtrl	<= C_AKmux_Reg;
				AMmuxCtrl	<= C_AMmux_BG;
				ALUctrl		<= C_ALUctrl_OR;
				BitGenInv	<= '0';
				if (Instr_9CLRBIT='1') then
					ALUctrl		<= C_ALUctrl_AND;
					BitGenInv	<= '1';
				end if;
				WrKreg		<= '1';
				nextInstr	<= '1';
			end if;
		end if;
		
		if (Instr_LDp='1' or Instr_STp='1') then -- LDp/STp
			if (InstrRunning = '1') then
				AMmuxCtrl	<= C_AMmux_Reg;
				ALUctrl		<= C_ALUctrl_ADD;
				UseALU		<= C_UseALU;
			end if;
			
			if (step(2) = '1') then
				InMuxCtrl	<= C_InMux_ALU;
				AKmuxCtrl	<= C_AKmux_m1;
				if (Instr(3)='1' and Instr(0)='1') then -- pre decrement
					WrMreg	<= '1';
				end if;
				nextStep		<= '1';
			end if; -- step 2
			
			if (step(3) = '1') then
				InMuxCtrl	<= C_InMux_Din;
				AoutMuxCtrl	<= C_AoutMux_Mmux;
				WB_Stb		<= '1';
				if (Instr_LDp='1') then
					WrKreg	<= '1';
				else
					WB_We		<= '1';
				end if;
				if (WB_Ack='1') then
					nextStep	<= '1';
				end if;
				if (Instr(3)='0' or Instr(0)='1') then -- No post increment
					nextInstr	<= '1';
				end if;
			end if; -- step 3

			if (step(4) = '1') then -- post increment
				InMuxCtrl	<= C_InMux_ALU;
				AKmuxCtrl	<= C_AKmux_1;
				WrMreg		<= '1';
				nextInstr	<= '1';
			end if; -- step 4
		end if;
		
		if (Instr_LDip='1') then -- LDip
			if (InstrRunning = '1') then
				InMuxCtrl	<= C_InMux_Din;
				AoutMuxCtrl	<= C_AoutMux_Imm;
				WrKreg		<= '1';
				WB_Stb		<= '1';
				if (WB_Ack='1') then
					nextInstr	<= '1';
				end if;
			end if;
		end if;
		
		if (Instr_STip='1') then -- STip
			if (InstrRunning = '1') then
				AoutMuxCtrl	<= C_AoutMux_Imm;
				WB_Stb		<= '1';
				WB_We			<= '1';
				if (WB_Ack='1') then
					nextInstr	<= '1';
				end if;
			end if;
		end if;
		
		if (Instr_9RET='1') then -- RET
			if (InstrRunning = '1') then
				AoutMuxCtrl		<= C_AoutMux_Mmux;
				Kmux_Force_PC	<= '1';
				Mmux_Force_SP	<= '1';
				AKmuxCtrl		<= C_AKmux_1;
				AMmuxCtrl		<= C_AMmux_Reg;
				ALUctrl			<= C_ALUctrl_ADD;
				UseALU			<= C_UseALU;
			end if;
			
			if (step(2) = '1') then -- Load last PC
				InMuxCtrl	<= C_InMux_Din;
				WrKreg		<= '1';
				WB_Stb		<= '1';
				if (WB_Ack='1') then
					nextStep		<= '1';
				end if;
			end if; -- step 2
			
			if (step(3) = '1') then -- Increment SP
				InMuxCtrl	<= C_InMux_ALU;
				WrMreg		<= '1';
				nextInstr	<= '1';
			end if; -- step 3
		end if;
		
		if (Instr_9DH='1') then -- DH
			if (InstrRunning = '1') then
				LoadDH		<= C_LoadDH_Now;
				nextInstr	<= '1';
			end if;
		end if;
	end process steph;
------------------------------------------------------------------------------
	-- Handle DH loaded signal
	dhp: process(Clk, Rst)
	begin
		if (Clk'event and Clk='1') then
			if (Rst='1') then
				DHloaded <= '0';
			elsif (nextInstr='1') then
				if (Instr_9DH='1') then
					DHloaded <= '1';
				else
					DHloaded <= '0';
				end if;
			end if; -- Rst
		end if; -- Clk
	end process dhp;
------------------------------------------------------------------------------
	-- Handle skip next instr
	snip: process(Clk, Rst)
	begin
		if (Clk'event and Clk='1') then
			if (Rst='1') then
				skipNextInstrHold <= '0';
			elsif (skipNextInstr='1') then
				skipNextInstrHold <= '1';
			elsif (nextInstr='1' and Instr_9DH='0') then-- Clear if not DH instr
				skipNextInstrHold <= '0';
			end if; -- Rst
		end if; -- Clk
	end process snip;
------------------------------------------------------------------------------
end architecture Beh;
------------------------------------------------------------------------------
