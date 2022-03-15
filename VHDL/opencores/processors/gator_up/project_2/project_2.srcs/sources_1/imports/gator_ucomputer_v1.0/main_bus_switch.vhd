--==========================> Gator uProccessor <===========================--
-- MAIN_BUS_SWITCH.VHD	
-- Engineer:	Kevin Phillipson
-- Date:		04/22/2007									Revision:4.22.07
-- Description: 
--
--==========================================================================--
library ieee;
use ieee.std_logic_1164.all;

--================================> Port Map <==============================--
--
entity main_bus_switch is
port 
(
	----------------------------------------> Inputs
	--
	rd_en				:	in  std_logic;
	wr_en				:	in  std_logic;

	addr_bus			:	in	std_logic_vector(15 downto  0);
	wr_data_bus			:	in	std_logic_vector( 7 downto  0);

	dev_rd_db			:	in	std_logic_vector( 7 downto  0);
	ram_rd_db			:	in	std_logic_vector( 7 downto  0);
	rom_rd_db			:	in	std_logic_vector( 7 downto  0);
	ext_rd_db			:	in	std_logic_vector( 7 downto  0);
	--
	----------------------------------------< 

	----------------------------------------> Outputs
	--
	mem_wait			:	out	std_logic;

	dev_rd_en			:	out	std_logic;

	dev_wr_en			:	out	std_logic;
	ram_wr_en			:	out	std_logic;

	rd_data_bus			:	out	std_logic_vector( 7 downto  0)
	--
	----------------------------------------< 

);
end main_bus_switch;
--
--==========================================================================--

architecture structure of main_bus_switch is

--=========================> Signals & Constants <==========================--
--
constant	dev_addr		:	std_logic_vector(15 downto 0) := x"0000"; -- 64bytes Register @ 0x0000 - 0x003F
constant	ram_addr		:	std_logic_vector(15 downto 0) := x"0000"; -- 960bytes RAM @ 0x0040 - 0x03FF
constant	rom_addr		:	std_logic_vector(15 downto 0) := x"E000"; -- 8k ROM @ 0xE000 - 0xFFFF
--
--==========================================================================--

begin

--============================> Architecture <==============================--
--

----------------------------------------> Read Data Bus Mux
--
process
(
	addr_bus,
	dev_rd_db,
	ram_rd_db,
	rom_rd_db,
	ext_rd_db
)
begin

	   if	(addr_bus(15 downto  6) = dev_addr(15 downto  6))	then	rd_data_bus	<=	dev_rd_db;
	elsif	(addr_bus(15 downto 10) = ram_addr(15 downto 10))	then	rd_data_bus	<=	ram_rd_db;
	elsif	(addr_bus(15 downto 13) = rom_addr(15 downto 13))	then	rd_data_bus	<=	rom_rd_db;
	else	rd_data_bus	<=	ext_rd_db;
	end if;
	
end process;

--
----------------------------------------<

----------------------------------------> Read Enable Logic
--
dev_rd_en		<= rd_en when (addr_bus(15 downto  6) = dev_addr(15 downto  6)) else '0';
--
----------------------------------------<

----------------------------------------> Write Enable Logic
--
dev_wr_en			<= wr_en when (addr_bus(15 downto  6) = dev_addr(15 downto  6)) else '0';
ram_wr_en			<= wr_en when (addr_bus(15 downto  10) = ram_addr(15 downto 10)) else '0';
--
----------------------------------------<

----------------------------------------> Memory Wait State Logic
--
mem_wait			<= '1' when	(addr_bus(15 downto  10) = ram_addr(15 downto 10)) or
								(addr_bus(15 downto  13) = rom_addr(15 downto 13)) else '0';
--
----------------------------------------<

--==========================================================================--

end structure;