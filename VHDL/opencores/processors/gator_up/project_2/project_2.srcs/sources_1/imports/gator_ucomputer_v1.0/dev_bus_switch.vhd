--==========================> Gator uProccessor <===========================--
-- DEV_BUS_SWITCH.VHD	
-- Engineer:	Kevin Phillipson
-- Date:		04/22/2007									Revision:02.04.08
-- Description: 
--
--==========================================================================--
library ieee;
use ieee.std_logic_1164.all;

--================================> Port Map <==============================--
--
entity dev_bus_switch is
port 
(
	----------------------------------------> Inputs
	--
	sync				:	in	std_logic;
	ext_irq				:	in  std_logic;
	sci_irq				:	in  std_logic;

	dev_rd_en			:	in  std_logic;
	dev_wr_en			:	in  std_logic;

	addr_bus			:	in	std_logic_vector( 5 downto  0);

	io_porta_rd_db		:	in	std_logic_vector( 7 downto  0);
	io_ddra_rd_db		:	in	std_logic_vector( 7 downto  0);
	io_portb_rd_db		:	in	std_logic_vector( 7 downto  0);
	io_ddrb_rd_db		:	in	std_logic_vector( 7 downto  0);

	l7seg1_rd_db		:	in	std_logic_vector( 7 downto  0);
	l7seg0_rd_db		:	in	std_logic_vector( 7 downto  0);
	lledsw_rd_db		:	in	std_logic_vector( 7 downto  0);
	r7seg1_rd_db		:	in	std_logic_vector( 7 downto  0);
	r7seg0_rd_db		:	in	std_logic_vector( 7 downto  0);
	rledsw_rd_db		:	in	std_logic_vector( 7 downto  0);

	sci_sccr1_rd_db		:	in	std_logic_vector( 7 downto  0);
	sci_sccr2_rd_db		:	in	std_logic_vector( 7 downto  0);
	sci_baud_rd_db		:	in	std_logic_vector( 7 downto  0);
	sci_cpbh_rd_db		:	in	std_logic_vector( 7 downto  0);
	sci_cpbl_rd_db		:	in	std_logic_vector( 7 downto  0);
	sci_scdr_rd_db		:	in	std_logic_vector( 7 downto  0);
	sci_scsr_rd_db		:	in	std_logic_vector( 7 downto  0);
	
	hprio_rd_db			:	in	std_logic_vector( 7 downto  0);
	--
	----------------------------------------< 

	----------------------------------------> Outputs
	--
	io_porta_wr_en		:	out	std_logic;
	io_ddra_wr_en		:	out	std_logic;
	io_portb_wr_en		:	out	std_logic;
	io_ddrb_wr_en		:	out	std_logic;

	l7seg1_wr_en		:	out	std_logic;
	l7seg0_wr_en		:	out	std_logic;
	lledsw_wr_en		:	out	std_logic;
	r7seg1_wr_en		:	out	std_logic;
	r7seg0_wr_en		:	out	std_logic;
	rledsw_wr_en		:	out	std_logic;

	sci_sccr1_wr_en		:	out	std_logic;
	sci_sccr2_wr_en		:	out	std_logic;
	sci_baud_wr_en		:	out	std_logic;
	sci_cpbh_wr_en		:	out	std_logic;
	sci_cpbl_wr_en		:	out	std_logic;
	sci_scdr_rd_en		:	out	std_logic;
	sci_scdr_wr_en		:	out	std_logic;
	sci_scsr_rd_en		:	out	std_logic;	

	hprio_wr_en			:	out	std_logic;

	dev_rd_db			:	out	std_logic_vector( 7 downto  0);
	
	dev_irq				:	out	std_logic_vector(15 downto  0)
	--
	----------------------------------------< 

);
end dev_bus_switch;
--
--==========================================================================--

architecture structure of dev_bus_switch is

--=========================> Signals & Constants <==========================--
--
constant	io_porta_addr	:	std_logic_vector( 7 downto 0) := x"00";
constant	io_ddra_addr	:	std_logic_vector( 7 downto 0) := x"01";
constant	io_portb_addr	:	std_logic_vector( 7 downto 0) := x"02";
constant	io_ddrb_addr	:	std_logic_vector( 7 downto 0) := x"03";

