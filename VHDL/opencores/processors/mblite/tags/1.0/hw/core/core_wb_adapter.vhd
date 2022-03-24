----------------------------------------------------------------------------------------------
--
--      Input file         : core_wb_adapter.vhd
--      Design name        : core_wb_adapter.vhd
--      Author             : Tamar Kranenburg
--      Company            : Delft University of Technology
--                         : Faculty EEMCS, Department ME&CE
--                         : Systems and Circuits group
--
--      Description        : Wishbone adapter for the MB-Lite microprocessor. The data output
--                           is registered for multicycle transfers. This adapter implements
--                           the synchronous Wishbone Bus protocol, Rev3B.
--
----------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

LIBRARY mblite;
USE mblite.config_Pkg.ALL;
USE mblite.core_Pkg.ALL;
USE mblite.std_Pkg.ALL;

ENTITY core_wb_adapter IS PORT
(
    dmem_i : OUT dmem_in_type;
    wb_o   : OUT wb_mst_out_type;
    dmem_o : IN dmem_out_type;
    wb_i   : IN wb_mst_in_type
);
END core_wb_adapter;

ARCHITECTURE arch OF core_wb_adapter IS

    SIGNAL r_cyc_o : std_ulogic;
    SIGNAL rin_cyc_o : std_ulogic;
    SIGNAL r_data, rin_data : std_ulogic_vector(CFG_DMEM_WIDTH - 1 DOWNTO 0);
    SIGNAL s_wait : std_ulogic;

BEGIN

    -- Direct input-output connections
    wb_o.adr_o   <= dmem_o.adr_o;
    wb_o.sel_o   <= dmem_o.sel_o;
    wb_o.we_o    <= dmem_o.we_o;
    dmem_i.dat_i <= wb_i.dat_i;

    -- synchronous bus control connections
    wb_o.cyc_o <= r_cyc_o OR wb_i.ack_i;
    wb_o.stb_o <= r_cyc_o;

    -- asynchronous core enable connection
    dmem_i.ena_i <= '0' WHEN (dmem_o.ena_o = '1' AND rin_cyc_o = '1') OR s_wait = '1' ELSE '1';
    wb_o.dat_o   <= rin_data;

    -- logic for wishbone master
    wb_adapter_comb: PROCESS(wb_i, dmem_o, r_cyc_o, r_data)
    BEGIN

        IF wb_i.rst_i = '1' THEN
            -- reset bus
            rin_data <= r_data;
            rin_cyc_o <= '0';
            s_wait <= '0';
        ELSIF r_cyc_o = '1' AND wb_i.ack_i = '1' THEN
            -- terminate wishbone cycle
            rin_data <= r_data;
            rin_cyc_o <= '0';
            s_wait <= '0';
        ELSIF dmem_o.ena_o = '1' AND wb_i.ack_i = '1' THEN
            -- wishbone bus is occuppied
            rin_data <= r_data;
            rin_cyc_o <= '1';
            s_wait <= '1';
        ELSIF r_cyc_o = '0' AND dmem_o.ena_o = '1' AND wb_i.ack_i = '0' THEN
            -- start wishbone cycle
            rin_data <= dmem_o.dat_o;
            rin_cyc_o <= '1';
            s_wait <= '0';
        ELSE
            -- maintain wishbone cycle
            rin_data <= r_data;
            rin_cyc_o <= r_cyc_o;
            s_wait <= '0';
        END IF;

    END PROCESS;

    wb_adapter_seq: PROCESS(wb_i.clk_i)
    BEGIN
        IF rising_edge(wb_i.clk_i) THEN
            r_cyc_o <= rin_cyc_o;
            r_data <= rin_data;
        END IF;
    END PROCESS;

END arch;
