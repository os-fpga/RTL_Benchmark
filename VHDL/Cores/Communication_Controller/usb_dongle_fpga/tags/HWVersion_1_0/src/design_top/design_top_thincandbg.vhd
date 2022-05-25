------------------------------------------------------------------
-- Universal dongle board source code
-- 
-- Copyright (C) 2006 Artec Design <jyrit@artecdesign.ee>
-- 
-- This source code is free hardware; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 2.1 of the License, or (at your option) any later version.
-- 
-- This source code is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- Lesser General Public License for more details.
-- 
-- You should have received a copy of the GNU Lesser General Public
-- License along with this library; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-- 
-- 
-- The complete text of the GNU Lesser General Public License can be found in 
-- the file 'lesser.txt'.



-- Coding for seg_out(7:0)  
--
--                bit 0,A 
--                 ----------
--                |          |
--                |          |
--             5,F|          |  1,B
--                |    6,G   |
--                 ----------
--                |          |
--                |          |
--             4,E|          |  2,C
--                |    3,D   |
--                 ----------  
--                              # 7,H

-- Revision history
--
-- Version 1.01
-- 15 oct 2006	version code 86 01	jyrit
-- Added IO write to address 0x0088  with commands F1 and F4 to
-- enable switching dongle to 4Meg mode for external reads
-- Changed USB interface to address all 4 Meg on any mode jumper configuration
--
-- Version 1.02
-- 04 dec 2006 version code 86 02 jyrit
-- Added listen only mode for mode pin configuration "00" to enable post code
-- spy mode (does not respond to external reads).


library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity design_top is
  port (
	--system signals
	sys_clk    : in    std_logic;         --25 MHz clk
	resetn     : in    std_logic;     
	hdr		   : out    std_logic_vector(10 downto 0);
	--alt_clk    : out    std_logic;    --alternative clock from extention header
	mode       : in    std_logic_vector(1 downto 0);  --sel upper addr bits
    --lpc slave interf
    lad        : inout std_logic_vector(3 downto 0);
    lframe_n   : in    std_logic;
    lreset_n   : in    std_logic;
    lclk       : in    std_logic;
    --led system    
    seg_out    : out   std_logic_vector(7 downto 0);
    scn_seg    : out   std_logic_vector(3 downto 0);
    led_green  : out   std_logic;
    led_red    : out   std_logic;
    --flash interface
    fl_addr    : out   std_logic_vector(23 downto 0);
    fl_ce_n    : out   std_logic;       --chip select
    fl_oe_n    : out   std_logic;       --output enable for flash
    fl_we_n    : out   std_logic;       --write enable
    fl_data    : inout std_logic_vector(15 downto 0);
    fl_rp_n    : out   std_logic;       --reset signal
    fl_sts     : in    std_logic;        --status signal
    --USB parallel interface
    usb_rd_n   : inout  std_logic;  -- enables out data if low (next byte detected by edge / in usb chip)
    usb_wr     : inout  std_logic;  -- write performed on edge \ of signal
    usb_txe_n  : in   std_logic;  -- transmit enable (redy for new data if low)
    usb_rxf_n  : in   std_logic;  -- rx fifo has data if low
    usb_bd     : inout  std_logic_vector(7 downto 0) --bus data
    );
end design_top;



architecture rtl of design_top is

component led_sys   --toplevel for led system
  generic(
	msn_hib : std_logic_vector(7 downto 0);  --Most signif. of hi byte
	lsn_hib : std_logic_vector(7 downto 0);  --Least signif. of hi byte
 	msn_lob : std_logic_vector(7 downto 0);  --Most signif. of hi byte
	lsn_lob : std_logic_vector(7 downto 0)  --Least signif. of hi byte	
  );
  port (
    clk				: in std_logic;
    reset_n			: in std_logic;
	led_data_i		: in  std_logic_vector(15 downto 0);   --binary data in
    seg_out			: out std_logic_vector(7 downto 0); --one segment out
    sel_out			: out std_logic_vector(3 downto 0)  --segment scanner with one bit low
    );
end component;


component lpc_iow
  port (
    --system signals
    lreset_n   : in  std_logic;
    lclk       : in  std_logic;
	--LPC bus from host
    lad_i      : in  std_logic_vector(3 downto 0);
    lad_o      : out std_logic_vector(3 downto 0);
    lad_oe     : out std_logic;
    lframe_n   : in  std_logic;
	--memory interface
    lpc_addr   : out std_logic_vector(23 downto 0); --shared address
    lpc_wr     : out std_logic;         --shared write not read
    lpc_data_i : in  std_logic_vector(7 downto 0);
    lpc_data_o : out std_logic_vector(7 downto 0);  
    lpc_val    : out std_logic;
    lpc_ack    : in  std_logic
    );
