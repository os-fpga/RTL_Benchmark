------------------------------------------------------------------
--	6502 principal module.
--
--	Copyright Ian Chapman October 28 2010
--
--	This file is part of the Lattice 6502 project
--	It is used to compile with Linux ghdl and ispLeaver.
--	email author@kool.kor
--	author	EQU	ichapman
--	kool	EQU	videotron
--	kor	EQU	ca
--
--	To do
--		Detailed test of all instructions.
--
--	*************************************************************
--	Distributed under the GNU Lesser General Public License.    *
--	This can be obtained from www.gnu.org.                      *
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
--	65C02.vhd


---  Purpose to test and exercise my VHLD skills
---- I've decided not to support 65C02 instructions
---- nor BCD arithmetic.
---- I will make it run as fast as I can.  Timing not per a real 6502
---- Lattice EBI has clocked address inputs, so as not to add a cycle
---- 6502 address outputs are not latched.  The data output of the EBI ROM and
---- RAM is not clocked.
---- To maintain speed the 6502 address to ROM/RAM is not clocked and the data
---- returned is not clocked by ROM/RAM.  Structures of form address <= address + "1";
---- cause a race condition.  I had to store the address from the  mux for
---- INC type instructions ie read then write.
----
---- One boob I've just noticed jsr and pha in the 6502 work opposite to 
---- what I expected ie jsr decrements the stack and I inc it.  I guess
---- that was the way my first computer the SDS sigma 2 did it.  I'll keep
---- like that for now in case a bigger stack is needed.  Oh no a sigma 2
---- did not have a stack only L link register.
----
--	I used this to set the hold timing default "-exp parHoldLimit=999"
--	Also path based placement on
--	When generating a Lattice ROM/RAM untick latche outputs and use
--	the *.mem file generated with my asm2rom.pl script.
------------------------------------------------------------------------------------
--			TO Do
--	1	DONE Update all address modes of cmp, cpx and cpy per #mode
--	2	DONE Add rol, ror, asl, lsr,  per inc and dec
--	3	DONE Correct flags in all modes of item 2
--	4	DONE Update the stack instructions, I've it pushing up not down.
--	5	Continue testing
--	6	DONE Get a kernel up to test each and every instruction
--	7	Test all instructions
--	7	Add the 65C02 stuff.  I think the most needed is phx, phy, plx
--		and ply are the most useful.
------------------------------------------------------------------------------------
--	Revision history
--	Dec 3, 2010
--	Interrupts BRK, IRQ and NMI checked out seem okay.
--	Fixed stack to push down pull up.
--	addressing	(zero,x) corrected.
--	CLV error corrected.
--	rol, ror, asl and lsr shift instructions checked and fixed.
--	Nov 17, 2010
--	Corrected BRK, IRQ, NMI and RTI due to error in status byte.
--	Nov 4, 2010
--	Rationalized all flavours of cmp, cpy and cpx.
--	Changed jsr to combine out_dat1 and out_dat2 into out_dat.
--	Changed wr_ctr to wr_fg.
--	This saved 43 slices, 69% of slices are used.
--	Removed many redundant comment lines.
--	******************************************************************
--	Nov 1, 2010
--	Double quotes inside a comment line rejected by ghdl
--	cmp carry not set when equal
--	php not saving flags, had to add a cycle for flags to prop in cycle 0
--
--	******************************************************************************

library IEEE;			--Use standard IEEE libs as recommended by Tristan.
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity P65C02 is

Port (
	clock: in std_logic;
	reset : in std_logic;
	data_wr: out unsigned(7 downto 0);
	data_rd: in unsigned(7 downto 0);
	proc_write:  inout std_logic;
	irq: in std_logic;		--Active 0
	nmi: in std_logic;		--Neg transition.
	address: inout unsigned(15 downto 0)
    );
end P65C02;

architecture P65C02_architecture of P65C02 is
------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
signal reg_pc : unsigned(15 downto 0);
signal add_hold : unsigned(15 downto 0);
signal reg_a  : unsigned(8 downto 0);
signal reg_x, reg_y, reg_s, reg_sp : unsigned(7 downto 0);
signal Instruction_in, dat_in1, dat_in2, dat_out : unsigned(7 downto 0);
signal n_fg, v_fg, b_fg, d_fg, i_fg, z_fg, v_ff, wr_fg : std_logic;
signal cycle_ctr, add_fg : unsigned(3 downto 0);
signal flags_fg : unsigned(1 downto 0);


signal reset_fg, irq_fg, nmi_ff1, nmi_ff2, nmi_req, nmi_fg, start_fg, pc_inc_fg, branch_fg: std_logic;
signal pc_dec_fg, dat2pc_fg : std_logic;
--	End of signal declarations

begin	--architecture
--	=======================================================
read_mem:process (clock, reset)
begin
if reset = '0' then
	dat_in1 <= (others => '0');
	dat_in2 <= (others => '0');
	instruction_in <= (others => '0');

	elsif rising_edge(clock) then
		dat_in2 <= dat_in1;
		dat_in1 <= data_rd;

		if cycle_ctr = x"0" then
--			if (i_fg = '0' and (irq = '0' or nmi_req = '0')) or (reset = '1' and reset_fg = '0') then
			if (i_fg = '0' and irq = '0') or nmi_req = '0' or (reset = '1' and reset_fg = '0') then
				Instruction_in <= x"00";
			else
				Instruction_in <= data_rd;
			end if;
		end if;
end if;
end process read_mem;

--	=======================================================
Prog_ptr:process (clock, reset, pc_dec_fg)
begin
if reset = '0' then
	reg_pc <= x"FFFC";
	elsif rising_edge(clock) then
		if dat2pc_fg = '1' then
			reg_pc(15 downto 8) <= data_rd;
			reg_pc(7 downto 0) <= dat_in1;

--		elsif (cycle_ctr = X"0" and not(irq = '0' or nmi = '0' )) or pc_inc_fg = '1' then
		elsif cycle_ctr = X"0" or pc_inc_fg = '1' then
			reg_pc <= reg_pc + x"0001";

		elsif pc_dec_fg = '1' then
			reg_pc <= reg_pc - x"0001";

--		elsif cycle_ctr = x"0" and irq = '0' and i_fg = '0' then
--			reg_pc <= reg_pc - x"0001";

		elsif branch_fg = '1' then
			reg_pc <= reg_pc + (dat_in1(7) & dat_in1(7) & dat_in1(7) & dat_in1(7) & dat_in1(7) & dat_in1(7) & dat_in1(7) & dat_in1(7) &  dat_in1);
		end if;
end if;
end process Prog_ptr;

addressing:process (reset, proc_write, data_rd, dat_in1, dat_in2, reg_x, reg_y, reg_sp, add_hold, reg_PC, add_fg)
begin

if reset = '0' then
address <= reg_pc;
	else
		Case add_fg is
		when x"0" =>
			address <= reg_pc;
		when x"1" =>			--Zero page
			if proc_write = '0' then
				address(7 downto 0) <= data_rd;
			else
				address(7 downto 0) <= dat_in1;
			end if;
			address(15 downto 8) <= x"00";
		when x"2" =>			--Zero page, x
			if proc_write = '0' then
				address(7 downto 0) <= data_rd + reg_x;
			else
				address(7 downto 0) <= dat_in1 + reg_x;
			end if;
			address(15 downto 8) <= x"00";

		when x"3" =>			--Zero page, y
			if proc_write = '0' then
				address(7 downto 0) <= data_rd + reg_y;
			else
				address(7 downto 0) <= dat_in1 + reg_y;
			end if;
			address(15 downto 8) <= x"00";
		when x"4" =>			--Absolute Return sub etc
			if proc_write = '0' then
				address <= data_rd & dat_in1;
			else
				address <= dat_in1 & dat_in2;
			end if;
		when x"5" =>			--Absolute, x
			if proc_write = '0' then
				address <= data_rd & dat_in1 + reg_x;
			else
				address <= dat_in1 & dat_in2 + reg_x;
			end if;
		when x"6" =>			--Absolute, y
--			address <= (data_rd & dat_in1) + reg_y;

			if proc_write = '0' then
				address <= data_rd & dat_in1 + reg_y;
			else
				address <= dat_in1 & dat_in2 + reg_y;
			end if;

		when x"7" =>			--Stack pointer
			address <= x"01" & reg_sp;		--msb should be hex 01
		when x"8" =>			--Reset 1st byte
			address <= x"FFFC";
		when x"9" =>			--IRQ and Break 1st byte
			address <= x"FFFE";
		when x"A" =>			--NMI and Break 1st byte
			address <= x"FFFA";
		when x"B" =>			--address + 1
			address <= add_hold + "1";
		when x"C" =>			--(zero),y
			address(7 downto 0) <= dat_in1 + "1";
			address(15 downto 8) <= x"00";
		when x"D" =>			--(zero,x)
			address(7 downto 0) <= dat_in1 + reg_x + "1";
			address(15 downto 8) <= x"00";
		when x"F" =>			--Hold addre	nmi_ff1 <= '0';ss steady for INC etc
			address <= add_hold;
		when others =>
			address <= reg_pc;
	end case;
end if;
end process addressing;

hold_address:process(clock, reset, address)
begin			--hold address bus for inc type instructions.
if reset = '0' then
	add_hold <= (others => '0');
elsif rising_edge(clock) then
	add_hold <= address;
end if;
end process hold_address;

memory_proc_write:process(clock, reset, wr_fg)
begin
if reset = '0' then
	data_wr <= (others => '0');
	proc_write <= '0';

elsif rising_edge(clock) then
	proc_write <= wr_fg;
--	if wr_fg = '1' then
		data_wr <= dat_out;
--	end if;
end if;
end process memory_proc_write;

instruction_decode:process (clock, reset, irq, nmi)
begin
if reset = '0' then
	cycle_ctr <= (others => '0');
	pc_inc_fg <= '0';
	pc_dec_fg <= '0';
	dat2pc_fg <= '0';
	add_fg <= (others => '0');
	branch_fg <= '0';
	flags_fg <= (others => '0');
	wr_fg <= '0';
	reg_a <= (others => '0');
	reg_x <= (others => '0');
	reg_y <= (others => '0');
	reg_sp <= (others => '1');
	n_fg <= '0';
	v_fg <= '0';
	b_fg <= '0';
	d_fg <= '0';
	i_fg <= '1';
	z_fg <= '0';
	reset_fg <= '0';
	start_fg <= '0';
	v_ff <= '0';
	nmi_ff1 <= '1';
	nmi_ff2 <= '1';
	nmi_req <= '1';
	nmi_fg <= '0';
	irq_fg <= '0';
	dat_out <= (others => '0');

elsif rising_edge(clock) then
	reset_fg <= reset;
--	This is to generate a nmi_req from neg transition on nmi input
	nmi_ff1 <= nmi;
	nmi_ff2 <= nmi_ff1;
	if nmi_fg = '0' and nmi_ff2 = '1' and nmi = '0' then
		nmi_req <= '0';
	end if;

--	This section is to get started
		if reset = '1' and reset_fg = '0' then
			start_fg <= '1';
			wr_fg <= '0';
			add_fg <= x"8";		--get start up vectors FFFC FFFD
			cycle_ctr <= x"7";	--Jump into cycle 7 add_fg <= x'8'
