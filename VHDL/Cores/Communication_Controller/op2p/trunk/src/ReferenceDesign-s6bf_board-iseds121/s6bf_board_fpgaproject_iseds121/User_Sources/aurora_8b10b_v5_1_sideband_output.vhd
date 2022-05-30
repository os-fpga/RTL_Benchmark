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
--  SIDEBAND_OUTPUT
--
--
--  Description: SIDEBAND_OUTPUT generates the SRC_RDY_N, EOF_N, SOF_N and
--               RX_REM signals for the RX localLink interface.
--
--               This module supports 2 2-byte lane designs.
--
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use WORK.AURORA_PKG.all;

entity aurora_8b10b_v5_1_SIDEBAND_OUTPUT is

    port (

            LEFT_ALIGNED_COUNT : in std_logic_vector(0 to 1);
            STORAGE_COUNT      : in std_logic_vector(0 to 1);
            END_BEFORE_START   : in std_logic;
            END_AFTER_START    : in std_logic;
            START_DETECTED     : in std_logic;
            START_WITH_DATA    : in std_logic;
            PAD                : in std_logic;
            FRAME_ERROR        : in std_logic;
            USER_CLK           : in std_logic;
            RESET              : in std_logic;
            END_STORAGE        : out std_logic;
            SRC_RDY_N          : out std_logic;
            SOF_N              : out std_logic;
            EOF_N              : out std_logic;
            RX_REM             : out std_logic_vector(0 to 1);
            FRAME_ERROR_RESULT : out std_logic

         );

end aurora_8b10b_v5_1_SIDEBAND_OUTPUT;

architecture RTL of aurora_8b10b_v5_1_SIDEBAND_OUTPUT is

-- Parameter Declarations --

    constant DLY : time := 1 ns;

-- External Register Declarations --

    signal END_STORAGE_Buffer        : std_logic;
    signal SRC_RDY_N_Buffer          : std_logic;
    signal SOF_N_Buffer              : std_logic;
    signal EOF_N_Buffer              : std_logic;
    signal RX_REM_Buffer             : std_logic_vector(0 to 1);
    signal FRAME_ERROR_RESULT_Buffer : std_logic;

-- Internal Register Declarations --

    signal start_next_r    : std_logic;
    signal start_storage_r : std_logic;
    signal end_storage_r   : std_logic;
    signal pad_storage_r   : std_logic;
    signal rx_rem_c        : std_logic_vector(0 to 2);

-- Wire Declarations --

    signal word_valid_c        : std_logic;
    signal total_lanes_c       : std_logic_vector(0 to 2);
    signal excess_c            : std_logic;
    signal storage_not_empty_c : std_logic;

begin

    END_STORAGE        <= END_STORAGE_Buffer;
    SRC_RDY_N          <= SRC_RDY_N_Buffer;
    SOF_N              <= SOF_N_Buffer;
    EOF_N              <= EOF_N_Buffer;
    RX_REM             <= RX_REM_Buffer;
    FRAME_ERROR_RESULT <= FRAME_ERROR_RESULT_Buffer;