end component;


component flash_if
  port (
    clk       : in  std_logic;
    reset_n   : in  std_logic;
    --flash Bus
    fl_addr   : out std_logic_vector(23 downto 0);
    fl_ce_n      : out std_logic;       --chip select
    fl_oe_n      : out std_logic;    --output enable for flash
    fl_we_n      : out std_logic;       --write enable
    fl_data      : inout std_logic_vector(15 downto 0);
    fl_rp_n      : out std_logic;       --reset signal
    fl_byte_n    : out std_logic;     --hold in byte mode
    fl_sts       : in std_logic;        --status signal
    -- mem Bus
    mem_addr  : in std_logic_vector(23 downto 0);
    mem_do    : out std_logic_vector(15 downto 0);
    mem_di    : in  std_logic_vector(15 downto 0);
     
    mem_wr    : in  std_logic;  --write not read signal
    mem_val   : in  std_logic;
    mem_ack   : out std_logic
    ); 
end component;


component usb2mem
  port (
    clk25     : in  std_logic;
    reset_n   : in  std_logic;
    -- mem Bus
    mem_addr  : out std_logic_vector(23 downto 0);
    mem_do    : out std_logic_vector(15 downto 0);
    mem_di    : in std_logic_vector(15 downto 0);
    mem_wr    : out std_logic;
    mem_val   : out std_logic;
    mem_ack   : in  std_logic;
    mem_cmd   : out std_logic;
    -- USB port
    usb_rd_n   : out  std_logic;  -- enables out data if low (next byte detected by edge / in usb chip)
    usb_wr     : out  std_logic;  -- write performed on edge \ of signal
    usb_txe_n  : in   std_logic;  -- tx fifo empty (redy for new data if low)
    usb_rxf_n  : in   std_logic;  -- rx fifo empty (data redy if low)
    usb_bd     : inout  std_logic_vector(7 downto 0) --bus data
    ); 
end component;



--LED signals
signal data_to_disp : std_logic_vector(15 downto 0);
--END LED SIGNALS

--lpc signals
signal    lad_i      : std_logic_vector(3 downto 0);
signal    lad_o      : std_logic_vector(3 downto 0);
signal    lad_oe     : std_logic;

signal    lpc_debug  : std_logic_vector(31 downto 0);
signal    lpc_addr   : std_logic_vector(23 downto 0); --shared address
signal 	  lpc_data_o : std_logic_vector(7 downto 0); 
signal 	  lpc_data_i : std_logic_vector(7 downto 0); 
signal    lpc_wr     : std_logic;        --shared write not read
signal    lpc_ack    : std_logic;
signal    lpc_val    : std_logic;


signal    c25_lpc_val  : std_logic;
signal    c25_lpc_wr     : std_logic;        --shared write not read
signal    c33_lpc_wr     : std_logic;        --for led debug data latching

--End lpc signals

--Flash signals
signal    mem_addr  : std_logic_vector(23 downto 0);
signal    mem_do    : std_logic_vector(15 downto 0);
signal    mem_di    : std_logic_vector(15 downto 0);
signal    mem_wr    : std_logic;  --write not read signal
signal    mem_val   : std_logic;
signal    mem_ack   : std_logic;

signal    c33_mem_ack   : std_logic;  --sync signal



signal    fl_ce_n_w : std_logic;       --chip select
signal    fl_oe_n_w : std_logic;    --output enable for flash

--END flash signals

--USB signals
signal    umem_addr  : std_logic_vector(23 downto 0);
signal    umem_do    : std_logic_vector(15 downto 0);
signal    umem_wr    : std_logic;
signal    umem_val   : std_logic;
signal    umem_ack   : std_logic;
signal    umem_cmd   : std_logic;
signal    enable_4meg: std_logic;
--END USB signals

begin



--LED SUBSYSTEM START

data_to_disp <= x"86"&lpc_debug(7 downto 0);	--x"C0DE"; -- ASSIGN data to be displayed (should be regitered)

--########################################--
	  		--VERSION CONSTATNS
--########################################--
led_red <= enable_4meg;

