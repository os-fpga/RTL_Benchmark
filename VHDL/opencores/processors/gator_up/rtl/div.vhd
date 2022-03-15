--==========================> Gator uProccessor <===========================--
-- DIV.VHD	
-- Engineer:	Kevin Phillipson
-- Date:		11/09/2007									Revision:11.27.07
-- Description: 
--
--==========================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity div is

--============================> Port Map <==================================--

port
(
	----------------------------------------> Inputs
	--
	sys_rst			:	in	std_logic;
	clk				:	in	std_logic;
	sync			:	in	std_logic;

	div_op			:	in	std_logic_vector( 1 downto  0);

	numerator		:	in	std_logic_vector(15 downto  0);
	denominator		:	in	std_logic_vector(15 downto  0);
	--
	---------------------------------------->


	----------------------------------------> Outputs
	--
	div_delay_sig	:	out	std_logic;

	z_flag			:	out	std_logic;
	v_flag			:	out	std_logic;
	c_flag			:	out	std_logic;

	quotient		:	out	std_logic_vector(15 downto  0);
	remainder		:	out	std_logic_vector(15 downto  0)
	--
	----------------------------------------< 

);

--==========================================================================--

end div;

architecture behavior of div is 

--==============================> Signals <=================================--


----------------------------------------> Internal Signals
--
type state_type is
(
	div_cycle_00,
	div_cycle_01,
	div_cycle_02,
	div_cycle_03,
	div_cycle_04
);

constant	DIV_REG			:	std_logic	:=	'0';
constant	DIV_INIT		:	std_logic	:=	'1';

constant	IDIV_OP			:	std_logic_vector( 1 downto  0)	:=	"10";
constant	FDIV_OP			:	std_logic_vector( 1 downto  0)	:=	"11";

signal		div_state_reg	:	state_type;
signal		div_state_nxt	:	state_type;

signal		div_mux_sel		:	std_logic;
signal		div_reg_en		:	std_logic;

signal		div_delay_reg	:	std_logic;
signal		div_delay_nxt	:	std_logic;

signal		d_bus_in		:	std_logic_vector(16 downto  0);

signal		a_bus_init		:	std_logic_vector(16 downto  0);
signal		a_bus_in		:	std_logic_vector(16 downto  0);
signal		a_bus_00		:	std_logic_vector(16 downto  0);
signal		a_bus_01		:	std_logic_vector(16 downto  0);
signal		a_bus_02		:	std_logic_vector(16 downto  0);
signal		a_bus_03		:	std_logic_vector(16 downto  0);
signal		a_bus_reg		:	std_logic_vector(16 downto  0);

signal		q_bus_init		:	std_logic_vector(15 downto  0);
signal		q_bus_in		:	std_logic_vector(15 downto  0);
signal		q_bus_00		:	std_logic_vector(15 downto  0);
signal		q_bus_01		:	std_logic_vector(15 downto  0);
signal		q_bus_02		:	std_logic_vector(15 downto  0);
signal		q_bus_03		:	std_logic_vector(15 downto  0);
signal		q_bus_reg		:	std_logic_vector(15 downto  0);

signal		a_tmp_00		:	std_logic_vector(16 downto  0);
signal		a_tmp_01		:	std_logic_vector(16 downto  0);
signal		a_tmp_02		:	std_logic_vector(16 downto  0);
signal		a_tmp_03		:	std_logic_vector(16 downto  0);

signal		a_correct		:	std_logic_vector(16 downto  0);
signal		quotient_vec	:	std_logic_vector(15 downto  0);

--
----------------------------------------<

--==========================================================================--

begin

--=======================> Division Architecture <==========================--

