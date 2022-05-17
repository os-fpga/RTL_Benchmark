----------------------------------------------------------------------------------
-- Company: 
-- Engineer: MUHAMMED KOCAOGLU
-- 
-- Create Date: 12/29/2021 12:07:32 AM
-- Design Name: 
-- Module Name: AES_pkg - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

PACKAGE AES_pkg IS
    TYPE array2D8 IS ARRAY (NATURAL RANGE 0 TO 3) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    TYPE array3D8 IS ARRAY (NATURAL RANGE 0 TO 3) OF array2D8;

    FUNCTION convert1D_to_2D(din             : IN STD_LOGIC_VECTOR(127 DOWNTO 0)) RETURN array3D8;
    FUNCTION generateSubKey(din : IN STD_LOGIC_VECTOR(127 DOWNTO 0); stage : IN INTEGER) RETURN array3D8;
    FUNCTION generateSubKey(din : IN array3D8; stage : IN INTEGER) RETURN array3D8;
    FUNCTION encryptMessage(aes_message : IN STD_LOGIC_VECTOR(127 DOWNTO 0); aes_key : IN STD_LOGIC_VECTOR(127 DOWNTO 0)) RETURN array3D8;
    FUNCTION encryptMessage(aes_message : IN array3D8; aes_key : IN array3D8) RETURN array3D8;
    FUNCTION mixcolumnOneByte(i1, i2, i3, i4 : IN STD_LOGIC_VECTOR (7 DOWNTO 0)) RETURN STD_LOGIC_VECTOR;
    FUNCTION encyrptFinal(aes_message : IN array3D8; aes_key : IN array3D8) RETURN STD_LOGIC_VECTOR;

    TYPE sBoxArray IS ARRAY (NATURAL RANGE 0 TO 255) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    CONSTANT sBox : sBoxArray := (
        x"63", x"7c", x"77", x"7b", x"f2", x"6b", x"6f", x"c5", x"30", x"01", x"67", x"2b", x"fe", x"d7", x"ab", x"76",
        x"ca", x"82", x"c9", x"7d", x"fa", x"59", x"47", x"f0", x"ad", x"d4", x"a2", x"af", x"9c", x"a4", x"72", x"c0",
        x"b7", x"fd", x"93", x"26", x"36", x"3f", x"f7", x"cc", x"34", x"a5", x"e5", x"f1", x"71", x"d8", x"31", x"15",
        x"04", x"c7", x"23", x"c3", x"18", x"96", x"05", x"9a", x"07", x"12", x"80", x"e2", x"eb", x"27", x"b2", x"75",
        x"09", x"83", x"2c", x"1a", x"1b", x"6e", x"5a", x"a0", x"52", x"3b", x"d6", x"b3", x"29", x"e3", x"2f", x"84",
        x"53", x"d1", x"00", x"ed", x"20", x"fc", x"b1", x"5b", x"6a", x"cb", x"be", x"39", x"4a", x"4c", x"58", x"cf",
        x"d0", x"ef", x"aa", x"fb", x"43", x"4d", x"33", x"85", x"45", x"f9", x"02", x"7f", x"50", x"3c", x"9f", x"a8",
        x"51", x"a3", x"40", x"8f", x"92", x"9d", x"38", x"f5", x"bc", x"b6", x"da", x"21", x"10", x"ff", x"f3", x"d2",
        x"cd", x"0c", x"13", x"ec", x"5f", x"97", x"44", x"17", x"c4", x"a7", x"7e", x"3d", x"64", x"5d", x"19", x"73",
        x"60", x"81", x"4f", x"dc", x"22", x"2a", x"90", x"88", x"46", x"ee", x"b8", x"14", x"de", x"5e", x"0b", x"db",
        x"e0", x"32", x"3a", x"0a", x"49", x"06", x"24", x"5c", x"c2", x"d3", x"ac", x"62", x"91", x"95", x"e4", x"79",
        x"e7", x"c8", x"37", x"6d", x"8d", x"d5", x"4e", x"a9", x"6c", x"56", x"f4", x"ea", x"65", x"7a", x"ae", x"08",
        x"ba", x"78", x"25", x"2e", x"1c", x"a6", x"b4", x"c6", x"e8", x"dd", x"74", x"1f", x"4b", x"bd", x"8b", x"8a",
        x"70", x"3e", x"b5", x"66", x"48", x"03", x"f6", x"0e", x"61", x"35", x"57", x"b9", x"86", x"c1", x"1d", x"9e",
        x"e1", x"f8", x"98", x"11", x"69", x"d9", x"8e", x"94", x"9b", x"1e", x"87", x"e9", x"ce", x"55", x"28", x"df",
        x"8c", x"a1", x"89", x"0d", x"bf", x"e6", x"42", x"68", x"41", x"99", x"2d", x"0f", x"b0", x"54", x"bb", x"16"
    );

    TYPE array2D8_sbox IS ARRAY (NATURAL RANGE 0 TO 3) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    TYPE array3D8_sbox IS ARRAY (NATURAL RANGE 0 TO 9) OF array2D8_sbox;
    CONSTANT rcon : array3D8_sbox := (
    (x"01", x"00", x"00", x"00"),
        (x"02", x"00", x"00", x"00"),
        (x"04", x"00", x"00", x"00"),
        (x"08", x"00", x"00", x"00"),
        (x"10", x"00", x"00", x"00"),
        (x"20", x"00", x"00", x"00"),
        (x"40", x"00", x"00", x"00"),
        (x"80", x"00", x"00", x"00"),
        (x"1B", x"00", x"00", x"00"),
        (x"36", x"00", x"00", x"00")
    );
