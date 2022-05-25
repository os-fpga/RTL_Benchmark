-----------------------------------------------------------------------------
--	Copyright (C) 2009 José Rodríguez-Navarro
--
-- This code is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 2.1 of the License, or (at your option) any later version.
--
-- This code is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- Lesser General Public License for more details.
--
--  Identify single/double ones/zeros based on length 
--  of time data_i is high/low
--
--  Revision  Date        Author                Comment
--  --------  ----------  --------------------  ----------------
--  1.0       20/02/09    J. Rodriguez-Navarro  Initial revision
--  Future revisions tracked in Subversion at OpenCores.org
--  under the manchesterwireless project
-----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.globals.all;

--------------------------------------------------------------------------------

entity singleDouble is
  port (
    clk_i   :  in  std_logic;
    ce_i    :  in  std_logic;    
    rst_i   :  in  std_logic;
    data_i  :  in  std_logic;
    q_o     :  out std_logic_vector(3 downto 0);
    ready_o :  out std_logic
  );
end;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

architecture behavioral of singleDouble is

  signal transition_n:   std_logic;
  signal transition_i:   std_logic;

  signal count_ones    : integer range 0 to INTERVAL_MAX_DOUBLE;
  signal count_ones_n  : integer range 0 to INTERVAL_MAX_DOUBLE;
  signal count_zeros   : integer range 0 to INTERVAL_MAX_DOUBLE;
  signal count_zeros_n : integer range 0 to INTERVAL_MAX_DOUBLE;

  signal single_one:      std_logic;
  signal double_one:      std_logic;
  signal single_zero:     std_logic;
  signal double_zero:     std_logic;

  signal data_i_d  :         std_logic;
  signal data_i_d2 :         std_logic;
  signal data_i_d3 :         std_logic;
  signal data_i_d3b:         std_logic;

  begin

  --------------------------------------------------------------------------------
  -- SEQUENTIAL ------------------------------------------------------------------
  --------------------------------------------------------------------------------

  -- Domain Clock (clk_i)
  process (rst_i, clk_i)
  begin

    if rst_i = '1' then
      data_i_d        <= '1';
      data_i_d2       <= '1';
      data_i_d3       <= '1';
      transition_i    <= '0';
      count_ones      <= 0;
      count_zeros     <= 0;
    elsif (rising_edge(clk_i) and ce_i = '1') then -- posedge
      data_i_d3       <= data_i_d2;
      data_i_d2       <= data_i_d;
      data_i_d        <= data_i;
      transition_i    <= transition_n;
      count_ones      <= count_ones_n;
      count_zeros     <= count_zeros_n;
    end if;

  end process;


  --------------------------------------------------------------------------------
  -- COMBINATIONAL ---------------------------------------------------------------
  --------------------------------------------------------------------------------

  -- Mark transition when an edge on data_i is detected
  transition_n <=  data_i_d xor data_i_d2;
  ready_o <= transition_i; -- buffered transition_n

  -- Invert and count zeroes
  data_i_d3b <= not data_i_d3;

  --
  -- Increment counters between transitions every posedge clk_i
  --
  process (transition_i, data_i_d3, data_i_d3b, count_ones, count_zeros)
  begin

    if transition_i = '1' then
      count_ones_n  <= 0;
      count_zeros_n <= 0;
    else
      count_ones_n  <= count_ones + conv_integer(data_i_d3);
      count_zeros_n <= count_zeros + conv_integer(data_i_d3b);
    end if;

  end process;

  --
  -- map single/double one/zero to output
  --
  transition : process (transition_i, rst_i)
  begin

    if (rst_i = '1') then
      q_o <= "0000"; -- protocol dictates an inital one. used in connecting entity
    elsif rising_edge(transition_i) then
      q_o(0) <= single_one;
      q_o(1) <= double_one;
      q_o(2) <= single_zero;
      q_o(3) <= double_zero;  
    end if;

  end process;

  --
  -- unsigned comparators
  --
  process(count_ones)
  begin

    if (count_ones >= INTERVAL_MIN_DOUBLE) and (count_ones <= INTERVAL_MAX_DOUBLE) then
      double_one <= '1';
    else
      double_one <= '0';
    end if;
    if (count_ones >= INTERVAL_MIN_SINGLE) and (count_ones <= INTERVAL_MAX_SINGLE) then
      single_one <= '1';
    else
      single_one <= '0';
    end if;

  end process;

  process(count_zeros)
  begin

    if (count_zeros >= INTERVAL_MIN_DOUBLE) and (count_zeros <= INTERVAL_MAX_DOUBLE) then
      double_zero <= '1';
    else
      double_zero <= '0';
    end if;
    if (count_zeros >= INTERVAL_MIN_SINGLE) and (count_zeros <= INTERVAL_MAX_SINGLE) then
      single_zero <= '1';
    else
      single_zero <= '0';
    end if;

  end process;

end;


