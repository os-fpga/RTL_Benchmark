--==========================> Gator uProccessor <===========================--
-- LED_SW_INTERFACE.VHD	
-- Engineer:	Kevin Phillipson
-- Date:		02/04/2008									Revision:02.04.08
-- Description: 
--
--==========================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity led_sw_interface is

--============================> Port Map <==================================--

port
(
	----------------------------------------> Inputs
	--
	sys_rst			: 	in		std_logic;
	clk				: 	in		std_logic;

	l7seg1_wr_en	:	in		std_logic;
	l7seg0_wr_en	:	in		std_logic;
	lledsw_wr_en	:	in		std_logic;

	r7seg1_wr_en	:	in		std_logic;
	r7seg0_wr_en	:	in		std_logic;
	rledsw_wr_en	:	in		std_logic;

	wr_data_bus		:	in		std_logic_vector( 7 downto  0);

	dip_sw			:	in		std_logic_vector( 7 downto  0);
	--
	---------------------------------------->

	----------------------------------------> Outputs
	--
	l7seg1_rd_db	:	out		std_logic_vector( 7 downto  0);
	l7seg0_rd_db	:	out		std_logic_vector( 7 downto  0);
	lledsw_rd_db	:	out		std_logic_vector( 7 downto  0);

	r7seg1_rd_db	:	out		std_logic_vector( 7 downto  0);
	r7seg0_rd_db	:	out		std_logic_vector( 7 downto  0);
	rledsw_rd_db	:	out		std_logic_vector( 7 downto  0);
	
	lbank_en		:	out		std_logic;
	rbank_en		:	out		std_logic;

	seven_seg1		:	out		std_logic_vector( 7 downto  0);
	seven_seg0		:	out		std_logic_vector( 7 downto  0);
	leds			:	out		std_logic_vector( 7 downto  0)
	--
	----------------------------------------< 
);

--==========================================================================--

end led_sw_interface;

architecture behavior of led_sw_interface is 

--==============================> Signals <=================================--


----------------------------------------> Internal Signals
--
type state_type is
(
	lbank_off,
	lbank_on,
	rbank_off,
	rbank_on
);

signal		led_sw_state_reg	:	state_type;
signal		led_sw_state_nxt	:	state_type;

constant	OFF_CNT_MAX			:	std_logic_vector(15 downto  0)	:=	x"01FF";
constant	OFF_CNT_MID			:	std_logic_vector(15 downto  0)	:=	'0' & OFF_CNT_MAX(15 downto  1);

constant	ON_CNT_MAX			:	std_logic_vector(15 downto  0)	:=	x"7FFF";
constant	ON_CNT_MID			:	std_logic_vector(15 downto  0)	:=	'0' & ON_CNT_MAX(15 downto  1);

signal		led_sw_cnt_reg		:	std_logic_vector(15 downto  0);

signal		led_sw_cnt_clr		:	std_logic;

signal		lbank_en_reg		:	std_logic;
signal		ldip_sw_reg			:	std_logic_vector( 7 downto  0);
signal		l7seg1_reg			:	std_logic_vector( 7 downto  0);
signal		l7seg0_reg			:	std_logic_vector( 7 downto  0);
signal		lleds_reg			:	std_logic_vector( 7 downto  0);

signal		lbank_en_nxt		:	std_logic;
signal		ldip_sw_nxt			:	std_logic_vector( 7 downto  0);
signal		l7seg1_nxt			:	std_logic_vector( 7 downto  0);
signal		l7seg0_nxt			:	std_logic_vector( 7 downto  0);
signal		lleds_nxt			:	std_logic_vector( 7 downto  0);

signal		rbank_en_reg		:	std_logic;
signal		rdip_sw_reg			:	std_logic_vector( 7 downto  0);
signal		r7seg1_reg			:	std_logic_vector( 7 downto  0);
signal		r7seg0_reg			:	std_logic_vector( 7 downto  0);
signal		rleds_reg			:	std_logic_vector( 7 downto  0);

