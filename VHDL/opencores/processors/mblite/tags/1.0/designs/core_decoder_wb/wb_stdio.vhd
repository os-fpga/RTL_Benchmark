----------------------------------------------------------------------------------------------
--
--      Input file         : wb_stdio.vhd
--      Design name        : wb_stdio
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
USE mblite.std_Pkg.ALL;

USE std.textio.ALL;

ENTITY wb_stdio IS PORT
(
    wb_o : OUT wb_slv_out_type;
    wb_i : IN wb_slv_in_type
);
END wb_stdio;

ARCHITECTURE arch OF wb_stdio IS
    CONSTANT ack_assert_delay : TIME := 2 ns;
    CONSTANT ack_deassert_delay : TIME := 2 ns;
    SIGNAL ack : std_ulogic;
    SIGNAL chr_dat : std_ulogic_vector(31 DOWNTO 0);
    SIGNAL chr_cnt : natural := 0;
BEGIN
    wb_o.int_o <= '0';
    wb_o.dat_o <= chr_dat;
    -- Character device
    stdio: PROCESS(wb_i.clk_i)
        VARIABLE s    : line;
        VARIABLE byte : std_ulogic_vector(7 DOWNTO 0);
        VARIABLE char : character;
    BEGIN
        IF rising_edge(wb_i.clk_i) THEN
            IF (wb_i.stb_i AND wb_i.cyc_i) = '1' THEN
                IF wb_i.we_i = '1' AND ack = '0' THEN
                -- WRITE STDOUT
                    wb_o.ack_o <= '1' AFTER ack_assert_delay;
                    ack <= '1';
                    CASE wb_i.sel_i IS
                        WHEN "0001" => byte := wb_i.dat_i( 7 DOWNTO 0);
                        WHEN "0010" => byte := wb_i.dat_i(15 DOWNTO 8);
                        WHEN "0100" => byte := wb_i.dat_i(23 DOWNTO 16);
                        WHEN "1000" => byte := wb_i.dat_i(31 DOWNTO 24);
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
                ELSIF ack = '0' THEN
                -- READ stdout
                    ack <= '1';
                    wb_o.ack_o <= '1' AFTER ack_assert_delay;
                    IF chr_cnt = 0 THEN
                        chr_cnt <= 1;
                        chr_dat <= X"4C4C4C4C";
                    ELSIF chr_cnt = 1 THEN
                        chr_cnt <= 2;
                        chr_dat <= X"4D4D4D4D";
                    ELSIF chr_cnt = 2 THEN
                        chr_cnt <= 3;
                        chr_dat <= X"4E4E4E4E";
                    ELSIF chr_cnt = 3 THEN
                        chr_cnt <= 0;
                        chr_dat <= X"0A0A0A0A";
                    END IF;
                END IF;
            ELSE
                ack <= '0';
                wb_o.ack_o <= '0' AFTER ack_deassert_delay;
            END IF;
        END IF;
    END PROCESS;
END arch;