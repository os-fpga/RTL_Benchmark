-- 
-- Copyright (C) 2006 Johannes Hausensteiner (johannes.hausensteiner@pcl.at)
-- 
-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--
-- 
-- Filename: spi_ctrl.vhd
--
-- Function: SPI Flash controller for DIY Calculator
-- 
--
-- Changelog
--
--  0.1  25.Sep.2006   JH   new
--


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity spi_ctrl is
  port (
    clk      : in std_logic;
    rst      : in std_logic;
    spi_clk  : out std_logic;
    spi_cs   : out std_logic;
    spi_din  : in std_logic;
    spi_dout : out std_logic;
    sel      : in std_logic;
    nWR      : in std_logic;
    addr     : in std_logic_vector (1 downto 0);
    d_in     : in std_logic_vector (7 downto 0);
    d_out    : out std_logic_vector (7 downto 0)
  );
end spi_ctrl;

architecture rtl of spi_ctrl is
  type state_t is (
    IDLE, TxCMD, TxADD_H, TxADD_M, TxADD_L, TxDUMMY, TxDATA, RxDATA,
    WAIT1, WAIT2, WAIT3, WAIT4, WAIT6, WAIT5, WAIT7, WAIT8, CLR_CMD);
  signal state, next_state : state_t;

  -- transmitter
  signal tx_reg, tx_sreg : std_logic_vector (7 downto 0);
  signal tx_empty, tx_empty_set : std_logic;
  signal tx_bit_cnt : std_logic_vector (3 downto 0);

  -- receiver
  signal rx_sreg : std_logic_vector (7 downto 0);
  signal rx_ready, rx_ready_set : std_logic;
  signal rx_bit_cnt : std_logic_vector (3 downto 0);

  signal wr_cmd, wr_data, wr_add_m, wr_add_l : std_logic;
  signal rd_stat, rd_add_m, rd_add_l : std_logic;
  signal rd_data, rd_data1, rd_data2 : std_logic;
  signal spi_cs_int : std_logic;

  -- auxiliary signals
  signal rx_enable, rx_empty, rx_empty_clr : std_logic;
  signal tx_enable, tx_enable_d : std_logic;
  signal tx_new_data, tx_new_data_clr, is_tx_data, is_wait6 : std_logic;
  signal cmd_clr, busy : std_logic;

  -- registers
  signal cmd, tx_data, rx_data, add_m, add_l : std_logic_vector (7 downto 0);
  
  -- FLASH commands
  constant NOP  : std_logic_vector (7 downto 0) := x"FF";  -- no cmd to execute
  constant WREN : std_logic_vector (7 downto 0) := x"06";  -- write enable
  constant WRDI : std_logic_vector (7 downto 0) := x"04";  -- write disable
  constant RDSR : std_logic_vector (7 downto 0) := x"05";  -- read status reg
  constant WRSR : std_logic_vector (7 downto 0) := x"01";  -- write stat. reg
  constant RD :   std_logic_vector (7 downto 0) := x"03";  -- read data
  constant F_RD : std_logic_vector (7 downto 0) := x"0B";  -- fast read data
  constant PP :   std_logic_vector (7 downto 0) := x"02";  -- page program
  constant SE :   std_logic_vector (7 downto 0) := x"D8";  -- sector erase
  constant BE :   std_logic_vector (7 downto 0) := x"C7";  -- bulk erase
  constant DP :   std_logic_vector (7 downto 0) := x"B9";  -- deep power down
  constant RES :  std_logic_vector (7 downto 0) := x"AB";  -- read signature
