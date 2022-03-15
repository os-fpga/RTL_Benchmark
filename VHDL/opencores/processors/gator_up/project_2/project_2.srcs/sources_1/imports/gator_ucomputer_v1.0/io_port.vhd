--==========================> Gator uProccessor <===========================--
-- IO_PORT.VHD	
--
-- Engineer:	Peter Flores
-- Date:		09/23/2007
-- Description:	Implements the a parallel input / output port compatible with
--				those found on the 68HC1x series of microcontrollers.
--				The port register contains the data moving in and out off the 
--				port. The data direction register controls the direction of
--				each pin as follows:
--				0 = Input
--				1 = Output
--
-- Engineer:	Kevin Phillipson
-- Revision:	09/24/2007
-- Notes:		Merged together block diagram file into single VHDL component.
--				Changed design so that input data is registered.
--				Added reset logic.
--				
--==========================================================================--

library ieee;
use ieee.std_logic_1164.all;

entity io_port is

--============================> Port Map <==================================--

port
(
	----------------------------------------> Inputs
	--
	sys_rst			: 	in		std_logic;
	clk				: 	in		std_logic;

	wr_data_bus		:	in		std_logic_vector( 7 downto  0);
	io_port_wr_en	:	in		std_logic;
	io_ddr_wr_en	:	in		std_logic;
	--
	---------------------------------------->

	----------------------------------------> Input / Outputs
	--
	io_port_pins	:	inout	std_logic_vector( 7 downto  0);
	--
	---------------------------------------->

	----------------------------------------> Outputs
	--
	io_port_rd_db	:	out		std_logic_vector( 7 downto  0);

	io_ddr_rd_db	:	out		std_logic_vector( 7 downto  0)
	--
	----------------------------------------< 

);

--==========================================================================--

end io_port;

architecture behavior of io_port is 

--==============================> Signals <=================================--

signal	data_dir_reg	:	std_logic_vector( 7 downto  0);
signal	port_reg		:	std_logic_vector( 7 downto  0);

--==========================================================================--

begin

--=========================> IO Port Architecture <=============================--


----------------------------------------> Data Direction Register
--
process
(
	sys_rst,
	clk,
	wr_data_bus,
	io_ddr_wr_en
)
begin
	if (clk'event and clk = '1') then

		if (sys_rst = '1') then
		
			data_dir_reg <= (others => '0');

		elsif (io_ddr_wr_en = '1') then

			data_dir_reg <= wr_data_bus;
			
		end if;

	end if;

end process;
--
----------------------------------------<

----------------------------------------> Port Register
--
process
(
	sys_rst,
	clk,
	wr_data_bus,
	io_port_wr_en,
	io_port_pins
)
begin
	if (clk'event and clk = '1') then

		if (sys_rst = '1') then
		
			port_reg <= (others => '0');

		else
			
			if (data_dir_reg(7) = '1' and io_port_wr_en = '1') then
				port_reg(7)	<= wr_data_bus(7);
			elsif (data_dir_reg(7) = '0') then
				port_reg(7)	<= io_port_pins(7);
			end if;

			if (data_dir_reg(6) = '1' and io_port_wr_en = '1') then
				port_reg(6)	<= wr_data_bus(6);
			elsif (data_dir_reg(6) = '0') then
				port_reg(6)	<= io_port_pins(6);
			end if;
			
			if (data_dir_reg(5) = '1' and io_port_wr_en = '1') then
				port_reg(5)	<= wr_data_bus(5);
			elsif (data_dir_reg(5) = '0') then
				port_reg(5)	<= io_port_pins(5);
			end if;

			if (data_dir_reg(4) = '1' and io_port_wr_en = '1') then
				port_reg(4)	<= wr_data_bus(4);
			elsif (data_dir_reg(4) = '0') then
				port_reg(4)	<= io_port_pins(4);
			end if;
			
			if (data_dir_reg(3) = '1' and io_port_wr_en = '1') then
				port_reg(3)	<= wr_data_bus(3);
			elsif (data_dir_reg(3) = '0') then
				port_reg(3)	<= io_port_pins(3);
			end if;
			
			if (data_dir_reg(2) = '1' and io_port_wr_en = '1') then
				port_reg(2)	<= wr_data_bus(2);
			elsif (data_dir_reg(2) = '0') then
				port_reg(2)	<= io_port_pins(2);
			end if;
			
			if (data_dir_reg(1) = '1' and io_port_wr_en = '1') then
				port_reg(1)	<= wr_data_bus(1);
			elsif (data_dir_reg(1) = '0') then
				port_reg(1)	<= io_port_pins(1);
			end if;
			
			if (data_dir_reg(0) = '1' and io_port_wr_en = '1') then
				port_reg(0)	<= wr_data_bus(0);
			elsif (data_dir_reg(0) = '0') then
				port_reg(0)	<= io_port_pins(0);
			end if;
			
		end if;

	end if;

end process;
--
----------------------------------------<

----------------------------------------> Outputs
--

io_port_pins(7)	<= port_reg(7) when (data_dir_reg(7) = '1') else 'Z';
io_port_pins(6)	<= port_reg(6) when (data_dir_reg(6) = '1') else 'Z';
io_port_pins(5)	<= port_reg(5) when (data_dir_reg(5) = '1') else 'Z';
io_port_pins(4)	<= port_reg(4) when (data_dir_reg(4) = '1') else 'Z';
io_port_pins(3)	<= port_reg(3) when (data_dir_reg(3) = '1') else 'Z';
io_port_pins(2)	<= port_reg(2) when (data_dir_reg(2) = '1') else 'Z';
io_port_pins(1)	<= port_reg(1) when (data_dir_reg(1) = '1') else 'Z';
io_port_pins(0)	<= port_reg(0) when (data_dir_reg(0) = '1') else 'Z';

io_port_rd_db	<= port_reg;
io_ddr_rd_db	<= data_dir_reg;

--
----------------------------------------<

--==========================================================================--

end behavior;