    -------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------
--
--  RX_LL_PDU_DATAPATH
--
--
--  Description: the RX_LL_PDU_DATAPATH module takes regular PDU data in Aurora format
--               and transforms it to LocalLink formatted data
--
--               This module supports 2 2-byte lane designs
--              
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use WORK.AURORA_PKG.all;

entity aurora_8b10b_v5_1_RX_LL_PDU_DATAPATH is

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

end aurora_8b10b_v5_1_RX_LL_PDU_DATAPATH;


architecture RTL of aurora_8b10b_v5_1_RX_LL_PDU_DATAPATH is

--****************************Parameter Declarations**************************

    constant DLY : time := 1 ns;

    
--****************************External Register Declarations**************************

    signal RX_D_Buffer                      : std_logic_vector(0 to 31);
    signal RX_REM_Buffer                    : std_logic_vector(0 to 1);
    signal RX_SRC_RDY_N_Buffer              : std_logic;
    signal RX_SOF_N_Buffer                  : std_logic;
    signal RX_EOF_N_Buffer                  : std_logic;
    signal FRAME_ERROR_Buffer               : std_logic;


--****************************Internal Register Declarations**************************
    --Stage 1
    signal stage_1_data_r                   : std_logic_vector(0 to 31); 
    signal stage_1_pad_r                    : std_logic;  
    signal stage_1_ecp_r                    : std_logic_vector(0 to 1);
    signal stage_1_scp_r                    : std_logic_vector(0 to 1);
    signal stage_1_start_detected_r         : std_logic;


    --Stage 2
    signal stage_2_data_r                   : std_logic_vector(0 to 31);
    signal stage_2_pad_r                    : std_logic;  
    signal stage_2_start_with_data_r        : std_logic; 
    signal stage_2_end_before_start_r       : std_logic;
    signal stage_2_end_after_start_r        : std_logic;    
    signal stage_2_start_detected_r         : std_logic; 
    signal stage_2_frame_error_r            : std_logic;
        

    




--*********************************Wire Declarations**********************************
    --Stage 1
    signal stage_1_data_v_r                 : std_logic_vector(0 to 1);
    signal stage_1_after_scp_r              : std_logic_vector(0 to 1);
    signal stage_1_in_frame_r               : std_logic_vector(0 to 1);
    
    --Stage 2
    signal stage_2_left_align_select_r      : std_logic_vector(0 to 5);
    signal stage_2_data_v_r                 : std_logic_vector(0 to 1);
    
    signal stage_2_data_v_count_r           : std_logic_vector(0 to 1);
    signal stage_2_frame_error_c            : std_logic;
             
 
    --Stage 3
    signal stage_3_data_r                   : std_logic_vector(0 to 31);
    
 
    
    signal stage_3_storage_count_r          : std_logic_vector(0 to 1);
    signal stage_3_storage_ce_r             : std_logic_vector(0 to 1);
    signal stage_3_end_storage_r            : std_logic;
    signal stage_3_storage_select_r         : std_logic_vector(0 to 9);
    signal stage_3_output_select_r          : std_logic_vector(0 to 9);
    signal stage_3_src_rdy_n_r              : std_logic;
    signal stage_3_sof_n_r                  : std_logic;
    signal stage_3_eof_n_r                  : std_logic;
    signal stage_3_rem_r                    : std_logic_vector(0 to 1);
    signal stage_3_frame_error_r            : std_logic;
    
  
  
    --Stage 4
    signal storage_data_r                   : std_logic_vector(0 to 31);
  
    

