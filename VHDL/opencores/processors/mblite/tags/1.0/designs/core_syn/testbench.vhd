----------------------------------------------------------------------------------------------
--
--      Input file         : config_Pkg.vhd
--      Design name        : config_Pkg
--      Author             : Tamar Kranenburg
--      Company            : Delft University of Technology
--                         : Faculty EEMCS, Department ME&CE
--                         : Systems and Circuits group
--
--      Description        : Testbench instantiates mblite_soc and stdio
--
----------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

LIBRARY std;
USE std.textio.ALL;

LIBRARY mblite;
USE mblite.config_Pkg.ALL;
USE mblite.core_Pkg.ALL;
USE mblite.std_Pkg.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE arch OF testbench IS

    COMPONENT mblite_soc IS PORT
    (
        sys_clk_i : in STD_LOGIC := 'X'; 
        dbg_dmem_o_we_o : out STD_LOGIC; 
        dbg_dmem_o_ena_o : out STD_LOGIC; 
        sys_rst_i : in STD_LOGIC := 'X'; 
        sys_ena_i : in STD_LOGIC := 'X'; 
        sys_int_i : in STD_LOGIC := 'X'; 
        dbg_dmem_o_adr_o : out STD_LOGIC_VECTOR(31 downto 0); 
        dbg_dmem_o_dat_o : out STD_LOGIC_VECTOR(31 downto 0); 
        dbg_dmem_o_sel_o : out STD_LOGIC_VECTOR( 3 downto 0) 
    );
    END COMPONENT;

    SIGNAL sys_clk_i : std_ulogic := '0';
    SIGNAL sys_int_i : std_ulogic := '0';
    SIGNAL sys_rst_i : std_ulogic := '0';
    SIGNAL sys_ena_i : std_ulogic := '1';

    SIGNAL dmem_o : dmem_out_type;

    CONSTANT std_out_adr : std_ulogic_vector(CFG_DMEM_SIZE - 1 DOWNTO 0) := X"FFFFFFC0";
BEGIN

    sys_clk_i <= NOT sys_clk_i AFTER 10000 ps;
    sys_rst_i <= '1' AFTER 0 ps, '0' AFTER  150000 ps;
    sys_int_i <= '1' AFTER 500000000 ps, '0' after 500040000 ps;

    soc : mblite_soc PORT MAP
    (
        sys_clk_i  => sys_clk_i,
        dbg_dmem_o_we_o => dmem_o.we_o,
        dbg_dmem_o_ena_o => dmem_o.ena_o,
        sys_rst_i => sys_rst_i,
        sys_ena_i => sys_ena_i,
        sys_int_i => sys_int_i,
        dbg_dmem_o_adr_o => dmem_o.adr_o,
        dbg_dmem_o_dat_o => dmem_o.dat_o,
        dbg_dmem_o_sel_o => dmem_o.sel_o
    );

    timeout: PROCESS(sys_clk_i)
    BEGIN
        IF NOW = 10 ms THEN
            REPORT "TIMEOUT" SEVERITY FAILURE;
        END IF;
    END PROCESS;

    -- Character device
    stdio: PROCESS(sys_clk_i)
        VARIABLE s    : line;
        VARIABLE byte : std_ulogic_vector(7 DOWNTO 0);
        VARIABLE char : character;
    BEGIN

        IF rising_edge(sys_clk_i) THEN
            IF (NOT sys_rst_i AND dmem_o.ena_o AND compare(dmem_o.adr_o, std_out_adr)) = '1' THEN
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
