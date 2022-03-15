
-- Copyright (C) 2010 David E. Roberts <davee dot roberts at fsmail dot net>

-- This file is part of AGCNORM (Apollo Guidance Computer NOR eMulator).
--
-- AGCNORM is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- AGCNORM is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with AGCNORM. If not, see <http://www.gnu.org/licenses/>.

-- Functional description.
-- =======================
--
-- This file implements the FIXED and ERASABLE memory sub-systems of the
-- Block II Apollo Guidance Computer (AGC). The logic is implemented as a VHDL description
-- for a Xilinx Spartan 3E device (XC3S500E-FG320-4) using release 11.1 of the ISE WebPACK tools.
-- Use is made of Block RAM (BRAM) and FLASH rather than ferrite cores!

-- Modification History.
-- =====================
--
-- Version : 
--    Date : 
--  Author : 
--  Reason : 
--
-- Version : 2.01
--    Date : 26th September 2010
--  Author : David E. Roberts
--  Reason : Move Strata Flash (Fixed core rope) into here.
--         : Move generation of T_SYSRESET into here.
--         : Start to add initial load of ERASABLE memory from Strata Flash on FPGA initialise.
--
-- Version : 2.00
--    Date : 20th June 2010
--  Author : David E. Roberts
--  Reason : Start to convert to Spartan 3E Development board. Remove Fixed memory.
--
-- Version : 1.02
--    Date : 10th April 2010
--  Author : David E. Roberts
--  Reason : Add SYSCLOCK and 'tweak' AGC fixed memory logic. AGC erasable memory is still in error.
--           BACKOUT CHANGE. Still some problems with the working of block RAM! Removing it didn't seem 
--           to fix the problem, so added SYSCLOCK back in... And take it out again! I have re-read
--           the BRAM documentation, and I think what I have done previously (using EREAD and FREAD
--           as the clocks) is correct.
--
-- Version : 1.01
--    Date : 29th December 2009
--  Author : David E. Roberts
--  Reason : Change q_ecadr so it latches on the leading edge of EREAD rather than on
--           EREAD being high. This attempts to fix a warning from ISE WebPACK :-
--           "WARNING:Xst:737 - Found 11-bit latch for signal <Q_ECADR>. 
--           Latches may be generated from incomplete case or if statements. 
--           We do not recommend the use of latches in FPGA/CPLD designs, as they may lead to timing problems."
--
-- Version : 1.00
--    Date : 27th December 2009
--  Author : David E. Roberts
--  Reason : First creation

-- Known issues.
-- =============
--
-- None.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.conv_std_logic_vector;

library UNISIM;

use work.AGCPACK.all;

entity AGC_MEMORY is
  port(
      ECADR    : in  AGCBITARRAY( 11 downto 1 ); -- Erasable address.
      SAXX     : out AGCBITARRAY( 15 downto 0 ); -- Sense Amplifiers (data to AGC).
      GEMXX    : in  AGCBITARRAY( 15 downto 0 ); -- 'G' register data from AGC.
      EREAD    : in  AGCBIT;                     -- Erasable Read  signal.
      EWRITE   : in  AGCBIT;                     -- Erasable Write signal.
      ESTART   : in  AGCBIT;                     -- Erasable cycle start signal.
      FCADR    : in  AGCBITARRAY( 16 downto 1 ); -- Fixed address.
      FREAD    : in  AGCBIT;                     -- Fixed read signal.
      SF_A     : out AGCBITARRAY( 24 downto 0 ); -- Strata Flash Address.
      SF_D     : in  AGCBITARRAY( 15 downto 0 ); -- Strata Flash Data.
      SF_BYTE  : out AGCBIT;                     -- Strata Flash Byte Select.
      SF_CE    : out AGCBIT;                     -- Strata Flash Chip Enable.
      SF_OE    : out AGCBIT;                     -- Strata Flash Output Enable.
      SF_WE    : out AGCBIT;                     -- Strata Flash Write Enable.
      SW0      : in  AGCBIT;                     -- Fixed Core Rope Select (least significant bit).
      SW1      : in  AGCBIT;                     -- Fixed Core Rope Select (most significant bit).
      SYSCLOCK : in  AGCBIT;                     -- AGC system clock.
      SYSRESET : out AGCBIT                      -- AGC system reset.
  );
end AGC_MEMORY;

