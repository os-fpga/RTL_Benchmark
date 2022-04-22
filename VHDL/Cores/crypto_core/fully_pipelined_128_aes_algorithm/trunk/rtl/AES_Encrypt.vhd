----------------------------------------------------------------------------------
-- Company: 
-- Engineer: MUHAMMED KOCAOGLU
-- 
-- Create Date: 12/29/2021 12:01:25 AM
-- Design Name: 
-- Module Name: AES_Encrypt - Behavioral
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
USE work.AES_pkg.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY AES_Encrypt IS
    PORT (
        CLK         : IN STD_LOGIC;
        aes_enable  : IN STD_LOGIC;
        aes_stop    : IN STD_LOGIC;
        aes_key     : IN STD_LOGIC_VECTOR(16 * 8 - 1 DOWNTO 0);
        aes_message : IN STD_LOGIC_VECTOR(16 * 8 - 1 DOWNTO 0);
        aes_out     : OUT STD_LOGIC_VECTOR(16 * 8 - 1 DOWNTO 0);
        aes_done    : OUT STD_LOGIC;
        aes_valid   : OUT STD_LOGIC
    );
END AES_Encrypt;

ARCHITECTURE Behavioral OF AES_Encrypt IS
    SIGNAL aes_matrix : array3D8;

    TYPE subkeyArray IS ARRAY (NATURAL RANGE 0 TO 9) OF array3D8;
    SIGNAL subkeys          : subkeyArray;
    SIGNAL cipheredMessages : subkeyArray;

    SIGNAL cntr      : INTEGER RANGE 0 TO 15 := 0;
    SIGNAL cntrValid : INTEGER RANGE 0 TO 15 := 0;

    SIGNAL aes_stop_Reg : STD_LOGIC := '0';
    TYPE states IS (
        S_IDLE,
        S_CIPHER
    );
    SIGNAL state : states := S_IDLE;

BEGIN
    P_MAIN : PROCESS (CLK)
    BEGIN
        IF rising_edge(CLK) THEN
            aes_done <= '0';
            CASE state IS
                WHEN S_IDLE =>
                    aes_stop_Reg <= '0';
                    aes_valid    <= '0';
                    IF aes_enable = '1' THEN
                        state <= S_CIPHER;
                    END IF;

                WHEN S_CIPHER =>
                    IF aes_stop = '1' THEN
                        aes_stop_Reg <= '1';
                    END IF;

                    IF aes_stop_Reg = '1' THEN
                        IF cntr < 9 THEN
                            cntr <= cntr + 1;
                        ELSE
                            aes_valid    <= '0';
                            cntr         <= 0;
                            cntrValid    <= 0;
                            aes_done     <= '1';
                            aes_stop_Reg <= '0';
                            state        <= S_IDLE;
                        END IF;
                    END IF;

                    IF cntrValid = 10 THEN
                        aes_valid <= '1';
                    ELSE
                        cntrValid <= cntrValid + 1;
                    END IF;

                    subkeys(0)          <= generateSubKey(aes_key, 0);
                    cipheredMessages(0) <= encryptMessage(aes_message, aes_key);
                    FOR i IN 0 TO 8 LOOP
                        subkeys(i + 1)          <= generateSubKey(subkeys(i), i + 1);
                        cipheredMessages(i + 1) <= encryptMessage(cipheredMessages(i), subkeys(i));
                    END LOOP;
                    aes_out <= encyrptFinal(cipheredMessages(9), subkeys(9));

            END CASE;

        END IF;
    END PROCESS;
END Behavioral;