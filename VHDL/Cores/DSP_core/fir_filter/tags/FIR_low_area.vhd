
--  CREATION DATE .......:  02 Jul 2007 (Filtro_FIR.vhd)
--  AUTHOR ..............:  DIEGO PARDO (arroxo2@yahoo.es)
--  REVISION ............:  2.0
--  LAST UPDATE .........:  08 April 2015
--  UPDATED BY ..........:  DIEGO PARDO 

--  TITLE "CONFIGURABLE FIR FILTER";
--
--  Generic VHDL (suitable for ALTERA, XILINX, MICROSEMI, etc)
--  Low resources occupation (fixed-point implementation)
--


--=============================================================================
--============================= LOCAL PACKAGE =================================
--=============================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;
USE ieee.math_real.all;     


PACKAGE fir_package IS

    CONSTANT max_coef: NATURAL:= 128;   -- (increase if needed)
    TYPE COEFF_ARRAY IS ARRAY (0 to max_coef-1) OF REAL;
    FUNCTION decimal_to_signed (c_real: IN REAL; CONSTANT precision: IN NATURAL) RETURN SIGNED;

END fir_package;


PACKAGE body fir_package IS

    FUNCTION decimal_to_signed (c_real: IN REAL; CONSTANT precision: IN NATURAL) RETURN SIGNED IS
    -- SIGNED = REAL / 2^(-precision) = REAL * 2^precision, with IEEE rounding
        CONSTANT RESOLUCION : REAL := "**"(2,REAL(INTEGER(precision)));
    BEGIN
        RETURN (SIGNED(CONV_STD_LOGIC_VECTOR(INTEGER(ROUND ("*"(c_real,RESOLUCION))),precision+1)));
    END FUNCTION;
    
END fir_package;



--=============================================================================
--================================== ENTITY ===================================
--=============================================================================

LIBRARY work;
USE WORK.fir_package.all;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;
USE ieee.math_real.all;     

--.............................................................................
-- GAIN                1.0
-- SATURATION CONTROL  Yes (output)
-- OUTPUT ROUNDING     Yes (IEEE)
-- IMPLEMENTED BY      Fixed-Point (configurable resolution)
-- 3rd-PARTY IPs       No (generic VHDL)
--.............................................................................

ENTITY FIR_low_area IS
    GENERIC(        
        data_length  : NATURAL     := 8;                   -- input/output length (number of bits)
        data_signed  : BOOLEAN     := false;               -- input/output type (signed or unsigned)
        improv_t     : BOOLEAN     := false;               -- minimal timing improvement by adding one extra output cycle delay (use only if needed)        
        bits_resol   : NATURAL     := 16;                  -- number of bits for the internal operations with decimals in fixed point. Recommended: bits_resol > taps. THIS SETTING IS CRITICAL FOR P&R RESULTS (MAX FREQ)
        taps         : NATURAL     := 5;                   -- =order+1, 2 coefficients as minimum (order=1)
        coefficients : COEFF_ARRAY :=(                     -- normalized coefficients bi: (bo,b1, ..., bN). They must be symmetric (but sign)
                                     -0.11735685282030676,
                                      0.23471370564061372,
                                      0.7066280917835991,
                                      0.23471370564061372,
                                     -0.11735685282030676,
                                      OTHERS=>0.0)         -- (always end with "others=>0.0")
    );
    PORT(
        areset       : IN    STD_LOGIC;                    -- active high                            
        sreset       : IN    STD_LOGIC;                    -- active high    
        clock_fs     : IN    STD_LOGIC;                              
        enable       : IN    STD_LOGIC;                                  
        xn           : IN    STD_LOGIC_VECTOR(data_length-1 DOWNTO 0);   -- FILTER INPUT  (any fixed-point format, e.g. whole numbers)
        yn           : OUT   STD_LOGIC_VECTOR(data_length-1 DOWNTO 0)    -- FILTER OUTPUT (keeps same fixed-point format of input)
    );
END FIR_low_area;



