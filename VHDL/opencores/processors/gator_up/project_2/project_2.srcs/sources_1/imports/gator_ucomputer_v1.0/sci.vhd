--==========================> Gator uProccessor <===========================--
-- SCI.VHD	
-- Engineer:	Kevin Phillipson / Peter Flores
-- Date:		10/10/2007									Revision:10.10.07
--
-- Description: This UART will implement the SCI of the HC11. As described in
-- the reference manual, the transmit and received channel are doudle buffered.
-- The TDRE flag is set when the TDR register is empty. The RDRF flag is set
-- when a character is ready to read from the RDR register.
--
--===============================> Change Log <=============================--
--
--	Date/Name	Description
--	10-29-07	Added functionality for OR and TC flags
--	Peter		Changed name of bpsh/bpsl to cpbh/cpbl
--				Added SCCR1 and SCCR2 registers
--				Added reset values
--
--	TODO	hook up R8, T8, M, TE, RE, IDLE, NF, FE
--
--
--==========================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

--================================> Port Map <==============================--
--
entity sci is
port 
(
	-- Inputs
	sys_rst			:	in	std_logic;
	clk				:	in	std_logic;

	sccr1_wr_en		:	in	std_logic;
	sccr2_wr_en		:	in	std_logic;
	baud_wr_en		:	in	std_logic;
	cpbh_wr_en		:	in	std_logic;
	cpbl_wr_en		:	in	std_logic;
	scdr_wr_en		:	in	std_logic;
	scdr_rd_en		:	in	std_logic;
	scsr_rd_en		:	in	std_logic;

	rxd_pin			:	in	std_logic;

	wr_data_bus		:	in	std_logic_vector( 7 downto 0);

	-- Outputs
	txd_pin			:	out	std_logic;
	
	sccr1_rd_db		:	out	std_logic_vector( 7 downto 0);
	sccr2_rd_db		:	out	std_logic_vector( 7 downto 0);
	baud_rd_db		:	out	std_logic_vector( 7 downto 0);
	cpbh_rd_db		:	out	std_logic_vector( 7 downto 0);
	cpbl_rd_db		:	out	std_logic_vector( 7 downto 0);
	scdr_rd_db		:	out	std_logic_vector( 7 downto 0);
	scsr_rd_db		:	out	std_logic_vector( 7 downto 0);

	sci_irq			:	out	std_logic
);
end sci;
--
--==========================================================================--

architecture structure of sci is

--==============================> Components <==============================--

----------------------------------------> SCI Transmit Block
--
component sci_tx
port
(
	-- Inputs
	sys_rst				:	in	std_logic;
	clk					:	in	std_logic;
	sci_clk_div			:	in	std_logic;

	tdr_wr_en			:	in	std_logic;

	wr_data_bus			:	in	std_logic_vector( 7 downto  0);
	cpb_cnt_max			:	in	std_logic_vector(15 downto  0);

	-- Outputs
	txd_pin				:	out	std_logic;
	scsr_tdre			:	out	std_logic;
	scsr_tc				:	out	std_logic
);
end component;
--
----------------------------------------<


----------------------------------------> SCI Receive Block
--
component sci_rx
port
(
	-- Inputs
	sys_rst				:	in	std_logic;
	clk					:	in	std_logic;
	sci_clk_div			:	in	std_logic;

	rxd_pin				:	in	std_logic;

	rdr_rd_en			:	in	std_logic;
	scsr_rd_en			:	in	std_logic;

	cpb_cnt_max			:	in	std_logic_vector(15 downto  0);

	-- Outputs
	scsr_rdrf			:	out std_logic;
	scsr_or				:	out std_logic;
	
	rdr_rd_db			:	out	std_logic_vector( 7 downto  0)
);
end component;
--
----------------------------------------<


--==========================================================================--

--==============================> Signals <=================================--

signal		clk_div_reg			:	std_logic;

