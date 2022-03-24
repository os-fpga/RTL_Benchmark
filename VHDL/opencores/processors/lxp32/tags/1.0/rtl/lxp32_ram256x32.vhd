---------------------------------------------------------------------
-- Generic dual-port memory
--
-- Part of the LXP32 CPU
--
-- Copyright (c) 2016 by Alex I. Kuznetsov
--
-- Portable description of a dual-port memory block with one write
-- port. Major FPGA synthesis tools can infer on-chip block RAM
-- from this description. Can be replaced with a library component
-- wrapper if needed.
---------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lxp32_ram256x32 is
	port(
		wclk_i: in std_logic;
		we_i: in std_logic;
		waddr_i: in std_logic_vector(7 downto 0);
		wdata_i: in std_logic_vector(31 downto 0);
		
		rclk_i: in std_logic;
		re_i: in std_logic;
		raddr_i: in std_logic_vector(7 downto 0);
		rdata_o: out std_logic_vector(31 downto 0)
	);
end entity;

architecture rtl of lxp32_ram256x32 is

type ram_type is array(255 downto 0) of std_logic_vector(31 downto 0);
signal ram: ram_type:=(others=>(others=>'0')); -- zero-initialize for SRAM-based FPGAs

attribute syn_ramstyle: string;
attribute syn_ramstyle of ram: signal is "block_ram,no_rw_check";
attribute ram_style: string; -- for Xilinx
attribute ram_style of ram: signal is "block";

begin

-- Write port

process (wclk_i) is
begin
	if rising_edge(wclk_i) then
		if we_i='1' then
			ram(to_integer(unsigned(waddr_i)))<=wdata_i;
		end if;
	end if;
end process;

-- Read port

process (rclk_i) is
begin
	if rising_edge(rclk_i) then
		if re_i='1' then
			rdata_o<=ram(to_integer(to_01(unsigned(raddr_i))));
		end if;
	end if;
end process;

end architecture;
