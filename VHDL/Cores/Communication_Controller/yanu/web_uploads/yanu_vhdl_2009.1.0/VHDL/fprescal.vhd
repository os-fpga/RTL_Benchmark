---------------------------------------------------------------------
--	Filename:	fprescal.vhd
--
--			
--	Description:
--		 fprescal: a fractionary prescaler
--              
--	Copyright (c) 2009 by Renato Andreola (Imagos sas)
--
--	This file is part of YANU.
--	YANU is free software: you can redistribute it and/or modify
--	it under the terms of the GNU Lesser General Public License as published by
--	the Free Software Foundation, either version 3 of the License, or
--	(at your option) any later version.
--	YANU is distributed in the hope that it will be useful,
--	but WITHOUT ANY WARRANTY; without even the implied warranty of
--	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--	GNU Lesser General Public License for more details.
--
--	You should have received a copy of the GNU Lesser General Public License
--	along with YANU.  If not, see <http://www.gnu.org/licenses/>.
--	
--	Revision	History:
--	Revision	Date      	Author   	Comment
--	--------	----------	---------	-----------
--	1.0     	30/05/2009	Renato Andreola	Initial revision
--	
--------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Top-level floating point prescaler entity
entity fprescal is
  generic
    (
      NMANTISSA : integer := 12;        -- number of DDS (rational divider) bits 
      NEXP      : integer := 4          -- number of 2^NEXP prescaler divider bits
      );
  port
    (
      clk, reset : in  std_logic;
      divisor    : in  std_logic_vector(NEXP+NMANTISSA-1 downto 0);
      output     : out std_logic
      );
end fprescal;

architecture arch_fprescal of fprescal is

  constant NPRESCAL : integer := (2**NEXP) -1;  -- number of /2 input stages (to be selected with NEXP exponent bits)

  ----------------------------------------------------------------------------------------------------------------------
  -- REGISTERS (and their "_in" input nodes)
  -- DDS accumulator: hold NMANTISSA bits and counts upward: dds(n+1) = (dds(n) + mantissa) mod 2^NMANTISSA 
  signal dds, dds_in                 : std_logic_vector(NMANTISSA -1 downto 0) := (others => '0');
  -- 2^Nx input prescaler
  signal prescal, prescal_in         : std_logic_vector(NPRESCAL -1 downto 0)  := (others => '0');
  -- output glitch free pulse generator
  signal zddsmsb, zddsmsb_in         : std_logic                               := '0';
  -- prescaler stage selected from exponent index
  signal prescal_bit, prescal_bit_in : std_logic_vector(1 downto 0)            := (others => '0');

  -------------------------------------------------------
  -- returns the number of '1' bits into the input vector
  -------------------------------------------------------
  function num_ones (signal word : in std_logic_vector; constant osize : in natural) return std_logic_vector is
    variable result : unsigned(osize -1 downto 0);
    variable i      : natural;
  begin
    result := (others => '0');
    for i in word'range loop
      if word(i) = '1' then
        result := result +1;
      end if;
    end loop;
    return std_logic_vector(result);
  end num_ones;

begin

  -- fpprescal sequential process:  registers update
  fprescal_sp : process (clk) is
  begin
    if rising_edge(clk) then
      dds         <= dds_in;
      prescal     <= prescal_in;
      prescal_bit <= prescal_bit_in;
      zddsmsb     <= zddsmsb_in;
    end if;
  end process fprescal_sp;

  -- fprescal combinatorial process: handles reset, dds/prescaler update and pulse generation
  fprescal_cp : process (dds, divisor, prescal, prescal_bit, reset, zddsmsb) is
    variable i : integer;
  begin
    if reset = '1' then
      prescal_in     <= (others => '0');
      dds_in         <= (others => '0');
      prescal_bit_in <= (others => '0');
      zddsmsb_in     <= '0';
    else
      -- pipelined version of A prescale bit
      prescal_bit_in(1) <= '0';
      for i in 1 to NPRESCAL loop
        if i = to_integer(unsigned(divisor(NEXP+NMANTISSA-1 downto NMANTISSA))) then
          prescal_bit_in(1) <= prescal(i-1);
        end if;
      end loop;  -- i
      prescal_bit_in(0) <= prescal_bit(1);

      -- DDS accumulator... update only on prescaler output bit changes
      dds_in <= dds;
      if (0 = to_integer(unsigned(divisor(NEXP+NMANTISSA-1 downto NMANTISSA)))) or ((prescal_bit(1) = '1') and (prescal_bit(0) = '0')) then
        dds_in <= std_logic_vector(unsigned(dds) + unsigned(divisor(NMANTISSA-1 downto 0)));
      end if;

      -- prescaler (synchronous) counter
      prescal_in <= std_logic_vector(unsigned(prescal) +1);

      -- output pulse
      zddsmsb_in <= dds(NMANTISSA -1);
    end if;
    -- output: on dds(msb) rising edge  generate a whole high clock pulse
    output <= not zddsmsb and dds(NMANTISSA -1);
  end process fprescal_cp;
  
end arch_fprescal;


