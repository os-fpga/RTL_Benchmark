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
--  SYM_DEC
--
--
--
--  Description: The SYM_DEC module is a symbol decoder for the 2-byte
--               Aurora Lane.  Its inputs are the raw data from the GTP.
--               It word-aligns the regular data and decodes all of the
--               Aurora control symbols.  Its outputs are the word-aligned
--               data and signals indicating the arrival of specific
--               control characters.
--
--               This module supports Completion Mode Native Flow Control.
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use WORK.AURORA_PKG.all;

entity aurora_8b10b_v5_1_SYM_DEC is

    port (

    -- RX_LL Interface

            RX_PAD           : out std_logic;                    -- LSByte is PAD.
            RX_PE_DATA       : out std_logic_vector(0 to 15);    -- Word aligned data from channel partner.
            RX_PE_DATA_V     : out std_logic;                    -- Data is valid data and not a control character.
            RX_SCP           : out std_logic;                    -- SCP symbol received.
            RX_ECP           : out std_logic;                    -- ECP symbol received.
            RX_SNF           : out std_logic;                    -- SNF symbol received.
            RX_FC_NB         : out std_logic_vector(0 to 3);     -- Flow Control size code.  Valid with RX_SNF or RX_SUF.

    -- Lane Init SM Interface

            DO_WORD_ALIGN    : in std_logic;                     -- Word alignment is allowed.
            RX_SP            : out std_logic;                    -- SP sequence received with positive or negative data.
            RX_SPA           : out std_logic;                    -- SPA sequence received.
            RX_NEG           : out std_logic;                    -- Intverted data for SP or SPA received.

    -- Global Logic Interface

            GOT_A            : out std_logic_vector(0 to 1);     -- A character received on indicated byte(s).
            GOT_V            : out std_logic;                    -- V sequence received.

    -- GTP Interface

            RX_DATA          : in std_logic_vector(15 downto 0); -- Raw RX data from GTP.
            RX_CHAR_IS_K     : in std_logic_vector(1 downto 0);  -- Bits indicating which bytes are control characters.
            RX_CHAR_IS_COMMA : in std_logic_vector(1 downto 0);  -- Rx'ed a comma.

    -- System Interface

            USER_CLK         : in std_logic;                     -- System clock for all non-GTP Aurora Logic.
            RESET            : in std_logic

         );

end aurora_8b10b_v5_1_SYM_DEC;

architecture RTL of aurora_8b10b_v5_1_SYM_DEC is

-- Parameter Declarations --

    constant DLY            : time := 1 ns;

    constant K_CHAR_0       : std_logic_vector(0 to 3) := X"B";
    constant K_CHAR_1       : std_logic_vector(0 to 3) := X"C";
    constant SP_DATA_0      : std_logic_vector(0 to 3) := X"4";
    constant SP_DATA_1      : std_logic_vector(0 to 3) := X"A";
    constant SPA_DATA_0     : std_logic_vector(0 to 3) := X"2";
    constant SPA_DATA_1     : std_logic_vector(0 to 3) := X"C";
    constant SP_NEG_DATA_0  : std_logic_vector(0 to 3) := X"B";
    constant SP_NEG_DATA_1  : std_logic_vector(0 to 3) := X"5";
    constant SPA_NEG_DATA_0 : std_logic_vector(0 to 3) := X"D";
    constant SPA_NEG_DATA_1 : std_logic_vector(0 to 3) := X"3";
    constant PAD_0          : std_logic_vector(0 to 3) := X"9";
    constant PAD_1          : std_logic_vector(0 to 3) := X"C";
    constant SCP_0          : std_logic_vector(0 to 3) := X"5";
    constant SCP_1          : std_logic_vector(0 to 3) := X"C";
    constant SCP_2          : std_logic_vector(0 to 3) := X"F";
    constant SCP_3          : std_logic_vector(0 to 3) := X"B";
    constant ECP_0          : std_logic_vector(0 to 3) := X"F";
    constant ECP_1          : std_logic_vector(0 to 3) := X"D";
    constant ECP_2          : std_logic_vector(0 to 3) := X"F";
    constant ECP_3          : std_logic_vector(0 to 3) := X"E";
    constant SNF_0          : std_logic_vector(0 to 3) := X"D";
    constant SNF_1          : std_logic_vector(0 to 3) := X"C";
    constant A_CHAR_0       : std_logic_vector(0 to 3) := X"7";
    constant A_CHAR_1       : std_logic_vector(0 to 3) := X"C";
    constant VER_DATA_0     : std_logic_vector(0 to 3) := X"E";
    constant VER_DATA_1     : std_logic_vector(0 to 3) := X"8";

