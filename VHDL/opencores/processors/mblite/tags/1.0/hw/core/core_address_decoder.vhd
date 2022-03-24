----------------------------------------------------------------------------------------------
--
--      Input file         : core_address_decoder.vhd
--      Design name        : core_address_decoder
--      Author             : Tamar Kranenburg
--      Company            : Delft University of Technology
--                         : Faculty EEMCS, Department ME&CE
--                         : Systems and Circuits group
--
--      Description        : Wishbone adapter for the MB-Lite microprocessor
--
----------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

LIBRARY mblite;
USE mblite.config_Pkg.ALL;
USE mblite.core_Pkg.ALL;
USE mblite.std_Pkg.ALL;

ENTITY core_address_decoder IS GENERIC
(
    G_NUM_SLAVES : positive := CFG_NUM_SLAVES;
    G_MEMORY_MAP : memory_map_type := CFG_MEMORY_MAP
);
PORT
(
    m_dmem_i : OUT dmem_in_type;
    s_dmem_o : OUT dmem_out_array_type(G_NUM_SLAVES - 1 DOWNTO 0);
    m_dmem_o : IN dmem_out_type;
    s_dmem_i : IN dmem_in_array_type(G_NUM_SLAVES - 1 DOWNTO 0);
    clk_i : std_ulogic
);
END core_address_decoder;

ARCHITECTURE arch OF core_address_decoder IS

    -- Decodes the address based on the memory map. Returns "1" if 0 or 1 slave is attached.
    FUNCTION decode(adr : std_ulogic_vector) RETURN std_ulogic_vector IS
        VARIABLE result : std_ulogic_vector(G_NUM_SLAVES - 1 DOWNTO 0);
    BEGIN
        result := (OTHERS => '1');
        IF G_NUM_SLAVES > 1 AND notx(adr) THEN
            FOR i IN G_NUM_SLAVES - 1 DOWNTO 0 LOOP
                IF (adr >= G_MEMORY_MAP(i) AND adr < G_MEMORY_MAP(i+1)) THEN
                    result(i) := '1';
                ELSE
                    result(i) := '0';
                END IF;
            END LOOP;
        END IF;
        RETURN result;
    END FUNCTION;

    FUNCTION demux(dmem_i : dmem_in_array_type; ce, r_ce : std_ulogic_vector) RETURN dmem_in_type IS
        VARIABLE dmem : dmem_in_type;
    BEGIN
        dmem := dmem_i(0);
        IF notx(ce) THEN
            FOR i IN G_NUM_SLAVES - 1 DOWNTO 0 LOOP
                IF ce(i) = '1' THEN
                    dmem.ena_i := dmem_i(i).ena_i;
                END IF;
                IF r_ce(i) = '1' THEN
                    dmem.dat_i := dmem_i(i).dat_i;
                END IF;
            END LOOP;
        END IF;
        RETURN dmem;
    END FUNCTION;

    SIGNAL r_ce, ce : std_ulogic_vector(G_NUM_SLAVES - 1 DOWNTO 0) := (OTHERS => '1');

BEGIN

    ce <= decode(m_dmem_o.adr_o);
    m_dmem_i <= demux(s_dmem_i, ce, r_ce);

    CON: FOR i IN G_NUM_SLAVES-1 DOWNTO 0 GENERATE
    BEGIN
        s_dmem_o(i).dat_o <= m_dmem_o.dat_o;
        s_dmem_o(i).adr_o <= m_dmem_o.adr_o;
        s_dmem_o(i).sel_o <= m_dmem_o.sel_o;
        s_dmem_o(i).we_o  <= m_dmem_o.we_o AND ce(i);
        s_dmem_o(i).ena_o <= m_dmem_o.ena_o AND ce(i);
    END GENERATE;

    PROCESS(clk_i)
    BEGIN
        IF rising_edge(clk_i) THEN
            r_ce <= ce;
        END IF;
    END PROCESS;
END arch;
