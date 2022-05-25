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
-- This wrapper forms complete UDP/IP stack with both RX and TX capability.
-- Both RX and TX interfaces are buffered using FIFOs.
--
-- The core is aimed to be connected to 64 bit XGMII interface of Xilinx RXAUI
-- core or equivalent.
--
-- All ports (both RX and TX) are synchronous to single clock - CLK. It is
-- supposed to run at 156.25 MHz regardless of link speed. 
-- Because XGMII doesn't adjust frequency to link speed and there is no flow 
-- control mechanism embedded in XGMII protocol, UDP/IP core must be informed
-- what link speed is currently used through LINK_SPEED port. Available values
-- are as follows:
-- "000" - 10  Gbps
-- "001" - 5   Gbps
-- "010" - 2.5 Gbps
-- "011" - 1   Gbps
-- "100" - 100 Mbps
-- "101" - 10  Mbps
--
-- Speed is adjusted by insertion of inter-frame gaps. If real link speed is
-- higher than core is set to, no data are lost or corrupted, but speed of TX
-- is suboptimal. If real link speed is smaller than core is set to, some
-- packets may not be sent at all, or can be sent incomplete. Reception is
-- not dependent on this setting and will work regardless link speed.
--
-- Each path (rx and tx) contains two FIFOs. One for data and one for tags
-- that describe what is stored in data FIFO. Data FIFOs have both 
-- width 72 bits - 64 bit data + 8 bit byte enables. Tag FIFOs differ.
-- TX tag fifo is 16 bits wide, RX tag fifo 34 bits wide.
-- In both paths whole datagram must be stored in FIFO before it is transmitted
-- to network(tx) or provided to user(rx).
-- Depth of each FIFO can be set by user. Data FIFO must be at least deep
-- enough to contain one the largest packet that can appear on network.
-- In most cases MTU is either 1500 or 9000 bytes. So 1500/8 = 187 and
-- 9000/8 = 1125 are minimal depths for data FIFOs.
-- Depth of tag fifos depends on maximum number of datagrams that are expected
-- to be buffered in data FIFO at once. For tx tag fifo one word is used for
-- each buffered packet. For rx three words of tag FIFO are used per each
-- buffered packets.
-- User can also select technology used to implelent FIFOs. Type can be
-- either selected automatically by Vivado tools ("auto") or it can be
-- implemented in block RAMs ("block") or as distributed memory in LUTs
-- ("distributed"). FIFOs are instances of Xilinx Parametrized Macros.
-- Each project that uses this macros must have XPM libraries enabled.
-- This can be done with tcl command:
-- set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-----
-- These are Xilinx parametrized macro libraries. It is used to 
-- Instantiate FIFOs without the need to create sub-IP
-- They also support setting depth and type in generics
--
-- If new project is created and these macros should be used TCL command
-- set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
-- must be used to enable their usage.
----------------------
Library xpm;
use xpm.vcomponents.all;

library work;
use work.frame_pkg.all;


entity udp_ip_10g is
   generic (
      g_tx_dfifo_depth  : integer := 2048; -- 72 bit data width (8 data bytes)
      g_tx_tfifo_depth  : integer := 128;  -- 16 bit data width
      g_rx_dfifo_depth  : integer := 2048; -- 72 bit data width (8 data bytes)
      g_rx_tfifo_depth  : integer := 128;  -- 34 bit data width
      g_tx_dfifo_type   : string  := "block"; -- auto, block, distributed
      g_tx_tfifo_type   : string  := "block";
      g_rx_dfifo_type   : string  := "block";
      g_rx_tfifo_type   : string  := "block"
           );
   port (
      RST               : in  std_logic;
      CLK               : in  std_logic;

      -- General control signals
      LINK_SPEED        : in  std_logic_vector(2 downto 0);
      

      -- Host information user interface
      HOST_MAC          : in  std_logic_vector(47 downto 0);
      HOST_IP           : in  std_logic_vector(31 downto 0);
      HOST_IP_NETMASK   : in  std_logic_vector(31 downto 0);

      -- TX user interface
      TX_DST_MAC        : in  std_logic_vector(47 downto 0);
      TX_DST_IP         : in  std_logic_vector(31 downto 0);
      TX_SRC_UDP        : in  std_logic_vector(15 downto 0);
      TX_DST_UDP        : in  std_logic_vector(15 downto 0);

      TX_FRAME_VALID    : in  std_logic;
      TX_FRAME_RDY      : out std_logic;
      TX_FRAME_LAST     : in  std_logic;
      TX_FRAME_BE       : in  std_logic_vector(7 downto 0);
      TX_FRAME_DATA     : in  std_logic_vector(63 downto 0);

      -- RX user interface
      RX_SRC_MAC        : out std_logic_vector(47 downto 0);
      RX_SRC_IP         : out std_logic_vector(31 downto 0);
      RX_SRC_UDP        : out std_logic_vector(15 downto 0);
      RX_DST_UDP        : out std_logic_vector(15 downto 0);

      RX_FRAME_VALID    : out std_logic;
      RX_FRAME_RDY      : in  std_logic;
      RX_FRAME_LAST     : out std_logic;
      RX_FRAME_BE       : out std_logic_vector(7 downto 0);
      RX_FRAME_DATA     : out std_logic_vector(63 downto 0);
      RX_FRAME_LENGTH   : out std_logic_vector(15 downto 0);
      
      -- XGMII interface
      XGMII_TXC         : out std_logic_vector(7 downto 0);
      XGMII_TXD         : out std_logic_vector(63 downto 0);
      XGMII_RXC         : in  std_logic_vector(7 downto 0);
      XGMII_RXD         : in  std_logic_vector(63 downto 0)
      

        );
