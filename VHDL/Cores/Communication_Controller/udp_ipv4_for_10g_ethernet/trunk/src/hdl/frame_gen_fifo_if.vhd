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
-- This module is aimed to be used together with frame_tx_if module.
-- Together they provide FIFO buffering for frame_gen module that makes
-- it a bit more convenient in cases where data are not available 
-- in every cycle and/or length of data is not known in advance.
--
-- It transform frame_gen interface to FIFO interface sink.
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.frame_pkg.all;

Library UNISIM;
use UNISIM.vcomponents.all;


entity frame_gen_fifo_if is
   port (
      CLK            : in  std_logic;

      DST_MAC        : out mac_addr_type;
      DST_IP         : out ip_addr_type;
      SRC_UDP        : out udp_port_type;
      DST_UDP        : out udp_port_type;

      -- Frame generator if
      FG_TX_EN       : out std_logic;
      FG_BUSY        : in  std_logic;
      FG_DATA_REN    : in  std_logic;
      FG_DATA_IN     : out std_logic_vector(63 downto 0);
      FG_DATA_LEN    : out std_logic_vector(15 downto 0);

      -- Tag and data fifos
      DFIFO_DATA     : in  txi_dfifo_data_type;
      DFIFO_RD_EN    : out std_logic;
      DFIFO_EMPTY    : in  std_logic;

      TFIFO_DATA     : in  txi_tfifo_data_type;
      TFIFO_RD_EN    : out std_logic;
      TFIFO_EMPTY    : in  std_logic

        );
end entity;

architecture synthesis of frame_gen_fifo_if is

   signal dfifo_data_be    : std_logic_vector(7 downto 0);
   signal dfifo_data_data  : std_logic_vector(63 downto 0);
   signal dfifo_data_data_d: std_logic_vector(63 downto 0);
   signal dfifo_rd_en_i    : std_logic;
   signal tfifo_rd_en_i    : std_logic;

   signal dst_mac_i        : mac_addr_type;
   signal dst_udp_i        : udp_port_type;

   signal fg_data_ren_d    : std_logic;

begin

   dfifo_data_data <= DFIFO_DATA(63 downto 0);
   dfifo_data_be <= DFIFO_DATA(71 downto 64);

   destination_info_proc : process(CLK)
   begin
      if rising_edge(CLK) then
         fg_data_ren_d <= FG_DATA_REN;
         dfifo_data_data_d <= dfifo_data_data;
         if dfifo_rd_en_i = '1' then
            dst_mac_i <= dfifo_data_data(63 downto 16);
            dst_udp_i <= dfifo_data_data(15 downto 0);
            DST_IP  <= dst_mac_i(DST_IP'range);
            SRC_UDP <= dst_udp_i;
         end if;
      end if;
   end process;


   rd_proc : process(TFIFO_EMPTY, FG_BUSY, DFIFO_EMPTY, dfifo_data_be,
                     fg_data_ren_d, FG_DATA_REN)
   begin
      dfifo_rd_en_i <= '0';
      tfifo_rd_en_i <= '0';
      FG_TX_EN <= '0';

      if TFIFO_EMPTY = '0' and FG_BUSY = '0' then
         -- Whole frame is ready for us, start transfer
         FG_TX_EN <= '1';
         tfifo_rd_en_i <= '1';
      end if;
       

      if DFIFO_EMPTY = '0' then
         if unsigned(dfifo_data_be) = 0 or 
                  FG_DATA_REN = '1' then
            -- This is either destination info or empty word 
            dfifo_rd_en_i <= '1';
         end if;
      end if;     

   end process;

   FG_DATA_IN  <= dfifo_data_data_d;
   FG_DATA_LEN <= TFIFO_DATA;
   DFIFO_RD_EN <= dfifo_rd_en_i;
   TFIFO_RD_EN <= tfifo_rd_en_i;

   DST_MAC <= dst_mac_i;
   DST_UDP <= dst_udp_i;

end architecture;




