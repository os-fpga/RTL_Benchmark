---------------------------------------------------------------------
--	Filename:	txcore.vhd
--
--			
--	Description:
--		txcore: UART transmitter 
--              
--	Copyright (c) 2009 by Renato Andreola (Imagos sas)
--
--	This file is part of YANU.
--	YANU is free software: you can redistribute it and/or modify
--	it under the terms of the GNU Lesser General Public License as published by
--	the Free Software Foundation, either version 3 of the License, or
--	(at your option) any later version.
--	YANU is distributed in the hope that it will be useful,
--	but WITHOUT ANY WARRANTY; without even the implied warranty of
--	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--	GNU Lesser General Public License for more details.
--
--	You should have received a copy of the GNU Lesser General Public License
--	along with YANU.  If not, see <http://www.gnu.org/licenses/>.
--	
--	Revision	History:
--	Revision	Date      	Author   	Comment
--	--------	----------	---------	-----------
--	1.0     	30/05/2009	Renato Andreola	Initial revision
--	
--------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library altera_mf;
--use altera_mf.altera_mf_components.all;

-- asynchronous TX core entity
entity txcore is
  generic (
    USE_EAB : string := "OFF"                            -- can be "ON" or "OFF"
    );
  port
    (
      clk, reset    : in  std_logic;                     -- clk and ynchronous reset
      tick          : in  std_logic;                     -- active high for clk period every 1/8 bit time
      bits          : in  std_logic_vector(2 downto 0);  -- number of bits: n means n+1 bits will be transmitted
      stops         : in  std_logic;                     -- 0 -> 1 stop bit, 1 -> 2 stop bits
      parity_enable : in  std_logic;                     -- 1 -> enable parity bit transmission
      parity_even   : in  std_logic;                     -- 1 -> transmit an even number of 1's (including parity bit)
      data          : in  std_logic_vector(7 downto 0);  -- bits to be transmitted...
      data_push     : in  std_logic;                     -- 1 clk pulse trigger to be activate with valid data
      fifo_thr      : in  std_logic_vector(3 downto 0);  -- fifo threshold: interrupt if fifo_words <= fifo_thr
      tx            : out std_logic;                     -- transmit data output
      irq           : out std_logic;                     -- interrupt request
      iflag         : out std_logic;                     -- transmitter can receive a data
      fifo_words    : out std_logic_vector(4 downto 0);  -- number of words into tx fifo
      fifo_clr      : in  std_logic;                     -- fifo (sync) clear pulse
      if_set        : in  std_logic;                     -- a pulse sets if by software
      if_clear      : in  std_logic;                     -- clear if
      ie            : in  std_logic;                     -- Interrupt Enable flag
      forcebrk      : in  std_logic;                     -- force tx = 0
      hhena         : in  std_logic;                     -- Hardware Handshake enable
      rts           : in  std_logic                      -- tx is enabled if rts = '1' or if hhena = '0'
      );
end txcore;

architecture arch_txcore of txcore is

  ----------------------------------------------------------------------------------------------------------------------
  -- REGISTERS (and their "_in" input nodes)

  -- bit time counter: 8 ticks builds up a bit time
  signal ntick, ntick_in       : std_logic_vector(2 downto 0) := (others => '0');
  signal nticktop, nticktop_in : std_logic                    := '0';

  -- bit counter: the index of the bit that is currently beeing sent 
  signal nbit, nbit_in : std_logic_vector(2 downto 0) := (others => '0');

  -- tx (shift) register
  signal txreg, txreg_in : std_logic_vector(7 downto 0) := (others => '0');

  -- output glitch free txdata holder
  signal txff, txff_in : std_logic := '1';

  -- parity bit!
  signal parity, parity_in : std_logic := '0';

  -- done output
  signal done_tmp, done_tmp_in : std_logic := '0';

  -- harware "tx stop" pipeline
  signal hw_txena, hw_txena_in : std_logic_vector(2 downto 0) := (others => '0');

  ----------------------------------------------------------------------------------------------------------------------
  -- Transmitter state machine controller: the system can be idle or transmitting a portion of the data packet
  type state_type is (Q_idle, Q_start, Q_bits, Q_parity, Q_stop);

  signal next_state, current_state : state_type := Q_idle;

  ----------------------------------------------------------------------------------------------------------------------
  -- interrupt handling: an interrupt is generated when the number of words into the fifo is lower than the predefined
  -- threshold
  signal ifbit, ifbit_in : std_logic := '0';  -- interrupt flag

  signal local_fifo_words : std_logic_vector(4 downto 0) := (others => '0');

  signal fifo_usedw : std_logic_vector(3 downto 0) := (others => '0');
  signal fifo_rdreq : std_logic                    := '0';
  signal fifo_empty : std_logic                    := '0';
  signal fifo_q     : std_logic_vector(7 downto 0) := (others => '0');
  signal fifo_full  : std_logic                    := '0';

  ----------------------------------------------------------------------------------------------------------------------
  -- used components

  component scfifo
    generic (
      lpm_numwords           : natural;
      intended_device_family : string;
      lpm_showahead          : string;
      lpm_type               : string;
      lpm_width              : natural;
      lpm_widthu             : natural;
      overflow_checking      : string;
      underflow_checking     : string;
      use_eab                : string
      );
    port (
      usedw : out std_logic_vector (3 downto 0);
      rdreq : in  std_logic;
      sclr  : in  std_logic;
      empty : out std_logic;
      clock : in  std_logic;
      q     : out std_logic_vector (7 downto 0);
      wrreq : in  std_logic;
      data  : in  std_logic_vector (7 downto 0);
      full  : out std_logic
      );
  end component;

