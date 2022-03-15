--==========================> Gator uProccessor <===========================--
-- VECTOR_SPLIT.VHD	
-- Engineer:	Kevin Phillipson
-- Date:		02/09/2007									Revision:4.01.07
-- Description: 
--
--==========================================================================--

library ieee;
use ieee.std_logic_1164.all;

entity vector_split is

--============================> Port Map <==================================--

port
(
	
	----------------------------------------> Microprogram Word
	--
	micro_prog_data	:	in	std_logic_vector(55 downto  0);
	--
	----------------------------------------<
	
	----------------------------------------> Microsquencer
	--
	true_false		:	out	std_logic;
	micro_op		:	out	std_logic_vector( 3 downto  0);
	branch_addr		:	out	std_logic_vector( 7 downto  0);
	--
	----------------------------------------<

	----------------------------------------> CCR
	--
	ccr_op			:	out	std_logic_vector( 4 downto  0);
	alu_cond_sel	:	out	std_logic_vector( 1 downto  0);
	usq_cond_sel	:	out	std_logic_vector( 3 downto  0);
	--
	----------------------------------------<

	----------------------------------------> Register Array
	--
	addr_sel		:	out	std_logic_vector( 3 downto  0);
	data_a_sel		:	out	std_logic_vector( 3 downto  0);
	data_b_sel		:	out	std_logic_vector( 3 downto  0);
	data_wr_sel		:	out	std_logic_vector( 3 downto  0);
	--
	----------------------------------------<

	----------------------------------------> Adress ALU
	--
	addr_alu_op		:	out	std_logic_vector( 3 downto  0);
	--
	----------------------------------------<

	----------------------------------------> Data ALU
	--
	data_alu_op		:	out	std_logic_vector( 2 downto  0);
	data_alu_mode	:	out	std_logic;
	--
	----------------------------------------<

	----------------------------------------> Memory Controller
	--
	mem_func_sel	:	out	std_logic_vector( 2 downto  0);
	--
	----------------------------------------<

	----------------------------------------> Advanced Math Unit
	--
	amu_op			:	out	std_logic_vector( 1 downto  0);
	amu_wr_sel		:	out	std_logic_vector( 1 downto  0)
	--
	----------------------------------------<

);

--==========================================================================--

end vector_split;

architecture behavior of vector_split is 

--==============================> Signals <=================================--

--==========================================================================--

begin

	----------------------------------------> Microsquencer
	--
	micro_op		<=	micro_prog_data(55 downto 52);	-- 4
	true_false		<=	micro_prog_data(51);			-- 1
	branch_addr		<=	micro_prog_data(50 downto 43);	-- 8
	--
	----------------------------------------<

	----------------------------------------> CCR
	--
	ccr_op			<=	micro_prog_data(42 downto 38);	-- 5
	alu_cond_sel	<=	micro_prog_data(37 downto 36);  -- 2
	usq_cond_sel	<=	micro_prog_data(35 downto 32);	-- 4
	--
	----------------------------------------<

	----------------------------------------> Register Array
	--
	addr_sel		<=	micro_prog_data(31 downto 28);	-- 4
	data_a_sel		<=	micro_prog_data(27 downto 24);	-- 4
	data_b_sel		<=	micro_prog_data(23 downto 20);	-- 4
	data_wr_sel		<=	micro_prog_data(19 downto 16);	-- 4
	--
	----------------------------------------<

	----------------------------------------> Adress ALU
	--
	addr_alu_op		<=	micro_prog_data(15 downto 12);	-- 4
	--
	----------------------------------------<

	----------------------------------------> Data ALU
	--
	data_alu_op		<=	micro_prog_data(11 downto  9);	-- 3
	data_alu_mode	<=	micro_prog_data( 8);			-- 1
	--
	----------------------------------------<

	----------------------------------------> Memory Controller
	--
	mem_func_sel	<=	micro_prog_data( 7 downto  5);	-- 3
	--
	----------------------------------------<

	----------------------------------------> Advanced Math Unit
	--
	amu_op			<=	micro_prog_data( 4 downto  3);	-- 2
	amu_wr_sel		<=	micro_prog_data( 2 downto  1);	-- 2
	--
	----------------------------------------<

end behavior;