--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- Package containing SD Card interface modules,
-- and related support modules.
--
-- 15-Aug-2017 RMR Backdoor opcodes not needed, SPI debugger still at 3000040
-- xx-Jun-2017 RMR Changed SPI debugger to 'w 03000040' so backdoor opcode could use 3000030 
-- 31-Mar-2017 RMR Added SPI debug capability to 'w 03000030'
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.sd_card_pack.all;
use work.sd_host_pack.all;

package mmc_test_pack is

  component mmc_test_cmd_rx
  port(
    -- Asynchronous reset
    sys_rst_n   : in  std_logic;
    -- SD/MMC card command signals
    sd_clk_i    : in  std_logic;
    sd_cmd_i    : in  std_logic;
    -- Command outputs
    cmd_raw_o   : out unsigned(47 downto 0);
    -- Status and done indicator
    cmd_done_o  : out std_logic;
    crc_err_o   : out std_logic;
    stop_err_o  : out std_logic
  );
  end component;

  component mmc_tester
  generic (
    SYS_CLK_RATE        : real; -- The clock rate at which the FPGA runs
    SYS_LEDS            : natural; -- Number of LED outputs on the board
    SYS_SWITCHES        : natural; -- Number of Switch inputs on the board
    EXT_CSD_INIT_FILE   : string; -- Initial contents of EXT_CSD
    HOST_RAM_ADR_BITS   : natural; -- Determines amount of BRAM in MMC host
    MMC_FIFO_DEPTH      : integer;
    MMC_FILL_LEVEL_BITS : integer; -- Should be at least int(floor(log2(FIFO_DEPTH))+1.0)
    RSP_FILL_LEVEL_BITS : integer; 
    MMC_RAM_ADR_BITS    : integer
  );
  port (

    -- Asynchronous reset
    sys_rst_n      : in  std_logic;
    sys_clk        : in  std_logic;

    -- Asynchronous serial interface
    cmd_i          : in  std_logic;
    resp_o         : out std_logic;

    -- Board related
    switch_i       : in  unsigned(SYS_SWITCHES-1 downto 0);
    led_o          : out unsigned(SYS_LEDS-1 downto 0);

    -- Interface for SD/MMC traffic logging
    -- via asynchronous serial transmission
    tlm_send_i     : in  std_logic;
    tlm_o          : out std_logic;

    -- Tester Function Enables
    slave_en_i     : in  std_logic; -- OR with register bit
    host_en_i      : in  std_logic; -- OR with register bit

    -- SD/MMC card signals
    mmc_clk_i      : in  std_logic;
    mmc_clk_o      : out std_logic;
    mmc_clk_oe_o   : out std_logic;
    mmc_cmd_i      : in  std_logic;
    mmc_cmd_o      : out std_logic;
    mmc_cmd_oe_o   : out std_logic;
    mmc_dat_i      : in  unsigned(7 downto 0);
    mmc_dat_o      : out unsigned(7 downto 0);
    mmc_dat_oe_o   : out std_logic;
    mmc_od_mode_o  : out std_logic; -- Open drain mode
    mmc_dat_siz_o  : out unsigned(1 downto 0);

    dbg_spi_data0_o     : out unsigned(7 downto 0);
    dbg_spi_data1_o     : out unsigned(7 downto 0);
    dbg_spi_data2_o     : out unsigned(7 downto 0);
    dbg_spi_data3_o     : out unsigned(7 downto 0);
    dbg_spi_data4_o     : out unsigned(7 downto 0);
    dbg_spi_data5_o     : out unsigned(7 downto 0);
    dbg_spi_data6_o     : out unsigned(7 downto 0);
    dbg_spi_data7_o     : out unsigned(7 downto 0);
    dbg_spi_data8_o     : out unsigned(7 downto 0);
    dbg_spi_data9_o     : out unsigned(7 downto 0);
    dbg_spi_dataA_o     : out unsigned(7 downto 0);
    dbg_spi_dataB_o     : out unsigned(7 downto 0);
    dbg_spi_dataC_o     : out unsigned(7 downto 0);
    dbg_spi_dataD_o     : out unsigned(7 downto 0);
    dbg_spi_bytes_io    : inout unsigned(3 downto 0); --bytes to send
    dbg_spi_start_o     : out std_logic;
    dbg_spi_device_o    : out unsigned(2 downto 0); --1=VGA, 2=SYN, 3=DDS, 4=ZMON
    dbg_spi_busy_i      : in  std_logic;
    dbg_enables_o       : out unsigned(15 downto 0);  --toggle various enables/wires

    ------ Connect MMC fifos to opcode processor ----------
    -- Read from MMC fifo connections
    opc_fif_dat_o       : out unsigned( 7 downto 0);    -- MMC opcode fifo
    opc_fif_ren_i       : in  std_logic;                -- mmc fifo read enable
    opc_fif_mt_o        : out std_logic;                -- mmc opcode fifo empty
    opc_rd_cnt_o        : out unsigned(MMC_FILL_LEVEL_BITS-1 downto 0); -- mmc opcode fifo fill level 
    opc_rd_reset_i      : in  std_logic;                -- Synchronous mmc opcode fifo reset
    -- Write to MMC fifo connections
    opc_rspf_dat_i      : in  unsigned( 7 downto 0);    -- MMC response fifo
    opc_rspf_we_i       : in  std_logic;                -- response fifo write line             
    opc_rspf_mt_o       : out std_logic;                -- response fifo empty
    opc_rspf_fl_o       : out std_logic;                -- response fifo full
    opc_rspf_reset_i    : in std_logic;                 -- Synchronous mmc response fifo reset
    opc_rspf_cnt_o      : out unsigned(MMC_FILL_LEVEL_BITS-1 downto 0); -- mmc response fifo fill level 

    -- UART debugger can show these values
    opc_oc_cnt_i        : in  unsigned(31 downto 0);    -- count of opcodes processed
    opc_status1_i       : in  unsigned(31 downto 0);    -- LS 16 bits=opc status, MS 16-bits=opc_state
    opc_status2_i       : in  unsigned(31 downto 0);    -- rsp_fifo_count__opc_fifo_count    
    opc_status3_i       : in  unsigned(31 downto 0);    -- LS 16 bits=MS 8 bits=RSP fifo level, LS 8 bits=OPC fifo level
    sys_status4_i       : in  unsigned(31 downto 0);    -- system frequency setting in Hertz
    sys_status5_i       : in  unsigned(31 downto 0);    -- MS 16 bits=SYN_STAT pin,1=PLL_LOCK, 0=not, LS 12 bits=system power, dBm x 10
    sys_status6_i       : in  unsigned(31 downto 0)     -- LS 16 bits: PTN_Status__PTN_Busy(running) 
  );
  end component;

end mmc_test_pack;

package body mmc_test_pack is
end mmc_test_pack;

-------------------------------------------------------------------------------
-- SD/MMC Testing Command Receiver
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update: July 29, 2016 Copied code from sd_card_cmd_rx, and modified
--                       the description and interface to better suit
--                       test needs, e.g. capturing commands and replies
--                       on an SD/MMC bus.
--
-- Description
-------------------------------------------------------------------------------
-- This module is meant to be part of a system that tests, or snoops on
-- an SD/MMC card.
--
-- This module clocks incoming serial bits from the cmd signal into a 48 bit
-- shift register.  It starts when a '0' (start) bit is found, and then shifts
-- in 47 additional bits.  The expected format of the command is:
--
-- 0 x [index] [arg] [crc] 1
--
-- Where:
--   x     = direction bit. '1'=host to card, '0'=reply from card.
--   index = 6 bits
--   arg   = 32 bits
--   crc   = 7  bits
--
-- The test command receiver checks that the last bit is a '1' (stop) bit,
-- in the expected position (bit 47; start bit is bit 0).
-- The seven bits immediately prior to the stop bit are
-- checked using a CRC-7 code.
--
-- If any of the checks does not pass, the associated error bits are set.
-- Regardless of errors, however, the received data bits are presented
-- at the cmd_raw_o output.  The cmd_rx_done_o output is pulsed high for
-- one clock cycle to notify the downstream entities that newly received
-- data is available.
--
-- In the interest of simplicity and in an effort to remain practical,
-- only 48 bit responses are captured correctly by this unit.  For R2
-- responses, which are 136 bits long, only the first 48 bits are presented.
-- Because the R2 type responses are 136 bits long, specific logic is
-- included to try and detect them, and prevent errors from being flagged
-- by their occurrence.  The first eight bits of an R2 response are
-- "00111111".  Unfortunately, the first eight bits of a 48 bit R3
-- response are also "00111111".  Fortunately, the CRC field of an R3
-- response is always set to "1111111".  So, the logic checks for these
-- conditions and behaves accordingly.  In the case of an R2 response, that
-- includes ignoring further activity on the command line for another 88
-- clocks after the initial 48 bits are received...
--
-- Note that this receiver runs entirely within the sd_clk_i clock domain.
-- Therefore, care must be taken when using the outputs.  A FIFO can form
-- a natural "clock domain boundary crossing" or the user may need to
-- implement other special handshaking to safely transfer signals into a
-- different clock domain.
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.ucrc_pack.all;

entity mmc_test_cmd_rx is
  port (
    -- Asynchronous reset
    sys_rst_n   : in  std_logic;
    -- SD/MMC card command signals
    sd_clk_i    : in  std_logic;
    sd_cmd_i    : in  std_logic;
    -- Command outputs
    cmd_raw_o   : out unsigned(47 downto 0);
    -- Status and done indicator
    cmd_done_o  : out std_logic;
    crc_err_o   : out std_logic;
    stop_err_o  : out std_logic
  );
end mmc_test_cmd_rx;

architecture beh of mmc_test_cmd_rx is

  -- CRC related
signal crc_clk        : std_logic;
signal crc_clr        : std_logic;
signal crc_match      : std_logic;
signal crc_val        : unsigned(6 downto 0);
  -- Related to the incoming command
signal sd_cmd_r1      : std_logic;
signal counter        : unsigned(5 downto 0);
signal rx_sr          : unsigned(47 downto 0);
signal cmd_raw_l      : unsigned(47 downto 0);
signal ignore_counter : unsigned(6 downto 0);

begin

--------------------------------------------
-- CRC generator

  crc0 : ucrc_ser
  generic map (
    POLYNOMIAL => "0001001",
    INIT_VALUE => "0000000"
  )
  port map (
    -- System clock and asynchronous reset
    sys_clk    => crc_clk,
    sys_rst_n  => sys_rst_n,
    sys_clk_en => '1',

    -- Input and Control
    clear_i    => crc_clr,
    data_i     => rx_sr(0),
    flush_i    => '0',

    -- Output
    match_o    => crc_match,
    crc_o      => crc_val
  );
  -- Falling edge was used for a while...
  -- Rising edge is now being used, per the specification.
  --crc_clk <= not sd_clk_i;
  crc_clk <= sd_clk_i;
  crc_clr <= '1' when counter=0 else '0';
  

--------------------------------------------
-- Command receiver

