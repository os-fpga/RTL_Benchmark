----------------------------------------------------------------------------------------------
--
--      Input file         : mblite_stdio.vhd
--      Design name        : mblite_stdio
--      Author             : Tamar Kranenburg
--      Company            : Delft University of Technology
--                         : Faculty EEMCS, Department ME&CE
--                         : Systems and Circuits group
--
--      Description        : Simulates standard output using stdio package
--
----------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

LIBRARY mblite;
USE mblite.config_Pkg.ALL;
USE mblite.core_Pkg.ALL;

USE std.textio.ALL;

ENTITY mblite_stdio IS PORT
(
    dmem_i : OUT dmem_in_type;
    dmem_o : IN dmem_out_type;
    clk_i  : IN std_ulogic
);
END mblite_stdio;

ARCHITECTURE arch OF mblite_stdio IS
BEGIN
    -- Character device
    stdio: PROCESS(clk_i)
            VARIABLE s    : line;
            VARIABLE byte : std_ulogic_vector(7 DOWNTO 0);
            VARIABLE char : character;
        BEGIN
            dmem_i.dat_i <= (OTHERS => '0');
            dmem_i.ena_i <= '1';
            IF rising_edge(clk_i) THEN
                IF dmem_o.ena_o = '1' THEN
                    IF dmem_o.we_o = '1' THEN
                    -- WRITE STDOUT
                        CASE dmem_o.sel_o IS
                            WHEN "0001" => byte := dmem_o.dat_o( 7 DOWNTO  0);
                            WHEN "0010" => byte := dmem_o.dat_o(15 DOWNTO  8);
                            WHEN "0100" => byte := dmem_o.dat_o(23 DOWNTO 16);
                            WHEN "1000" => byte := dmem_o.dat_o(31 DOWNTO 24);
                            WHEN OTHERS => NULL;
                        END CASE;
                        char := character'val(my_conv_integer(byte));
                        IF byte = X"0D" THEN
                            -- Ignore character 13
                        ELSIF byte = X"0A" THEN
                            -- Writeline on character 10 (newline)
                            writeline(output, s);
                        ELSE
                            -- Write to buffer
                            write(s, char);
                        END IF;
                    END IF;
                END IF;
            END IF;
    END PROCESS;
END arch;