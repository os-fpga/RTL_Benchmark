-- file: pll_for_adc.vhd
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
-- Copyright 2008, 2009 Xilinx, Inc.
-- All rights reserved.
--
-- This disclaimer and copyright notice must be retained as part
-- of this file at all times.
--
------------------------------------------------------------------------------
-- User entered comments
------------------------------------------------------------------------------
-- None
--
------------------------------------------------------------------------------
-- Output     Output      Phase    Duty Cycle   Pk-to-Pk     Phase
-- Clock     Freq (MHz)  (degrees)    (%)     Jitter (ps)  Error (ps)
------------------------------------------------------------------------------
-- CLK_OUT1   200.000      0.000    50.000      264.134    809.487
--
------------------------------------------------------------------------------
-- Input Clock   Input Freq (MHz)   Input Jitter (UI)
------------------------------------------------------------------------------
-- primary              25            0.010

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity pll_for_adc is
port
 (-- Clock in ports
  CLK_IN1           : in     std_logic;
  -- Clock out ports
  CLK_OUT1          : out    std_logic;
  -- Status and control signals
  RESET             : in     std_logic;
  LOCKED            : out    std_logic
 );
end pll_for_adc;

architecture xilinx of pll_for_adc is
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of xilinx : architecture is "pll_for_adc,clk_wiz_v1_4,{component_name=pll_for_adc,use_phase_alignment=false,use_min_o_jitter=false,use_max_i_jitter=true,use_dyn_phase_shift=false,use_inclk_switchover=false,use_dyn_reconfig=false,feedback_source=FDBK_AUTO,diff_ext_feedback=false,primtype_sel=PLL_BASE,num_out_clk=1,clkin1_period=40.0,clkin2_period=40.0,use_power_down=false}";
  -- Input clock buffering / unused connectors
  signal clkin1      : std_logic;
  -- Output clock buffering / unused connectors
  signal clkfbout         : std_logic;
  signal clkout0          : std_logic;
  signal clkout1_unused   : std_logic;
  signal clkout2_unused   : std_logic;
  signal clkout3_unused   : std_logic;
  signal clkout4_unused   : std_logic;
  signal clkout5_unused   : std_logic;
  -- Unused status signals

begin


  -- Input buffering
  --------------------------------------
  clkin1_buf : AUTOBUF
  generic map
   (BUFFER_TYPE => "BUFG")
  port map
   (O => clkin1,
    I => CLK_IN1);


  -- Clocking primitive
  --------------------------------------
  -- Instantiation of the PLL primitive
  --    * Unused inputs are tied off
  --    * Unused outputs are labeled unused

  pll_base_inst : PLL_BASE
  generic map
   (BANDWIDTH            => "LOW",
    CLK_FEEDBACK         => "CLKFBOUT",
    COMPENSATION         => "INTERNAL",
    DIVCLK_DIVIDE        => 1,
    CLKFBOUT_MULT        => 16,
    CLKFBOUT_PHASE       => 0.000,
    CLKOUT0_DIVIDE       => 2, --2 creates 200MHz, 4 creates 100MHz. This is sampling and IO-clock freq
    CLKOUT0_PHASE        => 0.000,
    CLKOUT0_DUTY_CYCLE   => 0.500,
    CLKIN_PERIOD         => 40.0,
    REF_JITTER           => 0.010)
  port map
    -- Output clocks
   (CLKFBOUT            => clkfbout,
    CLKOUT0             => clkout0,
    CLKOUT1             => clkout1_unused,
    CLKOUT2             => clkout2_unused,
    CLKOUT3             => clkout3_unused,
    CLKOUT4             => clkout4_unused,
    CLKOUT5             => clkout5_unused,
    -- Status and control signals
    LOCKED              => LOCKED,
    RST                 => RESET,
    -- Input clock control
    CLKFBIN             => clkfbout,
    CLKIN               => clkin1);

  -- Output buffering
  -------------------------------------


  clkout1_buf : AUTOBUF
  generic map
   (BUFFER_TYPE => "BUFG")
  port map
   (O => CLK_OUT1,
    I => clkout0);

end xilinx;
