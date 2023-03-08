// test4*.v are testbench which used to verify

1)DOC: @SharePoint, Folder: IP Engineering > Documets > Projects > Castor > In-house-Custom-IP
   https://rapidsilicon2.sharepoint.com/:p:/s/IPEngineering/EePE-EUywJhKkU5S6aRGKbABDn7h1_S0rSsh7Gw6tCkwog?e=gyvjLw

   
2) RC_OSC_50MHZ.v
vcs -sverilog  RC_OSC_50MHZ.v test4_RC_OSC_50MHZ.v
./simv

3) Liberty file(w/o timing info) added(lib -> db by lc_shell)

lc_shell> read_lib ./RC_OSC_50MHZ_tc.lib
lc_shell> write_lib RC_OSC_50MHZ_tc -f db -o ./RC_OSC_50MHZ_tc.db


