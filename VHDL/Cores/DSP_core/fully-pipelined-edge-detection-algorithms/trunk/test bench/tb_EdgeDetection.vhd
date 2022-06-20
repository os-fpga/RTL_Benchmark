----------------------------------------------------------------------------------
-- Company: 
-- Engineer: MUHAMMED KOCAOGLU
-- 
-- Create Date: 01/13/2022 11:37:53 PM
-- Design Name: 
-- Module Name: tb_EdgeDetection - Behavioral
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
USE std.textio.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE work.OperatorOverloading_pkg.ALL;
USE work.EdgeDetection_pkg.ALL;

ENTITY tb_EdgeDetection IS
    GENERIC (
        EdgeDetection_Type   : STRING  := "0"; -- "0"->Sobel filter -- "1"->Prewitt filter -- "2"->Scharr filter -- "3"->Roberts filter
        EdgeDetection_Kernel : INTEGER := DetermineKernel(EdgeDetection_Type)
    );
END tb_EdgeDetection;

ARCHITECTURE Behavioral OF tb_EdgeDetection IS

    PROCEDURE FILTERDATA (
        FILE RawImageHex_file        : text;
        FILE FilteredImageHex_file   : text;
        SIGNAL CLK                   : IN STD_LOGIC;
        SIGNAL EdgeDetection_Ready   : IN STD_LOGIC;
        SIGNAL EdgeDetection_Disable : OUT STD_LOGIC;
        SIGNAL EdgeDetection_Enable  : OUT STD_LOGIC;
        SIGNAL EdgeDetection_Din     : OUT array2D(0 TO EdgeDetection_Kernel)(7 DOWNTO 0);
        SIGNAL EdgeDetection_Dout    : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
    ) IS
        VARIABLE RawImageHex_current_line       : line;
        VARIABLE RawImageHex_current_field      : STD_LOGIC_VECTOR(3 * 8 - 1 DOWNTO 0) := (OTHERS => '0');
        VARIABLE FilteredImageHex_current_line  : line;
        VARIABLE FilteredImageHex_current_field : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    BEGIN
        WAIT UNTIL falling_edge(CLK);
        WHILE NOT endfile(RawImageHex_file) LOOP
            readline(RawImageHex_file, RawImageHex_current_line);
            hread(RawImageHex_current_line, RawImageHex_current_field);
            EdgeDetection_Enable <= '1';
            FOR i IN 0 TO EdgeDetection_Kernel LOOP
                EdgeDetection_Din(i) <= RawImageHex_current_field((EdgeDetection_Kernel + 1 - i) * 8 - 1 DOWNTO (EdgeDetection_Kernel - i) * 8);
            END LOOP;

            IF EdgeDetection_Ready = '1' THEN
                hwrite(FilteredImageHex_current_line, EdgeDetection_Dout);
                writeline(FilteredImageHex_file, FilteredImageHex_current_line);
            END IF;
            WAIT UNTIL falling_edge(CLK);
        END LOOP;
        EdgeDetection_Disable <= '1';
        EdgeDetection_Enable  <= '0';
        WHILE EdgeDetection_Ready = '1' LOOP
            hwrite(FilteredImageHex_current_line, EdgeDetection_Dout);
            writeline(FilteredImageHex_file, FilteredImageHex_current_line);
            WAIT UNTIL falling_edge(CLK);
        END LOOP;
    END PROCEDURE;

    COMPONENT EdgeDetection IS
        GENERIC (
            EdgeDetection_Type   : STRING  := "0";
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
    END COMPONENT;
    SIGNAL CLK                   : STD_LOGIC := '1';
    SIGNAL EdgeDetection_Enable  : STD_LOGIC := '0';
    SIGNAL EdgeDetection_Disable : STD_LOGIC := '0';
    SIGNAL EdgeDetection_Din     : array2D(0 TO EdgeDetection_Kernel)(7 DOWNTO 0);
    SIGNAL EdgeDetection_Dout    : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL EdgeDetection_Ready   : STD_LOGIC;
BEGIN

    CLK <= NOT CLK AFTER 5 ns;

    dut : PROCESS
        FILE RawImageHex_file      : text OPEN read_mode IS "C:\Users\Muhammed\OneDrive\FPGA_Projects\VivadoProjects\EdgeDetection_v2\EdgeDetection_v2.srcs\sim_1\new\venice_raw_vect_hex.txt";
        FILE FilteredImageHex_file : text OPEN write_mode IS "C:\Users\Muhammed\OneDrive\FPGA_Projects\VivadoProjects\EdgeDetection_v2\EdgeDetection_v2.srcs\sim_1\new\venice_filtered_vect_hex.txt";
    BEGIN
        WAIT FOR 50 ns;
        WAIT UNTIL falling_edge(CLK);

        FILTERDATA(
        RawImageHex_file,
        FilteredImageHex_file,
        CLK,
        EdgeDetection_Ready,
        EdgeDetection_Disable,
        EdgeDetection_Enable,
        EdgeDetection_Din,
        EdgeDetection_Dout
        );

        file_close(RawImageHex_file);
        file_close(FilteredImageHex_file);
        WAIT FOR 100 ns;
        std.env.stop;
    END PROCESS;

    EdgeDetection_Inst : EdgeDetection
    GENERIC MAP(
        EdgeDetection_Type   => EdgeDetection_Type,
        EdgeDetection_Kernel => EdgeDetection_Kernel
    )
    PORT MAP(
        CLK                   => CLK,
        EdgeDetection_Enable  => EdgeDetection_Enable,
        EdgeDetection_Disable => EdgeDetection_Disable,
        EdgeDetection_Din     => EdgeDetection_Din,
        EdgeDetection_Dout    => EdgeDetection_Dout,
        EdgeDetection_Ready   => EdgeDetection_Ready
    );
END Behavioral;