 
-- (c) Copyright 2008 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- 

--
--  STANDARD_CC_MODULE
--
--
--  Description: This module drives the Aurora module's Clock Compensation
--               interface.  Clock Compensation sequences are generated according
--               to the requirements in the Aurora Protocol specification.
--
--               This module supports Aurora Modules with any number of
--               2-byte lanes and no User Flow Control.
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- synthesis translate_off
library UNISIM;
use UNISIM.all;
-- synthesis translate_on

entity aurora_8b10b_v5_1_STANDARD_CC_MODULE is
port
(    
    -- Clock Compensation Control Interface
    WARN_CC        : out std_logic;
    DO_CC          : out std_logic;

    -- System Interface
    PLL_NOT_LOCKED : in std_logic;
    USER_CLK       : in std_logic;
    RESET          : in std_logic

);
end aurora_8b10b_v5_1_STANDARD_CC_MODULE;

architecture RTL of aurora_8b10b_v5_1_STANDARD_CC_MODULE is
  attribute core_generation_info        : string;
  attribute core_generation_info of RTL : architecture is "aurora_8b10b_v5_1,aurora_8b10b_v5_1,{backchannel_mode=Sidebands, c_aurora_lanes=2, c_column_used=None, c_gt_clock_1=GTPD1, c_gt_clock_2=None, c_gt_loc_1=X, c_gt_loc_10=X, c_gt_loc_11=X, c_gt_loc_12=X, c_gt_loc_13=X, c_gt_loc_14=X, c_gt_loc_15=X, c_gt_loc_16=X, c_gt_loc_17=X, c_gt_loc_18=X, c_gt_loc_19=X, c_gt_loc_2=X, c_gt_loc_20=X, c_gt_loc_21=X, c_gt_loc_22=X, c_gt_loc_23=X, c_gt_loc_24=X, c_gt_loc_25=X, c_gt_loc_26=X, c_gt_loc_27=X, c_gt_loc_28=X, c_gt_loc_29=X, c_gt_loc_3=1, c_gt_loc_30=X, c_gt_loc_31=X, c_gt_loc_32=X, c_gt_loc_33=X, c_gt_loc_34=X, c_gt_loc_35=X, c_gt_loc_36=X, c_gt_loc_37=X, c_gt_loc_38=X, c_gt_loc_39=X, c_gt_loc_4=2, c_gt_loc_40=X, c_gt_loc_41=X, c_gt_loc_42=X, c_gt_loc_43=X, c_gt_loc_44=X, c_gt_loc_45=X, c_gt_loc_46=X, c_gt_loc_47=X, c_gt_loc_48=X, c_gt_loc_5=X, c_gt_loc_6=X, c_gt_loc_7=X, c_gt_loc_8=X, c_gt_loc_9=X, c_lane_width=2, c_line_rate=1.5, c_nfc=true, c_nfc_mode=COMP, c_refclk_frequency=75.0, c_simplex=false, c_simplex_mode=TX, c_stream=false, c_ufc=false, flow_mode=Completion_NFC, interface_mode=Framing, dataflow_config=Duplex,}";
--******************************Parameter Declarations*******************************

    constant DLY : time := 1 ns;

--************************** Internal Register Declarations **************************

    signal      prepare_count_r     : std_logic_vector(0 to 9) := "0000000000";
    signal      cc_count_r          : std_logic_vector(0 to 5) := "000000";
    signal      reset_r             : std_logic;
    
    signal      count_13d_srl_r     : std_logic_vector(0 to 11);
    signal      count_13d_flop_r    : std_logic;
    signal      count_16d_srl_r     : std_logic_vector(0 to 14);
    signal      count_16d_flop_r    : std_logic;
    signal      count_24d_srl_r     : std_logic_vector(0 to 22);
    signal      count_24d_flop_r    : std_logic;    

