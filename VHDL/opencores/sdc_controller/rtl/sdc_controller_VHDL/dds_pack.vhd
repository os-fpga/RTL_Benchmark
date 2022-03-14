--------------------------------------------------------------------------
-- Package of Direct Digital Synthesizer (DDS) components
--
-- NOTE: These components are for producing digital pulse outputs at
--       desired frequencies and/or duty cycles.  In other words, there
--       are no modules here which include sinewave lookup tables.  For
--       that type of module, please refer to "dds_sine_pack.vhd"
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package dds_pack is

  component dds_constant_squarewave
    generic (
      OUTPUT_FREQ  : real;   -- Desired output frequency
      SYS_CLK_RATE : real;   -- underlying clock rate
      ACC_BITS     : integer -- Bit width of DDS phase accumulator
    );
    port (

      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Output
      pulse_o      : out std_logic;
      squarewave_o : out std_logic
    );
  end component;

  component dds_squarewave
    generic (
      ACC_BITS     : integer -- Bit width of DDS phase accumulator
    );
    port ( 
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Frequency setting
      freq_i       : in  unsigned(ACC_BITS-1 downto 0);

      -- Output
      pulse_o      : out std_logic;
      squarewave_o : out std_logic
    );
  end component;

  component dds_squarewave_phase_load
    generic (
      ACC_BITS     : integer -- Bit width of DDS phase accumulator
    );
    port ( 
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Frequency setting
      freq_i       : in  unsigned(ACC_BITS-1 downto 0);

      -- Synchronous load
      phase_i      : in  unsigned(ACC_BITS-1 downto 0);
      phase_ld_i   : in  std_logic;

      -- Output
      pulse_o      : out std_logic;
      squarewave_o : out std_logic
    );
  end component;

  component dds_constant_clk_en_gen
    generic (
      OUTPUT_FREQ  : real;   -- Desired output frequency
      SYS_CLK_RATE : real;   -- underlying clock rate
      ACC_BITS     : integer -- Bit width of DDS phase accumulator
    );
    port ( 
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Output
      clk_en_o     : out std_logic
    );
  end component;

  component dds_clk_en_gen
    generic (
      ACC_BITS     : integer -- Bit width of DDS phase accumulator
    );
    port ( 
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Frequency setting
      freq_i       : in  unsigned(ACC_BITS-1 downto 0);

      -- Output
      clk_en_o     : out std_logic
    );
  end component;

  component calibrated_clk_en_gen
    generic (
      SYS_CLK_RATE : real  -- underlying clock rate
    );
    port ( 
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Frequency setting
      freq_i       : in  unsigned(31 downto 0); -- some MSBs may be ignored

      -- Output
      clk_en_o     : out std_logic
    );
  end component;

  component dds_pwm_dac
    generic (
      ACC_BITS     : integer -- Bit width of DDS phase accumulator
    );
    port ( 
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Frequency setting
      freq_i       : in  unsigned(ACC_BITS-1 downto 0);

      -- Output
      clk_en_o     : out std_logic
    );
  end component;

  component dds_pwm_dac_srv
    generic (
      ACC_BITS     : integer -- Bit width of DDS phase accumulator
    );
    port ( 
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Frequency/Phase settings
      phase_load_i : in  std_logic;
      phase_val_i  : in  unsigned(ACC_BITS-1 downto 0);
      freq_i       : in  unsigned(ACC_BITS-1 downto 0);

      -- Output
      clk_en_o     : out std_logic
    );
  end component;

end dds_pack;

package body dds_pack is
end dds_pack;

