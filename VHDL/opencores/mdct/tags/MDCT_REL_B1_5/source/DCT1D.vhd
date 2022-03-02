--------------------------------------------------------------------------------
--                                                                            --
--                          V H D L    F I L E                                --
--                          COPYRIGHT (C) 2006                                --
--                                                                            --
--------------------------------------------------------------------------------
--
-- Title       : DCT1D
-- Design      : MDCT Core
-- Author      : Michal Krepa
--
--------------------------------------------------------------------------------
--
-- File        : DCT1D.VHD
-- Created     : Sat Mar 5 7:37 2006
--
--------------------------------------------------------------------------------
--
--  Description : 1D Discrete Cosine Transform (1st stage)
--
--------------------------------------------------------------------------------


library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.NUMERIC_STD.all; 

library WORK;
  use WORK.MDCT_PKG.all;

--------------------------------------------------------------------------------
-- ENTITY
--------------------------------------------------------------------------------
entity DCT1D is	 
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
end DCT1D;

--------------------------------------------------------------------------------
-- ARCHITECTURE
--------------------------------------------------------------------------------
architecture RTL of DCT1D is   
  
  type INPUT_DATA is array (N-1 downto 0) of SIGNED(IP_W downto 0);
  
  signal databuf_reg    : INPUT_DATA;
  signal latchbuf_reg   : INPUT_DATA;
  signal col_reg        : UNSIGNED(RAMADRR_W/2-1 downto 0);
  signal row_reg        : UNSIGNED(RAMADRR_W/2-1 downto 0);
  signal rowr_reg       : UNSIGNED(RAMADRR_W/2-1 downto 0);
  signal inpcnt_reg     : UNSIGNED(RAMADRR_W/2-1 downto 0);
  signal ramdatai_s     : STD_LOGIC_VECTOR(RAMDATA_W-1 downto 0);
  signal ramwe_s        : STD_LOGIC;
  signal wmemsel_reg    : STD_LOGIC;	
  signal stage2_reg     : STD_LOGIC; 
  signal stage2_cnt_reg : UNSIGNED(RAMADRR_W-1 downto 0); 
  signal col_2_reg      : UNSIGNED(RAMADRR_W/2-1 downto 0); 
