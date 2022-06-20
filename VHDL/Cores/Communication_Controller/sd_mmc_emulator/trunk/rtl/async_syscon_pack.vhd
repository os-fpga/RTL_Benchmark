--------------------------------------------------------------------------
-- Package of async_syscon components
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package async_syscon_pack is

  -- A system controller with an 8-bit parallel ASCII interface
  component ascii_syscon
    generic (
      ADR_DIGITS      : natural; -- # of hex digits for address
      DAT_DIGITS      : natural; -- # of hex digits for data
      QTY_DIGITS      : natural; -- # of hex digits for quantity
      CMD_BUFFER_SIZE : natural; -- # of chars in the command buffer
      WATCHDOG_VALUE  : natural; -- # of sys_clks before ack is expected
      DISPLAY_FIELDS  : natural  -- # of fields/line
    );
    port (
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Parallel ASCII I/O
      cmd_char_i   : in  unsigned(7 downto 0);
      cmd_we_i     : in  std_logic;
      cmd_ack_o    : out std_logic;
      cmd_echo_o   : out std_logic;
      resp_char_o  : out unsigned(7 downto 0);
      resp_cyc_o   : out std_logic;
      resp_ack_i   : in  std_logic;
      cmd_done_o   : out std_logic;

      -- Master Bus IO
      master_bg_i  : in  std_logic;
      master_ack_o : out std_logic;
      master_adr_i : in  unsigned(4*ADR_DIGITS-1 downto 0);
      master_dat_i : in  unsigned(4*DAT_DIGITS-1 downto 0);
      master_dat_o : out unsigned(4*DAT_DIGITS-1 downto 0);
      master_stb_i : in  std_logic;
      master_we_i  : in  std_logic;
      master_br_o  : out std_logic;

      -- System Bus IO
      ack_i        : in  std_logic;
      err_i        : in  std_logic;
      dat_i        : in  unsigned(4*DAT_DIGITS-1 downto 0);
      dat_o        : out unsigned(4*DAT_DIGITS-1 downto 0);
      rst_o        : out std_logic;
      stb_o        : out std_logic;
      cyc_o        : out std_logic;
      adr_o        : out unsigned(4*ADR_DIGITS-1 downto 0);
      we_o         : out std_logic
    );
  end component;

  -- ascii_syscon mounted with a UART interface
  component async_syscon
    generic (
      ECHO_COMMANDS   : natural; -- set nonzero to echo back command characters
      ADR_DIGITS      : natural; -- # of hex digits for address
      DAT_DIGITS      : natural; -- # of hex digits for data
      QTY_DIGITS      : natural; -- # of hex digits for quantity
      CMD_BUFFER_SIZE : natural; -- # of chars in the command buffer
      WATCHDOG_VALUE  : natural; -- # of sys_clks before ack is expected
      DISPLAY_FIELDS  : natural  -- # of fields/line
    );
    port (
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- rate and parity
      parity_i     : in  unsigned(1 downto 0); -- 0=none, 1=even, 2=odd
      baud_clk_i   : in  std_logic; -- At 1x the desired baud rate, can be squarewave or pulses.
      baud_lock_i  : in  std_logic; -- '1' Indicates baud clock is stable and ready.

      -- Serial IO
      cmd_i        : in  std_logic;
      resp_o       : out std_logic;
      cmd_done_o   : out std_logic;

      -- Master Bus IO
      master_bg_i  : in  std_logic;
      master_ack_o : out std_logic;
      master_adr_i : in  unsigned(4*ADR_DIGITS-1 downto 0);
      master_dat_i : in  unsigned(4*DAT_DIGITS-1 downto 0);
      master_dat_o : out unsigned(4*DAT_DIGITS-1 downto 0);
      master_stb_i : in  std_logic;
      master_we_i  : in  std_logic;
      master_br_o  : out std_logic;

      -- System Bus IO
      ack_i        : in  std_logic;
      err_i        : in  std_logic;
      dat_i        : in  unsigned(4*DAT_DIGITS-1 downto 0);
      dat_o        : out unsigned(4*DAT_DIGITS-1 downto 0);
      rst_o        : out std_logic;
      stb_o        : out std_logic;
      cyc_o        : out std_logic;
      adr_o        : out unsigned(4*ADR_DIGITS-1 downto 0);
      we_o         : out std_logic
    );
  end component;

end async_syscon_pack;

package body async_syscon_pack is
end async_syscon_pack;

