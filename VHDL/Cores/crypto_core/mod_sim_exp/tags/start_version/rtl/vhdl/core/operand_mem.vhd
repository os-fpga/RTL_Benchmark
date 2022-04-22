------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	operand_mem.vhd / entity operand_mem
-- 
-- Last Modified:	18/06/2012 
-- 
-- Description: 	BRAM memory and logic to the store 4 (1536-bit) operands and the
--                modulus for the montgomery multiplier
--
--
-- Dependencies: 	modulus_ram, operand_ram
--
-- Revision:
-- Revision 2.00 - Removed y_register -> seperate module
-- Revision 1.01 - Added "result_dest_op" input
--	Revision 1.00 - Architecture
--	Revision 0.01 - File Created
--
--
------------------------------------------------------------------------------------
--
-- NOTICE:
--
-- Copyright DraMCo research group. 2011. This code may be contain portions patented
-- by other third parties!
--
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity operand_mem is
	generic(n : integer := 1536
	);
   port(-- data interface (plb side)
		  data_in : in  std_logic_vector(31 downto 0);
		  data_out : out  std_logic_vector(31 downto 0);
		  rw_address : in  std_logic_vector(8 downto 0);
		  -- address structure:
		  -- bit:  8   -> '1': modulus
		  --              '0': operands
		  -- bits: 7-6 -> operand_in_sel in case of bit 8 = '0'
		  --              don't care in case of modulus
		  -- bits: 5-0 -> modulus_addr / operand_addr resp.
		  
		  -- operand interface (multiplier side)
		  op_sel : in  std_logic_vector(1 downto 0);
		  xy_out : out  std_logic_vector(1535 downto 0);
		  m : out  std_logic_vector(1535 downto 0);
		  result_in : in std_logic_vector(1535 downto 0);
		  -- control signals
		  load_op : in std_logic;
		  load_m : in std_logic;
		  load_result : in std_logic;
		  result_dest_op : in std_logic_vector(1 downto 0);
		  collision : out std_logic;
		  -- system clock
		  clk : in  std_logic
	);
end operand_mem;

architecture Behavioral of operand_mem is
	-- single port (32-bit -> 1536-bit) block ram
	component modulus_ram
	port(
		clk : in std_logic;
		modulus_addr : in std_logic_vector(5 downto 0);
		write_modulus : in std_logic;
		modulus_in : in std_logic_vector(31 downto 0);
		modulus_out : out std_logic_vector(1535 downto 0)
	);
	end component;

	-- dual port block ram
	component operand_ram
	port(
		clk : in std_logic;
		operand_addr : in std_logic_vector(5 downto 0);
		operand_in : in std_logic_vector(31 downto 0);
		operand_in_sel : in std_logic_vector(1 downto 0);
		write_operand : in std_logic;
		operand_out_sel : in std_logic_vector(1 downto 0);
		result_dest_op : in std_logic_vector(1 downto 0);
		write_result : in std_logic;
		result_in : in std_logic_vector(1535 downto 0);          
		collision : out std_logic;
		result_out : out std_logic_vector(31 downto 0);
		operand_out : out std_logic_vector(1535 downto 0)
		);
	end component;

	signal xy_data_i : std_logic_vector(31 downto 0);
	signal xy_addr_i : std_logic_vector(5 downto 0);
	signal operand_in_sel_i : std_logic_vector(1 downto 0);
	signal collision_i : std_logic;

	signal xy_op_i : std_logic_vector(1535 downto 0);
	
	signal m_addr_i : std_logic_vector(5 downto 0);
	signal write_m_i : std_logic;
	signal m_data_i : std_logic_vector(31 downto 0);
begin

	-- map outputs
	xy_out <= xy_op_i;
	collision <= collision_i;

	-- map inputs
	xy_addr_i <= rw_address(5 downto 0);
	m_addr_i <= rw_address(5 downto 0);
	operand_in_sel_i <= rw_address(7 downto 6);
	xy_data_i <= data_in;
	m_data_i <= data_in;
	write_m_i <= load_m;

	-- xy operand storage
	xy_ram: operand_ram port map(
		clk => clk,
		collision => collision_i,
		operand_addr => xy_addr_i,
		operand_in => xy_data_i,
		operand_in_sel => operand_in_sel_i,
		result_out => data_out,
		write_operand => load_op,
		operand_out => xy_op_i,
		operand_out_sel => op_sel,
		result_dest_op => result_dest_op,
		write_result => load_result,
		result_in => result_in
	);
	
	-- modulus storage
	m_ram : modulus_ram
	port map(
		clk => clk,
		modulus_addr => m_addr_i,
		write_modulus => write_m_i,
		modulus_in => m_data_i,
		modulus_out => m
	);
	
end Behavioral;