--		end if;
	else


	case cycle_ctr is		--cycle counter case
		when x"0" =>

			if  reset_fg = '1' and reset = '1' then

				if flags_fg /= "00" then
					n_fg <= dat_out(7);
					if dat_out = x"00" then
						z_fg <= '1';
					else
						z_fg <= '0';
					end if;
				end if;
				if flags_fg = "10" then
					start_fg <= '0';
					v_fg <= reg_a(7) xnor v_ff;	--Add V_ff true overflow possible
--									--Sub V_ff false underflow possible
				end if;
			flags_fg <= "00";
			end if;

			if irq = '0' and i_fg = '0' then
				irq_fg <= '1';
				pc_dec_fg <= '1';
				cycle_ctr <= cycle_ctr + x"1";
			elsif nmi_req = '0' then
				nmi_fg <= '1';
				pc_dec_fg <= '1';
				cycle_ctr <= cycle_ctr + x"1";
			else

			case data_rd is

--	===========================================================================================
				when x"48" =>			--PHA 1st part accumulator onto stack
					wr_fg <= '1';
					dat_out <= reg_a(7 downto 0);
					pc_dec_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";

				when x"08" =>			--PHP 1st part status onto stack
					pc_dec_fg <= '1';	--php needs extra cycle to propagate flags 
					cycle_ctr <= cycle_ctr + x"1";

				when x"68" =>			--PLA  1st part Pull Accumulator from Stack
					reg_sp <= reg_sp + "1";		--plus
					pc_dec_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";

				when x"28" =>			--PLP 1st part pull old status from stack
					reg_sp <= reg_sp + "1";		--plus
					pc_dec_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";

				when x"18" =>			--CLC clear carry
					reg_a(8) <= '0';
					cycle_ctr <= x"0";

				when x"38" =>			--SEC set carry
					reg_a(8) <= '1';
					cycle_ctr <= x"0";
				when x"58" =>			--CLI  Clear interrupt Disable Bit
					i_fg <= '0';
					cycle_ctr <= x"0";

				when x"78" =>			--SEI  Set interrupt Disable Status
					i_fg <= '1';
					cycle_ctr <= x"0";
				when x"88" =>			--DEY Decrement y reg
					reg_y <= reg_y - "1";
					flags_fg <= "01";
					dat_out <= reg_y - "1";
					cycle_ctr <= x"0";
				when x"98" =>			--TYA transfer Y to A
					reg_a(7 downto 0) <= reg_y;
					flags_fg <= "01";
					dat_out <= reg_y;
					cycle_ctr <= x"0";
				when x"A8" =>			--TAY transfer A to Y
					reg_y <= reg_a(7 downto 0);
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0);
					cycle_ctr <= x"0";
				when x"B8" =>			--CLV clear overflow flag
					v_fg <= '0';
					cycle_ctr <= x"0";
				when x"C8" =>			--INY increment Y reg
					reg_y <= reg_y + x"1";
					flags_fg <= "01";
					dat_out <= reg_y + x"1";
					cycle_ctr <= x"0";
				when x"D8" =>			--CLD Clear decimnal flag
					d_fg <= '0';
					cycle_ctr <= x"0";
				when x"E8" =>			--INX increment X reg
					reg_x <= reg_x + x"1";
					flags_fg <= "01";
					dat_out <= reg_x + x"1";
					cycle_ctr <= x"0";
				when x"F8" =>			--SLD Set decimnal flag
					d_fg <= '1';
					cycle_ctr <= x"0";
				when x"2A" =>			--ROL A Rotate Left one bit 1st part.
					reg_a(8 downto 1) <= reg_a(7 downto 0);
					reg_a(0) <= reg_a(8);
					dat_out(7 downto 1) <= reg_a(6 downto 0);
					dat_out(0) <= reg_a(8);
					flags_fg <= "01";
					cycle_ctr <=  x"0";
				when x"6A" =>			--ROR A Rotateft right one bit 1st part.
					reg_a(7 downto 0) <= reg_a(8 downto 1);
					reg_a(8) <= reg_a(0);
					dat_out <= reg_a(8 downto 1);
					flags_fg <= "01";
					cycle_ctr <=  x"0";
				when x"0A" =>			--ASL A Shift Left one bit 1st part.
					reg_a <= reg_a(7 downto 0) & '0';
					dat_out <= reg_a(6 downto 0) & '0';
					flags_fg <= "01";
					cycle_ctr <=  x"0";
				when x"4A" =>			--LSR A Logical Shift Right one bit 1st part.
					reg_a(7 downto 0) <= '0' & reg_a(7 downto 1);
					reg_a(8) <= reg_a(0);
					dat_out <= '0' & reg_a(7 downto 1);
					flags_fg <= "01";
					cycle_ctr <=  x"0";
				when x"9A" =>			--TXS
					reg_sp <= reg_x;
					cycle_ctr <= x"0";
				when x"AA" =>			--TAX
					reg_x <= reg_a(7 downto 0);
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0);
					cycle_ctr <= x"0";
				when x"8A" =>			--TXA
					reg_a(7 downto 0) <= reg_x;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0);
					cycle_ctr <= x"0";
				when x"BA" =>			--TSX
					reg_x <= reg_sp;
					flags_fg <= "01";
					dat_out <= reg_sp;
					cycle_ctr <= x"0";
				when x"CA" =>			--DEX
					reg_x <= reg_X - X"01";
					flags_fg <= "01";
					dat_out <= reg_x - X"01";
					cycle_ctr <= x"0";
--	=============================================================================================
				when x"F0" =>			--BEQ branch true 1st part.
						cycle_ctr <= cycle_ctr + "1";
				when x"D0" =>			--BNE branch true 1st part.
						cycle_ctr <= cycle_ctr + "1";
				when x"10" =>			--BPL plus true 1st part.
						cycle_ctr <= cycle_ctr + "1";
				when x"30" =>			--BM1 negative true 1st part.
						cycle_ctr <= cycle_ctr + "1";
				when x"50" =>			--BVC overflow false 1st part.
						cycle_ctr <= cycle_ctr + "1";
				when x"70" =>			--BVS overflow true 1st part.
						cycle_ctr <= cycle_ctr + "1";
				when x"90" =>			--BCC carry false 1st part.
						cycle_ctr <= cycle_ctr + "1";
				when x"B0" =>			--BCS carry true 1st part.
						cycle_ctr <= cycle_ctr + "1";

--	=============================================================================================
				when x"A2" =>			--LDX #.  1st partProto imediate instruction
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"A9" =>			--LDA #.  1st part Proto imediate instruction
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"09" =>			--ORA #.  1st part Proto imediate instruction
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"29" =>			--AND #.  1st part Proto imediate instruction
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"49" =>			--EOR #.  1st part Proto imediate instruction
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"69" =>			--ADC #.  1st part Proto imediate instruction
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"A0" =>			--LDY #.  1st part Proto imediate instruction
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"C0" =>			--CPY #.  1st part Proto imediate instruction
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"C9" =>			--CMP #.  1st part Proto imediate instruction
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"E0" =>			--CPX #.  1st part Proto imediate instruction
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"E9" =>			--SBC #.  1st part Proto imediate instruction
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

--	=============================================================================================
				when x"84" =>			--STY zero 1st part proto
					dat_out <= reg_y;
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"85" =>			--STA zero 1st part proto
					dat_out <= reg_a(7 downto 0);
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"86" =>			--STX zero 1st part proto
					dat_out <= reg_x;
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"94" =>			--STY zero, X 1st part proto
					dat_out <= reg_y;
					add_fg <= x"2";
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"95" =>			--STA zero, X 1st part proto
					dat_out <= reg_a(7 downto 0);
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"96" =>			--STX zero, Y 1st part proto
					dat_out <= reg_x;
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

--	===============================================================================================

				when x"A1" =>			--LDA (zero,x) 1st part proto
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + "1";
				when x"B1" =>			--LDA (zero),y 1st part proto
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + "1";

				when x"21" =>			--AND (zero,x) 1st part proto
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + "1";
				when x"31" =>			--AND (zero),y 1st part proto
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + "1";

				when x"41" =>			--EOR (zero,x) 1st part proto
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + "1";
				when x"51" =>			--EOR (zero),y 1st part proto
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + "1";

				when x"01" =>			--OR (zero,x) 1st part proto
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + "1";
				when x"11" =>			--OR (zero),y 1st part proto
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + "1";

				when x"61" =>			--ADC (zero,x) 1st part proto
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + "1";
				when x"71" =>			--ADC (zero),y 1st part proto
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + "1";

				when x"E1" =>			--SBC (zero,x) 1st part proto
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + "1";
				when x"F1" =>			--SBC (zero),y 1st part proto
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + "1";

				when x"C1" =>			--CMP (zero,x) 1st part proto
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + "1";
				when x"D1" =>			--CMP (zero),y 1st part proto
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + "1";

				when x"81" =>			--STA (zero,x) 1st part proto
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + "1";
				when x"91" =>			--STA (zero),y 1st part proto
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + "1";


--	==============================================================================================
				when x"A5" =>			--LDA zero 1st part proto
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"A4" =>			--LDY zero 1st part
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"A6" =>			--LDX zero 1st part
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"B5" =>			--LDA zero,x 1st part
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + x"1";
				when x"B4" =>			--LDY zero,x 1st part
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + x"1";
				when x"B6" =>			--LDX zero,y 1st part
					add_fg <= x"3";
					cycle_ctr <= cycle_ctr + x"1";
				when x"05" =>			--ORA zero 1st part
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"15" =>			--ORA zero,X 1st part
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + x"1";
				when x"24" =>			--BIT zero 1st part
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"25" =>			--AND zero 1st part
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"26" =>			--ROL zero 1st part
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"35" =>			--AND zero,X 1st part
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + x"1";
				when x"36" =>			--ROL zero,X 1st part
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + x"1";
				when x"45" =>			--EOR zero 1st part
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"46" =>			--LSR zero 1st part
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"55" =>			--EOR zero,X 1st part
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + x"1";
--	=========================================================================================
				when x"E6" =>			--INC zero 1st part
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"56" =>			--LSR zero,X 1st part
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + x"1";
				when x"65" =>			--ADC zero 1st part
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"66" =>			--ROR zero 1st part
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"75" =>			--ADC zero,X 1st part
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + x"1";
				when x"76" =>			--ROR zero,X 1st part
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + x"1";
				when x"C4" =>			--CPY zero 1st part
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"C5" =>			--CMP zero 1st part
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"C6" =>			--DEC zero 1st part
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"D5" =>			--CMP zero,X 1st part
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + x"1";
				when x"D6" =>			--DEC zero,X 1st part
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + x"1";
				when x"E4" =>			--CPX zero 1st part
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"E5" =>			--SBC zero 1st part
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"F5" =>			--SBC zero,X 1st part
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + x"1";
				when x"F6" =>			--INC zero,X 1st part
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + x"1";
				when x"06" =>			--ASL zero, 1st part
					add_fg <= x"1";
					cycle_ctr <= cycle_ctr + x"1";
				when x"16" =>			--ASL zero, x 1st part
					add_fg <= x"2";
					cycle_ctr <= cycle_ctr + x"1";
