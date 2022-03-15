--==========================> Gator uProccessor <===========================--
-- REGISTER_ARRAY.VHD	
-- Engineer:	Kevin Phillipson
-- Date:		02/09/2007									Revision:10.19.07
-- Description: Contains the internal registers of the CPU.
--		It also implements the neccessary input and output MUX's.
--==========================================================================--


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity register_array is
port
(
	----------------------------------------> FPGA Clock & Reset
	--
	clk				:	in  std_logic;
	sync			:	in  std_logic;
	--
	---------------------------------------->

	---------------------------------------->
	--
	addr_wr_db		:	in	std_logic_vector(15 downto  0);

	irq_vector		:	in	std_logic_vector(15 downto  0);

	mem_data		:	in	std_logic_vector(15 downto  0);

	addr_sel		:	in	std_logic_vector( 3 downto  0);

	data_a_sel		:	in	std_logic_vector( 3 downto  0);
	data_b_sel		:	in	std_logic_vector( 3 downto  0);
	data_wr_sel		:	in	std_logic_vector( 3 downto  0);

	data_wr_db		:	in	std_logic_vector(15 downto  0);

	amu_wr_sel		:	in	std_logic_vector( 1 downto  0);
	amu_wr_db		:	in	std_logic_vector(31 downto  0);

	ccr_data		:	in	std_logic_vector( 7 downto  0);

	addr_db			:	out	std_logic_vector(15 downto  0);

	data_a_db		:	out	std_logic_vector(15 downto  0);
	data_b_db		:	out	std_logic_vector(15 downto  0);

	amu_rd_db		:	out	std_logic_vector(31 downto  0)
	--
	----------------------------------------<

);
end register_array;

architecture behavior of register_array is

constant	AMU_ZERO		:	std_logic_vector( 1 downto 0)	:=	"00";
constant	AMU_A			:	std_logic_vector( 1 downto 0)	:=	"01";
constant	AMU_D			:	std_logic_vector( 1 downto 0)	:=	"10";
constant	AMU_DX			:	std_logic_vector( 1 downto 0)	:=	"11";

constant	ZERO			:	std_logic_vector( 3 downto 0)	:=	x"0";
constant	TMP				:	std_logic_vector( 3 downto 0)	:=	x"1";
constant	EA				:	std_logic_vector( 3 downto 0)	:=	x"2";
constant	PC				:	std_logic_vector( 3 downto 0)	:=	x"3";
constant	SP				:	std_logic_vector( 3 downto 0)	:=	x"4";
constant	Y				:	std_logic_vector( 3 downto 0)	:=	x"5";
constant	X				:	std_logic_vector( 3 downto 0)	:=	x"6";
constant	D				:	std_logic_vector( 3 downto 0)	:=	x"7";
constant	B				:	std_logic_vector( 3 downto 0)	:=	x"8";
constant	A				:	std_logic_vector( 3 downto 0)	:=	x"9";
constant	MEM_U16			:	std_logic_vector( 3 downto 0)	:=	x"A";
constant	MEM_U8			:	std_logic_vector( 3 downto 0)	:=	x"B";
constant	MEM_S8			:	std_logic_vector( 3 downto 0)	:=	x"C";
constant	CCR				:	std_logic_vector( 3 downto 0)	:=	x"D";
constant	IRQ_VEC			:	std_logic_vector( 3 downto 0)	:=	x"E";
constant	TRAP_VEC		:	std_logic_vector( 3 downto 0)	:=	x"F";

signal		a_reg_u8_sig	:	std_logic_vector(15 downto 0);
signal		b_reg_u8_sig	:	std_logic_vector(15 downto 0);
signal		mem_u16_sig		:	std_logic_vector(15 downto 0);
signal		mem_u8_sig		:	std_logic_vector(15 downto 0);
signal		mem_s8_sig		:	std_logic_vector(15 downto 0);
signal		ccr_sig			:	std_logic_vector(15 downto 0);

signal		tmp_reg			:	std_logic_vector(15 downto 0);
signal		ea_reg			:	std_logic_vector(15 downto 0);
signal		pc_reg			:	std_logic_vector(15 downto 0);
signal		sp_reg			:	std_logic_vector(15 downto 0);
signal		y_reg			:	std_logic_vector(15 downto 0);
signal		x_reg			:	std_logic_vector(15 downto 0);
signal		d_reg			:	std_logic_vector(15 downto 0);
signal		b_reg			:	std_logic_vector( 7 downto 0);
signal		a_reg			:	std_logic_vector( 7 downto 0);


begin

