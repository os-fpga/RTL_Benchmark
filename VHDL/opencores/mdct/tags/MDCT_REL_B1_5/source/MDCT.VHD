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
-- Company     : None
--
--------------------------------------------------------------------------------
--
-- File        : MDCT.VHD
-- Created     : Sat Feb 25 16:12 2006
--
--------------------------------------------------------------------------------
--
--  Description : Discrete Cosine Transform - chip top level (w/ memories)
--
--------------------------------------------------------------------------------


library IEEE;
  use IEEE.STD_LOGIC_1164.all;

library WORK;
  use WORK.MDCT_PKG.all;


entity MDCT is	
	port(	  
		clk          : in STD_LOGIC;  
		rst          : in std_logic;
    dcti         : in std_logic_vector(IP_W-1 downto 0);
    idv          : in STD_LOGIC;

    odv          : out STD_LOGIC;
    dcto         : out std_logic_vector(COE_W-1 downto 0);
    -- debug
    odv1         : out STD_LOGIC;
    dcto1        : out std_logic_vector(OP_W-1 downto 0)  
		
		);
end MDCT;

architecture RTL of MDCT is   

------------------------------
-- 1D DCT
------------------------------
component DCT1D	 
	port(	  
		  clk          : in STD_LOGIC;  
		  rst          : in std_logic;
      dcti         : in std_logic_vector(IP_W-1 downto 0);
      idv          : in STD_LOGIC;
      romedatao0   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao1   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao2   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao3   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao4   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao5   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao6   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao7   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao8   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao0   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao1   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao2   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao3   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao4   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao5   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao6   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao7   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao8   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);

      odv          : out STD_LOGIC;
      dcto         : out std_logic_vector(OP_W-1 downto 0);
      romeaddro0   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro1   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro2   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro3   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro4   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro5   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro6   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro7   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro8   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro0   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro1   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro2   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro3   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro4   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro5   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro6   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro7   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro8   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      ramwaddro    : out STD_LOGIC_VECTOR(RAMADRR_W-1 downto 0);
      ramdatai     : out STD_LOGIC_VECTOR(RAMDATA_W-1 downto 0);
      ramwe        : out STD_LOGIC;
      wmemsel      : out STD_LOGIC 	
		);
end component;	

------------------------------
-- 1D DCT (2nd stage)
------------------------------
component DCT2D	 
	port(	  
      clk          : in STD_LOGIC;  
      rst          : in std_logic;
      romedatao0   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao1   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao2   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao3   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao4   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao5   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao6   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao7   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao8   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao9   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romedatao10  : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao0   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao1   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao2   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao3   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao4   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao5   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao6   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao7   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao8   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao9   : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      romodatao10  : in STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
      ramdatao     : in STD_LOGIC_VECTOR(RAMDATA_W-1 downto 0);
      dataready    : in STD_LOGIC;
 
      odv          : out STD_LOGIC;
      dcto         : out std_logic_vector(OP_W-1 downto 0);
      romeaddro0   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro1   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro2   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro3   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro4   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro5   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro6   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro7   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro8   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro9   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romeaddro10  : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro0   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro1   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro2   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro3   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro4   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro5   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro6   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro7   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro8   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro9   : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      romoaddro10  : out STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
      ramraddro    : out STD_LOGIC_VECTOR(RAMADRR_W-1 downto 0);
      rmemsel      : out STD_LOGIC;
      datareadyack : out STD_LOGIC 
);
end component;

------------------------------
-- RAM
------------------------------
component RAM   
  port (      
        d                 : in  STD_LOGIC_VECTOR(RAMDATA_W-1 downto 0);
        waddr             : in  STD_LOGIC_VECTOR(RAMADRR_W-1 downto 0);
        raddr             : in  STD_LOGIC_VECTOR(RAMADRR_W-1 downto 0);
        we                : in  STD_LOGIC;
        clk               : in  STD_LOGIC;
        
        q                 : out STD_LOGIC_VECTOR(RAMDATA_W-1 downto 0)
  );
end component;

------------------------------
-- ROME
------------------------------
component ROME 
  port( 
       addr         : in  STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
       clk          : in STD_LOGIC;  
       
       datao        : out STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0) 
  );
end component;

------------------------------
-- ROMO
------------------------------
component ROMO 
  port( 
       addr         : in  STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0); 
       clk          : in STD_LOGIC; 
       
       datao        : out STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0) 
  );
end component;

