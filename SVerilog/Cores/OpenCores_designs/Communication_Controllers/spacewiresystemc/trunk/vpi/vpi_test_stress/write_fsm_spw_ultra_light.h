static int write_tx_fsm_spw_ultra_light_calltf(char*user_data)
{
	vpiHandle LINKSTART    = vpi_handle_by_name("module_tb.LINK_START",NULL);
	vpiHandle LINKDISABLE  = vpi_handle_by_name("module_tb.LINK_DISABLE",NULL);
	vpiHandle AUTOSTART    = vpi_handle_by_name("module_tb.AUTO_START",NULL);

	link_enable_value.format    = vpiIntVal;
	auto_start_value.format     = vpiIntVal;
	link_disable_value.format   = vpiIntVal;

	link_enable_value.value.integer  = SC_TOP->verilog_linkenable();
	vpi_put_value(LINKSTART, &link_enable_value, NULL, vpiNoDelay);

	auto_start_value.value.integer   = SC_TOP->verilog_autostart();
	vpi_put_value(AUTOSTART, &auto_start_value, NULL, vpiNoDelay);

	link_disable_value.value.integer = SC_TOP->verilog_linkdisable();
	vpi_put_value(LINKDISABLE, &link_disable_value, NULL, vpiNoDelay);

	return 0;
}