--	==============================================================================
				when x"AD" =>			--LDA abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"BD" =>			--LDA, x abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"B9" =>			--LDA, Y abs 1st part
					cycle_ctr <= cycle_ctr + x"1";

				when x"2D" =>			--AND abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"3D" =>			--AND, x abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"39" =>			--AND, Y abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";

				when x"0D" =>			--ORA abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"1D" =>			--ORA, x abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";

				when x"19" =>			--ORA, Y abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";

				when x"4D" =>			--EOR abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"5D" =>			--EOR, x abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"59" =>			--EOR, Y abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";

				when x"6D" =>			--ADC abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"7D" =>			--ADC, x abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"79" =>			--ADC, Y abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";

				when x"ED" =>			--SBC abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"FD" =>			--SBC, x abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"F9" =>			--SBC, Y abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";

				when x"AE" =>			--LDX abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"BE" =>			--LDX, y abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"AC" =>			--LDY abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"BC" =>			--LDY, x abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"2C" =>			--BIT abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";

				when x"CD" =>			--CMP abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"DD" =>			--CMP, x abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"D9" =>			--CMP, Y abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"EC" =>			--CPX abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"CC" =>			--CPY abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
--.........................................................................................
				when x"8D" =>			--STA abs 1st part.
					dat_out <= reg_a(7 downto 0);
					cycle_ctr <= cycle_ctr + x"1";
				when x"9D" =>			--STA,x abs 1st part.
					dat_out <= reg_a(7 downto 0);
					cycle_ctr <= cycle_ctr + x"1";
				when x"99" =>			--STA, y abs 1st part.
					dat_out <= reg_a(7 downto 0);
					cycle_ctr <= cycle_ctr + x"1";
				when x"8E" =>			--STX abs 1st part.
					dat_out <= reg_x;
					cycle_ctr <= cycle_ctr + x"1";--
				when x"8C" =>			--STY abs 1st part.
					dat_out <= reg_y;
					cycle_ctr <= cycle_ctr + x"1";
--.........................................................................................

				when x"EE" =>			--INC abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"FE" =>			--INC, x abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"CE" =>			--DEC abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"DE" =>			--DEC, x abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"2E" =>			--ROL abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"3E" =>			--ROL, x abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"6E" =>			--ROR abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"7E" =>			--ROR, x abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"4E" =>			--LSR abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"5E" =>			--LSR, x abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"0E" =>			--ASL abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
				when x"1E" =>			--ASL, x abs 1st part.
					cycle_ctr <= cycle_ctr + x"1";
--	............................................................................
--	==============================================================================


				when x"4C" =>			--JMP abs 1st part
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"6C" =>			--JMP indirect 1st part
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"20" =>			--JSR abs 1st part
					cycle_ctr <= cycle_ctr + x"1";
				when x"60" =>			--RTS 1st part
					reg_sp <= reg_sp + "1";		--plus
					add_fg <= x"7";
					cycle_ctr <= cycle_ctr + x"1";
				when x"40" =>			--RTI 1st part pull old status from stack
					reg_sp <= reg_sp + "1";		--plus
					add_fg <= x"7";
					cycle_ctr <= cycle_ctr + x"1";

				when x"00" =>				--Break 1st part cyc 0
					pc_dec_fg <= '1';		--Start up, irq and nmi also use.
					cycle_ctr <= cycle_ctr + x"1";	--this set of logic.

				when others =>
					cycle_ctr <= x"0";

			end case;	--Cycle 0
			end if;	--Initiated by nmi irq detection.


--	End cycle 0	=========================================================


		when x"1" =>
				case Instruction_in is
--	================================================================================================

				when x"48" =>			--PHA 2nd part accumulator onto stack
					pc_dec_fg <= '0';
					add_fg <= x"7";
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";
				when x"08" =>			--PHP 2nd part Status reg onto stack
					wr_fg <= '1';
					pc_dec_fg <= '0';
					dat_out <= n_fg & v_fg & '1' & b_fg & d_fg & i_fg & z_fg & reg_a(8);
					cycle_ctr <= cycle_ctr + x"1";

				when x"68" =>			--PLA 2nd part  Pull Accumulator from Stack
					add_fg <= x"7";
					pc_dec_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";
				when x"28" =>			--PLP 2nd part  Pull Status from Stack
					add_fg <= x"7";
					pc_dec_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";

				when x"F0" =>			--BEQ branch true 2nd part.
					if z_fg = '1' then	--Should work like a nop
						branch_fg <= '1';	--branch true 1st part.
					else
						pc_inc_fg <= '1';
					end if;
						cycle_ctr <= cycle_ctr + x"1";
				when x"D0" =>			--BNE branch true 2nd part.
					if z_fg = '0' then	--Should work like a nop
						branch_fg <= '1';	--branch true 1st part.
					else
						pc_inc_fg <= '1';
					end if;
						cycle_ctr <= cycle_ctr + x"1";
				when x"10" =>			--BPL plus true 2nd part.
					if n_fg = '0' then	--Should work like a nop
						branch_fg <= '1';	--branch true 1st part.
					else
						pc_inc_fg <= '1';
					end if;
						cycle_ctr <= cycle_ctr + x"1";
				when x"30" =>			--BM1 negative true 2nd part.
					if n_fg = '1' then	--Should work like a nop
						branch_fg <= '1';	--branch true 1st part.
					else
						pc_inc_fg <= '1';
					end if;
						cycle_ctr <= cycle_ctr + x"1";
				when x"50" =>			--BVC overflow false 2nd part.
					if v_fg = '0' then	--Should work like a nop
						branch_fg <= '1';	--branch true 1st part.
					else
						pc_inc_fg <= '1';
					end if;
						cycle_ctr <= cycle_ctr + x"1";
				when x"70" =>			--BVS overflow true 2nd part.
					if v_fg = '1' then	--Should work like a nop
						branch_fg <= '1';	--branch true 1st part.
					else
						pc_inc_fg <= '1';
					end if;
						cycle_ctr <= cycle_ctr + x"1";
				when x"90" =>			--BCC carry false 2nd part.
					if reg_a(8) = '0' then	--Should work like a nop
						branch_fg <= '1';	--branch true 1st part.
					else
						pc_inc_fg <= '1';
					end if;
						cycle_ctr <= cycle_ctr + x"1";
				when x"B0" =>			--BCS carry true 2nd part.
					if reg_a(8) = '1' then	--Should work like a nop
						branch_fg <= '1';	--branch true 1st part.
					else
						pc_inc_fg <= '1';
					end if;
						cycle_ctr <= cycle_ctr + x"1";
--	================================================================================================

				when x"A2" =>			--LDX #.  2nd part Proto imediate instruction
					pc_inc_fg <= '0';
					reg_x <= data_rd;
					dat_out <= data_rd;
					cycle_ctr <= x"0";
				when x"A9" =>			--LDA #.  2nd part Proto imediate instruction
					pc_inc_fg <= '0';
					flags_fg <= "01";
					reg_a(7 downto 0) <= data_rd;
					dat_out <= data_rd;
					cycle_ctr <= x"0";
				when x"A0" =>			--LDY #
					pc_inc_fg <= '0';
					flags_fg <= "01";
					reg_y <= data_rd;
					dat_out <= data_rd;
					cycle_ctr <= x"0";
				when x"09" =>			--ORA #
					pc_inc_fg <= '0';
					add_fg <= x"0";
					reg_a(7 downto 0) <= reg_a(7 downto 0) and data_rd;
					dat_out <= reg_a(7 downto 0) and data_rd;
					cycle_ctr <= x"0";
				when x"29" =>			--AND # 2nd part
					pc_inc_fg <= '0';
					flags_fg <= "01";
					reg_a(7 downto 0) <= reg_a(7 downto 0) and data_rd;
					dat_out <= reg_a(7 downto 0) and data_rd;
					cycle_ctr <= x"0";
				when x"49" =>			--EOR #
					pc_inc_fg <= '0';
					flags_fg <= "01";
					reg_a(7 downto 0) <= reg_a(7 downto 0) xor data_rd;
					dat_out <= reg_a(7 downto 0) xor data_rd;
					cycle_ctr <= x"0";
				when x"69" =>			--ADC #
					pc_inc_fg <= '0';
					v_ff <= not reg_a(7) and not data_rd(7);	--Pos+Pos=Overflow possible
					flags_fg <= "10";
					reg_a <= reg_a + ("0" & data_rd) + ("00000000" & reg_a(8));
					dat_out <= reg_a(7 downto 0) + data_rd + ("0000000" & reg_a(8));
					cycle_ctr <= x"0";
				when x"E9" =>			--SBC # 2nd part
					pc_inc_fg <= '0';
					v_ff <= reg_a(7) and data_rd(7);		--Neg-Neg=Underflow possible
					flags_fg <= "10";
					reg_a <= reg_a - ("0" & data_rd) - ("00000000" & reg_a(8));
					dat_out <= reg_a(7 downto 0) - data_rd - ("0000000" & reg_a(8));
					cycle_ctr <= x"0";

				when x"C9" =>			--CMP # 2nd part.
					pc_inc_fg <= '0';
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) - data_rd;
					if reg_a(7 downto 0) >= data_rd then
						reg_a(8) <= '1';
					else
						reg_a(8) <= '0';
					end if;
					cycle_ctr <= x"0";
				when x"E0" =>			--CPX #.
					pc_inc_fg <= '0';
					flags_fg <= "01";
					dat_out <= reg_x - data_rd;
					if reg_x >= data_rd then
						reg_a(8) <= '1';
					else
						reg_a(8) <= '0';
					end if;
					cycle_ctr <= x"0";
				when x"C0" =>			--CPY #.
					pc_inc_fg <= '0';
					flags_fg <= "01";
					dat_out <= reg_y - data_rd;
					if reg_y >= data_rd then
						reg_a(8) <= '1';
					else
						reg_a(8) <= '0';
					end if;
					cycle_ctr <= x"0";

--	===================================================================================================
				when x"84" =>			--STY zero 2nd part proto
					add_fg <= x"1";
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + "1";
				when x"85" =>			--STA zero 2nd part proto
					add_fg <= x"1";
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + "1";
				when x"86" =>			--STX zero 2nd part proto
					add_fg <= x"1";
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + "1";
				when x"94" =>			--STY zero, X 2nd part proto
					add_fg <= x"2";
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + "1";
				when x"95" =>			--STA zero, X 2nd part proto
					add_fg <= x"2";
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + "1";
				when x"96" =>			--STX zero, Y 2nd part proto
					add_fg <= x"3";
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + "1";