LEDS: led_sys   --toplevel for led system
  generic map(
	msn_hib => "01111111",--8  --Most signif. of hi byte  
	lsn_hib => "01111101",--6   --Least signif. of hi byte
 	msn_lob => "10111111",--0  --Most signif. of hi byte   This is version code
	lsn_lob => "01011011" --2   --Least signif. of hi byte	This is version code
  )
  port map(
    clk				=> sys_clk , -- in std_logic;
    reset_n			=> resetn, -- in std_logic;
	led_data_i		=> data_to_disp, -- in  std_logic_vector(15 downto 0);   --binary data in
    seg_out			=> seg_out, -- out std_logic_vector(7 downto 0); --one segment out
    sel_out			=> scn_seg -- out std_logic_vector(3 downto 0)  --segment scanner with one bit low
    );

--LED SUBSYSTEM END


--MAIN DATAPATH CONNECTIONS
--LPC bus logic
lad_i <= lad;
lad <=	lad_o when lad_oe='1' and mode/="00" else --mode "00" is post code spy mode 
		(others=>'Z');

--END LPC bus logic

LPCBUS : lpc_iow
  port map(
    --system signals
    lreset_n   => lreset_n, -- in  std_logic;
    lclk       => lclk, -- in  std_logic;
	--LPC bus from host
    lad_i      => lad_i, -- in  std_logic_vector(3 downto 0);
    lad_o      => lad_o, -- out std_logic_vector(3 downto 0);
    lad_oe     => lad_oe, -- out std_logic;
    lframe_n   => lframe_n, -- in  std_logic;
	--memory interface
    lpc_addr   => lpc_addr, -- out std_logic_vector(23 downto 0); --shared address
    lpc_wr     => lpc_wr, -- out std_logic;         --shared write not read
    lpc_data_i => lpc_data_i, -- in  std_logic_vector(7 downto 0);
    lpc_data_o => lpc_data_o, -- out std_logic_vector(7 downto 0);  
    lpc_val    => lpc_val, -- out std_logic;
    lpc_ack    => lpc_ack -- in  std_logic
    );


--memory data bus logic
	mem_addr <= mode&"11"&lpc_addr(19 downto 0) when c25_lpc_val='1' and enable_4meg='0' else  --use mode bist
				mode&lpc_addr(21 downto 0) when c25_lpc_val='1' and enable_4meg='1' else  --use mode bist
				mode&umem_addr(21 downto 0) when umem_val='1' else  --use mode bist
				(others=>'Z');
				
	mem_di <=	(others=>'Z') when c25_lpc_val='1' else
				umem_do when umem_val='1' else
				(others=>'Z'); 	
				
			
	mem_wr <= c25_lpc_wr when c25_lpc_val='1' and c25_lpc_wr='0' else  --pass read olny
			  umem_wr when umem_val='1' else
			  '0';
			
	mem_val <= c25_lpc_val or umem_val;
	
	

	umem_ack <= mem_ack when umem_val='1' else
				'0';
	
	
	lpc_data_i <= mem_do(7 downto 0) when lpc_addr(0)='0' else
				  mem_do(15 downto 8);
				
	lpc_ack <= c33_mem_ack when lpc_val='1' and lpc_wr='0' else
			   '1' when lpc_val='1' and lpc_wr='1' else
			   '0';
			


	SYNC1: process (lclk, lreset_n)  --c33
	begin  
 		if lclk'event and lclk = '1' then    -- rising clock edge
			c33_mem_ack <= mem_ack;
			
  		end if;
	end process SYNC1;
	
	
	SYNC2: process (sys_clk, resetn) --c25
	begin 
 		if sys_clk'event and sys_clk = '1' then    -- rising clock edge
			c25_lpc_val <= lpc_val;
			c25_lpc_wr <= lpc_wr;
  		end if;
	end process SYNC2;	

				

	LATCHled: process (lclk,lreset_n)  --c33
	begin  
		if lreset_n='0' then
			lpc_debug(7 downto 0)<=(others=>'0');
			enable_4meg <='0';
			c33_lpc_wr <='0';
 		elsif lclk'event and lclk = '1' then    -- rising clock edge
			c33_lpc_wr <= lpc_wr;			--just for debug delay
			if c33_lpc_wr='0' and  lpc_wr='1' then
				lpc_debug(7 downto 0)<= lpc_data_o;
				if lpc_addr(7 downto 0)=x"88" and lpc_data_o=x"4F" then   --Flash 4 Mega enable (LSN is first MSN is second)
					enable_4meg <='1';
				elsif lpc_addr(7 downto 0)=x"88" and lpc_data_o=x"1F" then --Flash 1 Mega enalbe
					enable_4meg <='0';
				end if;
			end if;
  		end if;
	end process LATCHled;
	
	


	
				
