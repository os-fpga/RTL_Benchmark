--------------------------------------------------------------------------
-- Package of UART components
--
-- This UART uses a squarewave input for the BAUDRATE clock.  In other
-- words, the BAUD rate is exactly the same as the frequency of the
-- incoming clock.  This is in contrast to other UARTs which need a
-- Baud rate clock which is some multiple of the actual Baud rate
-- desired.  Because of the 1x nature of the Baud clock, the receiver
-- needs at least one Baud Clock interval in which to measure the
-- Baud clock versus the system clock, before it can start working.
-- Also, the system clock must be somewhat higher than the Baud clock
-- in order for the receiver to work.
--
-- This package contains the UART, plus individual async_tx and async_rx
-- modules, which are the transmit and receive sections of the UART.
--
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package uart_sqclk_pack is

  component uart_sqclk
    port (

      sys_rst_n     : in std_logic;
      sys_clk       : in std_logic;
      sys_clk_en    : in std_logic;

      -- rate and parity
      parity_i      : in unsigned(1 downto 0); -- 0=none, 1=even, 2 or 3=odd
      rate_clk_i    : in std_logic;

      -- serial I/O
      tx_stream     : out std_logic;
      rx_stream     : in std_logic;

      --control and status
      tx_wr_i       : in  std_logic;        -- Starts Transmit
      tx_dat_i      : in  unsigned(7 downto 0);
      tx_done_o     : out std_logic;
      rx_restart_i  : in  std_logic;        -- High clears error flags, clears rx_done_o
      rx_dat_o      : out unsigned(7 downto 0);
      rx_wr_o       : out std_logic;        -- High pulse means store rx_dat_o.
      rx_done_o     : out std_logic;        -- Remains high after receive, until clk edge with rx_restart_i=1
      frame_err_o   : out std_logic;        -- High = error.  Reset when rx_restart_i asserted.
      parity_err_o  : out std_logic         -- High = error.  Reset when rx_restart_i asserted.
    );
  end component;

  component async_tx_sqclk
    port (
       
      sys_rst_n    : in std_logic;
      sys_clk      : in std_logic;
      sys_clk_en   : in std_logic;

      -- rate and parity
      tx_parity_i  : in unsigned(1 downto 0); -- 0=none, 1=even, 2 or 3=odd
      tx_clk_i     : in std_logic;

      -- serial output
      tx_stream    : out std_logic;

      -- control and status
      tx_wr_i      : in  std_logic;        -- Starts Transmit
      tx_dat_i     : in  unsigned(7 downto 0);
      tx_done_o    : out std_logic
    );
  end component;


  component async_rx_sqclk
    port (
       
      sys_rst_n    : in std_logic;
      sys_clk      : in std_logic;
      sys_clk_en   : in std_logic;

      -- rate and parity
      rx_parity_i  : in unsigned(1 downto 0); -- 0=none, 1=even, 2 or 3=odd
      rx_clk_i     : in std_logic;

      -- serial input
      rx_stream    : in std_logic;

      -- control and status
      rx_restart_i : in  std_logic;        -- High clears error flags, clears rx_done_o
      rx_dat_o     : out unsigned(7 downto 0);
      rx_wr_o      : out std_logic;        -- High pulse means store rx_dat_o.
      rx_done_o    : out std_logic;        -- Remains high after receive, until rx_restart_i
      frame_err_o  : out std_logic;        -- High = error.  Reset when rx_restart_i asserted.
      parity_err_o : out std_logic         -- High = error.  Reset when rx_restart_i asserted.
    );
  end component;

  component half_duplex_switch
    generic (
      HANG_TIME : integer;  -- Units of timer_i rising edges
      TX_DELAY  : integer   -- Units of timer_i rising edges
    );
    port (

      sys_rst_n  : in  std_logic;
      sys_clk    : in  std_logic;
      sys_clk_en : in  std_logic;

      -- Full Duplex side
      tx_i       : in  std_logic;
      rx_o       : out std_logic;

      -- Half Duplex side
      hd_o       : out std_logic;
      hd_i       : in  std_logic;
      hd_drive_o : out std_logic;

      -- Timer
      tick_i     : in  std_logic
    );
  end component;

end uart_sqclk_pack;

package body uart_sqclk_pack is
end uart_sqclk_pack;


