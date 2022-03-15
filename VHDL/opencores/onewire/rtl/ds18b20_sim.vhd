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
--  file: ds18b20_sim.vhd
--  description: A simulation model for the DS18B20 temperature probe
--
--  Generics are used to set the device ID, the NVROM, and the timing model
--  inputs are used to set the temperature to report back
--
--  This only simulates the SEARCH, ROM, SKIP, CONFIG, CONV, and READ commands
--  save and recall to/from EEPROM were started, but not tested
--  it is not a complete model. It does not validate timing.
-----------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-------------------------------------------------------------------------------------
-- Entity declaration
-------------------------------------------------------------------------------------
entity ds18b20_sim is
  generic (
    timing : in string := "ave";
    devid  : in std_logic_vector(63 downto 0) := x"0000000000000128";
    nvrom  : in std_logic_vector(23 downto 0) := x"3f0064"
    );
  port (
    --global signals
	  pwrin            : in    std_logic; --tie to '1' if power provided, '0' if using parasitic power
	  tempin           : in    real;
    dio              : inout std_logic  --synchronous reset
  );
end ds18b20_sim;


--library unisim;
--use unisim.vcomponents.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
library work;

architecture sim of ds18b20_sim is

  --low time to trigger a reaset
  constant tmin_rstl : time := 240 us;
  constant tave_rstl : time := 400 us;
  constant tmax_rstl : time := 480 us;
  signal trstl : time := tmin_rstl;
  --high time between reset pulse and presence pulse
  signal tpdih : time;
  constant tmin_pdih : time := 15 us;
  constant tave_pdih : time := 45 us;
  constant tmax_pdih : time := 60 us;
  --presence pulse low time
  signal tpdlo : time;
  constant tmin_pdlo : time := 60 us;
  constant tave_pdlo : time := 180 us;
  constant tmax_pdlo : time := 240 us;
  --write 0 low time
  signal tlow0 : time;
  constant tmin_low0 : time := 60 us;
  constant tave_low0 : time := 100 us;
  constant tmax_low0 : time := 120 us;
  --write 1 low time
  signal tlow1 : time;
  constant tmin_low1 : time := 1 us;
  constant tave_low1 : time := 10 us;
  constant tmax_low1 : time := 15 us;
  --master write data sample time
  signal tsamp : time := 1 us;
  constant tmin_samp : time := 15 us;
  constant tave_samp : time := 30 us;
  constant tmax_samp : time := 60 us;
  --slave read recovery time
  signal trec : time := 1 us;
  constant tmin_rec : time := 1 us;
  constant tave_rec : time := 3 us;
  constant tmax_rec : time := 6 us;
  --slave read data valid time
  signal trdv : time := 15 us;
  constant tmin_rdv : time := 15 us;
  constant tave_rdv : time := 30 us;
  constant tmax_rdv : time := 60 us;

  --recall from eeprom timing
  --note: dallas part does not spec this timing
  signal trecall : time := 100 us;

  --convert time
  signal tconv : time := 15 us;
  signal tconv9 : time := 15 us;
  constant tmax_conv9 : time := 93.75 us;
  constant tave_conv9 : time := tmax_conv9 * 2/3;
  constant tmin_conv9 : time := tmax_conv9 * 1/2;
  signal tconv10 : time := 15 us;
  constant tmax_conv10 : time := 93.75 us;
  constant tave_conv10 : time := tmax_conv10 * 2/3;
  constant tmin_conv10 : time := tmax_conv10 * 1/2;
  signal tconv11 : time := 15 us;
  constant tmax_conv11 : time := 93.75 us;
  constant tave_conv11 : time := tmax_conv11 * 2/3;
  constant tmin_conv11 : time := tmax_conv11 * 1/2;
  signal tconv12 : time := 15 us;
  constant tmax_conv12 : time := 93.75 us;
  constant tave_conv12 : time := tmax_conv12 * 2/3;
  constant tmin_conv12 : time := tmax_conv12 * 1/2;
  signal tcopy : time := 1 us;
  constant tmax_copy : time := 10 ms;
  constant tave_copy : time := 2 ms;
  constant tmin_copy : time := 1 ms;

  signal clk10m   : std_logic;
  signal rstdet   : std_logic := '0';  --indicates a detected a reset pulse from the master
  signal trise : time := now;
  signal tfall : time := now;
  signal rstdly : std_logic := '1';
  --signal tdif : time;
  signal timertime : time;
  signal timer : unsigned(15 downto 0);
  signal timertrig : std_logic := '0';
  signal timerdone : std_logic := '1';


  type state_type is (S_IDLE, S_RSTRESP,S_RSTRESP2,S_RSTRESP3,
        S_GETBYTE, S_GETBYTE2, S_PARSE,
        S_READROM, S_READROM2, S_SRCHROM, S_SRCHROMNOT, S_SRCHROMWR,
        S_MATCHROM, S_MATCHROM2, S_SRCHALARM, S_SKIPROM,
        S_PARSE2, S_CONV, S_COPY, S_WRITE1, S_WRITE2, S_WRITE3,
        S_READ, S_READRCVR, S_CRC, S_RECALL, S_RDPWR,
        S_START, S_MID, S_END);
  signal state : state_type := S_IDLE;
  signal nxt_state : state_type := S_IDLE;
  signal dout : std_logic := 'Z'; --read output bit from slave to master
  signal rstdout : std_logic := '1'; --read output bit from main process
  signal recalldout : std_logic := '1'; --read output bit from recall process
  signal copydout : std_logic := '1'; --read output bit from copy process
  signal convdout : std_logic := '1'; --read output bit from conv process
  signal readdout : std_logic := '1'; -- output data from read state machine
  signal din   : std_logic := '1'; --resolved input data bit
  --signal rstout : std_logic := 'Z';
  signal bitcnt : integer;
  signal shiftbyte : std_logic_vector(7 downto 0);
  signal shiftid : std_logic_vector(63 downto 0);
  signal busy : std_logic := '0';

  --These signals are for the read state machine
  signal bitout   : std_logic := '1';  --bit value to be read by master
  signal wrbitin : std_logic := '0'; -- the bit value written by the master
  signal wrbiterr : std_logic := '0'; -- indicates a master write pulse with an illegal timing
  signal writedet : std_logic := '0'; -- strobe indicating the master wrote a bit
  signal readen   : std_logic := '0'; --enables the slave responses to the master read pulses
  signal readdet : std_logic := '0'; -- strobe indicating the master read a bit
  signal readdly : std_logic := '0'; -- delayed version of din for detecting read strobes
  signal readbit : std_logic := '0'; -- data to output from read state machine
  --signal readbit : std_logic := '0'; -- bit to drive the read output

  signal res : integer range 9 to 12; --high alram value in volatile mem
  signal alarmhi : std_logic := '0';
  signal alarmlo : std_logic := '0';
  signal trighi : std_logic_vector(7 downto 0) := nvrom(7 downto 0);
  signal triglo : std_logic_vector(7 downto 0) := nvrom(15 downto 8);
  --signal temp : std_logic_vector(15 downto 0); --last temperature conversion
  signal slvtemp : std_logic_vector(15 downto 0) := x"0190"; --the temperature read from device, default to 25C
  signal config : std_logic_vector(7 downto 0) := nvrom(23 downto 16);
  signal convtrig : std_logic := '0';
  signal convdone : std_logic := '1';
  signal copytrig : std_logic := '0';
  signal copydone : std_logic := '1';
  signal recalltrig : std_logic := '0';
  signal recalldone : std_logic := '1';
  signal eeprom : std_logic_vector(23 downto 0) := nvrom;
  signal scratch : std_logic_vector(63 downto 0) := x"1000ff" & nvrom & x"0000";

  signal crc : std_logic_vector(7 downto 0);
