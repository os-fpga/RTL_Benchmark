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
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.OperatorOverloading_pkg.ALL;
USE work.EdgeDetection_pkg.ALL;
ENTITY EdgeDetection IS
    GENERIC (
        EdgeDetection_Type   : STRING  := "0"; -- "0"->Sobel filter -- "1"->Prewitt filter -- "2"->Scharr filter -- "3"->Roberts filter
        EdgeDetection_Kernel : INTEGER := DetermineKernel(EdgeDetection_Type)
    );
    PORT (
        CLK                   : IN STD_LOGIC;
        EdgeDetection_Enable  : IN STD_LOGIC;
        EdgeDetection_Disable : IN STD_LOGIC;
        EdgeDetection_Din     : IN array2D(0 TO EdgeDetection_Kernel)(7 DOWNTO 0);
        EdgeDetection_Dout    : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        EdgeDetection_Ready   : OUT STD_LOGIC
    );
END EdgeDetection;

ARCHITECTURE Behavioral OF EdgeDetection IS

BEGIN
    TypeSelectionCase : CASE EdgeDetection_Type GENERATE
        WHEN "0" =>
            SobelFilter_Inst : ENTITY work.SobelFilter(Behavioral)
                PORT MAP(
                    CLK                   => CLK,
                    EdgeDetection_Enable  => EdgeDetection_Enable,
                    EdgeDetection_Disable => EdgeDetection_Disable,
                    EdgeDetection_Din     => EdgeDetection_Din,
                    EdgeDetection_Dout    => EdgeDetection_Dout,
                    EdgeDetection_Ready   => EdgeDetection_Ready
                );
        WHEN "1" =>
            PrewittFilter_Inst : ENTITY work.PrewittFilter(Behavioral)
                PORT MAP(
                    CLK                   => CLK,
                    EdgeDetection_Enable  => EdgeDetection_Enable,
                    EdgeDetection_Disable => EdgeDetection_Disable,
                    EdgeDetection_Din     => EdgeDetection_Din,
                    EdgeDetection_Dout    => EdgeDetection_Dout,
                    EdgeDetection_Ready   => EdgeDetection_Ready
                );
        WHEN "2" =>
            ScharrFilter_Inst : ENTITY work.ScharrFilter(Behavioral)
                PORT MAP(
                    CLK                   => CLK,
                    EdgeDetection_Enable  => EdgeDetection_Enable,
                    EdgeDetection_Disable => EdgeDetection_Disable,
                    EdgeDetection_Din     => EdgeDetection_Din,
                    EdgeDetection_Dout    => EdgeDetection_Dout,
                    EdgeDetection_Ready   => EdgeDetection_Ready
                );
        WHEN "3" =>
            RobertsFilter_Inst : ENTITY work.RobertsFilter(Behavioral)
                PORT MAP(
                    CLK                   => CLK,
                    EdgeDetection_Enable  => EdgeDetection_Enable,
                    EdgeDetection_Disable => EdgeDetection_Disable,
                    EdgeDetection_Din     => EdgeDetection_Din,
                    EdgeDetection_Dout    => EdgeDetection_Dout,
                    EdgeDetection_Ready   => EdgeDetection_Ready
                );
        WHEN OTHERS =>
            RobertsFilter_Inst : ENTITY work.RobertsFilter(Behavioral)
                PORT MAP(
                    CLK                   => CLK,
                    EdgeDetection_Enable  => EdgeDetection_Enable,
                    EdgeDetection_Disable => EdgeDetection_Disable,
                    EdgeDetection_Din     => EdgeDetection_Din,
                    EdgeDetection_Dout    => EdgeDetection_Dout,
                    EdgeDetection_Ready   => EdgeDetection_Ready
                );
    END GENERATE;

END Behavioral;