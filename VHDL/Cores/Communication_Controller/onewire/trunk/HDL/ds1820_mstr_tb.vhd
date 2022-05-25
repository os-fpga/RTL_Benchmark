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
--  file: ds1820_mstr_tb.vhd
--  description: Testbench for both the ow_mstr and ds1820_mster modules
--
-------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use ieee.std_logic_textio.all;
library std;
use STD.textio.all;

-------------------------------------------------------------------------------------
-- Entity declaration
-------------------------------------------------------------------------------------
entity ds1820_mstr_tb is
end ds1820_mstr_tb;

-------------------------------------------------------------------------------------
-- Architecture declaration
-------------------------------------------------------------------------------------
architecture sim of ds1820_mstr_tb is

  -------------------------------------
  --    Check Temps Proceedure      ---
  -------------------------------------
  --check_temp - proceedure to check the output data, temp and tempidx, against expected values
  procedure check_temp (
    signal temp    : in signed(15 downto 0);  --the temp reported from the DUT
    signal idx     : in unsigned(4 downto 0); --the index of the sensor (sensor number) from the DUT
    exptemp : in signed(15 downto 0);         --expected temperature value
    expidx  : in unsigned(4 downto 0))        --expected index value
  is
    variable myline : line;
    variable dec : integer;
    variable frac : integer;
  begin
    --line := "";
    if idx /= expidx then
      write(myline,string'("Error: wrong idx, expected "));
      write(myline,to_integer(expidx));
      write(myline,string'(", got "));
      write(myline,to_integer(idx));
      writeline(output,myline);
      assert false report "bad tempidx value" severity error;
    end if;
    if temp /= exptemp then
      --write(output, std_logic_vector(temp));
      write(myline,string'("Error: wrong temp on sensor "));
      write(myline,to_integer(expidx));
      write(myline,string'(", expected "));
      dec := to_integer(exptemp) / 16;
      frac := ((to_integer(exptemp) - 16*dec)*100)/16;
      write(myline,dec);
      write(myline,string'("."));
      write(myline,frac);
      write(myline,string'(", got "));
      dec := to_integer(temp) / 16;
      frac := ((to_integer(temp) - 16*dec)*100)/16;
      write(myline,dec);
      write(myline,string'("."));
      write(myline,frac);
      write(myline,string'(", got "));
      writeline(output,myline);
      assert false report "bad temp value" severity error;
    end if;
  end procedure check_temp;
    
  -------------------------------------------
  ---       Signal declaration            ---
  -------------------------------------------
  constant clkfreqmhz : integer := 100;                   --clock frequency in mhz
  constant halfperiodns : time := 1000 ns /(clkfreqmhz*2);--half the clock period
  signal clk      : std_logic;
  
  constant CONVERSION_TIME : integer := 188;   --ADC conversion time in ms
  
  signal srst  : std_logic := '0';           --synchronous reset
  signal rst_cntr : unsigned(7 downto 0):= x"ff";
  signal stb1us_cntr  : integer range 1 to clkfreqmhz := 1; --counter used to generate stb1us
  signal stb1us  : std_logic := '0';  --strobe 1 us, goes high for one clock every 1 us

  signal search_init  : std_logic := '0';     --triggers the search module
  signal temp_init    : std_logic := '0';     --triggers the initialization module
  signal temp_conv    : std_logic := '0';     --triggers the temperature conversion
  signal temp_read    : std_logic := '0';     --triggers the reading of the temperature results
  signal ow_busy      : std_logic;            -- the one wire bus is busy
  signal ow_err       : std_logic;            --there is an error on the one wire bus
  signal temp         : signed(15 downto 0);  --signed temp from sensor, value is 16 times the temp in C
  signal tempidx      : unsigned(4 downto 0); --index of the current temp sensor
  signal tempstb      : std_logic;            --strobe to indicate an updated temp sensor value
  signal owin         : std_logic;            --one wire input to dut
  signal owout        : std_logic;            --one wire output from dut
  signal dio          : std_logic;            --one wire bus

begin

  -------------------------------------
  --    global timing signals       ---
  -------------------------------------

  p_osc : process
  begin
    clk <= '0';
    wait for halfperiodns;
    clk <= '1';
    wait for halfperiodns;
  end process p_osc;
  
  p_rst : process
  begin
    srst <= '1';
    wait for 5 us;
    wait until clk = '1';
    srst <= '0';
    wait;
  end process p_rst;

  --generate a 1 us strobe for timing
  p_stb1us : process(clk)
  begin
    if rising_edge(clk) then
      if srst = '1' then
        stb1us <= '0';
        stb1us_cntr <= 1;
      else
        if stb1us_cntr = clkfreqmhz then
          stb1us <= '1';
          stb1us_cntr <= 1;
        else
          stb1us <= '0';
          stb1us_cntr <= stb1us_cntr + 1;
        end if;
      end if;
    end if;
  end process p_stb1us;

  -------------------------------------
  --              DUT               ---
  -------------------------------------
 --ow_mstr - DUT (device under test)
  -- one wire master - this performs all the one wire logic
  --  such as configuring and reading the DS1820 devices
  u_dut : entity work.ds1820_mstr(rtl)
  port map(
    --global signals
    clk => clk,
    srst => srst,
    stb1us => stb1us,            --1 us strobe
    busy => ow_busy,
    err  => ow_err,
    --high level interfaces, lets this module do the heavy lifting. For microprocessor control,
    search_stb  => search_init,  --searches for devices on bus
    temp_init   => temp_init,    --initiates temperature read from all devices
    temp_conv   => temp_conv,    --initiates temperature read from all devices
    temp_read   => temp_read,    --initiates temperature read from all devices
    temp        => temp,         --temperatures read from temp devices
    tempidx     => tempidx,      --temperatures index
    tempstb     => tempstb,      --temperatures ready strobe
    --one wire bus interface, requires external 5k resistor on bus
    owin        => owin,       --one wire input
    owout       => owout       --one wire output
  );

  -----------------------------------------
  --    one wire bus, open collector    ---
  -----------------------------------------
  --handle in/out nature of one wire interface
  dio <= '0' when owout = '0' else 'Z';  --output, only drives low, tristates when not low, external 5k pullup
  owin <= '0' when dio = '0' else '1';   --input, make sure H,Z,1 all map to '1' for simulation
  dio <= 'H';  --simulates the external pullup resistor
 
  -----------------------------------------
  --   test bench control and checks    ---
  -----------------------------------------
  
  --p_control - controls the testing, initiates commands to the DUT
  p_control : process
  begin
  	search_init  <= '0';  --searches for devices on bus
    temp_init   <= '0';   --initiates temperature read from all devices
    temp_conv   <= '0';   --initiates temperature read from all devices
    temp_read    <= '0';  --initiates temperature read from all devices
    --wait for reset and a bit of time to settle
    wait for 10 us;
    --initiate a search of the one wire devices on the bus
    wait until clk = '0';
    search_init <= '1';
    wait until clk = '0';
    search_init <= '0';
    wait until clk = '0';
    --wait for search to complete
    wait until ow_busy = '0';
    wait until clk = '0';
    --initialize all the temperature sensors on the bus
    wait until clk = '0';
    temp_init   <= '1';
    wait until clk = '0';
    temp_init   <= '0';
    wait until clk = '0';
    --wait for search to complete
    wait until ow_busy = '0';
    wait for 5 us;
    --start conversions on all the sensors
    wait until clk = '0';
    temp_conv   <= '1';
    wait until clk = '0';
    temp_conv   <= '0';
    wait until clk = '0';
    --wait for conversion commands to complete
    wait until ow_busy = '0';
    --now wait until the conversions are actually complete
    wait for 190 ms;
    --read the temp from all the sensors
    wait until clk = '0';
    temp_read   <= '1';
    wait until clk = '0';
    temp_read   <= '0';
    wait until clk = '0';
    --wait for all reads to take place
    wait until ow_busy = '0';
    wait until clk = '0';
    --now wait until the conversions are actually complete
    wait;
  end process p_control;
  
  --p_check - checks the output of the DUT and alerts if it is incorrect
  p_check : process
    variable exptemp : signed(15 downto 0);
    variable expidx : unsigned(4 downto 0);
  begin
    --check data from sensor 1
    wait until tempstb = '1';
    exptemp := to_signed(-24,16); --  -1.5C
    expidx := to_unsigned(0,5);
    check_temp(temp,tempidx,exptemp,expidx);
    --check data from sensor 2
    wait until tempstb = '1';
    exptemp := to_signed(1844,16);  --  +115.25C
    expidx := to_unsigned(1,5);
    check_temp(temp,tempidx,exptemp,expidx);
    --check data from sensor 2
    wait until tempstb = '1';
    exptemp := to_signed(916,16);  --  +57.25C
    expidx := to_unsigned(2,5);
    check_temp(temp,tempidx,exptemp,expidx);
    wait for 5 us;
    assert false report "Test completed" severity note;
    wait;
  end process;

  p_error : process
  begin
    wait until ow_err = '1';
    assert true report "Bus error reported" severity error;
  end process;

  --------------------------------------------
  --   Simulated OW bus devices, ds1820    ---
  --------------------------------------------
  --simulated temperature sensor
  u_ds18b20_1 : entity work.ds18b20_sim(sim)
  generic map (
    timing => "min",
    devid => x"00a0458d3ea2be28"
    )
  port map (
    --dio => dio1,
    pwrin => '1',
    dio => dio,
    tempin => -1.54
    );

  --simulated temperature sensor
  u_ds18b20_2 : entity work.ds18b20_sim(sim)
  generic map (
    timing => "min",
    devid => x"002984456a32bf28"
    )
  port map (
    --dio => dio2,
    pwrin => '1',
    dio => dio,
    tempin => 115.3
    );

  --simulated temperature sensor
  u_ds18b20_3 : entity work.ds18b20_sim(sim)
  generic map (
    timing => "min",
    devid => x"0083726dab32bf28"
    )
  port map (
    --dio => dio3,
    pwrin => '1',
    dio => dio,
    tempin => 57.25
    );

end sim;
