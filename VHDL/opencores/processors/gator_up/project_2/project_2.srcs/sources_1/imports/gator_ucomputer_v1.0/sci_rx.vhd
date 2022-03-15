--==========================> Gator uProccessor <===========================--
-- SCI_RX.VHD	
-- Engineer:	Peter Flores
-- Date:		10/12/2007									Revision:10.12.07
--
--==========================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity sci_rx is

--============================> Port Map <==================================--

port
(
	----------------------------------------> Inputs
	--
	sys_rst				:	in	std_logic;
	clk					:	in	std_logic;
	sci_clk_div			:	in	std_logic;

	rxd_pin				:	in	std_logic;

	rdr_rd_en			:	in	std_logic;
	scsr_rd_en			:	in	std_logic;

	cpb_cnt_max			:	in	std_logic_vector(15 downto  0);
	--
	----------------------------------------<

	----------------------------------------> Outputs
	--
	scsr_rdrf			:	out std_logic;
	scsr_or				:	out std_logic;
	
	rdr_rd_db			:	out	std_logic_vector( 7 downto  0)
	--
	----------------------------------------< 
);
end sci_rx;

--==========================================================================--


architecture behavior of sci_rx is

type state_type is
(
	reset,
	idle,
	start_bit,
	shift_in,
	load
);

signal		state_reg	:	state_type;
signal		state_nxt	:	state_type;

signal		rxd_reg		:	std_logic;
signal		scsr_rdrf_reg	:	std_logic;
signal		scsr_or_reg	:	std_logic;
signal		shifter_en	:	std_logic;
signal		rdrf_set	:	std_logic;
signal		rdrf_clr	:	std_logic;
signal		overr_clr	:	std_logic;
signal		cpb_cnt_clr	:	std_logic;
signal		bit_cnt_clr	:	std_logic;
signal		bit_cnt_en	:	std_logic;

signal		bit_cnt_reg	:	std_logic_vector( 3 downto 0);
signal		bit_cnt_inc	:	std_logic_vector( 3 downto 0);
constant	bit_cnt_max	:	std_logic_vector( 3 downto 0)	:=	x"A"; -- 8 bit data length

signal		rdr_ld		:	std_logic;

signal		rdr_reg		:	std_logic_vector( 7 downto 0);

signal		shifter_reg	:	std_logic_vector( 9 downto 0);

signal		cpb_cnt_reg	:	std_logic_vector(15 downto 0);
signal		cpb_cnt_inc	:	std_logic_vector(15 downto 0);
signal		cpb_cnt_mid	:	std_logic_vector(15 downto  0);


begin


--========================> Combitorial Logic <=============================--

cpb_cnt_mid	<=	'0' & cpb_cnt_max(15 downto 1);
cpb_cnt_inc	<=	cpb_cnt_reg + '1';
bit_cnt_inc	<=	bit_cnt_reg + '1';

process
(
	state_reg,
	scsr_rdrf_reg,
	cpb_cnt_max,
	cpb_cnt_mid,
	cpb_cnt_inc,
	bit_cnt_inc,
	rxd_reg
)

begin

	-- Default Values
	shifter_en	<=	'0';
	rdrf_set	<=	'0';
	rdrf_clr	<=	'0';
	overr_clr	<=	'0';
	cpb_cnt_clr	<=	'0';
	bit_cnt_clr	<=	'0';
	bit_cnt_en	<=	'0';
	rdr_ld		<=	'0';
	state_nxt	<=	state_reg;

	case state_reg is

		when reset	=>
			rdrf_clr	<= '1';
			overr_clr	<= '1';
			state_nxt	<= idle;

		when idle	=>
			cpb_cnt_clr	<=	'1';
			bit_cnt_clr	<=	'1';
			if (rxd_reg = '0') then
				state_nxt	<= start_bit;
			end if;

		when start_bit	=>
			if (rxd_reg = '0') then
				state_nxt 	<= shift_in;
			else
				state_nxt 	<= idle;
			end if;

		when shift_in	=>
			if (cpb_cnt_inc = cpb_cnt_max) then
				cpb_cnt_clr	<=	'1';
			elsif (cpb_cnt_inc = cpb_cnt_mid) then
				shifter_en	<=	'1';
				bit_cnt_en	<=	'1';
				if (bit_cnt_inc = bit_cnt_max) then
					state_nxt	<= load;
				end if;
			end if;

		when load		=>
			rdr_ld		<= '1';
			rdrf_set	<= '1';
			state_nxt	<= idle;

	end case;