begin
  
  ramwe_sg:
  ramwe    <= ramwe_s;
  
  ramdatai_sg:
  ramdatai <= ramdatai_s;
  
  -- temporary
  odv_sg:
  odv      <= ramwe_s;
  dcto_sg:
  dcto     <= ramdatai_s(RAMDATA_W-1) & ramdatai_s(RAMDATA_W-1) & ramdatai_s;
  
  wmemsel_sg:
  wmemsel <= wmemsel_reg;
 
  process(clk,rst)
  begin
    if rst = '1' then
      inpcnt_reg     <= (others => '0');
      latchbuf_reg   <= (others => (others => '0')); 
      databuf_reg    <= (others => (others => '0'));
      stage2_reg     <= '0';
      stage2_cnt_reg <= (others => '1');
      ramdatai_s     <= (others => '0');
      ramwe_s        <= '0';
      ramwaddro      <= (others => '0');
      col_reg        <= (others => '0');
      row_reg        <= (others => '0');
      wmemsel_reg    <= '0';
      col_2_reg      <= (others => '0');
    elsif clk = '1' and clk'event then

      stage2_reg     <= '0';
      ramwe_s        <= '0';
 
      --------------------------------
      -- 1st stage
      --------------------------------
      if idv = '1' then
      
        inpcnt_reg    <= inpcnt_reg + 1;

        -- right shift input data
        latchbuf_reg(N-2 downto 0) <= latchbuf_reg(N-1 downto 1);
        latchbuf_reg(N-1)          <= SIGNED('0' & dcti) - LEVEL_SHIFT;

        if inpcnt_reg = N-1 then
          -- after this sum databuf_reg is in range of -256 to 254 (min to max) 
          databuf_reg(0)  <= latchbuf_reg(1)+(SIGNED('0' & dcti) - LEVEL_SHIFT);
          databuf_reg(1)  <= latchbuf_reg(2)+latchbuf_reg(7);
          databuf_reg(2)  <= latchbuf_reg(3)+latchbuf_reg(6);
          databuf_reg(3)  <= latchbuf_reg(4)+latchbuf_reg(5);
          databuf_reg(4)  <= latchbuf_reg(1)-(SIGNED('0' & dcti) - LEVEL_SHIFT);
          databuf_reg(5)  <= latchbuf_reg(2)-latchbuf_reg(7);
          databuf_reg(6)  <= latchbuf_reg(3)-latchbuf_reg(6);
          databuf_reg(7)  <= latchbuf_reg(4)-latchbuf_reg(5);
          stage2_reg      <= '1';
        end if;
      end if;
      --------------------------------
      
      --------------------------------
      -- 2nd stage
      --------------------------------
      if stage2_cnt_reg < N then
        
        if stage2_cnt_reg(0) = '0' then
          ramdatai_s <= STD_LOGIC_VECTOR(RESIZE
            (RESIZE(SIGNED(romedatao0),DA_W) + 
            (RESIZE(SIGNED(romedatao1),DA_W-1) & '0') +
            (RESIZE(SIGNED(romedatao2),DA_W-2) & "00") + 
            (RESIZE(SIGNED(romedatao3),DA_W-3) & "000") +
            (RESIZE(SIGNED(romedatao4),DA_W-4) & "0000") +
            (RESIZE(SIGNED(romedatao5),DA_W-5) & "00000") +
            (RESIZE(SIGNED(romedatao6),DA_W-6) & "000000") + 
            (RESIZE(SIGNED(romedatao7),DA_W-7) & "0000000") -
            (RESIZE(SIGNED(romedatao8),DA_W-8) & "00000000"),
                                        DA_W)(DA_W-1 downto 12));
        else
          ramdatai_s <= STD_LOGIC_VECTOR(RESIZE
            (RESIZE(SIGNED(romodatao0),DA_W) + 
            (RESIZE(SIGNED(romodatao1),DA_W-1) & '0') +
            (RESIZE(SIGNED(romodatao2),DA_W-2) & "00") + 
            (RESIZE(SIGNED(romodatao3),DA_W-3) & "000") +
            (RESIZE(SIGNED(romodatao4),DA_W-4) & "0000") +
            (RESIZE(SIGNED(romodatao5),DA_W-5) & "00000") +
            (RESIZE(SIGNED(romodatao6),DA_W-6) & "000000") + 
            (RESIZE(SIGNED(romodatao7),DA_W-7) & "0000000") -
            (RESIZE(SIGNED(romodatao8),DA_W-8) & "00000000"),
                                        DA_W)(DA_W-1 downto 12));
        end if;
        
        stage2_cnt_reg <= stage2_cnt_reg + 1;
        
        -- write RAM
        ramwe_s   <= '1';
        -- reverse col/row order for transposition purpose
        ramwaddro <= STD_LOGIC_VECTOR(col_2_reg & row_reg);
        -- increment column counter
        col_reg   <= col_reg + 1;
        col_2_reg <= col_2_reg + 1;
        
        -- finished processing one input row
        if col_reg = 0 then
          row_reg         <= row_reg + 1;
          -- switch to 2nd memory
          if row_reg = N - 1 then
            wmemsel_reg <= not wmemsel_reg;
            col_reg         <= (others => '0');
          end if;
        end if;  
 
      end if;
      
      if stage2_reg = '1' then
        stage2_cnt_reg <= (others => '0');
        col_reg        <= (0=>'1',others => '0');
        col_2_reg      <= (others => '0');
      end if;
      ----------------------------------    
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
  romeaddro4  <= STD_LOGIC_VECTOR( col_reg(RAMADRR_W/2-1 downto 1)) & 
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
    
  
end RTL;
--------------------------------------------------------------------------------
