--==========================> Gator uProccessor <===========================--
-- CCR.VHD	
-- Engineer:	Kevin Phillipson
-- Date:		02/09/2007									Revision:11.09.07
-- Description: 
--
--==========================================================================--

library ieee;
use ieee.std_logic_1164.all;

entity ccr is

--============================> Port Map <==================================--

port
(
	----------------------------------------> Inputs
	--
	clk		 		:	in	std_logic;
	sync			:	in	std_logic;
	sys_rst			:	in	std_logic;

	stop_cond		:	in	std_logic;
	irq_cond		:	in	std_logic;
	div_delay		:	in	std_logic;

	set_x_msk		:	in	std_logic;
	ccr_op			:	in	std_logic_vector( 3 downto  0);

	alu_cond_sel	:	in	std_logic_vector( 1 downto  0);
	usq_cond_sel	:	in	std_logic_vector( 3 downto  0);

	alu_flags		:	in	std_logic_vector( 5 downto  0);
	amu_flags		:	in	std_logic_vector( 3 downto  0);
	
	data_wr_db		:	in	std_logic_vector( 7 downto  0);
	--
	---------------------------------------->


	----------------------------------------> Outputs
	--
	alu_cond		:	out std_logic;
	usq_cond		:	out std_logic;

	ccr_data		:	out	std_logic_vector( 7 downto  0)
	--
	----------------------------------------< 

);

--==========================================================================--

end ccr;

architecture behavior of ccr is 

--==============================> Signals <=================================--


----------------------------------------> Operation Select Constants
--
--	CCR:	OP_SXHINZVC
constant	OP_oooooooo	:	std_logic_vector(3 downto 0)	:= x"0";
constant	OP_oooooooX	:	std_logic_vector(3 downto 0)	:= x"1";
constant	OP_oooooo0o	:	std_logic_vector(3 downto 0)	:= x"2";
constant	OP_oooooo1o	:	std_logic_vector(3 downto 0)	:= x"3";
constant	OP_oooooXoo	:	std_logic_vector(3 downto 0)	:= x"4";
constant	OP_oooooXXX	:	std_logic_vector(3 downto 0)	:= x"5";
constant	OP_ooooXXXX	:	std_logic_vector(3 downto 0)	:= x"6";
constant	OP_ooooXXXo	:	std_logic_vector(3 downto 0)	:= x"7";
constant	OP_oooXoooo	:	std_logic_vector(3 downto 0)	:= x"8";
constant	OP_ooXoXXXX	:	std_logic_vector(3 downto 0)	:= x"9";
constant	OP_oXo1oooo	:	std_logic_vector(3 downto 0)	:= x"A";
constant	OP_XVXXXXXX	:	std_logic_vector(3 downto 0)	:= x"B";
constant	OP_UZERO_EN	:	std_logic_vector(3 downto 0)	:= x"C";
constant	OP_AMU_FLGS	:	std_logic_vector(3 downto 0)	:= x"D";
--
----------------------------------------<

----------------------------------------> Internal CCR Signals
--
signal		alu_c			:	std_logic;	-- Carry
signal		alu_v			:	std_logic;	-- Overflow
signal		alu_z			:	std_logic;	-- Zero
signal		alu_n			:	std_logic;	-- Negative
signal		alu_h			:	std_logic;	-- Half Carry
signal		alu_a_sign		:	std_logic;	-- A Input Sign Bit

signal		c_reg			:	std_logic;	-- Carry
signal		v_reg			:	std_logic;	-- Overflow
signal		z_reg			:	std_logic;	-- Zero
signal		n_reg			:	std_logic;	-- Negative
signal		i_reg			:	std_logic;	-- I Interrupt Mask
signal		h_reg			:	std_logic;	-- Half Carry
signal		x_reg			:	std_logic;	-- X Interrupt Mask
signal		s_reg			:	std_logic;	-- Stop Disable

signal		uz_reg			:	std_logic;	-- micro zero flag


signal		bls_sig			:	std_logic;
signal		ble_sig			:	std_logic;
signal		blt_sig			:	std_logic;
--
----------------------------------------<

--==========================================================================--

begin

--=========================> CCR Architecture <=============================--

----------------------------------------> ALU Flag Input
--
alu_c		<=	alu_flags( 0);
alu_v		<=	alu_flags( 1);
alu_z		<=	alu_flags( 2);
alu_n		<=	alu_flags( 3);
alu_h		<=	alu_flags( 4);
alu_a_sign	<=	alu_flags( 5);
--
----------------------------------------<