end process;

--==========================================================================--


--==========================> Sequential Logic<==============================--

process
(
	clk,
	sys_rst,
	--wr_data_bus,
	--tdr_wr_en,
	rdr_rd_en,
	rdrf_set,
	sci_clk_div,
	state_nxt,
	cpb_cnt_clr,
	cpb_cnt_inc,
	bit_cnt_clr,
	bit_cnt_inc,
	bit_cnt_en,
	--shifter_set,
	--shifter_ld,
	shifter_en,
	shifter_reg,
	rxd_pin
)

begin

	if (clk'event and clk = '1') then
	
		if (sys_rst = '1') then
			
			state_reg	<=	reset;
	
		else
			
			rxd_reg		<=	rxd_pin;


			----------------------------------------> RDRF Flag Register
			--
			if (rdr_rd_en = '1') then -- when RDR reg is read
				scsr_rdrf_reg	<= '0';
			elsif (sci_clk_div = '1') then -- Syncronized Set / Clear
				if (rdrf_set = '1') then
					scsr_rdrf_reg	<= '1';
				elsif (rdrf_clr = '1') then
					scsr_rdrf_reg	<= '0';
				end if;
			end if;
			--
			----------------------------------------<


			----------------------------------------> OverR Flag Register
			--
			if (scsr_rd_en = '1') then -- when SCSR reg is read
				scsr_or_reg	<= '0'; -- OverR flag is cleared when SCSR is read
			elsif (sci_clk_div = '1') then -- Syncronized Error Detection
				if (overr_clr = '1') then
					scsr_or_reg	<= '0';
				elsif (rdr_ld = '1' and scsr_rdrf_reg = '1') then
					scsr_or_reg	<= '1'; -- Overrun Error - data in SCDR is not disturbed, the character in the shift register is lost
				end if;
			end if;
			--
			----------------------------------------<


			-- Syncronized Logic
			if (sci_clk_div = '1') then
			
					----------------------------------------> State Register
					--
					state_reg	<=	state_nxt;
					--
					----------------------------------------<
							
					----------------------------------------> rx CPB Counter
					-- 
					if (cpb_cnt_clr = '1') then
						cpb_cnt_reg		<=	(others => '0');
					else
						cpb_cnt_reg		<=	cpb_cnt_inc;
					end if;
					--
					----------------------------------------<
						
					----------------------------------------> Bit Counter
					--
					if (bit_cnt_clr = '1') then
						bit_cnt_reg		<=	(others => '0');
					elsif (bit_cnt_en = '1') then
						bit_cnt_reg		<=	bit_cnt_inc;
					end if;
					--
					----------------------------------------<

					----------------------------------------> RDR Register
					--
					if (rdr_ld = '1' and scsr_rdrf_reg = '0') then
						rdr_reg		<=	shifter_reg(8 downto 1); -- Write shift register to RDR.
					end if;
					--
					----------------------------------------<

					----------------------------------------> Shift In Register
					--
					if (shifter_en = '1') then
						shifter_reg		<=	rxd_reg & shifter_reg(9 downto 1); -- Shift in from rxD.
					end if;
					--
					----------------------------------------<
			
			end if;

		end if;

	end if;
	
end process;

scsr_or		<=	scsr_or_reg;
scsr_rdrf	<=	scsr_rdrf_reg;
rdr_rd_db	<=	rdr_reg;

--==========================================================================--

end behavior;