signal		rbank_en_nxt		:	std_logic;
signal		rdip_sw_nxt			:	std_logic_vector( 7 downto  0);
signal		r7seg1_nxt			:	std_logic_vector( 7 downto  0);
signal		r7seg0_nxt			:	std_logic_vector( 7 downto  0);
signal		rleds_nxt			:	std_logic_vector( 7 downto  0);

signal		seven_seg1_reg		:	std_logic_vector( 7 downto  0);
signal		seven_seg0_reg		:	std_logic_vector( 7 downto  0);
signal		leds_reg			:	std_logic_vector( 7 downto  0);
signal		dip_sw_reg			:	std_logic_vector( 7 downto  0);

signal		seven_seg1_nxt		:	std_logic_vector( 7 downto  0);
signal		seven_seg0_nxt		:	std_logic_vector( 7 downto  0);
signal		leds_nxt			:	std_logic_vector( 7 downto  0);

--
----------------------------------------<

--==========================================================================--

begin

--=================> LED Switch Interface Architecture <====================--

----------------------------------------> LED Switch Interface State Machine
--
process
(
	led_sw_state_reg,
	led_sw_cnt_reg,
	dip_sw_reg,
	l7seg1_reg,
	l7seg0_reg,
	lleds_reg,
	ldip_sw_reg,
	r7seg1_reg,
	r7seg0_reg,
	rleds_reg,
	rdip_sw_reg,
	seven_seg1_reg,
	seven_seg0_reg,
	leds_reg

)
begin

	-- Default values
	lbank_en_nxt		<=	'1';
	ldip_sw_nxt			<=	ldip_sw_reg;
	rbank_en_nxt		<=	'1';
	rdip_sw_nxt			<=	rdip_sw_reg;
	seven_seg1_nxt		<=	seven_seg1_reg;
	seven_seg0_nxt		<=	seven_seg0_reg;
	leds_nxt			<=	leds_reg;
	led_sw_cnt_clr		<=	'0';
	led_sw_state_nxt	<=	led_sw_state_reg;


	case led_sw_state_reg is

		when lbank_off =>
			lbank_en_nxt	<=	'1';
			rbank_en_nxt	<=	'1';
			if (led_sw_cnt_reg = OFF_CNT_MID) then
				seven_seg1_nxt		<=	not l7seg1_reg;
				seven_seg0_nxt		<=	not l7seg0_reg;
				leds_nxt			<=	not lleds_reg;
			elsif (led_sw_cnt_reg = OFF_CNT_MAX) then
				led_sw_cnt_clr		<=	'1';
				led_sw_state_nxt	<=	lbank_on;
			end if;

		when lbank_on =>
			lbank_en_nxt	<=	'0';
			rbank_en_nxt	<=	'1';
			if (led_sw_cnt_reg = ON_CNT_MID) then
				ldip_sw_nxt			<=	dip_sw_reg;
			elsif (led_sw_cnt_reg = ON_CNT_MAX) then
				led_sw_cnt_clr		<=	'1';
				led_sw_state_nxt	<=	rbank_off;
			end if;

		when rbank_off =>
			rbank_en_nxt	<=	'1';
			lbank_en_nxt	<=	'1';
			if (led_sw_cnt_reg = OFF_CNT_MID) then
				seven_seg1_nxt		<=	not r7seg1_reg;
				seven_seg0_nxt		<=	not r7seg0_reg;
				leds_nxt			<=	not rleds_reg;
			elsif (led_sw_cnt_reg = OFF_CNT_MAX) then
				led_sw_cnt_clr		<=	'1';
				led_sw_state_nxt	<=	rbank_on;
			end if;

		when rbank_on =>
			rbank_en_nxt	<=	'0';
			lbank_en_nxt	<=	'1';
			if (led_sw_cnt_reg = ON_CNT_MID) then
				rdip_sw_nxt		<=	dip_sw_reg;
			elsif (led_sw_cnt_reg = ON_CNT_MAX) then
				led_sw_cnt_clr		<=	'1';
				led_sw_state_nxt	<=	lbank_off;
			end if;

		when others	=>
			led_sw_state_nxt	<=	lbank_off;

	end case;

