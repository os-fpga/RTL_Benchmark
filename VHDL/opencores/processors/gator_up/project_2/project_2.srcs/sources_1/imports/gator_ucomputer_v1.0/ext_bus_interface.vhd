--==========================> Gator uProccessor <===========================--
-- EXT_BUS_INTERFACE.VHD	
-- Engineer:	Kevin Phillipson
-- Date:		10/22/2007									Revision:10.22.07
-- Description: 
--
--==========================================================================--
library ieee;
use ieee.std_logic_1164.all;

--================================> Port Map <==============================--
--
entity ext_bus_interface is
port 
(
	----------------------------------------> Inputs
	--
	wr_data_oe			:	in		std_logic;
	wr_data_bus			:	in		std_logic_vector( 7 downto  0);
	--
	----------------------------------------< 

	----------------------------------------> Bidirectional
	--
	ext_data_bus		:	inout	std_logic_vector( 7 downto  0);
	--
	----------------------------------------< 

	----------------------------------------> Outputs
	--
	ext_rd_db			:	out		std_logic_vector( 7 downto  0)
	--
	----------------------------------------< 

);
end ext_bus_interface;
--
--==========================================================================--

architecture structure of ext_bus_interface is

--=========================> Signals & Constants <==========================--
--
--
--==========================================================================--

begin

--============================> Architecture <==============================--
--

ext_data_bus	<=	wr_data_bus when (wr_data_oe = '1') else "ZZZZZZZZ";

ext_rd_db		<=	ext_data_bus;

--
--==========================================================================--

end structure;