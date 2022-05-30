-------------------------------------------------------------------------------
-- Title      : UART
-- Project    : UART
-------------------------------------------------------------------------------
-- File        : Uart.vhd
-- Author      : Philippe CARTON 
--               (pc@microsystemes.com / philippe.carton2@libertysurf.fr)
-- Organization: Microsystemes
-- Created     : 15/12/2001
-- Last update : 28/12/2001
-- Platform    : Foundation 3.1i
-- Simulators  : Foundation logic simulator
-- Synthesizers: Foundation Synopsys
-- Targets     : Xilinx Spartan
-- Dependency  : IEEE std_logic_1164, Rxunit.vhd, Txunit.vhd, utils.vhd
-------------------------------------------------------------------------------
-- Description: Uart (Universal Asynchronous Receiver Transmitter) for SoC.
--    Wishbone compatable.
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

entity UART is
  generic(BRDIVISOR: INTEGER range 0 to 65535 := 130); -- Baud rate divisor
  port (
-- Wishbone signals
     WB_CLK_I : in  Std_Logic;  -- clock
     WB_RST_I : in  Std_Logic;  -- Reset input
     WB_ADR_I : in  Std_Logic_Vector(1 downto 0); -- Adress bus          
     WB_DAT_I : in  Std_Logic_Vector(7 downto 0); -- DataIn Bus
     WB_DAT_O : out Std_Logic_Vector(7 downto 0); -- DataOut Bus
     WB_WE_I  : in  Std_Logic;  -- Write Enable
     WB_STB_I : in  Std_Logic;  -- Strobe
     WB_ACK_O : out Std_Logic;	-- Acknowledge
-- process signals     
     IntTx_O  : out Std_Logic;  -- Transmit interrupt: indicate waiting for Byte
     IntRx_O  : out Std_Logic;  -- Receive interrupt: indicate Byte received
     BR_Clk_I : in  Std_Logic;  -- Clock used for Transmit/Receive
     TxD_PAD_O: out Std_Logic;  -- Tx RS232 Line
     RxD_PAD_I: in  Std_Logic);  -- Rx RS232 Line     
end entity;

-- Architecture for UART for synthesis
architecture Behaviour of UART is

  component Counter is
  generic(COUNT: INTEGER range 0 to 65535); -- Count revolution
  port (
     Clk      : in  Std_Logic;  -- Clock
     Reset    : in  Std_Logic;  -- Reset input
     CE       : in  Std_Logic;  -- Chip Enable
     O        : out Std_Logic); -- Output  
  end component;

  component RxUnit is
  port (
     Clk    : in  Std_Logic;  -- system clock signal
     Reset  : in  Std_Logic;  -- Reset input
     Enable : in  Std_Logic;  -- Enable input
     ReadA  : in  Std_logic;  -- Async Read Received Byte
     RxD    : in  Std_Logic;  -- RS-232 data input
     RxAv   : out Std_Logic;  -- Byte available
     DataO  : out Std_Logic_Vector(7 downto 0)); -- Byte received
  end component;

  component TxUnit is
  port (
     Clk    : in  Std_Logic;  -- Clock signal
     Reset  : in  Std_Logic;  -- Reset input
     Enable : in  Std_Logic;  -- Enable input
     LoadA  : in  Std_Logic;  -- Asynchronous Load
     TxD    : out Std_Logic;  -- RS-232 data output
     Busy   : out Std_Logic;  -- Tx Busy
     DataI  : in  Std_Logic_Vector(7 downto 0)); -- Byte to transmit
  end component;

  signal RxData : Std_Logic_Vector(7 downto 0); -- Last Byte received
  signal TxData : Std_Logic_Vector(7 downto 0); -- Last bytes transmitted
  signal SReg   : Std_Logic_Vector(7 downto 0); -- Status register
  signal EnabRx : Std_Logic;  -- Enable RX unit
  signal EnabTx : Std_Logic;  -- Enable TX unit
  signal RxAv   : Std_Logic;  -- Data Received
  signal TxBusy : Std_Logic;  -- Transmiter Busy
  signal ReadA  : Std_Logic;  -- Async Read receive buffer
  signal LoadA  : Std_Logic;  -- Async Load transmit buffer
  signal Sig0   : Std_Logic;  -- gnd signal
  signal Sig1   : Std_Logic;  -- vcc signal  
 
  begin
  sig0 <= '0';
  sig1 <= '1';
  Uart_Rxrate : Counter -- Baud Rate adjust
     generic map (COUNT => BRDIVISOR) 
     port map (BR_CLK_I, sig0, sig1, EnabRx); 
  Uart_Txrate : Counter -- 4 Divider for Tx
     generic map (COUNT => 4)  
     port map (BR_CLK_I, Sig0, EnabRx, EnabTx);
  Uart_TxUnit : TxUnit port map (BR_CLK_I, WB_RST_I, EnabTX, LoadA, TxD_PAD_O, TxBusy, TxData);
  Uart_RxUnit : RxUnit port map (BR_CLK_I, WB_RST_I, EnabRX, ReadA, RxD_PAD_I, RxAv, RxData);
  IntTx_O <= not TxBusy;
  IntRx_O <= RxAv;
  SReg(0) <= not TxBusy;
  SReg(1) <= RxAv;
  
  -- Implements WishBone data exchange.
  -- Clocked on rising edge. Synchronous Reset RST_I
  WBctrl : process(WB_CLK_I, WB_RST_I, WB_STB_I, WB_WE_I, WB_ADR_I)
  variable StatM : Std_Logic_Vector(4 downto 0);
  begin
     if Rising_Edge(WB_CLK_I) then
        if (WB_RST_I = '1') then
  	   ReadA <= '0';
  	   LoadA <= '0';
  	else
	   if (WB_STB_I = '1' and WB_WE_I = '1' and WB_ADR_I = "00") then -- Write Byte to Tx
              TxData <= WB_DAT_I;
	      LoadA <= '1';   -- Load signal        
           else LoadA <= '0';	   
           end if;
	   if (WB_STB_I = '1' and WB_WE_I = '0' and WB_ADR_I = "00") then -- Read Byte from Rx
	      ReadA <= '1';   -- Read signal
           else ReadA <= '0';	   
           end if;           
        end if;	
     end if;
  end process;   
  WB_ACK_O <= WB_STB_I;
  WB_DAT_O <=
     RxData when WB_ADR_I = "00" else  -- Read Byte from Rx
     SReg when WB_ADR_I = "01" else    -- Read Status Reg
     X"00";
end Behaviour;
