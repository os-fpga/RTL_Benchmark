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
--  file: ow_search.vhd
--  description: searches a one wire bus for up to 8 one wire devices, and reports
--    the 8 IDs. If there are more than 8 IDs or if a device disapears during the
--    search it will activate the err flag. Only DS1820 devices are supported
--
-----------------------------------------------------------------------------------  

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-------------------------------------------------------------------------------------
-- Entity declaration
-------------------------------------------------------------------------------------
entity ow_search is
  port (
    --global signals
    clk              : in    std_logic;
    srst             : in    std_logic;
    --signals to upper layer hierarchy
    start            : in    std_logic;
    busyin           : in    std_logic;  --busy signal from either ow_byte or ow_bit
    busy             : out   std_logic;  --busy indication to higher level modules
    error            : out   std_logic;  --indicates a problem on the bus
    --signals to lower layer hierarchy (ow_bit and ow_byte)
    rdbit            : out   std_logic;  --strobe to read a bit from ow_bit
    wrbit            : out   std_logic;  --strobe to write a bit to ow_bit
    zzbit            : out   std_logic;  --strobe to send/recieve init/response pulses
    obit             : out   std_logic;  --the bit to write in a wrbit command to ow_bit
    ibit             : in    std_logic;  --the data recieved from a rdbit command to the ow_bit
    wrbyte           : out   std_logic;  --strobe to wrte a byte to ow_byte
    obyte            : out   std_logic_vector(7 downto 0);  --data to write to the ow_byte
    --interface to id ram
    id_num           : out   std_logic_vector(4 downto 0); --index of the id to read or write
    id_bit           : out   std_logic_vector(5 downto 0); --index of the bit to read or write
    id_rbit          : in    std_logic;  --bit value of the currently indexed bit of the current rom
    id_wbit          : out   std_logic;  --bit value to write to the currently indexed bit
    id_we            : out   std_logic   --write the currently indexed bit
  );
end ow_search;

-------------------------------------------------------------------------------------
-- Architecture declaration
-------------------------------------------------------------------------------------
architecture rtl of ow_search is


  type   h_state_type is (H_IDLE, H_RST, H_SKIP, H_READBIT, H_READCMP, H_PARSE, H_INCLOOP, H_FILL, H_ERROR);
  signal h_state : h_state_type := H_IDLE;
  type   f_state_type is (F_IDLE, F_FIND, F_INC);
  signal f_state : f_state_type := F_IDLE;

  signal idcnt : integer range 0 to 31;
  signal lastfork : integer range 0 to 63;
  signal lastzero : integer range 0 to 63;
  signal idbitnum : integer range 0 to 63;
	signal lastdev  : std_logic := '0';
	signal h_err    : std_logic := '0';
	signal f_err    : std_logic := '0';
	signal irdbit   : std_logic := '0';
  signal iwrbit   : std_logic := '0';
  signal iwe      : std_logic := '0';
  signal iobit    : std_logic := '0';
  signal iwrbyte  : std_logic := '0';
	signal izzbit   : std_logic := '0';
  signal rxpat    : std_logic_vector(1 downto 0);
	signal h_start  : std_logic := '0';
	signal restart  : std_logic := '0';
	signal h_busy   : std_logic := '0';

  constant scan_cmd  : std_logic_vector(7 downto 0) := x"f0";


  attribute mark_debug : string;
  attribute mark_debug of f_state : signal is "true";
  attribute mark_debug of h_state : signal is "true";
	attribute mark_debug of idbitnum  : signal is "true";
  attribute mark_debug of lastfork  : signal is "true";
  attribute mark_debug of lastzero  : signal is "true";
  attribute mark_debug of rxpat     : signal is "true";
  attribute mark_debug of iwrbyte   : signal is "true";
  attribute mark_debug of irdbit    : signal is "true";
  attribute mark_debug of iwrbit    : signal is "true";
  attribute mark_debug of iwe       : signal is "true";
  attribute mark_debug of iobit     : signal is "true";
  attribute mark_debug of id_rbit   : signal is "true";
  attribute mark_debug of obyte     : signal is "true";
  attribute mark_debug of lastdev     : signal is "true";
  attribute mark_debug of start     : signal is "true";
  attribute mark_debug of busyin     : signal is "true";

