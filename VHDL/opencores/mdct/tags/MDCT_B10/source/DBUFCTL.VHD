--------------------------------------------------------------------------------
--                                                                            --
--                          V H D L    F I L E                                --
--                          COPYRIGHT (C) 2006                                --
--                                                                            --
--------------------------------------------------------------------------------
--
-- Title       : DBUFCTL
-- Design      : MDCT Core
-- Author      : Michal Krepa
--
--------------------------------------------------------------------------------
--
-- File        : DBUFCTL.VHD
-- Created     : Thu Mar 30 22:19 2006
--
--------------------------------------------------------------------------------
--
--  Description : Double buffer memory controller
--
--------------------------------------------------------------------------------
library IEEE;
  use IEEE.STD_LOGIC_1164.all;

library WORK;
  use WORK.MDCT_PKG.all;

entity DBUFCTL is	
	port(	  
		clk          : in STD_LOGIC;  
		rst          : in STD_LOGIC;
    requestwr    : in STD_LOGIC;
    requestrd    : in STD_LOGIC;
    releasewr    : in STD_LOGIC;
    releaserd    : in STD_LOGIC;
      
    memswitchwr  : out STD_LOGIC;
    memswitchrd  : out STD_LOGIC;
    reqwrfail    : out STD_LOGIC;
    reqrdfail    : out STD_LOGIC;
    dataready    : out STD_LOGIC      
		);
end DBUFCTL;

architecture RTL of DBUFCTL is
 
  signal memswitchwr_reg : STD_LOGIC;
  signal memswitchrd_reg : STD_LOGIC;
  signal mem1_full_reg   : STD_LOGIC;
  signal mem2_full_reg   : STD_LOGIC;
  signal mem1_lock_reg   : STD_LOGIC;
  signal mem2_lock_reg   : STD_LOGIC;
  
begin

  dataready <= '1' when 
    ((mem1_lock_reg = '0' and mem1_full_reg = '1') or 
    (mem2_lock_reg = '0' and mem2_full_reg = '1')) else '0';

  memswitchwr  <= memswitchwr_reg;
  memswitchrd  <= memswitchrd_reg;

  MEM_SWITCH : process(rst,clk)
  begin
    if rst = '1' then   
      memswitchwr_reg <= '0'; -- initially mem 1 is selected
      memswitchrd_reg <= '0'; -- initially mem 1 is selected
      mem1_full_reg <= '0';
      mem2_full_reg <= '0';
      mem1_lock_reg <= '0';
      mem2_lock_reg <= '0'; 
      reqrdfail     <= '0';
      reqwrfail     <= '0';
    elsif clk = '1' and clk'event then
     
      -- write request by DCT1D
      if requestwr = '1' then
        -- if mem1 is free  
        if mem1_lock_reg = '0' and mem1_full_reg = '0' then
          memswitchwr_reg <= '0';
          mem1_lock_reg  <= '1';
          reqwrfail      <= '0';
        -- if mem2 is free
        elsif mem2_lock_reg = '0' and mem2_full_reg = '0' then
          memswitchwr_reg <= '1';
          mem2_lock_reg   <= '1';
          reqwrfail       <= '0';
        else
          reqwrfail       <= '1';
        end if;
      end if;
      
      -- write request released by DCT1D  
      if releasewr = '1' then
        -- if mem1 locked by DCT1D release it
        if mem1_lock_reg = '1' and memswitchwr_reg = '0' then
          mem1_lock_reg  <= '0';
          mem1_full_reg  <= '1';
        -- if mem2 locked by DCT1D release it
        elsif mem2_lock_reg = '1' and memswitchwr_reg = '1' then
          mem2_lock_reg  <= '0';
          mem2_full_reg  <= '1';
        end if;
      end if;
          
      -- read request by DCT2D
      if requestrd = '1' then
        if mem1_lock_reg = '0' and mem1_full_reg = '1' then
          memswitchrd_reg <= '0';
          mem1_lock_reg   <= '1';
          reqrdfail       <= '0';
        elsif mem2_lock_reg = '0' and mem2_full_reg = '1' then
          memswitchrd_reg <= '1';
          mem2_lock_reg   <= '1';
          reqrdfail       <= '0';
        else
          reqrdfail       <= '1';
        end if;
      end if;
      
      -- read request released by DCT2D
      if releaserd = '1' then
        -- if mem1 locked by DCT2D release it
        if mem1_lock_reg = '1' and memswitchrd_reg = '0' then
          mem1_lock_reg  <= '0';
          mem1_full_reg  <= '0';
        -- if mem2 locked by DCT2D release it
        elsif mem2_lock_reg = '1' and memswitchrd_reg = '1' then
          mem2_lock_reg  <= '0';
          mem2_full_reg  <= '0';
        end if;
      end if;
        
    end if; 
  end process;
  
end RTL;
--------------------------------------------------------------------------------