END PACKAGE;
PACKAGE BODY AES_pkg IS
    FUNCTION convert1D_to_2D(din : IN STD_LOGIC_VECTOR(127 DOWNTO 0)) RETURN array3D8 IS
        VARIABLE result              : array3D8;
    BEGIN
        result(0) := (din(16 * 8 - 1 DOWNTO 15 * 8), din(12 * 8 - 1 DOWNTO 11 * 8), din(8 * 8 - 1 DOWNTO 7 * 8), din(4 * 8 - 1 DOWNTO 3 * 8));
        result(1) := (din(15 * 8 - 1 DOWNTO 14 * 8), din(11 * 8 - 1 DOWNTO 10 * 8), din(7 * 8 - 1 DOWNTO 6 * 8), din(3 * 8 - 1 DOWNTO 2 * 8));
        result(2) := (din(14 * 8 - 1 DOWNTO 13 * 8), din(10 * 8 - 1 DOWNTO 9 * 8), din(6 * 8 - 1 DOWNTO 5 * 8), din(2 * 8 - 1 DOWNTO 1 * 8));
        result(3) := (din(13 * 8 - 1 DOWNTO 12 * 8), din(9 * 8 - 1 DOWNTO 8 * 8), din(5 * 8 - 1 DOWNTO 4 * 8), din(1 * 8 - 1 DOWNTO 0 * 8));
        RETURN result;
    END;

    FUNCTION generateSubKey(din : IN STD_LOGIC_VECTOR(127 DOWNTO 0); stage : IN INTEGER) RETURN array3D8 IS
        VARIABLE result : array3D8;
    BEGIN
        result(0)(0) := din(16 * 8 - 1 DOWNTO 15 * 8) XOR sBox(conv_integer(unsigned(din(3 * 8 - 1 DOWNTO 2 * 8)))) XOR rcon(stage)(0);
        result(0)(1) := din(16 * 8 - 1 DOWNTO 15 * 8) XOR sBox(conv_integer(unsigned(din(3 * 8 - 1 DOWNTO 2 * 8)))) XOR rcon(stage)(0) XOR din(12 * 8 - 1 DOWNTO 11 * 8);
        result(0)(2) := din(16 * 8 - 1 DOWNTO 15 * 8) XOR sBox(conv_integer(unsigned(din(3 * 8 - 1 DOWNTO 2 * 8)))) XOR rcon(stage)(0) XOR din(12 * 8 - 1 DOWNTO 11 * 8) XOR din(8 * 8 - 1 DOWNTO 7 * 8);
        result(0)(3) := din(16 * 8 - 1 DOWNTO 15 * 8) XOR sBox(conv_integer(unsigned(din(3 * 8 - 1 DOWNTO 2 * 8)))) XOR rcon(stage)(0) XOR din(12 * 8 - 1 DOWNTO 11 * 8) XOR din(8 * 8 - 1 DOWNTO 7 * 8) XOR din(4 * 8 - 1 DOWNTO 3 * 8);

        result(1)(0) := din(15 * 8 - 1 DOWNTO 14 * 8) XOR sBox(conv_integer(unsigned(din(2 * 8 - 1 DOWNTO 1 * 8)))) XOR rcon(stage)(1);
        result(1)(1) := din(15 * 8 - 1 DOWNTO 14 * 8) XOR sBox(conv_integer(unsigned(din(2 * 8 - 1 DOWNTO 1 * 8)))) XOR rcon(stage)(1) XOR din(11 * 8 - 1 DOWNTO 10 * 8);
        result(1)(2) := din(15 * 8 - 1 DOWNTO 14 * 8) XOR sBox(conv_integer(unsigned(din(2 * 8 - 1 DOWNTO 1 * 8)))) XOR rcon(stage)(1) XOR din(11 * 8 - 1 DOWNTO 10 * 8) XOR din(7 * 8 - 1 DOWNTO 6 * 8);
        result(1)(3) := din(15 * 8 - 1 DOWNTO 14 * 8) XOR sBox(conv_integer(unsigned(din(2 * 8 - 1 DOWNTO 1 * 8)))) XOR rcon(stage)(1) XOR din(11 * 8 - 1 DOWNTO 10 * 8) XOR din(7 * 8 - 1 DOWNTO 6 * 8) XOR din(3 * 8 - 1 DOWNTO 2 * 8);

        result(2)(0) := din(14 * 8 - 1 DOWNTO 13 * 8) XOR sBox(conv_integer(unsigned(din(1 * 8 - 1 DOWNTO 0 * 8)))) XOR rcon(stage)(2);
        result(2)(1) := din(14 * 8 - 1 DOWNTO 13 * 8) XOR sBox(conv_integer(unsigned(din(1 * 8 - 1 DOWNTO 0 * 8)))) XOR rcon(stage)(2) XOR din(10 * 8 - 1 DOWNTO 9 * 8);
        result(2)(2) := din(14 * 8 - 1 DOWNTO 13 * 8) XOR sBox(conv_integer(unsigned(din(1 * 8 - 1 DOWNTO 0 * 8)))) XOR rcon(stage)(2) XOR din(10 * 8 - 1 DOWNTO 9 * 8) XOR din(6 * 8 - 1 DOWNTO 5 * 8);
        result(2)(3) := din(14 * 8 - 1 DOWNTO 13 * 8) XOR sBox(conv_integer(unsigned(din(1 * 8 - 1 DOWNTO 0 * 8)))) XOR rcon(stage)(2) XOR din(10 * 8 - 1 DOWNTO 9 * 8) XOR din(6 * 8 - 1 DOWNTO 5 * 8) XOR din(2 * 8 - 1 DOWNTO 1 * 8);

        result(3)(0) := din(13 * 8 - 1 DOWNTO 12 * 8) XOR sBox(conv_integer(unsigned(din(4 * 8 - 1 DOWNTO 3 * 8)))) XOR rcon(stage)(3);
        result(3)(1) := din(13 * 8 - 1 DOWNTO 12 * 8) XOR sBox(conv_integer(unsigned(din(4 * 8 - 1 DOWNTO 3 * 8)))) XOR rcon(stage)(3) XOR din(9 * 8 - 1 DOWNTO 8 * 8);
        result(3)(2) := din(13 * 8 - 1 DOWNTO 12 * 8) XOR sBox(conv_integer(unsigned(din(4 * 8 - 1 DOWNTO 3 * 8)))) XOR rcon(stage)(3) XOR din(9 * 8 - 1 DOWNTO 8 * 8) XOR din(5 * 8 - 1 DOWNTO 4 * 8);
        result(3)(3) := din(13 * 8 - 1 DOWNTO 12 * 8) XOR sBox(conv_integer(unsigned(din(4 * 8 - 1 DOWNTO 3 * 8)))) XOR rcon(stage)(3) XOR din(9 * 8 - 1 DOWNTO 8 * 8) XOR din(5 * 8 - 1 DOWNTO 4 * 8) XOR din(1 * 8 - 1 DOWNTO 0 * 8);
        RETURN result;
    END;

    FUNCTION generateSubKey(din : IN array3D8; stage : IN INTEGER) RETURN array3D8 IS
        VARIABLE result : array3D8;
    BEGIN
        result(0)(0) := din(0)(0) XOR sBox(conv_integer(unsigned(din(1)(3)))) XOR rcon(stage)(0);
        result(0)(1) := din(0)(0) XOR sBox(conv_integer(unsigned(din(1)(3)))) XOR rcon(stage)(0) XOR din(0)(1);
        result(0)(2) := din(0)(0) XOR sBox(conv_integer(unsigned(din(1)(3)))) XOR rcon(stage)(0) XOR din(0)(1) XOR din(0)(2);
        result(0)(3) := din(0)(0) XOR sBox(conv_integer(unsigned(din(1)(3)))) XOR rcon(stage)(0) XOR din(0)(1) XOR din(0)(2) XOR din(0)(3);

        result(1)(0) := din(1)(0) XOR sBox(conv_integer(unsigned(din(2)(3)))) XOR rcon(stage)(1);
        result(1)(1) := din(1)(0) XOR sBox(conv_integer(unsigned(din(2)(3)))) XOR rcon(stage)(1) XOR din(1)(1);
        result(1)(2) := din(1)(0) XOR sBox(conv_integer(unsigned(din(2)(3)))) XOR rcon(stage)(1) XOR din(1)(1) XOR din(1)(2);
        result(1)(3) := din(1)(0) XOR sBox(conv_integer(unsigned(din(2)(3)))) XOR rcon(stage)(1) XOR din(1)(1) XOR din(1)(2) XOR din(1)(3);

        result(2)(0) := din(2)(0) XOR sBox(conv_integer(unsigned(din(3)(3)))) XOR rcon(stage)(2);
        result(2)(1) := din(2)(0) XOR sBox(conv_integer(unsigned(din(3)(3)))) XOR rcon(stage)(2) XOR din(2)(1);
        result(2)(2) := din(2)(0) XOR sBox(conv_integer(unsigned(din(3)(3)))) XOR rcon(stage)(2) XOR din(2)(1) XOR din(2)(2);
        result(2)(3) := din(2)(0) XOR sBox(conv_integer(unsigned(din(3)(3)))) XOR rcon(stage)(2) XOR din(2)(1) XOR din(2)(2) XOR din(2)(3);

        result(3)(0) := din(3)(0) XOR sBox(conv_integer(unsigned(din(0)(3)))) XOR rcon(stage)(3);
        result(3)(1) := din(3)(0) XOR sBox(conv_integer(unsigned(din(0)(3)))) XOR rcon(stage)(3) XOR din(3)(1);
        result(3)(2) := din(3)(0) XOR sBox(conv_integer(unsigned(din(0)(3)))) XOR rcon(stage)(3) XOR din(3)(1) XOR din(3)(2);
        result(3)(3) := din(3)(0) XOR sBox(conv_integer(unsigned(din(0)(3)))) XOR rcon(stage)(3) XOR din(3)(1) XOR din(3)(2) XOR din(3)(3);
        RETURN result;

    END;
    FUNCTION encryptMessage(aes_message : IN STD_LOGIC_VECTOR(127 DOWNTO 0); aes_key : IN STD_LOGIC_VECTOR(127 DOWNTO 0)) RETURN array3D8 IS
        VARIABLE result : array3D8;
    BEGIN
        result(0)(0) := aes_message(16 * 8 - 1 DOWNTO 15 * 8) XOR aes_key(16 * 8 - 1 DOWNTO 15 * 8);
        result(0)(1) := aes_message(12 * 8 - 1 DOWNTO 11 * 8) XOR aes_key(12 * 8 - 1 DOWNTO 11 * 8);
        result(0)(2) := aes_message(8 * 8 - 1 DOWNTO 7 * 8) XOR aes_key(8 * 8 - 1 DOWNTO 7 * 8);
        result(0)(3) := aes_message(4 * 8 - 1 DOWNTO 3 * 8) XOR aes_key(4 * 8 - 1 DOWNTO 3 * 8);

        result(1)(0) := aes_message(15 * 8 - 1 DOWNTO 14 * 8) XOR aes_key(15 * 8 - 1 DOWNTO 14 * 8);
        result(1)(1) := aes_message(11 * 8 - 1 DOWNTO 10 * 8) XOR aes_key(11 * 8 - 1 DOWNTO 10 * 8);
        result(1)(2) := aes_message(7 * 8 - 1 DOWNTO 6 * 8) XOR aes_key(7 * 8 - 1 DOWNTO 6 * 8);
        result(1)(3) := aes_message(3 * 8 - 1 DOWNTO 2 * 8) XOR aes_key(3 * 8 - 1 DOWNTO 2 * 8);

        result(2)(0) := aes_message(14 * 8 - 1 DOWNTO 13 * 8) XOR aes_key(14 * 8 - 1 DOWNTO 13 * 8);
        result(2)(1) := aes_message(10 * 8 - 1 DOWNTO 9 * 8) XOR aes_key(10 * 8 - 1 DOWNTO 9 * 8);
        result(2)(2) := aes_message(6 * 8 - 1 DOWNTO 5 * 8) XOR aes_key(6 * 8 - 1 DOWNTO 5 * 8);
        result(2)(3) := aes_message(2 * 8 - 1 DOWNTO 1 * 8) XOR aes_key(2 * 8 - 1 DOWNTO 1 * 8);

        result(3)(0) := aes_message(13 * 8 - 1 DOWNTO 12 * 8) XOR aes_key(13 * 8 - 1 DOWNTO 12 * 8);
        result(3)(1) := aes_message(9 * 8 - 1 DOWNTO 8 * 8) XOR aes_key(9 * 8 - 1 DOWNTO 8 * 8);
        result(3)(2) := aes_message(5 * 8 - 1 DOWNTO 4 * 8) XOR aes_key(5 * 8 - 1 DOWNTO 4 * 8);
        result(3)(3) := aes_message(1 * 8 - 1 DOWNTO 0 * 8) XOR aes_key(1 * 8 - 1 DOWNTO 0 * 8);
        RETURN result;
    END;

    FUNCTION encryptMessage(aes_message : IN array3D8; aes_key : IN array3D8) RETURN array3D8 IS
        VARIABLE result : array3D8;
    BEGIN
        result(0)(0) := mixcolumnOneByte(sBox(conv_integer(unsigned(aes_message(0)(0)))), sBox(conv_integer(unsigned(aes_message(1)(1)))), sBox(conv_integer(unsigned(aes_message(2)(2)))), sBox(conv_integer(unsigned(aes_message(3)(3))))) XOR aes_key(0)(0);
        result(1)(0) := mixcolumnOneByte(sBox(conv_integer(unsigned(aes_message(1)(1)))), sBox(conv_integer(unsigned(aes_message(2)(2)))), sBox(conv_integer(unsigned(aes_message(3)(3)))), sBox(conv_integer(unsigned(aes_message(0)(0))))) XOR aes_key(1)(0);
        result(2)(0) := mixcolumnOneByte(sBox(conv_integer(unsigned(aes_message(2)(2)))), sBox(conv_integer(unsigned(aes_message(3)(3)))), sBox(conv_integer(unsigned(aes_message(0)(0)))), sBox(conv_integer(unsigned(aes_message(1)(1))))) XOR aes_key(2)(0);
        result(3)(0) := mixcolumnOneByte(sBox(conv_integer(unsigned(aes_message(3)(3)))), sBox(conv_integer(unsigned(aes_message(0)(0)))), sBox(conv_integer(unsigned(aes_message(1)(1)))), sBox(conv_integer(unsigned(aes_message(2)(2))))) XOR aes_key(3)(0);

        result(0)(1) := mixcolumnOneByte(sBox(conv_integer(unsigned(aes_message(0)(1)))), sBox(conv_integer(unsigned(aes_message(1)(2)))), sBox(conv_integer(unsigned(aes_message(2)(3)))), sBox(conv_integer(unsigned(aes_message(3)(0))))) XOR aes_key(0)(1);
        result(1)(1) := mixcolumnOneByte(sBox(conv_integer(unsigned(aes_message(1)(2)))), sBox(conv_integer(unsigned(aes_message(2)(3)))), sBox(conv_integer(unsigned(aes_message(3)(0)))), sBox(conv_integer(unsigned(aes_message(0)(1))))) XOR aes_key(1)(1);
        result(2)(1) := mixcolumnOneByte(sBox(conv_integer(unsigned(aes_message(2)(3)))), sBox(conv_integer(unsigned(aes_message(3)(0)))), sBox(conv_integer(unsigned(aes_message(0)(1)))), sBox(conv_integer(unsigned(aes_message(1)(2))))) XOR aes_key(2)(1);
        result(3)(1) := mixcolumnOneByte(sBox(conv_integer(unsigned(aes_message(3)(0)))), sBox(conv_integer(unsigned(aes_message(0)(1)))), sBox(conv_integer(unsigned(aes_message(1)(2)))), sBox(conv_integer(unsigned(aes_message(2)(3))))) XOR aes_key(3)(1);

        result(0)(2) := mixcolumnOneByte(sBox(conv_integer(unsigned(aes_message(0)(2)))), sBox(conv_integer(unsigned(aes_message(1)(3)))), sBox(conv_integer(unsigned(aes_message(2)(0)))), sBox(conv_integer(unsigned(aes_message(3)(1))))) XOR aes_key(0)(2);
        result(1)(2) := mixcolumnOneByte(sBox(conv_integer(unsigned(aes_message(1)(3)))), sBox(conv_integer(unsigned(aes_message(2)(0)))), sBox(conv_integer(unsigned(aes_message(3)(1)))), sBox(conv_integer(unsigned(aes_message(0)(2))))) XOR aes_key(1)(2);
        result(2)(2) := mixcolumnOneByte(sBox(conv_integer(unsigned(aes_message(2)(0)))), sBox(conv_integer(unsigned(aes_message(3)(1)))), sBox(conv_integer(unsigned(aes_message(0)(2)))), sBox(conv_integer(unsigned(aes_message(1)(3))))) XOR aes_key(2)(2);
        result(3)(2) := mixcolumnOneByte(sBox(conv_integer(unsigned(aes_message(3)(1)))), sBox(conv_integer(unsigned(aes_message(0)(2)))), sBox(conv_integer(unsigned(aes_message(1)(3)))), sBox(conv_integer(unsigned(aes_message(2)(0))))) XOR aes_key(3)(2);

        result(0)(3) := mixcolumnOneByte(sBox(conv_integer(unsigned(aes_message(0)(3)))), sBox(conv_integer(unsigned(aes_message(1)(0)))), sBox(conv_integer(unsigned(aes_message(2)(1)))), sBox(conv_integer(unsigned(aes_message(3)(2))))) XOR aes_key(0)(3);
        result(1)(3) := mixcolumnOneByte(sBox(conv_integer(unsigned(aes_message(1)(0)))), sBox(conv_integer(unsigned(aes_message(2)(1)))), sBox(conv_integer(unsigned(aes_message(3)(2)))), sBox(conv_integer(unsigned(aes_message(0)(3))))) XOR aes_key(1)(3);
        result(2)(3) := mixcolumnOneByte(sBox(conv_integer(unsigned(aes_message(2)(1)))), sBox(conv_integer(unsigned(aes_message(3)(2)))), sBox(conv_integer(unsigned(aes_message(0)(3)))), sBox(conv_integer(unsigned(aes_message(1)(0))))) XOR aes_key(2)(3);
        result(3)(3) := mixcolumnOneByte(sBox(conv_integer(unsigned(aes_message(3)(2)))), sBox(conv_integer(unsigned(aes_message(0)(3)))), sBox(conv_integer(unsigned(aes_message(1)(0)))), sBox(conv_integer(unsigned(aes_message(2)(1))))) XOR aes_key(3)(3);
        RETURN result;
    END;
    -- as the order of i1, i2, i3, i4 change, the return value change
    FUNCTION mixcolumnOneByte(i1, i2, i3, i4 : IN STD_LOGIC_VECTOR (7 DOWNTO 0)) RETURN STD_LOGIC_VECTOR IS
        VARIABLE data_out                        : STD_LOGIC_VECTOR(7 DOWNTO 0);
    BEGIN
        data_out(7) := i1(6) XOR i2(6) XOR i2(7) XOR i3(7) XOR i4(7);
        data_out(6) := i1(5) XOR i2(5) XOR i2(6) XOR i3(6) XOR i4(6);
        data_out(5) := i1(4) XOR i2(4) XOR i2(5) XOR i3(5) XOR i4(5);
        data_out(4) := i1(3) XOR i1(7) XOR i2(3) XOR i2(4) XOR i2(7) XOR i3(4) XOR i4(4);
        data_out(3) := i1(2) XOR i1(7) XOR i2(2) XOR i2(3) XOR i2(7) XOR i3(3) XOR i4(3);
        data_out(2) := i1(1) XOR i2(1) XOR i2(2) XOR i3(2) XOR i4(2);
        data_out(1) := i1(0) XOR i1(7) XOR i2(0) XOR i2(1) XOR i2(7) XOR i3(1) XOR i4(1);
        data_out(0) := i1(7) XOR i2(7) XOR i2(0) XOR i3(0) XOR i4(0);
        RETURN data_out;
    END;

    FUNCTION encyrptFinal(aes_message : IN array3D8; aes_key : IN array3D8) RETURN STD_LOGIC_VECTOR IS
        VARIABLE result : STD_LOGIC_VECTOR(127 DOWNTO 0);
    BEGIN
        result(16 * 8 - 1 DOWNTO 15 * 8) := sBox(conv_integer(unsigned(aes_message(0)(0)))) XOR aes_key(0)(0);
        result(12 * 8 - 1 DOWNTO 11 * 8) := sBox(conv_integer(unsigned(aes_message(0)(1)))) XOR aes_key(0)(1);
        result(8 * 8 - 1 DOWNTO 7 * 8)   := sBox(conv_integer(unsigned(aes_message(0)(2)))) XOR aes_key(0)(2);
        result(4 * 8 - 1 DOWNTO 3 * 8)   := sBox(conv_integer(unsigned(aes_message(0)(3)))) XOR aes_key(0)(3);

        result(15 * 8 - 1 DOWNTO 14 * 8) := sBox(conv_integer(unsigned(aes_message(1)(1)))) XOR aes_key(1)(0);
        result(11 * 8 - 1 DOWNTO 10 * 8) := sBox(conv_integer(unsigned(aes_message(1)(2)))) XOR aes_key(1)(1);
        result(7 * 8 - 1 DOWNTO 6 * 8)   := sBox(conv_integer(unsigned(aes_message(1)(3)))) XOR aes_key(1)(2);
        result(3 * 8 - 1 DOWNTO 2 * 8)   := sBox(conv_integer(unsigned(aes_message(1)(0)))) XOR aes_key(1)(3);

        result(14 * 8 - 1 DOWNTO 13 * 8) := sBox(conv_integer(unsigned(aes_message(2)(2)))) XOR aes_key(2)(0);
        result(10 * 8 - 1 DOWNTO 9 * 8)  := sBox(conv_integer(unsigned(aes_message(2)(3)))) XOR aes_key(2)(1);
        result(6 * 8 - 1 DOWNTO 5 * 8)   := sBox(conv_integer(unsigned(aes_message(2)(0)))) XOR aes_key(2)(2);
        result(2 * 8 - 1 DOWNTO 1 * 8)   := sBox(conv_integer(unsigned(aes_message(2)(1)))) XOR aes_key(2)(3);

        result(13 * 8 - 1 DOWNTO 12 * 8) := sBox(conv_integer(unsigned(aes_message(3)(3)))) XOR aes_key(3)(0);
        result(9 * 8 - 1 DOWNTO 8 * 8)   := sBox(conv_integer(unsigned(aes_message(3)(0)))) XOR aes_key(3)(1);
        result(5 * 8 - 1 DOWNTO 4 * 8)   := sBox(conv_integer(unsigned(aes_message(3)(1)))) XOR aes_key(3)(2);
        result(1 * 8 - 1 DOWNTO 0 * 8)   := sBox(conv_integer(unsigned(aes_message(3)(2)))) XOR aes_key(3)(3);
        RETURN result;
    END;
END PACKAGE BODY;