--------------------------------------------------------------------
-- UART.  Variable Speed, RX Buffer, but no TX buffer
-- High Speed Asynchronous Receiver & Transmitter
-- 
-- Description:
--   This block receives and transmits asynchronous serial bytes.  The Baudrate
-- and parity are selectable through inputs, but the number of bits per character
-- is fixed at eight.
--
-- NOTES:
-- Transmit starts when tx_wr_i is detected high at a rising clock edge.
-- Once the transmit operation is completed, tx_done_o latches high.
--
-- The receive input is passed through two layers of synchronizing flip-flops
-- to help mitigate metastability issues, since this signal can come from
-- outside of the sys_clk clock domain.  All other logic connecting to inputs
-- of this function are assumed to be within the same clock domain.
--
-- The receiver looks for a new start bit immediately following the rx_wr_o
-- pulse, but rx_done_o is delayed until the expected end of the received
-- character.  If a new start bit is detected just prior to the expected end
-- of the received character, then rx_done_o is not asserted.
--
-- Receive begins when the falling edge of the start bit is detected.
-- Then after 10 or 11 bit times have passed (depending on the parity setting)
-- the rx_wr_o signal will pulse high for one clock period, indicating rx_dat_o
-- contains valid receive data.  The rx_wr_o pulse is only issued if there is
-- no parity error, and the stop bit is actually detected high at the sampling
-- time.
-- The rx_dat_o outputs will hold the received data until the next rx_wr_o pulse.
-- The rx_dat_o output provides the received data, even in the presence of a
-- parity or stop-bit error.
-- Error flags are valid during rx_wr_o, but they remain latched, until
-- rx_restart_i.
--
-- The Baud rate is equal to the frequency of the rate_clk_i input.
-- It should be, as nearly as possible, a square wave of the desired
-- communications rate.
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_sqclk is
    port (

      sys_rst_n     : in std_logic;
      sys_clk       : in std_logic;
      sys_clk_en    : in std_logic;

      -- rate and parity
      parity_i      : in unsigned(1 downto 0); -- 0=none, 1=even, 2 or 3=odd
      rate_clk_i    : in std_logic;

      -- serial I/O
      tx_stream     : out std_logic;
      rx_stream     : in std_logic;

      --control and status
      tx_wr_i       : in  std_logic;        -- Starts Transmit
      tx_dat_i      : in  unsigned(7 downto 0);
      tx_done_o     : out std_logic;
      rx_restart_i  : in  std_logic;        -- High clears error flags, clears rx_done_o
      rx_dat_o      : out unsigned(7 downto 0);
      rx_wr_o       : out std_logic;        -- High pulse means store rx_dat_o.
      rx_done_o     : out std_logic;        -- Remains high after receive, until clk edge with rx_restart_i=1
      frame_err_o   : out std_logic;        -- High = error.  Reset when rx_restart_i asserted.
      parity_err_o  : out std_logic         -- High = error.  Reset when rx_restart_i asserted.
    );
end uart_sqclk;

library work;
use work.uart_sqclk_pack.all;

architecture beh of uart_sqclk is

-- Components

begin

  tx1: async_tx_sqclk
    port map (        
       sys_rst_n     => sys_rst_n,
       sys_clk       => sys_clk,
       sys_clk_en    => sys_clk_en,
       
       -- rate and parity
       tx_parity_i   => parity_i, -- 0=none, 1=even, 2 or 3=odd
       tx_clk_i      => rate_clk_i,

       -- serial output
       tx_stream     => tx_stream,

       -- control and status
       tx_wr_i       => tx_wr_i,       -- Starts Transmit
       tx_dat_i      => tx_dat_i,
       tx_done_o     => tx_done_o
    );

  rx1: async_rx_sqclk
    port map (        
       sys_rst_n     => sys_rst_n,
       sys_clk       => sys_clk,
       sys_clk_en    => sys_clk_en,
       
       -- rate and parity
       rx_parity_i   => parity_i, -- 0=none, 1=even, 2 or 3=odd
       rx_clk_i      => rate_clk_i,

       -- serial input
       rx_stream     => rx_stream,

       -- control and status
       rx_restart_i  => rx_restart_i,  -- High clears error flags, clears rx_done_o
       rx_dat_o      => rx_dat_o,
       rx_wr_o       => rx_wr_o,       -- High pulse means store rx_dat_o.
       rx_done_o     => rx_done_o,     -- Remains high after receive, until rx_restart_i
       frame_err_o   => frame_err_o,   -- High = error.  Reset when rx_restart_i asserted.
       parity_err_o  => parity_err_o   -- High = error.  Reset when rx_restart_i asserted.
    );

