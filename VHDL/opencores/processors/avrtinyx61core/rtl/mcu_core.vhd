------------------------------------------------------------------------------
--
-- Written by: Andreas Hilvarsson, avmcu¤opencores.org (www.syntera.se)
-- Project...: AVRtinyX61core
--
-- Purpose:
-- AVR tiny261/461/861 core
--
------------------------------------------------------------------------------
--    AVR tiny261/461/861 core
--    Copyright (C) 2008  Andreas Hilvarsson
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

entity mcu_core is
	Generic (
		G_PM_A_bits			: natural := 16;
		G_DM_A_bits			: natural := 16;
		G_DM_Areal_bits	: natural := 16
	);
	Port (
		Clk	: in std_logic;
		Rst	: in std_logic; -- Reset core when Rst='1'
		En		: in std_logic; -- CPU stops when En='0', could be used to slow down cpu to save power
		-- PM
		PM_A		: out std_logic_vector(G_PM_A_bits-1 downto 0);
		PM_Drd	: in std_logic_vector(15 downto 0);
		-- DM
		DM_A		: out std_logic_vector(G_DM_A_bits-1 downto 0); -- 0x00 - xxxx
		DM_Areal	: out std_logic_vector(G_DM_Areal_bits-1 downto 0); -- 0x60 - xxxx (same as above + io-adr offset)
		DM_Drd	: in std_logic_vector(7 downto 0);
		DM_Dwr	: out std_logic_vector(7 downto 0);
		DM_rd		: out std_logic;
		DM_wr		: out std_logic;
		-- IO
		IO_A		: out std_logic_vector(5 downto 0); -- 0x00 - 0x3F
		IO_Drd	: in std_logic_vector(7 downto 0);
		IO_Dwr	: out std_logic_vector(7 downto 0);
		IO_rd		: out std_logic;
		IO_wr		: out std_logic;
		-- OTHER
		OT_FeatErr	: out std_logic; -- Feature error! (Unhandled part of instruction)
		OT_InstrErr	: out std_logic -- Instruction error! (Unknown instruction)
	);
end mcu_core;

-- Feature error is pulsed high if LD/LDD/LDS/ST/STD/STS instruction tries to access register map