-------------------------------------------------------------------------------
-- Direct Digital Synthesizer Constant Squarewave module
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update: Sep.  5, 2002 copied this file from "auto_baud_pack.vhd"
--                       Added tracking functions, and debugged them.
--
-- Description
-------------------------------------------------------------------------------
-- This is a simple direct digital synthesizer module.  It includes a phase
-- accumulator which increments in order to produce the desired output
-- frequency in its most significant bit, which is the squarewave output.
--
-- In addition to the squarewave output there is a pulse output which is
-- high for one sys_clk period, during the sys_clk period immediately
-- preceding the rising edge of the squarewave output.
--
-- NOTES:
--   The accumulator increment word is:
--        increment = Fout*2^N/Fsys_clk
--
--   Where N is the number of bits in the phase accumulator.
--
--   There will always be jitter with this type of clock source, but the
--   long time average frequency can be made arbitrarily close to whatever
--   value is desired, simply by increasing N.
--
--   To reduce jitter, use a higher underlying system clock frequency, and
--   for goodness sakes, try to keep the desired output frequency much lower
--   than the system clock frequency.  The closer it gets to Fsys_clk/2, the
--   closer it is to the Nyquist limit, and the output jitter is much more
--   significant at that point.
--
--


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

  entity dds_constant_squarewave is
    generic (
      OUTPUT_FREQ  : real := 8000.0;     -- Desired output frequency
      SYS_CLK_RATE : real := 48000000.0; -- underlying clock rate
      ACC_BITS     : integer := 16       -- Bit width of DDS phase accumulator
    );
    port ( 
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Output
      pulse_o      : out std_logic;
      squarewave_o : out std_logic
    );
  end dds_constant_squarewave;

architecture beh of dds_constant_squarewave is

-- Constants
constant DDS_INCREMENT : integer := integer(OUTPUT_FREQ*(2**real(ACC_BITS))/SYS_CLK_RATE);

-- Signals
signal dds_phase      : unsigned(ACC_BITS-1 downto 0); -- phase accumulator register
signal dds_phase_next : unsigned(ACC_BITS-1 downto 0);

