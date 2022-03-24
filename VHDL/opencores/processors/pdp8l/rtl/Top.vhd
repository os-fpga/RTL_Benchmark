----------------------------------------------------------------------------------
-- Company: 
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE std.textio.all;

entity PDP8L is
      Port (  Tx_out : out STD_LOGIC;
			  Rx_in : in STD_LOGIC;
			  Clk : in STD_LOGIC;
			  Reset : in STD_LOGIC;
			  Led : out STD_LOGIC_VECTOR(3 downto 0)
			  );
--	attribute xc_loc : string; 
--	attribute xc_loc of CLK : signal is "V9"; 
--	attribute xc_loc of Reset : signal is "N2"; 
--	attribute xc_loc of Tx_out : signal is "H17";
--	attribute xc_loc of Led : signal is "H17";
end;


architecture only of PDP8L is

Component MegaRam IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
	);
END component;

Component DF32 is
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (14 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
	);
end component;

COMPONENT CpuX8
    Port ( MA : out  STD_LOGIC_VECTOR (11 downto 0);
			  MBout : out  STD_LOGIC_VECTOR (11 downto 0);
			  MBin : in  STD_LOGIC_VECTOR (11 downto 0);
			  Clk : in STD_LOGIC;
			  Rst : in STD_LOGIC;
			  Mrd : out STD_LOGIC;
			  Tty : out STD_LOGIC_VECTOR(7 downto 0);
			  Tempty : in STD_LOGIC;
			  TLoad : inout STD_LOGIC;
			  Rempty : in STD_LOGIC;
			  Rty : in STD_LOGIC_VECTOR(7 downto 0);
			  Rload :inout STD_LOGIC;
			  DMA : out  STD_LOGIC_VECTOR (14 downto 0);
			  DMBout : out  STD_LOGIC_VECTOR (11 downto 0);
			  DMBin : in  STD_LOGIC_VECTOR (11 downto 0);
			  DMrd : out STD_LOGIC
			  );
END COMPONENT ;

Component uart is
    port (
        reset       :in  std_logic;
        txclk       :in  std_logic;
        ld_tx_data  :in  std_logic;
        tx_data     :in  std_logic_vector (7 downto 0);
        tx_out      :out std_logic;
        tx_empty    :out std_logic;
        rxclk       :in  std_logic;
        uld_rx_data :in  std_logic;
        rx_data     :out std_logic_vector (7 downto 0);
        rx_in       :in  std_logic;
        rx_empty    :out std_logic
    );
end component;

component divider is
    port (
        sysclk      :in  std_logic;
        dtxclk       :out std_logic;
        drxclk       :out std_logic;
        hbt         :out STD_LOGIC_VECTOR(3 downto 0)
    );
end component;

signal Txclk : STD_LOGIC := '1';
signal Rxclk : STD_LOGIC := '1';
signal LedVal : STD_LOGIC :='0';
signal Nclk : STD_LOGIC :='0';
SIGNAL Mrq   : STD_LOGIC := '1';
SIGNAL Xty   : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL Xtf   : STD_LOGIC;
SIGNAL Xld   : STD_LOGIC;
SIGNAL Mrd   : STD_LOGIC;
SIGNAL TMA   : STD_LOGIC_VECTOR(11 downto 0);
SIGNAL TMBin   : STD_LOGIC_VECTOR(11 downto 0);
SIGNAL TMBout   : STD_LOGIC_VECTOR(11 downto 0);
SIGNAL DMrd   : STD_LOGIC;
SIGNAL DMA   : STD_LOGIC_VECTOR(14 downto 0);
SIGNAL DMBin   : STD_LOGIC_VECTOR(11 downto 0);
SIGNAL DMBout   : STD_LOGIC_VECTOR(11 downto 0);

signal        tx_empty  : std_logic;
signal        Tld_rx_data : std_logic;
signal        Trx_data   : std_logic_vector (7 downto 0);
signal        Trx_empty  : std_logic;


begin

Mem1 : MegaRam
	PORT MAP (
		TMA,
		NClk,
		TMBout,
		Mrd,
		TMBin
	);

Mem2 : DF32
	PORT MAP (
		DMA,
		NClk,
		DMBout,
		DMrd,
		DMBin
	);
			
CPU1 : CpuX8 
   PORT MAP (
		TMA,
		TMBout,
		TMBin,
		Clk,
		reset,
		Mrd,Xty,Xtf,Xld,
		Trx_empty,Trx_data,Tld_rx_data,
		DMA,
		DMBout,
		DMBin,
		DMrd
		);

UART1 : uart
  PORT MAP (
        reset,
        Txclk,
        Xld,
        Xty,
        tx_out,
        Xtf,
        Rxclk,
        Tld_rx_data,
        Trx_data,
        rx_in,
        Trx_empty
		  );
DIVIDER1 : DIVIDER
    PORT MAP (
        Clk,
        Txclk,
        Rxclk,
        LED
		  ); 
	
	Nclk<=not Clk;

end only;