------------------------------------------------------------------------------
--
-- Written by: Andreas Hilvarsson, s.p.a.m ¤ opencores.org (www.syntera.se)
--                                 (Replace s.p.a.m with avmcu in email address above)
-- Project...: Testbench for Alwcpu66
--
-- Purpose:
-- Top of testbench
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

------------------------------------------------------------------------------
entity TbTop is
	Port (
		OutPort	: out std_logic_vector(15 downto 0)
	);
end TbTop;
------------------------------------------------------------------------------
architecture Beh of TbTop is
------------------------------------------------------------------------------
	component cpu
		Generic (
			G_have_shift_instr	: std_logic := '1'; -- Set to '1' for shift instructions, '0' to skip shift instructions
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
	end component cpu;
------------------------------------------------------------------------------
	signal Clk	: std_logic;
	signal Rst	: std_logic; -- Reset core when Rst='1'
	signal WB_Stb		: std_logic;
	signal WB_We		: std_logic;
	signal WB_Ack		: std_logic;
	signal WB_Adr		: std_logic_vector(15 downto 0);
	signal WB_WrData	: std_logic_vector(15 downto 0);
	signal WB_RdData	: std_logic_vector(15 downto 0);
------------------------------------------------------------------------------
	signal Prom_Cs			: std_logic;
	signal Prom_l			: std_logic_vector(15 downto 0);
	signal Prom_Ack		: std_logic;
	signal Prom_RdData	: std_logic_vector(15 downto 0);
------------------------------------------------------------------------------
	signal OutPort_Cs			: std_logic;
	signal OutPort_l			: std_logic_vector(15 downto 0);
	signal OutPort_Ack		: std_logic;
	signal OutPort_RdData	: std_logic_vector(15 downto 0);
------------------------------------------------------------------------------
	signal Ram_Cs		: std_logic;
	signal Ram_l		: std_logic_vector(15 downto 0);
	signal Ram_Ack		: std_logic;
	signal Ram_RdData	: std_logic_vector(15 downto 0);
	type ram_type is array (0 to 7) of std_logic_vector(15 downto 0);
	signal Ram_Data : ram_type;
------------------------------------------------------------------------------
begin
------------------------------------------------------------------------------
	alwcpu66: cpu
		Port map (
			CLK_I	=> Clk,
			RST_I	=> Rst,
			-- WB interface
			CYC_O	=> OPEN,
			STB_O	=> WB_Stb,
			SEL_O	=> OPEN,
			WE_O	=> WB_We,
			ACK_I	=> WB_Ack,
			ADR_O	=> WB_Adr,
			DAT_O	=> WB_WrData,
			DAT_I	=> WB_RdData
		);
------------------------------------------------------------------------------
	cp : process
	begin
		Clk <= '0';
		wait for 5 ns;
		Clk <= '1';
		wait for 5 ns;
	end process cp;
------------------------------------------------------------------------------
	rp : process
	begin
		Rst <= '1';
		wait for 25 ns;
		Rst <= '0';
		wait; -- forever
	end process rp;
------------------------------------------------------------------------------
	Prom_Cs		<= '1' when ((WB_Adr(15 downto 14) = "00") and (WB_Stb='1')) else '0';
	OutPort_Cs	<= '1' when ((WB_Adr(15 downto 14) = "10") and (WB_Stb='1')) else '0';
	Ram_Cs		<= '1' when ((WB_Adr(15 downto 14) = "11") and (WB_Stb='1')) else '0';
------------------------------------------------------------------------------
	prp : process (WB_Adr)
	begin
		case WB_Adr is
			when X"0000" => Prom_RdData <= X"4400"; -- CLR R4 (ANDi R4,0)
			when X"0001" => Prom_RdData <= X"7522"; -- LDi R5,0x22 (w se=0)
			when X"0002" => Prom_RdData <= X"9303"; -- DHi 0x30
			when X"0003" => Prom_RdData <= X"7680"; -- LDi R6,0x80 (wo se)
			when X"0004" => Prom_RdData <= X"778F"; -- LDi R7,0x8F (w se=1)
			when X"0005" => Prom_RdData <= X"8453"; -- ADD R4,R5
			when X"0006" => Prom_RdData <= X"34FF"; -- ADDi R4,0xFF (-1)
			when X"0007" => Prom_RdData <= X"448F"; -- ANDi R4,0x8F
			when X"0008" => Prom_RdData <= X"5470"; -- ORi R4,0x70
			when X"0009" => Prom_RdData <= X"6488"; -- XORi R4,0x88
			when X"000A" => Prom_RdData <= X"8547"; -- MOV R5,R4
			when X"000B" => Prom_RdData <= X"8456"; -- XOR R4,R5
			when X"000C" => Prom_RdData <= X"7202"; -- LDi STATUS,Z (LDi R2,2)
			when X"000D" => Prom_RdData <= X"9214"; -- IFEQ (IFSET R2,Z)
			when X"000E" => Prom_RdData <= X"3401"; -- ADDi R4,1
			when X"000F" => Prom_RdData <= X"9214"; -- IFEQ (IFSET R2,Z)
			when X"0010" => Prom_RdData <= X"3402"; -- ADDi R4,2
			when X"0011" => Prom_RdData <= X"9215"; -- IFNEQ (IFCLR R2,Z)
			when X"0012" => Prom_RdData <= X"9553"; -- DHi 0x55
			when X"0013" => Prom_RdData <= X"3404"; -- ADDi R4,4
			when X"0014" => Prom_RdData <= X"5201"; -- SET STATUS (ORi R2,Z(1))
			when X"0015" => Prom_RdData <= X"9214"; -- IFNEQ (IFSET R2,Z)
			when X"0016" => Prom_RdData <= X"9113"; -- DHi 0x11
			when X"0017" => Prom_RdData <= X"3408"; -- ADDi R4,8
			when X"0018" => Prom_RdData <= X"44F7"; -- ANDi R4,0XF7 -- Clear bit 3 in R4
			when X"0019" => Prom_RdData <= X"9436"; -- SETBIT R4,3
			when X"001A" => Prom_RdData <= X"9437"; -- CLRBIT R4,3
			when X"001B" => Prom_RdData <= X"8007"; -- NOP (MOV R0,R0)
			when X"001C" => Prom_RdData <= X"8418"; -- ROR R4
			when X"001D" => Prom_RdData <= X"8419"; -- RORC R4
			when X"001E" => Prom_RdData <= X"841A"; -- LSR R4
			when X"001F" => Prom_RdData <= X"64FF"; -- NOT R4 (XORi R4,0xFF (-1))
			when X"0020" => Prom_RdData <= X"841B"; -- ASR R4
			when X"0021" => Prom_RdData <= X"841C"; -- ROL R4
			when X"0022" => Prom_RdData <= X"841D"; -- ROLC R4
			when X"0023" => Prom_RdData <= X"841E"; -- LSL R4
			when X"0024" => Prom_RdData <= X"D4FF"; -- STip R4,0xFF (-1)
			when X"0025" => Prom_RdData <= X"D0FE"; -- STip R0,0xFE (-2) (Please note: Stores "NEXT" PC adr)
			when X"0026" => Prom_RdData <= X"C5FF"; -- LDip R5,0xFF (-1)
			when X"0027" => Prom_RdData <= X"C6FE"; -- LDip R6,0xFE (-2)
			when X"0028" => Prom_RdData <= X"77FD"; -- LDi R7,0xFD (-3)
			when X"0029" => Prom_RdData <= X"F47F"; -- STp R4,*--R7
			when X"002A" => Prom_RdData <= X"F07F"; -- STp R0,*--R7
			when X"002B" => Prom_RdData <= X"E57E"; -- LDp *R7++,R5
			when X"002C" => Prom_RdData <= X"E67E"; -- LDp *R7++,R6
			when X"002D" => Prom_RdData <= X"71FC"; -- LDi SP,0xFC (-4) (SP=R1)
			when X"002E" => Prom_RdData <= X"1001"; -- CALLRi 1 (skip one instr forward)
			when X"002F" => Prom_RdData <= X"30FF"; -- STOP (ADDi R0,-1)
			when X"0030" => Prom_RdData <= X"3401"; -- ADDi R4,1 (This is a short sub)
			when X"0031" => Prom_RdData <= X"9000"; -- RET
			when X"00FF" => Prom_RdData <= X"0000"; -- ???
			when others => Prom_RdData <= X"FFFF";
		end case;
	end process prp;
	
	Prom_Ack <= Prom_Cs;
	pap : process(Clk, Rst)
	begin
		if (Clk'event and Clk='1') then
			if (Rst='1') then
				NULL;
			elsif (Prom_Cs='1' and WB_We='1') then
				REPORT "Can not write flash"
					SEVERITY ERROR;
			end if;
		end if;
	end process pap;
------------------------------------------------------------------------------
	OutPort <= OutPort_l;
	OutPort_RdData <= OutPort_l;
	OutPort_Ack <= OutPort_Cs;
	opp : process(Clk, Rst)
	begin
		if (Clk'event and Clk='1') then
			if (Rst='1') then
				OutPort_l <= (OTHERS=>'0');
			elsif (OutPort_Cs='1' and WB_We='1') then
				OutPort_l <= WB_WrData;
			end if;
		end if;
	end process opp;
------------------------------------------------------------------------------
	rrp : process (WB_Adr)
	begin
		Ram_RdData <= Ram_Data(CONV_INTEGER(WB_Adr(2 downto 0)));
	end process rrp;
	
	Ram_Ack <= Ram_Cs;
	rap : process(Clk, Rst)
	begin
		if (Clk'event and Clk='1') then
			if (Rst='1') then
				for i in ram_type'range loop
					Ram_Data(i) <= (OTHERS=>'0');
				end loop;
			elsif (Ram_Cs='1' and WB_We='1') then
				Ram_Data(CONV_INTEGER(WB_Adr(2 downto 0))) <= WB_WrData;
			end if;
		end if;
	end process rap;
------------------------------------------------------------------------------
	WB_Ack <=	Prom_Ack when (Prom_Cs='1') else
					OutPort_Ack when (OutPort_Cs='1') else
					Ram_Ack when (Ram_Cs='1') else '0';
------------------------------------------------------------------------------
	WB_RdData <=	Prom_RdData when (Prom_Cs='1') else
						OutPort_RdData when (OutPort_Cs='1') else
						Ram_RdData when (Ram_Cs='1') else (OTHERS=>'X');
------------------------------------------------------------------------------
end architecture Beh;
------------------------------------------------------------------------------