------------------------------
-- DBUFCTL
------------------------------
component DBUFCTL is	
	port(	  
		clk          : in STD_LOGIC;  
		rst          : in STD_LOGIC;
    wmemsel      : in STD_LOGIC;
    rmemsel      : in STD_LOGIC;
    datareadyack : in STD_LOGIC;
      
    memswitchwr  : out STD_LOGIC;
    memswitchrd  : out STD_LOGIC;
    dataready    : out STD_LOGIC 
);
end component;

signal romedatao0_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romedatao1_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romedatao2_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romedatao3_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romedatao4_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romedatao5_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romedatao6_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romedatao7_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romedatao8_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romodatao0_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romodatao1_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romodatao2_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romodatao3_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romodatao4_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romodatao5_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romodatao6_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romodatao7_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romodatao8_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal ramdatao_s           : STD_LOGIC_VECTOR(RAMDATA_W-1 downto 0);
signal romeaddro0_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romeaddro1_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romeaddro2_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romeaddro3_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romeaddro4_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romeaddro5_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romeaddro6_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romeaddro7_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romeaddro8_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romoaddro0_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romoaddro1_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romoaddro2_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romoaddro3_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romoaddro4_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romoaddro5_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romoaddro6_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romoaddro7_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romoaddro8_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal ramraddro_s          : STD_LOGIC_VECTOR(RAMADRR_W-1 downto 0);
signal ramwaddro_s          : STD_LOGIC_VECTOR(RAMADRR_W-1 downto 0);
signal ramdatai_s           : STD_LOGIC_VECTOR(RAMDATA_W-1 downto 0);
signal ramwe_s              : STD_LOGIC;
	   
signal rome2datao0_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal rome2datao1_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal rome2datao2_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal rome2datao3_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal rome2datao4_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal rome2datao5_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal rome2datao6_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal rome2datao7_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal rome2datao8_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal rome2datao9_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal rome2datao10_s        : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romo2datao0_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romo2datao1_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romo2datao2_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romo2datao3_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romo2datao4_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romo2datao5_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romo2datao6_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romo2datao7_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romo2datao8_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romo2datao9_s         : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal romo2datao10_s        : STD_LOGIC_VECTOR(ROMDATA_W-1 downto 0);
signal rome2addro0_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal rome2addro1_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal rome2addro2_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal rome2addro3_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal rome2addro4_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal rome2addro5_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal rome2addro6_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal rome2addro7_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal rome2addro8_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal rome2addro9_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal rome2addro10_s        : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romo2addro0_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romo2addro1_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romo2addro2_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romo2addro3_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romo2addro4_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romo2addro5_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romo2addro6_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romo2addro7_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romo2addro8_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romo2addro9_s         : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal romo2addro10_s        : STD_LOGIC_VECTOR(ROMADDR_W-1 downto 0);
signal odv2_s                : STD_LOGIC;
signal dcto2_s               : STD_LOGIC_VECTOR(OP_W-1 downto 0);  
signal trigger2_s            : STD_LOGIC;
signal trigger1_s            : STD_LOGIC;
signal ramdatao1_s           : STD_LOGIC_VECTOR(RAMDATA_W-1 downto 0);
signal ramdatao2_s           : STD_LOGIC_VECTOR(RAMDATA_W-1 downto 0);
signal ramwe1_s              : STD_LOGIC;
signal ramwe2_s              : STD_LOGIC; 
signal memswitchrd_s         : STD_LOGIC;
signal memswitchwr_s         : STD_LOGIC;
signal wmemsel_s             : STD_LOGIC; 
signal rmemsel_s             : STD_LOGIC;
signal dataready_s           : STD_LOGIC;
signal datareadyack_s        : STD_LOGIC;

begin	