-----------------------------------------------------------------------------
begin

  dds_proc: Process(sys_rst_n,sys_clk)
  begin
    if (sys_rst_n = '0') then
      dds_phase <= (others=>'0');
    elsif (sys_clk'event and sys_clk='1') then
      if (sys_clk_en='1') then
        dds_phase <= dds_phase_next;
      end if;
    end if; -- sys_clk
  end process dds_proc;
  dds_phase_next <= dds_phase + DDS_INCREMENT;
  pulse_o <= '1' when sys_clk_en='1' and dds_phase(dds_phase'length-1)='0' and dds_phase_next(dds_phase_next'length-1)='1' else '0';
  squarewave_o <= dds_phase(dds_phase'length-1);

end beh;


-------------------------------------------------------------------------------
-- Direct Digital Synthesizer Variable Frequency Squarewave module
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update: Jan. 31, 2013 copied code from dds_constant_squarewave, and
--                       modified it to accept a frequency setting input.
--
-- Description
-------------------------------------------------------------------------------
-- This is a simple direct digital synthesizer module.  It includes a phase
-- accumulator which increments in order to produce the desired output
-- frequency in its most significant bit, which is the squarewave output.
--
-- In addition to the squarewave output there is a pulse output which is
-- high for one sys_clk period, during the sys_clk period immediately
-- preceding the rising edge of the squarewave output.
--
-- NOTES:
--   The accumulator increment word is:
--        increment = Fout*2^N/Fsys_clk
--
--   Where N is the number of bits in the phase accumulator.
--
--   There will always be jitter with this type of clock source, but the
--   long time average frequency can be made arbitrarily close to whatever
--   value is desired, simply by increasing N.
--
--   To reduce jitter, use a higher underlying system clock frequency, and
--   for goodness sakes, try to keep the desired output frequency much lower
--   than the system clock frequency.  The closer it gets to Fsys_clk/2, the
--   closer it is to the Nyquist limit, and the output jitter is much more
--   significant as compared to the output period at that point.
--
--


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

  entity dds_squarewave is
    generic (
      ACC_BITS     : integer := 16       -- Bit width of DDS phase accumulator
    );
    port ( 
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Frequency setting
      freq_i       : in  unsigned(ACC_BITS-1 downto 0);

      -- Output
      pulse_o      : out std_logic;
      squarewave_o : out std_logic
    );
  end dds_squarewave;

architecture beh of dds_squarewave is

-- Signals
signal dds_phase      : unsigned(ACC_BITS-1 downto 0); -- phase accumulator register
signal dds_phase_next : unsigned(ACC_BITS-1 downto 0);

-----------------------------------------------------------------------------
begin

  dds_proc: Process(sys_rst_n,sys_clk)
  begin
    if (sys_rst_n = '0') then
      dds_phase <= (others=>'0');
    elsif (sys_clk'event and sys_clk='1') then
      if (sys_clk_en='1') then
        dds_phase <= dds_phase_next;
      end if;
    end if; -- sys_clk
  end process dds_proc;
  dds_phase_next <= dds_phase + freq_i;
  pulse_o <= '1' when sys_clk_en='1' and dds_phase(dds_phase'length-1)='0' and dds_phase_next(dds_phase_next'length-1)='1' else '0';
  squarewave_o <= dds_phase(dds_phase'length-1);

end beh;


-------------------------------------------------------------------------------
-- Direct Digital Synthesizer Variable Frequency Squarewave module,
--   with synchronous phase load
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update: Aug.  1, 2013 copied code from dds_squarewave, and
--                       modified it to accept a synchronous load input.
--
-- Description
-------------------------------------------------------------------------------
-- This is a simple direct digital synthesizer module.  It includes a phase
-- accumulator which increments in order to produce the desired output
-- frequency in its most significant bit, which is the squarewave output.
--
-- In addition to the squarewave output there is a pulse output which is
-- high for one sys_clk period, during the sys_clk period immediately
-- preceding the rising edge of the squarewave output.
--
-- A synchronous load input allows the synthesizer to be adjusted to any
-- desired initial phase condition.  This is useful when using it for
-- timing and synchronization.
--
-- NOTES:
--   The accumulator increment word is:
--        increment = Fout*2^N/Fsys_clk
--
--   Where N is the number of bits in the phase accumulator.
--
--   There will always be jitter with this type of clock source, but the
--   long time average frequency can be made arbitrarily close to whatever
--   value is desired, simply by increasing N.
--
--   To reduce jitter, use a higher underlying system clock frequency, and
--   for goodness sakes, try to keep the desired output frequency much lower
--   than the system clock frequency.  The closer it gets to Fsys_clk/2, the
--   closer it is to the Nyquist limit, and the output jitter is much more
--   significant as compared to the output period at that point.
--
--


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

  entity dds_squarewave_phase_load is
    generic (
      ACC_BITS     : integer := 16       -- Bit width of DDS phase accumulator
    );
    port ( 
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Frequency setting
      freq_i       : in  unsigned(ACC_BITS-1 downto 0);

      -- Synchronous load
      phase_i      : in  unsigned(ACC_BITS-1 downto 0);
      phase_ld_i   : in  std_logic;

      -- Output
      pulse_o      : out std_logic;
      squarewave_o : out std_logic
    );
  end dds_squarewave_phase_load;

architecture beh of dds_squarewave_phase_load is

-- Signals
signal dds_phase      : unsigned(ACC_BITS-1 downto 0); -- phase accumulator register
signal dds_phase_next : unsigned(ACC_BITS-1 downto 0);

-----------------------------------------------------------------------------
begin

  dds_proc: Process(sys_rst_n,sys_clk)
  begin
    if (sys_rst_n = '0') then
      dds_phase <= (others=>'0');
    elsif (sys_clk'event and sys_clk='1') then
      if (sys_clk_en='1') then
        dds_phase <= dds_phase_next;
      end if;
      if (phase_ld_i='1') then
        dds_phase <= phase_i;
      end if;
    end if; -- sys_clk
  end process dds_proc;
  dds_phase_next <= dds_phase + freq_i;
  pulse_o <= '1' when sys_clk_en='1' and dds_phase(dds_phase'length-1)='0' and dds_phase_next(dds_phase_next'length-1)='1' else '0';
  squarewave_o <= dds_phase(dds_phase'length-1);

end beh;


-------------------------------------------------------------------------------
-- Direct Digital Synthesizer Clock Enable Generator, Constant output frequency
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update: Oct.  4, 2013 Copied code from dds_clk_en_gen, and modified it to
--                       create a clock enable output using generics to set
--                       the frequency.
--
-- Description
-------------------------------------------------------------------------------
-- This is a simple direct digital synthesizer module.  It includes a phase
-- accumulator which increments in order to produce the desired output
-- frequency in its most significant bit, which is a squarewave with
-- some unavoidable jitter.
--
-- In this module, the squarewave is not provided as an output, because
-- this module's purpose is to generate a clock enable signal.
--
-- The clock enable output is a pulsed output which, for frequencies below
-- the Nyquist frequency is high for one sys_clk period, during the sys_clk
-- period immediately preceding the rising edge of the squarewave output.
--
-- A special "trick" is performed inside this module, which is to invert the
-- pulse output for frequencies above the Nyquist frequency.  Since the pulse
-- train is a perfect 50% duty cycle squarewave at the Nyquist frequency, the
-- pulse train and its inverse are equivalent at that point...  But for
-- higher frequencies, the squarewave reduces in frequency back down towards
-- zero Hz.  However, since the pulse train is inverted for frequencies above
-- the Nyquist frequency (Fsys_clk/2), then the output pulse train is high for
-- a larger and larger fraction of time... essentially forming a nice clock
-- enable which can be varied from 0% duty cycle, all the way up to N% duty
-- cycle, where K is given by:
--
--   K = max_duty_cycle = 100 * (1-2**(-N)) percent
--
--   Where N is the number of bits in the phase accumulator (ACC_BITS)
--
--
-- NOTES:
--   The accumulator increment word is set by generics:
--        increment = OUTPUT_FREQ*2^ACC_BITS/SYS_CLK_RATE
--
--   Where N is the number of bits in the phase accumulator (ACC_BITS)
--
--   There will always be jitter with this type of clock source, but the
--   clock enable output duty cycle can be adjusted in increments as fine
--   as may be desired, simply by increasing N.
--
--


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

  entity dds_constant_clk_en_gen is
    generic (
      OUTPUT_FREQ  : real := 32000000.0;   -- Desired output frequency
      SYS_CLK_RATE : real := 50000000.0;   -- underlying clock rate
      ACC_BITS     : integer := 30 -- Bit width of DDS phase accumulator
    );
    port ( 
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Output
      clk_en_o     : out std_logic
    );
  end dds_constant_clk_en_gen;

architecture beh of dds_constant_clk_en_gen is

-- Constants
constant DDS_INCREMENT : integer := integer(OUTPUT_FREQ*(2**real(ACC_BITS))/SYS_CLK_RATE);
constant HALFWAY       : integer := integer(2**real(ACC_BITS-1));

-- Signals
signal dds_phase      : unsigned(ACC_BITS-1 downto 0); -- phase accumulator register
signal dds_phase_next : unsigned(ACC_BITS-1 downto 0);
signal pulse_l        : std_logic;

-----------------------------------------------------------------------------
begin

  dds_proc: Process(sys_rst_n,sys_clk)
  begin
    if (sys_rst_n = '0') then
      dds_phase <= (others=>'0');
    elsif (sys_clk'event and sys_clk='1') then
      if (sys_clk_en='1') then
        dds_phase <= dds_phase_next;
      end if;
    end if; -- sys_clk
  end process dds_proc;
  dds_phase_next <= dds_phase + DDS_INCREMENT;
  pulse_l <= '1' when sys_clk_en='1' and dds_phase(dds_phase'length-1)='0' and dds_phase_next(dds_phase_next'length-1)='1' else '0';
  clk_en_o <= pulse_l when (DDS_INCREMENT<HALFWAY) else not pulse_l;

end beh;


-------------------------------------------------------------------------------
-- Direct Digital Synthesizer Clock Enable Generator
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update: Oct.  4, 2013 Copied code from dds_squarewave, and modified it to
--                       create a clock enable output which essentially has
--                       a duty cycle that varies from zero up to 100%.  This
--                       is similar in some ways to a first order sigma-delta
--                       modulator, my friend!  It can be used as a DAC, if
--                       the sys_clk_en is high.  See dds_pwm_dac for a
--                       similar unit that allows slowing down the output
--                       waveform according to the period between sys_clk_en
--                       pulses.
--
-- Description
-------------------------------------------------------------------------------
-- This is a simple direct digital synthesizer module.  It includes a phase
-- accumulator which increments in order to produce the desired output
-- frequency in its most significant bit, which is a squarewave with
-- some unavoidable jitter.
--
-- In this module, the squarewave is not provided as an output, because
-- this module's purpose is to generate a clock enable signal.
--
-- The clock enable output is a pulsed output which, for frequencies below
-- the Nyquist frequency is high for one sys_clk period, during the sys_clk
-- period immediately preceding the rising edge of the squarewave output.
--
-- A special "trick" is performed inside this module, which is to invert the
-- pulse output for frequencies above the Nyquist frequency.  Since the pulse
-- train is a perfect 50% duty cycle squarewave at the Nyquist frequency, the
-- pulse train and its inverse are equivalent at that point...  But for
-- higher frequencies, the squarewave reduces in frequency back down towards
-- zero Hz.  However, since the pulse train is inverted for frequencies above
-- the Nyquist frequency (Fsys_clk/2), then the output pulse train is high for
-- a larger and larger fraction of time... essentially forming a nice clock
-- enable which can be varied from 0% duty cycle, all the way up to N% duty
-- cycle, where K is given by:
--
--   K = max_duty_cycle = 100 * (1-2**(-N)) percent
--
--   Where N is the number of bits in the phase accumulator (ACC_BITS)
--
-- This can perhaps operate as a form of PWM also... although the fundamental
-- frequency is not constant, as it is in true PWM.
--
--
-- NOTES:
--   The accumulator increment word is:
--        increment = Fout*2^N/Fsys_clk
--
--   Where N is the number of bits in the phase accumulator (ACC_BITS)
--
--   There will always be jitter with this type of clock source, but the
--   clock enable output duty cycle can be adjusted in increments as fine
--   as may be desired, simply by increasing N.
--
--


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

  entity dds_clk_en_gen is
    generic (
      ACC_BITS     : integer := 16       -- Bit width of DDS phase accumulator
    );
    port ( 
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Frequency setting
      freq_i       : in  unsigned(ACC_BITS-1 downto 0);

      -- Output
      clk_en_o     : out std_logic
    );
  end dds_clk_en_gen;

architecture beh of dds_clk_en_gen is

-- Signals
signal dds_phase      : unsigned(ACC_BITS-1 downto 0); -- phase accumulator register
signal dds_phase_next : unsigned(ACC_BITS-1 downto 0);
signal pulse_l        : std_logic;

-----------------------------------------------------------------------------
begin

  dds_proc: Process(sys_rst_n,sys_clk)
  begin
    if (sys_rst_n = '0') then
      dds_phase <= (others=>'0');
    elsif (sys_clk'event and sys_clk='1') then
      if (sys_clk_en='1') then
        dds_phase <= dds_phase_next;
      end if;
    end if; -- sys_clk
  end process dds_proc;
  dds_phase_next <= dds_phase + freq_i;
  pulse_l <= '1' when sys_clk_en='1' and dds_phase(dds_phase'length-1)='0' and dds_phase_next(dds_phase_next'length-1)='1' else '0';
  clk_en_o <= pulse_l when freq_i(freq_i'length-1)='0' else not pulse_l;

end beh;


-------------------------------------------------------------------------------
-- Calibrated Direct Digital Synthesizer Clock Enable Generator
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update: Nov. 11, 2013 Copied code from dds_clk_en_gen, and modified it.
--
-- Description
-------------------------------------------------------------------------------
-- This is two DDS units tied together.  The first unit produces a calibration
-- clock enable, at a frequency which is very close to a power of two Hz.
-- It uses the highest power of two which can be achieved using the given
-- system clock frequency.
--
-- The second DDS unit then uses the calibration clock enable for its
-- clock enable input.  This effectively "calibrates" the second unit
-- so that its input frequency is in Hz.
--
-- The input frequency to this module was fixed at 32 bits, but the
-- most significant bits may be ignored.
--


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

library work;
use work.dds_pack.all;
use work.convert_pack.all;

  entity calibrated_clk_en_gen is
    generic (
      SYS_CLK_RATE : real := 50000000.0 -- underlying clock rate
    );
    port ( 
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Frequency setting
      freq_i       : in  unsigned(31 downto 0);

      -- Output
      clk_en_o     : out std_logic
    );
  end calibrated_clk_en_gen;

architecture beh of calibrated_clk_en_gen is

-- Constants
constant LOG2_CAL_BITS : natural := bit_width(SYS_CLK_RATE)-1;

-- Signals
signal cal_clk_en      : std_logic;



-----------------------------------------------------------------------------
begin

  -- Calibration clock enable
  cal_clk_gen : dds_constant_clk_en_gen
    generic map(
      OUTPUT_FREQ  => real(2**LOG2_CAL_BITS),
      SYS_CLK_RATE => SYS_CLK_RATE,
      ACC_BITS     => 30
    )
    port map(
       
      sys_rst_n  => sys_rst_n,
      sys_clk    => sys_clk,
      sys_clk_en => sys_clk_en,

      -- Output
      clk_en_o     => cal_clk_en
    );

  clk_en_gen : dds_clk_en_gen
    generic map(
      ACC_BITS     => LOG2_CAL_BITS
    )
    port map(
       
      sys_rst_n  => sys_rst_n,
      sys_clk    => sys_clk,
      sys_clk_en => cal_clk_en,

      -- Frequency setting
      freq_i     => freq_i(LOG2_CAL_BITS-1 downto 0),

      -- Output
      clk_en_o   => clk_en_o
    );

end beh;


-------------------------------------------------------------------------------
-- Direct Digital Synthesizer PWM DAC
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update:
--         Jan. 23, 2015 Copied code from clk_en_gen, and brought pulse_l
--                       logic inside the sys_clk_en enabled process, so 
--                       that the pulses are widened according to sys_clk_en.
--
-- Description
-------------------------------------------------------------------------------
-- This is exactly the same as dds_clk_en_gen, except that it brings the pulse_l
-- logic inside the clocked process, so that output pulses are no longer 1
-- sys_clk wide, but are instead lengthened according to sys_clk_en.  This makes
-- the unit useful for generating a PWM output signal, with the smallest pulse
-- being the period between sys_clk_en pulses.
--
-- This is a simple direct digital synthesizer module.  It includes a phase
-- accumulator which increments in order to produce the desired output
-- frequency in its most significant bit, which is a squarewave with
-- some unavoidable jitter.
--
-- In this module, the squarewave is not provided as an output, because
-- this module's purpose is to generate a clock enable signal.
--
-- The clock enable output is a pulsed output which, for frequencies below
-- the Nyquist frequency is high for one sys_clk period, during the sys_clk
-- period immediately preceding the rising edge of the squarewave output.
--
-- A special "trick" is performed inside this module, which is to invert the
-- pulse output for frequencies above the Nyquist frequency.  Since the pulse
-- train is a perfect 50% duty cycle squarewave at the Nyquist frequency, the
-- pulse train and its inverse are equivalent at that point...  But for
-- higher frequencies, the squarewave reduces in frequency back down towards
-- zero Hz.  However, since the pulse train is inverted for frequencies above
-- the Nyquist frequency (Fsys_clk/2), then the output pulse train is high for
-- a larger and larger fraction of time... essentially forming a nice clock
-- enable which can be varied from 0% duty cycle, all the way up to N% duty
-- cycle, where K is given by:
--
--   K = max_duty_cycle = 100 * (1-2**(-N)) percent
--
--   Where N is the number of bits in the phase accumulator (ACC_BITS)
--
-- This can perhaps operate as a form of PWM also... although the fundamental
-- frequency is not constant, as it is in true PWM.
--
--
-- NOTES:
--   The accumulator increment word is:
--        increment = Fout*2^N/Fsys_clk
--
--   Where N is the number of bits in the phase accumulator (ACC_BITS)
--
--   There will always be jitter with this type of clock source, but the
--   clock enable output duty cycle can be adjusted in increments as fine
--   as may be desired, simply by increasing N.
--
--


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

  entity dds_pwm_dac is
    generic (
      ACC_BITS     : integer := 16       -- Bit width of DDS phase accumulator
    );
    port (
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Frequency setting
      freq_i       : in  unsigned(ACC_BITS-1 downto 0);

      -- Output
      clk_en_o     : out std_logic
    );
  end dds_pwm_dac;

architecture beh of dds_pwm_dac is

-- Signals
signal dds_phase      : unsigned(ACC_BITS-1 downto 0); -- phase accumulator register
signal dds_phase_next : unsigned(ACC_BITS-1 downto 0);
signal pulse_l        : std_logic;

-----------------------------------------------------------------------------
begin

  dds_proc: Process(sys_rst_n,sys_clk)
  begin
    if (sys_rst_n = '0') then
      dds_phase <= (others=>'0');
      pulse_l <= '0';
    elsif (sys_clk'event and sys_clk='1') then
      if (sys_clk_en='1') then
        dds_phase <= dds_phase_next;
        if (dds_phase(dds_phase'length-1)='0' and dds_phase_next(dds_phase_next'length-1)='1') then
          pulse_l <= '1';
        else
          pulse_l <= '0';
        end if;
      end if;
    end if; -- sys_clk
  end process dds_proc;
  dds_phase_next <= dds_phase + freq_i;
  clk_en_o <= pulse_l when freq_i(freq_i'length-1)='0' else not pulse_l;

end beh;

-------------------------------------------------------------------------------
-- Direct Digital Synthesizer PWM DAC - Synchronously Resettable Version
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update:
--         Jan. 23, 2015 Copied code from dds_pwm_dac, and added synchronous
--                       phase load input and phase value inputs
--
-- Description
-------------------------------------------------------------------------------
-- This is exactly the same as dds_pwm_dac, except that a synchronous phase
-- load is provided.  This was needed when using the DAC to "throttle" pixel
-- counters driving a display.  By resetting the DAC's phase accumulator
-- during each retrace interval, visible "jitter" was reduced, and made
-- identical for each line of display pixels.
--
-- NOTES:
--   The accumulator increment word is:
--        increment = Fout*2^N/Fsys_clk
--
--   Where N is the number of bits in the phase accumulator (ACC_BITS)
--
--   There will always be jitter with this type of clock source, but the
--   clock enable output duty cycle can be adjusted in increments as fine
--   as may be desired, simply by increasing N.
--
--


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

  entity dds_pwm_dac_srv is
    generic (
      ACC_BITS     : integer := 16   -- Bit width of DDS phase accumulator
    );
    port (
       
      sys_rst_n    : in  std_logic;
      sys_clk      : in  std_logic;
      sys_clk_en   : in  std_logic;

      -- Frequency/Phase settings
      phase_load_i : in  std_logic;
      phase_val_i  : in  unsigned(ACC_BITS-1 downto 0);
      freq_i       : in  unsigned(ACC_BITS-1 downto 0);

      -- Output
      clk_en_o     : out std_logic
    );
  end dds_pwm_dac_srv;

architecture beh of dds_pwm_dac_srv is

-- Signals
signal dds_phase      : unsigned(ACC_BITS-1 downto 0); -- phase accumulator register
signal dds_phase_next : unsigned(ACC_BITS-1 downto 0);
signal pulse_l        : std_logic;

-----------------------------------------------------------------------------
begin

  dds_proc: Process(sys_rst_n,sys_clk)
  begin
    if (sys_rst_n = '0') then
      dds_phase <= (others=>'0');
      pulse_l <= '0';
    elsif (sys_clk'event and sys_clk='1') then
      if (sys_clk_en='1') then
        if (phase_load_i='1') then
          dds_phase <= phase_val_i;
          pulse_l <= '0';
        else
          dds_phase <= dds_phase_next;
          if (dds_phase(dds_phase'length-1)='0' and dds_phase_next(dds_phase_next'length-1)='1') then
            pulse_l <= '1';
          else
            pulse_l <= '0';
          end if;
        end if; -- phase_zero_i
      end if; -- sys_clk_en
    end if; -- sys_clk
  end process dds_proc;
  dds_phase_next <= dds_phase + freq_i;
  clk_en_o <= pulse_l when freq_i(freq_i'length-1)='0' else not pulse_l;

end beh;