--	=================================================================================
				when x"A5" =>			--LDA zero 2nd part proto
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";
				when x"A4" =>			--LDY zero 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";
				when x"A6" =>			--LDX zero 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";
				when x"B5" =>			--LDA zero,X 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";
				when x"B4" =>			--LDY zero,X 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";

				when x"B6" =>			--LDX zero,Y 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";
				when x"05" =>			--ORA zero 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";

				when x"15" =>			--ORA zero,X 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";
				when x"24" =>			--BIT zero 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";

				when x"25" =>			--AND zero 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";

				when x"35" =>			--AND zero,X 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";

				when x"45" =>			--EOR zero,Y 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";

				when x"55" =>			--EOR zero,X 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";

				when x"65" =>			--ADC zero 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";

				when x"75" =>			--ADC zero,X 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";

				when x"C4" =>			--CPY zero 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";

				when x"C5" =>			--CMP zero 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";
				when x"C6" =>			--DEC zero 2nd part
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"D5" =>			--CMP zero,X 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";
				when x"D6" =>			--DEC zero,X 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";

				when x"E4" =>			--CPX zero 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";
				when x"E5" =>			--SBC zero 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";
				when x"F5" =>			--SBC zero,X 2nd part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";
--	===================================================================================
				when x"E6" =>			--INC zero 2nd part
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"F6" =>			--INC zero,X 2nd part
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"46" =>			--LSR zero 2nd part
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"56" =>			--LSR zero,X 2nd part
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";

				when x"66" =>			--ROR zero 2nd part
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"76" =>			--ROR zero,X 2nd part
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"26" =>			--ROL zero 2nd part
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"36" =>			--ROL zero,X 2nd part
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"06" =>			--ASL zero 2nd part
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"16" =>			--ASL zero,X 2nd part
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";


--	==============================================================================
				when x"A1" =>			--LDA (zero,x) 2nd part proto
					add_fg <= x"D";
					cycle_ctr <= cycle_ctr + "1";
				when x"B1" =>			--LDA (zero),y 2nd part proto
					add_fg <= x"C";
					cycle_ctr <= cycle_ctr + "1";

				when x"21" =>			--AND (zero,x) 2nd part proto
					add_fg <= x"D";
					cycle_ctr <= cycle_ctr + "1";
				when x"31" =>			--AND (zero),y 2nd part proto
					add_fg <= x"C";
					cycle_ctr <= cycle_ctr + "1";

				when x"41" =>			--EOR (zero,x) 2nd part proto
					add_fg <= x"D";
					cycle_ctr <= cycle_ctr + "1";
				when x"51" =>			--EOR (zero),y 2nd part proto
					add_fg <= x"C";
					cycle_ctr <= cycle_ctr + "1";

				when x"01" =>			--OR (zero,x) 2nd part proto
					add_fg <= x"D";
					cycle_ctr <= cycle_ctr + "1";
				when x"11" =>			--OR (zero),y 2nd part proto
					add_fg <= x"C";
					cycle_ctr <= cycle_ctr + "1";

				when x"61" =>			--ADC (zero,x) 2nd part proto
					add_fg <= x"D";
					cycle_ctr <= cycle_ctr + "1";
				when x"71" =>			--ADC (zero),y 2nd part proto
					add_fg <= x"C";
					cycle_ctr <= cycle_ctr + "1";

				when x"E1" =>			--SBC (zero,x) 2nd part proto
					add_fg <= x"D";
					cycle_ctr <= cycle_ctr + "1";
				when x"F1" =>			--SBC (zero),y 2nd part proto
					add_fg <= x"C";
					cycle_ctr <= cycle_ctr + "1";

				when x"C1" =>			--CMP (zero,x) 2nd part proto
					add_fg <= x"D";
					cycle_ctr <= cycle_ctr + "1";
				when x"D1" =>			--CMP (zero),y 2nd part proto
					add_fg <= x"C";
					cycle_ctr <= cycle_ctr + "1";

				when x"81" =>			--STA (zero,x) 2nd part proto
					add_fg <= x"D";
					cycle_ctr <= cycle_ctr + "1";
				when x"91" =>			--STA (zero),y 2nd part proto
					add_fg <= x"C";
					cycle_ctr <= cycle_ctr + "1";
--	==============================================================================
				when x"AD" =>			--LDA abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";
				when x"BD" =>			--LDA, x abs 2nd part.
					add_fg <= x"5";
					cycle_ctr <= cycle_ctr + x"1";
				when x"B9" =>			--LDA, Y abs 2nd part.


					add_fg <= x"6";
					cycle_ctr <= cycle_ctr + x"1";


				when x"2D" =>			--AND abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";

				when x"3D" =>			--AND, x abs 2nd part.

					add_fg <= x"5";
					cycle_ctr <= cycle_ctr + x"1";
				when x"39" =>			--AND, Y abs 2nd part.
					add_fg <= x"6";
					cycle_ctr <= cycle_ctr + x"1";

				when x"0D" =>			--ORA abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";
				when x"1D" =>			--ORA, x abs 2nd part.
					add_fg <= x"5";
					cycle_ctr <= cycle_ctr + x"1";
				when x"19" =>			--ORA, Y abs 2nd part.
					add_fg <= x"6";
					cycle_ctr <= cycle_ctr + x"1";

				when x"4D" =>			--EOR abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";
				when x"5D" =>			--EOR, x abs 2nd part.
					add_fg <= x"5";
					cycle_ctr <= cycle_ctr + x"1";
				when x"59" =>			--EOR, Y abs 2nd part.
					add_fg <= x"6";
					cycle_ctr <= cycle_ctr + x"1";

				when x"6D" =>			--ADC abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";
				when x"7D" =>			--ADC, x abs 2nd part.
					add_fg <= x"5";
					cycle_ctr <= cycle_ctr + x"1";
				when x"79" =>			--ADC, Y abs 2nd part.
					add_fg <= x"6";
					cycle_ctr <= cycle_ctr + x"1";

				when x"ED" =>			--SBC abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";
				when x"FD" =>			--SBC, x abs 2nd part.
					add_fg <= x"5";
					cycle_ctr <= cycle_ctr + x"1";
				when x"F9" =>			--SBC, Y abs 2nd part.
					add_fg <= x"6";
					cycle_ctr <= cycle_ctr + x"1";

				when x"AE" =>			--LDX abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";
				when x"BE" =>			--LDX, y abs 2nd part.
					add_fg <= x"6";
					cycle_ctr <= cycle_ctr + x"1";
				when x"AC" =>			--LDY abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";
				when x"BC" =>			--LDY, x abs 2nd part.
					add_fg <= x"5";
					cycle_ctr <= cycle_ctr + x"1";

				when x"2C" =>			--BIT abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";

				when x"CD" =>			--CMP abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";
				when x"DD" =>			--CMP, x abs 2nd part.
					add_fg <= x"5";
					cycle_ctr <= cycle_ctr + x"1";
				when x"D9" =>			--CMP, Y abs 2nd part.
					add_fg <= x"6";
					cycle_ctr <= cycle_ctr + x"1";
				when x"EC" =>			--CPX abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";
				when x"CC" =>			--CPY abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";
--	...............................................................................
				when x"8D" =>			--STA abs 2nd part.
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"9D" =>			--STA,x abs 2nd part.
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"99" =>			--STA, y abs 2nd part.
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"8E" =>			--STX abs 2nd part.
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"8C" =>			--STY abs 2nd part.
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
--	........................................................................

				when x"EE" =>			--INC abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";
				when x"FE" =>			--INC, x abs 2nd part.
					add_fg <= x"5";
					cycle_ctr <= cycle_ctr + x"1";
				when x"CE" =>			--DEC abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";
				when x"DE" =>			--DEC, x abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";
				when x"2E" =>			--ROL abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";
				when x"3E" =>			--ROL, x abs 2nd part.
					add_fg <= x"5";
					cycle_ctr <= cycle_ctr + x"1";
				when x"6E" =>			--ROR abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";
				when x"7E" =>			--ROR, x abs 2nd part.
					add_fg <= x"5";
					cycle_ctr <= cycle_ctr + x"1";
				when x"4E" =>			--LSR abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";
				when x"5E" =>			--LSR, x abs 2nd part.
					add_fg <= x"5";
					cycle_ctr <= cycle_ctr + x"1";
				when x"0E" =>			--ASL abs 2nd part.
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + x"1";
				when x"1E" =>			--ASL, x abs 2nd part.
					add_fg <= x"5";
					cycle_ctr <= cycle_ctr + x"1";
--	............................................................................
--	==============================================================================
				when x"4C" =>			--JMP abs 2nd part
					pc_inc_fg <= '0';
					dat2pc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"6C" =>			--JMP indirect 2nd part
					add_fg <= x"4";
					pc_inc_fg <= '0';
					cycle_ctr <= cycle_ctr + "1";
				when x"20" =>			--JSR abs 2nd part
					dat2pc_fg <= '1';
					wr_fg <= '1';
					dat_out <= reg_pc(15 downto 8);
					cycle_ctr <= cycle_ctr + x"1";

				when x"60" =>			--RTS second part
					reg_sp <= reg_sp + "1";		--plus
					cycle_ctr <= cycle_ctr + x"1";
				when x"40" =>			--RTI second part pull old status from stack
					reg_sp <= reg_sp + "1";		--plus
					cycle_ctr <= cycle_ctr + x"1";

				when x"00" =>					--Break 2nd part cyc 1
					if irq_fg = '0' and nmi_fg = '0' then	--Start up, irq and nmi also use
						pc_dec_fg <= '0';		--this set of logic.
					end if;
					cycle_ctr <= cycle_ctr + x"1";

				when others =>
				cycle_ctr <= cycle_ctr + x"1";
			end case;	--Cycle 1


--	End cycle 1	=========================================================

		when x"2" =>

			case instruction_in(7 downto 0) is
--	====================================================================================

				when x"48" =>			--PHA 3rd part accumulator onto stack
					pc_inc_fg <= '1';
					add_fg <= x"0";
					reg_sp <= reg_sp - "1";		--neg
					cycle_ctr <= cycle_ctr + x"1";
				when x"08" =>			--PHP 3rd part Status reg onto stack
					wr_fg <= '0';
					add_fg <= x"7";
					cycle_ctr <= cycle_ctr + x"1";

				when x"68" =>			--PLA 3rd part  Pull Accumulator from Stack
--					pc_dec_fg <= '0';
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"28" =>			--PLP 3rd part  Pull Status from Stack
--					pc_dec_fg <= '0';
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";

				when x"F0" =>			--BEQ branch true 3rd part.
					if branch_fg = '1' then
						branch_fg <= '0';
						cycle_ctr <= cycle_ctr + x"1";
					else
						pc_inc_fg <= '0';
						cycle_ctr <= x"0";
					end if;
				when x"D0" =>			--BNE branch true 3rd part.
					if branch_fg = '1' then
						branch_fg <= '0';
						cycle_ctr <= cycle_ctr + x"1";
					else
						pc_inc_fg <= '0';
						cycle_ctr <= x"0";
					end if;
				when x"10" =>			--BPL plus true 3rd part.
					if branch_fg = '1' then
						branch_fg <= '0';
						cycle_ctr <= cycle_ctr + x"1";
					else
						pc_inc_fg <= '0';
						cycle_ctr <= x"0";
					end if;
				when x"30" =>			--BM1 negative true 3rd part.
					if branch_fg = '1' then
						branch_fg <= '0';
						cycle_ctr <= cycle_ctr + x"1";
					else
						pc_inc_fg <= '0';
						cycle_ctr <= x"0";
					end if;
				when x"50" =>			--BVC overflow false 3rd part.
					if branch_fg = '1' then
						branch_fg <= '0';
						cycle_ctr <= cycle_ctr + x"1";
					else
						pc_inc_fg <= '0';
						cycle_ctr <= x"0";
					end if;
				when x"70" =>			--BVS overflow true 3rd part.
					if branch_fg = '1' then
						branch_fg <= '0';
						cycle_ctr <= cycle_ctr + x"1";
					else
						pc_inc_fg <= '0';
						cycle_ctr <= x"0";
					end if;
				when x"90" =>			--BCC carry false 3rd part.
					if branch_fg = '1' then
						branch_fg <= '0';
						cycle_ctr <= cycle_ctr + x"1";
					else
						pc_inc_fg <= '0';
						cycle_ctr <= x"0";
					end if;
				when x"B0" =>			--BCS carry true 3rd part.
					if branch_fg = '1' then
						branch_fg <= '0';
						cycle_ctr <= cycle_ctr + x"1";
					else
						pc_inc_fg <= '0';
						cycle_ctr <= x"0";
					end if;

