---------------------------------------------------------------------- 
----                                                              ---- 
----  VHDL Wishbone TESTBENCH                                     ---- 
----                                                              ---- 
----  This file is part of the vhdl_wb_tb project                 ---- 
----  http://www.opencores.org/cores/vhdl_wb_tb/                  ---- 
----                                                              ---- 
----  This file contains the verifier module which monitors the   ----
----  DUTs responses. It is controlled via a wishbone interface   ----
----  by the tc_xxxx files.                                       ---- 
----  It can check the signals by itself or forward information   ----
----  To the tc_xxxx files.                                       ----
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
use work.my_project_pkg.all;
use work.wishbone_bfm_pkg.all;

-- entity ------------------------------------------------------------
entity verifier is
  generic(
    number_of_signals_g             : natural := 1
    );  
  port( 
    wb_i                            : in wishbone_slave_in_t;
    wb_o                            : out wishbone_slave_out_t;
    
    signals_i                       : in std_logic_vector(number_of_signals_g-1 downto 0)
    );
end verifier;

-- architecture ----------------------------------------------------------------
architecture rtl of verifier is
  ------------------------------------------------------------------------------
  -- signal declaration
  ------------------------------------------------------------------------------
  signal  register0_s                    : std_logic_vector(31 downto 0);
  signal  register1_s                    : std_logic_vector(31 downto 0);
  ------------------------------------------------------------------------------
begin
  ------------------------------------------------------------------------------
  wb_o.ack <= '1';
  wb_o.err <= '0';
  wb_o.rty <= '0';
  wb_o.int <= '0';
  wb_o.tgd <= (others => '0');
  
  -- read data multiplexer
  proc_read_data_mux : process (all)
    begin 
      case wb_i.adr(27 downto 0) is
        when 28X"000_0000" =>
          wb_o.dat <= register0_s;
        when 28X"000_0004" =>
          wb_o.dat <= register1_s;
        when 28X"000_0008" =>
          wb_o.dat <= zero_c(wb_o.dat'left downto signals_i'left+1) & signals_i;
        when others =>
          wb_o.dat <= (others =>'U');
      end case;
    end process;
  ------------------------------------------------------------------------------
  -- write signals to control the verifier
  proc_avalon_write_data  : process (all)
    begin
      if (wb_i.rst = '1') then
        register0_s        <= (others => '0');
        register1_s        <= (others => '0');
      elsif (rising_edge(wb_i.clk)) then
        if (wb_i.we = '1' AND wb_i.stb = '1' AND wb_i.sel = X"F" AND wb_i.cyc = '1') then
          case wb_i.adr(27 downto 0) is
            when 28X"000_0000" =>
              register0_s        <= wb_i.dat;
            when 28X"000_0004" =>
              register1_s        <= wb_i.dat;
            when others =>
          end case;
        end if;
      end if;
    end process;
    
  ------------------------------------------------------------------------------
end rtl; --verifier
----------------------------------------------------------------------
---- end of file                                                  ---- 
----------------------------------------------------------------------