------------------------------
-- 1D DCT port map
------------------------------
U_DCT1D : DCT1D
  port map(	  
      clk          => clk,         
      rst          => rst,      
      dcti         => dcti,   
      idv          => idv,
      romedatao0   => romedatao0_s,
      romedatao1   => romedatao1_s,
      romedatao2   => romedatao2_s,
      romedatao3   => romedatao3_s,
      romedatao4   => romedatao4_s,
      romedatao5   => romedatao5_s,
      romedatao6   => romedatao6_s,
      romedatao7   => romedatao7_s,
      romedatao8   => romedatao8_s,
      romodatao0   => romodatao0_s,
      romodatao1   => romodatao1_s,   
      romodatao2   => romodatao2_s,   
      romodatao3   => romodatao3_s,   
      romodatao4   => romodatao4_s,   
      romodatao5   => romodatao5_s,   
      romodatao6   => romodatao6_s,   
      romodatao7   => romodatao7_s,
      romodatao8   => romodatao8_s,     
  
      odv          => odv1,
      dcto         => dcto1,
      romeaddro0   => romeaddro0_s,
      romeaddro1   => romeaddro1_s,
      romeaddro2   => romeaddro2_s,
      romeaddro3   => romeaddro3_s,
      romeaddro4   => romeaddro4_s,
      romeaddro5   => romeaddro5_s,
      romeaddro6   => romeaddro6_s,
      romeaddro7   => romeaddro7_s,
      romeaddro8   => romeaddro8_s,
      romoaddro0   => romoaddro0_s,
      romoaddro1   => romoaddro1_s,
      romoaddro2   => romoaddro2_s,
      romoaddro3   => romoaddro3_s,
      romoaddro4   => romoaddro4_s,
      romoaddro5   => romoaddro5_s,
      romoaddro6   => romoaddro6_s,
      romoaddro7   => romoaddro7_s,
      romoaddro8   => romoaddro8_s,
      ramwaddro    => ramwaddro_s,
      ramdatai     => ramdatai_s,
      ramwe        => ramwe_s,
      wmemsel      => wmemsel_s
		);

------------------------------
-- 1D DCT port map
------------------------------
U_DCT2D : DCT2D
  port map(	  
      clk          => clk,         
      rst          => rst,      
      romedatao0   => rome2datao0_s,
      romedatao1   => rome2datao1_s,
      romedatao2   => rome2datao2_s,
      romedatao3   => rome2datao3_s,
      romedatao4   => rome2datao4_s,
      romedatao5   => rome2datao5_s,
      romedatao6   => rome2datao6_s,
      romedatao7   => rome2datao7_s,
      romedatao8   => rome2datao8_s,
      romedatao9   => rome2datao9_s,
      romedatao10  => rome2datao10_s,
      romodatao0   => romo2datao0_s,
      romodatao1   => romo2datao1_s,   
      romodatao2   => romo2datao2_s,   
      romodatao3   => romo2datao3_s,   
      romodatao4   => romo2datao4_s,   
      romodatao5   => romo2datao5_s,   
      romodatao6   => romo2datao6_s,   
      romodatao7   => romo2datao7_s,      
      romodatao8   => romo2datao8_s,
      romodatao9   => romo2datao9_s,
      romodatao10  => romo2datao10_s,
      ramdatao     => ramdatao_s,
      dataready    => dataready_s,  
    
      odv          => odv,
      dcto         => dcto,
      romeaddro0   => rome2addro0_s,
      romeaddro1   => rome2addro1_s,
      romeaddro2   => rome2addro2_s,
      romeaddro3   => rome2addro3_s,
      romeaddro4   => rome2addro4_s,
      romeaddro5   => rome2addro5_s,
      romeaddro6   => rome2addro6_s,
      romeaddro7   => rome2addro7_s,
      romeaddro8   => rome2addro8_s,
      romeaddro9   => rome2addro9_s,
      romeaddro10  => rome2addro10_s,
      romoaddro0   => romo2addro0_s,
      romoaddro1   => romo2addro1_s,
      romoaddro2   => romo2addro2_s,
      romoaddro3   => romo2addro3_s,
      romoaddro4   => romo2addro4_s,
      romoaddro5   => romo2addro5_s,
      romoaddro6   => romo2addro6_s,
      romoaddro7   => romo2addro7_s,
      romoaddro8   => romo2addro8_s,
      romoaddro9   => romo2addro9_s,
      romoaddro10  => romo2addro10_s,
      ramraddro    => ramraddro_s,
      rmemsel      => rmemsel_s,
      datareadyack => datareadyack_s
		);

------------------------------
-- RAM1 port map
------------------------------
U1_RAM : RAM   
  port map (      
        d          => ramdatai_s,               
        waddr      => ramwaddro_s,     
        raddr      => ramraddro_s,     
        we         => ramwe1_s,     
        clk        => clk,      
        
        q          => ramdatao1_s      
  );

------------------------------
-- RAM2 port map
------------------------------
U2_RAM : RAM   
  port map (      
        d          => ramdatai_s,               
        waddr      => ramwaddro_s,     
        raddr      => ramraddro_s,     
        we         => ramwe2_s,     
        clk        => clk,      
        
        q          => ramdatao2_s      
  );

-- double buffer switch
ramwe1_s     <= ramwe_s when memswitchwr_s = '0' else '0';
ramwe2_s     <= ramwe_s when memswitchwr_s = '1' else '0';
ramdatao_s   <= ramdatao1_s when memswitchrd_s = '0' else ramdatao2_s;