end entity;


architecture synthesis of udp_ip_10g is
   
   signal rst_cnt             : integer range 0 to 15 := 0;
   signal rst_internal        : std_logic := '1';

-----------------------------------------------------------------------------
-- TX Path internal connection signals
-----------------------------------------------------------------------------

   signal txi_wr_dfifo_data   : txi_dfifo_data_type;
   signal txi_wr_dfifo_wr_en  : std_logic;
   signal txi_wr_dfifo_full   : std_logic;

   signal txi_wr_tfifo_data   : txi_tfifo_data_type;
   signal txi_wr_tfifo_wr_en  : std_logic;
   signal txi_wr_tfifo_full   : std_logic;

   signal txi_rd_dfifo_data   : txi_dfifo_data_type;
   signal txi_rd_dfifo_rd_en  : std_logic;
   signal txi_rd_dfifo_empty  : std_logic;

   signal txi_rd_tfifo_data   : txi_tfifo_data_type;
   signal txi_rd_tfifo_rd_en  : std_logic;
   signal txi_rd_tfifo_empty  : std_logic;


   signal fg_tx_en            : std_logic;
   signal fg_busy             : std_logic;
   signal fg_idle_ifg         : std_logic;
   signal fg_busy_throttled   : std_logic;
   signal fg_data_ren         : std_logic;
   signal fg_data_in          : std_logic_vector(63 downto 0);
   signal fg_data_len         : std_logic_vector(15 downto 0);
   signal fg_dst_mac          : std_logic_vector(47 downto 0);
   signal fg_dst_ip           : std_logic_vector(31 downto 0);
   signal fg_src_port         : std_logic_vector(15 downto 0);
   signal fg_dst_port         : std_logic_vector(15 downto 0);

-----------------------------------------------------------------------------
-- RX Path internal connection signals
-----------------------------------------------------------------------------
   

   signal frx_wr_dfifo_data   : fp_dfifo_data_type;
   signal frx_wr_dfifo_wr_en  : std_logic;
   signal frx_wr_dfifo_full   : std_logic := '0';

   signal frx_wr_tfifo_data   : fp_tfifo_data_type;
   signal frx_wr_tfifo_wr_en  : std_logic;
   signal frx_wr_tfifo_full   : std_logic := '0';

   signal frx_rd_dfifo_data   : fp_dfifo_data_type;
   signal frx_rd_dfifo_rd_en  : std_logic;
   signal frx_rd_dfifo_empty  : std_logic;
   signal frx_rd_tfifo_data   : fp_tfifo_data_type;
   signal frx_rd_tfifo_rd_en  : std_logic;
   signal frx_rd_tfifo_empty  : std_logic;

   signal fr_rx_data          : std_logic_vector(63 downto 0);
   signal fr_rx_dv            : std_logic;
   signal fr_rx_be            : std_logic_vector(7 downto 0);
   signal fr_rx_err           : std_logic;
   signal fr_rx_err_valid     : std_logic;


begin

   -- Reset should take at least 16 cycles to flush pipeline
   rst_proc : process (CLK)
   begin
      if rising_edge(CLK) then
         if RST = '1' then
            rst_cnt <= 0;
            rst_internal <= '1';
         elsif rst_cnt < 15 then
            rst_cnt <= rst_cnt + 1;
            rst_internal <= '1';
         else
            rst_internal <= '0';
         end if;
      end if;
   end process;

