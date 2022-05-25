-------------------------------------------------------------------------------
-- Title      :  HDLC flag detection
-- Project    :  HDLC controller
-------------------------------------------------------------------------------
-- File        : flag_detect.vhd
-- Author      : Jamil Khatib  (khatib@ieee.org)
-- Organization: OpenIPCore Project
-- Created     : 2000/12/28
-- Last update: 2001/01/05
-- Platform    : 
-- Simulators  : Modelsim 5.3XE/Windows98
-- Synthesizers: 
-- Target      : 
-- Dependency  : ieee.std_logic_1164
--
-------------------------------------------------------------------------------
-- Description:  Flag detection
-------------------------------------------------------------------------------
-- Copyright (c) 2000 Jamil Khatib
-- 
-- This VHDL design file is an open design; you can redistribute it and/or
-- modify it and/or implement it after contacting the author
-- You can check the draft license at
-- http://www.opencores.org/OIPC/license.shtml

-------------------------------------------------------------------------------
-- Revisions  :
-- Revision Number :   1
-- Version         :   0.1
-- Date            :   28 Dec 2000
-- Modifier        :   Jamil Khatib (khatib@ieee.org)
-- Desccription    :   Created
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity FlagDetect_ent is

  port (
    Rxclk      : in  std_logic;         -- Rx clock
    rst        : in  std_logic;         -- system reset
    FlagDetect : out std_logic;         -- Flag detected
    Abort      : out std_logic;         -- Abort signal detected
    RXD        : out std_logic;         -- RXD output
    RX         : in  std_logic);        -- RX signal

end FlagDetect_ent;

architecture FlagDetect_beh of FlagDetect_ent is
  type states_typ is (IDLE, ZERO, ONE1, ONE2, ONE3, ONE4, ONE5, ONE6);
                                        -- State machine states

  signal ShiftReg : std_logic_vector(7 downto 0);  -- Shift Register

begin  -- FlagDetect_beh

  -- purpose: Flag detection
  -- type   : sequential
  -- inputs : RXclk, rst
  -- outputs: 
  bitstreem_proc     : process (RXclk, rst)
    variable state   : states_typ;      -- System State
    variable FlagVar : std_logic;       -- Flag detected variable
  begin  -- process bitstreem_proc
    if rst = '0' then                   -- asynchronous reset (active low)

--      state      := IDLE;
      FlagDetect <= '0';
      Abort      <= '0';

      RXD <= '0';

      FlagVar := '0';

      ShiftReg <= (others => '0');

    elsif RXclk'event and RXclk = '1' then  -- rising clock edge

      FlagVar := not ShiftReg(0) and ShiftReg(1) and ShiftReg(2) and ShiftReg(3) and ShiftReg(4) and ShiftReg(5) and ShiftReg(6) and not ShiftReg(7);

      FlagDetect <= FlagVar;

      Abort <= not ShiftReg(0) and ShiftReg(1) and ShiftReg(2) and ShiftReg(3) and ShiftReg(4) and ShiftReg(5) and ShiftReg(6) and ShiftReg(7);


      ShiftReg(7 downto 0) <= RX & ShiftReg(7 downto 1);
      RXD                  <= ShiftReg(0);

--      case state is

--        when IDLE =>
--          if RX = '0' then
--            state := ZERO;
--          else
--            state := IDLE;
--          end if;

--          FlagDetect <= '0';
--          Abort      <= '0';
---------------------------------------------------------------------------------

--        when ZERO =>
--          if RX = '0' then
--            state := ZERO;
--          else
--            state := ONE1;
--          end if;

--          FlagDetect <= '0';
--          Abort      <= '0';
---------------------------------------------------------------------------------

--        when ONE1 =>
--          if RX = '0' then
--            state := ZERO;
--          else
--            state := ONE2;
--          end if;

--          FlagDetect <= '0';
--          Abort      <= '0';
---------------------------------------------------------------------------------
--        when ONE2 =>
--          if RX = '0' then
--            state    := ZERO;
--          else
--            state    := ONE3;
--          end if;

--          FlagDetect <= '0';
--          Abort      <= '0';
---------------------------------------------------------------------------------
--        when ONE3 =>
--          if RX = '0' then
--            state    := ZERO;
--          else
--            state    := ONE4;
--          end if;

--          FlagDetect <= '0';
--          Abort      <= '0';
---------------------------------------------------------------------------------
--        when ONE4 =>
--          if RX = '0' then
--            state    := ZERO;
--          else
--            state    := ONE5;
--          end if;

--          FlagDetect <= '0';
--          Abort      <= '0';
---------------------------------------------------------------------------------
--        when ONE5 =>
--          if RX = '0' then
--            state    := ZERO;
--          else
--            state    := ONE6;
--          end if;

--          FlagDetect   <= '0';
--          Abort        <= '0';
---------------------------------------------------------------------------------
--        when ONE6 =>
--          if RX = '0' then
--            FlagDetect <= '1';
--            Abort      <= '0';
--          else

--            FlagDetect <= '0';
--            Abort      <= '1';
--          end if;
--          state        := ZERO;

---------------------------------------------------------------------------------
--          when others =>
--            state    := IDLE;
--          FlagDetect <= '0';
--          Abort      <= '0';

--      end case;

--      RXD <= RX;

    end if;
  end process bitstreem_proc;

end FlagDetect_beh;
