-----------------------------------------------------------------------
----                                                               ----
---- Montgomery modular multiplier and exponentiator               ----
----                                                               ----
---- This file is part of the Montgomery modular multiplier        ----
---- and exponentiator project                                     ----
---- http://opencores.org/project,mod_mult_exp                     ----
----                                                               ----
---- Description:                                                  ----
----   This module is state machine for the example implementation ---- 
----   of the Montgomery modular exponentiatorcombined with the    ----
----   RS-232 communication with PC.                               ----
----                                                               ----
---- To Do:                                                        ----
----                                                               ----
---- Author(s):                                                    ----
---- - Krzysztof Gajewski, gajos@opencores.org                     ----
----                       k.gajewski@gmail.com                    ----
----                                                               ----
-----------------------------------------------------------------------
----                                                               ----
---- Copyright (C) 2019 Authors and OPENCORES.ORG                  ----
----                                                               ----
---- This source file may be used and distributed without          ----
---- restriction provided that this copyright statement is not     ----
---- removed from the file and that any derivative work contains   ----
---- the original copyright notice and the associated disclaimer.  ----
----                                                               ----
---- This source file is free software; you can redistribute it    ----
---- and-or modify it under the terms of the GNU Lesser General    ----
---- Public License as published by the Free Software Foundation;  ----
---- either version 2.1 of the License, or (at your option) any    ----
---- later version.                                                ----
----                                                               ----
---- This source is distributed in the hope that it will be        ----
---- useful, but WITHOUT ANY WARRANTY; without even the implied    ----
---- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR       ----
---- PURPOSE. See the GNU Lesser General Public License for more   ----
---- details.                                                      ----
----                                                               ----
---- You should have received a copy of the GNU Lesser General     ----
---- Public License along with this source; if not, download it    ----
---- from http://www.opencores.org/lgpl.shtml                      ----
----                                                               ----
-----------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.properties.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ModExpDataCtrlSM is
    port(
        clk                 : in  STD_LOGIC;
        reset               : in  STD_LOGIC;
        RDAsig              : in  STD_LOGIC;
        TBEsig              : in  STD_LOGIC;
        RDsig               : out STD_LOGIC;
        WRsig               : out STD_LOGIC;
        data_in_ready       : out STD_LOGIC;
        readySig            : in  STD_LOGIC;
        modExpCtrlRegEn     : out STD_LOGIC;
        dataToModExpEn      : out STD_LOGIC;
        dataToModExpShift   : out STD_LOGIC;
        dataFromModExpEn    : out STD_LOGIC;
        dataFromModExpShift : out STD_LOGIC;
        muxCtrl             : out STD_LOGIC;
        opcodes             : in  STD_LOGIC_VECTOR(2 downto 0);
        controlStateOut     : out STD_LOGIC_VECTOR(2 downto 0)
);
end ModExpDataCtrlSM;

architecture Behavioral of ModExpDataCtrlSM is

-- Counters are used for both bit counting in byte 
-- and composing full length word in exponentiator
component counter is 
    generic(
        size : integer := 4
    );
    port ( 
        count  : in  STD_LOGIC;
        zero   : in  STD_LOGIC;
        output : out STD_LOGIC_VECTOR (size - 1 downto 0); 
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC
    ); 
end component counter;

-- some constants for temp_state signal which is used in TEMPORARY_STATE.
-- This state is used as something like "wait" command due to data 
-- propagation in the core
constant rd_data      : STD_LOGIC_VECTOR(2 downto 0) := "000";
constant mk_fin       : STD_LOGIC_VECTOR(2 downto 0) := "001";
constant dat_out_prop : STD_LOGIC_VECTOR(2 downto 0) := "010";
constant info_st      : STD_LOGIC_VECTOR(2 downto 0) := "011";
constant mv_dat       : STD_LOGIC_VECTOR(2 downto 0) := "100";
constant nothing      : STD_LOGIC_VECTOR(2 downto 0) := "101";

signal state      : comm_ctrl_states := NOP;
signal next_state : comm_ctrl_states := NOP;

signal temp_state : STD_LOGIC_VECTOR (2 downto 0) := nothing;

