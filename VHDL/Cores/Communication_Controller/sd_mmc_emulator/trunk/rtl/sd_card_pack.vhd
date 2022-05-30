--------------------------------------------------------------------------
-- Package containing SD Card interface modules,
-- and related support modules.
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package sd_card_pack is

  component sd_card_cmd_rx
  port(
    -- Asynchronous reset
    sys_rst_n   : in  std_logic;
    -- SD/MMC card command signals
    sd_clk_i    : in  std_logic;
    sd_cmd_i    : in  std_logic;
    -- Command outputs
    cmd_raw_o   : out unsigned(47 downto 0);
    cmd_index_o : out unsigned(5 downto 0);
    cmd_arg_o   : out unsigned(31 downto 0);
    -- Status and done indicator
    cmd_done_o  : out std_logic;
    crc_err_o   : out std_logic;
    dir_err_o   : out std_logic;
    stop_err_o  : out std_logic
  );
  end component;

  component sd_card_responder
  generic (
    N_CR          : integer; -- Number of clocks between respond_i and response start
    RESP_PYLD_LEN : integer;
    CRC_OFFSET    : integer; -- Start CRC calculation after this many bits
    CRC_SEND_ONES : integer
  );
  port (
    -- Asynchronous reset
    sys_rst_n     : in  std_logic;
    -- SD/MMC card command signals
    sd_clk_i      : in  std_logic;
    sd_cmd_o      : out std_logic;
    sd_cmd_oe_o   : out std_logic;
    -- Response inputs
    resp_index_i  : in  unsigned(5 downto 0);
    resp_pyld_i   : in  unsigned(RESP_PYLD_LEN-1 downto 0);
    respond_i     : in  std_logic;
    -- Status and done indicator
    done_o        : out std_logic; -- A one clock long pulse
    busy_o        : out std_logic
  );
  end component;

  component sd_card_data_unit
  generic (
    BLK_PRG_TIME  : integer; -- Number of clocks to program a sector in FLASH (emulated)
    BLKSIZE_W     : integer;
    BLKCNT_W      : integer
  );
  port(
    sd_clk_i      : in  std_logic;
    sys_rst_n     : in  std_logic;
    --Tx Fifo
    tx_dat_i      : in  unsigned(7 downto 0);
    tx_dat_rd_o   : out std_logic;
    --Rx Fifo
    rx_dat_o      : out unsigned(7 downto 0);
    rx_dat_we_o   : out std_logic;
    --SD data
    sd_dat_i      : in  unsigned(7 downto 0);
    sd_dat_o      : out unsigned(7 downto 0);
    sd_dat_oe_o   : out  std_logic;
    --Control signals
    blksize_i     : in  unsigned(BLKSIZE_W-1 downto 0);
    bus_size_i    : in  unsigned(1 downto 0);
    blkcnt_i      : in  unsigned(BLKCNT_W-1 downto 0);
    continuous_i  : in  std_logic;
    d_stop_i      : in  std_logic;
    d_read_i      : in  std_logic;
    d_write_i     : in  std_logic;
    bustest_w_i   : in  std_logic;
    bustest_r_i   : in  std_logic;
    sd_dat_busy_o : out std_logic;
    fsm_busy_o    : out std_logic;
    crc_ok_o      : out std_logic
  );
  end component;

  component sd_card_emulator
  generic (
    USE_R4_RESPONSE      : integer; -- Fast I/O read/write (app specific)
    USE_R5_RESPONSE      : integer; -- Interrupt Request Mode
    EXT_CSD_INIT_FILE    : string; -- Initial contents of EXT_CSD
    OCR_USE_DUAL_VOLTAGE : integer;
    OCR_USE_SECTOR_MODE  : integer;
    CID_MID    : unsigned( 7 downto 0); -- Manufacturer ID
    CID_OID    : unsigned( 7 downto 0); -- OEM ID
    CID_CBX    : unsigned( 1 downto 0); -- 0=Card, 1=BGA, 2=Package On Package
    CID_PNM    : unsigned(47 downto 0); -- Product Name, 6 ASCII chars
    CID_PRV    : unsigned( 7 downto 0); -- Product Rev (2 BCD digits, e.g. 6.2=0x62)
    CID_PSN    : unsigned(31 downto 0); -- Product serial number
    CID_MDT    : unsigned( 7 downto 0); -- Manufacture Date (Jan=1, 1997=0, e.g. Apr. 2000=0x43)
    DEF_STAT   : unsigned(31 downto 0); -- Read Write, R_0
    CSD_WORD_3 : unsigned(31 downto 0); -- Read only
    CSD_WORD_2 : unsigned(31 downto 0); -- Read only
    CSD_WORD_1 : unsigned(31 downto 0); -- Read only
    CSD_WORD_0 : unsigned(31 downto 0); -- (31:16) is read only, (15:0) is R_1 default (R/W)
    DEF_R_Z    : unsigned(31 downto 0)  -- Value returned for nonexistent registers
  );
  port (

    -- Asynchronous reset
    sys_rst_n     : in  std_logic;
    sys_clk       : in  std_logic;

    -- Bus interface
    adr_i         : in  unsigned(3 downto 0);
    sel_i         : in  std_logic;
    we_i          : in  std_logic;
    dat_i         : in  unsigned(31 downto 0);
    dat_o         : out unsigned(31 downto 0);
    ack_o         : out std_logic;

    -- SD/MMC card signals
    sd_clk_i      : in  std_logic;
    sd_cmd_i      : in  std_logic;
    sd_cmd_o      : out std_logic;
    sd_cmd_oe_o   : out std_logic;
    sd_od_mode_o  : out std_logic; -- Open drain mode
    sd_dat_i      : in  unsigned(7 downto 0);
    sd_dat_o      : out unsigned(7 downto 0);
    sd_dat_oe_o   : out std_logic;
    sd_dat_siz_o  : out unsigned(1 downto 0);

    -- Data FIFO interface
    buf_adr_o     : out unsigned(31 downto 0);
    buf_dat_o     : out unsigned(7 downto 0);
    buf_dat_we_o  : out std_logic;
    buf_dat_i     : in  unsigned(7 downto 0);
    buf_dat_rd_o  : out std_logic
  );
  end component;

  component mmc_data_pipe
  generic (
    EXT_CSD_INIT_FILE : string; -- Initial contents of EXT_CSD
    FIFO_DEPTH        : integer;
    FILL_LEVEL_BITS   : integer; -- Should be at least int(floor(log2(FIFO_DEPTH))+1.0)
    RAM_ADR_WIDTH     : integer
  );
  port (

    -- Asynchronous reset
    sys_rst_n     : in  std_logic;
    sys_clk       : in  std_logic;

    -- Bus interface
    adr_i         : in  unsigned(3 downto 0);
    sel_i         : in  std_logic;
    we_i          : in  std_logic;
    dat_i         : in  unsigned(31 downto 0);
    dat_o         : out unsigned(31 downto 0);
    ack_o         : out std_logic;

    -- SD/MMC card signals
    mmc_clk_i     : in  std_logic;
    mmc_cmd_i     : in  std_logic;
    mmc_cmd_o     : out std_logic;
    mmc_cmd_oe_o  : out std_logic;
    mmc_od_mode_o : out std_logic; -- Open drain mode
    mmc_dat_i     : in  unsigned(7 downto 0);
    mmc_dat_o     : out unsigned(7 downto 0);
    mmc_dat_oe_o  : out std_logic;
    mmc_dat_siz_o : out unsigned(1 downto 0);

    -- Data Pipe FIFOs
    wr_clk_i      : in  std_logic;
    wr_clk_en_i   : in  std_logic;
    wr_reset_i    : in  std_logic;  -- Synchronous
    wr_en_i       : in  std_logic;
    wr_dat_i      : in  unsigned(7 downto 0);
    wr_fifo_level : out unsigned(FILL_LEVEL_BITS-1 downto 0);
    wr_fifo_full  : out std_logic;
    wr_fifo_empty : out std_logic;

    rd_clk_i      : in  std_logic;
    rd_clk_en_i   : in  std_logic;
    rd_reset_i    : in  std_logic;  -- Synchronous
    rd_en_i       : in  std_logic;
    rd_dat_o      : out unsigned(7 downto 0);
    rd_fifo_level : out unsigned(FILL_LEVEL_BITS-1 downto 0);
    rd_fifo_full  : out std_logic;
    rd_fifo_empty : out std_logic;

    -- Data Pipe RAM
    ram_clk_i     : in  std_logic;
    ram_clk_en_i  : in  std_logic;
    ram_adr_i     : in  unsigned(RAM_ADR_WIDTH-1 downto 0);
    ram_we_i      : in  std_logic;
    ram_dat_i     : in  unsigned(7 downto 0);
    ram_dat_o     : out unsigned(7 downto 0)

  );
  end component;

end sd_card_pack;

package body sd_card_pack is
end sd_card_pack;


-------------------------------------------------------------------------------
-- SD/MMC Card Command Receiver
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update: Mar. 24, 2016 Wrote description and initial code
--
-- Description
-------------------------------------------------------------------------------
-- This module is meant to be part of a system that emulates an SD/MMC card.
--
-- This module clocks incoming serial command bits into a 48 bit shift
-- register.  It starts when a '0' (start) bit is found, and then shifts in
-- 47 additional bits.  The expected format of the command is:
--
-- 0 1 [index] [arg] [crc] 1
--
-- Where:
--   index = 6 bits
--   arg   = 32 bits
--   crc   = 7  bits
--
-- It checks that the second bit is a '1' indicating that
-- the command is from the host to the card.  It also checks that the last bit
-- is a '1' (stop) bit.  The seven bits immediately prior to the stop bit are
-- checked using a CRC-7 code.
--
-- If any of the checks does not pass, the associated error bits are set, and
-- the cmd_ outputs remain unchanged.  If all checks pass, then the newly
-- received command contents are stored into the cmd_ outputs, and the
-- cmd_rx_done_o output is pulsed high for one sd_clk_i cycle.
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

entity sd_card_cmd_rx is
  port (
    -- Asynchronous reset
    sys_rst_n   : in  std_logic;
    -- SD/MMC card command signals
    sd_clk_i    : in  std_logic;
    sd_cmd_i    : in  std_logic;
    -- Command outputs
    cmd_raw_o   : out unsigned(47 downto 0);
    cmd_index_o : out unsigned(5 downto 0);
    cmd_arg_o   : out unsigned(31 downto 0);
    -- Status and done indicator
    cmd_done_o  : out std_logic;
    crc_err_o   : out std_logic;
    dir_err_o   : out std_logic;
    stop_err_o  : out std_logic
  );
end sd_card_cmd_rx;

architecture beh of sd_card_cmd_rx is

  -- CRC related
signal crc_clk    : std_logic;
signal crc_clr    : std_logic;
signal crc_match  : std_logic;
signal crc_val    : unsigned(6 downto 0);
  -- Related to the incoming command
signal counter    : unsigned(5 downto 0);
signal rx_sr      : unsigned(45 downto 0);
signal cmd_raw_l  : unsigned(47 downto 0);

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
    data_i     => sd_cmd_i,
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
    counter <= (others=>'0');
    rx_sr <= (others=>'0');
    cmd_raw_l <= (others=>'1');
