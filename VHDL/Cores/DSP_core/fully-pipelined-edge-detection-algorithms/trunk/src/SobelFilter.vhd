----------------------------------------------------------------------------------
-- Company: 
-- Engineer: MUHAMMED KOCAOGLU
-- 
-- Create Date: 01/13/2022 10:56:24 PM
-- Design Name: 
-- Module Name: EdgeDetection - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: VHDL 2008
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
USE work.OperatorOverloading_pkg.ALL;
USE work.EdgeDetection_pkg.ALL;


ENTITY SobelFilter IS
    PORT (
        CLK                     : IN STD_LOGIC;
        EdgeDetection_Enable    : IN STD_LOGIC;
        EdgeDetection_Disable   : IN STD_LOGIC;
        EdgeDetection_Din       : IN array2D(0 TO 2)(7 DOWNTO 0);
        EdgeDetection_Dout      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        EdgeDetection_Ready     : OUT STD_LOGIC
    );
END SobelFilter;

ARCHITECTURE Behavioral OF SobelFilter IS

    signal Din_Buffer               : array3D(0 to 2)(0 to 2)(7 downto 0)   := (others => (others => (others => '0')));

    signal MultArray_Reg_x          : array3D(0 to 2)(0 to 2)(16 downto 0)  := (others => (others => (others => '0')));
    signal AddArray_Layer1_x        : array2D(0 to 2)(16 downto 0)          := (others => (others => '0'));
    signal AddArray_Layer2_x        : std_logic_vector(16 downto 0)         := (others => '0');
    signal Convolution_Res_x        : std_logic_vector(33 downto 0)         := (others => '0');

    signal MultArray_Reg_y          : array3D(0 to 2)(0 to 2)(16 downto 0)  := (others => (others => (others => '0')));
    signal AddArray_Layer1_y        : array2D(0 to 2)(16 downto 0)          := (others => (others => '0'));
    signal AddArray_Layer2_y        : std_logic_vector(16 downto 0)         := (others => '0');
    signal Convolution_Res_y        : std_logic_vector(33 downto 0)         := (others => '0');

    signal EdgeDetection_Dout_Reg   : STD_LOGIC_VECTOR(33 DOWNTO 0)         := (others => '0');

    TYPE states IS (
        S_IDLE,
        S_CONVOLVE
    );
    SIGNAL state : states := S_IDLE;


    constant Coeff_x : array3D(0 to 2)(0 to 2)(7 downto 0) := (
        (x"01", x"00", x"ff"),
        (x"02", x"00", x"fe"),
        (x"01", x"00", x"ff")
    );
    constant Coeff_y : array3D(0 to 2)(0 to 2)(7 downto 0) := (
        (x"01", x"02", x"01"),
        (x"00", x"00", x"00"),
        (x"ff", x"fe", x"ff")
    );

    signal cntr : integer range 0 to 7 := 0;
    signal cntrDisable : integer range 0 to 7 := 0;

BEGIN

    P_MAIN : PROCESS (CLK)
    BEGIN
        IF rising_edge(CLK) THEN
            CASE state IS
                WHEN S_IDLE =>
                    EdgeDetection_Ready <= '0';
                    IF EdgeDetection_Enable THEN
                        state <= S_CONVOLVE;
                        Din_Buffer(0)           <=  EdgeDetection_Din;
                        Din_Buffer(1 to 2)      <= Din_Buffer(0 to 1);
                        cntr                    <= 0;
                    END IF;

                WHEN S_CONVOLVE =>
                    Din_Buffer(0)               <=  EdgeDetection_Din;
                    Din_Buffer(1 to 2)          <= Din_Buffer(0 to 1);

                    MultArray_Reg_x             <= Coeff_x * ("0" & Din_Buffer);
                    AddArray_Layer1_x(0)        <= std_logic_vector(signed(MultArray_Reg_x(0)(0)) + signed(MultArray_Reg_x(0)(1))  + signed(MultArray_Reg_x(0)(2))); 
                    AddArray_Layer1_x(1)        <= std_logic_vector(signed(MultArray_Reg_x(1)(0)) + signed(MultArray_Reg_x(1)(1))  + signed(MultArray_Reg_x(1)(2))); 
                    AddArray_Layer1_x(2)        <= std_logic_vector(signed(MultArray_Reg_x(2)(0)) + signed(MultArray_Reg_x(2)(1))  + signed(MultArray_Reg_x(2)(2)));  
                    AddArray_Layer2_x           <= std_logic_vector(signed(AddArray_Layer1_x(0)) + signed(AddArray_Layer1_x(1)) + signed(AddArray_Layer1_x(2)));
                    Convolution_Res_x           <= std_logic_vector(signed(AddArray_Layer2_x) * signed(AddArray_Layer2_x));

                    MultArray_Reg_y             <= Coeff_y * ("0" & Din_Buffer);
                    AddArray_Layer1_y(0)        <= std_logic_vector(signed(MultArray_Reg_y(0)(0)) + signed(MultArray_Reg_y(0)(1))  + signed(MultArray_Reg_y(0)(2))); 
                    AddArray_Layer1_y(1)        <= std_logic_vector(signed(MultArray_Reg_y(1)(0)) + signed(MultArray_Reg_y(1)(1))  + signed(MultArray_Reg_y(1)(2))); 
                    AddArray_Layer1_y(2)        <= std_logic_vector(signed(MultArray_Reg_y(2)(0)) + signed(MultArray_Reg_y(2)(1))  + signed(MultArray_Reg_y(2)(2)));  
                    AddArray_Layer2_y           <= std_logic_vector(signed(AddArray_Layer1_y(0)) + signed(AddArray_Layer1_y(1)) + signed(AddArray_Layer1_y(2)));
                    Convolution_Res_y           <= std_logic_vector(signed(AddArray_Layer2_y) * signed(AddArray_Layer2_y));

                    EdgeDetection_Dout_Reg      <= std_logic_vector(unsigned(Convolution_Res_x) + unsigned(Convolution_Res_y));

                    if cntr = 5 then
                        cntr    <= 0;
                        EdgeDetection_Ready <= '1';
                    else
                        cntr    <= cntr + 1;
                    end if;

                    if EdgeDetection_Disable = '1' then 
                        cntrDisable <= cntrDisable + 1;
                    end if;

                    if cntrDisable = 6 then
                        state   <= S_IDLE;
                        EdgeDetection_Ready <= '0';
                        cntr    <= 0;
                        cntrDisable <= 0;
                    end if;
            END CASE;
        END IF;
    END PROCESS;
    EdgeDetection_Dout  <= EdgeDetection_Dout_Reg(31 downto 0);
END Behavioral;