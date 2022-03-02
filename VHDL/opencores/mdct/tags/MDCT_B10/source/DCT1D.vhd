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
      reqwrfail    : in STD_LOGIC;

      ready        : out STD_LOGIC; -- read from FIFO
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
      requestwr    : out STD_LOGIC;
      releasewr    : out STD_LOGIC		
		);
end DCT1D;

--------------------------------------------------------------------------------
-- ARCHITECTURE
--------------------------------------------------------------------------------
architecture RTL of DCT1D is   

  type STATE_T is 
  (
    IDLE,
    GET_ROM,
    SUM,
    WRITE_ODD
  );
  
  type ISTATE_T is 
  (
    IDLE_I,
    ACQUIRE_1ROW,
    WAITF
  );
  
  type INPUT_DATA is array (N-1 downto 0) of SIGNED(IP_W downto 0);
  
  signal ready_reg      : STD_LOGIC;
  signal databuf_reg    : INPUT_DATA;
  signal latchbuf_reg   : INPUT_DATA;
  signal col_reg        : UNSIGNED(RAMADRR_W/2-1 downto 0);
  signal row_reg        : UNSIGNED(RAMADRR_W/2-1 downto 0);
  signal inpcnt_reg     : UNSIGNED(2 downto 0);
  signal state_reg      : STATE_T;
  signal istate_reg     : ISTATE_T;
  signal cnt_reg        : UNSIGNED(3 downto 0);
  signal ramdatai_s     : STD_LOGIC_VECTOR(RAMDATA_W-1 downto 0);
  signal ramwe_s        : STD_LOGIC;
  signal latch_done_reg : STD_LOGIC;	
  signal requestwr_reg  : STD_LOGIC;	
  signal releasewr_reg  : STD_LOGIC;
  signal ready_prev_reg : STD_LOGIC;	
  signal completed_reg  : STD_LOGIC;
  signal col_tmp_reg    : UNSIGNED(RAMADRR_W/2-1 downto 0);    
