----------------------------------------------------------------------------------------------
--
--      Input file         : sram.vhd
--      Design name        : sram
--      Author             : Tamar Kranenburg
--      Company            : Delft University of Technology
--                         : Faculty EEMCS, Department ME&CE
--                         : Systems and Circuits group
--
--      Description        : Single Port Synchronous Random Access Memory
--
----------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

LIBRARY mblite;
USE mblite.std_Pkg.ALL;

ENTITY sram IS GENERIC
(
    WIDTH : positive := 32;
    SIZE  : positive := 16
);
PORT
(
    dat_o : OUT std_ulogic_vector(WIDTH - 1 DOWNTO 0);
    dat_i : IN std_ulogic_vector(WIDTH - 1 DOWNTO 0);
    adr_i : IN std_ulogic_vector(SIZE - 1 DOWNTO 0);
    wre_i : IN std_ulogic;
    ena_i : IN std_ulogic;
    clk_i : IN std_ulogic
);
END sram;

ARCHITECTURE arch OF sram IS
    TYPE ram_type IS array(2 ** SIZE - 1 DOWNTO 0) OF std_ulogic_vector(WIDTH - 1 DOWNTO 0);
    SIGNAL ram :  ram_type;
BEGIN
    PROCESS(clk_i)
    BEGIN
        IF rising_edge(clk_i) THEN
            IF ena_i = '1' THEN
                IF wre_i = '1' THEN
                   ram(my_conv_integer(adr_i)) <= dat_i;
                END IF;
                dat_o <= ram(my_conv_integer(adr_i));
            END IF;
        END IF;
    END PROCESS;
END arch;

