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
--  RX_LL_NFC
--
--
--
--  Description: the RX_LL_NFC module detects, decodes and executes NFC messages
--               from the channel partner. When a message is recieved, the module
--               signals the TX_LL module that idles are required until the number
--               of idles the TX_LL module sends are enough to fulfil the request.
--
--               This module supports 2 2-byte lane designs
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use WORK.AURORA_PKG.all;

entity aurora_8b10b_v5_1_RX_LL_NFC is

    port (

    -- Aurora Lane Interface

            RX_SNF        : in  std_logic_vector(0 to 1);
            RX_FC_NB      : in  std_logic_vector(0 to 7);

    -- TX_LL Interface

            DECREMENT_NFC : in  std_logic;
            TX_WAIT       : out std_logic;

    -- Global Logic Interface

            CHANNEL_UP    : in  std_logic;

    -- USER Interface

            USER_CLK      : in  std_logic

         );

end aurora_8b10b_v5_1_RX_LL_NFC;

architecture RTL of aurora_8b10b_v5_1_RX_LL_NFC is

-- Parameter Declarations --

    constant DLY : time := 1 ns;

-- External Register Declarations --

    signal TX_WAIT_Buffer : std_logic;

-- Internal Register Declarations --

    signal load_nfc_r           : std_logic;
    signal fcnb_r               : std_logic_vector(0 to 3);
    signal nfc_counter_r        : std_logic_vector(0 to 8);
    signal xoff_r               : std_logic;
    signal fcnb_decode_c        : std_logic_vector(0 to 8);
    signal nfc_lane_index_r     : std_logic_vector(0 to 1);
    signal stage_1_load_nfc_r   : std_logic;
    signal channel_fcnb_r       : std_logic_vector(0 to 7);
    signal nfc_lane_index_c     : std_logic_vector(0 to 1);
    signal fcnb_c               : std_logic_vector(0 to 3);

begin

    TX_WAIT <= TX_WAIT_Buffer;

-- Main Body of Code --

    -- ________________Stage 1: Detect the most recent NFC message __________________

    -- Search for SNFs in the channel.  Output the index of the rightmost Lane in the
    -- channel constaining an SNF.
    process (RX_SNF)
    begin
        case RX_SNF is
            when "01" =>
                nfc_lane_index_c <= conv_std_logic_vector(1,2);
            when "10" =>
                nfc_lane_index_c <= conv_std_logic_vector(0,2);
            when "11" =>
                nfc_lane_index_c <= conv_std_logic_vector(1,2);
            when others =>
                nfc_lane_index_c <= (others => '0');
        end case;
    end process;


    -- Register the index of the most recent NFC lane.
    process (USER_CLK)
    begin
        if (USER_CLK 'event and USER_CLK = '1') then
            nfc_lane_index_r <= nfc_lane_index_c after DLY;
        end if;
    end process;


    -- Generate the load NFC signal if an NFC signal is detected.
    process (USER_CLK)
    begin
        if (USER_CLK 'event and USER_CLK = '1') then
            stage_1_load_nfc_r <= std_bool(RX_SNF /= "00") after DLY;
        end if;
    end process;


    -- Register all the FC_NB signals.
    process (USER_CLK)
    begin
        if (USER_CLK 'event and USER_CLK = '1') then
            channel_fcnb_r <= RX_FC_NB after DLY;
        end if;
    end process;


    -- __________________Stage 2: Register the correct FCNB code ____________________

    -- Pipeline the load_nfc signal.
    process (USER_CLK)
    begin
        if (USER_CLK 'event and USER_CLK = '1') then
            if (CHANNEL_UP = '0') then
                load_nfc_r <= '0' after DLY;
            else
                load_nfc_r <= stage_1_load_nfc_r after DLY;
            end if;
        end if;
    end process;


    -- Select the appropriate FCNB code.
    process (nfc_lane_index_r, channel_fcnb_r)
    begin
        case nfc_lane_index_r is
            when "00" =>
                fcnb_c <= channel_fcnb_r(0 to 3);
            when "01" =>
                fcnb_c <= channel_fcnb_r(4 to 7);
            when others =>
                fcnb_c <= (others => '0');
        end case;
    end process;


    -- Register the selected FCNB code.
    process (USER_CLK)
    begin
        if (USER_CLK 'event and USER_CLK = '1') then
            if (CHANNEL_UP = '0') then
                fcnb_r <= "0000" after DLY;
            else
                fcnb_r <= fcnb_c after DLY;
            end if;
        end if;
    end process;


    -- __________________Stage 3: Use the FCNB code to set the counter _____________

    -- We use a counter to keep track of the number of dead cycles we must produce to
    -- satisfy the NFC request from the Channel Partner.  Note we *increment* nfc_counter
    -- when decrement NFC is asserted.  This is because the nfc counter uses the difference
    -- between the max value and the current value to determine how many cycles to demand
    -- a pause.  This allows us to use the carry chain more effectively to save LUTS, and
    -- gives us a registered output from the counter.

    process (USER_CLK)
    begin
        if (USER_CLK 'event and USER_CLK = '1') then
            if (CHANNEL_UP = '0') then
                nfc_counter_r <= "100000000" after DLY;
            else
                if (load_nfc_r = '1') then
                    nfc_counter_r <= fcnb_decode_c after DLY;
                else
                    if ((not nfc_counter_r(0) and (DECREMENT_NFC and not xoff_r)) = '1') then
                        nfc_counter_r <= nfc_counter_r + "000000001" after DLY;
                    end if;
                end if;
            end if;
        end if;
    end process;


    -- We load the counter with a decoded version of the FCNB code.  The decode values are
    -- chosen such that the counter will assert TX_WAIT for the number of cycles required
    -- by the FCNB code.

    process (fcnb_r)
    begin
        case fcnb_r is
            when "0000" =>
                fcnb_decode_c <= "100000000"; -- XON
            when "0001" =>
                fcnb_decode_c <= "011111110"; -- 2
            when "0010" =>
                fcnb_decode_c <= "011111100"; -- 4
            when "0011" =>
                fcnb_decode_c <= "011111000"; -- 8
            when "0100" =>
                fcnb_decode_c <= "011110000"; -- 16
            when "0101" =>
                fcnb_decode_c <= "011100000"; -- 32
            when "0110" =>
                fcnb_decode_c <= "011000000"; -- 64
            when "0111" =>
                fcnb_decode_c <= "010000000"; -- 128
            when "1000" =>
                fcnb_decode_c <= "000000000"; -- 256
            when "1111" =>
                fcnb_decode_c <= "000000000"; -- 8
            when others =>
                fcnb_decode_c <= "100000000"; -- 8
        end case;
    end process;


    -- The XOFF signal forces an indefinite wait.  We decode FCNB to determine whether
    -- XOFF should be asserted.
    process (USER_CLK)
    begin
        if (USER_CLK 'event and USER_CLK = '1') then
            if (CHANNEL_UP = '0') then
                xoff_r <= '0' after DLY;
            else
                if (load_nfc_r = '1') then
                    if (fcnb_r = "1111") then
                        xoff_r <= '1' after DLY;
                    else
                        xoff_r <= '0' after DLY;
                    end if;
                end if;
            end if;
        end if;
    end process;


    -- The TXWAIT signal comes from the MSBit of the counter.  We wait whenever the counter
    -- is not at max value.

    TX_WAIT_Buffer <= not nfc_counter_r(0);

end RTL;
