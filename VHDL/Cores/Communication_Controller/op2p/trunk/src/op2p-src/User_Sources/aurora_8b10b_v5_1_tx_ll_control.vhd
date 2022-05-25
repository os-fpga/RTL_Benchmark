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
--  TX_LL_CONTROL
--
--
--
--  Description: This module provides the transmitter state machine
--               control logic to connect the LocalLink interface to
--               the Aurora Channel.
--
--               This module supports 2 2-byte lane designs
--
--               This module supports Completion Mode Native Flow Control.
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use WORK.AURORA_PKG.all;

-- synthesis translate_off
library UNISIM;
use UNISIM.all;
-- synthesis translate_on

entity aurora_8b10b_v5_1_TX_LL_CONTROL is

    port (

    -- LocalLink PDU Interface

            TX_SRC_RDY_N  : in std_logic;
            TX_SOF_N      : in std_logic;
            TX_EOF_N      : in std_logic;
            TX_REM        : in std_logic_vector(0 to 1);
            TX_DST_RDY_N  : out std_logic;

    -- NFC Interface

            NFC_REQ_N     : in std_logic;
            NFC_NB        : in std_logic_vector(0 to 3);
            NFC_ACK_N     : out std_logic;

    -- Clock Compensation Interface

            WARN_CC       : in std_logic;
            DO_CC         : in std_logic;

    -- Global Logic Interface

            CHANNEL_UP    : in std_logic;

    -- TX_LL Control Module Interface

            HALT_C        : out std_logic;

    -- Aurora Lane Interface

            GEN_SCP       : out std_logic;
            GEN_ECP       : out std_logic;
            GEN_SNF       : out std_logic;
            FC_NB         : out std_logic_vector(0 to 3);
            GEN_CC        : out std_logic_vector(0 to 1);

    -- RX_LL Interface

            TX_WAIT       : in std_logic;
            DECREMENT_NFC : out std_logic;

    -- System Interface

            USER_CLK      : in std_logic

         );

end aurora_8b10b_v5_1_TX_LL_CONTROL;

architecture RTL of aurora_8b10b_v5_1_TX_LL_CONTROL is

-- Parameter Declarations --

    constant DLY : time := 1 ns;

-- External Register Declarations --

    signal TX_DST_RDY_N_Buffer  : std_logic;
    signal NFC_ACK_N_Buffer     : std_logic;
    signal HALT_C_Buffer        : std_logic;
    signal GEN_SCP_Buffer       : std_logic;
    signal GEN_ECP_Buffer       : std_logic;
    signal GEN_SNF_Buffer       : std_logic;
    signal FC_NB_Buffer         : std_logic_vector(0 to 3);
    signal GEN_CC_Buffer        : std_logic_vector(0 to 1);
    signal DECREMENT_NFC_Buffer : std_logic;

-- Internal Register Declarations --

    signal do_cc_r                      : std_logic;
    signal do_nfc_r                     : std_logic;

    signal idle_r                       : std_logic;
    signal sof_to_data_r                : std_logic;
    signal data_r                       : std_logic;
    signal data_to_eof_1_r              : std_logic;
    signal data_to_eof_2_r              : std_logic;
    signal eof_r                        : std_logic;
    signal sof_to_eof_1_r               : std_logic;
    signal sof_to_eof_2_r               : std_logic;
    signal sof_and_eof_r                : std_logic;

-- Wire Declarations --

    signal nfc_ok_c              : std_logic;

    signal next_idle_c           : std_logic;
    signal next_sof_to_data_c    : std_logic;
    signal next_data_c           : std_logic;
    signal next_data_to_eof_1_c  : std_logic;
    signal next_data_to_eof_2_c  : std_logic;
    signal next_eof_c            : std_logic;
    signal next_sof_to_eof_1_c   : std_logic;
    signal next_sof_to_eof_2_c   : std_logic;
    signal next_sof_and_eof_c    : std_logic;

    signal fc_nb_c               : std_logic_vector(0 to 3);
    signal tx_dst_rdy_n_c        : std_logic;
    signal do_sof_c              : std_logic;
    signal do_eof_c              : std_logic;
    signal channel_full_c        : std_logic;
    signal pdu_ok_c              : std_logic;

-- Declarations to handle VHDL limitations
    signal reset_i               : std_logic;

-- Component Declarations --

    component FDR

        generic (INIT : bit := '0');

        port (

                Q : out std_ulogic;
                C : in  std_ulogic;
                D : in  std_ulogic;
                R : in  std_ulogic

             );

    end component;

begin

    TX_DST_RDY_N  <= TX_DST_RDY_N_Buffer;
    NFC_ACK_N     <= NFC_ACK_N_Buffer;
    HALT_C        <= HALT_C_Buffer;
    GEN_SCP       <= GEN_SCP_Buffer;
    GEN_ECP       <= GEN_ECP_Buffer;
    GEN_SNF       <= GEN_SNF_Buffer;
    FC_NB         <= FC_NB_Buffer;
    GEN_CC        <= GEN_CC_Buffer;
    DECREMENT_NFC <= DECREMENT_NFC_Buffer;

