------------------------------------------------------------------
--	6502 Top module.
--
--	Copyright Ian Chapman October 28 2010
--	email author@kool.kor
--	author	EQU	ichapman
--	kool	EQU	videotron
--	kor	EQU	ca
--	******************************************************
--	Dec 12 2010
--	RAM increased to 2k 0 to $7ff for bigger test code
--	sta irq and sta nmi trigger interrupts
--	******************************************************
--	This file is part of the Lattice 6502 project  
--	It is used to compile with ispLeaver not Linux ghdl.
--	It is the address mapping and connecting the other modules.
--	It is replaced by Processor.vhd when running ispLeaver.
--

--	To do
--		This will be work in process or replaced whatever
--		project file is needed to control other modules.
--
--	*************************************************************
--	Distributed under the GNU Lesser General Public License.    *
--	This can be obtained from “www.gnu.org”.                    *
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
--	Processor.vhd
------------------------------------------------------------------
--	Revision history
--	Nov 411, 2010
--	To facilitate testing of NMI and IRQ.
--	changed from I/O pins to signals
--	IRQ and NMI address decoded so as to initiated the inerupt from
------------------------------------------------------------------
library IEEE;			--Use standard IEEE libs as recommended by Tristan. 
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Processor is

Port (
--	data_wr : inout unsigned(7 downto 0);
	clk_pin : in std_logic;
--	clk_out : out std_logic;
--	u802 : out std_logic;
--	u702 : out std_logic;
--	u602 : out std_logic;
--	u1101 : out std_logic;	
--	u801 : out std_logic;
--	u701 : out std_logic;
	u601 : out std_logic;
	rst_pin : in std_logic;
--	irq_pin : in std_logic;	--disabled to test interrupts on fpga
--	nmi_pin : in std_logic;
	RX_pin	: in std_logic;
--	PG_pin	: in std_logic;
	TX_pin	: out std_logic;
	Pwr_on_pin : out std_logic
    );
end Processor;

architecture structure of Processor is

--	COMPONENT DECLARATIONS

component P65C02
port(
	data_rd: in unsigned(7 downto 0);
	data_wr: out unsigned(7 downto 0);
--	cycle_mark : out std_logic;			--Used to signal the cycle usually cycle 0.
	address: inout unsigned(15 downto 0);
	proc_write : inout std_logic;
	reset, clock : in std_logic;
	irq : in std_logic;
	nmi : in std_logic);
end component;

component UART_RX is
port(
	PG, OSC_10MHz,RX,  csr_usart :in std_logic;
	RX_rdy : out std_logic;
	rx_reg : out unsigned(7 downto 0)
	);
end component;

component UART_TX is
port(
	OSC_10MHz, PG, csw_usart :in std_logic;
	tx_dat : in unsigned(7 downto 0);
	TX ,tx_rdy : out std_logic
	);
end component;

component Lattice_rom
port (
        OutClock: in  std_logic;
        OutClockEn: in  std_logic;
        Reset: in  std_logic;
        Address: in  std_logic_vector(9 downto 0);
        Q: out  std_logic_vector(7 downto 0));
end component;

component Lattice_ram
port (
        Clock: in  std_logic;
        ClockEn: in  std_logic;
        Reset: in  std_logic;
        WE: in  std_logic;
        Address: in  std_logic_vector(10 downto 0);
        Data: in  std_logic_vector(7 downto 0);
        Q: out  std_logic_vector(7 downto 0));
end component;

--component ghdl_rom
--port	(
--	rom_dat: out unsigned(7 downto 0);
--	wr, clk, rst: in std_logic;
--	address: in unsigned(15 downto 0)
--    );
--end component;

--component ghdl_ram
--port	(
--	ram_dat: out unsigned(7 downto 0);
--	data_wr : in unsigned(7 downto 0);
--	clk, wr, rst: in std_logic;
--	address: in unsigned(15 downto 0)
--	);
--end component;


------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
signal address : unsigned(15 downto 0);
signal add : unsigned(15 downto 0);
signal proc_rd_dat, rom_dat, ram_dat, data_wr : unsigned(7 downto 0);
signal rx_dat : unsigned(7 downto 0);
signal proc_write : std_logic;
signal one, RX_rdy, csw_usart, csr_usart, tx_rdy : std_logic;
signal rst_bar : std_logic;

signal clk : std_logic;
--signal clk_pin : std_logic;
signal counter : unsigned(3 downto 0);
signal ram_write : std_logic;
signal irq_pin, nmi_pin : std_logic;

--	I/O ports
--constant	led_port	: unsigned (15 downto 0) := x"4007";
constant	irq		: unsigned (15 downto 0) := X"4002";
constant	nmi		: unsigned (15 downto 0) := x"4003";
constant	rs232_dat   : unsigned (15 downto 0) := x"4000";	--input and output
constant	uart_stat   : unsigned (15 downto 0) := x"4001";	--RX and TX state found here
constant	uart: unsigned (15 downto 0) := x"4000";	--starts the uart transmitting