-- External Register Declarations --

    signal RX_PAD_Buffer       : std_logic;
    signal RX_PE_DATA_Buffer   : std_logic_vector(0 to 15);
    signal RX_PE_DATA_V_Buffer : std_logic;
    signal RX_SCP_Buffer       : std_logic;
    signal RX_ECP_Buffer       : std_logic;
    signal RX_SNF_Buffer       : std_logic;
    signal RX_FC_NB_Buffer     : std_logic_vector(0 to 3);
    signal RX_SP_Buffer        : std_logic;
    signal RX_SPA_Buffer       : std_logic;
    signal RX_NEG_Buffer       : std_logic;
    signal GOT_A_Buffer        : std_logic_vector(0 to 1);
    signal GOT_V_Buffer        : std_logic;

-- Internal Register Declarations --

    signal left_aligned_r              : std_logic;
    signal previous_cycle_data_r       : std_logic_vector(0 to 7);
    signal previous_cycle_control_r    : std_logic;
    signal prev_beat_sp_r              : std_logic;
    signal prev_beat_spa_r             : std_logic;
    signal word_aligned_data_r         : std_logic_vector(0 to 15);
    signal word_aligned_control_bits_r : std_logic_vector(0 to 1);
    signal rx_pe_data_r                : std_logic_vector(0 to 15);
    signal rx_pe_control_r             : std_logic_vector(0 to 1);
    signal rx_pad_d_r                  : std_logic_vector(0 to 1);
    signal rx_scp_d_r                  : std_logic_vector(0 to 3);
    signal rx_ecp_d_r                  : std_logic_vector(0 to 3);
    signal rx_snf_d_r                  : std_logic_vector(0 to 1);
    signal prev_beat_sp_d_r            : std_logic_vector(0 to 3);
    signal prev_beat_spa_d_r           : std_logic_vector(0 to 3);
    signal rx_sp_d_r                   : std_logic_vector(0 to 3);
    signal rx_spa_d_r                  : std_logic_vector(0 to 3);
    signal rx_sp_neg_d_r               : std_logic_vector(0 to 1);
    signal rx_spa_neg_d_r              : std_logic_vector(0 to 1);
    signal prev_beat_v_d_r             : std_logic_vector(0 to 3);
    signal prev_beat_v_r               : std_logic;
    signal rx_v_d_r                    : std_logic_vector(0 to 3);
    signal got_a_d_r                   : std_logic_vector(0 to 3);
    signal first_v_received_r          : std_logic := '0';

-- Wire Declarations --

    signal got_v_c : std_logic;

begin

    RX_PAD       <= RX_PAD_Buffer;
    RX_PE_DATA   <= RX_PE_DATA_Buffer;
    RX_PE_DATA_V <= RX_PE_DATA_V_Buffer;
    RX_SCP       <= RX_SCP_Buffer;
    RX_ECP       <= RX_ECP_Buffer;
    RX_SNF       <= RX_SNF_Buffer;
    RX_FC_NB     <= RX_FC_NB_Buffer;
    RX_SP        <= RX_SP_Buffer;
    RX_SPA       <= RX_SPA_Buffer;
    RX_NEG       <= RX_NEG_Buffer;
    GOT_A        <= GOT_A_Buffer;
    GOT_V        <= GOT_V_Buffer;