architecture Rtl of AGC_MEMORY is

  -- ************************************
  -- ***                              ***
  -- ***  Erasable memory prototype.  ***
  -- ***                              ***
  -- ************************************
  
  component agc_erasable
	  port (
	    clka  : in  std_logic;
	    dina  : in  std_logic_VECTOR( 15 downto 0 );
	    addra : in  std_logic_VECTOR( 10 downto 0 );
	    wea   : in  std_logic_VECTOR(  0 downto 0 );
	    clkb  : in  std_logic;
	    addrb : in  std_logic_VECTOR( 10 downto 0 );
	    doutb : out std_logic_VECTOR( 15 downto 0 )
    );
  end component;

  -- ************************************
  -- ***                              ***
  -- ***  Local signal declarations.  ***
  -- ***                              ***
  -- ************************************

  signal WEOK : AGCBITARRAY( 0 downto 0 ) := "0";
  
  signal Q_ECADR : AGCBITARRAY( 11 downto 1 ) := "00000000000"; -- Latched erasable address.

  signal F_SAXX : AGCBITARRAY( 15 downto 0 ); -- Fixed    memory sense amplifiers.
  signal E_SAXX : AGCBITARRAY( 15 downto 0 ); -- Erasable memory sense amplifiers.
  
  signal T_SYSRESET : AGCBIT := '1';
  
  signal XIFREAD  : AGCBIT;
  signal XIEWRITE : AGCBIT;
  
  signal IFREAD  : AGCBIT;
  signal IEWRITE : AGCBIT;
  signal IEREAD  : AGCBIT;
  signal IWEOK   : AGCBITARRAY( 0 downto 0 );
  
  signal IQECADR  : AGCBITARRAY( 11 downto 1 );
  signal ICOUNTER : AGCBITARRAY( 11 downto 1 );
  
  signal IGEMXX   : AGCBITARRAY( 15 downto 0 );
  