begin
  -- assign signals
  spi_cs <= spi_cs_int;
  spi_clk <= not ((tx_enable or rx_enable) and spi_cs_int)
             or rx_ready or rx_ready_set or clk;
  spi_dout <= tx_sreg(7);

  -- address decoder
  process (sel, addr, nWR)
    variable input : std_logic_vector (3 downto 0);
  begin
    input := sel & addr & nWR;
    -- defaults
    wr_data <= '0';
    wr_cmd <= '0';
    wr_add_m <= '0';
    wr_add_l <= '0';
    rd_data <= '0';
    rd_stat <= '0';
    rd_add_m <= '0';
    rd_add_l <= '0';
    case input is
      when "1000" => wr_data  <= '1';
      when "1001" => rd_data  <= '1';
      when "1010" => wr_cmd   <= '1';
      when "1011" => rd_stat  <= '1';
      when "1100" => wr_add_m <= '1';
      when "1101" => rd_add_m <= '1';
      when "1110" => wr_add_l <= '1';
      when "1111" => rd_add_l <= '1';
      when others => null;
    end case;
  end process;

  -- read back registers
  d_out(0) <=    (rx_data(0) and rd_data)
              or (busy       and rd_stat)
              or (add_m(0)   and rd_add_m)
              or (add_l(0)   and rd_add_l);

  d_out(1) <=    (rx_data(1) and rd_data)
              or (tx_empty   and rd_stat)
              or (add_m(1)   and rd_add_m)
              or (add_l(1)   and rd_add_l);

  d_out(2) <=    (rx_data(2) and rd_data)
              or (rx_ready   and rd_stat)
              or (add_m(2)   and rd_add_m)
              or (add_l(2)   and rd_add_l);

  d_out(3) <=    (rx_data(3) and rd_data)
              or (is_wait6   and rd_stat)
              or (add_m(3)   and rd_add_m)
              or (add_l(3)   and rd_add_l);

  d_out(4) <=    (rx_data(4) and rd_data)
              or ('0'        and rd_stat)
              or (add_m(4)   and rd_add_m)
              or (add_l(4)   and rd_add_l);

  d_out(5) <=    (rx_data(5) and rd_data)
              or ('0'        and rd_stat)
              or (add_m(5)   and rd_add_m)
              or (add_l(5)   and rd_add_l);

  d_out(6) <=    (rx_data(6) and rd_data)
              or ('0'        and rd_stat)
              or (add_m(6)   and rd_add_m)
              or (add_l(6)   and rd_add_l);

  d_out(7) <=    (rx_data(7) and rd_data)
              or ('0'        and rd_stat)
              or (add_m(7)   and rd_add_m)
              or (add_l(7)   and rd_add_l);

  -- write command register
  process (rst, cmd_clr, wr_cmd)
  begin
    if rst = '1' or cmd_clr = '1' then
      cmd <= NOP;
    elsif falling_edge (wr_cmd) then
      cmd <= d_in;
    end if;
  end process;

  -- write address mid register
  process (rst, wr_add_m)
  begin
    if rst = '1' then
      add_m <= x"00";
    elsif falling_edge (wr_add_m) then
      add_m <= d_in;
    end if;
  end process;

  -- write address low register
  process (rst, wr_add_l)
  begin
    if rst = '1' then
      add_l <= x"00";
    elsif falling_edge (wr_add_l) then
      add_l <= d_in;
    end if;
  end process;

  -- write tx data register
  process (rst, wr_data)
  begin
    if rst = '1' then
      tx_data <= x"00";
    elsif falling_edge (wr_data) then
      tx_data <= d_in;
    end if;
  end process;

  -- new tx data flag
  tx_new_data_clr <= tx_empty_set and is_tx_data;
  process (rst, tx_new_data_clr, wr_data)
  begin
    if rst = '1' or tx_new_data_clr = '1' then
      tx_new_data <= '0';
    elsif falling_edge (wr_data) then
      tx_new_data <= '1';
    end if;
  end process;

  -- advance the state machine
  process (rst, clk)
  begin
    if rst = '1' then
      state <= IDLE;
    elsif rising_edge (clk) then
      state <= next_state;
    end if;
  end process;

  -- state machine transition table
  process (state, cmd, tx_bit_cnt, tx_new_data, rx_bit_cnt, rx_empty)
  begin
    case state is
      when IDLE =>
        case cmd is
          when NOP => next_state <= IDLE;
          when others => next_state <= TxCMD;
        end case;

      when TxCMD =>
        if tx_bit_cnt < x"7" then
          next_state <= TxCMD;
        else
          next_state <= WAIT1;
        end if;

      when WAIT1 =>
        case cmd is
          when WREN | WRDI | BE | DP => next_state <= CLR_CMD;
          when SE | PP | RES | RD | F_RD => next_state <= TxADD_H;
          when WRSR => next_state <= TxDATA;
          when RDSR => next_state <= RxDATA;
          when others => next_state <= CLR_CMD;
        end case;

      when TxADD_H =>
        if tx_bit_cnt < x"7" then
          next_state <= TxADD_H;
        else
          next_state <= WAIT2;
        end if;

      when WAIT2 => next_state <= TxADD_M;

      when TxADD_M =>
        if tx_bit_cnt < x"7" then
          next_state <= TxADD_M;
        else
          next_state <= WAIT3;
        end if;

      when WAIT3 => next_state <= TxADD_L;

      when TxADD_L =>
        if tx_bit_cnt < x"7" then
          next_state <= TxADD_L;
        else
          case cmd is
            when PP => next_state <= WAIT6;
            when SE | RES | RD | F_RD => next_state <= WAIT4;
            when others => next_state <= CLR_CMD;
          end case;
        end if;

      when WAIT4 =>
        case cmd is
          when F_RD => next_state <= TxDUMMY;
          when RES | RD => next_state <= RxDATA;
          when others => next_state <= CLR_CMD;
        end case;

      when TxDUMMY =>
        if tx_bit_cnt < x"7" then
          next_state <= TxDUMMY;
        else
          next_state <= WAIT8;
        end if;

      when WAIT7 => next_state <= WAIT8;

      when WAIT8 =>
        case cmd is
          when RD | F_RD =>
            if rx_empty = '1' then
              next_state <= RxDATA;
            else
              next_state <= WAIT8;
            end if;
          when others => next_state <= CLR_CMD;
        end case;

      when RxDATA =>
        if rx_bit_cnt < x"7" then
          next_state <= RxDATA;
        else
          case cmd is
            when RD | F_RD => next_state <= WAIT7;
            when RDSR | RES => next_state <= WAIT5;
            when others => next_state <= CLR_CMD;
          end case;
        end if;

      when TxDATA =>
        if tx_bit_cnt < x"7" then
          next_state <= TxDATA;
        else
          case cmd is
            when PP => next_state <= WAIT6;
            when others => next_state <= CLR_CMD;
          end case;
        end if;

      when WAIT6 =>
        case cmd is
          when PP =>
            if tx_new_data = '1' then
              next_state <= TxDATA;
            else
              next_state <= WAIT6;
            end if;
          when others => next_state <= CLR_CMD;
        end case;

      when WAIT5 => next_state <= CLR_CMD;

      when CLR_CMD => next_state <= IDLE;
    end case;
  end process;

  -- state machine output table
  process (state)
  begin
    -- default values
    tx_enable <= '0';
    rx_enable <= '0';
    tx_reg <= x"FF";
    spi_cs_int <= '0';
    busy <= '1';
    cmd_clr <= '0';
    is_tx_data <= '0';
    is_wait6 <= '0';

    case state is
      when IDLE =>
        busy <= '0';
      when TxCMD =>
        tx_reg <= cmd;
        tx_enable <= '1';
        spi_cs_int <= '1';
      when TxDATA =>
        tx_reg <= tx_data;
        tx_enable <= '1';
        spi_cs_int <= '1';
        is_tx_data <= '1';
      when TxADD_H =>
        tx_reg <= x"0F";
        tx_enable <= '1';
        spi_cs_int <= '1';
      when TxADD_M =>
        tx_reg <= add_m;
        tx_enable <= '1';
        spi_cs_int <= '1';
      when TxADD_L =>
        tx_reg <= add_l;
        tx_enable <= '1';
        spi_cs_int <= '1';
      when TxDUMMY =>
        tx_reg <= x"00";
        tx_enable <= '1';
        spi_cs_int <= '1';
      when RxDATA =>
        rx_enable <= '1';
        spi_cs_int <= '1';
      when WAIT1 | WAIT2 | WAIT3 | WAIT4 | WAIT8 =>
        spi_cs_int <= '1';
      when WAIT6 =>
        is_wait6 <= '1';
        spi_cs_int <= '1';
      when WAIT5 | WAIT7 =>
        rx_enable <= '1';
        spi_cs_int <= '1';
      when CLR_CMD =>
        cmd_clr <= '1';
      when others => null;
    end case;
  end process;

  -- the tx_empty flip flop
  process (rst, tx_empty_set, wr_data)
  begin
    if rst = '1' then
      tx_empty <= '1';
    elsif wr_data = '1' then
      tx_empty <= '0';
    elsif rising_edge (tx_empty_set) then
      tx_empty <= '1';
    end if;
  end process;

  -- delay the tx_enable signal
  process (rst, clk)
  begin
    if rst = '1' then
      tx_enable_d <= '0';
    elsif falling_edge (clk) then
      tx_enable_d <= tx_enable;
    end if;
  end process;

  -- transmitter shift register and bit counter
  process (rst, tx_enable_d, clk)
  begin
    if rst = '1' or tx_enable_d = '0' then
      tx_sreg <= tx_reg;
      tx_bit_cnt <= x"0";
      tx_empty_set <= '0';
    elsif falling_edge (clk) then
      tx_bit_cnt <= tx_bit_cnt + 1;

      tx_sreg(7) <= tx_sreg(6);
      tx_sreg(6) <= tx_sreg(5);
      tx_sreg(5) <= tx_sreg(4);
      tx_sreg(4) <= tx_sreg(3);
      tx_sreg(3) <= tx_sreg(2);
      tx_sreg(2) <= tx_sreg(1);
      tx_sreg(1) <= tx_sreg(0);
      tx_sreg(0) <= '1';

      if tx_bit_cnt = x"6" and is_tx_data = '1' then
        tx_empty_set <= '1';
      else
        tx_empty_set <= '0';
      end if;
    end if;
  end process;

  -- capture rd_data
  process (rst, rd_data, rd_data2)
  begin
    if rst = '1' or rd_data2 = '1' then
      rd_data1 <= '0';
    elsif rising_edge (rd_data) then
      rd_data1 <= '1';
    end if;
  end process;

  process (rst, clk)
  begin
    if rst = '1' then
      rd_data2 <= '0';
    elsif rising_edge (clk) then
      rd_data2 <= rd_data1;
    end if;
  end process;

  -- the rx_empty flip flop
  process (rst, clk)
  begin
    if rst = '1' then
      rx_empty <= '1';
    elsif falling_edge (clk) then
      if rx_empty_clr = '1' then
        rx_empty <= '0';
      elsif rd_data2 = '1' then
        rx_empty <= '1';
      end if;
    end if;
  end process;

  -- the rx_ready flip flop
  process (rst, clk)
  begin
    if rst = '1' then
      rx_ready <= '0';
    elsif falling_edge (clk) then
      if rd_data2 = '1' then
        rx_ready <= '0';
      elsif rx_ready_set = '1' then
        rx_ready <= '1';
      end if;
    end if;
  end process;

  -- the rx_data register
  process (rst, clk)
  begin
    if rst = '1' then
      rx_data <= x"FF";
    elsif falling_edge (clk) then
      if rx_ready_set = '1' then
        rx_data <= rx_sreg;
      end if;
    end if;
  end process;

  -- receiver shift register and bit counter
  process (rst, rx_enable, clk)
  begin
    if rst = '1' or rx_enable = '0' then
      rx_bit_cnt <= x"0";
      rx_ready_set <= '0';
      rx_empty_clr <= '0';
      rx_sreg <= x"FF";
    elsif rising_edge (clk) then
      rx_bit_cnt <= rx_bit_cnt + 1;

      rx_sreg(7) <= rx_sreg(6);
      rx_sreg(6) <= rx_sreg(5);
      rx_sreg(5) <= rx_sreg(4);
      rx_sreg(4) <= rx_sreg(3);
      rx_sreg(3) <= rx_sreg(2);
      rx_sreg(2) <= rx_sreg(1);
      rx_sreg(1) <= rx_sreg(0);
      rx_sreg(0) <= spi_din;

      if rx_bit_cnt = x"1" then
        rx_empty_clr <= '1';
      else
        rx_empty_clr <= '0';
      end if;

      if rx_bit_cnt = x"7" then
        rx_ready_set <= '1';
      else
        rx_ready_set <= '0';
      end if;
    end if;
  end process;
end rtl;
