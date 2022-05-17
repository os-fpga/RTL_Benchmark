--------------------------------------------------------------------------
-- Package
--
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

package signal_conditioning_pack is

  component edge_detector
    generic(
      DETECT_RISING  : natural;
      DETECT_FALLING : natural
    );
    port (
      -- System Clock and Clock Enable
      sys_rst_n   : in  std_logic;
      sys_clk     : in  std_logic;
      sys_clk_en  : in  std_logic;

      -- Input Signal
      sig_i       : in  std_logic;

      -- Output pulse
      pulse_o     : out std_logic

    );
  end component;

  component leaky_integrator
    generic(
      LEAK_FACTOR_BITS : natural;
      LEAK_FACTOR      : natural;
      INTEGRATOR_BITS  : natural   -- Bits in the integrating accumulator
    );
    port (
      -- System Clock and Clock Enable
      sys_rst_n   : in  std_logic;
      sys_clk     : in  std_logic;
      sys_clk_en  : in  std_logic;

      -- Settings
      input       : in  signed(INTEGRATOR_BITS-1 downto 0);

      -- Integration Result
      integrator  : out signed(INTEGRATOR_BITS-1 downto 0)

    );
  end component;

  component leaky_integrator_with_digital_output
    generic(
      FACTOR_BITS     : natural;  -- Make this less than INTEGRATOR_BITS
      HYSTERESIS_BITS : natural;  -- Make this less than INTEGRATOR_BITS
      INTEGRATOR_BITS : natural   -- Bits in the integrating accumulator
    );
    port (
      -- System Clock and Clock Enable
      sys_rst_n   : in  std_logic;
      sys_clk     : in  std_logic;
      sys_clk_en  : in  std_logic;

      -- Settings
      input       : in  signed(INTEGRATOR_BITS-1 downto 0);
      leak_factor : in  signed(FACTOR_BITS-1 downto 0);
      hysteresis  : in  unsigned(HYSTERESIS_BITS-1 downto 0);

      -- Integration Result
      integrator  : out signed(INTEGRATOR_BITS-1 downto 0);

      -- Conditioned Digital Output Signal
      output      : out std_logic
    );
  end component;

  component multi_stage_leaky_integrator
    generic(
      STAGES           : natural;
      LEAK_FACTOR_BITS : natural;  -- Inversely related to LP corner frequency. (Min=1)
      HYSTERESIS_BITS  : natural;  -- Make this less than INTEGRATOR_BITS
      INTEGRATOR_BITS  : natural   -- Bits in each integrating accumulator
    );
    port (
      -- System Clock and Clock Enable
      sys_rst_n   : in  std_logic;
      sys_clk     : in  std_logic;
      sys_clk_en  : in  std_logic;

      -- Settings
      input       : in  signed(INTEGRATOR_BITS-1 downto 0);
      hysteresis  : in  unsigned(HYSTERESIS_BITS-1 downto 0);

      -- Final Stage Integration Result
      integrator  : out signed(INTEGRATOR_BITS-1 downto 0);

      -- Conditioned Digital Output Signal
      output      : out std_logic
    );
  end component;

  component integrating_pulse_stretcher
    generic(
      MIN_CLKS        : natural; -- pulses below this many clocks are ignored
      RETRIGGERABLE   : natural; -- 1=restart on new pulses.  0=decay to zero before restarting
      STRETCH_FACTOR  : natural; -- 0=don't stretch, 1=double, 2=triple
      INITIAL_OFFSET  : natural; -- Value initially loaded into integrator
      INTEGRATOR_BITS : natural  -- Bits in the integrating accumulator
    );
    port (
      -- System Clock and Clock Enable
      sys_rst_n   : in  std_logic;
      sys_clk     : in  std_logic;
      sys_clk_en  : in  std_logic;

      -- Input
      pulse_i     : in  std_logic;

      -- Output
      pulse_o     : out std_logic

    );
  end component;