-- This signals are used for control the counters for data shifting
-- in shift registers (by bytes). This length have to be modified 
-- with changing the used word size.
-- Modify for variable key size
-- In fact it is modified from the properties file
signal serialDataCtrCt   : STD_LOGIC;
signal serialDataCtrZero : STD_LOGIC;
signal serialDataCtrOut  : STD_LOGIC_VECTOR(WORD_INT_LOG downto 0);

-- This signals are used for control the counters for data shifting - bits in 
-- bytes.
-- DO NOT MODIFY!!!
signal shiftDataCtrCt    : STD_LOGIC;
signal shiftDataCtrZero  : STD_LOGIC;
signal shiftDataCtrOut   : STD_LOGIC_VECTOR(3 downto 0);

begin
    -- State machine process
    SM : process(state, RDAsig, TBEsig, shiftDataCtrOut, 
         serialDataCtrOut, opcodes, readySig)
        begin
            case state is
                -- This state prepares whoole core before calculations
                -- 'No operation' state
                when NOP =>
                     WRsig <= '0';
                     modExpCtrlRegEn <= '0';
                     dataToModExpEn <= '0';
                     dataToModExpShift <= '0';
                     dataFromModExpEn <= '0';
                     dataFromModExpShift <= '0';
                     serialDataCtrZero <= '1';
                     serialDataCtrCt <= '0';
                     shiftDataCtrZero <= '1';
                     shiftDataCtrCt <= '0';
                     RDsig <= '0';
							-- This is something like 'info' word
                     if (readySig = '1') then
                        controlStateOut <= "100";
                     else
                        controlStateOut <= "000";
                     end if;
                     muxCtrl <= '1';
                     data_in_ready <= '0';
                     temp_state <= nothing; -- not important
                     -- RDAsig = '1' means that some data
                     -- appeard in the RS-232 input
                     if (RDAsig = '1') then
                        next_state <= DECODE_IN;
                     else
                        next_state <= NOP;
                     end if;
                when DECODE_IN =>
                     WRsig <= '0';
                     dataToModExpEn <= '0';
                     dataToModExpShift <= '0';
                     dataFromModExpEn <= '0';
                     dataFromModExpShift <= '0';
                     serialDataCtrZero <= '1';
                     serialDataCtrCt <= '0';
                     shiftDataCtrZero <= '1';
                     shiftDataCtrCt <= '0';
                     RDsig <= '1';
                     controlStateOut <= "000";
                     muxCtrl <= '1';
                     data_in_ready <= '0';
                     modExpCtrlRegEn <= '1';

                     -- firstly from the RS-232 input comes OPCODE informing the core
                     -- what to do. Data can appeard in any order. This opcode are saved
                     -- in the suitable register at the input of the modular exponentiator
                     if (opcodes = mn_read_base) or (opcodes = mn_read_modulus) or 
                         (opcodes = mn_read_exponent) or (opcodes = mn_read_residuum) then
                         next_state <= TEMPORARY_STATE;
                         temp_state <= rd_data;
                     elsif (opcodes = mn_count_power)  then
                         next_state <= TEMPORARY_STATE;
                         temp_state <= mk_fin;
                     elsif (opcodes = mn_show_result)  then
                         if (readySig = '1') then
                             next_state <= TEMPORARY_STATE;
                             temp_state <= dat_out_prop;
                         else
                             next_state <= TEMPORARY_STATE;
                             temp_state <= info_st;
                         end if;
                     elsif (opcodes = mn_prepare_for_data) then
                         next_state <= TEMPORARY_STATE;
                         temp_state <= nothing;
                     else 
                         next_state <= NOP;
                         temp_state <= nothing; -- not important
                     end if;
                when READ_DATA =>
                        -- For now need to 'restart' all the flow of reading data
                        modExpCtrlRegEn <= '0';
                        RDsig <= '0';
                        WRsig <= '0';
                        serialDataCtrCt <= '0';
                        serialDataCtrZero <= '0';
                        shiftDataCtrCt <= '0';
                        shiftDataCtrZero <= '0';
                        dataToModExpEn <= '1';
                        dataToModExpShift <= '0';
                        dataFromModExpEn <= '0';
                        dataFromModExpShift <= '0';
                        
                        controlStateOut <= "000";
                        muxCtrl <= '1';
                        data_in_ready <= '0';
                        temp_state <= nothing; -- not important
                        if (RDAsig = '0') then
                            next_state <= READ_DATA;
                        else
                            next_state <= DECODE_READ;
                        end if;
                -- This state is for the control of number of the 8-bit 'packets'
                -- of the input data for the modular exponentiator
                when DECODE_READ =>
                      modExpCtrlRegEn <= '0';
                      WRsig <= '0';
                      serialDataCtrCt <= '1';
                      serialDataCtrZero <= '0';
                      shiftDataCtrCt <= '0';
                      shiftDataCtrZero <= '0';
                      dataToModExpShift <= '0';
                      dataFromModExpEn <= '0';
                      dataFromModExpShift <= '0';
                      RDsig <= '1';
                      dataToModExpEn <= '1';
                      controlStateOut <= "000";
                      muxCtrl <= '1';
                      data_in_ready <= '0';
                      -- Data reading X times 8 bit -> modify for variable key length
                      -- In fact it is modified from the properties file
                      if (serialDataCtrOut(WORD_INT_LOG - 1 downto 0) = WORD_INT_LOG_STR) then
                          next_state <= DECODE_READ_PROP;
                          temp_state <= nothing; -- not important
                      else
                          next_state <= TEMPORARY_STATE;
                          temp_state <= mv_dat;
                      end if;
                -- Some info state for the modular exponentiator core,
                -- that some data are at the input - after the end of the 
                -- reading data
                when DECODE_READ_PROP =>
                      modExpCtrlRegEn <= '0';
                      WRsig <= '0';
                      serialDataCtrCt <= '0';
                      serialDataCtrZero <= '0';
                      shiftDataCtrCt <= '0';
                      shiftDataCtrZero <= '0';
                      dataToModExpShift <= '0';
                      dataFromModExpEn <= '0';
                      dataFromModExpShift <= '0';
                      RDsig <= '0';
                      dataToModExpEn <= '0';
                      serialDataCtrCt <= '0';
                      muxCtrl <= '1';
                      data_in_ready <= '1';
                      temp_state <= nothing; -- not important
                      controlStateOut <= "000";
                      next_state <= INFO_STATE;
                -- This state is for moving bits in data word for the 
                -- modular exponentiator counter counts to 8 while data
                -- are shifted
                when MOVE_DATA =>
                    modExpCtrlRegEn <= '0';
                    RDsig <= '0';
                    WRsig <= '0';
                    serialDataCtrCt <= '0';
                    dataToModExpEn <= '0';
                    dataToModExpShift <= '1';
                    dataFromModExpEn <= '0';
                    dataFromModExpShift <= '0';
                    serialDataCtrZero <= '0';
                    temp_state <= nothing;
                    controlStateOut <= "000";
                    muxCtrl <= '1';
                    data_in_ready <= '0';
                    --- shifting data in register -> DO NOT MODIFY!!!
                    if (shiftDataCtrOut(2 downto 0) = "111") then
                        shiftDataCtrZero <= '1';
                        shiftDataCtrCt <= '0';
                        next_state <= READ_DATA;
                    else
                        shiftDataCtrZero <= '0';
                        shiftDataCtrCt <= '1';
                        next_state <= MOVE_DATA;
                    end if;
                -- If all the needed data appeared at the input
                -- and 'mn_count_power' command appeared modular exponentiation
                -- is performed. This state is present until modular exponentiation
                -- is calculated
                when MAKE_MOD_EXP =>
                    modExpCtrlRegEn <= '0';
                    RDsig <= '0';
                    WRsig <= '0';
                    dataToModExpEn <= '0';
                    dataToModExpShift <= '0';
                    dataFromModExpEn <= '0';
                    dataFromModExpShift <= '0';
                    serialDataCtrCt <= '0';
                    serialDataCtrZero <= '0';
                    shiftDataCtrCt <= '0';
                    shiftDataCtrZero <= '0';
                    muxCtrl <= '1';
                    data_in_ready <= '1';
                    
                    -- Here 
                    if (readySig = '1') then
                        controlStateOut <= "100";
                        next_state <= TEMPORARY_STATE;
                        temp_state <= info_st;
                    else
                        controlStateOut <= "001";
                        next_state <= MAKE_MOD_EXP;
                        temp_state <= nothing;
                    end if;
                -- When 'mn_show_result' command appears in the core input, 
                -- the result from the modular exponentiation feeds the output
                -- Here and below state are also for 'data propagation'
                when DATA_TO_OUT_PROPAGATE =>
                    modExpCtrlRegEn <= '0';
                    RDsig <= '0';
                    WRsig <= '0';
                    dataToModExpEn <= '0';
                    dataToModExpShift <= '0';
                    shiftDataCtrCt <= '0';
                    shiftDataCtrZero <= '0';
                    serialDataCtrCt <= '0';
                    serialDataCtrZero <= '0';
                    dataFromModExpEn <= '1';
                    dataFromModExpShift <= '0';
                    next_state <= DATA_TO_OUT_PROPAGATE2;
                    temp_state <= nothing;
                    controlStateOut <= "000";
                    muxCtrl <= '0';
                    data_in_ready <= '0';
                    temp_state <= nothing; -- not important
                when DATA_TO_OUT_PROPAGATE2 =>
                    modExpCtrlRegEn <= '0';
                    RDsig <= '0';
                    WRsig <= '1';
                    dataToModExpEn <= '0';
                    dataToModExpShift <= '0';
                    dataFromModExpEn <= '0';
                    dataFromModExpShift <= '0';
                    serialDataCtrCt <= '0';
                    serialDataCtrZero <= '0';
                    shiftDataCtrCt <= '0';
                    shiftDataCtrZero <= '0';
                    next_state <= OUTPUT_DATA;
                    temp_state <= nothing;
                    controlStateOut <= "000";
                    muxCtrl <= '0';
                    data_in_ready <= '0';
                    temp_state <= nothing; -- not important
                -- Here data from parallel form are transformed to serial form.
                -- This state is for the control of number of the 8-bit 'packets'
                -- of the input data for the modular exponentiator
                when OUTPUT_DATA =>
                    modExpCtrlRegEn <= '0';
                    dataToModExpEn <= '0';
                    dataToModExpShift <= '0';
                    dataFromModExpEn <= '0';
                    dataFromModExpShift <= '0';
                    shiftDataCtrCt <= '0';
                    shiftDataCtrZero <= '0';
                    serialDataCtrZero <= '0';
                    RDsig <= '0';
                    WRsig <= '1';
                    serialDataCtrCt <= '1';
                    temp_state <= nothing;
                    controlStateOut <= "000";
                    muxCtrl <= '0';
                    data_in_ready <= '0';
                    if (serialDataCtrOut(WORD_INT_LOG) = '1') then
                        next_state <= NOP;
                    else
                        next_state <= MOVE_OUTPUT_DATA;
                    end if;
                -- This state is for moving bits in data word for the 
                -- modular exponentiator counter counts to 8 while data
                -- are shifted
                when MOVE_OUTPUT_DATA =>
                    if (TBEsig = '0') then
                        -- Here we have to wait for the sending the previous serial data
                        modExpCtrlRegEn <= '0';
                        RDsig <= '0';
                        WRsig <= '0';
                        serialDataCtrCt <= '0';
                        dataToModExpEn <= '0';
                        dataToModExpShift <= '0';
                        dataFromModExpEn <= '0';
                        dataFromModExpShift <= '0';
                        serialDataCtrZero <= '0';
                        shiftDataCtrCt <= '0';
                        shiftDataCtrZero <= '0';
                        next_state <= MOVE_OUTPUT_DATA;
                        controlStateOut <= "000";
                        muxCtrl <= '0';
                        data_in_ready <= '0';
                        temp_state <= nothing; -- not important
                    else
                        -- Here data are shifted in the output data word
                        modExpCtrlRegEn <= '0';
                        RDsig <= '0';
                        WRsig <= '0';
                        serialDataCtrCt <= '0';
                        dataToModExpEn <= '0';
                        dataToModExpShift <= '0';
                        dataFromModExpEn <= '0';
                        dataFromModExpShift <= '1';
                        shiftDataCtrCt <= '1';
                        serialDataCtrZero <= '0';
                        controlStateOut <= "000";
                        muxCtrl <= '0';
                        data_in_ready <= '0';
                        temp_state <= nothing; -- not important
                        -- Output register shifting DO NOT MODIFY!!!
                        if (shiftDataCtrOut(3) = '1') then
                            shiftDataCtrCt <= '0';
                            shiftDataCtrZero <= '1';
                            dataFromModExpShift <= '0';
                            next_state <= DATA_TO_OUT_PROPAGATE2;
                        else
                            shiftDataCtrZero <= '0';
                            next_state <= MOVE_OUTPUT_DATA;
                        end if;
                    end if;
                -- State for informing 'the world' about the end of
                -- the modular exponentiation
                when INFO_STATE =>
                    modExpCtrlRegEn <= '0';
                    dataToModExpEn <= '0';
                    dataToModExpShift <= '0';
                    dataFromModExpEn <= '0';
                    dataFromModExpShift <= '0';
                    serialDataCtrCt <= '0';
                    serialDataCtrZero <= '0';
                    shiftDataCtrCt <= '0';
                    shiftDataCtrZero <= '0';
                    if (readySig = '1') then
                        controlStateOut <= "100";
                    else
                        controlStateOut <= "000";
                    end if;
                    muxCtrl <= '1';
                    data_in_ready <= '0';
                    temp_state <= nothing; -- not important
                    RDsig <= '0';
                    WRsig <= '1';
                    next_state <= NOP;
                -- This state is mostly used for 'data propagation'
                -- and control of work of the modular exponentiator
                -- its work/state depends on the 'temp_state' signal.
                -- temp_state = nothing means that this state is not used
                when TEMPORARY_STATE =>
                    modExpCtrlRegEn <= '0';
                    RDsig <= '0';
                    WRsig <= '0';
                    dataToModExpEn <= '0';
                    dataToModExpShift <= '0';
                    dataFromModExpEn <= '0';
                    dataFromModExpShift <= '0';
                    serialDataCtrCt <= '0';
                    serialDataCtrZero <= '0';
                    shiftDataCtrCt <= '0';
                    shiftDataCtrZero <= '0';
                    if (readySig = '1') then
                        controlStateOut <= "100";
                        next_state <= TEMPORARY_STATE;
                        temp_state <= info_st;
                    else
                        controlStateOut <= "001";
                        next_state <= MAKE_MOD_EXP;
                        temp_state <= nothing;
                    end if;
                    
                    if (temp_state = rd_data) then
                        muxCtrl <= '0';
                        data_in_ready <= '0';
                        next_state <= READ_DATA;
                        temp_state <= rd_data;
                    elsif (temp_state = mk_fin)  then
                       muxCtrl <= '0';
                       data_in_ready <= '1';
                       next_state <= MAKE_MOD_EXP;
                       temp_state <= mk_fin;
                    elsif (temp_state = dat_out_prop)  then
                       muxCtrl <= '1';
                       data_in_ready <= '0';
                       next_state <= DATA_TO_OUT_PROPAGATE;
                       temp_state <= dat_out_prop;
                    elsif (temp_state = info_st) then
                       muxCtrl <= '0';
                       data_in_ready <= '0';
                       next_state <= INFO_STATE;
                       temp_state <= info_st;
                    elsif (temp_state = mv_dat) then
                       muxCtrl <= '0';
                       data_in_ready <= '0';
                       next_state <= MOVE_DATA;
                       temp_state <= mv_dat;
                    else
                       muxCtrl <= '0';
                       data_in_ready <= '0';
                       next_state <= NOP;
                       temp_state <= nothing;
                    end if;
            end case;
        end process SM;

    state_modifier : process (clk, reset)
        begin
            if (clk = '1' and clk'Event) then
                if (reset = '1') then
                    state <= NOP;   
                else
                    state <= next_state;
                end if;
            end if;
        end process state_modifier;

    -- modify for changing width of the hey
    -- in fact it is modified from the properties file
    dataCounter : counter 
        generic map(
            size => WORD_INT_LOG + 1
        )
        port map ( 
           count  => serialDataCtrCt, 
           zero   => serialDataCtrZero, 
           output => serialDataCtrOut,
           clk    => clk, 
           reset  => reset
        );
        
    shiftCounter : counter 
        generic map(
            size => 4
        )
        port map ( 
            count  => shiftDataCtrCt, 
            zero   => shiftDataCtrZero, 
            output => shiftDataCtrOut,
            clk    => clk, 
            reset  => reset
        );

end Behavioral;