-- Main Body of Code --

    -- Word Alignment --

    -- Determine whether the lane is aligned to the left byte (MS byte) or the
    -- right byte (LS byte).  This information is used for word alignment.  To
    -- prevent the word align from changing during normal operation, we do word
    -- alignment only when it is allowed by the lane_init_sm.

    process (USER_CLK)

        variable vec : std_logic_vector(0 to 3);

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if ((DO_WORD_ALIGN and not first_v_received_r) = '1') then

                vec := RX_CHAR_IS_COMMA & RX_CHAR_IS_K;

                case vec is

                    when "1010" => left_aligned_r <= '1' after DLY;
                    when "0101" => left_aligned_r <= '0' after DLY;
                    when others => left_aligned_r <= left_aligned_r after DLY;

                end case;

            end if;

        end if;

    end process;


    -- Store the LS byte from the previous cycle.  If the lane is aligned on
    -- the LS byte, we use it as the MS byte on the current cycle.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            previous_cycle_data_r(0) <= RX_DATA(7) after DLY;
            previous_cycle_data_r(1) <= RX_DATA(6) after DLY;
            previous_cycle_data_r(2) <= RX_DATA(5) after DLY;
            previous_cycle_data_r(3) <= RX_DATA(4) after DLY;
            previous_cycle_data_r(4) <= RX_DATA(3) after DLY;
            previous_cycle_data_r(5) <= RX_DATA(2) after DLY;
            previous_cycle_data_r(6) <= RX_DATA(1) after DLY;
            previous_cycle_data_r(7) <= RX_DATA(0) after DLY;

        end if;

    end process;


    -- Store the control bit from the previous cycle LS byte.  It becomes the
    -- control bit for the MS byte on this cycle if the lane is aligned to the
    -- LS byte.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            previous_cycle_control_r <= RX_CHAR_IS_K(0) after DLY;

        end if;

    end process;


    -- Select the word-aligned MS byte.  Use the current MS byte if the data is
    -- left-aligned, otherwise use the LS byte from the previous cycle.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if (left_aligned_r = '1') then

                word_aligned_data_r(0) <= RX_DATA(15) after DLY;
                word_aligned_data_r(1) <= RX_DATA(14) after DLY;
                word_aligned_data_r(2) <= RX_DATA(13) after DLY;
                word_aligned_data_r(3) <= RX_DATA(12) after DLY;
                word_aligned_data_r(4) <= RX_DATA(11) after DLY;
                word_aligned_data_r(5) <= RX_DATA(10) after DLY;
                word_aligned_data_r(6) <= RX_DATA(9) after DLY;
                word_aligned_data_r(7) <= RX_DATA(8) after DLY;

            else

                word_aligned_data_r(0 to 7) <= previous_cycle_data_r after DLY;

            end if;

        end if;

    end process;


    -- Select the word-aligned LS byte.  Use the current LSByte if the data is
    -- right-aligned, otherwise use the current MS byte.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if (left_aligned_r = '1') then

                word_aligned_data_r(8)  <= RX_DATA(7) after DLY;
                word_aligned_data_r(9)  <= RX_DATA(6) after DLY;
                word_aligned_data_r(10) <= RX_DATA(5) after DLY;
                word_aligned_data_r(11) <= RX_DATA(4) after DLY;
                word_aligned_data_r(12) <= RX_DATA(3) after DLY;
                word_aligned_data_r(13) <= RX_DATA(2) after DLY;
                word_aligned_data_r(14) <= RX_DATA(1) after DLY;
                word_aligned_data_r(15) <= RX_DATA(0) after DLY;

            else

                word_aligned_data_r(8)  <= RX_DATA(15) after DLY;
                word_aligned_data_r(9)  <= RX_DATA(14) after DLY;
                word_aligned_data_r(10) <= RX_DATA(13) after DLY;
                word_aligned_data_r(11) <= RX_DATA(12) after DLY;
                word_aligned_data_r(12) <= RX_DATA(11) after DLY;
                word_aligned_data_r(13) <= RX_DATA(10) after DLY;
                word_aligned_data_r(14) <= RX_DATA(9)  after DLY;
                word_aligned_data_r(15) <= RX_DATA(8)  after DLY;

            end if;

        end if;

    end process;


    -- Select the word-aligned MS byte control bit.  Use the current MSByte's
    -- control bit if the data is left-aligned, otherwise use the LS byte's
    -- control bit from the previous cycle.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if (left_aligned_r = '1') then

                word_aligned_control_bits_r(0) <= RX_CHAR_IS_K(1) after DLY;

            else

                word_aligned_control_bits_r(0) <= previous_cycle_control_r after DLY;

            end if;

        end if;

    end process;


    -- Select the word-aligned LS byte control bit.  Use the current LSByte's control
    -- bit if the data is left-aligned, otherwise use the current MS byte's control bit.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if (left_aligned_r = '1') then

                word_aligned_control_bits_r(1) <= RX_CHAR_IS_K(0) after DLY;

            else

                word_aligned_control_bits_r(1) <= RX_CHAR_IS_K(1) after DLY;

            end if;

        end if;

    end process;


    -- Pipeline the word-aligned data for 1 cycle to match the Decodes.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            rx_pe_data_r <= word_aligned_data_r after DLY;

        end if;

    end process;


    -- Register the pipelined word-aligned data for the RX_LL interface.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            RX_PE_DATA_Buffer <= rx_pe_data_r after DLY;

        end if;

    end process;


    -- Decode Control Symbols --

    -- All decodes are pipelined to keep the number of logic levels to a minimum.

    -- Delay the control bits: they are most often used in the second stage of
    -- the decoding process.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            rx_pe_control_r <= word_aligned_control_bits_r after DLY;

        end if;

    end process;


    -- Decode PAD

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            rx_pad_d_r(0) <= std_bool(word_aligned_data_r(8 to 11) = PAD_0) after DLY;
            rx_pad_d_r(1) <= std_bool(word_aligned_data_r(12 to 15) = PAD_1) after DLY;

        end if;

    end process;


    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            RX_PAD_Buffer <= std_bool((rx_pad_d_r = "11") and (rx_pe_control_r = "01")) after DLY;

        end if;

    end process;


    -- Decode RX_PE_DATA_V

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            RX_PE_DATA_V_Buffer <= not rx_pe_control_r(0) after DLY;

        end if;

    end process;


    -- Decode RX_SCP

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            rx_scp_d_r(0) <= std_bool(word_aligned_data_r(0 to 3)   = SCP_0) after DLY;
            rx_scp_d_r(1) <= std_bool(word_aligned_data_r(4 to 7)   = SCP_1) after DLY;
            rx_scp_d_r(2) <= std_bool(word_aligned_data_r(8 to 11)  = SCP_2) after DLY;
            rx_scp_d_r(3) <= std_bool(word_aligned_data_r(12 to 15) = SCP_3) after DLY;

        end if;

    end process;


    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            RX_SCP_Buffer <= rx_pe_control_r(0) and
                             rx_pe_control_r(1) and
                             rx_scp_d_r(0)      and
                             rx_scp_d_r(1)      and
                             rx_scp_d_r(2)      and
                             rx_scp_d_r(3)      after DLY;

        end if;

    end process;


    -- Decode RX_ECP

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            rx_ecp_d_r(0) <= std_bool(word_aligned_data_r(0 to 3)   = ECP_0) after DLY;
            rx_ecp_d_r(1) <= std_bool(word_aligned_data_r(4 to 7)   = ECP_1) after DLY;
            rx_ecp_d_r(2) <= std_bool(word_aligned_data_r(8 to 11)  = ECP_2) after DLY;
            rx_ecp_d_r(3) <= std_bool(word_aligned_data_r(12 to 15) = ECP_3) after DLY;

        end if;

    end process;


    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            RX_ECP_Buffer <= rx_pe_control_r(0) and
                             rx_pe_control_r(1) and
                             rx_ecp_d_r(0)      and
                             rx_ecp_d_r(1)      and
                             rx_ecp_d_r(2)      and
                             rx_ecp_d_r(3)      after DLY;

        end if;

    end process;


    -- Decode RX_SNF

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            rx_snf_d_r(0) <= std_bool(word_aligned_data_r(0 to 3) = SNF_0) after DLY;
            rx_snf_d_r(1) <= std_bool(word_aligned_data_r(4 to 7) = SNF_1) after DLY;

        end if;

    end process;


    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            RX_SNF_Buffer <= rx_pe_control_r(0) and
                             rx_snf_d_r(0)      and
                             rx_snf_d_r(1)      after DLY;

        end if;

    end process;


    -- Extract the Flow Control Size code and register it for the RX_LL interface.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            RX_FC_NB_Buffer <= rx_pe_data_r(8 to 11) after DLY;

        end if;

    end process;


    -- For an SP sequence to be valid, there must be 2 bytes of SP Data preceded
    -- by a Comma and an SP Data byte in the MS byte and LS byte positions
    -- respectively.  This flop stores the decode of the Comma and SP Data byte
    -- combination from the previous cycle.  Data can be positive or negative.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            prev_beat_sp_d_r(0) <= std_bool(word_aligned_data_r(0 to 3)    = K_CHAR_0) after DLY;
            prev_beat_sp_d_r(1) <= std_bool(word_aligned_data_r(4 to 7)    = K_CHAR_1) after DLY;
            prev_beat_sp_d_r(2) <= std_bool((word_aligned_data_r(8 to 11)  = SP_DATA_0) or
                                            (word_aligned_data_r(8 to 11)  = SP_NEG_DATA_0)) after DLY;
            prev_beat_sp_d_r(3) <= std_bool((word_aligned_data_r(12 to 15) = SP_DATA_1) or
                                            (word_aligned_data_r(12 to 15) = SP_NEG_DATA_1)) after DLY;

        end if;

    end process;


    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            prev_beat_sp_r <= std_bool((rx_pe_control_r  = "10") and
                                       (prev_beat_sp_d_r = "1111")) after DLY;

        end if;

    end process;


    -- This flow stores the decode of a Comma and SPA Data byte combination from the
    -- previous cycle.  It is used along with decodes for SPA data in the current
    -- cycle to determine whether an SPA sequence was received.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            prev_beat_spa_d_r(0) <= std_bool(word_aligned_data_r(0 to 3)   = K_CHAR_0) after DLY;
            prev_beat_spa_d_r(1) <= std_bool(word_aligned_data_r(4 to 7)   = K_CHAR_1) after DLY;
            prev_beat_spa_d_r(2) <= std_bool(word_aligned_data_r(8 to 11)  = SPA_DATA_0) after DLY;
            prev_beat_spa_d_r(3) <= std_bool(word_aligned_data_r(12 to 15) = SPA_DATA_1) after DLY;

        end if;

    end process;


    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            prev_beat_spa_r <= std_bool((rx_pe_control_r   = "10") and
                                        (prev_beat_spa_d_r = "1111")) after DLY;

        end if;

    end process;


    -- Indicate the SP sequence was received.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            rx_sp_d_r(0) <= std_bool((word_aligned_data_r(0 to 3)   = SP_DATA_0) or
                                     (word_aligned_data_r(0 to 3)   = SP_NEG_DATA_0)) after DLY;
            rx_sp_d_r(1) <= std_bool((word_aligned_data_r(4 to 7)   = SP_DATA_1) or
                                     (word_aligned_data_r(4 to 7)   = SP_NEG_DATA_1)) after DLY;
            rx_sp_d_r(2) <= std_bool((word_aligned_data_r(8 to 11)  = SP_DATA_0) or
                                     (word_aligned_data_r(8 to 11)  = SP_NEG_DATA_0)) after DLY;
            rx_sp_d_r(3) <= std_bool((word_aligned_data_r(12 to 15) = SP_DATA_1) or
                                     (word_aligned_data_r(12 to 15) = SP_NEG_DATA_1)) after DLY;

        end if;

    end process;


    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            RX_SP_Buffer <= prev_beat_sp_r and
                            std_bool((rx_pe_control_r = "00") and
                                     (rx_sp_d_r       = "1111")) after DLY;

        end if;

    end process;


    -- Indicate the SPA sequence was received.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            rx_spa_d_r(0) <= std_bool(word_aligned_data_r(0 to 3)   = SPA_DATA_0) after DLY;
            rx_spa_d_r(1) <= std_bool(word_aligned_data_r(4 to 7)   = SPA_DATA_1) after DLY;
            rx_spa_d_r(2) <= std_bool(word_aligned_data_r(8 to 11)  = SPA_DATA_0) after DLY;
            rx_spa_d_r(3) <= std_bool(word_aligned_data_r(12 to 15) = SPA_DATA_1) after DLY;

        end if;

    end process;


    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            RX_SPA_Buffer <= prev_beat_spa_r and
                             std_bool((rx_pe_control_r = "00") and
                                      (rx_spa_d_r      = "1111")) after DLY;

        end if;

    end process;


    -- Indicate reversed data received.  We look only at the word-aligned LS byte
    -- which, during an /SP/ or /SPA/ sequence, will always contain a data byte.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            rx_sp_neg_d_r(0)  <= std_bool(word_aligned_data_r(8 to 11)  = SP_NEG_DATA_0) after DLY;
            rx_sp_neg_d_r(1)  <= std_bool(word_aligned_data_r(12 to 15) = SP_NEG_DATA_1) after DLY;
            rx_spa_neg_d_r(0) <= std_bool(word_aligned_data_r(8 to 11)  = SPA_NEG_DATA_0) after DLY;
            rx_spa_neg_d_r(1) <= std_bool(word_aligned_data_r(12 to 15) = SPA_NEG_DATA_1) after DLY;

        end if;

    end process;


    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            RX_NEG_Buffer <= not rx_pe_control_r(1) and
                             std_bool((rx_sp_neg_d_r  = "11") or
                                      (rx_spa_neg_d_r = "11")) after DLY;

        end if;

    end process;


    -- GOT_A is decoded from the non_word-aligned input.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            got_a_d_r(0) <= std_bool(word_aligned_data_r(0 to 3)   = A_CHAR_0) after DLY;
            got_a_d_r(1) <= std_bool(word_aligned_data_r(4 to 7)   = A_CHAR_1) after DLY;
            got_a_d_r(2) <= std_bool(word_aligned_data_r(8 to 11)  = A_CHAR_0) after DLY;
            got_a_d_r(3) <= std_bool(word_aligned_data_r(12 to 15) = A_CHAR_1) after DLY;

        end if;

    end process;


    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            GOT_A_Buffer(0) <= rx_pe_control_r(0) and std_bool(got_a_d_r(0 to 1) = "11") after DLY;
            GOT_A_Buffer(1) <= rx_pe_control_r(1) and std_bool(got_a_d_r(2 to 3) = "11") after DLY;

        end if;

    end process;


    -- Verification symbol decode --

    -- This flow stores the decode of a Comma and SPA Data byte combination from the
    -- previous cycle.  It is used along with decodes for SPA data in the current
    -- cycle to determine whether an SPA sequence was received.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            prev_beat_v_d_r(0) <= std_bool(word_aligned_data_r(0 to 3)   = K_CHAR_0) after DLY;
            prev_beat_v_d_r(1) <= std_bool(word_aligned_data_r(4 to 7)   = K_CHAR_1) after DLY;
            prev_beat_v_d_r(2) <= std_bool(word_aligned_data_r(8 to 11)  = VER_DATA_0) after DLY;
            prev_beat_v_d_r(3) <= std_bool(word_aligned_data_r(12 to 15) = VER_DATA_1) after DLY;

        end if;

    end process;


    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            prev_beat_v_r <= std_bool((rx_pe_control_r = "10") and
                                      (prev_beat_v_d_r = "1111")) after DLY;

        end if;

    end process;


    -- Indicate the SP sequence was received.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            rx_v_d_r(0) <= std_bool(word_aligned_data_r(0 to 3)   = VER_DATA_0) after DLY;
            rx_v_d_r(1) <= std_bool(word_aligned_data_r(4 to 7)   = VER_DATA_1) after DLY;
            rx_v_d_r(2) <= std_bool(word_aligned_data_r(8 to 11)  = VER_DATA_0) after DLY;
            rx_v_d_r(3) <= std_bool(word_aligned_data_r(12 to 15) = VER_DATA_1) after DLY;

        end if;

    end process;


    got_v_c <= prev_beat_v_r and
               std_bool((rx_pe_control_r = "00") and
                        (rx_v_d_r        = "1111"));

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            GOT_V_Buffer <= got_v_c after DLY;

        end if;

    end process;


    -- Remember that the first V sequence has been detected.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if (RESET = '1') then

                first_v_received_r <= '0' after DLY;

            else

                if (got_v_c = '1') then

                    first_v_received_r <= '1' after DLY;

                end if;

            end if;

        end if;

    end process;

end RTL;
