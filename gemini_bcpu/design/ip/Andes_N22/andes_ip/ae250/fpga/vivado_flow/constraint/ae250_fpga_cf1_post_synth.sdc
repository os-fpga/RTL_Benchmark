# ============================
if {[llength [get_pins -quiet u_spi*/u_spi_reg/spi_r_clk_a1_inferred_i_*/O]]} {
	# Vivado has difficulties at deciding the clock edge used so let's guide it.
	if {$spi_mode_0 == $spi_mode_1} {
		set_clock_sense -positive [get_pins u_spi*/u_spi_reg/spi_r_clk_a1_inferred_i_*/O]
	} else {
		set_clock_sense -negative [get_pins u_spi*/u_spi_reg/spi_r_clk_a1_inferred_i_*/O]
	}
}

# ====================
# Pin Assignments
# ====================

set_property	PACKAGE_PIN	C2	[get_ports X_hw_rstn]
set_property	PACKAGE_PIN	F5	[get_ports X_oschin]
set_property	PACKAGE_PIN	E12	[get_ports X_osclin]
set_property	PACKAGE_PIN	F3	[get_ports X_por_b]
set_property	PACKAGE_PIN	E5	[get_ports X_wakeup_in]

set_property	PACKAGE_PIN	N11	[get_ports X_tck]
set_property	PACKAGE_PIN	P10	[get_ports X_tms]
set_property	PACKAGE_PIN	N12	[get_ports X_tdo]
set_property	PACKAGE_PIN	P11	[get_ports X_tdi]
set_property	PACKAGE_PIN	E13	[get_ports X_trst]

set_property	PACKAGE_PIN	E2	[get_ports X_spi1_mosi]
set_property	PACKAGE_PIN	D3	[get_ports X_spi1_miso]
set_property	PACKAGE_PIN	D4	[get_ports X_spi1_clk]
set_property	PACKAGE_PIN	C3	[get_ports X_spi1_csn]
set_property	PACKAGE_PIN	A3	[get_ports X_spi1_holdn]
set_property	PACKAGE_PIN	E3	[get_ports X_spi1_wpn]

set_property	PACKAGE_PIN	G12	[get_ports X_spi2_holdn]
set_property	PACKAGE_PIN	F14	[get_ports X_spi2_wpn]

if {$spi3_support} {
set_property	PACKAGE_PIN	H12	[get_ports X_spi3_mosi]
set_property	PACKAGE_PIN	F13	[get_ports X_spi3_miso]
set_property	PACKAGE_PIN	H13	[get_ports X_spi3_clk]
set_property	PACKAGE_PIN	B7	[get_ports X_spi3_csn]
set_property	PACKAGE_PIN	D8	[get_ports X_spi3_holdn]
set_property	PACKAGE_PIN	D9	[get_ports X_spi3_wpn]
}

if {$spi4_support} {
set_property	PACKAGE_PIN	R15	[get_ports X_spi4_mosi]
set_property	PACKAGE_PIN	T14	[get_ports X_spi4_miso]
set_property	PACKAGE_PIN	M14	[get_ports X_spi4_clk]
set_property	PACKAGE_PIN	N16	[get_ports X_spi4_csn]
set_property	PACKAGE_PIN	K13	[get_ports X_spi4_holdn]
set_property	PACKAGE_PIN	L13	[get_ports X_spi4_wpn]
}

