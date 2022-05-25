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
--  file: ow_temp.vhd
--  description: configures each ds1820 device, starts a conversion on each device, or reads the results
--    of each device. temps are set to 10 bit to shorten conversion times (and who needs 1/16 C resolution
--    when the accuracy is +-0.5C ). The temperatures are output on a bus with a strobe and a device index.
-----------------------------
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
--use work.p_ow_types.all;

-------------------------------------------------------------------------------------
-- Entity declaration
-------------------------------------------------------------------------------------
entity ow_temp is
  generic (
	  BITS : integer := 12;
    DEFTEMP : std_logic_vector(11 downto 0) := x"7ff";
    CRC : boolean := false
    );
  port (
    --global signals
	  clk              : in    std_logic;
    srst             : in    std_logic;
    busyin           : in    std_logic;  --busy signal from either ow_byte or ow_bit
    --signals to upper layer hierarchy
	  init             : in    std_logic; --init a device for temp reading
    conv             : in    std_logic; --send convert command to the device
    read             : in    std_logic; --read a device
    temp             : out   signed(15 downto 0);  --current device temp
    tempidx          : out   unsigned(4 downto 0); --current device index
    tempstb          : out   std_logic; --stobe indicating a temperature output
    busy             : out   std_logic;  --busy indication to higher level modules
		error            : out   std_logic;  --indicates a problem on the bus
    --signals to lower layer hierarchy (ow_bit and ow_byte)
    zzbit            : out   std_logic;  --reset strobe to ow_bit interface
    wrbit            : out   std_logic;  --write strobe to ow_bit interface
    ibit             : in    std_logic;  --the data read from the ow_bit interface
    obit             : out   std_logic;  --the data written to the ow_bit interface
	  rdbyte           : out   std_logic;  --read strobe to ow_byte interface
    wrbyte           : out   std_logic;  --write strobe to ow_byte interface
    obyte            : out   std_logic_vector(7 downto 0);  --data to write to the ow_byte
    ibyte            : in    std_logic_vector(7 downto 0);  --data read from the ow_byte
    --interface to id ram
    id_num           : out   std_logic_vector(4 downto 0); --index of the id to read or write
    id_bit           : out   std_logic_vector(5 downto 0); --index of the bit to read or write
    id_rbit          : in    std_logic  --bit value of the currently indexed bit of the current rom
  );
end ow_temp;

-------------------------------------------------------------------------------------
-- Architecture declaration
-------------------------------------------------------------------------------------
architecture rtl of ow_temp is
  
	type   t_state_type is (T_IDLE, T_GETTYPE, T_TXID, T_RST, T_TXTOUT, T_TXTOUT2, T_ERROR,
                          T_INIT, T_INIT1, T_INIT2, T_INIT3, T_INIT4,
                          T_CONV, T_CONV1, T_CONV2, T_CONV3, T_CONV4,
                          T_READ, T_READ1, T_READ2, T_READ3, T_READ4, T_READ5, T_READ6, T_READ7
                          );
  signal t_state : t_state_type := T_IDLE;
  signal t_next : t_state_type := T_IDLE;
	
	type slv8ary is array (integer range <>) of std_logic_vector(7 downto 0);
  
	constant ROMSTR  : integer := 1;
	constant ROMTXT : std_logic_vector( 7 downto 0) :=  x"55";
	constant ROMTXTLEN : integer := 1;
  constant INITSTR : integer := 2;
	constant INITTXT : slv8ary(1 to 4) := ( x"4e",x"7f",x"80",x"3f");
	constant INITTXTLEN : integer := INITTXT'length;
  constant CONVSTR : integer := 3;
	constant CONVTXT : std_logic_vector( 7 downto 0) := x"44";
	constant CONVTXTLEN : integer := 1;
  constant READSTR : integer := 4;
	constant READTXT : std_logic_vector( 7 downto 0) := x"be";
	constant READTXTLEN : integer := 1; --READTXT'length;
  constant LASTSTR : integer := READSTR;
  
  constant DS1822 : std_logic_vector(7 downto 0) := x"28";

  signal txtlen  : integer range 1 to 4;
  signal txtstr : integer range 1 to LASTSTR;
  signal txtptr : integer range 1 to 4;
  signal txbyte : std_logic_vector(7 downto 0);
  
  signal ididx    : integer range 0 to 31; --idx of the current device
	signal t_err    : std_logic := '0';
	signal irdbyte  : std_logic := '0';
	signal iwrbyte  : std_logic := '0';
	signal izzbit   : std_logic := '0';
  signal iwrbit   : std_logic := '0';
  --signal iobit    : std_logic := '0';

  signal readbits : integer range 1 to 10;
  signal shift    : std_logic_vector(15 downto 0);
  signal bytecnt  : integer range 0 to 9;
  signal bitcnt   : integer range 0 to 63;
  signal curid    : std_logic_vector(71 downto 0);

  signal stall : std_logic := '0'; -- this signal is used to stall the state machine one clock after each action

	
  --attribute mark_debug : string;
  --attribute mark_debug of pulse_state : signal is "true";
  --attribute mark_debug of timer : signal is "true";
  
  