begin

  -- Latch the Erasable address on the erasable read cycle.
  -- 
  -- This was found in R-416 "THE APOLLO GUIDANCE COMPUTER" by Ramon L. Alonso and 
  -- Albert L. Hopkins dated August 1963 (copy #213) on page 8 of this publication.
  --
  -- File: 1717.pdf
  --
  -- "The erasable memory is of the coincident current, ferrite
  -- core type,, operated with a very conservative cycle time [4].
  -- Figure 3 shows the size of an early prototype ferrite stack."
  -- 
  -- "Selection is accomplished by two banks of steering circuits.
  -- Twelve steering circuits operate on an eight by four
  -- coincidence principle to select one of 32 drive lines, as shown
  -- in Figure 4, The steering circuits are of some interest because
  -- the cores in them provide a memory for the address of the register
  -- after it is read out."

  process ( ECADR, EREAD ) 
  begin
  
    -- If the erasable memory is being 'read' then latch the erasable address
    -- for use by the erasable write cycle (if present).
    
    if rising_edge( EREAD ) then
    
      Q_ECADR <= ECADR;
      
    end if; -- rising_edge( EREAD )
    
  end process; -- ECADR and EREAD
  
  -- ************************************************************
  -- ***                                                      ***
  -- ***  Identify if the erasable write cycle is allowable.  ***
  -- ***                                                      ***
  -- ************************************************************

  process ( ESTART, EREAD )
  begin
  
    -- Look for a rising edge on SETEK to signify the start of an erasable read cycle.
    -- Use this to clear the erasable write cycle. Only enable the erasable write cycle
    -- when the erasable memory is actually read.
    --
    -- The 'level' needs to have a higher priority than the 'rising_edge' in the "pecking 
    -- order" to ensure compatability with the logic cells within the FPGA.
    
    if EREAD = '1' then
    
      -- Found a real erasable read cycle - so an erasable write is now allowed!
      
      WEOK(0) <= '1';
      
    elsif rising_edge( ESTART ) then
    
      -- Found a start of erasable read cycle.
      
      WEOK(0) <= '0'; -- No erasable write cycle yet until we see a real read!
      
    end if; -- ESTART and EREAD
  
  end process; -- ESTART and EREAD
  
  -- ********************************************************************
  -- ***                                                              ***
  -- ***  Derive internal signals for erasable memory instantiation.  ***
  -- ***                                                              ***
  -- ********************************************************************

  IEWRITE  <= XIEWRITE when T_SYSRESET = '1' else
                EWRITE;
  
  IGEMXX   <= SF_D when T_SYSRESET = '1' else
              GEMXX;
  
  IQECADR  <= ICOUNTER when T_SYSRESET = '1' else
              Q_ECADR;
  
  IWEOK(0) <= '1' when  T_SYSRESET = '1' else
              WEOK(0);
             
  IEREAD   <= '0' when T_SYSRESET = '1' else
              EREAD;
             
  -- ****************************************
  -- ***                                  ***
  -- ***  Erasable memory instantiation.  ***
  -- ***                                  ***
  -- ****************************************
  
  ERASABLE : agc_erasable port map (
			         clka  => IEWRITE,  -- ERASABLE WRITE (write clock)
			         dina  => IGEMXX,   -- ERASABLE WRITE (write data)
			         addra => IQECADR,  -- ERASABLE WRITE (write address)
			         wea   => IWEOK,    -- ERASABLE WRITE (write enable)
			         clkb  => IEREAD,   -- ERASABLE READ  (read  clock)
			         addrb => ECADR,    -- ERASABLE READ  (read  address)
			         doutb => E_SAXX    -- ERASABLE READ  (read  data)
             );
  
  -- *************************************
  -- ***                               ***
  -- ***  Fixed memory instantiation.  ***
  -- ***                               ***
  -- *************************************
  
  SF_BYTE <= '1'; -- 16-bit Accesses to Strata FLASH.
  
  SF_WE   <= '1'; -- Only READ from the Strata FLASH.
  
  IFREAD  <= XIFREAD when T_SYSRESET = '1' else
               FREAD;
  
  SF_CE   <= not IFREAD;
  SF_OE   <= not IFREAD;
  
  -- Form Strata Flash Address.
  
  SF_A( 24 ) <= '0';   -- Reserved for more core ropes!
  SF_A( 23 ) <= '0';   -- Reserved for more core ropes!
  SF_A( 22 ) <= '0';   -- Reserved for more core ropes!
  SF_A( 21 ) <= '0';   -- Reserved for more core ropes!
  SF_A( 20 ) <= '0';   -- Reserved for more core ropes!
  SF_A( 19 ) <= '0';   -- Reserved for more core ropes!
  
  SF_A( 18 ) <= SW1;   -- Select different 'core ropes' from the Strata Flash.
  SF_A( 17 ) <= SW0;   -- Select different 'core ropes' from the Strata Flash.
  
  SF_A( 16 downto 12 ) <= "11111" when T_SYSRESET = '1' else
                          FCADR( 16 downto 12 );
                          
  SF_A( 11 downto  1 ) <= ICOUNTER when T_SYSRESET = '1' else
                          FCADR( 11 downto  1 );
                          
  SF_A(  0 ) <= '0';   -- Unused in 16-bit access mode.
  
  F_SAXX( 15 ) <= SF_D( 15 );
  F_SAXX( 14 ) <= SF_D( 14 );
  F_SAXX( 13 ) <= SF_D( 13 );
  F_SAXX( 12 ) <= SF_D( 12 );
  F_SAXX( 11 ) <= SF_D( 11 );
  F_SAXX( 10 ) <= SF_D( 10 );
  F_SAXX(  9 ) <= SF_D(  9 );
  F_SAXX(  8 ) <= SF_D(  8 );
  F_SAXX(  7 ) <= SF_D(  7 );
  F_SAXX(  6 ) <= SF_D(  6 );
  F_SAXX(  5 ) <= SF_D(  5 );
  F_SAXX(  4 ) <= SF_D(  4 );
  F_SAXX(  3 ) <= SF_D(  3 );
  F_SAXX(  2 ) <= SF_D(  2 );
  F_SAXX(  1 ) <= SF_D(  1 );
  F_SAXX(  0 ) <= SF_D(  0 );  
  
  -- **************************************************************
  -- ***                                                        ***
  -- ***  Route the correct sense amplifiers to the AGC logic.  ***
  -- ***                                                        ***
  -- **************************************************************
  
  SAXX <= F_SAXX when FREAD = '1' else -- Fixed    sense amplifiers
          E_SAXX when EREAD = '1' else -- Erasable sense amplifiers
          "0000000000000000";          -- Default

  -- ***********************************************************************
  -- ***                                                                 ***
  -- *** Load the initial ERASABLE memory from Strata Flash at startup.  ***
  -- ***                                                                 ***
  -- ***********************************************************************

  startup: process( SYSCLOCK )  
  
    type t_state is ( RESET1, READ1, WRITE1, READ2, TEST1, DONE1 );
  
    variable state : t_state := RESET1;
  
    variable counter : integer range 0 to 2047;
 
  begin
  
    if rising_edge( SYSCLOCK ) then
    
      case state is
    
        when RESET1 =>
          counter  := 0;
          XIFREAD  <= '0';
          XIEWRITE <= '0';
          state    := READ1;
        
        when READ1 =>
          XIFREAD  <= '1';
          XIEWRITE <= '0';
          state    := WRITE1;
      
        when WRITE1 =>
          XIFREAD   <= '1';
          XIEWRITE  <= '1';
          state     := READ2;
      
        when READ2 =>
          XIFREAD  <= '1';
          XIEWRITE <= '0';
          state    := TEST1;
      
        when TEST1 =>
          XIFREAD  <= '0';
          XIEWRITE <= '0';
          if counter = 2047 then
            state := DONE1;
          else
            counter := counter + 1;
            state   := READ1;
          end if; -- counter = 2047
        
        when DONE1 => 
          T_SYSRESET <= '0'; -- No more reset.
          XIFREAD    <= '0'; -- Not strictly important.
          XIEWRITE   <= '0'; -- Not strictly important.
          state      := DONE1;

      end case; -- state
  
    end if; -- SYSCLOCK
    
    ICOUNTER <= conv_std_logic_vector( counter, 11 );
    
  end process startup;
  
  -- *********************************************
  -- ***                                       ***
  -- ***  Send out the AGC system reset flag.  ***
  -- ***                                       ***
  -- *********************************************
  
  SYSRESET <= T_SYSRESET;
  
end Rtl;

-- **********************
-- ***                ***
-- ***  END OF FILE.  ***
-- ***                ***
-- **********************
