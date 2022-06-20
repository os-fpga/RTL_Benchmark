---------------------------------------------------------------------
--	Filename:	rxcore.vhd
--
--			
--	Description:
--		rxcore: UART receiver 
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

-- asynchronous RX core entity
entity rxcore is
  generic (
    USE_EAB : string := "OFF"           -- can be "ON" or "OFF"
    );
  port
    (
      clk, reset    : in  std_logic;    -- clk and synchronous reset
      rx            : in  std_logic;    -- receive data input: ASYNCHRONOUS!
      tick          : in  std_logic;    -- active high for 1 clk period every 1/8 bit time
      bits          : in  std_logic_vector(2 downto 0);  -- number of bits: n means n+1 bits will be received
      parity_enable : in  std_logic;    -- 1 -> enable parity bit reception
      parity_even   : in  std_logic;    -- 1 -> there has to be an even number of 1's (including parity bit)
      data          : out std_logic_vector(7 downto 0);  -- last received word pulled from fifo (see fifo_pull)
      pe            : out std_logic;    -- parity error flag
      rpe, spe      : in  std_logic;    -- software: reset-pe, set-pe
      ipe           : in  std_logic;    -- enable interrupt on pe
      fe            : out std_logic;    -- framing error flag
      rfe, sfe      : in  std_logic;    -- software: reset-fe, set-fe
      ife           : in  std_logic;    -- enable interrupt on pe
      brk           : out std_logic;    -- break detect flag
      rbrk, sbrk    : in  std_logic;    -- software: reset-brk, set-brk
      ibrk          : in  std_logic;    -- enable interrupt on brk
      rdy           : out std_logic;    -- one or more character are ready (into rxfifo): set after rdy_delay bits
      rrdy, srdy    : in  std_logic;    -- software: reset-rdy, set-rdy
      irdy          : in  std_logic;    -- enable interrupt on rdy
      fifo_pull     : in  std_logic;    -- pull a character from rxfifo to rxdata register
      fifo_clear    : in  std_logic;    -- clear the rx register to empty
      fifo_chars    : out std_logic_vector(4 downto 0);  -- number of characters ready into rxfifo
      rdy_delay     : in  std_logic_vector(7 downto 0);  -- programmable delay from "a first character into fifo" to rdy
      oe            : out std_logic;    -- overflow error: a character arrived while the fifo was full
      roe, soe      : in  std_logic;    -- software: reset-oe, set-oe
      ioe           : in  std_logic;    -- enable interrupt on overflow
      irq           : out std_logic     -- interrupt request
      );
end rxcore;