-- Main Body of Code --

    -- Storage not Empty --

    -- Determine whether there is any data in storage.

    storage_not_empty_c <= std_bool(STORAGE_COUNT /= conv_std_logic_vector(0,2));


    -- Start Next Register --

    -- start_next_r indicates that the Start Storage Register should be set on the next
    -- cycle.  This condition occurs when an old frame ends, filling storage with ending
    -- data, and the SCP for the next cycle arrives on the same cycle.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if ((RESET or FRAME_ERROR) = '1') then

                start_next_r <= '0' after DLY;

            else

                start_next_r <= (START_DETECTED and
                                not START_WITH_DATA) and
                                not END_AFTER_START after DLY;

            end if;

        end if;

    end process;


    -- Start Storage Register --

    -- Setting the start storage register indicates the data in storage is from
    -- the start of a frame.  The register is cleared when the data in storage is sent
    -- to the output.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if ((RESET or FRAME_ERROR) = '1') then

                start_storage_r <= '0' after DLY;

            else

                if ((start_next_r or START_WITH_DATA) = '1') then

                    start_storage_r <= '1' after DLY;

                else

                    if (word_valid_c = '1') then

                        start_storage_r <= '0' after DLY;

                    end if;

                end if;

            end if;

        end if;

    end process;


    -- End Storage Register --

    -- Setting the end storage register indicates the data in storage is from the end
    -- of a frame.  The register is cleared when the data in storage is sent to the output.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if ((RESET or FRAME_ERROR) = '1') then

                end_storage_r <= '0' after DLY;

            else

                if ((((END_BEFORE_START and not START_WITH_DATA) and std_bool(total_lanes_c /= "000")) or
                    (END_AFTER_START and START_WITH_DATA)) = '1') then

                    end_storage_r <= '1' after DLY;

                else

                    end_storage_r <= '0' after DLY;

                end if;

            end if;

        end if;

    end process;


    END_STORAGE_Buffer <=  end_storage_r;


    -- Pad Storage Register --

    -- Setting the pad storage register indicates that the data in storage had a pad
    -- character associated with it.  The register is cleared when the data in storage
    -- is sent to the output.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if ((RESET or FRAME_ERROR) = '1') then

                pad_storage_r <= '0' after DLY;

            else

                if (PAD = '1') then

                    pad_storage_r <= '1' after DLY;

                else

                    if (word_valid_c = '1') then

                        pad_storage_r <= '0' after DLY;

                    end if;

                end if;

            end if;

        end if;

    end process;


    -- Word Valid signal and SRC_RDY register --

    -- The word valid signal indicates that the output word has valid data.  This can
    -- only occur when data is removed from storage.  Furthermore, the data must be
    -- marked as valid so that the user knows to read the data as it appears on the
    -- LocalLink interface.

    word_valid_c <= (END_BEFORE_START and START_WITH_DATA) or
                    (excess_c and not START_WITH_DATA) or
                    (end_storage_r);


    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if ((RESET or FRAME_ERROR) = '1') then

                SRC_RDY_N_Buffer <= '1' after DLY;

            else

                SRC_RDY_N_Buffer <= not word_valid_c after DLY;

            end if;

        end if;

    end process;


    -- Frame error result signal --
    -- Indicate a frame error whenever the deframer detects a frame error, or whenever
    -- a frame without data is detected.
    -- Empty frames are detected by looking for frames that end while the storage
    -- register is empty. We must be careful not to confuse the data from seperate
    -- frames.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            FRAME_ERROR_RESULT_Buffer <= FRAME_ERROR or

                                         (END_AFTER_START and not START_WITH_DATA) or
                                         (END_BEFORE_START and std_bool(total_lanes_c = "000") and not START_WITH_DATA) or
                                         (END_BEFORE_START and START_WITH_DATA and not storage_not_empty_c) after DLY;

        end if;

    end process;




    -- The total_lanes and excess signals --

    -- When there is too much data to put into storage, the excess signal is asserted.

    total_lanes_c <= conv_std_logic_vector(0,3) + LEFT_ALIGNED_COUNT + STORAGE_COUNT;

    excess_c <= std_bool(total_lanes_c > conv_std_logic_vector(2,3));


    -- The Start of Frame signal --

    -- To save logic, start of frame is asserted from the time the start of a frame
    -- is placed in storage to the time it is placed on the locallink output register.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            SOF_N_Buffer <= not start_storage_r after DLY;

        end if;

    end process;


    -- The end of frame signal --

    -- End of frame is asserted when storage contains ended data, or when an ECP arrives
    -- at the same time as new data that must replace old data in storage.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            EOF_N_Buffer <= not (end_storage_r or ((END_BEFORE_START and
                START_WITH_DATA) and storage_not_empty_c)) after DLY;

        end if;

    end process;


    -- The RX_REM signal --

    -- RX_REM is equal to the number of bytes written to the output, minus 1 if there is
    -- a pad.

    process (PAD, pad_storage_r, START_WITH_DATA, end_storage_r, STORAGE_COUNT, total_lanes_c)

    begin

        if ((end_storage_r or START_WITH_DATA) = '1') then

            if (pad_storage_r = '1') then

                rx_rem_c <= conv_std_logic_vector(0,3) + ((STORAGE_COUNT & '0') - conv_std_logic_vector(2,3));

            else

                rx_rem_c <= conv_std_logic_vector(0,3) + ((STORAGE_COUNT & '0') - conv_std_logic_vector(1,3));

            end if;


        else

            if ((PAD or pad_storage_r) = '1') then

                rx_rem_c <= (total_lanes_c(1 to 2) & '0') - conv_std_logic_vector(2,3);

            else

                rx_rem_c <= (total_lanes_c(1 to 2) & '0') - conv_std_logic_vector(1,3);

            end if;


        end if;

    end process;


    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            RX_REM_Buffer <= rx_rem_c(1 to 2) after DLY;

        end if;

    end process;

end RTL;