--	====================================================================================
				when x"84" =>			--STY zero 3rd part proto
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"85" =>			--STA zero 3rd part proto
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"86" =>			--STX zero 3rd part proto
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"94" =>			--STY zero, X 3rd part proto
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"95" =>			--STA zero, X 3rd part proto
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"96" =>			--STX zero, Y 3rd part proto
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";

--	========================================================================================
				when x"A5" =>			--LDA zero 3rd part proto
					pc_inc_fg <= '0';
					reg_a(7 downto 0) <= data_rd;
					flags_fg <= "01";
					dat_out <= data_rd;
					cycle_ctr <= x"0";
				when x"A4" =>			--LDY zero 3rd part
					pc_inc_fg <= '0';
					reg_y <= data_rd;
					flags_fg <= "01";
					dat_out <= data_rd;
					cycle_ctr <= x"0";
				when x"A6" =>			--LDX zero 3rd part
					pc_inc_fg <= '0';
					reg_x <= data_rd;
					flags_fg <= "01";
					dat_out <= data_rd;
					cycle_ctr <= x"0";
				when x"B5" =>			--LDA zero,X 3rd part
					pc_inc_fg <= '0';
					reg_a(7 downto 0) <= data_rd;
					flags_fg <= "01";
					dat_out <= data_rd;
					cycle_ctr <= x"0";
				when x"B4" =>			--LDY zero,X 3rd part
					pc_inc_fg <= '0';
					reg_y <= data_rd;
					flags_fg <= "01";
					dat_out <= data_rd;
					cycle_ctr <= x"0";
				when x"B6" =>			--LDX zero,Y 3rd part
					wr_fg <= '0';
					pc_inc_fg <= '0';
					reg_x <= data_rd;
					flags_fg <= "01";
					dat_out <= data_rd;
					cycle_ctr <= x"0";
				when x"05" =>			--ORA zero 3rd part
					pc_inc_fg <= '0';
					reg_a(7 downto 0) <= reg_a(7 downto 0) or data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) or data_rd;
					cycle_ctr <= x"0";
				when x"15" =>			--ORA zero,X 3rd part
					pc_inc_fg <= '0';
					reg_a(7 downto 0) <= reg_a(7 downto 0) or data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) or data_rd;
					cycle_ctr <= x"0";
				when x"24" =>			--BIT zero 3rd part
					pc_inc_fg <= '0';
					n_fg <= data_rd(7);
					v_fg <= data_rd(6);
					dat_out <= reg_a(7 downto 0) and data_rd;
					flags_fg <= "01";
					cycle_ctr <= x"0";
				when x"25" =>			--AND zero 3rd part
					pc_inc_fg <= '0';
					reg_a(7 downto 0) <= reg_a(7 downto 0) and data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) and data_rd;
					cycle_ctr <= x"0";

				when x"35" =>			--AND zero,X 3rd part
					pc_inc_fg <= '0';
					reg_a(7 downto 0) <= reg_a(7 downto 0) and data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) and data_rd;
					cycle_ctr <= x"0";

				when x"45" =>			--EOR zero 3rd part
					pc_inc_fg <= '0';
					reg_a(7 downto 0) <= reg_a(7 downto 0) xor data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) xor data_rd;
					cycle_ctr <= x"0";

				when x"55" =>			--EOR zero,X 3rd part
					pc_inc_fg <= '0';
					reg_a(7 downto 0) <= reg_a(7 downto 0) xor data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) xor data_rd;
					cycle_ctr <= x"0";

				when x"65" =>			--ADC zero 3rd part
					pc_inc_fg <= '0';
					reg_a <= reg_a + ("0" & data_rd) + ("00000000" & reg_a(8));
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) + data_rd + ("0000000" & reg_a(8));
					cycle_ctr <= x"0";

				when x"75" =>			--ADC zero,X 3rd part
					pc_inc_fg <= '0';
					reg_a <= reg_a + ("0" & data_rd) + ("00000000" & reg_a(8));
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) + data_rd + ("0000000" & reg_a(8));
					cycle_ctr <= x"0";

				when x"C4" =>			--CPY zero 3rd part
					flags_fg <= "01";
					dat_out <= reg_y - data_rd;
					if reg_y >= data_rd then
						reg_a(8) <= '1';
					else
						reg_a(8) <= '0';
					end if;
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"C5" =>			--CMP zero 3rd part
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) - data_rd;
					if reg_a(7 downto 0) >= data_rd then
						reg_a(8) <= '1';
					else
						reg_a(8) <= '0';
					end if;
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"C6" =>			--DEC zero 3rd part
					dat_out <= data_rd - x"01";
					dat_out <= data_rd - x"01";
					wr_fg <= '1';
					flags_fg <= "01";
					cycle_ctr <= cycle_ctr + "1";
				when x"D5" =>			--CMP zero,X 3rd part
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) - data_rd;
					if reg_a(7 downto 0) >= data_rd then
						reg_a(8) <= '1';
					else
						reg_a(8) <= '0';
					end if;
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"D6" =>			--DEC zero,X 3rd part
					pc_inc_fg <= '0';
					add_fg <= x"0";
					reg_a(7 downto 0) <= data_rd;
					flags_fg <= "01";
					dat_out <= data_rd;
					cycle_ctr <= cycle_ctr + "1";
				when x"E4" =>			--CPX zero 3rd part
					flags_fg <= "01";
					dat_out <= reg_x - data_rd;
					if reg_X >= data_rd then
						reg_a(8) <= '1';
					else
						reg_a(8) <= '0';
					end if;
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"E5" =>			--SBC zero 3rd part
					pc_inc_fg <= '0';
					reg_a <= reg_a - ("0" & data_rd) - ("00000000" & reg_a(8));
					dat_out <= reg_a(7 downto 0) - data_rd - ("0000000" & reg_a(8));
					flags_fg <= "01";
					cycle_ctr <= x"0";


				when x"F5" =>			--SBC zero,X 3rd part
					pc_inc_fg <= '0';
					reg_a <= reg_a - ('0' & data_rd) - ("00000000" & reg_a(8));
					dat_out <= reg_a(7 downto 0) - data_rd - ("0000000" & reg_a(8));
					flags_fg <= "01";
					cycle_ctr <= x"0";

				when x"E6" =>			--INC zero 3rd part
					dat_out <= data_rd + x"01";
					wr_fg <= '1';
					flags_fg <= "01";
					cycle_ctr <= cycle_ctr + "1";
				when x"F6" =>			--INC zero,X 3rd part
					dat_out <= data_rd + x"01";
					wr_fg <= '1';
					flags_fg <= "01";
					cycle_ctr <= cycle_ctr + "1";

				when x"66" =>			--ROR zero 3rd part
					dat_out(6 downto 0) <= data_rd(7 downto 1);
					dat_out(7) <= reg_a(8);
					reg_a(8) <= data_rd(0);
					flags_fg <= "01";
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"76" =>			--ROR zero,X 3rd part
					dat_out(6 downto 0) <= data_rd(7 downto 1);
					dat_out(7) <= reg_a(8);
					reg_a(8) <= data_rd(0);
					flags_fg <= "01";
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"26" =>			--ROL zero 3rd part
					dat_out(7 downto 0) <= data_rd(6 downto 0) & reg_a(8);
					reg_a(8) <= data_rd(7);
					flags_fg <= "01";
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"36" =>			--ROL zero,X 3rd part
					dat_out(7 downto 0) <= data_rd(6 downto 0) & reg_a(8);
					reg_a(8) <= data_rd(7);
					flags_fg <= "01";
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"46" =>			--LSR zero 3rd part
					dat_out <= '0' & data_rd(7 downto 1);
					reg_a(8) <= data_rd(0);
					flags_fg <= "01";
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"56" =>			--LSR zero,X 3rd part
					dat_out <= '0' & data_rd(7 downto 1);
					reg_a(8) <= data_rd(0);
					flags_fg <= "01";
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"06" =>			--ASL zero 3rd part
					reg_a(8) <= data_rd(7);
					dat_out <= data_rd(6 downto 0) & '0';
					flags_fg <= "01";
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"16" =>			--ASL zero,X 3rd part
					reg_a(8) <= data_rd(7);
					dat_out <= data_rd(6 downto 0) & '0';
					flags_fg <= "01";
					wr_fg <= '1';					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
--	=============================================================================================
				when x"A1" =>			--LDA (zero,x) 3rd part proto
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + "1";
				when x"B1" =>			--LDA (zero),y 3rd part proto
					add_fg <= x"6";
					cycle_ctr <= cycle_ctr + "1";

				when x"21" =>			--AMD (zero,x) 3rd part proto
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + "1";
				when x"31" =>			--AND (zero),y 3rd part proto
					add_fg <= x"6";
					cycle_ctr <= cycle_ctr + "1";

				when x"41" =>			--EOR (zero,x) 3rd part proto
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + "1";
				when x"51" =>			--EOR (zero),y 3rd part proto
					add_fg <= x"6";
					cycle_ctr <= cycle_ctr + "1";

				when x"01" =>			--OR (zero,x) 3rd part proto
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + "1";
				when x"11" =>			--OR (zero),y 3rd part proto
					add_fg <= x"6";
					cycle_ctr <= cycle_ctr + "1";

				when x"61" =>			--ADC (zero,x) 3rd part proto
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + "1";
				when x"71" =>			--ADC (zero),y 3rd part proto
					add_fg <= x"6";
					cycle_ctr <= cycle_ctr + "1";

				when x"E1" =>			--SBC (zero,x) 3rd part proto
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + "1";
				when x"F1" =>			--SBC (zero),y 3rd part proto
					add_fg <= x"6";
					cycle_ctr <= cycle_ctr + "1";

				when x"C1" =>			--CMP (zero,x) 3rd part proto
					add_fg <= x"4";
					cycle_ctr <= cycle_ctr + "1";
				when x"D1" =>			--CMP (zero),y 3rd part proto
					add_fg <= x"6";
					cycle_ctr <= cycle_ctr + "1";

				when x"81" =>			--STA (zero,x) 3rd part proto
					add_fg <= x"4";
					wr_fg <= '1';
					dat_out <= reg_a(7 downto 0);
					cycle_ctr <= cycle_ctr + "1";
				when x"91" =>			--STA (zero),y 3rd part proto
					add_fg <= x"6";
					wr_fg <= '1';
					dat_out <= reg_a(7 downto 0);
					cycle_ctr <= cycle_ctr + "1";
