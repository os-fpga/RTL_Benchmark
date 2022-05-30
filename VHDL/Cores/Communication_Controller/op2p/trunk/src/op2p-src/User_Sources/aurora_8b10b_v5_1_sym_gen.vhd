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
--  SYM_GEN
--
--
--  Description: The SYM_GEN module is a symbol generator for 2-byte Aurora Lanes.
--               Its inputs request the transmission of specific symbols, and its
--               outputs drive the GTP interface to fulfil those requests.
--
--               All generation request inputs must be asserted exclusively
--               except for the GEN_K, GEN_R and GEN_A signals from the Global
--               Logic, and the GEN_PAD and TX_PE_DATA_V signals from TX_LL.
--
--               GEN_K, GEN_R and GEN_A can be asserted anytime, but they are
--               ignored when other signals are being asserted.  This allows the
--               idle generator in the Global Logic to run continuosly without
--               feedback, but requires the TX_LL and Lane Init SM modules to
--               be quiescent during Channel Bonding and Verification.
--
--               The GEN_PAD signal is only valid while the TX_PE_DATA_V signal
--               is asserted.  This allows padding to be specified for the LSB of
--               the data transmission.  GEN_PAD must not be asserted when
--               TX_PE_DATA_V is not asserted - this will generate errors.
--
--               This module supports Completion Mode Native Flow Control.
--
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity aurora_8b10b_v5_1_SYM_GEN is

    port (

    -- TX_LL Interface                                        -- See description for info about GEN_PAD and TX_PE_DATA_V.

            GEN_SCP      : in std_logic;                      -- Generate SCP.
            GEN_ECP      : in std_logic;                      -- Generate ECP.
            GEN_SNF      : in std_logic;                      -- Generate SNF using code given by FC_NB.
            GEN_PAD      : in std_logic;                      -- Replace LSB with Pad character.
            FC_NB        : in std_logic_vector(0 to 3);       -- Size code for Flow Control messages.
            TX_PE_DATA   : in std_logic_vector(0 to 15);      -- Data.  Transmitted when TX_PE_DATA_V is asserted.
            TX_PE_DATA_V : in std_logic;                      -- Transmit data.
            GEN_CC       : in std_logic;                      -- Generate Clock Correction symbols.

    -- Global Logic Interface                                 -- See description for info about GEN_K,GEN_R and GEN_A.

            GEN_A        : in std_logic;                      -- Generate A character for selected bytes.
            GEN_K        : in std_logic_vector(0 to 1);       -- Generate K character for selected bytes.
            GEN_R        : in std_logic_vector(0 to 1);       -- Generate R character for selected bytes.
            GEN_V        : in std_logic_vector(0 to 1);       -- Generate Ver data character on selected bytes.

    -- Lane Init SM Interface

            GEN_K_FSM    : in std_logic;                      -- Generate K character on byte 0.
            GEN_SP_DATA  : in std_logic_vector(0 to 1);       -- Generate SP data character on selected bytes.
            GEN_SPA_DATA : in std_logic_vector(0 to 1);       -- Generate SPA data character on selected bytes.

    -- GTP Interface

            TX_CHAR_IS_K : out std_logic_vector(1 downto 0);  -- Transmit TX_DATA as a control character.
            TX_DATA      : out std_logic_vector(15 downto 0); -- Data to GTP for transmission to channel partner.

    -- System Interface

            USER_CLK     : in std_logic;                       -- Clock for all non-GTP Aurora Logic.
            RESET        : in std_logic                        -- RESET signal to drive TX_CHAR_IS_K to known value 

         );

end aurora_8b10b_v5_1_SYM_GEN;

architecture RTL of aurora_8b10b_v5_1_SYM_GEN is

-- Parameter Declarations --

    constant DLY : time := 1 ns;

-- External Register Declarations --

    signal TX_CHAR_IS_K_Buffer : std_logic_vector(1 downto 0);
    signal TX_DATA_Buffer      : std_logic_vector(15 downto 0);