# Some GPIOs are not used so they are not assigned pads.
# set_property	PACKAGE_PIN	D11	[get_ports X_gpio[0]]
set_property	PACKAGE_PIN	P16	[get_ports X_gpio[1]]
set_property	PACKAGE_PIN	R16	[get_ports X_gpio[2]]
set_property	PACKAGE_PIN	P15	[get_ports X_gpio[3]]
set_property	PACKAGE_PIN	T15	[get_ports X_gpio[4]]
set_property	PACKAGE_PIN	P14	[get_ports X_gpio[5]]
set_property	PACKAGE_PIN	N14	[get_ports X_gpio[6]]
set_property	PACKAGE_PIN	P13	[get_ports X_gpio[7]]
set_property	PACKAGE_PIN	N13	[get_ports X_gpio[8]]
set_property	PACKAGE_PIN	M15	[get_ports X_gpio[9]]
set_property	PACKAGE_PIN	M16	[get_ports X_gpio[10]]
set_property	PACKAGE_PIN	L4	[get_ports X_gpio[11]]
set_property	PACKAGE_PIN	C8	[get_ports X_gpio[12]]
set_property	PACKAGE_PIN	B9	[get_ports X_gpio[13]]
set_property	PACKAGE_PIN	A13	[get_ports X_gpio[14]]
set_property	PACKAGE_PIN	B15	[get_ports X_gpio[15]]
set_property	PACKAGE_PIN	J16	[get_ports X_gpio[16]]
set_property	PACKAGE_PIN	G14	[get_ports X_gpio[17]]
set_property	PACKAGE_PIN	H14	[get_ports X_gpio[18]]
set_property	PACKAGE_PIN	J15	[get_ports X_gpio[19]]
set_property	PACKAGE_PIN	G16	[get_ports X_gpio[20]]
set_property	PACKAGE_PIN	G15	[get_ports X_gpio[21]]
set_property	PACKAGE_PIN	H16	[get_ports X_gpio[22]]
set_property	PACKAGE_PIN	F15	[get_ports X_gpio[23]]
set_property	PACKAGE_PIN	E16	[get_ports X_gpio[24]]
set_property	PACKAGE_PIN	D16	[get_ports X_gpio[25]]
set_property	PACKAGE_PIN	E15	[get_ports X_gpio[26]]
set_property	PACKAGE_PIN	D15	[get_ports X_gpio[27]]
set_property	PACKAGE_PIN	B11	[get_ports X_gpio[28]]
set_property	PACKAGE_PIN	B10	[get_ports X_gpio[29]]
set_property	PACKAGE_PIN	A9	[get_ports X_gpio[30]]
set_property	PACKAGE_PIN	A8	[get_ports X_gpio[31]]

# I/O standard
set_property	SLEW		FAST	[get_ports X_tms]
if {!$jtag_twowire} {
	set_property	SLEW		FAST	[get_ports X_tdo]
	set_property	DRIVE		16	[get_ports X_tdo]
}
set_property	IOSTANDARD	LVCMOS33	[get_ports X_hw_rstn]
set_property	IOSTANDARD	LVCMOS33	[get_ports X_osch*]
set_property	IOSTANDARD	LVCMOS33	[get_ports X_oscl*]
set_property	IOSTANDARD	LVCMOS33	[get_ports X_por_b]
set_property	IOSTANDARD	LVCMOS33	[get_ports X_wakeup_in]
set_property	IOSTANDARD	LVCMOS33	[get_ports X_tck]
set_property	IOSTANDARD	LVCMOS33	[get_ports X_tms]
set_property	IOSTANDARD	LVCMOS33	[get_ports X_trst]
set_property	IOSTANDARD	LVCMOS33	[get_ports X_tdi]
set_property	IOSTANDARD	LVCMOS33	[get_ports X_tdo]
set_property	IOSTANDARD	LVCMOS33	[get_ports X_spi*_*]
set_property	IOSTANDARD	LVCMOS33	[get_ports X_pwm*]
set_property	IOSTANDARD	LVCMOS33	[get_ports X_gpio*]
set_property	IOSTANDARD	LVCMOS33	[get_ports X_mpd_pwr_off]
set_property	IOSTANDARD	LVCMOS33	[get_ports X_rtc_wakeup]

# ====================
# Attributes
# ====================

set_property	PULLDOWN	true	[get_ports X_hw_rstn]
set_property	PULLDOWN	true	[get_ports X_por_b]
if {!$jtag_twowire} {
	set_property	PULLUP		true	[get_ports X_tdo]
}

# Ram style
#define_global_attribute			syn_ramstyle 		block_ram

# Automatically insert a BUFG primitive on high fanout nets
#define_global_attribute			syn_auto_insert_bufg	1

