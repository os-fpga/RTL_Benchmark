--==========================> Gator uProccessor <===========================--
-- MEMORY_CONTROLLER.VHD	
-- Engineer:	Kevin Phillipson
-- Date:		02/09/2007									Revision:11.28.07
-- Description: 
--
--==========================================================================--


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity memory_controller is
port
(
	----------------------------------------> Clock, Reset & Sync
	--
	sys_rst					:	in		std_logic;
	clk						:	in		std_logic;
	sync					:	out		std_logic;
	--
	----------------------------------------<

	----------------------------------------> Memory & Control Bus
	--
	wr_data_oe				:	out		std_logic;

	wr_en					:	out		std_logic;
	rd_en					:	out		std_logic;

	mem_wait				:	in		std_logic;

	address_bus				:	out		std_logic_vector(15 downto  0);

	rd_data_bus				:	in		std_logic_vector( 7 downto  0);
	wr_data_bus				:	out		std_logic_vector( 7 downto  0);
	--
	----------------------------------------<

	----------------------------------------> Internal Architecture Signals
	--
	func_sel				:	in		std_logic_vector( 2 downto  0);

	address_alu_q			:	in		std_logic_vector(15 downto  0);
	data_alu_q				:	in		std_logic_vector(15 downto  0);

	rd_data_out				:	out		std_logic_vector(15 downto  0);
	opcode_out				:	out		std_logic_vector( 7 downto	0)
	--
	----------------------------------------<
);
end memory_controller;


architecture behavior of memory_controller is


----------------------------------------> Signals & Constants
--
type state_type is
(
	mem_cycle_0,
	mem_cycle_1,
	mem_cycle_2,
	mem_cycle_3
);

signal		state_reg		:	state_type;
signal		state_nxt		:	state_type;

signal		sync_nxt		:	std_logic;
signal		sync_reg		:	std_logic;

signal		wait_nxt		:	std_logic;
signal		wait_reg		:	std_logic;

signal		address_load	:	std_logic;
signal		address_inc		:	std_logic;
signal		address_bus_reg	:	std_logic_vector(15 downto  0);

signal		wr_data_oe_nxt	:	std_logic;
signal		wr_data_oe_reg	:	std_logic;
signal		wr_data_lo_load	:	std_logic;
signal		wr_data_hi_load	:	std_logic;
signal		wr_en_nxt		:	std_logic;
signal		wr_en_reg		:	std_logic;
signal		wr_data_bus_reg	:	std_logic_vector( 7 downto  0);

signal		rd_data_load	:	std_logic;
signal		rd_data_hi_load	:	std_logic;
signal		rd_en_nxt		:	std_logic;

signal		rd_en_reg		:	std_logic_vector(1  downto  0);

signal		rd_data_hi_reg	:	std_logic_vector( 7 downto  0);
signal		rd_data_out_reg	:	std_logic_vector(15 downto  0);

signal		opcode_load		:	std_logic;
signal		opcode_out_reg	:	std_logic_vector( 7 downto  0);

constant	IDLE			:	std_logic_vector( 2 downto  0)	:=  "000";
constant	READ_BYTE		:	std_logic_vector( 2 downto  0)	:=  "001";
constant	WRITE_BYTE		:	std_logic_vector( 2 downto  0)	:=  "010";
constant	READ_WORD		:	std_logic_vector( 2 downto  0)	:=  "011";
constant	WRITE_WORD		:	std_logic_vector( 2 downto  0)	:=  "100";
constant	READ_OPCODE		:	std_logic_vector( 2 downto  0)	:=  "101";
--
----------------------------------------<


begin


