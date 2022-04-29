----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2021 12:29:20 AM
-- Design Name: 
-- Module Name: tb_AES_Encrypt - Behavioral
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
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE std.textio.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY tb_AES_Encrypt IS
    --  Port ( );
END tb_AES_Encrypt;

ARCHITECTURE Behavioral OF tb_AES_Encrypt IS

    COMPONENT AES_Encrypt IS
        PORT (
            CLK         : IN STD_LOGIC;
            aes_enable  : IN STD_LOGIC;
            aes_stop    : IN STD_LOGIC;
            aes_message : IN STD_LOGIC_VECTOR(16 * 8 - 1 DOWNTO 0);
            aes_key     : IN STD_LOGIC_VECTOR(16 * 8 - 1 DOWNTO 0);
            aes_out     : OUT STD_LOGIC_VECTOR(16 * 8 - 1 DOWNTO 0);
            aes_done    : OUT STD_LOGIC;
            aes_valid   : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL aes_enable  : STD_LOGIC                      := '0';
    SIGNAL aes_stop    : STD_LOGIC                      := '0';
    SIGNAL aes_valid   : STD_LOGIC                      := '0';
    SIGNAL aes_done    : STD_LOGIC                      := '0';
    SIGNAL CLK         : STD_LOGIC                      := '1';
    SIGNAL aes_message : STD_LOGIC_VECTOR(127 DOWNTO 0) := (OTHERS => '0');
    SIGNAL aes_key     : STD_LOGIC_VECTOR(127 DOWNTO 0) := (OTHERS => '0');
    SIGNAL aes_out     : STD_LOGIC_VECTOR(127 DOWNTO 0) := (OTHERS => '0');

    SIGNAL doutGolden : STD_LOGIC_VECTOR(127 DOWNTO 0) := (OTHERS => '0');
BEGIN
    CLK <= NOT CLK AFTER 5 ns;

    dut : PROCESS
    BEGIN
        WAIT FOR 50 ns;        
        WAIT UNTIL falling_edge(CLK);
        aes_enable <= '1';
        FOR i IN 0 TO 10000 LOOP
            aes_key     <= x"2b7e151628aed2a6abf7158809cf4f3c";
            aes_message <= conv_std_logic_vector(i * 45154, aes_message'length);
            WAIT UNTIL falling_edge(CLK);
            aes_enable <= '0';
        END LOOP;
        aes_stop <= '1';
        WAIT UNTIL falling_edge(CLK);
        aes_stop <= '0';
        WAIT UNTIL aes_done = '1';
        WAIT FOR 100 ns;
        REPORT "Verification has been completed successffully!!!";
        std.env.finish;
    END PROCESS;

    dut_verify : PROCESS IS
        VARIABLE cntr                           : INTEGER := 0;
        FILE GoldenResult_file                  : text OPEN read_mode IS "GoldenData.txt"; -- give path
        VARIABLE GoldenResult_file_current_line : line;
        VARIABLE GoldenData_current_field       : STD_LOGIC_VECTOR(127 DOWNTO 0) := (OTHERS => '0');

    BEGIN
        WAIT UNTIL rising_edge(aes_valid);
        WHILE (cntr < 10000) LOOP
            REPORT "Entity: aes_out = " & to_hstring(aes_out) & "h";
            readline(GoldenResult_file, GoldenResult_file_current_line);
            hread(GoldenResult_file_current_line, GoldenData_current_field);
            doutGolden <= GoldenData_current_field;

            WAIT UNTIL rising_edge(CLK);

            ASSERT GoldenData_current_field = aes_out
            REPORT "The encryipted data is not correct"
                SEVERITY failure;
            
            cntr := cntr + 1;
        END LOOP;
    END PROCESS;
    AES_Encrypt_Inst : AES_Encrypt
    PORT MAP(
        CLK         => CLK,
        aes_enable  => aes_enable,
        aes_stop    => aes_stop,
        aes_message => aes_message,
        aes_key     => aes_key,
        aes_out     => aes_out,
        aes_done    => aes_done,
        aes_valid   => aes_valid
    );
END Behavioral;