command_rx_proc : process(sys_rst_n, sd_clk_i)
begin
  if (sys_rst_n='0') then
    ignore_counter <= (others=>'0');
    counter <= (others=>'0');
    rx_sr <= (others=>'0');
    sd_cmd_r1 <= '1';
    cmd_raw_l <= (others=>'1');
    cmd_done_o  <= '0';
    crc_err_o   <= '0';
    stop_err_o  <= '0';
--  elsif (sd_clk_i'event and sd_clk_i='0') then -- falling edge is used, when data is stable.
  elsif (sd_clk_i'event and sd_clk_i='1') then -- rising edge is used, per the specification.
    -- Default values
    cmd_done_o  <= '0';
    crc_err_o   <= '0';
    stop_err_o  <= '0';
    
    -- Metastability mitigation (synchronization) flip flops
    sd_cmd_r1 <= sd_cmd_i;
    -- The shift register is the second synchronization flip flop
    rx_sr(0)  <= sd_cmd_r1;
    rx_sr(47 downto 1) <= rx_sr(46 downto 0);
    -- Decrement the counter when it is non-zero
    if (counter>0) then
      counter <= counter-1;
    end if;
    -- Decrement the ignore counter when it is non-zero
    if (ignore_counter>0) then
      ignore_counter <= ignore_counter-1;
    end if;
    -- Load the counter when a start bit is seen
    if (ignore_counter=0 and counter=0 and sd_cmd_r1='0') then
      counter <= to_unsigned(48,counter'length);
    end if;
    -- Store the output when the counter is expiring
    if (counter=1) then
      cmd_raw_l <= rx_sr;
      cmd_done_o <= '1';
      -- Determine if this is a long R2 type response
      if (rx_sr(47 downto 40)="00111111" and rx_sr(7 downto 1)/="1111111") then
        ignore_counter <= to_unsigned(88,ignore_counter'length);
        -- No errors are generated for long R2 responses
      else
        -- Perform error checks
        if (rx_sr(0)='0') then
          stop_err_o <= '1';
        end if;
        if (crc_match='0') then
          crc_err_o <= '1';
        end if;
      end if;
    end if;
  end if;
end process;

-- Split out fields of the command
cmd_raw_o   <= cmd_raw_l;

end beh;



---------------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Date  : May 16, 2016
-- Update: 05/16/16 Wrote the description, began writing code
--
-- Description
---------------------------------------------------------------------------------------
-- This is a collection of modules put together which allow testing of an MMC system.
-- In particular, this module contains an MMC host, plus an "MMC data pipe" which
-- impersonates an MMC.  
--
-- In order to interact with this collection of MMC modules in hardware, an 
-- "async_syscon" serial terminal command interpreter is provided, having a 32-bit
-- address and a 32-bit data bus.  There is an automatic baud rate synchronization
-- unit, which synchronizes by looking for the 0x0D character, so that simply
-- pressing "Enter" in a serial terminal program should bring up the link at the
-- correct speed, anything in the range 19200 to 921600 Baud should work.
-- The parity setting is "None" and hardware handshaking is not supported.
--
-- Because of the different modules present in this MMC tester, it is helpful to
-- summarize the memory map here:
--
-- Address          Length     Function
-- --------------   --------   --------------------------------------------
-- 0x0300_0000      0x10       MMC host registers
-- 0x0300_0010      0x10       MMC slave registers
-- 0x0300_0020      0x10       MMC tester registers
-- 0x0400_0000      0x4000     MMC host RAM
-- 0x0500_0000      0x10000    MMC slave RAM
--
-- Note that the size of the MMC slave RAM can be modified by setting the
-- constant MMC_RAM_ADR_BITS within this module.  Similarly, the size of the
-- MMC host RAM can be modified by setting the constant HOST_RAM_ADR_BITS.
--
-- For a description of the MMC host registers, please refer to the
-- description given in the sd_controller_8bit_bram entity.
-- The code is contained in the "sd_host_pack.vhd" file.
--
-- For a description of the MMC slave registers, please refer to the
-- description given in the sd_card_emulator, which is an entity instantiated
-- inside the mmc_data_pipe unit.
-- The code is contained in the "sd_card_pack.vhd" file.
--
-- A detailed description of the local registers is given here, below.
--
-- Wouldn't it be nice to have a block diagram showing all of the modules
-- or cores instantiated within this one?  Yes, I believe it would be nice.
-- However, in lieu of a nice ASCII-art pictorial drawing, a few lines of
-- descriptive text will be better than nothing.  Here goes!
------------------------------------------------------------------------------
-- Brief Description of local test functions:
--
--   Within this unit, there is steering logic that selects how the SD/MMC bus
--   is driven and used, with regard to the tri-state output enables.  Actual
--   tri-state buffers are to be implemented at the top level of the FPGA
--   by means of the output enable signals.
--
--   The steering logic allows the SD/MMC host to communicate directly with
--   the sd_card_emulator and RAM/FIFOs contained in the mmc_data_pipe, or it
--   can also be set up to route the signals from the MMC controller host to
--   an external SD/MMC card.
--
--   In like manner, it can be set up so that an external SD/MMC host can talk
--   to the local mmc_data_pipe unit.
--
--   A third option is to disable both the local sd_controller_8bit_bram
--   and the local mmc_data_pipe unit from the bus.  In this configuration,
--   the user of this MMC tester is enabled to "snoop" on the activity and
--   traffic occurring between an external SD/MMC host and its attached card.
--   This requires, of course, some appropriate "interposer" cabling to give
--   the FPGA access to monitor the signals passing along the external SD/MMC
--   bus being monitored.
--
--   In order to keep track of commands on the SD/MMC bus for test and debug,
--   there is a dedicated, stand alone command receiver separate from the MMC
--   host and slave units.  This receiver looks for start bits on the SD/MMC
--   cmd line, and then captures the contents of the transfer, whether it be
--   from the host to the card, or a cmd response from the card to the host.
--   Some responses from an SD/MMC card are 136 bits long, but most responses
--   are 48 bits long.  In the interest of expediency, this special receiver
--   only captures the first 48 bits of a command transfer.  It does, however,
--   refrain from generating error flags for 136 bit long responses, by
--   checking the command index field, which is "111111b" for 136 bit long
--   responses.
--
--   For test and debug purposes, there are some counters, and data capture
--   mechanisms:
--
--     1. A counter that counts command transfer events, filtered based on
--        register settings.
--     2. A data transfer counter, which simply increments each time a data
--        transfer is started.  It is reset whenever a new host to card
--        command transfer of the selected command index type is detected.
--        In reality there are two such counters, a 32 bit one that is
--        accessible via registers, and an 8-bit one ("tlm_d_count") that is
--        used in the telemetry output.  The telemetry one is a relative
--        count; it gets cleared at every command transfer event.
--     3. An SD/MMC traffic reporting "telemetry sender" that emits a stream
--        of information meant to be used as a timestamped archive record
--        of SD/MMC activity.  A new record is emitted each time the command
--        transfer counter increments.  The telemetry records are 12 byte
--        bursts meant to be captured in a FIFO external to this module, or
--        sent out via a UART.
--
--   The format of the telemetry record burst is:
--      Byte Number     Contents       Purpose
--      -----------     --------       -----------------------------------------
--           0          0xEB           Synchronization character
--           1          frame ID       A modulo-256 incrementing value
--           2          tlm_d_count    Data transfers completed, modulo 256
--          3-5         time           time, in microseconds
--          6-11        cmd            48 bits of command or reply
--
------------------------------------------------------------------------------
-- Local Registers
--
-- 0x0300_0020  R0   LED outputs register (READ/WRITE)
--                   This register contains a number of bits meant for
--                   controlling LEDs on the test board, just for fun.  The
--                   number of bits implemented in this register is set by
--                   the SYS_LEDS generic, which should be set in the range
--                   [1..32].  For SYS_LEDS settings less than 32, the unused
--                   bits are the most significant bits, which read as '0'.
--
-- 0x0300_0021  R1   Switch inputs register (READ ONLY)
--                   This register allows reading the status of the switch_i
--                   inputs on the test board.  The number of bits implemented
--                   in this register is set by the SYS_SWITCHES generic,
--                   which should be set in the range [1..32].  For
--                   SYS_SWITCHES settings less than 32, the unused bits are
--                   the most significant bits, which read as '0'.
--
-- 0x0300_0022  R2   MMC Tester Mode (READ/WRITE)
--                   Bit [0] = Slave Enable Reg.  Setting this bit causes the
--                             internal MMC_data_pipe slave to be active
--                             on the SD/MMC bus.
--                   Bit [1] = Host Enable Reg.  Setting this bit causes the
--                             internal sd_controller_8bit_bram unit to
--                             be active on the SD/MMC bus.
--                   Bits [3..2] = "00" (Reserved)
--                   Bit [4] = Slave Enabled (READ ONLY).  This bit is the
--                             logical OR of bit[0] and the slave_en_i input.
--                             Thus we see that the MMC_data_pipe slave can
--                             be made active by the signal input, or the
--                             register bit.
--                   Bit [5] = Host Enabled (READ ONLY).  This bit is the
--                             logical OR of bit[1] and the host_en_i input.
--                             Thus we see that the sd_controller_8bit_bram
--                             host unit can be made active by the signal
--                             input, or the register bit.
--                   Bits [7..6] = "00" (Reserved)
--                   Bit [8] = Telemetry log register read access enable.
--                             When this bit is set, then telemetry log
--                             FIFO contents can be read out via register
--                             R10, and the asynchronous serial transmitter
--                             is disabled.  When clear, the asynchronous
--                             serial transmitter has access to the telemetry
--                             log FIFO instead of register R10.
--
-- 0x0300_0023  R3   Test Command Receiver Filter (READ/WRITE)
--                   Bits [7:0] determine what type of command creates a
--                   "command event."
--                   Except for the setting of 0x80, setting bit [7] means
--                   "capture and count everything," including all command
--                   indices, in both directions.
--                   Example settings:
--                     0x81..0xFF => Capture and count everything.
--                     0x80 => Capture and count nothing. Nada. Zilch.
--                     0x7F => Capture and count all host-to-card commands
--                     0x3F => Capture and count all card-to-host responses
--                     0x59 => Capture and count CMD25 from host-to-card only
--                     0x28 => Capture and count CMD40 R5 responses only
--                     0x27 => Capture and count CMD39 R4 responses only
--                     0x19 => Capture and count CMD25 R1 responses only
--                     0x00 => Capture and count CMD0 R1 responses only
--
--   To explain more clearly how these filter settings work, it is helpful to
--   recall that the first eight bits of the command or response are:
--
--     [0][d][cccccc]
--
--     Where: 0 = start bit (always low)
--            d = direction bit (1 for host to card, 0 for card response)
--            cccccc = command index, ranging from 0 to 56, (or 63 for
--                     long responses and/or 48-bit R3 OCR responses.)
--
--     Therefore, it becomes clear that the operation of the filter is
--     not perfect.  For example, there is no way to act on only R3
--     responses.  However, there is really no need for a perfect
--     filter.  This one is, well, you know, good enough!
--
-- 0x0300_0024  R4   Error-free Command Events (READ/WRITE)
--                   Writing to this register resets it back to zero.
--
-- 0x0300_0025  R5   Command Events with CRC error (READ/WRITE)
--                   Writing to this register resets it back to zero.
--
-- 0x0300_0026  R6   Command Events with stop bit error (READ/WRITE)
--                   Writing to this register resets it back to zero.
--
-- 0x0300_0027  R7   Number of data transfers completed(READ/WRITE)
--                   No means are provided for the tester to determine
--                   what direction the data is flowing over the SD/MMC
--                   data lines.  Therefore, this register simply contains
--                   the total number of transfers started in both
--                   directions.  Writing to this register clears the count
--                   back to zero.  Note that this 32-bit counter is distinct
--                   from the eight bit "tlm_d_count" data transfer counter
--                   in the telemetry, which is a relative count, cleared at
--                   every command transfer event.
--
-- 0x0300_0028  R8   reg_dbus_size (READ/WRITE)
--                     0 => 1 bit data bus transfers
--                     1 => 4 bit data bus transfers
--                     2 => 8 bit data bus transfers
--                   In order for the tester to determine when a data transfer
--                   is completed, so that it can count valid start bits, it
--                   is required to know the data bus size.  Logic is present
--                   to decode when a host-to-card command of index 6 (CMD6),
--                   the SWITCH command, is seen with an argument 0x03B70s00,
--                   where s contains the new data bus size.  This 2-bit
--                   setting is then stored in the reg_dbus_size register,
--                   and used to set the "dstart_wait" parameter used for
--                   ignoring data bus activity during an active data
--                   transfer.  The reg_dbus_size starts out at "00b", and
--                   is expected to change to "01b" for 4-bit SD activity,
--                   and to "10b" for 8-bit MMC activity.
--                   Writing to this register simply clears it back to zero.
--
-- 0x0300_0029  R9   SD/MMC traffic log FIFO fill level (READ/WRITE)
--                   This register returns the number of bytes stored in the
--                   FIFO, awaiting commission to the log archive or telemetry
--                   link.  Writing to this register clears out the FIFO.
--
-- 0x0300_002A  R10  SD/MMC traffic log FIFO read port (READ ONLY)
--                   Telemetry bytes can be read out of the traffic log FIFO
--                   whenever enabled in R2 bit 8.  For convenience in reading
--                   the data, the bytes are packed into 32-bit words.  If R2
--                   bit 8 is clear, then reading this register returns
--                   0x55555555.
--
-- 0x0300_002C  R12  S4 Enables/lines
--
-- 0x0300_002D  R13  MMC_data_pipe write data FIFO fill level (READ/WRITE)
--                   Reading this register returns the number of bytes in
--                   the MMC slave write data FIFO.  The FIFO holds data
--                   that are meant to flow from the MMC slave to the host.
--                   Writing to this register clears the MMC slave
--                   write data FIFO.
--
-- 0x0300_002E  R14  MMC_data_pipe read data FIFO fill level (READ/WRITE)
--                   Reading this register returns the number of bytes in
--                   the MMC slave read data FIFO.  The FIFO holds data
--                   that have been sent from the host to the MMC slave.
--                   Writing to this register clears the MMC slave
--                   read data FIFO.
--
-- 0x0300_002F  R15  MMC_data_pipe FIFO data (READ/WRITE)
--                   Writing to this address loads another byte into
--                   the MMC slave write data FIFO, thereby enqueueing
--                   it to be read by the host from the MMC slave.
--                   However, if the write data FIFO is full, then nothing
--                   happens, and the byte is thrown into the "bit bucket."
--                   Reading from this address removes another byte
--                   of data from the MMC slave read data FIFO, which
--                   was previously delivered from the host to the
--                   MMC slave.
--                   However, if the read data FIFO is empty, then no valid
--                   data is actually delivered.
--
-- 0x0300_0030  R16  Rd:Opcode processor status, 8 lsbs, Wr:SPI data, device, #bytes, 14 bytes data
--
-- 0x3000_0031  R17  Opcode processor opcode counter, 32 bits
--
-- 0x3000_0032  R18  Opcode processor internal state, 8 bits
--
-- 0x3000_0033  R19  Opcode processor overall system state, 16 bits
--
-- 0x3000_0034  R20  Opcode processor overall system mode, 32 bits
--
-- 0x3000_0035  R21  Frequency processor status, 16 msbs, power processor status, 16 lsbs
--
-- 0x3000_0036  R22  Phase processor status, 16 msbs, pulse processor status, 16 lsbs
--
-- 0x3000_0037  R23  Pattern processor status, 16 msbs, opc_response_ready flag, 16 lsbs 
--
------------------------------------------------------------------------------
-- Further Discussion, for the enquiring minds that want to know...
-- The below explanations might in some way repeat what was stated above,
-- but could still be useful.
--
-- Register 2, bit[0] : "slave enable"
--   When high, this bit causes the MMC slave to receive commands, and respond to
--   them.  When this bit is enabled, the MMC slave will drive signals onto mmc_cmd_o
--   and mmc_dat_o, including driving the mmc_cmd_oe_o and mmc_dat_oe_o lines when
--   appropriate.  When this bit is low, the MMC slave cmd input will be held high,
--   and the MMC slave will not have anything to do.
--
-- Register 2, bit[1] : "host enable"
--   When high, this bit causes the MMC host to send commands, and receive responses
--   to them.  When this bit is enabled, the MMC host can drive signals onto mmc_cmd_o
--   and mmc_dat_o, including driving the mmc_cmd_oe_o and mmc_dat_oe_o lines when
--   appropriate.  When this bit is low, the MMC host cmd output will be cut off
--   from affecting mmc_cmd_o, and the MMC host will not be able to influence the
--   MMC bus signals.
--
-- If both of these bits are low, then the only function active in this core is to
-- monitor the mmc commands which occur on the MMC bus due to the action of any
-- outside MMC hosts, such as card readers, which may send commands to an MMC card
-- on the bus.
-- Register 3 can be used to filter on a certain host command index.
--
-- With "host_enable" set, the tester can be used to communicate with a real
-- external SD/MMC device, perhaps for the purpose of reading or writing some
-- sectors, or reading the device registers including the CID, CSD and the 512
-- byte EXT_CSD.
--
-- With "slave_enable" set, on the other hand, an MMC slave can be used with an
-- external SD/MMC card reader.  The MMC slave in this case uses a small amount
-- of RAM, plus a pair of FIFO buffers.  Writing data to the card at addresses
-- below the upper boundary of the RAM, simply places the data into RAM.  Beyond
-- the RAM upper boundary, the data goes into the write FIFO.  Reading is handled
-- the same way.
--
-- An alternative to using the register bits to enable the slave and host, is to
-- use the input signals "slave_en_i" and "host_en_i".  These signals are simply
-- logically ORed with the register bits.
--
-- There are no "buried tri-states" present within this module.  Therefore, each
-- signal, or related bus of signals, has a drive signal provided to allow the
-- tri-state connections to be made at the top level.  The one for the mmc_clk
-- had to be provided because this module can both give and receive an MMC
-- clock signal.
--
-- An asynchronous system controller (async_syscon) is provided here for ease
-- of debugging by humans.  A person can access the entire memory map of this
-- tester by means of simple command line style commands, using an asynchronous
-- serial terminal.
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.dds_pack.all;
use work.fifo_pack.all;
use work.convert_pack.all;
use work.sd_card_pack.all;
use work.sd_host_pack.all;
use work.flancter_pack.all;
use work.mmc_test_pack.all;
use work.block_ram_pack.all;
use work.auto_baud_pack.all;
use work.uart_sqclk_pack.all;
use work.async_syscon_pack.all;

  entity mmc_tester is
  generic (
    SYS_CLK_RATE        : real    := 50000000.0; -- The clock rate at which the FPGA runs
    SYS_LEDS            : natural := 8; -- Number of LED outputs on the board
    SYS_SWITCHES        : natural := 4; -- Number of Switch inputs on the board
    EXT_CSD_INIT_FILE   : string  := "ext_csd_init.txt"; -- Initial contents of EXT_CSD
    HOST_RAM_ADR_BITS   : natural := 14; -- Determines amount of BRAM in MMC host
    MMC_FIFO_DEPTH      : integer := 2048;
    MMC_FILL_LEVEL_BITS : integer := 14; -- Should be at least int(floor(log2(FIFO_DEPTH))+1.0)
    RSP_FILL_LEVEL_BITS : integer := 10; 
    MMC_RAM_ADR_BITS    : integer := 14  -- 16 Kilobytes
  );
  port (

    -- Asynchronous reset
    sys_rst_n      : in  std_logic;
    sys_clk        : in  std_logic;

    -- Asynchronous serial interface
    cmd_i          : in  std_logic;
    resp_o         : out std_logic;

    -- Board related
    switch_i       : in  unsigned(SYS_SWITCHES-1 downto 0);
    led_o          : out unsigned(SYS_LEDS-1 downto 0);

    -- Interface for SD/MMC traffic logging
    -- via asynchronous serial transmission
    tlm_send_i     : in  std_logic;
    tlm_o          : out std_logic;

    -- Tester Function Enables
    slave_en_i     : in  std_logic; -- OR with register bit
    host_en_i      : in  std_logic; -- OR with register bit

    -- SD/MMC card signals
    mmc_clk_i      : in  std_logic;
    mmc_clk_o      : out std_logic;
    mmc_clk_oe_o   : out std_logic;
    mmc_cmd_i      : in  std_logic;
    mmc_cmd_o      : out std_logic;
    mmc_cmd_oe_o   : out std_logic;
    mmc_dat_i      : in  unsigned( 7 downto 0);
    mmc_dat_o      : out unsigned( 7 downto 0);
    mmc_dat_oe_o   : out std_logic;
    mmc_od_mode_o  : out std_logic; -- Open drain mode
    mmc_dat_siz_o  : out unsigned(1 downto 0);
    
    -- SPI debugging connections
    dbg_spi_data0_o     : out unsigned(7 downto 0);
    dbg_spi_data1_o     : out unsigned(7 downto 0);
    dbg_spi_data2_o     : out unsigned(7 downto 0);
    dbg_spi_data3_o     : out unsigned(7 downto 0);
    dbg_spi_data4_o     : out unsigned(7 downto 0);
    dbg_spi_data5_o     : out unsigned(7 downto 0);
    dbg_spi_data6_o     : out unsigned(7 downto 0);
    dbg_spi_data7_o     : out unsigned(7 downto 0);
    dbg_spi_data8_o     : out unsigned(7 downto 0);
    dbg_spi_data9_o     : out unsigned(7 downto 0);
    dbg_spi_dataA_o     : out unsigned(7 downto 0);
    dbg_spi_dataB_o     : out unsigned(7 downto 0);
    dbg_spi_dataC_o     : out unsigned(7 downto 0);
    dbg_spi_dataD_o     : out unsigned(7 downto 0);
    dbg_spi_bytes_io    : inout unsigned(3 downto 0); --bytes to send
    dbg_spi_start_o     : out std_logic;
    dbg_spi_device_o    : out unsigned(2 downto 0); --1=VGA, 2=SYN, 3=DDS, 4=ZMON
    dbg_spi_busy_i      : in  std_logic;            --top level is writing SPI bytes
    dbg_enables_o       : out unsigned(15 downto 0); --toggle various enables/wires

    -- connect opcode processor to mmc fifo's    
    -- MMC read fifo to opcode processor
    opc_fif_dat_o       : out unsigned( 7 downto 0);     -- MMC opcode fifo
    opc_fif_ren_i       : in std_logic;                  -- mmc fifo read enable
    opc_fif_mt_o        : out std_logic;                 -- mmc opcode fifo empty
    opc_rd_cnt_o        : out unsigned(MMC_FILL_LEVEL_BITS-1 downto 0); -- mmc opcode fifo fill level 
    opc_rd_reset_i      : in std_logic;                  -- Synchronous mmc opcode fifo reset
    -- MMC write fifo from opcode processor
    opc_rspf_dat_i      : in  unsigned( 7 downto 0);     -- MMC response fifo
    opc_rspf_we_i       : in std_logic;                  -- response fifo write line             
    opc_rspf_mt_o       : out std_logic;                 -- response fifo empty
    opc_rspf_fl_o       : out std_logic;                 -- response fifo full
    opc_rspf_reset_i    : in std_logic;                  -- Synchronous mmc response fifo reset
    opc_rspf_cnt_o      : out unsigned(MMC_FILL_LEVEL_BITS-1 downto 0); -- mmc response fifo fill level 

    -- Debugging
    opc_oc_cnt_i   : in  unsigned(31 downto 0);         -- LS 16 bits=count of opcodes processed, MS 16 bits=opc fifo level
    opc_status1_i  : in  unsigned(31 downto 0);         -- LS 16 bits=opc status, MS 16-bits=opc_state
    opc_status2_i  : in  unsigned(31 downto 0);         -- rsp_fifo_count__opc_fifo_count
    opc_status3_i  : in  unsigned(31 downto 0);         -- MS 16 bits=MS 8 bits=RSP fifo level, LS 8 bits=OPC fifo level
    sys_status4_i  : in  unsigned(31 downto 0);         -- system frequency setting in Hertz
    sys_status5_i  : in  unsigned(31 downto 0);         -- MS 16 bits=SYN_STAT pin,1=PLL_LOCK, 0=not, LS 12 bits=system power, dBm x 10
    sys_status6_i  : in  unsigned(31 downto 0)          -- LS 16 bits: PTN_Status__PTN_Busy(running) 
  );
  end mmc_tester;

architecture beh of mmc_tester is

  -- Constants
  
    -- async_syscon related
  constant FPGA_PARITY     : integer :=         0; -- 0=none, 1=even, 2=odd
  constant CMD_LINE_SIZE   : natural :=       128; -- Number of bytes in CMD buffer
  constant ADR_DIGITS      : natural :=         8;
  constant DAT_DIGITS      : natural :=         8;
  constant QTY_DIGITS      : natural :=         4;
  constant WDOG_VALUE      : natural :=      2000;
  constant DAT_SIZE        : natural := 4*DAT_DIGITS;
  constant ADR_SIZE        : natural := 4*ADR_DIGITS;

    -- Telemetry related
  constant TLM_FIFO_DEPTH  : natural := 16384;

  -- Signals

    -- autobaud related
  signal baud_clk         : std_logic;
  signal baud_lock        : std_logic;
  signal parity           : unsigned(1 downto 0);
  
    -- async_syscon related
  signal syscon_rst       : std_logic;
  signal fpga_rst_n       : std_logic;
  signal fpga_rst         : std_logic;
  signal syscon_dat_rd    : unsigned(DAT_SIZE-1 downto 0);
  signal syscon_dat_wr    : unsigned(DAT_SIZE-1 downto 0);
  signal syscon_cyc       : std_logic;
  signal syscon_err       : std_logic;
  signal syscon_ack       : std_logic;
  signal syscon_adr       : unsigned(ADR_SIZE-1 downto 0);
  signal syscon_we        : std_logic;

  signal master_bg        : std_logic;
  signal master_adr       : unsigned(ADR_SIZE-1 downto 0);
  signal master_cyc       : std_logic;
  signal master_we        : std_logic;
  signal master_dat_wr    : unsigned(DAT_SIZE-1 downto 0);

    -- related to decoding the address bus
  signal h_reg_sel        : std_logic;
  signal h_reg_ack        : std_logic;
  signal h_reg_dat_rd     : unsigned(31 downto 0);
  signal s_reg_sel        : std_logic;
  signal s_reg_ack        : std_logic;
  signal s_reg_dat_rd     : unsigned(31 downto 0);
  signal h_ram_sel        : std_logic;
  signal h_ram_ack        : std_logic;
  signal h_ram_dat_rd     : unsigned(7 downto 0);
  signal s_ram_sel        : std_logic;
  signal s_ram_ack        : std_logic;
  signal s_ram_dat_rd     : unsigned(7 downto 0);
  signal s_ram_we         : std_logic;
  signal s_fif_sel        : std_logic;

    -------------------------------------------------------
    -- mmc data pipe to opcode processor interface fifo's
  --signal s_fif_dat_rd     : unsigned(7 downto 0);       -- opcode fifo data from mmc
  --signal s_fif_rd         : std_logic;                  -- opcode fifo read enable
  --signal s_fif_rd_empty   : std_logic;
  --signal s_fif_rd_full    : std_logic;
  --signal s_fif_dat_wr     : unsigned(7 downto 0);       -- response fifo to mmc
  signal s_fif_wr         : std_logic;                  -- response fifo write enable
  --signal s_fif_wr_empty   : std_logic;
  --signal s_fif_wr_full    : std_logic;
    ------------------------------------------------------

  signal t_reg_sel        : std_logic; -- Test registers
  signal o_reg_sel        : std_logic; -- Opcode processor registers
  signal o_reg_ack        : std_logic; -- Opcode processor register ack
  signal o_reg_dat_rd     : unsigned(31 downto 0); -- Opcode processor register read data
  signal r_reg_sel        : std_logic; -- SPI debug registers
  signal r_reg_ack        : std_logic; -- SPI debug register ack
  signal r_reg_dat_rd     : unsigned(31 downto 0); -- SPI debug register read data
  signal t_reg_sel_r1     : std_logic;
  signal t_reg_ack        : std_logic; -- Test register ack
  signal t_reg_dat_rd     : unsigned(31 downto 0); -- Test register read data
  
    -- relating to system side BRAM and FIFO access
  signal h_ram_we           : std_logic;
  --signal s_fif_dat_wr_clear : std_logic;
  --signal s_fif_dat_rd_clear : std_logic;

    -- MMC host BRAM interface related
  signal host_bram_clk    : std_logic;
  signal host_bram_dat_wr : unsigned(7 downto 0);
  signal host_bram_dat_rd : unsigned(7 downto 0);
  signal host_bram_adr    : unsigned(31 downto 0);
  signal host_bram_we     : std_logic;
  signal host_bram_cyc    : std_logic;

    -- MMC related
  signal host_cmd_i       : std_logic;
  signal host_cmd_o       : std_logic;
  signal host_cmd_oe_o    : std_logic;
  signal host_dat_i       : unsigned(7 downto 0);
  signal host_dat_o       : unsigned(7 downto 0);
  signal host_dat_oe_o    : std_logic;
  signal host_dat_siz_o   : unsigned(1 downto 0);
  signal host_clk_o_pad   : std_logic;
  signal slave_clk_i      : std_logic;
  signal slave_cmd_i      : std_logic;
  signal slave_cmd_o      : std_logic;
  signal slave_cmd_oe_o   : std_logic;
  signal slave_od_mode_o  : std_logic;
  signal slave_dat_i      : unsigned(7 downto 0);
  signal slave_dat_o      : unsigned(7 downto 0);
  signal slave_dat_oe_o   : std_logic;
  signal slave_dat_siz_o  : unsigned(1 downto 0);
  signal test_cmd_i       : std_logic;

    -- local registers
  signal led_reg          : unsigned(SYS_LEDS-1 downto 0);
  signal slave_en_reg     : std_logic;
  signal host_en_reg      : std_logic;
  signal slave_enable     : std_logic;
  signal host_enable      : std_logic;

    -- local signals for the RX command counter
  signal t_rx_cmd_filter       : unsigned(7 downto 0);
  signal t_rx_cmd_done         : std_logic;
  signal t_rx_cmd_crc_err      : std_logic;
  signal t_rx_cmd_stop_err     : std_logic;
  signal reg_gdcount_clear     : std_logic;
  signal gdcount_clear         : std_logic;
  signal reg_crc_bdcount_clear : std_logic;
  signal crc_bdcount_clear     : std_logic;
  signal reg_stp_bdcount_clear : std_logic;
  signal stp_bdcount_clear     : std_logic;
  signal reg_dat_count_clear   : std_logic;
  signal dat_count_clear       : std_logic;
  signal t_rx_cmd_raw          : unsigned(47 downto 0);
  signal t_rx_cmd_gdcount      : unsigned(31 downto 0);
  signal t_rx_cmd_crc_bdcount  : unsigned(31 downto 0);
  signal t_rx_cmd_stp_bdcount  : unsigned(31 downto 0);
  signal t_rx_dat_count        : unsigned(31 downto 0);
  signal t_rx_capture          : std_logic;

    -- local signals for the data transfer start detector
  signal reg_dbus_size_clear   : std_logic;
  signal dbus_size_clear       : std_logic;
  signal reg_dbus_size         : unsigned(1 downto 0);
  signal dstart_wait           : unsigned(12 downto 0);
  signal dstart_wait_reading   : unsigned(12 downto 0);
  signal dstart_wait_writing   : unsigned(12 downto 0);
  signal write_active          : std_logic;
  signal dbus_active_count     : unsigned(12 downto 0);
  signal mmc_dat_r1            : unsigned(7 downto 0);
  signal mmc_dat_r2            : unsigned(7 downto 0);

    -- local signals for SD/MMC logging telemetry sender
  signal tlm_d_count           : unsigned(7 downto 0);
  signal tlm_fid               : unsigned(7 downto 0); -- Telemetry "Frame ID"
  signal tlm_1us_pulse         : std_logic;
  signal tlm_time              : unsigned(23 downto 0);
  signal tlm_tstamp            : unsigned(23 downto 0);
  signal tlm_fifo_fill_level   : unsigned(15 downto 0);
  signal tlm_fifo_clear        : std_logic;
  signal mmc_tlm_start         : std_logic; -- mmc_clk_i domain
  signal tlm_start             : std_logic; -- sys_clk domain
  signal tlm_fifo_reg_access   : std_logic;
  signal tlm_fifo_dat_rd       : std_logic;
  signal tlm_fifo_dat          : unsigned(7 downto 0);
  signal tlm_r10_dat           : unsigned(31 downto 0);
  signal tlm_code_byte         : unsigned(7 downto 0);
  signal tlm_r10_count         : unsigned(2 downto 0);
  signal tlm_tx_we             : std_logic;
  signal tlm_tx_done           : std_logic;
  signal tlm_stage             : unsigned(4 downto 0);
  signal tlm_keinplatz         : std_logic;
  signal tlm_fifo_leer         : std_logic;
  signal tlm_log_dat           : unsigned(7 downto 0);
  signal tlm_log_dat_we        : std_logic;

    -- local signals for the MMC data pipe
  --signal s_fif_dat_rd_level    : unsigned(MMC_FILL_LEVEL_BITS-1 downto 0);
  --signal s_fif_dat_wr_level    : unsigned(MMC_FILL_LEVEL_BITS-1 downto 0);  -- for debugging?
    
  -- SPI debugging vars
  signal dbg_spi_count         : unsigned(3 downto 0); --down counter
  signal dbg_spi_state         : integer;
  signal dbg_spi_start_l       : std_logic; -- local copy of dbg_spi_start_o

begin

  ------------------------------
  -- This module generates a serial BAUD clock automatically.
  -- The unit synchronizes on the carriage return character, so the user
  -- only needs to press the "enter" key for serial communications to start
  -- working, no matter what BAUD rate and clk_i frequency are used!
  auto_baud1 : auto_baud_with_tracking
    generic map(
      CLOCK_FACTOR    =>            1,  -- Output is this factor times the baud rate
      FPGA_CLKRATE    => SYS_CLK_RATE,  -- FPGA system clock rate
      MIN_BAUDRATE    =>       9600.0,  -- Minimum expected incoming Baud rate
      DELTA_THRESHOLD =>          200   -- Measurement filter constraint.  Smaller = tougher.
    )
    port map( 
       
      sys_rst_n    => sys_rst_n,
      sys_clk      => sys_clk,
      sys_clk_en   => '1',

      -- rate and parity
      rx_parity_i  => parity, -- 0=none, 1=even, 2=odd

      -- serial input
      rx_stream_i  => cmd_i,

      -- Output
      baud_lock_o  => baud_lock,
      baud_clk_o   => baud_clk
    );

  parity <= to_unsigned(FPGA_PARITY,parity'length);

  syscon1 : async_syscon
    generic map (
      ECHO_COMMANDS   =>               1, -- set nonzero to echo back command characters
      ADR_DIGITS      =>      ADR_DIGITS, -- # of hex digits for address
      DAT_DIGITS      =>      DAT_DIGITS, -- # of hex digits for data
      QTY_DIGITS      =>      QTY_DIGITS, -- # of hex digits for quantity
      CMD_BUFFER_SIZE =>   CMD_LINE_SIZE, -- # of chars in the command buffer
      WATCHDOG_VALUE  =>      WDOG_VALUE, -- # of sys_clks before ack is expected
      DISPLAY_FIELDS  =>               4  -- # of fields/line
    )
    port map ( 
       
      sys_rst_n    => sys_rst_n,
      sys_clk      => sys_clk,
      sys_clk_en   => '1',

      -- rate and parity
      parity_i     => parity,
      baud_clk_i   => baud_clk,
      baud_lock_i  => baud_lock,

      -- Serial IO
      cmd_i        => cmd_i,
      resp_o       => resp_o,
      cmd_done_o   => open,

      -- Master Bus IO
      master_bg_i  => master_bg,
      master_adr_i => master_adr,
      master_dat_i => master_dat_wr,
      master_dat_o => open, -- There is no other master to read data...
      master_stb_i => master_cyc,
      master_we_i  => master_we,
      master_br_o  => open, -- async_syscon is the only master in this design.

      -- System Bus IO
      ack_i        => syscon_ack,
      err_i        => syscon_err,
      dat_i        => syscon_dat_rd,
      dat_o        => syscon_dat_wr,
      rst_o        => syscon_rst,
      stb_o        => open,
      cyc_o        => syscon_cyc,
      adr_o        => syscon_adr,
      we_o         => syscon_we
    );

  -- Combine the input reset with the async_syscon bus reset
  fpga_rst_n <= '0' when (sys_rst_n='0' or syscon_rst='1') else '1';
  fpga_rst   <= '1' when (sys_rst_n='0' or syscon_rst='1') else '0';

  -- Since there is no bus master besides the async_syscon, take care of those signals
  master_bg     <= '1';
  master_cyc    <= '0';
  master_dat_wr <= (others=>'0');
  master_we     <= '0';
  master_adr    <= (others=>'0');

  h_reg_sel <= '1' when syscon_cyc='1' and syscon_adr(31 downto 4)=16#0300000# else '0';
  s_reg_sel <= '1' when syscon_cyc='1' and syscon_adr(31 downto 4)=16#0300001# else '0';
  t_reg_sel <= '1' when syscon_cyc='1' and syscon_adr(31 downto 4)=16#0300002# else '0';
  o_reg_sel <= '1' when syscon_cyc='1' and syscon_adr(31 downto 4)=16#0300003# else '0';
  r_reg_sel <= '1' when syscon_cyc='1' and syscon_adr(31 downto 4)=16#0300004# else '0';
  h_ram_sel <= '1' when syscon_cyc='1' and syscon_adr(31 downto 24)=16#04# and syscon_adr(23 downto HOST_RAM_ADR_BITS)=0 else '0';
  s_ram_sel <= '1' when syscon_cyc='1' and syscon_adr(31 downto 24)=16#05# and syscon_adr(23 downto MMC_RAM_ADR_BITS)=0 else '0';

  syscon_dat_rd <= h_reg_dat_rd              when h_reg_sel='1' else
                   s_reg_dat_rd              when s_reg_sel='1' else
                   t_reg_dat_rd              when t_reg_sel='1' else
                   o_reg_dat_rd              when o_reg_sel='1' else
                   r_reg_dat_rd              when r_reg_sel='1' else
                   u_resize(h_ram_dat_rd,32) when h_ram_sel='1' else
                   u_resize(s_ram_dat_rd,32) when s_ram_sel='1' else
                   str2u("12340000",32);

  syscon_ack <= h_reg_ack when h_reg_sel='1' else
                s_reg_ack when s_reg_sel='1' else
                t_reg_ack when t_reg_sel='1' else
                o_reg_ack when o_reg_sel='1' else
                r_reg_ack when r_reg_sel='1' else
                h_ram_ack when h_ram_sel='1' else
                s_ram_ack when s_ram_sel='1' else
                '0';

  syscon_err <= '0' when h_reg_sel='1' or s_reg_sel='1' or t_reg_sel='1' or 
                 o_reg_sel='1' or r_reg_sel='1' or h_ram_sel='1' or s_ram_sel='1' else '1';

  -- Select data for Local Register Reads
  with to_integer(syscon_adr(3 downto 0)) select
  t_reg_dat_rd <=
    u_resize(led_reg,32)                           when 16#0#,
    u_resize(switch_i,32)                          when 16#1#,
    to_unsigned(0,23) & tlm_fifo_reg_access &
      "00" & host_enable & slave_enable &
      "00" & host_en_reg & slave_en_reg            when 16#2#,
    u_resize(t_rx_cmd_filter,32)                   when 16#3#,
    u_resize(t_rx_cmd_gdcount,32)                  when 16#4#,
    u_resize(t_rx_cmd_crc_bdcount,32)              when 16#5#,
    u_resize(t_rx_cmd_stp_bdcount,32)              when 16#6#,
    u_resize(t_rx_dat_count,32)                    when 16#7#,
    u_resize(reg_dbus_size,32)                     when 16#8#,
    u_resize(tlm_fifo_fill_level,32)               when 16#9#,
    u_resize(tlm_r10_dat,32)                       when 16#A#,
    --u_resize(s_fif_dat_rd,32)                      when 16#F#,
    str2u("51514343",32)                           when others;

  with to_integer(syscon_adr(3 downto 0)) select
  o_reg_dat_rd <=
    sys_status6_i                                  when 16#9#,      -- LS 16 bits=
    sys_status5_i                                  when 16#A#,      -- LS 12 bits=system power, dBm x 10
    sys_status4_i                                  when 16#B#,      -- system frequency setting in Hertz
    opc_status3_i                                  when 16#C#,      -- 1st_opcode__last_opcode in lower 16 bits
    opc_status2_i                                  when 16#D#,      -- rsp_fifo_count__opc_fifo_count
    opc_status1_i                                  when 16#E#,      -- opc_state__opc_status
    u_resize(opc_oc_cnt_i,32)                      when 16#F#,      -- opcodes processed
  str2u("51514343",32)                             when others;
  
 -- Handle Local Register Writes
  process(sys_rst_n,sys_clk)
  begin
    if (sys_rst_n='0') then
      --led_reg <= (others=>'0');
      t_rx_cmd_filter  <= (others=>'1'); -- Default is to count everything
      reg_gdcount_clear <= '0';
      reg_crc_bdcount_clear <= '0';
      reg_stp_bdcount_clear <= '0';
      reg_dat_count_clear <= '0';
      reg_dbus_size_clear <= '0';
      --s_fif_dat_wr_clear <= '0';
      --s_fif_dat_rd_clear <= '0';
      t_reg_sel_r1 <= '0';
      host_en_reg <= '0';
      slave_en_reg <= '0';
      tlm_fifo_reg_access <= '0';
      
      -- SPI debugging
      dbg_spi_bytes_io <= to_unsigned(0, dbg_spi_bytes_io'length);
      dbg_spi_start_l <= '0';
      dbg_spi_device_o <= to_unsigned(0, dbg_spi_device_o'length);
      dbg_enables_o <= to_unsigned(0, dbg_enables_o'length);
      dbg_spi_state <= 0;
      
    elsif (sys_clk'event and sys_clk='1') then
      -- Default values
      reg_gdcount_clear <= '0';
      reg_crc_bdcount_clear <= '0';
      reg_stp_bdcount_clear <= '0';
      reg_dat_count_clear <= '0';
      reg_dbus_size_clear <= '0';
      --s_fif_dat_wr_clear <= '0';
      --s_fif_dat_rd_clear <= '0';
      -- Register writes have the highest priority
      t_reg_sel_r1 <= t_reg_sel;
      if (t_reg_sel='1' and t_reg_sel_r1='0' and syscon_we='1') then
        case to_integer(syscon_adr(3 downto 0)) is
          when 16#0# =>
            --led_reg <= syscon_dat_wr(SYS_LEDS-1 downto 0);
          when 16#2# =>
            slave_en_reg <= syscon_dat_wr(0);
            host_en_reg  <= syscon_dat_wr(1);
            tlm_fifo_reg_access <= syscon_dat_wr(8);
          when 16#3# =>
            t_rx_cmd_filter <= syscon_dat_wr(7 downto 0);
          -- Clearing the counters must be done in the mmc_clk domain...
          -- Flancters are used to pass the signals into the other clock
          -- domain.
          when 16#4# =>
            reg_gdcount_clear <= '1';
          when 16#5# =>
            reg_crc_bdcount_clear <= '1';
          when 16#6# =>
            reg_stp_bdcount_clear <= '1';
          when 16#7# =>
            reg_dat_count_clear <= '1';
          when 16#8# =>
            reg_dbus_size_clear <= '1';
          -- Register 9 writes implemented at the FIFO
          when 16#C# =>
             dbg_enables_o <= syscon_dat_wr(15 downto 0);
          --when 16#E# =>
            --opc_rspf_reset_i <= syscon_dat_wr(0);     --s_fif_dat_wr_clear <= syscon_dat_wr(0);
            --opc_rd_reset_i <= syscon_dat_wr(1);     --s_fif_dat_rd_clear <= syscon_dat_wr(1);
          when others =>
            null;
        end case;
      end if;
      
--      if (o_reg_sel='1' and syscon_we='1') then
--        case to_integer(syscon_adr(3 downto 0)) is
--          when 16#0# =>
--            bkd_opc_load_new <= '0';
--            bkd_opc_dat0_o <= syscon_dat_wr(31 downto 0);
--          when 16#1# =>
--            bkd_opc_dat1_o <= syscon_dat_wr(31 downto 0);
--          when 16#F# =>
--            bkd_opc_datF_o <= syscon_dat_wr(31 downto 0);
--            bkd_opc_load_new <= '1';
--          when others =>
--            null;
--          end case;
--      elsif (bkd_opc_load_ack='1') then
--        bkd_opc_load_new <= '0';
--      end if;            

      -- spi debug, SPI debug register writes, 03000040 x y z ...
      if (r_reg_sel='1' and syscon_we='1') then
        case to_integer(syscon_adr(3 downto 0)) is
          when 16#0# =>
            dbg_spi_device_o <= syscon_dat_wr(2 downto 0);
            dbg_spi_start_l <= '0';
          when 16#1# =>
            dbg_spi_bytes_io <= syscon_dat_wr(3 downto 0);
            dbg_spi_count <= to_unsigned(1, dbg_spi_count'length);
          when 16#2# =>
            dbg_spi_data0_o <= syscon_dat_wr(7 downto 0);
            if(dbg_spi_count = dbg_spi_bytes_io) then
              dbg_spi_start_l <= '1';
            else
              dbg_spi_count <= dbg_spi_count + 1;
            end if;
          when 16#3# =>
            dbg_spi_data1_o <= syscon_dat_wr(7 downto 0);
            if(dbg_spi_count = dbg_spi_bytes_io) then
              dbg_spi_start_l <= '1';
            else
              dbg_spi_count <= dbg_spi_count + 1;
            end if;
          when 16#4# =>
            dbg_spi_data2_o <= syscon_dat_wr(7 downto 0);
            if(dbg_spi_count = dbg_spi_bytes_io) then
              dbg_spi_start_l <= '1';
            else
              dbg_spi_count <= dbg_spi_count + 1;
            end if;
          when 16#5# =>
            dbg_spi_data3_o <= syscon_dat_wr(7 downto 0);
            if(dbg_spi_count = dbg_spi_bytes_io) then
              dbg_spi_start_l <= '1';
            else
              dbg_spi_count <= dbg_spi_count + 1;
            end if;
          when 16#6# =>
            dbg_spi_data4_o <= syscon_dat_wr(7 downto 0);
            if(dbg_spi_count = dbg_spi_bytes_io) then
              dbg_spi_start_l <= '1';
            else
              dbg_spi_count <= dbg_spi_count + 1;
            end if;
          when 16#7# =>
            dbg_spi_data5_o <= syscon_dat_wr(7 downto 0);
            if(dbg_spi_count = dbg_spi_bytes_io) then
              dbg_spi_start_l <= '1';
            else
              dbg_spi_count <= dbg_spi_count + 1;
            end if;
          when 16#8# =>
            dbg_spi_data6_o <= syscon_dat_wr(7 downto 0);
            if(dbg_spi_count = dbg_spi_bytes_io) then
              dbg_spi_start_l <= '1';
            else
              dbg_spi_count <= dbg_spi_count + 1;
            end if;
          when 16#9# =>
            dbg_spi_data7_o <= syscon_dat_wr(7 downto 0);
            if(dbg_spi_count = dbg_spi_bytes_io) then
              dbg_spi_start_l <= '1';
            else
              dbg_spi_count <= dbg_spi_count + 1;
            end if;
          when 16#A# =>
            dbg_spi_data8_o <= syscon_dat_wr(7 downto 0);
            if(dbg_spi_count = dbg_spi_bytes_io) then
              dbg_spi_start_l <= '1';
            else
              dbg_spi_count <= dbg_spi_count + 1;
            end if;
          when 16#B# =>
            dbg_spi_data9_o <= syscon_dat_wr(7 downto 0);
            if(dbg_spi_count = dbg_spi_bytes_io) then
              dbg_spi_start_l <= '1';
            else
              dbg_spi_count <= dbg_spi_count + 1;
            end if;
          when 16#C# =>
            dbg_spi_dataA_o <= syscon_dat_wr(7 downto 0);
            if(dbg_spi_count = dbg_spi_bytes_io) then
              dbg_spi_start_l <= '1';
            else
              dbg_spi_count <= dbg_spi_count + 1;
            end if;
          when 16#D# =>
            dbg_spi_dataB_o <= syscon_dat_wr(7 downto 0);
            if(dbg_spi_count = dbg_spi_bytes_io) then
              dbg_spi_start_l <= '1';
            else
              dbg_spi_count <= dbg_spi_count + 1;
            end if;
          when 16#E# =>
            dbg_spi_dataC_o <= syscon_dat_wr(7 downto 0);
            if(dbg_spi_count = dbg_spi_bytes_io) then
              dbg_spi_start_l <= '1';
            else
              dbg_spi_count <= dbg_spi_count + 1;
            end if;
          when 16#F# =>
            dbg_spi_dataD_o <= syscon_dat_wr(7 downto 0);
            dbg_spi_start_l <= '1';
          when others =>
            null;
          end case;
      end if;            

      --If Debug SPI just started, clear start pulse, device #
      if(dbg_spi_start_l = '1' and dbg_spi_busy_i = '1') then
        dbg_spi_start_l <= '0';     -- clear start
      end if;

    end if;
  end process;
  -- Provide test register acknowledge
  t_reg_ack <= '1' when syscon_adr(3 downto 0)=10 and tlm_r10_count=1 else
               '1' when syscon_adr(3 downto 0)/=10 and t_reg_sel='1' and t_reg_sel_r1='0' else
               '0';
  o_reg_ack <= o_reg_sel;
  r_reg_ack <= r_reg_sel;

  -- assign output based on local value
  dbg_spi_start_o <= dbg_spi_start_l;

  -- Provide led_reg as output to external LEDs
  led_o <= led_reg;

  -- Handle Reads from TLM FIFO
  -- Data is shifted in on counts 5,4,3,2.
  -- The acknowledge pulse is given on count 1.
  -- Count 0 is the quiescent condition.
  process(sys_rst_n,sys_clk)
  begin
    if (sys_rst_n='0') then
      tlm_r10_dat   <= (others=>'0');
      tlm_r10_count <= (others=>'0');
    elsif (sys_clk'event and sys_clk='1') then
      -- Handle the "byte shift" register counter
      if (tlm_r10_count>0) then
        tlm_r10_count <= tlm_r10_count-1;
      end if;
      -- Implement the "byte shift" data register
      if (tlm_r10_count<6 and tlm_r10_count>1) then
        if (tlm_fifo_reg_access='1') then
          tlm_r10_dat <= tlm_r10_dat(23 downto 0) & tlm_fifo_dat;
        else
          tlm_r10_dat <= tlm_r10_dat(23 downto 0) & "01010101";
        end if;
      end if;
      -- Charge the countdown when a read is initiated
      if (t_reg_sel='1' and t_reg_sel_r1='0' and syscon_we='0' and syscon_adr(3 downto 0)=16#A#) then
        tlm_r10_count <= to_unsigned(6,tlm_r10_count'length);
      end if;
    end if;
  end process;


  t_rx_gdcount_reset : flancter_rising_pulseout
  port map(
    async_rst_n => sys_rst_n,
    set_clk     => sys_clk,
    set         => reg_gdcount_clear,
    reset_clk   => mmc_clk_i,
    reset       => gdcount_clear,
    pulse_s_o   => open,
    pulse_r_o   => gdcount_clear,
    flag_o      => open
  );

  t_rx_crc_bdcount_reset : flancter_rising_pulseout
  port map(
    async_rst_n => sys_rst_n,
    set_clk     => sys_clk,
    set         => reg_crc_bdcount_clear,
    reset_clk   => mmc_clk_i,
    reset       => crc_bdcount_clear,
    pulse_s_o   => open,
    pulse_r_o   => crc_bdcount_clear,
    flag_o      => open
  );

  t_rx_stp_bdcount_reset : flancter_rising_pulseout
  port map(
    async_rst_n => sys_rst_n,
    set_clk     => sys_clk,
    set         => reg_stp_bdcount_clear,
    reset_clk   => mmc_clk_i,
    reset       => stp_bdcount_clear,
    pulse_s_o   => open,
    pulse_r_o   => stp_bdcount_clear,
    flag_o      => open
  );

  t_rx_dat_count_reset : flancter_rising_pulseout
  port map(
    async_rst_n => sys_rst_n,
    set_clk     => sys_clk,
    set         => reg_dat_count_clear,
    reset_clk   => mmc_clk_i,
    reset       => dat_count_clear,
    pulse_s_o   => open,
    pulse_r_o   => dat_count_clear,
    flag_o      => open
  );

  reg_dbus_size_reset : flancter_rising_pulseout
  port map(
    async_rst_n => sys_rst_n,
    set_clk     => sys_clk,
    set         => reg_dbus_size_clear,
    reset_clk   => mmc_clk_i,
    reset       => dbus_size_clear,
    pulse_s_o   => open,
    pulse_r_o   => dbus_size_clear,
    flag_o      => open
  );

  -- Use a separate command receiver to count the number of received
  -- commands.  A register setting allows counting only commands of
  -- a certain index and/or direction, otherwise all commands can be counted.
  -- Separate counts of good/bad commands are kept.
  test_cmd_receiver : mmc_test_cmd_rx
  port map(
    -- Asynchronous reset
    sys_rst_n   => sys_rst_n,
    -- SD/MMC card command signals
    sd_clk_i    => mmc_clk_i,
    sd_cmd_i    => test_cmd_i,
    -- Command outputs
    cmd_raw_o   => t_rx_cmd_raw,
    -- Status and done indicator
    cmd_done_o  => t_rx_cmd_done,
    crc_err_o   => t_rx_cmd_crc_err,
    stop_err_o  => t_rx_cmd_stop_err
  );
  -- Telemetry code byte currently only shows the direction of the transfer
  tlm_code_byte <= "11111111" when t_rx_cmd_raw(47 downto 46)="01" else "00000000";

  -- Handle counting received commands, whether good or bad
  -- Also, count data transfer starts
  process(sys_rst_n,mmc_clk_i)
  begin
    if (sys_rst_n='0') then
      t_rx_cmd_gdcount <= (others=>'0');
      t_rx_cmd_crc_bdcount <= (others=>'0');
      t_rx_cmd_stp_bdcount <= (others=>'0');
      t_rx_dat_count <= (others=>'0');
      dbus_active_count <= (others=>'0');
      reg_dbus_size <= "00";
      mmc_dat_r1 <= (others=>'0');
      mmc_dat_r2 <= (others=>'0');
      tlm_d_count <= (others=>'0');
      mmc_tlm_start <= '0';
    elsif (mmc_clk_i'event and mmc_clk_i='1') then
      -- Default values
      mmc_tlm_start <= '0';
      -- Data counters are incremented at each data transfer "start bit"
      -- An attempt is made to track the current data bus size, by catching
      -- CMD6 (SWITCH) commands which write to the EXT_CSD contents at
      -- location offset 183d (0xB7).  Based on the current bus size, a
      -- dstart_wait value is derived, and used to ignore activity on the
      -- SD/MMC data bus during the transfer, thereby guaranteeing that only
      -- real start bits are counted.
      if (t_rx_cmd_done='1' and (t_rx_cmd_raw(47 downto 40)=16#46#)
          and t_rx_cmd_crc_err='0' and t_rx_cmd_stop_err='0') then
        if (t_rx_cmd_raw(31 downto 24)=16#B7#) then
          -- Try to handle all EXT_CSD access modes...
          if (t_rx_cmd_raw(33 downto 32)="11") then -- Write byte mode
            reg_dbus_size <= t_rx_cmd_raw(17 downto 16);
          end if;
          if (t_rx_cmd_raw(33 downto 32)="10") then -- Clear bits mode
            reg_dbus_size <= reg_dbus_size and not t_rx_cmd_raw(17 downto 16);
          end if;
          if (t_rx_cmd_raw(33 downto 32)="01") then -- Set bits mode
            reg_dbus_size <= reg_dbus_size or t_rx_cmd_raw(17 downto 16);
          end if;
        end if;
      end if;
      -- Store previous data, for SD/MMC data bus start bit detection
      mmc_dat_r1 <= mmc_dat_i;
      mmc_dat_r2 <= mmc_dat_r1;
      -- Handle decrementing the data active count down
      if (dbus_active_count>0) then
        dbus_active_count <= dbus_active_count-1;
      end if;
      -- Detect start bits, according to reg_dbus_size setting
      -- The dstart_wait value is used to ignore further activity until
      -- after the data transfer is completed.
      if (dbus_active_count=0) then
        if (reg_dbus_size=0) then
          if (mmc_dat_r2(0)='1' and mmc_dat_r1(0)='0') then
            t_rx_dat_count <= t_rx_dat_count+1;
            tlm_d_count <= tlm_d_count+1;
            dbus_active_count <= dstart_wait;
          end if;
        end if;
        if (reg_dbus_size=1) then
          if (mmc_dat_r2(3 downto 0)="1111" and mmc_dat_r1(3 downto 0)="0000") then
            t_rx_dat_count <= t_rx_dat_count+1;
            tlm_d_count <= tlm_d_count+1;
            dbus_active_count <= dstart_wait;
          end if;
        end if;
        if (reg_dbus_size=2) then
          if (mmc_dat_r2="11111111" and mmc_dat_r1="00000000") then
            t_rx_dat_count <= t_rx_dat_count+1;
            tlm_d_count <= tlm_d_count+1;
            dbus_active_count <= dstart_wait;
          end if;
        end if;
      end if;
      if (t_rx_capture='1') then
        mmc_tlm_start <= '1';
        if (t_rx_cmd_crc_err='0' and t_rx_cmd_stop_err='0') then
          t_rx_cmd_gdcount <= t_rx_cmd_gdcount+1;
        else
          if (t_rx_cmd_crc_err='1') then
            t_rx_cmd_crc_bdcount <= t_rx_cmd_crc_bdcount+1;
          end if;
          if (t_rx_cmd_stop_err='1') then
            t_rx_cmd_stp_bdcount <= t_rx_cmd_stp_bdcount+1;
          end if;
        end if;
      end if;
      -- Clearing the counters is given priority over incrementing them
      if (gdcount_clear='1') then
        t_rx_cmd_gdcount <= (others=>'0');
      end if;
      if (crc_bdcount_clear='1') then
        t_rx_cmd_crc_bdcount <= (others=>'0');
      end if;
      if (stp_bdcount_clear='1') then
        t_rx_cmd_stp_bdcount <= (others=>'0');
      end if;
      if (dat_count_clear='1') then
        t_rx_dat_count <= (others=>'0');
      end if;
      -- Clearing the reg_dbus_size is done in this clock domain
      if (dbus_size_clear='1') then
        reg_dbus_size <= (others=>'0');
      end if;
    end if;
  end process;
  -- Create a signal that, when high, indicates that the SD/MMC command
  -- event filter criteria have been met.
--  t_rx_capture <= '1' when (t_rx_cmd_done='1' and t_rx_cmd_filter>"10000000") else
--                  '1' when (t_rx_cmd_done='1' and t_rx_cmd_filter=t_rx_cmd_raw(47 downto 40)) else
--                  '0';
-- John C sent this capture filter bugfix 24-Jun-2017
    t_rx_capture <= '1' when (t_rx_cmd_done='1' and t_rx_cmd_filter>"10000000") else
                  '1' when (t_rx_cmd_done='1' and t_rx_cmd_filter(6)=t_rx_cmd_raw(46) and t_rx_cmd_filter(5 downto 0)="111111") else
                  '1' when (t_rx_cmd_done='1' and t_rx_cmd_filter=t_rx_cmd_raw(47 downto 40)) else
                  '0';

  -- Derive dstart_wait values, used in detecting valid data transfer
  -- start bits.  Tune these values as needed, based on the sector
  -- size.
  write_active <= '1' when ((t_rx_cmd_raw(45 downto 40)=24) or (t_rx_cmd_raw(45 downto 40)=25)) else '0';
  dstart_wait <= dstart_wait_writing when (write_active='1') else dstart_wait_reading;
  -- When reading, include sector, plus start, CRC-16 and stop bits
  with (reg_dbus_size) select
  dstart_wait_reading <=
    to_unsigned(4096+2+16,dstart_wait'length) when "00",
    to_unsigned(1024+2+16,dstart_wait'length) when "01",
    to_unsigned( 512+2+16,dstart_wait'length) when "10",
    to_unsigned( 512+2+16,dstart_wait'length) when others;
  -- When writing, include sector, plus start, CRC-16, stop and CRC response token (2 turnaround+5 bits)
  with (reg_dbus_size) select
  dstart_wait_writing <=
    to_unsigned(4096+2+16+7,dstart_wait'length) when "00",
    to_unsigned(1024+2+16+7,dstart_wait'length) when "01",
    to_unsigned( 512+2+16+7,dstart_wait'length) when "10",
    to_unsigned( 512+2+16+7,dstart_wait'length) when others;

  -------------------------------------------------------------------------
  -- SD/MMC transaction telemetry sending logic
  -- For logging activity on the SD/MMC bus

  -- Create a 24 bit time counter with 1 microsecond resolution
  -- This is done in the system clock domain.
  tlm_1us_unit : dds_constant_squarewave
    generic map(
      OUTPUT_FREQ  => 1000000.0,    -- Desired output frequency
      SYS_CLK_RATE => SYS_CLK_RATE, -- underlying clock rate
      ACC_BITS     => 32 -- Bit width of DDS phase accumulator
    )
    port map(
      sys_rst_n    => sys_rst_n,
      sys_clk      => sys_clk,
      sys_clk_en   => '1',

      -- Output
      pulse_o      => tlm_1us_pulse,
      squarewave_o => open
    );
  process(sys_rst_n,sys_clk)
  begin
    if (sys_rst_n='0') then
      tlm_time <= (others=>'0');
    elsif (sys_clk'event and sys_clk='1') then
      if (tlm_1us_pulse='1') then
        tlm_time <= tlm_time+1;
      end if;
    end if;
  end process;
  -- Implement a small FIFO to accomodate the "burstiness" of the
  -- telemetry data, as compared with the more plodding consumption
  -- of it at the other end...
  tlm_fifo_unit : swiss_army_fifo
  generic map(
    USE_BRAM         => 1, -- Set to nonzero value for BRAM, zero for distributed RAM
    WIDTH            => 8,
    DEPTH            => TLM_FIFO_DEPTH,
    FILL_LEVEL_BITS  => tlm_fifo_fill_level'length, -- Should be at least int(floor(log2(DEPTH))+1.0)
    PF_FULL_POINT    => TLM_FIFO_DEPTH-16,
    PF_FLAG_POINT    => (TLM_FIFO_DEPTH/2),
    PF_EMPTY_POINT   => 1
  )
  port map(
    sys_rst_n       => sys_rst_n, -- Asynchronous
    sys_clk         => sys_clk,
    sys_clk_en      => '1',

    reset_i         => tlm_fifo_clear, -- Synchronous

    fifo_wr_i       => tlm_log_dat_we,
    fifo_din        => tlm_log_dat,

    fifo_rd_i       => tlm_fifo_dat_rd,
    fifo_dout       => tlm_fifo_dat,

    fifo_fill_level => tlm_fifo_fill_level,
    fifo_full       => open,
    fifo_empty      => tlm_fifo_leer,
    fifo_pf_full    => tlm_keinplatz,
    fifo_pf_flag    => open,
    fifo_pf_empty   => open
  );
  tlm_fifo_clear <= '1' when (t_reg_sel='1' and t_reg_sel_r1='0' and syscon_we='1' and syscon_adr(3 downto 0)=16#9#) else '0';
  tlm_fifo_dat_rd <= '1' when (tlm_fifo_reg_access='1' and tlm_r10_count>2) else
                     '1' when (tlm_fifo_reg_access='0' and tlm_tx_we='1') else
                     '0';
  -- Create an asynchronous transmitter that sends out a stream of
  -- telemetry information, when enabled.
  -- The baud clock pulse feeding the async_syscon unit is also used here
  tlm_tx_unit : async_tx_sqclk
    port map(
      sys_rst_n    => sys_rst_n,
      sys_clk      => sys_clk,
      sys_clk_en   => baud_lock, -- Do not transmit unless Baud rate is settled.

      -- rate and parity
      tx_parity_i  => "00", -- 0=none, 1=even, 2 or 3=odd
      tx_clk_i     => baud_clk,

      -- serial output
      tx_stream    => tlm_o,

      -- control and status
      tx_wr_i      => tlm_tx_we,        -- Starts Transmit
      tx_dat_i     => tlm_fifo_dat,
      tx_done_o    => tlm_tx_done
    );
  -- Automatically read out the contents of the FIFO, when enabled
  tlm_tx_we <= '1' when baud_lock='1' and tlm_tx_done='1' and tlm_send_i='1'
                   and tlm_fifo_leer='0' and tlm_fifo_reg_access='0' else '0';

  -- This is the sequencer that coordinates the creation of a new
  -- telemetry log record, to be stuffed into the telemetry log FIFO
  process(sys_rst_n,sys_clk)
  begin
    if (sys_rst_n='0') then
      tlm_stage  <= (others=>'0');
      tlm_tstamp <= (others=>'0');
      tlm_fid    <= (others=>'1');
    elsif (sys_clk'event and sys_clk='1') then
      -- Handle the sequence step down counter
      if (tlm_stage>0) then
        tlm_stage <= tlm_stage-1;
      end if;
      -- Catch start signal.  If the FIFO has room
      -- for at least one more complete record, then
      -- capture timestamp and begin.
      if (tlm_start='1' and tlm_keinplatz='0') then
        tlm_tstamp <= tlm_time;
        tlm_fid <= tlm_fid+1;
        tlm_stage <= to_unsigned(16,tlm_stage'length);
      end if;
    end if;
  end process;
  -- When active, write a new data byte every clock cycle
  tlm_log_dat_we <= '1' when tlm_stage>0 else '0';

  -- Select data for Local Register Reads
  with to_integer(tlm_stage) select
  tlm_log_dat <=
    to_unsigned(16#FE#,8)             when 16,
    to_unsigned(16#6B#,8)             when 15,
    to_unsigned(16#28#,8)             when 14,
    to_unsigned(16#40#,8)             when 13,
    tlm_fid                           when 12,
    tlm_tstamp(23 downto 16)          when 11,
    tlm_tstamp(15 downto 8)           when 10,
    tlm_tstamp( 7 downto 0)           when  9,
    tlm_d_count                       when  8,
    tlm_code_byte                     when  7,
    "00" & t_rx_cmd_raw(45 downto 40) when  6, -- Upper 2 MSBs determine tlm_code_byte
    t_rx_cmd_raw(39 downto 32)        when  5,
    t_rx_cmd_raw(31 downto 24)        when  4,
    t_rx_cmd_raw(23 downto 16)        when  3,
    t_rx_cmd_raw(15 downto  8)        when  2,
    t_rx_cmd_raw( 7 downto  0)        when  1,
    to_unsigned(16#55#,8)             when others;

  -- Use safe clock domain crossing for the signal that starts the process
  -- of emitting a new telemetry record, so we don't miss anything.
  tlm_start_pulser : flancter_rising_pulseout
  port map(
    async_rst_n => sys_rst_n,
    set_clk     => mmc_clk_i,
    set         => mmc_tlm_start,
    reset_clk   => sys_clk,
    reset       => tlm_start,
    pulse_s_o   => open,
    pulse_r_o   => tlm_start,
    flag_o      => open
  );


  -------------------------------------------------------------------------
  -- Create a Block RAM which the SD/MMC controller uses as a data
  -- storage area.
  -- The 'A' port is attached to the simulation bus controller
  -- The 'B' port is attached to the mmc controller
  h_ram_we <= '1' when h_ram_sel='1' and syscon_we='1' else '0';
  host_0_bram_0 : swiss_army_ram
    generic map(
      USE_BRAM  => 1, -- Set to nonzero value for BRAM, zero for distributed RAM
      WRITETHRU => 1, -- Set to nonzero value for writethrough mode
      USE_FILE  => 1, -- Set to nonzero value to use INIT_FILE
      INIT_VAL  => 16#00#, -- Value used when INIT_FILE is not used
      INIT_SEL  => 0, -- Selects which segment of (larger) INIT_FILE to use
      INIT_FILE => "host_ram_init.txt", -- ASCII hexadecimal initialization file name
      FIL_WIDTH => 32, -- Bit width of init file lines
      ADR_WIDTH => HOST_RAM_ADR_BITS,
      DAT_WIDTH =>  8
    )
    port map(
      clk_a    => sys_clk,
      adr_a_i  => syscon_adr(13 downto 0),
      we_a_i   => h_ram_we,
      en_a_i   => std_logic'('1'),
      dat_a_i  => syscon_dat_wr(7 downto 0),
      dat_a_o  => h_ram_dat_rd,

      clk_b    => host_bram_clk,
      adr_b_i  => host_bram_adr(HOST_RAM_ADR_BITS-1 downto 0),
      we_b_i   => host_bram_we,
      en_b_i   => std_logic'('1'),
      dat_b_i  => host_bram_dat_wr,
      dat_b_o  => host_bram_dat_rd
    );
-- system side BRAM ack signal needs to be delayed by 1 cycle,
-- to allow for the BRAM to respond to the given address.
process(sys_rst_n,sys_clk)
begin
  if (sys_rst_n='0') then
    h_ram_ack <= '0';
  elsif (sys_clk'event and sys_clk='1') then
    h_ram_ack <= h_ram_sel;
  end if;
end process;

  sd_host_0 : sd_controller_8bit_bram
  port map(
    -- WISHBONE common
    wb_clk_i     => sys_clk,
    wb_rst_i     => fpga_rst,
    -- WISHBONE slave (register interface)
    wb_dat_i     => syscon_dat_wr,
    wb_dat_o     => h_reg_dat_rd,
    wb_adr_i     => syscon_adr(3 downto 0),
    wb_we_i      => syscon_we,
    wb_cyc_i     => h_reg_sel,
    wb_ack_o     => h_reg_ack,
    -- Dedicated BRAM port without acknowledge.
    -- Access cycles must complete immediately.
    -- (data to cross clock domains by this dual-ported BRAM)
    bram_clk_o   => host_bram_clk, -- Same as sd_clk_o_pad
    bram_dat_o   => host_bram_dat_wr,
    bram_dat_i   => host_bram_dat_rd,
    bram_adr_o   => host_bram_adr,
    bram_we_o    => host_bram_we,
    bram_cyc_o   => host_bram_cyc,
    --SD Card Interface
    sd_cmd_i     => host_cmd_i,
    sd_cmd_o     => host_cmd_o,
    sd_cmd_oe_o  => host_cmd_oe_o,
    sd_dat_i     => host_dat_i,
    sd_dat_o     => host_dat_o,
    sd_dat_oe_o  => host_dat_oe_o,
    sd_dat_siz_o => host_dat_siz_o,
    sd_clk_o_pad => host_clk_o_pad,
    -- Interrupt outputs
    int_cmd_o    => open,
    int_data_o   => open
  );

  mmc_slave : mmc_data_pipe
  generic map(
    EXT_CSD_INIT_FILE => "ext_csd_init.txt", -- Initial contents of EXT_CSD
    FIFO_DEPTH        => MMC_FIFO_DEPTH,
    FILL_LEVEL_BITS   => MMC_FILL_LEVEL_BITS, --s_fif_dat_wr_level'length, -- Should be at least int(floor(log2(FIFO_DEPTH))+1.0)
    RAM_ADR_WIDTH     => MMC_RAM_ADR_BITS
  )
  port map(

    -- Asynchronous reset
    sys_rst_n     => fpga_rst_n,
    sys_clk       => sys_clk,

    -- Bus interface
    adr_i         => syscon_adr(3 downto 0),
    sel_i         => s_reg_sel,
    we_i          => syscon_we,
    dat_i         => syscon_dat_wr,
    dat_o         => s_reg_dat_rd,
    ack_o         => s_reg_ack,

    -- SD/MMC card signals
    mmc_clk_i     => slave_clk_i,
    mmc_cmd_i     => slave_cmd_i,
    mmc_cmd_o     => slave_cmd_o,
    mmc_cmd_oe_o  => slave_cmd_oe_o,
    mmc_od_mode_o => slave_od_mode_o, -- Open drain mode
    mmc_dat_i     => slave_dat_i,
    mmc_dat_o     => slave_dat_o,
    mmc_dat_oe_o  => slave_dat_oe_o,
    mmc_dat_siz_o => slave_dat_siz_o,

    -- Data Pipe FIFOs
    wr_clk_i      => sys_clk,
    wr_clk_en_i   => '1',
    wr_reset_i    => opc_rspf_reset_i,          --s_fif_dat_wr_clear,  -- Synchronous
    wr_en_i       => opc_rspf_we_i,             --s_fif_wr,
    wr_dat_i      => opc_rspf_dat_i,            --s_fif_dat_wr,  --syscon_dat_wr(7 downto 0),
    wr_fifo_level => opc_rspf_cnt_o,            --s_fif_dat_wr_level,
    wr_fifo_full  => opc_rspf_fl_o,             --s_fif_wr_full,
    wr_fifo_empty => opc_rspf_mt_o,             --s_fif_wr_empty,

    rd_clk_i      => sys_clk,
    rd_clk_en_i   => '1',
    rd_reset_i    => opc_rd_reset_i,        --s_fif_dat_rd_clear,  -- Synchronous
    rd_en_i       => opc_fif_ren_i,         --s_fif_rd,
    rd_dat_o      => opc_fif_dat_o,         --s_fif_dat_rd,
    rd_fifo_level => opc_rd_cnt_o,          --s_fif_dat_rd_level,
    rd_fifo_full  => open,                  --s_fif_rd_full,
    rd_fifo_empty => opc_fif_mt_o,          --s_fif_rd_empty,

    -- Data Pipe RAM
    ram_clk_i     => sys_clk,
    ram_clk_en_i  => '1',
    ram_adr_i     => syscon_adr(MMC_RAM_ADR_BITS-1 downto 0),
    ram_we_i      => s_ram_we,
    ram_dat_i     => syscon_dat_wr(7 downto 0),
    ram_dat_o     => s_ram_dat_rd
  );
  s_fif_sel <= '1' when syscon_cyc='1' and t_reg_sel='1' and syscon_adr(3 downto 0)=16#F# else '0';
--  s_fif_rd  <= '1' when syscon_we='0' and s_fif_sel='1' else '0';
--  s_fif_we  <= '1' when syscon_we='1' and s_fif_sel='1' else '0';
  s_ram_we  <= '1' when syscon_we='1' and s_ram_sel='1' else '0';

-- system side BRAM ack signal needs to be delayed by 1 cycle,
-- to allow for the BRAM to respond to the given address.
process(sys_rst_n,sys_clk)
begin
  if (sys_rst_n='0') then
    s_ram_ack <= '0';
  elsif (sys_clk'event and sys_clk='1') then
    s_ram_ack <= s_ram_sel;
  end if;
end process;

-- Formulate function enable signals
  host_enable  <= host_en_i  or host_en_reg;
  slave_enable <= slave_en_i or slave_en_reg;

-- Use output enables to steer MMC signaling

  mmc_clk_o     <= host_clk_o_pad;
  mmc_clk_oe_o  <= '1' when host_enable='1' else '0';
  mmc_cmd_o     <= (host_cmd_o or not host_enable) and (slave_cmd_o or not slave_enable);
  mmc_cmd_oe_o  <= (host_cmd_oe_o and host_enable) or (slave_cmd_oe_o and slave_enable);
  mmc_dat_o     <= host_dat_o   when (host_dat_oe_o='1' and host_enable='1') else
                   slave_dat_o  when (slave_dat_oe_o='1' and slave_enable='1') else
                   (others=>'1');
  mmc_dat_oe_o  <= (host_dat_oe_o and host_enable) or (slave_dat_oe_o and slave_enable);
  mmc_od_mode_o <= slave_od_mode_o when slave_enable='1' else '0'; -- Open drain mode
  mmc_dat_siz_o <= host_dat_siz_o  when (host_dat_oe_o='1' and host_enable='1') else
                   slave_dat_siz_o when (slave_dat_oe_o='1' and slave_enable='1') else
                   (others=>'0');

  host_cmd_i  <= mmc_cmd_i when host_enable='1' and host_cmd_oe_o='0' else '1';
  slave_cmd_i <= mmc_cmd_i when slave_enable='1' and slave_cmd_oe_o='0' else '1';
  host_dat_i  <= mmc_dat_i when host_enable='1' and host_dat_oe_o='0' else (others=>'1');
  slave_dat_i <= mmc_dat_i when slave_enable='1' and slave_dat_oe_o='0' else (others=>'1');
  slave_clk_i <= mmc_clk_i;

  test_cmd_i  <= mmc_cmd_i;

end beh;
