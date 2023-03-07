#! /bin/sh
export NDS_PLATFORM="ae250";

if [[ $NDS_PLATFORM = "" ]]; then
	puts "ERROR! Environment variable \"NDS_PLATFORM\" must be defined before synthesis."
	exit 1
fi

if [[ $NDS_PLATFORM = "ae250" ]]; then
# Set the list of IPs to run synthesis/equivalence checking
ip_list="atcapbbrg100 atcbmc200    \
         atcrtc100    atcgpio100   atcpit100  atcspi200 atcuart100   atcwdt200 "
else
ip_list="atcapbbrg100 atcbmc300    \
         atcrtc100    atcgpio100   atcpit100  atcspi200 atcuart100   atcwdt200 "
fi

if [[ -d "${NDS_HOME}/andes_ip/soc/nceplmt100" ]]; then
ip_list+=" nceplmt100"
fi
if [[ -d "${NDS_HOME}/andes_ip/soc/nceplic100" ]]; then
ip_list+=" nceplic100"
fi
if [[ -d "${NDS_HOME}/andes_ip/soc/ncejdtm200" ]]; then
ip_list+=" ncejdtm200"
fi
if [[ -d "${NDS_HOME}/andes_ip/soc/ncepldm200" ]]; then
ip_list+=" ncepldm200"
fi
if [[ -d "${NDS_HOME}/andes_ip/peripheral_ip/atciic100" ]]; then
ip_list+=" atciic100"
fi
if [[ -d "${NDS_HOME}/andes_ip/peripheral_ip/atcdmac100" ]]; then
ip_list+=" atcdmac100"
fi
if [[ -d "${NDS_HOME}/andes_ip/peripheral_ip/atcdmac300" ]]; then
ip_list+=" atcdmac300"
fi

ip_list+=" ${NDS_PLATFORM}_chip"

# Choice the best result of AndesCore synthesis iteration
itr="2"

export CORE_SYN_PATH="$NDS_HOME/andes_ip/n22_core/syn"
export SCRIPT_PATH="$NDS_HOME/andes_ip/peripheral_ip/design_flow/samples"

cd $SCRIPT_PATH

if [ ! -d "ip_database" ]; then
	mkdir ip_database
fi

if [ ! -e "ip_database/${NDS_PLATFORM}_cpu_subsystem.vg" ]; then
   cd $CORE_SYN_PATH
   
   if [ -d ./netlist ]; then
       rm -rf netlist
   fi
   if [  -d ./log ]; then
       rm -rf log
   fi
   if [  -d ./rpt ]; then
       rm -rf rpt
   fi
   
   $CORE_SYN_PATH/run_syn_genus
   
   cp $CORE_SYN_PATH/netlist/${NDS_PLATFORM}_cpu_subsystem$itr.vg  $SCRIPT_PATH/ip_database/${NDS_PLATFORM}_cpu_subsystem.vg
   cp $CORE_SYN_PATH/netlist/${NDS_PLATFORM}_cpu_subsystem$itr.sdc $SCRIPT_PATH/ip_database/${NDS_PLATFORM}_cpu_subsystem.sdc

   cd $SCRIPT_PATH
fi

for ip in $ip_list; do
	# Do synthesis only when the netlist not exists
	if [ ! -e "ip_database/$ip.vg" ]; then
		rm -rf $ip

		mkdir $ip
		cd $ip

		export DESIGN_NAME=$ip

		# Synthesis by RC
		genus -wait 1440 -f $SCRIPT_PATH/syn_genus.tcl -log genus.log

		# Equivalence checking by Conformal
		lec -LP -nogui -dofile $SCRIPT_PATH/formal_lec.do

		cd ..
	fi
done