begin
  trstl <= tmin_rstl when timing = "MIN" else tave_rstl when timing = "AVE" else tmax_rstl;
  tpdih <= tmin_pdih when timing = "MIN" else tave_pdih when timing = "AVE" else tmax_pdih;
  tpdlo <= tmin_pdlo when timing = "MIN" else tave_pdlo when timing = "AVE" else tmax_pdlo;
  tsamp <= tmin_samp when timing = "MIN" else tave_samp when timing = "AVE" else tmax_samp;
  trdv <= tmin_rdv when timing = "MIN" else tave_rdv when timing = "AVE" else tmax_rdv;
  tconv9 <= tmin_conv9 when timing = "MIN" else tave_conv9 when timing = "AVE" else tmax_conv9;
  tconv10 <= tmin_conv10 when timing = "MIN" else tave_conv10 when timing = "AVE" else tmax_conv10;
  tconv11 <= tmin_conv11 when timing = "MIN" else tave_conv11 when timing = "AVE" else tmax_conv11;
  tconv12 <= tmin_conv12 when timing = "MIN" else tave_conv12 when timing = "AVE" else tmax_conv12;
  tconv <= tconv9 when res = 9 else tconv10 when res=10 else tconv11 when res = 11 else tconv12;
  tcopy <= tmin_copy when timing = "MIN" else tave_copy when timing = "AVE" else tmax_copy;
  --rstdly <= dio after trstl;
  --rst <= '1' when rstdly = '0' and dio = '0' else '1';

  res <= 9 + to_integer(unsigned(config(6 downto 5)));

  p_clk10m : process
  begin
    clk10m <= '0';
    wait for 50 ns;
    clk10m <= '1';
    wait for 50 ns;
  end process;

  p_edges : process
  begin
    wait until din = '0';
    tfall <= now;
    wait until din = '1';
    trise <= now;
  end process;


  --this handles the master reseting this slave
  rstdly <= transport din after trstl;

  p_rst : process
  begin
    wait until rstdly = '0';
    --if last transition was falling edge and it was long ago...
    if tfall > trise and now - tfall >= trstl then
      rstdet <= '1';
      wait until din <= '1';
      rstdet <= '0';
    end if;
  end process;

  --p_readstb and p_read - work together to facilitate a read
  --  readen is set high to enable a read, then if din is low for 1 us the readdet signal triggers
  --  which causes readout to be driven low for a bit time if shift(0) is low
  --  after the bit time expires, din returns high, causing readdet to go low, and cycle is complete
  readdly <= transport din after 1us;
  p_readstb : process
  begin
    wait until readdly = '0';
    if tfall > trise and now - tfall >= 1us and readen = '1' then
      readdet <= '1';
      wait until din <= '1';
      readdet <= '0';
    end if;
  end process;

  p_read : process
  begin
    wait until readdet = '1' and readen = '1';
    readdout <= readbit;
    wait for trdv;
    readdout <= '1';
  end process;

  --this handles the master writing bits to this slave
  p_write : process
  begin
    wait until din = '1';
    --dont detect writes during read operations
    if readen = '0' and readdet = '0' then
      if now - tfall > tmin_low0 and now-tfall < tmax_low0 then
        wrbitin <= '0';
        writedet <= '1';
        wrbiterr <= '0';
      elsif now - tfall > tmin_low1 and now-tfall < tmax_low1 then
        wrbitin <= '1';
        writedet <= '1';
        wrbiterr <= '0';
      elsif now - tfall < trstl then
        wrbiterr <= '1';
      end if;
    end if;
    wait until din = '0';
    writedet <= '0';
  end process;


  p_timer : process(clk10m)
  begin
    if rising_edge(clk10m) then
      if timertrig = '1' then
        timer <= to_unsigned(integer(timertime/100 ns),16);
        timerdone <= '0';
      elsif timer > 1 then
        timer <= timer -1;
      else
        timerdone <= '1';
      end if;
    end if;
  end process;

  --this handles the master reading a bit from this slave
  --dout <= '0' when rdbiten = '1' and dout = '0' and now-tfall < trdv else '1';

  p_state :process(clk10m)
  begin
    if rising_edge (clk10m) then
      if rstdet = '1' then
        state <= S_RSTRESP;
        rstdout <= '1';
        readen <= '0';
      else
        case state is
          when S_IDLE =>
            rstdout <= '1';
            readen <= '0';
            bitcnt <= 0;
            convtrig <= '0';
            copytrig <= '0';
            recalltrig <= '0';
            shiftbyte <= x"00";
            shiftid <= devid;
          when S_RSTRESP =>
            readen <= '0';
            bitcnt <= 0;
            rstdout <= '1';
            shiftbyte <= x"00";
            shiftid <= devid;
            if timertrig = '0' and din = '1' then
              timertime <= tpdih;
              timertrig <= '1';
            elsif timertrig = '1' then
              timertrig <= '0';
              state <= S_RSTRESP2;
            end if;
          when S_RSTRESP2 =>
            if timertrig = '0' and timerdone = '1' then
              rstdout <= '0';
              timertime <= tpdlo;
              timertrig <= '1';
            elsif timertrig = '1' then
              timertrig <= '0';
              state <= S_RSTRESP3;
            end if;
          when S_RSTRESP3 =>
            if timerdone = '1' then
              rstdout <= '1';
              state <= S_GETBYTE;
              nxt_state <= S_PARSE;
            end if;
          when S_GETBYTE =>
            if writedet = '0' then
              state <= S_GETBYTE2;
            end if;
          when S_GETBYTE2 =>
            if writedet  = '1' then
              shiftbyte <= wrbitin & shiftbyte(7 downto 1);
              if bitcnt < 7 then
                bitcnt <= bitcnt + 1;
                state <= S_GETBYTE;
              else
                bitcnt <= 0;
                state <= nxt_state;
              end if;
            end if;
          when S_PARSE =>
            shiftid <= devid;
            case shiftbyte is
              when x"33" =>         --read the rom id from the device, can only be used on single device bus
                state <= S_READROM;
              when x"55" =>         --match rom, used to address a single device on the bus
                state <= S_MATCHROM;
              when x"F0" =>         --use to find the devices on a multiple device bus
                state <= S_SRCHROM;
              when x"EC" =>         --search alarm, used to find devices that have active alarms
                if alarmhi = '1' or alarmlo = '1' then
                  state <= S_SRCHROM;
                else
                  state <= S_IDLE;
                end if;
              when x"CC" =>         --skip rom, skips rom addressing, for single device busses or broadcast commands
                state <= S_GETBYTE;
                nxt_state <= S_PARSE2;
              when others =>
                state <= S_IDLE;
            end case;
          when S_READROM =>
            readen <= '1';
            if readdet = '1' then
              shiftid <= shiftid(0) & shiftid(63 downto 1);
              if bitcnt < 55 then
                bitcnt <= bitcnt + 1;
                state <= S_READRCVR;
                nxt_state <= S_READROM;
              else
                state <= S_CRC;
                nxt_state <= S_READROM2;
                shiftid <= x"00000000000000" & crc;
              end if;
            end if;
          when S_READROM2 =>
            state <= S_GETBYTE;
            nxt_state <= S_PARSE2;
          when S_MATCHROM =>
            if writedet = '0' then
              state <= S_MATCHROM2;
            end if;
          when S_MATCHROM2 =>
            if writedet = '1' then
              if  wrbitin /= shiftid(0) then
                state <= S_IDLE;  --this part is removed from search, goto idle, wait for rstdet
              else
                shiftid <= shiftid(0) & shiftid(63 downto 1);
                if bitcnt < 63 then
                  bitcnt <= bitcnt + 1;
                  state <= S_MATCHROM;
                else
                  bitcnt <= 0;
                  state <= S_GETBYTE;
                  nxt_state <= S_PARSE2;
                end if;
              end if;
            end if;
          when S_SRCHROM =>
            readen <= '1';
            readbit <= shiftid(0);
            if readdet = '1' then
              state <= S_READRCVR;
              nxt_state <= S_SRCHROMNOT;
            end if;
          when S_SRCHROMNOT =>
            readen <= '1';
            readbit <= not shiftid(0);
            if readdet = '1' then
              state <= S_READRCVR;
              nxt_state <= S_SRCHROMWR;
            end if;
          when S_SRCHROMWR =>
            readen <= '0';
            if writedet = '1' then
              if  wrbitin /= shiftid(0) then
                state <= S_IDLE;  --this part is removed from search, goto idle, wait for rstdet
              else
                shiftid <= shiftid(0) & shiftid(63 downto 1);
                if bitcnt < 63 then
                  bitcnt <= bitcnt + 1;
                  state <= S_SRCHROM;
               else
                  bitcnt <= 0;
                  state <= S_GETBYTE;
                  nxt_state <= S_PARSE2;
                end if;
              end if;
            end if;
          when S_PARSE2 =>
            case shiftbyte is
              when x"44" =>           --convert temp
                convtrig <= '1';
                state <= S_CONV;
              when x"48" =>           --copy scratchpad to eeprom
                copytrig <= '1';
                state <= S_COPY;
              when x"4e" =>           --write scratchpad
                state <= S_GETBYTE;   --   data in order is Thi,Tlo,config
                nxt_state <= S_WRITE1;
              when x"be" =>           --read  scratchpad
                state <= S_READ;      --data in order is TempLSB,TempMSB,AlarmHi,AlarmLo,config,FF,00,F0,CRC
                shiftid <=  x"1000ff" & config & trighi & triglo & slvtemp;
                bitcnt <= 0;
              when x"b8" =>           --recall scratchpad from eeprom
                recalltrig <= '1';
                state <= S_RECALL;
              when x"b4" =>           --read the power bit to determine if parasitic;y powered
                state <= S_RDPWR;
              when others =>
                state <= S_IDLE;
            end case;
          when S_CONV =>
            if convtrig = '1' then
              convtrig <= '0';
            elsif convdone = '1' then
              state <= S_IDLE;
            end if;
          when S_COPY =>
            if copytrig = '1' then
              copytrig <= '0';
            elsif copydone = '1' then
              state <= S_IDLE;
            end if;
          when S_WRITE1 =>
            scratch(7 downto 0) <= shiftbyte;
            state <= S_GETBYTE;
            nxt_state <= S_WRITE2;
          when S_WRITE2 =>
            scratch(15 downto 8) <= shiftbyte;
            state <= S_GETBYTE;
            nxt_state <= S_WRITE3;
          when S_WRITE3 =>
            scratch(23 downto 16) <= '0' & shiftbyte(6 downto 5) & "11111";
            state <= S_IDLE;
          when S_RECALL =>
            if recalltrig = '1' then
              recalltrig <= '0';
            elsif recalldone = '1' then
              config <= eeprom(23 downto 16);
              trighi <= eeprom(15 downto 8);
              triglo <= eeprom(7 downto 0);
              state <= S_IDLE;
            end if;
          when S_READ =>
            readen <= '1';
            readbit <= shiftid(0);
            if readdet = '1' then
              shiftid <= shiftid(0) & shiftid(63 downto 1);
              if bitcnt < 63 then
                bitcnt <= bitcnt + 1;
                state <= S_READRCVR;
                nxt_state <= S_READ;
              else
                state <= S_CRC;
                nxt_state <= S_IDLE;
                bitcnt <= 0;
                shiftid <= x"00000000000000" & crc;
              end if;
            end if;
          when S_READRCVR =>
            readen <= '0';
            if readdet = '0' then
              state <= nxt_state;
            end if;
          when S_RDPWR =>
            readen <= '1';
            if readdet = '1' then
              state <= S_READRCVR;
              nxt_state <= S_IDLE;
            end if;
          when S_CRC =>
            readen <= '1';
            if readdet = '1' then
              shiftid <= shiftid(0) & shiftid(63 downto 1);
              if bitcnt < 7 then
                bitcnt <= bitcnt + 1;
                state <= S_READRCVR;
                nxt_state <= S_READ;
              else
                state <= S_READRCVR;
                nxt_state <= S_IDLE;
                bitcnt <= 0;
                shiftid <= x"00000000000000" & crc;
              end if;
            end if;
          when others =>
            state <= S_IDLE;
        end case;
      end if;
    end if;
	end process;

	p_crc : process
	begin
	  crc <= x"00";
	  wait until state = S_READ or state = S_READROM;
	    crc <= x"00";
	  while state = S_READ or state = S_READROM loop
	    wait until din = '0' or (state /= S_READ and state /= S_READROM);
	    if din = '0' then
	      if (crc(0) xor shiftid(0)) = '1' then
	        crc <= ('0' & crc(7 downto 1)) xor x"8c";
	      else
	        crc <= ('0' & crc(7 downto 1));
	      end if;
	    end if;
	  end loop;
	end process;


	p_convert : process
	  variable tstart : time := 0 us;
	begin
    convdout <= '1';
	  convdone <= '1';
	  wait until convtrig = '1';
	  convdone <= '0';
    tstart := now;
    while state = S_CONV loop
      assert (din = '1' or pwrin = '1') report "power fail during parasitic powered conversion"  severity error;
      wait for 1 us;
      if now - tstart > tconv then
        convdone <= '1';
	      if res = 9 then
          slvtemp <= std_logic_vector(to_signed(integer(tempin*2.0),13)) &"000";
        elsif res = 10 then
          slvtemp <= std_logic_vector(to_signed(integer(tempin*4.0),14)) &"00";
        elsif res = 11 then
          slvtemp <= std_logic_vector(to_signed(integer(tempin*8.0),15)) &'0';
        else
          slvtemp <= std_logic_vector(to_signed(integer(tempin*16.0),16));
        end if;
        if signed(slvtemp(11 downto 4)) < signed(trighi) then
          alarmhi <= '0';
        else
          alarmhi <= '1';
        end if;
        if signed(slvtemp(11 downto 4)) > signed(triglo) then
          alarmlo <= '0';
        else
          alarmlo <= '1';
        end if;
      elsif rstdet = '1' then
        convdone <= '1';
      elsif din = '0' and pwrin = '1' then
        --master is reading convert ready bit
        wait for 1 us;
        convdout <= '0';
        wait for trdv;
        convdout <= '1';
      end if;
    end loop;
  end process;

	p_copy : process
	 variable tstart : time := 0 us;
  begin
    copydout <= '1';
    wait until copytrig = '1';
    copydone <= '0';
    tstart := now;
    wait for 10 us;
    while state = S_COPY loop
      assert (din = '1' or pwrin = '1') report "power fail during parasitic powered copy to eeprom"  severity error;
      wait for 1 us;
      if now - tstart > tcopy then
        copydone <= '1';
        eeprom <= config & trighi & triglo;
      elsif rstdet = '1' then
        copydone <= '1';
      elsif din = '0' then
        --master is reading copy ready bit
        wait for 1 us;
        copydout <= '0';
        wait for trdv;
        copydout <= '1';
      end if;
    end loop;
  end process;



  p_recall : process
    variable tstart : time := 0 us;
  begin
    recalldout <= '1';
    wait until recalltrig = '1';
    recalldone <= '0';
    tstart := now;
    wait for 10 us;
    while state = S_RECALL loop
      assert (din = '1' or pwrin = '1') report "power fail during parasitic recall from eeprom"  severity error;
      wait for 1 us;
      if now - tstart > trecall then
        recalldone <= '1';
      elsif rstdet = '1' then
        recalldone <= '1';
      elsif din = '0' then
        --master is reading recall ready bit
        wait for 1 us;
        recalldout <= '0';
        wait for trdv;
        recalldout <= '1';
      end if;
    end loop;
  end process;

	din <= '0' when dio = '0' else '1';
	dout <= rstdout and copydout and convdout and recalldout and readdout;
	dio <= '0' when dout = '0' else 'Z';
	busy <= '0' when state = S_IDLE else '1';

end sim;
