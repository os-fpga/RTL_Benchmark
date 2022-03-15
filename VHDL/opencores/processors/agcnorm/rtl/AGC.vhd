
-- Copyright (C) 2010 David E. Roberts <davee dot roberts at fsmail dot net>

-- This file is part of AGCNORM (Apollo Guidance Computer NOR eMulator).
--
-- AGCNORM is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- AGCNORM is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with AGCNORM. If not, see <http://www.gnu.org/licenses/>.

-- Functional description.
-- =======================
--
-- This file implements the highest-level module of the Block II Apollo Guidance Computer (AGC)
-- as published at <http://klabs.org/history/ech/agc_schematics>.
-- The logic is implemented as a VHDL description for a Xilinx Spartan 3E device (XC3S500E-FG320-4)
-- using release 11.1 of the ISE WebPACK tools.
--
-- Configuration switches.
-- =======================
--
-- SW3 SW2 SW1 SW0
-- 
-- On = DOWN Off = UP.
--
-- SW3 SW2 - Define Clock.
-- ON  XXX - Single Step CLock.
-- OFF ON  - 1Hz clock.
-- OFF OFF - 2.048 MHz clock.
--
-- SW1 SW0 - Define software.
-- ON  ON  - Colossus 249.
-- ON  OFF - Luminary 131.
-- OFF ON  - Spare (Lunar Lander?).
-- OFF OFF - Validation.
--
-- Modification History.
-- =====================
--
-- Version : 
--    Date : 
--  Author : 
--  Reason : 
--
-- Version : 2.50 (REV 03)
--    Date : 27th October 2010
--  Author : David E. Roberts
--  Reason : Added debounce of an externally-connected DSKY KEYBOARD (MAINRS). This *** WAS *** necessary!
--
-- Version : 2.40
--    Date : 27th October 2010
--  Author : David E. Roberts
--  Reason : Added "REV nn" to VGADEBUG (debugy=14).
--         : Added FPGA generation of MAINRS rather than from an external DSKY keyboard. May need to add some
--           debounce in the future.
--
-- Version : 2.20
--    Date : 26th October 2010
--  Author : David E. Roberts
--  Reason : Added I/O for FX2 (DSKY). Replaced LED array with the corresponding FX2 I/O.
--
-- Version : 2.10
--    Date : 01st October 2010
--  Author : David E. Roberts
--  Reason : Move Strata Flash (Fixed core rope) into AGC_MEMORY.
--         : Move T_SYSRESET into AGC_MEMORY. There is a good reason for it - honest!
--         : Correct errors with codes associated with VK_8 and VK_9!
--         : Add thruster and main engine to VGA debug display.
--
-- Version : 2.09
--    Date : 14th August 2010
--  Author : David E. Roberts
--  Reason : Convert from HydraXC-30 to Spartan 3E. Start to add VGA Diagnostic display.
--         : Add rotary encoder for a single step clock for debugging.
--         : Add DSKY display and keyboard for debugging.
--         : Change DSKY display debug from 'blobs' to actual characters.
--         : Add code to generate DSKY display segments rather than pre-canned numerals 
--           and my 'thought experiment' at how NASA has implemented the display decoding within the DSKY.
--           Start to add code for single_step_clock and simulated DSKY keyboard using the
--           rotary encoder (but only if the AGC clock is not being single stepped!)
--         : Add DSKY debug keyboard.
--
-- Version : 1.06
--    Date : 09th April 2010
--  Author : David E. Roberts
--  Reason : Increase number of DEBUG LEDS from 16 to 20 and the number of DEBUG SWITCHES
--           from 4 to 8. Seem to have a problem with the speed of OneHertzFlasher???
--
-- Version : 1.05
--    Date : 13th February 2010
--  Author : David E. Roberts
--  Reason : Hack 50 MHz clock down for testing! Slow down CLOCK dramatically to single step! 
--           Add DEBSWS.
--
-- Version : 1.04
--    Date : 07th February 2010
--  Author : David E. Roberts
--  Reason : Add DEBLEDS.
--
-- Version : 1.03
--    Date : 30th January 2010
--  Author : David E. Roberts
--  Reason : Add GREEN_LED2 and wire it up to the 1Hz flasher signal.
--
-- Version : 1.02
--    Date : 23rd January 2010
--  Author : David E. Roberts
--  Reason : Mass edit to add INPUT/OUTPUT records to/from AGC module to implement I/O signals.
--           Add code to perform SYSRESET and force STRT2 (10us and 20us respectively).
--
-- Version : 1.01
--    Date : 22nd January 2010
--  Author : David E. Roberts
--  Reason : Remove CLK0_FB from DCM (try and determine why the clock appears to be running 'slow' when
--           the design is synthesized but OK when it is simulated. IT NOW WORKS! Tidy up the code...
--
-- Version : 1.00
--    Date : 29th December 2009
--  Author : David E. Roberts
--  Reason : First creation

-- Known issues.
-- =============
--
-- None.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.AGCPACK.all;
use work.AGCIO.all;

entity AGC is
  port(
  
    --------------------------------
    --                            --
    --  The 50 MHz system clock!  --
    --                            --
    --------------------------------
    
    CLK_50MHz   : in  std_logic; -- The main system clock.

    --------------------------------
    --                            --
    --  Debug buttons and hacks.  --
    --                            --
    --------------------------------
    
    ROT_CENTER  : in  std_logic; -- Unpressed = '0'. Pressed = '1'. (Pull down resistor).
    ROT_A       : in  std_logic; -- Rotary shaft encoder phase A.   (Pull up   resistor).
    ROT_B       : in  std_logic; -- Rotary shaft encoder phase B.   (Pull up   resistor).
   
    SPI_SS_B    : out std_logic; -- Needs to be disabled on the Spartan-3E Starter Kit.
    AMP_CS      : out std_logic; -- Needs to be disabled on the Spartan-3E Starter Kit.
    AD_CONV     : out std_logic; -- Needs to be disabled on the Spartan-3E Starter Kit.
    FPGA_INIT_B : out std_logic; -- Needs to be disabled on the Spartan-3E Starter Kit.
    DAC_CS      : out std_logic; -- Needs to be disabled on the Spartan-3E Starter Kit.
    LCD_E       : out std_logic; -- Needs to be disabled on the Spartan-3E Starter Kit.
    LCD_RS      : out std_logic; -- Needs to be disabled on the Spartan-3E Starter Kit.
    LCD_RW      : out std_logic; -- Needs to be disabled on the Spartan-3E Starter Kit.
    
    ---------------------------------------------
    --                                         --
    --  Intel StrataFlash Parallel NOR Flash.  --
    --                                         --
    ---------------------------------------------
    
    SF_A        : out std_logic_vector( 24 downto 0 ); -- Address Bus.
    SF_D        : in  std_logic_vector( 15 downto 0 ); -- Data Bus.
    SF_BYTE     : out std_logic;                       -- 0 = 8-bit. 1=16-bit.
    SF_CE0      : out std_logic;                       -- Active Low Chip Select.
    SF_OE       : out std_logic;                       -- Active Low Output Enable.
    SF_WE       : out std_logic;                       -- Active Low Write Enable.

    ----------------------------
    --                        --
    --  Diagnostic VGA Port.  --
    --                        --
    ----------------------------

    VGA_RED     : out std_logic; -- Diagnostic VGA display red   signal.
    VGA_GREEN   : out std_logic; -- Diagnostic VGA display green signal. 
    VGA_BLUE    : out std_logic; -- Diagnostic VGA display blue  signal.
    VGA_HSYNC   : out std_logic; -- Diagnostic VGA display horizontal synchronisation signal.
    VGA_VSYNC   : out std_logic; -- Diagnostic VGA display vertical   synchronisation signal.

    -----------------------------------
    --                               --
    --  Discrete LEDs and switches.  --
    --                               --
    -----------------------------------
    
    SW          : in  std_logic_vector( 3 downto 0 ); -- English ON (away from the LED's) = '0'.

    -- Removed V2.20 LED         : out std_logic_vector( 7 downto 0 )  -- A '1' illuminates the LEDs.
    
    -------------------------
    --                     --
    --  FX2 I/O for DSKY.  --
    --                     --
    -------------------------
    
    FX2_IO1     : in  std_logic; -- J1 MKEY1.
    FX2_IO2     : in  std_logic; -- J1 MKEY2.
    FX2_IO3     : in  std_logic; -- J1 MKEY3.
    FX2_IO4     : in  std_logic; -- J1 MKEY4.

    FX2_IO5     : in  std_logic; -- J2 MKEY5.
    FX2_IO6     : in  std_logic; -- J2 PRO (CH #32 BIT 14).
    FX2_IO7     : in  std_logic; -- J2 MAINRS.
    FX2_IO8     : in  std_logic; -- J2 Enable external DSKY keyboard (with a default pull-down).

    FX2_IO9     : out std_logic; -- JP4 UPLACT (CH #11 BIT 03).
    FX2_IO10    : out std_logic; -- JP4 KYRLS  (CH #11 BIT 05).
    FX2_IO11    : out std_logic; -- JP4 TMPCAU (Hardwired logic).
    FX2_IO12    : out std_logic; -- JP4 VNFLSH (CH #11 BIT 06).

    FX2_IO13    : out std_logic; -- LED 7 OPEROR (CH #11 BIT 07).
    FX2_IO14    : out std_logic; -- LED 6 COMACT (CH #11 BIT 02).
    FX2_IO15    : out std_logic; -- LED 5 SBYLIT (hardwired logic).
    FX2_IO16    : out std_logic; -- LED 4 RESTRT (Hardwired logic).
    FX2_IO17    : out std_logic; -- LED 3 Diagnostic.
    FX2_IO18    : out std_logic; -- LED 2 Diagnostic.
    FX2_IO19    : out std_logic; -- LED 1 Diagnostic.
    FX2_IO20    : out std_logic; -- LED 0 Diagnostic.

    FX2_IO21    : out std_logic; -- CH #10 BIT 01
    FX2_IO22    : out std_logic; -- CH #10 BIT 02 
    FX2_IO23    : out std_logic; -- CH #10 BIT 03
    FX2_IO24    : out std_logic; -- CH #10 BIT 04
    FX2_IO25    : out std_logic; -- CH #10 BIT 05
    FX2_IO26    : out std_logic; -- CH #10 BIT 06
    FX2_IO27    : out std_logic; -- CH #10 BIT 07
    FX2_IO28    : out std_logic; -- CH #10 BIT 08
    FX2_IO29    : out std_logic; -- CH #10 BIT 09
    FX2_IO30    : out std_logic; -- CH #10 BIT 10
    FX2_IO31    : out std_logic; -- CH #10 BIT 11

    -- FX2_IO32 is shared with the StrataFlash (SF_A<24>) but not documented by Xilinx in the SPARTAN-3E User Guide.

    FX2_IO33    : out std_logic; -- CH #10 BIT 12
    FX2_IO34    : out std_logic; -- CH #10 BIT 13

    FX2_IO39    : out std_logic; -- CH #10 BIT 14

    FX2_CLKOUT  : out std_logic  -- CH #10 BIT 16

  );
end AGC;

architecture Rtl of AGC is

  component AGC_LOGIC
    port(
      SYSCLOCK : in  AGCBIT;
      SYSRESET : in  AGCBIT;
      SYSERROR : out AGCBIT;
      \CLOCK\  : in  AGCBIT;
      ECADR    : out AGCBITARRAY( 11 downto 1 );
      FCADR    : out AGCBITARRAY( 16 downto 1 );
      SAXX     : in  AGCBITARRAY( 15 downto 0 );
      GEMXX    : out AGCBITARRAY( 15 downto 0 );
      EWRITE   : out AGCBIT;
      EREAD    : out AGCBIT;
      ESTART   : out AGCBIT;
      FREAD    : out AGCBIT;
      INPUTS   : in  t_INPUTS;
      OUTPUTS  : out t_OUTPUTS;
      VGADEBUG : out t_debug
    );
  end component; -- AGC_LOGIC

  component AGC_MEMORY
    port(
      ECADR    : in  AGCBITARRAY( 11 downto 1 ); -- Erasable address.
      SAXX     : out AGCBITARRAY( 15 downto 0 ); -- Sense Amplifiers (data to AGC).
      GEMXX    : in  AGCBITARRAY( 15 downto 0 ); -- 'G' register data from AGC.
      EREAD    : in  AGCBIT;                     -- Erasable Read  signal.
      EWRITE   : in  AGCBIT;                     -- Erasable Write signal.
      ESTART   : in  AGCBIT;                     -- Erasable cycle start signal.
      FCADR    : in  AGCBITARRAY( 16 downto 1 ); -- Fixed address.
      FREAD    : in  AGCBIT;                     -- Fixed read signal.
      SF_A     : out AGCBITARRAY( 24 downto 0 ); -- Strata Flash Address.
      SF_D     : in  AGCBITARRAY( 15 downto 0 ); -- Strata Flash Data.
      SF_BYTE  : out AGCBIT;                     -- Strata Flash Byte Select.
      SF_CE    : out AGCBIT;                     -- Strata Flash Chip Enable.
      SF_OE    : out AGCBIT;                     -- Strata Flash Output Enable.
      SF_WE    : out AGCBIT;                     -- Strata Flash Write Enable.
      SW0      : in  AGCBIT;                     -- Fixed Core Rope Select (least significant bit).
      SW1      : in  AGCBIT;                     -- Fixed Core Rope Select (most significant bit).
      SYSCLOCK : in  AGCBIT;                     -- AGC system clock.
      SYSRESET : out AGCBIT                      -- AGC system reset.
    );
  end component; -- AGC_MEMORY

  signal CLOCK_50MHz   : std_logic;
  signal CLOCK_2048kHz : std_logic := '0';

  signal CLOCK_2048kHz_Counter : integer range 0 to 11 := 0;

  signal OneHertzCounter : integer range 0 to 1024_000 := 0;
  
  signal OneHertzFlasher : std_logic := '0';
  
  signal agc_clock : std_logic := '0';
  
  signal single_step_clock : std_logic := '0';
  
  signal T_SYSERROR : std_logic;
  signal T_SYSRESET : std_logic;
  
  signal T_STRT2 : std_logic := '1';
  
  signal StartCounter : integer range 0 to 39 := 0;
  
  signal ECADR  : AGCBITARRAY( 11 downto 1 );
  signal FCADR  : AGCBITARRAY( 16 downto 1 );
  signal SAXX   : AGCBITARRAY( 15 downto 0 );
  signal GEMXX  : AGCBITARRAY( 15 downto 0 );

  signal FREAD  : AGCBIT;
  signal EREAD  : AGCBIT;
  signal EWRITE : AGCBIT;
  signal ESTART : AGCBIT;
  
  signal INPUTS  : t_INPUTS;
  signal OUTPUTS : t_OUTPUTS;
  
  signal CLOCK_25MHz : std_logic := '0';
  signal hcounter    : integer range 0 to 800;
  signal vcounter    : integer range 0 to 521;
  signal gdebug      : t_debug;
  signal DSKY_DEBUG  : d_debug;
  
  --
  -- Signals used to interface to rotary encoder
  --
  
  signal      rotary_a_in : std_logic;
  signal      rotary_b_in : std_logic;
  signal        rotary_in : std_logic_vector( 1 downto 0 );
  signal        rotary_q1 : std_logic;
  signal        rotary_q2 : std_logic;
  signal  delay_rotary_q1 : std_logic;
  signal     rotary_event : std_logic;
  signal      rotary_left : std_logic;

  signal raw_mainrs       : std_logic;
  signal debounced_mainrs : std_logic;

  subtype t_keybits is std_logic_vector( 6 downto 1 );

  constant VK_NONE   : t_keybits := "000000";

  constant VK_0      : t_keybits := "010000";
  constant VK_1      : t_keybits := "000001";
  constant VK_2      : t_keybits := "000010";
  constant VK_3      : t_keybits := "000011";
  constant VK_4      : t_keybits := "000100";
  constant VK_5      : t_keybits := "000101";
  constant VK_6      : t_keybits := "000110";
  constant VK_7      : t_keybits := "000111";
  constant VK_8      : t_keybits := "001000";
  constant VK_9      : t_keybits := "001001";
  constant VK_VERB   : t_keybits := "010001";
  constant VK_RSET   : t_keybits := "010010";
  constant VK_KEYREL : t_keybits := "011001";
  constant VK_PLUS   : t_keybits := "011010";
  constant VK_MINUS  : t_keybits := "011011";
  constant VK_ENTR   : t_keybits := "011100";
  constant VK_CLR    : t_keybits := "011110";
  constant VK_NOUN   : t_keybits := "011111";
    
  constant VK_PRO    : t_keybits := "100000";
  
  type t_keyboard_array is array( natural range <> ) of t_keybits;

  constant keyboard : t_keyboard_array( 0 to 18 ) := (
    VK_0,      --  0 CHAR_0     0
    VK_1,      --  1 CHAR_1     1
    VK_2,      --  2 CHAR_2     2
    VK_3,      --  3 CHAR_3     3
    VK_4,      --  4 CHAR_4     4
    VK_5,      --  5 CHAR_5     5
    VK_6,      --  6 CHAR_6     6
    VK_7,      --  7 CHAR_7     7
    VK_8,      --  8 CHAR_8     8
    VK_9,      --  9 CHAR_9     9
    VK_PLUS,   -- 10 CHAR_PLUS  +
    VK_MINUS,  -- 11 CHAR_MINUS -
    VK_VERB,   -- 12 CHAR_V     V
    VK_NOUN,   -- 13 CHAR_N     N
    VK_CLR,    -- 14 CHAR_C     C
    VK_PRO,    -- 15 CHAR_P     P
    VK_KEYREL, -- 16 CHAR_K     K
    VK_ENTR,   -- 17 CHAR_E     E
    VK_RSET    -- 18 CHAR_R     R
  );

  -- V35E      = Test DSKY
  -- V36E      = Clear DSKY
  -- V16N36E   = display mission clock
  
  type t_charseg is array( 0 to 15 ) of std_logic_vector( 0 to 15 );
  
  constant charsega : t_charseg := (
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000001111000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000"
  );
  
  constant charsegb : t_charseg := (
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000100000",
    "0000000000100000",
    "0000000000100000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000"
  );
  
  constant charsegc : t_charseg := (
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000100000",
    "0000000000100000",
    "0000000000100000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000"
  );
  
  constant charsegd : t_charseg := (
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000001111000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000"
  );
  
  constant charsege : t_charseg := (
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000010000000000",
    "0000010000000000",
    "0000010000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000"
  );
  
  constant charsegf : t_charseg := (
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000010000000000",
    "0000010000000000",
    "0000010000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000"
  );
  
  constant charsegg : t_charseg := (
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000001111000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000",
    "0000000000000000"
  );

  subtype t_charindex is integer range 0 to 23;
  
  type t_chargen is array( t_charindex, 0 to 15 ) of std_logic_vector( 0 to 15 );
  
  constant CHAR_0        : integer :=  0;
  constant CHAR_1        : integer :=  1;
  constant CHAR_2        : integer :=  2;
  constant CHAR_3        : integer :=  3;
  constant CHAR_4        : integer :=  4;
  constant CHAR_5        : integer :=  5;
  constant CHAR_6        : integer :=  6;
  constant CHAR_7        : integer :=  7;
  constant CHAR_8        : integer :=  8;
  constant CHAR_9        : integer :=  9;
  constant CHAR_PLUS     : integer := 10;
  constant CHAR_MINUS    : integer := 11;
  constant CHAR_V        : integer := 12;
  constant CHAR_N        : integer := 13;
  constant CHAR_C        : integer := 14;
  constant CHAR_P        : integer := 15;
  constant CHAR_K        : integer := 16;
  constant CHAR_E        : integer := 17;
  constant CHAR_R        : integer := 18;
  constant CHAR_SPACE    : integer := 19;
  constant CHAR_QUESTION : integer := 20;
  constant CHAR_BLOCK    : integer := 21;
  constant CHAR_SINV     : integer := 22;
  constant CHAR_JET      : integer := 23;
  
  constant chargen : t_chargen := (
    --  0 = 0
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000001111000000",
     "0000011001100000",
     "0000110000110000",
     "0000110000110000",
     "0000110000110000",
     "0000110000110000",
     "0000110000110000",
     "0000110000110000",
     "0000011001100000",
     "0000001111000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    --  1 = 1
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000010000000",
     "0000000110000000",
     "0000001110000000",
     "0000011110000000",
     "0000000110000000",
     "0000000110000000",
     "0000000110000000",
     "0000000110000000",
     "0000000110000000",
     "0000011111100000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    --  2 = 2
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000001111000000",
     "0000011001100000",
     "0000110000110000",
     "0000000000110000",
     "0000000001100000",
     "0000000011000000",
     "0000000110000000",
     "0000001100000000",
     "0000011000000000",
     "0000111111110000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    --  3 = 3
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000111111110000",
     "0000000000110000",
     "0000000001100000",
     "0000000011000000",
     "0000000000110000",
     "0000000000110000",
     "0000000000110000",
     "0000110000110000",
     "0000011001100000",
     "0000001111000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    --  4 = 4
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000100000",
     "0000000001100000",
     "0000000011100000",
     "0000000111100000",
     "0000001101100000",
     "0000011001100000",
     "0000111111110000",
     "0000000001100000",
     "0000000001100000",
     "0000000001100000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    --  5 = 5
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000111111110000",
     "0000110000000000",
     "0000110000000000",
     "0000111111000000",
     "0000000001100000",
     "0000110000110000",
     "0000110000110000",
     "0000110000110000",
     "0000011001100000",
     "0000001111000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    --  6 = 6
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000110000000",
     "0000001100000000",
     "0000011000000000",
     "0000111111000000",
     "0000111001100000",
     "0000110000110000",
     "0000110000110000",
     "0000110000110000",
     "0000011001100000",
     "0000001111000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    --  7 = 7
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000111111110000",
     "0000000000110000",
     "0000000001100000",
     "0000000001100000",
     "0000000011000000",
     "0000000011000000",
     "0000000110000000",
     "0000000110000000",
     "0000001100000000",
     "0000001100000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    --  8 = 8
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000001111000000",
     "0000011001100000",
     "0000011001100000",
     "0000001111000000",
     "0000011001100000",
     "0000110000110000",
     "0000110000110000",
     "0000110000110000",
     "0000011001100000",
     "0000001111000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    --  9 = 9
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000011111100000",
     "0000110000110000",
     "0000110000110000",
     "0000011111110000",
     "0000000001100000",
     "0000000001100000",
     "0000000011000000",
     "0000000011000000",
     "0000000110000000",
     "0000000110000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    -- 10 = +
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000110000000",
     "0000000110000000",
     "0000000000000000",
     "0000111111110000",
     "0000111111110000",
     "0000000000000000",
     "0000000110000000",
     "0000000110000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    -- 11 = -
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000111111110000",
     "0000111111110000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    -- 12 = V
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000110000110000",
     "0000110000110000",
     "0000110000110000",
     "0000011001100000",
     "0000011001100000",
     "0000011001100000",
     "0000001111000000",
     "0000001111000000",
     "0000000110000000",
     "0000000110000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    -- 13 = N
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000100000110000",
     "0000110000110000",
     "0000111000110000",
     "0000110100110000",
     "0000110010110000",
     "0000110001110000",
     "0000110000110000",
     "0000110000110000",
     "0000110000110000",
     "0000110000110000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    -- 14 = C
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000001111000000",
     "0000011001100000",
     "0000110000110000",
     "0000110000000000",
     "0000110000000000",
     "0000110000000000",
     "0000110000110000",
     "0000110000110000",
     "0000011001100000",
     "0000001111000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    -- 15 = P
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000111111100000",
     "0000110000110000",
     "0000110000110000",
     "0000111111100000",
     "0000110000000000",
     "0000110000000000",
     "0000110000000000",
     "0000110000000000",
     "0000110000000000",
     "0000110000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    -- 16 = K
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000110000110000",
     "0000110001100000",
     "0000110011000000",
     "0000111110000000",
     "0000110011000000",
     "0000110011000000",
     "0000110001100000",
     "0000110001100000",
     "0000110000110000",
     "0000110000110000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    -- 17 = E
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000111111110000",
     "0000110000000000",
     "0000110000000000",
     "0000111111100000",
     "0000110000000000",
     "0000110000000000",
     "0000110000000000",
     "0000110000000000",
     "0000110000000000",
     "0000111111110000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    -- 18 = R
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000111111100000",
     "0000110000110000",
     "0000110000110000",
     "0000111111100000",
     "0000110001100000",
     "0000110000110000",
     "0000110000110000",
     "0000110000110000",
     "0000110000110000",
     "0000110000110000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    -- 19 = <SPACE>
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    -- 20 = ?
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000001111000000",
     "0000011001100000",
     "0000110000110000",
     "0000110000110000",
     "0000000001100000",
     "0000000111000000",
     "0000000110000000",
     "0000000000000000",
     "0000000110000000",
     "0000000110000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    -- 21 = <BLOCK>
    ("0000000000000000",
     "0111111111111110",
     "0111111111111110",
     "0111111111111110",
     "0111111111111110",
     "0111111111111110",
     "0111111111111110",
     "0111111111111110",
     "0111111111111110",
     "0111111111111110",
     "0111111111111110",
     "0111111111111110",
     "0111111111111110",
     "0111111111111110",
     "0111111111111110",
     "0000000000000000"),
    -- 22 = <SINV>
    ("0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000110000000",
     "0000001111000000",
     "0000011111100000",
     "0000110110110000",
     "0000111111110000",
     "0000001001000000",
     "0000010110100000",
     "0000101001010000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000",
     "0000000000000000"),
    -- 23 = <JET>
    ("0000000000000000",
     "0000000000000000",
     "0000011111100000",
     "0000001111000000",
     "0000001111000000",
     "0010000110000100",
     "0011100110011100",
     "0011111001111100",
     "0011111001111100",
     "0011100110011100",
     "0010000110000100",
     "0000001111000000",
     "0000001111000000",
     "0000011111100000",
     "0000000000000000",
     "0000000000000000")
  );

  signal poke : t_keybits;
  
  signal desired_key_index : integer range keyboard'range := CHAR_P; -- Default on reset is PRO key.
  
begin

  ---------------------------------------------
  --  HACKS FOR THE SPARTAN-3E STARTER KIT.  --
  ---------------------------------------------

  SPI_SS_B    <= '1'; -- SPI Serial Flash.
  AMP_CS      <= '1'; -- Programmable amplifier.
  AD_CONV     <= '0'; -- Analogue to digital converter.
  FPGA_INIT_B <= '0'; -- Platform Flash PROM (Note potential error in Xilinx documentation here).
  DAC_CS      <= '1'; -- Digital to analogue converter.
  LCD_E       <= '0'; -- LCD
  LCD_RS      <= '0'; -- LCD
  LCD_RW      <= '0'; -- LCD

  --------------------
  --  CLOCK LOGIC.  --
  --------------------
  
  -- The Spartan 3E development board contains a 50 MHz oscillator.
  
  -- The Apollo Guidance Computer (AGC) requires a 'raw' clock of 2.048 MHz. This can be approximated
  -- by dividing the 50 MHz clock by 24 to give 2.08333 recurring MHz. This results in an increase
  -- in the clock frequency by approximately 1.73%.
  --
  -- The divide by 24 is implemented by dividing the 50 MHz clock by 12 and toggling the state of the
  -- clock signal fed to the AGC logic. This yields a symetrical 50:50 square wave clock of the
  -- desired frequency.
  
  CLOCK_50MHz <= CLK_50MHz;
  
  process( CLOCK_50MHz ) is
  begin
  
    if rising_edge( CLOCK_50MHz ) then
    
      CLOCK_2048kHz_Counter <= CLOCK_2048kHz_Counter + 1;
      
      if CLOCK_2048kHz_Counter = 11 then
      
        CLOCK_2048kHz_Counter <= 0;
        
        CLOCK_2048kHz <= not CLOCK_2048kHz;
        
      end if;
      
    end if;
    
  end process;

  process( CLOCK_2048kHz ) is
  begin
  
    if rising_edge( CLOCK_2048kHz ) then
    
      OneHertzCounter <= OneHertzCounter + 1;
      
      if OneHertzCounter = 1024_000 then
      
        OneHertzCounter <= 0;
        
        OneHertzFlasher <= not OneHertzFlasher;
        
      end if;
      
    end if;
    
  end process;

  ---------------------------------------------------
  -- Interface to rotary encoder.
  -- Detection of movement and direction.
  ---------------------------------------------------
  
  -- The rotary switch contacts are filtered using their offset (one-hot) style to  
  -- clean them. Circuit concept by Peter Alfke.
  -- Note that the clock rate is fast compared with the switch rate.

  rotary_filter: process( CLOCK_50MHz )
  begin
  
    if rising_edge(CLOCK_50MHz) then

      --Synchronise inputs to clock domain using flip-flops in input/output blocks.
      
      rotary_a_in <= ROT_A;
      rotary_b_in <= ROT_B;

      --concatinate rotary input signals to form vector for case construct.
      
      rotary_in <= rotary_b_in & rotary_a_in;

      case rotary_in is

        when "00" => rotary_q1 <= '0';         
                     rotary_q2 <= rotary_q2;
 
        when "01" => rotary_q1 <= rotary_q1;
                     rotary_q2 <= '0';

        when "10" => rotary_q1 <= rotary_q1;
                     rotary_q2 <= '1';

        when "11" => rotary_q1 <= '1';
                     rotary_q2 <= rotary_q2; 

        when others => rotary_q1 <= rotary_q1; 
                       rotary_q2 <= rotary_q2; 
                       
      end case; -- rotary_in

    end if; -- CLOCK_50MHz
    
  end process rotary_filter;
  
  --
  -- The rising edges of 'rotary_q1' indicate that a rotation has occurred and the 
  -- state of 'rotary_q2' at that time will indicate the direction. 
  --
  
  direction: process( CLOCK_50MHz )
  begin
  
    if rising_edge(CLOCK_50MHz) then

      delay_rotary_q1 <= rotary_q1;
      if rotary_q1='1' and delay_rotary_q1='0' then
        rotary_event <= '1';
        rotary_left <= rotary_q2;
       else
        rotary_event <= '0';
        rotary_left <= rotary_left;
      end if;

    end if; -- CLOCK_50MHz
    
  end process direction;

  process( CLOCK_50MHz ) is
  begin
    if rising_edge(CLOCK_50MHz) then
      if (not SW(3)) = '1' then
        -- Single Step Clock (rotary encoder)
        single_step_clock <= '1'; -- Can't use simulated DSKY keyboard as the rotary encoder is used as a single step clock...
        if rotary_event = '1' then
          agc_clock <= not agc_clock;
        end if;
      elsif (not SW(2)) = '1' then
        -- Slow Clock (1Hz)
        single_step_clock <= '0'; -- Can use simulated DSKY keyboard.
        agc_clock <= OneHertzFlasher;
      else
        -- Normal Clock (2.048 MHz)
        single_step_clock <= '0'; -- We can use the simulated DSKY keyboard.
        agc_clock <= CLOCK_2048kHz;
      end if; -- SW(x) decode
    end if; -- CLOCK_50MHz
  end process;
  
  process( agc_clock, T_SYSRESET ) is
  begin
  
    if T_SYSRESET = '1' then
    
      StartCounter <= 0;
      
    elsif rising_edge( agc_clock ) then

      StartCounter <= StartCounter + 1;
      
      if StartCounter = 10 then
      
        StartCounter <= 0;
        
        T_STRT2 <= '0';
      
      end if;
      
    end if;
    
  end process;

  -- Generate a 25 MHz pixel clock from the 50 MHz system clock.
  pixclk: process( CLOCK_50MHz )
  begin
    if rising_edge( CLOCK_50MHz ) then
      CLOCK_25MHz <= not CLOCK_25MHz;
    end if; -- CLOCK_50MHz
  end process pixclk;

  -- Dignostic VGA screen logic.
  vga: process( CLOCK_25MHz, hcounter, vcounter )
    variable x          : integer range 0 to 639;
    variable y          : integer range 0 to 479;
    variable cellx      : integer range 0 to 15;
    variable celly      : integer range 0 to 15;
    variable grid       : std_logic;
    variable debugx     : integer range DEBUG_X_MIN to DEBUG_X_MAX;
    variable debugy     : integer range DEBUG_Y_MIN to DEBUG_Y_MAX;
    variable EDCBA      : std_logic_vector( 5 downto 1 ); -- 5 bits for a number.
    variable E,D,C,B,A  : std_logic;
    variable sega,segb,segc,segd,sege,segf,segg : std_logic;
    variable flashvn    : std_logic;
    variable derivedpix : std_logic;
    variable SIGNPM     : std_logic_vector( 2 downto 1 ); -- 2 bits for the sign.
    variable alarmbit   : std_logic;
    variable thruston   : std_logic;
    variable dispchar   : t_charindex;
    variable dispcol    : VGA_COLOUR;
    variable dispinv    : std_logic;
    variable pixel      : std_logic;
  begin
    -- hcounter counts from 0 to 799
    -- vcounter counts from 0 to 520
    -- x coordinate: 0 - 639 (x = hcounter - 144, i.e., hcounter -Tpw-Tbp)
    -- y coordinate: 0 - 479 (y = vcounter - 31, i.e., vcounter-Tpw-Tbp)
    x := hcounter - 144;
    y := vcounter - 31;
    if rising_edge( CLOCK_25MHz ) then
      cellx := x mod 16;
      celly := y mod 16;
      debugx := x / 16;
      debugy := y / 16;
      if (cellx=0) or (cellx=15) or (celly=0) or (celly=15) then
        grid := '1';
      else
        grid := '0';
      end if; -- cellx and celly
      if x < 640 and y < 480 then
        if grid='1' then
          VGA_RED   <= VGA_CWHITE(2);
          VGA_GREEN <= VGA_CWHITE(1);
          VGA_BLUE  <= VGA_CWHITE(0);
        else
          if debugy >= 8 and debugy <= 20 and debugx >= 29 and debugx <= 39 then
            -- DSKY DEBUG DISPLAY
            -- Default values.
            dispchar   := CHAR_SPACE;
            dispcol    := VGA_CGREEN;
            dispinv    := '0';
            alarmbit   := '0';
            flashvn    := '0';
            derivedpix := '0';
            -- Check for one of the three sign digits.
            if debugx=34 and (debugy=10 or debugy=11 or debugy=12) then
              if    debugy=10 then -- +/- 1
                SIGNPM := DSKY_DEBUG(7)(11) & DSKY_DEBUG(6)(11);
              elsif debugy=11 then -- +/- 2
                SIGNPM := DSKY_DEBUG(5)(11) & DSKY_DEBUG(4)(11);
              elsif debugy=12 then -- +/- 3
                SIGNPM := DSKY_DEBUG(2)(11) & DSKY_DEBUG(1)(11);
              end if; -- debugy
              case SIGNPM is
                when "00"   => dispchar := CHAR_SPACE;
                when "01"   => dispchar := CHAR_MINUS;
                when "10"   => dispchar := CHAR_PLUS;
                when others => dispchar := CHAR_QUESTION; -- This catches the "11" case.
              end case; -- SIGNPM
            elsif (debugx=34 or debugx=35) and debugy=8 then -- COMputer ACTivity CH 11 bit 2.
              if OUTPUTS.\COMACT\ = '1' then
                dispchar := CHAR_SINV;
              else
                dispchar := CHAR_SPACE;
              end if;
            elsif  (debugx=30 or debugx=32) and debugy >= 8 and debugy <= 14 then -- Alarms
              alarmbit := '0'; -- No alarm by default.
              if    debugx=30 then
                dispcol  := VGA_CWHITE;
                case debugy is
                  when  8     => alarmbit := OUTPUTS.\UPLACT\;
                  when  9     => alarmbit := DSKY_DEBUG(12)(4);
                  when 10     => alarmbit := OUTPUTS.\SBYLIT\;
                  when 11     => alarmbit := OUTPUTS.\KYRLS\;
                  when 12     => alarmbit := OUTPUTS.\OPEROR\;
                  when 13     => alarmbit := '0'; -- Unused?
                  when 14     => alarmbit := '0'; -- Unused?
                  when others => null;
                end case; -- debugy
              elsif debugx=32 then
                dispcol  := VGA_CYELLOW;
                case debugy is
                  when  8     => alarmbit := OUTPUTS.\TMPCAU\;
                  when  9     => alarmbit := DSKY_DEBUG(12)(6);
                  when 10     => alarmbit := DSKY_DEBUG(12)(9);
                  when 11     => alarmbit := OUTPUTS.\RESTRT\;
                  when 12     => alarmbit := DSKY_DEBUG(12)(8);
                  when 13     => alarmbit := DSKY_DEBUG(12)(5);
                  when 14     => alarmbit := DSKY_DEBUG(12)(3);
                  when others => null;
                end case; -- debugy
              end if; -- debugx
              if alarmbit = '1' then
                dispchar := CHAR_BLOCK;
              else
                dispchar := CHAR_SPACE;
              end if; -- alarmbit
            elsif debugx >= 30 and (debugy=16 or debugy=17) then -- Simulated DSKY keyboard
              dispchar := CHAR_SPACE;
              dispcol  := VGA_CWHITE;
              if debugy = 16 then
                dispchar := debugx - 30; -- Numbers 0,1,2,3,4,5,6,7,8 and 9.
              elsif debugy = 17 then
                dispchar := debugx - 30 + 10; -- Symbols +,-,V,N,C,P,K,E and R.
              end if;
              if single_step_clock = '0' then
                -- Set 'dispinv' if necessary.
                if dispchar = desired_key_index then
                  dispinv := '1';
                end if; -- dispchar = desired_key_index
              end if; -- single_step_clock;
            elsif ((debugy=19) or (debugy=20)) and (debugx >= 30) then
              dispcol  := VGA_CRED;
              thruston := '0'; -- No thruster by default.
              if debugy=19 then
                case debugx is
                  when 30     => thruston := OUTPUTS.\OT1113\; -- CH #11 BIT 13 (ENGINE ON)
                  when 32     => thruston := OUTPUTS.\RC+X-Y\; -- CH #05 BIT 08
                  when 33     => thruston := OUTPUTS.\RC-X+Y\; -- CH #05 BIT 07
                  when 34     => thruston := OUTPUTS.\RC-X-Y\; -- CH #05 BIT 06
                  when 35     => thruston := OUTPUTS.\RC+X+Y\; -- CH #05 BIT 05
                  when 36     => thruston := OUTPUTS.\RC+X-P\; -- CH #05 BIT 04
                  when 37     => thruston := OUTPUTS.\RC-X+P\; -- CH #05 BIT 03
                  when 38     => thruston := OUTPUTS.\RC-X-P\; -- CH #05 BIT 02
                  when 39     => thruston := OUTPUTS.\RC+X+P\; -- CH #05 BIT 01
                  when others => null;
                end case; -- debugx
              elsif debugy=20 then
                case debugx is
                  when 30     => thruston := OUTPUTS.\OT1114\; -- CH #11 BIT 14 (ENGINE OFF)
                                 dispcol  := VGA_CWHITE;       -- The exception to the rule...
                  when 32     => thruston := OUTPUTS.\RC+Y-R\; -- CH #06 BIT 08
                  when 33     => thruston := OUTPUTS.\RC-Y+R\; -- CH #06 BIT 07
                  when 34     => thruston := OUTPUTS.\RC-Y-R\; -- CH #06 BIT 06
                  when 35     => thruston := OUTPUTS.\RC+Y+R\; -- CH #06 BIT 05
                  when 36     => thruston := OUTPUTS.\RC+Z-R\; -- CH #06 BIT 04
                  when 37     => thruston := OUTPUTS.\RC-Z+R\; -- CH #06 BIT 03
                  when 38     => thruston := OUTPUTS.\RC-Z-R\; -- CH #06 BIT 02
                  when 39     => thruston := OUTPUTS.\RC+Z+R\; -- CH #06 BIT 01
                  when others => null;
                end case; -- debugx
              end if; -- debugy
              if thruston = '1' then
                dispchar := CHAR_JET;
              else
                dispchar := CHAR_SPACE;
              end if; -- thruston

            elsif (debugy = 14) and (debugx >= 34) and (debugx <= 39) then

              -- **************************
              -- ***                    ***
              -- ***  Version control.  ***
              -- ***                    ***
              -- **************************

              dispcol := VGA_CRED;
              dispinv := '1';

              case debugx is
                when 34     => dispchar := CHAR_R;     -- 'R'
                when 35     => dispchar := CHAR_E;     -- 'E'
                when 36     => dispchar := CHAR_V;     -- 'V'
                when 37     => dispchar := CHAR_SPACE; -- ' '
                when 38     => dispchar := CHAR_0;     -- '0'
                when 39     => dispchar := CHAR_3;     -- '3'
                when others => null;                   -- Ignore
              end case; -- debugx

            else
              if    debugx=38 and debugy=8 then -- M1
                EDCBA := DSKY_DEBUG(11)(10 downto 6);
              elsif debugx=39 and debugy=8 then -- M2
                EDCBA := DSKY_DEBUG(11)(5 downto 1);
              elsif debugx=34 and debugy=9 then -- V1
                EDCBA := DSKY_DEBUG(10)(10 downto 6);
                flashvn := OUTPUTS.\VNFLSH\;
              elsif debugx=35 and debugy=9 then -- V2
                EDCBA := DSKY_DEBUG(10)(5 downto 1); 
                flashvn := OUTPUTS.\VNFLSH\;                
              elsif debugx=38 and debugy=9 then -- N1
                EDCBA := DSKY_DEBUG(9)(10 downto 6);
                flashvn := OUTPUTS.\VNFLSH\;
              elsif debugx=39 and debugy=9 then -- N2
                EDCBA := DSKY_DEBUG(9)(5 downto 1);
                flashvn := OUTPUTS.\VNFLSH\;
              elsif debugx=35 and debugy=10 then -- 11
                EDCBA := DSKY_DEBUG(8)(5 downto 1);
              elsif debugx=36 and debugy=10 then -- 12
                EDCBA := DSKY_DEBUG(7)(10 downto 6);
              elsif debugx=37 and debugy=10 then -- 13
                EDCBA := DSKY_DEBUG(7)(5 downto 1);
              elsif debugx=38 and debugy=10 then -- 14
                EDCBA := DSKY_DEBUG(6)(10 downto 6);
              elsif debugx=39 and debugy=10 then -- 15
                EDCBA := DSKY_DEBUG(6)(5 downto 1);
              elsif debugx=35 and debugy=11 then -- 21
                EDCBA := DSKY_DEBUG(5)(10 downto 6);
              elsif debugx=36 and debugy=11 then -- 22
                EDCBA := DSKY_DEBUG(5)(5 downto 1);
              elsif debugx=37 and debugy=11 then -- 23
                EDCBA := DSKY_DEBUG(4)(10 downto 6);
              elsif debugx=38 and debugy=11 then -- 24
                EDCBA := DSKY_DEBUG(4)(5 downto 1);
              elsif debugx=39 and debugy=11 then -- 25
                EDCBA := DSKY_DEBUG(3)(10 downto 6);
              elsif debugx=35 and debugy=12 then -- 31
                EDCBA := DSKY_DEBUG(3)(5 downto 1);
              elsif debugx=36 and debugy=12 then -- 32
                EDCBA := DSKY_DEBUG(2)(10 downto 6);
              elsif debugx=37 and debugy=12 then -- 33
                EDCBA := DSKY_DEBUG(2)(5 downto 1);
              elsif debugx=38 and debugy=12 then -- 34
                EDCBA := DSKY_DEBUG(1)(10 downto 6);
              elsif debugx=39 and debugy=12 then -- 35
                EDCBA := DSKY_DEBUG(1)(5 downto 1);
              else
                EDCBA := "00000"; -- BLANK
              end if; -- debugx, debugy
              E := EDCBA(5);
              D := EDCBA(4);
              C := EDCBA(3);
              B := EDCBA(2);
              A := EDCBA(1);
              sega := E and (C or A);
              segb := A;
              segc := C or (A and B);
              segd := E and (D or C);
              sege := E and not B;
              segf := C;
              segg := D;
              pixel := ( ( charsega( celly )( cellx ) and sega ) or
                         ( charsegb( celly )( cellx ) and segb ) or
                         ( charsegc( celly )( cellx ) and segc ) or
                         ( charsegd( celly )( cellx ) and segd ) or
                         ( charsege( celly )( cellx ) and sege ) or
                         ( charsegf( celly )( cellx ) and segf ) or
                         ( charsegg( celly )( cellx ) and segg )    ) and (not flashvn);
              derivedpix := '1';
            end if; -- debugx, debugy
            -- At this point 'dispchar', 'dispcol' and 'dispinv' must have been defined or
            -- 'derivedpix' and 'pixel'.
            if derivedpix = '0' then
              pixel := chargen( dispchar, celly )( cellx ); -- Extract desired pixel from character generator
            end if; -- derivedpix
            if pixel = '1' then
              if dispinv = '0' then
                VGA_RED   <= dispcol( 2 );
                VGA_GREEN <= dispcol( 1 ); 
                VGA_BLUE  <= dispcol( 0 );
              else
                VGA_RED   <= VGA_CBLACK( 2 );
                VGA_GREEN <= VGA_CBLACK( 1 ); 
                VGA_BLUE  <= VGA_CBLACK( 0 );
              end if; -- dispinv
            else
              if dispinv = '0' then
                VGA_RED   <= VGA_CBLACK( 2 );
                VGA_GREEN <= VGA_CBLACK( 1 ); 
                VGA_BLUE  <= VGA_CBLACK( 0 );
              else
                VGA_RED   <= dispcol( 2 );
                VGA_GREEN <= dispcol( 1 ); 
                VGA_BLUE  <= dispcol( 0 );
              end if; -- dispinv
            end if; -- pixel
          elsif gdebug( debugx, debugy ) = '1' then
            if debugy = 0 then
              VGA_RED   <= VGA_CRED( 2 );
              VGA_GREEN <= VGA_CRED( 1 ); 
              VGA_BLUE  <= VGA_CRED( 0 );
            elsif debugy <= 3 then
              VGA_RED   <= VGA_CGREEN( 2 );
              VGA_GREEN <= VGA_CGREEN( 1 ); 
              VGA_BLUE  <= VGA_CGREEN( 0 );
            elsif debugy <= 7 then
              VGA_RED   <= VGA_CBLUE( 2 );
              VGA_GREEN <= VGA_CBLUE( 1 ); 
              VGA_BLUE  <= VGA_CBLUE( 0 );
            elsif debugy <= 20 then
              VGA_RED   <= VGA_CMAGENTA( 2 );
              VGA_GREEN <= VGA_CMAGENTA( 1 ); 
              VGA_BLUE  <= VGA_CMAGENTA( 0 );
            elsif debugy <= 27 then
              VGA_RED   <= VGA_CCYAN( 2 );
              VGA_GREEN <= VGA_CCYAN( 1 ); 
              VGA_BLUE  <= VGA_CCYAN( 0 );
            else
              VGA_RED   <= VGA_CWHITE(2);
              VGA_GREEN <= VGA_CWHITE(1);
              VGA_BLUE  <= VGA_CWHITE(0);
            end if; -- debugy
          else
            VGA_RED   <= VGA_CBLACK( 2 );
            VGA_GREEN <= VGA_CBLACK( 1 ); 
            VGA_BLUE  <= VGA_CBLACK( 0 );
          end if; -- gdebug          
        end if; -- grid
      else
        -- if not traced, set it to "black" colour
        VGA_RED   <= VGA_CBLACK(2);
        VGA_GREEN <= VGA_CBLACK(1);
        VGA_BLUE  <= VGA_CBLACK(0);
      end if; -- x and y
      -- Here is the timing for horizontal synchronisation.
      -- (Refer to p. 24, Xilinx, Spartan-3 Starter Kit Board User Guide)
      -- Pulse width: Tpw = 96 cycles @ 25 MHz
      -- Back porch: Tbp = 48 cycles
      -- Display time: Tdisp = 640 cycles
      -- Front porch: Tfp = 16 cycles
      -- Sync pulse time (total cycles) Ts = 800 cycles
      if hcounter > 0 and hcounter < 97 then
        VGA_HSYNC <= '0';
      else
        VGA_HSYNC <= '1';
      end if; -- hcounter
      -- Here is the timing for vertical synchronisation.
      -- (Refer to p. 24, Xilinx, Spartan-3 Starter Kit Board User Guide)
      -- Pulse width: Tpw = 1600 cycles (2 lines) @ 25 MHz
      -- Back porch: Tbp = 23200 cycles (29 lines)
      -- Display time: Tdisp = 38400 cycles (480 lines)
      -- Front porch: Tfp = 8000 cycles (10 lines)
      -- Sync pulse time (total cycles) Ts = 416800 cycles (521 lines)
      if vcounter > 0 and vcounter < 3 then
        VGA_VSYNC <= '0';
      else
        VGA_VSYNC <= '1';
      end if; -- vcounter
      -- horizontal counts from 0 to 799
      hcounter <= hcounter+1;
      if hcounter = 800 then
        vcounter <= vcounter+1;
        hcounter <= 0;
      end if; -- hcounter
      -- vertical counts from 0 to 520
      if vcounter = 521 then		    
        vcounter <= 0;
      end if; -- vcounter
    end if; -- rising_edge( CLOCK_25MHz )
  end process vga;

  -- ***************************
  -- ***                     ***
  -- ***  AGC INPUT MAPPING. ***
  -- ***                     ***
  -- ***************************

  INPUTS.\NHVFAL\  <= '0';
  -- INPUTS.\MAINRS\  <= '0';
  INPUTS.\SBYBUT\  <= '0';
  INPUTS.\IN3212\  <= '0';
  INPUTS.\CAURST\  <= '0';
  INPUTS.\IN3213\  <= '0';
  INPUTS.\NKEY1\   <= '0';
  -- INPUTS.\IN3214\  <= ROT_CENTER; -- PRO KEY
  INPUTS.\NKEY2\   <= '0';
  -- INPUTS.\MKEY1\   <= '0';
  INPUTS.\NKEY3\   <= '0';
  -- INPUTS.\MKEY2\   <= '0';
  INPUTS.\NKEY4\   <= '0';
  -- INPUTS.\MKEY3\   <= '0';
  INPUTS.\NKEY5\   <= '0';
  -- INPUTS.\MKEY4\   <= '0';
  INPUTS.\NAVRST\  <= '0';
  -- INPUTS.\MKEY5\   <= '0';
  INPUTS.\IN3216\  <= '0';
  INPUTS.\GATEX/\  <= '0';
  INPUTS.\GATEY/\  <= '0';
  INPUTS.\GATEZ/\  <= '0';
  INPUTS.\SIGNX\   <= '0';
  INPUTS.\SIGNY\   <= '0';
  INPUTS.\SIGNZ\   <= '0';
  INPUTS.\BMGXP\   <= '0';
  INPUTS.\CDUXM\   <= '0';
  INPUTS.\DKSTRT\  <= '0';
  INPUTS.\BMGXM\   <= '0';
  INPUTS.\CDUYP\   <= '0';
  INPUTS.\DKEND\   <= '0';
  INPUTS.\BMGYP\   <= '0';
  INPUTS.\CDUYM\   <= '0';
  INPUTS.\DKBSNC\  <= '0';
  INPUTS.\BMGYM\   <= '0';
  INPUTS.\CDUZP\   <= '0';
  INPUTS.\UPL0\    <= '0';
  INPUTS.\BMGZP\   <= '0';
  INPUTS.\CDUZM\   <= '0';
  INPUTS.\UPL1\    <= '0';
  INPUTS.\BMGZM\   <= '0';
  INPUTS.\PIPAX+\  <= '0';
  INPUTS.\RRIN0\   <= '0';
  INPUTS.\SHAFTP\  <= '0';
  INPUTS.\PIPAX-\  <= '0';
  INPUTS.\RRIN1\   <= '0';
  INPUTS.\SHAFTM\  <= '0';
  INPUTS.\PIPAY+\  <= '0';
  INPUTS.\LRIN0\   <= '0';
  INPUTS.\TRNP\    <= '0';
  INPUTS.\PIPAY-\  <= '0';
  INPUTS.\LRIN1\   <= '0';
  INPUTS.\TRNM\    <= '0';
  INPUTS.\PIPAZ+\  <= '0';
  INPUTS.\XLNK0\   <= '0';
  INPUTS.\CDUXP\   <= '0';
  INPUTS.\PIPAZ-\  <= '0';
  INPUTS.\XLNK1\   <= '0';
  INPUTS.\ULLTHR\  <= '0';
  INPUTS.\MNIM+Y\  <= '0';
  INPUTS.\RRPONA\  <= '0';
  INPUTS.\LFTOFF\  <= '0';
  INPUTS.\MNIM-Y\  <= '0';
  INPUTS.\RRRLSC\  <= '0';
  INPUTS.\GUIREL\  <= '0';
  INPUTS.\MNIM+R\  <= '0';
  INPUTS.\MANR+P\  <= '0';
  INPUTS.\TRAN+X\  <= '0';
  INPUTS.\MNIM-R\  <= '0';
  INPUTS.\MANR-P\  <= '0';
  INPUTS.\TRAN-X\  <= '0';
  INPUTS.\TRST9\   <= '0';
  INPUTS.\MANR+Y\  <= '0';
  INPUTS.\TRAN+Y\  <= '0';
  INPUTS.\TRST10\  <= '0';
  INPUTS.\MANR-Y\  <= '0';
  INPUTS.\TRAN-Y\  <= '0';
  INPUTS.\HOLFUN\  <= '0';
  INPUTS.\MANR+R\  <= '0';
  INPUTS.\TRAN+Z\  <= '0';
  INPUTS.\FREFUN\  <= '0';
  INPUTS.\MANR-R\  <= '0';
  INPUTS.\TRAN-Z\  <= '0';
  INPUTS.\S4BSAB\  <= '0';
  INPUTS.\ISSTOR\  <= '0';
  INPUTS.\OPCDFL\  <= '0';
  INPUTS.\SMSEPR\  <= '0';
  INPUTS.\OPCDEL\  <= '0';
  INPUTS.\MRKRST\  <= '0';
  INPUTS.\IN3008\  <= '0';
  INPUTS.\CDUFAL\  <= '0';
  INPUTS.\ZEROP\   <= '0';
  INPUTS.\BLKUPL/\ <= '0';
  INPUTS.\TEMPIN\  <= '1'; -- A logical '0' means 'too hot' or 'too cold'. A logical '1' means just right!
  INPUTS.\MARK\    <= '0';
  INPUTS.\SPSRDY\  <= '0';
  INPUTS.\IMUFAL\  <= '0';
  INPUTS.\OPMSW3\  <= '0';
  INPUTS.\GCAPCL\  <= '0';
  INPUTS.\LEMATT\  <= '0';
  INPUTS.\MRKREJ\  <= '0';
  INPUTS.\ROLGOF\  <= '0';
  INPUTS.\IMUOPR\  <= '0';
  INPUTS.\STRPRS\  <= '0';
  INPUTS.\PCHGOF\  <= '0';
  INPUTS.\IMUCAG\  <= '0';
  INPUTS.\MNIM+P\  <= '0';
  INPUTS.\LVDAGD\  <= '0';
  INPUTS.\IN3301\  <= '0';
  INPUTS.\MNIM-P\  <= '0';
  INPUTS.\LRRLSC\  <= '0';
  INPUTS.\CTLSAT\  <= '0';
  INPUTS.\2FSFAL\  <= '1'; -- DER FRIG to stop MSCDBL/ problem from raising SYSERROR.
  INPUTS.\FLTOUT\  <= '0';
  INPUTS.\OPMSW2\  <= '0';
  INPUTS.\SCAFAL\  <= '0';
  INPUTS.\STRT2\   <= T_STRT2;
  INPUTS.\VFAIL\   <= '0';

  -- ********************************
  -- ***                          ***
  -- ***  INSTANTIATE AGC LOGIC.  ***
  -- ***                          ***
  -- ********************************

  TOP : AGC_LOGIC port map(
          SYSCLOCK => CLOCK_50MHz,
          SYSRESET => T_SYSRESET,
          SYSERROR => T_SYSERROR,
          \CLOCK\  => agc_clock,
          ECADR    => ECADR,
          FCADR    => FCADR,
          SAXX     => SAXX,
          GEMXX    => GEMXX,
          EWRITE   => EWRITE,
          EREAD    => EREAD,
          ESTART   => ESTART,
          FREAD    => FREAD,
          INPUTS   => INPUTS,
          OUTPUTS  => OUTPUTS,
          VGADEBUG => gdebug
        );

  -- *********************************
  -- ***                           ***
  -- ***  INSTANTIATE AGC MEMORY.  ***
  -- ***                           ***
  -- *********************************

  MEM : AGC_MEMORY port map(
          ECADR    => ECADR,         -- Erasable address.
          SAXX     => SAXX,          -- Sense Amplifiers (data to AGC).
          GEMXX    => GEMXX,         -- 'G' register data from AGC.
          EREAD    => EREAD,         -- Erasable Read  signal.
          EWRITE   => EWRITE,        -- Erasable Write signal.
          ESTART   => ESTART,        -- Erasable cycle start signal.
          FCADR    => FCADR,         -- Fixed address.
          FREAD    => FREAD,         -- Fixed read signal.
          SF_A     => SF_A,          -- Strata Flash Address.
          SF_D     => SF_D,          -- Strata Flash Data.
          SF_BYTE  => SF_BYTE,       -- Strata Flash Byte Select.
          SF_CE    => SF_CE0,        -- Strata Flash Chip Enable.
          SF_OE    => SF_OE,         -- Strata Flash Output Enable.
          SF_WE    => SF_WE,         -- Strata Flash Write Enable.
          SW0      => not SW(0),     -- Fixed Core Rope Select (least significant bit).
          SW1      => not SW(1),     -- Fixed Core Rope Select (most significant bit).
          SYSCLOCK => CLOCK_2048kHz, -- AGC system clock (not single stepped or slow though).
          SYSRESET => T_SYSRESET     -- AGC system reset.
        );

  -- ***********************
  -- ***                 ***
  -- ***  DSKY OUTPUTS.  ***
  -- ***                 ***
  -- ***********************

  FX2_IO9  <= OUTPUTS.\UPLACT\; -- UPLink ACtive lamp              (CH #11 BIT 03).
  FX2_IO10 <= OUTPUTS.\KYRLS\;  -- KeY ReLeaSe lamp                (CH #11 BIT 05).
  FX2_IO11 <= OUTPUTS.\TMPCAU\; -- TeMP CAUtion lamp               (from hardwired logic).
  FX2_IO12 <= OUTPUTS.\VNFLSH\; -- Verb/Noun FLaSH                 (CH #11 BIT 06).

  FX2_IO13 <= OUTPUTS.\OPEROR\; -- LED 7 -- OP ERrOR lamp          (CH #11 BIT 07).
  FX2_IO14 <= OUTPUTS.\COMACT\; -- LED 6 -- COMputer ACTivity lamp (CH #11 BIT 02).
  FX2_IO15 <= OUTPUTS.\SBYLIT\; -- LED 5 -- Standby lamp           (from hardwired logic).
  FX2_IO16 <= OUTPUTS.\RESTRT\; -- LED 4 -- Restart lamp           (from hardwired logic).

  FX2_IO17 <= T_SYSERROR;       -- LED 3 -- AGC Diagnostic LEDS.
  FX2_IO18 <= T_STRT2;          -- LED 2 -- AGC Diagnostic LEDS.
  FX2_IO19 <= T_SYSRESET;       -- LED 1 -- AGC Diagnostic LEDS.
  FX2_IO20 <= OneHertzFlasher;  -- LED 0 -- AGC Diagnostic LEDS.

  FX2_IO21   <= OUTPUTS.\RLYB01\; -- CH #10 BIT 01
  FX2_IO22   <= OUTPUTS.\RLYB02\; -- CH #10 BIT 02
  FX2_IO23   <= OUTPUTS.\RLYB03\; -- CH #10 BIT 03
  FX2_IO24   <= OUTPUTS.\RLYB04\; -- CH #10 BIT 04
  FX2_IO25   <= OUTPUTS.\RLYB05\; -- CH #10 BIT 05
  FX2_IO26   <= OUTPUTS.\RLYB06\; -- CH #10 BIT 06
  FX2_IO27   <= OUTPUTS.\RLYB07\; -- CH #10 BIT 07
  FX2_IO28   <= OUTPUTS.\RLYB08\; -- CH #10 BIT 08
  FX2_IO29   <= OUTPUTS.\RLYB09\; -- CH #10 BIT 09
  FX2_IO30   <= OUTPUTS.\RLYB10\; -- CH #10 BIT 10
  FX2_IO31   <= OUTPUTS.\RLYB11\; -- CH #10 BIT 11
  FX2_IO33   <= OUTPUTS.\RYWD12\; -- CH #10 BIT 12
  FX2_IO34   <= OUTPUTS.\RYWD13\; -- CH #10 BIT 13
  FX2_IO39   <= OUTPUTS.\RYWD14\; -- CH #10 BIT 14
  FX2_CLKOUT <= OUTPUTS.\RYWD16\; -- CH #10 BIT 16

  -- ********************************
  -- ***                          ***
  -- ***  DSKY debug simulation.  ***
  -- ***                          ***
  -- ********************************
  
  dsky_display: process( CLOCK_50MHz, T_SYSRESET )
  
    variable RYWDnn : integer range 0 to 15;
    variable RLYBnn : std_logic_vector( 11 downto 1 );
    
  begin
  
    if T_SYSRESET = '1' then
    
      for i in 0 to 15 loop
      
        DSKY_DEBUG( i ) <= "00000000000";
        
      end loop; -- i
      
    elsif rising_edge( CLOCK_50MHz ) then
    
      RYWDnn := conv_integer( OUTPUTS.\RYWD16\ & OUTPUTS.\RYWD14\ & OUTPUTS.\RYWD13\ & OUTPUTS.\RYWD12\ );
      
      RLYBnn := OUTPUTS.\RLYB11\ & OUTPUTS.\RLYB10\ & OUTPUTS.\RLYB09\ & OUTPUTS.\RLYB08\ &
                OUTPUTS.\RLYB07\ & OUTPUTS.\RLYB06\ & OUTPUTS.\RLYB05\ & OUTPUTS.\RLYB04\ &
                OUTPUTS.\RLYB03\ & OUTPUTS.\RLYB02\ & OUTPUTS.\RLYB01\ ;

      if RYWDnn > 0 and RYWDnn <= 12 then

        DSKY_DEBUG( RYWDnn ) <= RLYBnn;
        
      end if; -- RYWDnn

      -- CH11 DEBUG
      DSKY_DEBUG( 13 ) <= '0'              & -- CH #11 BIT 11
                          '0'              & -- CH #11 BIT 10
                          '0'              & -- CH #11 BIT 09
                          OUTPUTS.\OT1108\ & -- CH #11 BIT 08
                          OUTPUTS.\OPEROR\ & -- CH #11 BIT 07
                          OUTPUTS.\VNFLSH\ & -- CH #11 BIT 06
                          OUTPUTS.\KYRLS\  & -- CH #11 BIT 05
                          '0'              & -- CH #11 BIT 04
                          OUTPUTS.\UPLACT\ & -- CH #11 BIT 03
                          OUTPUTS.\COMACT\ & -- CH #11 BIT 02
                          OUTPUTS.\ISSWAR\ ; -- CH #11 BIT 01

    end if; -- T_SYSRESET, CLOCK_50MHz
    
  end process dsky_display;

  dsky_keyboard: process( CLOCK_50MHz, T_SYSRESET )

  begin
  
    if T_SYSRESET = '1' then
    
      desired_key_index <= CHAR_P; -- Default on reset is PRO key.
      
    elsif rising_edge( CLOCK_50MHz ) then

      if single_step_clock = '0' then
      
        if rotary_event = '1' then
      
          if rotary_left = '1' then
      
            if desired_key_index > keyboard'left then
        
              desired_key_index <= desired_key_index - 1;
          
            else
        
              desired_key_index <= keyboard'right;
            
            end if;
          
          else
        
            if desired_key_index < keyboard'right then
          
              desired_key_index <= desired_key_index + 1;
            
            else
          
              desired_key_index <= keyboard'left;
            
            end if;
      
          end if; -- rotary_left
        
        end if; -- rotary_event
        
        if ROT_CENTER = '1' then
        
          poke <= keyboard( desired_key_index );
          
        else
        
          poke <= VK_NONE;
          
        end if; -- ROT_CENTER
        
      end if; -- single_step_clock
      
    end if; -- T_SYSRESET, CLOCK_50MHz

  end process dsky_keyboard;

  -- **********************
  -- ***                ***
  -- ***  DSKY INPUTS.  ***
  -- ***                ***
  -- **********************

  INPUTS.\MKEY1\  <= FX2_IO1 when FX2_IO8 = '1' else poke(1); -- DSKY KEYBOARD lsb.
  INPUTS.\MKEY2\  <= FX2_IO2 when FX2_IO8 = '1' else poke(2);
  INPUTS.\MKEY3\  <= FX2_IO3 when FX2_IO8 = '1' else poke(3);
  INPUTS.\MKEY4\  <= FX2_IO4 when FX2_IO8 = '1' else poke(4);
  INPUTS.\MKEY5\  <= FX2_IO5 when FX2_IO8 = '1' else poke(5); -- DSKY KEYBOARD msb.
  INPUTS.\IN3214\ <= FX2_IO6 when FX2_IO8 = '1' else poke(6); -- PRO KEY

  -- INPUTS.\MAINRS\ is assigned after the debounce code below.

  raw_mainrs <= not( FX2_IO1 or FX2_IO2 or FX2_IO3 or FX2_IO4 or FX2_IO5 ); -- Raw MAINRS derived from an external DSKY keypad.
                                                                            -- '1' = no keypress.
                                                                            -- '0' = keypress.

  -- **********************************************************
  -- ***                                                    ***
  -- ***  Debounce any externally-connected DSKY KEYBOARD.  ***
  -- ***                                                    ***
  -- **********************************************************

  debounce_mainrs: process( CLOCK_2048kHz, T_SYSRESET, raw_mainrs )
  
    constant CNT_MIN : integer :=     0;
    constant CNT_MAX : integer := 65535; -- Approximately 32 milliseconds of debounce.

    variable cnt : integer range CNT_MIN to CNT_MAX;
    
  begin
  
    if T_SYSRESET = '1' then

      cnt := CNT_MIN;

      debounced_mainrs <= '1'; -- No keypress assumed.

    elsif rising_edge( CLOCK_2048kHz ) then

      if raw_mainrs = '1' then

        cnt := CNT_MIN;

        debounced_mainrs <= '1'; -- No keypress assumed.

      else -- A key must have been pressed.

        if cnt = CNT_MAX then

          debounced_mainrs <= '0'; -- Got a keypress after the debouncing period.

        else

          cnt := cnt + 1; -- Keep counting...

        end if; -- cnt = CNT_MAX

      end if; -- raw_mainrs = '1'

    end if; -- T_SYSRESET, CLOCK_2048kHz

  end process debounce_mainrs;

  -- *******************************
  -- ***                         ***
  -- ***  Assignment of MAINRS.  ***
  -- ***                         ***
  -- *******************************

  INPUTS.\MAINRS\ <= debounced_mainrs when FX2_IO8 = '1' 
                     else '1' when poke(5 downto 1) = "00000" else '0';

  -- ***********************
  -- ***                 ***
  -- ***  END OF LOGIC.  ***
  -- ***                 ***
  -- ***********************

end Rtl;

-- **********************
-- ***                ***
-- ***  END OF FILE.  ***
-- ***                ***
-- **********************