--	==============================================================================
				when x"AD" =>			--LDA abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"BD" =>			--LDA, x abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"B9" =>			--LDA, Y abs 3rd part
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";


				when x"2D" =>			--AND abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"3D" =>			--AND, x abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"39" =>			--AND, Y abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"0D" =>			--ORA abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"1D" =>			--ORA, x abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"19" =>			--ORA, Y abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"4D" =>			--EOR abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"5D" =>			--EOR, x abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"59" =>			--EOR, Y abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"6D" =>			--ADC abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"7D" =>			--ADC, x abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"79" =>			--ADC, Y abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"ED" =>			--SBC abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"FD" =>			--SBC, x abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"F9" =>			--SBC, Y abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"AE" =>			--LDX abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"BE" =>			--LDX, y abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"AC" =>			--LDY abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"BC" =>			--LDY, x abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"2C" =>			--BIT abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"CD" =>			--CMP abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"DD" =>			--CMP, x abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"D9" =>			--CMP, Y abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"EC" =>			--CPX abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"CC" =>			--CPY abs 3rd part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

--	................................................................................
				when x"8D" =>			--STA abs 3rd part.
					wr_fg <= '0';
					add_fg <= x"4";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"9D" =>			--STA,x abs 3rd part.
					wr_fg <= '0';
					add_fg <= x"5";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"99" =>			--STA, y abs 3rd part.
					wr_fg <= '0';
					add_fg <= x"6";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"8E" =>			--STX abs 3rd part.
					wr_fg <= '0';
					add_fg <= x"4";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"8C" =>			--STY abs 3rd part.
					wr_fg <= '0';
					add_fg <= x"4";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
--	................................................................................

				when x"EE" =>			--INC abs 3rd part.
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"FE" =>			--INC, x abs 3rd part.
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"CE" =>			--DEC abs 3rd part.
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"DE" =>			--DEC, x abs 3rd part.
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"2E" =>			--ROL abs 3rd part.
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"3E" =>			--ROL, x abs 3rd part.
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"6E" =>			--ROR abs 3rd part.
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"7E" =>			--ROR, x abs 3rd part.
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"4E" =>			--LSR abs 3rd part.
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"5E" =>			--LSR, x abs 3rd part.
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"0E" =>			--ASL abs 3rd part.
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
				when x"1E" =>			--ASL, x abs 3rd part.
					add_fg <= x"f";
					cycle_ctr <= cycle_ctr + "1";
--	............................................................................
--	==============================================================================
				when x"4C"  =>			--JMP abs 3rd part
					dat2pc_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";
				when x"6C" =>			--JMP indirect 3rd part
					add_fg <= x"B";
					cycle_ctr <= cycle_ctr + x"1";
				when x"20" =>			--JSR abs 3rd part
					dat2pc_fg <= '0';
					add_fg <= x"7";
					wr_fg <= '1';
					dat_out <= reg_pc(7 downto 0);
					cycle_ctr <= cycle_ctr + x"1";
				when x"60" =>			--RTS 3rd part
					dat2pc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"40" =>		--RTI 3rd part pull old status from stack
					pc_dec_fg <= '0';	--Get 1st PC byte
					n_fg <= data_rd(7);	--cyc 6
					v_fg <= data_rd(6);
					b_fg <= data_rd(4);
					d_fg <= data_rd(3);
					i_fg <= data_rd(2);
					z_fg <= data_rd(1);
					reg_a(8) <= data_rd(0);
					reg_sp <= reg_sp + "1";		--plus
					cycle_ctr <= cycle_ctr + x"1";

				when x"00" =>					--Break 3rd part  cyc 2
					if irq_fg = '0' and nmi_fg = '0' then	--Start up, irq and nmi also use
						b_fg <= '1';			--this set of logic.
					else
						b_fg <= '0';
					end if;
					wr_fg <= '1';			--put dat_out onto stack
					dat_out <= reg_pc(15 downto 8);
					add_fg <= x"7";
					pc_dec_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";

				when others =>
				cycle_ctr <= cycle_ctr + x"1";
			end case;	--Cycle 2

------------------------------------------------------------------------
--	Cycle 3 is for single byte instructions ie TAY
		when x"3" =>



			if 	instruction_in(7 downto 0) /= x"A2" and
				(
				instruction_in(3 downto 0) = x"3" or
				instruction_in(3 downto 0) = x"7" or
				instruction_in(3 downto 0) = x"B" or
				instruction_in(3 downto 0) = x"F"
								) then		--NOPs
					cycle_ctr <= x"0";
					pc_dec_fg <= '1';
			else

			case instruction_in(7 downto 0) is
--	======================================================================================
				when x"84" =>			--STY zero 4th part proto
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"85" =>			--STA zero 4th part proto
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"86" =>			--STX zero 4th part proto
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"94" =>			--STY zero, X 4th part proto
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"95" =>			--STA zero, X 4th part proto
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"96" =>			--STX zero, Y 4th part proto
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
--	=======================================================================================


				when x"08" =>			--PHP 4th part accumulator onto stack
					pc_inc_fg <= '1';
					add_fg <= x"0";
					reg_sp <= reg_sp - "1";		--neg
					cycle_ctr <=  cycle_ctr + x"1";

				when x"48" =>			--PHA 4th part accumulator onto stack
					pc_inc_fg <= '0';
					cycle_ctr <=  x"0";


				when x"68" =>			--PLA 4th part  Pull Accumulator from Stack
					reg_a(7 downto 0) <= data_rd;
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"28" =>			--PLP 4th part  Pull Status from Stack
					n_fg <= data_rd(7);
					v_fg <= data_rd(6);
					b_fg <= data_rd(4);
					d_fg <= data_rd(3);
					i_fg <= data_rd(2);
					z_fg <= data_rd(1);
					reg_a(8) <= data_rd(0);
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"F0" =>			--BEQ branch true 4th part.
						branch_fg <= '0';
						pc_inc_fg <= '1';
						cycle_ctr <= cycle_ctr + x"1";
				when x"D0" =>			--BNE branch true 4th part.
						branch_fg <= '0';
						pc_inc_fg <= '1';
						cycle_ctr <= cycle_ctr + x"1";
				when x"10" =>			--BPL plus true 4th part.
						branch_fg <= '0';
						pc_inc_fg <= '1';
						cycle_ctr <= cycle_ctr + x"1";
				when x"30" =>			--BM1 negative true 4th part.
						branch_fg <= '0';
						pc_inc_fg <= '1';
						cycle_ctr <= cycle_ctr + x"1";
				when x"50" =>			--BVC overflow false 4th part.
						branch_fg <= '0';
						pc_inc_fg <= '1';
						cycle_ctr <= cycle_ctr + x"1";
				when x"70" =>			--BVS overflow true 4th part.
						branch_fg <= '0';
						pc_inc_fg <= '1';
						cycle_ctr <= cycle_ctr + x"1";
				when x"90" =>			--BCC carry false 4th part.
						branch_fg <= '0';
						pc_inc_fg <= '1';
						cycle_ctr <= cycle_ctr + x"1";
				when x"B0" =>			--BCS carry true 4th part.
						branch_fg <= '0';
						pc_inc_fg <= '1';
						cycle_ctr <= cycle_ctr + x"1";

--	======================================================================================

				when x"E6" =>			--INC zero fourth part
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";

				when x"F6" =>			--INC zero,X fourth part
					wr_fg <= '0';
					cycle_ctr <= x"0";
				when x"C6" =>			--DEC zero fourth part
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";
				when x"D6" =>			--DEC zero,X fourth part
					wr_fg <= '0';
					cycle_ctr <= x"0";

				when x"26" =>			--ROL zero fourth part
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";
				when x"36" =>			--ROL zero,X fourth part
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";
				when x"66" =>			--ROR zero fourth part
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";
				when x"76" =>			--ROR zero,X fourth part
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";
				when x"06" =>			--ASL zero fourth part
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";
				when x"16" =>			--ASL zero,X fourth part
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";
				when x"46" =>			--LSR zero fourth part
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";
				when x"56" =>			--LSR zero,X fourth part
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";
--
--	==============================================================================
				when x"AD" =>			--LDA abs 4th part.
					reg_a(7 downto 0) <= data_rd;
					flags_fg <= "01";
					dat_out <= data_rd;
					cycle_ctr <= cycle_ctr + x"1";
				when x"BD" =>			--LDA, x abs 4th part.
					reg_a(7 downto 0) <= data_rd;
					flags_fg <= "01";
					dat_out <= data_rd;
					cycle_ctr <= cycle_ctr + x"1";

				when x"B9" =>			--LDA, Y abs 4th part
					reg_a(7 downto 0) <= data_rd;
					flags_fg <= "01";
					dat_out <= data_rd;
					cycle_ctr <= cycle_ctr + x"1";
				when x"2D" =>			--AND abs 4th part.
					reg_a(7 downto 0) <= reg_a(7 downto 0) and data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) and data_rd;
					cycle_ctr <= cycle_ctr + x"1";
				when x"3D" =>			--AND, x abs 4th part.
					reg_a(7 downto 0) <= reg_a(7 downto 0) and data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) and data_rd;
					cycle_ctr <= cycle_ctr + x"1";
				when x"39" =>			--AND, Y abs 4th part.
					reg_a(7 downto 0) <= reg_a(7 downto 0) and data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) and data_rd;
					cycle_ctr <= cycle_ctr + x"1";

				when x"0D" =>			--ORA abs 4th part.
					reg_a(7 downto 0) <= reg_a(7 downto 0) or data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) or data_rd;
					cycle_ctr <= cycle_ctr + x"1";
				when x"1D" =>			--ORA, x abs 4th part.
					reg_a(7 downto 0) <= reg_a(7 downto 0) or data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) or data_rd;
					cycle_ctr <= cycle_ctr + x"1";
				when x"19" =>			--ORA, Y abs 4th part.
					reg_a(7 downto 0) <= reg_a(7 downto 0) or data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) or data_rd;
					cycle_ctr <= cycle_ctr + x"1";

				when x"4D" =>			--EOR abs 4th part.
					reg_a(7 downto 0) <= reg_a(7 downto 0) xor data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) xor data_rd;
					cycle_ctr <= cycle_ctr + x"1";
				when x"5D" =>			--EOR, x abs 4th part.
					reg_a(7 downto 0) <= reg_a(7 downto 0) xor data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) xor data_rd;
					cycle_ctr <= cycle_ctr + x"1";
				when x"59" =>			--EOR, Y abs 4th part.
					reg_a(7 downto 0) <= reg_a(7 downto 0) xor data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) xor data_rd;
					cycle_ctr <= cycle_ctr + x"1";

				when x"6D" =>			--ADC abs 4th part.
					reg_a <= reg_a + ("0" & data_rd) + ("00000000" & reg_a(8));
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) + data_rd + ("0000000" & reg_a(8));
					cycle_ctr <= cycle_ctr + x"1";
				when x"7D" =>			--ADC, x abs 4th part.
					reg_a <= reg_a + ("0" & data_rd) + ("00000000" & reg_a(8));
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) + data_rd + ("0000000" & reg_a(8));
					cycle_ctr <= cycle_ctr + x"1";
				when x"79" =>			--ADC, Y abs 4th part.
					reg_a <= reg_a + ("0" & data_rd) + ("00000000" & reg_a(8));
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) + data_rd + ("0000000" & reg_a(8));
					cycle_ctr <= cycle_ctr + x"1";

				when x"ED" =>			--SBC abs 4th part.
					reg_a <= reg_a - ("0" & data_rd) - ("00000000" & reg_a(8));
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) - data_rd - ("0000000" & reg_a(8));
					cycle_ctr <= cycle_ctr + x"1";
				when x"FD" =>			--SBC, x abs 4th part.
					reg_a <= reg_a - ("0" & data_rd) - ("00000000" & reg_a(8));
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) - data_rd - ("0000000" & reg_a(8));
					cycle_ctr <= cycle_ctr + x"1";
				when x"F9" =>			--SBC, Y abs 4th part.
					reg_a <= reg_a - ("0" & data_rd) - ("00000000" & reg_a(8));
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) - data_rd - ("0000000" & reg_a(8));
					cycle_ctr <= cycle_ctr + x"1";

				when x"AE" =>			--LDX abs 4th part.
					reg_x <= data_rd;
					flags_fg <= "01";
					dat_out <= data_rd;
					cycle_ctr <= cycle_ctr + x"1";
				when x"BE" =>			--LDX, y abs 4th part.
					reg_x <= data_rd;
					flags_fg <= "01";
					dat_out <= data_rd;
					cycle_ctr <= cycle_ctr + x"1";
				when x"AC" =>			--LDY abs 4th part.
					reg_y <= data_rd;
					flags_fg <= "01";
					dat_out <= data_rd;
					cycle_ctr <= cycle_ctr + x"1";
				when x"BC" =>			--LDY, x abs 4th part.
					reg_y <= data_rd;
					flags_fg <= "01";
					dat_out <= data_rd;
					cycle_ctr <= cycle_ctr + x"1";
				when x"2C" =>			--BIT abs 4th part.
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) and data_rd;
					cycle_ctr <= cycle_ctr + x"1";

				when x"CD" =>			--CMP abs 4th part.
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) - data_rd;
					if reg_a(7 downto 0) >= data_rd then
						reg_a(8) <= '1';
					else
						reg_a(8) <= '0';
					end if;
					cycle_ctr <= cycle_ctr + x"1";
				when x"DD" =>			--CMP, x abs 4th part.
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) - data_rd;
					if reg_a(7 downto 0) >= data_rd then
						reg_a(8) <= '1';
					else
						reg_a(8) <= '0';
					end if;
					cycle_ctr <= cycle_ctr + x"1";
				when x"D9" =>			--CMP, Y abs 4th part.
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) - data_rd;
					if reg_a(7 downto 0) >= data_rd then
						reg_a(8) <= '1';
					else
						reg_a(8) <= '0';
					end if;
					cycle_ctr <= cycle_ctr + x"1";
				when x"EC" =>			--CPX abs 4th part.
					flags_fg <= "01";
					dat_out <= reg_x - data_rd;
					if reg_x >= data_rd then
						reg_a(8) <= '1';
					else
						reg_a(8) <= '0';
					end if;
					cycle_ctr <= cycle_ctr + x"1";
				when x"CC" =>			--CPY abs 4th part.
					flags_fg <= "01";
					dat_out <= reg_y - data_rd;
					if reg_y >= data_rd then
						reg_a(8) <= '1';
					else
						reg_a(8) <= '0';
					end if;
					cycle_ctr <= cycle_ctr + x"1";