constant	l7seg1_addr		:	std_logic_vector( 7 downto 0) := x"04";
constant	l7seg0_addr		:	std_logic_vector( 7 downto 0) := x"05";
constant	lledsw_addr		:	std_logic_vector( 7 downto 0) := x"06";
constant	r7seg1_addr		:	std_logic_vector( 7 downto 0) := x"07";
constant	r7seg0_addr		:	std_logic_vector( 7 downto 0) := x"08";
constant	rledsw_addr		:	std_logic_vector( 7 downto 0) := x"09";

constant	sci_baud_addr	:	std_logic_vector( 7 downto 0) := x"2B";
constant	sci_sccr1_addr	:	std_logic_vector( 7 downto 0) := x"2C";
constant	sci_sccr2_addr	:	std_logic_vector( 7 downto 0) := x"2D";
constant	sci_scsr_addr	:	std_logic_vector( 7 downto 0) := x"2E";
constant	sci_scdr_addr	:	std_logic_vector( 7 downto 0) := x"2F";
constant	sci_cpbh_addr	:	std_logic_vector( 7 downto 0) := x"35";
constant	sci_cpbl_addr	:	std_logic_vector( 7 downto 0) := x"36";

constant	hprio_addr		:	std_logic_vector( 7 downto 0) := x"3C";

signal		dev_addr_bus	:	std_logic_vector( 7 downto 0);
--
--==========================================================================--

begin

--============================> Architecture <==============================--
--

dev_addr_bus	<=	"00" & addr_bus;

----------------------------------------> Read Data Bus Mux
--
process
(
	dev_addr_bus,
	io_porta_rd_db,
	io_ddra_rd_db,
	io_portb_rd_db,
	io_ddrb_rd_db,
	l7seg1_rd_db,
	l7seg0_rd_db,
	lledsw_rd_db,
	r7seg1_rd_db,
	r7seg0_rd_db,
	rledsw_rd_db,
	sci_sccr1_rd_db,
	sci_sccr2_rd_db,
	sci_scdr_rd_db,
	sci_scsr_rd_db,
	sci_baud_rd_db,
	sci_cpbh_rd_db,
	sci_cpbl_rd_db,
	hprio_rd_db
)
begin

	   if	(dev_addr_bus = io_porta_addr)	then	dev_rd_db	<=	io_porta_rd_db;
	elsif	(dev_addr_bus = io_ddra_addr)	then	dev_rd_db	<=	io_ddra_rd_db;
	elsif	(dev_addr_bus = io_portb_addr)	then	dev_rd_db	<=	io_portb_rd_db;
	elsif	(dev_addr_bus = io_ddrb_addr)	then	dev_rd_db	<=	io_ddrb_rd_db;

	elsif	(dev_addr_bus = l7seg1_addr)	then	dev_rd_db	<=	l7seg1_rd_db;
	elsif	(dev_addr_bus = l7seg0_addr)	then	dev_rd_db	<=	l7seg0_rd_db;
	elsif	(dev_addr_bus = lledsw_addr)	then	dev_rd_db	<=	lledsw_rd_db;
	elsif	(dev_addr_bus = r7seg1_addr)	then	dev_rd_db	<=	r7seg1_rd_db;
	elsif	(dev_addr_bus = r7seg0_addr)	then	dev_rd_db	<=	r7seg0_rd_db;
	elsif	(dev_addr_bus = rledsw_addr)	then	dev_rd_db	<=	rledsw_rd_db;
	
	elsif	(dev_addr_bus = sci_sccr1_addr)	then	dev_rd_db	<=	sci_sccr1_rd_db;
	elsif	(dev_addr_bus = sci_sccr2_addr)	then	dev_rd_db	<=	sci_sccr2_rd_db;
	elsif	(dev_addr_bus = sci_scdr_addr)	then	dev_rd_db	<=	sci_scdr_rd_db;
	elsif	(dev_addr_bus = sci_scsr_addr)	then	dev_rd_db	<=	sci_scsr_rd_db;
	elsif	(dev_addr_bus = sci_baud_addr)	then	dev_rd_db	<=	sci_baud_rd_db;
	elsif	(dev_addr_bus = sci_cpbh_addr)	then	dev_rd_db	<=	sci_cpbh_rd_db;
	elsif	(dev_addr_bus = sci_cpbl_addr)	then	dev_rd_db	<=	sci_cpbl_rd_db;

	elsif	(dev_addr_bus = hprio_addr)		then	dev_rd_db	<=	hprio_rd_db;

	else	dev_rd_db	<=	x"00";
	end if;
	
