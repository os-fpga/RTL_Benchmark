set NDS_HOME $env(NDS_HOME)
# ----------------------------------
# Configuration files
# ----------------------------------
add_include_path "./"
add_include_path "$NDS_HOME/andes_ip/${platform}/define" 
add_include_path "$NDS_HOME/andes_ip/${platform}/top/hdl/include" 
add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcgpio100/hdl/include" 
add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcpit100/hdl/include"
add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcwdt200/hdl/include"
add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcrtc100/hdl/include"
if {[file isdirectory "$NDS_HOME/andes_ip/peripheral_ip/atciic100"]} {
add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atciic100/hdl/include"
}
add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcspi200/hdl/include"
add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcahb2spi200/hdl/include"
add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcuart100/hdl/include"
add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcapbbrg100/hdl/include"
add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcapbdec100/hdl/include"
add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atceilmbrg100/hdl/include"
add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atfmac100/hdl/include"
add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atfsdc010/hdl/include"


add_include_path "$NDS_HOME/andes_ip/soc/memc_wrapper/hdl/include"

if {[file isdirectory "$NDS_HOME/andes_ip/soc/ncepldm200"]} {
add_include_path "$NDS_HOME/andes_ip/soc/ncepldm200/hdl/"
}

if {$platform == "ae250"} {
	add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcbmc200/hdl/include"
	if {[file isdirectory "$NDS_HOME/andes_ip/peripheral_ip/atcdmac100"]} {
	add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcdmac100/hdl/include"
	}
	add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcexlmbrg100/hdl/include"
} else {	# ae350
	add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcahb2axi200/hdl/include"
	add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcbmc300/hdl/include"
	add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcbusdec200/hdl/include"
	add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcbusdec200_1/hdl/include"
	add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcbusdec350/hdl/include"
	add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcdmac300/hdl/include"
	add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcmstmux100/hdl/include"
	add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcmstmux300/hdl/include"
	add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atflcdc100/hdl/include"
	add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atfsmc020/hdl/include"
	add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atfssp020/hdl/include"
	if {$NDS_BIU_PATH_X2 == "yes"} {
		add_include_path "$NDS_HOME/andes_ip/peripheral_ip/atcmstmux300_1/hdl/include"
	}
}
