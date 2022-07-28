# ------------------------------------
#
# ------------------------------------

global env

set env(LIB_BASE) qaz_libs

set env(ROOT_DIR) ../../../..
set env(PROJECT_DIR) ../../..

set env(LIB_BASE_DIR) $env(PROJECT_DIR)/$env(LIB_BASE)

# load sim procedures
do $env(LIB_BASE_DIR)/scripts/sim_procs.do