end process;

-- State Register
process
(
	clk,
	sys_rst,
	led_sw_state_nxt
)
begin

	if (clk'event  and clk = '1') then

		if (sys_rst = '1') then
			led_sw_state_reg	<=	lbank_off;
		else
			led_sw_state_reg	<=	led_sw_state_nxt;
		end if;

	end if;
	
end process;
--
----------------------------------------<

----------------------------------------> Time Counter
--
process
(
	clk,
	led_sw_cnt_clr
)
begin

	if (clk'event  and clk = '1') then

		if (led_sw_cnt_clr = '1') then

			led_sw_cnt_reg	<=	(others => '0');

		else

			led_sw_cnt_reg	<=	led_sw_cnt_reg + '1';

		end if;

	end if;
	
end process;
--
----------------------------------------<

----------------------------------------> Interface Registers
--
process
(
	clk,
	lbank_en_nxt,
	rbank_en_nxt,
	seven_seg1_nxt,
	seven_seg0_nxt,
	leds_nxt,
	dip_sw
)
begin

	if (clk'event  and clk = '1') then

		lbank_en_reg	<=	lbank_en_nxt;
		rbank_en_reg	<=	rbank_en_nxt;

		seven_seg1_reg	<=	seven_seg1_nxt;
		seven_seg0_reg	<=	seven_seg0_nxt;
		leds_reg		<=	leds_nxt;
		
		dip_sw_reg		<=	dip_sw;

	end if;
	
end process;
--
----------------------------------------<

----------------------------------------> Interface Outputs
--
lbank_en		<=	lbank_en_reg;
rbank_en		<=	rbank_en_reg;

seven_seg1		<=	seven_seg1_reg;
seven_seg0		<=	seven_seg0_reg;
leds			<=	leds_reg;
--
----------------------------------------<

----------------------------------------> Gator uComputer Registers
--
process
(
	clk,
	wr_data_bus,
	l7seg1_wr_en,
	l7seg0_wr_en,
	lledsw_wr_en,
	ldip_sw_nxt,
	r7seg1_wr_en,
	r7seg0_wr_en,
	rledsw_wr_en,
	rdip_sw_nxt
)
begin

	if (clk'event  and clk = '1') then

		if (l7seg1_wr_en = '1') then
			l7seg1_reg	<=	wr_data_bus;
		end if;
		if (l7seg0_wr_en = '1') then
			l7seg0_reg	<=	wr_data_bus;
		end if;
		if (lledsw_wr_en = '1') then
			lleds_reg	<=	wr_data_bus;
		end if;
		ldip_sw_reg		<=	ldip_sw_nxt;

		if (r7seg1_wr_en = '1') then
			r7seg1_reg	<=	wr_data_bus;
		end if;
		if (r7seg0_wr_en = '1') then
			r7seg0_reg	<=	wr_data_bus;
		end if;
		if (rledsw_wr_en = '1') then
			rleds_reg	<=	wr_data_bus;
		end if;
		rdip_sw_reg	<=	rdip_sw_nxt;

	end if;
	
end process;
--
----------------------------------------<

----------------------------------------> Gator uComputer Read Data Busses
--
l7seg1_rd_db	<=	l7seg1_reg;
l7seg0_rd_db	<=	l7seg0_reg;
lledsw_rd_db	<=	ldip_sw_reg;

r7seg1_rd_db	<=	r7seg1_reg;
r7seg0_rd_db	<=	r7seg0_reg;
rledsw_rd_db	<=	rdip_sw_reg;
--
----------------------------------------<

--==========================================================================--
end behavior;