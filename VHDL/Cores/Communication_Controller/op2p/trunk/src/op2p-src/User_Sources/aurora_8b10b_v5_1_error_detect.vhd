---------------------------------------------------------------------------------
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
--  ERROR_DETECT_GTP
--
--
--
--  Description : The ERROR_DETECT module monitors the GTP to detect hard
--                errors.  It accumulates the Soft errors according to the
--                leaky bucket algorithm described in the Aurora
--                Specification to detect Hard errors.  All errors are
--                reported to the Global Logic Interface.
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use WORK.AURORA_PKG.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity aurora_8b10b_v5_1_ERROR_DETECT is
port
(
    -- Lane Init SM Interface
    ENABLE_ERROR_DETECT : in std_logic;
    HARD_ERROR_RESET    : out std_logic;


    -- Global Logic Interface
    SOFT_ERROR          : out std_logic;
    HARD_ERROR          : out std_logic;


    -- GTP Interface
    RX_BUF_ERR              : in  std_logic;
    RX_DISP_ERR             : in  std_logic_vector(1 downto 0);
    RX_NOT_IN_TABLE         : in  std_logic_vector(1 downto 0);
    TX_BUF_ERR              : in  std_logic;
    RX_REALIGN              : in  std_logic;

    -- System Interface
    USER_CLK            : in std_logic
);

end aurora_8b10b_v5_1_ERROR_DETECT;

architecture RTL of aurora_8b10b_v5_1_ERROR_DETECT is

--******************************Constant Declarations*******************************

    constant DLY               : time := 1 ns;

--**************************VHDL out buffer logic*************************************

    signal HARD_ERROR_RESET_Buffer     : std_logic;
    signal SOFT_ERROR_Buffer           : std_logic;
    signal HARD_ERROR_Buffer           : std_logic;


--**************************Internal Register Declarations****************************


    signal count_r                     : std_logic_vector(0 to 1);
    signal bucket_full_r               : std_logic;
    signal soft_error_r                : std_logic_vector(0 to 1);
    signal good_count_r                : std_logic_vector(0 to 1);
    signal soft_error_flop_r           : std_logic; -- Traveling flop for timing.
    signal hard_error_flop_r           : std_logic; -- Traveling flop for timing.


--*********************************Main Body of Code**********************************
begin


    --_________________________VHDL Output Buffers_______________________________

    HARD_ERROR_RESET <= HARD_ERROR_RESET_Buffer;
    SOFT_ERROR       <= SOFT_ERROR_Buffer;
    HARD_ERROR       <= HARD_ERROR_Buffer;


