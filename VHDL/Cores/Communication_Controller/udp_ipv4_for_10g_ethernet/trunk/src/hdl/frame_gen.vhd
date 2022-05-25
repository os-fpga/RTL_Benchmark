-------------------------------------------------------------------------------
--
-- (C) Copyright 2013 DFC Design, s.r.o., Brno, Czech Republic
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
-- This core generates UDP/IPv4 Ethernet frames.
-- It is supposed to be connected to XGMII like interface.
-- UDP checksum is not used (set 0).
-- IP fragmentation is not supported. User is responsible for keeping packet
-- size under MTU.
-- Core ensures minimal standard IPG 96 bits is transmitted between every
-- two frames.
-- No checks are performed on validity of IP and MAC addresses.
-- ARP is not implemented - user must provide valid MAC & IP address pair.
-- Broadcasts are supported setting destination MAC to ff:ff:ff:ff:ff:ff and
-- IP to correct broadcast IP based on netmask or 255.255.255.255.
--
-- If BUSY signal is low, transmission starts when user asserts
-- TX_EN signal. All inputs - MAC and IP addresses, UDP ports, data length -
-- must be valid when TX_EN is asserted until BUSY goes high (so if BUSY is
-- low for one cycle together with TX_EN only).
--
-- After preamble and all headers are transmitted DATA_REN is asserted high
-- by the core to indicate that data transfer will begin. One cycle latency
-- is assumed, so data must be valid (and are consumed) in cycle
-- following the one DATA_REN is asserted.
--
-- User has to provide new word in each cycle. There is no flow control.
--
-- Exactly DATA_LEN bytes is captured on DATA_IN and sent as UDP payload.
--
-- All ports must be synchronized to TX_CLK which should be XGMII TX clock.
-- It is normally 156.25 MHz.
--
--
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity frame_gen is
   port (
      RESET    : in  std_logic;   -- Async reset
      TX_EN    : in  std_logic := '1';   -- Transmitt enable
      BUSY     : out std_logic;
      IDLE_IFG : out std_logic;
      --
      DATA_REN : out std_logic; -- Data read enable (1 cycle latency is assumed)
      DATA_IN  : in std_logic_vector(63 downto 0); -- Data input
      DATA_LEN : in std_logic_vector(15 downto 0); -- Number of data bytes to be transferred (should be multiple of 8)
      -- ETH/IP/UDP Configuration
      SRC_MAC  : in std_logic_vector(47 downto 0); --
      DST_MAC  : in std_logic_vector(47 downto 0); --
      SRC_IP   : in std_logic_vector(31 downto 0); --
      DST_IP   : in std_logic_vector(31 downto 0); --
      SRC_PORT : in std_logic_vector(15 downto 0); --
      DST_PORT : in std_logic_vector(15 downto 0); --

      -- XGMII TX interface
      TX_CLK : in  std_logic;   -- XGMII TX clock input
      TXD    : out std_logic_vector(63 downto 0); -- XGMII TX data, TX_CLK sync
      TXC    : out std_logic_vector( 7 downto 0) -- XGMII TX command, TX_CLK sync
   );
end frame_gen;

architecture behavioral of frame_gen is

constant C_SOP : std_logic_vector(7 downto 0) := X"FB";
constant C_EOP : std_logic_vector(7 downto 0) := X"FD";

type t_state is (IDLE,
                 PREAMBLE, --
                 MAC0,     -- SRC_MAC(1:0) & DST_MAC
                 MAC_IP0,  -- SERVICES & IP_VER & TYPE & SRC_MAC(5:2)  2
                 IP1,      -- PROTO(0x11) & TTL(0x80) & FLGS_OFFSET & ID(zeros) & Length(hdr+data [bytes]) 64
                 IP2,      -- DST_IP & SRC_IP & CHKSUM 64
                 IP3_UDP,  -- UDP_LEN & UDP_DST_P & UDP_SRC_P & DST_IP
                 UDP_DATA, -- Data & UDP_CHSUM
                 DATA,     -- Data
                 DATA_LAST,
                 EOP,
                 IFG);