begin
  ------------------------------------------------------
  --      TX MUX - mux between output commands       ---
  ------------------------------------------------------
  --select the byte to transmit from the text strings or the rom value
	txbyte <= CONVTXT when txtstr = CONVSTR  else READTXT when txtstr = READSTR
	        else ROMTXT when txtstr = ROMSTR else INITTXT(txtptr);
	txtlen <= CONVTXTLEN when txtstr = CONVSTR  else READTXTLEN when txtstr = READSTR
                  else ROMTXTLEN when txtstr = ROMSTR else INITTXTLEN;
	
  ------------------------------------------------------
  --      P_TEMP - INIT, CONV, READ temp sensors     ---
  ------------------------------------------------------
  --p_temp - sends rom match command followed by init command, convert command or 
  --         read command to the targeted temp sensor and reads data back (if a read command)
  p_temp : process (clk)
  begin
    if rising_edge(clk) then
      if srst = '1' then
        tempstb <= '0';
        t_state <= T_IDLE;
				t_err <= '0';
				izzbit <= '0';
        iwrbit <= '0';
        irdbyte <= '0';
        iwrbyte <= '0';
        ididx <= 0;
        bytecnt <= 0;
        bitcnt <= 0;
      elsif stall = '1' then
        tempstb <= '0';
        iwrbit <= '0';
        izzbit <= '0';
        iwrbyte <= '0';
        irdbyte <= '0';
        stall <= '0';
      else
          --allow 1 extra clock for ram read, temperature conversions
          --  but not when idle or we will miss the triggers
        if t_state /= T_IDLE then
          stall <= '1';
        end if;
        case t_state is
					when T_IDLE =>
            tempstb <= '0';
            obyte <= x"00";
            --shift <= x"000000000000000000";
            shift <= x"0000";
 				    izzbit <= '0';
            irdbyte <= '0';
            iwrbyte <= '0';
            izzbit <= '0';
            ididx <= 0;
            --shift <= x"00" & ids(ididx);
            --idtype <= x"00";
            bytecnt <= 0;
            bitcnt <= 0;
						if init = '1' then
              t_state <= T_GETTYPE;
              t_next <= T_INIT;
							t_err <= '0';
            elsif conv = '1' then
              t_state <= T_GETTYPE;
              t_next <= T_CONV;
              t_err <= '0'; 
            elsif read = '1' then
              t_state <= T_GETTYPE;
              t_next <= T_READ;
              t_err <= '0';
            end if;
          when T_GETTYPE =>
            --get the device type from the idrom
            shift(7 downto 0) <= id_rbit & shift(7 downto 1);
            if bitcnt = 7 then
              bitcnt <= 0;
              t_state <= t_next;
            else
              bitcnt <= bitcnt + 1;
            end if;
          when T_TXID =>
            if busyin = '0' then
              iwrbit <= '1';
              if bitcnt = 63 then
                t_state <= t_next;
                bitcnt <= 0;
              else
                bitcnt <= bitcnt + 1;
              end if;
            end if;
          when T_INIT =>
            if busyin = '0' then
              if shift(7 downto 0) = DS1822 then
                t_state <= T_RST;
                t_next <= T_INIT1;
                izzbit <= '1';
              else
                t_state <= T_INIT4;
              end if;
            end if;
          when T_INIT1 =>
            txtptr <= 1;
            txtstr <= ROMSTR;
            t_state <= T_TXTOUT;
            t_next <= T_INIT2;
          when T_INIT2 =>
            t_state <= T_TXID;
            t_next <= T_INIT3;
					when T_INIT3 =>
            txtptr <= 1;
            txtstr <= INITSTR;
            t_state <= T_TXTOUT;
            t_next <= T_INIT4;
					when T_INIT4 =>
            if ididx = 31 then
              t_state <= T_IDLE;
            else
              ididx <= ididx + 1;
              t_state <= T_GETTYPE;
              t_next <= T_INIT;
            end if;
          when T_CONV =>
            --this state cycles through all devices and initiates a conversion on all ds1822s
            if busyin = '0' then
              if shift(7 downto 0) = DS1822 then
                t_state <= T_RST;
                t_next <= T_CONV1;
                izzbit <= '1';
              else
                t_state <= T_CONV4;
              end if;
            end if;
          when T_CONV1 =>
            txtptr <= 1;
            txtstr <= ROMSTR;
            t_state <= T_TXTOUT;
            t_next <= T_CONV2;
          when T_CONV2 =>
            t_state <= T_TXID;
            t_next <= T_CONV3;
          when T_CONV3 =>
            txtptr <= 1;
            txtstr <= CONVSTR;
            t_state <= T_TXTOUT;
            t_next <= T_CONV4;
					when T_CONV4 =>
            if ididx = 31 then
              t_state <= T_IDLE;
            else
              ididx <= ididx + 1;
              t_state <= T_GETTYPE;
              t_next <= T_CONV;
            end if;
          when T_READ =>
            --this state cycles through all devices and reads all ds18B20s
            if busyin = '0' then
              if shift(7 downto 0) = DS1822 then
                t_state <= T_RST;
                t_next <= T_READ1;
                izzbit <= '1';
              else
                t_state <= T_READ7;
              end if;
            end if;
          when T_READ1 =>
            txtptr <= 1;
            txtstr <= ROMSTR;
            t_state <= T_TXTOUT;
            t_next <= T_READ2;
          when T_READ2 =>
            t_state <= T_TXID;
            t_next <= T_READ3;
          when T_READ3 =>
            txtptr <= 1;
            txtstr <= READSTR;
            t_state <= T_TXTOUT;
            t_next <= T_READ4;
            bytecnt <= 0;
          when T_READ4 =>
            if busyin = '0' then
              irdbyte <= '1';
              bytecnt <= 0;
              t_state <= T_READ5;
            end if;
          when T_READ5 =>
            --this state cycles through the 9 bytes to read
            if busyin = '0' then
              --if  CRC = true then
              --  shift <= ibyte & shift(71 downto 8);
              --else
              --  shift <= x"00000000000000" & ibyte & shift(15 downto 8);
              --end if;
              shift <= ibyte & shift(15 downto 8);
              if (bytecnt = 1 and CRC = false) or (bytecnt = 9 and CRC = true) then
                t_state <= T_READ6;
              else
                bytecnt <= bytecnt + 1;
                irdbyte <= '1';
              end if;
            end if;
					when T_READ6 =>
            tempstb <= '1';
            t_state <= T_READ7;
					when T_READ7 =>
            tempstb <= '0';
            if ididx = 31 then
              t_state <= T_IDLE;
            else
              ididx <= ididx + 1;
              t_state <= T_GETTYPE;
              t_next <= T_READ;
            end if;
          when T_RST =>
            if busyin = '0' then
              if ibit = '1' then
                t_state <= T_ERROR;
              else
                t_state <= t_next;
              end if;
            end if;
          when T_TXTOUT =>
            if busyin = '0' then
              --if txtstr = ROMSTR and txtptr > 1 then
              --  obyte <= shift(7 downto 0);
              --  shift <= shift(7 downto 0) & shift(71 downto 8);
              --else
                obyte <= txbyte;
              --end if;
              iwrbyte <= '1';
              t_state <= T_TXTOUT2;
            end if;
          when T_TXTOUT2 =>
            iwrbyte <= '0';
            if txtptr = txtlen then
              t_state <= t_next;
              txtptr <= 1;
            else
              txtptr <= txtptr + 1;
              t_state <= T_TXTOUT;
            end if;
					when T_ERROR =>
						t_err <= '1';
						t_state <= T_IDLE;
				end case;
			end if;
    end if;
  end process p_temp;
	
  ------------------------------------------------------
  --                External Signals                 ---
  ------------------------------------------------------

	temp <= signed(shift(15 downto 0));
	tempidx <= to_unsigned(ididx,5);
						  
  busy <= '0' when t_state = T_IDLE and conv = '0' and init = '0' and read = '0' else '1';  
  wrbyte <= iwrbyte;
  rdbyte <= irdbyte;
  zzbit <= izzbit;
  wrbit <= iwrbit;
  obit <= id_rbit;
  id_num <= std_logic_vector(to_unsigned(ididx,5));
  id_bit <= std_logic_vector(to_unsigned(bitcnt,6));

  error <= t_err;  
    
end rtl;
