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
--  file: ow_byte.vhd
--  description:  handles read and write byte operations on the one wire bus
--
-----------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
library work;

-------------------------------------------------------------------------------------
-- Entity declaration
-------------------------------------------------------------------------------------
entity ow_byte is
  port (
    --globals
    clk              : in    std_logic;
    srst             : in    std_logic;
    --clken            : in    std_logic;
    --ow1 interface
    rdbit    : out std_logic; -- rd bit strobe
    wrbit    : out std_logic; -- wr bit strobe
    ibit     : in  std_logic; -- rd bit data
    obit     : out std_logic; -- wr bit data
    busyin   : in  std_logic; -- busy from the bit interface
    --high level interface to owt,owi, or external
    rdbyte   : in  std_logic; -- read byte strobe
    obyte    : out std_logic_vector(7 downto 0); -- result of the byte read
    wrbyte   : in  std_logic; -- write byte strobe
    ibyte    : in  std_logic_vector(7 downto 0); -- write data
    busy     : out std_logic -- busy signal the to external modules
   );
end ow_byte;

-------------------------------------------------------------------------------------
-- Architecture declaration
-------------------------------------------------------------------------------------
architecture rtl of ow_byte is
  type state_type is (S_IDLE, S_STROBE, S_SHIFT);
  signal state : state_type := S_IDLE;

  signal bitcnt : integer range 0 to 7 := 0; --counts the bytes during the transfer
  signal shift : std_logic_vector(7 downto 0); -- used to shift in and out data
  signal rdwr_n : std_logic; -- 1 for read, 0 for write
  signal irdbit : std_logic; -- internal state of rdbit strobe
  signal iwrbit : std_logic; -- internal state of wrbit strobe

  attribute mark_debug : string;
  attribute mark_debug of state : signal is "true";
  attribute mark_debug of rdwr_n : signal is "true";
  attribute mark_debug of shift : signal is "true";
  attribute mark_debug of bitcnt : signal is "true";
  attribute mark_debug of irdbit : signal is "true";
  attribute mark_debug of iwrbit : signal is "true";
  
begin
  -------------------------------------
  --           bit shifter          ---
  -------------------------------------
  -- p_shifty - shifts data in and out the shift register, and counts down bits
  p_shifty : process (clk)
  begin
    if rising_edge(clk) then
      if srst = '1' then
        shift <= (others => '0');
        bitcnt <= 0;
		    rdwr_n <= '1';
  		  irdbit <= '0';
        iwrbit<= '0';
		    state <= S_IDLE;
      else
  	    case state is
  		    when S_IDLE =>
  		      --wait for read byte or write byte strobe
  		      if busyin = '0' and (rdbyte = '1' or wrbyte = '1') then
  		        rdwr_n <= rdbyte;  --remember whether it was read or write
  		    	  shift <= ibyte;    --load the byte to shift out(not needed for read)
  		    	  bitcnt <= 0;       --set bit counter
  		        state <= S_STROBE;
  		      end if;
  		    when S_STROBE =>
  		      if irdbit = '0' and iwrbit = '0' then
  		        --if we havent started the read or write yet
  		        irdbit <= rdwr_n;      --read one bit if it is a read
  		    	  iwrbit <= not rdwr_n;  --write one bit if its a write
  		      else
  		        --if we are the bit operation has already started, clear the strobes
  		        irdbit <= '0';
  		    	  iwrbit<= '0';
  		    	  state <= S_SHIFT;
  		      end if;
  		    when S_SHIFT =>
  		      if busyin = '0' then  --wait for the bit operation to finish
  		        shift <= ibit & shift(7 downto 1); --shift the bit in or out
  		    	  if bitcnt = 7 then                 --check for last bit
  		    	    state <= S_IDLE;                 --return to idle when finished
  		    	  else
  		    	    bitcnt <= bitcnt +1;             --more bits to go, count down bits
  		    	    state <= S_STROBE;               --strobe the next bit operatoin
  		    	  end if;
  	        end if;
		    end case;
      end if;
    end if;
  end process p_shifty;
 
  -------------------------------------
  --           IO signals           ---
  -------------------------------------
 --copy the internal signals to the external ports
  rdbit <= irdbit;
  wrbit <= iwrbit;
  obit <= shift(0);  --the output bit to the ow_bit module
  obyte <= shift;    --the read byte after shifting in all bits
  busy <= '0' when state = S_IDLE and rdbyte = '0' and wrbyte = '0' else '1'; --if we are not idle we are busy
  
  
end rtl;