signal fsm_state : t_state;

signal sum             : std_logic_vector(19 downto 0);
signal data_cntr       : std_logic_vector(15 downto 0);
signal data_dly        : std_logic_vector(15 downto 0);
signal tx_d_i          : std_logic_vector(63 downto 0) := (others => '0');
signal tx_c_i          : std_logic_vector( 7 downto 0) := (others => '0');
signal txd_i_dly0      : std_logic_vector(63 downto 0) := (others => '0');
signal txc_i_dly0      : std_logic_vector( 7 downto 0) := (others => '0');
signal txd_i_dly1      : std_logic_vector(63 downto 0) := (others => '0');
signal txc_i_dly1      : std_logic_vector( 7 downto 0) := (others => '0');
signal txd_i_dly2      : std_logic_vector(63 downto 0) := (others => '0');
signal txc_i_dly2      : std_logic_vector( 7 downto 0) := (others => '0');
signal txd_i_dly3      : std_logic_vector(63 downto 0) := (others => '0');
signal txc_i_dly3      : std_logic_vector( 7 downto 0) := (others => '0');

signal crc_mask_dly0   : std_logic_vector( 2 downto 0);
signal crc_mask_dly1   : std_logic_vector( 2 downto 0);
signal crc_mask_dly2   : std_logic_vector( 2 downto 0);
signal crc_mask_dly3   : std_logic_vector( 2 downto 0);
signal crc_mask_dly4   : std_logic_vector( 2 downto 0);

signal tx_d_i_vld      : std_logic;
signal crc32_i         : std_logic_vector(31 downto 0);
signal crc32           : std_logic_vector(31 downto 0);
signal crc_dly         : std_logic_vector(31 downto 0);
signal crc_mask        : std_logic_vector( 2 downto 0) := "000";
signal crc_eop         : std_logic;
signal crc_vld         : std_logic;
signal crc_vld_dly     : std_logic;