---------------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Date  : Dec. 27, 2013
-- Update: 12/27/13 copied async_syscon module, removed the serial interface.
--         02/05/14 Added line feed as a whitespace character, to 
--                  char_is_whitespace.
--         02/06/14 Made resp_cyc a direct function of the state machine state.
--                  This allows it to be asserted even when resp_ack_i is tied
--                  to '1' all the time...
--         02/13/14 Made a slight enhancement to the processing of comments.
--                  Previously, all comments were treated as "full line"
--                  comments, causing any valid commands preceding the
--                  comment to be ignored, since the entire line was being
--                  ignored.  I realized that a very small value
--                  check on cmd_ptr could differentiate between full line
--                  comments, and ones for which there might actually be
--                  a valid command.  The enhanced design can process the
--                  valid commands.
--         02/14/14 Happy Valentine's Day!  Fixed a "wacky" bug which caused
--                  an extra digit to be displayed for address and data fields.
--                  Added "0" command suffix, which prevents the bus address
--                  from incrementing during read, write and fill operations.
--                  It's useful for working with FIFOs that have read/write
--                  ports mapped to a single address, instead of a whole
--                  range of addresses.
--         02/27/14 Refined the CHECK_SUFFICES state by adding a jump to
--                  START_EXECUTION when ENTER_CHAR is found in the suffix
--                  position, thus preserving the "repeat last read with
--                  previous address and quantity" function.
--
-- Description
---------------------------------------------------------------------------------------
-- This is an 8-bit parallel ASCII character driven interface to a system
-- controller driving a "Wishbone" type of parallel system bus.
--
-- Specifically, the unit allows the user to send text commands to the 
-- "ascii_syscon" unit, in order to generate read and write cycles on the
-- Wishbone compatible bus.  The command structure is quite terse and spartan
-- in nature, this is for the sake of the logic itself.
--
-- The command line buffer is small enough to be implemented without the use
-- of dedicated BRAM memory blocks, and the menus and command responses were
-- kept as small as possible.  In most cases, the responses from the unit to
-- the user consist of a "newline" and one or two visible characters.  The
-- command structure consists of the following commands and responses:
--
-- Command Syntax              Purpose
-- ---------------             ---------------------------------------
-- w aaaa dddd dddd dddd...    Write data items "dddd" starting at address "aaaa"
--                             using sequential addresses.
--                             (If the data field is missing, nothing is done).
-- w0 aaaa dddd dddd dddd...   Write data items "dddd" at address "aaaa"
--                             without incrementing the address.
--                             (If the data field is missing, nothing is done).
-- f aaaa dddd xx              "Fill": Write data "dddd" starting at address "aaaa"
--                             perform this "xx" times at sequential addresses.
--                             (The quantity field is optional, default is 1).
-- f0 aaaa dddd xx             "Fill": Write data "dddd" starting at address "aaaa"
--                             perform this "xx" times at the same address.
--                             (The quantity field is optional, default is 1).
-- r aaaa xx                   Read data starting from address "aaaa."
--                             Perform this "xx" times at sequential addresses.
--                             (The quantity field is optional, default is 1).
-- r0 aaaa xx                  Read data from address "aaaa."
--                             Perform this "xx" times, using the same address.
--                             (The quantity field is optional, default is 1).
-- i                           Send a reset pulse to the system. (initialize).
--
-- <COMMENT_CHAR>              "Single Line" type Comment token.  Characters
--                             after the token are ignored until <ENTER>.
--                             This enables applications which send
--                             files to the unit to include comments for
--                             display and as an aid to understanding.
--                             The comment token is a constant, change it
--                             to be whatever makes sense!
--
-- Response from async_syscon  Meaning
-- --------------------------  ---------------------------------------
-- OK                          Command received and performed.  No errors.
-- ?                           Command buffer full, without receiving "enter."
-- C?                          Command not recognized.
-- A?                          Address field syntax error.
-- D?                          Data field syntax error.
-- Q?                          Quantity field syntax error.
-- !                           No "ack_i", or else "err_i" received from bus.
-- B!                          No "bg_i" received from master.
--
-- NOTES on the operation of this unit:
--
-- - The unit generates a command prompt which is "-> ".
-- - Capitalization is not important.
-- - Each command is terminated by the "enter" key (0x0d character).
--   Commands are executed as soon as "enter" is received.
-- - Trailing parameters need not be re-entered.  Their values will
--   remain the same as their previous settings.
-- - Use of the backspace key is supported, so mistakes can be corrected.
-- - The length of the command line is limited to a fixed number of
--   characters, as configured by parameter.
-- - Fields are separated by white space, including "tab" and/or "space"
-- - All numerical fields are interpreted as hexadecimal numbers.
--   Decimal is not supported.
-- - Numerical field values are retained between commands.  If a "r" is issued
--   without any fields following it, the previous values will be used.  A
--   set of "quantity" reads will take place at sequential addresses.
--   If a "f" is issued without any fields following it, the previous data
--   value will be written "quantity" times at sequential addresses, starting
--   from the next location beyond where the last command ended.
-- - If the user does not wish to use "ack" functionality, simply tie the
--   "ack_i" input to logic 1, and then the ! response will never be generated.
-- - The data which is read in by the "r" command is displayed using lines
--   which begin with the address, followed by the data fields.  The number
--   of data fields displayed per line (following the address) is adjustable
--   by setting a parameter.  No other display format adjustments can be made.
-- - There is currently only a single watchdog timer.  It begins to count at
--   the time the "enter" is received to execute a command.  If the bus is granted
--   and the ack is received before the expiration of the timer, then the
--   cycle will complete normally.  Therefore, the watchdog timeout value
--   needs to include time for the request and granting of the bus, in
--   addition to the time needed for the actual bus cycle to complete.
--
--
-- Currently, there is only a single indicator (stb_o) generated during bus
-- output cycles which are generated from this unit.
-- The user can easily implement decoding logic based upon adr_o and stb_o
-- which would serve as multiple "stb_o" type signals for different cores
-- which would be sharing the same bus.
--
-- The data bus supported by this module is separate input/output type of bus.
-- However, if a single tri-state dat_io bus is desired, it can be added
-- to the module without too much trouble.  Supposedly the only difference
-- between the two forms of data bus is that one of them avoids using tri-state
-- at the cost of doubling the number of interconnects used to carry data back
-- and forth...  Some people say that tri-state should be avoided for use
-- in internal busses in ASICs.  Maybe they are right.
-- But in FPGAs tri-state seems to work pretty well, even for internal busses.
--
-- Parameters are provided to configure the width of the different command
-- fields.  To simplify the logic for binary to hexadecimal conversion, these
-- parameters allow adjustment in units of 1 hex digit, not anything smaller.
-- If your bus has 10 bits, for instance, simply set the address width to 3
-- which produces 12 bits, and then just don't use the 2 msbs of address
-- output.
--
-- No support for the optional Wishbone "retry" (rty_i) input is provided at
-- this time.
-- No support for "tagn_o" bits is provided at this time, although a register
-- might be added external to this module in order to implement to tag bits.
-- No BLOCK or RMW cycles are supported currently, so cyc_o is equivalent to
-- stb_o...
-- The output busses are not tri-stated.  The user may add tri-state buffers
-- external to the module, using "stb_o" to enable the buffer outputs.
--
---------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.convert_pack.all;
use work.async_syscon_pack.all;

entity ascii_syscon is
    generic (
      ADR_DIGITS      : natural :=   4; -- # of hex digits for address
      DAT_DIGITS      : natural :=   4; -- # of hex digits for data
      QTY_DIGITS      : natural :=   2; -- # of hex digits for quantity
      CMD_BUFFER_SIZE : natural :=  32; -- # of chars in the command buffer
      WATCHDOG_VALUE  : natural := 200; -- # of sys_clks before ack is expected
      DISPLAY_FIELDS  : natural :=   8  -- # of fields/line
    );
    port (
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Parallel ASCII I/O
      cmd_char_i   : in  unsigned(7 downto 0);
      cmd_we_i     : in  std_logic;
      cmd_ack_o    : out std_logic;
      cmd_echo_o   : out std_logic;
      resp_char_o  : out unsigned(7 downto 0);
      resp_cyc_o   : out std_logic;
      resp_ack_i   : in  std_logic;
      cmd_done_o   : out std_logic;

      -- Master Bus IO
      master_bg_i  : in  std_logic;
      master_ack_o : out std_logic;
      master_adr_i : in  unsigned(4*ADR_DIGITS-1 downto 0);
      master_dat_i : in  unsigned(4*DAT_DIGITS-1 downto 0);
      master_dat_o : out unsigned(4*DAT_DIGITS-1 downto 0);
      master_stb_i : in  std_logic;
      master_we_i  : in  std_logic;
      master_br_o  : out std_logic;

      -- System Bus IO
      ack_i        : in  std_logic;
      err_i        : in  std_logic;
      dat_i        : in  unsigned(4*DAT_DIGITS-1 downto 0);
      dat_o        : out unsigned(4*DAT_DIGITS-1 downto 0);
      rst_o        : out std_logic;
      stb_o        : out std_logic;
      cyc_o        : out std_logic;
      adr_o        : out unsigned(4*ADR_DIGITS-1 downto 0);
      we_o         : out std_logic
    );
