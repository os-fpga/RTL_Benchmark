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
--  file: onewire_mstr.vhd
--  description: reading and writing devies on a one wire bus
--
--  To simplify the design, there is a low level entity, ow_bit, that handles the
--  read/write/init bit patterns. There is also a byte level entity,
--  ow_byte, that operates on bytes by controlling the ow_bit entity.
--  Controllers of this module can use bit or byte accesses to the one wire bus. 
--  to execute both byte and bit level operations, it is necessary to mux the control
--  to the ow_bit interface to the various higher level functions.
-----------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-------------------------------------------------------------------------------------
-- Entity declaration
-------------------------------------------------------------------------------------
entity ow_mstr is
  port (
    --global signals
	  clk              : in    std_logic;
    srst             : in    std_logic;  --synchronous reset
    stb1us           : in    std_logic;  --1us strobe, used to time transactions
    busy             : out   std_logic;  --device is in middle of read,write or init
    --low level interfaces, used for micro processor control of bus
  	init_stb         : in    std_logic;  --sends an init/reset pulse to bus
  	wrbyte           : in    std_logic;  --write a byte to the bus
  	inbyte           : in    std_logic_vector(7 downto 0); --data byte to write
  	wrbit            : in    std_logic;  --write a single bit to the bus
  	inbit            : in    std_logic;  --data bit to write
  	rdbyte           : in    std_logic;  --read a byte from the bus
  	outbyte          : out   std_logic_vector(7 downto 0); --read byte
  	rdbit            : in    std_logic;  --read a single bit from the bus
  	outbit           : out   std_logic;  --read bit
    --one wire bus interface, requires external 5k resistor on bus
    owin              : in    std_logic;  --one wire input
  	owout             : out   std_logic   --one wire output
  );
end ow_mstr;

-------------------------------------------------------------------------------------
-- Architecture declaration
-------------------------------------------------------------------------------------
architecture rtl of ow_mstr is

  signal busyout   : std_logic;
  
  --bit module signals
  signal ow1_rbit  : std_logic;
  signal ow1_obit  : std_logic;
  signal ow1_wbit  : std_logic;
  signal ow1_ibit  : std_logic;
  signal ow1_zbit  : std_logic;
  signal ow1_busy  : std_logic;
  
  --byte module signals
  signal ow8_rbit  : std_logic;
  signal ow8_wbit  : std_logic;
  signal ow8_obit  : std_logic;
  signal ow8_busy  : std_logic;
   
begin
  -------------------------------------
  --        signal decoding         ---
  -------------------------------------
  -- the following signals are muxed with priorities, allowing ow8 or external control of the bit interface
  ow1_rbit <= ow8_rbit when ow8_busy = '1' else rdbit;
  ow1_wbit <= ow8_wbit when ow8_busy = '1' else wrbit;
	ow1_ibit <= ow8_obit when ow8_busy = '1' else inbit;
	ow1_zbit <= init_stb;
	
  -------------------------------------
  --            u_ow1               ---
  -------------------------------------
  --handles single bit read/write/reset of the one wire bus
  u_ow1 : entity work.ow_bit(rtl)
  port map(
    --globals
	  clk    => clk,
    srst   => srst,
    clken  => stb1us,
    --interface to higher level
	  rstb   => ow1_rbit,
    wstb   => ow1_wbit,
    istb   => ow1_zbit,
    din    => ow1_ibit,
    dout   => ow1_obit,
    busy   => ow1_busy,
	  --one wire bus
    owin   => owin,   --one wire input
    owout  => owout   --one wire output
 );
  
  -------------------------------------
  --            u_ow8               ---
  -------------------------------------
  u_ow8 : entity work.ow_byte(rtl)
  port map(
    --globals
	  clk    => clk,
    srst   => srst,
    --ow1 interface
  	rdbit  => ow8_rbit,
    wrbit  => ow8_wbit,
  	ibit   => ow1_obit,
  	obit   => ow8_obit,
    busyin => ow1_busy,
    --high level interface to owt,owi, or external
  	rdbyte => rdbyte,
    obyte  => outbyte,
    wrbyte => wrbyte,
    ibyte  => inbyte,
    busy   => ow8_busy
  );
     
	outbit <= ow1_obit;	
	busy <= ow8_busy or ow1_busy;
    
end rtl;
