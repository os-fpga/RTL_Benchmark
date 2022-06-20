----------------------------------------------------------------------------------
--  <c>2018 william b hunter
--    This file is part of ow2rtd.
--
--    ow2rtd is free software: you can redistribute it and/or modify
--    it under the terms of the GNU Lessor General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    ow2rtd is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU Lessor General Public License
--    along with ow2rtd.  If not, see <https://www.gnu.org/licenses/>.
-----------------------------------------------------------------------------------  
--  Create Date: 5/15/2018
--  file: onewire_bit.vhd
--  description: handles single bit transactions on the one wire bus
--  it is used by higher level entities to initialize, search, read, and write the one
--    wire devices on the one wire bus.
--  Each operation consists of a start, that is always low, middle, which for reads
--    represents the time for the slave to respond, and the end, which allows for
--    the slave to finish its operation and provides spacing between bit patterns.
--  For reads and resets, the data is sampled at the end of the mid time
--
-----------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
library work;

-------------------------------------------------------------------------------------
-- Entity declaration
-------------------------------------------------------------------------------------
entity ow_bit is
  port (
    --globals
    clk              : in    std_logic;
    srst             : in    std_logic;
    clken            : in    std_logic;
    --interface to higher level
    rstb             : in    std_logic;
    wstb             : in    std_logic;
    istb             : in    std_logic;
    din              : in    std_logic;
    dout             : out   std_logic;
    busy             : out   std_logic;
	--one wire bus
    owout            : out std_logic;   --one wire input
    owin             : in  std_logic    --one wire output
  );
end ow_bit;

-------------------------------------------------------------------------------------
-- Architecture declaration
-------------------------------------------------------------------------------------
architecture rtl of ow_bit is
  type pulse_state_type is (S_IDLE, S_START, S_MID, S_END); --, S_DONE
  signal pulse_state : pulse_state_type := S_IDLE;

  
  constant r_start  : unsigned(11 downto 0) := to_unsigned(5,12);    --low time
  constant r_mid    : unsigned(11 downto 0) := to_unsigned(10,12);   --high z until sample time
  constant r_end    : unsigned(11 downto 0) := to_unsigned(65,12);   --recovery time
  constant w_start  : unsigned(11 downto 0) := to_unsigned(5,12);    --low time
  constant w_mid    : unsigned(11 downto 0) := to_unsigned(65,12);   --dout time
  constant w_end    : unsigned(11 downto 0) := to_unsigned(10,12);   --recovery time
  constant rw_cnt   : unsigned(11 downto 0) := to_unsigned(1,12);    --number of samples for read or write
  constant i_start  : unsigned(11 downto 0) := to_unsigned(500,12);  --reset low time
  constant i_mid    : unsigned(11 downto 0) := to_unsigned(100,12);  --high z till sample time
  constant i_end    : unsigned(11 downto 0) := to_unsigned(220,12);  --recovery time till end of rst response
  constant i_cnt   : unsigned(3 downto 0) := to_unsigned(1,4);   --number of samples (i_end each) to wait for init response

  signal start_time : unsigned(11 downto 0);   -- low pulse time
  signal mid_time   : unsigned(11 downto 0);   -- high pulse time
  signal end_time   : unsigned(11 downto 0);   -- time between samples, or the last sample and the end
  --signal rd_count   : unsigned(4 downto 0) := to_unsigned(30,5);    -- number of read smaples for this bit 
  
  
  signal owo   : std_logic := '0';  --one wire output bit
  --signal owo2   : std_logic := '0';  --one wire output bit combined with one wire power
  --signal owi   : std_logic := '0';  --one wire input bit
  --signal owt   : std_logic := '0';  --one wire tristate, implements open collector bus
  signal wstb_cap   : std_logic := '0';  --captures and holds write requests
  signal rstb_cap   : std_logic := '0';  --captures and holds read requests
  signal istb_cap   : std_logic := '0';  --captures and holds init requests (reset/presence sequence)
  signal din_cap   : std_logic := '0';  --captures and holds input data
  signal pulse_end  : std_logic;
  signal busy_int   : std_logic;
  signal timer      : unsigned(11 downto 0) := x"000";   --used to time one wire bus transactions
  --signal rdcntr     : unsigned(4 downto 0);    --used to count samples in the read mode
  --signal owopwr     : std_logic;               --internal state of dout combined with power input
  signal samp       : std_logic;               --AND'ed value of owi samples

  attribute mark_debug : string;
  attribute mark_debug of pulse_state : signal is "true";
  attribute mark_debug of timer : signal is "true";
  attribute mark_debug of samp : signal is "true";
  attribute mark_debug of din : signal is "true";
  attribute mark_debug of dout : signal is "true";
  attribute mark_debug of rstb_cap: signal is "true";
  attribute mark_debug of wstb_cap : signal is "true";
  attribute mark_debug of istb_cap : signal is "true";  
  attribute mark_debug of busy_int : signal is "true";  
  attribute mark_debug of pulse_end : signal is "true";  
  
  
