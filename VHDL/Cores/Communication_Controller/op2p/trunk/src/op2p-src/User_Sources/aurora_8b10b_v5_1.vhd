-----------------------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------------------
--  aurora_8b10b_v5_1
--
--
--  Description: This is the top level module for a 2 2-byte lane Aurora
--               reference design module. This module supports the following features:
--
--               * Completion Mode Native Flow Control
--               * Supports GTP
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_MISC.all;

-- synthesis translate_off

library UNISIM;
use UNISIM.all;

-- synthesis translate_on

entity aurora_8b10b_v5_1 is
   generic(
           SIM_GTPRESET_SPEEDUP   :integer :=   0      --Set to 1 to speed up sim reset
         );
    port (

    -- LocalLink TX Interface

            TX_D             : in std_logic_vector(0 to 31);
            TX_REM           : in std_logic_vector(0 to 1);
            TX_SRC_RDY_N     : in std_logic;
            TX_SOF_N         : in std_logic;
            TX_EOF_N         : in std_logic;
            TX_DST_RDY_N     : out std_logic;

    -- LocalLink RX Interface

            RX_D             : out std_logic_vector(0 to 31);
            RX_REM           : out std_logic_vector(0 to 1);
            RX_SRC_RDY_N     : out std_logic;
            RX_SOF_N         : out std_logic;
            RX_EOF_N         : out std_logic;

    -- Native Flow Control TX Interface

            NFC_REQ_N        : in std_logic;
            NFC_NB           : in std_logic_vector(0 to 3);
            NFC_ACK_N        : out std_logic;

    -- Native Flow Control RX Interface

            RX_SNF           : out std_logic;
            RX_FC_NB         : out std_logic_vector(0 to 3);
    -- GTP Serial I/O

            RXP              : in std_logic_vector(0 to 1);
            RXN              : in std_logic_vector(0 to 1);
            TXP              : out std_logic_vector(0 to 1);
            TXN              : out std_logic_vector(0 to 1);

    --GTP Reference Clock Interface

            GTPD1    : in  std_logic;

    -- Error Detection Interface

            HARD_ERROR       : out std_logic;
            SOFT_ERROR       : out std_logic;
            FRAME_ERROR      : out std_logic;

    -- Status

            CHANNEL_UP       : out std_logic;
            LANE_UP          : out std_logic_vector(0 to 1);

    -- Clock Compensation Control Interface

            WARN_CC          : in std_logic;
            DO_CC            : in std_logic;

    -- System Interface

            USER_CLK         : in  std_logic;
            SYNC_CLK         : in  std_logic;
            RESET            : in  std_logic;
            POWER_DOWN       : in  std_logic;
            LOOPBACK         : in  std_logic_vector(2 downto 0);
            GT_RESET         : in  std_logic;
            GTPCLKOUT        : out std_logic;
            TX_LOCK          : out std_logic

         );

end aurora_8b10b_v5_1;


architecture MAPPED of aurora_8b10b_v5_1 is
  attribute core_generation_info           : string;
  attribute core_generation_info of MAPPED : architecture is "aurora_8b10b_v5_1,aurora_8b10b_v5_1,{backchannel_mode=Sidebands, c_aurora_lanes=2, c_column_used=None, c_gt_clock_1=GTPD1, c_gt_clock_2=None, c_gt_loc_1=X, c_gt_loc_10=X, c_gt_loc_11=X, c_gt_loc_12=X, c_gt_loc_13=X, c_gt_loc_14=X, c_gt_loc_15=X, c_gt_loc_16=X, c_gt_loc_17=X, c_gt_loc_18=X, c_gt_loc_19=X, c_gt_loc_2=X, c_gt_loc_20=X, c_gt_loc_21=X, c_gt_loc_22=X, c_gt_loc_23=X, c_gt_loc_24=X, c_gt_loc_25=X, c_gt_loc_26=X, c_gt_loc_27=X, c_gt_loc_28=X, c_gt_loc_29=X, c_gt_loc_3=1, c_gt_loc_30=X, c_gt_loc_31=X, c_gt_loc_32=X, c_gt_loc_33=X, c_gt_loc_34=X, c_gt_loc_35=X, c_gt_loc_36=X, c_gt_loc_37=X, c_gt_loc_38=X, c_gt_loc_39=X, c_gt_loc_4=2, c_gt_loc_40=X, c_gt_loc_41=X, c_gt_loc_42=X, c_gt_loc_43=X, c_gt_loc_44=X, c_gt_loc_45=X, c_gt_loc_46=X, c_gt_loc_47=X, c_gt_loc_48=X, c_gt_loc_5=X, c_gt_loc_6=X, c_gt_loc_7=X, c_gt_loc_8=X, c_gt_loc_9=X, c_lane_width=2, c_line_rate=1.5, c_nfc=true, c_nfc_mode=COMP, c_refclk_frequency=75.0, c_simplex=false, c_simplex_mode=TX, c_stream=false, c_ufc=false, flow_mode=Completion_NFC, interface_mode=Framing, dataflow_config=Duplex,}";
-- Component Declarations --

    component FD

-- synthesis translate_off

        generic (

                    INIT : bit := '0'

                );