--	.................................................................................
				when x"8D" =>			--STA abs 4th part.
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"9D" =>			--STA,x abs 4th part.
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"99" =>			--STA, y abs 4th part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"8E" =>			--STX abs 4th part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"8C" =>			--STY abs 4th part.
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
--	........................................................................

				when x"EE" =>			--INC abs 4th part.
					dat_out <= data_rd + x"01";
					wr_fg <= '1';
					flags_fg <= "01";
					cycle_ctr <= cycle_ctr + x"1";
				when x"FE" =>			--INC, x abs 4th part.
					dat_out <= data_rd + x"01";
					wr_fg <= '1';
					flags_fg <= "01";
					cycle_ctr <= cycle_ctr + x"1";
				when x"CE" =>			--DEC abs 4th part.
					dat_out <= data_rd - x"01";
					wr_fg <= '1';
					flags_fg <= "01";
					cycle_ctr <= cycle_ctr + x"1";
				when x"DE" =>			--DEC, x abs 4th part.
					dat_out <= data_rd - x"01";
					wr_fg <= '1';
					flags_fg <= "01";
					cycle_ctr <= cycle_ctr + x"1";

				when x"2E" =>			--ROL abs 4th part.
					dat_out(7 downto 0) <= data_rd(6 downto 0) & reg_a(8);
					reg_a(8) <= data_rd(7);
					flags_fg <= "01";
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"3E" =>			--ROL, x abs 4th part.
					dat_out(7 downto 0) <= data_rd(6 downto 0) & reg_a(8);
					reg_a(8) <= data_rd(7);
					flags_fg <= "01";
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"6E" =>			--ROR abs 4th part.
					dat_out(6 downto 0) <= data_rd(7 downto 1);
					dat_out(7) <= reg_a(8);
					reg_a(8) <= data_rd(0);
					flags_fg <= "01";
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"7E" =>			--ROR, x abs 4th part.
					dat_out(6 downto 0) <= data_rd(7 downto 1);
					dat_out(7) <= reg_a(8);
					reg_a(8) <= data_rd(0);
					flags_fg <= "01";
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"4E" =>			--LSR abs 4th part.
					dat_out <= '0' & data_rd(7 downto 1);
					reg_a(8) <= data_rd(0);
					flags_fg <= "01";
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"5E" =>			--LSR, x abs 4th part.
					dat_out <= '0' & data_rd(7 downto 1);
					reg_a(8) <= data_rd(0);
					flags_fg <= "01";
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"0E" =>			--ASL abs 4th part.
					reg_a(8) <= data_rd(7);
					dat_out <= data_rd(6 downto 0) & '0';
					flags_fg <= "01";
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
				when x"1E" =>			--ASL, x abs 4th part.
					reg_a(8) <= data_rd(7);
					dat_out <= data_rd(6 downto 0) & '0';
					flags_fg <= "01";
					wr_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";
--	............................................................................
--	==============================================================================
				when x"A1" =>			--LDA (zero,x) 4th part proto
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"B1" =>			--LDA (zero),y 4th part proto
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"21" =>			--AND (zero,x) 4th part proto
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"31" =>			--AND (zero),y 4th part proto
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"41" =>			--EOR (zero,x) 4th part proto
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"51" =>			--EOR (zero),y 4th part proto
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"01" =>			--OR (zero,x) 4th part proto
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"11" =>			--OR (zero),y 4th part proto
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";


				when x"61" =>			--ADC (zero,x) 4th part proto
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"71" =>			--ADC (zero),y 4th part proto
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"E1" =>			--SBC (zero,x) 4th part proto
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"F1" =>			--SBC (zero),y 4th part proto
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"C1" =>			--CMP (zero,x) 4th part proto
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";

				when x"D1" =>			--CMP (zero),y 4th part proto
					add_fg <= x"0";
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + "1";


				when x"81" =>			--STA (zero,x) 4th part proto
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + "1";
				when x"91" =>			--STA (zero),y 4th part proto
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + "1";
--	==================================================================================

				when x"4C"  =>			--JMP abs 4th part
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"6C" =>			--JMP abs 4th part
					add_fg <= x"0";
					dat2pc_fg <= '1';
					pc_inc_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";
				when x"20" =>			--JSR indirect 4th part
					wr_fg <= '0';
					reg_sp <= reg_sp - "1";		--neg
					cycle_ctr <= cycle_ctr + x"1";
				when x"60" =>			--RTS fourth part
					dat2pc_fg <= '0';
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";

				when x"40" =>			--RTI forth part
					add_fg <= x"7";		--Get 2nd PC byte
					dat2pc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";

				when x"00" =>				--Break 4th part cyc 3
					dat_out <= reg_pc(7 downto 0);	--put dat_out onto stack set up dat_out
					cycle_ctr <= cycle_ctr + x"1";

--------------------------------------------------------------------------------------
				when others =>
					cycle_ctr <= cycle_ctr + x"1";

		end case;	--Cycle 3
		end if;						--End single byte stuff

--	End of cycle 3
--	Cycle 4 is for 2 byte/cycle instructions ie LDA #
--
		when x"4" =>
			case Instruction_in is
--	======================================================================================
				when x"08" =>			--PHP 5th part accumulator onto stack
					pc_inc_fg <= '0';
					cycle_ctr <=  x"0";

				when x"F0" =>			--BEQ branch true 5th part.
						pc_inc_fg <= '0';
						cycle_ctr <= x"0";
				when x"D0" =>			--BNE branch true 5th part.
						pc_inc_fg <= '0';
						cycle_ctr <= x"0";
				when x"10" =>			--BPL plus true 5th part.
						pc_inc_fg <= '0';
						cycle_ctr <= x"0";
				when x"30" =>			--BM1 negative true 5th part.
						pc_inc_fg <= '0';
						cycle_ctr <= x"0";
				when x"50" =>			--BVC overflow false 5th part.
						pc_inc_fg <= '0';
						cycle_ctr <= x"0";
				when x"70" =>			--BVS overflow true 5th part.
						pc_inc_fg <= '0';
						cycle_ctr <= x"0";
				when x"90" =>			--BCC carry false 5th part.
						pc_inc_fg <= '0';
						cycle_ctr <= x"0";
				when x"B0" =>			--BCS carry true 5th part.
						pc_inc_fg <= '0';
						cycle_ctr <= x"0";
--	======================================================================================

				when x"E6" =>			--INC zero 5th part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";

				when x"F6" =>			--INC zero,X 5th part
					wr_fg <= '0';
					pc_inc_fg <= '0';
					add_fg <= x"0";
					cycle_ctr <= x"0";
				when x"c6" =>			--DEC zero 5th part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";

				when x"46" =>			--LSR zero 5th part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"56" =>			--LSR zero,X 5th part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";

				when x"66" =>			--ROR zero 5th part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"76" =>			--ROR zero,X 5th part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"26" =>			--ROL zero 5th part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"36" =>			--ROL zero,X 5th part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"06" =>			--ASL zero 5th part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"16" =>			--ASL zero,X 5th part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";


--
--	======================================================================================
				when x"AD" =>			--LDA 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"BD" =>			--LDA, x 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"B9" =>			--LDA, Y 5th part
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"2D" =>			--AND 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"3D" =>			--AND, x 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"39" =>			--AND, Y 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"0D" =>			--ORA 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"1D" =>			--ORA, x 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"19" =>			--ORA, Y 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"4D" =>			--EOR 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"5D" =>			--EOR, x 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"59" =>			--EOR, Y 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"6D" =>			--ADC 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"7D" =>			--ADC, x 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"79" =>			--ADC, Y 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"ED" =>			--SBC 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"FD" =>			--SBC, x 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"F9" =>			--SBC, Y 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"AE" =>			--LDX 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"BE" =>			--LDX, y 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"AC" =>			--LDY 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"BC" =>			--LDY, x 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"2C" =>			--BIT 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"CD" =>			--CMP 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"DD" =>			--CMP, x 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"D9" =>			--CMP, Y 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"EC" =>			--CPX 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"CC" =>			--CPY 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
--	............................................................................
				when x"8D" =>			--STA 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"9D" =>			--STA,x 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"99" =>			--STA, y 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"8E" =>			--STX 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"8C" =>			--STY 5th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