----------------------------------------> Divider State Machine
--
process
(
	div_state_reg,
	numerator,
	div_op,
	sync
)
begin

	-- Default values
	div_mux_sel		<=	DIV_INIT;
	div_reg_en		<=	'1';
	a_bus_init		<=	(others => '0');
	q_bus_init		<=	numerator;
	div_state_nxt	<=	div_state_reg;
	div_delay_nxt	<=	'0';

	case div_state_reg is

		when div_cycle_00 =>
			div_mux_sel		<=	DIV_INIT;
			div_reg_en		<=	'1';
			if (div_op = IDIV_OP) then
				a_bus_init		<=	(others => '0');
				q_bus_init		<=	numerator;
				div_state_nxt	<=	div_cycle_01;
			elsif (div_op = FDIV_OP) then
				a_bus_init		<=	'0' & numerator;
				q_bus_init		<=	(others => '0');
				div_state_nxt	<=	div_cycle_01;
			end if;

		when div_cycle_01 =>
			div_mux_sel		<=	DIV_REG;
			div_reg_en		<=	'1';
			div_delay_nxt	<=	'1';
			div_state_nxt	<=	div_cycle_02;

		when div_cycle_02 =>
			div_mux_sel		<=	DIV_REG;
			div_reg_en		<=	'1';
			div_state_nxt	<=	div_cycle_03;

		when div_cycle_03 =>
			div_mux_sel		<=	DIV_REG;
			div_reg_en		<=	'1';
			div_state_nxt	<=	div_cycle_04;

		when div_cycle_04 =>
			div_mux_sel		<=	DIV_REG;
			div_reg_en		<=	'0';
			if (sync = '1') then
				div_state_nxt	<=	div_cycle_00;
			end if;

		when others	=>
			div_state_nxt	<=	div_cycle_00;

	end case;

end process;

-- State Register
process
(
	clk,
	sys_rst,
	div_state_nxt,
	div_delay_nxt
)
begin

	if (clk'event  and clk = '1') then

		if (sys_rst = '1') then
			div_state_reg	<=	div_cycle_00;
		else
			div_state_reg	<=	div_state_nxt;
		end if;
		
		div_delay_reg	<=	div_delay_nxt;

	end if;
	
end process;
--
----------------------------------------<

----------------------------------------> Input Select MUX
--
d_bus_in	<=	'0' & denominator;
a_bus_in	<=	a_bus_init	when (div_mux_sel = DIV_INIT) else a_bus_reg;
q_bus_in	<=	q_bus_init	when (div_mux_sel = DIV_INIT) else q_bus_reg;
--
----------------------------------------<

----------------------------------------> Stage 00
--
q_bus_00	<=	q_bus_in(14 downto  0) & (not a_bus_in(16));
a_tmp_00	<=	a_bus_in(15 downto  0) & q_bus_in(15);
a_bus_00	<=	a_tmp_00 - d_bus_in when (a_bus_in(16) = '0') else a_tmp_00 + d_bus_in;
--
----------------------------------------<

----------------------------------------> Stage 01
--
q_bus_01	<=	q_bus_00(14 downto  0) & (not a_bus_00(16));
a_tmp_01	<=	a_bus_00(15 downto  0) & q_bus_00(15);
a_bus_01	<=	a_tmp_01 - d_bus_in when (a_bus_00(16) = '0') else a_tmp_01 + d_bus_in;
--
----------------------------------------<

----------------------------------------> Stage 02
--
q_bus_02	<=	q_bus_01(14 downto  0) & (not a_bus_01(16));
a_tmp_02	<=	a_bus_01(15 downto  0) & q_bus_01(15);
a_bus_02	<=	a_tmp_02 - d_bus_in when (a_bus_01(16) = '0') else a_tmp_02 + d_bus_in;
--
----------------------------------------<

----------------------------------------> Stage 03
--
q_bus_03	<=	q_bus_02(14 downto  0) & (not a_bus_02(16));
a_tmp_03	<=	a_bus_02(15 downto  0) & q_bus_02(15);
a_bus_03	<=	a_tmp_03 - d_bus_in when (a_bus_02(16) = '0') else a_tmp_03 + d_bus_in;
--
----------------------------------------<

----------------------------------------> Divider Registers
--
process
(
	clk,
	div_reg_en,
	q_bus_03,
	a_bus_03
)
begin

	if (clk'event  and clk = '1') then

		if (div_reg_en = '1') then
			q_bus_reg		<=	q_bus_03;
			a_bus_reg		<=	a_bus_03;
		end if;

	end if;
	
end process;
--
----------------------------------------<

----------------------------------------> Correction Stage
--
quotient_vec	<=	q_bus_reg(14 downto  0) & (not a_bus_reg(16));
quotient		<=	quotient_vec;
a_correct		<=	a_bus_reg + d_bus_in;
remainder		<=	a_correct(15 downto  0) when (a_bus_reg(16) = '1') else a_bus_reg(15 downto  0);
--
----------------------------------------<

----------------------------------------> Flag Generation
--
z_flag	<=	'1'	when (quotient_vec = x"0000") else '0';
v_flag	<=	'1'	when (denominator <= numerator) else '0';
c_flag	<=	'1'	when (denominator = x"0000") else '0';
--
----------------------------------------<

div_delay_sig	<=	div_delay_reg;

--==========================================================================--
end behavior;