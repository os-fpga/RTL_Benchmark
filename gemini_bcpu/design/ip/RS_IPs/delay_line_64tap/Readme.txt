// test4*.v are testbench which used to verify

1)DOC: @SharePoint, Folder: IP Engineering > Documets > Projects > Castor > In-house-Custom-IP
   https://rapidsilicon2.sharepoint.com/:p:/s/IPEngineering/ESGyLnTuMlNGpEA-F1hmxtgBz25i1AWzyBqTGn5voCv0Qw?e=YpAt8a

2)verilog sim:  delay_line_64tap
#vcs delay_line_64tap.v test4_delay_line_64tap.v
vcs -sverilog delay_line_64tap.v test4_delay_line_64tap.v

3) Liberty file(w/o timing info) added(lib -> db by lc_shell)

lc_shell> read_lib ./delay_line_64tap_tc.lib
lc_shell> write_lib delay_line_64tap_tc -f db -o ./delay_line_64tap_tc.db