-- ____________________________ Error Processing _________________________________



    -- Detect Soft Errors

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if (ENABLE_ERROR_DETECT = '1') then

                soft_error_r(0) <= RX_DISP_ERR(1) or RX_NOT_IN_TABLE(1) after DLY;
                soft_error_r(1) <= RX_DISP_ERR(0) or RX_NOT_IN_TABLE(0) after DLY;

            else

                soft_error_r(0) <= '0' after DLY;
                soft_error_r(1) <= '0' after DLY;

            end if;

        end if;

    end process;


    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            soft_error_flop_r <= soft_error_r(0) or
                                 soft_error_r(1) after DLY;

            SOFT_ERROR_Buffer <= soft_error_flop_r after DLY;

        end if;

    end process;


    -- Detect Hard Errors

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if (ENABLE_ERROR_DETECT = '1') then

                hard_error_flop_r <= RX_BUF_ERR or
                                     TX_BUF_ERR or
                                     RX_REALIGN or
                                     bucket_full_r after DLY;

                HARD_ERROR_Buffer <= hard_error_flop_r after DLY;

            else

                hard_error_flop_r <= '0' after DLY;
                HARD_ERROR_Buffer <= '0' after DLY;

            end if;

        end if;

    end process;


    -- Assert hard error reset when there is a hard error.  This assignment
    -- just renames the two fanout branches of the hard error signal.

    HARD_ERROR_RESET_Buffer <= hard_error_flop_r;


    --_______________________________Leaky Bucket  ________________________


    -- Good cycle counter: it takes 2 consecutive good cycles to remove a demerit from
    -- the leaky bucket

    process (USER_CLK)

        variable err_vec : std_logic_vector(3 downto 0);

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if (ENABLE_ERROR_DETECT = '0') then

                good_count_r <= "00" after DLY; 

            else

               if (soft_error_r(0 to 1) = "00" and good_count_r = "00" ) then
                        good_count_r <= "10" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "00" and good_count_r = "01" ) then
                        good_count_r <= "11" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "00" and good_count_r = "10" ) then
                        good_count_r <= "00" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "00" and good_count_r = "11" ) then
                        good_count_r <= "01" after DLY;
                end if;

                if (soft_error_r(1) = '1') then
                        good_count_r <= "00" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "10") then
                        good_count_r <= "01" after DLY;
                end if;

            end if;

        end if;

    end process;


    -- Perform the leaky bucket algorithm using an up/down counter.  A drop is
    -- added to the bucket whenever a soft error occurs and is allowed to leak
    -- out whenever the good cycles counter reaches 2.  Once the bucket fills
    -- (3 drops) it stays full until it is reset by disabling and then enabling
    -- the error detection circuit.

    process (USER_CLK)

        variable leaky_bucket : std_logic_vector(5 downto 0);

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if (ENABLE_ERROR_DETECT = '0') then

                count_r <= "00" after DLY;

            else

                if (soft_error_r(0 to 1) = "00" and good_count_r(0) = '0' ) then
                        count_r <= count_r after DLY;
                end if;

                if (soft_error_r(0 to 1) = "00" and good_count_r(0) = '1'  and count_r = "00") then
                         count_r <= "00" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "00" and good_count_r(0) = '1'  and count_r = "01") then
                        count_r <= "00" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "00" and good_count_r(0) = '1'  and count_r = "10") then
                        count_r <= "01" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "00" and good_count_r(0) = '1'  and count_r = "11") then
                        count_r <= "10" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "01" and good_count_r = "00"  and count_r = "00") then
                        count_r <= "01" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "01" and good_count_r = "01"  and count_r = "00") then
                        count_r <= "01" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "01" and good_count_r = "10"  and count_r = "00") then
                        count_r <= "01" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "01" and good_count_r = "11"  and count_r = "00") then
                        count_r <= "00" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "01" and good_count_r = "00"  and count_r = "01") then
                        count_r <= "10" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "01" and good_count_r = "01"  and count_r = "01") then
                        count_r <= "10" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "01" and good_count_r = "10"  and count_r = "01") then
                        count_r <= "10" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "01" and good_count_r = "11"  and count_r = "01") then
                        count_r <= "01" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "01" and good_count_r = "00"  and count_r = "10") then
                        count_r <= "11" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "01" and good_count_r = "01"  and count_r = "10") then
                        count_r <= "11" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "01" and good_count_r = "10"  and count_r = "10") then
                        count_r <= "11" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "01" and good_count_r = "11"  and count_r = "10") then
                        count_r <= "10" after DLY;
                end if;

               if (soft_error_r(0 to 1) = "01" and count_r = "11") then
                        count_r <= "11" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "10" and count_r = "00") then
                        count_r <= "01" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "10" and count_r = "01") then
                        count_r <= "10" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "10" and count_r = "10") then
                        count_r <= "11" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "10" and count_r = "11") then
                        count_r <= "11" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "11" and count_r = "00") then
                        count_r <= "10" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "11" and count_r = "01") then
                        count_r <= "11" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "11" and count_r = "10") then
                        count_r <= "11" after DLY;
                end if;

                if (soft_error_r(0 to 1) = "11" and count_r = "11") then
                        count_r <= "11" after DLY;
                end if;

            end if;

        end if;

    end process;


    -- Detect when the bucket is full and register the signal.

    process (USER_CLK)

    variable leaky_bucket_v : std_logic_vector(5 downto 0);

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

           if(not ENABLE_ERROR_DETECT = '1') then

             bucket_full_r <= '0' after DLY;

           else

                        bucket_full_r <= '0' after DLY;

                if (soft_error_r(0 to 1) = "01" and good_count_r  = "01" and count_r = "11") then
                        bucket_full_r <= '1' after DLY;
                end if;

                if (soft_error_r(0 to 1) = "01" and good_count_r  = "10" and count_r = "11") then
                        bucket_full_r <= '1' after DLY;
                end if;

                if (soft_error_r(0 to 1) = "10" and count_r = "11") then
                        bucket_full_r <= '1' after DLY;
                end if;

                if (soft_error_r(0 to 1) = "11" and count_r(0) = '1') then
                        bucket_full_r <= '1' after DLY;
                end if;

           end if;

       end if;

    end process;

end RTL;