-----------------------------------------------------------------------------
-- TX Path
-----------------------------------------------------------------------------

   frame_tx_if_inst : entity work.frame_tx_if
   port map(
      CLK            => CLK,
      RST            => rst_internal,

      DST_MAC        => TX_DST_MAC,
      DST_IP         => TX_DST_IP,
      SRC_UDP        => TX_SRC_UDP,
      DST_UDP        => TX_DST_UDP,

      FRAME_VALID    => TX_FRAME_VALID,
      FRAME_RDY      => TX_FRAME_RDY,
      FRAME_LAST     => TX_FRAME_LAST,
      FRAME_BE       => TX_FRAME_BE,
      FRAME_DATA     => TX_FRAME_DATA,

      -- Tag and data fifos
      DFIFO_DATA     => txi_wr_dfifo_data,
      DFIFO_WR_EN    => txi_wr_dfifo_wr_en,
      DFIFO_FULL     => txi_wr_dfifo_full,

      TFIFO_DATA     => txi_wr_tfifo_data,
      TFIFO_WR_EN    => txi_wr_tfifo_wr_en,
      TFIFO_FULL     => txi_wr_tfifo_full
        );

   txi_dfifo_inst : xpm_fifo_sync
   generic map (
      FIFO_MEMORY_TYPE           => g_tx_dfifo_type,          
      ECC_MODE                   => "no_ecc",         
      FIFO_WRITE_DEPTH           => g_tx_dfifo_depth,             
      WRITE_DATA_WIDTH           => txi_dfifo_data_type'length, 
      WR_DATA_COUNT_WIDTH        => 1,               
      PROG_FULL_THRESH           => 10,               
      FULL_RESET_VALUE           => 0,                
      READ_MODE                  => "fwft",           
      FIFO_READ_LATENCY          => 0,                
      READ_DATA_WIDTH            => txi_dfifo_data_type'length, 
      RD_DATA_COUNT_WIDTH        => 1,               
      PROG_EMPTY_THRESH          => 10,               
      DOUT_RESET_VALUE           => "0",              
      WAKEUP_TIME                => 0                 
   )
   port map (
      rst                        => rst_internal,
      wr_clk                     => CLK,
      wr_en                      => txi_wr_dfifo_wr_en,
      din                        => txi_wr_dfifo_data,
      full                       => txi_wr_dfifo_full,
      overflow                   => open,
      wr_rst_busy                => open,
      rd_en                      => txi_rd_dfifo_rd_en,
      dout                       => txi_rd_dfifo_data,
      empty                      => txi_rd_dfifo_empty,
      underflow                  => open,
      rd_rst_busy                => open,
      prog_full                  => open,
      wr_data_count              => open,
      prog_empty                 => open,
      rd_data_count              => open,
      sleep                      => '0',
      injectsbiterr              => '0',
      injectdbiterr              => '0',
      sbiterr                    => open,
      dbiterr                    => open
   );

   txi_tfifo_inst : xpm_fifo_sync
   generic map (
      FIFO_MEMORY_TYPE           => g_tx_tfifo_type,          
      ECC_MODE                   => "no_ecc",         
      FIFO_WRITE_DEPTH           => g_tx_tfifo_depth,             
      WRITE_DATA_WIDTH           => txi_wr_tfifo_data'length, 
      WR_DATA_COUNT_WIDTH        => 1,               
      PROG_FULL_THRESH           => 10,               
      FULL_RESET_VALUE           => 0,                
      READ_MODE                  => "fwft",           
      FIFO_READ_LATENCY          => 0,                
      READ_DATA_WIDTH            => txi_wr_tfifo_data'length,  
      RD_DATA_COUNT_WIDTH        => 1,               
      PROG_EMPTY_THRESH          => 10,               
      DOUT_RESET_VALUE           => "0",              
      WAKEUP_TIME                => 0                 
   )
   port map (
      rst                        => rst_internal,
      wr_clk                     => CLK,
      wr_en                      => txi_wr_tfifo_wr_en,
      din                        => txi_wr_tfifo_data,
      full                       => txi_wr_tfifo_full,
      overflow                   => open,
      wr_rst_busy                => open,
      rd_en                      => txi_rd_tfifo_rd_en,
      dout                       => txi_rd_tfifo_data,
      empty                      => txi_rd_tfifo_empty,
      underflow                  => open,
      rd_rst_busy                => open,
      prog_full                  => open,
      wr_data_count              => open,
      prog_empty                 => open,
      rd_data_count              => open,
      sleep                      => '0',
      injectsbiterr              => '0',
      injectdbiterr              => '0',
      sbiterr                    => open,
      dbiterr                    => open
    );


   frame_gen_fifo_if_inst : entity work.frame_gen_fifo_if
   port map (
      CLK            => clk,

      DST_MAC        => fg_dst_mac,
      DST_IP         => fg_dst_ip,
      SRC_UDP        => fg_src_port,
      DST_UDP        => fg_dst_port,

      -- Frame generator if
      FG_TX_EN       => fg_tx_en,
      FG_BUSY        => fg_busy_throttled,
      FG_DATA_REN    => fg_data_ren,
      FG_DATA_IN     => fg_data_in,
      FG_DATA_LEN    => fg_data_len,

      -- Tag and data fifos
      DFIFO_DATA     => txi_rd_dfifo_data,
      DFIFO_RD_EN    => txi_rd_dfifo_rd_en,
      DFIFO_EMPTY    => txi_rd_dfifo_empty,

      TFIFO_DATA     => txi_rd_tfifo_data,
      TFIFO_RD_EN    => txi_rd_tfifo_rd_en,
      TFIFO_EMPTY    => txi_rd_tfifo_empty

        );

   frame_throttle_inst : entity work.frame_throttle
   port map (
      CLK            => clk,
      LINK_SPEED     => LINK_SPEED,

      FG_BUSY        => fg_busy,
      FG_IDLE_IFG    => fg_idle_ifg,
      BUSY_THROTTLED => fg_busy_throttled
   );


   -- Frame generator
   frame_gen_inst : entity work.frame_gen
   port map (
      RESET       => rst_internal,
      TX_EN       => fg_tx_en,
      BUSY        => fg_busy,
      IDLE_IFG    => fg_idle_ifg,
      DATA_REN    => fg_data_ren,
      DATA_IN     => fg_data_in,
      DATA_LEN    => fg_data_len,
      SRC_MAC     => HOST_MAC,
      DST_MAC     => fg_dst_mac,
      SRC_IP      => HOST_IP,
      DST_IP      => fg_dst_ip,
      SRC_PORT    => fg_src_port,
      DST_PORT    => fg_dst_port,
      TX_CLK      => clk,
      TXD         => XGMII_TXD,
      TXC         => XGMII_TXC
   );