signal		clk_div_cnt_reg		:	std_logic;			-- increasing the size of this
constant	clk_div_cnt_zero	:	std_logic	:=	'0';-- will increase baud rate divisor

signal		sccr1_t8_reg		:	std_logic;
signal		sccr1_m_reg			:	std_logic;
signal		sccr1_wake_reg		:	std_logic;

signal		sccr2_tie_reg		:	std_logic;
signal		sccr2_tcie_reg		:	std_logic;
signal		sccr2_rie_reg		:	std_logic;
signal		sccr2_ilie_reg		:	std_logic;
signal		sccr2_te_reg		:	std_logic;
signal		sccr2_re_reg		:	std_logic;
signal		sccr2_rwu_reg		:	std_logic;
signal		sccr2_sbk_reg		:	std_logic;

signal		sccr2_reg			:	std_logic_vector( 7 downto 0);

signal		baud_scp_reg		:	std_logic_vector( 1 downto 0);
signal		baud_scr_reg		:	std_logic_vector( 2 downto 0);
signal		cpbh_reg			:	std_logic_vector( 7 downto 0);
signal		cpbl_reg			:	std_logic_vector( 7 downto 0);

signal		prescaler			:	std_logic_vector( 3 downto 0);
signal		baud_vec			:	std_logic_vector(15 downto 0);
signal		baud_vec_ld			:	std_logic;

signal		scsr_tdre			:	std_logic;
signal		scsr_tc				:	std_logic;
signal		scsr_rdrf			:	std_logic;
signal		scsr_or				:	std_logic;

constant	scsr_idle			:	std_logic	:=	'0';

--==========================================================================--

begin

--==========================> Interface Logic <=============================--



with baud_scp_reg select
prescaler	<=	
				x"1"	when	"00",
				x"3"	when	"01",
				x"4"	when	"10",
				x"D"	when	others; -- "11";

with baud_scr_reg select
baud_vec	<=	
				"0000000" & prescaler & "00000"	when	"000",
				"000000" & prescaler & "000000"	when	"001",
				"00000" & prescaler & "0000000"	when	"010",
				"0000" & prescaler & "00000000"	when	"011",
				"000" & prescaler & "000000000"	when	"100",
				"00" & prescaler & "0000000000"	when	"101",
				"0" & prescaler & "00000000000"	when	"110",
				     prescaler & "000000000000"	when	others; -- "111";

process
(
	clk,
	sys_rst,
	clk_div_cnt_reg,
	wr_data_bus,
	baud_vec
)