signal src_mac_reg     : std_logic_vector(47 downto 0); 
signal dst_mac_reg     : std_logic_vector(47 downto 0); 
signal src_ip_reg      : std_logic_vector(31 downto 0); 
signal dst_ip_reg      : std_logic_vector(31 downto 0); 
signal src_port_reg    : std_logic_vector(15 downto 0); 
signal dst_port_reg    : std_logic_vector(15 downto 0);
signal data_len_reg    : std_logic_vector(DATA_LEN'range);

begin

FRAME_GEN_FSM: process(RESET, TX_CLK)
variable chksum : std_logic_vector(15 downto 0);
variable tmpsum : std_logic_vector(19 downto 0);
begin
   if RESET = '1' then
      fsm_state  <= IDLE;
      tx_d_i_vld <= '0';
      DATA_REN   <= '0';
   elsif TX_CLK'event and TX_CLK = '1' then
      crc_eop <= '0';
      IDLE_IFG <= '0';
      case fsm_state is

         when IDLE =>
            tx_d_i <= X"0707070707070707";
            tx_c_i <= "11111111";
            crc_eop  <= '0';
            crc_mask <= "000";
            BUSY     <= '0';
            if TX_EN = '1' then
               BUSY <= '1';
               fsm_state <= PREAMBLE;
               
               src_mac_reg  <= SRC_MAC;
               dst_mac_reg  <= DST_MAC;
               src_ip_reg   <= SRC_IP;
               dst_ip_reg   <= DST_IP;
               src_port_reg <= SRC_PORT;
               dst_port_reg <= DST_PORT;
               data_len_reg <= DATA_LEN;

            end if;
         when PREAMBLE =>
            tx_d_i <= X"D5555555555555FB";
            tx_c_i <= "00000001";
            fsm_state <= MAC0;
         when MAC0     =>
            tx_d_i_vld <= '1';
            tx_d_i(47 downto  0) <= dst_mac_reg(7 downto 0) & dst_mac_reg(15 downto 8) & dst_mac_reg(23 downto 16) & dst_mac_reg(31 downto 24) & dst_mac_reg(39 downto 32) & dst_mac_reg(47 downto 40); -- DST MAC
            tx_d_i(63 downto 48) <= src_mac_reg(39 downto 32) & src_mac_reg(47 downto 40); -- src_mac_reg(5:4)
            tx_c_i <= "00000000";
            fsm_state <= MAC_IP0;
         when MAC_IP0  =>
            tx_d_i(31 downto  0) <= src_mac_reg(7 downto 0) & src_mac_reg(15 downto 8) & src_mac_reg(23 downto 16) & src_mac_reg(31 downto 24); -- src_mac_reg(3:0)
            tx_d_i(63 downto 32) <= X"0045" & X"0008"; -- SERVICES & IP_VER & ETH_TYPE
            tx_c_i <= "00000000";
            sum    <= "0000" & X"4500";
            fsm_state <= IP1;
         when IP1      =>
            tmpsum := ("0000" & data_len_reg) + X"1C";
            tx_d_i(15 downto  0) <= tmpsum(7 downto 0) & tmpsum(15 downto 8); -- IP data length (ip_hdr+udp_hdr+data [bytes])
            tx_d_i(63 downto 16) <= X"118000000000"; -- PROTO(0x11) & TTL(0x80) & FLGS_OFFSET & ID(zeros)
            tx_c_i <= "00000000";
            sum    <= sum + X"8011" + tmpsum(15 downto 0);
            fsm_state <= IP2;
         when IP2      =>
            tmpsum := sum + src_ip_reg(15 downto 0) + src_ip_reg(31 downto 16) + dst_ip_reg(15 downto 0) + dst_ip_reg(31 downto 16);
            chksum := tmpsum(19 downto 16) + tmpsum(15 downto 0);
            tx_d_i(15 downto  0) <= not chksum(7 downto 0) & not chksum(15 downto 8); -- IP header CHKSUM
            tx_d_i(47 downto 16) <= src_ip_reg(7 downto 0) & src_ip_reg(15 downto 8) & src_ip_reg(23 downto 16) & src_ip_reg(31 downto 24); -- src_ip_reg
            tx_d_i(63 downto 48) <= dst_ip_reg(23 downto 16) & dst_ip_reg(31 downto 24); -- Destination IP
            tx_c_i <= "00000000";
            DATA_REN <= '1'; -- Enable reading data            
            fsm_state <= IP3_UDP;
         when IP3_UDP  =>
            tmpsum := ("0000" & data_len_reg) + 8;
            tx_d_i(15 downto  0) <= dst_ip_reg(7 downto 0) & dst_ip_reg(15 downto 8); -- Destionation IP
            tx_d_i(31 downto 16) <= src_port_reg(7 downto 0) & src_port_reg(15 downto 8); -- UDP SRC port
            tx_d_i(47 downto 32) <= dst_port_reg(7 downto 0) & dst_port_reg(15 downto 8); -- UDP DST port
            tx_d_i(63 downto 48) <= tmpsum(7 downto 0) & tmpsum(15 downto 8); -- UDP Data length
            tx_c_i <= "00000000";
            if data_len_reg > 8 then
               DATA_REN <= '1'; -- Enable reading data            
            else
               DATA_REN <= '0'; -- Enable reading data            
            end if;
            fsm_state <= UDP_DATA;

         when UDP_DATA => -- The reset of UDP header & first data
            tx_d_i(15 downto 0)  <= X"0000";  -- UDP checksum
            tx_d_i(63 downto 16) <= DATA_IN(47 downto 0);
            if data_len_reg > 18 then -- Min packet length is 60 so MAC hdr 14, IP hdr 20, UDP hdr 8, the rest is 18
               data_cntr <= data_len_reg - 6; -- 6 bytes are transmitted in this cycle
            else
               data_cntr <= x"000c";
            end if;
            data_dly  <= DATA_IN(63 downto 48);
            fsm_state <= DATA;
            if data_len_reg > 16 then
               DATA_REN  <= '1'; -- Enable reading data
            else
               DATA_REN  <= '0'; -- Enable reading data
            end if;

         when DATA     =>
            tx_d_i    <= DATA_IN(47 downto 0) & data_dly;
            tx_c_i    <= "00000000";
            data_dly  <= DATA_IN(63 downto 48);
            data_cntr <= data_cntr - 8;
            DATA_REN  <= '1';
            if data_cntr < 16 then
               fsm_state <= DATA_LAST;
            end if;
            if data_cntr < 19 then
               DATA_REN <= '0';
            end if;
            if data_cntr = 8 then
               crc_eop <= '1';
               crc_mask <= "000";
            end if;

         when DATA_LAST      =>
            crc_eop  <= '1';
            DATA_REN <= '0';
            case data_cntr(2 downto 0) is
               when "000" =>
                 crc_eop  <= '0';
                 tx_d_i   <= X"070707FD00000000";
                 tx_c_i   <= "11110000";
                 tx_d_i_vld <= '0';
                 fsm_state <= IDLE;
                 BUSY      <= '0';
                 IDLE_IFG  <= '1';
               when "001" =>
                 crc_mask <= "111";
                 tx_d_i   <= X"0707FD00000000" & data_dly(7 downto 0);
                 tx_c_i   <= "11100000";
                 fsm_state <= IFG;
               when "010" =>
                 crc_mask <= "110";
                 tx_d_i   <= X"07FD00000000" & data_dly(15 downto 0);
                 tx_c_i   <= "11000000";
                 fsm_state <= IFG;
               when "011" =>
                 crc_mask <= "101";
                 tx_d_i   <= X"FD00000000" & DATA_IN(7 downto 0) & data_dly(15 downto 0);
                 tx_c_i   <= "10000000";
                 fsm_state <= IFG;
               when "100" =>
                 crc_mask <= "100";
                 tx_d_i   <= X"00000000" & DATA_IN(15 downto 0) & data_dly(15 downto 0);
                 tx_c_i   <= "00000000";
                 fsm_state <= EOP;
               when "101" =>
                 crc_mask <= "011";
                 tx_d_i   <= X"000000" & DATA_IN(23 downto 0) & data_dly(15 downto 0);
                 tx_c_i   <= "00000000";
                 fsm_state <= EOP;
               when "110" =>
                 crc_mask <= "010";
                 tx_d_i   <= X"0000" & DATA_IN(31 downto 0) & data_dly(15 downto 0);
                 tx_c_i   <= "00000000";
                 fsm_state <= EOP;
               when "111" =>
                 crc_mask <= "001";
                 tx_d_i   <= X"00" & DATA_IN(39 downto 0) & data_dly(15 downto 0);
                 tx_c_i   <= "00000000";
                 fsm_state <= EOP;
               when others => null;
            end case;

         when EOP =>
            tx_d_i_vld <= '0';
            case crc_mask is
               when "100" =>
                  tx_d_i   <= X"07070707070707FD";
                  tx_c_i   <= "11111111";
                  BUSY     <= '0';
                  fsm_state <= IDLE;
                  IDLE_IFG  <= '1';
               when "011" =>
                  tx_d_i   <= X"070707070707FD00"; -- Last byte of CRC
                  tx_c_i   <= "11111110";
                  BUSY     <= '0';
                  fsm_state <= IDLE;
                  IDLE_IFG  <= '1';
               when "010" =>
                  tx_d_i   <= X"0707070707FD0000"; -- Last two bytes of CRC
                  tx_c_i   <= "11111100";
                  BUSY     <= '0';
                  fsm_state <= IDLE;
                  IDLE_IFG  <= '1';
               when "001" =>
                  tx_d_i   <= X"07070707FD000000"; -- Last three bytes of CRC
                  tx_c_i   <= "11111000";
                  BUSY     <= '0';
                  fsm_state <= IDLE;
                  IDLE_IFG  <= '1';

               when others => null;
            end case;

         when IFG      =>
            tx_d_i_vld <= '0';
            tx_d_i <= X"0707070707070707";
            tx_c_i <= "11111111";
            BUSY   <= '0';
            fsm_state <= IDLE;
            IDLE_IFG  <= '1';

         when others => null;

      end case;
   end if;
end process;

CRC_GEN: entity work.crc32_gen
generic map (
   DATA_WIDTH => 64
)
port map(
   DI    => tx_d_i,
   DI_DV => tx_d_i_vld,
   EOP   => crc_eop,
   MASK  => crc_mask,
   CLK   => TX_CLK,
   RESET => RESET,
   CRC   => crc32_i,
   DO_DV => crc_vld   
);


-- Swap bytes in the CRC word
crc32 <= crc32_i(7 downto 0) & crc32_i(15 downto 8) & crc32_i(23 downto 16) & crc32_i(31 downto 24);

-- Delay the frame data till the end of CRC computation
XGMII_DELAY: process(TX_CLK)
begin
  if (TX_CLK'event and TX_CLK = '1') then
      txd_i_dly0 <= tx_d_i;
      txc_i_dly0 <= tx_c_i;
      crc_mask_dly0 <= crc_mask;

      txd_i_dly1 <= txd_i_dly0;
      txc_i_dly1 <= txc_i_dly0;
      crc_mask_dly1 <= crc_mask_dly0;

      txd_i_dly2 <= txd_i_dly1;
      txc_i_dly2 <= txc_i_dly1;
      crc_mask_dly2 <= crc_mask_dly1;

      txd_i_dly3 <= txd_i_dly2;
      txc_i_dly3 <= txc_i_dly2;
      crc_mask_dly3 <= crc_mask_dly2;


      
      crc_mask_dly4 <= crc_mask_dly3;

  end if;
end process;

-- process will insert result of crc computation to output
CRC_INSERT: process(TX_CLK)
begin
   if (TX_CLK'event and TX_CLK = '1') then
      crc_dly <= crc32;
      crc_vld_dly <= crc_vld;
      TXD <= txd_i_dly3;
      TXC <= txc_i_dly3;

      if crc_vld = '1' then
         case crc_mask_dly3 is
            when "001"  => TXD <= crc32( 7 downto 0) & txd_i_dly3(55 downto 0);
            when "010"  => TXD <= crc32(15 downto 0) & txd_i_dly3(47 downto 0);
            when "011"  => TXD <= crc32(23 downto 0) & txd_i_dly3(39 downto 0);
            when "100"  => TXD <= crc32(31 downto 0) & txd_i_dly3(31 downto 0);
            when "101"  => TXD <= txd_i_dly3(63 downto 56) & crc32(31 downto 0) & txd_i_dly3(23 downto 0);
            when "110"  => TXD <= txd_i_dly3(63 downto 48) & crc32(31 downto 0) & txd_i_dly3(15 downto 0);
            when "111"  => TXD <= txd_i_dly3(63 downto 40) & crc32(31 downto 0) & txd_i_dly3(7 downto 0);
            when others => null;
         end case;
      elsif crc_vld_dly = '1' then
         case crc_mask_dly4 is
            when "000"  => TXD <= txd_i_dly3(63 downto 32) & crc_dly(31 downto 0);
            when "001"  => TXD <= txd_i_dly3(63 downto 24) & crc_dly(31 downto 8);
            when "010"  => TXD <= txd_i_dly3(63 downto 16) & crc_dly(31 downto 16);
            when "011"  => TXD <= txd_i_dly3(63 downto  8) & crc_dly(31 downto 24);
            when others => null;
         end case;
      end if;

   end if;
end process;

end behavioral;

