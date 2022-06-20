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
--  STORAGE_COUNT_CONTROL
--
--
--
--  Description: STORAGE_COUNT_CONTROL sets the storage count value for the next clock
--               cycle
--
--              This module supports 2 2-byte lane designs
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use WORK.AURORA_PKG.all;

entity aurora_8b10b_v5_1_STORAGE_COUNT_CONTROL is

    port (

            LEFT_ALIGNED_COUNT : in std_logic_vector(0 to 1);
            END_STORAGE        : in std_logic;
            START_WITH_DATA    : in std_logic;
            FRAME_ERROR        : in std_logic;
            STORAGE_COUNT      : out std_logic_vector(0 to 1);
            USER_CLK           : in std_logic;
            RESET              : in std_logic

         );

end aurora_8b10b_v5_1_STORAGE_COUNT_CONTROL;

architecture RTL of aurora_8b10b_v5_1_STORAGE_COUNT_CONTROL is

-- Parameter Declarations --

    constant DLY : time := 1 ns;

-- External Register Declarations --

    signal STORAGE_COUNT_Buffer : std_logic_vector(0 to 1);

-- Internal Register Declarations --

    signal storage_count_c : std_logic_vector(0 to 1);
    signal storage_count_r : std_logic_vector(0 to 1);

-- Wire Declarations --

    signal overwrite_c : std_logic;
    signal sum_c       : std_logic_vector(0 to 2);
    signal remainder_c : std_logic_vector(0 to 2);
    signal overflow_c  : std_logic;

begin

    STORAGE_COUNT <= STORAGE_COUNT_Buffer;

-- Main Body of Code --

    -- Calculate the value that will be used for the switch.

    sum_c       <= conv_std_logic_vector(0,3) + LEFT_ALIGNED_COUNT + storage_count_r;
    remainder_c <= sum_c - conv_std_logic_vector(2,3);

    overwrite_c <= END_STORAGE or START_WITH_DATA;
    overflow_c  <= std_bool(sum_c > conv_std_logic_vector(2,3));


    process (overwrite_c, overflow_c, sum_c, remainder_c, LEFT_ALIGNED_COUNT)

        variable vec : std_logic_vector(0 to 1);

    begin

        vec := overwrite_c & overflow_c;

        case vec is

            when "00" =>

                storage_count_c <= sum_c(1 to 2);

            when "01" =>

                storage_count_c <= remainder_c(1 to 2);

            when "10" =>

                storage_count_c <= LEFT_ALIGNED_COUNT;

            when "11" =>

                storage_count_c <= LEFT_ALIGNED_COUNT;

            when others =>

                storage_count_c <= (others => '0');

        end case;

    end process;


    -- Register the Storage Count for the next cycle.

    process (USER_CLK)

    begin

        if (USER_CLK'event and USER_CLK = '1') then

            if ((RESET or FRAME_ERROR) = '1') then

                storage_count_r <= (others => '0') after DLY;

            else

                storage_count_r <=  storage_count_c after DLY;

            end if;

        end if;

    end process;


    -- Make the output of the storage count register available to other modules.

    STORAGE_COUNT_Buffer <= storage_count_r;

end RTL;