-- synthesis translate_on

        port (

                Q : out std_ulogic;
                C : in  std_ulogic;
                D : in  std_ulogic
             );

    end component;


    component aurora_8b10b_v5_1_AURORA_LANE

        port (
        -- GTP Interface

                RX_DATA           : in std_logic_vector(15 downto 0);  -- 2-byte data bus from the GTP.
                RX_NOT_IN_TABLE   : in std_logic_vector(1 downto 0);   -- Invalid 10-bit code was recieved.
                RX_DISP_ERR       : in std_logic_vector(1 downto 0);   -- Disparity error detected on RX interface.
                RX_CHAR_IS_K      : in std_logic_vector(1 downto 0);   -- Indicates which bytes of RX_DATA are control.
                RX_CHAR_IS_COMMA  : in std_logic_vector(1 downto 0);   -- Comma received on given byte.
                RX_STATUS         : in std_logic_vector(5 downto 0);   -- Part of GTP status and error bus.
                RX_BUF_ERR        : in std_logic;                      -- Overflow/Underflow of RX buffer detected.
                TX_BUF_ERR        : in std_logic;                      -- Overflow/Underflow of TX buffer detected.
                RX_REALIGN        : in std_logic;                      -- SERDES was realigned because of a new comma.
                RX_POLARITY       : out std_logic;                     -- Controls interpreted polarity of serial data inputs.
                RX_RESET          : out std_logic;                     -- Reset RX side of GTP logic.
                TX_CHAR_IS_K      : out std_logic_vector(1 downto 0);  -- TX_DATA byte is a control character.
                TX_DATA           : out std_logic_vector(15 downto 0); -- 2-byte data bus to the GTP.
                TX_RESET          : out std_logic;                     -- Reset TX side of GTP logic.

        -- Comma Detect Phase Align Interface

                ENA_COMMA_ALIGN   : out std_logic;                     -- Request comma alignment.

        -- TX_LL Interface

                GEN_SCP           : in std_logic;                      -- SCP generation request from TX_LL.
                GEN_ECP           : in std_logic;                      -- ECP generation request from TX_LL.
                GEN_SNF           : in std_logic;                      -- SNF generation request from TX_LL.
                GEN_PAD           : in std_logic;                      -- PAD generation request from TX_LL.
                FC_NB             : in std_logic_vector(0 to 3);       -- Size code for SUF and SNF messages.
                TX_PE_DATA        : in std_logic_vector(0 to 15);      -- Data from TX_LL to send over lane.
                TX_PE_DATA_V      : in std_logic;                      -- Indicates TX_PE_DATA is Valid.
                GEN_CC            : in std_logic;                      -- CC generation request from TX_LL.

        -- RX_LL Interface

                RX_PAD            : out std_logic;                     -- Indicates lane received PAD.
                RX_PE_DATA        : out std_logic_vector(0 to 15);     -- RX data from lane to RX_LL.
                RX_PE_DATA_V      : out std_logic;                     -- RX_PE_DATA is data, not control symbol.
                RX_SCP            : out std_logic;                     -- Indicates lane received SCP.
                RX_ECP            : out std_logic;                     -- Indicates lane received ECP.
                RX_SNF            : out std_logic;                     -- Indicates lane received SNF.
                RX_FC_NB          : out std_logic_vector(0 to 3);      -- Size code for SNF or SUF.

        -- Global Logic Interface

                GEN_A             : in std_logic;                      -- 'A character' generation request from Global Logic.
                GEN_K             : in std_logic_vector(0 to 1);       -- 'K character' generation request from Global Logic.
                GEN_R             : in std_logic_vector(0 to 1);       -- 'R character' generation request from Global Logic.
                GEN_V             : in std_logic_vector(0 to 1);       -- Verification data generation request.
                LANE_UP           : out std_logic;                     -- Lane is ready for bonding and verification.
                SOFT_ERROR        : out std_logic;                     -- Soft error detected.
                HARD_ERROR        : out std_logic;                     -- Hard error detected.
                CHANNEL_BOND_LOAD : out std_logic;                     -- Channel Bonding done code received.
                GOT_A             : out std_logic_vector(0 to 1);      -- Indicates lane recieved 'A character' bytes.
                GOT_V             : out std_logic;                     -- Verification symbols received.

        -- System Interface

                USER_CLK          : in std_logic;                      -- System clock for all non-GTP Aurora Logic.
                RESET             : in std_logic                       -- Reset the lane.

             );

    end component;



    component aurora_8b10b_v5_1_GTP_WRAPPER
       generic(
                SIM_GTPRESET_SPEEDUP   :integer :=   0      --Set to 1 to speed up sim reset
              );
        port  (

                ENCHANSYNC_IN           : in    std_logic;
                ENCHANSYNC_IN_LANE1           : in    std_logic;
                ENMCOMMAALIGN_IN        : in    std_logic;
                ENMCOMMAALIGN_IN_LANE1        : in    std_logic;
                ENPCOMMAALIGN_IN        : in    std_logic;
                ENPCOMMAALIGN_IN_LANE1        : in    std_logic;
                REFCLK                                         : in    std_logic;

                LOOPBACK_IN             : in    std_logic_vector (2 downto 0);
                RXPOLARITY_IN           : in    std_logic;
                RXPOLARITY_IN_LANE1           : in    std_logic;
                RXRESET_IN              : in    std_logic;
                RXRESET_IN_LANE1              : in    std_logic;
                RXUSRCLK_IN             : in    std_logic;
                RXUSRCLK2_IN            : in    std_logic;
                RX1N_IN                 : in    std_logic;
                RX1N_IN_LANE1                 : in    std_logic;
                RX1P_IN                 : in    std_logic;
                RX1P_IN_LANE1                 : in    std_logic;
                TXCHARISK_IN            : in    std_logic_vector (1 downto 0);
                TXCHARISK_IN_LANE1            : in    std_logic_vector (1 downto 0);
                TXDATA_IN               : in    std_logic_vector (15 downto 0);
                TXDATA_IN_LANE1               : in    std_logic_vector (15 downto 0);
                GTPRESET_IN                                     : in    std_logic;
                TXRESET_IN              : in    std_logic;
                TXRESET_IN_LANE1              : in    std_logic;
                TXUSRCLK_IN             : in    std_logic;
                TXUSRCLK2_IN            : in    std_logic;
                RXBUFERR_OUT            : out   std_logic;
                RXBUFERR_OUT_LANE1            : out   std_logic;
                RXCHARISCOMMA_OUT       : out   std_logic_vector (1 downto 0);
                RXCHARISCOMMA_OUT_LANE1       : out   std_logic_vector (1 downto 0);
                RXCHARISK_OUT           : out   std_logic_vector (1 downto 0);
                RXCHARISK_OUT_LANE1           : out   std_logic_vector (1 downto 0);
                RXDATA_OUT              : out   std_logic_vector (15 downto 0);
                RXDATA_OUT_LANE1              : out   std_logic_vector (15 downto 0);
                RXDISPERR_OUT           : out   std_logic_vector (1 downto 0);
                RXDISPERR_OUT_LANE1           : out   std_logic_vector (1 downto 0);
                RXNOTINTABLE_OUT        : out   std_logic_vector (1 downto 0);
                RXNOTINTABLE_OUT_LANE1        : out   std_logic_vector (1 downto 0);
                RXREALIGN_OUT           : out   std_logic;
                RXREALIGN_OUT_LANE1           : out   std_logic;
                RXRECCLK1_OUT           : out   std_logic;
                RXRECCLK1_OUT_LANE1           : out   std_logic;
                RXRECCLK2_OUT           : out   std_logic;
                RXRECCLK2_OUT_LANE1           : out   std_logic;
                CHBONDDONE_OUT          : out   std_logic;
                CHBONDDONE_OUT_LANE1          : out   std_logic;
                TXBUFERR_OUT            : out   std_logic;
                TXBUFERR_OUT_LANE1            : out   std_logic;
                PLLLKDET_OUT            : out   std_logic;
                PLLLKDET_OUT_LANE1            : out   std_logic;
                GTPCLKOUT_OUT                 : out    std_logic_vector (1 downto 0);
                GTPCLKOUT_LANE1_OUT                 : out    std_logic_vector (1 downto 0);
                TX1N_OUT                : out   std_logic;
                TX1N_OUT_LANE1                : out   std_logic;
                TX1P_OUT                : out   std_logic;
                TX1P_OUT_LANE1                : out   std_logic;






POWERDOWN_IN            : in    std_logic

             );

    end component;


    component BUFG

        port (

                O : out STD_ULOGIC;
                I : in STD_ULOGIC

             );

    end component;


    component aurora_8b10b_v5_1_GLOBAL_LOGIC

        port (

        -- GTP Interface

                CH_BOND_DONE       : in std_logic_vector(0 to 1);
                EN_CHAN_SYNC       : out std_logic;

        -- Aurora Lane Interface

                LANE_UP            : in std_logic_vector(0 to 1);
                SOFT_ERROR         : in std_logic_vector(0 to 1);
                HARD_ERROR         : in std_logic_vector(0 to 1);
                CHANNEL_BOND_LOAD  : in std_logic_vector(0 to 1);
                GOT_A              : in std_logic_vector(0 to 3);
                GOT_V              : in std_logic_vector(0 to 1);
                GEN_A              : out std_logic_vector(0 to 1);
                GEN_K              : out std_logic_vector(0 to 3);
                GEN_R              : out std_logic_vector(0 to 3);
                GEN_V              : out std_logic_vector(0 to 3);
                RESET_LANES        : out std_logic_vector(0 to 1);

        -- System Interface

                USER_CLK           : in std_logic;
                RESET              : in std_logic;
                POWER_DOWN         : in std_logic;
                CHANNEL_UP         : out std_logic;
                START_RX           : out std_logic;
                CHANNEL_SOFT_ERROR : out std_logic;
                CHANNEL_HARD_ERROR : out std_logic

             );

    end component;


    component aurora_8b10b_v5_1_TX_LL

        port (

        -- LocalLink PDU Interface

                TX_D           : in std_logic_vector(0 to 31);
                TX_REM         : in std_logic_vector(0 to 1);
                TX_SRC_RDY_N   : in std_logic;
                TX_SOF_N       : in std_logic;
                TX_EOF_N       : in std_logic;
                TX_DST_RDY_N   : out std_logic;

        -- NFC Interface

                NFC_REQ_N      : in std_logic;
                NFC_NB         : in std_logic_vector(0 to 3);
                NFC_ACK_N      : out std_logic;

        -- Clock Compensation Interface

                WARN_CC        : in std_logic;
                DO_CC          : in std_logic;

        -- Global Logic Interface

                CHANNEL_UP     : in std_logic;

        -- Aurora Lane Interface

                GEN_SCP        : out std_logic;
                GEN_ECP        : out std_logic;
                GEN_SNF        : out std_logic;
                FC_NB          : out std_logic_vector(0 to 3);
                TX_PE_DATA_V   : out std_logic_vector(0 to 1);
                GEN_PAD        : out std_logic_vector(0 to 1);
                TX_PE_DATA     : out std_logic_vector(0 to 31);
                GEN_CC         : out std_logic_vector(0 to 1);

        -- RX_LL Interface

                TX_WAIT        : in std_logic;
                DECREMENT_NFC  : out std_logic;

        -- System Interface

                USER_CLK       : in std_logic

             );

    end component;


    component aurora_8b10b_v5_1_RX_LL

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

    end component;

