// test4*.v are testbench which used to verify

1)DOC: @SharePoint, Folder: IP Engineering > Documets > Projects > Castor > In-house-Custom-IP
  https://rapidsilicon2.sharepoint.com/:w:/s/IPEngineering/EZ1tF4IuKV1JiR7NIAyFyoMB0KY3oAkpelMCOUbSlpQX-g?e=zBlcij


2) Verilog sim: phase_gen_4_8, phase_sel_1_8
vcs -sverilog -v rs_t16n20p90cpdlvt_ana.v  phase_sel_1_8.v phase_gen_4_8.v test4_phase_gen_4_8_phase_4_8_sel_1_8.v

3) Liberty file(w/o timing info) added(lib -> db by lc_shell)

lc_shell> read_lib ./phase_gen_4_8_tc.lib
lc_shell> write_lib phase_gen_4_8_tc -f db -o ./phase_gen_4_8_tc.db

lc_shell> read_lib ./phase_sel_1_8_tc.lib
lc_shell> write_lib phase_sel_1_8_tc -f db -o ./phase_sel_1_8_tc.db