end beh;


-------------------------------------------------------------------------------
-- Asynchronous Transmitter With No Buffering
------------------------------------------------------------------------------- 
--
-- Author: John Clayton
-- Date  : Aug  08, 2013 Added this change log header, which was missing.
--                       Changed tx_done_o signal so that it pulses after
--                       the stop bit is finished.  How could this have
--                       remained so woefully incorrect for so long?!
--         Jan  02, 2014 Fixed a latent bug in the logic for asserting
--                       tx_done_o.  Prior to this fix, it was possible
--                       for a write that was coincident with do_txbit to
--                       be ignored!  Once again, how could this have
--                       remained so woefully incorrect all this time?!
--         Jan  07, 2014 Rewrote the startup logic to allow for cases
--                       when tx_wr_i='1' and tx_bcnt="0000" and do_txbit='1'
--                       Also rewrote the tx_done_o signal so that it is
--                       asserted earlier - when "tx_almost_done" is high.
--                       This is all calculated to allow the transmitter
--                       to send characters back-to-back using its own
--                       tx_done_o signal as a tx_wr_i signal.  This is
--                       actually getting pretty neat.  The unit sends out
--                       asynchronous characters, but insists on doing it
--                       in synchronism with the tx_clk_i input... so it
--                       isn't really very asynchronous in that sense!
--
-- Description
-------------------------------------------------------------------------------
-- Squarewave tx_clk_i input determines rate.
-- (tx_clk_i need not be a squarewave for this module, since only the rising
--  edge is used.  In the accompanying receiver, however, both edges are used.)
-- 
-- Description:
--   This block transmits asynchronous serial bytes.  The Baudrate and parity
-- are determined by inputs, but the number of bits per character is
-- fixed at eight.
--
-- NOTES:
-- Transmit starts when the transmitter is idle and tx_wr_i is detected high
-- at a rising sys_clk edge.
--
-- Once the transmit operation is completed, done_o latches high.
--
-- Since the baud clock might be asynchronous to the sys_clk, there are
-- syncronizing flip-flops on it inside this module.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity async_tx_sqclk is
    port (

      sys_rst_n    : in std_logic;
      sys_clk      : in std_logic;
      sys_clk_en   : in std_logic;

      -- rate and parity
      tx_parity_i  : in unsigned(1 downto 0); -- 0=none, 1=even, 2 or 3=odd
      tx_clk_i     : in std_logic;

      -- serial output
      tx_stream    : out std_logic;

      -- control and status
      tx_wr_i      : in  std_logic;        -- Starts Transmit
      tx_dat_i     : in  unsigned(7 downto 0);
      tx_done_o    : out std_logic
    );
end async_tx_sqclk;

architecture beh of async_tx_sqclk is

-- TX signals
  -- TX clock synchronizing flip-flops and rising edge detection
signal tx_clk_r1 : std_logic;
signal tx_clk_r2 : std_logic;
  -- TX clock enable, shift register and bit count
signal do_txbit       : std_logic;
signal tx_sr          : unsigned(9 downto 0); 
signal tx_bcnt        : unsigned(3 downto 0); -- Number of bits
signal tx_almost_done : std_logic;
signal tx_done        : std_logic;