begin

	if (clk'event and clk = '1') then
	
		if (sys_rst = '1') then
			
			----------------------------------------> Reset Values
			--
			baud_scp_reg	<=	(others => '0');
			-- baud_scr_reg	<=	(others => '0');	-- Unaffected by reset
			baud_vec_ld		<=	'0';

			-- sccr1_t8_reg	<=	'0';				-- Unaffected by reset
			sccr1_m_reg		<=	'0';
			sccr1_wake_reg	<=	'0';

			sccr2_tie_reg	<=	'0';
			sccr2_tcie_reg	<=	'0';
			sccr2_rie_reg	<=	'0';
			sccr2_ilie_reg	<=	'0';
			sccr2_te_reg	<=	'0';
			sccr2_re_reg	<=	'0';
			sccr2_rwu_reg	<=	'0';
			sccr2_sbk_reg	<=	'0';

			-- cpbh_reg		<=	(others => '0');	-- Unaffected by reset
			-- cpbl_reg		<=	(others => '0');	-- Unaffected by reset
			--
			----------------------------------------<
		
		else
		
			----------------------------------------> SCI Clock Divider Counter
			--
			-- if using a counter greater than 1 bit
			-- change the xor to a +
			clk_div_cnt_reg	<=	clk_div_cnt_reg xor '1';
			--
			----------------------------------------<

			----------------------------------------> SCI Clock Divider Signal Register
			--
			if (clk_div_cnt_reg = clk_div_cnt_zero) then
				clk_div_reg	<=	'1';
			else
				clk_div_reg	<=	'0';
			end if;	
			--
			----------------------------------------<

			----------------------------------------> SCI SCCR1 Register
			--
			if (sccr1_wr_en = '1') then
				sccr1_t8_reg	<=	wr_data_bus(6);
				sccr1_m_reg		<=	wr_data_bus(4);
				sccr1_wake_reg	<=	wr_data_bus(3);
			end if;
			--
			----------------------------------------<

			----------------------------------------> SCI SCCR2 Register
			--
			if (sccr2_wr_en = '1') then
				sccr2_tie_reg	<=	wr_data_bus(7);
				sccr2_tcie_reg	<=	wr_data_bus(6);
				sccr2_rie_reg	<=	wr_data_bus(5);
				sccr2_ilie_reg	<=	wr_data_bus(4);
				sccr2_te_reg	<=	wr_data_bus(3);
				sccr2_re_reg	<=	wr_data_bus(2);
				sccr2_rwu_reg	<=	wr_data_bus(1);
				sccr2_sbk_reg	<=	wr_data_bus(0);
			end if;
			--
			----------------------------------------<

			----------------------------------------> SCI BAUD Register
			--
			if (baud_wr_en = '1') then
				baud_scp_reg	<=	wr_data_bus( 5 downto 4 );
				baud_scr_reg	<=	wr_data_bus( 2 downto 0 );
				baud_vec_ld		<=	'1';
			else
				baud_vec_ld		<=	'0';
			end if;
			--
			----------------------------------------<

			----------------------------------------> SCI CPBL Register
			--
			if (cpbl_wr_en = '1') then
				cpbl_reg	<=	wr_data_bus;
			elsif (baud_vec_ld = '1') then
				cpbl_reg	<=	baud_vec( 7 downto 0);
			end if;
			--
			----------------------------------------<

			----------------------------------------> SCI CPBH Register
			--
			if (cpbh_wr_en = '1') then
				cpbh_reg	<=	wr_data_bus;
			elsif (baud_vec_ld = '1') then
				cpbh_reg	<=	baud_vec(15 downto 8);
			end if;
			--
			----------------------------------------<

		end if;

	end if;
		
end process;

----------------------------------------> SCI Interrupt Request Signal
--
sci_irq	<=	(scsr_tdre and sccr2_tie_reg) 	or		--	(TDRE and TIE)	or
			(scsr_tc and sccr2_tcie_reg) 	or		--	(TC and TCIE) 	or
			(scsr_rdrf and sccr2_rie_reg)	or		--	(RDRF and RIE)	or
			(scsr_or and sccr2_rie_reg) 	or		--	(OR and RIE)	or
			(scsr_idle and sccr2_ilie_reg);			--	(IDLE and ILIE)
--
----------------------------------------<

--==========================================================================--

--=======================> Component Connections <==========================--

----------------------------------------> SCI Transmit Block
--
tx_block	:	sci_tx
port map
(
	-- Inputs
	sys_rst		=>	sys_rst,
	clk			=>	clk,
	sci_clk_div	=>	clk_div_reg,
	tdr_wr_en	=>	scdr_wr_en,
	wr_data_bus	=>	wr_data_bus,
	cpb_cnt_max	=>	cpbh_reg & cpbl_reg,

	-- Outputs
	txd_pin		=>	txd_pin,
	scsr_tdre	=>	scsr_tdre,
	scsr_tc		=>	scsr_tc
);
--
----------------------------------------<

----------------------------------------> SCI Receive Block
--
rx_block	:	sci_rx
port map
(
	-- Inputs
	sys_rst		=>	sys_rst,
	clk			=>	clk,
	sci_clk_div	=>	clk_div_reg,
	rxd_pin		=>	rxd_pin,
	rdr_rd_en	=>	scdr_rd_en,
	scsr_rd_en	=>	scsr_rd_en,
	cpb_cnt_max	=>	cpbh_reg & cpbl_reg,

	-- Outputs
	scsr_rdrf	=>	scsr_rdrf,
	scsr_or		=>	scsr_or,
	rdr_rd_db	=>	scdr_rd_db

);
--
----------------------------------------<

--==========================================================================--

--==============================> Outputs <=================================--

----------------------------------------> SCCR1 Output
--

sccr1_rd_db(7)	<=	'0';			-- R8
sccr1_rd_db(6)	<=	sccr1_t8_reg;	-- T8
sccr1_rd_db(5)	<=	'0';			-- unused (0)
sccr1_rd_db(4)	<=	sccr1_m_reg;	-- M (0-eight data bits, 1-nine data bits)
sccr1_rd_db(3)	<=	sccr1_wake_reg;	-- WAKE
sccr1_rd_db(2)	<=	'0';			-- unused (0)
sccr1_rd_db(1)	<=	'0';			-- unused (0)
sccr1_rd_db(0)	<=	'0';			-- unused (0)
--
----------------------------------------<

----------------------------------------> SCCR2 Output
--
sccr2_rd_db(7)	<=	sccr2_tie_reg;	-- Transmit Interrupt Enable
sccr2_rd_db(6)	<=	sccr2_tcie_reg;	-- Transmit Complete Interrupt Enable
sccr2_rd_db(5)	<=	sccr2_rie_reg;	-- Receive Interrupt Enable
sccr2_rd_db(4)	<=	sccr2_ilie_reg;	-- Idle-Line Interrupt Enable
sccr2_rd_db(3)	<=	sccr2_te_reg;	-- Transmit Enable
sccr2_rd_db(2)	<=	sccr2_re_reg;	-- Receive Enable
sccr2_rd_db(1)	<=	sccr2_rwu_reg;	-- Receiver Wakeup
sccr2_rd_db(0)	<=	sccr2_sbk_reg;	-- Send Break
--
----------------------------------------<

----------------------------------------> SCSR Output
--
scsr_rd_db(7)	<=	scsr_tdre;	-- Transmit Data Empty
scsr_rd_db(6)	<=	scsr_tc;	-- Transmit Complete
scsr_rd_db(5)	<=	scsr_rdrf;	-- Receive Data Register Full
scsr_rd_db(4)	<=	scsr_idle;	-- Idle-Line Detect
scsr_rd_db(3)	<=	scsr_or;	-- Overrun Error
scsr_rd_db(2)	<=	'0';		-- Noise Flag
scsr_rd_db(1)	<=	'0';		-- Framing Error
scsr_rd_db(0)	<=	'0';		-- Always Zero
--
----------------------------------------<

----------------------------------------> BAUD Output
--
baud_rd_db(7)	<=	'0';				-- TCLR (Test Modes Only)
baud_rd_db(6)	<=	'0';				-- Always Zero
baud_rd_db(5)	<=	baud_scp_reg(1);	-- SCI Baud-Rate Prescale Selects
baud_rd_db(4)	<=	baud_scp_reg(0);	-- SCI Baud-Rate Prescale Selects
baud_rd_db(3)	<=	'0';				-- RCKB (Test Modes Only)
baud_rd_db(2)	<=	baud_scr_reg(2);	-- SCI Baud-Rate Selects
baud_rd_db(1)	<=	baud_scr_reg(1);	-- SCI Baud-Rate Selects
baud_rd_db(0)	<=	baud_scr_reg(0);	-- SCI Baud-Rate Selects
--
----------------------------------------<

----------------------------------------> cpbH Output
--
cpbh_rd_db	<=	cpbh_reg;
--
----------------------------------------<

----------------------------------------> cpbL Output
--
cpbl_rd_db	<=	cpbl_reg;
--
----------------------------------------<

--==========================================================================--

end structure;