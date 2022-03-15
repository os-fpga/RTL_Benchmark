--==========================> Gator uProccessor <===========================--
-- SCI_TX.VHD	
-- Engineer:	Kevin Phillipson
-- Date:		10/10/2007									Revision:10.10.07
--
--==========================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity sci_tx is

--============================> Port Map <==================================--

port
(
	----------------------------------------> Inputs
	--
	sys_rst				:	in	std_logic;
	clk					:	in	std_logic;
	sci_clk_div			:	in	std_logic;

	tdr_wr_en			:	in	std_logic;

	wr_data_bus			:	in	std_logic_vector( 7 downto  0);
	cpb_cnt_max			:	in	std_logic_vector(15 downto  0);
	--
	----------------------------------------<

	----------------------------------------> Outputs
	--
	txd_pin				:	out	std_logic;

	scsr_tdre			:	out	std_logic;
	scsr_tc				:	out	std_logic
	--
	----------------------------------------< 
);
end sci_tx;

--==========================================================================--


architecture behavior of sci_tx is

type state_type is
(
	reset,
	idle,
	shift_out
);

signal		state_reg		:	state_type;
signal		state_nxt		:	state_type;

signal		scsr_tdre_reg	:	std_logic;
signal		scsr_tc_reg		:	std_logic;
signal		tdre_set		:	std_logic;
signal		tc_set			:	std_logic;
signal		tc_clr			:	std_logic;

signal		shifter_set		:	std_logic;
signal		shifter_ld		:	std_logic;
signal		shifter_en		:	std_logic;
signal		cpb_cnt_clr		:	std_logic;
signal		bit_cnt_clr		:	std_logic;
signal		bit_cnt_en		:	std_logic;

signal		bit_cnt_reg		:	std_logic_vector( 3 downto 0);
signal		bit_cnt_inc		:	std_logic_vector( 3 downto 0);
constant	bit_cnt_max		:	std_logic_vector( 3 downto 0)	:=	x"A"; -- 8 bit data length

signal		tdr_reg			:	std_logic_vector( 7 downto 0);

signal		shifter_reg		:	std_logic_vector( 8 downto 0);

signal		cpb_cnt_reg		:	std_logic_vector(15 downto 0);
signal		cpb_cnt_inc		:	std_logic_vector(15 downto 0);


begin


--========================> Combitorial Logic <=============================--

cpb_cnt_inc	<=	cpb_cnt_reg + '1';
bit_cnt_inc	<=	bit_cnt_reg + '1';

process
(
	state_reg,
	scsr_tdre_reg,
	cpb_cnt_max,
	cpb_cnt_inc,
--	bit_cnt_max,
	bit_cnt_inc
)

begin

	-- Default Values
	shifter_set	<=	'0';
	shifter_ld	<=	'0';
	shifter_en	<=	'0';
	tdre_set	<=	'0';
	tc_set		<=	'0';
	tc_clr		<=	'0';
	cpb_cnt_clr	<=	'0';
	bit_cnt_clr	<=	'0';
	bit_cnt_en	<=	'0';
	state_nxt	<=	state_reg;

	case state_reg is

		when reset	=>
			shifter_set	<= '1';
			tdre_set	<= '1';
			tc_set		<= '1';
			state_nxt	<= idle;

		when idle	=>
			cpb_cnt_clr	<=	'1';
			bit_cnt_clr	<=	'1';
			if (scsr_tdre_reg = '0') then
				tdre_set	<=	'1';
				shifter_ld	<=	'1';
				tc_clr		<=	'1';
				state_nxt	<=	shift_out;
			else
				tc_set		<=	'1';
			end if;

		when shift_out	=>
			if (cpb_cnt_inc = cpb_cnt_max) then
				cpb_cnt_clr	<=	'1';
				if (bit_cnt_inc = bit_cnt_max) then
					state_nxt	<= idle;
				else
					shifter_en	<=	'1';
					bit_cnt_en	<=	'1';
				end if;
			end if;

	end case;

end process;

--==========================================================================--


--==========================> Sequential Logic<==============================--

process
(
	clk,
	sys_rst,
	wr_data_bus,
	tdr_wr_en,
	tdre_set,
	tc_set,
	tc_clr,
	sci_clk_div,
	state_nxt,
	cpb_cnt_clr,
	cpb_cnt_inc,
	bit_cnt_clr,
	bit_cnt_inc,
	bit_cnt_en,
	shifter_set,
	shifter_ld,
	shifter_en,
	shifter_reg,
	tdr_reg	
)

begin

	if (clk'event and clk = '1') then
	
		if (sys_rst = '1') then
			
			state_reg	<=	reset;
	
		else
			
			----------------------------------------> TDR Register
			--
			if (tdr_wr_en = '1') then
				tdr_reg		<= wr_data_bus;
			end if;
			--
			----------------------------------------<

			----------------------------------------> TDRE Flag Register
			--
			if (tdr_wr_en = '1') then
				scsr_tdre_reg	<= '0';
			elsif (tdre_set = '1' and sci_clk_div = '1') then -- Syncronized Set
				scsr_tdre_reg	<= '1';
			end if;
			--
			----------------------------------------<

			----------------------------------------> TC Flag Register
			--
			if (tc_set = '1') then -- Syncronized Set
				scsr_tc_reg	<= '1';
			elsif (tc_clr = '1') then -- Syncronized Clear
				scsr_tc_reg	<= '0';
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
							
					----------------------------------------> TX CPB Counter
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

					----------------------------------------> Shift Out Register
					--
					if (shifter_set = '1') then
						shifter_reg		<=	(others => '1'); -- Set shift_reg so that TXD idles high
					elsif (shifter_ld = '1') then
						shifter_reg		<=	tdr_reg & '0'; -- Load shift register from TDR, including low start-bit
					elsif (shifter_en = '1') then
						shifter_reg		<=	'1' & shifter_reg(8 downto 1); -- Shift in 1's. Shift out to the TXD line
					end if;
					--
					----------------------------------------<
			
			end if;

		end if;

	end if;
	
end process;

txd_pin		<=	shifter_reg(0);
scsr_tdre	<=	scsr_tdre_reg;
scsr_tc		<=	scsr_tc_reg;

--==========================================================================--

end behavior;