end ascii_syscon;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

architecture beh of ascii_syscon is

-- Constants
constant CMD_PTR_BITS                 : natural := bit_width(CMD_BUFFER_SIZE);
constant DISPLAY_FIELD_COUNT_BITS     : natural := bit_width(DISPLAY_FIELDS);
constant DISPLAY_ADR_DIGIT_COUNT_BITS : natural := bit_width(ADR_DIGITS);
constant DISPLAY_DAT_DIGIT_COUNT_BITS : natural := bit_width(DAT_DIGITS);
constant WATCHDOG_TIMER_BITS          : natural := timer_width(WATCHDOG_VALUE);

constant BACKSPACE_CHAR      : unsigned := "00001000";
constant ENTER_CHAR          : unsigned := "00001101";
constant COMMENT_CHAR        : unsigned := "00100011"; -- '#' character
--constant COMMENT_CHAR        : unsigned := "00101101"; -- '-' character

-- Internal signal declarations
  -- For the state machine
type FSM_STATE_TYPE is (IDLE, SEND_WELCOME_STRING, SEND_OK, SEND_PROMPT,
                        CHECK_NEW_CHAR, SEND_CRLF, PARSE_ERR_INDICATOR_CRLF,
                        ERR_INDICATOR, BG_ERR_INDICATOR, SEND_QUESTION, 
                        SCAN_CMD, CHECK_SUFFICES, SCAN_ADR_WHITESPACE,
                        GET_ADR_FIELD, SCAN_DAT_WHITESPACE, GET_DAT_FIELD, 
                        SCAN_QTY_WHITESPACE, GET_QTY_FIELD, START_EXECUTION,
                        REQUEST_BUS, EXECUTE, DISPLAY_PREP, DISPLAY_ADR,
                        DISPLAY_SEPARATOR, DISPLAY_DAT, DISPLAY_SPACE,
                        DISPLAY_CRLF, POST_FILL_CYCLE);

signal fsm_state      : FSM_STATE_TYPE;

signal watchdog_timer_done  : std_logic;  -- High when watchdog timer is expired
signal char_is_whitespace   : std_logic;  -- High when cmd_buffer[char_count] is whitespace.
signal char_is_num          : std_logic;  -- High when cmd_buffer[char_count] is 0..9
signal char_is_a_f          : std_logic;  -- High when cmd_buffer[char_count] is a..f
signal char_is_hex          : std_logic;  -- High when cmd_buffer[char_count] is a hex char.
signal msg_pointer          : unsigned(4 downto 0);  -- Determines message position or address.
signal msg_select           : unsigned(4 downto 0);  -- selection of msg_pointer or display value
signal hex_digit            : unsigned(3 downto 0);  -- This is the digit to be stored.

signal msg_char             : unsigned(7 downto 0);  -- Selected response message character.
signal comment_area         : std_logic;

    -- For the buses
signal adr_ptr              : unsigned(4*ADR_DIGITS-1 downto 0);  -- = adr_sr + adr_offset

signal stb_l                : std_logic;  -- "local" stb signal (to distinguish from stb_o)
signal we_l                 : std_logic;  -- "local" we  signal (to distinguish from we_o)

signal display_adr_sr       : unsigned(4*ADR_DIGITS-1 downto 0); -- sr for printing addresses
signal adr_sr               : unsigned(4*ADR_DIGITS-1 downto 0); -- "nibble" shift register
signal dat_sr               : unsigned(4*DAT_DIGITS-1 downto 0); -- "nibble" shift register
signal qty_sr               : unsigned(4*QTY_DIGITS-1 downto 0); -- "nibble" shift register

-- The command register has these values
type CMD_REG_TYPE is (INIT, READ, FILL, WRITE);
signal command : CMD_REG_TYPE;

    -- For the command buffer
signal cmd_ptr              : unsigned(CMD_PTR_BITS-1 downto 0); -- Offset from start of command.
--signal rd_cmd_ptr           : unsigned(CMD_PTR_BITS-1 downto 0); -- Latched cmd_ptr, use to infer BRAM.
type cmd_array_type is
  array (integer range 0 to CMD_BUFFER_SIZE-1) of unsigned(7 downto 0);

signal cmd_buffer  : cmd_array_type;
signal cmd_char    : unsigned(7 downto 0);
signal lc_cmd_char : unsigned(7 downto 0); -- Lowercase version of cmd_char
signal adr_offset  : unsigned(4*QTY_DIGITS-1 downto 0);   -- counts from 0 to qty_sr
signal adr_freeze  : std_logic; -- When set, prevents adr_offset from incrementing

signal resp_cyc                : std_logic; -- high for response type states
signal resp_cyc_l              : std_logic;
signal resp_cyc_mask           : std_logic; -- Used to lower resp_cyc_o for one clock cycle, upon acknowledgement.

    -- For various counters
signal display_field_count     : unsigned(DISPLAY_FIELD_COUNT_BITS-1 downto 0);      -- "fields displayed"
signal display_adr_digit_count : unsigned(DISPLAY_ADR_DIGIT_COUNT_BITS-1 downto 0);  -- "digits displayed"
signal display_dat_digit_count : unsigned(DISPLAY_DAT_DIGIT_COUNT_BITS-1 downto 0);  -- "digits displayed"
signal watchdog_timer_count    : unsigned(WATCHDOG_TIMER_BITS-1 downto 0);

----------------------------------------------------------------------------
-- Component Declarations
----------------------------------------------------------------------------

----------------------------------------------------------------------------
begin

-- In this module, command characters are accepted immediately but only when in the CHECK_NEW_CHAR state.
cmd_ack_o <= '1' when cmd_we_i='1' and fsm_state=CHECK_NEW_CHAR else '0';

-- Provide response character cycle active signal
resp_cyc   <= '1' when fsm_state=DISPLAY_CRLF             or
                       fsm_state=DISPLAY_SPACE            or
                       fsm_state=DISPLAY_DAT              or
                       fsm_state=DISPLAY_SEPARATOR        or
                       fsm_state=DISPLAY_ADR              or
                       fsm_state=SEND_QUESTION            or
                       fsm_state=ERR_INDICATOR            or
                       fsm_state=PARSE_ERR_INDICATOR_CRLF or
                       fsm_state=BG_ERR_INDICATOR         or
                       fsm_state=SEND_CRLF                or
                       fsm_state=SEND_PROMPT              or
                       fsm_state=SEND_OK                  or
                       fsm_state=SEND_WELCOME_STRING      else
                       '0';