----------------------------------------> Next State & Output Logic
--
process
(
	state_reg,
	func_sel,
	mem_wait,
	wait_reg
)
begin

	----------------------------------------> Default Values
	--
	address_load	<=	'0';
	address_inc		<=	'0';

	wr_en_nxt		<=	'0';
	wr_data_oe_nxt	<=	'0';
	wr_data_lo_load	<=	'0';
	wr_data_hi_load	<=	'0';

	rd_en_nxt		<=	'0';
	rd_data_load	<=	'0';
	rd_data_hi_load	<=	'0';

	opcode_load		<=	'0';

	sync_nxt		<=	'0';

	wait_nxt		<=	'0';

	state_nxt		<=	mem_cycle_0;
	--
	----------------------------------------<

	case state_reg is

		when mem_cycle_0 =>

			---------------------------------------->
			--
			if (func_sel = READ_OPCODE) then
				rd_en_nxt		<=	'1';			-- rd_en = '1' next state and is maintained for 1.5 states
				address_load	<=	'1';			-- address_bus_reg becomes valid next state & is maintained
				state_nxt		<=	mem_cycle_1;

			elsif (func_sel = READ_BYTE) then
				rd_en_nxt		<=	'1';			-- rd_en = '1' next state and is maintained for 1.5 states
				address_load	<=	'1';			-- address_bus_reg becomes valid next state & is maintained
				state_nxt		<=	mem_cycle_1;

			elsif (func_sel = WRITE_BYTE) then
				address_load	<=	'1';			-- address_bus_reg becomes valid next state & is maintained
				wr_data_lo_load	<=	'1';			-- wr_data_bus_reg becomes valid next state & is maintained
				wr_data_oe_nxt	<=	'1';			-- wr_data_oe_reg = '1' next state only
				state_nxt		<=	mem_cycle_1;

			elsif (func_sel = READ_WORD) then
				rd_en_nxt		<=	'1';			-- rd_en = '1' next state and is maintained for 1.5 states
				address_load	<=	'1';			-- address_bus_reg becomes valid next state & is maintained
				state_nxt		<=	mem_cycle_1;

			elsif (func_sel = WRITE_WORD) then
				address_load	<=	'1';			-- address_bus_reg becomes valid next state & is maintained
				wr_data_hi_load	<=	'1';			-- wr_data_bus_reg becomes valid next state & is maintained
				wr_data_oe_nxt	<=	'1';			-- wr_data_oe_reg = '1' next state only
				state_nxt		<=	mem_cycle_1;

			else
				sync_nxt		<=	'1';			-- sync_reg	= '1' half of this state and the next only
				state_nxt		<=	mem_cycle_0;
			end if;
			--
			----------------------------------------<
		
		when mem_cycle_1 =>

			---------------------------------------->
			--
			if (func_sel = READ_OPCODE) then
				if (mem_wait = '0' or (mem_wait = '1' and wait_reg = '1')) then
					opcode_load		<=	'1';			-- opcode_out_reg becomes valid next state & is maintained
					sync_nxt		<=	'1';			-- sync_reg	= '1' half of this state and the next only
					state_nxt		<=	mem_cycle_0;
				else
					rd_en_nxt		<=	'1';			-- rd_en = '1' next state and is maintained for 1.5 states
					wait_nxt		<=	'1';			-- wait_reg = '1' next state only
					state_nxt		<=	mem_cycle_1;
				end if;

			elsif (func_sel = READ_BYTE) then
				if (mem_wait = '0' or (mem_wait = '1' and wait_reg = '1')) then
					rd_data_load	<=	'1';			-- rd_data_out_reg becomes valid next state & is maintained
					sync_nxt		<=	'1';			-- sync_reg	= '1' half of this state and the next only
					state_nxt		<=	mem_cycle_0;
				else
					rd_en_nxt		<=	'1';			-- rd_en = '1' next state and is maintained for 1.5 states
					wait_nxt		<=	'1';			-- wait_reg = '1' next state only
					state_nxt		<=	mem_cycle_1;
				end if;

			elsif (func_sel = WRITE_BYTE) then
				wr_data_oe_nxt	<=	'1';			-- wr_data_oe_reg = '1' next state only
				wr_en_nxt		<=	'1';			-- wr_en_reg = '1' half of this state and the next only
				sync_nxt		<=	'1';			-- sync_reg	= '1' half of this state and the next only
				state_nxt		<=	mem_cycle_0;
			
			elsif (func_sel = READ_WORD) then
				if (mem_wait = '0' or (mem_wait = '1' and wait_reg = '1')) then
					rd_data_hi_load	<=	'1';			-- rd_data_out_reg becomes valid next state & is maintained
					state_nxt		<=	mem_cycle_2;
				else
					rd_en_nxt		<=	'1';			-- rd_en = '1' next state and is maintained for 1.5 states
					wait_nxt		<=	'1';			-- wait_reg = '1' next state only
					state_nxt		<=	mem_cycle_1;
				end if;

			elsif (func_sel = WRITE_WORD) then
				wr_data_oe_nxt	<=	'1';			-- wr_data_oe_reg = '1' next state only
				wr_en_nxt		<=	'1';			-- wr_en_reg = '1' half of this state and the next only
				state_nxt		<=	mem_cycle_2;
			else
				sync_nxt		<=	'1';			-- sync_reg	= '1' half of this state and the next only
				state_nxt		<=	mem_cycle_0;
			end if;
			--
			----------------------------------------<

		when mem_cycle_2 =>

			---------------------------------------->
			--
			if (func_sel = READ_WORD) then
				address_inc		<=	'1';			-- address_bus_reg becomes valid next state & is maintained
				rd_en_nxt		<=	'1';			-- rd_en = '1' next state and is maintained for 1.5 states
				state_nxt		<=	mem_cycle_3;
			elsif (func_sel = WRITE_WORD) then
				address_inc		<=	'1';			-- address_bus_reg becomes valid next state & is maintained
				wr_data_lo_load	<=	'1';			-- wr_data_bus_reg becomes valid next state & is maintained
				wr_data_oe_nxt	<=	'1';			-- wr_data_oe_reg = '1' next state only
				state_nxt		<=	mem_cycle_3;
			else
				sync_nxt		<=	'1';			-- sync_reg	= '1' half of this state and the next only
				state_nxt		<=	mem_cycle_0;
			end if;
			--
			----------------------------------------<

		when mem_cycle_3 =>

			---------------------------------------->
			--
			if (func_sel = READ_WORD) then
				if (mem_wait = '0' or (mem_wait = '1' and wait_reg = '1')) then
					rd_data_load	<=	'1';			-- rd_data_out_reg becomes valid next state & is maintained
					sync_nxt		<=	'1';			-- sync_reg	= '1' half of this state and the next only
					state_nxt		<=	mem_cycle_0;
				else
					rd_en_nxt		<=	'1';			-- rd_en = '1' next state and is maintained for 1.5 states
					wait_nxt		<=	'1';			-- wait_reg = '1' next state only
					state_nxt		<=	mem_cycle_3;
				end if;

			elsif (func_sel = WRITE_WORD) then
				wr_data_oe_nxt	<=	'1';			-- wr_data_oe_reg = '1' next state only
				wr_en_nxt		<=	'1';			-- wr_en_reg = '1' half of this state and the next only
				sync_nxt		<=	'1';			-- sync_reg	= '1' half of this state and the next only
				state_nxt		<=	mem_cycle_0;
			else
				sync_nxt		<=	'1';			-- sync_reg	= '1' half of this state and the next only
				state_nxt		<=	mem_cycle_0;
			end if;
			--
			----------------------------------------<

	end case;

