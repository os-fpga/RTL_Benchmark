-------------------------------------------------------------------------------
-- Title      :  HDLC components package
-- Project    :  HDLC controller
-------------------------------------------------------------------------------
-- File        : hdlc_components_pkg.vhd
-- Author      : Jamil Khatib  (khatib@ieee.org)
-- Organization: OpenIPCore Project
-- Created     : 2000/12/30
-- Last update : 2000/12/30
-- Platform    : 
-- Simulators  : Modelsim 5.3XE/Windows98
-- Synthesizers: 
-- Target      : 
-- Dependency  : ieee.std_logic_1164
--
-------------------------------------------------------------------------------
-- Description:  HDLC components package
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
-- Date            :   30 Dec 2000
-- Modifier        :   Jamil Khatib (khatib@ieee.org)
-- Desccription    :   Created
-- ToOptimize      :
-- Bugs            : 
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

package hdlc_components_pkg is

  component rxcont_ent
    port (
      RxClk        : in  std_logic;
      rst          : in  std_logic;
      RxEn         : in  std_logic;
      AbortedFrame : out std_logic;
      Abort        : in  std_logic;
      FlagDetect   : in  std_logic;
      ValidFrame   : out std_logic;
      FrameError   : out std_logic;
      aval         : in  std_logic;
      initzero     : out std_logic;
      enable       : out std_logic);
  end component;


  component ZeroDetect_ent
    port (
      Readbyte     : in  std_logic;
      aval         : out std_logic;
      enable       : in  std_logic;
      StartOfFrame : in  std_logic;
      rdy          : out std_logic;
      rst          : in  std_logic;
      RxClk        : in  std_logic;
      RxD          : in  std_logic;
      RxData       : out std_logic_vector(7 downto 0));
  end component;

  component FlagDetect_ent
    port (
      Rxclk      : in  std_logic;
      rst        : in  std_logic;
      FlagDetect : out std_logic;
      Abort      : out std_logic;
      RXD        : out std_logic;
      RX         : in  std_logic);
  end component;

  component RxChannel_ent
    port (
      Rxclk       : in  std_logic;
      rst         : in  std_logic;
      Rx          : in  std_logic;
      RxData      : out std_logic_vector(7 downto 0);
      ValidFrame  : out std_logic;
      AbortSignal : out std_logic;
      FrameError : out std_logic;
      Readbyte    : in  std_logic;
      rdy         : out std_logic;
      RxEn        : in  std_logic);
  end component;

end hdlc_components_pkg;