------------------------------
-- DBUFCTL
------------------------------
U_DBUFCTL : DBUFCTL 	
	port map(	  
		clk            => clk,
		rst            => rst,
    wmemsel        => wmemsel_s,
    rmemsel        => rmemsel_s,
    datareadyack   => datareadyack_s,
      
    memswitchwr    => memswitchwr_s,
    memswitchrd    => memswitchrd_s,
    dataready      => dataready_s
		);  

------------------------------
-- ROME port map
------------------------------
U1_ROME0 : ROME 
  port map( 
       addr        => romeaddro0_s,  
       clk         => clk, 
       
       datao       => romedatao0_s
  );
  
------------------------------
-- ROME port map
------------------------------
U1_ROME1 : ROME 
  port map( 
       addr        => romeaddro1_s,   
       clk         => clk, 
       
       datao       => romedatao1_s
  );
  
------------------------------
-- ROME port map
------------------------------
U1_ROME2 : ROME 
  port map( 
       addr        => romeaddro2_s,
       clk         => clk,    
       
       datao       => romedatao2_s
  ); 
   
------------------------------
-- ROME port map
------------------------------
U1_ROME3 : ROME 
  port map( 
       addr        => romeaddro3_s,
       clk         => clk,    
       
       datao       => romedatao3_s
  ); 
------------------------------
-- ROME port map
------------------------------
U1_ROME4 : ROME 
  port map( 
       addr        => romeaddro4_s, 
       clk         => clk,   
       
       datao       => romedatao4_s
  ); 
------------------------------
-- ROME port map
------------------------------
U1_ROME5 : ROME 
  port map( 
       addr        => romeaddro5_s, 
       clk         => clk,   
       
       datao       => romedatao5_s
  ); 
------------------------------
-- ROME port map
------------------------------
U1_ROME6 : ROME 
  port map( 
       addr        => romeaddro6_s, 
       clk         => clk,   
       
       datao       => romedatao6_s
  ); 
------------------------------
-- ROME port map
------------------------------
U1_ROME7 : ROME 
  port map( 
       addr        => romeaddro7_s, 
       clk         => clk,   
       
       datao       => romedatao7_s
  ); 
------------------------------
-- ROME port map
------------------------------
U1_ROME8 : ROME 
  port map( 
       addr        => romeaddro8_s, 
       clk         => clk,   
       
       datao       => romedatao8_s
  ); 

------------------------------
-- ROMO port map
------------------------------
U1_ROMO0 : ROMO 
  port map( 
       addr        => romoaddro0_s, 
       clk         => clk,  
       
       datao       => romodatao0_s
  );
------------------------------
-- ROMO port map
------------------------------
U1_ROMO1 : ROMO 
  port map( 
       addr        => romoaddro1_s,
       clk         => clk,   
       
       datao       => romodatao1_s
  );
------------------------------
-- ROMO port map
------------------------------
U1_ROMO2 : ROMO 
  port map( 
       addr        => romoaddro2_s,
       clk         => clk,   
       
       datao       => romodatao2_s
  );
------------------------------
-- ROMO port map
------------------------------
U1_ROMO3 : ROMO 
  port map( 
       addr        => romoaddro3_s, 
       clk         => clk,  
       
       datao       => romodatao3_s
  );
------------------------------
-- ROMO port map
------------------------------
U1_ROMO4 : ROMO 
  port map( 
       addr        => romoaddro4_s,   
       clk         => clk,
       
       datao       => romodatao4_s
  );
------------------------------
-- ROMO port map
------------------------------
U1_ROMO5 : ROMO 
  port map( 
       addr        => romoaddro5_s, 
       clk         => clk,  
       
       datao       => romodatao5_s
  );
------------------------------
-- ROMO port map
------------------------------
U1_ROMO6 : ROMO 
  port map( 
       addr        => romoaddro6_s,
       clk         => clk,   
       
       datao       => romodatao6_s
  );
------------------------------
-- ROMO port map
------------------------------
U1_ROMO7 : ROMO 
  port map( 
       addr        => romoaddro7_s,
       clk         => clk,   
       
       datao       => romodatao7_s
  );
------------------------------
-- ROMO port map
------------------------------
U1_ROMO8 : ROMO 
  port map( 
       addr        => romoaddro8_s, 
       clk         => clk,  
       
       datao       => romodatao8_s
  );
  
------------------------------
-- 2 stage ROMs
------------------------------
------------------------------
-- ROME port map
------------------------------
U2_ROME0 : ROME 
  port map( 
       addr        => rome2addro0_s, 
       clk         => clk,   
       
       datao       => rome2datao0_s
  );
  