-- Main Body of Code --



    reset_i <=  not CHANNEL_UP;


    -- Clock Compensation --

    -- Register the DO_CC and WARN_CC signals for internal use.  Note that the raw DO_CC
    -- signal is used for some logic so the DO_CC signal should be driven directly
    -- from a register whenever possible.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then
                do_cc_r <= DO_CC after DLY;
        end if;

    end process;

    -- NFC State Machine --

    -- The NFC state machine has 2 states: waiting for an NFC request, and
    -- sending an NFC message.  It can take over the channel at any time
    -- except when there is a UFC message or a CC sequence in progress.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if (CHANNEL_UP = '0') then

                do_nfc_r <= '0' after DLY;

            else

                if (do_nfc_r = '0') then

                    do_nfc_r <= not NFC_REQ_N and nfc_ok_c after DLY;

                else

                    do_nfc_r <= '0' after DLY;

                end if;

            end if;

        end if;

    end process;


    -- You can only send an NFC message when there is no CC operation or UFC
    -- message in progress.  We also prohibit NFC messages just before CC to
    -- prevent collisions on the first cycle.

    nfc_ok_c <= not DO_CC and
                not WARN_CC;


    NFC_ACK_N_Buffer <= not do_nfc_r;


    -- PDU State Machine --

    -- The PDU state machine handles the encapsulation and transmission of user
    -- PDUs.  It can use the channel when there is no CC, NFC message, UFC header,
    -- UFC message or remote NFC request.

    -- State Registers

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if (CHANNEL_UP = '0') then

                idle_r          <= '1' after DLY;
                sof_to_data_r   <= '0' after DLY;
                data_r          <= '0' after DLY;
                data_to_eof_1_r <= '0' after DLY;
                data_to_eof_2_r <= '0' after DLY;
                eof_r           <= '0' after DLY;
                sof_to_eof_1_r  <= '0' after DLY;
                sof_to_eof_2_r  <= '0' after DLY;
                sof_and_eof_r   <= '0' after DLY;

            else

                if (pdu_ok_c = '1') then

                    idle_r          <= next_idle_c          after DLY;
                    sof_to_data_r   <= next_sof_to_data_c   after DLY;
                    data_r          <= next_data_c          after DLY;
                    data_to_eof_1_r <= next_data_to_eof_1_c after DLY;
                    data_to_eof_2_r <= next_data_to_eof_2_c after DLY;
                    eof_r           <= next_eof_c           after DLY;
                    sof_to_eof_1_r  <= next_sof_to_eof_1_c  after DLY;
                    sof_to_eof_2_r  <= next_sof_to_eof_2_c  after DLY;
                    sof_and_eof_r   <= next_sof_and_eof_c   after DLY;

                end if;

            end if;

        end if;

    end process;


    -- Next State Logic

    next_idle_c          <= (idle_r and not do_sof_c)          or
                            (data_to_eof_2_r and not do_sof_c) or
                            (eof_r and not do_sof_c)           or
                            (sof_to_eof_2_r and not do_sof_c)  or
                            (sof_and_eof_r and not do_sof_c);


    next_sof_to_data_c   <= ((idle_r and do_sof_c) and not do_eof_c)          or
                            ((data_to_eof_2_r and do_sof_c) and not do_eof_c) or
                            ((eof_r and do_sof_c) and not do_eof_c)           or
                            ((sof_to_eof_2_r and do_sof_c) and not do_eof_c)  or
                            ((sof_and_eof_r and do_sof_c) and not do_eof_c);


    next_data_c          <= (sof_to_data_r and not do_eof_c) or
                            (data_r and not do_eof_c);


    next_data_to_eof_1_c <= ((sof_to_data_r and do_eof_c) and channel_full_c) or
                            ((data_r and do_eof_c) and channel_full_c);


    next_data_to_eof_2_c <= data_to_eof_1_r;


    next_eof_c           <= ((sof_to_data_r and do_eof_c) and not channel_full_c) or
                            ((data_r and do_eof_c) and not channel_full_c);


    next_sof_to_eof_1_c  <= (((idle_r and do_sof_c) and do_eof_c) and channel_full_c)          or
                            (((data_to_eof_2_r and do_sof_c) and do_eof_c) and channel_full_c) or
                            (((eof_r and do_sof_c) and do_eof_c) and channel_full_c)           or
                            (((sof_to_eof_2_r and do_sof_c) and do_eof_c) and channel_full_c)  or
                            (((sof_and_eof_r and do_sof_c) and do_eof_c) and channel_full_c);


    next_sof_to_eof_2_c  <= sof_to_eof_1_r;


    next_sof_and_eof_c   <= (((idle_r and do_sof_c) and do_eof_c) and not channel_full_c)          or
                            (((data_to_eof_2_r and do_sof_c) and do_eof_c) and not channel_full_c) or
                            (((eof_r and do_sof_c) and do_eof_c) and not channel_full_c)           or
                            (((sof_to_eof_2_r and do_sof_c) and do_eof_c) and not channel_full_c)  or
                            (((sof_and_eof_r and do_sof_c) and do_eof_c) and not channel_full_c);


    -- Drive the GEN_SCP signal when in an SOF state with the PDU state machine active.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if (CHANNEL_UP = '0') then

                GEN_SCP_Buffer <= '0' after DLY;

            else

                GEN_SCP_Buffer <= (sof_to_data_r  or
                                   sof_to_eof_1_r or
                                   sof_and_eof_r) and
                                   pdu_ok_c after DLY;

            end if;

        end if;

    end process;


    -- Drive the GEN_ECP signal when in an EOF state with the PDU state machine active.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if (CHANNEL_UP = '0') then

                GEN_ECP_Buffer <= '0' after DLY;

            else

                GEN_ECP_Buffer <= (data_to_eof_2_r or
                                   eof_r           or
                                   sof_to_eof_2_r  or
                                   sof_and_eof_r)  and
                                   pdu_ok_c after DLY;

            end if;

        end if;

    end process;


    -- TX_DST_RDY is the critical path in this module.  It must be deasserted (high)
    -- whenever an event occurs that prevents the PDU state machine from using the
    -- Aurora channel to transmit PDUs.

    tx_dst_rdy_n_c <= (next_data_to_eof_1_c and pdu_ok_c)            or
                     ((not do_nfc_r and not NFC_REQ_N) and nfc_ok_c) or
                       DO_CC                                         or
                      (TX_WAIT and not(next_data_c or next_sof_to_eof_1_c or next_sof_to_data_c)) or
                      (next_sof_to_eof_1_c and pdu_ok_c)             or
                      (sof_to_eof_1_r and not pdu_ok_c)              or
                      (data_to_eof_1_r and not pdu_ok_c);


    -- The flops for the GEN_CC signal are replicated for timing and instantiated to allow us
    -- to set their value reliably on powerup.

    gen_cc_flop_0_i : FDR

        port map (

                    D => do_cc_r,
                    C => USER_CLK,
                    R => reset_i,
                    Q => GEN_CC_Buffer(0)

                 );


    gen_cc_flop_1_i : FDR

        port map (

                    D => do_cc_r,
                    C => USER_CLK,
                    R => reset_i,
                    Q => GEN_CC_Buffer(1)

                 );


    -- GEN_SNF is asserted whenever the NFC state machine is not idle.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if (CHANNEL_UP = '0') then

                GEN_SNF_Buffer <= '0'      after DLY;

            else

                GEN_SNF_Buffer <= do_nfc_r after DLY;

            end if;

        end if;

    end process;


    -- FC_NB carries flow control codes to the Lane Logic.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            FC_NB_Buffer <= fc_nb_c after DLY;

        end if;

    end process;


    -- Flow control codes come from the NFC_NB input.

    fc_nb_c <= NFC_NB;


    -- The TX_DST_RDY_N signal is registered.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if (CHANNEL_UP = '0') then

                TX_DST_RDY_N_Buffer <= '1' after DLY;

            else

                TX_DST_RDY_N_Buffer <= tx_dst_rdy_n_c after DLY;

            end if;

        end if;

    end process;


    -- Decrement the NFC pause required count whenever the state machine prevents new
    -- PDU data from being sent except when the data is prevented by CC characters.

    DECREMENT_NFC_Buffer <= TX_DST_RDY_N_Buffer and not do_cc_r;


    -- Helper Logic

    -- SOF requests are valid when TX_SRC_RDY_N. TX_DST_RDY_N and TX_SOF_N are asserted

    do_sof_c <=     not TX_SRC_RDY_N            and
                    not TX_DST_RDY_N_Buffer     and
                    not TX_SOF_N;    


    -- EOF requests are valid when TX_SRC_RDY_N, TX_DST_RDY_N and TX_EOF_N are asserted

    do_eof_c <=     not TX_SRC_RDY_N            and
                    not TX_DST_RDY_N_Buffer     and
                    not TX_EOF_N;
                 
                 


    -- Freeze the PDU state machine when CCs or NFCs must be handled.

    pdu_ok_c <= not do_cc_r and
                not do_nfc_r;


    -- Halt the flow of data through the datastream when the PDU state machine is frozen.

    HALT_C_Buffer <= not pdu_ok_c;


    -- The aurora channel is 'full' if there is more than enough data to fit into
    -- a channel that is already carrying an SCP and an ECP character.

    channel_full_c <= '1';

end RTL;
