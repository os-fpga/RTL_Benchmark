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
-- This module sits on outputs of tag and data fifos and translates them
-- to easily understandable interface.
--
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.frame_pkg.all;

Library UNISIM;
use UNISIM.vcomponents.all;


entity frame_rx_if is
   port (
      RST            : in  std_logic;
      CLK            : in  std_logic;

      FRAME_VALID    : out std_logic;
      FRAME_RD_EN    : in  std_logic;
      FRAME_LENGTH   : out std_logic_vector(C_FP_TAG_LENGTH_BITLEN - 1 downto 0);
      FRAME_LAST     : out std_logic;
      FRAME_BE       : out std_logic_vector(7 downto 0);
      FRAME_DATA     : out data64_port_type;
      SRC_MAC        : out mac_addr_type;
      SRC_IP         : out ip_addr_type;
      SRC_UDP        : out udp_port_type;
      DST_UDP        : out udp_port_type;


      -- Tag and data fifos
      DFIFO_DATA     : in  fp_dfifo_data_type;
      DFIFO_RD_EN    : out std_logic;
      DFIFO_EMPTY    : in  std_logic;

      TFIFO_DATA     : in  fp_tfifo_data_type;
      TFIFO_RD_EN    : out std_logic;
      TFIFO_EMPTY    : in  std_logic
        );
end entity;




