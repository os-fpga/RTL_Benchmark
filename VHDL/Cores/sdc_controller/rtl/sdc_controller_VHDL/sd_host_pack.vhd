--------------------------------------------------------------------------
-- Package containing SD Card interface modules,
-- and related support modules.
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package sd_host_pack is

-- Constants relating to the SD Card interface

  -- Register size constants
constant BLKSIZE_W    : integer := 12;
constant BLKCNT_W     : integer := 16;

  -- cmd module interrupts
constant INT_CMD_CC    : integer := 0;
constant INT_CMD_EI    : integer := 1;
constant INT_CMD_CTE   : integer := 2;
constant INT_CMD_CCRCE : integer := 3;
constant INT_CMD_CIE   : integer := 4;
constant INT_CMD_SIZE  : integer := 5; -- Size of register field, in bits

  -- data module interrupts
constant INT_DATA_CC    : integer := 0;
constant INT_DATA_CCRCE : integer := 1;
constant INT_DATA_CFE   : integer := 2;
constant INT_DATA_SIZE  : integer := 3; -- Size of register field, in bits

  component sd_cmd_host
  port(
    sys_rst      : in  std_logic;
    sd_clk       : in  std_logic;
    -- Control and settings
    start_i      : in  std_logic;
    int_rst_i    : in std_logic;
    busy_i       : in  std_logic; --direct signal from data sd data input (data[0])
    cmd_index_i  : in  unsigned(5 downto 0);
    argument_i   : in  unsigned(31 downto 0);
    timeout_i    : in  unsigned(15 downto 0);
    int_status_o : out unsigned(4 downto 0);
    response_0_o : out unsigned(31 downto 0);
    response_1_o : out unsigned(31 downto 0);
    response_2_o : out unsigned(31 downto 0);
    response_3_o : out unsigned(31 downto 0);
    -- SD/MMC card command signals
    sd_cmd_i     : in  std_logic;
    sd_cmd_o     : out std_logic;
    sd_cmd_oe_o  : out std_logic
  );
  end component;

  component sd_data_8bit_host
  port(
    sd_clk        : in  std_logic;
    sys_rst       : in  std_logic;
    --Tx Fifo
    tx_dat_i      : in  unsigned(7 downto 0);
    tx_dat_rd_o   : out std_logic;
    --Rx Fifo
    rx_dat_o      : out unsigned(7 downto 0);
    rx_dat_we_o   : out std_logic;
    --SD data
    sd_dat_siz_o  : out unsigned(1 downto 0);
    sd_dat_oe_o   : out std_logic;
    sd_dat_o      : out unsigned(7 downto 0);
    sd_dat_i      : in  unsigned(7 downto 0);
    --Control signals
    blksize_i     : in  unsigned(BLKSIZE_W-1 downto 0);
    bus_size_i    : in  unsigned(1 downto 0);
    blkcnt_i      : in  unsigned(BLKCNT_W-1 downto 0);
    d_stop_i      : in  std_logic;
    d_read_i      : in  std_logic;
    d_write_i     : in  std_logic;
    bustest_w_i   : in  std_logic;
    bustest_r_i   : in  std_logic;
    bustest_res_o : out unsigned(2 downto 0);
    sd_dat_busy_o : out std_logic;
    fsm_busy_o    : out std_logic;
    crc_ok_o      : out std_logic
  );
  end component;

  component sd_controller_8bit_bram
  port (
    -- WISHBONE common
    wb_clk_i     : in  std_logic;
    wb_rst_i     : in  std_logic;
    -- WISHBONE slave (register interface)
    wb_dat_i     : in  unsigned(31 downto 0);
    wb_dat_o     : out unsigned(31 downto 0);
    wb_adr_i     : in  unsigned(3 downto 0);
    wb_we_i      : in  std_logic;
    wb_cyc_i     : in  std_logic;
    wb_ack_o     : out std_logic;
    -- Dedicated BRAM port without acknowledge.
    -- Access cycles must complete immediately.
    -- (data to cross clock domains by this dual-ported BRAM)
    bram_clk_o   : out std_logic; -- Same as sd_clk_o_pad
    bram_dat_o   : out unsigned(7 downto 0);
    bram_dat_i   : in  unsigned(7 downto 0);
    bram_adr_o   : out unsigned(31 downto 0);
    bram_we_o    : out std_logic;
    bram_cyc_o   : out std_logic;
    --SD Card Interface
    sd_cmd_i     : in  std_logic;
    sd_cmd_o     : out std_logic;
    sd_cmd_oe_o  : out std_logic;
    sd_dat_i     : in  unsigned(7 downto 0);
    sd_dat_o     : out unsigned(7 downto 0);
    sd_dat_oe_o  : out std_logic;
    sd_dat_siz_o : out unsigned(1 downto 0);
    sd_clk_o_pad : out std_logic;
    -- Interrupt outputs
    int_cmd_o    : out std_logic;
    int_data_o   : out std_logic
  );
  end component;

end sd_host_pack;

package body sd_host_pack is
end sd_host_pack;

-------------------------------------------------------------------------------
-- SD/MMC Command Host
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update: June 11, 2016 Combined sd_cmd_master with sd_cmd_serial_host from
--                       the opencores.org VHDL code, in order to make this
--                       unit.  The reason for combining them is that eight
--                       interface signals were shared only between those two
--                       modules when they were instantiated, and they are not
--                       needed individually.
--
-- Description
-------------------------------------------------------------------------------
-- This module handles generating the serial SD/MMC command output, and
-- receiving the SD/MMC responses from the card.
--
-- This unit runs entirely within the sd_clk_i clock domain.
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.ucrc_pack.all;
use work.sd_host_pack.all;

entity sd_cmd_host is
  port(
    sys_rst      : in  std_logic;
    sd_clk       : in  std_logic;
    -- Control and settings
    start_i      : in  std_logic;
    int_rst_i    : in std_logic;
    busy_i       : in  std_logic; --direct signal from data sd data input (data[0])
    cmd_index_i  : in  unsigned(5 downto 0);
    argument_i   : in  unsigned(31 downto 0);
    timeout_i    : in  unsigned(15 downto 0);
    int_status_o : out unsigned(4 downto 0);
    response_0_o : out unsigned(31 downto 0);
    response_1_o : out unsigned(31 downto 0);
    response_2_o : out unsigned(31 downto 0);
    response_3_o : out unsigned(31 downto 0);
    -- SD/MMC card command signals
    sd_cmd_i     : in  std_logic;
    sd_cmd_o     : out std_logic;
    sd_cmd_oe_o  : out std_logic
  );
end sd_cmd_host;

architecture beh of sd_cmd_host is

---------------Internal Constants-------------
constant INIT_DELAY   : integer := 4;
constant BITS_TO_SEND : integer := 48;
constant CMD_SIZE     : integer := 40;
constant RESP_SIZE    : integer := 128;

-----------------Internal Signals-----------
signal cmd_dat_reg   : std_logic;
signal resp_len      : integer;
signal cmd_buff      : unsigned(CMD_SIZE-1 downto 0);
signal resp_buff     : unsigned(RESP_SIZE-1 downto 0);
signal resp_idx      : integer;
  --CRC related