end process;

--
----------------------------------------<

----------------------------------------> Read Enable Logic
--
sci_scdr_rd_en		<= dev_rd_en when (dev_addr_bus = sci_scdr_addr) else '0';

sci_scsr_rd_en		<= dev_rd_en when (dev_addr_bus = sci_scsr_addr) else '0';
--
----------------------------------------<

----------------------------------------> Write Enable Logic
--
io_porta_wr_en		<= dev_wr_en when (dev_addr_bus = io_porta_addr) else '0';
io_ddra_wr_en		<= dev_wr_en when (dev_addr_bus = io_ddra_addr) else '0';
io_portb_wr_en		<= dev_wr_en when (dev_addr_bus = io_portb_addr) else '0';
io_ddrb_wr_en		<= dev_wr_en when (dev_addr_bus = io_ddrb_addr) else '0';

l7seg1_wr_en		<= dev_wr_en when (dev_addr_bus = l7seg1_addr) else '0';
l7seg0_wr_en		<= dev_wr_en when (dev_addr_bus = l7seg0_addr) else '0';
lledsw_wr_en		<= dev_wr_en when (dev_addr_bus = lledsw_addr) else '0';
r7seg1_wr_en		<= dev_wr_en when (dev_addr_bus = r7seg1_addr) else '0';
r7seg0_wr_en		<= dev_wr_en when (dev_addr_bus = r7seg0_addr) else '0';
rledsw_wr_en		<= dev_wr_en when (dev_addr_bus = rledsw_addr) else '0';

sci_sccr1_wr_en		<= dev_wr_en when (dev_addr_bus = sci_sccr1_addr) else '0';
sci_sccr2_wr_en		<= dev_wr_en when (dev_addr_bus = sci_sccr2_addr) else '0';
sci_scdr_wr_en		<= dev_wr_en when (dev_addr_bus = sci_scdr_addr) else '0';
sci_baud_wr_en		<= dev_wr_en when (dev_addr_bus = sci_baud_addr) else '0';
sci_cpbh_wr_en		<= dev_wr_en when (dev_addr_bus = sci_cpbh_addr) else '0';
sci_cpbl_wr_en		<= dev_wr_en when (dev_addr_bus = sci_cpbl_addr) else '0';

hprio_wr_en			<= dev_wr_en when (dev_addr_bus = hprio_addr) else '0';
--
----------------------------------------<

dev_irq( 0)	<=	'0';		--	FFF4	xirq pin (pseudo non-maskable interrupt)
dev_irq( 1)	<=	ext_irq;	--	FFF2	irq (external pin or parallel i/o)
dev_irq( 2)	<=	'0';		--	FFF0	real time interrupt
dev_irq( 3)	<=	'0';		--	FFEE	timer input capture 1
dev_irq( 4)	<=	'0';		--	FFEC	timer input capture 2
dev_irq( 5)	<=	'0';		--	FFEA	timer input capture 3
dev_irq( 6)	<=	'0';		--	FFE8	timer output compare 1
dev_irq( 7)	<=	'0';		--	FFE6	timer output compare 2
dev_irq( 8)	<=	'0';		--	FFE4	timer output compare 3
dev_irq( 9)	<=	'0';		--	FFE2	timer output compare 4
dev_irq(10)	<=	'0';		--	FFE0	timer output compare 5
dev_irq(11)	<=	'0';		--	FFDE	timer overflow
dev_irq(12)	<=	'0';		--	FFDC	pulse accumulator overflow
dev_irq(13)	<=	'0';		--	FFDA	pulse accumulator input edge
dev_irq(14)	<=	'0';		--	FFD8	SPI serial transfer complete
dev_irq(15)	<=	sci_irq;	--	FFD6	SCI serial system

--==========================================================================--

end structure;