-- Signal Declarations --

    signal TX1N_OUT_unused                 : std_logic_vector(0 to 1);
    signal TX1P_OUT_unused                 : std_logic_vector(0 to 1);
    signal RX1N_IN_unused                  : std_logic_vector(0 to 1);
    signal RX1P_IN_unused                  : std_logic_vector(0 to 1);
    signal rx_char_is_comma_i_unused        : std_logic_vector(3 downto 0);    
    signal rx_char_is_k_i_unused            : std_logic_vector(3 downto 0);    
    signal rx_data_i_unused                : std_logic_vector(31 downto 0);    
    signal rx_disp_err_i_unused            : std_logic_vector(3 downto 0);    
    signal rx_not_in_table_i_unused        : std_logic_vector(3 downto 0);    
    signal rx_realign_i_unused             : std_logic_vector(1 downto 0);    
    signal ch_bond_done_i_unused           : std_logic_vector(1 downto 0);






    signal ch_bond_done_i           : std_logic_vector(1 downto 0);
    signal ch_bond_load_not_used_i  : std_logic_vector(0 to 1);
    signal channel_bond_load_i      : std_logic_vector(0 to 1);
    signal channel_up_i             : std_logic;
    signal chbondi_not_used_i       : std_logic_vector(4 downto 0);
    signal chbondo_not_used_i       : std_logic_vector(9 downto 0);
    signal decrement_nfc_i          : std_logic;
    signal en_chan_sync_i           : std_logic;
    signal ena_comma_align_i        : std_logic_vector(1 downto 0);
    signal fc_nb_i                  : std_logic_vector(0 to 3);
    signal gen_a_i                  : std_logic_vector(0 to 1);
    signal gen_cc_i                 : std_logic_vector(0 to 1);
    signal gen_ecp_i                : std_logic;
    signal gen_k_i                  : std_logic_vector(0 to 3);
    signal gen_pad_i                : std_logic_vector(0 to 1);
    signal gen_r_i                  : std_logic_vector(0 to 3);
    signal gen_scp_i                : std_logic;
    signal gen_snf_i                : std_logic;
    signal gen_v_i                  : std_logic_vector(0 to 3);
    signal got_a_i                  : std_logic_vector(0 to 3);
    signal got_v_i                  : std_logic_vector(0 to 1);
    signal hard_error_i             : std_logic_vector(0 to 1);
    signal lane_up_i                : std_logic_vector(0 to 1);
    signal  master_chbondo_i        :std_logic_vector(4 downto 0);
    signal open_rx_char_is_comma_i  : std_logic_vector(11 downto 0);
    signal open_rx_char_is_k_i      : std_logic_vector(11 downto 0);
    signal open_rx_comma_det_i      : std_logic_vector(1 downto 0);
    signal open_rx_data_i           : std_logic_vector(95 downto 0);
    signal open_rx_disp_err_i       : std_logic_vector(11 downto 0);
    signal open_rx_loss_of_sync_i   : std_logic_vector(3 downto 0);
    signal open_rx_not_in_table_i   : std_logic_vector(11 downto 0);
    signal open_rx_rec1_clk_i       : std_logic_vector(1 downto 0);
    signal open_rx_rec2_clk_i       : std_logic_vector(1 downto 0);
    signal open_rx_run_disp_i       : std_logic_vector(15 downto 0);
    signal open_tx_k_err_i          : std_logic_vector(15 downto 0);
    signal open_tx_run_disp_i       : std_logic_vector(15 downto 0);
    signal raw_gtpclkout_i             :   std_logic_vector(1 downto 0);
    signal raw_gtpclkout_lane1_i             :   std_logic_vector(1 downto 0);
    signal reset_lanes_i            : std_logic_vector(0 to 1);
    signal rx_buf_err_i             : std_logic_vector(1 downto 0);
    signal rx_char_is_comma_i       : std_logic_vector(3 downto 0);
    signal rx_char_is_comma_gtp_i   : std_logic_vector(15 downto 0);
    signal rx_char_is_k_i           : std_logic_vector(3 downto 0);
    signal rx_char_is_k_gtp_i       : std_logic_vector(15 downto 0);
    signal rx_clk_cor_cnt_i         : std_logic_vector(5 downto 0);
    signal rx_data_0_vec    : std_logic_vector(63 downto 0);
    signal rx_data_1_vec    : std_logic_vector(63 downto 0);
    signal rx_data_i                : std_logic_vector(31 downto 0);
    signal rx_data_gtp_i            : std_logic_vector(127 downto 0);
    signal rx_data_width_i          : std_logic_vector(1 downto 0);
    signal rx_disp_err_i            : std_logic_vector(3 downto 0);
    signal rx_disp_err_gtp_i        : std_logic_vector(15 downto 0);
    signal rx_ecp_i                 : std_logic_vector(0 to 1);
    signal rx_fc_nb_i               : std_logic_vector(0 to 7);
    signal rx_int_data_width_i      : std_logic_vector(1 downto 0);
    signal rx_not_in_table_i        : std_logic_vector(3 downto 0);
    signal rx_not_in_table_gtp_i    : std_logic_vector(15 downto 0);
    signal rx_pad_i                 : std_logic_vector(0 to 1);
    signal rx_pe_data_i             : std_logic_vector(0 to 31);
    signal rx_pe_data_v_i           : std_logic_vector(0 to 1);
    signal rx_polarity_i            : std_logic_vector(1 downto 0);
    signal rx_realign_i             : std_logic_vector(1 downto 0);
    signal rx_reset_i               : std_logic_vector(1 downto 0);
    signal rx_scp_i                 : std_logic_vector(0 to 1);
    signal rx_snf_i                 : std_logic_vector(0 to 1);
    signal rxchariscomma_0_vec      : std_logic_vector(7 downto 0);
    signal rxcharisk_0_vec          : std_logic_vector(7 downto 0);
    signal rxdisperr_0_vec          : std_logic_vector(7 downto 0);
    signal rxchariscomma_1_vec      : std_logic_vector(7 downto 0);
    signal rxcharisk_1_vec          : std_logic_vector(7 downto 0);
    signal rxdisperr_1_vec          : std_logic_vector(7 downto 0);
    signal rxmclk_out_not_used_i    : std_logic_vector(0 to 1);
    signal rxnotintable_0_vec       : std_logic_vector(7 downto 0);
    signal rxnotintable_1_vec       : std_logic_vector(7 downto 0);
    signal rxpcshclkout_not_used_i  : std_logic_vector(0 to 1);
    signal soft_error_i             : std_logic_vector(0 to 1);
    signal start_rx_i               : std_logic;
    signal tied_to_ground_i         : std_logic;
    signal tied_to_ground_vec_i     : std_logic_vector(47 downto 0);
    signal tied_to_vcc_i            : std_logic;
    signal tx_buf_err_i             : std_logic_vector(1 downto 0);
    signal tx_char_is_k_i           : std_logic_vector(3 downto 0);
    signal tx_char_is_k_gtp_i       : std_logic_vector(15 downto 0);
    signal tx_data_i                : std_logic_vector(31 downto 0);
    signal tx_data_gtp_i            : std_logic_vector(127 downto 0);
    signal tx_data_width_i          : std_logic_vector(1 downto 0);
    signal tx_int_data_width_i      : std_logic_vector(1 downto 0);
    signal tx_lock_i                : std_logic_vector(0 to 1);
    signal tx_pe_data_i             : std_logic_vector(0 to 31);
    signal tx_pe_data_v_i           : std_logic_vector(0 to 1);
    signal tx_reset_i               : std_logic_vector(1 downto 0);
    signal tx_wait_i                : std_logic;
    signal txcharisk_lane_0_i       : std_logic_vector(7 downto 0);
    signal txdata_lane_0_i          : std_logic_vector(63 downto 0);
    signal txcharisk_lane_1_i       : std_logic_vector(7 downto 0);
    signal txdata_lane_1_i          : std_logic_vector(63 downto 0);
    signal txoutclk2_out_not_used_i : std_logic_vector(0 to 1);
    signal txpcshclkout_not_used_i  : std_logic_vector(0 to 1);
    signal ch_bond_load_pulse_i     : std_logic_vector(0 to 1);
    signal ch_bond_done_dly_i       : std_logic_vector(0 to 1);

