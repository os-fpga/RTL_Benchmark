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
-- This module adapts TX interface of frame_gen module to be closer to
-- the one used by RX path. It adds FIFO to TX data path so users don't
-- have to provide data in each cycle and length doesn't have to be known
-- in advance.
--
--
-- Two FIFOs are used. One to store data from user, the other one to store
-- tags currently consisting of length of frame to be sent only.
-- FIFOs are placed outside this module. They must be FWFT.
--
-- It is aimed to be used together with frame_gen_fifo_if that sits on the 
-- other side of FIFOs and interfaces them to the frame_gen module.
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.frame_pkg.all;

Library UNISIM;
use UNISIM.vcomponents.all;


entity frame_tx_if is
   port (
      CLK            : in  std_logic;
      RST            : in  std_logic;

      DST_MAC        : in  mac_addr_type;
      DST_IP         : in  ip_addr_type;
      SRC_UDP        : in  udp_port_type;
      DST_UDP        : in  udp_port_type;

      FRAME_VALID    : in  std_logic;
      FRAME_RDY      : out std_logic;
      FRAME_LAST     : in  std_logic;
      FRAME_BE       : in  std_logic_vector(7 downto 0);
      FRAME_DATA     : in  data64_port_type;

      -- Tag and data fifos
      DFIFO_DATA     : out txi_dfifo_data_type;
      DFIFO_WR_EN    : out std_logic;
      DFIFO_FULL     : in  std_logic;

      TFIFO_DATA     : out txi_tfifo_data_type;
      TFIFO_WR_EN    : out std_logic;
      TFIFO_FULL     : in  std_logic
        );
end entity;



architecture synthesis of frame_tx_if is


   type in_fsm_type is (I_IDLE_DI0, I_DI1, I_DATA, I_TAG);
   signal in_fsm_cur    : in_fsm_type;
   signal in_fsm_next   : in_fsm_type;

   signal frame_rdy_i   : std_logic;
   signal dfifo_wr_en_i : std_logic;
   signal tfifo_wr_en_i : std_logic;
   signal length_cnt_en : std_logic;
   signal length_cnt    : unsigned(txi_tfifo_data_type'length - 1 downto 0);


begin

   -- FSM controlling insertion of data into FIFOs
   in_fsm_adv_proc : process(CLK)
   begin
      if rising_edge(CLK) then
         if RST = '1' then
            in_fsm_cur <= I_IDLE_DI0;
         else
            in_fsm_cur <= in_fsm_next;
         end if;
      end if;
   end process;


   in_fsm_trans_out_proc : process(in_fsm_cur, DFIFO_FULL, TFIFO_FULL,
                              DST_MAC, DST_UDP, DST_IP, SRC_UDP,
                              FRAME_VALID, FRAME_LAST, FRAME_BE, FRAME_DATA)
   begin
      in_fsm_next <= in_fsm_cur;
      frame_rdy_i <= not DFIFO_FULL;
      dfifo_wr_en_i <= '0';
      tfifo_wr_en_i <= '0';
      DFIFO_DATA <= FRAME_BE & FRAME_DATA;
      length_cnt_en <= '0';

      case in_fsm_cur is
         when I_IDLE_DI0 =>
            frame_rdy_i <= '0';            
            DFIFO_DATA <= x"000000" & DST_IP & SRC_UDP;
            if FRAME_VALID = '1' and DFIFO_FULL = '0' then
               in_fsm_next <= I_DI1;
               dfifo_wr_en_i <= '1';
            end if;
         when I_DI1 =>
            frame_rdy_i <= '0';
            DFIFO_DATA <= x"00" & DST_MAC & DST_UDP;
            if DFIFO_FULL = '0' then
               in_fsm_next <= I_DATA;
               dfifo_wr_en_i <= '1';
            end if;
         when I_DATA =>
            length_cnt_en <= '1';
            -- In case of empty packet this inserts empty word into the fifo
            -- frame_gen_fifo_if is responsible for discarding it
            dfifo_wr_en_i <= not DFIFO_FULL and FRAME_VALID;
            if FRAME_LAST = '1' and FRAME_VALID = '1' and DFIFO_FULL = '0' then
               in_fsm_next <= I_TAG;
            end if;
         when I_TAG =>
            frame_rdy_i <= '0';
            if TFIFO_FULL = '0' then
               tfifo_wr_en_i <= '1';
               in_fsm_next <= I_IDLE_DI0;
            end if;
         when others =>
            in_fsm_next <= I_TAG;
      end case;
   end process;

   -- Count written bytes to determine length;
   length_proc : process(CLK)
   begin
      if rising_edge(CLK) then
         if length_cnt_en  = '1' then
            if dfifo_wr_en_i = '1' then
               if FRAME_LAST = '0' then
                  length_cnt <= length_cnt + 8;
               else
                  case (FRAME_BE) is
                     when "11111111" => length_cnt <= length_cnt + 8;
                     when "01111111" => length_cnt <= length_cnt + 7;
                     when "00111111" => length_cnt <= length_cnt + 6;
                     when "00011111" => length_cnt <= length_cnt + 5;
                     when "00001111" => length_cnt <= length_cnt + 4;
                     when "00000111" => length_cnt <= length_cnt + 3;
                     when "00000011" => length_cnt <= length_cnt + 2;
                     when "00000001" => length_cnt <= length_cnt + 1;
                     when "00000000" => length_cnt <= length_cnt + 0;
                     when others => length_cnt <= length_cnt + 8;
                  end case;
               end if;
            end if;
         else
            length_cnt <= (others => '0');
         end if;
      end if;
   end process;


   FRAME_RDY <= frame_rdy_i;
   DFIFO_WR_EN <= dfifo_wr_en_i;
   TFIFO_WR_EN <= tfifo_wr_en_i;
   TFIFO_DATA <= std_logic_vector(length_cnt);
end architecture;
