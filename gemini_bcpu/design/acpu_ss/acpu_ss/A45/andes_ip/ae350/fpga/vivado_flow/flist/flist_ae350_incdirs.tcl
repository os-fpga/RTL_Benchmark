set NDS_HOME $env(NDS_HOME)
# ----------------------------------
# Configuration files
# ----------------------------------
add_include_path "./"
set incdir [list\
	"$NDS_HOME/andes_ip/${platform}/define" \
	"$NDS_HOME/andes_ip/${platform}/top/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcgpio100/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcpit100/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcwdt200/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcrtc100/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atciic100/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcspi200/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcahb2spi200/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcuart100/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcapbbrg100/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcapbdec100/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atceilmbrg100/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atfmac100/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atfsdc010/hdl/include" \
	"$NDS_HOME/andes_ip/soc/ncepldm200/hdl/" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcahb2axi200/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcbmc300/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcdmac300/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcbusdec200/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcbusdec200_rom/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcbusdec301/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcbusdec302/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atcmstmux100/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atflcdc100/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atfsmc020/hdl/include" \
	"$NDS_HOME/andes_ip/peripheral_ip/atfssp020/hdl/include" \
]

foreach ip $incdir {
	if {[file isdirectory "$ip"]} {
		add_include_path "$ip"
	}
}