end signal_conditioning_pack;

-------------------------------------------------------------------------------
-- Edge Detector
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Date  : Nov.  1, 2013 Started Coding, drawing from various other sources.
--                       Created description.  Simulated it and saw that it
--                       works.
--                 
--
-- Description
-------------------------------------------------------------------------------
-- This module is a super simple edge detector, which produces is high-going
-- pulse whenever there is an edge on the input.  The type of edge is
-- selectable via generic.
--
-- The sys_clk_en affects the operation by extending the length of the pulse
-- output beyond one single sys_clk cycle, as expected.
--
-- Detecting both rising and falling edges is allowed.  Detecting neither is
-- also allowed, but not recommended.
--
-- The sys_rst_n input is an asynchronous reset.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

library work;
use work.convert_pack.all;

  entity edge_detector is
    generic(
      DETECT_RISING  : natural := 1;
      DETECT_FALLING : natural := 0
    );
    port (
      -- System Clock and Clock Enable
      sys_rst_n   : in  std_logic;
      sys_clk     : in  std_logic;
      sys_clk_en  : in  std_logic;

      -- Input Signal
      sig_i       : in  std_logic;

      -- Output pulse
      pulse_o     : out std_logic

    );
  end edge_detector;

architecture beh of edge_detector is

  -- Constants

  -- Functions & associated types

  -- Signal Declarations
  signal sig_r1  : std_logic;
  signal pulse_r : std_logic;
  signal pulse_f : std_logic;
  signal pulse_b : std_logic;

begin