--	............................................................................

				when x"EE" =>			--INC abs 5th part.
					wr_fg <= '0';
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";

				when x"FE" =>			--INC, x 5th part.
					wr_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";
				when x"CE" =>			--DEC 5th part.
					wr_fg <= '0';
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"DE" =>			--DEC, x 5th part.
					wr_fg <= '0';
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";

				when x"2E" =>			--ROL 5th part.
					wr_fg <= '0';
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"3E" =>			--ROL, x 5th part.
					wr_fg <= '0';
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"6E" =>			--ROR 5th part.
					wr_fg <= '0';
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"7E" =>			--ROR, x 5th part.
					wr_fg <= '0';
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"4E" =>			--LSR 5th part.
					wr_fg <= '0';
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"5E" =>			--LSR, x 5th part.
					wr_fg <= '0';
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"0E" =>			--ASL 5th part.
					wr_fg <= '0';
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
				when x"1E" =>			--ASL, x 5th part.
					wr_fg <= '0';
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";
--	............................................................................
--	==============================================================================
				when x"A1" =>			--LDA (zero,x) 5th part proto
					reg_a(7 downto 0) <= data_rd;
					flags_fg <= "01";
					dat_out <= data_rd;
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"B1" =>			--LDA (zero),y 5th part proto
					reg_a(7 downto 0) <= data_rd;
					flags_fg <= "01";
					dat_out <= data_rd;
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"21" =>			--AND (zero,x) 5th part proto
					reg_a(7 downto 0) <= reg_a(7 downto 0) and data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) and data_rd;
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"31" =>			--AND (zero),y 5th part proto
					reg_a(7 downto 0) <= reg_a(7 downto 0) and data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) and data_rd;
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"42" =>			--EOR (zero,x) 5th part proto
					reg_a(7 downto 0) <= reg_a(7 downto 0) xor data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) xor data_rd;
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"51" =>			--EOR (zero),y 5th part proto
					reg_a(7 downto 0) <= reg_a(7 downto 0) xor data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) xor data_rd;
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"01" =>			--OR (zero,x) 5th part proto
					reg_a(7 downto 0) <= reg_a(7 downto 0) 	or data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) or data_rd;
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"11" =>			--OR (zero),y 5th part proto
					reg_a(7 downto 0) <= reg_a(7 downto 0) or data_rd;
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) or data_rd;
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"61" =>			--ADC (zero,x) 5th part proto
					flags_fg <= "01";
					reg_a <= reg_a + ("0" & data_rd) + ("00000000" & reg_a(8));
					dat_out <= reg_a(7 downto 0) + data_rd + ("0000000" & reg_a(8));
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"71" =>			--ADC (zero),y 5th part proto
					flags_fg <= "01";
					reg_a <= reg_a + ("0" & data_rd) + ("00000000" & reg_a(8));
					dat_out <= reg_a(7 downto 0) + data_rd + ("0000000" & reg_a(8));
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"E1" =>			--SBC (zero,x) 5th part proto
					flags_fg <= "01";
					reg_a <= reg_a - ("0" & data_rd) - ("00000000" & reg_a(8));
					dat_out <= reg_a(7 downto 0) - data_rd - ("0000000" & reg_a(8));
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"F1" =>			--SBC (zero),y 5th part proto
					flags_fg <= "01";
					reg_a <= reg_a - ("0" & data_rd) - ("00000000" & reg_a(8));
					dat_out <= reg_a(7 downto 0) - data_rd - ("0000000" & reg_a(8));
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"C1" =>			--CMP (zero,x) 5th part proto
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) - data_rd;
					if reg_a(7 downto 0) >= data_rd then
						reg_a(8) <= '1';
					else
						reg_a(8) <= '0';
					end if;
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"D1" =>			--CMP (zero),y 5th part proto
					flags_fg <= "01";
					dat_out <= reg_a(7 downto 0) - data_rd;
					if reg_a(7 downto 0) >= data_rd then
						reg_a(8) <= '1';
					else
						reg_a(8) <= '0';
					end if;
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"81" =>			--STA (zero,x) 5th part proto
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"91" =>			--STA (zero),y 5th part proto
					pc_inc_fg <= '1';
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
--	==============================================================================
				when x"4C"  =>			--JMP abs 5th part
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"6C" =>			--JMP indirect 5th part
					pc_inc_fg <= '1';
					dat2pc_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";
				when x"20" =>			--JSR 5th part
					pc_inc_fg <= '1';
					add_fg <= x"0";
					reg_sp <= reg_sp - "1";		--neg
					cycle_ctr <= cycle_ctr + x"1";
				when x"60" =>			--RTS fifth part
					dat2pc_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";

				when x"40" =>			--RTI fifth part
--					reg_sp <= reg_sp + "1";
					add_fg <= x"0";
					dat2pc_fg <= '0';
					cycle_ctr <= cycle_ctr + x"1";

				when x"00" =>			--Break 5th extra part cyc 4
					dat_out <= n_fg & v_fg & '1' & b_fg & d_fg & i_fg & z_fg & reg_a(8);
					reg_sp <= reg_sp - "1";		--neg
					cycle_ctr <= cycle_ctr + x"1";

				when others =>
					cycle_ctr <= cycle_ctr + x"1";

			end case;	--Cycle 4
--			end if;
------------------------------------------------------------------------
--	End of cycle 4
--	Cycle 5 is for 3 byte instructions ie LDA abs

		when x"5" =>
			case Instruction_in is
--	=========================================================================
				when x"81" =>			--STA (zero,x) 6th part proto
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"91" =>			--STA (zero),y 6th part proto
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";


--	........................................................................................
				when x"E6" =>			--INC zero 6th part
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"c6" =>			--dec zero 6th part
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"26" =>			--ROL zero 6th part
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"F6" =>			--INC zero,X 6th part
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"46" =>			--LSR zero 6th part
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"56" =>			--LSR zero,X 6th part
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"66" =>			--ROR zero 6th part
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"76" =>			--ROR zero,X 6th part
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"36" =>			--ROL zero,X 6th part
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"06" =>			--ASL zero 6th part
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"16" =>			--ASL zero,X 6th part
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";


--==================================================


				when x"EE" =>			--INC abs 6th part.
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";

				when x"FE" =>			--INC, x 6th part.
					add_fg <= x"0";
					cycle_ctr <= x"0";
				when x"CE" =>			--DEC 6th part.
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"DE" =>			--DEC, x 6th part.
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";

				when x"2E" =>			--ROL 6th part.
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"3E" =>			--ROL, x 6th part.
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"6E" =>			--ROR 6th part.
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"7E" =>			--ROR, x 6th part.
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"4E" =>			--LSR 6th part.
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"5E" =>			--LSR, x 6th part.
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"0E" =>			--ASL 6th part.
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
				when x"1E" =>			--ASL, x 6th part.
					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + x"1";
--	........................................................................................

				when x"6C" =>			--JMP indirect 6th part
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"60" =>			--RTS 6th part
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"40" =>			--RTI sixth part
					pc_inc_fg <= '1';
					cycle_ctr <= cycle_ctr + x"1";

				when x"20" =>			--JSR 6th part
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"00" =>			--Break 6th part cyc 5
					wr_fg <= '0';
					reg_sp <= reg_sp - "1";		--neg
					cycle_ctr <= cycle_ctr + x"1";

				when others =>

					cycle_ctr <= cycle_ctr + x"1";
			end  case;	--Cycle 5

------------------------------------------------------------------------
--	End of cycle 5
--	Cycle 6 is for 3 byte instructions ie LDA abs

		when x"6" =>
			case Instruction_in is

				when x"EE" =>			--INC abs 7th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"cE" =>			--DEC abs 7th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"2E" =>			--ROL abs 7th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"3E" =>			--ROL, x abs 7th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"6E" =>			--ROR abs 7th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"7E" =>			--ROR, x abs 7th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"4E" =>			--LSR abs 7th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"5E" =>			--LSR, x abs 7th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"0E" =>			--ASL abs 7th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
				when x"1E" =>			--ASL, x abs 7th part.
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";
--=============================================================================

				when x"40" =>			--RTI 7th part
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when x"00" =>			--Break 7th part cyc 6
					wr_fg <= '0';
					reg_sp <= reg_sp - "1";		--neg
					if nmi_fg = '0' then
						add_fg <= x"9";		--Complete stacking start getting vector
					else
						add_fg <= x"A";
					end if;
					cycle_ctr <= cycle_ctr + x"1";

			when others =>
				cycle_ctr <=  x"0";
				--get_inst_fg <= '0';


			end  case;	--Cycle 6
--	End of cycle 6


--	Cycle 8 is for 3 byte instructions ie LDA abs

		when x"7" =>
			case Instruction_in is

				when x"40" =>			--RTI 8th cyc
					cycle_ctr <= x"0";

				when x"00" =>			--Break 8th part cyc 7
					add_fg <= x"B";
					irq_fg <= '0';
					nmi_fg <= '0';
					nmi_req <= '1';
					if irq_fg = '1' then
						i_fg <= '1';
					end if;
					cycle_ctr <= cycle_ctr + "1";

				when others =>
					cycle_ctr <= x"0";

			end  case;	--Cycle 7
--	Cycle 7
		when x"8" =>
			case Instruction_in is
				when x"00" =>			--Break 9th part cyc 8
					dat2pc_fg <= '1';
 					add_fg <= x"0";
					cycle_ctr <= cycle_ctr + "1";

				when others =>
					cycle_ctr <= x"0";

			end  case;	--Cycle 8
--	++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--	Cycle 9
		when x"9" =>
			case Instruction_in is
				when x"00" =>			--Break 10th part cyc 9
					pc_inc_fg <= '1';
					start_fg <= '0';
					dat2pc_fg <= '0';
					cycle_ctr <= cycle_ctr + "1";

				when others =>
					cycle_ctr <= x"0";
			end  case;	--Cycle 9
--	++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--	Cycle A

		when x"A" =>
			case Instruction_in is
				when x"00" =>			--Break 11th part cyc 10
					pc_inc_fg <= '0';
					cycle_ctr <= x"0";

				when others =>
				cycle_ctr <= cycle_ctr + "1";
				pc_inc_fg <= '0';

			end  case;	--Cycle A
--	++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--	Cycle B

		when x"B" =>
			case Instruction_in is

				when others =>
					cycle_ctr <= cycle_ctr + "1";
					pc_inc_fg <= '0';

			end  case;	--Cycle B
--	++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--	Cycle C

		when x"C" =>
			case Instruction_in is


				when others =>
				cycle_ctr <=  x"0";

			end  case;	--Cycle C

--	==========================================================================


		when others =>
			cycle_ctr<= x"0";
	end case;	--cycle_ctr
end if;	--Reset stuff

end if;	--rising edge

end process instruction_decode;

end P65C02_architecture;