------------------------------
-- ROME port map
------------------------------
U2_ROME1 : ROME 
  port map( 
       addr        => rome2addro1_s,
       clk         => clk,    
       
       datao       => rome2datao1_s
  );
  
------------------------------
-- ROME port map
------------------------------
U2_ROME2 : ROME 
  port map( 
       addr        => rome2addro2_s, 
       clk         => clk,   
       
       datao       => rome2datao2_s
  ); 
   
------------------------------
-- ROME port map
------------------------------
U2_ROME3 : ROME 
  port map( 
       addr        => rome2addro3_s, 
       clk         => clk,   
       
       datao       => rome2datao3_s
  ); 
------------------------------
-- ROME port map
------------------------------
U2_ROME4 : ROME 
  port map( 
       addr        => rome2addro4_s,  
       clk         => clk,  
       
       datao       => rome2datao4_s
  ); 
------------------------------
-- ROME port map
------------------------------
U2_ROME5 : ROME 
  port map( 
       addr        => rome2addro5_s, 
       clk         => clk,   
       
       datao       => rome2datao5_s
  ); 
------------------------------
-- ROME port map
------------------------------
U2_ROME6 : ROME 
  port map( 
       addr        => rome2addro6_s, 
       clk         => clk,   
       
       datao       => rome2datao6_s
  ); 
------------------------------
-- ROME port map
------------------------------
U2_ROME7 : ROME 
  port map( 
       addr        => rome2addro7_s, 
       clk         => clk,   
       
       datao       => rome2datao7_s
  ); 
------------------------------
-- ROME port map
------------------------------
U2_ROME8 : ROME 
  port map( 
       addr        => rome2addro8_s, 
       clk         => clk,   
       
       datao       => rome2datao8_s
  );
------------------------------
-- ROME port map
------------------------------
U2_ROME9 : ROME 
  port map( 
       addr        => rome2addro9_s, 
       clk         => clk,   
       
       datao       => rome2datao9_s
  );  
------------------------------
-- ROME port map
------------------------------
U2_ROME10 : ROME 
  port map( 
       addr        => rome2addro10_s, 
       clk         => clk,   
       
       datao       => rome2datao10_s
  );

------------------------------
-- ROMO port map
------------------------------
U2_ROMO0 : ROMO 
  port map( 
       addr        => romo2addro0_s,
       clk         => clk, 
       
       datao       => romo2datao0_s
  );
------------------------------
-- ROMO port map
------------------------------
U2_ROMO1 : ROMO 
  port map( 
       addr        => romo2addro1_s,
       clk         => clk,   
       
       datao       => romo2datao1_s
  );
------------------------------
-- ROMO port map
------------------------------
U2_ROMO2 : ROMO 
  port map( 
       addr        => romo2addro2_s, 
       clk         => clk,  
       
       datao       => romo2datao2_s
  );
------------------------------
-- ROMO port map
------------------------------
U2_ROMO3 : ROMO 
  port map( 
       addr        => romo2addro3_s, 
       clk         => clk,  
       
       datao       => romo2datao3_s
  );
------------------------------
-- ROMO port map
------------------------------
U2_ROMO4 : ROMO 
  port map( 
       addr        => romo2addro4_s, 
       clk         => clk,  
       
       datao       => romo2datao4_s
  );
------------------------------
-- ROMO port map
------------------------------
U2_ROMO5 : ROMO 
  port map( 
       addr        => romo2addro5_s, 
       clk         => clk,  
       
       datao       => romo2datao5_s
  );
------------------------------
-- ROMO port map
------------------------------
U2_ROMO6 : ROMO 
  port map( 
       addr        => romo2addro6_s,
       clk         => clk,   
       
       datao       => romo2datao6_s
  );
------------------------------
-- ROMO port map
------------------------------
U2_ROMO7 : ROMO 
  port map( 
       addr        => romo2addro7_s, 
       clk         => clk,  
       
       datao       => romo2datao7_s
  );
------------------------------
-- ROMO port map
------------------------------
U2_ROMO8 : ROMO 
  port map( 
       addr        => romo2addro8_s, 
       clk         => clk,  
       
       datao       => romo2datao8_s
  );	
------------------------------
-- ROMO port map
------------------------------
U2_ROMO9 : ROMO 
  port map( 
       addr        => romo2addro9_s,
       clk         => clk,   
       
       datao       => romo2datao9_s
  );	  			
------------------------------
-- ROMO port map
------------------------------
U2_ROMO10 : ROMO 
  port map( 
       addr        => romo2addro10_s,
       clk         => clk,   
       
       datao       => romo2datao10_s
  );
  	
end RTL;