begin

  -- This process detects the rising edge of tx_clk_i
  tx_clk_edge_proc: Process(sys_rst_n,sys_clk)
  BEGIN
    if (sys_rst_n = '0') then
      tx_clk_r1 <= '0';
      tx_clk_r2 <= '0';
    elsif (sys_clk'event AND sys_clk='1') then
      if (sys_clk_en='1') then
        tx_clk_r1 <= tx_clk_i;
        tx_clk_r2 <= tx_clk_r1;
      end if;
    end if;
  END PROCESS tx_clk_edge_proc;
  do_txbit <= (tx_clk_r1 and not tx_clk_r2); -- rising edge detect

  -- This process loads the shift register, then counts as the bits transmit out.
  byte_tx: Process(sys_rst_n,sys_clk)  
  BEGIN
    if (sys_rst_n = '0') then
      tx_sr     <= (others=>'0');
      tx_bcnt   <= (others=>'0');
      tx_stream <= '1';
      tx_done   <= '1';
    elsif (sys_clk'event and sys_clk='1') then
      if (sys_clk_en='1') then
        -- Start a new transmission when ready
        -- Case 1 is starting while do_txbit is high
        if tx_bcnt="0000" and do_txbit='1' and tx_wr_i='1' then
          tx_stream <= '0';                             -- Provide start bit
          tx_sr(7 downto 0) <= tx_dat_i;                -- Load the TX data
          tx_sr(8) <= '1';                              -- Default the parity bit to one
          if(tx_parity_i = "00") then                   --If no parity...
            tx_bcnt  <= "1001";                         -- send start, 8 data bits, and stop
          elsif (tx_parity_i = "01") then               --If even parity...
            tx_bcnt  <= "1010";                         -- send start, 8 data bits, parity, and stop
            tx_sr(8) <= tx_dat_i(0) XOR tx_dat_i(1) XOR tx_dat_i(2) XOR tx_dat_i(3) XOR 
                        tx_dat_i(4) XOR tx_dat_i(5) XOR tx_dat_i(6) XOR tx_dat_i(7);
          else                                          --If odd parity...
            tx_bcnt  <= "1011";                         --send start, 8 data bits, parity, and stop
            tx_sr(8) <= NOT (tx_dat_i(0) XOR tx_dat_i(1) XOR tx_dat_i(2) XOR tx_dat_i(3) XOR 
                             tx_dat_i(4) XOR tx_dat_i(5) XOR tx_dat_i(6) XOR tx_dat_i(7));
          end if;
          tx_done <= '0';
        -- Case 2 is starting while do_txbit is low
        elsif tx_done='1' and tx_wr_i='1' then -- Only allow loads when transmitter is idle
          tx_sr(0) <= '0';                              -- Load start bit
          tx_sr(8 downto 1) <= tx_dat_i;                -- Load the TX data
          tx_sr(9) <= '1';                              -- Default the parity bit to one
          if(tx_parity_i = "00") then                   --If no parity...
            tx_bcnt  <= "1010";                         -- send start, 8 data bits, and stop
          elsif (tx_parity_i = "01") then               --If even parity...
            tx_bcnt  <= "1011";                         -- send start, 8 data bits, parity, and stop
            tx_sr(9) <= tx_dat_i(0) XOR tx_dat_i(1) XOR tx_dat_i(2) XOR tx_dat_i(3) XOR 
                        tx_dat_i(4) XOR tx_dat_i(5) XOR tx_dat_i(6) XOR tx_dat_i(7);
          else                                          --If odd parity...
            tx_bcnt  <= "1011";                         --send start, 8 data bits, parity, and stop
            tx_sr(9) <= NOT (tx_dat_i(0) XOR tx_dat_i(1) XOR tx_dat_i(2) XOR tx_dat_i(3) XOR 
                             tx_dat_i(4) XOR tx_dat_i(5) XOR tx_dat_i(6) XOR tx_dat_i(7));
          end if;
          tx_done <= '0';
        -- Process through the remaining data
        elsif(tx_bcnt>"0000" and do_txbit='1') then     -- Still have bits to send?
          tx_bcnt <= tx_bcnt-1;
          tx_sr(8 downto 0) <= tx_sr(9 downto 1);       -- Right shift the data (send LSB first)
          tx_sr(9) <= '1';
          tx_stream <= tx_sr(0);
        end if;
        -- Assert tx_done when truly finished.
        if tx_almost_done='1' and tx_wr_i='0' then
          tx_done <= '1';
        end if;
      end if; -- sys_clk_en
    end if; -- sys_clk'event...
  END PROCESS byte_tx;

  tx_almost_done <= '1' when (tx_done='0' and tx_bcnt="0000" and do_txbit='1') else '0';
  tx_done_o <= '1' when tx_done='1' or tx_almost_done='1' else '0';

end beh;


-------------------------------------------------------------------------------
-- Asynchronous Receiver With Output Buffer
------------------------------------------------------------------------------- 
--
-- Author: John Clayton
-- Date  : Aug  05, 2013 Added this change log header, which was missing.
--                       Added first_edge signal to avoid erroneous initial
--                       baud interval measurement (John Clayton & Philip 
--                       Kasavan)
--         Jan.  2, 2014 Added output buffer, changed idle_prep to include
--                       the actual transition to IDLE state.  Added
--                       POST_RECV state, so that the rx_done_o signal will
--                       reflect the true end of the received character.
--                       This helps in applications where a received
--                       asynchronous input is "echoed back" directly,
--                       as the rx_wr_o signal can be used to switch the
--                       signal at the correct time.
--         Feb.  6, 2014 Added requirement for half_baud to be non-zero
--                       before leaving IDLE state.  This prevents leaving
--                       IDLE due to falling edges prior to the first Baud
--                       interval measurement.
--
-- Description
-------------------------------------------------------------------------------
-- Squarewave tx_clk_i input determines rate.
-- (tx_clk_i does not really need to be a squarewave.  Only the rising edges
--  are measured and used.)
-- 
-- Description:
--   This block receives asynchronous serial bytes.  The Baudrate and parity
-- are determined by inputs, but the number of bits per character is
-- fixed at eight.
--
-- NOTES:
-- The receive input and baudrate clock are passed through two layers of
-- synchronizing flip-flops to mitigate metastability, since those signals can
-- originate outside of the sys_clk clock domain.  All other logic connecting to 
-- input of this function are assumed to be within the same clock domain.
--
-- The receiver looks for a new start bit immediately following the rx_wr_o
-- pulse, but rx_done_o is delayed until the expected end of the received
-- character.  If a new start bit is detected just prior to the expected end
-- of the received character, then rx_done_o is not asserted.
--
-- Receive begins when the falling edge of the start bit is detected.
-- Then after 10 or 11 bit times have passed (depending on the parity setting)
-- the rx_wr_o signal will pulse high for one clock period, indicating rx_dat_o
-- contains valid receive data.  The rx_wr_o pulse is only issued if there is
-- no parity error, and the stop bit is actually detected high at the sampling
-- time.
-- The rx_dat_o outputs will hold the received data until the next rx_wr_o pulse.
-- The rx_dat_o output provides the received data, even in the presence of a
-- parity or stop-bit error.
-- Error flags are valid during rx_wr_o, but they remain latched, until
-- rx_restart_i.
--
-- Although the receiver immediately restarts itself to receive the next
-- character, the rx_restart_i input can clear the error indicators.  The rx_restart_i
-- input is like a synchronous reset in this respect since it will cause a receive
-- operation to abort.
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity async_rx_sqclk is
    port (
       
      sys_rst_n    : in std_logic;
      sys_clk      : in std_logic;
      sys_clk_en   : in std_logic;

      -- rate and parity
      rx_parity_i  : in unsigned(1 downto 0); -- 0=none, 1=even, 2 or 3=odd
      rx_clk_i     : in std_logic;

      -- serial input
      rx_stream    : in std_logic;

      -- control and status
      rx_restart_i : in  std_logic;        -- High clears error flags, synchronously resets receiver
      rx_dat_o     : out unsigned(7 downto 0);
      rx_wr_o      : out std_logic;        -- High pulse means store rx_dat_o.
      rx_done_o    : out std_logic;        -- Indicates receiver is idle
      frame_err_o  : out std_logic;        -- High = error.  Reset when rx_restart_i asserted.
      parity_err_o : out std_logic         -- High = error.  Reset when rx_restart_i asserted.
    );
end async_rx_sqclk;

architecture beh of async_rx_sqclk is


-- RX signals
  -- rx_clk_i synchronizing flip-flops and rising edge detector
signal rx_clk_r1       : std_logic;
signal rx_clk_r2       : std_logic;
  -- RX input synchronizing flip flops
signal rx_stream_r1    : std_logic;
signal rx_stream_r2    : std_logic;
  -- RX signals
    -- RX State Machine
type RX_STATE_TYPE is (IDLE, CHECK_START_1, CHECK_START_2, RECV_DATA, POST_RECV);
signal rx_state        : RX_STATE_TYPE;
signal start_bit_start : std_logic;             -- Signals falling edge of rx_stream_i
signal rx_sr           : unsigned(8 downto 0);  -- Shift register
signal rx_bcnt         : unsigned(3 downto 0);  -- Number of bits left, counts down
signal rx_bcnt_start   : unsigned(3 downto 0);  -- Total number of bits
signal rx_parity_good  : std_logic;
  -- Timers have been sized to hold baud interval for speeds as slow as 9600 bps at 100MHz sys_clk
signal rx_timer        : unsigned(13 downto 0); -- Elapsed sys_clks from last bit time start
signal half_baud       : unsigned(13 downto 0); -- One half of full_baud
signal full_baud       : unsigned(13 downto 0); -- Baud interval, as measured from rx_clk_i
signal baud_timer      : unsigned(13 downto 0); -- Used to measure baud interval
signal bit_sampled     : std_logic;             -- High indicates bit is already sampled, don't allow resampling.

signal first_edge      : std_logic;

begin
  
  -- Synchronizing flip flops to avoid metastability issues...
  rx_stream_syncproc: Process(sys_rst_n,sys_clk)
  BEGIN
    if (sys_rst_n = '0') then
      rx_stream_r1 <= '1';
      rx_stream_r2 <= '1';
    elsif (sys_clk'event AND sys_clk='1') then
      if (sys_clk_en='1') then
        rx_stream_r2 <= rx_stream_r1;
        rx_stream_r1 <= rx_stream;
      end if;
    end if;
  END PROCESS rx_stream_syncproc;
  start_bit_start <= rx_stream_r2 and not rx_stream_r1;

  -- Synchronizing flip flops to avoid metastability issues...
  rx_clk_syncproc: Process(sys_rst_n,sys_clk)
  BEGIN
    if (sys_rst_n = '0') then
      rx_clk_r1 <= '0';
      rx_clk_r2 <= '0';
    elsif (sys_clk'event AND sys_clk='1') then
      if (sys_clk_en='1') then
        rx_clk_r2 <= rx_clk_r1;
        rx_clk_r1 <= rx_clk_i;
      end if;
    end if;
  END PROCESS rx_clk_syncproc;

  -- This is the baud interval measuring process.
  -- Measurements are only made between rising edges
  baud_measure_proc: Process(sys_rst_n,sys_clk)
  BEGIN
    if (sys_rst_n = '0') then
      full_baud  <= (others=>'0');
      baud_timer <= (others=>'0');
      first_edge <= '0';
    elsif (sys_clk'event AND sys_clk='1') then
      if (sys_clk_en='1') then
        if(first_edge = '1')then 
          if (rx_clk_r1='1' and rx_clk_r2='0') then
            full_baud  <= baud_timer;
            baud_timer <= (others=>'0');
          else
            baud_timer <= baud_timer+1;
          end if;
        elsif(rx_clk_r1='1' and rx_clk_r2='0') then
          first_edge <= '1';
        end if;
      end if;
    end if;
  END PROCESS baud_measure_proc;


  -- This process handles the incoming bits
  uart_rx_bits: Process(sys_rst_n,sys_clk)

  procedure idle_prep is
  begin
    rx_done_o   <= '1';
    bit_sampled <= '0';
    rx_bcnt     <= (others=>'0');
    rx_timer    <= (others=>'0');
    rx_state    <= IDLE;
  end idle_prep;

  begin
    if (sys_rst_n = '0') then
      idle_prep;
      rx_sr        <= (others=>'0');
      frame_err_o  <= '0';
      parity_err_o <= '0';
      rx_wr_o      <= '0';
      rx_dat_o     <= (others=>'0');
    elsif (sys_clk'event AND sys_clk='1') then
      if (sys_clk_en='1') then
        -- Default values
        rx_wr_o      <= '0';           -- Default to no data write
        -- Handle incrementing the sample timer
        rx_timer<=rx_timer+1;
        -- State transitions
        case rx_state is

          when IDLE         =>
            rx_done_o   <= '1';           -- Indicate receive is done.
            bit_sampled <= '0';           -- Indicate bit is not yet sampled.
            if (rx_restart_i='1') then
              idle_prep;
              frame_err_o  <= '0';        -- At rx_restart, also clear error flags
              parity_err_o <= '0';
            elsif (half_baud/=0 and start_bit_start='1') then
              rx_timer  <= (others=>'0'); -- Reset timer back to zero
              rx_bcnt   <= rx_bcnt_start; -- Initialize bit counter
              rx_done_o <= '0';
              rx_state  <= CHECK_START_1;
            end if;

          when CHECK_START_1 =>
            if (rx_restart_i='1') then    -- Restart has very high priority
              idle_prep;
            elsif (rx_stream_r2='1') then -- High during this time is an error
              frame_err_o <= '1';
              idle_prep;
            elsif (rx_timer>=half_baud) then -- Must use >= since threshold may change downward
              rx_state  <= CHECK_START_2;
            end if;

          when CHECK_START_2 =>            -- During second half of start bit, don't verify low level
            if (rx_restart_i='1') then     -- Restart has very high priority
              idle_prep;
            elsif (rx_timer>=full_baud or rx_stream_r2='1') then -- Wait for end of start bit
              rx_timer <= (others=>'0'); -- Reset timer back to zero
              rx_state <= RECV_DATA;
            end if;

          when RECV_DATA     =>
            if (rx_restart_i='1') then     -- Restart has very high priority
              idle_prep;
            elsif (rx_timer>=full_baud) then -- Must use >= since threshold may change downward
              rx_timer <= (others=>'0'); -- Reset timer back to zero
              bit_sampled <= '0';
            elsif (rx_timer>=half_baud and bit_sampled='0') then -- Must use >= since threshold may change downward
              bit_sampled <= '1';
              if (rx_bcnt="0000") then
                rx_state <= POST_RECV;
                rx_dat_o <= rx_sr(7 downto 0);
                if (rx_parity_good='1' and rx_stream_r2='1') then
                  rx_wr_o <= '1';            -- If all is correct, create a one clock long pulse to store rx_dat_o.
                else
                  if (rx_stream_r2='0') then
                    frame_err_o <= '1';        -- Record error if there is a bad stop bit
                  end if;
                  if (rx_parity_good='0') then
                    parity_err_o <= '1';       -- Record error if there is bad parity
                  end if;
                end if;
              else -- Process a new bit
                rx_sr(7 downto 0) <= rx_sr(8 downto 1);
                if (rx_parity_i = "00") then
                  rx_sr(7) <= rx_stream_r2;  -- Store the new incoming bit
                else
                  rx_sr(8) <= rx_stream_r2;
                end if;
                rx_bcnt <= rx_bcnt-1;
              end if;
            end if;

          when POST_RECV => -- Wait out latter half of stop bit, checking for start bits...
            if (rx_restart_i='1') then
              bit_sampled  <= '0';
              frame_err_o  <= '0'; -- At rx_restart, also clear error flags
              parity_err_o <= '0';
              idle_prep;
            elsif (start_bit_start='1') then
              bit_sampled <= '0';
              rx_timer  <= (others=>'0'); -- Reset timer back to zero
              rx_bcnt   <= rx_bcnt_start; -- Initialize bit counter
              rx_done_o <= '0';
              rx_state  <= CHECK_START_1;
            elsif (rx_timer>=full_baud) then -- Wait for end of start bit
              bit_sampled <= '0'; -- Indicate bit is not yet sampled.
              idle_prep; -- Asserts rx_done_o to indicate completion
            end if;

          when others => null;

        end case;
      end if;
    end if;
  end process uart_rx_bits;

  -------------------------
  -- Assign number of bits to shift in.
  rx_bcnt_start <= "1000" when (rx_parity_i="00") else "1001";

  -------------------------
  -- Assign half baud period
  half_baud <= ('0' & full_baud(13 downto 1));

  -------------------------
  -- Parity check process
  rx_parity_check: process(rx_sr, rx_parity_i)
  begin
    if (rx_parity_i="00") then       -- No parity...
      rx_parity_good <= '1'; -- (always good.)
    elsif (rx_parity_i="01") then    -- Even parity...
      rx_parity_good <= not (rx_sr(0) XOR rx_sr(1) XOR rx_sr(2) XOR rx_sr(3) XOR rx_sr(4) 
                                      XOR rx_sr(5) XOR rx_sr(6) XOR rx_sr(7) XOR rx_sr(8));
    else                     -- Odd parity...
      rx_parity_good <=     (rx_sr(0) XOR rx_sr(1) XOR rx_sr(2) XOR rx_sr(3) XOR rx_sr(4) 
                                      XOR rx_sr(5) XOR rx_sr(6) XOR rx_sr(7) XOR rx_sr(8));
    end if;
  end process;

end beh;


-------------------------------------------------------------------------------
-- Half Duplex Switch -- automatic priority to TX, with "hang timer" and delay
------------------------------------------------------------------------------- 
--
-- Author: John Clayton
-- Date  : Oct. 09, 2015 Initial creation.
--         Oct. 20, 2015 Updated to include delay, thereby allowing for
--                       switching from TX to RX at the very end of the
--                       TX data, at the expense of waiting additional
--                       time for the TX data to emerge.
--
-- Description
-------------------------------------------------------------------------------
--
-- This unit implements a simple switch for routing both TX and RX signals
-- over a single wire, called "half duplex" communication.  This is needed
-- for 2 wire RS-232 or 3 wire RS-485/RS-422 communications.
--
-- The switch immediately goes into transmit mode when the non-idle state
-- is detected on the tx_i input.  After HANG_TIME rising edges of the
-- tick_i input, with the idle state continuously present on the tx_i input,
-- the switch reverts to the receive mode.  The tick_i may be connected
-- to the Baudrate clock, or any other desired clock, but it must not
-- be tied to a constant value, since the edges are needed to advance
-- the timer.
--
-- It is recommended to set HANG_TIME to exceed the time needed for one
-- character to be transmitted, since that will prevent mid-character
-- timeouts.
--
-- An additional parameter, DELAY, allows for the transmit data to be
-- delayed by DELAY rising edges of the tick_i input.  Note that this
-- delays the TX data after the activity check, so that the moment when
-- the "hang" timer expires can effectively be lined up with the end of
-- the final TX data byte.  Take care!  If DELAY is set greater than
-- HANG_TIME, then some of the TX data can be effectively curtailed.
--
-- Note that the delay shift register effectively samples tx_i data
-- on the detected rising edges of tick_i.  Thus, tick_i rising edges
-- should be a synchronized 1x Baud rate clock, or else an unsynchronized
-- clock at more than 2x the Baud rate, to satisfy Nyquist criteria. By
-- setting DELAY=0, this constraint is removed, since the shift register
-- is not used for zero DELAY, and no re-sampling of tx_i actually occurs.
--
-- The hd_drive_o signal is provided so that tristates may be kept at the top
-- level of the system.
--
-- No synchronization flip flops are implemented within this switch
-- module.  If needed, they are assumed to be included elsewhere.
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.convert_pack.all;

entity half_duplex_switch is
    generic (
      HANG_TIME : natural := 12; -- Units of timer_i rising edges
      TX_DELAY  : natural := 12  -- Units of timer_i rising edges
    );
    port (

      sys_rst_n  : in  std_logic;
      sys_clk    : in  std_logic;
      sys_clk_en : in  std_logic;

      -- Full Duplex side
      tx_i       : in  std_logic;
      rx_o       : out std_logic;

      -- Half Duplex side
      hd_o       : out std_logic;
      hd_i       : in  std_logic;
      hd_drive_o : out std_logic;

      -- Timer
      tick_i     : in  std_logic
    );
end half_duplex_switch;

architecture beh of half_duplex_switch is

-- TX signals
signal timer    : unsigned(timer_width(HANG_TIME)-1 downto 0);
signal delay_sr : unsigned(15 downto 0);
signal tick_r1  : std_logic;
signal tx_data  : std_logic;

begin

  main_proc: Process(sys_rst_n,sys_clk)
  begin
    if (sys_rst_n = '0') then
      tick_r1  <= '0';
      timer    <= (others=>'0');
      delay_sr <= (others=>'1');
    elsif (sys_clk'event AND sys_clk='1') then
      if (sys_clk_en='1') then
        tick_r1 <= tick_i;
        -- Handle the delay shift register
        if (tick_r1='0' and tick_i='1') then
          delay_sr <= delay_sr(14 downto 0) & tx_i;
        end if;
        -- Handle the hang timer
        if (tx_i='0') then
          timer <= to_unsigned(HANG_TIME,timer'length);
        elsif (tick_r1='0' and tick_i='1') then
          if (timer>0) then
            timer <= timer-1;
          end if;
        end if;
      end if;
    end if;
  end process main_proc;

  tx_data <= tx_i when (TX_DELAY=0) else delay_sr(TX_DELAY-1);

  rx_o <= '1' when (timer>0) else hd_i;
  hd_o <= tx_data when (timer>0) else '1';
  hd_drive_o <= '1' when (timer>0) else '0';

end beh;


