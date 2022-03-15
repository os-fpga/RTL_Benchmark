--=============SPI MASTER MODULE WITH FIFO=====================
-- By Diego Rosales
-- Last edited 31/01/2015
---------------------- NOTES -------------------------------
-- Some of the modules were inspired from the book
-- ++++FPGA Prototyping by VHDL examples++++
-- These modules were the mod-m counter and the FIFO
---------------------- LINKS -------------------------------
-- Book from Amazon: http://www.amazon.com/FPGA-Prototyping-VHDL-Examples-Spartan-3/dp/0470185317/ref=sr_1_6?ie=UTF8&qid=1422761365&sr=8-6&keywords=vhdl
-- My Github: https://github.com/DiegoRosales
-- My Blog: https://produccionyelectronica.blogspot.com
------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SPI_MASTER_MODULE_TX is
	GENERIC(
		POL : STD_LOGIC := '1';
		PHA : STD_LOGIC := '1';
		N : INTEGER := 8;
		SLAVES : INTEGER := 2;
		ADDRESS_WIDTH : INTEGER := 1;
		CLK_DIV_COUNT : INTEGER := 16;
		CLK_DIV_BITS : INTEGER := 4;
		FIFO_W : INTEGER := 2
	);
	PORT(
	-- To FPGA
		CLK, RESET : IN STD_LOGIC;
		START_TX: IN STD_LOGIC;
		CONT : IN STD_LOGIC;
		DATA_OUT : IN STD_LOGIC_VECTOR(N-1 downto 0);
		OUTPUT_BUFFER_FULL : OUT STD_LOGIC; -- '1' when the output FIFO is full, else '0'
		OUTPUT_BUFFER_DATA : OUT STD_LOGIC; -- '1' when de output FIFO has unsent data, else '0'
		ADDRESS : IN STD_LOGIC_VECTOR(ADDRESS_WIDTH-1 downto 0);
		BUSY : OUT STD_LOGIC;
	-- To Real World
		MOSI : OUT STD_LOGIC; -- Master Output, Slave Input
		SCLK : OUT STD_LOGIC; -- Serial Clock
		SS : OUT STD_LOGIC_VECTOR(SLAVES-1 downto 0) -- Slave Select (Chip Enable)
	);
end SPI_MASTER_MODULE_TX;

architecture Behavioral of SPI_MASTER_MODULE_TX is
--===================COMPONENT DECLARATION========================
	-- SCLK and CE generator
	COMPONENT SCLK_CE_GEN
		GENERIC(
		POL : STD_LOGIC := '1';
		N : INTEGER := 8
		);
		PORT(
			CLK, RESET : IN STD_LOGIC;
			S_TICK : IN STD_LOGIC;
			START : IN STD_LOGIC;
			SCLK : OUT STD_LOGIC;
			CE : OUT STD_LOGIC;
			BUSY : OUT STD_LOGIC;
			CONT : IN STD_LOGIC
		);
	END COMPONENT;
	
	-- TX Module
	COMPONENT SPI_MASTER_TX
	GENERIC(
		N : INTEGER := 8;
		POL : STD_LOGIC := '0';
		PHA : STD_LOGIC := '0'	
	);
	PORT(
		CLK, RESET : IN STD_LOGIC;
		SCLK : IN STD_LOGIC;
		MOSI : OUT STD_LOGIC;
		CE : IN STD_LOGIC;
		TX_START : IN STD_LOGIC;
		DATA_TX : IN STD_LOGIC_VECTOR(N-1 downto 0);
		TX_DONE : OUT STD_LOGIC;
		CONT : IN STD_LOGIC
	);
	END COMPONENT;
	
	COMPONENT mod_m_counter
	GENERIC(
		N : INTEGER := 4; -- Number of bits
		M : INTEGER := 10 -- mod-M
	);
	PORT(
		CLK, RESET : IN STD_LOGIC;
		MAX_TICK : OUT STD_LOGIC
		--Q : OUT STD_LOGIC_VECTOR(N-1 downto 0)
		);	
	END COMPONENT;
	
	COMPONENT FIFO
	GENERIC(
		B : NATURAL := 8; -- Number of bits
		W : NATURAL := 4  -- Number of address bits
	);
	PORT(
		CLK, RESET : IN STD_LOGIC;
		RD, WR : IN STD_LOGIC;
		W_DATA : IN STD_LOGIC_VECTOR(B-1 downto 0);
		EMPTY, FULL : OUT STD_LOGIC;
		R_DATA : OUT STD_LOGIC_VECTOR(B-1 downto 0)
	);
	END COMPONENT;
