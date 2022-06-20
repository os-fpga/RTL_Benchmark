--------------------------------------------------------------------------
-- Package
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

package bus_arbiter_pack is

  component bus_arbiter_N_way
    generic(
      LOCKING : integer; -- Nonzero to hold until ack_i is received.
      N_VALUE : integer; -- Number of bus requestors.
      LOG2_N  : integer  -- Bit width of msel_o
    );
    port (
      -- System Clock and Clock Enable
      sys_rst_n   : in  std_logic;
      sys_clk     : in  std_logic;
      sys_clk_en  : in  std_logic;

      -- Bus Access Request Inputs
      req_i       : in  unsigned(N_VALUE-1 downto 0);

      -- Status
      cyc_o       : out std_logic;
      hold_o      : out std_logic; -- Bus lock
      
      -- Ram Access Acknowledge
      ack_i       : in  std_logic; -- Releases lock

      -- Ram Selection (Use to control external muxes)
      msel_o      : out unsigned(LOG2_N-1 downto 0);
      msel_new_o  : out std_logic
    );
  end component;

  component bus_arbiter_dataflow_N_way
    generic(
      LOCKING : integer; -- Nonzero to hold until ack_i is received.
      N_VALUE : integer; -- Number of bus requestors.
      LOG2_N  : integer  -- Bit width of msel_o
    );
    port (
      -- System Clock and Clock Enable
      sys_rst_n   : in  std_logic;
      sys_clk     : in  std_logic;
      sys_clk_en  : in  std_logic;

      -- Bus Access Request Inputs
      req_i       : in  unsigned(N_VALUE-1 downto 0);

      -- Status
      cyc_o       : out std_logic;
      hold_o      : out std_logic; -- Bus lock
      
      -- Ram Access Acknowledge
      ack_i       : in  std_logic; -- Releases lock

      -- Ram Selection (Use to control external muxes)
      msel_o      : out unsigned(LOG2_N-1 downto 0);
      msel_new_o  : out std_logic
    );
  end component;

  component bus_requester_N_way
    generic(
      N_VALUE : integer -- Number of bus requestors.
    );
    port (
      -- System Clock and Clock Enable
      sys_rst_n   : in  std_logic;
      sys_clk     : in  std_logic;
      sys_clk_en  : in  std_logic;

      -- Single "master" Bus Access Request and acknowledge
      req_i       : in  std_logic;
      ack_o       : out std_logic;

      -- A multiplicity of subordinate bus requests
      n_req_o     : out unsigned(N_VALUE-1 downto 0);
      
      -- A multiplicity of subordinate Bus Access Acknowledge signals
      n_ack_i     : in  unsigned(N_VALUE-1 downto 0)

    );
  end component;


end bus_arbiter_pack;

