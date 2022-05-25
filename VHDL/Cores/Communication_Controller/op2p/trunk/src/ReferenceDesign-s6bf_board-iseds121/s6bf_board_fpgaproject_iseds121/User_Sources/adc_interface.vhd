
-- file: adc_interface.vhd
--
-- DISCLAIMER OF LIABILITY
--
-- This file contains proprietary and confidential information of
-- Xilinx, Inc. ("Xilinx"), that is distributed under a license
-- from Xilinx, and may be used, copied and/or disclosed only
-- pursuant to the terms of a valid license agreement with Xilinx.
--
-- XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION
-- ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
-- EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT
-- LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,
-- MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx
-- does not warrant that functions included in the Materials will
-- meet the requirements of Licensee, or that the operation of the
-- Materials will be uninterrupted or error-free, or that defects
-- in the Materials will be corrected. Furthermore, Xilinx does
-- not warrant or make any representations regarding use, or the
-- results of the use, of the Materials in terms of correctness,
-- accuracy, reliability or otherwise.
--
-- Xilinx products are not designed or intended to be fail-safe,
-- or for use in any application requiring fail-safe performance,
-- such as life-support or safety devices or systems, Class III
-- medical devices, nuclear facilities, applications related to
-- the deployment of airbags, or any other applications that could
-- lead to death, personal injury or severe property or
-- environmental damage (individually and collectively, "critical
-- applications"). Customer assumes the sole risk and liability
-- of any use of Xilinx products in critical applications,
-- subject only to applicable laws and regulations governing
-- limitations on product liability.
--
-- Copyright 2009 Xilinx, Inc.
-- All rights reserved.
--
-- This disclaimer and copyright notice must be retained as part
-- of this file at all times.
--
------------------------------------------------------------------------------
-- User entered comments
------------------------------------------------------------------------------
-- ad_converter_interface_to_ti_ads5517
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity adc_interface is
generic
 (-- width of the data for the system
  sys_w       : integer := 6;
  -- width of the data for the device
  dev_w       : integer := 12);
port
 (
  -- From the system into the device
  DATA_IN_FROM_PINS_P     : in    std_logic_vector(sys_w-1 downto 0);
  DATA_IN_FROM_PINS_N     : in    std_logic_vector(sys_w-1 downto 0);
  DATA_IN_TO_DEVICE       : out   std_logic_vector(dev_w-1 downto 0);
  CLK_IN_P                : in    std_logic;
  CLK_IN_N                : in    std_logic;
  CLK_OUT                 : out   std_logic;
  CLK_RESET               : in    std_logic;
  IO_RESET                : in    std_logic);
end adc_interface;

architecture xilinx of adc_interface is
  attribute CORE_GENERATION_INFO            : string;
  attribute CORE_GENERATION_INFO of xilinx  : architecture is "adc_interface,selectio_wiz_v1_2,{component_name=adc_interface,bus_dir=INPUTS,bus_sig_type=DIFF,bus_io_std=LVDS_33,use_serialization=false,serialization_factor=8,enable_bitslip=false,enable_train=false,system_data_width=6,bus_in_delay=NONE,bus_out_delay=NONE,clk_sig_type=DIFF,clk_io_std=LVDS_33,clk_buf=BUFIO2,active_edge=BOTH_RISE_FALL,clk_delay=NONE}";
  constant clock_enable            : std_logic := '1';
  signal clk_in_int                : std_logic;
  signal clk_div                   : std_logic;
  signal clk_div_int               : std_logic;
  signal clk_in_int_buf            : std_logic;
  signal clk_in_int_inv            : std_logic;

  -- After the buffer
  signal data_in_from_pins_int     : std_logic_vector(sys_w-1 downto 0);
  -- Between the delay and serdes
  signal data_in_from_pins_delay   : std_logic_vector(sys_w-1 downto 0);

begin


  -- Create the clock logic
  ibufds_clk_inst : IBUFGDS
    generic map (
      DIFF_TERM  => TRUE,  --100 ohm diff input termination
		IOSTANDARD => "LVDS_33")
    port map (
      I          => CLK_IN_P,
      IB         => CLK_IN_N,
      O          => clk_in_int);


		  --I HAD TO MANUALLY INVERT THE CLOCKS FOR THE IDDR2.
		  --THIS IS BECAUSE THE ADC SENDS DATA STARTING WITH FALLING EDGE OF THE CLOCK WHILE
		  --THE DEFAULT XILINX IDDR-APPNOTES START WITH RISING EDGE.
		  --CHANGE: SWAP THE "I_INVERT" GENERICS BETWEEN THE TWO BUIFIO2 INSTANCES.
		  --Also I had to swap the FUFIO2-LOC constraint locations.
		  --ISTVAN NAGY 2011

  -- Set up the clock for use in the serdes
  bufio2_inst : BUFIO2
    generic map (
      DIVIDE_BYPASS => FALSE,
      I_INVERT      => TRUE,
      USE_DOUBLER   => FALSE,
      DIVIDE        => 1)
    port map (
      DIVCLK       => clk_div,
      IOCLK        => clk_in_int_buf,
      SERDESSTROBE => open,
      I            => clk_in_int);

  -- also generated the inverted clock
  bufio2_inv_inst : BUFIO2
    generic map (
      DIVIDE_BYPASS => FALSE,
      I_INVERT      => FALSE,
      USE_DOUBLER   => FALSE,
      DIVIDE        => 1)
    port map (
      DIVCLK        => open,
      IOCLK         => clk_in_int_inv,
      SERDESSTROBE  => open,
      I             => clk_in_int);


   -- Buffer up the "divided" copied version of the input clock
   clkout_buf_inst : AUTOBUF
     generic map(
       BUFFER_TYPE => "BUFG")
     port map (
       O => CLK_OUT,
       I => clk_div);
		 
		 
  --GENERATE LOOP START ------------------------------------********************************
  -- We have multiple bits- step over every bit, instantiating the required elements
  pins: for pin_count in 0 to sys_w-1 generate
  begin
    -- Instantiate the buffers
    ----------------------------------
    -- Instantiate a buffer for every bit of the data bus
    ibufds_inst : IBUFDS
      generic map (
        DIFF_TERM  => TRUE,    --100 ohm diff input termination
        IOSTANDARD => "LVDS_33")
      port map (
        I          => DATA_IN_FROM_PINS_P  (pin_count),
        IB         => DATA_IN_FROM_PINS_N  (pin_count),
        O          => data_in_from_pins_int(pin_count));


    -- Pass through the delay
    -----------------------------------
   data_in_from_pins_delay(pin_count) <= data_in_from_pins_int(pin_count);

    -- Connect the delayed data to the fabric
    ------------------------------------------
   -- DDR register instantation
    iddr2_inst : IDDR2
      generic map (
        DDR_ALIGNMENT  => "C0",
        INIT_Q0        => '0',
        INIT_Q1        => '0',
        SRTYPE         => "ASYNC")
      port map
       (Q0             => DATA_IN_TO_DEVICE(pin_count + pin_count),  --THIS WAS MODIFIED TO MATCH THE BIT ORDER OF ADS5517
        Q1             => DATA_IN_TO_DEVICE(1 + pin_count + pin_count), --THIS WAS MODIFIED TO MATCH THE BIT ORDER OF ADS5517
        C0             => clk_in_int_buf,
        C1             => clk_in_int_inv,
        CE             => clock_enable,
        D              => data_in_from_pins_delay(pin_count),
        R              => IO_RESET,
        S              => '0');
		  

  end generate pins;
  --GENERATE LOOP END ------------------------------------********************************

end xilinx;



