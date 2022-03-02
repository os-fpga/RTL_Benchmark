--------------------------------------------------------------------------------
--                                                                            --
--                          V H D L    F I L E                                --
--                          COPYRIGHT (C) 2006                                --
--                                                                            --
--------------------------------------------------------------------------------
--
-- Title       : DCT
-- Design      : MDCT Core
-- Author      : Michal Krepa
--
--------------------------------------------------------------------------------
--
-- File        : ROMO.VHD
-- Created     : Sat Mar 5 7:37 2006
--
--------------------------------------------------------------------------------
--
--  Description : ROM for DCT matrix constant cosine coefficients (odd part)
--
--------------------------------------------------------------------------------

-- 5:0
-- 5:4 = select matrix row (1 out of 4)
-- 3:0 = select precomputed MAC ( 1 out of 16)

library IEEE; 
  use IEEE.STD_LOGIC_1164.all; 
  use ieee.numeric_std.all; 
  use WORK.MDCT_PKG.all;

entity ROMO is 
  port( 
       addr         : in  STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
       clk          : in  STD_LOGIC;  
       
       datao        : out STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0) 
  );          
  
end ROMO; 

architecture RTL of ROMO is  
  type ROM_TYPE is array (0 to 2**ROMADDR_W-1) 
            of STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
  constant rom : ROM_TYPE := 
    (
       (others => '0'),
       std_logic_vector( GP ),
       std_logic_vector( FP ),
       std_logic_vector( FP+GP ),
       std_logic_vector( EP ),
       std_logic_vector( EP+GP ),
       std_logic_vector( EP+FP ),
       std_logic_vector( EP+FP+GP ),
       std_logic_vector( DP ),
       std_logic_vector( DP+GP ),
       std_logic_vector( DP+FP ),
       std_logic_vector( DP+FP+GP ),
       std_logic_vector( DP+EP ),
       std_logic_vector( DP+EP+GP ),
       std_logic_vector( DP+EP+FP ),
       std_logic_vector( DP+EP+FP+GP ),    
      
       (others => '0'),
       std_logic_vector( FM ),
       std_logic_vector( DM ),
       std_logic_vector( DM+FM ),
       std_logic_vector( GM ),
       std_logic_vector( GM+FM ),
       std_logic_vector( GM+DM ),
       std_logic_vector( GM+DM+FM ),
       std_logic_vector( EP ),
       std_logic_vector( EP+FM ),
       std_logic_vector( EP+DM ),
       std_logic_vector( EP+DM+FM ),
       std_logic_vector( EP+GM ),
       std_logic_vector( EP+GM+FM ),
       std_logic_vector( EP+GM+DM ),
       std_logic_vector( EP+GM+DM+FM ),
      
       (others => '0'),
       std_logic_vector( EP ),
       std_logic_vector( GP ),
       std_logic_vector( EP+GP ),
       std_logic_vector( DM ),
       std_logic_vector( DM+EP ),
       std_logic_vector( DM+GP ),
       std_logic_vector( DM+GP+EP ),
       std_logic_vector( FP ),
       std_logic_vector( FP+EP ),
       std_logic_vector( FP+GP ),
       std_logic_vector( FP+GP+EP ),
       std_logic_vector( FP+DM ),
       std_logic_vector( FP+DM+EP ),
       std_logic_vector( FP+DM+GP ),
       std_logic_vector( FP+DM+GP+EP ),
    
       (others => '0'),
       std_logic_vector( DM ),
       std_logic_vector( EP ),
       std_logic_vector( EP+DM ),
       std_logic_vector( FM ),
       std_logic_vector( FM+DM ),
       std_logic_vector( FM+EP ),
       std_logic_vector( FM+EP+DM ),
       std_logic_vector( GP ),
       std_logic_vector( GP+DM ),
       std_logic_vector( GP+EP ),
       std_logic_vector( GP+EP+DM ),
       std_logic_vector( GP+FM ),
       std_logic_vector( GP+FM+DM ),
       std_logic_vector( GP+FM+EP ),
       std_logic_vector( GP+FM+EP+DM )
       );

  signal addr_reg : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
begin   
  
  datao <= rom( TO_INTEGER(UNSIGNED(addr_reg)) ); 
  
  process(clk)
  begin
   if clk = '1' and clk'event then
     addr_reg <= addr;
   end if;
  end process;
      
end RTL;    
          

                