--===================SIGNAL DECLARATION========================
	signal start : STD_LOGIC := '0';
	signal start_tx_signal : STD_LOGIC;
	signal sclk_signal : STD_LOGIC;
	signal ce_signal : STD_LOGIC;
	signal s_tick : STD_LOGIC;	
	signal tx_done : STD_LOGIC;
	signal fifo_tx_empty, fifo_tx_not_empty : STD_LOGIC;
	signal data_tx : STD_LOGIC_VECTOR(N-1 downto 0);
	signal ss_signal : STD_LOGIC_VECTOR(SLAVES-1 downto 0);
begin

-- Component instantiation
	--=== SCLK and CE Generator ===--
	Inst_SCLK_CE_GEN: SCLK_CE_GEN 
	GENERIC MAP(
		POL => POL,
		N => N
	)	
	PORT MAP(
		CLK => CLK,
		RESET => RESET,
		S_TICK => s_tick,
		START => start,
		SCLK => sclk_signal,
		CE => ce_signal,
		BUSY => BUSY,
		CONT => CONT
	);
	
	--=== TX ===--
	Inst_SPI_MASTER_TX: SPI_MASTER_TX 
	GENERIC MAP(
		POL => POL,
		PHA => PHA,
		N => N
	)
	PORT MAP(
		CLK => CLK,
		RESET => RESET,
		SCLK => sclk_signal,
		MOSI => MOSI, --feedback, -- feedback test
		CE => ce_signal,
		TX_START => start_tx_signal,
		DATA_TX => data_tx,
		TX_DONE => tx_done,
		CONT => CONT
	);
	
	--=== TX FIFO ===--
	Inst_FIFO_TX: FIFO
	GENERIC MAP(B => N, W => FIFO_W)
	PORT MAP(
		CLK => CLK,
		RESET => RESET,	
		RD => tx_done,
		WR => START_TX,
		W_DATA => DATA_OUT,
		EMPTY => fifo_tx_empty,
		FULL => OUTPUT_BUFFER_FULL,
		R_DATA => data_tx
	);
	
	Inst_mod_m_counter: mod_m_counter
	GENERIC MAP(
		N => CLK_DIV_BITS,
		M => CLK_DIV_COUNT
	)
	PORT MAP(
		CLK => CLK,
		RESET => RESET,
		MAX_TICK => s_tick
		--Q => open
	);
	
	ss_process: PROCESS(ce_signal)
	BEGIN
		ss_signal <= (others => '1');
		ss_signal(to_integer(unsigned(ADDRESS))) <= ce_signal;
	END PROCESS;
	
	start_tx_process: PROCESS(fifo_tx_not_empty, ce_signal)
	BEGIN
		if(fifo_tx_not_empty = '1' AND ce_signal = '0') then
			start_tx_signal <= '1';
		else
			start_tx_signal <= '0';
		end if;
	END PROCESS;
	
-- Ports
	SCLK <= sclk_signal;
	SS <= ss_signal;
	OUTPUT_BUFFER_DATA <= fifo_tx_not_empty;
	
-- Signals
	start <= fifo_tx_not_empty;
	--start_tx_signal <= '1' when fifo_tx_not_empty = '1' AND ce_signal = '0' else '0';
	
	fifo_tx_not_empty <= not(fifo_tx_empty);
	
	--SS(to_integer(unsigned(ADDRESS))) <= ce_signal;
end Behavioral;