--END memory data bus logic
fl_ce_n<= fl_ce_n_w;
fl_oe_n<= fl_oe_n_w;

FLASH : flash_if
  port map(
    clk       => sys_clk, -- in  std_logic;
    reset_n   => resetn, -- in  std_logic;
    --flash Bus
    fl_addr   => fl_addr, -- out std_logic_vector(23 downto 0);
    fl_ce_n      => fl_ce_n_w, -- out std_logic;       --chip select
    fl_oe_n      => fl_oe_n_w, -- buffer std_logic;    --output enable for flash
    fl_we_n      => fl_we_n, -- out std_logic;       --write enable
    fl_data      => fl_data, -- inout std_logic_vector(15 downto 0);
    fl_rp_n      => fl_rp_n, -- out std_logic;       --reset signal
    --fl_byte_n    => fl_byte_n, -- out std_logic;     --hold in byte mode
    fl_sts       => fl_sts, -- in std_logic;        --status signal
    -- mem Bus
    mem_addr  => mem_addr, -- in std_logic_vector(23 downto 0);
    mem_do    => mem_do, -- out std_logic_vector(15 downto 0);
    mem_di    => mem_di, -- in  std_logic_vector(15 downto 0);
     
    mem_wr    => mem_wr, -- in  std_logic;  --write not read signal
    mem_val   => mem_val, -- in  std_logic;
    mem_ack   => mem_ack  -- out std_logic
    ); 

--hdr(7 downto 0) <= umem_do(7 downto 0) when  umem_ack='0' and umem_wr='1' else
--				   umem_do(15 downto 8) when  umem_ack='1' and umem_wr='1' else
--				   mem_do(7 downto 0) when  umem_wr='0' else
--				   mem_do(15 downto 8);
--hdr(8)<= umem_wr;
--hdr(9)<= umem_val;
--hdr(10)<= umem_ack;
--    usb_rd_n   : out  std_logic;  -- enables out data if low (next byte detected by edge / in usb chip)
--    usb_wr     : out  std_logic;  -- write performed on edge \ of signal
--    usb_txe_n  : in   std_logic;  -- transmit enable (redy for new data if low)
--    usb_rxf_n  : in   std_logic;  -- rx fifo has data if low

hdr(3 downto 0) <= lad_o when lad_oe='1' else
				   lad;
hdr(4)<= lframe_n;
hdr(5)<= lreset_n;
hdr(6)<= lclk;
hdr(7)<= lpc_ack;

--hdr(7 downto 0) <= lpc_data_o(7 downto 0);

hdr(8)<= lpc_val;
hdr(9)<= '1' when lpc_wr='1' and lpc_addr(7 downto 0)=x"88" else
		 '0';
hdr(10)<= resetn;

 
USB: usb2mem
  port map(
    clk25     => sys_clk, -- in  std_logic;
    reset_n   => resetn, -- in  std_logic;
    -- mem Bus
    mem_addr  => umem_addr, -- out std_logic_vector(23 downto 0);
    mem_do    => umem_do, -- out std_logic_vector(15 downto 0);
    mem_di    => mem_do, -- in std_logic_vector(15 downto 0);   --from flash
    mem_wr    => umem_wr, -- out std_logic;
    mem_val   => umem_val, -- out std_logic;
    mem_ack   => umem_ack, -- in  std_logic;  --from flash
    mem_cmd   => umem_cmd, -- out std_logic;
    -- USB port
    usb_rd_n   => usb_rd_n, -- out  std_logic;  -- enables out data if low (next byte detected by edge / in usb chip)
    usb_wr     => usb_wr, -- out  std_logic;  -- write performed on edge \ of signal
    usb_txe_n  => usb_txe_n, -- in   std_logic;  -- tx fifo empty (redy for new data if low)
    usb_rxf_n  => usb_rxf_n, -- in   std_logic;  -- rx fifo empty (data redy if low)
    usb_bd     => usb_bd -- inout  std_logic_vector(7 downto 0) --bus data
    ); 


--END MAIN DATAPATH CONNECTIONS

end rtl;



