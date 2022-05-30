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
--  RX_LL
--
--
--
--  Description: The RX_LL module receives data from the Aurora Channel,
--               converts it to LocalLink and sends it to the user interface.
--               It also handles NFC and UFC messages.
--
--               This module supports 2 2-byte lane designs.
--
--               This module supports Completion Mode Native Flow Control.
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity aurora_8b10b_v5_1_RX_LL is

    port (

    -- LocalLink PDU Interface

            RX_D             : out std_logic_vector(0 to 31);
            RX_REM           : out std_logic_vector(0 to 1);
            RX_SRC_RDY_N     : out std_logic;
            RX_SOF_N         : out std_logic;
            RX_EOF_N         : out std_logic;

    -- Global Logic Interface

            START_RX         : in std_logic;

    -- Aurora Lane Interface

            RX_PAD           : in std_logic_vector(0 to 1);
            RX_PE_DATA       : in std_logic_vector(0 to 31);
            RX_PE_DATA_V     : in std_logic_vector(0 to 1);
            RX_SCP           : in std_logic_vector(0 to 1);
            RX_ECP           : in std_logic_vector(0 to 1);
            RX_SNF           : in std_logic_vector(0 to 1);
            RX_FC_NB         : in std_logic_vector(0 to 7);

    -- TX_LL Interface

            DECREMENT_NFC    : in std_logic;
            TX_WAIT          : out std_logic;

    -- Error Interface

            FRAME_ERROR      : out std_logic;

    -- System Interface

            USER_CLK         : in std_logic

         );

end aurora_8b10b_v5_1_RX_LL;

architecture MAPPED of aurora_8b10b_v5_1_RX_LL is

-- External Register Declarations --

    signal RX_D_Buffer             : std_logic_vector(0 to 31);
    signal RX_REM_Buffer           : std_logic_vector(0 to 1);
    signal RX_SRC_RDY_N_Buffer     : std_logic;
    signal RX_SOF_N_Buffer         : std_logic;
    signal RX_EOF_N_Buffer         : std_logic;
    signal TX_WAIT_Buffer          : std_logic;
    signal FRAME_ERROR_Buffer      : std_logic;

-- Wire Declarations --

    signal start_rx_i          : std_logic;

-- Component Declarations --

    component aurora_8b10b_v5_1_RX_LL_NFC

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

    end component;


    component aurora_8b10b_v5_1_RX_LL_PDU_DATAPATH

        port (

        -- Traffic Separator Interface

                PDU_DATA     : in std_logic_vector(0 to 31);
                PDU_DATA_V   : in std_logic_vector(0 to 1);
                PDU_PAD      : in std_logic_vector(0 to 1);
                PDU_SCP      : in std_logic_vector(0 to 1);
                PDU_ECP      : in std_logic_vector(0 to 1);

        -- LocalLink PDU Interface

                RX_D         : out std_logic_vector(0 to 31);
                RX_REM       : out std_logic_vector(0 to 1);
                RX_SRC_RDY_N : out std_logic;
                RX_SOF_N     : out std_logic;
                RX_EOF_N     : out std_logic;

        -- Error Interface

                FRAME_ERROR  : out std_logic;

        -- System Interface

                USER_CLK     : in std_logic;
                RESET        : in std_logic

             );

    end component;


begin

    RX_D             <= RX_D_Buffer;
    RX_REM           <= RX_REM_Buffer;
    RX_SRC_RDY_N     <= RX_SRC_RDY_N_Buffer;
    RX_SOF_N         <= RX_SOF_N_Buffer;
    RX_EOF_N         <= RX_EOF_N_Buffer;
    TX_WAIT          <= TX_WAIT_Buffer;
    FRAME_ERROR      <= FRAME_ERROR_Buffer;

    start_rx_i       <= not START_RX;

-- Main Body of Code --

    -- NFC processing --

    nfc_module_i : aurora_8b10b_v5_1_RX_LL_NFC

        port map (

        -- Aurora Lane Interface

                    RX_SNF        => RX_SNF,
                    RX_FC_NB      => RX_FC_NB,

        -- TX_LL Interface

                    DECREMENT_NFC => DECREMENT_NFC,
                    TX_WAIT       => TX_WAIT_Buffer,

        -- Global Logic Interface

                    CHANNEL_UP    => START_RX,

        -- USER Interface

                    USER_CLK      => USER_CLK

                 );


    -- Datapath for user PDUs --

    rx_ll_pdu_datapath_i : aurora_8b10b_v5_1_RX_LL_PDU_DATAPATH

        port map (

        -- Traffic Separator Interface

                    PDU_DATA     => RX_PE_DATA,
                    PDU_DATA_V   => RX_PE_DATA_V,
                    PDU_PAD      => RX_PAD,
                    PDU_SCP      => RX_SCP,
                    PDU_ECP      => RX_ECP,

        -- LocalLink PDU Interface

                    RX_D         => RX_D_Buffer,
                    RX_REM       => RX_REM_Buffer,
                    RX_SRC_RDY_N => RX_SRC_RDY_N_Buffer,
                    RX_SOF_N     => RX_SOF_N_Buffer,
                    RX_EOF_N     => RX_EOF_N_Buffer,

        -- Error Interface

                    FRAME_ERROR  => FRAME_ERROR_Buffer,

        -- System Interface

                    USER_CLK     => USER_CLK,
                    RESET        => start_rx_i

                 );


end MAPPED;
