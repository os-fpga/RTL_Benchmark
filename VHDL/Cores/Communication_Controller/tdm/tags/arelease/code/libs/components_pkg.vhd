-------------------------------------------------------------------------------
-- Title      : ISDN tdm controller
-- Project    : TDM controller
-------------------------------------------------------------------------------
-- File       : components_pkg.vhd
-- Author     : Jamil Khatib  <khatib@ieee.org>
-- Organization:  OpenCores.org
-- Created    : 2001/05/06
-- Last update:2001/05/06
-- Platform   : 
-- Simulators  : NC-sim/linux, Modelsim XE/windows98
-- Synthesizers: Leonardo
-- Target      : 
-- Dependency  : ieee.std_logic_1164
-------------------------------------------------------------------------------
-- Description:  tdm components
-------------------------------------------------------------------------------
-- Copyright (c) 2001  Jamil Khatib
-- 
-- This VHDL design file is an open design; you can redistribute it and/or
-- modify it and/or implement it after contacting the author
-- You can check the draft license at
-- http://www.opencores.org/OIPC/license.shtml
-------------------------------------------------------------------------------
-- Revisions  :
-- Revision Number :   1
-- Version         :   0.1
-- Date            :  2001/05/06
-- Modifier        :  Jamil Khatib  <khatib@ieee.org>
-- Desccription    :  Created
-- ToOptimize      :
-- Known Bugs      : 
-------------------------------------------------------------------------------
-- $Log: not supported by cvs2svn $
--
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE components_pkg IS

  COMPONENT isdn_cont_ent
    PORT (
      rst_n     : in  std_logic;
      C2        : in  std_logic;
      DSTi      : in  std_logic;
      DSTo      : out std_logic;
      F0_n      : in  std_logic;
      F0od_n    : out std_logic;
      HDLCen1   : out std_logic;
      HDLCen2   : out std_logic;
      HDLCen3   : out std_logic;
      HDLCTxen1 : out std_logic;
      HDLCTxen2 : out std_logic;
      HDLCTxen3 : out std_logic;
      Dout      : out std_logic;
      Din1      : in  std_logic;
      Din2      : in  std_logic;
      Din3      : in  std_logic);
  END COMPONENT;
  

END components_pkg;