--  elsif (sd_clk_i'event and sd_clk_i='0') then -- falling edge is used, when data is stable.
  elsif (sd_clk_i'event and sd_clk_i='1') then -- rising edge is used, per the specification.
    -- The shift register bit is the only synchronization flip flop
    rx_sr(0)  <= sd_cmd_i;
    rx_sr(45 downto 1) <= rx_sr(44 downto 0);
    -- Decrement the counter when it is non-zero
    if (counter>0) then
      counter <= counter-1;
    end if;
    -- Load the counter when a start bit is seen
    if (counter=0 and sd_cmd_i='0') then
      counter <= to_unsigned(47,counter'length);
    end if;
    -- Store the output when the counter is expiring
    if (counter=2) then
      cmd_raw_l <= rx_sr & sd_cmd_i & '1';
    end if;
  end if;
end process;

-- Provide output signals
cmd_done_o <= '1' when (counter=1 and crc_match='1' and cmd_raw_l(46)='1' and sd_cmd_i='1') else '0';
stop_err_o <= '1' when (counter=1 and sd_cmd_i='0') else '0';
dir_err_o  <= '1' when (counter=1 and cmd_raw_l(46)='0') else '0';
crc_err_o  <= '1' when (counter=1 and crc_match='0') else '0';

-- Split out fields of the command
cmd_raw_o   <= cmd_raw_l;
cmd_index_o <= cmd_raw_l(45 downto 40);
cmd_arg_o   <= cmd_raw_l(39 downto 8);

end beh;


-------------------------------------------------------------------------------
-- SD/MMC Card Command Responder
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update: Mar. 30, 2016 Wrote description and initial code
--         Apr. 28, 2016 Added N_CR generic
--
-- Description
-------------------------------------------------------------------------------
-- This module is meant to be part of a system that emulates an SD/MMC card.
--
-- This module latches parallel data into a shift register, and then shifts
-- the data out as a command response, using the sd_clk_i input as the clock.
--
-- The process of sending a response begins when the respond_i input is driven
-- high.  The generic N_CR determines how many clocks occur between the
-- respond_i pulse, and the actual start bit of the response.  However,
-- per the SD/MMC card specifications, there are supposed to be two clock
-- periods of tri-state bus "turnaround time" following the stop bit of the
-- command.  After the bus turnaround time, then the card pulls up the
-- command line, until the full N_CR time has expired.  The value of N_CR
-- must not be set below 5 to comply with the minimum values in the SD/MMC
-- specification.  If the respond_i input occurs in the clock following the
-- command stop bit, then a value of 4 is the lowest permitted N_CR...
--
-- According to the SD/MMC card specification, there are several different
-- types of card responses:
--
--  type   length  structure
--  ----   ------  ----------------------------------------------------------
--   R1 =  48 bit, ("00" & 6 bit index & 32 bit card status & 7 bit CRC & '1')
--   R2 = 136 bit, ("00111111" & 120 bit CID or CSD & 7 bit CRC & '1')
--   R3 =  48 bit, ("00111111" & 32 bit OCR & "11111111")
--   R4 =  48 bit, ("00100111" & 16 bit RCA & 1 bit status & 7 bit reg addr & 8 bit reg read data & 7 bit CRC & '1')
--   R5 =  48 bit, ("00101000" & 16 bit RCA & 16 bit undefined & 7 bit CRC & '1')
--
-- The length of the shift register is determined by a generic parameter,
-- RESP_PYLD_LEN, according to the following formula:
--
--   shift_reg_length = 8 + RESP_PYLD_LEN + 8 = 16 + RESP_PYLD_LEN
--
-- Thus, for the 48 bit response, RESP_PYLD_LEN is set to 32, and for the
-- 136 bit response, RESP_PYLD_LEN is set to 120.
--
-- This module automatically populates the first two bits of the reply with
-- "00", Because all of the replies begin with "00."  The next 6 bits are
-- supplied by the "resp_index_i" signal.  After that, the next set of bits
-- is supplied by the signal "resp_pyld_i" which stands for 
-- "response payload."  Since the payload could be either 32 bits or 120 bits
-- long, the payload length is set by the RESP_PYLD_LEN generic.
--
-- This module contains a CRC unit which calculates the 7 CRC bits to place at
-- the end, and the final stop bit is also sent out automatically.
--
-- Whenever the responder is idle, asserting the respond_i input causes the
-- response to be latched immediately, and the first bit of the newly
-- requested reponse is sent out on the following clock cycle.  If a response
-- is already being actively sent out, the respond_i input is simply ignored.
--
-- It is envisioned that several instances of the responder may be used in
-- parallel, each being connected to a different SD/MMC card register.
-- Therefore, coordination of the response signals needs to be done in a
-- higher level module, possibly through some sort of data selector or "mux"
-- to determine which sd_cmd_o and sd_cmd_oe_o outputs get used, and also
-- perhaps through logic to ensure that only the desired respond_i input is
-- asserted.  This may seem somewhat "messy," but it was done with the idea
-- in mind that certain types of responses could be easily left out of the
-- design completely, by eliminating the associated responder instance.
-- The higher level module is also responsible for determining the timing
-- between receipt of a command, and the start of the response.
-- For instance, the SD/MMC card standard specifies that for identification
-- responses, exactly 5 clock cycles should exist between the stop bit of
-- the command, and the start bit of the response.
-- 
-- Note that this responder runs entirely within the sd_clk_i clock domain.
-- Therefore, care must be taken when supplying the inputs.  A FIFO can form
-- a natural "clock domain boundary crossing" or the user may need to
-- implement other special handshaking to safely receive signals from a
-- different clock domain.
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.ucrc_pack.all;
use work.convert_pack.all;

entity sd_card_responder is
  generic (
    N_CR          : integer :=  5; -- Number of clocks between respond_i and response start
    RESP_PYLD_LEN : integer := 32;
    CRC_OFFSET    : integer := 0; -- Start CRC calculation after this many bits
    CRC_SEND_ONES : integer := 0
  );
  port (
    -- Asynchronous reset
    sys_rst_n     : in  std_logic;
    -- SD/MMC card command signals
    sd_clk_i      : in  std_logic;
    sd_cmd_o      : out std_logic;
    sd_cmd_oe_o   : out std_logic;
    -- Response inputs
    resp_index_i  : in  unsigned(5 downto 0);
    resp_pyld_i   : in  unsigned(RESP_PYLD_LEN-1 downto 0);
    respond_i     : in  std_logic;
    -- Status and done indicator
    done_o        : out std_logic; -- A one clock long pulse
    busy_o        : out std_logic
  );
end sd_card_responder;

architecture beh of sd_card_responder is

  -- CRC related
signal crc_clk_en : std_logic;
signal crc_clr    : std_logic;
signal crc_val    : unsigned(6 downto 0);
signal crc_enable : std_logic;
  -- Related to the response
signal n_cr_count : unsigned(timer_width(N_CR)-1 downto 0);
signal counter    : unsigned(7 downto 0);
signal tx_sr      : unsigned(RESP_PYLD_LEN+7 downto 0);
signal tail_end   : unsigned(8 downto 0);

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
    sys_clk    => sd_clk_i,
    sys_rst_n  => sys_rst_n,
    sys_clk_en => crc_clk_en,

    -- Input and Control
    clear_i    => crc_clr,
    data_i     => tx_sr(tx_sr'length-1),
    flush_i    => '0',

    -- Output
    match_o    => open,
    crc_o      => crc_val
  );
  crc_clk_en <= '1' when counter=0 or counter>8 else '0';
  crc_clr <= '1' when counter=0 or counter>(RESP_PYLD_LEN+16-CRC_OFFSET) else '0';
  -- Attach a stop bit to the CRC code, and another for easy indexing by the main counter
  tail_end <= crc_val & "11" when CRC_SEND_ONES=0 else "111111111";

--------------------------------------------
-- Response Transmitter

response_tx_proc : process(sys_rst_n, sd_clk_i)
begin
  if (sys_rst_n='0') then
    n_cr_count  <= (others=>'0');
    counter     <= (others=>'0');
    tx_sr       <= (others=>'1');
  elsif (sd_clk_i'event and sd_clk_i='1') then
    -- Default values

    -- Left shifting shift register
    tx_sr <= tx_sr(tx_sr'length-2 downto 0) & '0';
    -- Handle the N_CR counter, an incrementing counter
    if (n_cr_count>0) then
      n_cr_count <= n_cr_count+1;
    end if;
    -- Decrement the main counter when it is non-zero
    if (counter>0) then
      counter <= counter-1;
    end if;
    -- Load the N_CR counter when a start signal is seen
    if (counter=0 and n_cr_count=0 and respond_i='1') then
      n_cr_count <= to_unsigned(1,n_cr_count'length);
    end if;
    -- Load the main counter when the N_CR counter matures
    if (counter=0 and n_cr_count=N_CR) then
      n_cr_count <= (others=>'0');
      counter <= to_unsigned(RESP_PYLD_LEN+16,counter'length);
      tx_sr <= "00" & resp_index_i & resp_pyld_i;
    end if;
  end if;
end process;

done_o <= '1' when counter=1 else '0';
busy_o <= '1' when counter>0 else '0';
-- In our current implementation, there are already two cycles of
-- tri-state bus turnaround time, therefore and additional two cycles
-- is not required.  Uncomment this line for implementations where
-- the bus turnaround needs to be explicitly created.
--sd_cmd_oe_o <= '1' when n_cr_count>2 or counter>0 else '0';
sd_cmd_oe_o <= '1' when n_cr_count>0 or counter>0 else '0';
sd_cmd_o <= tx_sr(tx_sr'length-1) when counter>8 else
            tail_end(to_integer(counter));

end beh;


-------------------------------------------------------------------------------
-- SD/MMC Card Data Unit
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update: Apr. 14, 2016 Wrote description and initial code
--         June  9, 2016 Added bustest_w_i and bustest_r_i signals
--
-- Description
-------------------------------------------------------------------------------
-- This module is meant to emulate the data handler of an SD/MMC card.
--
-- This module accepts SD/MMC card data transfers, and generates return
-- transfers for sending data to the cardbus host.
--
-- Most of this unit runs entirely within the sd_clk_i clock domain.  The FIFO
-- data storage buffers form a natural place at which to interface between
-- clock domains, and the registers are also read and written from a separate
-- clock domain (sys_clk).
--
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.ucrc_pack.all;
use work.sd_host_pack.all;
use work.convert_pack.all;

entity sd_card_data_unit is
  generic (
    BLK_PRG_TIME  : integer := 400; -- Number of clocks to program a sector in FLASH (emulated)
    BLKSIZE_W     : integer := 12;
    BLKCNT_W      : integer := 16
  );
  port(
    sd_clk_i      : in  std_logic;
    sys_rst_n     : in  std_logic;
    --Tx Fifo
    tx_dat_i      : in  unsigned(7 downto 0);
    tx_dat_rd_o   : out std_logic;
    --Rx Fifo
    rx_dat_o      : out unsigned(7 downto 0);
    rx_dat_we_o   : out std_logic;
    --SD data
    sd_dat_i      : in  unsigned(7 downto 0);
    sd_dat_o      : out unsigned(7 downto 0);
    sd_dat_oe_o   : out  std_logic;
    --Control signals
    blksize_i     : in  unsigned(BLKSIZE_W-1 downto 0);
    bus_size_i    : in  unsigned(1 downto 0);
    blkcnt_i      : in  unsigned(BLKCNT_W-1 downto 0);
    continuous_i  : in  std_logic;
    d_stop_i      : in  std_logic;
    d_read_i      : in  std_logic;
    d_write_i     : in  std_logic;
    bustest_w_i   : in  std_logic;
    bustest_r_i   : in  std_logic;
    sd_dat_busy_o : out std_logic;
    fsm_busy_o    : out std_logic;
    crc_ok_o      : out std_logic
  );
end sd_card_data_unit;

architecture beh of sd_card_data_unit is

-- Internal constants
constant BLK_PRG_CBITS : natural := timer_width(BLK_PRG_TIME);

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
signal transf_cnt : unsigned(15 downto 0);
  --State Machine
type FSM_STATE_TYPE is (IDLE, SEND_DAT, READ_WAIT, READ_DAT, SEND_BUSTEST,
                        READ_BUSTEST_WAIT, READ_BUSTEST, CRC_ACK, CRC_NACK,
                        RECV_BUSY);
signal state : FSM_STATE_TYPE;

signal busy_int    : std_logic;
signal blkcnt_reg  : unsigned(BLKCNT_W-1 downto 0);
signal start_bit   : std_logic;
signal crc_c       : unsigned(4 downto 0);
signal crc_status  : unsigned(3 downto 0);
signal data_index  : unsigned(2 downto 0);
signal last_din    : unsigned(7 downto 0);

signal bustest_0   : unsigned(7 downto 0);
signal bustest_1   : unsigned(7 downto 0);
signal blk_prg_tmr : unsigned(BLK_PRG_CBITS-1 downto 0);
signal d_stop_pending : std_logic;

begin

--sd data input pad register
process(sys_rst_n,sd_clk_i)
begin
  if (sys_rst_n='0') then
    dat_reg <= (others=>'0');
  elsif (sd_clk_i'event and sd_clk_i='1') then
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
    sys_clk    => sd_clk_i,
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
sd_dat_busy_o <= '1' when (state=RECV_BUSY) else '0';

fsm_proc : process(sys_rst_n,sd_clk_i)
begin
  if (sys_rst_n='0') then
    state <= IDLE;
    sd_dat_oe_o <= '0';
    crc_enable <= '0';
    crc_rst_n <= '0';
    transf_cnt <= (others=>'0');
    tx_dat_rd_o <= '0';
    last_din <= (others=>'0');
    crc_c <= (others=>'0');
    crc_status <= (others=>'0');
    crc_in <= (others=>'0');
    sd_dat_o <= (others=>'0');
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
    blk_prg_tmr <= (others=>'0');
    d_stop_pending <= '0';
  elsif (sd_clk_i'event and sd_clk_i='1') then
    -- Handle block programming timer
    if (blk_prg_tmr>0) then
      blk_prg_tmr <= blk_prg_tmr-1;
    end if;
    -- Implement finite state machine
    case(state) is
      when IDLE =>
        d_stop_pending <= '0';
        sd_dat_oe_o <= '0';
        sd_dat_o <= "11111111";
        crc_enable <= '0';
        crc_rst_n <= '0';
        transf_cnt <= (others=>'0');
        crc_c <= to_unsigned(16,crc_c'length);
        rx_dat_we_o <= '0';
        tx_dat_rd_o <= '0';
        data_index <= (others=>'0');
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
        -- Currently stream based reads and writes are not supported, so if "continuous_i" is
        -- asserted, remain in IDLE state
        if (continuous_i='0' and d_stop_i='0' and d_read_i='0' and d_write_i='1' and bustest_w_i='0' and bustest_r_i='0') then
          state <= SEND_DAT;
          -- For the case of 8-bit bus width, provide early read signal, so that
          -- synchronous RAMs, such as BRAMs and BRAM based FIFOs have a chance to
          -- respond in time.
          if (bus_size_reg=2) then
            tx_dat_rd_o <= '1';
          end if;
        elsif  (continuous_i='0' and d_stop_i='0' and d_read_i='1' and d_write_i='0' and bustest_w_i='0' and bustest_r_i='0') then
          state <= READ_WAIT;
        elsif  (continuous_i='0' and d_stop_i='0' and d_read_i='0' and d_write_i='0' and bustest_w_i='0' and bustest_r_i='1') then
          data_cycles <= to_unsigned(24,data_cycles'length);
          state <= SEND_BUSTEST;
        elsif  (continuous_i='0' and d_stop_i='0' and d_read_i='0' and d_write_i='0' and bustest_w_i='1' and bustest_r_i='0') then
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
        if (transf_cnt = 2) then
          sd_dat_o <= bustest_0;
        end if;
        if (transf_cnt = 3) then
          sd_dat_o <= bustest_1;
        end if;
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
        if ((d_stop_i='1') or (transf_cnt >= data_cycles+1)) then
          state <= IDLE;
        end if;

      when READ_BUSTEST_WAIT =>
        sd_dat_oe_o <= '0';
        transf_cnt <= (others=>'0');
        -- state transition
        if (d_stop_i='1') then -- signal for stopping
          state <= IDLE;
        elsif (start_bit='1') then
          state <= READ_BUSTEST;
        end if;

      when READ_BUSTEST =>
        transf_cnt <= transf_cnt+1;
        if (transf_cnt = 0) then
          bustest_0 <= not dat_reg;
        end if;
        if (transf_cnt = 1) then
          bustest_1 <= not dat_reg;
        end if;
        -- state transition
        -- No CRC status response is needed
        -- Look for stop bits
        if ((d_stop_i='1') or (dat_reg = "11111111")) then
          state <= IDLE;
        end if;

      when SEND_DAT =>
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
          if (transf_cnt<data_cycles) and (data_index(0 downto 0)=1) then
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
          if (transf_cnt<data_cycles) and (data_index = 5) then
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
          sd_dat_o <= "00000000";
          -- Previous code took care to provide start bit on only
          -- the active lines.  However, the bus_size_reg logic
          -- takes care of masking the unused lines anyway, at
          -- the top level.
          --if (bus_size_reg=2) then -- start bits
          --  sd_dat_o <= "00000000";
          --elsif (bus_size_reg=1) then
          --  sd_dat_o <= "11110000";
          --else
          --  sd_dat_o <= "11111110";
          --end if;
          data_index <= to_unsigned(1,data_index'length);
        end if;
        if ((transf_cnt >= 2) and (transf_cnt <= data_cycles+1)) then
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
        end if;
        if (transf_cnt = data_cycles+18) then -- stop bits
          sd_dat_o <= "11111111";
        end if;
        if (transf_cnt = data_cycles+19) then
          sd_dat_oe_o <= '0';
        end if;
        -- state transition
        if (d_stop_i='1') then -- signal for stopping
          state <= IDLE;
        elsif (transf_cnt >= data_cycles+19) then
          transf_cnt <= (others=>'0');
          if (blkcnt_reg>0) then
            blkcnt_reg <= blkcnt_reg-1;
          end if;
          crc_rst_n <= '0';
          crc_c <= to_unsigned(16,crc_c'length);
          -- State transition
          if (blkcnt_reg=1) then
            state <= IDLE;
          else
            state <= SEND_DAT;
          end if;
        end if;

      when READ_WAIT =>
        sd_dat_oe_o   <= '0';
        crc_rst_n  <= '1';
        crc_enable <= '1';
        crc_in     <= (others=>'0');
        crc_c      <= to_unsigned(15,crc_c'length);-- end
        transf_cnt <= (others=>'0');
        -- state transition
        if (d_stop_i='1') then -- signal for stopping
          state <= IDLE;
        elsif (start_bit='1') then
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
        -- state transition, provide CRC status reponse
        -- The bus turnaround time (tri-state condition) occurs
        -- on transf_cnt=(data_cycles+16) and (data_cycles+17)
        -- Then, CRC status response begins
        if (d_stop_i='1') then -- signal for stopping
          if (transf_cnt <= data_cycles+16) then
            state <= IDLE;
          else
            d_stop_pending <= '1'; -- Continue with CRC status token response, then stop.
          end if;
        end if;
        if (transf_cnt=(data_cycles+17)) then
          sd_dat_oe_o <= '1';
          sd_dat_o <= "00000000"; -- start bit for CRC status response
          if (crc_ok_l='1') then
            crc_status <= "0101"; -- status for good CRC, with stop bit
            state <= CRC_ACK;
          else
            crc_status <= "1011"; -- status for bad CRC, with stop bit
            state <= CRC_NACK;
          end if;
        end if;

      when CRC_ACK =>
        transf_cnt <= transf_cnt+1;
        sd_dat_o(0) <= crc_status(3);
        sd_dat_o(7 downto 1) <= (others=>'1');
        crc_status <= crc_status(2 downto 0) & '1';
        if (d_stop_i='1') then
          d_stop_pending <= '1';
        end if;
        if (transf_cnt=(data_cycles+22)) then
          blk_prg_tmr <= to_unsigned(BLK_PRG_TIME,blk_prg_tmr'length);
          state <= RECV_BUSY;
        end if;

      when CRC_NACK =>
        transf_cnt <= transf_cnt+1;
        sd_dat_o(0) <= crc_status(3);
        sd_dat_o(7 downto 1) <= (others=>'1');
        crc_status <= crc_status(2 downto 0) & '1';
        if (d_stop_i='1') then
          d_stop_pending <= '1';
        end if;
        if (transf_cnt=(data_cycles+22)) then
          blkcnt_reg <= to_unsigned(1,blkcnt_reg'length); -- Cancel remainder, due to error
          blk_prg_tmr <= to_unsigned(BLK_PRG_TIME,blk_prg_tmr'length);
          state <= RECV_BUSY;
        end if;

      when RECV_BUSY =>
        if (d_stop_i='1') then
          d_stop_pending <= '1';
        end if;
        -- Wait for busy period, even if stop is pending
        if (blk_prg_tmr>0) then
          null; -- Wait here
        else
          if (blkcnt_reg>0) then
            blkcnt_reg <= blkcnt_reg-1;
          end if;
          -- State transition
          if ((d_stop_pending='1') or (blkcnt_reg=1)) then
            state <= IDLE;
          else
            state <= READ_WAIT;
          end if;
        end if;


    when others =>
      null;

    end case;
  end if;
end process;


end beh;



-------------------------------------------------------------------------------
-- SD/MMC Card Emulator
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update: Apr.  6, 2016 Wrote description and initial code
--         Apr. 28, 2016 Added sd_card_data_unit, and various signals to
--                       support it.
--
-- Description
-------------------------------------------------------------------------------
-- This module is meant to emulate an SD/MMC card.
--
-- This module does what an SD/MMC card would do, within reason.
-- That is to say, it responds to commands, and accepts and provides data,
-- but it does not contain the actual data storage cells.  Instead of storing
-- data directly into a non-volatile memory array, this module provides an
-- addressed parallel bus interface, so that FIFOs or other RAM buffers can
-- be attached and used as storage.  The idea is that entire ranges of
-- addresses can be mapped into the same storage buffer, or a set of buffers
-- which are set up on certain address boundaries.  With these buffers in
-- place, the sd_card_controller can act as a "bridge" between a host system
-- and the FIFOs.  Data can be transferred to and from the FIFO buffers, all
-- the while the host system believes it is communicating with an SD or MMC
-- card.
--
-- Obviously, this scheme does not include the concept of a file system, which
-- may necessitate one of the following:
--
--   1. A host command which can read and write to specific SD/MMC sectors,
--      which are most likely 512 bytes each in length.
--   2. The creation of a file system within the storage area of the FIFO
--      buffers.
--
-- Option 2 requires significant amounts of cleverness, and has not yet been
-- worked out in the mind of this code author.  However, for option 1, there
-- exists a command in Linux, namely the "dd" command, which can serve to 
-- access individual sectors, in the fashion shown below.  A software log
-- file output is shown after each command, helping to illustrate the sequence
-- of SD/MMC commands and responses which occur as part of the transfer, from
-- the perspective of the host:
--
--   WRITE BLOCK 0 : dd if=/dev/zero of=/dev/mmcblk1 bs=4k count=1
--   
--   Jan 15 11:45:31 bbb user.debug kernel: [  253.042114] omap_hsmmc 481d8000.mmc: enabled
--   Jan 15 11:45:31 bbb user.debug kernel: [  253.042235] omap_hsmmc 481d8000.mmc: mmc1: CMD25, argument 0x00000000
--   Jan 15 11:45:31 bbb user.debug kernel: [  253.042274] omap_hsmmc 481d8000.mmc: IRQ Status is 1
--   Jan 15 11:45:31 bbb user.debug kernel: [  253.096448] omap_hsmmc 481d8000.mmc: IRQ Status is 2
--   Jan 15 11:45:31 bbb user.debug kernel: [  253.096478] omap_hsmmc 481d8000.mmc: mmc1: CMD12, argument 0x00000000
--   Jan 15 11:45:31 bbb user.debug kernel: [  253.096511] omap_hsmmc 481d8000.mmc: IRQ Status is 3
--   Jan 15 11:45:31 bbb user.debug kernel: [  253.096617] omap_hsmmc 481d8000.mmc: mmc1: CMD13, argument 0x00010000
--   Jan 15 11:45:31 bbb user.debug kernel: [  253.096640] omap_hsmmc 481d8000.mmc: IRQ Status is 1
--   Jan 15 11:45:31 bbb user.debug kernel: [  253.195201] omap_hsmmc 481d8000.mmc: disabled
--   
--   
--   WRITE BLOCK 1 : dd if=/dev/zero of=/dev/mmcblk1 bs=4k count=1 seek=1
--   
--   Jan 15 11:50:19 bbb user.debug kernel: [  541.840549] omap_hsmmc 481d8000.mmc: enabled
--   Jan 15 11:50:19 bbb user.debug kernel: [  541.840671] omap_hsmmc 481d8000.mmc: mmc1: CMD25, argument 0x00000008
--   Jan 15 11:50:19 bbb user.debug kernel: [  541.840706] omap_hsmmc 481d8000.mmc: IRQ Status is 1
--   Jan 15 11:50:19 bbb user.debug kernel: [  541.840858] omap_hsmmc 481d8000.mmc: IRQ Status is 2
--   Jan 15 11:50:19 bbb user.debug kernel: [  541.840871] omap_hsmmc 481d8000.mmc: mmc1: CMD12, argument 0x00000000
--   Jan 15 11:50:19 bbb user.debug kernel: [  541.840888] omap_hsmmc 481d8000.mmc: IRQ Status is 1
--   Jan 15 11:50:19 bbb user.debug kernel: [  541.841414] omap_hsmmc 481d8000.mmc: IRQ Status is 2
--   Jan 15 11:50:19 bbb user.debug kernel: [  541.841484] omap_hsmmc 481d8000.mmc: mmc1: CMD13, argument 0x00010000
--   Jan 15 11:50:19 bbb user.debug kernel: [  541.841506] omap_hsmmc 481d8000.mmc: IRQ Status is 1
--   Jan 15 11:50:20 bbb user.debug kernel: [  541.934036] omap_hsmmc 481d8000.mmc: disabled
--   
--   
--   WRITE BLOCK 2 : dd if=/dev/zero of=/dev/mmcblk1 bs=4k count=1 seek=2
--   
--   Jan 15 11:49:31 bbb user.debug kernel: [  493.057453] omap_hsmmc 481d8000.mmc: enabled
--   Jan 15 11:49:31 bbb user.debug kernel: [  493.057573] omap_hsmmc 481d8000.mmc: mmc1: CMD25, argument 0x00000010
--   Jan 15 11:49:31 bbb user.debug kernel: [  493.057610] omap_hsmmc 481d8000.mmc: IRQ Status is 1
--   Jan 15 11:49:31 bbb user.debug kernel: [  493.057761] omap_hsmmc 481d8000.mmc: IRQ Status is 2
--   Jan 15 11:49:31 bbb user.debug kernel: [  493.057775] omap_hsmmc 481d8000.mmc: mmc1: CMD12, argument 0x00000000
--   Jan 15 11:49:31 bbb user.debug kernel: [  493.057792] omap_hsmmc 481d8000.mmc: IRQ Status is 1
--   Jan 15 11:49:31 bbb user.debug kernel: [  493.058283] omap_hsmmc 481d8000.mmc: IRQ Status is 2
--   Jan 15 11:49:31 bbb user.debug kernel: [  493.058357] omap_hsmmc 481d8000.mmc: mmc1: CMD13, argument 0x00010000
--   Jan 15 11:49:31 bbb user.debug kernel: [  493.058379] omap_hsmmc 481d8000.mmc: IRQ Status is 1
--   Jan 15 11:49:31 bbb user.debug kernel: [  493.150608] omap_hsmmc 481d8000.mmc: disabled
--   
--
-- This SD/MMC card emulator can implement the following response types:
--
--  type   length  structure
--  ----   ------  ----------------------------------------------------------
--   R1 =  48 bit, ("00" & 6 bit index & 32 bit card status & 7 bit CRC & '1')
--   R2 = 136 bit, ("00111111" & 120 bit CID or CSD & 7 bit CRC & '1')
--   R3 =  48 bit, ("00111111" & 32 bit OCR & "11111111")
--   R4 =  48 bit, ("00100111" & 16 bit RCA & 1 bit status & 7 bit reg addr & 8 bit reg read data & 7 bit CRC & '1')
--   R5 =  48 bit, ("00101000" & 16 bit RCA & 16 bit undefined & 7 bit CRC & '1')
--
-- There is a "modified" R1 response, called R1b, in which the D0 line can
-- be held low to signify that the card needs more time.  Currently, the
-- R1b option to delay is not used by this card.
--
-- The R4 and R5 response types are optional, and can be de-selected by
-- setting generics to zero.
-- 
-- Boot modes are not supported, although they probably could be with a
-- modicum of additional work.  The states are already provided in the card
-- state machine, along with some comments detailing what needs to be done.
--
-- This module assumes it is the only card on the host SD/MMC card bus.
-- Therefore, it does not "bitwise monitor its outgoing bitstream" when
-- responding to ALL_SEND_CID (CMD2).  See eMMC Specification JESD84-A44,
-- section 7.4.5 "Card Identification Process" for further details.
-- Of course, feel free to upgrade this module to operate on multi-card
-- buses, if that is what interests you.
--
-- Most of this unit runs entirely within the sd_clk_i clock domain.  The FIFO
-- data storage buffers form a natural place at which to interface between
-- clock domains, and the registers are also read and written from a separate
-- clock domain (sys_clk).
--
-- Register default values are set by generics.
--
-- The module registers are summarized as follows:
--
-- Address   Structure   Function
-- -------   ---------   -----------------------------------------------------
--   0x0       (31:0)    Card status, some bits read only
--   0x1       (31:0)    (31:16)=Relative Card Address (RCA) (READ ONLY)
--                       (15: 0)=Driver Stage Register (DSR) (READ ONLY)
--   0x2        (8:0)    EXT_CSD address
--   0x3        (7:0)    EXT_CSD data
--   0x4       (31:0)    Card Specific Data (CSD) bytes [ 3: 0]
--                       Byte [0] is a "scratchpad" only, since the card R2
--                       responder populates those bits with CRC-7 and stop bit.
--   0x5       (31:0)    Card Specific Data (CSD) bytes [ 7: 4]
--   0x6       (31:0)    Card Specific Data (CSD) bytes [11: 8]
--   0x7       (31:0)    Card Specific Data (CSD) bytes [15:12]
--   0xF       (15:0)    Command receive CRC error count
--
-- Notes on SD/MMC card registers:
--
-- The module registers are not equivalent to the card registers.
-- The card has the following registers:
--                      Module
--   Name    Size       Access  Notes
--   ------  ---------  ------  ---------------------------
--   status    4 bytes    RW    module R_0
--   CID      16 bytes    RO    Wholly set by generics
--   CSD      16 bytes    RW    Defaults set by generics
--   EXT_CSD 512 bytes    RW    contained in initialized Block RAM
--   RCA       2 bytes    RO    module R_1, bits (31:16)
--   DSR       2 bytes    RO    module R_1, bits (15: 0), use is optional
--   OCR       4 bytes    RW    Set by constant plus generics
--
--   CSD is readable in the 2 lower bytes by the card, the upper 14 bytes are
--   read only on the card side.
--
-- Notes on module registers:
--
--   Refer to MMC specifications for descriptions of the card registers.
--
--   0xF : SD/MMC command receive CRC error count
--
--     bits (15:0) contain a count of the number of SD/MMC commands
--                 which have been received with CRC errors.  This
--                 count is reset to zero whenever it is written to,
--                 regardless of what value is written.
--


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.convert_pack.all;
use work.sd_card_pack.all;
use work.block_ram_pack.all;

entity sd_card_emulator is
  generic (
    USE_R4_RESPONSE      : integer := 1; -- Fast I/O read/write (app specific)
    USE_R5_RESPONSE      : integer := 0; -- Interrupt Request Mode
    EXT_CSD_INIT_FILE    : string  := "ext_csd_init.txt"; -- Initial contents of EXT_CSD
    OCR_USE_DUAL_VOLTAGE : integer := 1;
    OCR_USE_SECTOR_MODE  : integer := 0;
    CID_MID    : unsigned( 7 downto 0) := str2u("45",8); -- Manufacturer ID
    CID_OID    : unsigned( 7 downto 0) := str2u("77",8); -- OEM ID
    CID_CBX    : unsigned( 1 downto 0) := "00"; -- 0=Card, 1=BGA, 2=Package On Package
    CID_PNM    : unsigned(47 downto 0) := str2u("434152444C59",48); -- Product Name, 6 ASCII chars
    CID_PRV    : unsigned( 7 downto 0) := str2u("01",8); -- Product Rev (2 BCD digits, e.g. 6.2=0x62)
    CID_PSN    : unsigned(31 downto 0) := str2u("00000012",32); -- Product serial number
    CID_MDT    : unsigned( 7 downto 0) := str2u("43",8); -- Manufacture Date (Jan=1, 1997=0, e.g. Apr. 2000=0x43)
    DEF_STAT   : unsigned(31 downto 0) := str2u("00000000",32); -- Read Write, R_0
    CSD_WORD_3 : unsigned(31 downto 0) := str2u("905E002A",32); -- See MMC spec
    CSD_WORD_2 : unsigned(31 downto 0) := str2u("1F5983D3",32); -- See MMC spec
    CSD_WORD_1 : unsigned(31 downto 0) := str2u("EDB707FF",32); -- See MMC spec
    CSD_WORD_0 : unsigned(31 downto 0) := str2u("96400000",32); -- See MMC spec, bits (7:0) not used.
    DEF_R_Z    : unsigned(31 downto 0) := str2u("33333333",32)  -- Value returned for nonexistent registers
  );
  port (

    -- Asynchronous reset
    sys_rst_n     : in  std_logic;
    sys_clk       : in  std_logic;

    -- Bus interface
    adr_i         : in  unsigned(3 downto 0);
    sel_i         : in  std_logic;
    we_i          : in  std_logic;
    dat_i         : in  unsigned(31 downto 0);
    dat_o         : out unsigned(31 downto 0);
    ack_o         : out std_logic;

    -- SD/MMC card command signals
    sd_clk_i      : in  std_logic;
    sd_cmd_i      : in  std_logic;
    sd_cmd_o      : out std_logic;
    sd_cmd_oe_o   : out std_logic;
    sd_od_mode_o  : out std_logic; -- Open drain mode
    sd_dat_i      : in  unsigned(7 downto 0);
    sd_dat_o      : out unsigned(7 downto 0);
    sd_dat_oe_o   : out std_logic;
    sd_dat_siz_o  : out unsigned(1 downto 0);

    -- Data FIFO interface
    buf_adr_o     : out unsigned(31 downto 0);
    buf_dat_o     : out unsigned(7 downto 0);
    buf_dat_we_o  : out std_logic;
    buf_dat_i     : in  unsigned(7 downto 0);
    buf_dat_rd_o  : out std_logic
  );
end sd_card_emulator;

architecture beh of sd_card_emulator is

-- constants
constant N_ID   : integer := 5; -- Number of clocks before response in card ID mode
constant N_CR   : integer := 5; -- Number of clocks before response in data transfer mode

constant N_CD   : integer := 45; -- Number of clocks before return data in data transfer mode
constant D_BITS : integer := 6; -- Number of bits used in N_CD countdown timers (Command to Data)

constant IMPLEMENT_WRITE_PROT : integer := 0; -- Can be added as a generic if desired...

-- signals
  -- related to card registers
signal status             : unsigned(31 downto 0);
signal reported_status    : unsigned(31 downto 0); -- contains some read only fields
signal cid                : unsigned(127 downto 0);
signal cid_resp           : unsigned(119 downto 0);
signal csd                : unsigned(127 downto 0);
signal csd_resp           : unsigned(119 downto 0);
signal rca                : unsigned(15 downto 0);
signal dsr                : unsigned(15 downto 0);
signal ocr                : unsigned(31 downto 0);
signal ocr_mode           : unsigned(1 downto 0);
signal ocr_vbit           : std_logic;
signal ocr_pwrup_done     : std_logic;
    -- Pertaining to the EXT_CSD register, which is 512 bytes long
      -- System side
signal ext_csd_reg_adr    : unsigned(8 downto 0);
signal ext_csd_reg_dat_rd : unsigned(7 downto 0);
signal ext_csd_reg_we     : std_logic;
      -- SD/MMC card side
signal ext_csd_sd_adr     : unsigned(8 downto 0);
signal ext_csd_sd_we      : std_logic;
signal ext_csd_sd_dat_wr  : unsigned(7 downto 0);
signal ext_csd_sd_dat_rd  : unsigned(7 downto 0);
signal cmd6_op            : unsigned(1 downto 0); -- Orchestrates operations on ext_csd mode space
signal ext_csd_rd_adr     : unsigned(8 downto 0);
signal dreply_start_count : unsigned(D_BITS-1 downto 0); -- Determines when data reply begins
signal prg_dly_count      : unsigned(23 downto 0); -- Determines emulated programming delay

  -- Related to receiving commands
signal sd_cmd_index       : unsigned(5 downto 0);
signal sd_cmd_arg         : unsigned(31 downto 0);
signal sd_cmd_done        : std_logic;
signal sd_cmd_crc_err     : std_logic;
signal sd_cmd_rx          : std_logic;
signal sd_cmd_oe_l        : std_logic;

  -- Related to Card Finite State Machine
type CARD_STATE_TYPE is (CARD_IDLE, CARD_READY, CARD_IDENT, CARD_STBY,
                         CARD_TRAN, CARD_DATA, CARD_RCV,
                         CARD_PRG,  CARD_DIS,  CARD_BTST, CARD_SLP, CARD_INA, 
                         CARD_IRQ,  CARD_PRE_IDLE, CARD_PRE_BOOT, CARD_BOOT);
signal card_state       : CARD_STATE_TYPE;
signal card_state_reply : CARD_STATE_TYPE; -- For reporting in status

signal r_delay                : unsigned(5 downto 0); -- Used to count reply delay clock cycles
signal sd_adr_match           : std_logic;
signal card_cmd_set           : unsigned(2 downto 0);
signal card_adr               : unsigned(31 downto 0);
signal card_blocklen          : unsigned(11 downto 0);
signal card_block_count       : unsigned(15 downto 0);
signal card_dbus_size         : unsigned(1 downto 0);
signal card_rel_wr_req        : std_logic;
signal card_erase_group_start : unsigned(31 downto 0);
signal card_erase_group_end   : unsigned(31 downto 0);
signal card_d_crc_ok          : std_logic;
signal card_d_continuous      : std_logic;
signal card_d_stop            : std_logic;
signal card_d_recv            : std_logic;
signal card_d_send            : std_logic;
signal card_bustest_r         : std_logic;
signal card_bustest_w         : std_logic;
signal card_sd_dat_busy       : std_logic;
signal sd_dat_unbusy          : unsigned(7 downto 0); -- Data lines before adding CARD_PRG busy indication
signal sd_dat_oe_unbusy       : std_logic; -- Output enable before adding CARD_PRG busy indication
signal card_d_busy            : std_logic;
signal card_d_busy_r1         : std_logic;
signal card_tx_dat            : unsigned(7 downto 0);
signal card_tx_dat_rd         : std_logic;
signal adr_offset             : unsigned(31 downto 0);
signal buf_dat_we_l           : std_logic;

  -- Related to command responses
    -- R1 response type
signal r1_cmd             : std_logic;
signal r1_cmd_oe          : std_logic;
signal r1_start           : std_logic;
signal r1_done            : std_logic;
signal crc_err_reply      : std_logic; -- Cleared at end of R1 reponse
signal cmd_err_reply      : std_logic; -- Cleared at end of R1 reponse
signal sd_cmd_neverbad    : std_logic;

    -- R2 CID response type
signal r2_cid_cmd         : std_logic;
signal r2_cid_cmd_oe      : std_logic;
signal r2_cid_start       : std_logic;
signal r2_cid_done        : std_logic;

    -- R2 CSD response type
signal r2_csd_cmd         : std_logic;
signal r2_csd_cmd_oe      : std_logic;
signal r2_csd_start       : std_logic;
signal r2_csd_done        : std_logic;

    -- R3 response type
signal r3_cmd             : std_logic;
signal r3_cmd_oe          : std_logic;
signal r3_start           : std_logic;
signal r3_done            : std_logic;

    -- R4 response type
signal r4_cmd             : std_logic;
signal r4_cmd_oe          : std_logic;
signal r4_start           : std_logic;
signal r4_done            : std_logic;
signal fast_io_reg_rd     : unsigned(31 downto 0);
signal r4_status          : std_logic;
signal r4_reg_adr         : unsigned(6 downto 0);
signal r4_reg_dat_rd      : unsigned(7 downto 0);
signal r4_reg_dat_wr      : unsigned(7 downto 0);
signal r4_reg_we          : std_logic;
      -- Special purpose registers used with CMD39
      -- (Currently only a pair of registers is provided,
      --  because we do not have a purpose for them.)
signal r4_reg_0           : unsigned(7 downto 0);
signal r4_reg_1           : unsigned(7 downto 0);

    -- R5 response type
signal r5_cmd             : std_logic;
signal r5_cmd_oe          : std_logic;
signal r5_start           : std_logic;
signal r5_done            : std_logic;
signal irq_response       : unsigned(31 downto 0);

begin

  -- module register read mux
  with to_integer(adr_i) select
  dat_o <=
    reported_status                        when 0,
    rca & dsr                              when 1,
    u_resize(ext_csd_reg_adr,32)           when 2,
    u_resize(ext_csd_reg_dat_rd,32)        when 3,
    csd(31 downto 0)                       when 4,
    csd(63 downto 32)                      when 5,
    csd(95 downto 64)                      when 6,
    csd(127 downto 96)                     when 7,
    DEF_R_Z                                when others;

  -- Create acknowledge signal
  ack_o <= sel_i;

  -- module register writes are handled here.
  module_reg_proc: process(sys_clk, sys_rst_n)
  begin
    if (sys_rst_n='0') then
      status <= DEF_STAT;
      csd    <= CSD_WORD_3 & CSD_WORD_2 & CSD_WORD_1 & CSD_WORD_0;
      ext_csd_reg_adr  <= (others=>'0');
    elsif (sys_clk'event and sys_clk='1') then
      -- Handle bus writes to registers
      -- These are allowed even when sys_clk_en is low
      if (sel_i='1' and we_i='1') then
        case to_integer(adr_i) is
          when 0 =>
            -- Except for the reported card_state, and the self-clearing
            -- error bits, the other status can be set here.
            status <= dat_i;
          when 2 =>
            ext_csd_reg_adr <= dat_i(8 downto 0);
          when 3 =>
            null; -- EXT_CSD write handled at the BRAM
          when 4 =>
            csd( 31 downto  0) <= dat_i;
          when 5 =>
            csd( 63 downto 32) <= dat_i;
          when 6 =>
            csd( 95 downto 64) <= dat_i;
          when 7 =>
            csd(127 downto 96) <= dat_i;
          when others => null;
        end case;
      end if; -- sel_i
    end if; -- sys_clk
  end process;

  -- formulate any card registers which may depend on generics
    -- Per the eMMC Specification, JESD84-A44, the following fields are defined:
    -- (From table 41, page 112, Section 8.1)
    --
    -- Bits (127:120) = MID (Manufacturer ID)
    -- Bits (119:114) = 000000b (Reserved)
    -- Bits (113:112) = CBX (00=Card, 01=BGA, 10=POP, 11=reserved) (POP=Package On Package)
    -- Bits (111:104) = OID (OEM ID)
    -- Bits (103: 56) = PNM (Product Name, 6 ASCII characters)
    -- Bits ( 55: 48) = PRV (Product Revision)
    -- Bits ( 47: 16) = PSN (Product Serial Number)
    -- Bits ( 15:  8) = MDT (Manufacturing Date)
    -- Bits (  7:  1) = CRC-7 checksum (Added by responder in this case)
    -- Bit  (      0) = '1' (Stop Bit, added by responder in this case)
cid <= CID_MID & "000000" & CID_CBX & CID_OID & CID_PNM &
       CID_PRV & CID_PSN & CID_MDT & "00000001";
cid_resp <= cid(127 downto 8); -- Responder adds the CRC-7 and stop bit fields
csd_resp <= csd(127 downto 8); -- Responder adds the CRC-7 and stop bit fields

    -- OCR:
    -- Per the eMMC Specification, JESD84-A44, the following fields are defined:
    -- (From table 40, page 111, Section 8.1)
    --
    -- Bits (6:0) = "0000000" (Reserved)
    -- Bit  (7) = '0' (1.7 to 1.95 Volts; set for "dual voltage" cards)
    -- Bits (14:8) = "0000000" (2.0 to 2.6 Volts)
    -- Bits (23:15) = "111111111" (2.7 to 3.6 Volts)
    -- Bits (28:24) = "00000" (Reserved)
    -- Bits (30:29) = "00" (Byte mode) or "01" (Sector mode)
    -- Bit  (31) = '1' (Card power up status, set to '0' for "busy")
ocr_vbit <= '1' when OCR_USE_DUAL_VOLTAGE>0 else '0';
ocr_mode <= "01" when OCR_USE_SECTOR_MODE>0 else "00";
ocr <= ocr_pwrup_done & ocr_mode & "00000" & "111111111" & "0000000" & ocr_vbit & "0000000";
    -- Note: OCR response to CMD1 for eMMC can be a fixed pattern, because the
    -- host's indication of requested voltage ranges is no longer meaningful for
    -- eMMC devices.
    -- Fixed pattern can be:
    --   0x00FF8080 for <=2GB eMMC
    --   0x40FF8080 for >2GB eMMC
    -- These fixed patterns are exactly what is produced by the ocr setting above, assuming
    -- that OCR_USE_DUAL_VOLTAGE is non-zero.

--------------------------------------------
-- BRAM for 512 byte long EXT_CSD register
  ext_csd_ram: swiss_army_ram
    generic map(
      USE_BRAM  => 1, -- Set to nonzero value for BRAM, zero for distributed RAM
      WRITETHRU => 1, -- Set to nonzero value for writethrough mode
      USE_FILE  => 1, -- Set to nonzero value to use INIT_FILE
      INIT_VAL  => 0, -- Value used when INIT_FILE is not used
      INIT_SEL  => 0, -- Selects which segment of (larger) INIT_FILE to use
      INIT_FILE => EXT_CSD_INIT_FILE, -- ASCII hexadecimal initialization file name
      FIL_WIDTH => 8, -- Bit width of init file lines
      ADR_WIDTH => 9,
      DAT_WIDTH => 8
    )
    port map(
       clk_a    => sys_clk,
       adr_a_i  => ext_csd_reg_adr,
       we_a_i   => ext_csd_reg_we,
       en_a_i   => '1',
       dat_a_i  => dat_i(7 downto 0),
       dat_a_o  => ext_csd_reg_dat_rd,

       clk_b    => sd_clk_i,
       adr_b_i  => ext_csd_sd_adr,
       we_b_i   => ext_csd_sd_we,
       en_b_i   => '1',
       dat_b_i  => ext_csd_sd_dat_wr,
       dat_b_o  => ext_csd_sd_dat_rd
    );

  -- create system side write enable
  ext_csd_reg_we <= '1' when sel_i='1' and we_i='1' and adr_i=3 else '0';

  -- process for the SD/MMC card side
  -- CMD39 "FAST_IO" register writes are handled here
  sd_reg_proc: process(sd_clk_i, sys_rst_n)
  begin
    if (sys_rst_n='0') then
      ext_csd_rd_adr <= (others=>'0');
    elsif (sd_clk_i'event and sd_clk_i='1') then
      if (dreply_start_count=0 and card_tx_dat_rd='1') then
        ext_csd_rd_adr <= ext_csd_rd_adr+1;
      end if;
      -- Perform one full readout
      if (ext_csd_rd_adr/=0 and card_tx_dat_rd='1') then
        ext_csd_rd_adr <= ext_csd_rd_adr+1;
      end if;
    end if; -- sd_clk_i
  end process;

  ext_csd_sd_adr <= '0' & sd_cmd_arg(23 downto 16) when card_state=CARD_TRAN and sd_cmd_index=6 and sd_cmd_arg(25 downto 24)/=0 and sd_cmd_arg(23 downto 16)<192 else ext_csd_rd_adr;
  ext_csd_sd_we <= '1' when cmd6_op>0 else '0';
  ext_csd_sd_dat_wr <=  sd_cmd_arg(15 downto 8) OR ext_csd_sd_dat_rd when cmd6_op=1 else -- set bits
                        (NOT sd_cmd_arg(15 downto 8)) AND ext_csd_sd_dat_rd when cmd6_op=2 else -- clear bits
                        sd_cmd_arg(15 downto 8); -- write byte

--------------------------------------------
-- SD/MMC Command Receiver

  -- Make sure the receiver only listens when there are no
  -- outgoing transmissions...
  sd_cmd_rx <= sd_cmd_i when sd_cmd_oe_l='0' else '1';

  cmd_receiver: sd_card_cmd_rx
  port map(
    -- Asynchronous reset
    sys_rst_n   => sys_rst_n,
    -- SD/MMC card command signals
    sd_clk_i    => sd_clk_i,
    sd_cmd_i    => sd_cmd_rx,
    -- Command outputs
    cmd_raw_o   => open,
    cmd_index_o => sd_cmd_index,
    cmd_arg_o   => sd_cmd_arg,
    -- Status and done indicator
    cmd_done_o  => sd_cmd_done,
    crc_err_o   => sd_cmd_crc_err,
    dir_err_o   => open,
    stop_err_o  => open
  );
  -- Create an indication that this card is being addressed
  sd_adr_match <= '1' when sd_cmd_arg(31 downto 16)=rca else '0'; 
  -- Create a signal that indicates when a "neverbad" command is received
  sd_cmd_neverbad <= '1' when sd_cmd_index=0 or sd_cmd_index=15 or sd_cmd_index=55 else '0';

--------------------------------------------
-- Card State Machine

card_fsm_proc: process(sd_clk_i, sys_rst_n)
begin
  if (sys_rst_n='0') then
    card_state <= CARD_PRE_IDLE;
    card_state_reply <= CARD_PRE_IDLE;
    r_delay    <= (others=>'0');
    rca        <= str2u("0001",16);
    dsr        <= str2u("0404",16);
    card_cmd_set       <= (others=>'0');
    card_adr           <= (others=>'0');
    card_blocklen      <= to_unsigned(512,card_blocklen'length);
    card_block_count   <= to_unsigned(0,card_block_count'length);
    card_dbus_size     <= "00";
    card_rel_wr_req    <= '0';
    card_erase_group_start <= (others=>'0');
    card_erase_group_end   <= (others=>'0');
    cmd6_op            <= (others=>'0');
    prg_dly_count      <= (others=>'0');
    dreply_start_count <= (others=>'0');
    crc_err_reply      <= '0';
    cmd_err_reply      <= '0';
    r1_start           <= '0';
    r2_cid_start       <= '0';
    r2_csd_start       <= '0';
    r3_start           <= '0';
    r4_start           <= '0';
    r5_start           <= '0';
    r4_reg_dat_wr      <= (others=>'0');
    r4_reg_adr         <= (others=>'0');
    r4_status          <= '0';
    r4_reg_we          <= '0';
    card_d_stop        <= '0';
    card_d_recv        <= '0';
    card_bustest_w     <= '0';
    card_d_busy_r1     <= '0';
    ocr_pwrup_done     <= '0'; -- low means busy

  elsif (sd_clk_i'event and sd_clk_i='1') then
    -- For edge detection
    card_d_busy_r1 <= card_d_busy;

    -- Default values
    r1_start     <= '0';
    r2_cid_start <= '0';
    r2_csd_start <= '0';
    r3_start     <= '0';
    r4_start     <= '0';
    r5_start     <= '0';

    r4_reg_we <= '0';
    cmd6_op   <= (others=>'0');
    card_bustest_w <= '0';
    card_d_stop  <= '0';
    card_d_recv  <= '0';

    -- Decrement the EXT_CSD readout delay timer
    if (dreply_start_count>0) then
      dreply_start_count <= dreply_start_count-1;
    end if;

    -- Decrement the programming delay timer
    if (prg_dly_count>0) then
      prg_dly_count <= prg_dly_count-1;
    end if;

    -- Clear certain status bits when reply is done
    if (r1_done='1') then
      crc_err_reply <= '0';
      cmd_err_reply <= '0';
    end if;
    -- Set CRC error status bit when errors are found
    if (sd_cmd_done='1' and sd_cmd_crc_err='1') then
      crc_err_reply <= '1';
    end if;

    -- Handle state transitions
    case (card_state) is
      when CARD_PRE_IDLE =>
        -- BOOT_PARTITION_ENABLE bit in EXT_CSD would be checked here
        -- but it is not currently supported, so just move on...
        card_state <= CARD_IDLE;
        -- IF BOOT_PARTITION_ENABLE were set, state would move to
        -- CARD_PRE_BOOT.

      when CARD_PRE_BOOT =>
        -- If sd_cmd_i is held low for >74 clocks, or if CMD0 is
        -- received with arg = 0xFFFFFFFA, then move to CARD_BOOT.
        -- NOTE: CMD0 is implemented outside of the FSM case statement,
        --       so be aware of that when implementing this special
        --       CMD0 with arg = 0xFFFFFFFA.
        -- but it is not currently supported, so just move on...
        card_state <= CARD_IDLE;
        -- If sd_cmd_i goes high in less than 74 clocks, or if
        -- "normal" CMD0 or CMD1 is received, move to CARD_IDLE

      when CARD_BOOT =>
        -- sd_cmd_i going high, or CMD0 with arg = 0x00000000
        -- moves to CARD_IDLE.  Meanwhile, all the while this
        -- state persists, continue sending boot data
        card_state <= CARD_IDLE;

      when CARD_IDLE =>
        if (sd_cmd_done='1' and sd_cmd_crc_err='0') then
          -- Look for SEND_OP_COND (CMD1)
          if (sd_cmd_index=1) then
            -- Here, check the sd_cmd_arg to see if the voltage range is
            -- compatible.  If it is not, then go to CARD_INA (inactive)
            -- state.  For this module, it is "inconceivable" that the
            -- requested voltage range would not be acceptable, so the
            -- check is not being performed.  But the reply is being given.
            r3_start <= '1';
            if (ocr_pwrup_done='1') then
              card_state <= CARD_READY;
            end if;
          elsif (sd_cmd_neverbad='0') then
            cmd_err_reply <= '1';
          end if;
        end if;
        -- When the R3 reply is finished, set the ocr_pwrup_done bit, to show
        -- that the card powerup status is no longer busy...  this is
        -- sketchy in the eMMC spec.  The card can stay in CARD_IDLE when
        -- it is busy.  We do this once, to match behavior of real cards.
        if (r3_done='1') then
          ocr_pwrup_done <= '1';
        end if;

      when CARD_READY =>
        if (sd_cmd_done='1' and sd_cmd_crc_err='0') then
          -- Look for ALL_SEND_CID (CMD2)
          if (sd_cmd_index=2) then
            -- Here, the idea in multi-card systems, is that each card sends
            -- out its 136 bit reply containing the CID.  All cards reply
            -- simultaneously, using open-drain drivers.  They are supposed
            -- to monitor the state of the sd_cmd_i line while sending their
            -- replies, to see if what they are seeing does not match what
            -- they are sending out.  If there is a mismatch, then the card
            -- "loses" the bus, and goes to the CARD_INA (inactive) state.
            --
            -- This implementation does not do the check, since in this case
            -- the assumption is made that there are no other cards present.
            --
            -- It's a pretty safe assumption, n'est-ce pas?
            -- So, this module expects to always "win" the bus!
            --
            r2_cid_start <= '1';
            card_state <= CARD_IDENT;
          elsif (sd_cmd_neverbad='0') then
            cmd_err_reply <= '1';
          end if;
        end if;

      when CARD_IDENT =>
        if (sd_cmd_done='1' and sd_cmd_crc_err='0') then
          -- Look for SET_RELATIVE_ADDR (CMD3)
          if (sd_cmd_index=3) then
            rca <= sd_cmd_arg(31 downto 16);
            r1_start <= '1';
            card_state_reply <= card_state;
            card_state <= CARD_STBY;
          elsif (sd_cmd_neverbad='0') then
            cmd_err_reply <= '1';
          end if;
        end if;

      when CARD_STBY =>
        -- Look for SET_DSR (CMD4), which has no reply
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=4) then
          dsr <= sd_cmd_arg(31 downto 16);
        end if;
        -- Look for SLEEP_AWAKE (CMD5), which toggles between CARD_STBY and CARD_SLP
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=5) then
          if sd_cmd_arg(15)='1' then
            r1_start <= '1';
            card_state_reply <= card_state;
            card_state <= CARD_SLP;
          end if;
        end if;
        -- Look for SELECT_CARD (CMD7)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=7) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_state <= CARD_TRAN;
        end if;
        -- Look for SEND_CSD (CMD9)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=9) then
          r2_csd_start <= '1';
        end if;
        -- Look for SEND_CID (CMD10)
        -- This is similar to CMD2, except only the addressed card responds...
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=10) then
          r2_cid_start <= '1';
        end if;
        -- Look for SEND_STATUS (CMD13)
        -- Per the spec, if a CRC error occurs, the card does not
        -- respond.  Therefore, the CRC error status bit is not
        -- reported until an R1 response is given to a later command
        -- that is received correctly.
        -- Hence, CMD13 is only executed if there is no CRC error.
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=13) then
          r1_start <= '1';
          card_state_reply <= card_state;
        end if;
        -- Look for GO_INACTIVE_STATE (CMD15), which has no reply
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=15) then
          card_state <= CARD_INA;
        end if;
        -- Look for FAST_IO (CMD39)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=39) then
          if (USE_R4_RESPONSE>0) then
            r4_start       <= '1';
            r4_status      <= sd_cmd_arg(15);
            r4_reg_adr     <= sd_cmd_arg(14 downto 8);
            r4_reg_dat_wr  <= sd_cmd_arg(7 downto 0);
            if (sd_cmd_arg(15)='1') then
              r4_reg_we <= '1';
            end if;
          end if;
        end if;
        -- Look for GO_IRQ_STATE (CMD40)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=40) then
          if (USE_R5_RESPONSE>0) then
            r5_start <= '1';
            card_state <= CARD_IRQ;
          end if;
        end if;
        -- Flag illegal commands
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_neverbad='0') then
          if (sd_cmd_index/= 4 and sd_cmd_index/= 5 and sd_cmd_index/= 7 and
              sd_cmd_index/= 9 and sd_cmd_index/=10 and sd_cmd_index/=13 and
              sd_cmd_index/=39 and sd_cmd_index/=40) then
            cmd_err_reply <= '1';
          end if;
        end if;

      when CARD_TRAN =>
        -- Look for SWITCH (CMD6)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=6) then
          r1_start <= '1';
          card_state_reply <= card_state;
          if (sd_cmd_arg(25 downto 24)=0) then
            card_cmd_set <= sd_cmd_arg(2 downto 0);
          else
            -- Setting the cmd6_op non-zero performs a write to ext_csd
            -- Different masking is done, based on the value
            cmd6_op <= sd_cmd_arg(25 downto 24);
          end if;
        end if;
        -- For CMD6, change states only when ext_csd processing is complete
        -- In reality, only a few clock cycles are needed for the processing,
        -- but it is convenient to simply wait for the response to finish.
        if (sd_cmd_index=6) then
          if (r1_done='1') then
            --prg_dly_count <= to_unsigned(4000,prg_dly_count'length); -- Programming delay (card is busy!)
            prg_dly_count <= to_unsigned(40,prg_dly_count'length); -- Programming delay (card is busy!)
            card_state <= CARD_PRG;
            -- "Operation Complete" returns from CARD_PRG back to CARD_TRAN.
            -- prg_dly_count determines the length of the programming time.
            -- The parts of the EXT_CSD that we really care about,
            -- are being "shadowed" as registers here, so capture them
            card_dbus_size <= ext_csd_sd_dat_rd(1 downto 0);
          end if;
        end if;
        -- Look for DESELECT_CARD (CMD7 without address match), which has no reply
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='0' and sd_cmd_index=7) then
          card_state <= CARD_STBY;
        end if;
        -- Look for SEND_EXT_CSD (CMD8)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=8) then
          r1_start <= '1';
          card_state_reply <= card_state;
          dreply_start_count <= to_unsigned(N_CD,D_BITS); -- Set the data readout delay counter
          card_block_count <= to_unsigned(1,card_block_count'length);
          card_state <= CARD_DATA;
        end if;
        -- Look for READ_DAT_UNTIL_STOP (CMD11)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=11) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_adr <= sd_cmd_arg;
          dreply_start_count <= to_unsigned(N_CD,D_BITS); -- Set the data readout delay counter
          card_state <= CARD_DATA;
        end if;
        -- Look for SEND_STATUS (CMD13)
        -- Per the spec, if a CRC error occurs, the card does not
        -- respond.  Therefore, the CRC error status bit is not
        -- reported until an R1 response is given to a later command
        -- that is received correctly.
        -- Hence, CMD13 is only executed if there is no CRC error.
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=13) then
          r1_start <= '1';
          card_state_reply <= card_state;
        end if;
        -- Look for GO_INACTIVE_STATE (CMD15), which has no reply
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=15) then
          card_state <= CARD_INA;
        end if;
        -- Look for SET_BLOCKLEN (CMD16)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=16) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_blocklen <= sd_cmd_arg(card_blocklen'length-1 downto 0);
        end if;
        -- Look for READ_SINGLE_BLOCK (CMD17)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=17) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_adr <= sd_cmd_arg;
          card_block_count   <= to_unsigned(1,card_block_count'length);
          dreply_start_count <= to_unsigned(N_CD,D_BITS); -- Set the data readout delay counter
          card_state <= CARD_DATA;
        end if;
        -- Look for READ_MULTIPLE_BLOCK (CMD18)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=18) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_adr <= sd_cmd_arg;
          dreply_start_count <= to_unsigned(N_CD,D_BITS); -- Set the data readout delay counter
          card_state <= CARD_DATA;
        end if;
        -- Look for BUSTEST_W (CMD19)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=19) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_bustest_w <= '1';
          card_state <= CARD_BTST;
        end if;
        -- Look for WRITE_DAT_UNTIL_STOP (CMD20)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=20) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_adr <= sd_cmd_arg;
          card_d_recv <= '1';
          card_state <= CARD_RCV;
        end if;
        -- Look for SET_BLOCK_COUNT (CMD23)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=23) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_block_count <= sd_cmd_arg(15 downto 0);
          card_rel_wr_req <= sd_cmd_arg(31);
        end if;
        -- Look for WRITE_BLOCK (CMD24)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=24) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_adr <= sd_cmd_arg;
          card_block_count <= to_unsigned(1,card_block_count'length);
          card_d_recv <= '1';
          card_state <= CARD_RCV;
        end if;
        -- Look for WRITE_MULTIPLE_BLOCK (CMD25)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=25) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_adr <= sd_cmd_arg;
          card_d_recv <= '1';
          card_state <= CARD_RCV;
        end if;
        -- Look for PROGRAM_CSD (CMD27)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=27) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_state <= CARD_RCV;
        end if;
        -- Look for SET_WRITE_PROT (CMD28)
        -- Currently there is no write protection in this emulated card.
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=28 and IMPLEMENT_WRITE_PROT>0) then
          r1_start <= '1';
          card_state_reply <= card_state;
          prg_dly_count <= to_unsigned(4000,prg_dly_count'length); -- Programming delay (card is busy!)
          card_state <= CARD_PRG;
        end if;
        -- Look for CLR_WRITE_PROT (CMD29)
        -- Currently there is no write protection in this emulated card.
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=29 and IMPLEMENT_WRITE_PROT>0) then
          r1_start <= '1';
          card_state_reply <= card_state;
          prg_dly_count <= to_unsigned(4000,prg_dly_count'length); -- Programming delay (card is busy!)
          card_state <= CARD_PRG;
        end if;
        -- Look for SEND_WRITE_PROT (CMD30)
        -- Currently there is no write protection in this emulated card.
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=30 and IMPLEMENT_WRITE_PROT>0) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_state <= CARD_DATA;
        end if;
        -- Look for SEND_WRITE_PROT_TYPE (CMD31)
        -- Currently there is no write protection in this emulated card.
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=31 and IMPLEMENT_WRITE_PROT>0) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_state <= CARD_DATA;
        end if;
        -- Look for ERASE_GROUP_START (CMD35)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=35) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_erase_group_start <= sd_cmd_arg;
        end if;
        -- Look for ERASE_GROUP_END (CMD36)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=36) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_erase_group_end <= sd_cmd_arg;
        end if;
        -- Look for ERASE (CMD38)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=38) then
          r1_start <= '1';
          card_state_reply <= card_state;
          prg_dly_count <= to_unsigned(4000,prg_dly_count'length); -- Programming delay for erase (card is busy!)
          card_state <= CARD_PRG;
        end if;
        -- Look for LOCK_UNLOCK (CMD42)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=42) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_state <= CARD_RCV;
        end if;
        -- Flag illegal commands
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_neverbad='0') then
          if (sd_cmd_index< 6 or sd_cmd_index= 9 or sd_cmd_index=10 or
              sd_cmd_index=12 or sd_cmd_index=14 or sd_cmd_index=21 or
              sd_cmd_index=22 or sd_cmd_index=26 or sd_cmd_index=32 or
              sd_cmd_index=33 or sd_cmd_index=34 or sd_cmd_index=37 or
              sd_cmd_index=39 or sd_cmd_index=40 or sd_cmd_index=41 or
              sd_cmd_index>42) then
            cmd_err_reply <= '1';
          end if;
        end if;

      when CARD_DATA =>
        -- Look for DESELECT_CARD (CMD7 without address match), which has no reply
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='0' and sd_cmd_index=7) then
          card_state <= CARD_STBY;
        end if;
        -- Look for STOP_TRANSMISSION (CMD12)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=12) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_d_stop <= '1';
          card_block_count <= to_unsigned(0,card_block_count'length);
          card_state <= CARD_TRAN;
        end if;
        -- Look for SEND_STATUS (CMD13)
        -- Per the spec, if a CRC error occurs, the card does not
        -- respond.  Therefore, the CRC error status bit is not
        -- reported until an R1 response is given to a later command
        -- that is received correctly.
        -- Hence, CMD13 is only executed if there is no CRC error.
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=13) then
          r1_start <= '1';
          card_state_reply <= card_state;
        end if;
        -- Look for GO_INACTIVE_STATE (CMD15), which has no reply
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=15) then
          card_state <= CARD_INA;
        end if;
        -- Flag illegal commands
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_neverbad='0') then
          if (sd_cmd_index/= 7 and sd_cmd_index/=12 and sd_cmd_index/=13) then
            cmd_err_reply <= '1';
          end if;
        end if;
        -- check for various "operation complete" conditions
        if (card_d_busy='0' and card_d_busy_r1='1') then -- falling edge
          -- For completion of CMD8 (SEND_EXT_CSD), change states
          -- Change states for CMD8, CMD11, CMD17, CMD18, CMD30 or CMD56(read).
          -- To make this easy, do not filter on the command index, just
          -- make the transition, assuming that the data transaction which
          -- just ended resulted from one of the listed commands.
          --if (sd_cmd_index=8) then
          card_block_count <= to_unsigned(0,card_block_count'length);
          card_state <= CARD_TRAN;
          --end if;
        end if;

      when CARD_BTST =>
        -- Look for SEND_STATUS (CMD13)
        -- Per the spec, if a CRC error occurs, the card does not
        -- respond.  Therefore, the CRC error status bit is not
        -- reported until an R1 response is given to a later command
        -- that is received correctly.
        -- Hence, CMD13 is only executed if there is no CRC error.
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=13) then
          r1_start <= '1';
          card_state_reply <= card_state;
        end if;
        -- Look for BUSTEST_R (CMD14)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=14) then
          r1_start <= '1';
          card_state_reply <= card_state;
          dreply_start_count <= to_unsigned(N_CD,D_BITS); -- Set the data readout delay counter
          card_state <= CARD_TRAN;
        end if;
        -- Look for GO_INACTIVE_STATE (CMD15), which has no reply
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=15) then
          card_state <= CARD_INA;
        end if;
        -- Flag illegal commands
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_neverbad='0') then
          if (sd_cmd_index/=13 and sd_cmd_index/=14) then
            cmd_err_reply <= '1';
          end if;
        end if;

      when CARD_RCV =>
        -- Look for STOP_TRANSMISSION (CMD12)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=12) then
          r1_start <= '1';
          card_state_reply <= card_state;
          card_d_stop <= '1';
          card_block_count <= to_unsigned(0,card_block_count'length);
          card_state <= CARD_PRG; -- sd_card_data_unit handles busy indication for this case.
        end if;
        -- Check for various "operation complete" conditions
        if (card_d_busy='0' and card_d_busy_r1='1') then -- falling edge
          -- Change states for CMD24, CMD25, CMD26, CMD27, CMD42 or CMD56(write).
          -- To make this easy, do not filter on the command index, just
          -- make the transition, assuming that the data transaction which
          -- just ended resulted from one of the listed commands.
          card_block_count <= to_unsigned(0,card_block_count'length);
          card_state <= CARD_PRG; -- sd_card_data_unit handles busy indication for this case.
        end if;
        -- Look for SEND_STATUS (CMD13)
        -- Per the spec, if a CRC error occurs, the card does not
        -- respond.  Therefore, the CRC error status bit is not
        -- reported until an R1 response is given to a later command
        -- that is received correctly.
        -- Hence, CMD13 is only executed if there is no CRC error.
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=13) then
          r1_start <= '1';
          card_state_reply <= card_state;
        end if;
        -- Look for GO_INACTIVE_STATE (CMD15), which has no reply
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=15) then
          card_state <= CARD_INA;
        end if;
        -- Flag illegal commands
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_neverbad='0') then
          if (sd_cmd_index/=12 and sd_cmd_index/=13) then
            cmd_err_reply <= '1';
          end if;
        end if;

      -- Within this state, use card_cmd_arg directly for command input, including the address.
      when CARD_PRG =>
        -- Look for DESELECT_CARD (CMD7 without address match), which has no reply
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='0' and sd_cmd_index=7) then
          card_state <= CARD_DIS;
        end if;
        -- Look for SEND_STATUS (CMD13)
        -- Per the spec, if a CRC error occurs, the card does not
        -- respond.  Therefore, the CRC error status bit is not
        -- reported until an R1 response is given to a later command
        -- that is received correctly.
        -- Hence, CMD13 is only executed if there is no CRC error.
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=13) then
          r1_start <= '1';
          card_state_reply <= card_state;
        end if;
        -- If the programming timer expires, then consider that the programming
        -- operation is complete.  Return to CARD_TRAN state.  In a real card, this
        -- CARD_PRG state would be actual flash programming time, but in our emulated
        -- card, the programming time is merely emulated.
        -- Delay, with accompanying card busy indication, is implemented explicitly
        -- here, by prg_dly_count, for:
        --   CMD6, CMD28, CMD29 and CMD38.
        -- A signal from sd_card_data_unit, controls the assertion of the card
        -- busy indicator during CARD_RCV state.
        if (prg_dly_count=0) then
          card_state <= CARD_TRAN;
        end if;
        -- Look for GO_INACTIVE_STATE (CMD15), which has no reply
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=15) then
          prg_dly_count <= (others=>'0');
          card_state <= CARD_INA;
        end if;
        -- A host should not issue this while busy is active and card is in this state
        -- Look for WRITE_BLOCK (CMD24)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=24) then
          r1_start <= '1';
          card_state_reply <= card_state;
          prg_dly_count <= (others=>'0');
          card_state <= CARD_RCV;
          card_adr <= sd_cmd_arg;
        end if;
        -- A host should not issue this while busy is active and card is in this state
        -- Look for WRITE_MULTIPLE_BLOCK (CMD25)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=25) then
          r1_start <= '1';
          card_state_reply <= card_state;
          prg_dly_count <= (others=>'0');
          card_state <= CARD_RCV;
          card_adr <= sd_cmd_arg;
        end if;
        -- Flag illegal commands
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_neverbad='0') then
          if (sd_cmd_index/= 7 and sd_cmd_index/=13 and
              sd_cmd_index/=24 and sd_cmd_index/=25) then
            cmd_err_reply <= '1';
          end if;
        end if;

      when CARD_DIS =>
        -- Look for SELECT_CARD (CMD7)
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=7) then
          r1_start <= '1';
          card_state_reply <= card_state;
          prg_dly_count <= to_unsigned(4000,prg_dly_count'length);
          card_state <= CARD_PRG;
        end if;
        -- Look for SEND_STATUS (CMD13)
        -- Per the spec, if a CRC error occurs, the card does not
        -- respond.  Therefore, the CRC error status bit is not
        -- reported until an R1 response is given to a later command
        -- that is received correctly.
        -- Hence, CMD13 is only executed if there is no CRC error.
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=13) then
          r1_start <= '1';
          card_state_reply <= card_state;
        end if;
        -- Look for GO_INACTIVE_STATE (CMD15), which has no reply
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=15) then
          card_state <= CARD_INA;
        end if;
        -- Flag illegal commands
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_neverbad='0') then
          if (sd_cmd_index/= 7 and sd_cmd_index/=13) then
            cmd_err_reply <= '1';
          end if;
        end if;

      when CARD_INA =>
        -- This state is pretty much a "dead end"
        -- Only reset can get out of it.
        null;

      when CARD_SLP =>
        -- Look for SLEEP_AWAKE (CMD5), which toggles between CARD_STBY and CARD_SLP
        if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_adr_match='1' and sd_cmd_index=5) then
          if sd_cmd_arg(15)='0' then
            r1_start <= '1';
            card_state_reply <= card_state;
            card_state <= CARD_STBY;
          end if;
        end if;
        -- Flag illegal commands
        if (sd_cmd_done='1' and sd_cmd_crc_err='0') then
          if (sd_cmd_index/= 0 and sd_cmd_index/= 5) then
            cmd_err_reply <= '1';
          end if;
        end if;

      when CARD_IRQ =>
        -- In reality, there is supposed to be some IRQ event which occurs
        -- before the R5 response is given.  No such events are implemented
        -- in this card, but if they were, it would be cool to just reset a
        -- timer or counter, in the manner of kicking a watchdog timer, until
        -- the event trigger occurs, then issue the r5_start pulse.
        -- The host has a mechanism for generating a "pseudo reply" at RCA
        -- of 0x0000, which is supposed to cause this state to exit.
        -- 
        -- "Any start bit on the bus" exits this state
        -- The method used here is to wait for the command to finish
        -- being received, instead of actually looking for the start
        -- bit...
        if (sd_cmd_done='1' and sd_cmd_crc_err='0') then
          if (sd_cmd_index/=55) then
            card_state <= CARD_STBY;
          end if;
        end if;

      when others =>
        card_state <= CARD_IDLE;
    end case;
    -- CMD0 affects nearly all states the same way, so it is coded here.
    if (sd_cmd_done='1' and sd_cmd_crc_err='0' and sd_cmd_index=0) then
      if (card_state/=CARD_INA and card_state/=CARD_IRQ) then
        ocr_pwrup_done <= '0';
        card_dbus_size <= "00"; -- Revert back to single data bit
        rca <= str2u("0001",16);
        dsr <= str2u("0404",16);
        card_cmd_set <= (others=>'0');
        if (sd_cmd_arg=0) then
          card_state <= CARD_IDLE;
        else
          card_state <= CARD_PRE_IDLE;
        end if;
      end if;
    end if;
  end if; -- sd_clk_i