begin

U1 : P65C02 port map(
	reset => rst_pin, 
	Clock => clk_pin,
	data_rd => proc_rd_dat, 
	data_wr => data_wr, 
	address => address, 
	proc_write => proc_write, 
	irq => irq_pin, 
--	cycle_mark => cycle_mark);
	nmi => nmi_pin);

	
U2 : UART_RX port map (
	PG => rst_pin, 
	OSC_10MHz => clk_pin, 
	RX => RX_pin, 
	rx_reg =>  rx_dat,
	csr_usart => csr_usart, 
	RX_rdy => RX_rdy);

U3 : UART_TX port map (
	PG => rst_pin, 
	TX => TX_pin, 
	tx_rdy => tx_rdy, 
	OSC_10MHz => clk_pin, 
	tx_dat => data_wr, 
	csw_usart => csw_usart);
		
--R1 : ghdl_rom port map(
--	rom_dat=>rom_dat,
--	address=>address,
--	wr=>proc_write,
--	clk=>clk_pin,
--	rst=>rst_pin);

--R2 : ghdl_ram port map(
--	clk=>clk_pin,
--	rst=>rst_pin,
--	ram_dat=>ram_dat,
--	data_wr=>data_wr,
--	address=>address,
--	wr=>ram_write);

--R3 : Lattice_rom port map(
--	Reset => rst_bar, 
--	OutClock => clk_pin,
--	(address(9 downto 0)) => std_logic_vector(Address(9 downto 0)),
--	unsigned(Q)  => rom_dat, 
--	OutClockEn => one);

--R4 : Lattice_ram port map(
--	Reset => rst_bar, 
--	Clock => clk_pin, 
--	WE => ram_write,
--	address(10 downto 0) => std_logic_vector(Address(10 downto 0)), 
--	Data => std_logic_vector(data_wr),
--	unsigned(Q) => ram_dat, ClockEn => one);

--	address(9 downto 0) => (Address(9 downto 0)), 
--	Data => (data_wr),
--	(Q) => ram_dat, ClockEn => one);

one <= '1';
rst_bar <= not rst_pin;
one <= '1';
--ram_write <= proc_write and not address(15) and not address(14) and not address(13) and not address(12) and not address(11) and not address(10);
--ram_write <= proc_write and not address(15) and not address(14);
--irq_pin <= '1';	--only used to test interrupts on fpga
--nmi_pin <= '1';
--u601 <= cycle_mark;



mux_add : process(rst_pin, clk_pin)
begin
if rst_pin = '0' then
add <= (others => '0');
elsif rising_edge(clk_pin) then
	add <= address;
end if;
end process;

ram_address : process (proc_write, address(15 downto 14))
begin
	if proc_write = '1' and address(15 downto 14) = "00" then
		ram_write <= '1';
	else
		ram_write <= '0';
	end if;
end process;


--	===================================================================
--	Updated muxer process
muxer : process (add(15 downto 14), rom_dat, ram_dat, rx_dat, tx_rdy, rx_rdy)
begin
if add(15 downto 14) = "11" then
	proc_rd_dat <= rom_dat;
end if;
if add(15 downto 14) = "00" then
	proc_rd_dat <= ram_dat;
end if;
if add(15 downto 0) = rs232_dat then
	proc_rd_dat <= rx_dat;
end if;
if add(15 downto 0) = uart_stat then
	proc_rd_dat <= tx_rdy & rx_rdy & "000000";
end if;
end process;
--	===================================================================

rs232_cs : process (rst_pin, clk_pin, address, proc_write)
begin
if proc_write = '0' and address = uart then
	csr_usart <= '1';	
else
	csr_usart <= '0';
end if;

if proc_write = '1' and address = uart then
	csw_usart <= '1';	
else
	csw_usart <= '0';
end if;			
end process; 
--	Only uded to test interrupts in the fpga
--	These two processe let the SW fire NMI and IRG
--	with a sta instruction.
--irq : process (rst_pin, proc_write, address, data_wr(0), clk_pin)
--begin
--if rst_pin = '0' then
	--irq_pin <= '1';
--	elsif rising_edge(clk_pin) then
--		if address = irq and proc_write = '1' then
--			irq_pin <= data_wr(0);	--set and hold bit 0
--		end if;
--end if;
--end process;

--nmi : process (rst_pin, proc_write, address, data_wr(0), clk_pin)
--begin
--if rst_pin = '0' then
--	nmi_pin <= '1';
--	elsif rising_edge(clk_pin) then
--		if address = nmi and proc_write = '1' then
--			nmi_pin <= data_wr(0);	--set and hold bit 0
--		end if;
--end if;
--end process;

--relay : process (rst_pin, proc_write, address, data_wr(7), clk_pin)
--begin
--if rst_pin = '0' then
--	Pwr_on_pin <= '0';
--	elsif rising_edge(clk_pin) and address = led_port  and proc_write = '1' then
--	Pwr_on_pin <= data_wr(7);
--end if;
--end process;


end structure;