process (sys_clk, sys_rst_n)
begin
  if (sys_rst_n='0') then
    sig_r1 <= '0';
  elsif (sys_clk'event and sys_clk='1') then -- rising edge
    if (sys_clk_en='1') then
      sig_r1 <= sig_i;
    end if;
  end if;
end process;

-- The detection
pulse_r <= '1' when sig_i='1' and sig_r1='0' else '0';
pulse_f <= '1' when sig_i='0' and sig_r1='1' else '0';
pulse_b <= sig_i xor sig_r1;

-- The output
pulse_o <= pulse_b when DETECT_RISING/=0 and DETECT_FALLING/=0 else
           pulse_r when DETECT_RISING/=0 else
           pulse_f when DETECT_FALLING/=0 else
           '0'; -- Haha!  Don't go there!

end beh;

-------------------------------------------------------------------------------
-- Leaky Integrator
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Date  : Oct. 11, 2013 Started Coding, drawing from various other sources.
--                       Created description.  Simulated it and saw that it
--                       works.
--                 
--
-- Description
-------------------------------------------------------------------------------
-- This module is a pretty simple digital "leaky integrator" designed to low
-- pass noisy signals by integrating them.
--
--   The first order differential equation is of the form:
--
--     dx/dt = -leak_factor*x + input
--
-- The input is discretized in both time and amplitude.  A one bit digital
-- input can be mapped to the "input" signal by using a positive value for
-- '1' and a negative value for '0'  Alternately, a signed DSP type signal
-- can be used directly.
--
-- The "leak_factor" is a feedback term, so that "DC gain" is inversely
-- proportional to the leak_factor.
--
-- Due to the presence of the feedback term, the integration's DC value, or
-- constant term, gets "leaked" to zero over time.  This is nice because
-- the threshold centers around zero.
--
-- Hysteresis can be added so that the digital output transitions an amount
-- above or below zero, depending on the current value of the output.
--
-- Clear as mud?  Well, it's similar to a low-pass filter, and the hysteresis
-- also helps remove noise on the input signal.
--
-- The sys_rst_n input is an asynchronous reset.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

library work;
use work.convert_pack.all;

  entity leaky_integrator is
    generic(
      LEAK_FACTOR_BITS : natural := 10;
      LEAK_FACTOR      : natural := 10;
      INTEGRATOR_BITS  : natural := 16   -- Bits in the integrating accumulator
    );
    port (
      -- System Clock and Clock Enable
      sys_rst_n   : in  std_logic;
      sys_clk     : in  std_logic;
      sys_clk_en  : in  std_logic;

      -- Settings
      input       : in  signed(INTEGRATOR_BITS-1 downto 0);

      -- Integration Result
      integrator  : out signed(INTEGRATOR_BITS-1 downto 0)

    );
  end leaky_integrator;

architecture beh of leaky_integrator is

  -- Constants

  -- Functions & associated types

  -- Signal Declarations
  signal sum     : signed(INTEGRATOR_BITS-1 downto 0);
  signal delta   : signed(INTEGRATOR_BITS-1 downto 0);
  signal m_term  : signed(INTEGRATOR_BITS+LEAK_FACTOR_BITS downto 0);

begin

-- The feedback term
m_term <= sum*to_signed(LEAK_FACTOR,LEAK_FACTOR_BITS+1);

-- The difference term
delta  <= input - s_resize_l(m_term,delta'length);

-- The leaky integrator
process (sys_clk, sys_rst_n)
begin
  if (sys_rst_n='0') then
    sum <= to_signed(0,integrator'length);
  elsif (sys_clk'event and sys_clk='1') then -- rising edge
    if (sys_clk_en='1') then
      sum <= sum + delta;
    end if;
  end if;
end process;

-- The outputs
integrator <= sum;

end beh;

-------------------------------------------------------------------------------
-- Leaky Integrator with conditioned Digital Output
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Date  : Oct. 11, 2013 Started Coding, drawing from various other sources.
--                       Created description.  Simulated it and saw that it
--                       works.
--                 
--
-- Description
-------------------------------------------------------------------------------
-- This module is a pretty simple digital "leaky integrator" designed to clean
-- up noisy repetitive signals by integrating them, and applying thresholds
-- to the integrated result.
--
--   The first order differential equation is of the form:
--
--     dx/dt = -leak_factor*x + input
--
-- The input is discretized in both time and amplitude.  A one bit digital
-- input can be mapped to the "input" signal by using a positive value for
-- '1' and a negative value for '0'
--
-- The "leak_factor" is a feedback term, so that "DC gain" is inversely
-- proportional to the leak_factor.
--
-- Due to the presence of the feedback term, the integration's DC value, or
-- constant term, gets "leaked" to zero over time.  This is nice because
-- the threshold centers around zero.
--
-- Hysteresis can be added so that the digital output transitions an amount
-- above or below zero, depending on the current value of the output.
--
-- Clear as mud?  Well, it's similar to a low-pass filter, and the hysteresis
-- also helps remove noise on the input signal.
--
-- The sys_rst_n input is an asynchronous reset.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

library work;
use work.convert_pack.all;

  entity leaky_integrator_with_digital_output is
    generic(
      FACTOR_BITS     : natural := 10;  -- Make this less than INTEGRATOR_BITS
      HYSTERESIS_BITS : natural := 10;  -- Make this less than INTEGRATOR_BITS
      INTEGRATOR_BITS : natural := 16   -- Bits in the integrating accumulator
    );
    port (
      -- System Clock and Clock Enable
      sys_rst_n   : in  std_logic;
      sys_clk     : in  std_logic;
      sys_clk_en  : in  std_logic;

      -- Settings
      input       : in  signed(INTEGRATOR_BITS-1 downto 0);
      leak_factor : in  signed(FACTOR_BITS-1 downto 0);
      hysteresis  : in  unsigned(HYSTERESIS_BITS-1 downto 0);

      -- Integration Result
      integrator  : out signed(INTEGRATOR_BITS-1 downto 0);

      -- Conditioned Digital Output Signal
      output      : out std_logic
    );
  end leaky_integrator_with_digital_output;

architecture beh of leaky_integrator_with_digital_output is

  -- Constants

  -- Functions & associated types

  -- Signal Declarations
  signal sum     : signed(INTEGRATOR_BITS-1 downto 0);
  signal delta   : signed(INTEGRATOR_BITS-1 downto 0);
  signal m_term  : signed(INTEGRATOR_BITS+FACTOR_BITS-1 downto 0);
  signal out_l   : std_logic;
  signal hp_term : signed(INTEGRATOR_BITS-1 downto 0);
  signal hn_term : signed(INTEGRATOR_BITS-1 downto 0);

begin

-- The feedback term
m_term <= sum*leak_factor;

-- The difference term
delta  <= input - s_resize_l(m_term,delta'length);

-- The leaky integrator
process (sys_clk, sys_rst_n)
begin
  if (sys_rst_n='0') then
    sum <= to_signed(0,integrator'length);
    out_l <= '0';
  elsif (sys_clk'event and sys_clk='1') then -- rising edge
    if (sys_clk_en='1') then
      sum <= sum + delta;
      if (out_l='0') then
        if (sum>hp_term) then
          out_l <= '1';
        end if;
      else
        if (sum<hn_term) then
          out_l <= '0';
        end if;
      end if;
    end if;
  end if;
end process;

-- The hysteresis terms
hp_term <= signed(u_resize(hysteresis,INTEGRATOR_BITS));
hn_term <= not(hp_term)+1;

-- The outputs
integrator <= sum;
output <= out_l;

end beh;

-------------------------------------------------------------------------------
-- Multi Stage Leaky Integrator with Digital Output
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Date  : Oct. 11, 2013 Started Coding, drawing from various other sources.
--                       Created description.
--                 
--
-- Description
-------------------------------------------------------------------------------
-- This module implements N-stages of leaky integrators.  Each stage has the
-- same leak factor, which is a value fixed by generics.  Use powers of two
-- to avoid inferring multipliers.  The smallest value of 1 is actually a
-- pretty nice choice.  The LEAK_FACTOR_BITS generic determines how small
-- the leak factor is by setting the number of bits.  The integer is converted
-- as follows:
--
--   multiplicand = to_signed(LEAK_FACTOR,LEAK_FACTOR_BITS);
--
--   It seems that the smallest signed number is 2 bits wide - one for a sign
--   bit, and the other for magnitude.  So, LEAK_FACTOR_BITS must be >=2.
--   Between stages, an arithmetic shift right operation is inserted, which is
--   intended to automatically scale the signal to fit the next integrator.
--
-- The hysteresis value is only applied at the final stage output, to derive
-- the conditioned digital output signal.
--
-- The "leak_factor" is a feedback term, so that "DC gain" is inversely
-- proportional to the leak_factor.
--
-- Due to the presence of the feedback term, the integration's DC value, or
-- constant term, gets "leaked" to zero over time.  This is nice because
-- the threshold centers around zero.
--
-- Hysteresis can be added so that the digital output transitions an amount
-- above or below zero, depending on the current value of the output.
--
-- Clear as mud?  Well, it's similar to a low-pass filter, and the hysteresis
-- also helps remove noise on the input signal.
--
-- The more stages are used, the more low-pass filtering occurs.
--
-- The sys_rst_n input is an asynchronous reset.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

library work;
use work.convert_pack.all;
use work.signal_conditioning_pack.all;

  entity multi_stage_leaky_integrator is
    generic(
      STAGES           : natural := 2;
      LEAK_FACTOR_BITS : natural := 5;  -- Inversely related to LP corner frequency. (Min=1)
      HYSTERESIS_BITS  : natural := 8;  -- Make this less than INTEGRATOR_BITS
      INTEGRATOR_BITS  : natural := 16  -- Bits in each integrating accumulator
    );
    port (
      -- System Clock and Clock Enable
      sys_rst_n   : in  std_logic;
      sys_clk     : in  std_logic;
      sys_clk_en  : in  std_logic;

      -- Settings
      input       : in  signed(INTEGRATOR_BITS-1 downto 0);
      hysteresis  : in  unsigned(HYSTERESIS_BITS-1 downto 0);

      -- Final Stage Integration Result
      integrator  : out signed(INTEGRATOR_BITS-1 downto 0);

      -- Conditioned Digital Output Signal
      output      : out std_logic
    );
  end multi_stage_leaky_integrator;

architecture beh of multi_stage_leaky_integrator is

  -- Constants
    -- This value has been found to preserve amplitude between stages,
    -- without appreciable growth or shrinkage of sum levels.
  constant STAGE_ASR   : natural := LEAK_FACTOR_BITS+1;
  constant LEAK_FACTOR : natural := 1;

  -- Functions & associated types

  -- Signal Declarations
  type sum_type is array (natural range STAGES-1 downto 0) of signed(INTEGRATOR_BITS-1 downto 0);
  signal sum_in  : sum_type;
  signal sum_out : sum_type;
  signal out_l   : std_logic;
  signal hp_term : signed(INTEGRATOR_BITS-1 downto 0);
  signal hn_term : signed(INTEGRATOR_BITS-1 downto 0);

begin


----------------------------------------------
leaky_gen : for nvar in 0 to STAGES-1 generate
begin
  lint : leaky_integrator
    generic map(
      LEAK_FACTOR_BITS => LEAK_FACTOR_BITS,
      LEAK_FACTOR      => LEAK_FACTOR,
      INTEGRATOR_BITS  => INTEGRATOR_BITS
    )
    port map(
      -- System Clock and Clock Enable
      sys_rst_n   => sys_rst_n,
      sys_clk     => sys_clk,
      sys_clk_en  => sys_clk_en,

      -- Settings
      input       => sum_in(nvar),

      -- Integration Result
      integrator  => sum_out(nvar)

    );
end generate;

sum_in(0) <= input;
sum_gen : for nvar in 1 to STAGES-1 generate
begin
  sum_in(nvar) <= asr_function(sum_out(nvar-1),STAGE_ASR);
end generate;

-- The hysteresis and digital output
process (sys_clk, sys_rst_n)
begin
  if (sys_rst_n='0') then
    out_l <= '0';
  elsif (sys_clk'event and sys_clk='1') then -- rising edge
    if (sys_clk_en='1') then
      if (out_l='0') then
        if (sum_out(STAGES-1)>hp_term) then
          out_l <= '1';
        end if;
      else
        if (sum_out(STAGES-1)<hn_term) then
          out_l <= '0';
        end if;
      end if;
    end if;
  end if;
end process;

-- The hysteresis terms
hp_term <= signed(u_resize(hysteresis,INTEGRATOR_BITS));
hn_term <= not(hp_term)+1;

-- The outputs
integrator <= sum_out(STAGES-1);
output <= out_l;

end beh;

-------------------------------------------------------------------------------
-- Integrating Pulse Stretcher
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Date  : Oct. 24, 2013 Started Coding, drawing from various other sources.
--                       Created description.  Simulated it and saw that it
--                       works.
--                 
--
-- Description
-------------------------------------------------------------------------------
-- This module is a pretty simple digital pulse stretcher.  A high input pulse
-- present for more than MIN_CLKS clock cycles causes the INITIAL_OFFSET value
-- to be loaded into an accumulator.  The accumulator is then incremented by 
-- STRETCH_FACTOR each clock cycle that the input pulse remains high, and is
-- decremented by one for each clock cycle that the input pulse is low.
--
-- The output is driven high whenever the accumulator is positive.
--
-- The output pulse width is given by:
--
--   Tpulse_o = STRETCH_FACTOR*(Tpulse_i-MIN_CLKS) + INITIAL_OFFSET
--
-- The INITIAL_OFFSET can be used to overcome the effects of minimum input
-- pulse filtering.  Also, if a negative value is used for it, then the
-- output pulse is delayed by additional clock cycles beyond the MIN_CLKS
-- of delay already present.  Another use for the INITIAL_OFFSET value is
-- to "bridge together" a train of pulses which might have some jitter.
-- The INITIAL_OFFSET value allows for some slop of jitter to be covered
-- by the extra decay time, so that no "gaps" appear in the output pulse.
--
-- During the decay time, when the output is high, the arrival of a new pulse
-- will cause further charging of the accumulator.  There is no minimum pulse
-- width for this to occur.  The MIN_CLKS only applies to starting the unit
-- from a quiescent state.
--
-- The integrator is a signed quantity, so set INTEGRATOR_BITS accordingly,
-- because the integrator can only hold positive quantities up to
-- 2^(INTEGRATOR_BITS-1)-1.
--
-- The sys_rst_n input is an asynchronous reset.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

library work;
use work.convert_pack.all;

  entity integrating_pulse_stretcher is
    generic(
      MIN_CLKS        : natural :=  5; -- pulses below this many clocks are ignored
      RETRIGGERABLE   : natural :=  1; -- 1=restart on new pulses.  0=decay to zero before restarting
      STRETCH_FACTOR  : natural :=  2; -- 0=no output, 1=same size, 2=double
      INITIAL_OFFSET  : natural := 25; -- Value initially loaded into integrator
      INTEGRATOR_BITS : natural := 16  -- Bits in the integrating accumulator
    );
    port (
      -- System Clock and Clock Enable
      sys_rst_n   : in  std_logic;
      sys_clk     : in  std_logic;
      sys_clk_en  : in  std_logic;

      -- Input
      pulse_i     : in  std_logic;

      -- Output
      pulse_o     : out std_logic

    );
  end integrating_pulse_stretcher;

architecture beh of integrating_pulse_stretcher is

  -- Constants
  constant RUNT_BITS : natural := timer_width(MIN_CLKS);

  -- Functions & associated types

  -- Signal Declarations
  signal runt_count : unsigned(RUNT_BITS-1 downto 0);
  signal sum        : signed(INTEGRATOR_BITS-1 downto 0);
  signal pulse_i_r1 : std_logic;
  signal pulse_l    : std_logic;

begin

-- The integrator
process (sys_clk, sys_rst_n)
begin
  if (sys_rst_n='0') then
    runt_count <= to_unsigned(0,runt_count'length);
    sum        <= to_signed(0,sum'length);
    pulse_i_r1 <= '0';
  elsif (sys_clk'event and sys_clk='1') then -- rising edge
    if (sys_clk_en='1') then
      -- Detect rising edge of input pulse
      pulse_i_r1 <= pulse_i;
      -- When the pulse_i input is consecutively high, decrement the runt
      -- counter until it is zero.
      if (runt_count>0) then
        if (pulse_i='1') then
          runt_count <= runt_count-1;
        else
          runt_count <= to_unsigned(MIN_CLKS,runt_count'length);
        end if;
      end if;
      -- Trigger on rising edge of pulse_i
      if (pulse_i='1' and pulse_i_r1='0') then
        if (pulse_l='0' or (RETRIGGERABLE=1 and pulse_l='1')) then
          runt_count <= to_unsigned(MIN_CLKS,runt_count'length);
        end if;
      end if;
      -- Load initial offset into accumulator on final runt countdown
      if (runt_count=1) then
        sum <= to_signed(INITIAL_OFFSET,sum'length);
      end if;
      -- Either accumulate or decay, depending on input state
      if (pulse_i='1' and runt_count=0) then
        sum <= sum+STRETCH_FACTOR;
      elsif (pulse_i='0' and pulse_l='1') then
        sum <= sum-1;
      end if;
    end if;
  end if;
end process;

-- The output
pulse_l <= '1' when (sum>0) else '0';
pulse_o <= pulse_l;

end beh;