-------------------------------------------------------------------------------
-- Bus Access Arbitration Module
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Date  : July 13, 2011 Copied code from "bus_arbiter_4_way" to begin.
--                       I am hoping to derive a more parameterized
--                       module.
--         Sept 11, 2012 After much successful use in hardware, I have
--                       revisited this module and simplified it so that
--                       requests are immediately driven out to msel.
--                       The intent is to eliminate wasted clock cycles.
--         Nov. 21, 2012 I have discovered that I was using an external
--                       mux for the bus_cyc signal, which is fairly
--                       understandable, since I'm using external muxes
--                       for nearly everything...  However, in the case
--                       of the bys_cyc signal, there is an unnecessary
--                       "opportunity for error" since bus_cyc is always
--                       set to the currently selected request line. It
--                       occurred to me that this can be moved inside
--                       the module, thereby eliminating the possibility
--                       of connecting it up incorrectly outside the
--                       module.  Thus, I'm adding the cyc_o signal.
--         May  15, 2013 While simulating a design, I discovered that
--                       while one request is active, another request
--                       may arrive which alters the state of msel_next,
--                       thus altering the output msel_o.  This is a flaw
--                       since requesters may be depending on the value
--                       of msel_o in order to receive acknowledgments,
--                       and could therefore erroneously see a ack when
--                       msel_o changed.  A new statement was added to
--                       "lock out" changes to msel_next while the current
--                       request is still active.
--         May  23, 2013 Because accesses through multiple arbiters using
--                       a single cycle seemed "aggressive" I put in a
--                       one cycle delay here.  This arbiter has the
--                       advantage now of not synthesizing any latches...
--                       The "dataflow" version could still be used, perhaps,
--                       reliably with a delayed acknowledge signal!
--         Feb.  6, 2014 Added cyc_l for fast clearing of cyc_o.
--         Feb. 11, 2014 Added LOCKING generic and hold_o output, to
--                       permit locking the arbiter until ack_i is
--                       received.
--                 
--
-- Description
-------------------------------------------------------------------------------
-- This module is an N way request arbitration unit.  There are N high
-- asserted request inputs.  When any subset of these is asserted, the arbitrator
-- causes its "msel" (multiplexer select address) output to control muxes that
-- route the appropriate request to the bus.
--
-- This unit is meant to coordinate access to a single resource bus, by N requesters.
-- The access is not exactly fair, since there is no timeout implemented here.
-- Thus, a requester must implement its own timeout, and if it never receives
-- an acknoledge signal, and never deasserts its request line, then the bus
-- will be "hogged" by that requester for ever.  The purpose of this module
-- is not to rip away the bus from a misbehaving or irresponsible requester.
-- Rather, this module gives out access to the bus in turns.  Each turn must
-- be fairly conducted by the requester.
--
-- There is a single acknowledge signal from the single bus.  The assertion of
-- the ack_i signal for one sys_clk edge is sufficient to terminate the current
-- access cycle, and cause this unit to change the msel_o output to route signals
-- from the next requester to the memory bus.  This same termination condition
-- should be respected by all requesters using this module.
--
-- The reason that external muxes are used to send the bus signals to the RAM is
-- to enable other muxes to be controlled for additional processing, e.g. an
-- offset engine which modifies the address presented to the bus, with the offset
-- being different depending on which requester is using the bus.
--
-- The policy of "fairness" followed by this module is of the "round robin" type.
-- In other words, each request when completed, is followed by a grant to the next
-- request, in order 0,1,2,...N-1,0,1...  There is no requirement for the request
-- lines to be returned to the inactive state before they can be asserted and
-- recognized again as valid requests.
--
-- There is a "parking" philosophy implemented in this module, which works in the
-- following way:  Whenever a request is completed, if there are no other pending
-- requests, the msel_o output remains in its current state.  This is probably
-- not an important fact, except to note that the most recent requester, already
-- having control of the memory bus, gets its next request granted one cycle faster
-- than usual, since its new request doesn't need to cause any change in the muxes
-- to grant it access to the memory bus.
--
-- Following reset, the msel_o output is set to zero, meaning that the bus is parked
-- for quickest access by requester zero.  Note that it is the user's responsibility
-- to ensure that the connections to the external muxes are made in such a way as to
-- correspond to the request inputs, according to this mapping:
--
--      Request Input         Corresponding msel_o output
--      -------------         ---------------------------
--        req_i(0)                       00b
--        req_i(1)                       01b
--         .....                         ...
--        req_i(N-1)                     unsigned(N-1)
--
-- All storage elements within this module are clocked according to the positive edge
-- of the sys_clk input, qualified by the sys_clk_en input being asserted high.  In
-- this way, sys_clk_en can be used to run this module at slower rates than sys_clk.
--
-- The sys_rst_n input is an asynchronous reset.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity bus_arbiter_N_way is
    generic(
      LOCKING : integer := 0; -- Nonzero to hold until ack_i is received.
      N_VALUE : integer := 4; -- Number of bus requestors.
      LOG2_N  : integer := 2  -- Bit width of msel_o
    );
    port (
      -- System Clock and Clock Enable
      sys_rst_n   : in  std_logic;
      sys_clk     : in  std_logic;
      sys_clk_en  : in  std_logic;

      -- Access Request Inputs
      req_i       : in  unsigned(N_VALUE-1 downto 0);

      -- Status
      cyc_o       : out std_logic;
      hold_o      : out std_logic; -- Bus lock
      
      -- Ram Access Acknowledge
      ack_i       : in  std_logic; -- Releases lock

      -- Selection (Use to control external muxes)
      msel_o      : out unsigned(LOG2_N-1 downto 0);
      msel_new_o  : out std_logic
    );