----------------------------------------> Condition Code Register
--
process
(
	clk,
	sync,
	sys_rst,
	ccr_op,
	alu_c,
	alu_v,
	alu_z,
	alu_n,
	alu_h,
	set_x_msk,
	amu_flags,
	data_wr_db
)
begin
	
	if (clk'event and clk = '1') then
	
		if (sys_rst = '1') then

		--	c_reg	<=	alu_c;
		--	v_reg	<=	alu_v;
		--	z_reg	<=	alu_z;
		--	n_reg	<=	alu_n;
			i_reg	<=	'1';
		--	h_reg	<=	alu_h;
			x_reg	<=	'1';
			s_reg	<=	'1';
		--	uz_reg	<=	alu_z;
		
		elsif (sync = '1') then

			if (ccr_op = OP_oooooooo) then

			--	c_reg	<=	alu_c;
			--	v_reg	<=	alu_v;
			--	z_reg	<=	alu_z;
			--	n_reg	<=	alu_n;
			--	i_reg	<=	'0';
			--	h_reg	<=	alu_h;
			--	x_reg	<=	'0';
			--	s_reg	<=	'0';
			--	uz_reg	<=	alu_z;

			elsif (ccr_op = OP_oooooooX) then

				c_reg	<=	alu_c;
			--	v_reg	<=	alu_v;
			--	z_reg	<=	alu_z;
			--	n_reg	<=	alu_n;
			--	i_reg	<=	'0';
			--	h_reg	<=	alu_h;
			--	x_reg	<=	'0';
			--	s_reg	<=	'0';
			--	uz_reg	<=	alu_z;

			elsif (ccr_op = OP_oooooo0o) then

			--	c_reg	<=	alu_c;
				v_reg	<=	'0';
			--	z_reg	<=	alu_z;
			--	n_reg	<=	alu_n;
			--	i_reg	<=	'0';
			--	h_reg	<=	alu_h;
			--	x_reg	<=	'0';
			--	s_reg	<=	'0';
			--	uz_reg	<=	alu_z;

			elsif (ccr_op = OP_oooooo1o) then

			--	c_reg	<=	alu_c;
				v_reg	<=	'1';
			--	z_reg	<=	alu_z;
			--	n_reg	<=	alu_n;
			--	i_reg	<=	'0';
			--	h_reg	<=	alu_h;
			--	x_reg	<=	'0';
			--	s_reg	<=	'0';
			--	uz_reg	<=	alu_z;

			elsif (ccr_op = OP_oooooXoo) then

			--	c_reg	<=	alu_c;
			--	v_reg	<=	alu_v;
				z_reg	<=	alu_z;
			--	n_reg	<=	alu_n;
			--	i_reg	<=	'0';
			--	h_reg	<=	alu_h;
			--	x_reg	<=	'0';
			--	s_reg	<=	'0';
			--	uz_reg	<=	alu_z;

			elsif (ccr_op = OP_oooooXXX) then

				c_reg	<=	alu_c;
				v_reg	<=	alu_v;
				z_reg	<=	alu_z;
			--	n_reg	<=	alu_n;
			--	i_reg	<=	'0';
			--	h_reg	<=	alu_h;
			--	x_reg	<=	'0';
			--	s_reg	<=	'0';
			--	uz_reg	<=	alu_z;

			elsif (ccr_op = OP_ooooXXXX) then

				c_reg	<=	alu_c;
				v_reg	<=	alu_v;
				z_reg	<=	alu_z;
				n_reg	<=	alu_n;
			--	i_reg	<=	'0';
			--	h_reg	<=	alu_h;
			--	x_reg	<=	'0';
			--	s_reg	<=	'0';
			--	uz_reg	<=	alu_z;

			elsif (ccr_op = OP_ooooXXXo) then

			--	c_reg	<=	alu_c;
				v_reg	<=	alu_v;
				z_reg	<=	alu_z;
				n_reg	<=	alu_n;
			--	i_reg	<=	'0';
			--	h_reg	<=	alu_h;
			--	x_reg	<=	'0';
			--	s_reg	<=	'0';
			--	uz_reg	<=	alu_z;

			elsif (ccr_op = OP_oooXoooo) then

			--	c_reg	<=	alu_c;
			--	v_reg	<=	alu_v;
			--	z_reg	<=	alu_z;
			--	n_reg	<=	alu_n;
				i_reg	<=	alu_z;
			--	h_reg	<=	alu_h;
			--	x_reg	<=	'0';
			--	s_reg	<=	'0';
			--	uz_reg	<=	alu_z;

			elsif (ccr_op = OP_ooXoXXXX) then

				c_reg	<=	alu_c;
				v_reg	<=	alu_v;
				z_reg	<=	alu_z;
				n_reg	<=	alu_n;
			--	i_reg	<=	'0';
				h_reg	<=	alu_h;
			--	x_reg	<=	'0';
			--	s_reg	<=	'0';
			--	uz_reg	<=	alu_z;

			elsif (ccr_op = OP_oXo1oooo) then

			--	c_reg	<=	alu_c;
			--	v_reg	<=	alu_v;
			--	z_reg	<=	alu_z;
			--	n_reg	<=	alu_n;
				i_reg	<=	'1';
			--	h_reg	<=	alu_h;
				x_reg	<=	set_x_msk;
			--	s_reg	<=	'0';
			--	uz_reg	<=	alu_z;

			elsif (ccr_op = OP_XVXXXXXX) then

				c_reg	<=	data_wr_db(0);
				v_reg	<=	data_wr_db(1);
				z_reg	<=	data_wr_db(2);
				n_reg	<=	data_wr_db(3);
				i_reg	<=	data_wr_db(4);
				h_reg	<=	data_wr_db(5);
				x_reg	<=	data_wr_db(6) and x_reg;
				s_reg	<=	data_wr_db(7);
			--	uz_reg	<=	alu_z;

			elsif (ccr_op = OP_UZERO_EN) then

			--	c_reg	<=	alu_c;
			--	v_reg	<=	alu_v;
			--	z_reg	<=	alu_z;
			--	n_reg	<=	alu_n;
			--	i_reg	<=	'0';
			--	h_reg	<=	alu_h;
			--	x_reg	<=	'0';
			--	s_reg	<=	'0';
				uz_reg	<=	alu_z;

			elsif (ccr_op = OP_AMU_FLGS) then

				c_reg	<=	amu_flags(0);
				v_reg	<=	amu_flags(1);
				z_reg	<=	amu_flags(2);
				n_reg	<=	amu_flags(3);
			--	i_reg	<=	'0';
			--	h_reg	<=	alu_h;
			--	x_reg	<=	'0';
			--	s_reg	<=	'0';
			--	uz_reg	<=	alu_z;

			end if;
		
		end if;

	end if;

end process;
--
----------------------------------------<


ccr_data(0)	<=	c_reg;
ccr_data(1)	<=	v_reg;
ccr_data(2)	<=	z_reg;
ccr_data(3)	<=	n_reg;
ccr_data(4)	<=	i_reg;
ccr_data(5)	<=	h_reg;
ccr_data(6)	<=	x_reg;
ccr_data(7)	<=	s_reg;


----------------------------------------> ALU Condition Select Logic
--
with alu_cond_sel select
alu_cond	<=	'0'			when "00",	-- ZERO
				'1'			when "01",	-- ONE
				c_reg		when "10",	-- CCR_C
				alu_a_sign	when others;-- ASHIFT
--
----------------------------------------<

---------------------------------------->
--
ble_sig		<=	z_reg or (n_reg xor v_reg);
blt_sig		<=	n_reg xor v_reg;
bls_sig		<=	c_reg or z_reg;
--
----------------------------------------<

----------------------------------------> Microsquencer Condition Select Logic
--
with usq_cond_sel select
usq_cond	<=	'0'			when x"0",-- ZERO
				'1'			when x"1",-- ONE
				c_reg		when x"2",-- CCR_C
				v_reg		when x"3",-- CCR_V
				z_reg		when x"4",-- CCR_Z
				n_reg		when x"5",-- CCR_N
				ble_sig		when x"6",-- CCR_BLE
				blt_sig		when x"7",-- CCR_BLT
				bls_sig		when x"8",-- CCR_BLS
				uz_reg		when x"9",-- CCR_UZ
				irq_cond	when x"A",-- IRQ_COND
				stop_cond	when x"B",-- STOP_COND
				div_delay	when x"C",-- DIV_DELAY
				'0'			when others;
--
----------------------------------------<

--==========================================================================--
end behavior;