-- Internal Register Declarations --

    -- Slack registers.  Allow slack for routing delay and automatic retiming.

    signal gen_scp_r      : std_logic;
    signal gen_ecp_r      : std_logic;
    signal gen_snf_r      : std_logic;
    signal gen_pad_r      : std_logic;
    signal fc_nb_r        : std_logic_vector(0 to 3);
    signal tx_pe_data_r   : std_logic_vector(0 to 15);
    signal tx_pe_data_v_r : std_logic;
    signal gen_cc_r       : std_logic;
    signal gen_a_r        : std_logic;
    signal gen_k_r        : std_logic_vector(0 to 1);
    signal gen_r_r        : std_logic_vector(0 to 1);
    signal gen_v_r        : std_logic_vector(0 to 1);
    signal gen_k_fsm_r    : std_logic;
    signal gen_sp_data_r  : std_logic_vector(0 to 1);
    signal gen_spa_data_r : std_logic_vector(0 to 1);

-- Wire Declarations --

    signal idle_c : std_logic_vector(0 to 1);

begin

    TX_CHAR_IS_K <= TX_CHAR_IS_K_Buffer;
    TX_DATA      <= TX_DATA_Buffer;

-- Main Body of Code --

    -- Register all inputs with the slack registers.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            gen_scp_r      <= GEN_SCP      after DLY;
            gen_ecp_r      <= GEN_ECP      after DLY;
            gen_snf_r      <= GEN_SNF      after DLY;
            gen_pad_r      <= GEN_PAD      after DLY;
            fc_nb_r        <= FC_NB        after DLY;
            tx_pe_data_r   <= TX_PE_DATA   after DLY;
            tx_pe_data_v_r <= TX_PE_DATA_V after DLY;
            gen_cc_r       <= GEN_CC       after DLY;
            gen_a_r        <= GEN_A        after DLY;
            gen_k_r        <= GEN_K        after DLY;
            gen_r_r        <= GEN_R        after DLY;
            gen_v_r        <= GEN_V        after DLY;
            gen_k_fsm_r    <= GEN_K_FSM    after DLY;
            gen_sp_data_r  <= GEN_SP_DATA  after DLY;
            gen_spa_data_r <= GEN_SPA_DATA after DLY;

        end if;

    end process;


    -- When none of the msb non_idle inputs are asserted, allow idle characters.

    idle_c(0) <= not (gen_scp_r         or
                      gen_ecp_r         or
                      gen_snf_r         or
                      tx_pe_data_v_r    or
                      gen_cc_r          or
                      gen_k_fsm_r       or
                      gen_sp_data_r(0)  or
                      gen_spa_data_r(0) or
                      gen_v_r(0));



    -- Generate data for MSB.  Note that all inputs must be asserted exclusively, except
    -- for the GEN_A, GEN_K and GEN_R inputs which are ignored when other characters
    -- are asserted.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if (gen_scp_r = '1') then

                TX_DATA_Buffer(15 downto 8) <= X"5C" after DLY;                -- K28.2(SCP)

            end if;

            if (gen_ecp_r = '1') then

                TX_DATA_Buffer(15 downto 8) <= X"FD" after DLY;                -- K29.7(ECP)

            end if;

            if (gen_snf_r = '1') then

                TX_DATA_Buffer(15 downto 8) <= X"DC" after DLY;                -- K28.6(SNF)

            end if;

            if (tx_pe_data_v_r = '1') then

                TX_DATA_Buffer(15 downto 8) <= tx_pe_data_r(0 to 7) after DLY; -- DATA

            end if;

            if (gen_cc_r = '1') then

                TX_DATA_Buffer(15 downto 8) <= X"F7" after DLY;                -- K23.7(CC)

            end if;

            if ((idle_c(0) and gen_a_r) = '1') then

                TX_DATA_Buffer(15 downto 8) <= X"7C" after DLY;                -- K28.3(A)

            end if;

            if ((idle_c(0) and gen_k_r(0)) = '1') then

                TX_DATA_Buffer(15 downto 8) <= X"BC" after DLY;                -- K28.5(K)

            end if;

            if ((idle_c(0) and gen_r_r(0)) = '1') then

                TX_DATA_Buffer(15 downto 8) <= X"1C" after DLY;                -- K28.0(R)

            end if;

            if (gen_k_fsm_r = '1') then

                TX_DATA_Buffer(15 downto 8) <= X"BC" after DLY;                -- K28.5(K)

            end if;

            if (gen_sp_data_r(0) = '1') then

                TX_DATA_Buffer(15 downto 8) <= X"4A" after DLY;                -- D10.2(SP data)

            end if;

            if (gen_spa_data_r(0) = '1') then

                TX_DATA_Buffer(15 downto 8) <= X"2C" after DLY;                -- D12.1(SPA data)

            end if;

            if (gen_v_r(0) = '1') then

                TX_DATA_Buffer(15 downto 8) <= X"E8" after DLY;                -- D8.7(Ver data)

            end if;

        end if;

    end process;


    -- Generate control signal for MSB.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

          if(RESET = '1') then
            TX_CHAR_IS_K_Buffer(1) <= '0' after DLY;
          else
            TX_CHAR_IS_K_Buffer(1) <= not (tx_pe_data_v_r    or
                                    gen_sp_data_r(0)  or
                                    gen_spa_data_r(0) or
                                    gen_v_r(0)) after DLY;
          end if;
        end if;

    end process;


    -- When none of the msb non_idle inputs are asserted, allow idle characters.  Note that
    -- because gen_pad is only valid with the data valid signal, we only look at the data
    -- valid signal.

    idle_c(1) <= not (gen_scp_r         or
                      gen_ecp_r         or
                      gen_snf_r         or
                      tx_pe_data_v_r    or
                      gen_cc_r          or
                      gen_sp_data_r(1)  or
                      gen_spa_data_r(1) or
                      gen_v_r(1));



    -- Generate data for LSB. Note that all inputs must be asserted exclusively except for
    -- the GEN_PAD signal and the GEN_K and GEN_R. GEN_PAD can be asserted
    -- at the same time as TX_DATA_VALID.  This will override TX_DATA and replace the
    -- lsb user data with a PAD character.  The GEN_K and GEN_R inputs are ignored
    -- if any other input is asserted.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

            if (gen_scp_r = '1') then

                TX_DATA_Buffer(7 downto 0) <= X"FB" after DLY;                 -- K27.7(SCP)

            end if;

            if (gen_ecp_r = '1') then

                TX_DATA_Buffer(7 downto 0) <= X"FE" after DLY;                 -- K30.7(ECP)

            end if;

            if (gen_snf_r = '1') then

                TX_DATA_Buffer(7 downto 0) <= fc_nb_r & "0000" after DLY;      -- SNF Data

            end if;

            if ((tx_pe_data_v_r and gen_pad_r) = '1') then

                TX_DATA_Buffer(7 downto 0) <= X"9C" after DLY;                 -- K28.4(PAD)

            end if;

            if ((tx_pe_data_v_r and not gen_pad_r) = '1') then

                TX_DATA_Buffer(7 downto 0) <= tx_pe_data_r(8 to 15) after DLY; -- DATA

            end if;

            if (gen_cc_r = '1') then

                TX_DATA_Buffer(7 downto 0) <= X"F7" after DLY;                 -- K23.7(CC)

            end if;

            if ((idle_c(1) and gen_k_r(1)) = '1') then

                TX_DATA_Buffer(7 downto 0) <= X"BC" after DLY;                 -- K28.5(K)

            end if;

            if ((idle_c(1) and gen_r_r(1)) = '1') then

                TX_DATA_Buffer(7 downto 0) <= X"1C" after DLY;                 -- K28.0(R)

            end if;

            if (gen_sp_data_r(1) = '1') then

                TX_DATA_Buffer(7 downto 0) <= X"4A" after DLY;                 -- D10.2(SP data)

            end if;

            if (gen_spa_data_r(1) = '1') then

                TX_DATA_Buffer(7 downto 0) <= X"2C" after DLY;                 -- D12.1(SPA data)

            end if;

            if (gen_v_r(1) = '1') then

                TX_DATA_Buffer(7 downto 0) <= X"E8" after DLY;                 -- D8.7(Ver data)

            end if;

        end if;

    end process;


    -- Generate control signal for LSB.

    process (USER_CLK)

    begin

        if (USER_CLK 'event and USER_CLK = '1') then

          if(RESET = '1') then
            TX_CHAR_IS_K_Buffer(0) <= '0' after DLY;
          else 
            TX_CHAR_IS_K_Buffer(0) <= not ((tx_pe_data_v_r and not gen_pad_r) or
                                            gen_snf_r                         or
                                            gen_sp_data_r(1)                  or
                                            gen_spa_data_r(1)                 or
                                            gen_v_r(1)) after DLY;

          end if;
        end if;

    end process;

end RTL;
