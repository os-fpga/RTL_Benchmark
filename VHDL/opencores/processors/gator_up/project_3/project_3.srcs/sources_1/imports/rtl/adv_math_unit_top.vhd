--==========================> Gator uProccessor <===========================--
-- ADV_MATH_UNIT.VHD	
-- Engineer:	Kevin Phillipson
-- Date:		11/27/2007									Revision:11.27.07
-- Description:
--==========================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

--================================> Port Map <==============================--
--
entity adv_math_unit is
port 
(
	-- Inputs
	sys_rst			:	in	std_logic;
	clk				:	in	std_logic;
	sync			:	in	std_logic;

	amu_op			:	in	std_logic_vector( 1 downto  0);

	ccr_data		:	in	std_logic_vector( 7 downto  0);

	amu_rd_db		:	in	std_logic_vector(31 downto  0);
	-- Outputs
	
	div_delay_sig	:	out	std_logic;
	
	amu_flags		:	out	std_logic_vector( 3 downto  0);

	amu_wr_db		:	out	std_logic_vector(31 downto  0)

);
end adv_math_unit;
--
--==========================================================================--

architecture structure of adv_math_unit is

--==============================> Components <==============================--

----------------------------------------> Multiplier Block
--
component mul
port
(
	-- Inputs
	clk			:	in	std_logic;
	mul_a		:	in	std_logic_vector( 7 downto  0);
	mul_b		:	in	std_logic_vector( 7 downto  0);

	-- Outputs
	c_flag		:	out	std_logic;
	product		:	out	std_logic_vector(15 downto  0)
);
end component;
--
----------------------------------------<

----------------------------------------> Divider Block
--
component div
port
(
	-- Inputs
	sys_rst			:	in	std_logic;
	clk				:	in	std_logic;
	sync			:	in	std_logic;
	div_op			:	in	std_logic_vector( 1 downto  0);
	numerator		:	in	std_logic_vector(15 downto  0);
	denominator		:	in	std_logic_vector(15 downto  0);

	-- Outputs
	div_delay_sig	:	out	std_logic;
	z_flag			:	out	std_logic;
	v_flag			:	out	std_logic;
	c_flag			:	out	std_logic;
	quotient		:	out	std_logic_vector(15 downto  0);
	remainder		:	out	std_logic_vector(15 downto  0)
);
end component;
--
----------------------------------------<

--==========================================================================--

--==============================> Signals <=================================--

constant	DAA_OP			:	std_logic_vector( 1 downto  0) := "00";
constant	MUL_OP			:	std_logic_vector( 1 downto  0) := "01";
constant	IDIV_OP			:	std_logic_vector( 1 downto  0) := "10";
constant	FDIV_OP			:	std_logic_vector( 1 downto  0) := "11";

signal		d_rd_db			:	std_logic_vector(15 downto  0);
signal		a_rd_db			:	std_logic_vector( 7 downto  0);
signal		b_rd_db			:	std_logic_vector( 7 downto  0);
signal		x_rd_db			:	std_logic_vector(15 downto  0);

signal		a_wr_db			:	std_logic_vector( 7 downto  0);
signal		b_wr_db			:	std_logic_vector( 7 downto  0);
signal		x_wr_db			:	std_logic_vector(15 downto  0);

signal		ccr_n_flag		:	std_logic;
signal		ccr_z_flag		:	std_logic;
signal		ccr_v_flag		:	std_logic;
signal		ccr_c_flag		:	std_logic;

signal		amu_n_flag		:	std_logic;
signal		amu_z_flag		:	std_logic;
signal		amu_v_flag		:	std_logic;
signal		amu_c_flag		:	std_logic;

signal		mul_c_flag		:	std_logic;
signal		mul_product		:	std_logic_vector(15 downto  0);

signal		div_z_flag		:	std_logic;
signal		div_v_flag		:	std_logic;
signal		div_c_flag		:	std_logic;
signal		div_quotient	:	std_logic_vector(15 downto  0);
signal		div_remainder	:	std_logic_vector(15 downto  0);

--==========================================================================--

begin

--==========================> Interface Logic <=============================--

