---------------------------------------------------------------------- 
----                                                              ---- 
----  VHDL Wishbone TESTBENCH                                     ---- 
----                                                              ---- 
----  This file is part of the vhdl_wb_tb project                 ---- 
----  https://opencores.org/project/vhdl_wb_tb                    ---- 
----                                                              ---- 
----  This file contains the highest (top) module for simulation. ----
----  Like tb_top it instantiates the core_top module and         ----
----  provides parameters/generics. Where the top module provides ---- 
----  parameters for synthesis this file provides parameters for  ----
----  simulation.                                                 ----
----                                                              ---- 
----  It instantiates the design under test (DUT), instantiates   ----
----  the stimulator module for test vector generation,           ----
----  instantiates the verifier module for result comparison,     ----
----  instantiates the test case top (testcase_top) bfm,          ----
----  interconnects all three components, generates DUT-external  ----
----  clocks and resets.                                          ----
----                                                              ---- 
----  To Do:                                                      ---- 
----   -                                                          ---- 
----                                                              ---- 
----  Author(s):                                                  ---- 
----      - Sinx, sinx@opencores.org                              ---- 
----                                                              ---- 
----------------------------------------------------------------------
----    SVN information
----
----      $URL:  $
---- $Revision:  $
----     $Date:  $
----   $Author:  $
----       $Id:  $
---------------------------------------------------------------------- 
----                                                              ---- 
---- Copyright (C) 2018 Authors and OPENCORES.ORG                 ---- 
----                                                              ---- 
---- This source file may be used and distributed without         ---- 
---- restriction provided that this copyright statement is not    ---- 
---- removed from the file and that any derivative work contains  ---- 
---- the original copyright notice and the associated disclaimer. ---- 
----                                                              ---- 
---- This source file is free software; you can redistribute it   ---- 
---- and/or modify it under the terms of the GNU Lesser General   ---- 
---- Public License as published by the Free Software Foundation; ---- 
---- either version 2.1 of the License, or (at your option) any   ---- 
---- later version.                                               ---- 
----                                                              ---- 
---- This source is distributed in the hope that it will be       ---- 
---- useful, but WITHOUT ANY WARRANTY; without even the implied   ---- 
---- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ---- 
---- PURPOSE.  See the GNU Lesser General Public License for more ---- 
---- details.                                                     ---- 
----                                                              ---- 
---- You should have received a copy of the GNU Lesser General    ---- 
---- Public License along with this source; if not, download it   ---- 
---- from http://www.opencores.org/lgpl.shtml                     ---- 
----                                                              ---- 
----------------------------------------------------------------------

-- library -----------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.convert_pkg.all;
use work.wishbone_pkg.all;
use work.wishbone_bfm_pkg.all;

-- entity ------------------------------------------------------------
entity tb_top is
  -- empty entity, since this is the simulation top and all test cases are defined
  -- in the tc_xxx files.
end entity tb_top;

-- architecture ------------------------------------------------------
architecture rtl of tb_top is
  -----------------------------------------------------------------------------
  constant  wb_clock_period_g               : time     := 20.0 ns;   -- 50 mhz
  -----------------------------------------------------------------------------
  signal wb_bfm_out_s                 : wishbone_bfm_master_out_t; -- from testcase_top
  signal wb_bfm_in_s                  : wishbone_bfm_master_in_t;  -- to testcase_top
        
  signal wb_master_out_s              : wishbone_master_out_t;    -- from wb_decoder
  signal wb_master_in_s               : wishbone_master_in_t;    -- to wb_decoder
      
  constant number_of_wb_slaves_c      : integer := 2;
  signal wb_slaves_in_s               : wishbone_slave_in_array_t (number_of_wb_slaves_c-1 downto 0);
  signal wb_slaves_out_s              : wishbone_slave_out_array_t (number_of_wb_slaves_c-1 downto 0);
      
  signal wb_clock_s                   : std_logic := '0';
  signal wb_clock_locked_s            : std_logic := '0';
  signal wb_reset_p1_s                : std_logic := '1';
  signal wb_reset_p2_s                : std_logic := '1';
  signal wb_reset_s                   : std_logic := '1';
  
  constant number_of_stimulus_signals_c : integer := 8;
  constant number_of_verify_signals_c   : integer := 8;
  signal stimulus_s                   : std_logic_vector(number_of_stimulus_signals_c-1 downto 0);
  signal verify_s                     : std_logic_vector(number_of_verify_signals_c-1 downto 0);
  -----------------------------------------------------------------------------