end bus_arbiter_N_way;

architecture beh of bus_arbiter_N_way is

  -- Constants

  -- Functions & associated types

  -- Signal Declarations
  signal msel_l        : unsigned(LOG2_N-1 downto 0);
  signal msel_prior    : unsigned(LOG2_N-1 downto 0);
  signal req_asserted  : std_logic;
  signal cyc_l         : std_logic;
  signal hold_l        : std_logic;

begin

-- Combine all incoming request signals into a single signal indicating
-- there is at least one request active.
req_asserted <= '1' when (req_i/=0) else '0';

process (sys_clk, sys_clk_en, sys_rst_n)
variable l : integer := 0;
variable k : integer := 0;
begin
  if (sys_rst_n='0') then
    msel_l     <= (others=>'0');
    msel_prior <= (others=>'0');
    cyc_l  <= '0';
    hold_l <= '0';
  elsif (sys_clk'event and sys_clk='1') then
    if (sys_clk_en='1') then
      for j in 0 to N_VALUE-1 loop
        l := j+to_integer(msel_l);
        -- Use an if statement to apply "modulo N_VALUE"
        if (l>=N_VALUE) then
          k := l-N_VALUE;
        else
          k := l;
        end if;
        if (req_i(k)='1') then
          msel_l <= to_unsigned(k,LOG2_N);
        end if;
      end loop;
      -- Lock out changes to msel_l when current request is still active
      if LOCKING=0 then
        if req_i(to_integer(msel_l))='1' then
          msel_l <= msel_l;
        end if;
      else
        if hold_l='1' and ack_i='0' then
          msel_l <= msel_l;
        end if;
      end if;
      -- Handle hold_l signal
      if LOCKING=1 then
        -- clear hold
        if (hold_l='1' and ack_i='1') then
          hold_l <= '0';
        end if;
        -- Setting hold has higher priority than clearing hold
        if req_i(to_integer(msel_l))='1' and (hold_l='0' or (hold_l='1' and ack_i='1')) then
          hold_l <= '1';
        end if;
      end if;
      -- Save previous msel_l value, to support msel_new_o
      msel_prior <= msel_l;
      -- Provide the currently selected request line as an
      -- arbiter-wide bus cycle signal
      cyc_l <= req_i(to_integer(msel_l));
    end if; -- sys_clk_en
  end if; -- sys_clk
end process;

msel_o <= msel_l;
msel_new_o <= '1' when (msel_prior/=msel_l) else '0';

-- Clear the bus cycle output immediately upon removal of request.
cyc_o <= cyc_l and req_asserted;

-- Provide hold output
hold_o <= hold_l;

end beh;

-------------------------------------------------------------------------------
-- Bus Access Arbitration Module - Dataflow version
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Date  : July 13, 2011 Copied code from "bus_arbiter_4_way" to begin.
--                       I am hoping to derive a more parameterized
--                       module.
--         Sept 11, 2012 After much successful use in hardware, I have
--                       revisited this module and simplified it so that
--                       requests are immediately driven out to msel.
--                       The intent is to eliminate wasted clock cycles.
--         Nov. 21, 2012 I have discovered that I was using an external
--                       mux for the bus_cyc signal, which is fairly
--                       understandable, since I'm using external muxes
--                       for nearly everything...  However, in the case
--                       of the bys_cyc signal, there is an unnecessary
--                       "opportunity for error" since bus_cyc is always
--                       set to the currently selected request line. It
--                       occurred to me that this can be moved inside
--                       the module, thereby eliminating the possibility
--                       of connecting it up incorrectly outside the
--                       module.  Thus, I'm adding the cyc_o signal.
--         May  15, 2013 While simulating a design, I discovered that
--                       while one request is active, another request
--                       may arrive which alters the state of msel_next,
--                       thus altering the output msel_o.  This is a flaw
--                       since requesters may be depending on the value
--                       of msel_o in order to receive acknowledgments,
--                       and could therefore erroneously see a ack when
--                       msel_o changed.  A new statement was added to
--                       "lock out" changes to msel_next while the current
--                       request is still active.
--         Feb. 11, 2014 Added LOCKING generic and hold_o output, to
--                       permit locking the arbiter until ack_i is
--                       received.
--                 
--
-- Description
-------------------------------------------------------------------------------
-- This module is an N way request arbitration unit.  There are N high
-- asserted request inputs.  When any subset of these is asserted, the arbitrator
-- causes its "msel" (multiplexer select address) output to control muxes that
-- route the appropriate request to the bus.
--
-- This unit is meant to coordinate access to a single resource bus, by N requesters.
-- The access is not exactly fair, since there is no timeout implemented here.
-- Thus, a requester must implement its own timeout, and if it never receives
-- an acknoledge signal, and never deasserts its request line, then the bus
-- will be "hogged" by that requester for ever.  The purpose of this module
-- is not to rip away the bus from a misbehaving or irresponsible requester.
-- Rather, this module gives out access to the bus in turns.  Each turn must
-- be fairly conducted by the requester.
--
-- There is a single acknowledge signal from the single bus.  The assertion of
-- the ack_i signal for one sys_clk edge is sufficient to terminate the current
-- access cycle, and cause this unit to change the msel_o output to route signals
-- from the next requester to the memory bus.  This same termination condition
-- should be respected by all requesters using this module.
--
-- The reason that external muxes are used to send the bus signals to the RAM is
-- to enable other muxes to be controlled for additional processing, e.g. an
-- offset engine which modifies the address presented to the bus, with the offset
-- being different depending on which requester is using the bus.
--
-- The policy of "fairness" followed by this module is of the "round robin" type.
-- In other words, each request when completed, is followed by a grant to the next
-- request, in order 0,1,2,...N-1,0,1...  There is no requirement for the request
-- lines to be returned to the inactive state before they can be asserted and
-- recognized again as valid requests.
--
-- There is a "parking" philosophy implemented in this module, which works in the
-- following way:  Whenever a request is completed, if there are no other pending
-- requests, the msel_o output remains in its current state.  This is probably
-- not an important fact, except to note that the most recent requester, already
-- having control of the memory bus, gets its next request granted one cycle faster
-- than usual, since its new request doesn't need to cause any change in the muxes
-- to grant it access to the memory bus.
--
-- Following reset, the msel_o output is set to zero, meaning that the bus is parked
-- for quickest access by requester zero.  Note that it is the user's responsibility
-- to ensure that the connections to the external muxes are made in such a way as to
-- correspond to the request inputs, according to this mapping:
--
--      Request Input         Corresponding msel_o output
--      -------------         ---------------------------
--        req_i(0)                       00b
--        req_i(1)                       01b
--         .....                         ...
--        req_i(N-1)                     unsigned(N-1)
--
-- All storage elements within this module are clocked according to the positive edge
-- of the sys_clk input, qualified by the sys_clk_en input being asserted high.  In
-- this way, sys_clk_en can be used to run this module at slower rates than sys_clk.
--
-- The sys_rst_n input is an asynchronous reset.
--
-- This version of the bus arbiter is a "dataflow" version in the sense that the
-- msel_o outputs change immediately upon a request input going high, thus allowing
-- for a bus cycle to be arbitrated and acknowledged in fewer sys_clk periods.
--
-- However, it synthesizes a latch in the msel_next process.  If this is nettlesome,
-- then do not use it...

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity bus_arbiter_dataflow_N_way is
    generic(
      LOCKING : integer := 0; -- Nonzero to hold until ack_i is received.
      N_VALUE : integer := 4; -- Number of bus requestors.
      LOG2_N  : integer := 2  -- Bit width of msel_o
    );
    port (
      -- System Clock and Clock Enable
      sys_rst_n   : in  std_logic;
      sys_clk     : in  std_logic;
      sys_clk_en  : in  std_logic;

      -- Ram Access Request Inputs
      req_i       : in  unsigned(N_VALUE-1 downto 0);

      -- Status
      cyc_o       : out std_logic;
      hold_o      : out std_logic; -- Bus lock
      
      -- Ram Access Acknowledge
      ack_i       : in  std_logic; -- Releases lock

      -- Ram Selection (Use to control external muxes)
      msel_o      : out unsigned(LOG2_N-1 downto 0);
      msel_new_o  : out std_logic
    );
end bus_arbiter_dataflow_N_way;

architecture beh of bus_arbiter_dataflow_N_way is

  -- Constants

  -- Functions & associated types

  -- Signal Declarations
  -- type msel_type is integer range 0 to N_VALUE-1; -- changed to integer for the simulator...
  -- signal msel_l        : msel_type := 0;
  -- signal msel_prev     : msel_type := 0;
  signal msel_next     : unsigned(LOG2_N-1 downto 0);
  signal msel_l        : unsigned(LOG2_N-1 downto 0);
  signal msel_prior    : unsigned(LOG2_N-1 downto 0);
  signal req_asserted  : std_logic;
  signal hold_l        : std_logic;

begin

-- Combine all incoming request signals into a single signal indicating
-- there is at least one request active.
req_asserted <= '1' when (req_i/=0) else '0';

process (msel_l,req_i)
-- type msel_modulo_type is integer range 0 to 2*N_VALUE-1; -- changed to integer, to satisfy simulator...
-- variable l : msel_modulo_type := 0;
-- variable k : msel_type := 0;
variable l : integer := 0;
variable k : integer := 0;
begin
  -- Change mux selections based on request and ack inputs.
  msel_next <= msel_l; -- Default value, prevents latch formation
  for j in 0 to N_VALUE-1 loop
    l := j+to_integer(msel_l);
    -- Use an if statement to apply "modulo N_VALUE"
    if (l>=N_VALUE) then
      k := l-N_VALUE;
    else
      k := l;
    end if;
    if (req_i(k)='1') then
      msel_next <= to_unsigned(k,LOG2_N);
    end if;
  end loop;
  -- Lock out changes to msel_next when current request is still active
  if LOCKING=0 then
    if req_i(to_integer(msel_l))='1' then
      msel_next <= msel_next;
    end if;
  else
    if (hold_l='1' and ack_i='0') then
      msel_next <= msel_next;
    end if;
  end if;
end process;

process (sys_clk, sys_clk_en, sys_rst_n)
begin
  if (sys_rst_n='0') then
    msel_l     <= (others=>'0');
    msel_prior <= (others=>'0');
    hold_l <= '0';
  elsif (sys_clk'event and sys_clk='1') then
    if (sys_clk_en='1') then
      msel_prior <= msel_next;
      if LOCKING=0 then
        if req_asserted='1' then
          msel_l <= msel_next;
        end if;
      else
        if req_asserted='1' and (hold_l='0' or (hold_l='1' and ack_i='1')) then
          msel_l <= msel_next;
        end if;
      end if;

      -- Handle the hold_l signal
        -- clear hold
      if (hold_l='1' and ack_i='1') then
        hold_l <= '0';
      end if;
        -- Setting hold has higher priority than clearing hold
      if req_i(to_integer(msel_l))='1' and LOCKING=1 then
        if (hold_l='0' or (hold_l='1' and ack_i='1')) then
          hold_l <= '1';
        end if;
      end if;

    end if; -- sys_clk_en
  end if; -- sys_clk
end process;

msel_o <= msel_next;
msel_new_o <= '1' when (msel_prior/=msel_next) else '0';

-- Provide the currently selected request line as an
-- arbiter-wide bus cycle signal
cyc_o <= req_i(to_integer(msel_next));

hold_o <= '0';

end beh;

-------------------------------------------------------------------------------
-- Multiple Bus Access Request Module
-------------------------------------------------------------------------------
--
-- Author: John Clayton
-- Date  : Feb.  3, 2014 Copied code from "bus_arbiter_N_way" to begin.
--
-- Description
-------------------------------------------------------------------------------
-- This module is an N way bus request unit.  It is meant for those rare days
-- when a single bus cycle is issued to multiple buses, all of which must
-- acknowledge the cycle before the request can be considered fulfilled.
--
-- Asserting a single "master" req_i signal gives rise to the assertion of a
-- multiplicity of bus request req_o signals.  Each of these is then used to
-- generate a bus cycle, with its associated acknowledge ack_i handshake signal
-- in return.  When each ack_i handshake is received, the associated request
-- line is deasserted.  However, the main "master" acknowledge is not given
-- until all the ack_i inputs have been received.
--
-- This module does not implement a cycle timeout of any kind.  Therefore, if
-- any of the multiple requested cycles does not complete, the master cycle
-- will remain unacknowledged, and it can "hang" forever in this state.  You
-- have been warned!
--
-- This is a "dataflow" unit in the sense that asserting req_i immediately
-- asserts the req_o signals, without any clock delays.  The acknowledge
-- ack_i inputs do not, however, immediately deassert the req_o outputs.
-- Instead, the req_o outputs are deasserted after one clock cycle.
--
-- Isn't that just as "clear as mud?"
--
-- The sys_rst_n input is an asynchronous reset.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity bus_requester_N_way is
    generic(
      N_VALUE : integer := 2 -- Number of bus requestors.
    );
    port (
      -- System Clock and Clock Enable
      sys_rst_n   : in  std_logic;
      sys_clk     : in  std_logic;
      sys_clk_en  : in  std_logic;

      -- Single "master" Bus Access Request and acknowledge
      req_i       : in  std_logic;
      ack_o       : out std_logic;

      -- A multiplicity of subordinate bus requests
      n_req_o     : out unsigned(N_VALUE-1 downto 0);
      
      -- A multiplicity of subordinate Bus Access Acknowledge signals
      n_ack_i     : in  unsigned(N_VALUE-1 downto 0)

    );
end bus_requester_N_way;

architecture beh of bus_requester_N_way is

  -- Constants

  -- Functions & associated types

  -- Signal Declarations
  signal req_l    : unsigned(N_VALUE-1 downto 0);
  signal req_msk  : unsigned(N_VALUE-1 downto 0);

begin

process (sys_clk, sys_clk_en, sys_rst_n)
variable k : integer := 0;
begin
  if (sys_rst_n='0') then
    req_l      <= (others=>'1');
  elsif (sys_clk'event and sys_clk='1') then
    if (sys_clk_en='1') then
      -- Clear internal request bits when acknowledged
      for k in 0 to N_VALUE-1 loop
        if (n_ack_i(k)='1') then
          req_l(k) <= '0';
        end if;
      end loop;
      -- Reset the internal request bits
      if (req_i='0') then
        req_l <= (others=>'1');
      end if;
    end if; -- sys_clk_en
  end if; -- sys_clk
end process;

n_req_gen : for i in 0 to N_VALUE-1 generate
  n_req_o(i) <= '1' when req_i='1' and req_l(i)='1' else '0';
end generate n_req_gen;

-- The masked version of req_l proleptically reflects the request
-- bits which are about to be cleared.
req_msk <= req_l and (not n_ack_i);

ack_o <= '1' when req_i='1' and req_msk=0 else '0';

end beh;