begin

-- Main Body of Code --

    -- Tie off top level constants

    tied_to_ground_vec_i <= (others => '0');
    tied_to_ground_i     <= '0';
    tied_to_vcc_i        <= '1';
    chbondi_not_used_i   <= (others => '0');

    -- Connect top level logic

    CHANNEL_UP           <=  channel_up_i;

    -- Set the data widths for all lanes

    rx_data_width_i      <= "01";
    rx_int_data_width_i  <= "01";
    tx_data_width_i      <= "01";
    tx_int_data_width_i  <= "01";

    GTPCLKOUT   <=   raw_gtpclkout_i(0);
    
    -- Connect TX_LOCK to tx_lock_i from lane 0
    TX_LOCK    <=   AND_REDUCE(tx_lock_i);
    -- NFC RX Interface
    RX_SNF   <= rx_snf_i(0);
    RX_FC_NB <= rx_fc_nb_i(0 to 3);    

    -- Instantiate Lane 0 --

    LANE_UP(0) <=   lane_up_i(0);

    aurora_lane_0_i : aurora_8b10b_v5_1_AURORA_LANE

        port map (

        -- GTP Interface

                    RX_DATA             => rx_data_i(15 downto 0),
                    RX_NOT_IN_TABLE     => rx_not_in_table_i(1 downto 0),
                    RX_DISP_ERR         => rx_disp_err_i(1 downto 0),
                    RX_CHAR_IS_K        => rx_char_is_k_i(1 downto 0),
                    RX_CHAR_IS_COMMA    => rx_char_is_comma_i(1 downto 0),
                    RX_STATUS           => tied_to_ground_vec_i(5 downto 0),
                    TX_BUF_ERR          => tx_buf_err_i(0),
                    RX_BUF_ERR          => rx_buf_err_i(0),
                    RX_REALIGN          => rx_realign_i(0),
                    RX_POLARITY         => rx_polarity_i(0),
                    RX_RESET            => rx_reset_i(0),
                    TX_CHAR_IS_K        => tx_char_is_k_i(1 downto 0),
                    TX_DATA             => tx_data_i(15 downto 0),
                    TX_RESET            => tx_reset_i(0),

        -- Comma Detect Phase Align Interface

                    ENA_COMMA_ALIGN     => ena_comma_align_i(0),

        -- TX_LL Interface
                    GEN_SCP             => gen_scp_i,
                    GEN_SNF             => gen_snf_i,
                    FC_NB               => fc_nb_i,
                    GEN_ECP             => tied_to_ground_i,
                    GEN_PAD             => gen_pad_i(0),
                    TX_PE_DATA          => tx_pe_data_i(0 to 15),
                    TX_PE_DATA_V        => tx_pe_data_v_i(0),
                    GEN_CC              => gen_cc_i(0),

        -- RX_LL Interface

                    RX_PAD              => rx_pad_i(0),
                    RX_PE_DATA          => rx_pe_data_i(0 to 15),
                    RX_PE_DATA_V        => rx_pe_data_v_i(0),
                    RX_SCP              => rx_scp_i(0),
                    RX_ECP              => rx_ecp_i(0),
                    RX_SNF              => rx_snf_i(0),
                    RX_FC_NB            => rx_fc_nb_i(0 to 3),

        -- Global Logic Interface

                    GEN_A               => gen_a_i(0),
                    GEN_K               => gen_k_i(0 to 1),
                    GEN_R               => gen_r_i(0 to 1),
                    GEN_V               => gen_v_i(0 to 1),
                    LANE_UP             => lane_up_i(0),
                    SOFT_ERROR          => soft_error_i(0),
                    HARD_ERROR          => hard_error_i(0),
                    CHANNEL_BOND_LOAD   => ch_bond_load_not_used_i(0),
                    GOT_A               => got_a_i(0 to 1),
                    GOT_V               => got_v_i(0),

        -- System Interface

                    USER_CLK            => USER_CLK,
                    RESET               => reset_lanes_i(0)

                 );


    -- Instantiate Lane 1 --

    LANE_UP(1) <=   lane_up_i(1);

    aurora_lane_1_i : aurora_8b10b_v5_1_AURORA_LANE

        port map (

        -- GTP Interface

                    RX_DATA             => rx_data_i(31 downto 16),
                    RX_NOT_IN_TABLE     => rx_not_in_table_i(3 downto 2),
                    RX_DISP_ERR         => rx_disp_err_i(3 downto 2),
                    RX_CHAR_IS_K        => rx_char_is_k_i(3 downto 2),
                    RX_CHAR_IS_COMMA    => rx_char_is_comma_i(3 downto 2),
                    RX_STATUS           => tied_to_ground_vec_i(5 downto 0),
                    TX_BUF_ERR          => tx_buf_err_i(1),
                    RX_BUF_ERR          => rx_buf_err_i(1),
                    RX_REALIGN          => rx_realign_i(1),
                    RX_POLARITY         => rx_polarity_i(1),
                    RX_RESET            => rx_reset_i(1),
                    TX_CHAR_IS_K        => tx_char_is_k_i(3 downto 2),
                    TX_DATA             => tx_data_i(31 downto 16),
                    TX_RESET            => tx_reset_i(1),

        -- Comma Detect Phase Align Interface

                    ENA_COMMA_ALIGN     => ena_comma_align_i(1),

        -- TX_LL Interface
                    GEN_SCP             => tied_to_ground_i,
                    GEN_SNF             => tied_to_ground_i,
                    FC_NB               => tied_to_ground_vec_i(3 downto 0),
                    GEN_ECP             => gen_ecp_i,
                    GEN_PAD             => gen_pad_i(1),
                    TX_PE_DATA          => tx_pe_data_i(16 to 31),
                    TX_PE_DATA_V        => tx_pe_data_v_i(1),
                    GEN_CC              => gen_cc_i(1),

        -- RX_LL Interface

                    RX_PAD              => rx_pad_i(1),
                    RX_PE_DATA          => rx_pe_data_i(16 to 31),
                    RX_PE_DATA_V        => rx_pe_data_v_i(1),
                    RX_SCP              => rx_scp_i(1),
                    RX_ECP              => rx_ecp_i(1),
                    RX_SNF              => rx_snf_i(1),
                    RX_FC_NB            => rx_fc_nb_i(4 to 7),

        -- Global Logic Interface

                    GEN_A               => gen_a_i(1),
                    GEN_K               => gen_k_i(2 to 3),
                    GEN_R               => gen_r_i(2 to 3),
                    GEN_V               => gen_v_i(2 to 3),
                    LANE_UP             => lane_up_i(1),
                    SOFT_ERROR          => soft_error_i(1),
                    HARD_ERROR          => hard_error_i(1),
                    CHANNEL_BOND_LOAD   => ch_bond_load_not_used_i(1),
                    GOT_A               => got_a_i(2 to 3),
                    GOT_V               => got_v_i(1),

        -- System Interface

                    USER_CLK            => USER_CLK,
                    RESET               => reset_lanes_i(1)

                 );


    -- Instantiate GTP Wrapper --

    gtp_wrapper_i : aurora_8b10b_v5_1_GTP_WRAPPER
        generic map(
                     SIM_GTPRESET_SPEEDUP  => SIM_GTPRESET_SPEEDUP
                   )
        port map   (

        -- Aurora Lane Interface

                    RXPOLARITY_IN           => rx_polarity_i(0),
                    RXPOLARITY_IN_LANE1           => rx_polarity_i(1),
                    RXRESET_IN              => rx_reset_i(0),
                    RXRESET_IN_LANE1              => rx_reset_i(1),
                    TXCHARISK_IN            => tx_char_is_k_i(1 downto 0),
                    TXCHARISK_IN_LANE1            => tx_char_is_k_i(3 downto 2),
                    TXDATA_IN               => tx_data_i(15 downto 0),
                    TXDATA_IN_LANE1               => tx_data_i(31 downto 16),
                    TXRESET_IN              => tx_reset_i(0),
                    TXRESET_IN_LANE1              => tx_reset_i(1),
                    RXDATA_OUT              => rx_data_i(15 downto 0),
                    RXDATA_OUT_LANE1              => rx_data_i(31 downto 16),
                    RXNOTINTABLE_OUT        => rx_not_in_table_i(1 downto 0),
                    RXNOTINTABLE_OUT_LANE1        => rx_not_in_table_i(3 downto 2),
                    RXDISPERR_OUT           => rx_disp_err_i(1 downto 0),
                    RXDISPERR_OUT_LANE1           => rx_disp_err_i(3 downto 2),
                    RXCHARISK_OUT           => rx_char_is_k_i(1 downto 0),
                    RXCHARISK_OUT_LANE1           => rx_char_is_k_i(3 downto 2),
                    RXCHARISCOMMA_OUT       => rx_char_is_comma_i(1 downto 0),
                    RXCHARISCOMMA_OUT_LANE1       => rx_char_is_comma_i(3 downto 2),
                    TXBUFERR_OUT            => tx_buf_err_i(0),
                    TXBUFERR_OUT_LANE1            => tx_buf_err_i(1),
                    RXBUFERR_OUT            => rx_buf_err_i(0),
                    RXBUFERR_OUT_LANE1            => rx_buf_err_i(1),
                    RXREALIGN_OUT           => rx_realign_i(0),
                    RXREALIGN_OUT_LANE1           => rx_realign_i(1),

        -- Phase Align Interface

                    ENMCOMMAALIGN_IN        => ena_comma_align_i(0),
                    ENMCOMMAALIGN_IN_LANE1        => ena_comma_align_i(1),
                    ENPCOMMAALIGN_IN        => ena_comma_align_i(0),
                    ENPCOMMAALIGN_IN_LANE1        => ena_comma_align_i(1),
                    RXRECCLK1_OUT           => open_rx_rec1_clk_i(0),                      RXRECCLK1_OUT_LANE1           => open_rx_rec1_clk_i(1),  
                    RXRECCLK2_OUT           => open_rx_rec2_clk_i(0),  
                    RXRECCLK2_OUT_LANE1           => open_rx_rec2_clk_i(1),  
        -- Global Logic Interface

                    ENCHANSYNC_IN           => en_chan_sync_i,
                    ENCHANSYNC_IN_LANE1           => tied_to_vcc_i,
                    CHBONDDONE_OUT          => ch_bond_done_i(0),
                    CHBONDDONE_OUT_LANE1          => ch_bond_done_i(1),

        -- Serial IO

                    RX1N_IN       => RXN(0),
                    RX1N_IN_LANE1       => RXN(1),
                    RX1P_IN       => RXP(0),
                    RX1P_IN_LANE1       => RXP(1),
                    TX1N_OUT      => TXN(0),
                    TX1N_OUT_LANE1      => TXN(1),
                    TX1P_OUT      => TXP(0),
                    TX1P_OUT_LANE1      => TXP(1),


        -- Reference Clocks and User Clock

                    RXUSRCLK_IN             => SYNC_CLK,
                    RXUSRCLK2_IN            => USER_CLK,
                    TXUSRCLK_IN             => SYNC_CLK,
                    TXUSRCLK2_IN            => USER_CLK,
                    REFCLK                  =>  GTPD1,

                    GTPCLKOUT_OUT => raw_gtpclkout_i,
                    GTPCLKOUT_LANE1_OUT => raw_gtpclkout_lane1_i,
                    PLLLKDET_OUT            => tx_lock_i(0),       
                    PLLLKDET_OUT_LANE1            => tx_lock_i(1),       
        -- System Interface

                    GTPRESET_IN                                => GT_RESET,                      LOOPBACK_IN                                    => LOOPBACK,





                    POWERDOWN_IN                                   => POWER_DOWN
                 );


       -- Instantiate Global Logic to combine Lanes into a Channel --
