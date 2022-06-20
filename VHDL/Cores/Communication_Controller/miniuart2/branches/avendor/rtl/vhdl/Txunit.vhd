-------------------------------------------------------------------------------
-- Title      : UART
-- Project    : UART
-------------------------------------------------------------------------------
-- File        : Txunit.vhd
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
-- Description: Txunit is a parallel to serial unit transmitter.
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

entity TxUnit is
  port (
     Clk    : in  Std_Logic;  -- Clock signal
     Reset  : in  Std_Logic;  -- Reset input
     Enable : in  Std_Logic;  -- Enable input
     LoadA  : in  Std_Logic;  -- Asynchronous Load
     TxD    : out Std_Logic;  -- RS-232 data output
     Busy   : out Std_Logic;  -- Tx Busy
     DataI  : in  Std_Logic_Vector(7 downto 0)); -- Byte to transmit
end entity;

architecture Behaviour of TxUnit is
  signal TBuff    : Std_Logic_Vector(7 downto 0); -- transmit buffer
  signal TReg     : Std_Logic_Vector(7 downto 0); -- transmit register
  signal TBufL    : Std_Logic;  -- Buffer loaded
  signal Load     : Std_Logic;  -- Load signal, Clk synchronised
  signal LoadAS   : Std_Logic;	-- Load signal Async started, Sync stopped

begin
  process(LoadA, Load)
  begin
     if load = '1' then
        loadAS <= '0';  -- Clear LoadAS
     elsif Rising_Edge(LoadA) then
        LoadAS <= '1';
     end if;
  end process;
  -- Synchronize Load on Clk
  SyncLoad : process(Clk, LoadAS)
  begin
     if Rising_Edge(Clk) then
        if LoadAS = '1' then
           Load <= '1';
        end if;
        if Load = '1' then
           Load <= '0';
        end if;
     end if;
  end process;
  Busy <= LoadAS or TBufL;

  -- Tx process
  TxProc : process(Clk, Reset, Enable, Load, DataI, TBuff, TReg, TBufL)
  variable BitPos : INTEGER range 0 to 10; -- Bit position in the frame
  begin
     if Reset = '1' then
        TBufL <= '0';
        BitPos := 0;
     elsif Rising_Edge(Clk) then        
        if LoadAS = '1' then
           TBuff <= DataI;
           TBufL <= '1';
        end if;
        if Enable = '1' then
           case BitPos is
              when 0 => -- idle or stop bit
                 TxD <= '1';
                 if TBufL = '1' then -- start transmit. next is start bit
                    TReg <= TBuff;
                    TBufL <= '0';
                    BitPos := 1;
                 end if;
              when 1 => -- Start bit
                 TxD <= '0';
                 BitPos := 2;
              when others =>
                 TxD <= TReg(BitPos-2); -- Serialisation of TReg
                 BitPos := BitPos + 1;                            
           end case;
           if BitPos = 10 then -- bit8. next is stop bit
              BitPos := 0;
           end if;
        end if;
     end if;
  end process;
end Behaviour;
