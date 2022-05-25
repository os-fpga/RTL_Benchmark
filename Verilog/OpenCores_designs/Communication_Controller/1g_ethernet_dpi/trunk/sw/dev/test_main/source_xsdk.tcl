sdk set_workspace ./
#sdk set_user_repo_path ./src
sdk create_hw_project -name hw_0 -hwspec ./base_microblaze_design_wrapper.hdf 
sdk create_bsp_project -name bsp_0 -proc microblaze_0 -hwproject hw_0 -os standalone
sdk create_app_project -name app_0 -proc microblaze_0 -hwproject hw_0 -bsp bsp_0 -os standalone -app {Empty Application}
sdk import_sources -name app_0 -path ../src/platform
sdk import_sources -name app_0 -path ../src/xil_lib
sdk import_sources -name app_0 -path ../src/net
sdk import_sources -name app_0 -path ../src/main

if {[lindex $argv 0] != "-bsp"} {
 sdk build_project
}