process(USER_CLK)
begin
     if(USER_CLK='1' and USER_CLK'event)then
        if(RESET='1')then
               ch_bond_done_dly_i  <=                                        "00";
                                                elsif(en_chan_sync_i='1')then
               ch_bond_done_dly_i  <=  ch_bond_done_i;
        else
               ch_bond_done_dly_i  <=                                        "00";
                                        
     end if;
   end if;
end process;

process(USER_CLK)
begin
     if(USER_CLK='1' and USER_CLK'event)then
       if(RESET='1')then
              ch_bond_load_pulse_i  <=                                        "00";
                                        
       elsif(en_chan_sync_i='1')then
              ch_bond_load_pulse_i  <= ch_bond_done_i and not ch_bond_done_dly_i;
       else
              ch_bond_load_pulse_i   <=                                        "00";
                                        
       end if;
    end if;
end process;

    global_logic_i : aurora_8b10b_v5_1_GLOBAL_LOGIC

        port map (

        -- GTP Interface

                    CH_BOND_DONE            => ch_bond_done_i,
                    EN_CHAN_SYNC            => en_chan_sync_i,

        -- Aurora Lane Interface

                    LANE_UP                 => lane_up_i,
                    SOFT_ERROR              => soft_error_i,
                    HARD_ERROR              => hard_error_i,
                    CHANNEL_BOND_LOAD       => ch_bond_load_pulse_i,
                    GOT_A                   => got_a_i,
                    GOT_V                   => got_v_i,
                    GEN_A                   => gen_a_i,
                    GEN_K                   => gen_k_i,
                    GEN_R                   => gen_r_i,
                    GEN_V                   => gen_v_i,
                    RESET_LANES             => reset_lanes_i,

        -- System Interface

                    USER_CLK                => USER_CLK,
                    RESET                   => RESET,
                    POWER_DOWN              => POWER_DOWN,
                    CHANNEL_UP              => channel_up_i,
                    START_RX                => start_rx_i,
                    CHANNEL_SOFT_ERROR      => SOFT_ERROR,
                    CHANNEL_HARD_ERROR      => HARD_ERROR

                 );


    -- Instantiate TX_LL --

    tx_ll_i : aurora_8b10b_v5_1_TX_LL

        port map (

        -- LocalLink PDU Interface

                    TX_D                    => TX_D,
                    TX_REM                  => TX_REM,
                    TX_SRC_RDY_N            => TX_SRC_RDY_N,
                    TX_SOF_N                => TX_SOF_N,
                    TX_EOF_N                => TX_EOF_N,
                    TX_DST_RDY_N            => TX_DST_RDY_N,

        -- NFC Interface

                    NFC_REQ_N               => NFC_REQ_N,
                    NFC_NB                  => NFC_NB,
                    NFC_ACK_N               => NFC_ACK_N,

        -- Clock Compenstaion Interface

                    WARN_CC                 => WARN_CC,
                    DO_CC                   => DO_CC,

        -- Global Logic Interface

                    CHANNEL_UP              => channel_up_i,

        -- Aurora Lane Interface

                    GEN_SCP                 => gen_scp_i,
                    GEN_ECP                 => gen_ecp_i,
                    GEN_SNF                 => gen_snf_i,
                    FC_NB                   => fc_nb_i,
                    TX_PE_DATA_V            => tx_pe_data_v_i,
                    GEN_PAD                 => gen_pad_i,
                    TX_PE_DATA              => tx_pe_data_i,
                    GEN_CC                  => gen_cc_i,

        -- RX_LL Interface

                    TX_WAIT                 => tx_wait_i,
                    DECREMENT_NFC           => decrement_nfc_i,


        -- System Interface

                    USER_CLK                => USER_CLK

                 );


    -- Instantiate RX_LL --

    rx_ll_i : aurora_8b10b_v5_1_RX_LL

        port map (

        -- LocalLink PDU Interface

                    RX_D             => RX_D,
                    RX_REM           => RX_REM,
                    RX_SRC_RDY_N     => RX_SRC_RDY_N,
                    RX_SOF_N         => RX_SOF_N,
                    RX_EOF_N         => RX_EOF_N,

        -- Global Logic Interface

                    START_RX         => start_rx_i,

        -- Aurora Lane Interface

                    RX_PAD           => rx_pad_i,
                    RX_PE_DATA       => rx_pe_data_i,
                    RX_PE_DATA_V     => rx_pe_data_v_i,
                    RX_SCP           => rx_scp_i,
                    RX_ECP           => rx_ecp_i,
                    RX_SNF           => rx_snf_i,
                    RX_FC_NB         => rx_fc_nb_i,

        -- TX_LL Interface

                    DECREMENT_NFC    => decrement_nfc_i,
                    TX_WAIT          => tx_wait_i,

        -- Error Interface

                    FRAME_ERROR      => FRAME_ERROR,

        -- System Interface

                    USER_CLK         => USER_CLK

                 );

end MAPPED;