architecture synthesis of frame_rx_if is

   constant LC_RI_LENGTH_POS  : integer := 0;
   constant LC_RI_DST_UDP_POS : integer := 
                                 LC_RI_LENGTH_POS + C_FP_TAG_LENGTH_BITLEN;
   constant LC_RI_SRC_UDP_POS : integer := 
                                 LC_RI_DST_UDP_POS + udp_port_type'length;
   constant LC_RI_SRC_IP_POS  : integer := 
                                 LC_RI_SRC_UDP_POS + udp_port_type'length;
   constant LC_RI_SRC_MAC_POS : integer := 
                                 LC_RI_SRC_IP_POS + ip_addr_type'length;



   -- Main FSM 
   type main_fsm_type is (M_WTAG, M_DATA, M_DISCARD);
   signal main_fsm_cur     : main_fsm_type;
   signal main_fsm_next    : main_fsm_type;

   -- FSM control signals
   signal load_tag_info       : std_logic;
   signal load_ret_info       : std_logic;
   signal load_discard_info   : std_logic;
   signal dfifo_rd_en_discard : std_logic;
   signal last_word           : std_logic;

   
   signal frame_length_i      : std_logic_vector(FRAME_LENGTH'range);
   signal data_cnt            : unsigned(FRAME_LENGTH'range);

   signal frame_valid_i       : std_logic;

   -- Internal variant of output signal
   signal tfifo_rd_en_i    : std_logic;
   signal dfifo_rd_en_i    : std_logic;

   -- Decomposed tag fifo
   signal tfifo_length     : std_logic_vector(C_FP_TAG_LENGTH_BITLEN - 1 
                                                                     downto 0);
   signal tfifo_flags      : std_logic_vector(C_FP_TAG_FLAGS_BITLEN - 1 
                                                                     downto 0);
   signal tfifo_return_info: std_logic_vector(C_FP_TAG_RET_INFO_LENGTH_BITLEN -1
                                                                     downto 0);
   signal return_info      : std_logic_vector(
                              4*C_FP_TAG_RET_INFO_LENGTH_BITLEN-1 downto 0);

   -- Decompose data fifo
   signal dfifo_rdata      : data64_port_type;
   signal dfifo_be         : std_logic_vector(7 downto 0);

begin

      -- Decompose fifos
   tfifo_length <= TFIFO_DATA(C_FP_TAG_LENGTH_BITLEN - 1 downto 0);
   tfifo_return_info <= TFIFO_DATA(C_FP_TAG_RET_INFO_LENGTH_BITLEN - 1
                                                 downto 0);
   tfifo_flags  <= TFIFO_DATA(TFIFO_DATA'left
                        downto C_FP_TAG_RET_INFO_LENGTH_BITLEN);


   dfifo_rdata <= DFIFO_DATA(dfifo_rdata'range);
   dfifo_be <= DFIFO_DATA(DFIFO_DATA'left downto dfifo_rdata'length);

   -- Main FSM
   main_fsm_adv_proc : process (RST, CLK)
   begin
      if RST = '1' then
         main_fsm_cur <= M_WTAG;
      elsif rising_edge(CLK) then
         main_fsm_cur <= main_fsm_next;
      end if;
   end process;

   main_fsm_trans_out_proc : process (main_fsm_cur, TFIFO_EMPTY, tfifo_flags,
                                      last_word, dfifo_rd_en_i)
   begin

      load_tag_info <= '0';
      load_discard_info <= '0';
      dfifo_rd_en_discard <= '0';
      tfifo_rd_en_i <= '0';
      load_ret_info <= '0';
      frame_valid_i <= '0';
      
      main_fsm_next <= main_fsm_cur;
      case main_fsm_cur is
         when M_WTAG =>
            if TFIFO_EMPTY = '0' then
               tfifo_rd_en_i <= '1';
               case tfifo_flags is
                  when C_FP_TAG_UDP =>
                     main_fsm_next <= M_DATA;
                     load_tag_info <= '1';
                  when C_FP_TAG_RETINF =>
                     load_ret_info <= '1';
                  when C_FP_TAG_DISCARD =>
                     load_discard_info <= '1';
                     main_fsm_next <= M_DISCARD;
                  when others =>
                     load_discard_info <= '1';
                     main_fsm_next <= M_DISCARD;
               end case;
            end if;
         when M_DATA =>
            frame_valid_i <= '1';
            if last_word = '1' and dfifo_rd_en_i = '1' then
               main_fsm_next <= M_WTAG;
            end if;
         when M_DISCARD =>
            dfifo_rd_en_discard <= '1';
            if last_word = '1' then
               main_fsm_next <= M_WTAG;
            end if;
         when others =>
            main_fsm_next <= M_WTAG;
      end case;

   end process;


   -- Count down packet len
   data_cnt_proc : process (RST, CLK)
      variable len : unsigned(tfifo_length'range);
   begin
      if RST = '1' then
         data_cnt <= (others => '0');
         last_word <= '0';
      elsif rising_edge(CLK) then
         if load_tag_info = '1' or
            load_discard_info = '1' then
            len := unsigned(tfifo_length);
            data_cnt <= len;
            if len <= 8 then
               last_word <= '1';
            else
               last_word <= '0';
            end if;
         elsif dfifo_rd_en_i = '1' then
            last_word <= '0';
            if data_cnt > 8 then
               data_cnt <= data_cnt - 8;
               if data_cnt <= 16 then
                  last_word <= '1';
               end if;
            else
               data_cnt <= (others => '0');
            end if;
         end if;
      end if;
   end process;

   -- Register return info
   ret_info_reg_proc : process(CLK)
   begin
      if rising_edge(CLK) then
         if load_ret_info = '1' or load_tag_info = '1' then
            for i in return_info'length/C_FP_TAG_RET_INFO_LENGTH_BITLEN 
                           downto 2 loop             
               return_info(i * C_FP_TAG_RET_INFO_LENGTH_BITLEN - 1 downto
                           (i-1) * C_FP_TAG_RET_INFO_LENGTH_BITLEN ) <= 
               return_info((i-1) * C_FP_TAG_RET_INFO_LENGTH_BITLEN - 1 downto
                           (i-2) * C_FP_TAG_RET_INFO_LENGTH_BITLEN );
            end loop;
            return_info(C_FP_TAG_RET_INFO_LENGTH_BITLEN - 1 downto 0) <=
               tfifo_return_info;
         end if;
      end if;
   end process;

   dfifo_rd_en_i <= '1' when dfifo_rd_en_discard = '1' or
                    (frame_valid_i = '1' and FRAME_RD_EN = '1') else '0';


   -- Outputs assignment
   -- DFIFO_EMPTY should never happen if tags are consistent.
   -- If it happens there is no way back. Reset is needed to recover.
   DFIFO_RD_EN <= dfifo_rd_en_i;
   TFIFO_RD_EN <= tfifo_rd_en_i;

   FRAME_VALID <= frame_valid_i;
   FRAME_LAST <= last_word;
   FRAME_DATA <= dfifo_rdata;
   FRAME_BE <= dfifo_be;
   FRAME_LENGTH <= return_info(C_FP_TAG_LENGTH_BITLEN - 1 downto 0);
   DST_UDP <= return_info(LC_RI_DST_UDP_POS + udp_port_type'left
                     downto LC_RI_DST_UDP_POS );
   SRC_UDP <= return_info(LC_RI_SRC_UDP_POS + udp_port_type'left
                     downto LC_RI_SRC_UDP_POS);
   SRC_IP  <= return_info(LC_RI_SRC_IP_POS + ip_addr_type'left
                     downto LC_RI_SRC_IP_POS );
   SRC_MAC <= return_info(LC_RI_SRC_MAC_POS + mac_addr_type'left
                     downto LC_RI_SRC_MAC_POS);
   
   
   

end architecture;



