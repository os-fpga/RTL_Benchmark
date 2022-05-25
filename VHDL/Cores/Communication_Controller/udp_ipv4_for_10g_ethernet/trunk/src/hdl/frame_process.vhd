-------------------------------------------------------------------------------
--
-- (C) Copyright 2013 DFC Design, s.r.o., Brno, Czech Republic
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
-- This core processes UDP/IPv4 frames. It is supposed to be connected to
-- frame_received core on input as it assumes aligned raw data with
-- convenient data valid and byte enable signals + checksum validation flags.
--
-- The purpose of this block is to filter out packets that are not intended
-- for us. All packets thats destination MAC and IP addresses don't match
-- set host addresses are rejected. Broadcast packets can be accepted too.
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


entity frame_process is
   port (
      RST               : in  std_logic;
      CLK               : in  std_logic;

      -- Interface towards frame receiver
      RX_DATA           : in  std_logic_vector(63 downto 0);
      RX_DV             : in  std_logic;
      RX_BE             : in  std_logic_vector(7 downto 0);
      RX_ERR            : in  std_logic;
      RX_ERR_VALID      : in  std_logic;

      -- Interfaces of tag and data fifos
      DFIFO_DATA        : out fp_dfifo_data_type;
      DFIFO_WR_EN       : out std_logic;
      DFIFO_FULL        : in  std_logic;

      TFIFO_DATA        : out fp_tfifo_data_type;
      TFIFO_WR_EN       : out std_logic;
      TFIFO_FULL        : in  std_logic;
      
      -- Host MAC and IP addresses
      MAC_ADDR          : in  mac_addr_type;
      IP_ADDR           : in  ip_addr_type;
      IP_NET_MASK       : in  ip_addr_type
        );
end entity;


