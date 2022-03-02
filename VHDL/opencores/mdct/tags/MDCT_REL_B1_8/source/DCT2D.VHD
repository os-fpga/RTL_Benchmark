--------------------------------------------------------------------------------
--                                                                            --
--                          V H D L    F I L E                                --
--                          COPYRIGHT (C) 2006                                --
--                                                                            --
--------------------------------------------------------------------------------
--
-- Title       : DCT2D
-- Design      : MDCT Core
-- Author      : Michal Krepa
--
--------------------------------------------------------------------------------
--
-- File        : DCT2D.VHD
-- Created     : Sat Mar 28 22:32 2006
--
--------------------------------------------------------------------------------
--
--  Description : 1D Discrete Cosine Transform (second stage)
--
--------------------------------------------------------------------------------


library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use ieee.numeric_std.all; 

library WORK;
  use WORK.MDCT_PKG.all;

entity DCT2D is	 
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
end DCT2D;

architecture RTL of DCT2D is   
  
  type input_data2 is array (N-1 downto 0) of SIGNED(RAMDATA_W downto 0);
  
  signal databuf_reg    : input_data2;
  signal latchbuf_reg   : input_data2;
  signal col_reg        : UNSIGNED(RAMADRR_W/2-1 downto 0);
  signal row_reg        : UNSIGNED(RAMADRR_W/2-1 downto 0);
  signal colram_reg     : UNSIGNED(RAMADRR_W/2-1 downto 0);
  signal rowram_reg     : UNSIGNED(RAMADRR_W/2-1 downto 0);
  signal colr_reg       : UNSIGNED(RAMADRR_W/2-1 downto 0);
  signal rowr_reg       : UNSIGNED(RAMADRR_W/2-1 downto 0);
  signal rmemsel_reg    : STD_LOGIC;
  signal stage1_reg     : STD_LOGIC; 
  signal stage2_reg     : STD_LOGIC; 
  signal stage2_cnt_reg : UNSIGNED(RAMADRR_W-1 downto 0);
  signal dataready_2_reg : STD_LOGIC;  
  	   
