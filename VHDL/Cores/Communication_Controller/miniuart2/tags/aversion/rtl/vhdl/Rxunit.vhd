-------------------------------------------------------------------------------
-- Title      : UART
-- Project    : UART
-------------------------------------------------------------------------------
-- File        : Rxunit.vhd
-- Author      : Philippe CARTON 
--               (pc@microsystemes.com / philippe.carton2@libertysurf.fr)
-- Organization: Microsystemes
-- Created     : 15/12/2001
-- Last update : 28/12/2001
-- Platform    : Foundation 3.1i
-- Simulators  : Foundation logic simulator
-- Synthesizers: Foundation Synopsys
-- Targets     : Xilinx Spartan
-- Dependency  : IEEE std_logic_1164
-------------------------------------------------------------------------------
-- Description: RxUnit is a serial to parallel unit Receiver.
-------------------------------------------------------------------------------
-- Copyright (c) notice
--    This core adheres to the GNU public license 
--
-------------------------------------------------------------------------------
-- Revisions       :
-- Revision Number :
-- Version         :
-- Date    :
-- Modifier        : name <email>
-- Description     :
--
------------------------------------------------------------------------------
library ieee;
   use ieee.std_logic_1164.all;
   
entity RxUnit is
  port (
     Clk    : in  Std_Logic;  -- system clock signal
     Reset  : in  Std_Logic;  -- Reset input
     Enable : in  Std_Logic;  -- Enable input
     ReadA  : in  Std_logic;  -- Async Read Received Byte
     RxD    : in  Std_Logic;  -- RS-232 data input
     RxAv   : out Std_Logic;  -- Byte available
     DataO  : out Std_Logic_Vector(7 downto 0)); -- Byte received
end entity;

architecture Behaviour of RxUnit is
  signal RReg    : Std_Logic_Vector(7 downto 0); -- receive register  
  signal RRegL   : Std_Logic;                    -- Byte received
begin
  -- RxAv process
  RxAvProc : process(RRegL,Reset,ReadA)
  begin
     if ReadA = '1' or Reset = '1' then
        RxAv <= '0';  -- Negate RxAv when RReg read     
     elsif Rising_Edge(RRegL) then
        RxAv <= '1';  -- Assert RxAv when RReg written
     end if;
  end process;
  
  -- Rx Process
  RxProc : process(Clk,Reset,Enable,RxD,RReg)
  variable BitPos : INTEGER range 0 to 10;   -- Position of the bit in the frame
  variable SampleCnt : INTEGER range 0 to 3; -- Count from 0 to 3 in each bit 
  begin
     if Reset = '1' then -- Reset
        RRegL <= '0';
        BitPos := 0;           
     elsif Rising_Edge(Clk) then
        if Enable = '1' then
           case BitPos is
              when 0 => -- idle
                 RRegL <= '0';
                 if RxD = '0' then -- Start Bit
                    SampleCnt := 0;
                    BitPos := 1;
                 end if;
              when 10 => -- Stop Bit
                 BitPos := 0;    -- next is idle
                 RRegL <= '1';   -- Indicate byte received
                 DataO <= RReg;  -- Store received byte
              when others =>
                 if SampleCnt = 1 then -- Sample RxD on 1
                    RReg(BitPos-2) <= RxD; -- Deserialisation
                 end if;
                 if SampleCnt = 3 then -- Increment BitPos on 3
                    BitPos := BitPos + 1;                    
                 end if;
           end case;   
           sampleCnt := SampleCnt + 1;   
        end if;
     end if;
  end process;
end Behaviour;