--*********************************Wire Declarations**********************************
    signal      enable_cc_c		: std_logic;

    signal      start_cc_c              : std_logic;
    signal      inner_count_done_r      : std_logic;
    signal      middle_count_done_c     : std_logic;
    signal      cc_idle_count_done_c    : std_logic;
   
--*********************************Main Body of Code**********************************
begin
 
 --________________________Clock Correction State Machine__________________________
   enable_cc_c <= not RESET; 
 
    -- The clock correction state machine is a counter with three sections.  The first
    -- section counts out the idle period before a clock correction occurs.  The second
    -- section counts out a period when NFC and UFC operations should not be attempted
    -- because they will not be completed.  The last section counts out the cycles of
    -- the clock correction sequence.
 
    -- The inner count for the CC counter counts to 13.  It is implemented using
    -- an SRL16 and a flop

    -- The SRL counts 12 bits of the count
    process(USER_CLK)
    begin
        if(USER_CLK'event and USER_CLK = '1') then
        if(RESET = '1') then
           count_13d_srl_r <=   "000000000000" after DLY;
        else
            count_13d_srl_r <=   (count_13d_flop_r & count_13d_srl_r(0 to 10)) after DLY;
        end if;
        end if;
    end process;
    
    -- The inner count is done when a 1 reaches the end of the SRL
    inner_count_done_r  <=  count_13d_srl_r(11);
 
    -- The flop extends the shift register to 13 bits for counting. It is held at 
    -- zero while channel up is low to clear the register, and is seeded with a 
    -- single 1 when channel up transitions from 0 to 1
    process(USER_CLK)
    begin
        if(USER_CLK'event and USER_CLK = '1') then
            if(RESET = '1') then
                count_13d_flop_r    <=  '0' after DLY;
            elsif( (enable_cc_c and reset_r)= '1') then
                count_13d_flop_r    <=  '1' after DLY;
            else
                count_13d_flop_r    <=  inner_count_done_r after DLY;
            end if;
        end if;
    end process;
 
    -- The middle count for the CC counter counts to 16.  Its count increments only
    -- when the inner count is done.  It is implemented using an SRL16 and a flop
    
    -- The SRL counts 15 bits of the count. It is enabled only when the inner count
    -- is done
    process(USER_CLK)
    begin
        if(USER_CLK'event and USER_CLK = '1') then
            if (RESET = '1') then
               count_16d_srl_r <=  "000000000000000" after DLY;
            elsif((inner_count_done_r or not enable_cc_c ) = '1') then
                count_16d_srl_r <=  ( count_16d_flop_r & count_16d_srl_r(0 to 13) ) after DLY;
            end if;
        end if;
    end process;
    
    -- The middle count is done when a 1 reaches the end of the SRL and the inner
    -- count finishes
    middle_count_done_c <=   inner_count_done_r and count_16d_srl_r(14);     
    
    -- The flop extends the shift register to 16 bits for counting. It is held at
    -- zero while channel up is low to clear the register, and is seeded with a 
    -- single 1 when channel up transitions from 0 to 1
    process(USER_CLK)
    begin
        if(USER_CLK'event and USER_CLK = '1') then
            if(RESET = '1') then
                count_16d_flop_r    <=  '0' after DLY;
            elsif((enable_cc_c  and reset_r)='1') then
                count_16d_flop_r    <=  '1' after DLY;
            elsif(inner_count_done_r = '1') then
                count_16d_flop_r    <=  middle_count_done_c after DLY;
            end if;
        end if;
    end process;
 
  
    -- The outer count (aka the cc idle count) is done when it reaches 24.  Its count
    -- increments only when the middle count is done.  It is implemented with 2
    -- SRL16Es.             
    
    
    -- The SRL counts 23 bits of the count. It is enabled only when the middle count is
    -- done
    process(USER_CLK)
    begin
        if(USER_CLK'event and USER_CLK = '1') then
           if(RESET = '1') then
                               count_24d_srl_r     <=  "00000000000000000000000" after DLY;
            elsif((middle_count_done_c or not enable_cc_c ) = '1') then
                count_24d_srl_r     <=  (count_24d_flop_r & count_24d_srl_r(0 to 21)) after DLY;
            end if;
        end if;
    end process;
            
    -- The cc idle count is done when a 1 reaches the end of the SRL and the middle count finishes
    cc_idle_count_done_c    <=   middle_count_done_c and count_24d_srl_r(22);
    
    -- The flop extends the shift register to 24 bits for counting. It is held at
    -- zero while channel up is low to clear the register, and is seeded with a single
    -- 1 when channel up transitions from 0 to 1
    process(USER_CLK)
    begin
        if(USER_CLK'event and USER_CLK = '1') then
            if(RESET = '1') then
                count_24d_flop_r    <=  '0' after DLY;
            elsif( (enable_cc_c  and reset_r) = '1') then
                count_24d_flop_r    <=  '1' after DLY;
            elsif( middle_count_done_c = '1') then
                count_24d_flop_r    <=  cc_idle_count_done_c after DLY;
            end if;
        end if;
    end process;
 
     -- Because UFC and CC sequences are not allowed to preempt one another, there
     -- there is a warning signal to indicate an impending CC sequence.  This signal
     -- is used to prevent UFC messages from starting.
 
     -- For 2 lanes, we use a 6-cycle count.
    process(USER_CLK)
    begin
        if(USER_CLK'event and USER_CLK = '1') then
         if(RESET = '1') then
            prepare_count_r <=  "0000000000" after DLY;
         else
            prepare_count_r <= ("0000" & cc_idle_count_done_c & prepare_count_r(4 to 8)) after DLY;
        end if;
        end if;
    end process;
 
 
    -- The state machine stays in the prepare_cc state from when the cc idle
    -- count finishes, to when the prepare count has finished.  While in this
    -- state, UFC operations cannot start, which prevents them from having to
    -- be pre-empted by CC sequences.
    process(USER_CLK)
    begin
        if(USER_CLK'event and USER_CLK = '1') then
            if(RESET = '1') then
                WARN_CC     <=  '0'     after DLY;
            elsif(cc_idle_count_done_c = '1') then
                WARN_CC     <=  '1'     after DLY;
            elsif(prepare_count_r(9) = '1') then
                WARN_CC    <=   '0'     after DLY;
            end if;
        end if;
    end process;
 
    -- Track the state of channel up on the previous cycle. We use this signal to determine
    -- when to seed the shift register counters with ones
    process(USER_CLK)
    begin
        if(USER_CLK'event and USER_CLK = '1') then
            reset_r <=  RESET after DLY;
        end if;
    end process;
 
    --Do a CC after enable_cc_c  is asserted or CC_warning is complete.
    start_cc_c   <=   prepare_count_r(9) or (enable_cc_c  and reset_r);
 
  
     -- This SRL counter keeps track of the number of cycles spent in the CC
     -- sequence.  It starts counting when the prepare_cc state ends, and
     -- finishes counting after 6 cycles have passed.
    process(USER_CLK)
    begin
        if(USER_CLK'event and USER_CLK = '1') then
        if(RESET = '1') then
           cc_count_r      <=  "000000" after DLY;
        else
            cc_count_r      <=  ( (not enable_cc_c  or prepare_count_r(9)) & cc_count_r(0 to 4) ) after DLY;
        end if;
        end if;
    end process;
 
     -- The TX_LL module stays in the do_cc state for 6 cycles.  It starts
     -- when the prepare_cc state ends.
    process(USER_CLK)
    begin
        if(USER_CLK'event and USER_CLK = '1') then
            if(RESET = '1') then
                DO_CC <=  '0'   after DLY;
            elsif(start_cc_c = '1') then
                DO_CC <=  '1'   after DLY;
            elsif(cc_count_r /= "000000" ) then
                DO_CC <=  '1'   after DLY;
           elsif(cc_count_r = "000000") then
                DO_CC <=  '0'   after DLY;
            end if;
        end if;
    end process;

end RTL;