architecture synthesis of frame_process is

   -- Constants
   constant LC_MAC_ADDR_BITLEN      : integer := 48;
   constant LC_DST_MAC_POS_RIGHT    : integer := 0;
   constant LC_DST_MAC_POS_LEFT     : integer := LC_DST_MAC_POS_RIGHT +
                                                 LC_MAC_ADDR_BITLEN - 1;
   constant LC_MAC_BROADCAST_ADDR   : std_logic_vector(LC_MAC_ADDR_BITLEN - 1
                                                   downto 0) := (others => '1');

   constant LC_MAC_ETHERTYPE_BITLEN : integer := 16;
   constant LC_MAC_ETHERTYPE_POS_RIGHT : integer := 12 * 8;
   constant LC_MAC_ETHERTYPE_POS_LEFT  : integer := LC_MAC_ETHERTYPE_POS_RIGHT +
                                                    LC_MAC_ETHERTYPE_BITLEN - 1;

   constant LC_MAC_ETHERTYPE_IPV4   : std_logic_vector(LC_MAC_ETHERTYPE_BITLEN -1
                                       downto 0) := x"0800";
   constant LC_MAC_ETHERTYPE_ARP    : std_logic_vector(LC_MAC_ETHERTYPE_BITLEN -1
                                       downto 0) := x"0806";
   constant LC_IP_ADDR_BITLEN       : integer := 32;
   constant LC_DST_IP_POS_RIGHT     : integer := 6*8;
   constant LC_DST_IP_POS_LEFT      : integer := LC_DST_IP_POS_RIGHT +
                                                 LC_IP_ADDR_BITLEN - 1;
   constant LC_IP_PROTO_BITLEN      : integer := 8;
   constant LC_IP_PROTO_POS_RIGHT   : integer := 7*8;   
   constant LC_IP_PROTO_POS_LEFT    : integer := LC_IP_PROTO_POS_RIGHT + 
                                                 LC_IP_PROTO_BITLEN - 1;
   constant LC_IP_PROTO_UDP         : std_logic_vector(LC_IP_PROTO_BITLEN - 1 
                                                         downto 0) := x"11";
   constant LC_THIS_NET_BROADCAST_IP: std_logic_vector(LC_IP_ADDR_BITLEN - 1 
                                                      downto 0) := x"ffffffff";
   constant LC_UDP_ADDR_BITLEN      : integer := 16;
   constant LC_DST_UDP_POS_RIGHT    : integer := 4*8;
   constant LC_DST_UDP_POS_LEFT     : integer := LC_DST_UDP_POS_RIGHT + 
                                                 LC_UDP_ADDR_BITLEN - 1;
   constant LC_UDP_LENGTH_BITLEN    : integer := 16;
   constant LC_UDP_LENGTH_POS_RIGHT : integer := 6*8;
   constant LC_UDP_LENGTH_POS_LEFT  : integer := LC_UDP_LENGTH_POS_RIGHT + 
                                                 LC_UDP_LENGTH_BITLEN - 1;
   constant LC_UDP_DATA_POS         : integer := 2*8;
   constant LC_UDP_HDR_LEN          : integer := 8;


   constant LC_SRC_MAC_BITLEN       : integer := 32;
   constant LC_SRC_MAC_POS_RIGHT0   : integer := 6*8;   
   constant LC_SRC_MAC_POS_LEFT0    : integer := LC_SRC_MAC_POS_RIGHT0 + 
                                          LC_SRC_MAC_BITLEN - 1;

   constant LC_SRC_MAC_BITLEN1      : integer := 16;
   constant LC_SRC_MAC_POS_RIGHT1   : integer := 2*8;   
   constant LC_SRC_MAC_POS_LEFT1    : integer := LC_SRC_MAC_POS_RIGHT1 + 
                                          LC_SRC_MAC_BITLEN1 - 1;

   constant LC_SRC_IP_BITLEN        : integer := 16;
   constant LC_SRC_IP_POS_RIGHT0    : integer := 18*8;   
   constant LC_SRC_IP_POS_LEFT0     : integer := LC_SRC_IP_POS_RIGHT0 + 
                                         LC_SRC_IP_BITLEN - 1;

   constant LC_SRC_IP_BITLEN1       : integer := 16;
   constant LC_SRC_IP_POS_RIGHT1    : integer := 4*8;   
   constant LC_SRC_IP_POS_LEFT1     : integer := LC_SRC_IP_POS_RIGHT1 + 
                                         LC_SRC_IP_BITLEN1 - 1;
                                         

   constant LC_SRC_UDP_BITLEN       : integer := 16;
   constant LC_SRC_UDP_POS_RIGHT    : integer := 10*8;   
   constant LC_SRC_UDP_POS_LEFT     : integer := LC_SRC_UDP_POS_RIGHT + 
                                                 LC_SRC_UDP_BITLEN - 1;                                                 


   -- Main FSM sorting frames and stripping headers
   type sort_fsm_type is (S_MAC0, S_MAC1_IP0, S_IP1, S_IP2, S_IP3_UDP0,
                          S_UDP1_DATA, 
                          --S_CHECK_ERR, 
                          S_TAG, 
                          S_TAG_DISCARD,
                          S_MAC1_ARP 
                       --   ,S_FILTERED
                       );
   signal sort_fsm_cur  : sort_fsm_type;
   signal sort_fsm_next : sort_fsm_type;

   -- FSM control signals
   signal all_data_written    : std_logic;
   signal load_udp_data_length: std_logic;
   signal write_udp_data      : std_logic;

   signal cur_broadcast       : std_logic;
   signal cur_broadcast_s     : std_logic;
   signal cur_broadcast_r     : std_logic;

   signal mac_ethertype_ipv4  : std_logic;
   signal mac_ethertype_arp   : std_logic;
   signal mac_filter_unicast  : std_logic;
   signal mac_filter_broadcast: std_logic;

   signal ip_filter_unicast   : std_logic;
   signal ip_filter_broadcast : std_logic;
   signal ip_next_proto_udp   : std_logic;

   signal udp_data_length     : unsigned(C_FP_TAG_LENGTH_BITLEN - 1 downto 0);
   signal udp_data_length_reg : unsigned(udp_data_length'range);

   signal rx_udp_be           : std_logic_vector(RX_BE'range);
   signal rx_udp_data         : std_logic_vector(RX_DATA'range);

   -- internal form of output ports
   signal tfifo_wr_en_i       : std_logic;
   signal tfifo_data_i        : fp_tfifo_data_type;

   -- Counter of data to send
   signal data_cnt            : unsigned(15 downto 0);
   -- Counter of data to be discarded if needed
   signal data_to_discard     : unsigned(data_cnt'range);

   signal dst_udp_reg         : udp_port_type;
   signal dst_udp_port        : udp_port_type;

   -- Register versions of inputs
   signal rx_data_d           : std_logic_vector(63 downto 0);
   signal rx_dv_d             : std_logic;
   signal rx_be_d             : std_logic_vector(7 downto 0);
   signal rx_err_d            : std_logic;
   signal rx_err_valid_d      : std_logic;
   signal rx_err_dd           : std_logic;
   signal rx_be_dd            : std_logic_vector(7 downto 0);
   signal rx_dv_dd            : std_logic;
   signal rx_data_dd          : std_logic_vector(63 downto 0);
   signal rx_err_valid_dd     : std_logic;
   signal rx_err_ddd          : std_logic;
   signal rx_be_ddd           : std_logic_vector(7 downto 0);
   signal rx_dv_ddd           : std_logic;
   signal rx_dv_dddd          : std_logic;
   signal rx_data_ddd         : std_logic_vector(63 downto 0);
   signal rx_err_valid_ddd    : std_logic;



   -- Function definitions
   -- Cut out byte enables from two delayed words - compensate for shift in UDP
   function derive_udp_be_func(be_ddd : std_logic_vector;
                           be_dd : std_logic_vector) return std_logic_vector is
      variable res : std_logic_vector(be_dd'range);
      variable tmp : std_logic_vector(be_dd'length * 2 - 1 downto 0);
   begin

      -- We know the offset for standard UDP packet (without options)

      tmp := be_dd & be_ddd;
      res := tmp(LC_UDP_DATA_POS/8 + be_dd'left downto LC_UDP_DATA_POS/8);

      return res;
   end function;
   
   
   -- Cut out data from two delayed words - compensate for shift in UDP
   function derive_udp_data_func(data_ddd : std_logic_vector;
                           data_dd : std_logic_vector) return std_logic_vector is
      variable res : std_logic_vector(data_dd'range);
      variable tmp : std_logic_vector(data_dd'length * 2 - 1 downto 0);
   begin

      -- We know the offset for standard UDP packet (without options)
      tmp := data_dd & data_ddd;
      res := tmp(LC_UDP_DATA_POS + data_dd'left downto LC_UDP_DATA_POS);
      return res;
   end function;

   -- Basically finds first 1 bit from left (MSB) to find out
   -- how many byte enables is 1 (gaps are not alowed)
   function be_to_cnt_udp_func(be_ddd : std_logic_vector;
                           be_dd : std_logic_vector) return integer is
      variable tmp : std_logic_vector(be_ddd'range);
      variable res : integer range 0 to be_ddd'length;
   begin
      tmp := derive_udp_be_func(be_ddd, be_dd);
      for i in tmp'left downto 0 loop
         if tmp(i) = '1' then
            return i + 1;
         end if;
      end loop;
      return 0;
   end function;


   -- Change endians
   function swap_bytes(fi : std_logic_vector) return std_logic_vector is
      variable f   : std_logic_vector(fi'length - 1 downto 0);
      variable res : std_logic_vector(f'length - 1 downto 0);
      variable blen : integer;
   begin
      f := fi;
      blen := f'length/8 - 1;
      for i in 0 to blen loop
         res(i*8 + 7 downto i * 8) := f((blen - i)*8 + 7 downto (blen - i) * 8);
      end loop;
      return res;
   end Function;

   function swap_bytes(f : unsigned) return unsigned is
   begin
      return unsigned(swap_bytes(std_logic_vector(f)));
   end function;

begin

   -- Create delayed signal, first to isolate from previous
   -- block, second to align filter results with data
   delay_input_proc : process (RST, CLK)
   begin
      if RST = '1' then
         rx_data_d         <= (others => '0');
         rx_data_dd        <= (others => '0');
         rx_data_ddd       <= (others => '0');
         rx_dv_d           <= '0';
         rx_dv_dd          <= '0';
         rx_dv_ddd         <= '0';
         rx_dv_dddd         <= '0';
         rx_be_d           <= (others => '0');
         rx_be_dd          <= (others => '0');
         rx_be_ddd         <= (others => '0');
         rx_err_d          <= '0';
         rx_err_dd         <= '0';
         rx_err_ddd        <= '0';
         rx_err_valid_d    <= '0';
         rx_err_valid_dd   <= '0';
         rx_err_valid_ddd  <= '0';
      elsif rising_edge(CLK) then
         rx_data_d         <= RX_DATA;  
         rx_data_dd        <= rx_data_d;
         rx_data_ddd       <= rx_data_dd;
         rx_dv_d           <= RX_DV;
         rx_dv_dd          <= rx_dv_d;
         rx_dv_ddd         <= rx_dv_dd;
         rx_dv_dddd        <= rx_dv_ddd;
         rx_be_d           <= RX_BE;
         rx_be_dd          <= rx_be_d;
         rx_be_ddd         <= rx_be_dd;
         rx_err_d          <= RX_ERR;
         rx_err_dd         <= rx_err_d;
         rx_err_ddd        <= rx_err_dd;
         rx_err_valid_d    <= RX_ERR_VALID;
         rx_err_valid_dd   <= rx_err_valid_d;  
         rx_err_valid_ddd  <= rx_err_valid_dd;  
      end if;
   end process;


   -- Main FSM sorting frames and stripping headers
   sort_fsm_adv_proc : process (CLK, RST)
   begin
      if RST ='1' then
         sort_fsm_cur <= S_MAC0;
         cur_broadcast <= '0';
      elsif rising_edge(CLK) then
         sort_fsm_cur <= sort_fsm_next;

         if cur_broadcast_s = '1' then
            cur_broadcast <= '1';
         elsif cur_broadcast_r = '1' then
            cur_broadcast <= '0';
         end if;
      end if;
   end process;

   sort_fsm_trans_out_proc : process (sort_fsm_cur, dst_udp_port,
                                      udp_data_length, rx_dv_ddd, rx_dv_dddd, 
                                      mac_filter_unicast, mac_filter_broadcast,
                                      mac_ethertype_ipv4, mac_ethertype_arp,
                                      ip_filter_unicast, ip_filter_broadcast,
                                      all_data_written, ip_next_proto_udp, 
                                      DFIFO_FULL, rx_err_valid_ddd, 
                                      rx_err_ddd, TFIFO_FULL, cur_broadcast, 
                                      data_to_discard, rx_data_d, rx_data_dd, rx_data_ddd)
     variable header : std_logic_vector(3*64-1 downto 0);
   begin

      header := rx_data_d & rx_data_dd & rx_data_ddd; 
      
      load_udp_data_length  <= '0';
      write_udp_data <= '0';

      tfifo_wr_en_i <= '0';
      cur_broadcast_s <= '0';
      cur_broadcast_r <= '0';

      -- Dafault state of tfifo data
      tfifo_data_i <= C_FP_TAG_UDP & dst_udp_port & 
                                             std_logic_vector(udp_data_length);

      sort_fsm_next <= sort_fsm_cur;

      case sort_fsm_cur is
         when S_MAC0 =>
            cur_broadcast_r <= '1';
            if rx_dv_ddd = '1' and rx_dv_dddd = '0' then
               -- Process only our packets and broadcast
               if mac_filter_unicast = '1' or
                  mac_filter_broadcast = '1' then
                  if mac_filter_broadcast = '1' then
                     -- Remember we process broadcast
                     -- because we will need to know later
                     cur_broadcast_s <= '1';
                  end if;
                  -- Differentiate between IPv4 and ARP
                  if mac_ethertype_ipv4 = '1' then
                     sort_fsm_next <= S_MAC1_IP0;
                  elsif mac_ethertype_arp = '1' then
                     sort_fsm_next <= S_MAC1_ARP;
                  else
                     -- We process IPv4 and ARP packets only
                     NULL;
                  end if;
                  -- Save the first part of return info - part of src MAC addr
                  if TFIFO_FULL = '0' then
                     tfifo_wr_en_i <= '1';
                  else
                     -- tag FIFO full; As nothing has been written yet
                     -- we can stay in this state and wait for next frame
                     sort_fsm_next <= S_MAC0;
                  end if;
                  tfifo_data_i <= C_FP_TAG_RETINF & 
                     swap_bytes(header(LC_SRC_MAC_POS_LEFT0 downto 
                                                      LC_SRC_MAC_POS_RIGHT0));
               end if;
            end if;
         when S_MAC1_ARP =>
            -- ARP not supported in this version
            sort_fsm_next <= S_MAC0;
         when S_MAC1_IP0 =>
            -- Only first ten bytes of IP header available
            if rx_dv_ddd = '1' then
               sort_fsm_next <= S_IP1;
               -- Save the second part of return info - rest of src MAC addr
               -- and part of src IP
               if TFIFO_FULL = '0' then
                  tfifo_wr_en_i <= '1';
               else
                  -- tag FIFO full; no date have been written so just ignere pkt
                  sort_fsm_next <= S_MAC0;
               end if;
               tfifo_data_i <= C_FP_TAG_RETINF & 
                  swap_bytes(header(LC_SRC_MAC_POS_LEFT1 downto 
                                                   LC_SRC_MAC_POS_RIGHT1)) &
                  swap_bytes(header(LC_SRC_IP_POS_LEFT0 downto 
                                                   LC_SRC_IP_POS_RIGHT0));
            else
               sort_fsm_next <= S_TAG_DISCARD;
            end if;
         when S_IP1 =>
            -- Check if next protocol is UDP
            -- Destination IP is not yet completely loaded
            if rx_dv_ddd = '1' and
               ip_next_proto_udp = '1' then
               sort_fsm_next <= S_IP2;
            else
               sort_fsm_next <= S_MAC0;
            end if;
         when S_IP2 =>
            -- Continue if destination address is ours or
            -- broadcast and MAC was broadcast too
            if rx_dv_ddd = '1' and
               ((ip_filter_unicast = '1' and   cur_broadcast = '0')or
                (ip_filter_broadcast = '1' and cur_broadcast = '1')
               ) then
               sort_fsm_next <= S_IP3_UDP0;
               -- Save the third part of return info - rest of src IP addr
               -- and src UDP port
               if TFIFO_FULL = '0' then
                  tfifo_wr_en_i <= '1';
               else
                  -- data FIFO full; discard if anything has been written
                  sort_fsm_next <= S_MAC0;
               end if;
               tfifo_data_i <= C_FP_TAG_RETINF & 
                  swap_bytes(header(LC_SRC_IP_POS_LEFT1 downto 
                                                LC_SRC_IP_POS_RIGHT1)) &
                  swap_bytes(header(LC_SRC_UDP_POS_LEFT downto 
                                                LC_SRC_UDP_POS_RIGHT));

            else
               sort_fsm_next <= S_MAC0;
            end if;
         when S_IP3_UDP0 =>
            -- Now we can determine destination socket
            -- based on destination UDP port
            if rx_dv_ddd = '1' then
               load_udp_data_length <= '1';
               sort_fsm_next <= S_UDP1_DATA;
            else
               sort_fsm_next <= S_MAC0;
            end if;
         when S_UDP1_DATA =>
            -- For UDP data are not aligned and first two bytes
            -- are mixed with header; because we want data aligned
            -- in fifo it may happen that there are no data
            -- to write in last cycle of dv
            if rx_dv_ddd = '1' then
               if all_data_written = '0' then
                  if DFIFO_FULL = '0' then
                     write_udp_data <= '1';
                  else
                     -- We dont have space in data fifo; data will be 
                     -- corrupted; discard packet
                     -- Data are still valid so we have enough time
                     -- to go to discard state
                     sort_fsm_next <= S_TAG_DISCARD;
                  end if;
               end if;
            else
               if all_data_written = '0' or
                  rx_err_ddd = '1'then
                  -- DV deasserted before all data received
                  -- or error occurred in packet
                  -- We don't have time to go to discard state
                  -- write discard tag now (minimal IFG is only one cycle)
                  if TFIFO_FULL = '0' then
                     tfifo_wr_en_i <= '1';
                     sort_fsm_next <= S_MAC0;
                  else
                     -- Tag fifo is full go waiting for space for discard tag
                     sort_fsm_next <= S_TAG_DISCARD;
                  end if;
                  tfifo_data_i <= C_FP_TAG_DISCARD & dst_udp_port & 
                                          std_logic_vector(data_to_discard);
               else
                  -- All is fine, write ok tag
                  if TFIFO_FULL = '0' then
                     -- Write default - i.e. length and destination port
                     tfifo_wr_en_i <= '1';
                     sort_fsm_next <= S_MAC0;
                  else
                     -- There is no space for tag, go waiting
                     sort_fsm_next <= S_TAG;
                  end if;
               end if;
            end if;
         when S_TAG =>
            -- Wait until there is space in tag fifo and write ok tag
            if TFIFO_FULL = '0' then
               -- Write default - i.e. length and destination port
               tfifo_wr_en_i <= '1';
               sort_fsm_next <= S_MAC0;
            end if;
         when S_TAG_DISCARD =>
            -- Wait until there is space in tag fifo and write discard tag
            if TFIFO_FULL = '0' then
               tfifo_wr_en_i <= '1';
               sort_fsm_next <= S_MAC0;
            end if;
            tfifo_data_i <= C_FP_TAG_DISCARD & dst_udp_port & 
                                             std_logic_vector(data_to_discard);
--         when S_FILTERED =>
--            -- Wait until packet that we don't care of ends
--            if rx_dv_ddd = '0' then
--               sort_fsm_next <= S_MAC0;
--            end if;
      end case;

   end process;

   -- Count data written; check against
   -- header info - valid for UDP only
   data_cnt_proc : process (RST, CLK)
      variable be_cnt : integer;
   begin
      if RST = '1' then
         data_cnt <= (others => '0');
         data_to_discard <= (others => '0');
         all_data_written <= '0';
      elsif rising_edge(CLK) then
         if load_udp_data_length = '1' then
            -- Subtract 8 as a length of UDP_HEADER
            udp_data_length <= swap_bytes(udp_data_length_reg) - LC_UDP_HDR_LEN;
            data_cnt <= swap_bytes(udp_data_length_reg) - LC_UDP_HDR_LEN;
            dst_udp_port <= swap_bytes(dst_udp_reg);
            all_data_written <= '0';
            data_to_discard <= (others => '0');
         elsif write_udp_data = '1' then
            -- Count data for case of discarding
            -- hede we don't have to play on byte enables
            data_to_discard <= data_to_discard + 8;

            -- Now, we have to derive how many bytes to write
            if data_cnt > 8 then
               -- Most often case
               data_cnt <= data_cnt - 8;
            elsif data_cnt = 8 then
               -- Data were 8 by aligned
               data_cnt <= data_cnt - 8;
               all_data_written <= '1';
            elsif data_cnt < 8 then
               be_cnt := be_to_cnt_udp_func(rx_be_ddd, rx_be_dd);
               if be_cnt >= data_cnt then
                  -- If equal it is ok; if more there are 
                  -- trailing data in packet and it is fine too
                  data_cnt <= (others => '0');
                  all_data_written <= '1';
               else
                  -- Packet was shorter and will be discarded
                  -- because DV will go down
                  null;    
               end if;
            end if;
         end if;
      end if;
   end process;

   rx_udp_be   <= derive_udp_be_func(rx_be_ddd, rx_be_dd);
   rx_udp_data <= derive_udp_data_func(rx_data_ddd, rx_data_dd);



   -- Register udp length and dst port
   udp_length_reg_proc : process (RST, CLK)
      variable header : std_logic_vector(127 downto 0);
   begin
      if RST = '1' then
         udp_data_length_reg <= (others => '0');
      elsif rising_edge(CLK) then
         header := rx_data_d & rx_data_dd;
         udp_data_length_reg <= unsigned(
                  header(LC_UDP_LENGTH_POS_LEFT downto LC_UDP_LENGTH_POS_RIGHT));
         dst_udp_reg <= header(LC_DST_UDP_POS_LEFT downto LC_DST_UDP_POS_RIGHT);
      end if;
   end process;


   -- Filters for various info from header
   -- Output is aligned with data in ddd version

   -- MAC filter; Check ethertype field of MAC
   mac_filter_proc : process (RST, CLK)
      variable header      : std_logic_vector(127 downto 0);
      variable dst_mac     : std_logic_vector(LC_MAC_ADDR_BITLEN - 1 downto 0);
      variable ethertype   : std_logic_vector(LC_MAC_ETHERTYPE_BITLEN -1
                                                                     downto 0);
   begin
      if RST = '1' then
         mac_filter_unicast   <= '0';
         mac_filter_broadcast <= '0';
         mac_ethertype_ipv4   <= '0';
         mac_ethertype_arp    <= '0';
      elsif rising_edge(CLK) then

         mac_filter_unicast   <= '0';
         mac_filter_broadcast <= '0';
         mac_ethertype_ipv4   <= '0';
         mac_ethertype_arp    <= '0';

         -- Extract destination MAC and ethertype from received headers
         header := rx_data_d & rx_data_dd;
         dst_mac := header(LC_DST_MAC_POS_LEFT downto LC_DST_MAC_POS_RIGHT);
         ethertype := header(LC_MAC_ETHERTYPE_POS_LEFT downto 
                                                   LC_MAC_ETHERTYPE_POS_RIGHT);
         -- Check for broadcast MAC
         if dst_mac = LC_MAC_BROADCAST_ADDR then
            mac_filter_broadcast <= '1';
         end if;
         -- Check for unicast with our MAC
         if dst_mac = swap_bytes(MAC_ADDR) then
            mac_filter_unicast <= '1';
         end if;

         -- Check for ipv4 ethertype
         if ethertype = swap_bytes(LC_MAC_ETHERTYPE_IPV4) then
            mac_ethertype_ipv4 <= '1';
         end if;
         -- Check for arp ethertype
         if ethertype = swap_bytes(LC_MAC_ETHERTYPE_ARP) then
            mac_ethertype_arp <= '1';
         end if;

      end if;
   end process;


   -- IP filter; Check for UDP as next protocol
   ip_filter_proc : process (RST, CLK)
      variable header : std_logic_vector(127 downto 0);
      variable dst_ip : std_logic_vector(LC_IP_ADDR_BITLEN - 1 downto 0);
      variable next_proto : std_logic_vector(LC_IP_PROTO_BITLEN - 1 downto 0);
      variable tmpip : ip_addr_type;
   begin
      if RST = '1' then
         ip_filter_unicast <= '0';
         ip_filter_broadcast <= '0';
         ip_next_proto_udp <= '0';
      elsif rising_edge(CLK) then

         ip_filter_unicast <= '0';
         ip_filter_broadcast <= '0';
         ip_next_proto_udp <= '0';

         -- Extract destination IP from received headers
         header := rx_data_d & rx_data_dd;
         dst_ip := header(LC_DST_IP_POS_LEFT downto LC_DST_IP_POS_RIGHT);
         next_proto := header(LC_IP_PROTO_POS_LEFT downto LC_IP_PROTO_POS_RIGHT);
         -- Check for broadcast IP
         tmpip := IP_ADDR and IP_NET_MASK;
         if (swap_bytes(dst_ip) and IP_NET_MASK)  = tmpip or
            dst_ip = LC_THIS_NET_BROADCAST_IP then
            ip_filter_broadcast <= '1';
         end if;
         -- Check for unicast with our IP
         if dst_ip = swap_bytes(IP_ADDR) then
            ip_filter_unicast <= '1';
         end if;
         -- Check for UDP as next protocol
         if next_proto = LC_IP_PROTO_UDP then
            ip_next_proto_udp <= '1';
         end if;
      end if;
   end process;

   -- Outputs assignment
   TFIFO_DATA <= tfifo_data_i;
   TFIFO_WR_EN <= tfifo_wr_en_i;

   DFIFO_DATA <= rx_udp_be & rx_udp_data;
   DFIFO_WR_EN <= write_udp_data;


end architecture;