begin
  -- transmit fifo..
  txfifo : scfifo
    generic map (
      intended_device_family => "CYCLONE II",
      lpm_numwords           => 16,
      lpm_showahead          => "OFF",
      lpm_type               => "scfifo",
      lpm_width              => 8,
      lpm_widthu             => 4,
      overflow_checking      => "ON",
      underflow_checking     => "ON",
      use_eab                => USE_EAB
      )
    port map (
      sclr  => fifo_clr,
      rdreq => fifo_rdreq,
      clock => clk,
      wrreq => data_push,
      data  => data,
      usedw => fifo_usedw,
      empty => fifo_empty,
      q     => fifo_q,
      full  => fifo_full
      );

  -- interrupt handling sequential process: update timers an flag status
  if_sp : process (clk) is
  begin  -- process if_sp
    if rising_edge(clk) then
      ifbit <= ifbit_in;
    end if;
  end process if_sp;

  -- interrupt handling logic 
  if_cp : process (fifo_full, fifo_thr, fifo_usedw, ie, if_clear, if_set, ifbit, local_fifo_words) is
  begin  -- process if_cp
    -- default: flags holds their value.
    ifbit_in         <= ifbit;
    local_fifo_words <= (fifo_full & fifo_usedw);  -- 0 to 16! (see fifo specs)
    if if_clear = '1' then
      ifbit_in <= '0';                             -- clear: HIGH priority
    else
      if (if_set = '1') or (unsigned(local_fifo_words) <= unsigned('0' & fifo_thr)) then
        ifbit_in <= '1';
      end if;
    end if;
    -- output
    iflag      <= ifbit;
    irq        <= ie and ifbit;
    fifo_words <= local_fifo_words;
  end process if_cp;

  -- txcore sequential process:  registers update
  txcore_sp : process (clk) is
  begin
    if rising_edge(clk) then
      txreg         <= txreg_in;
      ntick         <= ntick_in;
      nticktop      <= nticktop_in;
      nbit          <= nbit_in;
      txff          <= txff_in;
      parity        <= parity_in;
      done_tmp      <= done_tmp_in;
      current_state <= next_state;
      hw_txena      <= hw_txena_in;
    end if;
  end process txcore_sp;

  -- txcore combinatorial process: handles reset, main state machine update,...
  txcore_cp : process (bits, current_state, fifo_empty, fifo_q, forcebrk, hhena, hw_txena, nbit, ntick, nticktop,
                       parity, parity_enable, parity_even, reset, rts, stops, tick, txff, txreg)
    is
    variable i : integer;
  begin
    -- harware tx enable logic and its pipeline
    hw_txena_in(2)          <= rts or (not hhena);
    hw_txena_in(1 downto 0) <= hw_txena(2 downto 1);

    -- default: hold previous values if tick is false
    ntick_in    <= ntick;
    nbit_in     <= nbit;
    txreg_in    <= txreg;
    txff_in     <= txff;
    parity_in   <= parity;
    done_tmp_in <= '0';
    next_state  <= current_state;
    nticktop_in <= nticktop;
    fifo_rdreq  <= '0';

    if reset = '1' then
      txff_in    <= '1';
      next_state <= Q_idle;
    else
      -- do something only if tick is asserted
      if tick = '1' then
        -- advance tick (rolling!) counter
        ntick_in <= std_logic_vector(unsigned(ntick) +1);
        if ntick = std_logic_vector(to_unsigned(7, ntick'length)) then
          nticktop_in <= '1';
        else
          nticktop_in <= '0';
        end if;
        case current_state is
          when Q_idle =>
            -- data_ready: if it is asserted and there are no hardware handshake stops then all begins...
            if (fifo_empty = '0') and (hw_txena(0) = '1') then
              next_state  <= Q_start;
              fifo_rdreq  <= '1';               -- pull a data from fifo
              -- reset timer
              ntick_in    <= (others => '0');
              nticktop_in <= '0';               -- reset pipelined flag...
            end if;
          when Q_start =>                       -- transmit start bit
            txff_in <= '0';
            nbit_in <= (others => '0');
            if nticktop = '1' then
              next_state <= Q_bits;
              parity_in  <= '0';
              txreg_in   <= fifo_q;             -- load transmit register!
            end if;
          when Q_bits =>                        -- shift out "bits" bit
            txff_in <= txreg(0);
            if nticktop = '1' then
              -- update parity bit
              parity_in <= parity xor txreg(0);
              -- shift out a bit and update bit counter
              txreg_in  <= ('1' & txreg(7 downto 1));
              nbit_in   <= std_logic_vector(unsigned(nbit) +1);
              if nbit = bits then
                nbit_in <= (others => '0');
                if parity_enable = '1' then
                  next_state <= Q_parity;       -- a parity bit has to be sent
                else
                  next_state <= Q_stop;
                end if;
              end if;
            end if;
          when Q_parity =>                      -- transmit the parity
            txff_in <= parity xor parity_even;  -- correct polariy...
            nbit_in <= (others => '0');
            if nticktop = '1' then
              next_state <= Q_stop;
            end if;
          when Q_stop =>                        -- send some (1 or 2) stop bits 
            txff_in <= '1';
            if nticktop = '1' then
              nbit_in <= std_logic_vector(unsigned(nbit) +1);
              if nbit(0) = stops then
                -- signal the end of transmission with a "done" pulse
                done_tmp_in <= '1';
                next_state  <= Q_idle;
              end if;
            end if;
        end case;
      end if;
    end if;

    -- connect outputs
    tx <= txff and not forcebrk;
  end process txcore_cp;

end arch_txcore;