begin

  ------------------------------------------------------
  --    HUNT - search for the next device on bus     ---
  ------------------------------------------------------
  --p_hunt - hunts for the next device using the algorithm described in Maxim (Analog Devices) app note APP187
	-- the app note is modified slightly for optimization in VHDL
	-- "restart" resets all parameters to rediscover all ROM iDs
	-- "hunt" searches for the next ROM ID in the sort order
  p_hunt : process (clk)
  begin
    if rising_edge(clk) then
      if srst = '1' or restart = '1' then
        h_state <= H_IDLE;
        idbitnum  <= 0;
				lastfork <= 0;
				lastdev <= '0';
				rxpat   <= "00";
				h_err <= '0';
				iwrbyte <= '0';
				izzbit <= '0';
				irdbit <= '0';
				iwrbit <= '0';
				iwe <= '0';
				iobit <= '0';
 			  obyte <= x"00";
      else
        case h_state is
					when H_IDLE =>
						idbitnum  <= 0;
					  lastzero <= 0;
					  rxpat   <= "00";
					  iwrbyte <= '0';
					  irdbit <= '0';
					  iwrbit <= '0';
			      iwe <= '0';
            iobit <= '0';
            obyte <= x"00";
						if h_start = '1' then
						  if lastdev = '0' then
                h_state <= H_RST;
                izzbit <= '1';
                h_err <= '0';
              else
                h_state <= H_FILL;
                iwe <= '1';
                iobit <= '0';
              end if;
            else
              izzbit <= '0';
						end if;
					when H_RST =>
						if izzbit = '1' then
							izzbit <= '0';
						elsif busyin = '0' then
							if ibit = '1' then
								h_state <= H_ERROR;
							else
								obyte <= x"f0";
								iwrbyte <= '1';
								h_state <= H_SKIP;
							end if;
						end if;
					when H_SKIP =>
						if iwrbyte = '1' then
							iwrbyte <= '0';
						elsif busyin = '0' then
							irdbit <= '1';
							h_state <= H_READBIT;
						end if;
					when H_READBIT =>
						if irdbit = '1' then
							irdbit <= '0';
						elsif busyin = '0' then
							rxpat(1) <= ibit;
							irdbit <= '1';
					    h_state <= H_READCMP;
						end if;
					when H_READCMP =>
						if irdbit = '1' then
							irdbit <= '0';
						elsif busyin = '0' then
							rxpat(0) <= ibit;
							h_state <= H_PARSE;
						end if;
					when H_PARSE =>
						case rxpat is
							when "11" =>
								h_state <= H_ERROR;
							when "00" =>
								if idbitnum = lastfork then
									--last_romid(63 downto 0) <= last_romid(0) & last_romid(63 downto 1);
									--new_romid(63 downto 0) <= '1' & new_romid(63 downto 1);
									iobit <= '1';
    							iwrbit <= '1';
		              iwe <= '1';
									h_state <= H_INCLOOP;
								elsif idbitnum > lastfork then
									--last_romid(63 downto 0) <= last_romid(0) & last_romid(63 downto 1);
									--new_romid(63 downto 0) <= '0' & new_romid(63 downto 1);
                  iobit <= '0';
									iwrbit <= '1';
		              iwe <= '1';
									lastzero <= idbitnum;
									h_state <= H_INCLOOP;
								else
									--last_romid(63 downto 0) <= last_romid(0) & last_romid(63 downto 1);
									--new_romid(63 downto 0) <= last_romid(0) & new_romid(63 downto 1);
									iobit <= id_rbit;
									iwrbit <= '1';
		              iwe <= '1';
									if id_rbit = '0' then
										lastzero <= idbitnum;
									end if;
									h_state <= H_INCLOOP;
								end if;
							when others =>
								--last_romid(63 downto 0) <= last_romid(0) & last_romid(63 downto 1);
								--new_romid(63 downto 0) <= rxpat(1) & new_romid(63 downto 1);
								iobit <= rxpat(1);
								iwrbit <= '1';
		            iwe <= '1';
								h_state <= H_INCLOOP;
						end case;
					when H_INCLOOP =>
						if iwrbit = '1' or iwe = '1' then
						  iwrbit <= '0';
		          iwe <= '0';
						elsif busyin = '0' then
							if idbitnum = 63 then
								h_state <= H_IDLE;
								lastfork <= lastzero;
								if lastzero = 0 then
									lastdev <= '1';
								end if;
							else
								idbitnum <= idbitnum + 1;
								irdbit <= '1';
								h_state <= H_READBIT;
							end if;
						end if;
					when H_FILL =>
            if iwe = '1' then
              iwe <= '0';
            elsif idbitnum = 63 then
              h_state <= H_IDLE;
            else
              idbitnum <= idbitnum + 1;
              iobit <= '0';
              iwe <= '1';
            end if;
    			when others =>
						h_err <= '1';
						h_state <= H_IDLE;
				end case;
			end if;
    end if;
  end process p_hunt;

  h_busy <= '0' when h_state = H_IDLE and h_start = '0' else '1';

  ------------------------------------------------------
  --    FINDALL - find all devices, one by one       ---
  ------------------------------------------------------
  --p_findall - finds all (at least up to 8) of the roms on the bus
  -- this process initiates up to 8 searches, each finds the next device
  -- in the sorted (by device ID) order.
	p_findall : process(clk)
	begin
	  if rising_edge(clk) then
		  if srst = '1' then
			  idcnt <= 0;
				f_state <= F_IDLE;
				restart <= '0';
			else
			  case f_state is
				  when F_IDLE =>
					  if start = '1' then
						  restart <= '1';
					  elsif restart = '1' then
					    restart <= '0';
						  h_start <= '1';
							f_state <= F_FIND;
							idcnt <= 0;
							f_err <= '0';
						end if;
					when F_FIND =>
					  if h_start = '1' then
						  h_start <= '0';
						elsif h_busy = '0' then
						  if h_err = '1' then
							  f_state <= F_IDLE;
								f_err <= '1';
							else
								f_state <= F_INC;
							end if;
						end if;
					when F_INC =>
            if idcnt = 31 then
              idcnt <= 0;
              f_state <= F_IDLE;
            else
              idcnt <= idcnt + 1;
              f_state <= F_FIND;
              h_start <= '1';
            end if;
				end case;
			end if;
		end if;
	end process p_findall;

  ------------------------------------------------------
  --                External Signals                 ---
  ------------------------------------------------------

  id_num <= std_logic_vector(to_unsigned(idcnt,5));
  id_bit <= std_logic_vector(to_unsigned(idbitnum,6));
  id_we <= iwe;
  id_wbit <= iobit;

	rdbit <= irdbit;
	wrbit <= iwrbit;
	zzbit <= izzbit;
  obit <= iobit;
	wrbyte <= iwrbyte;

  busy <= '0' when f_state = F_IDLE and h_state = H_IDLE and start = '0' and restart = '0' else '1';
  error <= f_err;

end rtl;