end process;
--
----------------------------------------<



----------------------------------------> Rising Edge Clocked Registers
--
process
(
	sys_rst,
	clk,
	state_nxt,
	wr_data_oe_nxt,
	address_load,
	address_alu_q,
	address_inc,
	wr_data_hi_load,
	wr_data_lo_load,
	data_alu_q,
	rd_data_hi_load,
	rd_data_load,
	rd_data_hi_reg,
	rd_data_bus,
	rd_en_nxt,
	wait_nxt,
	opcode_load
)
begin
	
	if (clk'event and clk = '1') then

		if (sys_rst = '1') then
		
			state_reg		<=	mem_cycle_0;
			wr_data_oe_reg	<=	'0';
			rd_en_reg(0)	<=	'0';
			wait_reg		<=	'0';

		else
	
			state_reg		<=	state_nxt;
			wr_data_oe_reg	<=	wr_data_oe_nxt;

			rd_en_reg(0)	<=	rd_en_nxt;
			wait_reg		<=	wait_nxt;

			if (address_load = '1') then
				address_bus_reg	<=	address_alu_q;
			elsif (address_inc = '1') then
				address_bus_reg	<=	address_bus_reg + '1';
			end if;

			if (wr_data_hi_load = '1') then
				wr_data_bus_reg	<=	data_alu_q(15 downto  8);
			elsif (wr_data_lo_load = '1') then
				wr_data_bus_reg	<=	data_alu_q( 7 downto  0);
			end if;

			if (rd_data_hi_load = '1') then
				rd_data_hi_reg	<=	rd_data_bus;
			end if;
			
			if (rd_data_load = '1') then
				rd_data_out_reg(15 downto  8)	<=	rd_data_hi_reg;
				rd_data_out_reg( 7 downto  0)	<=	rd_data_bus;
			end if;

			if (opcode_load = '1') then
				opcode_out_reg	<=	rd_data_bus;
			end if;

		end if;

	end if;

end process;
--
----------------------------------------<


----------------------------------------> Falling Edge Clocked Registers
--
process
(
	sys_rst,
	clk,
	wr_en_nxt,
	rd_en_reg,
	sync_nxt
)
begin
	
	if (clk'event and clk = '0') then

		if (sys_rst = '1') then
		
			sync_reg		<=	'0';

			wr_en_reg		<=	'0';
			rd_en_reg(1)	<=	'0';

		else

			sync_reg		<=	sync_nxt;

			wr_en_reg		<=	wr_en_nxt;
			rd_en_reg(1)	<=	rd_en_reg(0);
		
		end if;

	end if;

end process;
--
----------------------------------------<


----------------------------------------> Outputs
--
sync		<=	sync_reg;
rd_en		<=	rd_en_reg(0) or rd_en_reg(1);
wr_en		<=	wr_en_reg;
wr_data_oe	<=	wr_data_oe_reg;
address_bus	<=	address_bus_reg;
wr_data_bus	<=	wr_data_bus_reg;
rd_data_out	<=	rd_data_out_reg;
opcode_out	<=	opcode_out_reg;
--
----------------------------------------<


end behavior;