-- ********************************** Component Declarations ************************************--

    component aurora_8b10b_v5_1_RX_LL_DEFRAMER
    port (
        PDU_DATA_V      : in std_logic_vector(0 to 1);
        PDU_SCP         : in std_logic_vector(0 to 1);
        PDU_ECP         : in std_logic_vector(0 to 1);
        USER_CLK        : in std_logic;
        RESET           : in std_logic;
        
        DEFRAMED_DATA_V : out std_logic_vector(0 to 1);
        IN_FRAME        : out std_logic_vector(0 to 1);
        AFTER_SCP       : out std_logic_vector(0 to 1)
    );
    end component;


    component aurora_8b10b_v5_1_LEFT_ALIGN_CONTROL
    port (
        PREVIOUS_STAGE_VALID : in std_logic_vector(0 to 1);

        MUX_SELECT           : out std_logic_vector(0 to 5);
        VALID                : out std_logic_vector(0 to 1);

        USER_CLK             : in std_logic;
        RESET                : in std_logic

    );
    end component;


    component aurora_8b10b_v5_1_VALID_DATA_COUNTER
    port (
        PREVIOUS_STAGE_VALID : in std_logic_vector(0 to 1);
        
        USER_CLK             : in std_logic;
        RESET                : in std_logic;
        
        COUNT                : out std_logic_vector(0 to 1)
     );
     end component;


    component aurora_8b10b_v5_1_LEFT_ALIGN_MUX
    port (
        RAW_DATA   : in std_logic_vector(0 to 31);
        MUX_SELECT : in std_logic_vector(0 to 5);
        
        USER_CLK   : in std_logic;
        
        MUXED_DATA : out std_logic_vector(0 to 31)

     );
    end component;


    component aurora_8b10b_v5_1_STORAGE_COUNT_CONTROL
    port (

        LEFT_ALIGNED_COUNT : in std_logic_vector(0 to 1);
        END_STORAGE        : in std_logic;
        START_WITH_DATA    : in std_logic;
        FRAME_ERROR        : in std_logic;
        
        STORAGE_COUNT      : out std_logic_vector(0 to 1);
        
        USER_CLK           : in std_logic;
        RESET              : in std_logic
    );
    end component;


    component aurora_8b10b_v5_1_STORAGE_CE_CONTROL
    port (
        LEFT_ALIGNED_COUNT : in std_logic_vector(0 to 1);
        STORAGE_COUNT      : in std_logic_vector(0 to 1);
        END_STORAGE        : in std_logic;
        START_WITH_DATA    : in std_logic;
        
        STORAGE_CE         : out std_logic_vector(0 to 1);
        
        USER_CLK           : in std_logic;
        RESET              : in std_logic
    );
    end component;


    component aurora_8b10b_v5_1_STORAGE_SWITCH_CONTROL
    port (
        LEFT_ALIGNED_COUNT : in std_logic_vector(0 to 1);
        STORAGE_COUNT      : in std_logic_vector(0 to 1);
        END_STORAGE        : in std_logic;
        START_WITH_DATA    : in std_logic;
        
        STORAGE_SELECT     : out std_logic_vector(0 to 9);
        
        USER_CLK           : in std_logic
    );
    end component;


    component aurora_8b10b_v5_1_OUTPUT_SWITCH_CONTROL
    port (
        LEFT_ALIGNED_COUNT : in std_logic_vector(0 to 1);
        STORAGE_COUNT      : in std_logic_vector(0 to 1);
        END_STORAGE        : in std_logic;
        START_WITH_DATA    : in std_logic;
        
        OUTPUT_SELECT      : out std_logic_vector(0 to 9);
        
        USER_CLK           : in std_logic
    );
    end component;


    component aurora_8b10b_v5_1_SIDEBAND_OUTPUT
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
    end component;


    component aurora_8b10b_v5_1_STORAGE_MUX
    port (

        RAW_DATA     : in std_logic_vector(0 to 31);
        MUX_SELECT   : in std_logic_vector(0 to 9);
        STORAGE_CE   : in std_logic_vector(0 to 1);
        USER_CLK     : in std_logic;
        
        STORAGE_DATA : out std_logic_vector(0 to 31)
    );
    end component;


    component aurora_8b10b_v5_1_OUTPUT_MUX
    port (
        STORAGE_DATA      : in std_logic_vector(0 to 31);
        LEFT_ALIGNED_DATA : in std_logic_vector(0 to 31);
        MUX_SELECT        : in std_logic_vector(0 to 9);
        USER_CLK          : in std_logic;
        
        OUTPUT_DATA       : out std_logic_vector(0 to 31)
    );
    end component;


begin    
   