-----------------------------------------------------------------------------
-- RX Path
-----------------------------------------------------------------------------

     -- Frame receiver
   frame_receiver_inst : entity work.frame_receiver
   port map (
      RST               => rst_internal,

      -- XGMII RX input interface
      XGMII_RXCLK       => CLK,
      XGMII_RXD         => XGMII_RXD,
      XGMII_RXC         => XGMII_RXC,

       -- Output interface
      RX_DATA           => fr_rx_data,
      RX_DV             => fr_rx_dv,
      RX_BE             => fr_rx_be,
      RX_ERR            => fr_rx_err,
      RX_ERR_VALID      => fr_rx_err_valid
        );

    -- Frame process
   frame_process_inst : entity work.frame_process
   port map (
      RST               => rst_internal,
      CLK               => CLK,

      -- Interface towards frame receiver
      RX_DATA           => fr_rx_data,
      RX_DV             => fr_rx_dv,
      RX_BE             => fr_rx_be,
      RX_ERR            => fr_rx_err,
      RX_ERR_VALID      => fr_rx_err_valid,

      DFIFO_DATA        => frx_wr_dfifo_data,
      DFIFO_WR_EN       => frx_wr_dfifo_wr_en,
      DFIFO_FULL        => frx_wr_dfifo_full,

      TFIFO_DATA        => frx_wr_tfifo_data,
      TFIFO_WR_EN       => frx_wr_tfifo_wr_en,
      TFIFO_FULL        => frx_wr_tfifo_full,
      
      MAC_ADDR          => HOST_MAC,
      IP_ADDR           => HOST_IP,
      IP_NET_MASK       => HOST_IP_NETMASK
        );

   rx_dfifo_inst : xpm_fifo_sync
   generic map (
      FIFO_MEMORY_TYPE           => g_rx_dfifo_type,          
      ECC_MODE                   => "no_ecc",         
      FIFO_WRITE_DEPTH           => g_rx_dfifo_depth,             
      WRITE_DATA_WIDTH           => fp_dfifo_data_type'length, 
      WR_DATA_COUNT_WIDTH        => 1,               
      PROG_FULL_THRESH           => 10,               
      FULL_RESET_VALUE           => 0,                
      READ_MODE                  => "fwft",           
      FIFO_READ_LATENCY          => 0,                
      READ_DATA_WIDTH            => fp_dfifo_data_type'length, 
      RD_DATA_COUNT_WIDTH        => 1,               
      PROG_EMPTY_THRESH          => 10,               
      DOUT_RESET_VALUE           => "0",              
      WAKEUP_TIME                => 0                 
   )
   port map (
      rst                        => rst_internal,
      wr_clk                     => CLK,
      wr_en                      => frx_wr_dfifo_wr_en,
      din                        => frx_wr_dfifo_data,
      full                       => frx_wr_dfifo_full,
      overflow                   => open,
      wr_rst_busy                => open,
      rd_en                      => frx_rd_dfifo_rd_en,
      dout                       => frx_rd_dfifo_data,
      empty                      => frx_rd_dfifo_empty,
      underflow                  => open,
      rd_rst_busy                => open,
      prog_full                  => open,
      wr_data_count              => open,
      prog_empty                 => open,
      rd_data_count              => open,
      sleep                      => '0',
      injectsbiterr              => '0',
      injectdbiterr              => '0',
      sbiterr                    => open,
      dbiterr                    => open
   );

   rx_tfifo_inst : xpm_fifo_sync
   generic map (
      FIFO_MEMORY_TYPE           => g_rx_tfifo_type,          
      ECC_MODE                   => "no_ecc",         
      FIFO_WRITE_DEPTH           => g_rx_tfifo_depth,             
      WRITE_DATA_WIDTH           => frx_wr_tfifo_data'length, 
      WR_DATA_COUNT_WIDTH        => 1,               
      PROG_FULL_THRESH           => 10,               
      FULL_RESET_VALUE           => 0,                
      READ_MODE                  => "fwft",           
      FIFO_READ_LATENCY          => 0,                
      READ_DATA_WIDTH            => frx_wr_tfifo_data'length,  
      RD_DATA_COUNT_WIDTH        => 1,               
      PROG_EMPTY_THRESH          => 10,               
      DOUT_RESET_VALUE           => "0",              
      WAKEUP_TIME                => 0                 
   )
   port map (
      rst                        => rst_internal,
      wr_clk                     => CLK,
      wr_en                      => frx_wr_tfifo_wr_en,
      din                        => frx_wr_tfifo_data,
      full                       => frx_wr_tfifo_full,
      overflow                   => open,
      wr_rst_busy                => open,
      rd_en                      => frx_rd_tfifo_rd_en,
      dout                       => frx_rd_tfifo_data,
      empty                      => frx_rd_tfifo_empty,
      underflow                  => open,
      rd_rst_busy                => open,
      prog_full                  => open,
      wr_data_count              => open,
      prog_empty                 => open,
      rd_data_count              => open,
      sleep                      => '0',
      injectsbiterr              => '0',
      injectdbiterr              => '0',
      sbiterr                    => open,
      dbiterr                    => open
    );

   frame_rx_if_inst : entity work.frame_rx_if
   port map (
      RST            => rst_internal,
      CLK            => clk,

      FRAME_VALID    => RX_FRAME_VALID,
      FRAME_RD_EN    => RX_FRAME_RDY,
      FRAME_LENGTH   => RX_FRAME_LENGTH,
      FRAME_LAST     => RX_FRAME_LAST,
      FRAME_BE       => RX_FRAME_BE,
      FRAME_DATA     => RX_FRAME_DATA,
      SRC_MAC        => RX_SRC_MAC,
      SRC_IP         => RX_SRC_IP,
      SRC_UDP        => RX_SRC_UDP,
      DST_UDP        => RX_DST_UDP,


      -- Tag and data fifos
      DFIFO_DATA     => frx_rd_dfifo_data,
      DFIFO_RD_EN    => frx_rd_dfifo_rd_en,
      DFIFO_EMPTY    => frx_rd_dfifo_empty,

      TFIFO_DATA     => frx_rd_tfifo_data,
      TFIFO_RD_EN    => frx_rd_tfifo_rd_en,
      TFIFO_EMPTY    => frx_rd_tfifo_empty
        );


end architecture;