end process;

--------------------------------------------
-- Response Transmitters

  R1_responder: sd_card_responder
  generic map(
    N_CR          => N_CR,
    RESP_PYLD_LEN => 32,
    CRC_OFFSET    =>  0, -- Start CRC calculation after this many bits
    CRC_SEND_ONES =>  0
  )
  port map(
    -- Asynchronous reset
    sys_rst_n     => sys_rst_n,
    -- SD/MMC card command signals
    sd_clk_i      => sd_clk_i,
    sd_cmd_o      => r1_cmd,
    sd_cmd_oe_o   => r1_cmd_oe,
    -- Response inputs
    resp_index_i  => sd_cmd_index,
    resp_pyld_i   => reported_status,
    respond_i     => r1_start,
    -- Status and done indicator
    done_o        => r1_done, -- A one clock long pulse
    busy_o        => open
  );
  -- Create a status report.  Some fields are read only.
  reported_status(31 downto 24) <= status(31 downto 24);
  reported_status(23) <= crc_err_reply;
  reported_status(22) <= cmd_err_reply;
  reported_status(21 downto 13) <= status(21 downto 13);
  with card_state_reply select
  reported_status(12 downto 9) <=
    "0000" when CARD_IDLE,
    "0001" when CARD_READY,
    "0010" when CARD_IDENT,
    "0011" when CARD_STBY,
    "0100" when CARD_TRAN,
    "0101" when CARD_DATA,
    "0110" when CARD_RCV,
    "0111" when CARD_PRG,
    "1000" when CARD_DIS,
    "1001" when CARD_BTST,
    "1010" when CARD_SLP,
    "1011" when others;
  reported_status(8) <= '1'; -- Buffers are empty!
  reported_status(7 downto 0) <= status(7 downto 0);

  R2_CID_responder: sd_card_responder
  generic map(
    N_CR          => N_CR,
    RESP_PYLD_LEN => 120,
    CRC_OFFSET    =>   8, -- Start CRC calculation after this many bits
    CRC_SEND_ONES =>   0
  )
  port map(
    -- Asynchronous reset
    sys_rst_n     => sys_rst_n,
    -- SD/MMC card command signals
    sd_clk_i      => sd_clk_i,
    sd_cmd_o      => r2_cid_cmd,
    sd_cmd_oe_o   => r2_cid_cmd_oe,
    -- Response inputs
    resp_index_i  => "111111",
    resp_pyld_i   => cid_resp,
    respond_i     => r2_cid_start,
    -- Status and done indicator
    done_o        => r2_cid_done, -- A one clock long pulse
    busy_o        => open
  );

  R2_CSD_responder: sd_card_responder
  generic map(
    N_CR          => N_CR,
    RESP_PYLD_LEN => 120,
    CRC_OFFSET    =>   8, -- Start CRC calculation after this many bits
    CRC_SEND_ONES =>   0
  )
  port map(
    -- Asynchronous reset
    sys_rst_n     => sys_rst_n,
    -- SD/MMC card command signals
    sd_clk_i      => sd_clk_i,
    sd_cmd_o      => r2_csd_cmd,
    sd_cmd_oe_o   => r2_csd_cmd_oe,
    -- Response inputs
    resp_index_i  => "111111",
    resp_pyld_i   => csd_resp,
    respond_i     => r2_csd_start,
    -- Status and done indicator
    done_o        => r2_csd_done, -- A one clock long pulse
    busy_o        => open
  );

  R3_responder: sd_card_responder
  generic map(
    N_CR          => N_ID,
    RESP_PYLD_LEN => 32,
    CRC_OFFSET    =>  0, -- Start CRC calculation after this many bits
    CRC_SEND_ONES =>  1
  )
  port map(
    -- Asynchronous reset
    sys_rst_n     => sys_rst_n,
    -- SD/MMC card command signals
    sd_clk_i      => sd_clk_i,
    sd_cmd_o      => r3_cmd,
    sd_cmd_oe_o   => r3_cmd_oe,
    -- Response inputs
    resp_index_i  => "111111",
    resp_pyld_i   => ocr,
    respond_i     => r3_start,
    -- Status and done indicator
    done_o        => r3_done, -- A one clock long pulse
    busy_o        => open
  );

  R4_responder: sd_card_responder
  generic map(
    N_CR          => N_CR,
    RESP_PYLD_LEN => 32,
    CRC_OFFSET    =>  0, -- Start CRC calculation after this many bits
    CRC_SEND_ONES =>  0
  )
  port map(
    -- Asynchronous reset
    sys_rst_n     => sys_rst_n,
    -- SD/MMC card command signals
    sd_clk_i      => sd_clk_i,
    sd_cmd_o      => r4_cmd,
    sd_cmd_oe_o   => r4_cmd_oe,
    -- Response inputs
    resp_index_i  => "100111",
    resp_pyld_i   => fast_io_reg_rd,
    respond_i     => r4_start,
    -- Status and done indicator
    done_o        => r4_done, -- A one clock long pulse
    busy_o        => open
  );
  -- Assign response for R4
  fast_io_reg_rd <= rca & r4_status & r4_reg_adr & r4_reg_dat_rd;

  -- An interesting idea : Add a CMD39 "R4" register read/write bus port
  -- to the top level of this module, if this function of reading and
  -- writing special registers becomes important and/or useful enough
  -- to justify the effort.

  -- CMD39 "FAST_IO" register read mux
  with to_integer(r4_reg_adr) select
  r4_reg_dat_rd <=
    r4_reg_0         when 0,
    r4_reg_1         when 1,
    "10100101"       when others;

  -- CMD39 "FAST_IO" register writes are handled here
  reg_proc: process(sd_clk_i, sys_rst_n)
  begin
    if (sys_rst_n='0') then
      r4_reg_0 <= (others=>'0');
      r4_reg_1 <= (others=>'0');
    elsif (sd_clk_i'event and sd_clk_i='1') then
      if (r4_reg_we='1') then
        case to_integer(adr_i) is
          when 0 =>
            r4_reg_0 <= r4_reg_dat_wr;
          when 1 =>
            r4_reg_1 <= r4_reg_dat_wr;
          when others => null;
        end case;
      end if;
    end if; -- sd_clk_i
  end process;


  R5_responder: sd_card_responder
  generic map(
    N_CR          => N_CR,
    RESP_PYLD_LEN => 32,
    CRC_OFFSET    =>  0, -- Start CRC calculation after this many bits
    CRC_SEND_ONES =>  0
  )
  port map(
    -- Asynchronous reset
    sys_rst_n     => sys_rst_n,
    -- SD/MMC card command signals
    sd_clk_i      => sd_clk_i,
    sd_cmd_o      => r5_cmd,
    sd_cmd_oe_o   => r5_cmd_oe,
    -- Response inputs
    resp_index_i  => "101000",
    resp_pyld_i   => irq_response,
    respond_i     => r5_start,
    -- Status and done indicator
    done_o        => r5_done, -- A one clock long pulse
    busy_o        => open
  );
  -- Assign response for R5
  irq_response <= rca & to_unsigned(0,16);

-- Select which response gets driven out
sd_cmd_o <= r1_cmd     when r1_cmd_oe='1' else
            r2_cid_cmd when r2_cid_cmd_oe='1' else
            r2_csd_cmd when r2_csd_cmd_oe='1' else
            r3_cmd     when r3_cmd_oe='1' else
            r4_cmd     when r4_cmd_oe='1' and USE_R4_RESPONSE>0 else
            r5_cmd     when r5_cmd_oe='1' and USE_R5_RESPONSE>0 else
            '1';

  -- NOTE: If multiple responders are active at the same time, then
  --       the drive signal may not be correct, so don't do that!
sd_cmd_oe_l <= '1' when r1_cmd_oe='1' or r2_cid_cmd_oe='1' or
                        r2_csd_cmd_oe='1' or r3_cmd_oe='1' or
                        (r4_cmd_oe='1' and USE_R4_RESPONSE>0) or
                        (r5_cmd_oe='1' and USE_R5_RESPONSE>0) else
                '0';
sd_cmd_oe_o <= sd_cmd_oe_l;

sd_od_mode_o <= '1' when card_state=CARD_INA      or card_state=CARD_PRE_IDLE or
                         card_state=CARD_PRE_BOOT or card_state=CARD_IDLE     or
                         card_state=CARD_READY    or card_state=CARD_IDENT    or
                         card_state=CARD_IRQ else '0';

-- SD/MMC data handling unit
  sd_card_d_handler : sd_card_data_unit
  generic map(
    BLK_PRG_TIME => 200, -- Number of clocks to program a sector in FLASH (emulated)
    BLKSIZE_W    => card_blocklen'length,
    BLKCNT_W     => card_block_count'length
  )
  port map(
    sd_clk_i      => sd_clk_i,
    sys_rst_n     => sys_rst_n,
    --Tx Fifo
    tx_dat_i      => card_tx_dat,
    tx_dat_rd_o   => card_tx_dat_rd,
    --Rx Fifo
    rx_dat_o      => buf_dat_o,
    rx_dat_we_o   => buf_dat_we_l,
    --SD data
    sd_dat_i      => sd_dat_i,
    sd_dat_o      => sd_dat_unbusy,
    sd_dat_oe_o   => sd_dat_oe_unbusy,
    --Control signals
    blksize_i     => card_blocklen,
    bus_size_i    => card_dbus_size,
    blkcnt_i      => card_block_count,
    continuous_i  => card_d_continuous,
    d_stop_i      => card_d_stop,
    d_read_i      => card_d_recv,
    d_write_i     => card_d_send,
    bustest_w_i   => card_bustest_w, -- Receives bustest pattern
    bustest_r_i   => card_bustest_r, -- Sends bustest pattern out
    sd_dat_busy_o => card_sd_dat_busy,
    fsm_busy_o    => card_d_busy,
    crc_ok_o      => card_d_crc_ok
  );

-- Indicate when the card is busy, based on state of this state machine,
-- and the state in sd_card_data_unit.  The output enable signal is also
-- controlled, to ensure that the busy indicator is asserted.
sd_dat_o <= (sd_dat_unbusy and "11111110") when card_sd_dat_busy='1' or (card_state=CARD_PRG and prg_dly_count>0) else sd_dat_unbusy;
sd_dat_oe_o <= '1' when card_state=CARD_PRG and prg_dly_count>0 else sd_dat_oe_unbusy;

-- Provide special override for bus size, when BUSTEST is being used.
sd_dat_siz_o <= "10" when sd_cmd_index=14 else card_dbus_size; -- Drive entire bus for BUSTEST_R response

-- Provide write enable output for data buffers
buf_dat_we_o <= buf_dat_we_l;

-- Provide address to be used for steering data to and from
-- the correct FIFO buffers.
  adr_offset_proc: process(sd_clk_i, sys_rst_n)
  begin
    if (sys_rst_n='0') then
      adr_offset <= (others=>'0');
    elsif (sd_clk_i'event and sd_clk_i='1') then
      if (buf_dat_we_l='1' or (card_tx_dat_rd='1' and sd_cmd_index/=8)) then -- Do not increment for CMD8 (EXT_CSD_READ)
        adr_offset <= adr_offset+1;
      end if;
      if (card_d_recv='1' or card_d_send='1') then
        adr_offset <= (others=>'0');
      end if;
    end if; -- sd_clk_i
  end process;

buf_adr_o <= card_adr(buf_adr_o'length-1 downto 0) + adr_offset;

-- Select which data source is transmitted.
card_tx_dat <= ext_csd_sd_dat_rd when sd_cmd_index=8 else buf_dat_i; -- CMD8 returns EXT_CSD as data...
buf_dat_rd_o <= '0' when sd_cmd_index=8 else card_tx_dat_rd;

-- Indicate to sd_card_data_unit when continous data transfer is needed
card_d_continuous <= '1' when (sd_cmd_index=11 or sd_cmd_index=20) else '0';
-- Start a transmit operation, when needed
card_d_send <= '1' when (sd_cmd_index=8 or sd_cmd_index=11 or sd_cmd_index=17 or sd_cmd_index=18) and dreply_start_count=1 else '0';
-- Start sending bustest response data, when needed
card_bustest_r <= '1' when sd_cmd_index=14 and dreply_start_count=1 else '0';

end beh;

-------------------------------------------------------------------------------
-- MMC Data Pipe
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update: May  12, 2016 Wrote description and assembled the needed modules
--
-- Description
-------------------------------------------------------------------------------
-- This module is meant to emulate an SD/MMC card, but instead of having a
-- vast FLASH based storage array, it provides a simple set of data FIFOs
-- and a small RAM.
--
-- MMC sectors of 512 bytes are mapped into the RAM.  These are the lowest
-- addresses of the card address space.  All addresses higher than the end
-- of the RAM block are mapped to the FIFOs.  Data written to the card ends
-- up in one FIFO, while data read from the card is taken from the other FIFO.
--
-- The unit is currently set up to use MMC byte addressing mode.  Sector
-- addressing could also be enabled if desired.  Just set the EXT_CSD correctly,
-- and then change the generic OCR_USE_SECTOR_MODE to a nonzero value on the
-- sd_card_emulator unit.
--
-- Note that the FIFOs are "clock domain crossing" type.  The thing to remember
-- with them is that the fifo empty, full and fill_level status is not
-- synchronized to the local clock domain.  The user is free to perform that
-- synchronization or not, as desired, and incur the additional delay that it
-- brings, or not.
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.fifo_pack.all;
use work.convert_pack.all;
use work.sd_card_pack.all;
use work.block_ram_pack.all;

  entity mmc_data_pipe is
  generic (
    EXT_CSD_INIT_FILE : string  := "ext_csd_init.txt"; -- Initial contents of EXT_CSD
    FIFO_DEPTH        : integer := 2048;
    FILL_LEVEL_BITS   : integer :=   12; -- Should be at least int(floor(log2(FIFO_DEPTH))+1.0)
    RAM_ADR_WIDTH     : integer :=   14  -- 16 Kilobytes
  );
  port (

    -- Asynchronous reset
    sys_rst_n     : in  std_logic;
    sys_clk       : in  std_logic;

    -- Bus interface
    adr_i         : in  unsigned(3 downto 0);
    sel_i         : in  std_logic;
    we_i          : in  std_logic;
    dat_i         : in  unsigned(31 downto 0);
    dat_o         : out unsigned(31 downto 0);
    ack_o         : out std_logic;

    -- SD/MMC card signals
    mmc_clk_i     : in  std_logic;
    mmc_cmd_i     : in  std_logic;
    mmc_cmd_o     : out std_logic;
    mmc_cmd_oe_o  : out std_logic;
    mmc_od_mode_o : out std_logic; -- Open drain mode
    mmc_dat_i     : in  unsigned(7 downto 0);
    mmc_dat_o     : out unsigned(7 downto 0);
    mmc_dat_oe_o  : out std_logic;
    mmc_dat_siz_o : out unsigned(1 downto 0);

    -- Data Pipe FIFOs
    wr_clk_i      : in  std_logic;
    wr_clk_en_i   : in  std_logic;
    wr_reset_i    : in  std_logic;  -- Synchronous
    wr_en_i       : in  std_logic;
    wr_dat_i      : in  unsigned(7 downto 0);
    wr_fifo_level : out unsigned(FILL_LEVEL_BITS-1 downto 0);
    wr_fifo_full  : out std_logic;
    wr_fifo_empty : out std_logic;

    rd_clk_i      : in  std_logic;
    rd_clk_en_i   : in  std_logic;
    rd_reset_i    : in  std_logic;  -- Synchronous
    rd_en_i       : in  std_logic;
    rd_dat_o      : out unsigned(7 downto 0);
    rd_fifo_level : out unsigned(FILL_LEVEL_BITS-1 downto 0);
    rd_fifo_full  : out std_logic;
    rd_fifo_empty : out std_logic;

    -- Data Pipe RAM
    ram_clk_i     : in  std_logic;
    ram_clk_en_i  : in  std_logic;
    ram_adr_i     : in  unsigned(RAM_ADR_WIDTH-1 downto 0);
    ram_we_i      : in  std_logic;
    ram_dat_i     : in  unsigned(7 downto 0);
    ram_dat_o     : out unsigned(7 downto 0)
  );
  end mmc_data_pipe;

architecture beh of mmc_data_pipe is

-- constants
constant N_ID   : integer := 5; -- Number of clocks before response in card ID mode

-- signals
signal buf_adr             : unsigned(31 downto 0);
signal buf_dat_from_host   : unsigned(7 downto 0);
signal buf_dat_we          : std_logic;
signal buf_dat_to_host     : unsigned(7 downto 0);
signal buf_dat_rd          : std_logic;
signal fifo_dat_rd         : std_logic;
signal fifo_dat_to_host    : unsigned(7 downto 0);
signal ram_dat_to_host     : unsigned(7 downto 0);
signal fifo_we             : std_logic;
signal ram_we              : std_logic;

begin

-- Instantiate the MMC
mmc_1 : sd_card_emulator
  generic map(
    USE_R4_RESPONSE      => 0, -- Fast I/O read/write (app specific)
    USE_R5_RESPONSE      => 0, -- Interrupt Request Mode
    EXT_CSD_INIT_FILE    => EXT_CSD_INIT_FILE, -- Initial contents of EXT_CSD
    OCR_USE_DUAL_VOLTAGE => 0,
    OCR_USE_SECTOR_MODE  => 0,
    CID_MID    => str2u("45",8), -- Manufacturer ID
    CID_OID    => str2u("77",8), -- OEM ID
    CID_CBX    => "00", -- 0=Card, 1=BGA, 2=Package On Package
    CID_PNM    => str2u("434152444953",48), -- Product Name, 6 ASCII chars
    CID_PRV    => str2u("01",8), -- Product Rev (2 BCD digits, e.g. 6.2=0x62)
    CID_PSN    => str2u("00000012",32), -- Product serial number
    CID_MDT    => str2u("43",8), -- Manufacture Date (Jan=1, 1997=0, e.g. Apr. 2000=0x43)
    DEF_STAT   => str2u("00000000",32), -- Read Write, R_0
    CSD_WORD_3 => str2u("905E002A",32), -- See MMC spec
    CSD_WORD_2 => str2u("1F5903D3",32), -- See MMC spec
    CSD_WORD_1 => str2u("EDB707FF",32), -- See MMC spec
    CSD_WORD_0 => str2u("96400000",32), -- See MMC spec, bits (7:0) not used
    DEF_R_Z    => str2u("33333333",32)  -- Value returned for nonexistent registers
  )
  port map(

    -- Asynchronous reset
    sys_rst_n     => sys_rst_n,
    sys_clk       => sys_clk,

    -- Bus interface
    adr_i         => adr_i,
    sel_i         => sel_i,
    we_i          => we_i,
    dat_i         => dat_i,
    dat_o         => dat_o,
    ack_o         => ack_o,

    -- SD/MMC card command signals
    sd_clk_i      => mmc_clk_i,
    sd_cmd_i      => mmc_cmd_i,
    sd_cmd_o      => mmc_cmd_o,
    sd_cmd_oe_o   => mmc_cmd_oe_o,
    sd_od_mode_o  => mmc_od_mode_o, -- Open drain mode
    sd_dat_i      => mmc_dat_i,
    sd_dat_o      => mmc_dat_o,
    sd_dat_oe_o   => mmc_dat_oe_o,
    sd_dat_siz_o  => mmc_dat_siz_o,

    -- Data FIFO interface
    buf_adr_o     => buf_adr,
    buf_dat_o     => buf_dat_from_host,
    buf_dat_we_o  => buf_dat_we,
    buf_dat_i     => buf_dat_to_host,
    buf_dat_rd_o  => buf_dat_rd  -- Used by FIFOs only.
  );
  -- Select the appropriate data to return to the host
  buf_dat_to_host <= ram_dat_to_host when buf_adr(buf_adr'length-1 downto RAM_ADR_WIDTH)=0 else fifo_dat_to_host;

-- Instantiate the FIFOs
  fifo_from_mmc : swiss_army_fifo_cdc
    generic map(
      USE_BRAM         => 1, -- Set to nonzero value for BRAM, zero for distributed RAM
      WIDTH            => 8,
      DEPTH            => FIFO_DEPTH,
      FILL_LEVEL_BITS  => FILL_LEVEL_BITS, -- Should be at least int(floor(log2(DEPTH))+1.0)
      PF_FULL_POINT    => FIFO_DEPTH-1,
      PF_FLAG_POINT    => 512,
      PF_EMPTY_POINT   => 1
    )
    port map(
      sys_rst_n        => sys_rst_n, -- Asynchronous

      wr_clk_i         => mmc_clk_i,
      wr_clk_en_i      => '1',
      wr_reset_i       => '0',  -- Synchronous
      wr_en_i          => fifo_we,
      wr_dat_i         => buf_dat_from_host,
      wr_fifo_level    => open,
      wr_fifo_full     => open,
      wr_fifo_empty    => open,
      wr_fifo_pf_full  => open,
      wr_fifo_pf_flag  => open,
      wr_fifo_pf_empty => open,

      rd_clk_i         => rd_clk_i,
      rd_clk_en_i      => rd_clk_en_i,
      rd_reset_i       => rd_reset_i,  -- Synchronous
      rd_en_i          => rd_en_i,
      rd_dat_o         => rd_dat_o,
      rd_fifo_level    => rd_fifo_level,
      rd_fifo_full     => rd_fifo_full,
      rd_fifo_empty    => rd_fifo_empty,
      rd_fifo_pf_full  => open,
      rd_fifo_pf_flag  => open,
      rd_fifo_pf_empty => open

    );
    fifo_we <= '1' when buf_dat_we='1' and buf_adr(buf_adr'length-1 downto RAM_ADR_WIDTH)>0 else '0';

  fifo_to_mmc : swiss_army_fifo_cdc
    generic map(
      USE_BRAM         => 1, -- Set to nonzero value for BRAM, zero for distributed RAM
      WIDTH            => 8,
      DEPTH            => FIFO_DEPTH,
      FILL_LEVEL_BITS  => FILL_LEVEL_BITS, -- Should be at least int(floor(log2(DEPTH))+1.0)
      PF_FULL_POINT    => FIFO_DEPTH-1,
      PF_FLAG_POINT    => 512,
      PF_EMPTY_POINT   => 1
    )
    port map(
      sys_rst_n        => sys_rst_n, -- Asynchronous

      wr_clk_i         => wr_clk_i,
      wr_clk_en_i      => wr_clk_en_i,
      wr_reset_i       => wr_reset_i,  -- Synchronous
      wr_en_i          => wr_en_i,
      wr_dat_i         => wr_dat_i,
      wr_fifo_level    => wr_fifo_level,
      wr_fifo_full     => wr_fifo_full,
      wr_fifo_empty    => wr_fifo_empty,
      wr_fifo_pf_full  => open,
      wr_fifo_pf_flag  => open,
      wr_fifo_pf_empty => open,

      rd_clk_i         => mmc_clk_i,
      rd_clk_en_i      => '1',
      rd_reset_i       => '0',  -- Synchronous
      rd_en_i          => fifo_dat_rd,
      rd_dat_o         => fifo_dat_to_host,
      rd_fifo_level    => open,
      rd_fifo_full     => open,
      rd_fifo_empty    => open,
      rd_fifo_pf_full  => open,
      rd_fifo_pf_flag  => open,
      rd_fifo_pf_empty => open
    );
    fifo_dat_rd <= '1' when buf_dat_rd='1' and buf_adr(buf_adr'length-1 downto RAM_ADR_WIDTH)>0 else '0';

-- Instantiate the RAM block
-- Port A is the MMC side.
-- Port B is the user side.
  pipe_ram : swiss_army_ram
    generic map(
      USE_BRAM  => 1,
      WRITETHRU => 0, -- Set to nonzero value for writethrough mode
      USE_FILE  => 0, -- Set to nonzero value to use INIT_FILE
      INIT_VAL  => 18,
      INIT_SEL  => 0, -- No generate loop here
      INIT_FILE => ".\foo.txt", -- ASCII hexadecimal initialization file name
      FIL_WIDTH => 32, -- Bit width of init file lines
      ADR_WIDTH => RAM_ADR_WIDTH,
      DAT_WIDTH => 8
    )
    port map (
       clk_a    => mmc_clk_i,
       clk_b    => ram_clk_i,

       adr_a_i  => buf_adr(RAM_ADR_WIDTH-1 downto 0),
       adr_b_i  => ram_adr_i,

       we_a_i   => ram_we,
       en_a_i   => '1',
       dat_a_i  => buf_dat_from_host,
       dat_a_o  => ram_dat_to_host,

       we_b_i   => ram_we_i,
       en_b_i   => ram_clk_en_i,
       dat_b_i  => ram_dat_i,
       dat_b_o  => ram_dat_o
    );
    ram_we <= '1' when buf_dat_we='1' and buf_adr(buf_adr'length-1 downto RAM_ADR_WIDTH)=0 else '0';

end beh;

