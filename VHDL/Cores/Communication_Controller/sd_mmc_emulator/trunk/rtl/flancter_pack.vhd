--------------------------------------------------------------------------
-- Package of flancter components
--
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package flancter_pack is

  component flancter
  port (
    async_rst_n : in  std_logic;
    set_clk     : in  std_logic;
    set_ce      : in  std_logic;
    reset_clk   : in  std_logic;
    reset_ce    : in  std_logic;
    flag_s_o    : out std_logic;
    flag_r_o    : out std_logic;
    flag_o      : out std_logic
    );
  end component;

  component flancter_fastflag
  port (
    async_rst_n : in  std_logic;
    set_clk     : in  std_logic;
    set_ce      : in  std_logic;
    reset_clk   : in  std_logic;
    reset_ce    : in  std_logic;
    flag_s_o    : out std_logic;
    flag_r_o    : out std_logic;
    flag_o      : out std_logic
    );
  end component;

  component flancter_rising
  port (
    async_rst_n : in  std_logic;
    set_clk     : in  std_logic;
    set         : in  std_logic;
    reset_clk   : in  std_logic;
    reset       : in  std_logic;
    flag_s_o    : out std_logic;
    flag_r_o    : out std_logic;
    flag_o      : out std_logic
    );
  end component;

  component flancter_rising_pulseout
  port (
    async_rst_n : in  std_logic;
    set_clk     : in  std_logic;
    set         : in  std_logic;
    reset_clk   : in  std_logic;
    reset       : in  std_logic;
    pulse_s_o   : out std_logic;
    pulse_r_o   : out std_logic;
    flag_o      : out std_logic
    );
  end component;

end flancter_pack;

package body flancter_pack is
end flancter_pack;

-------------------------------------------------------------------------------
-- Basic Flancter Component
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update: May   1, 2013 Copied code from Rob Weinstein's MEMEC flancter
--                       app note.  Formatted it, and wrote a short
--                       description.
--
-- Description
-------------------------------------------------------------------------------
-- This is a simple set/reset flag that crosses clock domains in a safe
-- manner.
-- For further details, see Rob Weinstein's MEMEC app. note
-- (Which probably was a Xilinx app. note at one time...)
--
--


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

  entity flancter is
  port (
    async_rst_n : in  std_logic;
    set_clk     : in  std_logic;
    set_ce      : in  std_logic;
    reset_clk   : in  std_logic;
    reset_ce    : in  std_logic;
    flag_s_o    : out std_logic;
    flag_r_o    : out std_logic;
    flag_o      : out std_logic
    );
  end flancter;

architecture beh of flancter is

-- Signals
signal setflop : std_logic;
signal rstflop : std_logic;
signal flag    : std_logic;

begin

  --The Set flip-flop
  set_proc:process(async_rst_n, set_clk)
  begin
    if async_rst_n='0' then
      setflop <= '0';
      flag_s_o <= '0';
    elsif rising_edge(set_clk) then
      if set_ce = '1' then
        -- Flops get opposite logic levels.
        setflop <= not rstflop;
      end if;
      flag_s_o <= flag;
    end if;
  end process;

  --The Reset flip-flop
  reset_proc:process(async_rst_n, reset_clk)
  begin
    if async_rst_n='0' then
      rstflop <= '0';
      flag_r_o <= '0';
    elsif rising_edge(reset_clk) then
      if reset_ce = '1' then
        -- Flops get the same logic levels.
        rstflop <= setflop;
      end if;
      flag_r_o <= flag;
    end if;
  end process;

flag <= setflop xor rstflop;
flag_o <= flag;

end beh;


-------------------------------------------------------------------------------
-- Flancter Component - "Fast Flag" version
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update: May   1, 2013 Copied code from flancter, updated it to set and
--                       clear flags as early as possible!  The original
--                       has a one clock cycle delay before the synchronized
--                       flags reflect the state of the raw flag.
--
-- Description
-------------------------------------------------------------------------------
-- This is a simple set/reset flag that crosses clock domains in a safe
-- manner.
-- For further details, see Rob Weinstein's MEMEC app. note
-- (Which probably was a Xilinx app. note at one time...)
--
--


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

  entity flancter_fastflag is
  port (
    async_rst_n : in  std_logic;
    set_clk     : in  std_logic;
    set_ce      : in  std_logic;
    reset_clk   : in  std_logic;
    reset_ce    : in  std_logic;
    flag_s_o    : out std_logic;
    flag_r_o    : out std_logic;
    flag_o      : out std_logic
    );
  end flancter_fastflag;

architecture beh of flancter_fastflag is

-- Signals
signal setflop : std_logic;
signal rstflop : std_logic;
signal flag    : std_logic;

begin

  --The Set flip-flop
  set_proc:process(async_rst_n, set_clk)
  begin
    if async_rst_n='0' then
      setflop <= '0';
      flag_s_o <= '0';
    elsif rising_edge(set_clk) then
      flag_s_o <= flag;
      if set_ce = '1' then
        -- Flops get opposite logic levels.
        setflop <= not rstflop;
        flag_s_o <= '1'; -- Fast action!
      end if;
    end if;
  end process;

  --The Reset flip-flop
  reset_proc:process(async_rst_n, reset_clk)
  begin
    if async_rst_n='0' then
      rstflop <= '0';
      flag_r_o <= '0';
    elsif rising_edge(reset_clk) then
      flag_r_o <= flag;
      if reset_ce = '1' then
        -- Flops get the same logic levels.
        rstflop <= setflop;
        flag_r_o <= '0'; -- Fast action!
      end if;
    end if;
  end process;

