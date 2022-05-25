# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set g_tx_dfifo_depth [ipgui::add_param $IPINST -name "g_tx_dfifo_depth" -parent ${Page_0}]
  set_property tooltip {FIFO must be larger than MTU (width is 8 bytes)} ${g_tx_dfifo_depth}
  set g_tx_tfifo_depth [ipgui::add_param $IPINST -name "g_tx_tfifo_depth" -parent ${Page_0}]
  set_property tooltip {One record (depth level) for one outstanding datagram} ${g_tx_tfifo_depth}
  set g_rx_dfifo_depth [ipgui::add_param $IPINST -name "g_rx_dfifo_depth" -parent ${Page_0}]
  set_property tooltip {FIFO must be larger than MTU (width is 8 bytes)} ${g_rx_dfifo_depth}
  set g_rx_tfifo_depth [ipgui::add_param $IPINST -name "g_rx_tfifo_depth" -parent ${Page_0}]
  set_property tooltip {Three records (depth levels) are needed for each received packet in RX FIFO} ${g_rx_tfifo_depth}
  ipgui::add_param $IPINST -name "g_rx_tfifo_type" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "g_rx_dfifo_type" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "g_tx_tfifo_type" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "g_tx_dfifo_type" -parent ${Page_0} -widget comboBox


}

proc update_PARAM_VALUE.g_rx_dfifo_depth { PARAM_VALUE.g_rx_dfifo_depth } {
	# Procedure called to update g_rx_dfifo_depth when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.g_rx_dfifo_depth { PARAM_VALUE.g_rx_dfifo_depth } {
	# Procedure called to validate g_rx_dfifo_depth
	return true
}

proc update_PARAM_VALUE.g_rx_dfifo_type { PARAM_VALUE.g_rx_dfifo_type } {
	# Procedure called to update g_rx_dfifo_type when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.g_rx_dfifo_type { PARAM_VALUE.g_rx_dfifo_type } {
	# Procedure called to validate g_rx_dfifo_type
	return true
}

proc update_PARAM_VALUE.g_rx_tfifo_depth { PARAM_VALUE.g_rx_tfifo_depth } {
	# Procedure called to update g_rx_tfifo_depth when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.g_rx_tfifo_depth { PARAM_VALUE.g_rx_tfifo_depth } {
	# Procedure called to validate g_rx_tfifo_depth
	return true
}

proc update_PARAM_VALUE.g_rx_tfifo_type { PARAM_VALUE.g_rx_tfifo_type } {
	# Procedure called to update g_rx_tfifo_type when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.g_rx_tfifo_type { PARAM_VALUE.g_rx_tfifo_type } {
	# Procedure called to validate g_rx_tfifo_type
	return true
}

proc update_PARAM_VALUE.g_tx_dfifo_depth { PARAM_VALUE.g_tx_dfifo_depth } {
	# Procedure called to update g_tx_dfifo_depth when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.g_tx_dfifo_depth { PARAM_VALUE.g_tx_dfifo_depth } {
	# Procedure called to validate g_tx_dfifo_depth
	return true
}

proc update_PARAM_VALUE.g_tx_dfifo_type { PARAM_VALUE.g_tx_dfifo_type } {
	# Procedure called to update g_tx_dfifo_type when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.g_tx_dfifo_type { PARAM_VALUE.g_tx_dfifo_type } {
	# Procedure called to validate g_tx_dfifo_type
	return true
}

proc update_PARAM_VALUE.g_tx_tfifo_depth { PARAM_VALUE.g_tx_tfifo_depth } {
	# Procedure called to update g_tx_tfifo_depth when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.g_tx_tfifo_depth { PARAM_VALUE.g_tx_tfifo_depth } {
	# Procedure called to validate g_tx_tfifo_depth
	return true
}

proc update_PARAM_VALUE.g_tx_tfifo_type { PARAM_VALUE.g_tx_tfifo_type } {
	# Procedure called to update g_tx_tfifo_type when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.g_tx_tfifo_type { PARAM_VALUE.g_tx_tfifo_type } {
	# Procedure called to validate g_tx_tfifo_type
	return true
}


proc update_MODELPARAM_VALUE.g_tx_dfifo_depth { MODELPARAM_VALUE.g_tx_dfifo_depth PARAM_VALUE.g_tx_dfifo_depth } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.g_tx_dfifo_depth}] ${MODELPARAM_VALUE.g_tx_dfifo_depth}
}

proc update_MODELPARAM_VALUE.g_tx_tfifo_depth { MODELPARAM_VALUE.g_tx_tfifo_depth PARAM_VALUE.g_tx_tfifo_depth } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.g_tx_tfifo_depth}] ${MODELPARAM_VALUE.g_tx_tfifo_depth}
}

proc update_MODELPARAM_VALUE.g_rx_dfifo_depth { MODELPARAM_VALUE.g_rx_dfifo_depth PARAM_VALUE.g_rx_dfifo_depth } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.g_rx_dfifo_depth}] ${MODELPARAM_VALUE.g_rx_dfifo_depth}
}

proc update_MODELPARAM_VALUE.g_rx_tfifo_depth { MODELPARAM_VALUE.g_rx_tfifo_depth PARAM_VALUE.g_rx_tfifo_depth } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.g_rx_tfifo_depth}] ${MODELPARAM_VALUE.g_rx_tfifo_depth}
}

proc update_MODELPARAM_VALUE.g_tx_dfifo_type { MODELPARAM_VALUE.g_tx_dfifo_type PARAM_VALUE.g_tx_dfifo_type } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.g_tx_dfifo_type}] ${MODELPARAM_VALUE.g_tx_dfifo_type}
}

proc update_MODELPARAM_VALUE.g_tx_tfifo_type { MODELPARAM_VALUE.g_tx_tfifo_type PARAM_VALUE.g_tx_tfifo_type } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.g_tx_tfifo_type}] ${MODELPARAM_VALUE.g_tx_tfifo_type}
}

proc update_MODELPARAM_VALUE.g_rx_dfifo_type { MODELPARAM_VALUE.g_rx_dfifo_type PARAM_VALUE.g_rx_dfifo_type } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.g_rx_dfifo_type}] ${MODELPARAM_VALUE.g_rx_dfifo_type}
}

proc update_MODELPARAM_VALUE.g_rx_tfifo_type { MODELPARAM_VALUE.g_rx_tfifo_type PARAM_VALUE.g_rx_tfifo_type } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.g_rx_tfifo_type}] ${MODELPARAM_VALUE.g_rx_tfifo_type}
}