-- Implement the "courtesy" of lowering resp_cyc_o for one cycle after resp_ack_i is recognized.
-- This increases the amount of time needed for data transfer, and some would say it is needless,
-- since a "burst" type transfer also can work.  Since burst transfers were not intended here,
-- this is being done anyway.  You see, burst transfers can "tie up" bus arbiters for the entire
-- burst, which is not desirable in this design.
resp_cyc_l <= '1' when resp_cyc='1' and resp_cyc_mask='0' else '0';
resp_cyc_o <= resp_cyc_l;

resp_cyc_mask_proc : process(sys_clk,sys_rst_n)
variable i : natural;
begin
  if (sys_rst_n='0') then
    resp_cyc_mask <= '0';
  elsif (sys_clk'event and sys_clk='1') then
    if (sys_clk_en='1') then
      resp_cyc_mask <= '0'; -- Default value
      if (resp_cyc_l='1' and resp_ack_i='1') then
        resp_cyc_mask <= '1';
      end if;
    end if;
  end if;
end process;


-- Provide command echo indication, to allow ASCII response data to be
-- echoed or not, as desired.
cmd_echo_o <= '1' when fsm_state=CHECK_NEW_CHAR else '0';

-- Provide parallel ASCII response data
resp_char_o <= msg_char;

-- Select which bus signals get used on the system bus
adr_o <= adr_ptr when (master_bg_i='1') else master_adr_i;
we_o  <= we_l    when (master_bg_i='1') else master_we_i;
stb_o <= stb_l   when (master_bg_i='1') else master_stb_i;
cyc_o <= stb_l   when (master_bg_i='1') else master_stb_i; -- Separate cyc_o is not yet supported!

dat_o <= dat_sr when (master_bg_i='1' and we_l='1' and stb_l='1') else master_dat_i;
master_dat_o <= dat_i;
master_ack_o <= ack_i when master_bg_i='0' else '0';

-- This forms the adress pointer which is used on the bus.
adr_ptr <= adr_sr + adr_offset when adr_freeze='0' else adr_sr;

-- This is the ROM for the ASCII characters to be transmitted.
-- Choose which value to use
msg_select <= '0' & display_adr_sr(4*ADR_DIGITS-1 downto 4*(ADR_DIGITS-1)) when fsm_state=DISPLAY_ADR else
              '0' & dat_sr(4*DAT_DIGITS-1 downto 4*(DAT_DIGITS-1))         when fsm_state=DISPLAY_DAT else
              msg_pointer;
with (msg_select) select
  msg_char <=
    "00110000" when "00000",  --  "0"; -- Hexadecimal characters
    "00110001" when "00001",  --  "1";
    "00110010" when "00010",  --  "2";
    "00110011" when "00011",  --  "3";
    "00110100" when "00100",  --  "4";
    "00110101" when "00101",  --  "5";
    "00110110" when "00110",  --  "6";
    "00110111" when "00111",  --  "7";
    "00111000" when "01000",  --  "8";
    "00111001" when "01001",  --  "9";
    "01000001" when "01010",  --  "A"; -- Address error indication
    "01000010" when "01011",  --  "B";
    "01000011" when "01100",  --  "C"; -- Command error indication
    "01000100" when "01101",  --  "D"; -- Data error indication
    "01000101" when "01110",  --  "E";
    "01000110" when "01111",  --  "F";
    "00100000" when "10000",  --  " "; -- Space
    "00111010" when "10001",  --  ":"; -- Colon
    "00100000" when "10010",  --  " "; -- Space
    "00111111" when "10011",  --  "?"; -- Parse error indication
    "00100001" when "10100",  --  "!"; -- ack_i/err_i error indication
    "01001111" when "10101",  --  "O"; -- "All is well" message
    "01001011" when "10110",  --  "K";
    "00001101" when "10111",  -- Carriage Return
    "00001010" when "11000",  -- Line Feed
    "00101101" when "11001",  --  "-"; -- Command Prompt
    "00111110" when "11010",  --  ">";
    "00100000" when "11011",  --  " ";
    "01010001" when "11100",  --  "Q"; -- Quantity error indication
    "01011000" when others;   --  "X";

-- This is state machine m1.  It handles receiving the command line, including
-- backspaces, and prints error/response messages.  It also parses and
-- executes the commands.

-- State register
fsm_proc : process(sys_clk, sys_rst_n)

  procedure exec_prep is
  begin
    if (adr_offset=qty_sr) then
      msg_pointer <= "10101"; -- Address of message
      fsm_state   <= SEND_OK;
    else
      watchdog_timer_count <= (others=>'0'); -- Reset the timer.
      fsm_state <= EXECUTE;
    end if;
  end exec_prep;

begin
  if (sys_rst_n='0') then -- asynchronous reset
    rst_o       <= '0';
    fsm_state   <= IDLE;
    command     <= INIT;
    msg_pointer <= (others=>'0');
    cmd_ptr     <= (others=>'0');
    adr_offset  <= (others=>'0');
    adr_freeze  <= '0';
    adr_sr      <= (others=>'0');
    dat_sr      <= (others=>'0');
    qty_sr     <= to_unsigned(1,qty_sr'length); -- Set qty = 1 default.
    display_field_count      <= (others=>'0');
    display_adr_digit_count  <= (others=>'0');
    display_dat_digit_count  <= (others=>'0');
    watchdog_timer_count     <= (others=>'0');
    display_adr_sr           <= (others=>'0');
    cmd_done_o  <= '0';
    comment_area <= '0';
  elsif (sys_clk'event and sys_clk='1') then
    if (sys_clk_en='1') then

      -- Handle the Watchdog timer
      if (watchdog_timer_done='0') then
        watchdog_timer_count <= watchdog_timer_count+1;
      end if;

      -- Default values for outputs.  The individual states can override these.
      rst_o <= '0';
      cmd_done_o <= '0';

      case (fsm_state) is

        when IDLE =>
          msg_pointer <= (others=>'0');
          fsm_state   <= SEND_WELCOME_STRING;

        when SEND_WELCOME_STRING =>
          if (resp_cyc_l='1' and resp_ack_i='1') then
            if (msg_pointer=15) then  -- Send initial string ("0123456789ABCDEF")
              msg_pointer <= "10111"; -- Address of the message
              fsm_state   <= SEND_PROMPT;
            else
              msg_pointer <= msg_pointer+1;
            end if;
          end if;

        when SEND_OK =>
          if (resp_cyc_l='1' and resp_ack_i='1') then
            if (msg_pointer=22) then -- Send 2 characters...
              msg_pointer <= "10111"; -- Address of the message
              fsm_state   <= SEND_PROMPT;
            else
              msg_pointer <= msg_pointer+1;
            end if;
          end if;

        when SEND_PROMPT =>
          if (resp_cyc_l='1' and resp_ack_i='1') then
            if (msg_pointer=27) then -- Send 5 characters...
              cmd_ptr     <= (others=>'0');
              cmd_done_o  <= '1';
              fsm_state   <= CHECK_NEW_CHAR;
            else
              msg_pointer <= msg_pointer+1;
            end if;
          end if;

        -- This state always leads to activating the parser...
        when SEND_CRLF =>
          if (resp_cyc_l='1' and resp_ack_i='1') then
            if (msg_pointer=24) then -- Send 2 characters...
              cmd_ptr     <= (others=>'0');
              fsm_state   <= SCAN_CMD;
            else
              msg_pointer <= msg_pointer+1;
            end if;
          end if;

        when CHECK_NEW_CHAR =>
          if (cmd_we_i='1') then
            if (cmd_char_i=BACKSPACE_CHAR) then
              cmd_ptr <= cmd_ptr-1; -- This effectively eliminates the last char
            elsif (comment_area='0' and cmd_char_i=ENTER_CHAR) or (cmd_ptr=CMD_BUFFER_SIZE-1) then
              if (cmd_char_i=ENTER_CHAR) then
                msg_pointer <= "10111";     -- Address of the message
                fsm_state   <= SEND_CRLF;
              end if;
              if (cmd_ptr=CMD_BUFFER_SIZE-1) then
                msg_pointer <= "10111";    -- Address of the message.
                cmd_ptr     <= (others=>'0');
                fsm_state   <= PARSE_ERR_INDICATOR_CRLF;
              end if;
            elsif (cmd_char_i=COMMENT_CHAR) then
              comment_area <= '1'; -- Activate comment area, which stores characters, but does not advance cmd_ptr.
            elsif (comment_area='0') then
              cmd_ptr <= cmd_ptr+1;
            end if;
            -- Deactivate comment area at end of line
            if (comment_area='1' and cmd_char_i=ENTER_CHAR) then
              comment_area <= '0';
              -- Check if a valid command might have preceded the comment
              if (cmd_ptr>1) then
                msg_pointer <= "10111";     -- Address of the message
                fsm_state   <= SEND_CRLF;
              else
                msg_pointer <= "10111"; -- Address of the message
                fsm_state   <= SEND_PROMPT;
              end if;
            end if;
          end if;

        when BG_ERR_INDICATOR =>
          if (resp_cyc_l='1' and resp_ack_i='1') then
            msg_pointer <= "10100";    -- Address of the error message
            fsm_state   <= ERR_INDICATOR;
          end if;

        -- This state is used when the line is too long...
        when PARSE_ERR_INDICATOR_CRLF =>
          if (resp_cyc_l='1' and resp_ack_i='1') then
            if (msg_pointer=24) then -- Send 2 characters...
              msg_pointer <= "10011";    -- Address of the message.
              fsm_state   <= ERR_INDICATOR;
            else
              msg_pointer <= msg_pointer+1;
            end if;
          end if;

        when ERR_INDICATOR =>
          if (resp_cyc_l='1' and resp_ack_i='1') then
            msg_pointer <= "10111"; -- Address of the message
            fsm_state   <= SEND_PROMPT;
          end if;

        when SEND_QUESTION =>
          if (resp_cyc_l='1' and resp_ack_i='1') then
            msg_pointer <= "10011";    -- Address of the message.
            fsm_state   <= ERR_INDICATOR;
          end if;

        -- The following states are for parsing and executing the command.

        -- This state takes care of leading whitespace before the command
        when SCAN_CMD =>
          cmd_ptr    <= cmd_ptr+1;
          adr_offset <= (others=>'0');
          case (lc_cmd_char) is
            when "01110010" => -- "r"
              command   <= READ;
              fsm_state <= CHECK_SUFFICES;
            when "01110111" => -- "w"
              command   <= WRITE;
              qty_sr    <= (others=>'1'); -- Limit writes to the max. qty...
              fsm_state <= CHECK_SUFFICES;
            when "01101001" => -- "i"
              command   <= INIT;
              qty_sr    <= (others=>'0');
              rst_o     <= '1'; -- Actually do this one right now!!
              fsm_state <= START_EXECUTION;
            when "01100110" => -- "f"
              command   <= FILL;
              fsm_state <= CHECK_SUFFICES;
            when others     =>
              if (char_is_whitespace='0') then
                msg_pointer <= "01100";    -- Address of message
                fsm_state   <= SEND_QUESTION;
              end if;
          end case;

        -- This state cleverly detects command "suffix" modifiers, such
        -- as the '0' modifier, which causes the address to remain frozen.
        -- Invalid or unimplemented suffix modifiers elicit the "C?" response.
        when CHECK_SUFFICES => -- Should that read "check suffixes" Hmmm...
          if (cmd_char="00110000") then -- '0' suffix
            cmd_ptr <= cmd_ptr+1;
            adr_freeze <= '1';
            fsm_state <= SCAN_ADR_WHITESPACE;
          elsif (cmd_char=ENTER_CHAR) then
            fsm_state <= START_EXECUTION; -- Using last values
          elsif (char_is_whitespace='1') then
            adr_freeze <= '0';
            fsm_state <= SCAN_ADR_WHITESPACE;
          else
            msg_pointer <= "01100";    -- Address of message
            fsm_state   <= SEND_QUESTION;
          end if;


        -- The only way to determine the end of a valid field is to find
        -- whitespace.  Therefore, char_is_whitespace must be used as an exit
        -- condition from the "get_xxx_field" states.  So, this state is used to
        -- scan through any leading whitespace prior to the first field.
        when SCAN_ADR_WHITESPACE =>
          if (char_is_whitespace='1') then
            cmd_ptr <= cmd_ptr+1;
          elsif (cmd_char=ENTER_CHAR) then
            fsm_state <= START_EXECUTION; -- Using last values
          else
            fsm_state <= GET_ADR_FIELD;
            adr_sr    <= (others=>'0');
          end if;

        when GET_ADR_FIELD =>
          if (char_is_hex='1') then
            adr_sr    <= adr_sr(4*(ADR_DIGITS-1)-1 downto 0) & hex_digit;
            cmd_ptr   <= cmd_ptr+1;
          elsif (char_is_whitespace='1') then -- Normal exit
            fsm_state <= SCAN_DAT_WHITESPACE;
          elsif (cmd_char=ENTER_CHAR and command=READ) then
            fsm_state <= START_EXECUTION; -- Using last values
          else
            msg_pointer <= "01010";    -- Address of message
            fsm_state   <= SEND_QUESTION;
          end if;

        when SCAN_DAT_WHITESPACE =>
          -- There is no DAT field for reads, so skip it.
          if (command=READ) then
            fsm_state <= SCAN_QTY_WHITESPACE;
          elsif (char_is_whitespace='1') then
            cmd_ptr <= cmd_ptr+1;
          elsif (cmd_char=ENTER_CHAR) then
            if (command=WRITE) then -- Writing data values done, finish.
              msg_pointer <= "10101";    -- Address of message
              fsm_state   <= SEND_OK;
            else
              fsm_state <= START_EXECUTION; -- Using last DATA & QTY values
            end if;
          else
            fsm_state <= GET_DAT_FIELD;
            dat_sr    <= (others=>'0');
          end if;

        when GET_DAT_FIELD =>
          if (char_is_hex='1') then
            dat_sr    <= dat_sr(4*(DAT_DIGITS-1)-1 downto 0) & hex_digit;
            cmd_ptr   <= cmd_ptr+1;
          elsif (char_is_whitespace='1') then -- Normal exit
            if (command=WRITE) then
              fsm_state  <= START_EXECUTION;
            else
              fsm_state <= SCAN_QTY_WHITESPACE;
            end if;
          elsif (cmd_char=ENTER_CHAR) then
            fsm_state <= START_EXECUTION;
          else
            msg_pointer <= "01101";    -- Address of message
            fsm_state   <= SEND_QUESTION;
          end if;
 
        when SCAN_QTY_WHITESPACE =>
          if (char_is_whitespace='1') then
            cmd_ptr   <= cmd_ptr+1;
          elsif (cmd_char=ENTER_CHAR) then
            fsm_state <= START_EXECUTION; -- Using last values
          else
            fsm_state <= GET_QTY_FIELD;
            qty_sr    <= to_unsigned(0,qty_sr'length);
          end if;

        when GET_QTY_FIELD =>
          if (char_is_hex='1') then
            qty_sr    <= qty_sr(4*(QTY_DIGITS-1)-1 downto 0) & hex_digit;
            cmd_ptr   <= cmd_ptr+1;
          elsif (char_is_whitespace='1' or cmd_char=ENTER_CHAR) then  -- Normal exit
            fsm_state <= START_EXECUTION;
          else
            msg_pointer <= "11100";    -- Address of message
            fsm_state   <= SEND_QUESTION;
          end if;

        -- This state seeks to obtain master_bg_i, which grants the bus for use.
        when START_EXECUTION =>
          watchdog_timer_count <= (others=>'0'); -- Reset the timer.
          display_adr_sr       <= adr_ptr;
          display_field_count  <= (others=>'0');
          if (master_bg_i='1') then -- skip REQUEST_BUS if it is already granted!
            exec_prep;
          else
            fsm_state   <= REQUEST_BUS;
          end if;

        when REQUEST_BUS =>
          if (master_bg_i='1') then
            exec_prep; -- resets watchdog, sends "OK" if done.
          elsif (watchdog_timer_done='1') then
            msg_pointer <= "01011";    -- Address of messsage
            fsm_state   <= BG_ERR_INDICATOR;
          end if;

        -- This single state does fill/write/read depending upon the value
        -- contained in "command"!
        when EXECUTE =>
          if (watchdog_timer_done='1' or err_i='1') then
            fsm_state   <= BG_ERR_INDICATOR;
          elsif (ack_i='1' and master_bg_i='1') then
            case command is
              when READ =>
                dat_sr <= dat_i; -- Capture the read data
                display_adr_sr <= adr_ptr;
                fsm_state <= DISPLAY_PREP;
              when WRITE =>
                adr_offset <= adr_offset+1;
                fsm_state  <= SCAN_DAT_WHITESPACE; -- Continue to next data value
              when FILL  =>
                adr_offset <= adr_offset+1;
                fsm_state  <= POST_FILL_CYCLE;
              when others =>
                fsm_state  <= POST_FILL_CYCLE;
            end case;
          end if;

        when POST_FILL_CYCLE =>
          exec_prep; -- resets watchdog, sends "OK" if done.

        when DISPLAY_PREP =>
          adr_offset <= adr_offset+1;
          if (display_field_count = 0) then -- Check to see if address display is needed yet.
            msg_pointer <= '0' & display_adr_sr(4*ADR_DIGITS-1 downto 4*(ADR_DIGITS-1));
            display_adr_digit_count <= (others=>'0');
            display_adr_sr <= adr_ptr;
            fsm_state <= DISPLAY_ADR; -- Leads to a new address line.
          else
            display_dat_digit_count <= (others=>'0');
            msg_pointer <= '0' & dat_sr(4*DAT_DIGITS-1 downto 4*(DAT_DIGITS-1));
            fsm_state <= DISPLAY_DAT;
          end if;

        when DISPLAY_ADR =>
          if (resp_cyc_l='1' and resp_ack_i='1') then
            if (display_adr_digit_count = ADR_DIGITS-1) then
              msg_pointer <= "10000";    -- Address of the message
              fsm_state   <= DISPLAY_SEPARATOR;
            else
              display_adr_sr <= display_adr_sr(4*(ADR_DIGITS-1)-1 downto 0) & to_unsigned(0,4);
              display_adr_digit_count <= display_adr_digit_count+1;
            end if;
          end if;

        when DISPLAY_SEPARATOR =>
          if (resp_cyc_l='1' and resp_ack_i='1') then
            msg_pointer <= msg_pointer+1;
            if (msg_pointer = 18) then -- Three characters
              display_dat_digit_count <= (others=>'0');
              msg_pointer <= '0' & dat_sr(4*DAT_DIGITS-1 downto 4*(DAT_DIGITS-1));
              fsm_state <= DISPLAY_DAT;
            end if;
          end if;

        when DISPLAY_DAT =>
          if (resp_cyc_l='1' and resp_ack_i='1') then
            if (
                (display_dat_digit_count = DAT_DIGITS-1)
                and (display_field_count = DISPLAY_FIELDS-1)
                )
            then
              msg_pointer <= "10111";     -- Address of the message
              fsm_state   <= DISPLAY_CRLF;
              display_field_count <= (others=>'0');
            elsif (display_dat_digit_count = DAT_DIGITS-1) then
              msg_pointer <= "10000";    -- Address of the message
              fsm_state   <= DISPLAY_SPACE;
              display_field_count <= display_field_count+1;
            else
              dat_sr      <= dat_sr(4*(DAT_DIGITS-1)-1 downto 0) & hex_digit;
              display_dat_digit_count <= display_dat_digit_count+1;
            end if;
          end if;

        when DISPLAY_SPACE =>
          if (resp_cyc_l='1' and resp_ack_i='1') then
            exec_prep; -- resets watchdog, sends "OK" if done.
          end if;

        when DISPLAY_CRLF =>
          if (resp_cyc_l='1' and resp_ack_i='1') then
            msg_pointer <= msg_pointer+1;
            if (msg_pointer=24) then -- Two characters
              exec_prep; -- resets watchdog, sends "OK" if done.
            end if;
          end if;

        --when others => 
        --  fsm_state <= IDLE;
      end case;

    end if; -- sys_clk_en
  end if; -- sys_clk
end process;

-- Assert needed outputs during execution of bus cycles
master_br_o <= '1' when (fsm_state=REQUEST_BUS or fsm_state=EXECUTE) else '0';
we_l        <= '1' when (fsm_state=EXECUTE and (command=WRITE or command=FILL)) else '0';
stb_l       <= '1' when (fsm_state=EXECUTE) else '0';


-- This is the command buffer writing section
ram_proc : process(sys_clk,sys_rst_n)
variable i : natural;
begin
  if (sys_rst_n='0') then
    -- synthesis translate_off
    -- The initialization of the command buffer is for convenience in simulation only.
    -- It can be removed for synthesis.
     for i in 0 to CMD_BUFFER_SIZE-1 loop
       cmd_buffer(i) <= (others=>'0');
     end loop;
    -- synthesis translate_on
  elsif (sys_clk'event and sys_clk='1') then
    if (sys_clk_en='1') then
      if (cmd_we_i='1' and fsm_state=CHECK_NEW_CHAR) then
        cmd_buffer(to_integer(cmd_ptr)) <= cmd_char_i;
      end if;
      -- Latch the command pointer, for synchronous reads.
      --rd_cmd_ptr <= cmd_ptr; -- Use this to infer BRAM.
    end if;
  end if;
end process;

-- This is the command buffer reading section
cmd_char <= cmd_buffer(to_integer(cmd_ptr)); -- Asynchronous read.  Amazingly, this was the better option in XC2S200E...
--cmd_char <= cmd_buffer(to_integer(rd_cmd_ptr)); -- Synchronous read, use this to infer BRAM.
lc_cmd_char <= (cmd_char or "00100000"); -- lowercase

-- These assigments are for detecting whether the cmd_char is
-- anything of special interest.
char_is_whitespace <= '1' when ((cmd_char=16#20#)  -- space
                             or (cmd_char=16#09#)  -- tab
                             or (cmd_char=16#0A#)  -- line feed
                       ) else '0';
char_is_num <= '1' when ((cmd_char>=16#30#) and (cmd_char<=16#39#)) else '0';
char_is_a_f <= '1' when ((lc_cmd_char>=16#61#) and (lc_cmd_char<=16#66#)) else '0';
char_is_hex <= char_is_num or char_is_a_f;

hex_digit <= cmd_char(3 downto 0) when char_is_num='1' else (cmd_char(3 downto 0)+"1001");

watchdog_timer_done <= '1' when (watchdog_timer_count=WATCHDOG_VALUE) else '0';

end beh;


---------------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Date  : Nov. 20, 2009
-- Update: 11/20/09 copied this file from rs232_syscon.v  Began translating.
--         10/04/11 Removed msg_offset+msg_base adder, in a bid to
--                  increase max operating speed of this module.
--                  Combined CMD_ERR_INDICATOR, ADR_ERR_INDICATOR,
--                           DAT_ERR_INDICATOR, and QTY_ERR_INDICATOR
--                  into a single state : SEND_QUESTION
--                  Combined ACK_ERR_INDICATOR and PARSE_ERR_INDICATOR
--                  into a single state : ERR_INDICATOR
--         08/03/13 Removed rs232_tx_active_o, since it appears to be a
--                  vestigial relic of a time long ago when the echoing of
--                  command characters was done through the UART, and not
--                  directly as it is now.  It was staying high all the
--                  time except for brief pulses low during generated
--                  responses... which is not useful.
--         08/03/13 Added "cmd_done_o" output pulse, which helps outside
--                  serial command generators know when to begin generating
--                  the next command.  Removed the "rs232_" prefix from
--                  signal names, since the signals really aren't at RS232
--                  levels.
--         08/03/13 Changed module and packet name to replace "rs232_"
--                  with "async_"
--         08/07/13 Added logic to include a "single line" type of comment
--                  which allows initialization strings and messages to
--                  include comments, which are echoed back over the
--                  interface for the user to perhaps see.
--
-- Description
---------------------------------------------------------------------------------------
-- This module takes an "ascii_syscon" unit and adds an asynchronous serial
-- interface to it.
--
-- For details of command and response syntax, please refer to the ascii_syscon
-- description.
--
---------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

library work;
use work.convert_pack.all;
use work.uart_sqclk_pack.all;
use work.async_syscon_pack.all;

entity async_syscon is
    generic (
      ECHO_COMMANDS   : natural :=         1; -- set nonzero to echo back command characters
      ADR_DIGITS      : natural :=         4; -- # of hex digits for address
      DAT_DIGITS      : natural :=         4; -- # of hex digits for data
      QTY_DIGITS      : natural :=         2; -- # of hex digits for quantity
      CMD_BUFFER_SIZE : natural :=        32; -- # of chars in the command buffer
      WATCHDOG_VALUE  : natural :=       200; -- # of sys_clks before ack is expected
      DISPLAY_FIELDS  : natural :=         8  -- # of fields/line
    );
    port (
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- rate and parity
      parity_i     : in  unsigned(1 downto 0); -- 0=none, 1=even, 2=odd
      baud_clk_i   : in  std_logic; -- At 1x the desired baud rate, can be squarewave or pulses.
      baud_lock_i  : in  std_logic; -- '1' Indicates baud clock is stable and ready.

      -- Serial IO
      cmd_i        : in  std_logic;
      resp_o       : out std_logic;
      cmd_done_o   : out std_logic;

      -- Master Bus IO
      master_bg_i  : in  std_logic;
      master_ack_o : out std_logic;
      master_adr_i : in  unsigned(4*ADR_DIGITS-1 downto 0);
      master_dat_i : in  unsigned(4*DAT_DIGITS-1 downto 0);
      master_dat_o : out unsigned(4*DAT_DIGITS-1 downto 0);
      master_stb_i : in  std_logic;
      master_we_i  : in  std_logic;
      master_br_o  : out std_logic;

      -- System Bus IO
      ack_i        : in  std_logic;
      err_i        : in  std_logic;
      dat_i        : in  unsigned(4*DAT_DIGITS-1 downto 0);
      dat_o        : out unsigned(4*DAT_DIGITS-1 downto 0);
      rst_o        : out std_logic;
      stb_o        : out std_logic;
      cyc_o        : out std_logic;
      adr_o        : out unsigned(4*ADR_DIGITS-1 downto 0);
      we_o         : out std_logic
    );
end async_syscon;

architecture beh of async_syscon is

-- Constants
constant ENTER_CHAR : unsigned := "00001101";

-- Signals
  -- For ascii_syscon
signal cmd_char         : unsigned(7 downto 0);
signal cmd_we_uart      : std_logic;
signal cmd_we_wait      : std_logic;
signal cmd_rx_done      : std_logic;
signal cmd_we           : std_logic;
signal cmd_ack          : std_logic;
signal cmd_echo         : std_logic;
signal resp_char        : unsigned(7 downto 0);
signal resp_cyc         : std_logic;
signal resp_cyc_r1      : std_logic;
signal resp_cyc_uart    : std_logic;
signal resp_ack_uart    : std_logic;
signal resp_ack_uart_r1 : std_logic;
signal resp_ack         : std_logic;

  -- For the serial interface
signal async_rx_error       : unsigned(1 downto 0);
signal async_rx_restart     : std_logic;
signal resp_l               : std_logic;

----------------------------------------------------------------------------
-- Component Declarations
----------------------------------------------------------------------------

----------------------------------------------------------------------------
begin

----------------------------------------------------------------------------
-- Instantiations
----------------------------------------------------------------------------

uart1 : uart_sqclk
    port map ( 

      sys_rst_n     => sys_rst_n,
      sys_clk       => sys_clk,
      sys_clk_en    => sys_clk_en,

      -- rate and parity
      parity_i      => parity_i,
      rate_clk_i    => baud_clk_i,

      -- serial I/O
      tx_stream     => resp_l,
      rx_stream     => cmd_i,

      --control and status
      tx_wr_i       => resp_cyc_uart,
      tx_dat_i      => resp_char,
      tx_done_o     => resp_ack_uart,
      rx_restart_i  => async_rx_restart,   -- High clears error flags, clears rx_done_o
      rx_dat_o      => cmd_char,
      rx_wr_o       => cmd_we_uart,        -- High pulse means store rx_dat_o.
      rx_done_o     => cmd_rx_done,        -- Remains high after receive, until clk edge with rx_restart_i=1
      frame_err_o   => async_rx_error(0),  -- High = error.  Reset when rx_restart_i asserted.
      parity_err_o  => async_rx_error(1)   -- High = error.  Reset when rx_restart_i asserted.
    );

syscon1 : ascii_syscon
    generic map(
      ADR_DIGITS      => ADR_DIGITS, -- # of hex digits for address
      DAT_DIGITS      => DAT_DIGITS, -- # of hex digits for data
      QTY_DIGITS      => QTY_DIGITS, -- # of hex digits for quantity
      CMD_BUFFER_SIZE => CMD_BUFFER_SIZE, -- # of chars in the command buffer
      WATCHDOG_VALUE  => WATCHDOG_VALUE, -- # of sys_clks before ack is expected
      DISPLAY_FIELDS  => DISPLAY_FIELDS -- # of fields/line
    )
    port map(
       
      sys_rst_n    => sys_rst_n,
      sys_clk      => sys_clk,
      sys_clk_en   => sys_clk_en,

      -- Parallel ASCII I/O
      cmd_char_i   => cmd_char,
      cmd_we_i     => cmd_we,
      cmd_ack_o    => cmd_ack,
      cmd_echo_o   => cmd_echo,
      resp_char_o  => resp_char,
      resp_cyc_o   => resp_cyc,
      resp_ack_i   => resp_ack,
      cmd_done_o   => cmd_done_o,

      -- Master Bus IO
      master_bg_i  => master_bg_i,
      master_ack_o => master_ack_o,
      master_adr_i => master_adr_i,
      master_dat_i => master_dat_i,
      master_dat_o => master_dat_o,
      master_stb_i => master_stb_i,
      master_we_i  => master_we_i,
      master_br_o  => master_br_o,

      -- System Bus IO
      ack_i        => ack_i,
      err_i        => err_i,
      dat_i        => dat_i,
      dat_o        => dat_o,
      rst_o        => rst_o,
      stb_o        => stb_o,
      cyc_o        => cyc_o,
      adr_o        => adr_o,
      we_o         => we_o
    );

----------------------------------------------------------------------------
-- Module code
----------------------------------------------------------------------------

async_rx_restart <= async_rx_error(0) or async_rx_error(1) or cmd_ack;
resp_o <= resp_l when cmd_echo='0' else
          cmd_i  when ECHO_COMMANDS/=0 else
          '1';

  -- Detect rising edge of resp_ack_uart
  resp_ack_proc: Process(sys_rst_n,sys_clk)
  begin
    if (sys_rst_n = '0') then
      resp_ack_uart_r1 <= '1';
    elsif (sys_clk'event AND sys_clk='1') then
      if (sys_clk_en='1') then
        resp_ack_uart_r1 <= resp_ack_uart;
      end if;
    end if; -- sys_clk
  end process;
  resp_ack <= '1' when resp_ack_uart='1' and resp_ack_uart_r1='0' else '0';

  -- Detect rising edge of resp_cyc
  resp_cyc_proc: Process(sys_rst_n,sys_clk)
  begin
    if (sys_rst_n = '0') then
      resp_cyc_r1 <= '1';
    elsif (sys_clk'event AND sys_clk='1') then
      if (sys_clk_en='1') then
        resp_cyc_r1 <= resp_cyc;
      end if;
    end if; -- sys_clk
  end process;
  resp_cyc_uart <= '1' when resp_cyc='1' and resp_cyc_r1='0' else '0';

  -- Create a valid command write enable, that waits until the final echoed
  -- character (CHAR_ENTER) is done being transmitted
  cmd_we_proc: Process(sys_rst_n,sys_clk)
  begin
    if (sys_rst_n = '0') then
      cmd_we_wait <= '0';
    elsif (sys_clk'event AND sys_clk='1') then
      if (sys_clk_en='1') then
        if (cmd_we_uart='1' and cmd_we_wait='0') then
          cmd_we_wait <= '1';
        end if;
        if (cmd_we_wait='1') then
          if (cmd_rx_done='1') then
            cmd_we_wait <= '0';
          end if;
        end if;
      end if;
    end if; -- sys_clk
  end process;

cmd_we <= cmd_we_uart when baud_lock_i='1' and cmd_char/=ENTER_CHAR else
          '1'         when baud_lock_i='1' and cmd_char=ENTER_CHAR and cmd_we_wait='1' and cmd_rx_done='1' else
          '0';

end beh;


