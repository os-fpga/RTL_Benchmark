-------------------------------------------------------------------------------
--
-- (C) Copyright 2017 DFC Design, s.r.o., Brno, Czech Republic
-- Author: Marek Kvas (m.kvas@dfcdesign.cz)
--
-------------------------------------------------------------------------------
-- This file is part of UDP/IPv4 for 10 G Ethernet core.
-- 
-- UDP/IPv4 for 10 G Ethernet core is free software: you can 
-- redistribute it and/or modify it under the terms of 
-- the GNU Lesser General Public License as published by the Free 
-- Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-- 
-- UDP/IPv4 for 10 G Ethernet core is distributed in the hope that 
-- it will be useful, but WITHOUT ANY WARRANTY; without even 
-- the implied warranty of MERCHANTABILITY or FITNESS FOR A 
-- PARTICULAR PURPOSE.  See the GNU Lesser General Public License 
-- for more details.
-- 
-- You should have received a copy of the GNU Lesser General Public 
-- License along with UDP/IPv4 for 10 G Ethernet core.  If not, 
-- see <http://www.gnu.org/licenses/>.
-------------------------------------------------------------------------------
--
-- This simple core is used to slow transmission of frames down when
-- link speed is lower than maximum 10 Gbps. AS RXAUI runs on the same
-- frequency regardless of link speed and data are stored in the PHY FIFO
-- it is necessary to insert such IFG that average speed is equal to
-- link speed. Otherwise PHY FIFO overflows and frames get corrupted.
--
-- Output is combinatorial.
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity frame_throttle is
   port (
      CLK            : in  std_logic;

      LINK_SPEED     : in  std_logic_vector(2 downto 0);
      
      FG_BUSY        : in  std_logic;
      FG_IDLE_IFG    : in  std_logic;
      BUSY_THROTTLED : out std_logic
        );
end entity;



architecture synthesis of frame_throttle is

   function spd_to_ratio_cnt(spd : std_logic_vector) return natural is
      variable ratio : natural;
   begin
      case to_integer(unsigned(spd)) is
         -- 10 Gbps must be handled differently
         when 1 => ratio := 2; -- 5 Gbps
         when 2 => ratio := 4; -- 2.5 Gbps
         when 3 => ratio := 10; -- 1 Gbps
         when 4 => ratio := 100; -- 100 Mbps
         when others => ratio := 1000; -- 10 Mbps and unsupported link speds
      end case;
      return ratio;
   end function;

   signal busy_throttle_i     : std_logic;
   signal throttle_cnt        : integer range 0 to 2**16-1;
   signal ratio_cnt           : integer range 0 to 1000 -1;


begin
   
   throttle_proc : process(CLK)
   begin
      if rising_edge(CLK) then
         if LINK_SPEED = "000" then
            -- 10 Gbps - maximal speed
            busy_throttle_i <= '0';
         elsif FG_BUSY = '1' or FG_IDLE_IFG = '1' then
            busy_throttle_i <= '1';
            throttle_cnt <= throttle_cnt + 1;
            ratio_cnt <= 0;
         else
            -- -1 for one cycle spent in cycle counting and
            -- -1 for counter limit as usual forms -2 altogether.
            if ratio_cnt < spd_to_ratio_cnt(LINK_SPEED) - 2 then
               ratio_cnt <= ratio_cnt + 1;
            else
               ratio_cnt <= 0;
               if throttle_cnt > 1 then
                  throttle_cnt <= throttle_cnt - 1;
               else
                  busy_throttle_i <= '0';
               end if;
            end if;
         end if;
      end if;
   end process;


   BUSY_THROTTLED <= FG_BUSY or busy_throttle_i;

end architecture;