begin

  ramraddro_sg:
  ramraddro  <= STD_LOGIC_VECTOR(rowr_reg & colr_reg);
  
  rmemsel_sg:
  rmemsel    <= rmemsel_reg;
  
  process(clk)
  begin
    if clk='1' and clk'event then
      if rst = '1' then
        stage2_cnt_reg       <= (others => '1');
        rmemsel_reg          <= '0';
        stage1_reg           <= '0';
        stage2_reg           <= '0';
        colram_reg           <= (others => '0');
        rowram_reg           <= (others => '0');
        col_reg              <= (others => '0');
        row_reg              <= (others => '0');
        latchbuf_reg         <= (others => (others => '0')); 
        databuf_reg          <= (others => (others => '0'));
        dcto                 <= (others => '0');
        odv                  <= '0';
        colr_reg             <= (others => '0');
        rowr_reg             <= (others => '0'); 
        dataready_2_reg      <= '0';
      else
      
        stage2_reg    <= '0';
        odv           <= '0';
        datareadyack  <= '0';
  
        dataready_2_reg <= dataready;
        
        ----------------------------------
        -- read DCT 1D to barrel shifer
        ----------------------------------
        if stage1_reg = '1' then
  
          -- right shift input data
          latchbuf_reg(N-2 downto 0) <= latchbuf_reg(N-1 downto 1);
          latchbuf_reg(N-1)          <= RESIZE(SIGNED(ramdatao),RAMDATA_W+1);       
           
          colram_reg  <= colram_reg + 1;
          colr_reg    <= colr_reg + 1;
            
          if colram_reg = N-2 then
            rowr_reg <= rowr_reg + 1;
          end if;
                 
          if colram_reg = N-1 then
            rowram_reg <= rowram_reg + 1; 
            if rowram_reg = N-1 then
              stage1_reg    <= '0';
              colr_reg      <= (others => '0');
              -- release memory
              rmemsel_reg    <= not rmemsel_reg;
            end if;
            
            -- after this sum databuf_reg is in range of -256 to 254 (min to max) 
            databuf_reg(0)  <= latchbuf_reg(1)+RESIZE(SIGNED(ramdatao),RAMDATA_W+1);
            databuf_reg(1)  <= latchbuf_reg(2)+latchbuf_reg(7);
            databuf_reg(2)  <= latchbuf_reg(3)+latchbuf_reg(6);
            databuf_reg(3)  <= latchbuf_reg(4)+latchbuf_reg(5);
            databuf_reg(4)  <= latchbuf_reg(1)-RESIZE(SIGNED(ramdatao),RAMDATA_W+1);
            databuf_reg(5)  <= latchbuf_reg(2)-latchbuf_reg(7);
            databuf_reg(6)  <= latchbuf_reg(3)-latchbuf_reg(6);
            databuf_reg(7)  <= latchbuf_reg(4)-latchbuf_reg(5);
            
            -- 8 point input latched
            stage2_reg      <= '1';
          end if;     
        end if;
          
        --------------------------------
        -- 2nd stage
        --------------------------------
        if stage2_cnt_reg < N then
        
          if stage2_cnt_reg(0) = '0' then
            dcto <= STD_LOGIC_VECTOR(RESIZE
              (RESIZE(SIGNED(romedatao0),DA2_W) + 
              (RESIZE(SIGNED(romedatao1),DA2_W-1) & '0') +
              (RESIZE(SIGNED(romedatao2),DA2_W-2) & "00") + 
              (RESIZE(SIGNED(romedatao3),DA2_W-3) & "000") +
              (RESIZE(SIGNED(romedatao4),DA2_W-4) & "0000") +
              (RESIZE(SIGNED(romedatao5),DA2_W-5) & "00000") +
              (RESIZE(SIGNED(romedatao6),DA2_W-6) & "000000") + 
              (RESIZE(SIGNED(romedatao7),DA2_W-7) & "0000000") +
              (RESIZE(SIGNED(romedatao8),DA2_W-8) & "00000000") +
              (RESIZE(SIGNED(romedatao9),DA2_W-9) & "000000000") -
              (RESIZE(SIGNED(romedatao10),DA2_W-10) & "0000000000"),            
              DA2_W)(DA2_W-1 downto 12));
          else
            dcto <= STD_LOGIC_VECTOR(RESIZE
              (RESIZE(SIGNED(romodatao0),DA2_W) + 
              (RESIZE(SIGNED(romodatao1),DA2_W-1) & '0') +
              (RESIZE(SIGNED(romodatao2),DA2_W-2) & "00") + 
              (RESIZE(SIGNED(romodatao3),DA2_W-3) & "000") +
              (RESIZE(SIGNED(romodatao4),DA2_W-4) & "0000") +
              (RESIZE(SIGNED(romodatao5),DA2_W-5) & "00000") +
              (RESIZE(SIGNED(romodatao6),DA2_W-6) & "000000") + 
              (RESIZE(SIGNED(romodatao7),DA2_W-7) & "0000000") +
              (RESIZE(SIGNED(romodatao8),DA2_W-8) & "00000000") +
              (RESIZE(SIGNED(romodatao9),DA2_W-9) & "000000000") -
              (RESIZE(SIGNED(romodatao10),DA2_W-10) & "0000000000"),          
              DA2_W)(DA2_W-1 downto 12)); 
          end if;
          
          stage2_cnt_reg <= stage2_cnt_reg + 1;
          
          -- write RAM
          odv       <= '1';
    
          -- increment column counter
          col_reg   <= col_reg + 1;
          
          -- finished processing one input row
          if col_reg = N - 1 then
            row_reg         <= row_reg + 1;
          end if;  
        end if;
          
        if stage2_reg = '1' then
          stage2_cnt_reg <= (others => '0');
          col_reg        <= (0=>'1',others => '0');
        end if;
        --------------------------------
        
        ----------------------------------
        -- wait for new data
        ----------------------------------
        -- one of ram buffers has new data, process it
        if dataready = '1' and dataready_2_reg = '0'  then
          stage1_reg    <= '1';
          -- to account for 1T RAM delay, increment RAM address counter
          colram_reg    <= (others => '0');
          colr_reg      <= (0=>'1',others => '0');
          datareadyack  <= '1';
        end if;
        ----------------------------------
           
      end if;
    end if;
  end process;

  -- read precomputed MAC results from LUT
  romeaddro0 <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
           databuf_reg(0)(0) & 
           databuf_reg(1)(0) &
           databuf_reg(2)(0) &
           databuf_reg(3)(0);
  romeaddro1 <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
           databuf_reg(0)(1) & 
           databuf_reg(1)(1) &
           databuf_reg(2)(1) &
           databuf_reg(3)(1);
  romeaddro2 <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
           databuf_reg(0)(2) & 
           databuf_reg(1)(2) &
           databuf_reg(2)(2) &
           databuf_reg(3)(2);
  romeaddro3 <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
           databuf_reg(0)(3) & 
           databuf_reg(1)(3) &
           databuf_reg(2)(3) &
           databuf_reg(3)(3);          
  romeaddro4 <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
           databuf_reg(0)(4) & 
           databuf_reg(1)(4) &
           databuf_reg(2)(4) &
           databuf_reg(3)(4);                    
  romeaddro5  <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
           databuf_reg(0)(5) & 
           databuf_reg(1)(5) &
           databuf_reg(2)(5) &
           databuf_reg(3)(5); 
  romeaddro6  <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
           databuf_reg(0)(6) & 
           databuf_reg(1)(6) &
           databuf_reg(2)(6) &
           databuf_reg(3)(6);
  romeaddro7  <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
           databuf_reg(0)(7) & 
           databuf_reg(1)(7) &
           databuf_reg(2)(7) &
           databuf_reg(3)(7);
  romeaddro8  <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
           databuf_reg(0)(8) & 
           databuf_reg(1)(8) &
           databuf_reg(2)(8) &
           databuf_reg(3)(8); 
  romeaddro9  <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
           databuf_reg(0)(9) & 
           databuf_reg(1)(9) &
           databuf_reg(2)(9) &
           databuf_reg(3)(9);
  romeaddro10  <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
           databuf_reg(0)(10) & 
           databuf_reg(1)(10) &
           databuf_reg(2)(10) &
           databuf_reg(3)(10);
  -- odd
  romoaddro0 <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
            databuf_reg(4)(0) & 
            databuf_reg(5)(0) &
            databuf_reg(6)(0) &
            databuf_reg(7)(0);
  romoaddro1 <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
            databuf_reg(4)(1) & 
            databuf_reg(5)(1) &
            databuf_reg(6)(1) &
            databuf_reg(7)(1);
  romoaddro2 <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
            databuf_reg(4)(2) & 
            databuf_reg(5)(2) &
            databuf_reg(6)(2) &
            databuf_reg(7)(2);
  romoaddro3 <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
            databuf_reg(4)(3) & 
            databuf_reg(5)(3) &
            databuf_reg(6)(3) &
            databuf_reg(7)(3);                   
  romoaddro4 <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
            databuf_reg(4)(4) & 
            databuf_reg(5)(4) &
            databuf_reg(6)(4) &
            databuf_reg(7)(4);
  romoaddro5 <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
            databuf_reg(4)(5) & 
            databuf_reg(5)(5) &
            databuf_reg(6)(5) &
            databuf_reg(7)(5);
  romoaddro6 <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
            databuf_reg(4)(6) & 
            databuf_reg(5)(6) &
            databuf_reg(6)(6) &
            databuf_reg(7)(6);
  romoaddro7 <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
            databuf_reg(4)(7) & 
            databuf_reg(5)(7) &
            databuf_reg(6)(7) &
            databuf_reg(7)(7);
  romoaddro8 <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
            databuf_reg(4)(8) & 
            databuf_reg(5)(8) &
            databuf_reg(6)(8) &
            databuf_reg(7)(8); 
  romoaddro9 <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
            databuf_reg(4)(9) & 
            databuf_reg(5)(9) &
            databuf_reg(6)(9) &
            databuf_reg(7)(9);
  romoaddro10 <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
            databuf_reg(4)(10) & 
            databuf_reg(5)(10) &
            databuf_reg(6)(10) &
            databuf_reg(7)(10);
	
end RTL;
--------------------------------------------------------------------------------