----------------------------------------> Register Read Bus Spilt
--
d_rd_db	<=	amu_rd_db(31 downto 16);
a_rd_db	<=	amu_rd_db(31 downto 24);
b_rd_db	<=	amu_rd_db(23 downto 16);
x_rd_db	<=	amu_rd_db(15 downto  0);
--
----------------------------------------<

----------------------------------------> CCR Flags
--
ccr_n_flag	<=	ccr_data(3);
ccr_z_flag	<=	ccr_data(2);
ccr_v_flag	<=	ccr_data(1);
ccr_c_flag	<=	ccr_data(0);
--
----------------------------------------<

 
--==========================================================================--

--=======================> Component Connections <==========================--

----------------------------------------> Multiplier Block
--
mul_block	:	mul
port map
(
	-- Inputs
	clk			=>	clk,
	mul_a		=>	a_rd_db,
	mul_b		=>	b_rd_db,

	-- Outputs
	c_flag		=>	mul_c_flag,
	product		=>	mul_product
);
--
----------------------------------------<

----------------------------------------> Divider Block
--
div_block	:	div
port map
(
	-- Inputs
	sys_rst			=>	sys_rst,
	clk				=>	clk,
	sync			=>	sync,
	div_op			=>	amu_op,
	numerator		=>	d_rd_db,
	denominator		=>	x_rd_db,

	-- Outputs
	div_delay_sig	=>	div_delay_sig,
	z_flag			=>	div_z_flag,
	v_flag			=>	div_v_flag,
	c_flag			=>	div_c_flag,
	quotient		=>	div_quotient,
	remainder		=>	div_remainder
);
--
----------------------------------------<

--==========================================================================--

--==============================> Outputs <=================================--

----------------------------------------> A Write Data Bus Mux
--
with amu_op select
a_wr_db		<=
			x"00"						when DAA_OP,
			mul_product(15 downto  8)	when MUL_OP,
			div_remainder(15 downto  8)	when IDIV_OP,
			div_remainder(15 downto  8)	when others;--FDIV_OP,
--
----------------------------------------<

----------------------------------------> B Write Data Bus Mux
--
with amu_op select
b_wr_db		<=
			mul_product( 7 downto  0)	when MUL_OP,
			div_remainder( 7 downto  0)	when IDIV_OP,
			div_remainder( 7 downto  0)	when others;--FDIV_OP,
--
----------------------------------------<

----------------------------------------> X Write Data Bus
--
x_wr_db		<=	div_quotient;
--
----------------------------------------<

----------------------------------------> AMU N Flag Mux
--
with amu_op select
amu_n_flag	<=
			'0'			when DAA_OP,
			ccr_n_flag	when MUL_OP,
			ccr_n_flag	when IDIV_OP,
			ccr_n_flag	when others;--FDIV,
--
----------------------------------------<

----------------------------------------> AMU Z Flag Mux
--
with amu_op select
amu_z_flag	<=
			'0'			when DAA_OP,
			ccr_z_flag	when MUL_OP,
			div_z_flag	when IDIV_OP,
			div_z_flag	when others;--FDIV,
--
----------------------------------------<

----------------------------------------> AMU V Flag Mux
--
with amu_op select
amu_v_flag	<=
			'0'			when DAA_OP,
			ccr_v_flag	when MUL_OP,
			'0'			when IDIV_OP,
			div_v_flag	when others;--FDIV,
--
----------------------------------------<

----------------------------------------> AMU C Flag Mux
--
with amu_op select
amu_c_flag	<=
			'0'			when DAA_OP,
			mul_c_flag	when MUL_OP,
			div_c_flag	when IDIV_OP,
			div_c_flag	when others;--FDIV,
--
----------------------------------------<

----------------------------------------> AMU Flags
--
amu_flags(3)	<=	amu_n_flag;
amu_flags(2)	<=	amu_z_flag;
amu_flags(1)	<=	amu_v_flag;
amu_flags(0)	<=	amu_c_flag;
--
----------------------------------------<

----------------------------------------> AMU Write Bus
--
amu_wr_db(31 downto 24)	<=	a_wr_db;
amu_wr_db(23 downto 16)	<=	b_wr_db;
amu_wr_db(15 downto  0)	<=	x_wr_db;
--
----------------------------------------<

--==========================================================================--

end structure;