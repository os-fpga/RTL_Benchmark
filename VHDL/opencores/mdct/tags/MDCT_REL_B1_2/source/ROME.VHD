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
-- File        : ROME.VHD
-- Created     : Sat Mar 5 7:37 2006
--
--------------------------------------------------------------------------------
--
--  Description : ROM for DCT matrix constant cosine coefficients (even part)
--
--------------------------------------------------------------------------------

-- 5:0
-- 5:4 = select matrix row (1 out of 4)
-- 3:0 = select precomputed MAC ( 1 out of 16)

library IEEE; 
  use IEEE.STD_LOGIC_1164.all; 
  use ieee.numeric_std.all;
  use WORK.MDCT_PKG.all;

entity ROME is 
  port( 
       addr         : in  STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);  
       
       datao        : out STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0) 
  );         
  
end ROME; 

architecture RTL of ROME is  
  
  type ROM_TYPE is array (0 to 2**ROMADDR_W-1) 
            of STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
  constant rom : ROM_TYPE := 
    (
    (others => '0'),                
     std_logic_vector( AP ),         
     std_logic_vector( AP ),         
     std_logic_vector( AP+AP ),      
     std_logic_vector( AP ),         
     std_logic_vector( AP+AP ),      
     std_logic_vector( AP+AP ),      
     std_logic_vector( AP+AP+AP ),   
     std_logic_vector( AP ),         
     std_logic_vector( AP+AP ),      
     std_logic_vector( AP+AP ),      
     std_logic_vector( AP+AP+AP ),   
     std_logic_vector( AP+AP ),      
     std_logic_vector( AP+AP+AP ),   
     std_logic_vector( AP+AP+AP ),   
     std_logic_vector( AP+AP+AP+AP ),
                                     
                                     
     (others => '0'),                
     std_logic_vector( BM ),         
     std_logic_vector( CM ),         
     std_logic_vector( CM+BM ),      
     std_logic_vector( CP ),         
     std_logic_vector( CP+BM ),      
     (others => '0'),                
     std_logic_vector( BM ),         
     std_logic_vector( BP ),         
     (others => '0'),                
     std_logic_vector( BP+CM ),      
     std_logic_vector( CM ),         
     std_logic_vector( BP+CP ),      
     std_logic_vector( CP ),         
     std_logic_vector( BP ),         
     (others => '0'),                
                                     
                                     
     (others => '0'),                
     std_logic_vector( AP ),         
     std_logic_vector( AM ),         
     (others => '0'),                
     std_logic_vector( AM ),         
     (others => '0'),                
     std_logic_vector( AM+AM ),      
     std_logic_vector( AM ),         
     std_logic_vector( AP ),         
     std_logic_vector( AP+AP ),      
     (others => '0'),                
     std_logic_vector( AP ),         
     (others => '0'),                
     std_logic_vector( AP ),         
     std_logic_vector( AM ),         
     (others => '0'),                
                                     
                                     
     (others => '0'),                
     std_logic_vector( CM ),         
     std_logic_vector( BP ),         
     std_logic_vector( BP+CM ),      
     std_logic_vector( BM ),         
     std_logic_vector( BM+CM ),      
     (others => '0'),                
     std_logic_vector( CM ),         
     std_logic_vector( CP ),         
     (others => '0'),                
     std_logic_vector( CP+BP ),      
     std_logic_vector( BP ),         
     std_logic_vector( CP+BM ),      
     std_logic_vector( BM ),         
     std_logic_vector( CP ),         
     (others => '0')
     );                
  
   
begin 

  process( addr )
  begin
    datao <= rom( TO_INTEGER(UNSIGNED(addr)) ); 
  end process;
  
      
end RTL;    
--------------------------------------------------------------------------------          

                