begin
  -----------------------------------------------------------------------------
  --clocks---------------------------------------------------------------------
  wb_clock_generator : process -- required for test bench wb bus; 50mhz is standard
  begin
    wb_clock_s        <= '0';
    wait for wb_clock_period_g/2;
    wb_clock_s        <= '1';
    wait for wb_clock_period_g/2;
    wb_clock_locked_s <= '1';
  end process;
  -----------------------------------------------------------------------------
  synchronize_reset_proc : process(all) 
  begin
    if (wb_clock_locked_s = '0') then
      wb_reset_p1_s <= '1';
      wb_reset_p2_s <= '1';
    elsif (rising_edge(wb_clock_s)) then
      wb_reset_p1_s <= '0'; -- or tc_reset_s;
      wb_reset_p2_s <= wb_reset_p1_s;
    end if;
  end process;
  wb_reset_s   <= wb_reset_p2_s;
  -----------------------------------------------------------------------------
  -- instance of test case "player"; runs tc_xxxx modules
  tc_top_inst : entity work.tc_top
    port map (
      wb_o                => wb_bfm_out_s,
      wb_i                => wb_bfm_in_s
      );
  -----------------------------------------------------------------------------
  -- splits the test case wb bus for all stimulation and verifier modules.
  -- decodes the given bits (decoded_address_msb_g:decoded_address_lsb_g) and#
  -- compares them to 0..n, with n=(number_of_ports_g-1)
  proc_readdata_decoder  : process (all)
    begin
      wb_bfm_in_s.dat <= (others => 'U');
      wb_bfm_in_s.ack <= '1';
      wb_bfm_in_s.clk <= wb_clock_s;
      wb_bfm_in_s.int <= '0';
      wb_bfm_in_s.rst <= wb_reset_s;
      for I in number_of_wb_slaves_c-1 downto 0 loop
        wb_slaves_in_s(I) <= work.wishbone_pkg.wb_master_out_idle_c; -- default values are init (idle) values
        wb_slaves_in_s(I).clk <= wb_clock_s;
        wb_slaves_in_s(I).rst <= wb_reset_s OR wb_bfm_out_s.rst;
        if ( wb_bfm_out_s.adr(31 downto 28) = to_std_logic_vector(I,4)) then -- decode the upper nibble for module decoding
          wb_bfm_in_s.dat <= wb_slaves_out_s(I).dat;
          wb_bfm_in_s.ack <= wb_slaves_out_s(I).ack;
          wb_slaves_in_s(I).dat <= wb_bfm_out_s.dat;
          wb_slaves_in_s(I).tgd  <= wb_bfm_out_s.tgd;
          wb_slaves_in_s(I).adr  <= wb_bfm_out_s.adr;
          wb_slaves_in_s(I).cyc  <= wb_bfm_out_s.cyc;
          wb_slaves_in_s(I).lock <= wb_bfm_out_s.lock;
          wb_slaves_in_s(I).sel  <= wb_bfm_out_s.sel;
          wb_slaves_in_s(I).stb  <= wb_bfm_out_s.stb;
          wb_slaves_in_s(I).tga  <= wb_bfm_out_s.tga;
          wb_slaves_in_s(I).tgc  <= wb_bfm_out_s.tgc;
          wb_slaves_in_s(I).we   <= wb_bfm_out_s.we;
        end if;
      end loop;
  end process;
  -----------------------------------------------------------------------------
  -- instance of design under test
  core_top_inst : entity work.core_top
    generic map(
      number_of_in_signals_g              => number_of_stimulus_signals_c,
      number_of_out_signals_g             => number_of_verify_signals_c
      )
    port map(
      clock_i                             => wb_clock_s,
      reset_i                             => wb_reset_s,
      signals_i                           => stimulus_s,
      signals_o                           => verify_s
      );
  -----------------------------------------------------------------------------
  -- instance of stimulator
  stimulator_inst : entity work.stimulator
    generic map(
      number_of_signals_g                 => number_of_stimulus_signals_c
      )
    port map(
      wb_i                                => wb_slaves_in_s(0),
      wb_o                                => wb_slaves_out_s(0),
      signals_o                           => stimulus_s
      );
  -----------------------------------------------------------------------------
  -- instance of stimulator
  verifier_inst : entity work.verifier
    generic map(
      number_of_signals_g                 => number_of_verify_signals_c
      )
    port map(
      wb_i                                => wb_slaves_in_s(1),
      wb_o                                => wb_slaves_out_s(1),
      signals_i                           => verify_s
      );
  -----------------------------------------------------------------------------
end rtl;
----------------------------------------------------------------------
---- end of file                                                  ---- 
----------------------------------------------------------------------