ARCHITECTURE FIR_low_area_arch OF FIR_low_area IS

    type ENTRADA_xn IS ARRAY (taps-2 DOWNTO 0) OF SIGNED(data_length DOWNTO 0);   -- A(data_length,0) : x[n-k]
    type VALORES_h  IS ARRAY (taps-1 DOWNTO 0) OF SIGNED(bits_resol  DOWNTO 0);   -- A(0,bits_resol)  : h[n-k]

    SIGNAL REGISTRO_xn  : ENTRADA_xn;       
        
    SIGNAL yn_1, yn_2   : SIGNED (data_length+1+bits_resol+1+(taps-2) DOWNTO 0);
    SIGNAL yn_aux       : SIGNED (data_length+1+bits_resol+1+(taps-2) DOWNTO 0);  -- yn_1 + yn_2
    SIGNAL yn_comb      : SIGNED (data_length+1+bits_resol+1+(taps-2) DOWNTO 0); 
    SIGNAL yn_sync      : SIGNED (data_length+1+bits_resol+1+(taps-2) DOWNTO 0); 
    
    SIGNAL yn_unsigned  : STD_LOGIC_VECTOR(data_length-1 DOWNTO 0);
    SIGNAL yn_signed    : STD_LOGIC_VECTOR(data_length-1 DOWNTO 0);  

    CONSTANT SIGNED_MAX : INTEGER :=      2**(yn'length-1)-1;
    CONSTANT SIGNED_MIN : INTEGER := -1 * 2**(yn'length-1);

                                                                          
BEGIN


    ASSERT (bits_resol >= 4) 
    REPORT "PLEASE INCREASE RESOLUTION BITS (result will be poor)" SEVERITY FAILURE;
    
	-- pragma translate_off
	process
	  VARIABLE sum_coeff : real;
	begin	  
      sum_coeff := 0.0;
      FOR ind IN 0 TO (taps-1) LOOP
        sum_coeff := sum_coeff + coefficients(ind);
      END LOOP;
      ASSERT sum_coeff = 1.0
      REPORT "COEFFICIENTS ARE NOT NORMALIZED" SEVERITY WARNING;     
	  wait;
	end process;
	-- pragma translate_on
	
	
    -- =======================================================================================
    --  HALF FILTERING OPERATIONS (1/2)  
    --  (DOES NOT INCLUDE INITIAL AND FINAL COEFFICIENTS, INCLUDES CENTRE COEFFICIENT (WHEN "taps" EVEN)
    -- =======================================================================================
	
    process1:
    PROCESS (clock_fs, areset)                          
        VARIABLE xn_a_pares : SIGNED (data_length+1 DOWNTO 0);                            -- to sum x[n-k] with symmetric coefficients
        VARIABLE REGISTRO_h : VALORES_h := (OTHERS => (OTHERS => '0'));                   -- it stores the coefficients (avoids registers)
        VARIABLE producto   : SIGNED (data_length+1+bits_resol+1 DOWNTO 0);               -- product of xn_a_pares by symmetric coefficient
        VARIABLE yn_aux     : SIGNED (data_length+1+bits_resol+1+(taps-2) DOWNTO 0); -- partial sum
        VARIABLE signos_bi  : STD_LOGIC_VECTOR (1 DOWNTO 0);                              -- signs of the symmetric coefficients             
        VARIABLE indice1    : NATURAL;
        VARIABLE margen     : NATURAL;

    BEGIN
        IF (areset = '1') THEN
            yn_1 <= (OTHERS => '0');
			       
        ELSIF rising_edge(clock_fs) THEN
          IF (sreset = '1') THEN
            yn_1 <= (OTHERS => '0');
          ELSE
          
            IF (enable = '1') THEN
            
                -- variable avoids h[n] register, REGISTRO_h(0) = bN 
                FOR ind IN 0 TO (taps-1) LOOP
                    REGISTRO_h(ind) := decimal_to_signed (coefficients(taps-1-ind),bits_resol);
                END LOOP;           
   
                yn_aux := (OTHERS => '0');
                
                -- symmetric coefficients (but first and last ones):
                -- In this cycle x[n-k] has not been applied yet to the shift register of x[n]
                IF (taps > 3) THEN
                
                    indice1 := (taps/2)+(taps MOD 2);
                    margen  := ((taps-1)-(taps/2))/2 - (taps MOD 2);
                
                    FOR i IN indice1 TO (indice1 + margen) LOOP
                        
                        -- symmetric bi signs 
                        signos_bi(1):= REGISTRO_h(i)(bits_resol);
                        signos_bi(0):= REGISTRO_h(taps-1-i)(bits_resol);
                                      
                        CASE signos_bi IS
                            WHEN "00"   => xn_a_pares:= "+"( CONV_SIGNED(conv_integer(signed(REGISTRO_xn(i))),data_length+2),  CONV_SIGNED(conv_integer(signed(REGISTRO_xn(taps-1-i))),data_length+2));
                            WHEN "01"   => xn_a_pares:= "+"( CONV_SIGNED(conv_integer(signed(REGISTRO_xn(i))),data_length+2), -CONV_SIGNED(conv_integer(signed(REGISTRO_xn(taps-1-i))),data_length+2));
                            WHEN "10"   => xn_a_pares:= "+"(-CONV_SIGNED(conv_integer(signed(REGISTRO_xn(i))),data_length+2),  CONV_SIGNED(conv_integer(signed(REGISTRO_xn(taps-1-i))),data_length+2));
                            WHEN OTHERS => xn_a_pares:= "+"(-CONV_SIGNED(conv_integer(signed(REGISTRO_xn(i))),data_length+2), -CONV_SIGNED(conv_integer(signed(REGISTRO_xn(taps-1-i))),data_length+2));
                        END CASE;               
            
                        producto := "*"(xn_a_pares, ABS(REGISTRO_h(i)));
                        yn_aux   := "+"(yn_aux, producto);
                    END LOOP;       
                END IF;
                
                --------------------------------------------------------------- 
                -- central coefficient operation (when taps is even)
                ---------------------------------------------------------------
                -- non-symmetric coefficient
                
                IF (taps MOD 2)/=0 THEN
                    producto := "*"(CONV_SIGNED(conv_integer(signed(REGISTRO_xn(taps/2))),data_length+2), REGISTRO_h(taps/2));                    
                    yn_aux   := "+"(yn_aux, producto);
                END IF; 
                            
                --------------------------------------------------------------- 
                -- output of processo1
                ---------------------------------------------------------------
                -- yn_1 has decimal part (bits_resol bits)
                
                yn_1 <= yn_aux;        
                            
            END IF;     
          END IF;
        END IF;         
    END PROCESS process1;

    
    -- =======================================================================================
    --  HALF FILTERING OPERATIONS (2/2)  
    --  (INCLUDINF INITIAL AND FINAL COEFFICIENTS)
    -- =======================================================================================
    
    process2:
    PROCESS (clock_fs, areset)                         
        VARIABLE xn_a_pares : SIGNED (data_length+1 DOWNTO 0);                            -- to sum x[n-k] with symmetric coefficients
        VARIABLE REGISTRO_h : VALORES_h := (OTHERS => (OTHERS => '0'));                   -- it stores the coefficients (avoids registers)
        VARIABLE producto   : SIGNED (data_length+1+bits_resol+1 DOWNTO 0);               -- product of xn_a_pares by symmetric coefficient
        VARIABLE yn_aux     : SIGNED (data_length+1+bits_resol+1+(taps-2) DOWNTO 0); -- partial sum
        VARIABLE signos_bi  : STD_LOGIC_VECTOR (1 DOWNTO 0);                              -- signs of the symmetric coefficients
        VARIABLE indice1    : NATURAL;
        VARIABLE margen     : NATURAL;
        
    BEGIN
        IF (areset = '1') THEN
            yn_2 <= (OTHERS => '0');
        
        ELSIF rising_edge(clock_fs) THEN
          IF (sreset = '1') THEN
            yn_2 <= (OTHERS => '0');
          ELSE
          
            IF (enable = '1') THEN
            
                -- variable avoids h[n] register, REGISTRO_h(0) = bN   
                FOR ind IN 0 TO (taps-1) LOOP
                    REGISTRO_h(ind) := decimal_to_signed (coefficients(taps-1-ind),bits_resol);
                END LOOP;           
                             
            
                yn_aux := (OTHERS => '0');
                
                -- symmetric coefficients (but first and last ones). When taps < 7 the operations are resolved by process1:
                -- In this cycle x[n-k] has not been applied yet to the shift register of x[n]
                IF (taps > 6) THEN
                
                    indice1 := (taps/2)+(taps MOD 2);
                    margen  := ((taps-1)-(taps/2))/2 - (taps MOD 2);
                
                    FOR i IN (indice1 + margen + 1) TO (taps-2) LOOP
                        
                        -- symmetric bi signs 
                        signos_bi(1):= REGISTRO_h(i)(bits_resol);
                        signos_bi(0):= REGISTRO_h(taps-1-i)(bits_resol);
                    
                        CASE signos_bi IS                           
                            WHEN "00"   => xn_a_pares:= "+"( CONV_SIGNED(conv_integer(signed(REGISTRO_xn(i))),data_length+2),  CONV_SIGNED(conv_integer(signed(REGISTRO_xn(taps-1-i))),data_length+2));                          
                            WHEN "01"   => xn_a_pares:= "+"( CONV_SIGNED(conv_integer(signed(REGISTRO_xn(i))),data_length+2), -CONV_SIGNED(conv_integer(signed(REGISTRO_xn(taps-1-i))),data_length+2));                          
                            WHEN "10"   => xn_a_pares:= "+"(-CONV_SIGNED(conv_integer(signed(REGISTRO_xn(i))),data_length+2),  CONV_SIGNED(conv_integer(signed(REGISTRO_xn(taps-1-i))),data_length+2));                      
                            WHEN OTHERS => xn_a_pares:= "+"(-CONV_SIGNED(conv_integer(signed(REGISTRO_xn(i))),data_length+2), -CONV_SIGNED(conv_integer(signed(REGISTRO_xn(taps-1-i))),data_length+2));
                        END CASE;           
                
                        producto:= "*"(xn_a_pares, ABS(REGISTRO_h(i)));
                        yn_aux  := "+"(yn_aux, producto);
                    END LOOP;       
                END IF;
                    
                ----------------------------------------------------------------                                                
                -- first and last coefficients operation (symmetric)
                ----------------------------------------------------------------               
                -- The initial coefficient multiplies x[n] (not registered yet)             
                
                signos_bi(1):= REGISTRO_h(taps-1)(bits_resol);
                signos_bi(0):= REGISTRO_h(0)(bits_resol);
                
                CASE signos_bi IS
                    
                    WHEN "00"   => if (data_signed = true) then
                                     xn_a_pares:= "+"( CONV_SIGNED(conv_integer(  signed(xn)),data_length+2),  CONV_SIGNED(conv_integer(signed(REGISTRO_xn(0))),data_length+2));                                
                                   else
                                     xn_a_pares:= "+"( CONV_SIGNED(conv_integer(unsigned(xn)),data_length+2),  CONV_SIGNED(conv_integer(signed(REGISTRO_xn(0))),data_length+2));
                                   end if;
                    WHEN "01"   => if (data_signed = true) then
                                     xn_a_pares:= "+"( CONV_SIGNED(conv_integer(  signed(xn)),data_length+2), -CONV_SIGNED(conv_integer(signed(REGISTRO_xn(0))),data_length+2));                                
                                   else
                                     xn_a_pares:= "+"( CONV_SIGNED(conv_integer(unsigned(xn)),data_length+2), -CONV_SIGNED(conv_integer(signed(REGISTRO_xn(0))),data_length+2));
                                   end if;    
                    WHEN "10"   => if (data_signed = true) then
                                     xn_a_pares:= "+"(-CONV_SIGNED(conv_integer(  signed(xn)),data_length+2),  CONV_SIGNED(conv_integer(signed(REGISTRO_xn(0))),data_length+2));                                
                                   else
                                     xn_a_pares:= "+"(-CONV_SIGNED(conv_integer(unsigned(xn)),data_length+2),  CONV_SIGNED(conv_integer(signed(REGISTRO_xn(0))),data_length+2));
                                   end if;
                    WHEN OTHERS => if (data_signed = true) then
                                     xn_a_pares:= "+"(-CONV_SIGNED(conv_integer(  signed(xn)),data_length+2), -CONV_SIGNED(conv_integer(signed(REGISTRO_xn(0))),data_length+2));                                
                                   else
                                     xn_a_pares:= "+"(-CONV_SIGNED(conv_integer(unsigned(xn)),data_length+2), -CONV_SIGNED(conv_integer(signed(REGISTRO_xn(0))),data_length+2));
                                   end if;
                END CASE;                                   
                                        
                producto := "*"(xn_a_pares, ABS(REGISTRO_h(taps-1)));
                yn_aux   := "+"(yn_aux, producto);        
               
                --------------------------------------------------------------- 
                -- output of processo2
                ---------------------------------------------------------------             
                -- yn_2 has decimal part (bits_resol bits)
                
                yn_2 <= yn_aux;                     
                            
            END IF;     
          END IF;
        END IF;         
    END PROCESS process2;
    
    
    -- =======================================================================================
    --  SHIT REGISTER: x[n-k]
    -- =======================================================================================
        
    process_reg:
    PROCESS (clock_fs, areset)  
    BEGIN   
        IF (areset = '1') THEN
            REGISTRO_xn <= (OTHERS => (OTHERS => '0'));
                    
        ELSIF rising_edge(clock_fs) THEN
          IF (sreset = '1') THEN
            REGISTRO_xn <= (OTHERS => (OTHERS => '0'));         
          ELSE
             
            IF (enable = '1')THEN
            
                ---------------------------------------------------------------
                -- x[n-k], it is not applied instantaneously (scheduled)  
                ---------------------------------------------------------------             
                -- right-shift
                
                FOR i IN 0 TO (taps-3) LOOP        -- (ignored when taps=2)
                    REGISTRO_xn(i)<= REGISTRO_xn(i+1);
                END LOOP;
                
                if (data_signed = true) then
                  REGISTRO_xn(taps-2) <= CONV_SIGNED(conv_integer(  signed(xn)),data_length+1); 
                else
                  REGISTRO_xn(taps-2) <= CONV_SIGNED(conv_integer(unsigned(xn)),data_length+1);
                end if;
                    
            END IF;
          END IF;
        END IF;
        
    END PROCESS process_reg;

    
    -- =======================================================================================
    --  OUTPUT (neither saturation control nor IEEE rounding)
    -- =======================================================================================
    -- SUM of process1 and process2 outputs
        
    yn_comb <= yn_1 + yn_2;     
    yn_sync <= yn_1 + yn_2 when rising_edge(clock_fs);
    
    yn_aux  <= yn_sync when (improv_t = true) else yn_comb;
    
    
    --------------------------------------------------------------- 
    -- OUTPUT (with saturation control and IEEE rounding)
    ---------------------------------------------------------------

    -- yn_aux of type A(_,bits_resol): 
    --                  whole part:   'LEFT downto bits_resol 
    --                  decimal part: (bits_resol-1) downto 0           
    --
    --                 |<------------------------------------------ yn_aux ------------------------------------------->|
    --                  [yn_aux'left] ..... [bits_resol+data_length-1] ..... [bits_resol]   [bits_resol-1] .........[0]
    --                                     |<------------ yn_signed/unsigned ------------>|<----- (decimal part) ----->|

    
    -- unsigned output:
    yn_unsigned <=  
      (OTHERS => '0') WHEN yn_aux(bits_resol+data_length+1) = '1'                                                                                                                                          ELSE -- negative overflow 
      (OTHERS => '1') WHEN yn_aux(bits_resol+data_length)   = '1'                                                                                                                                          ELSE -- positive overflow                                                                          
      STD_LOGIC_VECTOR(yn_aux(bits_resol+data_length-1 DOWNTO bits_resol))+1 WHEN yn_aux(bits_resol-1) = '1' and STD_LOGIC_VECTOR(yn_aux(bits_resol+data_length-1 downto bits_resol)) /= (yn'range => '1') ELSE -- positive IEEE rounding (avoids positive overflow)
      STD_LOGIC_VECTOR(yn_aux(bits_resol+data_length-1 DOWNTO bits_resol));                                                                                                                                     -- truncated
 
    -- signed output:
    yn_signed   <=  
      STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED_MIN,data_length)) WHEN yn_aux(bits_resol+data_length) = '1' and yn_aux(bits_resol+data_length-1) = '0'                                              ELSE -- negative overflow 
      STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED_MAX,data_length)) WHEN yn_aux(bits_resol+data_length) = '0' and yn_aux(bits_resol+data_length-1) = '1'                                              ELSE -- positive overflow
      STD_LOGIC_VECTOR(yn_aux(bits_resol+data_length-1 DOWNTO bits_resol))+1 WHEN yn_aux(bits_resol-1) = '1' and                                                                                   -- positive or negative IEEE rounding (avoids positive overflow)
        (yn_aux(bits_resol+data_length-1) = '1' or STD_LOGIC_VECTOR(yn_aux(bits_resol+data_length-2 downto bits_resol)) /= (yn_aux(bits_resol+data_length-2 downto bits_resol)'range => '1')) ELSE    
      STD_LOGIC_VECTOR(signed(yn_aux(bits_resol+data_length-1 DOWNTO bits_resol)));                                                                                                                -- truncated
    
    -- FINAL OUTPUT
    yn <= yn_signed when (data_signed = true) else yn_unsigned;
                     

END FIR_low_area_arch;



--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


-------------------------------------------------------------------------------
--                                DESCRIPTION 
-------------------------------------------------------------------------------
--          
------------------
-- DELAY
------------------
--  clock_fs period x taps
--
------------------
-- AREA
------------------
--  bits_resol  stablishes the precision of the filtering operations (resources)
--
------------------
-- OUTPUT ERROR
------------------
--  maximum output error: 
-- 
--             ------------------------------------------------------
--            | taps * [2^(-bits_resol)] * [(2^data_length)-1)] |
--             ------------------------------------------------------
-- (taps = order+1)
--
------------------------------------------------------------------------------
-- Operations:
------------------------------------------------------------------------------
--
--          h[n] = A(0,bits_resol) with resolution = 2^(-bits_resol)
--          x[n] = A(data_length,0)
--
--  y[n] = sum{x[n-k] x h[k]}
--          x[n-i] x h[i] = A(data_length,0) x A(0,bits_resol) = A(data_length+0+1,bits_resol)
--          y[n] = A(data_length+1+[taps]-1,bits_resol) 
--
------------------------------------------------------------------------------
-- Implementation:
------------------------------------------------------------------------------
--
--  -FIR direct form II-
--
--  3 process() in parallel:
--
--    process1():    1/2 part of the filtering operations
--    process2():    2/2 part of the filtering operations
--    process_reg(): x[n-k]
--
--  FIR filters have symmetric coefficients (but sign):
--
--  e.g. taps=5 and positive h[n] coefficients: 
--      x[n-3]*h(3) + x[n-1]*h[1] = (x[n-3]+x[n-1])*h[3], because h[1]=h[3]
--
---------------
-- 
--  x: products by means of process1() and centre coefficient
--  o: products by means of process2() and first-last coefficients
--
--
--   taps  bi                              prod process1()               prod process2()
--
--      2       x x                             0                             1   bo=b1
--      3       o x o                           1   b1                        1   bo=b2
--      4       o x x o                         1   b1=b2                     1   bo=b3       
--      5       o x x x o                       2   b1=b3, b2                 1   bo=b4       
--      6       o x x x x o                     2   b1=b4, b2=b3              1   bo=b5           
--      7       o o x x x o o                   2   b2=b4, b3                 2   bo=b6,  b1=b5 
--      8       o o x x x x o o                 2   b2=b5, b3=b4              2   bo=b7,  b1=b6
--      9       o o x x x x x o o               3   b2=b6, b3=b5, b4          2   bo=b8,  b1=b7
--      10      o o x x x x x x o o             3   b2=b7, b3=b6, b4=b5       2   bo=b9,  b1=b8
--      11      o o o x x x x x o o o           3   b3=b7, b4=b6, b5          3   bo=b10, b1=b9,  b2=b8
--      12      o o o x x x x x x o o o         3   b3=b8, b4=b7, b5=b6       3   bo=b11, b1=b10, b2=b9
--      13      o o o x x x x x x x o o o       4   b3=b9, b4=b8, b5=b7, b6   3   bo=b12, b1=b11, b2=b10
--      14      o o o o x x x x x x o o o o     4   b4=b9, b5=b8, b6=b7       4   bo=b13, b1=b12, b2=b11, b3=b10
--      15      o o o o x x x x x x x o o o o   4   b4=b10,b5=b9, b6=b8, b7   4   bo=b14, b1=b13, b2=b12, b3=b11
--     (etc)...

-------------------------------------------------------------------------------
-- Fixed-Point Arithmetic: An Introduction
--   Randy Yates
--   March 3, 2001 11:52
-------------------------------------------------------------------------------
--
-- A(a,b):  a = whole part, b = decimal part
--  
--          length             = (a+b) +1 bits (sign)
--          resolution (steps) =  2^(-b)
--          maximum value      =  2^a - 2^(-b)
--          minimum value      = -2^(-a)
--
-- Operations:
--
--          A(x,y) * A(z,n)         =   A(x+z+1,y+n), length = (x+z+1+y+n) +1 bits (sign)
--          A(x,y) + A(x,y)         =   A(x+1,y)    , length = (x+1+y) +1 bits (sign)
--          A(x,y) + A(x,y) + A(x,y)=   A(x+2,y)    , length = (x+2+y) +1 bits (sign)
-- 

------------------------------------------------------------------------------          
--                 TYPES CONVERSION (OF CONSTANT VALUES)
------------------------------------------------------------------------------
--
--      REAL -> INTEGER -> STD_LOGIC_VECTOR -> SIGNED:
--
--          SIGNED(CONV_STD_LOGIC_VECTOR(INTEGER(ROUND(<real_value>))))
--
--      SIGNED -> STD_LOGIC_VECTOR -> INTEGER -> REAL:
--
--          ROUND(REAL(CONV_INTEGER(CONV_STD_LOGIC_VECTOR(<signed_value>))))
--