architecture arch_rxcore of rxcore is

  ----------------------------------------------------------------------------------------------------------------------
  -- REGISTERS (and their "_in" input nodes)

  -- bit time counter: 8 ticks builds up a bit time
  signal ntick, ntick_in         : std_logic_vector(2 downto 0) := (others => '0');
  signal ntickhalf, ntickhalf_in : std_logic                    := '0';  -- 1/2 bit position indicator
  signal nticktop, nticktop_in   : std_logic                    := '0';  -- 1 bit time position indicator

  -- bit counter: the index of the bit that is currently beeing received 
  signal nbit, nbit_in : std_logic_vector(2 downto 0) := (others => '0');

  -- rx (pseudo-shift) register
  signal rxreg, rxreg_in     : std_logic_vector(7 downto 0) := (others => '0');
  signal rxpulse, rxpulse_in : std_logic                    := '0';

  -- input data filter (3 stage) and metastability (2 stage) avoidance pipeline
  signal rxpipe, rxpipe_in : std_logic_vector(4 downto 0) := (others => '1');

  -- parity bit!
  signal parity, parity_in : std_logic := '0';

  ----------------------------------------------------------------------------------------------------------------------
  -- Receiver state machine controller: after a valid start bit it collects bits,parity stop...
  type state_type is (Q_idle, Q_start, Q_bits, Q_parity, Q_stop, Q_wait_for_mark);

  signal next_state, current_state : state_type := Q_idle;

  -- flags and interrupt enables
  signal pef, pef_in   : std_logic := '0';  -- parity error
  signal fef, fef_in   : std_logic := '0';  -- framing error
  signal brkf, brkf_in : std_logic := '0';  -- break detect error
  signal oef, oef_in   : std_logic := '0';  -- overflow error
  signal rdyf, rdyf_in : std_logic := '0';  -- data ready flag

  -- sampled and filtered version of rx
  signal rxd : std_logic;

  -- rx fifo wires 
  signal fifo_usedw : std_logic_vector(3 downto 0) := (others => '0');
  signal fifo_empty : std_logic                    := '0';
  signal fifo_q     : std_logic_vector(7 downto 0) := (others => '0');
  signal fifo_full  : std_logic                    := '0';

  -- debug signals
  signal sampleedge, sampleedge_in : std_logic := '0';  -- toggles for each bit sample point

  ----------------------------------------------------------------------------------------------------------------------
  -- data interrupt handling: an interrupt is generated when some time is elapsed after that a char has been received
  -- Time is measured (approx...) in unit of "bits time" (independent of baud rate)

  -- ready timer... delays the interrupt generation
  signal rdytimer, rdytimer_in : std_logic_vector(7 downto 0) := (others => '0');


  -------------------------------------------------------
  -- returns the number of '1' bits into the input vector
  -------------------------------------------------------
  function num_ones (signal word : in std_logic_vector; constant osize : in natural) return std_logic_vector is
    variable result : unsigned(osize -1 downto 0);
    variable i      : natural;
  begin
    result := (others => '0');
    for i in word'range loop
      if word(i) = '1' then
        result := result +1;
      end if;
    end loop;
    return std_logic_vector(result);
  end num_ones;

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
  -- receive fifo..
  rxfifo : scfifo
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
    port map (                          -- @
      sclr  => fifo_clear,
      rdreq => fifo_pull,
      clock => clk,
      wrreq => rxpulse,
      data  => rxreg,
      usedw => fifo_usedw,
      empty => fifo_empty,
      q     => fifo_q,
      full  => fifo_full
      );

  -- filter_sp/cp process: input metasability avoidance pipe and majority filter
  filter_sp : process (clk) is
  begin  -- process filter_sp
    if rising_edge(clk) then
      rxpipe <= rxpipe_in;
    end if;
  end process filter_sp;

  filter_cp : process (rx, rxpipe) is
  begin  -- process filter_cp
    if (tick = '1') then
      rxpipe_in(4)          <= rx;
      rxpipe_in(3 downto 0) <= rxpipe(4 downto 1);
      --rxd                   <= '0';

    else
      rxpipe_in <= rxpipe;
    end if;
    if unsigned(num_ones(rxpipe(2 downto 0), 2)) > 1 then
      rxd <= '1';
    else
      rxd <= '0';
    end if;
  end process filter_cp;

  -- rxcore sequential process:  registers update
  rxcore_sp : process (clk) is
  begin
    if rising_edge(clk) then
      rxreg         <= rxreg_in;
      ntick         <= ntick_in;
      nticktop      <= nticktop_in;
      ntickhalf     <= ntickhalf_in;
      nbit          <= nbit_in;
      parity        <= parity_in;
      current_state <= next_state;
      rxpulse       <= rxpulse_in;
      pef           <= pef_in;
      fef           <= fef_in;
      brkf          <= brkf_in;
      oef           <= oef_in;
      rdyf          <= rdyf_in;
      rdytimer      <= rdytimer_in;
      sampleedge    <= sampleedge_in;
    end if;
  end process rxcore_sp;

  -- rxcore combinatorial process: handles reset, main state machine update,...
  rxcore_cp : process (bits, brkf, current_state, fef, fifo_empty, fifo_full, fifo_q, fifo_usedw, ibrk, ife, ioe, ipe,
                       irdy, nbit, ntick, ntickhalf, nticktop, oef, parity, parity_enable, parity_even, pef, rbrk,
                       rdy_delay, rdyf, rdytimer, reset, rfe, roe, rpe, rrdy, rxd, rxpulse, rxreg, sampleedge, sbrk,
                       sfe, soe, spe, srdy, tick)
    is
  begin
    -- default: hold previous values if tick is false
    ntick_in      <= ntick;
    nbit_in       <= nbit;
    rxreg_in      <= rxreg;
    parity_in     <= parity;
    next_state    <= current_state;
    nticktop_in   <= nticktop;
    ntickhalf_in  <= ntickhalf;
    rxpulse_in    <= '0';
    pef_in        <= pef;
    fef_in        <= fef;
    brkf_in       <= brkf;
    oef_in        <= oef;
    rdyf_in       <= rdyf;
    rdytimer_in   <= rdytimer;
    sampleedge_in <= sampleedge;

    -- "software" low priority flag settings
    if rpe = '1' then                   -- parity error sw set/clear
      pef_in <= '0';
    elsif spe = '1' then
      pef_in <= '1';
    end if;
    if rfe = '1' then                   -- framing error sw set/clear
      fef_in <= '0';
    elsif sfe = '1' then
      fef_in <= '1';
    end if;
    if rbrk = '1' then                  -- break detect
      brkf_in <= '0';
    elsif sbrk = '1' then
      brkf_in <= '1';
    end if;
    if roe = '1' then                   -- overflow error
      oef_in <= '0';
    elsif soe = '1' then
      oef_in <= '1';
    end if;
    if rrdy = '1' then                  -- rdy flag
      rdyf_in <= '0';
    elsif srdy = '1' then
      rdyf_in <= '1';
    end if;

    -- rdytimer update. Note: rdytimer's clear has higher priority...
    -- data-ready irq timer and rdy flag: software (rrdy) clear
    if rrdy = '1' then
      rdytimer_in <= (others => '0');
    else
      if (tick = '1') and (nticktop = '1') then
        if (rdyf = '0') and (fifo_empty = '0') then  -- fifo has data -> count up
          rdytimer_in <= std_logic_vector(unsigned(rdytimer) +1);
        end if;
      end if;
    end if;

    -- rdy flag set on rdytimer level
    if rdytimer = rdy_delay then
      rdyf_in <= '1';
    end if;

    -- rx overflow...
    if '1' = (rxpulse and fifo_full) then
      oef_in <= '1';
    end if;

    if reset = '1' then
      next_state <= Q_idle;
    else
      -- do something only if tick is asserted
      if tick = '1' then
        -- advance tick (rolling!) counter and update time threshold flags
        ntick_in <= std_logic_vector(unsigned(ntick) +1);
        if ntick = std_logic_vector(to_unsigned(7, ntick'length)) then
          nticktop_in <= '1';
        else
          nticktop_in <= '0';
        end if;
        if ntick = std_logic_vector(to_unsigned(1, ntick'length)) then
          ntickhalf_in <= '1';
        else
          ntickhalf_in <= '0';
        end if;
        case current_state is
          when Q_idle =>
            -- if a 0 is detected then look for a valid start bit
            if rxd = '0' then
              next_state   <= Q_start;
              -- reset timer, flags, register, etc..
              ntick_in     <= (others => '0');
              nticktop_in  <= '0';              -- reset pipelined flag...
              ntickhalf_in <= '0';
              rxreg_in     <= (others => '0');  -- clear RX register
              parity_in    <= parity_even;
            end if;
          when Q_start =>                       -- look for a valid start bit
            nbit_in <= (others => '0');
            if ntickhalf = '1' then
              if rxd = '0' then                 -- true start bit
                next_state  <= Q_bits;
                -- rester timer to sample the bits in the middle...
                ntick_in    <= (others => '0');
                nticktop_in <= '0';
              else                              -- false start bit -> framing error
                fef_in     <= '1';
                next_state <= Q_wait_for_mark;  -- wait for another '1'
              end if;
            end if;
          when Q_bits =>                        -- shift in "bits" bit
            if nticktop = '1' then
              sampleedge_in <= not sampleedge;  -- signals the sampling point with an edge...
              for i in 0 to 7 loop
                if i = to_integer(unsigned(nbit)) then
                  rxreg_in(i) <= rxd;           -- update bit sample of current bit 
                end if;
              end loop;  -- i
              -- update parity bit
              parity_in <= parity xor rxd;
              -- update bit counter
              nbit_in   <= std_logic_vector(unsigned(nbit) +1);
              if nbit = bits then
                nbit_in <= (others => '0');
                if parity_enable = '1' then
                  next_state <= Q_parity;       -- a parity bit has to be read
                else
                  next_state <= Q_stop;
                end if;
              end if;
            end if;
          when Q_parity =>                      -- check the parity bit
            if nticktop = '1' then
              next_state <= Q_stop;
              -- update parity bit (will be used by break detect logic...)
              parity_in  <= parity xor rxd;
              if '0' = ((parity xor rxd) xor parity_even) then
                -- incorrect parity
                pef_in <= '1';
              end if;
            end if;
          when Q_stop =>                        -- look for a valid stop bit
            if nticktop = '1' then
              next_state <= Q_wait_for_mark;    -- will always wait for another '1'...
              rxpulse_in <= '1';                -- push char here!
              if rxd = '0' then
                -- framing error or break detect
                if (rxreg /= "00000000") then
                  fef_in <= '1';                -- a "simple" framing error
                else
                  if ('0' = parity_enable) or ('0' = (parity xor parity_even)) then
                    brkf_in <= '1';             -- break detect
                  else
                    fef_in <= '1';              -- framing error if not all bits are '0'
                  end if;
                end if;
              end if;
            end if;
          when Q_wait_for_mark =>               -- wait for a high on rxd..
            if rxd = '1' then
              next_state <= Q_idle;
            end if;
        end case;
      end if;
    end if;

    -- connect outputs
    data       <= fifo_q;
    pe         <= pef;
    fe         <= fef;
    brk        <= brkf;
    oe         <= oef;
    rdy        <= rdyf;
    fifo_chars <= (fifo_full & fifo_usedw);
    irq        <= (pef and ipe) or (fef and ife) or (brkf and ibrk) or (oef and ioe) or (rdyf and irdy);

  end process rxcore_cp;

end arch_rxcore;