--*********************************Main Body of Code**********************************
    
    -- VHDL Helper Logic
    RX_D         <= RX_D_Buffer;
    RX_REM       <= RX_REM_Buffer;
    RX_SRC_RDY_N <= RX_SRC_RDY_N_Buffer;
    RX_SOF_N     <= RX_SOF_N_Buffer;
    RX_EOF_N     <= RX_EOF_N_Buffer;
    FRAME_ERROR  <= FRAME_ERROR_Buffer;
    
    


    --_____Stage 1: Decode Frame Encapsulation and remove unframed data ________
    
    
    stage_1_rx_ll_deframer_i : aurora_8b10b_v5_1_RX_LL_DEFRAMER 
    port map
    (        
        PDU_DATA_V          =>   PDU_DATA_V,
        PDU_SCP             =>   PDU_SCP,
        PDU_ECP             =>   PDU_ECP,
        USER_CLK            =>   USER_CLK,
        RESET               =>   RESET,

        DEFRAMED_DATA_V     =>   stage_1_data_v_r,
        IN_FRAME            =>   stage_1_in_frame_r,
        AFTER_SCP           =>   stage_1_after_scp_r
   
    );
    
   
    --Determine whether there were any SCPs detected, regardless of data
    process(USER_CLK)
    begin
        if(USER_CLK 'event and USER_CLK = '1') then
            if(RESET = '1') then
                stage_1_start_detected_r    <= '0' after DLY;  
            else         
                stage_1_start_detected_r    <=  std_bool(PDU_SCP /= "00") after DLY; 
            end if;
        end if;
    end process;    
   
   
    --Pipeline the data signal, and register a signal to indicate whether the data in
    -- the current cycle contained a Pad character.
    process(USER_CLK)
    begin
        if(USER_CLK 'event and USER_CLK = '1') then
            stage_1_data_r             <=  PDU_DATA after DLY;
            stage_1_pad_r              <=  std_bool(PDU_PAD /= "00") after DLY;
            stage_1_ecp_r              <=  PDU_ECP after DLY;
            stage_1_scp_r              <=  PDU_SCP after DLY;
        end if;    
    end process;    
    
    
    
    --_______________________Stage 2: First Control Stage ___________________________
    
    
    --We instantiate a LEFT_ALIGN_CONTROL module to drive the select signals for the
    --left align mux in the next stage, and to compute the next stage valid signals
    
    stage_2_left_align_control_i : aurora_8b10b_v5_1_LEFT_ALIGN_CONTROL 
    port map(
        PREVIOUS_STAGE_VALID    =>   stage_1_data_v_r,

        MUX_SELECT              =>   stage_2_left_align_select_r,
        VALID                   =>   stage_2_data_v_r,
        
        USER_CLK                =>   USER_CLK,
        RESET                   =>   RESET

    );
        

    
    --Count the number of valid data lanes: this count is used to select which data 
    -- is stored and which data is sent to output in later stages    
    stage_2_valid_data_counter_i : aurora_8b10b_v5_1_VALID_DATA_COUNTER 
    port map(
        PREVIOUS_STAGE_VALID    =>   stage_1_data_v_r,
        USER_CLK                =>   USER_CLK,
        RESET                   =>   RESET,
        
        COUNT                   =>   stage_2_data_v_count_r
    );
     
     
          
    --Pipeline the data and pad bits
    process(USER_CLK)
    begin
        if(USER_CLK 'event and USER_CLK = '1') then
            stage_2_data_r          <=  stage_1_data_r after DLY;        
            stage_2_pad_r           <=  stage_1_pad_r after DLY;
        end if;    
    end process;   
        
        
    
    
    --Determine whether there was any valid data after any SCP characters
    process(USER_CLK)
    begin
        if(USER_CLK 'event and USER_CLK = '1') then
            if(RESET = '1') then
                stage_2_start_with_data_r    <=  '0' after DLY;
            else
                stage_2_start_with_data_r    <=  std_bool((stage_1_data_v_r and stage_1_after_scp_r) /= "00") after DLY;
            end if;
        end if;
    end process;    
        
        
        
    --Determine whether there were any ECPs detected before any SPC characters
    -- arrived
    process(USER_CLK)
    begin
        if(USER_CLK 'event and USER_CLK = '1') then
            if(RESET = '1') then
                stage_2_end_before_start_r      <=  '0' after DLY;   
            else
                stage_2_end_before_start_r      <=  std_bool((stage_1_ecp_r and not stage_1_after_scp_r) /= "00") after DLY;
            end if;
        end if;
    end process;    
    
    
    --Determine whether there were any ECPs detected at all
    process(USER_CLK)
    begin
        if(USER_CLK 'event and USER_CLK = '1') then
            if(RESET = '1') then
                stage_2_end_after_start_r       <=  '0' after DLY;   
            else        
                stage_2_end_after_start_r       <=  std_bool((stage_1_ecp_r and stage_1_after_scp_r) /= "00") after DLY;
            end if;
        end if;
    end process;    
        
    
    --Pipeline the SCP detected signal
    process(USER_CLK)
    begin
        if(USER_CLK 'event and USER_CLK = '1') then
            if(RESET = '1') then
                stage_2_start_detected_r    <=  '0' after DLY;  
            else        
                stage_2_start_detected_r    <=   stage_1_start_detected_r after DLY;
            end if;
        end if;
    end process;    
        
    
    
    --Detect frame errors. Note that the frame error signal is held until the start of 
    -- a frame following the data beat that caused the frame error
    stage_2_frame_error_c   <=   std_bool( (stage_1_ecp_r and not stage_1_in_frame_r) /= "00" ) or
                                 std_bool( (stage_1_scp_r and stage_1_in_frame_r) /= "00" );
    
    
    process(USER_CLK)
    begin
        if(USER_CLK 'event and USER_CLK = '1') then
            if(RESET = '1') then
                stage_2_frame_error_r               <=  '0' after DLY;
            elsif(stage_2_frame_error_c = '1') then
                stage_2_frame_error_r               <=  '1' after DLY;
            elsif(stage_1_start_detected_r = '1') then   
                stage_2_frame_error_r               <=  '0' after DLY;
            end if;
        end if;
    end process;    
       
    
        
 



    --_______________________________ Stage 3 Left Alignment _________________________
    
    
    --We instantiate a left align mux to shift all lanes with valid data in the channel leftward
    --The data is seperated into groups of 8 lanes, and all valid data within each group is left
    --aligned.
    stage_3_left_align_datapath_mux_i : aurora_8b10b_v5_1_LEFT_ALIGN_MUX 
    port map(
        RAW_DATA    =>   stage_2_data_r,
        MUX_SELECT  =>   stage_2_left_align_select_r,
        USER_CLK    =>   USER_CLK,
 
        MUXED_DATA  =>   stage_3_data_r
    );
        






    --Determine the number of valid data lanes that will be in storage on the next cycle
    stage_3_storage_count_control_i : aurora_8b10b_v5_1_STORAGE_COUNT_CONTROL 
    port map(
        LEFT_ALIGNED_COUNT  =>   stage_2_data_v_count_r,
        END_STORAGE         =>   stage_3_end_storage_r,
        START_WITH_DATA     =>   stage_2_start_with_data_r,
        FRAME_ERROR         =>   stage_2_frame_error_r,
        
        STORAGE_COUNT       =>   stage_3_storage_count_r,
        
        USER_CLK            =>   USER_CLK,
        RESET               =>   RESET
          
    );
        
     
     
    --Determine the CE settings for the storage module for the next cycle
    stage_3_storage_ce_control_i : aurora_8b10b_v5_1_STORAGE_CE_CONTROL 
    port map(
        LEFT_ALIGNED_COUNT  =>   stage_2_data_v_count_r,
        STORAGE_COUNT       =>   stage_3_storage_count_r,
        END_STORAGE         =>   stage_3_end_storage_r,
        START_WITH_DATA     =>   stage_2_start_with_data_r,

        STORAGE_CE          =>   stage_3_storage_ce_r,
        
        USER_CLK            =>   USER_CLK,
        RESET               =>   RESET
    
    );
    
             
        
    --Determine the appropriate switch settings for the storage module for the next cycle
    stage_3_storage_switch_control_i : aurora_8b10b_v5_1_STORAGE_SWITCH_CONTROL 
    port map(
        LEFT_ALIGNED_COUNT  =>   stage_2_data_v_count_r,
        STORAGE_COUNT       =>   stage_3_storage_count_r,
        END_STORAGE         =>   stage_3_end_storage_r,
        START_WITH_DATA     =>   stage_2_start_with_data_r,

        STORAGE_SELECT      =>   stage_3_storage_select_r,
        
        USER_CLK            =>   USER_CLK
        
    );
    
        
        
    --Determine the appropriate switch settings for the output module for the next cycle
    stage_3_output_switch_control_i : aurora_8b10b_v5_1_OUTPUT_SWITCH_CONTROL 
    port map(
        LEFT_ALIGNED_COUNT  =>   stage_2_data_v_count_r,
        STORAGE_COUNT       =>   stage_3_storage_count_r,
        END_STORAGE         =>   stage_3_end_storage_r,
        START_WITH_DATA     =>   stage_2_start_with_data_r,

        OUTPUT_SELECT       =>   stage_3_output_select_r,
        
        USER_CLK            =>   USER_CLK
    
    );
        
    
    --Instantiate a sideband output controller
    sideband_output_i : aurora_8b10b_v5_1_SIDEBAND_OUTPUT 
    port map(
        LEFT_ALIGNED_COUNT  =>   stage_2_data_v_count_r,
        STORAGE_COUNT       =>   stage_3_storage_count_r,
        END_BEFORE_START    =>   stage_2_end_before_start_r,
        END_AFTER_START     =>   stage_2_end_after_start_r,
        START_DETECTED      =>   stage_2_start_detected_r,
        START_WITH_DATA     =>   stage_2_start_with_data_r,
        PAD                 =>   stage_2_pad_r,
        FRAME_ERROR         =>   stage_2_frame_error_r,
        USER_CLK            =>   USER_CLK,
        RESET               =>   RESET,
    
        END_STORAGE         =>   stage_3_end_storage_r,
        SRC_RDY_N           =>   stage_3_src_rdy_n_r,
        SOF_N               =>   stage_3_sof_n_r,
        EOF_N               =>   stage_3_eof_n_r,
        RX_REM              =>   stage_3_rem_r,
        FRAME_ERROR_RESULT  =>   stage_3_frame_error_r
    );
    
      
    
    
    
    --________________________________ Stage 4: Storage and Output_______________________
 
    
    --Storage: Data is moved to storage when it cannot be sent directly to the output.
    
    stage_4_storage_mux_i : aurora_8b10b_v5_1_STORAGE_MUX 
    port map(
        RAW_DATA        =>   stage_3_data_r,
        MUX_SELECT      =>   stage_3_storage_select_r,
        STORAGE_CE      =>   stage_3_storage_ce_r,
        USER_CLK        =>   USER_CLK,

        STORAGE_DATA    =>   storage_data_r
        
    );
    
    
    
    --Output: Data is moved to the locallink output when a full word of valid data is ready,
    -- or the end of a frame is reached
    
    output_mux_i : aurora_8b10b_v5_1_OUTPUT_MUX 
    port map(
        STORAGE_DATA        =>   storage_data_r,    
        LEFT_ALIGNED_DATA   =>   stage_3_data_r,
        MUX_SELECT          =>   stage_3_output_select_r,
        USER_CLK            =>   USER_CLK,
        
        OUTPUT_DATA         =>   RX_D_Buffer
        
    );
    
    
    --Pipeline LocalLink sideband signals
    process(USER_CLK)
    begin
        if(USER_CLK 'event and USER_CLK = '1') then
            RX_SOF_N_Buffer        <=  stage_3_sof_n_r after DLY;
            RX_EOF_N_Buffer        <=  stage_3_eof_n_r after DLY;
            RX_REM_Buffer          <=  stage_3_rem_r after DLY;
        end if;    
    end process;
         

    --Pipeline the LocalLink source Ready signal
    process(USER_CLK)
    begin
        if(USER_CLK 'event and USER_CLK = '1') then
            if(RESET = '1') then
                RX_SRC_RDY_N_Buffer    <=  '1' after DLY;
            else
                RX_SRC_RDY_N_Buffer    <=  stage_3_src_rdy_n_r after DLY;
            end if;
        end if;
    end process;    
        
        
    
    --Pipeline the Frame error signal
    process(USER_CLK)
    begin
        if(USER_CLK 'event and USER_CLK = '1') then
            if(RESET = '1') then
                FRAME_ERROR_Buffer     <=  '0' after DLY;
            else        
                FRAME_ERROR_Buffer     <=  stage_3_frame_error_r after DLY;
            end if;
        end if;
    end process;    
    
 
 
 end RTL;


