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
--  file: ds1820_mstr.vhd
--  description: interfaces to the ds1820 devices on the one wire bus.
--  this includes discovering the devices, configuring them, and reading the temperatures
--
--  The design consists of the following major blocks:
--     ow_mstr - low level interface to the one wire bus including byte and bit accesses
--     ow_search - discovers devices on the one wire bus, both ds1820 types and others
--     ow_temp - configures the ds1820 devices on the bus and reads the temperatures
--     ow_idram - a ram for storing the 64 bit long device ids
-----------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-------------------------------------------------------------------------------------
-- Entity declaration
-------------------------------------------------------------------------------------
entity ds1820_mstr is
  port (
    --global signals
	  clk              : in    std_logic;
    srst             : in    std_logic;  --synchronous reset
    stb1us           : in    std_logic;  --1us strobe, used to time transactions
    busy             : out   std_logic;  --device is in middle of read,write or init
    err              : out   std_logic;  --something went wrong, this is cleared by next command
    --controls from upper level of hierarchy
  	search_stb       : in    std_logic;  --searches for devices on bus
    temp_init        : in    std_logic;  --starts initialization of all sensors
    temp_conv        : in    std_logic;  --starts temperature conversion on all sensors
    temp_read        : in    std_logic;  --starts temperature read from all sensors
    --response to upper level of hierarchy
    temp             : out   signed(15 downto 0); --temperature of the current sensor
    tempidx          : out   unsigned(4 downto 0); --index of the current temp sensor
    tempstb          : out   std_logic;                    --temperature available strobe
    --one wire bus interface
    owin             : in    std_logic;  --one wire input
    owout            : out   std_logic   --one wire output
    --dio             : inout std_logic
  );
end ds1820_mstr;

-------------------------------------------------------------------------------------
-- Architecture declaration
-------------------------------------------------------------------------------------
architecture rtl of ds1820_mstr is
  --bit module signals
  type s16ary is array (integer range <>) of signed(15 downto 0);
  signal ow_zbit  : std_logic;
  signal ow_rbit  : std_logic;
  signal ow_obit  : std_logic;
  signal ow_wbit  : std_logic;
  signal ow_ibit  : std_logic;
  signal ow_rbyte : std_logic;
  signal ow_obyte : std_logic_vector(7 downto 0);
  signal ow_wbyte : std_logic;
  signal ow_ibyte : std_logic_vector(7 downto 0);
  signal ow_busy  : std_logic;
  signal ow_ppwr  : std_logic;
  
  --search module signals
  signal ows_wbit  : std_logic;
  signal ows_obit  : std_logic;
  signal ows_rbit  : std_logic;
  signal ows_zbit  : std_logic;
  signal ows_busy  : std_logic;
  signal ows_err   : std_logic;
  signal ows_wbyte : std_logic;
  signal ows_obyte : std_logic_vector(7 downto 0);
  signal ows_idnum : std_logic_vector(4 downto 0);
  signal ows_idbit : std_logic_vector(5 downto 0);

  --temp module signals
  signal owt_wbit  : std_logic;
  signal owt_obit  : std_logic;
  signal owt_zbit  : std_logic;
  signal owt_busy  : std_logic;
  signal owt_err   : std_logic;
  signal owt_wbyte : std_logic;
  signal owt_obyte : std_logic_vector(7 downto 0);
  signal owt_rbyte : std_logic;
  signal owt_idnum : std_logic_vector(4 downto 0);
  signal owt_idbit : std_logic_vector(5 downto 0);

	signal id_we     : std_logic;
	signal id_ibit   : std_logic;
	signal id_obit   : std_logic;
  signal id_num    : std_logic_vector(4 downto 0);
  signal id_bit    : std_logic_vector(5 downto 0);
	
  --byte module signals
  signal ow8_rbit  : std_logic;
  signal ow8_wbit  : std_logic;
   
