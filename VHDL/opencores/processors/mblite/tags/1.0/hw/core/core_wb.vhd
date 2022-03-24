----------------------------------------------------------------------------------------------
--
--      Input file         : core_wb.vhd
--      Design name        : core_wb
--      Author             : Tamar Kranenburg
--      Company            : Delft University of Technology
--                         : Faculty EEMCS, Department ME&CE
--                         : Systems and Circuits group
--
--      Description        : Top level module of the MB-Lite microprocessor with connected
--                           wishbone data bus
--
----------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

LIBRARY mblite;
USE mblite.config_Pkg.ALL;
USE mblite.core_Pkg.ALL;
USE mblite.std_Pkg.ALL;

ENTITY core_wb IS GENERIC
(
    G_INTERRUPT  : boolean := CFG_INTERRUPT;
    G_USE_HW_MUL : boolean := CFG_USE_HW_MUL;
    G_USE_BARREL : boolean := CFG_USE_BARREL;
    G_DEBUG      : boolean := CFG_DEBUG
);
PORT
(
    imem_o : OUT imem_out_type;
    wb_o   : OUT wb_mst_out_type;
    imem_i : IN imem_in_type;
    wb_i   : IN wb_mst_in_type
);
END core_wb;

ARCHITECTURE arch OF core_wb IS
    SIGNAL dmem_i : dmem_in_type;
    SIGNAL dmem_o : dmem_out_type;
BEGIN

    wb_adapter0 : core_wb_adapter PORT MAP
    (
        dmem_i => dmem_i,
        wb_o   => wb_o,
        dmem_o => dmem_o,
        wb_i   => wb_i
    );

    core0 : core GENERIC MAP
    (
        G_INTERRUPT  => G_INTERRUPT,
        G_USE_HW_MUL => G_USE_HW_MUL,
        G_USE_BARREL => G_USE_BARREL,
        G_DEBUG      => G_DEBUG
    )
    PORT MAP
    (
        imem_o => imem_o,
        dmem_o => dmem_o,
        imem_i => imem_i,
        dmem_i => dmem_i,
        int_i  => wb_i.int_i,
        rst_i  => wb_i.rst_i,
        clk_i  => wb_i.clk_i
    );

END arch;
