----------------------------------------------------------------------------------------------
--
--      Input file         : config_Pkg.vhd
--      Design name        : config_Pkg
--      Author             : Tamar Kranenburg
--      Company            : Delft University of Technology
--                         : Faculty EEMCS, Department ME&CE
--                         : Systems and Circuits group
--
--      Description        : Testbench instantiates core, data memory and instruction memory,
--                           together with a character device.
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

    SIGNAL dmem_o : dmem_out_type;
    SIGNAL imem_o : imem_out_type;
    SIGNAL dmem_i : dmem_in_type;
    SIGNAL imem_i : imem_in_type;

    SIGNAL sys_clk_i : std_ulogic := '0';
    SIGNAL sys_int_i : std_ulogic := '0';
    SIGNAL sys_rst_i : std_ulogic := '0';
    SIGNAL sys_ena_i : std_ulogic := '1';

    CONSTANT std_out_adr : std_ulogic_vector(CFG_DMEM_SIZE - 1 DOWNTO 0) := X"FFFFFFC0";
    CONSTANT rom_size : integer := 16;
    CONSTANT ram_size : integer := 16;

    SIGNAL mem_enable : std_ulogic;
    SIGNAL chr_enable : std_ulogic;
    SIGNAL chr_read : std_ulogic;
    SIGNAL sel_o : std_ulogic_vector(3 DOWNTO 0);
    SIGNAL mem_dat : std_ulogic_vector(31 DOWNTO 0);
    SIGNAL chr_dat : std_ulogic_vector(31 DOWNTO 0);
    SIGNAL chr_cnt : integer := 0;

BEGIN

    sys_clk_i <= NOT sys_clk_i AFTER 10000 ps;
    sys_rst_i <= '1' AFTER 0 ps, '0' AFTER  150000 ps;
    sys_int_i <= '1' AFTER 500000000 ps, '0' after 500040000 ps;


    dmem_i.ena_i <= sys_ena_i;
    sel_o <= dmem_o.sel_o WHEN dmem_o.we_o = '1' ELSE (OTHERS => '0');

    mem_enable <= NOT sys_rst_i AND dmem_o.ena_o AND NOT compare(dmem_o.adr_o, std_out_adr);
    chr_enable <= NOT sys_rst_i AND dmem_o.ena_o AND compare(dmem_o.adr_o, std_out_adr);

    dmem_i.dat_i <= chr_dat WHEN chr_read = '1' ELSE mem_dat;

    -- Character device
    stdio: PROCESS(sys_clk_i)
        VARIABLE s    : line;
        VARIABLE byte : std_ulogic_vector(7 DOWNTO 0);
        VARIABLE char : character;
    BEGIN
        IF rising_edge(sys_clk_i) THEN
            IF chr_enable = '1' THEN
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
                    chr_read <= '0';
                ELSE
                    chr_read <= '1';
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
                chr_read <= '0';
            END IF;
        END IF;

    END PROCESS;

    -- Warning: an infinite loop like while(1) {} triggers this timeout too!
    -- disable this feature when a premature finish occur.
    timeout: PROCESS(sys_clk_i)
    BEGIN
        IF NOW = 10 ms THEN
            REPORT "TIMEOUT" SEVERITY FAILURE;
        END IF;
        -- BREAK ON EXIT (0xB8000000)
        IF compare(imem_i.dat_i, "10111000000000000000000000000000") = '1' THEN
            -- Make sure the simulator finishes when an error is encountered.
            -- For modelsim: see menu Simulate -> Runtime options -> Assertions
            REPORT "FINISHED" SEVERITY FAILURE;
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

    dmem : sram_4en GENERIC MAP
    (
        WIDTH => CFG_DMEM_WIDTH,
        SIZE => ram_size - 2
    )
    PORT MAP
    (
        dat_o => mem_dat,
        dat_i => dmem_o.dat_o,
        adr_i => dmem_o.adr_o(ram_size - 1 DOWNTO 2),
        wre_i => sel_o,
        ena_i => mem_enable,
        clk_i => sys_clk_i
    );

    core0 : core PORT MAP
    (
        imem_o => imem_o,
        dmem_o => dmem_o,
        imem_i => imem_i,
        dmem_i => dmem_i,
        int_i  => sys_int_i,
        rst_i  => sys_rst_i,
        clk_i  => sys_clk_i
    );

END arch;

----------------------------------------------------------------------------------------------
-- USE CONFIGURATIONS INSTEAD OF GENERICS TO IMPLEMENT - FOR EXAMPLE - DIFFERENT MEMORIES.
-- CONFIGURATIONS CAN HIERARCHICALLY INVOKE OTHER CONFIGURATIONS TO REDUCE THE SIZE OF THE
-- CONFIGURATION DECLARATION
----------------------------------------------------------------------------------------------
CONFIGURATION tb_conf_example OF testbench IS
    FOR arch
        FOR ALL: sram_4en
            USE ENTITY mblite.sram_4en(arch);
        END FOR;
    END FOR;
END tb_conf_example;