begin
  -------------------------------------
  --        signal decoding         ---
  -------------------------------------
  -- ows is the search module, owt is the temp module
  -- rbit, rbyte, wbit, wbyte are the read and write strobes that initiate commands
  -- ibit,obit, ibyte, obyte are the bit and byte input and output values
  
  
  -- the following signals are muxed with priorities, allowing both the temperture and search modules
  --   (owt and ows) to control the one wire interface. 
  ow_rbit <= ows_rbit;
	ow_wbit <= ows_wbit when ows_busy = '1' else owt_wbit;
  ow_ibit <= ows_obit when ows_busy = '1' else owt_obit;
  ow_zbit <= ows_zbit when ows_busy = '1' else owt_zbit;
	ow_wbyte <= ows_wbyte when ows_busy = '1' else owt_wbyte;
	ow_ibyte <= ows_obyte when ows_busy = '1' else owt_obyte;
  ow_rbyte <= owt_rbyte;
  id_bit <= ows_idbit when ows_busy = '1' else owt_idbit ;
  id_num <= ows_idnum when ows_busy = '1' else owt_idnum ;

	
  -------------------------------------
  --      one wire controller       ---
  -------------------------------------
	--ow_mstr - interfaces to the one wire bus, handles reset, rd/wr byte, rd/wr bit
	u_onewire : entity work.ow_mstr(rtl)
  port map (
    --global signals
    clk         => clk,
    srst        => srst,
    stb1us      => stb1us,          -- 1us timing strobe
    busy        => ow_busy,         --indicates the one wire interface is busy
    init_stb    => ow_zbit,         --sends an init/reset pulse to bus
    wrbit       => ow_wbit,         --write a single bit to the bus
    inbit       => ow_ibit,         --data bit to write
    rdbit       => ow_rbit,         --read a single bit from the bus
    outbit      => ow_obit,         --read bit
    wrbyte      => ow_wbyte,        --write a byte to the bus
    inbyte      => ow_ibyte,        --data byte to write
    rdbyte      => ow_rbyte,        --read a byte from the bus
    outbyte     => ow_obyte,        --read byte
    --one wire bus interface
    owin        => owin,            --one wire input
    owout       => owout            --one wire output
	);
	
  -------------------------------------
  --        search controller       ---
  -------------------------------------
  --ow_search - searches the one wire bus for all the one wire devices
  --  this detects the ds1820 temp sensors and other devices with 64 bit ids
  u_ows : entity work.ow_search(rtl)
  port map (
    --global signals
    clk         => clk,
    srst        => srst,
    start       => search_stb,       --iniitates the ow bus search for devices
    busyin      => ow_busy,          --(input) indicates the ow_mstr is busy
    busy        => ows_busy,         --(output) indicates the search is busy
    error       => ows_err,          --the search algorithm hit a snag
    --ow1 & ow8 interfaces
    rdbit       => ows_rbit,         --read command to ow1
    wrbit       => ows_wbit,         --write command to ow1
    zzbit       => ows_zbit,         --reset pulse command to ow1
    obit        => ows_obit,         --write value to ow1
    ibit        => ow_obit,          --value read from ow1
    wrbyte      => ows_wbyte,        --write command to ow8
    obyte       => ows_obyte,        --write value to ow8
    --id ram interface,
    id_num      => ows_idnum,        --current device index (0=31)
    id_bit      => ows_idbit,        --current bit index (0-63)
    id_rbit     => id_obit,          --bit read from RAM
    id_wbit     => id_ibit,          --bit written to RAM
    id_we       => id_we             --write enable to RAM

  );    

  -------------------------------------
  --    temp sensor controller      ---
  -------------------------------------
  --ow_temp - handles the temperature reading from devices.
  --performs initialization, conversion start, and read back of results.
  u_owt : entity work.ow_temp(rtl)
  port map (
    --globals
    clk         => clk,
    srst        => srst,
    busyin      => ow_busy,            --(input) os_mstr is busy
    --signals to upper layer hierarchy
    init        => temp_init,          --command strobe to initialize sensors
    conv        => temp_conv,          --command strobe to start conversions
    read        => temp_read,          --command strobe to read the temps
    busy        => owt_busy,           --(output) temp module is busy
    error       => owt_err,            --indicates temp module error
    --temp values output on a muxed bus
    temp        => temp,               --output temp value
    tempidx     => tempidx,            --temp index
    tempstb     => tempstb,            --temp strobe
    --ow1 and ow8 interfaces
    zzbit       => owt_zbit,           --reset pulse command to ow1
    wrbit       => owt_wbit,           --write command to ow1      
    obit        => owt_obit,           --write value to ow1
    ibit        => ow_ibit,            --value read from ow1
    wrbyte      => owt_wbyte,          --write command to ow8
    rdbyte      => owt_rbyte,          --read command to ow8
    ibyte       => ow_obyte,           --read value from ow8
    obyte       => owt_obyte,          --write value to ow8
    --id ram interface,
    id_num => owt_idnum,               --current device index (0=31)
    id_bit  => owt_idbit,              --current bit index (0-63)
    id_rbit => id_obit                 --bit read from RAM
  );    
  
  -------------------------------------
  --              ID RAM            ---
  -------------------------------------
  -- ow_idram - store and recalls the device ids for devices on the ow bus.
  --  this is implemented in a seperate module to ensure that it uses a internal ram
  --  which greatly reduces the FPGA utilization (saves a lot of FFs and LUTs)
  u_idram : entity work.ow_idram(rtl)
  port map(
    --globals
    clk    => clk,
    --srst   => srst,
    --ram signals
    mode       => ows_busy,    --1=search,0=other, used to compute read addresses
    idnum      => id_num,      --index of the id to read or write
    idbit      => id_bit,      --index of the bit within the id to read or write
    we         => id_we,       --write the currently indexed bit
    wdat       => id_ibit,     --bit value to write to the currently indexed bit
    rdat       => id_obit      --bit value of the currently indexed bit
  );
       
  -- crc8 - computes the CRC for the ow command and responses.
  --  not yet implemented
  --u_crc : entity work.crc8(rtl)
  --port map (
  --  clk    => clk,
  --  srst   => srst,
  --  clken  => stb1us,
  --  crcen  => owc_en,
  --	crcclr => ow1_init,
  --	rdstb  => ow1_rbit,
  --	busyin => ow1_busy,
  --	din    => ow1_odat,
  --	crc    => owc_crc
  --);
	
  
  err <= ows_err or owt_err;
	busy <= owt_busy or ows_busy;
	
end rtl;