process
(
	clk,
	sync,
	data_wr_db,
	addr_wr_db,
	amu_wr_db,
	data_wr_sel,
	addr_sel,	
	amu_wr_sel	
)
begin
	
	if (clk'event and clk = '1' and sync = '1') then

		----------------------------------------> Registers
		--

		----------------------------------------> A & D Register
		if (data_wr_sel = A) then
			a_reg			<=	data_wr_db( 7 downto 0);
		elsif (data_wr_sel = D) then
			a_reg			<=	data_wr_db(15 downto 8);
		elsif (addr_sel = A) then
			a_reg			<=	addr_wr_db( 7 downto 0);
		elsif (addr_sel = D) then
			a_reg			<=	addr_wr_db(15 downto 8);
		elsif (amu_wr_sel = AMU_A) then
			a_reg			<=	amu_wr_db(31 downto 24);
		elsif (amu_wr_sel = AMU_D) then
			a_reg			<=	amu_wr_db(31 downto 24);
		elsif (amu_wr_sel = AMU_DX) then
			a_reg			<=	amu_wr_db(31 downto 24);
		end if;
		
		----------------------------------------> B & D Register
		if (data_wr_sel = B) then
			b_reg			<=	data_wr_db( 7 downto 0);
		elsif (data_wr_sel = D) then
			b_reg			<=	data_wr_db( 7 downto 0);
		elsif (addr_sel = B) then
			b_reg			<=	addr_wr_db( 7 downto 0);
		elsif (addr_sel = D) then
			b_reg			<=	addr_wr_db( 7 downto 0);
		elsif (amu_wr_sel = AMU_D) then
			b_reg			<=	amu_wr_db(23 downto 16);
		elsif (amu_wr_sel = AMU_DX) then
			b_reg			<=	amu_wr_db(23 downto 16);
		end if;

		----------------------------------------> X Register
		if (data_wr_sel = X) then
			x_reg			<=	data_wr_db;
		elsif (addr_sel = X) then
			x_reg			<=	addr_wr_db;
		elsif (amu_wr_sel = AMU_DX) then
			x_reg			<=	amu_wr_db(15 downto  0);
		end if;

		----------------------------------------> Y Register
		if (data_wr_sel = Y) then
			y_reg			<=	data_wr_db;
		elsif (addr_sel = Y) then
			y_reg			<=	addr_wr_db;
		end if;

		----------------------------------------> SP Register
		if (data_wr_sel = SP) then
			sp_reg			<=	data_wr_db;
		elsif (addr_sel = SP) then
			sp_reg			<=	addr_wr_db;
		end if;

		----------------------------------------> PC Register
		if (data_wr_sel = PC) then
			pc_reg			<=	data_wr_db;
		elsif (addr_sel = PC) then
			pc_reg			<=	addr_wr_db;
		end if;

		----------------------------------------> EA Register
		if (data_wr_sel = EA) then
			ea_reg			<=	data_wr_db;
		elsif (addr_sel = EA) then
			ea_reg			<=	addr_wr_db;
		end if;

		----------------------------------------> TMP Register
		if (data_wr_sel = TMP) then
			tmp_reg			<=	data_wr_db;
		elsif (addr_sel = TMP) then
			tmp_reg			<=	addr_wr_db;
		end if;

		--
		----------------------------------------<
		
	end if;

end process;



----------------------------------------> Output Logic
--

ccr_sig			<=	x"00" & ccr_data;

a_reg_u8_sig	<=	x"00" & a_reg;
b_reg_u8_sig	<=	x"00" & b_reg;

d_reg			<=	a_reg & b_reg;

mem_u16_sig		<=	mem_data;

mem_u8_sig		<=	x"00" & mem_data(7 downto 0);

mem_s8_sig		<=	mem_data(7) &
					mem_data(7) &
					mem_data(7) &
					mem_data(7) &

					mem_data(7) &
					mem_data(7) &
					mem_data(7) &
					mem_data(7) &

					mem_data(7 downto 0);



----------------------------------------> Data A Bus MUX
with data_a_sel select
data_a_db	<=	
				x"0000"			when ZERO,
				tmp_reg			when TMP,
				ea_reg			when EA,
				pc_reg			when PC,
				sp_reg			when SP,

				y_reg			when Y,
				x_reg			when X,
				d_reg			when D,
				b_reg_u8_sig	when B,

				a_reg_u8_sig	when A,
				mem_u16_sig		when MEM_U16,
				mem_u8_sig		when MEM_U8,
				mem_s8_sig		when MEM_S8,
				ccr_sig			when CCR,

				irq_vector		when IRQ_VEC,
				x"FFF8"			when others; --TRAP_VEC


----------------------------------------> Data B Bus MUX
with data_b_sel select
data_b_db	<=
				x"0000"			when ZERO,
				tmp_reg			when TMP,
				ea_reg			when EA,
				pc_reg			when PC,
				sp_reg			when SP,

				y_reg			when Y,
				x_reg			when X,
				d_reg			when D,
				b_reg_u8_sig	when B,

				a_reg_u8_sig	when A,
				mem_u16_sig		when MEM_U16,
				mem_u8_sig		when MEM_U8,
				mem_s8_sig		when MEM_S8,
				ccr_sig			when CCR,

				irq_vector		when IRQ_VEC,
				x"FFF8"			when others; --TRAP_VEC


----------------------------------------> Address Bus MUX
with addr_sel select
addr_db	<=		
				x"0000"			when ZERO,
				tmp_reg			when TMP,
				ea_reg			when EA,
				pc_reg			when PC,
				sp_reg			when SP,

				y_reg			when Y,
				x_reg			when X,
				d_reg			when D,
				b_reg_u8_sig	when B,

				a_reg_u8_sig	when A,
				mem_u16_sig		when MEM_U16,
				mem_u8_sig		when MEM_U8,
				mem_s8_sig		when MEM_S8,
				ccr_sig			when CCR,

				irq_vector		when IRQ_VEC,
				x"FFF8"			when others; --TRAP_VEC


----------------------------------------> AMU Read Bus
amu_rd_db(31 downto 24)	<=	a_reg;
amu_rd_db(23 downto 16)	<=	b_reg;
amu_rd_db(15 downto  0)	<=	x_reg;

end behavior;