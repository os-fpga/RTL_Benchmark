-- IOTA Pearl Diver VHDL Port
--
-- 2018 by Thomas Pototschnig <microengineer18@gmail.com,
-- http://microengineer.eu
-- discord: pmaxuw#8292
--
-- Permission is hereby granted, free of charge, to any person obtaining
-- a copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:
-- 
-- The above copyright notice and this permission notice shall be
-- included in all copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
-- NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
-- LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
-- OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
-- WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWAR

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity de1 is
	port (
--		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_24 : in std_logic_vector (1 downto 0);
		CLOCK_27 : in std_logic_vector (1 downto 0);
		CLOCK_50 : in std_logic;
		EXT_CLOCK : in std_logic;
--		////////////////////	Push Button		////////////////////
		KEY : in std_logic_vector(3 downto 0);
--		////////////////////	DPDT Switch		////////////////////
		SW : in std_logic_vector (9 downto 0);
--		////////////////////	7-SEG Dispaly	////////////////////
		HEX0 : out std_logic_vector (6 downto 0);
		HEX1 : out std_logic_vector (6 downto 0);
		HEX2 : out std_logic_vector (6 downto 0);
		HEX3 : out std_logic_vector (6 downto 0);
--		////////////////////////	LED		////////////////////////
		LEDG : out std_logic_vector (7 downto 0);
		LEDR : out std_logic_vector (9 downto 0);
--		////////////////////////	UART	////////////////////////
		UART_TXD : out std_logic;
		UART_RXD : in std_logic;
--		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ : inout std_logic_vector (15 downto 0);
		DRAM_ADDR : out std_logic_vector (11 downto 0);
		DRAM_LDQM : out std_logic;
		DRAM_UDQM : out std_logic;
		DRAM_WE_N : out std_logic;
		DRAM_CAS_N : out std_logic;
		DRAM_RAS_N : out std_logic;
		DRAM_CS_N : out std_logic;
		DRAM_BA_0 : out std_logic;
		DRAM_BA_1 : out std_logic;
		DRAM_CLK : out std_logic;
		DRAM_CKE : out std_logic;
--		////////////////////	Flash Interface		////////////////
		FL_DQ : inout std_logic_vector (7 downto 0);
		FL_ADDR : out std_logic_vector (21 downto 0);
		FL_WE_N : out std_logic;
		FL_RST_N : out std_logic;
		FL_OE_N : out std_logic;
		FL_CE_N : out std_logic;
--		////////////////////	SRAM Interface		////////////////
		SRAM_DQ : inout std_logic_vector (15 downto 0);
		SRAM_ADDR : out std_logic_vector (17 downto 0);
		SRAM_UB_N : out std_logic;
		SRAM_LB_N : out std_logic;
		SRAM_WE_N : out std_logic;
		SRAM_CE_N : out std_logic;
		SRAM_OE_N : out std_logic;
--		////////////////////	SD_Card Interface	////////////////
		SD_DAT : inout std_logic;
		SD_DAT3 : inout std_logic;
		SD_CMD : inout std_logic;
		SD_CLK : out std_logic;
--		////////////////////	USB JTAG link	////////////////////
		TDI : in std_logic;
		TCK : in std_logic;
		TCS : in std_logic;
	    TDO : out std_logic;
--		////////////////////	I2C		////////////////////////////
		I2C_SDAT : inout std_logic;
		I2C_SCLK : out std_logic;
--		////////////////////	PS2		////////////////////////////
		PS2_DAT : in std_logic;
		PS2_CLK : in std_logic;
--		////////////////////	VGA		////////////////////////////
		VGA_HS : out std_logic;
		VGA_VS : out std_logic;
		VGA_R  : out std_logic_vector (3 downto 0);
		VGA_G: out std_logic_vector (3 downto 0);
		VGA_B: out std_logic_vector (3 downto 0);
--		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK : inout std_logic;
		AUD_ADCDAT : in std_logic;
		AUD_DACLRCK : inout std_logic;
		AUD_DACDAT : out std_logic;
		AUD_BCLK : out std_logic;
		AUD_XCK : out std_logic;
--		////////////////////	GPIO	////////////////////////////
		GPIO_0 : inout std_logic_vector (35 downto 0);
		GPIO_1 : inout std_logic_vector (35 downto 0)
	);
end;

architecture beh of de1 is


signal reset : std_logic;

signal pll_clk : std_logic;
signal pll_reset : std_logic := '0';
signal pll_locked : std_logic;

signal spi_data_tx : std_logic_vector(31 downto 0);
signal spi_data_rx  : std_logic_vector(31 downto 0);
signal spi_data_rx_en : std_logic;

signal running : std_logic := '0';
signal overflow : std_logic := '0';
signal found : std_logic := '0';

signal spi_mosi : std_logic;
signal spi_miso : std_logic;
signal spi_sck : std_logic;
signal spi_ss : std_logic;
signal pll_slow : std_logic;
component spi_slave
	port
	(
		clk : in std_logic;
		reset : in std_logic;
		
		mosi : in std_logic;
		miso : out std_logic;
		sck : in std_logic;
		ss : in std_logic;
		
		
		data_rd : in std_logic_vector(31 downto 0);
		data_wr : out std_logic_vector(31 downto 0);
		data_wren : out std_logic
	);
end component;

component pll
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC ;
		c1 : out std_logic;
		locked		: OUT STD_LOGIC 
	);
end component;

component curl
	port
	(
		clk : in std_logic;
		clk_slow : in std_logic;
		reset : in std_logic;
		
		spi_data_rx : in std_logic_vector(31 downto 0);
		spi_data_tx : out std_logic_vector(31 downto 0);
		spi_data_rxen : in std_logic;

		overflow : out std_logic;
		running : out std_logic;
		found : out std_logic
	);
end component;

begin
	pll0 : pll port map (
		areset => pll_reset,
		inclk0 => CLOCK_50,
		c0 => pll_clk,
		c1	=> pll_slow,
		locked => pll_locked
	);
	
	
	spi0 : spi_slave port map (
		clk => pll_slow,
		reset => reset,
		
		mosi => spi_mosi,
		miso => spi_miso,
		sck => spi_sck,
		ss => spi_ss,
		
		data_rd => spi_data_tx,
		data_wr => spi_data_rx,
		data_wren => spi_data_rx_en
	);
	
	curl0 : curl port map (
		clk => pll_clk,
		reset => reset,
		clk_slow => pll_slow,
		
		spi_data_rx => spi_data_rx,
		spi_data_tx => spi_data_tx,
		spi_data_rxen => spi_data_rx_en,
		
		overflow => overflow,
		running => running,
		found => found
	);
	
	
-- disable all DE1 stuff	
DRAM_DQ <= (others => 'Z');
FL_DQ <= (others => 'Z');
SRAM_DQ <= (others => 'Z');
SD_DAT <= 'Z';
I2C_SDAT <= 'Z';
GPIO_0 <= (others => 'Z');
GPIO_1 <= (others => 'Z');

LEDR <= "0" & "1" & spi_ss & spi_sck & spi_mosi & spi_miso & reset & overflow & found & running;
LEDG <= (others => '0');

AUD_BCLK <= '0';
AUD_DACLRCK <= '0';
AUD_ADCLRCK	<= '0';
AUD_XCK <= '0';

SRAM_ADDR(17)<='0';

reset <= not SW(0);

spi_mosi <= GPIO_0(0);
spi_sck <= GPIO_0(2);
spi_ss <= GPIO_0(3);

-- all pins except one is input
GPIO_0(3 downto 0) <= "ZZ" & spi_miso & "Z";


end architecture;