signal crc_rst_n  : std_logic;
signal crc_in     : unsigned(6 downto 0);
signal crc_val    : unsigned(6 downto 0);
signal crc_enable : std_logic;
signal crc_bit    : std_logic;
signal crc_ok     : std_logic;
  --Internal Counters
signal counter    : integer;
  --State Machines
type SERIAL_STATE_TYPE is (INIT, IDLE, SETUP_CRC, WRITE, READ_WAIT, READ, FINISH_WR);
signal serial_state : SERIAL_STATE_TYPE;
type CMD_STATE_TYPE is (IDLE, EXECUTE, BUSY_WAIT);
signal cmd_state    : CMD_STATE_TYPE;

signal expect_response : std_logic;
signal watchdog        : unsigned(15 downto 0);

-- Signals originally from sd_cmd_master (DELETE THIS COMMENT SOON)
signal timeout_reg : unsigned(15 downto 0);
signal int_status_reg  : unsigned(4 downto 0);

begin

-- Form a signal indicating when a response is expected
expect_response <= '0' when (cmd_index_i=0 or cmd_index_i=4 or cmd_index_i=15) else '1';

-- Command Finite State Machine
cmd_fsm_proc : process(sys_rst,sd_clk)
begin
  if (sys_rst='1') then
    response_0_o <= (others=>'0');
    response_1_o <= (others=>'0');
    response_2_o <= (others=>'0');
    response_3_o <= (others=>'0');
    int_status_reg  <= (others=>'0');
    resp_len    <= 0;
    watchdog    <= (others=>'0');
    timeout_reg <= (others=>'0');
    cmd_state   <= IDLE;
    cmd_buff    <= (others=>'0');
  elsif (sd_clk'event and sd_clk='1') then
    watchdog <= watchdog+1;
    case (cmd_state) is
      when IDLE =>
        -- Only CMD2, CMD9 and CMD10 have long responses...
        if (cmd_index_i=2 or cmd_index_i=9 or cmd_index_i=10) then
          resp_len <= 127;
        else
          resp_len <= 39;
        end if;
        cmd_buff(39 downto 38) <= "01";
        cmd_buff(37 downto 32) <= cmd_index_i;
        cmd_buff(31 downto 0)  <= argument_i; --CMD_Argument
        timeout_reg <= timeout_i;
        watchdog <= (others=>'0');
        if (start_i='1') then
            int_status_reg <= (others=>'0');
        end if;
        -- State transition
        if (start_i='1') then
          response_0_o <= (others=>'0');
          response_1_o <= (others=>'0');
          response_2_o <= (others=>'0');
          response_3_o <= (others=>'0');
          cmd_state <= EXECUTE;
        end if;

      when EXECUTE =>
        if (watchdog > timeout_reg) then
          int_status_reg(INT_CMD_CTE) <= '1';
          int_status_reg(INT_CMD_EI) <= '1';
          response_0_o <= to_unsigned(16#55555555#,32);
          response_1_o <= to_unsigned(16#55555555#,32);
          response_2_o <= to_unsigned(16#55555555#,32);
          response_3_o <= to_unsigned(16#55555555#,32);
          cmd_state <= IDLE;
        else --Incoming New Status
          if (serial_state=FINISH_WR) then --Data available
            -- CMD1 has "1111111" for the CRC field...
            if (cmd_index_i/=1 and crc_ok='0') then
              int_status_reg(INT_CMD_CCRCE) <= '1';
              int_status_reg(INT_CMD_EI) <= '1';
            end if;
            if (resp_len=39 and cmd_index_i/=1 and cmd_buff(37 downto 32)/=resp_buff(125 downto 120)) then
              int_status_reg(INT_CMD_CIE) <= '1';
              int_status_reg(INT_CMD_EI) <= '1';
            end if;
            int_status_reg(INT_CMD_CC) <= '1';
            if (expect_response/='0') then
              response_0_o <= resp_buff(119 downto 88);
              response_1_o <= resp_buff(87 downto 56);
              response_2_o <= resp_buff(55 downto 24);
              response_3_o <= resp_buff(23 downto 0) & "00000000";
            end if;
            -- end
          end if; --Data avaible
        end if; --Status change
        -- State transition
        if (watchdog > timeout_reg) then
          cmd_state <= IDLE;
        elsif (serial_state=FINISH_WR) then
          cmd_state <= BUSY_WAIT;
        end if;

      when BUSY_WAIT =>
        if (watchdog > timeout_reg) then
          int_status_reg(INT_CMD_CTE) <= '1';
          int_status_reg(INT_CMD_EI) <= '1';
          cmd_state <= IDLE;
        end if;
        -- State transition
        if (busy_i='0') then
          cmd_state <= IDLE;
        end if;

      when others =>
        cmd_state <= IDLE;

    end case;

    if (int_rst_i='1') then
      int_status_reg <= (others=>'0');
    end if;

  end if;
end process;
int_status_o <= int_status_reg;



--sd cmd input pad register
process(sd_clk, sys_rst)  -- JLC added sys_rst to sensitivity list.
begin
  if (sys_rst='1') then
    cmd_dat_reg <= '0';
--  elsif (sd_clk'event and sd_clk='0') then -- use falling edge, when data is stable
  elsif (sd_clk'event and sd_clk='0') then -- use rising edge, per the specification
    cmd_dat_reg <= sd_cmd_i;
  end if;
end process;

--------------------------------------------
-- CRC generator

  crc0 : ucrc_ser
  generic map (
    POLYNOMIAL => "0001001",
    INIT_VALUE => "0000000"
  )
  port map (
    -- System clock and asynchronous reset
    sys_clk    => sd_clk,
    sys_rst_n  => crc_rst_n,
    sys_clk_en => crc_enable,

    -- Input and Control
    clear_i    => '0',
    data_i     => crc_bit,
    flush_i    => '0',

    -- Output
    match_o    => open,
    crc_o      => crc_val
  );

--------------------------------------------
-- This is the serial_state machine
--------------------------------------------
serial_fsm_proc : process(sd_clk, sys_rst)
begin
  if (sys_rst='1') then
    serial_state <= INIT;
    crc_enable   <= '0';
    resp_idx     <= 0;
    sd_cmd_oe_o  <= '1';
    sd_cmd_o     <= '1';
    resp_buff    <= (others=>'0');
    crc_rst_n    <= '0';
    crc_bit      <= '0';
    crc_in       <= (others=>'0');
    crc_ok       <= '0';
    counter      <= 0;
  elsif (sd_clk'event and sd_clk='1') then

    case (serial_state) is

      when INIT =>
        counter <= counter+1;
        sd_cmd_oe_o <= '1';
        sd_cmd_o    <= '1';
        if (counter >= INIT_DELAY) then
          serial_state <= IDLE;
        end if;

      when IDLE =>
        sd_cmd_oe_o <= '0'; --Put CMD to Z
        counter    <= 0;
        crc_rst_n  <= '0';
        crc_enable <= '0';
        resp_idx   <= 0;
        if (start_i='1') then
          serial_state <= SETUP_CRC;
          resp_buff    <= (others=>'0');
        end if;

      when SETUP_CRC =>
        crc_rst_n  <= '1';
        crc_enable <= '1';
        crc_bit    <= cmd_buff(CMD_SIZE-1-counter);
        serial_state <= WRITE;

      when WRITE =>
        if (counter < BITS_TO_SEND-8) then  -- 1->40 CMD, (41 <= CNT <=47) CRC, 48 stop_bit
          sd_cmd_oe_o <= '1';
          sd_cmd_o    <= cmd_buff(CMD_SIZE-1-counter);
          if (counter < BITS_TO_SEND-9) then --1 step ahead
            crc_bit <= cmd_buff((CMD_SIZE-1-counter)-1);
          else
            crc_enable <= '0';
          end if;
        elsif (counter < BITS_TO_SEND-1) then
          crc_enable  <= '0';
          sd_cmd_o    <= crc_val(BITS_TO_SEND-counter-2);
          sd_cmd_oe_o <= '1';
        elsif (counter = BITS_TO_SEND-1) then
          sd_cmd_oe_o <= '1';
          sd_cmd_o    <= '1';
        else
          sd_cmd_oe_o <= '0';
          sd_cmd_o    <= '1';
        end if;
        counter <= counter+1;

        if (counter >= BITS_TO_SEND and expect_response='1') then
          serial_state <= READ_WAIT;
        elsif (counter >= BITS_TO_SEND) then
          serial_state <= FINISH_WR;
        end if;

      when READ_WAIT =>
        crc_enable  <= '0';
        crc_rst_n   <= '0';
        counter     <= 1;
        sd_cmd_oe_o <= '0';
        resp_buff(RESP_SIZE-1) <= cmd_dat_reg;
        if (cmd_dat_reg='0') then
          serial_state <= READ;
        end if;

      when READ =>
        crc_rst_n <= '1';
        if ((resp_len/=RESP_SIZE-1) or (counter>7)) then
          crc_enable <= '1';
        end if;
        sd_cmd_oe_o <= '0';
        if (counter <= resp_len) then
          if (counter < 8) then --1+1+6 (S,T,Index)
            resp_buff(RESP_SIZE-1-counter) <= cmd_dat_reg;
          else
            resp_idx <= resp_idx + 1;
            resp_buff(RESP_SIZE-9-resp_idx) <= cmd_dat_reg;
          end if;
          crc_bit <= cmd_dat_reg;
        elsif (counter-resp_len <= 7) then
          crc_in((resp_len+7)-counter) <= cmd_dat_reg;
          crc_enable <= '0';
        else
          crc_enable <= '0';
          if (crc_in = crc_val) then
            crc_ok <= '1';
          else
            crc_ok <= '0';
          end if;
        end if;
        counter <= counter + 1;
        if (counter >= resp_len+8) then
          serial_state <= FINISH_WR;
        end if;

      when FINISH_WR =>
        crc_enable   <= '0';
        crc_rst_n    <= '0';
        counter      <= 0;
        sd_cmd_oe_o  <= '0';
        serial_state <= IDLE;

      when others =>
        serial_state <= INIT;

    end case;

  end if;
end process;

end beh;

----------------------------------------------------------------------
----                                                              ----
---- WISHBONE SD Card Controller IP Core                          ----
----                                                              ----
---- sd_data_8bit_host.vhd                                        ----
----                                                              ----
---- This file is part of the WISHBONE SD Card                    ----
---- Controller IP Core project                                   ----
---- http:--opencores.org/project,sd_card_controller              ----
----                                                              ----
---- Description                                                  ----
---- Module resposible for sending and receiving data through     ----
---- sd/mmc card data interface                                   ----
----                                                              ----
---- Author(s):                                                   ----
----     - John Clayton, morianton@gmail.com                      ----
----                                                              ----
----------------------------------------------------------------------
----                                                              ----
---- Copyright (C) 2016 Authors                                   ----
----                                                              ----
---- Based on original work by                                    ----
----     Adam Edvardsson (adam.edvardsson@orsoc.se)               ----
----                                                              ----
----     Copyright (C) 2009 Authors                               ----
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
---- PURPOSE. See the GNU Lesser General Public License for more  ----
---- details.                                                     ----
----                                                              ----
---- You should have received a copy of the GNU Lesser General    ----
---- Public License along with this source; if not, download it   ----
---- from http:--www.opencores.org/lgpl.shtml                     ----
----                                                              ----
-- Author: John Clayton                                             --
-- Update: June 11, 2016 Added bustest_w_i and bustest_r_i, plus    --
--                       bustest_res_o result output.               --
----                                                              ----
----------------------------------------------------------------------
--
-- Explanation:
--   bustest_res_o values are:
--     000 = BUSTEST_R (CMD14) not yet performed
--     001 = 1 bit data width
--     010 = 4 bit data width
--     011 = 8 bit data width
--     100 = Unspecified Error
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.sd_host_pack.all;
use work.ucrc_pack.all;

entity sd_data_8bit_host is
  port(
    sd_clk        : in  std_logic;
    sys_rst       : in  std_logic;
    --Tx Fifo
    tx_dat_i      : in  unsigned(7 downto 0);
    tx_dat_rd_o   : out std_logic;
    --Rx Fifo
    rx_dat_o      : out unsigned(7 downto 0);
    rx_dat_we_o   : out std_logic;
    --SD data
    sd_dat_siz_o  : out unsigned(1 downto 0);
    sd_dat_oe_o   : out std_logic;
    sd_dat_o      : out unsigned(7 downto 0);
    sd_dat_i      : in  unsigned(7 downto 0);
    --Control signals
    blksize_i     : in  unsigned(BLKSIZE_W-1 downto 0);
    bus_size_i    : in  unsigned(1 downto 0);
    blkcnt_i      : in  unsigned(BLKCNT_W-1 downto 0);
    d_stop_i      : in  std_logic;
    d_read_i      : in  std_logic;
    d_write_i     : in  std_logic;
    bustest_w_i   : in  std_logic;
    bustest_r_i   : in  std_logic;
    bustest_res_o : out unsigned(2 downto 0);
    sd_dat_busy_o : out std_logic;
    fsm_busy_o    : out std_logic;
    crc_ok_o      : out std_logic
  );
end sd_data_8bit_host;

architecture beh of sd_data_8bit_host is

-- Internal constants

-- Internal signals
signal dat_reg      : unsigned(7 downto 0);
signal data_cycles  : unsigned(BLKSIZE_W+2 downto 0);
signal bus_size_reg : unsigned(1 downto 0);
--CRC16
signal crc_in     : unsigned(7 downto 0);
signal crc_enable : std_logic;
signal crc_rst_n  : std_logic;
type crc_out_type is
  array (integer range 0 to 7) of unsigned(15 downto 0);
signal crc_out    : crc_out_type;
signal crc_ok_l   : std_logic;
signal transf_cnt : unsigned(BLKSIZE_W+3 downto 0);
  --State Machine
type FSM_STATE_TYPE is (IDLE, WRITE_DAT, CHECK_CRC_STATUS, WRITE_BUSY,
                        READ_WAIT, READ_DAT,  SEND_BUSTEST,
                        READ_BUSTEST_WAIT, READ_BUSTEST, ANALYZE_BUSTEST);
signal state : FSM_STATE_TYPE;

signal crc_s_cnt  : unsigned(2 downto 0);
signal busy_int   : std_logic;
signal blkcnt_reg : unsigned(BLKCNT_W-1 downto 0);
signal start_bit  : std_logic;
signal crc_c      : unsigned(4 downto 0);
signal crc_s      : unsigned(3 downto 0);
signal data_index : unsigned(2 downto 0);
signal last_din   : unsigned(7 downto 0);

signal bustest_0  : unsigned(7 downto 0);
signal bustest_1  : unsigned(7 downto 0);
signal bustest_x  : unsigned(7 downto 0);

begin

--sd data input pad register
process(sd_clk)
begin
  if (sd_clk'event and sd_clk='1') then
    dat_reg <= sd_dat_i;
  end if;
end process;

-- There are eight different CRC generators
sd_crc_gen : for nvar in 0 to 7 generate
begin
  crc_unit : ucrc_ser
  generic map (
    POLYNOMIAL => "0001000000100001",
    INIT_VALUE => "0000000000000000"
  )
  port map (
    -- System clock and asynchronous reset
    sys_clk    => sd_clk,
    sys_rst_n  => crc_rst_n,
    sys_clk_en => crc_enable,

    -- Input and Control
    clear_i    => '0',
    data_i     => crc_in(nvar),
    flush_i    => '0',

    -- Output
    match_o    => open,
    crc_o      => crc_out(nvar)
  );
end generate;

crc_ok_o   <= crc_ok_l;
fsm_busy_o <= '1' when (state/=IDLE) else '0';
start_bit  <= '1' when (dat_reg(0)='0') else '0';
sd_dat_busy_o <= '1' when (dat_reg(0)='0') else '0';
-- Provide external bus size signals, for controlling data bus tri-states
sd_dat_siz_o <= "10" when state=SEND_BUSTEST else bus_size_i;

-- Create bus test analysis, by XORing the two returned patterns
-- together.
bustest_x <= bustest_0 xor bustest_1;

fsm_proc : process(sys_rst,sd_clk)
begin
  if (sys_rst='1') then
    state <= IDLE;
    sd_dat_oe_o <= '0';
    crc_enable <= '0';
    crc_rst_n <= '0';
    transf_cnt <= (others=>'0');
    tx_dat_rd_o <= '0';
    last_din <= (others=>'0');
    crc_c <= (others=>'0');
    crc_in <= (others=>'0');
    sd_dat_o <= (others=>'0');
    crc_s_cnt <= (others=>'0');
    crc_s <= (others=>'0');
    rx_dat_we_o <= '0';
    rx_dat_o <= (others=>'0');
    crc_ok_l <= '0';
    busy_int <= '0';
    data_index <= (others=>'0');
    blkcnt_reg <= (others=>'0');
    data_cycles <= (others=>'0');
    bus_size_reg <= (others=>'0');
    bustest_0 <= (others=>'0');
    bustest_1 <= (others=>'0');
    bustest_res_o <= (others=>'0');
  elsif (sd_clk'event and sd_clk='1') then
    case(state) is
      when IDLE =>
        sd_dat_oe_o <= '0';
        sd_dat_o <= "11111111";
        crc_enable <= '0';
        crc_rst_n <= '0';
        transf_cnt <= (others=>'0');
        crc_c <= to_unsigned(16,crc_c'length);
        crc_s_cnt <= (others=>'0');
        crc_s <= (others=>'0');
        rx_dat_we_o <= '0';
        tx_dat_rd_o <= '0';
        data_index <= (others=>'1');
        blkcnt_reg <= blkcnt_i;
        if (bus_size_i=2) then
          data_cycles <= "000" & blksize_i; -- (<<0) operation
        elsif (bus_size_i=1) then
          data_cycles <= "00" & blksize_i & '0'; -- (<<1) operation
        else
          data_cycles <= blksize_i & "000"; -- (<<3) operation
        end if;
        bus_size_reg <= bus_size_i;
        -- state transition
        if (d_read_i='0' and d_write_i='1' and bustest_w_i='0' and bustest_r_i='0') then
          state <= WRITE_DAT;
        elsif  (d_read_i='1' and d_write_i='0' and bustest_w_i='0' and bustest_r_i='0') then
          state <= READ_WAIT;
        elsif  (d_read_i='0' and d_write_i='0' and bustest_w_i='1' and bustest_r_i='0') then
          data_cycles <= to_unsigned(24,data_cycles'length);
          state <= SEND_BUSTEST;
        elsif  (d_read_i='0' and d_write_i='0' and bustest_w_i='0' and bustest_r_i='1') then
          state <= READ_BUSTEST_WAIT;
        end if;

      when SEND_BUSTEST =>
        transf_cnt <= transf_cnt+1;
        tx_dat_rd_o <= '0';
        -- Send out start bits
        if (transf_cnt = 1) then
          sd_dat_oe_o <= '1';
          sd_dat_o <= "00000000";
        end if;
        -- Send out first pattern
        if (transf_cnt = 2) then
          sd_dat_o <= "10101010";
        end if;
        -- Send out second pattern
        if (transf_cnt = 3) then
          sd_dat_o <= "01010101";
        end if;
        -- Send out zeros
        if ((transf_cnt >= 4) and (transf_cnt < data_cycles)) then
          sd_dat_o <= "00000000";
        end if;
        if (transf_cnt = data_cycles) then -- stop bits
          sd_dat_o <= "11111111";
        end if;
        if (transf_cnt = data_cycles+1) then
          sd_dat_oe_o <= '0';
        end if;
        -- state transition
        if (transf_cnt >= data_cycles+1) then
          transf_cnt <= (others=>'0');
          state <= IDLE;
        end if;

      when READ_BUSTEST_WAIT =>
        sd_dat_oe_o <= '0';
        transf_cnt <= (others=>'0');
        bustest_0 <= (others=>'0');
        bustest_1 <= (others=>'0');
        bustest_res_o <= (others=>'0');
        -- state transition
        if (start_bit='1') then
          state <= READ_BUSTEST;
        end if;

      when READ_BUSTEST =>
        transf_cnt <= transf_cnt+1;
        if (transf_cnt = 0) then
          bustest_0 <= dat_reg;
        end if;
        if (transf_cnt = 1) then
          bustest_1 <= dat_reg;
        end if;
        -- state transition
        -- No CRC status response is needed
        -- Look for stop bits
        if (dat_reg = "11111111") then
          state <= ANALYZE_BUSTEST;
        end if;

      when ANALYZE_BUSTEST =>
        if (bustest_x="00000001") then
          bustest_res_o <= "001";
        elsif (bustest_x="00001111") then
          bustest_res_o <= "010";
        elsif (bustest_x="11111111") then
          bustest_res_o <= "011";
        else
          bustest_res_o <= "100";
        end if;
        state <= IDLE;

      when WRITE_DAT =>
        crc_ok_l <= '0';
        transf_cnt <= transf_cnt+1;
        tx_dat_rd_o <= '0';
        -- Load values for last_din and crc_in
        if (bus_size_reg=2) then
          last_din <= tx_dat_i;
          crc_in <= tx_dat_i;
          if (transf_cnt<data_cycles-1) then
            tx_dat_rd_o <= '1';
          else
            tx_dat_rd_o <= '0';
          end if;
        elsif (bus_size_reg=1) then
          last_din <=
            "1111" &
            tx_dat_i(7-(4*to_integer(data_index(0 downto 0)))) & 
            tx_dat_i(6-(4*to_integer(data_index(0 downto 0)))) & 
            tx_dat_i(5-(4*to_integer(data_index(0 downto 0)))) & 
            tx_dat_i(4-(4*to_integer(data_index(0 downto 0))));
          crc_in <=
            "1111" &
            tx_dat_i(7-(4*to_integer(data_index(0 downto 0)))) &
            tx_dat_i(6-(4*to_integer(data_index(0 downto 0)))) &
            tx_dat_i(5-(4*to_integer(data_index(0 downto 0)))) &
            tx_dat_i(4-(4*to_integer(data_index(0 downto 0))));
          if (transf_cnt<data_cycles) and (data_index(0 downto 0)=0) then
            tx_dat_rd_o <= '1';
          end if;
          if (data_index(0 downto 0)=1) then
            data_index <= (others=>'0');
          else
            data_index <= data_index+1;
          end if;
        else
          last_din <= "1111111" & tx_dat_i(7-to_integer(data_index));
          crc_in <= "1111111" & tx_dat_i(7-to_integer(data_index));
          if (transf_cnt<data_cycles) and (data_index = 6) then
            tx_dat_rd_o <= '1';
          end if;
          if (data_index = 7) then
            data_index <= (others=>'0');
          else
            data_index <= data_index+1;
          end if;
        end if;
        -- Treat first transfer differently
        if (transf_cnt = 1) then
          crc_rst_n <= '1';
          crc_enable <= '1';
          if (bus_size_reg=2) then
            last_din <= tx_dat_i;
            crc_in <= tx_dat_i;
          elsif (bus_size_reg=1) then
            last_din <= "1111" & tx_dat_i(7 downto 4);
            crc_in <= "1111" & tx_dat_i(7 downto 4);
          else
            last_din <= "1111111" & tx_dat_i(7);
            crc_in <= "1111111" & tx_dat_i(7);
          end if;
          sd_dat_oe_o <= '1';
          if (bus_size_reg=2) then -- start bits
            sd_dat_o <= "00000000";
          elsif (bus_size_reg=1) then
            sd_dat_o <= "11110000";
          else
            sd_dat_o <= "11111110";
          end if;
          data_index <= to_unsigned(1,data_index'length);
        elsif ((transf_cnt >= 2) and (transf_cnt <= data_cycles+1)) then
          sd_dat_o <= last_din;
          if (transf_cnt = data_cycles+1) then
            crc_enable <= '0';
          end if;
        elsif (transf_cnt > data_cycles+1) and (crc_c/=0) then
          crc_enable <= '0';
          crc_c <= crc_c-1;
          sd_dat_o(0) <= crc_out(0)(to_integer(crc_c)-1);
          if (bus_size_reg=2) then
            sd_dat_o(7 downto 1) <= crc_out(7)(to_integer(crc_c)-1) & crc_out(6)(to_integer(crc_c)-1) &
                                    crc_out(5)(to_integer(crc_c)-1) & crc_out(4)(to_integer(crc_c)-1) &
                                    crc_out(3)(to_integer(crc_c)-1) & crc_out(2)(to_integer(crc_c)-1) &
                                    crc_out(1)(to_integer(crc_c)-1);
          elsif (bus_size_reg=1) then
            sd_dat_o(3 downto 1) <= crc_out(3)(to_integer(crc_c)-1) & crc_out(2)(to_integer(crc_c)-1) &
                                    crc_out(1)(to_integer(crc_c)-1);
            sd_dat_o(7 downto 4) <= (others=>'1');
          else
            sd_dat_o(7 downto 1) <= (others=>'1');
          end if;
        elsif (transf_cnt = data_cycles+18) then -- stop bits
          sd_dat_o <= "11111111";
        elsif (transf_cnt >= data_cycles+19) then
          sd_dat_oe_o <= '0';
        end if;
        -- state transition
        -- There are two clocks of bus turnaround time, plus one extra
        -- because of the data input register, then the start bit of
        -- the CRC status occurs.
        if (d_stop_i='1') then
          state <= IDLE;
        elsif (transf_cnt = data_cycles+23) then
          if (start_bit='1') then
            state <= CHECK_CRC_STATUS;
          else
            transf_cnt <= (others=>'0');
            blkcnt_reg <= blkcnt_reg-1;
            crc_rst_n <= '0';
            crc_c <= to_unsigned(16,crc_c'length);
            crc_s_cnt <= (others=>'0');
            if (blkcnt_reg>1) then
              state <= WRITE_DAT;
            else
              state <= IDLE;
            end if;
          end if;
        end if;

      when CHECK_CRC_STATUS =>
        if (crc_s_cnt < 4) then
          crc_s(to_integer(crc_s_cnt)) <= dat_reg(0);
        end if;
        crc_s_cnt <= crc_s_cnt+1;
        busy_int <= '1';
        -- state transition
        if (crc_s_cnt = 4) then
          if (crc_s="1010") then
            crc_ok_l <= '1';
          else
            crc_ok_l <= '0';
          end if;
          state <= WRITE_BUSY;
        end if;

      when WRITE_BUSY =>
        busy_int <= not dat_reg(0);
        transf_cnt <= (others=>'0');
        -- state transition
        if (busy_int='0') then
          blkcnt_reg <= blkcnt_reg-1;
          crc_rst_n <= '0';
          crc_c <= to_unsigned(16,crc_c'length);
          crc_s_cnt <= (others=>'0');
          if (blkcnt_reg>1 and crc_ok_l='1') then
            state <= WRITE_DAT;
          elsif (busy_int='0') then
            state <= IDLE;
          end if;
        end if;

      when READ_WAIT =>
        crc_rst_n  <= '1';
        crc_enable <= '1';
        crc_in     <= (others=>'0');
        crc_c      <= to_unsigned(15,crc_c'length);-- end
        transf_cnt <= (others=>'0');
        -- state transition
        if (start_bit='1') then
          state <= READ_DAT;
        end if;

      when READ_DAT =>
        transf_cnt <= transf_cnt+1;
        if (transf_cnt < data_cycles) then
          if (bus_size_reg=2) then
            rx_dat_we_o <= '1';
            rx_dat_o <= dat_reg;
          elsif (bus_size_reg=1) then
            if (transf_cnt(0 downto 0)=1) then
              rx_dat_we_o <= '1';
            else
              rx_dat_we_o <= '0';
            end if;
            rx_dat_o(7-(4*to_integer(transf_cnt(0 downto 0)))) <= dat_reg(3);
            rx_dat_o(6-(4*to_integer(transf_cnt(0 downto 0)))) <= dat_reg(2);
            rx_dat_o(5-(4*to_integer(transf_cnt(0 downto 0)))) <= dat_reg(1);
            rx_dat_o(4-(4*to_integer(transf_cnt(0 downto 0)))) <= dat_reg(0);
          else
            if (transf_cnt(2 downto 0)=7) then
              rx_dat_we_o <= '1';
            else
              rx_dat_we_o <= '0';
            end if;
            rx_dat_o(7-to_integer(transf_cnt(2 downto 0))) <= dat_reg(0);
          end if;
          crc_in <= dat_reg;
          crc_ok_l <= '1';
        elsif (transf_cnt <= data_cycles+16) then
          crc_enable <= '0';
          last_din <= dat_reg;
          rx_dat_we_o <= '0';
          if (transf_cnt > data_cycles) then
            crc_c <= crc_c-1;
            if  (crc_out(0)(to_integer(crc_c)) /= last_din(0)) then
              crc_ok_l <= '0';
            end if;
            if  (crc_out(1)(to_integer(crc_c)) /= last_din(1) and bus_size_reg>0) then
              crc_ok_l <= '0';
            end if;
            if  (crc_out(2)(to_integer(crc_c)) /= last_din(2) and bus_size_reg>0) then
              crc_ok_l <= '0';
            end if;
            if  (crc_out(3)(to_integer(crc_c)) /= last_din(3) and bus_size_reg>0) then
              crc_ok_l <= '0';
            end if;
            if  (crc_out(4)(to_integer(crc_c)) /= last_din(4) and bus_size_reg>1) then
              crc_ok_l <= '0';
            end if;
            if  (crc_out(5)(to_integer(crc_c)) /= last_din(5) and bus_size_reg>1) then
              crc_ok_l <= '0';
            end if;
            if  (crc_out(6)(to_integer(crc_c)) /= last_din(6) and bus_size_reg>1) then
              crc_ok_l <= '0';
            end if;
            if  (crc_out(7)(to_integer(crc_c)) /= last_din(7) and bus_size_reg>1) then
              crc_ok_l <= '0';
            end if;
            if (crc_c=0) then
              crc_rst_n <= '0';
            end if;
          end if;
        end if;
        -- state transition
        if (d_stop_i='1') then
          state <= IDLE;
        elsif (transf_cnt=(data_cycles+17) and blkcnt_reg>1 and crc_ok_l='1') then
          blkcnt_reg <= blkcnt_reg-1;
          state <= READ_WAIT;
        elsif (transf_cnt=data_cycles+17) then
          state <= IDLE;
        end if;

    when others =>
      null;

    end case;
  end if;
end process;

end beh;

----------------------------------------------------------------------
----                                                              ----
---- WISHBONE SD Card Controller IP Core                          ----
----                                                              ----
---- sd_controller_8bit.vhd                                      ----
----                                                              ----
---- This file is part of the WISHBONE SD Card                    ----
---- Controller IP Core project                                   ----
---- http:--opencores.org/project,sd_card_controller              ----
----                                                              ----
---- Description                                                  ----
---- Top level entity.                                            ----
---- This core is based on the "sd card controller" project from  ----
---- http:--opencores.org/project,sdcard_mass_storage_controller  ----
---- but has been largely rewritten. A lot of effort has been     ----
---- made to make the core more generic and easily usable         ----
---- with OSs like Linux.                                         ----
---- - data transfer commands are not fixed                       ----
---- - data transfer block size is configurable                   ----
---- - multiple block transfer support                            ----
---- - R2 responses (136 bit) support                             ----
----                                                              ----
---- Author(s):                                                   ----
----     - John Clayton, morianton@gmail.com                      ----
----                                                              ----
----------------------------------------------------------------------
----                                                              ----
---- Copyright (C) 2016 Authors                                   ----
----                                                              ----
---- Based on original work by                                    ----
----     Adam Edvardsson (adam.edvardsson@orsoc.se)               ----
----                                                              ----
----     Copyright (C) 2009 Authors                               ----
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
---- PURPOSE. See the GNU Lesser General Public License for more  ----
---- details.                                                     ----
----                                                              ----
---- You should have received a copy of the GNU Lesser General    ----
---- Public License along with this source; if not, download it   ----
---- from http:--www.opencores.org/lgpl.shtml                     ----
----                                                              ----
----------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.sd_host_pack.all;
use work.dds_pack.all;
use work.fifo_pack.all;
use work.convert_pack.all;
use work.signal_conditioning_pack.all;

entity sd_controller_8bit_bram is
  port (
    -- WISHBONE common
    wb_clk_i     : in  std_logic; -- system clock
    wb_rst_i     : in  std_logic; -- asynchronous
    -- WISHBONE slave (register interface)
    wb_dat_i     : in  unsigned(31 downto 0);
    wb_dat_o     : out unsigned(31 downto 0);
    wb_adr_i     : in  unsigned(3 downto 0);
    wb_we_i      : in  std_logic;
    wb_cyc_i     : in  std_logic;
    wb_ack_o     : out std_logic;
    -- Dedicated BRAM port without acknowledge.
    -- Access cycles must complete immediately.
    -- (data to cross clock domains by this dual-ported BRAM)
    bram_clk_o   : out std_logic; -- Same as sd_clk_o_pad
    bram_dat_o   : out unsigned(7 downto 0);
    bram_dat_i   : in  unsigned(7 downto 0);
    bram_adr_o   : out unsigned(31 downto 0);
    bram_we_o    : out std_logic;
    bram_cyc_o   : out std_logic;
    --SD Card Interface
    sd_cmd_i     : in  std_logic;
    sd_cmd_o     : out std_logic;
    sd_cmd_oe_o  : out std_logic;
    sd_dat_i     : in  unsigned(7 downto 0);
    sd_dat_o     : out unsigned(7 downto 0);
    sd_dat_oe_o  : out std_logic;
    sd_dat_siz_o : out unsigned(1 downto 0);
    sd_clk_o_pad : out std_logic;
    -- Interrupt outputs
    int_cmd_o    : out std_logic;
    int_data_o   : out std_logic
  );
end sd_controller_8bit_bram;

architecture beh of sd_controller_8bit_bram is

--SD clock
signal sd_clk_l    : std_logic; --sd_clk used in the system
signal sd_clk_en_l : std_logic; --clock enable pulse of sd_clk
signal combo_rst   : std_logic; -- combines two reset signals
signal combo_rst_n : std_logic;
signal wb_ack_r1   : std_logic;
signal wb_ack_r2   : std_logic;

signal cmd_start_pend  : std_logic;
signal cmd_start       : std_logic;
signal cmd_start_r1    : std_logic;
signal cmd_with_data   : std_logic;
signal sd_data_rd      : std_logic;

  -- Related to BRAM interface port
signal bram_cyc_l    : std_logic;
signal offset        : unsigned(31 downto 0);

  -- Related to data master
signal d_write       : std_logic;
signal d_read        : std_logic;
signal bustest_r     : std_logic;
signal bustest_w     : std_logic;
signal bustest_res   : unsigned(2 downto 0);
signal sd_dat_busy   : std_logic;
signal data_busy     : std_logic;
signal data_crc_ok   : std_logic;
signal bram_rd       : std_logic;
signal bram_we       : std_logic;

signal cmd_int_rst_pend  : std_logic;
signal cmd_int_rst       : std_logic;
signal cmd_int_rst_edge  : std_logic;
signal data_int_rst_pend : std_logic;
signal data_int_rst      : std_logic;
signal data_int_rst_edge : std_logic;

  --SD Data Master State Machine
type DM_STATE_TYPE is (IDLE, WAIT_FOR_CMD_INT, DATA_TX_START, DATA_TX,
                       DATA_RX, BUSTEST_ACTIVE, BUSTEST_W_START);
signal dm_state : DM_STATE_TYPE;

-- registers
signal argument_reg  : unsigned(31 downto 0);
signal cmd_index_reg : unsigned(5 downto 0);
signal blk_size_reg  : unsigned(BLKSIZE_W-1 downto 0);
signal blk_count_reg : unsigned(BLKCNT_W-1 downto 0);
signal resp_0_reg    : unsigned(31 downto 0);
signal resp_1_reg    : unsigned(31 downto 0);
signal resp_2_reg    : unsigned(31 downto 0);
signal resp_3_reg    : unsigned(31 downto 0);
  -- Fields of the settings register
signal bus_siz_reg   : unsigned(1 downto 0);
signal sw_rst_reg    : std_logic;
signal d_stop        : std_logic;
signal sd_freq_reg   : unsigned(31 downto 0);
signal timeout_reg   : unsigned(15 downto 0);
  -- Registers 0x9..0xC are interrupt related
signal cmd_int_status_reg   : unsigned(4 downto 0);
signal cmd_int_enable_reg   : unsigned(4 downto 0);
signal data_int_status_reg  : unsigned(2 downto 0);
signal data_int_enable_reg  : unsigned(2 downto 0);
  -- Register holding current bus address
signal dma_adr_reg   : unsigned(31 downto 0);

begin

  -- Register read mux
  with (to_integer(wb_adr_i)) select
  wb_dat_o <=
    u_resize(blk_size_reg,32)  when 0,
    u_resize(blk_count_reg,32) when 1,
    u_resize(cmd_index_reg,32) when 2,
    argument_reg               when 3,
    resp_0_reg                 when 4,
    resp_1_reg                 when 5,
    resp_2_reg                 when 6,
    resp_3_reg                 when 7,
    timeout_reg & "00000" & bustest_res & "000" & sw_rst_reg & "00" & bus_siz_reg when 8,
    sd_freq_reg                when 9,
    u_resize(cmd_int_status_reg,32)  when 10,
    u_resize(cmd_int_enable_reg,32)  when 11,
    u_resize(data_int_status_reg,32) when 12,
    u_resize(data_int_enable_reg,32) when 13,
    dma_adr_reg                when 14,
    str2u("55555555",32)       when others;

  -- Register Writing Process
reg_wr_proc : process(wb_rst_i, wb_clk_i)
begin
  if (wb_rst_i='1') then
    argument_reg <= (others=>'0');
    cmd_index_reg <= (others=>'0');
    blk_size_reg <= to_unsigned(512,blk_size_reg'length);
    blk_count_reg <= to_unsigned(1,blk_count_reg'length);
    bus_siz_reg <= "00";
    sw_rst_reg <= '0';
    sd_freq_reg <= str2u("010624DD",sd_freq_reg'length); -- Set for 400 kHz default (100 MHz sys_clk)
    timeout_reg <= to_unsigned(1000,timeout_reg'length);
    cmd_int_rst_pend <= '0';
    cmd_int_rst <= '0';
    d_stop <= '0';
    cmd_int_enable_reg <= (others=>'0');
    data_int_rst_pend <= '0';
    data_int_rst <= '0';
    data_int_enable_reg <= (others=>'0');
    wb_ack_r1 <= '0';
    wb_ack_r2 <= '0';
    cmd_start_pend <= '0';
    cmd_start <= '0';
    cmd_start_r1 <= '0';
    dma_adr_reg <= (others=>'0');
  elsif (wb_clk_i'event and wb_clk_i='1') then
    -- default values, clocked on sd_clk_en_l
    if (sd_clk_en_l='1') then
      cmd_start    <= '0';
      data_int_rst <= '0';
      cmd_int_rst  <= '0';
      d_stop       <= '0';
    end if;
    -- signals raised on sd_clk_en_l
    -- higher priority than the default
    if (sd_clk_en_l='1') then
      if (cmd_start_pend='1') then
        cmd_start <= '1';
        cmd_start_pend <= '0';
      end if;
      if (data_int_rst_pend='1') then
        data_int_rst <= '1';
        data_int_rst_pend <= '0';
      end if;
      if (cmd_int_rst_pend='1') then
        cmd_int_rst <= '1';
        cmd_int_rst_pend <= '0';
      end if;
    end if;
    -- delayed version
    cmd_start_r1 <= cmd_start;
      

    if (wb_ack_r1='1' and wb_ack_r2='0') then
      if (wb_we_i='1') then
        case (to_integer(wb_adr_i)) is
          when 0 =>
            blk_size_reg <= wb_dat_i(BLKSIZE_W-1 downto 0);

          when 1 =>
            blk_count_reg <= wb_dat_i(BLKCNT_W-1 downto 0);

          when 2 =>
            cmd_index_reg <= wb_dat_i(5 downto 0);

          when 3 =>
            argument_reg <= wb_dat_i;
            cmd_start_pend <= '1';

          when 8 =>
            bus_siz_reg <= wb_dat_i(1 downto 0);
            sw_rst_reg  <= wb_dat_i(4);
            d_stop      <= wb_dat_i(5); -- write only bit
            timeout_reg <= wb_dat_i(31 downto 16);

          when 9 =>
            sd_freq_reg <= wb_dat_i;

          when 10 =>
            cmd_int_rst_pend <= '1';

          when 11 =>
            cmd_int_enable_reg <= wb_dat_i(cmd_int_enable_reg'length-1 downto 0);

          when 12 =>
            data_int_rst_pend <= '1';

          when 13 =>
            data_int_enable_reg <= wb_dat_i(data_int_enable_reg'length-1 downto 0);

          when 14 =>
            dma_adr_reg <= wb_dat_i;

          when others =>
            null;
        end case;
      end if;
    end if;
    -- Detect rising edge of wb_cyc_i
    wb_ack_r1 <= wb_cyc_i;
    wb_ack_r2 <= wb_ack_r1;
  end if;
end process;

  -- Provide Wishbone bus cycle acknowledge
  wb_ack_o <= wb_ack_r1;

  -- Form a combined reset signal
  combo_rst   <= wb_rst_i or sw_rst_reg;
  combo_rst_n <= not combo_rst;

-- SD Card clock generation
-- A DDS is used.
sd_clk_dds : dds_squarewave
  generic map(
    ACC_BITS => sd_freq_reg'length -- Bit width of DDS phase accumulator
  )
  port map( 

    sys_rst_n    => combo_rst_n,
    sys_clk      => wb_clk_i,
    sys_clk_en   => '1',

    -- Frequency setting
    freq_i       => sd_freq_reg,

    -- Output
    pulse_o      => sd_clk_en_l,
    squarewave_o => sd_clk_l
  );
sd_clk_o_pad <= sd_clk_l;


cmd_host_0 : sd_cmd_host
  port map(
    sd_clk       => sd_clk_l,
    sys_rst      => combo_rst,
    -- Control and settings
    start_i      => cmd_start_r1,
    int_rst_i    => cmd_int_rst_edge,
    busy_i       => sd_dat_busy,
    cmd_index_i  => cmd_index_reg,
    argument_i   => argument_reg,
    timeout_i    => timeout_reg,
    int_status_o => cmd_int_status_reg,
    response_0_o => resp_0_reg,
    response_1_o => resp_1_reg,
    response_2_o => resp_2_reg,
    response_3_o => resp_3_reg,
    -- SD/MMC card command signals
    sd_cmd_i     => sd_cmd_i,
    sd_cmd_o     => sd_cmd_o,
    sd_cmd_oe_o  => sd_cmd_oe_o
  );

cmd_with_data <= '1' when cmd_index_reg=20 or cmd_index_reg=24 or cmd_index_reg=25 or
                          cmd_index_reg=8  or cmd_index_reg=11 or cmd_index_reg=17 or
                          cmd_index_reg=18 or cmd_index_reg=14 or cmd_index_reg=19 else '0';
sd_data_rd    <= '1' when cmd_index_reg=8  or cmd_index_reg=11 or 
                          cmd_index_reg=17 or cmd_index_reg=18 else '0';

  -- SD Data Master Finite State Machine
d_read <= '1' when dm_state=IDLE and cmd_start_r1='1' and cmd_with_data='1' and sd_data_rd='1' else '0';
d_write <= '1' when dm_state=DATA_TX_START else '0';
bustest_r <= '1' when dm_state=IDLE and cmd_start_r1='1' and cmd_index_reg=14 else '0';
bustest_w <= '1' when dm_state=BUSTEST_W_START else '0';

dm_fsm_proc : process(combo_rst, sd_clk_l)
begin
  if (combo_rst='1') then
    offset <= (others=>'0');
    data_int_status_reg <= (others=>'0');
    dm_state <= IDLE;
  elsif (sd_clk_l'event and sd_clk_l='1') then
    case (dm_state) is
      when IDLE =>
        offset <= (others=>'0');
        -- state transition
        if (cmd_start_r1='1') then
          if (cmd_with_data='1') then
            if (cmd_index_reg=14) then -- BUSTEST_R
              dm_state <= BUSTEST_ACTIVE;
            elsif (sd_data_rd='1') then -- Reading
              dm_state <= DATA_RX;
            else
              dm_state <= WAIT_FOR_CMD_INT;
            end if;
          end if;
        end if;

      when BUSTEST_ACTIVE =>
        if (data_busy='0') then --Transfer complete
          dm_state <= IDLE;
        end if;

      when BUSTEST_W_START =>
        dm_state <= BUSTEST_ACTIVE;

      when WAIT_FOR_CMD_INT =>
        if (cmd_int_status_reg(INT_CMD_CC)='1') then
          if (cmd_index_reg=19) then
            dm_state <= BUSTEST_W_START;
          else
            dm_state <= DATA_TX_START;
          end if;
        elsif (cmd_int_status_reg(INT_CMD_EI)='1') then
          dm_state <= IDLE;
        end if;

      when DATA_TX_START =>
        dm_state <= DATA_TX;

      when DATA_TX =>
        if (bram_cyc_l='1') then
          offset <= offset+1;
        end if;
        if (data_busy='0') then --Transfer complete
          if (data_crc_ok='0') then --Wrong CRC
            data_int_status_reg(INT_DATA_CCRCE) <= '1';
          else
            data_int_status_reg(INT_DATA_CC) <= '1';
          end if;
          dm_state <= IDLE;
        end if;

      when DATA_RX =>
        if (bram_cyc_l='1') then
          offset <= offset+1;
        end if;
        if (data_busy='0') then --Transfer complete
          if (data_crc_ok='0') then --Wrong CRC
            data_int_status_reg(INT_DATA_CCRCE) <= '1';
          else
            data_int_status_reg(INT_DATA_CC) <= '1';
          end if;
          dm_state <= IDLE;
        end if;

      when others =>
        null;

    end case;

    if (data_int_rst_edge='1') then
      data_int_status_reg <= (others=>'0');
    end if;
  end if;
end process;


sd_data_host0 : sd_data_8bit_host
  port map(
    sd_clk         => sd_clk_l,
    sys_rst        => combo_rst,
    --Tx Fifo
    tx_dat_i       => bram_dat_i,
    tx_dat_rd_o    => bram_rd,
    --Rx Fifo
    rx_dat_o       => bram_dat_o,
    rx_dat_we_o    => bram_we,
    --tristate data
    sd_dat_siz_o   => sd_dat_siz_o,
    sd_dat_oe_o    => sd_dat_oe_o,
    sd_dat_o       => sd_dat_o,
    sd_dat_i       => sd_dat_i,
    --Control signals
    blksize_i      => blk_size_reg,
    bus_size_i     => bus_siz_reg,
    blkcnt_i       => blk_count_reg,
    d_stop_i       => d_stop,
    d_read_i       => d_read,
    d_write_i      => d_write,
    bustest_w_i    => bustest_w,
    bustest_r_i    => bustest_r,
    bustest_res_o  => bustest_res,
    sd_dat_busy_o  => sd_dat_busy,
    fsm_busy_o     => data_busy,
    crc_ok_o       => data_crc_ok
  );

bram_clk_o <= not sd_clk_l;
bram_we_o  <= bram_we;
bram_cyc_l <= bram_rd or bram_we;
bram_cyc_o <= bram_cyc_l;
bram_adr_o <= dma_adr_reg+offset;

cmd_int_rst_edge_detect : edge_detector
  generic map(
    DETECT_RISING  => 1,
    DETECT_FALLING => 0
  )
  port map(
    -- System Clock and Clock Enable
    sys_rst_n   => combo_rst_n,
    sys_clk     => sd_clk_l,
    sys_clk_en  => '1',

    -- Input Signal
    sig_i       => cmd_int_rst,

    -- Output pulse
    pulse_o     => cmd_int_rst_edge
  );

data_int_rst_edge_detect : edge_detector
  generic map(
    DETECT_RISING  => 1,
    DETECT_FALLING => 0
  )
  port map(
    -- System Clock and Clock Enable
    sys_rst_n   => combo_rst_n,
    sys_clk     => sd_clk_l,
    sys_clk_en  => '1',

    -- Input Signal
    sig_i       => data_int_rst,

    -- Output pulse
    pulse_o     => data_int_rst_edge
  );

-- provide outputs
int_cmd_o  <= '1' when (cmd_int_status_reg or cmd_int_enable_reg)/=0 else '0';
int_data_o <= '1' when (data_int_status_reg or data_int_enable_reg)/=0 else '0';

end beh;