begin
  -------------------------------------
  --        strobe captures         ---
  -------------------------------------
  -- p_capstb - captures the pulse strobes, and clears then when the pulse is complete
  -- this is necessary if the clken is used because the strobes happen on the system clk and
  -- the pulse is timed by the stb1us. We need to hold the strobes throughout the pulse because the active
  -- strobe is used to zelect the timing for the pulse.
  p_capstb : process (clk)
  begin
    if rising_edge(clk) then
      if srst = '1' then
        rstb_cap <= '0';
        wstb_cap <= '0';
        istb_cap <= '0';
	      din_cap  <= '0';
      elsif busy_int = '0' then
        if rstb = '1' then
          rstb_cap <= '1';
        elsif wstb = '1' then
          wstb_cap <= '1';
	        din_cap  <= din;
        elsif istb = '1' then
          istb_cap <= '1';
        end if;
      elsif pulse_state = S_END then
        rstb_cap <= '0';
        wstb_cap <= '0';
        istb_cap <= '0';
	    din_cap  <= '0';
      end if;
    end if;
  end process p_capstb;

  -------------------------------------
  --        control muxing          ---
   -------------------------------------
 --busy_int indicates that a pulse is pending (one of the strobe captures is high) or the pulse is active
  busy_int <= '0' when rstb_cap = '0' and wstb_cap = '0' and istb_cap = '0' 
                   and pulse_state = S_IDLE
                   else '1';
  
  start_time <= w_start when wstb_cap = '1' else i_start when istb_cap = '1' else r_start;
  mid_time <= w_mid when wstb_cap = '1' else i_mid when istb_cap = '1' else r_mid;
  end_time <= w_end when wstb_cap = '1' else i_end when istb_cap = '1' else r_end;

      
  -------------------------------------
  --        pulse generator         ---
  -------------------------------------
  --p_pulse - generates the pulse, and if needed captures the read bit or read presence pulse
  -- all pulses consist of a start time, a middle time, and an end time.
  -- for read, write, and init, the start time is always low, and starts the timing for the pulse
  -- for a read or init, the middle time is used for the slave to react. data is sampled at the end of the mid time
  -- for the write, the middle time is where the actual data, zero or one, is output.
  -- the end time is used to space between pulses.
  --                    |start| middle |end|
  --     Write one   ----_____-------------
  --     Write zero  ----______________----
  --     read        ----_____xxxxxxxxx----
  --     init        ----_____---------____
  p_pulse : process (clk)
  begin
    if rising_edge(clk) then
      if srst = '1' then
        pulse_state <= S_IDLE;
        timer <= x"000";
        --rdcntr <= "00000";
        owo <= '1';
        samp <= '1';
      elsif clken = '1' then
        case pulse_state is
        when S_IDLE =>
          samp <= '1';
          if busy_int = '1' then
            pulse_state <= S_START;
            timer <= start_time;
            owo <= '0';
          end if;
        when S_START =>
          if timer > 0 then
            timer <= timer -1;
          else
            if wstb_cap = '1' then
		      	  owo <= din_cap;
		      	else
		      	  owo <= '1';
		      	end if;
            timer <= mid_time;
            pulse_state <= S_MID;
          end if;
        when S_MID =>
          if timer > 0 then
            timer <= timer -1;
          else
            samp <= owin;
            timer <= end_time;
            --rdcntr <= rd_count;
            pulse_state <= S_END;
		        owo <= '1';
          end if;
        when S_END =>
          if timer > 0 then
            timer <= timer -1;
           else
            pulse_state <= S_IDLE;
          end if; 
        --when S_DONE =>
        --  pulse_state <= S_IDLE;
        end case;
      end if;
    end if;
  end process p_pulse;
        
  dout <= samp; --this is the value read back from a read pulse or a reset pulse
  busy <= busy_int or rstb or wstb or istb;

  --The output is driven high when pwr = 1, otherwise is only driven low when owo is low
  owout <= owo;
      
end rtl;
