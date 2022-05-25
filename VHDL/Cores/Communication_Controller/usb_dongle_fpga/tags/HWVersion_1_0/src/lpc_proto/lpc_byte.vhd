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


library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;


entity lpc_iow is
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
end lpc_iow;

architecture rtl of lpc_iow is
type state is (RESETs,STARTs,ADDRs,TARs,SYNCs,DATAs,LOCAL_TARs);  -- simple LCP states
signal CS : state;
signal r_lad   : std_logic_vector(3 downto 0);
signal r_addr  : std_logic_vector(31 downto 0);  --should consider saving max
                                                --adress 23 bits on flash
signal r_data  : std_logic_vector(7 downto 0);
signal r_cnt   : std_logic_vector(2 downto 0);
signal ext_sum : std_logic_vector(2 downto 0);
signal mem_nio : std_logic;             -- memory not io cycle
signal data_valid : std_logic;
begin  -- rtl

  
--Pass the whole LPC address to the system
lpc_addr <= r_addr(23 downto 0);
lpc_data_o<= r_data;


--this result is used in LPC process 
ext_sum <= r_cnt + 1;
  
-- purpose: LPC IO write handler
-- type   : sequential
-- inputs : lclk, lreset_n
-- outputs: 
LPC: process (lclk, lreset_n)
begin  -- process LPC
  if lreset_n = '0' then                -- asynchronous reset (active low)
    CS<= RESETs;
    lad_oe<='0';
    data_valid <='1';
    lad_o <="0000";
    lpc_val <='0';
	 r_addr <= (others=>'0');
   elsif lclk'event and lclk = '1' then  -- rising clock edge
    case CS is
      when RESETs => ----------------------------------------------------------
        lpc_wr <='0';             
        lpc_val <='0';
        if lframe_n='0' then
          CS <= STARTs;
          r_lad <= lad_i;
        else
          CS <= RESETs;
        end if;
      when STARTs => ----------------------------------------------------------
        if lframe_n = '0' then
          r_lad <= lad_i;
          CS <= STARTs;
        elsif r_lad="0000" then
          --must identify CYCTYPE
          if lad_i(3 downto 1)="001" then --IO WRITE WILL HAPPEN
            --next 4 states must be address states
            CS<=ADDRs;
            mem_nio <= '0';
            r_cnt <= "000";
          elsif lad_i(3 downto 1)="010" then
            CS<=ADDRs;
            mem_nio <= '1';
            r_cnt <= "000";           
          else
            CS<= RESETs;
          end if;
        end if;
      when ADDRs => -----------------------------------------------------------
       case mem_nio is
         when '0' =>                   --IO write cycle
          if r_cnt ="011" then
             if r_addr(11 downto 0)=x"008" and lad_i(3 downto 2)="00" then
              r_addr<= r_addr(27 downto 0)&lad_i;
              r_cnt <= "000";
              CS<=DATAs;
            elsif r_addr(11 downto 0)=x"008" and lad_i(3 downto 0)=x"8" then  --for debug switch
              r_addr<= r_addr(27 downto 0)&lad_i;
              r_cnt <= "000";
              CS<=DATAs;
            else
              --not for this device
               CS<=RESETs;
            end if;
          else
            r_addr<= r_addr(27 downto 0)&lad_i;
            r_cnt<=ext_sum;
            CS<=ADDRs;
          end if;
        when '1' =>                    --Memory read cycle
          if r_cnt ="111" then
              r_addr<= r_addr(27 downto 0)&lad_i;
              r_cnt <= "000";
              lpc_wr <='0';             --memory read mus accure
              lpc_val <='1';
              data_valid <='0';
              CS<=TARs;
          else
            r_addr<= r_addr(27 downto 0)&lad_i;
            r_cnt<=ext_sum;
            CS<=ADDRs;
          end if;
         when others => null;
        end case;  
      when DATAs => -----------------------------------------------------------
       case mem_nio is           
        when '0' =>                   --IO write cycle              
          if r_cnt ="001" then
            r_data <= r_data(3 downto 0)&lad_i;
            r_cnt <= "000";
            lpc_wr <='1';             --IO write must accure
            lpc_val <='1';
            CS <= TARs;
          else
            r_data <= r_data(3 downto 0)&lad_i;
            r_cnt<=ext_sum;
            CS <= DATAs;
          end if;
        when '1' =>                    --Memory read cycle
          if r_cnt ="001" then
            lad_o <= r_data(7 downto 4);
            r_cnt <= "000";
            CS <= LOCAL_TARs;
          else
            lad_o <= r_data(3 downto 0);
            r_cnt<=ext_sum;
            CS <= DATAs;
          end if;
        when others => null;          
       end case;                         
      when TARs => ------------------------------------------------------------
          if mem_nio = '1' and lpc_ack='1' and r_cnt ="001" then
            r_data <= lpc_data_i;
            lpc_val <='0';
            data_valid <='1';
			CS<= SYNCs;
			r_cnt <= "000";
		  elsif lpc_ack='1' and r_cnt ="001" then
		  lad_o<="0000";              --added to avoid trouble
			lpc_val <='0';
			CS<= SYNCs;
			r_cnt <= "000";			
          end if;

          if r_cnt ="001" then
			  if lpc_ack='0' then
				lad_o<="0110";              --added to avoid trouble				
			  end if;
            lad_oe<='1';
          elsif lad_i="1111" then
            r_cnt<=ext_sum;
            lad_oe<='1';
            lad_o<="1111";              --drive to F on the bus
            CS <= TARs;
          else
            CS <= RESETs; --some error in protocol master must drive lad to "1111" on 1st TAR
          end if;
      when SYNCs => -----------------------------------------------------------
       case mem_nio is           
        when '0' =>                   --IO write cycle   
          -- just passing r_lad on bus again
          lad_o <= "1111";
          CS <= LOCAL_TARs;
        when '1' =>                    --Memory read cycle
          if data_valid ='1' then
            lad_o <="0000";
            CS <= DATAs;
          else
            if lpc_ack='1' then
              r_data <= lpc_data_i;
              data_valid <= '1';
              lad_o<="0000";           --SYNC ok now                            
              lpc_val <='0';
              CS <= DATAs;
            end if;
          end if;
         when others => null;          
        end case;                      
      when LOCAL_TARs => ------------------------------------------------------
       case mem_nio is           
        when '0' =>                   --IO write cycle   
            lpc_wr <='0';
            lad_oe <='0';
            CS <= RESETs;
        when '1' =>                    --Memory read cycle
          if r_cnt ="000" then                    
            lad_o <= "1111";
            r_cnt <= ext_sum;
          else
            lad_oe <= '0';
            r_cnt <="000";
            CS <= RESETs;
          end if;
        when others => null;            
       end case;                       
    end case; -----------------------------------------------------------------
  end if;
end process LPC;

end rtl;
