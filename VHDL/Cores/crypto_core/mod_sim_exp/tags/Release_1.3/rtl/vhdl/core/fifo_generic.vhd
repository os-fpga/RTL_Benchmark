----------------------------------------------------------------------  
----  fifo_generic                                                ---- 
----                                                              ---- 
----  This file is part of the                                    ----
----    Modular Simultaneous Exponentiation Core project          ---- 
----    http://www.opencores.org/cores/mod_sim_exp/               ---- 
----                                                              ---- 
----  Description                                                 ---- 
----    behavorial description of a FIFO, correctly inferred by   ----
----    altera and xilinx.                                        ----
----                                                              ----
----  Resources needed (xilinx):                                  ----
----    - RAM: (depth+1 * 32) bits                                ----
----    - 2 adders/substractors                                   ----
----    - 2 comparators                                           ----
----    - 2 registers: aw bits  (for the address pointers)        ----
----    - 3 registers:  1 bit (for the flags)                     ----
----                                                              ----
----  Authors:                                                    ----
----      - Geoffrey Ottoy, DraMCo research group                 ----
----      - Jonas De Craene, JonasDC@opencores.org                ---- 
----                                                              ---- 
---------------------------------------------------------------------- 
----                                                              ---- 
---- Copyright (C) 2011 DraMCo research group and OPENCORES.ORG   ---- 
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

library mod_sim_exp;
use mod_sim_exp.mod_sim_exp_pkg.all;
use mod_sim_exp.std_functions.all;

entity fifo_generic is
  generic (
    depth : integer := 32
  );
  port  (
    clk    : in  std_logic; -- clock input
    din    : in  std_logic_vector (31 downto 0); -- 32 bit input data for push
    dout   : out  std_logic_vector (31 downto 0); -- 32 bit output data for pop
    empty  : out  std_logic; -- empty flag, 1 when FIFO is empty
    full   : out  std_logic; -- full flag, 1 when FIFO is full
    push   : in  std_logic;  
    pop    : in  std_logic;
    reset  : in std_logic;
    nopop  : out std_logic;
    nopush : out std_logic
  );
end fifo_generic;

architecture arch of fifo_generic is
  -- calculate the width for the address-pointers
  constant aw : integer := log2(depth+1);

  -- read and write pointer
  signal rd_addr : std_logic_vector(aw-1 downto 0);
  signal wr_addr : std_logic_vector(aw-1 downto 0);
  
  -- control signals
  signal empty_i  : std_logic;
  signal full_i   : std_logic;
  signal push_i   : std_logic;
  signal push_i_d : std_logic;
  signal pop_i    : std_logic;
begin
  
  empty <= empty_i;
  full <= full_i;
  -- full flag is 1 when read address is one below write address
  full_i <= '1' when (wr_addr+'1'=rd_addr) or 
                      (wr_addr=conv_std_logic_vector(depth, aw) and (rd_addr=conv_std_logic_vector(0, aw))) 
                else '0';
  -- empty flag is 1 when read and write address are the same
  empty_i <= '1' when (wr_addr=rd_addr) else '0';
  
  fifo_addr_proc : process (clk)
  begin     
    if rising_edge(clk) then
      if reset='1' then -- if reset, both read and write address point to the maximum address (depth)
        wr_addr <= conv_std_logic_vector(depth, aw);
        rd_addr <= conv_std_logic_vector(depth, aw);
      else
        if push_i='1' then -- push
          if (wr_addr=conv_std_logic_vector(depth, aw)) then
            wr_addr <= (others=>'0'); -- if overflow, set to zero
          else
            wr_addr <= wr_addr+'1'; -- else, increase address
          end if;
        end if;
        
        if pop_i='1' then -- pop
          if (rd_addr=conv_std_logic_vector(depth, aw)) then
            rd_addr <= (others=>'0'); -- if overflow, set to zero
          else
            rd_addr <= rd_addr+'1'; -- else, increase address
          end if;
        end if;
      end if;
      push_i_d <= push_i; -- delayed version of push signal
      
      nopop <= (pop and empty_i) or (pop and reset);
      nopush <= (push and full_i) or (push and reset);
    end if;
  end process;
  
  push_i <= push and not full_i;
  pop_i <= pop and not empty_i;
  
  -- Block RAM
  ramblock: dpram_generic
    generic map(
      depth => depth+1
    )
    port map(
      clk   => clk,
      -- write port
      waddr => wr_addr,
      we    => push_i_d,
      din   => din,
      -- read port
      raddr => rd_addr,
      dout  => dout
    );

end arch;
