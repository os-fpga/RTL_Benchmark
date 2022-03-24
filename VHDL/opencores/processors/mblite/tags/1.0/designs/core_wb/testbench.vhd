----------------------------------------------------------------------------------------------
--
--      Input file         : config_Pkg.vhd
--      Design name        : config_Pkg
--      Author             : Tamar Kranenburg
--      Company            : Delft University of Technology
--                         : Faculty EEMCS, Department ME&CE
--                         : Systems and Circuits group
--
--      Description        : Testbench instantiates core, data memory, instruction memory
--                           and a character device.
--
----------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

LIBRARY mblite;
USE mblite.config_Pkg.ALL;
USE mblite.core_Pkg.ALL;
USE mblite.std_Pkg.ALL;

use std.textio.all;

ENTITY testbench IS
END testbench;

ARCHITECTURE arch OF testbench IS

    SIGNAL imem_o : imem_out_type;
    SIGNAL imem_i : imem_in_type;

    SIGNAL wb_o : wb_mst_out_type;
    SIGNAL wb_i : wb_mst_in_type;

    SIGNAL sys_clk_i : std_ulogic := '0';
    SIGNAL sys_int_i : std_ulogic;
    SIGNAL sys_rst_i : std_ulogic;

    CONSTANT std_out_adr : std_ulogic_vector(CFG_DMEM_SIZE - 1 DOWNTO 0) := X"FFFFFFC0";
    SIGNAL std_out_ack : std_ulogic;

    SIGNAL stdo_ena : std_ulogic;

    SIGNAL dmem_ena : std_ulogic;
    SIGNAL dmem_dat : std_ulogic_vector(CFG_DMEM_WIDTH - 1 DOWNTO 0);
    SIGNAL dmem_sel : std_ulogic_vector(3 DOWNTO 0);

    CONSTANT rom_size : integer := 16;
    CONSTANT ram_size : integer := 16;

BEGIN

    sys_clk_i <= NOT sys_clk_i AFTER 10000 ps;
    sys_rst_i <= '1' AFTER 0 ps, '0' AFTER  150000 ps;
    sys_int_i <= '1' AFTER 500000000 ps, '0' after 500040000 ps;

    timeout: PROCESS(sys_clk_i)
    BEGIN
        IF NOW = 10 ms THEN
            report "TIMEOUT" SEVERITY FAILURE;
        END IF;

        -- BREAK ON EXIT (0xB8000000)
        IF compare(imem_i.dat_i, "10111000000000000000000000000000") = '1' THEN
            -- Make sure the simulator finishes when an error is encountered.
            -- For modelsim: see menu Simulate -> Runtime options -> Assertions
            REPORT "FINISHED" SEVERITY FAILURE;
        END IF;
    END PROCESS;

    -- Character device
    wb_stdio_slave: PROCESS(sys_clk_i)
        VARIABLE s    : line;
        VARIABLE byte : std_ulogic_vector(7 DOWNTO 0);
        VARIABLE char : character;
    BEGIN
        IF rising_edge(sys_clk_i) THEN
            IF (wb_o.stb_o AND wb_o.cyc_o AND compare(wb_o.adr_o, std_out_adr)) = '1' THEN
                IF wb_o.we_o = '1' AND std_out_ack = '0' THEN
                -- WRITE STDOUT
                    std_out_ack <= '1';
                    CASE wb_o.sel_o IS
                        WHEN "0001" => byte := wb_o.dat_o( 7 DOWNTO  0);
                        WHEN "0010" => byte := wb_o.dat_o(15 DOWNTO  8);
                        WHEN "0100" => byte := wb_o.dat_o(23 DOWNTO 16);
                        WHEN "1000" => byte := wb_o.dat_o(31 DOWNTO 24);
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
                ELSIF std_out_ack = '0' THEN
                    std_out_ack <= '1';
                END IF;
            ELSE
                std_out_ack <= '0';
            END IF;
        END IF;

    END PROCESS;

    wb_i.clk_i <= sys_clk_i;
    wb_i.rst_i <= sys_rst_i;
    wb_i.int_i <= sys_int_i;

    dmem_ena <= wb_o.stb_o AND wb_o.cyc_o AND NOT compare(wb_o.adr_o, std_out_adr);

    PROCESS(wb_o.stb_o, wb_o.cyc_o, std_out_ack, wb_o.adr_o)
    BEGIN
        IF NOT compare(wb_o.adr_o, std_out_adr) = '1' THEN
            wb_i.ack_i <= wb_o.stb_o AND wb_o.cyc_o AFTER 2 ns;
        ELSE
            wb_i.ack_i <= std_out_ack AFTER 22 ns;
        END IF;
    END PROCESS;

    imem : sram GENERIC MAP
    (
        WIDTH => CFG_IMEM_WIDTH,
        SIZE => rom_size - 2
    )
    PORT MAP
    (
        dat_o => imem_i.dat_i,
        dat_i => "00000000000000000000000000000000",
        adr_i => imem_o.adr_o(rom_size - 1 DOWNTO 2),
        wre_i => '0',
        ena_i => imem_o.ena_o,
        clk_i => sys_clk_i
    );

    dmem_sel <= wb_o.sel_o WHEN wb_o.we_o = '1' ELSE (OTHERS => '0');
    wb_i.dat_i <= X"61616161" WHEN std_out_ack = '1' ELSE dmem_dat;

    dmem : sram_4en GENERIC MAP
    (
        WIDTH => CFG_DMEM_WIDTH,
        SIZE => ram_size - 2
    )
    PORT MAP
    (
        dat_o => dmem_dat,
        dat_i => wb_o.dat_o,
        adr_i => wb_o.adr_o(ram_size - 1 DOWNTO 2),
        wre_i => dmem_sel,
        ena_i => dmem_ena,
        clk_i => sys_clk_i
    );

    core_wb0 : core_wb PORT MAP
    (
        imem_o => imem_o,
        wb_o   => wb_o,
        imem_i => imem_i,
        wb_i   => wb_i
    );

END arch;