architecture Beh of mcu_core is
------------------------------------------------------------------------------
	--IO
	
	--REG
	signal reg_sreg : std_logic_vector(7 downto 0);
	constant c_sreg_i : natural := 7;
	constant c_sreg_t : natural := 6;
	constant c_sreg_h : natural := 5;
	constant c_sreg_s : natural := 4;
	constant c_sreg_v : natural := 3;
	constant c_sreg_n : natural := 2;
	constant c_sreg_z : natural := 1;
	constant c_sreg_c : natural := 0;
	signal reg_sp : std_logic_vector(15 downto 0);
	signal reg_pc : std_logic_vector(PM_A'range);
	constant c_reg_X : std_logic_vector(4 downto 0) := "11010";
	constant c_reg_Y : std_logic_vector(4 downto 0) := "11100";
	constant c_reg_Z : std_logic_vector(4 downto 0) := "11110";
	constant c_reg_R0 : std_logic_vector(4 downto 0) := "00000";

	type half_reg_file_type is array(0 to 15) of std_logic_vector(7 downto 0);
	signal reg_regs_h : half_reg_file_type; -- 1, 3 ... 31
	signal reg_regs_l : half_reg_file_type; -- 0, 2 ... 30

	signal reg_dData : std_logic_vector(7 downto 0); -- dest read data
	signal reg_dData_d : std_logic_vector(7 downto 0); -- dest read data
	signal reg_dRData : std_logic_vector(15 downto 0); -- dest read data
	signal reg_dRData_d : std_logic_vector(15 downto 0); -- dest read data
	signal reg_rData : std_logic_vector(7 downto 0); -- read read data
	signal reg_rData_d : std_logic_vector(7 downto 0); -- read read data
	signal reg_rRData : std_logic_vector(15 downto 0); -- read read data
	signal reg_rRData_d : std_logic_vector(15 downto 0); -- read read data
	signal reg_dAdr : std_logic_vector(4 downto 0); -- dest reg adr
	signal reg_rAdr : std_logic_vector(4 downto 0); -- read reg adr
	signal reg_dAdr_int : natural range 0 to 15; -- dest reg adr
	signal reg_rAdr_int : natural range 0 to 15; -- read reg adr
	signal reg_dWData : std_logic_vector(15 downto 0); -- dest write data
	signal reg_dWE_b : std_logic; -- Write byte
	signal reg_dWE_w : std_logic; -- Write word
	
	--OTHER
	signal ext_PM_A : std_logic_vector(15 downto 0);
	signal ext_DM_A : std_logic_vector(15 downto 0);
	signal ext_DM_Areal : std_logic_vector(15 downto 0);
	signal loc_Rd5 : std_logic_vector(4 downto 0); -- xxxx xxxd dddd xxxx
	signal loc_Rd5_locked : std_logic_vector(4 downto 0); -- xxxx xxxd dddd xxxx
	signal loc_Rd4 : std_logic_vector(3 downto 0); -- xxxx xxxx dddd xxxx
	signal loc_Rd2 : std_logic_vector(1 downto 0); -- xxxx xxxx xxdd xxxx
	signal loc_Rr5 : std_logic_vector(4 downto 0); -- xxxx xxrx xxxx rrrr
	signal loc_Rr4 : std_logic_vector(3 downto 0); -- xxxx xxxx xxxx rrrr
	signal loc_K12 : std_logic_vector(11 downto 0); -- xxxx kkkk kkkk kkkk
	signal loc_K8 : std_logic_vector(7 downto 0); -- xxxx kkkk xxxx kkkk
	signal loc_K7 : std_logic_vector(6 downto 0); -- xxxx xxkk kkkk kxxx
	signal loc_K6 : std_logic_vector(5 downto 0); -- xxxx xxxx kkxx kkkk
	signal loc_s3 : std_logic_vector(2 downto 0); -- xxxx xxxx xsss xxxx
	signal loc_b3 : std_logic_vector(2 downto 0); -- xxxx xxxx xxxx xbbb
	signal loc_A6 : std_logic_vector(5 downto 0); -- xxxx xAAx xxxx AAAA
	signal loc_A5 : std_logic_vector(4 downto 0); -- xxxx xxxx AAAA Axxx
	signal loc_q6 : std_logic_vector(5 downto 0); -- xxqx qqxx xxxx xqqq
	signal loc_add_h_flag : std_logic;
	signal loc_sub_h_flag : std_logic;
	signal loc_subi_h_flag : std_logic;
	signal loc_add_s_flag : std_logic;
	signal loc_sub_s_flag : std_logic;
	signal loc_subi_s_flag : std_logic;
	signal loc_add_v_flag : std_logic;
	signal loc_sub_v_flag : std_logic;
	signal loc_subi_v_flag : std_logic;
	signal loc_std_n_flag : std_logic;
	signal loc_std_z_flag : std_logic;
	signal loc_add_c_flag : std_logic;
	signal loc_sub_c_flag : std_logic;
	signal loc_subi_c_flag : std_logic;
	
	signal step : std_logic_vector(2 downto 0);
	signal rst_step : std_logic_vector(4 downto 0);
	type int_processing_state_type is (	Reset, NextInstr, WaitForInstr, HandleInstr, InstrError, 
													HandleLDS, HandleSTS, HandleLpmR0Z, HandleLpmZ, HandleLpmZPlus,
													SkipInstr
													--HandleFarJmp, HandleFarCall
													);
	signal proc_state : int_processing_state_type;
	signal skip_next_instr : std_logic;
	
	signal ext_Dwr : std_logic_vector(7 downto 0);
	signal ext_Drd : std_logic_vector(7 downto 0);
	signal ext_Drd_d : std_logic_vector(7 downto 0);
	signal ext_rd : std_logic;
	signal ext_wr : std_logic;
	signal ext_DM_A_is_sreg : std_logic;
	signal ext_DM_A_is_spl : std_logic;
	signal ext_DM_A_is_sph : std_logic;
	signal ext_DM_A_is_reg : std_logic;
	signal ext_DM_A_is_intIO : std_logic;
	signal ext_DM_A_is_io : std_logic;
	signal ext_DM_A_is_dm : std_logic;
------------------------------------------------------------------------------
begin
------------------------------------------------------------------------------
	loc_Rd5 <= PM_Drd(8 downto 4);								-- xxxx xxxd dddd xxxx
	loc_Rd4 <= PM_Drd(7 downto 4);								-- xxxx xxxx dddd xxxx
	loc_Rd2 <= PM_Drd(5 downto 4);								-- xxxx xxxx xxdd xxxx
	loc_Rr5 <= PM_Drd(9) & PM_Drd(3 downto 0);				-- xxxx xxrx xxxx rrrr
	loc_Rr4 <= PM_Drd(3 downto 0);								-- xxxx xxxx xxxx rrrr
	loc_K12 <= PM_Drd(11 downto 0);								-- xxxx kkkk kkkk kkkk
	loc_K8 <= PM_Drd(11 downto 8) & PM_Drd(3 downto 0);	-- xxxx kkkk xxxx kkkk
	loc_K7 <= PM_Drd(9 downto 3);									-- xxxx xxkk kkkk kxxx
	loc_K6 <= PM_Drd(7 downto 6) & PM_Drd(3 downto 0);		-- xxxx xxxx kkxx kkkk
	loc_s3 <= PM_Drd(6 downto 4);									-- xxxx xxxx xsss xxxx
	loc_b3 <= PM_Drd(2 downto 0);									-- xxxx xxxx xxxx xbbb
	loc_A6 <= PM_Drd(10 downto 9) & PM_Drd(3 downto 0);	-- xxxx xAAx xxxx AAAA
	loc_A5 <= PM_Drd(7 downto 3);									-- xxxx xxxx AAAA Axxx
	loc_q6 <= PM_Drd(13) & PM_Drd(11 downto 10) & PM_Drd(2 downto 0);	-- xxqx qqxx xxxx xqqq
------------------------------------------------------------------------------
	loc_add_h_flag <=	(reg_dData_d(3)			and reg_rData_d(3)) or
							(reg_rData_d(3)			and (not reg_dWData(3))) or
							((not reg_dWData(3))		and reg_dData_d(3));

	loc_add_c_flag <=	(reg_dData_d(7)			and reg_rData_d(7)) or
							(reg_rData_d(7)			and (not reg_dWData(7))) or
							((not reg_dWData(7))		and reg_dData_d(7));

	loc_add_v_flag <=	(reg_dData_d(7)			and reg_rData_d(7)			and (not reg_dWData(7))) or
							((not reg_dData_d(7))	and (not reg_rData_d(7))	and reg_dWData(7));

	loc_sub_h_flag <=	((not reg_dData_d(3))	and reg_rData_d(3)) or
							(reg_rData_d(3)			and reg_dWData(3)) or
							(reg_dWData(3)				and (not reg_dData_d(3)));

	loc_sub_c_flag <=	((not reg_dData_d(7))	and reg_rData_d(7)) or
							(reg_rData_d(7)			and reg_dWData(7)) or
							(reg_dWData(7)				and (not reg_dData_d(7)));

	loc_sub_v_flag <=	(reg_dData_d(7)			and (not reg_rData_d(7))	and (not reg_dWData(7))) or
							((not reg_dData_d(7))	and reg_rData_d(7)			and reg_dWData(7));

	loc_subi_h_flag <=	((not reg_dData_d(3))	and loc_K8(3)) or
								(loc_K8(3)					and reg_dWData(3)) or
								(reg_dWData(3)				and (not reg_dData_d(3)));

	loc_subi_c_flag <=	((not reg_dData_d(7))	and loc_K8(7)) or
								(loc_K8(7)					and reg_dWData(7)) or
								(reg_dWData(7)				and (not reg_dData_d(7)));

	loc_subi_v_flag <=	(reg_dData_d(7)			and (not loc_K8(7))	and (not reg_dWData(7))) or
								((not reg_dData_d(7))	and loc_K8(7)			and reg_dWData(7));

	loc_add_s_flag		<=	loc_std_n_flag xor loc_add_v_flag; -- for signed tests
	loc_sub_s_flag 	<=	loc_std_n_flag xor loc_sub_v_flag; -- for signed tests
	loc_subi_s_flag 	<=	loc_std_n_flag xor loc_subi_v_flag; -- for signed tests
	
	loc_std_n_flag <=	reg_dWData(7);
	loc_std_z_flag <=	'1' when (reg_dWData(7 downto 0) = "00000000") else '0';
------------------------------------------------------------------------------
	reg_dAdr_int <= CONV_INTEGER('0'&reg_dAdr(4 downto 1));
	reg_rAdr_int <= CONV_INTEGER('0'&reg_rAdr(4 downto 1));
	
	reg_proc : process(clk)
	begin
		if (clk'event and clk='1') then
			if (rst='1') then
				-- registers are cleared in processin_proc process
			elsif (En='1') then
				if (reg_dWE_w = '1') then -- word write
					reg_regs_h(reg_dAdr_int) <= reg_dWData(15 downto 8);
					reg_regs_l(reg_dAdr_int) <= reg_dWData(7 downto 0);
				elsif (reg_dWE_b = '1') then -- byte write
					if (reg_dAdr(0)= '0') then
						reg_regs_l(reg_dAdr_int) <= reg_dWData(7 downto 0);
					else
						reg_regs_h(reg_dAdr_int) <= reg_dWData(7 downto 0); -- Only use lowe byte
					end if; -- dAdr(0)
				end if; --WE
			end if; -- Rst/En
		end if; -- Clk
	end process reg_proc;

	reg_dData <= reg_regs_l(reg_dAdr_int) when (reg_dAdr(0) = '0') else reg_regs_h(reg_dAdr_int);
	reg_dRData <= reg_regs_h(reg_dAdr_int) & reg_regs_l(reg_dAdr_int);
	
	reg_rData <= reg_regs_l(reg_rAdr_int) when (reg_rAdr(0) = '0') else reg_regs_h(reg_rAdr_int);
	reg_rRData <= reg_regs_h(reg_rAdr_int) & reg_regs_l(reg_rAdr_int);

	regd_d_proc : process(clk)
	begin
		if (clk'event and clk='1') then
			if (rst='1') then
				reg_dData_d		<= (OTHERS => '0');
				reg_rData_d		<= (OTHERS => '0');
				reg_dRData_d	<= (OTHERS => '0');
				reg_rRData_d	<= (OTHERS => '0');
			elsif (En='1') then
				-- store for next clockpulse
				reg_dData_d <= reg_dData;
				reg_rData_d <= reg_rData;
				reg_dRData_d <= reg_dRData;
				reg_rRData_d <= reg_rRData;
			end if; -- Rst/En
		end if; -- Clk
	end process regd_d_proc;
------------------------------------------------------------------------------
	PM_A <= ext_PM_A(PM_A'range);
	pma_proc : process (reg_pc, proc_state, reg_rRData)
	begin
		case proc_state is
			when HandleLpmR0Z		=> ext_PM_A <= '0' & reg_rRData(15 downto 1);
			when HandleLpmZ		=> ext_PM_A <= '0' & reg_rRData(15 downto 1);
			when HandleLpmZPlus	=> ext_PM_A <= '0' & reg_rRData(15 downto 1);
			when others				=> 
				ext_PM_A <= (OTHERS=>'0');
				ext_PM_A(reg_pc'range) <= reg_pc;
		end case;
	end process pma_proc;
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
	ext_DM_A_is_sreg	<= '1' when (ext_DM_Areal = X"005F") else '0';
	ext_DM_A_is_sph	<= '1' when (ext_DM_Areal = X"005E") else '0';
	ext_DM_A_is_spl	<= '1' when (ext_DM_Areal = X"005D") else '0';
	ext_DM_A_is_intIO	<= '1' when ((ext_DM_A_is_sreg = '1') or (ext_DM_A_is_sph = '1') or (ext_DM_A_is_spl = '1')) else '0';
	ext_DM_A_is_reg	<= '1' when (ext_DM_Areal(15 downto 5) = X"00"&"000") else '0';
	ext_DM_A_is_io		<= '1' when (	(ext_DM_A_is_intIO = '0') and
												((ext_DM_Areal(15 downto 5) = X"00"&"001") or (ext_DM_Areal(15 downto 5) = X"00"&"010"))
										) else '0';
	ext_DM_A_is_dm		<= '1' when ((ext_DM_A_is_io = '0') and (ext_DM_A_is_reg = '0') and (ext_DM_A_is_intIO = '0')) else '0';

	DM_A <= ext_DM_A(DM_A'range);
	ext_DM_A <= ext_DM_Areal - X"0060";
	DM_Areal <= ext_DM_Areal(DM_Areal'range);
	DM_Dwr <= ext_Dwr;

	IO_A <= ext_DM_Areal(IO_A'range) - ("10" & X"0"); -- -0x20
	IO_Dwr <= ext_Dwr;
	
	erwp : process (	ext_DM_Areal, ext_Dwr, ext_wr, ext_rd, reg_sreg, reg_sp, io_Drd, DM_Drd,
							ext_DM_A_is_sreg, ext_DM_A_is_sph, ext_DM_A_is_spl, ext_DM_A_is_reg, ext_DM_A_is_io, ext_DM_A_is_intIO, ext_DM_A_is_dm)
	begin
		-- defaults
		DM_rd <= '0';
		DM_wr <= '0';
		io_rd <= '0';
		io_wr <= '0';
		ext_Drd <= (OTHERS => '0');

		-- check whats active
		if (ext_DM_A_is_sreg = '1') then
			ext_Drd <= reg_sreg;
		end if;

		if (ext_DM_A_is_sph = '1') then
			ext_Drd <= reg_sp(15 downto 8);
		end if;

		if (ext_DM_A_is_spl = '1') then
			ext_Drd <= reg_sp(7 downto 0);
		end if;

		if (ext_DM_A_is_reg = '1') then
			NULL; -- Do nothing, must be handled else where
		end if;

		if (ext_DM_A_is_io = '1') then
			IO_rd <= ext_rd;
			IO_wr <= ext_wr;
			ext_Drd <= IO_Drd;
		end if;

		if (ext_DM_A_is_dm = '1') then
			DM_rd <= ext_rd;
			DM_wr <= ext_wr;
			ext_Drd <= DM_Drd;
		end if;
	end process;

	extd_d_proc : process(clk)
	begin
		if (clk'event and clk='1') then
			if (rst='1') then
				ext_Drd_d	<= (OTHERS => '0');
			elsif (En='1') then
				-- store for next clockpulse
				ext_Drd_d	<= ext_Drd;
			end if; -- Rst/En
		end if; -- Clk
	end process extd_d_proc;

------------------------------------------------------------------------------
	processin_proc : process(clk)
		variable tmp_calc9 : std_logic_vector(8 downto 0); -- used when 9 bit result is returned from calc.
		variable tmp_calc16 : std_logic_vector(15 downto 0); -- used when 16 bit result is returned from calc.
		variable reg_pc_plus_one : std_logic_vector(15 downto 0); -- points to next pc address
		variable next_pc : std_logic_vector(15 downto 0); -- points to next pc address
	begin
		if (clk'event and clk='1') then
			if (rst='1') then
				proc_state			<= Reset;
				step					<= (OTHERS => '0');
				rst_step				<= (OTHERS => '0');
				OT_FeatErr			<= '0';
				OT_InstrErr			<= '0';
				skip_next_instr	<= '0';
				loc_Rd5_locked		<= (others => '0');
				-- Regs
				reg_sreg		<= (OTHERS => '0');
				reg_sp		<= (OTHERS => '0');
				reg_pc		<= (OTHERS => '0');
				reg_dWData	<= (OTHERS => '0');
				reg_dAdr		<= (OTHERS => '0');
				reg_rAdr		<= (OTHERS => '0');
				reg_dWE_b	<= '0';
				reg_dWE_w	<= '0';
				-- Ext
				ext_DM_Areal	<= (OTHERS => '0');
				ext_Dwr		<= (OTHERS => '0');
				ext_rd		<= '0';
				ext_wr		<= '0';
			elsif (En='1') then
				-- Defaults
				step			<= (OTHERS => '0');
				rst_step		<= rst_step + 1;
				OT_InstrErr	<= '0';
				OT_FeatErr	<= '0';
				reg_pc_plus_one	:= reg_pc + 1;
				-- Regs
				reg_dWData	<= (OTHERS => '0');
				reg_dAdr		<= loc_Rd5;
				reg_rAdr		<= loc_Rr5;
				reg_dWE_b	<= '0';
				reg_dWE_w	<= '0';
				-- Ext
				ext_DM_Areal	<= (OTHERS => '0');
				ext_Dwr		<= (OTHERS => '0');
				ext_rd		<= '0';
				ext_wr		<= '0';
				
				-- Handle signaling of error if internal registers are access as external addresses
				if ((ext_rd = '1') or (ext_wr = '1')) then
					if (ext_DM_A_is_reg = '1') then
						OT_FeatErr <= '1'; -- Signal error if reg is accessed
					end if;
				end if;
				
				-- Handle writing of internal registers.
				if (ext_wr = '1') then
					if (ext_DM_A_is_sreg = '1') then
						reg_sreg <= ext_Dwr;
					end if;
					if (ext_DM_A_is_sph = '1') then
						reg_sp(15 downto 8) <= ext_Dwr;
					end if;
					if (ext_DM_A_is_spl = '1') then
						reg_sp(7 downto 0) <= ext_Dwr;
					end if;
					if (ext_DM_A_is_reg = '1') then
						-- synthesis off
						REPORT "Not implemented"
							SEVERITY ERROR;
						-- synthesis on
						-- TODO implement
					end if;
				end if;

				-- Handle proc
				case proc_state is
					-- Processor is reset
					when Reset =>
						if (rst_step(4) = '0') then
							-- Clear reg_regs
							reg_dAdr		<= rst_step(3 downto 0) & '0';
							reg_dWE_w	<= '1';
						else
							proc_state <= HandleInstr;
						end if; --rst_step
						
					-- Go to next instruction
					when NextInstr =>
						next_pc := reg_pc_plus_one;
						reg_pc <= next_pc(reg_pc'range);
						proc_state <= WaitForInstr;
						
					-- Wait one wait state for PM
					when WaitForInstr =>
						skip_next_instr <= '0';
						if (skip_next_instr = '0') then
							proc_state <= HandleInstr;
						else
							proc_state <= SkipInstr;
						end if;
						
					-- Skip instruction
					when SkipInstr =>
						proc_state <= NextInstr;
						-- If 2 word instruction move pc one extra step
						if ((PM_Drd(15 downto 10) = "100100") and (PM_Drd(3 downto 0) = "0000")) then -- lds / sts
							next_pc := reg_pc_plus_one;
							reg_pc <= next_pc(reg_pc'range);
						end if;
					
					-- Handle instruction
					when HandleInstr =>
						-- Default
						step <= step + 1;
						skip_next_instr <= '0';
						loc_Rd5_locked <= loc_Rd5; -- Safe for other separate HandleXXXX states
						
						case PM_Drd(15 downto 12) is -- (DONE)
							when "0000" => -- nop, movw, cpc, sbc, add (DONE)
								case PM_Drd(11 downto 8) is
									when "0000" => -- nop?
										proc_state <= NextInstr;
										if (PM_Drd(7 downto 0) = "00000000") then
											NULL; -- do nothing
										else
											proc_state <= InstrError;
										end if;
									when "0001" => -- movw
										reg_dWData <= reg_rRData;
										reg_dAdr <= loc_Rd4 & '0';
										reg_rAdr <= loc_Rr4 & '0';
										if (step(0) = '0') then
											proc_state <= HandleInstr; -- Stay here
										else
											reg_dWE_w <= '1';
											proc_state <= NextInstr;
										end if;
									when "0100"|"0101"|"0110"|"0111" | "1000"|"1001"|"1010"|"1011"  => -- cpc | sbc
										reg_dAdr <= loc_Rd5;
										reg_rAdr <= loc_Rr5;
										case step(1 downto 0) is
											when "00" => NULL; -- fetch data
											when "01" => -- Do calc
												reg_dWData(7 downto 0) <= reg_dData - reg_rData - reg_sreg(c_sreg_c);
												reg_dWE_b <= PM_Drd(11); -- Only write if sbc, not if cpc
											when others => -- set flags and done
												reg_sreg(c_sreg_h) <= loc_sub_h_flag;
												reg_sreg(c_sreg_s) <= loc_sub_s_flag;
												reg_sreg(c_sreg_v) <= loc_sub_v_flag;
												reg_sreg(c_sreg_n) <= loc_std_n_flag;
												reg_sreg(c_sreg_z) <= loc_std_z_flag and reg_sreg(c_sreg_z);
												reg_sreg(c_sreg_c) <= loc_sub_c_flag;
												proc_state <= NextInstr;
										end case; --step
									when "1100"|"1101"|"1110"|"1111" => -- add
										reg_dAdr <= loc_Rd5;
										reg_rAdr <= loc_Rr5;
										case step(1 downto 0) is
											when "00" => NULL; -- fetch data
											when "01" => -- Do calc
												reg_dWData(7 downto 0) <= reg_dData + reg_rData;
												reg_dWE_b <= '1';
											when others => -- set flags and done
												reg_sreg(c_sreg_h) <= loc_add_h_flag;
												reg_sreg(c_sreg_s) <= loc_add_s_flag;
												reg_sreg(c_sreg_v) <= loc_add_v_flag;
												reg_sreg(c_sreg_n) <= loc_std_n_flag;
												reg_sreg(c_sreg_z) <= loc_std_z_flag;
												reg_sreg(c_sreg_c) <= loc_add_c_flag;
												proc_state <= NextInstr;
										end case; --step
									when others =>
										proc_state <= InstrError;
								end case; --11 downto 8
								
							when "0001" => -- cpse, cp, sub, adc (DONE)
								case PM_Drd(11 downto 10) is
									when "00" => -- cpse (DONE)
										reg_dAdr <= loc_Rd5;
										reg_rAdr <= loc_Rr5;
										if (step(0) = '0') then
											NULL; -- fetch data
										else -- compare data
											proc_state <= NextInstr;
											if (reg_dData = reg_rData) then
												skip_next_instr <= '1';
											end if; -- eq?
										end if; --step
									when "01" | "10" => -- cp, sub (DONE)
										reg_dAdr <= loc_Rd5;
										reg_rAdr <= loc_Rr5;
										case step(1 downto 0) is
											when "00" => NULL; -- fetch data
											when "01" => -- Do calc
												reg_dWData(7 downto 0) <= reg_dData - reg_rData;
												reg_dWE_b <= PM_Drd(11); -- Only write if sub, not if cp
											when others => -- set flags and done
												reg_sreg(c_sreg_h) <= loc_sub_h_flag;
												reg_sreg(c_sreg_s) <= loc_sub_s_flag;
												reg_sreg(c_sreg_v) <= loc_sub_v_flag;
												reg_sreg(c_sreg_n) <= loc_std_n_flag;
												reg_sreg(c_sreg_z) <= loc_std_z_flag;
												reg_sreg(c_sreg_c) <= loc_sub_c_flag;
												proc_state <= NextInstr;
										end case; --step
									when "11" => -- adc (DONE)
										reg_dAdr <= loc_Rd5;
										reg_rAdr <= loc_Rr5;
										case step(1 downto 0) is
											when "00" => NULL; -- fetch data
											when "01" => -- Do calc
												reg_dWData(7 downto 0) <= reg_dData + reg_rData + reg_sreg(c_sreg_c);
												reg_dWE_b <= '1';
											when others => -- set flags and done
												reg_sreg(c_sreg_h) <= loc_add_h_flag;
												reg_sreg(c_sreg_s) <= loc_add_s_flag;
												reg_sreg(c_sreg_v) <= loc_add_v_flag;
												reg_sreg(c_sreg_n) <= loc_std_n_flag;
												reg_sreg(c_sreg_z) <= loc_std_z_flag;
												reg_sreg(c_sreg_c) <= loc_add_c_flag;
												proc_state <= NextInstr;
										end case; --step
									when others => NULL; --for simulation
								end case; --11 downto 10
								
							when "0010" => -- and, eor, or, mov (DONE)
								case PM_Drd(11 downto 10) is
									when "00" => -- and
										reg_dAdr <= loc_Rd5;
										reg_rAdr <= loc_Rr5;
										case step(1 downto 0) is
											when "00" => NULL; -- fetch data
											when "01" => -- Do calc
												reg_dWData(7 downto 0) <= reg_dData and reg_rData;
												reg_dWE_b <= '1';
											when others => -- set flags and done
												reg_sreg(c_sreg_s) <= loc_std_n_flag;
												reg_sreg(c_sreg_v) <= '0';
												reg_sreg(c_sreg_n) <= loc_std_n_flag;
												reg_sreg(c_sreg_z) <= loc_std_z_flag;
												proc_state <= NextInstr;
										end case; --step
									when "01" => -- eor
										reg_dAdr <= loc_Rd5;
										reg_rAdr <= loc_Rr5;
										case step(1 downto 0) is
											when "00" => NULL; -- fetch data
											when "01" => -- Do calc
												reg_dWData(7 downto 0) <= reg_dData xor reg_rData;
												reg_dWE_b <= '1';
											when others => -- set flags and done
												reg_sreg(c_sreg_s) <= loc_std_n_flag;
												reg_sreg(c_sreg_v) <= '0';
												reg_sreg(c_sreg_n) <= loc_std_n_flag;
												reg_sreg(c_sreg_z) <= loc_std_z_flag;
												proc_state <= NextInstr;
										end case; --step
									when "10" => -- or
										reg_dAdr <= loc_Rd5;
										reg_rAdr <= loc_Rr5;
										case step(1 downto 0) is
											when "00" => NULL; -- fetch data
											when "01" => -- Do calc
												reg_dWData(7 downto 0) <= reg_dData or reg_rData;
												reg_dWE_b <= '1';
											when others => -- set flags and done
												reg_sreg(c_sreg_s) <= loc_std_n_flag;
												reg_sreg(c_sreg_v) <= '0';
												reg_sreg(c_sreg_n) <= loc_std_n_flag;
												reg_sreg(c_sreg_z) <= loc_std_z_flag;
												proc_state <= NextInstr;
										end case; --step
									when "11" => -- mov
										reg_dAdr <= loc_Rd5;
										reg_rAdr <= loc_Rr5;
										reg_dWData(7 downto 0) <= reg_rData;
										if (step(0) = '0') then -- fetch data
											NULL;
										else -- move and done
											reg_dWE_b <= '1';
											proc_state <= NextInstr;
										end if; -- step
									when others => NULL; --for simulation
								end case; --11 downto 10
								
							when "0011" | "0101" => -- cpi, subi (DONE)
								reg_dAdr <= '1' & loc_Rd4; -- only reg 16-31
								case step(1 downto 0) is
									when "00" => NULL; -- fetch data
									when "01" => -- Do calc
										reg_dWData(7 downto 0) <= reg_dData - loc_k8;
										reg_dWE_b <= PM_Drd(14); -- Only write if subi, not if cpi
									when others => -- set flags and done
										reg_sreg(c_sreg_h) <= loc_subi_h_flag;
										reg_sreg(c_sreg_s) <= loc_subi_s_flag;
										reg_sreg(c_sreg_v) <= loc_subi_v_flag;
										reg_sreg(c_sreg_n) <= loc_std_n_flag;
										reg_sreg(c_sreg_z) <= loc_std_z_flag;
										reg_sreg(c_sreg_c) <= loc_subi_c_flag;
										proc_state <= NextInstr;
								end case; --step

							when "0100" => -- sbci (DONE)
								reg_dAdr <= '1' & loc_Rd4; -- only reg 16-31
								case step(1 downto 0) is
									when "00" => NULL; -- fetch data
									when "01" => -- Do calc
										reg_dWData(7 downto 0) <= reg_dData - loc_k8 - reg_sreg(c_sreg_c);
										reg_dWE_b <= '1';
									when others => -- set flags and done
										reg_sreg(c_sreg_h) <= loc_subi_h_flag;
										reg_sreg(c_sreg_s) <= loc_subi_s_flag;
										reg_sreg(c_sreg_v) <= loc_subi_v_flag;
										reg_sreg(c_sreg_n) <= loc_std_n_flag;
										reg_sreg(c_sreg_z) <= loc_std_z_flag and reg_sreg(c_sreg_z);
										reg_sreg(c_sreg_c) <= loc_subi_c_flag;
										proc_state <= NextInstr;
								end case; --step

							when "0110" => -- ori (DONE)
								reg_dAdr <= '1' & loc_Rd4; -- only reg 16-31
								case step(1 downto 0) is
									when "00" => NULL; -- fetch data
									when "01" => -- Do calc
										reg_dWData(7 downto 0) <= reg_dData or loc_k8;
										reg_dWE_b <= '1';
									when others => -- set flags and done
										reg_sreg(c_sreg_s) <= loc_std_n_flag;
										reg_sreg(c_sreg_v) <= '0';
										reg_sreg(c_sreg_n) <= loc_std_n_flag;
										reg_sreg(c_sreg_z) <= loc_std_z_flag;
										proc_state <= NextInstr;
								end case; --step

							when "0111" => -- andi (DONE)
								reg_dAdr <= '1' & loc_Rd4; -- only reg 16-31
								case step(1 downto 0) is
									when "00" => NULL; -- fetch data
									when "01" => -- Do calc
										reg_dWData(7 downto 0) <= reg_dData and loc_k8;
										reg_dWE_b <= '1';
									when others => -- set flags and done
										reg_sreg(c_sreg_s) <= loc_std_n_flag;
										reg_sreg(c_sreg_v) <= '0';
										reg_sreg(c_sreg_n) <= loc_std_n_flag;
										reg_sreg(c_sreg_z) <= loc_std_z_flag;
										proc_state <= NextInstr;
								end case; --step

							when "1000" | "1010" => -- ldd+q, std+q (DONE)
								reg_dAdr <= loc_Rd5;
								if (PM_Drd(3) = '0') then -- Z
									reg_rAdr <= c_reg_Z;
								else -- Y
									reg_rAdr <= c_reg_Y;
								end if;
								ext_DM_Areal <= reg_rRData + loc_q6;
								if (PM_Drd(9) = '0') then -- ldd+q (DONE)
									reg_dWData(7 downto 0) <= ext_Drd;
									case step(1 downto 0) is
										when "00" => -- do reg read
										when "01" => -- do sram read
											ext_rd <= '1';
										when "10" => -- wait on sram read
										when others => -- set reg with loaded data and done
											reg_dWE_b <= '1';
											proc_state <= NextInstr;
									end case; --step
								else -- std+q (DONE)
									ext_Dwr <= reg_dData;
									case step(0) is
										when '0' => -- do reg read
										when others => -- store reg in sram and done
											ext_wr <= '1';
											proc_state <= NextInstr;
									end case; --step
								end if;

							when "1001" => -- *many* (DONE)
								case PM_Drd(11 downto 9) is
									when "000" => -- ld, lds, lpm, pop (DONE)
										case PM_Drd(3 downto 0) is
											when "0000" => -- lds (DONE)
												next_pc := reg_pc_plus_one;
												reg_pc <= next_pc(reg_pc'range);
												proc_state <= HandleLDS;
												step <= (others => '0');
											when "0001" | "1001" | "1101" => -- ld Z+ Y+ X+ (DONE)
												reg_dAdr <= loc_Rd5;
												case PM_Drd(3 downto 2) is
													when "00" => reg_rAdr <= c_reg_Z;
													when "10" => reg_rAdr <= c_reg_Y;
													when "11" => reg_rAdr <= c_reg_X;
													when others => NULL; -- for simulation
												end case; 
												ext_DM_Areal <= reg_rRData;
												reg_dWData(7 downto 0) <= ext_Drd;
												case step(2 downto 0) is
													when "000" => -- wait on data
													when "001" => -- wait on data
														ext_rd <= '1';
													when "010" => -- wait on data
													when "011" => -- set reg with loaded data
														reg_dWE_b <= '1';
													when others => -- update XYZ with +1
														reg_dWE_w <= '1';
														case PM_Drd(3 downto 2) is
															when "00" => reg_dAdr <= c_reg_Z;
															when "10" => reg_dAdr <= c_reg_Y;
															when "11" => reg_dAdr <= c_reg_X;
															when others => NULL; -- for simulation
														end case; 
														reg_dWData <= reg_rRData + 1;
														proc_state <= NextInstr;
												end case; --step
											when "0010" | "1010" | "1110" => -- ld -Z -Y -X (DONE)
												reg_dAdr <= loc_Rd5;
												case PM_Drd(3 downto 2) is
													when "00" => reg_rAdr <= c_reg_Z;
													when "10" => reg_rAdr <= c_reg_Y;
													when "11" => reg_rAdr <= c_reg_X;
													when others => NULL; -- for simulation
												end case; 
												ext_DM_Areal <= reg_rRData - 1;
												reg_dWData(7 downto 0) <= ext_Drd;
												case step(2 downto 0) is
													when "000" => -- wait on data
													when "001" => -- wait on data
														ext_rd <= '1';
													when "010" => -- wait on data
													when "011" => -- set reg with loaded data
														reg_dWE_b <= '1';
													when others => -- update XYZ with -1
														reg_dWE_w <= '1';
														case PM_Drd(3 downto 2) is
															when "00" => reg_dAdr <= c_reg_Z;
															when "10" => reg_dAdr <= c_reg_Y;
															when "11" => reg_dAdr <= c_reg_X;
															when others => NULL; -- for simulation
														end case; 
														reg_dWData <= reg_rRData - 1;
														proc_state <= NextInstr;
												end case; --step
											when "1100" => -- ld X (DONE)
												reg_dAdr <= loc_Rd5;
												reg_rAdr <= c_reg_X;
												ext_DM_Areal <= reg_rRData;
												reg_dWData(7 downto 0) <= ext_Drd;
												case step(1 downto 0) is
													when "00" => -- wait on reg data
													when "01" => -- start sram read
														ext_rd <= '1';
													when "10" => -- wait on sram data
													when others => -- set pc and done
														reg_dWE_b <= '1';
														proc_state <= NextInstr;
												end case; --step
											when "0100" => -- lpm Z (DONE)
												reg_rAdr <= c_reg_Z; -- Z
												proc_state <= HandleLpmZ;
												step <= (others => '0');
											when "0101" => -- lpm Z+ (DONE)
												reg_rAdr <= c_reg_Z; -- Z
												proc_state <= HandleLpmZPlus;
												step <= (others => '0');
											when "1111" => -- pop (DONE)
												reg_dAdr <= loc_Rd5;
												ext_DM_Areal <= reg_sp + 1;
												reg_dWData(7 downto 0) <= ext_Drd;
												case step(1 downto 0) is
													when "00" => -- wait on adr
													when "01" => -- do read
														ext_rd <= '1';
													when "10" => -- wait on data
													when others => -- set reg, update sp and done
														reg_dWE_b <= '1';
														reg_sp <= reg_sp + 1;
														proc_state <= NextInstr;
												end case; --step
											when others =>
												proc_state <= InstrError;
										end case; -- 3 downto 0
									when "001" => -- st, sts, push (DONE)
										case PM_Drd(3 downto 0) is
											when "0000" => -- sts (DONE)
												next_pc := reg_pc_plus_one;
												reg_pc <= next_pc(reg_pc'range);
												proc_state <= HandleSTS;
												step <= (others => '0');
											when "0001" | "1001" | "1101" => -- st Z+ Y+ X+ (DONE)
												reg_rAdr <= loc_Rd5;
												case PM_Drd(3 downto 2) is
													when "00" => reg_dAdr <= c_reg_Z;
													when "10" => reg_dAdr <= c_reg_Y;
													when "11" => reg_dAdr <= c_reg_X;
													when others => NULL; -- for simulation
												end case; 
												reg_dWData <= reg_dRData + 1;
												ext_DM_Areal <= reg_dRData;
												ext_Dwr <= reg_rData;
												case step(1 downto 0) is
													when "00" => -- wait on data
													when "01" => -- wait on data
													when others => -- store reg in sram and update XYZ with +1
														ext_wr <= '1';
														reg_dWE_w <= '1';
														proc_state <= NextInstr;
												end case; --step
											when "0010" | "1010" | "1110" => -- st -Z -Y -X (DONE)
												reg_rAdr <= loc_Rd5;
												case PM_Drd(3 downto 2) is
													when "00" => reg_dAdr <= c_reg_Z;
													when "10" => reg_dAdr <= c_reg_Y;
													when "11" => reg_dAdr <= c_reg_X;
													when others => NULL; -- for simulation
												end case; 
												reg_dWData <= reg_dRData - 1;
												ext_DM_Areal <= reg_dRData - 1;
												ext_Dwr <= reg_rData;
												case step(1 downto 0) is
													when "00" => -- wait on data
													when "01" => -- wait on data
													when others => -- store reg in sram and update XYZ with -1
														ext_wr <= '1';
														reg_dWE_w <= '1';
														proc_state <= NextInstr;
												end case; --step
											when "1100" => -- st X (DONE)
												reg_dAdr <= loc_Rd5;
												reg_rAdr <= c_reg_X;
												ext_DM_Areal <= reg_rRData;
												ext_Dwr <= reg_dData;
												reg_dWData(7 downto 0) <= ext_Drd;
												case step(1 downto 0) is
													when "00" => -- wait on data
													when "01" => -- wait on data
													when others => -- set pc and done
														ext_wr <= '1';
														proc_state <= NextInstr;
												end case; --step
											when "1111" => -- push (DONE)
												reg_dAdr <= loc_Rd5;
												ext_DM_Areal <= reg_sp;
												case step(0) is
													when '0' => NULL; -- fetch data
													when others => -- store reg, update sp and done
														ext_Dwr <= reg_dData;
														ext_wr <= '1';
														reg_sp <= reg_sp - 1;
														proc_state <= NextInstr;
												end case; --step
											when others =>
												proc_state <= InstrError;
										end case; -- 3 downto 0
									when "010" => -- *many* (DONE)
										case PM_Drd(3 downto 0) is
											when "0000" => -- com (DONE)
												reg_dAdr <= loc_Rd5;
												case step(1 downto 0) is
													when "00" => NULL; -- fetch data
													when "01" => -- Do calc
														reg_dWData(7 downto 0) <= X"FF" - reg_dData;
														reg_dWE_b <= '1';
													when others => -- set flags and done
														reg_sreg(c_sreg_s) <= loc_std_n_flag;
														reg_sreg(c_sreg_v) <= '0';
														reg_sreg(c_sreg_n) <= loc_std_n_flag;
														reg_sreg(c_sreg_z) <= loc_std_z_flag;
														reg_sreg(c_sreg_c) <= '1';
														proc_state <= NextInstr;
												end case; --step
											when "0001" => -- neg (DONE)
												reg_dAdr <= loc_Rd5;
												case step(1 downto 0) is
													when "00" => NULL; -- fetch data
													when "01" => -- Do calc
														reg_dWData(7 downto 0) <= X"00" - reg_dData;
														reg_dWE_b <= '1';
													when others => -- set flags and done
														reg_sreg(c_sreg_h) <= reg_dWData(3) or reg_dData_d(3);
														if (reg_dWdata(7 downto 0) = "10000000") then
															reg_sreg(c_sreg_v) <= '1';
															reg_sreg(c_sreg_s) <= not loc_std_n_flag;
														else
															reg_sreg(c_sreg_v) <= '0';
															reg_sreg(c_sreg_s) <= loc_std_n_flag;
														end if;
														reg_sreg(c_sreg_n) <= loc_std_n_flag;
														reg_sreg(c_sreg_z) <= loc_std_z_flag;
														if (reg_dWdata(7 downto 0) = "00000000") then
															reg_sreg(c_sreg_c) <= '0';
														else
															reg_sreg(c_sreg_c) <= '1';
														end if;
														proc_state <= NextInstr;
												end case; --step
											when "0010" => -- swap (DONE)
												reg_dAdr <= loc_Rd5;
												case step(1 downto 0) is
													when "00" => NULL; -- fetch data
													when "01" => -- Do calc
														reg_dWData(7 downto 0) <= reg_dData(3 downto 0) & reg_dData(7 downto 4);
														reg_dWE_b <= '1';
													when others => -- set flags and done
														proc_state <= NextInstr;
												end case; --step
											when "0011" => -- inc (DONE)
												reg_dAdr <= loc_Rd5;
												case step(1 downto 0) is
													when "00" => NULL; -- fetch data
													when "01" => -- Do calc
														reg_dWData(7 downto 0) <= reg_dData + 1;
														reg_dWE_b <= '1';
													when others => -- set flags and done
														if (reg_dWdata(7 downto 0) = "10000000") then
															reg_sreg(c_sreg_v) <= '1';
															reg_sreg(c_sreg_s) <= not loc_std_n_flag;
														else
															reg_sreg(c_sreg_v) <= '0';
															reg_sreg(c_sreg_s) <= loc_std_n_flag;
														end if;
														reg_sreg(c_sreg_n) <= loc_std_n_flag;
														reg_sreg(c_sreg_z) <= loc_std_z_flag;
														proc_state <= NextInstr;
												end case; --step
											when "0101" => -- asr (DONE)
												reg_dAdr <= loc_Rd5;
												case step(1 downto 0) is
													when "00" => NULL; -- fetch data
													when "01" => -- Do calc
														reg_dWData(7 downto 0) <= reg_dData(7)&(reg_dData(7 downto 1));
														reg_dWE_b <= '1';
														reg_sreg(c_sreg_c) <= reg_dData(0);
													when others => -- set flags and done
														reg_sreg(c_sreg_v) <= loc_std_n_flag xor reg_sreg(c_sreg_c);
														reg_sreg(c_sreg_s) <= loc_std_n_flag xor loc_std_n_flag xor reg_sreg(c_sreg_c);
														reg_sreg(c_sreg_n) <= loc_std_n_flag;
														reg_sreg(c_sreg_z) <= loc_std_z_flag;
														proc_state <= NextInstr;
												end case; --step
											when "0110" => -- lsr (DONE)
												reg_dAdr <= loc_Rd5;
												case step(1 downto 0) is
													when "00" => NULL; -- fetch data
													when "01" => -- Do calc
														reg_dWData(7 downto 0) <= '0'&(reg_dData(7 downto 1));
														reg_dWE_b <= '1';
														reg_sreg(c_sreg_c) <= reg_dData(0);
													when others => -- set flags and done
														reg_sreg(c_sreg_v) <= loc_std_n_flag xor reg_sreg(c_sreg_c);
														reg_sreg(c_sreg_s) <= loc_std_n_flag xor loc_std_n_flag xor reg_sreg(c_sreg_c);
														reg_sreg(c_sreg_n) <= loc_std_n_flag;
														reg_sreg(c_sreg_z) <= loc_std_z_flag;
														proc_state <= NextInstr;
												end case; --step
											when "0111" => -- ror (DONE)
												reg_dAdr <= loc_Rd5;
												case step(1 downto 0) is
													when "00" => NULL; -- fetch data
													when "01" => -- Do calc
														reg_dWData(7 downto 0) <= reg_sreg(c_sreg_c)&(reg_dData(7 downto 1));
														reg_dWE_b <= '1';
														reg_sreg(c_sreg_c) <= reg_dData(0);
													when others => -- set flags and done
														reg_sreg(c_sreg_v) <= loc_std_n_flag xor reg_sreg(c_sreg_c);
														reg_sreg(c_sreg_s) <= loc_std_n_flag xor loc_std_n_flag xor reg_sreg(c_sreg_c);
														reg_sreg(c_sreg_n) <= loc_std_n_flag;
														reg_sreg(c_sreg_z) <= loc_std_z_flag;
														proc_state <= NextInstr;
												end case; --step
											when "1000" => -- *many* ("DONE") bset, bclr, ret, reti, sleep, wdr, lpm, spm
												case PM_Drd(8 downto 7) is
													when "00" => -- bset (DONE)
														proc_state <= NextInstr;
														reg_sreg(CONV_INTEGER(loc_s3)) <= '1';
													when "01" => -- bclr (DONE)
														proc_state <= NextInstr;
														reg_sreg(CONV_INTEGER(loc_s3)) <= '0';
													when "10" => -- ret, reti (DONE)
														if (PM_Drd(6 downto 5) = "00") then
															ext_DM_Areal <= reg_sp + 1;
															case step(1 downto 0) is
																when "00" => -- wait and set adr for pc(high)
																	reg_sp <= reg_sp + 1;
																	ext_rd <= '1';
																when "01" => -- wait and set adr for pc(low)
																	reg_sp <= reg_sp + 1;
																	ext_rd <= '1';
																when "10" => -- wait, fetch data pc(high)
																when others => -- set pc and done
																	next_pc := ext_Drd_d & ext_Drd; -- ext_Drd_d now has pc(high) from stack and ext_Drd has pc(low)
																	reg_pc <= next_pc(reg_pc'range);
																	if (PM_Drd(4) = '1') then -- reti
																		reg_sreg(c_sreg_i) <= '1';
																	end if;
																	proc_state <= WaitForInstr;
															end case; --step
														else
															proc_state <= InstrError;
														end if;
													when "11" => -- sleep, wdr, lpm, spm ("DONE")
														case PM_Drd(6 downto 4) is
															when "000" => -- sleep ("DONE")
																proc_state <= InstrError;
															when "010" => -- wdr ("DONE")
																proc_state <= InstrError;
															when "100" => -- lpm R0<-Z (DONE)
																reg_rAdr <= c_reg_Z; -- Z
																--PM_Adr <= reg_dRData;
																proc_state <= HandleLpmR0Z;
																step <= (others => '0');
															when "110" => -- spm ("DONE")
																proc_state <= InstrError;
															when others =>
																proc_state <= InstrError;
														end case; -- 6 downto 4
													when others => NULL; -- for simulation
												end case; -- 8 downto 7
											when "1001" => -- ijmp, icall (DONE)
												if (PM_Drd(7 downto 4) = "0000") then
													reg_dAdr <= c_reg_Z; -- Z
													if (PM_Drd(8) = '0') then -- ijmp (DONE)
														case step(0) is
															when '0' => NULL; -- fetch data
															when others => -- set pc and done
																next_pc := reg_dRdata;
																reg_pc <= next_pc(reg_pc'range);
																proc_state <= WaitForInstr;
														end case; --step
													else -- icall (DONE)
														tmp_calc16 := reg_pc_plus_one; -- next instruction
														ext_DM_Areal <= reg_sp;
														case step(1 downto 0) is
															when "00" => -- fetch data and store pc(low)
																ext_Dwr <= tmp_calc16(7 downto 0);
																ext_wr <= '1';
																reg_sp <= reg_sp - 1;
															when "01" => -- fetch data and store pc(high)
																ext_Dwr <= tmp_calc16(15 downto 8);
																ext_wr <= '1';
																reg_sp <= reg_sp - 1;
															when others => -- set pc, update sp and done
																next_pc := reg_dRdata;
																reg_pc <= next_pc(reg_pc'range);
																proc_state <= WaitForInstr;
														end case; --step
													end if;
												else
													proc_state <= InstrError;
												end if;
											when "1010" => -- dec (DONE)
												reg_dAdr <= loc_Rd5;
												case step(1 downto 0) is
													when "00" => NULL; -- fetch data
													when "01" => -- Do calc
														reg_dWData(7 downto 0) <= reg_dData - 1;
														reg_dWE_b <= '1';
													when others => -- set flags and done
														if (reg_dWdata(7 downto 0) = "01111111") then
															reg_sreg(c_sreg_v) <= '1';
															reg_sreg(c_sreg_s) <= not loc_std_n_flag;
														else
															reg_sreg(c_sreg_v) <= '0';
															reg_sreg(c_sreg_s) <= loc_std_n_flag;
														end if;
														reg_sreg(c_sreg_n) <= loc_std_n_flag;
														reg_sreg(c_sreg_z) <= loc_std_z_flag;
														proc_state <= NextInstr;
												end case; --step
											--when "1100"|"1101" => -- jmp (DONE)
											--	-- this instruction isn't available in tiny261/461/861
											--	proc_state <= HandleFarJmp;
											--	step <= (others => '0');
											--	reg_pc <= reg_pc_plus_one;
											--when "1110"|"1111" => -- call (DONE)
											--	-- this instruction isn't available in tiny261/461/861
											--	proc_state <= HandleFarCall;
											--	step <= (others => '0');
											--	reg_pc <= reg_pc_plus_one;
											when others =>
												proc_state <= InstrError;
										end case; -- 3 downto 0
									when "011" => -- adiw, sbiw (DONE)
										if (PM_Drd(8) = '0') then -- adiw (DONE)
											reg_dAdr <= "11" & loc_Rd2 & '0';
											case step(1 downto 0) is
												when "00" => NULL; -- fetch data
												when "01" => -- Do calc
													tmp_calc16 := (others => '0');
													tmp_calc16(loc_k6'range) := loc_k6;
													reg_dWData <= reg_dRData + tmp_calc16;
													reg_dWE_w <= '1';
												when others => -- set flags and done
													if (reg_dWdata = X"0000") then
														reg_sreg(c_sreg_z) <= '1';
													else
														reg_sreg(c_sreg_z) <= '0';
													end if;
													reg_sreg(c_sreg_n) <= reg_dWData(15);
													reg_sreg(c_sreg_v) <= (not reg_dRData_d(15)) and reg_dWData(15);
													reg_sreg(c_sreg_s) <= reg_dWData(15) xor ((not reg_dRData_d(15)) and reg_dWData(15));
													reg_sreg(c_sreg_c) <= (not reg_dWData(15)) and reg_dRData_d(15);
													proc_state <= NextInstr;
											end case; --step
										else -- sbiw (DONE)
											reg_dAdr <= "11" & loc_Rd2 & '0';
											case step(1 downto 0) is
												when "00" => NULL; -- fetch data
												when "01" => -- Do calc
													tmp_calc16 := (others => '0');
													tmp_calc16(loc_k6'range) := loc_k6;
													reg_dWData <= reg_dRData - tmp_calc16;
													reg_dWE_w <= '1';
												when others => -- set flags and done
													if (reg_dWdata = X"0000") then
														reg_sreg(c_sreg_z) <= '1';
													else
														reg_sreg(c_sreg_z) <= '0';
													end if;
													reg_sreg(c_sreg_n) <= reg_dWData(15);
													reg_sreg(c_sreg_v) <= reg_dRData_d(15) and (not reg_dWData(15));
													reg_sreg(c_sreg_s) <= reg_dWData(15) xor (reg_dRData_d(15) and (not reg_dWData(15)));
													reg_sreg(c_sreg_c) <= reg_dWData(15) and (not reg_dRData_d(15));
													proc_state <= NextInstr;
											end case; --step
										end if;
									when "100" => -- cbi, sbic (DONE)
										if (PM_Drd(8) = '0') then -- cbi (DONE)
											ext_DM_Areal <= X"0020" + loc_A5;
											ext_Dwr <= ext_Drd;
											ext_Dwr(CONV_INTEGER(loc_b3)) <= '0';
											case step(1 downto 0) is
												when "00" => NULL; -- fetch data
													ext_rd <= '1';
												when "01" => -- Wait for data
												when others => -- Do store
													ext_wr <= '1';
													proc_state <= NextInstr;
											end case; --step
										else -- sbic (DONE)
											ext_DM_Areal <= X"0020" + loc_A5;
											case step(1 downto 0) is
												when "00" => NULL; -- fetch data
													ext_rd <= '1';
												when "01" => -- Wait for data
												when others => -- Do store
													if (ext_Drd(CONV_INTEGER(loc_b3)) = '0') then
														skip_next_instr <= '1';
													end if;
													proc_state <= NextInstr;
											end case; --step
										end if;
									when "101" => -- sbi, sbis (DONE)
										if (PM_Drd(8) = '0') then -- sbi (DONE)
											ext_DM_Areal <= X"0020" + loc_A5;
											ext_Dwr <= ext_Drd;
											ext_Dwr(CONV_INTEGER(loc_b3)) <= '1';
											case step(1 downto 0) is
												when "00" => NULL; -- fetch data
													ext_rd <= '1';
												when "01" => -- Wait for data
												when others => -- Do store
													ext_wr <= '1';
													proc_state <= NextInstr;
											end case; --step
										else -- sbis (DONE)
											ext_DM_Areal <= X"0020" + loc_A5;
											case step(1 downto 0) is
												when "00" => NULL; -- fetch data
													ext_rd <= '1';
												when "01" => -- Wait for data
												when others => -- Do store
													if (ext_Drd(CONV_INTEGER(loc_b3)) = '1') then
														skip_next_instr <= '1';
													end if;
													proc_state <= NextInstr;
											end case; --step
										end if;
									when others =>
										proc_state <= InstrError;
								end case; -- 11 downto 9

							when "1011" => -- in, out (DONE)
								if (PM_Drd(11) = '0') then -- in (DONE)
									reg_dAdr <= loc_Rd5;
									ext_DM_Areal <= X"0020" + loc_A6;
									reg_dWData(7 downto 0) <= ext_Drd;
									case step(1 downto 0) is
										when "00" => NULL; -- wait for io data
											ext_rd <= '1';
										when "01" => -- Wait for data
										when others => -- Do store
											reg_dWE_b <= '1';
											proc_state <= NextInstr;
									end case; --step
								else -- out (DONE)
									reg_dAdr <= loc_Rd5;
									ext_DM_Areal <= X"0020" + loc_A6;
									ext_Dwr <= reg_dData;
									case step(1 downto 0) is
										when "00" => NULL; -- fetch data
										when "01" => -- Wait for data
										when others => -- Do store
											ext_wr <= '1';
											proc_state <= NextInstr;
									end case; --step
								end if;

							when "1100" => -- rjmp (DONE)
								tmp_calc16 := loc_k12(11)&loc_k12(11)&loc_k12(11)&loc_k12(11) & loc_k12; -- sign extend
								next_pc := reg_pc_plus_one + tmp_calc16;
								reg_pc <= next_pc(reg_pc'range);
								proc_state <= WaitForInstr;

							when "1101" => -- rcall (DONE)
								tmp_calc16 := reg_pc_plus_one; -- next instruction
								ext_DM_Areal <= reg_sp;
								case step(1 downto 0) is
									when "00" => -- store pc(low)
										ext_Dwr <= tmp_calc16(7 downto 0);
										ext_wr <= '1';
										reg_sp <= reg_sp - 1;
									when "01" => -- store pc(high)
										ext_Dwr <= tmp_calc16(15 downto 8);
										ext_wr <= '1';
										reg_sp <= reg_sp - 1;
									when others => -- set pc, update sp and done
										tmp_calc16 := loc_k12(11)&loc_k12(11)&loc_k12(11)&loc_k12(11) & loc_k12; -- sign extend
										next_pc := reg_pc_plus_one + tmp_calc16;
										reg_pc <= next_pc(reg_pc'range);
										proc_state <= WaitForInstr;
								end case; --step

							when "1110" => -- ldi (DONE)
								reg_dWData(7 downto 0) <= loc_k8;
								reg_dAdr <= '1' & loc_Rd4; -- only reg 16-31 could be written
								reg_dWE_b <= '1';
								proc_state <= NextInstr;

							when "1111" => -- brbs, brbc, bld, bst, sbrc, sbrs (DONE)
								if (PM_Drd(11) = '0') then -- brbs, brbc (DONE)
									proc_state <= NextInstr;
									if (PM_Drd(10) = '0') then -- brbs (DONE)
										if (reg_sreg(CONV_INTEGER(loc_b3)) = '1') then
											for i in tmp_calc16'high downto (loc_k7'high+1) loop
												tmp_calc16(i) := loc_k7(loc_k7'high); -- sign extend
											end loop;
											tmp_calc16(loc_k7'range) := loc_k7;
											next_pc := reg_pc_plus_one + tmp_calc16;
											reg_pc <= next_pc(reg_pc'range);
											proc_state <= WaitForInstr;
										end if;
									else -- brbc (DONE)
										if (reg_sreg(CONV_INTEGER(loc_b3)) = '0') then
											for i in tmp_calc16'high downto (loc_k7'high+1) loop
												tmp_calc16(i) := loc_k7(loc_k7'high); -- sign extend
											end loop;
											tmp_calc16(loc_k7'range) := loc_k7;
											next_pc := reg_pc_plus_one + tmp_calc16;
											reg_pc <= next_pc(reg_pc'range);
											proc_state <= WaitForInstr;
										end if;
									end if;
								elsif (PM_Drd(3) = '0') then -- bld, bst, sbrc, sbrs (DONE)
									case PM_Drd(10 downto 9) is
										when "00" => -- bld
											reg_dAdr <= loc_Rd5;
											case step(0) is
												when '0' => NULL; -- fetch data
												when others => -- set bit and done
													reg_dWData(7 downto 0) <= reg_dData;
													reg_dWData(CONV_INTEGER(loc_b3)) <= reg_sreg(c_sreg_t);
													reg_dWE_b <= '1';
													proc_state <= NextInstr;
											end case; --step
										when "01" => -- bst
											reg_dAdr <= loc_Rd5;
											case step(0) is
												when '0' => NULL; -- fetch data
												when others => -- set bit and done
													reg_sreg(c_sreg_t) <= reg_dData(CONV_INTEGER(loc_b3));
													proc_state <= NextInstr;
											end case; --step
										when "10" => -- sbrc
											reg_dAdr <= loc_Rd5;
											if (step(0) = '0') then
												NULL; -- fetch data
											else -- compare data
												proc_state <= NextInstr;
												if (reg_dData(CONV_INTEGER(loc_b3)) = '0') then
													skip_next_instr <= '1';
												end if; -- eq?
											end if; --step
										when "11" => -- sbrs
											reg_dAdr <= loc_Rd5;
											if (step(0) = '0') then
												NULL; -- fetch data
											else -- compare data
												proc_state <= NextInstr;
												if (reg_dData(CONV_INTEGER(loc_b3)) = '1') then
													skip_next_instr <= '1';
												end if; -- eq?
											end if; --step
										when others => NULL; -- for simulation
									end case; -- 10 downto 9
								else
									proc_state <= InstrError;
								end if;

							when others => NULL; -- for simulation
						end case; --15 downto 12
					
					-- Handle LDS instruction
					when HandleLDS => -- (DONE)
						step <= step + 1;
						reg_dAdr <= loc_Rd5_locked;
						ext_DM_Areal <= PM_Drd;
						case step(1 downto 0) is
							when "00" => NULL; -- wait on reg data
							when "01" => -- fetch data
								ext_rd <= '1';
							when "10" => -- wait for data
							when others => -- set reg and done
								reg_dWData(7 downto 0) <= ext_Drd;
								reg_dWE_b <= '1';
								proc_state <= NextInstr;
						end case; --step
					
					-- Handle STS instruction
					when HandleSTS => -- (DONE)
						step <= step + 1;
						reg_dAdr <= loc_Rd5_locked;
						case step(0) is
							when '0' => -- fetch data
							when others => -- store data and done
								ext_DM_Areal <= PM_Drd;
								ext_Dwr <= reg_dData;
								ext_wr <= '1';
								proc_state <= NextInstr;
						end case; --step
					
					-- Handle LPM R0,Z
					when HandleLpmR0Z => -- (DONE)
						step <= step + 1;
						reg_rAdr <= c_reg_Z;
						reg_dAdr <= c_reg_R0;
						case step(0) is
							when '0' => NULL; -- wait for PM_Drd
							when others => -- store data and done
								reg_dWE_b <= '1';
								if (reg_rRData(0) = '0') then
									reg_dWData(7 downto 0) <= PM_Drd(7 downto 0);
								else
									reg_dWData(7 downto 0) <= PM_Drd(15 downto 8);
								end if;
								proc_state <= NextInstr;
						end case; --step
					
					-- Handle LPM Z
					when HandleLpmZ => -- (DONE)
						step <= step + 1;
						reg_rAdr <= c_reg_Z;
						reg_dAdr <= loc_Rd5_locked;
						case step(0) is
							when '0' => NULL; -- wait for PM_Drd
							when others => -- store data and done
								reg_dWE_b <= '1';
								if (reg_rRData(0) = '0') then
									reg_dWData(7 downto 0) <= PM_Drd(7 downto 0);
								else
									reg_dWData(7 downto 0) <= PM_Drd(15 downto 8);
								end if;
								proc_state <= NextInstr;
						end case; --step
					
					-- Handle LPM Z+
					when HandleLpmZPlus => -- (DONE)
						step <= step + 1;
						reg_rAdr <= c_reg_Z;
						reg_dAdr <= loc_Rd5_locked;
						if (reg_rRData(0) = '0') then
							reg_dWData(7 downto 0) <= PM_Drd(7 downto 0);
						else
							reg_dWData(7 downto 0) <= PM_Drd(15 downto 8);
						end if;
						case step(1 downto 0) is
							when "00" => NULL; -- wait for PM_Drd
							when "01" => -- store data
								reg_dWE_b <= '1';
							when others => -- update Z and done
								reg_dAdr <= c_reg_Z;
								reg_dWData <= reg_rRData + 1;
								reg_dWE_w <= '1';
								proc_state <= NextInstr;
						end case; --step
					
					-- Handle far jmp (DONE)
					--when HandleFarJmp =>
					--	-- this instruction isn't available in tiny261/461/861
					--	reg_dAdr <= c_reg_Z; -- Z
					--	step <= step + 1;
					--	case step(0) is
					--		when '0' => NULL; -- fetch data
					--		when others => -- set pc and done
					--			reg_pc <= PM_Drd;
					--			proc_state <= WaitForInstr;
					--	end case; --step
						
					-- Handle far call (DONE)
					--when HandleFarCall =>
					--	--	-- this instruction isn't available in tiny261/461/861
					--	tmp_calc16 := reg_pc_plus_one; -- next instruction
					--	ext_DM_Areal <= reg_sp;
					--	step <= step + 1;
					--	case step(1 downto 0) is
					--		when "00" => -- fetch data and store pc(low)
					--			ext_Dwr <= tmp_calc16(7 downto 0);
					--			ext_wr <= '1';
					--			reg_sp <= reg_sp - 1;
					--		when "01" => -- fetch data and store pc(high)
					--			ext_Dwr <= tmp_calc16(15 downto 8);
					--			ext_wr <= '1';
					--			reg_sp <= reg_sp - 1;
					--		when others => -- set pc, update sp and done
					--			reg_pc <= PM_Drd;
					--			proc_state <= WaitForInstr;
					--	end case; --step
               
					-- Handle error
					when InstrError =>
						-- Just hang here for now.
						OT_InstrErr	<= '1';
						-- TODO
						
					when others =>
						NULL; -- Just hang here for now.
						OT_InstrErr	<= '1';
						-- TODO
						--proc_state <= Reset;
				end case; --proc_state
			end if; -- Rst / En
		end if; -- clk
	end process processin_proc;
------------------------------------------------------------------------------
end architecture Beh;
