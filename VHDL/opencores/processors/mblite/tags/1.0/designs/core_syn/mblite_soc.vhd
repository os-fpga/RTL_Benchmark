----------------------------------------------------------------------------------------------
--
--      Input file         : config_Pkg.vhd
--      Design name        : config_Pkg
--      Author             : Tamar Kranenburg
--      Company            : Delft University of Technology
--                         : Faculty EEMCS, Department ME&CE
--                         : Systems and Circuits group
--
--      Description        : Instantiates instruction- and datamemories and the core
--
----------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

LIBRARY mblite;
USE mblite.config_Pkg.ALL;
USE mblite.core_Pkg.ALL;
USE mblite.std_Pkg.ALL;

ENTITY mblite_soc IS PORT
(
    sys_clk_i : IN std_ulogic;
    dbg_dmem_o_we_o : OUT std_ulogic;
    dbg_dmem_o_ena_o : OUT std_ulogic;
    sys_rst_i : IN std_ulogic;
    sys_ena_i : IN std_ulogic;
    sys_int_i : IN std_ulogic;
    dbg_dmem_o_adr_o : OUT std_ulogic_vector (31 DOWNTO 0);
    dbg_dmem_o_dat_o : OUT std_ulogic_vector (31 DOWNTO 0);
    dbg_dmem_o_sel_o : OUT std_ulogic_vector ( 3 DOWNTO 0)
);
END mblite_soc;

ARCHITECTURE arch OF mblite_soc IS

    COMPONENT sram_init IS GENERIC
    (
        WIDTH : integer;
        SIZE  : integer
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
    END COMPONENT;

    COMPONENT sram_4en_init IS GENERIC
    (
        WIDTH : integer;
        SIZE  : integer
    );
    PORT
    (
        dat_o : OUT std_ulogic_vector(WIDTH - 1 DOWNTO 0);
        dat_i : IN std_ulogic_vector(WIDTH - 1 DOWNTO 0);
        adr_i : IN std_ulogic_vector(SIZE - 1 DOWNTO 0);
        wre_i : IN std_ulogic_vector(3 DOWNTO 0);
        ena_i : IN std_ulogic;
        clk_i : IN std_ulogic
    );
    END COMPONENT;

    SIGNAL dmem_o : dmem_out_type;
    SIGNAL imem_o : imem_out_type;
    SIGNAL dmem_i : dmem_in_type;
    SIGNAL imem_i : imem_in_type;

    SIGNAL mem_enable : std_ulogic;
    SIGNAL sel_o : std_ulogic_vector(3 DOWNTO 0);

    CONSTANT std_out_adr : std_ulogic_vector(CFG_DMEM_SIZE - 1 DOWNTO 0) := X"FFFFFFC0";
    CONSTANT rom_size : integer := 13;
    CONSTANT ram_size : integer := 13;

BEGIN

    dbg_dmem_o_we_o  <= dmem_o.we_o;
    dbg_dmem_o_ena_o <= dmem_o.ena_o;
    dbg_dmem_o_adr_o <= dmem_o.adr_o;
    dbg_dmem_o_dat_o <= dmem_o.dat_o;
    dbg_dmem_o_sel_o <= dmem_o.sel_o;

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

    mem_enable <= NOT sys_rst_i AND dmem_o.ena_o AND NOT compare(dmem_o.adr_o, std_out_adr);
    sel_o <= dmem_o.sel_o WHEN dmem_o.we_o = '1' ELSE (OTHERS => '0');

    dmem : sram_4en GENERIC MAP
    (
        WIDTH => CFG_DMEM_WIDTH,
        SIZE => ram_size - 2
    )
    PORT MAP
    (
        dat_o => dmem_i.dat_i,
        dat_i => dmem_o.dat_o,
        adr_i => dmem_o.adr_o(ram_size - 1 DOWNTO 2),
        wre_i => sel_o,
        ena_i => mem_enable,
        clk_i => sys_clk_i
    );

    dmem_i.ena_i <= sys_ena_i;

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