flag <= setflop xor rstflop;
flag_o <= flag;

end beh;


-------------------------------------------------------------------------------
-- Flancter Component with rising edge detection on set/reset inputs
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update: May   2, 2013 Copied code from basic flancter, and added rising
--                       edge detectors.
--
-- Description
-------------------------------------------------------------------------------
-- This is a simple set/reset flag that crosses clock domains in a safe
-- manner.
-- For further details, see Rob Weinstein's MEMEC app. note
-- (Which probably was a Xilinx app. note at one time...)
--
--


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

  entity flancter_rising is
  port (
    async_rst_n : in  std_logic;
    set_clk     : in  std_logic;
    set         : in  std_logic;
    reset_clk   : in  std_logic;
    reset       : in  std_logic;
    flag_s_o    : out std_logic;
    flag_r_o    : out std_logic;
    flag_o      : out std_logic
    );
  end flancter_rising;

architecture beh of flancter_rising is

-- Signals
signal setflop   : std_logic;
signal rstflop   : std_logic;
signal flag      : std_logic;
signal set_ce    : std_logic;
signal reset_ce  : std_logic;
signal set_r1    : std_logic;
signal reset_r1  : std_logic;

begin

  --The Set flip-flop
  set_proc:process(async_rst_n, set_clk)
  begin
    if async_rst_n='0' then
      setflop <= '0';
      flag_s_o <= '0';
      set_r1 <= '1';
    elsif rising_edge(set_clk) then
      set_r1 <= set;
      if set_ce = '1' then
        -- Flops get opposite logic levels.
        setflop <= not rstflop;
      end if;
      flag_s_o <= flag;
    end if;
  end process;
  set_ce <= '1' when set='1' and set_r1='0' else '0';

  --The Reset flip-flop
  reset_proc:process(async_rst_n, reset_clk)
  begin
    if async_rst_n='0' then
      rstflop <= '0';
      flag_r_o <= '0';
      reset_r1 <= '0';
    elsif rising_edge(reset_clk) then
      reset_r1 <= reset;
      if reset_ce = '1' then
        -- Flops get the same logic levels.
        rstflop <= setflop;
      end if;
      flag_r_o <= flag;
    end if;
  end process;
  reset_ce <= '1' when reset='1' and reset_r1='0' else '0';

flag <= setflop xor rstflop;
flag_o <= flag;

end beh;


-------------------------------------------------------------------------------
-- Flancter Component with rising edge detection on set/reset inputs,
-- and outputs which go high for a single clock pulse.
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Update: May   2, 2013 Copied code from flancter_rising, and added rising
--                       edge detectors to the outputs, changing them from
--                       "flags" to "pulses".
--
-- Description
-------------------------------------------------------------------------------
-- This is a simple set/reset flag that crosses clock domains in a safe
-- manner.
-- For further details, see Rob Weinstein's MEMEC app. note
-- (Which probably was a Xilinx app. note at one time...)
--
--


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

  entity flancter_rising_pulseout is
  port (
    async_rst_n : in  std_logic;
    set_clk     : in  std_logic;
    set         : in  std_logic;
    reset_clk   : in  std_logic;
    reset       : in  std_logic;
    pulse_s_o   : out std_logic;
    pulse_r_o   : out std_logic;
    flag_o      : out std_logic
    );
  end flancter_rising_pulseout;

architecture beh of flancter_rising_pulseout is

-- Signals
signal setflop    : std_logic;
signal rstflop    : std_logic;
signal flag       : std_logic;
signal set_ce     : std_logic;
signal reset_ce   : std_logic;
signal set_r1     : std_logic;
signal reset_r1   : std_logic;
signal pulse_s_r1 : std_logic;
signal pulse_s_r2 : std_logic;
signal pulse_r_r1 : std_logic;
signal pulse_r_r2 : std_logic;

begin

  --The Set flip-flop
  set_proc:process(async_rst_n, set_clk)
  begin
    if async_rst_n='0' then
      setflop <= '0';
      pulse_s_r1 <= '0';
      pulse_s_r2 <= '0';
      set_r1 <= '1';
    elsif rising_edge(set_clk) then
      set_r1 <= set;
      if set_ce = '1' then
        -- Flops get opposite logic levels.
        setflop <= not rstflop;
      end if;
      pulse_s_r1 <= flag;
      pulse_s_r2 <= pulse_s_r1;
    end if;
  end process;
  set_ce <= '1' when set='1' and set_r1='0' else '0';
  pulse_s_o <= '1' when pulse_s_r1='1' and pulse_s_r2='0' else '0';

  --The Reset flip-flop
  reset_proc:process(async_rst_n, reset_clk)
  begin
    if async_rst_n='0' then
      rstflop <= '0';
      pulse_r_r1 <= '0';
      pulse_r_r2 <= '0';
      reset_r1 <= '0';
    elsif rising_edge(reset_clk) then
      reset_r1 <= reset;
      if reset_ce = '1' then
        -- Flops get the same logic levels.
        rstflop <= setflop;
      end if;
      pulse_r_r1 <= flag;
      pulse_r_r2 <= pulse_r_r1;
    end if;
  end process;
  reset_ce <= '1' when reset='1' and reset_r1='0' else '0';
  pulse_r_o <= '1' when pulse_r_r1='1' and pulse_r_r2='0' else '0';

flag <= setflop xor rstflop;
flag_o <= flag;

end beh;