begin
  
  ready_sg:  
  ready    <= ready_reg;
  
  ramwe_sg:
  ramwe    <= ramwe_s;
  
  ramdatai_sg:
  ramdatai <= ramdatai_s;
  
  -- temporary
  odv_sg:
  odv      <= ramwe_s;
  dcto_sg:
  dcto     <= ramdatai_s(RAMDATA_W-1) & ramdatai_s(RAMDATA_W-1) & ramdatai_s;
  
  releasewr_sg:
  releasewr <= releasewr_reg;
  requestwr_sg:
  requestwr <= requestwr_reg;
  
  --------------------------------------
  -- PROCESS
  --------------------------------------
  GET_PROC : process(rst,clk)
  begin
    if rst = '1' then   
      inpcnt_reg     <= (others => '0'); 
      ready_reg      <= '0'; 
      latchbuf_reg   <= (others => (others => '0'));
      istate_reg     <= IDLE_I; 
      latch_done_reg <= '0';
      requestwr_reg  <= '0';
      ready_prev_reg <= '0';
    elsif clk = '1' and clk'event then
    
      ready_prev_reg <= ready_reg;
      
      case istate_reg is
        
        when IDLE_I =>
          if idv = '1' then
            requestwr_reg <= '1';
          end if;
          if requestwr_reg = '1' then
            requestwr_reg <= '0';
            istate_reg <= ACQUIRE_1ROW;
          end if;    
      
        when ACQUIRE_1ROW =>
          
          if idv = '1' then 
            -- read next data from input FIFO
            ready_reg  <= '1'; 
            
            if ready_reg = '1' then
              -- right shift input data
              latchbuf_reg(N-2 downto 0) <= latchbuf_reg(N-1 downto 1);
              latchbuf_reg(N-1)          <= SIGNED('0' & dcti) - LEVEL_SHIFT;       
              
              inpcnt_reg   <= inpcnt_reg + 1;
             
              if inpcnt_reg = N-1 then
                latch_done_reg <= '1';
                ready_reg  <= '0';
                istate_reg <= WAITF;
              end if;
            end if;
          else
            ready_reg  <= '0';
          end if; 

          -- failure to allocate any memory buffer
          if reqwrfail = '1' then
          -- restart allocation procedure
            istate_reg  <= IDLE_I;
            ready_reg   <= '0';
          end if;             
        
        when WAITF =>
          -- wait until DCT1D_PROC process 1D DCT computation 
          -- before latching new 8 input words
          if state_reg = IDLE then
            latch_done_reg <= '0';
            if completed_reg = '1' then
              istate_reg <= IDLE_I;
            else
              istate_reg <= ACQUIRE_1ROW;
            end if;
          end if;    
        when others =>
          istate_reg <= IDLE_I;
      end case;     
    end if;  
  end process;
  
  --------------------------------------
  -- PROCESS
  --------------------------------------
  DCT1D_PROC: process(rst, clk)
  begin
    if rst = '1' then
      col_reg       <= (others => '0');
      row_reg       <= (others => '0');  
      state_reg     <= IDLE;
      cnt_reg       <= (others => '0'); 
      databuf_reg   <= (others => (others => '0')); 
      romeaddro0    <= (others => '0');
      romeaddro1    <= (others => '0');
      romeaddro2    <= (others => '0');
      romeaddro3    <= (others => '0');
      romeaddro4    <= (others => '0');
      romeaddro5    <= (others => '0');
      romeaddro6    <= (others => '0');
      romeaddro7    <= (others => '0');
      romeaddro8    <= (others => '0');
      romoaddro0    <= (others => '0');
      romoaddro1    <= (others => '0');
      romoaddro2    <= (others => '0');
      romoaddro3    <= (others => '0');
      romoaddro4    <= (others => '0');
      romoaddro5    <= (others => '0');
      romoaddro6    <= (others => '0');
      romoaddro7    <= (others => '0');
      romoaddro8    <= (others => '0');
      ramwaddro     <= (others => '0');
      ramdatai_s    <= (others => '0');
      ramwe_s       <= '0'; 
      releasewr_reg <= '0';
      completed_reg <= '0';
      col_tmp_reg   <= (others => '0');
    elsif rising_edge(clk) then	
      
      case state_reg is
        
        ----------------------
        -- wait for input data
        ----------------------
        when IDLE =>
            
          releasewr_reg <= '0';  
          ramwe_s       <= '0'; 
          -- wait until 8 input words are latched in latchbuf_reg
          -- by GET_PROC                    
          if latch_done_reg = '1' then
            completed_reg   <= '0';
            -- after this sum databuf_reg is in range of -256 to 254 (min to max) 
            databuf_reg(0)  <= latchbuf_reg(0)+latchbuf_reg(7);
            databuf_reg(1)  <= latchbuf_reg(1)+latchbuf_reg(6);
            databuf_reg(2)  <= latchbuf_reg(2)+latchbuf_reg(5);
            databuf_reg(3)  <= latchbuf_reg(3)+latchbuf_reg(4);
            databuf_reg(4)  <= latchbuf_reg(0)-latchbuf_reg(7);
            databuf_reg(5)  <= latchbuf_reg(1)-latchbuf_reg(6);
            databuf_reg(6)  <= latchbuf_reg(2)-latchbuf_reg(5);
            databuf_reg(7)  <= latchbuf_reg(3)-latchbuf_reg(4);
            state_reg   <= GET_ROM;
          end if;    

        ----------------------
        -- get MAC results from ROM even and ROM odd memories
        ----------------------
        when GET_ROM => 
            
           ramwe_s   <='0';   
           
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
           romeaddro4  <= STD_LOGIC_VECTOR(col_reg(RAMADRR_W/2-1 downto 1)) & 
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
                     
           state_reg <= SUM;
           
        ---------------------
        -- do distributed arithmetic sum on even part,
        -- write even part to RAM
        ---------------------  
        when SUM =>
           
          ramdatai_s <= STD_LOGIC_VECTOR(RESIZE
            (RESIZE(SIGNED(romedatao0),DA_W) + 
            (RESIZE(SIGNED(romedatao1),DA_W-1) & '0') +
            (RESIZE(SIGNED(romedatao2),DA_W-2) & "00") + 
            (RESIZE(SIGNED(romedatao3),DA_W-3) & "000") +
            (RESIZE(SIGNED(romedatao4),DA_W-4) & "0000") +
            (RESIZE(SIGNED(romedatao5),DA_W-5) & "00000") +
            (RESIZE(SIGNED(romedatao6),DA_W-6) & "000000") + 
            (RESIZE(SIGNED(romedatao7),DA_W-7) & "0000000") -
            (RESIZE(SIGNED(romedatao8),DA_W-8) & "00000000"),DA_W)(DA_W-1 downto 12));
         
          -- write even part
          ramwe_s   <= '1';
          -- reverse col/row order for transposition purpose
          ramwaddro <= STD_LOGIC_VECTOR(col_reg & row_reg);
           
          col_reg <= col_reg + 1;
          col_tmp_reg <= col_reg + 2;
         
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
          state_reg <= WRITE_ODD; 
    
        ---------------------
        -- do distributed arithmetic sum on odd part,
        -- write odd part to RAM
        ---------------------
        when WRITE_ODD =>  
          
          -- write odd part
          --ramwe_s   <= '1';
             
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
         
          -- write odd part
          -- reverse col/row order for transposition purpose
          ramwaddro <= STD_LOGIC_VECTOR(col_reg & row_reg);    
          
          -- move to next column
          col_reg <= col_reg + 1;
              
          -- finished processing one input row
          if col_reg = N - 1 then
            row_reg         <= row_reg + 1;
            col_reg         <= (others => '0');   
            if row_reg = N - 1 then
              releasewr_reg <= '1';
              completed_reg <= '1';
            end if;
            state_reg  <= IDLE;
          else
            
            -- read precomputed MAC results from LUT
            romeaddro0 <= STD_LOGIC_VECTOR(col_tmp_reg(RAMADRR_W/2-1 downto 1)) & 
                     databuf_reg(0)(0) & 
                     databuf_reg(1)(0) &
                     databuf_reg(2)(0) &
                     databuf_reg(3)(0);
            romeaddro1 <= STD_LOGIC_VECTOR(col_tmp_reg(RAMADRR_W/2-1 downto 1)) & 
                     databuf_reg(0)(1) & 
                     databuf_reg(1)(1) &
                     databuf_reg(2)(1) &
                     databuf_reg(3)(1);
            romeaddro2 <= STD_LOGIC_VECTOR(col_tmp_reg(RAMADRR_W/2-1 downto 1)) & 
                     databuf_reg(0)(2) & 
                     databuf_reg(1)(2) &
                     databuf_reg(2)(2) &
                     databuf_reg(3)(2);          
            romeaddro3 <= STD_LOGIC_VECTOR(col_tmp_reg(RAMADRR_W/2-1 downto 1)) & 
                     databuf_reg(0)(3) & 
                     databuf_reg(1)(3) &
                     databuf_reg(2)(3) &
                     databuf_reg(3)(3);                    
            romeaddro4  <= STD_LOGIC_VECTOR(col_tmp_reg(RAMADRR_W/2-1 downto 1)) & 
                     databuf_reg(0)(4) & 
                     databuf_reg(1)(4) &
                     databuf_reg(2)(4) &
                     databuf_reg(3)(4); 
            romeaddro5  <= STD_LOGIC_VECTOR(col_tmp_reg(RAMADRR_W/2-1 downto 1)) & 
                     databuf_reg(0)(5) & 
                     databuf_reg(1)(5) &
                     databuf_reg(2)(5) &
                     databuf_reg(3)(5);
            romeaddro6  <= STD_LOGIC_VECTOR(col_tmp_reg(RAMADRR_W/2-1 downto 1)) & 
                     databuf_reg(0)(6) & 
                     databuf_reg(1)(6) &
                     databuf_reg(2)(6) &
                     databuf_reg(3)(6);
            romeaddro7  <= STD_LOGIC_VECTOR(col_tmp_reg(RAMADRR_W/2-1 downto 1)) & 
                     databuf_reg(0)(7) & 
                     databuf_reg(1)(7) &
                     databuf_reg(2)(7) &
                     databuf_reg(3)(7);                                       
            romeaddro8  <= STD_LOGIC_VECTOR(col_tmp_reg(RAMADRR_W/2-1 downto 1)) & 
                     databuf_reg(0)(8) & 
                     databuf_reg(1)(8) &
                     databuf_reg(2)(8) &
                     databuf_reg(3)(8);
                     
            state_reg <= SUM;

          end if;
        --------------------------------
        -- OTHERS
        --------------------------------
        when others =>
          state_reg  <= IDLE;
      end case;
    end if;
  end process;
  
end RTL;
--------------------------------------------------------------------------------
