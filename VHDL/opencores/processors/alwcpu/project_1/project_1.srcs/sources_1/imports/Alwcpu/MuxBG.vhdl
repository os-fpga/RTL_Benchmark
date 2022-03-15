------------------------------------------------------------------------------
--
-- Written by: Andreas Hilvarsson, avmcu ¤ opencores.org (www.syntera.se)
-- Project...: Alwcpu66
--
-- Purpose:
-- Multiplexers and other stuff in cpu
--
------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library Work;
use Work.Global_Constants_Pkg.ALL;

------------------------------------------------------------------------------
entity MuxBG is
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
end MuxBG;
------------------------------------------------------------------------------
architecture Beh of MuxBG is
------------------------------------------------------------------------------
	-- Hold registers
	signal Instr_l	: std_logic_vector(15 downto 0);
	signal Imm_l	: std_logic_vector(15 downto 0);
	signal DH_l		: std_logic_vector(7 downto 0);
------------------------------------------------------------------------------
begin
------------------------------------------------------------------------------
	-- Aout mux
	WB_Adr <= RegMrdD when (AoutMuxCtrl=C_AoutMux_Mmux) else Imm_l;
------------------------------------------------------------------------------
	-- Instruction hold
	Instr_l <= DataIn when (Clk'event and Clk='1' and LoadInstr=C_LoadInstr_Now) else Instr_l;
	Instr <= Instr_l;
------------------------------------------------------------------------------
	-- Immediate data
	Imm_l	<= DH_l & Instr_l(7 downto 0);
	Imm <= Imm_l;
------------------------------------------------------------------------------
	-- In mux for reg write
	rwdp: process(InMuxCtrl, DataIn, Imm_l, AluD)
	begin
		case (InMuxCtrl) is
			when C_InMux_ALU	=> RegWeD <= AluD;
			when C_InMux_Imm	=> RegWeD <= Imm_l;
			when C_InMux_Din	=> RegWeD <= DataIn;
			when others			=> RegWeD <= AluD;
		end case;
	end process rwdp;
------------------------------------------------------------------------------
	-- Data hold process
	dhp: process (Clk, Rst)
	begin
		if (Clk'event and Clk='1') then
			if (Rst='1') then
				DH_l <= (OTHERS=>'0');
			else
				if (LoadDH=C_LoadDH_Now) then
					DH_l <= Instr_l(11 downto 4);
				elsif (SignExtendDH=C_SignExtendDH_Now) then
					for i in DH_l'high downto DH_l'low loop
						DH_l(i) <= Instr_l(7); -- Sign extend
					end loop;
				end if;
			end if; -- Rst
		end if; -- Clk
	end process dhp;
------------------------------------------------------------------------------
	-- Bit gen block
	bgp: process(BitGenBit, BitGenInv)
		variable BitGenDraw : std_logic_vector(15 downto 0);
		constant C_allone : std_logic_vector(15 downto 0) := (OTHERS=>'1');
	begin
		BitGenDraw := (OTHERS=>'0');
		case (BitGenBit) is
			when "0000" => BitGenDraw(0) := '1';
			when "0001" => BitGenDraw(1) := '1';
			when "0010" => BitGenDraw(2) := '1';
			when "0011" => BitGenDraw(3) := '1';
			when "0100" => BitGenDraw(4) := '1';
			when "0101" => BitGenDraw(5) := '1';
			when "0110" => BitGenDraw(6) := '1';
			when "0111" => BitGenDraw(7) := '1';
			when "1000" => BitGenDraw(8) := '1';
			when "1001" => BitGenDraw(9) := '1';
			when "1010" => BitGenDraw(10) := '1';
			when "1011" => BitGenDraw(11) := '1';
			when "1100" => BitGenDraw(12) := '1';
			when "1101" => BitGenDraw(13) := '1';
			when "1110" => BitGenDraw(14) := '1';
			when "1111" => BitGenDraw(15) := '1';
			when others => BitGenDraw(0) := '1';
		end case;
		if (BitGenInv='0') then
			BitGenD <= BitGenDraw;
		else
			BitGenD <= BitGenDraw xor C_allone;
		end if;
	end process bgp;
------------------------------------------------------------------------------
end architecture Beh;
------------------------------------------------------------------------------
